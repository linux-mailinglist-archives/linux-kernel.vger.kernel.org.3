Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63B234686BC
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 18:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385246AbhLDRtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 12:49:03 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:45946 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbhLDRtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 12:49:01 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD6BB60ECE
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 17:45:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CC5C341C0;
        Sat,  4 Dec 2021 17:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638639935;
        bh=SKTOiEnCRSF1blw0CzZe+GV1RIbwCYCpvBVjjm5D05I=;
        h=From:To:Cc:Subject:Date:From;
        b=m0MsmUYrwuVUwKl6MZElcwxrLizu/pvR3AR8zk2PHOHYKVJxiWKhKJHu6p271XZaf
         gNYpo6z4q2n5vFU7JbZ24L6EhTEl+SGo78rEKizqJvj2z18XyZ43sVMlajy28z8T3M
         aLWaL07Bbrekg9klx6pKn5wvOuPj43pJMAYGReJnnQdTxfCsGn7vKFwtmnUT8BbypD
         2j2WABgRJUFkfYYGbU7iwInvTSEffsHgCqNDyZ8sY17MTG4ZiH2jPzqYvNGXslHJa2
         zU/JEuwUxtdf6ixCzLw6wlaxAioKp10v0jUHTbzxIXUy1I5uJeoOqs6jaFHjhMzS1i
         s71zdUjirwvug==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bard Liao <bard.liao@intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        sound-open-firmware@alsa-project.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: SOF: Intel: move CODEC_PROBE_RETRIES definition
Date:   Sat,  4 Dec 2021 18:44:47 +0100
Message-Id: <20211204174529.1122697-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The macro is defined in an #ifdef but used outside:

sound/soc/sof/intel/hda-codec.c: In function 'hda_codec_probe':
sound/soc/sof/intel/hda-codec.c:132:42: error: 'CODEC_PROBE_RETRIES' undeclared (first use in this function)
  132 |         } while (resp == -1 && retry++ < CODEC_PROBE_RETRIES);
      |                                          ^~~~~~~~~~~~~~~~~~~

Move it to a place where it can be seen unconditionally.

Fixes: 046aede2f847 ("ASoC: SOF: Intel: Retry codec probing if it fails")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/sof/intel/hda-codec.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index 13cd96e6724a..4324178b3ca6 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -20,9 +20,10 @@
 #include "../../codecs/hdac_hda.h"
 #endif /* CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC */
 
+#define CODEC_PROBE_RETRIES 3
+
 #if IS_ENABLED(CONFIG_SND_SOC_SOF_HDA_AUDIO_CODEC)
 #define IDISP_VID_INTEL	0x80860000
-#define CODEC_PROBE_RETRIES 3
 
 /* load the legacy HDA codec driver */
 static int request_codec_module(struct hda_codec *codec)
-- 
2.29.2

