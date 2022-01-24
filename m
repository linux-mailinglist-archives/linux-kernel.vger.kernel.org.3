Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36BEC49A8C4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1320418AbiAYDMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3415687AbiAYC4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 21:56:52 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50DBC0E532B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:44:37 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id j5-20020a05600c1c0500b0034d2e956aadso434064wms.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:44:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7znmcaDRDi4XBN93/6yXaX6uBsi3TKnQRGE8o8aEMJU=;
        b=6NrmZXRPLdTEvLqS3ppSEX5eWHDYIGuQfgP+OmoRc9nX4bQYf6Jc+vK8VwVvGC0reW
         YpD083sS6XzF3mD2x3Q6yx2gLLg56RiTdTTPdvEEqediDTbdenAFJeHqICEDuv+/Zubj
         BfTtwNHZxFcf6gIxCZDN/jFFR4r5+FwNGUVP+XFPjhm6Zmlpr+meHkUGeJuPRNIBhB+s
         JQwHBvsiBFiv326bYrkQh5gYUXHzaPHc2q5Xlpo9YBG9E5oaD5qM+1DmA/8d/ZY8cTif
         8X4bHgLpIL3sjvtJr81nb8eUzkA9Eq6E3D0TjA//coBqxuxn2wMKklIxCHk7zs3XGh5Y
         cCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7znmcaDRDi4XBN93/6yXaX6uBsi3TKnQRGE8o8aEMJU=;
        b=o3+5aPV0fmyVBU3t8S5iLy+hO9OITGEm0iYiBCmUxn+YCGtrnzm4G35LUzq08q3vI/
         VEuirPFErx64qaVWsLms6F9F6NZ4zH6486b/83hN2Hm46mv/HQaeC6JbvaiNHSGT7YMR
         zKlNAADYNQiZNEiZNnxCDbZJYOj7xqQP3l7/nbhh2l/RvUjAjrE2qXAwNdvv7aI5wmC/
         RV+FSUPxgsA93byU/KzqgYJYF1Bq3zDgwjDcGgDWMofAC6USTX8M24Ek/v+n7Yagl8wo
         ESfjEKRIVruylEmcFvCUx9ZozGpQw9I4Cs/iINT90orCAsHL3VCY8z5izox8jFiThTu5
         E6RQ==
X-Gm-Message-State: AOAM533umawTPyW+ggIwhxQfTVsJsJo8K2zpgGNXl/sScEElZ1E53rLt
        m4se5oX+8dZKZYLdl7CB/xrsGg==
X-Google-Smtp-Source: ABdhPJwbcicGgogM0TZZeXSpHymAph9CrVa/BQqjNDo7r1juFnFPlm1dFX+XORwvjCEQhpNJ5GbSGQ==
X-Received: by 2002:a1c:a7c2:: with SMTP id q185mr378882wme.3.1643064276529;
        Mon, 24 Jan 2022 14:44:36 -0800 (PST)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id i3sm15010613wru.33.2022.01.24.14.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 14:44:36 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: [PATCH 07/10] staging: r8188eu: remove DBG_88E call from include/usb_ops.h
Date:   Mon, 24 Jan 2022 22:44:12 +0000
Message-Id: <20220124224415.831-8-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124224415.831-1-phil@philpotter.co.uk>
References: <20220124224415.831-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove DBG_88E call from include/usb_ops.h, as it does not conform to
kernel coding standards and is superfluous. This will allow the eventual
removal of the DBG_88E macro itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/include/usb_ops.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/r8188eu/include/usb_ops.h b/drivers/staging/r8188eu/include/usb_ops.h
index 0a1155bbc7b8..2b1d50d2b2f2 100644
--- a/drivers/staging/r8188eu/include/usb_ops.h
+++ b/drivers/staging/r8188eu/include/usb_ops.h
@@ -30,11 +30,8 @@ static inline int rtw_inc_and_chk_continual_urb_error(struct dvobj_priv *dvobj)
 	int ret = false;
 	int value;
 	value = atomic_inc_return(&dvobj->continual_urb_error);
-	if (value > MAX_CONTINUAL_URB_ERR) {
-		DBG_88E("[dvobj:%p][ERROR] continual_urb_error:%d > %d\n",
-			dvobj, value, MAX_CONTINUAL_URB_ERR);
+	if (value > MAX_CONTINUAL_URB_ERR)
 		ret = true;
-	}
 	return ret;
 }
 
-- 
2.34.1

