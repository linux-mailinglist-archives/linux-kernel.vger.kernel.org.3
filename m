Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A347527FDD
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 10:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241900AbiEPIlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 04:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241869AbiEPIlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 04:41:06 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD7F10E7
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 01:41:03 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id q4so13762982plr.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 01:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M0tCKoDzsPTdc59i5aDsXZipsRf0A5iHp7WUamBhVp0=;
        b=hp6/uhCc1vISll7TeQVh3UtY9N1H5PpJx964CmK3VKM2/cWxxbK9p36HVeUHT61Nc0
         dprPwhpblfcBwOKtiih1xvq5ACP1/nETYJ2IcJTNzWU1R3QaeiIigM9Aa7lpMt0su1SY
         SXNTjwZ8o4nYFEvhIFC6iGnMLKShkjX6dJgUGzYWDetNuoo69vqCGCWLSPqmG3yU/UpC
         ZBecOJb0vRZDna24r7Y2NrVNCINeqZZw7NMAKe1MpHvYv61jQwR9rf4iuNVgp5Zc7bZt
         dt8unfIFP58o5ciDcckvrKJAWmJ6k7hGG7dGcFe8JwyPpHqXPLpK+ns57b4z27tdTuax
         L4wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=M0tCKoDzsPTdc59i5aDsXZipsRf0A5iHp7WUamBhVp0=;
        b=dHOZU8p34XH1NJMtOj0rd8MXbcgrMyiwLXJxkMUXlk6l+DeKq342/bnj1CuKPHyfcg
         kLnp/1jcLEsgvtrZHdXCHnZE0a5RTYcc8WMh8pFGL+meO5VrTVZf/1lQkR4/ar0Myktu
         jQMOedRjxzIVZa5R36hRi2V/VCbwZix0eP+VRhKt9hOhS2mHMAT701yPJE4HWFlFDhqF
         8+g5HqO6JC+6/G9G7/c8bTBS5h/9W1rmEjjpWNDlPol0/ZWuz4oGPRl8LaCjiJC76HU9
         xTT9rZD3DQclT4ZWT0iFpse+mupxFiVf4SrDuq74sISbq9XliNmgZOWJLEKDjRqYW5/0
         03Mg==
X-Gm-Message-State: AOAM530iNu7HX6o9g/qBO59JqFZ+HxYxhZnQbw3INFRPzKOihWRCdkAt
        qQOmgq2zUYM5HFj4qD0x58BKug==
X-Google-Smtp-Source: ABdhPJwsfheq9ax2SfLs9SSyrtzzkZ954A2+1dyAFeSwkGK4ND2OiKKuyQ3hvNB7yKwYvE95gD8+DA==
X-Received: by 2002:a17:90a:ec01:b0:1df:56aa:6b7b with SMTP id l1-20020a17090aec0100b001df56aa6b7bmr3847686pjy.230.1652690462892;
        Mon, 16 May 2022 01:41:02 -0700 (PDT)
Received: from C02CV1DAMD6P.bytedance.net ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id n8-20020a170902968800b0015e8d4eb26bsm6398763plp.181.2022.05.16.01.40.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 01:41:02 -0700 (PDT)
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     tj@kernel.org, axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com,
        Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] blk-iocost: fix very large vtime when iocg activate
Date:   Mon, 16 May 2022 16:40:45 +0800
Message-Id: <20220516084045.96004-1-zhouchengming@bytedance.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the first iocg activate after blk_iocost_init(), now->vnow
maybe smaller than ioc->margins.target, cause very large vtarget
since it's u64.

	vtarget = now->vnow - ioc->margins.target;
	atomic64_add(vtarget - vtime, &iocg->vtime);

Then the iocg's vtime will be very large too, larger than now->vnow.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-iocost.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 5019dff524a4..a2ee12175c49 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -1248,7 +1248,7 @@ static bool iocg_activate(struct ioc_gq *iocg, struct ioc_now *now)
 {
 	struct ioc *ioc = iocg->ioc;
 	u64 last_period, cur_period;
-	u64 vtime, vtarget;
+	u64 vtime, vtarget = 0;
 	int i;
 
 	/*
@@ -1290,7 +1290,8 @@ static bool iocg_activate(struct ioc_gq *iocg, struct ioc_now *now)
 	 * Always start with the target budget. On deactivation, we throw away
 	 * anything above it.
 	 */
-	vtarget = now->vnow - ioc->margins.target;
+	if (now->vnow > ioc->margins.target)
+		vtarget = now->vnow - ioc->margins.target;
 	vtime = atomic64_read(&iocg->vtime);
 
 	atomic64_add(vtarget - vtime, &iocg->vtime);
-- 
2.36.1

