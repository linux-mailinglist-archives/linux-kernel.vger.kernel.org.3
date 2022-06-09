Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236C6544E03
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 15:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245257AbiFINrh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 09:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244511AbiFINrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 09:47:32 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30088.outbound.protection.outlook.com [40.107.3.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9CF9F5D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 06:47:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qj51S2a7ZxvwXPhNzYTf0UYwMaimg7Q/Bz1WZNpqyuJksDAb1+VaMIfcHsrIL0lyWFrD2HL56MX3FxUNCstK2/ww7CpbWsIU9+jvexiFPbjbpFlVFKoidxR8VhXChRVMNzX2mqGMk4irSvtD90r6EWWHNTzi43FzCvTNvLNBP9o2FyLRplqQDxKNc3GdaXmTmSA1zTRvEnV0Q/QE+OXXlrF1WPLITeoUCKWO52mNE13P0zgBIVXLZWt5WOd0quKNRrN/zSQmPZ1S5u3Io5fPZ4Nu/6H2+QXZekXEqgU8300HyNbKbJ4IYF1dXwqsfP78pyCUezkThYyKIANuPxkHgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tfKrk0MQyx3jgXjFHXaVVafDb8qP5BlrDfAI3HPEOZk=;
 b=e11qkEZOPER6J1b8S0easGoR+nJnjvSCRz1njEFQLpKfq6esZLAMpO8rWLZp5by90clYUIZtUvVtkljnQT67qwdSJgOnOGDPV08iY/LLq6zW1uzicHnreyRmrqbHp3Pg6vKXTN8A1PtGoMb8cNdyRUu2KvFqnRicBT50bk4aqObMZbAZV+QG0e0QxVBF1vin88jogoD/kZVS+7n9LYGTxhpkCdASuoUuWg0lekh6GMUGHP2g8c8jlkKKV5EA667mVzAkX4VvKzS3iDxKAA4eg8/s3k8EFEyB2n27NvYSnD/uNLs0hdaCCBM7oUS5XIBTS5Wp/BxxGlfwY7mYtvQxiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tfKrk0MQyx3jgXjFHXaVVafDb8qP5BlrDfAI3HPEOZk=;
 b=jjtHx32KkBnBswvFhylm9viXOvnTTyQRAQ96MAr7bEveBdywHqw74/mG3sQNp3F1YY7hR2HVh94AxSZ6Q1H3fqYzUNb14eAcU8W46J+e6kGbHE4m8taYKh0axXyw+eTiQVIRgzhvetuPhGXMlOCT3XefwDWAKueEqaglPfbheqE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM6PR04MB6583.eurprd04.prod.outlook.com (2603:10a6:20b:fd::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 9 Jun
 2022 13:47:28 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502%7]) with mapi id 15.20.5332.013; Thu, 9 Jun 2022
 13:47:28 +0000
Message-ID: <a8ebd458887cc181fca8c4454d7fb242a81a1e1f.camel@nxp.com>
Subject: Re: [PATCH] irqchip/irq-imx-irqsteer: Get/put PM runtime in
 ->irq_unmask()/irq_mask()
From:   Liu Ying <victor.liu@nxp.com>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Date:   Thu, 09 Jun 2022 21:47:18 +0800
In-Reply-To: <87czfi3wpv.wl-maz@kernel.org>
References: <20220608105057.2607812-1-victor.liu@nxp.com>
         <2d79719b8670a3693b210af5ab45716dba23999a.camel@pengutronix.de>
         <17d3adc7d7d329cab65b54ce71db05bc070872d1.camel@nxp.com>
         <26973cddee5f527ea17184c0f3fccb70bc8969a0.camel@pengutronix.de>
         <87k09r45ww.wl-maz@kernel.org>
         <07e01555c4722daed2dc13871c42ef7764a157ae.camel@nxp.com>
         <87czfi3wpv.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR06CA0191.apcprd06.prod.outlook.com (2603:1096:4:1::23)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f66b5cb-77de-4fb3-d3b0-08da4a1e976f
X-MS-TrafficTypeDiagnostic: AM6PR04MB6583:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB658318551A0933016EE70F4798A79@AM6PR04MB6583.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3nmy4TwT/Jt0x8a7xQkI2f8ALn0ZqiobYqtftxzYn/sGnfEnCTzd7Crl8W79KwncRjdNqdSrK7R7Gxvav1pCsZvYsrzP11moETDEsaw7Z/jzrmZOmSGJaPnnDeOIOJYOJQlX3bbAk3XMjnscrI69o63zEogTn/rwTdHrvsz/HFYtC7ZgMNNaAcn28kalAw3lJq5M5DxAj8I/ZsxQBgm22AO9uQ8OgyI/Kze3+JPGX7fxfu04j2JX0jvK4aNruY5c9GrjMz0aLc3dCjSU2eiLWZpx3L7V/m/InH42+DfeBgPylpLkglDLNUu4DP9fCM+B9P281ZGWrDwwi6t+qEsQgcl0mQlZBoXibSdIaszF8GUNr5RxJBzRkigiUNypcdjD87skvkTBXiVoUnwyknC2bgQpb0TO5S2aVAPbBC1RMscHVE3w+30sKpIXV8C5/KWYebaD4gAVKFoIjMfdovi5DmRb2zLZalov9TKY/gLM5kQ372AAyKjmSq80HBE3OLPdLOlryT80oGmvy1nntEAog87W06Z+FKe2YKDUAJkAGpvIBw21Yu1h/xVblSGN6+bgHs81EmNYBbwRgHkT1fEXwcnmFMy0YAmLmQGaHjZSJiUW13Id0BB9nnLi5JyQYNnCTOrbC0sx06yppPFNffs4M7UNs8KaG2+3eaEK2TPaU/S4SyWvGvQD+tE07PhnyTKCetOE1G8VXvsxYhN6SBu79kf1OUKSLkGzCLWyPezLke8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(316002)(6486002)(2906002)(5660300002)(4326008)(66946007)(66556008)(66476007)(36756003)(52116002)(6666004)(26005)(8676002)(6506007)(6512007)(86362001)(508600001)(2616005)(45080400002)(6916009)(186003)(8936002)(38100700002)(54906003)(38350700002)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHM3S3ZDYW5ENWN2dkFsbFBqM0hhZDk4ZGVjWnJ2ZnRucjdBOHZQRHZvZE43?=
 =?utf-8?B?NU9aYWhyeFRBY0xXVGFmeEs1ZitmcG1Tc0xMR2Nab3kvOENYSXk5VWZJZkNz?=
 =?utf-8?B?M3Ayd1BMSmpaYzJ5bVlFdkZKUXJNcS92M1VBVUh5M2VJRWtZWFE5VEFqdnJK?=
 =?utf-8?B?WktIbEwzN0tmUHpCbFFiL1NPRnVPZ25BRTJ6aXo1Ky9yTVRKbFg1WjY0Z1No?=
 =?utf-8?B?MWt2Y2E3SE1HcWhNSnJucGF2QWhSM1ViUHE0aDV3a21KZjVlbHo4MVVhMjEw?=
 =?utf-8?B?eGhCdXZ1R1dEa1V1akxFU0psZGk4Q2FIOUJRK25hVjVQSTZ1MGxadWFHak9i?=
 =?utf-8?B?MVJ0WXNtSjFlOW5rV2creVZLNExEdCtQamhrM1R3SzNuMFJOWVNCSjJaM0VZ?=
 =?utf-8?B?SDdBanZrbHRZTzZUQnM0ak5STlR2c3VKMk9RMER2MFd1aDFWRTRnUVZaYmpB?=
 =?utf-8?B?N1V3SG9PdlpEWnNLNmdFLy9hZjdqQVhHUDJxb2F1VzhsQmswbGFuN3BmaWJn?=
 =?utf-8?B?WlNIbXJNajRIMnBuU3paWnl3MDd0cXoxWmNBdU1jSTlCTEU0TUtITlNsWjU3?=
 =?utf-8?B?Ymp3NGN3TjRIeVlhaFcwUDJ6L2FueExpUjZVak5hdlFjcFB2djZlalZWVUlJ?=
 =?utf-8?B?UjJ4UyswK0QySm1HSkdaZ2Z6bHBreEF3L3dPUS9JZHM0NWRHVDBqajJTeUVS?=
 =?utf-8?B?MEFSNE1kTnJoOFdKSGpoYTZDL1ZjRXNyNEc0cVViTmZEZU1jUmdKU25scTFZ?=
 =?utf-8?B?T0xmY21wODZLVVNwWW9pMmM5ckhIS00zWlRDMGE5c29RVENoaHlQQ1RzclA1?=
 =?utf-8?B?RlFJa0pXMVZTbCtpd1p0aHA2b3B3MUd4RjBZZkRCZCt1Y3ZOZEpqYUQwcTFZ?=
 =?utf-8?B?UVdCRXpQMW9zMWNFOHI2WThvMTNqTnRrNDZVcDE3MkV6S2R0TklKYk9qaUI4?=
 =?utf-8?B?NjZOQnJWZ1llVXZuT0tYMGc1eHBuVTNtWGVWL3NadkJVVWVyMTJQNzhrWFJu?=
 =?utf-8?B?eGM2bWV0Q1haN1kwVk1MdEEySXJCNkdiTFZFNFk0TjNJM3dvR0RpVzJ0TjJ6?=
 =?utf-8?B?OUdJRGh3aURPc2RYY3Q5M1hvbUhyejBaUGZHQWtsQnV1U1JvUldvSkpNZzRV?=
 =?utf-8?B?cXRDdkYrZkNPbHBuZ2NLclRKdUhsNEV1YnJjNUdiTVp2V3lIcFRUcTZVZmFB?=
 =?utf-8?B?UmdYL29oU0ZxQkIxYURXMzJUdmlaMlVKYmR1QVVzdE9uOUVROHlOVEVJR1RU?=
 =?utf-8?B?MGN2Q3RCWnBNYkZKWHdRSWM1bU94QUI2Z2VHRjhic0lDZldjb2NFRDBLSE9h?=
 =?utf-8?B?eWpqUk05Q0MrOHhJR2ZWL2RLcEdSaXc0Q0poVEx0U3hDOWNVd3pjMlpCMGEz?=
 =?utf-8?B?blVRNmNzMklObWpYdVJudzBGcS9ERkJKN2Z5UUdjTjZyR1IrMFRrcnAzY3Iz?=
 =?utf-8?B?TXlLd2ZFOHF1MXA5SEFKYlJGWEVlQzdzbUJEb01uOGNndEt6VmgxeVpMUmM5?=
 =?utf-8?B?RE5RZHVuQTZwaGNzSkdGdTdoSTJVTnR0S2FMc0tlTkEzL3pMZkZid2VGL2kz?=
 =?utf-8?B?dllMQXM4UWtkQ3NHNnBnUnQvQWM1aG9DT09EN3VvNUN2Tlh3STRqaWEvc3NB?=
 =?utf-8?B?cldnNHZOb3ZsZUpGa3RGWFBLSldLVHUwUDZIQ2MzUDJPR3FyNWFXd2VuUk8r?=
 =?utf-8?B?bkNLMXNVcTduNVRXWUZENW5VZlJDMmdoYWYrcWlmanhueGpGU1F2dU9jTUNu?=
 =?utf-8?B?cVlVRVRqdVFSWEMrYUNoL3JMUHZTZWlEOFFHS0MzdEVubkptZm15QVNVZFVq?=
 =?utf-8?B?ZzZFbVdOdXRtR3NHVmJPTFhxMzhwNmxmQ3k2KzJGWXpWT1JVZFpMcnFLdHhF?=
 =?utf-8?B?YmNJMzl3NnZmTDhIMFExOHBYdmZiOWJIZEYyYU9pNGMzNzlKNHJuZjF4MmJC?=
 =?utf-8?B?NnBIaFNBZVQ0ZnNZY0QxR0ZuNHhhdjFjNlVjaWpxRG1LYXVvS1ltbDdhZEVs?=
 =?utf-8?B?R2NacFU0UUJZZm9OUkxWYzhvblc3V3NFU3ZGa1o5bnFuT0FMNmJRSk9oa0Ns?=
 =?utf-8?B?U2g0emFzWVRNYWNwVjk3MWNNcXZUKzZoaVRBZENBaFcwL3EyNnBlUHAycUhw?=
 =?utf-8?B?bFNKbDRDY3NqZnpHRCt5NHBBL2ZtODBsMzJvYWd3YkVoWWNUdUJpclBRdUJK?=
 =?utf-8?B?blorN0Z5QTZIbWc5MzQvR0wzK0hzdW9Qb0tRczRQMGNRTm5lMnozL3c0d3R4?=
 =?utf-8?B?L1pLNDVmR2VyNzBiOTNaeCsyTGNZZDNERWVPOXVNUDhsSUZwSGlOLzF3QTVJ?=
 =?utf-8?B?QWhnN2E5QjhNeUNJdkg5dTJEN3NudU00OFdVb0YvWjNGdE9EcHg3Zz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f66b5cb-77de-4fb3-d3b0-08da4a1e976f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 13:47:28.1508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qz1ohOKAFhL80LDWOCl9EXMjt4bxQ0Zf1mFS383zJ6r/zD2Pu470HYyEJkS7Ya9d9o/5MdJ6VkydVPFnv5FMug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6583
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2022-06-09 at 12:25 +0100, Marc Zyngier wrote:
> On Thu, 09 Jun 2022 02:41:55 +0100,
> Liu Ying <victor.liu@nxp.com> wrote:
> > 
> > On Wed, 2022-06-08 at 14:54 +0100, Marc Zyngier wrote:
> > > On Wed, 08 Jun 2022 13:02:46 +0100,
> > > Lucas Stach <l.stach@pengutronix.de> wrote:
> > > > 
> > > > Am Mittwoch, dem 08.06.2022 um 19:29 +0800 schrieb Liu Ying:
> > > > > On Wed, 2022-06-08 at 12:56 +0200, Lucas Stach wrote:
> > > > > > Am Mittwoch, dem 08.06.2022 um 18:50 +0800 schrieb Liu
> > > > > > Ying:
> > > > > > > Now that runtime PM support was added in this driver, we
> > > > > > > have
> > > > > > > to enable power before accessing irqchip registers.  And,
> > > > > > > after
> > > > > > > the access is done, we should disable power.  This patch
> > > > > > > calls
> > > > > > > pm_runtime_get_sync() in ->irq_unmask() and
> > > > > > > pm_runtime_put()
> > > > > > > in
> > > > > > > ->irq_mask() to make sure power is managed for the
> > > > > > > register
> > > > > > > access.
> > > > > > > 
> > > > > > 
> > > > > > Can you tell me in which case this is necessary? IIRC the
> > > > > > IRQ
> > > > > > core
> > > > > 
> > > > > With the i.MX8qxp DPU driver[1], I see below synchronous
> > > > > external
> > > > > abort:
> > > > > 
> > > > > [    1.207270] Internal error: synchronous external abort:
> > > > > 96000210
> > > > > [#1] PREEMPT SMP
> > > > > [    1.207287] Modules linked in:
> > > > > [    1.207299] CPU: 1 PID: 64 Comm: kworker/u8:2 Not tainted
> > > > > 5.18.0-
> > > > > rc6-next-20220509-00053-gf01f74ee1c18 #272
> > > > > [    1.207311] Hardware name: Freescale i.MX8QXP MEK (DT)
> > > > > [    1.207319] Workqueue: events_unbound
> > > > > deferred_probe_work_func
> > > > > [    1.207339] pstate: 400000c5 (nZcv daIF -PAN -UAO -TCO
> > > > > -DIT
> > > > > -SSBS
> > > > > BTYPE=--)
> > > > > [    1.207349] pc : imx_irqsteer_irq_unmask+0x48/0x80
> > > > > [    1.207360] lr : imx_irqsteer_irq_unmask+0x38/0x80
> > > > > [    1.207368] sp : ffff80000a88b900
> > > > > [    1.207372] x29: ffff80000a88b900 x28: ffff8000080fed90
> > > > > x27:
> > > > > ffff8000080fefe0
> > > > > [    1.207388] x26: ffff8000080fef40 x25: ffff0008012538d4
> > > > > x24:
> > > > > ffff8000092fe388
> > > > > [    1.207407] x23: 0000000000000001 x22: ffff0008013295b4
> > > > > x21:
> > > > > ffff000801329580
> > > > > [    1.207425] x20: ffff0008003faa60 x19: 000000000000000e
> > > > > x18:
> > > > > 0000000000000000
> > > > > [    1.207443] x17: 0000000000000003 x16: 0000000000000162
> > > > > x15:
> > > > > 0000000000000001
> > > > > [    1.207459] x14: 0000000000000002 x13: 0000000000000018
> > > > > x12:
> > > > > 0000000000000040
> > > > > [    1.207477] x11: ffff000800682480 x10: ffff000800682482 x9
> > > > > :
> > > > > ffff80000a072678
> > > > > [    1.207495] x8 : ffff0008006a64a8 x7 : 0000000000000000 x6
> > > > > :
> > > > > ffff0008006a6608
> > > > > [    1.207513] x5 : ffff800009070a18 x4 : 0000000000000000 x3
> > > > > :
> > > > > ffff80000b240000
> > > > > [    1.207529] x2 : ffff80000b240038 x1 : 00000000000000c0 x0
> > > > > :
> > > > > 00000000000000c0
> > > > > [    1.207549] Call trace:
> > > > > [    1.207553]  imx_irqsteer_irq_unmask+0x48/0x80
> > > > > [    1.207562]  irq_enable+0x40/0x8c
> > > > > [    1.207575]  __irq_startup+0x78/0xa4
> > > > > [    1.207588]  irq_startup+0x78/0x16c
> > > > > [    1.207601]  irq_activate_and_startup+0x38/0x70
> > > > > [    1.207612]  __irq_do_set_handler+0xcc/0x1e0
> > > > > [    1.207626]  irq_set_chained_handler_and_data+0x58/0xa0
> > > > 
> > > > Ooh, I think this is the problem. The IRQ is not requested in
> > > > the
> > > > usual
> > > > way when a chained handler is added, so this might bypass the
> > > > runtime
> > > > PM handling normally done in the IRQ core. In that case this is
> > > > a
> > > > core
> > > > issue and should not be worked around in the driver, but the
> > > > core
> > > > should take the RPM reference for the chained handler, just
> > > > like it
> > > > does for normal IRQs.
> > > 
> > > Well spotted. Could you please give the hack below (compile-
> > > tested
> > > only) a go?
> > 
> > I don't see the splat after your patch is applied.
> 
> Can I take this as a formal "Tested-by:" tag?

Yes, you can.

Regards,
Liu Ying

