Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E142846A6B3
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 21:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349578AbhLFUUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 15:20:25 -0500
Received: from mail-db8eur05on2053.outbound.protection.outlook.com ([40.107.20.53]:13056
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349544AbhLFUUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 15:20:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEGLQTLwIsTe915fu7qdtatcMwlm9bdTAgc7QKOM8QETsw4qr9w1KaKBXQIX5hYd1Qd2VSx1WvzAHY/SGshN4pFgiiJYW8FCkEmGwl9RUZfArc/861EuzCumh7ApApzzvKn0woWxuRk2xj/v6hzM+MPCwu+JH8snHuWG51z8tpwo+GB24Q+E9lobg1eWtGEKjiVeN4A2OMwvK5J6C2wtm//MZmC1eOMVwvo0dU2uIzOVPz2Y55Rm5iH7vgFDusEYfdkJAoQACP3ZmL2t03W7f/LR4MbuLcj1R3c9WyDYL2NAwBvpCDB4Di29r4xUKnCajxxWYjCOanP15gSarTUOiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z7HWfbNpgjiL5bNEoAN3yMIfgYeQ5fLAdF/Xh6GXnyM=;
 b=D/9X+cesc7ORgb1j/U6lDCuGxy/5vNkY1wwMHn/xrqetSBoIl60e26ljlzxVNNcRNsJ19aqPUH6ciXzubzsKpUqd5DMeFr9pz3AreqlvInJUCRUOs6ZFyUiQ3iyX3WU3EfqbHVA5ad53ohbbzsTSPJ8nqcuAzmlsiMMxI5iafOoPOKKw06VXjZ0beWiE/p/URGt5yCwqTFAFItPx13qt1aVK5zZ+jvy+ZRVUUVMRLrSKmPBBcKqbtwCtf3MkNMIgGDDPpbua+yCrFXrW2/vm4oI3PO0/vQQ0O4TyKz65XUmTX5krkI2B+qinEnbqk9CKKI4hu0vwLtFskwAs0xx84g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z7HWfbNpgjiL5bNEoAN3yMIfgYeQ5fLAdF/Xh6GXnyM=;
 b=q3gmLd+F9ABReRf5BQFcfou9AyO8OFUxp7YanInv+DAPELF615XAiE2sJylnMoxWjU124b9zF/ny3s+q2NLKvPNz0Atn7juyuOAaGBeN22O6YF/Rj7YnEhTieYVQMStBQGbWaC4J44oJVM+ekKB7HGW6zRtS9A6PESBJblBCy5A=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB8PR10MB2988.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:ee::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.19; Mon, 6 Dec
 2021 20:16:51 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276%4]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 20:16:51 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Andrej Picej <andrej.picej@norik.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
CC:     "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-imx@nxp.com" <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "cniedermaier@dh-electronics.com" <cniedermaier@dh-electronics.com>
Subject: RE: [PATCH v5 4/5] dt-bindings: watchdog: da9062: add watchdog
 timeout mode
Thread-Topic: [PATCH v5 4/5] dt-bindings: watchdog: da9062: add watchdog
 timeout mode
Thread-Index: AQHX6m0sJNh5NEXMwES0MGj1zYa//awl51tA
Date:   Mon, 6 Dec 2021 20:16:51 +0000
Message-ID: <DB9PR10MB4652E77469D4E34933E85009806D9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20211206064732.280375-1-andrej.picej@norik.com>
 <20211206064732.280375-4-andrej.picej@norik.com>
In-Reply-To: <20211206064732.280375-4-andrej.picej@norik.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 074ad6f7-39de-4d33-d5de-08d9b8f556bc
x-ms-traffictypediagnostic: DB8PR10MB2988:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <DB8PR10MB2988CD756BBFE4820695ED45A76D9@DB8PR10MB2988.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:2657;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cJCWKcLjrU1aCWBt5Lq3/XL4IjRLxGYuksKytLIdiFVaU0O/5ZFslqKMVOwDqddxqL5Px4+q5mKbfqXEY0k2xKABJuE0nK9EZ07PfgwMBHzbK6z/yz23cT1t+ILXT3JS15e0jO+T6ZVwzmaTULUGaxE1xAPhkzLfbHnE/+Ij1v8YwG1AEzIOJZN15SFrM/a7TIoWxqwIa2/Yzicf0kzoGEZUXi2/ld7lCfUv+du0ozsGFxxorYaYZgViLNQWXqVomcFmpAN36Xqdx6OqBxHVY0tjTuMg0ugbBOjzmp8pF34KlwmLgN694XAa2Ucyp/J+g1BbxVE634aiK0o3WLWSstMtESCR1TiFJziB8sCON/KhcDS9lV1DTZ191z/KBNPljF9H49yNHRqp8bkzaGdW8krxw/KB03CAW/sCIshymNKUks1DOlEZsNjUDZhWRxRQBDCs2ZBIv4Nk4ZyoaS3H4zRVMpl+BG1o3rMS6PXylVk6okoCBZuYD3gS7yOT1u6/0IV2lMOTB9kGetFwUREq7MSomfEAUdJmKHAJOgjnWgum2xF6ati1nV89GYw4YjLEnkQ6S2wyyNoVOIAvFnhwQ5RVN/B9CCqhsMsL+/5TTLTWF4QYC02eRKolWwwbXxHiajGSTy3z+ZBmLisi6g1aW8J7kRzTPzmTxKE+jpvm83nusGkUNmpFuuCr96YWwT/lphcTWEO7HY8ol3yBL13amw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(52536014)(5660300002)(508600001)(66446008)(8676002)(53546011)(6506007)(316002)(8936002)(76116006)(38100700002)(186003)(122000001)(66556008)(55236004)(64756008)(110136005)(4744005)(66476007)(26005)(54906003)(2906002)(55016003)(71200400001)(86362001)(7696005)(38070700005)(66946007)(9686003)(4326008)(33656002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?MVY91VuTNxnAbA8cMLbX+cLATRudFN0nFmBiQG+rPXPwPY8iDe9oCw375UUs?=
 =?us-ascii?Q?XyhwVBUPx2PKorq8XnB6sFjiBiyFBkfIyldQ4SeYcHNQfRtQR0En07BsDmvP?=
 =?us-ascii?Q?8rEgAS3n1gg/svz8JASRjRczsKHHQEL9m+7zFSVRguqSspYuYfYKXff1a9zd?=
 =?us-ascii?Q?uRvx9AK93dDhzhT3xdJYFuL9C/xhCLsgOBEznlnv0YRAQcdb/7ZtywKhgpQt?=
 =?us-ascii?Q?+DzJmL9q9RcZTdocSVcXwomWAmQc8FImLnXp96p7EhA9wUd8/UxCLvKPdokU?=
 =?us-ascii?Q?BWEkBbzVhV/kj6Iik3wDkYEe4KMIMpunsK6kWHNQ4uBiFPolDh69pUizvMP2?=
 =?us-ascii?Q?douYogY4KYrw8zu0Cj196v4hQ3pRjL7APdDSP+sYVA8rxwDuOF49l+Btclx+?=
 =?us-ascii?Q?gjZjrlri0jIycn/fGBXtE2jP+pbQTrmDTHHE+LjVmxTI4a57ZeNIikaocADp?=
 =?us-ascii?Q?l5d9fy5qI97rpW4u/U05UXyec+h9h8Mfk04VRMGeT9MDHBz3X7e7DqWrsyyK?=
 =?us-ascii?Q?79+l83nRomN74a78MtwVqdiotIBZiDOoIYQpOZA/UFsOWL5jeXMflh6ueay5?=
 =?us-ascii?Q?alRYTWOqyly9c8K7xYa9yme942aQWBOHNCqwF9epxDAKgtTcYFsmmSB+cRef?=
 =?us-ascii?Q?YEvQgVXQ/hhUBaA+5kP9hiw9mH7x/03ZzuhBrGizz8AigvzP/sAOqX6s874R?=
 =?us-ascii?Q?FDDjDO+hvobQ9BIskHJM7pAPVHOYwOl0N/lDUHuu0lPjBtFFoPZ2KKOFlZfG?=
 =?us-ascii?Q?lMSlgbYStQuAr1T42om5vA5UmDtVPE0CsIppdzaMNtAWStp+lc+VUcwOzZId?=
 =?us-ascii?Q?X3oL4U13RBW6FXZpRs1snq01RXVD9L9z52Al4B2iX06Rf+b5Jm/48adDGO9b?=
 =?us-ascii?Q?z9hyzPEyWedR5rnfOtQTS/PKYqCv9OY8cylgqJg7rBpXegVYPNwj7xpqSwjm?=
 =?us-ascii?Q?ryOk5HG5xdn+o+r1z7lCNOvOSSpomosMgoujpDD6B3P+K7iYngd50tKf+0AU?=
 =?us-ascii?Q?Dymog0zQlqmEekqanU3p2m67eRwFQWdhCpfmohbyXtDzoi8Eq3JPMVOgJ+P5?=
 =?us-ascii?Q?QRuIBEL3A6npkBECY+qDo1lDL6Z1d5/V0KbBSxA3reDSESnKGFbb1V0EOvP3?=
 =?us-ascii?Q?BN/m9QrKkiBGCd9/MNB17h8VAHMoniS+U3j1Vx+syyh4zfh4QbbIHpQbKNjs?=
 =?us-ascii?Q?PElJ0bh6t8yBC4tTRcGH/2yNFMrg3GN4JMAyp2SgFybxpCRacOpKZ/1JBxRQ?=
 =?us-ascii?Q?dD8KpyoxpISlO8spB8YGAjBI4wHyJ0XsKHCJvDXGUB0cwIXvNe0EQkPLafjy?=
 =?us-ascii?Q?p7tNLPH43e4FOFl5sudnlL+RKbsYywXLFWg8Cocmj3r/QnwkfC0thltLbcQV?=
 =?us-ascii?Q?HwScfNJbg3H1Ev28ZZOsZMQdySLv6t8zZ4EoqvHLCtUU20+Xpf+drdFgAuHy?=
 =?us-ascii?Q?NvThH+HaKq2+5mvNB6sz33r7L8vakDIPMG5ItIHqTU3Ucx265RYchlGNUinG?=
 =?us-ascii?Q?Ls11C65X5jDinomHWVc94XOfNDKkQmZJE7927SUsPlWCKWIcZqKENfH65Q7G?=
 =?us-ascii?Q?22tUYQcc/uNI8AqK+Ilc4+JWgUzMuRKRIhdxocx9SmAMZ5UnhH3cQguOoz3n?=
 =?us-ascii?Q?yXlqim7D8j0OohyJgUBjU7BxmL75nswAEiSSsx8I3gSvpAoMgl0q/w/5jD6+?=
 =?us-ascii?Q?srx5Pw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 074ad6f7-39de-4d33-d5de-08d9b8f556bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 20:16:51.0593
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O887iiMr0x/t+wP/THquHX+IhG9+NrCuN0tcSrXaivJB67TUkXf/iQGFZ8q3avr3k0kRYqW4gU+JgAYEleJ0cxD/kf9IDbrt7UWd7d9w+N0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR10MB2988
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06 December 2021 06:48, Andrej Picej wrote:

> Document the watchdog timeout mode property. If this property is used
> the user can select what happens on watchdog timeout. Set this property
> to 1 to enable SHUTDOWN (the device resets), set it to 0 and the device
> will go to POWERDOWN on watchdog timeout.
>=20
> If this property is not set, don't touch the WATCHDOG_SD bit and leave
> the configuration to OTP. This way backward compatibility is not broken.
>=20
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> ---

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
