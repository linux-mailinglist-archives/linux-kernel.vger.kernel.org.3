Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF1857FBEA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 11:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234430AbiGYJCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 05:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbiGYJCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 05:02:05 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3340F15705
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 02:02:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MHwyh8Ah1QCZAWPc4F0nvu6qSonzcM380WsFYbP2XEF/nfHHZUPijkZwlBdlaTICM0zNPt4oq1ajRqjwXF0Ay6G8zaepCIthAZFUhQQh5PTqEBkyUfzs7kfbKaaHRrND+epSmXtBezG0AQLiGDvfSSy+MvrrXnEeW5j86R+96T4z0my0igWGduCxXwuEigmXBgnUsD1s5upkUcd227Pkqt+BdC4jnW9jepJxWL/TmLm6mM9crrfD7EaGgHrfTyT6SRaEnezfj6XYmAGHHj7z1xXq1ffZvtqVqo0L+Emmxuydx7Mc+FGV/F06WrsrdgvC64MzxyukmglsLyUur/5c3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ME6lEAeiDtJeOoERcgL04RsDrFxMTnogntlUMTlXw/w=;
 b=fxLtSCu5ZXFVQGK24NxTlSQVQ3cPGOyUYJKe+lkHDvt1L1aN/w/YUgCmH6yG/hDPBvh1iVzYbBSMvbz76d+YgWLq1dG+X9Qow2AWP7sl7bcpaFBlNFOg6xX32KbfQ0nYaMFXuVHjUOgvpRHJJg/4vc5J39WWrLrDcpUhsk6j5n8tIkjLPctGruLdZnGhkLX8YX8oaRK1Mtmmhfw6h93mAOfMXsa4N7yJLJzC9iCgRhpsD5NOyPDEi7wbDI4O5ylVk/ZzT7OxPf20gi+lJCAq9NhndXzd7YT1LVL6efr/7J4fBp/8ZlauvOINjyYh34Sxbn0jHHRoF5mmycD7VWuG1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ME6lEAeiDtJeOoERcgL04RsDrFxMTnogntlUMTlXw/w=;
 b=XANs5otfbGRGDAPVkMekLzKupCe3G1p2Gw/SaSTwd77nPIWqrYXarRTNHFUBDvs0hsKsWkcn05i73bjarDjKNeDyC1D7PGlg76oGLpiyCK1uXaTSHtpxt/OV0K+M1ffrHvjSQpAwmibiSV/TSa/bu5ZrYte03GCnpNdZgEzyRZ0=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS8PR04MB9045.eurprd04.prod.outlook.com (2603:10a6:20b:440::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Mon, 25 Jul
 2022 09:02:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 09:02:01 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] soc: imx: imx93-blk-ctrl: set priority level
Thread-Topic: [PATCH] soc: imx: imx93-blk-ctrl: set priority level
Thread-Index: AQHYn9q2XCdDIKjK3k6IbfZ3hVw/662Ox5IAgAAB5WA=
Date:   Mon, 25 Jul 2022 09:02:01 +0000
Message-ID: <DU0PR04MB9417BBDAE35E932F7601F94788959@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220725035931.3988435-1-peng.fan@oss.nxp.com>
 <20220725085050.izj7kmgeuxxug6rh@pengutronix.de>
In-Reply-To: <20220725085050.izj7kmgeuxxug6rh@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a0b17e33-3bf9-473c-4238-08da6e1c56b6
x-ms-traffictypediagnostic: AS8PR04MB9045:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iVNjR1/o+feZf8QYO/24EsQiKYGPE9Vkvgj/sRlkONbjRuPYAjkV6MmHz2jw5ptR9MwybgrHeebkPA+xdcfY7HysyqAOwSeDDm6GrZ2GwR1M6vhm7YjMQqSDJ+c8G0gpuI6+XKKVhRcaN3J71NUMFszAhmrFKNofRTHN7f7bs7qGcRzT/kLUJ8F1aKMkMjE5DHdq9zlymSxuK8w6MP1NTDYqxa+R6Dw6aEZKVTBykchAp71riqmf0B+4Y9mbuaa/hD0KCeTO8JT5ArYBKtjKKdfVnIDCg6EfwVg3/zsM/oXhoH2bC3eeOeG4zloFFJ6QG6RCRwNe8sHYd9g3i0BM9dYOwg9MskzQwNiJ0hH5jyn1seuNvsX2YLUTs49M711k8QTPjE1pFKXdt/SJcG9iCzcRX5tGHXn6Dfo9Ouz6RJfyumABZZ4joDj2hpF485WGa1CnPyZvINaCXqSegd4SnPWuIO9JQKnRma3ptUC0XpxiMGyemXpeI12cw0cxN959ct/syfCvGHFInGhAciQFX11Nin1Oht8AS/xttsDNTDiczHVDp+tHlepNtWzGP2FlyNGblqxFtTlXB333dKqAIngejcumLbduz0gm2/0UEtdq2Ad2q3OCrvypNjqv3sjHv9lc/xkLkyYEFuEjX/JZoFGCjJf2DRcXwoyl3reMR6O3RYnKZyPdouFX3eTcnJ4yUYVgzBFg+QazvROEh9wSsP27aEuzP6mRhm+Ys9gYpHspX1nqFBIxC88ehn2viLKyLnLJRwcwT/aAlCiOR00e6xoPEiCwhcEj7ZkxQSUMU6NZ+J+2hcPt7+LgZiVLkD9z
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(110136005)(54906003)(316002)(6506007)(7696005)(41300700001)(478600001)(71200400001)(2906002)(76116006)(186003)(55016003)(66946007)(44832011)(66446008)(66556008)(8676002)(5660300002)(64756008)(66476007)(4326008)(4744005)(26005)(122000001)(33656002)(86362001)(38070700005)(38100700002)(9686003)(83380400001)(52536014)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lGQK00hOA8r75Lad4SSLr5latCmr4ZQvb2wu5mIjQw79npDHBRxTeXopMgMC?=
 =?us-ascii?Q?yIEGSsFN1riaOfsuyFo+eis0UMLlZjoduizqx40zxJRapLvcY1x1BHmZv24l?=
 =?us-ascii?Q?/SmFo5nog1Ax7kK3YpyhuYRbk9O9zYRC9uZbJrh7gatEZtPFbL5onxUQmmAX?=
 =?us-ascii?Q?QDVRX9/ZsKc44tqlm/qSX0ONvyE1A63gBB+Y9UEo9FEv8Hb/XtWT50fn2Mbm?=
 =?us-ascii?Q?UhMixfekKAmXOMwVuSLRsPF61awgkJ3Iizd6pU1DRbfllxFkf1V03UkVOFX5?=
 =?us-ascii?Q?qpH0f1q6Eic5GLXfzuKAN03Gh8OjolxY8FAvzrEa5JVue21L2k8NqOeW/+uY?=
 =?us-ascii?Q?ZKQshDsy3fnp0CT1iFmEP3WosK+M96m85vPqFaU4Lq3llAVEB5ITr2I24VGR?=
 =?us-ascii?Q?zvk3cGqaRslTgiVtY5PDDom/Lg8MYQFfqMmcJibrWxlB3Cfs9/Tsm2P6lUi4?=
 =?us-ascii?Q?Aa5ma82gxM6Cce+PwUdV8hULbX8S41lGRauZBq91o7qXl1AmI+aGIiuC5QMq?=
 =?us-ascii?Q?FftPKJ6S5ArshsxANnYsmIEIQrnlCcePPSJMsZQdwY/OHAZZ0btbf/DtIsOq?=
 =?us-ascii?Q?J8KRo1wX1IRB3vr0uWNiuNax+oJpVXmbtVW26hZRpm55Y6x5q9qTVZtCOnEA?=
 =?us-ascii?Q?ZbDSx6Q4xln8v2qtPk05SW44SPSAwNJB2H4hML/O9GBJ2nU0TKoEve//idus?=
 =?us-ascii?Q?9+eX8xsaf02rwC4rMaoFSGizLnqY01SQcXw4gpkwKQuCzgbf/wirwGkA14d3?=
 =?us-ascii?Q?Pd0oB2xVzMMnfWiL47yWJKWvO7GS/av4yNy54ApVHI82O/YNGVr+5DkA9ObN?=
 =?us-ascii?Q?1ejLV+WBFdSrYB/paTkX4Smr7Flsog7snzWstNsfQ+MVqqGGOdRV/84gdTVf?=
 =?us-ascii?Q?GCR6A3AdRQTtXBUsGY1R83UVu2U2+fUN/rLAUKRp/6tpJ/XeoCYIf1z++GDj?=
 =?us-ascii?Q?H75jbBx2FU+9R+ApPqmGZ8r1mK1GFdheB6tgYQkyFMXNMgyD091RLNpKtnSR?=
 =?us-ascii?Q?VTV9U2+eHd1iYnspUJvHvhk3pYXIeq+aTKXY5tDqHMyG5sxONNG+odWLeBBf?=
 =?us-ascii?Q?Ugj8NsW1ob2kmSgeMCyNvGtrzuBhiMPYM7/cReqr1brvgp9bOORR55ylLtHS?=
 =?us-ascii?Q?VPgQqrViV6ok4EOnkfer8Y/pnaXWyaJk5kmHkDL6hKu4iZtW46naqEuHmZrQ?=
 =?us-ascii?Q?MOnouajetSYml28kPveue4Ks1Ay+Bb5zEnCvAk0WXWhtvPI9J5NJf6/ElaYR?=
 =?us-ascii?Q?5bZ+GeOeSHRqCt7nSNFG6Fmet3XviE6VUx7pkYfAFaBXOSc1DdjVOEC5UoZp?=
 =?us-ascii?Q?Ixi2l+5OSJbl6EEIqz45MRBLcRlAedRzxEPjMo5Mmy9tkUUiZiooEJTtD+FE?=
 =?us-ascii?Q?2FaL4oVc4fWokQFWnHOqPPVenHI4uAo34bhbIRkgLvTaWraF3dQ21tXGegyY?=
 =?us-ascii?Q?OEGp0cY7eS4Y1Xg84qdrxkBqLCyTVTjP3yodKuM6+lZUjRintUz5fArAdJ/+?=
 =?us-ascii?Q?VQ7shhg8Werj4Cu6HueHle71hGsz7mQHLBobNsQzQC/hQWI1DqK+sYp040hW?=
 =?us-ascii?Q?sX+FGC+vNBKF1QtcfTQ=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0b17e33-3bf9-473c-4238-08da6e1c56b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 09:02:01.8802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EIga1KrOzPyLbD1gHTVbRmUqGh3rBdXI1gTuGRdY37TWEXG3QlPSz6oh0nCDe9RyMqBNKDKwka3KTPL6c3U7Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9045
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco,

> Subject: Re: [PATCH] soc: imx: imx93-blk-ctrl: set priority level
>=20
> Hi Peng,
>=20
> thanks for the patch.
>=20
> On 22-07-25, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > i.MX93 mediamix blk ctrl has registers to set QoS(priority) value.
> > It support default QoS value and cfg QoS value. Set an initial value
> > from i.MX design team. If LCDIF/ISI/PXP wanna a different QoS value in
> > future, they could use interconnect to request bandwidth.
>=20
> I need to ask here. Does the iMX93 use the same interconnect as the
> iMX8M* does?

No. i.MX93 use different interconnect, it has different design,=20
the QoS priority register are distributed in blk ctrl.=20

The reference manual would be public soon I think, then you could
have more information.

Regards,
Peng.
>=20
> Regards,
>   Marco
