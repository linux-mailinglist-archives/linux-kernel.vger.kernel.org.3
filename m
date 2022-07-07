Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C201569C82
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235238AbiGGIIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234655AbiGGIID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:08:03 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A0B33E29
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:08:02 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id j3so5212685pfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 01:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MO3ynSxTj8X1iCfAoxAy28PWw6GICyf08YG7/5qtXxo=;
        b=PJ+ZhdDXDLbL0KK1RiKOurk0CvAhFVF5mBp/VCAST7ahanMw8eIp5Bzpjk3oKcvJiO
         J0qspqCUt1HpVmVXfRtifYWZyVpVqEwTtG0lqcvVxcEDZFA7/FzhNXIxZgGnNmHI8NdZ
         pBUYRfrd0OZLpgNUYGy59RmWrlyUODCb6y26Dx/OylIZQawfKSnrCo8kQJwOtuIdkPgV
         P5c38HarwZL1OYa1I0eprUzp4mmcX2HPL5G2n0Kk3XeOe5vskaqy8V7zYoyYo7XZWWho
         Ez2bs1VLcPFGJi8h34ZKrysLJFnXBSX1UBwFSzGpKeHh/I3kDKNl09l/WW9STD/xJv20
         1CVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MO3ynSxTj8X1iCfAoxAy28PWw6GICyf08YG7/5qtXxo=;
        b=l0YjID6RCwjJhpbjtWrvEKxv8P5Se7KTJtMl0zRSzDDqzUr1kKDTurE2sLVez8Lenk
         ueittgImEW3TIj1Atl5lCoOngril9YLGHWGCXZtIObT31TiFb1I8BpbJhlyd/Bh+FN2M
         QaOxJauOGSk9XH2M6mFUQskOFY/aZBCS1kRgahAasiha4m/vLttwuWkwJjd6bMHKtYXz
         puLXvDmnrIg4vfo44ipOnETtOiGeETANdxRXmOeMY7eURw2/jbMOxZ92MjfgghqHKslC
         BWYMNXF902E2l1Y9E5xKrTYo+zDoCEuSxyKIh9JRWZJZAnmH1tpB8ZqzJEshyNgMbX+b
         Mz9g==
X-Gm-Message-State: AJIora/iVU5IpEDyCGxerJkJ0BjqmmCM4D6Dqk4fMOW09z1rLOzeKtzO
        fFh9KtDsK/nmkjl22K//YQ0=
X-Google-Smtp-Source: AGRyM1vNn3jmyFY6iNR9bfGT2tzhmnOtKbimC0i10Ah6N47O9NBIDTvg6GpILMBbxDE7K7U1ewfGMg==
X-Received: by 2002:a17:902:6b8b:b0:14d:66c4:f704 with SMTP id p11-20020a1709026b8b00b0014d66c4f704mr52158092plk.53.1657181282389;
        Thu, 07 Jul 2022 01:08:02 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:a3e3:ea8c:2267:a237])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902e74400b0016c0c82e85csm1377374plf.75.2022.07.07.01.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 01:08:02 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 1/3] xtensa: iss/network: drop 'devices' list
Date:   Thu,  7 Jul 2022 01:07:59 -0700
Message-Id: <20220707080801.3496148-2-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220707080801.3496148-1-jcmvbkbc@gmail.com>
References: <20220707080801.3496148-1-jcmvbkbc@gmail.com>
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

