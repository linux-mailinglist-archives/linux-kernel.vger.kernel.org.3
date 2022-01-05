Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3834484DD0
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 06:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237576AbiAEFvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 00:51:33 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54882 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237565AbiAEFvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 00:51:32 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2055ou07052391;
        Tue, 4 Jan 2022 23:50:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1641361856;
        bh=tdcTMhc1Ts5QhC1nBW9dbCgFpNUPFIMsN0Pbt3IRi1s=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=Vk924puR/YqGmHbKXpHpPLNRdA/9/2mRhi1rpyoaRbEQQvY6irvQoIN3kL/ZgERQO
         2LXTDfd9PLQMx4Y3USf91Q9hLDxoT4xL3jZZ7YlzrGkgOLWsDMlOcCrUU6uHjZBDgZ
         MxKpseCK/H9ZDQeAT9AtcLkqZ3ERIiL6P1MtNPL0=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2055ouAj111411
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 4 Jan 2022 23:50:56 -0600
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 4
 Jan 2022 23:50:56 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 4 Jan 2022 23:50:56 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2055otVr121132;
        Tue, 4 Jan 2022 23:50:56 -0600
Date:   Wed, 5 Jan 2022 11:20:55 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Boris Brezillon <boris.brezillon@collabora.com>
CC:     Apurva Nandan <a-nandan@ti.com>,
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
Message-ID: <20220105055053.s4yfnk7cjedwtgvn@ti.com>
References: <20220101074250.14443-1-a-nandan@ti.com>
 <20220101074250.14443-2-a-nandan@ti.com>
 <20220104163100.56850d0b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220104163100.56850d0b@collabora.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/01/22 04:31PM, Boris Brezillon wrote:
> and you get to define a DTR op like that:
> 
> 	struct spi_mem_op op =
> 		SPI_MEM_OP(SPI_MEM_OP_EXT_CMD(2, 0x1234, 8, SPI_MEM_OP_DTR),
> 			   SPI_MEM_OP_ADDR(4, 0xdeadbeef, 8, SPI_MEM_OP_DTR),
> 			   SPI_MEM_OP_DATA_OUT(128, buf, 8, SPI_MEM_OP_DTR));
> 
> This also means we can extend the struct without having to define new macros.

I like this. It would also let us easily mix-and-match the ecc parameter 
that Miquel is adding.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
