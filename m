Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9625983ED
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:17:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243463AbiHRNOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244167AbiHRNOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:14:21 -0400
X-Greylist: delayed 14864 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 18 Aug 2022 06:14:19 PDT
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D6CCE09;
        Thu, 18 Aug 2022 06:14:18 -0700 (PDT)
Received: from pps.filterd (m0174680.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27I8Ze3q014645;
        Thu, 18 Aug 2022 09:06:04 GMT
Received: from eur02-he1-obe.outbound.protection.outlook.com (mail-he1eur02lp2058.outbound.protection.outlook.com [104.47.5.58])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3j1j26051y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 09:06:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idegcFyBwYJHe6FZWZVv6KY/hTtA2YzVbqR1A57OhWklElAWKKeGhBFGEq0GatJhR8Yzbu5FxbPOrRCN+l8M8Ob7xhwHSBcXzop9MsJ3Tktx+ot6XCSI3zSECChrodHxhgea79aZV8Nzxjxk4qaqvxJLc29n+rDgCRJI6jb+f0gn4Jh00WWX/Id4uHFDxRc7SyOVXcd1nyD+7xqGn0SVMvzNcB2CNMXlDJuD5+IUOvji8AHS/Kk9K5DWZ2E7xw93vOWMed0fDOdrKfwja6DBIh8U1auVMcdRYcjtcD3haihdyU0ctuNwsEZAC0NZJrnMzCrltWLYOouTKxsnkxvpMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xuI3DDSVTgUhm0f9AVzTTvpRb/JXWOF+Rst3O2TE1C8=;
 b=hSagvuxiiysEQrM8p1v03SDNgNJ+6VqbAo9N/pS3sa63arebIB4P6Kl4+gtFhBdZ3wU4JYRQ8+wktP8U3g/ZESpn21R64l5NkiZy/Lt6SfJrG01kxeCe2nXI0NZnc0v8OPKrEzSsm9rsud+0Ns0RVNA8eomn86fMNvyTGhb9T44kvEbigFm5GoRRMvYWBMaYa1wMDo/bRhJskNhjc5yPxvvU1bhh5DqqlYo37wXKQOoFRuGD6o3eFfcZyfPDcxVG6nimosMWu7ua/AEtz2rYNMtlFxU4AC5LzCsgEDWCPYVRFym7yJ1dOpdtIExG9U+XwLG1Gu/FHtdfoJKl+TQtng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xuI3DDSVTgUhm0f9AVzTTvpRb/JXWOF+Rst3O2TE1C8=;
 b=iof6FkmFzCMMW+U+CUZ+sGzeknYxOE17NSjWb2xpUmJBofl1PZtwMCwhImWISH7KN2DkRLHd7UzUbB0Sqq8BY9z36lxuoxLPRMaO0xzxLDIjmqd1AmCBxOkEWTxp7XD0M6l1SE0u0pSEo0YcEteaR3LCmHeiBz/GSwhobqoFPwi8LZV9xYPm5Hs0w4aQqnYPevde2Un1rGa2G1pKl2x/N05J+5ILGfg+7RoRiYBFDYbP/mNPvPvqepyDCKFxg2vN7Jmg+81jRC+bI3gqdXeQAmT+qWDt6MGWLU4KxmmdET5RsBrL4ftw+xNCXXZfLXPi4oTivZ/D0oULLxEQVZtTeQ==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by DB8PR03MB5657.eurprd03.prod.outlook.com (2603:10a6:10:101::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.25; Thu, 18 Aug
 2022 09:05:59 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::d1ad:dbe5:58e:f0d0]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::d1ad:dbe5:58e:f0d0%4]) with mapi id 15.20.5546.016; Thu, 18 Aug 2022
 09:05:59 +0000
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
Thread-Index: AQHYkevVQuji0mJdiUaO5T+/y7MyeK2wZr+AgAQ43YA=
Date:   Thu, 18 Aug 2022 09:05:59 +0000
Message-ID: <Yv4A9Rgna2bzAuvj@EPUAKYIW015D>
References: <cover.1657187536.git.oleksii_moisieiev@epam.com>
 <3ca7cd75-4b62-2380-adb0-646bbeb647a2@pengutronix.de>
In-Reply-To: <3ca7cd75-4b62-2380-adb0-646bbeb647a2@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6f40db2a-35d3-4981-3e65-08da80f8de54
x-ms-traffictypediagnostic: DB8PR03MB5657:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KMnpIhj0DyvBFgLtiTMVqT2WLrwznUJX0jHigPcTFqFpCnBhKS/rn3INZ0pL5ExuJtid7uLJcaFTh+pLZcJG2AFk17BnoPmPDLZNnsKDf6A03Jb1HNBySADAqi4MhJyYGYDBaIXp6ABeJMuUqaOwlFq1dN+GQWBX0BPUqwhTBEJnnWLGbu6ihVojPlwFAgQDeVoWeipMWqpyYF6r/sQJykcuqJvJ4fhBQ8KMc9WscMXzlcy9lbtdxkdK4lnWeN2fFZ+tCCezajfAG0KS7WS88+IF1/tA0LnaGnKyZqZzmFgMJz+BwJnYlGK0Y/Xvr/rJjKILx1Zjj1Wpy3kDBScL5UVd13PL1B+X0qSx5Glt+qW4rNXTXgW3tFM2493dD9Ws6YZTCiqIBiZ9ngJtIyPeh1nsHEjA3oIufEokXT35+8WyvG0l5nkxqzNV4cZWyIxouEGRC0tm7Ov1lyvIGCbP1IBcz5r8C3fa3MH1lPu7hHOOsDRQFHCnr0Of6DJHusJ2HfqsBxT+RefHMa5zlxv4LhV8r1n4ipewYIazxRtc8/agSq52b2NYdzs9Z0vUdvtV7lhbC6CyxZSGLFq248fhO2Ql0L5k918rP9fSYGDCgjWWZULtrrNrw6+BBYEX6a+sVTM3z5Vr+pFkTCeqyOXlRKkhSkYAZySNgBiiAzYyYbq3c6QJxLCTp70yCiu9sIbZealzo+fn5bACD4j2dIus7NpUS2dvCJTo3ljwTpEWkKIkEBXWgZSxylu9Ay3O2NHs6nofMSCThyOIc3svTCsKfB8kRVSGGcjL4Mp0XE+rCpM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(86362001)(91956017)(66556008)(6506007)(66476007)(66946007)(2906002)(76116006)(71200400001)(33716001)(53546011)(41300700001)(966005)(66446008)(478600001)(6486002)(8936002)(6916009)(26005)(38070700005)(6512007)(9686003)(54906003)(5660300002)(186003)(122000001)(4326008)(316002)(64756008)(7416002)(38100700002)(83380400001)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?3vBCQO0JqRqjbrxOZ7zg+cVaf4hESL/GhQRbnCf4yTC03h52HZk8z37qETmO?=
 =?us-ascii?Q?lnlQPzIuAB3FQmb8aMNvdu3vlNZDbnlQyOyzyHDWSHgSWwJQPrvJkH877Ryf?=
 =?us-ascii?Q?ToHi6OWRwD+0nWLapIGSXWOYBWRr+Fd6EeKauXKIw5UIWvzOCAMKQ6MwtSVO?=
 =?us-ascii?Q?0db9kAgjk1LA636+VAuu4rFhMho4mGbImoPhgER0vadQm1yrldbtb4iiYcwF?=
 =?us-ascii?Q?lyAhfVUUKXyIygNWeFncBM72p1vU3nAn576tP+tMQ/GvOMv1i093j6TNb4v7?=
 =?us-ascii?Q?g1X56MQl7b4QlmKjB0OI8e8lPsg/9lXeW+Pt6kQ3GCBu/itH7hV/TYgZYsXI?=
 =?us-ascii?Q?YLp1JusriEL8xow49jMiUFS5JnPxMiN6BAPhimVekg2ER8w1gjXFA4Dr2zpo?=
 =?us-ascii?Q?sPd+6mjm2RiyL1EPd69uS1TIqLsoXs2BPYLEd4+kGtln2/Z1EZGS9Ud++JkG?=
 =?us-ascii?Q?MiUXbjzLVb+G3CkKZ8y/4NyU3RTPTMeJ7cZ7I32hY6smzhMgN7yugJsuWebV?=
 =?us-ascii?Q?5zOQTWhr9/GtOA4UyY/uh3L7AYsKnXtW+w3lyeIXT/iDsCTVfujdloYWcO0K?=
 =?us-ascii?Q?OTRqF3AT2PuBXnX4gb+VvEWMg+wf01WR8QBpdMbzwIO6PLc+0Aa+JjQFmcbO?=
 =?us-ascii?Q?Cs1qMwFZiOC4rvDZe2fM3yBFMZ2mLiNeQBGS2fuwlI/gQrMn1Ads3NzykluN?=
 =?us-ascii?Q?yrb1IWRyL59zerREzJz+ja/NZeqXfAfCdkWqIKqwVVHf/X6p00y8/K0FdPLc?=
 =?us-ascii?Q?vZHlq866zn/QrUe2gvJhKfW/RcoZXZPhyVDcAkejsZgjMxpyN06EvXXGE8z1?=
 =?us-ascii?Q?zBEPvh0xk9kF6A14JdfwOC7U/qDmbH7wmavVrl7zNrynO0+aekgHeZj+9KLf?=
 =?us-ascii?Q?lx0KW5KF52r1XPhkf+xuDIeFj2NhOi7e+4uLg2jpF18Y0sEG06PPbTA3WtV2?=
 =?us-ascii?Q?/u8SwQe9C0m94TFW9Rk9tS7dpXbO7IlycXL0BA3Anw8DNVGKm2VRtHEpjCge?=
 =?us-ascii?Q?EJup9voZjbALFLKGTfZoS7aCQMWWMdwfBOKCsGlYj0ZTPd2dnRDCqqjxnXaq?=
 =?us-ascii?Q?eZcn/CFUmxKBYU8al2TRnlYR4we1PSjHDC0NKO9VJU/xyccdglRB+KIT40Pb?=
 =?us-ascii?Q?Q5l80UFmxHDaIs8taJtrX395LjjZRcyfSivW7rVb9kBKj8ud4RClanZM6IHx?=
 =?us-ascii?Q?Q3UrrqfkIVxQFPk9ZEF/DOVC8QHqyPscqwNxoVOpWgPJrE3JeG+OgjtaeTLC?=
 =?us-ascii?Q?L1hNPe7kOuMLd6BVFMhXpdmXk9e+WVqgpg/0MVN3OOSWkakyyUgvj2c30TFL?=
 =?us-ascii?Q?fwR3kRd2Kmn+22sQeQPEOX7Aus7v+DURgKC/M0lo7uThbve+7K2veOYXKKsZ?=
 =?us-ascii?Q?zeDcL4OIIK61kDRIs3i4nJoUJE3JJAZR0vr94CGVw2b1ne2l6NjhrBv3hd0Y?=
 =?us-ascii?Q?XNJD/oQqz/wH6+aEUCz5A1gnFWbnGu1HI7cgheU9c+HKVqlVWQgnxTLPqpPF?=
 =?us-ascii?Q?0C/Ub/xXJ66luXwJ+qh/3LwCNEwlJu2ffo4AuY8QoogEPUupEX9Ry1rCw6CV?=
 =?us-ascii?Q?JPywGeycKeNqCICoWE8Jodk7x7Eo0hrzdWjCMoyV9eIDLqSUHJMY1y+1Q/Bd?=
 =?us-ascii?Q?XA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <37F70E59D31DF14F804D7987826EE7E9@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f40db2a-35d3-4981-3e65-08da80f8de54
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 09:05:59.6185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eJVLvvu1WCYVQSsNtm7g0ei33mEXT62rzifzcTOzZoE23x/I9W54g5HxfkrYHjvnjYogJ1/UnlXCkE6E5vEKTT8Hok0BBzdmjMo26KetjRw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB5657
X-Proofpoint-ORIG-GUID: 44V9wTBeoTF_knawrHUaz35pc3UQKWvy
X-Proofpoint-GUID: 44V9wTBeoTF_knawrHUaz35pc3UQKWvy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_02,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 phishscore=0 malwarescore=0 adultscore=0 impostorscore=0
 spamscore=0 suspectscore=0 priorityscore=1501 mlxlogscore=999 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180029
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 06:37:23PM +0200, Ahmad Fatoum wrote:
> Hello Oleksii,
>=20
> On 07.07.22 12:25, Oleksii Moisieiev wrote:
> > Introducing the domain controller provider/consumenr bindngs which allo=
w to
> > divided system on chip into multiple domains that can be used to select
> > by who hardware blocks could be accessed.
> > A domain could be a cluster of CPUs, a group of hardware blocks or the
> > set of devices, passed-through to the Guest in the virtualized systems.
> >=20
> > Device controllers are typically used to set the permissions of the har=
dware
> > block. The contents of the domain configuration properties are defined =
by the
> > binding for the individual domain controller device.
> >=20
> > The device controller conception in the virtualized systems is to set
> > the device configuration for SCMI (System Control and Management
> > Interface) which controls clocks/power-domains/resets etc from the
> > Firmware. This configuratio sets the device_id to set the device permis=
sions
> > for the Fimware using BASE_SET_DEVICE_PERMISSIONS message (see 4.2.2.10=
 of [0]).
> > There is no BASE_GET_DEVICE_PERMISSIONS call in SCMI and the way to
> > determine device_id is not covered by the specification.
> > Device permissions management described in DEN 0056, Section 4.2.2.10 [=
0].
> > Given parameter should set the device_id, needed to set device
> > permissions in the Firmware.
> > This property is used by trusted Agent (which is hypervisor in our case=
)
> > to set permissions for the devices, passed-through to the non-trusted
> > Agents. Trusted Agent will use device-perms to set the Device
> > permissions for the Firmware (See Section 4.2.2.10 [0] for details).
> > Agents concept is described in Section 4.2.1 [0].
> >=20
> > Domains in Device-tree node example:
> > usb@e6590000
> > {
> >     domain-0 =3D <&scmi 19>; //Set domain id 19 to usb node
> >     clocks =3D <&scmi_clock 3>, <&scmi_clock 2>;
> >     resets =3D <&scmi_reset 10>, <&scmi_reset 9>;
> >     power-domains =3D <&scmi_power 0>;
> > };
> >=20
> > &scmi {
> >     #domain-cells =3D <1>;
> > }
> >=20
> > All mentioned bindings are going to be processed by XEN SCMI mediator
> > feature, which is responsible to redirect SCMI calls from guests to the
> > firmware, and not going be passed to the guests.
> >=20
> > Domain-controller provider/consumenr concept was taken from the bus
> > controller framework patch series, provided in the following thread:
> > [1].
>=20
> I also was inspired by Benjamin's series to draft up a binding, but for a=
 slightly
> different problem: Some SoCs like the i.MX8MP have a great deal of variat=
ion
> in which IPs are actually available. After factory testing, fuses are bur=
nt
> to describe which IPs are available and as the upstream DT only describes
> the full featured SoCs, either board DT or bootloader is expected to turn
> off the device that are unavailable.
>=20
> What I came up with as a binding for the bootloader to guide its fixup
> looks very similar to what you have:
>=20
> feat: &ocotp { /* This is the efuse (On-Chip OTP) device */
>     feature-controller;
>     feature-cells =3D <1>;
> };
>=20
> &vpu_g1 {
>     features-gates =3D <&feat IMX8MP_VPU>;
> };
>=20
> The OCOTP driver would see that it has a feature-controller property and =
register
> a callback with a feature controller framework that checks whether a devi=
ce
> is available. barebox, that I implemented this binding for, would walk
> the kernel device tree on boot looking for the feature-gates property and=
 then
> disable/delete nodes as indicated without having to write any SoC specifi=
c code
> and especially without hardcoding node names and hierarchies, which is qu=
ite brittle.
>=20
> There was a previous attempt at defining a binding for this, but Rob's NA=
K
> mentioned that a solution should cover both cases:
>=20
>  https://urldefense.com/v3/__https://lore.kernel.org/all/20220324042024.2=
6813-1-peng.fan@oss.nxp.com/__;!!GF_29dbcQIUBPA!2j_vN6Jc1k2XI3EegAC2yzTLgJ1=
Rw1DhDrjGF03a5tDtOGpm_qp9B0zHJeAJzw-fWOeJp5HtnzYmOJZ0XPJxHzHFDBt_$  [lore[.=
]kernel[.]org]
>=20
> Having implemented nearly the same binding as what you describe, I obviou=
sly like your
> patch. Only thing I think that should be changed is the naming. A domain =
doesn't
> really describe this gated-by-fuses scenario I have. Calling it feature-g=
ates
> instead OTOH makes sense for both your and my use case. Same goes for the=
 documentation
> that could be worded more generically. I am open to other suggestions of =
course. :-)
>=20
> Also a general gpio-controller like property would be nice. It would allo=
w drivers
> to easily check whether they are supposed to register a domain/feature co=
ntroller.
> For devices like yours where a dedicated device node represents the domai=
n controller,
> it's redundant, but for a fuse bank, it's useful. #feature-cells could be=
 used for
> that, but I think a dedicated property may be better.
>=20
> Let me know what you think and thanks for working on this!
>=20
> Cheers,
> Ahmad
>=20

Hello Ahmad,

I'm very happy that you are interested in my proposal. It will be great
if we produce common binding to suite both our requirements.
I agree that binding should be renamed, but I don't think feature-gates
name would fit my case.
IIUC both our cases requires different devices across the system to
provide some information to the controller device. This information
could be used to identify the devices later or to make some
controller-specific configuration. In this case I would prefer name
"device-feature" or "bus-domain", suggested by Linus Walleij.
Also I like your idea to add dedicated property. This will make bindings
more clear.
Summarizing all above, I would suggest the following names:

 feat: &ocotp { /* This is the efuse (On-Chip OTP) device */
     device-feature-controller;
     device-feature-cells =3D <1>;
 };

 &vpu_g1 {
     device-features =3D <&feat IMX8MP_VPU>;
 };

What do you think about this?

Best regards,
Oleksii.

>=20
> >=20
> > I think we can cooperate with the bus controller framework developers
> > and produce the common binding, which will fit the requirements of both
> > features
> >=20
> > Also, I think that binding can also be used for STM32 ETZPC bus
> > controller feature, proposed in the following thread: [2].
> >=20
> > Looking forward for your thoughts and ideas.
> >=20
> > [0] https://urldefense.com/v3/__https://developer.arm.com/documentation=
/den0056/latest__;!!GF_29dbcQIUBPA!2j_vN6Jc1k2XI3EegAC2yzTLgJ1Rw1DhDrjGF03a=
5tDtOGpm_qp9B0zHJeAJzw-fWOeJp5HtnzYmOJZ0XPJxH59KKjhc$  [developer[.]arm[.]c=
om]
> > [1] https://urldefense.com/v3/__https://lore.kernel.org/all/20190318100=
605.29120-1-benjamin.gaignard@st.com/__;!!GF_29dbcQIUBPA!2j_vN6Jc1k2XI3EegA=
C2yzTLgJ1Rw1DhDrjGF03a5tDtOGpm_qp9B0zHJeAJzw-fWOeJp5HtnzYmOJZ0XPJxHy1kyyWZ$=
  [lore[.]kernel[.]org]
> > [2] https://urldefense.com/v3/__https://lore.kernel.org/all/20200701132=
523.32533-1-benjamin.gaignard@st.com/__;!!GF_29dbcQIUBPA!2j_vN6Jc1k2XI3EegA=
C2yzTLgJ1Rw1DhDrjGF03a5tDtOGpm_qp9B0zHJeAJzw-fWOeJp5HtnzYmOJZ0XPJxHzVdVT4B$=
  [lore[.]kernel[.]org]
> >=20
> > ---
> > Changes v1 -> V2:
> >    - update parameter name, made it xen-specific
> >    - add xen vendor bindings
> >=20
> > Changes V2 -> V3:
> >    - update parameter name, make it generic
> >    - update parameter format, add link to controller
> >    - do not include xen vendor bindings as already upstreamed
> >=20
> > Changes V3 -> V4:
> >    - introduce domain controller provider/consumer device tree bindings
> >    - making scmi node to act as domain controller provider when the
> >      device permissions should be configured
> > ---
> >=20
> > Oleksii Moisieiev (2):
> >   dt-bindings: Document common device controller bindings
> >   dt-bindings: Update scmi node description
> >=20
> >  .../bindings/domains/domain-controller.yaml   | 80 +++++++++++++++++++
> >  .../bindings/firmware/arm,scmi.yaml           | 25 ++++++
> >  2 files changed, 105 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/domains/domain-co=
ntroller.yaml
> >=20
>=20
>=20
> --=20
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       | https://urldefense.com/v3/__=
http://www.pengutronix.de/__;!!GF_29dbcQIUBPA!2j_vN6Jc1k2XI3EegAC2yzTLgJ1Rw=
1DhDrjGF03a5tDtOGpm_qp9B0zHJeAJzw-fWOeJp5HtnzYmOJZ0XPJxH_HqFmwM$  [pengutro=
nix[.]de]  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|=
