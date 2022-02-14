Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E0D4B50EC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353786AbiBNNDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:03:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353778AbiBNNDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:03:02 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60044.outbound.protection.outlook.com [40.107.6.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7484D24E;
        Mon, 14 Feb 2022 05:02:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FbZyEkwJTfCQ4YvMJj0Oxlha1G3Jq/YLSOOghjHdKHiNiqSzC7uDnX6KFABoAi3WPGV3oZ/kXbpu8Plm+q9Y0hV6UG/x/oMyLztpPQ+q7KG1Y8jjLqZaHprJTPbK3X6E6cTM1MICLtbX71rod0WrkDRQPjOpaDWj63FA+VE0lcEZaXKznCyTBGCYzb8C4jInvvfevvxf7ixJ9m1VFFtysaqGNPeydqJyx9/61TWYh1amvKZzLFHNY/aAv89geZa9r7ZIgdyBdmUMfB9eE2pFBpea9kbH0maFfbSqB/WG7QZ/dCqw65wBq0TeUspGWqzFsqxF3rVHjY7icz+p8a82zQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/oFSqhKcQbNFLjluDDdlp7T587s9F+rB9SbMrdeszO4=;
 b=Z/+t1JuVNWnuRI121ky1FPDazLm5XXYn+F+4CX+h5Qw+O6lVFxcaX9/4i4v2/OGG5dV9oT6JWNjBizZzlBTV56LF+fGQrBZ8/O9kN3IltxHuty+CYFTXQxytsYAsY7BNmr2ukC8ylLccFuxxP3xwfZZHLm6bjMQYogRMqof8keqD07mFZH+XBov8SfjemM2H6AF3AiA3boq1cO5SZrzlHBe1F+bwaOc8Nlwe48GRPrxSTREF8kb+v32eMiWRHGkQQCwb7FahN+BSRJnGNL3ztKOCIJtRTuY50/ontxZjdp0JBqo75DXuDXT3jw3pUQu+XBsMA5dqV1wgYM7mqvUVIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=KoCoConnector.onmicrosoft.com; s=selector2-KoCoConnector-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/oFSqhKcQbNFLjluDDdlp7T587s9F+rB9SbMrdeszO4=;
 b=NJGeLSXXRcaAtSO8by1H4SLf7f0zDMSeCv5jQrcv85m1uoY4MM3Ab2+goBuRbRFqYLT5tpoFJAxS8iGP59Fqe0GWbKByLB+FutJFlHEuoWWALZ8rngb98yFrHR7HHzjyBSWiOKmCKWjzw0W+CzaHaJbXIAFqjykkxepU0vPyBAk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kococonnector.com;
Received: from AM9PR09MB4884.eurprd09.prod.outlook.com (2603:10a6:20b:281::9)
 by DB8PR09MB2841.eurprd09.prod.outlook.com (2603:10a6:10:ad::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.12; Mon, 14 Feb
 2022 13:02:51 +0000
Received: from AM9PR09MB4884.eurprd09.prod.outlook.com
 ([fe80::3c7a:2af6:3623:4c3d]) by AM9PR09MB4884.eurprd09.prod.outlook.com
 ([fe80::3c7a:2af6:3623:4c3d%7]) with mapi id 15.20.4975.019; Mon, 14 Feb 2022
 13:02:51 +0000
Date:   Mon, 14 Feb 2022 14:02:41 +0100
From:   Oliver Graute <oliver.graute@kococonnector.com>
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-input@vger.kernel.org
Subject: Re: [PATCH 5/6] Input: edt-ft5x06 - show firmware version by sysfs
Message-ID: <20220214130241.GB13510@optiplex>
References: <20220213171532.346270-1-dario.binacchi@amarulasolutions.com>
 <20220213171532.346270-6-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220213171532.346270-6-dario.binacchi@amarulasolutions.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: AM0PR02CA0161.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::28) To AM9PR09MB4884.eurprd09.prod.outlook.com
 (2603:10a6:20b:281::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 14079f7d-0971-4259-0fc2-08d9efba4eb0
X-MS-TrafficTypeDiagnostic: DB8PR09MB2841:EE_
X-Microsoft-Antispam-PRVS: <DB8PR09MB28418BD27CF6C409B0282B21EB339@DB8PR09MB2841.eurprd09.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:800;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qyspOwHJG0LA8c0i1HUbK12FCMuHVWyrXR7g19XTx3Wf7a6p5Lvbqyrm1mggXqUAvdfRiw88VhYnA7C783Wgfbdpvry0LjAf+HBZganwy87QhInT8u2lLrmG1LU7i18ZEHOkrll7b7KPfJWupwzhYrzXhhdHOqnRZTFd7wiodENWHXYZRy4gIU3bAY0Tg70/vFlPWl6cl1dQf4VMl1SzSAXkDppQ/17FjFYzBlUNPGycA2Nm7VOaW0kY3Kth2t2ItVUOGaGMpuw8gPEB6RKL1zjLjkY48/XzxTPmzpgJvnfqiMpoRbWe6C3DszAPLnyUZhlKqMn4sVXtKgHAl8AxWivoF7KUG/SsC3PwUX5wiHoTFHSXpJDJt2bqbci1bvM6sdkyc5S3QAQZX04LG7fnch2dOrYNV/tQSOTQWrOlyUIkDYNvJrJ0ufIvtZF6T/nUI+ndHG4TWK29B0aP+/i83ooRnXI+cIJ+dhYQ1aZQiVRMtbAEs37GhpWnRgjQXzUvJS2ifR6gIMPLxj4FH6mO5+Ww+zY81krEfrpZkuuGNTRBf0LWBITfpVpuOx/MRXcsAi+pbgO1Vvs0NI8e27NQUDdFMe4hVGST12fBy2O94fJr083UucFhRbJULYlrleLFTL+JTzSkow8Kf6h/ihtnVpKj/hny0U+c6KIvQokBCZJJaEXrIuqjUoqMPJmnvMkdlHk0/Ols5AF01iyonwsifg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR09MB4884.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(376002)(366004)(346002)(39830400003)(136003)(396003)(33716001)(6512007)(9686003)(186003)(6666004)(6506007)(26005)(6486002)(52116002)(508600001)(1076003)(54906003)(6916009)(316002)(44832011)(8676002)(38350700002)(66556008)(66476007)(8936002)(86362001)(5660300002)(66946007)(38100700002)(4326008)(4744005)(2906002)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CsEku5fRmhiko3nP4/GrzBI8iYHHm9Y11G5DFLlMJXB8tmDaZIrCsIL/mCPe?=
 =?us-ascii?Q?hY78OUk6UOa9UN6BxxUOMzQ0jRA24pM1Hxjd9kKWH7sTwySaVQtIuG85Yc5P?=
 =?us-ascii?Q?a+a2AJqy/6m0uQUiKAyuwhLAHAcPhOWbDlN98Kc5iywT1mAYQvsVpC2ndj+2?=
 =?us-ascii?Q?E8WB0ASRB4RahOZlBs2ZS+yOdqHKo4VPHmKBah963QFgZ6PHh2Lqga3oULUw?=
 =?us-ascii?Q?WyAXx6K0G+PD35m3H+ww8PXx8lJpYOd8pQ26u0g+ngPkPtti5DoVw/PquOvF?=
 =?us-ascii?Q?u4480i3XLrMCVzsQl4fT4gCkaLnojkqbz7H0PVjMhDIA6P14cjCGkl7JsmVh?=
 =?us-ascii?Q?ljB2ZFcL38OZRP87T8iGwcvoQh0aJfIiR6iumU1BrUXx7VqFcRMNv3KfFCbQ?=
 =?us-ascii?Q?d6wzcMHEr22AQXt3SNPN2Nk3t4K6U7uQiOUZDYajK5X71Jg4LMbay8Ev4N+K?=
 =?us-ascii?Q?TT5Ldrreb24vm9dIM620YvT+UwlfMY8Mik0+bU1OuP828asUpUmBA//I2qkv?=
 =?us-ascii?Q?EBKmmFaEgDLa+5PLBtA3VY/oLC2rdD1BJFLd2MhCPZ/l6OMFlgM44TP+ZlYS?=
 =?us-ascii?Q?tMMQMd8fJHH/f4KiVgauGUtvbYxzDwlFHUlZf7iMcj7xQZzfj2/NcPWUUJtV?=
 =?us-ascii?Q?vn9FHpgM0v6iAAqGylqJ7UiKscCe6EENBLday8V/kT3BwgEt2ncRmCbzfNqh?=
 =?us-ascii?Q?iJnqjYFBxUDM3/kBUgViBgSoKF0WmtHa6UZuPya3RXb3YFoM/11SaJzy1s+8?=
 =?us-ascii?Q?jeATuIWpK+tGLKOgsGkU4XUlz8ZuDx5jw+LaAp28paw5Kl1KXJp3eGK8tf0x?=
 =?us-ascii?Q?S7zTNMRWC1iOEWf/fwf1IDuwEh7LMeCitpkvmq/iZFrcn5XLywW44bAKOXeY?=
 =?us-ascii?Q?ZIvuGbx8605Spd42tR8vHPD1FKl/hOPjvsMLQ6jgazrD+7EyjRk2xS03TFHK?=
 =?us-ascii?Q?AiWp5O8dGl0pCjDx2+ODmlbFcyBfUcdSi4KMveHIotIUbht3AIzeyAM8mpVq?=
 =?us-ascii?Q?PaxNjNGoqGGQiTucfXCehCQuNntPG9t9sMCTWFFp8R2SeIbcUdPAeNV0R5AK?=
 =?us-ascii?Q?UM2Vh3Fl1/IY1OkfoZRiucyUAtQZlmb6pF2VCtpXvGOUOab3a4BrMWuL/OHP?=
 =?us-ascii?Q?C/PpJMqq8FwzEWJSIHVilx4mddrYfl9SeSqPe05JcTgxyJgdvUMYNLd1+30Q?=
 =?us-ascii?Q?rbzgCKmnBFOOXrMkcTYvbSpgFqDtcbHkQy9DaD1sdfijo4fga+FErqsiIGl4?=
 =?us-ascii?Q?YZNv/l8pZnFZ+wIGo96EFrPwhzPWUxrinWdtL0o8y5PH29KVeu4tqx97ZRqI?=
 =?us-ascii?Q?eRd+JQfJ0ZhGiutda66Zo3f5kole3Po960YuFxZd+2bVb0w/Rn9JlDmqRHvl?=
 =?us-ascii?Q?cChqsAlQBIYIGMw7sZpH7taqfeZMZdP58eOLIeozXFYVoiMJyxFr1KeZX1gI?=
 =?us-ascii?Q?Uf878e2n0isDTBw4sYl+4qjgL1gT5pvtadbaK6GHepzJYyKGVqu3FSYVn+Gl?=
 =?us-ascii?Q?vo8YvCwvIwG22UcpYNj0mD5tr7Tfxeq0kDf3kRMZgaRr/Yz16gb9zcKy0rfI?=
 =?us-ascii?Q?PkUMLmWEGxKtqxJvPa2f3+NuuM+M20zrd0Z51wR4P/M6mE13SWo/YbU389gt?=
 =?us-ascii?Q?LGPO0iZqEXzFdf6U9QQP0gQFv8ADyCdqkF7Pl8dybPnDLUQlgwL0zGe9cZ0M?=
 =?us-ascii?Q?UL0dXA=3D=3D?=
X-OriginatorOrg: kococonnector.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14079f7d-0971-4259-0fc2-08d9efba4eb0
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4884.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2022 13:02:51.4158
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 59845429-0644-4099-bd7e-17fba65a2f2b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dGq+lgqmmAwYeQe7VHMXon60wvxNHopripTt0Ol7ibWJT3/XNANDBmSMkRApcoD7WH3FSuxFgPa93U2+RRfFlXEduTs0CSEwsHwIgj7p2E0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR09MB2841
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/22, Dario Binacchi wrote:
> The firmware version was printed only if debug mode was enabled. Now you
> can always get it from sysfs.
> 
> Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Michael Trimarchi <michael@amarulasolutions.com>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
Acked-by: Oliver Graute <oliver.graute@kococonnector.com>
