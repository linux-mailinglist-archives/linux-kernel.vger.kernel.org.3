Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551B34C0211
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 20:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235233AbiBVTcR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 14:32:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231702AbiBVTcO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 14:32:14 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACD83CA53;
        Tue, 22 Feb 2022 11:31:48 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21MJVgiR032351;
        Tue, 22 Feb 2022 13:31:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1645558302;
        bh=fJN1oYa3XToyh1Sxwy1ZAbKlDyBkS1XToPQnJvq85yU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WvSrKxyercfQ6lV1ZmpX2gxUQyaQwPlIq3+ots6Z25J/lmh9kJdnjJP+iWetdGKM8
         qTRniUWAxcVfLm0oGprrsaPQiTnzOGWcXPXWrCPr9D/dHbD3r0xs+O4wBUXf8Xh0t4
         7Hl+qigVGgsBd3MMu2GrzCkgdDTS24KydNk+39xY=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21MJVgqu045317
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Feb 2022 13:31:42 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 22
 Feb 2022 13:31:42 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 22 Feb 2022 13:31:42 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21MJVgtg022105;
        Tue, 22 Feb 2022 13:31:42 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/5] arm64: dts: ti: k3*: Fix gic-v3 compatible regs
Date:   Tue, 22 Feb 2022 13:31:41 -0600
Message-ID: <164555829763.27188.1899521132083967069.b4-ty@ti.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220215201008.15235-1-nm@ti.com>
References: <20220215201008.15235-1-nm@ti.com>
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

Hi Nishanth Menon,

On Tue, 15 Feb 2022 14:10:03 -0600, Nishanth Menon wrote:
> This series was triggered by the discussion in [1], and we realized we
> need to cleanup the definitions in K3 SoC. Usage of kvm with gic-v2
> compatibility is a bit niche usecase, but valid and possible with A53
> and A72 even though the GIC500 instantiation is done with no backward
> compatibility.
> 
> Nishanth Menon (5):
>   arm64: dts: ti: k3-am65: Fix gic-v3 compatible regs
>   arm64: dts: ti: k3-j721e: Fix gic-v3 compatible regs
>   arm64: dts: ti: k3-j7200: Fix gic-v3 compatible regs
>   arm64: dts: ti: k3-am64: Fix gic-v3 compatible regs
>   arm64: dts: ti: k3-j721s2: Fix gic-v3 compatible regs
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/5] arm64: dts: ti: k3-am65: Fix gic-v3 compatible regs
      commit: 8cae268b70f387ff9e697ccd62fb2384079124e7
[2/5] arm64: dts: ti: k3-j721e: Fix gic-v3 compatible regs
      commit: a06ed27f3bc63ab9e10007dc0118d910908eb045
[3/5] arm64: dts: ti: k3-j7200: Fix gic-v3 compatible regs
      commit: 1a307cc299430dd7139d351a3b8941f493dfa885
[4/5] arm64: dts: ti: k3-am64: Fix gic-v3 compatible regs
      commit: de60edf1be3d42d4a1b303b41c7c53b2f865726e
[5/5] arm64: dts: ti: k3-j721s2: Fix gic-v3 compatible regs
      commit: a966803781fc5e1875511db9392b0d16174c5dd2

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

