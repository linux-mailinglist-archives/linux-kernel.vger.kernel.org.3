Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19ED5B1626
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 10:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbiIHIAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 04:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiIHH75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 03:59:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57C9FDED7;
        Thu,  8 Sep 2022 00:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662623996; x=1694159996;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=4EwQRekZRM6OeQliAKCjLnr3kmKjkZcC3qRgvReZ09k=;
  b=XunYb1oJ3NvKLo3fElR8jvT8stl5ozZTGiQU2sKXCPK6pT3w0DPsyETS
   L7PuzUvIgoQ5J9owBl1/Nx1bGYNhhQ8EidM9xm6CQZwNdKB+hs67RQjBc
   O2d25qgft05bHSF5YMob+5EA5SibjirHEL04c4SPoLyt2Q865AGvJMoYI
   QOXbQfgMViQoMa0RXBpRlh/mJ6DevuqsncaetskLRs2m761/Hv2JyxcAG
   woF+bbBmehC5qbtI04iKUr5BQ5cClSp6HE8LhUjhKOq4KI7JG5KolZMpc
   HXXGGO+YhASGyTHpQHNr2dy1UnGjq3zOtknLw9IeMGCKHQq8bF9Ap8hfb
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="179650856"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2022 00:59:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Sep 2022 00:59:55 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 8 Sep 2022 00:59:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MUiGstvW56L5o5F2pXIl5r8tX6DPqv//h6qdmqE69NU/kgGntylZ4DvaphDiHSsP4EHbfypZFFftZdwZ7ofa7g8CK23fPfrhIE0HMe34zM2MyW6pVb8Y95GjHz7xLpCl9kWNcZdydAhxaSl9uTx8OAWFu9NyE4ndeeZQ4+L0jVZH4wnMu7ZAcTsbYYwN7X3pFkKB2wz1IsFzdq/CsaSLZggj2gUQvUvf7zwT9TOHo/Djyi+RHju6VuN5JYzN/sRAmOZgWYTGS1hcTOJclCreEvFoqKiFtryfHIgGG4X0UGCFihFJ7Jp3KB4a58/w78buzDHJ3IHw3Tl5N42ckEnAEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EwQRekZRM6OeQliAKCjLnr3kmKjkZcC3qRgvReZ09k=;
 b=Cl9Z5K9NOgeLBM8tUeUlXhIeDwsI6Inur+jPn8GvD+IWxCAhxbRF3aP6quAXbfeMJ+LgaZcHyQB1NgZf/eTjFXQp8CXf/PwOLO4fastuEE8o7fZVlVgk/86vbwdXoxogUpM8K+B0ahmSNoO0iu1Gx7EDVFEBA0JLWJ9QqEfaQKxMJUXOBsofMJnyu8ZrE9kdY5lgbpXc0CL2pRBNZJmFy7+2IXYgVUNSIcMFqFAxhnTE6z609MmdklA/LaMqJz+WmLM5SuNdS3E0p3V4mIyVhlQn2FnOydjqyq7/iJT1WHgjo+KO5iTt5qCkjDZLGvDYlQzHne6DCziFIQ42MvkjpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EwQRekZRM6OeQliAKCjLnr3kmKjkZcC3qRgvReZ09k=;
 b=oJ7T2YBvgzuUmiskfKxNwWMCSHg6rNkss71tMSE/Ji321FVn+6kz9Y3CiAFHNFe73he3bNA7NN+Prk9aX2D8R6FkzzhqRSUhq5CvusGjZaRRS7IZVSSUMSWzyObgnoUBmoinQV2ruah4sdS1J8hCTILy/lHn01CsROxkcMFuHdE=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BN6PR11MB4017.namprd11.prod.outlook.com (2603:10b6:405:79::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.16; Thu, 8 Sep
 2022 07:59:41 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::a159:97ec:24bc:6610%11]) with mapi id 15.20.5588.014; Thu, 8 Sep 2022
 07:59:41 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Hari.PrasathGE@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <davem@davemloft.net>, <krzysztof.kozlowski+dt@linaro.org>,
        <alexandre.belloni@bootlin.com>, <arnd@arndb.de>, <olof@lixom.net>,
        <soc@kernel.org>, <Manikandan.M@microchip.com>, <michael@walle.cc>,
        <Horatiu.Vultur@microchip.com>, <Kavyasree.Kotagiri@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Durai.ManickamKR@microchip.com>
Subject: Re: [linux][PATCH 2/6] ARM: dts: at91: sam9x60: Move flexcom
 definitions to the SoC dtsi
Thread-Topic: [linux][PATCH 2/6] ARM: dts: at91: sam9x60: Move flexcom
 definitions to the SoC dtsi
Thread-Index: AQHYw1jy6TUISGE3q0G5fsfvcJqDhQ==
Date:   Thu, 8 Sep 2022 07:59:41 +0000
Message-ID: <66ae978a-1356-555f-3e43-1e17021ceae7@microchip.com>
References: <20220907092054.29915-1-Hari.PrasathGE@microchip.com>
 <20220907092054.29915-3-Hari.PrasathGE@microchip.com>
In-Reply-To: <20220907092054.29915-3-Hari.PrasathGE@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 623ccf43-7cc1-47f8-b0ad-08da917015af
x-ms-traffictypediagnostic: BN6PR11MB4017:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xZ+vIWJCcJAWjfNrvCy+qZUmbto6w35DsERbDpBbt7c8ITy9U0QCt2xziKCLmzku7unkzyrBd7p8MOdSNsHR4ylL9+JVuclpgS6JzyLs6m4BMU4pYsWdK8lnGvZ367K1py0X7oY+2V3UmgHTE1ZQ+2fhhXQs5+V2ZI1A6VNTpKKTRLH71g/93sa90+t33u4sOchZOlITFK7ZMPfLJUuGy4gLdyYOb3ozhtYHZuPumuF4UM7Bet1/u49rTRZdMb0V3Ywc2wYD830RIYNPS7d1UdESdGJ3aOLM8P+fNMfo4pORts6BVjc9GGn4wDhbCHRE74jjVPn0xhNoxQe4taEu8XVIqUUGOk6ieurV7eoOaTL+dFWO0jA+glacLx6zTA/Zhcan+zqy/0mqwiUuYTHTvYl0R99Ml9FEkYMRNZzxNGpRHfRJyKgkOgs/8AV1P8+hs+X4e5JTVUFRbqann1+L2HL7Ddx4RmAxLr0F2IRqG0eWTs6MsqXitnQpkYWlIkFS2F0g1sAbU5Q2M7c4jdj0EiQBBfnyYwxrkaThHF916jWjdiHmGeqE6ZaBo3sr2GQCRWGegMsiSDYG2lo3f5NkseDOzQwJzJ73Gm+eHEv95Ta6IrEV/ZI6kO2uOW3j9tvzs5vBdx8WHdyu7OZSAZSUiEGpLk05HxyW66BqfrE0XChpErOzPiXKKHDAVhybcHLtAG8jWhIqHzJfud4pSK0STKXGjhgOdkn70HRQBexk6etgwc3LCVl4IJsDU8NT+2+w3X6WeRQJ+j9SZEDpCjlxWyJN/7caabfl9t6h/XjHC3WVI6fDiwHbYtfMOYlAIFi27nzDQ1q3EgyDHBZ5krRHPTkozhN0sJHuPUqsYtn8yKI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(396003)(39860400002)(376002)(366004)(41300700001)(26005)(6506007)(71200400001)(478600001)(66446008)(76116006)(91956017)(64756008)(66556008)(66476007)(2906002)(6636002)(921005)(86362001)(31696002)(38070700005)(31686004)(36756003)(316002)(110136005)(6512007)(6486002)(53546011)(38100700002)(122000001)(66946007)(186003)(2616005)(8676002)(8936002)(7416002)(5660300002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cG1ic0FOSzdPYzJLaDlrNmh6QStycTRlQ0ViWklxU3NPZERLZTM4ZUtGSDli?=
 =?utf-8?B?NXRlT0g2WCtYaTd6cXJxRUFadEtIRFFWY05yY1NwbzFPaEc0R3E0TWU3K203?=
 =?utf-8?B?YzZXL3NTVzNSbDVoandCMlVPM1plMFd3ZDIyb1FIMS9ReHM0OC9sbGNzVXN4?=
 =?utf-8?B?WVlpUzh5dU5PbU8rNlk2SXIvWSt1NElxWTVKclA0RS9ZbHFDMmlZRXlLWWE0?=
 =?utf-8?B?ejdNK3JQeGZ1cnVLYU9EL2wxekJQaFJ2OFJvV2hGUVFIWVZsU0NodXRLdHZL?=
 =?utf-8?B?RlFYYWVORTA2a0M3RVoxU1BjZXZPbHBiWlh6bnhEK3A3T2hCNGFtQWFSRVRZ?=
 =?utf-8?B?aHluaTVPSWN1U3QwU21wNVlDMXVNc1ZXbnU2RUZXeU9hWkljZWRJT1pqM0hE?=
 =?utf-8?B?RlVKK013KytUdWQ2aFBIbmNhSHc3SktLV3BNaktveGtqVnh3QkFsS0FvS004?=
 =?utf-8?B?Vlc0dmtsRUZSVys4RS81cGV0cytkUXc2L0RmTUZIL2w5SmZaNHdGOTl2MDk4?=
 =?utf-8?B?NTR1eU1XU3ErVGl1NzZRaTJxRjBhbTRTY29PeXhUMnVoRnBEMkFVbG5Ud1lQ?=
 =?utf-8?B?bjVYRm5ndHY3anRsL3FzRjdoZDVjMzBYakplL3dnWkVKazFFcVZNdVBNa2c4?=
 =?utf-8?B?b1ZGbDFxdEhyTDRNUEtOcmFBTjI5bVBldzVmQ09BYmxlVkQzcWY1ZlU3MHg5?=
 =?utf-8?B?YTdjeXZldXZMcUt0MWk0Y3Q1TUlqUUQ2Y2NyWjE1TnowUzJlV0tSYnBSNFNF?=
 =?utf-8?B?a0ZmOWZLZGMrZ1h0ck1ESS9zV1FrR3JqQzNUM0RtTEN0NG9VeU1XaWVJQW1Q?=
 =?utf-8?B?aDhERTNPdCtIMHMrLzczdkRJK1RLd2lUOVY4MHpEZE5maHExVmgxU3JwVElO?=
 =?utf-8?B?bkI2Vk1yMWxMK1RkVzdGcC9ieEZZTnJaYVM5TUN1UFVJem5NZDJOSHNnVWMr?=
 =?utf-8?B?bHFOSFNlVXVKSzB4N1d1TFhvLy95YkYwcENhZ3pQSGpaelBPYTJBYXdhRGds?=
 =?utf-8?B?RHpqU3NjbEl1dGRpd2l4a2l1L0dYbjI5ZjJqQ3NmVHdUc2V3NVJ5bExMUG9B?=
 =?utf-8?B?YzNMczduY1FzVndVV2hTUHpXcExjSzBxRkMvQS9BUzUxbVc3SVFkVkc5eHpG?=
 =?utf-8?B?ZXQydWdrRmZmWkY3UWxmRjJKSlQ0Q0d2ajFYRDhnRU9hbEN6T09yY21mY1M5?=
 =?utf-8?B?VGtvV1VabDE4N0c0d3diK1R5M0NUeGQ1SW13ZDdxNmFiY2h3OXJkQm9ZSlNj?=
 =?utf-8?B?bGMrVmNqdEt2Ukp5eWdoZXJmbjRpNUNNZFdQUnpkdUlkTGJkUS93ODBJMTFW?=
 =?utf-8?B?OUR0VWFucDkrTjJmNWRycngxYk9MUVROZjRGMXFoSys3d1pqbUUwc2RRS2tB?=
 =?utf-8?B?THFuY1ZMV0hvNEw2MWZxTTFsaTZRNFg0cUhWWTJTWUNhSk42ODlVUHBGdmFD?=
 =?utf-8?B?RjdhS1ArSWJKTU9objEwMVZZekh2elQ4UVRjc1RpWkZmZ1k3YlZqb01OWGd2?=
 =?utf-8?B?V2ZDM25vd2t1eXlDMWcwdXF3WHNpNW1qaU1pRnB3blIyVG1maW10Nm5vMWNo?=
 =?utf-8?B?ZVJ4dUV0b0RrNHJoNDBUYWdLYjhDNDlKRlBqTTdUM002VUwwMVpLZXdDdWFL?=
 =?utf-8?B?TVJ4Ky9nUFh0a3hhMFhFSVl1Tk5RUWNJeDViaEE2b2JKV2tGNGlYeC9JOWc4?=
 =?utf-8?B?MlNsbW56Mkg5cDBZQ0QwR3BmbWpXL2RXajcvT3BwZUY0TUVHRm10MUlFSGcy?=
 =?utf-8?B?UlRiYjNGOFpFc2UvV2EweVlmcnZzSXN0ZWxRZVBLdVRlU1FtMnZqQmRPamJJ?=
 =?utf-8?B?UldsLzNTVTBtMlpNUWM0Zm1CWTJ0UnhyaUEzMVdRNHFrRFAvV0hJbkhsS2xy?=
 =?utf-8?B?US9iNnFoY1B5dG1naWdQVnVRTlFnM3N6Tk4vNUhVT3k4czduMTRuNzRPY1ND?=
 =?utf-8?B?UWR0bU5YenYwZGd5TEtXV25NWit6OGR4YmFUbmNvWkQwWCtiT3V0MmF0dlFN?=
 =?utf-8?B?RW4ydVoyZ3l5RzVQeUFaRXRuUmdkaWRlcWxRcTZDRHAvV1dZeVc2WEhNSjBx?=
 =?utf-8?B?WXdpd3dSN0pacm4ySjdQNEVaSzdJa0tXeEtNb1B0R3FweVl6ZEE4TDhlTEZl?=
 =?utf-8?B?VFVGbGdRSE9pZmdyejNYTnRxVEpzS3NUZlhaZzhValJQQ1ZmRGpCQlB3UVov?=
 =?utf-8?B?eGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B66DBF05C70EF4EB0E71BDCF11D1DFD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 623ccf43-7cc1-47f8-b0ad-08da917015af
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 07:59:41.2078
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UHD01Oz/c860sB//50z3IDnVEm9uHHV2PyJyJ3xJmPlyd+TNUbQLNTkIguQR3sRGlFYoFaZxMrg3NIgnCgRQzpf6tbaZ6w81GRcPQWptKkU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4017
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcuMDkuMjAyMiAxMjoyMCwgSGFyaSBQcmFzYXRoIHdyb3RlOg0KPiBNb3ZlIHRoZSBmbGV4
Y29tIGRlZmluaXRpb25zIHRvIHRoZSBTb0Mgc3BlY2lmYyBEVFNJIGZpbGUgcmV0YWluaW5nIG9u
bHkNCj4gdGhlIHBpbm11eCBhbmQgZGVzaXJlZCBmdW5jdGlvbnMgaW4gdGhlIGJvYXJkIHNwZWNp
ZmljIERUUyBmaWxlIG9mDQo+IHNhbTl4NjBlay4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEhhcmkg
UHJhc2F0aCA8SGFyaS5QcmFzYXRoR0VAbWljcm9jaGlwLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTog
TWFuaWthbmRhbiBNIDxtYW5pa2FuZGFuLm1AbWljcm9jaGlwLmNvbT4NCj4gU2lnbmVkLW9mZi1i
eTogRHVyYWkgTWFuaWNrYW0gS1IgPGR1cmFpLm1hbmlja2Fta3JAbWljcm9jaGlwLmNvbT4NCj4g
LS0tDQo+ICBhcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbTl4NjBlay5kdHMgfCAzNCArLS0tLS0t
LS0tLS0tLS0tLS0NCj4gIGFyY2gvYXJtL2Jvb3QvZHRzL3NhbTl4NjAuZHRzaSAgICAgICB8IDUy
ICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gIDIgZmlsZXMgY2hhbmdlZCwgNTEgaW5z
ZXJ0aW9ucygrKSwgMzUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0v
Ym9vdC9kdHMvYXQ5MS1zYW05eDYwZWsuZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW05
eDYwZWsuZHRzDQo+IGluZGV4IGI5YjdhMjM1ZWY4OS4uOWQ5ZTUwYzc3Nzk0IDEwMDY0NA0KPiAt
LS0gYS9hcmNoL2FybS9ib290L2R0cy9hdDkxLXNhbTl4NjBlay5kdHMNCj4gKysrIGIvYXJjaC9h
cm0vYm9vdC9kdHMvYXQ5MS1zYW05eDYwZWsuZHRzDQo+IEBAIC0yMTEsMTUgKzIxMSwxMCBAQA0K
PiAgCXN0YXR1cyA9ICJva2F5IjsNCj4gIA0KPiAgCWkyYzA6IGkyY0A2MDAgew0KPiAtCQljb21w
YXRpYmxlID0gIm1pY3JvY2hpcCxzYW05eDYwLWkyYyI7DQo+IC0JCXJlZyA9IDwweDYwMCAweDIw
MD47DQo+IC0JCWludGVycnVwdHMgPSA8NSBJUlFfVFlQRV9MRVZFTF9ISUdIIDc+Ow0KPiAgCQkj
YWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gIAkJI3NpemUtY2VsbHMgPSA8MD47DQo+IC0JCWNsb2Nr
cyA9IDwmcG1jIFBNQ19UWVBFX1BFUklQSEVSQUwgNT47DQo+ICAJCXBpbmN0cmwtbmFtZXMgPSAi
ZGVmYXVsdCI7DQo+ICAJCXBpbmN0cmwtMCA9IDwmcGluY3RybF9mbHgwX2RlZmF1bHQ+Ow0KPiAt
CQlhdG1lbCxmaWZvLXNpemUgPSA8MTY+Ow0KPiAgCQlpMmMtYW5hbG9nLWZpbHRlcjsNCj4gIAkJ
aTJjLWRpZ2l0YWwtZmlsdGVyOw0KPiAgCQlpMmMtZGlnaXRhbC1maWx0ZXItd2lkdGgtbnMgPSA8
MzU+Ow0KPiBAQCAtMjM5LDE2ICsyMzQsOCBAQA0KPiAgCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+
ICANCj4gIAlzcGk0OiBzcGlANDAwIHsNCj4gLQkJY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsc2Ft
OXg2MC1zcGkiLCAiYXRtZWwsYXQ5MXJtOTIwMC1zcGkiOw0KPiAtCQlyZWcgPSA8MHg0MDAgMHgy
MDA+Ow0KPiAtCQlpbnRlcnJ1cHRzID0gPDEzIElSUV9UWVBFX0xFVkVMX0hJR0ggNz47DQo+IC0J
CWNsb2NrcyA9IDwmcG1jIFBNQ19UWVBFX1BFUklQSEVSQUwgMTM+Ow0KPiAtCQljbG9jay1uYW1l
cyA9ICJzcGlfY2xrIjsNCj4gIAkJcGluY3RybC1uYW1lcyA9ICJkZWZhdWx0IjsNCj4gIAkJcGlu
Y3RybC0wID0gPCZwaW5jdHJsX2ZseDRfZGVmYXVsdD47DQo+IC0JCWF0bWVsLGZpZm8tc2l6ZSA9
IDwxNj47DQo+IC0JCSNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiAtCQkjc2l6ZS1jZWxscyA9IDww
PjsNCg0KVGhpcyBpcyBub3QgbW92ZWQgaXQgaXMgZGVsZXRlZCwgaXQgc2hvdWxkIGdvIGluIGEg
ZGlmZmVyZW50IHBhdGNoLg0KDQo+ICAJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICAJfTsNCj4g
IH07DQo+IEBAIC0yNTgsMjIgKzI0NSw4IEBADQo+ICAJc3RhdHVzID0gIm9rYXkiOw0KPiAgDQo+
ICAJdWFydDU6IHNlcmlhbEAyMDAgew0KPiAtCQljb21wYXRpYmxlID0gIm1pY3JvY2hpcCxzYW05
eDYwLXVzYXJ0IiwgImF0bWVsLGF0OTFzYW05MjYwLXVzYXJ0IjsNCj4gLQkJcmVnID0gPDB4MjAw
IDB4MjAwPjsNCj4gLQkJaW50ZXJydXB0cyA9IDwxNCBJUlFfVFlQRV9MRVZFTF9ISUdIIDc+Ow0K
PiAtCQlkbWFzID0gPCZkbWEwDQo+IC0JCQkoQVQ5MV9YRE1BQ19EVF9NRU1fSUYoMCkgfCBBVDkx
X1hETUFDX0RUX1BFUl9JRigxKSB8DQo+IC0JCQkgQVQ5MV9YRE1BQ19EVF9QRVJJRCgxMCkpPiwN
Cj4gLQkJICAgICAgIDwmZG1hMA0KPiAtCQkJKEFUOTFfWERNQUNfRFRfTUVNX0lGKDApIHwgQVQ5
MV9YRE1BQ19EVF9QRVJfSUYoMSkgfA0KPiAtCQkJIEFUOTFfWERNQUNfRFRfUEVSSUQoMTEpKT47
DQo+IC0JCWRtYS1uYW1lcyA9ICJ0eCIsICJyeCI7DQo+IC0JCWNsb2NrcyA9IDwmcG1jIFBNQ19U
WVBFX1BFUklQSEVSQUwgMTQ+Ow0KPiAtCQljbG9jay1uYW1lcyA9ICJ1c2FydCI7DQo+IC0JCXBp
bmN0cmwtMCA9IDwmcGluY3RybF9mbHg1X2RlZmF1bHQ+Ow0KPiAgCQlwaW5jdHJsLW5hbWVzID0g
ImRlZmF1bHQiOw0KPiAtCQlhdG1lbCx1c2UtZG1hLXJ4Ow0KPiAtCQlhdG1lbCx1c2UtZG1hLXR4
Ow0KPiArCQlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfZmx4NV9kZWZhdWx0PjsNCj4gIAkJc3RhdHVz
ID0gIm9rYXkiOw0KPiAgCX07DQo+ICB9Ow0KPiBAQCAtMjgzLDE1ICsyNTYsMTAgQEANCj4gIAlz
dGF0dXMgPSAib2theSI7DQo+ICANCj4gIAlpMmM2OiBpMmNANjAwIHsNCj4gLQkJY29tcGF0aWJs
ZSA9ICJtaWNyb2NoaXAsc2FtOXg2MC1pMmMiOw0KPiAtCQlyZWcgPSA8MHg2MDAgMHgyMDA+Ow0K
PiAtCQlpbnRlcnJ1cHRzID0gPDkgSVJRX1RZUEVfTEVWRUxfSElHSCA3PjsNCj4gIAkJI2FkZHJl
c3MtY2VsbHMgPSA8MT47DQo+ICAJCSNzaXplLWNlbGxzID0gPDA+Ow0KPiAtCQljbG9ja3MgPSA8
JnBtYyBQTUNfVFlQRV9QRVJJUEhFUkFMIDk+Ow0KPiAgCQlwaW5jdHJsLW5hbWVzID0gImRlZmF1
bHQiOw0KPiAgCQlwaW5jdHJsLTAgPSA8JnBpbmN0cmxfZmx4Nl9kZWZhdWx0PjsNCj4gLQkJYXRt
ZWwsZmlmby1zaXplID0gPDE2PjsNCj4gIAkJaTJjLWFuYWxvZy1maWx0ZXI7DQo+ICAJCWkyYy1k
aWdpdGFsLWZpbHRlcjsNCj4gIAkJaTJjLWRpZ2l0YWwtZmlsdGVyLXdpZHRoLW5zID0gPDM1PjsN
Cj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL3NhbTl4NjAuZHRzaSBiL2FyY2gvYXJt
L2Jvb3QvZHRzL3NhbTl4NjAuZHRzaQ0KPiBpbmRleCBkM2Y2MGY2YTQ1NmQuLmYwZTBkYzIwZGUx
YiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvc2FtOXg2MC5kdHNpDQo+ICsrKyBi
L2FyY2gvYXJtL2Jvb3QvZHRzL3NhbTl4NjAuZHRzaQ0KPiBAQCAtMTY5LDYgKzE2OSwxNiBAQA0K
PiAgCQkJCSNzaXplLWNlbGxzID0gPDE+Ow0KPiAgCQkJCXJhbmdlcyA9IDwweDAgMHhmMDAwMDAw
MCAweDgwMD47DQo+ICAJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gKw0KPiArCQkJCXNwaTQ6
IHNwaUA0MDAgew0KPiArCQkJCQljb21wYXRpYmxlID0gIm1pY3JvY2hpcCxzYW05eDYwLXNwaSIs
ICJhdG1lbCxhdDkxcm05MjAwLXNwaSI7DQo+ICsJCQkJCXJlZyA9IDwweDQwMCAweDIwMD47DQo+
ICsJCQkJCWludGVycnVwdHMgPSA8MTMgSVJRX1RZUEVfTEVWRUxfSElHSCA3PjsNCj4gKwkJCQkJ
Y2xvY2tzID0gPCZwbWMgUE1DX1RZUEVfUEVSSVBIRVJBTCAxMz47DQo+ICsJCQkJCWNsb2NrLW5h
bWVzID0gInNwaV9jbGsiOw0KPiArCQkJCQlhdG1lbCxmaWZvLXNpemUgPSA8MTY+Ow0KPiArCQkJ
CQlzdGF0dXMgPSAiZGlzYWJsZWQiOw0KPiArCQkJCX07DQo+ICAJCQl9Ow0KPiAgDQo+ICAJCQlm
bHg1OiBmbGV4Y29tQGYwMDA0MDAwIHsNCj4gQEAgLTE3OSw2ICsxODksMjYgQEANCj4gIAkJCQkj
c2l6ZS1jZWxscyA9IDwxPjsNCj4gIAkJCQlyYW5nZXMgPSA8MHgwIDB4ZjAwMDQwMDAgMHg4MDA+
Ow0KPiAgCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICsNCj4gKwkJCQl1YXJ0NTogc2VyaWFs
QDIwMCB7DQo+ICsJCQkJCWNvbXBhdGlibGUgPSAibWljcm9jaGlwLHNhbTl4NjAtdXNhcnQiLCAi
YXRtZWwsYXQ5MXNhbTkyNjAtdXNhcnQiOw0KPiArCQkJCQlyZWcgPSA8MHgyMDAgMHgyMDA+Ow0K
PiArCQkJCQlpbnRlcnJ1cHRzID0gPDE0IElSUV9UWVBFX0xFVkVMX0hJR0ggNz47DQo+ICsJCQkJ
CWRtYXMgPSA8JmRtYTANCj4gKwkJCQkJCShBVDkxX1hETUFDX0RUX01FTV9JRigwKSB8DQo+ICsJ
CQkJCQkgQVQ5MV9YRE1BQ19EVF9QRVJfSUYoMSkgfA0KPiArCQkJCQkJIEFUOTFfWERNQUNfRFRf
UEVSSUQoMTApKT4sDQo+ICsJCQkJCQk8JmRtYTANCj4gKwkJCQkJCShBVDkxX1hETUFDX0RUX01F
TV9JRigwKSB8DQo+ICsJCQkJCQkgQVQ5MV9YRE1BQ19EVF9QRVJfSUYoMSkgfA0KPiArCQkJCQkJ
IEFUOTFfWERNQUNfRFRfUEVSSUQoMTEpKT47DQo+ICsJCQkJCWRtYS1uYW1lcyA9ICJ0eCIsICJy
eCI7DQo+ICsJCQkJCWNsb2NrcyA9IDwmcG1jIFBNQ19UWVBFX1BFUklQSEVSQUwgMTQ+Ow0KPiAr
CQkJCQljbG9jay1uYW1lcyA9ICJ1c2FydCI7DQo+ICsJCQkJCWF0bWVsLHVzZS1kbWEtcng7DQo+
ICsJCQkJCWF0bWVsLHVzZS1kbWEtdHg7DQo+ICsJCQkJCXN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+
ICsJCQkJfTsNCj4gIAkJCX07DQo+ICANCj4gIAkJCWRtYTA6IGRtYS1jb250cm9sbGVyQGYwMDA4
MDAwIHsNCj4gQEAgLTM3OCw2ICs0MDgsMTUgQEANCj4gIAkJCQkjc2l6ZS1jZWxscyA9IDwxPjsN
Cj4gIAkJCQlyYW5nZXMgPSA8MHgwIDB4ZjgwMTAwMDAgMHg4MDA+Ow0KPiAgCQkJCXN0YXR1cyA9
ICJkaXNhYmxlZCI7DQo+ICsNCj4gKwkJCQlpMmM2OiBpMmNANjAwIHsNCj4gKwkJCQkJY29tcGF0
aWJsZSA9ICJtaWNyb2NoaXAsc2FtOXg2MC1pMmMiOw0KPiArCQkJCQlyZWcgPSA8MHg2MDAgMHgy
MDA+Ow0KPiArCQkJCQlpbnRlcnJ1cHRzID0gPDkgSVJRX1RZUEVfTEVWRUxfSElHSCA3PjsNCj4g
KwkJCQkJY2xvY2tzID0gPCZwbWMgUE1DX1RZUEVfUEVSSVBIRVJBTCA5PjsNCj4gKwkJCQkJYXRt
ZWwsZmlmby1zaXplID0gPDE2PjsNCj4gKwkJCQkJc3RhdHVzID0gImRpc2FibGVkIjsNCj4gKwkJ
CQl9Ow0KPiAgCQkJfTsNCj4gIA0KPiAgCQkJZmx4NzogZmxleGNvbUBmODAxNDAwMCB7DQo+IEBA
IC00MDQsMTAgKzQ0MywxOSBAQA0KPiAgCQkJCWNvbXBhdGlibGUgPSAiYXRtZWwsc2FtYTVkMi1m
bGV4Y29tIjsNCj4gIAkJCQlyZWcgPSA8MHhmODAxYzAwMCAweDIwMD47DQo+ICAJCQkJY2xvY2tz
ID0gPCZwbWMgUE1DX1RZUEVfUEVSSVBIRVJBTCA1PjsNCj4gLQkJCQkjYWRkcmVzcy1jZWxscyA9
IDwxPjsNCj4gLQkJCQkjc2l6ZS1jZWxscyA9IDwxPjsNCg0KVGhpcyBzaG91bGQgcmVtYWluIGhl
cmUuDQoNCj4gIAkJCQlyYW5nZXMgPSA8MHgwIDB4ZjgwMWMwMDAgMHg4MDA+Ow0KPiAgCQkJCXN0
YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICsNCj4gKwkJCQlpMmMwOiBpMmNANjAwIHsNCj4gKwkJCQkJ
Y29tcGF0aWJsZSA9ICJtaWNyb2NoaXAsc2FtOXg2MC1pMmMiOw0KPiArCQkJCQlyZWcgPSA8MHg2
MDAgMHgyMDA+Ow0KPiArCQkJCQlpbnRlcnJ1cHRzID0gPDUgSVJRX1RZUEVfTEVWRUxfSElHSCA3
PjsNCj4gKwkJCQkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ICsJCQkJCSNzaXplLWNlbGxzID0g
PDA+Ow0KPiArCQkJCQljbG9ja3MgPSA8JnBtYyBQTUNfVFlQRV9QRVJJUEhFUkFMIDU+Ow0KPiAr
CQkJCQlhdG1lbCxmaWZvLXNpemUgPSA8MTY+Ow0KPiArCQkJCQlzdGF0dXMgPSAiZGlzYWJsZWQi
Ow0KPiArCQkJCX07DQo+ICAJCQl9Ow0KPiAgDQo+ICAJCQlmbHgxOiBmbGV4Y29tQGY4MDIwMDAw
IHsNCg0K
