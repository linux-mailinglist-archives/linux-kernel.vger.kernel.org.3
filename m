Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93C5E4F83C4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344977AbiDGPpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242094AbiDGPpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:45:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75675B6E5A;
        Thu,  7 Apr 2022 08:43:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A701961E86;
        Thu,  7 Apr 2022 15:42:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75291C385A4;
        Thu,  7 Apr 2022 15:42:43 +0000 (UTC)
Date:   Thu, 7 Apr 2022 11:42:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: runtime warning after merge of the cel-fixes tree
Message-ID: <20220407114241.0c52b8f0@gandalf.local.home>
In-Reply-To: <F1B98786-A0C4-4907-9B44-7D13050237F2@oracle.com>
References: <20220407144524.2a592ed6@canb.auug.org.au>
        <F83867B8-2737-4850-83A6-13B95973A0BB@oracle.com>
        <20220407105446.186114c3@gandalf.local.home>
        <20220407111318.649f908d@gandalf.local.home>
        <F1B98786-A0C4-4907-9B44-7D13050237F2@oracle.com>
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

On Thu, 7 Apr 2022 15:35:24 +0000
Chuck Lever III <chuck.lever@oracle.com> wrote:

> > --- a/kernel/trace/trace_events.c
> > +++ b/kernel/trace/trace_events.c
> > @@ -392,8 +392,9 @@ static void test_event_printk(struct trace_event_call *call)
> > 			if (!(dereference_flags & (1ULL << arg)))
> > 				goto next_arg;
> > 
> > -			/* Check for __get_sockaddr */;
> > -			if (str_has_prefix(fmt + i, "__get_sockaddr(")) {
> > +			/* Check for __get_sockaddr or __get_dynamic_array */;
> > +			if (str_has_prefix(fmt + i, "__get_sockaddr(") ||
> > +			    str_has_prefix(fmt + i, "__get_dynamic_array(")) {
> > 				dereference_flags &= ~(1ULL << arg);
> > 				goto next_arg;
> > 			}  
> 
> That looks reasonable for present and future kernels.

Actually, I found an issue with the above that will not fix it, but the fix
to that is not that difficult (currently testing it this time).

> 
> We're looking for a solution that can be back-ported to stable,
> however, because the patch Mr. Rothwell had to revert is meant
> to address a NULL pointer deref that was introduced several years
> ago. (Otherwise I would have just used __get_sockaddr() and put
> my pencil down).

I can make a stable version of this patch, as __get_dynamic_array() has
been around for a long time. We could even keep the check for
"__get_sock_addr()" even though it does not exist in older kernels, but
this is just a string check, so that doesn't matter.

> 
> The simplest option is to take a brute-force approach and
> convert the sockaddr to a presentation address with an snprintf()
> call in the TP_fast_assign() arm of the tracepoints. Allow that
> to be carried into -stable as needed; then in v5.19 apply a
> clean-up that converts that mess into a proper __get_sockaddr().
> 
> That way, it stays my issue to address without needing to
> co-ordinate with fixes in other areas.

This change makes the tracing system more robust, which means it's not just
changing to solve an issue with your code. I'm happy to get this working
and backported.

-- Steve
