Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A25FC507E74
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 03:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358820AbiDTBwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 21:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348404AbiDTBwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 21:52:04 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A9236E0A
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 18:49:20 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id x191so190996pgd.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 18:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/UuWmXAeK3wDg34COXqd7JHzyxxdodWHUXeYP3t+DVM=;
        b=jNy+tVOlKTuaYase1uWbsaybUMzAQOYmfdHlgLhP/+zTF8xCAUk/rP1NoLEGiss6Ci
         8qkBAnee5LdixG9PAXR78Oh8mQtv1kvTWP7aD6/ans2MUS8VItAiXi29L6eVczGyZ5Gk
         O9Qyer2uqerzeN7dx4kFdxCkpGRACMwyQmfXq9KmBIv5s6TxXgXU3PpOziZzKuX5PLik
         9ciG9eSVuwEK8pTOA4H+l7gR4xJegCf7bUg2hDXyi8H6nGdC/fypU7slc7C2UTtKBBa4
         naCTHZbfiuCV7cDhsc64yGZCVU7gLq8M7oy4C2pkMiGKaNe3L6SmTIuAh9u21UEuE1rU
         2q+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/UuWmXAeK3wDg34COXqd7JHzyxxdodWHUXeYP3t+DVM=;
        b=17zZUi/3jCL2FgGbKmVWT2iNG3GkKyvKz5B3eJqVtcbDrIESQ6a5ll0ISTRUfPAn7m
         9Tl0/JUlYwiRJbldw9GZFc0+YO9SBOS/aT8JE/TSnc93iVf5jSzlTodyuX3rrEyhOUaw
         /PTXaPj2U+4OWEr2O9D5ec90/CJ/JD33oww0P3j1XgYaD4MSM3/AgFp9Qzozx7bYNLCi
         qnCTj/u5no2m3qliDkVAgDy79huuUd0CIPa5p/xxeGvzj3mqDFsIkMpqN+ET7TKpJAYc
         gQfroGhq14guj6mTwD9knn0jr89oOm/nExJhzRMLx235OtLV6XkgoUsy3qaa2lpuo6z1
         rfQw==
X-Gm-Message-State: AOAM533sPQsCDxZ0RhpLEi1+XxlK9khINv6oR44vMtXQ/HNstMY4nTSw
        TWEvb8N8HTZjhITWWqDk1AY=
X-Google-Smtp-Source: ABdhPJw58IDvs8PX3F7lrr3iHelhvA0R312SWs14z9YL08C1HaVgt0xmXyKbe63xjiK6qsGJlYlidA==
X-Received: by 2002:a05:6a00:2489:b0:50a:754c:c557 with SMTP id c9-20020a056a00248900b0050a754cc557mr13590297pfv.37.1650419359982;
        Tue, 19 Apr 2022 18:49:19 -0700 (PDT)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id x20-20020aa79574000000b005061f4782c5sm17543755pfq.183.2022.04.19.18.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 18:49:19 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Shannon Zhao <shannon.zhao@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Julien Grall <julien.grall@arm.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Juergen Gross <jgross@suse.com>,
        xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH v2] arm/xen: Fix some refcount leaks
Date:   Wed, 20 Apr 2022 01:49:13 +0000
Message-Id: <20220420014913.2586-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220406021905.GA30436@8345e2a12d0c>
References: <20220406021905.GA30436@8345e2a12d0c>
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

Fixes: 9b08aaa3199a ("ARM: XEN: Move xen_early_init() before efi_init()")
Fixes: b2371587fe0c ("arm/xen: Read extended regions from DT and init Xen resource")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
changes in v2:
- call of_node_put in non-error path in xen_dt_guest_init
- fix same refcount leak error in arch_xen_unpopulated_init
---
 arch/arm/xen/enlighten.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index ec5b082f3de6..07eb69f9e7df 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -337,12 +337,15 @@ int __init arch_xen_unpopulated_init(struct resource **res)
 
 	if (!nr_reg) {
 		pr_err("No extended regions are found\n");
+		of_node_put(np);
 		return -EINVAL;
 	}
 
 	regs = kcalloc(nr_reg, sizeof(*regs), GFP_KERNEL);
-	if (!regs)
+	if (!regs) {
+		of_node_put(np);
 		return -ENOMEM;
+	}
 
 	/*
 	 * Create resource from extended regions provided by the hypervisor to be
@@ -403,8 +406,8 @@ int __init arch_xen_unpopulated_init(struct resource **res)
 	*res = &xen_resource;
 
 err:
+	of_node_put(np);
 	kfree(regs);
-
 	return rc;
 }
 #endif
@@ -424,8 +427,10 @@ static void __init xen_dt_guest_init(void)
 
 	if (of_address_to_resource(xen_node, GRANT_TABLE_INDEX, &res)) {
 		pr_err("Xen grant table region is not found\n");
+		of_node_put(xen_node);
 		return;
 	}
+	of_node_put(xen_node);
 	xen_grant_frames = res.start;
 }
 
-- 
2.17.1

