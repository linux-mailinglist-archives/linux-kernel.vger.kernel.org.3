Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910F14A4CBC
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 18:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380711AbiAaRHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 12:07:25 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:55928 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236802AbiAaRHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 12:07:21 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20VH7Dgx004911;
        Mon, 31 Jan 2022 11:07:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643648833;
        bh=Y5ubGFQwLXLIAyG1M+qn3V/jyqUuK8grcewfac8oAY0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=LDSh9FNE7lpjO8sCs0kzIK2xu2bRRwNoNh+4h8htvrrewZ7pvXC/k8hdr/WHidiwV
         8/Kp/kdvjE5tKJ9OWB28FdSxQuKsLFBYxrByVdUj57/NhMeFQHZwp2tDPG104EHRu4
         Kyf6PW8/xL7RYv//A6yQLgSij7ZSrO0RkOpCmESI=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20VH7DmI035872
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 31 Jan 2022 11:07:13 -0600
Received: from DLEE107.ent.ti.com (157.170.170.37) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 31
 Jan 2022 11:07:12 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 31 Jan 2022 11:07:12 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20VH7BXX075932;
        Mon, 31 Jan 2022 11:07:12 -0600
Date:   Mon, 31 Jan 2022 22:37:11 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Takahiro Kuwano <tkuw584924@gmail.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] spi: spi-mem: check if data buffers are on stack
Message-ID: <20220131170711.ydydtx3jeu3fl7pu@ti.com>
References: <20220131114508.1028306-1-p.yadav@ti.com>
 <YffqNEzjIkApR1HS@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YffqNEzjIkApR1HS@sirena.org.uk>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/01/22 01:55PM, Mark Brown wrote:
> On Mon, Jan 31, 2022 at 05:15:08PM +0530, Pratyush Yadav wrote:
> > The buffers passed in the data phase must be DMA-able. Programmers often
> > don't realise this requirement and pass in buffers that reside on the
> > stack. This can be hard to spot when reviewing code. Reject ops if their
> > data buffer is on the stack to avoid this.
> 
> Acked-by: Mark Brown <broonie@kernel.org>

Thanks. But seems like this is breaking build on arm-socfpga_defconfig. 
Let me take a look into it.

> 
> > +	/* Buffers must be DMA-able. */
> > +	if (op->data.dir == SPI_MEM_DATA_IN &&
> > +	    object_is_on_stack(op->data.buf.in))
> 
> Might be worth a WARN_ON_ONCE() for debuggability?

Okay, I'll add it.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
