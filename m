Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02E804C0037
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234659AbiBVRfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbiBVRfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:35:34 -0500
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A37216FDD2;
        Tue, 22 Feb 2022 09:35:08 -0800 (PST)
Received: from pps.filterd (m0174680.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21MHN8aM016345;
        Tue, 22 Feb 2022 17:35:03 GMT
Received: from eur05-db8-obe.outbound.protection.outlook.com (mail-db8eur05lp2105.outbound.protection.outlook.com [104.47.17.105])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3ed46e8167-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 17:35:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GJSVudjTk6tfATe0czdwKIyUImDmbjKno2bn45Bto4HjIJQBhjOW89mm5eGS613HHhH5kchYQDbCmXfXAX4frgMQQTjnllfI3L0nVS7yGe9wr0CxO0OYNpPojcr62C+KcijG6QVDeT1YeRJ+5rXSc0DJaJtaaQejAhlhTQSw6eHe+J1Nt5bEN+Bjv31c+YHSW86qcZ48nOsuAJ8Uz5GYiV6YPTKtLi8nZh5Rwh2OI6cG3WDdh5NF+I2gl3ly3bk2rsfucaPcjqLpAc+3Ra5oB3C+jdDSj7wk9OkCsSAZ0X8EdldMhs+w2LqBC1Hf7KiaGaNynMfRip+lM3mGmrLA0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70xpp7jgAFZapTxMW9lCIf1O9X3tYKous6KDx35Gjik=;
 b=MMU5DKBqMUoSwmYhMGJUZ1MAyud+5AJanPTywpFqhQy7O7FeyZ6oxk2zFEO7kvqRor5RY4R5QH9wi9/eYNyaakGLa6ArTlTO2h2m7ZILDMvZ5IPeogCb9zewK7R7ezFxLM7DnwTp2QMTNv8Y9ab7+ev3Xnq24RFHpt8bowDJLA6ze/iIuSp8FqpFEe6XiTNS054TrxIaKFFvvNSSjlIGQztZBsKlW1KwcQ8cNI28EG/do2WlbNvgErkiw/gcU6xolITlK3f3qKFEbsrcKxW8vOe13deZlj8dIzNjtsii4MSsHhnpsTdgaDAyDoggvIFQF7oz5HdTISXijKD9m4K6LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70xpp7jgAFZapTxMW9lCIf1O9X3tYKous6KDx35Gjik=;
 b=IzOO6Iw45/oL+1WR9ITTMjPiAInNgWIqmFEX9T4o88ey8ARP2GiLdOMwjugejkWK5m6THBMEoFpyRiS1a+ey4TjPaMleRthdzSLDawhnJRq5KbdxIo7mw7jKOrXPu50L1MjCEpIMJMbZATUqyk2IiFz/YfEuRC6epSOplDGnIFe3hDiWz4/gyJ6x9PPbbUa71+JSZ89L8H2AjPLUv8O+bYpM6yQRf3gZwae4Y2AOhsfRB+Jt5/cs4G4CCdPkKNEzgrUHTiXdfB5omS7WsHjN/wvJyapegb82Dl/SfVMQn7QyAmrazWUpQUa4/qwBsfcr3Mv2/xTLN6tJIEp+3WUi+A==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by HE1PR0302MB2812.eurprd03.prod.outlook.com (2603:10a6:3:f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Tue, 22 Feb
 2022 17:34:59 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::c1c:f98:9dd:86e0]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::c1c:f98:9dd:86e0%5]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 17:34:59 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Krzysztof Kozlowski <krzk@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] dt-bindings: arm: Add scmi_devid paramter for
Thread-Topic: [RFC PATCH 0/1] dt-bindings: arm: Add scmi_devid paramter for
Thread-Index: AQHYJ0gzI98NnKSQaEaZikv/1tAERayefeSAgAAKkQCAAK8mgIAAiGsAgAAWbwA=
Date:   Tue, 22 Feb 2022 17:34:59 +0000
Message-ID: <20220222173458.GA2310133@EPUAKYIW015D>
References: <cover.1645460043.git.oleksii_moisieiev@epam.com>
 <2546477f-4190-e838-3095-f47b31802445@kernel.org>
 <20220221213932.GA164964@EPUAKYIW015D>
 <7f17ab8f-429f-d2e0-8f5f-bfa2dd19cc49@kernel.org>
 <20220222161440.xadrgjftdyxenxgo@bogus>
In-Reply-To: <20220222161440.xadrgjftdyxenxgo@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d6a62685-1328-4920-6fbd-08d9f629a655
x-ms-traffictypediagnostic: HE1PR0302MB2812:EE_
x-microsoft-antispam-prvs: <HE1PR0302MB28125C316D8A51A765788A58E33B9@HE1PR0302MB2812.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3YvCKBIsSX4C4m/puGyAJ3CT5f3zkoDCX2Fvm7okEDYIIqzDqTSjWQxXfzfoS327y6uATEvQ8MxWNumrFFgSOBLatELS4a64kBbLDoyY89CDs75P3C+OlCoS9dkjECUsdOjdP15snrRCqTHaIh7MSeR7nrSG0U9x/YVyIw42cYXhvFF+fOR+KKHpa1oe/n1vUBGUDsheBMG+U60HfWsk/Fo9JSnXd/oguyhkh6kShHoF28KIrY6cT1GakXSBrMTTxfUvCeTeJL1luH/k5oTtYQQV1KWTwsv+1zNQTWRxGSPgt7mrwcc01/TR01OV+h1PIQ6e7cKH+Ibo6kEo20bHLgsM5EO5ZxT3QUDNgo9+rGb9hGJ/b1ODl820svvQ+9RHPuW6bjQJsdy9Jh/NGoRGt3x7uMDTztmQVor5OMmIhln8uEOItOP9/wMII1gV83QiQKYasVyLgv7l4z3LzkqBEo3i7hi4i42DT0z5EXoUSV8x5/IFW0bnkLR9j9cI2FSnElyf6cGWuiIR0+HOK4/W2hrGj2Cj7mMeo1ZimN6equO7IMAslKC85N7MpKo/CkonrB/Z8nI2B1xbSSCjMcVBiYQZYtLC8oalW+qWWgZRtFOBj9rak3BY9NFxsK/CVP4AwxhgxHvtU+eX5yadTyxfjLd5cc9tySy6TpV+J7mO7qdkZL94jU1xtnRV7WBzUpdvg+b1X+tqozdPujuc7GWFfw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(66946007)(76116006)(66556008)(91956017)(64756008)(6916009)(54906003)(83380400001)(71200400001)(508600001)(4326008)(53546011)(8676002)(66476007)(66446008)(33656002)(6506007)(6486002)(122000001)(33716001)(26005)(86362001)(1076003)(186003)(38070700005)(8936002)(316002)(9686003)(6512007)(38100700002)(2906002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kwzFnvNrbqANCeoGktrrBbt4Gi9ZWh4/Ua6Zu48pNiQpvOAWMcP7616tkdLu?=
 =?us-ascii?Q?hTKPz26xh9ShknC/gY4pmTCqBE2SIOo00ENHTdVysay01bjrOSHnveit/Lg7?=
 =?us-ascii?Q?BRISHar6AeP554jLaMvTgyad1luRtcCKfmrAmLp6nTme9LRxoNZ++3eiu8DA?=
 =?us-ascii?Q?D9Y1/ZGLv/D1DnKaRdfEsSJXjxf4QmvzqiR6P5Jj5GpF2wyqxTgkgDBrF2Av?=
 =?us-ascii?Q?Ofp5BEcAH259zpuaGoSyRlTYPCUGvL8hMRJmXiwRkXFAYds2Q7p5+Ij8OyyC?=
 =?us-ascii?Q?xYMSdbT6BwRE53duVK8cMv03B81XV/njmOJJErcNOPP8PYFpwRWLwb873MgJ?=
 =?us-ascii?Q?wO/LQoxxfPJGRAlpC+Y6uH+9plKDjw+6OULb11atkUq1skUFOVkuCRvtllrU?=
 =?us-ascii?Q?7DmksOA3Px6AzPNfVb5kI7VTumSE2Rn6R7y2nxN5pbYY8WXrVLrkIKUkHdt2?=
 =?us-ascii?Q?d3mi4puHF0od4eDR2ZUI5LGnODhWcbCYRgJW0JG9HTuA4QuGRVEWQn4J5u2z?=
 =?us-ascii?Q?2l7pJ+X/8w/FoaVqZ818txHtCtSGV/WL9J6zYEpPe2SdIAhShR/M+31BmQgV?=
 =?us-ascii?Q?uItCIAvNt5+x/mqrmuyEIEKkOUf91Nr8WCrZFMTlFuX0g+kQm9XMrr4IHoWh?=
 =?us-ascii?Q?wHPUQmPv3MlkwVuTxlIZb2YYN3u9GnnKqRBTcjRPSP8Sx/D2cLW34OfvAOr/?=
 =?us-ascii?Q?YyhmrTV5OfkTmuMv4y+YbmKDXEslg8Sygp/0U6K8v4WjY1rXD9nYStd3esZg?=
 =?us-ascii?Q?+acsUXPWUDgEYH3HzfvGSekCH0Qy8vTDUSzc+ErbdtUCW4yK/N10FAyJh6hD?=
 =?us-ascii?Q?28lrsxeYpu2yXbYdnZRuJPjV4TYanCz9jh9ftU8dd+EjlgWWYl8Bygh80pvS?=
 =?us-ascii?Q?dWWYG2wOqbe2w3nEmTKWHHyaU2K2bHJQO63cCuOxuyQICpvr2Ten5z/fM4XH?=
 =?us-ascii?Q?vUqadW+X31YNLHrgNiEgt41i+9Rm1zgROhX1vahXvvKC02N3PeaRGI5MACx7?=
 =?us-ascii?Q?lNycnmIeP/JpNqmbzwLPUXDDz/64d8IPoEOQFwWlqj2ChheimNjPFljmNAkg?=
 =?us-ascii?Q?toJUaqSD6JEFet0M9Ae0CPxh/7XxMIbChqhIY85dvrzfMGSU73bRtD6ishSp?=
 =?us-ascii?Q?sa3umrCAYoH6W0IJ4fDBVrgHIjxvOQY8mhnU2n36e1yr0+vZ2WaEC51jIQ7j?=
 =?us-ascii?Q?TiBt4UHGH2XJ3fdfd11z7Rev+ky9uEV7y9FWEIypoYpG02ETyMa6IVNtJi/X?=
 =?us-ascii?Q?osks+n7pIKo2XOcJsoU/zVii4lGOQ5Y7tvU+uyJouI0x5vBjrxCF5CF6JSVG?=
 =?us-ascii?Q?16HeSzvRWzgz+rBzPE4SBu3HBUlFs/kVsnW1hFkkM/qYv0Gw/EQup3akde3O?=
 =?us-ascii?Q?gtg7+ceBlScP7hhY7yl+6NZ3LlwNGViWLB6WD95o2YBg5uTFy9UGrk22JTLS?=
 =?us-ascii?Q?RnE8F6IB34oIBaTTUEskXANUJpPV/NcKkSqd7iPUwwlDUfFm89IDufYg/XQ5?=
 =?us-ascii?Q?le/IRNSlw5OAaEmVyVYiU+Z6qMfqlb9az/4z3qwlc0iNEFOy6ntht0zvCWk0?=
 =?us-ascii?Q?IZfLS8G/8OOPwv3ZcJP4dnn+vr3BNrTYdMAbIXf+E3iIsYzUPKmI0fEUq9bZ?=
 =?us-ascii?Q?VYWaT6xCSGZoAsoUgPYbhvF19hQkSB+/OcQbmI8/ie8+8Wpnv9gCxCTpU1YN?=
 =?us-ascii?Q?wb20qORY0qsh0A9DpccR1RNEhuw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <BC5CF11C430846449F3F5BC657412671@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6a62685-1328-4920-6fbd-08d9f629a655
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 17:34:59.3563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OuTPrccx3Q8wc3bQDQ2DKe2FPvG4+enTDdX+TWZAmgbFuGyMvU41mGiZIBrpyd+YBRTF4LwSCo8r7vfw2xD7hTcRSXNntDW3tlaF5LTMsOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0302MB2812
X-Proofpoint-GUID: 5njnDgzxWdbgA1uzuYnQVTySHNJoJcbf
X-Proofpoint-ORIG-GUID: 5njnDgzxWdbgA1uzuYnQVTySHNJoJcbf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_05,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 adultscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202220107
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 22, 2022 at 04:14:40PM +0000, Sudeep Holla wrote:
> On Tue, Feb 22, 2022 at 09:06:25AM +0100, Krzysztof Kozlowski wrote:
> > On 21/02/2022 22:39, Oleksii Moisieiev wrote:
> > > Hi Krzysztof,
> > >=20
> > > On Mon, Feb 21, 2022 at 10:01:43PM +0100, Krzysztof Kozlowski wrote:
> > >> On 21/02/2022 18:26, Oleksii Moisieiev wrote:
> > >>> Introducing new parameter called scmi_devid to the device-tree bind=
ings.
> > >>> This parameter should be set for the device nodes, which has
> > >>> clocks/power-domains/resets working through SCMI.
> > >>> Given parameter should set the device_id, needed to set device
> > >>> permissions in the Firmware. This feature will be extremely useful =
for
> > >>> the virtualized systems, which has more that one Guests running on =
the
> > >>> system at the same time or for the syestems, which require several
> > >>> agents with different permissions. Trusted agent will use scmi_devi=
d to
> > >>> set the Device permissions for the Firmware (See Section 4.2.2.10 [=
0]
> > >>> for details).
> > >>> Agents concept is described in Section 4.2.1 [0].
> > >>>
> > >>> scmi_devid in Device-tree node example:
> > >>> usb@e6590000
> > >>> {
> > >>>     scmi_devid =3D <19>;
> > >>>     clocks =3D <&scmi_clock 3>, <&scmi_clock 2>;
> > >>>     resets =3D <&scmi_reset 10>, <&scmi_reset 9>;
> > >>>     power-domains =3D <&scmi_power 0>;
> > >>> };
> > >>
> > >> And how do you prevent DT overlay adding such devid to any other nod=
e
> > >> thus allowing any other device to send requests with given devid?
> > >>
> > > Thank you for the quick response.
> > > scmi_devid value will be used only by Trusted Agent when the device
> > > permissions are set. Non-trusted agents, which in our case are
> > > represented as Guest OS are using scmi drivers, already present in li=
nux
> > > kernel, ignores scmi_devid and uses scmi_clocks, scmi_power, scmi_res=
et
> > > nodes to access to SCMI protocol.
> >=20
> > Ah, ok.
> >=20
> > >=20
> > >> Plus few technicalities:
> > >> 1. Hyphen, not underscore in property name, so scmi-devid.
> > >=20
> > > Thanks for the tip, I will change that in v2.
> >=20
> > Few more thoughts:
> > 1. This looks specific to ARM SCMI, so you also need vendor prefix, so
> > something like:
> > arm,scmi-devid
> > arm,scmi-device-id
> >=20
>=20
> Keeping the other discussion separate, I wanted to comment on this.
> I agree with Krzysztof on having vendor specific prefix if we decide to a=
dd
> this device id thing. However, I prefer not to use "arm,scmi-" here.
> It can be "xen,scmi-" as we had plans to introduce some concepts in SCMI
> spec that may use looks like this device-id. I would just like to avoid
> conflicting with that in the future. It may happen to be same in the futu=
re
> (i.e. this xen device-id matches 100% with definition of device-id we mig=
ht
> introduce in the spec, but I want to make assumption otherwise and leave
> scope for divergence however small/little it can be). No issues even if
> they converge and match 100% later in the far future.
>=20

xem,scmi- works for me. What do other thinks?=
