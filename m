Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C1955C821
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233875AbiF0Kg1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 06:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbiF0KgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 06:36:25 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB19063CE;
        Mon, 27 Jun 2022 03:36:24 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25RAZuUw045156;
        Mon, 27 Jun 2022 05:35:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1656326156;
        bh=9F5SoVyG6vTy+xKAz4DQZx53RbUN3yIhlnK2kgDE/aY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=dpPzAC8DcT+V80prGXqI2Pb+UikO8Gj3gOigyw3Jr+xfD4G3o4E1tYU19q4JqG1tK
         bvtspUtIk+gdUj7BQ5V+NcpOJ7T30+hd7apgZVLO33UpG+Gl6W/aY0j2plpRiqfc3K
         DhCUfF7vr3Q0Nz+S2oW0u3RTgidGg4vyACDH5YnQ=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25RAZuF3087355
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 27 Jun 2022 05:35:56 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 27
 Jun 2022 05:35:56 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 27 Jun 2022 05:35:56 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25RAZtBd091967;
        Mon, 27 Jun 2022 05:35:55 -0500
Date:   Mon, 27 Jun 2022 16:05:54 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>
CC:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mark Brown <broonie@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <linux-spi@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
Subject: Re: [RFC PATCH 3/6] mtd: spi-nor: core: run calibration when
 initialization is done
Message-ID: <20220627103554.hcvvu4r7bebd2qum@ti.com>
References: <20210311191216.7363-1-p.yadav@ti.com>
 <20210311191216.7363-4-p.yadav@ti.com>
 <20220517160226.4107f282@xps-13>
 <20220518060640.os5fp5rez4ie7qc4@ti.com>
 <20220518091931.279c5398@xps-13>
 <20220518075651.mvdhfnfbgutecgyq@ti.com>
 <b3bfa5a6-caac-94ed-6741-04db9c2a9ee0@kaod.org>
 <20220627091404.54257obrdazcjhre@ti.com>
 <82015d89-cab5-3e9a-a40e-e5dafa17ec0c@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <82015d89-cab5-3e9a-a40e-e5dafa17ec0c@kaod.org>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/22 11:43AM, Cédric Le Goater wrote:
> On 6/27/22 11:14, Pratyush Yadav wrote:
> > On 18/05/22 10:51AM, Cédric Le Goater wrote:
[...]
> 
> > > > This series does that by looking at the MTD
> > > > partitions. For that to happen, we need to create those partitions
> > > > first, which happens after mtd_device_register().
> > > 
> > > hmm, that might work for some boards. This is not at all the case for
> > > the BMC boards. Vendors can put any kind of flash model and/or layout
> > > and the driver needs to be more generic.
> > 
> > Yes, vendors can choose any layout, but one partition on that layout
> > would be your calibration pattern. I think you can use a different
> > compatible for that partition.
> 
> OK. and that it would become more generic then.
> 
> > I have not thought this through yet though.
> 
> If a partition is required, that's a dependency on mtdpart.
> 
> It could be done from spi_nor_probe() after mtd_device_register() with
> some spimem handler using the 'struct mtd_partition' for the {size,offset}
> parameters.

Hmm, yes but I've got this feedback from multiple people that we should 
not do the calibration after mtd_device_register() since at that point 
the device is usable from userspace. Maybe we can come up with an API 
from MTD parsers that can just return us a list of partitions but not 
actually register them?

> 
> > > 
> > > > But I am planning to use device tree to get that information now so this
> > > > should no longer be needed and we can do calibration before registering
> > > > the device with MTD.
> > > 
> > > Perfect, we can move the calibration hook in spi_nor_create_read_dirmap()
> > > then, or in devm_spi_mem_dirmap_create(), which would make more sense IMHO.
> > 
> > Sorry, I still don't get why you want to tie dirmap and calibration
> > together. Just let them be independent and let flash drivers take care
> > of when to call what. SPI MEM should not care.
> 
> I know you would prefer a specific handler and that can still be done.
> 
> Thanks,
> 
> C.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
