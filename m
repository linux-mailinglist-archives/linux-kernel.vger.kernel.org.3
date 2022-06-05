Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E754853DAD7
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Jun 2022 10:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244754AbiFEI2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Jun 2022 04:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240098AbiFEI2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jun 2022 04:28:18 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99158286C5
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 01:28:16 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d22so9924069plr.9
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 01:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5BhKZd1ZztUFuFtohu4ix955CtOvlBJ4OzYqsyB12K8=;
        b=doejqQpfz9ht/RQ+t1MfOyTZgVOi5NUVQwtmSNk3icJY41qCkgzM3wefT3Y0hwCIGs
         6Go7a8QuyARo4srDXXsx824/KaEqFHz5CC2FQsOscnOpJZQ7LdwAVw9GYtldLunGpmQf
         nNP8EJkJUVNH5jhFO3GGZGkwVti36ZHnvmc1SYT4YOaF/QYAL+tL/5NYSc8qNrR44xZh
         KvU7474brhY19TEcrDdQ4SK04ewQ5SC7+SNtXm/TOh9qUlhXZz9FheHmuJb8+tB4m9/N
         HwGWG6f/aynWlwD5KdiF2pWS6AkaPtt4cxc0ME3KOTuzTtf+g0O9gN/3eSNaDWrwFz5k
         NDdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5BhKZd1ZztUFuFtohu4ix955CtOvlBJ4OzYqsyB12K8=;
        b=cUXQdEPC8LuGalXNSAYiS5iXbqrENAq1MHyscXXVJx35nED0VvHFg4/s+qvv6QlpO6
         onI8LkZj5P2SoMkhohJk5DINpPYqFUbdwriBpX9agKYCwFJ/FQ4yOnp3j9DWD1EJdiIc
         uoQYjVnk0Vft22F9YNcK4vnTcK+e5x4Gl8IuPlK+avN9bRKw2Y8qUl2NNOUginMlvSHG
         4xHckjmQdwkEEbcNqZd3bfOp3tz0yfEKLTrUsa5ZAxR7ZtzA9uS8zM18i4dGmriMzCgA
         LN9QGqDBy5qKirbBoG95n27zvvKuh/3VMRD88/o9M5Zgx6/886+TGoD+1h9ea8NpYqO0
         6s2w==
X-Gm-Message-State: AOAM531S4Drdqp+Ia6bW0ay14lV1AkzLW38YGcpFx8Mhw9VgcuZnzzAI
        icCF4EuuV0rYVRk0H220B4JLA6Oa/Lbrc9SL
X-Google-Smtp-Source: ABdhPJz+77+w83gRA+JN7McpWBC+snx4VxJBfmCdhMazKDR29ry7zs/XkwDU9P9w8263YLVuHf7r+g==
X-Received: by 2002:a17:902:e5ca:b0:164:1958:c84a with SMTP id u10-20020a170902e5ca00b001641958c84amr18409178plf.72.1654417696119;
        Sun, 05 Jun 2022 01:28:16 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id l24-20020a17090ac59800b001e25e3ba05csm12820399pjt.2.2022.06.05.01.28.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 01:28:15 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] cpufreq: zynq: Fix refcount leak in zynq_get_revision
Date:   Sun,  5 Jun 2022 12:28:07 +0400
Message-Id: <20220605082807.21526-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_find_compatible_node() returns a node pointer with refcount
incremented, we should use of_node_put() on it when done.
Add missing of_node_put() to avoid refcount leak.

Fixes: 00f7dc636366 ("ARM: zynq: Add support for SOC_BUS")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/arm/mach-zynq/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-zynq/common.c b/arch/arm/mach-zynq/common.c
index e1ca6a5732d2..15e8a321a713 100644
--- a/arch/arm/mach-zynq/common.c
+++ b/arch/arm/mach-zynq/common.c
@@ -77,6 +77,7 @@ static int __init zynq_get_revision(void)
 	}
 
 	zynq_devcfg_base = of_iomap(np, 0);
+	of_node_put(np);
 	if (!zynq_devcfg_base) {
 		pr_err("%s: Unable to map I/O memory\n", __func__);
 		return -1;
-- 
2.25.1

