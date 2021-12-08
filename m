Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88FD46DE87
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 23:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237918AbhLHWo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 17:44:26 -0500
Received: from mail-os0jpn01on2110.outbound.protection.outlook.com ([40.107.113.110]:48371
        "EHLO JPN01-OS0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230480AbhLHWoZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 17:44:25 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwpExSmKPFCWVFIDJBh1Ok2QVWiEUJ/ORIxRmCJkYjGQKOL4jLpG4+A4ypR2YQ8bBsFdd4baw7k5vAFB8ONXANFvsngGBb7CPkR9zuGq6h78VRQrzj9hC+y3XVH6GVaZibAG4J/KLgvdo9ee0JD4gCk4I6eNZ35vfT5FIR+taAuwKt+z9LMQjz4WQzqyFTmLpe48CcH3uT3KeiQKUE7vIh5Y+uy0QJU7q6Fe/2SYN0w6+/JBm2OC2n1t1UYYlcVqJJaoPFNDcmV8C43pCeCXnxk3HM9YoBtiLJvMZYrbz1gDRvD02b5Rl9lPK44/fJ0wS51jdc4Of2M9AlxbbJJylA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/wWjegG/Tyz/7LbBRwPl7yUMeG0lZ5DYSibutC1YWJ4=;
 b=StFIrGwg00Fo/Nx5SKEErMXT3JBQ7sYjhN+lX8JN1X4Gi4wze4VtVyUhnCuwaAAb9f+6zHUvH9drLUEm4pjGrd4OVUWtVd8ha8FtGryfpt9JdPCyy3Q4/HYNVgu8sOlbRzaf9Oz/DDdqfmY63/ZLkYTsRoBPwRUfc2p67x+BnWRwxFo3pinjyblP4NbdKoY6ZiCURonaqFFug+KHBSnvIsGrjI8bYOggFzxieDT0f1AmrNz55TT/Z4R+S4LyNhBjMvy4fw1Y3Y41DZXEiYbEKRrTRrb0Ig6WI9f4aBYiEmSWAFzrO8rAXpldp0HPJfKVbdvkl9S9bplzYuH2EY4H6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/wWjegG/Tyz/7LbBRwPl7yUMeG0lZ5DYSibutC1YWJ4=;
 b=lu90EQbJGmTEEgJcpGzInxKPXvIM5qe94XAVwdqLrHJryEjzs/R+Kd7w6JKJ00u5Iel6kUCC7nZxshwuVeFGklqrU+1rjgUfk2o17uPXKx29zt4AiMVdpAWnaPSNzFspZRMPLkvtmeuRy53jzi3O/APPLDZlH0kCNbcurz1ZIw8=
Received: from TYCPR01MB5581.jpnprd01.prod.outlook.com (2603:1096:400:a::10)
 by TY2PR01MB3801.jpnprd01.prod.outlook.com (2603:1096:404:d7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Wed, 8 Dec
 2021 22:40:50 +0000
Received: from TYCPR01MB5581.jpnprd01.prod.outlook.com
 ([fe80::3d74:9c2e:e85a:df82]) by TYCPR01MB5581.jpnprd01.prod.outlook.com
 ([fe80::3d74:9c2e:e85a:df82%5]) with mapi id 15.20.4755.024; Wed, 8 Dec 2021
 22:40:47 +0000
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     Ameer Hamza <amhamza.mgc@gmail.com>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: test-component: replace of_match_device() to
 of_device_get_match_data()
Thread-Topic: [PATCH] ASoC: test-component: replace of_match_device() to
 of_device_get_match_data()
Thread-Index: AQHX7DBY5fEniqBhmUyqXxej8V4MzqwpMFEw
Date:   Wed, 8 Dec 2021 22:40:47 +0000
Message-ID: <TYCPR01MB5581FF204343B5539B449F92D46F9@TYCPR01MB5581.jpnprd01.prod.outlook.com>
References: <20211208120526.GA12550@hamza-OptiPlex-7040>
 <20211208123659.15789-1-amhamza.mgc@gmail.com>
In-Reply-To: <20211208123659.15789-1-amhamza.mgc@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: be1cd608-0198-472b-8953-08d9ba9bc780
x-ms-traffictypediagnostic: TY2PR01MB3801:EE_
x-microsoft-antispam-prvs: <TY2PR01MB38013665485DFFE4654F7A6DD46F9@TY2PR01MB3801.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1417;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ctC2aaAw1TL5QMs/TIpzdRC2AzPLt/q2JOVQ9tKeoZL4630wN8gLU+J7DCSDA8P3zPpnHvzrGyX1Kiglh5XPdQdYP+Lez1N47gEvvwlDTaDhcXtHts5xY7QUkdDJomTlSou6LtvG/7Ip58Eko9R+qTLD3OUhtcrBAkh+6/YFCpaYDoBO57jMtjNMVtF8nGERUwKM+94wvGoe7LgtzVs/Y9GqfWFrksln4KuCufdPMi9Q5zbI0lV9KO83ALDrRcxwa9DjzcIAtXVLQUn8vXX4HxKzYWF8lqDq/OoRgEgykhwIQ3WETA0aPe0/I760/2sqtxdQtmtS2SXzBfI6480NGt7y1qRlMMCrRdt0nfU0c/yl5HZv3BBzhB1NpYVyUOLMIEp+ikFxTwN7cNg9LpoL0K9vUgdBcqeMbjrRHAg+ajgrv/fLsw7bUILkA1mni6NWA6WMrB8Z8j4qBiz9pAjGLvfK7GDQtgh4YLhKx8ewE/IPQQxTdwoBIbd+wSIGMYiv75xBbhP7MIqdUfq7yZtTw8NzJ0ZZ7kXtzMBNV6StzmgHckGhmadJwVLOWN1NLr2aCw1CJ1BVAiq89dw7Zgb/zg52ZBIOSba6DcPtAY6Kl8vs1wvjYYkdIfM42M9BsRk/PDtAZfweNC/qinB7373b/oP/DmXPkIW1M4PYp6YBxP4bTOI0huoQLoCJTS4UzPlshwZFOqCYDLj7M/MyoTb9IA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5581.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(38070700005)(5660300002)(8676002)(71200400001)(8936002)(55016003)(558084003)(86362001)(38100700002)(64756008)(66446008)(66476007)(66946007)(9686003)(66556008)(76116006)(4326008)(316002)(26005)(33656002)(7696005)(6506007)(186003)(54906003)(52536014)(6916009)(122000001)(2906002)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?QqwbFGNe/01KTw16paiTEXEeQOATXLwTnGpHpvdIkzWwczOXDosdVoLVqu0J?=
 =?us-ascii?Q?+KbRWo2C2IbrW1iWtbRHe5FiKIWENHlZnAPnMo1/sOEmokZg9pEkfTjwdMJt?=
 =?us-ascii?Q?HQitQ/GFDqZkTjzh6wXHc9jGrDh19sRFv5/N3Y/JHLcTWQkMHM+kFmL4rAKJ?=
 =?us-ascii?Q?a7GX/ocPKPR+dKH+VAKohhiKFkIjOsON8ePYUJpfHrHTmWIIe/InNfhQdri1?=
 =?us-ascii?Q?bbrfFeh8je8Gk0dkmW8K979Fll1nL9BDzPpdmStUaFjUhZ5E2o+8upBsNgvQ?=
 =?us-ascii?Q?ktsMELVwCrp1rM7KdX7/rUjfI/gox89EvS+rkFdbhqfWczDAIIeM5yfxDjwl?=
 =?us-ascii?Q?LKTeLLFbU6khD7YBab4v47DIg1zB2ZAVRSM5U+QpM/ro+vmltOjrfexFwAxg?=
 =?us-ascii?Q?mSYDMGteDzU8LU5NjlAcFzxOVbMz88L5xBzFjTyPSk4Bek2bjLnBbZBk4nMr?=
 =?us-ascii?Q?T4tWeMmamJ5DxHOw6L5Pya/vkvq35Yi7428UVH44icFZJZSP6OTr0lA6wBo1?=
 =?us-ascii?Q?GpH6LxNM3Pra4+mvsBarhNInfERw/ZppAkNlAsbgowxWrly6KfP0WwxzoOi7?=
 =?us-ascii?Q?XV89s9+nSvUEDrNdBSdbt7OjZIin6En7dhn33gHvF2IYE9IJd/BbfX2RMlBH?=
 =?us-ascii?Q?r0r2Y5NEfRaIpg1ykbFiiI30ZRoOg/A0qXeAbJZzpYg2GIoFoGzrqisWoC75?=
 =?us-ascii?Q?m4Dv70BfcAl2psRL1+38FLx6RWYAJzkhwoZL6jclTvkqxJPx49Cvu6wBkw3+?=
 =?us-ascii?Q?mVUwAu39nLhn7mUl87S/Z+LoHFmpk3G0sriHSQV1XLJwmYq8HekSlULYpCsL?=
 =?us-ascii?Q?JZTLUSB62+5iB3cQme0I1he6EuiFdueRNjZLe+o3GBoOLcGUaxmhwPk8zLVT?=
 =?us-ascii?Q?Syf166qsqXHzau3TYcvgX52Da7vKd4zgu9dKw3Hc6MG8G3Qnc35xfBcp6Msu?=
 =?us-ascii?Q?uhpKkUEpJmVvFTkP46aqgi6wXug5jle9bFpmdXCsKkGPFIqAp9ofZCOSM0W7?=
 =?us-ascii?Q?aMvxnT9qiryfIvz/vfei5FoZfvNMjciOm/YyTzU+zagi4XW74WQ26FWAqIbu?=
 =?us-ascii?Q?3qkWIeWrtW2rhG4M+rzlC1tYXMM/k8C+Vy584yaprLSULS3LKBZYqCxdIy2t?=
 =?us-ascii?Q?Qmwlp//cE8oLE9tRWr1qIjDhJ04yLbdNEINuUTT7H3iqLPKLHEgazhPSXVQc?=
 =?us-ascii?Q?2BLctJu/4RfSoc2p0ssj3LNbYNBOGiSbw/mPuHkPypcpEmSY3yMQCZLEW/Va?=
 =?us-ascii?Q?HKY4xrc8+1+KFwiTcw5FCmmKBA2dVtNoh8ZxG+3SERdKbR7ck1z1B8g7AszR?=
 =?us-ascii?Q?dwHx+YrTljy+Lki729f2iXfOKdAoUC3RGKLEg6qxbmZGNA6flLI1kLNFi6YM?=
 =?us-ascii?Q?0g46hLa83MP2Z3qtgj8bjaNtznbXMlqDW1zTII0SWsQNplrbqVQOE/ljRKP0?=
 =?us-ascii?Q?/Cv3L0mOL3+i/1HXSFBJbfioZJSXkQHaWQieUpj7eYoumdLPgFgGmtb+MDJj?=
 =?us-ascii?Q?jeYRDRsLDiZZfQlLRVovdiH31K0FyzMZHrS39UCBqBDzGQBUvPPa2RqG9zTu?=
 =?us-ascii?Q?cGOT1CrXhZWJecMQDDNpx7avWvL8J/jGInbpxtkn5RYU+qn98aEnMceNNyIB?=
 =?us-ascii?Q?n1HABsni2uJe7TDDxggFxc4KETGO3gVxomCNluhU5x0CNGXToEcHD+ISRTDE?=
 =?us-ascii?Q?DRywOKEgdxUuBJ0ezO+5SKYbbyBXcgUNefCahJocZYk9m6hwp7vyMJxsa5Tb?=
 =?us-ascii?Q?sXLGh9nTCg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5581.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1cd608-0198-472b-8953-08d9ba9bc780
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 22:40:47.7079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fDrMRy0fNYW7V0UYyYH1fyEGBVYoCub1plplwvpJWChBjgnMuAh23TZ48SCO599M4i/b3SMD/TUAvZ8XJyYYr3X2NEpbPuD9tzuuut8IQiRQ6XZpeOpWsWVUrHhkwtiF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB3801
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

> Getting device data from of_device_get_match_data() for a cleaner
> implementation.
>
> Signed-off-by: Ameer Hamza <amhamza.mgc@gmail.com>
> ---

Reviewed-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Best regards
---
Kuninori Morimoto
