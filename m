Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07C184BF426
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 09:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbiBVI4M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 03:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiBVI4L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 03:56:11 -0500
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E50118627;
        Tue, 22 Feb 2022 00:55:46 -0800 (PST)
Received: from pps.filterd (m0174677.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21M8d2Bb023645;
        Tue, 22 Feb 2022 08:55:40 GMT
Received: from eur01-db5-obe.outbound.protection.outlook.com (mail-db5eur01lp2057.outbound.protection.outlook.com [104.47.2.57])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3ecvgh82f4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Feb 2022 08:55:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I5iKXHEFHXhd6qkm6RPWgTMbXBQxxZ5Gsu6mgPkCmc9uSM0FcLnqwxckZRmPNY79NL6h05kaYfgw9aqlDjR0Yxa4MYo42u6E6YAFNAiaYpeVVaI0WKtjh2zUSfTu60oETC8oXBmUvEpfLM85LXtcUe3ORjlmrDgTBrq1t5xylL6p3VqEF58vBcmWRlO1paIXO3cqToVlzZ3TsYajgH5qbFwJAlrQxd6/jy3XJwrmSthUR/rA/Y3u8IEYtjTaWO6DgryHU6cfh3cPHTutpqNDZAJT3N+F2xPzYD4PyQQ7Yhixf1QD3Rdl3d+SVZm9T0lYVV+mi0Y8+9khig3nNjBrjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjQS1LBBzIHzQ8wTDgdLHnbjSQxPpOaws0tq6tO9FMQ=;
 b=JI/9O8GLOMyiYQJPX+QjOMiNAzmvj8mB8oArNfGFQeI6+UaTwtE3WMt9XY0vfSoIyknFA3LCrrnSq6TEDqQ3jUy+V6nA5fCD0Vehdj2nN3YnrSI68hBjTA05MGhZvLMyDWTAWXeg/NvWPgPKVIdEYxWnD5D+cye8g9hR5rDkI5M7ngaPBVzJv0q0pyP3sittX0V80sdi9g/CDy1SjZ7Q73VhH70Y4Q9rMByExlU9Hu8UqL1L98ZURhY+JeOu20st6JnJrtetoiGSqDpk0MjHoxxGAzGrMEvabeclRaFXLwwQtWIsihZG8Fu6NGz2BAf+e4TJhUnvqxBPpLJAkm83sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjQS1LBBzIHzQ8wTDgdLHnbjSQxPpOaws0tq6tO9FMQ=;
 b=Ld8NtEW/fZ1jFEGYFtPNY2hZYkl5ERrrXXleuhZxbpGrldYW8+Cbp0CC+10zCd21ruAtKthO59wWN4JmZIRr41l6HcprHnSaiU+UYjBWmel+wJNi/OzXdcFmbZVL1PekGPKgQenbHNdUm1ARvdp5x6z5KxbjfUJSkGgYD9+6dJi/oTffTCB6PvwaMkd736Z+jISDpRJUMOko/wVRfa396zIWOO/u/hQOI1g6jG039UeL60vsfu5pZ6vVNZ5ixerJWgJIqknRo2JncJglhtATXGukU4rmStTRPA5lqnAE2nuUqaUXDg5lur59LF+nEhm+fuyQuDy192rM4/lLl1KV/Q==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by VI1PR03MB4637.eurprd03.prod.outlook.com (2603:10a6:803:5c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Tue, 22 Feb
 2022 08:55:33 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::c1c:f98:9dd:86e0]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::c1c:f98:9dd:86e0%5]) with mapi id 15.20.4995.027; Tue, 22 Feb 2022
 08:55:33 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
CC:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] dt-bindings: arm: Add scmi_devid paramter for
Thread-Topic: [RFC PATCH 0/1] dt-bindings: arm: Add scmi_devid paramter for
Thread-Index: AQHYJ0gzI98NnKSQaEaZikv/1tAERayefeSAgAAKkQCAAK8mgIAADbkA
Date:   Tue, 22 Feb 2022 08:55:33 +0000
Message-ID: <20220222085532.GA439897@EPUAKYIW015D>
References: <cover.1645460043.git.oleksii_moisieiev@epam.com>
 <2546477f-4190-e838-3095-f47b31802445@kernel.org>
 <20220221213932.GA164964@EPUAKYIW015D>
 <7f17ab8f-429f-d2e0-8f5f-bfa2dd19cc49@kernel.org>
In-Reply-To: <7f17ab8f-429f-d2e0-8f5f-bfa2dd19cc49@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e8feb07-28c9-48bc-bdb8-08d9f5e115f7
x-ms-traffictypediagnostic: VI1PR03MB4637:EE_
x-microsoft-antispam-prvs: <VI1PR03MB46376C41EC0421DF22B9B6C0E33B9@VI1PR03MB4637.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i42N/idSFdUe7qu2FMC1mZPQexAOjBuEAYly07QslUeShutmqx1UkE+3wHNMlj6gMUE1fis3IEGhNceOGQ1SoB6a4v9biPGCoh3Fkzzi+ButYyo39sa8y5jZWloiXWx8byFpnyXvAnnG4A9zSqAWklEyB873aQdeK8Af3iRa9AqVODYDTOxTcKx0nG5cNkp5sWovZqkBnz7NJPXhEQclSyqGZQ3ixC6Z42I6+KiAs4sKvbDocHeAzDRyyiA7qnTxjt9kRZ6Ttee/2EQAsDdXA8VwDKH4kO8DaX77wqMim8/B/FD7BqEW9IalfAN9OWZID7fJa9nAgjDLoGPlxUXfDZQzczfq01tqvZFRcvJvAC8HISybDHpCEhOyXx60s9LqaBPQGTiC71yO+AoOQlnys+l92P9MmH2QJmFzs0oj6VvSAbnRxSRvBTGuzntvmzIW1ECMmnTcB3rVbGmQUSHIXntRLY6B5iL6i4A1ec+TbNA27VRm1KT65zdfKCPB63qw+alNsxCGGwpAGiQlvPPAjJ08tL8eofY00KWZ8ls8ReCbDp7gP84itlpq6paX6YN2gVzCKlriB0ngXsiuDv9+dLXW9Cx6OqpHmdQSQ6TuhbWnZU5vhJTTTc7NWHRp5W5iBXcl/aDrXu6EskoLZoEXUuhFZiP5tYt8MzE+disga6H2usjg/MeNj/FTpKypHV/bjNtbU6wop+s9vuLTTzsccowp/6sFR7DUm9rl7qCS/xxP3Dm/Pgx5LYKiMXE6a6DS
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(33716001)(71200400001)(1076003)(316002)(5660300002)(86362001)(54906003)(6916009)(26005)(83380400001)(186003)(66556008)(76116006)(66946007)(8676002)(9686003)(66476007)(66446008)(64756008)(2906002)(91956017)(6486002)(508600001)(38070700005)(38100700002)(6506007)(33656002)(4326008)(6512007)(53546011)(8936002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qsJd2Trh/BIzZZKm/imaZRr+8MZakX6skXVPABvkNqDK7MJaJw4NeZ7Dr6pQ?=
 =?us-ascii?Q?+E2YpmlzYSQ6673uAc2nccLYdLt9ZfubIOAd1DrjBMZu5bhbbmITCmPiQl0Z?=
 =?us-ascii?Q?Ue+Hs9DSMGmZy2WzKC5VE+cD4lREDS4PcoHAq2Mv6XQz3CkHscbqiXISyzvV?=
 =?us-ascii?Q?zu+jQDYdunPxm0bD+QxJ/FZQkPeLm+n+eQDbqg4BhGg9AL4b4oVt4fCqULYa?=
 =?us-ascii?Q?ujspQCWh7A2WU7QdO72WBWNKNyRJuDW6yiMMCP6qArSCV3tCTeEJKHiHuqq9?=
 =?us-ascii?Q?tn2/xwyKi7WUDSPDqYSQBPzkciwmzSMZCQ9H0JraUaF9kgX2XKnk+60E/N8f?=
 =?us-ascii?Q?A70AvEKdVr4kHmTzy5Yn7yiU7Uq3n96IIMoSvcWYoG0AjkNYD92t5OOBncdU?=
 =?us-ascii?Q?BegztV36bee1jVKw8HTkCPJ5i0s1eLUvayWRIBCMAr9wG+G/BtA0e3voEhiD?=
 =?us-ascii?Q?ajkvbihPd+2A2f7qTmmh8NHhhj/LJ7UvV15XycGebJT++jEaP9jhtTQlK5Rs?=
 =?us-ascii?Q?qVqYGIkBRPHmxvkesy4ChhgR5L7HV70za650IE8ZX/kmmcuMI5eEcn4rOIiZ?=
 =?us-ascii?Q?PmEUUADsjsUObzLZKm72kMJgcbFPH0ifA5x+kt9rDtFj4JOYEd82iq2LqImB?=
 =?us-ascii?Q?GERv04w1ShowmpTW9tBvrnkIqALvNtj5D2ivU2GfYKHRGwyMEVLIXVdCd8Kl?=
 =?us-ascii?Q?bU/RuEcCrSgJ6AV79hvmhQ8tuyfmF6yNtsgv8vpcLNlkkZ1nWx/XHcUbNTOi?=
 =?us-ascii?Q?WmTMxmWkL+SdBsFrLy0B0BTjq1FyL15YLruNkrnQkDtdWviu6LzbURE0PVNk?=
 =?us-ascii?Q?17HObMgoKeJSh98lB9sHxeeXDLxjDg9h7NAqzEBEnaTpGhzxfGXEB+Snrht4?=
 =?us-ascii?Q?KmCPKkGosjQMlcNqBqhQuvMYadAmzVjjxGc8eb8jj/3iQwit5WbZPYtbnp5Q?=
 =?us-ascii?Q?BsHGRwZQOiPBrZH19SLPW+m2GHU+ttCsrR+d4hUaIQkk8qnOiMZnejgXc9Sq?=
 =?us-ascii?Q?b1WnQ7w/HgEih/dN3C/E8UDo1EOqg1hYkbiMTQ0cLToHbFXI92LKxGh7X+9j?=
 =?us-ascii?Q?eSgy7snCwTtpOW5bt/KRy7Z8iAON06CGv937Gwg+Ljk5pTvw918LYpVrq9QR?=
 =?us-ascii?Q?f71e/sbfPJiSSFEDiblARGJE1amqaXOCZm7AVAsHKq0iEnyhTIiEQDB8YKB9?=
 =?us-ascii?Q?yOvHz+SD5VPtk8L1HcQc5Y11hceGcguOCZE7MAdxJXYLoqysHp/yl6CXTWxr?=
 =?us-ascii?Q?XbarzEZuYPKfkR3NPwDB1f/2tZICf/2QYSODcwoQtbymqPYPT6i63MFYn0Ln?=
 =?us-ascii?Q?P3G3XwYjMC+y8AG6DJzfuZ109UOKPv7Vmbw7SX3hh3+1YmqDjoxjKBKxyhJA?=
 =?us-ascii?Q?96K8qCG/8euUm6AJDTGKNaqKMVlJhghwUv95O4paAz6+KFjLegZklJbv9H7+?=
 =?us-ascii?Q?eRuzyhjiKWmFQqHgz28ncvaopGK0VCR3cwrmDIUro2qc+AG1EXVYY5tFsW15?=
 =?us-ascii?Q?gt9TVaVOpNmxnFPhftO1Vug81JWroFw24CyltK4wV7PyuaC9ImIco7WFW73a?=
 =?us-ascii?Q?WHXmApqkc0FJxoMt6caH3W5ammQG8Jc6q3owVOxuMT80B3+5J9fSz7xEMSlE?=
 =?us-ascii?Q?e4hV0uMa/sBGacyz5u3jV/9B3F1hFjN6tiMRqJ1mM3ymUkaRNl0BlF0slbDf?=
 =?us-ascii?Q?UZP66WYmO5nDyiOozfyQDFGJiPg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5DA0B660C31F7746A411074C438D0ECE@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e8feb07-28c9-48bc-bdb8-08d9f5e115f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Feb 2022 08:55:33.3858
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nPjrV821gtjUDnM4kDhwY28ZC0p8MjbXcMl2n4e4bP8+d/6mosIFTm3QIVIuj6LGw36YDrRqC0AlREp+gw8VHfvq78uASZrayBUoFvLPA84=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4637
X-Proofpoint-ORIG-GUID: oIkoBH0-DjXphLNJdin69ytocZR2c23h
X-Proofpoint-GUID: oIkoBH0-DjXphLNJdin69ytocZR2c23h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-22_02,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202220051
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Tue, Feb 22, 2022 at 09:06:25AM +0100, Krzysztof Kozlowski wrote:
> On 21/02/2022 22:39, Oleksii Moisieiev wrote:
> > Hi Krzysztof,
> >=20
> > On Mon, Feb 21, 2022 at 10:01:43PM +0100, Krzysztof Kozlowski wrote:
> >> On 21/02/2022 18:26, Oleksii Moisieiev wrote:
> >>> Introducing new parameter called scmi_devid to the device-tree bindin=
gs.
> >>> This parameter should be set for the device nodes, which has
> >>> clocks/power-domains/resets working through SCMI.
> >>> Given parameter should set the device_id, needed to set device
> >>> permissions in the Firmware. This feature will be extremely useful fo=
r
> >>> the virtualized systems, which has more that one Guests running on th=
e
> >>> system at the same time or for the syestems, which require several
> >>> agents with different permissions. Trusted agent will use scmi_devid =
to
> >>> set the Device permissions for the Firmware (See Section 4.2.2.10 [0]
> >>> for details).
> >>> Agents concept is described in Section 4.2.1 [0].
> >>>
> >>> scmi_devid in Device-tree node example:
> >>> usb@e6590000
> >>> {
> >>>     scmi_devid =3D <19>;
> >>>     clocks =3D <&scmi_clock 3>, <&scmi_clock 2>;
> >>>     resets =3D <&scmi_reset 10>, <&scmi_reset 9>;
> >>>     power-domains =3D <&scmi_power 0>;
> >>> };
> >>
> >> And how do you prevent DT overlay adding such devid to any other node
> >> thus allowing any other device to send requests with given devid?
> >>
> > Thank you for the quick response.
> > scmi_devid value will be used only by Trusted Agent when the device
> > permissions are set. Non-trusted agents, which in our case are
> > represented as Guest OS are using scmi drivers, already present in linu=
x
> > kernel, ignores scmi_devid and uses scmi_clocks, scmi_power, scmi_reset
> > nodes to access to SCMI protocol.
>=20
> Ah, ok.
>=20
> >=20
> >> Plus few technicalities:
> >> 1. Hyphen, not underscore in property name, so scmi-devid.
> >=20
> > Thanks for the tip, I will change that in v2.
>=20
> Few more thoughts:
> 1. This looks specific to ARM SCMI, so you also need vendor prefix, so
> something like:
> arm,scmi-devid
> arm,scmi-device-id

That's a good advice. arm,scmi-devid looks good for me.

>=20
> 2. Does your example work properly? Passes dt_binding_check? Reg looks
> different than unit-address.
>=20
dt_bindings_check passes without errors. Also I've checked this file
explicitly by using command:
yamllint -c Documentation/devicetree/bindings/.yamllint Documentation/devic=
etree/bindings/firmware/arm,scmi-devid.yaml

Reg value, if you mean reg parameter from an Example, was taken from
r8a77961.dtsi file.

>=20
> >=20
> >> 2. Your schema does is not selected by anything. How is it intended to
> >> be used? Nothing is including it, either...
> >>
> >=20
> > The idea is to use this parameter to set the device_id for the device i=
n
> > the device-tree, which matches to the device mapping in the Firmware, s=
o
> > Trusted Agent can use it to the device permissions.
> > Please see Sections 4.2.2.10 and 4.2.1 [0] (Link was provided in the
> > cover letter).
> >=20
> > I'm currently propose the new feature, called SCI mediator to Xen-devel
> > community. Please see link [1] from cover letter for the details.
> > In this feature - Xen is the Trusted Agent, which uses scmi_devid
> > parameter to set the device permissions.
> > We think that this parameter will be useful for other possible SCMI
> > implementations, such as other hypervisor or SCMI backend server etc.
>=20
> We talk about different things, I think. I was asking how is this schema
> selected?
>=20
> I gave it a fast try (dtbs_check) and it confirmed - schema does not
> have an effect. It's a noop. You need something like "select: true", see:
> Documentation/devicetree/bindings/nvmem/nvmem-consumer.yaml
> or this schema should be included by other schemas... but then I would
> be happy to see actual usage in this patchset (more commits...).
>=20

I think select: true will work for me. I'll do dtbs_check and
dt_bindings_check after making all changes and prepare v2 if there will
be no further comments.

Also what do you think about maintainers: field? Is it correct? I'm not
sure if I used it correctly.

>=20
> Best regards,
> Krzysztof=
