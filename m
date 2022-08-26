Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619E55A2BC9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344667AbiHZP5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237300AbiHZP5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:57:06 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94C3D0759;
        Fri, 26 Aug 2022 08:57:03 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id n14so1362224qvq.10;
        Fri, 26 Aug 2022 08:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=qBPPfnbpmPdM2QlLk+XM/BmeuhyavLK4nk3zz2G6eCg=;
        b=CPiZTaQckYJmCF3Q8lHsgnadiiRUmfxnEosw9kbKq+Tx54CgTIWc07+Je8TKtqoLYF
         Ut9NVZUS+L8ODkeF+6U1FQ25NeZsKLXxkwWchf/CGSy6/MNn2RcPTRAmrWDyw+zajf7C
         kLbo0s3aUU27qTkUuWyKTQbool5HIt4pI5xwpXNuTIacAH3gTjouw5i50PiaIkauIq3Q
         0uHhzUncrQQ1CViqPEcGHtwV5OxkEnO8v/AjNEedQTawJlvnfI/9UCBMaLV+K8Ub4XrA
         641IWD+XkJECh5gW/3stcHyDeQLkssuJcIQjSraeUjd9UHm88vQ9TT8qe2Hpt+kemift
         Azeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=qBPPfnbpmPdM2QlLk+XM/BmeuhyavLK4nk3zz2G6eCg=;
        b=nyLelDtl2pZjKRxO9i50ko1PUVolgxNfVGmL/MKxWO1tUcHLmlPPWYuNu7x3PsYIKu
         sQVJYXf/ShVqNOOyIREPEvOCMRvyat3KW7hW1aaHt3SjQAOQWUo2AgvnZgTSEQuZPGMo
         PhBz1HNwOp6RsEsOKR1vM8VV6Nl2aCj63OAf0ET3Jyy6/Kq/+Op6rl0cwJpvvso2vQe3
         Or2GdPos8qJArN+ROIt4KFNY14RYC9puPzU2XEBNKXB6UNL/+lr6SfTCEXhc+pHJFoEo
         LZT95sjMMQEifYLBAY9Lf93E8oY2G8hjeoR0vSPD3QLQDcoUaGGl+BR49xOqcK0BlPwY
         wJQg==
X-Gm-Message-State: ACgBeo2K6Y6ciQmnD6Tu8JDcT36tbw5YlRvaK2LPNRM+YMSc2/evbWKz
        ieSTa8+9VbRClbVQGV1evO5zfdmVvJh5p/fhPNNPqAcW/3Q=
X-Google-Smtp-Source: AA6agR5Vp1Pv2yu0EIDrk3tas0uO1hDuhEbwaDRIm0oDiIfrNATaSz2jloXX+R957k6neYAGicI7YNRkhMw1dWTz7rQ=
X-Received: by 2002:a05:6214:c22:b0:497:10a8:3067 with SMTP id
 a2-20020a0562140c2200b0049710a83067mr267440qvd.48.1661529423003; Fri, 26 Aug
 2022 08:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220825085810.7290-1-ilpo.jarvinen@linux.intel.com> <20220825085810.7290-4-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20220825085810.7290-4-ilpo.jarvinen@linux.intel.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Aug 2022 18:56:27 +0300
Message-ID: <CAHp75Vdn6tTnJbP0--PZoKZJN3XbJpDNN+4GNAF65BK8DRKFgQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] serial: fsl_lpuart: Remove custom frame size calculation
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Thu, Aug 25, 2022 at 11:59 AM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> The number of bits can be calculated using tty_get_frame_size(), no
> need for the driver to do it on its own.

...

>         struct dma_slave_config dma_rx_sconfig =3D {};
>         struct circ_buf *ring =3D &sport->rx_ring;
>         int ret, nent;
> -       int bits, baud;
> +       int baud;
>         struct tty_port *port =3D &sport->port.state->port;
>         struct tty_struct *tty =3D port->tty;
>         struct ktermios *termios =3D &tty->termios;
>         struct dma_chan *chan =3D sport->dma_rx_chan;
>
>         baud =3D tty_get_baud_rate(tty);

You can move baud and join with the assignment, right?
At the same time provide a temporary variable for bits here with the assign=
ment.

> -       bits =3D (termios->c_cflag & CSIZE) =3D=3D CS7 ? 9 : 10;
> -       if (termios->c_cflag & PARENB)
> -               bits++;
> -
>         /*
>          * Calculate length of one DMA buffer size to keep latency below
>          * 10ms at any baud rate.
>          */
> -       sport->rx_dma_rng_buf_len =3D (DMA_RX_TIMEOUT * baud /  bits / 10=
00) * 2;

This will be left untouched.

> +       sport->rx_dma_rng_buf_len =3D (DMA_RX_TIMEOUT * baud / tty_get_fr=
ame_size(termios->c_cflag) /
> +                                    1000) * 2;

And no strange indentation.

--=20
With Best Regards,
Andy Shevchenko
