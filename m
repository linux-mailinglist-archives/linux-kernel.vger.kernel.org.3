Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A625461D63
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 19:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350291AbhK2SPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 13:15:14 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:54720 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349813AbhK2SNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 13:13:13 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1ATI9bdw085910;
        Mon, 29 Nov 2021 12:09:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638209377;
        bh=7BzZum/wSpr+6OJerze3ARCjTNpCFGTq2Yr+iKCYVE8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=G3U9OzgzLfAEvnAt1pP25EJH9XgDtuxUrXdMCff3ztCsgMYvYKSvtyoRevrqvGUWH
         t6Rtyz7SXl2lrdayZk2zjMnphy7bsnNFC/ExVgLhdtdZQZTxzBi0fOoVvfY/HLZbmO
         LtTYbOEWMqQM2VvqDHM45SGDGZtbnHtxacEHZUlA=
Received: from DFLE104.ent.ti.com (dfle104.ent.ti.com [10.64.6.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1ATI9bNQ113862
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Nov 2021 12:09:37 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 29
 Nov 2021 12:09:36 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 29 Nov 2021 12:09:36 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1ATI9ZYm037856;
        Mon, 29 Nov 2021 12:09:36 -0600
Date:   Mon, 29 Nov 2021 23:39:35 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Rob Herring <robh+dt@kernel.org>
CC:     Mark Brown <broonie@kernel.org>, Nishanth Menon <nm@ti.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>
Subject: Re: [PATCH v3 0/3] Add bindings for peripheral-specific SPI
 controller properties
Message-ID: <20211129180935.nmymboy336hllly7@ti.com>
References: <20211109181911.2251-1-p.yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20211109181911.2251-1-p.yadav@ti.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 09/11/21 11:49PM, Pratyush Yadav wrote:
> Hi,
> 
> This series adds bindings for peripheral-specific SPI controller properties.
> See patch 1 for more info on the motivations behind this.
> 
> This is the best approach that I came up with with my limited knowledge
> of JSON schema. It has some limitations that are mentioned in patch 1. I
> don't know of any better ways to model this. Suggestions are welcome!

Do you plan to take this series through your tree or should I poke Mark 
about it?

> 
> Changes in v3:
> - s/slave/peripheral/g
> - Drop the | on description.
> - Drop the compatible property.
> 
> Changes in v2:
> - Move other subnode properties listed in spi-controller.yaml to
>   spi-slave-props.yaml
> - Move the Cadence controller-specific properties out of
>   spi-slave-props.yaml. They will be added in a separate file.
> - Add a reference to spi-slave-props.yaml in spi-controller.yaml.
> - Update description.
> 
> Pratyush Yadav (3):
>   spi: dt-bindings: add schema listing peripheral-specific properties
>   spi: dt-bindings: cdns,qspi-nor: Move peripheral-specific properties
>     out
>   dt-bindings: mtd: spi-nor: Add a reference to
>     spi-peripheral-props.yaml
> 
>  .../bindings/mtd/jedec,spi-nor.yaml           |  3 +-
>  .../spi/cdns,qspi-nor-peripheral-props.yaml   | 42 +++++++++
>  .../bindings/spi/cdns,qspi-nor.yaml           | 33 -------
>  .../bindings/spi/spi-controller.yaml          | 69 +-------------
>  .../bindings/spi/spi-peripheral-props.yaml    | 89 +++++++++++++++++++
>  5 files changed, 135 insertions(+), 101 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/spi/cdns,qspi-nor-peripheral-props.yaml
>  create mode 100644 Documentation/devicetree/bindings/spi/spi-peripheral-props.yaml
> 
> --
> 2.33.1.835.ge9e5ba39a7
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
