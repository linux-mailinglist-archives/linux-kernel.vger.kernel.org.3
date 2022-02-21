Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDF54BE5D7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 19:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380050AbiBUQQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 11:16:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379993AbiBUQPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 11:15:33 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C6F275E4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:15:10 -0800 (PST)
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7911A40017
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 16:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645460109;
        bh=5wR2inrb50SGryPV3ql5qm7RIRt9i7gNq/sby+Clcps=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=VN7Dhyuauh9RFyBI5ipyI8n0C4NYgAO5DDi3VIbLmt2nWXCkqkNF1wof+aCWixrsh
         /iQaN/+hGGWRSRs3qwaFNhXGD5H6kf3XAgNRxCmC3ywbMQprU5caJ3rKqdqDYJ15xt
         qcPVTUbbWI5yB9eHFRY+gjN+r9sJpc3AO4J+xyGKz8uo4jeYeAIs2RLjoTlG/QBVsa
         jE7JHGHtu99yCWUNDlFJ10biaXkmKRSMgfpz+ME/ZRimaAG3IzaE6SYimmLcHDNYsO
         tZSw9hQBd1aBo7LH8UPcCzH8sVdIGM/EBNNf462KqKilE8xpr5F81Xvoky59UHMN2P
         E2Xc8KWvic/7Q==
Received: by mail-wr1-f70.google.com with SMTP id v17-20020adfc5d1000000b001e6405c2b56so7654825wrg.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 08:15:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5wR2inrb50SGryPV3ql5qm7RIRt9i7gNq/sby+Clcps=;
        b=2+NVqBsyEPvIwVs1H8YF2ZjzisKe4hFp7h1fNzPXmbkUBMcOWFdP+3qae/GrOAqjKs
         mWJGnqzsAzamc3UxcqxhHP8SIZu9ZciE684d4BA6NtMPQXlM3yqtAxeAHcbKjXFXxppM
         PxJnvHU1jgJpY1UfYtd7W1+QNOBCMKue6UzDiS1GFBu5kfgd/HZThX1lDLOjVnRaiWCS
         CJdQ5Gt1Z5LlLHMIGtHnpZkxPSdAXp5yLvqioNUguyEXPv4K3d4T80qS9FBZEsgBTkKG
         ftlvK17gkwOeDhGqnzpxqVrbZp+F9YoPFqD5TfrMvDxu3vDGyGCnb6YEZgK7q7pTfVVA
         K2CQ==
X-Gm-Message-State: AOAM532lTlioXVDRDyw4g5M95y1ebuTG8I+6lJ53CM4/9aIq6R8aOMDA
        fPamyh+fEagtDM7MgYCVN8UQ49ahX6A+33z0rwc1yr7CyO968o/z0vR1fkATpWEM6xpmjTuBmr1
        gvIoZcodVg80k/iRdpikxebs4zPe13AJCFxeJtwspAg==
X-Received: by 2002:adf:e952:0:b0:1e3:39ed:d990 with SMTP id m18-20020adfe952000000b001e339edd990mr16495594wrn.215.1645460109057;
        Mon, 21 Feb 2022 08:15:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw4/RK1fIWDS+henbbXZJgauSuqwElTcKvG20tpmepmsmnqy5mytufnWbPM6q+0YBF1+QKZTA==
X-Received: by 2002:adf:e952:0:b0:1e3:39ed:d990 with SMTP id m18-20020adfe952000000b001e339edd990mr16495579wrn.215.1645460108908;
        Mon, 21 Feb 2022 08:15:08 -0800 (PST)
Received: from localhost.localdomain (lfbn-gre-1-195-1.w90-112.abo.wanadoo.fr. [90.112.158.1])
        by smtp.gmail.com with ESMTPSA id 3sm49978552wrz.86.2022.02.21.08.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 08:15:08 -0800 (PST)
From:   Alexandre Ghiti <alexandre.ghiti@canonical.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>,
        Aleksandr Nogikh <nogikh@google.com>,
        Nick Hu <nickhu@andestech.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: [PATCH -fixes v2 2/4] riscv: Fix config KASAN && SPARSEMEM && !SPARSE_VMEMMAP
Date:   Mon, 21 Feb 2022 17:12:30 +0100
Message-Id: <20220221161232.2168364-3-alexandre.ghiti@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220221161232.2168364-1-alexandre.ghiti@canonical.com>
References: <20220221161232.2168364-1-alexandre.ghiti@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to get the pfn of a struct page* when sparsemem is enabled
without vmemmap, the mem_section structures need to be initialized which
happens in sparse_init.

But kasan_early_init calls pfn_to_page way before sparse_init is called,
which then tries to dereference a null mem_section pointer.

Fix this by removing the usage of this function in kasan_early_init.

Fixes: 8ad8b72721d0 ("riscv: Add KASAN support")
Signed-off-by: Alexandre Ghiti <alexandre.ghiti@canonical.com>
---
 arch/riscv/mm/kasan_init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/mm/kasan_init.c b/arch/riscv/mm/kasan_init.c
index f61f7ca6fe0f..85e849318389 100644
--- a/arch/riscv/mm/kasan_init.c
+++ b/arch/riscv/mm/kasan_init.c
@@ -202,8 +202,7 @@ asmlinkage void __init kasan_early_init(void)
 
 	for (i = 0; i < PTRS_PER_PTE; ++i)
 		set_pte(kasan_early_shadow_pte + i,
-			mk_pte(virt_to_page(kasan_early_shadow_page),
-			       PAGE_KERNEL));
+			pfn_pte(virt_to_pfn(kasan_early_shadow_page), PAGE_KERNEL));
 
 	for (i = 0; i < PTRS_PER_PMD; ++i)
 		set_pmd(kasan_early_shadow_pmd + i,
-- 
2.32.0

