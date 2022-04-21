Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C81D45098CE
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385600AbiDUHN5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239658AbiDUHNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:13:53 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C203C140DC;
        Thu, 21 Apr 2022 00:11:04 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23L7Aw1B035971;
        Thu, 21 Apr 2022 02:10:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650525058;
        bh=n+5mdjCoCf0ii1KcjNSILRnfR+lLzv1OJKI293EFGy8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=oKyy2mWYUcwJx9cMCyiVlOl8RUv/ToL5I3DBUZYFjWRhj/CE7mXCpgAViVzG0T4um
         Z34fZSatjDkOVR4N10kArIbqt2cHc5f605eRJC3L1Zr/LwM9z9t8gAgjRASUAhbo9b
         sZHxDTYCuYAHMC03PZjGRXiFVIzPpGwyEVuYMZlw=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23L7AwYN124547
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Apr 2022 02:10:58 -0500
Received: from DFLE107.ent.ti.com (10.64.6.28) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 21
 Apr 2022 02:10:58 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE107.ent.ti.com
 (10.64.6.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 21 Apr 2022 02:10:58 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23L7Av0s070769;
        Thu, 21 Apr 2022 02:10:57 -0500
Date:   Thu, 21 Apr 2022 12:40:56 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Takahiro Kuwano <tkuw584924@gmail.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] spi: spi-mem: check if data buffers are on stack
Message-ID: <20220421071056.4o33vlhoqarod3ow@ti.com>
References: <20220420102022.3310970-1-p.yadav@ti.com>
 <YmAE2IVRgPyWxmbn@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YmAE2IVRgPyWxmbn@sirena.org.uk>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/22 02:04PM, Mark Brown wrote:
> On Wed, Apr 20, 2022 at 03:50:22PM +0530, Pratyush Yadav wrote:
> > The buffers passed in the data phase must be DMA-able. Programmers often
> > don't realise this requirement and pass in buffers that reside on the
> > stack. This can be hard to spot when reviewing code. Reject ops if their
> > data buffer is on the stack to avoid this.
> > 
> > Signed-off-by: Pratyush Yadav <p.yadav@ti.com>
> > Acked-by: Mark Brown <broonie@kernel.org>
> > ---
> > 
> > Changes in v2:
> > - Include task_stack.h. It might not get included indirectly on some
> >   platforms and can cause build failures.
> > - Add a WARN_ON_ONCE() for debuggability.
> > - Add Mark's Ack.
> 
> Since this is now an isolated patch does that mean whatever meant that I
> acked rather than applying this patch has gone in and I can now apply it
> directly?

Yes, you should be able to apply it directly. Miquel's spi-mem-ecc 
branch is now in 5.18-rc1 and later. Though this patch never conflicted 
with that branch to begin with. The spi-mem-ecc branch does not touch 
spi_mem_check_op() as far as I can see.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
