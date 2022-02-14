Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E2B4B55D2
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 17:12:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356225AbiBNQLP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 11:11:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356227AbiBNQKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 11:10:40 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF61460D9F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:10:26 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id j2so47755199ybu.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 08:10:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7cG3DtS4AFRpk5Ytg8SebP0tvlPwMV13yDhdJ92f6j8=;
        b=nkY8OC1guEp+iBvvAKdH8uX4DHWKDUYifZMG7fUcaVU5dGlMpe0ROTjrfcTYl5ikh9
         cF17s9gZMl/Flw+7Bw/CDtMSY4YAJ6zQ3Dg5e3qel/uDjE53fEPXceT9l0RqCIxIUs0s
         Tn34nIqD8jvG/EeL4seiSbzkA4VH1+IjamxBwWyJzxUfKFmSxbeSKVp1glLpwisZ/vOu
         EFbI+K6ea432x1R3uVsUDH/Jdva4B7BcKmQygfhCrpH68Dgbzr3iu3ZHO8GEAygm2Vil
         ZO+H9mdL79k3ldSQpcV415Cx/rZf1bQIg+vnVjaq73QoJniq8v6l33qdN1tBIwNiFS8C
         BetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7cG3DtS4AFRpk5Ytg8SebP0tvlPwMV13yDhdJ92f6j8=;
        b=UGFvYml4JE3nGoYKezSijKPKMJKRUuRIPSFgh/mZ3WiHOHbbhX1SsCFp4FzGsXJnbJ
         ywBJ+zec1k4zg6J+6b2WHmkOT688ozCTI5ajDE06Nl7+KzFcqWP0edMffEZPdHguy4Io
         bZiHzLeykzgwAqrr88DcKsex2gzSu1o3WCQVd67y9R2MvoSjc8BNyasEZ6k/wpdntXnh
         rOpRszxN6yTl2Yu/+qEeLBygSqLtyFOow44gDX1h6T8A74H7NVVAN2kf7u2hAqFKF1O4
         ueCqOlmRTG+QEYU2ez4tbiCIubYPl0wfPeZUfrkFfEBW9WAnP4TDFD5t2bbqEdxFdjmo
         7Tmg==
X-Gm-Message-State: AOAM5330WWOeyBAh2fi5D0+zscJvwKNUeK/5I6KQ6idVoW4FG4eba8eA
        gVo8Hrdnq9UJmwlsXQTz09uyKkHKTlYhe8aDlCOwPQ==
X-Google-Smtp-Source: ABdhPJxmeN0Mu0nfPv7jQg7fnM5tK8qeTcOwoiKNnS1LECVetrm3mNP8Yu3R/CnlqIPtPQaboKVejM8GSgVVJp7zzC4=
X-Received: by 2002:a81:ff10:: with SMTP id k16mr314507ywn.321.1644855025825;
 Mon, 14 Feb 2022 08:10:25 -0800 (PST)
MIME-Version: 1.0
References: <20220211014313.1790140-1-aik@ozlabs.ru> <CAKwvOdkKsoYw9KOfwdHYg7OkTz0TQ6YgZZcqQ5PNg+_O1Q5bgg@mail.gmail.com>
In-Reply-To: <CAKwvOdkKsoYw9KOfwdHYg7OkTz0TQ6YgZZcqQ5PNg+_O1Q5bgg@mail.gmail.com>
From:   Sami Tolvanen <samitolvanen@google.com>
Date:   Mon, 14 Feb 2022 08:10:16 -0800
Message-ID: <CABCJKudj5VJ-f+QU0qmnODoadEzpVME2rXhtUZbzrEV8o69hqQ@mail.gmail.com>
Subject: Re: [RFC PATCH kernel] trace: Make FTRACE_MCOUNT_USE_RECORDMCOUNT configurable
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Kees Cook <keescook@chromium.org>, llvm@lists.linux.dev,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 4:11 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> + Sami, Kees
>
> Do you guys remember why we don't support
> FTRACE_MCOUNT_USE_RECORDMCOUNT with LTO?

It's because recordmcount cannot distinguish between calls and other
references to mcount/fentry, which is a problem with LTO where we have
to process the entire vmlinux.o and cannot ignore individual
translation units. Instead of resorting to workarounds, Peter was kind
enough to implement a smarter mcount pass in objtool, which we now use
on x86_64 with LTO.

Alexey, which architecture are you trying to fix here?

Sami
