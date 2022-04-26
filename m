Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCD3A510201
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 17:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352429AbiDZPja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 11:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352407AbiDZPjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 11:39:23 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A4115703;
        Tue, 26 Apr 2022 08:36:15 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 23QFZwC4095154;
        Tue, 26 Apr 2022 10:35:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1650987358;
        bh=+wXVEK8JCV6awv2uh9nVMeADNZSkgBnA4Ju6ueZN+HA=;
        h=From:To:CC:Subject:Date;
        b=trVDvRK66edZUKXwpvoR7RfDwCgujhNAMjpxnr74PO0ZkqMmhAcXDjDT5O5N9H7kr
         myuhDVQi52eRARJKHVJJF2ucWTI/1BJY5kKgCIiGv78jcmkCKcmNJtrz/pxuY1vbum
         HQ4kFZ6WMIVqQ5jhJYAcG1dr31PLrzk2df4gUrdk=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 23QFZvux090012
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 26 Apr 2022 10:35:58 -0500
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 26
 Apr 2022 10:35:57 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 26 Apr 2022 10:35:57 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 23QFZu57016778;
        Tue, 26 Apr 2022 10:35:57 -0500
From:   Rahul T R <r-ravikumar@ti.com>
To:     <nm@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@canonical.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>, <kishon@ti.com>,
        <r-ravikumar@ti.com>
Subject: [PATCH v4 0/2] DSS: Add support for DisplayPort
Date:   Tue, 26 Apr 2022 21:05:51 +0530
Message-ID: <20220426153553.18474-1-r-ravikumar@ti.com>
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

