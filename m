Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13AD4AA4B2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378517AbiBDX4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:56:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35248 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377814AbiBDX4D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:56:03 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644018961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=96SoL3E8HRraXhW4GJvLh32KeIwpXS7GySgMx5VXOrw=;
        b=dl9H1uZ7++7Lg9O8+nklBFbOMxVaazDBU+q+U0NCRS0OTWk7CG8E9MX67//cKNReM3zKyJ
        kfncVJ1nKkBjP1L9TVRAO9C9MZtC4m0B19lXjGaKYxU/g9i5reQE8vYYm5f6w1JMUQ2WJW
        nwmm+GY9MZRT6xxG19brdWjAlnccQLCV1HcMLqbQOQgsWaK16x6fO6MqZ8A2X5irI/EiGF
        3KlB8Cp9jdF/HyGLs15k1DTAer4b/VXtKypipqgBnoevbfkipIbDdLef+PLyPU/NJSuDzn
        zaU5OWVIoXtm0i0eZd+vfVLQ1zRrawlJ7A64Andor5vrPhXrvSb7X9TL7hNDOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644018961;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=96SoL3E8HRraXhW4GJvLh32KeIwpXS7GySgMx5VXOrw=;
        b=boPOAy3L0uN2tjlbFX4t2zq9awzckTNT1mstjB0iv6tj8UuvZH2u6cEj7x9WyBdmJ1y5ts
        ZpdYSFRPbV+iUKCA==
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>
Cc:     iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: Re: [PATCH v3 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
In-Reply-To: <20220128202905.2274672-6-fenghua.yu@intel.com>
References: <20220128202905.2274672-1-fenghua.yu@intel.com>
 <20220128202905.2274672-6-fenghua.yu@intel.com>
Date:   Sat, 05 Feb 2022 00:56:00 +0100
Message-ID: <87r18ib2zz.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28 2022 at 12:28, Fenghua Yu wrote:
> To avoid complexity of updating each thread's PASID status (e.g. sending
> IPI to update IA32_PASID MSR) on allocating and freeing PASID, once
> allocated and assigned to an mm, the PASID stays with the mm for the
> rest of the mm's lifetime. A reference to the PASID is taken on
> allocating the PASID. Binding/unbinding the PASID won't change refcount.
> The reference is dropped on mm exit and thus the PASID is freed.
>
> Two helpers mm_pasid_set() and mm_pasid_drop() are defined in mm because
> the PASID operations handle the pasid member in mm_struct and should be
> part of mm operations. Because IOASID's reference count is not used any
> more and removed, unused ioasid_get() and iommu_sva_free_pasid()
> are deleted and ioasid_put() is renamed to ioasid_free().
>
> 20-bit PASID allows up to 1M processes bound to PASIDs at the same time.
> With cgroups and other controls that might limit the number of process
> creation, the limited number of PASIDs is not a realistic issue for
> lazy PASID free.

Please take a step back and think hard about it whether that changelog
makes sense to you a year from now.

Let me walk you through:

> To avoid complexity of updating each thread's PASID status (e.g. sending
> IPI to update IA32_PASID MSR) on allocating and freeing PASID, once
> allocated and assigned to an mm, the PASID stays with the mm for the
> rest of the mm's lifetime.

You are missing the oportunity to tell a story about the history of this
decision here:

  PASIDs are process wide. It was attempted to use refcounted PASIDs to
  free them when the last thread drops the refcount. This turned out to
  be complex and error prone. Given the fact that the PASID space is 20
  bits, which allows up to 1M processes to have a PASID associated
  concurrently, PASID resource exhaustion is not a realistic concern.

  Therefore it was decided to simplify the approach and stick with lazy
  on demand PASID allocation, but drop the eager free approach and make
  a allocated PASID lifetime bound to the life time of the process.

> A reference to the PASID is taken on allocating the
> PASID. Binding/unbinding the PASID won't change refcount.  The
> reference is dropped on mm exit and thus the PASID is freed.

There is no refcount in play anymore, right? So how does this part of
the changelog make any sense?

This is followed by:

> Two helpers mm_pasid_set() and mm_pasid_drop() are defined in mm because
> the PASID operations handle the pasid member in mm_struct and should be
> part of mm operations. Because IOASID's reference count is not used any
> more and removed, unused ioasid_get() and iommu_sva_free_pasid()
> are deleted and ioasid_put() is renamed to ioasid_free().

which does not provide much rationale and just blurbs about _what_ the
patch is doing and not about the why and the connection to the
above. And the refcount removal section contradicts the stale text
above.

So this paragraph should be something like this:

  Get rid of the refcounting mechanisms and replace/rename the
  interfaces to reflect this new approach.

Hmm?

Thanks,

        tglx
