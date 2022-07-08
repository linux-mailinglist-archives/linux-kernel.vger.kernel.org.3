Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0EC156B309
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 09:02:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237276AbiGHHAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 03:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237176AbiGHHA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 03:00:26 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396A174792;
        Fri,  8 Jul 2022 00:00:25 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 72so125362pge.0;
        Fri, 08 Jul 2022 00:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M5RE66zrdc/N0NBtgGFgV/bL4WegcaJZi2+sphyGLok=;
        b=FIuiHaiPXg7QDqSFtyF6OuChPFcFdIcMisknzrlnDq8HzZBfhgsjLVyV7RbU9yoUiD
         ts3SzbiQZzg7wJzoHtZ+ax4J7TRlPqLeaMAQUPIKVS4Uun9ZeVDm6DGSS0UaMj4/23w7
         ORjoskWb/pJBuPBfMe/ye2FXZqMaRrjoB0qbxJfUFLZkqHRRWloEJ9bycl/XcKTrxMgJ
         I8l0IvM4Pc/WMzHU38+0BX3KakIJ9f59ZQ0bNV2EQzHDI7NIDG5qNog10RY6Bf9d052f
         lHWvNZI6tmQ0CdiFx8FeFhbBXhNncdEUxujTSc0qOO38uhHxfW0fi74KhnhsVjGzJTuI
         ilgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M5RE66zrdc/N0NBtgGFgV/bL4WegcaJZi2+sphyGLok=;
        b=zkH1JhudaeUxZyMtjeIVqjM5i5/B02ZK2JrIpCHeM1Q67LIhV/ECchyY0fhsjGleSL
         W2U5TC6NGvhkhhEBXQOvTSIBAe0TapiXhchsaopgnqkM13G+ZeeAZC01hpWwHqOyk1RL
         EZ2QKbgSD2z5nprDgJ2rL33TfE2O/3aGqQieuFjfkX7m7JsZssXD/yJaTWRexKUJYeP9
         tnx4PWZSb5NwLqyhzQjSpo4YzOhmw0NlcwoX99Da9+0qc5DRHbH1qM+Ajnkyz6IWoqkO
         pJ4zhsfuIFUll68ozLIukfn7fFQh2JlDI2e+0gkacf0lQfb8+zenCHQjQPQQS71Mwu1H
         cQLg==
X-Gm-Message-State: AJIora8pADAYOByYK28oHkpdNHAA171wlwNEjUrHVTVSfJtZyD86mjBY
        Pi05TTeWnjY1toS5qWLQe50=
X-Google-Smtp-Source: AGRyM1uf7NHQjaeeca+DJ6oixV1QzXnzIK7AaL5emKlSjOMweKzPtb9tssIVlJVf5TC7BTLLInm8ag==
X-Received: by 2002:aa7:8b51:0:b0:525:5132:8a84 with SMTP id i17-20020aa78b51000000b0052551328a84mr2206235pfd.45.1657263624676;
        Fri, 08 Jul 2022 00:00:24 -0700 (PDT)
Received: from localhost.localdomain (47-72-206-164.dsl.dyn.ihug.co.nz. [47.72.206.164])
        by smtp.gmail.com with ESMTPSA id d16-20020a170902b71000b0016a7b9558f7sm26513101pls.136.2022.07.08.00.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 00:00:24 -0700 (PDT)
From:   Barry Song <21cnbao@gmail.com>
To:     namit@vmware.com
Cc:     21cnbao@gmail.com, akpm@linux-foundation.org, arnd@arndb.de,
        catalin.marinas@arm.com, corbet@lwn.net,
        darren@os.amperecomputing.com, guojian@oppo.com,
        huzhanyuan@oppo.com, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, lipeifeng@oppo.com, mgorman@suse.de,
        realmz6@gmail.com, v-songbaohua@oppo.com, will@kernel.org,
        x86@kernel.org, yangyicong@hisilicon.com, zhangshiming@oppo.com
Subject: Re: [PATCH 2/4] mm: rmap: Allow platforms without mm_cpumask to defer TLB flush
Date:   Fri,  8 Jul 2022 18:59:57 +1200
Message-Id: <20220708065957.3859-1-21cnbao@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <67943544-6DAA-4C8A-A04D-029D2D36C318@vmware.com>
References: <67943544-6DAA-4C8A-A04D-029D2D36C318@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The cpumask_empty() is indeed just another memory access, which is most
> likely ok. But wouldn’t adding something like CONFIG_ARCH_HAS_MM_CPUMASK
> make the code simpler and (slightly, certainly slightly) more performant?

Yep. good suggestion, Nadav. So the code will be as below, right?

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index be0b95e51df6..a91d73866238 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -81,6 +81,7 @@ config X86
 	select ARCH_HAS_KCOV			if X86_64
 	select ARCH_HAS_MEM_ENCRYPT
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
+	select ARCH_HAS_MM_CPUMASK
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PMEM_API		if X86_64
 	select ARCH_HAS_PTE_DEVMAP		if X86_64
diff --git a/mm/Kconfig b/mm/Kconfig
index 169e64192e48..7bf54f57ca01 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -951,6 +951,9 @@ config ARCH_HAS_CURRENT_STACK_POINTER
 	  register alias named "current_stack_pointer", this config can be
 	  selected.

+config ARCH_HAS_MM_CPUMASK
+	bool
+
 config ARCH_HAS_VM_GET_PAGE_PROT
 	bool

diff --git a/mm/rmap.c b/mm/rmap.c
index 5bcb334cd6f2..13d4f9a1d4f1 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -692,6 +692,10 @@ static bool should_defer_flush(struct mm_struct *mm, enum ttu_flags flags)
 	if (!(flags & TTU_BATCH_FLUSH))
 		return false;

+#ifndef CONFIG_ARCH_HAS_MM_CPUMASK
+	return true;
+#endif
+
 	/* If remote CPUs need to be flushed then defer batch the flush */
 	if (cpumask_any_but(mm_cpumask(mm), get_cpu()) < nr_cpu_ids)
 		should_defer = true;

Thanks
Barry

