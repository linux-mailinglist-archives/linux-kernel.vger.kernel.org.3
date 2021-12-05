Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3C0B468DBC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 23:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239795AbhLEWn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 17:43:59 -0500
Received: from mail-tycjpn01on2124.outbound.protection.outlook.com ([40.107.114.124]:57699
        "EHLO JPN01-TYC-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233833AbhLEWn6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 17:43:58 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KLUFKOUU+uWkTGJdsMy8V2pXmIE1RskYUY0XDs0fMmZ46khJsy2l6a3327TNYbGraasgFDCsw9KTChWMXOmdjGsthNO7+xPVwwwE3ZM0y27BhJJ1TsDXW+j1NhyHAEi9hEHHPH97asAE4wRe/vBY9ztJs8plXwAf8AcYg7vpv2mMMvbqleE1FDaEjM73Y4nfUIhPICCRsTkLFbol/BxR2f5f17PWYK5LWKytAqf8KH6ecjwLLCkL8WQISS+67uOBeWbRm8I6i5Nm7ljPmdRrhbNKM3yNfcY8zQC1DEylvGoMMI6Q3p80H3p/lqwU5fR7QlOYeAt7zUkkp+WBvBtnOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rVG0Fk+I7OB0GfrzT6M5p6lcLbn8KXT9W7gJxDu6qnY=;
 b=l8kFCMKyUFV3ogpm3lubW2ZqBgtGzMaEaayrd6038wkZXlUgaekSr1f6pfC9fa9yzIyY+TZs8uTdzlLwBieJxtzApAW60d16hqKZHoNNIgZ+5g0dVjmzr4RkxHnGTq00mzlseWrtiKdwpYMBigTvtC8V1kxflnaNxMzUT6QoCuD942IU5EkjW2ELN+p1enMmvMWw7ylewzGQsjSRXvS5oiyWrktk4AUQbjmrKKNeYjzh8nnGrQUU+fqeidL2U+3m3NBweXGA+9L/fuf+q0F2mnsSCtYJ4dS462F8sQUpkWQtbHiRc+64HOJzuHAfjNI+c7g3qLix3aK4FlSPKlcK9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rVG0Fk+I7OB0GfrzT6M5p6lcLbn8KXT9W7gJxDu6qnY=;
 b=VXPyDh8scl7tswUGYuE8PJyBlbIvE1Fr/thRIPSjyX7BTPTrbkoQOEiF0CiBtADcKTZ1WoEatyGvijPnS+aG0pusTUTpuxA22srfCBM4ldC1CRqgIHBNJZrZQfT6HzWK6M1TDzAvh2LMIZOkXolMGwa686tXUnj76Kgp3TAAmvg=
Received: from TYCPR01MB5581.jpnprd01.prod.outlook.com (2603:1096:400:a::10)
 by TYCPR01MB6240.jpnprd01.prod.outlook.com (2603:1096:400:78::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Sun, 5 Dec
 2021 22:40:27 +0000
Received: from TYCPR01MB5581.jpnprd01.prod.outlook.com
 ([fe80::3d74:9c2e:e85a:df82]) by TYCPR01MB5581.jpnprd01.prod.outlook.com
 ([fe80::3d74:9c2e:e85a:df82%5]) with mapi id 15.20.4755.021; Sun, 5 Dec 2021
 22:40:27 +0000
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     Ameer Hamza <amhamza.mgc@gmail.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: test-component: fix null pointer dereference.
Thread-Topic: [PATCH] ASoC: test-component: fix null pointer dereference.
Thread-Index: AQHX6hiZRK5cTb56bk2m5NVbTZyjx6wkenEw
Date:   Sun, 5 Dec 2021 22:40:27 +0000
Message-ID: <TYCPR01MB55813B26BB2B3BB6D1E072F2D46C9@TYCPR01MB5581.jpnprd01.prod.outlook.com>
References: <20211205204200.7852-1-amhamza.mgc@gmail.com>
In-Reply-To: <20211205204200.7852-1-amhamza.mgc@gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4938372d-7ffe-4bff-0d64-08d9b8403c1c
x-ms-traffictypediagnostic: TYCPR01MB6240:
x-microsoft-antispam-prvs: <TYCPR01MB6240F1AA5BA57C72E9939935D46C9@TYCPR01MB6240.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BrbAbpc8wzM2weMkZsx3IcDuWCzQwM/AXpm7q/7LAutB/Plk5hLfvFOiZrYoW8LUTYtuw+P1HkEItIuIz7xPG8GT+DykJdWAiJMYXHQkUtC/Acn3IJp50P6azyzBji74d34t/i9kcHA5iopp7OXJf2zNLGaqN9WBxEkdvGpcg0nlLrXHqUwe8tCwVAjsqePhj6xBAZCw9feg8Y7wpcPnDWSv+9U/QjNrYmKxP2qvHhWQTKgqfrsf8C8WEgpPlO6Tr83m6ry2CwLM5oYj1dlcKSEw0TDF1hrjoG/GE/N15Uweqr9oMxC1gZYfogwU029fgXBtYoFgyAvm6EMDSbXT0G/CJBxBj4Tur006T0qTsJHF0EjuZtqknAhctp/EJ//TaSIWFGoa+uezr6CaEG7PU5ZIaReHUGh/eQXjrrRKMpn/J/TpoNtbG+yY/Ed7gswrpiV4c1ZByZH/1ihu+JbDO881wY338alsR3y3I6RY3KmpK8cZkJCM9ewxBzNegQCPbCR3APilmOhm+Faw0Ffa3rTfeTkmouHYwbWHj4foWcTc7FD6uY8GnLZb3oSSVU+mPOJm+ajhJgjKrSSL8lotXlEJ1UdYZapw9bcT1TmnzWwHt55/79OqDWHnf0iv50xBqsSBXaRrVFZdcYDBsCMs337Og5WsyQr3XyouZGMs3Tpt8kXO8gFLYciIlfoDpfaoeFoll4CC1GcOoRd8vrk5EQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5581.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(66946007)(66476007)(38070700005)(64756008)(66446008)(122000001)(66556008)(8936002)(110136005)(316002)(71200400001)(26005)(52536014)(55016003)(508600001)(33656002)(4744005)(86362001)(6506007)(186003)(9686003)(8676002)(2906002)(5660300002)(7696005)(38100700002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5EjQ88F+vCfyiyHC4CsSB9RxfmxXh+Y7L6RLCfYftHanGjtfvTB34AFJaCvD?=
 =?us-ascii?Q?dauDJ4ZZLDFZNBTMt6W4SRKO5239qOIrkwAWXUeBFm4zdPVM9V/G0Df6K+Bc?=
 =?us-ascii?Q?IZeHVhkyIEN8nGgxOXw7xiCpTwFCCzYDUEbYyrollSD4x+gMEK7AGgkJSmJJ?=
 =?us-ascii?Q?GU92OfgiXDuygxxRoK5o/BQ1VlwD1Gc/KDk931YdmlDn7xTvgahNV5pSqqGi?=
 =?us-ascii?Q?MiWRR7riktanwSAnsGvKELpOTX127/swTSlpRe/a3E1MTb6kUy/00LvxYyXl?=
 =?us-ascii?Q?P6nAvrK1BaxTWF1O7Z/T9ftNB/6e1UIJ7btMWaA9LSjywSth5sIKxLf9LJDc?=
 =?us-ascii?Q?SoxNNHla6a5JhF+geiC2rB+5O0B3aaY30zjl3kQmG7kq0msguXTp+9NeLNlr?=
 =?us-ascii?Q?Cnpyb/zGm+FsqDYJh10TZFLO+6M6mykRDwgabxM4tclQmH5sX6TyidHuvE9f?=
 =?us-ascii?Q?J7lQ1hPmhlcv5vjPeiUATNANTDjd3YHR5XsBo67Igt7z7w1qMriHW6YEBrtY?=
 =?us-ascii?Q?3o/+JIIlstKbHD9fkJsV57eNz0aXROFfHsn8oQmInFjzbrqYX7N626Ax3+M4?=
 =?us-ascii?Q?Y2J0h+/o1uKFGv7Of4Of0Abe2i5HOQG368maBkKI7n5HXL2j42365pPPW0Vp?=
 =?us-ascii?Q?Y2/Z9DpLnG3e3WuxhxNtVLMiI5J+jaJr7BtmwThC7KLhBIZ5bWiciRKfkIZC?=
 =?us-ascii?Q?JuVZXDkW2onSJujy9BXqhgeQw7zomF63/zCxq19WoXb2RIQtxy5fEzF99XZQ?=
 =?us-ascii?Q?hXWzgYQzE0PuTPCsPUTbitNa/urxz6IFZDqoEqqiLLOX8jrTf+7UBFVbQspW?=
 =?us-ascii?Q?yuqjKKxgaMVajx8YA44lE16s22ZPKFM1UukU1Xfj+Y/bsxEbHvQpp+1N59V0?=
 =?us-ascii?Q?r6MLdlZsw4m+kfVWNwpSiAuzTX7S4MGphwzsinQaXFVY6fFfYmldfE+HR8K8?=
 =?us-ascii?Q?lB7jYmiFB2Z9WMR1ucfE3HiOfi2WNVNnUEKOO4Hy3SWr1Be8SoYsN3BaD1XN?=
 =?us-ascii?Q?zdGKd21gbAhZ/ihMmckAQSuGyx6DvfLpufRYqXhSN7nhJZzMFoUxso/qrIiP?=
 =?us-ascii?Q?Q+B5hjwmcWdvIQun7DF5hnaqKWke3IfSf70AJ3lYZTKNur12J0oh8JhdNihw?=
 =?us-ascii?Q?jzxKDd+BW0r84jgRr+PqoX7ldA3CAFSX+Xq7Q9zPbI7fYb5C/D86yy3ay/0y?=
 =?us-ascii?Q?beZtopKzqNPyhzexKOpJ8HoAYCmajkOg+HxrrgbAr5ZX+auU5W44EUak3H36?=
 =?us-ascii?Q?p2mSPf2ruvlOn8ZcvEX2aptqWJfXcdDpFSJwoWQSGC6jAT6OwJZ/esw//zFX?=
 =?us-ascii?Q?8kH6kwCEGWonh/kJbhC8DL2CG/vzjYzdqwO8fdPOB+kIXafn9v2OkCrLaXUl?=
 =?us-ascii?Q?jvIG1WwoXiExd08XQn1d4JE0cvvg1fJPujd05cpTJTlR2kMxe0YLJ15jZL/G?=
 =?us-ascii?Q?GWPlFpyx2tUULvKx+fA2mB405OFBFO3fp1v/owoleF6oPDOl+6g0bzBXkw0K?=
 =?us-ascii?Q?LLBB23T5PgbE+T5eBnsTYwT+NG4C5VlW+LxFBGsKru4KvstGO85sF/tRktWe?=
 =?us-ascii?Q?1xiuLj/bH8h880u5xee7294JEif7CQ+JTMqwindLkbkqtOJL+j158gkm+LfO?=
 =?us-ascii?Q?mXES6GgBSkzbS5tyagxSQzZhP9doAimJecfdYrhXb4lZGT/jbQG5Y4H7nGnR?=
 =?us-ascii?Q?yaWCxpgF68TgP8SlXfUYM3sdwsAHwlvg8o/v9UT6OGH5eQVP3SVHcQcso84b?=
 =?us-ascii?Q?bu9n2HWX7w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5581.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4938372d-7ffe-4bff-0d64-08d9b8403c1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2021 22:40:27.4431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DaOKFZJ6f2DBFi0uesJkGI8jd3uCClz1NbRqsfl/AJz+s3ryEBAzBN0D8wX0hsBVWVO1PTZeNVzvGjlH7rlkK0coz7BBv/VSBd4KyUCn2TrRWEz0fNaxtGYBggfdCI7V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6240
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ameer

Thank you for your patch.

> Dereferncing of_id pointer will result in exception in current
> implementation since of_match_device() will assign it to NULL.
> Adding NULL check for protection.
(snip)
> @@ -532,13 +532,16 @@ static int test_driver_probe(struct platform_device=
 *pdev)
>  	struct device_node *node =3D dev->of_node;
>  	struct device_node *ep;
>  	const struct of_device_id *of_id =3D of_match_device(test_of_match, &pd=
ev->dev);
> -	const struct test_adata *adata =3D of_id->data;
> +	const struct test_adata *adata;
>  	struct snd_soc_component_driver *cdriv;
>  	struct snd_soc_dai_driver *ddriv;
>  	struct test_dai_name *dname;
>  	struct test_priv *priv;
>  	int num, ret, i;
> =20
> +	if (!of_id)
> +		return -EINVAL;
> +	adata =3D of_id->data;

But hmm...
Probing this driver without adata is strange for me.
How did probe this driver ??

Best regards
---
Kuninori Morimoto
