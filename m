Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE545017AD
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:03:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241037AbiDNPnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354587AbiDNPSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:18:23 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EBD7ECB3B
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:06:50 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 218D21F47B07;
        Thu, 14 Apr 2022 16:06:48 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649948808;
        bh=UpSLyopnlq5YAkIaxL8rC/z8gQiFGUjISBXjuDV87YA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=b0pwOTmW+kxJoLFq5v97T8FjTuaAb8wrqPxesw6cwS+6nTA86EsvdR+Chu26nEWCy
         Xf3qKjda/0QTX/bFoVGdrjagui6XsSTSQ1L9HwCXh74Rm5w5x0DiRSjHVb0JxxNPNQ
         bqWf+vIKAbX/hVQfy7h2oTN2Iy0IZKRAebF+sd41nSxF4QV0psAsLqbKE2uWE8/WlE
         qcVEUlR3nJwD01Nq3MxUmpUKrKWr2rLCJUC36537UvTZAn/x0R6pehthyq6/P2TqtC
         xv6GBdR7477RO7wlrat+EGIYskHD8T4Xr1PPPiqCP99itD0GSaDanjiPUTpFkJP+5h
         qVJgqOvlkKTAA==
Date:   Thu, 14 Apr 2022 17:06:44 +0200
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mtd@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Palmer <daniel@0x0f.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH 1/2] mtd: spinand: add support for detection with param
 page
Message-ID: <20220414170644.4a53484f@collabora.com>
In-Reply-To: <20220414143426.723168-2-gch981213@gmail.com>
References: <20220414143426.723168-1-gch981213@gmail.com>
        <20220414143426.723168-2-gch981213@gmail.com>
Organization: Collabora
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Apr 2022 22:34:25 +0800
Chuanhong Guo <gch981213@gmail.com> wrote:

> SPI-NAND detection using chip ID isn't always reliable.
> Here are two known cases:
> 1. ESMT uses JEDEC ID from other vendors. This may collapse with future
>    chips.

Really?! So the manufacturer id matching is not even possible?

> 2. Winbond W25N01KV uses the exact same JEDEC ID as W25N01GV while
>    having completely different chip parameters.
> 
> Recent SPI-NANDs have a parameter page which is stored in the same
> format as raw NAND ONFI data. There are strings for chip manufacturer
> and chip model. Chip ECC requirement and memory organization are
> available too.
> This patch adds support for detecting SPI-NANDs with the parameter page
> after ID matching failed. In this detection, memory organization and
> ECC requirements are taken from the parameter page, and other SPI-NAND
> specific parameters are obtained by matching chip model string with
> a separated table.

Oh come on! Looks like they never learn from their mistakes...

> 
> It's common for vendors to release a series of SPI-NANDs with the same
> SPI-NAND parameters in different voltages and/or capacities. The chip
> table defined in this patch supports multiple model strings in one
> entry, and multiple chip models can be covered using only one entry.

That's really disappointing. And I guess the ONFI-page read commands are
not even standard, and each vendor will come with its own sequence to
read it. What's bothering me the most is the fact that ONFI parameter
pages are not even designed for SPI NANDs. They have a bunch of
parameters that don't really apply to SPI NANDs, and we're still
lacking SPI-specific info, like the read/write/erase command variants,
the maximum SPI bus width (AKA SPI modes)...

To sum-up, if we have to support reading the ONFI parameter page, I'd
rather keep it vendor-private (but that's assuming the vendor ID
detection works, and you seem to imply ESMT cheats on that too), and
use it only as a way to distinguish between 2 chip variants.

> 
> Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
> ---
> 
> I'm not brave enough to touch raw nand code without testing, so
> sanitize_string, onfi_crc16 and nand_bit_wise_majority are
> duplicated from raw/nand_onfi.c into spi/onfi.c
> 
>  drivers/mtd/nand/spi/Makefile |   2 +-
>  drivers/mtd/nand/spi/core.c   |  23 +--
>  drivers/mtd/nand/spi/onfi.c   | 296 ++++++++++++++++++++++++++++++++++

Please, no. Try to move the common code to drivers/mtd/nand/onfi.c
instead of duplicating it. AFAICT, the only thing that's spinand
specific is spinand_onfi_read() and the last part of
spinand_onfi_detect(). I'm sure we can find a way to expose
generic onfi_parsing() helpers.
