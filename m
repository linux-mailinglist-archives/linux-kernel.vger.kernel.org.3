Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2EE514884
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 13:48:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350699AbiD2Lvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 07:51:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235786AbiD2Lvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 07:51:47 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94027B3C52;
        Fri, 29 Apr 2022 04:48:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hv6ubDbSWrbIF9/mgRhRmz4fxIptP5Tk0D5jVf4TuJHhCju06DTErTgfG/lM7m6Cv7PgXjidR5LLsUr3HJ/VY09eFDw3/2ClsOPLEKPN+0yzIwPeBjlJBdZk/LzHbY0G9qspYWxpnVrDCa60gcnrT7M/Uek9xaE4G91fZAdm+ycoaLWNahOtLeX1xmlAPxtNYcStjpzYoNh0V/Da/qjJYRmtFGD0gWYChQumlj5syp0pcCOrkUnPgsa6DhgUy1Mj4aqasPB/4uGXxxUFma6CwO6bZOClGrj79FWeccgru0ZloB63HvUpA6OXxF4WPSbt0HoJpyqxzmG7HkPTAdhLMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/w7ZynustWfBfi/E/z7BvhmuDhsvcl+0kNnHtnvlhbw=;
 b=iqWCoIPVdJhr3L+GazJAtxwCWwRFqtZJFUMJCkgBhPLYECn5WNzESHKRYcde930nCvlxLAcpAFtHNHqZ7/dpU3hiRkAx8dCUJ+0NIxHQD5npH2o9upbDSMAbhtIWDRydkUcId2E7VsmpOnXAXcT8o6q4zekhwJTzUjDbei75u3bwn1jLSm5mkFNU0CWEVO20y0X62KmbDKhVWLFBQRhcPYLF7YC94TWryX2jEtg4zpR0wQDRLpkyexWYMts7EhtqJagt+HCSg16andzfdeUUSTWOFIY/ikRXEHwyxRgjcF7YeiLSDVPViQY2I6+aECquWYl+MZ2RAdfnp6fAVqf2lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/w7ZynustWfBfi/E/z7BvhmuDhsvcl+0kNnHtnvlhbw=;
 b=DbtUfNbFrFHwJZtnBe/RVf1gS8fS8+dEdb+MZV9YD1j2t+srJHklmGbk/DwZpJUbUNL7ZySxajau0/7nV89/KbYJesCKFzu5WMwZ6IcyOECH8MODE+fSkv8z/Ykca6P7sSuRlXh3y6byZXFDt1T6y+LEqnkbnV4zAqezJP5WcnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com (2603:10a6:10:314::7)
 by VE1PR04MB7358.eurprd04.prod.outlook.com (2603:10a6:800:1a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Fri, 29 Apr
 2022 11:48:27 +0000
Received: from DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::9457:1995:964b:e94d]) by DU0PR04MB9563.eurprd04.prod.outlook.com
 ([fe80::9457:1995:964b:e94d%8]) with mapi id 15.20.5164.025; Fri, 29 Apr 2022
 11:48:27 +0000
From:   meenakshi.aggarwal@nxp.com
To:     Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH v5 0/1] crypto: caam/rng: Add support for PRNG 
Date:   Fri, 29 Apr 2022 13:48:07 +0200
Message-Id: <20220429114808.147108-1-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429084527.2069402-1-meenakshi.aggarwal@nxp.com>
References: <20220429084527.2069402-1-meenakshi.aggarwal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P191CA0015.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:21a::20) To DU0PR04MB9563.eurprd04.prod.outlook.com
 (2603:10a6:10:314::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02d4a3a7-ca61-4b71-a8e5-08da29d62c2b
X-MS-TrafficTypeDiagnostic: VE1PR04MB7358:EE_
X-Microsoft-Antispam-PRVS: <VE1PR04MB73582515BB2147E3CC8A7AF98EFC9@VE1PR04MB7358.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i7m4/pVwE5inZktt6bysaY5sCcJsZRqeV2qDFiS7bR2RTI4HNmEVkbIInNKE51/fWkqdwaIWFzxO1S4Ki2vjpzorseFv8cMCzaeW4uFr3Kkddo7ROyurHIZrlxDyJe3QfUneRu1VglppSn4m4g6CoG0HvO1I+2WC+Ox96/lC47Z/GpYxde5ADl9FCkiFCMM6W08WMuC9/WhlJhUeZKBSXUxuErjxC9vV2+mcHsfg5og1I9k9e5100tiujE6y8ls8ZPwFB7cPhh2AheXsYBW/cH9BKq4ISwY9A2HFnLjnO38rv2cgstkOq9I01H/hw75+pSBcV5I3Xyzx6rrU4De1VSP57FkPPrZ3X7PppM9uiVwjSs1qM0+IuechcO4Tg3skC7jR519mQCjSSysu1dpAe6WnPGSJzuJicmeD/EQDYlaDvnhrJhc9ZcsLD6LWj9eOE/Jp8ROHnmTxBnvFAJA83TLusb+GXYB3EiWlp0SA6F/XJRPfGq5cB0SZKy5QuP7YHgY1YyirgFqhxQrlfSL+xuy9RisyXn+oOSlEnmfEy3jbv8LLq/atlZDTELQUQwbMD1/WG6ExroRtFH6kvbWOgFlPkRmfNWuFyXa506SNvSP4IVXgRKv6rAo4EAiB2U1T0YZXZ9wvEcDq3TSVc488FSeSS0KyTPuiyXeYogDOmo/kez8G8Kfb01HbhZbVXRahiCZj8kUirOyhsrKUYykd8Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9563.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(86362001)(110136005)(2616005)(83380400001)(508600001)(186003)(1076003)(316002)(66946007)(8676002)(4326008)(6486002)(2906002)(66556008)(6666004)(66476007)(38350700002)(38100700002)(36756003)(4743002)(52116002)(9686003)(26005)(6512007)(8936002)(5660300002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?R5pBDlyb1sjWNP9z19UX3gnvAcV/jR4OOK8RqeNTxQpqo+kBQIo/+33rVnqU?=
 =?us-ascii?Q?vNyIGqoIE56wMm8LYMT33qr71dOfMECSIYYOAZbN/154PZDtx+yYqIwAqizH?=
 =?us-ascii?Q?4d4RFpBbzh9S0qRObHhlHC/qVHM3hKI9LDs7x4/jy8RiGLqCxt4JoK+rd9Es?=
 =?us-ascii?Q?YlhLhjhzoSBfgLS1wkuViBHl15IEoNoOGikLSkwzgfCdp0Lh30Vn1+zSk8gT?=
 =?us-ascii?Q?pndttejhA1vftU/Kthz5J066NQPhKotk1BGBm5QMf1QgNx5tF23a6zyzk5Bq?=
 =?us-ascii?Q?N18qgqkLd/SDkVk82IAN5reh9D8qrJO9IKIxbEXq1+okb3qcO8dqLVB8A4bp?=
 =?us-ascii?Q?NGv4vay3VsruYbXf4awdBkYo1Exbqk8AQZWvUwlxRve02gbu1/eAuwb0anhW?=
 =?us-ascii?Q?qZmnCxZWWGX/O8n3vYxPJlE2aFRBJWO25iG+7KFz0THNl4QNmMVWJcg480b7?=
 =?us-ascii?Q?DJbvqezsDfj5Eh0oRHL2/g+yie/HHqXqBg7F5nqQARxUO4JNCe1/jKMNKdAI?=
 =?us-ascii?Q?ItmbOgQw8ZZTYrE6q2FN/L4ALb9COGok15x+S0bJQC6zGsmF/yPthnrTvj62?=
 =?us-ascii?Q?fVLro3Dq6Pgy5OXXSvkvy1pIHvhMu3RH+2FGlkcwLcmtqUta36vt4ufeVJ5R?=
 =?us-ascii?Q?PQ+GxWZOKQW5HQs/NE6zHAz0KkI0I48gts75TvqeLmh8BTRpKYxV80C8xyTy?=
 =?us-ascii?Q?1VR+0zTPO/cVu4au7eEBw5NGecTub7QriTfxBoLu+nxRsQ3P0T5FEaM4r9Wo?=
 =?us-ascii?Q?J2ddV2KLOlT41tCmMV74uZdWnIigLblQ9EZl4c2rnvc/D0VEuep1N9TTRzKX?=
 =?us-ascii?Q?w5uKVcanxZDt56pESmQxy1oVoUS48nfqYx180NMej6HirKrC5ao+uBv4w2RC?=
 =?us-ascii?Q?d1ukhGGbLCrdShpCFb3NWijRgYFFM3yv87E9fMxyUZ0yLsEcFmdumGs+AhDI?=
 =?us-ascii?Q?gLXb/JjuRoa02xo8rgqvRPlTxKw6wdetlEvPf+BEBDTTh7xJCwAU++ZNX3/l?=
 =?us-ascii?Q?zq8FP5lq7VdgdL0XBR+nk3FkNrCmaLXp8DEshDh+DOqjuS9xfi0viGD8Tjpg?=
 =?us-ascii?Q?djoDx+vPcg6+Ibm4p9m4vfZwXyZ9GZDpcSRYDYpcY+050cEd7DiRDYq5yZmn?=
 =?us-ascii?Q?sfXokqvWtfSbLgklAJUw6UvR6fS+4wBp6KVTcPFz2OBD9I3UmD0G4aZXn4T8?=
 =?us-ascii?Q?my1OTf2ItOA+jmYM1FD8Wh0lzsgdaPeoLJLg6gpoxUu5wIJi7JhpgnX2rzbw?=
 =?us-ascii?Q?MFvV+bGB9oCr6I0DHLO9KzvsPastI/UDihm0qy3HD60BeFCaMTJNkpgnhNjw?=
 =?us-ascii?Q?nD79RSb+KMAdxpXaV0rkjDUo10Mk6fyO45FhCCJSfvLgEYRal425H4nq99dK?=
 =?us-ascii?Q?0J+2MzsnqNJw4LcF9GDr9el3RkrSLiauCmEVfeNxhCPNS2EXrX77ivMFgWyl?=
 =?us-ascii?Q?V0PXrCyHhG/GI4pNbEID8nlnFzfwTb4xpr1hLdUMOLwv3CIwS6QPc55Z8nEq?=
 =?us-ascii?Q?5KbeKBPu+MH8TI/eXFAq86nZDj3xDSQBsvgRbzzcR3VpNzPshh0yGFBviG+d?=
 =?us-ascii?Q?kUUkW+oyUnhVKlgXG+EiDCuyd0bzaW3jbKTRT6rSEls+A6DJSq4R2rOUtlJN?=
 =?us-ascii?Q?avboOD2tXxibOFkBMZ/6BwCT193N0uKKWmX8gE/6q4ehPyY/V0FJaeFImwtC?=
 =?us-ascii?Q?txWdjB1Jb2tpJsklosE6eceeFG2Y4SY8MNAMX5iYnyLqp3GS7OsEtFkI4QAA?=
 =?us-ascii?Q?yuccadP0e0cLFZmKR7Y94J3hhPUXpyo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d4a3a7-ca61-4b71-a8e5-08da29d62c2b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9563.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 11:48:26.9813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LlJPvjs8dQ3Ay4mZulkxI/U4xOHY+Br1fB9lD/LZFDxWKevJyKRA5o8B8BZgorOWX54QGRmri8fSUxG1167oV8ibx9dG6GwXNv/Uew9FrMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB7358
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

changes in v5:
	- incorporated review comments

Meenakshi Aggarwal (1):
  crypto: caam/rng: Add support for PRNG

 drivers/crypto/caam/Kconfig    |   8 ++
 drivers/crypto/caam/Makefile   |   1 +
 drivers/crypto/caam/caamprng.c | 235 +++++++++++++++++++++++++++++++++
 drivers/crypto/caam/intern.h   |  15 +++
 drivers/crypto/caam/jr.c       |   3 +-
 5 files changed, 261 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/caam/caamprng.c


base-commit: 38d741cb70b30741c0e802cbed7bd9cf4fd15fa4
-- 
2.25.1

