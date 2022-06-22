Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5986F554247
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 07:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357041AbiFVF35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 01:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232386AbiFVF34 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 01:29:56 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912C33616D;
        Tue, 21 Jun 2022 22:29:53 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id q15so8570002wmj.2;
        Tue, 21 Jun 2022 22:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e8ZNIxBrgtMQiUBB+AomF9YceG4wweliH+wtvtHZbpM=;
        b=NzFG6aUDVog5xCHWHWO3+6IOp6tW90NJQQ34O++uBT+OkQXW7pUMGey/QmDnrqxVzf
         dcj8lvppKrwCWJCMLl0/ShuY5QH1AhOiErI5eUCrwWSDzDxGRDO+rrGvEC0MBjkWEY+v
         Ut0Tx6ylAZmuuHsJGiCZR/LzBl88gGujh8oP8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e8ZNIxBrgtMQiUBB+AomF9YceG4wweliH+wtvtHZbpM=;
        b=xjDJsPLhBioaL11Szv3a0Hx0/myyEWKDPkvERA2czSuypLpnai2d7AbFR335XFBiHw
         GPp0XJfZzxrDZhkqH2Cp8DfZqVw6rwgo8zAvtdhLzUDVjVai2dsLK4lBUofnDwOIpMeK
         RozllumFO89LodWK2bL1851P4qHuTOcZ/2X5laFSICC7bWSYHDUX+NUI94P2ITX32hiE
         y9W+nUDoTD67QbqOKHfQbv1X7zc7jUiH+Lrz+IhkRaHLIk5N0iVWeBcxXubGJsCyjyww
         ZiSh2X9x5SZMCVrgbsd/T2xmJ0ryDlHJhVtypvw+JPyONdBA/m75rWkDAqbHxXN2EPYZ
         Gw9w==
X-Gm-Message-State: AOAM530p6mDSoQHDMVV4CpFhIPCyMXJQPayY44tT7kvYbqaAPia0JVLO
        4AB7weA88SWdMnBT/c99TS4UhHVwekn3n9Nug4jSq82O
X-Google-Smtp-Source: ABdhPJzZvryKqgcWaTUQ/imYSx0Fb7tWzac85u0+/+HebZbQfMU1jqgg9EjHTaoRErRZh9y06Dm67UEboYdMRO3X0DM=
X-Received: by 2002:a05:600c:5d3:b0:39c:506d:c987 with SMTP id
 p19-20020a05600c05d300b0039c506dc987mr44748571wmd.10.1655875792091; Tue, 21
 Jun 2022 22:29:52 -0700 (PDT)
MIME-Version: 1.0
References: <7ae260778d2c08986348ea48ce02ef148100e088.1655817534.git.geert+renesas@glider.be>
In-Reply-To: <7ae260778d2c08986348ea48ce02ef148100e088.1655817534.git.geert+renesas@glider.be>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 22 Jun 2022 05:29:39 +0000
Message-ID: <CACPK8Xd-+zmExboCfeHL4axgrA_P99PDO0dgda5SHGo84DYB3A@mail.gmail.com>
Subject: Re: [PATCH] eeprom: at25: Rework buggy read splitting
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Eddie James <eajames@linux.ibm.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Brad Bishop <bradleyb@fuzziesquirrel.com>,
        linux-spi@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jun 2022 at 13:22, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
>
> The recent change to split reads into chunks has several problems:
>   1. If an SPI controller has no transfer size limit, max_chunk is
>      SIZE_MAX, and num_msgs becomes zero, causing no data to be read
>      into the buffer, and exposing the original contents of the buffer
>      to userspace,
>   2. If the requested read size is not a multiple of the maximum
>      transfer size, the last transfer reads too much data, overflowing
>      the buffer,
>   3. The loop logic differs from the write case.
>
> Fix the above by:
>   1. Keeping track of the number of bytes that are still to be
>      transferred, instead of precalculating the number of messages and
>      keeping track of the number of bytes tranfered,

sp: transferred

>   2. Calculating the transfer size of each individual message, taking
>      into account the number of bytes left,
>   3. Switching from a "while"-loop to a "do-while"-loop, and renaming
>      "msg_count" to "segment".
>
> While at it, drop the superfluous cast from "unsigned int" to "unsigned
> int", also from at25_ee_write(), where it was probably copied from.
>
> Fixes: 0a35780c755ccec0 ("eeprom: at25: Split reads into chunks and cap write size")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks Geert for the patch. This is particularly important as I
noticed the "fix" has been backported to stable trees.

I was surprised that patch went in as-is; I thought it needed some
discussion before merging. I wasn't sure if it was the correct fix at
all; I wondered if it should have been fixed at the spi layer. Do you
have an opinion there?

Eddie, can you jump in for some testing and a review of this one?

Cheers,

Joel

> ---
> Tested on Ebisu-4D with 25LC040 EEPROM.
> ---
>  drivers/misc/eeprom/at25.c | 26 ++++++++++++--------------
>  1 file changed, 12 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/misc/eeprom/at25.c b/drivers/misc/eeprom/at25.c
> index c9c56fd194c1301f..bdffc6543f6f8b7f 100644
> --- a/drivers/misc/eeprom/at25.c
> +++ b/drivers/misc/eeprom/at25.c
> @@ -80,10 +80,9 @@ static int at25_ee_read(void *priv, unsigned int offset,
>         struct at25_data *at25 = priv;
>         char *buf = val;
>         size_t max_chunk = spi_max_transfer_size(at25->spi);
> -       size_t num_msgs = DIV_ROUND_UP(count, max_chunk);
> -       size_t nr_bytes = 0;
> -       unsigned int msg_offset;
> -       size_t msg_count;
> +       unsigned int msg_offset = offset;
> +       size_t bytes_left = count;
> +       size_t segment;
>         u8                      *cp;
>         ssize_t                 status;
>         struct spi_transfer     t[2];
> @@ -97,9 +96,8 @@ static int at25_ee_read(void *priv, unsigned int offset,
>         if (unlikely(!count))
>                 return -EINVAL;
>
> -       msg_offset = (unsigned int)offset;
> -       msg_count = min(count, max_chunk);
> -       while (num_msgs) {
> +       do {
> +               segment = min(bytes_left, max_chunk);
>                 cp = at25->command;
>
>                 instr = AT25_READ;
> @@ -131,8 +129,8 @@ static int at25_ee_read(void *priv, unsigned int offset,
>                 t[0].len = at25->addrlen + 1;
>                 spi_message_add_tail(&t[0], &m);
>
> -               t[1].rx_buf = buf + nr_bytes;
> -               t[1].len = msg_count;
> +               t[1].rx_buf = buf;
> +               t[1].len = segment;
>                 spi_message_add_tail(&t[1], &m);
>
>                 status = spi_sync(at25->spi, &m);
> @@ -142,10 +140,10 @@ static int at25_ee_read(void *priv, unsigned int offset,
>                 if (status)
>                         return status;
>
> -               --num_msgs;
> -               msg_offset += msg_count;
> -               nr_bytes += msg_count;
> -       }
> +               msg_offset += segment;
> +               buf += segment;
> +               bytes_left -= segment;
> +       } while (bytes_left > 0);
>
>         dev_dbg(&at25->spi->dev, "read %zu bytes at %d\n",
>                 count, offset);
> @@ -229,7 +227,7 @@ static int at25_ee_write(void *priv, unsigned int off, void *val, size_t count)
>         do {
>                 unsigned long   timeout, retries;
>                 unsigned        segment;
> -               unsigned        offset = (unsigned) off;
> +               unsigned        offset = off;
>                 u8              *cp = bounce;
>                 int             sr;
>                 u8              instr;
> --
> 2.25.1
>
