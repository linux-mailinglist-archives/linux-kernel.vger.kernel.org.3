Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19E85AC1E0
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 02:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbiIDAkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 20:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiIDAkD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 20:40:03 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13E632BB5
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 17:40:01 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 012E53200805;
        Sat,  3 Sep 2022 20:39:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 03 Sep 2022 20:39:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shutemov.name;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1662251996; x=1662338396; bh=jO
        iB6BRciZiGUtx6imc89hidDkCwOtUwyTVUDvZtpKY=; b=QcCki5X70hRi8ne0Ie
        ep9DKNyIV3eDFlbK/8J/hYsHpFKFUuphQ6Lm0Kq9pGsCaoO8p76OZRmarKCtgAXy
        FZh9v5yYr9/BaaSPVgslC9fNU1Y8KUsAlqoRBwQc9Lh2C29QQrZs76hnYQ8+oCA8
        5Am0laq87wowypq3kgEhs5LQFGPSLcLU+MG9wHbvx4QPE0B1+wrb6hz2HgJmEaHq
        Hpv+1IWSWp5OAPw+vabDebxPHzuAy5NQPnp0TAJwcHgbpjUOnEjBiKTQJamA+Su+
        mSXxgRbACJhWlUd1prpTsmiV0EOqUQYModD17t3yN98FrI3Y2ZAdJIeUyEI/tcj8
        3Zkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1662251996; x=1662338396; bh=jOiB6BRciZiGUtx6imc89hidDkCw
        OtUwyTVUDvZtpKY=; b=soY9uNyEBbLul3xQvbs06KXmQ8lc426Ehqi7iLpXdb/3
        OnCiybNwfavVL7Kj0nGEyNo+5Xb4PZzCb4HJuZr0QdUxUOZUw5po5EMCRT2kBQiU
        Dis2eFB5TJDCRCiaH+ZQRDhHNIpu8VlG8HRZmp2eyix7WQtW1+lxtDmcbpV1MxWX
        vGKVdlGWJxryJELsbD1Lw9MXHXcDePXfn0wLv82WWG7tr3dRqX3SZKxNe2WysX/3
        3DiEr2D2YIgILWAVHDQnv4tXgBrRaVKMY1dZGRiejLAevj4iBQryGcsZeFUSO1Zd
        ZIXBv+2g7Lm8kOgxy9oVX6jR9RqvbBD7wn+4/JFGWw==
X-ME-Sender: <xms:2_MTY-mvG8YLNkkXJBvBhryzU5PiM1GkpuQ5G8yVeYzBBXbPVxaezQ>
    <xme:2_MTY11Yl7oqYydaK6UBdoDYVquvljv08hU_xg3omjcRgYF2KsTPQ7LUZsNqnOYZW
    e-wxOYXkG1d6snM5wk>
X-ME-Received: <xmr:2_MTY8qF8H6qWOopfKHGU5SqUXttsydZuMROtc-iRGNZ65IJtoV4wfUSBLeGTwwK0Yzz5A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdelfedgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdttddttddtvdenucfhrhhomhepfdfmihhr
    ihhllhcutedrucfuhhhuthgvmhhovhdfuceokhhirhhilhhlsehshhhuthgvmhhovhdrnh
    grmhgvqeenucggtffrrghtthgvrhhnpefhieeghfdtfeehtdeftdehgfehuddtvdeuheet
    tddtheejueekjeegueeivdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehkihhrihhllhesshhhuhhtvghmohhvrdhnrghmvg
X-ME-Proxy: <xmx:3PMTYynft-vOt4thz3zZzqDIMpx0zADNMeE-P-WfdvdJfTQ-a2EEng>
    <xmx:3PMTY82e2BMTDG3GMyclt6X1663obXTWTDQ4ame8UhVgsLo3H8tCbw>
    <xmx:3PMTY5tnyr0yrB65qTEsCtZav-3RwjrLPU56OPQNnri7FRVbwHZu6g>
    <xmx:3PMTY05R6GRak06jMSYhoimNaNi-Ni9ez_8CQVTIrwELAYZx-iZJdg>
Feedback-ID: ie3994620:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 3 Sep 2022 20:39:55 -0400 (EDT)
Received: by box.shutemov.name (Postfix, from userid 1000)
        id AAB0B104A03; Sun,  4 Sep 2022 03:39:52 +0300 (+03)
Date:   Sun, 4 Sep 2022 03:39:52 +0300
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
To:     Ashok Raj <ashok_raj@linux.intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Taras Madan <tarasmadan@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Jacon Jun Pan <jacob.jun.pan@intel.com>,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCHv8 00/11] Linear Address Masking enabling
Message-ID: <20220904003952.fheisiloilxh3mpo@box.shutemov.name>
References: <20220830010104.1282-1-kirill.shutemov@linux.intel.com>
 <YxDvpLb77lwb8zaT@araj-dh-work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxDvpLb77lwb8zaT@araj-dh-work>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 01, 2022 at 05:45:08PM +0000, Ashok Raj wrote:
> Hi Kirill,
> 
> On Tue, Aug 30, 2022 at 04:00:53AM +0300, Kirill A. Shutemov wrote:
> > Linear Address Masking[1] (LAM) modifies the checking that is applied to
> > 64-bit linear addresses, allowing software to use of the untranslated
> > address bits for metadata.
> 
> We discussed this internally, but didn't bubble up here.
> 
> Given that we are working on enabling Shared Virtual Addressing (SVA)
> within the IOMMU. This permits user to share VA directly with the device,
> and the device can participate even in fixing page-faults and such.
> 
> IOMMU enforces canonical addressing, since we are hijacking the top order
> bits for meta-data, it will fail sanity check and we would return a failure
> back to device on any page-faults from device. 
> 
> It also complicates how device TLB and ATS work, and needs some major
> improvements to detect device capability to accept tagged pointers, adjust
> the devtlb to act accordingly. 
> 
> 
> Both are orthogonal features, but there is an intersection of both
> that are fundamentally incompatible.
> 
> Its even more important, since an application might be using SVA under the
> cover provided by some library that's used without their knowledge.
> 
> The path would be:
> 
> 1. Ensure both LAM and SVM are incompatible by design, without major
>    changes.
>    	- If LAM is enabled already and later SVM enabling is requested by
> 	  user, that should fail. and Vice versa.
> 	- Provide an API to user to ask for opt-out. Now they know they
> 	  must sanitize the pointers before sending to device, or the
> 	  working set is already isolated and needs no work.

The patch below implements something like this. It is PoC, build-tested only.

To be honest, I hate it. It is clearly a layering violation. It feels
dirty. But I don't see any better way as we tie orthogonal features
together.

Also I have no idea how to make forced PASID allocation if LAM enabled.
What the API has to look like?

Any comments?

> 2. I suppose for any syscalls that take tagged pointers you would maybe
>    relax checks for how many bits to ignore for canonicallity. This is
>    required so user don't need to do the same for everything sanitization
>    before every syscall. 

I'm not quite follow this. For syscalls that allow tagged pointers, we do
untagged_addr() now. Not sure what else needed.

> If you have it fail, the library might choose a less optimal path if one is
> available.
> 
> Cheers,
> Ashok

diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index a31e27b95b19..e5c04ced36c9 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -23,5 +23,6 @@
 #define ARCH_GET_UNTAG_MASK		0x4001
 #define ARCH_ENABLE_TAGGED_ADDR		0x4002
 #define ARCH_GET_MAX_TAG_BITS		0x4003
+#define ARCH_ENABLE_TAGGED_ADDR_FORCED	0x4004
 
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 337f80a0862f..7d89a2fd1a55 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -774,7 +774,8 @@ static bool lam_u48_allowed(void)
 #define LAM_U48_BITS 15
 #define LAM_U57_BITS 6
 
-static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
+static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits,
+				    bool forced)
 {
 	int ret = 0;
 
@@ -793,6 +794,11 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 		goto out;
 	}
 
+	if (pasid_valid(mm->pasid) && !forced) {
+		ret = -EBUSY;
+		goto out;
+	}
+
 	if (!nr_bits) {
 		ret = -EINVAL;
 		goto out;
@@ -910,7 +916,9 @@ long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 		return put_user(task->mm->context.untag_mask,
 				(unsigned long __user *)arg2);
 	case ARCH_ENABLE_TAGGED_ADDR:
-		return prctl_enable_tagged_addr(task->mm, arg2);
+		return prctl_enable_tagged_addr(task->mm, arg2, false);
+	case ARCH_ENABLE_TAGGED_ADDR_FORCED:
+		return prctl_enable_tagged_addr(task->mm, arg2, true);
 	case ARCH_GET_MAX_TAG_BITS: {
 		int nr_bits;
 
diff --git a/drivers/iommu/iommu-sva-lib.c b/drivers/iommu/iommu-sva-lib.c
index 106506143896..a6ec17de1937 100644
--- a/drivers/iommu/iommu-sva-lib.c
+++ b/drivers/iommu/iommu-sva-lib.c
@@ -4,6 +4,7 @@
  */
 #include <linux/mutex.h>
 #include <linux/sched/mm.h>
+#include <asm/mmu_context.h>
 
 #include "iommu-sva-lib.h"
 
@@ -32,6 +33,15 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 		return -EINVAL;
 
 	mutex_lock(&iommu_sva_lock);
+
+	/* Serialize against LAM enabling */
+	mutex_lock(&mm->context.lock);
+
+	if (mm_lam_cr3_mask(mm)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
 	/* Is a PASID already associated with this mm? */
 	if (pasid_valid(mm->pasid)) {
 		if (mm->pasid < min || mm->pasid >= max)
@@ -45,6 +55,7 @@ int iommu_sva_alloc_pasid(struct mm_struct *mm, ioasid_t min, ioasid_t max)
 	else
 		mm_pasid_set(mm, pasid);
 out:
+	mutex_unlock(&mm->context.lock);
 	mutex_unlock(&iommu_sva_lock);
 	return ret;
 }
-- 
  Kiryl Shutsemau / Kirill A. Shutemov
