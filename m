Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743FE49D49B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 22:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiAZViK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 16:38:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiAZViI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 16:38:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA41C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 13:38:07 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643233085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f5fcoWwfmhzNvMjUp+pjH4hD1mIf2d1g2+i2SJzfS4Q=;
        b=J5TRhWXL23NuwdM3hRs+FPxtZmSYLsb36kLeKRr3FWAhvN9lr8SBhLOI+zjjcbnluOWX0J
        La6iQGteVfCwqPIhFSpnJiDFXFF3kAlFjpLmhduP3NkxTDN96Peda9Yc/TMTrVUQcsUiPx
        pj1x0gvkj0KnKpRGFUZy/EzknDDLUbr83/0d3NiXGM4AwgvolreuNsxm8u6AhZy0R3fc/3
        Mu+4iaWJIMSXp6nvn4F8GKRoGFcypVFJovKrtByV6iWptI2gDHd7YdWJCnl72d5j/ahW86
        vxC36v6EePrfe5vdTvwcIpFrclV1jgl3yyAIfSm2HIsCtdaFyOe+vFrsWYPExw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643233085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f5fcoWwfmhzNvMjUp+pjH4hD1mIf2d1g2+i2SJzfS4Q=;
        b=JEka+zNZXXyLc6D1VvwfqDsXU24l1eYSpl3XbMvwJi7v+170sTD6Z+2Gh27xmdaOmydw/f
        E7/StC2ZRyAae9CA==
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        iommu@lists.linux-foundation.org, x86 <x86@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
In-Reply-To: <YfGGk7kWNc9q2YwV@otcwcpicx3.sc.intel.com>
References: <20211217220136.2762116-1-fenghua.yu@intel.com>
 <20211217220136.2762116-6-fenghua.yu@intel.com> <87ee4w6g1n.ffs@tglx>
 <87bl006fdb.ffs@tglx> <Ye8RmmKpJT8brmDE@otcwcpicx3.sc.intel.com>
 <878rv46eg3.ffs@tglx> <YfAUutQhqS6ejUFU@otcwcpicx3.sc.intel.com>
 <87k0em4lu9.ffs@tglx> <YfGGk7kWNc9q2YwV@otcwcpicx3.sc.intel.com>
Date:   Wed, 26 Jan 2022 22:38:04 +0100
Message-ID: <8735la41qb.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26 2022 at 09:36, Fenghua Yu wrote:
> On Wed, Jan 26, 2022 at 03:23:42PM +0100, Thomas Gleixner wrote:
>> On Tue, Jan 25 2022 at 07:18, Fenghua Yu wrote:
>> While looking at ioasid_put() usage I tripped over the following UAF
>> issue:
>> 
>> --- a/drivers/iommu/intel/iommu.c
>> +++ b/drivers/iommu/intel/iommu.c
>> @@ -4817,8 +4817,10 @@ static int aux_domain_add_dev(struct dma
>>  	auxiliary_unlink_device(domain, dev);
>>  link_failed:
>>  	spin_unlock_irqrestore(&device_domain_lock, flags);
>> -	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
>> +	if (list_empty(&domain->subdevices) && domain->default_pasid > 0) {
>>  		ioasid_put(domain->default_pasid);
>> +		domain->default_pasid = INVALID_IOASID;
>> +	}
>>  
>>  	return ret;
>>  }
>> @@ -4847,8 +4849,10 @@ static void aux_domain_remove_dev(struct
>>  
>>  	spin_unlock_irqrestore(&device_domain_lock, flags);
>>  
>> -	if (list_empty(&domain->subdevices) && domain->default_pasid > 0)
>> +	if (list_empty(&domain->subdevices) && domain->default_pasid > 0) {
>>  		ioasid_put(domain->default_pasid);
>> +		domain->default_pasid = INVALID_IOASID;
>> +	}
>>  }
>>  
>>  static int prepare_domain_attach_device(struct iommu_domain *domain,
>
> The above patch fixes an existing issue. I will put it in a separate patch,
> right?

Correct.

> It cannot be applied cleanly to the upstream tree. Do you want me to base
> the above patch (and the whole patch set) to the upstream tree or a specific
> tip branch?

Against Linus tree please so that the bugfix applies.

> I will fold the following patch into patch #5. The patch #11 (the doc patch)
> also needs to remove one paragraph talking about refcount.
>
> So I will send the whole patch set with the following changes:
> 1. One new bug fix patch (the above patch)
> 2. Updated patch #5 (with the following patch folded)
> 3. Updated patch #11 (removing refcount description)

Looks good.

Thanks,

        tglx
