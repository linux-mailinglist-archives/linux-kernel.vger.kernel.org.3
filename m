Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EDE50A0B7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 15:23:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345970AbiDUN0C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 09:26:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231967AbiDUNZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 09:25:50 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A6F332EDC;
        Thu, 21 Apr 2022 06:23:01 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23LDMiEr065593;
        Thu, 21 Apr 2022 08:22:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650547364;
        bh=+VFNKTAB//MK7xlNT2KoS5a+qBg4nty6a/x60XARYSI=;
        h=From:To:CC:Subject:Date;
        b=tHLYUDRh+vWYFzDw9cv/KdLVilVf0Qn4sYDQiIWFtyrJokKJSDZBrOShMlLDiWhCu
         OWzsIFatrpbncf6ZWc18pOvCzsqcSWehT+ViEDwHh+FLGuFj7q1HC6ZQRUZRiCudxh
         1Sl/zIuYZOtCfg7CyLNuQXALmCEjLUFFnxRF2w0Y=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23LDMisi072033
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 21 Apr 2022 08:22:44 -0500
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 21
 Apr 2022 08:22:43 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 21 Apr 2022 08:22:44 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23LDMh27017103;
        Thu, 21 Apr 2022 08:22:43 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Peter Ujfalusi <peter.ujfalusi@gmail.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jayesh Choudhary <j-choudhary@ti.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, Jai Luthra <j-luthra@ti.com>
Subject: [PATCH 0/3] Enable audio output on AM62-SK
Date:   Thu, 21 Apr 2022 18:52:21 +0530
Message-ID: <20220421132224.8601-1-j-luthra@ti.com>
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

Please apply this series on top of 
https://lore.kernel.org/all/20220415131917.431137-1-vigneshr@ti.com/ 

Jai Luthra (1):
  arm64: dts: ti: am625-sk: Add audio output support

Jayesh Choudhary (2):
  arm64: dts: ti: k3-am62-main: Add McASP nodes
  ASoC: ti: davinci-mcasp: Add dma-type for bcdma

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 51 ++++++++++++++
 arch/arm64/boot/dts/ti/k3-am625-sk.dts   | 89 ++++++++++++++++++++++++
 sound/soc/ti/davinci-mcasp.c             |  2 +
 3 files changed, 142 insertions(+)

-- 
2.17.1

