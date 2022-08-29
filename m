Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AE785A45BA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbiH2JHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiH2JHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:07:47 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D188057E38;
        Mon, 29 Aug 2022 02:07:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pdlge78N6kJLaPg1BkduSl+O662qTopfuOyQiDFrih8fPUynVwS1gxhvYLbV35CXDPA7ExNcHfkky7Qh+S31m8TSWxVNp1Xu54t6MqkDwTQq0b/ZWjwfHWZfodlcNXe/ivusKDx1jwNyv/+jy6Ev0h8A25svK5PKiSKVyRB7NJjSQTVOho6WRekRVJ9snblBe2C8j7aXFwfTQnvVb1mGQ98hJmp8US6G0hKmNnR+GfoQS32rvjp3tEAmzpLsR2PrH7gRqAHyJKBdQL4h+2O2ogl+RMZ5FLoehzeGZ9Yi/coJdW3tToL7yrVPwPXIh0s1Emv665CB+xhUC5yrNSC6LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uw+0Nn2VGw3BeggEgeupW1NyCVVLROEGuHfbR43+4yA=;
 b=Ua4ljIMx0sdnGak3JwEX07z80YjJ7E9hCNLAym/biVgCOqIH8eackFYpd6dWOdB6WNserBvcireyoHJHig1FqWepZ5xMlSy3yfRVIZdSHWhtSiYPqUJFNc7ul0zz53ZDGfp+UDzbihzFre6cKh6zvUyRAA1LSzkn+6JcaWWBU8npjIN8lnu6T1C5QUU0yz4ctJdcCn5LugUMIEy9sJq2C0o7TpK97xU8D6tlPCmmeobdV+ueVCWQhPX2kiTQRaowf/WlocS7LaJaM8hBkUIV8F7VkHrXL434d1QMvXspQxf7HmXH0KgXXmU+6RSfD3E52TG9YrKzNaiUm+OtbgB7lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uw+0Nn2VGw3BeggEgeupW1NyCVVLROEGuHfbR43+4yA=;
 b=yQrxZCtEGVilPEQEaqbbRHi89f6hT81Txg7fTPhPfYwUntNudTmxYXXumk7rAy9SbbkJsm1sGC7FkVvXbeiNQ8VVW0U/l0vRYSe3sw/miPeVb5SzVlY5agCOX2N+FAgDfA6sJ54wz74Y/joi4hFdmWgTWYCVrnrFxzMFuLRISjk=
Received: from DM6PR21CA0001.namprd21.prod.outlook.com (2603:10b6:5:174::11)
 by SA1PR12MB6821.namprd12.prod.outlook.com (2603:10b6:806:25c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Mon, 29 Aug
 2022 09:07:40 +0000
Received: from DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::4b) by DM6PR21CA0001.outlook.office365.com
 (2603:10b6:5:174::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.2 via Frontend
 Transport; Mon, 29 Aug 2022 09:07:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT104.mail.protection.outlook.com (10.13.173.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Mon, 29 Aug 2022 09:07:39 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 04:07:38 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 29 Aug
 2022 02:07:38 -0700
Received: from xhdlakshmis40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Mon, 29 Aug 2022 04:07:34 -0500
From:   Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        "Vignesh Raghavendra" <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
CC:     <devicetree@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <saikrishna12468@gmail.com>,
        <git@amd.com>, Sai Krishna Potthuri <sai.krishna.potthuri@amd.com>
Subject: [PATCH 0/2] mtd: spi-nor: Add flash device reset support
Date:   Mon, 29 Aug 2022 14:35:26 +0530
Message-ID: <20220829090528.21613-1-sai.krishna.potthuri@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15643229-f56c-46e0-ba38-08da899dec74
X-MS-TrafficTypeDiagnostic: SA1PR12MB6821:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f420Ea2F7hWQbH4lXRIiVxcBEsUmAEhAK6/9cIKo0bubjljmgES9B4U24zQJ0l/CHNjiN/L9Blod/RWFJSpzl5ZmAc78W70DJ0vQ6Qi0LrHuYC7IyCWlF+BRGWvxcSWRSreQZf6ymgQbFfy4soDQ1kN4YKlKW5ejQClgldssanD1lsFfgaD2CmepVKLAyHu3KDAwe8l4NpB3rXyulf3T9JF2s6jQlNzChCHThO7RFhKqO3riKb8POsyr6WfOoRAAaUsaDPu/EzG1xRuuKs0xIGni9pvA4/js/8oQAdaPLlTF0JZiTIBWU/afmzEvJWBRLEEvZ/7jAsnRsyUFVLGRTB/v3Z4CRGK/lnJZ5oixffkwnfx3qbpkroAPMgF+K1lO8w3pg69Me9FBFRKRFFE5bju+tunLMECe+Xe1jM/9T2HdWOSHHou7s2UtMBlQoPzu9zXTGqjT6J2sgHjUmMXUncokUD/tkkAgszB5hcZOJF9pBpDtdhmZ4o4x2p/CUTla/gdXrCaXa5DpQWspw+LDdDv3YKQwxdfdS7hjKwOOYCkIm8Om6oCwXAOPAMEOXCCH5PPPFPacxImO7KOEOb1wq6F6z9TdZlcbqQVH9uY9oMeXzWqZjg61M1QGgM1hYtos9DT2+CRu+by1YHWOzIYjuKxuCsa1trpBH5BJhBYsRf1YgeJw1oVBYGiy6KzS8N6Pj3TKgLjmqZrMT1Hj8byHOq3oFB8fRs5yTSe0PYJP/V166vzcBlQVW+1RdxBZI1BMifpY0mz18iLlq7unrvhIszgvyuJx7upWFPSgSzasnAg=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(396003)(136003)(346002)(376002)(46966006)(40470700004)(36840700001)(81166007)(186003)(82310400005)(86362001)(356005)(110136005)(47076005)(2616005)(82740400003)(316002)(40460700003)(54906003)(36756003)(1076003)(426003)(70206006)(5660300002)(26005)(36860700001)(70586007)(4744005)(478600001)(8936002)(4326008)(40480700001)(41300700001)(8676002)(336012)(7416002)(6666004)(103116003)(83380400001)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 09:07:39.5196
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15643229-f56c-46e0-ba38-08da899dec74
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6821
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series update spi-nor dt-binding and spi-nor core to support
flash device reset using reset-gpios property.

Sai Krishna Potthuri (2):
  dt-bindings: mtd: spi-nor: Add reset-gpios property
  mtd: spi-nor: Add support for flash reset

 .../bindings/mtd/jedec,spi-nor.yaml           |  6 +++
 drivers/mtd/spi-nor/core.c                    | 50 +++++++++++++++++--
 2 files changed, 52 insertions(+), 4 deletions(-)

-- 
2.17.1

