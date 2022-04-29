Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89BEB5143B8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355446AbiD2IRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239059AbiD2IRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:17:48 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E870DC0E56;
        Fri, 29 Apr 2022 01:14:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=foynttQot1E/ReRDVR71QH4HNwja2hM2VxXI6eeE7sveyLUDFjaP4BMTQAPwF71uF23gnj3GGB5vequOHk2SzZ+Lck/Xy295epZioSMWV56sa0MZIMfCxAJhPLEfkeumnSGHYO0/Mr095bYatynWk0qyXRH4UBhWmiPIGNMHmsAwNXTijF+SxmCKUx8dMWsDjszwPAi/dX89ouAConUmUcCWxKaH3kgw3z9NssDU3/DxYAw9G2QZYvvWCjWR5rujq/1uapvcjlf2bT5s77S5d5Yw1r9zM3jjTJhNOlbY+p78jF5ooxNFvcb4RvVXjbSp3V3QaPIK2R36c+phGsZLnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJUDbDdXEMGq3tUAaoyM2iuT8EMdck6VlvXDSVGvrKc=;
 b=P/mBIEfxnbYwayV+g/jPH3roPR3NTNbtodvvd9+Y0zHVbg4ibB1JnRXNphkPpNUDVv/5epwx5GkmK9wCB8dGqDXc4iSnhxsTg69yovlk6KZor2XaaIdL0CuNjbs5vwFUywjXoR6ghe3CbXlbHoVrS1Yqhk+EQ3EfGSBTsvLNPyUwQT3EPoCzZK9G/xIiSWJQ78z/rMt9vawj4SrSS98v/dOKmUwTOVSEjfMpQaEAgee/kkmvWjChuAdV/mGKOb4H8pwjQLlwQQYeDuuqdmd06//jfsXEhtg2VtpTw6qvY4qvPkrp01JxMalKm7wfmqydCR756OY2GgzyO9+HTq9oQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJUDbDdXEMGq3tUAaoyM2iuT8EMdck6VlvXDSVGvrKc=;
 b=rWVvm2J/NU6Kr6HwN/54DyJ1rlHO5jXhbdcy1WUEWMI/oQBZXNUTOe0vwQDlWvCzbzVrzYlWEuPW+aOn6L0so9GQUzM6OqV7LoXgXCcNIxLfJDKJ+YjEICfQVFURzGDAsPo3Zbp0Epqa0qHi48VnqTOziVgvg3P+00XQhiw/kiY=
Received: from DM6PR12CA0030.namprd12.prod.outlook.com (2603:10b6:5:1c0::43)
 by SA1PR02MB8383.namprd02.prod.outlook.com (2603:10b6:806:1f2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 08:14:28 +0000
Received: from DM3NAM02FT021.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:1c0:cafe::53) by DM6PR12CA0030.outlook.office365.com
 (2603:10b6:5:1c0::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 08:14:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT021.mail.protection.outlook.com (10.13.4.249) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 08:14:28 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 29 Apr 2022 01:14:27 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 29 Apr 2022 01:14:27 -0700
Envelope-to: git@xilinx.com,
 linux-serial@vger.kernel.org,
 jirislaby@kernel.org,
 gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.39] (port=57162 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1nkLli-0002va-Rm; Fri, 29 Apr 2022 01:14:27 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-serial@vger.kernel.org>
CC:     <michal.simek@xilinx.com>, <jirislaby@kernel.org>,
        <gregkh@linuxfoundation.org>, <git@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 0/7] tty: xilinx_uartps: fixes and improvements
Date:   Fri, 29 Apr 2022 13:44:15 +0530
Message-ID: <20220429081422.3630070-1-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3eba4c97-009c-4cd1-050f-08da29b8481e
X-MS-TrafficTypeDiagnostic: SA1PR02MB8383:EE_
X-Microsoft-Antispam-PRVS: <SA1PR02MB83831AA1391093BDCC6996AFAAFC9@SA1PR02MB8383.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DhZQEYTOh0QKHXgn+NSiXA3hQJDOM/eqpA9zEuFm7FYi7vfEu6vvITLEQEiu3Ygq1SU9wzeuPEahHG4oNODFjX8AuK/lCfS4NuFSiI9F4UkXuh18ZLaoqVOD03sUmfRvdbvVwqLe3F9BzpmQO36eC3b2i9lkJdULbKhcs7ClVR+jwQGRgu+KuWU15+pHg2cg6UGMU++nFMXDG/nKJlVIlZwSPB4vx2glIk3EPXo5g7hCq0ltfWUngbawAaxlKeyYsHqcFMikou/W0Kc+DnHdrdr6tr6kFbSTQYT3yAJIOaPz22hMQfNvzx4a+DTTDwKvCxYxJHq0RGbd8Faey0bDIBDb58Im2e4lHN8oTaCgJ4cTz+gSo0eGMcdZ/rR5sYhnFmqOeUrpkTUP47NkSp62JcdYE2JkqaeCZYK6AvLMPVi0OgDSI9ltABqzb66VEi37vWR9fNPrO3nAwQFiH7Ok68VPDfAGJzovqpVdMd3TGBdmAbgl84VNr1iEvwSAjSO32ZanGWtLKX5c5jI6mJjnW4XlacYVgbpy8DOsjRn7ebkUJ8fYPeUihfkbrY1u4FYupytQkjz0fJWciDfB8kObhTPG0p2lqMeVoHvJYitxm7CS76BS9TYrZudjDULgazesF2ENE067pIzar5kFpqsqngx43sNWpA4TpLV41cbp8GuKHGgkCOM56Y8S0cAb++poh3zFd82ytIbb9jtt5yOe+A==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(54906003)(82310400005)(6916009)(36860700001)(336012)(83380400001)(316002)(26005)(186003)(7636003)(36756003)(47076005)(426003)(44832011)(1076003)(40460700003)(508600001)(107886003)(8676002)(70206006)(2616005)(6666004)(2906002)(5660300002)(4744005)(4326008)(7696005)(9786002)(8936002)(356005)(70586007)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 08:14:28.6057
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3eba4c97-009c-4cd1-050f-08da29b8481e
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT021.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB8383
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Many of the stuff is reported by static analysis
changes are 

- Update the copyright text
- Check the return valuesof runtime and clock enable calls
- Check the ignore_status in the isr 
- Prevent writing to the fifo when controller is disabled.

Michal Simek (1):
  xilinx: Update copyright text to correct format

Shubhrajyoti Datta (6):
  tty: xilinx_uartps: Check the clk_enable return value
  tty: xilinx_uartps: Add check for runtime_get_sync calls
  tty: xilinx_uartps: Check clk_enable return type
  tty: xilinx_uartps: Make the timeout unsigned
  serial: uartps: Fix the ignore_status
  serial: uartps: Prevent writes when the controller is disabled

 drivers/tty/serial/xilinx_uartps.c | 45 ++++++++++++++++++++++++------
 1 file changed, 37 insertions(+), 8 deletions(-)

-- 
2.25.1

