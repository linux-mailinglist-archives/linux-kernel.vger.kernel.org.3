Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4487E481DEE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 17:06:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240632AbhL3QGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 11:06:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238908AbhL3QG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 11:06:29 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB03C061574;
        Thu, 30 Dec 2021 08:06:28 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id v11so51316177wrw.10;
        Thu, 30 Dec 2021 08:06:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x0Z4VfhJECgT1/vs4niZzj7+Z6gvqhAPOkKcI0mAqoc=;
        b=ipzs2Z2aIE/u3K6VQ0AbCXqJ8wzmf1CopsYvKY+Qnn/ypMJrQW++LKWeEAwsV267tf
         t/OWBLVKSyFw0wHISAQYQ/sekslWFw+GrVzFpI2MXI+UUgXxYiJnRgyfaUcgYLs5Nbc5
         OU4JWJ+vwyVDzJbMgAD/7iEZaV+serEDsV9EO6Q+mLPRybz+otJsAr9upP8DSB9ux1y7
         C3ZIYUS+20ZWs3XKnn++HN1OxbYZrd/hWqjy0MeN+9OO5294IDMdhtAUM/m7bOuNEj09
         R2c0HsgYjT3+g57nvb2HtHm56oclfA62XnLRfylNZNz+mv1MqDvvyoM3JLoj+slwMRF2
         HwjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x0Z4VfhJECgT1/vs4niZzj7+Z6gvqhAPOkKcI0mAqoc=;
        b=f4x8gtobQecwUVp9tnKQ1itwB9jRS47fc0xsb3g9qkVjvGdjRfIJR1i55ExwU0rd25
         YWD6efBhXHo305qa0xnlRE5VGYFjm7jkulFVd9V5mj7SHaLC9dLtxgc8SJaOQJMz72Jc
         H9PXL2qxYjKnEVAO/NhTCpFFdUnB+e2IhvHH1uNPQmY845E88+GeC/m+lEwH/EZ3kqfn
         X3ZEJ4dZYlCRgQkgOrFXjXrGvX0pTK9ToggDBvCExBziYNS8xKYJ5W88Ot8AV3ska5bk
         d74saj+/tUeKpkBl2tyraYezh6ajdCwVsdQbxt8wF5HtGUi2BLG9wmfQL8Kx0hqex2zN
         QHIA==
X-Gm-Message-State: AOAM533++NehMkajvWCGrSXM6cl8LLdgyb6AGo7oWCnoZeKmY3MzeZ2l
        oou5pgpCl5lbFIjq/HDtVSWGyC0Zmpe8e4gi
X-Google-Smtp-Source: ABdhPJwh/LJEO882P8Cm7xI3bzxI9mqZ37vTY5joIviEvK7W3BI5qy21cL58BLPI6V+WVVtkmMpCMA==
X-Received: by 2002:a05:6000:1241:: with SMTP id j1mr27249409wrx.601.1640880387487;
        Thu, 30 Dec 2021 08:06:27 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id r7sm23477675wrt.77.2021.12.30.08.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 08:06:27 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Jingoo Han <jingoohan1@gmail.com>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH] video: fbdev: s3c-fb: remove redundant initialization of pointer bufs
Date:   Thu, 30 Dec 2021 16:06:26 +0000
Message-Id: <20211230160626.404072-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pointer bufs is being initialized with a value that is never read, it
is being re-assigned with a different value later on. The assignment
is redundant and can be removed. Cleans up clang-scan warning:

drivers/video/fbdev/s3c-fb.c:492:16: warning: Value stored to 'buf'
during its initialization is never read [deadcode.DeadStores]
        void __iomem *buf = regs;

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/video/fbdev/s3c-fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/s3c-fb.c b/drivers/video/fbdev/s3c-fb.c
index 3b134e1bbc38..68408c499627 100644
--- a/drivers/video/fbdev/s3c-fb.c
+++ b/drivers/video/fbdev/s3c-fb.c
@@ -489,7 +489,7 @@ static int s3c_fb_set_par(struct fb_info *info)
 	struct s3c_fb_win *win = info->par;
 	struct s3c_fb *sfb = win->parent;
 	void __iomem *regs = sfb->regs;
-	void __iomem *buf = regs;
+	void __iomem *buf;
 	int win_no = win->index;
 	u32 alpha = 0;
 	u32 data;
-- 
2.33.1

