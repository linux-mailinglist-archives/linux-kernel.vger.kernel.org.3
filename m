Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CE495983A8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244612AbiHRNCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244924AbiHRNCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:02:23 -0400
X-Greylist: delayed 3812 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 18 Aug 2022 06:02:12 PDT
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAADDB4403;
        Thu, 18 Aug 2022 06:02:12 -0700 (PDT)
Received: from pps.filterd (m0174676.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27I9Ij17007076;
        Thu, 18 Aug 2022 09:31:04 GMT
Received: from eur03-ve1-obe.outbound.protection.outlook.com (mail-ve1eur03lp2051.outbound.protection.outlook.com [104.47.9.51])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3j1jj0g3et-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 18 Aug 2022 09:31:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GxT+Q/6ddUsRmGSHm5eSNjCKvyWC6wEWx0ls/aVT8wFxUbIwxLJpWnJphAfTWTi3H2mCQIAyAHQ/mPhNIHKBrObzjrSJfOeHO8zzYewyN21pg/oZO5WNWnnb00+6HkaPoFJmrhPKEsAIzJoNsuhv80NiSsnvmAkTDrrHAs5j4YRJm9CVXRtUdWgTlljqWhtMJutmRDHanQxX6I0WKgNq9fZUF/cLkVQF8Q9/nlJrmv9e/sGePsvhV9ZzlQjqjxTKjn+wFDaEzV9SinR4190e4ZRsYDgnSbD/arbnfIbzcST80AjyMqoQxHATfTY8P3RtTp0P+B0JqOb+2zluGTsj9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJ93RUQgFF4yXw0st0G3OCrf6NV+AtvPOGTNLTE2eO0=;
 b=G8cdrIzRmxwbdhhgJr7Bl4Osku0VnHDZkOUV3zmepg3D1hsjbNSh6uVhD16ZYdZg/QEwrFix2KFgcRKbXee5AM+MO0bnZ1Z9QvuDeuxtp/4Be4MnO8G5h69rinesorZTV6PVmcHUnWTOgBJdkB3ZmWPthKeJ7rV5HDyNkEHQiFK3mpjH59/VUHWVLICT62f+p415OAKjJCDdTTaVaIpR1uKddnHOVW6B3CNwMpAWuWTSo3XgcxYafbdcIv5kMAeHz7i69ELeeHbJK6UtEq+qn2MdhlTq337aahSW6BQxgJSqFcHVmQlQc8diJ8swmhe3Omte5LBSUCw2/PQ2HTppfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJ93RUQgFF4yXw0st0G3OCrf6NV+AtvPOGTNLTE2eO0=;
 b=OqaxwqkTDUdvKtlkVF7fLCxb2kieXbE5+rikikdaruMtlHS194DlrHQ/f9HjdPKpV4t4b+E1jf+YhAhJQ0XBgEXbm1DgaYRSDfbjY8PfBlkfSldb5OB/FBzHxrNQFWjNNbbPQOhct3SxnOq71Xso7TRLm2jVvtV5t2Z/xoOSIUzZwhkjRweWTkKxwfUNnXjmKWgUH9Um20zVfMdY7d40SW71OcqCPBB3W3RralXVaJpxrXl6L6lNSWRBkdgBoffEPAj3DnK5O5JR8ehc/M7GOfev5r8JW6ZUF5MPa8NM2s5s5XD5OlQPI/hw+77BCAOp/vBQRXp92Fai1rbaaTmEcw==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by AS4PR03MB8747.eurprd03.prod.outlook.com (2603:10a6:20b:576::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Thu, 18 Aug
 2022 09:31:00 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::d1ad:dbe5:58e:f0d0]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::d1ad:dbe5:58e:f0d0%4]) with mapi id 15.20.5546.016; Thu, 18 Aug 2022
 09:31:00 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     Loic PALLARDY <loic.pallardy@st.com>
CC:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        Alexandre TORGUE <alexandre.torgue@st.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "tomase@xilinx.com" <tomase@xilinx.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "fabio.estevam@nxp.com" <fabio.estevam@nxp.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Loic PALLARDY - foss <loic.pallardy@foss.st.com>
Subject: Re: [PATCH v4 0/2] dt-bindings: Intorduce domain-controller
Thread-Topic: [PATCH v4 0/2] dt-bindings: Intorduce domain-controller
Thread-Index: AQHYkevVQuji0mJdiUaO5T+/y7MyeK2wZr+AgAF+bwCAAsFtgA==
Date:   Thu, 18 Aug 2022 09:31:00 +0000
Message-ID: <Yv4G068IpWx/v1Lg@EPUAKYIW015D>
References: <cover.1657187536.git.oleksii_moisieiev@epam.com>
 <3ca7cd75-4b62-2380-adb0-646bbeb647a2@pengutronix.de>
 <PAXPR10MB48428C9241301E4ACFA9DF8E8A6A9@PAXPR10MB4842.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To: <PAXPR10MB48428C9241301E4ACFA9DF8E8A6A9@PAXPR10MB4842.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: afb027dc-1072-4924-c14e-08da80fc5ce7
x-ms-traffictypediagnostic: AS4PR03MB8747:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qtKp/WWmnp0PUgP9g/iLBKhsE1rKFACuZxot2CtFxYKJAZDcMZwL9B9IAXlWV51CaqyeXn1IFJzqH1RFlIH6ZxJ9mGACiNmZ3OIEFo4XHpOLAyXDl70FTMiBl/x57atvuPgZNVLkBcTSmfSx2IUa3J6UXqO3JnXtw79bLMD3Np12BEmuUTZQLEewUNfrLHdqv6OzyGLOu5+TED6XDzvtWZfYBCq8odcQzI0IGLYnSbhsLS06moPQ9+UA8S6i4FmvimTytb0WU/zUeWFh+cKksbsfpWKpfLDtmd7WG+C9EDTUxd5MwfFY5pV3RsF7/T1rg1sF5BoJNjdWCzYGdkp49o5CaSQe/EiWeCYU/jO7gTABv6uEqCRiOqeFxLQhat/KHSbPG/JBRJWLvwiu/J4F7gQm0c8CKZq3NBZDfRwp4tBnLSeZEsYZhrTzrzuFDUi3lQ08mWrmUghdeSn8BYeKeXJ84MzAt+8MS71XLgsqSKVYBY/8gVXf+mAX2r3j7qyihxe55rzpL9jG0J0J/L/4LXUabLaKgSFayeFVIxnnbcIYoP3WV8X0cKmqy7JQhM0UFyGvK0qG2C0UgeN8EnLlvUxgGDDnDmFMqM4QexEmeOpyhl5n+LAiBwzsKSRq6TE49jIfMJfi0CXBDouaTK/H6uX9IKVHcduCDYcQapiKSsgfMH7+qSkBKnOiXFA17ClZP+D250OaK8tUqcxoKuRcQdGl9DyiOPUzuMS1G5fNdRygthpWbUZJxYbGXabOOgH5RrM5U9e3WILPcVO/xlMtL6/6J2JuBzXRpCHhAgNvTzk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(4636009)(376002)(39860400002)(366004)(396003)(136003)(346002)(64756008)(66946007)(66446008)(76116006)(122000001)(38100700002)(91956017)(66476007)(66556008)(4326008)(8676002)(26005)(38070700005)(53546011)(41300700001)(186003)(71200400001)(478600001)(5660300002)(6512007)(6916009)(6506007)(966005)(316002)(83380400001)(33716001)(7416002)(8936002)(30864003)(9686003)(2906002)(6486002)(86362001)(54906003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MVtXXwlVWuCprbRRI1BhUrW+ZfRlJUWJruC2sDyPvsCFfXOfiXIyV6ExOjWr?=
 =?us-ascii?Q?umbr7iqhS9iHXuRMMKjf+VQRmEjHxf91IbsyuEIeVQrmFk918dNuwbXgU3UM?=
 =?us-ascii?Q?a4JHdUsXYFDDe2x0PmALgC/gAm3t3z/3NNFKiLIqxEx+j2o9ddNXGJqp8SwF?=
 =?us-ascii?Q?h0SbhtSN1Ncilvosn7h8rfnQz6DqmaLicjArfyAQUIa3z0gFETRKYnC7Pq5A?=
 =?us-ascii?Q?MRwmNr13pqvlllXUDhSc8voxJK0LHtEgw1yZH1ZUcwQAi6jSmxbjS7Tz+i8T?=
 =?us-ascii?Q?u+GJTKqEnVdNQRR8vzN19p4DMiEIYwNhTk0Bu9UnaDVLzbxul85tTdAA2EWc?=
 =?us-ascii?Q?TfcXNbm2dFzUJnCAewNG1xPxiAXffqRUb7HPp+UMNrCNvUMgtcYYoiEV6ORf?=
 =?us-ascii?Q?eM03mSXpXDX9t8Jo1z/QrG+rhDfcXVF1Fb8VG/r2QkTb5DS+CbUPkCei1MDX?=
 =?us-ascii?Q?/YwEEgiXuKS7MPVo49Ky7PviDWX3vJXMoy0eoflatmQ5iTDIKMCaCWf/gZK/?=
 =?us-ascii?Q?Tqg7jqYvA1shQEYMiQgykM4qxGkigkUAizOz+5xBDYwj424HsYg+7QoxuDaA?=
 =?us-ascii?Q?cwWqvXeTAcVE1hnkZE+BVP69l/kk3aYLn40+Td9lzrYMnQxG3cTEHa/Uix4/?=
 =?us-ascii?Q?PcSl240eDXpQVszV299cr0qll9dyDcyPU6Gvl+jvhOydtNkkW7YEl6sQxcTp?=
 =?us-ascii?Q?CH2j4PPQ1eIIlXsCaS3Zj0caxqjjETHcE85ANpl7sQu4jNq2NFwfxhrewV+M?=
 =?us-ascii?Q?7STC+hTWN+UmIN9G6t2EWyzkd3SCJ3/NpWgKH8/JZc1906oLVROp5X+RxSVc?=
 =?us-ascii?Q?J/ucOTmczKB8yh3kU726FSbH6iR4DPZAPVDnrJj6Kc0CegYuMmQjeMqpJTC3?=
 =?us-ascii?Q?D+wcp9BvCBlxgOOhfat9UihfSZnjJjDYShLYA5MeodbIiVJwD8j0rNlTz6br?=
 =?us-ascii?Q?J82nVdQNVBy6uMXuzGh+a4wZw8HIZfZnI8T/1xkwZd81ekT9tnVax1SKHZ1D?=
 =?us-ascii?Q?cqjfaMZdRfyQDL/iihc5QPGEAMrp+UQWjCCRSJupa/LhRTGtwRTy8HntCAgg?=
 =?us-ascii?Q?pYbCVsmUrlmiA2/groAhJ0kepEKWENB3QR7h/40LGO43GGqEE41f5sxO2LvJ?=
 =?us-ascii?Q?H0HejdRLLyHVlaPIhCzVOHbTw61wM4NqJSXm04Litu8JTM22XcH1Mo0CVCti?=
 =?us-ascii?Q?WvgqH1Xp2p40ExFTH/tH7UsBy1pWTUu27U8PHz4+7RGzwEN0CqHWinGl3XdC?=
 =?us-ascii?Q?w8STuaJ9kRKmNLmagLr6P0w+LbFIggbDCOXF1eAnTAscDtYvpIfzl6M/emFG?=
 =?us-ascii?Q?oeL7iKLnt8z6TwDokw+P1RGjGrl7dRTtlCHVWfaJiZ9KY0gpCMJI18GAyYY4?=
 =?us-ascii?Q?Xr5vB6M/RFUi/kLHHg6JY7JVZg/k5PXlHjHfdEOsDBxjxdZyr0e35J0S6Dzw?=
 =?us-ascii?Q?oEJSuGvqqjZvh+QN/I+dPWeWAvyhYLOJ356zLmOpABgg1K1zpoz3axNCAJEB?=
 =?us-ascii?Q?laJ54HWuisabap1Jw6L5o1IQ8VIPRuHDOgFs4o8jsMFtCotGHlTu0HFGAZcN?=
 =?us-ascii?Q?vfOmxhvumHkaJS47zL43Cld1dh+BacZmJZSgfwv/IrsM/ZO4vBSQfCvonjJj?=
 =?us-ascii?Q?4A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C43DE5FE7930904FB98121B0EB967DCF@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afb027dc-1072-4924-c14e-08da80fc5ce7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2022 09:31:00.4840
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rdDN9gk8QmSGWNe0PHoJtRvMtuxPOOhle7dUwhIxV8nAP8gJ7H3+FTgZ6KDb4BgwL8rzhEwSwYgxbzdIOgtigUOWU946wedi3ydkbunBB/g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR03MB8747
X-Proofpoint-ORIG-GUID: G5vBy4bLSHHgrz0CnUvPFBU3I9NOBcw_
X-Proofpoint-GUID: G5vBy4bLSHHgrz0CnUvPFBU3I9NOBcw_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-18_02,2022-08-16_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 suspectscore=0 clxscore=1011 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208180031
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 17, 2022 at 07:09:57AM +0000, Loic PALLARDY wrote:
> Hello,
>=20
>=20
> ST Restricted
>=20
> > -----Original Message-----
> > From: Ahmad Fatoum <a.fatoum@pengutronix.de>
> > Sent: Monday, August 15, 2022 6:37 PM
> > To: Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>; robh+dt@kernel.org
> > Cc: mcoquelin.stm32@gmail.com; Alexandre TORGUE
> > <alexandre.torgue@st.com>; linus.walleij@linaro.org;
> > gregkh@linuxfoundation.org; devicetree@vger.kernel.org; tomase@xilinx.c=
om;
> > Benjamin Gaignard <benjamin.gaignard@collabora.com>; broonie@kernel.org=
;
> > arnd@arndb.de; shawnguo@kernel.org; fabio.estevam@nxp.com; Loic
> > PALLARDY <loic.pallardy@st.com>; mark.rutland@arm.com; Sudeep Holla
> > <sudeep.holla@arm.com>; Cristian Marussi <cristian.marussi@arm.com>;
> > Stefano Stabellini <sstabellini@kernel.org>; linux-kernel@vger.kernel.o=
rg;
> > Pengutronix Kernel Team <kernel@pengutronix.de>; Peng Fan (OSS)
> > <peng.fan@oss.nxp.com>
> > Subject: Re: [PATCH v4 0/2] dt-bindings: Intorduce domain-controller
> >=20
> > Hello Oleksii,
> >=20
> > On 07.07.22 12:25, Oleksii Moisieiev wrote:
> > > Introducing the domain controller provider/consumenr bindngs which al=
low
> > to
> > > divided system on chip into multiple domains that can be used to sele=
ct
> > > by who hardware blocks could be accessed.
> > > A domain could be a cluster of CPUs, a group of hardware blocks or th=
e
> > > set of devices, passed-through to the Guest in the virtualized system=
s.
> > >
> > > Device controllers are typically used to set the permissions of the h=
ardware
> > > block. The contents of the domain configuration properties are define=
d by the
> > > binding for the individual domain controller device.
> > >
> > > The device controller conception in the virtualized systems is to set
> > > the device configuration for SCMI (System Control and Management
> > > Interface) which controls clocks/power-domains/resets etc from the
> > > Firmware. This configuratio sets the device_id to set the device perm=
issions
> > > for the Fimware using BASE_SET_DEVICE_PERMISSIONS message (see
> > 4.2.2.10 of [0]).
> > > There is no BASE_GET_DEVICE_PERMISSIONS call in SCMI and the way to
> > > determine device_id is not covered by the specification.
> > > Device permissions management described in DEN 0056, Section 4.2.2.10=
 [0].
> > > Given parameter should set the device_id, needed to set device
> > > permissions in the Firmware.
> > > This property is used by trusted Agent (which is hypervisor in our ca=
se)
> > > to set permissions for the devices, passed-through to the non-trusted
> > > Agents. Trusted Agent will use device-perms to set the Device
> > > permissions for the Firmware (See Section 4.2.2.10 [0] for details).
> > > Agents concept is described in Section 4.2.1 [0].
> > >
> > > Domains in Device-tree node example:
> > > usb@e6590000
> > > {
> > >     domain-0 =3D <&scmi 19>; //Set domain id 19 to usb node
> > >     clocks =3D <&scmi_clock 3>, <&scmi_clock 2>;
> > >     resets =3D <&scmi_reset 10>, <&scmi_reset 9>;
> > >     power-domains =3D <&scmi_power 0>;
> > > };
> > >
> > > &scmi {
> > >     #domain-cells =3D <1>;
> > > }
> > >
> > > All mentioned bindings are going to be processed by XEN SCMI mediator
> > > feature, which is responsible to redirect SCMI calls from guests to t=
he
> > > firmware, and not going be passed to the guests.
> > >
> > > Domain-controller provider/consumenr concept was taken from the bus
> > > controller framework patch series, provided in the following thread:
> > > [1].
> >=20
> > I also was inspired by Benjamin's series to draft up a binding, but for=
 a slightly
> > different problem: Some SoCs like the i.MX8MP have a great deal of vari=
ation
> > in which IPs are actually available. After factory testing, fuses are b=
urnt
> > to describe which IPs are available and as the upstream DT only describ=
es
> > the full featured SoCs, either board DT or bootloader is expected to tu=
rn
> > off the device that are unavailable.
> >=20
> > What I came up with as a binding for the bootloader to guide its fixup
> > looks very similar to what you have:
> >=20
> > feat: &ocotp { /* This is the efuse (On-Chip OTP) device */
> >     feature-controller;
> >     feature-cells =3D <1>;
> > };
> >=20
> > &vpu_g1 {
> >     features-gates =3D <&feat IMX8MP_VPU>;
> > };
> >=20
> > The OCOTP driver would see that it has a feature-controller property an=
d
> > register
> > a callback with a feature controller framework that checks whether a de=
vice
> > is available. barebox, that I implemented this binding for, would walk
> > the kernel device tree on boot looking for the feature-gates property a=
nd then
> > disable/delete nodes as indicated without having to write any SoC speci=
fic code
> > and especially without hardcoding node names and hierarchies, which is =
quite
> > brittle.
> >=20
> > There was a previous attempt at defining a binding for this, but Rob's =
NAK
> > mentioned that a solution should cover both cases:
> >=20
> >  https://urldefense.com/v3/__https://lore.kernel.org/all/20220324042024=
.26813-1-peng.fan@oss.nxp.com/__;!!GF_29dbcQIUBPA!xfDOoAXBRWNVG6S9o74w3BLqN=
OTamI_n0-lTb7WX_ZJo7ljnENiZE5FCXmDYTdGwGRyqj4c8dqLqsDurEZ7OSmC7HQ$  [lore[.=
]kernel[.]org]
> >=20
> > Having implemented nearly the same binding as what you describe, I obvi=
ously
> > like your
> > patch. Only thing I think that should be changed is the naming. A domai=
n doesn't
> > really describe this gated-by-fuses scenario I have. Calling it feature=
-gates
> > instead OTOH makes sense for both your and my use case. Same goes for t=
he
> > documentation
> > that could be worded more generically. I am open to other suggestions o=
f
> > course. :-)
>=20
> Issue looks the same as the initial one, how to guarantee Linux kernel wo=
n't try to access to
> resources protected by firewall or OTP.
>=20
> Initial proposal from Benjamin was NAK for different reasons and DT bindi=
ngs were also
> discussed during system DT calls without any agreement at the end.
> Today we have decided to implement a platform bus to check access like pr=
oposed by Greg [1].
> Indeed, a new framework was rejected at the time being.
> The main difference compared to [2] is that bus identifies peripheral tha=
nks to its base address "reg" and=20
> then verifies associated access properties before probing or not device.
> It was a proposal from Rob we discussed during a system DT call to avoid =
an additional binding.
>=20

Hi Loic,

I also thought about the device identification, based on it's base
address "reg", but the problem is that on different platforms regs
should be different. My suggestion is to make common binding, which
allows to identify the devices or set the device parameters and then use
this information for driver specific purposes. Those values should be
common to all platforms and there is no need to write translation tables
regs -> device_id for each platform. Also values can be potentially
used to set some device parameters, not just as device identifiers.

Best regards,
Oleskii.

> We are late to send an update because we are also working on OP-TEE and U=
-Boot to verify
> the approach and be sure we can cover our specific SoC cases with this so=
lution.
>=20
> Regards,
> Loic
>=20
> [1] https://urldefense.com/v3/__https://patchwork.ozlabs.org/project/devi=
cetree-bindings/cover/20200128153806.7780-1-benjamin.gaignard@st.com/__;!!G=
F_29dbcQIUBPA!xfDOoAXBRWNVG6S9o74w3BLqNOTamI_n0-lTb7WX_ZJo7ljnENiZE5FCXmDYT=
dGwGRyqj4c8dqLqsDurEZ5QBPMO3g$  [patchwork[.]ozlabs[.]org]
> [2] https://urldefense.com/v3/__https://lore.kernel.org/all/2020070113252=
3.32533-1-benjamin.gaignard@st.com/__;!!GF_29dbcQIUBPA!xfDOoAXBRWNVG6S9o74w=
3BLqNOTamI_n0-lTb7WX_ZJo7ljnENiZE5FCXmDYTdGwGRyqj4c8dqLqsDurEZ5e94Xj5w$  [l=
ore[.]kernel[.]org]
>=20
> >=20
> > Also a general gpio-controller like property would be nice. It would al=
low drivers
> > to easily check whether they are supposed to register a domain/feature
> > controller.
> > For devices like yours where a dedicated device node represents the dom=
ain
> > controller,
> > it's redundant, but for a fuse bank, it's useful. #feature-cells could =
be used for
> > that, but I think a dedicated property may be better.
> >=20
> > Let me know what you think and thanks for working on this!
> >=20
> > Cheers,
> > Ahmad
> >=20
> >=20
> > >
> > > I think we can cooperate with the bus controller framework developers
> > > and produce the common binding, which will fit the requirements of bo=
th
> > > features
> > >
> > > Also, I think that binding can also be used for STM32 ETZPC bus
> > > controller feature, proposed in the following thread: [2].
> > >
> > > Looking forward for your thoughts and ideas.
> > >
> > > [0] https://urldefense.com/v3/__https://developer.arm.com/documentati=
on/den0056/latest__;!!GF_29dbcQIUBPA!xfDOoAXBRWNVG6S9o74w3BLqNOTamI_n0-lTb7=
WX_ZJo7ljnENiZE5FCXmDYTdGwGRyqj4c8dqLqsDurEZ4PJTS54g$  [developer[.]arm[.]c=
om]
> > > [1] https://urldefense.com/v3/__https://lore.kernel.org/all/201903181=
00605.29120-1-__;!!GF_29dbcQIUBPA!xfDOoAXBRWNVG6S9o74w3BLqNOTamI_n0-lTb7WX_=
ZJo7ljnENiZE5FCXmDYTdGwGRyqj4c8dqLqsDurEZ60ZFPZKg$  [lore[.]kernel[.]org]
> > benjamin.gaignard@st.com/
> > > [2] https://urldefense.com/v3/__https://lore.kernel.org/all/202007011=
32523.32533-1-__;!!GF_29dbcQIUBPA!xfDOoAXBRWNVG6S9o74w3BLqNOTamI_n0-lTb7WX_=
ZJo7ljnENiZE5FCXmDYTdGwGRyqj4c8dqLqsDurEZ4pcCPvwg$  [lore[.]kernel[.]org]
> > benjamin.gaignard@st.com/
> > >
> > > ---
> > > Changes v1 -> V2:
> > >    - update parameter name, made it xen-specific
> > >    - add xen vendor bindings
> > >
> > > Changes V2 -> V3:
> > >    - update parameter name, make it generic
> > >    - update parameter format, add link to controller
> > >    - do not include xen vendor bindings as already upstreamed
> > >
> > > Changes V3 -> V4:
> > >    - introduce domain controller provider/consumer device tree bindin=
gs
> > >    - making scmi node to act as domain controller provider when the
> > >      device permissions should be configured
> > > ---
> > >
> > > Oleksii Moisieiev (2):
> > >   dt-bindings: Document common device controller bindings
> > >   dt-bindings: Update scmi node description
> > >
> > >  .../bindings/domains/domain-controller.yaml   | 80 +++++++++++++++++=
++
> > >  .../bindings/firmware/arm,scmi.yaml           | 25 ++++++
> > >  2 files changed, 105 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/domains/domain-
> > controller.yaml
> > >
> >=20
> >=20
> > --
> > Pengutronix e.K.                           |                           =
  |
> > Steuerwalder Str. 21                       | https://urldefense.com/v3/=
__http://www.pengutronix.de/__;!!GF_29dbcQIUBPA!xfDOoAXBRWNVG6S9o74w3BLqNOT=
amI_n0-lTb7WX_ZJo7ljnENiZE5FCXmDYTdGwGRyqj4c8dqLqsDurEZ4CWLnh6g$  [pengutro=
nix[.]de]  |
> > 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0  =
  |
> > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |=
