Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2854E46C867
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 00:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238469AbhLGX5G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 18:57:06 -0500
Received: from mail-os0jpn01on2099.outbound.protection.outlook.com ([40.107.113.99]:56320
        "EHLO JPN01-OS0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231416AbhLGX5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 18:57:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hPHRmObrwVaYmMndXX5Hvph8R4KzwVqImJryP1z+Vw+rhVfcj80Jv+vy2dId0GNzDTLO0JCCiLMbj2QrPrSD4yFRDUoNyYZPjNVsyIq6acscJkfqifdqzGbEwhS+Hot50pjiGgYorYIP4N+OJNXaoKbHHFSOKl2cJDwac+gufQirZU14j8KSkusGI4GliM3IT42sk46t8V8AMq+hmTo3XVlmKK5XL87sHWf3CTKLCg0KwHI1YEZdTTbwZHhLAteJnCdtvf7MjzVQSt5MHrXxElzDwHvoU/OrXXicu/qY8F2k7najn4LXNUvbNsJj+jTO6zKCXVKWsuRxpJdgP2CEww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpIk5Uy4mzzLnosfVJiBSLEKQY50VX8ftMPQp7GO5Ug=;
 b=SOUwpLzPrrIq6gUKDScCG3x5fgj7ciLnJGw/1jN3lxU3465XGIM4ITMcRBENyZhvcqrtiez6ymyuJ6aERD/oNHKNPj2xo1piq2qaPT779djoqlPKGLkNOJW5k2JgO71+jLSWPBvZc/419c36rn6duyZ8ZM/HZ45rxItF+OPo1qxqtAaAvNcX/5ySqnhDzQrdjKm++A6O9HRICTpA6DJJupRYBn2BYBgDLU9lJeV7F94pxY0KX2hlcnOEg4+qol4a0xOfH55SNrCFl4h4VJVEdf07nqphPdYmtkFLhDeOOgA1B8rKNif+0gZNnAifBjLtcOQOAksj8UY1FD+iJsxcEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpIk5Uy4mzzLnosfVJiBSLEKQY50VX8ftMPQp7GO5Ug=;
 b=IzI60mhUw1+XAGXQmnR+A3aia12kHMypq8ZHPSaO84qSq3Nrp3kwPuRZqnXha6W1jIQqyIFYYDVVLdskEVMS5zg5x9HN8gK+DW1FSn1jJDotR0r4xosuP6j7Gqp+o/2s6Zabb4fJjc/a7i+vj279Zcy7ostgel5vWokszSF0aaM=
Received: from TYCPR01MB5581.jpnprd01.prod.outlook.com (2603:1096:400:a::10)
 by TYCPR01MB5581.jpnprd01.prod.outlook.com (2603:1096:400:a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Tue, 7 Dec
 2021 23:53:31 +0000
Received: from TYCPR01MB5581.jpnprd01.prod.outlook.com
 ([fe80::3d74:9c2e:e85a:df82]) by TYCPR01MB5581.jpnprd01.prod.outlook.com
 ([fe80::3d74:9c2e:e85a:df82%5]) with mapi id 15.20.4755.023; Tue, 7 Dec 2021
 23:53:31 +0000
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     Mark Brown <broonie@kernel.org>,
        Ameer Hamza <amhamza.mgc@gmail.com>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: test-component: fix null pointer dereference.
Thread-Topic: [PATCH] ASoC: test-component: fix null pointer dereference.
Thread-Index: AQHX6hiZRK5cTb56bk2m5NVbTZyjx6wkenEwgAC48ICAAOYnsIAAl28AgABNGACAALi/0A==
Date:   Tue, 7 Dec 2021 23:53:31 +0000
Message-ID: <TYCPR01MB558131047A6ABA9AA535AAC8D46E9@TYCPR01MB5581.jpnprd01.prod.outlook.com>
References: <20211205204200.7852-1-amhamza.mgc@gmail.com>
 <TYCPR01MB55813B26BB2B3BB6D1E072F2D46C9@TYCPR01MB5581.jpnprd01.prod.outlook.com>
 <20211206092937.GA5609@hamza-OptiPlex-7040>
 <TYCPR01MB5581998AD64AE249C7D86C26D46D9@TYCPR01MB5581.jpnprd01.prod.outlook.com>
 <20211207081522.GA9690@hamza-OptiPlex-7040> <Ya9YxoUqkATCOASh@sirena.org.uk>
In-Reply-To: <Ya9YxoUqkATCOASh@sirena.org.uk>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d5db3b89-5282-4279-14af-08d9b9dcc637
x-ms-traffictypediagnostic: TYCPR01MB5581:EE_
x-microsoft-antispam-prvs: <TYCPR01MB5581BC4214DED7AB6325DA93D46E9@TYCPR01MB5581.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BMsHCpkD6PYt5uKrGSJygcWZ4qyTHgdnyR/rNMn3nz077Dz8Mj5CbJlpOXuyyodYkT5CMdeaRRW5V1LUBfHKh8sAiC5iOl1tLOku3KES1qquE9WB39djDQfe2q16Gvk6EfhRHcm2G6ESMfMJ+ZpVg89eKm62Xqy7XTx3Uh90bSN9yorufiEiGLkHGR9kwDuJhA+O4KgeQZKoYJOrPzunkbnemfbQoT9S87vafU17eKpwmBGQ0v+vIfUaUBwuTybyjCqSrVs7wQ6nfAMCYL7mW+WDaJW2dUP9g89nGC1ZYLvNPab6axydTuuha9uTivhisi+oIxUIhh+J/pBHhfNNTZ+ZRbuuNPSXdA7jXtBBscbPLvlLNtHx8+goMEAHZblcWnBDVRTfsyP1eL54M3R56rYIEQ/eFyEUpjYkFD0/mSSFRApz0B04txq0YAQGGb6n63ZtkWveJfrP4p/zmxB/b8aACA9L4BCyEOCWbCUIAyN+v0MXUqrVK+hgrDitgLIocdajPwAlSNQfQaIuzrN2dudwhn/+CVuHEDtNNL9vgvBtmdBxPPem51CDxLp0BmT0BKHM5pUxZ1QbKZ9KHnWzE6hSw3P6V1GnUNX3+hupu3lFU/+Z82fi7UH6X/ClpIxXZsUnOKoN1TFYTPfHxmeV+0HSTquzhO7xM5vBHGjyfpjeTQDgylVwFzf5EvDsTkWMVvKdYbTrkUd8gFMq98iB3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5581.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(8676002)(508600001)(9686003)(8936002)(38100700002)(54906003)(110136005)(83380400001)(122000001)(316002)(76116006)(6506007)(2906002)(186003)(66556008)(4744005)(66476007)(66446008)(66946007)(64756008)(26005)(55016003)(52536014)(33656002)(86362001)(7696005)(4326008)(5660300002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?lf3RngFNAYc3Cbvfd6WtMX8x+F/0AGQaHtANAg6Hy8WDOhOPob6PjeMHiDWT?=
 =?us-ascii?Q?V3rkSQ4KYKllhsuKWdE/0MauVSQfesn71MbOy55PcPZmzahsqJ1ba7F+gnhH?=
 =?us-ascii?Q?NCvstbj82revYUUdYlOp+7SPpdPYPsj0Zsf7TVTrHU0+kj64aY8dyz6lfM8H?=
 =?us-ascii?Q?bH1nSYWTW0sJ2K1i/yKyH5aqSArZlH2mr3Jo05lzgW8B8W2Uy2htk37g3eZT?=
 =?us-ascii?Q?evwmHk2xJizMSX1RUu5ZM/mrLl1n37dE83inaS4E1l7PZ8mP4Re34x9dtHK/?=
 =?us-ascii?Q?0eV9NGZwVg2MvpHiv/DFK7WLKsAeKCcXBtSS5sW7FQkd7tM9hI6uaIcgYedi?=
 =?us-ascii?Q?uvLSIZaTqBUBB1cPnTa7SDRouEyiIKKpbpHnkhVerKMzY4fsiEfXwuEn7FsY?=
 =?us-ascii?Q?HVtSRaRUatYRY3QNoqjDBCQSWSilouCWQlUDZtZOme1hs2bD0RSUtBmZhN2o?=
 =?us-ascii?Q?hN79zyhqem0gIkjYVph117C5GVLK4+VkFHMlICkapzoqjJEXvQM2PRgfrb2C?=
 =?us-ascii?Q?u7/3QHdBmID2b52Jnzlsgkqma1Gk9oe4Ivq/h7rzv4fFRdSAMd0ib1duE/ap?=
 =?us-ascii?Q?W7gqrf8C2I/dpRTwo74hmav0o5rsiqn48lwA9Atk0RaPmgVecj4XXdqFyYRg?=
 =?us-ascii?Q?/kmyB9MhJ/hY/lpChR/vfOqx5oH2/T7hnN0iikQgxDfABqjdsI/y0nKWm1g7?=
 =?us-ascii?Q?GlZeAntsY4zXBP3bD1wCqwPi+g+WMhpd6VnMd03nbczQfDs7nGa2Gtma2dXy?=
 =?us-ascii?Q?iQ71E8ohn0NgODHYc/CHgxUwXomc74jNRXKpl1jnhR3FGXyTyEdQ8wceopb2?=
 =?us-ascii?Q?Po41qRYViip93oD58jdSyKqsTjuVjMTSMg2fP1hDuqkt9cZLclybRYMjtr12?=
 =?us-ascii?Q?WdLojBfRLW9/LGeN+aYIvbMrr90OTr5MrnzApcUGOgu47oZgrbcOR0zqqxFN?=
 =?us-ascii?Q?Qko4koylapeZCo3b1MH530YZrD2DN7FKwCYklR6IupaTL8cFrETRNSLuLjkA?=
 =?us-ascii?Q?Lh2TLv2icftqTyZLgcyo1MgTCFofkh7q9LHAl7tcxkkFR1MYUKmhIcat5On8?=
 =?us-ascii?Q?xcepYwbCV2tm9uv4QhlESPf2sqqB/j0nExRHsQaw+u/Iijy0dF1rVEA/RMuU?=
 =?us-ascii?Q?0BW6Y+7nm7q14aiOEJvVcev4TuEm0ch+l0NfE6RFjTsf64FGYUzK6J6E/IiJ?=
 =?us-ascii?Q?4dlsrSoeI9VSzeFqgQUVeokfBCNwlPdv3OXNvCwFKEsEjWUAoWWIM0tWmEDj?=
 =?us-ascii?Q?/WA7tCAhd79JDQKOXUFs5Dxjt/yTJujAmyK1St2oucP07J7jdSFTDcI6sSoU?=
 =?us-ascii?Q?KkpPCHkjZlRl/9rOXwE/vMSedUOj1dZgT2M8r4upSu9wbOOSAcdEmyE0zby0?=
 =?us-ascii?Q?YzFVN6vrEe1SEZ1Qdx8nmzPGogzIJ8HEzTeG/hmSNEnEmjZ1Cjx1MIbwSB6X?=
 =?us-ascii?Q?LUeqXCFLFMpdLf5rCIFiZln1sEF9qAdNgP55Z1a12Tp9jTe4dnaI1ukrDlZ6?=
 =?us-ascii?Q?OX2zWu2yXdBJuV+h/eb3XJe+diK67bpR2cyLDTlYWSsTEIkBnO+fWUV1dOio?=
 =?us-ascii?Q?7HQipwkqFeqb4v9If9Swi0yy6zuKk1zl1zGank7ek/MJmgHNZRpb5YJlsw4C?=
 =?us-ascii?Q?QTsVjYAdLwxsIL0DPkkjF6JCHgrKS5/InI0aWVxMfv3jLCguBWu69ILVkuNS?=
 =?us-ascii?Q?wbUgudVHDXvHO7SWqgu4yycQQpinm9xLq1YtRaYmKEcSGSmST8f7xK5/Nn9I?=
 =?us-ascii?Q?fCJ8VYfY0Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5581.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5db3b89-5282-4279-14af-08d9b9dcc637
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 23:53:31.7816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B1yOXLa+yJTe1GP1IpTKnnsl2qUPLURJz7wAJHZKhCXvNobCoj6Yeb9bd1rOq47+a1Vb4CO6D0NG+hgZ2S4YdMMkBKjLVSWlcSACl2GWgHdisPM9IHqwtBiH2znWbhar
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5581
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ameer, Mark

>> > -	const struct test_adata *adata =3D of_id->data;
>> > +	const struct test_adata *adata =3D of_device_get_match_data(&pdev->d=
ev);
>
>> Thanks, that's a cleaner way. Can you advise how should proceed with
>> this since previous patch is already applied. Should I send a updated
>> version of patch, e.g., v2 or a new patch.=20
>
> Please send an incremental patch on top of what is already applied as
> covered in the message saying the patch was applied.

No worry.
I will post that patch

Best regards
---
Kuninori Morimoto
