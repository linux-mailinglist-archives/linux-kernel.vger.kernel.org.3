Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B15164ED44A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 08:58:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231560AbiCaG7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 02:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbiCaG7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 02:59:15 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F12AC108547
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 23:57:27 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id bx5so23159760pjb.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 23:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I5exx/RB+d0Ig7pXuqKbMzRv7rQoprfE6EMWAxPn3vk=;
        b=VxsWEIotkC2VYiWWzOCyD1h39EI03hJn4gYoUq5zL+es6eKEi/fQPJEpTFiQhX51V9
         eikNF5Q4nJX9kTCRRilvUSCkBYeRXTclsDYJrtTV3K7xEbiRG2R9cRz5ththfznMM3XC
         66QKDnh3Cj3JDimXFfT7EUKNWhHjsObnnQynBYRDAdMdFdKt8UOEDbHAWZejxE0xs4rx
         snTFc7AtACXs3vBUkU+J5RON6gZUTOjKnm6p9ZnUqRBfbWaVAiLtTSaP8GfA32r9OqOS
         f7tm7oIJpihmrGFTzDO6n6HNvqTowM06YPD5GLVOL5OO1WiLcWlYeA+WAx20Xiu72BDc
         B/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=I5exx/RB+d0Ig7pXuqKbMzRv7rQoprfE6EMWAxPn3vk=;
        b=jhyDjfeBK6xfFuMXPFnhWSn7R8Lmt5XEqOzcArNqKhYCmkP87y9Zo/ujcNKIyLo3Io
         5z2EeQpDeBvjX/B1xAto1DvSc8zhKgjsX2tqh5GLmKknPTze8gEL7ZQH0v0weDc8LTCm
         oLvupIefcwqfw/A1aDiPC4P6pavKb4/BFLYkJ/fP9HHEwKK9sWnvDU0SlOoIJ7Vr/L5J
         1OqKrCTPvfmhPl6d55aTrah+NeSbIYzy3os8Pu6qYNPHPS5gvT0c+mQa96O08a16z3v3
         U+2xKKwl9d5lSvWcGQnEkrDAMqGiNZz5c+vEInmgWGIWPREvi1dmGLPPjNoLhPjidqbV
         eEvg==
X-Gm-Message-State: AOAM533dGzURFgUBsq32iYMaCtV8+S5N0B1eahidriepK7J7/XGx6Dyj
        pYGHZwLrN8bDWB8E/FXBp0y2GA==
X-Google-Smtp-Source: ABdhPJxVeMek9ygr1gEJ2F2+WMGJOZmPNv0PKkIoA3/xhuB910rYtwVdeKFiPVghs/O8sDNlYZOp5w==
X-Received: by 2002:a17:90b:17c7:b0:1c7:c616:6eb0 with SMTP id me7-20020a17090b17c700b001c7c6166eb0mr4632866pjb.144.1648709847477;
        Wed, 30 Mar 2022 23:57:27 -0700 (PDT)
Received: from FVFYT0MHHV2J.bytedance.net ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id d8-20020a056a00198800b004fab740dbe6sm26169846pfl.15.2022.03.30.23.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 23:57:27 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     will@kernel.org, akpm@linux-foundation.org, david@redhat.com,
        bodeddub@amazon.com, osalvador@suse.de, mike.kravetz@oracle.com,
        rientjes@google.com, mark.rutland@arm.com, catalin.marinas@arm.com,
        james.morse@arm.com, 21cnbao@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v4 1/2] mm: hugetlb_vmemmap: introduce ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP
Date:   Thu, 31 Mar 2022 14:56:39 +0800
Message-Id: <20220331065640.5777-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The feature of minimizing overhead of struct page associated with each
HugeTLB page is implemented on x86_64, however, the infrastructure of
this feature is already there, we could easily enable it for other
architectures.  Introduce ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP for other
architectures to be easily enabled.  Just select this config if they
want to enable this feature.

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 arch/x86/Kconfig |  1 +
 fs/Kconfig       | 10 +++++++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 9f5bd41bf660..e69d42528542 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -119,6 +119,7 @@ config X86
 	select ARCH_WANTS_DYNAMIC_TASK_STRUCT
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_WANT_HUGE_PMD_SHARE
+	select ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP	if X86_64
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANTS_THP_SWAP		if X86_64
 	select ARCH_HAS_PARANOID_L1D_FLUSH
diff --git a/fs/Kconfig b/fs/Kconfig
index 6c7dc1387beb..f6db2af33738 100644
--- a/fs/Kconfig
+++ b/fs/Kconfig
@@ -245,9 +245,17 @@ config HUGETLBFS
 config HUGETLB_PAGE
 	def_bool HUGETLBFS
 
+#
+# Select this config option from the architecture Kconfig, if it is preferred
+# to enable the feature of minimizing overhead of struct page associated with
+# each HugeTLB page.
+#
+config ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP
+	bool
+
 config HUGETLB_PAGE_FREE_VMEMMAP
 	def_bool HUGETLB_PAGE
-	depends on X86_64
+	depends on ARCH_WANT_HUGETLB_PAGE_FREE_VMEMMAP
 	depends on SPARSEMEM_VMEMMAP
 
 config HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON
-- 
2.11.0

