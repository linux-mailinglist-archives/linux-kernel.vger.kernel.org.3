Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558C54B4FC8
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 13:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352695AbiBNMMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 07:12:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbiBNMMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 07:12:43 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E490E48E7A;
        Mon, 14 Feb 2022 04:12:35 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id z18so12145848iln.2;
        Mon, 14 Feb 2022 04:12:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I63uXQLULxgIp+fxBBldhXZGMfrAe8iy9NyQfbBqJO0=;
        b=JZBkvSicr6NtfK98ljz2alqvymXQ0GUvDMoAHYM8+T6uTTo6eGknpXg4G/hXbfa4J6
         i9FjhKAXKmSxBx3kC/ZhkVWFWKA7jYsYruEVp5Dpei0Z/LMWn69PIt/6U9iBK4ryufb0
         q/JP0zQ67doDCcrtc1OQxa6Tf+m4T03mKevIVCx6P2OvVIAEXvnhBzN5qnNMxc6NFAuN
         DgKMWnQW7JgwTvayVkKG2k+Gia6oL+OwF6BcLHs8Q7MlwEEJcH0W0zMKnu4iEO/pZa6h
         aiK3179PUSbIAY6rcmtq41FqJoXeTK9Q/QoUaz1MyM4T3QPUyVSTiSWqNO9TvqEOmvNi
         mxqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I63uXQLULxgIp+fxBBldhXZGMfrAe8iy9NyQfbBqJO0=;
        b=GZs24v5ZusgtHU4kpxXAplTb9NVaFXh8tALqDof/VQPSJI2v44KXFX0opd8Q3m4RCQ
         +ahVWkFKuoG+MenPVbH0Yv7yFgtbWi4PvK1ZfhxPksn+smwK5CyyWdUziVmvHWj7MjU6
         Dnhw3H5eTLCIMIIWoytQDTonW3Ky3tyy3YCaAIqpuTGrh3gy5XuslcDbN3NtqRGNIWqI
         JZq7BKU1EclYnxTKmE6DJDNuemRFao1FabDHv7WHkzn3jmPsOR05SBPV+RnPUqwKAbYr
         I5iwkIxFSmm6O/kO561QED7C5f4wGrPj4r9eaTHT5xI0bOxMWMPnfwwKk+pAsTb7Ml3J
         HYEg==
X-Gm-Message-State: AOAM5312nIzJdqKhuToGNVdduA3B7x2JpLX8+UL6xyu9x+3/iiYezCeG
        kEBHu9R2JlKxA0+ckqtAdOeN7ik43qDfJq0cjJY=
X-Google-Smtp-Source: ABdhPJxP0qVSdni91fTkhLPpuqdXa4tkmKCt6AvlGTNRlON0vuZGUCaWQMGTu6DhK93bwZFFtrS8Zo/9aCY1r6Dg5OU=
X-Received: by 2002:a92:c248:: with SMTP id k8mr3453071ilo.321.1644840755343;
 Mon, 14 Feb 2022 04:12:35 -0800 (PST)
MIME-Version: 1.0
References: <20220212130410.6901-1-ojeda@kernel.org> <20220212130410.6901-13-ojeda@kernel.org>
 <YgosclY9ebD3t020@smile.fi.intel.com> <dc9054f2-5e2b-0ae2-1022-23421668dd05@rasmusvillemoes.dk>
In-Reply-To: <dc9054f2-5e2b-0ae2-1022-23421668dd05@rasmusvillemoes.dk>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 14 Feb 2022 13:12:24 +0100
Message-ID: <CANiq72=mNh415UG_nxDQc=9SCSVSPnqcAbgFZKzavnmsim_L0Q@mail.gmail.com>
Subject: Re: [PATCH v4 12/20] vsprintf: add new `%pA` format specifier
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Gary Guo <gary@garyguo.net>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
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

On Mon, Feb 14, 2022 at 11:52 AM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> I think the point is for vsnprintf() to call (back) into Rust code.

Indeed, this is the case.

> That said, I don't like the !CONFIG_RUST version to return NULL, that
> will surely crash moments later.
>
> So I prefer something like
>
> [rust.h]
> // no CONFIG_RUST conditional
> +char *rust_fmt_argument(char* buf, char* end, void *ptr);
>
> [vsprintf.c]
> +       case 'A':
> +               if (IS_ENABLED(CONFIG_RUST))
> +                   return rust_fmt_argument(buf, end, ptr);
> +               else
> +                   return string_nocheck(buf, end, "[%pA in non-Rust
> code?!]", default_str_spec);

Sounds good. Or perhaps simply `break` and let it print the pointer
(to be consistent with `g` case and non-error `e` case).

Cheers,
Miguel
