Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B6514B7758
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244030AbiBOUKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 15:10:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236571AbiBOUKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 15:10:30 -0500
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8FDDB86E;
        Tue, 15 Feb 2022 12:10:18 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 21FKA9Dv071773;
        Tue, 15 Feb 2022 14:10:09 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1644955809;
        bh=nFjLPGELwJtadWdb9FpAoiY7mb9Qwfbj9M2rC59OVdQ=;
        h=From:To:CC:Subject:Date;
        b=jwP8pwvpXy9kGAslX2SVhFlQ12xiUqyLz/1HZGJEmaegObxDgDJBjM5L6PFcnCYqA
         JqHLwrUaHVjtvO+Nz887bVn1msbw94Sa5z4d+DOvZLIodBL/X8WNo6uhFsXTqXFJnD
         hfO+S+4LMxX0KdYM6ozbk8R5WWQKaH5nvjO4dQJc=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 21FKA9SC068714
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 15 Feb 2022 14:10:09 -0600
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 15
 Feb 2022 14:10:09 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 15 Feb 2022 14:10:09 -0600
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 21FKA9NC127932;
        Tue, 15 Feb 2022 14:10:09 -0600
From:   Nishanth Menon <nm@ti.com>
To:     Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/5] arm64: dts: ti: k3*: Fix gic-v3 compatible regs
Date:   Tue, 15 Feb 2022 14:10:03 -0600
Message-ID: <20220215201008.15235-1-nm@ti.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series was triggered by the discussion in [1], and we realized we
need to cleanup the definitions in K3 SoC. Usage of kvm with gic-v2
compatibility is a bit niche usecase, but valid and possible with A53
and A72 even though the GIC500 instantiation is done with no backward
compatibility.

Nishanth Menon (5):
  arm64: dts: ti: k3-am65: Fix gic-v3 compatible regs
  arm64: dts: ti: k3-j721e: Fix gic-v3 compatible regs
  arm64: dts: ti: k3-j7200: Fix gic-v3 compatible regs
  arm64: dts: ti: k3-am64: Fix gic-v3 compatible regs
  arm64: dts: ti: k3-j721s2: Fix gic-v3 compatible regs

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi   | 5 ++++-
 arch/arm64/boot/dts/ti/k3-am64.dtsi        | 1 +
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi   | 5 ++++-
 arch/arm64/boot/dts/ti/k3-am65.dtsi        | 1 +
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi  | 5 ++++-
 arch/arm64/boot/dts/ti/k3-j7200.dtsi       | 1 +
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi  | 5 ++++-
 arch/arm64/boot/dts/ti/k3-j721e.dtsi       | 1 +
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi | 5 ++++-
 arch/arm64/boot/dts/ti/k3-j721s2.dtsi      | 1 +
 10 files changed, 25 insertions(+), 5 deletions(-)

[1] https://lore.kernel.org/all/87k0e0tirw.wl-maz@kernel.org/

-- 
2.31.1

