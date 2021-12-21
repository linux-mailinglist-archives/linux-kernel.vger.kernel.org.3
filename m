Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6EA547B685
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 01:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbhLUAmu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 19:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbhLUAmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 19:42:49 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F8EC061574;
        Mon, 20 Dec 2021 16:42:49 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id bg2-20020a05600c3c8200b0034565c2be15so563885wmb.0;
        Mon, 20 Dec 2021 16:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Puo2oNvsoRrnpQH+n5NLnmsOFgzm1Lgnbw19SNKWiaE=;
        b=Yba/NrOEC10S1hJBj0eFz30kKNmKLgaqv31/VG2P2JWZnd8YevofZq00lN4ZZYpVxm
         424ZLUH3eISz79/DXuMlNABq2nJjRWi0U3qlqC0Ll0pdrG249cCdq1fldf+sfZLYJfp3
         SfvRJQ81dRqJWIgcol2ywuZPcNG/V9KSsxq/WzXgqiuvsreUmO/bqMDWn5dk++kSE2P8
         bhRTTaZlcSwDGERXwXT3Pu4x3FAUkCtiZMpRMLdZVbbgvH2n/Ig86m7v5im/IK6u90Dj
         HMMdvnjekcWiWtdcwBM/YA8aYQYu2jElTpI6eBO6nrBiXQBcGel+xWf40iMX5Y1Nw9zy
         lxDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Puo2oNvsoRrnpQH+n5NLnmsOFgzm1Lgnbw19SNKWiaE=;
        b=SuVt3NkVDwat1YxVBUkGvpBNUGUZnzVbwQTbUPbdYzXDsjfcc+Y46QQKi+uufdKKmF
         aQJ2ZtHGw+0QXMDSO/+tyDJFdcDXLsvj/Ku3rd1x9D8Cy0qs1g97BClR/5R5dTjZtATj
         jFg7lxgk4KXOUjBNyiy74sNfdkHyqGJ5ngS23EzU3WuiMvR/xzNFshJWUn2K9T3pZATn
         ZQo6S8X1YPdHfd62W+9FPFZkdpDCQBldGpoJUQjfNIUk/eCZMUxH86toDAeb+ioLdf7k
         ycrcN7DgK5BW8fdOFB6B+rurcgmHVRZFORvy5cJnw+5e1GPDEyliyLGfWl9MgQCnp6Zm
         Duyg==
X-Gm-Message-State: AOAM530U6a7HmOZReGDeT+S+tQ5RfbcAVAo0A7sp/I/4ef/yuq5tO39s
        hZ9+hkrhd4AurDnyeSrJqBQ=
X-Google-Smtp-Source: ABdhPJzjBBPLhk7+kN3XdBeElOx6r0VuLj7K389GxHsxIkT+d5ia1DNpdzu60cAWnGs3oVVdDE0kHw==
X-Received: by 2002:a05:600c:2f01:: with SMTP id r1mr409570wmn.153.1640047367820;
        Mon, 20 Dec 2021 16:42:47 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id h2sm16176319wrz.23.2021.12.20.16.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Dec 2021 16:42:47 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] video: fbdev: mb862xx: remove redundant assignment to pointer ptr
Date:   Tue, 21 Dec 2021 00:42:46 +0000
Message-Id: <20211221004246.213203-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pointer ptr is being assigned a value that is never read. The
pointer is being re-assigned later in a loop. The assignment is
redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/video/fbdev/mb862xx/mb862xxfb_accel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/mb862xx/mb862xxfb_accel.c b/drivers/video/fbdev/mb862xx/mb862xxfb_accel.c
index d40b806461ca..61aed7fc0b8d 100644
--- a/drivers/video/fbdev/mb862xx/mb862xxfb_accel.c
+++ b/drivers/video/fbdev/mb862xx/mb862xxfb_accel.c
@@ -132,7 +132,7 @@ static void mb86290fb_imageblit8(u32 *cmd, u16 step, u16 dx, u16 dy,
 	cmd[2] = (height << 16) | width;
 
 	i = 0;
-	line = ptr = image->data;
+	line = image->data;
 	bytes = image->width;
 
 	while (i < height) {
-- 
2.32.0

