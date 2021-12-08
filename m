Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A156846C879
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 01:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242741AbhLHAJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 19:09:24 -0500
Received: from mail-os0jpn01on2105.outbound.protection.outlook.com ([40.107.113.105]:12751
        "EHLO JPN01-OS0-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242722AbhLHAJV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 19:09:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GINWifmu0yGYoxrwzQfHl9pkvPDiQEz8Sf3r9QHh3JJtB5ToOYRiazG+BtXkjd+sdSZhI5aq7Q93l3kiP8CespXAbYKFsYtaxjJUQpgwOEGxbhjwRWTyEiuYbmA+GcrDjXzQNcbj80psUdGuQLtx2/+DeqUytYSqLKdjBQyO6uw6ibHOuOV4QygUG/Gg7yIAf3l8stkN+xtxPCoshVc5HIYX561lOSkg2n68y8ihUrjjA3VioBNuDS1wjwJDAVNhmzVPIcTLMsPbxTn+jxzrTP+OQ/5mzfBJpiYduCEByL2Ri/rR7cQmJ7xAk5Bz9xcTqQ8dIwxTG5/Xg9pHxzUpEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Luu4wSNQ5gxaryq6/1gImxVKUmO2S3wI2u0c+rOGUUg=;
 b=FR87DztvND66TBlbkj9FWGYyR/7g40SJCRb/lkrhxi/ba75OqMzLCsn83bcn3mVe4fLulXnqAi1Afb99gTeT2cUjrzs0KwXh/6D79PSCsl8jG/Fn+9YdI4w9nWszTbwkc7rnibkUvoRVwvNbfvojXx2tYxS/dUZVu3Ar/WVp7IYHQdcmqkvtFdY1AR/Aj8f4gAqdep76csMUDGr8JCQGvJbZyJglp4Vy1wmAYXnDETSuL4GUGC8u8KoHAtY5edWCkl1L506O5Vc0zJ3WC2rXOgqubYjCE4iqWVLhJRoEKGzZDR4NOA1LDo+byJp+d6IrmNKweeIboGpAHe1LLfDojA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Luu4wSNQ5gxaryq6/1gImxVKUmO2S3wI2u0c+rOGUUg=;
 b=oFh9+s5qF43PsUPdQhH5sbYEuta725+Upq08uszFevHfpE8wuiKF0vQr4RSGcEEU4Hm7PUWcp8bezPTt/S5ca9+RXOVkz4x8laaKogbxghAbQyEzBSAv/YVghRD8p5aDuErddh0ZKmfWBDpYQlkWFvk/k6KLhfO+Tr1VQdNYM90=
Received: from TYCPR01MB5581.jpnprd01.prod.outlook.com (2603:1096:400:a::10)
 by TYAPR01MB3278.jpnprd01.prod.outlook.com (2603:1096:404:8e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Wed, 8 Dec
 2021 00:05:46 +0000
Received: from TYCPR01MB5581.jpnprd01.prod.outlook.com
 ([fe80::3d74:9c2e:e85a:df82]) by TYCPR01MB5581.jpnprd01.prod.outlook.com
 ([fe80::3d74:9c2e:e85a:df82%5]) with mapi id 15.20.4755.023; Wed, 8 Dec 2021
 00:05:46 +0000
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     Ameer Hamza <amhamza.mgc@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] ASoC: test-component: fix null pointer dereference.
Thread-Topic: [PATCH v2] ASoC: test-component: fix null pointer dereference.
Thread-Index: AQHX63X/efmSO580GUGeokqOxsO5kawnte7w
Date:   Wed, 8 Dec 2021 00:05:46 +0000
Message-ID: <TYCPR01MB55814819F7AAAC654084615AD46F9@TYCPR01MB5581.jpnprd01.prod.outlook.com>
References: <Ya9YxoUqkATCOASh@sirena.org.uk>
 <20211207142309.222820-1-amhamza.mgc@gmail.com>
In-Reply-To: <20211207142309.222820-1-amhamza.mgc@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6c6d888a-e120-4f23-125b-08d9b9de7c46
x-ms-traffictypediagnostic: TYAPR01MB3278:EE_
x-microsoft-antispam-prvs: <TYAPR01MB3278FFC69A388FEE06AA79FCD46F9@TYAPR01MB3278.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uEeAvYOEQc/7jyZilCoyqKKupdd/f62bXt+bhulKyvHYYUf18awa3z5eBBG1VLwerZjGGgHkvsasZb4lzV56gQxwdkemL+ktSG44qmbESbOKmtF6Hnn4JW5W4ezW23jp/wgfE+5aRGilf8ZjXv5lhfUOIErLMNG1kiF2r+hLVStEfCUwV7SsuNAR8OhRbSK2+ce/YE/7AV/3ZQtIF1qGq4TtW7+vQqwLPyEb+I9KPCP4zzaIPqd/FIdeVbJtojj/N1booq39t6LbUY9jIYp7P5PKuIcRVrfx3jwa6O7voPHv9gYqNeb5GtTyN4sO4YDlc/c8eLKPvtdQRj3i1mARlMbaw+NkL01FNhEB8SM0O9odQu5r+21d+gNpxWMSMC4021bevm59ZzPQgWncBebTC3jsB3NhCKDYU0+/bEOk1JlHIK2cY7U1+4H1R94O6idDwXd18h0/9ZbWMSV4Ss6h9DmZbsBttwZs2Z1LJJz572hETORrUjwkwptivpal/p4jg858h/ahoE3bVR0NUNUNXNAZEz7lBJB9iZ3eRrpXSHNyQbIrZZ9N7lfYX0Qc2APqt5j17kRKF2slUWgMi/W0HQHQoSjJN+lX5S6355Dfnz2DLZN3AYkvlTaQU66PtRhqYwihVBmW5CDfAz9fgyUnbIaGnrwBHM8Acdu/uWmD68pYiFE28vs/m2aVYZkK7hPuKzQL7v8OCkTaa6/W8HFEjQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5581.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(9686003)(8676002)(71200400001)(33656002)(7696005)(76116006)(4326008)(55016003)(186003)(26005)(316002)(66946007)(2906002)(52536014)(508600001)(110136005)(38070700005)(6506007)(8936002)(4744005)(122000001)(66556008)(86362001)(66476007)(38100700002)(64756008)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?EoZEdPguhQgn5mqgS/r53V6R7QaOm+bSLjKSWyLd+qpfdACD2C2B9zw94xCA?=
 =?us-ascii?Q?YKqmeCeaJkbP6n9GBGAlptah+Kj4s0vgapSb6a7NegzOl7/R2YuZgxNlyO18?=
 =?us-ascii?Q?sttqFLnWlx+6rAEiVTirZzZtJZydOHLciL57WESdtM1iSi7IyctqxAi8VGCr?=
 =?us-ascii?Q?C+JJ0SkbX7i806uw65NyjFM4sv6d6cck7a3QfpiIAlen1VKVeqil46xebEA6?=
 =?us-ascii?Q?oZhFG/jPiUtpN87uCso3DhZ+FcCDM5MaK0m+cv4OXWxA12X33vEb4jpZX0ZC?=
 =?us-ascii?Q?btqqQywSgCeDoMcC6TcZStgD+8wF9Yto/Xzz3TaEW7MUnYni/55wGIgBVRRM?=
 =?us-ascii?Q?+XDhOVhYvDOdYBWQ6drcWQItkzhD9hsG35Sj1bFPeVJOmhsq999aXkqLLMI7?=
 =?us-ascii?Q?gqvX8uwUciiIjU1h6spgdoUm2WwVn7cUv2eqwWPsQjC48DtQo/9F/+mSF391?=
 =?us-ascii?Q?+fZPStOiZ01xVQ+br0nB5as91hoqXn/+YBAi/eVnMwHz1OABi7NEHzshTPRp?=
 =?us-ascii?Q?qD2Ic8RbFIxHBDinKM70hG6yyTZegsK0gIPKverMloECPUU05d224up/JQ4B?=
 =?us-ascii?Q?MYPZ0D7ZIgcV3IcUdyibcAtw/7zSr9I85sPUKDO3/AjIlxjZomwDq3tT4XFw?=
 =?us-ascii?Q?x/wIMOyC+hhwlpVs/G0g3hsYptbhLOb8U74wy3p0t4bo5nE6WU8FUldKIW4T?=
 =?us-ascii?Q?51w/owspvsxwy8vGcLhgr5p6c5TFMOxRYA/pF4OdZS9+Ul/bG/pWtUMMeNJM?=
 =?us-ascii?Q?ZQV643swf2ljSNd1P3f5E4Tye7bIDsXAvzNeHFg1NwJuxrwO/cXka2coPcrK?=
 =?us-ascii?Q?hQlNAeAKojQ/DikKY0OX2YkGmdO2tgWD1QkixoyzrspabsloVhPesvNkYBtM?=
 =?us-ascii?Q?ZJ46wsFpCOH1vptt0i8XnDW42DlohVldFnLKhCdy7d8bME/uEc2COciSJ028?=
 =?us-ascii?Q?Gm1af91/DHAIRf+SAZs/zaeQRtZ4zxgOuCKZXbxDc//MuxzXGZO5b39vV/Zf?=
 =?us-ascii?Q?proaZLVS+uwMTHmhq71IYRV0q+Df3V7DwSh54HHWW74yAotRSWnG10iKohAX?=
 =?us-ascii?Q?oQEAfkNvELtpMwOI2Xj1Vlls2Xlgr7b+Z0wDGWmeQ0KZP0G6B5GblX2RZlio?=
 =?us-ascii?Q?6+e+/cmibDB0AIceKTPRk6nhj+FFPd8teaIlLXF2iJoZA0V67m4OfAg4Vu6J?=
 =?us-ascii?Q?Ko3WDAEa89nAQgYosDjtNZ1DySpZcXkqNMAWfmGo7jzIUYQjrz5P2C9PXVBv?=
 =?us-ascii?Q?ZggiL+9R/xD1sAWIDAEoQCAtxTANn6wtb6i/VxuFqrp51bj6zajl1zPs77rg?=
 =?us-ascii?Q?4kUsaGczhV8ojrFfKjDF0DwJxXd4MMA5wv0H1cNDrv8202arA5yAFnahRKtP?=
 =?us-ascii?Q?cnqWCeLSNIqpsBq1yTm/aYIF2jGMbMep6W/7Nrbvcen0SjfI4tD5/yg1XdMs?=
 =?us-ascii?Q?C20L6TuDL2peXme2TzkbBNN8nMNotcS1w7q7gq3WduIswsYxZ+fjypXGzabR?=
 =?us-ascii?Q?eJ14PZeMdVCuW7ekCmpgKyRinoT6aVdBd/Lnx/7F96DmkobAioZ77KvaRUJ6?=
 =?us-ascii?Q?SKqLFuEWs0aASclb7GVP8t9GHlPeXMvQunATX+Vn9zRCj96j6lOeKI6FRlHa?=
 =?us-ascii?Q?yJnt9JrAyBnEH4RrRdkjgJMfWSCGXZruHkMmKGh3SVaxubI+7x7091qLCQmZ?=
 =?us-ascii?Q?0pjQxqMskk7jqGCUdJ4JVPQwjgHZ9mM+Xc9f9zl0CQgdvDvdArt0UQTgaCXA?=
 =?us-ascii?Q?1Rm7ovnXag=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5581.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c6d888a-e120-4f23-125b-08d9b9de7c46
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2021 00:05:46.7231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MCGcXokyvAkNl6BjvoZ0lWtwf/AXBiH1ThK3WuwII7V2JKBd4GIBbngCTLwy/aw3NhclbpBugc8w5DKTf39IbcWBle04OAyddYZ7FLtMz9oSTWK1KCL/LQzaITCA+g7N
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3278
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ameer

Ah, you posted the patch :)

> Subject: [PATCH v2] ASoC: test-component: fix null pointer dereference.
>
> Dereferncing of_id pointer will result in exception in current
> implementation since of_match_device() will assign it to NULL.
> Adding NULL check for protection.

Previous your patch was already accepted,
thus this is not v2 patch.
git log should indicate is replace of_match_device() to of_device_get_match=
_data()

Best regards
---
Kuninori Morimoto
