Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141C5505FCA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 00:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231847AbiDRWgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 18:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231727AbiDRWgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:36:18 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57101CB0C;
        Mon, 18 Apr 2022 15:33:37 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23IL8GRP028418;
        Mon, 18 Apr 2022 18:32:33 -0400
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2044.outbound.protection.outlook.com [104.47.51.44])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3ffqj8vc1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 18 Apr 2022 18:32:33 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=doepZm0v55eDlc/+TEIqbvUuteaY6yjyyXlW8i9xza8RAkuQvj+6yv3QgFEKDO2y8eVYy3VRrMpLrg4efzQefGm/ltcTZ6yqsv6PcxnrlbbKb0ROJq9kGp2ihYn5cNpawRG/yB+6hHYoscFPmVgfVZi5vHC7IvFT1bAUHsNzS3hyPoRfF8GfMrMfYXtz4kup7GbGINbE0US/TCYqckkQm2SzX964MG+ey07rlDfPZi2qEbBNXEMCdQ5b/9J3eRny7wMWBh080d9cFDDWvRnhdvDoA4qy4sFFMdWgC5HQnt4JTecNVFqDGIcl4dT4mhZlAD0v5dxfGO7nNBcBjjo4xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jq0QcdSfmLiOf99UjLsmZlvmwFvSTQOoLGId0oSj1TY=;
 b=kE2a4d5Uc7dJ19tYABK2tJRcVdg3m4ZO5UH09o56dhBGwcSnLKCl/ezf9BBmzxBqUI7BJxTvYSwu1svx6T+kK0zBd2NLq/IafkR4WRpdQnKDjCouOEWYyam5kqmyxew0nad6Sc/rlH3/JcxsxDIQD/Hwtih1x8jJ+gyHsI5yF1fQgqBS5/BNRflOj5bb85ZzzDkYuj36Lq6tKj16Rq6G5Cntfh+C+pOPokFcusqbp4qc7NgjWsVf/h4YbJmVsw/RQYvRa8ClANvkvnsBhwOeU6FxI7uUhAfDs8r6850+PAK4FGIWFwlH6src6ktalqSDV22qwVaQW/7mBEGL5+AsFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jq0QcdSfmLiOf99UjLsmZlvmwFvSTQOoLGId0oSj1TY=;
 b=cEgIUMnVENZycL3sMmvysmbzeBir+/USWEkXNPLtlM8S1jElt7piAXxKj1uuavtn1Rm2kXbbGB+ihFlpjLg5oIOHcrPEEym9FzjrLaAlQ219dVjmdRSkQaMSGt65yB7ki1K+JztZXLrnpPqp/CQfkPP73QymDFBG8HOJFev69sA=
Received: from SJ0PR03MB6681.namprd03.prod.outlook.com (2603:10b6:a03:400::6)
 by MWHPR03MB2575.namprd03.prod.outlook.com (2603:10b6:300:45::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Mon, 18 Apr
 2022 22:32:30 +0000
Received: from SJ0PR03MB6681.namprd03.prod.outlook.com
 ([fe80::2cd9:31ee:53dd:3187]) by SJ0PR03MB6681.namprd03.prod.outlook.com
 ([fe80::2cd9:31ee:53dd:3187%7]) with mapi id 15.20.5164.025; Mon, 18 Apr 2022
 22:32:29 +0000
From:   "Lee, RyanS" <RyanS.Lee@analog.com>
To:     Rob Herring <robh@kernel.org>, Ryan Lee <ryan.lee.analog@gmail.com>
CC:     "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "pbrobinson@gmail.com" <pbrobinson@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "lukas.bulwahn@gmail.com" <lukas.bulwahn@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "pierre-louis.bossart@linux.intel.com" 
        <pierre-louis.bossart@linux.intel.com>,
        "srinivas.kandagatla@linaro.org" <srinivas.kandagatla@linaro.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "tanureal@opensource.cirrus.com" <tanureal@opensource.cirrus.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "cy_huang@richtek.com" <cy_huang@richtek.com>,
        "stephan@gerhold.net" <stephan@gerhold.net>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "drhodes@opensource.cirrus.com" <drhodes@opensource.cirrus.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>
Subject: RE: [PATCH 1/2] ASoC: dt-bindings: max98396: add amplifier driver
Thread-Topic: [PATCH 1/2] ASoC: dt-bindings: max98396: add amplifier driver
Thread-Index: AQHYUSqfbf52IXb2okOGjW7bkRB5AazzHTuAgAMoKFA=
Date:   Mon, 18 Apr 2022 22:32:29 +0000
Message-ID: <SJ0PR03MB6681CB77F45CE973DF87B01E8AF39@SJ0PR03MB6681.namprd03.prod.outlook.com>
References: <20220416004024.210418-1-ryan.lee.analog@gmail.com>
 <1650147459.157752.3544948.nullmailer@robh.at.kernel.org>
In-Reply-To: <1650147459.157752.3544948.nullmailer@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a1b3097-706e-4283-6789-08da218b52b3
x-ms-traffictypediagnostic: MWHPR03MB2575:EE_
x-microsoft-antispam-prvs: <MWHPR03MB257532E8889D717F8EC8EA218AF39@MWHPR03MB2575.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hBVdDSlxzVwHFZfcshqVaegZ/D+7NYqHHTW+/udzo+4kUtwuCAobMon6AyP1NgNVLb3xCIkohst1/BrPncenvW0anrCv924DLRoNVNm3aA2dQEjgkGtomXYSNwtl+3/No8clHyDDANgMlvdAF3C2qgxBad8ogvRjnBF64g+/QmXm+3UhHPTViuBBg6jjxm65g/Fw0whdDO/gDqjGTP0rede09YOCaZ1+EUTyf27tfPZWgFTlSmluHNr/7XTbTRMIa8YYmec5m4p8QdbhzWFfQU0MOKELmy4ZdkfYFYikv1BCCNmRRgCo171RdspdTDbVY/h8SE/hkMPqHAq1J3Ka2rYuD/hDBi1Nuin9S+Hr4nT/n2s6BXccYdfU+rGCJhsNKVK1txViqYM5qqwnWhTU5iAJ9XI9FUWTUMyLRVvcwk5oPjienGbSMoRUC4HwW+ac9+t3KJWsumInEHbYXfm0BbVR9NtktPfMSExK0dHderduTUKHdaoDyaYjH289wmLxnMi89w9edW5rmHm7uglWnIy+K1Gb0NHww1h6e+fNh2CxwrQH8g4A8kg32GGoGxRRu+CfVKkW1FaQ1xndW7Pbgv89TzXI5pZWjuhMCLVrZwqCY6FpW+3AoMSqwaZZFUSbewnUBt2F+EtmRUo+RPqZvvfbLOpAybcx1a+9wQrCSc1lACjcmcLytLCaAYMiXvhzV7QAqC2Pc6mSxh6kLpJbGXLX2Zaz/diQUSHnnQrVRcquQiJhiZ/TwBdFNLwSRjNCWSq8ia6oyOQhT/Dzr41uaxf+kbYoJIi1tPiqXBuyXxlaEdgtUCI8A6/IqZVraXkD03j7jL6Cb9QGVXBfkDMZXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6681.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(53546011)(966005)(55016003)(9686003)(33656002)(2906002)(7696005)(186003)(71200400001)(8936002)(26005)(122000001)(508600001)(110136005)(54906003)(52536014)(7416002)(316002)(8676002)(66446008)(4326008)(64756008)(66476007)(5660300002)(38070700005)(38100700002)(76116006)(86362001)(66556008)(83380400001)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?AFZFxEHq1nV6AXs0oqxwHsRCl4MANHK5WUOWhVu6of+c3AoDnPy2bWSsJnzE?=
 =?us-ascii?Q?7Q7GdSYBk6yTrpMCvIcIevrduGOmICeuLEPl1KNS9sFvQyrGq9l5BsWpdlKY?=
 =?us-ascii?Q?sj335rHH1o78UTJZ1YdNHuTg4Lxr8pkE44ZMQZgvOrwMlUzyIQLjOHF7jDaQ?=
 =?us-ascii?Q?GOESvYy+xwV8saI8gzyoS7QSrB/txt/4XMQhrKmwrANQHqw5A0Ry2P1aQ4g/?=
 =?us-ascii?Q?103C/SuB1ASAZox6SkQWkanK8ITL2XuaBDUAwnV8M2mIUiAXDLe/UcVhpUO0?=
 =?us-ascii?Q?gHxiegbP3OdGei4YBO6bmTw+lOIzloo572HlvFBkY7fB3WbBrotFjR6XkpGk?=
 =?us-ascii?Q?OCWnGJvPHc3FGEf/iC5aAVQBCRoazMc8GB3f4syQe2TTm7InIRloDrqWYNin?=
 =?us-ascii?Q?rphLXnjd05VBpiNupeFHBa5dg9kNjETz+pNjt9sZX+92CesSXoVEoa8daCfy?=
 =?us-ascii?Q?YYtCzE4lEfS4mIcqtzf7gPZqSlPeB282zdLLMym8XFFa/uZiOO269yjf3Sc3?=
 =?us-ascii?Q?ivcFcpVDHNZUx30ebMl0TrWOZXCAk8P//tNlviHgw/duTB02BeMoHgHn6+p5?=
 =?us-ascii?Q?wB8zOjtVxLQShZMZPFpwcBFGzpGOeAvTWA1t00BEU2MTqeyPNTdnZfoHkHgf?=
 =?us-ascii?Q?WpS9kf5KnOS5kd/GkhnmsbmXwLyrPgrurQHajexMNZeVMSNRuhSk8a8w3LNJ?=
 =?us-ascii?Q?DaHClmEdWiJTsXoKlLKXxXh2l/5UBerdENdcU6YfKK6D78UuVA0KdN6IfJSi?=
 =?us-ascii?Q?WaLRAsYSQUUo57rXoaflCsDeaPO+fv3YspevMOhGZPIYq8thpyhlTzntBbBh?=
 =?us-ascii?Q?z0y6zOFXZLsVTxtkR8mK0BiBpN9g5YUIjqmdXh6yUIEnm+y8E8sWekArgiow?=
 =?us-ascii?Q?kZxtVsiMybDlhUrFObryB/jvJjPpmWGrV5KWb8IK6k1FsMybhx3tSYWduEcx?=
 =?us-ascii?Q?aDedaiGOJkj6a+EWm1W7PTPUocWribjQwAP+O9W9FVVnPbKQdqqmcuLMmuex?=
 =?us-ascii?Q?64VYPaPtJkeUEYPP2b2m01l59wKJ1ABjAMHvBlBCs++e/f1DNT+IVsk5LaSE?=
 =?us-ascii?Q?ziqRPU6VwKMf/bcaZAjS6zOr9nDMmTpEFOZSK6DJIMA/p5DYj9S2JIOHlYA9?=
 =?us-ascii?Q?0ZJ1FOiu+MjNEUMNoZt7RDdMcTmIpvMVQW0OcRXjwpCC3QrEH1gssSDMtzvS?=
 =?us-ascii?Q?BdK1Bz1j1A+oJwELDgJ4wyxJw6edkpq/JbMvb2NqYCI2c3VyxEvcuDhfWW9x?=
 =?us-ascii?Q?8HJYN2QAIpwyTOMjq06sUJkJTyxzjc6AcGNdJ2J4/VpjrVa9uan1Q9beuoaN?=
 =?us-ascii?Q?OIi9FuERMcviLxGxzNRipNiNStNCDIzqxKw/7/lOXhrWMvEi5bQc1cJ9sZoE?=
 =?us-ascii?Q?eHPdQ02XPgtYQiRcMaQtCQ2JslHgqgsDGU6M0+6LC5uQMr6c2vzrr0yeXfwL?=
 =?us-ascii?Q?fBTQzJiu9a4Nl0wz6LfZ+VRgOHGiel3iGZYn9wlOo8MLIFVNO7/E75anWH2L?=
 =?us-ascii?Q?3IamZIReOms5lvk7kul/YQMQ+jkFS/j6qzjj5WK3cfZuphwYTajkZF1RVhyC?=
 =?us-ascii?Q?qQ0PWWvDJSnd1Xq2cxt4/pDR7OmTo8hD7IQvdLo5df6XNMSAD/nZViua4viC?=
 =?us-ascii?Q?PAqFTWS3i1fhikK0ToHHnBDojMjSRNBZuegrbv+Pc5MTQXd+th1786udPE2+?=
 =?us-ascii?Q?ecHPa+2kJgxfUfQGXnlPCQKI5tHFwgUYeUhh7LcHP21iE6CtEMdAxBejwem7?=
 =?us-ascii?Q?C08oOR6QJw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a1b3097-706e-4283-6789-08da218b52b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2022 22:32:29.5819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LUIjczbidugFqC36I8TppFA1BNYqVzyzE5sSWb3P/q0YlRInjk+2TZ4Hb1UMifod3vDguLw1wjSyQL6z6QOFlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR03MB2575
X-Proofpoint-ORIG-GUID: Gk3CtEvf2h7hUICNHQenas2oLOQqDc8E
X-Proofpoint-GUID: Gk3CtEvf2h7hUICNHQenas2oLOQqDc8E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-18_02,2022-04-15_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 clxscore=1011 impostorscore=0 priorityscore=1501
 mlxscore=0 spamscore=0 mlxlogscore=750 suspectscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204180125
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: Rob Herring <robh@kernel.org>
> Sent: Saturday, April 16, 2022 3:18 PM
> To: Ryan Lee <ryan.lee.analog@gmail.com>
> Cc: krzk+dt@kernel.org; pbrobinson@gmail.com; linux-
> kernel@vger.kernel.org; ckeepax@opensource.cirrus.com;
> lukas.bulwahn@gmail.com; devicetree@vger.kernel.org; pierre-
> louis.bossart@linux.intel.com; srinivas.kandagatla@linaro.org; alsa-
> devel@alsa-project.org; tanureal@opensource.cirrus.com;
> broonie@kernel.org; tiwai@suse.com; cy_huang@richtek.com;
> stephan@gerhold.net; arnd@arndb.de; robh+dt@kernel.org;
> hdegoede@redhat.com; perex@perex.cz;
> drhodes@opensource.cirrus.com; Lee, RyanS
> <RyanS.Lee@analog.com>; lgirdwood@gmail.com
> Subject: Re: [PATCH 1/2] ASoC: dt-bindings: max98396: add amplifier
> driver
>=20
> [External]
>=20
> On Fri, 15 Apr 2022 17:40:23 -0700, Ryan Lee wrote:
> > From: Ryan Lee <ryans.lee@analog.com>
> >
> > This patch adds dt-bindings information for Analog Devices
> MAX98396
> > and MAX98397 Smart Amplifier.
> >
> > Signed-off-by: Ryan Lee <ryans.lee@analog.com>
> > ---
> >  .../bindings/sound/adi,max98396.yaml          | 84
> +++++++++++++++++++
> >  1 file changed, 84 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/sound/adi,max98396.yaml
> >
>=20
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m
> dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>=20

I appreciate your feedback. I was able to check the same issues on my side.
I shall fix the problem and submit the updated patch.

> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/sound/adi,max98396.yaml:49:1
> 11: [warning] line too long (121 > 110 characters) (line-length)
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/linux-dt-
> review/Documentation/devicetree/bindings/sound/adi,max98396.ya
> ml: properties:adi,spkfb-slot-no: 'oneOf' conditional failed, one must
> be fixed:
> 	'type' is a required property
> 		hint: A vendor boolean property can use "type:
> boolean"
> 	Additional properties are not allowed ('maximum', 'default',
> 'minimum' were unexpected)
> 		hint: A vendor boolean property can use "type:
> boolean"
> 	/builds/robherring/linux-dt-
> review/Documentation/devicetree/bindings/sound/adi,max98396.ya
> ml: properties:adi,spkfb-slot-no: 'oneOf' conditional failed, one must
> be fixed:
> 		'enum' is a required property
> 		'const' is a required property
> 		hint: A vendor string property with exact values has an
> implicit type
> 		from schema $id:
> https://urldefense.com/v3/__http://devicetree.org/meta-
> schemas/vendor-
> props.yaml*__;Iw!!A3Ni8CS0y2Y!6AbqO57BdHk8HsfdSgsIJ96PVLttFGa
> Nyp2EOec4EnuAYY4aQ25BDE2H4waOpyi0_juZ-wiHiNs8$
> 	/builds/robherring/linux-dt-
> review/Documentation/devicetree/bindings/sound/adi,max98396.ya
> ml: properties:adi,spkfb-slot-no: 'oneOf' conditional failed, one must
> be fixed:
> 		'$ref' is a required property
> 		'allOf' is a required property
> 		hint: A vendor property needs a $ref to types.yaml
> 		from schema $id:
> https://urldefense.com/v3/__http://devicetree.org/meta-
> schemas/vendor-
> props.yaml*__;Iw!!A3Ni8CS0y2Y!6AbqO57BdHk8HsfdSgsIJ96PVLttFGa
> Nyp2EOec4EnuAYY4aQ25BDE2H4waOpyi0_juZ-wiHiNs8$
> 	hint: Vendor specific properties must have a type and
> description unless they have a defined, common suffix.
> 	from schema $id:
> https://urldefense.com/v3/__http://devicetree.org/meta-
> schemas/vendor-
> props.yaml*__;Iw!!A3Ni8CS0y2Y!6AbqO57BdHk8HsfdSgsIJ96PVLttFGa
> Nyp2EOec4EnuAYY4aQ25BDE2H4waOpyi0_juZ-wiHiNs8$
> /builds/robherring/linux-dt-
> review/Documentation/devicetree/bindings/sound/adi,max98396.ya
> ml: properties:adi,interleave-mode: 'oneOf' conditional failed, one
> must be fixed:
> 	Additional properties are not allowed ('default' was
> unexpected)
> 		hint: A vendor boolean property can use "type:
> boolean"
> 	/builds/robherring/linux-dt-
> review/Documentation/devicetree/bindings/sound/adi,max98396.ya
> ml: properties:adi,interleave-mode: 'oneOf' conditional failed, one
> must be fixed:
> 		'enum' is a required property
> 		'const' is a required property
> 		hint: A vendor string property with exact values has an
> implicit type
> 		from schema $id:
> https://urldefense.com/v3/__http://devicetree.org/meta-
> schemas/vendor-
> props.yaml*__;Iw!!A3Ni8CS0y2Y!6AbqO57BdHk8HsfdSgsIJ96PVLttFGa
> Nyp2EOec4EnuAYY4aQ25BDE2H4waOpyi0_juZ-wiHiNs8$
> 	Additional properties are not allowed ('type', 'default' were
> unexpected)
> 		hint: A vendor string property with exact values has an
> implicit type
> 	/builds/robherring/linux-dt-
> review/Documentation/devicetree/bindings/sound/adi,max98396.ya
> ml: properties:adi,interleave-mode: 'oneOf' conditional failed, one
> must be fixed:
> 		'$ref' is a required property
> 		'allOf' is a required property
> 		hint: A vendor property needs a $ref to types.yaml
> 		from schema $id:
> https://urldefense.com/v3/__http://devicetree.org/meta-
> schemas/vendor-
> props.yaml*__;Iw!!A3Ni8CS0y2Y!6AbqO57BdHk8HsfdSgsIJ96PVLttFGa
> Nyp2EOec4EnuAYY4aQ25BDE2H4waOpyi0_juZ-wiHiNs8$
> 	hint: Vendor specific properties must have a type and
> description unless they have a defined, common suffix.
> 	from schema $id:
> https://urldefense.com/v3/__http://devicetree.org/meta-
> schemas/vendor-
> props.yaml*__;Iw!!A3Ni8CS0y2Y!6AbqO57BdHk8HsfdSgsIJ96PVLttFGa
> Nyp2EOec4EnuAYY4aQ25BDE2H4waOpyi0_juZ-wiHiNs8$
> /builds/robherring/linux-dt-
> review/Documentation/devicetree/bindings/sound/adi,max98396.ya
> ml: properties:adi,vmon-slot-no: 'oneOf' conditional failed, one must
> be fixed:
> 	'type' is a required property
> 		hint: A vendor boolean property can use "type:
> boolean"
> 	Additional properties are not allowed ('maximum', 'default',
> 'minimum' were unexpected)
> 		hint: A vendor boolean property can use "type:
> boolean"
> 	/builds/robherring/linux-dt-
> review/Documentation/devicetree/bindings/sound/adi,max98396.ya
> ml: properties:adi,vmon-slot-no: 'oneOf' conditional failed, one must
> be fixed:
> 		'enum' is a required property
> 		'const' is a required property
> 		hint: A vendor string property with exact values has an
> implicit type
> 		from schema $id:
> https://urldefense.com/v3/__http://devicetree.org/meta-
> schemas/vendor-
> props.yaml*__;Iw!!A3Ni8CS0y2Y!6AbqO57BdHk8HsfdSgsIJ96PVLttFGa
> Nyp2EOec4EnuAYY4aQ25BDE2H4waOpyi0_juZ-wiHiNs8$
> 	/builds/robherring/linux-dt-
> review/Documentation/devicetree/bindings/sound/adi,max98396.ya
> ml: properties:adi,vmon-slot-no: 'oneOf' conditional failed, one must
> be fixed:
> 		'$ref' is a required property
> 		'allOf' is a required property
> 		hint: A vendor property needs a $ref to types.yaml
> 		from schema $id:
> https://urldefense.com/v3/__http://devicetree.org/meta-
> schemas/vendor-
> props.yaml*__;Iw!!A3Ni8CS0y2Y!6AbqO57BdHk8HsfdSgsIJ96PVLttFGa
> Nyp2EOec4EnuAYY4aQ25BDE2H4waOpyi0_juZ-wiHiNs8$
> 	hint: Vendor specific properties must have a type and
> description unless they have a defined, common suffix.
> 	from schema $id:
> https://urldefense.com/v3/__http://devicetree.org/meta-
> schemas/vendor-
> props.yaml*__;Iw!!A3Ni8CS0y2Y!6AbqO57BdHk8HsfdSgsIJ96PVLttFGa
> Nyp2EOec4EnuAYY4aQ25BDE2H4waOpyi0_juZ-wiHiNs8$
> /builds/robherring/linux-dt-
> review/Documentation/devicetree/bindings/sound/adi,max98396.ya
> ml: properties:adi,imon-slot-no: 'oneOf' conditional failed, one must
> be fixed:
> 	'type' is a required property
> 		hint: A vendor boolean property can use "type:
> boolean"
> 	Additional properties are not allowed ('maximum', 'default',
> 'minimum' were unexpected)
> 		hint: A vendor boolean property can use "type:
> boolean"
> 	/builds/robherring/linux-dt-
> review/Documentation/devicetree/bindings/sound/adi,max98396.ya
> ml: properties:adi,imon-slot-no: 'oneOf' conditional failed, one must
> be fixed:
> 		'enum' is a required property
> 		'const' is a required property
> 		hint: A vendor string property with exact values has an
> implicit type
> 		from schema $id:
> https://urldefense.com/v3/__http://devicetree.org/meta-
> schemas/vendor-
> props.yaml*__;Iw!!A3Ni8CS0y2Y!6AbqO57BdHk8HsfdSgsIJ96PVLttFGa
> Nyp2EOec4EnuAYY4aQ25BDE2H4waOpyi0_juZ-wiHiNs8$
> 	/builds/robherring/linux-dt-
> review/Documentation/devicetree/bindings/sound/adi,max98396.ya
> ml: properties:adi,imon-slot-no: 'oneOf' conditional failed, one must
> be fixed:
> 		'$ref' is a required property
> 		'allOf' is a required property
> 		hint: A vendor property needs a $ref to types.yaml
> 		from schema $id:
> https://urldefense.com/v3/__http://devicetree.org/meta-
> schemas/vendor-
> props.yaml*__;Iw!!A3Ni8CS0y2Y!6AbqO57BdHk8HsfdSgsIJ96PVLttFGa
> Nyp2EOec4EnuAYY4aQ25BDE2H4waOpyi0_juZ-wiHiNs8$
> 	hint: Vendor specific properties must have a type and
> description unless they have a defined, common suffix.
> 	from schema $id:
> https://urldefense.com/v3/__http://devicetree.org/meta-
> schemas/vendor-
> props.yaml*__;Iw!!A3Ni8CS0y2Y!6AbqO57BdHk8HsfdSgsIJ96PVLttFGa
> Nyp2EOec4EnuAYY4aQ25BDE2H4waOpyi0_juZ-wiHiNs8$
> /builds/robherring/linux-dt-
> review/Documentation/devicetree/bindings/sound/adi,max98396.ya
> ml: ignoring, error in schema: properties: adi,spkfb-slot-no
> Documentation/devicetree/bindings/sound/adi,max98396.example.dt
> b:0:0: /example-0/i2c/amplifier@39: failed to match any schema with
> compatible: ['adi,max98396']
> Documentation/devicetree/bindings/sound/adi,max98396.example.dt
> b:0:0: /example-0/i2c/amplifier@3c: failed to match any schema with
> compatible: ['adi,max98397']
>=20
> doc reference errors (make refcheckdocs):
>=20
> See
> https://urldefense.com/v3/__https://patchwork.ozlabs.org/patch/__;!
> !A3Ni8CS0y2Y!6AbqO57BdHk8HsfdSgsIJ96PVLttFGaNyp2EOec4EnuAYY
> 4aQ25BDE2H4waOpyi0_juZ-xmX_4-e$
>=20
> This check can fail if there are any dependencies. The base for a patch
> series is generally the most recent rc1.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit.

