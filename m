Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88AFD4BA970
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:15:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245070AbiBQTPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:15:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245052AbiBQTPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:15:02 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F234F90265;
        Thu, 17 Feb 2022 11:14:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxgVq/qWQt5HMdLdcHq04K1PGvWJLL07iRxJwyfdbA1sOv2t19VFtpSK0FvMPOTOubYXnmRDaV/88Z4uDjif/Y3umkXq3xmnUmHAdUEUD6XwyhSXsa7ybTMF2yY3tsrfYJ7S20dHQ0jggDohJH6D9o3ijRCYLpMQ5SZqnUZBcHFcdbI7SSMC9iqZvZHmgVzRuomQHheIT2PVQLclSW/8DWpaABE7Ql4ypTiaUzKFyWE5T4xR2eFwY+6L8oT35jvDuppf6ccTS7iwMOOg6tmmNz5l/o/2K6rDE9ZLOJ6hL8LUsGFcBhEWtBD1P+G3ofYKo3lrN9HMEpaMsNWU+FPnvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CuT+Fxx/s+iFZhmctPLI+eHNZRpiHpVzj6HCIZt7iNQ=;
 b=ir4iWs+3lskrU3HmDVoTwo6V8Jj7R1p+YbO2NeSG0M/PMn7O4UeHlyvFySK6ErAs+mmFT6hNUuujfpSw46n6l9UFCrWssUfNpgltFVGl/7nGGmigb/haAyQFCYYtvcNwBfARM5cNuZ+D7iyRD3LAKg98BUr4k+84L9Y6dsFp6vRfYzCW1V339Jc9LDzNODnGhAZBKp5VpLGDIfIFLz5i1NuRyQVmFPL0DR64M88iwj0Y9DPsxxdJkSUVrA/0Zbpa0a4abMH9tzfM7ZVGNds7QkQ+wsxFHKRLvJf26RSyXnUQOBHfp2fVXltgx2Nn6cam8JoTgc0ONlJkSr/uZIMLVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=gondor.apana.org.au
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CuT+Fxx/s+iFZhmctPLI+eHNZRpiHpVzj6HCIZt7iNQ=;
 b=sFpMXoDa4jRaGUTKrlhuBXr6YPpypZAFrNCXoBzzhcWKU8yIET+2MI+j77xUD24AudHQp1errAjuKKplvW8Atapubyj4r6gxnMp8BbPeCpAGUbk0rwzFPxPkz5jqb/LcQr0GxR3U2926Rq6J0V+7nSMVJvXICZ+iyQjDE4hU6+U=
Received: from SA9P221CA0020.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::25)
 by CY4PR02MB3253.namprd02.prod.outlook.com (2603:10b6:910:80::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.17; Thu, 17 Feb
 2022 19:14:45 +0000
Received: from SN1NAM02FT0003.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:25:cafe::18) by SA9P221CA0020.outlook.office365.com
 (2603:10b6:806:25::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16 via Frontend
 Transport; Thu, 17 Feb 2022 19:14:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0003.mail.protection.outlook.com (10.97.4.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4975.11 via Frontend Transport; Thu, 17 Feb 2022 19:14:44 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 17 Feb 2022 11:14:29 -0800
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 17 Feb 2022 11:14:29 -0800
Envelope-to: git@xilinx.com,
 herbert@gondor.apana.org.au,
 davem@davemloft.net,
 linux-crypto@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Received: from [10.140.6.15] (port=57270 helo=xhdharshah40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <harsha.harsha@xilinx.com>)
        id 1nKmEW-0002nF-K3; Thu, 17 Feb 2022 11:14:29 -0800
From:   Harsha <harsha.harsha@xilinx.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <michals@xilinx.com>
CC:     <saratcha@xilinx.com>, <harshj@xilinx.com>, <git@xilinx.com>,
        Harsha <harsha.harsha@xilinx.com>
Subject: [PATCH V2 0/4] crypto: Add Xilinx ZynqMP SHA3 driver support
Date:   Fri, 18 Feb 2022 00:44:20 +0530
Message-ID: <1645125264-11033-1-git-send-email-harsha.harsha@xilinx.com>
X-Mailer: git-send-email 1.8.2.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 54292213-ebd0-496a-c962-08d9f249c16b
X-MS-TrafficTypeDiagnostic: CY4PR02MB3253:EE_
X-Microsoft-Antispam-PRVS: <CY4PR02MB3253AB6A73585C652CB3B730DE369@CY4PR02MB3253.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 81TqV9NdDqrumSoeyAzoi7O7McW0D070C+Aoi4j7+/15h7quAi+qLxwi+dT5prq9H3eyPZzeCVfKk08SFepaPYI9qGTdx2v7QSUMVCqlvln3lVRqmlpWCSUIjnecr8+ajtHgeLx0SOrT0rrPP10EUvcrjyIlo4M8yGzSX80owNg3gw8uzPGW/4XYkT4qYmGuY5oBJ1C+eTvDd7BySv+KiakwM8mzOTKDNFUfLuY2ozKZlw/Q7H6bxzrr6BqRryKbMnKz8MHIdjEyN9up6w6B+z7mqCbn65qQaVQcOKHskmTuQLpHwPx9FnlHHtF5JxWaLxEvHvmLGcSaFiBDWiEBTWLyU/WWpHiskTI3u2Mlfv91RFRkwxPn24cx72LsqquUzwpXPPGQCxcQORJAtsZ0CHsuv6utW5lpF15M2tJ/Gq4m68snvpPyoWDv+EDIUGyxClVD2ysZUNoiBMc34ovJrJo6490Rzu8RMxSWM3exdsyrzjlJoIJd8xzHT9ijVRTBiyRcgFhlSTtPNCd6whPVqSDPD/zruoZbRtBSpez/VXGj6juAEoXI2h7AE5mVdSJPztYew+kN9SmEUUvtkfOj+rpron+WxnjMHD3LU23qi9kwIpYOCnQKjmUcF6EIH+bHZWzqYzhiIZlJjQaDUxmjzraDwDCW9zLohpOCXIal6DBFdS2ebnASk1ysxqhZQZmQBIPHGbzTgKpwyZdIzAyfQPP8oUMVloMKdQ14ayms++E=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(336012)(40460700003)(508600001)(26005)(2616005)(186003)(7696005)(426003)(82310400004)(6666004)(107886003)(83380400001)(7636003)(356005)(2906002)(36756003)(47076005)(36860700001)(110136005)(54906003)(8676002)(5660300002)(4326008)(8936002)(6636002)(9786002)(70586007)(70206006)(316002)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 19:14:44.0455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54292213-ebd0-496a-c962-08d9f249c16b
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0003.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR02MB3253
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch set does the following:
  - Updates the Makefile for xilinx subdirectory
  - Adds communication layer support for sha_hash in zynqmp.c
  - Adds Xilinx ZynqMP driver for SHA3 Algorithm
  - Updates the list of MAINTAINERS

V2 changes:
- Removed dependency on COMPILE_TEST in 3/4
- Rebased this patchset on latest Cryptodev-2.6 tree which fixed
below kernel robot warning
   In file included from ./arch/s390/include/generated/asm/cacheflush.h:1,
                    from drivers/crypto/xilinx/zynqmp-sha.c:6:
include/asm-generic/cacheflush.h:53:46: warning: 'struct folio' declared
inside parameter list will not be visible outside of this definition
or declaration
      53 | static inline void flush_dcache_folio(struct folio *folio) { }
         |
- Included linux/cacheflush.h instead of asm/cacheflush.h in 3/4
 

V1 changes:
- Converted RFC patch to PATCH
- Updated zynqmp-sha driver so that it can be self discovered 
- Removed patch 3/6 and 4/6 as they added support for device tree
- Substituted hw with hardware in drivers/crypto/Kconfig

Harsha (4):
  drivers: crypto: Updated Makefile for xilinx subdirectory
  firmware: xilinx: Add ZynqMP SHA API for SHA3 functionality
  crypto: xilinx: Add Xilinx SHA3 driver
  MAINTAINERS: Add maintainer for Xilinx ZynqMP SHA3 driver

 MAINTAINERS                          |   5 +
 drivers/crypto/Kconfig               |  10 ++
 drivers/crypto/Makefile              |   2 +-
 drivers/crypto/xilinx/Makefile       |   1 +
 drivers/crypto/xilinx/zynqmp-sha.c   | 285 +++++++++++++++++++++++++++++++++++
 drivers/firmware/xilinx/zynqmp.c     |  26 ++++
 include/linux/firmware/xlnx-zynqmp.h |   8 +
 7 files changed, 336 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/xilinx/zynqmp-sha.c

-- 
1.8.2.1

