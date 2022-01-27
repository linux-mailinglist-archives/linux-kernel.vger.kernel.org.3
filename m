Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F6449EAB6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 20:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245346AbiA0TAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 14:00:34 -0500
Received: from mail-vi1eur05on2045.outbound.protection.outlook.com ([40.107.21.45]:49655
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238995AbiA0TAb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 14:00:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfoPQXdtLRI7mtBTWr9y72s8Uy7uZasXMyWLw7IddK1quO994+RZtdFAsghrinMiw4/avdvje9y/rOakzfJc7afgQOcP+YwZfNXmeR+voBixstR/wwBGH7kB65RhCoaCZnR8Xzz1RAmSQF/ULtgNsnTuZotel6UMRkoFog2BYpYpXiIvoU35M0UNe3jggn/cYhQeq8B1b8IWc8tXAu47e7s7xTYv9J15C4J1wjLyRIebko0UVYlyjhujL8ME/mVYrZwrEaSAFASFhMskmGy6xQC9rUaPzfC8GxeNMSjCKe8rdqBLhObEKtsEnI7lFhGxRnHC62h9OM1PGAhnRP9pCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TySb2zixNX9e6Jg3TRqqnRb8CbNdAFjVTcxUHpv+AxE=;
 b=SM0kTcT8miISGW/tCgfaSRtpS0YtCvNfDvc8UtZdwe1xrxfAjBNRYRxeASlz+cbI3xa3IaeMkDJwb6oX1pMNE9EBhjWGw+JDO2UWI2QJ7Mtr75W517u+8LEnEwKxakq1CM0uW6kMZQsX3Xb4AZoJLQMrY/VZ29oMzH28fixJBSJIEzaq7IoMB+2Jv6wHTTx0ZPfTKGIVobjPeL1nQiDdrrcgDaQfbpwJnsAdWv6f4L4mVUhtUGrORt1b5l5yWIJjlB76ZhEQPyhhx8jgnpPIzozZnE43yzAXZFIHFzDiFZN3gprsuNCbp+IPjMXNJGDg4fa4blm2/Nzi9azxXc+Idg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TySb2zixNX9e6Jg3TRqqnRb8CbNdAFjVTcxUHpv+AxE=;
 b=NY6miHd3ezP8BAxZ5XlcmyRca9d41nzlCDpnfra2QfQJ3KTEKYoev9rB3ndRgTofS1q7pu7/cVHQYZfq07R1knpS0pZIy/XdZna4fmmpjrFQW6IvaUgDuEXoyJ1TJTavglI3kMr9mUxOCgiv2qEAb1ShH7VlYVc4upNj2PwjzkkPEoPlFuhwLc5pLjbpRVO0tJ+I9LqMl37tb6hWOrrCthrxsTw5jqBZow9tyqGajotkI4uD+wHcU7WhA2ogjoWanJM5wBULXZCSjt7JnoXjFYPHHu7ytbS7VhG/JPLZxgjhHDt89BXg54XK2oXVDWl4lMnVsS81PGjO/jwyQ9tNzA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by PR2PR03MB5466.eurprd03.prod.outlook.com (2603:10a6:101:1e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 19:00:25 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::2d1f:654e:f946:1a95%6]) with mapi id 15.20.4930.015; Thu, 27 Jan 2022
 19:00:25 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 1/3] usb: ulpi: Move of_node_put to ulpi_dev_release
Date:   Thu, 27 Jan 2022 14:00:02 -0500
Message-Id: <20220127190004.1446909-2-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220127190004.1446909-1-sean.anderson@seco.com>
References: <20220127190004.1446909-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0008.namprd04.prod.outlook.com
 (2603:10b6:208:d4::21) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c28c2cd-9590-4c3f-8d7e-08d9e1c74681
X-MS-TrafficTypeDiagnostic: PR2PR03MB5466:EE_
X-Microsoft-Antispam-PRVS: <PR2PR03MB546619D13005E6B3464078B196219@PR2PR03MB5466.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3631;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oFPaxqnbuv81b5wyBo7LLAWIJ2IjxrpVE3zC8daKJtmIKtU8qVdeNwHf7FxxURmoNfJLka/cKM7T3OI9nLGaO1DCibgVRQrPsHKgdV5gDdPMmWNveaaWa+WnSGMMPMPj6UH74JWHtkh33MsrpZCoTemiinUTef0H1+cXPtVsy4m+hVnz90ftdhMr/cGeOkYtgkY4OTRuAxRn1x0hnUU3w5yZYhVN4hMqc6LBtslvAVpP+Hb5H3teDRViceLsEM+xn36q65PnYhi7OWeQxiSdlGB9rjXfTcV22mpGyIL8ZiqAP0vIsWdTL533XryP4SBAVoBMD31nd0rHpvDiHTlvGPvPbwm7ssGDblBNbAo7urD8ipzMiYAU/GD75Ij5COA5cjdrT1g/uma28bAJ4kNgO9Sk5OOdcRRRSN1NsNK1LOJAJUFGxriLaqZQh+VlYWCjjhXfNpmtFqBcl3uWo9JDuKsmRZ+CtvjnB7MLExS3kXw5qiw4LYovZ18WzFfEXuCMyoN9GTpltorRHJcxm3AzqLkQAV6oSEVqarVSvHSTmFBmjTTAqdpEZE3XJ3n+wsqgVFbLSE5alzzWX3hVdA2dSiuurW6t8JCz5FgFTxIXQPYYVCTmAU5hz+k1HiMjquRBDhTuqBxdfs3xPglNEa/SMuu4sC2wbNMFENTGtcnK+tOpndH2rjjdVItTYin+3/edDly2VNaBTWblNmfu9zbGjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(44832011)(36756003)(4326008)(54906003)(6506007)(5660300002)(8936002)(66476007)(316002)(66946007)(66556008)(38100700002)(38350700002)(8676002)(6666004)(83380400001)(2906002)(6486002)(86362001)(6512007)(1076003)(508600001)(52116002)(107886003)(186003)(26005)(2616005)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0H4exOMvenXXZiGSvVIkzObNGacCKl/fsVGIgC85MgEpiJe8HDK8PkVt6lKq?=
 =?us-ascii?Q?dlfbhkpvOiYiibEqbbGrOvmGPSXlaeWmH4Eu1O+Hbzb61JRvySrWgpwDS625?=
 =?us-ascii?Q?VLVbV98xHbjpV1tP5+YL9uwwwzaetlje0diq6cii6HB+RvCKDpOEzKM/ynR6?=
 =?us-ascii?Q?B9M6VxnkylZA+OgRSed+LG5Io2rZ3y4MmGJOaMsG41bWJWu8Tzv6s+Hn39q9?=
 =?us-ascii?Q?Up2dkfyGlfAGUTRETsPzZ43OhaV6ZBjjDk+jmk1FsE6fyKoE1YthJBArritm?=
 =?us-ascii?Q?xJnJBPdlR9QHIEfKwDyzCGJUOgXaf3k0GMGP5Q6RC1rHer2vfVgUYuRNkZyA?=
 =?us-ascii?Q?teKIwb7yQOB7IoelvEx50v12URnsBjzmzZbpJp0ce+uxzIpzM9Jnt72pftQj?=
 =?us-ascii?Q?H01Eql8+7aY+YJZim3NkqUyoPrSBJRHS21mTlgDkWIllCMYvpjoAHgt8m7ph?=
 =?us-ascii?Q?QsvtbIwJcP0aR+/NWVVRiYulCzYeeca1QPs+GkODtHkVpNG7VKGtwRRPGsqX?=
 =?us-ascii?Q?v2gv5x3EqKsXwd8+Cca+djODnYiHynB3cPAVdB+CykFlSP9CZI/FL0HEjl9H?=
 =?us-ascii?Q?G3u8G9TmeLXO2AoqZZE9CEOEnxwj8HlGjQhM2ILd2WGMyfSS/+Pm8v+Pp6lQ?=
 =?us-ascii?Q?QjAt3XWYb8ARW83AF3AqHIraqiT5rHrgTa908kBmuovMrsDb65hiDAVTeAqv?=
 =?us-ascii?Q?KZ2064hrZHy9M8LydAn+33H1S2Eh13sVQNtDK4AgLysrJMflEhqtY8cA+Gpp?=
 =?us-ascii?Q?KjnA8sshR7dJnnyFMlUk2HTduSRKju+SaregM/maaSlpR3YG046ZS/dz02Kt?=
 =?us-ascii?Q?8gWXNTmw7y/bMj4+1umToSCVP4x2JbL+bv7JDzF4gMf1JVhcn0GKPTTF1grp?=
 =?us-ascii?Q?G3jZxQla3ChdaUm9wTlZjjygQiP6Le66t2V1PNMiBPbU2NVrmOKKnudIJnFq?=
 =?us-ascii?Q?DB43y2jK8XqiijuZ+lPcpONJYn6HYR0Ax9Wk3eVZJ7O0y7J0h9xN0xHh09qd?=
 =?us-ascii?Q?ShlFWip/OrGCIDlTOxG2TBu9vtt4YUU4sI03lAUdU54K9+kB+OcXcH889wS3?=
 =?us-ascii?Q?OiQCM4uqCWOBtVJj2CXj8xWs495suVEN5YqkUYP3Kp/+qa/urMEPDA2kfw1B?=
 =?us-ascii?Q?C3IvKOIqcSHZ1JJWFWRMz5Ws2cqee7KcFF4mTU0MpOPjWAZ2liERK2nrmlql?=
 =?us-ascii?Q?DB/3tAPuNMrQPgvJHVpfJHIu6IgmAWTKXtJ7jPGi/miYa8czV9tb6vuJ4xjw?=
 =?us-ascii?Q?fteZhkT6QGtHmUFGD55+9bwbP4IC7IGJm2sW7UZy9Hs3n1dsWXd7NtgV5CxU?=
 =?us-ascii?Q?23lASQTXJ40uP+T4XykxB1xmKF0OSmUI4n1p1/ODFATU71cT+GkuP4pRYQRs?=
 =?us-ascii?Q?Z1Nc8UyCHCduSixSReb4VwafVawXa26K2i3ErZhIOJFF85A7k/qaS0p1/BiE?=
 =?us-ascii?Q?4SzeB5iulsSFfUNmAz78xwIp8u1jNZlLcjT+OCOoaUBrrBP59NrrbU19QmKI?=
 =?us-ascii?Q?KYaXTGxR2pI9wPZGsUtn0tJzQ2scX9v5MVX8Q9PzJtO4siwvCwUXI/aJM4Ok?=
 =?us-ascii?Q?iFXqTDc/PvggVgvzc9ecIxNMm3jDpCyqyBW3g9YMXcavFbhKepUivYZ0jMlX?=
 =?us-ascii?Q?WvqQ3gGUpNqzncMEJyHAU5Q=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c28c2cd-9590-4c3f-8d7e-08d9e1c74681
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 19:00:24.9460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CsgrdjxKrr/DiVkvvt3X0ciraxYOCHhQJCsYQJtxttSLoLYoVq7wLt2s/xFElW5nTnlIzadSez8J8U9qchstpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR03MB5466
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drivers are not unbound from the device when ulpi_unregister_interface
is called. Move of_node-freeing code to ulpi_dev_release which is called
only after all users are gone.

Fixes: ef6a7bcfb01c ("usb: ulpi: Support device discovery via DT")
Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

Changes in v3:
- Use separate patch for moving of_node_put from unregister to release

 drivers/usb/common/ulpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/common/ulpi.c b/drivers/usb/common/ulpi.c
index 4169cf40a03b..c90a1ab705a3 100644
--- a/drivers/usb/common/ulpi.c
+++ b/drivers/usb/common/ulpi.c
@@ -127,6 +127,7 @@ static const struct attribute_group *ulpi_dev_attr_groups[] = {
 
 static void ulpi_dev_release(struct device *dev)
 {
+	of_node_put(dev->of_node);
 	kfree(to_ulpi_dev(dev));
 }
 
@@ -296,7 +297,6 @@ EXPORT_SYMBOL_GPL(ulpi_register_interface);
  */
 void ulpi_unregister_interface(struct ulpi *ulpi)
 {
-	of_node_put(ulpi->dev.of_node);
 	device_unregister(&ulpi->dev);
 }
 EXPORT_SYMBOL_GPL(ulpi_unregister_interface);
-- 
2.25.1

