Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7ABF57A820
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 22:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239486AbiGSUQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 16:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236808AbiGSUQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 16:16:34 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93AD640BF2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 13:16:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=g92KGzzs1Lrj8LYPruXCmLI2322Fr4hPe/vbEF/2wP8=; b=V0QerpO8GZCO8a23n3oRxeSdMY
        qXIObJqT/YqDWYyxxauG3Ob78GEecubtWoZMGaQKPlwyc2I7J/XBhJpSiGSSVzBBD6AtoVaeuQx1N
        da7Mcaxf218nOUY6anKOW3J2Da4iXegoUDOyroXfAFDiAao9WT1pLhykq098TgJGBKnlwhASD2W7u
        UJvNni7/H5fv3cA4rBfkCAE6HHisKCk4MmEY4/QjW+ADsT6bIMRpRTdwbW53FRmgLXYWvJwdZ1hCy
        9LtXc+NEgMn7oAPbjU0tlWtQYPYnH0lBfI9uSbcfXTIc8sa3kj0mDwFi57VwdpJ9rgkYG0WxSiPEy
        OhPdNH/g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDtdd-005AFx-Jv; Tue, 19 Jul 2022 20:16:13 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id B96289802A4; Tue, 19 Jul 2022 22:16:11 +0200 (CEST)
Date:   Tue, 19 Jul 2022 22:16:11 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Michael Kelley (LINUX)" <mikelley@microsoft.com>
Cc:     Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: Re: Virt Call depth tracking mitigation
Message-ID: <YtcRC0A8TvEHsMqJ@worktop.programming.kicks-ass.net>
References: <20220716230344.239749011@linutronix.de>
 <4ca4a4ab-6ea0-d94a-59cc-1ab99ff869d5@citrix.com>
 <PH0PR21MB30250D66D36B5D94C809BE31D78F9@PH0PR21MB3025.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH0PR21MB30250D66D36B5D94C809BE31D78F9@PH0PR21MB3025.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 02:45:40PM +0000, Michael Kelley (LINUX) wrote:

> In Hyper-V, the hypercall page is *not* writable by the guest.  Quoting
> from Section 3.13 in the Hyper-V TLFS:
> 
>     The hypercall page appears as an "overlay" to the GPA space; that is,
>     it covers whatever else is mapped to the GPA range. Its contents are
>     readable and executable by the guest. Attempts to write to the
>     hypercall page will result in a protection (#GP) exception.
> 
> And:
> 
>     After the interface has been established, the guest can initiate a
>     hypercall. To do so, it populates the registers per the hypercall protocol
>     and issues a CALL to the beginning of the hypercall page. The guest
>     should assume the hypercall page performs the equivalent of a near
>     return (0xC3) to return to the caller.  As such, the hypercall must be
>     invoked with a valid stack.

I'm hoping that these days you're following that 0xc3 with a 0xcc at the
very least ?

IIRC the whole hyper-v thing is negotiated using (virtual) MSRs, would
it be possible to write the address of a return thunk into an MSR and
have the hypervisor rewrite the hypercall page accordingly?

This is needed for the AMD jmp2ret thing anyway. Or you get to eat an
IBPB before every hypercall, which I'm guessing your performance people
aren't keen on.
