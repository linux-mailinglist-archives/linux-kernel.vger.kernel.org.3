Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E458D4C5453
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 08:20:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiBZHKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 02:10:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiBZHK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 02:10:29 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8825E2AB0ED
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 23:09:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D8A56B80E8F
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 07:09:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C103BC340E9;
        Sat, 26 Feb 2022 07:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645859392;
        bh=4eazNUJ7+ReHoE0uXxik+R6XLoJmoiIZfWOFK6prnIY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kCC67E0arPZ4ZA4E+JastLLv325huiyaKcRztD3FxEdy3twUXND1kqbmNTmk0LAnl
         92kAjYKC2Kz3FQA2mGpm812EeVYbQtxxxiSu2jPsakj9JPbBT/H0kkZytyTU0KBBqj
         FXUN3IAZjv4e6IMgaZbw0X5oF/t1CRmpJQveu+wUxfyWoZUi3RZ74w8Vk8ILCrtJkO
         5qJPemZSZZC5jiyilZJzSaKHAW34o2RIVgzvAYfSpRD/dqqcgIQ9VM1IQeGLbuSFyH
         QvdRFB6Pi3M2qcS5SC7mqX/gpOAzCSZ1FMYCGQc753wEuepLKLPzR8HOSHHgjpytkQ
         3Nt1tlDNZgS3Q==
Date:   Sat, 26 Feb 2022 16:09:46 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        joao@overdrivepizza.com, hjl.tools@gmail.com, jpoimboe@redhat.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz,
        alexei.starovoitov@gmail.com
Subject: Re: [PATCH v2 15/39] x86/ibt,kprobes: Fix more +0 assumptions
Message-Id: <20220226160946.cd0d45b859449ea4a2c40b75@kernel.org>
In-Reply-To: <20220225091409.0963e7d2@gandalf.local.home>
References: <20220224145138.952963315@infradead.org>
        <20220224151322.892372059@infradead.org>
        <20220225103215.77080de0b3edd0fa2839b8fa@kernel.org>
        <YhizfwoddLwWWl2J@hirez.programming.kicks-ass.net>
        <20220225091409.0963e7d2@gandalf.local.home>
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

On Fri, 25 Feb 2022 09:14:09 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 25 Feb 2022 11:46:23 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Given all that, kprobe users are in a bit of a bind. Determining the
> > __fentry__ point basically means they *have* to first read the function
> > assembly to figure out where it is.
> 
> Technically I think that's what kprobes has been designed for. But
> realistically, I do not think anyone actually does that (outside of
> academic and niche uses).

Yeah, raw kprobe user must check the instruction boundary anyway.
And if possible, I would like to keep the kprobe (in kprobe level) as it is.

> Really, when people use func+0 they just want to trace the function, and
> ftrace is the fastest way to do so, and if it's not *exactly* at function
> entry, but includes the arguments, then it should be fine.

Yes, that is another (sub) reason why I introduced fprobe. ;-)

OK, I understand that we should not allow to probe on endbr unless
user really wants it. Let me add a KPROBE_FLAG_RAW_ENTRY for that special
purpose. If the flag is not set (by default), the kprobe::addr will be
shifted automatically.
ANyway, this address translation must be done in check_ftrace_location
instead of kprobe_lookup_name(). Let me make another patch.
Also, selftest and document must be updated with that.

> That said, perhaps we should add a config to know if the architecture
> uses function entry or the old mcount that is after the frame set up (that
> is, you can not get to the arguments).
> 
> CONFIG_HAVE_FTRACE_FUNCTION_START ?

Hmm, ENDBR is not always there, and except x86, most of the arch will
make it 'n'. (x86 is a special case.)

> 
> Because, if the arch still uses the old mcount method (where it's after the
> frame set up), then a kprobe at func+0 really wants the breakpoint.
> 
> -- Steve
> 

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
