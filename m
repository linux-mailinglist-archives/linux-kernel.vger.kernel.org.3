Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 162F2524E69
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 15:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354493AbiELNie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 09:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354485AbiELNib (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:38:31 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2126.outbound.protection.outlook.com [40.107.255.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4DB24824B;
        Thu, 12 May 2022 06:38:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GVoTohuk+lVjMWChqbbAWkCNEFU1IJxS8DX2KIPIlUIHvROEJQqLvwxR2q1F5XRkxY6QqOP+riVsWw5D0aTtem/YfqaxQNgkpfA80w+41O08Yxdt+MWdXhaCWp1v46ccuaTCBfyxDTaq7biYcEUmmHgDw8jvQgT4KQYcCxBGWEq8bFgn40goKQFDgse1BoIj38XgxDBPL9eKyY0ak9ZOMugRzTvEwvlSUb8QODoXt7qkY1MIZBfx1iTBkmYGxWrdZBh2/uwl56Q4ILw/P8oKBeqXw3xPmddiI57fY159TPrEpgxw0C7Gx0LuLEcLkSe0Z1GkzJ8zJ89GF7ByWlLRVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jravj802QOyDcIv3uhS6aY9iFcLAKsoBdBSYgxCNuvA=;
 b=dq1svdlUZJMYXxmQuJZxb+vo9GeJXfh4Pf/+6ZLur7YHQ4sEg3Mj74n2c8v6ERC/1TYsQpNZfD56NfM2/MhtlWcfzpmcay0O5iolr+EAWVSOj45nlAx1HtOZ+V2KLtS/dvjs8V4izWkbAhzELglXh26+R8omWCucTtpxS+Rp2NcPuYChaZb+o/DWqaOSJw5kbppm2vQazffjLkK75mktyYvxrdGI1J6DOW/nskx2XmzY830MVh2I1cHdYu9jeOayImrD7ggszqk2ulBS7yiDhFGH9qOITphNBAVbnGBMCCJhKVmUSIBx9GLYwYsB5UiUedAnyEcEvThQvLxVxFmqsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jravj802QOyDcIv3uhS6aY9iFcLAKsoBdBSYgxCNuvA=;
 b=M5QD7zAqQNbEwQpwIeQMQOBYEd8Sik7BHXo1fpPGRzby/TAUoejoiWnzpMv+c0aRPBouvMLiDs6lVNz2wpS2lyJ3zCOf1yEeVgcLejUQbebNmzkcL/KJXe2ESuN6aIFBV7msdjTQdv/4pJtlAl3pjtFFSgpI87Y7YJf/ULSxUmU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
 by PS2PR06MB3606.apcprd06.prod.outlook.com (2603:1096:300:5d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Thu, 12 May
 2022 13:38:26 +0000
Received: from HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08]) by HK2PR06MB3492.apcprd06.prod.outlook.com
 ([fe80::88e1:dc04:6851:ad08%7]) with mapi id 15.20.5227.023; Thu, 12 May 2022
 13:38:25 +0000
From:   Guo Zhengkui <guozhengkui@vivo.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        Mike Christie <michael.christie@oracle.com>,
        Varun Prakash <varun@chelsio.com>,
        Guo Zhengkui <guozhengkui@vivo.com>,
        linux-scsi@vger.kernel.org (open list:SCSI TARGET SUBSYSTEM),
        target-devel@vger.kernel.org (open list:SCSI TARGET SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Cc:     zhengkui_guo@outlook.com
Subject: [PATCH linux-next] scsi: target: cxgbit: replace ternary operator with min()
Date:   Thu, 12 May 2022 21:37:52 +0800
Message-Id: <20220512133754.40849-1-guozhengkui@vivo.com>
X-Mailer: git-send-email 2.20.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY1PR01CA0161.jpnprd01.prod.outlook.com (2603:1096:402::13)
 To HK2PR06MB3492.apcprd06.prod.outlook.com (2603:1096:202:2f::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c4c7b5f-5dea-41be-b670-08da341cb0c0
X-MS-TrafficTypeDiagnostic: PS2PR06MB3606:EE_
X-Microsoft-Antispam-PRVS: <PS2PR06MB3606952C1DBBDDAF9646D9ECC7CB9@PS2PR06MB3606.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aMa1IHTDQ8jc8oKnuOXMYM7ldqb4FZgwVOwqtwJ3QcZF2s6cN9VOW7c8/HLGQiSlPDhEK1UDkSteSOCJy3f+3l0OxUFqXO9NmmrZuRFxf/fyKVED922C5ZSf7q5nxjXJ0klFU8S5d3Y6UekffszdJnbOLbvMsoF8jSe1jMemBBw4qQqMvLGXWsOSHTDfQJSi/IBn2XyUkWCWL/EVEFagWgCOPb+rWZFOgjogvy4/FREhaQmRnyUwEIZP8AL5gVGimZnw2s/8GcjBNOg+0LMkM6Sy7KNliPHunvQ/r7tCeSv44JE5UYLRDdaYdAYLFl6gspZiU3jbpO5TO7ZY6u+vjSqcdbUCSQqFu973P5PzEe+Zp5fYN0ZXNFUNyZoTBy0VsE982dxj9eXpI9kybSE0VeV8kjD9YwwZZuDhf3Y608e3Jy8C76lO0T+uk3CUTSjEkXAXi2TjUUwCC4Yc/pPFw8zwjVxWucQzmDKnkUclPhO8BpGc4izt0wX4PJEzqltbneHo+VNob/plrrSks205e04N5PsItK6qMDsPT/xXstdUUAQ4lCBY/Zg8C4135lYBsOkKmNQdlJwaxO+hJ1b8f0LOy2C76Cusekap+bsaZBOMAder8XfrwQ84qvrWE6sufKOaHtwykqkwDJgPvW5JdQAjbSjk6BldUBlKqp9BgRM8SunqQbuWODoLcKg6rNaH
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR06MB3492.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(36756003)(1076003)(6512007)(2906002)(6666004)(186003)(2616005)(86362001)(52116002)(8676002)(6506007)(38350700002)(38100700002)(508600001)(4326008)(66476007)(8936002)(6486002)(5660300002)(66556008)(110136005)(26005)(66946007)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YKuObxdaeHHQ81VACLYnPuqZS2efaLgFbSPc+qkxLXQE2NfdDxhB+PSOtneC?=
 =?us-ascii?Q?O/nYWgg9t/RWKAIrFdOJ7Ew+Q2Ene2xe5+suBDdULmOuKelB8cxKwRbTGkxN?=
 =?us-ascii?Q?2TtcgNV7t0voPcDU2kdSvgLPUv4nu39WkV6R2QM3C8KIv8XGqm4gBPtIBa2r?=
 =?us-ascii?Q?B5BUAjYwB55qaErnlztndahisjwkFdcyPihH7C0WEcEd7XzJB7ScsCY/i2qL?=
 =?us-ascii?Q?CrV5DITNmJz7JnTh8ERoEwL2+RzC2uYfKb5PodJtoCky61t3K3MKn9FfFlkj?=
 =?us-ascii?Q?T3SA3eggTgm8alJBMmeo9opxVhj5Qs+QdLb5fBtAxCnHuo9yyU/+lNzr3jD8?=
 =?us-ascii?Q?KZpfVWcPWN2KoKvISlrkLZjHyZlcWkOCV4KFEQpwHek0Z/SWsg00EFVuEcFq?=
 =?us-ascii?Q?2DZLcmf4XFY5+PIAJ3qgTmxBZoYqUPbhRaUqX//Fe3bopZKSlwS+EhEFFwGK?=
 =?us-ascii?Q?8nTu0+6qgt75YfK9Ji+kPEoEwVYG7ub0dUocWymYjVcgMBdSIxuK6QPBhB8N?=
 =?us-ascii?Q?mtKmYGLhJvNpDbrSukihVb+8lCJnufTynH12gmfpdVjmRs4sgkrqbW1SURRl?=
 =?us-ascii?Q?7s8AMdZ8aNXJTQZX9EckCzQ39nAJSf1OshIi8+00RRXgjfkKZvxor0d/T1CT?=
 =?us-ascii?Q?/YD3rE1lJM+FN64lB3/EUR+jAREFkAdyfCVsvvYPZIXYzQdd68ew1flvcNK9?=
 =?us-ascii?Q?qLfuSE1TMhAziCFLq1AdiR2bTPIxDfRWk1huXvAaVNeZByQ2hZUPKcYpiund?=
 =?us-ascii?Q?46EcbaVJvff/H/NDa+0oNgHvdmGPPn8L7ysGOnhBIUe1JtXGEv3iAFNhrJkI?=
 =?us-ascii?Q?/xqpg4yI59y51tCPKamO1a3lWjp+OyPwzGnBb6hE3/IbSdl2+JfvONueMfEX?=
 =?us-ascii?Q?Z0f/SBVGMbEcRcX2QFImexW46zMNXMY/0vtJuhFTLjMQu14/a1wuIdAYIrMo?=
 =?us-ascii?Q?z4RPIyeq7HDWMAAe0hRpiLa24DZnTCfzKEVPAmwma1AfXAb0uzALBB6CgbHW?=
 =?us-ascii?Q?wfYHfijYzCdu/bltZstH+b+ql1uLinHXA1UnV26GeRwhkloeIUQVyyoxnQvK?=
 =?us-ascii?Q?7ybaQqNrxPhMxykd0j/SurC6zT5QOtnErvKqBeF1aXCXDcg3zcxhBbfAMhT+?=
 =?us-ascii?Q?PQ0eJmwRtw1WR5F9WIdLV5uGETXFT7pAUUG6WGtSsZlZEkG7BydBq8ZWOw/7?=
 =?us-ascii?Q?1tesHobOOp/cPDQbq9hpLOTWvx2g7C+ndsvzFcV+gbhaXyjaYnIuw3ZrxQ+/?=
 =?us-ascii?Q?EJoJcpIDz7u8ELSex/WecpYrV16TzGsiIY8IV75Pg1RKXYcmYEJZNE8JyBPM?=
 =?us-ascii?Q?Vuw2cbvHhl8R9H6lN+jadR4wwwy2urtNZG/0NQbvj8tLLh0NsHeqCuIE6z9X?=
 =?us-ascii?Q?3dfLAYqHByKsn421JsjjtlB6TX/sW/T/BifpAmt62ABts3BWJqtaptROtzSY?=
 =?us-ascii?Q?Y0kiNv5x9H1NV9cNZ7qnBUHo5tLPQg+seGwAs8fr7chqO3yMaJk6G6K4TzVy?=
 =?us-ascii?Q?PWgFUcWumdAJ6NJiV9KSK6p1SdG4m4v5VS4/fARydWw/539WAkowRC4u9Cqa?=
 =?us-ascii?Q?U1GdaPgsA8q7HVYM0QqCCJH5ouTb1P2H8274GuVWV5aFz326ZpR7s6z7sUYR?=
 =?us-ascii?Q?bwvIKRvnC5mfrEAyrnG8XZfZ5xDsalyXxrCs3TG7og7+t8ewK87HX3qYXoIE?=
 =?us-ascii?Q?XFHJnlH+V6cfLtpdiuBbDo7zlzCcbz9Nre6TOmdwYh6K29UTvOAxnzTJkN5M?=
 =?us-ascii?Q?ONQwfzUr9Q=3D=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4c7b5f-5dea-41be-b670-08da341cb0c0
X-MS-Exchange-CrossTenant-AuthSource: HK2PR06MB3492.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2022 13:38:25.7525
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jYAF3cN83+6a7ba6mG7cw+LmHEU0et3dYdJ6srQFAWrpytnRy5GG8jUhlXuobAW+FbS/1OcAVLjIqUatSUlm5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR06MB3606
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:

drivers/target/iscsi/cxgbit/cxgbit_cm.c:1042:12-13: WARNING
opportunity for min()
drivers/target/iscsi/cxgbit/cxgbit_cm.c:1011:12-13: WARNING
opportunity for min()

min() macro is defined in include/linux/minmax.h. It avoids multiple
evaluations of the arguments when non-constant and performs strict
type-checking.

Signed-off-by: Guo Zhengkui <guozhengkui@vivo.com>
---
 drivers/target/iscsi/cxgbit/cxgbit_cm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/target/iscsi/cxgbit/cxgbit_cm.c b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
index 3336d2b78bf7..6d9a13da6cb7 100644
--- a/drivers/target/iscsi/cxgbit/cxgbit_cm.c
+++ b/drivers/target/iscsi/cxgbit/cxgbit_cm.c
@@ -1008,7 +1008,7 @@ int cxgbit_ofld_send(struct cxgbit_device *cdev, struct sk_buff *skb)
 	ret = cxgb4_ofld_send(cdev->lldi.ports[0], skb);
 	if (ret < 0)
 		kfree_skb(skb);
-	return ret < 0 ? ret : 0;
+	return min(ret, 0);
 }
 
 static void cxgbit_release_tid(struct cxgbit_device *cdev, u32 tid)
@@ -1039,7 +1039,7 @@ cxgbit_l2t_send(struct cxgbit_device *cdev, struct sk_buff *skb,
 	ret = cxgb4_l2t_send(cdev->lldi.ports[0], skb, l2e);
 	if (ret < 0)
 		kfree_skb(skb);
-	return ret < 0 ? ret : 0;
+	return min(ret, 0);
 }
 
 static void cxgbit_send_rx_credits(struct cxgbit_sock *csk, struct sk_buff *skb)
-- 
2.20.1

