Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829944C0350
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 21:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235662AbiBVUtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 15:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235633AbiBVUs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 15:48:58 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B74C2A41A3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 12:48:32 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id j2so15953471oie.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 12:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=klZ1jMjbBvLLqWpFcVVPQAyVMxl5JTcih5hQrWe+IKM=;
        b=SToRoHvrgISX5HcL1lbaJnzkK53qsAnL+YhbPx/ajhID82BuLQq8fsttj+vq9XmDCC
         X7QwCrMMZkcCMi7ZE0u94fuFeCGYyg5edz2U7bSCAbGgipkNoiK5UAxKwtXA4JdfbXbs
         1i3mF7sY1OX+rmyhL9+OddhiwK58X1jeGNoL57g/izIWG+KE15ndTqxJ2Y8BD4GWW+9R
         QXpluEmcSJRwLW5L4joKNrFJ2MJuIELZHAzYtBuq4IsLAem1+r2jw07dj6Kih4iB3xqJ
         0DMZcdx/YYhDqHHb27H5ogfGGRUAX7AUSplf06dE8EWm5AZI03ROUP6hAfQ48LnlDZFe
         0uXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=klZ1jMjbBvLLqWpFcVVPQAyVMxl5JTcih5hQrWe+IKM=;
        b=kMeP91QnPwogszguK3hWZyc4u9fQTR3o/gFsgc2feFXtVR/XEoTfJJGD7SZ5WGtoI3
         lFhQ8t7objxlKDzYXGedLCYKXIJb8L8F2uFeEBcpqi2j4CPilmjgnx2rjgSUgFL0lKBk
         /FTejw6hiJ950Hy4pxii1xTf1Y2YjU+N4dUqXYYUgUpvBvvNL2ZqkvaIU/FX7jzb0szj
         jrIV+6Q10LpJogUfdx5JA9dXcjJGhr15nPRsmVPCLeVQfbkioOX5mSjTQBSt//wGyJdO
         eqcsWgDh/aMI2oIPaLaXT4pvSmHm63YCEKWgsAJ/3ERMeoRRSJBt369jynWWpL+dneZx
         bDFA==
X-Gm-Message-State: AOAM531FDzDyBZARgsWLc9d7ogZZaEehZsa8hQPhdfDbcJtMyfeQouZ3
        CFNagbkVR235JOSsXKka8LZVFA6W/+nVJg==
X-Google-Smtp-Source: ABdhPJxuDinis6H1SdDayKBv5l4KVw4gpSxffp1LNNYuA9r/JGZwEVp7PVaiYmeyU7yakZXDrftMjA==
X-Received: by 2002:a05:6808:1441:b0:2d6:9ee5:99b1 with SMTP id x1-20020a056808144100b002d69ee599b1mr1571540oiv.18.1645562911821;
        Tue, 22 Feb 2022 12:48:31 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id o14sm16508197oaq.37.2022.02.22.12.48.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 12:48:31 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Anup Patel <anup@brainfault.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v5 5/6] RISC-V: Do no continue isa string parsing without correct XLEN
Date:   Tue, 22 Feb 2022 12:48:10 -0800
Message-Id: <20220222204811.2281949-6-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220222204811.2281949-1-atishp@rivosinc.com>
References: <20220222204811.2281949-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The isa string should begin with either rv64 or rv32. Otherwise, it is
an incorrect isa string. Currently, the string parsing continues even if
it doesnot begin with current XLEN.

Fix this by checking if it found "rv64" or "rv32" in the beginning.

Tested-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kernel/cpufeature.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index c6693873e95c..f3a4b0619aa0 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -84,6 +84,7 @@ void __init riscv_fill_hwcap(void)
 	for_each_of_cpu_node(node) {
 		unsigned long this_hwcap = 0;
 		DECLARE_BITMAP(this_isa, RISCV_ISA_EXT_MAX);
+		const char *temp;
 
 		if (riscv_of_processor_hartid(node) < 0)
 			continue;
@@ -93,6 +94,7 @@ void __init riscv_fill_hwcap(void)
 			continue;
 		}
 
+		temp = isa;
 #if IS_ENABLED(CONFIG_32BIT)
 		if (!strncmp(isa, "rv32", 4))
 			isa += 4;
@@ -100,6 +102,9 @@ void __init riscv_fill_hwcap(void)
 		if (!strncmp(isa, "rv64", 4))
 			isa += 4;
 #endif
+		/* The riscv,isa DT property must start with rv64 or rv32 */
+		if (temp == isa)
+			continue;
 		bitmap_zero(this_isa, RISCV_ISA_EXT_MAX);
 		for (; *isa; ++isa) {
 			const char *ext = isa++;
-- 
2.30.2

