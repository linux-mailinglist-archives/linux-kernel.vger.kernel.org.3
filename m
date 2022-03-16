Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0E54DB7B9
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 19:02:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353759AbiCPSDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 14:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344751AbiCPSD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 14:03:29 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2067.outbound.protection.outlook.com [40.107.20.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CA2543396;
        Wed, 16 Mar 2022 11:02:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nFOhThSJ6xopegF8BgotiDVHqmUZ1jEUqRHUe3Ct0yj27+1zX0OLz091u3giq+DgWLIGG7N8lg3cwrAltSL9oT2xV7/XcwhEM7SyVIQdcEX1dQ0Xr1xX7UxALYcIP482AqAYQwTXoKUxm5R6q5Lkjv6KhPcKADXJkDFg4Uv04F1CSSZnb5wSi2oAf1AX3J8Ql6AwjeTQbqxLHaBwefhUhtg8t5gvyOElcyMHXukO9MYa7qqVQN8rQN8ZJdz2y+GYELb/LxUjAwpV1ZCj9Sh2huKkKOVaJk5FKDDK2xyUDiCWoAsfCQ5/H2n8QMVAwzJc6x7lpXx5LOY+M8IO12FruA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VviB9RUVBKQ6pvIgFAufGQ1c4ojd5ZKfGtkFEENrPGU=;
 b=GmYJNUD1/Ds/xuIleHDWgdae1Cl5VrpSgLNXYIuxu81KXTOXzhQrV9etVEh0gPHDYqMoNDa/PWQega2uHX/mqq/5pw0KYBH2r/gBXWCg3REI9SckzZ2WV+mrZ3kBGEBr2bmm+XAz0sB2h7W2i3TtkdOwjAO2nuT2u9/RiZ3qjbvKERGDxoWvLhWNELseoXB76qQiBhTWAz1m3RP037309at6Nv7q5Rx91jQQOqBBFQjHaSmKML2BtN/Lou0gHa6ogQjqn5OelLCRGJzBdqFbG3K5754DvRZqZkqmdMlZklmONmf9a1KydLj+iU+ud78HUvIf7hoRuYqfUqtuMlAEbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VviB9RUVBKQ6pvIgFAufGQ1c4ojd5ZKfGtkFEENrPGU=;
 b=MKc7a3yfRTsIeD+7zvBMYS1XB3G+/zr0TOcK0XnsMReA/dXtTnYtB+7uOYktszrfXCzMFMbosPiUBRd1gvU39SK77B/kf5uY+6Jl+2B2Qln9510gxxNrNbkxuF4VBumSnSgMol8TLaDpoVSjM7s9O8Xe32wayT1+5GtUZcXYWyw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR04MB2971.eurprd04.prod.outlook.com (2603:10a6:7:24::13) by
 AM0PR04MB4114.eurprd04.prod.outlook.com (2603:10a6:208:5f::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5081.15; Wed, 16 Mar 2022 18:02:11 +0000
Received: from HE1PR04MB2971.eurprd04.prod.outlook.com
 ([fe80::a813:c3ed:d1d3:5b03]) by HE1PR04MB2971.eurprd04.prod.outlook.com
 ([fe80::a813:c3ed:d1d3:5b03%7]) with mapi id 15.20.5081.015; Wed, 16 Mar 2022
 18:02:11 +0000
From:   meenakshi.aggarwal@nxp.com
To:     Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH v2 0/1] crypto: caam/rng: Add support for PRNG
Date:   Wed, 16 Mar 2022 19:01:48 +0100
Message-Id: <20220316180149.4070622-1-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220304114123.3762649-1-meenakshi.aggarwal@nxp.com>
References: <20220304114123.3762649-1-meenakshi.aggarwal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM4PR05CA0022.eurprd05.prod.outlook.com (2603:10a6:205::35)
 To HE1PR04MB2971.eurprd04.prod.outlook.com (2603:10a6:7:24::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07a36923-6cec-46d7-6824-08da07771749
X-MS-TrafficTypeDiagnostic: AM0PR04MB4114:EE_
X-Microsoft-Antispam-PRVS: <AM0PR04MB41140E2141AE161800187C498E119@AM0PR04MB4114.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2a+tTsh+iiBkT/rTaCSLJxy5PIh+FqVvwe5orUF7vBtavL2YIpvbcuHqdlqr4X2p6YcSkjMLVEUU6fXEHwm+pWo9p2vE4z0BhgpHu6DSXmSjg+Zs9+eg7GUysa4+u4atIYXIk0/xw0r9IWbsOQTw/laQjrSQ0viSL4Z3/Qx7xc8Fx5aduc0tjVyWU3XbrnFUv32wn4IccZwhy/AYIRsI42+g8dRrHttYTDsLVit78a3qLGHhwV2tQLzCM/K8PwreUZ8d8XgrO5ohUw0xvd2tVYARWiG7kPv6x/zJSgQWcgkESLKUv/cxyuzUs8s59k1Zt0wKO5Oerr+ApwkzKtxV9HX8pjbx+25zOA9sK9USAL4O5Bu5923/sf6OzIyToVZNuZpVOkZm1gz7oPeEL/+D1eDW6XVj3s5SyWvpqWLqQPRwCERd7v3rOww+vCGUNcO4P3QlY7FRTL4uI7qmN96Yltyyn0daag77QZh97OlMuY3piANBPI2mmQKwQ76hCwV6oE6hPsMy5Pd2AdwRujq1aLmfnvcq9C0n8Os24lo20Shz+JrMnTbGBJXbTO86KJMXV/pFgOYerB7XF6aL/6ZKn+verHO3DPnYxOAlOTExcq7iBk0jFw8PRqrxs0sqZJQc8kZ3pdh2Ak9AvG+dG1OgQecH8jUfBhqOHMqOw/Vy6cXAKoDMFkoofVXuGA7X1bVpjRr0axzoOERxjwYniVQ2EA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR04MB2971.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(83380400001)(66556008)(66476007)(66946007)(38100700002)(6486002)(508600001)(1076003)(6506007)(38350700002)(52116002)(2616005)(9686003)(6512007)(8676002)(4326008)(6666004)(26005)(186003)(8936002)(110136005)(2906002)(36756003)(86362001)(4744005)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ht1h2voG3zNCl2UiZN72P+YKbL1gTJcxbww6zcwXkAYW9ARVyG6mH2W4+EPA?=
 =?us-ascii?Q?esMhqxXK7slc7ljgaoHSaz5kZe/XTHZ97bP/9+0D/2vMPNfRV7PNu4tbH4MA?=
 =?us-ascii?Q?fe6thEX6GFJ3CtP5ucY6c/o9k/qe+3qseA48b5UySqEMCt1L+0f9QvfWn/CE?=
 =?us-ascii?Q?poljmHzu2IuTToueHp+5rzBqlpDiNdXCgkKTR+9M3COyHZwAp5o5XiKnjDL9?=
 =?us-ascii?Q?4TLqz/R720saxrP40uJzqO0rcQ05sB5d4W+kovgm1NXx3wWE84w06UY6eiNj?=
 =?us-ascii?Q?AwsBQzHfDqkfmzAs9gUFM4cruT55HrXCQG39bmefzgEpO5ESJKC66WJV6DI/?=
 =?us-ascii?Q?BEMYObQBtQxZmJU0NE7e4gU48XXqH+B5PmINYy7DRq3eojk5n0acoyyEmbcc?=
 =?us-ascii?Q?q9tA9NN7pUH31l1upUYjHBf1/y2EriSVn/SsEiw4rPUBmHHZVWf4QFF2iMFP?=
 =?us-ascii?Q?cMVgq28nmQEl5abIEVLv1yZlPzhC12zdBnm4z+mXHTYi6qUo+g4Hca50jRRO?=
 =?us-ascii?Q?rQSQOyhiO9ZPjIYuoQDvU22Spif41q0xQI4a3mVaFLl7W+KFuDbiSSAckVhB?=
 =?us-ascii?Q?lALzQJohzC+yMJYO9VXNAAELPeS8tWdzrM88ogv88RoL14JA8Tv+u/oU5L7r?=
 =?us-ascii?Q?EJHI5qj/9ZbuzlCmIMTpypqtOHJKs+H0CHqw3qP4/eSLxau9/IQA0iMcbGs/?=
 =?us-ascii?Q?fLDB8GzDt3xhuIHli4stwMrWCthbgWF+XGK5hjKrd7fWaugsqfPpL79tB8Z7?=
 =?us-ascii?Q?ORMQCrsxuDHGCRpT37dbuxtnE18YdrweULKpISNbWLq4KDTdWOXlb86N+Vt2?=
 =?us-ascii?Q?On7aOaezO6o7IKR2NHUd9KGb+mslOOfEeZDnMbgnW80zmSCdqkDiR+c7RRRu?=
 =?us-ascii?Q?ZCRSsvTFGW2JKK2K0OczCRTmaokgAzraiHNsTD/3ZGK+nk+5C1MWCZ/kCTQI?=
 =?us-ascii?Q?FnoPWrHmrZ9UbiOhj5V6NQEFUAtbcT+Fb6BSSgkVbDVzFgz148u1H3Dosue7?=
 =?us-ascii?Q?ufmRY4wz+PaagBVMdIZPl8lCAUk9whRrqAcoiiy9iFaB9ajKvG278yUymbCr?=
 =?us-ascii?Q?sgXgarXSjtYJambLpIKHU9p0GlhhKGmcwoH5iId07d5Cp7biDKpu0PoF6LO7?=
 =?us-ascii?Q?x3JCekUZVdAT9AIq2fh6Eaz3mT6RdAXRY8+wQqCUGoE1BjJn54wNxBAFSykG?=
 =?us-ascii?Q?UcS8W/d77mk6VFExUclEflstqqTk4IJCLa68jcVf+ZUC608kycabTq0G37PC?=
 =?us-ascii?Q?Mcp7OY7XR9ZSG9BtibIOskX4XNxs8+nBAZLEW2H0HY0g0kgWsO/4G20vQ/Lv?=
 =?us-ascii?Q?PsPm2NtgLt9tivMFDMQUSyIqktMtE0ZD1kTHWG2EZTK4RU3ltLn79ByVXL/r?=
 =?us-ascii?Q?tIxak40etxBscTXvONEXGFF1hxpyF98w/3zpsRWKyFP23f/4+FnzwXZDBTBr?=
 =?us-ascii?Q?GHV3cwXACx+/AnPzKM+jUItxQWuJ+XZZ3x0UE8FKZGJ4mIqB6LUv3w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07a36923-6cec-46d7-6824-08da07771749
X-MS-Exchange-CrossTenant-AuthSource: HE1PR04MB2971.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2022 18:02:10.9222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKUu34fDZ6DPxwy38WYdeyjfXFeeXT2fAFEa7K69TFRz2Ldted9bDai9TJtp9MubwCf7ZT8x9lJTf719NiDVFtWnOxag5g9dkx8GHS6kzk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB4114
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>

changes in v2:
	- rebase to latest master
        - fixed compile time warning reported by kernel test robot
	- fixed checkpatch warning
	- fixed "rejecting DMA map of vmalloc memory" issue while running
	  "ecdh-nist-p256" algorithm self-test. This test uses caam prng's
	  to generate random number for its key.

Meenakshi Aggarwal (1):
  crypto: caam/rng: Add support for PRNG

 drivers/crypto/caam/Kconfig    |   9 ++
 drivers/crypto/caam/Makefile   |   1 +
 drivers/crypto/caam/caamprng.c | 256 +++++++++++++++++++++++++++++++++
 drivers/crypto/caam/desc.h     |   1 +
 drivers/crypto/caam/intern.h   |  15 ++
 drivers/crypto/caam/jr.c       |   2 +
 6 files changed, 284 insertions(+)
 create mode 100644 drivers/crypto/caam/caamprng.c


base-commit: 56e337f2cf1326323844927a04e9dbce9a244835
-- 
2.25.1

