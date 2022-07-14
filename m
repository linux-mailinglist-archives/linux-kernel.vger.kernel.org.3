Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A73B574B85
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 13:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbiGNLID (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 07:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229666AbiGNLIB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 07:08:01 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9F56163;
        Thu, 14 Jul 2022 04:08:01 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 26EB7plu090790;
        Thu, 14 Jul 2022 06:07:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657796871;
        bh=p7pqq2g8/Wby+2K8I1+/FwfIeNjPoy6Wx6KoZD17UX0=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=S90nZq5HNvlqK1P43SUIumnzYKKRkK/yc6yy2NbjmaZT16ZlmoWPMDWXvKtIBlp5a
         X8ov1ZVvQz+h00IChm4LT1d/AQ4qrhUbrQkDw7j3iM4uKjPDmwcR+Rvk6ap8U0ajrC
         eVKOARqsfM9U8aWkAW1or4ZmXoAv37QVR9DUxtSY=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 26EB7pVe019466
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 14 Jul 2022 06:07:51 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 14
 Jul 2022 06:07:50 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 14 Jul 2022 06:07:50 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 26EB7oXs021273;
        Thu, 14 Jul 2022 06:07:50 -0500
Date:   Thu, 14 Jul 2022 16:37:49 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Mark Brown <broonie@kernel.org>
CC:     <vaishnav.a@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <vigneshr@ti.com>
Subject: Re: [PATCH -next] spi: cadence-quadspi: Remove spi_master_put() in
 probe failure path
Message-ID: <20220714110749.ee5r4hznjn3ij66s@ti.com>
References: <20220601071611.11853-1-vaishnav.a@ti.com>
 <165459880689.302078.15844858048042907353.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <165459880689.302078.15844858048042907353.b4-ty@kernel.org>
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

Hi Mark,

On 07/06/22 11:46AM, Mark Brown wrote:
> On Wed, 1 Jun 2022 12:46:11 +0530, Vaishnav Achath wrote:
> > Currently the spi_master is allocated by devm_spi_alloc_master()
> > and devres core manages the deallocation, but in probe failure
> > path spi_master_put() is being handled manually which causes
> > "refcount underflow use-after-free" warning when probe failure happens
> > after allocating spi_master.
> > 
> > Trimmed backtrace during failure:
> > 
> > [...]
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next

I see this error in v5.19-rc6 as well. Can we get this patch merged as a 
fix in rc7? Sorry for spotting this so late in the cycle, but I thought 
you had already got this merged in one of the rcs.

> 
> Thanks!
> 
> [1/1] spi: cadence-quadspi: Remove spi_master_put() in probe failure path
>       commit: 8523c96894e916b20ba3612e48e404fad5acfdd9
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent to Linus during
> the next merge window (or sooner if it is a bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> Thanks,
> Mark

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
