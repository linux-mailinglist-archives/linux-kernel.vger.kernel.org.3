Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F217524D15
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353871AbiELMht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353866AbiELMhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:37:40 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F99662135
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:37:39 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id qe3-20020a17090b4f8300b001dc24e4da73so5744015pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l6CFViMJQOM5l59cZNiZSV+VZMyJ7ocJv3o9yD35geY=;
        b=Yw+ak1SylPEUFp4qRcjq1rFxni8CWqBy86jhLlH0Dby796+zoPoCW90mbXwOZNw46Z
         nJdn+cmyPfp/kCaYbY1Kzp2UhGVHHih/aw+LLoo/FPupKb05/lfCOMQeYDyYLBPYfKYd
         JH8qGLMxzO2pf8iNQOzehDwBohbOOUtYEjAR94eDP/mL/tfl1GFfizQUArmy9mC6O02n
         xA1ZAsDgMvDITUqUa1UmcYG7tme0NH2dTl/y5Olfto056hm3uuRYgUUWURBLjEr5Q5Jo
         I7hEXunGErlS57VSVO10JN+mH/AYnwRDBPbuzUsmTS7WuTMQfRt5mShDD27Xfmlw19OM
         zS6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=l6CFViMJQOM5l59cZNiZSV+VZMyJ7ocJv3o9yD35geY=;
        b=H8uyYaEhWAknlwFwIZOYelfMpM8ZVWOXyHO2H8t+yQLaBBHeRWh4lXXzComKIhs+eb
         HJaq8pQRPGaF7eCHEhanvwQRmJ2COueLJIHa/qKkhv1QrDmv+Ik0GlI4IKsBZyK56FUl
         q4RbroChujMXhg5T4rTfEhGn5pkoFrh4j0fAVhND0AyfVUsd0a8S9n6EAcN9H0BjBm5a
         iM5EvFMtQzVlhtRi3GXT1mnH6vzCLF1GGr4lUZEwipoZ2mnfXAHOh0j67eAgrcxUIz9j
         aYFBuiLpwwyJMsks1kkrCmNYO8FP1rgtvdjWG6FkbnmFK6kXx1m64w9Wyfmi3hL8GxQ6
         8dSA==
X-Gm-Message-State: AOAM533vjiuA/rqeW24pcrUVhIcPq6fmSNwk4R54f/57WkkwpovxwoN9
        RP1dscO1gPdAr+5D4tJGazc=
X-Google-Smtp-Source: ABdhPJy68VggfNTCd5j2856FnBuLiJrqP3Y8EuxTuwfCivGxvsAzhFVoo4tZ5/+fDCPbgaYMytyBqw==
X-Received: by 2002:a17:902:7296:b0:14b:4bc6:e81 with SMTP id d22-20020a170902729600b0014b4bc60e81mr30308708pll.132.1652359059094;
        Thu, 12 May 2022 05:37:39 -0700 (PDT)
Received: from localhost.localdomain ([202.120.234.246])
        by smtp.googlemail.com with ESMTPSA id 10-20020a17090a174a00b001d5f22845bdsm2471299pjm.1.2022.05.12.05.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 05:37:38 -0700 (PDT)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Miaoqian Lin <linmq006@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Liu Gang <Gang.Liu@freescale.com>,
        Jin Qing <b24347@freescale.com>,
        Alexandre Bounine <alexandre.bounine@idt.com>,
        Li Yang <leoyang.li@nxp.com>,
        Kumar Gala <galak@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc/fsl_rio: Fix refcount leak in fsl_rio_setup
Date:   Thu, 12 May 2022 16:37:18 +0400
Message-Id: <20220512123724.62931-1-linmq006@gmail.com>
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

of_parse_phandle() returns a node pointer with refcount
incremented, we should use of_node_put() on it when not need anymore.
Add missing of_node_put() to avoid refcount leak.

Fixes: abc3aeae3aaa ("fsl-rio: Add two ports and rapidio message units support")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/powerpc/sysdev/fsl_rio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/sysdev/fsl_rio.c b/arch/powerpc/sysdev/fsl_rio.c
index ff7906b48ca1..1bfc9afa8a1a 100644
--- a/arch/powerpc/sysdev/fsl_rio.c
+++ b/arch/powerpc/sysdev/fsl_rio.c
@@ -505,8 +505,10 @@ int fsl_rio_setup(struct platform_device *dev)
 	if (rc) {
 		dev_err(&dev->dev, "Can't get %pOF property 'reg'\n",
 				rmu_node);
+		of_node_put(rmu_node);
 		goto err_rmu;
 	}
+	of_node_put(rmu_node);
 	rmu_regs_win = ioremap(rmu_regs.start, resource_size(&rmu_regs));
 	if (!rmu_regs_win) {
 		dev_err(&dev->dev, "Unable to map rmu register window\n");
-- 
2.25.1

