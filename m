Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788504BECB9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 22:40:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbiBUVkH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 16:40:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiBUVkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 16:40:06 -0500
Received: from mx0a-0039f301.pphosted.com (mx0a-0039f301.pphosted.com [148.163.133.242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 349C122B3F;
        Mon, 21 Feb 2022 13:39:42 -0800 (PST)
Received: from pps.filterd (m0174676.ppops.net [127.0.0.1])
        by mx0a-0039f301.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21LLP4Ah008385;
        Mon, 21 Feb 2022 21:39:36 GMT
Received: from eur01-ve1-obe.outbound.protection.outlook.com (mail-ve1eur01lp2056.outbound.protection.outlook.com [104.47.1.56])
        by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3ecjmtg15c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Feb 2022 21:39:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbUy+s70DQHWfmOezqRRIpDaFY0PibHwjhojcLruz8ajIobDIaQOTmwFr/ixiUoA+2RFE1u8HsbeBc5/RHswoY8JMQtT1kHzjypa4kvNb+mS7XY15XkhJhef+jltjwGyxlH11+RMd7ZSDCWicvI0/0g1+Hha9wURovLXE9Qed8cmho2Uwz+8RHow30h9QfnFZz+QRiwG4UoJESxQ+hQDeVUNvNRBas5SaldPjl0EuukGa2zan2xMQM7E4PQWJWTQ8UXOngxWitymrk8t8pr21uaRNWUDPEDe+9HfEBnXSa51JM59KpC7SNa641+IPu2K5rqSSeo0IjIYnorCT3JDlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H+bOLgcOIrKCwLfXPKNG3YLTAkJCMbKkdin1bm9N3fw=;
 b=lZB1Gd8VehuZNzU99po4+iIlfUWVORAZ2WrFHpocJJ06sXtgHu78iO5xT+0gpN72cJ/1CRy2KI+fqDunOPVyF0Mh/L77k8MfbcDzOA4ab03vkQ7XO7UOnHOj21YTNkR4jFOYbqoooGrhB0Az45F596k72ndiwPxcdhh0V9K8GFoH4OGa9k7aicY1ujWS8QKWjKpRCJluAkoC+BS3fMg0CVsFfO85EnFEy5N7VOAw7BGrxqwcPAOEtuWoRzFJQNKnMcwqyPOOKLZjrAeEo//DHF5IMH5NPFSnOLStks5CiFv+IfvDB6Ipv2idBVwaFD0QvHjhnRvDJ2wtQbmK13rhMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H+bOLgcOIrKCwLfXPKNG3YLTAkJCMbKkdin1bm9N3fw=;
 b=ExLzBhocsNSr4yBRKlOKzaGha5P3EtgncVz0k06zGTkiNO3hu64zOOMaJaV2qY3F2oh2E8I4/twZHp78y/WK9197aj7EKqbs4Ap/gMJ+fu3NZfx74EZfksIeovuPYYFVL2oZcUwt8EHxHtT7zj3U+OINoYgb51lxScWJZwvGwFPlTVpNde2I9tbvYpS8RKuVHqgLDO9k+qfP6a1bnW+8/4zAJuLm8Ufa38pi4KD1KvuaYmK7NFL8uoOGcSks6t6CBqrECNKBwI3tMNyU4OC8rb01irP+uQ8ktxAVhgyQGjEVbILQIEq118necxeArLsd+YmRET9FseQ3zsOWq7VAnA==
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com (2603:10a6:102:ea::23)
 by DB8PR03MB6330.eurprd03.prod.outlook.com (2603:10a6:10:136::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.27; Mon, 21 Feb
 2022 21:39:33 +0000
Received: from PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::c1c:f98:9dd:86e0]) by PA4PR03MB7136.eurprd03.prod.outlook.com
 ([fe80::c1c:f98:9dd:86e0%5]) with mapi id 15.20.4995.027; Mon, 21 Feb 2022
 21:39:33 +0000
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
Thread-Index: AQHYJ0gzI98NnKSQaEaZikv/1tAERayefeSAgAAKkQA=
Date:   Mon, 21 Feb 2022 21:39:33 +0000
Message-ID: <20220221213932.GA164964@EPUAKYIW015D>
References: <cover.1645460043.git.oleksii_moisieiev@epam.com>
 <2546477f-4190-e838-3095-f47b31802445@kernel.org>
In-Reply-To: <2546477f-4190-e838-3095-f47b31802445@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33bcae5b-42f3-406b-66af-08d9f582a648
x-ms-traffictypediagnostic: DB8PR03MB6330:EE_
x-microsoft-antispam-prvs: <DB8PR03MB6330D4E03970BD6EFF64806CE33A9@DB8PR03MB6330.eurprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xE+aqRMKUslgJobitT/OwTAq0Y+HkvlKxFWVuh1iH2hRPHaELNmtTwViWWFF7dYstGVG0fvPZ2am/dbLk/Ntn9yo5uwAjd4j6TIIjydAtuXuXm9LqDpIhRnh2HnLO8dLOhhkmQKdlPY4mP5B0Ljq6F3v4Z6NSG8tRWDZ0AeA70CMwwjTIAr17hBFV/3PA058mymu4Rf84JnTIiajam3FEqy83giZqX5Fb/9q1u/ixGdf9xzIXiBDz1Ey72tUEUv77o2FDZySsILyOHzpU0LD9aMjWut8cDU+eu2Wgy8CBvHcnl4yAw4vIuEli9scXzrXX2Ucn35UfARtiCPJmrh9cTYwdVKuQ+MZuYxn095/A3lXsq9kPJe8hhp82lsxnd+btZhXEMXxfO1jos4fdmzYTys1IFk/2hPlYLBmVNkN8Om03VrQHRYcGxRfG17oVPEf+ejXBkcIOnuGKJw3oj30I9LxfVQYKqFt1OxwzPbs16XsTwbcj3R0PanpFsCVkaxwfPkRhp+dmvF6tRr7bwRLJcLtsrqZwyTBhhFhM09Ec/UDXyhoGLSehu24nZyxGQ88Kn1++GvyVr8QWE8SVWO59bNbrhNys3X6bAepNIaVv3gI1pBXCJ/G72GIsMUB5uFT3Ez1n78eXjHRoePXuIcSx0ShFZj/NRqcBNgRTFSuJyOIAjT9VI/pf/IxFjDIoCNNRzk8i6UYlLo4VEHj9QeYuA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR03MB7136.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(1076003)(38070700005)(86362001)(26005)(8936002)(33716001)(122000001)(9686003)(38100700002)(2906002)(5660300002)(6512007)(186003)(316002)(91956017)(66946007)(71200400001)(83380400001)(64756008)(76116006)(66446008)(54906003)(6916009)(53546011)(6506007)(6486002)(33656002)(8676002)(508600001)(4326008)(66476007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0JjZUsiL3Xd/z5lA+HA04VA8ktPPxcqeShFcT5jxAhSaCHxuEZy2MszntySM?=
 =?us-ascii?Q?E6LFyJAHlWRV0zJ660XX1kNc3pSWUo81yoyZHAwArby4eJJ5eKXtH/0P8HxD?=
 =?us-ascii?Q?NO7V+UUlBmTgwVFHZe1tIFE4s1ojl1EVf+HdqhHhS4QeqkyyNn7IMMOeX1nf?=
 =?us-ascii?Q?vHCtl5eGb2+phNcEyA47AkjewXjXX6hjK71CbrCCgrYE03ZLXIc6O1Pmvb8U?=
 =?us-ascii?Q?KMSMnIF9e24NN+wBfHV7JvC/Q+2/CQVLzquR9aQwDHDUjWnIUTbtS4K6Xrov?=
 =?us-ascii?Q?K7et1i3XSfXFz/uvMvHfQdbSIBBEAbFJVJhdA8RmEJGte4fadtqDoF+d1C0f?=
 =?us-ascii?Q?s/g1PJO13R9iGPsnnZpki0+uVPf2xDmQMs14GuxzhK7i5Se6M2nw80SSvYe3?=
 =?us-ascii?Q?OcKASCKRRTwunxXGc3fxNBpK00Q+PIfyQ7B2JinojvuTFnrmak9ZJJH7IZq5?=
 =?us-ascii?Q?GmufXplbaSqCuJKqRwOyzGPnpnjJOOUCnrz8lCBbi2ky04htQM/ESYRWZOGu?=
 =?us-ascii?Q?vmhL6RNZISOqvK8uuZvy2Y1yWWrHL8NhKQDGRIsU6WIpdr+tOmaJXigmTkrm?=
 =?us-ascii?Q?DXP8WhurqYkV27dHrWDvwnelWqs6X9de52Je6GgyXsrFULNCerBT6IbUe2S4?=
 =?us-ascii?Q?427gV1qzMsD0UpiyDB3HMuG8/WJItcfJJeAD29cOcBSLbrOIMLUl7PrP6APk?=
 =?us-ascii?Q?skhLnqSKc0bau6s2291byDpkdnxAT4r4OuNdwDa4Pop4RxxqqTO1xkHLvQmm?=
 =?us-ascii?Q?nxtw1VLh6al8SWAJ21iz0DCYmOUqenZSTBPjLiKMCb/WTWlHgCI788kJ0O9Z?=
 =?us-ascii?Q?NlEFKqiumh8kXnRJlk7qqVwutpBMxbw6zy7zt5w/KJOLfOvFQX2JncLXEAEh?=
 =?us-ascii?Q?hx6R9maQLTGebBcltHri9MJxaaGisMk966kT5ZIR0bls7H5qQKFy0r6DPR8h?=
 =?us-ascii?Q?VS1jTqrOHnbpN2ImO3cbGaOkphxF8ZT1Ov5w5eMr9kC0ZKhBK0N/tkTbg1ny?=
 =?us-ascii?Q?4yV2Avhn66J0wQrtYgt3wyckW1aGrHRPDL+lbt8sqXfAoqtbPeQSDtMD+U0x?=
 =?us-ascii?Q?zFuQZlakiByopLYjGjgYoFzKCU33sUyRyjHGj3/u3hq8MMx3Kcs9Q/mTQLMa?=
 =?us-ascii?Q?EpprwAsF9+GdxE4r0YX1s6eoNhiRMspxxZ0JDtg7zSrkv5Te9tYkVKPbCT/k?=
 =?us-ascii?Q?kcyS+Ip+Z2mkMpzTeA3kyr6EcQ8hO83byGeOyq0/ZuBv4u/eBF5AFTFfveou?=
 =?us-ascii?Q?pSO/kWIBz1LOc6Mmk3eP6K4OOxVw/pgBhYbldLR8rksAedR7YzG4ZlTaBq6O?=
 =?us-ascii?Q?0om2TCA5k/PfMWeeGY3fPhHxNDja3DwuI5CVxFurV52I8j8Zth7sXxgoI0R0?=
 =?us-ascii?Q?9UYE9saQye1K/Y18G4rMhW2GQiCrw/EjWz7+qhEyN5/pdBeg38cpC4hu1WlI?=
 =?us-ascii?Q?y8M2SHIP2lfOvz/L5ivsVAu4dxFy+ayBTiiGdZAut4vIo0Jndfjh2xaReyRV?=
 =?us-ascii?Q?0dgGe1nrox0Uj6pHWKgTXFLrRji/f/ayBcz5PtThf0V7kglJcZCp3Qs0thuj?=
 =?us-ascii?Q?a14jlSJ259aQP5Ln87W96QFcu1dzRAKZwYf+IL5t0lgvOSfxjC9Hj+I6yhJ8?=
 =?us-ascii?Q?E8Bgk32/pZKQD0Z+uTbRYepwTiO6kwlZKpDUGEpmK/XCXXSn6iSGsICVjJOV?=
 =?us-ascii?Q?V3KTPuTOF0xms7pjHDNFMcW8Rvo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E1BB0A10FE58EC4E8F725A49E9295F92@eurprd03.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PA4PR03MB7136.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33bcae5b-42f3-406b-66af-08d9f582a648
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2022 21:39:33.3327
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6F6Q/HxA3qcUmm3HUqyJK+VJ0QQwP3Yeox0RsnzR/QsTnBRzcxkjiBsFGpci2DirZnQT8PxMSMEaa6jF4PtZGZhXnZcGrs6RlGKATXBxDJI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB6330
X-Proofpoint-GUID: UWfUlGNKJlsD1KPvaPqmDU51-1M6mGHd
X-Proofpoint-ORIG-GUID: UWfUlGNKJlsD1KPvaPqmDU51-1M6mGHd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-21_10,2022-02-21_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 suspectscore=0
 mlxscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202210128
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Mon, Feb 21, 2022 at 10:01:43PM +0100, Krzysztof Kozlowski wrote:
> On 21/02/2022 18:26, Oleksii Moisieiev wrote:
> > Introducing new parameter called scmi_devid to the device-tree bindings=
.
> > This parameter should be set for the device nodes, which has
> > clocks/power-domains/resets working through SCMI.
> > Given parameter should set the device_id, needed to set device
> > permissions in the Firmware. This feature will be extremely useful for
> > the virtualized systems, which has more that one Guests running on the
> > system at the same time or for the syestems, which require several
> > agents with different permissions. Trusted agent will use scmi_devid to
> > set the Device permissions for the Firmware (See Section 4.2.2.10 [0]
> > for details).
> > Agents concept is described in Section 4.2.1 [0].
> >=20
> > scmi_devid in Device-tree node example:
> > usb@e6590000
> > {
> >     scmi_devid =3D <19>;
> >     clocks =3D <&scmi_clock 3>, <&scmi_clock 2>;
> >     resets =3D <&scmi_reset 10>, <&scmi_reset 9>;
> >     power-domains =3D <&scmi_power 0>;
> > };
>=20
> And how do you prevent DT overlay adding such devid to any other node
> thus allowing any other device to send requests with given devid?
>
Thank you for the quick response.
scmi_devid value will be used only by Trusted Agent when the device
permissions are set. Non-trusted agents, which in our case are
represented as Guest OS are using scmi drivers, already present in linux
kernel, ignores scmi_devid and uses scmi_clocks, scmi_power, scmi_reset
nodes to access to SCMI protocol.

> Plus few technicalities:
> 1. Hyphen, not underscore in property name, so scmi-devid.

Thanks for the tip, I will change that in v2.

> 2. Your schema does is not selected by anything. How is it intended to
> be used? Nothing is including it, either...
>=20

The idea is to use this parameter to set the device_id for the device in
the device-tree, which matches to the device mapping in the Firmware, so
Trusted Agent can use it to the device permissions.
Please see Sections 4.2.2.10 and 4.2.1 [0] (Link was provided in the
cover letter).

I'm currently propose the new feature, called SCI mediator to Xen-devel
community. Please see link [1] from cover letter for the details.
In this feature - Xen is the Trusted Agent, which uses scmi_devid
parameter to set the device permissions.
We think that this parameter will be useful for other possible SCMI
implementations, such as other hypervisor or SCMI backend server etc.

Best regards,
Oleksii.=
