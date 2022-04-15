Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0051502807
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 12:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352151AbiDOKQz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 06:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239572AbiDOKQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:16:52 -0400
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60C2BA330
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 03:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1650017654;
        bh=fQnh3qt0+gOsXVYOOm5JWym51U5VAolvTvqPtnE6nRs=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=du0M4qiFzNATGZkilKHoMJEzs0PnqvaglUhnk1uCRge2HROaAMVAgoYBpFoy+4PLh
         c1cpL052ZMGvNBFpIVmI+vpr+Kp35Z0s8sGt0/dfrWhhIW0RNCVlKOJB5taDcmdq9C
         a2ANFHxMwCjbG++c2x/faJWkUzDdoTFhfTtto3Aw=
Received: from [IPv6:240e:362:47d:9500:6527:51dc:8ce2:179e] ([240e:362:47d:9500:6527:51dc:8ce2:179e])
        by newxmesmtplogicsvrszc8.qq.com (NewEsmtp) with SMTP
        id 3899F435; Fri, 15 Apr 2022 18:14:09 +0800
X-QQ-mid: xmsmtpt1650017649tealrp6ne
Message-ID: <tencent_960E0647C06CE7A9893545A5AD345876240A@qq.com>
X-QQ-XMAILINFO: MtZ6QPwsmM9XyOP1qhF3KgB2+kucOc1gMvPT135LHmRMtvFVUEDI0iGVuGhr8B
         EUR0HZZLG/j1xSWGe8rgNEYTidz0gQfjU0eTGuXhLr1FV/BrSyPrTbBdFEy2BsOIkqMl7lZqmord
         CSddmTakP+D+SHRWHRKXrHagq3kjb5LshM+vin3aJI8ZvjKUnrxDowozpflIEscgnMMNKWZH1sWR
         OGGDcMf57go750uLQh7s5+pl80BxRxekupn5AHjA4K7dfgyMrC9w3HmrK24b1D/k/Wz3Ec2UKUq7
         smzRzWf7erc8OLYiDHKZsncN54K6MNt9vN2ziCs6CHcZgqGkyQ5pVmB1E/N2utEMAFYuDQpTSp/8
         lI9/Owjq5HAfEAUyQScshW2pNISmSHeXAsq8Tiz5NP/k+Qv9I6Kh9Bw0uXWH62CL1cphkdes1gRu
         wsQzEvWobejAaNNpN30PW+Pz0DWLW/HX/3PZ/KqPD4gCJ1rwB4hSLtdVQe6l0F3VMKccumkxsB/3
         YuoPLDLUAsszen32Vk8KmxCrRFZLZ5gsfVnT2OwvPTyBFnY2uSvc1bYYxurpP3pTNoGN+jUQz776
         xF3CD33/5Y5dgHCgiVHDZ9TQVOyhE2zjpIpZfBOFBmMpwbACWbipR2I/n+pKUi8f0fRT33Y7juHW
         lVk0swTw/ppgMO3vy/seND01pVhTyNr8MhE16bk8zKoFX32nMrG/3xtse2y5YRArFn2T9r6txUBJ
         Kops9Agrp1S+ftpHh0Tgp56J/igyXM/tFap+UXVuf+NM4usJqkHDhfoYMTcp7lTe6r4ec6O25Klc
         lmFTlYXtkhYkW+flrYmwjYme6gnuCg81piGiohoDdRIpL47H0MGR4XzPuy1AyIXHyqrGOZyjqxQK
         KoNFSy9JHLR5F3UhoG1GggyiR+j5UrH76BmWhG3vnbslonS31Toxsxero1Y+eUkw/x8fvF0WqtNn
         5dZt5eELzJOarkZtavqIXTERoaTgoDJtCtEVjYwzc=
Subject: Re: [PATCH v4 05/11] iommu/sva: Assign a PASID to mm on PASID
 allocation and free it on mm exit
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        jean-philippe <jean-philippe@linaro.org>,
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
        Thomas Gleixner <tglx@linutronix.de>
References: <tencent_F6830A1196DB4C6A904D7C691F0D961D1108@qq.com>
 <56ed509d-a7cf-1fde-676c-a28eb204989b@intel.com>
 <tencent_9920B633D50E9B80D3A41A723BCE06972309@qq.com>
 <f439dde5-0eaa-52e4-9cf7-2ed1f62ea07f@intel.com>
 <tencent_F73C11A7DBAC6AF24D3369DF0DCA1D7E8308@qq.com>
 <a139dbad-2f42-913b-677c-ef35f1eebfed@intel.com>
 <tencent_B683AC1146DB6A6ABB4D73697C0D6A1D7608@qq.com>
 <YlWBkyGeb2ZOGLKl@fyu1.sc.intel.com>
 <tencent_A9458C6CEBAADD361DA765356477B00E920A@qq.com>
 <tencent_8B6D7835F62688B4CD069C0EFC41B308B407@qq.com>
 <YllADL6uMoLllzQo@fyu1.sc.intel.com>
From:   "zhangfei.gao@foxmail.com" <zhangfei.gao@foxmail.com>
Message-ID: <99bcb9f5-4776-9c40-a776-cdecfa9e1010@foxmail.com>
Date:   Fri, 15 Apr 2022 18:14:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YllADL6uMoLllzQo@fyu1.sc.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/15 下午5:51, Fenghua Yu wrote:
> On Thu, Apr 14, 2022 at 06:08:09PM +0800, zhangfei.gao@foxmail.com wrote:
>> On 2022/4/12 下午11:35, zhangfei.gao@foxmail.com wrote:
>>> Hi, Fenghua
>>>
>>> On 2022/4/12 下午9:41, Fenghua Yu wrote:
>>>> Hi, Zhangfei,
>>>>
>>>> On Tue, Apr 12, 2022 at 03:04:09PM +0800, zhangfei.gao@foxmail.com
>>>> wrote:
>>>>> On 2022/4/11 下午10:52, Dave Hansen wrote:
>>>>>> On 4/11/22 07:44, zhangfei.gao@foxmail.com wrote:
>>>>>>> On 2022/4/11 下午10:36, Dave Hansen wrote:
>>>>>>>> On 4/11/22 07:20, zhangfei.gao@foxmail.com wrote:
>>> Agree with Dave, I think user space should not be broken.
>>>
>>> Thanks
>> Any plan about this regression?
>> Currently I need this patch to workaround the issue.
>>
>> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>> b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>> index 22ddd05bbdcd..2d74ac53d11c 100644
>> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
>> @@ -4,6 +4,7 @@
>>    */
>>
>>   #include <linux/mm.h>
>> +#include <linux/sched/mm.h>
>>   #include <linux/mmu_context.h>
>>   #include <linux/mmu_notifier.h>
>>   #include <linux/slab.h>
>> @@ -363,6 +364,7 @@ arm_smmu_sva_bind(struct device *dev, struct mm_struct
>> *mm, void *drvdata)
>>
>>          mutex_lock(&sva_lock);
>>          handle = __arm_smmu_sva_bind(dev, mm);
>> +       mmget(mm);
>>          mutex_unlock(&sva_lock);
>>          return handle;
>>   }
>> @@ -377,6 +379,7 @@ void arm_smmu_sva_unbind(struct iommu_sva *handle)
>>                  arm_smmu_mmu_notifier_put(bond->smmu_mn);
>>                  kfree(bond);
>>          }
>> +       mmput(bond->mm);
>>          mutex_unlock(&sva_lock);
>>   }
> Could you please review and/or test this patch? It's supposed to fix
> the PASID issue on both ARM and X86.
>
>  From a6444e1e5bd8076f5e5c5e950d3192de327f0c9c Mon Sep 17 00:00:00 2001
> From: Fenghua Yu <fenghua.yu@intel.com>
> Date: Fri, 15 Apr 2022 00:51:33 -0700
> Subject: [RFC PATCH] iommu/sva: Fix PASID use-after-free issue
>
> A PASID might be still used even though it is freed on mm exit.
>
> process A:
> 	sva_bind();
> 	ioasid_alloc() = N; // Get PASID N for the mm
> 	fork(): // spawn process B
> 	exit();
> 	ioasid_free(N);
>
> process B:
> 	device uses PASID N -> failure
> 	sva_unbind();
>
> Dave Hansen suggests to take a refcount on the mm whenever binding the
> PASID to a device and drop the refcount on unbinding. The mm won't be
> dropped if the PASID is still bound to it.
>
> Fixes: 701fac40384f ("iommu/sva: Assign a PASID to mm on PASID allocation and free it on mm exit")
>
> Reported-by: Zhangfei Gao <zhangfei.gao@foxmail.com>
> Suggested-by: Dave Hansen" <dave.hansen@linux.intel.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 6 ++++++
>   drivers/iommu/intel/svm.c                       | 4 ++++
>   2 files changed, 10 insertions(+)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index 22ddd05bbdcd..3fcb842a0df0 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -7,6 +7,7 @@
>   #include <linux/mmu_context.h>
>   #include <linux/mmu_notifier.h>
>   #include <linux/slab.h>
> +#include <linux/sched/mm.h>
>   
>   #include "arm-smmu-v3.h"
>   #include "../../iommu-sva-lib.h"
> @@ -363,6 +364,9 @@ arm_smmu_sva_bind(struct device *dev, struct mm_struct *mm, void *drvdata)
>   
>   	mutex_lock(&sva_lock);
>   	handle = __arm_smmu_sva_bind(dev, mm);
> +	/* Take an mm refcount on a successful bind. */
> +	if (!IS_ERR(handle))
> +		mmget(mm);
>   	mutex_unlock(&sva_lock);
>   	return handle;
>   }
> @@ -372,6 +376,8 @@ void arm_smmu_sva_unbind(struct iommu_sva *handle)
>   	struct arm_smmu_bond *bond = sva_to_bond(handle);
>   
>   	mutex_lock(&sva_lock);
> +	/* Drop an mm refcount. */
> +	mmput(bond->mm);
>   	if (refcount_dec_and_test(&bond->refs)) {
>   		list_del(&bond->list);
>   		arm_smmu_mmu_notifier_put(bond->smmu_mn);
> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> index 23a38763c1d1..345a0d5d7922 100644
> --- a/drivers/iommu/intel/svm.c
> +++ b/drivers/iommu/intel/svm.c
> @@ -403,6 +403,8 @@ static struct iommu_sva *intel_svm_bind_mm(struct intel_iommu *iommu,
>   		goto free_sdev;
>   
>   	list_add_rcu(&sdev->list, &svm->devs);
> +	/* Take an mm refcount on binding mm. */
> +	mmget(mm);
>   success:
>   	return &sdev->sva;
>   
> @@ -465,6 +467,8 @@ static int intel_svm_unbind_mm(struct device *dev, u32 pasid)
>   				kfree(svm);
>   			}
>   		}
> +		/* Drop an mm reference on unbinding mm. */
> +		mmput(mm);
>   	}
>   out:
>   	return ret;
This patch can not be applied on 5.18-rc2 for intel part.
It should work for arm.

In fact I have a similar patch at hand but pending since I found an issue.

I start & stop nginx via this cmd.
//start
sudo sbin/nginx                    // this alloc an ioasid=1
//stop
sudo sbin/nginx -s quit    // this does not free ioasid=1, but still 
alloc ioasid=2.
So ioasid will keep allocated but not freed if continue start/stop 
nginx,  though not impact the nginx function.

stop nginx with -s quit still calls
src/core/nginx.c
main -> ngx_ssl_init -> openssl engine:    bind_fn -> ... -> alloc asid
But openssl engine: ENGINE_free is not called

Still in checking nginx code.

Or do you test with nginx?

Thanks




