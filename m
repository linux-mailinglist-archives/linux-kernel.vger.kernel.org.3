Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E2B5729BA
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 01:14:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234026AbiGLXN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 19:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233869AbiGLXNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 19:13:34 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D49CC78A
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 16:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657667610; x=1689203610;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OJDuDjvUGA+HqDGHfFlodTRAfB+eKXuXU7w3WDfuVQk=;
  b=LIrmgR1GR8S075KU0qsh1B8AeO+bwqgkGbW2c8vHlXNQIIv6f/GBI+zD
   rYuKCm908JS9M7IR4n5QCt54Hlk8QhyJHPUz3h4opYn3FYvYF8lJa4BL0
   J0A4e7fBxaF+069ymX/a33rlyWtK5S+u4OPu2YsMVdhLbkVPtaqaoctrV
   aZKZLvasPeqyEB/4AU3nbxFB/ttFRgiQhX1UwKbQmelMH/hY/aAYHzQ5Z
   UK36GmgnGURJPEM6sx0VzUm47iH5+AjlZjX5vmjbqauhixogFqO890KIk
   gcFszZsfrR8o4lAmWfw+A7WeY0F+whRghgRxjbj3K/zQSTgREJOyJGXE7
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="285808443"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="285808443"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 16:13:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="737658278"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga001.fm.intel.com with ESMTP; 12 Jul 2022 16:13:26 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id EC3853E3; Wed, 13 Jul 2022 02:13:29 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv5 06/13] x86/mm: Provide ARCH_GET_UNTAG_MASK and ARCH_ENABLE_TAGGED_ADDR
Date:   Wed, 13 Jul 2022 02:13:21 +0300
Message-Id: <20220712231328.5294-7-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220712231328.5294-1-kirill.shutemov@linux.intel.com>
References: <20220712231328.5294-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 arch/x86/kernel/process_64.c      | 60 ++++++++++++++++++++++++++++++-
 2 files changed, 62 insertions(+), 1 deletion(-)

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
index 1962008fe743..82a19168bfa4 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -742,6 +742,60 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
 }
 #endif
 
+static void enable_lam_func(void *mm)
+{
+	struct mm_struct *loaded_mm = this_cpu_read(cpu_tlbstate.loaded_mm);
+	unsigned long lam_mask;
+	unsigned long cr3;
+
+	if (loaded_mm != mm)
+		return;
+
+	lam_mask = READ_ONCE(loaded_mm->context.lam_cr3_mask);
+
+	/* Update CR3 to get LAM active on the CPU */
+	cr3 = __read_cr3();
+	cr3 &= ~(X86_CR3_LAM_U48 | X86_CR3_LAM_U57);
+	cr3 |= lam_mask;
+	write_cr3(cr3);
+	set_tlbstate_cr3_lam_mask(lam_mask);
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
+	smp_mb();
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
@@ -829,7 +883,11 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
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

