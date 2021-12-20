Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 829BF47A57B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 08:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbhLTHrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 02:47:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbhLTHrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 02:47:03 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 399FFC061574;
        Sun, 19 Dec 2021 23:47:03 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id v16so8523290pjn.1;
        Sun, 19 Dec 2021 23:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xbFfVTLwYNEeaZM0iP6zcXXCgb7TcMhev/HZm7YFsT8=;
        b=mYgWCGcfbeAMpFFkoTy2lIAgDHyyokHWjXgciTv7HX9cRTH+WS2PnOqJdO6rBN281f
         CP7e+5+6k0SfcomPen1r8NHf0NUd1ytKS6rbNbfpJS9JF8c4uK5ImfLFVmMNNl5UeKa7
         lPSHJqHKSU2AQml/uCb10kdkOA1GbhlDFiLLv3UAQPDGk0DsUn1q83zlo57SF9fr9MlU
         uVeYCOXB99OAkTUaYn81RDrxF6Inxcsjfn5KVVDkTOU/VwxWj91N481M/2fStu3sPvDE
         6Q0M9/t5RTPQVX4f67bJHyNNbnfveEpSNS/a9iK9w00fVtHZF96gEs0vY9MlGhlOmNl2
         7O6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xbFfVTLwYNEeaZM0iP6zcXXCgb7TcMhev/HZm7YFsT8=;
        b=FuziMtn9TqTBt5XKeKUZOFqtEcu7rkSRDM2k2E2ZsXYJ3Y1WNLbDnVGMLM56SqfEW+
         3H6tD4B2Gc0+am4p2iQNY+WXfa0LHCBKXgtmTsq2T7NbpA5VCg4Vef2w1SrX4FNbOedQ
         vv6NfRNUv9XVSXTL/wBO9Eq81YA+ao4H/1JZ2lKByNqAN9RGQGBnOQ6kOm4y7Go8pCAo
         xGJqU4773jiRqikK2eauVBOAI2laq0jRkTidR/nbdw3R2Cglvdy0Zcsc9/WWg/vA5GCJ
         SaGLQAOx1lTr+o00DokPChk7e5dKORSI3dD1/Hq0bilxdwyOusZRuJDUj0n4Y/lWAWZ1
         XPCw==
X-Gm-Message-State: AOAM533e6rvE4FM/A60Ks/VYA3kaU0hDRy6Jwsr5nSnPB+EkDX7kNHqw
        8I5+stxTYYVxqeskFmd4pTzuPI2BMpA=
X-Google-Smtp-Source: ABdhPJz7HgaBSytkb16nvnJkSo4L3EUqePAHaK29iy68WXThwHIzzAbVu9wTh6JwKfnOLs2AOcDqNg==
X-Received: by 2002:a17:90b:f82:: with SMTP id ft2mr296151pjb.203.1639986421520;
        Sun, 19 Dec 2021 23:47:01 -0800 (PST)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id n16sm16488637pja.46.2021.12.19.23.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Dec 2021 23:47:00 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     mchehab@kernel.org
Cc:     davidcomponentone@gmail.com, arnd@arndb.de,
        hverkuil-cisco@xs4all.nl, laurent.pinchart@ideasonboard.com,
        yang.guang5@zte.com.cn, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH v2] media: saa7134: use swap() to make code cleaner
Date:   Mon, 20 Dec 2021 15:46:46 +0800
Message-Id: <6c4f34f21648a981f195e8e7a57edab4f3865676.1639961762.git.yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

Use the macro 'swap()' defined in 'include/linux/minmax.h' to avoid
opencoding it.

---
Change from V1->V2:
- Delete the curly {} braces.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 drivers/media/pci/saa7134/saa7134-video.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/media/pci/saa7134/saa7134-video.c b/drivers/media/pci/saa7134/saa7134-video.c
index 374c8e1087de..7bc4c7709f4d 100644
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
@@ -868,11 +868,8 @@ static int buffer_activate(struct saa7134_dev *dev,
 		lines_uv = dev->height >> dev->fmt->vshift;
 		base2    = base + bpl * dev->height;
 		base3    = base2 + bpl_uv * lines_uv;
-		if (dev->fmt->uvswap) {
-			tmp = base2;
-			base2 = base3;
-			base3 = tmp;
-		}
+		if (dev->fmt->uvswap)
+			swap(base2, base3);
 		video_dbg("uv: bpl=%ld lines=%ld base2/3=%ld/%ld\n",
 			bpl_uv,lines_uv,base2,base3);
 		if (V4L2_FIELD_HAS_BOTH(dev->field)) {
-- 
2.30.2

