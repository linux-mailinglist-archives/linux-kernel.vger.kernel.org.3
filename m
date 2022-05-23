Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8494A531443
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237392AbiEWOz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 10:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237309AbiEWOzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 10:55:24 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 362E05AEFD;
        Mon, 23 May 2022 07:55:23 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id w3so6706052plp.13;
        Mon, 23 May 2022 07:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lAsfZ94mPmdCtSLuY+yTmU/kf8t1RWq4c+zfwIS3kZU=;
        b=qL3OCqHcHzyKI5hwEV6UajS56blAArm+NUR5fTeRmpHvBTF2luIyJ0ScsLgXZJOktO
         AF+2XMLz6+6H7LaZw3wtPUtT2Dr+4Kw6bV6pOwQV3I0sQgHyK9n3jm2RFDteLOjtxfmg
         md34NvnoGVWei0z081yCNsxplR+5EOZMtzGTDcjJb7Bk86yaGlqqyHz2YHa7w7/uP5yQ
         W1Vdv3MY9pBEomJvjedvwOBD7nZTr9KwQT/Y2VbgfX6x45Vm9FZy+R4QfW+6P5FSp8sj
         L9iUxeFcwd5G9AcJFDobomkNWm20xsxRiRWJaHYzrnUnhp+bA0nMBFZAz/XRdjsGXlrR
         kBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lAsfZ94mPmdCtSLuY+yTmU/kf8t1RWq4c+zfwIS3kZU=;
        b=XddCAtc0KqcJee7TmelQnvX243FhLci/a+ihnfyizWM9n5VBXkVfGF9BV2dh8fQe8O
         XtUbs/o5Mu1rnTG8xJN4zYsnpgFBATW0VffjxjsMUa2Jn0UwhsKmLW3u14NGvzLhOheu
         xnEq9hSUZPZQ/QafDlblzu9M2ziJCqfs/rTPkEAJ1MObXFbpDeaiIstvP/msA5hNBN3H
         tkL2EwqZQ47RQLo5cgvd0MtCYQFpfDFkZl70mxar9A43/T+1LUFmRxoH7smLkKHd7Mct
         wwPHTI7a/6FmX4Nt7c7ipgarNXbvNoIGiLj583CgUnikZdm9uXQhlmdxf1IbxWQuNm+a
         HLhA==
X-Gm-Message-State: AOAM532JfmD2mUQDWiJRtkfq5GU5o0LXbgoY3XNOP93kDBEvqOT1o+9M
        UseREfhvCT/cXLie7P+xTJne+QfFtHB/9w==
X-Google-Smtp-Source: ABdhPJwZhynyLL9YejikmlfxuBPI0eDBAgXevyP08lOSVThADiIwAEm0EMxekv2afPJkWC7NZT4lQg==
X-Received: by 2002:a17:903:124b:b0:15e:84d0:ded6 with SMTP id u11-20020a170903124b00b0015e84d0ded6mr22841886plh.141.1653317722732;
        Mon, 23 May 2022 07:55:22 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id o13-20020a17090a4b4d00b001df264610c4sm138116pjl.0.2022.05.23.07.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 07:55:22 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Russell King <linux@armlinux.org.uk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        Tomasz Figa <t.figa@samsung.com>,
        Kukjin Kim <kgene.kim@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ARM: exynos: Fix refcount leak in exynos_map_pmu
Date:   Mon, 23 May 2022 18:55:13 +0400
Message-Id: <20220523145513.12341-1-linmq006@gmail.com>
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

of_find_matching_node() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.
of_node_put() checks null pointer.

Fixes: fce9e5bb2526 ("ARM: EXYNOS: Add support for mapping PMU base address via DT")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/arm/mach-exynos/exynos.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-exynos/exynos.c b/arch/arm/mach-exynos/exynos.c
index 8b48326be9fd..51a247ca4da8 100644
--- a/arch/arm/mach-exynos/exynos.c
+++ b/arch/arm/mach-exynos/exynos.c
@@ -149,6 +149,7 @@ static void exynos_map_pmu(void)
 	np = of_find_matching_node(NULL, exynos_dt_pmu_match);
 	if (np)
 		pmu_base_addr = of_iomap(np, 0);
+	of_node_put(np);
 }
 
 static void __init exynos_init_irq(void)
-- 
2.25.1

