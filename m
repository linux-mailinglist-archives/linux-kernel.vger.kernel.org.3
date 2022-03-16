Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9911D4DABEA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 08:39:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354239AbiCPHky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 03:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354235AbiCPHkw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 03:40:52 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA7E60A8D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 00:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1647416378; x=1678952378;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HmhzW1Qp4+U0VPSr1IDp2ch0J2gmIREwX+GllKQnkvs=;
  b=ixziSYcZBNIDgXU0PCISl93l/0hXAsgUrFIEeFSWqUHuB8gdD2W/qxF3
   CixRtVNLMXxTlA6gNqpGxXXFssLKmbXSi5yuzU0+yhQGOQ70i+MKv+NM2
   f3U8D1XQGjgYo5yAEmjxstO+U7yPVGbukFDhxDnYD/X9rRXehyenxgrcq
   cZaLsDRynay6HXAT7vOA0hcNG464to0p0cCfbnkVdJ4j4zENwHtHHwv6Z
   pFrN6qcAATiqMl7dCAj2hsxIpZDIhBzmrpugULVshKsElKopCImNSKLr3
   j0CwZUVLz6VODCfrWDEa54C2phjp8Az3zlw1+DPJkVrsIMH600mLJjAJL
   A==;
X-IronPort-AV: E=Sophos;i="5.90,186,1643670000"; 
   d="scan'208";a="22692323"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 16 Mar 2022 08:39:36 +0100
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 16 Mar 2022 08:39:36 +0100
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 16 Mar 2022 08:39:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1647416376; x=1678952376;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HmhzW1Qp4+U0VPSr1IDp2ch0J2gmIREwX+GllKQnkvs=;
  b=dfpML5EA0TZp7DHALlrFIRQxsLOHs23j4cCeiV3g8EE+PPI/S/Mp3mwx
   2Kq3zz9gQ322dSEojJCcnFm+QX9ttd+Xdy8rjPDE6mwBs0arukF/DSr2i
   hMSQE2agPKTaYpGzmMDpwDHliRP6BWq86A0Bh2L+rLfTTN/5tSzUV3QjL
   f7joTc6ON+wD/Xr7j8aEEkkc4yQQ6/Fd6njFF87fqYeX0pH3Oj1CsdlnM
   JVYImrvn72FGZ062wUz6naBl/+txKcadojcSH7inVSOu0Ys39h/A4kenr
   AjFgxa4aBL+0thn7N56oK6w9rwNVejCiI7bJEsI5X8Xsjt4ctxiNv6Reb
   A==;
X-IronPort-AV: E=Sophos;i="5.90,186,1643670000"; 
   d="scan'208";a="22692322"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 16 Mar 2022 08:39:36 +0100
Received: from steina-w.localnet (unknown [10.123.49.12])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 2F44F280065;
        Wed, 16 Mar 2022 08:39:36 +0100 (CET)
From:   Alexander Stein <Alexander.Stein@tq-group.com>
To:     linux-mtd@lists.infradead.org
Cc:     michael@walle.cc, p.yadav@ti.com, vigneshr@ti.com,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-kernel@vger.kernel.org,
        Tudor Ambarus <tudor.ambarus@microchip.com>
Subject: Re: [PATCH 1/2] mtd: spi-nor: Fix shift-out-of-bounds
Date:   Wed, 16 Mar 2022 08:39:33 +0100
Message-ID: <5550605.DvuYhMxLoT@steina-w>
Organization: TQ Systems GmbH
In-Reply-To: <20211106075616.95401-2-tudor.ambarus@microchip.com>
References: <20211106075616.95401-1-tudor.ambarus@microchip.com> <20211106075616.95401-2-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Am Samstag, 6. November 2021, 08:56:15 CET schrieb Tudor Ambarus:
> When paring SFDP we may choose to mask out an erase type, passing
> an erase size of zero to spi_nor_set_erase_type().
> Fix shift-out-of-bounds and just clear the erase params when
> passing zero for erase size.
> While here avoid a superfluous dereference and use 'size' directly.
> 
> UBSAN: shift-out-of-bounds in drivers/mtd/spi-nor/core.c:2237:24
> shift exponent 4294967295 is too large for 32-bit type 'int'
> 
> Fixes: 5390a8df769e ("mtd: spi-nor: add support to non-uniform SFDP SPI NOR
> flash memories") Reported-by: Alexander Stein
> <Alexander.Stein@tq-group.com>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
>  drivers/mtd/spi-nor/core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
> index 3d97c189c332..a1b5d5432f41 100644
> --- a/drivers/mtd/spi-nor/core.c
> +++ b/drivers/mtd/spi-nor/core.c
> @@ -2230,8 +2230,13 @@ void spi_nor_set_erase_type(struct spi_nor_erase_type
> *erase, u32 size, erase->size = size;
>  	erase->opcode = opcode;
>  	/* JEDEC JESD216B Standard imposes erase sizes to be power of 2. */
> -	erase->size_shift = ffs(erase->size) - 1;
> -	erase->size_mask = (1 << erase->size_shift) - 1;
> +	if (size) {
> +		erase->size_shift = ffs(size) - 1;
> +		erase->size_mask = (1 << erase->size_shift) - 1;
> +	} else {
> +		erase->size_shift = 0;
> +		erase->size_mask = 0;
> +	}
>  }
> 
>  /**

What is the status of this patch? It is not applied up until now, no? Has it 
been superseeded?

Regards,
Alexander



