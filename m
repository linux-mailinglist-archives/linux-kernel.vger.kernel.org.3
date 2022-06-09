Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6BC544126
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 03:42:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235988AbiFIBmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 21:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiFIBmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 21:42:10 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2068.outbound.protection.outlook.com [40.107.20.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC453B8
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 18:42:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K1LME76RQwK2lepAKUtbO0KUL//I1xWPK3ZcuYdUgXpGmhhJFPNFcIDdwSEDLkTujEg8JRxm5tKWfMGIhENMNzwo0nXjinWm0M3z/KJ/+ETOrpWOsmXRED01JCIaVDnS6PJnkDwayGniZOchCRomNLk08HORlV7PDyi6HaPmria9+zmo4CotSqS+trva24LzmdRAxOvErzgH1i4TImPedtDQknnSvpboYPNegsNWXSD6bGJ8d+tYRW+bU/uWmM9Dtd7E2O8saxGHDa/iRCRBR+EVgbQUW7td+XGPpkfS9pxFMwT01wUedcmro0HT0mXzIxIGFsRdB5250aFxhyUOFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eZwiRIM6Y27IHBTv7lgLzN4pJRdd3Fuc/4YCdcDXSlk=;
 b=jLa4Ur2yy9tD0+VWvnuYt6hQcM6MXAWjz+f4xhA1pfPysaJ1GzKNVro5TSLkofD+lNTX4iWjttccSa025RuZg13+c6rkxnf49pxURiupVrPKK3duwC50fjpEX54Dwj1qkhmGGgBf8oWtFNqrLIArvowo150azHarhx5dPNzC1wwp8Kvlbgfy1R7N51DKUH0GbOw2ZyifXJuuTfYXqYb795xrWQsGNrW8UwvXlvD/rsVPU70H9szdwIS2icAkJ+5ra50Y/qaWd2eo58NH+HdYdnv/EYHu2WF3Uc9uIMxNYvSvlDbu2yXNPYllzA1LGLN3w4NwgNbDu7hZ9avrNSiYJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eZwiRIM6Y27IHBTv7lgLzN4pJRdd3Fuc/4YCdcDXSlk=;
 b=CXK7TcfjiKm7whWN6fbGRaS0eLY/+yS2tuzJA3CZ314dpI3kMotC5OnEmeqmk1i1GWkFOguTjY0liRwB1UIaJb/e6onIPSY0kAEuLpr+eR8CFA8b6mxMpXSqDymlT+K9Xt5SAGunQRI4tqyeX2FdwdWb7le3C4GGJrGLkvssYL0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by AM5PR0401MB2451.eurprd04.prod.outlook.com (2603:10a6:203:36::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 01:42:05 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502%7]) with mapi id 15.20.5332.013; Thu, 9 Jun 2022
 01:42:05 +0000
Message-ID: <07e01555c4722daed2dc13871c42ef7764a157ae.camel@nxp.com>
Subject: Re: [PATCH] irqchip/irq-imx-irqsteer: Get/put PM runtime in
 ->irq_unmask()/irq_mask()
From:   Liu Ying <victor.liu@nxp.com>
To:     Marc Zyngier <maz@kernel.org>, Lucas Stach <l.stach@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Date:   Thu, 09 Jun 2022 09:41:55 +0800
In-Reply-To: <87k09r45ww.wl-maz@kernel.org>
References: <20220608105057.2607812-1-victor.liu@nxp.com>
         <2d79719b8670a3693b210af5ab45716dba23999a.camel@pengutronix.de>
         <17d3adc7d7d329cab65b54ce71db05bc070872d1.camel@nxp.com>
         <26973cddee5f527ea17184c0f3fccb70bc8969a0.camel@pengutronix.de>
         <87k09r45ww.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SGAP274CA0024.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b6::36)
 To AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ed350e19-0712-400e-22c2-08da49b9421a
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2451:EE_
X-Microsoft-Antispam-PRVS: <AM5PR0401MB2451AF0810F26381EBA8478298A79@AM5PR0401MB2451.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8xJcIOc1pDso/5aDSzk1ePeGk0eqEDL/nLIBSexhvFnTkYD5pikAwvOvB6UaXNtYHb3TlRbqonhw8vm37ztChiXyFpf3epkmQic7ySqHl4OvF1IG0+J1Y+SY0IgiFSRiYhVE3r9fQ1klbgmWkbj80TOlhNdypH6FTcL9c/lGBzMikuH2qfyVf0HyNzvsdXAUX90XV7YaXVanZcnTnORJVkYcjmsX6wRqc41dAbzMQFU9JxSJroqzNMlvsdnM/26UaEffBLoKbri3UiybWmvO682/cEQi41JtrCAAro4ufMI+bHC6CgVVpUjW4Xfx46zg1Q1jMn+INz3FbWuP0vQtnR1xQvcYXY+vmjmFJK7BotbgPxPVkxyl06MtYWRBj0w1LeRLlD+lZIeZklpnLHG+FTd7qjpifaRxAmd4MYDz2zIZBXTvhrUWJ5Cc17fIRRdtGL/VQnfQDYjJutmCLimk4mQTU3KPFpTDxKtansZnw9JxUQ9TD7fq2tbj0J4M+Wtxt5m2rDUODK9oWlQ6aab9sla/topnjWeVVM0+2hUTdesArBglyfk7O04TrImdXl+dkKnmlRDBpoFuWuUCyQAcK27h63ESpU6gzXfLnQYaffl5X1836Rl+Wl/jOBEkjmnTpCGtxEvE9SQj6D2ujx5mkdxrSZ7PELqEbCjq0d0jDZzdXTi8cfF6BhZ5O0FtJ1U4Ha0NPPUnrln29e3tJl3zpQNyorF113mWT87VOgGsK9RInax2uO4YhIm71QQR2Sa4bBGqkVQN4nbzELFmuAxurmfVXx/Ye2JWHpmTYG3u3r1A6VqyY55Pw78TA77acFDo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(6506007)(2616005)(186003)(86362001)(38100700002)(38350700002)(5660300002)(6486002)(66946007)(8676002)(66556008)(45080400002)(316002)(508600001)(966005)(66476007)(54906003)(110136005)(6512007)(26005)(36756003)(4326008)(2906002)(6666004)(8936002)(53546011)(52116002)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmhhZWNiOGlTbjRQdWFEdGZuSzkwVXUzOW84NHI5R0dUcGhyVGNKeGNkRG5P?=
 =?utf-8?B?bk1ZZjUxcHpaZjBDaWt0STM3RThad3ZrT0g0V015OWU0cGF5d1dUV3NCaUhL?=
 =?utf-8?B?clRMNzRSdGNCdzBySElVbmRIeGtTdS9MWGY3VXNWT21ST1N0VEFkMFpJaU56?=
 =?utf-8?B?Yi9hRDdlaFpzUXRjc1c5RG1vOWhuK2NwV3YzcXNQVXVqOGtEN056ZnJNOHkw?=
 =?utf-8?B?RGprOS95aWtRbEFvYlZlQkpTVElnM0xHVkxvZlJjY1lkeGRIV1ZJYVpsYXMr?=
 =?utf-8?B?aXowNmNDSUNzaEFIS2YxZFVVY0xzZUJMVnJ6Zk1rNVR5LzVHZFFMZjdoYURZ?=
 =?utf-8?B?YlYvS3Vra2ViSjNwa1Z1WUNtdmg3V2duU2toeFJXcFJJanU0bElZdjlHaksx?=
 =?utf-8?B?bExhcHUvSGxtUkNlUGhETTBpYWFxYjZydm16M29YVUN2WXQ1bkJZanpYL0Z3?=
 =?utf-8?B?NFBMTVNGMVZmZFpQbHNobVNoaCsybkRTL0NwM0kyTEcvSlZ5d0pWeFJoTGVE?=
 =?utf-8?B?VlhUM3U3YjRlaG9sV3V0a0gwMU9DeG9XZTRpYVBvMUE5SjZZUlVOK05IbGE5?=
 =?utf-8?B?ZnN1WHhqTVkycGRMWnpqbC95dUIvUGIzbXBzOFllVjkwdEloMEh4SWwwZ2hx?=
 =?utf-8?B?c0dPL3lqVnBGVndJSER5ZXE3WSsvYlUyV2tSYWtoVnZGRTVLVmw4T0ZkeUZY?=
 =?utf-8?B?UUJCRnhvWFo0YVd5RUsvNFhwVlNVVkhYaWpDSEpzUDRBR3hjb3FzcVl3c2Zj?=
 =?utf-8?B?ZXdQTW1tY21hZ1Vrd3B5aGVWVldrTjR0TWRpSEZFVE9iUDFaQkhmb3Nva1k2?=
 =?utf-8?B?Qk5ERFUyNnBteklsZjJuNnViY21TNFJINFhKZHphd0g3M2RkcWl0T2ZoSzNx?=
 =?utf-8?B?Y0RVYS9yMmhYbzh4ck14bU42Y0FxNk85QUdRYjBvOXQ3cnVnV0h0NEhMMHYr?=
 =?utf-8?B?QlNxQXhXMWJYcVNObERrWjJIRW5vL1JDamNVTWNGcWI3NDNCYjFTVTNDVmJD?=
 =?utf-8?B?aGFXbnVRVlNTeHRpZ0ErQVdwNVNKOWk2QUNpbmxoSTMrN3BhK0pJdmVuMFhZ?=
 =?utf-8?B?bGcxZjNkYTEzWTNyVEhmY1Y4UDJaZHhzTmg1elJRbUZ2VEo2ZkU0QStENHZ6?=
 =?utf-8?B?ckdFUUtFSkx5OTE2RFI0cUtmMXJwbjJjWnNUTzVrL0VyVjdGckZZWlduNE42?=
 =?utf-8?B?UStZdG5HcVhLKzVIZFEyQ2gxQ2Y5SFVEZFhWNTVRZmR2VGQ5ZjhBUGRqcU1J?=
 =?utf-8?B?WGZRYi9DM203U0VJNEZSN1VjdndQK1J1UExmT2VBVlpvVkhWWTJQWDZGWEZF?=
 =?utf-8?B?YUVxQWpkT2lCdDdzMW5aby8xQmRqZTVNQ0NMVGhnSG8xTzkvUnJheGk1NjIw?=
 =?utf-8?B?bTlBd2E4V0MwZ0JBTDM4Z01PakdzNm4yS3JtTDBXUnM3RjVGeTdVUkg5cVBZ?=
 =?utf-8?B?c3JRdVh2MTZoTm5JOUdFc1hWSHVsTG0yTytucDN4YUwzRk1sRWNWenFid2lN?=
 =?utf-8?B?Y20vU0cyYUVIeXZRckZ5S2RWZGYxNXdnVmc2WTJPRU1ub0tlbm1VTDVmWEpo?=
 =?utf-8?B?TDZ2YVlpTWNNZW1hWHNTZlpkWEk0VUt6eHMxMHRicmRIVWlMZmpMLytPeFY0?=
 =?utf-8?B?dUpOU3cwbkRqbVJkcHVnY2ZpbFhYbFRUM2dJbC9yZDczUW85T1kwdlNGUmx3?=
 =?utf-8?B?eGJnc3hYNEZ3dkJOV01CbGxEN05KaG81N0svWDBTTWxyclNkMnVvWk1xaGw1?=
 =?utf-8?B?blkycXVCNDJBc081cnNzZ0thZ3o1THB5ZEtPbldaUDh4Um1nQ0lidW90K2JN?=
 =?utf-8?B?ZVlqZGpoMHlpeUVRbEZaNVhiSE8yRVVHdGI0dSszOE80akd2aVdLQXhOemc1?=
 =?utf-8?B?MENCWU9Cd3d4VHJ3bjdsdnJJQk92ZEhUaGxpNkVjcDVlbkkzRTVaT1ZiaEZz?=
 =?utf-8?B?UHBYdE5idFlGSmo0eGtlQ0V6bERSeGNqVjJOVTV6bzVGdnVCOE5RRzM3NWZQ?=
 =?utf-8?B?NFM1OVh6YThCWmoxbWw2NmtTK2UxU051cWk0ajFVUHEwYWo2a0FFT3pvd3Bw?=
 =?utf-8?B?UzdZVkpURVFMRDBQY1N2YVFWOE4wRks5UnlKektTdkFTbU1BcDcxWFVuNENM?=
 =?utf-8?B?TWdzTmFxaURsaXVIbXJoK1hMSElpZCswaStrQzhVdDhxbzRZVnlHV2hEQTRT?=
 =?utf-8?B?VmcrQzFaemxjeTg5aWlZNUJzODV5cm1oYTQ3U2Nld0hoS0FlSXg5T2E4Nmdr?=
 =?utf-8?B?N1V0WlpyMVZ2V0IwenN3RXNSb3NnNklua2RXZXcwMHpOc3BUMWdJRkF0K1ZF?=
 =?utf-8?B?dHV1U21YSDJjWDYycnRvamhwU01MWTVyTThFZDA3eVIyTkg1VVNmQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed350e19-0712-400e-22c2-08da49b9421a
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 01:42:05.5163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 84SkDcgHaYtLvenmRwpeYu/ybDKLVVrPRHfCYGxFYS+uglJED83DswkRu4XtsR3LYDGlj0/Kg0/mlWSxQMdEfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2451
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-08 at 14:54 +0100, Marc Zyngier wrote:
> On Wed, 08 Jun 2022 13:02:46 +0100,
> Lucas Stach <l.stach@pengutronix.de> wrote:
> > 
> > Am Mittwoch, dem 08.06.2022 um 19:29 +0800 schrieb Liu Ying:
> > > On Wed, 2022-06-08 at 12:56 +0200, Lucas Stach wrote:
> > > > Am Mittwoch, dem 08.06.2022 um 18:50 +0800 schrieb Liu Ying:
> > > > > Now that runtime PM support was added in this driver, we have
> > > > > to enable power before accessing irqchip registers.  And,
> > > > > after
> > > > > the access is done, we should disable power.  This patch
> > > > > calls
> > > > > pm_runtime_get_sync() in ->irq_unmask() and pm_runtime_put()
> > > > > in
> > > > > ->irq_mask() to make sure power is managed for the register
> > > > > access.
> > > > > 
> > > > 
> > > > Can you tell me in which case this is necessary? IIRC the IRQ
> > > > core
> > > 
> > > With the i.MX8qxp DPU driver[1], I see below synchronous external
> > > abort:
> > > 
> > > [    1.207270] Internal error: synchronous external abort:
> > > 96000210
> > > [#1] PREEMPT SMP
> > > [    1.207287] Modules linked in:
> > > [    1.207299] CPU: 1 PID: 64 Comm: kworker/u8:2 Not tainted
> > > 5.18.0-
> > > rc6-next-20220509-00053-gf01f74ee1c18 #272
> > > [    1.207311] Hardware name: Freescale i.MX8QXP MEK (DT)
> > > [    1.207319] Workqueue: events_unbound deferred_probe_work_func
> > > [    1.207339] pstate: 400000c5 (nZcv daIF -PAN -UAO -TCO -DIT
> > > -SSBS
> > > BTYPE=--)
> > > [    1.207349] pc : imx_irqsteer_irq_unmask+0x48/0x80
> > > [    1.207360] lr : imx_irqsteer_irq_unmask+0x38/0x80
> > > [    1.207368] sp : ffff80000a88b900
> > > [    1.207372] x29: ffff80000a88b900 x28: ffff8000080fed90 x27:
> > > ffff8000080fefe0
> > > [    1.207388] x26: ffff8000080fef40 x25: ffff0008012538d4 x24:
> > > ffff8000092fe388
> > > [    1.207407] x23: 0000000000000001 x22: ffff0008013295b4 x21:
> > > ffff000801329580
> > > [    1.207425] x20: ffff0008003faa60 x19: 000000000000000e x18:
> > > 0000000000000000
> > > [    1.207443] x17: 0000000000000003 x16: 0000000000000162 x15:
> > > 0000000000000001
> > > [    1.207459] x14: 0000000000000002 x13: 0000000000000018 x12:
> > > 0000000000000040
> > > [    1.207477] x11: ffff000800682480 x10: ffff000800682482 x9 :
> > > ffff80000a072678
> > > [    1.207495] x8 : ffff0008006a64a8 x7 : 0000000000000000 x6 :
> > > ffff0008006a6608
> > > [    1.207513] x5 : ffff800009070a18 x4 : 0000000000000000 x3 :
> > > ffff80000b240000
> > > [    1.207529] x2 : ffff80000b240038 x1 : 00000000000000c0 x0 :
> > > 00000000000000c0
> > > [    1.207549] Call trace:
> > > [    1.207553]  imx_irqsteer_irq_unmask+0x48/0x80
> > > [    1.207562]  irq_enable+0x40/0x8c
> > > [    1.207575]  __irq_startup+0x78/0xa4
> > > [    1.207588]  irq_startup+0x78/0x16c
> > > [    1.207601]  irq_activate_and_startup+0x38/0x70
> > > [    1.207612]  __irq_do_set_handler+0xcc/0x1e0
> > > [    1.207626]  irq_set_chained_handler_and_data+0x58/0xa0
> > 
> > Ooh, I think this is the problem. The IRQ is not requested in the
> > usual
> > way when a chained handler is added, so this might bypass the
> > runtime
> > PM handling normally done in the IRQ core. In that case this is a
> > core
> > issue and should not be worked around in the driver, but the core
> > should take the RPM reference for the chained handler, just like it
> > does for normal IRQs.
> 
> Well spotted. Could you please give the hack below (compile-tested
> only) a go?

I don't see the splat after your patch is applied.

Regards,
Liu Ying

> 
> Thanks,
> 
> 	M.
> 
> From 1426cadd87717f1d876c7563f2a29b00283a847e Mon Sep 17 00:00:00
> 2001
> From: Marc Zyngier <maz@kernel.org>
> Date: Wed, 8 Jun 2022 14:45:35 +0100
> Subject: [PATCH] genirq: PM: Use runtime PM for chained interrupts
> 
> When requesting an interrupt, we correctly call into the runtime
> PM framework to guarantee that the underlying interrupt controller
> is up and running.
> 
> However, we fail to do so for chained interrupt controllers, as
> the mux interrupt is not requested along the same path.
> 
> Augment __irq_do_set_handler() to call into the runtime PM code
> in this case, making sure the PM flow is the same for all interrupts.
> 
> Reported-by: Lucas Stach <l.stach@pengutronix.de>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Link: 
> https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fr%2F26973cddee5f527ea17184c0f3fccb70bc8969a0.camel%40pengutronix.de&amp;data=05%7C01%7Cvictor.liu%40nxp.com%7C2ce8f74775494461d51808da49566940%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637902932736234542%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=jqe8nsRFWQpVjRl7C6Bgz%2BlwtkaMv%2BKq%2Fui5F1jwf4c%3D&amp;reserved=0
> ---
>  kernel/irq/chip.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
> index e6b8e564b37f..886789dcee43 100644
> --- a/kernel/irq/chip.c
> +++ b/kernel/irq/chip.c
> @@ -1006,8 +1006,10 @@ __irq_do_set_handler(struct irq_desc *desc,
> irq_flow_handler_t handle,
>  		if (desc->irq_data.chip != &no_irq_chip)
>  			mask_ack_irq(desc);
>  		irq_state_set_disabled(desc);
> -		if (is_chained)
> +		if (is_chained) {
>  			desc->action = NULL;
> +			WARN_ON(irq_chip_pm_put(irq_desc_get_irq_data(d
> esc)));
> +		}
>  		desc->depth = 1;
>  	}
>  	desc->handle_irq = handle;
> @@ -1033,6 +1035,7 @@ __irq_do_set_handler(struct irq_desc *desc,
> irq_flow_handler_t handle,
>  		irq_settings_set_norequest(desc);
>  		irq_settings_set_nothread(desc);
>  		desc->action = &chained_action;
> +		WARN_ON(irq_chip_pm_get(irq_desc_get_irq_data(desc)));
>  		irq_activate_and_startup(desc, IRQ_RESEND);
>  	}
>  }
> -- 
> 2.34.1
> 
> 

