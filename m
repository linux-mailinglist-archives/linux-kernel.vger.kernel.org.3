Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E982463043
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 10:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240448AbhK3JyB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 04:54:01 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:34454 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240421AbhK3Jxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 04:53:39 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1AU9o01L083094;
        Tue, 30 Nov 2021 03:50:00 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1638265800;
        bh=7xhhlicdSvFPl57W3W68n3eLENoVyST+z3lW9HfMOQM=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=KDgRXyqfU5+r5knpQEzz5dbKAphannLIuJQo+fgKFIst+mcF+gZ7txBYnJqzzkjpF
         jETpBSlYeQu5TPwWrVLssbuzP5qG/mqvKfdToUd4Dlt/Z7kqJmAz+j/J60IHdUZr25
         hdMsQv867bhrebxQuRBNUFyQc3YCCDSvssMrKAqs=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1AU9o0dx104790
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Nov 2021 03:50:00 -0600
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 30
 Nov 2021 03:50:00 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 30 Nov 2021 03:50:00 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1AU9nxVX077201;
        Tue, 30 Nov 2021 03:49:59 -0600
Date:   Tue, 30 Nov 2021 15:19:58 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
CC:     Michael Walle <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: mt25qu: Ignore 6th ID byte
Message-ID: <20211130094956.h7mpaucciam2taco@ti.com>
References: <20211119080402.20262-1-alexander.sverdlin@nokia.com>
 <9a158e2ef6635212c1e353590e3b773b@walle.cc>
 <1e133bc6-5edb-c4ce-ad44-3de77048acf2@nokia.com>
 <e9589af968d7b9dafbce17325dbf8472@walle.cc>
 <85251c3b-13c1-8b24-0ce2-6793ea55e39a@nokia.com>
 <20211123174206.bzh5yq2f7sgkqpmi@ti.com>
 <8742b6e8-c26e-47d7-0b77-67137d3de10f@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <8742b6e8-c26e-47d7-0b77-67137d3de10f@nokia.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/21 08:26AM, Alexander Sverdlin wrote:
> Hi Pratyush,
> 
> thanks for the quick reply!
> 
> On 23/11/2021 18:42, Pratyush Yadav wrote:
> >> In my opinion, as I look into Micron or Macronix datasheets, write_proto has little to
> >> do with erase_proto. (there is currently no separate erase_proto)
> > I think this just worked for most flashes since both writes and erases 
> > generally use 1-bit mode. 4 or 8 bit modes are generally used for reads 
> > only.
> > 
> >> Before I come up with a totally wrong patch, wanted to ask your opinion, how should
> >> it be solved, what do you think?
> >>
> >> I do not see any erase-related tables for this in JESD216C.
> >> I also cannot come up with an example of a chip with erase != 1-1-0.
> > See Micron MT35XU512ABA or Cypress S28HS512T (in spansion.c). Both have 
> > erase in 8D-8D-8D mode.
> > 
> >> Shall I hardcode 1-1-0 for erase?
> >> Shall I introduce erase_proto? What would be the logic for its setting/discovery?
> > I think introducing erase_proto would be the sensible thing. You would 
> > have to see if we can discover erase protocol from SFDP. But my question 
> > is: is that really worth it? Do you really need that little bit speed 
> > boost you'd get by transmitting write data in 4 bit mode, since the 
> > large portion of the time would be spent in the chip actually flashing 
> > the data.
> 
> The problem I have is not speed, but totally not working erase. And I don't want
> to downgrade write functionality for other chips.

Then you need to introduce erase_proto.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
