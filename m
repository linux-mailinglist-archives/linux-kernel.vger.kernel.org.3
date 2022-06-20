Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767805517B0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 13:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242014AbiFTLqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 07:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242048AbiFTLps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 07:45:48 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A877218365;
        Mon, 20 Jun 2022 04:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655725534; x=1687261534;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KYq+tiGKIeyIBQq4i0WLjwDBuXImoQuRGXN4SQr/j6w=;
  b=1GiLMK2xAoVw1fADFfxtS54ZJC8BMKt3oDoJKXAkSAoBRS1dyZBa0MZc
   6fs6CjGPMF4YM9aiKAjC7Ooc9vkq5Kux5gqQCd+fOSw1MZvKdUw5Kpt/L
   tthgBG4SPsDYEATN0G/P/bxTvYEmcpllZvQpLXNiPFjJxS8lOtEZ+nLOJ
   SPS51kxtdpzMJIfoTEmcU8NJzPjCwG4KsB6dpYOu1SgGr3kUzp4Jcd0LA
   dRcNG92uGksKlHshj1X71aajgNVhILrOmU2sgM+3KiHO/HmkDlKRV+8PW
   UDjXOnubKS0wdWI+W+rALaOA6JgndZ/Crfi6yhc1DQO9ptZbUJe/J+t1n
   A==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="169097305"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jun 2022 04:45:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 20 Jun 2022 04:45:32 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 20 Jun 2022 04:45:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZIC3uklZv1VJzYM6UkQDuefbkAhduj7OuWzDyJnJugU2WnnC/S5wIYR2He8nT4antGXa6x1uyEMZw6z3DhFgJpTy5x12CO02cX1Jnn01DGgw8Sb7sdWm735lPtUOi1oYKRq4rqTWvQp9tf30aiy0qBsmX4HTl1UCVGbdk7vlOv0nMgX9Wq6R16pvUhjlWKwsSODEGXmgdYjD3gB1+97IGYMCjhwKr9fDDB6HKM2oG3gHO725z04ZKYfWopd7/h/BCFXP+B5GPtr3a1NOAUcv7bVS/ShxxvLCuAX1t1jDct9Kkaz38ghJtHwD9vhGIyAywpakvtboQCZImkln/CsQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jc0vjXaQ5L7waAK444rGTS+aVRK40FTccFzK2kal4lA=;
 b=fvrKwJVZsgnAsIGZ+xqYS8I+2POvccphHg5Uc9d5kp9pKDA9FzonqfbUdk/us5XDUeUp/lTYXP1qeasmKmNAI/JnR1uQo246U0PaYRVBUKCakaPtJsrEkv93eOYr6Ws5OOBGIYFwbAmAX7LNXQJ4jm3yQe1SD/XaxMtGA9mV4HA8+CgCg4n5Hcu4E15Fhl5CkyHLqi+XTIUZBwu+ULNQEikOo+ufpBrDiuYEID8gzZWPFdRNr2wkud+6PflVbkhjjGUES1VTn+BYPqQalYwC8Z4HQmQtrzfcBlqKZoPvBq7LKxWXoloCtvosfmJuRXFihNasyiqlUysfC+UUzhpTvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jc0vjXaQ5L7waAK444rGTS+aVRK40FTccFzK2kal4lA=;
 b=QfNJJ/3YOAD5ymULVhxOhZ27/yUlNM6vR6+QuXoqYZsM/hmnWIR2/BQkBGqFSnV72Gmvovm223jvncvgmg5rCd12XSxEV3637ir30abyt+ew4dMugPAKX1aMyz/GCBiS88wpGRqW1svMLY+e79JevqHf12dKcrRqe9oxJIBDDt0=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by BL0PR11MB3089.namprd11.prod.outlook.com (2603:10b6:208:79::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.13; Mon, 20 Jun
 2022 11:45:31 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::9cb9:213a:4f98:d9a]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::9cb9:213a:4f98:d9a%9]) with mapi id 15.20.5353.022; Mon, 20 Jun 2022
 11:45:31 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <robh@kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <Claudiu.Beznea@microchip.com>, <krzysztof.kozlowski@linaro.org>,
        <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v4 1/3] dt-bindings: mfd: atmel,flexcom: Convert to
 json-schema
Thread-Topic: [PATCH v4 1/3] dt-bindings: mfd: atmel,flexcom: Convert to
 json-schema
Thread-Index: AQHYgktCiqqptpU+dEuWUcG+O1Oj/61ToBIAgASPMIA=
Date:   Mon, 20 Jun 2022 11:45:31 +0000
Message-ID: <CO1PR11MB48653378BAECD414F497D59592B09@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <20220617130729.12072-1-kavyasree.kotagiri@microchip.com>
 <20220617130729.12072-2-kavyasree.kotagiri@microchip.com>
 <1655474312.882258.1508989.nullmailer@robh.at.kernel.org>
In-Reply-To: <1655474312.882258.1508989.nullmailer@robh.at.kernel.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 924b6fb7-6435-41bb-de57-08da52b26103
x-ms-traffictypediagnostic: BL0PR11MB3089:EE_
x-microsoft-antispam-prvs: <BL0PR11MB30894D41B8E6B569C925039792B09@BL0PR11MB3089.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S4tD/XdQIx0IhlEi+Y0J/HVCrclENFJkkHcmIb4Ce6dmifMMLKYWBvEiiuEhGGY1va495S/zCl75aBEQoeJgbokZBr4BRHOTAXkDWAyaeFZWNZJ1MZQLMM9D8M7qcxbql1gM+uybipNncOaj4pkMMgZHq51gyljH7vclHNITYkNPcR/019Fwd3ADYRRBaHb0kf0maaKokLdw+otTo6jb10EIGHXs+GTtDN6t6lOAUCpWWLFRE/5zABjgcwEj/FAHgeyGeYPVXROXYuD6kkCQxj5oyAqdDO2oR39Kw4H9IXX1olilSiKMEdoaTBfBO5Ri/0YGiAp1JyhTkv1SgnRBD9AO4Vi7TqsIG5Cs8oI+C/LNbnSny8L6rIVvV+rx4ZoahBLly61IGG+Xjs50W2IyLlSj//9RK+ZO/fFw3+HtgKMy+L6zpyUAwq4F70bccY4mK6pda/EN5UrZvJmfwIUPrsVt4iHzt9884NVSBIvRS1m3uzEiNbV3bxURRXPVDNrHQ7GGWLClWEFu+vKR6kK81PfthVKEAj02acOVL++3UKbor3sWk9689SN+3cuuIcPnKZdkaPPHB1FDHSdJBWRxMFqCS5sgCLIWND2JTRz9Z5uLqPL09tum9VVXIxRNV1hxYTZQzbKOKOKS8rtFSqWaeLQ7vTc04KhtuHK8jdk/jiXiH+Wy4GKVan/2HDAwxRYXuPky6bSV6aaUH0dZno9BsBFPUE5BGgtDjhDuFYS1gCOuGmsBuGCAR0XEUcGNuEU6MHm1/ONSla5Ok5LkyL0nJQsm2qs9SsKVqruCvKEi/LA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(396003)(366004)(346002)(136003)(8676002)(66946007)(66556008)(76116006)(4326008)(66446008)(66476007)(38070700005)(83380400001)(55016003)(71200400001)(2906002)(186003)(54906003)(6916009)(316002)(64756008)(8936002)(966005)(478600001)(52536014)(5660300002)(38100700002)(9686003)(107886003)(41300700001)(122000001)(33656002)(26005)(86362001)(6506007)(7696005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?4CufCPrccKU0XZKIUKn+Zpw6jhpysBd4EbULz58hTJCpwaWfZE3p8vxRsCTC?=
 =?us-ascii?Q?/DEK5QCOaAVKr0MG60V4/FTaPgCXbDr5uadQnS3gqFu4wXD1qwWtdq+xCXZc?=
 =?us-ascii?Q?q+F//B/VRkqAA8+Vku1OuMDKa/NRKchWvFF4x5Q0MpfxvCW0ZC5LlcpW/XHE?=
 =?us-ascii?Q?nSdMXk3K/8A0tMMBEkzR7vfkuc5+qFbDNr45MJYvRUCX+TpT3UlzlnYimNem?=
 =?us-ascii?Q?SXrdO8T305xNtaO1EiQanBPeGBe+yRedZl0yhwWRfZVnFXUh62L9z0E0K6+a?=
 =?us-ascii?Q?fc0r3cXnxnAteILQ0rPa621Fon90VVlBwJK42992HPlCMvocB43N4JAt3o/G?=
 =?us-ascii?Q?TuY2iLeRrYbxFRkj1oSumu97ygKFbPHkCFyRiOPGB+TcCTjD9EVVaS+xlhMF?=
 =?us-ascii?Q?u9dyNkZxVcgmUNJT4pVJ+SG48ptvbBpS4AK6G6Ph57ZmllHAH1FBSsp9v6i7?=
 =?us-ascii?Q?E9p8+I/sXjZ75t0tF0ZChf1Dr9c9l9rsE3Sa+gxvU8kNF4GHrOGp4N+Jxlrh?=
 =?us-ascii?Q?H67zdkIop15yAFPmuq86lQ2qSLuY+37zFipT6B6bd6iY4weeBUhfyw/+ohEz?=
 =?us-ascii?Q?rHSkj6OIXlc2o6bV5zMqDfSrjpaGoPW5IZWL+/QDWPVC9Va3S64oORxjZ042?=
 =?us-ascii?Q?wCoVLIT7/rPMurjq3PbaDSaUmX4Q/nz6ruDykimPYS3xDvgAb+uXC2Er7mQv?=
 =?us-ascii?Q?lNthNBSrgMRLahZepYId4ye5QE9eG6vVD0IFrtUUUnqIyxfoYRysvWwLvHZM?=
 =?us-ascii?Q?dAeU7kQgUpt5g6RIEAf7xItBWCN2F50Yz+bE51PJEbcM1nKSDYOf54tuSW/3?=
 =?us-ascii?Q?AqvYOc8tr+SVAx+u9dQwIr+dEpX4ctraOSWSPX/QHgBc+kVPkwbV/fHfAlKU?=
 =?us-ascii?Q?TemBh5pps7VudzRntWdfmD9c9+wv63nm3A8LaXzWR1qovKVhwAsXX8g3b61x?=
 =?us-ascii?Q?1hRW65AJtaZFRiTtIA7H+049BoKBmdJ842VdkT62QK1F31prZC9ON9M6ca5m?=
 =?us-ascii?Q?SMADg/1DjoWyqFxoa2IMHAAvLJE1P+maoD+/heMm4l443bTx0HxFniT7c9r+?=
 =?us-ascii?Q?K6uE/PpSJpm5b74ED8nX2EHVHCGKVMSHcNtF9hDY8RrttSLeaf06ZXQ3PSke?=
 =?us-ascii?Q?oRRrUKoS/pWBZYkxfzt0Xy8RQutyQN+2NVrjlqTMqKNeBXpFQixbPNrCwHmZ?=
 =?us-ascii?Q?LEA/xSstwZLsBcC5C6x+fyG+/F87Ufm01MOCx32R24c9vBn3pHTOoTE5N3n6?=
 =?us-ascii?Q?QH1LdHNrCtWUTTCnSiUX+1tBUGDOHJo2FDZaATYikc9P4jv47/gJC2L/XwzY?=
 =?us-ascii?Q?WscUPIb4rhPQfRmPyjbU0z4dS46/n8RelbMG+NI3zHEyVbsF3JixNrgPvHH7?=
 =?us-ascii?Q?yHNJg2TxrtwoQIfkD3dr6vlihRXOqtvqtBaIbNCN4KA5PCUzX0nes3C/QbnA?=
 =?us-ascii?Q?Q67Fs9KUJKazQ78fdMHHokYdrYyT9R0Jy63tSB8S/0fl0gKZ/uIdbpTzRuMk?=
 =?us-ascii?Q?oJJt+JQvsLbsxUeiFdWyIfkcNQS1evKxB7RO/x1SjQq7zMNM5kp8D+R18ArZ?=
 =?us-ascii?Q?1CcKTumwhEKgHpxqycdUuxSAm2mUelmIunfzQfs8wO11V3bSxTJyqgSmG+Tk?=
 =?us-ascii?Q?7yrlVeh+bCMuKyxdkHzkQ+zxhRwap9Bp/x+aejpiYD3YivTAG5HWOS/QLpSS?=
 =?us-ascii?Q?UAlptwB7wKKhkVgvTxugPsyvJBszTFUQFNBxagrxcianXxLjfX++ykV1Rx76?=
 =?us-ascii?Q?1krBWdZslnH/AYXIi4SkJgU8QA5e9lw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 924b6fb7-6435-41bb-de57-08da52b26103
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2022 11:45:31.1020
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bnUwJ144xO3eBNQob/J8x06U0q46ZNzxjzxn7dxrrAPLReWnUAiY49npJm1cYcdGN2UzeTpT81IKqjcT7T4mIoUy5HtGIK4Y21dOkUX2xdSaVsCRnq28vx1DOaFKBXAR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB3089
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Convert the Atmel flexcom device tree bindings to json schema.
> >
> > Signed-off-by: Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
> > ---
> > v3 -> v4:
> >  - Corrected format of enum used for compatible string.
> >
> > v2 -> v3:
> >  - used enum for compatible string.
> >  - changed irq flag to IRQ_TYPE_LEVEL_HIGH in example.
> >  - fixed dtschema errors.
> >
> > v1 -> v2:
> >  - Fix title.
> >
> >  .../bindings/mfd/atmel,flexcom.yaml           | 104 ++++++++++++++++++
> >  .../devicetree/bindings/mfd/atmel-flexcom.txt |  63 -----------
> >  2 files changed, 104 insertions(+), 63 deletions(-)
> >  create mode 100644
> Documentation/devicetree/bindings/mfd/atmel,flexcom.yaml
> >  delete mode 100644 Documentation/devicetree/bindings/mfd/atmel-
> flexcom.txt
> >
>=20
> Running 'make dtbs_check' with the schema in this patch gives the
> following warnings. Consider if they are expected or the schema is
> incorrect. These may not be new warnings.
>=20
> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
> This will change in the future.
>=20
> Full log is available here: https://patchwork.ozlabs.org/patch/
>=20
>=20
> flexcom@f0000000: spi@400:compatible:0: 'atmel,at91rm9200-spi' was
> expected
>         arch/arm/boot/dts/at91-sam9x60ek.dtb
>=20
> flexcom@f0000000: spi@400:compatible: ['microchip,sam9x60-spi',
> 'atmel,at91rm9200-spi'] is too long
>         arch/arm/boot/dts/at91-sam9x60ek.dtb

These errors are expected because "microchip,sam9x60-spi" and "atmel,at91rm=
9200-spi"
are documented in Documentation/devicetree/bindings/spi/spi_atmel.txt.
which I added in description as
" description: See ../spi/spi_atmel.txt for details of SPI bindings."
