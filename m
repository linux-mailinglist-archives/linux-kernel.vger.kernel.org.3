Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA5864D5773
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 02:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344012AbiCKBn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 20:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233427AbiCKBn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 20:43:56 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACB6CD5ED
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 17:42:53 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id z26so10207523lji.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 17:42:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=hLFNo3h1Zc1UQ8/DMGxbZedolKRWk33TAyloll9SclM=;
        b=OE5VsEvE8fNq3LsGKordr6ba8Tdtd+y1Hr2unD/Fou1X8hPFiu9jdXoAySW70trnHB
         5bHvv5uJJqE3XIGPi7PN3K+Fk1aSiJMip7DcYsVGaTUNLioDaM0dE/5qbAk/h3gYjDHk
         J9+SSoZL6kxWzHw+8D0Z35q12aMUKOtm29dB8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=hLFNo3h1Zc1UQ8/DMGxbZedolKRWk33TAyloll9SclM=;
        b=JVoO2BXIjUMMREAp6cCr8FdUqpPlEMsLv9jXrvxWZWVZzf4TP6XFBJHAj8Wm46QHa5
         xcWSSsZgCxfiSlRNSlcZRhAxJGQ0eqgvv4eOBU0THnoWF3wl3k0gsEYd7n8/OKNk47Q1
         wXI/e/GEgFoOlsf3yhCGCjvsi1T3CdkI5tZnNReRPqc46U42fYsCJ0GhdCBUHoxp/gcC
         m4v/pFtZzhvn7KyIWA0QKsGf8yZgrJD9e2et9GWnyT5p+wwPGFMDN4wrFvrhYAF2f1DN
         O7AKsQrAgOceb4VQphY5xpae3Bjub0dt+HcDlGFqURbV3PearnwD7jDS8q+ZuMkpBlTw
         xL+w==
X-Gm-Message-State: AOAM531IYmv/ov+V7wsJwR32YW2Z/6woI7pyuTi8BjPVtdHRFqEutLjG
        lGnA3ziKHodzu4w8qeldQuQbdFR+SEB+Hv6aUOs=
X-Google-Smtp-Source: ABdhPJzefsVpD1pPlhBXt1F50i10PtjCwfpPn8N951qs3FBQWrUzYfllG5AzsvO83mWBNWF/j8EtnQ==
X-Received: by 2002:a2e:5009:0:b0:247:d738:3e8e with SMTP id e9-20020a2e5009000000b00247d7383e8emr4646078ljb.281.1646962972057;
        Thu, 10 Mar 2022 17:42:52 -0800 (PST)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id d4-20020a193844000000b0044315cbf157sm127572lfj.64.2022.03.10.17.42.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 17:42:50 -0800 (PST)
Received: by mail-lj1-f171.google.com with SMTP id 25so10215626ljv.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 17:42:50 -0800 (PST)
X-Received: by 2002:a2e:804b:0:b0:247:e81f:87e9 with SMTP id
 p11-20020a2e804b000000b00247e81f87e9mr4803701ljg.176.1646962970388; Thu, 10
 Mar 2022 17:42:50 -0800 (PST)
MIME-Version: 1.0
References: <20220311013238.3387227-1-pobrn@protonmail.com> <20220311013238.3387227-2-pobrn@protonmail.com>
In-Reply-To: <20220311013238.3387227-2-pobrn@protonmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Mar 2022 17:42:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjkqz42CNjDgWA9U3uNWa9GriqaCqqKciqm0sZUYjfLQg@mail.gmail.com>
Message-ID: <CAHk-=wjkqz42CNjDgWA9U3uNWa9GriqaCqqKciqm0sZUYjfLQg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/2] list: add type-safer list_head wrapper
To:     =?UTF-8?B?QmFybmFiw6FzIFDFkWN6ZQ==?= <pobrn@protonmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Xiaomeng Tong <xiam0nd.tong@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Jakob Koschel <jakobkoschel@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2022 at 5:33 PM Barnab=C3=A1s P=C5=91cze <pobrn@protonmail.=
com> wrote:
>
> The underlying idea is to define each list head using an anonymous struct=
:

Why struct? Union is much better, and doesn't pointlessly waste memory
for members that are only used for their type.

Anyway, as far as I can tell, your model is unworkable as-is, since it
only works for a list that is external to the types in question.

Which is not even remotely the interesting case. All serious list uses
are inside other types, and refer to each other.

So this seems to be fundamentally broken, in that it only works for
trivial things, and is not even as good as

   https://lore.kernel.org/all/CAHk-=3DwiacQM76xec=3DHr7cLchVZ8Mo9VDHmXRJzJ=
_EX4sOsApEA@mail.gmail.com/

that actually converted a real case.

That one didn't do the automatic offset thing, but see

   https://lore.kernel.org/all/CAADWXX-Pr-D3wSr5wsqTEOBSJzB9k7bSH+7hnCAj0Ae=
L0=3DU4mg@mail.gmail.com/

on the problems that has.

Again, you avoided those problems by making the use-case a narrow and
uninteresting one.

                 Linus
