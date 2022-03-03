Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B68F4CC6C0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 21:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbiCCUDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 15:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235913AbiCCUDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 15:03:21 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFE9B9B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 12:02:35 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id u11so8252187lju.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 12:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F++KWIByQw15zKEln3xtCXqdyRaB/5lOWU6i+7W/zvU=;
        b=PknX5RT2csG8YCPJJzeTThmKtWYz/gqBuB+ekT0aM3WjTZ3KKVFIpSIWfpfKVPM5Ki
         o+9YfSG9Yy7saDcQotbBnEVnPMoCo7IhS9uKplbQdtuhfSP4iQ1IBYoIUnm3uY7DHZq3
         5Xjkqbv8O1UbcN/o1GM/kFCbUdwyb65CjJdIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F++KWIByQw15zKEln3xtCXqdyRaB/5lOWU6i+7W/zvU=;
        b=s2mAdYBw4lFyGaTI4zGKJk3Y3Nwytc3ouxNUeCq51ZCb2sR6V5aTU9r2CGPTW5+fJQ
         udp4D2xsDg83MX7yHeWtRUU3LW9KCxO9hUBMZ9DsAxHgpoh448DG83vPy4Q3rpQ4U2jj
         6ISC2cSL7LzJUx4BrHTxhFohb4F6bMv1My+fZ43iGK8uK1HnS4UGSdNo/o4gw9BEeven
         7Qg2sOOQgIz2Aitsh2U2p09tyBMjxg5kL2m1EfS3YTsaMoi87uGlR4uhgZFi2ihQmH2V
         2HHd2Sil0jin8gyNET8WZtOuwKCYj3YR8uphzJPd5kWHASCIrSAk4L/EYp0Df2bWBWXN
         N3Ag==
X-Gm-Message-State: AOAM532KUSkf6EtPwR/JbWtdmX30fK1gYUWdl8j77yXuPYTki/nZfjzJ
        rryF9DTUN7nYmAB2cEnE7B8phqI5+Iy+OGtw2dA=
X-Google-Smtp-Source: ABdhPJz1h/05Aei3Z2OljCDFMdJv5prGEHrHM9HV7eGOPI5E0P9lAKh9rbNULmgA+YcsWnXpizIMSQ==
X-Received: by 2002:a05:651c:311:b0:246:1250:d6f with SMTP id a17-20020a05651c031100b0024612500d6fmr24245162ljp.455.1646337753375;
        Thu, 03 Mar 2022 12:02:33 -0800 (PST)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id p23-20020a2e9ad7000000b00244b2ec2f88sm662133ljj.50.2022.03.03.12.02.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Mar 2022 12:02:32 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id j7so10410471lfu.6
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 12:02:31 -0800 (PST)
X-Received: by 2002:a05:6512:6c6:b0:447:ca34:b157 with SMTP id
 u6-20020a05651206c600b00447ca34b157mr75483lff.435.1646337750887; Thu, 03 Mar
 2022 12:02:30 -0800 (PST)
MIME-Version: 1.0
References: <20220301075839.4156-1-xiam0nd.tong@gmail.com> <20220301075839.4156-3-xiam0nd.tong@gmail.com>
In-Reply-To: <20220301075839.4156-3-xiam0nd.tong@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Mar 2022 12:02:14 -0800
X-Gmail-Original-Message-ID: <CAHk-=whJX52b1jNsmzXeVr6Z898R=9rBcSYx2oLt69XKDbqhOg@mail.gmail.com>
Message-ID: <CAHk-=whJX52b1jNsmzXeVr6Z898R=9rBcSYx2oLt69XKDbqhOg@mail.gmail.com>
Subject: Re: [PATCH 2/6] list: add new MACROs to make iterator invisiable
 outside the loop
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 28, 2022 at 11:59 PM Xiaomeng Tong <xiam0nd.tong@gmail.com> wrote:
>
> +#define list_for_each_entry_inside(pos, type, head, member)            \

So as mentioned in another thread, I actually tried exactly this.

And it was horrendous.

It's _technically_ probably a very nice solution, but

 - it means that the already *good* cases are the ones that are
penalized by having to change

 - the syntax of the thing becomes absolutely nasty

which means that _practially_ it's exactly the wrong thing to do.

Just as an example, this is a random current "good user" in kernel/exit.c:

-       list_for_each_entry_safe(p, n, dead, ptrace_entry) {
+       list_for_each_entry_safe_inside(p, n, struct task_struct,
dead, ptrace_entry) {

and while some of the effects are nice (no need to declare p/n ahead
of time), just look at how nasty that line is.

Basically every single use will result in an over-long line. The above
example has minimal indentation, almost minimal variable names (to the
point of not being very descriptive at all), and one of the most basic
kernel structure types. And it still ended up 87 columns wide.

 And no, the answer to that is not "do it on multiple lines then".
That is just even worse.

So I really think this is a major step in the wrong direction.

We should strive for the *bad* cases to have to do extra work, and
even there we should really strive for legibility.

Now, I think that "safe" version in particular can be simplified:
there's no reason to give the "n" variable a name. Now that we can
(with -stc=gnu11) just declare our own variables in the for-loop, the
need for that externally visible 'next' declaration just goes away.

So three of those 87 columns are pointless and should be removed. The
macro can just internally decare 'n' like it always wanted (but
couldn't do due to legacy C language syntax restrictions).

But even with that fixed, it's still a very cumbersome line.

Note how the old syntax was "only" 60 characters - long but still
quite legible (and would have space for two more levels of indentation
without even hitting 80 characters). And that was _despute_ having to
have that 'n' declaration.

And yes, the old syntax does require that

        struct task_struct *p, *n;

line to declare the types, but that really is not a huge burden, and
is not complicated. It's just another "variables of the right type"
line (and as mentioned, the 'n' part has always been a C syntax
annoyance).

              Linus
