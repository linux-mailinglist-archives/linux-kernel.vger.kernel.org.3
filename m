Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7491A484EC2
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 08:36:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238104AbiAEHgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 02:36:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231343AbiAEHgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 02:36:43 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C375C061761;
        Tue,  4 Jan 2022 23:36:43 -0800 (PST)
Received: from localhost (unknown [IPv6:2a01:e0a:2c:6930:5cf4:84a1:2763:fe0d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: bbrezillon)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id F38BC1F43FFC;
        Wed,  5 Jan 2022 07:36:40 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1641368201;
        bh=QPkvd5xczl6Z64qbpAjTBQEF06yvP1eRXJlEOKnp7wg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BiIw+6nB+qqPQ/qBtYrXS+VmqjdzQ7EMIhmhNM7fUVnsarXQtFyRjz0XNQm5YPOwI
         rlAzEpKreHkAlXq5qstDryPmGTf0YTex2q/M8VhYNZ8c4xVUFbHPpDQBCfhXM08chG
         9QCTE7SMYpjkFhZ4wKz0LiboypZJvdZJCC98UaahVyxpyX7lHbna85So3YJRH8a3HI
         LxK8ibXE61RXlHR85yo2HSxiFbq4ZJPTXKyzNxWWQyqPmzhW9xXBJgkzOZ2kFpWfmC
         KM14EZ1EwRdF8ALrUEy5lL1jLEc1EHNd1zHncaskbacCsagFGi57JD9WeEqBYVg8ME
         lBe/8jpyu72pA==
Date:   Wed, 5 Jan 2022 08:36:37 +0100
From:   Boris Brezillon <boris.brezillon@collabora.com>
To:     Pratyush Yadav <p.yadav@ti.com>
Cc:     Apurva Nandan <a-nandan@ti.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Daniel Palmer <daniel@0x0f.com>,
        Alexander Lobakin <alobakin@pm.me>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v3 01/17] spi: spi-mem: Add DTR templates for cmd,
 address, dummy and data phase
Message-ID: <20220105083637.651f0d01@collabora.com>
In-Reply-To: <20220105055053.s4yfnk7cjedwtgvn@ti.com>
References: <20220101074250.14443-1-a-nandan@ti.com>
        <20220101074250.14443-2-a-nandan@ti.com>
        <20220104163100.56850d0b@collabora.com>
        <20220105055053.s4yfnk7cjedwtgvn@ti.com>
Organization: Collabora
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.30; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Jan 2022 11:20:55 +0530
Pratyush Yadav <p.yadav@ti.com> wrote:

> On 04/01/22 04:31PM, Boris Brezillon wrote:
> > and you get to define a DTR op like that:
> > 
> > 	struct spi_mem_op op =
> > 		SPI_MEM_OP(SPI_MEM_OP_EXT_CMD(2, 0x1234, 8, SPI_MEM_OP_DTR),
> > 			   SPI_MEM_OP_ADDR(4, 0xdeadbeef, 8, SPI_MEM_OP_DTR),
> > 			   SPI_MEM_OP_DATA_OUT(128, buf, 8, SPI_MEM_OP_DTR));
> > 
> > This also means we can extend the struct without having to define new macros.  
> 
> I like this. It would also let us easily mix-and-match the ecc parameter 
> that Miquel is adding.
> 

In practice, I doubt you'll ever set the ecc bit when declaring the op,
it's more a modification you do afterwards if ECC needs to be enabled,
but who knows...
