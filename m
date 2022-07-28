Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE40584314
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 17:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230258AbiG1P2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 11:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiG1P2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 11:28:20 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80041.outbound.protection.outlook.com [40.107.8.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A70F60694
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 08:28:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ca8Gi8Qsvf3ZBm6CCceMjLIc7BrcNzoTX9lDK18TMPgqlXwWd8GIewLdjZJwLdSH6j1FaxqMN+XWk3gJyESnKVHFARxGinNkolqKVVlg86APmdAc7yw2RCdQTKBZ+CQ7ZE+AGV3zAxWMfxrXQnvlc5KdSxs+gqCxa/j3q22u3bmE9V+3xREfUyOFNoR7egV7aRR59F4m1w0vqMQWpRaU/1naVpZKzganCKGWPMhziPMyGrYZmHBZ4DN4ZBBaD4UFK9YukmICuiQ4xt+muBnehcF/uuSuOcG+/v9wrEKX4GWoin2pZZBJGXhmVTCRFjynUH70yNf66ocoT7KbsAeDLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdUdfTxo0votKCLxPo9SZ/TWZ1MtPMsleV1l2CSQZjg=;
 b=dWeoAQvkksioVmkY61r6vFEXfbj6Lg28RsZD/yh7XzTj+e03ss3wcvxcrdkiALMUkWmOVwTXfIVrC1YuXKca23+9g4qE+LgRwgwQFqCEI/gDbPFZLWm83wqVuIWLP3zvmmNat0dr5AKdqUtsxWOB54C+saOuorSAj4/zFmzkAffstBtgyyoikAFq9Dp3y6/3Fmz9WV+ody3ENwvm9ekAme4+kVcbDog9fHBJPIN2kQXCUODTOOvNBj3L9yOlS7BDVtOkchWoYR/0g4PXh57Avjhkw8GgAkWXYtplgd6HggiQhYM+4a5mAHfYrUDqMRkuFgZmyyoecY8+GPJED0xuBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdUdfTxo0votKCLxPo9SZ/TWZ1MtPMsleV1l2CSQZjg=;
 b=o8wOCFsWoC8SOczFN8sLm/Ni9xd0xWQP5EjuatHJGHex+CI48uHtBATWuEZLB5M82rIl2ISaa/AePxMGBe1vKIJwR72nsqfhzoerEXzH5xGFZ03EqEdbC8lqSukzGEoiJd2PHOo7zZsdpiGE9JieiGVKAnatBCCGU0UWzADA5tc=
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by PAXPR04MB9060.eurprd04.prod.outlook.com (2603:10a6:102:223::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.25; Thu, 28 Jul
 2022 15:28:16 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::71b7:8ed1:e4e0:3857]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::71b7:8ed1:e4e0:3857%4]) with mapi id 15.20.5458.019; Thu, 28 Jul 2022
 15:28:16 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     Sean Anderson <sean.anderson@seco.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>,
        "Z.Q. Hou" <zhiqiang.hou@nxp.com>, Biwen Li <biwen.li@nxp.com>
Subject: Re: [PATCH v4] irqchip/ls-extirq: fix invalid wait context by
 avoiding to use regmap
Thread-Topic: [PATCH v4] irqchip/ls-extirq: fix invalid wait context by
 avoiding to use regmap
Thread-Index: AQHYopBXddIttVt6zkGyOalTC33MGK2T52GAgAAAzYA=
Date:   Thu, 28 Jul 2022 15:28:15 +0000
Message-ID: <20220728152815.6h4ytx52ll2gzjj3@skbuf>
References: <20220728144254.175385-1-vladimir.oltean@nxp.com>
 <501b52ba-7691-0263-c007-38174c7e5c22@seco.com>
In-Reply-To: <501b52ba-7691-0263-c007-38174c7e5c22@seco.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dafe0f88-2ab5-4bac-431c-08da70adcacc
x-ms-traffictypediagnostic: PAXPR04MB9060:EE_
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5G7Cj291aezVZQ+NMZiag/w369/gjqxfmfwkalC+vBbAFFnkne9azPwn3Rb4V/Skv8DmBs4XnfbykIU7SMzR8APEsFfzrtKuK56hhzYf7Kig92IxficGxSfT/wzEhtRwidPo4WWsmj0MyujQxY8O3fu0FMddubSEvfop1BNaiio6cywdej+iUItLPpgrYOmTY3HhJg8RdM7o6hVR+eya8meDerjfBJ72EQ7GmrwwIXGkKYVZeWEJ6ylF9DYRAPfxyh857YmNevAEA1nCW0bMvfFIUKPJQIDZejWm8XzgsJghBlPGsleuxNUFbkbNNjkiKMcYvJS8SPqiDZweTyqazdj8C6gOdu6zw6WZYFVbu4uQ/z5sh6c7kXOII6eFo3Ep2yH/rO0Wa/Sr9o+jUosLJnq2ljuGfDD5ySmStiLBatb/HLLvXMboy6m2d5dqjS3/1Q4eoi12QSBeK/W5oOdB5zOQ+yjI5zjdWTejZdiMAz1nrUeTDZsZH6IUAEVeWCd/odpMIocoUmabsb5Ik3vUjRxrxq/798+CVf45BiKtwGASGoDQqePJYzYDLoChxdvR9PREmvqMeeDrON1SynZCTUeQW4noIKlMFudCykV6JRVi4LgvdAje5RAdA+1BBXYay6MOkdiAibpC1Rk7Cqgu91HjqvnHEee0hywfwnNUEU6z+qMONTT+esn3s8STXGO7OP3wjSM1R1jRjkoxC8Zf6omnaWXf2pWxjdWckCqSu/0lChmDljYU4/f3DdnR15Zch1Phym6iv0EcFLz971Z6MpFMT2zltdo5Z96G3MC7kyBACig4ojYX0H1ZjqHcBKKqgUqB7jlNxDDzwalxP1hsQw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(366004)(39860400002)(136003)(346002)(376002)(396003)(1076003)(122000001)(316002)(83380400001)(33716001)(86362001)(6916009)(966005)(54906003)(186003)(8936002)(66476007)(66446008)(2906002)(66946007)(38100700002)(64756008)(66556008)(8676002)(9686003)(6506007)(478600001)(38070700005)(4326008)(558084003)(6486002)(71200400001)(5660300002)(91956017)(44832011)(26005)(76116006)(6512007)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hYg7fERWH9po76GgehhRTdoYyuaMlpqd9ksPdeavx+zmtx1sSo+lx/V6DPwk?=
 =?us-ascii?Q?AgUSKn173tkgr5xemIeD+gsZfVSGTD4BjWBT1KVHxEdMNQOyzEvRuYCZ/5yL?=
 =?us-ascii?Q?2/XE527GSIOC5FPxNclI0nM2en4igyXkHQyYj40RF0EWzvVtSlEZBJvBS4/7?=
 =?us-ascii?Q?mm+kqWOYzClZqTHvyFlk1ug+VztF7CS4g7r/5fmCYFAOTlRzoaglX0hL4D2C?=
 =?us-ascii?Q?ZQchQNndeuk4xoyUQxhOIp1ZM9PmCOWMPIiZN23I8uZfgIde31DVi0S8axaJ?=
 =?us-ascii?Q?w6ZEarnSfSMdFK8CwrNDi61OzAoRNfy95PZUAYs55iUqiQplgJ7pnwkjh0wl?=
 =?us-ascii?Q?yWnFchfgHvaSMh+AQ6nl6gaeoMxi+1DMeOEpZmAnX2/9fFcH0e10yIdYmr/K?=
 =?us-ascii?Q?cmo4tJ5dPgqSpAEawE35Y8JDij2zai3sxoOYiNlG87RQ5MAYYsx11swtSbzY?=
 =?us-ascii?Q?Xxa+cRKFlvkaUe0PrRJmu1QrUQuKydD0U1Q8yYMpQZcbhwQve4wZNuVagnia?=
 =?us-ascii?Q?Hl19JN/D1B1Q8zv5lBP6UAO/Gm8CqWmmACfbttguBKQiFJbI4DU6aWrM8rXj?=
 =?us-ascii?Q?pNRJv4jOSgRPj4yxMfJg3XtAj+ruTh73ruNacfrF/LpYHen/fkoQLqL7nhxU?=
 =?us-ascii?Q?yaUSayKMVuO1CS/K49VMPwFd2Eb5olBnkILOsL/m8i7QZjmmIIDj8TbTCvot?=
 =?us-ascii?Q?DQd72rYfZlu9lgOMX9XzsTKbVTufMCcSy28SJo6INy7MMlR1XyARYuYvtmeO?=
 =?us-ascii?Q?YtB0PlMDdD8wRoyjgxIqBCDLzns8s8WNXp2bnoJs9Z1e39KcY7wJAup1hx3f?=
 =?us-ascii?Q?4qRpsv2QqQ7ZrIYHBVz8zDi5wVMW6NeHnObgh6/5bSUnZN1ULWtZUhVwq+7Z?=
 =?us-ascii?Q?d9dTjz8sgvOKs12JuBVSDr5Kd4GRa/PLedeUQa/a7+G3WZpKxS+BM3VKZUEP?=
 =?us-ascii?Q?dScd5WIGA+4XkAGh7dKJxScydXHsiJfH3giNGFx+y3+guFm1sDVtJ54JGtiH?=
 =?us-ascii?Q?Gw6UeqGNahvfRJ4Dk2D47MDl9zIhvRX3RF4smmegM+GPl4QM06ISVyAbhKkb?=
 =?us-ascii?Q?Y48fBkJho7/nnJlcRAbWjBl5QtHozX0kTjShnOLwZy7wintAJCSE0w6g05qH?=
 =?us-ascii?Q?KEAjPwm56xVypo6iFE4TMlAZWlM6qupUB0alfZarENBBFw05K5px+Wpb+UjV?=
 =?us-ascii?Q?Kd6Xk4JzVkaX6SkYMSbl+4p5ALIJZ2FtkSyBoj0UFvZuT9QZgDh5t8Y+UGWB?=
 =?us-ascii?Q?JYIK8W+vd0s1S+jgQbHtH2b+K6nHMF6GZSYy7sm5FLcdwePEcXGnkSzh06oD?=
 =?us-ascii?Q?JkzLcCE2JW22eO0w5ODc3StClgFt2wnnslPyz1ofZLqSemV3S+nSuBryiFom?=
 =?us-ascii?Q?W+qVOzIR088Upf6SpBYGiavl1oZL9Z3YtSR0jEeWK6zWElUkxx+J+1mVdL5V?=
 =?us-ascii?Q?bZ0m0K/I/65KWeFGJ4HLJzj5XvDL9LWW7nEDVtgZQDfjZ3g52sH1pk71qxWG?=
 =?us-ascii?Q?DTkc7UhPuZ5ARSBscCJhc4jqFf15FmevLWDw1Q/vdU0sw5l5DgZGwUyldmIt?=
 =?us-ascii?Q?G9yYdPVUz3xfLjSmFqKpALz5AzFi3v4Ue58FOzSPwj8RkN3PDGcnZ8IeKy92?=
 =?us-ascii?Q?+Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AA587EFAB584BD4B92338B2FF7D51225@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dafe0f88-2ab5-4bac-431c-08da70adcacc
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 15:28:15.9915
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UazVw4k3xs9K86pecYeBbGuxWJYIRoYp45LgwsB9DqOS5Xg+gSfYz2kmxPUDQeRvncB5hhWFGIpnrBxSTupNrw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9060
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 11:25:23AM -0400, Sean Anderson wrote:
> Could we just use use_raw_spinlock in the regmap config?

That was v2, essentially:
https://lore.kernel.org/lkml/874jz6dcp6.wl-maz@kernel.org/=
