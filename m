Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA38252DBD0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 19:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243358AbiESRuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 13:50:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242496AbiESRti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 13:49:38 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938DAAF303;
        Thu, 19 May 2022 10:49:00 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id j3so5158838qvn.0;
        Thu, 19 May 2022 10:49:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ypz7+YxgISOOflvYtmwnpKygymqNnA7Map87dQNKlcs=;
        b=2PENtJvcVjDtbysgbjoIPodk1YP5YvyIInfhwrV6XBobmsM/GXlt7hmw2mAAyWnPZw
         n/8IwhWbtsxYEBEaYcbwjMTBnFbqI5M5Fy1RtiSX8x8YE3QvBPv10V7630pepan8JOcK
         GXFrmFtdXGicyQYaSTF712C+eRVaq2irb0dkKGeLk/VtyUHW7eJDFDIxIMpRLUC+prAp
         eyOUWY9L2oheoDah65Uc/slL/iCNshanCUZoS01f6OjGTALY5jTfpVMVtse6rbkbc/6R
         kjb+GRY0EH528s3rLxz20JfWs9jpbrEh+M6ZVsB0HBgmhGh0AVzilaOrunZI1og8gBiC
         l/xQ==
X-Gm-Message-State: AOAM532U5nSCR4uq379vt3n1kO2iQtfp/E2oqC6WuGe7cXJfUvrIAPtu
        yHIsm4aMmVPKSTPcdVO1eSxCYEnP9sBOsg==
X-Google-Smtp-Source: ABdhPJw5tyo+TSVr8lt/1CZ1cJBraalNy3xt8peVxfJUpEdgSgWClwdBxmOpiVoknVbmEvN0vxf2kA==
X-Received: by 2002:a05:6214:5298:b0:461:c745:3b87 with SMTP id kj24-20020a056214529800b00461c7453b87mr5154812qvb.61.1652982539242;
        Thu, 19 May 2022 10:48:59 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id l63-20020a37a242000000b0069fc13ce21bsm1628795qke.76.2022.05.19.10.48.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 10:48:58 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id t26so10309046ybt.3;
        Thu, 19 May 2022 10:48:58 -0700 (PDT)
X-Received: by 2002:a25:4289:0:b0:64d:746f:5311 with SMTP id
 p131-20020a254289000000b0064d746f5311mr5263711yba.89.1652982538414; Thu, 19
 May 2022 10:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <YoUBh5BSsURDO71Z@chrisdown.name> <CAMuHMdU2tUU6FAM-nK9oxd0GwcO3WwvZp9Um4=w5By+N0P0kXA@mail.gmail.com>
 <YoZWFi0AtmA9fvv/@chrisdown.name>
In-Reply-To: <YoZWFi0AtmA9fvv/@chrisdown.name>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 19 May 2022 19:48:46 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU5=XW28XBdEx9ofrrysUCqqtoaS7=0U8Mr7TF3XdntWw@mail.gmail.com>
Message-ID: <CAMuHMdU5=XW28XBdEx9ofrrysUCqqtoaS7=0U8Mr7TF3XdntWw@mail.gmail.com>
Subject: Re: [RFC PATCH] printk: console: Allow each console to have its own loglevel
To:     Chris Down <chris@chrisdown.name>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kernel Team <kernel-team@fb.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>
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

Hi Chris,

CC DT

On Thu, May 19, 2022 at 4:37 PM Chris Down <chris@chrisdown.name> wrote:
> Geert Uytterhoeven writes:
> >All of the above options are appropriate for "classic" systems,
> >where the console device is selected using the "console=" option.
> >
> >On systems using Device tree, the serial console device is selected
> >using the "chosen/stout-path" property in DT, and the graphical
> >console is usually auto-detected and auto-enabled through DRM.
> >Do you envision a way to specify a specific console loglevel on the
> >kernel command line on such systems?
>
> Interesting question! I hadn't really thought about device tree. I actually
> have very little understanding of how it works to be honest :-)
>
> I'm happy to add loglevel support to device tree, I assume I'd add another
> property under the chosen node, like chosen/stdout-loglevel.

Please do not add a new property there.
IMHO, the loglevel should be specified on the kernel command line,
and not be fixed using a DT property.

Typically, boot loaders (e.g. U-Boot) replace the command line
specified in chosen/stdout-path in DT by something retrieved from
the boot environment (e.g. user-specifief bootargs in NVMEM).

> I have some questions, though:
>
> 1. It looks like DT is standardised. Do I need to get standards approval first?
> 2. Is there documentation on how to reliably test DT changes?

The DT specification can be found at
https://www.devicetree.org/specifications/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
