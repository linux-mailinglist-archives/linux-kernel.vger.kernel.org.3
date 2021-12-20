Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09C747A877
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 12:18:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231630AbhLTLSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 06:18:43 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52520 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbhLTLSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 06:18:42 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 1BKBIU8B005960;
        Mon, 20 Dec 2021 05:18:30 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1639999110;
        bh=aM+DkVdHhah+ozhy7i5sI/2zcufpmw4b8BATTNe7JGc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=noE1RkT0c916jEJAV/NOTIl9tubZyB7VyT8gOBwN6if0Zx/MUJ3JSi2Tt6ZRpemrg
         8gdqUp8/m7iA9UtpuVcSiKaK4O+YHIAK7y/yCCf3gE7slo856OuUhE5KqyOqWhV2YZ
         0Bx4J7ji1sqBafJvPThE25Kb6GjIl0I17tdScr4o=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 1BKBIU99036571
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Dec 2021 05:18:30 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 20
 Dec 2021 05:18:30 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 20 Dec 2021 05:18:30 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 1BKBITxp081660;
        Mon, 20 Dec 2021 05:18:30 -0600
Date:   Mon, 20 Dec 2021 16:48:29 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH v5 2/2] mtd: spi-nor: macronix: Add support for
 mx66lm1g45g
Message-ID: <20211220111827.m7cymttlgmpnyejb@ti.com>
References: <20211217180601.585825-1-tudor.ambarus@microchip.com>
 <20211217180601.585825-2-tudor.ambarus@microchip.com>
 <20211220102514.bnws67ks5uia5yfh@ti.com>
 <213719a3-ed81-b1c6-9c9e-85dbeee85ff5@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <213719a3-ed81-b1c6-9c9e-85dbeee85ff5@microchip.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/12/21 11:10AM, Tudor.Ambarus@microchip.com wrote:
> On 12/20/21 12:25 PM, Pratyush Yadav wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Hi Tudor,
> > 
> > On 17/12/21 08:06PM, Tudor Ambarus wrote:
> >> mx66lm1g45g supports just 1-1-1, 8-8-8 and 8D-8D-8D modes. There are
> >> versions of mx66lm1g45g which do not support SFDP, thus use
> >> SPI_NOR_SKIP_SFDP. The RDID command issued through the octal peripheral
> >> interface outputs data always in STR mode for whatever reason. Since
> >> 8D-8D-8S is not common, avoid reading the ID when enabling the octal dtr
> >> mode. Instead, read back the CR2 to check if the switch was successful.
> > 
> > I replied to your v2 just now about this.
> > 
> >> Tested in 1-1-1 and 8d-8d-8d modes using sama7g5 QSPI IP.
> > 
> > Link to datasheet in the commit message would be nice.
> 
> Do you know if there's a standardized way to add a link to a datasheet
> in the commit message, i.e. should I use the Link tag or just a simple
> link will do?

I don't know if there is. Something like "Datasheet: <link>" should be 
fine I think.

> > 
> > As discussed on IRC, this flash reverses byte order in 8D-8D-8D mode. So
> > the data you write in 1S-1S-1S mode will be have byte order reversed
> > when reading in 8D-8D-8D mode. Do you have any plans on doing something
> > for this? Or do we just leave it to the user to figure it out?
> 
> I don't think we should amend this in software. Reading/writing in
> 8D-8D-8D will give sane results, the problem is just when you
> use STR for write and DTR for read, or viceversa. This is just a bad
> design and we should leave it as it is.

Sounds good to me.

> 
> I'll address all your other comments in a v6. Thanks.
> ta

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
