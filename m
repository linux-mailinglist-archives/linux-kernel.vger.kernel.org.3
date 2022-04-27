Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 439EA5113F8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 11:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230173AbiD0JDC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 05:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiD0JC6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 05:02:58 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2D91EE8BD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 01:59:43 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23R8xRXh077668;
        Wed, 27 Apr 2022 03:59:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651049967;
        bh=/JsFpmWyyIBVaFbOoYwRRqvXrsPjhVSVjKC+q6PG1vA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=BtXaVlWbkMaAIOGrYeP2rLLGcbXDwZi1bNXRQyOU/Cw3LcZXW+/cxBzIyGd3R/8wK
         mK0GBPVVDDPfrvL6NoDiFxKLRUcThTSeluLC+f5wUvgfvwCDeNWHNdAowc4S8tx29t
         rA/0XtMYSp71XR2cNgRiO7fmgQSbBsUQ2LyOYA+4=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23R8xROf025164
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Apr 2022 03:59:27 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 27
 Apr 2022 03:59:26 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 27 Apr 2022 03:59:26 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23R8xPad030273;
        Wed, 27 Apr 2022 03:59:26 -0500
Date:   Wed, 27 Apr 2022 14:29:25 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <chentsung@chromium.org>, <michael@walle.cc>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [RESEND PATCH] mtd: spi-nor: core: Check written SR value in
 spi_nor_write_16bit_sr_and_check()
Message-ID: <20220427085925.wlmsnr7qgi5wteod@ti.com>
References: <20220126073227.3401275-1-chentsung@chromium.org>
 <20220131171929.uk3z5sr453c3eefp@ti.com>
 <0e02112a-317c-e95b-e0d3-7ed2c74c3509@microchip.com>
 <c6b2956d-85f6-19c3-4282-23a72a1b5849@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c6b2956d-85f6-19c3-4282-23a72a1b5849@microchip.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/22 07:14AM, Tudor.Ambarus@microchip.com wrote:
> On 4/27/22 10:11, Tudor Ambarus wrote:
> > On 1/31/22 19:19, Pratyush Yadav wrote:
> >> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >>
> >> On 26/01/22 03:32PM, Chen-Tsung Hsieh wrote:
> >>> Read back Status Register 1 to ensure that the written byte match the
> >>> received value and return -EIO if read back test failed.
> >>>
> >>> Without this patch, spi_nor_write_16bit_sr_and_check() only check the
> >>> second half of the 16bit. It causes errors like spi_nor_sr_unlock()
> >>> return success incorrectly when spi_nor_write_16bit_sr_and_check()
> >>> doesn't write SR successfully.
> >>>
> 
> cc to stable please

Since this has the Fixes tag, once the patch hits the MTD tree stable 
should pick it up right?

> 
> >>> Fixes: 39d1e3340c73 ("mtd: spi-nor: Fix clearing of QE bit on lock()/unlock()")
> >>> Signed-off-by: Chen-Tsung Hsieh <chentsung@chromium.org>
> >>
> >> I don't know much about this bit of code but this patch looks fine to me
> >> from the surface. Would be nice to hear from Tudor about this too since
> >> he added the function.
> > 
> > Reviewed-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> >>
> >> Acked-by: Pratyush Yadav <p.yadav@ti.com>
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
