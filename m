Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9606F55022D
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 04:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383963AbiFRCx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 22:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbiFRCxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 22:53:54 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CE12FFCD;
        Fri, 17 Jun 2022 19:53:53 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25I2rksj077003;
        Fri, 17 Jun 2022 21:53:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655520826;
        bh=m1DJSOYksRV0fWe0v7pNOCdXuzAmtTzTZveQ0gOcdnI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=I2sd+puqjt/SILepn2cbtLIIPEfAJPr8ahH4JgQ5D5/1T6rOjG6mSbehEp6qfudiC
         SVOehUFHhZVyMERHnW48N2qnPC9XBmrg6KJc1FM2/HKqXzG+YR/z5/3X1jNKLtrnXb
         97vkWwePNQCmwSSNxmh8f7NrQVj0+LwZrcNmtxps=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25I2rkM4003647
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Jun 2022 21:53:46 -0500
Received: from DLEE103.ent.ti.com (157.170.170.33) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 17
 Jun 2022 21:53:46 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 17 Jun 2022 21:53:46 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25I2rkXg118886;
        Fri, 17 Jun 2022 21:53:46 -0500
From:   Nishanth Menon <nm@ti.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <mranostay@ti.com>,
        <linux-kernel@vger.kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <maz@kernel.org>,
        <linux-stable@vger.kernel.org>, <robin.murphy@arm.com>
Subject: Re: [PATCH v3] arm64: dts: ti: k3-j721s2: fix overlapping GICD memory region
Date:   Fri, 17 Jun 2022 21:53:43 -0500
Message-ID: <165552079466.27929.4149556071528668326.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220617151304.446607-1-mranostay@ti.com>
References: <20220617151304.446607-1-mranostay@ti.com>
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

Hi Matt Ranostay,

On Fri, 17 Jun 2022 08:13:04 -0700, Matt Ranostay wrote:
> GICD region was overlapping with GICR causing the latter to not map
> successfully, and in turn the gic-v3 driver would fail to initialize.
> 
> This issue was hidden till commit 2b2cd74a06c3 ("irqchip/gic-v3: Claim
> iomem resources") replaced of_iomap() calls with of_io_request_and_map()
> that internally called request_mem_region().
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j721s2: fix overlapping GICD memory region
      commit: 856216b70a41ff3f8c866b627546afa01567b389

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

