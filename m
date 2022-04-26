Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04B7750FE2D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 15:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiDZNDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 09:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350597AbiDZNCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:02:49 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2104.outbound.protection.outlook.com [40.107.215.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CBD1848F0;
        Tue, 26 Apr 2022 05:59:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X+QVKYPkztidJphdUhMjYeCj4DmjqXowaYp+6+nyH9jWQ7jEFMLNUgvMSB9+A86ZEHrOWKizM1KWG5EPIBOn2UxIW0zatkzZFXx1ddBa3Z9CfRRKcF7tthMGBmN0aTboDXHKtyD/8GxSdOSL14fDi9P73PlglYP+WAY6r0hTHcwo14NEhAICriHJz0b994zjtLNM9iKDlCowEZIVKQmOPmNZNMx/uuZZm/WHTrReds6fRvJimIf0pIPgKbsy128fMG9Nuw2KRxx5YBC8pB+f1APeYdnQLAtUqLsr+S97cNtJF8KxiASCkExlCKkwApBVddylHyzv8ucWQhPdIAjhCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xZKcJLPeVICMSH+EyfZwVrJ2ipFbLWQnizfTCYlFFw=;
 b=IdahbrMi0frViJQPeymGrXQog+TfI0jDu2rSwwC9NmWWfQvLfLzTPU83+yZHsqmHSOZa7zioghShw9ffuQZw8ieMbFo+eAI+oudq3VuhIW6Xl24Kbun52CYjlalakUpIVKtoyPsJT/NRzjGBJFGgaMyayrFm4tluy7GLehTOYiHFUhiBnSmWieQiiN+SF51e9eyz5hylRGqR6ZRFj22b8co7NrtcbniyP3ocDdZRRLiTtanFjcFPMfrqgDRFAxRADAZbpg+8mN6RAE8oFJ2eclk/Rzq4yoxWqoPI1VqcTHoAqyCCO9hpP8blz5xAKEUMSz0EJCI6JrTU8FfBAItCJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xZKcJLPeVICMSH+EyfZwVrJ2ipFbLWQnizfTCYlFFw=;
 b=pjTS2q6igSKTcEBF9JciWQIUv7dmgZCSHYP65lm4nEi7cM/n13+E7o5SMZLYYbmo6FE8F1q0Tdr5sO1ZTExocIn3xMX8JAFEb8a+oyGu9kjSOch4mH+GHcmPLltfEzScR8kTeO/Owa7BHjV5fTmv3zXCMqdzWQ3MC+OJrxj44co=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 HK0PR06MB2692.apcprd06.prod.outlook.com (2603:1096:203:54::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Tue, 26 Apr 2022 12:59:25 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 12:59:25 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Manivannan Sadhasivam <mani@kernel.org>,
        Hemant Kumar <quic_hemantk@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffrey Hugo <quic_jhugo@quicinc.com>,
        Bhaumik Bhatt <bbhatt@codeaurora.org>,
        Paul Davey <paul.davey@alliedtelesis.co.nz>,
        Kees Cook <keescook@chromium.org>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] bus: mhi: replace snprintf with sysfs_emit
Date:   Tue, 26 Apr 2022 20:58:59 +0800
Message-Id: <20220426125902.681258-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR02CA0173.apcprd02.prod.outlook.com
 (2603:1096:201:1f::33) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ff2ce49-545a-42f2-662a-08da278496d9
X-MS-TrafficTypeDiagnostic: HK0PR06MB2692:EE_
X-Microsoft-Antispam-PRVS: <HK0PR06MB2692F14F54CA997D22D75810ABFB9@HK0PR06MB2692.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YkuwjURMSnfsA/dOUzWT8DCRIgN1XOFrALdcI5kwmiTzUTriPm1znCtasyT+nUQRackGmDqNBh2PJAk19VvgGK4exPl9TnzJFIlBizHhRsOi6LlMKwZBPcRtWNqneY0IsBOe+LFYsxfWtziwLwoRl+PxYP59rNWKQMuQf004TxCsPbjDdhl28SiUeXmhw6b3gurx7oRFpUAv0y7JC+Q7KrYIgAJf+ipRvsQPnF2fpuoVIIsBz5zaITeI8urjl9kT8yKnoRyteflzDViMw90BYpTHucJJ0HxuSaqd+27CyqcSxAF9O41cpOc3B6rRar7uUnnhjole2K/hnMSPFQpr024UNeO14OFCPKJEW1B9djL9z2TodBgjWCYndgmS+pTdSRaM3+bCPFSA1cuZN4AWMI9LrsORyPanRj9Lz2UfDyeeaOv2uXR6Gud6YGOIsScQ1lRTTQYTLuN6xSv110q3Gka9PfQrTJMVGk6n8IpiBimd5u/WvimSekkLVtwvHT/iPxmzEI7SHKB0WJwL9eY2QZbxU8gK1RO2YNKBz2s3vCrZK7Fh8TINEEyYz5+/W+8UgnymtBjcoV6tzfyKrjfv89+odDBFTVslPVv88vTKERJ8zSvJZTZyjXvnsOXQ//pDwEaJkNK+F7My+odgYsy7fJB2BpxeEpt5Uq7pnDpDy4pRsSlH16iMXp0o5+8A7AZQeBwY6gDPXEPIDnhrqSt1SOhwR67l/KyaCCj2DEhfp5U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(110136005)(86362001)(186003)(66946007)(66476007)(66556008)(107886003)(8676002)(36756003)(4326008)(8936002)(7416002)(5660300002)(2906002)(2616005)(1076003)(26005)(508600001)(83380400001)(316002)(6512007)(52116002)(6506007)(6666004)(921005)(38350700002)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NM9dLQ00ZWF3Uh1EJuz8JdgufcjObakqrOinor9ttVj8hp40F0d8SUFgns9Y?=
 =?us-ascii?Q?233hRvHnMq+mM8xeZ1CQ4HuqHLJrh2DDah9ycwZvYTM96uW1BrXwPgnshv05?=
 =?us-ascii?Q?M/BqXJt9n7Ov+j86RosVCQKRaxP8TaKnpCkxifkXriLoMlWYauB0sYZLuM46?=
 =?us-ascii?Q?72eWUMakMr+M0zKQEpL7lRUtKWwqWxyyzr3jKk5cb+jiuEt48r1x4qku18aV?=
 =?us-ascii?Q?iUpEgDreFCNon3Yme3DBnYBomKci8oGLaADj2vKvYLgNdgrTdACGznwGEm+Z?=
 =?us-ascii?Q?yQsDEfiPhvwFPZTkHlqPp2Dxtg8vv6Q6SyDJdt3N2etpl5H+nKWusJlQTfOB?=
 =?us-ascii?Q?/GQmPvsBPQKL/D7Z8M9VCwOd99gqoI4k4qhWZxRSvJB0OauNzApDf69bMZDI?=
 =?us-ascii?Q?+u1WcAL0X3kiA3qGmTWIk8NZlIBhNKWlZR77IoP6BpHDwyE8k92c8fJXgb1B?=
 =?us-ascii?Q?mdB29V8pR0umlH+GAGdWlJePivbGBuHH45Ou6KZZypvZ2GIIPiMx+FjlEbXg?=
 =?us-ascii?Q?fJdGsbavES9ggOJRWlLI+C55Xnl7mCIItaMAOy2ni7wX5wiMcYhOL/4BUcCk?=
 =?us-ascii?Q?rNgFP7vec1XdmKzieSa4pQJAT2zoJz2qJSC/kwwfQX336oWgrHPRYlnhUVgV?=
 =?us-ascii?Q?ENDeUKX6WLUvrFMaCJjj8tf1+ylJKdvkn03D8Rbj+FrHkzpZvNF6Cr9z8ipo?=
 =?us-ascii?Q?wDewmYlsmskhcHphbyVJ9ifUPhDpDHxzmqqvvpUUFZPwGJwjN4ohHDnblVIJ?=
 =?us-ascii?Q?lB9nTSqCSBb6nxJpTbqauHxc78MM54Izj2Wm91kPu6vp7Z+tRi/CpxbsqB8n?=
 =?us-ascii?Q?/iWBCKJsg0kzpUiJL6PjmytdmuahNuKdXdfw/h54BfmGC6M7F0zzBUFIv1Cv?=
 =?us-ascii?Q?WB7lTKMRru9RldQxQTLqJ/v1vymI2eD3CKqMkEGWfOgVtE68UNgl/kwBavL2?=
 =?us-ascii?Q?zPjqck7kjBl+7QvKuyftPZNTPe4oHn8RN+/H1t8d6iD26o69Asuqs6YzzTgE?=
 =?us-ascii?Q?x+Ft8klW2mqb7HDPUwkZUX/25aFJ5vHbUG+z+3HzOLwtmC3CiFyl+stUZxV3?=
 =?us-ascii?Q?tLiJem7ZOJ+bttBVbWHJoqQHxaRYs4cezW5Ky4eGecba/TMYqUh2kYX+lBVm?=
 =?us-ascii?Q?Lk2yzNmDIwNZIIGia/je1PwuWyRIDdmkjWYPt+wiIxGkxUsUeRuiVMUcXxxG?=
 =?us-ascii?Q?5C5rqwl0VOpXmq3UkeOlvJg4jv7Zw/QVuqRXF6cbWclTn4WAkuDJi7A4T3x7?=
 =?us-ascii?Q?z5T6IBYc6f/qRd0DKs1+EnVXy31q5J9iXDsSecDrZS0UhyopC/+NU3KGxJON?=
 =?us-ascii?Q?02Ny6RzHsqVR8RzHM956kVydq/ngQrtOfXRbGKiquN24j+BC13W/vJO1sm2C?=
 =?us-ascii?Q?zxoCyz247zWbv9CEs5TGRO9rvhTE66GGEZ5MLnbiN+Msg26iHMSZZMoN++BN?=
 =?us-ascii?Q?TaVp6u20g4eGi9uttvDjfNpMUxBqKeDXJL/lGjoGGwRWE/If6fMTpDPlij6C?=
 =?us-ascii?Q?2HsSszh5AIXxNih/SckTa4END2GKpqhsGW+dKXJNnWqyuzQV5FdzaBGwVQLG?=
 =?us-ascii?Q?A6SUjaNG6/Sm0gbo7kdKt8EsAN3vhGaswSko7rAtNy5xSmKrluPNxjYyxYC7?=
 =?us-ascii?Q?W9BfKhVJDxyOHfYuVls0zi32sjAGAjIL7r3cuWLfZLQ7jPckdVaGV2PZFu29?=
 =?us-ascii?Q?2Q/wjrdY0aM+b4qC3Gpp0Pc/lzQEGyOl60KS1XMYRFHzdQWRb/eQL37WCEPJ?=
 =?us-ascii?Q?Up819VlzpA=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ff2ce49-545a-42f2-662a-08da278496d9
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 12:59:24.8842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hzH+bTUDl+oZqqUH6TAu5kTuLc3igfmyTtyYDTIluVgdAOuSTreXvqg6I8CCQNE/j3v7r/8OGDtpRDWrPLix/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB2692
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following coccicheck warning:
./drivers/bus/mhi/host/init.c:89:8-16: WARNING: use scnprintf or sprintf

Use sysfs_emit and sysfs_emit_at instead of snprintf.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/bus/mhi/host/init.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
index cbb86b21063e..c137d55ccfa0 100644
--- a/drivers/bus/mhi/host/init.c
+++ b/drivers/bus/mhi/host/init.c
@@ -86,7 +86,7 @@ static ssize_t serial_number_show(struct device *dev,
 	struct mhi_device *mhi_dev = to_mhi_device(dev);
 	struct mhi_controller *mhi_cntrl = mhi_dev->mhi_cntrl;
 
-	return snprintf(buf, PAGE_SIZE, "Serial Number: %u\n",
+	return sysfs_emit(buf, "Serial Number: %u\n",
 			mhi_cntrl->serial_number);
 }
 static DEVICE_ATTR_RO(serial_number);
@@ -100,9 +100,8 @@ static ssize_t oem_pk_hash_show(struct device *dev,
 	int i, cnt = 0;
 
 	for (i = 0; i < ARRAY_SIZE(mhi_cntrl->oem_pk_hash); i++)
-		cnt += snprintf(buf + cnt, PAGE_SIZE - cnt,
-				"OEMPKHASH[%d]: 0x%x\n", i,
-				mhi_cntrl->oem_pk_hash[i]);
+		cnt += sysfs_emit_at(buf, cnt, "OEMPKHASH[%d]: 0x%x\n",
+				i, mhi_cntrl->oem_pk_hash[i]);
 
 	return cnt;
 }
-- 
2.35.3

