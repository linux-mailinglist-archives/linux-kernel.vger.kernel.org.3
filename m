Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2B756F96A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiGKI6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbiGKI5v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:57:51 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF861A042;
        Mon, 11 Jul 2022 01:57:51 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 26B8vj7q052237;
        Mon, 11 Jul 2022 03:57:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657529865;
        bh=Q2llsh/2FKRNS8ubLOQgjDkJPI6SEWj033eHEtQSi+o=;
        h=From:To:CC:Subject:Date;
        b=oqqxE5cRFxDJNO1hvRPoOzjHp6XAiVTNkpYX7sZ7a8Rg+aCIQTpFSaaLzjVwvLp6i
         2JHFhCOkaAplGD6Ojmd7Y/8V5TTUp4pWZJKBak00NkPQzWqygZ39/PvXtgk6kmInRA
         OJW9E/EfHfiBqf8RwaPkB2iKT5GBqv8ia1nJOYEg=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 26B8vjfs126426
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Jul 2022 03:57:45 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 11
 Jul 2022 03:57:45 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 11 Jul 2022 03:57:45 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 26B8viha094120;
        Mon, 11 Jul 2022 03:57:44 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <devicetree@vger.kernel.org>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <j-choudhary@ti.com>
Subject: [PATCH v2 0/2] Enable SA2UL support on AM64X
Date:   Mon, 11 Jul 2022 14:27:41 +0530
Message-ID: <20220711085743.10128-1-j-choudhary@ti.com>
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

This series enables sa2ul support for TI SoC AM64X.
It is based on another series posted by Suman Anna:
<https://lore.kernel.org/linux-arm-kernel/20210514210725.32720-1-s-anna@ti.com/>

rng node has been disabled due to its indirect access from OP-TEE.

Since the sa2ul hardware is being used by OP-TEE as well,
it should be requested using shared TI-SCI flag. So the flag
has been changed from TI-SCI-EXCLUSIVE to TI-SCI-SHARED.

I have tried crypto tests on my local setup, and tcrypt and
self-tests are passing.

Changes from v1:
- disable rng node instead of dropping it

Peter Ujfalusi (1):
  arm64: dts: ti: k3-am64-main: Enable crypto accelerator

Suman Anna (1):
  arm64: dts: ti: k3-am64: Add SA2UL address space to Main CBASS ranges

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 20 ++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-am64.dtsi      |  1 +
 2 files changed, 21 insertions(+)

-- 
2.17.1

