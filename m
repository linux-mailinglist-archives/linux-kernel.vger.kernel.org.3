Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 140B952024A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 18:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239036AbiEIQ1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 12:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239009AbiEIQ1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 12:27:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409022689D5;
        Mon,  9 May 2022 09:23:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C5F7461453;
        Mon,  9 May 2022 16:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E049C385B6;
        Mon,  9 May 2022 16:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652113423;
        bh=XjCnODs5eDe2B6X2CKoYdGCfUAZLm0o230Hy5WWYtoI=;
        h=From:To:Cc:Subject:Date:From;
        b=dDCQULQx6Ix7kDV0M/p/zOdD8C5+qlFZUsCYdG06NUh0Uy31yjFYb2UG7GWVu1V+R
         wexdYfEEQl4hJym0y7yoVcFFkcW0SZC9EJF/u1IqwoxN97dFar7D+XA6TlvumAECd1
         1s9alS5L1GNT+/vr5mUiCL/I0X1Pk+pVaIKRafifXSmmDf9a6d4ZIpMUw4X4ITi1gR
         0kRsP6TIiWHPVXrv5GCD29mz90FmHHP/dcl82vLLjxIoJWo3Ut2350lvSxjevDyABQ
         ONDIEdCUIYQtUZAzpx5mM8JMIgLC/i+aOmUTw/Z0JD9YrvCa1MvGzKJif8nb8bF8+4
         oFBbvRfQFq6fw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1no6Ae-006xVL-E7; Mon, 09 May 2022 18:23:40 +0200
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
        David Airlie <airlied@linux.ie>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org
Subject: [PATCH v6 0/4] Let userspace know when snd-hda-intel needs i915
Date:   Mon,  9 May 2022 18:23:35 +0200
Message-Id: <cover.1652113087.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, kernel/module annotates module dependencies when
request_symbol is used, but it doesn't cover more complex inter-driver
dependencies that are subsystem and/or driver-specific.

That's because module_try_get() and symbol_get() doesn't try to
setup the module owner.

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

So, add support at kernel/modules to properly set the holders when
try_module_get() and symbol_get() are used.

This allow allow audio drivers to properly annotate when a dependency 
on a DRM driver dependencies exists, and add a call to such new 
function at the snd-hda driver when it successfully binds into the DRM 
driver.

With that, userspace tools can now check and properly remove the
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

PS.: This series was generated against next-20220506.

---

v6:
- dropped an unused function prototype for __symbol_get_gpl();
- addressed several issues that were noticed while testing the series on
  an slow atom machine;
- also add holders when symbol_get() is used.

v5:
- while v4 works fine, it ends calling try_module_format() recursively, which
  is not what it it was supposed to do. So, change the logic to avoid such
  recursion, by adding a static __try_module_format() and renaming the
  new version that takes two arguments as try_module_format_owner().

v4:
 - fix a compilation warning reported by Intel's Kernel robot when
   !CONFIG_MODULE_UNLOAD or !CONFIG_MODULE.

v3: minor fixes:
 - fixed a checkpatch warning;
 - use a single line for the new function prototype.

v2:
 - the dependencies are now handled directly at try_module_get().
Mauro Carvalho Chehab (4):
  module: drop prototype for non-existing __symbol_get_gpl()
  module: update dependencies at try_module_get()
  module: set holders when symbol_get() is used
  ALSA: hda - identify when audio is provided by a video driver

 drivers/mtd/chips/gen_probe.c           |  4 +-
 include/linux/module.h                  | 13 +++--
 kernel/module/main.c                    | 76 ++++++++++++++++++++-----
 samples/hw_breakpoint/data_breakpoint.c |  2 +-
 sound/hda/hdac_component.c              |  2 +-
 5 files changed, 72 insertions(+), 25 deletions(-)

-- 
2.35.3


