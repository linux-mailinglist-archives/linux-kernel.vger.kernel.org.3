Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6594D512ED4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344305AbiD1Ir6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344096AbiD1IrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:47:19 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68074ABF69
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:39:54 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id a1so4681964edt.3
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D5+nFt6Ea7EC31s7wJHU5grETay07mE4VfWqd3ItgC0=;
        b=Ry01M9KA22nld0bRc5AXSR/k/WhEpT5PZniJo9iJBPUEkcgnabxgqnnAh0vpcJPVOJ
         qZZwhh7qmARlsHt0iAvt4oQYA7UYL6VZqpo/v4SwSczI4mv7k9ySJTS38/f2BHEy0gPN
         y7wHKxIU/q7oAwVDWmXglq8smOrQyZ7xmILZvBYzujXAr/5nps1MtSulZfyAQTJ/j+5W
         i+n2PKxANZPiF5e4bUQhc0deXWKTjfgn9mP4defuhSAY5ne6OIO+BjDgQBExG+AWU5ms
         Dc6kCx9pi9v3Y0Mi5z3/ljYEH8V55knGQm9GYit3TIOB2kfdIuDSiAd1Aq8K5Uzd2A2B
         Q1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D5+nFt6Ea7EC31s7wJHU5grETay07mE4VfWqd3ItgC0=;
        b=QYTbo36EL3JTRgZfSgNwdHuri7JsOmoMOu0jZe5y9YpZV96jaR/MmSBQPB/172OSsH
         RwbGnxuPu4zzlUbOvgyhTeWp64HvXZDFg7PieuU1wSUgwLgdVX1kY5+OFx2WGReZ3Fue
         +Ycwi59UWUa1BcroQatWel8uLn1dAY/5JOM5uw1fHCLV7bdJNLb1XRlD4SeXZmhuBRff
         16Mg/B4U4Yu0lhVX0dop9KCKz+Ly9cMyTCv+OnQd5gh/q0oiVcmT3ZAQ9JJfNTaA9MSQ
         Jbma0kCKYwp/IRy30K0Z8EZrPD1OGZlbmi6lxjnH+rQRdlGI8a0/96ALTBq+UBOlnEvh
         /ErQ==
X-Gm-Message-State: AOAM532t8FX22a/1yJ3gsDEK94Uk5pJ9+qdM+ql7qhBvmVluVzgU46DB
        rsFrYutAFfds/x6xM74vqfZevA==
X-Google-Smtp-Source: ABdhPJwBPNHeb/K2J5VGKPrZ+4Y/Qy4hkj466iMlH8I6yasOvr5Ab1dpRZVkytuOmwHBu2gkcRU6SQ==
X-Received: by 2002:aa7:d609:0:b0:425:d94b:4119 with SMTP id c9-20020aa7d609000000b00425d94b4119mr24113038edr.282.1651135192971;
        Thu, 28 Apr 2022 01:39:52 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id x24-20020a1709064bd800b006ef606fe5c1sm8064976ejv.43.2022.04.28.01.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 01:39:52 -0700 (PDT)
Date:   Thu, 28 Apr 2022 09:39:27 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        iommu <iommu@lists.linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org,
        robin.murphy@arm.com, zhangfei.gao@linaro.org
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YmpSv48aPIbVXqGi@myrica>
References: <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica>
 <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica>
 <22b659c7-e972-7a56-2bd7-8df3b4820d4e@intel.com>
 <YmbO/l5IwfBCHrl8@myrica>
 <8c044e49-74bb-df56-8a60-663013c0910e@intel.com>
 <YmgiQZZyFxsJ+9um@myrica>
 <63582490-a794-fd11-0380-44b27cc660b7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63582490-a794-fd11-0380-44b27cc660b7@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2022 at 04:31:57PM -0700, Dave Hansen wrote:
> On 4/26/22 09:48, Jean-Philippe Brucker wrote:
> > On Tue, Apr 26, 2022 at 08:27:00AM -0700, Dave Hansen wrote:
> >> On 4/25/22 09:40, Jean-Philippe Brucker wrote:
> >>> The problem is that we'd have to request the device driver to stop DMA
> >>> before we can destroy the context and free the PASID. We did consider
> >>> doing this in the release() MMU notifier, but there were concerns about
> >>> blocking mmput() for too long (for example
> >>> https://lore.kernel.org/linux-iommu/4d68da96-0ad5-b412-5987-2f7a6aa796c3@amd.com/
> >>> though I think there was a more recent discussion). We also need to drain
> >>> the PRI and fault queues to get rid of all references to that PASID.
> >> Is the concern truly about blocking mmput() itself?  Or, is it about
> >> releasing the resources associated with the mm?
> > The latter I think, this one was about releasing pages as fast as possible
> > if the process is picked by the OOM killer. 
> 
> We're tying the PASID to the life of the mm itself, not the mm's address
> space.  That means the PASID should be tied to
> mmgrab()/mmdrop()/mm->mm_count.
> 
> The address space is what the OOM killer is after.  That gets refcounted
> with mmget()/mmput()/mm->mm_users.  The OOM killer is satiated by the
> page freeing done in __mmput()->exit_mmap().
> 
> Also, all the VMAs should be gone after exit_mmap().  So, even if
> vma->vm_file was holding a reference to a device driver, that reference
> should be gone by the time __mmdrop() is actually freeing the PASID.

I agree with all that. The concern was about tearing down the PASID in the
IOMMU and device from the release() MMU notifier, which would happen in
exit_mmap(). But doing the teardown at or before __mmdrop() is fine. And
since the IOMMU drivers need to hold mm->mm_count anyway between bind()
and unbind(), I think Fenghua's fix works.

Thanks,
Jean

