Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B2F46AE51
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 00:19:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376559AbhLFXXN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 18:23:13 -0500
Received: from mail-tycjpn01on2117.outbound.protection.outlook.com ([40.107.114.117]:14529
        "EHLO JPN01-TYC-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1376309AbhLFXXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 18:23:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mN2uT6sKTzj8D9R6XiZU0mdhBNsgyc3+Qj2DyWbO8uOleTQyfEmYVcdgAcgsoFwa+nW+QUxsM0QzBteJCUIDX663ET0iFIM+yn7G78sIMcbhU8qh38pIkyW7ka3m/y9dsVycaAWzWHoToZ6bamMPSTWCV6YuMq4/TW1fsNwcbEqJL6pN+Qc27ZuiBY0pkj0HLm+8+FjwqqTh+8IeLS6maMn/4UCJsrvpQZ9uE7YWTTkM7kTCEBphv/5b1lrZoB3tN9PVFFzQgK9wV7vY4SUNfg0UuvAhXVZGgpfxM+O3RZnMQOHzV5APqoqmqrpBtN/PSvIyK934UdJ8uOQcMafS/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/LQTu28OgIxp9uoQilEo/+kbo1AnANJ1aOXoKQrO4Ko=;
 b=WUeNry6xxdOWiglbdhph6DN55QLpJdBdYOkJaasLOiZcj05ewxYfUuZO+porIqEdgzs9DrnRQuxM5R3OdycXlMxULKDk6KrDLrgzzqqcKXOqS5XSKkZNpaWHP9Wh9DTmhEEe/gdbYWITc5g00AWSWT6p9tFEyAyNzMzuLiCSdErcu3sS2X6C8VOmQCB1/Def67IqGGtKiQ3qImsD35JKdDLnHSmnpi66BqRziTB5a0jH3Uk3JjNMTcA2EkR7tBUjGym8koRbmFbXX4Q5qLvlKPB3Bj4Pkuket1oJuNVwMOwwHdq2SI9Y1cDIrnxAMbqZvlM6X/C3uKnk4K6hdI9gSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/LQTu28OgIxp9uoQilEo/+kbo1AnANJ1aOXoKQrO4Ko=;
 b=BieFd0yyFzp2yg4tqnWs077QNaUq+QSjk6diNTI1/ALGQnb3meDxssEDAZZKD1BzDpRBENNhQv2UjJn1jeLtc5L1mqYBPWj88lXEm87NCiywQjNhv3hA6g4wuhbBNPn1yLyftMcPsfyN5PKqVzlpGTvBjZgqrGGPQXMWlXaIjZM=
Received: from TYCPR01MB5581.jpnprd01.prod.outlook.com (2603:1096:400:a::10)
 by TYAPR01MB1981.jpnprd01.prod.outlook.com (2603:1096:404:6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Mon, 6 Dec
 2021 23:19:36 +0000
Received: from TYCPR01MB5581.jpnprd01.prod.outlook.com
 ([fe80::3d74:9c2e:e85a:df82]) by TYCPR01MB5581.jpnprd01.prod.outlook.com
 ([fe80::3d74:9c2e:e85a:df82%5]) with mapi id 15.20.4755.022; Mon, 6 Dec 2021
 23:19:36 +0000
From:   Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To:     Ameer Hamza <amhamza.mgc@gmail.com>
CC:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: test-component: fix null pointer dereference.
Thread-Topic: [PATCH] ASoC: test-component: fix null pointer dereference.
Thread-Index: AQHX6hiZRK5cTb56bk2m5NVbTZyjx6wkenEwgAC48ICAAOYnsA==
Date:   Mon, 6 Dec 2021 23:19:36 +0000
Message-ID: <TYCPR01MB5581998AD64AE249C7D86C26D46D9@TYCPR01MB5581.jpnprd01.prod.outlook.com>
References: <20211205204200.7852-1-amhamza.mgc@gmail.com>
 <TYCPR01MB55813B26BB2B3BB6D1E072F2D46C9@TYCPR01MB5581.jpnprd01.prod.outlook.com>
 <20211206092937.GA5609@hamza-OptiPlex-7040>
In-Reply-To: <20211206092937.GA5609@hamza-OptiPlex-7040>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 658da310-2711-4f42-6af7-08d9b90eded7
x-ms-traffictypediagnostic: TYAPR01MB1981:EE_
x-microsoft-antispam-prvs: <TYAPR01MB19816EC8BA29F93B429CE1C6D46D9@TYAPR01MB1981.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WfFVzXt0VGA9lS2eYpkGYez9YUnKTREAD9s4IBevY8S9jZQQjewkLAPY5VMM1rEsjM3WpYZUcFm88WHnKp7sKuR4qregRm+KuHVbVmS6xEVByvJxEg2u1sIPml07EDuL5+Be8mlDRmAvlPYHqFfFP9u6GEaD/RRnGrfDuwrlyws30wIaqUNfms5qqNSgdNfkdvbSbMhD5V0OdPu1GAYakRBUDXx97DiMGsOiXVy8H0aY8t5c/xNbbRWbTBxqUCf7/h3SuLLht2AP1tZKAN8J17VRihn3PtOwB59c6NcYLAeR70oBDH1rI+kvUjm12gvryNS9+y87jPrkInDoKiN/wKIbXPpsRYVu6xQxs7vCItnn/ZbOCyuX4JjkX1kYdPLKq2fgmnGi00aSP31GCha9AMPoZTYmWtsc7ms16nTG1Ua+ElPBYo1S+kLoNJPCvjM11YQKqv9f02Lg7FsmR0eBC59LzhgJrrh7eCTVbIqlkO5zZo/F1AcTQ5FltNOQr0aV4KTVAu51jsg7ewYx5AJoPa7k8/reugU3X4yLduhRfNvraCYZVewpy2Q5o9+JEV/ag+ie8Jx1KJmyCzNA75ZkarjaEFq/E06oHoiDeIjhxUx1QhAOA5U9MEIwdaqwsyzMH3JZSLzSk6Zn9uf80sxhdt00t66A6l598CS9Ao1SyHj/JKVOKX8ScBKT3rp6iahb+OLiORC7A0PBOG6KLTydDQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB5581.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(316002)(7696005)(6506007)(122000001)(38100700002)(26005)(6916009)(83380400001)(52536014)(2906002)(86362001)(76116006)(186003)(5660300002)(71200400001)(9686003)(66446008)(66476007)(66946007)(33656002)(55016003)(64756008)(8676002)(66556008)(4744005)(8936002)(54906003)(4326008)(38070700005)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BWLILlyWwr2vgLOciQfnSFsNkY28u798HX0+TTQDyODl61IDuvNCLQaC5P/z?=
 =?us-ascii?Q?eDYlLKA/gww5BIwE+SGg8IA9tdvShmbr2Ub0g3KzyLRuo4MScFk11sv5i2sp?=
 =?us-ascii?Q?Y0Czq57YDKYQV6XAWjI9tp7+AluFBuWTJ2atjKi6OgzbvgdMeXaXDGwGjJtm?=
 =?us-ascii?Q?igfJi/+1d7p5zHJyB30kwoTwREmH6Noy6rrqXWVP1TIAN/jAebhIg2rJ5awP?=
 =?us-ascii?Q?IFcQRscP/aAjYzjs4Ex9XnYQeERYFYbiJRMvMH0s7Bs0sqixPdlm52v6x+Yf?=
 =?us-ascii?Q?snqpR+hAyN+yofxgQ3aMBjBFeXWivrIVOwZp3b1Wi532k+s92fyxmpT762jW?=
 =?us-ascii?Q?IJWckdELFtj4A8Avz1aw7iJq6xyTReIcsOOfOeurU1vaotmiMZsEIYomOG9R?=
 =?us-ascii?Q?4D9HnDLbUJCXHHMG9+oi8UHyKMCXp+vj3EmIAKIg+xqGBpDK0NgZ1DsbaLv6?=
 =?us-ascii?Q?GFK5luIN/kjG3fxBQxqMYp13JQRZQrwcJfPfJwMUr2l4FA0KiPQzia6rs5Pg?=
 =?us-ascii?Q?P2NEWxhPTCiUzuYuF2+F8DGtkgrI8Qh5hc3OYvTuw5nnKSl0QoLqvxVeUuGs?=
 =?us-ascii?Q?rfUg777naM6CaASYfoGxWpKWMGcJTjtfiRYdW7Fk6c0kpBAt6UhftJzDlI9b?=
 =?us-ascii?Q?MeL1DINXRlWbxVdsJf/tiRTcv+l26jSZeXiIYiVB6tEQdbwbGRDjT6nq5CXY?=
 =?us-ascii?Q?gWO5pMqeSpznS3XfXCqtfHfyEx01VK/MGmtWn46XsyZTJ3kq13uIUv4Fwrep?=
 =?us-ascii?Q?bmU1xqMkviQKl6FbA45MqWgiQKU0zeM+bb09kr2NAHeXEW4Jhcq0zBCdYKVz?=
 =?us-ascii?Q?PaT00V8kXA0R+o5yllRPQ1G9GhAs+/bQQ4ANaSdkhT6/R5qt3TX/2KyjAwzP?=
 =?us-ascii?Q?ptuFGAx2PMgkcXoI72dxMCb57SH5diqPquFjsXbXexlYfxrx+s2uh0RqcPan?=
 =?us-ascii?Q?zYbOs0eaMA2MgWjMDRHFpmGj0WVZzYr21jbssQRLVVsU+lxiEMollAW5L6uw?=
 =?us-ascii?Q?8cFWClvsOOiTRnVkIzYGQDhswjhBMadz/OtncIvMfeJp0ilYQZ8f+lDO6HRS?=
 =?us-ascii?Q?4w/0hInyDiH9wvD1QN3k6Px9TroP+W9ydQZhV3zEd+ubgXVKR9V77eTafRkn?=
 =?us-ascii?Q?7FzXyWixXlur2USxR776iN/VoeU5gFzXxkykB9zcpmTmqA4ApZ68olHlxWak?=
 =?us-ascii?Q?fzDTElgvKy6kuWwJf7Z1Pfjg/x/wop3omQ2H07EfbDtx61F2EWGOHXTMEYuV?=
 =?us-ascii?Q?lQtqJ2IfCorksH0eOv4o1f4Mh1U8nASPNTvQvEctoux27/6Mnvdd8BGIIe+D?=
 =?us-ascii?Q?UL56QC+Wdf0T2wJUnQsAAoBbQ5WRQ36wfRjbChukXSy8/Ln9D3Kj9EdXlqwz?=
 =?us-ascii?Q?Wy+sgG9EhwskVcUhXeTvNDtJ/Gj2R/Avp1yBX1zeU0F0KuBuF+uYAJ5KjUBj?=
 =?us-ascii?Q?tcQoDt6ND24CKLdODfnGLAsZOVy03Doswc/nlIrMigYqL8+dJjfbT51vFi5P?=
 =?us-ascii?Q?UqUKJgo+7BH/4T0RdS89H1i4djgPZNAmsAE724+flE3vweWpuS7lOdVyFkDY?=
 =?us-ascii?Q?vuc8vk3jpiJA9B+oGjXn/a7yfHSOVQDMvQGwS9bJicASDRR/7Tgb6R1zhWfb?=
 =?us-ascii?Q?e6Ry/xKV7FjUl4MwnXKxag7yi6NkprxcapLTinYp1pM3sFMk+jrE6If5mNpb?=
 =?us-ascii?Q?cT2Is20EuTmaaoKraA5dqT1r0wPak2UCDBjwZQ3lz5XXt3D+FIpDx4iBJUUA?=
 =?us-ascii?Q?V+eMLw04LA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB5581.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 658da310-2711-4f42-6af7-08d9b90eded7
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2021 23:19:36.7882
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U/gtHbFRgRF7cYKhbIoUAXiBYVImcbQw8NXI8+C2PjdusFVPvMeUlm1djGY+foSTERV3bE1eNevbc4qKlpHitMQjx0xJMD1deI5LDRVCIqKocNJnLThcMRRq1Pi8AOdS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB1981
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Ameer

>> Probing this driver without adata is strange for me.
>> How did probe this driver ??
>
> Thank you for your response. Unfortunately, I am not aware of
> implementation details of this component. Coverity suggested that there
> can be a potential NULL pointer access which seems logical to me. Do you
> agree with coverity here?

I think no potential NULL pointer access, because this driver can't
be called without of_id->data.
But, potential NULL pointer check itself is good idea.
It seems your patch was already accepted :)

I noticed that we can replace it to use of_device_get_match_data()

-	const struct of_device_id *of_id =3D of_match_device(test_of_match, &pdev=
->dev);
-	const struct test_adata *adata =3D of_id->data;
+	const struct test_adata *adata =3D of_device_get_match_data(&pdev->dev);


Best regards
---
Kuninori Morimoto
