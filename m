Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66A03502F7F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 22:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350865AbiDOUIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 16:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349803AbiDOUIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 16:08:51 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93164AF1C0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 13:06:22 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23FK6Gsb032405;
        Fri, 15 Apr 2022 15:06:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650053176;
        bh=q35Q+zTatXelDL+Cqd9qrSdJFvS6gynC+iWXI8GiVz4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=BdSgTE/MCUQ09XOHTNoz+yJiHuAg1auEx5/Ga+PnJzqg04FVKWqCqC3S0p3f5YPro
         txXI9tNhvWUH7ct0izn8vPjgDyEkTq3wVNlEYYxxV+ij2rfHtcSZ9EqLiSZbEgjHvt
         DA28ElducLkdXpcj6KUCjGF3+cE5U4okqjA3KwYQ=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23FK6FCP032458
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 15 Apr 2022 15:06:15 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 15
 Apr 2022 15:06:15 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 15 Apr 2022 15:06:15 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23FK6FZ5018018;
        Fri, 15 Apr 2022 15:06:15 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <cgel.zte@gmail.com>
CC:     Nishanth Menon <nm@ti.com>, Zeal Robot <zealci@zte.com.cn>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Minghao Chi <chi.minghao@zte.com.cn>, <ssantosh@kernel.org>
Subject: Re: [PATCH] soc: ti: knav_dma: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Fri, 15 Apr 2022 15:06:14 -0500
Message-ID: <165005314169.9689.12736994224475831709.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220412082923.2532649-1-chi.minghao@zte.com.cn>
References: <20220412082923.2532649-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

Hi cgel.zte@gmail.com,

On Tue, 12 Apr 2022 08:29:23 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get is more appropriate
> for simplifing code
> 
> 

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] soc: ti: knav_dma: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      commit: d3e3116f253591a473873fab8363ecb998ddde13

(Minor $subject cleanup and commit message spell fixup)

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D

