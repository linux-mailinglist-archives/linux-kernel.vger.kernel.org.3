Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257C2553133
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 13:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349571AbiFULmQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 07:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348826AbiFULmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 07:42:15 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A047DDD
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 04:42:14 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id n197so9795694qke.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 04:42:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XsOPQXuW6wpuHbz+/8q/+YnnNNH09/T0pbD7HutKQxc=;
        b=Sz1gzaPoKooK6lJ035FYSAzsHrJPh7CKkgb9ZoDm0ZZRbb6K/vyHM64SuyImpH+0sB
         uvB+VOLvajVFsxb9/v30u683U1LFuT6sG4YX+cILEg2sajO5Bkwcxg29QtdpqvfCoW60
         X7EDe9ocJgNeBbrOWZ40IyTPWvCXyWJkFiqS0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XsOPQXuW6wpuHbz+/8q/+YnnNNH09/T0pbD7HutKQxc=;
        b=OATxL9UWXvIDJ2XSeLMBlKvG71SqB93bdfp2qqTbukUr7K1mQS8Qatk7GKO5+p0cXA
         jEANSTkii6MKSXM2LyC2yBJVKyOz9gbqb1ovOz0KYKtv7r2MUuf9zd6uHo3Tin6QWZkl
         oB9KRbVOnHOQQC61dwLwL3384DYg8hZEYvUCEwL0LIc/XZHszhM0SFsnlgAqC4zyjRB0
         gPlDZ6yGU2ICeW19AlQnAq4tiCPej58Asqdf7YXEUhB4lk1s/WTjW/ClQ+Yzzi3O6do2
         V7OWaCFVpPHcdHDaEHdELueavjhZJ/dxuKNdLPqML4gzyK6xNZupuN640h1YGeO979bP
         hSQQ==
X-Gm-Message-State: AJIora8Oj0pLqgK1iDfWVXEA0fhxHMjnnUTnr5joWobrK7tDmoeY7MFN
        Ig3oV1RzLVg71SmAEaJWm08JP/z7feczlDEV/v0MqAa8Fy1ydA==
X-Google-Smtp-Source: AGRyM1u8Div7AT5jyOote1CqFLOUhCYg3z/GBMzsM368ESPqsfzuYgD5al2ju94s99ngNoSElFed/eZA+q5gP9wfee8=
X-Received: by 2002:a05:620a:40c9:b0:6a7:84a6:11a3 with SMTP id
 g9-20020a05620a40c900b006a784a611a3mr19352541qko.331.1655811733449; Tue, 21
 Jun 2022 04:42:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220621090900.GB7891@pathway.suse.cz>
In-Reply-To: <20220621090900.GB7891@pathway.suse.cz>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Tue, 21 Jun 2022 20:42:02 +0900
Message-ID: <CAFr9PXkKCf-JRcv+bk17HcC8-4kRG=J9bnNtp_nsMqzg4f=epw@mail.gmail.com>
Subject: Re: [PATCH v2] printk/console: Enable console kthreads only when
 there is no boot console left
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On Tue, 21 Jun 2022 at 18:09, Petr Mladek <pmladek@suse.com> wrote:
>
> Threaded console printing does not take into consideration that boot
> consoles may be accessing the same hardware as normal consoles and thus
> must not be called in parallel.
>
> Since it is currently not possible to identify which consoles are
> accessing the same hardware, delay threaded console printing activation
> until it is known that there are no boot consoles registered.
>
> Link: https://lore.kernel.org/r/20220619204949.50d9154d@thinkpad
> Link: https://lore.kernel.org/r/2a82eae7-a256-f70c-fd82-4e510750906e@sams=
ung.com
> Link: https://lore.kernel.org/r/20220619204949.50d9154d@thinkpad
> Reported-by: Marek Beh=C3=BAn <kabel@kernel.org>
> [john.ogness@linutronix.de: Better description of the problem.]
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Tested-by: Marek Beh=C3=BAn <kabel@kernel.org>
> ---
> Changes against v1:

The lockups on boot seem to be gone on my boards with this patch.
So FWIW:

Tested-by: Daniel Palmer<daniel@thingy.jp>
