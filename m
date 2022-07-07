Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4AE569A88
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 08:31:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbiGGGbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 02:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbiGGGbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 02:31:00 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B831580C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 23:30:57 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y141so17420212pfb.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 23:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MO3ynSxTj8X1iCfAoxAy28PWw6GICyf08YG7/5qtXxo=;
        b=lf23X0U7EUSaU+TM9HkurbaRi3vg/9BZwKnU+DUtKR7xnUl9Owo5QqLWDp2vmH6oYA
         XD6y6VZfwvKBsojd4boZ5Hjj9VPJbGv2OojAJkY9Ev8BwvDDTD0NkhxIWac/sJNRc3fN
         18vrosz+1HAfjpiETu0BdEO4sS/5UFABQc6TRQX+yGQKaKLD5bnHFWwj3gXtJEOYSTgl
         zcAUODlHbga0lOVLfQ+FjcPYPyWZa9FHD2tkwcjP8symTsN4oOkJgW7hfjcincW9uMwd
         M7ZhF9E2u/pLCNYzx41fEH5u9gfMCettPloj5PbQh97m/3oZnwVx91WaWkii69tv+YNx
         wSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MO3ynSxTj8X1iCfAoxAy28PWw6GICyf08YG7/5qtXxo=;
        b=KzwYkOwjhlEY+PdeaHGBfNRy9MQMXTpjjipJioINkM8gWhmQStw9zUUzCm5XGvEEP6
         b7R32lEOOCcEncuDHLeZtjAHUHbZStSe4doOmEZ/y+EAEFIXGmtOtsSYyBri2BVMKdmN
         fs0kY7vE/cQcI0XQzmwSSkA2gKyKfgHQBrIL8I5yH2jS/UmnAgek+/3lIDlWxkmNk5Tz
         eS1HRtmX7YgFS4QH7mD9WTsObkYswU8IMfaBSHvJixMB6rSQv1mtG9gtGHvT3bADRts2
         aCw/YZzsvrUPafo/MH7VtHOA7ppvgqije2CRMwNF0SRetvFcY0B5eFylB+X3hBpUd1Jv
         32ag==
X-Gm-Message-State: AJIora823eJl6pw7xhqAdHjmOvx44vBkV/XWQYMae9kxO9clMexia/Mm
        gUmDIAj+AU9H3hN2iWp/owE=
X-Google-Smtp-Source: AGRyM1vasxVFHOLUeQxCZwevdQZD9p7H2SSgtk/WNZE+n7hPzwBJu8mmJ5/o3U+kl4qUSdYTUW22UQ==
X-Received: by 2002:a17:903:2445:b0:16a:32da:cc9 with SMTP id l5-20020a170903244500b0016a32da0cc9mr51440461pls.148.1657175457406;
        Wed, 06 Jul 2022 23:30:57 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:a3e3:ea8c:2267:a237])
        by smtp.gmail.com with ESMTPSA id a140-20020a621a92000000b005289fbef7c4sm3317798pfa.140.2022.07.06.23.30.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 23:30:57 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: iss/network: drop 'devices' list
Date:   Wed,  6 Jul 2022 23:30:55 -0700
Message-Id: <20220707063055.3463190-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are two per-device lists in the ISS network driver: command line
parameters list and iss_net_private object list. The latter is only used
for duplicate checking in the function iss_net_setup where the former
should have been used.
Drop iss_net_private object list and associated code and use command
line parameters list in the iss_net_setup instead.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/platforms/iss/network.c | 21 +++------------------
 1 file changed, 3 insertions(+), 18 deletions(-)

diff --git a/arch/xtensa/platforms/iss/network.c b/arch/xtensa/platforms/iss/network.c
index fd84d4891758..2d566231688f 100644
--- a/arch/xtensa/platforms/iss/network.c
+++ b/arch/xtensa/platforms/iss/network.c
@@ -37,10 +37,6 @@
 #define ETH_HEADER_OTHER 14
 #define ISS_NET_TIMER_VALUE (HZ / 10)
 
-
-static DEFINE_SPINLOCK(devices_lock);
-static LIST_HEAD(devices);
-
 /* ------------------------------------------------------------------------- */
 
 /* We currently only support the TUNTAP transport protocol. */
@@ -70,8 +66,6 @@ struct iss_net_ops {
 /* This structure contains out private information for the driver. */
 
 struct iss_net_private {
-	struct list_head device_list;
-
 	spinlock_t lock;
 	struct net_device *dev;
 	struct platform_device pdev;
@@ -488,7 +482,6 @@ static int iss_net_configure(int index, char *init)
 
 	lp = netdev_priv(dev);
 	*lp = (struct iss_net_private) {
-		.device_list		= LIST_HEAD_INIT(lp->device_list),
 		.dev			= dev,
 		.index			= index,
 	};
@@ -521,10 +514,6 @@ static int iss_net_configure(int index, char *init)
 		driver_registered = 1;
 	}
 
-	spin_lock(&devices_lock);
-	list_add(&lp->device_list, &devices);
-	spin_unlock(&devices_lock);
-
 	lp->pdev.id = index;
 	lp->pdev.name = DRIVER_NAME;
 	platform_device_register(&lp->pdev);
@@ -574,7 +563,7 @@ struct iss_net_init {
 
 static int __init iss_net_setup(char *str)
 {
-	struct iss_net_private *device = NULL;
+	struct iss_net_init *device = NULL;
 	struct iss_net_init *new;
 	struct list_head *ele;
 	char *end;
@@ -595,16 +584,12 @@ static int __init iss_net_setup(char *str)
 	}
 	str = end;
 
-	spin_lock(&devices_lock);
-
-	list_for_each(ele, &devices) {
-		device = list_entry(ele, struct iss_net_private, device_list);
+	list_for_each(ele, &eth_cmd_line) {
+		device = list_entry(ele, struct iss_net_init, list);
 		if (device->index == n)
 			break;
 	}
 
-	spin_unlock(&devices_lock);
-
 	if (device && device->index == n) {
 		pr_err("Device %u already configured\n", n);
 		return 1;
-- 
2.30.2

