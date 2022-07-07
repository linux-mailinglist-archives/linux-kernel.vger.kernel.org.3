Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347A3569893
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 05:05:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234837AbiGGDFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 23:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbiGGDFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 23:05:32 -0400
Received: from mailbox.box.xen0n.name (mail.xen0n.name [115.28.160.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCF602E9EA
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 20:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xen0n.name; s=mail;
        t=1657163127; bh=3fMmtr4cgbsob89vngXI1qnEjO+r9ALND5XHCDGdjL8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=HKbDT6WSnay7gmalfGk/E/ZiOH09Wgr96rCZURtwRpOysQW9O5vEAHB+QcCGUzIEg
         clVc/Am/XDAFLAfTl65QfDe6VdtZOYrq7kfA4BUFY/aW+0ccShZIjKvtgb3m27OAt3
         /BsekbHlHyDPJkuC8LGMR2+/jT7jy07kptAf5zMY=
Received: from [100.100.57.190] (unknown [220.248.53.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailbox.box.xen0n.name (Postfix) with ESMTPSA id B653660114;
        Thu,  7 Jul 2022 11:05:26 +0800 (CST)
Message-ID: <0583a335-72f7-55cf-3cd9-4dbd8109a440@xen0n.name>
Date:   Thu, 7 Jul 2022 11:05:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:104.0)
 Gecko/20100101 Thunderbird/104.0a1
Subject: Re: [PATCH v2] LoongArch: Clean useless vcsr in loongarch_fpu.
Content-Language: en-US
To:     Qi Hu <huqi@loongson.cn>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Xi Ruoyao <xry111@xry111.site>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     Xuerui Wang <kernel@xen0n.name>, loongarch@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>
References: <20220704153612.314112-1-huqi@loongson.cn>
 <4273e104-8392-6a06-5d18-a1933978d8c3@xen0n.name>
 <22a1ba993e298ce12a374decefebeca484240883.camel@xry111.site>
 <16c9ccaa5e5a2ffd39272cff6f66e487c659b571.camel@xry111.site>
 <CAAhV-H5+qd1ZrOqE8fgRmWshXy57AfEFpyKSK8ZstZZEQ53owQ@mail.gmail.com>
 <ac46f5cb4c8d1154cfc3e862fb5211e869839c9a.camel@xry111.site>
 <c824b9ca-c9c4-1912-7845-99a0989277a4@loongson.cn>
 <9d064771-9402-4e84-96f8-4713cddf42f2@www.fastmail.com>
 <730cb4c4-a6a3-783e-3e4c-7c2bdc35c088@loongson.cn>
From:   WANG Xuerui <kernel@xen0n.name>
In-Reply-To: <730cb4c4-a6a3-783e-3e4c-7c2bdc35c088@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/7 09:29, Qi Hu wrote:
>
> On 2022/7/7 04:49, Jiaxun Yang wrote:
>>
>> 在2022年7月6日七月 上午5:00，Qi Hu写道：
>>> On 2022/7/6 10:51, Xi Ruoyao wrote:
>>>> On Wed, 2022-07-06 at 10:35 +0800, Huacai Chen wrote:
>>>>
>>>>> Maybe Xuerui and Ruoyao have some misunderstanding. LSX/LASX will
>>>>> surely be upstream, this has nothing to do with cleanup VCSR16.
>>>>> Because FP/LSX/LASX share the same control bits in FCSR now.
>>>> My guess:
>>>>
>>>> Almost all behavior of vector unit is controlled by FCSR (for example,
>>>> the rounding of both FPU and vector unit should be controlled by FCSR
>>>> altogether), except one bit similar to the bit 24 of MSACSR ("flush to
>>>> zero") is in VCSR [^1].  And "flush to zero" is not really useful 
>>>> so it
>>>> will be removed in 3A6000, and we'll not use it for 3A5000.
>>> Actually, flush to zero has been removed in 3A5000.
>>>> [^1]: A more bold guess: the hardware engineers could have just said
>>>> "let's wire this register called MSACSR in GS464V as FCSR16/VCSR in
>>>> LA464, maybe it will be useful and who knows?"  But now in practice 
>>>> it's
>>>> not useful.
>>>>
>>>> Am I correct?
>>> The hardware(LA464) has removed the vcsr("has but not use" is
>>> incorrect), and here are some details:
>>>
>>> - For all FP operations, including LSX/LASX, they are controlled by
>>> fcsr0/1/2/3.
>>>
>>> - For LSX/LASX other operations, they are *not* controlled by any other
>>> CSR now. And fcsr16 to fcsr31 are reserved to control these operations
>>> (now they are *undefined*).
>> Sorry but what do you meant by “these” here?
> "These operations" means "LSX/LASX other operations", except its 
> floating-point operations.

This is getting hard to follow. Assuming the expression "LSX/LASX other 
operations" is Chinglish (it's certainly not proper English), I think 
you mean "the non-FP operations belonging to LSX/LASX" here right?

And it's strange, that these ops do exist in LSX/LASX, hence also 
present in 3A5000, but the control bits are undefined. How come this is 
even possible?

>> If it means LSX/LASX, are you trying to say that future chip’s 
>> LSX/LASX won’t be
>> compatible with present 3A5000? As your said fcsr16 and fcsr31 are 
>> undefined
>> for now.
>>
>> Thanks
>> -
>
> "not compatible" is incorrect. If future chips add new features to 
> define and use these registers, some bits in CPUCFG should be set, 
> like CPUID in X86.
>
> And at that time, if the applications do not use these new 
> features(like some old apps), they can run at *default* state which is 
> the same as current 3A5000.
>
> So, "reserved" is just to prepare for adding something, not 
> "incompatible".

To be frank, at this point I think you're trying to hide something. 
(This is not your fault, blame someone else of course because they told 
you the fact.) In the old-world kernel the VCSR a.k.a. FCSR16 is 
certainly being saved/restored, and there's apparently no harm in doing 
so. And if the contents are indeed "undefined", why are the code there 
in the first place? Certainly the bits *are* meaningful, only that for 
some reason you aren't revealing the semantics and pretending that they 
are "undefined" and probably "do nothing externally observable" if 
accessed in the first place.

Then, either

(1) I am wrong and being hyper-aggressive here (and if it turns out to 
be the case, I'd immediately apologize for that), and the VCSR is indeed 
only meaningful for some early development steppings of 3A5000, and does 
nothing on the 3A5000 we all have now;

or, (2) the VCSR is still relevant for the "other" applicable LSX/LASX 
ops on 3A5000, but this patch is taking the VCSR out thus rendering such 
ops unreliable/incorrect in case they depend on the additional state.

Either way, the new-world kernel is handling LSX/LASX differently from 
the old-world, and I fear this would create unnecessary churn both in 
kernel and downstream projects already carrying LSX/LASX assembly, in 
case they actually used said ops. I can't rule out such possibility 
because at this time all LSX/LASX assembly was written by Loongson 
people with access to the manuals, and tested on old-world systems, so 
they might not be aware that some non-FP ops are going to magically 
change behavior on new-world systems because VCSR is suddenly not being 
saved/restored.

(Actually, people outside of Loongson might never know if (2) is the 
case, because the insns dependent on VCSR could be simply deleted from 
manuals, so they "don't exist" for outsiders, and "compatibility" of 
course doesn't suffer.)

>
> Thanks.
>
>>> - Flush to zero(MSACSR.FS) is removed and not supported.
>>>
>>> - If you use "movfcsr2gr" to read the fcsr16, the value is *UNDEFINED*.
>
