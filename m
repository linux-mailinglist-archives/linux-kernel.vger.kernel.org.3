Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872AA4D57CC
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 02:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345520AbiCKB7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 20:59:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345453AbiCKB7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 20:59:07 -0500
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60067.outbound.protection.outlook.com [40.107.6.67])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FB2F4E;
        Thu, 10 Mar 2022 17:58:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KDtTOM+4pG/WFXLsSXUUDL21fLCawTkm4wioWslp1NcsoAlRoYtmPwEhDO7BDJm02XMa1i2vM653+jlfuZUe3Qmha0SPwh87uJm2mTyhr/Yc8ez0VyL28DXf1lhTQcsP8ngE18p9gpGrkVWCB2kl7MS2L4spb8V3LgiWJIsxoVJkGFwWAdB6TWq6Txd1cdmKNOgLyywUNehZ6xigeSA9saCQUoD7lg/Lhn3r3xcd2vRu2ic6lMW4BZuOQoSY6Ynx4frpfAYdTBHQkKQkbZlFfFW5Sh/Kjf9vV1YcTzaHJNMGOELkoVTX6kp+kJdkSaQ3FZHJ+ztFfr7Awdk/7WjpHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pWcsHYEtAtDSOKlWyKxFMfgssWvtyPa6u57pGYKmiq0=;
 b=XyluITBE6cNxKN1+rQFX1GxxIePl4tJAUzoujVZn9OAszgt78C0ZgaSN/WoeOcW/83RAP0HLb+pFTOXar6vIAL0ZqE2nN0Vo0/cG+M/RDNJCqfk1T/jSVE+wwgRVTt+EBJPQy1gCElBKsHJQDsMwlg1QUXsafrTvh2T722hHri9oCwge4yzrr7E63Q9Wn+czbpLi65wkfgKhgu1/8hVQZO4WwAFBKpy3IjJU2xJve+aplzR329ZNCtZmdeYdukRKI7h0rBBfhOhZl3pXBHEIqVGJsvw/aXz5CUFMmKPWnXD3GP71pPPwIgxyfWrmKu+apOhwdPDgIncJOOGnYJO6ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pWcsHYEtAtDSOKlWyKxFMfgssWvtyPa6u57pGYKmiq0=;
 b=rS4MhYqnfgap9DV+H6I25L7IsDZqZZv7NlEucwmYPr4/CNKpFzN0hGMuOoHDzzeGO058mfYg+bRfkxAuSGw1zAm1vnl0LvAETuB7YCEN9Po6oglrkBLDj9CjuYjeFMaKpJO5Wjhg7AG+pF21guZbNtno86U9Cj38Z4fDVNZ6+6k=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7428.eurprd04.prod.outlook.com (2603:10a6:20b:1d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Fri, 11 Mar
 2022 01:58:03 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::5538:7e34:6843:2bc7%8]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 01:58:03 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
CC:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "mathieu.poirier@linaro.org" <mathieu.poirier@linaro.org>,
        "krzysztof.kozlowski@canonical.com" 
        <krzysztof.kozlowski@canonical.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 2/6] dt-bindings: remoteproc: imx_rproc: support
 i.MX8QM
Thread-Topic: [PATCH V2 2/6] dt-bindings: remoteproc: imx_rproc: support
 i.MX8QM
Thread-Index: AQHYM5nQv0X+1zO/o06U/MCJBJ0v46y5QJOAgAAu4bA=
Date:   Fri, 11 Mar 2022 01:58:03 +0000
Message-ID: <DU0PR04MB9417A914373C466BE76729AB880C9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220309102118.8131-1-peng.fan@oss.nxp.com>
 <20220309102118.8131-3-peng.fan@oss.nxp.com>
 <YiqFJ+1l/h7XCQkN@robh.at.kernel.org>
In-Reply-To: <YiqFJ+1l/h7XCQkN@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 11d50847-ab6a-4387-a7e6-08da030293f3
x-ms-traffictypediagnostic: AM8PR04MB7428:EE_
x-microsoft-antispam-prvs: <AM8PR04MB7428CBDDF14983288A5CE7D5880C9@AM8PR04MB7428.eurprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bNZmlQMRsSKYFTbLr7J/AcVBcYRdz2OvqdEJKADRls+xCY3a4QGMv6P0HYLcfaXkU8cv5VCqx574HUhlewqsM/MqfKfXNhLKIqSyD3DAf3k95ZtS6Rhz3GrF3ren+mkt91ipYaAXILjtMDwEB/zqiHJAdak3EMnk/4X37zvcHWybgNAQMlgNVWS5kI1mUXUiYJIeCzOmQtA/RR4vp73EZhcdBgpIUJjie4ZS0lzqWpK7mn+IvjUDv+HagB/uzurk1/0Y7j2i8mT7/Lhg2cBaV7cf9V0P5hqzjEXCS4ww5Ql7QgYWcSmX4jyyBIdtRx6qZG5Ugei3RAVuFnL7U4u6myCM8u4Qo3irhqhILq0G5NpS2ba5bd0XWAIkDHSZCEOPuOWaOmcB399PX/E8nnP9rdIJFdG6TEl9ApFd609eU/eNI6PTNZPEadwrspuEWc2Zg13utCswCXwz6BxSaY8NIN/e+1B1KOT2XPj9sX18BO+09Dt3q6J+DPG3OTZ9uUvxsa3zdKTTf3kHUjrQHC1fs3jywd2XN6HU5ohLPuY/ubfBl+shRZgIkRb5EW9a2xg0KuLpdnIY2yyRgUGQPIe5NPXFhYXq2DvfSoR7fYPg6XN0HkUhSyASQuhIPe7rHfUlS4BRpwYb/5jknukx2GnpGW8c7bkFlMMQrjheZw3csy2Kwj+EkavsbFgGZyW4smKAaiDhUUNh2aQvzCiz6Ud3Kw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(110136005)(86362001)(8676002)(38100700002)(26005)(76116006)(7416002)(66556008)(66946007)(66476007)(122000001)(54906003)(186003)(4326008)(9686003)(71200400001)(498600001)(66446008)(38070700005)(55016003)(6506007)(8936002)(64756008)(7696005)(52536014)(33656002)(5660300002)(44832011)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?p2RbA3GsgCc6ziXTPZqwDGZx0YQQFOobHFY8LyUsBpcs5YM5gLppgyBht5bO?=
 =?us-ascii?Q?vYcQx7wkQSPy3s0cUhVHaLFwufnS4CUYpa4R4n8kW5IULMfiYmqOuwcGl26N?=
 =?us-ascii?Q?fBprofuKLZB/waMwLlmnBXdlcuF4UHPXRIJz99JKzQkrSD8CQoDQq2ptQfzi?=
 =?us-ascii?Q?4Ty85VkBFSyAuxZ4nWuzK+lH064AF1NSuC0RXzsNj4C8Poibjia+Am2L2EsM?=
 =?us-ascii?Q?TWS5kc3Qnzp1XxKXqlD9uEcn0pRbprz71DancR6/fL2Iu4lBogavUiNipCPL?=
 =?us-ascii?Q?IwWEsi/8d052PvhaSjMjvKIGXy0rpOO3zyTLreZZ3v4115AvgE4bAPnEwMAZ?=
 =?us-ascii?Q?8ry55sST2U0w80kvOjcGPk3Ul++EGFotZIl2UGG00JdKAZ5A24xKm8QdsrAU?=
 =?us-ascii?Q?zDS0s6Hx+1Yo6ttJx1SHzzG/aMDwr64UBR7dE2t1wPiuZOg9QrRgZFmK7F+X?=
 =?us-ascii?Q?jR57gqGOXr816NrZbZKCHcN5NVDBw0u6B5LRHeRAVw1TLZImoVA0KfiX0zfu?=
 =?us-ascii?Q?DcraJPV1iA0tuw3UGmpk4HgNhOkDe9C2Jo4/kPHBwlWVW+hj1Qx0+/MUJ5T3?=
 =?us-ascii?Q?KiXRjBpzx4WqXEYg4RpVyvVKc+9Soy+8ZWP0+cTnhr2OwqznG5ieYsdcbxZP?=
 =?us-ascii?Q?L3dAuXk70VAbyp0K+RO5kIYNsj709dfBiQBV9rAvrHdWl6OpF4qxoN38t3mi?=
 =?us-ascii?Q?siAGc+kp0N037DGAu2w70TJlYpwN7U84jaxRwtQ385pLlaz9xhVgSc91PgWR?=
 =?us-ascii?Q?BIBwU/o1iNa7UbSm8XuDxxbBi/+VA1HPDKAdnOZcgT3vrTkYKPNnJU6RLwjL?=
 =?us-ascii?Q?vLDg70iBqdBgET5wTSR3x4u5gBxH925ac1EuUrLqRrpHgXC0uSIHCjf1TjUl?=
 =?us-ascii?Q?7IzrK4eQd0mJMdR1TN4nGGuBGiy+mHNSNj1PqxsXH8OS03Saf5s59aUjLc5P?=
 =?us-ascii?Q?ig40MPVwESa1ywzaR0JtH43Iac1QcWuW/+TAEPIqsAyuJwlqQpb+gAe8AO1H?=
 =?us-ascii?Q?UEqCIm0/7QiG+3HlgSlETuygpMsGsSCvCQNDDPjRKC9jOrFGiB4QVfDgFsT6?=
 =?us-ascii?Q?qKLryIXk/SiPFEF9qhpoTrVt2TNw1iTV8Qw7YgXlRd8wz8px9ryfLcESANZV?=
 =?us-ascii?Q?LQJue+n62JIDVQUJJHz+c4ErBbjkC2hta14tme5VycPNK23LHuoOFDE6a0N6?=
 =?us-ascii?Q?OaQaFzXv+LhcOeSxMkCs9Z9X3cZJ1X2nG3rBfltlHk2h+qm7b0dwwakEg7ZC?=
 =?us-ascii?Q?NoxEA9UkdBxUy+gh3nVlxIi5j8lYNU0RhPa0vZlg2mBCAxTdx54mfsOYUx70?=
 =?us-ascii?Q?p6pmC8WiCHIHjfFCtf94S+sAJFuaTK4Kdd5jVADB4z+Btp/+p4QA9NPCr7Xd?=
 =?us-ascii?Q?Yji+VDzGI9KPN7J3TWuBty2utxEqFp2rnJ0AwV7OyRRY6DSSyvBEVMlxyamg?=
 =?us-ascii?Q?WKQ6RgkHJvgU+F0QTFL4/Y8HtpQRAGiHGdZN4fweIHhJiN2FLYfQpItGhfmP?=
 =?us-ascii?Q?2xicT987XMbeBDCodb0R1BaAo9m9TLM+yjxJLVPqN/RCJ+MVENmO0l6uCyhF?=
 =?us-ascii?Q?XuY+s/iW03CPDZDCsJvDOkamTmP2uI3ypbTxh9aLg5vlrBkU5GaxXGsvUQO3?=
 =?us-ascii?Q?8w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11d50847-ab6a-4387-a7e6-08da030293f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 01:58:03.2602
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CD5bV27cJspwZTHvjQLdja+3T15O3bqGSgOGLG//QnoVX29ddmfTRu2iQhsroFnwrqdJ+MlMu2QIuGYvT4gb2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7428
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V2 2/6] dt-bindings: remoteproc: imx_rproc: support
> i.MX8QM
>=20
> On Wed, Mar 09, 2022 at 06:21:14PM +0800, Peng Fan (OSS) wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > Add i.MX8QM compatible
> >
> > There are two general purpose M4, so add reg property to indicate the
> > id.
>=20
> Where does the id come from? Is this just an index?

It is software use to identify which is m4_0 and which is m4_1,
just an index.

Thanks,
Peng.

>=20
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > ---
> >  .../devicetree/bindings/remoteproc/fsl,imx-rproc.yaml         | 4
> ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git
> > a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> > b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> > index f25c203dd2f9..41d366cff3cd 100644
> > --- a/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> > +++ b/Documentation/devicetree/bindings/remoteproc/fsl,imx-rproc.yaml
> > @@ -20,6 +20,7 @@ properties:
> >        - fsl,imx8mn-cm7
> >        - fsl,imx8mp-cm7
> >        - fsl,imx8qxp-cm4
> > +      - fsl,imx8qm-cm4
> >        - fsl,imx8ulp-cm33
> >        - fsl,imx7d-cm4
> >        - fsl,imx7ulp-cm4
> > @@ -68,6 +69,9 @@ properties:
> >    power-domains:
> >      maxItems: 8
> >
> > +  reg:
> > +    maxItems: 1
> > +
> >    rsrc-id:
> >      description:
> >        This property is to specify the resource id of the remote
> > processor in SoC
> > --
> > 2.30.0
> >
> >
