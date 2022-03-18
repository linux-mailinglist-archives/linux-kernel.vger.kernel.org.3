Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAEC84DDC59
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 16:03:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237703AbiCRPEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 11:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237221AbiCRPEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 11:04:44 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2128.outbound.protection.outlook.com [40.107.255.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293CF7D038
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 08:03:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=El00VutyQsZ+invUqQKZWBztJzt1G5bFaxh4GfxndyzRgj7IHecukBlokHsNnkHyOCRmp6xX5jjLpnxgsNcj7NfEdqx4nfKl8pEBxMLlSzM7r30rD6JYYbzOnbpyZ0uPeSq0QyazOWiqFfhNcVnxXM7TzxHNhIkORy8tuU9D3tBilRta9ntb9npn6AN5styy1Al2O0ZN3akZFat8njQKCDFvbS6X6ItqSVWiCK31oQ92ukV6nNzCr0+SrOrfjQU/qjxFWoy4YT1SXbAbuQ7pqDeA/0mzujLGApKaGsO/x75eH+t6QixzNETrXv3IPKHTq6I4eXZWC2LU8PzVbI0vsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E3Oxig1VftUP80G7DtjiHe1ujf/SSF3C+d8SkoBaQLc=;
 b=GIIjWQbgnpozt9cGqR3MOYEMbW/TtCHbUqhxa4OPGsochgo45F5m1g+XnTRmBej7rGNkltiukIH0pCtL7yBBxe3Vcq56Lk4wFEuesQjTH3GxPw+xNijA1IuXseIa9PP+3Zrfu8UOD77fLjCOZ6VUB8wSGqO+TL9/BVUpZEk0bxnlWSXEC+aUDpA2UkWckNr1/2ALFKreXhBVcp5zUBy6EPXdigxRfo+ywEhsV+jUbsqbJs9W1ivb8p077chB72A01txw7A/FSHC6DuU8hnP0OE9Hz+i4YkiwwnlfXZezxv5hCN4NK97seqmNtQceyLepzNapWMfsWy0ZSR9eQkKlHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E3Oxig1VftUP80G7DtjiHe1ujf/SSF3C+d8SkoBaQLc=;
 b=i9VdaOiIpti/raMpjX3ZCF+zetmf+R+sJCjyOgmhQnINeENaWKC4OQ+lB+D3UWG0p4eJni3JFku3VNX6NCTRgPRRHIBC6a7QYvdtx9QyALYYlXOGLizpCnvDNNdgbLeWtUGGFwMw8wC5ny9bX9PSP7oK3d5qQB8cBRK3CmR74tk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 TYZPR06MB4061.apcprd06.prod.outlook.com (2603:1096:400:2f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.14; Fri, 18 Mar 2022 15:03:22 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732%4]) with mapi id 15.20.5081.017; Fri, 18 Mar 2022
 15:03:22 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Cc:     Wan Jiabing <wanjiabing@vivo.com>
Subject: [PATCH] pstore: zone: remove unnecessary memset
Date:   Fri, 18 Mar 2022 23:03:04 +0800
Message-Id: <20220318150305.4573-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0117.apcprd03.prod.outlook.com
 (2603:1096:203:b0::33) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74d2a61b-dff6-46b8-4d38-08da08f071b6
X-MS-TrafficTypeDiagnostic: TYZPR06MB4061:EE_
X-Microsoft-Antispam-PRVS: <TYZPR06MB4061F7AF824B16E3C801AA39AB139@TYZPR06MB4061.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WXa4M4aOmrUOAki1+Aiy6+qfCb5RZfjMlSHj1DRaVzPFrA/oty5XeZIsBOVZgTN3EvLpt9YsestgizuTWW5KdNzAHn+7GYHGIfJhomKGT1DCCpIKDbsZUE83+ZPIA3GWZ3EkJEEPZsdwuanlQDHepQ04NyOGf7qkzumnfPyv4fpQF3qVe5JG5Iq9r2mpYMif3Mog+J9drCg0Ugj+iLuK8xVg69p7EIWZ/JzN02DrPTuuj2UD0pbNx0RPrPwecds+8Ra9ez+33IXI3UdF77UzZr+8CBHvalsjuPZipVFNdslqSmklYnKfi2LSNwJD2NQ7rvt//E5GWqXJPbsznwgmBrn8GbDwHPHwXEQYwU3XAFN/4tUcDoOvtp99LI7HSjr8H7R4n86SDaUK4hXva3c8d1oPsm+LyLqc8rLU/jqP+iK6Sn4mglNzLn9VCZ9k3mQeIp4LZEiMtWGRcTkD5eByVTmDYe2uX/S0mPToCEa+SQK0Q7zXiaAEA+rNoTCTDFmTa328YhRTSMSlhZU9cR93bpo8EPirgO7O0gLkrwAnxXyJ0We4InrrAJa3yUHEvnCrWfiNIlMACIsCAIcjOLnJq60xmq/k37oYx1U0BY7LDlya7RbAMu0+FrdEfEVBSFs4r/8xQfGnj0Q+vhvm1kNIvwVg1kW5VaV6nwgyd4fLbz23N8N0dQbSC5LJ7DYtBfKq5Ni9AlMtnExZ5B2513Y9tQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(6666004)(2906002)(8936002)(83380400001)(6512007)(6506007)(4744005)(36756003)(5660300002)(2616005)(107886003)(4326008)(38350700002)(38100700002)(508600001)(8676002)(110136005)(66946007)(66556008)(66476007)(1076003)(26005)(186003)(6486002)(52116002)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iam+FAlpx7ddqvVmOaF2Q//pjKDvy9BNFsUFsB3PRjtinK4GiwjDSN0QIUoa?=
 =?us-ascii?Q?neu5ER5GMHa5MKLzD9LLjWe/5Ew+72hxX7wc52sUJFKazkcJOEwou7ZGfG4P?=
 =?us-ascii?Q?0dV57Mm+x60oDF6dWt/mqt8T5e2e1KsPV/Yg01yJOFs9u1yjz2imHvvHtXAp?=
 =?us-ascii?Q?ApSoPnGJN3xAkKIXgkSFiXRUEXvSWIIBBDQ2uw6yUOSLw5/ZGWL8Bq1iXG9K?=
 =?us-ascii?Q?m2vGgvcuQ9dGqGKRiPeh6F/b7aRZ3uNc1FiYaM1X9YwR/1tSTyzN8ERx3uXW?=
 =?us-ascii?Q?PTXvxBEVS7Nh/EvZezmoU6y27ResMIb1h/g5su9vdO3k/BTrJtPL7wdvd2Bb?=
 =?us-ascii?Q?9VFL78KMW2nRlK2iMB4atT6d3CnfP0E0OgPHd4UYcC6RN6bxTeMKp9Ch01h3?=
 =?us-ascii?Q?hvD2wHK4jYoLYrGIxJrmyGzbHY1YwtTbLJFXbzaq1Xhn+LbVtC15j1+w02ND?=
 =?us-ascii?Q?iqGotHm10w+dFIjhAvLTPVsXxe8BQWiLOqB/DPJIo4jnzUwgyPUjuOiX2ujY?=
 =?us-ascii?Q?96DQIUDq84z9YwpeuDGN4B3boxC+c11SZaVRMV/V4ntSHGqLa9r7vRru7zFg?=
 =?us-ascii?Q?yUOxlMeJf2iTNo2p+30IOyaAKuMY2dMgKwZvGHSrxaqD9TQHjGPoOmZsbP1G?=
 =?us-ascii?Q?Gl864N+L6lQAAgQSvMBZcw2fEqn2TP0q6tc8jalqsBNvBZjHsAKEvil4Y6Vv?=
 =?us-ascii?Q?Da6wNAHydJjjRt4MoDdz9XfAW2o1qV4/SBqWwtj+TPmHQP3zGDhj8iFoAVuR?=
 =?us-ascii?Q?dK3HInlWEKDegewR+jvd6RRFtOOYH/isPuN2Ra+wp+EW13nyIpvWRgxDOFYk?=
 =?us-ascii?Q?foWd5LjZoJVgjqd4lWBFW9VT75COP7owG5uSs2N9OtaUTLi7Btc3M/oifx6M?=
 =?us-ascii?Q?7zZMhbjLojAby74bfb+/FFFBFEMTCk30qQScw1UCRadmHDBaHuv6y7A6OBvk?=
 =?us-ascii?Q?qVGcwDeULBrHtm+Hh2w5WQTRUN2PGjwMaTNW9uRugjyf4WIdLQHp9nsJeMK9?=
 =?us-ascii?Q?9JEhxOyyt/K+qQmhewRfWB1twEuJnH5OGnSkm2ipk5h2hHOsI5hDxfj0LP60?=
 =?us-ascii?Q?bh1nkgZZh84nO8KPAco6lwX8hkKAbdo7vy4bjzwkpKgoxaf9QKDaLCUP9Ph0?=
 =?us-ascii?Q?ehtswXuezJd/vhu4io0cMg17g9m++NfjW7WerTJVfzfW3QcR33T8/hLEnTrL?=
 =?us-ascii?Q?YvhqBxXMdbxhmfnYiFI/o3nkvR318ZilR8Dx7GSTUDzJQIjjQ7jloF82dxn6?=
 =?us-ascii?Q?557/mVuTBBSpKbT7FnjPJ7Rdvc0b+ru11weBIEALxReuqCJQmOF/9VsiaVXS?=
 =?us-ascii?Q?PwXxe4K16SXZR4ryA6pjFnR6zVJNUo0FMjS0LLTibRTU1WzxIq52fHveftnn?=
 =?us-ascii?Q?72qKmuP2Kk0CUd/gcyl+/e94dOj0smuEjtqsV+1DOW3ZSqdMYt7PKU8kNzG0?=
 =?us-ascii?Q?aHaBQxR7fptqkGB2ct/XxV6I4yGGh08X?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d2a61b-dff6-46b8-4d38-08da08f071b6
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 15:03:22.1948
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gtxJ5l6Bn2dZBOFvhz0/PSu/Cczckn4g+ewuZGStE6J5lkJVR3oFQwY+2oWPDPUrgmmml2kPsj+tgfELIQsGBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4061
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

zones is allocated by kcalloc(). The memory is set to zero.
It is unnecessary to call memset again.

Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 fs/pstore/zone.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/pstore/zone.c b/fs/pstore/zone.c
index 7c8f8feac6c3..27ee216345a5 100644
--- a/fs/pstore/zone.c
+++ b/fs/pstore/zone.c
@@ -1215,7 +1215,6 @@ static struct pstore_zone **psz_init_zones(enum pstore_type_id type,
 		pr_err("allocate for zones %s failed\n", name);
 		return ERR_PTR(-ENOMEM);
 	}
-	memset(zones, 0, c * sizeof(*zones));
 
 	for (i = 0; i < c; i++) {
 		zone = psz_init_zone(type, off, record_size);
-- 
2.35.1

