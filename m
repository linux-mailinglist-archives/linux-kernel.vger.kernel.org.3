Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A7E94D2CEE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiCIKQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 05:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbiCIKQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:16:54 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6F116A59F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 02:15:55 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id kx6-20020a17090b228600b001bf859159bfso4812631pjb.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 02:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=odNBjGrfLCCPWEVQUhYnxTpNq5FiPrbmkDJ85NVrPQw=;
        b=I3KMUvRSQEdnGuaxO5x1JFtWhUj27A9+W0K7Ydv8Kzgvqy1OhZwKt9hhxwhQ9qNfR2
         YMdwy4wyCCKDK0bpnFCuHp9LRF0lOLwcZWxOBMBvq95MOWdIoSpm1//SvusoX3+gQnrF
         SPGee4OLQxyjkMXs8/lMM5l3nLQ0wUEt/bluv+d8Suw61rGFhTzufj8W84MllHV2Lnup
         pbc7uBKxpQBDvGIzLUjsVqBZpAx71R1bHZgzSX5k/rKCe7PAg9W5ICsdUTLcFBVdPFFt
         aPv51yw3KP3X58dvOIxi1o49tHbzxI/EDSl9pMa5ld4/ZOJwLS05Mu+mLQp0PFQVeDnq
         yEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=odNBjGrfLCCPWEVQUhYnxTpNq5FiPrbmkDJ85NVrPQw=;
        b=FW53HyAAIpn3vGXIJgj3FRWxLnVLVe+LuhfUtcvkPlh3fU5vemsts3hMuPdN6I/GQT
         72lG7GdgCE0qdYEgTqbhrKUJ8b0ielVAOdQp0MM7c9EUKoSIRqJwV+nu+/sY6SAQF3zC
         G8Q3tCdFF0bgUIpqpSUZLGng0TwWC0tTPaQ8tSzh+x/5kECE9kX/xu4ZLAEm0oBC4i+/
         MEbX+AfQ5JnEQVmHZrETB8JVuEWwwTKDuhiWno5+1GBZJ1++201PczhdqbqSxb/Xku/s
         DDukGbCjFg6pdbwsTm90J6+X8Ecwa9nvoK/3MIUJhGMalYlGQJtLPz1dVIwXCEUslDp+
         wygA==
X-Gm-Message-State: AOAM532QZt3R4g15FrTJpK0HOGRuWwF1gv5Umq0xWnKgNIfvPXFsQSwd
        v8FX0II6XfcHNJLBk7H4csI=
X-Google-Smtp-Source: ABdhPJza+8kB9vZlu1b2h1E6fBcBlyCbckSr2FJLVWa4fvJBmhCY3ASnKtHhMhkvPCuUtRv9g38faw==
X-Received: by 2002:a17:902:da90:b0:152:57b:5e6e with SMTP id j16-20020a170902da9000b00152057b5e6emr6338774plx.103.1646820955248;
        Wed, 09 Mar 2022 02:15:55 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id 23-20020a17090a0d5700b001bc3c650e01sm6961452pju.1.2022.03.09.02.15.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 02:15:54 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ARM: owl: smp: Fix refcount leak in s500_smp_prepare_cpus
Date:   Wed,  9 Mar 2022 10:15:49 +0000
Message-Id: <20220309101550.11584-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_find_compatible_node() function returns a node pointer with
refcount incremented, We should use of_node_put() on it when done
Add the missing of_node_put() to release the refcount.

Fixes: 172067e0bc87 ("ARM: owl: Implement CPU enable-method for S500")
Fixes: b6a0e18ca690 ("ARM: owl: smp: Implement SPS power-gating for CPU2 and CPU3")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/arm/mach-actions/platsmp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-actions/platsmp.c b/arch/arm/mach-actions/platsmp.c
index f26618b43514..9fe9a0bd0fd0 100644
--- a/arch/arm/mach-actions/platsmp.c
+++ b/arch/arm/mach-actions/platsmp.c
@@ -103,6 +103,7 @@ static void __init s500_smp_prepare_cpus(unsigned int max_cpus)
 	}
 
 	timer_base_addr = of_iomap(node, 0);
+	of_node_put(node);
 	if (!timer_base_addr) {
 		pr_err("%s: could not map timer registers\n", __func__);
 		return;
@@ -115,6 +116,7 @@ static void __init s500_smp_prepare_cpus(unsigned int max_cpus)
 	}
 
 	sps_base_addr = of_iomap(node, 0);
+	of_node_put(node);
 	if (!sps_base_addr) {
 		pr_err("%s: could not map sps registers\n", __func__);
 		return;
@@ -128,6 +130,7 @@ static void __init s500_smp_prepare_cpus(unsigned int max_cpus)
 		}
 
 		scu_base_addr = of_iomap(node, 0);
+		of_node_put(node);
 		if (!scu_base_addr) {
 			pr_err("%s: could not map scu registers\n", __func__);
 			return;
-- 
2.17.1

