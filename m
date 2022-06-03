Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D514653C9CD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 14:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244240AbiFCMPw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 08:15:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244203AbiFCMPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 08:15:41 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2922A39826;
        Fri,  3 Jun 2022 05:15:40 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 253CFNNf054345;
        Fri, 3 Jun 2022 07:15:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1654258523;
        bh=wx1Z1JAWtJ0bLXfcJY0X28Tf4dQ3zbCBztSxFzw1Ksc=;
        h=From:To:CC:Subject:Date;
        b=lpeAHNriu5d2vuC6OQeEAbResmu00iZLeEHCyBrSBRTKAAPy8dBbj+NBaqVeSZ/bb
         qLd0zItocBLxaay9+QNt83JVW2xYAtlIPdvZZGCQCS1ImO0s5JQP50TVfn4uriRd6V
         vocWW41SWU7pz3AEAE58+yglAmKYxmjvRBFhAqek=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 253CFNfV031375
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 3 Jun 2022 07:15:23 -0500
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 3
 Jun 2022 07:15:22 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 3 Jun 2022 07:15:22 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 253CFLg7025652;
        Fri, 3 Jun 2022 07:15:22 -0500
From:   Puranjay Mohan <p-mohan@ti.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nm@ti.com>, <ssantosh@kernel.org>, <s-anna@ti.com>,
        <p-mohan@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <rogerq@kernel.org>, <grygorii.strashko@ti.com>, <vigneshr@ti.com>,
        <kishon@ti.com>, <robh@kernel.org>
Subject: [PATCH v4 0/6] Introduce PRU remoteproc consumer API
Date:   Fri, 3 Jun 2022 17:45:14 +0530
Message-ID: <20220603121520.13730-1-p-mohan@ti.com>
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

This is the v4 of the patch series [1]. The v3 had some comments
on the DT patch that have been addressed here. The 6th patch in this
series was missed in the previous versions, so, it has been added now.

I have posted two more patch series that depend on this series, one to
the soc tree and another to the networking tree. I had sent all the 3
series, including this one as RFC [2] to get comments and to explain the
dependencies.

The Programmable Real-Time Unit and Industrial Communication Subsystem
(PRU-ICSS or simply PRUSS) on various TI SoCs consists of dual 32-bit
RISC cores (Programmable Real-Time Units, or PRUs) for program execution.

There are 3 foundation components for PRUSS subsystem: the PRUSS platform
driver, the PRUSS INTC driver and the PRUSS remoteproc driver. All were
already merged and can be found under:
1) drivers/soc/ti/pruss.c
   Documentation/devicetree/bindings/soc/ti/ti,pruss.yaml
2) drivers/irqchip/irq-pruss-intc.c
   Documentation/devicetree/bindings/interrupt-controller/ti,pruss-intc.yaml
3) drivers/remoteproc/pru_rproc.c
   Documentation/devicetree/bindings/remoteproc/ti,pru-rproc.yaml

The programmable nature of the PRUs provide flexibility to implement custom
peripheral interfaces, fast real-time responses, or specialized data handling.
Example of a PRU consumer drivers will be:
  - Software UART over PRUSS
  - PRU-ICSS Ethernet EMAC

In order to make usage of common PRU resources and allow the consumer drivers to
configure the PRU hardware for specific usage the PRU API is introduced.

[1] https://patchwork.kernel.org/project/linux-remoteproc/cover/20220418104118.12878-1-p-mohan@ti.com/
[2] https://patchwork.kernel.org/project/linux-remoteproc/cover/20220406094358.7895-1-p-mohan@ti.com/

Thanks and Regards,
Puranjay Mohan

Roger Quadros (1):
  remoteproc: pru: Add pru_rproc_set_ctable() function

Suman Anna (2):
  dt-bindings: remoteproc: Add PRU consumer bindings
  remoteproc: pru: Make sysfs entries read-only for PRU client driven
    boots

Tero Kristo (3):
  remoteproc: pru: Add APIs to get and put the PRU cores
  remoteproc: pru: Configure firmware based on client setup
  remoteproc: pru: add support for configuring GPMUX based on client
    setup

 .../bindings/remoteproc/ti,pru-consumer.yaml  |  69 +++++
 drivers/remoteproc/pru_rproc.c                | 254 +++++++++++++++++-
 include/linux/pruss.h                         |  78 ++++++
 3 files changed, 396 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/ti,pru-consumer.yaml
 create mode 100644 include/linux/pruss.h

-- 
2.17.1

