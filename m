Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EBB5198F8
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 09:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345857AbiEDH5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 03:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237497AbiEDH5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 03:57:19 -0400
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam08on2047.outbound.protection.outlook.com [40.107.100.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDC9A15701;
        Wed,  4 May 2022 00:53:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YWSTRdJTXrKhJWqQY0l+hbSwZVNmQBqdsRURnG+hPd3ZF942YECNRbK08GYspSs1cV878nrcisEYvz+VlAwKfpCfPzsKoVbIvD4V9waX9d2RSoLsUe36T/mLUIxh6KBrhqCCvrQ8Ua+ZMlX2tB6IubRRNA5hMzY7z+UkkLPR8IhTOU99ue3CfoBfs8ylVLyRY5PM35MIKsvUJViiJ32ipsqCklVNHbzsZk6Y+/8urNV12USBi8Z07ALyufmgElGCE9uSONIj/88CpptbTUj2Q1vCdWX5i5yMR/yg/fmLvTWVU5Vl0OEgyaJgENZia8ggjl42XGM9wtqyYRc5CuoIVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FKXEeDDylN8dFZqdaIZbAZP1J8V+oOvfmUZ3X6oziT4=;
 b=aW8IBftq5uXHO8rK78HvFQ67yw9VmGcxi4ZKDTK0KT0NNzJIUMVgwMxNmyn7hR6jL8nhAgePX4svNqtfrg3vATeBM+7YMjAC4VbIxqED6qc5uN5OuzAHyt8OGx7jEJgurW6h5nrx38Zfp0nesOfLZxowpl2v9c2nuQlwc5xKKtQqjAQGCGxZ3LRU0axaCfhzWLfx6vo6hy6RrARLregXBOWEvKBZ8iuWzeOXpvt5CGX5PCvnsV694j57DXsfwxoXDRiSbRzi2YUUoMOwBxEptKhC+WfpNbUKN/eEj/khZpvMIVfhmnQ0s5PWSV7SsujkGosHJ7J+F1Avbnxvn7SzgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FKXEeDDylN8dFZqdaIZbAZP1J8V+oOvfmUZ3X6oziT4=;
 b=JC71agcX3+bVCSZ+ujbNZw1GEtxSDho/fMrSBzwCb5zQ5ytUNKB6p12SvHJlm5v/f1vNc0JxOOHUPpwQ+qZv2RyYmUw3jIW6ICQEzWLtjSev9LK5JxAyh+8MbXUkvxeqUJIuhUhvtlSbi5SZGezI8SkiT270ycfPXGidRQDvOSY=
Received: from SA0PR11CA0013.namprd11.prod.outlook.com (2603:10b6:806:d3::18)
 by CY4PR02MB2536.namprd02.prod.outlook.com (2603:10b6:903:71::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.26; Wed, 4 May
 2022 07:53:40 +0000
Received: from SN1NAM02FT0050.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:d3:cafe::a6) by SA0PR11CA0013.outlook.office365.com
 (2603:10b6:806:d3::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Wed, 4 May 2022 07:53:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0050.mail.protection.outlook.com (10.97.5.121) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Wed, 4 May 2022 07:53:39 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 4 May 2022 00:53:38 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 4 May 2022 00:53:38 -0700
Envelope-to: git@xilinx.com,
 gregkh@linuxfoundation.org,
 balbi@kernel.org,
 robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org,
 linux-usb@vger.kernel.org,
 devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.18] (port=46956 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1nm9pJ-000B5T-Q9; Wed, 04 May 2022 00:53:38 -0700
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     <gregkh@linuxfoundation.org>, <balbi@kernel.org>,
        <radheys@xilinx.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <michal.simek@xilinx.com>,
        <manish.narani@xilinx.com>
CC:     <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <git@xilinx.com>,
        <sivadur@xilinx.com>, Piyush Mehta <piyush.mehta@xilinx.com>
Subject: [PATCH 0/2] usb: dwc3: xilinx: Add gpio-reset support
Date:   Wed, 4 May 2022 13:23:07 +0530
Message-ID: <20220504075309.6244-1-piyush.mehta@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55f3ca62-e9af-45dd-e549-08da2da333aa
X-MS-TrafficTypeDiagnostic: CY4PR02MB2536:EE_
X-Microsoft-Antispam-PRVS: <CY4PR02MB2536AE3DE8015D864BAB4C37D4C39@CY4PR02MB2536.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 995iVR33dnTE68o9vh8zOUaj5GwUBscJTrOzAlWgr85GbcAE3FcDkc+qeEBeaeLfrVaROsqNrb0ip1ZXlflkTnIBZvAtNs2gi7mw+u6m3lcsBPvedm+B0+Bf+QVrdH8CRXAVpvxgJsru9aUg5yaOA8Difk08dU+1uLu8Ras7AFoe9GR9YUYu6eCpDTnlUDF3TeKu8oFvDkMq7dD/eD+KaRa5UixLPOwMV/rAH18qk/wH0xQohoSQjEOMSr/Cb3t1BwXnRj2TI7r34K4tZ5P0k9hLcgURwEPKC/kt4k96kq77URSIPb+X3VEQJLKr9NDUCWPoSfEol8y0Q1su8byzy5tP/rrMAynoWAKYnRLGSDu+WIxVhoYN15WUiqAihBF7J8xIzsmE8T3x/BYPFv/5qQPkZNIlN09ADH8FRehvrjqUperVAbZFEtaWXbvX4212ps6OS/mpgWFE9U1XdiGF5Zc/ONeAOt2T4MwVX/mNCoV1cvy4HFhZKLvvtF25kjyNljIi6sPQzfME9tp9/tOVpnfNDloMSaEhJk/SjXclZ+311cfJldEmmxAL6dGGVVa14imyeOjFYbJsehzZK8qZm6aVHQma75Fc9Zhm6mZALLCwjOu7dvQB2sAmuN+dAA0mFHHBcjAwK5bMRHDC+svK5RNgFwYxh7RT5TIlV5m3j8WpxI67rbk0vldr3WKnxztMHwfkiffS8BI97pUWM8XQkJncAk3Go7lU8IR3hVMlheU=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(4744005)(8936002)(44832011)(4326008)(508600001)(9786002)(5660300002)(82310400005)(356005)(7636003)(2906002)(40460700003)(6666004)(54906003)(110136005)(107886003)(316002)(186003)(6636002)(336012)(36756003)(2616005)(426003)(47076005)(36860700001)(1076003)(70586007)(70206006)(8676002)(26005)(7696005)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2022 07:53:39.5322
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55f3ca62-e9af-45dd-e549-08da2da333aa
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0050.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB2536
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These series of patches adds gpio-reset support in the dwc3-xilinx
glue driver.

The optional property added in dwc3-xilinx Linux binding document
and based on the 'reset-gpios' property dwc3-xilinx driver trigger
the GPIO ulpi-phy reset.

This reset is specific to the zynqMp.

Piyush Mehta (2):
  dt-bindings: usb: dwc3-xilinx: add optional property reset-gpios
  usb: dwc3: xilinx: Add gpio-reset support

 Documentation/devicetree/bindings/usb/dwc3-xilinx.yaml |  4 ++++
 drivers/usb/dwc3/dwc3-xilinx.c                         | 17 +++++++++++++++++
 2 files changed, 21 insertions(+)

-- 
2.7.4

