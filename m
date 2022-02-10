Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 634544B139E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:54:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244714AbiBJQy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:54:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236743AbiBJQy1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:54:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A40A0D4
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:54:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 485ABB82664
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 16:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8802AC004E1;
        Thu, 10 Feb 2022 16:54:24 +0000 (UTC)
Date:   Thu, 10 Feb 2022 11:54:22 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH] tracing: uninline trace_trigger_soft_disabled()
Message-ID: <20220210115422.111755e3@gandalf.local.home>
In-Reply-To: <d60a60ff-cc16-75b0-2415-482cb70a2e5e@csgroup.eu>
References: <38191e96ec6d331662ee7278e26edb79cdf95402.1644482771.git.christophe.leroy@csgroup.eu>
        <20220210092617.2bb40912@gandalf.local.home>
        <d60a60ff-cc16-75b0-2415-482cb70a2e5e@csgroup.eu>
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

On Thu, 10 Feb 2022 15:05:51 +0000
Christophe Leroy <christophe.leroy@csgroup.eu> wrote:

> 
> Well, my first issue is that I get it duplicated 50 times because GCC 
> find it too big to get inlined. So it is a function call anyway.
> 
> For instance, when building arch/powerpc/kernel/irq.o which -Winline, I get:
> 
> ./include/linux/perf_event.h:1169:20: error: inlining failed in call to 
> 'perf_fetch_caller_regs': call is unlikely and code size would grow 
> [-Werror=inline]
> ./include/linux/perf_event.h:1169:20: error: inlining failed in call to 
> 'perf_fetch_caller_regs': call is unlikely and code size would grow 
> [-Werror=inline]
> ./include/linux/perf_event.h:1169:20: error: inlining failed in call to 
> 'perf_fetch_caller_regs': call is unlikely and code size would grow 
> [-Werror=inline]
> ./include/linux/perf_event.h:1169:20: error: inlining failed in call to 
> 'perf_fetch_caller_regs': call is unlikely and code size would grow 
> [-Werror=inline]
> ./include/linux/trace_events.h:712:1: error: inlining failed in call to 
> 'trace_trigger_soft_disabled': call is unlikely and code size would grow 
> [-Werror=inline]
> ./include/linux/trace_events.h:712:1: error: inlining failed in call to 
> 'trace_trigger_soft_disabled': call is unlikely and code size would grow 
> [-Werror=inline]
> ./include/linux/trace_events.h:712:1: error: inlining failed in call to 
> 'trace_trigger_soft_disabled': call is unlikely and code size would grow 
> [-Werror=inline]
> ./include/linux/trace_events.h:712:1: error: inlining failed in call to 
> 'trace_trigger_soft_disabled': call is unlikely and code size would grow 
> [-Werror=inline]
> 
> 
> 
> If having it a function call is really an issue, then it should be 
> __always_inline

Yes you are correct.

> 
> I will see the impact on size when we do so.
> 
> 
> What is in the hot path really ? It is the entire function or only the 
> first test ?
> 
> What about:
> 
> static inline bool
> trace_trigger_soft_disabled(struct trace_event_file *file)
> {
> 	unsigned long eflags = file->flags;
> 
> 	if (!(eflags & EVENT_FILE_FL_TRIGGER_COND))
> 		return outlined_trace_trigger_soft_disabled(...);
> 	return false;
> }
> 
> 
> Or is there more in the hot path ?

Actually, the condition should be:

 	if (!(eflags & EVENT_FILE_FL_TRIGGER_COND) &&
	    (eflags & (EVENT_FILE_FL_TRIGGER_MODE |
		       EVENT_FILE_FL_SOFT_DISABLE |
		       EVENT_FILE_FL_PID_FILTER)) {
		return outlined_trace_trigger_soft_disabled(...);
	}

	return false;

As we only want to call the function when TRIGGER_COND is not set and one
of those bits are. Because the most common case is !eflags, which your
version would call the function every time.

Maybe even switch the condition, to the most common case:

 	if ((eflags & (EVENT_FILE_FL_TRIGGER_MODE |
		       EVENT_FILE_FL_SOFT_DISABLE |
		       EVENT_FILE_FL_PID_FILTER) &&
	    !(eflags & EVENT_FILE_FL_TRIGGER_COND)) {

Because if one of those bits are not set, no reason to look further. And
the TRIGGER_COND being set is actually the unlikely case, so it should be
checked last.

Would that work for you?

-- Steve
