Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C13F950F557
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 10:53:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345167AbiDZIzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 04:55:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345526AbiDZIl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 04:41:58 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F24CE158F85;
        Tue, 26 Apr 2022 01:33:08 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id a11so6094040pff.1;
        Tue, 26 Apr 2022 01:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XPCJZevhs8brMYhtAZr8BdWat46UoHpJViKaKdpMRuU=;
        b=c7vbIQntGD0977Uznsb+oxAGZUTT0lMxHbhYk9ny8G4wzPWoOrh53GXQ7s4xzFZ01f
         eV0kK1RejcGO0tYo7DEZ52ThTAGY9v/Rn7YkIOOjjb+l4n/m4yXBHk+i2OSF6CJOE05j
         AP6sQcmEG+dNc5HAV+8T/fhQ04peAYAEmXUtGXR2sFsqht4dGf6d2hvFcP57oLDKrHtF
         ypxCGEdR4zAJtJ2XsdqDsaxHSk8NB7yXLSvEXdabkat45dZjVGA7w3zbhnUhc0pAc/ue
         3xOx5leNCKMNmR4tX0M/m9umZl8/caTns2y5uwlnCP8z6sBZhZcZ1cnrjoFBw7+tX/xJ
         i3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XPCJZevhs8brMYhtAZr8BdWat46UoHpJViKaKdpMRuU=;
        b=5TPBfeZOtYn3Pa5rmID0KaDinKVJU0+LiDcqz0s9oWdPrLqNYcBBZ+uN/p4QIgvp/k
         ryis3OzA7QC0Lzt8L51LBgm5kJy9gW0UGu72IdpSxLKBxlW+JPUpyOFTe3nfiHDFO0pw
         +wFwi3/NUmkNLmfsV62BSDOsGEGOzFiV8SKgcz4v85dTTKy1SufD6M6i8rHCtmFvuEjs
         88nSk9rVeSUrGc8AXkfwg/qQ+Vjih9cMISEgb25822dZmX7VSGxQzlvrD0rZnivGd2Ht
         ezewvs5Ua0hl2AGRgRYtaaj5Be9FBNGYDcdg0XWK97vyNsIkLeXVKWQMExkB+AWFBH4p
         T7PQ==
X-Gm-Message-State: AOAM530v5y2M2gQN9HFwBHOl9uSeADMIkbPAKPu0MJ3iU6zXdGuCiTJi
        +RFptWlvad6FP9AwkKu9o1E=
X-Google-Smtp-Source: ABdhPJwD7n+yUCkn32g7caIxVGOr7/fDkuZD+briKdFO0oetqszHzCrrrJwMEBKW3GVoFDHbDd5kWw==
X-Received: by 2002:a05:6a00:1687:b0:4e1:45d:3ded with SMTP id k7-20020a056a00168700b004e1045d3dedmr23359483pfc.0.1650961988373;
        Tue, 26 Apr 2022 01:33:08 -0700 (PDT)
Received: from localhost.localdomain ([103.197.71.140])
        by smtp.gmail.com with ESMTPSA id f187-20020a6251c4000000b005058e59604csm14317884pfb.217.2022.04.26.01.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 01:33:07 -0700 (PDT)
From:   Stephen Zhang <starzhangzsd@gmail.com>
To:     tsbogend@alpha.franken.de, liam.howlett@oracle.com,
        ebiederm@xmission.com, dbueso@suse.de, alobakin@pm.me,
        f.fainelli@gmail.com
Cc:     zhangshida@kylinos.cn, starzhangzsd@gmail.com,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH] arch/mips/kernel/traps: add CONFIG_MIPS_FP_SUPPORT when using handle_fpe
Date:   Tue, 26 Apr 2022 16:32:59 +0800
Message-Id: <20220426083259.526685-1-starzhangzsd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shida Zhang <zhangshida@kylinos.cn>

handle_fpe gets defined when CONFIG_MIPS_FP_SUPPORT is defined. So add
CONFIG_MIPS_FP_SUPPORT when using handle_fpe.

Signed-off-by: Shida Zhang <zhangshida@kylinos.cn>
---
 arch/mips/kernel/traps.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 246c6a6b0261..ef9792261f91 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -90,7 +90,9 @@ extern asmlinkage void handle_cpu(void);
 extern asmlinkage void handle_ov(void);
 extern asmlinkage void handle_tr(void);
 extern asmlinkage void handle_msa_fpe(void);
+#ifdef CONFIG_MIPS_FP_SUPPORT
 extern asmlinkage void handle_fpe(void);
+#endif
 extern asmlinkage void handle_ftlb(void);
 extern asmlinkage void handle_gsexc(void);
 extern asmlinkage void handle_msa(void);
@@ -2489,8 +2491,10 @@ void __init trap_init(void)
 	if (board_nmi_handler_setup)
 		board_nmi_handler_setup();
 
+#ifdef CONFIG_MIPS_FP_SUPPORT
 	if (cpu_has_fpu && !cpu_has_nofpuex)
 		set_except_vector(EXCCODE_FPE, handle_fpe);
+#endif
 
 	if (cpu_has_ftlbparex)
 		set_except_vector(MIPS_EXCCODE_TLBPAR, handle_ftlb);
-- 
2.30.2

