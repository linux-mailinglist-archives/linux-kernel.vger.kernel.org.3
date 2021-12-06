Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B84F946A6AD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 21:16:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349468AbhLFUTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 15:19:38 -0500
Received: from mail-eopbgr70049.outbound.protection.outlook.com ([40.107.7.49]:6629
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1349378AbhLFUTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 15:19:37 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfaEVqCNTx+z3SpbTt5Jg6uG0WIg7l7c0bbscfvAbY+p+vvTSBv5hbBaLPNJnd9ZEj1s0EX9zesBTGTr2o629scpHjK4JFna86+vQFStXXrm5/wIwd17hZT/UVODD8IcAbUWEh8FBcVUpYDAsvtGuJY+bsANvyAxNwrMRGJeOI68SE2Wrg4ZL414M/EYGH8II9dKV4I4armek8KLbxvmsmeljUqZXDscjEQHGjPnN4d7gp5QsWxhnhLeZaaeRYS2N7igCHZ7qECdR0wTvaWUNq1NYQWj+SaQLNSd+r8amrjSzOpRYvAWsh3S+ehUyLLtwKEdHiDit7nphp8KYXMbOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3VmOopAxUjPGQQjz/+73AeQmeyp8XLYAMKBurjcl/No=;
 b=Uz674WvFQ94z0g8Qw1Weu7/wiRTrRWFvdJ7pxBF30BDtZruuVeBLibN2RW+pUy0tFlBWM5yThBWFjhjAQHT2rosmcNJsnLBbuGnAIkD/gVmaDfuHHQ3o9GGIpScb/rWqhejOkYer76hploUgS8f1Up2nU4LdJ31u3ihpqrmnNTq0a6u2LHziIWLSeN+drFTQ15kBYjJvapDK+X1PXEX57QrrfbB5iYCDVlvlHt+lWWXO56m/UobqdOjauh+4Q6Avwxexu+MqbXnDPTq26zBdAbCK1KWhgwEx0YD824T/7KZsooYW3xgjUbbFke9NUDqKk9V6fyRu7uhBq6E+x8a1dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3VmOopAxUjPGQQjz/+73AeQmeyp8XLYAMKBurjcl/No=;
 b=LX4H1Amb/TiLF+2ZZbheMHB4b8CWMhFF0tQ6TXbXRm/kdHZYiUFY5cLvw0q72iQbz5bm1jskq8fGSQu5mBXAdlgGhpFWYCyohyW8KXVhPSsidbjqO9Cu2njnZTdilpT3ah1y/JxtjId52803Qvha7ZPAY+IUIuDsFI6bfaWFAuw=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DB6PR1001MB1207.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:4:66::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 20:16:05 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276%4]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 20:16:05 +0000
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
Subject: RE: [PATCH v5 3/5] watchdog: da9062: reset board on watchdog timeout
Thread-Topic: [PATCH v5 3/5] watchdog: da9062: reset board on watchdog timeout
Thread-Index: AQHX6m0skg4aZzl2AEWanpI9yMCcYqwl503Q
Date:   Mon, 6 Dec 2021 20:16:05 +0000
Message-ID: <DB9PR10MB4652F0C952D173B857308F96806D9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20211206064732.280375-1-andrej.picej@norik.com>
 <20211206064732.280375-3-andrej.picej@norik.com>
In-Reply-To: <20211206064732.280375-3-andrej.picej@norik.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 155528b7-fd48-46e8-7d10-08d9b8f53b69
x-ms-traffictypediagnostic: DB6PR1001MB1207:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <DB6PR1001MB1207FA5061532DAD34BFAEE1A76D9@DB6PR1001MB1207.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lyRRCQOzYwDYZAM+R8z1y8h+p7Yvt30h/In+LdHYgbyENKVIO2sOgLysTDTtgR65539RVYXGXX0jKmW6o5jm48+UPRoqaNutTI/HkIwfjqGF9bRPGPYfn3l3mhw/+tW9NzqMGtm7/3HffFOGcel8CuL9leuKMPPG/qlrVLZDFWbq34wAmPvq+rvosw6L2xd6FlTEwbPNWoi2LE3Odpxw/nCdMc61oslE2mfXwJ7CYS8v3P2zfZD57QyyIegGW7fLg592e9BroeBhvVnxN1LFD7lkAoCs3JcyplAu36/njeSNDLNiJNyA/xfRO0JkQEoVFbRL3WcBEfgpKec6Gmjw9+V8RIXn2Dmfk50Gwpnbg+n5a4K9RD/77DWBh6uOld1MlggsVwIO8O1m7axDEMQOf+nG1SC8dhaXfBpCoiOnyXShSoJfRCCn40rgFRtklhZTDV/FoVK3Sar9OIeaOB8kb2SyUeCH45nIma3deMKRixMY4X9m6pMPXeh9jl4iInvYuvPhiIVKXBuZdb2u/4meacVETZDfqn2OWD3AONf4acY+pwTIcW/0E9YIJQcr5VKuHAb1mHBjdTRfTQPusSy7ZlBDY1xHaDI7RbA6p8MnYWyqZ/9oe6hSDNC9btQCesUefBAJz7nxBKfI9ItJlBUz4TfQzWLpp05cAjWkoXyiecUA3OjWPYNVxSfDij7UHKOWlbacrWm0Qe9fwW1sV7t2xg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(186003)(86362001)(122000001)(38070700005)(8936002)(64756008)(26005)(7416002)(76116006)(66946007)(8676002)(66476007)(66446008)(508600001)(38100700002)(5660300002)(66556008)(71200400001)(4744005)(52536014)(316002)(7696005)(6506007)(110136005)(54906003)(53546011)(4326008)(55016003)(33656002)(2906002)(55236004)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?RFONt3l8OJbvtN1XKd+6CCwPNdTpZUMISuH6Upypbrxf0aR6o/ZzhYiJuC7f?=
 =?us-ascii?Q?epd5KpZFNsiPuRKw799WGrsrIoqRuog/vn6k7/HKYzmEPuswIBhUHvvWCCnR?=
 =?us-ascii?Q?WPXgG42Q3bIQq1Da5jhr+TPNE2BLyz4BEs5yi+R0qSUFyYssBnh961G2N8RB?=
 =?us-ascii?Q?YwKkHZCC49xyqKmhwDd5DsNoTEodsgDK+94kffolF+5Ttx+3VUeoZP7bwZnh?=
 =?us-ascii?Q?L+MzsSoA6UnygNhS3pwEixqfWDmgx/lbiaMOoSTBwRVrkDwdI3z7io6H9j6Q?=
 =?us-ascii?Q?57S1H2ZwLCVnAdI8+eItCrQqHEbsFZTF2yv4rYyWZJ9sjZ3dhjNQrj4X03AA?=
 =?us-ascii?Q?fjNLCK7G21FtJxqTZOR1tNaacnoFVJRfDf+LsHUHujLvsIhJNw854p5NfEnX?=
 =?us-ascii?Q?e/mcKbHl1QWYn+HkziNZLmlUhj9RwDExg12u9ENPOOWxkIAO30Cxi3P7XQ8v?=
 =?us-ascii?Q?0DeJNhzl8ABvq6cxji9K0eKlKKFO8eMfKWoHXYhNAwyeR2Vs3VrOIcAQ2j61?=
 =?us-ascii?Q?UGex1nvzeLAZwedgo3LY3resMVOBKEjwdEEE9p6JXqu19dl6x9KmrOypGc6d?=
 =?us-ascii?Q?lJkBZqD/MJtVeswe876pXwuSoPxSoJxfJePUYBleDEuoqLz9Tir7EVM2m6O3?=
 =?us-ascii?Q?L8H0/6tFd8EjHjfSvOVbJk2OmiP2fCzcyw0ox3EVzUZF/V4ZnbC+S3gFn7v1?=
 =?us-ascii?Q?Bq8pFxx5IX6SujpFyeyn7xtB7QsqgM8+ys6sucPYOrDizQCxcOJ9U9n3uxdP?=
 =?us-ascii?Q?qfU1tjgcDHcCfBFpO2ULTPnwjBxlbcYsctB9oIX0Mz8aL69A9LVWLAVzCJMH?=
 =?us-ascii?Q?RZDbWBgcd8efYDu4CZUVzhYSSfZBit0cN2A094KEb8MXpTyNhQ0tvcDxU9Pz?=
 =?us-ascii?Q?DWfEUQwhINDtVpJ6towjAKlo+eIoGz7OXOUtHYkS2IfH6HBmEs4WOnTsKBN4?=
 =?us-ascii?Q?yxso+JrlnegC6FyXTfb9fr6X/5V5/gj6Tv7ud6pMtQxeh1U+0vMtN6UvBwKQ?=
 =?us-ascii?Q?u64Cg58uGMF+wOfwd9iHJOKHHK/R4Cara3JFB69OS0G/py+m8Xu61RXgPZm5?=
 =?us-ascii?Q?o/s6CpnM4GBfQmAt5YlzMkusYBI3Vtr8WMXRH6qwGrAcT3ICQYOJRmJ2qHCE?=
 =?us-ascii?Q?Prk5pepmY/PFO4Jll+C8A2OwcOiKY25raXb3/vUcblOfPEbTkUpbrGspnz7M?=
 =?us-ascii?Q?pG5OZReuWCev3vaUIDKY8JIPW/5+uGFIkpzKwA0zBsG8d/ZLsx7iIhVPrvha?=
 =?us-ascii?Q?hzTUcYB1s2NxQMVEVU6abgModYwKy1vWRbl++woK72j0Z9n7axL2kKybjvZ+?=
 =?us-ascii?Q?Q0aiqVw++4rOzPc+bSWpUrIjhEHXU5kFWG/YAiDPmJX7x5qC2aIoSkrLl27D?=
 =?us-ascii?Q?sfmQ0zt+ra7yML7i3bTZtm0BxUwo6FpQCbu7b5YsG1Mlie0H9fr3O+9+u0zv?=
 =?us-ascii?Q?lIFw4rkdMSUxZxRaFbHrz95oa0mB2zoKkQn3yZA1ZKlC3RpM1z6C1h77arsg?=
 =?us-ascii?Q?wkglr5zOOQ3FOFAzN+g95QzFzDDzxC10BbyxQsBXQMMsSDXsRAguyAcKB+a2?=
 =?us-ascii?Q?OUsenEAcd/s2vTrofa+e9gmpDNC0c/aEerBlwK+ZV0DKZKAc4Bika3bDWN7g?=
 =?us-ascii?Q?IF7Tjoo2Zd7HdWTw3JAhk5oHVAz7ldRdENV/lcMT/inznUUr2o0MecsoZGhv?=
 =?us-ascii?Q?YAKBFA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 155528b7-fd48-46e8-7d10-08d9b8f53b69
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 20:16:05.1907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RITBtr6oxEWxmzvpfAXMykzs5o4qNfAJ0NwnEQJRNPCcnG75nscNOO6J/1ID7nilOaxacxby9PUAnkkhJorx4/4Uu1xchUGeDrJZ5DI1UL0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR1001MB1207
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06 December 2021 06:48, Andrej Picej wrote:

> Implement a method to change watchdog timeout configuration based on DT
> binding ("dlg,wdt-sd"). There is a possibility to change the behaviour
> of watchdog reset. Setting WATCHDOG_SD bit enables SHUTDOWN mode, and
> clearing it enables POWERDOWN mode on watchdog timeout.
>=20
> If no DT binding is specified the WATCHDOG_SD bit stays in default
> configuration, not breaking behaviour of devices which might depend on
> default fuse configuration.
>=20
> Note: This patch requires that the config register CONFIG_I is
> configured as writable in the da9061/2 multi function device.
>=20
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> ---

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
