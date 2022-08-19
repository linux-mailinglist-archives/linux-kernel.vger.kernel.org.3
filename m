Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A928599D54
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 16:09:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349344AbiHSOC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 10:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349181AbiHSOC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 10:02:56 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3747100F0E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:02:54 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id x21so5797637edd.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 07:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=gWpCeboSTd362c81JJRbfvlhocgLTAM7tdDbcBSzWLo=;
        b=nAbT1+smFaqdX4qfGI5TykDxMyIbjzhqPcHArokTkIhBwchex3uvH78ENi3Bnt4BX0
         7w5W23B0DjDiFlHt0tvmIR7ZBNYQXCvUgD8pwYp8qlP3gFqj6NxL89vjWHt8T25TT1Wy
         UrKpuERmkAa5DCCZ1tOsYOxShaMrJ1Purq4AJ0OlUWJZnLKm9oeL6UTGZSl4ncJ7MzFr
         82RvD6l56TIYCeypl3BK4Mgyzwq3H8JprBrW79AqcMzodyc7wGF4QoM8pQgA9htThGnF
         pqTJ9f/BsE6PliI6Iwsc5feBsinOW5WQUQkxw0puSHoOgvWPFWikY5bEgkDHA8tOF5ra
         LK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=gWpCeboSTd362c81JJRbfvlhocgLTAM7tdDbcBSzWLo=;
        b=oxrs42yKyr9qY7hmx/evpjMKc1vEUaH1tdiZ9Z0ZHNRGi9pP/gQ/2crjwvHPCclesL
         7M9YdViO9VqErx6sRbTUn+QlM3KzCQWm8x3qkzR5wbaJsiczWh5K00gsaCBZD4G/OQ06
         9zEU78YPh31JGsRuYXkLkS70mbG2OkSYjbWw4vI1ohBEVt1Ua857mw0CTN36eAOxGwkB
         bZfM+zQyBi3Gc3YDtiRCFF4ogIIg8RuMxZbO4JXRL19ei9/mFvpO/i92JdJVihISKi6Q
         43q7lMeBmQoPa+DaxeOL+IwuQZwOLwaTXhiof1Qg3gYlW0OHtcR/73IFqhxs3P4ztFus
         qzOg==
X-Gm-Message-State: ACgBeo1QC2Qs9KK4gBDHRV/hflbIci11IbHx/6YYP0kYNuM/pTXEv0iD
        CNwgRhaDG8dwrDLSc0BTKxlwww==
X-Google-Smtp-Source: AA6agR6iqHD8BlV5q3t5q+oMfU59Fa2v3ezBpXzZ0BeKOHeC9Vpm41nPJvjiQV3QcFghPode/hRkQw==
X-Received: by 2002:a05:6402:198:b0:442:da5a:6716 with SMTP id r24-20020a056402019800b00442da5a6716mr6164620edv.5.1660917773621;
        Fri, 19 Aug 2022 07:02:53 -0700 (PDT)
Received: from localhost (cst2-173-67.cust.vodafone.cz. [31.30.173.67])
        by smtp.gmail.com with ESMTPSA id q15-20020a170906360f00b00730a73cbe08sm2383101ejb.169.2022.08.19.07.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 07:02:53 -0700 (PDT)
From:   Andrew Jones <ajones@ventanamicro.com>
To:     linux-riscv@lists.infradead.org, kvm-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        mchitale@ventanamicro.com, heiko@sntech.de
Subject: [PATCH 1/4] riscv: Add X register names to gpr-nums
Date:   Fri, 19 Aug 2022 16:02:47 +0200
Message-Id: <20220819140250.3892995-2-ajones@ventanamicro.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220819140250.3892995-1-ajones@ventanamicro.com>
References: <20220819140250.3892995-1-ajones@ventanamicro.com>
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
2.37.1

