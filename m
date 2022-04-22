Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D67650AFEC
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbiDVGEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233197AbiDVGEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:04:01 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3B04F473;
        Thu, 21 Apr 2022 23:01:09 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23M60wwP121003;
        Fri, 22 Apr 2022 01:00:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650607258;
        bh=9bUnBTWCXhpkU1twUskkrZzH3INxU1FojkanyreYxNc=;
        h=From:To:CC:Subject:Date;
        b=AVgu/NeLYgA3+J/TSRX9kuk0mwEDpN+PLQicY+imhhdVoslbuU2m5D16f+yOHS9eo
         xmMvos8zzPiAogkThlUzr4+/WR/AWvmYZdcQzHhi2pVgjxQp4Ge0rV/8Aj/VP6MvDH
         mlkDHCYVq5+HvywkpITSLxCNNCD3ZeF9L938ePC8=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23M60wlm024103
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 22 Apr 2022 01:00:58 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 22
 Apr 2022 01:00:57 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 22 Apr 2022 01:00:57 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23M60vCk082867;
        Fri, 22 Apr 2022 01:00:57 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Jai Luthra <j-luthra@ti.com>
Subject: [PATCH v2 0/2] Enable audio output on AM62-SK
Date:   Fri, 22 Apr 2022 11:30:50 +0530
Message-ID: <20220422060052.8548-1-j-luthra@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for audio output via headphone jack on the 
AM62-SK board. The jack is wired to TLV320AIC3106 (codec), which is 
connected to McASP (serializer).

The same 3.5mm jack can be used for combined playback+recording, but audio 
input is currently disabled on McASP until further testing and debugging.

For testing, please apply this series on top of 
https://lore.kernel.org/all/20220415131917.431137-1-vigneshr@ti.com/ and 
https://lore.kernel.org/alsa-devel/20220422054001.3738-1-j-luthra@ti.com/

Changelog:

V2:
- Move out the patch for sound/soc/ti/davinci-mcasp.c from this series

Jai Luthra (1):
  arm64: dts: ti: am625-sk: Add audio output support

Jayesh Choudhary (1):
  arm64: dts: ti: k3-am62-main: Add McASP nodes

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 51 ++++++++++++++
 arch/arm64/boot/dts/ti/k3-am625-sk.dts   | 89 ++++++++++++++++++++++++
 2 files changed, 140 insertions(+)

-- 
2.17.1

