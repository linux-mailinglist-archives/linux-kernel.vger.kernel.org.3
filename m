Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFB265B2243
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbiIHP3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbiIHP3H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:29:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DADF1F09;
        Thu,  8 Sep 2022 08:27:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662650875; x=1694186875;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=XiE5EqExJhlO64X7BZaUX7O9YHaSOxysO6FLbSSsdlE=;
  b=IODL0yXRPPcYx5o7gseHkWhu+POG/GtfoaWFAOJ/ohSsblZ6xlSUNNq7
   5z5mwIfZMTIc686ll5774nNhEY7Ng5FeARRKqWbYboRHhFImm3yULgrwb
   +JGnyrTmz5WVgqULHn1nElc3PxGDY6I10DrI2C3Pf0UVwdm2k6YnYUv6d
   lMZiIEGLnYd9H8A4XGKkUntTDrZrm0pmnJV2YoDTo/pt83D7kcf1i+zel
   /WetYzBQk0eOaz1bz9P66I/S1p/w0kGNnw+2J4j4SaWjXge/QY429/wzH
   uvNc3he2DL5AnnM2E7+VFGz3QrUYXoCK7wXNt0ja0fu3ees6gz4e2DvbB
   g==;
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="179714305"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2022 08:27:53 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Sep 2022 08:27:48 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 8 Sep 2022 08:27:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SpoWxFRTZhCL/Qt+s07fDf0qcw4lmOqHGktY1iyyaOtZh2A7NY0AkygLfffBC1glzAFrxyPHca3sZKSGRtv80m9EZ7Jcz1zxblVBTCknFOPNLnHQr4T18f8eiLwr1UAw5LNDRRvnXMm8GKFQ8xHyfhnGMNWb5r8xpgGXZhMcBVFQ+C3vAyudDuw3WONluENwMg64BQI1OeCiAT2CzFrlrk5+yH+OjvFC7pocB6hOWIyq+I/L8DaeYwN6RtlgvaerWLaX7cV60u8Kr+Lky/LF78dYbPwUdRxcwfPiglEFXe1KsDxGsak0T2Ro+gJhNGNBfoHIxK8WQRISAqDUaif6tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XiE5EqExJhlO64X7BZaUX7O9YHaSOxysO6FLbSSsdlE=;
 b=TUpuNLaWnshuTx9N6WXQYXRgtweLM/xt0xypDx0dHfhszL3n+XagpLCPIY+/vC5kV+UlC0ko15RdTWeZC80EaZSS8rCvyJXyFVC08NrH3jsFwMvLDvXiUfH/B+wAsJ/tQyYAElsBdgxNv6KXjb5GjkBFjDJSziSm0YQbrCxW9aTcnuL3TWLxbM4tZBVaahS57l6MJPTnzrcI+ZnqYMkQsiOj1LaRC5/Uem+miMUsiyIZdvbDXmdU7sGjRxKqJl3bp/msC9VWr7i1CG1znseoQItAzYhe0s4GsaQHj5/uy50mOY4Vw1f4sejRA4aJ4sYKIQ2nwA3/8+BMaJSXuv7Hiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XiE5EqExJhlO64X7BZaUX7O9YHaSOxysO6FLbSSsdlE=;
 b=ARF/JTW2TY2F5lIYMK9V9xkIaQfjgnp1mNV915BOCGkMLRFlPTHxMmqLBzo99kvrWw+XW5GAuIneRK7RaJ766yiBus5V/KEmjj/tc1jpb8l1Z4iyeJrUDH2BpjIFkynjrQ/kluno9aZEVnwCTqNo/19xKCe3517yAe1fB4Kq7BM=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by DM4PR11MB5231.namprd11.prod.outlook.com (2603:10b6:5:38a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.11; Thu, 8 Sep
 2022 15:27:46 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::6852:5740:4bc9:d1b4]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::6852:5740:4bc9:d1b4%7]) with mapi id 15.20.5588.014; Thu, 8 Sep 2022
 15:27:46 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <lee@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Claudiu.Beznea@microchip.com>, <richard.genoud@gmail.com>,
        <radu_nicolae.pirea@upb.ro>, <gregkh@linuxfoundation.org>,
        <broonie@kernel.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <jirislaby@kernel.org>, <admin@hifiphile.com>,
        <Kavyasree.Kotagiri@microchip.com>, <Tudor.Ambarus@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <linux-serial@vger.kernel.org>, <linux-clk@vger.kernel.org>
Subject: Re: [PATCH v2 05/13] dt-bindings: serial: atmel,at91-usart: convert
 to json-schema
Thread-Topic: [PATCH v2 05/13] dt-bindings: serial: atmel,at91-usart: convert
 to json-schema
Thread-Index: AQHYwfjByH4K4eAxe0ucv3xGn9LEXq3VeUyAgAAr1QCAAAEigIAABOaA
Date:   Thu, 8 Sep 2022 15:27:46 +0000
Message-ID: <753d73d0-44b9-9fba-1ed8-53691ecf2ee7@microchip.com>
References: <20220906135511.144725-1-sergiu.moga@microchip.com>
 <20220906135511.144725-6-sergiu.moga@microchip.com>
 <e799ca9e-acb0-1bea-1c1a-b2ab79089381@linaro.org>
 <fde16d80-28b4-aae6-363f-ad9dcf87a5e1@microchip.com>
 <1d3904d9-7fec-2e61-f999-61b89c4becb6@linaro.org>
In-Reply-To: <1d3904d9-7fec-2e61-f999-61b89c4becb6@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18f4ead8-4ee8-4c2e-2ab8-08da91aeae55
x-ms-traffictypediagnostic: DM4PR11MB5231:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1vEgVuhgRDr0GHEMljaQI+RKfEk2UadswFx5qAbcBNik0lBwP4oMou951c5TZAsokufp8RKhd97YHJ+bstVYH+TIHvgZuAnSQZhufQjaBL+3MA5YAaNdyhNKOosnPGLO8AhNr9KZi9RYlOYMOVQcF9Qye13iSuCZwQ/Tr8jDoaiYPoqSYkexu1zU8ty1sPhVAwE9Ia7oVrw/1JiWuiYwmRUr0WiDuGzCCjYFljgXAfCofveasPzpE8JehCmAlzOfaqdX7BRa6GWsFItjWj/qSNYpl5FQUbCV6FyumMjx0MNBASSwWrXOeqdkashmoJOnp/r6ZXo8eerWi5vdyv2SeV6v8DPP+nqsP4GpZ7sL9ETCEWpgDY4RQum0Ts2WA7MI1UK3FxTvDmQ1cQWlcDLgwy6rluRlSAy0zC2aEpZQ6zy6cZGVvPOBqW9KG6iMpHfd76M0/RzBcFuQJAVVPxUfJhpiDIutQWLUfXulWtonkt8rTVhOXBF2eBc4IVroREupSUtftI7dG3ztz4CvoNAwfkBc8M65Tqc/pjPtbpy2shjVJ3sghqih8unUe8+KDKzgjglV+by7QWK9gtn5M3SD/R3GtY8r2oLrPGsGBArR9F4KQeRZw19io0Hc7Va2hmxbLQka/1DrCpxuvd0zo599xjV5quXWnvK7BkBJlRb8WU18A/XV2SHA4nQTf0OdojEHeSvpAxxmekPuMRdJEMWy7OypyZu9zQaVpYxW0tCM/b25tvCAoLNzs3MlBBuVecylg76n7dxjDLO/XO4JBqSkzwLQRobVsx1gdsKtwcYhWUhwtNfBqoPf/pZiyGp0ZMG8+9sgTGXaEpVYXvvZudlQgA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(376002)(39860400002)(136003)(346002)(38070700005)(921005)(2616005)(186003)(83380400001)(122000001)(38100700002)(31696002)(86362001)(8936002)(110136005)(5660300002)(54906003)(6636002)(71200400001)(7416002)(36756003)(316002)(66946007)(8676002)(76116006)(4326008)(91956017)(66476007)(64756008)(66556008)(66446008)(31686004)(6506007)(53546011)(6512007)(26005)(2906002)(6486002)(966005)(478600001)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T2FJZ0xyblhTdE04WlRkc1Q0eVMzQmFCMHNDTFNLRHF3SzFwU1hqS0RSRjhE?=
 =?utf-8?B?SFhBYXNndGhXR3M0Y3FKdCtUOXY5MVg1VFUwa0VLRERDQmZ5WGg4V0NVOU9x?=
 =?utf-8?B?ZXhLa1lRSU8zODk1akR4RE80Rnhmam10VHhEZGVFeUFUbkdHRy84TXQ2eW52?=
 =?utf-8?B?Y1JrdVlad2E2L1ZYcVpyaGJzcStuNkdEdVppMXFNalNjRUxIRlI3MDYrWk1R?=
 =?utf-8?B?YkRodjh4ZnFLa3oxZ01xZzh1L3dJR1RIMVhJbmMrNVJkM2VZWitWbTVodCts?=
 =?utf-8?B?eWg3ZkhkaFk4UjQyTzZ1VDQ1VEZYOElxcGFRMVBkNkowREVCenN6YU81WkJs?=
 =?utf-8?B?RUZkSzliemxqbURkaTlhZHoxNDF3N3RjK0t3UDlFOGFrK01JNFQ4c0V3c1VM?=
 =?utf-8?B?dUtFaEpNYTZpQmNtK0RJbHg4SkFGemgrbUZCVkJLTHBudUc1bjM2RnJ2d0M0?=
 =?utf-8?B?dFdFaHhnUGl2U2xJbmV3NzlYMnRPd0h4TlhlS2V0R2daQUJkejlRR2RmSmNx?=
 =?utf-8?B?c1ErWmhxRG52L2xjdThYbHFJeW51eXhpKzBNcm9abFFGUmxYOStOTTZiTUdQ?=
 =?utf-8?B?eXE1MXNwNHpmN1N0aFpKRTd3SlA2aHRQQnQ2UkJDeU8xQm9jZnpXSGZvTzR0?=
 =?utf-8?B?QlM1WUxGWFI1ejFVeXRlRVZYRTRsc2NKU1ZrOFBWWUFjV3VLM1p2VzJ3aFVB?=
 =?utf-8?B?RXRVVWMzSTNEUkNoOVU3d0pmTlA2OXJsMkZibUV5YzNsYVZVc0c4SWlPMlVP?=
 =?utf-8?B?TmZXbmJ4WVYydXE3TFdkUkRwTVFtTlh3Y0h6dUtOSGJiWTBSajdhajQxNG1y?=
 =?utf-8?B?Uy93a05TUG9wTnk4MERET2RjNnZzNC9FbjJzcUJveWtSek92TzRSTExXYU85?=
 =?utf-8?B?alZMVkI3cWdsbEJrQU1jS3h4Y1FTcDRNVUJzYjN5K2RLSnN0Zk9vb3VGenJJ?=
 =?utf-8?B?YmorVDZxbCtnK2xjc3BEaWNuV0M4TkdJMHZycWZ4b2ZoblViblQvSjRCRUND?=
 =?utf-8?B?WkE2TXZicCszZ2VRTzVIdXRyQ0RCb0xTNlRDc09kY3MwcWNpcDFKV29tTmFK?=
 =?utf-8?B?M0hpdFZsVHpUNkx1TmorTkxRdVUyaGNraEF0OWhHdTdSNEtBY0M4UnFRMU1M?=
 =?utf-8?B?UytmaHJSZGwwcUhRUUM2alJ6VG1pNEpWTkRjMmxOS1FVT2Zyc2xFNitwbWtP?=
 =?utf-8?B?S2RNL0c3eGpBMlFnMGxOMVo1bWsxS3NaMG1ueXQyZlI5dmRMb2I3TkJiVndO?=
 =?utf-8?B?VmtVVW41Z0E0V2FwNXpaRGlxK1ZPRDJUbWFWSDhoeFlrQ2hKYjNpSWltMkx5?=
 =?utf-8?B?NnJtTDlCNlZIK2JLL244Z204Q3MyNVNzTkhMei9QbzNFZGM0NWRJZm8vQU5r?=
 =?utf-8?B?U1RFbXJ3RnVyZ1l5eFNML0lwWE5PSzQzejFLTm1WSEFOSW1kRGh5Q1RyeUdZ?=
 =?utf-8?B?VnIwNUxzRFpkN0lPbnNDYzZHV2hVRTRTaXVCdnlRWG1JWWx5c1c4cktzYTkx?=
 =?utf-8?B?NnN4K1cwdGpEelBwSTZOSm9DL2FMc21NLzhnWk1Ta1lTTk5WdGZrYUZLdDVF?=
 =?utf-8?B?L2hxNkdiVWNhb0xvc3RnR2lQUVVpaEFPWkYveGU4bTd4MWZ6bUxBMGxqTnVQ?=
 =?utf-8?B?eUFoVmFQaGMyR3VBaEZNQ2U2YkRBdENRR241VElPS0pwYThoV1FOSUxlRkZQ?=
 =?utf-8?B?dUdEMzR6TzlpMDZZRXpxS2U5S2g0VHRqakhSUUsyblM2YXdCNXd2cnFGWS9q?=
 =?utf-8?B?QU9WR0dKMjNYTGozRkN4ZmF2bEl3a0pOS09keUZMaXpneHI1bFhWZU1Sa1lr?=
 =?utf-8?B?azluVENPbW9lL25Cd2pBQ3BNSlZiaXR4U21HSW8rUmozK0FBbDJaNjZlUnVG?=
 =?utf-8?B?OGEwdlFlUWFuT3FlVnJlZC92YVB6eWxpTUZ3ZStOdGtHcVRybVFyZU9pRW94?=
 =?utf-8?B?RnhwZlU2cHJiT3F6T1BsbjVEeG8vMTFvOE1pNkEvMlZicDIrS215eWdRY0U2?=
 =?utf-8?B?a1o5VitINlppUzNKOGFZSVN3WG5VaGZtSGhEL3ZKVlhvZTRSRi9rM29qZGdJ?=
 =?utf-8?B?cG9MeVhDcTZKV053dkF2dmhzQkhpdnhUQlRRK2FPQ0QwTFhoanptbmVOd3d6?=
 =?utf-8?Q?uogSHX1ePLMlimivl3oro07Ku?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B01BFE1FE449984F87AE250AC080F986@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f4ead8-4ee8-4c2e-2ab8-08da91aeae55
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 15:27:46.1031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9knmsrn7R7vRishbNsE+rcXI5rqgsiBoI/G1J7ofKwbfVX/IeoEKw9K058TCGT6tq16QGZFmJBtkH1pvigQAanCLPLrXbjFj8m+QkxzxHNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5231
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDguMDkuMjAyMiAxODoxMCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gMDgv
MDkvMjAyMiAxNzowNiwgU2VyZ2l1Lk1vZ2FAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IE9uIDA4
LjA5LjIwMjIgMTU6MjksIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IA0KPj4+PiArcmVx
dWlyZWQ6DQo+Pj4+ICsgIC0gY29tcGF0aWJsZQ0KPj4+PiArICAtIHJlZw0KPj4+PiArICAtIGlu
dGVycnVwdHMNCj4+Pj4gKyAgLSBjbG9jay1uYW1lcw0KPj4+PiArICAtIGNsb2Nrcw0KPj4+PiAr
DQo+Pj4+ICthbGxPZjoNCj4+Pj4gKyAgLSBpZjoNCj4+Pj4gKyAgICAgIHByb3BlcnRpZXM6DQo+
Pj4+ICsgICAgICAgICRub2RlbmFtZToNCj4+Pj4gKyAgICAgICAgICBwYXR0ZXJuOiAiXnNlcmlh
bEBbMC05YS1mXSskIg0KPj4+DQo+Pj4gWW91IHNob3VsZCByYXRoZXIgY2hlY2sgdmFsdWUgb2Yg
YXRtZWwsdXNhcnQtbW9kZSwgYmVjYXVzZSBub3cgeW91IHdvbid0DQo+Pj4gcHJvcGVybHkgbWF0
Y2ggZGV2aWNlIG5vZGVzIGNhbGxlZCAiZm9vYmFyIi4gU2luY2UgdXNhcnQtbW9kZSBoYXMgb25s
eQ0KPj4+IHR3byBwb3NzaWJsZSB2YWx1ZXMsIHRoaXMgd2lsbCBuaWNlbHkgc2ltcGxpZnkgeW91
IGlmLWVsc2UuDQo+Pj4NCj4+Pg0KPj4NCj4+DQo+PiBJIGRpZCB0aGluayBvZiB0aGF0IGJ1dCB0
aGUgcHJldmlvdXMgYmluZGluZyBzcGVjaWZpZXMgdGhhdA0KPj4gYXRtZWwsdXNhcnQtbW9kZSBp
cyByZXF1aXJlZCBvbmx5IGZvciB0aGUgU1BJIG1vZGUgYW5kIGl0IGlzIG9wdGlvbmFsDQo+PiBm
b3IgdGhlIFVTQVJUIG1vZGUuIFRoYXQgaXMgd2h5IEkgd2VudCBmb3IgdGhlIG5vZGUncyByZWdl
eCBzaW5jZSBJDQo+PiB0aG91Z2h0IGl0IGlzIHNvbWV0aGluZyB0aGF0IGJvdGggbm9kZXMgd291
bGQgaGF2ZS4NCj4gDQo+IEkgdGhpbmsgaXQgc2hvdWxkIGJlIGV4cGxpY2l0IC0geW91IGNvbmZp
Z3VyZSBub2RlIGVpdGhlciB0byB0aGlzIG9yDQo+IHRoYXQsIHNvIHRoZSBwcm9wZXJ0eSBzaG91
bGQgYmUgYWx3YXlzIHByZXNlbnQuDQoNCg0KDQpObyBEVCBvZiBvdXJzIGhhcyB0aGF0IHByb3Bl
cnR5IGF0bSwgc2luY2UgdGhleSBhcmUgYWxsIG9uIFVTQVJUIG1vZGUgYnkgDQpkZWZhdWx0LiBJ
ZiBJIHdlcmUgdG8gbWFrZSBpdCByZXF1aXJlZC4gYWxsIG5vZGVzIHdvdWxkIGZhaWwgc28gSSB3
b3VsZCANCmhhdmUgdG8gYWRkIGl0IHRvIGVhY2ggb2YgdGhlbS4NCg0KDQoNCg0KPiBUaGUgbm9k
ZSBuYW1lIHNob3VsZCBub3QNCj4gYmUgcmVzcG9uc2libGUgZm9yIGl0LCBldmVuIHRob3VnaCB3
ZSB3YW50IG5vZGUgbmFtZXMgdG8gbWF0Y2ggY2VydGFpbg0KPiBwYXR0ZXJucy4NCj4gDQoNCg0K
RG9lcyBjaGVja2lnIGZvciB0aGUgbm9kZSdzIHBhdHRlcm4gbm90IG1ha2UgaXQgYmV0dGVyIHRo
ZW4/IFNpbmNlIGl0IA0KaW1wb3NlcyBhbiBhZGRpdGlvbmFsIGNoZWNrPyBJZiBpdCB3b3VsZCBu
b3QgaGF2ZSBhIGNvbnZlbnRpb25hbCANCnBhdHRlcm4sIGl0IHdvdWxkIGZhaWwgdGhyb3VnaCB1
bmV2YWx1YXRlZFByb3BlcmllczpmYWxzZSBhdCB0aGUgZW5kLCANCnNpbmNlIGl0IHdvdWxkIGhh
dmUgcHJvcGVydGllcyB0aGF0IHdlcmUgY29udGFpbmVkIGluc2lkZSBhIGJyYW5jaCB0aGF0IA0K
dGhlIHZhbGlkYXRpb24gb2YgdGhlIG5vZGUgd291bGQgbm90IGhhdmUgZ29uZSB0aHJvdWdoIHNp
bmNlIGl0IGNvbnRhaW5zIA0KYSBwYXR0ZXJuIHRoYXQgZG9lcyBub3QgbWF0Y2ggdGhlIGNvbmRp
dGlvbnMgb2YgdGhhdCBicmFuY2guDQoNCg0KPj4NCj4+DQo+Pj4+ICsgICAgdGhlbjoNCj4+Pj4g
KyAgICAgIGFsbE9mOg0KPj4+PiArICAgICAgICAtICRyZWY6IC9zY2hlbWFzL3NlcmlhbC9zZXJp
YWwueWFtbCMNCj4+Pj4gKyAgICAgICAgLSAkcmVmOiAvc2NoZW1hcy9zZXJpYWwvcnM0ODUueWFt
bCMNCj4+Pj4gKw0KPj4+PiArICAgICAgcHJvcGVydGllczoNCj4+Pj4gKyAgICAgICAgYXRtZWws
dXNlLWRtYS1yeDoNCj4+Pj4gKyAgICAgICAgICB0eXBlOiBib29sZWFuDQo+Pj4+ICsgICAgICAg
ICAgZGVzY3JpcHRpb246IHVzZSBvZiBQREMgb3IgRE1BIGZvciByZWNlaXZpbmcgZGF0YQ0KPj4+
PiArDQo+Pj4+ICsgICAgICAgIGF0bWVsLHVzZS1kbWEtdHg6DQo+Pj4+ICsgICAgICAgICAgdHlw
ZTogYm9vbGVhbg0KPj4+PiArICAgICAgICAgIGRlc2NyaXB0aW9uOiB1c2Ugb2YgUERDIG9yIERN
QSBmb3IgdHJhbnNtaXR0aW5nIGRhdGENCj4+Pj4gKw0KPj4+PiArICAgICAgICBhdG1lbCxmaWZv
LXNpemU6DQo+Pj4+ICsgICAgICAgICAgJHJlZjogL3NjaGVtYXMvdHlwZXMueWFtbCMvZGVmaW5p
dGlvbnMvdWludDMyDQo+Pj4+ICsgICAgICAgICAgZGVzY3JpcHRpb246DQo+Pj4+ICsgICAgICAg
ICAgICBNYXhpbXVtIG51bWJlciBvZiBkYXRhIHRoZSBSWCBhbmQgVFggRklGT3MgY2FuIHN0b3Jl
IGZvciBGSUZPDQo+Pj4+ICsgICAgICAgICAgICBjYXBhYmxlIFVTQVJUUy4NCj4+Pj4gKyAgICAg
ICAgICBlbnVtOiBbIDE2LCAzMiBdDQo+Pj4NCj4+PiBJIGRpZCBub3QgbWVudGlvbiBpdCBsYXN0
IHRpbWUsIGJ1dCBJIHRoaW5rIGl0IHNob3VsZCBmb2xsb3cgZ2VuZXJpYw0KPj4+IHByYWN0aWNl
LCBzbyBkZWZpbmUgYWxsIHByb3BlcnRpZXMgdG9wLWxldmVsIGFuZCBkaXNhbGxvdyB0aGVtIGZv
ciBvdGhlcg0KPj4+IHR5cGUuIFRoaXMgYWxsb3dzIHlvdSB0byBzaW1wbHkgdXNlIGFkZGl0aW9u
YWxQcm9wZXJ0aWVzOmZhbHNlIGF0IHRoZSBlbmQuDQo+Pj4NCj4+DQo+Pg0KPj4gV2hhdCB3b3Vs
ZCBiZSBhIGdvb2QgZXhhbXBsZSBiaW5kaW5nIGluIHRoaXMgY2FzZT8NCj4gDQo+IFRoZSBleGFt
cGxlIGJpbmRpbmcuDQo+IA0KPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC92NS4x
OS9zb3VyY2UvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL2V4YW1wbGUtc2NoZW1h
LnlhbWwjTDIxMg0KPiANCg0KDQpBaCwgSSB1bmRlcnN0YW5kIG5vdy4gSSBkaWQgbm90IGdldCB3
aGF0IHlvdSBtZWFudCBieSAiZGlzYWxsb3ciLCBJIA0KZ3Vlc3MgaXQncyBqdXN0IGEgInByb3Bl
cnR5LW5hbWU6IGZhbHNlIi4NClRoYW5rcyENCg0KDQo+Pg0KPj4NCj4+Pj4gKw0KPj4+PiArICAg
IGVsc2U6DQo+Pj4+ICsgICAgICBpZjoNCj4+Pj4gKyAgICAgICAgcHJvcGVydGllczoNCj4+Pj4g
KyAgICAgICAgICAkbm9kZW5hbWU6DQo+Pj4+ICsgICAgICAgICAgICBwYXR0ZXJuOiAiXnNwaUBb
MC05YS1mXSskIg0KPj4+PiArICAgICAgdGhlbjoNCj4+Pj4gKyAgICAgICAgYWxsT2Y6DQo+Pj4+
ICsgICAgICAgICAgLSAkcmVmOiAvc2NoZW1hcy9zcGkvc3BpLWNvbnRyb2xsZXIueWFtbCMNCj4+
Pj4gKw0KPj4+PiArICAgICAgICBwcm9wZXJ0aWVzOg0KPj4+PiArICAgICAgICAgIGF0bWVsLHVz
YXJ0LW1vZGU6DQo+Pj4+ICsgICAgICAgICAgICBjb25zdDogMQ0KPj4+PiArDQo+Pj4+ICsgICAg
ICAgICAgIiNzaXplLWNlbGxzIjoNCj4+Pj4gKyAgICAgICAgICAgIGNvbnN0OiAwDQo+Pj4+ICsN
Cj4+Pj4gKyAgICAgICAgICAiI2FkZHJlc3MtY2VsbHMiOg0KPj4+PiArICAgICAgICAgICAgY29u
c3Q6IDENCj4+Pg0KPj4+IFRoZSBzYW1lIC0gdG9wIGxldmVsIGFuZCBkaXNhbGxvdyB0aGVtIGZv
ciB1YXJ0Lg0KPj4+DQo+Pg0KPj4NCj4+IFRoZXNlIHZhbHVlcyBvZiAjc2l6ZS1jZWxscyBhbmQg
I2FkZHJlc3MtY2VsbHMgYXJlIG9ubHkgbWVhbnQgZm9yIHRoZQ0KPj4gU1BJIHNvIEkgZ3Vlc3Mg
SSB3b3VsZCBzdGlsbCBoYXZlIHRvIHNwZWNpZnkgdGhlaXIgbWFuZGF0b3J5IGNvbnN0DQo+PiB2
YWx1ZXMgaGVyZS4NCj4gDQo+IFN1cmUsIG9rLg0KPiANCj4+DQo+Pg0KPj4+PiArDQo+Pj4+ICsg
ICAgICAgIHJlcXVpcmVkOg0KPj4+PiArICAgICAgICAgIC0gYXRtZWwsdXNhcnQtbW9kZQ0KPj4+
PiArICAgICAgICAgIC0gIiNzaXplLWNlbGxzIg0KPj4+PiArICAgICAgICAgIC0gIiNhZGRyZXNz
LWNlbGxzIg0KPj4+DQo+Pj4gRW5kIGVsc2UgaW4gdGhpcyBicmFuY2ggaXMgd2hhdD8NCj4+Pg0K
Pj4NCj4+DQo+PiBZb3UgYXJlIHJpZ2h0LCBJIHdpbGwgcmVtb3ZlIHRoZSB1c2VsZXNzIGlmOiBh
ZnRlciBlbHNlOg0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiBLcnp5c3p0b2YNCg0KDQpSZWdhcmRz
LA0KCVNlcmdpdQ0K
