Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCA656600B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 02:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbiGEANp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 20:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbiGEANn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 20:13:43 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6656336
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 17:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656980021; x=1688516021;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NGr/La54zVRmr7IapDE8sb1OM85ZTxwA3yns3YUAQOQ=;
  b=kRybR9fRQ9pbZEaedn/iILygMqGUh9Gw/8LPT1VuCdolVjye4UHlJK6K
   4dP0usQvH9ciN24xeqpgFm9Ks7ma+kkiVsV2BXuuih0N6NQ4DCYC/MzoG
   zpGZW6+K7m0TN/oyz8RGqFEvvbS9ghSk2IYuXuXN1+ImPoG+VmlRsgxm9
   407fieJbwMe4OROn0d6dQZr9ZLOn/Ul00JLDqc/I0y5feuSrJUyNzLRmq
   SGccgdFY5g01578Eax97ghoWWTP4OA+CnxiTa/zwUoAXdEpoXLQTN9zxp
   ZJIOgVdPG8fic0lJXbPvt5uYCFAKw02B4H6Ln1jEWs8nk7c4mCi9+5ORT
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="281972744"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="281972744"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jul 2022 17:13:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="590204345"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 04 Jul 2022 17:13:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 74540136; Tue,  5 Jul 2022 03:13:44 +0300 (EEST)
Date:   Tue, 5 Jul 2022 03:13:44 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
        "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
        "glider@google.com" <glider@google.com>,
        "dvyukov@google.com" <dvyukov@google.com>,
        "H.J. Lu" <hjl.tools@gmail.com>, Andi Kleen <ak@linux.intel.com>,
        Rick P Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv3 5/8] x86/uaccess: Provide untagged_addr() and remove
 tags before address check
Message-ID: <20220705001344.euyapepzjhrz5sid@black.fi.intel.com>
References: <20220610143527.22974-1-kirill.shutemov@linux.intel.com>
 <20220610143527.22974-6-kirill.shutemov@linux.intel.com>
 <53d41f54-28ad-023c-537f-281cc2c40ae9@kernel.org>
 <20220629004257.x3pyoydmtk2lhrnx@black.fi.intel.com>
 <7c8381b3-c71b-45e8-a162-c9701dabcc9b@www.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7c8381b3-c71b-45e8-a162-c9701dabcc9b@www.fastmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 07:38:20PM -0700, Andy Lutomirski wrote:
> 
> 
> On Tue, Jun 28, 2022, at 5:42 PM, Kirill A. Shutemov wrote:
> > On Tue, Jun 28, 2022 at 04:40:48PM -0700, Andy Lutomirski wrote:
> >> On 6/10/22 07:35, Kirill A. Shutemov wrote:
> >> > untagged_addr() is a helper used by the core-mm to strip tag bits and
> >> > get the address to the canonical shape. In only handles userspace
> >> > addresses. The untagging mask is stored in mmu_context and will be set
> >> > on enabling LAM for the process.
> >> > 
> >> > The tags must not be included into check whether it's okay to access the
> >> > userspace address.
> >> > 
> >> > Strip tags in access_ok().
> >> 
> >> What is the intended behavior for an access that spans a tag boundary?
> >
> > You mean if 'addr' passed to access_ok() is below 47- or 56-bit but 'addr'
> > + 'size' overflows into tags? If is not valid access and the current
> > implementation works correctly.
> >
> >> Also, at the risk of a potentially silly question, why do we need to strip
> >> the tag before access_ok()?  With LAM, every valid tagged user address is
> >> also a valid untagged address, right?  (There is no particular need to
> >> enforce the actual value of TASK_SIZE_MAX on *access*, just on mmap.)
> >> 
> >> IOW, wouldn't it be sufficient, and probably better than what we have now,
> >> to just check that the entire range has the high bit clear?
> >
> > No. We do things to addresses on kernel side beyond dereferencing them.
> > Like comparing addresses have to make sense. find_vma() has to find
> > relevant mapping and so on. 
> 
> I think you’re misunderstanding me. Of course things like find_vma()
> need to untag the address. (But things like munmap, IMO, ought not
> accept tagged addresses.)
> 
> But I’m not talking about that at all. I’m asking why we need to untag
> an address for access_ok.  In the bad old days, access_ok checked that a
> range was below a *variable* cutoff. But set_fs() is gone, and I don’t
> think this is needed any more.
> 
> With some off-the-cuff bit hackery, I think it ought to be sufficient to
> calculate addr+len and fail if the overflow or sign bits get set. If LAM
> is off, we could calculate addr | len and fail if either of the top two
> bits is set, but LAM may not let us get away with that.  The general
> point being that, on x86 (as long as we ignore AMD’s LAM-like feature)
> an address is a user address if the top bit is clear. Whether that
> address is canonical or not or will translate or not is a separate
> issue. (And making this change would require allowing uaccess to #GP,
> which requires some care.)
> 
> What do you think?

I think it can work. Below is my first take on this. It is raw and
requires more work.

You talk about access_ok(), but I also checked what has to be done in
get_user()/put_user() path. Not sure it is a good idea (but it seems
work).

The basic idea is to OR start and end of the range and check that MSB is
clear.

I reworked array_index_mask_nospec() thing to make the address all-ones if
it is ouside of the user range. It should work to stop speculation as well
as making it zero as we do now. 

The patch as it is breaks 32-bit. It has to be handled separately.

Any comments?

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 803241dfc473..53c6f86b036f 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -45,6 +45,12 @@ static inline bool pagefault_disabled(void);
 #define untagged_ptr(mm, ptr)	(ptr)
 #endif
 
+#define __access_ok(ptr, size)						\
+({									\
+	unsigned long addr = (unsigned long)(ptr);			\
+	!((addr | (size) | addr + (size)) >> (BITS_PER_LONG - 1));	\
+})
+
 /**
  * access_ok - Checks if a user space pointer is valid
  * @addr: User space pointer to start of block to check
@@ -62,10 +68,10 @@ static inline bool pagefault_disabled(void);
  * Return: true (nonzero) if the memory block may be valid, false (zero)
  * if it is definitely invalid.
  */
-#define access_ok(addr, size)					\
+#define access_ok(addr, size)						\
 ({									\
 	WARN_ON_IN_IRQ();						\
-	likely(__access_ok(untagged_addr(current->mm, addr), size));	\
+	likely(__access_ok(addr, size));				\
 })
 
 #include <asm-generic/access_ok.h>
@@ -150,13 +156,7 @@ extern int __get_user_bad(void);
  * Return: zero on success, or -EFAULT on error.
  * On error, the variable @x is set to zero.
  */
-#define get_user(x,ptr)							\
-({									\
-	__typeof__(*(ptr)) __user *__ptr_clean;				\
-	__ptr_clean = untagged_ptr(current->mm, ptr);			\
-	might_fault();							\
-	do_get_user_call(get_user,x,__ptr_clean);			\
-})
+#define get_user(x,ptr) ({ might_fault(); do_get_user_call(get_user,x,ptr); })
 
 /**
  * __get_user - Get a simple variable from user space, with less checking.
@@ -253,12 +253,7 @@ extern void __put_user_nocheck_8(void);
  *
  * Return: zero on success, or -EFAULT on error.
  */
-#define put_user(x, ptr) ({						\
-	__typeof__(*(ptr)) __user *__ptr_clean;				\
-	__ptr_clean = untagged_ptr(current->mm, ptr);			\
-	might_fault();							\
-	do_put_user_call(put_user,x,__ptr_clean);			\
-})
+#define put_user(x, ptr) ({ might_fault(); do_put_user_call(put_user,x,ptr); })
 
 /**
  * __put_user - Write a simple value into user space, with less checking.
diff --git a/arch/x86/lib/getuser.S b/arch/x86/lib/getuser.S
index b70d98d79a9d..e526ae6ff844 100644
--- a/arch/x86/lib/getuser.S
+++ b/arch/x86/lib/getuser.S
@@ -37,22 +37,13 @@
 
 #define ASM_BARRIER_NOSPEC ALTERNATIVE "", "lfence", X86_FEATURE_LFENCE_RDTSC
 
-#ifdef CONFIG_X86_5LEVEL
-#define LOAD_TASK_SIZE_MINUS_N(n) \
-	ALTERNATIVE __stringify(mov $((1 << 47) - 4096 - (n)),%rdx), \
-		    __stringify(mov $((1 << 56) - 4096 - (n)),%rdx), X86_FEATURE_LA57
-#else
-#define LOAD_TASK_SIZE_MINUS_N(n) \
-	mov $(TASK_SIZE_MAX - (n)),%_ASM_DX
-#endif
-
 	.text
 SYM_FUNC_START(__get_user_1)
-	LOAD_TASK_SIZE_MINUS_N(0)
-	cmp %_ASM_DX,%_ASM_AX
-	jae bad_get_user
-	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
-	and %_ASM_DX, %_ASM_AX
+	mov %_ASM_AX, %_ASM_DX
+	shl $1, %_ASM_DX
+	jb bad_get_user
+	sbb %_ASM_DX, %_ASM_DX
+	or %_ASM_DX, %_ASM_AX
 	ASM_STAC
 1:	movzbl (%_ASM_AX),%edx
 	xor %eax,%eax
@@ -62,11 +53,13 @@ SYM_FUNC_END(__get_user_1)
 EXPORT_SYMBOL(__get_user_1)
 
 SYM_FUNC_START(__get_user_2)
-	LOAD_TASK_SIZE_MINUS_N(1)
-	cmp %_ASM_DX,%_ASM_AX
-	jae bad_get_user
-	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
-	and %_ASM_DX, %_ASM_AX
+	mov %_ASM_AX, %_ASM_DX
+	add $1, %_ASM_DX
+	or %_ASM_AX, %_ASM_DX
+	shl $1, %_ASM_DX
+	jb bad_get_user
+	sbb %_ASM_DX, %_ASM_DX
+	or %_ASM_DX, %_ASM_AX
 	ASM_STAC
 2:	movzwl (%_ASM_AX),%edx
 	xor %eax,%eax
@@ -76,11 +69,13 @@ SYM_FUNC_END(__get_user_2)
 EXPORT_SYMBOL(__get_user_2)
 
 SYM_FUNC_START(__get_user_4)
-	LOAD_TASK_SIZE_MINUS_N(3)
-	cmp %_ASM_DX,%_ASM_AX
-	jae bad_get_user
-	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
-	and %_ASM_DX, %_ASM_AX
+	mov %_ASM_AX, %_ASM_DX
+	add $3, %_ASM_DX
+	or %_ASM_AX, %_ASM_DX
+	shl $1, %_ASM_DX
+	jb bad_get_user
+	sbb %_ASM_DX, %_ASM_DX
+	or %_ASM_DX, %_ASM_AX
 	ASM_STAC
 3:	movl (%_ASM_AX),%edx
 	xor %eax,%eax
@@ -91,22 +86,26 @@ EXPORT_SYMBOL(__get_user_4)
 
 SYM_FUNC_START(__get_user_8)
 #ifdef CONFIG_X86_64
-	LOAD_TASK_SIZE_MINUS_N(7)
-	cmp %_ASM_DX,%_ASM_AX
-	jae bad_get_user
-	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
-	and %_ASM_DX, %_ASM_AX
+	mov %_ASM_AX, %_ASM_DX
+	add $7, %_ASM_DX
+	or %_ASM_AX, %_ASM_DX
+	shl $1, %_ASM_DX
+	jb bad_get_user
+	sbb %_ASM_DX, %_ASM_DX
+	or %_ASM_DX, %_ASM_AX
 	ASM_STAC
 4:	movq (%_ASM_AX),%rdx
 	xor %eax,%eax
 	ASM_CLAC
 	RET
 #else
-	LOAD_TASK_SIZE_MINUS_N(7)
-	cmp %_ASM_DX,%_ASM_AX
-	jae bad_get_user_8
-	sbb %_ASM_DX, %_ASM_DX		/* array_index_mask_nospec() */
-	and %_ASM_DX, %_ASM_AX
+	mov %_ASM_AX, %_ASM_DX
+	add $7, %_ASM_DX
+	or %_ASM_AX, %_ASM_DX
+	shl $1, %_ASM_DX
+	jb bad_get_user
+	sbb %_ASM_DX, %_ASM_DX
+	or %_ASM_DX, %_ASM_AX
 	ASM_STAC
 4:	movl (%_ASM_AX),%edx
 5:	movl 4(%_ASM_AX),%ecx
diff --git a/arch/x86/lib/putuser.S b/arch/x86/lib/putuser.S
index b7dfd60243b7..eb7c4396cb1e 100644
--- a/arch/x86/lib/putuser.S
+++ b/arch/x86/lib/putuser.S
@@ -33,20 +33,11 @@
  * as they get called from within inline assembly.
  */
 
-#ifdef CONFIG_X86_5LEVEL
-#define LOAD_TASK_SIZE_MINUS_N(n) \
-	ALTERNATIVE __stringify(mov $((1 << 47) - 4096 - (n)),%rbx), \
-		    __stringify(mov $((1 << 56) - 4096 - (n)),%rbx), X86_FEATURE_LA57
-#else
-#define LOAD_TASK_SIZE_MINUS_N(n) \
-	mov $(TASK_SIZE_MAX - (n)),%_ASM_BX
-#endif
-
 .text
 SYM_FUNC_START(__put_user_1)
-	LOAD_TASK_SIZE_MINUS_N(0)
-	cmp %_ASM_BX,%_ASM_CX
-	jae .Lbad_put_user
+	mov %_ASM_CX, %_ASM_BX
+	shl $1, %_ASM_BX
+	jb .Lbad_put_user
 SYM_INNER_LABEL(__put_user_nocheck_1, SYM_L_GLOBAL)
 	ENDBR
 	ASM_STAC
@@ -59,9 +50,11 @@ EXPORT_SYMBOL(__put_user_1)
 EXPORT_SYMBOL(__put_user_nocheck_1)
 
 SYM_FUNC_START(__put_user_2)
-	LOAD_TASK_SIZE_MINUS_N(1)
-	cmp %_ASM_BX,%_ASM_CX
-	jae .Lbad_put_user
+	mov %_ASM_CX, %_ASM_BX
+	add $1, %_ASM_BX
+	or %_ASM_CX, %_ASM_BX
+	shl $1, %_ASM_BX
+	jb .Lbad_put_user
 SYM_INNER_LABEL(__put_user_nocheck_2, SYM_L_GLOBAL)
 	ENDBR
 	ASM_STAC
@@ -74,9 +67,11 @@ EXPORT_SYMBOL(__put_user_2)
 EXPORT_SYMBOL(__put_user_nocheck_2)
 
 SYM_FUNC_START(__put_user_4)
-	LOAD_TASK_SIZE_MINUS_N(3)
-	cmp %_ASM_BX,%_ASM_CX
-	jae .Lbad_put_user
+	mov %_ASM_CX, %_ASM_BX
+	add $3, %_ASM_BX
+	or %_ASM_CX, %_ASM_BX
+	shl $1, %_ASM_BX
+	jb .Lbad_put_user
 SYM_INNER_LABEL(__put_user_nocheck_4, SYM_L_GLOBAL)
 	ENDBR
 	ASM_STAC
@@ -89,9 +84,11 @@ EXPORT_SYMBOL(__put_user_4)
 EXPORT_SYMBOL(__put_user_nocheck_4)
 
 SYM_FUNC_START(__put_user_8)
-	LOAD_TASK_SIZE_MINUS_N(7)
-	cmp %_ASM_BX,%_ASM_CX
-	jae .Lbad_put_user
+	mov %_ASM_CX, %_ASM_BX
+	add $7, %_ASM_BX
+	or %_ASM_CX, %_ASM_BX
+	shl $1, %_ASM_BX
+	jb .Lbad_put_user
 SYM_INNER_LABEL(__put_user_nocheck_8, SYM_L_GLOBAL)
 	ENDBR
 	ASM_STAC
-- 
 Kirill A. Shutemov
