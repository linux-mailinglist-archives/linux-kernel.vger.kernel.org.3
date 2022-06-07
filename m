Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81E45401CD
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 16:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343568AbiFGOwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 10:52:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343571AbiFGOwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 10:52:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDE7F506F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 07:52:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15627B81DB3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 14:52:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7974C341C6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 14:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654613519;
        bh=nUGvY8qp8MLZCpbuA9uMm+tmCRu40sGop9jcJcMRaUs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CRXWGoTM5/4em/h+sfJjfc+gPXjWHAbZmBrN+Tm4epCh9HmZwLHweH2mKSnYi9Ne/
         YcUJ1NXD+wZtEGYLEB9xWVf8bV7tN9Fs03h+8LzWViNR/gssFtDl1DUeZZ/9icIvco
         1/Wh8nKV9XFCFGteHIBiyIBhBUtVBOJ3F8qJpuWw3C59yGI8SDti2ecHMYQwkasjK3
         ODSgPa2tExwREyy0OjNYcA/zW7rtOR9kUd+PwI35kJSLAMfHxM7NGtN6w1vo3KqiDM
         oysrbgHFqf4XJX62JD4ZV7v0wrza4zmdSKhhTGFL3gH4jF5Y4DfH0HLewjYZRv5tw6
         jcAMRdPg0hUaQ==
Received: by mail-oo1-f42.google.com with SMTP id ay16-20020a056820151000b0041b71517844so1485904oob.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 07:51:59 -0700 (PDT)
X-Gm-Message-State: AOAM533tRZ6SJK4Nr8DwZTtAiRD7wbb2ewQoFWuBWoKve21UzsXWjlq6
        NKSnieJaD0dko3CaPUGZqzef0O8QrB8mfDSN1yM=
X-Google-Smtp-Source: ABdhPJy7N2gw3L1N+nkZAsBmhvp5r0K2l+ufRiclF6nmLKyCbQ/Muh6ib8LV02EZM9XOPq7KMeJLtAPs9Z/Z7ZdWe54=
X-Received: by 2002:a4a:c983:0:b0:41b:9e6f:44ab with SMTP id
 u3-20020a4ac983000000b0041b9e6f44abmr889002ooq.98.1654613518997; Tue, 07 Jun
 2022 07:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220607111514.755009-1-Jason@zx2c4.com> <CAMj1kXFDYX3fAdO6hxH9DTFP7+LNYz0fL9Dy8eKsH_xGwXxatQ@mail.gmail.com>
 <Yp8+6Y+bEcmR1LS0@zx2c4.com> <CAMj1kXFPxP3y6Ma1AonMSiW5DP0veB+NAj+ggfvrWvAARsOmgA@mail.gmail.com>
 <Yp9C4xY0+CguTd7l@zx2c4.com> <CAMj1kXH4ifsytLNpaVTHAumadMjj8rNEZbsn-8t=hH51ucG11A@mail.gmail.com>
 <Yp9lLkYXCo9BZxpk@zx2c4.com>
In-Reply-To: <Yp9lLkYXCo9BZxpk@zx2c4.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 7 Jun 2022 16:51:43 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGY7tPOazLZ0VKagPDcmqURO2Y4MytPMmVjRTz=Ho=2jg@mail.gmail.com>
Message-ID: <CAMj1kXGY7tPOazLZ0VKagPDcmqURO2Y4MytPMmVjRTz=Ho=2jg@mail.gmail.com>
Subject: Re: [PATCH] random: defer use of bootloader randomness to random_init()
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stephen Boyd <swboyd@chromium.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Phil Elwell <phil@raspberrypi.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Jun 2022 at 16:48, Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>
> Hi Ard,
>
> On Tue, Jun 07, 2022 at 04:19:26PM +0200, Ard Biesheuvel wrote:
> > #include <stdio.h>
> > #include <stdlib.h>
> > #include <sys/random.h>
> >
> > static unsigned char buf[16];
> >
> > int main(void)
> > {
> >   for (int i = 0; i < 1000000; i++) {
> >     if (getrandom(buf, sizeof(buf),
> >         GRND_RANDOM | GRND_NONBLOCK) < sizeof(buf)) {
> >           fprintf(stderr, "getrandom() error!\n");
> >           exit(-1);
> >     }
> >   }
> >   return 0;
> > }
>
> I'm actually more worried about the random input flow than the random
> output flow and branch misprediction. But more generally, I'd just like
> to keep that code as cold as possible after crng init. It's code that's
> only used in that one phase and then never again. It can be entirely
> disabled.
>
> Anyway, we've got a few solutions now to pick from on the random.c side
> of things. I'm going to investigate the arm32 situation next. And then
> we'll see what it all looks like.
>

Sure.

It would be helpful if some other folks could chime in as well?
