Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D947C598CA3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 21:36:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241003AbiHRTe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 15:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbiHRTex (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 15:34:53 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE229CE47B;
        Thu, 18 Aug 2022 12:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=eQTG/989/DAu6Exi05B4ixu+5J4EP6ThaWhb/xNoy+s=; b=Xf4Ah/68SvKJXBUh3t+EzcI/kl
        p0SaEWsgfgYL4IeuEygr6avs8qZMXojf5td0sD+sqXd0PjU+5Wp324p1dQEG59JiMaCV9jYqBhk5x
        tKdsy7i29Vixdm2oe2vuctWNtujThsTu4TcEuoKxdAsLtNPQWe9Am+KylYFNWVErk+6SQDxXi/tVh
        3DIsSAN1x/v2RipIg5LRRH8Gm/03DpxvzJdT/t43hmlUaAkWMHAoJXkSubNqBPtTO+oma6YUAcVYV
        UwV4JGX7IyuLLckngrOo5vh/XVkh+vQM0X3RlMSfUJme6tsYaWWTWkhhUCHQMYni9V/kAPNvzJo/8
        vHEtPcxQ==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oOlHz-008gDy-TP; Thu, 18 Aug 2022 19:34:48 +0000
Message-ID: <df284479-9981-9983-7775-81d7d7875dac@infradead.org>
Date:   Thu, 18 Aug 2022 12:34:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: build failure of next-20220817 for amdgpu due to 7bc913085765
 ("drm/amdkfd: Try to schedule bottom half on same core")
Content-Language: en-US
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        linux-next <linux-next@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx mailing list <amd-gfx@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <Yv1lepjhg/6QKyQl@debian>
 <CADnq5_Od9W1iuzYpsmODOB=Xem97ogeH_t0JrjWC-S8h0XM9fA@mail.gmail.com>
 <5638aaf1-b808-bdc6-d84a-820f24facea6@infradead.org>
 <CADVatmNA6-qCJEHNn-gRO6Nx88SsTrPsJn_F5J0NiFhyvijNxA@mail.gmail.com>
 <c1869a4b-ead1-2ae5-c9ec-61834b578216@infradead.org>
 <CADVatmPCd5KQ0mAfQGHvqVGFJtK+fyQPB4XUktgfc3fzYJvyCg@mail.gmail.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <CADVatmPCd5KQ0mAfQGHvqVGFJtK+fyQPB4XUktgfc3fzYJvyCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 8/18/22 12:15, Sudip Mukherjee wrote:
> On Thu, Aug 18, 2022 at 4:10 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>>
>>
>> On 8/18/22 03:43, Sudip Mukherjee wrote:
>>> On Thu, Aug 18, 2022 at 3:09 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>>>>
>>>>
>>>>
>>>> On 8/17/22 19:01, Alex Deucher wrote:
>>>>> On Wed, Aug 17, 2022 at 6:03 PM Sudip Mukherjee (Codethink)
>>>>> <sudipm.mukherjee@gmail.com> wrote:
>>>>>>
>>>>>> Hi All,
>>>>>>
>>>>>> Not sure if it has been reported, build of next-20220817 fails with the
>>>>>> error:
>>>>>>
>>>>>> ERROR: modpost: "cpu_smallcore_map" [drivers/gpu/drm/amd/amdgpu/amdgpu.ko] undefined!
>>>>>>
>>>>>> Trying to do a git bisect to find out the offending commit.
>>>>>>
>>>>>
>>>>> Thanks.  I don't see that symbol in the driver at all.  Not sure where
>>>>> it is coming from.
>>>>>
>>>>
>>>> It's powerpc only.
>>>>
>>>> Sudip, is it non-CONFIG_SMP by any chance?
>>>
>>> Ohhh.. really sorry for the incomplete report. I should not try to
>>> mail while travelling.
>>>
>>> The error is seen with powerpc allmodconfig and it has CONFIG_SMP=y.
>>
>> OK, I see that also, but it doesn't make any sense (to me).
>>
>> I did 'objdump' on the code file (amdgpu.o) and it's listed as
>> undefined but there are no code references to it.
> 
> cpu_smt_mask() is called by drivers/gpu/drm/amd/amdkfd/kfd_device.c.
> and cpu_smt_mask() is an inline function in
> arch/powerpc/include/asm/smp.h which is doing "return
> per_cpu(cpu_smallcore_map, cpu);"
> 
> So, the offending commit is 7bc913085765 ("drm/amdkfd: Try to schedule
> bottom half on same core").

Thanks for digging that up.

It just needs to have that symbol exported I think.
This builds cleanly now.
I can submit it or one of the AMD gfx developers can do so.


---
 arch/powerpc/kernel/smp.c |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -86,6 +86,7 @@ DEFINE_PER_CPU(cpumask_var_t, cpu_core_m
 static DEFINE_PER_CPU(cpumask_var_t, cpu_coregroup_map);
 
 EXPORT_PER_CPU_SYMBOL(cpu_sibling_map);
+EXPORT_PER_CPU_SYMBOL(cpu_smallcore_map);
 EXPORT_PER_CPU_SYMBOL(cpu_l2_cache_map);
 EXPORT_PER_CPU_SYMBOL(cpu_core_map);
 EXPORT_SYMBOL_GPL(has_big_cores);


-- 
~Randy
