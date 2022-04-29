Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952FF514D3C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 16:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377474AbiD2OiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 10:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344646AbiD2OiV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 10:38:21 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDEC72A71A
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:35:02 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id c190-20020a1c35c7000000b0038e37907b5bso7185553wma.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 07:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MNfUquSBQXRdU8AFXuKgswA3BnrGyLe9et79dGaHCHo=;
        b=aCrclNQan4DsysNx5+Nj3TiV0fkI/4mECyTS4zEiZJ1dbrslZNfdTJXWueSAZWJnj9
         DwSOotBRoD0nJ/o2/tSmtSJ5R306TVL+nnpVT5ZaYo5fsHtkNVj8ZEHVmr176n4+JxPx
         SjomnHzojd/oFkir7xR7lTB3rXs3zZOZtmb3rziM8Pbx95QK36YxjUQC9D7AUyOGlfPJ
         6pXmo870wnuuYI1pL69PpSShVXLUfeCJy82zRSiD0TAKehsScy7PPWZdcH+jqaCj02QL
         kFZCgZunayVK8ji/YGjOacvZv+7UCpBUAbWAN+ZvMnrNGupxBZg4rfrn4HU1c5SoPpA/
         JKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MNfUquSBQXRdU8AFXuKgswA3BnrGyLe9et79dGaHCHo=;
        b=i3MNFuPOVGB0T2I3QvWpwl4jnDBTlMtkwod6dVpU/0nTKsTfcpoJgiwubb+1nwf9gD
         G86Cbv6cNwHnMeG0y80DvPSChITXnBUESXyjZAt8QR6LricAwmcnrLCv9LjSX95z0xYz
         SZrRjfJNbY06RQa7Y40O5Q0QwUBDcLHp2IsBp+5wQrh9o20SfGi2A10RB5s/wuh+mm0K
         jZCyal6MVzbH2mKu8MixJmy4+KMyvN71B53zHXQbgvAB1RpnB+7/aReE7jDdMmTLybGb
         b8mPFTmntFKiktDJ6r2WwszC6j0warCHbCbaVKKhi8x1o6qbfo8dQrZjOMjt1kQaQQEA
         mDjw==
X-Gm-Message-State: AOAM53222ARsdhQqcWZJH7IZ15riMouO7Koa2v3AvdmglV3iG3TKtkdm
        I+t76Q0qfo0CcYsWNQW3IuYG0w==
X-Google-Smtp-Source: ABdhPJxKHrquOOAsrXP0Ic/O71Wk33ou9E5855eyzUO0XSRyB3TpmdWISR92SDQl7rOKCjBmfNPoLA==
X-Received: by 2002:a05:600c:2e08:b0:394:24c:2da4 with SMTP id o8-20020a05600c2e0800b00394024c2da4mr3532185wmf.134.1651242901408;
        Fri, 29 Apr 2022 07:35:01 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id m35-20020a05600c3b2300b00393ebe201a6sm7075995wms.44.2022.04.29.07.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 07:35:00 -0700 (PDT)
Date:   Fri, 29 Apr 2022 15:34:36 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
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
Message-ID: <Ymv3fC4xXqe+oMRK@myrica>
References: <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica>
 <22b659c7-e972-7a56-2bd7-8df3b4820d4e@intel.com>
 <YmbO/l5IwfBCHrl8@myrica>
 <8c044e49-74bb-df56-8a60-663013c0910e@intel.com>
 <YmgiQZZyFxsJ+9um@myrica>
 <63582490-a794-fd11-0380-44b27cc660b7@intel.com>
 <YmpSv48aPIbVXqGi@myrica>
 <044595e6-e5d0-26c2-af8e-fc9d06906179@linux.intel.com>
 <YmvtVRlwVJjStXc0@fyu1.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmvtVRlwVJjStXc0@fyu1.sc.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 06:51:17AM -0700, Fenghua Yu wrote:
> Hi, Baolu,
> 
> On Fri, Apr 29, 2022 at 03:53:57PM +0800, Baolu Lu wrote:
> > On 2022/4/28 16:39, Jean-Philippe Brucker wrote:
> > > > The address space is what the OOM killer is after.  That gets refcounted
> > > > with mmget()/mmput()/mm->mm_users.  The OOM killer is satiated by the
> > > > page freeing done in __mmput()->exit_mmap().
> > > > 
> > > > Also, all the VMAs should be gone after exit_mmap().  So, even if
> > > > vma->vm_file was holding a reference to a device driver, that reference
> > > > should be gone by the time __mmdrop() is actually freeing the PASID.
> > > 
> > > I agree with all that. The concern was about tearing down the PASID in the
> > > IOMMU and device from the release() MMU notifier, which would happen in
> > > exit_mmap(). But doing the teardown at or before __mmdrop() is fine. And
> > > since the IOMMU drivers need to hold mm->mm_count anyway between bind()
> > > and unbind(), I think Fenghua's fix works.
> > 
> > But I didn't find mmgrab()/mmdrop() get called in both arm and intel
> > IOMMU drivers.
> > 
> > $ git grep mmgrab drivers/iommu/
> > [no output]
> > 
> > Do we need to add these in a separated fix patch, or I missed anything
> > here?
> 
> On both ARM and X86, sva_bind() calls mmu_notifier_register()->mmgrab() and
> sva_unbind() calls mmu_notifier_unregister()/mmu_notifier_put()->mmdrop().

Yes, although for Arm I realized the mmu_notifier grab wasn't sufficient
so I sent a separate fix that should go in 5.18 as well
https://lore.kernel.org/linux-iommu/20220426130444.300556-1-jean-philippe@linaro.org/
The Arm driver still touches the arch mm context after mmu_notifier_put().
I don't think X86 has that problem.

Thanks,
Jean

> So mm->mm_count are already counted in existing ARM and X86 binding and
> unbinding. The fix patch just frees the PASID in __mmdrop() after
> no more mm->mm_count.
> 
> There is no need to add extra  mmgrab() and mmdrop() pair.
> 
> Thanks.
> 
> -Fenghua
> 
>  
