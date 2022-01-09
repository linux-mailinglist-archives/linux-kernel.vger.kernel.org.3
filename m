Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42EBC48882F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 07:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235196AbiAIGFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 01:05:40 -0500
Received: from mga12.intel.com ([192.55.52.136]:7587 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229960AbiAIGFj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 01:05:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641708339; x=1673244339;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PcEkNSTfdx04O272Wzze1eduouNaT4rvO4OOP/8Sqyk=;
  b=nBr0dC5cMNb32oeg65R9vJtDMA6fOFzDzQ4Y4WSZxcbNXD7JZ+60uf2M
   RAX14Pg3O+Fm0QA+123F10zMNclmUrVURwhVsWCZjop8fWXFrdhdH3yPL
   PJ8i1iDT0zD/TO/4iq+rm4lwzlMomFH6XIahcfrBFyEcib1HpcJFkHoeX
   c8P4EkXg0bVgdTraYc5h1mFzPrfc54OFKWnJAGoyv9TfGH3qyIv6OcTrn
   KQ8ETKnOxMm72KwZNlHGBELL2fvaYPkFHLIlpDMhpD20p4tm0bp2lI3x8
   NMPzcpqTmoAYqAQsEkzL+Lsg2Ba5LBNsDao8VDMENz3bxDcXEZLP/DScK
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10221"; a="223048671"
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="223048671"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2022 22:05:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,273,1635231600"; 
   d="scan'208";a="471727718"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga003.jf.intel.com with ESMTP; 08 Jan 2022 22:05:38 -0800
Received: from lcsmsx602.ger.corp.intel.com (10.109.210.11) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 8 Jan 2022 22:05:37 -0800
Received: from lcsmsx602.ger.corp.intel.com (10.109.210.11) by
 LCSMSX602.ger.corp.intel.com (10.109.210.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sun, 9 Jan 2022 08:05:35 +0200
Received: from lcsmsx602.ger.corp.intel.com ([10.109.210.11]) by
 LCSMSX602.ger.corp.intel.com ([10.109.210.11]) with mapi id 15.01.2308.020;
 Sun, 9 Jan 2022 08:05:35 +0200
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>
Subject: RE: [PATCH] mei: me: Use dma_set_mask_and_coherent() and simplify
 code
Thread-Topic: [PATCH] mei: me: Use dma_set_mask_and_coherent() and simplify
 code
Thread-Index: AQHYBFwhZZz1KUNKp068RyPxOX5Wq6xaNL3g
Date:   Sun, 9 Jan 2022 06:05:35 +0000
Message-ID: <210864289c574c65b1c7e5ad5b913b9c@intel.com>
References: <67ddcec656194153830684e6ff4513114e8859d6.1641624544.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <67ddcec656194153830684e6ff4513114e8859d6.1641624544.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-reaction: no-action
dlp-version: 11.6.200.16
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>=20
> Use dma_set_mask_and_coherent() instead of unrolling it with some
> dma_set_mask()+dma_set_coherent_mask().
>=20
> Moreover, as stated in [1], dma_set_mask() with a 64-bit mask will never =
fail
> if dev->dma_mask is non-NULL.
> So, if it fails, the 32 bits case will also fail for the same reason.
>=20
> Simplify code and remove some dead code accordingly.
>=20
>=20
> While at it, include directly <linux/dma-mapping.h> instead on relying on
> indirect inclusion.
>=20
> [1]: https://lkml.org/lkml/2021/6/7/398
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Acked-by: Tomas Winkler <tomas.winkler@intel.com>
> ---
>  drivers/misc/mei/pci-me.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/misc/mei/pci-me.c b/drivers/misc/mei/pci-me.c index
> 3a45aaf002ac..a05cdb25d0c4 100644
> --- a/drivers/misc/mei/pci-me.c
> +++ b/drivers/misc/mei/pci-me.c
> @@ -10,6 +10,7 @@
>  #include <linux/errno.h>
>  #include <linux/types.h>
>  #include <linux/pci.h>
> +#include <linux/dma-mapping.h>
>  #include <linux/sched.h>
>  #include <linux/interrupt.h>
>=20
> @@ -192,14 +193,7 @@ static int mei_me_probe(struct pci_dev *pdev,
> const struct pci_device_id *ent)
>  		goto end;
>  	}
>=20
> -	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(64)) ||
> -	    dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64))) {
> -
> -		err =3D dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
> -		if (err)
> -			err =3D dma_set_coherent_mask(&pdev->dev,
> -						    DMA_BIT_MASK(32));
> -	}
> +	err =3D dma_set_mask_and_coherent(&pdev->dev,
> DMA_BIT_MASK(64));
>  	if (err) {
>  		dev_err(&pdev->dev, "No usable DMA configuration,
> aborting\n");
>  		goto end;
> --
> 2.32.0

