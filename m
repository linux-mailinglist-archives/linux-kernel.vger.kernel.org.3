Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030E058126B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 13:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232934AbiGZLzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 07:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbiGZLzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 07:55:42 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60042.outbound.protection.outlook.com [40.107.6.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BA51F608
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 04:55:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cAqwyVHzP2X7k0q03eliYP2L73vKANE4AJ12B87pmaj/23O/GDI6fwq96bom3xiZuebiEAWbg0rJ/7bM92Y5KUq7+XAAbE88JWBesFHbMpnK3YQjT6JfxX0C3m8MVvmA7vv0Z6YTEjVT6dAGd31r1MqlCK7DwkrvCZp5V7/sGPKgJcjxGBQeIDtYs3WSuJAtR28k2+WuMgqyYGmUDvESc/IpO1shd+nN8miZXKqGu+L+13QgDJV/7qOzKkevDPGEF1cRmjAR1zN3tIIggR4eZ7GJIoo4eIfr5vIQccGcLYNBbI4NXzpSqocZdluxPajU0dtsGuZc4P7gj1ySrN/2JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mxoJ+hVTQqq6ajixYXN/zooKDUNTZfDVMZYsUk4PL+I=;
 b=V0DAkACnuCrAS2yLmgpPw3pGXP2TIQw6rI/jkUbtjH97a3jXD04VrFbIR6Shm1lzvDVbqAWL91Gb8XQ43WfpRuH5CjiWDimanhaAyxlksEwK0V3H0DICLVDNKTBwfFlpGH5XMkC+Y4avGCRGbOVGpCQ/5CHQKOM5FwUy3aQLMWbT8YS+olBCZYuZIuRF9VHbmb8D0u29JmQxetSJuqVyymNx3tLfzm/VuUsUN5ypekCvdZj2CKrRrOu5WkloFUffTal3sBrLdbPgGZmFsj3Qs8/tCMJo6QkTmH1algCmbWv6aSr6anLH11cGAvc6wbzDF95ac2YS3wtsNEdwIRX/uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mxoJ+hVTQqq6ajixYXN/zooKDUNTZfDVMZYsUk4PL+I=;
 b=VEUrWAZxL9kMw+oZGzvFYEOIZUvTf7cUSCV99QEQ8DqocHynn1eYNrB/vBgkLEAy9SGTHn/BMncAG9HoQFMgghMSsPJ+mvxWqEfkDCpDo549CN5qdOfwG14TziZ2acCZ2jE8A7DtnHXZxlViJguY6wjMMZA1bhqAvr7blDF3bJM=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB8PR04MB6505.eurprd04.prod.outlook.com (2603:10a6:10:10d::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Tue, 26 Jul
 2022 11:55:38 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5458.024; Tue, 26 Jul 2022
 11:55:38 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
CC:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] soc: imx: imx93-blk-ctrl: set priority level
Thread-Topic: [PATCH] soc: imx: imx93-blk-ctrl: set priority level
Thread-Index: AQHYn9q2XCdDIKjK3k6IbfZ3hVw/662Ox5IAgAAB5WCAAAlPAIAAB53QgAF2NICAADvtQA==
Date:   Tue, 26 Jul 2022 11:55:38 +0000
Message-ID: <DU0PR04MB9417A6E7A7D4A8C7EB55777188949@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220725035931.3988435-1-peng.fan@oss.nxp.com>
 <20220725085050.izj7kmgeuxxug6rh@pengutronix.de>
 <DU0PR04MB9417BBDAE35E932F7601F94788959@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20220725093056.ywr7zo37e4rbrvei@pengutronix.de>
 <DU0PR04MB9417E452C99EA1C4662A06DA88959@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20220726081731.laulutjo4h4tizpx@pengutronix.de>
In-Reply-To: <20220726081731.laulutjo4h4tizpx@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: daaab9cc-fea3-4f79-fbdf-08da6efdc1d0
x-ms-traffictypediagnostic: DB8PR04MB6505:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9vsAlH5UsxE57/9JKL0frGILFIcgjPXC4h19eWYi4bhQzmjH3nxgUXvyPGRpD2IU1m12ae+0HGq8sOXS782+ZF8/tJcEfS60TVhQuvaMdz37wrO8g84FEQdD5n7jXKr7NpkvUqp5uavn3MROgDa512Ys9oovRnbNM4WgfHnRlHIb9oimHWREob8bbVKoOoXy/QE/S2qzMUxSDUWRgaRzWrtA3judZjGwinrjPesP7tL1Y4ofTQs/gHyV0cvTAzq5o21wCRuNPFqK54VkNoFoFlUttvaLkHU6v0cIs8aTuhO9cSXuryrA3+vYHqETI+VhzdkoKFgug8bAwxAFPE+3RlZXl5BlSjUKZJ0niDdgyVz+YPonqjnqt37LmzImupAOhUOxSZ3oUViRl3EGZXgDSSJ6ko1U4y9QPMnTAkXzgzsjMyv8waY9CRssyorId24H6SPfHcah6iGDkRpty91iHkizS6u5GCSjIpYctGkqYkFxvCD6F8xZTk8+7zHjUDjmBhaXClmDmLY5YJq2F1MVFdEWuWax3CpZG9vf++Bo0mf6gSHBDJKJA+m51B3H4Tirr3TdcmrNZJGp5QaTu/uCheUIVpHQ3uMNr7fkabFjsAcQ+4OKrf5vOwFz9dSxhFG7RPtOV4XN58KPI5viqEfDuodXFpj5CGA0QrNRUYNmEoMBUk8nTt0Wo0LNEs2j6sVHzJAaZRNqYA89pKOpIC8XEip6NA2w0520xkeFT/LN4Q/0KDJ8lel0bmr8xkhtE7g7Mi7jLEzIod4OvwQlE/tZX6PEAvv49M6sTCyIk9Rnqz4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(136003)(396003)(376002)(39860400002)(5660300002)(6506007)(71200400001)(7696005)(26005)(86362001)(41300700001)(186003)(55016003)(83380400001)(44832011)(478600001)(33656002)(9686003)(38070700005)(52536014)(54906003)(122000001)(8676002)(2906002)(66446008)(64756008)(66476007)(66946007)(66556008)(4326008)(316002)(38100700002)(76116006)(6916009)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0Mgjnj8Ua6koHYVrNoObOCB8KqD0i7Mi7v9vGs/OhhXWgFG2Pgkn9IbzJWC/?=
 =?us-ascii?Q?Mq/CNNxp4MhMwniC/xAxgeQJwSVLAUa5KVpz9v2r3v3aFbDuXkfMUR93Ayxf?=
 =?us-ascii?Q?PWpCpBuxtYUlMpN2yCj6qdc8pQ9OCFxLolmOxELOz8NGIwGvjSKklag+J9IA?=
 =?us-ascii?Q?JlweXeNt/14STnDy28GD7NsY7uRDdxdJuw/LQrZf6PmRIKM57c27WbJacHLy?=
 =?us-ascii?Q?oZbYCMNXa2INKo/3xKKhDSl5U6z/XbDZtCtgfoCbw+TGyS5TYsx9J+Rvjweh?=
 =?us-ascii?Q?I4KPNLtex6hqwuW4i2GWqgWt7sa2m7yX6J/Si0tv3RlK4qbjOYy10KEwa5KK?=
 =?us-ascii?Q?6Yw9Fqp08e30BzrWtGCnS4iRQ0GmEszZyezfBPABMMlFA/HHNkUO0TeIhQHY?=
 =?us-ascii?Q?359y8b/fEu5A518/IT6WtLwscuWjXPQBIey8+1UBmzdWU+nro9RKJiyqVYHj?=
 =?us-ascii?Q?JbUEyK28yrSw0G483bTQPPDrkCYroh19iOeR7hzQUTlt5oX4KYPWJV8VGPUu?=
 =?us-ascii?Q?cQ+ck/G+mpqRPUvwvrczjsksdla5zi2ykQvxP/bfdye7SUUTA6CJP4YtIHH4?=
 =?us-ascii?Q?Tw0dTbyyFxzX0q+DfahDLkYmWTrgpATcp6XNGmQE3D56zW9Rq2OeRgEnsdxQ?=
 =?us-ascii?Q?wXeN5vTgI3JGCe25dDPE6Q9SGrQ3MVI2SfCJxK+IEar2tzhp9smJ41WUU5Yb?=
 =?us-ascii?Q?MeTa0GuU5d89th8XFNda/z8q25dK23xqVQ3EhnH2XXu1nGl/ffqf2DGjjNMM?=
 =?us-ascii?Q?sSThCMCWIvN/9/yo3X8hoRrSk1owlORb/XrTKpawz30gg+Z9eDW13Jo1no9F?=
 =?us-ascii?Q?lsh7TRqkKJcyC26HTGw7dPora9/spKpio5FfYFGh9Va+l5PZeGz/3czaZ5hs?=
 =?us-ascii?Q?xISn/q3W3xwim4mA08weIAna0m+ju1R89fNokvt03MygSr6ei5DqFQ/L+y7I?=
 =?us-ascii?Q?2rWniYW2LJ0AiFamiWe3Mk/ewqUYMf743fuV5Um7tj7neUrlDHN++eisOOXs?=
 =?us-ascii?Q?tgT9P+lmH5Wblk+gY+MjgP6xJTnl5QYxfwY23xXZ0WxRZq+bUBg49U/hoimI?=
 =?us-ascii?Q?YWX52Rs04WjqzLMbRKToxQ12vnBZdxKRawVmH0pf6PQyXEWDxb5Ok37cp0su?=
 =?us-ascii?Q?kxxbND3l2jLMKw3IPQWIy6TvTTyWVDOgXLmfkaqYw8ncO4NS7bet+yWGdTRK?=
 =?us-ascii?Q?o17RK3Bf6rpFAInQgzs4YK9syUZZYcUaWEwD06vtdkeHLbZuNJKZPD5F7DYo?=
 =?us-ascii?Q?2dxPrIYJUxU4cwLxmD369fqh8/RW8be45VosvlhR+Ca5A0HR3h0utyd29n8p?=
 =?us-ascii?Q?sWvUkToUfCPHT1f/MJi/GdkJXwTdCM5Z82jyKDP92Oz8jraK2hUiHa4xVNzU?=
 =?us-ascii?Q?WybbNFhy/KT984ybUk/jyd+NL6npKiE2lN+bmyKFjlrF8bN6NyrudSCFmEjh?=
 =?us-ascii?Q?600f1DLaQMuXnL8RhjAKUfwYVjITzu4fmwzwDyQr9/sVC/8vSh8CytjkVQhk?=
 =?us-ascii?Q?K0YANJ3sb2DFVpUdKMwW85UlkG/ED+MmwwNYZ2Yy+4qIDzC+ZpGRNtrKceMt?=
 =?us-ascii?Q?GCmlC9VAsDrukD1oYRY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: daaab9cc-fea3-4f79-fbdf-08da6efdc1d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 11:55:38.3357
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b6EfOrQ+5O7m0x82pf9njtnrd4M4wDJq6Pb1pukIdSdZbvmcZJ7g4s6JdN0Ie97tOLbsTfv7wVR7n/4cXVSYmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6505
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH] soc: imx: imx93-blk-ctrl: set priority level
>=20
> Hi Peng,
>=20
> On 22-07-25, Peng Fan wrote:
> > > Subject: Re: [PATCH] soc: imx: imx93-blk-ctrl: set priority level
> > >
> > > On 22-07-25, Peng Fan wrote:
> > > > Hi Marco,
> > > >
> > > > > Subject: Re: [PATCH] soc: imx: imx93-blk-ctrl: set priority
> > > > > level
> > > > >
> > > > > Hi Peng,
> > > > >
> > > > > thanks for the patch.
> > > > >
> > > > > On 22-07-25, Peng Fan (OSS) wrote:
> > > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > > >
> > > > > > i.MX93 mediamix blk ctrl has registers to set QoS(priority) val=
ue.
> > > > > > It support default QoS value and cfg QoS value. Set an initial
> > > > > > value from i.MX design team. If LCDIF/ISI/PXP wanna a
> > > > > > different QoS value in future, they could use interconnect to
> request bandwidth.
> > > > >
> > > > > I need to ask here. Does the iMX93 use the same interconnect as
> > > > > the
> > > > > iMX8M* does?
> > > >
> > > > No. i.MX93 use different interconnect, it has different design,
> > > > the QoS priority register are distributed in blk ctrl.
> > >
> > > Did just the interface change e.g. how you configure the
> > > interconnect or is it a complete new interconnect?
> >
> > It is different interconnect IP. The QoS(priority) register is not in
> > a central place, they are spread in the mix blk ctrl register space,
> > most blk ctrl has QoS. By configure the register in BLK CTRL, the QoS
> > value will flow into the interconnect IP.
> >
> > But compared with i.MX8M, it is simpler.
>=20
> Okay, I got both points. Just to be clear (and sorry for my persistency
> here) it is not just a different IP interface for the NOC?

The interconnect IP is a different IP, not NOC. Before RM public,
I could not say what it is.

>=20
> So to be on the same page with you: On the i.MX93 we now have the
> BLKCTRL settting the interconnect priority and a interconnect setting for
> advanced traffic shaping like bandwidth reservation?

For mediamix, the programming registers is in mediamix blk ctrl.

Regards,
Peng.
>=20
> Regards,
>   Marco
