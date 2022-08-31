Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0385A8447
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbiHaRZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231894AbiHaRZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:25:08 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E5463C8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:25:05 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k9so19217694wri.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 10:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=DdNOmnay44tpamKMrs1LwErqXxNdYL1hnnIQ+CjZ7QA=;
        b=MG0rBr2wWp2+FARb5OnChcQ4x0S23ZL60h95CnzB7VjDZ/H2HzOa4qhBqJfaUhg+bl
         HH5NMuPrPw4BBMJ3GKz++cbp+aJPSUUdP776VpS+lgLuEgUKtZt18gnVv3ooY7nKDzxl
         vwmrQATtXcj1hDSk4rrVBtBx0sqkrypO3+3VGt8gksRuuwORrUdhboPgeoODeKhpbVqp
         W4+J069NjrhutbCY/qVWI0Pk5r3H8/XFTGFFdVfn7/SHsW0aszphuwKoa5PaZPpGYZQM
         WiwK8bGL1chbaM/cM+VZ5grJrVGRBHGb/OYSZDQwgm1s2MBXHEJqrvVJx8SRmoWWtlrg
         bViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=DdNOmnay44tpamKMrs1LwErqXxNdYL1hnnIQ+CjZ7QA=;
        b=k0LGZmilDGwnb9LFq1BKr0iKFPON/8nvhzQKb2ecJwmNYgYLwcN3Mr35zsFgpffEuX
         /oSW7RgFP+mijQwX19DZry9ks+3eyFZUJQS/33rNuyGINm6/EstqvtknLlwDPHMDDH7Q
         dzhOPmBKL7iAl86699uHUgQ58/NFQLVbznx3UgpnVI43Ht9ZZJFiW8RMcF0vbxTKk+yA
         ByWuIKWnx5CwZeC7a5/Wan8wlhMbEy4foMn9RTpu0ZyHq5+MtciEAHgB6GArBW4oweu5
         rxcUhdEtd4TLuJDoxBBWAGh4F/3qzX9+/yNYd1wJoBdMHRoFTGSvFzFk6qWFnNaP/QnC
         SWjA==
X-Gm-Message-State: ACgBeo2xqQMbQZLPH7FM/SbA/LyIddjGfCDPWM0Axu+GFSE0Ztn/vZao
        alHYjhRVY/1MyPFUmIHhIgHPxQ==
X-Google-Smtp-Source: AA6agR4D9tdHfJxgAr4odD2uA9lewMl1R3XYhjjgYG/X1gSRjA2gExwl6O2ex2Vl5wzSh024Cw+XvQ==
X-Received: by 2002:adf:d1c5:0:b0:222:cbe8:f9fa with SMTP id b5-20020adfd1c5000000b00222cbe8f9famr12286408wrd.383.1661966703923;
        Wed, 31 Aug 2022 10:25:03 -0700 (PDT)
Received: from localhost (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a5a5069107sm2618214wmq.24.2022.08.31.10.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 10:25:03 -0700 (PDT)
From:   Andrew Jones <ajones@ventanamicro.com>
To:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        mchitale@ventanamicro.com, heiko@sntech.de
Subject: [PATCH v2 1/4] riscv: Add X register names to gpr-nums
Date:   Wed, 31 Aug 2022 19:24:57 +0200
Message-Id: <20220831172500.752195-2-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220831172500.752195-1-ajones@ventanamicro.com>
References: <20220831172500.752195-1-ajones@ventanamicro.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When encoding instructions it's sometimes necessary to set a
register field to a precise number. This is easiest to do using
the x<num> naming.

Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/include/asm/gpr-num.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/include/asm/gpr-num.h b/arch/riscv/include/asm/gpr-num.h
index dfee2829fc7c..efeb5edf8a3a 100644
--- a/arch/riscv/include/asm/gpr-num.h
+++ b/arch/riscv/include/asm/gpr-num.h
@@ -3,6 +3,11 @@
 #define __ASM_GPR_NUM_H
 
 #ifdef __ASSEMBLY__
+
+	.irp	num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
+	.equ	.L__gpr_num_x\num, \num
+	.endr
+
 	.equ	.L__gpr_num_zero,	0
 	.equ	.L__gpr_num_ra,		1
 	.equ	.L__gpr_num_sp,		2
@@ -39,6 +44,9 @@
 #else /* __ASSEMBLY__ */
 
 #define __DEFINE_ASM_GPR_NUMS					\
+"	.irp	num,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31\n" \
+"	.equ	.L__gpr_num_x\\num, \\num\n"			\
+"	.endr\n"						\
 "	.equ	.L__gpr_num_zero,	0\n"			\
 "	.equ	.L__gpr_num_ra,		1\n"			\
 "	.equ	.L__gpr_num_sp,		2\n"			\
-- 
2.37.2

