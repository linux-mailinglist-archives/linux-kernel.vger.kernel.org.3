Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A9A4C8E65
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 15:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235430AbiCAO4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 09:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235475AbiCAO4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 09:56:33 -0500
Received: from mx0b-0039f301.pphosted.com (mx0b-0039f301.pphosted.com [148.163.137.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313FCA2533;
        Tue,  1 Mar 2022 06:55:50 -0800 (PST)
Received: from pps.filterd (m0174683.ppops.net [127.0.0.1])
        by mx0b-0039f301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 221EkYhH007374;
        Tue, 1 Mar 2022 14:55:38 GMT
Received: from eur04-vi1-obe.outbound.protection.outlook.com (mail-vi1eur04lp2059.outbound.protection.outlook.com [104.47.14.59])
        by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3ehnj1013b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Mar 2022 14:55:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hESJTGgy/vN/BFPcqX/0+B/7FRs9Y56+NT81+OiIuOjSsaOmx0508WBxYRV6czQbKgAStP92WE5DCxGNNGuH+tLGqgDn1UP07pvkIQ3HW2bBHOjmDqEXuSUT9BlwBiLdiklRG+NpMLvNTZLYFNVecSUqUm7NTD/uiZd2MZQiIaq2R/OWW5v0i10AXy6SUKtbK6yvpx1HtlO30s9TGk5SC/yz4J5N6TMK0x09PCE+cp5yr5sFVLILjxjfn00fa0LBYgYUcTeurdnqtBfS3PgpCcAUxCTaX4iEpY90IbsHePHZgLaWEMieIKu2c7qrxBuJhg0EI28JTZNOgimhrvJoow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHReyZ8kW4fBejb51kCSYmI6gx/e8/zF0OjOa4uXMH0=;
 b=YFiJDATPyvPvNIxj9cVRsmjT/CQ/CF0rUgaXVZAeAc/jlwLJaazNrOgp5087/yUsXVwSJX3+QOyZjDlSXDY2Z6+7Co1kDtFKTzM58HMtIw06ZXcmp/21YsS2vzdW9D0c+SPPH8uwhPMvdiKg+gkXcO+sOR/NX+9P8b4e5+EcSIbSF+jUQ3iplhlRApbGzkb5rfbz8t27HgaaLLsILop8x6RiMNP1/hagbOA0E4M3kJmTP59crM7pW48xNRsOOnmonmL0qrtIiy5f/SJylqIxQNmoDodpV/6pOB6Y/wzF10yUYJBBbleEk/Rus+KfxTb99T8TYSNKRJlykECFvD2umw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHReyZ8kW4fBejb51kCSYmI6gx/e8/zF0OjOa4uXMH0=;
 b=UBjVbyjs3R8BRp8HABO1L4UxlLWApzW2x1i0Rctyr352YAeVbpnBl7QVO2o7dXbFWasMfchHJLgbpbS5bg5X0nspbSEuRxnVf5xyz1R/1PPtcD1icF2eYGMKOoKqwbjAKZfi2Hc4EDDxPrYDO/nKDib1DiXjmeYSY6f99m1VkE270Eg/WTuHi9AwuLu4OA3U50Y/2twV8zQdk8cvZvVA6Hj2wuMf4QqHldDfM5Lo0Pqj840mNcUsT7rLVnvvUbBYR2YE6pICw6TjKbW9iZvP7hD0q0XquXQQ454itVpxujlp6Z5wIpXyYbz4y+5pZKjsH4077HpZwOr2wdM4zs5FOQ==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by VI1PR03MB4926.eurprd03.prod.outlook.com (2603:10a6:803:b5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Tue, 1 Mar
 2022 14:55:32 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::c1c:f98:9dd:86e0]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::c1c:f98:9dd:86e0%5]) with mapi id 15.20.5017.026; Tue, 1 Mar 2022
 14:55:32 +0000
From:   Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>
CC:     Sudeep Holla <sudeep.holla@arm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 0/1] dt-bindings: arm: Add scmi_devid paramter for
Thread-Topic: [RFC PATCH 0/1] dt-bindings: arm: Add scmi_devid paramter for
Thread-Index: AQHYJ0gzI98NnKSQaEaZikv/1tAERayefeSAgAAKkQCAAK8mgIAAiGsAgAAWbwCAAi32gIAAb+kAgADXHgCAB17IgA==
Date:   Tue, 1 Mar 2022 14:55:32 +0000
Message-ID: <20220301145531.GA43106@EPUAKYIW015D>
References: <cover.1645460043.git.oleksii_moisieiev@epam.com>
 <2546477f-4190-e838-3095-f47b31802445@kernel.org>
 <20220221213932.GA164964@EPUAKYIW015D>
 <7f17ab8f-429f-d2e0-8f5f-bfa2dd19cc49@kernel.org>
 <20220222161440.xadrgjftdyxenxgo@bogus>
 <20220222173458.GA2310133@EPUAKYIW015D>
 <alpine.DEB.2.22.394.2202231841190.239973@ubuntu-linux-20-04-desktop>
 <20220224093232.GA12053@e120937-lin>
 <alpine.DEB.2.22.394.2202241415180.239973@ubuntu-linux-20-04-desktop>
In-Reply-To: <alpine.DEB.2.22.394.2202241415180.239973@ubuntu-linux-20-04-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e896c15-3574-4cd8-d0cd-08d9fb9388f6
x-ms-traffictypediagnostic: VI1PR03MB4926:EE_
x-microsoft-antispam-prvs: <VI1PR03MB492613F0CB15C84EE01C4BCEE3029@VI1PR03MB4926.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OgSCFIEAV6gzWgIzZUeCXmbC63AMFVGA28RHZhKNyL820ENeCd4p3tWvWW0/TZeVxYI+UFqQY9juC8IwkrGXxEwg0ERT7Qgb3AAMbAKrpBYsb6NOsXnE8Vu0aAiiZ0DBglcrjachWlsCCrmY9lrsd6w1rWZ5wq/VqSa8ge4eahuGyCj97wKpX2JB1gnrVyMl23ZLkTUcvvMnfiBTdaW6lQetC6yGH1JzoXmtcPz3EY5N88ww5NXlEgb/OjFny/cJ1Kyyq6I9HyROn3+yYeQtiG96fxBulxrzMLOzaRd4nTnt10zDKtgMxB1mlLn7GjO628n/Lr5LUksnTEYJ5DUjj4maOYEhkYp05FIsxgf/xWzjUX/afZ+BWOlYKDfVdljVaoImaOBlVtPcJwwUPvWcLZ4d1ksOtjaz14ow4G2+enIMdEMGk0gu2pAa1t0YEjwxRfX9KGojIDch5T0vQoI3qpeIPngn5F6TDuJVOWdhfC1yjZQpNnquMDAcI2iQV3BmrJJVkaaztgQwFlrM+R+vwpOweoP4PIzr/9HDaOhQ6mgKp7nH3fRIKs/ls2C4FNG0wArHiBUGQPNJDFg32EfJSG+T1UkJ9OlI4oejiosY2aiNaBaqHpUn/XrrimxW7UBNhwFSzVwd5e6yci8LlfMvJW+NnWjtYPMeS3b73U9hyUeR8VRjp1r7+aydE2ttyR2CSfbm0ffMDMyrUSQ1SVQvEw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(7916004)(366004)(1076003)(38100700002)(26005)(186003)(83380400001)(122000001)(5660300002)(8936002)(33716001)(2906002)(508600001)(8676002)(6486002)(4326008)(53546011)(55236004)(9686003)(6512007)(71200400001)(6506007)(316002)(66556008)(66446008)(66476007)(64756008)(66946007)(76116006)(110136005)(91956017)(54906003)(38070700005)(86362001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yqeMgAM8v6lMwl0Y/nx0l1l7D2hxiIOoPbSF8FYE3V371u3034Zly/++5uXs?=
 =?us-ascii?Q?hHg7NW/6yQURf+JUxJ0SNBH3Si8ZMQzK0WvO3kbzwEU9YA8PXozBoWDliBFu?=
 =?us-ascii?Q?KheIFDdD+sCSzPzNVeLuj1LQUHwCCXtyLv5UsfvTWVZYsEsjMHIB8cY5BnB6?=
 =?us-ascii?Q?n9WPypK0xll2u4EC61ezaNz5syAWMU+lEDnUuh+LO0IfrtPTnOnuYfbk4boy?=
 =?us-ascii?Q?aLL67HqDIB3thqexqkJpGk1+CD8rxr+End+R1CcmwVlalIwcZum0Z5xzrr80?=
 =?us-ascii?Q?BiZeMCgglrzuJ2pz1uFajg53WCydSASjGHK47zACnbnfj6VdMdGvuQKi14p5?=
 =?us-ascii?Q?nQd7FoLVyPsCj9Kk1+nCfF9BEUoizJpgC4DHhWK4pO8iHAuPTxWSb3TM1JN3?=
 =?us-ascii?Q?9JQM30kekPGTQHe3FedXJhdp5zGueCmE3EvNCguFc+wJFJf2HCy8NKxzDedA?=
 =?us-ascii?Q?mEDEH75b7iRnVZaM+MJIJnW4MDEQsujTNlohYpz6G1pxODdS9UEzauNvuxUD?=
 =?us-ascii?Q?ul4VfLh+CahaTjHyJzZu0UsQ92JY5mCIAoP/u7E/WBnvZOifGH6+akbnvlpj?=
 =?us-ascii?Q?5GVxXm5jY8ZH9thXQgw9K9d41nQVfeIhdKjRC+TI6YgOZNdRMN/797nIrTmq?=
 =?us-ascii?Q?zJmF0Ua6OdZzmHjQ20+GSe2iGt0rThavA6ltf7VnvY4RyADs8aG7etLXRyjr?=
 =?us-ascii?Q?YfavakHNi+bJFu9yMGNizTlmUDE4g2I7MWND1AYiPM8jW31NhFZ2LCYulZZ0?=
 =?us-ascii?Q?l3vsTSVq/jGjCDFvc1r30azEgpHAVG8lLt4ziOX+6gtSqKOGfj8XcxQ2x+lX?=
 =?us-ascii?Q?YE90NUnUYSYiYdRNkA9ay9i/7YtUoxYQv2ieE5KE4c8T36/PPWB1Qqp70ocT?=
 =?us-ascii?Q?d3KWKxSOVrflj9Obq48b7RurhmcyJ5Sv3E6NIA4O4OKa/PYVm0ciyQ+qmjvk?=
 =?us-ascii?Q?I+dXhlY3sv9rKt0RLhr6Zy3rW7MerKmdNdyPrB3/c4It6AhsV/gg62iImHkl?=
 =?us-ascii?Q?50asviG9O1fjghlogev2Atkp8Lo/cZJJqj38+hesupUbk0HHwamhhexWrA/A?=
 =?us-ascii?Q?udvoP20DVYt6d7y9f901hBc3lpnXyEIwgKugMsL7nAFPulAX9+VpnZ8dMOOL?=
 =?us-ascii?Q?84BmO0XjOnNmmHzqu3qAdFy89SF+ZaouhkXSpNeoksZ/FCoOnw1RKr2qmeKg?=
 =?us-ascii?Q?q29BuD6cWXXfojxLuMuJgxWtLSeOUmSj638hQpVpMaLo7NwR0tn8bzFRMFCu?=
 =?us-ascii?Q?LYi7DQXzuNd1K0+DTAc5NLgMWOiWdqSygkczmpqod5eNhoEIo4WFG1hZUuTI?=
 =?us-ascii?Q?cqX86NCz0g6qRAUUx7GFcIQ3W89a3G7iSpAeY3SYk/lEZgvmt3VdBYrK/h8H?=
 =?us-ascii?Q?oDJDA7XP1Gvgy3NzPWiXk9XHduYftYjSNlTgh5D53eFriYyuOfJu0rYf5/pU?=
 =?us-ascii?Q?evgf4Z/ztiN7OhWoww9pM4myujbfHFHagqVjRbuZHjC8lBFJyJZtKNWIc34l?=
 =?us-ascii?Q?RCYdyXk0hrBZ7zIcGyNQX11qV+YrPI3M9V6d1bxY0etvYjxfeIu0+BqDneIy?=
 =?us-ascii?Q?zF03kBw0741qDkPFtFKCbUJV4pXV0sa66Ero8P5/pC+hzm+jPjY8XlH2uKRC?=
 =?us-ascii?Q?rzVqrd7gpocAm8EXS5EaZictBfcMPGBnsJq0r+ZllQoRSuEGboLMJeyan8EU?=
 =?us-ascii?Q?bQ9ZZBMdD2uZ0K8r9ptqpUTUz7c=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F19F99EE4A14194E986D45301CC4BD56@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e896c15-3574-4cd8-d0cd-08d9fb9388f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 14:55:32.5495
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a8NJvWr1K1xcpMefYr2Linvz3ufhVQ4YKunUg6y/qA5olyGpWipy/2bCKLUhohbei7dBk4BHGnJ3b3Hrs5J3R311d5O9pXCUQFdFl7Dvh+A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR03MB4926
X-Proofpoint-GUID: KDJ2DA8iiaM96FAizkNtrUkLDxwsTJoz
X-Proofpoint-ORIG-GUID: KDJ2DA8iiaM96FAizkNtrUkLDxwsTJoz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-01_07,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1015 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203010080
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stefano, Cristian,

On Thu, Feb 24, 2022 at 02:22:28PM -0800, Stefano Stabellini wrote:
> On Thu, 24 Feb 2022, Cristian Marussi wrote:
> > On Wed, Feb 23, 2022 at 06:51:59PM -0800, Stefano Stabellini wrote:
> > > On Tue, 22 Feb 2022, Oleksii Moisieiev wrote:
> > > > On Tue, Feb 22, 2022 at 04:14:40PM +0000, Sudeep Holla wrote:
> > > > > On Tue, Feb 22, 2022 at 09:06:25AM +0100, Krzysztof Kozlowski wro=
te:
> > > > > > On 21/02/2022 22:39, Oleksii Moisieiev wrote:
> > > > > > > Hi Krzysztof,
> > > > > > >=20
> >=20
> > Hi Stefano,
> >=20
> > > > > > > On Mon, Feb 21, 2022 at 10:01:43PM +0100, Krzysztof Kozlowski=
 wrote:
> > > > > > >> On 21/02/2022 18:26, Oleksii Moisieiev wrote:
> > > > > > >>> Introducing new parameter called scmi_devid to the device-t=
ree bindings.
> > > > > > >>> This parameter should be set for the device nodes, which ha=
s
> > > > > > >>> clocks/power-domains/resets working through SCMI.
> > > > > > >>> Given parameter should set the device_id, needed to set dev=
ice
> > > > > > >>> permissions in the Firmware. This feature will be extremely=
 useful for
> > > > > > >>> the virtualized systems, which has more that one Guests run=
ning on the
> > > > > > >>> system at the same time or for the syestems, which require =
several
> > > > > > >>> agents with different permissions. Trusted agent will use s=
cmi_devid to
> > > > > > >>> set the Device permissions for the Firmware (See Section 4.=
2.2.10 [0]
> > > > > > >>> for details).
> > > > > > >>> Agents concept is described in Section 4.2.1 [0].
> > > > > > >>>
> > > > > > >>> scmi_devid in Device-tree node example:
> > > > > > >>> usb@e6590000
> > > > > > >>> {
> > > > > > >>>     scmi_devid =3D <19>;
> > > > > > >>>     clocks =3D <&scmi_clock 3>, <&scmi_clock 2>;
> > > > > > >>>     resets =3D <&scmi_reset 10>, <&scmi_reset 9>;
> > > > > > >>>     power-domains =3D <&scmi_power 0>;
> > > > > > >>> };
> > > > > > >>
> > > > > > >> And how do you prevent DT overlay adding such devid to any o=
ther node
> > > > > > >> thus allowing any other device to send requests with given d=
evid?
> > > > > > >>
> > > > > > > Thank you for the quick response.
> > > > > > > scmi_devid value will be used only by Trusted Agent when the =
device
> > > > > > > permissions are set. Non-trusted agents, which in our case ar=
e
> > > > > > > represented as Guest OS are using scmi drivers, already prese=
nt in linux
> > > > > > > kernel, ignores scmi_devid and uses scmi_clocks, scmi_power, =
scmi_reset
> > > > > > > nodes to access to SCMI protocol.
> > > > > >=20
> > > > > > Ah, ok.
> > > > > >=20
> > > > > > >=20
> > > > > > >> Plus few technicalities:
> > > > > > >> 1. Hyphen, not underscore in property name, so scmi-devid.
> > > > > > >=20
> > > > > > > Thanks for the tip, I will change that in v2.
> > > > > >=20
> > > > > > Few more thoughts:
> > > > > > 1. This looks specific to ARM SCMI, so you also need vendor pre=
fix, so
> > > > > > something like:
> > > > > > arm,scmi-devid
> > > > > > arm,scmi-device-id
> > > > > >=20
> > > > >=20
> > > > > Keeping the other discussion separate, I wanted to comment on thi=
s.
> > > > > I agree with Krzysztof on having vendor specific prefix if we dec=
ide to add
> > > > > this device id thing. However, I prefer not to use "arm,scmi-" he=
re.
> > > > > It can be "xen,scmi-" as we had plans to introduce some concepts =
in SCMI
> > > > > spec that may use looks like this device-id. I would just like to=
 avoid
> > > > > conflicting with that in the future. It may happen to be same in =
the future
> > > > > (i.e. this xen device-id matches 100% with definition of device-i=
d we might
> > > > > introduce in the spec, but I want to make assumption otherwise an=
d leave
> > > > > scope for divergence however small/little it can be). No issues e=
ven if
> > > > > they converge and match 100% later in the far future.
> > > > >=20
> > > >=20
> > > > xem,scmi- works for me. What do other thinks?
> > >   ^ xen,scmi-
> > >=20
> > > If this problem was Xen specific, then it would be fine to use xen,sc=
mi-
> > > As Xen developer, it solves my problem and I am fine with it.
> > >=20
> > > However, from a device tree and SCMI point of view, it looks like thi=
s
> > > problem is generic and it just happens that Xen is the first
> > > implementation to encounter it.
> > >=20
> > > Cristian wrote: "The SCMI spec does not indeed cover the discovery of
> > > such devices and the related associated resources: it indeed delegate=
s
> > > such description to FDT/ACPI as of now." How is that supposed to happ=
en
> > > today with the current DT definitions, regardless of Xen? Is it a gap=
 in
> > > the current device tree binding?
> >=20
> > What I meant is that in fact SCMI device IDs are NOT needed in the Linu=
x
> > Kernel DT, in fact also this series does not add any code using it and
> > there is no code as of now in Kernel to issue BASE_SET_DEVICE_PERMISSIO=
NS
> > commands; Linux Guest OS in the above scenario is a Non-Trusted agent a=
nd
> > doesn't need to know SCMI DevIDs and must NOT have access to those IDs =
for
> > security reasons too (as Sudeep was saying): the Trusted Agent (XEN her=
e)
> > and the SCMI platform server are the only ones required to share the
> > knowledge of such Device IDs (and how the related resources are grouped=
)
> > via some HW description scheme as you are doing indeed in XEN.
> >=20
> > So, while on one side such device IDs discovery is delegated by the spe=
c
> > to the HW description mechanisms, it seems just not needed in Kernel DT
> > given the kind or role it has as an SCMI agent in this context: as said
> > in fact there won't be any use as of now in Linux of such DT entries as
> > of now.
>=20
> I see. This is one of those "difficult" cases where the device tree
> binding is needed but it is not used by the Linux kernel. (We have a few
> cases like this in system device tree and the more device tree gets
> adopted by other projects the more will see instances like this one.)
>=20
> In that case, I think it is OK to call it "xen,scmi-" if Rob also
> agrees.
>=20
> After all, we are currently using in Xen a property called
> "linux,pci-domain". We might as well have Linux in the future use a
> property called "xen,scmi-devid" to even things out :-)

In this case, if Rob is ok with xen,scmi-devid then I'll rename binding.

Best regards,
Oleksii=
