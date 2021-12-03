Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B665846733A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 09:26:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379190AbhLCI3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 03:29:31 -0500
Received: from mail-ua1-f41.google.com ([209.85.222.41]:36789 "EHLO
        mail-ua1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379143AbhLCI3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 03:29:30 -0500
Received: by mail-ua1-f41.google.com with SMTP id r15so4055170uao.3;
        Fri, 03 Dec 2021 00:26:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nv8Jf49U8dHM6/sJsWSvwazrQnskBUzISoulkhKft80=;
        b=L8t0rXDY8x2xXDbYuVWHPhDDMNxKk8NRu2hPgywrWYG3Kn3fSl/zEFZIenOJgCL6Hd
         A3Fd5RMtWOTjVRLupH9fPusTqO4HXIVTWKjpfJBH0RzpeVkEGFnd1ebx9uip4NGOKjRn
         eaNXT1kLbQMADNIcmf+iPL82y3Thf4OCHqxw/aqMZi1W+ixLPGczvPnn+pm/6+4Q1gfB
         n0RV33ubNKQNnyoIs/ewKnR06b3ul75XRDqZvgYgn+wpu9uNE52BA1rumQM35DlUe3fY
         DvCyaA2hkK+qwtXTs5xDAkvPoaVN2HatmfByB0kXZhUfBNMAfU9XbPosPiqLoWPxuFhJ
         VyQg==
X-Gm-Message-State: AOAM532X1mjDOKgcOB5Nqy6DTWosErW6TdnKDr+Y+SXIOfu9f39tn0GT
        DlCphxBkKxo8ZYXQoIi8CQNwKfv0BE8Rncg9
X-Google-Smtp-Source: ABdhPJyfSjm1n2ApUicTHkaVFy01cgH9A3aFLoRzPLPE++w/ueLdUaz2mW4rH0r5UQpmSrDQmryCPA==
X-Received: by 2002:a67:e114:: with SMTP id d20mr20213817vsl.5.1638519966445;
        Fri, 03 Dec 2021 00:26:06 -0800 (PST)
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com. [209.85.222.42])
        by smtp.gmail.com with ESMTPSA id q20sm362299uae.17.2021.12.03.00.26.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 00:26:06 -0800 (PST)
Received: by mail-ua1-f42.google.com with SMTP id t13so3985314uad.9;
        Fri, 03 Dec 2021 00:26:06 -0800 (PST)
X-Received: by 2002:a05:6102:c89:: with SMTP id f9mr19521165vst.68.1638519963327;
 Fri, 03 Dec 2021 00:26:03 -0800 (PST)
MIME-Version: 1.0
References: <c26dfdf9ce56e92d23530a09db386b283e62845d.1638289204.git.geert+renesas@glider.be>
 <20211203065726.GA3072@lst.de>
In-Reply-To: <20211203065726.GA3072@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 3 Dec 2021 09:25:51 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWR3hwBho3wDBPjGm4q==qrQn3PLdZN9CfVwX-aOMUW0A@mail.gmail.com>
Message-ID: <CAMuHMdWR3hwBho3wDBPjGm4q==qrQn3PLdZN9CfVwX-aOMUW0A@mail.gmail.com>
Subject: Re: [PATCH/RFC -nxt] mtd_blkdevs: Set GENHD_FL_NO_PART
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>,
        MTD Maling List <linux-mtd@lists.infradead.org>,
        linux-block@vger.kernel.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph,

On Fri, Dec 3, 2021 at 7:57 AM Christoph Hellwig <hch@lst.de> wrote:
> I think we need the patch below to restore the old behavior where a
> partitions scan happens only for those sub-drivers that do report a
> partition shift.

Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

> MTD maintainers: is this intentional that raw mtdblock does not support
> partitions, but the various "FTL" modules do?
>
> diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
> index 113f86df76038..57a22d2ebaeca 100644
> --- a/drivers/mtd/mtd_blkdevs.c
> +++ b/drivers/mtd/mtd_blkdevs.c
> @@ -345,6 +345,8 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
>         gd->first_minor = (new->devnum) << tr->part_bits;
>         gd->minors = 1 << tr->part_bits;
>         gd->fops = &mtd_block_ops;
> +       if (!tr->part_bits)
> +               gd->flags |= GENHD_FL_NO_PART;

Move this into the "else" branch of the test below?

>         if (tr->part_bits)
>                 if (new->devnum < 26)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
