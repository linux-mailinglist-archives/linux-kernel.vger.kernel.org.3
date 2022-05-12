Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26D925242F1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 04:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244206AbiELC6v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 22:58:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239781AbiELC6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 22:58:49 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D98633A3
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 19:58:48 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so3692873pjq.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 19:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e82365Ff7p+1CTdsj/N8XkhHoFJJQh8unB4z0JdNzS8=;
        b=jVixRsD1RDA02fr1DWC/jV1gCz63E7FOS05NJMN88eJAaxJZKCQM/RG2D0ekUW3lyD
         OFj7eTintRsTDnIEUx/NoD4eZe4OQraBxMZoZCzfcLIDSoRi8LKf4lNmlIFDKfLrYv13
         SMZZJn80KTNDHVhb/8Tex3shfLiURtjKh1oVWs0Nt3hqXtkNTMScmA07jZN9q3dEa7FB
         llQZPt9lFmcfBNZ+vtTF71UM+5+UifA1EvmvYVyXAy91W72YHA+LVzHbOSk1OdgYfvwN
         BeZaO9AgpEfBg4MrNAJ+OCX6xMzPeIRjQlUXe0QawHZRAdPCdLsdoykt8rkwsh9BnnWl
         Xqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=e82365Ff7p+1CTdsj/N8XkhHoFJJQh8unB4z0JdNzS8=;
        b=KyepFqvHUDt2PbyL9gBfOSUDB05vQ+O13eBOUHeJeyjaNS7St7ba3XXKV7rZTxvOn0
         G3N0adRkpt5A8Iek3gBeI3ZwrJVOOMIy4TK22c3SSozOG4dzrs4r69v5xIMak+4YbNck
         uPctagrVuydd0GEQiyODCXphGOMeDbf1BB64KC4zslvJFFB1h3Bl1b68kTAHLEXP1LKg
         eUTiWA3ouVS3By4ioOrtMSpRc9Sr5mOXguWpGcFFCNZM8n4P3V7rBd0hzYjqgilnElba
         cUEsErzWiCA2VQsNATIVEWaFtvYe6Q7Wi56rMaq9JDOUAuYzY1nYU1vuoLf9k7zbfSmf
         68dg==
X-Gm-Message-State: AOAM533KL2HK8VKcWJh5vz70svnrNORGJrgvazq93/HfgKt4/X/58Nhs
        kXzDGt/SjLqTQNZ8CQyYZ1o=
X-Google-Smtp-Source: ABdhPJzODckhwJTR36IUNad4+zB/ARGAivCDfA0RevtjjKjJWtFHMnDzsxhAKFbYKDQMqAyHGO6VLA==
X-Received: by 2002:a17:90b:4d11:b0:1dc:ec4f:a19c with SMTP id mw17-20020a17090b4d1100b001dcec4fa19cmr8437542pjb.117.1652324328306;
        Wed, 11 May 2022 19:58:48 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id x4-20020aa793a4000000b0050dc76281f5sm2444208pff.207.2022.05.11.19.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 19:58:47 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Wei Xu <xuwei5@hisilicon.com>,
        Russell King <linux@armlinux.org.uk>,
        Kevin Hilman <khilman@linaro.org>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] ARM: hisi: Fix refcount leak in hi3xxx_smp_prepare_cpus
Date:   Thu, 12 May 2022 06:58:38 +0400
Message-Id: <20220512025839.50333-1-linmq006@gmail.com>
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

Fixes: a9434e96d9f0 ("ARM: hi3xxx: add smp support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/arm/mach-hisi/platsmp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-hisi/platsmp.c b/arch/arm/mach-hisi/platsmp.c
index a56cc64deeb8..15e63b72df3a 100644
--- a/arch/arm/mach-hisi/platsmp.c
+++ b/arch/arm/mach-hisi/platsmp.c
@@ -68,13 +68,16 @@ static void __init hi3xxx_smp_prepare_cpus(unsigned int max_cpus)
 		ctrl_base = of_iomap(np, 0);
 		if (!ctrl_base) {
 			pr_err("failed to map address\n");
+			of_node_put(np);
 			return;
 		}
 		if (of_property_read_u32(np, "smp-offset", &offset) < 0) {
 			pr_err("failed to find smp-offset property\n");
+			of_node_put(np);
 			return;
 		}
 		ctrl_base += offset;
+		of_node_put(np);
 	}
 }
 
-- 
2.25.1

