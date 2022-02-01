Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447964A5410
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 01:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbiBAAaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 19:30:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:60394 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230387AbiBAAac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 19:30:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643675431;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4ZXnMqMTjhCODrzBX/cYgLVFu6C0QMPhSVx3vFBSQE4=;
        b=JO/HFS7xGMkPssQ3q16o5YDXip7IrDF1DRdEHij6lsjzb5UKMJUsxOat3T+0XQ3GQg4O1+
        e2Alrv4PRMRt1PFcWQT6+X7U+i6sApWWvnaF15Qu8Ig3Ur6LoQGn1J5PRpPXjX8C7m5+b2
        viyd4fZa/kZzqQNuCDho09s616Ic7W0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-437-8ZdFm2WXNSitfosDXjfjKQ-1; Mon, 31 Jan 2022 19:30:30 -0500
X-MC-Unique: 8ZdFm2WXNSitfosDXjfjKQ-1
Received: by mail-qt1-f199.google.com with SMTP id l15-20020ac84ccf000000b002cf9424cfa5so11703306qtv.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 16:30:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4ZXnMqMTjhCODrzBX/cYgLVFu6C0QMPhSVx3vFBSQE4=;
        b=cDziiqt1kbWNGechfYowJrmSzOWUsBh82ykLnhmE7eXHrimbKzFvxXekD545VgE++n
         KHWz57s6vESDKApdvth783cSd3j0ZL7Yf9hG4uRZ6r1wyADjSNM56jNarPZPILQFSdz8
         iNMbgGTzuNkIoYZ5xP8//FolR7pqbgZPEuKI0RQb4dRZ6a4YZbiePegFNVwg40xqSZK6
         KqsKl6Hi2flhOX8qv0wEeYN2e9INbcTOKjgF91CEznQw4CLzsnhF3nq8LWw1v1MzdGss
         Lv6SHeFc3q/JdNWa7/LtpOxboeT/J6mjmlO2Gcbll9LUBKLKKE5e+5ohzuqoyOxigAR3
         wPlQ==
X-Gm-Message-State: AOAM531pjsfTN/nCz1OMoERrsiiMpJMtGCSzXyliTsfbGtOnhLyghi8e
        x4hIcXwPzyXaQ0ReyPZW83MobD6hBTM5MEf8ZCvyWSiKrQFmsVqARlKkDysQlWzB7apIR/qlhAD
        BzH486OcRPBw+nnVAuAL7Twte
X-Received: by 2002:a05:622a:1350:: with SMTP id w16mr16932720qtk.320.1643675429591;
        Mon, 31 Jan 2022 16:30:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxcU6Q/Ar+1PORDMHeHdSkYIDRol8TVKqlIFKIp6y3P1Nu6cTI+jdY7B1NUgfXzyplagNS42w==
X-Received: by 2002:a05:622a:1350:: with SMTP id w16mr16932710qtk.320.1643675429332;
        Mon, 31 Jan 2022 16:30:29 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::15])
        by smtp.gmail.com with ESMTPSA id e9sm8990768qtx.37.2022.01.31.16.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 16:30:28 -0800 (PST)
Date:   Mon, 31 Jan 2022 16:30:25 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Jann Horn <jannh@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [RFC PATCH] x86/dumpstack: Fix unwind failure due to
 off-by-one-frame
Message-ID: <20220201003025.yb2wpmw4dprmsdww@treble>
References: <20220127005555.2766254-1-jannh@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220127005555.2766254-1-jannh@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 01:55:55AM +0100, Jann Horn wrote:
> (emphasis on the "RFC", not the "PATCH"...)
> 
> I've hit a bug where __dump_stack() ends up printing a stack trace that
> consists purely of guesses (all printed frames start with "? ").
> 
> Debugging the issue, I found that show_trace_log_lvl() is looking at a
> stack that looks like this:
> 
>     function             stored value    pointer in show_trace_log_lvl()
>     ====================================================================
>             show_stack   saved RIP
>             show_stack   saved RBP       <-- stack
>     show_trace_log_lvl   saved RIP       <-- unwind_get_return_address_ptr(...)
>     show_trace_log_lvl   ...
>     show_trace_log_lvl   ...
> 
> show_trace_log_lvl() then iterates up the stack with its `stack`
> variable; but because `unwind_get_return_address_ptr(&state)` is below the
> starting point, the two never compile equal, and so `reliable` is never
> set to 1.

Thanks for reporting!  If I understand correctly, this only happens
when show_stack() has an 8-byte stack size.

> Poking around a bit, I see two issues.
> 
> The first issue is that __unwind_start() tries to figure out whether
> `first_frame` is inside the current frame before even having looked up
> the ORC entry that determines where the current frame ends.
> That can't work and results in being off-by-one-frame in some cases no
> matter how we twist the comparison between `state->sp` and `first_frame`.

> The second issue is that show_trace_log_lvl() asks __unwind_start() to
> stop when it finds the frame containing `stack`, but then tries
> comparing `unwind_get_return_address_ptr(&state)` (which has to be below
> `stack`, since it is part of the lower frame) with `stack`.
> That can't work if __unwind_start() is working properly - we'll have to
> unwind up another frame.
>
> This patch is an attempt to fix that, but I guess there might still be
> issues with it in the interaction with show_regs_if_on_stack() in
> show_trace_log_lvl(), or something like that?
> 
> Another option might be to rework even more how ORC stack walking works,
> and always compute the location of the next frame in __unwind_start()
> and unwind_next(), such that it becomes possible to query for the top
> of the current frame?
> 
> Or a completely different approach, do more special-casing of different
> unwinding scenarios in __unwind_start(), such that unwinding a remote
> task doesn't go through the skip-ahead loop, and unwinding the current
> task from a starting point is always guaranteed to skip the given frame
> and stop at the following one? Or something along those lines?
>
> That would also make it more obviously correct what happens if a
> function specifies its own frame as the starting point wrt to changes to
> that frame's contents before the call to unwind_next()... now that I'm
> typing this out, I think that might be the best option?

If I understand correctly, this last proposal is what the current
__unwind_start() code already attempts to do (but obviously fails in the
above off-by-one case).  It tries to start at the first frame it finds
*beyond* the given 'first_frame' pointer, rather than the frame
including it.  That makes the logic simpler, since you don't have to
find the size of the frame.

So I think this bug could be fixed by reverting commit f1d9a2abff66
("x86/unwind/orc: Don't skip the first frame for inactive tasks").

Can you confirm?

If that fixes it, we may need to do a little more special-casing like
you suggest to get the expected results for the different use cases.

-- 
Josh

