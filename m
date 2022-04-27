Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F205113CE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:51:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359563AbiD0IyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355911AbiD0IyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:54:23 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD24B6D38;
        Wed, 27 Apr 2022 01:51:11 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23R8p4vw090901;
        Wed, 27 Apr 2022 03:51:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651049464;
        bh=ujc/XpuszdRxajxAaY3YyKhkwghES92p6BnlsrNrfH4=;
        h=From:To:CC:Subject:Date;
        b=rfuOirVYvOdoyf6sIdbLSo0Fob75FFDVB7WHLZRcGQKkRwrQkroRrZPvFuMfTSui5
         35WCBNTU2IO+rpUo9XcQht33zi3SzM7uySYttQgfWQ0uaZEulPDtRI29P+COP/+Ww7
         YOiUMP5qH/7N3u9QhMDfDCxO/lzroxFLafJfnxKk=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23R8p4dq021625
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 27 Apr 2022 03:51:04 -0500
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 27
 Apr 2022 03:51:03 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 27 Apr 2022 03:51:03 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23R8p3Cv042354;
        Wed, 27 Apr 2022 03:51:03 -0500
From:   Jai Luthra <j-luthra@ti.com>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        Jayesh Choudhary <j-choudhary@ti.com>,
        Jai Luthra <j-luthra@ti.com>
Subject: [PATCH v3 0/2] arm64: ti: k3-am62: Enable audio output
Date:   Wed, 27 Apr 2022 14:20:51 +0530
Message-ID: <20220427085053.14964-1-j-luthra@ti.com>
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
https://lore.kernel.org/all/20220427072954.8821-1-vigneshr@ti.com/ and
https://lore.kernel.org/alsa-devel/20220422054001.3738-1-j-luthra@ti.com/

v3:
Fix regulator, clock and codec node names

v2:
Move out the patch for sound/soc/ti/davinici-mcasp.c into a separate series

v2: https://lore.kernel.org/all/20220422060052.8548-1-j-luthra@ti.com/
v1: https://lore.kernel.org/all/20220421132224.8601-1-j-luthra@ti.com/

Jai Luthra (1):
  arm64: dts: ti: am625-sk: Add audio output support

Jayesh Choudhary (1):
  arm64: dts: ti: k3-am62-main: Add McASP nodes

 arch/arm64/boot/dts/ti/k3-am62-main.dtsi | 51 ++++++++++++++
 arch/arm64/boot/dts/ti/k3-am625-sk.dts   | 89 ++++++++++++++++++++++++
 2 files changed, 140 insertions(+)

-- 
2.17.1

