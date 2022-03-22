Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA774E46DF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 20:44:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbiCVTqL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 15:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231824AbiCVTqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 15:46:06 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4553D12617
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 12:44:37 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id v75so20613256oie.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 12:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=CAzB2bxWOL1HZEUAkxbUyi+0BLpsE35+TdYIg2Gczsk=;
        b=LHh2V3u23YaTHVt7ryJ00QpQj2lolnfFeBCDwmVG+Yzvjjm3IUpNCXVFU0LqnQ63fc
         vRvdkp8BAeEO4KbsPzzrmG1Jo1TwVcSxbI6G2mbH1qkwW8Tmlh/CepuHDWVqFag8m/t4
         NLRK/xriGvkEwu0bqDWz1HRzvGHgv/D6dcVQs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=CAzB2bxWOL1HZEUAkxbUyi+0BLpsE35+TdYIg2Gczsk=;
        b=3hR2KsRSRd6pYprGoEKrohfOo3ToF316of6MaodyJysP6BiNNLAllj8NLRXpnMQPrt
         6EgYogWNc0rcgNLWfICM0qvsCIBwiBFmEizql+AY1WR2cK7DTelBiDMJ+mUuJCc0utDJ
         zeDqklHh1/zz45+B/TAkqNU1gJndlTfgRhVZELzC3Ka/wAyDHQiZcrStWZ5db4WrZ36L
         dNu1SHYCOD91yOsnwS730edoLk+1EkA1a653PuqUFRDBu8ruCC9NXpVAyyWyyBTFGtLy
         P9jxSqoTgIA/ClPfV1r+lP0fuYHr8knBqZCDD58cfM75CNjukPKWZv5VJV+U78ob6tmS
         RQqQ==
X-Gm-Message-State: AOAM5318k+gFJpR47l4EhoImRydNfe92kcgpmHpogpRdj4AAy7ghNCc6
        4VfIHlpEk2MB/rZQsg/4vmcY9rLfw9XrrJtTG4OaWg==
X-Google-Smtp-Source: ABdhPJx648kRoeFIg6qr1MoqlzkLUrFEo36LwaPxWmkijK9tGCkGuyzZbaWIpDuSFZ252ApxbfxaUNN3/mLT4KNpQeg=
X-Received: by 2002:aca:bd41:0:b0:2ec:ff42:814f with SMTP id
 n62-20020acabd41000000b002ecff42814fmr3002721oif.63.1647978276526; Tue, 22
 Mar 2022 12:44:36 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 22 Mar 2022 20:44:35 +0100
MIME-Version: 1.0
In-Reply-To: <1647934315-5189-1-git-send-email-quic_vnivarth@quicinc.com>
References: <1647934315-5189-1-git-send-email-quic_vnivarth@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Tue, 22 Mar 2022 20:44:35 +0100
Message-ID: <CAE-0n53x2ayF3c9bf7qDm-HEHb9TVivFtrgN9XukAR1L=UP1+A@mail.gmail.com>
Subject: Re: [PATCH] drivers/tty/serial/qcom-geni-serial: Remove uart
 frequency table. Instead, find suitable frequency with call to clk_round_rate.
To:     Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Cc:     quic_msavaliy@quicinc.com, quic_dkammath@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vijaya Krishna Nivarthi (2022-03-22 00:31:55)
> [Why]
> This change is part of resolving feedback for an earlier
> patch. The UART frequency table is to be replaced with a

The first sentence is useless. Just say what you're doing and why you're
doing it.

Replace the UART frequency table 'root_freq[]' with logic around
clk_round_rate() so that SoC details like the available clk frequencies
can change and this driver still works. This reduces tight coupling
between this UART driver and the SoC clk driver because we no longer
have to update the 'root_freq[]' array for new SoCs. Instead the driver
determines the available frequencies at runtime.

> call to clk_round_rate so it would work regardless of
> what the clk driver supports for the particular SoC.
>
> [How]
> Try to find a frequency and divider that exactly matches
> the required rate. If not found, return the closest
> possible frequency and set divider to 1.
>
> Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
> ---
>  drivers/tty/serial/qcom_geni_serial.c | 57 ++++++++++++++++++++---------------
>  1 file changed, 33 insertions(+), 24 deletions(-)
>
> diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
> index aedc388..5226673 100644
> --- a/drivers/tty/serial/qcom_geni_serial.c
> +++ b/drivers/tty/serial/qcom_geni_serial.c
> @@ -149,12 +149,6 @@ static unsigned int qcom_geni_serial_tx_empty(struct uart_port *port);
>  static void qcom_geni_serial_stop_rx(struct uart_port *uport);
>  static void qcom_geni_serial_handle_rx(struct uart_port *uport, bool drop);
>
> -static const unsigned long root_freq[] = {7372800, 14745600, 19200000, 29491200,
> -                                       32000000, 48000000, 51200000, 64000000,
> -                                       80000000, 96000000, 100000000,
> -                                       102400000, 112000000, 120000000,
> -                                       128000000};
> -
>  #define to_dev_port(ptr, member) \
>                 container_of(ptr, struct qcom_geni_serial_port, member)
>
> @@ -946,32 +940,46 @@ static int qcom_geni_serial_startup(struct uart_port *uport)
>         return 0;
>  }
>
> -static unsigned long get_clk_cfg(unsigned long clk_freq)
> -{
> -       int i;
> -
> -       for (i = 0; i < ARRAY_SIZE(root_freq); i++) {
> -               if (!(root_freq[i] % clk_freq))
> -                       return root_freq[i];
> -       }
> -       return 0;
> -}
> -
> -static unsigned long get_clk_div_rate(unsigned int baud,
> +static unsigned long get_clk_div_rate(struct clk *clk, unsigned int baud,
>                         unsigned int sampling_rate, unsigned int *clk_div)
>  {
>         unsigned long ser_clk;
>         unsigned long desired_clk;
> +       unsigned long freq, prev, freq_first;
> +
> +       if (!clk) {

Please remove this nonsense check. When is clk going to be NULL?

> +               pr_err("%s: Invalid clock handle\n", __func__);
> +               return 0;
> +       }
>
>         desired_clk = baud * sampling_rate;
> -       ser_clk = get_clk_cfg(desired_clk);
> -       if (!ser_clk) {
> -               pr_err("%s: Can't find matching DFS entry for baud %d\n",
> -                                                               __func__, baud);
> -               return ser_clk;
> +       if (!desired_clk) {
> +               pr_err("%s: Invalid frequency\n", __func__);
> +               return 0;
>         }
>
> +       freq_first = 0;
> +       prev = desired_clk;
> +       freq = desired_clk - 1;
> +       do {
> +               if (freq != (desired_clk - 1))

Does this ever happen after the first loop? Why not assign prev to freq
before entering?

> +                       prev = freq;
> +
> +               freq = clk_round_rate(clk, (freq + 1));

Remove useless parenthesis.

> +
> +               if (!freq_first)
> +                       freq_first = freq;
> +       } while ((freq % desired_clk) && (freq > 0) && (freq != prev));

Remove useless parenthesis.
	
In general, take a look at clk_divider_bestdiv() for how to handle this.
This device only has so many possible divider values so it's better to
loop through clk_round_rate() taking into account the possible divider
values instead of adding 1 to the frequency returned from
clk_round_rate(). According to the defines

#define CLK_DIV_MSK                     GENMASK(15, 4)
#define CLK_DIV_SHFT                    4

it has 4095 divider values (I guess a divider of 0 is the same as
divider of 1?). We should be able to multiply the desired rate by the
divider and see if it matches the frequency of the 'ser_clk'. If it
doesn't we can calculate the actual frequency that we can achieve and
then do our own rounding here to figure out if it is acceptable. I guess
it needs to be exactly divisible, so if the clk_round_rate() doesn't
come back with the same frequency we wanted we keep trying bigger
numbers with bigger dividers. The important thing is that we don't
exceed the possible divider values by returning from this function
with an invalid divider.

I was thinking it may be easier to implement this divider as a clk in
the clk tree but that looks complicated. Largely that's because the
'ser_clk' is set with dev_pm_opp_set_rate() and that would be the parent
of this new divider clk. If OPP core could figure out that the parent
clk is changing and that's the one with the voltage requirements it
would work to call dev_pm_opp_set_rate() on the new divider clk (maybe
call it baud_clk). This logic doesn't exist today though so implementing
it here in this driver is OK with me for now.

> +
> +       if (!(freq % desired_clk))

Flip these conditions to remove one more set of parenthesis.

> +               ser_clk = freq;
> +       else
> +               ser_clk = freq_first;
> +
>         *clk_div = ser_clk / desired_clk;
> +       if ((ser_clk) && (!(*clk_div)))

Remove useless parenthesis.

> +               *clk_div = 1;
> +
>         return ser_clk;
>  }
>
> @@ -1003,7 +1011,8 @@ static void qcom_geni_serial_set_termios(struct uart_port *uport,
>         if (ver >= QUP_SE_VERSION_2_5)
>                 sampling_rate /= 2;
>
> -       clk_rate = get_clk_div_rate(baud, sampling_rate, &clk_div);
> +       clk_rate = get_clk_div_rate((port->se).clk, baud,

Remove useless parenthesis.

> +               sampling_rate, &clk_div);
>         if (!clk_rate)
>                 goto out_restart_rx;
