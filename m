Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A9F546C26D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 19:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240450AbhLGSNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 13:13:41 -0500
Received: from mga18.intel.com ([134.134.136.126]:52983 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231351AbhLGSNk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 13:13:40 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="224513425"
X-IronPort-AV: E=Sophos;i="5.87,295,1631602800"; 
   d="scan'208";a="224513425"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 09:38:08 -0800
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="751385217"
Received: from charriso-mobl2.amr.corp.intel.com (HELO pbossart-mobl3.intel.com) ([10.212.98.250])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 09:38:07 -0800
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
To:     alsa-devel@alsa-project.org
Cc:     tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org,
        Sameer Pujar <spujar@nvidia.com>,
        Gyeongtaek Lee <gt82.lee@samsung.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        linux-kernel@vger.kernel.org,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 0/6] ASoC : soc-pcm: fix trigger race conditions with shared BE
Date:   Tue,  7 Dec 2021 11:37:39 -0600
Message-Id: <20211207173745.15850-1-pierre-louis.bossart@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've been adding a 'deep buffer' PCM device to several SOF topologies
in order to reduce power consumption. The typical use-case would be
music playback over a headset: this additional PCM device provides
more buffering and longer latencies, leaving the rest of the system
sleep for longer periods. Notifications and 'regular' low-latency
audio playback would still use the 'normal' PCM device and be mixed
with the 'deep buffer' before rendering on the headphone endpoint. The
tentative direction would be to expose this alternate device to
PulseAudio/PipeWire/CRAS via the UCM SectionModifier definitions.

That seemed a straightforward topology change until our automated
validation stress tests started reporting issues on SoundWire
platforms, when e.g. two START triggers might be send and conversely
the STOP trigger is never sent. The SoundWire stream state management
flagged inconsistent states when the two 'normal' and 'deep buffer'
devices are used concurrently with rapid play/stop/pause monkey
testing.

Looking at the soc-pcm.c code, it seems that the BE state
management needs a lot of love.

a) there is no consistent protection for the BE state. In some parts
of the code, the state updates are protected by a spinlock but in the
trigger they are not. When we open/play/close the two PCM devices in
stress tests, we end-up testing a state that is being modified. That
can't be good.

b) there is a conceptual deadlock: on stop we check the FE states to
see if a shared BE can be stopped, but since we trigger the BE first
the FE states have not been modified yet, so the TRIGGER_STOP is never
sent.

This patchset suggests the removal of the dedicated 'dpcm_lock' and
follows the design suggested by Takashi Iwai.  By default the
protection relies on the 'pcm_mutex', except for the FE and BE
triggers where the mutex cannot be used.  In this case, the FE PCM
lock is used instead. In the cases where a BE is added/removed, the
pcm_mutex and FE PCM lock are both taken.  In addition, the BE PCM
lock is used to serialize access to a shared BE.

With these patches I am able to run our entire validation suite
without any issues with this new 'deep buffer' topology, and no
regressions on existing solutions [1]. The tests were reproduced by
Bard Liao for SoundWire devices.

One might ask 'how come we didn't see this earlier'? The answer is
probably that the .trigger callbacks in most implementations seems to
perform DAPM operations, and sending the triggers multiple times is
not an issue. In the case of SoundWire, we do use the .trigger
callback to reconfigure the bus using the 'bank switch' mechanism. It
could be acceptable to tolerate a trigger multiple times, but the
deadlock on stop cannot be fixed at the SoundWire level alone.

Opens:

1) The issues reported by Nvidia on the RFCv3 may or may not be
present. We'd need test results to make sure the locking update does
not introduce a regression on Tegra.

2) There are other reports of kernel oopses [2] that seem related to
the lack of protection. I'd be good to confirm if this patchset solve
these problems as well.

[1] https://github.com/thesofproject/linux/pull/3146
[2] https://lore.kernel.org/alsa-devel/002f01d7b4f5$c030f4a0$4092dde0$@samsung.com/

changes since RFCv3:
Used two patches from Takashi. We now use the pcm_mutex, the FE stream
lock when adding and deleting a BE, and the BE stream lock to handle
concurrency between streams using the same BE.
Added a patch to use GFP_ATOMIC for the DPCM structure.
Fixed PAUSE_RELEASE transition (GitHub comment from Kai Vehmanen)

changes since RFCv2:
Removal of dpcm_lock to use FE PCM locks (credits to Takashi Iwai for
the suggestion). The FE PCM lock is now used before each use of
for_each_dpcm_be() - with the exception of the trigger where the lock
is already taken. This change is also applied in drivers which make
use of this loop (compress, SH, FSL).
Addition of BE PCM lock to deal with mutual exclusion between triggers
for the same BE.
Alignment of the BE atomicity on the FE on connections, this is
required to avoid sleeping in atomic context.
Additional cleanups (indentation, static functions)

changes since RFC v1:
Removed unused function
Removed exported symbols only used in soc-pcm.c, used static instead
Use a mutex instead of a spinlock
Protect all for_each_dpcm_be() loops
Fix bugs introduced in the refcount

Pierre-Louis Bossart (4):
  ASoC: soc-pcm: use GFP_ATOMIC for dpcm structure
  ASoC: soc-pcm: align BE 'atomicity' with that of the FE
  ASoC: soc-pcm: test refcount before triggering
  ASoC: soc-pcm: fix BE handling of PAUSE_RELEASE

Takashi Iwai (2):
  ASoC: soc-pcm: Fix and cleanup DPCM locking
  ASoC: soc-pcm: serialize BE triggers

 include/sound/soc-dpcm.h |   2 +
 include/sound/soc.h      |   2 -
 sound/soc/soc-core.c     |   1 -
 sound/soc/soc-pcm.c      | 351 +++++++++++++++++++++++++++------------
 4 files changed, 246 insertions(+), 110 deletions(-)

-- 
2.25.1

