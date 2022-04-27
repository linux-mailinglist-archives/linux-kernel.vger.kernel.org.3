Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B9725110F0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 08:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358001AbiD0GOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 02:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357993AbiD0GOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 02:14:04 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FB8275D4;
        Tue, 26 Apr 2022 23:10:52 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23R6Aiuo031644;
        Wed, 27 Apr 2022 01:10:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651039844;
        bh=kXpnKZPSd6Bc0SfVzhPyIFl8QKwcMhZDEyWtuIqi54E=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=KwtrjDd/13hHI7TIVMv0mLGdXGutEAbvgJt+w4Fae/1cd12Vzb7/Id8395na24KAG
         bQn/40MjWXUtsIC9oKUsFffF0TX3y2HT1Ys6MPrFYTHr9MWUuYkrggmZzxNZ9oCuxx
         w2rUtxKsP2ch7075WEbT7Rq287vp21KSjkFBRpXA=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23R6Ai5b116236
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Apr 2022 01:10:44 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 27
 Apr 2022 01:10:43 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 27 Apr 2022 01:10:43 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23R6Ahi4130008;
        Wed, 27 Apr 2022 01:10:43 -0500
Date:   Wed, 27 Apr 2022 11:40:42 +0530
From:   Pratyush Yadav <p.yadav@ti.com>
To:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
CC:     Mark Brown <broonie@kernel.org>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ramuthevar Vadivel Murugan 
        <vadivel.muruganx.ramuthevar@linux.intel.com>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] spi: cadence-quadspi: drop cqspi_set_protocol()
Message-ID: <20220427061042.6xmzg7i6ozhlbhzi@ti.com>
References: <20220420155616.281730-1-matthias.schiffer@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220420155616.281730-1-matthias.schiffer@ew.tq-group.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/22 05:56PM, Matthias Schiffer wrote:
> As suggested, this removes the whole cqspi_set_protocol() function, as it
> is not actually needed:
> 
> - Checks for unsupported operations are already handled by supports_op(),
>   removing the need to distinguish DTR and non-DTR modes in the buswidth
>   setup
> - supports_op() ensures that the DTR flags match for all relevant parts of
>   an operation, so op->cmd.dtr can be used instead of copying the flag to
>   the cqspi_flash_pdata
> - The logic in cqspi_set_protocol() is moved to cqspi_calc_rdreg() and
>   cqspi_write_setup() (with a helper macro CQSPI_OP_WIDTH())
> 
> The helper macro checks nbytes instead of buswidth for 0, for consistency
> with supports_op() etc.
> 
> Suggested-by: Pratyush Yadav <p.yadav@ti.com>
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

I know the patch has already been applied, but FWIW,

Reviewed-by: Pratyush Yadav <p.yadav@ti.com>

Also did some basic testing on the latest linux-next, which has your 
patches. Things seem to work fine.

-- 
Regards,
Pratyush Yadav
Texas Instruments Inc.
