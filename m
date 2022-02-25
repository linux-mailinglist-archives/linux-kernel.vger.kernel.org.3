Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5CE4C422C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 11:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239450AbiBYKUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 05:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238179AbiBYKUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 05:20:50 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D1A1C233E
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 02:20:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 77BC8CE2429
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 10:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7C55C340E7;
        Fri, 25 Feb 2022 10:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645784413;
        bh=jTN6lFqaS32dJ2UbgZGYAvzDkSeCb/06dnDC06bxVD8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qht9oQi/uwHy7zPXb1T63ftiT8u3kdL+ml2WdA6QCIN2LCEdqMWQBz+K17pIwhOka
         Zpk5SCUwFxIkzkGhkM8LUZ/3Ot7BB+0CemetqOxR7+7ma7CuMkEhSzizYBdg5RZ5mJ
         a7r6fbeHinrLavoEc5YGchz7ww9VK0nzCjrHFdey6SVT04DBr8vnPBOTpIecs5fDLu
         f3EWyNx1Z1xLXQRT/wrF4pl4PX9DHM+sqrcMEc/BwD0iyhYR5MAhoUZ8yqZAiuuv/x
         W2yZL//0n8HHs1Ubvb3bBf6CvzWVg7uB/b3m5Lvw1UctgX9+ky7Z3dSRbYitxEmlzd
         4GBGEyr+AIS/Q==
Date:   Fri, 25 Feb 2022 19:20:08 +0900
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
Message-Id: <20220225192008.d7a4f2b5558fe43c95909777@kernel.org>
In-Reply-To: <20220224211919.0612a3f6@rorschach.local.home>
References: <20220224145138.952963315@infradead.org>
        <20220224151322.714815604@infradead.org>
        <20220225005520.c69be2fbdbd28028361792d9@kernel.org>
        <20220224105847.5c899324@gandalf.local.home>
        <20220225103449.6084e5314273556f35107cd9@kernel.org>
        <20220224211919.0612a3f6@rorschach.local.home>
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

On Thu, 24 Feb 2022 21:19:19 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 25 Feb 2022 10:34:49 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > > > > +	if (!rec) {
> > > > > +		if (!kallsyms_lookup_size_offset(ip, &size, &offset))
> > > > > +			goto out;
> > > > > +
> > > > > +		if (!offset)    
> > > > 
> > > > Isn't this 'if (offset)' ?  
> > > 
> > > No, the point to only look for the fentry location if the ip passed in
> > > points to the start of the function. IOW, +0 offset.  
> > 
> > OK, so this means ftrace_location() will be same as
> > ftrace_location_range(sym, sym_end) ?
> 
> No. It only acts like ftrace_location_range(sym, sym_end) if the passed
> in argument is the ip of the function (kallsyms returns offset = 0)

Got it. So now ftrace_location() will return the ftrace address
when the ip == func or ip == mcount-call.

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
