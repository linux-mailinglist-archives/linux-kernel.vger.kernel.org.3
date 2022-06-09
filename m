Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8337954524A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 18:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344224AbiFIQts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 12:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241991AbiFIQtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 12:49:46 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F186322B10;
        Thu,  9 Jun 2022 09:49:42 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-30ce6492a60so247456927b3.8;
        Thu, 09 Jun 2022 09:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fMS9TIxkGe1SNflk7Pc+4GXMnerXGYgSxsPZVCqDiJY=;
        b=PR2+3AZZEG3PUn9lrnsvEvT86Nqs4LH6hBUk9VS7NtftZstIj3t0CGR4Xsi3uv4PpX
         cqnpyQpC1/554+CbFpFZMF65TYZIUyv1IEtZ7WpriE35RoG0BH7+RcWls9kZQqKcR+u+
         0KW2ARaoEP2+DonhKFPf1dHzlHjHIiELq4XwSc2bDFSwcWvhXkTkISrKe078Bmzuk+Oe
         jOXwSFzA2CguORw5dHZsBv/AibkXi3T+MQDFPGy/rcF701WUMEgm36t5UrywA7ZDQ8ZU
         tjIEmMMRq5aq/S4LCDu8TUIgxsHp2Q6NwGcSj/n66un//+W2HnQA77iIQbn2az8DHuIz
         Q1dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fMS9TIxkGe1SNflk7Pc+4GXMnerXGYgSxsPZVCqDiJY=;
        b=j4f8vgYBkBnHbPyOqSEvyyQYYta9vwnvuQp0pzA0TmHUJ81AdqJMXUlvzGSJXB5Jex
         MzMyFr6X9iNlri9AZrn7h5ic+jkERs15YFbWv4rQs76bo876yqcOwPLV0SRrqU9hMofg
         8Iy9AIY5KZvmsmv4jhAqm+p7EkY8+QlkMAIxhGGuLTBrmir/DLNg+OL4JsUNIoWGl8uy
         XKlgXGKXrhsinwTSNOct0q+thOA5JDHSsmKn8Wf2CACsdkuQY+wZ1Zwbouh+mp4Gh6q3
         hqL3L5GGQ6c/riD0tPLV/BgYwJFLE0BrB+g8DvXaMB1oWVFz+VLCDhxdZ+nuBxqDIKLM
         ND0A==
X-Gm-Message-State: AOAM532P879Cujui3fQHD1deA2jZ1MCWf1ZmrEC2l5oHDOoTP9aXpL4T
        If5hLHTOmoi4mQgBokhmcqGG/xwxasYJVGs/3Lk=
X-Google-Smtp-Source: ABdhPJwyITj+sNxPe7wtPh4y3au+6gdTenhqJOJnPfcYop0KE+vUbAV5NuLM+sGgBGixRemuT1J+B2x80tXDP06BACo=
X-Received: by 2002:a81:920e:0:b0:30c:201e:b3d1 with SMTP id
 j14-20020a81920e000000b0030c201eb3d1mr43671912ywg.374.1654793382188; Thu, 09
 Jun 2022 09:49:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220608212923.8585-1-jorge.lopez2@hp.com> <20220608212923.8585-2-jorge.lopez2@hp.com>
 <CAHp75VfPoranKhsHJo=8jJXXhdvqn4-x2E2UJa-Yxb_=tO3QDg@mail.gmail.com>
In-Reply-To: <CAHp75VfPoranKhsHJo=8jJXXhdvqn4-x2E2UJa-Yxb_=tO3QDg@mail.gmail.com>
From:   Jorge Lopez <jorgealtxwork@gmail.com>
Date:   Thu, 9 Jun 2022 11:49:31 -0500
Message-ID: <CAOOmCE-cAWRa6e2t2ZChbNBGA2YkWph+iV_nm+7=CpmqPCso1g@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] Resolve WMI query failures on some devices
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, balalic.enver@gmail.com,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Gross <markgross@kernel.org>
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

Awesome, thanks!

On Thu, Jun 9, 2022 at 11:30 AM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Wed, Jun 8, 2022 at 11:32 PM Jorge Lopez <jorgealtxwork@gmail.com> wrote:
> >
> > WMI queries fail on some devices where the ACPI method HWMC
> > unconditionally attempts to create Fields beyond the buffer
> > if the buffer is too small, this breaks essential features
> > such as power profiles:
> >
> >          CreateByteField (Arg1, 0x10, D008)
> >          CreateByteField (Arg1, 0x11, D009)
> >          CreateByteField (Arg1, 0x12, D010)
> >          CreateDWordField (Arg1, 0x10, D032)
> >          CreateField (Arg1, 0x80, 0x0400, D128)
> >
> > In cases where args->data had zero length, ACPI BIOS Error
> > (bug): AE_AML_BUFFER_LIMIT, Field [D008] at bit
> > offset/length 128/8 exceeds size of target Buffer (128 bits)
> > (20211217/dsopcode-198) was obtained.
> >
> > ACPI BIOS Error (bug): AE_AML_BUFFER_LIMIT, Field [D009] at bit
> > offset/length 136/8 exceeds size of target Buffer (136bits)
> > (20211217/dsopcode-198)
> >
> > The original code created a buffer size of 128 bytes regardless if
> > the WMI call required a smaller buffer or not.  This particular
> > behavior occurs in older BIOS and reproduced in OMEN laptops.  Newer
> > BIOS handles buffer sizes properly and meets the latest specification
> > requirements.  This is the reason why testing with a dynamically
> > allocated buffer did not uncover any failures with the test systems at
> > hand.
> >
> > This patch was tested on several OMEN, Elite, and Zbooks.  It was
> > confirmed the patch resolves HPWMI_FAN GET/SET calls in an OMEN
> > Laptop 15-ek0xxx.  No problems were reported when testing on several Elite
> > and Zbooks notebooks.
>
> Perfect!
>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> Also needs a Fixes tag:
>
> Fixes: 4b4967cbd268 ("platform/x86: hp-wmi: Changing bios_args.data to
> be dynamically allocated")
>
> (I believe Hans can help you and add it on the fly)
>
> > Signed-off-by: Jorge Lopez <jorge.lopez2@hp.com>
> >
> > ---
> > Based on the latest platform-drivers-x86.git/for-next
> > ---
> >  drivers/platform/x86/hp-wmi.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/platform/x86/hp-wmi.c b/drivers/platform/x86/hp-wmi.c
> > index 0e9a25b56e0e..d3540dd62d06 100644
> > --- a/drivers/platform/x86/hp-wmi.c
> > +++ b/drivers/platform/x86/hp-wmi.c
> > @@ -290,14 +290,16 @@ static int hp_wmi_perform_query(int query, enum hp_wmi_command command,
> >         struct bios_return *bios_return;
> >         union acpi_object *obj = NULL;
> >         struct bios_args *args = NULL;
> > -       int mid, actual_outsize, ret;
> > +       int mid, actual_insize, actual_outsize;
> >         size_t bios_args_size;
> > +       int ret;
> >
> >         mid = encode_outsize_for_pvsz(outsize);
> >         if (WARN_ON(mid < 0))
> >                 return mid;
> >
> > -       bios_args_size = struct_size(args, data, insize);
> > +       actual_insize = max(insize, 128);
> > +       bios_args_size = struct_size(args, data, actual_insize);
> >         args = kmalloc(bios_args_size, GFP_KERNEL);
> >         if (!args)
> >                 return -ENOMEM;
> > --
> > 2.25.1
> >
>
>
> --
> With Best Regards,
> Andy Shevchenko
