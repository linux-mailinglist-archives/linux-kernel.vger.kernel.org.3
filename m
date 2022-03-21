Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51AC04E30E8
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 20:47:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352824AbiCUTsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 15:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239684AbiCUTsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 15:48:51 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918B776297
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:47:21 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id c15so21323854ljr.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lCiODI9PI/EEfC6nyI3suBU5YNtGDoGGxuNDXJnVdTA=;
        b=ezmZUQJ4kvMrHLo4x5F8XsnqcRGxtWgktJJ1WwpOwWXNKYLVOUbTbyhLyRBpe5o8Dt
         +g8PqbcgmlNrTRHqBe78ScSgYJYGnvcSIKiLY8zwdhx//bndxVsMOhUQyeXm2OUHo2AA
         zezBo+N6+i7TZSdnwddAT0+JYMamd1jr42bIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lCiODI9PI/EEfC6nyI3suBU5YNtGDoGGxuNDXJnVdTA=;
        b=6ui9jIkNPq693m439szm2kXfNsYo3nSO+KYq4Q9L1mw69PHygeT9s30L7IIaPkUeiA
         oPKMp4WCrq5OwY7jSfRKCamZ2mhXxWhoMCBWC/gBacl+83KYQ5wuuRRp0CeMA6VWK5IM
         L5JdcsrIRtXk4Me1TsfL3FXp8ltC8NmrouKo2jvab8l4F47icgpJI07NbPiUjaRUqh36
         wvmntImhbI79hLF8iUF2yjk5VmSDJ1kY700g+bU7yKRrDmge/ACNxZRcN+0cLLpajVZP
         H47kmibu7LeF/0LEs150HKIqiE0bXa9tajKnrSZTf49yh81nDaOYTR+iSMIiI9ZTwLjm
         GNww==
X-Gm-Message-State: AOAM533SpTM2H1WN1r2DxDevlDUNjxV+L3WPje3f43+XGWJIVlpeZ15D
        Zjim7qeEziDpdLROBm09oNIXzfKdYMyxYVxNhhQ=
X-Google-Smtp-Source: ABdhPJy95Ya2NviqIo9Bu3A+aYbg8txXV0UgttM7+noppa16CWI7gwYnqlki6lulBu/BfOewVsGJag==
X-Received: by 2002:a05:651c:3cc:b0:249:800d:58ea with SMTP id f12-20020a05651c03cc00b00249800d58eamr6855403ljp.41.1647892039380;
        Mon, 21 Mar 2022 12:47:19 -0700 (PDT)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id r25-20020ac25a59000000b00445b78bb876sm1893923lfn.295.2022.03.21.12.47.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 12:47:18 -0700 (PDT)
Received: by mail-lf1-f54.google.com with SMTP id a26so8337493lfg.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 12:47:17 -0700 (PDT)
X-Received: by 2002:a05:6512:2294:b0:448:6c86:3c78 with SMTP id
 f20-20020a056512229400b004486c863c78mr15188243lfu.531.1647892037101; Mon, 21
 Mar 2022 12:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <164786042536.122591.4459156564791679956.tglx@xen13>
In-Reply-To: <164786042536.122591.4459156564791679956.tglx@xen13>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 21 Mar 2022 12:47:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgfSKuzHggdngkXxSDvRp3FOMwbbvPJqag99NiRekbJfg@mail.gmail.com>
Message-ID: <CAHk-=wgfSKuzHggdngkXxSDvRp3FOMwbbvPJqag99NiRekbJfg@mail.gmail.com>
Subject: Re: [GIT pull] core/core for v5.18-rc1
To:     Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
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

On Mon, Mar 21, 2022 at 4:02 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>   - Provide a mechanism to delay raising signals from atomic context on
>     PREEMPT_RT enabled kernels as sighand::lock cannot be acquired.  Store
>     the information in the task struct and raise it in the exit path.

This isn't super-pretty, but doing it conditionally makes it even uglier.

I've pulled this, but my reaction to it all is
"force_sig_info_to_task() isn't that critical, and
CONFIG_RT_DELAYED_SIGNALS might as well have been unconditional".

In fact, is there any reason to make it conditional even at run-time, ie this:

> +       if (!in_atomic())
> +               return false;

looks a bit unnecessary too. Why not just always do that thing and
avoid having two code-paths?

I really think we don't want more complexity in this unusual "force
signal on exception" case, and TIF_NOTIFY_RESUME doesn't seem like
it's the wrong place to do it.

Hmm?

Anyway, I've pulled it in this form, I just don't like the special
cases that seem a bit pointless. They not only make the code bigger
and more complex, they actively mean that test coverage is much worse
too.

             Linus
