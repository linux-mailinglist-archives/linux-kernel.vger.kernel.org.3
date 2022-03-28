Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7939C4E9065
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 10:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239507AbiC1IsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 04:48:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239529AbiC1Irz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 04:47:55 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150042.outbound.protection.outlook.com [40.107.15.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6738F53B49
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 01:46:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TF+Qo15+UijHEufst1lAOa3FuPkk56uUCwWv+9wnLfsiN1/5gfvHltjE0VJWqgUzg9ZHsS8LMWKtpLT1KQYwQtb2nik2JmnKwuodK3IE3XK5wE01BHiDuh0h/LEQicVQB27zcN8PU69FFRtgsCuivXL/RLyhSrjk1ybB9EPfNtmfkaC8bbWpr6KFWuVx9upQfaYjyAWXrewXmVaGFnemjvfSkxwSasYBkjSEB8BfhBa5x4a28alsQJp0iAOygVfWjz5meCs6ygl/unmM+0yNGRo1EreAgyc61TTJ1LTzvRYia5kp5z3MESo1OaJfVwu3nebm7MuDKjEpicpMjrs7fA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uYXBdlwioYEJ5aMHrnxs4xh4Ov09pJ2ktH+CrKYpHZc=;
 b=Z9/VlSYbg+YrC58I0KtqT5OIuvghZvHW7sUHMfJNgWOTnJ65XK3F1iKxTmuU4pYK/unQYUdsbzadnLZt3JlyqJDDnnslM5MWpiIoR1McjrhWs+XeHmSWEWADRLV7yPxtSvABOxFxSgG3CHFck2/0Qyybfca6BO3IsaDyQ5k4ZeRIg0j5FA5EyeXlY84pO4l2DQ9gs/8wT7iIWoUYr7kTE8j1VGH8CMH0adwwBAQA5NQvzhrUvuSvwYesFSD1NJjKiXZWtI4bjkakvcMbM2Ys6Op4A3TepTJxLocJiEi1IqMphjZ/4Rar/K+Y5SMy7HoMGVEeEUhODDnEpZzEeDeZIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=diasemi.com; dmarc=pass action=none header.from=diasemi.com;
 dkim=pass header.d=diasemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dialogsemiconductor.onmicrosoft.com;
 s=selector1-dialogsemiconductor-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uYXBdlwioYEJ5aMHrnxs4xh4Ov09pJ2ktH+CrKYpHZc=;
 b=UlYzBpsDxnoTX1D8IkIlIof+I5iDvkRKSef/WkkoDzN24+51kX2K4UcRl77ju6zS2ZyTFGwPt7WMZOAHAIJ1nhY9mPPAd2I404TFsfhmW+ywiieBSCE4FlC56YuZ1vdS6RfJ6reSotVAUhNxG39Oi9Ni3IyPYZ1CDo9vHmPsP/g=
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:255::23)
 by AS1PR10MB5627.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:47a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Mon, 28 Mar
 2022 08:46:11 +0000
Received: from DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a030:858e:5c4b:c5ab]) by DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::a030:858e:5c4b:c5ab%5]) with mapi id 15.20.5102.022; Mon, 28 Mar 2022
 08:46:11 +0000
From:   Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
To:     Stephen Kitt <steve@sk2.org>,
        Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        Wolfram Sang <wsa@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ASoC: da[79]*: use simple i2c probe function
Thread-Topic: [PATCH] ASoC: da[79]*: use simple i2c probe function
Thread-Index: AQHYQGuXkw3PWPYqD0ehIvB7y2zRg6zUf1ew
Date:   Mon, 28 Mar 2022 08:46:11 +0000
Message-ID: <DB9PR10MB4652606C0FB62468D6561442801D9@DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM>
References: <20220325171243.1218003-1-steve@sk2.org>
In-Reply-To: <20220325171243.1218003-1-steve@sk2.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=diasemi.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba0bcbb0-066e-4ca6-5020-08da10976900
x-ms-traffictypediagnostic: AS1PR10MB5627:EE_
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-microsoft-antispam-prvs: <AS1PR10MB562786D249EFBF36CDA43C73A71D9@AS1PR10MB5627.EURPRD10.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oCSeX1hcpfXGe8PhPq2IcqLDFaz66BMBwFQQDBFecnyjV4DA1hNSkffDN9cr0BesOp0ZNj5TFJPszUruwjqbMBI4fvSNPchro6h7URxbxsgzuloY1SsfB4FrJ1ErBmkCOR9zRB4CTeP5gn568UHg9Y12uYDIuKpHWu6mNoI3zxd8bugE1rqOX0+6K+CuEMPprsVAZZ1BKx18G2kRgWT0TQSRGJ7XBeb0dZJjVpxprSSFA2I78NFld9JzGFVIrxKPa8cNdWtFXiWxU1rqmxEBUKacwoJMn3gNWvB5f/pYno0ULakYddp2QalrMY/zqsmtCICaIz5ZRiSs7hs20+6EKc+d2HIEm7z1qlNoKGNNliK5HWZJEKphvpqJ0OmlH1HikxEjAnSqq7581HYS7nTSk1lIxBsctiWQo93d/foiaErHduOagAZeZhCfY+SGu9jFN7Gh+xCMtbpCuW568A9frujpAq/dq6khUxSMaqxlfIKrDUiua3p8St6qrDxBueUdYMn4wOzZ6dBeHfG9T64vqY0W2O6sINL2tKd1jl+DUJc4ZyctbIO9KZHTM8FXx8fKguHiASm80wzgl3O0+AQ1vuIvay1UQfb0f+DOTnFXdnQ7C7tB7E4c4qTXWeZdWTP460yNiLMgi5tBngiZ2kS517pZZ01vjRJzkyZO/N0DntGdPyIvBmFc69VlNsjvL3xDPPMeoDNNYeMqVcW9Bf3PnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(4744005)(54906003)(2906002)(110136005)(66446008)(64756008)(8676002)(38070700005)(5660300002)(55016003)(66476007)(38100700002)(316002)(122000001)(52536014)(4326008)(53546011)(55236004)(86362001)(76116006)(66946007)(7696005)(186003)(66556008)(6506007)(26005)(71200400001)(33656002)(9686003)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?5Tu1J6CHmo2efg+XJks3K7lDobWFh3T8SaeAkPbAjZFbnOtzvIGeeAeN+QEa?=
 =?us-ascii?Q?YfexgOwYroMmipP1qVC/l/ptsjtOKDyFAjU8xL9igyjxNsXuVxlHdNdR3x8V?=
 =?us-ascii?Q?A5RQmoyPOobUvNmZPK4kAjz8CmX8eXKWiRzmoDV0Rjj7siFZQ3do2q+MELd/?=
 =?us-ascii?Q?Tz56avDxDj/T0q0JvSonWBFRw/GSviZsoP6lddG5kBmnLkfbrdgw1Zenv9a+?=
 =?us-ascii?Q?VDxd0pdK2B8ao7w4s4JX7BP9n80/H0+56eHT4nSZZ5I9WqsXYh5ubyHCGC5d?=
 =?us-ascii?Q?lgpxqNRAyIasE/chgVZohFd8IY6/rqUHwhM2Jkxs/ZtGlMsLX+EofIklcNkK?=
 =?us-ascii?Q?MBzCbAwVK566UEpHDGyz85PXoT6zy5iqgceQQNQnX4ia9DahMqYPVA/x0Qd1?=
 =?us-ascii?Q?Sd0Cmk2eT55lf04oNb+OBcnLcVNxV0mrZeEdQaUPtqDFGG4CVNGGIZ976M+C?=
 =?us-ascii?Q?E6ivH7hZMrkxESnc3o0jn5JPRfxrYrgeALfBjJdc6C+uBv4KEYvN/SqYfYpf?=
 =?us-ascii?Q?McoEA77YCfUlppFcZGYUX0NEogx5QDWJ5iX654e+wUQNrQrw1YbcYUtflGk1?=
 =?us-ascii?Q?DkpzxdLeL1SI/uFd+DrmH2kC900njTS6MLig9UABAjg2o46H007ibAI6k7iq?=
 =?us-ascii?Q?F6ACVO6LU9TusyIc2wrZYLixpdYR+zoYGqyODuPRAA4GoKMMTmRLyRZfJw2L?=
 =?us-ascii?Q?3lpKc/XCXzXfc0PsyuYFku8UebvEjF/dRfn+DrzwYSZ5GPVGfgNqsaqjL3Po?=
 =?us-ascii?Q?1wT6v9zYDf909LviAPyyW8jgL7VjcvP8IHsqv6RZl/8YC2ZZD+zUR2VGDbab?=
 =?us-ascii?Q?sS3xgfD+LI2yjPmWSAhFEOgM+42TjCC+6yXd6/2yr83WMvM7hB0UvOZS6D/8?=
 =?us-ascii?Q?8/Vh6Tv0QZu72X4j+92z0B8QGU1s1L8jQkQXGLlG38D+ciXXMAWZto7asDpE?=
 =?us-ascii?Q?GE6EKToA61FRjupqW6rwzXmjz/HFagAQmLMD13AEPcM9eusXRviAjltFQU+l?=
 =?us-ascii?Q?UVg3ERjbJlX4x9xZEx9Dn5gqOhBkUlV6CZPleAssK6vOFjYXzJQDoVquK1Md?=
 =?us-ascii?Q?Kvv3WAFGu7xtRb0YguiNOxJ0+VVuUG7HDO1wXMnNOZxpEM11xUiQItJJHEPc?=
 =?us-ascii?Q?yw4/KhgTwXPzFgflqzuHDlQDgMiTB4VqpR5UF0JAXMpGaHr6Hdg5hUcHJDWB?=
 =?us-ascii?Q?7kIIZyQfsjt90dWNrzPu1gHA4pgPUe4iGK/2Hq9t4BmnNsZznGReKZUifOIL?=
 =?us-ascii?Q?oA2vFpWIXA00MCGKpDDCGWxu/ogeQe5kzwRXc7RoAq+SoWt3xDn0sjsPTx5l?=
 =?us-ascii?Q?JlTg5B1DNK8DeYciklOfuKGErmZw617KrYpFPSXEFPiqrWwM+5D+CNf6urHI?=
 =?us-ascii?Q?Z1ngeG+cBUSGfAMQtV30DJqR7UT9jE0T3LoWNweAONoIjSIaBDvahojhJ0qU?=
 =?us-ascii?Q?yYeWbSTq7gZ78hYjUcQiRCp9ZATWqGtPKmePG5JLZbyBBVocCSa8jf/rkK0G?=
 =?us-ascii?Q?Zk453vJT3IRuzBiuh1kA4wrBs3BBJ26PqEhuBS3YXfVXa2Dy4ijE2ZAmjV8H?=
 =?us-ascii?Q?JOuOpVuITulIxgrg40Wwat/ddxec2O70Jccb7wurcmtHiKnwugZzKGplRZzZ?=
 =?us-ascii?Q?5FS7/0LTv3wAbTAAcZSAa+M9wPUEh++AJwoWTDGy7M2unF/O9lKz9UF13QWj?=
 =?us-ascii?Q?9Q8i6efRtlvcS/JLqbPaOBFA60Mlxv2EBhS/YEsVrt1X4qNxC/rk3tmcDjUM?=
 =?us-ascii?Q?24V9pp07BMs4VjNuS7YJIV7/F5hZIpo=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: diasemi.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB9PR10MB4652.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ba0bcbb0-066e-4ca6-5020-08da10976900
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2022 08:46:11.3143
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 511e3c0e-ee96-486e-a2ec-e272ffa37b7c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1b7lIMTr8vX6pkteBCMv+8JPmsLiUbZCbtgGJYZuVNWWKatQ2RXZNfHOA66cYnoIl/wZFGK9W2/ND0V0yOUJIN7liG/LmE45i1zYMU+zWto=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR10MB5627
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25 March 2022 17:13, Stephen Kitt wrote:

> The i2c probe functions here don't use the id information provided in
> their second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
>=20
> This avoids scanning the identifier tables during probes.
>=20
> Signed-off-by: Stephen Kitt <steve@sk2.org>

Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
