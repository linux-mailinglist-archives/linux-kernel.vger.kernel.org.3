Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A0054C0CF5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238550AbiBWHDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:03:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238546AbiBWHDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:03:04 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB266E4DD
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:02:36 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id 139so19118027pge.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WPDmTe+hCTvs80jt4/49UAsxs25Y+NKSQwRiuv6cnUk=;
        b=K1JUDrM55xOwRD2LV3t4ZsSEYEZIFuZkVhoIYOp5IBUh8VTeMb33DgDyN8v3mcZl75
         SkGpfNqDl/p548LdibYrbvsvSXw6XOuspxhoDnNlG4eeD37y6ZRsf6FHg30ybPyNE9CJ
         lN3qsn/ZOryh9a87Fm40odUiCwY0oGsAk6a1Qw/Kgs8nNLkNeKfSgTvjrivRBe/0RjPc
         AeQVdAOgJG4p46J+uaOL9YpCOFvuz5iMGvRFINL17OwlNFFMENQSZgF2zUkFlD9Jg5f+
         vFUykyn2f+86MSg//095SQB85p38o2UTL7kFNP9ZYnjTh6xCFGquyM2DFdMP8SgFBZIT
         F9KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WPDmTe+hCTvs80jt4/49UAsxs25Y+NKSQwRiuv6cnUk=;
        b=dA5QaGVIW8AdgiqN0FKTZDCEvo+Jd086fRVYdM5m89Z4KLocSTJatZ1mlFgsPBcgc3
         3Q8O60MGqZByy5c6WjQqOP7RSc7jQpCGwJVnJvtCL2GXjHML9ZHGbl/0fdi/v7LJfXex
         0FzbCwt339AIZWG9woYAKL/09NqF1h/xvGRB1KHxHNzO0ffIeYf0b5fl9E7zZmHjFhuD
         VoCLOW556Vq2gtsNo5hsUvxpH8KD+hlFlqqtNWnFt4+5rs4U2cpIY6FKYRoCGFXXVhrV
         teUe7hjUut4aIDsSLgBqNtQ1u4dpvyhQBQHI+Uo1j168NI0ZvE6oKt/dHr0REDe4sEJI
         NF/g==
X-Gm-Message-State: AOAM53157Jd/cSd8pS8DybDtk3ApcaT+/tEX2ngVnDBli1LCNBOzymSb
        VZYh7MnbPG2vj2eZq+lbWZM=
X-Google-Smtp-Source: ABdhPJySLkvZrZ7DCwipOS93XXYsHjLEryc1FsRRn4QNjccIV8lxj6oFoh1K87CNJTejrZSPzFa1IQ==
X-Received: by 2002:a62:1d42:0:b0:4c7:f78d:6f62 with SMTP id d63-20020a621d42000000b004c7f78d6f62mr28125329pfd.33.1645599755708;
        Tue, 22 Feb 2022 23:02:35 -0800 (PST)
Received: from slim.das-security.cn ([103.84.139.54])
        by smtp.gmail.com with ESMTPSA id m21sm22748406pgh.69.2022.02.22.23.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 23:02:35 -0800 (PST)
From:   Hangyu Hua <hbh25y@gmail.com>
To:     christophe.leroy@csgroup.eu, mpe@ellerman.id.au,
        benh@kernel.crashing.org, paulus@samba.org, peng.hao2@zte.com.cn,
        wen.yang99@zte.com.cn
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Hangyu Hua <hbh25y@gmail.com>
Subject: [PATCH] powerpc: 8xx: fix a return value error in mpc8xx_pic_init
Date:   Wed, 23 Feb 2022 15:02:23 +0800
Message-Id: <20220223070223.26845-1-hbh25y@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mpc8xx_pic_init() should return -ENOMEM instead of 0 when
irq_domain_add_linear() return NULL. This cause mpc8xx_pics_init to continue
executing even if mpc8xx_pic_host is NULL.

Fixes: cc76404feaed ("powerpc/8xx: Fix possible device node reference leak")
Signed-off-by: Hangyu Hua <hbh25y@gmail.com>
---
 arch/powerpc/platforms/8xx/pic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/8xx/pic.c b/arch/powerpc/platforms/8xx/pic.c
index f2ba837249d6..04a6abf14c29 100644
--- a/arch/powerpc/platforms/8xx/pic.c
+++ b/arch/powerpc/platforms/8xx/pic.c
@@ -153,6 +153,7 @@ int __init mpc8xx_pic_init(void)
 	if (mpc8xx_pic_host == NULL) {
 		printk(KERN_ERR "MPC8xx PIC: failed to allocate irq host!\n");
 		ret = -ENOMEM;
+		goto out;
 	}
 
 	ret = 0;
-- 
2.25.1

