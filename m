Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E495A691E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiH3RAp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbiH3RAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:00:03 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A7CDF27;
        Tue, 30 Aug 2022 09:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661878786; x=1693414786;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yVVvW6u9AHugt31LLrrDXKaxVVvG8OAY12FkqELMbbM=;
  b=jzkaE2zy9UXHrrxWXpsAs3v7HSp9o+lUOUJKyHGzz64lRtFkS4bxpAyQ
   c3spYhBwI3252O6oiDIQ+tBE95drroPY+eeWzbn7V4+SgAVLZojHDqBNI
   QuCXVJVmZFYeG3ecqVDYcsYHKcVZzkCuSxp0VcuwaYhAGnOCdul7iKEzR
   bnXMKnuqCBRFqk9zEJ0tRH18nmT+ShVUJISUT2pWUws11p2+g0Y5GTiP7
   x7YGuZ9vuxEL+V+PRXK29LYEI5V7Q5u4ayF4UXi27XOtYoRypqy9CbhsG
   dfFDbBPUQ0L+v4oAR23MaHYHh1SCB0GswygBNDfFNJ/KRpbD9S8eaBlBy
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,275,1654585200"; 
   d="scan'208";a="178346728"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Aug 2022 09:59:29 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 30 Aug 2022 09:59:25 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 30 Aug 2022 09:59:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UC4IUw2SygGWVGayzW+Am2Qn21t2ZHAIRiGHe3YtttdM8Neb9NLjaCCl/Apmu1sldyCe0zt/X58kAkC/zxgQhRtWUjLI+Vo2VRC/+SMg06TbMHDtoOyip4maIicC8iKSaaHVcn50GwXAUhgcB6HnohFJXdAbGelUXPdbMTfoBsNVNp7kSjoBs9vEDAhBUPF9yGkLqTdE0P4F22SmoBcLuYyTg8cfIcmIxN0Rhwx4Zw9C7SfYiB+MWodEjMI0AfPysCJ2uShU+zku0kmaj8iB7AV9viaPp2HYYh0ku2llc84iW3t/kyAnfyV/Sxhz4OLmtASFhJymZ2INQ5q0acmjxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yVVvW6u9AHugt31LLrrDXKaxVVvG8OAY12FkqELMbbM=;
 b=Je0Unvli0i+w7w4k+u2Tx/ZqN1r9cOLu9f+9XLdiBtrn8JG7LmC5PBcMe6PpnqKDwGTTySWficpvFhcGR6F/XDJ0u2hpWxpBK9G3tNdsGcCVm/kLN9jg4OhIBdc5bRSLW1XOY6ZX3ktzlxL9Xg9KYvlchbn3pvTJ15982pTeOactMEonkGHrFwVoVkNQZNgP7MU3u1V1lzTJRjKC77cGYS5HhKQhSk5pPL9542+velXiXdvDhyZTWDvfCDSfRPUdcubPj9H40rjdKeOo30NdzeJw1x2vxjwppHm9tqlCrpI9305/q/19xZ2fwSBVCqjWttUkfbZGfKIQDwbzEwfVYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yVVvW6u9AHugt31LLrrDXKaxVVvG8OAY12FkqELMbbM=;
 b=g4a0ePTLFNoBAmSumZTT6tDD0HvpM+RAW3+g3YaBhkaoBjBjafQsj4Nesn+qPwCu/MDmFQMM87GbqB6WNZtSUJqZ9Y1dK5hrhmh8OHs2OtZsGNgAgHu6L9wllHZDqgcGfuFObBBN+ZiUfLG3c0cRebJ4CfeCTaHbvpDu5lyINns=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN8PR11MB3636.namprd11.prod.outlook.com (2603:10b6:408:8c::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 16:59:19 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 16:59:19 +0000
From:   <Conor.Dooley@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <Conor.Dooley@microchip.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Daire.McNamara@microchip.com>, <Shravan.Chippa@microchip.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <Cyril.Jean@microchip.com>,
        <Lewis.Hanly@microchip.com>, <Praveen.Kumar@microchip.com>,
        <wg@aries-embedded.de>, <Hugh.Breslin@microchip.com>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/9] dt-bindings: riscv: microchip: document the aries
 m100pfsevp
Thread-Topic: [PATCH v2 2/9] dt-bindings: riscv: microchip: document the aries
 m100pfsevp
Thread-Index: AQHYvFnwSpVLiReZPUWC5HM7xMt/UK3Hg2QAgAANgQCAABkagIAAAP2A
Date:   Tue, 30 Aug 2022 16:59:19 +0000
Message-ID: <69027950-f18d-c9a7-9f0b-d73ef68197c7@microchip.com>
References: <20220830101803.1456180-1-conor.dooley@microchip.com>
 <20220830101803.1456180-3-conor.dooley@microchip.com>
 <a3a8e2ba-a6bd-6e66-fd04-e3a46661a34d@linaro.org>
 <27b8aa9e-9173-b40e-8f9c-a53fa5ba36c8@microchip.com>
 <1065bc99-d73a-9d19-7f09-26cd862fe0c7@linaro.org>
In-Reply-To: <1065bc99-d73a-9d19-7f09-26cd862fe0c7@linaro.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a5994cc3-c752-4d53-4007-08da8aa8fae4
x-ms-traffictypediagnostic: BN8PR11MB3636:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qnIPXi5nZLZm+5kuq/HzK3Bxp1KtPzzO2vdagzgvDDnnH3hRB2tXFC8Yf9/zKYJJI4pcQK0cZfXgDRL/MfM6M3KCCEwVMuLHSvm2hC+bNZ1xRN4XoGmexDjWW9c/RyXaYu+f0EoFkxNCi3S+/fShcbExC4ur8j9m0UNtVdXz/M3qPt0HI5CurigUcrOHv5F73E/a417xSnRkHi3OK0k57SbQWvLe+I7nyXBr+NR1doAAWjuO0laRx8yzPpDq6UV7aGjNP+BSzNUWs50ehxSgjw9KZpwkUkwx9jsKdNQUKMImlSLCEOik+wzX00H/z7g7IeAVhLgq45q6fNPeqaUuEzeJjXc1kC7a0w5CyaFKO/iembRPjKfjIRO7UvtGw2lM1BtticpkVPF/qxnxEFvPgI3nLPbE3UR9DX7om8wEdy7082hsFUVNqjsId590ABy0gIaqugmgewuok6F+d+1MIWUadR/BjJRJOXx3lGycwcpANjPkQucJqMfme5jay0fVkuuTTL71CGKaeGMKR87p09nQs2nWFIHKFmS6vbcZoikmVu3K4M4dviW0zrzrfCuSPrp/A2jYEQw4o6CSrtPF+FRInlANJOnBvrEO4JZLWDVmFZVsp8I1i/MFXkm+DVCRz7m+ditU739s1km1xAAw4gFpkzXrYlLw58FB0zFYogd4Dy2ckN+rKawyocr+R20B6BFNteYXXDShfH/3Bc02WNfmitu1Mh0zVXLDghMmGC/Tlebd6+KzroHSudqmKXIvCXwFo42+DSgCXuM0ZsLPLQ14ildm0K4xbWqp4+6vV2vNxpipMXZQkqJFH0ZIyNXReiaH15ayJY/X7J3VxsbxWsYfoVm+sWW2c8P1fXAgRgo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(136003)(376002)(396003)(366004)(86362001)(31696002)(6512007)(7416002)(53546011)(26005)(38070700005)(71200400001)(478600001)(6486002)(6506007)(966005)(41300700001)(186003)(38100700002)(122000001)(83380400001)(2616005)(64756008)(66446008)(66476007)(110136005)(5660300002)(66556008)(6636002)(66946007)(8936002)(54906003)(4326008)(8676002)(31686004)(2906002)(316002)(36756003)(91956017)(76116006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTJWQmI3bzhJTGc3OEFIbGYxOEJINGdQSG9FQ3ZHdEY2eVQ4TlphS29FRGF5?=
 =?utf-8?B?VGZublJiL2w2VHVsR1ZHMmkxYzAzdVFHOWpBTmI2dExvYUJYQ2FyREsyVkU5?=
 =?utf-8?B?MWdaM3FQQkRpWHJhUVBWV0tudGY5MG96a1d4em5RMzRORW9OTXd4VzVDRG1D?=
 =?utf-8?B?SlNCbEV0SjBmK2VneHNDTHdqVlhlOEptVjZlWC91ZzA0bnRNWlZ3aXg0Umdh?=
 =?utf-8?B?dUEraHA2dERzMjJ6VGE2SHBzSHZPMjR2d0IvbW5Db3hqcUJhVDJ6TVZXM2E3?=
 =?utf-8?B?QjAyaUMwOXgrRmZlVW9vZFhqZzRNVS96QnduWDZZeUdIMXg1UFFiRGl0QzF2?=
 =?utf-8?B?U2NRWUFudTRNTVFZODFadkNiVTZZbkRoOFQxZFF4TkIzSHJYNmlZK0dxUEpW?=
 =?utf-8?B?bzVBVmxGVTJoaWxxMEVJcGtERUhlUWNVMHRkMm9LSTBCc0c0YmUwU01NSDNG?=
 =?utf-8?B?cHVKMVBxRXFYdk4vTThmRjM0dWNUcndyc21zbzZJaHNtMFNwbGJJR1c1dGZq?=
 =?utf-8?B?b1pNV0UwazVFVWVyN1FEVFJJODJ4aUgwcEsrUnlPSlN0Zy81T3gzazBFQU9M?=
 =?utf-8?B?NVpPZU5ZVmJSZk1wL2hBeE1LMUlFUXJBSzJTZC9hN2VtSktzT05XVVVOZG5Q?=
 =?utf-8?B?L0o5TFlHY3NqcDF5QVY1aWNxME0ydkx0ZnVVOHhXalJFM0I3YTByZkFJT0E3?=
 =?utf-8?B?TkFHRVBGWkpxOS96MGFQcE1TN3RhL2ZPeGVaeFhkbUR4RzQ4MWlPbHFiRzdE?=
 =?utf-8?B?NFp5TkNBa3orSFdsNms2cFF4anp4UFlYdmpEVFIzZWJTeWZLZ2FIS3kwM09n?=
 =?utf-8?B?VVNZMys1MnV3WW9WVFpDbGhzOWYyNWVpeGV6ZzhHNG1wbTFEMTUybTFwVm1a?=
 =?utf-8?B?N1FYcXhnQjBwaVMzV2ZpZlBOZWh2WU9yMFduTWhydEFkMElpUVRHNnRER1NP?=
 =?utf-8?B?cUVtaGYza3dpS0VwZUlldFUxMityNlhSdEYybVpGMnVJRXNWTGxkeVlDbkl5?=
 =?utf-8?B?dmlHck84d3ZPYXVIWGRma0V4ZEswMkt3YVQvRkJMSDkxdWdKSlY1cnUyRk5J?=
 =?utf-8?B?aHZDQnU0VTM1Uk9hRGdXYVY2cjFlNzhHZHVzeVJLd3ZzQVJJOExmZ0VTK1FW?=
 =?utf-8?B?M1dxNTU1eUV2czFBUm5ZZFdpSVB1MzF2K0NjbGVkMmtQcUU5V0dzd08rMC9I?=
 =?utf-8?B?K2hESmJ3K1ZQSTB1QjNMYnljb2pMLzNiNmJId0JLNUxaV1ZRSzhOYkZsNWZu?=
 =?utf-8?B?VTM3RjNacmZEYmNud1lydzdtRkZaUkljWjRDMHBST3NBZ3dqMGJseDBmdjFO?=
 =?utf-8?B?MFllblhZNVBRekgwRWxzZUs3bkRrSGlQUi9OOXllcEVLMUgzb1gwd09oOW5M?=
 =?utf-8?B?RDdKV3VEV1dzYlA4dHM4dEdlVXFKQk0xQXJsaGJYOCs5clhJSmJkQ0hWWlIv?=
 =?utf-8?B?R1RsSXRZeEV3OE9pdE4yNHdwMXVFY1FaNzZXSWErOTlKeFl6cjVGRXFoaTUz?=
 =?utf-8?B?djdxWkVXRGgwb0hYZGRjRFdjaHR6T0hpbUphckRNSU1zeFA4UENNM1N0QWc4?=
 =?utf-8?B?czB0bUV0Rnp2NjBkaVY1UEEwa005UGphWUVkUXVpVEFrSGY2amRyRUtSYWFl?=
 =?utf-8?B?VFhZcVlOZ2RZcHgyeWd5RkRYdGRod2FHNXNrY2NuZkxQRWtmSVA2TmEvYm1h?=
 =?utf-8?B?YjQ2ak1PQ1NWZzk4eHBLa2cyTHBjUGlndlZySVpQVWx2MzJnczNucVppUHk2?=
 =?utf-8?B?RFgzUlZSNEZaeUp1OERqNTNXQmI2KzVTYkEzVG85Wk51c1pmOFVvRmxiZnBw?=
 =?utf-8?B?QXZaeVRGekZONWJwbGk2RG9DMmVmKy9sK2hEOG9RRVRxWFNnN0dIUGRSWmY0?=
 =?utf-8?B?cmlONWhkVnVjWTNwYWh3aFk1N3BuY2JlTkQvWlRabFc1V1k5Yk5zNFpJb0pl?=
 =?utf-8?B?Y1F2MG1SYWgvcUNzdVhJL2dLc2NDL29ubW9zMERlTzlFQXhneFhFdGFqQ2Zw?=
 =?utf-8?B?OWl1WEdmYWVxWDFiVDFETVM2eHpIc2NONGo3SjE5Y0lQcnJjVHQ1Wk5aa1d5?=
 =?utf-8?B?V3U1RHVwOEdSYU5QUE9HNCtEWmdjNWJpaEhnVEo5eGpCdkxzeXVvOUdkYkti?=
 =?utf-8?B?U1phajZxalk5VlFnTXhKTjl2SE5qSnErbzJ2VG1HSE5mRlhHR29wd1BiOVZT?=
 =?utf-8?B?NlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <019978C7F39FA74FA02F905FFB17E0E3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5994cc3-c752-4d53-4007-08da8aa8fae4
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 16:59:19.4279
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1qgXR2vjqvMogXQFJ6I1BOpmA0rAIZ3I+Rj1XoXGbmPkpHp1SOtw0YiriJjgwUx4uOnV1/yQdrVeHZmrIUUX+0WCHN6K3bI2Y8Y+THeu+58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR11MB3636
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMzAvMDgvMjAyMiAxNzo1NSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gMzAv
MDgvMjAyMiAxODoyNSwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBPbiAz
MC8wOC8yMDIyIDE1OjM3LCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPj4+IEVYVEVSTkFM
IEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91
IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPj4+DQo+Pj4gT24gMzAvMDgvMjAyMiAxMzoxNywg
Q29ub3IgRG9vbGV5IHdyb3RlOg0KPj4+PiBBZGQgY29tcGF0aWJsZXMgZm9yIGJvdGggY29uZmln
dXJhdGlvbnMgb2YgdGhlIEFyaWVzIEVtYmVkZGVkDQo+Pj4+IE0xMDBQRlNFVlAgU09NICsgRVZL
IHBsYXRmb3JtLg0KPj4+Pg0KPj4+PiBMaW5rOiBodHRwczovL3d3dy5hcmllcy1lbWJlZGRlZC5j
b20vcG9sYXJmaXJlLXNvYy1mcGdhLW1pY3Jvc2VtaS1tMTAwcGZzLXNvbS1tcGZzMDI1dC1wY2ll
LXNlcmRlcw0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBt
aWNyb2NoaXAuY29tPg0KPj4+PiAtLS0NCj4+Pj4gIERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9i
aW5kaW5ncy9yaXNjdi9taWNyb2NoaXAueWFtbCB8IDMgKysrDQo+Pj4+ICAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvcmlzY3YvbWljcm9jaGlwLnlhbWwgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvcmlzY3YvbWljcm9jaGlwLnlhbWwNCj4+Pj4gaW5kZXggNDg1
OTgxZmJmYjRiLi4wNGViZDQ4Y2FhYTcgMTAwNjQ0DQo+Pj4+IC0tLSBhL0RvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9yaXNjdi9taWNyb2NoaXAueWFtbA0KPj4+PiArKysgYi9Eb2N1
bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcmlzY3YvbWljcm9jaGlwLnlhbWwNCj4+Pj4g
QEAgLTI3LDkgKzI3LDEyIEBAIHByb3BlcnRpZXM6DQo+Pj4+DQo+Pj4+ICAgICAgICAtIGl0ZW1z
Og0KPj4+PiAgICAgICAgICAgIC0gZW51bToNCj4+Pj4gKyAgICAgICAgICAgICAgLSBhcmllcyxt
MTAwcGZzZXZwLWVtbWMNCj4+Pj4gKyAgICAgICAgICAgICAgLSBhcmllcyxtMTAwcGZzZXZwLXNk
Y2FyZA0KPj4+DQo+Pj4gVXN1YWxseSBzZCBjYXJkIGlzIHBsdWdnYWJsZSwgc28gd2hhdCBpcyB0
aGUgYWN0dWFsIGRpZmZlcmVuY2UgaGVyZT8gRm9yDQo+Pj4gZXhhbXBsZSB0aGlzIG9uZToNCj4+
PiBodHRwczovL3Nob3AuYXJpZXMtZW1iZWRkZWQuZGUvZXZhbHVhdGlvbi1raXQvbS9tMTAwcGZz
ZXZwLzQ0NS9tMTAwcGZzZXZwLTI1MGJhYWINCj4+PiBoYXMgZU1NQyBhbmQgU0QgY2FyZC4uLg0K
Pj4NCj4+IFllYWgsIGJvdGggYXJlIHRoZXJlIGJ1dCBpdCBpcyBtdXhlZCBieSB0aGUgYm9vdGxv
YWRlciB1c2luZyBhIEdQSU8uIEZvcg0KPj4gaWNpY2xlIHRoaXMgaXMgZG9uZSBieSBhIG11eCBp
biB0aGUgRlBHQSBmYWJyaWMgaW5zdGVhZC4gVA0KPiANCj4gQWgsIHRoaXMgaXMgc3RpbGwganVz
dCBvbmUgTU1DIGNvbnRyb2xsZXIgLSBlaXRoZXIgYXMgZU1NQyBvciBhcyBTRC1jYXJkPw0KDQpZ
ZXMuDQoNCj4gDQo+PiB3IGR0cyB3ZXJlDQo+PiBuZWVkZWQgc28gdGhhdCB0aGUgZ3Bpby1ob2cg
Y291bGQgYmUgc2V0IGNvcnJlY3RseS4gT3V0IG9mIGN1cmlvc2l0eSwgSSBjYW4NCj4+IGhhdmUg
dGhlIHNhbWUgY29tcGF0aWJsZSBpbiBtdWx0aXBsZSBkZXZpY2V0cmVlcyByaWdodD8gSW4gdGhh
dCBjYXNlLCBpdA0KPj4gd291bGQganVzdCBiZSAiYXJpZXMsbTEwMHBmc2V2cCIgaGVyZSBhbmQg
SSBjb3VsZCBwdXQgdGhhdCBpbiBib3RoPw0KPj4gV291bGQgbWFrZSB0aGluZ3MgZWFzaWVyLi4N
Cj4gDQo+IERlcGVuZHMsIGJ1dCBJIHdvdWxkIHNheSBmb3IgdGhpcyBjYXNlIHJhdGhlciBub3Qu
IFRoZSBjb21wYXRpYmxlIHNob3VsZA0KPiBpZGVudGlmeSB0aGUgYm9hcmQuIElmIHRoZSBib2Fy
ZHMgYXJlIGRpZmZlcmVudCwgb25lIGNvbXBhdGlibGUgc2hvdWxkDQo+IG5vdCBpZGVudGlmeSBi
b3RoIG9mIHRoZW0uIEltYWdpbmUgVS1Cb290IChvciBzb21ldGhpbmcgZWxzZSkgdHJ5aW5nIHRv
DQo+IG1hdGNoIHRoZSBEVFMuDQoNCkl0IGlzIHRoZSBzYW1lIGJvYXJkIHRob3VnaCwgdGhlIHdh
eSB0aGUgYm9vdGxvYWRlciB3b3JrcyBpcyB0aGF0IGlmIGl0DQpkZXRlY3RzIGFuIFNELWNhcmQg
aXQgd2lsbCB1c2UgdGhhdCB0byBib290IGZyb20sIGFuZCBpZiBub3Qgd2lsbCBmYWxsIGJhY2sN
CnRvIHRoZSBlbW1jLg0KDQo=
