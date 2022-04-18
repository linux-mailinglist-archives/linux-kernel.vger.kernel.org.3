Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB554505C81
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242498AbiDRQkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233687AbiDRQkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:40:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BB4E3205E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:37:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650299858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=P83Gcc/3BQO5mHOZosACnJZhAbZi4cw5wYAFllafdDo=;
        b=TO3BY23wVm1n4acxDyMoAIXERgPmmQIuaLd4kEAtHY3Z6z3GJNp0akWxW1JxbSEtTLruLs
        G3jHLWvwDUQgPslxRVWRBNEHkJ8eJj+Dh/vv2yyhhY3C9N0M/lvzvMCwqakT+PHQ2+1azY
        UurLnaXsMGZxOBAY97t0cCsTfjhkF6g=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-173-JveT40VwOjG3WxXuJkgMkA-1; Mon, 18 Apr 2022 12:37:37 -0400
X-MC-Unique: JveT40VwOjG3WxXuJkgMkA-1
Received: by mail-qt1-f199.google.com with SMTP id ay26-20020a05622a229a00b002f20573a0faso972690qtb.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:37:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P83Gcc/3BQO5mHOZosACnJZhAbZi4cw5wYAFllafdDo=;
        b=u/+iiiO903OtAf7DyJ6ZmVdoPGBerwHM8Mh/aQESd8NclZ2awpALT3IclZoUMqFJ1n
         tpyHyHaARdmRCq2Cz8ha0ZnMcurYjwqZvVp83P4qFyGEHuD3NzVepxT5b9zS8e2E+WWQ
         NlIhzM6CGjacnQg/svQCXHUirk5AC3ZMeLSqaWREGIBUgP1+3oM8pX4NkOB7Yb7puYJP
         SBWt1+PLyDFsQcHddpUmWn2KlTvGeDbgsAuwSIwzNidLdOnvHSzaZfrQRd5G1ubx9qjg
         DRp+cbFzpbEO1zTFy+d5ZeqYKyrXIdw16CpuY90/9xfpojaBHocV7AddEilTNysXeU1g
         3EJg==
X-Gm-Message-State: AOAM5326+CTQSUhFNSAT2W6ZDx683kqVMjEPQ9hCDpZR9x9e2arkFK7M
        k9uAFmyfdpu38FMqYYAMn+6bvh0NzfUYoaMoPzPYSJ2AcYTm3KwYX3wu95LVsBE6SL9DuqjeBpf
        8ekUJ6HK928gendN19rX1UU+S
X-Received: by 2002:a05:620a:e18:b0:67d:7fcb:6244 with SMTP id y24-20020a05620a0e1800b0067d7fcb6244mr7206021qkm.42.1650299856939;
        Mon, 18 Apr 2022 09:37:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxfliqvroOUhQG6t+QeU8s6qOb24qvY/YiWMXibo68LqBHGRGzVSX1d8jahV3fbkN61zUH2AQ==
X-Received: by 2002:a05:620a:e18:b0:67d:7fcb:6244 with SMTP id y24-20020a05620a0e1800b0067d7fcb6244mr7206007qkm.42.1650299856599;
        Mon, 18 Apr 2022 09:37:36 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id p3-20020a05620a15e300b0069e5b556f75sm4822095qkm.5.2022.04.18.09.37.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:37:36 -0700 (PDT)
Date:   Mon, 18 Apr 2022 09:37:33 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Dmitry Monakhov <dmtrmonakhov@yandex-team.ru>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, mingo@redhat.com,
        Kim Phillips <kim.phillips@amd.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] x86/unwind/orc: recheck address range after stack info
 was updated V2
Message-ID: <20220418163733.hmee24hzlt4zyixm@treble>
References: <1650201791-356270-1-git-send-email-dmtrmonakhov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1650201791-356270-1-git-send-email-dmtrmonakhov@yandex-team.ru>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the subject, the patch version should be in the [PATCH] field which
gets discarded by git.  Also "recheck" should be capitalized:

  [PATCH v2] x86/unwind/orc: Recheck address range after stack info was updated

> get_stack_info() detects stack type only by begin address, so we must
> check that address range in question is fully covered by detected stack

Try to use good grammar/punctuation.  This sentence doesn't even have a
period.

And, it should mention the fact that the root cause actually seems to be
a bug in the IBS handling code which is passing invalid regs to the
unwinder.

> 
> Otherwise following crash is possible:
> -> unwind_next_frame
>    case ORC_TYPE_REGS:
>      if (!deref_stack_regs(state, sp, &state->ip, &state->sp))
>      -> deref_stack_regs
>        -> stack_access_ok  <- addr is ok, but addr+len-1 is not, exit with success
>      *ip = READ_ONCE_NOCHECK(regs->ip); <- Here we hit stack guard fault
> 
> Original OOPS log:
> BUG: stack guard page was hit at 000000000dd984a2 (stack is 00000000d1caafca..00000000613712f0)
> kernel stack overflow (page fault): 0000 [#1] SMP NOPTI
> CPU: 93 PID: 23787 Comm: context_switch1 Not tainted 5.4.145 #1
> RIP: 0010:unwind_next_frame
> Call Trace:
>  <NMI>
>  perf_callchain_kernel
>  ..
>  get_perf_callchain
>  perf_callchain
>  perf_prepare_sample
>  perf_event_output_forward
>  ...
>  __perf_event_overflow
>  perf_ibs_handle_irq
>  ....
>  perf_ibs_nmi_handler

This is definitely more readable than before, though I think all the
'...' can be removed, since you only trimmed the '?' entries which are
just bread crumbs on the stack and not actually part of the call path.

>  nmi_handle
>  default_do_nmi
>  do_nmi
>  end_repeat_nmi
> 
> Changes since v1:
>  - Do not call on_stack() twice for valid range.

This changelog shouldn't be a part of the patch description itself.
Instead it should be below the "---" line.

Also, a diffstat would be helpful.

See "The canonical patch format" in
Documentation/process/submitting-patches.rst.

> diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
> index 794fdef2501a..38185aedf7d1 100644
> --- a/arch/x86/kernel/unwind_orc.c
> +++ b/arch/x86/kernel/unwind_orc.c
> @@ -339,11 +339,11 @@ static bool stack_access_ok(struct unwind_state *state, unsigned long _addr,
>  	struct stack_info *info = &state->stack_info;
>  	void *addr = (void *)_addr;
>  
> -	if (!on_stack(info, addr, len) &&
> -	    (get_stack_info(addr, state->task, info, &state->stack_mask)))
> -		return false;
> +	if (on_stack(info, addr, len))
> +		return true;
>  
> -	return true;
> +	return !get_stack_info(addr, state->task, info, &state->stack_mask) &&
> +		on_stack(info, addr, len);

The change itself looks ok.

-- 
Josh

