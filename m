Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AADD524262
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 04:18:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238387AbiELCQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 22:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238192AbiELCQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 22:16:28 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCF434BB8
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 19:16:21 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 137so3337257pgb.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 19:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X2j6TD2mIuTPKvyhgEM84vF0mnSOjtOspQG8G1GXffs=;
        b=p1OXZw6z2v4rx3gFzTZYeRYEHweMQThNO3HvXWX/Ly+fMO+GCCRNuXu+dfQF8WHB9v
         KFFCJH1uMORluOnXfEBBLx8TCFGJZk8ugaavQKyD5DBxsGpOvkbDfmTEoG+B2LEHvhIH
         /YoETu4eRXd8aafzrI/O904zSfaxqmXUXvytytIC6FxS59joxaE9RAlt+rjF2SxYvGC/
         vo+IIPoWSZFI/L0kFI987Rfajz7GVvSdBOqBoBC+dOdv9WrJD1OCdkdUDoYDd6wbAdzS
         9BaRbwXaw8rmGwVzXCkdq3T8PnhSt0S/DITRkqtZk0CXCp4DXQar5ovEVnxzov/Aue7b
         ucdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X2j6TD2mIuTPKvyhgEM84vF0mnSOjtOspQG8G1GXffs=;
        b=mNnaNietSj7xHxknyOgU8n9ed0aAHJx31BXgaK3woOe0LDIpigSzxWwRnLPfnEqvfc
         rhodzyIWCjS7ubRlMsDkJFZwusMXZJR0FOw0rpFWUO48U4dlVdpde6Y7hQjK0vBk9iMY
         +eBg/I7XrZmzfbUXVz89WHRzpkFKiH+Y5Wrsuu7IL+W+RcMgcfwvX66HqBgxqxl9ttQk
         gGI3nzBzrtVx4SwaWwopgoWJ6USbjkZQFAT+9RHk5ec6Sdx6adJWpWtskI56BgqNBGJO
         ujiT0hy0LczC7DzF37BflcjDH3l3HBgE+cDUlqiVFE6+Bio89vxoY3ZIfVt4PVWiMRsj
         tXhA==
X-Gm-Message-State: AOAM530Rl54YI3fmJZiXHBLopNCem22nOpIu0mDaRQ0pv5tFnNwHb/6V
        zcN4bwdq+lfwwm4mYIusAe4=
X-Google-Smtp-Source: ABdhPJzwUrvw0u4Ts5wcIk8VISitjh89yUfdKrp/c3awkVtG7tvC+Yr23Yqcf/H1PK4Sm6VH/0eWMA==
X-Received: by 2002:a63:5902:0:b0:3c2:43c8:dff0 with SMTP id n2-20020a635902000000b003c243c8dff0mr23291690pgb.385.1652321780960;
        Wed, 11 May 2022 19:16:20 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id k12-20020a170902c40c00b0015e8d4eb292sm2590167plk.220.2022.05.11.19.16.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 19:16:20 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@endlessm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ARM: meson: Fix refcount leak in meson_smp_prepare_cpus
Date:   Thu, 12 May 2022 06:16:10 +0400
Message-Id: <20220512021611.47921-1-linmq006@gmail.com>
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

Fixes: d850f3e5d296 ("ARM: meson: Add SMP bringup code for Meson8 and Meson8b")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/arm/mach-meson/platsmp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-meson/platsmp.c b/arch/arm/mach-meson/platsmp.c
index 4b8ad728bb42..32ac60b89fdc 100644
--- a/arch/arm/mach-meson/platsmp.c
+++ b/arch/arm/mach-meson/platsmp.c
@@ -71,6 +71,7 @@ static void __init meson_smp_prepare_cpus(const char *scu_compatible,
 	}
 
 	sram_base = of_iomap(node, 0);
+	of_node_put(node);
 	if (!sram_base) {
 		pr_err("Couldn't map SRAM registers\n");
 		return;
@@ -91,6 +92,7 @@ static void __init meson_smp_prepare_cpus(const char *scu_compatible,
 	}
 
 	scu_base = of_iomap(node, 0);
+	of_node_put(node);
 	if (!scu_base) {
 		pr_err("Couldn't map SCU registers\n");
 		return;
-- 
2.25.1

