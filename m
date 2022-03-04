Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C9B4CD5DC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 15:05:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234080AbiCDOGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 09:06:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiCDOGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 09:06:14 -0500
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D431B8FFE;
        Fri,  4 Mar 2022 06:05:27 -0800 (PST)
Received: by mail-vs1-f54.google.com with SMTP id d11so9156128vsm.5;
        Fri, 04 Mar 2022 06:05:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sh/UsdLtl5esoC6iW6GtfHfa3gbA1m4Kn/Ru4w1jxfc=;
        b=lii4qe0Bm/WBecxqeoKj2dKKmLGx95kb615ofXuLxXcQzgveonMVYtVXhvEu1q6LIM
         P9IZER3rqMU8o+pVSLSmdIq3hbm5Nrr/FRPygvYLOUlDJLQgbR80tVadzygy90c7rDIj
         pCBlzLw93vt7z4Bj3bp6JPMir5pIzhYjhDuDMTLYfzRXFCqLHShUcuFneo3n/ynpdRB+
         foxCtgLtuRnuC5GzKBv3mgPXECgxfuFKJ9ud6u1jcqMU0DvQKwxBHaIeC81kR6JTHovM
         r0quwVth3ttSqqkJ7Z/MU+ADTIq63nCnzjUuYzmAUD734JPR1pTFnMEALr3Mp5P8y1uj
         hwSA==
X-Gm-Message-State: AOAM5314CJei7oBPdrnfGMCySP8qG4QVI9+2jg6+nxUcy4adokV6GZ8/
        WPS/AS4TQ3XhL8O04fhwK5MdUNgttrQPFw==
X-Google-Smtp-Source: ABdhPJyH1P+a55lhlnnwoEKcKHiJGP4Q3+hHPMw4BKComFhFigadnBnTHylRB15Ad8bZ7CjDo/ldTg==
X-Received: by 2002:a05:6102:a21:b0:31c:c1e:6bd4 with SMTP id 1-20020a0561020a2100b0031c0c1e6bd4mr16036413vsb.25.1646402725993;
        Fri, 04 Mar 2022 06:05:25 -0800 (PST)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com. [209.85.221.173])
        by smtp.gmail.com with ESMTPSA id u6-20020ac5c926000000b00330e8c9b1d6sm741617vkl.39.2022.03.04.06.05.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 06:05:25 -0800 (PST)
Received: by mail-vk1-f173.google.com with SMTP id f12so4412766vkl.2;
        Fri, 04 Mar 2022 06:05:25 -0800 (PST)
X-Received: by 2002:a05:6122:8ca:b0:332:64b4:8109 with SMTP id
 10-20020a05612208ca00b0033264b48109mr17830506vkg.7.1646402725242; Fri, 04 Mar
 2022 06:05:25 -0800 (PST)
MIME-Version: 1.0
References: <20220303224237.2497570-1-robh@kernel.org> <20220303224237.2497570-2-robh@kernel.org>
 <CAMuHMdU6g7c9YX0mBAGWbCWgA8exkUSfqn8ZGi_2N+Nz1WT+BA@mail.gmail.com> <YiIa3Ox7UBLyBtoR@robh.at.kernel.org>
In-Reply-To: <YiIa3Ox7UBLyBtoR@robh.at.kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 4 Mar 2022 15:05:13 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU9yzpLh+S821osed5nuHfc0rONB+i4sPjXsGuKLumgfQ@mail.gmail.com>
Message-ID: <CAMuHMdU9yzpLh+S821osed5nuHfc0rONB+i4sPjXsGuKLumgfQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: kbuild: Pass DT_SCHEMA_FILES to dt-validate
To:     Rob Herring <robh@kernel.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kbuild <linux-kbuild@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, Mar 4, 2022 at 2:57 PM Rob Herring <robh@kernel.org> wrote:
> On Fri, Mar 04, 2022 at 10:32:29AM +0100, Geert Uytterhoeven wrote:
> > On Thu, Mar 3, 2022 at 11:43 PM Rob Herring <robh@kernel.org> wrote:
> > > In preparation for supporting validation of DTB files, the full
> > > processed schema will always be needed in order to extract type
> > > information from it. Therefore, the processed schema containing only
> > > what DT_SCHEMA_FILES specifies won't work. Instead, dt-validate has
> > > gained an option, -l or --limit, to specify which schema(s) to use for
> > > validation.
> > >
> > > As the command line option is new, we the minimum dtschema version must be
> > > updated.
> > >
> > > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> >
> > Thanks for your patch!
> >
> > > --- a/Documentation/devicetree/bindings/Makefile
> > > +++ b/Documentation/devicetree/bindings/Makefile
> > > @@ -6,7 +6,7 @@ DT_MK_SCHEMA ?= dt-mk-schema
> > >  DT_SCHEMA_LINT := $(shell which yamllint || \
> > >    echo "warning: yamllint not installed, skipping. To install, run 'pip install yamllint'" >&2)
> > >
> > > -DT_SCHEMA_MIN_VERSION = 2021.2.1
> > > +DT_SCHEMA_MIN_VERSION = 2022.3
> >
> > This doesn't work as-is, as that version hasn't been tagged yet ;-)
>
> I had to make sure people are paying attention. You win the prize. :)
>
> It's there now.

Thanks, confirmed.

With this series applied, the various salvator-xs DTS files are now
throwing up:

    sata: size (19) error for type phandle
    backlight: size (11) error for type phandle

I tried to find out what caused that, but couldn't find it.
Do you have a clue?
Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
