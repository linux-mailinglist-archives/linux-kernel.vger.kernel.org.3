Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B95424FED90
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 05:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231965AbiDMDbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 23:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiDMDbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 23:31:16 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60041.outbound.protection.outlook.com [40.107.6.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716F62497A;
        Tue, 12 Apr 2022 20:28:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCTBcc6zTVsY6XzxtntJuB8NXdYt3VOJG6eSpHN0aAnh6BkPbFbH0MWJU3XW2vuN0cVyTKRKi25bGAeQ0ziP/n1Vaf+qii8J10+N8USGV0VjecMve0/MNHX41xDp9aVzeYygaz7Xqv4GV5HdxyMUJffPUwa99q2cqWDzJ1bwHusMXsx7VgfbUHPbhE+T2glhyt7DMer7cF9eM8FMOTg1xhFrAUCPgJINJkBdvHz7ibB7UnPAflS1X2E3piJUB05Dlgao8tBPZEpummHth7T7QBuhDatL7NzQwIDwlLOHXCUl8Ta/jbriOsOtmzI7A8qaie2gf6dEfw+M/p7kQpKk+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ZWAyW4ldKnu3kXikZo/hX0YEeSoDJ+iqPM7u1m88Lc=;
 b=T0rcKsO6TZYgFavPv5PTFrNQR+5K1Hb3Oj8E2n0j4JL1D7CI2HVseitDIAJmijBp6d7mmlFJH6kxoF/LdkugR7Kz4MZ5Gx28mSXqc44RSCuEJWoF3HFXw/Us/Sk8UyL+b4MDwC12iuhyw+4FGxvrcOHCfpFq9tBqAA3gLCzGgj9RvLcSJAbty365dvTiPF/1o1t0//oniJ+ZyCWpgtl8rBVr/CrGxklM/P8Ty+Yq4967m+B0u3qb0dk4UgcuXcJxZEXV7xYwGujRrBFwc5hLKNwf7I4G7BC0Of3EUFiBe7tRBvQHRG+ADb/hMkVO2ffl6Pmqawu9dgBPLMpVCbnscQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ZWAyW4ldKnu3kXikZo/hX0YEeSoDJ+iqPM7u1m88Lc=;
 b=fxIynXyMCecoU0vvHmfDCjFdC35kkBQ0UFKPxAbmBmZwTl3BjwiOV6u1BsKyBk+Nl33si8judy+XNM5F7hvKqy2Ha6TevwcJBCmnAmi8P4/xlsCeFNJb9/T8wsMa9pFGY5NSUPt68ntyUyo7LM2lo8ymoBS+7B0/8sAnDv145Eo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7483.eurprd04.prod.outlook.com (2603:10a6:102:86::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Wed, 13 Apr
 2022 03:28:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6%8]) with mapi id 15.20.5144.029; Wed, 13 Apr 2022
 03:28:50 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     bjorn.andersson@linaro.org, mathieu.poirier@linaro.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com,
        linux-remoteproc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        shengjiu.wang@nxp.com, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 0/2] remoteproc: elf: ignore PT_LOAD type segment with memsz as 0
Date:   Wed, 13 Apr 2022 11:30:36 +0800
Message-Id: <20220413033038.1715945-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0013.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8067a3de-5d5a-4233-74fc-08da1cfdba25
X-MS-TrafficTypeDiagnostic: PR3PR04MB7483:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <PR3PR04MB74837348693BA9A04634F9E2C9EC9@PR3PR04MB7483.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3cxySkQS5F2x6UXE//DWUNguvTytz1/31kOPRnWvSzBqW4OaIPhSss5FukauAX5QKMK7LKJYp2z+kfrtVZ/Fcb4lEy9aDQo9IwLFD9THat9sYQGNLlEZ3yhYF8hR9A0PNcZL8DEifsicOjxT+D3KvaKGSFu9p6ZreNmh/61gJgUiD59V3FD3/nXQwup26Uu5ylHxR6Jt70TktZRdhaAa4aLJLJ8vsy+LAvU2S9OBP68ZKzpeqhDJIr1tWq/hatFDSEX0/ckSJRuHOFPLJqUkM7lJ8VtUyTRFOigDp9lhriM2Kd1+pvusJfGeelsCgskyKlUvQe3MhjpDsKKNWuizyg20qQvcHQg4vC4Xc4gHmTmQcGeydvI+to3TD1iKoN2e1GHxn9zqg40Nhi8cq8xVXtjZtNcMiYhC1g5i/I6/8TtLgqZnJjudRRS80BN0bGfFELm09a0qh4F/TGXblaUUuYSMbcqDxVfhaWOoLXG4QeX2MP2OwO23IikPzyoK/4FH63CyhYxe9apyasg3JpGH+yL3Yc1gUU71Pbpe9zzt/kHSa/OuIGCBXbSjfiejEb0TNtju+p7VUaKF2PQUsMjCOJUZqoUekkS7soz5kAQAHysKgOFG0hVmWdBlY+pfTcUkwCTNow/MW9w0AHAzK5oV+1hLFtybcr+6KEFp4ZGsjrFuPI8wst8WWX+/RViu8y6yLp2KU2YSSDCAXhO7v8GCduzVJKII1jW6rnzg2QBgPGcwXGktq4a2xQokMHREmQmH5TveSY9u4mFh0/mMBk3vWjFa29F0JKAKQrBTWjzMJOA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(508600001)(52116002)(316002)(1076003)(186003)(2616005)(6506007)(83380400001)(38350700002)(86362001)(38100700002)(26005)(4326008)(66476007)(66556008)(6512007)(2906002)(966005)(6486002)(8676002)(5660300002)(4744005)(8936002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tHrqNRUZgOg2qVr/wgZJy1ceRL1mQIl9LETn4bBQBJoqM0aOqmOypxnl7oEF?=
 =?us-ascii?Q?/upBOydC/GOkU/pIE38Evk7Q0bY15wEhfaVQTkG1bMOXwYluUfjxdBHGp5+j?=
 =?us-ascii?Q?csm7YeTpgAFK8h/2LoPn/0CLq+RJA1IzIPE5CylfksdN9WIdfIeb3tT2nnqZ?=
 =?us-ascii?Q?/Frm3k4q4Ji5dzp2uZWjDTi/hEmjahhuzDVB+QqMaHNmAG7YvaP5rgomr2z9?=
 =?us-ascii?Q?OPg+X27qQvLVbargjGsUyCp2aKaDLNJ2vJLOKnZceP9IYNGpfLSO9y6IRFSP?=
 =?us-ascii?Q?gCh2H9rTNwE5OCXpzcbhJxRntgdU+W3rLadHpdoXicOxMtIIqIFBAALgo8SX?=
 =?us-ascii?Q?VRTH6UIKD5GE4js7my3NrHA+8N8ZsqHtwUXcafMsPyjEXNNJKnXJ9GN+Sb6T?=
 =?us-ascii?Q?Mgnd+tk9AUrxrcpFTKFbJVKBxj2VtzVD8m7N2NKKeIZC1fQib06PynIlKddz?=
 =?us-ascii?Q?DuccLrLeP9O4fgru3f5pqBwkQL+iKDn8w8fMg/dN0Qn4M91zD83A5J97iyGK?=
 =?us-ascii?Q?3Snx8GwZfffa3UqHb95uQ7h3z1+FQKO/bGPRnshkhke4ZqcPGL2KGP5dgHi2?=
 =?us-ascii?Q?casdIfAidEbaGXd24AXPFd9ymijqZ7TpVtuV4jS8q6h+sWjjiL0lGHUMInx8?=
 =?us-ascii?Q?MhYFTWeZATflGe7om2STQOXZ+5a6aQoPuTJnZONqX8dve5IkX6FEiNTWpqh9?=
 =?us-ascii?Q?nOgmz4yhPf98BGDifvmcLqcnoE5jmb3DvIPkaOwCh/KkfxQnHsIF8RMC1BB8?=
 =?us-ascii?Q?HF0POhP3NZ/DAHgnc9z4myIdn2/SqBcY9UwonQm7s7rLIGPmCXhDiLkx1kSW?=
 =?us-ascii?Q?MHK4tMciYJeJ3P4CPmOMkqAY3hZKTyTwoKbrQUSUs1vnRuWzJFGQ03rG9LBa?=
 =?us-ascii?Q?TKnYQ6PKnhiubC7FB94AiU/cBVglmBMMQeQeKEdHz0PTs/IiTblERzt8yjMC?=
 =?us-ascii?Q?iDmrTFeTUxLRuACuH3dwHRM2Iev7hs06/LRaBjRHGSCeFHFv+yKXe9mdNbAo?=
 =?us-ascii?Q?qhzy5INwuOalIGZgb9rPwknEgI8ZqAtu1p7AjAnaOjtSeRo7PU64l5xSJGrY?=
 =?us-ascii?Q?iUZcFa/2be0FNx8tBfeCRcHOEuvNZ1C3TdLSSEA7UhHffYzyRLQ1taq7w9Xj?=
 =?us-ascii?Q?guXExjYkRX7N+C2P3W0jAophBIZJnA2PSz9z2VGdsN4L9B9WH1s8k3WpaEg2?=
 =?us-ascii?Q?gZ1BNpYicA0dcdyO06N7L9nadgWS3JdjEbbID7IgvE6Adgddo3ER0+C7XSN7?=
 =?us-ascii?Q?eMkqtjhMs9XYgOtJj7GQU95JCDWktg2QDOiuJOTa0JFtvfdtjadLZzmh/boc?=
 =?us-ascii?Q?nkAEz+RmwQSJu9R/4jNU9QYnI8i41w6vLmgilsanDf3hF5YAXdI9NUsC7ad2?=
 =?us-ascii?Q?ZIVtkJ37jJLhlWtdfBtZrB5qoWeW8f24nRIMXUp8hJ9xoKX/4uMAp/17NqPX?=
 =?us-ascii?Q?63uHDzPXNTNBS+jkxZWSfCTORhnvWPXU8GbUtJ79Nt5P1UI6/ABzzYkIIx/c?=
 =?us-ascii?Q?rjcANGxI/3LN6EmBOt+ASlnd4vKBuCeqEmRiW+A5ZCmwG9a1K9eAHVdHeNHn?=
 =?us-ascii?Q?LrbiGT3skSyiG/SD4k4kap+iuo/uqf+ErjLS7Wn738hlDVcqqunQ+ng8jArg?=
 =?us-ascii?Q?vdGzBr2KcgHhtZN+SNQNd3Od1jdfVhiWE2hgpu1S/ey6RirL4a1XRTGQU5Sl?=
 =?us-ascii?Q?gNoTE7AA1AO85FtjZwtR2fJ8caOKwoTnyUJXQkiyeJH00u+3v3badqB+N0oo?=
 =?us-ascii?Q?ZQF4BJnEEw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8067a3de-5d5a-4233-74fc-08da1cfdba25
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Apr 2022 03:28:50.4468
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0ZTOnnBB5MySg/iH7Vp/c7qkP84mPRWe4fZ1M1aErHvoBgvdoTzEENM4E72MArXrzgTqM5FuelQbUQD8pqw0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7483
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V2:
 Add R-b/A-b tag
 Drop inaccurate comment in patch 1

i.MX DSP firmware has segments with PT_LOAD and memsz/filesz as zero.
It is valid case the memsz set to zero according to elf spec:
https://refspecs.linuxbase.org/elf/elf.pdf page 40

So we could let remoteproc elf loader handle this case, then no
duplicate code in imx dsp rproc driver

Tested i.MX8MP DSP and M7 remoteproc

Peng Fan (2):
  remoteproc: elf_loader: skip segment with memsz as zero
  remoteproc: imx_dsp_rproc: use common rproc_elf_load_segments

 drivers/remoteproc/imx_dsp_rproc.c         | 95 +---------------------
 drivers/remoteproc/remoteproc_elf_loader.c |  2 +-
 2 files changed, 2 insertions(+), 95 deletions(-)

-- 
2.25.1

