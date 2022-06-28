Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 010CF55D017
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:07:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245118AbiF1FoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 01:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245111AbiF1FoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 01:44:05 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE9E1D0E0;
        Mon, 27 Jun 2022 22:44:02 -0700 (PDT)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=DL7ngWQKPOJX0753nyH1utQI77nDiBTKUa6ywymhUooPChio/bjjJgWDHRLcRTjvBLwROtwWxz3ZKaYJKKUGUdKRvdbWo1X7BwDOt+7LcYFz+HAnnnYpwHcy2ROnz+nnNPBGef+phIWBqQ/v4tNm5kGOVPvflFVqEIIaULJHgNanIn++UYEk1q+cxcXQYMK/f8v/NWGaCkb7wQMJq2zhS4ALkHnRAJHRua61zHzof9Wt2tZG91e3Hz7nRjr9JKqr7eAvVYiKMvZcd4TW82T52v0O42kvERMkxGvLfST5RbXCQD4UYYHFUiXf6+cbCBaiNxpGoXryerspAtU3J2n8Xg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K70VROl2VxnmbVDpT2J0WclUKHVSV6en0RHZXwHrZds=;
 b=lFStePWH7nC61benAGig5KUyhh4LOkDESmpmTeiv+MoPPtorEz4XQP1YoX/w0GgCbgV7uwMvmc+bW+L1cMF3KcfQOkR6oAP/SQFVQK7IPCjr41eB9E3etVltRtsK324AMlSnR8Vbr1LWbO3yIzT6g+O8KZl9XtSLiMYQTtPb71waTnqtOu6OSjrngvThuJo7nw0lt4ortUVal2FJ2DER+KEIVWLOCuLPzMPmPv0mXsXCPbjIpQUgXx/6Alfa7ixubvFsaEVHhXBGYCAgIJyYuQopGcVhJvnmV5dFyNEDAv31T6pedtvd+A9zrHkziPzeqpyahsJbnG3IGmNwpad8dg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 20.83.241.18) smtp.rcpttodomain=arndb.de smtp.mailfrom=xilinx.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=xilinx.com; dkim=none
 (message not signed); arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=xilinx.com] dmarc=[1,1,header.from=xilinx.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K70VROl2VxnmbVDpT2J0WclUKHVSV6en0RHZXwHrZds=;
 b=cUZME1HWHu6qaBxgfHIejYiT3K/P2YF1xbgTxUmhkd6amm2UqV6DCooHb+dfkMrkNi7soUp9hXoOPWcQDUOGqVRDQKOnovmPlFWXs63iuI2UyzaeVstddM72IK30nUtLXSzBhMRTZHmox12UbAsDDxhM3ppoym/m15eyefbb19s=
Received: from DM6PR06CA0015.namprd06.prod.outlook.com (2603:10b6:5:120::28)
 by BN7PR02MB5140.namprd02.prod.outlook.com (2603:10b6:408:2a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 28 Jun
 2022 05:43:58 +0000
Received: from DM3NAM02FT029.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:120:cafe::9d) by DM6PR06CA0015.outlook.office365.com
 (2603:10b6:5:120::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17 via Frontend
 Transport; Tue, 28 Jun 2022 05:43:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 20.83.241.18)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 20.83.241.18 as permitted sender) receiver=protection.outlook.com;
 client-ip=20.83.241.18;
 helo=mailrelay000000.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net;
 pr=C
Received: from
 mailrelay000000.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net
 (20.83.241.18) by DM3NAM02FT029.mail.protection.outlook.com (10.13.4.98) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15 via Frontend
 Transport; Tue, 28 Jun 2022 05:43:58 +0000
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mailrelay000000.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net (Postfix) with ESMTPS id E97A73F030;
        Tue, 28 Jun 2022 05:43:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TED4UgMV0DDK2rM/Td8Fyk1prkaKRY/Wol4KSmnf/1oOSkPIe9JO9HqRNdo7j5foZNL1nbCcN911tyLn8kE8tpkJnWIdsKkZpkTxtLIE68slprVh8MHUr8xJKXXgMW/OzdPPbIzh33usTSMDxYhGv4gUiftl2EGJOmXlOydW3CYdb6YKkr5oPmAl7aOCLu/olKUifiNJz6B2ATLdBPTTGVSF0venxkLD58RZLjhtlOXHZpi0Xy1heE+ClmO049fg1P1AZkRRvtS8G4r+8oHLVluy8epF1RGWpBUyAEtqKuJomd4fKXxAkBpNRK2NSZkNodZ0RsuS+yoftoPM8e0bXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K70VROl2VxnmbVDpT2J0WclUKHVSV6en0RHZXwHrZds=;
 b=oLlcwHfqosr42qsAWW2HB3aTHXxJ4Gv1yZoayZ4C1+rfyXMLvqW0MQ2g2mveqh7Qwo10TXJsCnOOAEQ2Q4Y1vzi2FmlQ7xuNVmBOGJt48UHnohkDqGkwpYM9NCzYFkObMAybZsaknALroLsPG1MV7KcPYlWGeIoUp/7YZOgi92/Ihhl9aebKpM+P4ivBl/dcLJ+eCyeh5qdf7hwe132xUuULtd+vRmzMYvWfaU78Ca1ZjM47ARnJ6rL/IP6d0YlUwFKoU8AEUVFhPHo/INAtZiqtzLXxlIesEmP/JuPAiAato96dt0w16jlJzM/TKAuae7X/RxDr7JJYpCtFhVuv3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
Received: from SA9PR13CA0085.namprd13.prod.outlook.com (2603:10b6:806:23::30)
 by CO1PR02MB8854.namprd02.prod.outlook.com (2603:10b6:303:163::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 28 Jun
 2022 05:43:55 +0000
Received: from SN1NAM02FT0045.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:23:cafe::e5) by SA9PR13CA0085.outlook.office365.com
 (2603:10b6:806:23::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.8 via Frontend
 Transport; Tue, 28 Jun 2022 05:43:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0045.mail.protection.outlook.com (10.97.5.234) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5373.15 via Frontend Transport; Tue, 28 Jun 2022 05:43:54 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 27 Jun 2022 22:43:51 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 27 Jun 2022 22:43:51 -0700
Envelope-to: git@xilinx.com,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 arnd@arndb.de,
 gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org,
 git@amd.com
Received: from [10.140.6.6] (port=51114 helo=xhdappanad40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <appana.durga.rao@xilinx.com>)
        id 1o640t-0007Ut-7L; Mon, 27 Jun 2022 22:43:51 -0700
From:   Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <appana.durga.rao@xilinx.com>, <michal.simek@xilinx.com>,
        <derek.kiernan@xilinx.com>, <dragan.cvetic@xilinx.com>,
        <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <git@amd.com>, <git@xilinx.com>
Subject: [PATCH 2/4] drivers: misc: Add Support for TMR Manager
Date:   Tue, 28 Jun 2022 11:13:36 +0530
Message-ID: <20220628054338.1631516-3-appana.durga.rao@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220628054338.1631516-1-appana.durga.rao@xilinx.com>
References: <20220628054338.1631516-1-appana.durga.rao@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 1
X-MS-Office365-Filtering-Correlation-Id: c1c3a7dc-0a6f-4fa9-8496-08da58c9327e
X-MS-TrafficTypeDiagnostic: CO1PR02MB8854:EE_|DM3NAM02FT029:EE_|BN7PR02MB5140:EE_
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: iR6dh7rE77k6YGgF01ngs5uatLUh3QOiayIEnD+6U50ogJChHOS9SxNoMNFnd/51BnD6O48+5QVt/tf778/YDvnlpN2KBSoLZjYH42y0YcSUAhsduYum4NTgynPdmaGYYic/DbLyoTitHvVRogPtir76u+1JC6Q2V3GnHdfFt/PhwaPpUdLrW4qan9nk9xBC/2PoP98waEaIun6LWhScwaA19wf9AtgfWZCtFTs004Wd5teqfA7jsEQD/8mlXyXii2u7Qwg6nJL1+rzQM9++yD6VIabifhOQvEHnZ0dS7AbEBLu5CIuS55+1fU+PUztlsfyzk1rZimRwB3uUEmnllYYFHmbpF6tHpLkVeTf4D0rUBD56XMpMVSWo/vOmW5WR+MQRapTDp7N3YD6p5lL4wysucOLZJgpLnPfdTIWwvbObrMIcQskASYleligOoUONwHAuo282meeUwW0Wr7ty0bxWAdDEfiHG98U+zML/SuDuoq+wjdXPkKjP3r61n6Sxn3OBuogra4h0pqZNiZf18bTYsIq1FfUVzbBcNeVAB/KYKSFL14qbITMv9oqqvxR93s/pnkC09uR6EQX819zvFSVY5+FwVNa6aysaBfeL/GHL2OlyKPdrPjesChNmnnUibmMY3giewepJAixhiaRRo4g+bBkMBEVls1Lf998OH3jTpEuMllVzPave901uFgDmd5nYcDTObiB8IbrfwgZxgtG1dzjKr6n5sabhr3J/vUV+y3BScmr0+d5wixgXsVe4o106asCIdfZgMHf5y8CMb4VXRUeJaCZB5tKdJ/QGSgKOWxLfASwsy1zDJlTJgow5K3IQMhS2tRh9NSAs9U7Fm8/+na1VRt49sviCcD+dvfWnPRmgfE3i2bX8mD9FZpqK
X-Forefront-Antispam-Report-Untrusted: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(396003)(376002)(346002)(40470700004)(46966006)(36840700001)(36860700001)(356005)(107886003)(336012)(921005)(47076005)(2616005)(316002)(36756003)(478600001)(70206006)(2906002)(8676002)(70586007)(1076003)(54906003)(7696005)(110136005)(26005)(8936002)(4326008)(103116003)(30864003)(40460700003)(82740400003)(426003)(40480700001)(6666004)(186003)(82310400005)(7636003)(5660300002)(83380400001)(41300700001)(9786002)(966005)(102446001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR02MB8854
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DM3NAM02FT029.eop-nam02.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: d598b79e-604c-4159-9610-08da58c93034
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hLRaL7Isq+dJ4zrkJ1LsjMXTxviW39fNqB23v9BLVPQ4LNv5nzZrbbJAPVzY7cT8IBOpI5FXgaLd+9EgEbr7HhXiC+XCwVoPTRiN90bBKArvt5+lXtGPJMdQGpORq/kTNubgGTdYrmwfjHCc5J5Cly3X4ggcUuJMtDcHh+RCHTzKA1ndExFgqWh8XF48DI5822zAPxOktCbTCtAAO/GkCrbkRiqSMQN3EGTDR0xL8YPjfNjtpIuSwVHJ2aePO7yke5KKMyCJONplF4FLrqIh481FlZUd3ap3/5FXpCX2mdxYv68Rw2ik9bKZ0BmCqlBMlRc3J7xIMU6yEEg+zclBHeKHWYWBBfBHLvJ18X4OiViuvOxOsxnyat1QzJTq4ykNiaMxxn5o0LEv4PfI9906frZcG0i0mbeVzXLF+ZRyEESYrYyOoOzDClaXBlQl4MjTpYFUZU3m2GYJ4nKTyoUGgY7NMKSF8dt8PX45Uk1tv8SDuJ795PtCYTqBSSfyjJi6CEVaMdxPi8zjgPD+m6ODKGCoBzQGi1TSn9lsIAyIVwi2/H6zK96J2Bu2pTo9OErguuQ/IQ+M1a9Xk1IQ3cEozZadvTgW0RWVKM/BndlZuTFZ9jFDEBhn7N6wI4wTDeX3wfrYbCeTvCoET8jIJUesUKJFH4GOtgjWi38QddCpze5FMlP5MjKyuTySV2RIwQLmSb9UHNAVwTZ0oyCTyJMi+5rRVhjGpsiE0KHBUgsW8xuktgAlMBdkud462fP2OkB7fGHw2+t2ANA5CzP23IvCOUAaI5++wi0o6U2G9SwKPcqW1JW6e2FJ3gPEqUPNGjklZ9z2JlKVdNrYKoAVXpSfn/0mHYljIhxDovWP4ricV3BWfvLwjCcciWPxmbSxpS3bjDSOzAFP2Uzqoe85858PmCeil1wCabgDhyOTJTwgAtE=
X-Forefront-Antispam-Report: CIP:20.83.241.18;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mailrelay000000.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(136003)(39860400002)(36840700001)(46966006)(40470700004)(83380400001)(82310400005)(110136005)(316002)(81166007)(54906003)(82740400003)(4326008)(26005)(2906002)(36756003)(2616005)(107886003)(9786002)(921005)(8676002)(8936002)(70206006)(478600001)(103116003)(40460700003)(6666004)(186003)(966005)(47076005)(7696005)(426003)(336012)(41300700001)(1076003)(5660300002)(40480700001)(36860700001)(30864003)(102446001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2022 05:43:58.4075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c1c3a7dc-0a6f-4fa9-8496-08da58c9327e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[20.83.241.18];Helo=[mailrelay000000.14r1f435wfvunndds3vy4cdalc.xx.internal.cloudapp.net]
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TreatMessagesAsInternal-DM3NAM02FT029.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR02MB5140
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Triple Modular Redundancy(TMR) Manager is responsible for handling
the TMR subsystem state, including fault detection and error recovery
provides soft error detection, correction and recovery features.

This commit adds support for fault detection feature via
sysfs interface.

Usage:
To know the hardware status:
cat /sys/devices/platform/amba_pl/44a10000.tmr_manager/status
To know the break handler count(Error count):
cat /sys/devices/platform/amba_pl/44a10000.tmr_manager/errcnt

Signed-off-by: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
---
 .../testing/sysfs-driver-xilinx-tmr-manager   |  18 ++
 MAINTAINERS                                   |   7 +
 drivers/misc/Kconfig                          |  10 +
 drivers/misc/Makefile                         |   1 +
 drivers/misc/xilinx_tmr_manager.c             | 288 ++++++++++++++++++
 5 files changed, 324 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
 create mode 100644 drivers/misc/xilinx_tmr_manager.c

diff --git a/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager b/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
new file mode 100644
index 000000000000..c2f615126201
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
@@ -0,0 +1,18 @@
+What:		/sys/devices/platform/amba_pl/<dev>/status
+Date:		June 2022
+Contact:	appana.durga.rao@xilinx.com
+Description:	This control file provides the status of the tmr manager
+		useful for getting the status of fault.
+		This file cannot be written.
+
+What:		/sys/devices/platform/amba_pl/<dev>/errcnt
+Date:		June 2022
+Contact:	appana.durga.rao@xilinx.com
+Description:	This control file provides the fault detection count.
+		This file cannot be written.
+
+What:		/sys/devices/platform/amba_pl/<dev>/dis_block_break
+Date:		June 2022
+Contact:	appana.durga.rao@xilinx.com
+Description:	This control file enables the break signal.
+		This file is write only.
diff --git a/MAINTAINERS b/MAINTAINERS
index 6cc825857722..3d29109788ed 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12962,6 +12962,13 @@ W:	http://www.monstr.eu/fdt/
 T:	git git://git.monstr.eu/linux-2.6-microblaze.git
 F:	arch/microblaze/
 
+MICROBLAZE TMR MANAGER
+M:	Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
+S:	Supported
+F:	Documentation/ABI/testing/sysfs-driver-xilinx-tmr-manager
+F:	Documentation/devicetree/bindings/misc/xlnx,tmr-manager.yaml
+F:	drivers/misc/xilinx_tmr_manager.c
+
 MICROCHIP AT91 DMA DRIVERS
 M:	Ludovic Desroches <ludovic.desroches@microchip.com>
 M:	Tudor Ambarus <tudor.ambarus@microchip.com>
diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index 41d2bb0ae23a..555ae2e33b91 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -483,6 +483,16 @@ config OPEN_DICE
 
 	  If unsure, say N.
 
+config TMR_MANAGER
+	bool "Select TMR Manager"
+	depends on MICROBLAZE && MB_MANAGER
+	help
+	  This option enables the driver developed for TMR Manager. The Triple
+	  Modular Redundancy(TMR) manager provides support for fault detection
+	  via sysfs interface.
+
+	  Say N here unless you know what you are doing.
+
 source "drivers/misc/c2port/Kconfig"
 source "drivers/misc/eeprom/Kconfig"
 source "drivers/misc/cb710/Kconfig"
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 70e800e9127f..28b9803f909b 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -60,3 +60,4 @@ obj-$(CONFIG_XILINX_SDFEC)	+= xilinx_sdfec.o
 obj-$(CONFIG_HISI_HIKEY_USB)	+= hisi_hikey_usb.o
 obj-$(CONFIG_HI6421V600_IRQ)	+= hi6421v600-irq.o
 obj-$(CONFIG_OPEN_DICE)		+= open-dice.o
+obj-$(CONFIG_TMR_MANAGER)	+= xilinx_tmr_manager.o
diff --git a/drivers/misc/xilinx_tmr_manager.c b/drivers/misc/xilinx_tmr_manager.c
new file mode 100644
index 000000000000..5a4562e4a9d4
--- /dev/null
+++ b/drivers/misc/xilinx_tmr_manager.c
@@ -0,0 +1,288 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Xilinx TMR Subsystem.
+ *
+ * Copyright (C) 2022 Xilinx, Inc.
+ *
+ * Description:
+ * This driver is developed for TMR Manager,The Triple Modular Redundancy(TMR)
+ * Manager is responsible for handling the TMR subsystem state, including
+ * fault detection and error recovery. The core is triplicated in each of
+ * the sub-blocks in the TMR subsystem, and provides majority voting of
+ * its internal state provides soft error detection, correction and
+ * recovery. Error detection feature is provided through sysfs
+ * entries which allow the user to observer the TMR microblaze
+ * status.
+ */
+
+#include <asm/xilinx_mb_manager.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+
+/* TMR Manager Register offsets */
+#define XTMR_MANAGER_CR_OFFSET		0x0
+#define XTMR_MANAGER_FFR_OFFSET		0x4
+#define XTMR_MANAGER_CMR0_OFFSET	0x8
+#define XTMR_MANAGER_CMR1_OFFSET	0xC
+#define XTMR_MANAGER_BDIR_OFFSET	0x10
+#define XTMR_MANAGER_SEMIMR_OFFSET	0x1C
+
+/* Register Bitmasks/shifts */
+#define XTMR_MANAGER_CR_MAGIC1_MASK	GENMASK(7, 0)
+#define XTMR_MANAGER_CR_MAGIC2_MASK	GENMASK(15, 8)
+#define XTMR_MANAGER_CR_RIR_MASK	BIT(16)
+#define XTMR_MANAGER_FFR_LM12_MASK	BIT(0)
+#define XTMR_MANAGER_FFR_LM13_MASK	BIT(1)
+#define XTMR_MANAGER_FFR_LM23_MASK	BIT(2)
+
+#define XTMR_MANAGER_CR_MAGIC2_SHIFT	4
+#define XTMR_MANAGER_CR_RIR_SHIFT	16
+#define XTMR_MANAGER_CR_BB_SHIFT	18
+
+#define XTMR_MANAGER_MAGIC1_MAX_VAL	255
+
+/**
+ * struct xtmr_manager_dev - Driver data for TMR Manager
+ * @regs: device physical base address
+ * @dev: pointer to device struct
+ * @cr_val: control register value
+ * @magic1: Magic 1 hardware configuration value
+ * @err_cnt: error statistics count
+ * @phys_baseaddr: Physical base address
+ */
+struct xtmr_manager_dev {
+	void __iomem *regs;
+	struct device *dev;
+	u32 cr_val;
+	u32 magic1;
+	u32 err_cnt;
+	uintptr_t phys_baseaddr;
+};
+
+/* IO accessors */
+static inline void xtmr_manager_write(struct xtmr_manager_dev *xtmr_manager,
+				      u32 addr, u32 value)
+{
+	iowrite32(value, xtmr_manager->regs + addr);
+}
+
+static inline u32 xtmr_manager_read(struct xtmr_manager_dev *xtmr_manager,
+				    u32 addr)
+{
+	return ioread32(xtmr_manager->regs + addr);
+}
+
+/**
+ * xtmr_manager_unblock_break - unblocks the break signal
+ * @xtmr_manager: Pointer to xtmr_manager_dev structure
+ */
+static void xtmr_manager_unblock_break(struct xtmr_manager_dev *xtmr_manager)
+{
+	xtmr_manager->cr_val &= ~(1 << XTMR_MANAGER_CR_BB_SHIFT);
+	xtmr_manager_write(xtmr_manager, XTMR_MANAGER_CR_OFFSET,
+			   xtmr_manager->cr_val);
+}
+
+/**
+ * xmb_manager_reset_handler - clears the ffr register contents
+ * @priv: Private pointer
+ */
+static void xmb_manager_reset_handler(void *priv)
+{
+	struct xtmr_manager_dev *xtmr_manager = (struct xtmr_manager_dev *)priv;
+	/* Clear the FFR Register contents as a part of recovery process. */
+	xtmr_manager_write(xtmr_manager, XTMR_MANAGER_FFR_OFFSET, 0);
+}
+
+/**
+ * xmb_manager_update_errcnt - update the error inject count
+ * @priv: Private pointer
+ */
+static void xmb_manager_update_errcnt(void *priv)
+{
+	struct xtmr_manager_dev *xtmr_manager = (struct xtmr_manager_dev *)priv;
+
+	xtmr_manager->err_cnt++;
+}
+
+static ssize_t errcnt_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct xtmr_manager_dev *xtmr_manager = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%x\n", xtmr_manager->err_cnt);
+}
+static DEVICE_ATTR_RO(errcnt);
+
+static ssize_t status_show(struct device *dev, struct device_attribute *attr,
+			   char *buf)
+{
+	struct xtmr_manager_dev *xtmr_manager = dev_get_drvdata(dev);
+	size_t ffr;
+	int len = 0;
+
+	ffr = xtmr_manager_read(xtmr_manager, XTMR_MANAGER_FFR_OFFSET);
+	if ((ffr & XTMR_MANAGER_FFR_LM12_MASK) == XTMR_MANAGER_FFR_LM12_MASK) {
+		len += sprintf(buf + len,
+			       "Lockstep mismatch between processor 1 and 2\n");
+	}
+
+	if ((ffr & XTMR_MANAGER_FFR_LM13_MASK) == XTMR_MANAGER_FFR_LM13_MASK) {
+		len += sprintf(buf + len,
+			       "Lockstep mismatch between processor 1 and 3\n");
+	}
+
+	if ((ffr & XTMR_MANAGER_FFR_LM23_MASK) == XTMR_MANAGER_FFR_LM23_MASK) {
+		len += sprintf(buf + len,
+			       "Lockstep mismatch between processor 2 and 3\n");
+	}
+
+	return len;
+}
+static DEVICE_ATTR_RO(status);
+
+static ssize_t dis_block_break_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t size)
+{
+	struct xtmr_manager_dev *xtmr_manager = dev_get_drvdata(dev);
+	int ret;
+	long value;
+
+	ret = kstrtoul(buf, 16, &value);
+	if (ret)
+		return ret;
+
+	if (value > 1)
+		return -EINVAL;
+
+	xtmr_manager_unblock_break(xtmr_manager);
+	return size;
+}
+static DEVICE_ATTR_WO(dis_block_break);
+
+static struct attribute *xtmr_manager_attrs[] = {
+	&dev_attr_dis_block_break.attr,
+	&dev_attr_status.attr,
+	&dev_attr_errcnt.attr,
+	NULL,
+};
+ATTRIBUTE_GROUPS(xtmr_manager);
+
+static void xtmr_manager_init(struct xtmr_manager_dev *xtmr_manager)
+{
+	/* Clear the SEM interrupt mask register to disable the interrupt */
+	xtmr_manager_write(xtmr_manager, XTMR_MANAGER_SEMIMR_OFFSET, 0);
+
+	/* Allow recovery reset by default */
+	xtmr_manager->cr_val = (1 << XTMR_MANAGER_CR_RIR_SHIFT) |
+				xtmr_manager->magic1;
+	xtmr_manager_write(xtmr_manager, XTMR_MANAGER_CR_OFFSET,
+			   xtmr_manager->cr_val);
+	/*
+	 * Configure Break Delay Initialization Register to zero so that
+	 * break occurs immediately
+	 */
+	xtmr_manager_write(xtmr_manager, XTMR_MANAGER_BDIR_OFFSET, 0);
+
+	/*
+	 * To come out of break handler need to block the break signal
+	 * in the tmr manager, update the xtmr_manager cr_val for the same
+	 */
+	xtmr_manager->cr_val |= (1 << XTMR_MANAGER_CR_BB_SHIFT);
+
+	/*
+	 * When the break vector gets asserted because of error injection,
+	 * the break signal must be blocked before exiting from the
+	 * break handler, Below api updates the TMR manager address and
+	 * control register and error counter callback arguments,
+	 * which will be used by the break handler to block the
+	 * break and call the callback function.
+	 */
+	xmb_manager_register(xtmr_manager->phys_baseaddr, xtmr_manager->cr_val,
+			     xmb_manager_update_errcnt,
+			     xtmr_manager, xmb_manager_reset_handler);
+}
+
+/**
+ * xtmr_manager_probe - Driver probe function
+ * @pdev: Pointer to the platform_device structure
+ *
+ * This is the driver probe routine. It does all the memory
+ * allocation and creates sysfs entries for the device.
+ *
+ * Return: 0 on success and failure value on error
+ */
+static int xtmr_manager_probe(struct platform_device *pdev)
+{
+	struct xtmr_manager_dev *xtmr_manager;
+	struct resource *res;
+	int err;
+
+	xtmr_manager = devm_kzalloc(&pdev->dev, sizeof(*xtmr_manager),
+				    GFP_KERNEL);
+	if (!xtmr_manager)
+		return -ENOMEM;
+
+	xtmr_manager->dev = &pdev->dev;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	xtmr_manager->regs =  devm_ioremap_resource(xtmr_manager->dev, res);
+	if (IS_ERR(xtmr_manager->regs))
+		return PTR_ERR(xtmr_manager->regs);
+
+	xtmr_manager->phys_baseaddr = res->start;
+
+	err = of_property_read_u32(pdev->dev.of_node, "xlnx,magic1",
+				   &xtmr_manager->magic1);
+	if (err < 0) {
+		dev_err(&pdev->dev, "unable to read xlnx,magic1 property");
+		return err;
+	} else if (xtmr_manager->magic1 > XTMR_MANAGER_MAGIC1_MAX_VAL) {
+		dev_err(&pdev->dev, "invalid xlnx,magic1 property value");
+		return err;
+	}
+
+	/* Initialize TMR Manager */
+	xtmr_manager_init(xtmr_manager);
+
+	err = sysfs_create_groups(&xtmr_manager->dev->kobj,
+				  xtmr_manager_groups);
+	if (err < 0) {
+		dev_err(&pdev->dev, "unable to create sysfs entries\n");
+		return err;
+	}
+
+	platform_set_drvdata(pdev, xtmr_manager);
+
+	return 0;
+}
+
+static int xtmr_manager_remove(struct platform_device *pdev)
+{
+	sysfs_remove_groups(&pdev->dev.kobj, xtmr_manager_groups);
+
+	return 0;
+}
+
+static const struct of_device_id xtmr_manager_of_match[] = {
+	{
+		.compatible = "xlnx,tmr-manager-1.0",
+	},
+	{ /* end of table */ }
+};
+MODULE_DEVICE_TABLE(of, xtmr_manager_of_match);
+
+static struct platform_driver xtmr_manager_driver = {
+	.driver = {
+		.name = "xilinx-tmr_manager",
+		.of_match_table = xtmr_manager_of_match,
+	},
+	.probe = xtmr_manager_probe,
+	.remove = xtmr_manager_remove,
+};
+module_platform_driver(xtmr_manager_driver);
+
+MODULE_AUTHOR("Xilinx, Inc");
+MODULE_DESCRIPTION("Xilinx TMR Manager Driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

