Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F8249C533
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 09:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238403AbiAZIYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 03:24:50 -0500
Received: from mail-eopbgr70072.outbound.protection.outlook.com ([40.107.7.72]:13441
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238378AbiAZIYt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 03:24:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bl3A6OECZEf+YH28UnhtIN1JI9sdNATFJzSBGda/qImDYoU5FEMdDqEmoItCI2C6BP/Po9+vhFfEVYM6NT1sIaaAVrazJ1aXk3gmyrnQz3i59jjbcXeSfr2/D0mUSac+bY9PaYGh4HQiH7uLQc6XiuC85OPv/jq4a1IYH3sqo8J2FcAaEynoDj7wgHbt5v77mE3O3lxyOY6rFG1zcweSuSqTPthyHCNgNHjsoLpsSisjLlcVF5KScDmejBPY323QZcTvuJC0XY37pEfw/kwQrAAgVRFFkeWgJyUmAO9yQ95qNF4LOzzW95VFz6HHJzqsQGJrAfUfzvcR/lqJLjZCGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4RQ6XND5UQez1fDnvKWnWYwTfu9V+PzAyetvjjWwqdo=;
 b=fSqiI+2Eh9aAZ+tNdXfRDwcBDHML6Ic5VJyNNCuqr0rq0ojxB869nIKqkpTp3rVMXTGhG/6x38QeXWTpTGTOS3WUaECx71q4LoqzjQ25b38M11TfI8XCSZQV6+5dIH0xsItZkSxNGfsdqFFIT54UJNHppEn8/Gv9B5SZ5+byiMMUE9gQ3td0fI8s6tKyJBzpZZGBqFjENVgoHkX0YO0IXKZQBYdPcrGpJXq3kC0BC1Ju7QmPaJPB70eoeX49ICNYVIjcUystXAcd20OO/XhyroXNORfZB9wRsZhVLD00u4XlEwRlWq4JoXnUoFq19aOu5G1pPHmDFM+YbTTVA4FJaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4RQ6XND5UQez1fDnvKWnWYwTfu9V+PzAyetvjjWwqdo=;
 b=A2QsmLDYa34+4Ml8UjWx+hkMn5qnW/2eSGDqBrDo0bqBXgA8Qs/9sSH0AwX3wvPpTqDmJga09fcnsIzUtx0V0x7HwPk2kqxDCfiTalZwyVwEYIaVghLPiVSsZXmV3TgaqBO7ioS8rndkia6NEzuYDVB+xGN2VeyoJ7IrjC772zs=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB5526.eurprd04.prod.outlook.com (2603:10a6:20b:9b::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Wed, 26 Jan
 2022 08:24:47 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4930.015; Wed, 26 Jan 2022
 08:24:47 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH 0/5] clocksource/drivers/imx: several updates
Thread-Topic: [PATCH 0/5] clocksource/drivers/imx: several updates
Thread-Index: AQHX8ONNsTFmjnGsD0WJi9r2hmyxN6xdV8+ggBfiokA=
Date:   Wed, 26 Jan 2022 08:24:47 +0000
Message-ID: <DU0PR04MB9417BA24DB13CD6C98BE47CF88209@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20211214120737.1611955-1-peng.fan@oss.nxp.com>
 <DU0PR04MB94177F777E854B92C665303488519@DU0PR04MB9417.eurprd04.prod.outlook.com>
In-Reply-To: <DU0PR04MB94177F777E854B92C665303488519@DU0PR04MB9417.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3ade7557-568c-4568-1587-08d9e0a55062
x-ms-traffictypediagnostic: AM6PR04MB5526:EE_
x-microsoft-antispam-prvs: <AM6PR04MB552695C8897E63E05ED554CF88209@AM6PR04MB5526.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dvqEgZ77b5xHse+OcdW4Mg06SN7ZKBMQOK1ciplcdvrMWkE8kTEjwBkWy+jcG3+rM5MMf9o6tOyP+QARbcbCBoQ4sdQQIKsuKNOIVmF86A54WzA4b0SL5GagHjgjtSz0dVoEQYRF8gMF+r/CFzsC+WlYYZA1Qz5lQHEr5mby+60OWuCbYesbzkcVHPt0+J1kVmSh6kzthFFboQ2fnXeXzp3sBL0/mnpzD5r43e9k/qqeLSojDxQ6W7ZWENxsc7hrxXwaZ3uC7q4TlGj7NMY764Y50MAyhdKL1wr61QLH74eiyv9vGUmAWYoqJRPfxftN3Gw2W3tPaXcYuI9bYHgZcOHmkikJqYIqPHZoKng5Pjx0ffXPKnotciELJVKXQsdSqxgw40DQ16K5A2nyOr2fYXDbxUci45GSkP/+70DZryz1MA5LHjjweGUin4LhnVkf2XHnmqJnb8cy5eP7cFBbgLmLWwTT/aItlVTorvccqWmXhkPyb02XwsZrLx3ViH15QSb1PRptdUriknnT+EdP6ngRrH7sxOSDbMXSSMny7zHm7wAyl4pAKfQYCkKReYdpLXXpH4W3Aorl9FuIKMSuICC6HWHVs9HqQCRQHeBmEGTIM4vvAWkwogcjhCWsCjVQPxqnlDlAUrXg1/ej6CL17soTbELJyRNvlYbfwi8hxh7y4A5uM/zfPMvwOO4KqEDSz+e7iETF+VsX+tM7x0vwhw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(38100700002)(66476007)(66556008)(66946007)(2906002)(8676002)(64756008)(76116006)(4744005)(33656002)(66446008)(52536014)(15650500001)(8936002)(26005)(5660300002)(4326008)(55016003)(44832011)(71200400001)(316002)(9686003)(110136005)(86362001)(7696005)(38070700005)(6506007)(54906003)(508600001)(83380400001)(122000001)(20210929001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?pgoCZBOFnEaNPhqgyGNpVNagfcEKEwXgsJtIzv36ZL3/aamzQKalXGMdBquR?=
 =?us-ascii?Q?vk3HRAPf9hof5rva4C8ZdGHRCYTxPcm6arFbFYIE5N4N8u0WY0NvSkMxa2Ju?=
 =?us-ascii?Q?eyUSy+4hHaoOl3cFNJQAMZqYL3+i1EJagnn2s2pC7X++l2wVDg4MrPfnIz96?=
 =?us-ascii?Q?ALi0HuSqqj2F1ml3kyV6Eiu5hUEmKSVlDNrB3zxe839rVZGbiYxpMKXHRPUD?=
 =?us-ascii?Q?E4W+UhjdqQjiAxLpxwGns0f8rcic3jjh5TrCiC3zqC+VUTQwztDoFDtOeA17?=
 =?us-ascii?Q?2biHsz8JmlzKnzjCj5Oe97qtFjApPcBqwniozvn958QySWf03RU8HLHy3gRO?=
 =?us-ascii?Q?crMNESxBJ8eYgO7O9TaZxLH+JCe57HTbAYFOcympmgwkSLSi1yO7AH/t8fdD?=
 =?us-ascii?Q?Eyl6QOUnFamcv48utEIB3tPhZFndPNr9q5FcETVr/YNK560okcfyCC0ksPk/?=
 =?us-ascii?Q?B7ZHiqowHOdB7df4BPsMCYrlE6rJpTBlTok8cD4kIyV7L0SeQ4kBn+kkgwsA?=
 =?us-ascii?Q?v4nfYNNYRP/12sEqNGXWu/R/sPyrKJt/vhESjHpXsBIUCP/9uQKCBCNphOYm?=
 =?us-ascii?Q?Y6ijqI0a3wMyYhAQrV9YDFzApDYOOkNJ+2lww0hMgKApd3wMb3F+Qm/1I04n?=
 =?us-ascii?Q?BDBbEqjj6pLxJxF1DHbqwxB8+qH20JeQZVS6pR6q1zKpHVEFDR5mIzFuLLlE?=
 =?us-ascii?Q?u93+ThT86vSF3dkzFq++iuvUn39BhA7ZBseOuJ0L8Wb+j3hcTIspXCpQx75R?=
 =?us-ascii?Q?wDmcZEn6hVq3UnAdo6MSc+sQk3wGosHpnvuuSiFbZInNxzHWezRHZ2+6emSO?=
 =?us-ascii?Q?B4OkLqB4Lk/gHbHbaeOdl3K5GtZ8pVNf20nYgZV0EijXBfgnbxk/FtrPPrmN?=
 =?us-ascii?Q?aATGCovm3RbC+sLfk4RR5VHYkR9rP7NDEnApTq2O6pjN5vmFPmx4PuWmUpOj?=
 =?us-ascii?Q?OD9sP9sxRxf3Fxt/FVkFrT7TQpPeZmVoWoJppete6NHltf2dpm99zE1aCcOG?=
 =?us-ascii?Q?g9AYrDoUWBA2YvieXX6T8YCU6pCAKHHCmPsPz09dGzrFSSByisa+rParyn1V?=
 =?us-ascii?Q?ikN0WubFHFh0J5g1HNPTvfnLh7vGzXXSeGBSgqBX9ygxLVTAl42QXI2RpFHk?=
 =?us-ascii?Q?Ly5hbEseC3wo0+uaCw9+s77aP1Fh6KSKAqpuo8zbBEC8siOKJFmfVAge9K04?=
 =?us-ascii?Q?gRYrJyXKbz4JihYsqblexk7Z7UGhWxM/yJZKSiWbXKxFqziN0TBwxQckxSXQ?=
 =?us-ascii?Q?iRG2aHsIVVr/E2IXrPOFZE5IWZqoE9vnabwRHFHuOH7gbQ6x9JiNV67VdA9g?=
 =?us-ascii?Q?5I0n/oQjhzJm/oirHOXb3+iYA5XeVhgIzyj6+Fqmj8u20RBD96//b0tQitYf?=
 =?us-ascii?Q?eVRrQs7IWHsbe9kAmTcqbFA+YdBJ/ngLS3azRXGsY4sG20muoGiuTYP1goCm?=
 =?us-ascii?Q?R82Z7vjJb8YQXbBHSev+cxLn+SWwLoMeQXdi1tJNJZy34eQAVUVCd4eZlh34?=
 =?us-ascii?Q?OwQ40URdE9ljuP5W6NndWqLqGlX4ob1UKxWkrYfIQWMKur2rZLFhwiZfmCO3?=
 =?us-ascii?Q?ep8bJfxuk7ugrib0iEM0wMdYHbEFAeOJ04hRWytdBy7W51TNsEXDcsI40E9f?=
 =?us-ascii?Q?tw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ade7557-568c-4568-1587-08d9e0a55062
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2022 08:24:47.1217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xTv/4Pjd1LS2j1CnBXNqS/WDeMQEADYBih+oRuLlNCb1aIyLHv4ii0u7C0XqKqbZmgueAdVIuZfw3DmsmB/9pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5526
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel,

> Subject: RE: [PATCH 0/5] clocksource/drivers/imx: several updates

Do you have time to give a look?

Thanks,
Peng.

>=20
> > Subject: [PATCH 0/5] clocksource/drivers/imx: several updates
> >
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > This patchset includes several update of i.MX sysctr and tpm driver.
>=20
> Ping..
>=20
> Thanks,
> Peng.
>=20
> >
> > Peng Fan (5):
> >   clocksource/drivers/imx-sysctr: drop IRQF_IRQPOLL
> >   clocksource/drivers/imx-tpm: drop IRQF_IRQPOLL
> >   clocksource/drivers/imx-tpm: mark two variable with __ro_after_init
> >   clocksource/drivers/imx-tpm: add CLOCK_EVT_FEAT_DYNIRQ
> >   clocksource/drivers/imx-tpm: update name of clkevt
> >
> >  drivers/clocksource/timer-imx-sysctr.c |  2 +-
> >  drivers/clocksource/timer-imx-tpm.c    | 10 +++++-----
> >  2 files changed, 6 insertions(+), 6 deletions(-)
> >
> > --
> > 2.25.1

