Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E13051B7D9
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 08:18:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244192AbiEEGV6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 02:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbiEEGVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 02:21:55 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2123.outbound.protection.outlook.com [40.107.117.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E3F51EAC6;
        Wed,  4 May 2022 23:18:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgqTI8pJARM3LYu1wuo1XjNQNcEyha3tFxMzCkHXwlE7KiV1nAYMYrnZzr/fMumcs/D/Cf5D9i3oBz5KKbze4ycxDhcCOnx8yY6xnyRY2lOH8LPbzMeREtZTPrQfM8c6Kg4NgsPIaBNhjewS4stZ73HkpQ8qrbItZfjBfPkMsthaB+o9/zzLWbli22Ypxaba3kPnAclmjB4Ux9HSAm3HQ94Pig7nmCFJETAgYnv1GBImZ5W7jlbJ76JZGJN28RJg+fKMKGcGTnTBGtdGz73Ao2ki2tluiE4NEScsZr5hqNSzwilx7DfEgxQF5XwYA3S8Pel1IFtTuoztDDjvV9A1UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6BAMggDYn5wBQAshvsy1FSJG262ydS1qbKjbeI9Lg8=;
 b=GQLl3xQws9H38K4tatdgL/xR0HxJCTf7OVnGi67n+ah6kLCDSEQBQCwHtkdBzxIDt5N7Ua29A4Zh4oHzPGKnpGgopmqamd3RiZMMRbr2Encv4D214rO6eZIwZqh2A3htCVyC1yv+dxGnDupIT8WMzD/oHrCkCRlVPyhWfURr6Q2nGl1kIj9PUTPrULCs6yS488KvHQb67oCiNox13fEjnvZ/dn1JIg+pSdUi5hBEX+V2Y02JU57K0M21ziWFS1tByRRPaJmQkP+2INU2PC1ucRkzEGxvEoFRKHffaa2P93EdCUjoUeTC5LAyJ1IyP44y7Y+zE0rO4PyMl+Jg3xuPGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6BAMggDYn5wBQAshvsy1FSJG262ydS1qbKjbeI9Lg8=;
 b=XYd0ClnHsSpoKPHwz8vi9aUqWlTfGYAtm7FKx3jlXjcOKLK+ZgICnqddFtO7DHgUozT/wat6tTifokxmoFXw1M8M4zVKDlxmm2uiF1xvkBYvvq8ve6L5Y4SqGzgLBLyZZkwIn2ZpDAUJASCZQ7yKFCTVJ4FqCh1jNGVfkyiT1p8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 HK0PR06MB3826.apcprd06.prod.outlook.com (2603:1096:203:b9::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5206.13; Thu, 5 May 2022 06:18:02 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::4591:4f3e:f951:6c8c%7]) with mapi id 15.20.5186.028; Thu, 5 May 2022
 06:18:02 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Sathya Prakash Veerichetty <sathya.prakash@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        mpi3mr-linuxdrv.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] scsi: mpi3mr: Replace snprintf with sysfs_emit in adp_state_show
Date:   Thu,  5 May 2022 14:17:42 +0800
Message-Id: <20220505061742.1657020-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.36.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK2PR03CA0047.apcprd03.prod.outlook.com
 (2603:1096:202:17::17) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 49d19012-650a-429d-120f-08da2e5f01de
X-MS-TrafficTypeDiagnostic: HK0PR06MB3826:EE_
X-Microsoft-Antispam-PRVS: <HK0PR06MB3826A0888CA5AC9B995A66FFABC29@HK0PR06MB3826.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KjqvnpXIVWzI4WseNqzgJ2oMk7kv7Df+8YVtsDaB25Q1Zyn9hqeWRezOhOXh9+13rxkrMkMQVRsEhElTTEuR3SkHAw74q7Qj0Ii2PAnsSaCzUk7f3p8u9blCqlBM0J6Wxty4JO1jpk2Wx1iC5pjyqiCZYwnHn7KYiybf7IGeK8bS63Qkxed4JjyVpGBZ+mgBbBzzstkFnNIq1oaVpYY54RSZiOb4ALNo0ih0U59I4uNbCdMNsCKNVF1T7g1+EOJW5dWZlovWf7uIKvSAUtkjJFEvSGOkmDau0ebAhU+zSktWjeky79mrs7dqTQie4BMCHWspcKqjuk0nZgZCA2buDZnKCfOLZ89gI8D82A9iKiQlyiNCAV4vLMf1MnlvCeaC0b5EAThx8bSwwQ6oZhAYNj5HAmyCmITqEZfGesTktyYklTIvcgWuA3Vnw53XnZegGscx8XNZQsXBkvBfSnJjp1heYy3TNYu6UdAk8y+Cii3g3mo5XEY+qOJFpZnnDMfsarEP9caTZfJndwHS+SM8QTXftiXnohrDkJoubcxrMq73c49jNC+uFp/TUm7rAwEORm9m9pvitzPamLuCuJpHCbwLjjE5Pad+LEBqx2h8UvGaiL+z9HKM3Nj+ppo1xaZcy6VLW0dm5le60JZ1RT0KltgaiccPBL2DTRT74F3MOAxFLmZQD1UcxiwEC14K91v8ZcSn/eEhO80DaI+ynZlv0V9+ZlM5ywj2nQtrEjGsUcg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(6486002)(508600001)(2906002)(316002)(38350700002)(38100700002)(4326008)(66476007)(8676002)(66556008)(66946007)(8936002)(5660300002)(110136005)(186003)(52116002)(107886003)(6666004)(1076003)(36756003)(26005)(2616005)(6512007)(6506007)(83380400001)(32563001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Grb5rvuZDRh57IfW/99iSXFLLSYpamjTN5/J+d9FhCp4nJNRh18pcQKJo8cf?=
 =?us-ascii?Q?okHzE3pOetFw2DTl5NdVJ34eE+mXX4bchpx672UioKBiwf+6QY6scuGLM0S2?=
 =?us-ascii?Q?/eY/UE73TTtidj8UxbNm5SdiHoT8TYBYmyB/9/RzObEUUXnAUrcKpcqklQKg?=
 =?us-ascii?Q?KxY+nPFxiH1BGuBJpXiV2q5O0qkXvdXdHOMqXfNe7HZI654oC6CbXz4dNXXd?=
 =?us-ascii?Q?S9CXC9WIIow8ns9IvgApbiKpkSBD3cXa4ES6G0OkDYDfX6LiRgtXileXBYBJ?=
 =?us-ascii?Q?XgPObv9Oy+l402r3VIhATjmdtMAk+vCcpehBVb3MctzKh9tY+T2gi/mQn2J0?=
 =?us-ascii?Q?ewyzbn2clYfgo+Z8kU5oT5sFmL/um/Ee3GI7RYgINz3RqiHC2pKbHItIfC+U?=
 =?us-ascii?Q?xQXT7GX+Cvx0TWQED7RMlZjrka1ZL9Ne0yLhP8lt7SmEi2oQNNzSxcbJExN3?=
 =?us-ascii?Q?4rsGRcLOkLkycxzgrvfRIghdVEuN/3DBI/55w3dP1f3k0xuLD+PXyrPnI8Sw?=
 =?us-ascii?Q?AmHzcKOQQ7Fe50mtN0fhXzAgfRDpb1Dgr7tqPonpDRBv8kLvxL/KWY4jMIqQ?=
 =?us-ascii?Q?i2q6AUNZH6VF+4+xkWmj+jF0vhGxFYGFDb0H3JsI6t/EhpeQ+DUAA6ukVnCl?=
 =?us-ascii?Q?cbWz4onQ4YFQmHSj58bNo0M0b021hccpbw1jw9WaJEs6MnHLxVKH/gQ2vAsT?=
 =?us-ascii?Q?UaTqA90cQWMHPic1INoY969/AZQjJPu65vMi/30lTgieXV6WHMXeDRFHKoPT?=
 =?us-ascii?Q?0Dg1xvw2VQaB8RIfSp8QRNU4PqCFlAnZrFVwX1YpQvsutbUKsYveSGoJ9R5r?=
 =?us-ascii?Q?Nvgvy26JWdnK83r96vkQuVGfHRVZdUBzTO6kQsDu74wQerxTtuxyA95j/tFV?=
 =?us-ascii?Q?66a+JwUeXeA2EAlAleyCXPpQOT+4AW/yO59k0ev6JOjuVnhas2NerFKY+EPw?=
 =?us-ascii?Q?SMrwetsvtKNyZk437PFaIuiJ2qEIhXSJND1kQoIaMpAi13uP5wmf/lcCUcVP?=
 =?us-ascii?Q?tAChiQq2eqHxBK9kGxoiUkyMOhH2/ZrtUSKiV+Lc5C14JOq5mxMRTn3DH6Rg?=
 =?us-ascii?Q?pmEzJd+D8Qgj+aDVf1H6pz82PsXjER4WbI1aY0LAfpbUiq3ggs6zKA2XDggD?=
 =?us-ascii?Q?lJFJPetnAW3Hx68aeMPDfRmFPdvOissenVvbeJ+HA+oCC920gMDxAEx/GlcX?=
 =?us-ascii?Q?MVD1eNcxg6dDkkKbUEr+ZYqioW3I4RrZwHrMvmB5u6i8rKesr6zkFzuQlrJh?=
 =?us-ascii?Q?b7s2EQ3w4xW0QoZK1Rdue4EwUgeZVqyq+2JQnRyofUzo5A4mlUOq8gcWTyJ4?=
 =?us-ascii?Q?mH2JlCE/9H3J8FEQ58Js8Mj4XPwGM15oW49vhTOFZW5imdsRYwylkRDFFdk7?=
 =?us-ascii?Q?srpZOEOYqb6HGBwhAwMHuEF3XnbxXL/wa3TyXNnRMT5nIZrdpS2xE1VQh9f4?=
 =?us-ascii?Q?0KToRIRnyJamG1H2oxXlWQvzwLTb8n7pCZyFIoL2dCS445VQ5tWJy/TV9r7u?=
 =?us-ascii?Q?5ntvg+nrf60WOEnVJtiXY5MPzqmw0xECa168eBIaLchLS2b15GnOKuixoC1t?=
 =?us-ascii?Q?6SpxegYZvtChv1srOVftdkxLxvlvvny+CUsxbe506uJu5H5q5M8WE22v8LIZ?=
 =?us-ascii?Q?Pt7Dr9kUBJ0keVFz4FDCM9HNS2pZAZprZILvj5CxIlIu04Z0oJeh5SXCNYXm?=
 =?us-ascii?Q?L0GiCSac99E7aUiQJeG4gUQTxLpf1B1XZRbCQvkiLp38YSSlYvC3AZIfJqUy?=
 =?us-ascii?Q?xGA0SWjHfQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49d19012-650a-429d-120f-08da2e5f01de
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2022 06:18:02.0541
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EJgJTXlYaRQahcuF39kT8nZXUdG58OFkb0mQ1ksf7iQfbuxpWhoC+VHxlFT1lEaCuMo0Oyq+w+D5oIgLrEozJg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR06MB3826
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following coccicheck warning:
./drivers/scsi/mpi3mr/mpi3mr_app.c:1588:8-16: WARNING: use scnprintf or sprintf

Use sysfs_emit instead of snprintf and fix some comments.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 drivers/scsi/mpi3mr/mpi3mr_app.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/mpi3mr/mpi3mr_app.c b/drivers/scsi/mpi3mr/mpi3mr_app.c
index 73bb7992d5a8..86a7206548e4 100644
--- a/drivers/scsi/mpi3mr/mpi3mr_app.c
+++ b/drivers/scsi/mpi3mr/mpi3mr_app.c
@@ -1559,12 +1559,12 @@ void mpi3mr_bsg_init(struct mpi3mr_ioc *mrioc)
 }
 
 /**
- * adapter_state_show - SysFS callback for adapter state show
+ * adp_state_show - SysFS callback for adapter state show
  * @dev: class device
  * @attr: Device attributes
  * @buf: Buffer to copy
  *
- * Return: snprintf() return after copying adapter state
+ * Return: sysfs_emit() return after copying adapter state
  */
 static ssize_t
 adp_state_show(struct device *dev, struct device_attribute *attr,
@@ -1585,7 +1585,7 @@ adp_state_show(struct device *dev, struct device_attribute *attr,
 	else
 		adp_state = MPI3MR_BSG_ADPSTATE_OPERATIONAL;
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", adp_state);
+	return sysfs_emit(buf, "%u\n", adp_state);
 }
 
 static DEVICE_ATTR_RO(adp_state);
-- 
2.36.0

