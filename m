Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B08A4C3B0B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 02:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236424AbiBYBfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 20:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234818AbiBYBf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:35:28 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B606269ABB
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 17:34:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8FAD6CE1FBF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 01:34:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3763C340E9;
        Fri, 25 Feb 2022 01:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645752895;
        bh=wNUCXuIaSBVD0lkhDYcB4fH3smbby6B3WwxA1B90+RQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vNQcaL5rjk/hvJytGi7kNKB1OJahVApVcayZ68FyZ4XMEJh8rwRyUnILohM8W1GWQ
         Vt0N0Vuz++IEU6WVbQ5LPp8tgiOMleG+PXFDr4FKNNRls5PHqEzOE4tO61jp+Fyw+/
         Uoy3SqV+CFfEdctQZjigUZi9IY46GpBJJEAIdgboTmbMNUYIQrSCwTii6bNNlggjat
         Q/x/v3XvsKyFtJeRgEppAd+vN9ZVgMKhV1Bh013vWHcJoRGvHA9WZfjX8b6YshM0mQ
         iKRrPwtaWaJOm/T7csjNwWtmIeKGw/cnr7a3cwfxbdZfFZiXzMhch7rRD56S5NMxJa
         oeb8iKYlv8C9Q==
Date:   Fri, 25 Feb 2022 10:34:49 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        joao@overdrivepizza.com, hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 12/39] x86/ibt,ftrace: Search for __fentry__ location
Message-Id: <20220225103449.6084e5314273556f35107cd9@kernel.org>
In-Reply-To: <20220224105847.5c899324@gandalf.local.home>
References: <20220224145138.952963315@infradead.org>
        <20220224151322.714815604@infradead.org>
        <20220225005520.c69be2fbdbd28028361792d9@kernel.org>
        <20220224105847.5c899324@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

OK, so this means ftrace_location() will be same as
ftrace_location_range(sym, sym_end) ?

Thank you,

> 
> -- Steve
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


-- 
Masami Hiramatsu <mhiramat@kernel.org>
