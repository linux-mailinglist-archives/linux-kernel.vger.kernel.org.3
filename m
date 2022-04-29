Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E70CA5144BC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356073AbiD2ItW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356074AbiD2ItD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:49:03 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2041.outbound.protection.outlook.com [40.107.22.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6FA62B1A9;
        Fri, 29 Apr 2022 01:45:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKYhB5reQFwh61oPAuWIIoFc36Sca86W2jIoFzpkp6H1he2oJYXUJnauminEQ9J6QEg2Z1FEkLrknqPQxxQtwnCVyH5Q+yhzqKhoGIDxJ7KXNiu6nJPVQ+1AYx1rvtax1KO7P47JITO+yXEB0OvZKciz6zpNatTKud5dhbyUH97E1J7ePYCqTxKhwsABCHrv8OXKre+YNEWIGRf+ClgRbPayzQr5BgEIMGOYXnDE0YWItbBjBjqDTKRgBuEK9cE6/e6F+Po2SrlLtaOxOUJw3iusw1BPH1FvJpIYwoRgsaPqGTAcH4j9kmqhg64NR2CIYBz5kLUtbMfJkbCXmcUL7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05pv0c6Az8XbT8BSnTwz+GeugGcKDs79RP7Vx+k7Cpw=;
 b=K+ZetzDyEd2Y70uUUomSkK104kh0KdVg8YZkTzm6r+4prraXhICbyXglhOzCHNVhA4vDm5zvFudLpnnNVq2IotY3wJfwdmHVzYsOrUM3WnHzPibT/5D3axVzQsQXlNe/f0CMFWoBUKgt2V7Mv9GQxNG69F3tJy+tGaD21JFWmTBSX1MFJfNk2RvDOqdTS/aV3j0GwEKJld70ztcqnyr9CYCcrxmd8dSi4tjIhNTOyILxnpqc2cifz0ZverUjUBivpQ8UZV0xs40gY2VHF6wUNkpwQRaJyTZrIlVzsq/2C4ZaIdb9Yv5jZJI7fNSgLvYvURwnP7bKl/mxKFEOSEfutQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05pv0c6Az8XbT8BSnTwz+GeugGcKDs79RP7Vx+k7Cpw=;
 b=Q1cxebCRXeSGK/J5x4n+x9JpyGghoOE6SXXZhNkEQUOJWLk5PrJbicVGFFs+2DH8XDogWJWZjKuY1d8I1oGs+JjSfbnu/vbZtug+VBm8N/CmJ13UpSAVaOr7d0tcj4ru7lOzYdpTfXz2AgMDvZNVbkGCAe+/3Bo4f/ISCvEErHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by VE1PR04MB7423.eurprd04.prod.outlook.com (2603:10a6:800:1a0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Fri, 29 Apr
 2022 08:45:41 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::9457:1995:964b:e94d]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::9457:1995:964b:e94d%8]) with mapi id 15.20.5164.025; Fri, 29 Apr 2022
 08:45:41 +0000
From:   meenakshi.aggarwal@nxp.com
To:     Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH v4 0/1] crypto: caam/rng: Add support for PRNG 
Date:   Fri, 29 Apr 2022 10:45:26 +0200
Message-Id: <20220429084527.2069402-1-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220420063808.1089283-1-meenakshi.aggarwal@nxp.com>
References: <20220420063808.1089283-1-meenakshi.aggarwal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0144.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::11) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 07c2f1ba-19eb-412a-a985-08da29bca3ba
X-MS-TrafficTypeDiagnostic: VE1PR04MB7423:EE_
X-Microsoft-Antispam-PRVS: <VE1PR04MB7423637436A932239E6D921A8EFC9@VE1PR04MB7423.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MnzDIHl3HenIiyWeUzvT+HRozMN3h0PoAJhVr6gHcBpHXSjyQenIpWoG5s9lmVap7cvLEwEkXJ9H0XtGbiny0rOO/C5nlpLh6rJ11kJOouCb8v6DQb4Fo/ea90TmCWAEw7FJ/52lWXdtrwUuXU3XtcUyb7fzeIEv1FV5oNDuws2YL6XrxEPrYbirvbhSV8IGjyv0REDeKJbqdQw98lYj+H5zYPAvNPMw1oKzrLugH+d/cm/6P2SGmbyjfy+MJJCqkLyQoCpujoVk8YX5yPKMmajxjMdSxzz4BazIHL38g97FCqKJBux453t8LrQjeAJHe1F05z49oKE+h/ayyamHb6D53tDXol2MsM0CPPCHOQb5x/MPfh/3POG8bucD/ea5Qwy8mLB/do33j0v5ye7vIY67AKsGTvD2hniGK6hH7OTu9AOAilFP51tCoVLm/hqLbkuppbrvH5bNKkwVO//COBFV9Tmgp5YfXp6akzRTf/o392xnYaoiCIsgjdh/o+f478GlGet2FOfsw0JoQMxrzka7/0Gz2hkUvFEqBPRGuVOeTsuX6k5VWDMwyO9wDAgg3VF8CSQ9fZ9OMROwannWFOQeJYSfHervQQ6CcT8bSO9EvRoXdCc4OhPaOTV4rCEfKk6D+MM6BswwCa4QdWhOMW7/S2c42izooMy8oWJdhDjIuPo1yjzi0NxFj4+FlpOEty3SB/rV+63D5JGstlfeSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66556008)(66476007)(66946007)(83380400001)(8676002)(4326008)(2616005)(110136005)(186003)(316002)(1076003)(4743002)(9686003)(6512007)(2906002)(26005)(6506007)(86362001)(6666004)(36756003)(52116002)(4744005)(5660300002)(6486002)(8936002)(508600001)(38100700002)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pUh5hjmkdHhiwg8A6OpaUDfLEiKR3Uy8ycBiObJ3xBQTIIQi0XZevZ4DuCo7?=
 =?us-ascii?Q?dvNNkKrLat05Pt2USz4Xl+dj0dMVZ4edYkAMXB/RSkLE88zvK66v5AHQOgIW?=
 =?us-ascii?Q?9glNDqLUA5VytNua/DlLq7gYJnifBIPRpMZ8soTCfWpGum8EPxN9ghe6ksi2?=
 =?us-ascii?Q?6sNeLDUtYM2vuVd5F9SQax7dHZYKm1cEHhZXM7zY2bY6gMNTm1hm20wDvDQw?=
 =?us-ascii?Q?Pl1euRHyVtH3bsgg0YV6lCdOANUg9LgZ7itFbaF4tc0cBW6xahKEY+XOtbCw?=
 =?us-ascii?Q?b9hO3dJzjxiVDmlSETf4K4UDWw/RQgUH0QoFQBf7JyG/dYPwdZvhNLk8s7jP?=
 =?us-ascii?Q?yqhU2v1eXAOLcHnXch6XLIW1vETCbhQ4pemd/9GMe3RziIaowj2w7Z89NOZn?=
 =?us-ascii?Q?AUU+IvHYiMhqBmPBjvpCcim5pYFMN0a1IV7tkwrFgYfKlvOLLZNQ5wO7yT3M?=
 =?us-ascii?Q?pabag96Quc4C0C3ni3RpzC9bHNK6wNJU96GfELHkyKaDDBO0AfBp7aCho0Mx?=
 =?us-ascii?Q?FIlUicNdxXghUcp8zhP/Mxh4wM6U+vjUF79qB9K1ah1HqQGVVc1eCKcp4e/A?=
 =?us-ascii?Q?seL1Vuf9utw+pBNnxnrDLx5xU8zHFs/V+krsIYsbu96E/5o672lcwPFPpXpW?=
 =?us-ascii?Q?BVnD5abuYG+JALG1YypyphPzpRHHcpaY9jC5XZUfe8ew6C4AwkKLCxSXSrKA?=
 =?us-ascii?Q?3Q7QCdv6WgNXG75VPt4yd2b6VMmE5cNgIiwrpFlYAKrrMgs4tvq6kwi31cm0?=
 =?us-ascii?Q?bNmsFqaEGWHY2fWgcPKZrfNRB295J52QzxcDf1nh4Qcr4//cxm05U1UgXell?=
 =?us-ascii?Q?aGcFpY9S08ROhMKawWDj5Nq0uIg43ECIaxxqKLQGdhsqAGGgagQiWKDy2mPM?=
 =?us-ascii?Q?JfiSEjReYfvpxVEgvxFgxC8FHCjb2mSBI+Ta5znetppop0E9pWqZI/rJoJU/?=
 =?us-ascii?Q?XqI54oLPPsWrUnw1d79Jh/ACbdj2mSTQDdHCt4B/aKlkvJi5hnaJixzUoQeb?=
 =?us-ascii?Q?JbtbAz+BiFimrWlJuLPX7pulVTXF3Z606vKR9u6uBhTs4PiN2EJrFWzvZs1u?=
 =?us-ascii?Q?SXLLIMSwXhq5dOptJ+m25dmTsk4nw6i93VlvMkgNtg9+IMQoJYt6O8TwmFjC?=
 =?us-ascii?Q?a/EpujTU1+TR5yIkI4H8aotzL0yzdjCQlJoePZt0QI50zt4KI0pyMnI7QbVT?=
 =?us-ascii?Q?MyQITQ9+RvQPoWnmpec4l0g0Z8akdLHbxPPK/XGa2nhLbC/z7qPXezowPPsx?=
 =?us-ascii?Q?D0HlS8P6C0IvR/He3tddQYHWAb5afWe3JQ8OhA9kJrsc1zN5N5Ivh/9f+AXr?=
 =?us-ascii?Q?kKJptlxWhfEHoWt1Ol8vJJJVBx3CcSW03ReASTGHF4NSuAzxrMi4rguICwWP?=
 =?us-ascii?Q?0H5tjD5EdWfNpuuLO3GkFyki1bCY9RsPstDNvGM+kJx9JeUPKv/t2wYnDPuj?=
 =?us-ascii?Q?EkAFm/OQUbLd2E+fYdDy9fC3EfW6TXOWCeTUgqPtR2IApeipK6fYnPal3bQg?=
 =?us-ascii?Q?fRIGgNXoLXUrqmAbwyrJsRCApGk3JnKOcIDYP2x8E6uWtPtd9Wabaf1P/F1Z?=
 =?us-ascii?Q?0XgkKKRKHGzIxrWKxpd1y36uK9LZpb5prQt/ssWijpHJmWn3nr/LtUDuDTIS?=
 =?us-ascii?Q?jIi3EDgKozeMIlAgxOrudpGNlQbuf7G29h4fGIcQS/0ghvRSDGBuU0LA8vf1?=
 =?us-ascii?Q?7kDENJo970j4mL1Ej92AR1TAIefehbKDslsMfFcYGaacRorvMD/buIdg1yHp?=
 =?us-ascii?Q?WgRXz24Tn+cCZb+aRjxST/afUibFKqg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07c2f1ba-19eb-412a-a985-08da29bca3ba
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 08:45:41.0263
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: re55IN135rFkbRvTIPq7sxpcbGl/kAd20e6QVwXV5yl1h9wtxHj6U/JIYtUMej7BdaAtazeu7GYI0yD3J5xb2CsXy2Spv88jt6QycqnvwIs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7423
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>

changes in v4:
	- rebase to latest master
	- incorporated review comments

Meenakshi Aggarwal (1):
  crypto: caam/rng: Add support for PRNG

 drivers/crypto/caam/Kconfig    |   8 ++
 drivers/crypto/caam/Makefile   |   1 +
 drivers/crypto/caam/caamprng.c | 234 +++++++++++++++++++++++++++++++++
 drivers/crypto/caam/intern.h   |  15 +++
 drivers/crypto/caam/jr.c       |   3 +-
 5 files changed, 260 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/caam/caamprng.c


base-commit: 38d741cb70b30741c0e802cbed7bd9cf4fd15fa4
-- 
2.25.1

