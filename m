Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65CE148A772
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 06:51:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347323AbiAKFvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 00:51:35 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:59572 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347288AbiAKFve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 00:51:34 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20B5pBaX063299;
        Mon, 10 Jan 2022 23:51:11 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1641880271;
        bh=0fW3jwGVa1LJO5zm4tAXz+1RoUDB7y7Tbg485ljzd0o=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=GO9UWxkhjJ6wmPJymjJpVUcqStfcgmEEzMKLxPkVyXPBliACbLT6eoAt9ZX+qIcDo
         /4HbkNHhN+VZrPfB8rqhKWbXzix+mvemVgU0ezcQf8LuAqcuyIADz9zPmal3v7z18i
         xYSydtfeg/lZr+9cbG3oU+3JAmwroXqvWk7ySPpw=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20B5pB57042791
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 10 Jan 2022 23:51:11 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 10
 Jan 2022 23:51:11 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 10 Jan 2022 23:51:11 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20B5pApM023051;
        Mon, 10 Jan 2022 23:51:11 -0600
Date:   Tue, 11 Jan 2022 11:21:09 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Dhananjay Phadke <dphadke@linux.microsoft.com>
CC:     Michael Walle <michael@walle.cc>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mtd: spi-nor: Add support for w25q512jvm
Message-ID: <20220111055107.tevqpnt32mzjodok@ti.com>
References: <20220109044418.4657-1-dphadke@linux.microsoft.com>
 <262a03e185c29583450180e3dc8c4e6c@walle.cc>
 <57513f5f-1e66-3758-a56b-1eced486a4df@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <57513f5f-1e66-3758-a56b-1eced486a4df@linux.microsoft.com>
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/22 03:12PM, Dhananjay Phadke wrote:
> On 1/10/2022 7:10 AM, Michael Walle wrote:
> > 
> > > +    { "w25q512jvm", INFO(0xef7020, 0, 64 * 1024, 1024),
> > 
> > OTP_INFO(256, 3, 0x1000, 0x1000)
> > 
> > should enable OTP support, could you please test this using the
> > flash_otp_{dump,info,erase,write} tools and add that line?
> 
> The board I've has HW filter between controller and NOR and doesn't seem to
> allow security reg access opcodes (read to be specific).
> 
> So long as adding this doesn't affect probe, I can add it. Otherwise, will
> have to leave it for later when that's fixed.

Please don't it if you can't test it. In that case let's just leave it 
for someone else to add later.

> 
> 
> On 1/9/2022 9:07 PM, Pratyush Yadav wrote:
> > 
> > You need to show the dumps of the SFDP and other flash parameters. See
> > [0] for an example.
> > 
> > The patch looks fine to me otherwise.
> > 
> 
> Lemme collect SFDP dump and include it in v2.
> I ended up sending stale patch that has extra comma between INFO()
> PARSE_SFDP macros, so need to re-spin anyway.
> 
> Thanks,
> Dhananjay

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
