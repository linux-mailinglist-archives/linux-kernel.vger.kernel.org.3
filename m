Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7CB518527
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 15:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235913AbiECNMz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 09:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235903AbiECNMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 09:12:51 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928E12B270;
        Tue,  3 May 2022 06:09:19 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 243D98ZI015600;
        Tue, 3 May 2022 08:09:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651583348;
        bh=+NJWeR2yAoBQ4gOXBumJ8EELuBtqDItb0MKtfFopUbs=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Ovg5r4eKf5S9YAsVU+RRnJYo/iNXNe3beD3nkKDieeUNQ5zqjajoOPFBKH/NwkBCh
         xSWKRvIr21et/UvuO98a38LGOijozwf2pgmIhMB4LxXgoBl7mlaklH9vxaaV9CXKJ3
         +wf9yoGToYCGTa6WTLccuur6O03oZcddnBMnTCIk=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 243D98LW028230
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 May 2022 08:09:08 -0500
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 3
 May 2022 08:09:07 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 3 May 2022 08:09:07 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 243D97AM049057;
        Tue, 3 May 2022 08:09:07 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Dave Gerlach <d-gerlach@ti.com>,
        Drew Fustini <dfustini@baylibre.com>
CC:     Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: (subset) [PATCH v3 0/2] soc: ti: wkup_m3_ipc: support i2c voltage scaling
Date:   Tue, 3 May 2022 08:09:06 -0500
Message-ID: <165158334205.6551.12979681952730458038.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220426200741.712842-1-dfustini@baylibre.com>
References: <20220426200741.712842-1-dfustini@baylibre.com>
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

Hi Drew Fustini,

On Tue, 26 Apr 2022 13:07:40 -0700, Drew Fustini wrote:
> Allow loading of a binary file containing i2c scaling sequences to be
> provided to the Cortex-M3 firmware in order to properly scale voltage
> rails on the PMIC during low power modes like DeepSleep0.
> 
> The 'firmware-name' property which contains the name of a binary file.
> 
> A prerequisite for this series is:
> [PATCH v3 0/2] soc: ti: wkup_m3_ipc: Add support for IO Isolation
> https://lore.kernel.org/linux-devicetree/20220414192722.2978837-1-dfustini@baylibre.com/
> 
> [...]

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[2/2] soc: ti: wkup_m3_ipc: Add support for i2c voltage scaling
      commit: ea082040fe071d2ba1f8f73792743d7ca9fb218e

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

