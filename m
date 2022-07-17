Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 044A55776C5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 16:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232823AbiGQOpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 10:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbiGQOop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 10:44:45 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2FF8FD17
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 07:44:42 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id j22so17110840ejs.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 07:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HlrziZZ76Peg4qV5xEsTcKPFlstjpM1SL9BDNiXfu2c=;
        b=DS8vDfy5PisUHpo8QkxoxfYYXqiO9hj+fmk/WC8pM7VlVfPf4QI7fKq+8iWyFlBosN
         xOaKReN1tr6gKUlm2poGf/qYOY0t1sShwW+dhRV//mwtfmSuMpaD81F4Kwf9rs0vMp7F
         xavWty7gfUG6G+PTd+tLOjuyv7MUqoAAUViF4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HlrziZZ76Peg4qV5xEsTcKPFlstjpM1SL9BDNiXfu2c=;
        b=u8e8IByuGQ5KsGpAxI4tRi7hiAHDF8n4cqcPAglau1iTBtOQSY8UZDM4aKI0IlD0kN
         nlqpF/T8RftFr+HoocJ54zBkZ/AfkHF1Gz1FNwaBn0v0aJFhfZnCJDjamPBQZgvl5Fxb
         Spt/FM5S3CK7aPQA/xvYNMoh0HLEG9BZDJEwK2xnZc6ZstcMZdhdYnSJFo6djc7wzXhK
         5WQWbkx7hUVaofJmC77o2S5yuEn/ybS1NyFINIDbpyNSvxgdGrJfojo8c1xh6H04X80y
         c0+KXCUIHQY3rTJ/tE4YmpFRFWkQlMYTsi4KDh06NIMolV/UJRJM+yMPIZ/0NarsrVTQ
         YsaQ==
X-Gm-Message-State: AJIora8LOpBtSYL/mA2Fn6XvPKtaGWqHj1DuLyidGyXyuOEexs+2RsSL
        Bp7kgUX2e7L3cR3oNwet31GLDpXhfcxS92GY
X-Google-Smtp-Source: AGRyM1uLTNXaC/VB2Mah7h34XLkkxNjD7i5/VWQ4iQre1smzDT9M+ihN2ocycP8vK0q+6V//8NBH/A==
X-Received: by 2002:a17:906:6a21:b0:72f:2174:16e6 with SMTP id qw33-20020a1709066a2100b0072f217416e6mr3819294ejc.177.1658069081073;
        Sun, 17 Jul 2022 07:44:41 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id ey9-20020a1709070b8900b0072ed72072aesm4375420ejc.192.2022.07.17.07.44.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Jul 2022 07:44:40 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id e15so8286482wro.5
        for <linux-kernel@vger.kernel.org>; Sun, 17 Jul 2022 07:44:39 -0700 (PDT)
X-Received: by 2002:a05:6000:1f8c:b0:21d:7e98:51ba with SMTP id
 bw12-20020a0560001f8c00b0021d7e9851bamr18844596wrb.442.1658069078907; Sun, 17
 Jul 2022 07:44:38 -0700 (PDT)
MIME-Version: 1.0
References: <Ys/aDKZNhhsENH9S@debian> <CADVatmO9XzFnX+N0TuOtr0FYyxKr1oe5RAhCEJjmnvjteT5QNw@mail.gmail.com>
In-Reply-To: <CADVatmO9XzFnX+N0TuOtr0FYyxKr1oe5RAhCEJjmnvjteT5QNw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 17 Jul 2022 07:44:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=whc3Uvhrmrr27xp5=oOhSDjXc5s1ZxC3B7xMYV6oj4WRQ@mail.gmail.com>
Message-ID: <CAHk-=whc3Uvhrmrr27xp5=oOhSDjXc5s1ZxC3B7xMYV6oj4WRQ@mail.gmail.com>
Subject: Re: mainline build failure of powerpc allmodconfig for prom_init_check
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Kees Cook <keescook@chromium.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2022 at 2:13 AM Sudip Mukherjee
<sudipm.mukherjee@gmail.com> wrote:
>
> I was trying to check it. With gcc-11 the assembly code generated is
> not using memset, but using __memset.
> But with gcc-12, I can see the assembly code is using memset. One
> example from the assembly:

You could try making the 'args' array in 'struct prom_args' be marked
'volatile'.

Ie something like this:

  --- a/arch/powerpc/kernel/prom_init.c
  +++ b/arch/powerpc/kernel/prom_init.c
  @@ -115,6 +115,6 @@ struct prom_args {
           __be32 service;
           __be32 nargs;
           __be32 nret;
  -          __be32 args[10];
  +        volatile __be32 args[10];
   };

because I think it's just the compilers turning the small loop over
those fields into a "memset()".

              Linus
