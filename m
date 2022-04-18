Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20C65052AA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 14:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239475AbiDRMuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 08:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240727AbiDRMjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 08:39:35 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11EA713CED;
        Mon, 18 Apr 2022 05:30:18 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23ICU9BC077061;
        Mon, 18 Apr 2022 07:30:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650285009;
        bh=8G0h/3NF1tmnS3Le0+tUCjebMIA+1hV3rqMDN1tOb1Y=;
        h=From:To:CC:Subject:Date;
        b=lONBWY/egKTKEZSS/TN9UyPgIoqlPMAcwRFm0CFuSSUFDmcc4dtf9VzdmtqNKUakF
         dGN4hXEHnMSCrgvI0gaSBwRQX2S8wf3vERCBfimUsQW2B8QOHHfHtKo09s7gV8y0cy
         VKmm5jDiZygGfGgJFG7F2ePLbVy0DtkREhltXRH0=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23ICU92C060480
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 18 Apr 2022 07:30:09 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Mon, 18
 Apr 2022 07:30:08 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Mon, 18 Apr 2022 07:30:08 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23ICU6pb010907;
        Mon, 18 Apr 2022 07:30:07 -0500
From:   Puranjay Mohan <p-mohan@ti.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <bjorn.andersson@linaro.org>, <mathieu.poirier@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nm@ti.com>, <ssantosh@kernel.org>, <s-anna@ti.com>,
        <p-mohan@ti.com>, <linux-arm-kernel@lists.infradead.org>,
        <rogerq@kernel.org>, <grygorii.strashko@ti.com>, <vigneshr@ti.com>,
        <kishon@ti.com>
Subject: [PATCH v2 0/6] Introduce PRU platform consumer API
Date:   Mon, 18 Apr 2022 17:59:58 +0530
Message-ID: <20220418123004.9332-1-p-mohan@ti.com>
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

This is the re-spin of the old patch series[1]. This doesn't have any 
functional changes, the old series has been rebased on linux-next.

This series depends on another un-merged series in the remoteproc
tree[2]. This series and the remoteproc series form the PRUSS comsumer
API which can be used by consumer drivers to utilize the PRUs.

One example of the consumer driver is the PRU-ICSSG ethernet driver,
which depends on this series and the remoteproc series[2].

I had earlier sent all the three series, this, remoteproc, and the 
ethernet driver as RFC to get comments. It can be seen here[3] to
understand the overall structure.

The Programmable Real-Time Unit and Industrial Communication Subsystem (PRU-ICSS
or simply PRUSS) on various TI SoCs consists of dual 32-bit RISC cores
(Programmable Real-Time Units, or PRUs) for program execution.

There are 3 foundation components for TI PRUSS subsystem: the PRUSS platform
driver, the PRUSS INTC driver and the PRUSS remoteproc driver.

The programmable nature of the PRUs provide flexibility to implement custom
peripheral interfaces, fast real-time responses, or specialized data handling.
Example of a PRU consumer drivers will be: 
  - Software UART over PRUSS
  - PRU-ICSS Ethernet EMAC

In order to make usage of common PRU resources and allow the consumer drivers to
configure the PRU hardware for specific usage the PRU API is introduced.

[1] https://patchwork.kernel.org/project/linux-remoteproc/cover/20201211184811.6490-1-grzegorz.jaszczyk@linaro.org/
[2] https://patchwork.kernel.org/project/linux-remoteproc/cover/20220418104118.12878-1-p-mohan@ti.com/
[3] https://patchwork.kernel.org/project/linux-remoteproc/cover/20220406094358.7895-1-p-mohan@ti.com/

Thanks,
Puranjay Mohan

Andrew F. Davis (1):
  soc: ti: pruss: Add pruss_{request,release}_mem_region() API

Suman Anna (3):
  soc: ti: pruss: Add pruss_cfg_read()/update() API
  soc: ti: pruss: Add helper functions to set GPI mode, MII_RT_event and
    XFR
  soc: ti: pruss: Add helper function to enable OCP master ports

Tero Kristo (2):
  soc: ti: pruss: Add pruss_get()/put() API
  soc: ti: pruss: Add helper functions to get/set PRUSS_CFG_GPMUX

 drivers/soc/ti/pruss.c       | 257 ++++++++++++++++++++++++++++++++++-
 include/linux/pruss.h        | 221 ++++++++++++++++++++++++++++++
 include/linux/pruss_driver.h |  72 +++++++---
 3 files changed, 526 insertions(+), 24 deletions(-)

-- 
2.17.1

