Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB2025B0216
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 12:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiIGKu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 06:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbiIGKuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 06:50:22 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87E1255B6;
        Wed,  7 Sep 2022 03:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662547820; x=1694083820;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=3lBAKPT59/N2vdrvnO1NmtGMUW3wxAlrHb2/1RHEV7c=;
  b=P6dsfMzXWmYnaZqx0FpYVEBK4kWLP2Ob+FyqP9GgteIAg8ePHXSbqVDJ
   Af9+a+fUOKrbg25hOQ7vZOHn4G/tN/PkdIch8pL1tYRfC8JqthXBOUQjV
   OMohHdXYVx1nsv9qRgQIDm4pCDRp3Xe409Cjac6TTss222aiRsjjzkFMS
   QXW+0vdckzLJlN6MaBO0fJfnHfjbA18hNqLOCzq8fjNey2m37vbY66awb
   cyrn/XJtf6mZz81gWbD6wLH4fk/knx1gZw6JMUjnecH4x/3+qfyR8Owdo
   E1yfJF9jDbKA/qRGJmygJColoXpQ6GPtrf/LKthZfktnGh/WY0r2+3qe+
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,296,1654585200"; 
   d="scan'208";a="179503674"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Sep 2022 03:50:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 7 Sep 2022 03:50:19 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 7 Sep 2022 03:50:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K5LTIIH1ePaDDcwlRHUdUljLzoAeduWAIYEGDmP6XsblAZq+aUNdZ1SSKR33vUOBF92NhesZMbkWXunEf+ebuaO8U0U8X+/RN9BB19SeamHcSdykVQv/4vBnq3ZijIo1U+T4Plq/e2RBiFs4N+3RKs+l47QjBdP/oVMmG52nrR1goca31UqKBUD71oSNjXKsCA06gQ0JU8rRLUjDhJPbxVUj3FeJ4KPcTMrsUFbGhq//tl55RRtK9sVeSlFL8J3VIRArqVlstC1fe7U+wgcNMO7lXsy5aYMVeX0z0yH6gElIWM4ZK302a2CbTw19IoxggEV/6FyVm5nEVsDvNPFYuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n/Y7Tsoi0P3krWpkF2XzutMdA286QOIKLW31pZ12lmc=;
 b=WUh1V1lOydS8MZjQm7Wcs/nb4QguTlIRvqoO3qveDOFFUQ/HGNRkWrW27HNnPoMPEKf2rK1QBfPKP3RdjqEwVi7vvcW/m8g45zZ26T8LlIsh/grAZ5Ef2MvD0CymqZdg4dTUmvexiDPw+I8HzeR1wf1ZSvz/MKRNxmiuNEJLrj7ptPRwW6DR6BCKpiU+yp+YBrQ5zcc+rH44hMCCYhft7xKx06e3Busru+tkzlHYrnnvdUVoiq6/uD+rncFp/5kVNrXKdgkS1Q3/LTWUS0NP1L4VNVUsF6UVTUvKzW2HJH32sZ+lWQuQfxgLB8kgcn1YJN3yHgTZxYuqqwMtKIzMBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n/Y7Tsoi0P3krWpkF2XzutMdA286QOIKLW31pZ12lmc=;
 b=d+oD897/TvgwUV+dCEdO1FgYNEAR38qmB/PLN6Iqk5cvPJzqN0x/F0MzSgWMGNB8E/hLHCZ5zR/c/whr+NJ+TatDQVh1NMe2wSO3D8FXtpAcyNYV+g85MF33a9NXj2mLfeX1zu87TRc5x9rBiWsxaUayXqCRzqGvnSULuje8lAo=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by IA0PR11MB7257.namprd11.prod.outlook.com (2603:10b6:208:43e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Wed, 7 Sep
 2022 10:50:12 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::f851:80cd:172b:4b1c]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::f851:80cd:172b:4b1c%5]) with mapi id 15.20.5612.012; Wed, 7 Sep 2022
 10:50:11 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <lee@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <UNGLinuxDriver@microchip.com>,
        <lee@kernel.org>
Subject: RE: [PATCH v8 0/3] Add support for lan966x flexcom chip-select
 configuration
Thread-Topic: [PATCH v8 0/3] Add support for lan966x flexcom chip-select
 configuration
Thread-Index: AQHYksHtcVb2nMUrrUee0+iQGAJuu63Q0lnggAB3TQCAAt2jUA==
Date:   Wed, 7 Sep 2022 10:50:11 +0000
Message-ID: <CO1PR11MB4865D594CABE612A0FA93CEF92419@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <20220708115619.254073-1-kavyasree.kotagiri@microchip.com>
 <SA2PR11MB4874435AC1CAEE6DAFC3F239927F9@SA2PR11MB4874.namprd11.prod.outlook.com>
 <YxYN9CacFm47R/e2@google.com>
In-Reply-To: <YxYN9CacFm47R/e2@google.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4865:EE_|IA0PR11MB7257:EE_
x-ms-office365-filtering-correlation-id: eccef8a7-927b-4c25-1fe0-08da90bebd2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0uI//msJjIwQCBgW5M4oOcwQIQcW/98cXCDxCTgGu3UD7ElE0FQ2d6HtL3DuIOYZIWtvbW7Kp7KTUQq+RR6FrpEz5YmXLtY9xXrKhhCxQO6e1QkFtgOu+9kml7H1jyK3iot9apgpMTJbVFJMj/pa28dZOWkNRtWZtE5Pm+Qoj94geuw41/UPGvLEzPUmDGWmRxEmr77m/Fbb7DYwWVfFdhcoJ0gRseBK/g/oFFp4+ULXHelKoIAe93t6t8x9gy0MvRj2NVBJ7cEzHyQDH+ZFWo5u7FolTGeRFcFzfg57fhceA0wSRMZljGu7u4DDGZqRvaPnyHvRVazmFEvqGYEP5MTDvRWLnTjx1sQgl9pU9zdIzxoB8I+RYAHklp0ffMlwa2zM7Qd5y4bppDKdYLJ5AsVguu6DoUHwoItz9xxjP192Ap4CwkgJyzSBhnWgkBqFU8Yj+vdgMhCo3ENJmoZM4HptbvEe2wFrW9t6BYgUex2A5oOmRtd8U9aDDA/Z9BuV0+U2h+YjndZ17Xibe3o/7Nk9Nah/ReeCsuapXIFJFLisGd5NqtX8dCTnZbdo8AamRU7JPeHkbj4tkGo31QWZXBbc28GPrZEt8qeQvjxmED6FT+zeexbrSlPvQLHp+nl5mDW5v5OshS9ko8vOK34BobkMB5PGh2/UKBdGOPwn93FfH+KYmaRFR8F1xI6hvOJ1zfutHJLS72bQRENFGREpHkI0FDH0q5NQZnPvMBqxWdPcHFGTPmJItSM9nnxZQ0Fb5C2UgcTOBPiLuXzR/z2fQBXVBAUlSod+wfVY9HQSS76Ka4r1wxzFPvbklHsHo3rAptfZh84zRVcRDxRM72gFcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(396003)(39860400002)(136003)(346002)(33656002)(83380400001)(54906003)(966005)(6916009)(8936002)(478600001)(8676002)(64756008)(76116006)(66556008)(4326008)(55016003)(66446008)(38100700002)(66476007)(122000001)(66946007)(52536014)(86362001)(316002)(53546011)(9686003)(2906002)(71200400001)(26005)(7696005)(38070700005)(6506007)(41300700001)(186003)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zdzrRBb5apdMYZRWfa0kkABP8viaDtU3QLwsdqXJil/K3T60U+BiwbRttEzJ?=
 =?us-ascii?Q?7iY0NAZ/85uFA0qjf/y/TLRL4EkQ4rnpkCo8Q2xmTxCdxx9XQ4soCryb63UO?=
 =?us-ascii?Q?wRoyX0y/ILbjRKQIuYQNw/BTKEHTc394JD8zAqaYsw67pYlpvogDnrOSYWuA?=
 =?us-ascii?Q?lyR+ETI3LDZdKSY8yWC+dBuYae4diI2MYwYjg2AGo1osMoEGgvAKw12NyWMp?=
 =?us-ascii?Q?No0Twtoc0Gv6we5kDCE/FjPAK1s+LEyFWiuz767MpHZsxOSjBGqAz3DXwXab?=
 =?us-ascii?Q?dyz2fPEFpRCgyLPtIdojrieLvAzsq3vyR8xVmlXaV7NjvpWIAsKqnCA9OqvS?=
 =?us-ascii?Q?iJoJaMV7bacXB/Sq3gMXYAEcssNIQ5Qwy5OOVlqlgMAQSYtbzvMPd77HDe/m?=
 =?us-ascii?Q?PoGiDSJ5P7gTKFfSSFr0QSdwRHb3lR3JMnxylFtIbraxy7Y3J/xJa4n2ML1z?=
 =?us-ascii?Q?rRvDLVX/4wziPuqvgo/k6TQyLfEq45Y4mCeELRHhy0JygbQ7o9AM/I+9YSqU?=
 =?us-ascii?Q?oNcFpAxDTMvUxkojpFv5//fQYFCJ8+oHebabOyG6RD0G5FsvqI8Nx5yswdZU?=
 =?us-ascii?Q?QBS8bm95N2/apDXVA0QK0Yqf6ygX6Ewc6GJoTLfafRCXpBEc+k8cjEnO4Bda?=
 =?us-ascii?Q?hGktYpvHl3l2IGzyR1/v6c+72CC2tevU7QeolTipGPuV3MzKdbnXjASSUb2s?=
 =?us-ascii?Q?pJ0PCvn8Nd2RyDR3ckpiRtrW6DtXeMryueHwwyuCniWl4dsBzEqf/kUiwpdT?=
 =?us-ascii?Q?YxRztqEd8CwYXdK7gTqPEjWTmvKxl/FlEXU8ykNVqG73GybNfbNbyTVpbdTX?=
 =?us-ascii?Q?AwsqgcWa0yy/O2LuJmoBJjxMDDptxSenigGqYDlfrf3fkHvaeP5owhOgOWXz?=
 =?us-ascii?Q?w4/hKmoQr20ff+h3W2GNvx/a2I0llk0GbAHISMptzwPhPoe1Az+vE5oduvrF?=
 =?us-ascii?Q?qo4P7jornl658JMuTmHvqwIXElwKcOtrTmJoq4aoiWRbdcdobDI+y/tHEg9p?=
 =?us-ascii?Q?IyRKdBw3I+M3M32gIoCZHHh9mT5368/TIR6SUp+pt/k8nXSl0kjlq1hawDMq?=
 =?us-ascii?Q?UZmrkA7JJjZRPLz/Os01UB91FSDvKt+mDKf6qyDN+8gOOaqYPgTqeOctcm2n?=
 =?us-ascii?Q?/bcoP6y22UM16ek71ZzX8SYA4RxNeLcqvRDVzKNAoOmfirq5F7JBIdM3tND3?=
 =?us-ascii?Q?ceI/qzLZ6z8fTB/dIbFmi3nGK+mkjKBwcNBLFuSDQWodtbF5piF8uvE7ps5p?=
 =?us-ascii?Q?FlIAQIJqS+86LjopFBs8E/WoKpBoYUs40tHdbH072J8VIMzVCZSnJsjrc+Px?=
 =?us-ascii?Q?vsaIybQ5V99V/VQit/1ZwvHqodvI0ZdR8hKo0uaEOOjWshaebSpxzAqxrgWf?=
 =?us-ascii?Q?31B9XIgxnITvjaOz9fY8B1SmGBlNfYZxRJtd+1JpfSVyho0CXYS3IrIzEPYQ?=
 =?us-ascii?Q?DCHTvU7x80qzV+SCIWgJ+T65fB6iDda0kXxVlW7sWtBntNm4dP5pJXdh2pet?=
 =?us-ascii?Q?dhKFp3U5xsP2w2ETuEkZxzYuezrfC1LfyiygbbcGWAPsL1ov0Rjhp6elEk86?=
 =?us-ascii?Q?aYSCSYdaCs1PB05z7hwz3pSXGFNQCwOzb64cxwT5UjjkprzqtUUe1uuaAxms?=
 =?us-ascii?Q?IA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eccef8a7-927b-4c25-1fe0-08da90bebd2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Sep 2022 10:50:11.8046
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5VK9lI9ek70YahL6wIIv+aMlG3g11onSs7SWqQd3CXJVscRRWf/b4Rd9s0imiXRsoEBZot0AF+sKAiPiiIW/6EUKyNRgsts2Qx9UgY5HfsiwtWtWPewlKkfMZxmUmuD+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7257
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>=20
> > Hi Lee,
> >
> > Are you planning to take this patch series for 6.1 or Can we include th=
em
> through arm-soc pull-request?
>=20
> I don't seem to have visibility.
>=20
Please find the patches below:
https://lore.kernel.org/lkml/20220708115619.254073-1-kavyasree.kotagiri@mic=
rochip.com/T/

> Have I Acked it already?
>=20
No.=20

> BTW, this is my old email address.
>=20
> Please use the one in my signature instead.
>=20
> > > -----Original Message-----
> > > From: Kavyasree Kotagiri [mailto:kavyasree.kotagiri@microchip.com]
> > > Sent: Friday, July 8, 2022 5:26 PM
> > > To: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; Nicolas
> Ferre -
> > > M43238 <Nicolas.Ferre@microchip.com>;
> alexandre.belloni@bootlin.com;
> > > Claudiu Beznea - M18063 <Claudiu.Beznea@microchip.com>;
> > > UNGLinuxDriver <UNGLinuxDriver@microchip.com>
> > > Cc: devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org;
> linux-
> > > kernel@vger.kernel.org; Kavyasree Kotagiri - I30978
> > > <Kavyasree.Kotagiri@microchip.com>
> > > Subject: [PATCH v8 0/3] Add support for lan966x flexcom chip-select
> > > configuration
> > >
> > > This patch series converts atmel-flexcom bindings into json-schema
> format.
> > > Adds support for lan966x flexcom chip-select configurations and its
> > > DT bindings.
> > >
> > > v7 -> v8:
> > >  - Added back patternProperties for child nodes.
> > >  - Changed compatible string to microchip,lan9668-flexcom.
> > >
> > > v6 -> v7:
> > >  - Change filename to atmel,sama5d2-flexcom.yaml
> > >  - Add #address-cells, #size-cells to flexcom node - Fixed warnings.
> > >
> > > v5 -> v6:
> > >  - Removed spi node from example as suggested by Rob and
> > >    also pattern properties(spi dt-bindings conversion to yaml patch i=
s
> under
> > > review).
> > >    https://patchwork.kernel.org/project/linux-arm-
> > > kernel/patch/20220629125804.137099-1-sergiu.moga@microchip.com/
> > >    Once this is accepted, I will add back spi example through new pat=
ch.
> > >
> > > v4 -> v5:
> > >  - Fix indentations of DT example.
> > >  - Fix dt-schema errors - removed minItems, maxItems for allOf:if:the=
n
> > >    "reg" property as it is not required.
> > >
> > > v3 -> v4:
> > >  - Fix dtschema errors.
> > >  - Add a condition to flexcom chip-selects configuration as chip-sele=
ct
> > >    lines are optional.
> > >
> > > v2 -> v3:
> > >  - changed IRQ flag in dt-bindings example.
> > >  - added reg property specific to lan66x which is missed in v2.
> > >  - used goto label for clk_disable in error cases.
> > >
> > > v1 -> v2:
> > >  - minor fix in title of dt-bindings.
> > >  - Modified new dt properties usage in atmel,flexcom.yaml.
> > >  - Used GENMASK and macros for maximum allowed values.
> > >  - Use u32 values for flexcom chipselects instead of strings.
> > >  - disable clock in case of errors.
> > >
> > > Kavyasree Kotagiri (3):
> > >   dt-bindings: mfd: Convert atmel-flexcom to json-schema
> > >   dt-bindings: mfd: atmel,sama5d2-flexcom: Add new compatible string
> for
> > >     lan966x
> > >   mfd: atmel-flexcom: Add support for lan966x flexcom chip-select
> > >     configuration
> > >
> > >  .../bindings/mfd/atmel,sama5d2-flexcom.yaml   | 155
> ++++++++++++++++++
> > >  .../devicetree/bindings/mfd/atmel-flexcom.txt |  63 -------
> > >  drivers/mfd/atmel-flexcom.c                   |  94 ++++++++++-
> > >  3 files changed, 248 insertions(+), 64 deletions(-)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
> > >  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-
> > > flexcom.txt
> > >
> >
>=20
> --
> DEPRECATED: Please use lee@kernel.org
