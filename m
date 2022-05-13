Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72EB052622B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 14:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380370AbiEMMl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 08:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230340AbiEMMlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 08:41:46 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150122.outbound.protection.outlook.com [40.107.15.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6449536317;
        Fri, 13 May 2022 05:41:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jo4Jc3ITjKHHf9EsJj43U9BNqcN0zWz6Z5G8La9zJtPsKx4ADvuLoZd3ULWxV8P2yHUeF/90RnFmDOGM4qkaMiHg24wJUvqHpj6YkifNkLlKbVhETYxINYd58YrTAJZBPIlP4Kub4FvImAfqcLTcIBx9pVwwUmcYw1wS5+qhFN7PSl//0vbspFbgZpHLGE9yIMfa18DBRTTZvk9p8vmlTxTd3GJwwGdv8bIskwqGHrL0CSYBc7Nia+hhqhbB5zS4CW3Glsb+K5DLCtQH9w1KjyrGucpPHPQvHgslrMYfqppaOrbJrn5sPdETh7BfMR8J9AsU5YHxVFKs6QNGlEwLpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ELU1WXMI2cudFkUdRUNXSRoO0+8T5o07hwjHqKh4/r8=;
 b=NTkCdB7XGpF06cCnvPgxblBWtYdF45JXY+8zIs3L5xNf/cZvnnZWMo9nlyWNg0rLAvG1JZ2H69FpFOVVFPrGrLKSWBTxVcXUHyT6nSBwnqt8ZYTeMkT6U5iWVioxc6q9xbFrqFdyYI+aJ3PJhS4C/RFkEZv56vVZSkKSNCnGAJSuAfZTtv9oFQqTrhLbIx1OktskfT2wtlWxGm19OoSahv0QDv+cumYh6YPg3qvwuG9fjWqEs0MjxGhcAy7xdVhZ1IOAawBLaSmejJhgKGNWgL3AIGqA82kJzfCp2n/+0Q2L9IokyvcsQ6GKp/6oUBK/YYs7BOX6Jp9tbQn9iktFZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=kernel.org
 smtp.mailfrom=leica-geosystems.com.cn; dmarc=pass (p=quarantine sp=quarantine
 pct=100) action=none header.from=leica-geosystems.com.cn; dkim=none (message
 not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=leica-geosystems.com.cn; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ELU1WXMI2cudFkUdRUNXSRoO0+8T5o07hwjHqKh4/r8=;
 b=bhT3B+kvFAvYN9xae3tcD+c7XzxyPnqVrSPMlnFSjE8hRgJDnBzQTrlIO6rEaMmMvjzp86vR0kJZYv8t8C4d53fye02a+THVVEBsyt6VBSru4H+0MtYsyTPErQGMFKEi6JykszcfWeQPZQ2NHNCeuRazqU/0QI6FesHYGRLhUqw=
Received: from AM6P194CA0100.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:8f::41)
 by PR3PR06MB6890.eurprd06.prod.outlook.com (2603:10a6:102:88::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 12:41:38 +0000
Received: from VE1EUR02FT036.eop-EUR02.prod.protection.outlook.com
 (2603:10a6:209:8f:cafe::1d) by AM6P194CA0100.outlook.office365.com
 (2603:10a6:209:8f::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13 via Frontend
 Transport; Fri, 13 May 2022 12:41:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com.cn; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com.cn;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com.cn
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=aherlnxbspsrv01.lgs-net.com;
Received: from aherlnxbspsrv01.lgs-net.com (193.8.40.94) by
 VE1EUR02FT036.mail.protection.outlook.com (10.152.13.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5250.13 via Frontend Transport; Fri, 13 May 2022 12:41:37 +0000
From:   LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
To:     jic23@kernel.org, lars@metafoo.de, robh+dt@kernel.org,
        tomas.melin@vaisala.com, andy.shevchenko@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qing-wu.Li@leica-geosystems.com.cn
Cc:     linux-iio@vger.kernel.org
Subject: [PATCH V6 0/5] iio: accel: sca3300: add compatible for scl3300
Date:   Fri, 13 May 2022 12:41:30 +0000
Message-Id: <20220513124135.1295822-1-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d02795fb-835c-4970-0994-08da34ddec36
X-MS-TrafficTypeDiagnostic: PR3PR06MB6890:EE_
X-Microsoft-Antispam-PRVS: <PR3PR06MB689052EC5D1537298A9A1801D7CA9@PR3PR06MB6890.eurprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GOo4L5eZR3RgE4MY9Ll7iOtI5tseK7yVlBPWjYMU4S6aH1HbaLTvE8jYi7wtcgcKtPzQWBT/tXI7z+gBEqURuRFWsdaH6XcI9CfPHjKWOpOhIuWDmUpSCVjcU/kyKgkixdNWN2P7gsRynWrrrWC+AYAauRrjJw30nXk+R6ReK4H4Q+MW5ZDUYq2gCLM11FpBRwL96S9+WPD4Y6XKvYkNn11yp+tO2lEzQCbRFegS4K0zLyK2M7UqfYvI2J4HxgENV16gC8sKMIwP9wETTcFFliCoTgpsnn9cM5EotnQNXxKTdnlDAu1tLlUuwWpnaM+dhJfax4lcCO2R87eBWG2SCLD5Z4liZoREW9VR8tWIm9E9l2LhLfAZaPU2WMv0qJtDBSZw0Hz4e5Z4jnqS8q00UhkGJyIlzzGCPMcdXHzwRzqpnPEeji4weot5XlmysdZWVn9vIykMPRPzDH00joXS6KbtQN0lCcW9KJvkGf0IigJag2lzK6xbWZdi344aJaPlmUmsPVbB/gPkDwW5403UdvCg01n2FKnTJkczTkwT2j6eK7Hvb1eYKP5X2hOHtY8nO739xX5fbB/Hfd99WzfxkFuFON9vO88FkvmEBgzRI/PHjTBjPh2+Y+zoAXDIEKhLfd0NCg0+IcTVSwWn8lZunehbC9/Hpt78WJP5Ecf9OfQ1Fo9ESMtxSLQy6GiVo5Ic
X-Forefront-Antispam-Report: CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:aherlnxbspsrv01.lgs-net.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(316002)(6506007)(82310400005)(2906002)(36736006)(336012)(47076005)(86362001)(6666004)(36756003)(4744005)(6512007)(1076003)(83380400001)(5660300002)(26005)(40460700003)(186003)(81166007)(356005)(118246002)(508600001)(8936002)(36860700001)(70586007)(6486002)(4326008)(70206006)(2616005)(956004)(8676002);DIR:OUT;SFP:1102;
X-OriginatorOrg: leica-geosystems.com.cn
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 12:41:37.9540
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d02795fb-835c-4970-0994-08da34ddec36
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[aherlnxbspsrv01.lgs-net.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR02FT036.eop-EUR02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR06MB6890
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current driver support sca3300 only, modified to support SCL3300.
Verified with SCL3300 on IMX8MM.

SCL3300 is a three-axis accelerometer sensor with angle output, 
the change adds the support of scl3300 and inclination data output.


Changes in v6: 
  - Fix the warning of precedence issue,
    Reported-by: kernel test robot <lkp@intel.com>
  - Modify the commit message.
  - Fix the check of the for-loop issue,
    delete the blank line, and change ">=" to "==".

LI Qingwu (5):
  dt-bindings: iio: accel: sca3300: Document murata,scl3300
  iio: accel: sca3300: add define for temp channel for reuse.
  iio: accel: sca3300: modified to support multi chips
  iio: accel: sca3300: Add support for SCL3300
  iio: accel: sca3300: Add inclination channels

 .../bindings/iio/accel/murata,sca3300.yaml    |   1 +
 drivers/iio/accel/sca3300.c                   | 312 +++++++++++++++---
 2 files changed, 260 insertions(+), 53 deletions(-)

-- 
2.25.1

