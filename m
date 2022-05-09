Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B44520411
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 20:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239948AbiEISEN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 14:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239891AbiEISEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 14:04:07 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E35923109D;
        Mon,  9 May 2022 11:00:11 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id p18so17202892edr.7;
        Mon, 09 May 2022 11:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xRBXx928dagw+3e9EPYrB5itePsWk8eOmqf8pq2vamA=;
        b=RNexsFbRx1gQtdbWYE5hw4OJCI3HtPhqPUD5BUFamEViXuYg5ZmePtst0py1FQddKo
         JChc+QzblTpxWVJOpOS38IPJ1kKZc2Uf8lJuvh2Wvk8tsJVPJSIijstdRvFLjm30B8kN
         JRYRTWHjrXWXjVAK3Y6PmVuZcLB1+XuJntTCdHMqPNJ9eW5HKmz74TmtfA2mEDM/be7d
         vdBDKUE1bAH2yugKRz6iNCqdlTc/J/DkabnHJ+S9DczdhEVf5VeIbG9zwIa/HCeyECz3
         xUeTSVWL29mSNK6Y5Yw4h/SLWYRJrxxOy7FMZN9cDEEtRCNG2ft4/nfx5fHqdgyzlorW
         oDag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xRBXx928dagw+3e9EPYrB5itePsWk8eOmqf8pq2vamA=;
        b=L2s0/sotDe/Zus3qc24u1FpHd9Quk+HsrnZMEes7NetUoWXj0q3wqpPTavNbQpmuDV
         FS7mqP1GLBRZlAPWSFIToZPpUqzt20B6PW6XIb9HJQBMcmIqSbGyFiCuFnUaI2VJryuV
         wxlkbhu7QpYTiBlwQKSEjagB2eO0D2jl2TlIQpuHTf0x9TtzNQ5g/M/XCA0aN0FrB1lm
         EA2A8u+/wGcHsVzr7dL8XMmMWmOIJHIaeD63zuQjpj3MZLoL0RBU1htVthBALkS6wf/v
         9mew/7H86AjX9vDw/eTptjP3rOayp8ZplKngwQ1+d/Q8PRf9frT82AzN47EiqYUegeiX
         wHeA==
X-Gm-Message-State: AOAM533pRa1LkYlChnW8bLCTBXwkhRIexKejzpzVzxgSrP3UW5P+Iph/
        a3FQTGyRqvPc9tJZzl68Q1/9KjkS5FZ+1PwDWj4yYRNYDZN4ckJfkso=
X-Google-Smtp-Source: ABdhPJwTVcHGdp+naHV+dUtWIr1b/VP6pyxUqV4WzQ+FWdmKeMBYD9rAUysZKVyHEV9Cb99QhXlNT+9auh6Atk7H9k0=
X-Received: by 2002:aa7:d350:0:b0:425:e029:da56 with SMTP id
 m16-20020aa7d350000000b00425e029da56mr18665027edr.296.1652119209687; Mon, 09
 May 2022 11:00:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220509172129.37770-1-andriy.shevchenko@linux.intel.com> <d76c13b2-16a0-d53f-0cc9-562fa96f373d@wanadoo.fr>
In-Reply-To: <d76c13b2-16a0-d53f-0cc9-562fa96f373d@wanadoo.fr>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 9 May 2022 19:59:33 +0200
Message-ID: <CAHp75Vca60m+mkPDzh022B4pU2sng8-ZLoEK0POLQON3EWjBKg@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] serial: 8250_dw: Use devm_add_action_or_reset()
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 9, 2022 at 7:49 PM Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
> Le 09/05/2022 =C3=A0 19:21, Andy Shevchenko a =C3=A9crit :

...

> > +static void dw8250_clk_disable_unprepare(void *data)
> > +{
> > +     clk_disable_unprepare(data);
> > +}

> we already have several time this function in different drivers.
> Maybe, it would be nice to have something standart for it.
>
> A devm_clk_prepare_enable() or something devm-helpers.h ([1])

Seems you missed the full story. We tried to add that several times
[1] and CCF maintainers refused all the time. You may work with them
to convince them.

[1]: https://lore.kernel.org/linux-clk/20210304221247.488173-2-linux@rasmus=
villemoes.dk/
(the latest one AFAIK)

--=20
With Best Regards,
Andy Shevchenko
