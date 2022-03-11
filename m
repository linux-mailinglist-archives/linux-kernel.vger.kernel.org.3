Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975DC4D6B24
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbiCKX3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 18:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiCKX3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 18:29:18 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC4053BA6A;
        Fri, 11 Mar 2022 15:28:14 -0800 (PST)
Received: from kbox (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 58C4320B7178;
        Fri, 11 Mar 2022 15:28:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 58C4320B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1647041294;
        bh=WfV97jFHnXJqj+8W72uvh/s0Oir5+4FauwMiti7lDyo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WklNVZ8VgCMbt6CBIj/Ou2yFgYoFSQ9clwj6uTd8IsNJq1rp+1zuix4huK4EAN6gf
         CwX0BEhHri8MluGwQOum1Z19FFOE7SgBGcoFgvju54mv6jaYtU9y+yf1kWXdkUoraJ
         7/Y0+4a+Ud/qau4VOrlqnWjLJgzRovBd2Uw17XS0=
Date:   Fri, 11 Mar 2022 15:28:09 -0800
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org
Subject: Re: [next] arm64: allmodconfig: kernel BUG at
 include/linux/page-flags.h:509
Message-ID: <20220311232809.GA2044@kbox>
References: <CADYN=9+xY5Vku3Ws5E9S60SM5dCFfeGeRBkmDFbcxX0ZMoFing@mail.gmail.com>
 <20220311112426.7e3cf434@gandalf.local.home>
 <20220311171123.GA1675@kbox>
 <20220311130453.54a4e0b2@gandalf.local.home>
 <20220311181328.GA1904@kbox>
 <20220311181500.0be31225@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311181500.0be31225@gandalf.local.home>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 06:15:00PM -0500, Steven Rostedt wrote:
> On Fri, 11 Mar 2022 10:13:28 -0800
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > Is that true as well for the user process that has this mapped? Will the
> > user process virtual memory that maps to this ever page it out? I
> > believe that was the concern. My understanding is by reserving in
> > kernel, even though it won't page out on that side, marks the user side
> > entry to not let it page out.
> 
> My memory of the purpose of SetPageReserve() is a bit fuzzy, and there's
> not much use of it in the kernel. Just a hand full. I'll try to investigate
> it some more.
> 

OK, you know more than I, so hopefully we can land on if we really need
it or not. For now I've left it in.

> > 
> > The other thing is that this patch applied to 5.10.X on ARM64 does not
> > appear to hit this. Is it some weird interaction with something else or
> > was 5.10.X just getting lucky?
> 
> Perhaps it's because you allocated the page with kzalloc and not just
> getting a page directly?
> 

Yeah, I think so too. I was able to repro locally and validate that using
alloc_pages directly fixes this by setting DEBUG_VM_PGFLAGS=y.

I've posted a patch for this:
https://lore.kernel.org/linux-trace-devel/20220311223028.1865-1-beaub@linux.microsoft.com/

> Again, my knowledge in this area is lacking. I'm looking more into it.
> 
> -- Steve

Thanks,
-Beau
