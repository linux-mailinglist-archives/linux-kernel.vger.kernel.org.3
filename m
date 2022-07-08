Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF75E56B878
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 13:29:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237862AbiGHL2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 07:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237853AbiGHL2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 07:28:06 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 085F8904DB;
        Fri,  8 Jul 2022 04:28:04 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 268BRuZH034593;
        Fri, 8 Jul 2022 06:27:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657279676;
        bh=YpBYXN3/OXv+iCuG4NvEzBRnaSPgKafH6hRfGWBM6OQ=;
        h=From:To:CC:Subject:Date;
        b=klfu0vYl+f9l2cr8BPgZw48eaLpcxX1fSMVU/qep/PnyYLR69wa1s+ILl7zVw3KGg
         1DKNflWLuA6vPF4UP3XJ1IoCf5ztPyyoWestwBc/tAlrhCEA7buEEZt3WivWMMxqWZ
         hy/+6qG4QbYBrRKcmVhi602fsT8s/eW61KB0HjKk=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 268BRuwL082301
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 8 Jul 2022 06:27:56 -0500
Received: from DLEE112.ent.ti.com (157.170.170.23) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 8
 Jul 2022 06:27:56 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 8 Jul 2022 06:27:56 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 268BRtgt042892;
        Fri, 8 Jul 2022 06:27:56 -0500
From:   Jayesh Choudhary <j-choudhary@ti.com>
To:     <nm@ti.com>, <vigneshr@ti.com>, <devicetree@vger.kernel.org>
CC:     <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <j-choudhary@ti.com>
Subject: [PATCH 0/2] Enable SA2UL support on AM64X
Date:   Fri, 8 Jul 2022 16:57:53 +0530
Message-ID: <20220708112755.105642-1-j-choudhary@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

rng node has been dropped due to its indirect access from OP-TEE.

Since the sa2ul hardware is being used by OP-TEE as well,
it should be requested using shared TI-SCI flag. So the flag
has been changed from TI-SCI-EXCLUSIVE to TI-SCI-SHARED.

I have tried crypto tests on my local setup, and tcrypt and
self-tests are passing.

Peter Ujfalusi (1):
  arm64: dts: ti: k3-am64-main: Enable crypto accelerator

Suman Anna (1):
  arm64: dts: ti: k3-am64: Add SA2UL address space to Main CBASS ranges

 arch/arm64/boot/dts/ti/k3-am64-main.dtsi | 12 ++++++++++++
 arch/arm64/boot/dts/ti/k3-am64.dtsi      |  1 +
 2 files changed, 13 insertions(+)

-- 
2.17.1

