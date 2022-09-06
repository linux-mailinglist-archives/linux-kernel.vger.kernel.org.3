Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E34035AE43C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 11:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239463AbiIFJ3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 05:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239616AbiIFJ2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 05:28:45 -0400
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B632B13CED;
        Tue,  6 Sep 2022 02:28:43 -0700 (PDT)
Received: from pps.filterd (m0174678.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 28623gx0027171;
        Tue, 6 Sep 2022 09:27:10 GMT
Received: from eur04-he1-obe.outbound.protection.outlook.com (mail-he1eur04lp2056.outbound.protection.outlook.com [104.47.13.56])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3jdqdmheam-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Sep 2022 09:27:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RZX0UtuuH2KBKHlVDVfoLR5ifbdXpY2Jl2ylGMMMIw3ehckz8PtVme51otJmqwmJTe901Nbgg1tVWBK31pJmExUL0I0bSBL9RFZkzJ0WUot0S0qLtBmi/VIe8RzOrsIxqZK0XOnmzdNKTh1k//1kk8Bd18WFiQ9WKkmEyF2hVQFBKt+MJEchJQYeH9MwJmKrWLscFB8UtQ25OmWBI08j1m0kkY8mJiiR8IMmQcP/8FZ0z+jxJdUSftRiwym2yFzjvEToZlPU0dKYiPds3AsYrIqgXfOChDZuGnB7kZJ07ihOTBAMok1MG2CaPxggCUTA2vwlSCvTN1SEXyBIF6tDsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ryFWdBRiZBB7rpIhCTaoQhyy8lLxnryYfLkT4irUJbM=;
 b=LW5qQVCQnnc8zHe96EX4+cflCbMjdcorT3RW5SHva4Qvf0EKnZwemK+wQXmK0fXI9fXPbqUUpUWnJ3UwvBQvEFErKuofEwoPTjao9o9U8T5yXLz5z36+n3wBq5w9vwbCQXmrW65FKGQaDThRPswxgcrvUc6Izmz5lpSLzhr0k5H69cIw/f0tlmtS8Zzl2CzYchzDPHhtCuro6ztvR5qw1TW5KdfRlJxKwU8TMAeJvBaPLrb3olG5QZ+5yl3jR+2AblXlk4vrWbNWDfQotfFIkz+nxCKHWAwSJncmSXGKlWJgvLli3KetcRXrCUEGb9u8NBke4xG6cQ2HUyFmY1U/Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ryFWdBRiZBB7rpIhCTaoQhyy8lLxnryYfLkT4irUJbM=;
 b=Z0do8Py25jT839Km42Zw7v/N0IghTSeLNfPlXTj7JETUwYDryA8n7C3dYat5J7uiSNLoms0RSvEfUmu1mEDGte0P2PZHtGaBrwLCw3WxOMTnvcAxXazAicC9uI65c6Rj/04W8ArbTeS4qAcNB29ohVlpnBd26AkuGBtgRMr4z1XsmkFWcyq4zH9oSRhC8HPzDBNL/WBSCtEgXoTBcj3ja6F3g4Dwvt1RFe0Ukq9yjsll2imYtwNxR5GYp4Mg9E7vNCEQ/5gCNhk3F8j6KWaIHIRjJEmAedLWcSZLJDXs3H0+oIPoFbcLjep4Aq0BGTU6/gwtaGqUGlEXQELdrwRVIQ==
Received: from AM9PR03MB7121.eurprd03.prod.outlook.com (2603:10a6:20b:2dc::22)
 by DB8PR03MB5498.eurprd03.prod.outlook.com (2603:10a6:10:10c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Tue, 6 Sep
 2022 09:27:05 +0000
Received: from AM9PR03MB7121.eurprd03.prod.outlook.com
 ([fe80::2ddb:62f1:fce9:48eb]) by AM9PR03MB7121.eurprd03.prod.outlook.com
 ([fe80::2ddb:62f1:fce9:48eb%5]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 09:27:05 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "alexandre.torgue@st.com" <alexandre.torgue@st.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tomase@xilinx.com" <tomase@xilinx.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "loic.pallardy@st.com" <loic.pallardy@st.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: Re: [PATCH v4 0/2] dt-bindings: Intorduce domain-controller
Thread-Topic: [PATCH v4 0/2] dt-bindings: Intorduce domain-controller
Thread-Index: AQHYkevVQuji0mJdiUaO5T+/y7MyeK2wZr+AgAQ43YCAEsJdAIALH9eA
Date:   Tue, 6 Sep 2022 09:27:05 +0000
Message-ID: <YxcSaYuFlFoIphJ5@EPUAKYIW015D>
References: <cover.1657187536.git.oleksii_moisieiev@epam.com>
 <3ca7cd75-4b62-2380-adb0-646bbeb647a2@pengutronix.de>
 <Yv4A9Rgna2bzAuvj@EPUAKYIW015D>
 <d703bd19-7e68-86ee-681a-544321c25d37@pengutronix.de>
In-Reply-To: <d703bd19-7e68-86ee-681a-544321c25d37@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89f9ec2d-747d-4584-353b-08da8fe9f6ce
x-ms-traffictypediagnostic: DB8PR03MB5498:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mMfy3mdT28KwZoaqQ4lV8T3sKIo6T0iMR2ZjxU4NWSbnCKgkBkIIOb0DtJb1iE2TM8MOJXjexWyvBer2ieNgIo4HdC/nLl046YoyGhf2uTxFb1eYrW8HpKiXSjNe33khIwVV/4B0qPTMdAJYyzssZ0m/EuNmwwtzRcygDnB11wxgndHdH19XyYDoMCq7cngG0nXNl0fhL7kg+c3tZD2wzfITB6Rfntd0Yk99yvwvhWKH98VTd8b3ZZVf3v5kzXF/xJU7ilYpytVPN9bSeXmH3bzGuP8OREE/xet+ZVFXiyqLzqToyGXhFrirMyLp9fLEidOLxXtiA7n8oARLIIc7228142fzTWLusXbqfY8ThOLrGDLcctm9XD1X6YO3Bi0FlnuzVd8gD5Y73xWe/wTD93YC7EVffpP6WbfW/AIMfRhH4+E0e020pa75o3WyXMcYo28o70sP2IhLN3c6TIVQDtyWQt8qXtSMJBDHyJ9SkTjt0ZOe9q4/52ctLEylhvI8lkjUed7XTvHYqSqpivUCOUK+GTv7XB4i/3cRYx2ZGXvt7+r4Hy+4LFCnJWnLP4eYxzVn1BFr2a63aESW0vdriCYVmmU6uoW7oWNqSjngPE87OWIVC5x2oisvjCq2VyMXu3Ehr1NzzDsMdylYlpalo1tlfTMjIF/2ghIN5NBCrLYSRNV7wZsC0qolm2aJy3G08PiplVptcMZ/wsLiXmzyTz55osZKUD4aZMEuAA5/G0lIj31sIWlvINo+zUNNVAp54CfSBGkcGf8fEuIZ+++zc8EqIsH4/PgaZ7vS03PuNmA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR03MB7121.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(7916004)(376002)(39860400002)(346002)(366004)(396003)(136003)(86362001)(186003)(41300700001)(6486002)(26005)(6512007)(9686003)(966005)(71200400001)(478600001)(6506007)(38070700005)(122000001)(38100700002)(33716001)(53546011)(83380400001)(316002)(5660300002)(76116006)(54906003)(6916009)(2906002)(66946007)(8936002)(66446008)(64756008)(8676002)(4326008)(66556008)(66476007)(7416002)(91956017);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gLjgSlTgHVFNqNyUHXJvK76RnPZV7gluBgQHvANpgb/vZiiQTPlOLN8K+tDS?=
 =?us-ascii?Q?PHXQNXTyCPlOrrcK/epxw3RHEO268UQUJdSNTi68JtUSAW/mVQvgzKGDSCia?=
 =?us-ascii?Q?uZwLzO8In0XIuFEJCriiubEmjjjkIE8ihAFeRqPSnas5IIZZkKVtJg5Z8Gst?=
 =?us-ascii?Q?FUjLzbvWjOSo2cciVaJwZk2ns4Cl+A+UYikbAMUUzwMfr3TfqtgTUCliWwFD?=
 =?us-ascii?Q?zcHav3fyAzTy0BdQRMpbGY4c6911swaJXDjNb5zhebPpBOS/orF0uoNOF3Zl?=
 =?us-ascii?Q?5ZirM0SVnIUDgtJfiy66YPw0SVqyGtG0TFx2KU8AwvjCa6cVGybm217T6nos?=
 =?us-ascii?Q?UFWoxJPhsumMoyZNYXv+Jnr3+6YjiTGRpbjug+sazXKREfD2N08XFXYIL042?=
 =?us-ascii?Q?hf60xKFmD32KIlImZ98X1i2y2DJQH7kLBkH/PTdknaRz9qy85zh9nVru3ZWL?=
 =?us-ascii?Q?uzUriTjORGihBw17VRFwPMfrCoAfUnZ9PCNViQFUqtktQDy2y1TmAL8IlZJP?=
 =?us-ascii?Q?PSqqnn9LQSNBXAjrcRYF6dBDP/bTJXMryBaDAWUH7QbrQMZj751wObPAVxMp?=
 =?us-ascii?Q?8csdTOmZjfAGFm73ktnyKHuK93VY08C/PKgDVo6EGkziX1tjFN2yeMuQMpWu?=
 =?us-ascii?Q?luMcHH+fsyMPUPL5hm+MzW492oXQh2a97kA7ZgmgPoSQ7aB/UZtHFwD8THWX?=
 =?us-ascii?Q?aYw2ZhKvvtAufSxJg78O8XvBLB5k+HfvvEW/L8eoAe8QJlQJZfmFYx1pBXyI?=
 =?us-ascii?Q?iiina2aIUDX1F6w06nkdYOG443KS9L2gyjMSviXsY0eWbQs2NajlYs7eAyVY?=
 =?us-ascii?Q?dY6Z/f8MkZXKxk1w1QvOGbX5hrelKhqFquefGXbuGP7IYmOk2jmwvbTBgHQu?=
 =?us-ascii?Q?81TP4V9rFPpGZc/eh0+mWTX/8FFtT74+gMMbi8ji4bHfIK6EiCdq2dsPMyY9?=
 =?us-ascii?Q?LtmKeHOU6TlsXb7/bzK0yrd0NMitJVM8wc31Kl5g4J0LwxmAOmjoxH5yGE/e?=
 =?us-ascii?Q?FtrIZ89muCQg2ns2h3CWy7YYMd04u+8WSGfIjKpkqSerMu661m971d+QYb8q?=
 =?us-ascii?Q?J0xWE7fEgmrZP2d8pfqQ0GvySiOn7UgEtAu7LJwgD18GQCtdJ94CysBYYt7f?=
 =?us-ascii?Q?UoOsOAS7b4OUy0XITuI7+Ya9r/6IauHaiNfQV1BPoOEpsayggF3JfzYg0acv?=
 =?us-ascii?Q?BkZ5P9ZJqjDctX5z/tHDYI40ovVOwzFaZRXZhmiub/nOF5mdBS0t24L9Icev?=
 =?us-ascii?Q?+5fyP924RXgZThULPRcpLY7u3WX7yu//Wsq3UfmHyPS5t80WJRTpGS1oou2s?=
 =?us-ascii?Q?QiTh4T962sjUBz8HDL3cZOdKj2p1AInTjoQl24iy10Hyfg+Geq2MBFZP5AAO?=
 =?us-ascii?Q?NRWknHtHlkaPO0JJ1HPcGceTuZp6Dxb+qqS4fUrtorFm6zdRi8pjzM4RY2EG?=
 =?us-ascii?Q?Q+9cGanRflFPjJ4/tPfiMxDJ6Yn+F2lJLD0Mag3D5jvzhQpAvoyMrpngwsCQ?=
 =?us-ascii?Q?gnKzH4hwb9QGVJUzBp3gWI8CezzYYBGYc0NmeAHpwT3CxJfhGUkwxf5MAwYV?=
 =?us-ascii?Q?H63wne6lty1Q3CRdioW3JQiiX95cSZf9hqX8kRj2QnU3xqtMvS8rjoNrji35?=
 =?us-ascii?Q?Lw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E56529DEC315604CB59AE6A370D0AF5B@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR03MB7121.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 89f9ec2d-747d-4584-353b-08da8fe9f6ce
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 09:27:05.6582
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ckWLYqXhnSJkYtWYScGlx356pvzlxPpcqWJFsWxV2h7Z7+K4EVQWny6IGr+wBYjIUg2jBWWcwlaTftZRJGUY04yLmonIz4bOUq1UDHn1Mac=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB5498
X-Proofpoint-ORIG-GUID: hLjNtNa9t0gy289-Vuehoy--B9L-ncAI
X-Proofpoint-GUID: hLjNtNa9t0gy289-Vuehoy--B9L-ncAI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.528,FMLib:17.11.122.1
 definitions=2022-09-06_04,2022-09-05_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 impostorscore=0 phishscore=0 clxscore=1011
 mlxlogscore=999 adultscore=0 mlxscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2209060044
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 09:34:16AM +0200, Ahmad Fatoum wrote:
> Hello Oleksii,
>=20
> On 18.08.22 11:05, Oleksii Moisieiev wrote:
> > On Mon, Aug 15, 2022 at 06:37:23PM +0200, Ahmad Fatoum wrote:
> >> Hello Oleksii,
> >>
> >> On 07.07.22 12:25, Oleksii Moisieiev wrote:
> >>> Introducing the domain controller provider/consumenr bindngs which al=
low to
> >>> divided system on chip into multiple domains that can be used to sele=
ct
> >>> by who hardware blocks could be accessed.
> >>> A domain could be a cluster of CPUs, a group of hardware blocks or th=
e
> >>> set of devices, passed-through to the Guest in the virtualized system=
s.
> >>>
> >>> Device controllers are typically used to set the permissions of the h=
ardware
> >>> block. The contents of the domain configuration properties are define=
d by the
> >>> binding for the individual domain controller device.
> >>>
> >>> The device controller conception in the virtualized systems is to set
> >>> the device configuration for SCMI (System Control and Management
> >>> Interface) which controls clocks/power-domains/resets etc from the
> >>> Firmware. This configuratio sets the device_id to set the device perm=
issions
> >>> for the Fimware using BASE_SET_DEVICE_PERMISSIONS message (see 4.2.2.=
10 of [0]).
> >>> There is no BASE_GET_DEVICE_PERMISSIONS call in SCMI and the way to
> >>> determine device_id is not covered by the specification.
> >>> Device permissions management described in DEN 0056, Section 4.2.2.10=
 [0].
> >>> Given parameter should set the device_id, needed to set device
> >>> permissions in the Firmware.
> >>> This property is used by trusted Agent (which is hypervisor in our ca=
se)
> >>> to set permissions for the devices, passed-through to the non-trusted
> >>> Agents. Trusted Agent will use device-perms to set the Device
> >>> permissions for the Firmware (See Section 4.2.2.10 [0] for details).
> >>> Agents concept is described in Section 4.2.1 [0].
> >>>
> >>> Domains in Device-tree node example:
> >>> usb@e6590000
> >>> {
> >>>     domain-0 =3D <&scmi 19>; //Set domain id 19 to usb node
> >>>     clocks =3D <&scmi_clock 3>, <&scmi_clock 2>;
> >>>     resets =3D <&scmi_reset 10>, <&scmi_reset 9>;
> >>>     power-domains =3D <&scmi_power 0>;
> >>> };
> >>>
> >>> &scmi {
> >>>     #domain-cells =3D <1>;
> >>> }
> >>>
> >>> All mentioned bindings are going to be processed by XEN SCMI mediator
> >>> feature, which is responsible to redirect SCMI calls from guests to t=
he
> >>> firmware, and not going be passed to the guests.
> >>>
> >>> Domain-controller provider/consumenr concept was taken from the bus
> >>> controller framework patch series, provided in the following thread:
> >>> [1].
> >>
> >> I also was inspired by Benjamin's series to draft up a binding, but fo=
r a slightly
> >> different problem: Some SoCs like the i.MX8MP have a great deal of var=
iation
> >> in which IPs are actually available. After factory testing, fuses are =
burnt
> >> to describe which IPs are available and as the upstream DT only descri=
bes
> >> the full featured SoCs, either board DT or bootloader is expected to t=
urn
> >> off the device that are unavailable.
> >>
> >> What I came up with as a binding for the bootloader to guide its fixup
> >> looks very similar to what you have:
> >>
> >> feat: &ocotp { /* This is the efuse (On-Chip OTP) device */
> >>     feature-controller;
> >>     feature-cells =3D <1>;
> >> };
> >>
> >> &vpu_g1 {
> >>     features-gates =3D <&feat IMX8MP_VPU>;
> >> };
> >>
> >> The OCOTP driver would see that it has a feature-controller property a=
nd register
> >> a callback with a feature controller framework that checks whether a d=
evice
> >> is available. barebox, that I implemented this binding for, would walk
> >> the kernel device tree on boot looking for the feature-gates property =
and then
> >> disable/delete nodes as indicated without having to write any SoC spec=
ific code
> >> and especially without hardcoding node names and hierarchies, which is=
 quite brittle.
> >>
> >> There was a previous attempt at defining a binding for this, but Rob's=
 NAK
> >> mentioned that a solution should cover both cases:
> >>
> >>  https://urldefense.com/v3/__https://lore.kernel.org/all/2022032404202=
4.26813-1-peng.fan@oss.nxp.com/__;!!GF_29dbcQIUBPA!2j_vN6Jc1k2XI3EegAC2yzTL=
gJ1Rw1DhDrjGF03a5tDtOGpm_qp9B0zHJeAJzw-fWOeJp5HtnzYmOJZ0XPJxHzHFDBt_$  [lor=
e[.]kernel[.]org]
> >>
> >> Having implemented nearly the same binding as what you describe, I obv=
iously like your
> >> patch. Only thing I think that should be changed is the naming. A doma=
in doesn't
> >> really describe this gated-by-fuses scenario I have. Calling it featur=
e-gates
> >> instead OTOH makes sense for both your and my use case. Same goes for =
the documentation
> >> that could be worded more generically. I am open to other suggestions =
of course. :-)
> >>
> >> Also a general gpio-controller like property would be nice. It would a=
llow drivers
> >> to easily check whether they are supposed to register a domain/feature=
 controller.
> >> For devices like yours where a dedicated device node represents the do=
main controller,
> >> it's redundant, but for a fuse bank, it's useful. #feature-cells could=
 be used for
> >> that, but I think a dedicated property may be better.
> >>
> >> Let me know what you think and thanks for working on this!
> >>
> >> Cheers,
> >> Ahmad
> >>
> >=20
> > Hello Ahmad,
> >=20
> > I'm very happy that you are interested in my proposal. It will be great
> > if we produce common binding to suite both our requirements.
> > I agree that binding should be renamed, but I don't think feature-gates
> > name would fit my case.
> > IIUC both our cases requires different devices across the system to
> > provide some information to the controller device. This information
> > could be used to identify the devices later or to make some
> > controller-specific configuration. In this case I would prefer name
> > "device-feature" or "bus-domain", suggested by Linus Walleij.
> > Also I like your idea to add dedicated property. This will make binding=
s
> > more clear.
> > Summarizing all above, I would suggest the following names:
> >=20
> >  feat: &ocotp { /* This is the efuse (On-Chip OTP) device */
> >      device-feature-controller;
> >      device-feature-cells =3D <1>;
> >  };
> >=20
> >  &vpu_g1 {
> >      device-features =3D <&feat IMX8MP_VPU>;
> >  };
> >=20
> > What do you think about this?
>=20
> Sorry for the late answer. Full plate before vacation :)
>=20
> A device- prefix for device properties is kind of redundant IMO.
> And [device-]features is somewhat ambiguous (it's not
> a list of features of the device, but a list of features that
> control the device). I see that gates might sounds a bit odd, how about
> feature-domains, feature-domain-controller, #feature-domain-cells?
>=20
> Cheers,
> Ahmad
>=20

Hello Ahmad,

feature-domains works for me as well. I will prepare patches if nobody
have any additional comments.

--
Oleksii

> >=20
> > Best regards,
> > Oleksii.
> >=20
> >>
> >>>
> >>> I think we can cooperate with the bus controller framework developers
> >>> and produce the common binding, which will fit the requirements of bo=
th
> >>> features
> >>>
> >>> Also, I think that binding can also be used for STM32 ETZPC bus
> >>> controller feature, proposed in the following thread: [2].
> >>>
> >>> Looking forward for your thoughts and ideas.
> >>>
> >>> [0] https://urldefense.com/v3/__https://developer.arm.com/documentati=
on/den0056/latest__;!!GF_29dbcQIUBPA!2j_vN6Jc1k2XI3EegAC2yzTLgJ1Rw1DhDrjGF0=
3a5tDtOGpm_qp9B0zHJeAJzw-fWOeJp5HtnzYmOJZ0XPJxH59KKjhc$  [developer[.]arm[.=
]com]
> >>> [1] https://urldefense.com/v3/__https://lore.kernel.org/all/201903181=
00605.29120-1-benjamin.gaignard@st.com/__;!!GF_29dbcQIUBPA!2j_vN6Jc1k2XI3Ee=
gAC2yzTLgJ1Rw1DhDrjGF03a5tDtOGpm_qp9B0zHJeAJzw-fWOeJp5HtnzYmOJZ0XPJxHy1kyyW=
Z$  [lore[.]kernel[.]org]
> >>> [2] https://urldefense.com/v3/__https://lore.kernel.org/all/202007011=
32523.32533-1-benjamin.gaignard@st.com/__;!!GF_29dbcQIUBPA!2j_vN6Jc1k2XI3Ee=
gAC2yzTLgJ1Rw1DhDrjGF03a5tDtOGpm_qp9B0zHJeAJzw-fWOeJp5HtnzYmOJZ0XPJxHzVdVT4=
B$  [lore[.]kernel[.]org]
> >>>
> >>> ---
> >>> Changes v1 -> V2:
> >>>    - update parameter name, made it xen-specific
> >>>    - add xen vendor bindings
> >>>
> >>> Changes V2 -> V3:
> >>>    - update parameter name, make it generic
> >>>    - update parameter format, add link to controller
> >>>    - do not include xen vendor bindings as already upstreamed
> >>>
> >>> Changes V3 -> V4:
> >>>    - introduce domain controller provider/consumer device tree bindin=
gs
> >>>    - making scmi node to act as domain controller provider when the
> >>>      device permissions should be configured
> >>> ---
> >>>
> >>> Oleksii Moisieiev (2):
> >>>   dt-bindings: Document common device controller bindings
> >>>   dt-bindings: Update scmi node description
> >>>
> >>>  .../bindings/domains/domain-controller.yaml   | 80 +++++++++++++++++=
++
> >>>  .../bindings/firmware/arm,scmi.yaml           | 25 ++++++
> >>>  2 files changed, 105 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/domains/domain-=
controller.yaml
> >>>
> >>
> >>
> >> --=20
> >> Pengutronix e.K.                           |                          =
   |
> >> Steuerwalder Str. 21                       | https://urldefense.com/v3=
/__http://www.pengutronix.de/__;!!GF_29dbcQIUBPA!2j_vN6Jc1k2XI3EegAC2yzTLgJ=
1Rw1DhDrjGF03a5tDtOGpm_qp9B0zHJeAJzw-fWOeJp5HtnzYmOJZ0XPJxH_HqFmwM$  [pengu=
tronix[.]de]  |
> >> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0 =
   |
> >> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-55=
55 |
>=20
>=20
> --=20
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       | https://urldefense.com/v3/__=
http://www.pengutronix.de/__;!!GF_29dbcQIUBPA!3ZZDuNOsR-mCQt8F9mbsVQvjDi0X_=
yfmxS65xA-VBjaknyBBRUGdS2y5z6lnRcdi0AfVhp0n_2LXh1V4GabWEUYzqKJ3$  [pengutro=
nix[.]de]  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|=
