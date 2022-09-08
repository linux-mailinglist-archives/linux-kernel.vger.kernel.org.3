Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154205B12E5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 05:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiIHD0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 23:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiIHD0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 23:26:12 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2097.outbound.protection.outlook.com [40.107.117.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45F8890C68;
        Wed,  7 Sep 2022 20:26:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NUjNsVXRMXpEuEN98OneX1MBN85Kog+LXg09DJmPHiv9vdyyT/8MSZmBfXt71gBl9/GNNx1imzKTuOodQK/VCOxOPXDJaarIhz37MOWFnJO7GBaO3oYaDZ4lEKwPBO/arqUWUWXz+Gwpvl9IcnSUphQEXRwUS4HbfB3Gl7DqjHU8b/Ac8C28GD8ligtjD0rYbqVe5vMyFtzK1gaa09LgczPi+MN8rntOcvZsV7SfAOUkTvs/ktZ+mSaCimpubo1CS0q9bSWsV4FxEl2Ba78UUewfjqW4+ffNbDGxErxILelQ01kN8OtilYbl/YvMa/8N7nBUBFFCwkswDKP/BB0ykQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2YbnG1X6Ja3LbZJ5wz65Pp0E0HigoKCAxexfw31unqI=;
 b=XFYOrMiTMPnqWZOa6ltI1ji97yLX3CCpttsyTY9ioqdkNauJvyF1t48YAmU72g+zfwa3NQa6Z55bjFJyIdZLKM36dd5BdFzPNG5pfCQFhuW6aeiraOtGxWJ/f0avilKfWW8SUa6fO89yz/xGjrS/AFXdMAIBKyrNmNxtaVstVd7mp0GVCQHXsQscbqgSJEIvFKey3sut8R+PHwxHLRqQwoOiRqqx4D4T08VTnnJgWgZGE4U8qhBwUlkuRf604AJzyTtAb9q4mkuxVkZ2Q5Qkt0V/pU1TD0hjkrlT/DtmeJyK5/hZwh1gEOLgrYTeBZFVttu19UPYuyzjMrrHj2jvSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2YbnG1X6Ja3LbZJ5wz65Pp0E0HigoKCAxexfw31unqI=;
 b=Ovsxgwk6939nTwGPOkwB9bkXNrsKqaWWZJVV8MKCQKCfcOt1epE+lC61GC82uIXvd0XNG/GfKkZdcGnrkEhkDBWyC446//EEK7U7bKODsllwR3Tx6RbdO6z4FSb0pkCIteiEmsgZ4NIdyBJpDTOUk8XHB5dOfrzxgW1ahWvz29ZczN4vOl5U1ZTE5GS+zPXAkqGwEPBuXAx+HKakhXVfbkn9k9oFK51+2IZ4Lj4gZZmvWiQJTUDXdjcUpIZhiVE5TrTYcibyZ91EzPu2/9O9bY2iijAIxih0aTvuLKkJ7tNug5nr5eMvbrmL0umkmhc+5vu7bgRxxpYUMxCFIbIi/w==
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com (2603:1096:203:87::17)
 by TYZPR06MB4633.apcprd06.prod.outlook.com (2603:1096:400:124::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 8 Sep
 2022 03:26:05 +0000
Received: from HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c44:6fe1:af1:7b42]) by HK0PR06MB3202.apcprd06.prod.outlook.com
 ([fe80::7c44:6fe1:af1:7b42%5]) with mapi id 15.20.5612.014; Thu, 8 Sep 2022
 03:26:04 +0000
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Rob Herring <robh@kernel.org>
CC:     Dhananjay Phadke <dphadke@linux.microsoft.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ChiaWei Wang <chiawei_wang@aspeedtech.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        BMC-SW <BMC-SW@aspeedtech.com>
Subject: RE: [PATCH v1 4/4] dt-bindings: bus: add documentation for Aspeed
 AHBC
Thread-Topic: [PATCH v1 4/4] dt-bindings: bus: add documentation for Aspeed
 AHBC
Thread-Index: AQHYvpFQWGemIcDpzUOpE+PtjZ1bGK3Uec+AgABuMXA=
Date:   Thu, 8 Sep 2022 03:26:04 +0000
Message-ID: <HK0PR06MB32025230C219AD97D39537AF80409@HK0PR06MB3202.apcprd06.prod.outlook.com>
References: <20220902060012.3758637-1-neal_liu@aspeedtech.com>
 <20220902060012.3758637-5-neal_liu@aspeedtech.com>
 <20220907205033.GA317033-robh@kernel.org>
In-Reply-To: <20220907205033.GA317033-robh@kernel.org>
Accept-Language: en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: HK0PR06MB3202:EE_|TYZPR06MB4633:EE_
x-ms-office365-filtering-correlation-id: 3cc453af-41a6-448c-0d05-08da9149dc99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +nivzF7O9WThG3bIzV34xIhFw+6kN+dg4LjknwPS+oHicYAwttaaml2HcinfevrLtZqHN359MrV/wyFE0pDKNxxpD9SRv8W67UdKFGEoRVYBjtlh8H10//R9l6llg3UOctZrUjDriP3XH0wJNBwo7ZjoUxOxtESBL+Mr6/bVEJmxg0wE5V6mRil9QVS7xiIxhzhtHSw7gtMHrIFIF/io/iW4jBbyG/rEsLOVoT6tKzLl1pr6AUJqa6jMzooj1YTzS3gRiGQPx8hWdeGGmsfIGZ2btdNTC+3N1/eAvmYGpAzN1dIjK98E7kRGlSAM52yk3IHGh5S9dXKSm5zKq5Wh+44luIMm8VqngoD2me/7K5Vmw/EfZ+lMhfr7HsBXZ5/G6eeisCFQrA30O4VKIP8FuYJkTGYo8WQra6QgCwhzfuKQZZUtpgywLXXydI+VV/F/sogK0UwRJ2wp/x75n5pUmq4vJ74XfTg90qsOF4Fmrj0Wh1UgykU+7wlsltIhI07zVjedNYA0MTLawHFNTc3icowC0G6H+iIDuml5EElpflJxGghx7QlvIEeEtUoaOn2LUf3GLSUWtR9Djo4SBDr+NIgU6EKGvtSRleVZPLzwewkCtDVG46Vunf5zrNA8uAcw/p+7lyQTAG2kP65ZuR5QtO7wRbg+EJz5X8GmvGnQIHOiVBw46EXYhZ/H43srKj0GuRmmZOD24aRbCqC7W3TNx89ZvTl1exXjcne9QtQ5h0upDbLRUDl9/8lJFg+6ehMYZodkVXqdrLvj7apWUhCTviqq6oXEATuyqs57DO1IqS5N5z/CV+Id3I6B9+9q0zdOcqHiot8wt4zEYXPuwwIrMg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR06MB3202.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(396003)(346002)(376002)(39840400004)(366004)(38070700005)(38100700002)(122000001)(316002)(6916009)(71200400001)(54906003)(5660300002)(52536014)(66556008)(7416002)(8936002)(66476007)(76116006)(8676002)(4326008)(66946007)(66446008)(2906002)(64756008)(186003)(41300700001)(966005)(83380400001)(107886003)(478600001)(55016003)(26005)(7696005)(6506007)(9686003)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?w2IZd9kln/1z+oCxQvySstIBJHDby30ilf6ZVHsKFM2QlMAcjAFFoDAmrmnq?=
 =?us-ascii?Q?G1Ga+7cBp3NOYYylbTwXfvxrtdlCO3laMZFXWGSLW0EPuNt4aViX9yJWQzKQ?=
 =?us-ascii?Q?fMSkmrSIUEoeVgPvpnN8j4geMF0C+a1ubTHHuO/lJM/emaUDe2yEOodNOH1h?=
 =?us-ascii?Q?sqUPCsLhpNqPCzr03JwsLWkYTuzCTTAhbOLAiye6omwlTNPVNDmIUSHPXFrr?=
 =?us-ascii?Q?jhihD5PAuKLH2/r+3VCBHgwWQzEu+DzQVfQXrnCjzGyINVvnJhCachp3sPpk?=
 =?us-ascii?Q?c7vPSc2aFh0VEQuO5+6xorziuUnwxYe2ajHR7L1EJxBLXsnQIExWcUk+RK/Q?=
 =?us-ascii?Q?Crpb7xInwUzSxs1mcC6ipxEYz+69zmBoVl+5GowlrZ4TlSGKiE3u9kC8k/ka?=
 =?us-ascii?Q?o9aEBE76B4qpy/3qghNzcOYRqWXndxP3iGeqmltJ2fBVKLsJeLrDEV5g75BP?=
 =?us-ascii?Q?1chmpXK7h53uQqK02+9PDYLinks9QAv08wtq2jdt0oobH9XkAgsp1yf+A5TY?=
 =?us-ascii?Q?xBn0PI8DQV73MZz3NWEhPntV0qBhn+51dsoFDsspdCmj4KQM5lrtKNmJ77FK?=
 =?us-ascii?Q?SqcwgqMgolmKYOH6XsMmCO0K2TibczfNuIL7DEVCCd9nY6m+/rdh+/GvrZy5?=
 =?us-ascii?Q?flcO6l6WYkk4m/cY1z3BGGYWWs7euTCs8ZOEYgxbYXiFwkWz0FyGzPC2GjL7?=
 =?us-ascii?Q?uosJIaBC9bxKNC2TKJvboakEwCLbsbNcHMs8i4Ijxuauzi/8bLAES3Rpd6G8?=
 =?us-ascii?Q?xOH8v+qnui59xViOC90ZEVag9eimtF83ouK/XCZf6+IQA2wLGhbfC06irYjw?=
 =?us-ascii?Q?W+QPuDuULiN5i3ft2MkoSq6CBe+iynOeLYJrU4lrsKFzUlGLRdoM9k5njWiG?=
 =?us-ascii?Q?hAJ4cfpSbC6TfI8lcK5QwVz/Qn5kFX+sktn/kAM+/PILkQYJc8Pu3g5KZP1j?=
 =?us-ascii?Q?eYVuzaI55dCKz4sRrabQWux56QH0IiGZUeuNctTPbXfY20beXEtcD2nMauPx?=
 =?us-ascii?Q?P2jr3rY5OwaehDK3m2BVWIKx5D0qbx3wqhH+TQ3yp+nnHGyAsM1AiB83FOJx?=
 =?us-ascii?Q?5BtaMfmRmJ4vvVVosUBDopgsBKM0omX034aTa2YYf+UA6N7BPH1Im621FsyK?=
 =?us-ascii?Q?duD+xzzx+d8haLnVzJ2GoohKZDU1QjTftd6LrNeikmzv8OM3Z3dWsUCjGYak?=
 =?us-ascii?Q?JhyXY+guwR7EPN7V+c4ES/aBFnuN5ONeFYRS7EWLdY/qLSghD9uAK3KMHsOX?=
 =?us-ascii?Q?Xet/+2E/R9W8HZnRK/FxWXJJ6zBqFL8oInRL8Hh2/IjuIPKXtoSk3cL+dICI?=
 =?us-ascii?Q?nqaQCbOGNhmx4fHfn/L3DJ5iiHn7VIqhEGFbuDxbbmdeaPD+/kH7KZogo4wV?=
 =?us-ascii?Q?lKRH9GXCano9ilscBk98iFdOQn8cls/ysyPdqYkNMo0tQj207Lel1MbBIIA0?=
 =?us-ascii?Q?p/FkJw1dQZH22KI9SDyRiwABI/6E0xgoV6QJUPTqrMS0G1J1/oniPjRbQlGY?=
 =?us-ascii?Q?WBGxnFqgvuiswH2v+1NYk3Xovy/aCqDMXvShLRdvgNkEauvEF72sCk4rllU6?=
 =?us-ascii?Q?QEAPzfbsDq5pEbj9Fn6B038aztjBxSEtvmOcVfkK?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR06MB3202.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cc453af-41a6-448c-0d05-08da9149dc99
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 03:26:04.5848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: M3N2is5F9XP3GTgL3okfm5zPz0z+CWBKUJi5TBfrT4b2SAkqGZrqiUkSmf52G8BrXQbXNijC56z+zcJNskvuQw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB4633
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Fri, Sep 02, 2022 at 02:00:12PM +0800, Neal Liu wrote:
> > Add device tree binding documentation for the Aspeed Advanced
> > High-Performance Bus (AHB) Controller.
> >
> > Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
> > ---
> >  .../bindings/bus/aspeed,ast2600-ahbc.yaml     | 39
> +++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >  create mode 100644
> > Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> >
> > diff --git
> > a/Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> > b/Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> > new file mode 100644
> > index 000000000000..ca09eb531666
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/bus/aspeed,ast2600-ahbc.yaml
> > @@ -0,0 +1,39 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) %YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/bus/aspeed,ast2600-ahbc.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: ASPEED Advanced High-Performance Bus Controller (AHBC) Device
> > +Tree Bindings
> > +
> > +maintainers:
> > +  - Neal Liu <neal_liu@aspeedtech.com>
> > +  - Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> > +
> > +description: |
> > +  Advanced High-performance Bus Controller (AHBC) supports plenty of
> > +mechanisms
> > +  including a priority arbiter, an address decoder and a data
> > +multiplexer
> > +  to control the overall operations of Advanced Highperformance
>=20
> High-performance
>=20
> > +  Bus (AHB). AHB is the main system bus for ARM CPU to communicate
> > + with the  related peripherals.
> > +
> > +properties:
> > +  compatible:
> > +    enum:
> > +      - aspeed,ast2600-ahbc
> > +
> > +  reg:
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - reg
> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  - |
> > +    ahbc: bus@1e600000 {
> > +        compatible =3D "aspeed,ast2600-ahbc";
> > +        reg =3D <0x1e600000 0x100>;
>=20
> Shouldn't devices on the bus be child nodes?

Yes, I miss this part, I'll update it.
Thanks.

> > +    };
> > --
> > 2.25.1
> >
> >
