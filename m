Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FBB4D9CB4
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 14:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348850AbiCON50 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 09:57:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237737AbiCON5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 09:57:25 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72EB53E0A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:56:12 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id b28so21446372lfc.4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 06:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s1/XtdD9lOjuxMU2r55RI6PoOC6K/O2oa4T7eimZ1IU=;
        b=ZWS5A+0tbbX4H7U6XAT5oIl2GXv6bYR3x7p8n/Vb+8X3Wq9HKmUVGgd5LU7oRnWDUj
         Ve2umdkc34LWh02hX9mVaM0yzFGhWeRfTeqO7eSvMlcUy83DLZVzqicGdZZCwZlabWbX
         XZ0aM/FqC4k+8Say759OTpsbXJCyjGaCnb6GW92F4L7+yKVoZJ4y2WDqhXWopCosBZ0W
         SeqdcIzN/xiMR4mGTynqpZeIBlzbckahEZCu3dxlMMocJuSE4YGOZJFelEmX08rNnc62
         sMJQ83gR4srUKW0ouhpyp/hOlndXbjNr66XZ3VzcAJULrT64ojt6MdeR/zLU5F7JjT+N
         CJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s1/XtdD9lOjuxMU2r55RI6PoOC6K/O2oa4T7eimZ1IU=;
        b=hLHEFQ/U3lbLnd33Led3SHICvTREzpveVApOyEKALE672NZwYLRgRhdWHwJV7LBSvJ
         Qn4Xhthk4lU0CVS6RRsrgwrccp0kj9qflnI07gNQAu3n0LIFSGW4fAp2YqfjxcehuSxc
         hDM7j17psZ3AlARdaB6aO9gm5MEsGkfJNqM0fh1TqGz6H0MmNu6SvvmzCehmRErASZAG
         kG4lzBmjsX9+lVFhOCRJTfkQp1jiR+bt5n/otthdQzTc2t06XV++IHFAsx2adP7olbtP
         IBxhr5bHS9iLNu04hHf4HoVpXSuFsSjtPXyg8XXoAgCIlcmOJfPJ0FkNKaxAvQdtJso9
         w+zw==
X-Gm-Message-State: AOAM5335D9Yp0wPcn9Kc2q4wm+qxx4Y5iGdZI8+S9QmJOVfeseY5qEN1
        jIQXAwtejzIWCDfeZX1F1ixLhSTI9IEcXBamOjE=
X-Google-Smtp-Source: ABdhPJynvxlUirgTz4EMM9qs0K1zH5RFuuURzqmKE9XGQierM+iYa1DkOpd1q4VPH1YfzGaIBIrlsnqbu+Le00EoZAg=
X-Received: by 2002:a05:6512:10d5:b0:448:8b71:3654 with SMTP id
 k21-20020a05651210d500b004488b713654mr9050289lfg.349.1647352571047; Tue, 15
 Mar 2022 06:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220313032125.124094-1-libang.linuxer@gmail.com> <20220313173646.e3d797f9ee3105239179fb5d@kernel.org>
In-Reply-To: <20220313173646.e3d797f9ee3105239179fb5d@kernel.org>
From:   =?UTF-8?B?5p2O5qOS?= <libang.linuxer@gmail.com>
Date:   Tue, 15 Mar 2022 21:56:00 +0800
Message-ID: <CAH753rByBhsNp-EARbTZ_N3sPRSWipU+A=pTD7pv2ae4V-aXwg@mail.gmail.com>
Subject: Re: [PATCH] kprobes: Allow both @symbol_name and @addr to exist
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     naveen.n.rao@linux.ibm.com, anil.s.keshavamurthy@intel.com,
        davem@davemloft.net, linux-kernel@vger.kernel.org
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

On Sun, Mar 13, 2022 at 4:36 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Sun, 13 Mar 2022 11:21:25 +0800
> Bang Li <libang.linuxer@gmail.com> wrote:
>
> > If the address found by the @symbol_name is equal to the @addr, this case
> > should be considered a valid parameter combinations.
>
> Could you tell me the reason why this is needed and use case?
> I explictly made this case as an error, because I couldn't find
> any good reason to support this case.
>
> Thank you,
>

I'm not sure if I need to change it this way, I just think it's more
comprehensive.

Thanks

> >
> > Example:
> >
> > static struct kprobe kp = {
> >     .symbol_name    = "kernel_clone",
> >     .addr           = (kprobe_opcode_t*)kernel_clone,
> > };
> >
> > Signed-off-by: Bang Li <libang.linuxer@gmail.com>
> > ---
> >  kernel/kprobes.c | 15 ++++++++++-----
> >  1 file changed, 10 insertions(+), 5 deletions(-)
> >
> > diff --git a/kernel/kprobes.c b/kernel/kprobes.c
> > index 94cab8c9ce56..70d4ed9e7dc7 100644
> > --- a/kernel/kprobes.c
> > +++ b/kernel/kprobes.c
> > @@ -1497,13 +1497,19 @@ bool within_kprobe_blacklist(unsigned long addr)
> >  static kprobe_opcode_t *_kprobe_addr(kprobe_opcode_t *addr,
> >                       const char *symbol_name, unsigned int offset)
> >  {
> > -     if ((symbol_name && addr) || (!symbol_name && !addr))
> > +     kprobe_opcode_t *symbol_addr;
> > +
> > +     if (!symbol_name && !addr)
> >               goto invalid;
> >
> >       if (symbol_name) {
> > -             addr = kprobe_lookup_name(symbol_name, offset);
> > -             if (!addr)
> > +             symbol_addr = kprobe_lookup_name(symbol_name, offset);
> > +             if (!symbol_addr)
> >                       return ERR_PTR(-ENOENT);
> > +
> > +             if (addr && symbol_addr != addr)
> > +                     goto invalid;
> > +             addr = symbol_addr;
> >       }
> >
> >       addr = (kprobe_opcode_t *)(((char *)addr) + offset);
> > @@ -2062,8 +2068,7 @@ bool __weak arch_kprobe_on_func_entry(unsigned long offset)
> >   * function entry address or not.
> >   * This returns 0 if it is the function entry, or -EINVAL if it is not.
> >   * And also it returns -ENOENT if it fails the symbol or address lookup.
> > - * Caller must pass @addr or @sym (either one must be NULL), or this
> > - * returns -EINVAL.
> > + * Caller must pass @addr or @sym, or this returns -EINVAL.
> >   */
> >  int kprobe_on_func_entry(kprobe_opcode_t *addr, const char *sym, unsigned long offset)
> >  {
> > --
> > 2.25.1
> >
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
