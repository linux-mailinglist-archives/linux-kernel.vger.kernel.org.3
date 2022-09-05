Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B295ACD3C
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 09:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236998AbiIEHyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 03:54:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236902AbiIEHyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:54:01 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01933CBEC;
        Mon,  5 Sep 2022 00:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662364441; x=1693900441;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=mmXLJcWG86mkbApM7Hdk0uCjrr3ajgZUy/4Qwf8ksEE=;
  b=W+mrOdhiGgGsInc2PBO+ztaueBdBNLjdQ5byMaekYywjJLZfNnqCbU6/
   6AQTa2PvlWFo0SPHV17G7+Mw5hr+/GqM2gUcg+eFRc4Ou1RV+/nGSe0V7
   hkR25+7KaOFwWXuXF4HirqgtT2TCz8/MI3KOQhTYCS6GVJuqQxoacbVUA
   3qFvywi6Gfup9ggMzu1+txlRfAfKIPHziWKn4VVd3WHk9bC5cY96L5GHw
   s92AJFgLXlGRQOGIzr4xCNjPq/3ohy0Mdvy6a0LCfdZw3BVWBmQGpmsly
   NAeK0Us6SKV2/qVc+RauTh955+3VVBczLuHzvXjpSLOJUFq5coCwFMQn5
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="172385608"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Sep 2022 00:54:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 5 Sep 2022 00:53:58 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Mon, 5 Sep 2022 00:53:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gl2jpYLPh/HxV29BrhJPqTXfM4bA+VMAzk7njqp7puK17iYpvVU4KfoA8n/ogL1o+OpBekWxpMvNfNJs6G1uYCV7+zSdAOB7qkWaqg0mUQstjSsytOPVKryBBi8yn1U/IOcTDQ1ur4/GQxNZMqqI/u+3Exzxn20MO3Q8UmsYuoL7ZlQMt7qlNxoI59eGbfGdTZa89qZVuhYpevvOpYSjlNcSsrNr4bed3F9xeVrdMmOpJD6v0TnJ5xoEnmrcVyjRO929MVnli95tOtS8uNzigILqfNABSd5btJjtwwbpnU4sImtKWweEzGiS0e+O8HKmv7nflua44P8ShJJICzG3Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pM+zd6qF7BBg6ct+sNmTp93Nfvr6jpmmpMItym18AsY=;
 b=RwsFn0SlQzFaC5L+EaOuSuFdkR3yjc4Sr1ddfdH9OCewBYSbDoHzdardlIzB+ygfyXSR9kdnwF0E/PQPqClMp27zRjzVtqd5G7fefbzH2qurLYp+sGlheKhp6Djl9iIxCbJk5LoiFNrZL39r5pkx8iWiJ0UGPHlQwMrjzmVdwNxcruzxSd4bJfOcNraol9oKEtbXKa4nQJ2hfZW+9RlxK5gJCIiDBePkTOZOU4BtycFi3KJtN8Rpj31+gbXZ1MRzqL0JuEJ6/a4k1jQWzK1IV7QXHj+o4XGhUdYzFaNTJEDnbmr+WKq3+wjFcl8ttWtsGrp7y1sAXw9YKPjegZjEpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pM+zd6qF7BBg6ct+sNmTp93Nfvr6jpmmpMItym18AsY=;
 b=mEpoBF2uwkB5GVw2jsXcsTZOpElnJQmJs72QrxjokAiYNYTuraIEIe/3Eh7O6WjeDSPHLdYyMyJMhSZPgi/3T9MeLuApXfJUAuvC+MRGx9T9PR3QjWxnP+FGxlxwXo3AXaotc7yiBo5gx+jTIUAr+5rqdnYsISwqplPcR+FKukE=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by DS7PR11MB6294.namprd11.prod.outlook.com (2603:10b6:8:96::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Mon, 5 Sep
 2022 07:53:56 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6982:4db0:989c:c097]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::6982:4db0:989c:c097%8]) with mapi id 15.20.5588.012; Mon, 5 Sep 2022
 07:53:56 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <lee.jones@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v8 0/3] Add support for lan966x flexcom chip-select
 configuration
Thread-Topic: [PATCH v8 0/3] Add support for lan966x flexcom chip-select
 configuration
Thread-Index: AQHYksHtcVb2nMUrrUee0+iQGAJuu63Q0lng
Date:   Mon, 5 Sep 2022 07:53:56 +0000
Message-ID: <SA2PR11MB4874435AC1CAEE6DAFC3F239927F9@SA2PR11MB4874.namprd11.prod.outlook.com>
References: <20220708115619.254073-1-kavyasree.kotagiri@microchip.com>
In-Reply-To: <20220708115619.254073-1-kavyasree.kotagiri@microchip.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0e77b46-27b5-4d76-6b2f-08da8f13c90d
x-ms-traffictypediagnostic: DS7PR11MB6294:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aUDTH/uG5KU/1e5HpX6YCuRssQfOh3dZjg+VTl2va2HQjfceQ12ou3Z26qS9aiwiZtfJayi1G+bksPQ960CkVeZbfHmmntfqApoTWxhkPPcosv4mHW5tT5NtRh55VRJ1AItpFTbod+K/u4LO6XpBPq5Oo14zZSj/a7NmrdQ0DGQ92URe7gMSXJpp57cH9qCbb3bLefCOK6X+B57zJtyYtNhh3TZuBFBqzXRIKTJ9VllkCKh8q6P7B5n4MLZg+wfCduiDD5Rf0G5kiX50RAMJMBWUXfd/2QJhHj3Ulw+ajsbHeuOrHHAwWJFJWnOFbVvzKG7Gd/gV0cmH5UUD+CDtdxLzU6nu+2LaoKtqCXOhse4zOgejoCrO7e/0d5aLFnIyJ4lfnqwHtko5sLuIfIgRqB2PyKoYT40dbKTcoaA879m6vWbJ2wfBzR+pmPOt7Cc+KAqNpwc1N9NVI3bxiDdxP21Y3hl/TkpyEhPGaJJGmwFbH3rcNKFxo7lAQFIZP5TlrnqVnAD+dB0r0AY+FxCv/UxhYkoDnQSKYG2blBd+dDU88jagmOny5aziq/amcSfJeV8uQ/ED0zmdKxuiDu5SleMkZt5pdj+SNHCjnnBJTCsDzGi1481ygesyGAmmkvBQ4DfC0pnCsobOQt3Jjr/22zYirlc7W7lEmkT9DfMYhCpnmdKDeRDbfWk3G1D2te4kjKcIFdJywhxUMwfH7c6rWwKpISWFVNTttjzNaH9Ym12AMiLFPfH98k6ESchF4r9HV8VBs3sADC15n7XZ6gSXo52hxv0vCT/WYoX91+8i4Gw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(346002)(136003)(396003)(376002)(66476007)(64756008)(66446008)(8936002)(33656002)(2906002)(53546011)(86362001)(66556008)(4326008)(41300700001)(6506007)(9686003)(107886003)(5660300002)(7696005)(478600001)(66946007)(55016003)(8676002)(38100700002)(122000001)(26005)(52536014)(38070700005)(316002)(186003)(83380400001)(966005)(6916009)(71200400001)(54906003)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?1DVofFdPK9rR42FVe/slb1Zm8I865krmDwMs/GDvBBP0j03fgeItUprc1+Ca?=
 =?us-ascii?Q?MNpvjpymnpVjrTjqCWhrTtE1B8EAnS4N9SqIe0zmcdyZGcb9FW1AEPoYv7M2?=
 =?us-ascii?Q?E/Nt4kZlpudhzI3EQaSz2nDqDq1WjT1R4y3qo3gRbL5YOxwalGlcRQb+lraq?=
 =?us-ascii?Q?0VPwZ9FUG2sw2Bl4LVh8i9pjZ5Sz7NmP/xHRVd9kcIxSehtW80kwsdpKRCWg?=
 =?us-ascii?Q?5ohpJXGFgXUfea2jQwWOCGMpbpADSQZZ8ODT04R+P8wKVX8peOeeuqsWq4J2?=
 =?us-ascii?Q?Vx4X8lpvHbfhbY21DVHxSGITrDrmBZIJfWL7/nrWXEAHv1+SDQnNn4klhxwe?=
 =?us-ascii?Q?GdMh1h8zNdDXOVSPfw8yjOdhySuptGf44EtSJisSPNFsvkjb78BaC2LL01J6?=
 =?us-ascii?Q?l69iQGXgLc3YIaRtSHE/1ziWUwwGoXK0dzjI9Z4RS28I1EPAHgi6QhCDDRjI?=
 =?us-ascii?Q?NqsxuZIHDDjYB1XL3oOYW81HOAwBxjoBuMUjaVSDXi6iJdupcjuldSlXIw1g?=
 =?us-ascii?Q?y6eGH8zU8q3uUthpRnysgndkOtA3RaPZE+wJ6NuA6M5ezPagnp08PvaFOMcH?=
 =?us-ascii?Q?1B7JB4g0+dEXMyaFJua4vL7alqm4ieb5wO0kI3jaWdOn1nzceb9rT1kVQH34?=
 =?us-ascii?Q?kPBpJgcfB4fi7vY06E5KmMdnQi76UIOZX3AJ9BbSGIF6sbFItPSocH3/Aapw?=
 =?us-ascii?Q?4nTq3V4XzO+Fz/Rk5+eQ/am4Xrsi7wZJmewiu5B+Zoqy/BZYAOYM5jgMdEqj?=
 =?us-ascii?Q?v+JFZj8cpuBceKGJjUaEemNc07uW1DMcZuzBZBlPxD5eM2dbWz6T7JpcFNEE?=
 =?us-ascii?Q?ahhwOw5p0bCJ6bjawTaSMg7tATZNZH4u06oLZk9pd6Rs1suq0qTsTjiObqfa?=
 =?us-ascii?Q?ZIQtEEzAq2rb8nkW3M3bPs1peVcb55U9x915SrxKzcSz6qE9DysF6+Oy2m/e?=
 =?us-ascii?Q?5typeoNv8yzPGszdcBmEocIQY8is57eXqrCkMxQZeE9+qcaC94m4OIjpF4Ym?=
 =?us-ascii?Q?8IV+wVcSWVbqSY7zvhF0NXIOA57joWU/xn6SoW4u9xdN9FflhMA/6LfMEMcR?=
 =?us-ascii?Q?Gt0dTT7bk7dQ2b1wSxjFjdHMXkye70X4YcLGI73btUQ5spP9Okc7JjHb7y97?=
 =?us-ascii?Q?x60+UW2uoO14bZzU2FkblqnsySQoq2mjyOLtIB5pq+vuHhyI0uNX4aQZYXz3?=
 =?us-ascii?Q?Yk8t5eGY3u1lTOrQEElHJjruPq+tmoav/rTTRZn1AA/EXmoNEsUj046nyw2F?=
 =?us-ascii?Q?l9nXm/B9Xa+ZBsmA6GiYJ0PRFHc+uSwufQEQ6hMIwNCejd3htMlsDyMlkGK/?=
 =?us-ascii?Q?paGFBCwaCEcDvjVSbiBDr5VOOwmCuPY1QtyKr4DAow9sxEnh6TgtGej0oVL/?=
 =?us-ascii?Q?mlXBi3GTPhsLM5q7uP8Q7Koo3WRI7bmHNdrU5Mpy/EGGmH1ZsIYkLvVeZFqZ?=
 =?us-ascii?Q?p4thXHmcWc1uhqpQIAn7dy2sIjZJv8ZpDJtlDlWj8x5Yry4rir2FrQIVNMc4?=
 =?us-ascii?Q?NUpbQ1s5509StEZ35ssQlDK7TWmgK+XRu2W0XZ4eykfrG8ImW+lTguCK0oAC?=
 =?us-ascii?Q?KP5VEWhjYi/CwbUfGvFOzz3vjPcT4Obp/vxMUn9buADDqeG5y2bWDVwF+GQ1?=
 =?us-ascii?Q?Gw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e77b46-27b5-4d76-6b2f-08da8f13c90d
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 07:53:56.6284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /32srjhcpjmjkz10mtxCQJtlo4EZY94xQEwVSN8mA23Gien6tAshhebY6qt0cKgCI2XprVMUSUUAMQpfiyAc3HfRMI+FY2Qcwe2e+0qJtQEP0R0PEf8M0/n7hUaRKNNs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6294
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

Are you planning to take this patch series for 6.1 or Can we include them t=
hrough arm-soc pull-request?

Thanks,
Kavya

> -----Original Message-----
> From: Kavyasree Kotagiri [mailto:kavyasree.kotagiri@microchip.com]
> Sent: Friday, July 8, 2022 5:26 PM
> To: robh+dt@kernel.org; krzysztof.kozlowski+dt@linaro.org; Nicolas Ferre =
-
> M43238 <Nicolas.Ferre@microchip.com>; alexandre.belloni@bootlin.com;
> Claudiu Beznea - M18063 <Claudiu.Beznea@microchip.com>;
> UNGLinuxDriver <UNGLinuxDriver@microchip.com>
> Cc: devicetree@vger.kernel.org; linux-arm-kernel@lists.infradead.org; lin=
ux-
> kernel@vger.kernel.org; Kavyasree Kotagiri - I30978
> <Kavyasree.Kotagiri@microchip.com>
> Subject: [PATCH v8 0/3] Add support for lan966x flexcom chip-select
> configuration
>=20
> This patch series converts atmel-flexcom bindings into json-schema format=
.
> Adds support for lan966x flexcom chip-select configurations and its
> DT bindings.
>=20
> v7 -> v8:
>  - Added back patternProperties for child nodes.
>  - Changed compatible string to microchip,lan9668-flexcom.
>=20
> v6 -> v7:
>  - Change filename to atmel,sama5d2-flexcom.yaml
>  - Add #address-cells, #size-cells to flexcom node - Fixed warnings.
>=20
> v5 -> v6:
>  - Removed spi node from example as suggested by Rob and
>    also pattern properties(spi dt-bindings conversion to yaml patch is un=
der
> review).
>    https://patchwork.kernel.org/project/linux-arm-
> kernel/patch/20220629125804.137099-1-sergiu.moga@microchip.com/
>    Once this is accepted, I will add back spi example through new patch.
>=20
> v4 -> v5:
>  - Fix indentations of DT example.
>  - Fix dt-schema errors - removed minItems, maxItems for allOf:if:then
>    "reg" property as it is not required.
>=20
> v3 -> v4:
>  - Fix dtschema errors.
>  - Add a condition to flexcom chip-selects configuration as chip-select
>    lines are optional.
>=20
> v2 -> v3:
>  - changed IRQ flag in dt-bindings example.
>  - added reg property specific to lan66x which is missed in v2.
>  - used goto label for clk_disable in error cases.
>=20
> v1 -> v2:
>  - minor fix in title of dt-bindings.
>  - Modified new dt properties usage in atmel,flexcom.yaml.
>  - Used GENMASK and macros for maximum allowed values.
>  - Use u32 values for flexcom chipselects instead of strings.
>  - disable clock in case of errors.
>=20
> Kavyasree Kotagiri (3):
>   dt-bindings: mfd: Convert atmel-flexcom to json-schema
>   dt-bindings: mfd: atmel,sama5d2-flexcom: Add new compatible string for
>     lan966x
>   mfd: atmel-flexcom: Add support for lan966x flexcom chip-select
>     configuration
>=20
>  .../bindings/mfd/atmel,sama5d2-flexcom.yaml   | 155 ++++++++++++++++++
>  .../devicetree/bindings/mfd/atmel-flexcom.txt |  63 -------
>  drivers/mfd/atmel-flexcom.c                   |  94 ++++++++++-
>  3 files changed, 248 insertions(+), 64 deletions(-)
>  create mode 100644
> Documentation/devicetree/bindings/mfd/atmel,sama5d2-flexcom.yaml
>  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-
> flexcom.txt
>=20
> --
> 2.25.1

