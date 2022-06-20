Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179E1551F8A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242147AbiFTO5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241922AbiFTO51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:57:27 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2044.outbound.protection.outlook.com [40.107.21.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A89624F3A;
        Mon, 20 Jun 2022 07:18:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igOXctBXQmSQiO3iHDeqxLgrprqEX2P1wwV+08MWOMCw+HPsQ2WxlGkDOYBVMDKIIa905MIc7VNtW09uIa2NYmhAlgi5z83tpnzPmy2qkphVYn+/CIczgsv0B/+kHznT7gLD4QgSe2g372sD/mOijFR9npgH6tV/I/7pGTm+sXXfHkTjQLH6YTpPLAvl2T7T15HpT4IQEZRggP7PjlQS9HHQ+hBjhqajIv4GGWhgfeTP2KHNYv3D5JbFHJpUamKmHo3BHtEfQubM55U7j4Xa37c9XsbyAKwDQ7gJiUf+bS0yil6Dw843ATDEWecd/k1EKglK6RO40UkKQeDUxFSAqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2qh5k8MtqwJ0+C3ypqjbyTGFLnBNUE8JaUXQKcyZ860=;
 b=aLD8Y1+4jUW5aonFjARoUoJcQ0QBhFZq1weMYxFCJi+4TGCC4CtLogajMySpMwIjap5wh25I09EjwhYBPngJj4xZMQG9VlP0kETYDjNVV3thsH6fM4fsLSiBubQfT5QsjYc4uogAaWsFPSS0M3nR10K7ZKlVz7eTP8ONbSlP4EMsBpPhTKt3cRICIOgeN+VklegnErnQQA9CgEFKLyYLqs+Tb/b6LlgYxB7wevpGYwhkqjvbaOJ8PJ92DDnI5mgzi+rb8eW7NnQkmJoBegK5mGQt4I7KDxDLT+LX6Oh9PKF1hOiUf/W0h1ZI0Ks5FFnmg4E1I/EMdUoRnqtKjeOYLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=variscite.com; dmarc=pass action=none
 header.from=variscite.com; dkim=pass header.d=variscite.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=variscite.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2qh5k8MtqwJ0+C3ypqjbyTGFLnBNUE8JaUXQKcyZ860=;
 b=WwjL66jhC8HP/psJBtd2boAp9pNx1jDjWu/ZzgJvMJ7oYhwNLyji3HJBGXPsGEm7tWc16eBiegAU6iwAt6OtDzhjS0TYzaEeH0KUR3ynk0s/N00Lc7conByj3TJ6TCTtrt+eZfl7sJJ0Do3Ob09Z/XJFZ4EaOcZ9+bi+ogAldSHhmyivtzDcWETn6KfquMsez7xjeWF1hAHSvnPG9Yxlr0TUX57Ao0k8RyBpH87MwgafVzmFgxLEfucVhueRH/iud1xuMst5OjUiNldzz+Cq+s4EHNDaaLUR12KqLsO6h66BIPwaF/XEpl24LPVlBlm9q1BRe7nS0da/adynVKjpxQ==
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com (2603:10a6:20b:bb::21)
 by HE1PR0802MB2489.eurprd08.prod.outlook.com (2603:10a6:3:d8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Mon, 20 Jun
 2022 14:18:30 +0000
Received: from AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3d45:c206:59e3:6539]) by AM6PR08MB4376.eurprd08.prod.outlook.com
 ([fe80::3d45:c206:59e3:6539%5]) with mapi id 15.20.5353.022; Mon, 20 Jun 2022
 14:18:30 +0000
From:   Pierluigi Passaro <pierluigi.p@variscite.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alifer Willians de Moraes <alifer.m@variscite.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Eran Matityahu <eran.m@variscite.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Francesco Ferraro <francesco.f@variscite.com>
Subject: Re: [PATCH] driver: pca953x: avoid error message when resuming
Thread-Topic: [PATCH] driver: pca953x: avoid error message when resuming
Thread-Index: AQHYMi53yuU+pjue7EaPB7U02lddyqy0GpcAgKTcIeU=
Date:   Mon, 20 Jun 2022 14:18:30 +0000
Message-ID: <AM6PR08MB4376058D3FFB4139E9292EE8FFB09@AM6PR08MB4376.eurprd08.prod.outlook.com>
References: <20220307141955.28040-1-alifer.m@variscite.com>
 <CAHp75Vf=vQd5-PGPu3Pcx9bhKSfhdnYDOSOmZKQZQ+bxVkpmYg@mail.gmail.com>
In-Reply-To: <CAHp75Vf=vQd5-PGPu3Pcx9bhKSfhdnYDOSOmZKQZQ+bxVkpmYg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 5534e979-0d9f-c3c6-acba-05036c487e23
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=variscite.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a384f926-288c-4cff-7132-08da52c7c087
x-ms-traffictypediagnostic: HE1PR0802MB2489:EE_
x-microsoft-antispam-prvs: <HE1PR0802MB2489B4AD7D8C0C0AF99B4DA1FFB09@HE1PR0802MB2489.eurprd08.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KcNqgYrb9KPmmGgUHAfrxUZPik4/XhllcREE+/gWIaHPLmk73crwQn8zZbyXQu5uFVaC+qf/pp9qZx38jDGnpgWtItOz6YGCkDob0Gv0D/fBJFzboIVa/ywdhYwKKpTG+rp1HmMfCab8rORIHD8uPfwnDMnZ5/4z5T79oswSzR1WM+exxL6bKMc2HLL7v1UI09dn7bHnGgHPNUCAjxCleylN0m9UU7u7ptLDHFzYoLthipEptMb7nveOmk6Lw5QFCcVnBP+EkFmXJ6RuoGDvx4IrXOgjUOgUlHWOWRZVlnVIY4d/5OoyQ8v/jWQuE/BrbKMAJNS7wPjpG70a7AXLl+TuIfjc0zOoTIBCFiPdfI7Utu3MHqsdXzGfdzfoNkd/mfYoWNbc52dz0ZlnMrwY7J1EKRJv3kFb2VJ7rO1Unvvy1fmcv/Gh7JztzDgw831h5s+e8a1y6ODe2l8L2hokrV0U4mYNaZ7Zjx9uz6pXjCGFJK/+1dNlIX7K4CfN/w+h15voKpMub/0AEtiqaZYqPkaUwGH1qyxuKabkDFceMURp5EiYCoT2thos4648tfFeiCgoJ/CEfc2Ojfd7EN6Da7qUdCR4P+wkoOLg+CrhtiLSBpOp8Nc3Zf9mrqafjLva2s2xbkdA8oHyNiBY2m/MtXua6yBEQzapmNa037/Of82iqaL7QYt0Z0jPEOfh1O4xQA61x+oZddo0UXGLJOXcJA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB4376.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(396003)(136003)(346002)(39840400004)(5660300002)(55016003)(33656002)(15650500001)(478600001)(8936002)(71200400001)(122000001)(52536014)(83380400001)(186003)(41300700001)(9686003)(86362001)(107886003)(66556008)(38070700005)(2906002)(7696005)(26005)(64756008)(66476007)(66946007)(6506007)(91956017)(76116006)(54906003)(110136005)(8676002)(4326008)(6636002)(316002)(66446008)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?L5r4mNM0rTOOg8VXDxI1agFc94TPy3XAqUe31lOBV4cEaMYDuzuRrwdXHL?=
 =?iso-8859-1?Q?JBMNHcpFc7yX4i7Tj3o/PGRyfzlHjmLHcvDl1hU4D/0k7S1roAluwi8urR?=
 =?iso-8859-1?Q?XPwWcIq6kLSTdEOhhHbkUD6LHeWimrLdktQ+V9+yoKSlZsPg1QQ4xzJyNy?=
 =?iso-8859-1?Q?hhgi+wemVkK2XpgQmqus/BuJMHbI5WRE/RAkI+i0Lt7QNqe3Hb4FmJpWtA?=
 =?iso-8859-1?Q?0unyZZc1niT6DE3XZn4NQQkSFsXVt3FTw/TYx7Rfgjy2rYg95t6/75rJzE?=
 =?iso-8859-1?Q?IWM4xopqxLy1PvjPPCbyTVpMY/Ug3tng8xP8eYFQt/a+c578gaWdyZfsuD?=
 =?iso-8859-1?Q?bW0tJXmnBY/WwDZdb6ZwH+EfT03pLYYahmpFmNZM79Bi/T/1NTpS2UCbCW?=
 =?iso-8859-1?Q?RHatmL0wjWJeICLdLnFEWKQ/ZqLzCLMl3DFC1WCLOx/OHVdcYs3j++9Qwb?=
 =?iso-8859-1?Q?4Hxcvx1bUZhjDSy4hBMt19d/iaGDwASAsnKKA9fS0BmdyOwGbXPWzTaU8+?=
 =?iso-8859-1?Q?PprhGyzDd0Zn0/c5yFG0MhAQDokS970eDfTw7591LX5cg0RZGHwCyuqYeH?=
 =?iso-8859-1?Q?rQFkOz9hCc0ajxJiYQeb+l0U6sXVgs+FrWknRBAbepiyj0lqefhO7vdY63?=
 =?iso-8859-1?Q?WILzYM6aN+gkT2PeRX6icMmctdHLnS56R6h0nTerRyQ7iX8hvOT4hzJMeD?=
 =?iso-8859-1?Q?ZMGRTtCvkWNtVBDLPNAEPR0uAeOuNBdyNy7sAs4AnGC2nQW4J28mlXvwV2?=
 =?iso-8859-1?Q?ounQQpJ1XoRVfpTayhW6wgLFqiWfbJ2u5hyIrDlrowAAy/CV8k0s3mty7f?=
 =?iso-8859-1?Q?6mKvmXKFKTraby+AL2N1H5CXNujN5pXNDebk5ereGBy1qqACAdp6QVhPMM?=
 =?iso-8859-1?Q?2t3hqwaVBwNugQNvjHsjv+O+PflkeYE5AccgJX8f7VJhJlbd+ZfriUpqbA?=
 =?iso-8859-1?Q?6+OQ44Nlk8FTtZUKwsH8N3qUxWhfXCh3czf4Qlg33LQyvRWZ+kIUkVxmdR?=
 =?iso-8859-1?Q?tu4aFHqM6bCkIRNJRB5cKwwaxid9TO/9tXRAQajmlt/PxGEWAJiga82hST?=
 =?iso-8859-1?Q?3dI0dj95eJYnCu9WZOo7/LojpJ7KkNNmHbG9Z/sqPvf2zN/f7ZsyTsaNPi?=
 =?iso-8859-1?Q?iZh9tcIa3oig+Tq2DIqTB5mJkExxMiALFz8gu6s4LWB+zgCAq2CrtIVoUC?=
 =?iso-8859-1?Q?cukw3HKmnQLPUW9Q1WPtVnrt8t0TtcB2PAA7VtvbKoGwiBQntfpXphWRdJ?=
 =?iso-8859-1?Q?e9u5yrVo/OT6ucJwGrDuIp+zYBs5amjsfTBLUPvOdRSzYu6NvRuBhQBJhl?=
 =?iso-8859-1?Q?V/EP8AJNgL7Vey/1xLw9QOP3RzJSbCqmwPWbVfBMZeWteJESh+flrNAoaB?=
 =?iso-8859-1?Q?JRobTATtxyWNDb+eGBXIaWCe470Ib2h+hcaQfksQrWDelGLrovnZ0mmxeF?=
 =?iso-8859-1?Q?3cAZZb+VkMQ3ICk5aF8FECrpL9YlC2248FB90NhEBjdnLDdDw/NNVpN+Sd?=
 =?iso-8859-1?Q?hNWq9l22pOnqnraMWEu1/AZ8a/P0Ocu+98ON/7tqzSf7V7osa3x2VK9vdG?=
 =?iso-8859-1?Q?eUFa3QMbKeCufHavmNfSaCtU9YjAaFxrV834dbSsjogAhREevvwobiIwj0?=
 =?iso-8859-1?Q?Tv+FaemmPQR+maS+XjetIe1ARXIUyxxan2topxOCAL/TpanSzXKpdDeo92?=
 =?iso-8859-1?Q?1EhUQnUJ33bNlEAUY4zZak/xGuBLPX0D98l7/M3PuuiDMCsdEa8BkGrIOF?=
 =?iso-8859-1?Q?mV1LOFfnAUgZPnu22lvuieWh49m0d5VmmQCaIqc6ukrMkNbJPvM1JP0fjq?=
 =?iso-8859-1?Q?7OZ10HBSvQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: variscite.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4376.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a384f926-288c-4cff-7132-08da52c7c087
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 14:18:30.8261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 399ae6ac-38f4-4ef0-94a8-440b0ad581de
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xm+9OVm7rXqFWqASNKiZ8Ou20chc7OtGsQ6ZugMYezR1+0tI2jnwmKjShKa3jj1tIoBYqiBiY2QpsY/qN1T3v/VejCPP8SLjfAI+fjImci0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2489
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,=0A=
=0A=
> > From: FrancescoFerraro <francesco.f@variscite.com>=0A=
> >=0A=
> > Avoids the error messages "pca953x 1-0020: failed reading register"=0A=
> > when resuming from suspend using gpio-key attached to pca9534.=0A=
> Thanks for your report and fix. My comments below.=0A=
> First of all, how many of them do you get and why is it a problem?=0A=
> ...=0A=
=0A=
The number of occurrences depends on the time required to I2C bus to fully =
wake-up.=0A=
It's not a real problem, but the message may lead to think about a real I2C=
 problem.=0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0 const struct pca953x_reg_config *regs;=0A=
> > +=A0=A0=A0=A0=A0=A0 int is_in_suspend;=0A=
> Usually we call it is_suspended or so, check existing code by `git=0A=
> grep ...`. And it can be boolean.=0A=
> ...=0A=
=0A=
Do you mean something like in drivers/gpio/gpio-omap.c ?=0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0 ret =3D regmap_bulk_read(chip->regmap, regaddr,=
 value, NBANK(chip));=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0 if (ret < 0) {=0A=
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(&chip->client->dev,=
 "failed reading register\n");=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (!chip->is_in_suspend)=
=0A=
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev=
_err(&chip->client->dev, "failed reading register\n");=0A=
> Hmm... Maybe we can simply move it to debug level?=0A=
=0A=
On the other side, this can be a serious problem, so I'm not sure the level=
 should be changed. =0A=
=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return ret;=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0 }=0A=
> ...=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0 chip =3D devm_kzalloc(&client->dev, sizeof(*chi=
p), GFP_KERNEL);=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0 if (chip =3D=3D NULL)=0A=
> >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return -ENOMEM;=0A=
> > +=A0=A0=A0=A0=A0=A0 chip->is_in_suspend =3D 0;=0A=
> Redundant change.=0A=
> -- =0A=
> With Best Regards,=0A=
> Andy Shevchenko=0A=
=0A=
Thanks=0A=
Best Regards=0A=
Pier=
