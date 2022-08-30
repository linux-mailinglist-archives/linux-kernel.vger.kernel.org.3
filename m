Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD1B75A58BB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 03:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229804AbiH3BCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 21:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiH3BBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 21:01:38 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC8F9F771
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 18:01:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661821297; x=1693357297;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gJsP/Lgemx2usecScQbMEyqztN6q+W6cu2oGGdXpnWc=;
  b=ljDLY+MPAUAoXZIQxRmB7r76x13jPQkX0l3EnLOevXexR/32Np3l/3Kr
   X80ivqW5yQWq33lm9bcQe/Br1LE8evtEp73CB+YFZJmt6puYmPKl/Y16l
   hLxzjjoa9QmpL1KV+EuH6OHO6v7JOrSrEsEXoErcsYAPtGRVwhelb97MR
   76+1Wu8c93oPOQENKX6rciu82lSuj/ZbV6ZncR+5BtRpVB0CytV/ysyTg
   X6BEd/IxJpS3Z31V43a48WuC7z+cHbJmMosoYsKkr3GgVyPL32YZZjXRE
   2Bdx5QqlM5VrefPKea5wCZFbD0lLQNzkTinTqe5KHKv9gn2cdz8Dqk7xq
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="282015880"
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="282015880"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 18:01:36 -0700
X-IronPort-AV: E=Sophos;i="5.93,273,1654585200"; 
   d="scan'208";a="715096951"
Received: from fpalamon-mobl.amr.corp.intel.com (HELO box.shutemov.name) ([10.252.54.23])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2022 18:01:33 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 9588610419A; Tue, 30 Aug 2022 04:01:24 +0300 (+03)
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
Subject: [PATCHv8 06/11] x86/mm: Provide arch_prctl() interface for LAM
Date:   Tue, 30 Aug 2022 04:00:59 +0300
Message-Id: <20220830010104.1282-7-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220830010104.1282-1-kirill.shutemov@linux.intel.com>
References: <20220830010104.1282-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

 - ARCH_GET_MAX_TAG_BITS returns the maximum tag bits user can request.
   Zero if LAM is not supported.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Tested-by: Alexander Potapenko <glider@google.com>
Reviewed-by: Alexander Potapenko <glider@google.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/uapi/asm/prctl.h |  4 ++
 arch/x86/kernel/process_64.c      | 64 ++++++++++++++++++++++++++++++-
 2 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 500b96e71f18..a31e27b95b19 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -20,4 +20,8 @@
 #define ARCH_MAP_VDSO_32		0x2002
 #define ARCH_MAP_VDSO_64		0x2003
 
+#define ARCH_GET_UNTAG_MASK		0x4001
+#define ARCH_ENABLE_TAGGED_ADDR		0x4002
+#define ARCH_GET_MAX_TAG_BITS		0x4003
+
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 1962008fe743..455601a3cc3f 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -742,6 +742,59 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
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
+#define LAM_U57_BITS 6
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
+	} else if (nr_bits <= LAM_U57_BITS) {
+		mm->context.lam_cr3_mask = X86_CR3_LAM_U57;
+		mm->context.untag_mask =  ~GENMASK(62, 57);
+	} else {
+		ret = -EINVAL;
+		goto out;
+	}
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
@@ -829,7 +882,16 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 	case ARCH_MAP_VDSO_64:
 		return prctl_map_vdso(&vdso_image_64, arg2);
 #endif
-
+	case ARCH_GET_UNTAG_MASK:
+		return put_user(task->mm->context.untag_mask,
+				(unsigned long __user *)arg2);
+	case ARCH_ENABLE_TAGGED_ADDR:
+		return prctl_enable_tagged_addr(task->mm, arg2);
+	case ARCH_GET_MAX_TAG_BITS:
+		if (!cpu_feature_enabled(X86_FEATURE_LAM))
+			return put_user(0, (unsigned long __user *)arg2);
+		else
+			return put_user(LAM_U57_BITS, (unsigned long __user *)arg2);
 	default:
 		ret = -EINVAL;
 		break;
-- 
2.35.1

