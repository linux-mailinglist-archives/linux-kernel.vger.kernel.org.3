Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A20354647EC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347292AbhLAH07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:26:59 -0500
Received: from verein.lst.de ([213.95.11.211]:33811 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347247AbhLAH0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:26:53 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 373BF68B05; Wed,  1 Dec 2021 08:23:29 +0100 (CET)
Date:   Wed, 1 Dec 2021 08:23:28 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Pratyush Yadav <p.yadav@ti.com>, linux-mtd@lists.infradead.org,
        linux-block@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFC -nxt] mtd_blkdevs: Set GENHD_FL_NO_PART
Message-ID: <20211201072328.GA31765@lst.de>
References: <c26dfdf9ce56e92d23530a09db386b283e62845d.1638289204.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c26dfdf9ce56e92d23530a09db386b283e62845d.1638289204.git.geert+renesas@glider.be>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 05:23:46PM +0100, Geert Uytterhoeven wrote:
> When DT declares the partitions of an spi-nor device using
> "fixed-partitions", the individual mtdblockN partitions are now scanned
> for partitition tables, which should not happen.
> 
> Fix this by setting the GENHD_FL_NO_PART flag in the MTD block layer
> interface.
> 
> Fixes: 1ebe2e5f9d68e94c ("block: remove GENHD_FL_EXT_DEVT")
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
> Seen with e.g. arch/arm/boot/dts/r8a7791-koelsch.dts.
> I only noticed because I have debug code to measure QSPI performance,
> which informed me about 8 x 512 bytes being read from each partition
> detected.
> 
> RFC as I'm not sure this is correct in all cases.
> I did verify that in the absence of "fixed-partitions", the spi-nor
> device is not scanned for partitions before and after commit
> 1ebe2e5f9d68e94c.

As far as I can tell mtd fixed partitions have nothing to do with
the block layer concept of partitions.  What kind of behavior change
did you see?
