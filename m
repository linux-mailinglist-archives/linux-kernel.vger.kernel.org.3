Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B48250F2E5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:44:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344234AbiDZHr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238615AbiDZHrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:47:20 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2118.outbound.protection.outlook.com [40.107.215.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1587C1334EC;
        Tue, 26 Apr 2022 00:44:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DD8ohwFbEoX3tHPDohP3L4HGGep5g3mN+haowReq8Q9+4IeZ4us3WdcskhGkKvF0ZxeBFrl2yD8XbjstDfPOwlUrzMs1p9oxW2K8n55u8WNwQXgs/LJdGYorVzVDx3O5E+V+OyD+44J/xI9gTUMQDkUg1H7ICQOLNnQUzOzMBKTkOww5czyVJf92QzRedFQSQ4r8TDJ+GR4aJQptYH6auLHUi27jTY30vAtxSXrcWbKPXBZF9pUqHa+/tnI/8eI0/2bgIYWfijl5LwWafyBjzO8W5anKHE6bVXJSku6pnnlPYMb0cbn3L10oGn61jZYKrsrlngipkdb6hX+ReVOlVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8GUAOCiEb7yUbznRrQMLFIj8tUn/zjgr/VRgWHTbws=;
 b=HVQPaMBMXIaxsifw0DB3UWBaoo8kL3YaLPnbHLnOuPFMLQHHrVaDHC1H4Cp8OqUCnaR54R/2+tEQe3QplHc3FWPPUHDpZ6j0Lo/onQ5bWl1w2AOZlwxloLF5kaONaH0l841ch+Ugsgxl1NJPT9JdgVMEV2f1Lfqqk/397VG8PYEYSwTrXlQQDN7uT2i8bdVDw3rL/r18Galp+bL891rgAQU2jvV9IJ3+r+PA7mLnkA9PNg5bB4Iw4dhv6P0YtFv2FNwq3WfATTOfh0KXwYVFDnBuH+FZuF13ymi0viwh9dhyNoRJExhc0L9eL4A+F6yPui1oh/yCEsRI1JzIzq+e+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8GUAOCiEb7yUbznRrQMLFIj8tUn/zjgr/VRgWHTbws=;
 b=e6sXMuUzFHkSf76JLtCYiV1f3wlNSIzNYJ0ErpUro9AlJBzrCr2Qo398S9b7PoKkwzTq14BDeJ10uo8ILDDpPkz/keuY2tGCiJunWU94EnyMo4b0zbmWCu1YSvEInR20xTgknPeasKhYy4e2n8Mi9DR1zxQ9RpOr2E90ctWbENc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by PS2PR06MB3494.apcprd06.prod.outlook.com (2603:1096:300:6b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Tue, 26 Apr
 2022 07:44:07 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08%7]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 07:44:07 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com (supporter:QLOGIC QLA2XXX
        FC-SCSI DRIVER), "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org (open list:QLOGIC QLA2XXX FC-SCSI DRIVER),
        linux-kernel@vger.kernel.org (open list)
Cc:     zhengkui_guo@outlook.com, Guo Zhengkui <guozhengkui@vivo.com>
Subject: [PATCH] qla2xxx: edif: remove unneeded variable
Date:   Tue, 26 Apr 2022 15:43:34 +0800
Message-Id: <20220426074334.9281-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0185.apcprd06.prod.outlook.com (2603:1096:4:1::17)
 To HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05bb3c0a-c65a-47e9-c770-08da27588b3d
X-MS-TrafficTypeDiagnostic: PS2PR06MB3494:EE_
X-Microsoft-Antispam-PRVS: <PS2PR06MB3494BE88D7C34CFE460D800FC7FB9@PS2PR06MB3494.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7SlK4GnnJjFt73ShuhSia8ldKRllTdGUzlM64jtqGx9E+Mrf62mnAPzwzqZXjAintlGE7qMuLZTB2CnCtSAXxvlzwfkmg5X3P+vRDrmJfB8MnbWOL/NhXNTB0rrSubqV/njd345HpNQPa6VsuoQi8AzVuhNPumxXjY1DVIjFRvVoE+xhrkb3S8BlpQjFtmYoppfyaY0T6KeyC0QVBQ8W5VW1Z3CHDWPCFm+2d3T/Td2WKP+oPXHVmHOoormTu46gzk9Cy8g/xK5u99NIJF8hzPmLsZEA2HaASY5kdQtjDvgpLqvFFCgwkrFoT/Gc+7w37mDrvfG8ahH4gPwRxiu7sNK9DLquCrIMHKKOjGrCJiFkUQz/umx1No3Gv1olbF3lu8pyaSc27PgSEDKXEy4uzJYPiscFuFbR/U4ZhVnOFaXTsMLTA5w8Yxl5qxTtxNHTRVc7Y9Vzftkxoc48LtB/YNFtz7AwGMNUGxOA1SAPi7FzCEb4f+qKCBFzmIB2ASXuqOWdOzGFwitUYlaw+Q4vl+ZUPbD/7YEaH0w8Aqn3vmPxLNZRpVyfMk60hhD6oXaxB1Z1Wnqtn2+DAZ69qCi27n15u52gqA2NZ1PvvEchF8tTKqwSOI8JvBv9kZw1ICZXa6h7yykcIS8OrBy7e+0z1aHXkjrexGAHD1lOztfPUTwuMaWd9ipWH4kPWFAd1fKyB8ZVvKL4cbJ3+qsWhquokA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4744005)(66476007)(316002)(86362001)(2616005)(107886003)(5660300002)(38350700002)(38100700002)(6666004)(83380400001)(52116002)(2906002)(66556008)(6512007)(6506007)(66946007)(8936002)(4326008)(26005)(186003)(1076003)(110136005)(8676002)(6486002)(508600001)(36756003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5osIC9YdJZxY6obUxJV3NVjUqZ6Gnqem9ZaP2XwsOmbFFxfurdiyK5bIVwXA?=
 =?us-ascii?Q?6X8O5GX8n2DU8Ly5k6V7fZnO3dtrAWMfQ38FIxHtMJf/yFJD/Y2JsvNuWsKh?=
 =?us-ascii?Q?gpRsbX0liCvlU2K56hJz0N3d9ulB7Z61RtbFcz7ZZYGc9UHO05pVd0giW571?=
 =?us-ascii?Q?aSbSXfkyTGoRLlEv18NeT0aEwEgH2O86wZIIrQuzIkoIkFIuqVpxoIRubnlj?=
 =?us-ascii?Q?Pa4+d0VM0DgfrvPsrWVvfX4wvNpXT/YsDNO22k+LDNsIDOcN6oFRQlFwnXTI?=
 =?us-ascii?Q?zrhGapzIgonU/DXmJY8GF/kqeef2ROMMt0P7HPdDpvzfvTJWpJA2xMKcK7VN?=
 =?us-ascii?Q?Cf6GwCjCafQyNrXx5AIUDa0bRcWS453ZfuII72dcWLu48aCjVQgz9dkebNSZ?=
 =?us-ascii?Q?AUt5K8STiljRdh1JaO2myqOqJWN0LdQ8w8zrzE+OAq2Y7OdHyP6HVIKdcpx9?=
 =?us-ascii?Q?s/Bjz8YGSn2UBU/hUvG4vxb9/LRk01n/cffzfdq96T7zRVO8urfLkdDlcfh3?=
 =?us-ascii?Q?VFYUdnhUAUqWSviS/FNBeMnC/KrV9rqahP8VvsVlG+jffZ/xw6blU1KW15k+?=
 =?us-ascii?Q?ibWpiLIB9D2KFd1nkO+hhj/8uyZqzXxsq2uLnq0JhD22X+YkmGG0wQ+n4Euk?=
 =?us-ascii?Q?z1OejoJDuwmJ38u56tklx1SqM9YRUKK+H157o9GpDmsICDyw8HpiXdWycYVr?=
 =?us-ascii?Q?weGEvXArVOi8H+i8wqGZPHg8SdvsJl7Ecw4M560XIgY+naJqiD1D8Jj4FkhF?=
 =?us-ascii?Q?38U5upAuS5Sfozq5TuOqXPXu0GVdG89txKHSEkOJzAA5emJwPyAjCspsac3e?=
 =?us-ascii?Q?jhe1jaYKgVeQFVeAAjZ+DYI5NFNpt3O5moqWH1LJAzB/Q+4JRy6MDyNiG3ri?=
 =?us-ascii?Q?7dnw0uejRiu6LYmhh9e+bvIK4FtNEVj7ajtQIdgkA4jOkXOsY2LdY7SUs9zJ?=
 =?us-ascii?Q?P9wgDnO/VYCV/Ho+B6Wnb5wSKkB/MrNS/VbOtiYDRCONptGY79Los2e8jafy?=
 =?us-ascii?Q?NhnKd0oPOvTMvcZXF9XGecX8OeoFIfmDxRDx1tKb4iqOgHGFThiewn4GphiR?=
 =?us-ascii?Q?+sbneazNdUbEAWbcQ6gOT7riwZQTXBlvpHxW9ywN9Eor7OANbmi88VKtss3B?=
 =?us-ascii?Q?i5cMzyutbJtxL/vhQ4YqZMUtmy3JFXE1jmcKXTeHDtJ8/6S8x+QSdTku/ayd?=
 =?us-ascii?Q?ODwePfnRaCNyEbgfUIAAkMtdNbvqtEIqKjnG40VMFV4iSgHNiD1sHney5gGL?=
 =?us-ascii?Q?gSZTIQlD4zQ7OXcrkdpy2Vhiqcw/6JPmh1hK38c5+h50TCjxfImSveGsdYtE?=
 =?us-ascii?Q?9xPVcLDhOfAPxTmotFJOmRqc/qX+WwwQ/9f0DMwHY/AwpkHZa78jOdTUEWbF?=
 =?us-ascii?Q?V7vCWyxOldkWmVZm1iWbbdwiXVjpQEK46jPwcDcN1kYRwHKyviIwrtybnDQF?=
 =?us-ascii?Q?mURatKNtkj/VDsiy/wyTHB/Z6lv1vD9HmF7gWWzUMtEBjE3kXgX7Xg2tkg/E?=
 =?us-ascii?Q?08MC/o6SmBqIlbTnDRcE4JbAMhYgOntlGSoy1yezIzgEmnvlC0puUQdMPGfS?=
 =?us-ascii?Q?wFFHS0mg30b3v+yPcZDlLs9OS7w3lXlpvkYylxdTVBMpeDcH8HtPudUBGCZG?=
 =?us-ascii?Q?9het29yWJ/m6XX/o7J0lYL8AEoRHYEbWnwLnGjm43QXdccSVqVOMR7BAqgk6?=
 =?us-ascii?Q?ZRTsntTyJABgg2KAPYB1dmi6/oM3CAPuh9cglbZPlNPLffXzPpVtSaRRweiR?=
 =?us-ascii?Q?qSDsavZ/nQ=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05bb3c0a-c65a-47e9-c770-08da27588b3d
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2022 07:44:07.5221
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: biGvmRnsXez+54E1JQBXENsW1FLTj6pE1WThOUaWxwm1hjgp66LQi1Io49DL2IniVPdpwTf4QaxxxGyshez35Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR06MB3494
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warning:

drivers/scsi/qla2xxx/qla_edif.c:660:11-15: Unneeded variable: "rval".
Return "0" on line 761.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 drivers/scsi/qla2xxx/qla_edif.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_edif.c b/drivers/scsi/qla2xxx/qla_edif.c
index 0628633c7c7e..cb8145a9ac09 100644
--- a/drivers/scsi/qla2xxx/qla_edif.c
+++ b/drivers/scsi/qla2xxx/qla_edif.c
@@ -657,7 +657,6 @@ qla_edif_app_chk_sa_update(scsi_qla_host_t *vha, fc_port_t *fcport,
 static int
 qla_edif_app_authok(scsi_qla_host_t *vha, struct bsg_job *bsg_job)
 {
-	int32_t			rval = 0;
 	struct auth_complete_cmd appplogiok;
 	struct app_plogi_reply	appplogireply = {0};
 	struct fc_bsg_reply	*bsg_reply = bsg_job->reply;
@@ -758,7 +757,7 @@ qla_edif_app_authok(scsi_qla_host_t *vha, struct bsg_job *bsg_job)
 							       &appplogireply,
 							       sizeof(struct app_plogi_reply));
 
-	return rval;
+	return 0;
 }
 
 /**
-- 
2.20.1

