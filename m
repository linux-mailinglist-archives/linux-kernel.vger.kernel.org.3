Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B7E529256
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 23:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237004AbiEPVHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 17:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348072AbiEPVGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 17:06:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27411BE82;
        Mon, 16 May 2022 13:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=oBgHeRTw46lB8VbDalNtQkk1rHR6/RluKxpwDwMO2Lo=; b=IHU66snTQUwaaTUEIkvgO8EA4O
        QZS20N82CJaeH3XrvC4ENfRC2zSPOoKstH0rOoAuZMpRld56cAaZvNkXqbBqISEc0F/snhp1h7Gd9
        XAaN7agEaYztFPIOQP7Mp984HJgoo9UqCYyVseM4CKdYI6+H4EkdcFfviA26Xo2sD8NTX0qv1TwzG
        FyktxL3HS9dJplyg15aahnIv5q4+ETnrMu8Z590oQr+bQoFxYwnrJiXwVGiEt6LzaKWvScY7a2RUq
        E87g+ow6KUD2AB2ctLQgmoFMk+xfmXUKLo9itTgLxv7bt+xLnUnY/XH2z1L1NnejV9T8UCyYtLg4N
        q8QrIZSg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nqhaE-00AEGp-M1; Mon, 16 May 2022 20:44:50 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2B0DA980DCC; Mon, 16 May 2022 22:44:49 +0200 (CEST)
Date:   Mon, 16 May 2022 22:44:49 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] sched/core: Do not treat class list boundary markers as
 arrays
Message-ID: <20220516204449.GO76023@worktop.programming.kicks-ass.net>
References: <20220516194241.3064242-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516194241.3064242-1-keescook@chromium.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 12:42:41PM -0700, Kees Cook wrote:
> GCC 12 is very sensitive about array checking, and views all negative
> array accesses as unsafe (a not unreasonable position). Avoid the
> warnings about __begin_sched_classes being accessed via negative bounds
> by converting them to the pointers they actually are. Silences this
> warning:

Yeah, this patch is *much* saner, thanks!

> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 8dccb34eb190..3d31ed9d33fa 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2190,8 +2190,8 @@ const struct sched_class name##_sched_class \
>  	__section("__" #name "_sched_class")
>  
>  /* Defined in include/asm-generic/vmlinux.lds.h */
> -extern struct sched_class __begin_sched_classes[];
> -extern struct sched_class __end_sched_classes[];
> +extern struct sched_class *__begin_sched_classes;
> +extern struct sched_class *__end_sched_classes;
>  
>  #define sched_class_highest (__end_sched_classes - 1)
>  #define sched_class_lowest  (__begin_sched_classes - 1)
> -- 
> 2.32.0
> 
