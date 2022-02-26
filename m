Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031974C5308
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 02:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbiBZB2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 20:28:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiBZB2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 20:28:38 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0351AAFDE;
        Fri, 25 Feb 2022 17:28:04 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id h16so8514850iol.11;
        Fri, 25 Feb 2022 17:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZnbbEMt3jkmlYOE0bA6a7Tz/qzU0Syhvt4pmLzBwk+U=;
        b=RD+cBNsCKTgv1ZnZ1ww8dul+ibocM3XNMxPC3T5gBhIuZDqFh4/+kYvjgl+t3THB1t
         TNY0vlilXIORXYvymwZxQrrjSEK1wd4iJiCthynJiK1XwO21rxyqWtt4NZcR05feyV2n
         zFvQSxJsRzpiH2PfaXX410mFGoUH5iC6BS7r0YhEenMmvWUivRtYM5bBamYy/HJ4UfQf
         mLKAjuy7qOm5PbBJEnJV+fLywhchcsy2LndGiD5cvN6P9igs3Jc+hC3E7bO8/PdkZFGK
         Tm5PdGBeZ0zNFQ8NQgn4dY65bZy9Yq8Irbw8vHAUhXXnjcSAFaVjOaOFooFxtYNNcrVO
         7N1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZnbbEMt3jkmlYOE0bA6a7Tz/qzU0Syhvt4pmLzBwk+U=;
        b=Fz2AVTJRnzAu1OVXpv59kpgrvZwQ27b6ptu/Hs6vcNBctL//1cJZKrpv+Xk5KPz7Nv
         9Gn2xyXWba/qfBC716BWWIwd/YD+1Ufw5XIgQ6FtnK3SGQpZ95BQtfIH5o9LIJFruSQB
         kR5VMEI30l2pHx5RrlkEVs0wQca7CIqqNP02s3tCRb1Rxy4M0+kz1xCl/RGK+OYP50aB
         oGuFpMIV+uaNZBAKv/Iqp2sZaRArlBss7OFkNVHM3/EYdvFr4pWCbPtwxv5/Qb67hzLQ
         fGecfnFOvLP+ff/FlGhrUhaPcP5oatsV6feoO+vF7ve90mrmgSZA5SDtMVW6r/wrK0gS
         LjXw==
X-Gm-Message-State: AOAM530oC5nsLbO7vFHaiuzDi0PA5ri2zaTAhKy+D/fQQAAqMQ1Uci6I
        yptNE5BkG6h3j947LV1ffSKrbzu0J77/SNz080tnVTUyz5NShg==
X-Google-Smtp-Source: ABdhPJwr8piYYKuKvOcgUuJp6nj91ylsWJvd8vpauApcGsvvimPOHYrtBAnaLmcM49B9zyvW3bEcZ47iiLi2OkJg/Kg=
X-Received: by 2002:a05:6602:2d90:b0:63d:b41e:e4e4 with SMTP id
 k16-20020a0566022d9000b0063db41ee4e4mr7393250iow.172.1645838884294; Fri, 25
 Feb 2022 17:28:04 -0800 (PST)
MIME-Version: 1.0
References: <20220225032410.25622-1-ashimida@linux.alibaba.com>
 <CANiq72kXoonDYk095XvBwEtRCRNECd1iQOqJHE2cNcgLyUMfcQ@mail.gmail.com> <202202251258.DB0F403B@keescook>
In-Reply-To: <202202251258.DB0F403B@keescook>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 26 Feb 2022 02:27:53 +0100
Message-ID: <CANiq72=KjCd8pWKuXFzoW7oBQM9DV=DDyGzCyz62F4B+e5Q_qg@mail.gmail.com>
Subject: Re: [PATCH] [PATCH v2] AARCH64: Add gcc Shadow Call Stack support
To:     Kees Cook <keescook@chromium.org>
Cc:     Dan Li <ashimida@linux.alibaba.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Marco Elver <elver@google.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 9:59 PM Kees Cook <keescook@chromium.org> wrote:
>
> I thought about that too, but I think it's less simple due to the
> __has_feature vs CONFIG differences, etc:
> https://lore.kernel.org/lkml/202202251243.1E38256F9@keescook/
>
> But maybe __has_feature doesn't really matter here?

I have not tested it, but I was assuming the `CONFIG` could do its
job, since it comes from testing the compiler flag.

If the `__has_feature` is actually restricting it more than that, then
we should probably get the `CONFIG` fixed so that it only gets enabled
when really it is going to be used.

Cheers,
Miguel
