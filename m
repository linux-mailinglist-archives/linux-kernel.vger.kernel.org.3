Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF25508149
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 08:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350614AbiDTGlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 02:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348640AbiDTGlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 02:41:08 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60071.outbound.protection.outlook.com [40.107.6.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377623466B;
        Tue, 19 Apr 2022 23:38:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XnDejtpuC8h/MMBLAaTXrw8V0JdQvavC9dk8C5NGLM7as2Hc9S/uLDPeMg6ZKNxw2evZJn9kkpNCCCOoNNwu9DshHL2B6Ne4iwLy3RvDJVHeVKIgycro8GYicNqOEjDQOnTwJwN4JgyhppR5xdWTYRqsvZKFFfy8e40faXxmp6NrikP3UuYwb95xJRQe8VWEF7DdPn1gh44NEkjNPBFXpOm/YGl/3AwR5BG/WkobBOx/clsefz4IfDYlS/p8C9GenDyBWzZpG6w0CvlWTOIzulaFJZIHonrM90SbYX+gxheDNhsFBWdB+3V1IVXIMVK5A5Sv4t1g9t/JisU0l+SC+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wJc/iPThTvwvqDm9XpiQwvfPM0pazdsqOmjWXEVeSs=;
 b=YP7BN1w5HTrwWnqbhQe9z7w3KzGyvnK2Fdi7qJf9m8jMGiqfbLUn1SBhURg/6UkhzPq3sAe6cAmloILsWnTAqJpr2FCq8OFO+uaxJZKhP6wjxQJBJtP+W6XT+aPmg9lHp9n9gkU8FAgd71Q05BBobmi+uEOfwNjnaGEGDmEjDk+OBjtenpx3v2NYu2UjUms+/C0FJWqqGbIXHbBd2sUgFmfZefd2+L0AftpyDu1nhNqBUpB6JkiNKlIcTSgg/YeANFWUtxooopW9Ux1zORl44ke/69mVyWcRUPRww6dHEC2g0auqiO13GjAuQXjiMm43pEdq6g5hUslyNf0rR9aXWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wJc/iPThTvwvqDm9XpiQwvfPM0pazdsqOmjWXEVeSs=;
 b=PhVOZDlIpo38siFYs4JH1G9OR39BT9z/m5EIHnfFoly4NBc+FxAN9TrgIEZUYf9A0ZJlXaxv820vFFBMxCILHt8cDuy0KqFf9KPFamkkQemx7BI+rx3tUdAGgLUfbYiEY7QKiulD0s0dC5jTW/gy0TXgo9AwTfqpSIFyiXyzBXk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from HE1PR04MB2971.eurprd04.prod.outlook.com (2603:10a6:7:24::13) by
 AS8PR04MB7990.eurprd04.prod.outlook.com (2603:10a6:20b:2a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Wed, 20 Apr
 2022 06:38:20 +0000
Received: from HE1PR04MB2971.eurprd04.prod.outlook.com
 ([fe80::5d82:9d6e:68a0:fd8]) by HE1PR04MB2971.eurprd04.prod.outlook.com
 ([fe80::5d82:9d6e:68a0:fd8%3]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 06:38:20 +0000
From:   meenakshi.aggarwal@nxp.com
To:     Horia Geanta <horia.geanta@nxp.com>,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        Varun Sethi <V.Sethi@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>
Subject: [PATCH v3 0/1] crypto: caam/rng: Add support for PRNG
Date:   Wed, 20 Apr 2022 08:38:07 +0200
Message-Id: <20220420063808.1089283-1-meenakshi.aggarwal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220304114123.3762649-1-meenakshi.aggarwal@nxp.com>
References: <20220304114123.3762649-1-meenakshi.aggarwal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR06CA0097.eurprd06.prod.outlook.com
 (2603:10a6:208:fa::38) To HE1PR04MB2971.eurprd04.prod.outlook.com
 (2603:10a6:7:24::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2a09a88-af57-40b1-0049-08da22985c2e
X-MS-TrafficTypeDiagnostic: AS8PR04MB7990:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB79904467608552A118797AD68EF59@AS8PR04MB7990.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: szcDyfardu0bU1bl/UJPuTFifYSAXOnOD5z8bCwYwcJDpja8gMQbRvlvYytM9qQzWh/5JngTkH/NERalDb/BHewK1Vu4sjbKkpp5itGnmaQAqHgxGmBmzvYyy3LpKfiM8AExOUh7EAwiIy7bnKw3Y3IepR10vG2gEKb4GEp/XERQ5YPmaRd1VP6dQwhPzlroSel7LPoiaq5ISadnMMcvJoPHvcw7fVDaLabYcXA8dXEwbNPgA7nw0VmfbKsz2xU/CrDgVxjeAQfM0QCozZDIZtfJ4x5s815xNcbEYGJzc6pUcccLeTeIREk/otmECYaCfSErUAjG1BHY6/oKAuIkM3Vx2jLoXsn0sxliPEfDiYHZ5Kbj1/2D/iwoXhLPKhfzI5XQpC1RxpR1cxuVbYFixkt0UTJq4zdkIEINnKJoI+n5xvk/kdb96iimKAiGzTDgHr8WAmdAkOwte7a9uhCp6SN4VjAbX8gBPbfWhYFqGxZ6vtkgO13MsfPNjXGnC5FVd6+L2+HzBuGKDyR9JCF04y1fdRzL99zTbQ5zruptULPDb6IscgIhedkQwE6XLbVnGelBLEK7eK/NKhLaK/XUg3q92ow7Ee+JcLjb/eKSMyxFBFswjTPfBiAwjK5pzMulDGcyHUHfWXdKq1r+mg/odPiBm40d9Hk8CVtr/OhwZxQi6t9GQgusU4CBA3QVRobzNP3IG7aizZ0MHNicIbBzfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR04MB2971.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(6486002)(6512007)(6666004)(508600001)(8936002)(2616005)(86362001)(8676002)(83380400001)(66476007)(26005)(186003)(1076003)(66556008)(9686003)(66946007)(5660300002)(6506007)(2906002)(52116002)(38100700002)(4744005)(110136005)(36756003)(316002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yFCQSVqDqsGe2KHzP2rLrPkaTzXH7JFkROLtKRHE5kzRrSQH4xHzrKsd+pmh?=
 =?us-ascii?Q?9Rs6yifRjhO5P9430HfRO9SGGMh5A15oqwpt0IaEeWgDzIGjcGrI5d4Jt2/m?=
 =?us-ascii?Q?E+oGVp2kT5FwOQXVTymuHlqTX/mcCUCZdGbV+ZPNntgUNO8JSgb/nHBUv4w4?=
 =?us-ascii?Q?1GSpIOLWEcuDkkgeSqBJVlVZCBN9Pc/a2W6wq6YKEuHMVkZkFZ9/I1LlIiJf?=
 =?us-ascii?Q?HKjHUSsPueYKZ6FBbNfS+wTG5U5QTid/OGo1K6xYfKSLRdjfNnLG8wSVjGq1?=
 =?us-ascii?Q?mrSZwLqNqb/OwJWCwgFefYlgQ1YFjd2s9fpRU1l4DMtsRe90z6Uwzxpkx8LM?=
 =?us-ascii?Q?+XL3MLouOCEf57gznvPukAug/9ZmQmwBa5/SgdjFD47cqpjIfplsT2EbVK1S?=
 =?us-ascii?Q?aHVytxjQBFjh1F4eC1tYrjavCvNMfZokTSpth61SqDdPFrLEUt4dIy0USHIF?=
 =?us-ascii?Q?NWq2HcyIXV2KwcDTDyppQVx46yQu+UePnOzZEK+FjlCV56d+nE38qt8ohkSi?=
 =?us-ascii?Q?8XtxmHWZzVzcYcGBZCV3FaCXGdHFNp5Nz6Hm3gtF0+326AYt0/qXdNeggWB/?=
 =?us-ascii?Q?T4W2q9b8pZ9jEPrDgRZejpy6lqtWIS6dDPhUNY2C6f1QC6aB7A8OcRjiUG2q?=
 =?us-ascii?Q?LjUQrCY6hD4hzSR6u4vffg/cjoKi+r1/I/3i9j9q2vEYyPSyZ7jpT1AYVsdb?=
 =?us-ascii?Q?3Foc2vNYWaNXq3LBEwLgfxIywF99cy5BsQsMgnQSQ6/P4nZjx328FkHrkQ2o?=
 =?us-ascii?Q?BBNWkPXEz3NzRT7swAGc1hiVnDQUqna51AxTlMrEETUpnrHDu0NqZo9HrrB8?=
 =?us-ascii?Q?uwCAgD2kYkqQL0GywJCsBuCLKe07np7fs6y8F/1HzYC7kbuARup0j8c54/YE?=
 =?us-ascii?Q?ER09yYCzJ0QF8RTPk+9ce2Zz1K/42Pb9urijKJ75jS0KyT4CvWiUjPPEkWz8?=
 =?us-ascii?Q?s4Mpa6vlB8DhOmCyfIBzo29TkMU59YIVCrHGErxLCTmolTvAGX94p7zn1MBk?=
 =?us-ascii?Q?B7C1oIGXgJoN2IavZEXuDvbdM5vrXRBpf7AE5jKmQUtjGiWdblGY4F4sOxfh?=
 =?us-ascii?Q?tnAO0OwYw4hhRbrmpMpnv/LA0Q7bzLA58OfvhZb/nGBAdHKi8qUBq2tqHNWy?=
 =?us-ascii?Q?VvlIIWgl2CNXALvmz4FTLF4w/kdY2Q2zRHGvNp6tfCgnbfL0tOwhIYi1Z/z5?=
 =?us-ascii?Q?wYBFrKLbAfBd4jV1gkFQbxxuf9QkMPy+KC/bTLR6SVBvAB4XhfpRo/Uc9bmC?=
 =?us-ascii?Q?u8JOm5R3kY7g1HNIo3l5KH1lUKZfloVBel4+2j1O6PIEjO19tGWLALEKmYEr?=
 =?us-ascii?Q?uqka+8sKTPiYWXkScQ0Fkz5brBNO3XubAq4l7WIAKjju92wIXHg7d+X+CoW/?=
 =?us-ascii?Q?oa61SUb+VQ9qFeohIdeDmzR4qjkyXJjJYN1q939b7Raec8RWL24bFYJcvuMT?=
 =?us-ascii?Q?/TD8Mr9tisgyUKc1L2CW9erW6/Rm2hZt7ql5F+HvuCWJcRcOo5Zd7VJ4m8lS?=
 =?us-ascii?Q?l+4qkWBmVSu3S3JL3Uohyt49nQr24Ai0wTMfucnws7OoqcWcViiRYsQX5KiT?=
 =?us-ascii?Q?n4m5gWfELWd0X3a/p6GAQtWdqDPMF5kEt+CRIImGqpBnrXiehzY4Wax2Jw9S?=
 =?us-ascii?Q?Za2GoYvfNfBcoW5j6lfssL5ell5lyqbDS6EOsVug3CpnOgQs1JXWPg36OSBp?=
 =?us-ascii?Q?dyXFNckdol8b4Qzr3vsDkVvIGngYtKpeits1H3vyIKpFp7x4u/Jk4lEA+JuC?=
 =?us-ascii?Q?HYZ7Sm9NxyD39kFlV77uBtjndVc19bA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2a09a88-af57-40b1-0049-08da22985c2e
X-MS-Exchange-CrossTenant-AuthSource: HE1PR04MB2971.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2022 06:38:20.6050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t1PkDqYc6L1qKHClY5+qoXlyyZvw9AMDoDLgvtyNUCZIBjXkTI4xHMyqj8nw5EXglhSb6PW98DMaxs4NV0ugjIth+exRlIJkE/wb0cNHT5k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7990
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

changes in v3:
	- rebase to latest master
	- incorporated review comments

Meenakshi Aggarwal (1):
  crypto: caam/rng: Add support for PRNG

 drivers/crypto/caam/Kconfig    |   9 ++
 drivers/crypto/caam/Makefile   |   1 +
 drivers/crypto/caam/caamprng.c | 260 +++++++++++++++++++++++++++++++++
 drivers/crypto/caam/desc.h     |   1 +
 drivers/crypto/caam/intern.h   |  15 ++
 drivers/crypto/caam/jr.c       |   3 +-
 6 files changed, 288 insertions(+), 1 deletion(-)
 create mode 100644 drivers/crypto/caam/caamprng.c


base-commit: 559089e0a93d44280ec3ab478830af319c56dbe3
-- 
2.25.1

