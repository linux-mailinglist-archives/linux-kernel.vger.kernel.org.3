Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD19A51481F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358548AbiD2LbF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:31:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358465AbiD2Lap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:30:45 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934B1B6D25;
        Fri, 29 Apr 2022 04:26:55 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23TBQh44063972;
        Fri, 29 Apr 2022 06:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1651231603;
        bh=x+5lRF/olGHJ4+jtLpCvlbL4hvGBh7bUN3rx1gpPEg4=;
        h=From:To:CC:Subject:Date;
        b=xPEg7Zqdcotl/hNuyVD6PeHRo5ujD9Yvn+0Ypb92hovO6+2U3/+9acOxfQOUZ76V5
         BEcOo9vY78JnJ4a31T37WHKMOUt8/7m0/XpxP6OtBh19j8aGKAV7/10flGjYA7MQVe
         PIuVwA3LSq1vskcHeV+vK3ZYRlqw3pIDPyC/sbWg=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23TBQhME110293
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 29 Apr 2022 06:26:43 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 29
 Apr 2022 06:26:43 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 29 Apr 2022 06:26:43 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23TBQgYv077647;
        Fri, 29 Apr 2022 06:26:42 -0500
From:   Rahul T R <r-ravikumar@ti.com>
To:     <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>, <kishon@ti.com>,
        <a-bhatia1@ti.com>, <r-ravikumar@ti.com>
Subject: [PATCH v5 0/2] DSS: Add support for DisplayPort
Date:   Fri, 29 Apr 2022 16:56:37 +0530
Message-ID: <20220429112639.13004-1-r-ravikumar@ti.com>
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

The following series of patches enables DisplayPort on
j721e-evm

v2:
   - use phandle with a parameter to refer clocks insted of
     sub nodes in serdes_wiz node
   - move phy link node to board DTS file

v3:
   - Fix the regulator node name as per the DT spec
   - Use Macro for GPIO type

v4:
   - Move adding of phy link nodes from 2/2 to 1/2, to fix dtbs checks warnings
   - Add leading zeros to align reg property addresses and sizes
   - Add empty ports for mhdp node in dtsi file to fix dtbs checks warnings

v5:
   - Fix a typo in regulator name

boot logs:
   https://gist.githubusercontent.com/ravi-rahul/1bdbc3f77ab381e486c8394650c2e85d/raw/2327c9894c3236950a00f4511ae668ac4399b71e/j7_DP_upstream.log

kernel patch verify report:
   https://gist.githubusercontent.com/ravi-rahul/a982fef3fae03ec0dbdd5cb475a4cb25/raw/9ef482f96fa351cff7980e4340e9bcb8471ec3ab/report-kernel-patch-verify.txt

Tomi Valkeinen (2):
  arm64: dts: ti: k3-j721e-*: add DP & DP PHY
  arm64: dts: ti: k3-j721e-common-proc-board: add DP to j7 evm

 .../dts/ti/k3-j721e-common-proc-board.dts     | 77 ++++++++++++++++++-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 75 +++++++++++++++++-
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts        | 16 ++++
 3 files changed, 162 insertions(+), 6 deletions(-)

-- 
2.17.1

