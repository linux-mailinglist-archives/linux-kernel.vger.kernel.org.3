Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7CB8521285
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 12:46:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240016AbiEJKuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 06:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239997AbiEJKt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 06:49:57 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD8F193DB;
        Tue, 10 May 2022 03:45:59 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id a10so603888ioe.9;
        Tue, 10 May 2022 03:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SNnTCe84Y4lgHjzt2eIaU/CTKrKXShYzumTezLzN1tg=;
        b=Ibq5j1LSdg0E2VtB2ruDuS49NRWwyzozl1BfIlRVUYwhGTMjByOT1nxECjnF+dg7T/
         cjFGB0VOwUV1sHAh6dOH3Ey9+vNz7j/R1KfqHmxM56MONbHkQWjUTGpVirh8mssRj+gq
         JoOKbrGI1Fs1SHAN/Uky9p1wndDHZvvdKjHkoJgOVvDoLkxNUA6Ga3BYpiAKaOBNbTGl
         xYYeB/ROeJ+OaA1udvQ6RPe/yKuDxFeqwxcxZkp7N92MOvVNrOVWLlshP8VLDZ+JxcRO
         v7IREdx3R0hv83weoFmZZ0qWr5dSUdrxfq4QI5Mygj54VUx4V8Bn1jNTzRANEeLetQ3Z
         lvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SNnTCe84Y4lgHjzt2eIaU/CTKrKXShYzumTezLzN1tg=;
        b=2htsP6kOiLN7Nb5JCtIiF0XBixOut4fmOt4U3sz3SKc0nzSryQ8yKpyGCeqcWDUcSy
         OZufeqNpstkmXuGvV7lwMFFPvkPereAiXcru2/h6ulg6hgW9qXbJbHF48P1u5V7z8UNb
         RsiKr/jpoG9WSJmFiTW7J3Kp+QlQDt9vRaclbC7f1hVgPhOZUAmIn7jv7oolUIrIzLw4
         9781F8qJZeHyr/VYtFzAAUtMdcBfd1RYd9zGLxmmhNt9Zn3UVubVyYCDCpaTx9HKXHHz
         y+2+AeIZ8cNezLs/c/r8Z50m1eFkMq+Q94FjbIRmXyipAEZmPpQqY6LM3trTC/qF+2sA
         P0NQ==
X-Gm-Message-State: AOAM530kgtTHD0r21jL+dtZgZW2/mux6W6G2R8gM6jR0ufAizDDERK4g
        oFiDBBYUKFvgHbkbJ5g5h6NxM4oNeqdhkp47lY0=
X-Google-Smtp-Source: ABdhPJwATdKHOC3sSPtMN6oh0hRLfFBf5pmvZa8pLqAPBNcGchVX1rD5hhxuA68HKS+9vlzRAx65gcUbRopRtQJaPFk=
X-Received: by 2002:a05:6638:d56:b0:32b:62e4:39be with SMTP id
 d22-20020a0566380d5600b0032b62e439bemr9566596jak.308.1652179558815; Tue, 10
 May 2022 03:45:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220507052451.12890-1-ojeda@kernel.org> <20220507052451.12890-15-ojeda@kernel.org>
 <Ynoki5rA2ivmFwkS@alley>
In-Reply-To: <Ynoki5rA2ivmFwkS@alley>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 10 May 2022 12:45:47 +0200
Message-ID: <CANiq72m-oMTtoXh+RDpQm3pO6F6=u+H8uNWGWGoE=pw79EOc=g@mail.gmail.com>
Subject: Re: [PATCH v6 14/23] vsprintf: add new `%pA` format specifier
To:     Petr Mladek <pmladek@suse.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Gary Guo <gary@garyguo.net>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@google.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
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

Hi Petr,

On Tue, May 10, 2022 at 10:38 AM Petr Mladek <pmladek@suse.com> wrote:
>
> Feel free to use:
>
> Acked-by: Petr Mladek <pmladek@suse.com>

Thanks!

> It would be great to document it also in
> Documentation/core-api/printk-formats.rst
> I am sorry that I did not mentioned it earlier.

Ah, definitely, I will add it.

> Also the check in checkpatch.pl, mentioned in another reply, sounds
> like a good idea.

+1

Cheers,
Miguel
