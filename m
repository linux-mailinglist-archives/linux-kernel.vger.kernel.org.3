Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA07D569BE5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 09:43:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbiGGHkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 03:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiGGHkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 03:40:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D839E;
        Thu,  7 Jul 2022 00:40:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657179613; x=1688715613;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5NO3y5patT1FEHE/7bEO11/EbpsuhnURFOyvCi2Gl5o=;
  b=lorCI3PZdEqQXmZuMsCJ0brTPuLWCDjqTblhpgaS1SCNsNiiWg1U//PS
   SqjCEiKkV94oTeVZK4usVIvEvGN/OJ44qO9zbWsHyKypwvjwzHVd5iF+H
   YzLdJ2AHDFd+FAnsQ5x+l23T8DMOo0Q5xncNsS12bjsETjOfpM81nnwDE
   4zRxXfltQq4G/O37d3C1qP9du2VSZ+wJyhNQhKWEzngZIXHn00ablkvhA
   eBwQgojT09m6yNiclAQNcxfiaIICBffI6ViGqs2ILKwaqkDquKfwZvMMt
   EhGbBWBG9lHBq/1ny7lxU+Yx+IQfM4EbEe0N7bzUuYmp/0vI8Um2fdpvG
   w==;
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="163703973"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Jul 2022 00:40:12 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 7 Jul 2022 00:40:10 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 7 Jul 2022 00:40:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CzGHRYkzaMjhdYRN0ZMpYm0K2VD/GLhSwVrjDMzRo0iA0Q+rHAGpJBnCKr4hheCWXCmxy/ELL8pdlnHfgfyuZjub09twKNr8NNyxW7N6K1DG49A6DY0E4xD7uFo3ewrHk0NYdMLkQ8+sj2xroixR5QuIwPrm5sqnIzz6qN+Cns4SZ+OK/svnD5+Lc+lkR8qNw1gcSHuHshcytJPqxe9ok2U7IKWWNQV+eJxWbxYVXF7XzFeXLEOrU6Adw3/0Xj0omSjuQoCvPCkqtKu2X8uQLEfeqA8bx8ioQIFx9JD2lehLrYz1v8VyAX3OdkJLonaH91tW+K/XV+pnx7Yz/ILMPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+Q97bVObQZE6yyMFhd63kqDb0CyICs4xNynJYn+cMkA=;
 b=GumrSj35s3JzaZropr5hRIX/em/EuRc+XdxUxzIIluTKUa1m9MnJBFFL2RDtcFwk6SGXQnwm3Vi6D6DQxDl2JJesKwG/3LOyF3FZJKS6xYy4/ltuLBMeWSCTW6VqPaQQrwxmLmBfEBXVPOv5jbgidKpQyd9MFpB01HOnKXHvwuFrnf3VN8U0ShK8MbUp4taOvb1+ogGGsbbk7vRRKlenT/4iuIMyneGtzlShKprpdMjW9fKbRgB9PTplv8Uq7UeQhGypHAUIYic2fA9yoq3WScO79nd43kujyu3ulaIhw6bvKUb1C3RG0+IDOUL4TlyDBk+TgOin29RW54ykqvvpfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+Q97bVObQZE6yyMFhd63kqDb0CyICs4xNynJYn+cMkA=;
 b=OJNFXA+YxtauXIIWUsbWXbKPpSv7VC6ICt0g4bc+JQToiE2mW9QTKcooxIsihulzaJ+ldnLG7RTl7bAq69J5RH2PN/NA4GBpGEPx7RHb3h2pFyHjXQdk6R5MchDVb2/R90MP6SQOET5z0hOnrk7bth8d6GyX3ol66sfVYk5E4f8=
Received: from PH0PR11MB4872.namprd11.prod.outlook.com (2603:10b6:510:32::18)
 by MN2PR11MB3648.namprd11.prod.outlook.com (2603:10b6:208:f0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Thu, 7 Jul
 2022 07:40:05 +0000
Received: from PH0PR11MB4872.namprd11.prod.outlook.com
 ([fe80::1884:3ecf:a6c7:c2cb]) by PH0PR11MB4872.namprd11.prod.outlook.com
 ([fe80::1884:3ecf:a6c7:c2cb%7]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 07:40:05 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <robh@kernel.org>
CC:     <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v7 2/3] dt-bindings: mfd: atmel,sama5d2-flexcom: Add new
 compatible string for lan966x
Thread-Topic: [PATCH v7 2/3] dt-bindings: mfd: atmel,sama5d2-flexcom: Add new
 compatible string for lan966x
Thread-Index: AQHYkSi2d8vdUqQCqkCL84gayHBxnq1xaxKAgAEZa0A=
Date:   Thu, 7 Jul 2022 07:40:05 +0000
Message-ID: <PH0PR11MB4872E0DBEC7B10E550FC33AB92839@PH0PR11MB4872.namprd11.prod.outlook.com>
References: <20220706110619.71729-1-kavyasree.kotagiri@microchip.com>
 <20220706110619.71729-3-kavyasree.kotagiri@microchip.com>
 <20220706144303.GA7885-robh@kernel.org>
In-Reply-To: <20220706144303.GA7885-robh@kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 670537ef-180c-46ca-47db-08da5febe8c0
x-ms-traffictypediagnostic: MN2PR11MB3648:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PM/rnzqF1zSdFEVghyqRYiCzLKQ1c3Qklz6PsnNs6uffcJPWv9fkxSkwTfzh9TxbBlSb4vmJaiFXj6xn/aDKAmxJoRB7Apx0UQymNgVMETGMh+C2nqyiBWVa4KyvF93+j27715iKPBkg8FBhodIs1GInCwacuFoiBgPBKs0JFH9nQNnLCATwLSGpd6TvRchbi4n8wQmfkY3+m3oYPVZIFX8wtkjkuBdj9s8bFYyB70IMpmW6Urjindgu8/nK7pGpCsZmutABRv3Tv3hIDVAMpMQt7KvEGZi7E4BbVBx2HhMiJxeGIgON3KcQcaQWidhXlm4Eaq9i2PHrDj8mz5aNNQiaI8ICqwdJX51S0/70A4Spyn/NFCrcKxBBS8OxXyDQHqAIa27XT2W9uWUFD90wMr0eDvFm2LxUWf0/ilvAt/Ir5O7TJMLgUtTdxU/CrTNrq8Vn+R97D8x9cA4eMnPCqWBJXHenN8m8WH6XAM0EfLSO0bWq3/CHfY7yiQzuhXACWqMi5mQEtUjhTemf/HDtWmwWb3zBd93JIOH5KiwZbNmVvN/AQxKLFMOUOMZxHG3hWYbIxGy65b8QmHqkNzrFIMSn3Xxe9EmfBNU2SMKfKGKLGuGxeKiweS2PAXLEXXd/ZyXHG5po9h7mo8fziQHS3F/R3F9Ct7UfyWPlw1gI+QE2uxkwy7n0kxh7R6riDu1eiN6e9PT1qDv+USoU5/k9LfbuDqAZn8kEOhey0JKjUmboLyX8vByRFlewfn4VY+1H8m2G033KUvsbNtpJKHj7PbAyGc4Old9mmkB64woG1DG/vsfGqZVLIBVhTF3K5Phg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB4872.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(136003)(396003)(346002)(376002)(186003)(38070700005)(64756008)(54906003)(83380400001)(4326008)(6916009)(66946007)(71200400001)(8676002)(38100700002)(55016003)(122000001)(66556008)(66446008)(76116006)(66476007)(316002)(478600001)(33656002)(8936002)(5660300002)(6506007)(86362001)(52536014)(7696005)(9686003)(26005)(2906002)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?BwZrILSjY2YHRDzVGXqFdrP4XqX2f6EW9KNXIAQiSJLT9VfUYi0QrofC4nYZ?=
 =?us-ascii?Q?6F0/NhtdT8MrieG3KJOGVHPrmXZ6ucXwz+NJftLvRiPh/YdBNUff5mP/FtKk?=
 =?us-ascii?Q?BScjlvtuc+zinsKOt2Xt1EbUrPnyQZXrydGctEgQhf6Clrc+4BHaiHKx+My5?=
 =?us-ascii?Q?NPslIlJuAjGN2gWweMwV8bPL2DmdZ4/HUNk+Fsd84P8r/UlPJJDKYecsdwau?=
 =?us-ascii?Q?9h0MgPQtJKLKySR4aL3aDOsuL0YpSGVXQDh1/X6ZTcg2hhtdg6qoRHocLjCV?=
 =?us-ascii?Q?+5vhtx6pZPpfD6y5W+CiQGldwbTJO47qUN9+4aXEblPAi+K7p/OLqe2xA4Ut?=
 =?us-ascii?Q?0tKLzom98m2CccLQ8B2i163as4BiGocdisuIcoz0ufHSEMWQyfAnWXLL6dhi?=
 =?us-ascii?Q?QalJfpqKRv/y05OSTnfCY5KJuTWplyivWPtXd4KXQZb9lRUN+BSlHwtU3HU5?=
 =?us-ascii?Q?dAB3VxYu/ejKTdc/OJ+/UiB0of2/vVql2VX19vbc9UtjMluEGCBqWrhrzw2Y?=
 =?us-ascii?Q?HaQeCCN8DEZT0/JOGooHm/tjNW3yOp0Gx3pjkmmrMcrf7Wyt25TR8g7Y6BaN?=
 =?us-ascii?Q?BVu8oWFFdgcraUm5G9N8u18MT/tBjLEQL9Cq/Q4+J3EnUwsH6pYNTdGNBGkr?=
 =?us-ascii?Q?BoAPkv7900TSARaqR94CZQt9eB/b5096+X6X2rOlElNQ2ddH8hAesA3HDNzm?=
 =?us-ascii?Q?3UBQC+ODpI0nZj3pSb16qsHKAD0LYdAtd3zll6dVtVoxGl0ZTuiKgO9BgK+x?=
 =?us-ascii?Q?DMaGjCBNNQzzifOZ0jSAvZGWUjc2Zwt+Fyfk2p69uqSkzyeJzrWr6w281Af1?=
 =?us-ascii?Q?KZly/l0Fe71JA1YIW06JTlWriqHQP+Ml2vGpNnb/YzXeUKo2pAtFU18/lbPW?=
 =?us-ascii?Q?IB3XaIFE7Po6XCN6EVbYsDz1BX/nbKYEeOVdBgLKV2Uy4hupd32cdOqwtvUC?=
 =?us-ascii?Q?PxmIWua66eqRixgy0mXMkdgCkIt2KeGW/YLbRbUl1HvSaYVVG6tAMFlxeCRT?=
 =?us-ascii?Q?151CRuRZISpJFE9+/JOwxFE9LW+iB5I4gHw6hgp97IpSHbEX+rDuX5QnHwri?=
 =?us-ascii?Q?6MX235N9IU51Fo2GiYnVKLsHWXc5XqBBjB8H5E+vipw87U7BlmuK4wnJWDyF?=
 =?us-ascii?Q?98LVsOgIQbpuCVUmhSJ/9WA5zHi/U16G4qc99mYozDMC/Ffd9fVa7yUns282?=
 =?us-ascii?Q?eTpt/Xbat/aXF9ElGNjork7B+NPr65wMbKAQ/UZfLER2zUmM1FVbS4EP2AqW?=
 =?us-ascii?Q?gPvnBLxL6yV7P1VSbSQWtKV+p74+Wey8SBsmny69mIXj7I/8cWzf1orE/VVj?=
 =?us-ascii?Q?uQWigs52wkWS9YI79IT7rAuz0gtrpot61KyhWxt89st2WviFtyDK2aUE2hi6?=
 =?us-ascii?Q?ixIpArgks4ZtExxobMZDQMv6bGK6RU5QFAp+/HC8fvjo3IAfL6We24tCZFRu?=
 =?us-ascii?Q?fjPo+Dbrr577yUzsVCKnKkxOa4/VQfZ0y9qTm0ejdTRIHL0yWxtbr06gHAIu?=
 =?us-ascii?Q?F4yBbo7lJ1vla6i7MEM9y5keSxfO73T3S0ytyL4sM97/Ejhz5e3oMf8Fl2Wg?=
 =?us-ascii?Q?tqUul6eecUJdNTLUjedEtS83C1l8TiYVvKJl3hAA6RnoBAZe1HCkMmEDuh86?=
 =?us-ascii?Q?bA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB4872.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 670537ef-180c-46ca-47db-08da5febe8c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 07:40:05.3059
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /vyZQ8NEB9FDIS7/wPdszqZo74zRA/6fSJzaMiS/rp+ZjeqYHn/4AVEp6vkXJeDmJAjDJK1d47YLk+L9tNw7nEnjgeFbND7JkCmhQc5iKxkdAvPBjAaJWexOUHbthXSE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3648
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > @@ -18,9 +18,11 @@ properties:
> >    compatible:
> >      enum:
> >        - atmel,sama5d2-flexcom
> > +      - microchip,lan966x-flexcom
>=20
> Don't use wildcards in compatible strings.
>=20
Ok. I will change it.
> >
> >    reg:
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 2
> >
> >    clocks:
> >      maxItems: 1
> > @@ -47,6 +49,27 @@ properties:
> >      $ref: /schemas/types.yaml#/definitions/uint32
> >      enum: [1, 2, 3]
> >
> > +  microchip,flx-shrd-pins:
> > +    description: Specify the Flexcom shared pins to be used for flexco=
m
> > +      chip-selects.
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    minItems: 1
> > +    maxItems: 2
> > +    items:
> > +      minimum: 0
> > +      maximum: 20
>=20
> It's not clear how one uses this. It's selecting 2 pins, or a range of
> pins, or ???
>=20
I used minItems and maxItems to represent number of entries allowed. Either=
 one shared pin
can be mapped or max of 2 based on pins mapped on board and 0-20 is allowed=
 shared pin numbers.

> > +
> > +  microchip,flx-cs:
> > +    description: Flexcom chip selects. Here, value of '0' represents "=
cts" line
> > +      of flexcom USART or "cs0" line of flexcom SPI and value of '1'
> represents
> > +      "rts" line of flexcom USART or "cs1" line of flexcom SPI.
> > +    $ref: /schemas/types.yaml#/definitions/uint32-array
> > +    minItems: 1
> > +    maxItems: 2
> > +    items:
> > +      minimum: 0
> > +      maximum: 1
> > +
> >  required:
> >    - compatible
> >    - reg
> > @@ -56,6 +79,31 @@ required:
> >    - ranges
> >    - atmel,flexcom-mode
> >
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          contains:
> > +            const: microchip,lan966x-flexcom
> > +
> > +    then:
> > +      properties:
> > +        reg:
> > +          items:
> > +            - description: Flexcom base registers map
> > +            - description: Flexcom shared registers map
> > +      required:
> > +        - microchip,flx-shrd-pins
> > +        - microchip,flx-cs
> > +
> > +    else:
> > +      properties:
> > +        reg:
> > +          items:
> > +            - description: Flexcom base registers map
> > +        microchip,flx-shrd-pins: false
> > +        microchip,flx-cs: false
> > +
> >  additionalProperties: false
> >
> >  examples:
> > @@ -71,4 +119,19 @@ examples:
> >          ranges =3D <0x0 0xf8034000 0x800>;
> >          atmel,flexcom-mode =3D <2>;
> >      };
> > +  - |
> > +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> > +
> > +    flx3: flexcom@e0064000 {
> > +        compatible =3D "microchip,lan966x-flexcom";
> > +        reg =3D <0xe0064000 0x100>,
> > +              <0xe2004180 0x8>;
> > +        clocks =3D <&flx0_clk>;
> > +        #address-cells =3D <1>;
> > +        #size-cells =3D <1>;
> > +        ranges =3D <0x0 0xe0040000 0x800>;
> > +        atmel,flexcom-mode =3D <2>;
> > +        microchip,flx-shrd-pins =3D <9>;
> > +        microchip,flx-cs =3D <0>;
> > +    };
> >  ...
> > --
> > 2.25.1
> >
> >
