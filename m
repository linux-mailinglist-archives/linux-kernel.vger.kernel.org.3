Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481154A9B7E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 15:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359538AbiBDOvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 09:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359484AbiBDOv1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 09:51:27 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC38C061748
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 06:51:26 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id r17so2750591wrr.6
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 06:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ymoa5X9VDt1Lo7923G6xQz+2XF6WMF2nPpUrkksIMss=;
        b=Xopc4Nkg8x7cYq22CMvzmComoF0CuwSoz//ulwpXuNdB841RjSYEx8qZRKc6BHGmU5
         EPXcpzWtRzbpveFJQAKHvcgxcwz6OmxZQVSz5o9xJeTL/Tx2IU998rs9wHupVWJHcW61
         G8xjIDSkxMItkiCWo2THoUZMQolHmRRBLBXsjYEeXRLsejRRzZZwcE2w+UbCZ59w3smU
         3fNcS3DL4k1XSN068MgJeeV3nDtzGUUEOCFWcfV4762t1hNXbZIpUNyy+i/djzqv65t0
         Cv1cTnwGEU68aaI3K5vesGD0Y66vVvhTBH1Tn3bD9q9CwnXcEqC6HAcbARH45YJnJzsU
         ChNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ymoa5X9VDt1Lo7923G6xQz+2XF6WMF2nPpUrkksIMss=;
        b=6nNyTW1piaxP+gecP8IVc8duNLhJld3uFm2RvL8x/1roJhjytGy+PYw6CZOm8nHJ/E
         137qbMKWZIpHioj+Wmi5GPq5W8xfqDbzVjSBuFV9AOLmA/7fp2+X8NkdRqR7sEVLZeHE
         W/BzyRbaNVShR854GRlUgqnmHiZhSVWZoVIwRrjPeOXvyuMzDlkaU2OIu5MtYtohky54
         GBD5CY9KTNkmh38t39EFleTOKsel15YNueWdSRb9AjXebZ1q6HWuqmQZBoSWuFvp0DP2
         zDeFB7CwUh3CZg17txe97G3xW3jNBGMcMNTga2J7Aa/Ll4pKFhzHlK30v2IhhDHrejWa
         vyCA==
X-Gm-Message-State: AOAM531+obxJyxmLk1Vkvt7BwfhayUuFv4Qcv74uZxaz3gwYKrAV0Bwz
        EPDsPKtguPcwZ5/1y6YmqTRK2Q==
X-Google-Smtp-Source: ABdhPJykTMrOCuJ93oe7UN/RWNzj2G8gPRf2kOv+qJS1PEv/rFiPf7S0PHstOzbImEPkHrt2QrJSUg==
X-Received: by 2002:a5d:5342:: with SMTP id t2mr1775121wrv.602.1643986285245;
        Fri, 04 Feb 2022 06:51:25 -0800 (PST)
Received: from usaari01.cust.communityfibre.co.uk ([2a02:6b6d:f804:0:e94c:d0f2:1084:a0d3])
        by smtp.gmail.com with ESMTPSA id c11sm2552898wri.43.2022.02.04.06.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 06:51:24 -0800 (PST)
From:   Usama Arif <usama.arif@bytedance.com>
To:     io-uring@vger.kernel.org, axboe@kernel.dk, asml.silence@gmail.com,
        linux-kernel@vger.kernel.org
Cc:     fam.zheng@bytedance.com, Usama Arif <usama.arif@bytedance.com>
Subject: [PATCH v6 4/5] io_uring: avoid ring quiesce while registering restrictions and enabling rings
Date:   Fri,  4 Feb 2022 14:51:16 +0000
Message-Id: <20220204145117.1186568-5-usama.arif@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220204145117.1186568-1-usama.arif@bytedance.com>
References: <20220204145117.1186568-1-usama.arif@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IORING_SETUP_R_DISABLED prevents submitting requests and
so there will be no requests until IORING_REGISTER_ENABLE_RINGS
is called. And IORING_REGISTER_RESTRICTIONS works only before
IORING_REGISTER_ENABLE_RINGS is called. Hence ring quiesce is
not needed for these opcodes.

Signed-off-by: Usama Arif <usama.arif@bytedance.com>
---
 fs/io_uring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 671c57f9c1fa..a2ce2601d4de 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -11007,6 +11007,8 @@ static bool io_register_op_must_quiesce(int op)
 	case IORING_REGISTER_PROBE:
 	case IORING_REGISTER_PERSONALITY:
 	case IORING_UNREGISTER_PERSONALITY:
+	case IORING_REGISTER_ENABLE_RINGS:
+	case IORING_REGISTER_RESTRICTIONS:
 	case IORING_REGISTER_FILES2:
 	case IORING_REGISTER_FILES_UPDATE2:
 	case IORING_REGISTER_BUFFERS2:
-- 
2.25.1

