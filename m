Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D27F44B66D4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 10:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235617AbiBOJDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 04:03:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235547AbiBOJDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 04:03:02 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CEB91160F7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:02:41 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id z15so146492qtx.13
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 01:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hRHHCDwWs7pktn1e2TaButK3zinNjCuetMty1a6rgb4=;
        b=7B7t6he5vZWDqwC+Ob5M+euG08lerFIoCfMiLtDOqQ2llS4N7CH8tfcYn/KoBtv7rq
         E1nyUU1YJk68c1oAremArUd9AH0uqeCR7dp/29ak2YIBJl/QSXe/xtBn0NqyPDdZ9k7W
         45JdN4FAhBHtOAIqm7j/s97C8948+pHvC6Djz+YAgPYpzuA+y/VkpthppYNN14E/tlCk
         Y93QFQJ/1US9wHDPQTDcZamZDqz+RlDCVmbwMbBgZrkHdTixO1BEOCclLFc5u6tbMV1A
         1spsxllWmT7bU5arlXiRYWvH1e3qQWiSXrHqmhXBYOHHlwJB9+b4at8Z3bijZwd7w/L4
         5vPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hRHHCDwWs7pktn1e2TaButK3zinNjCuetMty1a6rgb4=;
        b=EtA9Q0MUC50EgPYJSCJgKIdXGcsNEYggKxcQ8zSyHTyl85ydWUS1xfo47HEa9XsxHk
         bhuzCryhJ/2XtNoUXRwufkCWmdU3TluzMaidHpdwV9XKJCrtgDL5xGwHwyI/qX4o8c71
         abZFmlMXcvMJYvpAtWefTOhltwBEwZU5vFr3O9i28LiYq+3DC5rX1oZ1bB3urX5keeFo
         OQfFTM6Zzf42VSie3fYlDSSBJcADPUfEDwV5uUnNy1TqLMC8VM4HHOlCpZ0DD4sEoFIg
         DMH3lR6WgJhMS3uD2gJu+7qntLq2/SsNCPhXwi3QfuREK2pSUo9TaeouC/m/dXzQ1zCw
         yG/w==
X-Gm-Message-State: AOAM533OqD+J82z47gRch86FPfzxhkJjuVTYColDZbOjumVpI95cP0Sl
        AVpG/fveRt3UuL++9Wv4s7Sh3Q/w3wkvD4nL
X-Google-Smtp-Source: ABdhPJx5N9RQt5omXNMZk0pqvVK8FnSoi+atkRQddYY2Oh8yjRKofmbcY6IK0gC4u9lfv6gg2X9Y0w==
X-Received: by 2002:a05:622a:1ba6:: with SMTP id bp38mr1972295qtb.259.1644915760250;
        Tue, 15 Feb 2022 01:02:40 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id w4sm17711158qko.123.2022.02.15.01.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 01:02:39 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atishp@rivosinc.com>,
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
Subject: [PATCH v3 5/6] RISC-V: Do no continue isa string parsing without correct XLEN
Date:   Tue, 15 Feb 2022 01:02:10 -0800
Message-Id: <20220215090211.911366-6-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220215090211.911366-1-atishp@rivosinc.com>
References: <20220215090211.911366-1-atishp@rivosinc.com>
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

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/kernel/cpufeature.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index af9a57ad3d4e..0c818035ec92 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -84,6 +84,7 @@ void __init riscv_fill_hwcap(void)
 	for_each_of_cpu_node(node) {
 		unsigned long this_hwcap = 0;
 		uint64_t this_isa = 0;
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
 		for (; *isa; ++isa) {
 			const char *ext = isa++;
 			const char *ext_end = isa;
-- 
2.30.2

