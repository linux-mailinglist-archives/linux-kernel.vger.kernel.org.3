Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21371532ED9
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 18:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239648AbiEXQVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 12:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239419AbiEXQV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 12:21:29 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0571FB492;
        Tue, 24 May 2022 09:21:26 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id o16so12187351ilq.8;
        Tue, 24 May 2022 09:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LC2IXAGcmYuiteZpSiIXi00J39B1CEM53r26v/kTRJM=;
        b=MycnTkQhH+UxSrimwN12BB8TeOpX70Fq9HSbOTIJylR8wHkeAejpaS7Dm2NPvfA3SW
         POz0Ge9dHsexOR1LZR8jYvWaoxlCgsGqWZIED8pF2bp5HDSkO9uiZEtuidOVq5suRWPz
         XYkIqIhtEf8rzc3hPRU9j6ooGV7afl2IbZabN+zo+F6I7DxbOt+tgXitaCysCmaLAPc6
         CnQZ6ka9ORT4ZQNImgRyVRnlsj4wZRShNxsuqaObrYONLvldfFLAMQ4bg8gVMyKlyyIs
         h5Onos6LsWuEHkvwL1ffKx9B/BunUXZAu5wkTfxA+RgTiaSYl1c/9VvtmyfyHIb8G1oP
         CIdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LC2IXAGcmYuiteZpSiIXi00J39B1CEM53r26v/kTRJM=;
        b=GDlCzvYxo89LmcaU+DTcommu7uFl4WR69T9Nf3jQpo9t6OEG/qjDUG4XSvCtv0GnbD
         A5ftaUVmgo2g9ry1wVwLiGUO3MDACMEgyewJ2RMZK5JRss52WTthrSU07a+9TrfiT8gZ
         dNiT+AfayvZ4EFTBfnT1WLzDv27cDrBdC+w7XmJ7rEPFMQKT37tvgGc13/9X+rSqSnz/
         V2g3nqu8P+MxFcBT6RgW+i31k5jGCL+EY8So9PCC35NFr287e+Cl2KD68n5B8kHxj1fE
         duTAvu5fSSO+yPjBXxOe4MwHmioemJuZcf7kvjzYMJ3VUO688JMCnqnrtFv2Q7zmr1IH
         77KA==
X-Gm-Message-State: AOAM531u7OZnvtOk5Pr97Xh6+2l4hideJvxuFro6NWD4eEWtikNFfi86
        T2aAPllGJR1ux+kQI60ZUZmHqn+kIK7U8vWZAoU=
X-Google-Smtp-Source: ABdhPJwNQSKfUEC0s31c/Rr9/rNSNWE/ryUc80Ip9r8jglMdrY3NeJGsyCM/aWzJ5tw0gW9aXRlC9IcJXApIK+49uuw=
X-Received: by 2002:a05:6e02:1c81:b0:2d1:3971:9343 with SMTP id
 w1-20020a056e021c8100b002d139719343mr14623732ill.237.1653409286022; Tue, 24
 May 2022 09:21:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220523020209.11810-1-ojeda@kernel.org> <20220523020209.11810-2-ojeda@kernel.org>
 <YovkR56ZYsPhDW4q@kernel.org>
In-Reply-To: <YovkR56ZYsPhDW4q@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 24 May 2022 18:21:14 +0200
Message-ID: <CANiq72=K4eC5EX9M8YRzL5Uy9onoTzha9rki-XZ3enSPy0p+UQ@mail.gmail.com>
Subject: Re: [PATCH v7 01/25] kallsyms: avoid hardcoding the buffer size
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux <rust-for-linux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Kees Cook <keescook@chromium.org>
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

On Mon, May 23, 2022 at 9:46 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> "Declare KSY_NAME_LEN, which describes the maximum length for a kernel
> symbol read by kallsyms from the input.  In read_symbol(), define the
> buffer to be of length "KSY_NAME_LEN + 1", which includes the terminator
> character."
>
> would be better.

Note that the patch is not declaring `KSYM_NAME_LEN`, but a new
constant for a fairly arbitrarily sized for an input buffer.

I am all for detailed commit messages, and I agree this can be
expanded. However, I think the first sentence of what you wrote should
be part of the docs of the constant, and the second one sounds like it
could be a comment on the code. Something like "Introduce
KSYM_NAME_LEN_BUFFER in place of the previously hardcoded size of the
input buffer (...)" would be better for a reviewer.

> You must split this then into two patches:

Note that the size is not really being increased in a meaningful way
-- the important bit is the introduction of the relationship between
constants. The changes are all meant as a replacement for the
previously hardcoded constant, so I don't think the split is a "must",
but we can do it.

We can even split this into 3 patches: clean up the unneeded `sizeof`,
replace (and, importantly, document) the hardcoded constant, and
finally introduce the relationship.

Thanks for taking a look!

Cheers,
Miguel
