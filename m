Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE1C0504FCB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 14:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238063AbiDRMRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 08:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbiDRMRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 08:17:03 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DB61A82E;
        Mon, 18 Apr 2022 05:14:22 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id c64so17219105edf.11;
        Mon, 18 Apr 2022 05:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9Yi3JLK4e1JeX9Duse43qaRJcbvheP09jxiZrAgIDBU=;
        b=DxLelIcLuvrBmf7L8udOP+AY3bWeeIv36zEOdsZuLI+OadRQs5Tj2cNMLfYjQabwPA
         YL240QfjEFUTl4D1PGG3Nt7vYLxEZlrvgSl1R3KUVvXsOLzXLweH+1gjr9fPAHAbWV6p
         X6QPcD5V0fGP1kEuqp8b2pnI4LKKRkTLOjfANG55K0CA33htMblD8hAyzXSxoepuRoWp
         Oizl9sDGNVU/myD7YD9Ks5QeYeZtiQGQOPMjYDWHHhnA9BfumJMsob+KvM3mVq2VSnER
         t3QbDq3FMzEQThxSnZKojKFHBo/DrQuRe9lW0xkHoz+xpkuHdI589Vh/HuRxEYdGk6bf
         BPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9Yi3JLK4e1JeX9Duse43qaRJcbvheP09jxiZrAgIDBU=;
        b=e8X4Us+/Za9OxNlTw5zadBWh81gmC5p7Jke3wLxJ5IVJrdgNSNLk2cjxnkXGQMH4Gt
         lIKikSumIWXsQJJX279p3ViUBImQ7Nx6pkM5nW54G/XJWw6qTKVnvYHCgt21W7F8Mlca
         SiZlAEvAegqP15Lb915Re+oOAd5Oj/fOd2ug2dHb7Tg6mC7btqYETuTrnb7hguQTwBRf
         /0qloluy4GGkUN0Q67nSmxE+fvtVApMa9BNNHVIVFXM5Upvr7fKZX97tt6RVzHkPyjHP
         1sIMF/lAvWjNc51NMBiKrnfIc5qe3HKpwWIMoMH32wS6pBaSpzti8/825tTcG2yq/tm3
         xEbw==
X-Gm-Message-State: AOAM5303xGnRvCzqvZjF5qapTaY4swEOq++sVaQb0ETUTSL2uG97JXCT
        rcyIEHoa9hTJC10QjbSs2ywla93almM5fUmhBrMj/GHfqJ9kzw==
X-Google-Smtp-Source: ABdhPJw9OLFzWqDY5GO1qkj761DGYpTL/KDZbxcg1DmwEBkgenFKvVhRHy5LQTjCOPt3MrdJ9RmgO06nOEDblpXd9HE=
X-Received: by 2002:a50:e696:0:b0:419:998d:5feb with SMTP id
 z22-20020a50e696000000b00419998d5febmr12073094edm.122.1650284060716; Mon, 18
 Apr 2022 05:14:20 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.DEB.2.21.2204161848030.9383@angie.orcam.me.uk> <alpine.DEB.2.21.2204162123320.9383@angie.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.21.2204162123320.9383@angie.orcam.me.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 18 Apr 2022 15:13:44 +0300
Message-ID: <CAHp75VdTzd56DzWsjf9GW3zfCtYh4ej3U6KTS7j3aXSVkWOOig@mail.gmail.com>
Subject: Re: [PATCH v4 1/5] serial: 8250: Correct the clock for EndRun
 PTP/1588 PCIe device
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
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

On Mon, Apr 18, 2022 at 2:02 AM Maciej W. Rozycki <macro@orcam.me.uk> wrote:
>
> The EndRun PTP/1588 dual serial port device is based on the Oxford
> Semiconductor OXPCIe952 UART device with the PCI vendor:device ID set
> for EndRun Technologies and is therefore driven by a fixed 62.5MHz clock
> input derived from the 100MHz PCI Express clock.  The clock rate is
> divided by the oversampling rate of 16 as it is supplied to the baud
> rate generator, yielding the baud base of 3906250.
>
> Replace the incorrect baud base of 4000000 with the right value of
> 3906250 then, complementing commit 6cbe45d8ac93 ("serial: 8250: Correct
> the clock for OxSemi PCIe devices").

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
> Fixes: 1bc8cde46a159 ("8250_pci: Added driver for Endrun Technologies PTP PCIe card.")
> ---
> New change in v4, factored out from 2/5.
> ---
>  drivers/tty/serial/8250/8250_pci.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> linux-serial-8250-endrun-pcie-clock.diff
> Index: linux-macro/drivers/tty/serial/8250/8250_pci.c
> ===================================================================
> --- linux-macro.orig/drivers/tty/serial/8250/8250_pci.c
> +++ linux-macro/drivers/tty/serial/8250/8250_pci.c
> @@ -2667,7 +2667,7 @@ enum pci_board_num_t {
>         pbn_panacom2,
>         pbn_panacom4,
>         pbn_plx_romulus,
> -       pbn_endrun_2_4000000,
> +       pbn_endrun_2_3906250,
>         pbn_oxsemi,
>         pbn_oxsemi_1_3906250,
>         pbn_oxsemi_2_3906250,
> @@ -3195,10 +3195,10 @@ static struct pciserial_board pci_boards
>         * signal now many ports are available
>         * 2 port 952 Uart support
>         */
> -       [pbn_endrun_2_4000000] = {
> +       [pbn_endrun_2_3906250] = {
>                 .flags          = FL_BASE0,
>                 .num_ports      = 2,
> -               .base_baud      = 4000000,
> +               .base_baud      = 3906250,
>                 .uart_offset    = 0x200,
>                 .first_offset   = 0x1000,
>         },
> @@ -4128,7 +4128,7 @@ static const struct pci_device_id serial
>         */
>         {       PCI_VENDOR_ID_ENDRUN, PCI_DEVICE_ID_ENDRUN_1588,
>                 PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> -               pbn_endrun_2_4000000 },
> +               pbn_endrun_2_3906250 },
>         /*
>          * Quatech cards. These actually have configurable clocks but for
>          * now we just use the default.



-- 
With Best Regards,
Andy Shevchenko
