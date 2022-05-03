Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3FB518522
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 15:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbiECNMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 09:12:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbiECNL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 09:11:59 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 382962B254
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 06:08:23 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 243D8A9H042407;
        Tue, 3 May 2022 08:08:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651583290;
        bh=+PjDdN/NWid9naOrdEqrBg84dmGSmnwHbEYyAYI+SOc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=vxyqyrHs+Bd7MQCyq/cmxXbIC+/gEKwDjDT2BfsC0j3DwNeGFwNEf17S4eGGh9L5E
         zrd5LNI9mJpfATLnCOOPvtLg2IibuDKMGNJV4EBsrDwh4Nn3m72jMxr6EUJqPGyHmd
         p7YSxkrt4kEIiHYcg90aUal1mroYQRuZ2M1QJ6aU=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 243D8AUa083789
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 May 2022 08:08:10 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 3
 May 2022 08:08:10 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 3 May 2022 08:08:10 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 243D8A2Z010119;
        Tue, 3 May 2022 08:08:10 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <cgel.zte@gmail.com>
CC:     Nishanth Menon <nm@ti.com>, Zeal Robot <zealci@zte.com.cn>,
        <linux-kernel@vger.kernel.org>,
        Minghao Chi <chi.minghao@zte.com.cn>,
        <linux-arm-kernel@lists.infradead.org>, <ssantosh@kernel.org>
Subject: Re: [PATCH] soc: ti: pm33xx: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
Date:   Tue, 3 May 2022 08:08:09 -0500
Message-ID: <165158328285.6255.11257896409414961807.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220418063059.2558074-1-chi.minghao@zte.com.cn>
References: <20220418063059.2558074-1-chi.minghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

Hi cgel.zte@gmail.com,

On Mon, 18 Apr 2022 06:30:59 +0000, cgel.zte@gmail.com wrote:
> From: Minghao Chi <chi.minghao@zte.com.cn>
> 
> Using pm_runtime_resume_and_get is more appropriate
> for simplifing code
> 
> 

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[1/1] soc: ti: pm33xx: using pm_runtime_resume_and_get instead of pm_runtime_get_sync
      commit: 2b7042500cab7952bdbf4fe4a84de8712b418c36

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

