Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077B053C9B2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 14:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244159AbiFCMJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 08:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237519AbiFCMJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 08:09:17 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6444248E0
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 05:09:16 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id q18so6680406pln.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 05:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0DhV/bSEDMfWlEIgmxZfIXZk2f8EJJW/Clb9Xr6LaGQ=;
        b=eEx/CXv91F51gHGzlP7zjr9bT6WbxjasgQZstRm/f9Ke5zHlfqu2OS/yhdaAju55bb
         BalsuxJl0Y78g3SLsgX8pZznbSfrZYhG1ofOJDV9G1hW5ljIQ1vIPK2z/Z1Vf29/7ZWz
         Gt70+XKZVBu4Zj/oUWxNQ9CLYzPQWhL2L/D8YQB+JW4hCbFuoyPeSpRKa1j9iLbUpsvm
         UFLQSONOD3o0qyMBYhB8RM1ryy40J0050hObaakm1jGSyktzcDISJsLA8P5fqUUckmNy
         nAYWOcuL/lh3+1IMgWH06/XSCY1uDSarD7XsE5LTRaItxGkvs8MrpO7z3LGSY/SqDDPc
         vONQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0DhV/bSEDMfWlEIgmxZfIXZk2f8EJJW/Clb9Xr6LaGQ=;
        b=pUmRtWe2gFRjur8C9tsGbjAZ/d3qQuBlDV7xyEvvrPDX7qkPp4fNNDu6TTFf3Eqvr0
         96Km7FIJE2YMgfNbo1MQhaaSmUC0cXYPmsKmbj+dRJ7Sp1jASmN59rnQL4GIyxAOmqoe
         TlwRt0VEWFEmO77fSU8Jt4WMVJHC217JsuwwxlQyDURxU0aRpUbKvJd5Jx0xJsbuVWOt
         nCaf54TX5BG9DfvVvmVoFwTx9gMdRpHiPq3hygrmK7w6T0/TTSTSypmpiUDPm3DpC3I+
         5QHfVmoNLt3qn6/AF8Xhec2QUy4Y984EDBjv/XZ1BcYddRI4w9DKz2K20P5iQliuUiBW
         HHiA==
X-Gm-Message-State: AOAM533q02xB9rOZBxiMSVEQW4V9SZWB5e+REdH6J+U+oeek17C1vZRH
        RgpL+RJ0CxgS0ohZ0q/S4bg=
X-Google-Smtp-Source: ABdhPJxL50NVd//ZW4zr/fI3E4mFR5M/jjEmELF8syGQR/bbikYMpaN4MnfTXHNT5RAt/SCYxeB1tg==
X-Received: by 2002:a17:902:ef50:b0:156:486f:b593 with SMTP id e16-20020a170902ef5000b00156486fb593mr9964208plx.104.1654258156469;
        Fri, 03 Jun 2022 05:09:16 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id e14-20020a170902ed8e00b0015edfccfdb5sm5312741plj.50.2022.06.03.05.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 05:09:15 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Scott Wood <oss@buserror.net>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nick Child <nick.child@ibm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Miaoqian Lin <linmq006@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/85xx: Fix reference leak in xes_mpc85xx_setup_arch
Date:   Fri,  3 Jun 2022 16:09:05 +0400
Message-Id: <20220603120907.19999-1-linmq006@gmail.com>
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

of_find_node_by_path() returns remote device nodepointer with
refcount incremented, we should use of_node_put() on it when done.
Add missing of_node_put() to avoid refcount leak.

Fixes: format:3038acf9091f ("powerpc/85xx: Add platform support for X-ES MPC85xx boards")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/powerpc/platforms/85xx/xes_mpc85xx.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/platforms/85xx/xes_mpc85xx.c b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
index 5836e4ecb7a0..93f67b430714 100644
--- a/arch/powerpc/platforms/85xx/xes_mpc85xx.c
+++ b/arch/powerpc/platforms/85xx/xes_mpc85xx.c
@@ -130,6 +130,8 @@ static void __init xes_mpc85xx_setup_arch(void)
 	mpc85xx_smp_init();
 
 	fsl_pci_assign_primary();
+
+	of_node_put(root);
 }
 
 machine_arch_initcall(xes_mpc8572, mpc85xx_common_publish_devices);
-- 
2.25.1

