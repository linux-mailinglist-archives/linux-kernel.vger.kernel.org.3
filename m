Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5230C4C30B7
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 17:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbiBXQAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 11:00:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiBXQAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 11:00:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E26AE17EDB9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:59:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DEA9CB826B1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 15:58:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05C9CC340E9;
        Thu, 24 Feb 2022 15:58:48 +0000 (UTC)
Date:   Thu, 24 Feb 2022 10:58:47 -0500
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
Message-ID: <20220224105847.5c899324@gandalf.local.home>
In-Reply-To: <20220225005520.c69be2fbdbd28028361792d9@kernel.org>
References: <20220224145138.952963315@infradead.org>
        <20220224151322.714815604@infradead.org>
        <20220225005520.c69be2fbdbd28028361792d9@kernel.org>
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

On Fri, 25 Feb 2022 00:55:20 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> >  unsigned long ftrace_location(unsigned long ip)
> >  {
> > -	return ftrace_location_range(ip, ip);
> > +	struct dyn_ftrace *rec;
> > +	unsigned long offset;
> > +	unsigned long size;
> > +
> > +	rec = lookup_rec(ip, ip);
> > +	if (!rec) {
> > +		if (!kallsyms_lookup_size_offset(ip, &size, &offset))
> > +			goto out;
> > +
> > +		if (!offset)  
> 
> Isn't this 'if (offset)' ?

No, the point to only look for the fentry location if the ip passed in
points to the start of the function. IOW, +0 offset.

-- Steve


> 
> > +			rec = lookup_rec(ip - offset, (ip - offset) + size);
> > +	}
> > +
> > +	if (rec)
> > +		return rec->ip;
> > +
> > +out:
> > +	return 0;
