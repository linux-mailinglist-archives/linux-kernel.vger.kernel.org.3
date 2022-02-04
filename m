Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2004E4AA43C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:22:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378064AbiBDXWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:22:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35074 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbiBDXWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:22:14 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1644016932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DBK2yZNYxvLy8x/PDAEC/NG09v5eFxGT61LctE0oxSY=;
        b=aBDit1LkinvPfla5El5YaYm0kJu7cY2oxGsuMNIho93oSkb23VHPKLKfDIuNZT5GL2ZXsK
        TMF2V7N8gzmmi0wwtlMRKOtVPURyNjzeSE4j1kVjooS6o1HavQyxx7MlHx8vnTkHQtG7/x
        Faijrr64fpfWl3bPcBV63Zh5FNahx4KE7LxngzjUc2UixffxT5Ba0OuhgmulGbv8SbFNO7
        sd06yCQaFBq0jrREyL0RfZDMXkfzYpSTa+w+DKPGvNXH3JOkQB4gXct2S8dy9ubTJs1Ypt
        0fNlno6ElIe3scEa9P6ceksKYw3OHjRhSlE2E8tuaK0w0orsacxqjRRdw4JxDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1644016932;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DBK2yZNYxvLy8x/PDAEC/NG09v5eFxGT61LctE0oxSY=;
        b=0USIK3EJKSRVIDVzeQ8qFn4rlRy37TsVmeexs71EbJ4kLHSFBJnN3VeIjAdrtxVUaJU3HP
        dqhQiGyXYf0dqEDA==
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
Subject: Re: [PATCH v3 04/11] kernel/fork: Initialize mm's PASID
In-Reply-To: <20220128202905.2274672-5-fenghua.yu@intel.com>
References: <20220128202905.2274672-1-fenghua.yu@intel.com>
 <20220128202905.2274672-5-fenghua.yu@intel.com>
Date:   Sat, 05 Feb 2022 00:22:12 +0100
Message-ID: <87wniab4kb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28 2022 at 12:28, Fenghua Yu wrote:
> A new mm doesn't have a PASID yet when it's created. Initialize
> the mm's PASID on fork() or for init_mm to INVALID_IOASID (-1).

I must be missing something here.

> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index aa5f09ca5bcf..c74d1edbac2f 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -8,6 +8,7 @@
>  #include <linux/mm_types.h>
>  #include <linux/gfp.h>
>  #include <linux/sync_core.h>
> +#include <linux/ioasid.h>
>  
>  /*
>   * Routines for handling mm_structs
> @@ -433,4 +434,13 @@ static inline void membarrier_update_current_mm(struct mm_struct *next_mm)
>  }
>  #endif
>  
> +#ifdef CONFIG_IOMMU_SVA
> +static inline void mm_pasid_init(struct mm_struct *mm)
> +{
> +	mm->pasid = INVALID_IOASID;
> +}
> +#else
> +static inline void mm_pasid_init(struct mm_struct *mm) {}
> +#endif
> +
>  #endif /* _LINUX_SCHED_MM_H */

So this adds mm_pasid_init() to linux/sched/mm.h which replaces:

> -static void mm_init_pasid(struct mm_struct *mm)
> -{
> -#ifdef CONFIG_IOMMU_SVA
> -	mm->pasid = INIT_PASID;
> -#endif
> -}
> -

I.e. already existing code which is initializing mm->pasid with
INIT_PASID (0) while the replacement initializes it with INVALID_IOASID
(-1).

The change log does not have any information about why INIT_PASID is the
wrong initialization value and why this change is not having any side
effects.

It neither mentions why having this in a global available header makes
sense when the only call site is in the C file from which the already
existing function is removed.

Thanks,

        tglx
