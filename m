Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37483542F35
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 13:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238041AbiFHLaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 07:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238026AbiFHLaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 07:30:16 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80070.outbound.protection.outlook.com [40.107.8.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4E62B24E
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 04:30:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/1550sCSEX+JlWEUHngp3bkfV3gLBStY9HNuLWXC1FU+2ls7UUXdiJ1gcgV9rWP7d40tfGnn7qSFvW4HVbJnDiEYyy21f4NuvXwPB/PyEMHa73J5bc8z8mp2hqsEYZKdIAI6DjD5T2PvpaD0fFwWcKjvyh+0pP/k5j6yzNLwNejx4+C47CEW1pbY2NRm1ERv9e+15F1H5llq/JqKhhyCjL2/zQwqnWBZrZidIkgbmbp2WN5pTNSQE4fNXDIg4T7g4AQ0+0U11m9LmsDGycX+COoPVnGo42a/Gn0B0g3g2TbX/I61Hks+bgYtp3Xl5y6bQlMgKJGrGOcrx1c6h182g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tUSbmBAnymC274SucRbBTpLSqL81VdAeJOdaYAhNSMc=;
 b=EySQDR7lfK38g041yo40Fu58k6uCxL1dz4bjbHuQJV/cq/Uz+/JT59iDyH7HCnN5s1uDxtTVY3Jza4GX7F3cakCKzIWDjIikp1T44bOZDOvDF0a0Zpqb2PYKIwpwsRXPO6NkTObAsnVjklyCD80jFXKy5aBDZ+WjhQ7Bh/x/DQv02+3nFGdQMfduY2kb3/3KCEHNv6BOBNykguS4GnYElvbXXVvyASwafjX3+cjuG1UykQW36HLZHAXyrYL9/LR5PbtKfbyHVa/m+Tl8mWCQlswWF/g/vcoKDvUDda4UJ7JqxrrRdhb51XoJdtiRFpacebVCliHK+Bjc+7bz+nlm+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tUSbmBAnymC274SucRbBTpLSqL81VdAeJOdaYAhNSMc=;
 b=ReIohgmx/g0d8HNNokg439ghYK+XKxy0hfHl1ssyHp2UlTGOFKxm9oNiFsryZR077Po3oHVso75+oeMNurq9DU0fN/nRm3huRcFqupSyM6dCBFpW4YwVOAsRZXxzLaPg9rCaHewCuXhVazkxGMatzq3Oy+072LtoOuJo1Ge+Sig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by VI1PR0402MB3805.eurprd04.prod.outlook.com (2603:10a6:803:20::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Wed, 8 Jun
 2022 11:30:11 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::3c82:f63b:711a:502%6]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 11:30:11 +0000
Message-ID: <17d3adc7d7d329cab65b54ce71db05bc070872d1.camel@nxp.com>
Subject: Re: [PATCH] irqchip/irq-imx-irqsteer: Get/put PM runtime in
 ->irq_unmask()/irq_mask()
From:   Liu Ying <victor.liu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Date:   Wed, 08 Jun 2022 19:29:31 +0800
In-Reply-To: <2d79719b8670a3693b210af5ab45716dba23999a.camel@pengutronix.de>
References: <20220608105057.2607812-1-victor.liu@nxp.com>
         <2d79719b8670a3693b210af5ab45716dba23999a.camel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR04CA0198.apcprd04.prod.outlook.com
 (2603:1096:4:14::36) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 091a4368-9988-4593-c429-08da49423fc7
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3805:EE_
X-Microsoft-Antispam-PRVS: <VI1PR0402MB38053548B1AAE2A38BB5ACA398A49@VI1PR0402MB3805.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ao1QglYfpjKpFU3pIFDZ/I4knoIUNIJ4hy903ZZ6Hu6KVfRPnJc4o28YGmdvEygPMvhSqM9RpDpRImOmhLzKx/ITGOUoB/oXU7CcBcSYRcN2tDCLMPoAcUSTCjwAUsPR+/AvqoXVID5x1npAaUvrDT3QILMgzPSf6xig2DB8tKmHgybpvPY0Y6Hbw+GJK+E9Vwp7ViEfBlTWrDPJjEFtdD+3oUtMmB9kbTUSDuteKJ/7aEVpLScNLZDV3CixaxsqyeBE83NOM6xMobN7VUPWF8yCoVPTFL2+f7hVI0wi9kh00kzXqEp0EG7BaHwyt4LfBbw1ila/8sCSN1bHONLyvHB10veS5bysUYac1DsWGNja8IRWgaUFrz6SC3vaG+gJ4g9AEQs/rl8dsTucJUtOqBR/HqrbLW3TdyydDva6YgZVBNHnkjwiUDCjXh0xq4OE4vBZq7ICESU+dk12aGy5XPL/7t4osU4TBl1FbOU/M/YGSO3jdRig8CWIxAnDaXf1RfEa5ARVpiO45e/L1iJzwezpK7hAMTmt7NnkPggRFaHKX3mZvQeOi2d2LTjbFa1y6YLX98x8DFyBvZdGxhWJLX99bTCdbUiHir9QE6TH5qCORXTS9s8rn3fWuy1tZ8vDvo0Bo8bRuJCLIWvwzN4BpoDzUDX67w1hrOFRseDvDBL6x1a7riBnV89F0ByRPPVJKnP+c8gTfGDPVc92/vWNytkwQM2LTnfSA7NAwFeoaoU7Uo03tmF9PDIE4NfSqf5nqhtQBXzfUOQCQ9NpvUFk1FczJlQerPwD/QHKZXvMjFOwCKQ6nT9CETrxs1rrb20w
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8676002)(6506007)(66946007)(2616005)(38100700002)(38350700002)(66476007)(6666004)(966005)(52116002)(45080400002)(6486002)(86362001)(4326008)(5660300002)(36756003)(186003)(2906002)(508600001)(66556008)(83380400001)(54906003)(6512007)(316002)(26005)(8936002)(99106002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1V3SExwZi9pRzF3YVpiZStKNkpjUFNZZGp3TzZZSW5aeGYzdHNOelZpYmhY?=
 =?utf-8?B?cFljY1A3QjBaS2VJU3VVMUQwQ0hydkgzRk5BTXRXTk9idlQzb0RiVGN3MW5N?=
 =?utf-8?B?Uk53aUxnVjNCcUhFN0lzOUxtdWkrS1BIbmRTWGlsVjNPZUtqalZFY3hqRTVl?=
 =?utf-8?B?bmlMYmoremVlQThHblBEYzJsNTUwemFWWG9DT21PbmhpVVMrQ1lzZjRlbEp6?=
 =?utf-8?B?N0tHSmJVZ0U3dmszODdGY3c1aUNOZmVUU0lSNXVuOXplQ1FKLzBPNEJzbm83?=
 =?utf-8?B?N2VyanBTYUNVdWs2amxpNmxMbkl5bHE5RUVhcnE0cE10ZHl1cElVRmRPMDU1?=
 =?utf-8?B?M1UrcitVWTU3VThYcmRaNVl2WUEzcTFMcnBhcHFFV0lRVGFsbDZ1WGhabDE5?=
 =?utf-8?B?Uzlxby9yN1ZzaDYwTzNlQXVlY0hlZHJsQ2VSblQwYTlPYkJoYm5RREtoK3ow?=
 =?utf-8?B?bmNqaGJub2x2RFRsZElwOStpTjIzNVdGZFZrQ1huZFY5UXJTZ0dQeTNDSThU?=
 =?utf-8?B?WVZqbExqVFNIM3N6VmdWSjkwUFVOL09uaklBSkE5ZkVMallPWWV0ZmVEdjhV?=
 =?utf-8?B?c2dsNXJ6WGtRSEFHRGkwYVNLNFdSOVFEbDlDMkd6ZmFkOERDT0hXdGZlVDd5?=
 =?utf-8?B?SFF1MUN2YzJ2Rlp2bWlJcWUyZ2tYZlhvdHNYc3NHalVjdGtscTkzemVIdFY4?=
 =?utf-8?B?RDRoaHVyV0NjRit6alpmdFlBeVZwaFUreXJtbDloOTh6OHVMMXhUcjlnUVp2?=
 =?utf-8?B?SmtBZEVLeVRnZHd5RGl5MlE0N3Z5cTBmM29EeUpMdER0ZHNJMk9yMEZFZ2U0?=
 =?utf-8?B?ajMwWmlBc2ZHeHZrZlRiOHlhd3NIejFOSVNsVjhLeHhqbmp0L1NHQzlKbXpL?=
 =?utf-8?B?WnFoMWphY3kyU1p3bjNkRCs4V3YycW5lRWl1ODUyZGZoTGpMVkxZTDdHK216?=
 =?utf-8?B?UURsaFpUNnpXa2xveno5RU5aRjR6aktaVkxsQXVONHBwRUFpM3JZNnVNVjhu?=
 =?utf-8?B?QlFtdkNvQUZ6Nmc5UkIxbitVcHNwVzRuaDllYzI4TWhBM0NMV2xhWlZMYjY3?=
 =?utf-8?B?R0Zxdk0xdWYxOXhyL2FvK0NMTWQrNFhmS1NycU13NjlEUnplNlZWL1MvZHpk?=
 =?utf-8?B?MU5UTzdPNHcwUkJRRHlUNXViWlBqek5XQXIySGRaU094ODlrSVJTNitsRVV2?=
 =?utf-8?B?UXFqUUorVStmeU9mZ1hBcU8xcmZBN0t4ZXlISGJsVkRTM25veUxBanhRZUlX?=
 =?utf-8?B?WkJRZW4vWXAxY2Nnemh1b2k0eHRuTjhQYXEybnBSSm5pN2NVeXIxL084d3hP?=
 =?utf-8?B?eXhNbmtDSEM0ZEduSFZVK1Fqa2RsRVF1NG5ONTJFTzQvRTQ3dHcwdHM0blpl?=
 =?utf-8?B?bEhTc251YUtMY0FXdmxoc1BFTjFnaWllK2xtSGpZajl1M2FRSDd0SlUwallL?=
 =?utf-8?B?akR4Rlp6clFZaHgzZHhzQ0k4ZXpaeFlrSFVZdnhTUFpZZ3F5TE5FNjd4d1cx?=
 =?utf-8?B?cG1Bc1FoMktIaTN0cHJvdDdhQk5sblRUcWxCL09IK1ZkaktsQXpkVUFDQlVo?=
 =?utf-8?B?SUl4bGUvc3lPMmRXaWJJeTdjY0ZDTWpOWU5BRHl4Z0lEQkZKMVFnUXl0UGxj?=
 =?utf-8?B?TjNKa3RSWHgrOGdscVhzYTNCM2ZKaU9rMWJyS1JOZlJYTTV2Z1hReHlZaW5T?=
 =?utf-8?B?S1dVWm9TN2FiT1RESTI5bWUzNmV4VExhRFBVb2szV2hpUlZ6bTR3cHN0Umh2?=
 =?utf-8?B?QVRad2RmOS8zWmlmQVd2OUtrK0ZiUlQyNDk5WXkzdW4yMElod1h5U2Yza09H?=
 =?utf-8?B?dUlqc1JUN0hkUVJiOVB6T1NkTHYrV2tRb0ZDWVRwZEY0RnlhcHp4eWYxMldi?=
 =?utf-8?B?QURWdDlsS3RzZ2cvZXhneExjazVXRWpmMFlUWU5xNktWRDFmRTcrdnpjYUg4?=
 =?utf-8?B?d3dtSnNVeFF6REdjWlRSKzdwQzR1eXhBQUNQdDhmN2kwSW9Ua1BWYWZhK01o?=
 =?utf-8?B?ZDlLK2wwc1d2Rlo0THNXWU5oQWFLTDF6Zk9tZW1rTG96ZDBOTjVORG9LYVVE?=
 =?utf-8?B?ZEFuNEUwY01mQU9tblZXMHVGallYUVAzYUg3RC90UkpoeXRFdFkzQTVTVWl1?=
 =?utf-8?B?eVZBYm1XM08zUFJrOFIrVTBtSWd5MXovT1FXb0VveVlkVTVra1NyZGw5VFRy?=
 =?utf-8?B?VFRqMlJscW52aFIyY1I4aFE4YW9OaDNxaG5sK0R1QWh1Q3gxRUN0K0JoaCtZ?=
 =?utf-8?B?c0FNRnMvdUNSaDltcFZyZjY3NmJHK1E1WFgweXlySkJWRGVhR1ByODRSOTlv?=
 =?utf-8?B?bmNJWkhXNDNwVUNhREx4b2tkNWZhclEyR0Rub1FCU2UrY0daK1IxZz09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 091a4368-9988-4593-c429-08da49423fc7
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 11:30:11.4211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EucobCJW7T/5nmJEBw5XhHDruAVrH3i76ClXaWYPhWgfyixED2cStkhKRp5GIflk6B3R2nZaW+46HmdkdZaW6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3805
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-06-08 at 12:56 +0200, Lucas Stach wrote:
> Am Mittwoch, dem 08.06.2022 um 18:50 +0800 schrieb Liu Ying:
> > Now that runtime PM support was added in this driver, we have
> > to enable power before accessing irqchip registers.  And, after
> > the access is done, we should disable power.  This patch calls
> > pm_runtime_get_sync() in ->irq_unmask() and pm_runtime_put() in
> > ->irq_mask() to make sure power is managed for the register access.
> > 
> 
> Can you tell me in which case this is necessary? IIRC the IRQ core

With the i.MX8qxp DPU driver[1], I see below synchronous external
abort:

[    1.207270] Internal error: synchronous external abort: 96000210
[#1] PREEMPT SMP
[    1.207287] Modules linked in:
[    1.207299] CPU: 1 PID: 64 Comm: kworker/u8:2 Not tainted 5.18.0-
rc6-next-20220509-00053-gf01f74ee1c18 #272
[    1.207311] Hardware name: Freescale i.MX8QXP MEK (DT)
[    1.207319] Workqueue: events_unbound deferred_probe_work_func
[    1.207339] pstate: 400000c5 (nZcv daIF -PAN -UAO -TCO -DIT -SSBS
BTYPE=--)
[    1.207349] pc : imx_irqsteer_irq_unmask+0x48/0x80
[    1.207360] lr : imx_irqsteer_irq_unmask+0x38/0x80
[    1.207368] sp : ffff80000a88b900
[    1.207372] x29: ffff80000a88b900 x28: ffff8000080fed90 x27:
ffff8000080fefe0
[    1.207388] x26: ffff8000080fef40 x25: ffff0008012538d4 x24:
ffff8000092fe388
[    1.207407] x23: 0000000000000001 x22: ffff0008013295b4 x21:
ffff000801329580
[    1.207425] x20: ffff0008003faa60 x19: 000000000000000e x18:
0000000000000000
[    1.207443] x17: 0000000000000003 x16: 0000000000000162 x15:
0000000000000001
[    1.207459] x14: 0000000000000002 x13: 0000000000000018 x12:
0000000000000040
[    1.207477] x11: ffff000800682480 x10: ffff000800682482 x9 :
ffff80000a072678
[    1.207495] x8 : ffff0008006a64a8 x7 : 0000000000000000 x6 :
ffff0008006a6608
[    1.207513] x5 : ffff800009070a18 x4 : 0000000000000000 x3 :
ffff80000b240000
[    1.207529] x2 : ffff80000b240038 x1 : 00000000000000c0 x0 :
00000000000000c0
[    1.207549] Call trace:
[    1.207553]  imx_irqsteer_irq_unmask+0x48/0x80
[    1.207562]  irq_enable+0x40/0x8c
[    1.207575]  __irq_startup+0x78/0xa4
[    1.207588]  irq_startup+0x78/0x16c
[    1.207601]  irq_activate_and_startup+0x38/0x70
[    1.207612]  __irq_do_set_handler+0xcc/0x1e0
[    1.207626]  irq_set_chained_handler_and_data+0x58/0xa0
[    1.207642]  dpu_core_probe+0x368/0xbd4
[    1.207653]  platform_probe+0x68/0xe0
[    1.207667]  really_probe.part.0+0x9c/0x28c
[    1.207678]  __driver_probe_device+0x98/0x144
[    1.207692]  driver_probe_device+0xac/0x140
[    1.207704]  __device_attach_driver+0xb4/0x120
[    1.207716]  bus_for_each_drv+0x78/0xd0
[    1.207727]  __device_attach+0xdc/0x184
[    1.207739]  device_initial_probe+0x14/0x20
[    1.207749]  bus_probe_device+0x9c/0xa4
[    1.207762]  deferred_probe_work_func+0x88/0xc0
[    1.207774]  process_one_work+0x1d0/0x320
[    1.207788]  worker_thread+0x2c8/0x444
[    1.207799]  kthread+0x10c/0x110
[    1.207812]  ret_from_fork+0x10/0x20
[    1.207829] Code: f94002a3 531e7662 aa0003e1 8b22c062 (b9400040)
[    1.207839] ---[ end trace 0000000000000000 ]---

DPU DT node references an imx-irqsteer DT node as the interrupt parent.
The DPU driver adds an irq domain by itself.

[1] 
https://patchwork.kernel.org/project/dri-devel/patch/20220407091156.1211923-6-victor.liu@nxp.com/

Regards,
Liu Ying

> already keeps the chip runtime resumed as soon as a IRQ is requested,
> so why would it be in runtime suspend at mask/unmask?
> 
> Regards,
> Lucas
> 
> > Fixes: 4730d2233311 ("irqchip/imx-irqsteer: Add runtime PM
> > support")
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> > Cc: Sascha Hauer <s.hauer@pengutronix.de>
> > Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> > Cc: Fabio Estevam <festevam@gmail.com>
> > Cc: NXP Linux Team <linux-imx@nxp.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Signed-off-by: Liu Ying <victor.liu@nxp.com>
> > ---
> >  drivers/irqchip/irq-imx-irqsteer.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/irqchip/irq-imx-irqsteer.c
> > b/drivers/irqchip/irq-imx-irqsteer.c
> > index 96230a04ec23..a5eabe71e8ab 100644
> > --- a/drivers/irqchip/irq-imx-irqsteer.c
> > +++ b/drivers/irqchip/irq-imx-irqsteer.c
> > @@ -45,11 +45,14 @@ static int imx_irqsteer_get_reg_index(struct
> > irqsteer_data *data,
> >  
> >  static void imx_irqsteer_irq_unmask(struct irq_data *d)
> >  {
> > +	struct device *dev = d->domain->dev;
> >  	struct irqsteer_data *data = d->chip_data;
> >  	int idx = imx_irqsteer_get_reg_index(data, d->hwirq);
> >  	unsigned long flags;
> >  	u32 val;
> >  
> > +	pm_runtime_get_sync(dev);
> > +
> >  	raw_spin_lock_irqsave(&data->lock, flags);
> >  	val = readl_relaxed(data->regs + CHANMASK(idx, data->reg_num));
> >  	val |= BIT(d->hwirq % 32);
> > @@ -59,6 +62,7 @@ static void imx_irqsteer_irq_unmask(struct
> > irq_data *d)
> >  
> >  static void imx_irqsteer_irq_mask(struct irq_data *d)
> >  {
> > +	struct device *dev = d->domain->dev;
> >  	struct irqsteer_data *data = d->chip_data;
> >  	int idx = imx_irqsteer_get_reg_index(data, d->hwirq);
> >  	unsigned long flags;
> > @@ -69,6 +73,8 @@ static void imx_irqsteer_irq_mask(struct irq_data
> > *d)
> >  	val &= ~BIT(d->hwirq % 32);
> >  	writel_relaxed(val, data->regs + CHANMASK(idx, data->reg_num));
> >  	raw_spin_unlock_irqrestore(&data->lock, flags);
> > +
> > +	pm_runtime_put(dev);
> >  }
> >  
> >  static const struct irq_chip imx_irqsteer_irq_chip = {
> 
> 

