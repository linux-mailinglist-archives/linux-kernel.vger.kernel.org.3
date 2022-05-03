Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDC53518529
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 15:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235923AbiECNNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 09:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232644AbiECNNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 09:13:14 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF8A42B259;
        Tue,  3 May 2022 06:09:41 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 243D8ux6043001;
        Tue, 3 May 2022 08:08:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651583336;
        bh=3vIShAAoNpZLtMZtd0E1uDb7nunSsqnUnysIieloaUw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=FawXVzieqpKrR+PRu9xRSx1l1CLani8PFnfCochOQXzdHQrC/eZZGn/5NOQBImvES
         VRis9xQZ5doy/zqNikcekh/Fez4L1AkSur1urCHCthQ/PLvUe9TGjZgSgKSzbqso0x
         BSJ5vcKbpQQ1Eqe51rrovkVvIT2e5aA+AVFbtRXk=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 243D8ueH082277
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 3 May 2022 08:08:56 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 3
 May 2022 08:08:55 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 3 May 2022 08:08:55 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 243D8tUN096341;
        Tue, 3 May 2022 08:08:55 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Santosh Shilimkar <ssantosh@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Drew Fustini <dfustini@baylibre.com>
CC:     Nishanth Menon <nm@ti.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>
Subject: Re: (subset) [PATCH v3 0/2] soc: ti: wkup_m3_ipc: Add support for IO Isolation
Date:   Tue, 3 May 2022 08:08:54 -0500
Message-ID: <165158332118.6421.15725754853562188300.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220414192722.2978837-1-dfustini@baylibre.com>
References: <20220414192722.2978837-1-dfustini@baylibre.com>
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

On Thu, 14 Apr 2022 12:27:22 -0700, Drew Fustini wrote:
> TI AM437x SoCs support isolation of the IOs so that control is taken
> from the peripheral they are connected to and overridden by values
> present in the control register for that pad. This series documents a
> new property 'ti,set-io-isolation' and updates the wkup_m3_ipc driver to
> inform the CM3 firmware when that property is set.
> 
> A prerequisite for this series is:
> [PATCH v2 0/2] soc: ti: wkup_m3_ipc: support vtt toggle
> https://lore.kernel.org/lkml/20220409211215.2529387-1-dfustini@baylibre.com/T/
> 
> [...]

I have applied the following to branch ti-drivers-soc-next on [1].
Thank you!

[2/2] soc: ti: wkup_m3_ipc: Add support for IO Isolation
      commit: 1dcbae86ee669bdb0338954cd0136863f5c96c0a

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

