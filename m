Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E913A55738C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:06:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbiFWHG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiFWHGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:06:15 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02AD54578E
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:06:14 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id u37so18253044pfg.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tKM3xvFOU9BbHzW/2uuQbOBzRGB1RdsYKFUv60RJdxg=;
        b=r8IqrvjRWQT1pBFaEM8t6vVrtOXzX4aBi6mB5Zn9BhF6u/GdCpTiSIQ9EN1T89UQj6
         Q/XstSt/4WvBdRHCDoYjxdqu/Vgo7gOXkXbKIbZt9KDUqp+AF2VlRc1jaq5ikvtO20pM
         ga4RO4zQnvyJ+UiOEdglRFUW06tX01Ty+kLquhYQlfE59ZMlmpKfe3q1I0acI9TWYsXf
         zlT54N/o/t/0rcF+Z3wh1GM7GMx7vddnwm/3OB3a1xADfJhWz61ioPANF44Dg1svLas/
         ssRhFze6ur1kw8m5U1FZEow+xiZCpeVdIJbpPyTO59wLxKmlB3cIVfzbnRsQTQc6xrce
         ngfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tKM3xvFOU9BbHzW/2uuQbOBzRGB1RdsYKFUv60RJdxg=;
        b=Hi7+OSMmLZ+N0Surhx7vFf5HmFIjvu/KBKEbXxV51UqhYLKMhtn76YTGRngcDvCXhY
         2Rffyny2ZIGGT7Ihn7bSdTocB15+uvvkxHKPAR6fHh3LwtHPiB11k14vOw57IIwxaY29
         BVHQQ6RRMfPRPP+RPbOiXwpcAK3Y96l03ma4xSI5ZVtZKHQCK3JOjmGd9Dqh3hZQ8p3t
         IIEZvIt9tM1Vwdg3dHx6F+5WVHcbDIaHPjMkrnGbq65mnlc75NLlJzdh3NaqIXtlRjP3
         Q4b9MtJL+e/lwpMhugB8TARdc05/7CET3MQJYzNO1xiEIONLfetBOLWJhD7HF5cHRZoz
         ITIQ==
X-Gm-Message-State: AJIora9rHDzzdAGKuPKrThNxarJA3Kr7N61h2XL+IErEO+l6CxTn3Bv5
        cs5EDBfw3RZ1pCHJvU1BZY+fIg==
X-Google-Smtp-Source: AGRyM1vyVTszeaTgvw5g3puVzGBDCQwgKBdRvtGXDXW++HjJ81hyW0BTHsvDY8mGAjdO+0tAlWFXJw==
X-Received: by 2002:a63:b345:0:b0:409:fc0f:5d5c with SMTP id x5-20020a63b345000000b00409fc0f5d5cmr6274754pgt.587.1655967973467;
        Thu, 23 Jun 2022 00:06:13 -0700 (PDT)
Received: from FVFDK26JP3YV.bytedance.net ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id ji1-20020a170903324100b0016a15842cf5sm9125184plb.121.2022.06.23.00.06.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Jun 2022 00:06:13 -0700 (PDT)
From:   Lei He <helei.sig11@bytedance.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        dhowells@redhat.com
Cc:     mst@redhat.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, berrange@redhat.com,
        pizhenwei@bytedance.com, lei he <helei.sig11@bytedance.com>
Subject: [PATCH v2 3/4] crypto: remove unused field in pkcs8_parse_context
Date:   Thu, 23 Jun 2022 15:05:49 +0800
Message-Id: <20220623070550.82053-4-helei.sig11@bytedance.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220623070550.82053-1-helei.sig11@bytedance.com>
References: <20220623070550.82053-1-helei.sig11@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lei he <helei.sig11@bytedance.com>

remove unused field 'algo_oid' in pkcs8_parse_context

Signed-off-by: lei he <helei.sig11@bytedance.com>
---
 crypto/asymmetric_keys/pkcs8_parser.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/crypto/asymmetric_keys/pkcs8_parser.c b/crypto/asymmetric_keys/pkcs8_parser.c
index e507c635ead5..f81317234331 100644
--- a/crypto/asymmetric_keys/pkcs8_parser.c
+++ b/crypto/asymmetric_keys/pkcs8_parser.c
@@ -21,7 +21,6 @@ struct pkcs8_parse_context {
 	struct public_key *pub;
 	unsigned long	data;			/* Start of data */
 	enum OID	last_oid;		/* Last OID encountered */
-	enum OID	algo_oid;		/* Algorithm OID */
 	u32		key_size;
 	const void	*key;
 	const void	*algo_param;
-- 
2.20.1

