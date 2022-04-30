Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 046A7515DC7
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 15:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242134AbiD3NpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 09:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234800AbiD3NpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 09:45:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04EBB3A18A;
        Sat, 30 Apr 2022 06:41:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D18E6091F;
        Sat, 30 Apr 2022 13:41:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05609C385AA;
        Sat, 30 Apr 2022 13:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651326114;
        bh=z1ShzoCSkbQb+bOpuaiBtOfCObZ5xV/5jCkA52fVM7U=;
        h=From:To:Cc:Subject:Date:From;
        b=ZSoiPmfwpPthXwwLa+SgKEi3DzH2Y1E+GN8PH8yc8mRVbjar4q05Gt45Z5GnuOC9r
         DTQR2PrUvyCR5hjBBVFXEkXT/24eZiI/31Qzl2M+9U+jdclLfZJ4cJOSqO/0zXB3fi
         /JQQCltMWzh4hCzbuZ49YlcTU/AynOFfg0PGeINz91OtWxxI3MnYaomVQO8VumZTZI
         JOj8/uyj+4pj+2nnTnlWrLoKjlTWhjC+PcukaXUpFLgVzNGNysenUz6lb4icrnpUMp
         loucqMnkOtEc6nfxhIT7qckU12c5SF85dy/WmK2mbaQCzhDuwYIkXc9z9/FXiTII/Q
         4GiqNWH0i7hZw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1nknM6-001nsd-HX; Sat, 30 Apr 2022 14:41:50 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        mauro.chehab@linux.intel.com, Greg KH <gregkh@linuxfoundation.org>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Kai Vehmanen <kai.vehmanen@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>
Subject: [PATCH v3 0/2] Let userspace know when snd-hda-intel needs i915
Date:   Sat, 30 Apr 2022 14:41:46 +0100
Message-Id: <cover.1651326000.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, kernel/module annotates module dependencies when
request_symbol is used, but it doesn't cover more complex inter-driver
dependencies that are subsystem and/or driver-specific.

In the case of hdmi sound, depending on the CPU/GPU, sometimes the
snd_hda_driver can talk directly with the hardware, but sometimes, it
uses the i915 driver. When the snd_hda_driver uses i915, it should
first be unbind/rmmod, as otherwise trying to unbind/rmmod the i915
driver cause driver issues, as as reported by CI tools with different
GPU models:

	https://intel-gfx-ci.01.org/tree/drm-tip/IGT_6415/fi-tgl-1115g4/igt@core_hotunplug@unbind-rebind.html
	https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_11495/bat-adlm-1/igt@i915_module_load@reload.html

In the past, just a few CPUs were doing such bindings, but this issue now
applies to all "modern" Intel CPUs  that have onboard graphics, as well as
to the  newer discrete GPUs.

With the discrete GPU case, the HDA controller is physically separate and
requires i915 to power on the hardware for all hardware  access. In this
case, the issue is hit basicly 100% of the time.

With on-board graphics, i915 driver is needed only when the display
codec is accessed. If i915 is unbind during runtime suspend, while
snd-hda-intel is still bound, nothing bad happens, but unbinding i915
on other situations may also cause issues.

So, add support at kernel/modules to allow snd-hda drivers to properly
annotate when a dependency on a DRM driver dependencies exists,
and add a call to such new function at the snd-hda driver when it
successfully binds into the DRM driver.

This would allow userspace tools to check and properly remove the
audio driver before trying to remove or unbind the GPU driver.

It should be noticed that this series conveys the hidden module
dependencies. Other changes are needed in order to allow
removing or unbinding the i915 driver while keeping the snd-hda-intel
driver loaded/bound. With that regards, there are some discussions on
how to improve this at alsa-devel a while  back:

https://mailman.alsa-project.org/pipermail/alsa-devel/2021-September/190099.html

So, future improvements on both in i915 and the audio drivers could be made.
E.g. with  discrete GPUs, it's the only codec of the card, so it seems feasible
to detach the ALSA card if i915 is bound (using infra made for VGA
switcheroo), but,  until these improvements are done and land in
upstream, audio drivers needs to be unbound if i915 driver goes unbind.

Yet, even if such fixes got merged, this series is still needed, as it makes
such dependencies more explicit and easier to debug.

PS.: This series was generated against next-20220428.

---

v3: minor fixes:
 - fixed a checkpatch warning;
 - use a single line for the new function prototype.

v2: 
 - the dependencies are now handled directly at try_module_get().


Mauro Carvalho Chehab (2):
  module: update dependencies at try_module_get()
  ALSA: hda - identify when audio is provided by a video driver

 include/linux/module.h     |  4 +++-
 kernel/module/main.c       | 33 +++++++++++++++++++++++++++++++--
 sound/hda/hdac_component.c |  2 +-
 3 files changed, 35 insertions(+), 4 deletions(-)

-- 
2.35.1


