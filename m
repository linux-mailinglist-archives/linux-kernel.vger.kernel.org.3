Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0BA54CE682
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 20:04:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbiCETFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 14:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiCETE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 14:04:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136297A9BF;
        Sat,  5 Mar 2022 11:04:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 91FEF60B3B;
        Sat,  5 Mar 2022 19:04:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B6BFC004E1;
        Sat,  5 Mar 2022 19:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646507046;
        bh=z9qsqCnRoprXuCmYoVSudLuALkSMt5N4bc625kH6jQU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bkGhFm9p9HGdMhdVX9JabL/Uck+Oczp//tDoJjgXMYy0skcfLo/ZtcPFEWOSwTyhh
         5Hx3PuQobzI0/vLzUmdWJbYolyR7oc/uJASFmuO0NcPjv2qUasxncwFAtHsQt5YGle
         7xswOrN4+S8XvxYzYcQtgdoHE5Uz3bHwWCLvMJzuS5bI4GRc51R8y6zUHi35td2LHb
         YJ169T0m7eiCAETmvvMZBM7T1+4UzEtdSBJqJX4UR3lqy7yzkNHXNx2wccSK3dCso9
         rXNn0Er160wpIeLTpp8tARYtysWCgbKemvuTZHrOe80GAfBrQ+aWujevSb/gvF4Mcc
         h4iFUfT/z0fng==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id BB5BE403C8; Sat,  5 Mar 2022 16:04:02 -0300 (-03)
Date:   Sat, 5 Mar 2022 16:04:02 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf: Add irq and exception return branch types
Message-ID: <YiO0IhoAYmdGNWqd@kernel.org>
References: <1645681014-3346-1-git-send-email-anshuman.khandual@arm.com>
 <10aac3a9-6912-6e47-400e-5c7d8ca9dbcd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10aac3a9-6912-6e47-400e-5c7d8ca9dbcd@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 28, 2022 at 03:45:25PM +0000, James Clark escreveu:
> 
> 
> On 24/02/2022 05:36, Anshuman Khandual wrote:
> > This expands generic branch type classification by adding two more entries
> > there in i.e irq and exception return. Also updates the x86 implementation
> > to process X86_BR_IRET and X86_BR_IRQ records as appropriate. This changes
> > branch types reported to user space on x86 platform but it should not be a
> > problem. The possible scenarios and impacts are enumerated here.
> > 
> > --------------------------------------------------------------------------
> > | kernel | perf tool |                     Impact                        |
> > --------------------------------------------------------------------------
> > |   old  |    old    |  Works as before                                  |
> > --------------------------------------------------------------------------
> > |   old  |    new    |  PERF_BR_UNKNOWN is processed                     |
> > --------------------------------------------------------------------------
> > |   new  |    old    |  PERF_BR_ERET/IRQ are blocked via old PERF_BR_MAX |
> > --------------------------------------------------------------------------
> > |   new  |    new    |  PERF_BR_ERET/IRQ are recognized                  |
> > --------------------------------------------------------------------------
> > 
> > When PERF_BR_ERET/IRQ are blocked via old PERF_BR_MAX (new kernel with old
> > perf tool) the user space might throw up an warning complaining about some
> > unrecognized branch types being reported, but it is expected. PERF_BR_ERET
> > and PERF_BR_IRQ branch types will be used for BRBE implementation on arm64
> > platform.
> > 
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Cc: Namhyung Kim <namhyung@kernel.org>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Will Deacon <will@kernel.org>
> > Cc: linux-arm-kernel@lists.infradead.org
> > Cc: linux-perf-users@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> > ---
> > This applies on v5.17-rc5
> > 
> > These two new branch types expands generic branch type classification but
> > still leaves another three entries in 'type' field for later. Please refer
> > a previous discussion [1] for some further context.
> > 
> > [1] https://lore.kernel.org/all/1643348653-24367-1-git-send-email-anshuman.khandual@arm.com/
> > 
> >  arch/x86/events/intel/lbr.c           | 4 ++--
> >  include/uapi/linux/perf_event.h       | 2 ++

Please try to avoid lockstep development of kernel and tools/, submit
patches to the kernel maintainers for the kernel parts, and to the perf
tools maintainer in separate patches.

It is important that changes to the API are flagged, for instance via
tools/perf/check-headers.sh so that opportunity is given for the various
people involved in perf (u/k) development to see what is going on.

Thanks,

- Arnaldo

> >  tools/include/uapi/linux/perf_event.h | 2 ++
> >  tools/perf/util/branch.c              | 4 +++-
> >  4 files changed, 9 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
> > index 669c2be14784..fe1742c4ca49 100644
> > --- a/arch/x86/events/intel/lbr.c
> > +++ b/arch/x86/events/intel/lbr.c
> > @@ -1329,10 +1329,10 @@ static int branch_map[X86_BR_TYPE_MAP_MAX] = {
> >  	PERF_BR_SYSCALL,	/* X86_BR_SYSCALL */
> >  	PERF_BR_SYSRET,		/* X86_BR_SYSRET */
> >  	PERF_BR_UNKNOWN,	/* X86_BR_INT */
> > -	PERF_BR_UNKNOWN,	/* X86_BR_IRET */
> > +	PERF_BR_ERET,		/* X86_BR_IRET */
> >  	PERF_BR_COND,		/* X86_BR_JCC */
> >  	PERF_BR_UNCOND,		/* X86_BR_JMP */
> > -	PERF_BR_UNKNOWN,	/* X86_BR_IRQ */
> > +	PERF_BR_IRQ,		/* X86_BR_IRQ */
> Hi Anshuman,
> 
> I couldn't verify if these changes to the lbr map matched up to the spec because
> I couldn't find the right section. I suppose there might need to be a comment
> about why BR_ERET == BR_IRET or what those abbreviations are.
> 
> I think it could also be possible to leave these entries as unknowns if we don't know
> if they're even being used. It will always be possible to go back and update these
> lbr mappings after you've added the new types.
> 
> 
> >  	PERF_BR_IND_CALL,	/* X86_BR_IND_CALL */
> >  	PERF_BR_UNKNOWN,	/* X86_BR_ABORT */
> >  	PERF_BR_UNKNOWN,	/* X86_BR_IN_TX */
> > diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
> > index 82858b697c05..d37629dbad72 100644
> > --- a/include/uapi/linux/perf_event.h
> > +++ b/include/uapi/linux/perf_event.h
> > @@ -251,6 +251,8 @@ enum {
> >  	PERF_BR_SYSRET		= 8,	/* syscall return */
> >  	PERF_BR_COND_CALL	= 9,	/* conditional function call */
> >  	PERF_BR_COND_RET	= 10,	/* conditional function return */
> > +	PERF_BR_ERET		= 11,	/* exception return */
> > +	PERF_BR_IRQ		= 12,	/* irq */
> >  	PERF_BR_MAX,>  };
> >  
> > diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
> > index 82858b697c05..d37629dbad72 100644
> > --- a/tools/include/uapi/linux/perf_event.h
> > +++ b/tools/include/uapi/linux/perf_event.h
> > @@ -251,6 +251,8 @@ enum {
> >  	PERF_BR_SYSRET		= 8,	/* syscall return */
> >  	PERF_BR_COND_CALL	= 9,	/* conditional function call */
> >  	PERF_BR_COND_RET	= 10,	/* conditional function return */
> > +	PERF_BR_ERET		= 11,	/* exception return */
> > +	PERF_BR_IRQ		= 12,	/* irq */
> >  	PERF_BR_MAX,
> >  };
> >  
> > diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
> > index 2285b1eb3128..a9a909db8cc7 100644
> > --- a/tools/perf/util/branch.c
> > +++ b/tools/perf/util/branch.c
> > @@ -49,7 +49,9 @@ const char *branch_type_name(int type)
> >  		"SYSCALL",
> >  		"SYSRET",
> >  		"COND_CALL",
> > -		"COND_RET"
> > +		"COND_RET",
> > +		"ERET",
> > +		"IRQ"
> >  	};
> >
> Otherwise the new entries look good to me, so without the lbr changes:
> 
> Reviewed-by: James Clark <james.clark@arm.com>
> 
> If we're keeping the lbr mapping changes, then I will defer to someone else
> to review.
> 
> Thanks
> James
> 
> >  	if (type >= 0 && type < PERF_BR_MAX)

-- 

- Arnaldo
