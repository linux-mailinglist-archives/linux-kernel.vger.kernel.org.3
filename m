Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1831A59B802
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 05:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbiHVDgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 23:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232353AbiHVDgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 23:36:33 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2069.outbound.protection.outlook.com [40.107.21.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF39321809;
        Sun, 21 Aug 2022 20:36:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ApRva6ayG410qvLvdIyiCBsolkgQGZXMWer4NIXsHKbvQqIAh2HMwBIO+UJkQT8l4Nu+sfNchTP/lYDE9dI1sG4qpSy6U09eV2CgN0PivjhusWlL+siolHiZt+c4YyTJN8JkNYy8ZMMM4JET4XY6GQik8/W+XHf1ZOWK4U+QOdXP+4d/KpeoCC+wuKmw5OWWhs8BId8yS5wRpYbJGnmwHk+IkB9yNeAPFkTbWhVNcEZqwwlTkCYM+/Rgo75f7274Ag7LQ2opjVLg7NmOcVES4Z/vu+XQ9rBJYhGnCl/eFie7sSeH33MgyIOlxbRZbV4kNEV7nQLr+jLP08fIUED8sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2WX2ENSJSJSV/4PM4p3iI1gEsj5aJeDF7IUlILoGpY=;
 b=bYqHR5TGA3wcu7u2J9T6KsAPA/gHiJ3HqkHmOIHTRpmz1kN7I9FBLvfx1IHRq6u/YUeiv5KlnihQ1yAWXE+PUSrsMBQDXMTmuvu/DUguRaUW1V6fvTd//Puvfquf8WF1aKYd7ESg3e7JKsUGPY0nnvcozh5tFUYw1KBtg9J6/n0Q6YR5IoxGHztN9mupYvve+pZJy72QZXIrC35pj+atoTKk07sKQ4nKXOMPo5eeyqBCJTdaBsIQAFGxmnlqBXwhQDjP9OJKBVb2B4p6+BKT2fOw91nyM10X90O57h6j0nqcDqx4ukuQkvglETyW3T2By9rYrOtxETgUDxzuOZyXxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2WX2ENSJSJSV/4PM4p3iI1gEsj5aJeDF7IUlILoGpY=;
 b=nXXALuZ4C209k0mP0w1076uoTzYw5NmMfFsFOW7mudSyH55oE1n0vP/PVmYFth1xewtv3/ikqURuCMowCJ6jZ72KWC2s1ZmL/FRRybyMkqY55zJa2Tth9BNh8zyk8sMGe3iOeLbIQMAXxVRFjaSPCb/QmpcrrLkMv+6ry92XuqU=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB4311.eurprd04.prod.outlook.com (2603:10a6:209:40::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Mon, 22 Aug
 2022 03:36:28 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%6]) with mapi id 15.20.5546.021; Mon, 22 Aug 2022
 03:36:28 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "laurent.pinchart@ideasonboard.com" 
        <laurent.pinchart@ideasonboard.com>,
        "marex@denx.de" <marex@denx.de>,
        "paul.elder@ideasonboard.com" <paul.elder@ideasonboard.com>,
        "aford173@gmail.com" <aford173@gmail.com>,
        "Markus.Niebel@ew.tq-group.com" <Markus.Niebel@ew.tq-group.com>,
        "alexander.stein@ew.tq-group.com" <alexander.stein@ew.tq-group.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: RE: [PATCH V4 0/8] imx: add i.MX8MP hdmi blk ctrl hdcp/hrv and vpu
 blk ctrl
Thread-Topic: [PATCH V4 0/8] imx: add i.MX8MP hdmi blk ctrl hdcp/hrv and vpu
 blk ctrl
Thread-Index: AQHYncpgcRC5pL/sY0qgJ/MQewbbY62l5PqAgBNCNYCAAU08IA==
Date:   Mon, 22 Aug 2022 03:36:27 +0000
Message-ID: <DU0PR04MB9417C62589EDC6DFE741CA7F88719@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220722125730.3428017-1-peng.fan@oss.nxp.com>
 <b8b01610-ba76-913d-d195-b11ab8925fd9@oss.nxp.com>
 <20220821074111.GN149610@dragon>
In-Reply-To: <20220821074111.GN149610@dragon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6931b398-d0d9-4d15-5996-08da83ef7f1d
x-ms-traffictypediagnostic: AM6PR04MB4311:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nNZGWmrHCr8P0AFwjB2Y8jfWJjZO6+/jykfBefNOHS+GUgmDy/qh46mKK18pA9VViXt9w2X6jAUGwd33+XvKIgWtRTR6+z6aJEg7wPxNK0fNM0/PAnw/JHrYb87RdhPiKYn1ucP74oeWMNJhglKEtV/LserHsp1DdIF4IjV12lUOzLkQ4HmRQkfq094JmGzmBBxKfbl+c2rIYK0RPMxZObAJfR99ZU3aa8bKmvMxwD7PZD6i8LiJ0Wqgy6o7FEC7+8oDuy/4qil0mvEAuClw4XgEea753ubcnGH7HznYhdPMNsWAAl81CxrN8Fasc2fVdGPJpL0x4NAtVSFMLbY4BmdTtQW9GADYfk0JR23GxwNq5mHCcaYAhMM3cWArIuDfBqbt8rvJOxu7zVW8BdyTZIzuLsSHkIBxVUq5BL0TX6jEHisY1J7q0Lsz88+DDdAOgYgVwHjBkHDzIFPFPI+9M+fvdlwYQSQey0n0PLyNWnFyM6OM3xVdu9PsJKM8yaeZKS7WeByaqS90umHohO9byXFl2Sl+3qM5urkFladYfjupHvDe3lJyZ7FyrGmT7oj0XdDmvrX+99rxt8FX19ffSj36I9bakWAp6aDpxe42bMwriTjJBRchS4A6g5hjjcHgo2bW72a3tgdUECb5XV+0q82kzRQKMkBgIVDBvr61EOK9zwBJJGmLrv2ywHXCR6XZ2C1uaWfXyZiN8aqtgwTH7kZUjN512szJ9bHe/kcHlu/rxW2nQHwtwFMvpDYIb5/5SRssToiByD/QXiuRlUVQbQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(136003)(346002)(376002)(396003)(8676002)(4326008)(44832011)(54906003)(52536014)(76116006)(66946007)(66556008)(66476007)(66446008)(64756008)(55016003)(33656002)(86362001)(2906002)(8936002)(7416002)(4744005)(316002)(5660300002)(122000001)(83380400001)(38070700005)(38100700002)(71200400001)(478600001)(41300700001)(6506007)(7696005)(9686003)(26005)(110136005)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?eMg++ioDX1YyYALoCMfPvCkN1cz7d3JQqqV6XQbIJy1gFSOB9pSr804FpqSn?=
 =?us-ascii?Q?IAnKM6dzfNrPG/zLpxQ8kK714rK3UOv+e8XnfHch3DRgKFPpKQZ7heqLjsgw?=
 =?us-ascii?Q?lUGkAmmInT29HATe+EW/yg7FddoRz9nm96AiowHv8AmU3nbRwFF8sRT7z62p?=
 =?us-ascii?Q?2lUiMBvIbq0Sl7Kk0mcHIx2II8yT7SMCnxQ6CURWfv0akMF99QgjlCVGRnA/?=
 =?us-ascii?Q?zWiyBGe1r9aXApFZa+MPYsLD7e62bRzCVHzlLguIWwAJOz2SMkEfOgu5UdDW?=
 =?us-ascii?Q?c6ESv+eNamY+S6e7S67SgmcCrZ8x2qvz4B0pLunL0imh/yj4qPpWgDmmNdIX?=
 =?us-ascii?Q?trHodSBfLcaPC0Av4jVs2yBL+zCBMcLf8F+bn5l+TvwrSNEcKa9psw3mCy1K?=
 =?us-ascii?Q?O4LJd2IG+U2xwfp4gN4wn0LtcHelacee2GRVJgbdpXlb5t4Zx0BdGShuK1+y?=
 =?us-ascii?Q?hRYL+qxZKU13EXVJ/1AUGYePTl0GEahUaBvwjJPhy+F/JXEOw1ut2puUub15?=
 =?us-ascii?Q?cmx2YNrAIVzdpGjmpogrz8aAO9eW1QQ3ga2UKPEcAI/sPB+PvYPKJZD7wrBM?=
 =?us-ascii?Q?ZIFS3nQZmBAnwQmW+RsXo5HL41RBjKFIo7COFPSb28+m0e6H5xFRzd9E2zD7?=
 =?us-ascii?Q?pKDBEckjikxX3E8A7204t9F5kjHz54C2RwfjXspyQIk7ft9DbviWIfoElFtX?=
 =?us-ascii?Q?YO7PW3d6M6SUv0O/PHto/dXQP9NXX0/rAAbpRqdcqliSXk0R0APYkGStwjtK?=
 =?us-ascii?Q?skaV0oM1EsNXp5jGUKySIeB9L6MldgdBdFTrfZPNQfWWY6zb8wkNiX/X37//?=
 =?us-ascii?Q?7Erx0DvV5cfJTuJTOTR/N/e1DJEzMOOwLrH3f+EwVQJxq+Kpfs/1Ib9E2+Sy?=
 =?us-ascii?Q?oAb1JWJ6IalfISfpa5qRuyU5sCp5AokCpKG0YBcXqz3EJWnT7K8Xij3vgDcv?=
 =?us-ascii?Q?ksrlJxZUf+rf6dnrvxbpMEroyU9tTTtFRq3ZRAvJBKB6N4iD5PFKzY1d5boz?=
 =?us-ascii?Q?jDWuSR6vqso+3O+9/8oVNZRBQDJNs8p3nrSYBQ1Nq/B6pFQo0ZZ4D2yaPXd9?=
 =?us-ascii?Q?wRsVnHnW0F5dqAkKS8Tk8Vz9bfE8ik1nq54QBp0Yg0ql0yhfYeS4UHdheIyz?=
 =?us-ascii?Q?NugMSmnLYOYVXbAUnICViNPcEL+14pCTeJqnL7mKwJCuQqSxKJ2L95Fewuh1?=
 =?us-ascii?Q?lF5Zij/t9yDexpS1C2WVz9DLjk8vCT8ojV73ZpVBBKefb+8lkkiJgWkdVCJF?=
 =?us-ascii?Q?5amEwTfqeO9mu4wuz2v8/sLuXzZSjaVR11mwVdWdIGnPvyY/HDrGzxjZBAJ6?=
 =?us-ascii?Q?d3KpZ4YUmW83pHSS7dkiOnvB+6ytwfB3tnsWXo0UWRbQNJsSjgz63X5NeHe3?=
 =?us-ascii?Q?ldzC0Da0sQOVS62MKV/aC/0GJJp2x/zn60OY8DgFkZOstaGxor0ANkkkNtgF?=
 =?us-ascii?Q?547oJ4tjz8ZBxb//2hkJ/E1gnorxiXGVUGXtOuM0GKbuos5+0OLrIcA/mH7C?=
 =?us-ascii?Q?JYNmRT6g5EjCb12rnhr943jFxUCrZbP5hxuS8Fk7Fiak4JNF6i6DCp/KSx1s?=
 =?us-ascii?Q?W5ZEfONwRlhBUfnrMw+ndyojJhjfUc/c6RpXkajQ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6931b398-d0d9-4d15-5996-08da83ef7f1d
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 03:36:27.9086
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o7pkNDTpxuRSF3bokpydiOE0zGB3tHa90PVMcYc9UlmL0Eoa7o9cej+sVsP0b8asyocEeuS09sm9co05upTeSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4311
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V4 0/8] imx: add i.MX8MP hdmi blk ctrl hdcp/hrv and
> vpu blk ctrl
>=20
> On Tue, Aug 09, 2022 at 09:35:17AM +0800, Peng Fan wrote:
> > Hi Shawn,
> >
> > Ping..
>=20
> I think Marco is requesting some information about HRV?

I just added what listed in hdmi blk ctrl. About what HRV is and for,
I could add a bit simple information in commit log in V5, for detailed
info, HDMI(HRV) should have that.

Thanks,
Peng.
>=20
> Shawn
