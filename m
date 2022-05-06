Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E726351D44A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 11:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390525AbiEFJ0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 05:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390570AbiEFJZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 05:25:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8E1A169284;
        Fri,  6 May 2022 02:21:34 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CC3E9ED1;
        Fri,  6 May 2022 02:21:33 -0700 (PDT)
Received: from [10.57.0.148] (unknown [10.57.0.148])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C01AC3FA31;
        Fri,  6 May 2022 02:21:31 -0700 (PDT)
Message-ID: <687b78b5-5671-5317-ce9e-98720bb533fa@arm.com>
Date:   Fri, 6 May 2022 10:21:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCHv14 2/9] coresight: etm4x: Use asm-generic IO memory
 barriers
To:     Sai Prakash Ranjan <quic_saipraka@quicinc.com>, arnd@arndb.de,
        catalin.marinas@arm.com, rostedt@goodmis.org
Cc:     gregkh@linuxfoundation.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        maz@kernel.org, quic_psodagud@quicinc.com, quic_tsoni@quicinc.com,
        will@kernel.org, Mathieu Poirier <mathieu.poirier@linaro.org>
References: <cover.1651663123.git.quic_saipraka@quicinc.com>
 <0d76de0ecc0aa7cb01fd8b8863a8e567abd4410b.1651663123.git.quic_saipraka@quicinc.com>
 <483bb401-13e6-8c52-4b5f-f3c635b9ad46@arm.com>
 <b44a0e0b-ee86-3b08-0103-3ccee94e3270@quicinc.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <b44a0e0b-ee86-3b08-0103-3ccee94e3270@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2022 04:02, Sai Prakash Ranjan wrote:
> Hi Suzuki,
> 
> On 5/6/2022 5:14 AM, Suzuki K Poulose wrote:
>> Hi,
>>
>> On 04/05/2022 12:28, Sai Prakash Ranjan wrote:
>>> Per discussion in [1], it was decided to move to using architecture
>>> independent/asm-generic IO memory barriers to have just one set of
>>> them and deprecate use of arm64 specific IO memory barriers in driver
>>> code. So replace current usage of __io_rmb()/__iowmb() in drivers to
>>> __io_ar()/__io_bw().
>>>
>>> [1] 
>>> https://lore.kernel.org/lkml/CAK8P3a0L2tLeF1Q0+0ijUxhGNaw+Z0fyPC1oW6_ELQfn0=i4iw@mail.gmail.com/ 
>>>
>>>
>>
>> Looking at the dis-assembly it looks like in effect they are slightly
>> different for arm64.
>>
>> i.e., before this patch we had
>>
>> "dmb osh{ld/st}"
>>
>> and after the patch we have :
>>
>> "dsb {ld/st}"
>>
>> Is this really what we want ? I don't think this is desirable.
>>
>> Suzuki
>>
> 
> No, this is not supposed to happen and I do not see how it could happen.
> __io_ar() is defined as __iormb() and __io_bw() is __iowmb().
> 
> I checked the disassembly in both case with MMIO trace off/on with 
> __etm4_cpu_save()
> as below and saw the same number of "dmb"s.
> 
> aarch64-linux-gnu-gdb -batch -ex "disassemble/rs __etm4_cpu_save" 
> vmlinux-without-mmio
> aarch64-linux-gnu-gdb -batch -ex "disassemble/rs __etm4_cpu_save" 
> vmlinux-with-mmio
> 
> Can you tell me how are you validating if I am missing something?

Apologies, I was missing the patch in this series, which adds
the arm64 definition for __io_ar/__io_bw. (hint: Please Cc
the affected subsystem in the Cover letter for the series, so
we know what the intention of the changes are).

With the patch1, yes this makes sense to me. Otherwise, __io_ar()
is default to rmb() which implies dsb ld.

With that said,

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
