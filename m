Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85304FC27C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 18:35:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348572AbiDKQiI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 12:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244545AbiDKQiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 12:38:06 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6454D1E3EF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 09:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1649694951; x=1681230951;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=K5lFWxWsi+Ws0ONYh0a01lTDsJWyTl8xXrRj3aWLpy8=;
  b=HiejiT+ZrMdChmnzQfZZH5fdoUiObBkcZpMdLAX4SPCh2CFWoNdQ5hZ4
   E7F37owbmnYOILc4XihIC1KEm6wtwwi1uKraRxUbrO+Qm+cy24i1Qiksq
   TeNK7qJ2v+7GNW8Jjo+bGuo3CB75eWsSqi308aO/I0MVQeuwJ/F9i5bkg
   s=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 11 Apr 2022 09:35:50 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 09:35:50 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 11 Apr 2022 09:35:50 -0700
Received: from [10.226.58.18] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Mon, 11 Apr
 2022 09:35:49 -0700
Message-ID: <30a825d5-1739-3095-7217-2e109951251b@quicinc.com>
Date:   Mon, 11 Apr 2022 10:35:49 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
Subject: Re: x86 multi-msi w/o iommu
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Marc Zyngier <maz@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <6410d0d5-bd88-64d5-6ae7-cca33746b302@quicinc.com>
 <877d7yhve7.ffs@tglx>
From:   Jeffrey Hugo <quic_jhugo@quicinc.com>
In-Reply-To: <877d7yhve7.ffs@tglx>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/9/2022 2:08 PM, Thomas Gleixner wrote:
> Jeffrey!
> 
> On Fri, Apr 08 2022 at 11:34, Jeffrey Hugo wrote:
>> I'd like to get multi-MSI without IOMMU working on x86. I'm hoping you
>> could help me understand the current state of things, and if there is
>> a path toward enabling this.
> 
> Hope is definitely required here, but you did not explain yet WHY you
> want that to work. Making it work just because is not really a good
> starting point.

Arguably Linux exists "just because", but its a fair question.

Someone made a request for this.  Trying to figure out the logistics of 
the request before responding to the requestor.

There is a particular device that due to hardware limitations (arguably 
mistakes were made) it only supports MSI and it requires more than 1 MSI 
to work.

While the device is documented as requiring an IOMMU on x86, the 
requesting entity wants to use the device without an IOMMU in a unusual 
setup and pointed it that it works (for some definition of working) on 
other Operating Systems.  So from their viewpoint is not a system issue, 
but a Linux issue.

Granted, I suspect you disagree with this being a Linux issue per the 
below.  I'm trying to understand all of the aspects.

I suspect this is not the level of detail you would like, but from my 
perspective parts of this situation are sensitive so I'm trying to 
proceed as best I can currently (arguably with one hand tied behind my 
back).  To be clear, this level of secrecy is unacceptable when working 
with the community and if I were to move forward to propose changes 
based on the information you've provided, I would be more transparent.

I greatly appreciate your response given the limitations in what I've 
provided.

>> This is an overly simplistic assessment, but this reportedly works in
>> other OSes, so it looks like Linux is broken in comparison.
>>
>> In my investigation so far, the failure stems from
>> x86_vector_alloc_irqs() in arch/x86/kernel/apic/vector.c [1].
> 
> The failure? That's not a failure, that's a deliberate decision.

I'm sorry, I choose my words poorly.  I was viewing things from the 
perspective of reproducing the reported "issue" and seeing why that is 
the case.  The device requests multiple MSIs and doesn't get them, which 
is a "failure" from the perspective that the expectation is things work.

I do however see that this is deliberate per the code, and thus would 
like to understand why.  Fundamentally, that is why I asked you for help.

 From one perspective, its a "failure", from another, its "working as 
intended".  I did not intend any offense, and I'm more interested with 
understanding the "why" than applying a specific label.

> Side note: Please spare us the links to random code sites and git web
> interfaces. A function name and a commit id is good enough.
> 
>> If we need a contiguous allocation of more than one irq, the
>> allocation immediately fails:
>>
>> 	/* Currently vector allocator can't guarantee contiguous allocations */
>> 	if ((info->flags & X86_IRQ_ALLOC_CONTIGUOUS_VECTORS) && nr_irqs > 1)
>> 		return -ENOSYS;
>>
>> As I'm sure you are aware, this only impacts MSI without IOMMU as both
>> MSI-X and MSI with IOMMU can handle a discontinuous allocation (the flag
>> is not set for either of those cases).
>>
>> That check was added back in 2015 with [2].
> 
> X86 never supported multi-MSI in Linux. See:
> 
>      commit 1c8d7b0a562d ("PCI MSI: Add support for multiple MSI")
> 
>> In 2017, it looks like you refactored the allocator to the irq_matrix
>> component [3].  However, the limitation remains to today.
> 
> For very good reasons.
> 
>> Digging a bit further, it looks like the internal function
>> matrix_alloc_area() [4] is capable of doing a contiguous allocation, but
>> all the callers of that via the public api hardcode num to 1.  I
>> wouldn't say it would be trivial to refactor the irq_matrix public api
>> to do a contigious range allocation, and refactor
>> x86_vector_alloc_irqs() to do that based on
>> X86_IRQ_ALLOC_CONTIGUOUS_VECTORS, but since it seems like that hasn't
>> been tackled in 5-7 years (depending on how you look at the history), I
>> suspect I'm missing something.
> 
> There are two fundamental issues with multi-MSI:
> 
>     1) General
> 
>        a) Multi-MSI is a single MSI message. The device sets the vector
>           offset in the lower bits of message data.
> 
>        b) As a consequence the Multi-MSI interrupts of a given device are
>           all affine to a single target and you cannot set affinity for
>           them separately, which limits the usefulness very much.
> 
>     2) x86
> 
>        a) Due to #1a this requires N consecutive vectors on one CPU and
>           these vectors have to be aligned so that the device can set the
>           vector offset into the lower bits of message data. The
>           alignment requirement depends on the number of vectors and is
>           always power of 2 in the range (2, 4, 8, 16, 32).
> 
>           Easy to do in theory. But in practice there is the limited
>           vector space on x86 (~200) for device interrupts per CPU.
> 
>           That creates a problem for allocations in general and for CPU
>           hotplug. On hotplug all active interrupts are moved away from
>           the outgoing CPU. Due to the alignment requirement this is
>           pretty much a guarantee for vector exhaustion.
> 
>        b) Changing interrupt affinity for MSI w/o IOMMU is an interesting
>           exercise on X86 when the interrupt is not maskable, which is
>           unfortunately the case in the majority of MSI hardware
>           implementations.
> 
>           In that case while the new vectors are installed interrupts can
>           be issued by the device. So you need to be very careful _not_
>           to lose an interrupt in the case that both the message address
>           (the target APIC) and the message data (the vector) are
>           changed. You can find the gory details in:
> 
>                    arch/x86/kerne/apic/msi.c::msi_set_affinity()
> 
>           and the related change logs espescially:
>           6f1a4891a592 ("x86/apic/msi: Plug non-maskable MSI affinity race")
> 
>           Due to #1b changing interrupt affinity has to move _all_
>           vectors associated to the device at once, which makes this
>           excercise even more interesting.
> 
>           This code is already horrible as hell and the thought alone to
>           expand it for multi MSI makes me shudder.
> 
> Now with interrupt remapping all of the above goes away:
> 
>      - The alignment problem and consecutive space issue moves into
>        the remap tables which have plenty of space.
> 
>      - Each interrupts affinity can be individually controlled because
>        the affinity setting happens in the remap table and does not
>        require the horrors of the non remapped case.
> 
> That means in Multi-MSI can be implemented on x86 w/o remapping, but is
> it worth the trouble? From looking at the problem space and under
> consideration that the advantage of multi-MSI is very limited the
> decision was made to not support it. That's not broken as you claim,
> that's a very reasonable technical decision.

Again, sorry I choose my words poorly.  I understand the summary of the 
issues which lead to the decision, which I did not previously understand 
before.  I think I need to dig into the references you provided to fully 
comprehend the situation and come to the same conclusion.

I think the above is what I was looking for.  I thank you for 
elaborating on the issues and pointing me toward where I can learn more.

>  From experimentation I know that multi-MSI w/o remapping has a very
> limited benefit because it cannot provide scalability through
> parallelism obviously. The only benefit is a clear separation of
> interrupt functionality which spares a MMIO read to get the pending bits
> and a few conditionals. Here is a trivial experiment to demonstrate the
> benefit or the lack of it:
> 
>      Use a system with interrupt remapping and add a module parameter to
>      your driver which allows you to select ONE or MANY MSIs. Then run
>      performance tests with both setups.
>      
> The result might not be what you expect depending on the device and the
> resulting interrupt patterns.

This is a fine suggestion and if it were possible, I would go forward 
with it rather than investigate understanding the issues and developing 
a solution to address them (under the assumption its possible, theory 
and reality are often different).

Sadly, as mentioned, device limitations prevent operation with just one 
MSI which is why I'm seeking to understand if multi-MSI with no IOMMU is 
possible in Linux.  As you point out below sometimes software is put in 
an unfortunate position ("between a rock and a hard place").  All I can 
do is evaluate the various options and pick the least bad one.  Right 
now, I don't know that $SUBJECT is the best option, but I think I can 
evaluate it and compare based on your assistance.

> The problems of MSI are known since two decades, but hardware folks
> still insist on it. MSI-X exists for a reason, but sure it makes the
> chips $0.01 more expensive and lots of hardware people still work under
> the assumption that whatever they get wrong can be fixed in software,
> which is unfortunately wishful thinking >
> I hope this clarifies it for you.

Yes, very much so.  Thank you!

-Jeff
