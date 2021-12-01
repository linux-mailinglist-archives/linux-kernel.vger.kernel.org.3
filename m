Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44401464B3B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 11:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348484AbhLAKMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 05:12:16 -0500
Received: from mail-ua1-f51.google.com ([209.85.222.51]:45588 "EHLO
        mail-ua1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242474AbhLAKMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 05:12:15 -0500
Received: by mail-ua1-f51.google.com with SMTP id ay21so47712081uab.12;
        Wed, 01 Dec 2021 02:08:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OPPtbzDfyTfORykbO3S8ExCZdlOUf/q6E0viO28dDok=;
        b=est6xarIJW0f3uqvw+ijPQS29F3g5d76o1io1CuKRsurdL60TEGEn/1Xjrs9M9ii40
         zYTlPKyTduWi8XhYGpuetZcMTMqLfrf6It+3NNIyx/4QxsAdI5AqTwieCvJXqsRWf0yq
         rSSdtfSYszYVqqE0A2MlvSBUKO69COFA8xaTGW39/7NBVcTWPSCyk6qk6McWjdUaSSJF
         M7No0t3hcJdOejJ3Y9DkuZcLrINMsMzklhN6sfHF23QyBmj7fDf2Ir0q5nfzawQsuSre
         jdBJ6ie2xLLOQxELur+JQHPKT+oNd6XkU2y05gLuwC++zrXKh3fE6FiVD/M85Y7vGh/2
         qMGg==
X-Gm-Message-State: AOAM532brfaRIhOx+JwCpzpWyFGhrC5yhK7e+23uQJSXCzi9ScoXGv6y
        8kehfcAl8rZIMj51DpCCm8gKv3AFJTHRAw==
X-Google-Smtp-Source: ABdhPJzONKxO5t51M2gpdgTljeOlTefC+Sx2WyqfaXm+IoqOPGwe4BGteg4WMK9SfHGKNmLDfFBh1g==
X-Received: by 2002:a05:6102:cd1:: with SMTP id g17mr5770153vst.55.1638353334299;
        Wed, 01 Dec 2021 02:08:54 -0800 (PST)
Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com. [209.85.222.53])
        by smtp.gmail.com with ESMTPSA id b11sm12359765vsp.6.2021.12.01.02.08.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Dec 2021 02:08:53 -0800 (PST)
Received: by mail-ua1-f53.google.com with SMTP id p2so47641930uad.11;
        Wed, 01 Dec 2021 02:08:53 -0800 (PST)
X-Received: by 2002:a67:c106:: with SMTP id d6mr5459646vsj.77.1638353333064;
 Wed, 01 Dec 2021 02:08:53 -0800 (PST)
MIME-Version: 1.0
References: <c26dfdf9ce56e92d23530a09db386b283e62845d.1638289204.git.geert+renesas@glider.be>
 <20211201072328.GA31765@lst.de>
In-Reply-To: <20211201072328.GA31765@lst.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 1 Dec 2021 11:08:40 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV7PbXwuBNBn4TtjXUvjzWiOQTYoOJTEACyN-k4DUj5-Q@mail.gmail.com>
Message-ID: <CAMuHMdV7PbXwuBNBn4TtjXUvjzWiOQTYoOJTEACyN-k4DUj5-Q@mail.gmail.com>
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

On Wed, Dec 1, 2021 at 8:23 AM Christoph Hellwig <hch@lst.de> wrote:
> On Tue, Nov 30, 2021 at 05:23:46PM +0100, Geert Uytterhoeven wrote:
> > When DT declares the partitions of an spi-nor device using
> > "fixed-partitions", the individual mtdblockN partitions are now scanned
> > for partitition tables, which should not happen.
> >
> > Fix this by setting the GENHD_FL_NO_PART flag in the MTD block layer
> > interface.
> >
> > Fixes: 1ebe2e5f9d68e94c ("block: remove GENHD_FL_EXT_DEVT")
> > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > ---
> > Seen with e.g. arch/arm/boot/dts/r8a7791-koelsch.dts.
> > I only noticed because I have debug code to measure QSPI performance,
> > which informed me about 8 x 512 bytes being read from each partition
> > detected.
> >
> > RFC as I'm not sure this is correct in all cases.
> > I did verify that in the absence of "fixed-partitions", the spi-nor
> > device is not scanned for partitions before and after commit
> > 1ebe2e5f9d68e94c.
>
> As far as I can tell mtd fixed partitions have nothing to do with
> the block layer concept of partitions.  What kind of behavior change
> did you see?

After the aforementioned commit, 8 x 512 bytes are being read from
the start of each partition described by "fixed-partitions".
Dmesg difference with debug print added to spi_nor_spimem_read_data():

  renesas_spi e6b10000.spi: registered master spi0
  spi spi0.0: setup mode 3, 8 bits/w, 30000000 Hz max --> 0
  spi-nor spi0.0: s25fl512s (65536 Kbytes)
  3 fixed-partitions partitions found on MTD device spi0.0
  Creating 3 MTD partitions on "spi0.0":
  0x000000000000-0x000000080000 : "loader"
+ spi-nor spi0.0: spi_nor_spimem_read_data: from 0 len 512
+ spi-nor spi0.0: spi_nor_spimem_read_data: from 512 len 512
+ spi-nor spi0.0: spi_nor_spimem_read_data: from 1024 len 512
+ spi-nor spi0.0: spi_nor_spimem_read_data: from 1536 len 512
+ spi-nor spi0.0: spi_nor_spimem_read_data: from 2048 len 512
+ spi-nor spi0.0: spi_nor_spimem_read_data: from 2560 len 512
+ spi-nor spi0.0: spi_nor_spimem_read_data: from 3072 len 512
+ spi-nor spi0.0: spi_nor_spimem_read_data: from 3584 len 512
  0x000000080000-0x000000600000 : "user"
+ spi-nor spi0.0: spi_nor_spimem_read_data: from 524288 len 512
+ spi-nor spi0.0: spi_nor_spimem_read_data: from 524800 len 512
+ spi-nor spi0.0: spi_nor_spimem_read_data: from 525312 len 512
+ spi-nor spi0.0: spi_nor_spimem_read_data: from 525824 len 512
+ spi-nor spi0.0: spi_nor_spimem_read_data: from 526336 len 512
+ spi-nor spi0.0: spi_nor_spimem_read_data: from 526848 len 512
+ spi-nor spi0.0: spi_nor_spimem_read_data: from 527360 len 512
+ spi-nor spi0.0: spi_nor_spimem_read_data: from 527872 len 512
  0x000000600000-0x000004000000 : "flash"
+ spi-nor spi0.0: spi_nor_spimem_read_data: from 6291456 len 512
+ spi-nor spi0.0: spi_nor_spimem_read_data: from 6291968 len 512
+ spi-nor spi0.0: spi_nor_spimem_read_data: from 6292480 len 512
+ spi-nor spi0.0: spi_nor_spimem_read_data: from 6292992 len 512
+ spi-nor spi0.0: spi_nor_spimem_read_data: from 6293504 len 512
+ spi-nor spi0.0: spi_nor_spimem_read_data: from 6294016 len 512
+ spi-nor spi0.0: spi_nor_spimem_read_data: from 6294528 len 512
+ spi-nor spi0.0: spi_nor_spimem_read_data: from 6295040 len 512
  renesas_spi e6b10000.spi: registered child spi0.0
  renesas_spi e6b10000.spi: probed

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
