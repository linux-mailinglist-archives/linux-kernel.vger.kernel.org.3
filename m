Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373484F536C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 06:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2360015AbiDFDXc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 23:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1847969AbiDFCUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 22:20:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E2C1D1916
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 16:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Bqjzo3dRF9g7zUJGDSV93bexe38finF36uQEXO1Q6Eo=; b=fRCXkrEwv9VlqF3i5n9xEpcHOQ
        dD8CsjQZQI67uzl8Uwku21HAQ42AP38UPrbcrebkHkjbMYeaCCYtw+mbtyliiMBCcly08eIZQMtub
        vHHKUQOUdY5DQIIU80MGvObCOJ3Ib17YBDuiTuOuq+Vbd2Y23xdMQfWjaVnihN3onI6Zz9HtuEG9q
        y7udsfo4rC+7RTknUG98ZKECcgOR8AJXqS3OYBuKIUjHzrjt4WtxMmIesbIP58wUXhQX5JmC1W4aN
        NaRIOkkN5ZeQ1+LufEbHO1p5DMxt5OvHIQSZ6JY8lpmhHcOfqIidOTdW+GNKKU87fWCa04IQ304lC
        f6We2LSg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nbsnY-0031Cn-28; Tue, 05 Apr 2022 23:41:20 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        kernel test robot <lkp@intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Subject: [PATCH v3] sound/oss/dmasound: fix build when drivers are mixed =y/=m
Date:   Tue,  5 Apr 2022 16:41:18 -0700
Message-Id: <20220405234118.24830-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_DMASOUND_ATARI=m and CONFIG_DMASOUND_Q40=y (or vice versa),
dmasound_core.o can be built without dmasound_deinit() being defined,
causing a build error:

ERROR: modpost: "dmasound_deinit" [sound/oss/dmasound/dmasound_atari.ko] undefined!

Modify dmasound_core.c and dmasound.h so that dmasound_deinit() is
always available.

The mixed modes (=y/=m) also mean that several variables and structs
have to be declared in all cases.

Suggested-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Link: lore.kernel.org/r/202204032138.EFT9qGEd-lkp@intel.com
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org
---
v3: Remove use of #ifdef MODULE/#endif since the conditional data & code
    need to be there for some of the cases. (Geert)
v2: make dmasound_deinit() defined and available in all configs (Arnd)

@Geert: any way to test this?

#Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

 sound/oss/dmasound/dmasound.h      |    6 ------
 sound/oss/dmasound/dmasound_core.c |   24 +-----------------------
 2 files changed, 1 insertion(+), 29 deletions(-)

--- a/sound/oss/dmasound/dmasound_core.c
+++ b/sound/oss/dmasound/dmasound_core.c
@@ -206,12 +206,10 @@ module_param(writeBufSize, int, 0);
 
 MODULE_LICENSE("GPL");
 
-#ifdef MODULE
 static int sq_unit = -1;
 static int mixer_unit = -1;
 static int state_unit = -1;
 static int irq_installed;
-#endif /* MODULE */
 
 /* control over who can modify resources shared between play/record */
 static fmode_t shared_resource_owner;
@@ -391,9 +389,6 @@ static const struct file_operations mixe
 
 static void mixer_init(void)
 {
-#ifndef MODULE
-	int mixer_unit;
-#endif
 	mixer_unit = register_sound_mixer(&mixer_fops, -1);
 	if (mixer_unit < 0)
 		return;
@@ -1171,9 +1166,6 @@ static const struct file_operations sq_f
 static int sq_init(void)
 {
 	const struct file_operations *fops = &sq_fops;
-#ifndef MODULE
-	int sq_unit;
-#endif
 
 	sq_unit = register_sound_dsp(fops, -1);
 	if (sq_unit < 0) {
@@ -1366,9 +1358,6 @@ static const struct file_operations stat
 
 static int state_init(void)
 {
-#ifndef MODULE
-	int state_unit;
-#endif
 	state_unit = register_sound_special(&state_fops, SND_DEV_STATUS);
 	if (state_unit < 0)
 		return state_unit ;
@@ -1386,10 +1375,9 @@ static int state_init(void)
 int dmasound_init(void)
 {
 	int res ;
-#ifdef MODULE
+
 	if (irq_installed)
 		return -EBUSY;
-#endif
 
 	/* Set up sound queue, /dev/audio and /dev/dsp. */
 
@@ -1408,9 +1396,7 @@ int dmasound_init(void)
 		printk(KERN_ERR "DMA sound driver: Interrupt initialization failed\n");
 		return -ENODEV;
 	}
-#ifdef MODULE
 	irq_installed = 1;
-#endif
 
 	printk(KERN_INFO "%s DMA sound driver rev %03d installed\n",
 		dmasound.mach.name, (DMASOUND_CORE_REVISION<<4) +
@@ -1424,8 +1410,6 @@ int dmasound_init(void)
 	return 0;
 }
 
-#ifdef MODULE
-
 void dmasound_deinit(void)
 {
 	if (irq_installed) {
@@ -1444,8 +1428,6 @@ void dmasound_deinit(void)
 		unregister_sound_dsp(sq_unit);
 }
 
-#else /* !MODULE */
-
 static int dmasound_setup(char *str)
 {
 	int ints[6], size;
@@ -1489,8 +1471,6 @@ static int dmasound_setup(char *str)
 
 __setup("dmasound=", dmasound_setup);
 
-#endif /* !MODULE */
-
     /*
      *  Conversion tables
      */
@@ -1577,9 +1557,7 @@ char dmasound_alaw2dma8[] = {
 
 EXPORT_SYMBOL(dmasound);
 EXPORT_SYMBOL(dmasound_init);
-#ifdef MODULE
 EXPORT_SYMBOL(dmasound_deinit);
-#endif
 EXPORT_SYMBOL(dmasound_write_sq);
 EXPORT_SYMBOL(dmasound_catchRadius);
 #ifdef HAS_8BIT_TABLES
--- a/sound/oss/dmasound/dmasound.h
+++ b/sound/oss/dmasound/dmasound.h
@@ -88,11 +88,7 @@ static inline int ioctl_return(int __use
      */
 
 extern int dmasound_init(void);
-#ifdef MODULE
 extern void dmasound_deinit(void);
-#else
-#define dmasound_deinit()	do { } while (0)
-#endif
 
 /* description of the set-up applies to either hard or soft settings */
 
@@ -114,9 +110,7 @@ typedef struct {
     void *(*dma_alloc)(unsigned int, gfp_t);
     void (*dma_free)(void *, unsigned int);
     int (*irqinit)(void);
-#ifdef MODULE
     void (*irqcleanup)(void);
-#endif
     void (*init)(void);
     void (*silence)(void);
     int (*setFormat)(int);
