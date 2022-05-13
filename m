Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBAE9525C21
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377777AbiEMHRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377746AbiEMHQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:16:41 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2123.outbound.protection.outlook.com [40.107.117.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C470579B2
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 00:16:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ThWAxys+YxUbeap51jHsYzdgVp7jcIVVaOmOKwZtMUp3t3VrVg/FTINRNvERi33LDhaWHuzX1z7t0cXVbYY8FO3qec54++98AjeHC2hDbZMQ41NQXfIiYqVBX0ZOTzlwhR1gzaf73+0PPYRDyuxyue9lqXEixhPIJ6riEggz4XFGxnlmj1bChipIzhxHz4QQy+obV/vEhH+w6sJlGqZ0u7dtvU4zTwoM45NN8mqJInmALlTAT85+U91XmsSfSKsBn/5VWk9bl0jAbhelhUPWTAZ+avFvRoaQGcCHM+xHnjeGoyZC2Vsv4/l5rF4iAjJxg9tnQ5D/VFWrCHLED48uSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYYWcAYqSJY0kXYihQ+4dCGLnlQD9gV1WZyv6RZWWDg=;
 b=IMKpgMKHL0BR8HNGYdnLtJu9MhNgR/iKYA8F7ag+vHy8Wy2unipO7EN5BXtDCQfKsM3jPZGrSr9+JZCUHA5BFbD+lmf4pg16pT3ZwjpSYRD5UP8FkJHOCZd2MntdakBC8BdyFkLntuD5ujYtYsB7xcpkjQmzvjfBmbdHLDtKa66r6Mj3uao2nBnGmh/NWzy1mQYGaOz0X2CBiDZe36R1soEHH6nckQngZTQ+fqlHBBbPl4NLeTT8bNdIalpchMjorHNvAbvyOlWUUaRF4SmsalL35J8Vhj0jkg/dfCaIRVn7nl5xKd6hl4EOLksu2dZQxRn9H9bDe6X7gGh90yze7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYYWcAYqSJY0kXYihQ+4dCGLnlQD9gV1WZyv6RZWWDg=;
 b=lMObc7VQ9d+e5GqI8T+tZtRVDHnBC/OPIZlrMBDPDdIpTCU4hsaxRFWsgorDE6WuPbseK0Mp10hNqetHu81ltKTmsoPaS3AfudNTsIlKDfK1FyCigf+rygH7GYpU1QF4PJyzWrT++hiQZxUvOiFJ+uYneczYYHhhoqWHiRhGQG8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by SI2PR06MB4316.apcprd06.prod.outlook.com (2603:1096:4:155::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.14; Fri, 13 May
 2022 07:16:34 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08%7]) with mapi id 15.20.5227.027; Fri, 13 May 2022
 07:16:34 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Ian Abbott <abbotti@mev.co.uk>,
        H Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        linux-kernel@vger.kernel.org (open list)
Cc:     zhengkui_guo@outlook.com
Subject: [PATCH] drivers: comedi: replace ternary operator with min()
Date:   Fri, 13 May 2022 15:16:06 +0800
Message-Id: <20220513071608.49047-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0012.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:178::14) To HK2PR06MB3492.apcprd06.prod.outlook.com
 (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7cf72dc1-d09d-4aaf-ce67-08da34b082af
X-MS-TrafficTypeDiagnostic: SI2PR06MB4316:EE_
X-Microsoft-Antispam-PRVS: <SI2PR06MB4316E191FEE774FE0A470B5EC7CA9@SI2PR06MB4316.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EBu6pt0XgQ8U/zRQyzBhvC3TXrQLx/Rl68WHN0tJkzpdNsm5uNgJ4WyQS0iCjjlaYRiQaj46WaMCk34dZmCrkeG8mnQ05vs9kgI5DtijzeTZtmCJHG9rKtsgAaEYRMS6dBXh2XCuyVTcr9vh8XIGoT7F/hIXRH7rh2I9Jr2iPX/gCzLgVGtgMr/kaRMhpX8+EZNe+giDD0l+NcpBt5ISbAtFcSh0rIdEv6b6Nnq+McyFuM0u1Jc1fV8Lpz1yrT9bZPj2FNF/NRlhoHogn+dIU5Sxb8PJPTUJ5iZ5kv+iJn+9PYzXTWFTx2FTh/3QWsovlbzIU5yTWXxsA2ET/Dk5+ZmWs9XRlzJyEfEBRrTOCZHNxm+UQfAdLztLuh5xswStN1BSh0RkECXPUzS/AtotaOGEmoCfZCCx0nRdF0YtbkL0BxFK1/5qn/vJE4Tb5SNi4GpfGv8hbh4tQ2IzdJqWWRR2UJZPqUHW2G+yD7si6u0alLNnw16DWqA+KvnMIy3GJ9cLMBc6VDf8qJVoFfTMn2K2Zu1yyZWauyki7XDqRT4jOXRV11Irkv4GuYCwC2H1gSucKOmXiPYRqs6ClW43Ssv6NafU+NqxQqQ+eQPpW3NHpYK3qqOw2+KjID9tOIFUHgfPEiJhM6PzxKNXp4KmYV9qEozVSIgq00juXkMTFWEJw84eZwRyZ96eXO10eFzcsOUHb0BDQAJynxn2/h64Ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52116002)(110136005)(83380400001)(6666004)(508600001)(6512007)(2906002)(6506007)(86362001)(186003)(316002)(26005)(1076003)(2616005)(8676002)(4326008)(66556008)(66476007)(66946007)(5660300002)(6486002)(8936002)(4744005)(38100700002)(38350700002)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RSBRgIGAsH7Wpw3lXWhHPS/xWUpenFm9aOtuQHZhAXh4Hc8WS9dFiragyptW?=
 =?us-ascii?Q?PDOHWflUzLApiXW4MWRlKaXDTscyTeHaAgD4kmeqTrMnjDMzKCSGZ67nd1L6?=
 =?us-ascii?Q?PfDvtwAwuHpDbfuNYdBZC38kY5ZxJ4kDbGqmF+NlbcXd3HJLGZg7yacz9nwt?=
 =?us-ascii?Q?FONHrHMhcMbhKdOxE/5BT2Kf4hx+d8Stu0HK5jh0EbANPoy3F3Fo3qzaakoI?=
 =?us-ascii?Q?T6RVy2QO5XO2oQj39Vz/h0pQE23CEzyK1iKJhMl1K0luL03uLdplhBkI54Qv?=
 =?us-ascii?Q?d+Z/y/CiEYc5PjtJQ/HG9uI/HFebQKc8MlCxHx4d8JosmnUjdi2B+fSu4RhQ?=
 =?us-ascii?Q?viA1tUW/8NYfPpaxxb/Vv+GX+VXpncTIgRD/3DNer1fHGBCf9/c7C4w9sO2i?=
 =?us-ascii?Q?OjAOGmgyjaGCSYWts9XVsM5G8xLuAoZA/gqDJ9Cy4AlPrXCwOn9F5MkXO6BR?=
 =?us-ascii?Q?QXIOdKuEUltcbPOQPbDYgYv2L2BwrxkDnZqaVBkLu35QmgeGu2xvhSbLywGC?=
 =?us-ascii?Q?B8vZss+2pxpezqGA5g8Awlt/ubP/kSjIvqe89eVBCBheTGSLrmdSzSfTl2ZH?=
 =?us-ascii?Q?G5sXAPLmmzulk3cGn1Udj+NHwhC1yzmZNMKITcLE4ErfIKGLy6ih5Y6Kv1pX?=
 =?us-ascii?Q?7e4zARH7HMJFfUlrweomjwCe+wol8tN0Fy7cSzY8Al1mOBchd4yYbqot9Kfv?=
 =?us-ascii?Q?h2iDNDaKcMmwt2ITeEZ4bnG7Kk8YiluaOWlWo6apcSy/cpFzG2IlTDfTeAcV?=
 =?us-ascii?Q?TS2YXTCRS20CxWB8tB/i0439v8AD6lneSqO6+1YwWaTym0Hs4Yx5m9jPAv8h?=
 =?us-ascii?Q?GbqaH7eX39bq1ewS+N9Mxb+cC9crZbvGIt57znrUVJwio5WYE/65f3Ck7p6V?=
 =?us-ascii?Q?NAr2loMvPKyh3n5Bsm4+MBChpgdK/zuEz0Ga7dDZVjgTPy1EB+f9myFI9uDL?=
 =?us-ascii?Q?qAMK/wLwaRhBsVizB0mkAvqTF+GnHB03sv1gB3HmPsBmk023SRaBfsw22AqI?=
 =?us-ascii?Q?tcoyZ978RxrKdXa91E7lerVeHuuisAQPM6ONpW1qZwAgqqh7iu7JiFh38VrP?=
 =?us-ascii?Q?MUMOZyKnKw2UmguD+Bh+1ISBLaKkUlcR1vuUjnsXDInLYvb0Ivevr6FCLSzG?=
 =?us-ascii?Q?rq1M+5zn4aVtPDjPBcaoEUEuNhUMxnbOHIT6FIi0P8BSKR2G+1OY3MrcgPp8?=
 =?us-ascii?Q?Fa19jdGEYaG2VM4n4djbAvRXcgCT6SlYnJl9O+azW+4fxjxlQKqyY5sXDxPh?=
 =?us-ascii?Q?VkY2KYUjmZWNhyPsZFIipAjU13fmxNEpHWQooBHmIz5gyLTqqFKLNdyxjqII?=
 =?us-ascii?Q?UXPp6t+LTKHkAXdTwrWZcIYuXJWfK7Bp8nhR2KwzpBKlL7HQ4i9e4zLQhlwF?=
 =?us-ascii?Q?aE8//cCZOOQ8ngkykUbW8/D3KgiosH/eiitahtvoMsKGJAFcT6Dg3FsaY94e?=
 =?us-ascii?Q?G/nghUGD5RcN0+o9AfKu3x2vRnwkh/OQUgkk10pfKX59JLvxDh7scOpvr66B?=
 =?us-ascii?Q?BjjtesCWSovNFP5zpItcT830vq8UpTcFCk8UuQX0589nqkbtfcihC4NtebFo?=
 =?us-ascii?Q?T/FRKchfVaj+p+E8G6OAXDuUX4iNfp+hIvlmjhwthJXYeFUaqe/pyi9JEV/Q?=
 =?us-ascii?Q?40mO9MnFqUj9M1onDrFEATHrZwNDUaSoaSv4FctOsY+bNmX5zBYdgxEYEs5h?=
 =?us-ascii?Q?7o75YGyYt8aXbIHbUj6EtdCYv4GsoOEE5kgOJ3m0K0kdUf9XFpgwG0gD8bMs?=
 =?us-ascii?Q?MMCDv7ZBvQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cf72dc1-d09d-4aaf-ce67-08da34b082af
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2022 07:16:34.0919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bNMymhPX99C4zOTgSJ7ogYuS29JsyQJfYgQnq8pDTtZpDtgW2DzpGfAhcqQYOElU5XibrE5M4I3FRIsJiEz9KQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB4316
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

drivers/comedi/drivers.c:857:12-13: WARNING opportunity for min().

min() macro is defined in include/linux/minmax.h. It avoids multiple
evaluations of the arguments when non-constant and performs strict
type-checking.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 drivers/comedi/drivers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/comedi/drivers.c b/drivers/comedi/drivers.c
index 8eb1f699a857..d4e2ed709bfc 100644
--- a/drivers/comedi/drivers.c
+++ b/drivers/comedi/drivers.c
@@ -854,7 +854,7 @@ int comedi_load_firmware(struct comedi_device *dev,
 		release_firmware(fw);
 	}
 
-	return ret < 0 ? ret : 0;
+	return min(ret, 0);
 }
 EXPORT_SYMBOL_GPL(comedi_load_firmware);
 
-- 
2.20.1

