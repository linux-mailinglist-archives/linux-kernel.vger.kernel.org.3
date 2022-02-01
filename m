Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3F04A5D82
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 14:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238663AbiBANhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 08:37:54 -0500
Received: from mail-gv0che01on2104.outbound.protection.outlook.com ([40.107.23.104]:30816
        "EHLO CHE01-GV0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238789AbiBANhv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 08:37:51 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l+SyMl0IjM8Q8WD8ZuRm6kwoQjo4QSAo5SqRdoRf4O9TOb2Kq8RXyskHNpTI9jxaRcxOrj8YLeCRP8kim9Opmef3EocaqKfl+qbzYTjyNR5dynYHA/OPQ/C8b2Hl2xcYcTsRet4pxW6xfKIKc/Za0lKB/tuFDyEDyQzdVvpdyFvPx9yLRCT4u1wyplqhWTqVvbxwAtxFyrNJjn0pu2M5NBjzyiiOmd9b0t8JeLNnJEUrYC81odiZbJgwMGZK4YCJrsxj+TKks0shwmEx872LtXMePp91q6v85pu4ZWtfdtEHPIV8fgG3zU4fk50pRh25UmcKpzQPd9dI1yT37ivikg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1jsdAFFi7iyZiP6hTgdPIkpVgWtLMqpEdJO95FeReNM=;
 b=ZSJofnC7wQK+PRF7mCbKy7laZTN6WWttHoW75bIiHWKVirx1zbvf/ARnpxGcIhypS9I5/sagteo0lfj+372wYjmbyxNRwHCr+VC9a4pC8C/yc8ofIrXsQNTSjMS+2jvs4gcJrsK7NnFOMxnDJ8sFfv4vbEv6a/jpBhCNOyiwT3MtHmTAfIyKuZgtuGRmVUbQRf2BckXIsetYhvgTyr1KGfDEIlAnLPPwR7nYscnpRlNjHw4BbnZy0oQUTVg+TtnxXpc8mcx4hpmL+Sk8C+YbTNBVXM+5tAj3cucg/tGFrf3FzSwqhoNpBfEwv9xtfrLZonqFN5b+fyq36oBFOts3Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1jsdAFFi7iyZiP6hTgdPIkpVgWtLMqpEdJO95FeReNM=;
 b=gEDnlbBx9oCGHDN0anlrTqwc8Hbpcvy4v2gL0mNt1sdQmpGG7IaeDQu7c2e4y5oty6J0sCvMDgb1jdwR6S31ula25no2PM3Mole3RHRsM7XZ63Kckl+RsawwpMdkR+T6tm4kuIBu+a7d6PsnJN0+TgFoIo4jGf3KdpUULWYPp4o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=toradex.com;
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:3d::11)
 by ZR0P278MB0299.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:37::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Tue, 1 Feb
 2022 13:37:47 +0000
Received: from ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fc21:519b:ba18:7676]) by ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 ([fe80::fc21:519b:ba18:7676%3]) with mapi id 15.20.4930.022; Tue, 1 Feb 2022
 13:37:47 +0000
Date:   Tue, 1 Feb 2022 14:37:46 +0100
From:   Francesco Dolcini <francesco.dolcini@toradex.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Stefan Agner <stefan@agner.ch>
Subject: Re: [PATCH v2 0/2] Enable i.MX7 SOLO temperature sensor
Message-ID: <20220201133746.GA848723@francesco-nb.int.toradex.com>
References: <20220124082803.94286-1-francesco.dolcini@toradex.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124082803.94286-1-francesco.dolcini@toradex.com>
X-ClientProxiedBy: GV0P278CA0009.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:710:26::19) To ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:3d::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15ecce9d-3a4b-4341-d4ad-08d9e58808a6
X-MS-TrafficTypeDiagnostic: ZR0P278MB0299:EE_
X-Microsoft-Antispam-PRVS: <ZR0P278MB02999665DC210FBF48760411E2269@ZR0P278MB0299.CHEP278.PROD.OUTLOOK.COM>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IpTuUXKZLFIoZiQ6PRwYSna4kPsFxat7idwLXLHksWook+AAoE0Q1yEFpWiSb9f/Rq56rASR5PziOF751cYsub2/ZMaVtSoa/lkOB6ENQYHIETmE4HLdiM3oledgc9AEV/lX7J66SpP6tjJc0nPo0qDsgXZRZLIEqE3UJ1MAv3mi6RpsNVyVa5Lx8WHKxU45OBc+ZSoc6j9Hc+q8wyfFozRwXIuK/2EPOYCH4GRMHVIaBjxIA1etv2l4RC3hW/B4//iJkT6QbVAgxTM0pEh7Iw+5O4ZCdPBwuWYtE9CU8akSayptalzNArjylXDgwiwEtyFX+99lHX3E4QDkE3MLFaQi+xrlO7+3TNNI4sgDha3LVPsmHDdWYKrbzaSHSqHWOx1EDxiEv1W2Nf8nc2GQpAyNYgKlDCzne8vlbJDaipF3WF6+1Jpn+g0xfG19TpLTfJtV4m15ddsPTqJwhUq9Y2BTxjs9qVi32inN8aagpg4G1RlHwcK/uQn889DYUPkS2RvDSilVU+Fq4nY0NBoFm8El67o9db+lAJ0HyQjsvhUPKUN46T4l82rha6gMMcZtm5lg3su03uVUO/i/AYFJLvvEe45lfuQooflA5Hss7YufKnVCQXTjhZLl5a9i9qXuziQCk4RZohEuG2/LDl2DrO3f2w7Dqkq0sTuI5DtzDL/A3eLdfxSOvaEN6DmRcvxva+eVghbAFKcHEUwY4xUh4g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(346002)(38100700002)(38350700002)(86362001)(33656002)(66476007)(66946007)(66556008)(8936002)(8676002)(52116002)(5660300002)(6512007)(4326008)(6506007)(508600001)(6486002)(110136005)(54906003)(7416002)(2906002)(44832011)(4744005)(26005)(186003)(1076003)(20210929001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ecB9krFpee+fre06G+Q7Y9sPUcWVWOQIeGt6rqEHoDqGHSMEAL8HtD5LQRGN?=
 =?us-ascii?Q?laVm/wEfFXtcqbNHeXnuRVLmsaxL2gKWVbWkpmodl67eMjsbTC5t+NEhLeNA?=
 =?us-ascii?Q?UvFwN8+TpU6Kc28D8jmROVZ2ozbLnHR/ICm+Rw8O214qsmWNNsh206vKOwdZ?=
 =?us-ascii?Q?BKyxOvMuMougRg95ErHpjBoyUkeCFjTm+Ra6Lx1WG9PfCLZILqm3EUYvImsu?=
 =?us-ascii?Q?oyearwqVKGaNhgQ+1X7Y38u2psT5QDQzWLFdS2KCULcJe19UDL5MN60tuL2W?=
 =?us-ascii?Q?jEf/9Rw1px3npVaSMGeutRKzaA42DPBBIe3c5m/abYdGaebMGeZkmtouMDmI?=
 =?us-ascii?Q?RJecVbGKjaRAZzd+Svk2rLO81dGmmc++b8SSieAr8f4anI7faLJDHgMNsQaU?=
 =?us-ascii?Q?gw71FSDUGAkb+O0GliGhM59RDqL45MxFfs2SjfJkli6ycmTRI1lVFFM9ABIJ?=
 =?us-ascii?Q?+xTd01Q2+06CIlgjPkVgLv8JRV6BiJYOic7e+XVKA+XurNmZ4UUsZMUf5VT4?=
 =?us-ascii?Q?2mYSJoRT6Zar8RzuPJ20OsvrXXvKL487qQQ2waVvg2fnVQ8B4ke+tCA+Smjy?=
 =?us-ascii?Q?MoywwZ5IApMeqBdlg4d9sFR+j16ut+O47Z2Xx6LeI2sa66ofGTxHCcuftRA/?=
 =?us-ascii?Q?Bp83k7dodi/AxiXuT+iMULJVRi5GOenTjQK+p8F3WjjC6VlySzK3rlVtT7bI?=
 =?us-ascii?Q?TWW7PVvrndGliU5AUAfhM2tH/e3840cvaXKEdejKp29ZwTzTaB3PqVWM4Daa?=
 =?us-ascii?Q?LfubKTKSI2ZBKijJa/oOxWpTfFu6z804qNqZ0cekD3hY1sPtSB6NP5duPRph?=
 =?us-ascii?Q?KQHBaJNL15EaIVanrpQeM1yS9Cn+nS6Kk3q1KcUanH/ZBuYFGwglXJ6iAGDP?=
 =?us-ascii?Q?onSxiRks/RUhRG58yG6c6v+eV74naRHGrmRB3FVejdoWfc1MQMaxHGkmOt6c?=
 =?us-ascii?Q?OyZh7j4udfFfDt6vvpmtIsSiE2efdD2W+bHwv/5cMqhlBazC72yflC5FnFGJ?=
 =?us-ascii?Q?IQDfc5lA7IlUO/bxM/Wdllg3OJCzNhwQ41UFc5vrw8DxHWJ+2j6nYBv74htS?=
 =?us-ascii?Q?VbDQQs4B4iZ/rSpTYfBPC5sAGpUtRnWhbdWWGYOEZ8g/F+Ad18JK2rJ1/ihw?=
 =?us-ascii?Q?YIH6gIVa866ljwmOFTnpQbQkOg5kkYUVasdiQPOX8f7pxxRbEX+ASsWwx2cn?=
 =?us-ascii?Q?JH3uZ5ZKo8t1um7uXj/mzbgc7ipGYuJc4gOLC9FCDMLuxGdMu8/5TvcwFIk6?=
 =?us-ascii?Q?lILwP1eiA8NFBUelSSPg6DX1PW0xZYsjhI6O3GRBsAXCfURgxP4vkUoy8kn1?=
 =?us-ascii?Q?Q8MBy5370chOKm2la7f8qnq+4+c02A2+yFH9cnrkLmIsmLnEKM28rrFPQipH?=
 =?us-ascii?Q?ZtRZk9aPCs3Hf6bCeU4jMhwlvctdEpyDzBkBpncoKSCWMTHGwSBulamAeqS5?=
 =?us-ascii?Q?hwi3edAofzdSrIGrEY7xxOUyyIQDUka9bE4xb7wWCN2w12ZxE4I2mgjAmf/J?=
 =?us-ascii?Q?gRy0OtlTMFKUXpWuiEntw/Y94J+naKC3jMxzVwzwBoROALE7SnRub1H+eCUT?=
 =?us-ascii?Q?8IlaIbyKsbyKyl4mtj9wfc/FAS3wIVtykRr8vf72X8HLJ5DVVKDEYp6/JNWL?=
 =?us-ascii?Q?WtaUEAYenAJcgqcZlwkqAYbr3HoPw8Bt1kaJQGPdtHqYUM6GKV1MeSQvAYs3?=
 =?us-ascii?Q?03EgIg=3D=3D?=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15ecce9d-3a4b-4341-d4ad-08d9e58808a6
X-MS-Exchange-CrossTenant-AuthSource: ZRAP278MB0642.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2022 13:37:47.3881
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uO8IHQXLLb56F7BodUivD+zFV0E1jmbpWuLWlcHQqwScSjKPjhX87I2squ1A5Zmh0sN5TL9pM43+PofPnrtQEla3eUPrBlKN4F7k2qj4qqc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZR0P278MB0299
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, just a gently ping on this series. Thanks!

Francesco

On Mon, Jan 24, 2022 at 09:28:01AM +0100, Francesco Dolcini wrote:
> To be able to read the T junction on i.MX CPU the imx-cpufreq-dt needs to be
> loaded, however this is currently not the case for i.MX7S given that it does
> have only one operating frequency.
