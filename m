Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DAE5247BC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 10:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351371AbiELIQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 04:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238788AbiELIQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:16:04 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15FBD17E1D
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:16:03 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id x23so4124713pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 01:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tUkJOIS8lwBZmrt5a2OvebuTUCP3blFkLYSYRFyjeQY=;
        b=Np32Pz60lGHyi5QgB4d6enqs5e24lUOA+sXhYI684Gk8Sj/D8pzT1/wyZHty3fVAAy
         Y4oeH691lpGUi4tr7yKIOwe3FtSebEjbJW4xx57BGrDumWR/lnnAbyqqbXfnfdcT/TFC
         IGBUc0oBbXMbNIm7xjFcVk/HI0aGA3HXopY0l7XTI2vMpy/0Hiorj6XMin4WfKLIEY+n
         YNyUbnbKzmyCc555vbO4nV8uLP/cCFjGM0LKHDngPENpCHaRyVMryOCx1iHeAnTQaNQC
         6y+SuJ9KMoCBd62+U1VV0eErirt0xIhv2gQ7AvLsSgFt9MMPxJsF9xYi9MkaZXFJvr6G
         yQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tUkJOIS8lwBZmrt5a2OvebuTUCP3blFkLYSYRFyjeQY=;
        b=iSkctirSYawwOswC0nBGlX+VdwC1BVC5lK6zvkPyGX/92ae9nET0FyZzzA1FREuihO
         5zUN9JFWPh43ufOWVT6L5hy91545gorDODTXCEWVAyzxpEM/PO0XaJt8xGtwm5JnwWH8
         DX63s6/+aMJoGz7HSv45M2AGGfDgpCcxW9yn1HxlavP1UKFNVZg+uGVwjIgzu3+NUFtx
         75TZfrITBs4ojHKn0lwa+LbNxcnM3k4kD0BR6mc/VdF7xtRyMJcdeuiYRCIOiMWY06ac
         gHvaEpxj6nLPfoIznpf/x3X2w2++U7Ns9mx5v1Z+gxESeDEYpKeqTT+Er7s20rpHDvWh
         5Z4A==
X-Gm-Message-State: AOAM533xgVN5kMHffjbogMlE3Unx0wCHd4Ki18RKDhP9GgOhhxpG4G5D
        fFHvfzfKfE4ukDw6iQfeBWw=
X-Google-Smtp-Source: ABdhPJyzuQEUlIMDx98SBZY7SWhn0EDZgQDhOP33U0ZSGHiOS48GCmCZ4reUHEUYam6IzMd2Dy9Dvw==
X-Received: by 2002:a05:6a00:1a87:b0:50e:22b:c4a1 with SMTP id e7-20020a056a001a8700b0050e022bc4a1mr28950140pfv.75.1652343362244;
        Thu, 12 May 2022 01:16:02 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id l20-20020a056a00141400b0050dc76281a1sm3170790pfu.123.2022.05.12.01.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 01:16:01 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Taichi Sugaya <sugaya.taichi@socionext.com>,
        Takao Orito <orito.takao@socionext.com>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ARM: milbeaut: Fix refcount leak in m10v_smp_init
Date:   Thu, 12 May 2022 12:15:53 +0400
Message-Id: <20220512081554.28562-1-linmq006@gmail.com>
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

Fixes: 9fb29c734f9e ("ARM: milbeaut: Add basic support for Milbeaut m10v SoC")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/arm/mach-milbeaut/platsmp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-milbeaut/platsmp.c b/arch/arm/mach-milbeaut/platsmp.c
index 3ea880f5fcb7..1f1ff21c7140 100644
--- a/arch/arm/mach-milbeaut/platsmp.c
+++ b/arch/arm/mach-milbeaut/platsmp.c
@@ -53,6 +53,7 @@ static void m10v_smp_init(unsigned int max_cpus)
 		return;
 
 	m10v_smp_base = of_iomap(np, 0);
+	of_node_put(np);
 	if (!m10v_smp_base)
 		return;
 
-- 
2.25.1

