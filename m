Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF5E4D6808
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 18:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350677AbiCKRtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 12:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348199AbiCKRsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 12:48:50 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1140143381;
        Fri, 11 Mar 2022 09:47:41 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22BHlDXT021105;
        Fri, 11 Mar 2022 11:47:13 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1647020833;
        bh=pdP+i9m2lw1qpqeGFBrxp+l79uJC+mKNJuBzp+PYH+8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=aRiuC3tc34x7CtK/Tz9/INvJh3X3MRMjZrXxbp1LrtQPZs1uQq52SBK5vlOIOsq2d
         aP+PwInlCWjivPgYud86F5xtAeSGGy5rVswtp4YJWBMVxIofOh74yOcJHW9C+VzPKe
         KI1eyO+dAQwGRUNwI+9ywSNIshSEa27vjd14vW1w=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22BHlDtl116195
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 11 Mar 2022 11:47:13 -0600
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 11
 Mar 2022 11:47:12 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 11 Mar 2022 11:47:12 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22BHlBZx049523;
        Fri, 11 Mar 2022 11:47:12 -0600
Date:   Fri, 11 Mar 2022 23:17:11 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     <Tudor.Ambarus@microchip.com>
CC:     <michael@walle.cc>, <broonie@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <zhengxunli@mxic.com.tw>, <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH 1/4] spi: spi-mem: Allow specifying the byte order in DTR
 mode
Message-ID: <20220311174711.wexljqvqx6cgmeub@ti.com>
References: <20220218145900.1440045-1-tudor.ambarus@microchip.com>
 <20220218145900.1440045-2-tudor.ambarus@microchip.com>
 <20220302100255.gseqjbdyxrgmt3zf@ti.com>
 <f0501c29-ae70-185d-8f40-4a249e49575e@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f0501c29-ae70-185d-8f40-4a249e49575e@microchip.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03/22 05:31AM, Tudor.Ambarus@microchip.com wrote:
> On 3/2/22 12:02, Pratyush Yadav wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> > 
> > Hi Tudor,
> 
> Hi, Pratyush,
> 
> > 
> > I'm reviewing the code here. I still have not thought through the
> > discussion about Kconfig option yet.
> > 
> > On 18/02/22 04:58PM, Tudor Ambarus wrote:
> >> There are NOR flashes (Macronix) that swap the bytes on a 16-bit boundary
> >> when configured in DTR mode. The byte order of 16-bit words is swapped
> > 
> > s/DTR mode/ Octal DTR mode/
> > 
> > I don't think this would apply to a 4D-4D-4D flash since it would only
> > transmit one byte per clock cycle.
> 
> From what I see, flashes that claim "QPI DTR support" they actually support
> 4S-4D-4D. JESD251-1 talks about 4S-4D-4D too. So data is latched on both rising
> and falling edges of the clock. But I'm ok with your proposal because we don't
> have any proof if there are any QPI DTR flashes that swap bytes in DTR.

I think this problem fundamentally applies to Octal DTR and above (if 
there is ever 16-line DTR (hexadecimal DTR?) in the future). In your 4D 
data phase, you can only send _one_ byte per cycle. So the byte order 
inter-cycle does not matter as it does in 8D mode. Similarly, for a 
16-line STR this would also apply, since that has 2 bytes per cycle. For 
a 16-line DTR there are now 4 bytes per cycle and so on.

And the BFPT bit that you use to enable this swap also says "Byte order 
in 8D-8D-8D mode". So I really don't think it makes sense for QPI DTR.

> 
> > 
> >> when read or written in Double Transfer Rate (DTR) mode compared to
> >> Single Transfer Rate (STR) mode. If one writes D0 D1 D2 D3 bytes using
> >> 1-1-1 mode, and uses 8D-8D-8D SPI mode for reading, it will read back
> >> D1 D0 D3 D2. Swapping the bytes is a bad design decision because this may
> >> introduce some endianness problems. It can affect the boot sequence if the
> >> entire boot sequence is not handled in either 8D-8D-8D mode or 1-1-1 mode.
> >> Fortunately there are controllers that can swap back the bytes at runtime,
> >> fixing the endiannesses. Provide a way for the upper layers to specify the
> >> byte order in DTR mode.
> >>
> >> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> >> ---
> >>  include/linux/spi/spi-mem.h | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/include/linux/spi/spi-mem.h b/include/linux/spi/spi-mem.h
> >> index 85e2ff7b840d..e1878417420c 100644
> >> --- a/include/linux/spi/spi-mem.h
> >> +++ b/include/linux/spi/spi-mem.h
> >> @@ -89,6 +89,8 @@ enum spi_mem_data_dir {
> >>   * @dummy.dtr: whether the dummy bytes should be sent in DTR mode or not
> >>   * @data.buswidth: number of IO lanes used to send/receive the data
> >>   * @data.dtr: whether the data should be sent in DTR mode or not
> >> + * @data.dtr_bswap16: whether the byte order of 16-bit words is swapped when
> >> + *                 read or written in DTR mode compared to STR mode.
> >>   * @data.dir: direction of the transfer
> >>   * @data.nbytes: number of data bytes to send/receive. Can be zero if the
> >>   *            operation does not involve transferring data
> >> @@ -119,6 +121,7 @@ struct spi_mem_op {
> >>       struct {
> >>               u8 buswidth;
> >>               u8 dtr : 1;
> >> +             u8 dtr_bswap16 : 1;
> 
> but I would keep this name here as it is, without prepending octal.

I won't nitpick much on the member name as long as the comment 
describing its role is clear enough.

> 
> > 
> > You also need to add this capability to spi_controller_mem_caps and
> > update spi_mem_default_supports_op() to check for it.
> 
> sure, will do.
> 
> Thanks!
> ta
> > 
> >>               enum spi_mem_data_dir dir;
> >>               unsigned int nbytes;
> >>               union {
> >> --
> >> 2.25.1
> >>
> > 
> > --
> > Regards,
> > Pratyush Yadav
> > Texas Instruments Inc.
> 

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
