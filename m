Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D0357FB6C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 10:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233895AbiGYIbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 04:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiGYIbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 04:31:47 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8B5BA;
        Mon, 25 Jul 2022 01:31:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gIcPqbq359p6gOF7Dk8OUmYfMewD79otTAvKBxfXy6uCeeyzekS8eFq7X0z+diiUS4Bco6MVsAcgoRJRkogvwpC6TeXZf33xVxbbLDbQQKditeDnQ89lCsd/J8SlQnukZWQF9Oqz36PQGox7ZiwAO86txLUJJnulwhfVD6kM8LxPx6bikBj9snYTUXup4vql+cQwjRxCBe/IMqGp2FeCvn2Y7qdE+vM71ASFIo7fDhFgO8xaqY359dLUv/rEgHWNUcx/ccoIQCeWJ1MTxufjG9idVqzN1w5bxVS0l61fw2QO+hBzrsBuIHcBAYpAfJQOabMwRgB+gDn9SVjUyUCXUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dOIjcu7tVr1qrzVwViE4+hLf8GgGwhbJStBBzvbeAWQ=;
 b=i/yx816HJRNBmN0WpFiT2wJ2JTWvLvk1UCyJPIIxv54Sl1XbU6lMksHdtOCKkWHcuZVqirniWCHrUXajj8t7tsLD5FIvoSOTSppBhoVlZpcMfK3w4OV++t/hWSv7EAc4b+S+Vov/1a/Ye3fRBhkJP34vQYifYyMhDb7hzvG9BMo/sKmcj7EBWbEtSeNChZVIWhQzci1ZlQbbE76CJaX5APRfaoybAc7Xob7agnTeuqxsiCs7KmsO0oKVaNH335HutaVhV1Ns8NcAqxh9tUwWraDoTqu2oPJuKFq+mWlG7xMeC2SEhmKxL+Svv7HYvVNR7nH2BQz8YMTqetrws8KhQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dOIjcu7tVr1qrzVwViE4+hLf8GgGwhbJStBBzvbeAWQ=;
 b=S7yq674IqpdppmGpZO6I8v61jGGzu4KFAQ8fXxmnQeQLUmYg+tP2OWtXv+qwimhV8MTVIvqatODL0S/OHW1JIayid71B6jgiG9FbTFW+6durWJPmuoTgMmYHyIe6CBbaJWH35Zwf2mkoV7sd9jZle7UowSmmplYeU9MHsyjLTqE=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AS4PR04MB9241.eurprd04.prod.outlook.com (2603:10a6:20b:4e0::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.24; Mon, 25 Jul
 2022 08:31:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 08:31:44 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Marco Felsch <m.felsch@pengutronix.de>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Sandor Yu <sandor.yu@nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "marex@denx.de" <marex@denx.de>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Markus.Niebel@ew.tq-group.com" <Markus.Niebel@ew.tq-group.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "aford173@gmail.com" <aford173@gmail.com>,
        "paul.elder@ideasonboard.com" <paul.elder@ideasonboard.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>
Subject: RE: [PATCH V4 5/8] soc: imx: add i.MX8MP HDMI blk ctrl HDCP/HRV
Thread-Topic: [PATCH V4 5/8] soc: imx: add i.MX8MP HDMI blk ctrl HDCP/HRV
Thread-Index: AQHYncpy+yRA05cqu0SqDex5yQx9xq2OxMAAgAAA7CA=
Date:   Mon, 25 Jul 2022 08:31:44 +0000
Message-ID: <DU0PR04MB9417A2642EFFDC0FD1B3934188959@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220722125730.3428017-1-peng.fan@oss.nxp.com>
 <20220722125730.3428017-6-peng.fan@oss.nxp.com>
 <20220725082558.prowncgliwfa2egq@pengutronix.de>
In-Reply-To: <20220725082558.prowncgliwfa2egq@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f23437e5-1437-4d25-8b8f-08da6e181b91
x-ms-traffictypediagnostic: AS4PR04MB9241:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6B0rX+G8RLM0ibs+2lnUIxaK55E8IyrJqo8NsTb/zMdG5JTGKdaQ/xCN+CgYxRpUgxaZxOI8271zR/1lmQooXTl3U7QYVble9syhqwaLhIeuEviKHYf+ebEeJqKgxZH5IhmrMiljtd8YZUSl7XfoWRk0GoMny3dnf7J9rTTwwCDQEj9dBRvGHme80dC/SjdzW4xi3Vdrg4l/znVuygDz9BnahyCHMC4IRu9wkys1VqhRkC1MKr4vmO62oDCkXOEgR/hY1PMSNP+DW2ix9tskkTqhb1hy7HXTr14Vrp8/LARPZmlUD8HaSYWweS8oEZrr9urcUMTuRHPzaWbssaCzx0dkORaqXjZhr3/a1tzLFFjSXTN83GCyzUIGXOH1/W0VnI3DWeFoyMPab+7llE+e/w9qKTalhYeTdcqSxugZW+gPYeT9B2lKVfI7l/ZVslzGQbgCjhxyMQiTOR/U11gTBVCwC8A5s8aBuxjWgaWIaXstrDrgusNBFf/Rh8j8haUwQn2wFUw+ffRkIfIXvYhdVnNQoys9sXGvGuPkt318Chm3343eu+WbjDGDFJf0YOxeJf7cjgcy/ovRYBZ8kf98O7ur/hozH4NkssCuO+e7FCte86FMxCQdfE9dwx4pnz0/voux9mHKg70NjpmmFbgprXA0fpMf0Hbkoxbpg8vOeOkbGExh15X6/znGvR7wRFt0XR4R/kjLfjDgCkH4iP+tZrFlAJTOPT3R1iZm82HzkvTxIyssILqc/zBBomGrt3hgN3uMA4a0d60dK/tSh7H8pd2+1sEx6sUk1KNuVgRWGoW8aA9oVIFlSNNq98Z7kEbA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(186003)(83380400001)(66476007)(66556008)(54906003)(55016003)(8676002)(110136005)(71200400001)(66946007)(76116006)(6506007)(66446008)(64756008)(4326008)(7696005)(2906002)(9686003)(26005)(6636002)(33656002)(38070700005)(38100700002)(86362001)(122000001)(5660300002)(44832011)(8936002)(7416002)(316002)(41300700001)(478600001)(4744005)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?U4rmI1ajsVXlNhRiTbftnSwW7Yf5Hx+KUTEmeZTgUHoBF4wvmA9mej9KvX12?=
 =?us-ascii?Q?h6zgu0vGsPMb8v0WZwMkeJwOtmusNSuNotoW623OW+duShIFY/nw32pUOqkV?=
 =?us-ascii?Q?XmdVwrIIgH5E+ak+kYrsrtxeP1eSY5n4yzZdNSM9tHR3x3k+SHdz8uV66Px9?=
 =?us-ascii?Q?UkKmgsPXHrFEbFDlMoxei7zGeySJvOBnYFPa4qKMNq9Jm93AQyCF4VJgJw5F?=
 =?us-ascii?Q?ru86oPKouQX6ZjkeXypn7XRmj4Bm2yCt194jYkvJJFFbjSA18sGUZxiIFmrZ?=
 =?us-ascii?Q?5M3vSrpkSddu7Te6xyx+6chQQHnZjKThbU0JM3d2Vm13vSAkGXoI04BCYylo?=
 =?us-ascii?Q?SGAoM579hVaDOjHd6PHthtOfZfhaHYbXvH9Px58lOzLgYQC+UlNmsbIa2iqM?=
 =?us-ascii?Q?j3+ViHRPZRwtKSvRWzvy6RRFqNvqr91UMDY5immMxMMgBYqKBfMBLV9IOCVa?=
 =?us-ascii?Q?v9Lk6MlHRzev2GVqRPvEP4scZEcsHCDUobUZ3ERcbuwtKWB+64ywlYtMDk36?=
 =?us-ascii?Q?W/0moAlNeUQrr0lja+/0OY08sqQzYea5KFkGgpBA4PNJKkBt1wP6FuLkRiCG?=
 =?us-ascii?Q?4K7X9Oyi2Uej31CaOOoU4GRv/XzoR9oj8d8uiAaQtgaUcHojITDS1KIOf0zy?=
 =?us-ascii?Q?+8pI2zqrppcCoZGTY41DUKue0FEhGapryjfLx0kw5PpDo++TB+pHbjlIokTT?=
 =?us-ascii?Q?pboVhu96t+DPf3CHnNSdE99ZHyd7F1hl0n8KG5xK8ry2YBopCo3wlPBjpi6Z?=
 =?us-ascii?Q?sJmU/Xy+6as9LViNq9WIHPvsE/GpDFYSWHJCI62aFVjBmNQ/Rfcn5pqcgFR0?=
 =?us-ascii?Q?ukElK1E486IoMiXUwPQ/xAuJH5qSkft9F+7e/AHilxD6D1muvGMdrqvLUVh4?=
 =?us-ascii?Q?LS2jRPcD3DfTwNgbtd9z2KESuJjKnEUomnpZNZI8GgKHKUrmkCKjOPmPgLcP?=
 =?us-ascii?Q?yKuQSq6OrdX/wb1K06VOI/bzQclvcNj48ilmRiXjrU6cSnmX69dCL+yATncL?=
 =?us-ascii?Q?O9wR+/TVRggI7dkbNOt4QAzM4RcAuhBfmwh9S2wC6EmNWJVvSEIMZWezg8ax?=
 =?us-ascii?Q?74xAnRtXjmHQnA7YlfeeHGz78XdXg7fJEh4BNdwsYa1IibL/pf5s8xkohT5c?=
 =?us-ascii?Q?0DjMJNXBRbv3W2lhVCnIM+BePDyz7bAIPioOWIte6GM9QRKqE4r6QBSJoLaj?=
 =?us-ascii?Q?rbksXU6tM1+DBXHf9Edxzx0stMAF8zS6NrNdSHJyE9dW7NL5Fvx0P9LhqRuw?=
 =?us-ascii?Q?kwLrYa4vM4tmelZnsKLTULv60gZwkwBpzAWyTJnEMfeTTgikHGikDrpM2+GB?=
 =?us-ascii?Q?2OCddpeZpQeIzWiREPeZQTqAEIhNiqmegYsArblsQrg+p68Hy94+xgg4W8sy?=
 =?us-ascii?Q?oxkxlycrTS3QbleDhs0JoXthtYFoWRLmxKUkVjpxS+4BP5vjGmNY4H/UOa4I?=
 =?us-ascii?Q?QJXCQt0sIM/qLDtoqveMBLBrf9O8acrG3rWXkYi8M2YMU9aOYvQRGOBpa7s6?=
 =?us-ascii?Q?hWbrHMVf4UqjL/NcCyhEFiNmGVkpRRXIJ5kodQElX04LaRk3N1/8hZcrjS+C?=
 =?us-ascii?Q?3maIZfCUThF37RlCi4g=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f23437e5-1437-4d25-8b8f-08da6e181b91
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2022 08:31:44.6671
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5OlHRoRRUwfznJeV1kA8UgXNgvJFVLeJeltQFShlUNcQUVbcXBhmc08+ByODMRfku+4Y9y48Vwscp4Y7ZF0Ddg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9241
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V4 5/8] soc: imx: add i.MX8MP HDMI blk ctrl HDCP/HRV
>=20
> Hi,
>=20
> On 22-07-22, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > i.MX8MP HDMI supports HDCP and HRV, so add them.
>=20
> Out of curiosity what is this HRV? Is it a HDMI receive block? The refere=
nce
> manual has only a few references to a few bits but says nothing about thi=
s
> block.

Loop Sandor to help on this.

Regards,
Peng.
>=20
> Regards,
>   Marco
