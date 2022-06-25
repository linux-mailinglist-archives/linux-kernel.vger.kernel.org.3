Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CB0255AB89
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 18:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233313AbiFYQKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 12:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbiFYQKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 12:10:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEB614D2E;
        Sat, 25 Jun 2022 09:10:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0AD2AB80139;
        Sat, 25 Jun 2022 16:10:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD3AC3411C;
        Sat, 25 Jun 2022 16:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656173410;
        bh=QSWAyUdJzasHKF1Z9c5060hPLNcWPmd3x4OaL74W4HY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MPIF5FvG7m9c6/e3wnewrLU1ha4RtardAl1QUwVJUrAGCelDOO2XeOxmdvJKLf9gI
         Q5sflhfn0uXwoIhhaxnoALf7a5Pct27xYqtWxTQT0AJ8TLDfyU7LtWrCVxzjJCTZG3
         xszxQR91hOMUYOmfpfce7rscmQ59SxHI0Vt1rqcQuOcOLvUhai6++e6i4s5wDh+VH5
         H6P5u+uc74ixbvi4ajD9Ywb74N9fcWXh9jStjYFDHxQBT5PMqPhZ3YSrjxB/x932op
         Z5C+Q8ijvad9s2Ou+O8QjkKuiOi/1Je5ujHesnHko5VAHubhWajJft+S/lDV7yFCn2
         1/uh6zFgE4vTQ==
Date:   Sun, 26 Jun 2022 01:10:06 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     rostedt@goodmis.org, mingo@redhat.com, mhiramat@kernel.org,
        zanussi@kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v12 4/4] trace/objtrace: Add documentation for objtrace
Message-Id: <20220626011006.22572fbabcac5c8494e09f13@kernel.org>
In-Reply-To: <20220606160943.663180-5-xiehuan09@gmail.com>
References: <20220606160943.663180-1-xiehuan09@gmail.com>
        <20220606160943.663180-5-xiehuan09@gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff,

OK, this looks good to me.

Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

And just a note that please add 'Documentation:' tag to the title
and Cc to linux-doc@vger.kernel.org and Jonathan Corbet too since
this is a patch for the Documentation/*.

Thank you,

On Tue,  7 Jun 2022 00:09:43 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:

> Added documentation explaining how to use objtrace trigger to get the value
> of the object.
> 
> Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
> ---
>  Documentation/trace/events.rst | 83 ++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
> 
> diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
> index c47f381d0c00..0dc475160133 100644
> --- a/Documentation/trace/events.rst
> +++ b/Documentation/trace/events.rst
> @@ -546,6 +546,89 @@ The following commands are supported:
>  
>    See Documentation/trace/histogram.rst for details and examples.
>  
> +- objtrace
> +
> +  This command provides a way to get the value of any object, The object
> +  can be obtained from the dynamic event(kprobe_event/uprobe_event) or the
> +  static event(tracepoint).
> +
> +  Usage:
> +  When using the kprobe event, only need to set the objtrace(a new trigger),
> +  we can get the value of the object. The object is from the setting of the
> +  kprobe event.
> +
> +  For example:
> +  For the function bio_add_page():
> +
> +  int bio_add_page(struct bio *bio, struct page *page,
> +	unsigned int len, unsigned int offset)
> +
> +  Firstly, we can set the base of the object, thus the first string "arg1"
> +  stands for the value of the first parameter of this function bio_add_gage(),
> +
> +  # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
> +
> +  Secondly, we can get the value dynamically based on above object.
> +
> +  find the offset of the bi_size in struct bio:
> +  $ gdb vmlinux
> +  (gdb) p &(((struct bio *)0)->bi_iter.bi_size)
> +  $1 = (unsigned int *) 0x28
> +
> +  # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/ \
> +	p_bio_add_page_0/trigger
> +
> +  # cd /sys/kernel/debug/tracing/
> +  # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
> +  # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/p_bio_add_page_0/trigger
> +
> +  # du -sh /test.txt
> +  12.0K   /test.txt
> +
> +  # cat  /test.txt > /dev/null
> +  # cat ./trace
> +  # tracer: nop
> +  #
> +  # entries-in-buffer/entries-written: 128/128   #P:4
> +  #
> +  #                                _-----=> irqs-off/BH-disabled
> +  #                               / _----=> need-resched
> +  #                              | / _---=> hardirq/softirq
> +  #                              || / _--=> preempt-depth
> +  #                              ||| / _-=> migrate-disable
> +  #                              |||| /     delay
> +  #           TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
> +  #              | |         |   |||||     |         |
> +               cat-117     [002] ...1.     1.602243: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x0
> +               cat-117     [002] ...1.     1.602244: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x0
> +               cat-117     [002] ...2.     1.602244: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x1000
> +               cat-117     [002] ...1.     1.602245: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x1000
> +               cat-117     [002] ...1.     1.602245: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x1000
> +               cat-117     [002] ...2.     1.602245: bio_add_page <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x2000
> +               cat-117     [002] ...1.     1.602245: __bio_try_merge_page <-bio_add_page object:0xffff88811bee4000 value:0x2000
> +               cat-117     [002] ...1.     1.602245: __bio_add_page <-bio_add_page object:0xffff88811bee4000 value:0x2000
> +               cat-117     [002] ...1.     1.602245: submit_bio <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x3000
> +               cat-117     [002] ...1.     1.602245: submit_bio_noacct <-ext4_mpage_readpages object:0xffff88811bee4000 value:0x3000
> +               cat-117     [002] ...1.     1.602246: __submit_bio <-submit_bio_noacct object:0xffff88811bee4000 value:0x3000
> +               cat-117     [002] ...1.     1.602246: submit_bio_checks <-__submit_bio object:0xffff88811bee4000 value:0x3000
> +               cat-117     [002] ...1.     1.602246: __cond_resched <-submit_bio_checks object:0xffff88811bee4000 value:0x3000
> +               cat-117     [002] ...1.     1.602246: should_fail_bio <-submit_bio_checks object:0xffff88811bee4000 value:0x3000
> +               cat-117     [002] ...1.     1.602246: blk_mq_submit_bio <-submit_bio_noacct object:0xffff88811bee4000 value:0x3000
> +               cat-117     [002] ...1.     1.602246: blk_attempt_plug_merge <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> +               cat-117     [002] ...1.     1.602246: blk_mq_sched_bio_merge <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> +               cat-117     [002] ...1.     1.602247: __rcu_read_lock <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> +               cat-117     [002] ...1.     1.602247: __rcu_read_unlock <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> +               cat-117     [002] ...1.     1.602247: __blk_mq_alloc_requests <-blk_mq_submit_bio object:0xffff88811bee4000 value:0x3000
> +            <idle>-0       [002] d..3.     1.602298: bio_endio <-blk_update_request object:0xffff88811bee4000 value:0x0
> +            <idle>-0       [002] d..3.     1.602298: mpage_end_io <-blk_update_request object:0xffff88811bee4000 value:0x0
> +            <idle>-0       [002] d..3.     1.602298: __read_end_io <-blk_update_request object:0xffff88811bee4000 value:0x0
> +            <idle>-0       [002] d..3.     1.602300: bio_put <-blk_update_request object:0xffff88811bee4000 value:0x0
> +            <idle>-0       [002] d..3.     1.602300: bio_free <-blk_update_request object:0xffff88811bee4000 value:0x0
> +            <idle>-0       [002] d..3.     1.602300: mempool_free <-blk_update_request object:0xffff88811bee4000 value:0x0
> +            <idle>-0       [002] d..3.     1.602300: mempool_free_slab <-blk_update_request object:0xffff88811bee4000 value:0x0
> +            <idle>-0       [002] d..3.     1.602300: kmem_cache_free <-blk_update_request object:0xffff88811bee4000 value:0x0
> +             ...
> +
>  7. In-kernel trace event API
>  ============================
>  
> -- 
> 2.25.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
