Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FF6849A8C9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 05:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1320572AbiAYDNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 22:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S3415911AbiAYDAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 22:00:54 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836CBC0E5330
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:44:40 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id i2so16366289wrb.12
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h/tZwH09eYlURsU9ovNUrKKrqJAZOzfkUhLGHlZxAp8=;
        b=ptFZ/MGN5iTUclqldWK8yRdVKiYO5Un+VcwO4DgjfA4TluzTbiidROQZmsG52CfD4N
         zgBB1PAlpLRfC3/ROysfGEI3GxYrvKwuHCFwtlPHE1OOVfsGMqFVLUy8HvdUUsojS08Y
         TLSQX4jFe0cQ/X25xRj+VN1yPe3I9BsW4jvjW9f95YxO/y9HieedO3WH5Svr4ZD1UGxI
         Zs2pgqldHOgojdp59t8YJRkEPCHLuiSpUqKlhQzAy3PrvPXUEqLOYi7lUmMuuXedjbgz
         dk5S4dDyHzDgZrae0Pyavcb5JDrfys/pYexWxeuHqQuEUV+BNxYf9qZtmbRuXSoKGID7
         hI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h/tZwH09eYlURsU9ovNUrKKrqJAZOzfkUhLGHlZxAp8=;
        b=X4650NNLijEFtwfT5S/xKYLlwotE4OBG2UTjzDIKLAbrGNBD6Oo/nuXEj2Hmh3otqD
         9n/p3qPoP052cc0qR2LCNi4zNxLkAo8L61Z5lz5QAsnHmOGl/SZJLDgRecSxCaDazeUy
         LI1nPk08BNfJZdhNI1sWERu+dDqJiZBaH2m+yq20OBLk+M1e4NNOHF2tBUI2wOh2W/XD
         Qtz+OXgrpmS2w9auFafp4LAgRZ7CJ7YKn0Hxk+xkM7OzOfRhqsSNXWFjWJ3BzsC8K4JQ
         cGFKA16XLKrTx/nkP6NMg2SkHvGSVJeKhvwpcd7jqem74BlXRC7MW/NvK+PqT2MmyEIh
         4A4w==
X-Gm-Message-State: AOAM533n2SgvtQLEn8eIm5SL8K4GxNU5t70AUwJTVJAZqxoteSrkqe9u
        iNJkzWLRZih112z3TQ5IiO4uoQ==
X-Google-Smtp-Source: ABdhPJy5PWoq5xnwSnDuR+TdcNRfbKgEO02CCgU6iLz39soj9kdjN4AaH8rBrMGny2wziNhoXFQV5g==
X-Received: by 2002:a5d:5046:: with SMTP id h6mr15929372wrt.167.1643064279187;
        Mon, 24 Jan 2022 14:44:39 -0800 (PST)
Received: from localhost.localdomain (d.f.5.e.6.6.b.1.e.6.2.7.e.5.c.8.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:8c5e:726e:1b66:e5fd])
        by smtp.gmail.com with ESMTPSA id i3sm15010613wru.33.2022.01.24.14.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 14:44:38 -0800 (PST)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        straube.linux@gmail.com, martin@kaiser.cx,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        paskripkin@gmail.com
Subject: [PATCH 09/10] staging: r8188eu: remove DBG_88E macro definition
Date:   Mon, 24 Jan 2022 22:44:14 +0000
Message-Id: <20220124224415.831-10-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124224415.831-1-phil@philpotter.co.uk>
References: <20220124224415.831-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove DBG_88E macro definition as it has no remaining callers within
the driver. This is part of the ongoing effort to cleanup the driver to
use standard debug mechanisms where appropriate.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/include/rtw_debug.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_debug.h b/drivers/staging/r8188eu/include/rtw_debug.h
index 311051757715..959fb6bd25ca 100644
--- a/drivers/staging/r8188eu/include/rtw_debug.h
+++ b/drivers/staging/r8188eu/include/rtw_debug.h
@@ -54,10 +54,4 @@
 
 extern u32 GlobalDebugLevel;
 
-#define DBG_88E(...)							\
-	do {								\
-		if (_drv_err_ <= GlobalDebugLevel)			\
-			pr_info(DRIVER_PREFIX __VA_ARGS__);		\
-	} while (0)
-
 #endif	/* __RTW_DEBUG_H__ */
-- 
2.34.1

