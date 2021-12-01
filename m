Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707494644A2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 02:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345519AbhLABxa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 20:53:30 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37376 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230168AbhLABx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 20:53:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E109BB81BBC
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 01:50:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C39DAC53FCB;
        Wed,  1 Dec 2021 01:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638323406;
        bh=0mwtVUg0Pjtr2xBEyZ4NHyUmo7aycFpcv9dwp7BLvCo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GNFVE43Bi7zLPvCSK+0s10l/HyHQds5YiK5hQcLOvFMvOcJJlmugeac8ZbqHJ0eBl
         Uhe31sh2eCyOSI74CMHkmof0VsNJp5PLOvMqNGLw020xiumR0NIDWBph+yIR9prOQs
         RRvXX7Dq7VCXzmEZoo8CBsPP53mt1xFyqRuvVKdl83b7VDnpIoTqDFffS7J1XBMIch
         WseKCriThB7LFmOy/dCnrEa6jpuK4d9iO/oGGs3eSO7fIov6jBPLL73hLWCZr5exA4
         7YGKmHAHsbgdUpvqCBm9Bd+wwwWzRVz+N2ykpEKDp5IM0tzhTMGL20gtuwRhEP14tD
         1iBTFrttuQAlA==
Date:   Wed, 1 Dec 2021 10:50:01 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     "liuqi (BA)" <liuqi115@huawei.com>
Cc:     Linuxarm <linuxarm@huawei.com>,
        Mark Rutland <mark.rutland@arm.com>, <catalin.marinas@arm.com>,
        <will@kernel.org>, <naveen.n.rao@linux.ibm.com>,
        <anil.s.keshavamurthy@intel.com>, <davem@davemloft.net>,
        <linux-arm-kernel@lists.infradead.org>,
        <song.bao.hua@hisilicon.com>, <prime.zeng@hisilicon.com>,
        <robin.murphy@arm.com>, <f.fangjian@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] arm64: kprobe: Enable OPTPROBE for arm64
Message-Id: <20211201105001.5164f98ba783e7207df1229c@kernel.org>
In-Reply-To: <9fdb2ad3-539f-fb4d-7a96-c737fec967f7@huawei.com>
References: <20210818073336.59678-1-liuqi115@huawei.com>
        <20210818073336.59678-3-liuqi115@huawei.com>
        <20210824105001.GA96738@C02TD0UTHF1T.local>
        <aebcfbcb-eded-ff48-9d1f-2a93539575ca@huawei.com>
        <20211127212302.f71345c34e5a62e5e779adb2@kernel.org>
        <4998f219-eb47-a07c-b3ed-c2ae46a77230@huawei.com>
        <20211129140040.87c5f423a72c95c90602c2c6@kernel.org>
        <3f8c1754-b677-971c-2e04-a04678206424@huawei.com>
        <20211129233514.e59d953a7d90d9f4f3d6a097@kernel.org>
        <9fdb2ad3-539f-fb4d-7a96-c737fec967f7@huawei.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Nov 2021 14:48:06 +0800
"liuqi (BA)" <liuqi115@huawei.com> wrote:

> 
> 
> On 2021/11/29 22:35, Masami Hiramatsu wrote:
> >>>>>> Hi all,
> >>>>>>
> >>>>>> I meet a problem when I use SYM_CODE_START(optprobe_template) to replace
> >>>>>> optprobe_template_entry.
> >>>>>>
> >>>>>> If SYM_CODE_START is used, all optprobe will share one trampoline space.
> >>>>>> Under this circumstances, if user register two optprobes, trampoline
> >>>>>> will be overwritten by the newer one, and this will cause kernel panic
> >>>>>> when the old optprobe is trigger.
> >>>>> Hm, this is curious, because the template should be copied to the
> >>>>> trampoline buffer for each optprobe and be modified.
> >>>>>
> >>>>>> Using optprobe_template_entry will not have this problem, as each
> >>>>>> optprobe has its own trampoline space (alloced in get_opinsn_slot()).
> >>>>> Yes, it is designed to do so.
> >>>>>
> >>>>> Thank you,
> >>>>>
> >>>> Hi Masami,
> >>>>
> >>>> Thanks for your reply. But I also met a problem when using
> >>>> get_opinsn_slot() to alloc trampoline buffer.
> >>>>
> >>>> As module_alloc(like x86) is used to alloc buffer, trampoline is in
> >>>> module space, so if origin insn is in kernel space, the range between
> >>>> origin insn and trampoline is out of 128M.
> >>>>
> >>>> As module PLT cannot used here, I have no idea to achieve long jump in
> >>>> this situation. Do you have any good idea?
> >> Hi Masami,
> >>
> >> Thanks so much for your reply.
> >>
> >>> One possible solution is to use pre-allocated trampoline space in
> >>> the text area, as same as ppc64 does.
> >>> (See arch/powerpc/kernel/optprobes_head.S, it embeds a space at "optinsn_slot")
> >>>
> >> I find something interesting in arch/powerpc/kernel/optprobes.c, it use
> >> "optinsn_slot" as a public buffer, and use a static "insn_page_in_use"
> >> to make sure there is only one optprobe in kernel.
> >>
> >> If we use this solution , users could only register one optprobe each
> >> time. This will also be a limitation for users, what's your opinion
> >> about this?
> > No, that is just a memory area for pooling trampoline buffer. So optprobe
> > can allocate the buffer from that area. Please see kernel/kprobes.c:344.
> > optprobe allocates "insn_slot" from kprobe_optinsn_slots, which uses
> > alloc_optinsn_page() to allocate the pool of slots.
> > 
> > Thank you,
> > 
> 
> Hi,
> 
> Thanks for your reply, I test alloc_optinsn_page() and it does work well 
> to alloc the pool of slots.
> 
> But when I tried to use module PLT, something seems wrong here.
> Arm64 Module PLT in mod->arch.ftrace_trampolines is set in 
> module_finalize, after that, mod->arch.ftrace_trampolines seems to be a 
> read-only memory. But in arch_optimize_kprobes() we need to modify the 
> destination of PLT (as each optprobe has its own trampoline buffer), if 
> so, we cannot get rid of the 128M branch limit :(

Hmm, OK, we need to introduce trampoline buffer allocation pool for modules
for such arch. But that should be another story. I think you should start
from the core-kernel. At this moment, if the probe address is in the module,
please return -ERANGE from arch_prepare_optimized_kprobe().
Module support must be done in the next step (series), since that will involve
the kprobes generic code change.

Thank you,

> 
> Thanks,
> Qi


-- 
Masami Hiramatsu <mhiramat@kernel.org>
