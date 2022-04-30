Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D2B51601D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 21:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244485AbiD3Tgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 15:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238997AbiD3Tgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 15:36:45 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3B8949F86
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 12:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=39GrQWmkZ+YjAD7XxF6O6MKjllRIm9u5hW3pNItTxOA=; b=G53zhjoxT+zmssO/muK3gwagRT
        vCyYcvUkkwwYNPE6LkrDNpqlwrv8aBTl12r6bA+YymCqawfWmO61/lYk2xVRNsrK8da8VynnDKpm1
        cKTJ1Cai//W/daBoEO/YspjstwTJ//y48alWvk492qtualg/T7ZP1IzyTBwcgRorLm7ev/JOpFMDm
        G8mFr/NP11n6X15prYk7OOL2xWJEqNHJWDQQdFktRPz989INgDeSCkfYFS1oNff5rqjve6BV8xcrj
        bV1VNbx5rJAjfkZ+ERALjFi9sYCdsG+UjLLpS0Z5/2jC9dUoJvbpaUBFus5CgiLIOJgSXAcXnYacC
        loiLeI4g==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nksqG-00F0XW-GA; Sat, 30 Apr 2022 19:33:20 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Takashi Iwai <tiwai@suse.de>, Jaroslav Kysela <perex@perex.cz>,
        alsa-devel@alsa-project.org
Subject: [PATCH] ALSA: hda - fix unused Realtek function when PM is not enabled
Date:   Sat, 30 Apr 2022 12:33:18 -0700
Message-Id: <20220430193318.29024-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_PM is not enabled, alc_shutup() is not needed,
so move it inside the #ifdef CONFIG_PM guard.
Also drop some contiguous #endif / #ifdef CONFIG_PM for simplicity.

Fixes this build warning:
sound/pci/hda/patch_realtek.c:886:20: warning: unused function 'alc_shutup'

Fixes: 08c189f2c552 ("ALSA: hda - Use generic parser codes for Realtek driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
---
 sound/pci/hda/patch_realtek.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -937,6 +937,9 @@ static int alc_init(struct hda_codec *co
 	return 0;
 }
 
+#define alc_free	snd_hda_gen_free
+
+#ifdef CONFIG_PM
 static inline void alc_shutup(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
@@ -950,9 +953,6 @@ static inline void alc_shutup(struct hda
 		alc_shutup_pins(codec);
 }
 
-#define alc_free	snd_hda_gen_free
-
-#ifdef CONFIG_PM
 static void alc_power_eapd(struct hda_codec *codec)
 {
 	alc_auto_setup_eapd(codec, false);
@@ -966,9 +966,7 @@ static int alc_suspend(struct hda_codec
 		spec->power_hook(codec);
 	return 0;
 }
-#endif
 
-#ifdef CONFIG_PM
 static int alc_resume(struct hda_codec *codec)
 {
 	struct alc_spec *spec = codec->spec;
