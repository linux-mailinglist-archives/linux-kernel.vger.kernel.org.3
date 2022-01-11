Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED3848A67E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 04:39:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346128AbiAKDjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 22:39:14 -0500
Received: from mail-eopbgr60086.outbound.protection.outlook.com ([40.107.6.86]:43334
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S244768AbiAKDjN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 22:39:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EbI7zmg/fVSYXnR2WY8sb8Voj0M59gh/bGhyRfWdh2vipby9pdDHwlhuUzv9PZPtDJI8JeRq9M87BOInYo5W4/v5W7U4CWG+b00RF47WJIKWBEyIxmd/Y70JEIaD5IdkOMKEdkTbC+tUXGkh+AfcAY5EQxjLROD25nXclpOiTErGF9mtGckJI25vsBOlotVn0B2fHCPWWwi+zS5R45xadTrXFSyA8WniGI6+RBHR8+GTJosQshrhT3wHiP53k7g6BPMahy30uG5v4mXDiaMXa2sKleyW7cGUE36O9VsiCudrnt0NmMgZh2h/+Z4GDG33VAQSd6NUrZ3xNwr2tLCLBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xoZwS6imymBz5o0/TsFvpvyQKs35NMR7xr1yzajMGCw=;
 b=FMLxpvyHli52cBRoHD+5C4C0AOCb7m7PHblgOWAwJP+gBLGB2hmYi4XPZ5/3tOXEClBPQzNxpO81b/+rgDt50PUUDw6iSA2ftQLfBlCJqlPMr3wjgpWLczIz+7AU6VLyqTL0p4UlbpetwvsILAYZFp69LtvgLS+d2fjRFctc90r9q8y94lHcVssdJYx8MLMQ8JKTqUD0bbyIW03QCceyuCqn5iAR2Wlg30pPymreT6otQfk/f0N2PRipy7LROUed0lkYF/RSf+BZ8iqQAGAhK6AjjjUiXOSCplmDN05FBgDJPMoctdT5D3TWMT8xzbm1vIQdqYalK3vxLRryJ4Zpog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xoZwS6imymBz5o0/TsFvpvyQKs35NMR7xr1yzajMGCw=;
 b=N3x2HdTETkZmiKpET6ipyJuX+yLKcJQXOcKJdqxSaDpGcUHFNKQHPBkaaRZubThJATgj+mstb5MZ0HazEKoMKLtn5XojL5VJNiedhOTvnmKD+0SXUxMlbUt7tU+Jn58M7xZStvs/hvvQOpSvjUOCFVjE8tZprDMl5K2uq90+I9E=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DU2PR04MB8520.eurprd04.prod.outlook.com (2603:10a6:10:2d3::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Tue, 11 Jan
 2022 03:39:11 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d4dc:8c9a:55d0:81d8%3]) with mapi id 15.20.4867.011; Tue, 11 Jan 2022
 03:39:11 +0000
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
Thread-Index: AQHX8ONNsTFmjnGsD0WJi9r2hmyxN6xdV8+g
Date:   Tue, 11 Jan 2022 03:39:11 +0000
Message-ID: <DU0PR04MB94177F777E854B92C665303488519@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20211214120737.1611955-1-peng.fan@oss.nxp.com>
In-Reply-To: <20211214120737.1611955-1-peng.fan@oss.nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b89eb801-3dd6-4147-d58a-08d9d4b3eead
x-ms-traffictypediagnostic: DU2PR04MB8520:EE_
x-microsoft-antispam-prvs: <DU2PR04MB8520020EE2E8BE9B0154E8EA88519@DU2PR04MB8520.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2449;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cZdORlWOevL3RNK41qot/flY/J/qgh5d1I8+nyXgligoLHkDQ5nqZFSoN1Mcq5ymPeIIF1CsM44O3yKx+tUj1zD07+ScoCBGM8skj34mdhRn94jlv3lQhKWUWw8fBcwsdIkjlRm0+4fz9XKVSFLo080N9Dp+2AeoPWt+k3xBAMFdywo7bsxu2bCv+2TUj4M/Fl5KJZcTHZ4fa1u/81J7VFl7kj3589fIY3G2jzJQmpxMR8fo0hn3Em8eOic3CkvfbBwy0HYarIlijHDv808f4cXQLYi8DSsSng1PEPDbtaSHa1iB2IU8hdGTik/q2tePTxiibYv1B7e6lxVDmUKxM/YWlmmXKtWccZMzadmwMdVBnkuqKO/mx/Ww9uDBuZE6SMTsiqJzYO7W2x/MZOvUUzTVGOjgxbuyTVCndPIwS54dTWCHxaGV+6oycn7sIMFHpleilZUUKb/94d0sNucwjh+XH9EwuP1y/t0WjG6TtA3YXhEQQ1PcOK/F5bj+ZFfW93yHBZq6knqmtvZ6vjbvBxu16s/XKvsgyXZctEzRUxVt5LkIbSr/pJmpmt9doSDLcL+uD6TKjvGBQEkGNldgyc1x8BPFbS9vVYEV1TgXLndDu3JAr07hpT05qmLGqg3F3uIMidd9kBQa5y628XXVB8q/0qLoRIF8BftRDgSXjcP9Dx+sZ4aB+BiQ5oUoRUVhH/K6504ztLzGLztv24VNEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8936002)(44832011)(15650500001)(33656002)(38070700005)(4326008)(186003)(26005)(2906002)(71200400001)(86362001)(6506007)(83380400001)(76116006)(508600001)(4744005)(7696005)(38100700002)(110136005)(9686003)(66946007)(5660300002)(52536014)(8676002)(55016003)(122000001)(66476007)(316002)(54906003)(66446008)(66556008)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?b1pCgFa3oz5BvOlgZcRGWLlIRQIvm6jI1aNEhYhsN3O36JZUbULbaX2thB2G?=
 =?us-ascii?Q?ShQNjBmn2XnFTySyLrN3iY97ERecSdhXf8AwHu2rTYpakWzEE0I3TAJnus9B?=
 =?us-ascii?Q?PLJ9FnOoTt4FDUxOYJ8/lpRigvPLoJdkI0dieImU5HzPOvZYIc/e70dPRjxB?=
 =?us-ascii?Q?au3rFHg15VgciVUratCU4lkpGqLpUCQJmiBtYx8GF3Ta19JSx7ck+4noX39i?=
 =?us-ascii?Q?Zh3cbSbqZe0jZuWUx7rncbPSu5WFikWywoVsQ4p50QlrvqwNnJqNZLfu67NM?=
 =?us-ascii?Q?FHzJnXxxlu/x2TPpNZzYZt71jgFo9I6oU/tq4azyanBwQsQPZ99AkQBgEZCb?=
 =?us-ascii?Q?/+bauOcqgS+6sJNsmTHfLiDdnAAdThigj63EM9gMHOWC+AWl+ee2dZ95n8au?=
 =?us-ascii?Q?mTfXPSMzuCYDlAJ1fKLEitWsPVRR9iG87Cq6CJNJURNC4xDT823fuspIHrtU?=
 =?us-ascii?Q?3uZtjGtLOMxAw3aPQvij31Tyz5O/4mzGpy3LW+QWmGlZJZiXS0SEVBK0SJwc?=
 =?us-ascii?Q?SK35TxwopmoPxjGmMzDN+3Duu0m2Ng1p0H6yIcenLR8zILVdpqOtmcOeFeO7?=
 =?us-ascii?Q?E43zyuIRfG2NoTB6NhY7l9jKYEPek2ofhSdL4p8tEp77Y8n6O3D5cLiqYTBj?=
 =?us-ascii?Q?jVFE/tQoigKTKSbAi1zT16OMq9DVVSmG4Dd4UYRqIkW/OpRDA7eCChgPgD4+?=
 =?us-ascii?Q?K6CIonNzqrWpcYB5UV5mYEFiOymtycnbhtoiVrc6kwm7zUcbogYuUoP/PIQb?=
 =?us-ascii?Q?Dpspn75DFwTapyhHX7YLLMPM/c9O/4m1gvfOC+5EMhAcwvXD17GNYV1QLlvE?=
 =?us-ascii?Q?fFYlZaDgGbDnFGu0sbqWPqaIc4AjDLDbKzjVvY5/J49fGzQqmSU4VQ95jWqV?=
 =?us-ascii?Q?mHBTUtj3fMHeP8ozaWjbv+rlZCBu5ULmXZRlTo5Xw6j5R6oniXHiaxST5/8R?=
 =?us-ascii?Q?BM/V2zOi9B/Sz5X+flwuKPsbL26OkRzuyaE4qrKvyTR4LnO0LQB86PY3abW8?=
 =?us-ascii?Q?8orQRJv9CWNOCYXWajWnZ8MbhMuuYrqOBkhFVZUqoCUZ3S1XXoATUqreK6Wh?=
 =?us-ascii?Q?9hALZbe4ECakEcXAeozlEowF05aUa7yAFM4He/bp1URzx9pkBth9QljdLCOK?=
 =?us-ascii?Q?UWW/Gnk0KCCtlIKuBkyeZYoUY+2vJRJxoV4asbg1HfPBkYbVy7kb2/+bwbkl?=
 =?us-ascii?Q?x7i7CuA8Bxj9k5nExNP5G5NJo7vWGFseO5L1gb4dFxuqjb4yB3Ap++Mir+7i?=
 =?us-ascii?Q?AZKv5NuUjdhRdbJBSnjjnEmjLKUjaDM54cyMeoBCYVxsJQLe2F4pQwb6uTxB?=
 =?us-ascii?Q?wuvrFntaB/mX66C6LfbdcEaz2En9w5eEij5qU459404gchjxI0xpSP/Z2Zi6?=
 =?us-ascii?Q?uimNaB+9RtDyszuoBIbJcQxw1ljEtEfYs8BgGMkbWgk5bUh8dFADLwpBtG3w?=
 =?us-ascii?Q?kaBpRxFYyi0LKQ40DXYv2Aapmfyu7EoM7Co1epDuwXj29QjazeJEqFsGnVtu?=
 =?us-ascii?Q?EbW7PHXAwVB1SflgtQJ1Zcl8Zy0bb9pPNUhwPS3eK3h0AMhBs6w56HCKWpg4?=
 =?us-ascii?Q?owFv60DKaVp+Vwh/r2/ToiTOKEozLlLMXYpvmCGUuwjjtgXhogaOZQip+47W?=
 =?us-ascii?Q?VDQPg7sZmPFhta/ABdBD1GY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b89eb801-3dd6-4147-d58a-08d9d4b3eead
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jan 2022 03:39:11.7146
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: u1Rgrd1Nv9RQVLMefbxvEdeKVzE7hZI0BgT7UKPpWQ6R98rE9E1XqbZEvOJhoaRBk9RVY1Bs8VGnv0YAl09r7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8520
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: [PATCH 0/5] clocksource/drivers/imx: several updates
>=20
> From: Peng Fan <peng.fan@nxp.com>
>=20
> This patchset includes several update of i.MX sysctr and tpm driver.

Ping..

Thanks,
Peng.

>=20
> Peng Fan (5):
>   clocksource/drivers/imx-sysctr: drop IRQF_IRQPOLL
>   clocksource/drivers/imx-tpm: drop IRQF_IRQPOLL
>   clocksource/drivers/imx-tpm: mark two variable with __ro_after_init
>   clocksource/drivers/imx-tpm: add CLOCK_EVT_FEAT_DYNIRQ
>   clocksource/drivers/imx-tpm: update name of clkevt
>=20
>  drivers/clocksource/timer-imx-sysctr.c |  2 +-
>  drivers/clocksource/timer-imx-tpm.c    | 10 +++++-----
>  2 files changed, 6 insertions(+), 6 deletions(-)
>=20
> --
> 2.25.1

