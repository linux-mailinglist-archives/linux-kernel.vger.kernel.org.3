Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C0450CA52
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 15:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235700AbiDWNFl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 09:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235636AbiDWNF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 09:05:29 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A00A1F0B88
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 06:02:30 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id c23so16766693plo.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 06:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p8rAqTMQ2XWjal/ekmPzbpXL4sv2yzkmbXk/WYInG0Q=;
        b=J6Aeym90Qy7VvagYHJbWEoIg+d2WadfzFnKyUGz0cxZRSxhvpDAkZjUZ7Tz0RdjTe+
         V2gHk2sQmmEJJc6KSe7SXmlQ5yjByo+Ts95qXsXhYzFwvBt4L/vPOdjb5LVKnLmcfK5x
         HcfNqM+4BTydL8FplyHJQfRopqpOr8xicBNxYtC/V3YBnrBA9zBDKPw3EDY8ePH2CJlP
         JFyZ3SNEJH338tHvdh21LKXbLDAim5DyDlcO8upRXgOiJa9wwhXLx8yy/5T9IbQFfoC7
         nyE+L/9mAm8uodApvvqHxti+ZLS3wXdXJEWp8sSCJlqVINKpYgI8fTvMFRNZCU2ftZVc
         m2cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p8rAqTMQ2XWjal/ekmPzbpXL4sv2yzkmbXk/WYInG0Q=;
        b=CZgM/nLPYFmHeYuzjw27f7B5PFxUZNO8Iq6fXTuhpRn3Rwe4517PX4oC+tkJVeiCc9
         HKPYLDITTfwZ3VbsdBz18ZogvfyR3DqBn8bT3hE75795i5lCpNDZiFQNIN2wBxYgc4Se
         Ui0x1dslFtMIXQRpqFUpHCNjxKDKduPXryfa4WInWsTT7nlQrG/92zSlkjGbfPZCvIbA
         Uv2oX289LPa8MqwoZ8L6Tsj6dR6LJr7iLM6N78Vwu3Bc55oN32GF7LFTvM08JKEcS6Qo
         Xfc4bHKTjjpyfwjNTNn0M0cmS2nUahgJKp7g7SOzwMbU3PhI5xTHupppjaMgAg6SHfHC
         z+Lg==
X-Gm-Message-State: AOAM533tXZEgeFoM7VFGLHV4YGhGiKOUfAngfaol0l2rcE5x09Bk6sse
        QGfye0VsnFIXqWVhMrn4ZueCTWY6L1c+Ww==
X-Google-Smtp-Source: ABdhPJwAIIyfCLGQZTmPZl143X0zqHT/wc9wmMavCCX3LYvhAQteaMrULWE7fGph3+AgK9ezAIRCdA==
X-Received: by 2002:a17:90b:3c51:b0:1d6:aabd:6a3b with SMTP id pm17-20020a17090b3c5100b001d6aabd6a3bmr10729005pjb.241.1650718950431;
        Sat, 23 Apr 2022 06:02:30 -0700 (PDT)
Received: from localhost.localdomain ([14.100.36.163])
        by smtp.gmail.com with ESMTPSA id c139-20020a624e91000000b005060cdff4ffsm5808994pfb.129.2022.04.23.06.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 06:02:30 -0700 (PDT)
From:   Solomon Tan <wjsota@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dan.carpenter@oracle.com
Subject: [PATCH 7/7] staging: rtl8192e: Remove u16 cast for u16 return value
Date:   Sat, 23 Apr 2022 21:01:50 +0800
Message-Id: <20220423130150.161903-8-wjsota@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220423130150.161903-1-wjsota@gmail.com>
References: <20220423130150.161903-1-wjsota@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove explicit u16 cast of the function Mk16 return value.
The variable hi does not need to be casted explicitly to u16 as it will
already be casted implicitly.

Signed-off-by: Solomon Tan <wjsota@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_crypt_tkip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
index a305b79c53e7..8bc95651e384 100644
--- a/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
+++ b/drivers/staging/rtl8192e/rtllib_crypt_tkip.c
@@ -136,7 +136,7 @@ static inline u16 Hi16(u32 val)
 
 static inline u16 Mk16(u8 hi, u8 lo)
 {
-	return lo | (((u16)hi) << 8);
+	return lo | (hi << 8);
 }
 
 
-- 
2.36.0

