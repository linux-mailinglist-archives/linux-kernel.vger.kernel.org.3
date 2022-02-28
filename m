Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5494C6178
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 03:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbiB1C5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 21:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiB1C5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 21:57:50 -0500
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300125.outbound.protection.outlook.com [40.107.130.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0A5289B0;
        Sun, 27 Feb 2022 18:57:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOh6xTTYn/F2iRbv5lKAD5gtnUMVDSkKpx2ogB0BCYybvZX03SS0tTtG0TwgL5B0TDf51nFIopzXvocnH7Fz2yJKVxSPTJOBQ7gDCAvLFRY6PmStzUMymipyB4RSGu5VBtuCaqvxBb/wSeeeck8fD9dLuEEPAt1LcND3Fgq42E9IVEHt2fNPoT1PK/Ilu6yhLXwtxrraKfwMLllwCllCkyA9yr2Mi0Ul2jjmnIZIl3w+L0tCDbrSF+KR6dCEkfPF3swCUt8H7VW44QS3mOK+0mezn698tHo0zyJNvfneeO9cHO6ANgZK9Hpx1dwPIJARQZ5dOk3cCyXuT1jpai1UnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xpJRC8BRXpTE6fGRumQY3Ju79DpztFSHtEo1p4uaidw=;
 b=I1Y9ckBOq2GClQTnvbPgthgEYX23LPRu29P8ZkjjHNR7LfUm8j7PV6HKJaJnqa8j9/QOdWFHxI2yxnf8P0F4cTrwoQiUy7RbvVb6EnfsdnLVAYihm9V0Ld9Q1JwRVLcJFZHRXHT3bwjRciGxwWwN03RoCtsRX474K40aebjZCx003HUyRNctpcZR9g9BMKft4Vl23Tm9S7/nwyL/OoaxFwgDfE8WWl1sxiWk6KSVJde0mjR4DMHPtb3EDP9XWWyLhKz1edl81DfS2+6wbivRXZqGlVMm+hFTsdgjOT5Ax/mQDkjQudQ8wN/kEKiakpp1YCrHuXFR0xf07vWYMkosLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xpJRC8BRXpTE6fGRumQY3Ju79DpztFSHtEo1p4uaidw=;
 b=E9r0QmlNOe9OrMjS/qzMGXFskrxh5vWMO5ShmkidHTQKmePr0/ly6A+BXp4nuWIsbUa5suam+2Op4e1RTuO++yyV45zzt+fGIC/WUArT3sy3KdTKjlBEYSXrtFkYerESv1VbvdH/0+e/6zFTq9Br174SfEwUin9LFN0iUk8CWfU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com (2603:1096:4:78::19) by
 SG2PR06MB2652.apcprd06.prod.outlook.com (2603:1096:4:1c::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.26; Mon, 28 Feb 2022 02:57:09 +0000
Received: from SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732]) by SG2PR06MB3367.apcprd06.prod.outlook.com
 ([fe80::9d3f:ff3b:1948:d732%4]) with mapi id 15.20.5017.026; Mon, 28 Feb 2022
 02:57:09 +0000
From:   Wan Jiabing <wanjiabing@vivo.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        "David S. Miller" <davem@davemloft.net>,
        Xin Long <lucien.xin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        Richard Haines <richard_c_haines@btinternet.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Wan Jiabing <wanjiabing@vivo.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     jiabing.wan@qq.com
Subject: [PATCH] docs: fix 'make htmldocs' warning in SCTP.rst
Date:   Mon, 28 Feb 2022 10:56:41 +0800
Message-Id: <20220228025646.1665265-1-wanjiabing@vivo.com>
X-Mailer: git-send-email 2.35.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0109.apcprd03.prod.outlook.com
 (2603:1096:203:b0::25) To SG2PR06MB3367.apcprd06.prod.outlook.com
 (2603:1096:4:78::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 436c1d0b-6fcc-4ba9-b8b4-08d9fa6602aa
X-MS-TrafficTypeDiagnostic: SG2PR06MB2652:EE_
X-Microsoft-Antispam-PRVS: <SG2PR06MB2652163879714A5BF4DEE91FAB019@SG2PR06MB2652.apcprd06.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NV0M7CvzvBOESUvPtpgZ9PjGBCLjccxd8NYL7PfQJUzWYx9e7OcV62M1A/v2b/kdumpiPAi4xIQKIK18+GlpEc37iqf+3mHTlfibcB1SppF/lq9WFYG8zyDW1tFBlW5+KKOtDYdS4Q8zMY2aqdLq1rVyY2ra+6vMv6+7dggIjAHcxs21pTj9zNISoa/QhMFVfvU01/wfdgha5S+z+lbg9oJnu0nmS7orjOO/Ybr177yPvaOYDSTQGiaCJCcRjj6YmniN1xXE1an3oZ6Y1p+OcDeA+RLcC6gKaOQ/Q2+GlGvmYkWb/TBPomy84PrH5PVDPkw6FixRtwWKSHVhdw+b5mMjkJwgITG+t7JVPKjiumsE7+3zxArsmlN58lQfie4xG7elI+zzPy7jBIiC1zmFSx/zcg4/GaXjXOCIJW592CjMZAfd5182UKGBWJADyb7jdYlEh98yHsDmB4R1OijHETSqEHQm2jo0cz6wZm5BhHrRRngbKvDZ7EdhPLLDUoh6R0KLGuhQbx71lMCag1y6uJK0VBmHNQAS5K14RNuyHvOSG9IEHMUt4uj6mgBQrM+Z606yZATchevR+nEO6N+mHkoSZe1J6Qu0n/QeRigaDT940MR6gbvngOOBGOccrlv/rr72HbljrwxbedSP8+kTIpoirydIkHKJDlOzI5HfWvuDk4G2Yjn/noC0/7U7ztzytgk5P7yrjZmiIzZnt+nNXg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SG2PR06MB3367.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(66476007)(86362001)(38350700002)(8936002)(508600001)(66946007)(66556008)(316002)(110136005)(2906002)(4326008)(5660300002)(52116002)(6666004)(6506007)(6512007)(8676002)(36756003)(38100700002)(1076003)(186003)(26005)(2616005)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JFC37/dhR6LpcB35iOC4zxbisM0OV72rAPMehf0+Ca3uP1r+7t52HiXxbTkW?=
 =?us-ascii?Q?JEF6Xui6ddT0wPF4V6QfTujt0JIbQAm8MmaAv+HTRpQH4bPw6lKZEy5NIwts?=
 =?us-ascii?Q?bAwNecj1gpemtSDyi3B9yUXBdvojmEb+2pvDRoSE7foeHvkbzG+OWhQv86I5?=
 =?us-ascii?Q?4xBsqM3g6jpkqPDyTHFMsN4FNwfXTLfe0k8xL6IuY4gQ0sQNz7gGPGPtQjCY?=
 =?us-ascii?Q?mwJ6ybLq1VZFZ4v1zUmEBlOXMe162DOaFThZoNV8pw+TDy+EGaDDId7ymPqr?=
 =?us-ascii?Q?3gQujjoQ7vqX8QxlJMyDFp7Axqj2M21POsJogbo+KdMc4s7iyf6j+HwK8SuJ?=
 =?us-ascii?Q?YcMwt6twLROf9YyUA9l5O+vVcDE/Eikxj/PoaWQ6+nUDJuiySXAfSi0aG3JC?=
 =?us-ascii?Q?0esO4+IODLwQFwjb09nohOBNgkTJTXsl5DA4wiNTJMwaCRi9CLxX1lf01diY?=
 =?us-ascii?Q?cwR/HPz+SrbLzVNA3by2siwLPaBUDjqO2KPcCIUULjtTGoUal8CMYxgby1Jw?=
 =?us-ascii?Q?QZB1bYnFKv0dImOQTABmuRpfROeFQH0HduGjLrekoatfvBnXwZaYnMfXAP2d?=
 =?us-ascii?Q?bi70+lThAAWkrV09RM7+BbVPEsWjL72AnUsnzdinKoSXvqGHuVTT3aPcjovD?=
 =?us-ascii?Q?x10/vJadbuEY2axFAK0LhxC7FgCzlAFSF0hXmc6eW+khcwGfa+HwDnojFyMY?=
 =?us-ascii?Q?8e/0GlaFrbHkr6z+7C/9Xzro+R6yO/2bXiQpZm4Uyni4bjWTCDF5uUGk/tVa?=
 =?us-ascii?Q?w8X7qI1PcqNfZUlkL7tcyx7PlH6yVMcfyWCnyAM38h9ouD+osvO/UrO0/fX5?=
 =?us-ascii?Q?7jVGAnwgFO1G6lR5Ic05VGmOAlAA3bYOfevorNHVr95CFk6g419RAOIf6GPI?=
 =?us-ascii?Q?5aoMFysBk48bzLU9DHBGrvrux3otVHC/Up/g8CZBjfsjMatbB9my3i5KEmTR?=
 =?us-ascii?Q?CbcptmCtDPEHLPrnKcTiz9uCKSbuNdRbwTqw2P/soXcNUfi0eAV6E5cZbTZd?=
 =?us-ascii?Q?kcUZgEOwAI6l979fB6yqC555kgpfxMXh8EKv8shzcRpUb4xGzrnTyitBHLAb?=
 =?us-ascii?Q?+KEi47CjVInifx3HB4SAE2keVXn52cpIFAeoKy314CM6Vqnfnvi2HwdvI4ue?=
 =?us-ascii?Q?UuIfbMikp1drMyX7cfXgz0pGf7TThLHxungo0Q+rtFhhrTWMQfeEUHRAUWsq?=
 =?us-ascii?Q?hiac1/PLqnu9KAFBX0c+F4SMhqluifu/eB0ld4/1yaH+BemDKgSzn6J8JlLn?=
 =?us-ascii?Q?Um2ZuTrqhKSaUX2ZWbkhPp974kbYcT5A+ZeVBTw3OvmrjutV8joMN6NU9SiR?=
 =?us-ascii?Q?+3bmMX0hGgfhq96kypqejraWbYw0WCgoirjXjBO97FidAWJ2mA8vqF5qFgeM?=
 =?us-ascii?Q?Dxt7eHJLH9OTiVwgs8i9v8H5Kq+3RKz+jNkDc4Sc+0j+iRTlsp8ayjBS9Gi7?=
 =?us-ascii?Q?/npt9lqDkfmmjn532wkZvEsCSUih/ytzrSALzbr5VT+/G6EJbeh3UmXXdTrH?=
 =?us-ascii?Q?IlLqCtfbGLmX+fhWb52ZbFayFmmnxG1XEd2QiUFI1nmhZqKv8/IFEeZy0/Mm?=
 =?us-ascii?Q?OFNfk1szgX8Sv7rDRGQXA6iTdSnn06MeqonLg8caeTRPk8Xep/dAT0lBtMYV?=
 =?us-ascii?Q?4gkzgbWiwBrBO5wVvO52SMc=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 436c1d0b-6fcc-4ba9-b8b4-08d9fa6602aa
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3367.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2022 02:57:09.0642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7YadqTx5x0OESKh8RFSCG1MsUenxEer5+YPvm1e8/4MNAxpNzGYeDlG06EsTY0JvhHyjkzL+NURxT/JrHvA3+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB2652
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix following 'make htmldocs' warnings:
./Documentation/security/SCTP.rst:123: WARNING: Title underline too short.
security_sctp_assoc_established()
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./Documentation/security/SCTP.rst:123: WARNING: Title underline too short.
security_sctp_assoc_established()
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./Documentation/security/SCTP.rst:273: WARNING: Title underline too short.
security_sctp_assoc_established()
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
./Documentation/security/SCTP.rst:273: WARNING: Title underline too short.
security_sctp_assoc_established()
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Fixes: 5e50f5d4ff31 ("security: add sctp_assoc_established hook")
Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
---
 Documentation/security/SCTP.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/security/SCTP.rst b/Documentation/security/SCTP.rst
index 406cc68b8808..b73eb764a001 100644
--- a/Documentation/security/SCTP.rst
+++ b/Documentation/security/SCTP.rst
@@ -120,7 +120,7 @@ calls **sctp_peeloff**\(3).
 
 
 security_sctp_assoc_established()
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Called when a COOKIE ACK is received, and the peer secid will be
 saved into ``@asoc->peer_secid`` for client::
 
@@ -270,7 +270,7 @@ sockets sid and peer sid to that contained in the ``@asoc sid`` and
 
 
 security_sctp_assoc_established()
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Called when a COOKIE ACK is received where it sets the connection's peer sid
 to that in ``@skb``::
 
-- 
2.35.1

