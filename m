Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03D674C30D9
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:03:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbiBXQDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233802AbiBXQDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:03:01 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B412539B9D
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 08:02:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 225DF6179C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 16:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C66C340E9;
        Thu, 24 Feb 2022 16:01:31 +0000 (UTC)
Date:   Thu, 24 Feb 2022 11:01:30 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        joao@overdrivepizza.com, hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 12/39] x86/ibt,ftrace: Search for __fentry__ location
Message-ID: <20220224110130.4f4ae4ac@gandalf.local.home>
In-Reply-To: <20220224105847.5c899324@gandalf.local.home>
References: <20220224145138.952963315@infradead.org>
        <20220224151322.714815604@infradead.org>
        <20220225005520.c69be2fbdbd28028361792d9@kernel.org>
        <20220224105847.5c899324@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Feb 2022 10:58:47 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 25 Feb 2022 00:55:20 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > >  unsigned long ftrace_location(unsigned long ip)
> > >  {
> > > -	return ftrace_location_range(ip, ip);
> > > +	struct dyn_ftrace *rec;
> > > +	unsigned long offset;
> > > +	unsigned long size;
> > > +
> > > +	rec = lookup_rec(ip, ip);
> > > +	if (!rec) {
> > > +		if (!kallsyms_lookup_size_offset(ip, &size, &offset))
> > > +			goto out;
> > > +
> > > +		if (!offset)    
> > 
> > Isn't this 'if (offset)' ?  
> 
> No, the point to only look for the fentry location if the ip passed in
> points to the start of the function. IOW, +0 offset.
> 

I do agree with Masami that it is confusing. Please add a comment:

		/* Search the entire function if ip is the start of the function */
		if (!offset)
			[..]

-- Steve

> 
> 
> >   
> > > +			rec = lookup_rec(ip - offset, (ip - offset) + size);
> > > +	}
> > > +
> > > +	if (rec)
> > > +		return rec->ip;
> > > +
> > > +out:
> > > +	return 0;  

