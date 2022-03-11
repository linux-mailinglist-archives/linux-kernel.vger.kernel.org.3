Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E259B4D6B25
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbiCKXs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 18:48:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiCKXsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 18:48:25 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CF8C4CC6;
        Fri, 11 Mar 2022 15:47:20 -0800 (PST)
Received: from kbox (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 54A3320B7178;
        Fri, 11 Mar 2022 15:47:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 54A3320B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1647042440;
        bh=r4wRkjLHtlp0+RbqSNUqU2qLOHaEhv3lI/uj32aZtbM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D6j0h2rchbKT16Dhy3eQQgPgzKUpYoTz6rqnhjaKjoZLYuV4ufT9Vr8yL5FIJuKNH
         OHUyRGVzEdK1upzoy/teVpZWkjy+73pKAeus3oaHbBqNDySvrW1foD7L08FpVuThmO
         EdLYEPANATpsZuPPm8Q1sl1mlT5JSLk3EftmBQOA=
Date:   Fri, 11 Mar 2022 15:47:15 -0800
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org
Subject: Re: [next] arm64: allmodconfig: kernel BUG at
 include/linux/page-flags.h:509
Message-ID: <20220311234715.GA2101@kbox>
References: <CADYN=9+xY5Vku3Ws5E9S60SM5dCFfeGeRBkmDFbcxX0ZMoFing@mail.gmail.com>
 <20220311112426.7e3cf434@gandalf.local.home>
 <20220311171123.GA1675@kbox>
 <20220311130453.54a4e0b2@gandalf.local.home>
 <20220311181328.GA1904@kbox>
 <20220311181500.0be31225@gandalf.local.home>
 <20220311232809.GA2044@kbox>
 <20220311183607.291dc950@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311183607.291dc950@gandalf.local.home>
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

On Fri, Mar 11, 2022 at 06:36:07PM -0500, Steven Rostedt wrote:
> On Fri, 11 Mar 2022 15:28:09 -0800
> Beau Belgrave <beaub@linux.microsoft.com> wrote:
> 
> > OK, you know more than I, so hopefully we can land on if we really need
> > it or not. For now I've left it in.
> > 
> > > > 
> > > > The other thing is that this patch applied to 5.10.X on ARM64 does not
> > > > appear to hit this. Is it some weird interaction with something else or
> > > > was 5.10.X just getting lucky?  
> > > 
> > > Perhaps it's because you allocated the page with kzalloc and not just
> > > getting a page directly?
> 
> I sent a version that removes it, but I think we can add it back.
> 
> > >   
> > 
> > Yeah, I think so too. I was able to repro locally and validate that using
> > alloc_pages directly fixes this by setting DEBUG_VM_PGFLAGS=y.
> > 
> > I've posted a patch for this:
> > https://lore.kernel.org/linux-trace-devel/20220311223028.1865-1-beaub@linux.microsoft.com/
> 
> Just saw it (I screwed up my procmail settings getting rid of some more
> spam, and ended up sending all my email to a ":" folder :-p)
> 
> If you want, I can send another version of my patch that doesn't remove the
> reserve. But I like my patch as it sets the MAX_EVENTS based on a order and
> not the other way around.

I never pass up free work (or drinks), I would prefer to keep the reserve
in there. Worst case it's redundant, best case it protects us from a
crash in a user process down the road.

Thanks,
-Beau
