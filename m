Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1A158E00A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 21:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344679AbiHITS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 15:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348561AbiHITRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 15:17:03 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10082.outbound.protection.outlook.com [40.107.1.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D78442C10B;
        Tue,  9 Aug 2022 12:10:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CKmI9pwVWIpne97GLF3tYwA7ru/BPxptcJ+SKBc9ax0FZsybQqGyI0TdbnNO6VudFioViAqgk0AHgl+tcQQ5CM1MercY/2x6AL329/jlQorFmZLBUZbQF9TOg37ZrO6Taw8qLMLfCEYlK7yVVFRZTnsZObtQqCQ+37R2wzzB+ZTMwyR70Zzu1ZO8ThjBURYUFmUFZxsAm26mho9edXkeD7oNTfpRYDXEjg4mtlFZI2g4bomCNfnPtRiBe2FFXDwGSg6Gmy8NnXZHRvOH52UOfStBe1aAV/zX8uM7eJtUa4NouFGHqmqHIGgoiIUq86VdIVOwEpqjC33xZtPcVepbkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvZUOVT/+f6VK9QSBpgOueBibD9UsD+iOGlOJ6a41hY=;
 b=lre8F59AsE6HqYExt0MF6dSBFDDAJjPEf7x+sKCitrY6N9ibJm8jwdZ+yYEeWsr8qTz1q1eCYPmamCIrfDHpJ66EsmPsQOY0DIvWI8VII6U542wIt4uXUoEm3UZEs3Hna17vRCiWp/NhNQDVuoBOtew6/vIDlzQWgp6soO75n9YTF2OejKQxzxJ8MZm8vY5cA/uLJt0nkff+G9/P1+kL8y1Qq42NC/d5lhA0dFu0wt9YLYrNpv5EIz5ST9b8B8j11dPG4wUkMkYA5x1RLhevlJUyltme4Kmwx14rD/Vu+CsaQyPY8Rws/Uzffnea3EmmL3YHevNAwv6JXSm1uVI8Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvZUOVT/+f6VK9QSBpgOueBibD9UsD+iOGlOJ6a41hY=;
 b=AZWOXOyhyBsQeH+JyzPy1c6GX6zwInoVTJfdemsC3e2PW+gy9PF4EjTlWiouqPmoyCdoKFxPCMNoPa+oNuYVyvLisV1xZD0o9xu24d3Smb5iPnXquD2/B3C7A1fIqAxGfu2DPONtIpp+IiPv08F5JO2jApMInt+QyFrD5btRlJk=
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by AM0PR04MB5346.eurprd04.prod.outlook.com (2603:10a6:208:116::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.21; Tue, 9 Aug
 2022 19:10:34 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca%5]) with mapi id 15.20.5525.010; Tue, 9 Aug 2022
 19:10:33 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>
CC:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [EXT] Re: [PATCH v2 1/3] dt-bindings: gpio: Add imx-scu gpio
 driver bindings
Thread-Topic: [EXT] Re: [PATCH v2 1/3] dt-bindings: gpio: Add imx-scu gpio
 driver bindings
Thread-Index: AQHYq/y3hjQZyrerhEOc0N3FD1GMnq2mu6cAgAAzTFA=
Date:   Tue, 9 Aug 2022 19:10:33 +0000
Message-ID: <AM9PR04MB827455A25D76A21D1CAB6D3489629@AM9PR04MB8274.eurprd04.prod.outlook.com>
References: <20220809143105.17967-1-shenwei.wang@nxp.com>
 <20220809143105.17967-2-shenwei.wang@nxp.com>
 <5eb4d4a0-9895-dc0b-ba6a-ac435674892d@linaro.org>
In-Reply-To: <5eb4d4a0-9895-dc0b-ba6a-ac435674892d@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a62006c0-f4df-4b4a-d77b-08da7a3ad56b
x-ms-traffictypediagnostic: AM0PR04MB5346:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6MUpcGmV1CEyCCQoBFnhNK2BtD801DDa+PBlSnncquFO17G7JZw9u72Sc1IZbeR92wo3KhBTcZpRKtc3fqtEvIqHAdoMARkU5ugUjuJHn/o81hFlIKt7nLqy6VKCndVqdGTSDQW477JHiybU90guWCyLUXAMwsYXgUyPnebdvfWhHxeoFsbt0qKkC8vvgXqf3yRu/rvmHH8OsNfMxYKbbW/vzCEgqCJup3Df3a7MpXG90FETAj74UeFqfLwgUkUy/7FJ4DuNavRmMpBhOOPL5ZzLqya1EeCA+EoQVynFnuTA1d4h9eO42ThhjhCgoSnw4z1sskh1UkqCNsslUklVAAhFSq0pFATl5P1c1c9AGWNUF/asQ25QIxGu5+4kMX62BOylNEeidFXU1A+i+q0Z2bXQGtqwzvGh5y3scYMTqvULuICGUNMZUifCoAzv9pISRFcGxirlZG4YUQ9O/baxgTaZttXhufkIalNFt7G/NNSo9QepPEthGTFwj0un+EAIBej2TWUSqCP8x7YfpijDJcW/2xeGbXSrFfhkbyshT5rDX2bXdI6i6vuJvXK68amUX2YzeaT4R7mIz8HKWxD7QNHyNJTDUIueMqhV1uWzLwgOaQ3QLnvc61F1yviOzrEsoqgAz/+caBlSXc8aG7ckicHZCh9frx2S4kvw1VO6FuQEiYGEZ8PDAJMfSDSm5MEqctSnsp0HobxNqDjPHOF54xdan4uD2XYe18oELpMwxscAUSdYsr4IQt4ZZudUT4g4ZaN1A3OKqi8nuKc5Fef8TCwk4sehfSvZJ01lm80lboTwhuHI+l7dTVyQD9lOVXVsxDKHjKny8BaQVujRmWNNqg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(110136005)(6636002)(54906003)(478600001)(316002)(2906002)(71200400001)(41300700001)(55016003)(64756008)(66476007)(8676002)(4326008)(66946007)(66556008)(66446008)(44832011)(76116006)(5660300002)(52536014)(4744005)(8936002)(7416002)(38100700002)(122000001)(38070700005)(921005)(9686003)(33656002)(86362001)(186003)(53546011)(7696005)(26005)(55236004)(83380400001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?P13Z1HT6VFc6CVGkGT96KcnDhD7qHcICWFoOOZVQRqcWUCqPo7CbrZjGqZcu?=
 =?us-ascii?Q?1Bpyx7Kr9x34noSYqAFFkInItUFpf02PJLFX45Ir0+WPcjOJ/LoJB3oSHXfl?=
 =?us-ascii?Q?G6ftn0llnrsvyFz/QGd3M3hv6a+p4nCuGKLBGHCbv8P4xAGQuAiw7/sF3IUE?=
 =?us-ascii?Q?aRtSe6UA3VAodbsHZ9Qh4yaKNPOQuk1y5XlIf2mcFoR1uMXo8u/Y4nKIqsgr?=
 =?us-ascii?Q?IzDmZ0fr0gMtGsKyQOsZxHMXKP9TAsCGWc5e+LKQy/MlNYCAmLV4IDMVgkW7?=
 =?us-ascii?Q?Iw0KJYGVrKe8KNMkIenHGa0fDGB+7tgAQC2lN2d1UgqGgdHbHI0SyynXXQFH?=
 =?us-ascii?Q?PyZVD8awaExBAiUHxNiht5SswFTYadYHTsumbs5UI4RiRkA+3QiCUsux/pHP?=
 =?us-ascii?Q?1uV3CjfqzM0EiRMNDgRxppCmHU8xydted6+pux8qiI7OLOmTMohps17foG9q?=
 =?us-ascii?Q?XsOQFv9hdRPyu4rAw2fDpg02FhJFylG1DFWYejsypRCmzON0+LE/Wj9ei7KE?=
 =?us-ascii?Q?UK5RWI8gKxAt8eQViJR8vB8yE++0aHNAdJ4rNv+5TXLxQbkitvS7/1Wk6Fmh?=
 =?us-ascii?Q?dW6HdqIk9dXuG0mqaE9T3aAHSYqlwCtbPkjsiUyIaQ9WPqb8UiejA83p3hJy?=
 =?us-ascii?Q?jNi7tLUcPwifNYyc/JjtP/Oey9B0yC+R9SOtM0NVi0dvqyhHLdLe1U8jriL3?=
 =?us-ascii?Q?oqXJ3g52L5JgbP5rq41SmZfPpV43li8JHpyBbzSsr/DV6HUsg1wK4hHSjQUG?=
 =?us-ascii?Q?C4ualbCN28+7L8pTfyx/nw3l6sdVdHzx79S38/g0nPXNi70iJmsXxYYqF2GO?=
 =?us-ascii?Q?/Ii1+LI+9osRnKifv7pZDFbsfSKEq7AwooN483IksQQ88GLsz/1vkxsQI4FW?=
 =?us-ascii?Q?amBPxtGR9DU8cNq9zNX1lTdzZAbRXfFVRQGJSmGXy2wo8jlVNig9y5usA2SE?=
 =?us-ascii?Q?berLS8K4BvTtD/Ch2wEawYHjIE7U7cRdX4OARIMzYrc9DUEaV8Mee2/ZRli5?=
 =?us-ascii?Q?BkrMa0VPTBiMSBs4P9KQsIrQ7HXJA0xnz0jShgO9mm9Y7lBH2QeIe2AW5BvP?=
 =?us-ascii?Q?bIpZOvgp/4K8gDQOqfHg6Cguv5D/w+cUZ7w5EEQi49DloLBajGvYGXVbp1DG?=
 =?us-ascii?Q?s/QUci81VRniQWyvKkBeEQcu1yq04x+CIf3WZ/Hi63k7mXnw8zfq5UCnB1Bk?=
 =?us-ascii?Q?0WF64fcm/X1VPLiV/3QaT5i9/dr7jXzxIPSOqEQT6S3thrOQrK0okMYKR8JA?=
 =?us-ascii?Q?9QyB97Sj7NJq4P4KIDQDb6+1sPJCG9eYAY2+uLhm7Qu8JJ2gQzaNVl9teFn1?=
 =?us-ascii?Q?vmRtUsL1V7CgfvexEsGJ3webXdMlrURRHPlpMAnbxiuA6K/ZeEMJzqdTa+k4?=
 =?us-ascii?Q?ayz46j4hql5cDu+IlXDIRiVONdzMYl4mvoCigTefW3CcSGc++9lG8WQyxGov?=
 =?us-ascii?Q?roTCyJO5o8dz0+7MikNpJYrzy+0QPkrDVHC4tHLmgANeCCYYnhSXkKpgQpKM?=
 =?us-ascii?Q?kI5W5Bz9Sca7hwVtv1FPn5Hm3DmJQFPvIM/uqKeds4TR3JAOOuRk+ev192n+?=
 =?us-ascii?Q?nsDGS5uNnCDLTb1ENbqvShXdaZAs2PWnl074j5Bs?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a62006c0-f4df-4b4a-d77b-08da7a3ad56b
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2022 19:10:33.3027
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C5EM+d3I4ilD+7+gdyfiTELfnoOfVRqoDmihTmJ1Bvo2tuAmBZ1UYp18i1MVb82XeP3uzPqiJx3VGqqABJm7lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5346
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Sent: Tuesday, August 9, 2022 11:05 AM
> To: Shenwei Wang <shenwei.wang@nxp.com>; robh+dt@kernel.org;
> krzysztof.kozlowski+dt@linaro.org; linus.walleij@linaro.org; brgl@bgdev.p=
l;
> shawnguo@kernel.org; s.hauer@pengutronix.de; kernel@pengutronix.de;
> festevam@gmail.com; dl-linux-imx <linux-imx@nxp.com>
> Cc: devicetree@vger.kernel.org; linux-kernel@vger.kernel.org; linux-
> gpio@vger.kernel.org; linux-arm-kernel@lists.infradead.org; imx@lists.lin=
ux.dev
> Subject: [EXT] Re: [PATCH v2 1/3] dt-bindings: gpio: Add imx-scu gpio dri=
ver
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - fsl,imx8-scu-gpio
>=20
> This should be rather a specific imx8 chip. See other imx8 SCU bindings.
> Strictly speaking there is no "imx8" SoC and compatible should be derived=
 from
> SoC.

Make sense. Thank you very much for the comments.

Regards
Shenwei

>=20
>=20
>=20
> Best regards,
> Krzysztof
