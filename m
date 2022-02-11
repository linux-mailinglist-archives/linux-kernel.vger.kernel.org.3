Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35CF94B2D2F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 19:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236602AbiBKS5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 13:57:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235421AbiBKS5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 13:57:20 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE77CCEB
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 10:57:13 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id r15-20020a4ae5cf000000b002edba1d3349so11459361oov.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 10:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=swiecki.net; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QMVVkjMchB0s/a3beZw7NTzCf3sxBDL51mOIwpD203k=;
        b=GL0LgTUPusm/gXkWe5cb3RI71yed94r1V7/qjDQ2WB6QNQIkXk8wGM/c2r+tDbObeS
         yoYbBNf4fLZcJ7ByIgwTdWh+ACR0LlvA5ZPobiyqBjhSWZUUA5MIUr+RDFjfz17N3Scn
         l2GOKYbrL6ySj2J6Hk9571DTGIx3PDMLrB8Fg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QMVVkjMchB0s/a3beZw7NTzCf3sxBDL51mOIwpD203k=;
        b=ZJ7aGwowTPGw4g+bJYGI+ZBz2t8dF28kxqHy009vViw67xS4S9agI/64rg6+q0UhAm
         pNa2PW2YjRgOcxDuKKop1jWzRdbMa2HJv9au+3vROT5TBlPAiOEm2d7BDMcMwXZFSng8
         TgQELmGblnLA04O8mUxGp7i17mlD/lpC+sCQrskDVryGLYrqW6zkys3SLyHUoX6Q8zLB
         ftCJnAzlxIuAOfPawScivfwugY6C+/hIUQ7objCAzrfNE+rWprSoCMO35bqtv9sqUFyz
         RwAsd4hcaUkkarsUN0PXKseoq6qvMbnMRP55JWYbg9SzKZSPek+xiOXRgS4V4UVU+Snh
         9WsA==
X-Gm-Message-State: AOAM5304gM6+f7A8n70LyKDVVg4nBA488cgKg0coJOIj0C5D4exgfU8m
        Zr9To0nv26pLwv/0CuIzP1PddWspHySrGzbNDsIx4g==
X-Google-Smtp-Source: ABdhPJyeJ0HVhp1BgrMDOgkHBZ7gDWNotH68ktkbcwoEd65AcEAuS2movuRDZXQrAsACs06cFH4u+eku+T90vkCEqN0=
X-Received: by 2002:a05:6870:3906:: with SMTP id b6mr581232oap.83.1644605833197;
 Fri, 11 Feb 2022 10:57:13 -0800 (PST)
MIME-Version: 1.0
References: <20220210025321.787113-1-keescook@chromium.org>
 <871r0a8u29.fsf@email.froward.int.ebiederm.org> <202202101033.9C04563D9@keescook>
 <87pmnu5z28.fsf@email.froward.int.ebiederm.org> <202202101137.B48D02138@keescook>
 <87k0e249tt.fsf@email.froward.int.ebiederm.org> <202202101710.668EDCDC@keescook>
 <875ypm41kb.fsf@email.froward.int.ebiederm.org> <202202101827.4B16DF54@keescook>
 <CAP145phAg3ZSPJw7x2kKVQe86puy-XyKatVoByVoM27RP4aw_g@mail.gmail.com> <87a6ex1ek2.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87a6ex1ek2.fsf@email.froward.int.ebiederm.org>
From:   =?UTF-8?B?Um9iZXJ0IMWad2nEmWNraQ==?= <robert@swiecki.net>
Date:   Fri, 11 Feb 2022 19:57:02 +0100
Message-ID: <CAP145pii+zCyoQBw778P-Jw9YSOWhQEgB7OTHUaRwfGy7BYWCA@mail.gmail.com>
Subject: Re: [PATCH 0/3] signal: HANDLER_EXIT should clear SIGNAL_UNKILLABLE
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pt., 11 lut 2022 o 18:47 Eric W. Biederman <ebiederm@xmission.com> napisa=
=C5=82(a):

> > I think it'd be good to have some way of doing it from the perspective
> > of a parent process - it'd simplify development of sandboxing managers
> > (eg nsjail, minijail, firejail), and creation of good seccomp
> > policies.
>
> By development do you mean debugging sandbox managers?  Or do you mean
> something that sandbox managers can use on a routine basis?

On a routine basis for 2 purposes

a). development of seccomp policies - the manager (regular parent of
sandboxed process) can tell which syscall (and arguments) failed and
it can be then added to policy (though, 'strace -f -c' might be a
better option here)
b). in case of actual seccomp SIGSYS kill, it could then inform users
about what exactly and where happened (syscall no, cpu arch,
arguments, maybe also eip + stack ptr)

But, I don't want to derail the current bug fixing effort, so I just
wanted to mention all of this quickly, and maybe we can follow up on
this in the future.
