Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB69473E35
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 09:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbhLNIZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 03:25:33 -0500
Received: from mail-eopbgr70041.outbound.protection.outlook.com ([40.107.7.41]:38707
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229703AbhLNIZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 03:25:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGzV1cy/8niLxJ5rmO5usnKTPzmK0W9dS+RRnBCVR3p4PjT2NsZKcbkbjZnpRxYybPRiKWJ6kCAPi9Qb6t+A9O4Y4sO77VL+6Cuu5AcopBgMHBrzZiWbdoMq5h3THkIs+UZ08na7eh+596zn1qzsFf+L9FJEnlGrXeA2aqEZg3wKup89kj7Ou7p8fAcOuDyZFqxx8vWWIZUDu4lNSsdypMLoP7R+xvEwQi09dhdY5LTojLqWNcW5AL/meRhvrXgYHX+QhbrTpZlCi2d0HmyQxcQuGSnd31KVoGZ5RyuO6dSfgVH0+E7z4Q2NO0aP7AGOczpZ9P9JZxuv6LOmLkx2HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GErMA3+3mknPMiGsx4/EcLi+iuQo1tN5d8wCKGKgets=;
 b=Fh6C0ey2p3VfBAIjwY+1wRTglmI0Ol20XLbFsGuq4teXaMsCFw4WVM41QdAGxIKv/8Mf5kbdTT1tec6dX9QGhtnyXtsE7dscuG+bppfmkzLt7ucxj4du24AQ/W8s7N9Ck7hBYGBIvrM0y8CBt5H/hFRfs8YmIHiznEaoGK+x312TdPa1muTd1tqo7+KGyhztGt9i0emRh4sKOIGQwLpfgotRismy2sUZTLBdZIbaV+tUhf48EBM1DVKSHj9rvmSitK5jUI50B/gn8PNeUhpFYZ8iNawKZ1WipyWpE2ngQovlitNZBMDgW3xMxHyVBp9kmQ57EB92Y71jYqdrkg3lhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GErMA3+3mknPMiGsx4/EcLi+iuQo1tN5d8wCKGKgets=;
 b=KyK5oHs4b9lAU9B8WlY+XvzH9fB2ELZOvC73Kgi0bYiE7lnv+z3zXV5V45XW3vtPX2buoZbyVHeQdlXxjCvvg2IjwbSWoLFDwl9T1xwHbknv11phf7hOkZYMdSv0Nu0KfIFV+axpUo0mBM61UgoDylIQB36ENye25JSMhiWKf6I=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU0PR04MB9348.eurprd04.prod.outlook.com (2603:10a6:10:358::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 08:25:29 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::82e:6ad2:dd1d:df43%9]) with mapi id 15.20.4755.021; Tue, 14 Dec 2021
 08:25:29 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>
CC:     "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "van.freenix@gmail.com" <van.freenix@gmail.com>,
        Kees Cook <keescook@chromium.org>
Subject: RE: [PATCH 1/2] clocksource/drivers/imx-sysctr: mark two variable
 with __ro_after_init
Thread-Topic: [PATCH 1/2] clocksource/drivers/imx-sysctr: mark two variable
 with __ro_after_init
Thread-Index: AQHX5rIlvBchCluH8k2pnk3+75X866wqMDWAgAeKc5A=
Date:   Tue, 14 Dec 2021 08:25:28 +0000
Message-ID: <DU0PR04MB94177C2C02E5DC01CE33A5C788759@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20211201125030.2307746-1-peng.fan@oss.nxp.com>
 <1c7ecec9-6a1c-3940-4b4e-e9011c916870@linaro.org>
In-Reply-To: <1c7ecec9-6a1c-3940-4b4e-e9011c916870@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a0aa78f-351c-49b1-aeea-08d9bedb498b
x-ms-traffictypediagnostic: DU0PR04MB9348:EE_
x-microsoft-antispam-prvs: <DU0PR04MB9348412D4A20EDFCC4BE668888759@DU0PR04MB9348.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TprswcLs8BZrsvcuCq+QqI15P/H+Bp+MWu2GBvYDcEfRK1t3uKe8URiYrBNIBXvhl/xfWMc9CHn+pHLJDBEwIZb0p+r4kZJFAcCwFw6FyqS+/ZtAUWY2M77iFMrMDVzgtX6XfGEV7jBmXdRxnTaS0VPyI6Pg9UHsGKeYaFl/grAcc3ZXxTiVC5IDvp0Nuenu+chb2SMDIsPzleO0UwUsc5cM/t+B6QpTWqfdPJBWGokne+Ri51/yw9njViMspjp28VYDCQ1ZVNSrKPckr/jmRgOxEZidZ+Rld4Dy/yfSXwV2rc3lpBKma29+0x830a2XdtymZ2gX3MD9DAURZ/P5W21MHrryNBdoyfHzAt5WD0VYgPW9KSUogTrQ+KoOe3/L3LaFbTiW5h2JZ9WKy3Xw3kf0/f7h/xcR2lNWnQK4BKJqh+7U+Q3I988WBZja0IScMQJ4k78AzCWclalaPlx934GJPlNn0VklVRxJA+5/zw9np813RFzhFUpFO1WKSBCxIUih4TyXaZn/z6y9SDrMCtL2j/BdWxWNXNZpwzPShG5p9J2bD2sCyup4H6i1ABEdub8Z/PmpvKbr0YaFSktbgaoVq7f00PVRAKC6gxwpBo4GQX14NzUdOPu9eCUDWIyssmPbwEzVKUHFOSMLNBjDX0UHNK1LAc+H3BXLTkR9WTw9y26HLNkzUPZjJuSCygCNjSn1uobOSxXQdX3sxgiQ0IeiFu2hBpBJsJ5QoaBOZ9NUq0Zsuq/JtQfy6W3hWI+UlGSGTeF0l53SfY2LOKZMyxunbADcZpxNPxgmUHf5Y/LhXxI6+DgB8MhWMQfl2USJNDI0tpZbk34B4EewBl8n/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(52536014)(9686003)(2906002)(7696005)(38100700002)(8676002)(122000001)(38070700005)(86362001)(7416002)(55016003)(316002)(6506007)(4326008)(508600001)(66476007)(66556008)(54906003)(64756008)(66446008)(66946007)(110136005)(8936002)(83380400001)(76116006)(33656002)(44832011)(53546011)(26005)(5660300002)(186003)(71200400001)(966005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?koi8-r?Q?c4N3QnTKwhGzkVzL1wVVWAgW4tDWEmb8PbWGwW0dKWE6Ybu4SvXDAvTZ5CVYJX?=
 =?koi8-r?Q?pDsgMfiNtq8kBpZOacLHrV1XWCoq6I4CO7BpYOrfnCpcuQPdg4G5PgaUUXdz9e?=
 =?koi8-r?Q?YCjLcCHSYGcQms37K/Z3MXr/fswEtqz1jK5mAXAlcF4SbU9df6KwjZPDOt57vo?=
 =?koi8-r?Q?btNSwlgSYEtr7RfU6feTdv9j9nWDi8AEX0QaSTaa4/uLRCALbc9Oovj2RUuG5l?=
 =?koi8-r?Q?ze/g88VF75SvdM+kX10fIyfrd2l0vSnP4hlhtgv2taXcG6uCukmpp1e5Hyy/9+?=
 =?koi8-r?Q?Z4Pt03ELAZfJ9RtV59vjU3gFYmTShWFSoXUxYCwDxsRcY5/UwHjsVZrPtK7QEy?=
 =?koi8-r?Q?eqywT/lRnN7E7NWqCsqr6B8S9Np/PpW7UOo9vGW/0sGhad7yeFdERXc5DAxUU3?=
 =?koi8-r?Q?obWqyk0zYi7FM+UmcNZyaqIG4kqqEtFnhCW4UPiNYJ7Npng5tpsrUJGXi7Gego?=
 =?koi8-r?Q?hL67cn5bwrkVpH7BTFGtcuiGpNbCzgYT9EIY+E3qVlIo3oLUe3Ln1p7jApJvMx?=
 =?koi8-r?Q?J8yjf3dUbp2SZRVe7kMUu/rBJvGQuGJkrKl0CMMSfG7l90ueHOkMTIp7ZpTDh7?=
 =?koi8-r?Q?JtiDdel7f47bCElotc+Fosn2Cs/hAK5gCAs/Tvw2aMOG9Rnm3A9fVK536jVU+B?=
 =?koi8-r?Q?p4I1vjAwfPKBggrJ3y3NEE8UtgOKLbmB/ffODyZktlOcV4PmbYyHLJ01hHryyN?=
 =?koi8-r?Q?+hG5b+hZiSvVssjKCqyKuKeQToUhL3+RBqDJHkVKFVC72N5bSnY7y19pLeXpWv?=
 =?koi8-r?Q?IZQ1wnnGscCPH2ux1r28w4Mg6xotsY2aYhvXKBH3CUXrXXsyMzrp7qDFbNAuMB?=
 =?koi8-r?Q?nzuSW3zCFOu9W1L+X3C/yDPuT/NCC3/GMlfQaZOeMinMoTZDo0atwNyoS8roJP?=
 =?koi8-r?Q?Bq/YEWwntRjwC7iPZxxqyB7++bJEkJdC8JgjkFhHDNpG9I7EdPvBJ0ZRIldwRn?=
 =?koi8-r?Q?KaTLUqPkzzsZ9oSwWOWaZw7MigxocOP4h9ijlPlpRpmEgZguq9ZL+oqC0J8SOO?=
 =?koi8-r?Q?Zs2KglY0dIR9X/atLK3ixsSkfQip5w9ZTW1wAf5jDLv1QmvS6G+/Nmsr5LK2tg?=
 =?koi8-r?Q?SQR9/jH49Q0+T5j2xYhgoWukjD5mo0LzdIvdTn1ABqqvA2oKZ4rf1qE6ROlQoT?=
 =?koi8-r?Q?+aLClk43EPrrua2xhvfiBgHc8HVCHeIPgH0q2y7Obsh7/xfB8FN61yO3H4G8+C?=
 =?koi8-r?Q?WkrbkaLcIUHE6AqVKfR3dY9mfgPZ6PY05UM1CFu3eamCwdC89pmtqoalOW08PT?=
 =?koi8-r?Q?gcw6CS5V3bI/5N+egE7xmNG/DTvUQ9Irz7BWyZj6HANwypPOO7YeebDGfTnvO1?=
 =?koi8-r?Q?gNIGZdQvQD0mr3AryAVcGGFE5QGdMEwurWELqSvKCmetCQlJBN90qgL70dHNUP?=
 =?koi8-r?Q?8T5sCoU4Qy9A5H3KystWdZbWkN3YxdwXFYwMH//gDqiiMvBZzv6ZDMFEAWrVIL?=
 =?koi8-r?Q?aHztFH22ur6ylpY1ryBivSgwn7App1xilszKOaYHgxexqoB4fEBsuSDVVf3t0V?=
 =?koi8-r?Q?bY92aZYPzP7Qdei1MWVllggKb7MMZRuxfxE7Tef8PvpiVK/l+8FbBvkKxbo4OE?=
 =?koi8-r?Q?iRkySVk0nw=3D=3D?=
Content-Type: text/plain; charset="koi8-r"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a0aa78f-351c-49b1-aeea-08d9bedb498b
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2021 08:25:28.9198
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TslGMDAf0PgOQcvNO+bNDPXg/NPfJb+FJUW/SsUucM/LvCb8EeVELpARK5QYwUjrfngb1QSiwhl3ICILBg6ybg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9348
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

> Subject: Re: [PATCH 1/2] clocksource/drivers/imx-sysctr: mark two variabl=
e
> with __ro_after_init
>=20
> On 01/12/2021 13:50, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > sys_ctr_base and cmpcr will not be updated after init, so mark as
> > __ro_after_init.
> >
> > Cc: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  drivers/clocksource/timer-imx-sysctr.c | 4 ++--
>=20
> Applied, thanks

I not see this patch in your tree.
https://git.linaro.org/people/daniel.lezcano/linux.git/log/?h=3Dtimers/driv=
ers/next

Thanks,
Peng.

>=20
>=20
> --
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.l
> inaro.org%2F&amp;data=3D04%7C01%7Cpeng.fan%40nxp.com%7C380f2f0784
> d247c95a2408d9bb15f12b%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%
> 7C0%7C637746525178346096%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC
> 4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000&
> amp;sdata=3D09OwJe9RQhLb20On45Q1Pb2R%2BdvHcAmqPWRffJCkyTo%3D&
> amp;reserved=3D0> Linaro.org =81 Open source software for ARM SoCs
>=20
> Follow Linaro:
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.f
> acebook.com%2Fpages%2FLinaro&amp;data=3D04%7C01%7Cpeng.fan%40nxp.
> com%7C380f2f0784d247c95a2408d9bb15f12b%7C686ea1d3bc2b4c6fa92cd9
> 9c5c301635%7C0%7C0%7C637746525178346096%7CUnknown%7CTWFpbG
> Zsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> Mn0%3D%7C3000&amp;sdata=3DoupiLK7WS1N%2BWKGzzNjP%2FpErz4QxIjlvC
> 0xIY7s1E7Y%3D&amp;reserved=3D0> Facebook |
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Ftwitt=
er
> .com%2F%23!%2Flinaroorg&amp;data=3D04%7C01%7Cpeng.fan%40nxp.com%
> 7C380f2f0784d247c95a2408d9bb15f12b%7C686ea1d3bc2b4c6fa92cd99c5c3
> 01635%7C0%7C0%7C637746525178346096%7CUnknown%7CTWFpbGZsb3d
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> 3D%7C3000&amp;sdata=3DxepxUkFReOujXx0GAKU%2BvTFzfwjxkIwFj6UndjeOJ
> gY%3D&amp;reserved=3D0> Twitter |
> <https://eur01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Fwww.l
> inaro.org%2Flinaro-blog%2F&amp;data=3D04%7C01%7Cpeng.fan%40nxp.com%
> 7C380f2f0784d247c95a2408d9bb15f12b%7C686ea1d3bc2b4c6fa92cd99c5c3
> 01635%7C0%7C0%7C637746525178356054%7CUnknown%7CTWFpbGZsb3d
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> 3D%7C3000&amp;sdata=3D62SdTlTWr%2FZP2pr7gIx0fGqE30SQR0SKFbOTbPFZd
> %2BQ%3D&amp;reserved=3D0> Blog
