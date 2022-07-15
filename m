Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BF6575B78
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:25:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiGOGX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231433AbiGOGX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:23:26 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6863D7479F
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:23:25 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e132so3577075pgc.5
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HvPrR9PIE0FNCqOgFLW4Eslzvb6RnaQ22kAYBIHei34=;
        b=S2iHj+VFNVxnLekpu122G0p/swN1DGTW0uZ5m2uQvyIVyk6BvXLcTi4Yq7t5NucfwN
         RNhUH2sUPDyeY/NAITUOUgYEtxrEK9NalbDnarbPNv/VP+9QQmHRkje0W79+sIGMN0Iy
         WhXSrnsLZM8DDIQ+GpaEBqJWYyOf/mmclYD91LDyhTfxaI1AdshaUjpN7z2QvXl6LQGM
         UYtAmYTatcr9G5hyFjzBQaxmKDJ78QGUxu0TFSTJOB1Brr6UzRyXVhB7iCstVR5OtvMR
         npkpfdEJ1GWJg0GK0xVxZB5r9QTEngKobBJWpZL1ePw9v5iyRdkVWXyuUwL4UH3g0nZb
         lcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HvPrR9PIE0FNCqOgFLW4Eslzvb6RnaQ22kAYBIHei34=;
        b=yR51KzecmviIOl1hRZGa/69EFq0kFyIc9PHls601R3JT/kt47vMt7kgPst+vsgS9+r
         9V5k0sC2Pwg80HfdITWRTNT7gRik3ZRQ/Bs9a41tu5bAfW2xUM5FcZd1hzgbcV6hR2kq
         lGtOOWq/wQBe2BeIBkLWI8zrZ+Mjfx/qqh9LepVniA2nfqcdeNDhz9nmxmDLEZZpXL/X
         oxOub3PMnadcGzhR1wsf2sVATd5x5OAxrCTByH0xjYLxVkuAISAACVBrERc8533gEZ3m
         EVfyxKqQWJYA2yZd7mBNn6CvKFe/h52PZFaWIqDOg9GeTIwOivGgBgvGuYK1LuONiG8a
         L8LA==
X-Gm-Message-State: AJIora/c+xBk+5+QXdy53VlHrk8dAD7+uqECtKud8sXLdRo1ozN6G/+o
        iQb/x1w2Ea2QQ994BTbyZpo=
X-Google-Smtp-Source: AGRyM1sTC6B5IXpBBvNT/82EeGdVT/5LyajSqupUagFzyHf+rDIloPLuW3RaX8PdPdbIKYGjZdUnTw==
X-Received: by 2002:a63:4463:0:b0:419:d02e:4dcc with SMTP id t35-20020a634463000000b00419d02e4dccmr3268700pgk.184.1657866205037;
        Thu, 14 Jul 2022 23:23:25 -0700 (PDT)
Received: from localhost.localdomain ([129.227.148.126])
        by smtp.gmail.com with ESMTPSA id o10-20020a634e4a000000b00401a9bc0f33sm2334307pgl.85.2022.07.14.23.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 23:23:24 -0700 (PDT)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     akpm@linux-foundation.org, songmuchun@bytedance.com,
        longman@redhat.com, roman.gushchin@linux.dev,
        ebiederm@xmission.com, legion@kernel.org
Cc:     linux-kernel@vger.kernel.org, Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] ipc: mqueue: fix possible memory leak in init_mqueue_fs()
Date:   Fri, 15 Jul 2022 14:23:01 +0800
Message-Id: <20220715062301.19311-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit db7cfc380900 ("ipc: Free mq_sysctls if ipc namespace creation
failed")

Here's a similar memory leak to the one fixed by the patch above.
retire_mq_sysctls need to be called when init_mqueue_fs fails after
setup_mq_sysctls.

Fixes: dc55e35f9e81 ("ipc: Store mqueue sysctls in the ipc namespace")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 ipc/mqueue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index 12ad7860bb88..83370fef8879 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -1746,6 +1746,7 @@ static int __init init_mqueue_fs(void)
 	unregister_filesystem(&mqueue_fs_type);
 out_sysctl:
 	kmem_cache_destroy(mqueue_inode_cachep);
+	retire_mq_sysctls(&init_ipc_ns);
 	return error;
 }
 
-- 
2.25.1

