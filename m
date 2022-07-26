Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F2A581AC5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 22:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239822AbiGZUMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 16:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiGZUME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 16:12:04 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04B032477
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 13:12:01 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id o13so4039729edc.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 13:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aqW2jQ+Akji8N/AJOWkQoEhPnhEDdU8RvQcZ00uEYJo=;
        b=ZG5zQYj0tD9ykZ3Z3UzFvSYkW1evxRXZfyYL2+l+05i8v5KOUb9pDU+JxPb3YIpNDT
         sQWPHRM/lA4J508Wa0zqu8qFiq8WUhvP1BPyIwjATYDJMzx6HJtsyWGSKVsW3xJA3QXY
         neSHF4ZOOHkmVfqA8QtIr6oxkklc4RLZfrvT3zmusJxGS4+gA7u6t15YQEvm/eTB9Nev
         rtfL/x7+1yuZ9+4o4YDl0bY6TTnCXHrEIrb/L5LCAkrQ6IKl4AQDUXN9IlXRcGbKsMjS
         S2kNNvCDHai2la0ddMcrPFgqEB6Jep0KyJLJYvHh2PscEY9eJaz8DzCSJr3LGj3k/6Kv
         4VNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aqW2jQ+Akji8N/AJOWkQoEhPnhEDdU8RvQcZ00uEYJo=;
        b=ievC2xBHBjBxfW7wt/aF51L6aqWCVZsYAQyIEzVxfuoj6HLRDkYaJB/oPD/8EVhO9N
         koywrn+Yj6N0b9axbqpFKe/bgQlkWvkCfGftRMDCVdP9b8EaQ6hLJOhjk2rbZAhQ4rJO
         R3EYulx9+5k7fJFyF2NedxliN6Q6WKs7vHrGeQ9ngU943X6+gKZcjl/5GAc3paDtbpOu
         ShPEwnyH4ZA2I9HLMD0t4MSiJglLKAJjpKlefEER1eQO24G0oESxc194STrZoVqHEwMh
         J0z3J/ZAuYadVtL4rpQ+lNkpDbCt4XspTfU6ITsx3ImDGYH+XUJtFSro99l1shch+Ofx
         Imuw==
X-Gm-Message-State: AJIora9+ne8bhaeDgRrFnhPruJ15x/8i25gJmMAaLSiXduf2RoZZC7dr
        jELR7bAwzX3BfdbggSGyObU=
X-Google-Smtp-Source: AGRyM1vGpFkmv1bsXHo6g9sRYLgWWV7T7/PMkLzh3P4QVXtNc+H+z4ZdLYjvn6IP4DHhIKvqctzVfQ==
X-Received: by 2002:a05:6402:51d4:b0:43c:1742:430b with SMTP id r20-20020a05640251d400b0043c1742430bmr9621483edd.212.1658866320152;
        Tue, 26 Jul 2022 13:12:00 -0700 (PDT)
Received: from bhl6zntu.conti.de ([2a02:908:2525:6ea0:4afb:53d1:2272:b50b])
        by smtp.gmail.com with ESMTPSA id wj22-20020a170907051600b0072af2460cd6sm6863959ejb.30.2022.07.26.13.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 13:11:59 -0700 (PDT)
Date:   Tue, 26 Jul 2022 22:11:51 +0200
From:   Wadim Mueller <wafgo01@gmail.com>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Conor.Dooley@microchip.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SIFIVE DRIVERS" <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH] checkstack: add riscv support for scripts/checkstack.pl
Message-ID: <20220726201151.GB17701@bhl6zntu.conti.de>
References: <20220713194112.15557-1-wafgo01@gmail.com>
 <fa77d640-a18d-ca77-ba57-6735094a224f@microchip.com>
 <CAK7LNARu4OU_hGQHu8B7F=5jLzU1jp7L=RHVcyo3eLkEyWNcQw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK7LNARu4OU_hGQHu8B7F=5jLzU1jp7L=RHVcyo3eLkEyWNcQw@mail.gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor, Hi Masahiro,

thank you for your support. Your help is much appreciated.

Best Regards
Wadim

On Tue, Jul 26, 2022 at 01:47:47PM +0900, Masahiro Yamada wrote:
> On Tue, Jul 26, 2022 at 2:40 AM <Conor.Dooley@microchip.com> wrote:
> >
> > On 13/07/2022 20:41, Wadim Mueller wrote:
> > > [You don't often get email from wafgo01@gmail.com. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> > >
> >
> > I feel like you might've been mislead by get_maintainer for this
> > patch. It looks like the maintainer covering this is Masahiro
> > Yamada <masahiroy@kernel.org> (at least he's taken the last few
> > patches for it).
> 
> 
> I can pick this up.
> 
> Applied to linux-kbuild. Thanks.
> 
> 
> >
> > I'll be honest, I don't know how to verify that the output is
> > correct - but I did run it & it does output something that looks
> > sane /shrug
> >
> > Thanks,
> > Conor.
> >
> > > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > >
> > > scripts/checkstack.pl lacks support for the riscv architecture. Add
> > > support to detect "addi sp,sp,-FRAME_SIZE" stack frame generation instruction
> > >
> > > Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
> > > ---
> > >  scripts/checkstack.pl | 4 ++++
> > >  1 file changed, 4 insertions(+)
> > >
> > > diff --git a/scripts/checkstack.pl b/scripts/checkstack.pl
> > > index d2c38584ece6..d48dfed6d3db 100755
> > > --- a/scripts/checkstack.pl
> > > +++ b/scripts/checkstack.pl
> > > @@ -16,6 +16,7 @@
> > >  #      AArch64, PARISC ports by Kyle McMartin
> > >  #      sparc port by Martin Habets <errandir_news@mph.eclipse.co.uk>
> > >  #      ppc64le port by Breno Leitao <leitao@debian.org>
> > > +#      riscv port by Wadim Mueller <wafgo01@gmail.com>
> > >  #
> > >  #      Usage:
> > >  #      objdump -d vmlinux | scripts/checkstack.pl [arch]
> > > @@ -108,6 +109,9 @@ my (@stack, $re, $dre, $sub, $x, $xs, $funcre, $min_stack);
> > >         } elsif ($arch eq 'sparc' || $arch eq 'sparc64') {
> > >                 # f0019d10:       9d e3 bf 90     save  %sp, -112, %sp
> > >                 $re = qr/.*save.*%sp, -(([0-9]{2}|[3-9])[0-9]{2}), %sp/o;
> > > +       } elsif ($arch =~ /^riscv(64)?$/) {
> > > +               #ffffffff8036e868:      c2010113                addi    sp,sp,-992
> > > +               $re = qr/.*addi.*sp,sp,-(([0-9]{2}|[3-9])[0-9]{2})/o;
> > >         } else {
> > >                 print("wrong or unknown architecture \"$arch\"\n");
> > >                 exit
> > > --
> > > 2.25.1
> > >
> > >
> > > _______________________________________________
> > > linux-riscv mailing list
> > > linux-riscv@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> 
> 
> -- 
> Best Regards
> Masahiro Yamada
