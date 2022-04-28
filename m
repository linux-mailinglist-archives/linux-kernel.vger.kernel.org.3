Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCF3512EE3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 10:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344747AbiD1It4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 04:49:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344973AbiD1ItW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 04:49:22 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB82B34654
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:43:57 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id l7so8155159ejn.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 01:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=9qK0+yT5ZuvbWECRaZtFlSv9cK0d+SeQzM8xONyxFCQ=;
        b=stS617MSascC+M/L8Vm06gYeVbC9Dv8jmbtIYvajmhdVFUgUEad4GGTmYf86a3gPMc
         gvOLmNgpK1lK1sbsCTVW+4luWQVpIPEg7SfHFaOMpKspPhr3oOl8f7ZSxS8qBr/8ik4F
         8R6JHbL5w1QREHlPS2LLB983z3AxBfJVqSFgcEv1EN0oCFNXy7mtlMt4R0Wh8eJCcxyi
         bZLuzpGQhFw4crbB6XiawB9l9SMUdKbMbECwK4Gvg37enM8206EJ1i4uiIYI9ZYLYbnL
         ldHlrbha0JSRHqDrbR7I1bmgqI1sSEkxELfwb+tRgxVsJ1MNFoFy0Gozo8gNRuRndFwR
         NbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=9qK0+yT5ZuvbWECRaZtFlSv9cK0d+SeQzM8xONyxFCQ=;
        b=Cpue400ef3r+tCnDTXVRFC1CXfOHnRmbY1Ajzu5ETh2Bg9uHnuCcU9AtO/QFTLoRG8
         T+4znFZNWVEkr3bqZ/f7hbIKcPj4DH3bcmd0cnx/5u8QTdP6XQ9UxRgPbbqFzuw8eXIW
         yaui5qEQDyKiHMiJ22WETQufE0uCti6QwQ7xIvWGfFeIe2BBkDCdN5YzZaZqhmveFrw1
         cm7zaidipExctpYmTGnYFiNwUaj/OfclVr76dpZIeCGj030zGSBgn4HHtjjt7BCk9pbN
         e2LQLq3d904mw0ke4GDr495QMEoP5B6/G143Pgj0ew0IZH9o6ZcxIwaqSBt6QaIYjUBe
         rMoA==
X-Gm-Message-State: AOAM532Xm92Lb+aHYdWhG1perXE1sKRBJe6vwL7WSDMsBc3u8H39FQ9U
        WZ15n26BPeo7A6h+vOh5XmL2cQ==
X-Google-Smtp-Source: ABdhPJzJBVpp2d/wZQwgCg1qkQkqpQYVKtQS90/gVQhiKAu6DHwNEfi97i9sDvJSY3AS5SYynQrv5g==
X-Received: by 2002:a17:906:6a14:b0:6f3:d26d:8923 with SMTP id qw20-20020a1709066a1400b006f3d26d8923mr5217702ejc.758.1651135436507;
        Thu, 28 Apr 2022 01:43:56 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net. [82.27.106.168])
        by smtp.gmail.com with ESMTPSA id x24-20020a1709064bd800b006ef606fe5c1sm8070635ejv.43.2022.04.28.01.43.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 01:43:55 -0700 (PDT)
Date:   Thu, 28 Apr 2022 09:43:31 +0100
From:   Jean-Philippe Brucker <jean-philippe@linaro.org>
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Zhangfei Gao <zhangfei.gao@linaro.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
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
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, will@kernel.org
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
Message-ID: <YmpTsw1xArrtgXaY@myrica>
References: <YmLOznyBF0f7COYT@myrica>
 <tencent_2922DAB6F3D5789A1CD3A21A843B4007ED09@qq.com>
 <Yman5hLomw9/c+bi@myrica>
 <76ec6342-0d7c-7c7b-c132-2892e4048fa1@intel.com>
 <YmavoKkVu+hd+x0M@myrica>
 <20220425083444.00af5674@jacob-builder>
 <YmbIjnHtibY7n4Wb@myrica>
 <YmdzFFx7fN586jcf@fyu1.sc.intel.com>
 <51514a02-0de9-2f9e-ec0e-c86e147fa74c@linaro.org>
 <Ymnl4S6ukb8kgwaq@fyu1.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ymnl4S6ukb8kgwaq@fyu1.sc.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 05:54:57PM -0700, Fenghua Yu wrote:
> Hi, Dave and Jean,
> 
> On Tue, Apr 26, 2022 at 01:04:45PM +0800, Zhangfei Gao wrote:
> > 
> > 
> > On 2022/4/26 下午12:20, Fenghua Yu wrote:
> > > Hi, Jean and Zhangfei,
> > > 
> > > On Mon, Apr 25, 2022 at 05:13:02PM +0100, Jean-Philippe Brucker wrote:
> > > > Could we move mm_pasid_drop() to __mmdrop() instead of __mmput()?  For Arm
> > > > we do need to hold the mm_count until unbind(), and mmgrab()/mmdrop() is
> > > > also part of Lu's rework [1].
> > > Is this a right fix for the issue? Could you please test it on ARM?
> > > I don't have an ARM machine.
> > > 
> > > Thanks.
> > > 
> > > -Fenghua
> > > 
> > >  From 84aa68f6174439d863c40cdc2db0e1b89d620dd0 Mon Sep 17 00:00:00 2001
> > > From: Fenghua Yu <fenghua.yu@intel.com>
> > > Date: Fri, 15 Apr 2022 00:51:33 -0700
> > > Subject: [PATCH] iommu/sva: Fix PASID use-after-free issue
> > > 
> > > A PASID might be still used on ARM after it is freed in __mmput().
> > > 
> > > process:
> > > 	open()->sva_bind()->ioasid_alloc() = N; // Get PASID N for the mm
> > > 	exit();
> > > 	exit_mm()->__mmput()->mm_pasid_drop()->mm->pasid = -1; // PASID -1
> > > 	exit_files()->release(dev)->sva_unbind()->use mm->pasid; // Failure
> > > 
> > > To avoid the use-after-free issue, free the PASID after no device uses it,
> > > i.e. after all devices are unbound from the mm.
> > > 
> > > sva_bind()/sva_unbind() call mmgrab()/mmdrop() to track mm->mm_count.
> > > __mmdrop() is called only after mm->mm_count is zero. So freeing the PASID
> > > in __mmdrop() guarantees the PASID is safely freed only after no device
> > > is bound to the mm.
> > > 
> > > Fixes: 701fac40384f ("iommu/sva: Assign a PASID to mm on PASID allocation and free it on mm exit")
> > > 
> > > Reported-by: Zhangfei Gao <zhangfei.gao@foxmail.com>
> > > Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > Suggested-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> > Thanks for the fix.
> > 
> > Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > 
> > 
> > > ---
> > >   kernel/fork.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/kernel/fork.c b/kernel/fork.c
> > > index 9796897560ab..35a3beff140b 100644
> > > --- a/kernel/fork.c
> > > +++ b/kernel/fork.c
> > > @@ -792,6 +792,7 @@ void __mmdrop(struct mm_struct *mm)
> > >   	mmu_notifier_subscriptions_destroy(mm);
> > >   	check_mm(mm);
> > >   	put_user_ns(mm->user_ns);
> > > +	mm_pasid_drop(mm);
> > >   	free_mm(mm);
> > >   }
> > >   EXPORT_SYMBOL_GPL(__mmdrop);
> > > @@ -1190,7 +1191,6 @@ static inline void __mmput(struct mm_struct *mm)
> > >   	}
> > >   	if (mm->binfmt)
> > >   		module_put(mm->binfmt->module);
> > > -	mm_pasid_drop(mm);
> > >   	mmdrop(mm);
> > >   }
> > 
> 
> Is this patch a good fix? Will you help push the fix into upstream?

Yes, I think it's the right thing to do for now. Could you resend it
separately so it gets visibility from the maintainers?

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

