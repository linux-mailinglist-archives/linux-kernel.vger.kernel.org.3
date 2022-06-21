Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843F055326E
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 14:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350546AbiFUMpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 08:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350684AbiFUMpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 08:45:33 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20DBC29802
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 05:45:30 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id pk21so4121489ejb.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 05:45:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bcjA9/tClfWPESGlrIQVZA/2r4BPB9szIxR6nIZp8Ww=;
        b=gJW2z+Y4X78SHt7UAWAYQwmYmh3fuUA+fG8GEQH8GLP8+sGvw+wkgDN2h41I6JMxLh
         meCoPMfH2uzNKpXtTgzPGogy3bU3FxrNet7ujQdYM5LCIsS4n0lt/7a50cWHAQX0uTLS
         0cG8AoDGgzyXgx2Ox47YAbkV7kVHCiwRXJVQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bcjA9/tClfWPESGlrIQVZA/2r4BPB9szIxR6nIZp8Ww=;
        b=Xop+OViQPY70yJfD26KwRbkhFKgLky0VPkS1Fk5ycOU07furEbyXq+BqqVZnC98Sdz
         dSSUeuTV7CI10c5GZoWCMCLPI2qBjpCMx6Rq5iFFJuN+j5owVuapMbuGfW0vZ2mLFEJj
         erTxXoB3HUtfLAD+AaAfHtohJ1uDw9rpb1IuZUp84+qCR3VukFzYQAXTYR/H5i7yVXNA
         d59PPG6tFTuad87qHODgb/lAeFVs6EEuekaK5SR20glSvIHCq5YMhY0LzCVi6r3Oisc+
         nWKYe+gEHDe9t7LfYbKY8lNc6zWobrxoBJ980f13jKOC5xxjjb0yA3m6t6pWGkapDWJR
         oaLQ==
X-Gm-Message-State: AJIora8PHgo7tlpY13s3W15ZSIfBXCQeN4E/4aKR7J8gIk9r2QNsC70B
        UDumXqhh4h/sOH3NgQ8itmqlrFBXen45e0R7
X-Google-Smtp-Source: AGRyM1s1Skkjzn0JntwguH5V+e6fEfFCTjNONcV4dV/PeKmXAMu1itiMWNaoG9Mhhu60B9+iJwuYJQ==
X-Received: by 2002:a17:906:c048:b0:718:ca61:e7b9 with SMTP id bm8-20020a170906c04800b00718ca61e7b9mr25593821ejb.120.1655815528513;
        Tue, 21 Jun 2022 05:45:28 -0700 (PDT)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com. [209.85.128.46])
        by smtp.gmail.com with ESMTPSA id h12-20020a05640250cc00b004358cec9ce1sm3593457edb.65.2022.06.21.05.45.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jun 2022 05:45:26 -0700 (PDT)
Received: by mail-wm1-f46.google.com with SMTP id l126-20020a1c2584000000b0039c1a10507fso7198838wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 05:45:26 -0700 (PDT)
X-Received: by 2002:a05:600c:3485:b0:39c:7db5:f0f7 with SMTP id
 a5-20020a05600c348500b0039c7db5f0f7mr30105277wmq.8.1655815525809; Tue, 21 Jun
 2022 05:45:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220621090900.GB7891@pathway.suse.cz> <CAFr9PXkKCf-JRcv+bk17HcC8-4kRG=J9bnNtp_nsMqzg4f=epw@mail.gmail.com>
In-Reply-To: <CAFr9PXkKCf-JRcv+bk17HcC8-4kRG=J9bnNtp_nsMqzg4f=epw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Jun 2022 07:45:09 -0500
X-Gmail-Original-Message-ID: <CAHk-=wg9dB5Fc7skWTEOHNohgf=p3oLdL4H_FW-7GyunnQ5Edg@mail.gmail.com>
Message-ID: <CAHk-=wg9dB5Fc7skWTEOHNohgf=p3oLdL4H_FW-7GyunnQ5Edg@mail.gmail.com>
Subject: Re: [PATCH v2] printk/console: Enable console kthreads only when
 there is no boot console left
To:     Daniel Palmer <daniel@0x0f.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        John Ogness <john.ogness@linutronix.de>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>
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

On Tue, Jun 21, 2022 at 6:42 AM Daniel Palmer <daniel@0x0f.com> wrote:
>
> The lockups on boot seem to be gone on my boards with this patch.

Good.

Petr, was this all the reports sorted out? Sounds like we can keep the
kernel thread model.

                  Linus
