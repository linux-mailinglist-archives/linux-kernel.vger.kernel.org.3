Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1983E4E4697
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 20:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbiCVTXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 15:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiCVTXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 15:23:33 -0400
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFB767D0C;
        Tue, 22 Mar 2022 12:22:04 -0700 (PDT)
Received: from pps.filterd (m0174680.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22MJJUsW002877;
        Tue, 22 Mar 2022 19:21:51 GMT
Received: from eur03-am5-obe.outbound.protection.outlook.com (mail-am5eur03lp2053.outbound.protection.outlook.com [104.47.8.53])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3eymggr06q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Mar 2022 19:21:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cc9OzxyoPitF/tTo4M3thMNNPL5o9hyFDPLRq1kfUrdWrqrQ16xslZFhHQGZ+Ml7e2QqBrk5MIMUuXh1eEfpgN0KLOV0Zfyuk7z4ljV/TB/DMUiZKhz4HWa7QRtsyp+HcH93sngQDNbdrVprrZByar5qU8n27u6pZ2brhsRrg1EmgHYpSqbv3BTbrNmlnfPNjYr/v3bmwL3WwW7ijbGlmDO5jE5xbGR4yW7FMW9Xh/I4kAWEbvfWm0pLBikZVxSY/SwMI3ZtzAanzkd0UUe6VjrTGAwtu3hkhnnQtaox5l6mS61xz7l/DHxSbXXg6L67P+tUr0mmXms7vaOZh2zikA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KibwSGOXhzMs6bjp4rAT8YS8cAyQ9kNkGO0EecOvPMw=;
 b=S43ttzm8tqFyeuF8cj1B9rTwtApM95XhrKJqh3OmGypRE34tU3nZzAxmg16Nt3hwkGxq7VFs09asGTF+KzdocL7wDzvjJ14P/nptnYWRhZQ+VySJGBuELs0ya+zR9kfgGtPumXh5e0CC7VbcEx923MJ1V5VOCamgDCAThrznEWxg9GmPj3KA4yaMh/aOPRdK5BKLR0ZxsubfGpq6UWIF2wRU+g46DS+YgCMO6qqdYTpcyvKsnLHVddxdBgp19iW+wbf72CYoMFIQBm17AOT5k2eYgC5n81QkhlcV0W6utaJEW8vQeFlodJD2riCipBbFvsW9lDeNFvw0OyqPiukNxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KibwSGOXhzMs6bjp4rAT8YS8cAyQ9kNkGO0EecOvPMw=;
 b=NcrnLSSfmyI0hIZ/B1zxNXHtZ07416kP9EqNHKRtGxMOTvCeDuftzD3m1igdQ1nMbta8WrDxOtFU2XicAFJ7cM1c7zOd45PKG1dxkJ9iCaEo/OfiK4nmR/npTLZTJS8BDe+/O6zBRiyyZCeo/GMqnN+CckumasHIjbxv5PKP0UWDaEJlhLdDMtpjn0Aionlgfi9Jm/p/bDdxclpPrktE0s/peMaaQstwiWL9CilTjL12y790OMQoVtDtFyJn03KUnTuckrPxoE16BSVMJwCo1hMBGoyHykJS8z1t38YNAWZWt2cIk5nPAwPGRxCpEkxRwLz/pzEvm7dVOLlbeWH1RQ==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by DB6PR0301MB2262.eurprd03.prod.outlook.com (2603:10a6:4:47::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.23; Tue, 22 Mar
 2022 19:21:48 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::b12a:5b52:7c19:fbc]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::b12a:5b52:7c19:fbc%5]) with mapi id 15.20.5102.016; Tue, 22 Mar 2022
 19:21:47 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Stefano Stabellini <sstabellini@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: xen: Add xen,scmi-devid property
 description for SCMI
Thread-Topic: [PATCH v2 2/2] dt-bindings: xen: Add xen,scmi-devid property
 description for SCMI
Thread-Index: AQHYMfvS+PrMFPR+OUmb9ZzOrE/y56y17gCAgAxYwICAACUbgIADdt4AgAV0tYCAAIi+AA==
Date:   Tue, 22 Mar 2022 19:21:47 +0000
Message-ID: <20220322192146.GA145617@EPUAKYIW015D>
References: <cover.1646639462.git.oleksii_moisieiev@epam.com>
 <5859bb58c8caf87985deb84d7f6bfc8182bd6a59.1646639462.git.oleksii_moisieiev@epam.com>
 <Yie47a4lqXjVzgxI@robh.at.kernel.org> <20220316164619.GA3489934@EPUAKYIW015D>
 <YjIzeyNoWhVAY5HK@bogus>
 <alpine.DEB.2.22.394.2203181644560.2910984@ubuntu-linux-20-04-desktop>
 <YjmvFZOqAcnoBcR+@bogus>
In-Reply-To: <YjmvFZOqAcnoBcR+@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 894c9f91-91d4-4612-89c1-08da0c3935ad
x-ms-traffictypediagnostic: DB6PR0301MB2262:EE_
x-microsoft-antispam-prvs: <DB6PR0301MB2262142CC7EBBFB92833F60DE3179@DB6PR0301MB2262.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tBNaU2s2n8webTTBZnOR9eI/pu8GobDAoH4iIzD5fKOyLQt+D0dOlZzFl5ODPj7B2NUhxelxLXG8ZJpkQypFK0Taodo/yJ01WAGjH22JKRMrIYozBaN3eidO+T0ZQ5jKpuzzIQ29zpR1Sis3OfYxdplszieY1JFL8Kau+BYH5IpBQIBxMxkzevbUzl2txtg98MpeHt2BRNmi8qAfk7JWYxfRCZyb+OAfgCQ2055Qt2wR70R/OxgfDIYjdST7PbZYKOGwNCOltszqXoU5jxoNufGKU3UmINDdbhsvJh3X8DPKOU5SwP8aeFkk1NyzkN1wPCEUE0QDDWyx8maM2vvFXvFTIpwbsVtFNG8Eo2h8U33n+iU5uIjINjdyp52Fb4g0zNtL+IJ09biuAJkADXZF5oINCYFywZx3PhRUyU47QYrYdw+JSJIrcDcBqCjwhaeLdijjf5ZCkPriIVb7MHdw9SZ0ETDyHUey0pXK8qiZPdlVsR0yxDBPXtRkAU/reXa3iRvKwaWZ6+jqkNJSIsU1HBr+pBYo07mGYOGmaxe89nI2uECSe0vGCRukKnsY9L+pXqKvTFKf71uxHlsL7rNUnkco5iJeQLk9n9L6658KyM0qKi0uNhE+nzOI1/fSA3ZUcBjtAotea2ZWnlYHh2aD+Km9f2tJkIZ68YumnHAUscShz1gjdtDR4KkOjOZOj2KeSK1FAWgbVirLuV2R+2Qfug==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(38100700002)(186003)(86362001)(1076003)(26005)(8936002)(316002)(8676002)(83380400001)(2906002)(122000001)(54906003)(6486002)(38070700005)(6916009)(71200400001)(508600001)(9686003)(66946007)(6512007)(6506007)(33716001)(4326008)(66476007)(66556008)(33656002)(64756008)(66446008)(91956017)(76116006)(55236004)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9t+1oh+9F9lyeut/cGB08dC187qrk7Gc9MMMVjcV4Xj6ybR0r+3YwljXHYqT?=
 =?us-ascii?Q?3w01ol745gvrTPzQ1Lc0O0QjVZjOulRhMKide7tI4No7LQAmcfnn+HRWzKtm?=
 =?us-ascii?Q?HGx8KpQmDhWN2Q2fINGi739o/KExvKbpctL/hB5WrD7dkOjRu0DAs3Yjlu9Y?=
 =?us-ascii?Q?DMmZhb+slUSVXrIxlumERz8rk06zox+JVAcYhZnZu4DpavOWdRois+WiWrmu?=
 =?us-ascii?Q?FR785Np+pZkDDOdVCU0AIGgCUlw7b4j7OxN3n7pJGlRbs/9ORfSQEeS40fvP?=
 =?us-ascii?Q?wNQR6GccVCaj9kK2kVXOLMmEu5Vx51elwPKNepKguYeRGdbX4QVos0wpqwMY?=
 =?us-ascii?Q?Y6ky2Y4UwbPDP2VT+o13+QHAU/nd8PtNkHfBbU983+Hre8EUufJ5zRiv7/Cl?=
 =?us-ascii?Q?TnUl9li0PtzXWuJLjWnuifOKOJj0As3mmOX8ntYIEbklvgZJDQPlwNK/AieH?=
 =?us-ascii?Q?XUChKxNmUe81UtWOEb4bgnP/ALG44k9AgqTkObd/mDvnJAWKtW54JCZB2BYR?=
 =?us-ascii?Q?Q77CZUAc8UxdP4aF8KtkLaOnPw/5EcaA+Xk+rJDz6/+SyD2I4u4/Vf5wQC2z?=
 =?us-ascii?Q?3vt/w2RsczTV54EVd+EFM89cOXq3WkPGYNcqAV0X1gxxCNFOBckquiLq1WkI?=
 =?us-ascii?Q?abztLwgEV0xOPoYzR/teot65m/QqjdCkVREQKVgpCuNl21gdFVkU6tXYNwXB?=
 =?us-ascii?Q?f6ojApbjRyevq5A50s0IHm10StR7G9rKgh7VHEQGvlrgvyEP+YZ/2YJpr86G?=
 =?us-ascii?Q?XH8A+xP28vd8ZKePaNiS2ThXiQvJjOhxqTiSeWXtVax9q/rSENgYTup2KwY8?=
 =?us-ascii?Q?oka224NRHtE3lz6g8T8/yNCgpeLjLTv6Iu7V1MUE8b3O+1CMHjFvl/fgvqDi?=
 =?us-ascii?Q?K5fsTw8BCPhCgE22UabfKdwHUAQP/n/XEMbrqLNPLUB1rLaetilFYZHuK7Kx?=
 =?us-ascii?Q?TwYaWhHcrge6KklL+55yGhhuNMvxHFeH3AwuCfMC8brZoJvNY7pnRakuKZ+v?=
 =?us-ascii?Q?49kttEo6KZsYEVYwCaYdKsy0OohDValu97juAGlB9iEYdoC7vWjasbbqElSc?=
 =?us-ascii?Q?G4K+p9FaJP/YLzQVDq9RkQMTLtUPegyyWX+ABkstSg38/vnJbXpAOv0J95W9?=
 =?us-ascii?Q?hDVjRcTakPZ929oR52WTGeNs0oV1+3U50sbV8U9nmUdilCmXrnailjABOgaA?=
 =?us-ascii?Q?vXbugPePNcm5UZEa8J0wS+yBoWjZjTwfW/58p7FWO3pDmkzRwqRimhMXqCo3?=
 =?us-ascii?Q?vfhbvvmiUlh9plvjIE2fMylnwJCC2i1LDT17dnclwVw/fbPiXY+RFimy2xot?=
 =?us-ascii?Q?aLdiegsbdPz5ObpKSJZbter6dqG7UAlEXGdMtDNnv22dwzl5q65tmYMTh/V7?=
 =?us-ascii?Q?ULCHN6qZiGeaUGDuqvkzUsn55Zf0NUGo/nMyP1l0Me456ysT0wuxOWcIiKwC?=
 =?us-ascii?Q?fjPowsj5pr244RYGzy1g9atolTnzHxxdwcW+RQ0Rk1w/piTVqFfuoA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <375872617842E349A4D730D8C32CE475@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894c9f91-91d4-4612-89c1-08da0c3935ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Mar 2022 19:21:47.8331
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WjXq4ci6GGpRfkPpGnB97QbHfSWRLNId89cAJuB0Eemy1koeyG3ld2xfDwwWWiKA4lfu30OjiC0x24+8Lk/MeT9a3way8dlvKzdDhXcJtBA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0301MB2262
X-Proofpoint-GUID: WO0EPeTGXoBDI_LK-4R8q5sKA8a-s-kw
X-Proofpoint-ORIG-GUID: WO0EPeTGXoBDI_LK-4R8q5sKA8a-s-kw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-22_07,2022-03-22_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 spamscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 adultscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=999
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203220100
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On Tue, Mar 22, 2022 at 11:12:21AM +0000, Sudeep Holla wrote:
> On Fri, Mar 18, 2022 at 04:53:20PM -0700, Stefano Stabellini wrote:
> > On Wed, 16 Mar 2022, Sudeep Holla wrote:
> > > On Wed, Mar 16, 2022 at 04:46:20PM +0000, Oleksii Moisieiev wrote:
> > > >=20
> > > > > + The reason I want to keep it xen specific at the moment as we h=
ad some
> > > > > plan to extended the device-id usage in the spec which hasn't pro=
gressed
> > > > > a bit(I must admit that before you ask), and this addition should=
 not be
> > > > > obstruct that future development. If we align with what we define=
 xen
> > > > > specific as part of $subject work, we can always define generic b=
inding
> > > > > in the future and slowly make the other obsolete over the time.
> > > >=20
> > > > IIUC you have some plans to provide device_id support to the device=
-tree
> > > > bindings from your side. Maybe we can discuss some of your plans he=
re
> > > > and we can come up with the generic device-id binding?
> > > > So I will have something to base on in Xen.
> > > >=20
> > >=20
> > > Sorry if I wasn't clear in earlier emails. What I mentioned was that =
I would
> > > like to reserve the generic namespace(i.e. just device-id) for generi=
c SCMI
> > > usage. Since we haven't defined it clearly in the spec, I don't want =
to
> > > introduce the generic definition and binding now.
> > >=20
> > > As mentioned earlier, though Xen definition and generic once may be e=
xactly
> > > same, but we won't know until then. So keep the xen usage and namespa=
ce
> > > separate for now to avoid any future conflicts.
> >=20
> >=20
> > Hi Sudeep,
> >=20
> > I thought the specification already covered this device id, it simply
> > delegated the description of it to Device Tree or ACPI, which is common
> > behavior in ARM specs. What is missing in the SCMI spec from your point
> > of view?
> >
>=20
> While you can say so, but for me it isn't to an extent that we can suppor=
t
> software around it. I did share my feedback with spec author but as you
> know it was needed for virtualisation use-case like Xen and was rushed
> into the spec. All it states is "Device identifier" identifies the device
> and the enumeration is not part of the spec. It defers to DT/ACPI.
>=20
> Since I didn't have to use that in OSPM, I hadn't given much thought/revi=
ew
> on that.
>=20
> >
> > Or would you like this scmi-devid Device Tree property (or similar) to
> > be described in the SCMI specification itself?
> >
>=20
> Spec doesn't cover that in general but do carry some recommendations
> sometimes.
>=20
> > Typically Device Tree and ACPI descriptions are delegated to Device Tre=
e
> > and ACPI respectively. Also specification updates are typically slow
> > (for good reason.) We might be waiting for a long time. It is usually
> > not a matter of days.
>=20
> I agree.
>=20
> As I said, there were thoughts about adding device protocol to make
> all the other protocols centered around the device. The idea is as below:
>=20
> Today a device A is associated with clock domain X, reset domain Y,
> voltage domain Z, perf domain P, power domain Q, ...and so on.
> Especially this would get complex with lots of devices and for virtual
> machines.
>=20
> Instead let all these different operations use the device identifier A
> in the above case to drive clock, reset, perf, power, voltage,...etc.

So, IIUC - the idea is to provide new device based protocol
which will allow agents to control different domains by using ony device
id? Does it mean that scmi drivers for agents should be also changed and th=
ere will
be no back compatibility with previous versions of SCMI protocol?
If yes - we probably can add scmi-devid property for current SCMI
version, such as scmi-v3,device-id (because current DEN0056D document
has version 3.1) and say that this property should be
used for SCMI versions, which doesn't support device protocol.
What do you think about this idea?

>=20
> While this was just initial idea, I am bit wary of the fact that it would
> alter the definition of device identifier. Also there is orthogonal topic
> of device assignment in various contexts and associated identifiers.
> IIRC Rob briefly raised concerns on one of such topics.
>=20
> With all these in consideration, I preferred to not use the "device-id"
> in the standard namespace for anything else until we get clarity on these=
.
>=20

Best regards,
Oleksii.=
