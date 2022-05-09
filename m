Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1598652025B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 18:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239044AbiEIQ1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 12:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239019AbiEIQ1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 12:27:41 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F86B2689D7;
        Mon,  9 May 2022 09:23:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D045DCE1A16;
        Mon,  9 May 2022 16:23:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03D9AC385B1;
        Mon,  9 May 2022 16:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652113423;
        bh=mdAPNlLnOrv84PSoSJSxXEtEdCuj0qy2zCvHlvJ5Njo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mi2544dS7YM1A/FSFwFeIwBDZblvgLsGSEpCwm+trqSAnt8wy5S5Qxto9Wur2y4tO
         9cpkOftKBmZiVgPD7AYJPlCh5bucJIreuaqYsH3amUCE4IdKRG42FKL04zCcjwSABg
         F/ii55iELg27DEEsp+767f5ls63aiwURAJEdXjUDQkwnfs/cq02uiDDSuY8Gu0wllF
         EBzhbG4bWuU3xbaBtlYBCpHP6pWPpDqzbDXEBoFUOuZMg2SLH5sMo34M8upZFsdEOv
         NBny6sycMAKpOlw1elPGs+06j0/ruIgmMXZbHNPxazEsK7iM72JdgdhjyPu/Wyvvco
         88LhlYqi4D5jg==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1no6Ae-006xVb-Lo; Mon, 09 May 2022 18:23:40 +0200
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "David Airlie" <airlied@linux.ie>,
        "Greg KH" <gregkh@linuxfoundation.org>,
        "Jaroslav Kysela" <perex@perex.cz>,
        "Kai Vehmanen" <kai.vehmanen@intel.com>,
        "Lucas De Marchi" <lucas.demarchi@intel.com>,
        "Pierre-Louis Bossart" <pierre-louis.bossart@intel.com>,
        "Takashi Iwai" <tiwai@suse.com>, alsa-devel@alsa-project.org,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        mauro.chehab@linux.intel.com, Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v6 4/4] ALSA: hda - identify when audio is provided by a video driver
Date:   Mon,  9 May 2022 18:23:39 +0200
Message-Id: <f53f8a9d04b39a6843f19fe3069d1be7a9713aae.1652113087.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <cover.1652113087.git.mchehab@kernel.org>
References: <cover.1652113087.git.mchehab@kernel.org>
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

On some devices, the hda driver needs to hook into a video driver,
in order to be able to properly access the audio hardware and/or
the power management function.

That's the case of several snd_hda_intel devices that depends on
i915 driver.

Ensure that a proper reference between the snd-hda driver needing
such binding is shown at /proc/modules, in order to allow userspace
to know about such binding.

Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH v6 0/4] at: https://lore.kernel.org/all/cover.1652113087.git.mchehab@kernel.org/

 sound/hda/hdac_component.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/hda/hdac_component.c b/sound/hda/hdac_component.c
index bb37e7e0bd79..7789873ddf47 100644
--- a/sound/hda/hdac_component.c
+++ b/sound/hda/hdac_component.c
@@ -199,7 +199,7 @@ static int hdac_component_master_bind(struct device *dev)
 	}
 
 	/* pin the module to avoid dynamic unbinding, but only if given */
-	if (!try_module_get(acomp->ops->owner)) {
+	if (!try_module_get_owner(acomp->ops->owner, dev->driver->owner)) {
 		ret = -ENODEV;
 		goto out_unbind;
 	}
-- 
2.35.3

