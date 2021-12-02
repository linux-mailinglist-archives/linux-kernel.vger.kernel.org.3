Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65E84466362
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 13:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346668AbhLBMVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 07:21:43 -0500
Received: from mail-eopbgr80050.outbound.protection.outlook.com ([40.107.8.50]:61326
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229463AbhLBMVj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 07:21:39 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kUxqLamx41ekTiZAwvylcplNPcEEF8vmrKvcXQ+/59pP4vmbjvo4bK5oBJMex8NT898yXPZYYdOeQHlUxd2s5hCgl1Bofhg0pBshHfIXo9fTrEnSr8M//vgkE5SUVXdMpXs9doopmJEq3d9nPqCK1Kr3t6rX7/MmoTMaQ9RbMS39XCKUaWzSYeL3PkTZry5igyaYttYUDUcSxQaUE4q2oxJo/McvjVuzoYFcBYjJosqMpLXk47sdKXuGQ1Gah+ysXi/JseZw4OXaJLtRWwEn04dTpJbtxqqNCuglo27kHAJhIZoaFFQaqO0uvJy3brnIJxQYBp01QVRn/szSYSyv6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ng03S2EugcPRweuVsudzqHxjadSwiMs23TZa6tuDrbw=;
 b=JJ4SvX+1ZFD0xhF0oeu0hZrEt2Qlk+nUBjQpJgafOv7uFl6qxXMvRzXHBefNq8XTomoo5NOuW/moVFO8JL3VubIjQ0uPuWoewlZi8LOuA4K7x9tz5xlBVvm409fAcfAqART3Xoa072Fltq0CKZ6xVSae2ZT1YKBjQMpZXrJa8lUT9HCAKoMmKNoVIqRHYP0UJXU+zALs5Ehx+Pa85zG44wElEA7CEVHNMJdTzKTaiQ2yX83TisdVsEGZjT9xNSktSkBUgu/dMT/fBsrFaXOPvzR/Jq99wIh1HK6oE2/Ylwelaugv8I3QygIQqY9R2EfndP6ny1svnkJu9alspcvBzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ng03S2EugcPRweuVsudzqHxjadSwiMs23TZa6tuDrbw=;
 b=xRbO9TuT4SrwR9sTEd8OI9viQHLA+M570t6TCBGxu7LNWIUzflDtcBNUgRqvir0I1GvCcgsLzy+pH9v0sWYJOpb/1vXrgf5F8IW4LZw28E1J+M1THYTV436x9oA7DY1tKP2T32arv8kbnUoGNeGpWmXX76ZabX5t6AiquDLx3Fk=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by DBAPR10MB4218.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Thu, 2 Dec
 2021 12:18:14 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::852d:c54f:8414:3276%3]) with mapi id 15.20.4734.027; Thu, 2 Dec 2021
 12:18:14 +0000
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
        <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 2/4] watchdog: da9062: reset board on watchdog timeout
Thread-Topic: [PATCH v4 2/4] watchdog: da9062: reset board on watchdog timeout
Thread-Index: AQHX51+RFOvTE/m7OEWtqDLlukPIEawfHbzQ
Date:   Thu, 2 Dec 2021 12:18:14 +0000
Message-ID: <DB9PR10MB4652A6A2F9A2CB48920F3F5F80699@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20211202093230.3951996-1-andrej.picej@norik.com>
 <20211202093230.3951996-2-andrej.picej@norik.com>
In-Reply-To: <20211202093230.3951996-2-andrej.picej@norik.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 88b6fbba-6eff-401d-8057-08d9b58dd0b5
x-ms-traffictypediagnostic: DBAPR10MB4218:
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <DBAPR10MB4218A23E39996364493C4A10A7699@DBAPR10MB4218.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: l4jYvMan9JeQmJa7pADpjeRIsagKTZFpNzOV6LA/SqnVgmaAAgxjVbsCpmOwlEGX6knu94c6FkEZGh0tqO4DFGAX6KPw6o81xRCaDvzmuFiA+2YSK8ZgJP1T9HPRTiNAVyJnpzAR6fHGAcOt54ejeLPvH8aUR9d65JVMi40v6+IC2AXYGn5YridGW9gWJu7UBXuXmAr41nBZNduEjnW454wYV2pApYZ0AEIQihvom6S2lXf1MKhngaxCtozIDaFhDbQU0YlWk7VN/xoVoM8WbT2jRvB9g/02O9QRv5mtX7Gsn+8/HjdZ7Z9DANi33p63MCNq9k350G1+5aWAHzJ/2TZhKJOgzNsrreDHC9u/MfCw3tK2kWUVLiVnV1sfVnKXUL1bSbhd9vVVT7gSDBMtZ4WGXB8WNfxOOpuxtMXAVNRbnOXQyGibWXCqRRxO1vD80I+HZNrldKbAL4RRas7aR6yjIqZ3O3uvLjdmixDcia0Y/mp2YtUUZ+K5Bv0QM6QWj+HIdneZSKkjr2sEEm4wo5+Wsy5hmGNX3YP1Rqf7j3oDAjBI9PMnjWvhrvvpZsOJ+Xrjk9b2MoN+ZHxljbBZx+8vcQtDYL8worWDd3b1KLHRI5H3A6/etjwojlptiywSYc2Ew56FUxagQ/e0/UaLg6J05XCBtKvX4d4yW0PjPzm/Go2K1opkNT9+9cFXTDaVUD33wCfOAwNa8LDSfwj1Ag==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(86362001)(5660300002)(4744005)(2906002)(38070700005)(508600001)(9686003)(55016003)(53546011)(122000001)(52536014)(64756008)(66446008)(66476007)(66556008)(66946007)(316002)(8936002)(8676002)(186003)(110136005)(76116006)(26005)(54906003)(71200400001)(38100700002)(6506007)(33656002)(7416002)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?gcYoxNaxT5m59b/x+UEoVOz+X6EMjGiqVP4VEWQh5S8/PWIgyIvHdFdCXSg+?=
 =?us-ascii?Q?lCo1/gtgX9y6T69Z+okKmZJle11cCWb+LBs31uC1E6uJayP7vD+dvo8YEKrc?=
 =?us-ascii?Q?JE4jraQ3mXijlL+m9/XYxTzBlpV7FOoElSkSH18lIsR8FybLQ8YrhD6NhAbb?=
 =?us-ascii?Q?yX1G2ZL7I9WYr/baFmhTGE9Z4ZTA8iAOOTpPEVe3ETL7m6JM9fIOe14tLqwD?=
 =?us-ascii?Q?G2Enf8fvFHxTc+8O//656GxJZsy21CInO9TeezlZym5Pk062y9SKHzrZebHN?=
 =?us-ascii?Q?Y4OHTywhcpiGd/VjARlnZphHjD6rDmdt3fjkFfHMlUzX0JH+riXShW4fOEAH?=
 =?us-ascii?Q?KZlF+ENuGi/89qwMEFbw1SU5Vy6hgpO0Z9uQNCavKy3j6sOAVtkHSjBnBCFZ?=
 =?us-ascii?Q?44cd0vgb8CxxCbhQicDQJXIkT0RGf3Zw+Cf71jRT3ANhGs+DQ/GmPB0D9/uj?=
 =?us-ascii?Q?yIMorM/yuz65AiZvVd2Wq7o8i71QXdNuTdte4Uy0TVuBZPqD7Y6XVsq6bbXE?=
 =?us-ascii?Q?yENvMJrjAtpIypzhv0R2QzfhMkrafKwcqXIfdOYEJocr9tdC7OHU7442AGl6?=
 =?us-ascii?Q?Rxr/3n4L+ctgW6TW3U922GFcwUMAGNEAYvw0bvjhyt7HIGqWEw0rRydbG9Jr?=
 =?us-ascii?Q?cnRus966CdgjoGM5l8jzhkAJp3CJCLMSYDV1IhqCdlgO/yV/9IoKsYWgsKBa?=
 =?us-ascii?Q?q8EFfQksEMefXOPtl5CatW5fCUyzEymFukkJuTBmHiUzpgGePXEc+JNcsWYu?=
 =?us-ascii?Q?vMDXKLmR7htIo+mLgVm39D99vo4VkrL8FTYSVW+/RmFNjHpQuAa7edrqM+o4?=
 =?us-ascii?Q?CYVE+fp0nY6RCs6OGf390IfQO6j/ZAG/mWOl52tGYulmifiU4ZG9KcybdoVC?=
 =?us-ascii?Q?wA3Cwxi5iPHmrKl7/Al86tc6BSekJG+uJvAAVzQso1FCCNPWvKRowtHBp04d?=
 =?us-ascii?Q?/7p6Qs0snyUcQExYAdJaNpWvy88cL36Mbqz9utR810q5wAf661naHsuPwiRe?=
 =?us-ascii?Q?uKaW45BR01O3Oob9zfqApcjh4KWRf/wyZOPjWdffSHtvJ5Yy2eIOQCCJJ6Ow?=
 =?us-ascii?Q?fbgxPRIpXThMz6QdriCtwF8w2l6MWGPYHaav3zXiLTKczRdkSQmUukmZlCGM?=
 =?us-ascii?Q?x+zbTTsp9QkW6NiThIlWf9Yg/Sq//AskBfcGXSuAHjHmGQeZbHZpbU608KkC?=
 =?us-ascii?Q?DrtSlkuvfqIqRrKYJzMfQD3RWzI3Dwwib9cum32bmkggDrrZDmdh4j3E/Z6V?=
 =?us-ascii?Q?E6EJJYTm33EUrJo66gU6+lBgOWflEvamIgS9MUuSKcT3IsiASgW/oKht8Z4u?=
 =?us-ascii?Q?qcGhr+iUvbPXAEFBmaxzgFO5WDW8G3qxe+CXe/FDR6m/dDFKuddThm7Xf1St?=
 =?us-ascii?Q?Rb062m+jX/bJnZByJqYi0PARQZ05Cl+aN9Qs3fcc6SgzzZCPyWLcCPw7Uolw?=
 =?us-ascii?Q?+UQLlbbbFuKuDxnITo9RZQY2yCO47uza6rsevihhJTFg8UgaItQfTSWun+hZ?=
 =?us-ascii?Q?8MJ/TGEUDrP2AltY9iZYJepH805DGFfDs6KvgsOxzYlfkHgiRrpD37rCSf+O?=
 =?us-ascii?Q?hxu1NdhCYhwT36A8B+aWxux5ywZU0dYCZCVBvKoPQqxskF6Myp1lB/+66ym2?=
 =?us-ascii?Q?iP/H1qSPrkcx6GVE8dQAmIsmAeeEDGCtKV5JWuXji1E2armJXJDnQGFapyVN?=
 =?us-ascii?Q?IUS4ow=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 88b6fbba-6eff-401d-8057-08d9b58dd0b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 12:18:14.4943
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aqREHutJYwcHeJlyfaoyYFYQmQaxf5jgr7z2fL5+uLtJTnHnAtNawh4LI2rrsH1eQil/S2f3PbX9dPQ1mOAphm8nCYIyOpOd2zEQAGGJpoU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4218
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02 December 2021 09:32, Andrej Picej wrote:

> Implement a method to change watchdog timeout configuration based on DT
> binding ("dlg,wdt-sd"). There is a possibility to change the bahaviour

behaviour?

> of watchdog reset. Setting WATCHDOG_SD bit enables SHUTDOWN mode, and
> clearing it enables POWERDOWN mode on watchdog timeout.
>=20
> If no DT binding is specified the WATCHDOG_SD bit stays in default
> configuration, not breaking behaviour of devices which might depend on
> default fuse configuration.
>=20
> Note: This patch requires that the config register CONFIG_I is
> configured as writable in the da9062 multi function device.
>=20
> Signed-off-by: Andrej Picej <andrej.picej@norik.com>
> ---

Spelling aside:

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
