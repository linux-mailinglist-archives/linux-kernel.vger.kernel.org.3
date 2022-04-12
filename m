Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A3D4FD447
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391293AbiDLJ3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383021AbiDLIfS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 04:35:18 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A2445D1A1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:01:26 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aef95.dynamic.kabel-deutschland.de [95.90.239.149])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 30DB661EA1923;
        Tue, 12 Apr 2022 10:01:22 +0200 (CEST)
Message-ID: <88760cd1-d1ed-8952-d061-15e238b2ec57@molgen.mpg.de>
Date:   Tue, 12 Apr 2022 10:01:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH] drm/amd/amdgpu: Not request init data for MS_HYPERV with
 vega10
Content-Language: en-US
To:     Alex Deucher <alexdeucher@gmail.com>,
        Yongqiang Sun <yongqiang.sun@amd.com>
Cc:     Jingwen Chen <jingwen.chen2@amd.com>,
        "Luo, Zhigang" <zhigang.luo@amd.com>,
        amd-gfx@lists.freedesktop.org, monk.liu@amd.com,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
References: <20220411135939.906700-1-yongqiang.sun@amd.com>
 <f06ce5e3-158b-88a8-06f0-53b88c4fad45@molgen.mpg.de>
 <CADnq5_PSZX+11meHYn9CR3A4LiseGo30TwbkOuPgTQsfbYxmCg@mail.gmail.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CADnq5_PSZX+11meHYn9CR3A4LiseGo30TwbkOuPgTQsfbYxmCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Cc: +x86 folks]

Dear Alex, dear x86 folks,


x86 folks, can you think of alternatives to access `X86_HYPER_MS_HYPERV` 
from `arch/x86/include/asm/hypervisor.h` without any preprocessor ifdef-ery?


Am 11.04.22 um 18:28 schrieb Alex Deucher:
> On Mon, Apr 11, 2022 at 11:28 AM Paul Menzel wrote:

[…]

>> Am 11.04.22 um 15:59 schrieb Yongqiang Sun:
>>> MS_HYPERV with vega10 doesn't have the interface to process
>>> request init data msg.
>>
>> Should some Hyper-V folks be added to the reviewers list too?
>>
>>> Check hypervisor type to not send the request for MS_HYPERV.
>>
>> Please add a blank line between paragraphs.
>>
>>> Signed-off-by: Yongqiang Sun <yongqiang.sun@amd.com>
>>> ---
>>>    drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c | 12 ++++++++++--
>>>    1 file changed, 10 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>>> index 933c41f77c92..56b130ec44a9 100644
>>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c
>>> @@ -23,6 +23,10 @@
>>>
>>>    #include <linux/module.h>
>>>
>>> +#ifdef CONFIG_X86
>>> +#include <asm/hypervisor.h>
>>> +#endif
>>> +
>>>    #include <drm/drm_drv.h>
>>>
>>>    #include "amdgpu.h"
>>> @@ -721,8 +725,12 @@ void amdgpu_detect_virtualization(struct amdgpu_device *adev)
>>>                        break;
>>>                case CHIP_VEGA10:
>>>                        soc15_set_virt_ops(adev);
>>> -                     /* send a dummy GPU_INIT_DATA request to host on vega10 */
>>> -                     amdgpu_virt_request_init_data(adev);
>>> +#ifdef CONFIG_X86
>>> +                     /* not send GPU_INIT_DATA with MS_HYPERV*/
>>> +                     if (hypervisor_is_type(X86_HYPER_MS_HYPERV) == false)
>>> +#endif
>>
>> Why guard everything with CONFIG_X86? (If it’s needed, it should be done
>> in C code.)
> 
> X86_HYPER_MS_HYPERV only available on x86.

Sorry, I missed the X86 dependency when quickly looking at the Hyper-V 
stub IOMMU driver `drivers/iommu/hyperv-iommu.c`, but missed that 
`HYPERV_IOMMU` has `depends on HYPERV && X86`.


Kind regards,

Paul


>>> +                             /* send a dummy GPU_INIT_DATA request to host on vega10 */
>>> +                             amdgpu_virt_request_init_data(adev);
>>>                        break;
>>>                case CHIP_VEGA20:
>>>                case CHIP_ARCTURUS:
>>
>>
>> Kind regards,
>>
>> Paul
