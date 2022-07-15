Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373025759BE
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 05:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241173AbiGODBS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 23:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiGODBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 23:01:14 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80070.outbound.protection.outlook.com [40.107.8.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF4548C8D;
        Thu, 14 Jul 2022 20:01:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8kMs8qCvUtV7oGI2cxX61WsuQuQhg21nZ3abGIbIyF1itup9aUARl/kHbCYN4rSHiqTZNSGkNQk+loSLuzHgMeFG7D3/5uozszPSZqrPlVSacWqMgBXvWfGK/VHdkWK5SF7vYAuOtjKac9LxTPFWo8KGQ0s2x2NbT+Bs6WnM+V5SWWbbddOt2rnVAhEoNN7Viu04w2rvN6zRlb5jtm86p4E8xsaW/uoLd1uBxxK/er365tjgC8kMksvuum1T0pOwxBRsVpLx9P2PvC4GQVMFr3cyDVKSF8gep/6fUXl2CAhC7rdfyw/YO/7XiAkcsHvCpRyWfqmOmrkKJhVdWwUCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bpphCbnvSGF05V8uwar8pb0AF+a94Tc/SJLKRUeM7+c=;
 b=R0zu/QyHT03hdBjij5u6d/tLOMwqdpbIk5u6SbSmTDOwmKFBxNzcjdgkLxH6U/XZVeq9hVutga13lBNeCxqJaztkB23ZqwD8vMqzlMCqPY88+2uwBKea0TV8jx0+9VSLqZSieNBDN3ef2neS6s5sH49pOh/eLtiOomIMkGDqErf6UqTFJvG/y6ZFpIvbVR/NRpnPy65JkZU//D+MHwabWewJvk2v3Jh+tmNqaoftv3LU5etZGwoIaacJ1ydtbr2Ns8P2MvnGpnGFZ+Qg3d9w8UkXhH1mxqOCrplxRXpl4U4eXPBmsZkU2t2BiZBQ05AftYsqKYofX9w1gmFIsO6Nmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bpphCbnvSGF05V8uwar8pb0AF+a94Tc/SJLKRUeM7+c=;
 b=ErNc6SqlHNRiaFGvFHAKs7MTyavgMsgbUPqaAA7pxHgsnkjzyerluDZsRijHeTzvtxy5ra/WIJPdQI3izpQmVWweq2N/8GUtbwCP4qAPuMQevr+LKYmCGMOLJn0K5piGEZsA3PkytVh7BBlkXTpCE1OtA5YX5/GEwd7RSb+k3uU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by VE1PR04MB6477.eurprd04.prod.outlook.com (2603:10a6:803:11e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 03:01:09 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3cec:d61:3836:2826]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3cec:d61:3836:2826%5]) with mapi id 15.20.5438.017; Fri, 15 Jul 2022
 03:01:09 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org, michael@walle.cc
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH 0/2] fsl_lpuart: fix the bugs in received break signal count and send break signal
Date:   Fri, 15 Jul 2022 10:59:42 +0800
Message-Id: <20220715025944.11076-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0163.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::19) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 272df67b-3bb6-4840-9534-08da660e4493
X-MS-TrafficTypeDiagnostic: VE1PR04MB6477:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MhPrOlCrI7CJop3Fx/5YH85OBCLhBG9m3BTEKMUo/65+DGj0yt+Djhybqn/OxkeIeUy1sFie3zyfbIBd3YWrl/AIPNw7IaMKaM6WkoBLnQl+HvJcw0d/NsPlLGGYOZhPZryPzxi8d/gMW13BUZlzyE4AiruSnisG9duanEs5f86Swj1DHLazJVmVPbHqDYUr5tffDCYF2U4bCtgLdOgXmIEh9UtSK9LyZ8qXjEhmsy4mC29zeoNoLDam5bfSeW1wBP/HigijkxSRyG1Fjn9Ck1/Pna1/qFYE50vu1LywZbDrxggiIVaiAZSH0xNKUtVtzhwrwxlKKo4HxaWgbe3D74Zz58iSgN8OUG+O6RRghqpIBaeGn3sRgBCkDkDfE/46N7qxiyQKkDZGFrCHqbqAKLMx9QTgID4mZIdMdx6JpWx3AbAy1jLAmf9r1/DqwATAvlsnrhZx9Eb31gJsOR6frGywvTHQIvA09W3cEENEGCsDx6GgMgfVp+7R/HeBfJnI9sRFX+BA/ZmcYThMMog29SWqRlNJLW6qLxaKzcaucT1loCUX8YullBHbun7InrIz4ytJ7kNqZxNmeGW9v/ezIrZh9KeNyqujWr0BTVSva0+kLrE4iUHSlMF6DwAzlAsB/ns3mjT4GuJWPNWk/U/hXdvvtX3zWTLmXfguhGI76cnloIPox0WcFLyVGtWGtgi0JTP2qzZ/hvJs7PXIqfDF17Rt1BNxhyId84UuSWlupLxj2JsYs67GUbxIQDhFxua0aYxH5C4EnbH5eKV/eV7xG1nrAM+UvQQY9djq/SBTwDT0I9CL1wSoTcAfBtiHroqL
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(8676002)(66946007)(66556008)(4326008)(26005)(5660300002)(38100700002)(83380400001)(1076003)(38350700002)(2906002)(2616005)(41300700001)(66476007)(6666004)(186003)(316002)(36756003)(52116002)(44832011)(6512007)(478600001)(8936002)(6486002)(86362001)(6506007)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jbEz5gkMOBd8W8jiW6tdG/01mvl+HrLjDvIDihSkLcqNyIbXKhAcFbBC5e+k?=
 =?us-ascii?Q?3BR3QshdhMYWZ9ECPOeG/Rw3DUlxQMVEkzg0CMBV6/Z3lvW5GFnsOrTnczZa?=
 =?us-ascii?Q?rcK/EN8QdJUD5K1pmdWyg3qaTUwhYPBuId8Q9OVUQCdiSjoDoDL1l6KQwesJ?=
 =?us-ascii?Q?nWyc3dwK7SspzlOLBpZ+p9mHTIPhKLK+Yijro3UJXC99+wQT9t+P2SB35k3O?=
 =?us-ascii?Q?ltqOglF2cioOPdsB5a4n+4Bf7mW2G1ezVPDoOlmN3+TH0x0GhB3aC2OKEmNf?=
 =?us-ascii?Q?/eAo2yCqYzoy8YP8FTLZmB/yTb4KDX4Pnw3zexfiICAkCGH0LlUYk0fdoisk?=
 =?us-ascii?Q?60p672Ru/Alq039E8tuoL8OaTaBRCnCpZ2RdndseEMwmyDVhN4d1cIte5esA?=
 =?us-ascii?Q?YHzoHmcp0+fw02szQVHv4nq3FPMZMl2K7vVgYoJh/yZd1EfNnHsTekd9Dixo?=
 =?us-ascii?Q?UN/03BkD7PnmhpyHbDf04a+V7Lj6bznExqkWVA7ItjqgjAKu+5MTs3uscTJ/?=
 =?us-ascii?Q?6zB7Ec5u4W0mxbUEDnOrzAWORN67mpGFHdHziVuDCCeXNpNU8QwPMJjFOef1?=
 =?us-ascii?Q?tqBtgJqFOj+fDd9VA/ctIUu6qSVuvQA+lep7lVSaUEIJG5tsCJpCkocTMmI8?=
 =?us-ascii?Q?4DzM4kor5fcZ1MJ2ZA3sV2mvkeo7hHta+VrGmHwrd7qf4iCroBzkXh0tGaJa?=
 =?us-ascii?Q?ppsEDoXBElbNLB96MW3I9sbV3v7YuXDRtID4UEvWkQ4/LhfN0Kdnnyq9fnlT?=
 =?us-ascii?Q?NgLIDBZ6YFiG0ikNqWST+gDvR5mzvKff7sVfNLaqZJCxxcYgFP5CWNZ/2PRm?=
 =?us-ascii?Q?f4J4tw0LADtK8aNi4g/nqcLcf/4/QTJdICCGgqmlzToa5KpijE/KfsSBRDP/?=
 =?us-ascii?Q?UFoyk/LQeZ3OEgXbTnyRuUVZtbblKBXJIrRJ2fLidbhWLXRRlX6Tj6HwZBpj?=
 =?us-ascii?Q?j/vKxifoHQPq0wFetIYIa0mbUVzaUsRCceemYRSSga09BBqyVYlITlg5pCBO?=
 =?us-ascii?Q?Onr6Vu3PGq9W+2El5Z9hPY9DwryiCKTzyEVF3qfuMWHdtP5nWVRSx3w7gN4W?=
 =?us-ascii?Q?OavdaD/h9Bjf5YCwnl1KtszndJ1KRTitF8FpwrCRxPmui82sku+VlFypcRHI?=
 =?us-ascii?Q?pjjpGVGwDbLNnA5jBqYpgkoouAj3pYLm0qYyOBd6mBh+nUnsSuVvpqyc63tu?=
 =?us-ascii?Q?DMDQNdY/BhLO/s9hWITEh+v+k2pkjLAmnHh5G4L6E3XZ1VyXz2H40fD6UvY8?=
 =?us-ascii?Q?XNxF18kH5xASwnc4tZDf4Gm7UXkwFz2MLyD8JTbBuKHqrAHODH6hV+Jb1Q20?=
 =?us-ascii?Q?Qjwz8CEMzQUfgRZy33PaiVsCZQ7YpQ/XBOCO24GmBRjANL8XdrkPuiGhLola?=
 =?us-ascii?Q?piz+qPLS4RWpyhf/bpT+FZY9L1RmqyU6l36wV5n0C1JmJgVP2UDl0RDyROlK?=
 =?us-ascii?Q?6PaYF2fCfSi3y22zAgapbILEXBa5l/eTvRECsUoNyChHC5NvAn41lTtgOyU9?=
 =?us-ascii?Q?RoRe2dhFHXsB52cplxzfZ3gSyCSCpgnNHOAQaVACEehVREAcyyNS/aPOo+2Q?=
 =?us-ascii?Q?wdRuNuQtivgGi/ULhpF6EfGiIuOTr3YT53lIg06r?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 272df67b-3bb6-4840-9534-08da660e4493
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 03:01:09.5882
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bNy+pABiiHxvTQHY6sJXtACalPwYcdr87q/O+GeLB9OP/ZepKqBWcyyDms8b7/zEjHXbFuNUFXFr2iOcRW+d1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6477
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fix some issues in the received break characters counts and send
break character in the lpuart driver.

Sherry Sun (2):
  tty: serial: fsl_lpuart: correct the count of break characters
  tty: serial: fsl_lpuart: writing a 1 and then a 0 to trigger a break
    character

 drivers/tty/serial/fsl_lpuart.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

-- 
2.17.1

