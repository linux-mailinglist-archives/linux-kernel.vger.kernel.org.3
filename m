Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFCB4B7FB5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 05:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344522AbiBPEv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 23:51:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344431AbiBPEvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 23:51:50 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B0B0BD2FE
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 20:51:37 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 195so1116575pgc.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 20:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ozlabs-ru.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=U8eQUsaiuvfdO3IgfBqvbUSDsbva5gKLb5MEIzgw2eE=;
        b=cZIDOJeahCGn3AdKZfVPt+MiKrc+rR+MukeFhI+8YawjGR9fnZiZtpUUvOFDzSRHh3
         9kCzHQke5DEYQROn/0+O3cCFmAttsee0CJ3kG8lNF4p5hB49AFumVtCYtepWTGtWqu9d
         NnrQbyyvoXrLTdyoZ7IddsvbVPuekOi7EcrImSl9Ebmc693O0PJ2rdPzuwxZWzhLnN2I
         Ud8ZROljBZYzqjmb0971DJFJPmkLkMnX/3gg3Ouht1OiZgcTXlngU8hWVhNrhrlq2lX3
         Kcacu8E+fHVDsrylulXA1rxiDT2EVjULsR3Kyb3sAJq+hKxd3HRZbrqaXBH1fKFTNaM7
         lPSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=U8eQUsaiuvfdO3IgfBqvbUSDsbva5gKLb5MEIzgw2eE=;
        b=5Rq4wBQe7S9nSFdo8zxnjKiYOOkP6s+9a0qFkoeZTLp0jcggpWuPj6fCyupeT5Nu9N
         lUajJVn7pikKHe+Q8V7OWM7QnaKDWhwf5QJj3mtLbQcUP27SjQ6llEI92K4w4sxfnPsp
         OwTZQS0P+0gX61g6PvTnIRGkM90oBjgjhbXnBnmLJPKX6VmXev7qhlkQxyNEAbiREAWc
         O/8QzvViphBgQwl4C7gDIEuHcAQtaT1atBA4bqsboA/VLiueYeldq6llHlhFGyx3AGej
         to+Ywc2fgB6MlrMMlpBMwOuRdeTmLRS3pWpDKKFdqxgNKt1HnuaeQ7/vF2dmDG/Lnr3t
         OlgA==
X-Gm-Message-State: AOAM532cbBhibEJvQ9XZl84tFAXwM8sPj+qMFnrRkGKAvkFLaaQ/RzN+
        dK3f2u3jEK1mnXVF6IQ/hhaimA==
X-Google-Smtp-Source: ABdhPJwOgmr4/U+0CQce1FmUkpL5w9ASN5368AKCh9x8pGmOIigflKL2cjulpUa3pybTAQZ9Wa9Idg==
X-Received: by 2002:a63:4cf:0:b0:363:c42:c135 with SMTP id 198-20020a6304cf000000b003630c42c135mr887140pge.82.1644987096612;
        Tue, 15 Feb 2022 20:51:36 -0800 (PST)
Received: from [192.168.10.24] (203-7-124-83.dyn.iinet.net.au. [203.7.124.83])
        by smtp.gmail.com with ESMTPSA id t11sm4251105pgi.90.2022.02.15.20.51.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 20:51:36 -0800 (PST)
Message-ID: <5b021d73-51c1-164f-6136-483eeebef6fb@ozlabs.ru>
Date:   Wed, 16 Feb 2022 15:51:31 +1100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:97.0) Gecko/20100101
 Thunderbird/97.0
Subject: Re: [RFC PATCH kernel] trace: Make FTRACE_MCOUNT_USE_RECORDMCOUNT
 configurable
Content-Language: en-US
To:     Sami Tolvanen <samitolvanen@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>, llvm@lists.linux.dev,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
References: <20220211014313.1790140-1-aik@ozlabs.ru>
 <CAKwvOdkKsoYw9KOfwdHYg7OkTz0TQ6YgZZcqQ5PNg+_O1Q5bgg@mail.gmail.com>
 <CABCJKudj5VJ-f+QU0qmnODoadEzpVME2rXhtUZbzrEV8o69hqQ@mail.gmail.com>
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <CABCJKudj5VJ-f+QU0qmnODoadEzpVME2rXhtUZbzrEV8o69hqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/15/22 03:10, Sami Tolvanen wrote:
> On Fri, Feb 11, 2022 at 4:11 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
>>
>> + Sami, Kees
>>
>> Do you guys remember why we don't support
>> FTRACE_MCOUNT_USE_RECORDMCOUNT with LTO?
> 
> It's because recordmcount cannot distinguish between calls and other
> references to mcount/fentry, which is a problem with LTO where we have
> to process the entire vmlinux.o and cannot ignore individual
> translation units. Instead of resorting to workarounds, Peter was kind
> enough to implement a smarter mcount pass in objtool, which we now use
> on x86_64 with LTO.


So can x86_64 have both FTRACE_MCOUNT_USE_RECORDMCOUNT and LTO?

> Alexey, which architecture are you trying to fix here?


powerpc64le.

> 
> Sami
