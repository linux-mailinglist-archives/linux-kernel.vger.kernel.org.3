Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE91F479816
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 02:58:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbhLRB6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 20:58:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhLRB6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 20:58:15 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063E5C061574;
        Fri, 17 Dec 2021 17:58:15 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id m24so3303670pls.10;
        Fri, 17 Dec 2021 17:58:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pFfNVSOltuNWp1wMtI3hg/qMObF7DQ/1Aun+IfAtVr8=;
        b=Ku2yX3hNsH1XjBVY62B25nOIqkkNt+zmO+8g5n+lPfF75Uze5Tam4vlb1rWefeX0tQ
         jGr/W02uNdbacnH0FuFZjctXsxa26d9e/0MzE9yJCNwSY88Q2g/300ORMOJQRuhGfxPf
         ea84uiFj+ShaVJIP0LMO66MPHnSKDDfmQEZUxiH4lRUiyfAO9bN8WkrfmmTLWxmxV+ie
         YK6C/Pn1QjfjCuChIUxzOs4MCsXRGzsrqjuul/dztx6ugdKnSbhCUYitwWTMKgeUd16V
         jybCQzyUJ5NLbWMO324vcBmue+7HLvpi80Us5fk6TovQ2wQg+GyHkqIupQZbjs4N/quS
         w/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=pFfNVSOltuNWp1wMtI3hg/qMObF7DQ/1Aun+IfAtVr8=;
        b=0m427m2SFF37JWNjbj4g4kCYgDfPKdrEeRnvtKHwNA4ur79pdUz0NoMvyoJYGbrhtD
         dUEr3mp9ubT54J2iwzeWmCW/xGwFb3WRanA6a2eIravFGfRP6hXe9mufNB0xEo3wRMbV
         TR1oru/oL9dQUCZbxFMShli+BbFbop0MnO4Bcb/+F/aTptYUsIHnmGyb2wPqkgwfx2Zr
         0YIlW6hJeh4H80ooFvQDCNcMDah/+mEMK/stwM0b7P+trNBVQo52/LJnLovYijEGJsS7
         WFSZt+mHhGqNcjMtgQ6uyPpcIKu7rzczIBMhqKh0bEcEIhD7zZxApfR1mhq71WOWlr/+
         KxRw==
X-Gm-Message-State: AOAM530r5BO+ZuhnSxahaTJwGUFUsziwfzU3KJKW7E6W/u+2Th7Cxsw0
        GC26SlVUQMRTZX9AodYBe14=
X-Google-Smtp-Source: ABdhPJzB8JazEJhP+/mJKteVGLQBI8KNkSAxq2OHSWjU+1dJJCp9aBhu/oGvEjtTneUzIRrqMt7hLg==
X-Received: by 2002:a17:902:bc41:b0:148:aef6:b5ad with SMTP id t1-20020a170902bc4100b00148aef6b5admr6073087plz.27.1639792694595;
        Fri, 17 Dec 2021 17:58:14 -0800 (PST)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id n14sm404657pgd.80.2021.12.17.17.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Dec 2021 17:58:14 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     mchehab@kernel.org
Cc:     davidcomponentone@gmail.com, arnd@arndb.de,
        hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] media: saa7134: use swap() to make code cleaner
Date:   Sat, 18 Dec 2021 09:58:02 +0800
Message-Id: <021c7dbfec45346672d1773bd322c00b62906e54.1639791971.git.yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
opencoding it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 drivers/media/pci/saa7134/saa7134-video.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/media/pci/saa7134/saa7134-video.c b/drivers/media/pci/saa7134/saa7134-video.c
index 374c8e1087de..6f4132058c35 100644
--- a/drivers/media/pci/saa7134/saa7134-video.c
+++ b/drivers/media/pci/saa7134/saa7134-video.c
@@ -823,7 +823,7 @@ static int buffer_activate(struct saa7134_dev *dev,
 {
 	struct saa7134_dmaqueue *dmaq = buf->vb2.vb2_buf.vb2_queue->drv_priv;
 	unsigned long base,control,bpl;
-	unsigned long bpl_uv,lines_uv,base2,base3,tmp; /* planar */
+	unsigned long bpl_uv, lines_uv, base2, base3; /* planar */
 
 	video_dbg("buffer_activate buf=%p\n", buf);
 	buf->top_seen = 0;
@@ -869,9 +869,7 @@ static int buffer_activate(struct saa7134_dev *dev,
 		base2    = base + bpl * dev->height;
 		base3    = base2 + bpl_uv * lines_uv;
 		if (dev->fmt->uvswap) {
-			tmp = base2;
-			base2 = base3;
-			base3 = tmp;
+			swap(base2, base3);
 		}
 		video_dbg("uv: bpl=%ld lines=%ld base2/3=%ld/%ld\n",
 			bpl_uv,lines_uv,base2,base3);
-- 
2.30.2

