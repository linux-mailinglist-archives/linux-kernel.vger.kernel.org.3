Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A846D5707BB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 17:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbiGKP4Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 11:56:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiGKP4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 11:56:22 -0400
X-Greylist: delayed 338 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Jul 2022 08:56:21 PDT
Received: from gauss.telenet-ops.be (gauss.telenet-ops.be [IPv6:2a02:1800:120:4::f00:11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855D42B270
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 08:56:21 -0700 (PDT)
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by gauss.telenet-ops.be (Postfix) with ESMTPS id 4LhSyl2lCnz4x3QD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 17:50:39 +0200 (CEST)
Received: from ramsan.of.borg ([84.195.186.194])
        by xavier.telenet-ops.be with bizsmtp
        id trqf270054C55Sk01rqf58; Mon, 11 Jul 2022 17:50:39 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oAvgE-0036x2-H5; Mon, 11 Jul 2022 17:50:38 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oAvgC-006shk-Vj; Mon, 11 Jul 2022 17:50:36 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Helge Deller <deller@gmx.de>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-fbdev@vger.kernel.org,
        linux-doc@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 06/10] video: fbdev: atari: Remove unneeded casts to void *
Date:   Mon, 11 Jul 2022 17:50:30 +0200
Message-Id: <d1da8bf1b21759bcda39c572bc102c5a6380b1a8.1657554353.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1657554353.git.geert@linux-m68k.org>
References: <cover.1657554353.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arbitrary pointers can be passed to functions accepting "void *" without
casting.

Remove the casts, as they make it impossible to validate types.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/fbdev/atafb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/atafb.c b/drivers/video/fbdev/atafb.c
index f20535ea3e549384..fbc333d5615df5d5 100644
--- a/drivers/video/fbdev/atafb.c
+++ b/drivers/video/fbdev/atafb.c
@@ -2599,14 +2599,14 @@ atafb_ioctl(struct fb_info *info, unsigned int cmd, unsigned long arg)
 	switch (cmd) {
 #ifdef FBCMD_GET_CURRENTPAR
 	case FBCMD_GET_CURRENTPAR:
-		if (copy_to_user((void *)arg, (void *)&current_par,
+		if (copy_to_user((void *)arg, &current_par,
 				 sizeof(struct atafb_par)))
 			return -EFAULT;
 		return 0;
 #endif
 #ifdef FBCMD_SET_CURRENTPAR
 	case FBCMD_SET_CURRENTPAR:
-		if (copy_from_user((void *)&current_par, (void *)arg,
+		if (copy_from_user(&current_par, (void *)arg,
 				   sizeof(struct atafb_par)))
 			return -EFAULT;
 		ata_set_par(&current_par);
-- 
2.25.1

