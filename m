Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DE74E4A09
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 01:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbiCWAYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 20:24:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiCWAYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 20:24:35 -0400
Received: from CAN01-QB1-obe.outbound.protection.outlook.com (mail-eopbgr660129.outbound.protection.outlook.com [40.107.66.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10AA10B8;
        Tue, 22 Mar 2022 17:23:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aL2asP59lNVpVD+lL9XX7/9JGvee2I8s5Xpe1vPOyVGvorWdaocZZ/xQqZoOleLvVVYfdwFMVBsmbFlOjiEUgftcHZViB0pJIHFQUeCIxcxkRSajWA+dsSPgUyPHNJ7uFza6giPV4eYC3DVzikozyZ0t2gKV8vN+3g484IRjJRcWDx5yIRgb+mQxaSOSWXnvCI2JgV25rfyFZOu1R78g1BTxy22fD+7CIkoYjkh8kE7ZDiddiyGgoZAUCpEHNMJqSl4kbqQVcTQq4Wm6i+qSiFKPHYsPErRA2D5lxNFdH24pifaoImO2PdDfMjAZwyVY7DGrZu4Vd4W3Ckocpm+gLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcu3nv73Y9Ukzx/xKd9dM6mWdvjtUjrkoa3cE1HvneI=;
 b=XOWfX6tp9C3Tf8L1BXnvpSv2w2F/w12XGzc4ygXGjkKyIblOuGchSp7tv7fSLaHOy38TQazOLlRet2I4knWPlAadZOyx2nzmdOgXfAzGKi9yjVI6w/V6BppnnQKE7f2MzGBBJ03CixBn/KXeMVHNoiFnQcB5KHtRw5atykdQTEf3wxmVYQzRZufmArUbF+ysdjLrD9kC/3nogFvugohMQ8zM6Z50Llv4xaq3/k+xsgB2GHJ82BcOLFwyoENeCmYa6G8AEeWO6b54ceEAZdlqyu6m7CHAQWVi3hJqLhP1tt3w/w2GVHDRs+C8+NTsCl40uXbKPxmtP1IzsfdP25/3NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=lenbrook.com; dmarc=pass action=none header.from=lenbrook.com;
 dkim=pass header.d=lenbrook.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lenbrook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcu3nv73Y9Ukzx/xKd9dM6mWdvjtUjrkoa3cE1HvneI=;
 b=aeLMJiHz1RbeLGI1YYZwv4O3L3+i8HhxRM0M4kz7C7xZpqkwi1s0WbjNZw9DrlP5zA0IGSXY+mFsRPfQQsxj5ai0p2cpwIAy8dk1JhJ3mGlQ8MKMRutYILolR53h/Y7tnj/TvOTLLri/yjpIBk2WAgL7mc8E4djLfcQ2HXhr6Hc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=lenbrook.com;
Received: from YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:e8::12)
 by YT3PR01MB9009.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:7e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Wed, 23 Mar
 2022 00:23:02 +0000
Received: from YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::291e:a689:84cc:ce0d]) by YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::291e:a689:84cc:ce0d%7]) with mapi id 15.20.5081.023; Wed, 23 Mar 2022
 00:23:02 +0000
From:   Kevin Groeneveld <kgroeneveld@lenbrook.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Kevin Groeneveld <kgroeneveld@lenbrook.com>
Subject: [PATCH] scsi: sr: fix typo in CDROM(CLOSETRAY|EJECT) handling
Date:   Tue, 22 Mar 2022 20:22:42 -0400
Message-Id: <20220323002242.21157-1-kgroeneveld@lenbrook.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0135.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::14) To YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:e8::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab0ab5cc-7808-4f70-5ece-08da0c634aeb
X-MS-TrafficTypeDiagnostic: YT3PR01MB9009:EE_
X-Microsoft-Antispam-PRVS: <YT3PR01MB9009F6D460A039D886720902CD189@YT3PR01MB9009.CANPRD01.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6RbL2RJgiHgzUA18VbyP57tvf2AlwU615wK3UFhHbColidIMHXkpx0rB36Q0iRqLSAJvb51sA++HiukQoUbzwm6rTCLYsbeyHSyUu1YO9gONZ1KJUUG9uhwCRc3hBTUuDE4WSuM0NC9Lzz/SH5jPwUYeRTRZx4SJsD65ID1mcaEWsQ1fWO6ty1ht+L7d4C6d1799qfbIvDSx5/u/g1qVA/sMZbuRO07avZUfjE7PDGH760+Mlw8AMCRGrK4UhOpfnW6NlcyN3bMFb7csxM/I9uIbyJgq3X+E6zH6hjQE/7QxU9vsGhiAgaUwjxKfiRjapH6GuPnmiAt/vrK9IvLIwZCharhvIWCiRBYn8maqgrxxsstQLzSBPvMAKM/QezWb+xWXdA7dBxU4abY71+p8hyr7f3CuKFBB6IL+2xlelRaXeE/f5LU2OX2qtTPoOUmESuopfT5Mq3zjO+RAInOyFka61mUB70ajX7LtrqqKmPxIYV3GrvImlJss1ETmjnRM2//9GrwrZfUDo4aqzintsGN2VuZE8ixUdg2HuqhAbwn9qQOuHoPLSWKWzmX3ytTZFNwpnUYMNI7vUSYCzLFnlwGIawRMFDUZ08fXuKHVkPqu8B/qe+TB0OamkC0O29Kixsacfd/Hxz7nmhPbzkxkojo5fdG9nX1bJevWSbXNq0GzibOCWFlbLMlGfm/ooCqg6S7LwoOZGztwbvTLC7a4fQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(8676002)(36756003)(6512007)(6506007)(6666004)(66556008)(66476007)(66946007)(5660300002)(4326008)(2906002)(38100700002)(110136005)(6486002)(316002)(86362001)(83380400001)(508600001)(1076003)(26005)(2616005)(186003)(107886003)(83133001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RKMVjtz3PlTdNfhEZkvVO4Wsa4chJhfa4x0EJyFzyQDY3KNPlNLs/4IA78LD?=
 =?us-ascii?Q?9EbYj2TrW9EIksC3Td2yqo0HGa11QvojrwSZkCq+E1LCIr5lMFlLNgB0rFLx?=
 =?us-ascii?Q?W3mwC2m3rE5soDR4LoXWCnK6KIawwtSY5hXErWPlOLavgIQvEJSlXSsPPFTV?=
 =?us-ascii?Q?u6ezmYTIypLGTpqr9Xi0zhmp5wI1A3MNeUEjLn1IkuBhEiY43zXszkpa9QES?=
 =?us-ascii?Q?LXqTa318Pocgb84jKz6TesPrkgzkuGCumEw7Ysu4SG4wvqerLn4TJEuqCXqB?=
 =?us-ascii?Q?AfCFDtLng0ktAgz75M4FLBkRQ0e0Ra9Yl1nruVZUFXEH1O/IUw3TpoYoNyfz?=
 =?us-ascii?Q?4t8qSafGWpCAEKwhz1YLPfJv99n5HsDM7PEsqoc5/jHUiNSX+s2t4X9+c2IG?=
 =?us-ascii?Q?TVmt0cSliNHS4ibLAuTv0xTk1eHnMhIZVYhOpa/EtpQhdJtqd1hMhYAjBEt8?=
 =?us-ascii?Q?dCVKdnHq9JY0TiJcOtNEbf2ssTAY15/3KwVJ8F+ug+1xHM036nAQxrXlVA3e?=
 =?us-ascii?Q?rE43sA0ZqXAGHl9bw3xe4PvHd85AVjqXumRKJEpEx0M1CDcrBWmQJ8aN0wH4?=
 =?us-ascii?Q?9Qc+6lYQYYwmLaDOtkW+/Y6WmvaPVwcFnTIIQ2dkQW9MdEN7vRySm4JJzox/?=
 =?us-ascii?Q?i/nj3XtWYxw5XrsNCFDo4Dhtv9xNLxh6pDKF/OBEefndmEIomNFUj6Wn83Xz?=
 =?us-ascii?Q?5PRIU+1tjKJ92HVkrrJqy1ndEoXwyTgVsd+yKlAdY2eMNOFfwvIB0ADQo9ff?=
 =?us-ascii?Q?vy7pbqcltzA/Y1v9DTnP6VdUSwuiOD2yhDyFkl4uLaNRRqKhaKLM6LK3917T?=
 =?us-ascii?Q?Objg8JXqrbUJWimMxfnQpr7CP6NsjHkBeo6Ck9CRgGKcS1arZ9kCQu15jF13?=
 =?us-ascii?Q?jB3wpeukB1XMh0NCSzygEIBsFqJwX5zELwY4xyIZV14mNT1ehYLXjQXa6CoZ?=
 =?us-ascii?Q?PdSoFbBY5TEpxOi4sINxRiTZ+1NTrzof8QbrEhnbhJzEKOwvqq7qO+imcH1Q?=
 =?us-ascii?Q?SqyNr+N3c+Z7hzaqW+perxWwRBP4BYPJ6nF8qtvQRSQjLLke5fnh3xsSuxag?=
 =?us-ascii?Q?uXiZUVT+LDREP37bJ/4jBalOpGRqiN6RZh8qZCn7IDT2BWIdtgz95lNax2FH?=
 =?us-ascii?Q?d4luzMDL9vexTv4e/W7Q/dlaaVSHTxoE4sySibKM/JosGGPxM1VfqufmiPgE?=
 =?us-ascii?Q?JzJtj+eMxpSZLpjUDLz1R5HnYamNYjJ0T/jF00ez877iZ7tttmd0jcBHkygf?=
 =?us-ascii?Q?aCIEIyojzPn6etHDDEs7NIfMAbgzgV6j2EPzC+sdESot08RyDEriiEO8d1Ni?=
 =?us-ascii?Q?lQ8WAdwoNr5nvDvMhF00p8AXFzZGcs02mEzmul3DQxUVRUHoZld3qSwx7lxT?=
 =?us-ascii?Q?Xwl3ihB4MRZUER36/wSmqD5JzcAK/OehzAlDJc3fPc6DmRrwX9CZgbX4l68o?=
 =?us-ascii?Q?rAcFZzdIb1+2cBNJHhqZqa2RBtpKxC8Sq+iqp8gSckBcogjAj1/z0w=3D=3D?=
X-OriginatorOrg: lenbrook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0ab5cc-7808-4f70-5ece-08da0c634aeb
X-MS-Exchange-CrossTenant-AuthSource: YT4PR01MB9670.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2022 00:23:02.6612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3089fb55-f9f3-4ac8-ba44-52ac0e467cb6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9GYLWNPycsFI6Gk9kiN7Z/hCdHhoVw7vYf2zPjqQzyF0dKYRAhqf9t90OqS4+x5hlxMMbEpnh+RhzeZZNFcy2z7aVVt2Obd0lx48+wXzYX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT3PR01MB9009
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2e27f576abc6 ("scsi: scsi_ioctl: Call scsi_cmd_ioctl() from
scsi_ioctl()") seems to have a typo as it is checking ret instead of
cmd in the if statement checking for CDROMCLOSETRAY and CDROMEJECT.
This changes the behaviour of these ioctls as the cdrom_ioctl
handling of these is more restrictive than the scsi_ioctl version.

Fixes: 2e27f576abc6 ("scsi: scsi_ioctl: Call scsi_cmd_ioctl() from scsi_ioctl()")
Signed-off-by: Kevin Groeneveld <kgroeneveld@lenbrook.com>
---
 drivers/scsi/sr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index f925b1f1f9ad..a0beb11abdc9 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -578,7 +578,7 @@ static int sr_block_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 
 	scsi_autopm_get_device(sdev);
 
-	if (ret != CDROMCLOSETRAY && ret != CDROMEJECT) {
+	if (cmd != CDROMCLOSETRAY && cmd != CDROMEJECT) {
 		ret = cdrom_ioctl(&cd->cdi, bdev, mode, cmd, arg);
 		if (ret != -ENOSYS)
 			goto put;
-- 
2.17.1

