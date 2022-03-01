Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E91084C8FA7
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 17:05:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235969AbiCAQGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 11:06:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235323AbiCAQGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:06:20 -0500
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AC8954A3;
        Tue,  1 Mar 2022 08:05:38 -0800 (PST)
Received: from pps.filterd (m0174682.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 221Fb18J017369;
        Tue, 1 Mar 2022 16:05:32 GMT
Received: from eur04-he1-obe.outbound.protection.outlook.com (mail-he1eur04lp2056.outbound.protection.outlook.com [104.47.13.56])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3ehp9k05v9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 16:05:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGPWaVvzqqq9/NMF6z5/fow9XgSUUwZMjDKOd2uCIuFvQ65hojveVPB6QUsQ1yYlsdZ+2CvC1j+sJgfpW77g5sVvI4UVZZ8ycuk43EjkqZWjOuECrcbFHTKU3La+gnHbgy1fmJe/cfLd1gz2FMybm6Z8Rfph0zj75jVqdhq1QJ3um1Pq0f5zQY0iIMpNapRpT6R+cHaFvnk46tW+O01mK9ijhKqechIId16J9eY3+HAiuT8Ll7kwqc3kaed0CYXqLniifGfIemw0Tho5uRO3/r1BzV6O05s7wp4aC/nQ4iNPXpsuON1U0sI3SZTTVNG5Lhwb7ujw00ETwPE9+HQ7Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z1NnVs6W5yuvO58tohRJg95pI3TU4mxvL1IhBRHuVS8=;
 b=C5Nn6qbFof8ybeEcyOlQVAvvnx3X1pnX/AnCW8kh3j1DE+mmMUKPeLewSr1omVAk4OVCXdh34lBBfYipjvo1f3sWe/G9DKqP12FSZtpE+O3vpdnsaxRKaEZPjf7KVdN3ya1gUKqqOayiytnS3XzBkZw+SdEKkvXiSvsHveoWzvqpTvRkkNgyf9GjWKZdbDo6PuaFOUNVpQzX+79RmqNDmnZvk6Ifca/i6Ff/RIgBC/5FvHBSRrf7TN+MWTCFapTmJb3Dq4ek0lvl8++CRoxQBl1lQMEJetI2c/VqtWoTXP70mxSAG/kfF8PaMjxIDs3KwjyMQves7c4sonRoEeCfaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z1NnVs6W5yuvO58tohRJg95pI3TU4mxvL1IhBRHuVS8=;
 b=G3wcuwOM14V+7ST0VFYHa0xqkJuUEd8RUDWhqncyPhrJrlBvT0MauuHS2hWjpojyzYr0d16Bp1jBzZTRMNJm2v5RGooolxnfg501MFx9SJwJvPXsiw/mP/8g0/7JRccX13/k4Rh0evLjKuxZjhiEqTZD+eLM0ELaa8psTJ4I/zBNYrdBQlel3XNbNX5TCKFHVCYvHR5usGeJ5QmKSJd5UuRvNJf+IilZsdSHeYotkuAh8gyPJHIQ7fxbVAG7VRKtZ7OYIWPkDan690xO9hyDoRCyLh6r+x4OevWX7oivhn6UyiN7OmhPYa3cV8z8JAT0sMvgJwcRBcXFb4R7YPK16g==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by DB6PR0301MB2213.eurprd03.prod.outlook.com (2603:10a6:4:50::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Tue, 1 Mar
 2022 16:05:26 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::c1c:f98:9dd:86e0]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::c1c:f98:9dd:86e0%5]) with mapi id 15.20.5017.026; Tue, 1 Mar 2022
 16:05:26 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Cristian Marussi <cristian.marussi@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] dt-bindings: arm: Add scmi_devid paramter for
Thread-Topic: [RFC PATCH 0/1] dt-bindings: arm: Add scmi_devid paramter for
Thread-Index: AQHYJ0gzI98NnKSQaEaZikv/1tAERayfaB6AgABVqICAABNVgIACyvOAgAghswA=
Date:   Tue, 1 Mar 2022 16:05:25 +0000
Message-ID: <20220301160524.GA47342@EPUAKYIW015D>
References: <cover.1645460043.git.oleksii_moisieiev@epam.com>
 <20220222110003.GC21915@e120937-lin> <20220222160637.yn6pru4nfgwih23j@bogus>
 <20220222171549.GA2194063@EPUAKYIW015D>
 <20220224115443.fwhczfvm3cfwoim7@bogus>
In-Reply-To: <20220224115443.fwhczfvm3cfwoim7@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f00ebf2-3eb5-4ff1-2c2b-08d9fb9d4c82
x-ms-traffictypediagnostic: DB6PR0301MB2213:EE_
x-microsoft-antispam-prvs: <DB6PR0301MB22138A5C840B491541B67938E3029@DB6PR0301MB2213.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 71VNnZcFj5Svd5f8C0lsIYCXUzMb4BVDEdT+X+PQt1j5gKaAdo71J3SGoPH1LJb7ZSL7bSpdBgofsMWiqndmH162rA8erdW0BY+MTCAsTjoul8m9amDJDlAIUJVB3sWtHD52fTMIs+6OFEGCDs/F6lS/hsBg8z6KSCNfNuxAaANDkrIjlGkrWXDkX/3ftiS4NeMBFpucvau8WekPRfs89znQNu3+nrvARbvfgZwMl8oe+aVHp6jA6HzVpM0DOipwychZPp10ycBQDTXktTg25EliPeEKkB74UV8E9dY719SWCM+BlORFHi33qMAhVbwGVNh4ktaEz7lUU6JmdAXnTSXIO1omyUEgCR4jQXbpH/YzIqEe153s4EKZfOnQPJhkelM4RPUWvtcak+uVvlU/ktmjrVSh9RYA/hnz/djBq1PHj0vtN5jfAwBS1J8GO5/GEkItCLQRFMOLPQ8snxxE5gBmIkRhZo2wdGy8GXjN7u6zR7sJPgG98FfdXk0lpyJobnKnbT8gB1T1dBWs5oEACb08L2VRuqHlwZskG3Qh8tFHc6BSQ19NbxbTPBCQDIgDrS2RT8sWZg0rYVw17fFe2uPm7CwAeBf8wa+0cPPfkjnv5nE9hToi7QggQzKjRKgq/YmiVouiSXF72YaNG5jiWSm4VwcdMCVw7Iuoks1OpaVBhsKf73GUI7SbfUJ2XoKcehIWIlZLIHTpJXwD1qpnCpQFTCl+Qx1GoUYWWqb901r9dOL8NMsDJaCAMoDMMRrlUhTGnD/C77Uj9xWDw21eU6YRBi/LS2kg2bUhG/40Vro=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(6512007)(316002)(33656002)(66446008)(6916009)(6506007)(55236004)(71200400001)(508600001)(966005)(6486002)(38100700002)(122000001)(30864003)(33716001)(8936002)(83380400001)(1076003)(54906003)(9686003)(2906002)(8676002)(186003)(26005)(5660300002)(4326008)(38070700005)(91956017)(76116006)(66556008)(66476007)(86362001)(66946007)(64756008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MmARTd69UhNBla6OVZK5ljQWBjXDpQmtcHXYWazPqb0oZXmmQic2W2QwZUbe?=
 =?us-ascii?Q?8GkWBqz1MCvPu7d+NhJ6GXjHKCJYjYAIql+paeA+Ds5WFZDYyzdie7Dmd1I9?=
 =?us-ascii?Q?gJXSj5eY09EelZyMjHkFWRjva/zesk5UPmutsB7RbzEpHZOs5wjs7gjlMvdm?=
 =?us-ascii?Q?6QMXu8XFrxNWNeBYFM1chP8WtQoAIFyQ14Ie+vyVKReR2l4ROn3oErKE/DWQ?=
 =?us-ascii?Q?Z6pGnekvcCnwrKvztBfyhIcq9r4Uwd2g9RPvODa4j4d6h7VwzNCVukcyBuPY?=
 =?us-ascii?Q?hpSmDzr99FiWUG33HPmihLgnu40Tpk6xV/5sX+axzTYJmIrr7eqaXpJv9Dhc?=
 =?us-ascii?Q?BN9Lsajez0lfwpHFVZhbeKsbNtxMStVCSyQ2TR3LIT7WXv52whGQhs0ZFa7v?=
 =?us-ascii?Q?SLktNn4D/lh4i0ZQ+ZhWAlfn3wCQAABrYFknx/cCJ6sUCpW7l3SjGFV0Qxex?=
 =?us-ascii?Q?Yo1txCRQ4ald9/yfbuWZZQjSfura0JQl5CeTZ2FdiUkj9PE3tujkELiCwuJY?=
 =?us-ascii?Q?zpqFsJFNtaU01E3nYP3PWqCsbn31Yl4uXYUcpf0ymXkDJPSiqojUgp0nn2X9?=
 =?us-ascii?Q?Z2rx8145mUza103BYlBB68KMQ/XT2c4dEnA28ko03KyZc9tqgMR5fTs7uzyx?=
 =?us-ascii?Q?rOhmLCKFYegZuTwFdsMCtMoJZJ6BtRuYFphI8M0yeYwASApU2sVD7G6M5FMT?=
 =?us-ascii?Q?HWr6CAjGMOjQUH94XjowV9xQUTgXu/911wayUEfDmn1G4gNnR7HAIzwopbik?=
 =?us-ascii?Q?ZNzD6qWG3OEjVuYC5LQ3pcxWqY2Rb7jcptlzKjIiFB9fIWbUff3EBXgx1PgS?=
 =?us-ascii?Q?5Km1lzobHdfUKeyzvM7qr1+do+eZRooeBgISe5NZkjSV5aZTzLFg+eX0FmwZ?=
 =?us-ascii?Q?2btFT8+nHTTrHEpnWA/4gXyjsok6MFXkzNgbrnQyDec738THDK7kG6JCxUHn?=
 =?us-ascii?Q?ULK5MOnWoPPS5tAW8icmcdSJ0Q8802kXV6w7UV9LtKLRdFtxrfbzGJwOcAa2?=
 =?us-ascii?Q?xBhZzOL/oo9+5o1enLvB90Nuf27G5/97m+F0MBIzSv5W5eWh0Vk5YQGds0S+?=
 =?us-ascii?Q?LSClfMNtyOb5lY5gCNeGSYI5V9HEssRvORP965aspyRj2R5ic0lfqQ4Tff5T?=
 =?us-ascii?Q?HmF8nhXN3/VqgfWetjX+US/qS/Ma0anE+0jC42lHTW5ZQMQu1P9JwwxY3yB0?=
 =?us-ascii?Q?1ldc72wjSsTX/Lg+2Hw1leui6QfdQzCgenYBEC51PVrnO8alUcecfUaolCsR?=
 =?us-ascii?Q?pm+u0RpoqRvQmxsqlxUSDjbwYHvlspeGAe8B5gA6Zg5DhE6SD9Tk90gpejqD?=
 =?us-ascii?Q?QSRasbz4x4sbSVrGzz7Z4tBNO+DvQtIjjgF4Uvroz4UbDN6Xn+tYWSAx8EkV?=
 =?us-ascii?Q?MUn4QuBjQSMIk9s2BiDNF/wRSdDoj34pZXQ//fyorVEON/se33J27jR1q6h6?=
 =?us-ascii?Q?sBJ02GA/hR/h9QWXlg64Ltxxw8lhnte+AlfrLgGHQO/APhJd0ddPaQ0OHUI/?=
 =?us-ascii?Q?5zzjSZmL+9bb8h3ZbP0OC0L2n+t0FWcaIaPoD4djh/LiZAx1WyFfjPDu0D1K?=
 =?us-ascii?Q?kc5MVped2kJEn6oOc0lSnLwmiEWGb2B+VzJ2mtw4d7sQlTC4RGQZbcuJdOWB?=
 =?us-ascii?Q?PlCSlpcijylWlgrLKZe746NwkXKCvSKwE2vQaVh/ongzIpDH0VUWn1CT1iXG?=
 =?us-ascii?Q?VuMcToGQhJxap1QBrkv7Tr6cULg=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <5C13DF97149527498B342C48631A3E50@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f00ebf2-3eb5-4ff1-2c2b-08d9fb9d4c82
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 16:05:26.0735
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4fL0XkHPsuZySVkE9rBwEqjQcem17Hhqexq5dnqBu5E6vnm52m3S2HcUQRC8T/1WTAFM+iY7dT7CR6H/vE7xM187oTHPXloCeJdl/oiUiZQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0301MB2213
X-Proofpoint-ORIG-GUID: iysEd6yGwR3gRE9DjXm1Dz-MbqUgvU7B
X-Proofpoint-GUID: iysEd6yGwR3gRE9DjXm1Dz-MbqUgvU7B
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-01_07,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203010086
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

On Thu, Feb 24, 2022 at 11:54:43AM +0000, Sudeep Holla wrote:
> On Tue, Feb 22, 2022 at 05:15:49PM +0000, Oleksii Moisieiev wrote:
> > Hi Sudeep,
> >=20
> > On Tue, Feb 22, 2022 at 04:06:37PM +0000, Sudeep Holla wrote:
> > > Hi Oleksii,
> > >=20
> > > My initial feedback on this. And thanks Cristian for making it so eas=
y as
> > > you have covered most of the things in depth(which I might have not d=
one
> > > myself that well)
> > >=20
> > > On Tue, Feb 22, 2022 at 11:00:03AM +0000, Cristian Marussi wrote:
> > > > On Mon, Feb 21, 2022 at 05:26:46PM +0000, Oleksii Moisieiev wrote:
> > > > > Introducing new parameter called scmi_devid to the device-tree bi=
ndings.
> > > > > This parameter should be set for the device nodes, which has
> > > > > clocks/power-domains/resets working through SCMI.
> > >=20
> > > I prefer you had given more details on your usage model here instead =
of
> > > pointing to the other Xen thread as it helps for someone without much
> > > background on Xen or your use-case to review this.
> > >=20
> > Let me describe the process in few words:
> > We implemented a new feature, called SCI-mediator in Xen.
> > The proposed implementation allows Guests to communicate with the Firmw=
are using SCMI
> > protocol with SMC as a transport. Other implementation are also
> > possible, such as SCMI-Mailbox, SCPI-mailbox etc.
> >=20
> > In this feature Xen is the Trusted Agent, which receives the following
> > information in Xen device-tree:
> > 1) All channels should be described, each channel defined as
> > arm,scmi-shmem node;
> > 2) Scmi node arm,scmi-smc with protocols description;
>=20
> Sounds good so far.
>=20
> > 3) scmi-devid should be set in nodes, which works through SCMI.
> >
>=20
> Why is this needed for Guest OS, you need not populate this if Guest OS
> is not required to use it, right ? If it is needed just by Xen hypervisor=
,
> lets talk about that and why it is bad idea to mix that with general
> SCMI bindings.
>=20
Yes, I agree that the device_id should not be populated to the Guest OS,
but trusted agent still require this information. I can't tell that it
is needed only by Xen hypervioer, I'd rather tell that it is needed only
for the Trusted Agent. This is only our case, when Trusted adent is Xen,
Different setup, where trusted agent is for example daemon, running in
the separate guest, or another hypervisor, such as KVM etc, still
requires the same device_ids. That's why the idea was to present generic
parameter.


> > On start Xen inits itself as trusted agent and requests agent
> > configuration by using BASE_DISCOVER_AGENT message. This message is sen=
t
> > to each configured channel to get agent_id
> >=20
> > On Domain creation stage Xen will do the following steps:
> > 1) Assign channel to the Guest and map channel address to the Domain
> > address. For the Domain this address should be the same;
> > 2) Generate arm,scmi-shmem and arm,scmi-smc nodes if needed for Guest
> > device-tree (the device-tree which should be passed to the Guest);
> > 3) Process devices, which are passed through to this Guest and set
> > BASE_SET_DEVICE_PERMISSIONS for the scmi-devid, received from the
> > device-node;
> >
>=20
> I am confused here. So the Xen knows which devices are assigned to each
> Guest OS but doesn't know device ID for them, but relies on the device
> tree node ?

Xen knows the device-list that should be passed to the Domain. Each
device is represented by the device-tree path so Xen can access the
device-tree device node and get all infromation from it.

>=20
> > Guest OS will receive non-trusted channel and ignore scmi-devid fields
> > in the device-nodes.
> >
>=20
> Then no need to pass it. It keeps the SCMI agent binding clean.
>=20

Ok, Agreed.

> > IMPORTANT: Guest OS is non-trusted Agent. Xen is the only trusted agent
> > in the system. Guest OS uses standart scmi drivers without any xen
> > related changes. So Guest OS doesn't know it works through mediator.
> >
>=20
> Good.
>=20
> > The main question is - how Firmware will know what agent sent SMC
> > message and what channel_id should be used? I couldn't find clear
> > explanation in spec.
>=20
> 1. So the hypervisor forwards all the messages from different guests with=
out
>    any marshalling ?

Correct.

> 2. If Xen is just acting as pass through, why does firmware care about th=
e
>    origin of the message.
>

Because Firmware has, let's say, 15 agents with 15 shmem pages in memory.
It should know which page it should read.

> > That's why I end up with the following approaches:
> > 1) Current implemenation: Guest OS send SMC request, Xen intercept this
> > request and set channel ID to SMC Client_ID field (reg7), then resend
> > SMC message to Firmware. Firmware parses SMC Client ID to get channel_i=
d
> > to work with.
>=20
> As asked above, why is this information important to the firmware.

Please see above.

>=20
> > 2) Another approach is to generate unique FuncID for each GuestOS. In
> > this case no interception from Xen is needed - Guest OS can work
> > directly with Firmware.
> >
>=20
> I think that is the only way today to support multiple channels with
> SMC/HVC. The reason for that is since the SMC FID is custom, we can't tak=
e
> custom parameters and write a generic SCMI smc transport driver. This was
> discussed and we decided to go for different FID, otherwise we would have
> to standardise parameters to the custom FID which is insane IMO.
>=20

Thank you for the clarification. I will refactor Xen code.
Do you mind if I mention you in the cover letter and say that this
approach was approved from Arm side?

> > I hope you'll be able to help me with that.
> >
>=20
> Thanks for details. It definitely provided more information though not ye=
t
> complete as you can guess with my questions here.
>=20
> > > > > Given parameter should set the device_id, needed to set device
> > > > > permissions in the Firmware. This feature will be extremely usefu=
l for
> > > > > the virtualized systems, which has more that one Guests running o=
n the
> > > > > system at the same time or for the syestems, which require severa=
l
> > > > > agents with different permissions. Trusted agent will use scmi_de=
vid to
> > > > > set the Device permissions for the Firmware (See Section 4.2.2.10=
 [0]
> > > > > for details).
> > >=20
> > > I am bit confused here, so you expecting a non-secure/non-trusted ent=
ity
> > > to supply this device-id to the Trusted agent ? Is that not the breac=
h of
> > > trust as any non-trusted entity can supply any agent-id and get the p=
ermission
> > > to access the associated resource in this way ? Or am I missing somet=
hing
> > > totally here.
> > >=20
> >=20
> > No, Device-id will be used only by trusted agents, which is Xen in our
> > case. Please see above.
> >
>=20
> Understood now, and I will assert guest OS must not have it in its DT.
>=20
>=20
> [...]
>=20
> > > >
> > > > So in all of this, I don't get why you need this DT definition aggr=
egating SCMI
> > > > resources to SCMI device IDs in the Guest OS, which is an SCMI agen=
t that does not
> > > > need to now anything about SCMI device IDs (at least with the curre=
nt spec): this
> > > > would make sense only if the Linux Kernel was the TrustedAgent in c=
harge of
> > > > configuring the devices permissions via BASE_SET_DEVICE_PERMISSIONS=
.
> > > > (in fact you said you won't provide any code to manage this scmi_de=
vid
> > > > in the kernel since those guests are not trusted agents and the won=
't be
> > > > allowed to set device permissions...)
> > > >
> > >=20
> > > +1 (again)
> > >=20
> > > > The only tricky part I can see in all of the above is agent identif=
ication, since
> > > > the agents are assigned an ID by the SCMI platform (which can be qu=
eried) and they
> > > > have a set of dedicated channels to use, so basically the platform =
really identifies
> > > > the Agents looking at the channel from which a request is coming fr=
om and AgentID is
> > > > not carried inside the message as a source and cannot be spoofed.
> > > >
> > >=20
> > > IIUC, the physical/virtual transport and associated transport chosen
> > > identifies the agent for the SCMI platform.
> >=20
> > Could you please clarify what do you mean under "physical/virtual
> > transport"?
>=20
> I was speculating some design in Xen on how it present virtual channels t=
o
> guests. Ignore that as I now understand you are using SMC.
>=20
> > For now yes - Firmware should get information for the channel from
> > transport.
>=20
> Indeed, with SMC/HVC, you will need different FID for reasons stated abov=
e.
>=20
> > >=20
> > > > > Given example shows the configuration of the hsusb node, which is=
 using
> > > > > scmi to contol clocks, resets and power-domains. scmi_devid is se=
t
> > > > > equals to 19, which should match defined id for usb in the Firmwa=
re.
> > > > >
> > > > > Trusted agent will use scmi_devid to set the device permissions f=
or
> > > > > the Agents. Guest OS should not have an access to the permissions
> > > > > settings, so no code to process scmi_devid was presented in Linux
> > > > > kernel.
> > > > >
> > > > > We are currently contributing changes to Xen, which are intended =
to
> > > > > mediate SCMI access from Guests to the Firmware. Xen uses scmi_de=
vid to set
> > > > > the permissions for the devices. See [1] thread for details.
> > > > >
> > > > > [0] https://urldefense.com/v3/__https://developer.arm.com/documen=
tation/den0056/latest__;!!GF_29dbcQIUBPA!mGggDzmp0B8cSdGJdH4utz6sx7g5PMXq05=
mXf91dU8XgkJaCuEpHdARZCdl-g1BnrduL$ [developer[.]arm[.]com]
> > > > > [1] https://urldefense.com/v3/__https://xen.markmail.org/message/=
mmi4fpb4qr6e3kad__;!!GF_29dbcQIUBPA!mGggDzmp0B8cSdGJdH4utz6sx7g5PMXq05mXf91=
dU8XgkJaCuEpHdARZCdl-g-bWzzb5$ [xen[.]markmail[.]org]
> > > >
> > > > IMHO, but I could be wrong, looking at the current SCMI spec you ca=
nnot just
> > > > gather messages from a set of GuestOs talking via different SCMI ch=
annels and
> > > > then pipe/route them through a single channel to the backend server=
,
> > > > attaching/spoofing some sort of Agent source ID to each message lik=
e you seem to
> > > > be doing in the Xen series
> > > >
> > >=20
> > > I haven't looked at the other series, but it is hard to say the spec =
prohibits
> > > this. I don't understand that spoofing part, but Xen hyp can arbitrat=
e the
> > > requests across guests I believe. But the devil is in details so I ca=
n't
> > > comment on what is done. What I can say is this Agent ID is in each m=
essage is
> > > not compliant to spec.
> > >=20
> >=20
> > In our implementation XEN do not copy any data from shared memory. The
> > only thing it does is letting Firmware know which channel it should use=
.
>=20
> OK.
>=20
> --=20
> Regards,
> Sudeep

Best regards,
Oleksii.=
