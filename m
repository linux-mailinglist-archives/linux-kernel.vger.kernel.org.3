Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 166864C99BB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 01:12:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238739AbiCBAMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 19:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbiCBAMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 19:12:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE0B5004B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 16:11:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C5F961510
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:11:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5A4C340EE;
        Wed,  2 Mar 2022 00:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646179915;
        bh=I2vZtwuFZPbmioJOa3mkvX78X/wdYqIxDTqM6MMnvi8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=tjW7FbHVKn+IK4cq3vBDTCRzC1B5K+dKjory6f3iLNmAmVFU9wIQYGIJ8yeP4R31/
         TXAiTGcGNee8GBxKVcJMpcv7QE5cORi3Je6A2+NrlDUwXwdo8dg8yzEHeYz6rDciYq
         bWuSfDyDy7kx6gez26Lud1J1utPj0mrvR7oYQdGWWvBEPhZxYH7upsoZk4oilKD4wY
         eQi6srWcwcclj259Hbjfo93dxKXU7k7G18ENlEHNkznQbtCap9VO9nk1cTXC2uMKcF
         1WHDp8xkJH9okbP1arFmZ01BGREwu7WynozTi/4VLFiAF8e4bHrpMCMuas3tyQbExL
         ZHZPl9KnzEiRg==
Date:   Wed, 2 Mar 2022 09:11:50 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com,
        linux-kernel@vger.kernel.org, ndesaulniers@google.com,
        keescook@chromium.org, samitolvanen@google.com,
        mark.rutland@arm.com, alyssa.milburn@intel.com, mbenes@suse.cz,
        rostedt@goodmis.org, alexei.starovoitov@gmail.com,
        naveen.n.rao@linux.vnet.ibm.com
Subject: Re: [PATCH v2 15/39] x86/ibt,kprobes: Fix more +0 assumptions
Message-Id: <20220302091150.21daa1b3f153a98206ee8d9a@kernel.org>
In-Reply-To: <Yh3ZQQv8GjtqgUF4@hirez.programming.kicks-ass.net>
References: <20220224145138.952963315@infradead.org>
        <20220224151322.892372059@infradead.org>
        <20220228150705.aab2d654b973109bab070ffe@kernel.org>
        <20220228232513.GH11184@worktop.programming.kicks-ass.net>
        <20220301114905.e11146ad69d6e01998101c3b@kernel.org>
        <Yh3ZQQv8GjtqgUF4@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Mar 2022 09:28:49 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Mar 01, 2022 at 11:49:05AM +0900, Masami Hiramatsu wrote:
> > > +static kprobe_opcode_t *
> > > +_kprobe_addr(kprobe_opcode_t *addr, const char *symbol_name,
> > > +	     unsigned long offset, bool *on_func_entry)
> > >  {
> > >  	if ((symbol_name && addr) || (!symbol_name && !addr))
> > >  		goto invalid;
> > >  
> > >  	if (symbol_name) {
> > > +		/*
> > > +		 * Input: @sym + @offset
> > > +		 * Output: @addr + @offset
> > > +		 *
> > > +		 * NOTE: kprobe_lookup_name() does *NOT* fold the offset
> > > +		 *       argument into it's output!
> > > +		 */
> > >  		addr = kprobe_lookup_name(symbol_name, offset);
> > 
> > Hmm, there are 2 issues.
> > 
> > - the 'addr' includes the 'offset' here.
> 
> AFAICT it doesn't (I ever wrote that in the comment on top). There's two
> implementations of kprobe_lookup_name(), the weak version doesn't even
> use the offset argument, and the PowerPC implementation only checks for
> !offset and doesn't fold it.

Oops, OK.

> 
> > - the 'offset' is NOT limited under the symbol size.
> >   (e.g. symbol_name = "_text" and @offset points the offset of target symbol from _text)
> > 
> > This means we need to call kallsyms_lookup_size_offset() in this case too.
> 
> I'm feeling we should error out in that case. Using sym+offset beyond
> the limits of sym is just daft.

No, this is required for pointing some local scope functions, which has
same name. (And perf-probe does that)

> 
> But if you really want/need to retain that, then yes, we need that
> else branch unconditionally :/

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
