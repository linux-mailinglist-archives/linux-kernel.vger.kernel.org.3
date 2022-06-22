Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01A8C55513D
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359333AbiFVQXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376548AbiFVQWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:22:50 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F03B3FBC6
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655914966; x=1687450966;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BkKX7P64WZcLjWfGUU0r+pKJ4TB5dZSWjwFRGFzJ7l0=;
  b=k8v35Rv1FOCjbbv5D9yoCHVzGkGKic4MINdIqcpVBrtWvPdkJZ/HcXJW
   LANHyeH7JMaPFxmPVkI+rw/y7NxTrexcoDH7XrVzwfHIU+R8M0byuCQ2p
   pYBXfeARdbkpxA74QVtTRa2pXFe/zPWAZbdfWF6u9I5V4u1+1psDc7a56
   +2bpPDvYAEythIJgf/rxIrEKaSqwpf+bSOiNVzPng53A/5Ygo3oxXvxMZ
   gk6EZFX2T1glTTxYDIoeA9J7og/DYx5velU7qn9bWue5YMB5plmupNiZU
   36xJo+OKwb37Aw2bwntf3kMjJsPdANmfUt09dDZYMrxiK1c7GUZc7lxEN
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="278013494"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="278013494"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 09:22:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="592264460"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jun 2022 09:22:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 6060572D; Wed, 22 Jun 2022 19:22:43 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 6/8] x86/mm: Provide ARCH_GET_UNTAG_MASK and ARCH_ENABLE_TAGGED_ADDR
Date:   Wed, 22 Jun 2022 19:22:28 +0300
Message-Id: <20220622162230.83474-7-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220622162230.83474-1-kirill.shutemov@linux.intel.com>
References: <20220622162230.83474-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a couple of arch_prctl() handles:

 - ARCH_ENABLE_TAGGED_ADDR enabled LAM. The argument is required number
   of tag bits. It is rounded up to the nearest LAM mode that can
   provide it. For now only LAM_U57 is supported, with 6 tag bits.

 - ARCH_GET_UNTAG_MASK returns untag mask. It can indicates where tag
   bits located in the address.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/uapi/asm/prctl.h |  3 ++
 arch/x86/kernel/process_64.c      | 55 ++++++++++++++++++++++++++++++-
 2 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 500b96e71f18..38164a05c23c 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -20,4 +20,7 @@
 #define ARCH_MAP_VDSO_32		0x2002
 #define ARCH_MAP_VDSO_64		0x2003
 
+#define ARCH_GET_UNTAG_MASK		0x4001
+#define ARCH_ENABLE_TAGGED_ADDR		0x4002
+
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 1962008fe743..e328b91d1492 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -742,6 +742,55 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
 }
 #endif
 
+static void enable_lam_func(void *mm)
+{
+	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
+
+	if (loaded_mm != mm)
+		return;
+
+	/* Counterpart of smp_wmb() in prctl_enable_tagged_addr() */
+	smp_rmb();
+
+	/* Update CR3 to get LAM active on the CPU */
+	switch_mm(loaded_mm, loaded_mm, current);
+}
+
+static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
+{
+	int ret = 0;
+
+	if (!cpu_feature_enabled(X86_FEATURE_LAM))
+		return -ENODEV;
+
+	mutex_lock(&mm->context.lock);
+
+	/* Already enabled? */
+	if (mm->context.lam_cr3_mask) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	if (!nr_bits) {
+		ret = -EINVAL;
+		goto out;
+	} else if (nr_bits <= 6) {
+		mm->context.lam_cr3_mask = X86_CR3_LAM_U57;
+		mm->context.untag_mask =  ~GENMASK(62, 57);
+	} else {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	/* Make lam_cr3_mask and untag_mask visible on other CPUs */
+	smp_wmb();
+
+	on_each_cpu_mask(mm_cpumask(mm), enable_lam_func, mm, true);
+out:
+	mutex_unlock(&mm->context.lock);
+	return ret;
+}
+
 long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 {
 	int ret = 0;
@@ -829,7 +878,11 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 	case ARCH_MAP_VDSO_64:
 		return prctl_map_vdso(&vdso_image_64, arg2);
 #endif
-
+	case ARCH_GET_UNTAG_MASK:
+		return put_user(task->mm->context.untag_mask,
+				(unsigned long __user *)arg2);
+	case ARCH_ENABLE_TAGGED_ADDR:
+		return prctl_enable_tagged_addr(task->mm, arg2);
 	default:
 		ret = -EINVAL;
 		break;
-- 
2.35.1

