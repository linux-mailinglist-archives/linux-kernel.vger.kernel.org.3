Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4255355E418
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345943AbiF1NMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345971AbiF1NMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:12:03 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49DF2BB1E;
        Tue, 28 Jun 2022 06:12:02 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id i15so22210032ybp.1;
        Tue, 28 Jun 2022 06:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4Dndi5h/zWqB6In2E0grpesiVdBXsHnaC/f8f16Jrk8=;
        b=pP8lsUxHbgrgAxUUSLLKxPjGo8ZmNEVDLuBB43wdxKDAHV010b0MC5nauihZkvEcJl
         Npn/VLm5YbA40u5T8EcufMt4J8qquis0LfnAklKKfwACXDlJauu4yfvCYs2JOmA/eBos
         AqJbHqJDYAvp4Xu36q7Q/t9ykyiwhrpoviNJ0+KbNpxVGHercIeTMHFC9hrWNemV6imY
         g3azcaJb8+cUgddg4kHfXjhKDgTGYJFzNIZJz3KiTfB1N4PgumTnr5TuOAz6IH9ghQaK
         ioRz48YYdbaXLtIeJEekYqO2o5s+5TV3QOCH1tu1pdF20sJi9u0KOuTzVQRn28rW/zPW
         7PkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4Dndi5h/zWqB6In2E0grpesiVdBXsHnaC/f8f16Jrk8=;
        b=6DKdpQJSAPmW0QY+SmZZpkb5D3Z/y9yTElJQJIDVJvJAGF1EXzXPYI6YIAK4lTvWxy
         OnG3PZ/X6kuCRyUyTwT0S2UBUliUaS5Gwa07b17NVbZCI0c/uVWnHGUmJMNqshmnwJIf
         uSlFrgG5nsx9yRclohQtYR2l/rejRT7yN3JvhbHe4uwN4AWS+JKsqZ7rWmPw3yFJuCPD
         Nw6XxEVpRvafgbhmZRdw3nROEfhm9eAeKoQIGQFzqcdAo7Uu270b2rKmWVXqdiOPQF4U
         yQ5fIs2eoVxkN6HsKxRYeEeyjV5g7QnRl5DpRrl3iZheg1gWlyWZUV8Xnm000oTCW0F7
         Ng4w==
X-Gm-Message-State: AJIora/MlU7Qg9iKzkNgk7skYnGi51miPiWeK+Yo+3tz1mHKV7fCtL1U
        KehVaHfTeW0F6XUaRgU0fAzRQQdMP1o+SjICebs=
X-Google-Smtp-Source: AGRyM1tReBe8TC8uOF3q2i6TSGVt2gqO98DI6ICLmgqUC+jSgdck/O9+QfJwIOSBs8oSjGIr89SfICFqQ9pg94ZgSQM=
X-Received: by 2002:a25:187:0:b0:66c:eaea:71ec with SMTP id
 129-20020a250187000000b0066ceaea71ecmr8995133ybb.570.1656421921710; Tue, 28
 Jun 2022 06:12:01 -0700 (PDT)
MIME-Version: 1.0
References: <4e1d5db9dea68d82c94336a1d6aac404@walle.cc> <Yrrhs3D++V79/4Jk@smile.fi.intel.com>
 <f17d3ecfecf4491dd15b1fa092205f3f@walle.cc>
In-Reply-To: <f17d3ecfecf4491dd15b1fa092205f3f@walle.cc>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 28 Jun 2022 15:11:24 +0200
Message-ID: <CAHp75Vd6e3WwHPfyL=GP=vsoWhwGXadwQziiRRwfHPfjkX2eFg@mail.gmail.com>
Subject: Re: fwnode_for_each_child_node() and OF backend discrepancy
To:     Michael Walle <michael@walle.cc>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Jun 28, 2022 at 1:54 PM Michael Walle <michael@walle.cc> wrote:
>
> Am 2022-06-28 13:10, schrieb Andy Shevchenko:
> > On Mon, Jun 27, 2022 at 02:49:51PM +0200, Michael Walle wrote:
> >> Hi,
> >>
> >> I tired to iterate over all child nodes, regardless if they are
> >> available
> >> or not. Now there is that handy fwnode_for_each_child_node() (and the
> >> fwnode_for_each_available_child_node()). The only thing is the OF
> >> backend
> >> already skips disabled nodes [1], making fwnode_for_each_child_node()
> >> and
> >> fwnode_for_each_available_child_node() behave the same with the OF
> >> backend.
> >>
> >> Doesn't seem to be noticed by anyone for now. I'm not sure how to fix
> >> that
> >> one. fwnode_for_each_child_node() and also
> >> fwnode_get_next_child_node() are
> >> used by a handful of drivers. I've looked at some, but couldn't decide
> >> whether they really want to iterate over all child nodes or just the
> >> enabled
> >> ones.
> >>
> >> Any thoughts?
> >
> > It was discussed at least twice this year (in regard to some new IIO
> > drivers)
> > and Rob told that iterating over disabled (not available) nodes in OF
> > kinda
> > legacy/design mistake. That's why device_for_each_child_node() goes
> > only
> > over available nodes only.
>
> Mh, but then the fwnode_for_each_child_node() is very misleading, esp.
> with the presence of fwnode_for_each_available_child_node().
>
> > So, why do you need to iterate over disabled ones?
>
> I was trying to fix the lan966x driver [1] which doesn't work if there
> are disabled nodes in between.

Can you elaborate what's wrong now in the behaviour of the driver? In
the code it uses twice the _available variant.

> My steps would have been:
>   (1) change fwnode_for_each_available_child_node() to
>       fwnode_for_each_child_node(), maybe with a fixes tag, as it's
>       easy to backport
>   (2) introduce new compatibles and deduce the number of ports
>       according to the compatible string and not by counting
>       the child nodes.
>   (3) keep the old behavior for the legacy compatible and mark it
>       as deprecated in the binding
>   (4) move the device tree over to the new compatible string

> [1]
> https://elixir.bootlin.com/linux/v5.19-rc4/source/drivers/net/ethernet/microchip/lan966x/lan966x_main.c


-- 
With Best Regards,
Andy Shevchenko
