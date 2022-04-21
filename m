Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E23050A97B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392084AbiDUTt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355803AbiDUTtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:49:24 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F2D4D608;
        Thu, 21 Apr 2022 12:46:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ij8QpbNmMQcBQ5O5uSXqJnXBLxPl9HpmuDZ2Qcf7QUCLLKS4NZAH9qsaeWjOmnp98ainslqb2xmHPU4gzNvl5QgPXdzbjVFpSg2EjRtdoV57t0ATu9v+UFeMy/4tJ9ndzANClwDKmIbPt8V62eoQiS0X9ybmwHni/a8Z3oAtNVe2G8DNTsFrLSuClUyKVWEP7jvOFjmiepQDK4z4/x0KBQy8tfjIjJsMOCwLog3lfYciPHEVcjiZui8EgCC0i29e5RQCX4XnyVdLM9OxJUh/notb7Z7yF+CGdEyaPj9NKjw/1JAvjQnbrWgzy4ghmRMOQ8nT0KJ5fS3zIOJNzor+UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ll9qGamCYjrqDd1n4RuM8O805tkwLUxA5SOasBS0xNw=;
 b=CvC/0qhi8mNXAuF78fqZTUC7bwAEYqTmFi9/LLzalCGaPowQoxbsiWZH7bf5hfG6HoldH4iLJyAgTUVFNgQlCvw8QaTfP6WGYwl3vP+t2UMFzs3+GePCru78kvVt9dh7wSaUj9YzyOdRUttyjmrVUKkG0mNHujv/bkfazQDgRMWurmZWOYPWGvfdYt+eQQhsUgzn6wKcdA7bT38mjCSAGDa4VuTWewkzrLUvaqDdvMFenGy6KxgAYML0KgQGEyhwyArMKKqstQIvoMda8rtHIMdK421dnXO8b9YN6F40vemSGk0+Czx8Cd4sUD6rsSwziK24XaQj3MiMkO4EzXwFDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=eideticom.com; dmarc=pass action=none
 header.from=eideticom.com; dkim=pass header.d=eideticom.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=eideticcom.onmicrosoft.com; s=selector2-eideticcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ll9qGamCYjrqDd1n4RuM8O805tkwLUxA5SOasBS0xNw=;
 b=PHcvepv5aEQew8zg37jUwxc09T/f99E8tWmO4juGrtQl8QhpogHmNFeI+GYkw1YbUOOxLw5OeDH9PYkTqCqSjp5uucZtZjMxd0D1of6ZzpBHM4LXfKBaYJhIXZWcx9OoelJdkI2g1F8x0ASmcdovVPzZWTG4wYAmPpwiT31LRvY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=eideticom.com;
Received: from MWHPR19MB0925.namprd19.prod.outlook.com (2603:10b6:300:a3::10)
 by PH0PR19MB4758.namprd19.prod.outlook.com (2603:10b6:510:20::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 21 Apr
 2022 19:46:30 +0000
Received: from MWHPR19MB0925.namprd19.prod.outlook.com
 ([fe80::dd25:71ab:56fa:b1e6]) by MWHPR19MB0925.namprd19.prod.outlook.com
 ([fe80::dd25:71ab:56fa:b1e6%3]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 19:46:30 +0000
From:   David Sloan <david.sloan@eideticom.com>
To:     Song Liu <song@kernel.org>, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        David Sloan <david.sloan@eideticom.com>
Subject: [PATCH] md: Replace role magic numbers with defined constants
Date:   Thu, 21 Apr 2022 13:45:58 -0600
Message-Id: <20220421194558.59667-1-david.sloan@eideticom.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: BY5PR04CA0024.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::34) To MWHPR19MB0925.namprd19.prod.outlook.com
 (2603:10b6:300:a3::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ae708a66-1cad-4930-9119-08da23cfa145
X-MS-TrafficTypeDiagnostic: PH0PR19MB4758:EE_
X-Microsoft-Antispam-PRVS: <PH0PR19MB47587E6A3A8DE01B24AD644CEBF49@PH0PR19MB4758.namprd19.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +xLnUXsgqpIpZ8Zhs6KimVMKlqOCF01bH7T7SruvJa6SzIFtDtT3qXWNo6pPDphK4h3MV0bKAsVTTXJ1l0+AF8EVgG0ma1N/eDGvMdBYmVnm37UctvN8Ej7Xt375X5UpqaYmZuKClCYQsuVhtOxooTAVcHuAPSQRkqkmW6zgLu0wivmSgK0oaQyZfRnn6KLEdNljIlb2U4CS27HaRvgOrL/v7oRW45gaC0aMBbWgT2+ZcAd+/t78V4sxsTMwvFWB+L0WzFlxAAwOD5+AdHR4FXE4OSosT+/c2MwLp3BrKHAh6kS4jfKywgqNiqfozEc58tdkXDsdTt5eEjC0WJG08MVFinXdi30ld6TiC2RCyJM6Eubh67rlmcUUciBI69L5oiJvKaYqIFZgH8eBjTnXJ1Jov5J/gG9T9ZsKPS3PzLJwpAshEpIR4/u5sOJxLAjPnWPnnvnHmuY5MRWeGvXInEi3ERtyJO+pbMQnrVwc41rGf7/kUWVnT0d+CvKqWMQ82bJZInA4B9WSpdtjFcUZ3wXXGVM5I1YkdjvwCxfmaDULwSyoqGNQ63iy/LTRFfVSU5jVJMp/tIcH5t4nzHag/6baHnGcDcwUb2r+ODigVV5Cm7WtxA88H2JDCt4FY8w6D3gFB0RW0Ekg8zQztNMYDuMGOawiu9M1mjB2ejbnNgFLoVw+1pcnang59tB6zhUT+Opg0ili5C5hpsEkRe0zGA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR19MB0925.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(396003)(346002)(366004)(136003)(39830400003)(376002)(52116002)(44832011)(66556008)(83380400001)(36756003)(186003)(66476007)(2616005)(6666004)(8676002)(4326008)(6506007)(6512007)(2906002)(66946007)(5660300002)(1076003)(107886003)(508600001)(6486002)(26005)(38350700002)(38100700002)(316002)(54906003)(8936002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AblxrGiG0wbKmv+Qgfp0N00Hr8XowbaKG21faW27Uyu5wZdEl8Df2HQwJxwa?=
 =?us-ascii?Q?MKc9WMJcvJB6MHah1bgtAfXh+w8n5hpngGqpIT++el23IkBykhf/Qadczibq?=
 =?us-ascii?Q?yAOd2Nj9wqtygyLMFbZkqyCqfdCeK38QSN6Cga6q0RcZnpYMmDt8TSXpTvqK?=
 =?us-ascii?Q?q/OigAemmH8IAiORnFpnEpqWPNsIo7nQ7fMW0lnJgP03Lz+LC05DtkjGVN/w?=
 =?us-ascii?Q?Vd8bH7+ErrFBYV3jU6QQxOcQpELovrW5LQ8F70oPzG3ZvHKhHE8y0oKWqS7w?=
 =?us-ascii?Q?kCzp6Huq/Z5N/1gNYcXN1WAWAYbAyOZtQ+SjWFUmltoFiKXv/4dMRYhvvCjb?=
 =?us-ascii?Q?F5tmWADUXFqUtaEO3QlXhT2c0VBeMKkdvTVCX48jcb2cpbvt6XRmDYvaEpHd?=
 =?us-ascii?Q?Z2HQCVqPPtpYrgjjXPymHSnCIzR7x3rKs4x/nsmD2gN0PCUscb7b2fHd8enw?=
 =?us-ascii?Q?Ql0KoHG/eoTqiV+ZhCnxKPoF49odVtsLh28OBm9cDL1UBmksEHeKzyV2Im6y?=
 =?us-ascii?Q?VaNz/g+62sQGn3/kwxF61f8sJmn/IBUOXDNe9k394X261MTVFZA/8svUGh/y?=
 =?us-ascii?Q?LQcN1CY4Fwy2MJfNtWtnSmy43mFBOPbuhOAC9iRuVDHHlpEr4jtaqblpcShY?=
 =?us-ascii?Q?PS9bMeQ/byBrMBK6MMjrRxkM9U77KZwbQthBcFIiAX67tYKnaxcCRPTZEdpm?=
 =?us-ascii?Q?s+D/S3pJW+4/SEnXf1tHkk41bY6oRHihf08N7FC2OAR6YfvRpIJmoIs83kMm?=
 =?us-ascii?Q?/fOP6FUG0A2DX3/MDGXMlwtWUXnLlrB8Ryc4Wuli2MPGHRsr/UjSgwDbPES8?=
 =?us-ascii?Q?aI3s0uupw+SAseIjt1kyo3TzkWaDFKapJwo9IxrzkusVDlmHeLkgIc8H/7Sg?=
 =?us-ascii?Q?IzN1QL6cK+aw2UJZpmI/3t7gkpbWFFqGxKI9DX6Z9bOTwcvEO8BfTw/ENgNG?=
 =?us-ascii?Q?PbvoTtGci+gbHOP2mMV8ap15vkM5W+ZYSOIDh17jTfce0JvklJFyKDgO+dRR?=
 =?us-ascii?Q?yOUZWGYEej60BdV+bMxemr0AidFPY4JSycWf495Czvu2s09mY9LiNTeRVloY?=
 =?us-ascii?Q?/2h64HYW0xluCqBpbbEq6HJZHN4zSegPAQndk/ggry5fMS/xJFcOkwh/G991?=
 =?us-ascii?Q?QfO6C+XgT0FQGoKxmyJKEtKwCS2xwtgvLF1S5tMJ9PPWkGXsfR+y3Hzt1I4R?=
 =?us-ascii?Q?0HNgUDMpNBLj++qGPGS5OLaDmNWixdSO/U9QvUXEGXlRpcxEsqZ67YdiYTzB?=
 =?us-ascii?Q?jneNyCsyLDZE9TJVoRPeymGbzrCFiNCKVUi79IF7BSrv7DkELLCRrGZs7MrL?=
 =?us-ascii?Q?DPzlwyu2QuI8mS8cNySEE04zvLQ0akq076ifWGfnTarNv2isYVMxzu4Iah2w?=
 =?us-ascii?Q?h5eF0Sr/nploQ6B9GrcYG2SRSAf9SCB4cmctnjMLX4vtwvTleNyiqPYKiQEc?=
 =?us-ascii?Q?o+flwtRmIkFc9CS6dZnQ5XtMbty2Lztn9YGbNRTeKUMrgO2+k+OGxs0Dady+?=
 =?us-ascii?Q?X+8RevBAi2uHUALV2KXLnfdd3ylUGUgQ4KCnjh80x6LsRMeS9CyTDjJLNsN9?=
 =?us-ascii?Q?eIhArxWEa2FrNQUCD+ebrCSikHwoB0w3asZmkON2+yVnmQBJJfhR+oDs7f40?=
 =?us-ascii?Q?JHIDPduTWjR0o4RZQxGcdPL6Yj4TT38LtU7WaltDjuoWr87qXRyX/xowonie?=
 =?us-ascii?Q?8l8Xh1JU7u74Ht6IMylY73qgaHXvnPgv34Zl45rvAq4y6Vd+ejSzlm2VV3mh?=
 =?us-ascii?Q?A3O0+JyD1Z3l0KAKUVEe3EaAGpCtmFE=3D?=
X-OriginatorOrg: eideticom.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae708a66-1cad-4930-9119-08da23cfa145
X-MS-Exchange-CrossTenant-AuthSource: MWHPR19MB0925.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2022 19:46:29.9270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3490cd4b-0360-4377-abb1-15f8c5af8fc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0f7r+noA2zjYvhIX3+We8ka84eQSLdSc3ByAr6kgob+YaMSw/gGAf0hcBV/bDJ9Em4mBIM2Os/zYTG4R2y4KOf4kIetFruaQ2TS4I48mSks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR19MB4758
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several instances where magic numbers are used in md.c instead
of the defined constants in md_p.h. This patch set improves code
readability by replacing all occurrences of 0xffff, 0xfffe, and 0xfffd when
relating to md roles with their equivalent defined constant.

Signed-off-by: David Sloan <david.sloan@eideticom.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/md/md.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 309b3af906ad..b34b72fc5887 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -2645,11 +2645,12 @@ static bool does_sb_need_changing(struct mddev *mddev)
 	rdev_for_each(rdev, mddev) {
 		role = le16_to_cpu(sb->dev_roles[rdev->desc_nr]);
 		/* Device activated? */
-		if (role == 0xffff && rdev->raid_disk >=0 &&
+		if (role == MD_DISK_ROLE_SPARE && rdev->raid_disk >= 0 &&
 		    !test_bit(Faulty, &rdev->flags))
 			return true;
 		/* Device turned faulty? */
-		if (test_bit(Faulty, &rdev->flags) && (role < 0xfffd))
+		if (test_bit(Faulty, &rdev->flags) &&
+		    role < MD_DISK_ROLE_JOURNAL)
 			return true;
 	}
 
@@ -9671,7 +9672,7 @@ static void check_sb_changes(struct mddev *mddev, struct md_rdev *rdev)
 		role = le16_to_cpu(sb->dev_roles[rdev2->desc_nr]);
 
 		if (test_bit(Candidate, &rdev2->flags)) {
-			if (role == 0xfffe) {
+			if (role == MD_DISK_ROLE_FAULTY) {
 				pr_info("md: Removing Candidate device %s because add failed\n", bdevname(rdev2->bdev,b));
 				md_kick_rdev_from_array(rdev2);
 				continue;
@@ -9684,7 +9685,8 @@ static void check_sb_changes(struct mddev *mddev, struct md_rdev *rdev)
 			/*
 			 * got activated except reshape is happening.
 			 */
-			if (rdev2->raid_disk == -1 && role != 0xffff &&
+			if (rdev2->raid_disk == -1 &&
+			    role != MD_DISK_ROLE_SPARE &&
 			    !(le32_to_cpu(sb->feature_map) &
 			      MD_FEATURE_RESHAPE_ACTIVE)) {
 				rdev2->saved_raid_disk = role;
@@ -9701,7 +9703,8 @@ static void check_sb_changes(struct mddev *mddev, struct md_rdev *rdev)
 			 * as faulty. The recovery is performed by the
 			 * one who initiated the error.
 			 */
-			if ((role == 0xfffe) || (role == 0xfffd)) {
+			if (role == MD_DISK_ROLE_FAULTY ||
+			    role == MD_DISK_ROLE_JOURNAL) {
 				md_error(mddev, rdev2);
 				clear_bit(Blocked, &rdev2->flags);
 			}

base-commit: b2d229d4ddb17db541098b83524d901257e93845
-- 
2.17.1

