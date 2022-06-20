Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC83C5515D5
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 12:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240303AbiFTK2V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 06:28:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235119AbiFTK2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 06:28:20 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91EB865E0;
        Mon, 20 Jun 2022 03:28:18 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25KAS3D8044729;
        Mon, 20 Jun 2022 05:28:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655720883;
        bh=8S4RJIt01krO5SFnaHIBaeR25+r/z/wZvXY6r5G9Pkk=;
        h=From:To:CC:Subject:Date;
        b=VYqBl3va4IlQQdrVQwOrJ1DGBk/TusowmP/d4xh++/v3dWH5YU5dMwJnlyMp4nvjw
         tZt5qU6XHT/2njQVtOBzfDyz8w+hxQ9qKIuQMM/VS93YebMvYzM+Fcl7Itk1uHOTGx
         SP2ZN/O1oz0T8twB2XmQqYUIFNa1ohv8/G4XwIGY=
Received: from DLEE109.ent.ti.com (dlee109.ent.ti.com [157.170.170.41])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25KAS3kS049419
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Jun 2022 05:28:03 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 20
 Jun 2022 05:28:03 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 20 Jun 2022 05:28:03 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25KAS2TQ018315;
        Mon, 20 Jun 2022 05:28:02 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Jai Luthra <j-luthra@ti.com>
Subject: [PATCH v4 0/2] arm64: ti: k3-am62: Enable audio output
Date:   Mon, 20 Jun 2022 15:57:47 +0530
Message-ID: <20220620102750.32718-1-j-luthra@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
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

This patch series adds support for audio output via headphone jack on the 
AM62-SK board. The jack is wired to TLV320AIC3106 (codec), which is connected 
to McASP (serializer).

The same 3.5mm jack can be used for combined playback+recording, but audio 
input is currently disabled on McASP until further testing and debugging.

v4:
Use audio-friendly 96Mhz source as clock parent for mcasp

v3:
Fix regulator, clock and codec node names

v2:
Move out the patch for sound/soc/ti/davinici-mcasp.c into a separate series

v3: https://lore.kernel.org/all/20220427085053.14964-1-j-luthra@ti.com/
v2: https://lore.kernel.org/all/20220422060052.8548-1-j-luthra@ti.com/
v1: https://lore.kernel.org/all/20220421132224.8601-1-j-luthra@ti.com/

Jai Luthra (1):
  arm64: dts: ti: k3-am625-sk: Add audio output support

Jayesh Choudhary (1):
  arm64: dts: ti: k3-am62-main: Add McASP nodes

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 57 +++++++++++++++
 arch/arm64/boot/dts/ti/k3-am625-sk.dts   | 89 ++++++++++++++++++++++++
 2 files changed, 146 insertions(+)

-- 
2.17.1

