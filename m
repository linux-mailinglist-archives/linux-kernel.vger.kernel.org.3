Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C121C504DFF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 10:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbiDRIsn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 04:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbiDRIsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 04:48:41 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E87F17058
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 01:46:02 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23I8jeOL065277;
        Mon, 18 Apr 2022 03:45:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650271540;
        bh=+U6Hu+9lZI/gVP37GKxe1CGnlGr3BPUFHc06XHPe+Yc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=R4fKlmyi2Jp/L/nnOaeYRVbOoQMpB/SkyqfU4o6LfNv3s1cNHTT7ArtiQ3ZYyx0W6
         rMuTciU+5JsNaqtFlc4k1r52aS57XL15elfJXzwKnd6yJ5FPKrEg5TwSBtOq3U6dsH
         fMTm2MCFVcZXS8V8pNeopai8NAKZiQ1ithKDNP8w=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23I8jee6009519
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Apr 2022 03:45:40 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 18
 Apr 2022 03:45:39 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 18 Apr 2022 03:45:39 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23I8jd8v008590;
        Mon, 18 Apr 2022 03:45:39 -0500
Date:   Mon, 18 Apr 2022 14:15:38 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <michael@walle.cc>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Nicolas.Ferre@microchip.com>
Subject: Re: [PATCH v3 3/3] mtd: spi-nor: Favor the BFPT-parsed
 set_4byte_addr_mode method
Message-ID: <20220418084538.ccvqhbik6a7ffz5j@ti.com>
References: <20220411125346.118274-1-tudor.ambarus@microchip.com>
 <20220411125346.118274-4-tudor.ambarus@microchip.com>
 <a6519a1ce39534c35760334cd69396b3@walle.cc>
 <2c77371b-355a-5a1a-a83d-7bf40b088683@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2c77371b-355a-5a1a-a83d-7bf40b088683@microchip.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/22 09:32AM, Tudor.Ambarus@microchip.com wrote:
> On 4/14/22 12:21, Michael Walle wrote:
> >> +static void macronix_nor_late_init(struct spi_nor *nor)
> >> +{
> >> +     if (!nor->params->set_4byte_addr_mode)
> >> +             nor->params->set_4byte_addr_mode =
> >> +                     spi_nor_set_4byte_addr_mode_en4b_ex4b;
> > 
> > This is more of a general question. Can we have this in one
> > line? IMHO this looks awful and since linux nowadays relaxed the
> > 80 chars rule a bit and we have such long names.. I think it makes
> > sense to allow some lines to be longer than 80 chars.
> 
> I still split my terminal in multiple windows and pretty much read
> code in a 80 chars limit. But I won't argue with you, it seems you
> care about it, so I'll change it.

FWIW, I do the same. I won't like it much if line lengths get too long. 
I won't take any sides here though, either should be fine as long as the 
result at least fits in 100 chars.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
