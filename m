Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1174FFD93
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237601AbiDMSOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiDMSOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:14:06 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C69136E0C;
        Wed, 13 Apr 2022 11:11:43 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23DIBaIs042051;
        Wed, 13 Apr 2022 13:11:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1649873496;
        bh=YqQ5rhFaUeIpx8tuzzpS1g5Fp/H5CjLBRHeqIyn+Wi0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=jiB1kSKVqqdFwHaPL0yEw+MBlOXKriOi6k0T/pibExHaE9uWWJBIPoQVIUkDnn3Nb
         BHCDucxff1xtEEpcssM21NG2fn5novsjea/qEIXPucM7AnUVmBj2ji1ErVb4kdwoHn
         WXQDV377Zm/tFrnNvz3siZE4QX1b2HAmjrJ+YUCE=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23DIBaPt009306
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 13 Apr 2022 13:11:36 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 13
 Apr 2022 13:11:36 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 13 Apr 2022 13:11:36 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23DIBZTt058236;
        Wed, 13 Apr 2022 13:11:35 -0500
Date:   Wed, 13 Apr 2022 23:41:34 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
CC:     Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] spi: cadence-quadspi: fix incorrect supports_op()
 return value
Message-ID: <20220413181134.izsam4fuogl6inbj@ti.com>
References: <20220406132832.199777-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220406132832.199777-1-matthias.schiffer@ew.tq-group.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/22 03:28PM, Matthias Schiffer wrote:
> Since the conversion to spi-mem, the driver advertised support for
> various operations that cqspi_set_protocol() was never expected to handle
> correctly - in particuar all non-DTR operations with command or address
> buswidth > 1. For DTR, all operations except for 8-8-8 would fail, as
> cqspi_set_protocol() returns -EINVAL.
> 
> In non-DTR mode, this resulted in data corruption for SPI-NOR flashes that
> support such operations. As a minimal fix that can be backported to stable
> kernels, simply disallow the unsupported operations again to avoid this
> issue.
> 
> Fixes: a314f6367787 ("mtd: spi-nor: Convert cadence-quadspi to use spi-mem framework")
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

I suppose it is too late now since the patch is already applied. But 
FWIW,

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
