Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41F4E57AB31
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 02:52:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237280AbiGTAwA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 20:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiGTAv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 20:51:58 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60084.outbound.protection.outlook.com [40.107.6.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB464AD7C;
        Tue, 19 Jul 2022 17:51:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aS5oaoSNWARNZiYeibkiy0MN9Dywv56cnshs+YzJhpzU4teQ05ZuunhRI+4z5Ui2RCGENLV9zQ6+h0BQfd7pYqW7Sc8JHpKMOr7zj1ZtC8i9kBYMFnQ12nRPXcVWWzy0hxnhacU3A8aBfqf+HUfXVGvO/DsDkQOBxpyWBysEqsf5+mEV/0dQ1Div5mvTyiU2d2pnzvd8tI0H2/luP7kK/uwsaNRQwSqYbbjMrfNseBwkcaO3yvenKS0s6ONoRf5vn/6d+gxvQt5l30EzOsuBAcsDwaX3m+7kulNfH3FLiY5cCHodcnwtAttqO2jIgTQU7y4KrcQl6Z7bu/6wq9Gz1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3r5PtMkVin9V4tHn7FGqvZbWFi6U+tzxwFEBffGoNkc=;
 b=fkhGD26sCHKLjxia8ke7gGFDX4JhvJ7eXsJUhXnVVPr+U5KBJbpw4WG5VusQqdIZ0S/hVvrzNB2XWPS3uUO2UtzL12Pd/Z97rRmNH9MD6zuiuxJ3cqj29+Ip9BkCETSS9/MfYE+Wg/nV17O790WVp9RQxGXa5pjyfp7I3WYvGq4sOzzYTQyEXYCqsS4MBG1x6qU7yePDxK31zkWFpD82w8KRl4kJMVRI81DwciAXsJ5Z5m/pW1v8nX3okVxM0KyN1a1lFXDBKi3LBXOBBK3kQG4z4kWsADXJojkVb8/jnqJ7lx6jlIhTbcHKblZqqqDdIJdp1Dh6CuE+Otrq5GJK1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3r5PtMkVin9V4tHn7FGqvZbWFi6U+tzxwFEBffGoNkc=;
 b=cX2vxJQeg2c+xvfEcthjO9X9/yYjR31RanmrIXGgklY0Uj4QG1NBED0qnAeMIL0Ark37YXo93XIlF0wEWYDqliKEejUWH/5YaVWhr94O88SjgOnwBROti7YHd36DHOwBeLYFD7HO3LgCiYrKFAdYkyiwnyCnFXmfcVFdR4d3GaM=
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DBBPR04MB7851.eurprd04.prod.outlook.com (2603:10a6:10:1e1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Wed, 20 Jul
 2022 00:51:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 00:51:55 +0000
From:   Peng Fan <peng.fan@nxp.com>
To:     kernel test robot <lkp@intel.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
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
Subject: RE: [PATCH V3 4/7] soc: imx: add i.MX8MP HDMI blk ctrl HDCP/HRV
Thread-Topic: [PATCH V3 4/7] soc: imx: add i.MX8MP HDMI blk ctrl HDCP/HRV
Thread-Index: AQHYmzNb3ZvM7jnewE2wfGaV417gbq2F06OAgACbVCA=
Date:   Wed, 20 Jul 2022 00:51:54 +0000
Message-ID: <DU0PR04MB94170DA24E82952EAED8F201888E9@DU0PR04MB9417.eurprd04.prod.outlook.com>
References: <20220719055054.3855979-5-peng.fan@oss.nxp.com>
 <202207192320.p1W4jEjD-lkp@intel.com>
In-Reply-To: <202207192320.p1W4jEjD-lkp@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9b2b2c57-dbf8-4578-8cde-08da69ea0ab2
x-ms-traffictypediagnostic: DBBPR04MB7851:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NNc0DA2dSjOD2qVYg0bfOO+QXGc5n3KoGqxxGZ4wtKmBKqXVS/BPbsUdaVJOH2LWCbdjGDq872tO3t8+prczLE4Md4FLQ/2XMZnYXKqRxrr+4E2xNECjmk9LwADf/NNkKbMbHkTS0RdzvtXFB5ELoJ1Zcgae9VeS/bh1bg75CsjWxi7kKnldxa/TpBC5xp2+xC+ltyeb+YtFEw9dzC1htjfGREFufQ7nfyGvh2IClveMa84qjCgFqlNjX2TRCCcHmwQ135+scnluXii4iALD9LlPeXetYLqNye3BfFAt/DE91+W6q71hvapLQ4L/EQXuqgKHikqf3OdN/oCGiP3y//B1CSjVLTdvwm1A9Y6E+QCveW11yJ7l/Juju+4VnN/vaAjsA4AqNWLU1ZMdJ1Bpr75IN/pPiPAbipiaMhl/njlenTCsT7yCIQQbqQtVJWgU3XadAvSR/+cM60kQdL7qUiHRSn+xc2M63fj5xhK/zyE2zfnWERL8oRvU/f6GoeCdwZoXk6OJ6akgB+YdcxqLs5f6stX2lcmwCGdrPenvrwim7eBUyTVBSMzNIUmYnU8+yl2B2Ix4fRS9EzTTUtLLNFIaIDU3KwApPMDMfJYn5uVWE4SbcmWCHiI1Pq47GzI0DiEPqrsRZ5VzllHn8UqlNa72sQoXLqU4yPM09Pfo9m3LL8Xt5G3BbfQQFHK59WU2tIYEcuk2D5MGVQDRjSecFxanULSU1OW8topv3SpTbKm+rNDs0++jINL50x3kMMavMzVreVrZbM3f8rO3uHhjk3t4GDUf2Sn872VKd5cA3Takwp691qxj0I/sbENs5kuv7pz0l26nNHrr9mEZnlXxn0b2hfqBKO1pk+QE7EGF9iBYyl3RPQivpg6PcVYIf/UP
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(376002)(396003)(136003)(366004)(26005)(41300700001)(186003)(9686003)(478600001)(55016003)(2906002)(83380400001)(33656002)(8936002)(7696005)(6506007)(44832011)(7416002)(966005)(5660300002)(52536014)(86362001)(19627235002)(38100700002)(66946007)(316002)(45080400002)(122000001)(8676002)(64756008)(4326008)(71200400001)(54906003)(38070700005)(66446008)(66476007)(76116006)(110136005)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MvCw0mFHMJnuI8W3J8G7FFhofxssRl7lXMtM5+JG2m9iBMCN7mDZogj+qebU?=
 =?us-ascii?Q?fMW4blKBH8ZPOjo2SuuO9yN/q67lZ+vDOn855kUEhDpXB865puQgJ5jBJGcT?=
 =?us-ascii?Q?a+X/7/Z6W5jBBOYEgDkEbLtCz3XHYdoRKSxbd8Yc3ABlPICunCFCB2S65LCK?=
 =?us-ascii?Q?MsJcxqeho1ekeG5PR2cL6cHz0pGJlT4R4lyC4rljmXJqsvxUTBxbz1QiYoaO?=
 =?us-ascii?Q?HBtXPFebBDVFFuF3joeeLoIenK574TH1ABpmyvWB0z8wd06hnXhitNnK5EvY?=
 =?us-ascii?Q?dXF+CujsC0+kZ4veP5teEDhapFXQqY5Rge8JAK/b9Dm6qgmwOfwPGN/iw0am?=
 =?us-ascii?Q?RsXoD9axwzGfCDFwaMMfEpBZbueI+zyxFpOJCKeg0hlOY2acArvaw3TZEVTF?=
 =?us-ascii?Q?mIQ4Iud1rF3kp3+B7eC1lgGsNK42iqk+ZlsNDtBnI7vEO+aWTHUnld1kNSF6?=
 =?us-ascii?Q?MCHBz7sMHi0up82TbR4vzKwVaaneZ1Wc+kFiiK/lMz6+sBPqNTl/z6245Ii5?=
 =?us-ascii?Q?bYo5LZzYteOrLiJMwL23K4EmT/ySbF3DjQXvClzoKbrXeyHW9kX72LkwSybF?=
 =?us-ascii?Q?i5/HTUmmDagml5C47FUuPbnVC6d1Vvm0E8dg/JCamnD5tCq+0AnOyN0R7O2U?=
 =?us-ascii?Q?I7P6Tycafffqi/VQdax0vszTgkGa6N2BL16k0EB4IWO0r0X6PYsrALS0cRdM?=
 =?us-ascii?Q?B1f9MoEpIQdTQG7FWVgQW65DpS/jym1HNavd8dhZjSLjp8cMwu90M20agol4?=
 =?us-ascii?Q?NHK+7DmA4S/CxY2D+Mp39kABRImlZUvHImXBPzcV/K/SlaqlLFgRiMFnBCBO?=
 =?us-ascii?Q?MDfENGp6s0YLv06/ACQSB6NsPG8JQ+DmoFXdUKj1rGkK5cjlj7Mh5nzb/DMN?=
 =?us-ascii?Q?CwUvBAytU7brPEyTlWb54EOHRQybz98WEb7UuztT4fdYuK3Du5k48JeojsIj?=
 =?us-ascii?Q?ZDtffyRF8ivrZIY2RWLFTH/Brmh4xjeyZ9BjLD3A9Cmf7rIuRHHSdgwbJraE?=
 =?us-ascii?Q?UPUVe8YNrFtx3ulOWIMVZ1lWu1Zca5k7BKl19Z0zyYRypakroLHIJuHdlsa3?=
 =?us-ascii?Q?1A7EdwQl2tgv3xB/kdJ+OeuirXWx+T6lJwzlpxcDNF85tvS3R439z7Fln5Fy?=
 =?us-ascii?Q?TD31W2UkGXGZhTUQmLpXOv74YSmprLWf+jGCINgT3ugxLO92sHUwI+BNEpUJ?=
 =?us-ascii?Q?swl/pOpX+8TtIEXTQ89gL6s+l+BBwHAhCY6xyisRyurzPVbm84oFwHMnI1bp?=
 =?us-ascii?Q?TFH8HMKdNUyR2GEveKlgmjAbwyChs2mHT+9lyP9kMxu2Ku1VlSbQPdnCNH2S?=
 =?us-ascii?Q?lxVrNBjmZS3dwLCXFEsLAo/wW7ns7qJwQ9QJBvLSySHREidntaT0mMvtkU4U?=
 =?us-ascii?Q?w3BlUgnt0Z7QGifTb0RbQCe9u4iDHQgol2nzyYy8DI5O6uKElBwKK4SZkzie?=
 =?us-ascii?Q?OxLkT65FTiRaryXd7VOt/67HCaJNfRQLwf+zaJJJv9KEUHFwc6ypCc3h5uBj?=
 =?us-ascii?Q?sAcjLpqxx80Vu211VLrfwFraY3zSmLvYl1iVQ27xUd8Ke+Tsa+ygHZXK4n5j?=
 =?us-ascii?Q?MQUh+4KG+gJlelx9Lbs=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b2b2c57-dbf8-4578-8cde-08da69ea0ab2
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 00:51:54.8927
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L1hlzCWJkYyzfdQZB3jNiFUpJvO/FE8uWsMic6PDYBbiAkt/kAFb7wkDX2KeFvcD6kyugt8YU8GV/xmbWb+h0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7851
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Subject: Re: [PATCH V3 4/7] soc: imx: add i.MX8MP HDMI blk ctrl HDCP/HRV
>=20
> Hi "Peng,
[Peng Fan]=20

As I wrote in cover-letter, this patch depends on the other patchset, so
it is expected if directly build this patchset.

Regards,
Peng.

>=20
> Thank you for the patch! Perhaps something to improve:
>=20
> [auto build test WARNING on shawnguo/for-next] [also build test WARNING
> on linus/master v5.19-rc7 next-20220719] [cannot apply to robh/for-next]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit-
> scm.com%2Fdocs%2Fgit-format-
> patch%23_base_tree_information&amp;data=3D05%7C01%7Cpeng.fan%40nx
> p.com%7C10c48f8d87c4495ae2cb08da699c4cf9%7C686ea1d3bc2b4c6fa92c
> d99c5c301635%7C0%7C0%7C637938417271437135%7CUnknown%7CTWFp
> bGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXV
> CI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3Dj52hhniJ9%2F8Erb1s%2BWs
> Tbrt6PrEFUNFx%2FOpuaVliIk8%3D&amp;reserved=3D0]
>=20
> url:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu
> b.com%2Fintel-lab-lkp%2Flinux%2Fcommits%2FPeng-Fan-OSS%2Fimx-add-i-
> MX8MP-hdmi-blk-ctrl-hdcp-hrv-and-vpu-blk-ctrl%2F20220719-
> 135352&amp;data=3D05%7C01%7Cpeng.fan%40nxp.com%7C10c48f8d87c449
> 5ae2cb08da699c4cf9%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%
> 7C637938417271437135%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
> wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7
> C%7C&amp;sdata=3DB1ZT%2B01n%2FntH1CuS6diMTiwYT6F%2FWcWa2wN%2
> BCI07oaA%3D&amp;reserved=3D0
> base:
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgit.k=
e
> rnel.org%2Fpub%2Fscm%2Flinux%2Fkernel%2Fgit%2Fshawnguo%2Flinux.git
> &amp;data=3D05%7C01%7Cpeng.fan%40nxp.com%7C10c48f8d87c4495ae2cb0
> 8da699c4cf9%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63793
> 8417271437135%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiL
> CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&a
> mp;sdata=3DrT48ZhcxCPw5jkaxziGZIkZeGhOsfNMmHwTy79hpxHw%3D&amp;r
> eserved=3D0 for-next
> config: microblaze-allmodconfig
> (https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fdow
> nload.01.org%2F0day-
> ci%2Farchive%2F20220719%2F202207192320.p1W4jEjD-
> lkp%40intel.com%2Fconfig&amp;data=3D05%7C01%7Cpeng.fan%40nxp.com%
> 7C10c48f8d87c4495ae2cb08da699c4cf9%7C686ea1d3bc2b4c6fa92cd99c5c3
> 01635%7C0%7C0%7C637938417271437135%7CUnknown%7CTWFpbGZsb3d
> 8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%
> 3D%7C3000%7C%7C%7C&amp;sdata=3DsZzZ%2Fhe0aDQ0hhNOkNEyURDlzYP1
> F4xjkRey4lzZBLI%3D&amp;reserved=3D0)
> compiler: microblaze-linux-gcc (GCC) 12.1.0 reproduce (this is a W=3D1 bu=
ild):
>         wget
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fraw.
> githubusercontent.com%2Fintel%2Flkp-
> tests%2Fmaster%2Fsbin%2Fmake.cross&amp;data=3D05%7C01%7Cpeng.fan%
> 40nxp.com%7C10c48f8d87c4495ae2cb08da699c4cf9%7C686ea1d3bc2b4c6f
> a92cd99c5c301635%7C0%7C0%7C637938417271437135%7CUnknown%7CT
> WFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiL
> CJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=3DtO6jPASKjlJjMPM12kf7
> MeyVbK3%2BfnjRxjfaumbGPE8%3D&amp;reserved=3D0 -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         #
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu
> b.com%2Fintel-lab-
> lkp%2Flinux%2Fcommit%2F328924f29e2ab1b6667c1be9578a9e17a7824c71
> &amp;data=3D05%7C01%7Cpeng.fan%40nxp.com%7C10c48f8d87c4495ae2cb0
> 8da699c4cf9%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C63793
> 8417271437135%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiL
> CJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&a
> mp;sdata=3DotOy63cAD8a6%2BGdQBEA0E4GiFw%2BtrUCM7JH5lGh4mbs%3D
> &amp;reserved=3D0
>         git remote add linux-review
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Fgithu
> b.com%2Fintel-lab-
> lkp%2Flinux&amp;data=3D05%7C01%7Cpeng.fan%40nxp.com%7C10c48f8d87c
> 4495ae2cb08da699c4cf9%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C
> 0%7C637938417271437135%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4w
> LjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C
> %7C%7C&amp;sdata=3DE65GHnHqVvRXXZTqnFGTbpXudJCL7uVZQ41zcQvsCPE
> %3D&amp;reserved=3D0
>         git fetch --no-tags linux-review Peng-Fan-OSS/imx-add-i-MX8MP-hdm=
i-
> blk-ctrl-hdcp-hrv-and-vpu-blk-ctrl/20220719-135352
>         git checkout 328924f29e2ab1b6667c1be9578a9e17a7824c71
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=3D$HOME/0day COMPILER=3Dgcc-12.1.0
> make.cross W=3D1 O=3Dbuild_dir ARCH=3Dmicroblaze SHELL=3D/bin/bash
> drivers/soc/imx/ sound/soc/sof/imx/
>=20
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
>=20
> All warnings (new ones prefixed by >>):
>=20
>    drivers/soc/imx/imx8mp-blk-ctrl.c:375:18: error: 'const struct
> imx8mp_blk_ctrl_domain_data' has no member named 'path_names'
>      375 |                 .path_names =3D (const char *[]){"hrv"},
>          |                  ^~~~~~~~~~
> >> drivers/soc/imx/imx8mp-blk-ctrl.c:375:31: warning: excess elements in
> >> struct initializer
>      375 |                 .path_names =3D (const char *[]){"hrv"},
>          |                               ^
>    drivers/soc/imx/imx8mp-blk-ctrl.c:375:31: note: (near initialization f=
or
> 'imx8mp_hdmi_domain_data[8]')
>    drivers/soc/imx/imx8mp-blk-ctrl.c:376:18: error: 'const struct
> imx8mp_blk_ctrl_domain_data' has no member named 'num_paths'
>      376 |                 .num_paths =3D 1,
>          |                  ^~~~~~~~~
>    drivers/soc/imx/imx8mp-blk-ctrl.c:376:30: warning: excess elements in
> struct initializer
>      376 |                 .num_paths =3D 1,
>          |                              ^
>    drivers/soc/imx/imx8mp-blk-ctrl.c:376:30: note: (near initialization f=
or
> 'imx8mp_hdmi_domain_data[8]')
>    drivers/soc/imx/imx8mp-blk-ctrl.c:383:18: error: 'const struct
> imx8mp_blk_ctrl_domain_data' has no member named 'path_names'
>      383 |                 .path_names =3D (const char *[]){"hdcp"},
>          |                  ^~~~~~~~~~
>    drivers/soc/imx/imx8mp-blk-ctrl.c:383:31: warning: excess elements in
> struct initializer
>      383 |                 .path_names =3D (const char *[]){"hdcp"},
>          |                               ^
>    drivers/soc/imx/imx8mp-blk-ctrl.c:383:31: note: (near initialization f=
or
> 'imx8mp_hdmi_domain_data[7]')
>    drivers/soc/imx/imx8mp-blk-ctrl.c:384:18: error: 'const struct
> imx8mp_blk_ctrl_domain_data' has no member named 'num_paths'
>      384 |                 .num_paths =3D 1,
>          |                  ^~~~~~~~~
>    drivers/soc/imx/imx8mp-blk-ctrl.c:384:30: warning: excess elements in
> struct initializer
>      384 |                 .num_paths =3D 1,
>          |                              ^
>    drivers/soc/imx/imx8mp-blk-ctrl.c:384:30: note: (near initialization f=
or
> 'imx8mp_hdmi_domain_data[7]')
>=20
>=20
> vim +375 drivers/soc/imx/imx8mp-blk-ctrl.c
>=20
>    326
>    327	static const struct imx8mp_blk_ctrl_domain_data
> imx8mp_hdmi_domain_data[] =3D {
>    328		[IMX8MP_HDMIBLK_PD_IRQSTEER] =3D {
>    329			.name =3D "hdmiblk-irqsteer",
>    330			.clk_names =3D (const char *[]){ "apb" },
>    331			.num_clks =3D 1,
>    332			.gpc_name =3D "irqsteer",
>    333		},
>    334		[IMX8MP_HDMIBLK_PD_LCDIF] =3D {
>    335			.name =3D "hdmiblk-lcdif",
>    336			.clk_names =3D (const char *[]){ "axi", "apb" },
>    337			.num_clks =3D 2,
>    338			.gpc_name =3D "lcdif",
>    339		},
>    340		[IMX8MP_HDMIBLK_PD_PAI] =3D {
>    341			.name =3D "hdmiblk-pai",
>    342			.clk_names =3D (const char *[]){ "apb" },
>    343			.num_clks =3D 1,
>    344			.gpc_name =3D "pai",
>    345		},
>    346		[IMX8MP_HDMIBLK_PD_PVI] =3D {
>    347			.name =3D "hdmiblk-pvi",
>    348			.clk_names =3D (const char *[]){ "apb" },
>    349			.num_clks =3D 1,
>    350			.gpc_name =3D "pvi",
>    351		},
>    352		[IMX8MP_HDMIBLK_PD_TRNG] =3D {
>    353			.name =3D "hdmiblk-trng",
>    354			.clk_names =3D (const char *[]){ "apb" },
>    355			.num_clks =3D 1,
>    356			.gpc_name =3D "trng",
>    357		},
>    358		[IMX8MP_HDMIBLK_PD_HDMI_TX] =3D {
>    359			.name =3D "hdmiblk-hdmi-tx",
>    360			.clk_names =3D (const char *[]){ "apb", "ref_266m" },
>    361			.num_clks =3D 2,
>    362			.gpc_name =3D "hdmi-tx",
>    363		},
>    364		[IMX8MP_HDMIBLK_PD_HDMI_TX_PHY] =3D {
>    365			.name =3D "hdmiblk-hdmi-tx-phy",
>    366			.clk_names =3D (const char *[]){ "apb", "ref_24m" },
>    367			.num_clks =3D 2,
>    368			.gpc_name =3D "hdmi-tx-phy",
>    369		},
>    370		[IMX8MP_HDMIBLK_PD_HRV] =3D {
>    371			.name =3D "hdmiblk-hrv",
>    372			.clk_names =3D (const char *[]){ "axi", "apb" },
>    373			.num_clks =3D 2,
>    374			.gpc_name =3D "hrv",
>  > 375			.path_names =3D (const char *[]){"hrv"},
>    376			.num_paths =3D 1,
>    377		},
>    378		[IMX8MP_HDMIBLK_PD_HDCP] =3D {
>    379			.name =3D "hdmiblk-hdcp",
>    380			.clk_names =3D (const char *[]){ "axi", "apb" },
>    381			.num_clks =3D 2,
>    382			.gpc_name =3D "hdcp",
>    383			.path_names =3D (const char *[]){"hdcp"},
>    384			.num_paths =3D 1,
>    385		},
>    386	};
>    387
>=20
> --
> 0-DAY CI Kernel Test Service
> https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2F01.or
> g%2Flkp&amp;data=3D05%7C01%7Cpeng.fan%40nxp.com%7C10c48f8d87c449
> 5ae2cb08da699c4cf9%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%
> 7C637938417271437135%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjA
> wMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7
> C%7C&amp;sdata=3DIAl%2FXvFsNel91HfuahEWK%2BMJWkYJHGs76AXN7cvXx
> Eo%3D&amp;reserved=3D0
