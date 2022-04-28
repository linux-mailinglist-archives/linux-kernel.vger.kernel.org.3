Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC21513950
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 18:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349775AbiD1QF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 12:05:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231591AbiD1QF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 12:05:28 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E71F6562
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:02:13 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 1-20020a05600c248100b00393fbf11a05so4539347wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 09:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qmZUiFUPP8wYUiHrUlqJhgO7VbVwKJAKpj8W10R2YOQ=;
        b=y5cpmqg5E14QepqUlmfEMAz04fMm1zi45VxE4Ue0OGvGJ8fM1byvnMaqzHq+ppFs3w
         JnxbtA7kJWWMJJl3ouYlk3AjbA1cNCJDRpij/RajvJyXZrjpRcWwJb48vIKt715o3OVF
         PiE80uXqVgbGn4QJruJfxuffMm6Q6uOUcMoqYYU16QEIgZiLU5jMiTcEbvCW+yaAPQah
         IY2aBbMlrYGbhf4frrMPrU8x7Cpu22G5C5go8JIScX3x5GfM5NDkTkHNuImPEbvB8QqP
         ZZtnGEAWAdCdDemlhaX2h2bCpVvoHRDUcI3MYsD8hLtLB3bIBaKZvTnJTd9PhFL5UdXN
         FQeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qmZUiFUPP8wYUiHrUlqJhgO7VbVwKJAKpj8W10R2YOQ=;
        b=ZrESXv7ay8aqjQRkH89HnnzdaWDuCGUKu/oDcRaNBb+4KbMTF6pnXDYNHkF7aJYoxp
         FGImJBpWNcml0/pqhY/vjmBaCYp7toD1WOAbVu1ij9/7vY7n1c7I5LIE3BAXis631gM/
         uTjffqC586PWK/5wz4c31jTzkFJ0K3ByMC16jx3/eRuqL+8uxupPNybL9u0FaVgM+H1S
         mcADAyRgLQmXIg9ZgqqZ27sL3s4tiJMYrKsuH/uh1IbG4DMGMQbUjHWgY/OJ+k0Zg5db
         QCU8HYGuGr4iS5PlbiunKnUlbsexHuJfTFto4FdckSd7jDTrTuU+YeQTNQ0PsNWgLUIa
         IXCQ==
X-Gm-Message-State: AOAM532VpQGk4wwBSmIB9tykLp5suhOPdopIwW8eOjDYsxAlEKG0nUCi
        5XEZ7PrNnD++cIq3RB5xBwVjaQ==
X-Google-Smtp-Source: ABdhPJxL4jzSFoCLq25i5k8etbhswfCdtRlZ7uAjJ5s+YgxKJFIWI2qzwygKSC+xkj15A4B9LX8IYA==
X-Received: by 2002:a05:600c:590:b0:38c:804e:4197 with SMTP id o16-20020a05600c059000b0038c804e4197mr31616563wmd.22.1651161731620;
        Thu, 28 Apr 2022 09:02:11 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id q1-20020a1c4301000000b00394145534bbsm325283wma.9.2022.04.28.09.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 09:02:10 -0700 (PDT)
Date:   Thu, 28 Apr 2022 17:01:45 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Peter Zijlstra <peterz@infradead.org>, robin.murphy@arm.com,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, zhangfei.gao@linaro.org,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <Ymq6aZCTdrOE60cn@myrica>
References: <tencent_A4E83BA6071B2204B6F5D4E69A50D21C1A09@qq.com>
 <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica>
 <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica>
 <20220425083444.00af5674@jacob-builder>
 <YmbIjnHtibY7n4Wb@myrica>
 <YmdzFFx7fN586jcf@fyu1.sc.intel.com>
 <bc18351c-27f2-17ae-e781-6b60fbb72541@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc18351c-27f2-17ae-e781-6b60fbb72541@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 08:09:04AM -0700, Dave Hansen wrote:
> On 4/25/22 21:20, Fenghua Yu wrote:
> >>From 84aa68f6174439d863c40cdc2db0e1b89d620dd0 Mon Sep 17 00:00:00 2001
> > From: Fenghua Yu <fenghua.yu@intel.com>
> > Date: Fri, 15 Apr 2022 00:51:33 -0700
> > Subject: [PATCH] iommu/sva: Fix PASID use-after-free issue
> > 
> > A PASID might be still used on ARM after it is freed in __mmput().
> 
> Is it really just ARM?
> 
> > process:
> > 	open()->sva_bind()->ioasid_alloc() = N; // Get PASID N for the mm
> > 	exit();
> > 	exit_mm()->__mmput()->mm_pasid_drop()->mm->pasid = -1; // PASID -1
> > 	exit_files()->release(dev)->sva_unbind()->use mm->pasid; // Failure
> > 
> > To avoid the use-after-free issue, free the PASID after no device uses it,
> > i.e. after all devices are unbound from the mm.
> > 
> > sva_bind()/sva_unbind() call mmgrab()/mmdrop() to track mm->mm_count.
> > __mmdrop() is called only after mm->mm_count is zero. So freeing the PASID
> > in __mmdrop() guarantees the PASID is safely freed only after no device
> > is bound to the mm.
> 
> Does this changelog work for everyone?
> 
> ==
> 
> tl;dr: The PASID is being freed too early.  It needs to stay around
> until after device drivers that might be using it have had a chance to
> clear it out of the hardware.
> 
> --
> 
> As a reminder:
> 
> mmget() /mmput()  refcount the mm's address space
> mmgrab()/mmdrop() refcount the mm itself
> 
> The PASID is currently tied to the life of the mm's address space and
> freed in __mmput().  This makes logical sense because the PASID can't be
> used once the address space is gone.
> 
> But, this misses an important point: even after the address space is
> gone, the PASID will still be programmed into a device.  Device drivers
> might, for instance, still need to flush operations that are outstanding
> and need to use that PASID.  They do this at ->release() time.

It's not really clear which release() this is. For us it's file descriptor
release() (not MMU notifier release(), which is how I initially understood
this sentence)

> 
> Device drivers hold a reference on the mm itself and drop it at
> ->release() time.  But, the device driver holds a reference mm itself,

"to the mm"

(To be pendantic it's the IOMMU driver that holds this reference, and
the device driver calls the IOMMU driver to release it, but the idea is
the same.)

> not the address space.  The address space (and the PASID) is long gone
> by the time the driver tries to clean up.  This is effectively a
> use-after-free bug on the PASID.
> 
> To fix this, move the PASID free operation from __mmput() to __mmdrop().
>  This ensures that the device drivers' existing mmgrab() keeps the PASID
> allocated until they drop their mm reference.

Good changelog otherwise

Thanks,
Jean

> 
> >  kernel/fork.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/kernel/fork.c b/kernel/fork.c
> > index 9796897560ab..35a3beff140b 100644
> > --- a/kernel/fork.c
> > +++ b/kernel/fork.c
> > @@ -792,6 +792,7 @@ void __mmdrop(struct mm_struct *mm)
> >  	mmu_notifier_subscriptions_destroy(mm);
> >  	check_mm(mm);
> >  	put_user_ns(mm->user_ns);
> > +	mm_pasid_drop(mm);
> >  	free_mm(mm);
> >  }
> >  EXPORT_SYMBOL_GPL(__mmdrop);
> > @@ -1190,7 +1191,6 @@ static inline void __mmput(struct mm_struct *mm)
> >  	}
> >  	if (mm->binfmt)
> >  		module_put(mm->binfmt->module);
> > -	mm_pasid_drop(mm);
> >  	mmdrop(mm);
> >  }
> >  
> 
