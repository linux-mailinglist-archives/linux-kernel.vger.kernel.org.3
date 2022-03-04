Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E8A4CD6C0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 15:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239960AbiCDOuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 09:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236106AbiCDOuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 09:50:21 -0500
Received: from mail-vs1-f41.google.com (mail-vs1-f41.google.com [209.85.217.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8279811C7D5;
        Fri,  4 Mar 2022 06:49:33 -0800 (PST)
Received: by mail-vs1-f41.google.com with SMTP id v128so4489228vsb.8;
        Fri, 04 Mar 2022 06:49:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nuEFnp8xzEBzIGWOOUSQ4sQ7i7Pz5qWLvQbZ+armpO8=;
        b=haviDSvEToHq+oI3Eetl1AL8ntiKnRLaPepSe2D0WX0n/ek3B3Ft9ZxndVPIEGGdX0
         bDhR2B42OeGWM+VOKM7tvp3MerIadSlW9Hm2O5vWHlIKCTDxrDrhi8kSVDo67rNm4iyh
         WlZT0ZzfF2WJzKQXScTFatzDiEUgXfYCIHKCANI/BAjRMlPL4qB59FV8jzjzpSQoHlEA
         olJ0zCSrjpCN/AnWY/0A+5nSmoSD11E7fry8ujpEDB6hx5Tb7nWBHb650OJnWwdn+6y/
         cqQpAJwNXDSIpVsbCkdK7P4H3fNcIucGwLM4l1RHZ2nC7MoZJ7DtLze2xyKnd8ahdjzG
         m0Kg==
X-Gm-Message-State: AOAM531xlTxr8vNTTEvwzd95+6+V3qWBVYPkNJGtPYR8AXUxgZrBmqru
        QWQ2DaDAyNRYyk/XFo1+FoIM6QoWnzyAgg==
X-Google-Smtp-Source: ABdhPJzQvQioj32KgApOeaq1GlS9nfh/kkwneIiPdzoaZ2YZL+LNGFqOY0L+Ro5yw3li6PUm869NOA==
X-Received: by 2002:a05:6102:3543:b0:31e:248d:2f97 with SMTP id e3-20020a056102354300b0031e248d2f97mr17230595vss.76.1646405372547;
        Fri, 04 Mar 2022 06:49:32 -0800 (PST)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id q65-20020a1fa744000000b0032db512ac39sm739891vke.46.2022.03.04.06.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 06:49:32 -0800 (PST)
Received: by mail-vs1-f46.google.com with SMTP id q9so9305779vsg.2;
        Fri, 04 Mar 2022 06:49:32 -0800 (PST)
X-Received: by 2002:a05:6102:2922:b0:31e:bd90:f1c3 with SMTP id
 cz34-20020a056102292200b0031ebd90f1c3mr7166946vsb.77.1646405371982; Fri, 04
 Mar 2022 06:49:31 -0800 (PST)
MIME-Version: 1.0
References: <20220303224237.2497570-1-robh@kernel.org> <20220303224237.2497570-2-robh@kernel.org>
 <CAMuHMdU6g7c9YX0mBAGWbCWgA8exkUSfqn8ZGi_2N+Nz1WT+BA@mail.gmail.com>
 <YiIa3Ox7UBLyBtoR@robh.at.kernel.org> <CAMuHMdU9yzpLh+S821osed5nuHfc0rONB+i4sPjXsGuKLumgfQ@mail.gmail.com>
 <YiIio1dJd5mvMr0v@robh.at.kernel.org>
In-Reply-To: <YiIio1dJd5mvMr0v@robh.at.kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 4 Mar 2022 15:49:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXBkLbQVcNYhd=7z0RtU0CicsTF2BQLFRGBX6pNZZVadA@mail.gmail.com>
Message-ID: <CAMuHMdXBkLbQVcNYhd=7z0RtU0CicsTF2BQLFRGBX6pNZZVadA@mail.gmail.com>
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

On Fri, Mar 4, 2022 at 3:31 PM Rob Herring <robh@kernel.org> wrote:
> On Fri, Mar 04, 2022 at 03:05:13PM +0100, Geert Uytterhoeven wrote:
> > On Fri, Mar 4, 2022 at 2:57 PM Rob Herring <robh@kernel.org> wrote:
> > > On Fri, Mar 04, 2022 at 10:32:29AM +0100, Geert Uytterhoeven wrote:
> > > > On Thu, Mar 3, 2022 at 11:43 PM Rob Herring <robh@kernel.org> wrote:
> > > > > In preparation for supporting validation of DTB files, the full
> > > > > processed schema will always be needed in order to extract type
> > > > > information from it. Therefore, the processed schema containing only
> > > > > what DT_SCHEMA_FILES specifies won't work. Instead, dt-validate has
> > > > > gained an option, -l or --limit, to specify which schema(s) to use for
> > > > > validation.
> > > > >
> > > > > As the command line option is new, we the minimum dtschema version must be
> > > > > updated.
> > > > >
> > > > > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > > > > Signed-off-by: Rob Herring <robh@kernel.org>

> > With this series applied, the various salvator-xs DTS files are now
> > throwing up:
> >
> >     sata: size (19) error for type phandle
> >     backlight: size (11) error for type phandle
>
> Those come from the code decoding the properties[1]. Unfortunately, I
> haven't come up with a prettier way to report those with the filename. I
> may just remove it because if decoding the property fails, we'll get
> schema errors later on anyways.
>
> But I don't see any 'sata' properties in the DTS files and 'backlight'
> is a node. Are you building with '-@'? I probably need to skip
> __symbols__ nodes. The overlay side is handled because examples are
> built as overlays (to allow unresolved phandles).

Yes I am. Dropping the "-@" fixes the issue.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
