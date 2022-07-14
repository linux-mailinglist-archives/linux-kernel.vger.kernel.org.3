Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E33E574B2B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 12:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238518AbiGNKvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 06:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237741AbiGNKvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 06:51:10 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B68550B1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 03:51:06 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v16so1986220wrd.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 03:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/A1bl8uzP7IN65BrZb8dSWfE+1UFn2V6/tpFEMYxRTE=;
        b=FHQ/h+WAITPqIb63PRPvbooq/4N1XSL5vd9v1suRKTvjdrqG0PJrj1MUu9CYM8FvvH
         u3C6SneHoSYBObqd6oa84Z31DZSRffXLko2nnYVuodE1TJiM7mPEwiKdxR8WruBEb7SH
         1/zWBu1Tz/B5HAp6TbqJORKJNPuWHRDI15A54jc+Ljd/hVBnzyBQtDT/gGNIJWmYcXOJ
         a30mW5wield7hYWNpWbuSftg0Y46h/Ztm46fOes68bmzjfesGsLoZf54wcAMIFMzPNzb
         M9GUuQBXp/hhRZQeccUZPLZNbyakn2FCBWhmezIFNAoT9jv4Dd0VwQVusOj4dJQ81jpD
         n73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/A1bl8uzP7IN65BrZb8dSWfE+1UFn2V6/tpFEMYxRTE=;
        b=0ALH3fvNle+Qx+c7b44sJaPd42FndB4NlsdN0k5bZN3k0/nn5D0stxvm1o0Kcm6qZa
         NDvQ6tLhveFJLUKTn4FdEXRgRD1wMf5Hz0zKiTz4UAlqWYkH3Z44cf2PuQUcO2GBVHEY
         hlms6LLI2a2XIxnfAWi+a/pIsOwBH4HnSf4WTaqZBpBVRq/wCEszNlO/xgNZhR1cAN8x
         v4LJt+4CKpDt00wXGEik/5upwYAJPICHmAYV5l/x0PqVO0Yi8gr1YsCKmi8BIZhEXkub
         ZyKKBkNj/qq2+PWM2iGwXF2W5Pm/t/JyuXpq1HkSvtubxWWjMbxg96IpqGpr4bmO12HA
         tXwA==
X-Gm-Message-State: AJIora+ac1Tqa97ZWxlLFgJBhAXva1dj2yS4eQFD5M0RkZRKWkETC5FN
        RK3eWdEimmnkpN+xio47YBhZ0/0rpOztO6kp
X-Google-Smtp-Source: AGRyM1tJ47E2CU5jfxrTgFJ3qkVdCVzrt0J23krS2bzOY2hDikHxOBpCmHjarXe6ZQxKpCFLW1+veA==
X-Received: by 2002:adf:fe0d:0:b0:21d:81f3:854a with SMTP id n13-20020adffe0d000000b0021d81f3854amr7444549wrr.540.1657795864769;
        Thu, 14 Jul 2022 03:51:04 -0700 (PDT)
Received: from rainbowdash.office.codethink.co.uk ([167.98.27.226])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600c2e4700b003a03be171b1sm1363762wmf.43.2022.07.14.03.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 03:51:04 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH] bpf: add endian modifiers to fix endian warnings
Date:   Thu, 14 Jul 2022 11:51:01 +0100
Message-Id: <20220714105101.297304-1-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A couple of the syscalls which load values (bpf_skb_load_helper_16
and bpf_skb_load_helper_32) are using u16/u32 types which are
triggering warnings as they are then converted from big-endian
to cpu-endian. Fix these by making the types __be instead.

Fixes the following sparse warnings:

net/core/filter.c:246:32: warning: cast to restricted __be16
net/core/filter.c:246:32: warning: cast to restricted __be16
net/core/filter.c:246:32: warning: cast to restricted __be16
net/core/filter.c:246:32: warning: cast to restricted __be16
net/core/filter.c:273:32: warning: cast to restricted __be32
net/core/filter.c:273:32: warning: cast to restricted __be32
net/core/filter.c:273:32: warning: cast to restricted __be32
net/core/filter.c:273:32: warning: cast to restricted __be32
net/core/filter.c:273:32: warning: cast to restricted __be32
net/core/filter.c:273:32: warning: cast to restricted __be32

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
 net/core/filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 5d16d66727fc..c971dfaed74b 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -237,7 +237,7 @@ BPF_CALL_2(bpf_skb_load_helper_8_no_cache, const struct sk_buff *, skb,
 BPF_CALL_4(bpf_skb_load_helper_16, const struct sk_buff *, skb, const void *,
 	   data, int, headlen, int, offset)
 {
-	u16 tmp, *ptr;
+	__be16 tmp, *ptr;
 	const int len = sizeof(tmp);
 
 	if (offset >= 0) {
@@ -264,7 +264,7 @@ BPF_CALL_2(bpf_skb_load_helper_16_no_cache, const struct sk_buff *, skb,
 BPF_CALL_4(bpf_skb_load_helper_32, const struct sk_buff *, skb, const void *,
 	   data, int, headlen, int, offset)
 {
-	u32 tmp, *ptr;
+	__be32 tmp, *ptr;
 	const int len = sizeof(tmp);
 
 	if (likely(offset >= 0)) {
-- 
2.35.1

