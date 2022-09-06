Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD495AE947
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 15:19:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240397AbiIFNTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 09:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233500AbiIFNTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 09:19:07 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640666E2EB;
        Tue,  6 Sep 2022 06:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662470347; x=1694006347;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vT9HrR6f3nlqd7aqU/8hmOdyRMfanjqeG0o3KxMWu8I=;
  b=Qjz2ocjInrBl4QITA7pEEplUWUn01tmxLcTOgLMl0UumMvcCEVUbTDV7
   z5HkZapYVyAc9oJ8zun+M2Lqzugenby/MZe15gSBpOs9nLfxGVlmKuShb
   ZQUuwG0KymJwryU5X5BzLpYYFd5PZ8Me9MYoQKGG0AkxqBwa1/rmbkHYn
   X7uAj+JsS+XQ6vGjdbK/RFDZTyNm4b8U8GPb+lMEow11Icm+zwNcrZFQM
   sTIyAaqTSrNYnPXzgqwVCQUhBbMQQvsTgOeiECeC6z7vl3Tl811JXqeUf
   fNn+eWTNVGcsaz/F9DqfFNpMDa/Q/AtWXLDX0oW+NWvDABfqOHjP2C6pi
   A==;
X-IronPort-AV: E=Sophos;i="5.93,294,1654585200"; 
   d="scan'208";a="172585203"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Sep 2022 06:19:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Tue, 6 Sep 2022 06:19:05 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Tue, 6 Sep 2022 06:19:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDCFlIyXJk8hicJ+fknbvmVQGeiMmSMjp3LjSuBP6+YPekTmc8jAEHV9JR3syZ15QfqStu57D65NAd+ydGjEE5A05JCY5SBz+lquy7hCiEUzFA9+bL6yJwPmMQDYcJzbjjbLvkaXdPUuFqS3gW8BegQw4imhfylDi2vwak8mr+jPNnj8MqIZpgD0d7+ugjNzbDPB9bKDwjQdaei/56s9zPYKwdK4/SKucKYRb90P89IWiolMzsHKseQ0AO7A95cZk0hIRxVpe6sdNRlvW+JEY+pwZT1I4J73U1C5ddTKBRHIoX+kN9mtcRu4rxRaQMfR2k5gBHzBtX357jkNgMYLcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vT9HrR6f3nlqd7aqU/8hmOdyRMfanjqeG0o3KxMWu8I=;
 b=G3oIOUWsDvQ0ntdrTjkXvrUPexqeh7Ix6PQDIkiRbTorqwEMiqYEPaQXa/CELuhJpvVf2cZcfS3MnwkG1sjPAkN13r9katu9fXMv3Y89jWbn43u7uw0xfQahDrcuBbZKLJydvqAyLbRMhyaNTdwQjMTjaSybW3gUa9rvMHua/GOJ0eDJ8du5lWQ8goyZ2qMHSfcC0fFEEj0TnIQQ0Dvq0BgRbAnlw1RU/EjLeP74UC3Hxm43NsBz2VMVMxbCkd0xO9xkWmabPlADmEAuRpYFP2BNEWsSy76gIGPLmwzI8zZUbsJMctFOCNo/9TSJ+obDX0YnaryTHkAeNgGiZhoY2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vT9HrR6f3nlqd7aqU/8hmOdyRMfanjqeG0o3KxMWu8I=;
 b=D6rOQNPodM5j/yRaTTzFjUmE8KUwr2Da1ADs9cqG5Bu2UuVb8f7vbo3/OY/+CsPLddjUOD1XRyE8CBbcajTMTSPJUuihzY4t6pBE/9SX03ZYuWyGkpWgVjuQeU4bzMIGolVRlfxfvGtyqnL1bszrzjLpH/TkX3lJWU/O5+yzQUU=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SJ0PR11MB4877.namprd11.prod.outlook.com (2603:10b6:a03:2d9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Tue, 6 Sep
 2022 13:19:03 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::545a:72f5:1940:e009%3]) with mapi id 15.20.5588.018; Tue, 6 Sep 2022
 13:19:02 +0000
From:   <Conor.Dooley@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>,
        <Daire.McNamara@microchip.com>
CC:     <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 3/3] riscv: dts: microchip: add a devicetree for the
 Aldec TySoM
Thread-Topic: [PATCH v1 3/3] riscv: dts: microchip: add a devicetree for the
 Aldec TySoM
Thread-Index: AQHYwep2/OhY7h1hMU6Rq5t8qhTyJ63SYKUAgAAB54A=
Date:   Tue, 6 Sep 2022 13:19:02 +0000
Message-ID: <796f7dd4-8a72-e621-1c3a-e242f8b54631@microchip.com>
References: <20220906121525.3212705-1-conor.dooley@microchip.com>
 <20220906121525.3212705-4-conor.dooley@microchip.com>
 <71dad0f0-db66-e79e-5e01-d5fc66b0cb3e@linaro.org>
In-Reply-To: <71dad0f0-db66-e79e-5e01-d5fc66b0cb3e@linaro.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 894b8f57-b729-4939-d26a-08da900a5e12
x-ms-traffictypediagnostic: SJ0PR11MB4877:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QFh0Sm2bDW9xSV0q/hFDAgEut9CMpHO44vjntbtQwydvGTWAZAuovggBaO87eswSnawhzcLiNe+ScjVjAAqUVczx8v7dP1nFNn+FkqE3mT4N7ZnGutHKpimK8rQYjJ9yodj1D9uyZmWx+3DbFzn0WAkRayjGDzBTg5amY6LwQC3DRZ7TmHdqmS66iU6SlHgjKcI3owYdxmeYZ9R2WktP3ZXbU17n+IKjyAi1iSbMxdS7sH6SH9+KnOtDGnma6Yt+B54dWzUWN5ti/IixXbRB2cNLXimHdHxmse/MklqhFmUl0j0+gj1EysJxSyevN+zPDV/4dubL+0iLgSBIQio/P8QuA5nGVkjRmCAcQd56fn99drCyB/P16ganVaxJ8HHUpdlY5vQurabm4tmtTNaFaNlgOK7feJ/XMlgWMTuO5/KcjXnK5dQwsh0R3/cDgbfcDzkdDT0kiulcg1j/RUimXrFWd34mN9a0iHXFLkR182e3gnmvlQCyCTCRfh/dLenJq8AXI0Q0MOlCCZS1pi2A71g0/6Hp+7AHiZA+YItF4hN2G3cqJUhdG44NX+8OwYa1MzqmEpi0Tzt/UVyHoxCAA/PmpqRntcjGN1jDa67jEneR93/jXE30AVSNkb39JzFgZ8IbXR4DYeE1H6fA6y2lXPrZ+u04y6DPV33Ebz2uWF3dbofZC1O4y+0vMoxrTPKuXvatTAncrlA0dvLOtBCu54m4daDgh78vX+6FHSIAdNzZmxjBLAG0nst9Pd8IP8O+UKXOxlwv7IP/bObhsQDUpLuvX/NxlLkvejvhca+ITwfgF7i3SkExJcQ6oPj5h9h8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(6029001)(376002)(39860400002)(346002)(136003)(366004)(396003)(478600001)(36756003)(6512007)(5660300002)(41300700001)(6486002)(26005)(122000001)(8936002)(2906002)(38100700002)(66446008)(66556008)(66476007)(66946007)(76116006)(86362001)(64756008)(91956017)(8676002)(4326008)(53546011)(31696002)(6506007)(110136005)(38070700005)(31686004)(186003)(54906003)(71200400001)(316002)(2616005)(6636002)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eTRmeWVvd2dZUXJEZkxHR0dJc2hnOGNURExnQnVjd3c0NXp3clFCcWFLVGRT?=
 =?utf-8?B?eStKUlpzWTQ5d0ZGOTEzV3IvWU9jUDQzeXBtZFJ4UFVnNi9QMTRrYlJUbk05?=
 =?utf-8?B?alFYSTlyd3JReVFKWDkrMkcrNmdUVVpRR0pOUVk3RE5vcGRLbGg2SncwSG9k?=
 =?utf-8?B?eEhVZ2hIUkdGeDhNZ2V5Tk9uaDVsQ0d2eDRXVmlDRkF4Q3AzWi9ndE9YYk1a?=
 =?utf-8?B?bXNVSXN5L01IeTJRdnFTaGlxdVRqYXMyd0NVbGFpYW5jMzZ4THdEZ0xVTFpJ?=
 =?utf-8?B?cEI0dzkxS2NUc1B0dEVJRENwR1FLeGVCRXhGQ2w4cXRKU3hsYVIzd3VlSldV?=
 =?utf-8?B?dm5taFNaMitxd3ZDSXZRYVc4NGxmYU1ETVlzblZrZXNoVlcwV3UxL0p5eW5H?=
 =?utf-8?B?SHB4KzJ5L1ZIaGh1WmdUOGRDK3BVeFlrTTkxRnBEWFVlZnBMTWJNRStFNHdK?=
 =?utf-8?B?bmRVcTh3L3Q3aExDOHZ6dUcycHFjbzltUDd5OHVmYTFhK0FQTERHMGhOMkd2?=
 =?utf-8?B?elB1Mk5sR2FwN1V5L0J3Nllwbm93c0twYWdrTmYzM0R5NUZ2aU1QQnU1N241?=
 =?utf-8?B?QXk1SWg2Q3JndnNRNmtQbVNFaXU1ODJBVFVYdHNocXpaZUJVcVpoUHltNEpO?=
 =?utf-8?B?anhqSmRGT1R1UmpDUzEzL1QxWFd5WEJOL3NBR1BqcjhaU1pnODcyWndNWi94?=
 =?utf-8?B?enMxNXBEQ0tuNXVIRDQ1S3M0YTZnaGlUcncxMlZFU3JFb1dWM1JxUVBtUUNO?=
 =?utf-8?B?bHNGRWowYm5kemFkcEVaVFNyWU9odEI1cVlVdGpTa05vQkprTFU1cWhRUm1B?=
 =?utf-8?B?YnpHSHFKRk1LTlNYLzBUblRWYmFFT2RLU2dPT1dsa09xQWdGZW4vaUQ5NHBs?=
 =?utf-8?B?UjhnZzl0NkQ1bU5pWWtjK0FWMURoZWRIRWJUamxEQzV0b1JKUE5FSzM5WjR5?=
 =?utf-8?B?SEUxSFdNak9qZFFRbmZqZVdsVndZSThQRGRzTy9tYmgwejFnRVJZUGpDZ01C?=
 =?utf-8?B?di82bWRTejZzdE91TGNIT1pNWW9Ec0ZWeDRQRTIxeUFjN2ROQW1UMnIyOTJx?=
 =?utf-8?B?V2ZSWGJWNW5EbldNbmhHSjBKQTZDS0pYb0dYNEV2TFh6eGVNZjAwdnZVMjRE?=
 =?utf-8?B?ZXhDRFdmblpzN21acnk2S2FmYy9EaTVESEY5ZVZKQndycDJueUZKQ01TUFRW?=
 =?utf-8?B?Y01BQXdPZVQ1ZHl6RHZYejVWVGFmNHMxT0hnV3ZOT2tGaE8vcC96azg2Z0k3?=
 =?utf-8?B?dVJ6SUhESmVtTGF4SjFoL3l6bXFsLzk5clorNXA5eVVNRlQyaHY2YS9oUkxs?=
 =?utf-8?B?U3VJdERnQVNseGFJMXNsYlZldytQSS9ETmZOZFo4WlNHb1U5VXkwQmowMXo5?=
 =?utf-8?B?UVFteC94Z2Q2Y1F0Nk5PeGZrVllKcTdwMU1MQ08xWjdrZ3pKeWoxWU42YzRM?=
 =?utf-8?B?YW1MQTVLeFBUYmxVb3RNNEtDeXdnczZDdW9yZUZ1Zkxmakx6VEZjcmMxcXMz?=
 =?utf-8?B?MHd4d3gyVGxKeVI5WStnOWNlMk9na0V5bTBvQlZ6cmEwbnM1cDJoRkJJZlVz?=
 =?utf-8?B?eXpaWFJsbTR5ZGNzRlgzRXZLclhLZGFBbkRJa2pFRm1iRWM0bWxSRmRGa29v?=
 =?utf-8?B?Q1hPVmtuWVdESDdGQnp1QSsvZUtZV2pudTdVcThvSXpCMlNncno4dFJZSHNh?=
 =?utf-8?B?SnZaR1NJZkNQSjg3dGZwWHpNa0d0R2F5S054RUx1YUVrdVR2V2h6MjZpb0Y0?=
 =?utf-8?B?QUJjVjFodk5yMVdLUG5SQWJPTkFuOGhmSTBZZmtaaDNRUG1JZTFFMVdDRm43?=
 =?utf-8?B?TmYrNlNOWjA0NWZjdlhXL2l3NEF4bnR4dkxwMWswc3llYnpSNGs5c1dJcGdk?=
 =?utf-8?B?VjVnSmx3WlIzelNTVWN4WDZEdVJ4eTE5NlA3aTk2WWZhNU5QVHFJb04yR3E2?=
 =?utf-8?B?eEI5ZWRXUjlmSlRuUjFsZVY1aWRYTmlXSS8zVGFYVmpiVDg5NFpwTWdsa0Qx?=
 =?utf-8?B?TmdWWWc0MWtNazdWWktrUDhmZVY1RjZpdWtubUUxYUhMTkRNemtmUHJHR1A0?=
 =?utf-8?B?ZGMySTk0TkhndXdiWWZHQUk3S3l0UlRYMlo4aFh3RkJSbkxNVm9sU1BTOTN0?=
 =?utf-8?Q?WwLL3U1TG2RNSLd1zfI5drhuB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <147EE5DE56F3E14EB646976614A74CB7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 894b8f57-b729-4939-d26a-08da900a5e12
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2022 13:19:02.8398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /OeXz8b1q6sVqiPSjQJSIIi2FX8eARh31idW/tYFQXX75zlW6mN4HtQORSfGxz6p7XAssTR94PdVFCvCXL/K3Be/lJlW1J/rBY9xqgwK2kk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4877
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDYvMDkvMjAyMiAxNDoxMSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAwNi8wOS8yMDIyIDE0OjE1LCBD
b25vciBEb29sZXkgd3JvdGU6DQo+PiBUaGUgVHlTT00tTS1NUEZTMjUwIGlzIGEgY29tcGFjdCBT
b0MgcHJvdG90eXBpbmcgYm9hcmQgZmVhdHVyaW5nDQo+PiBhIE1pY3JvY2hpcCBQb2xhckZpcmUg
U29DIE1QRlMyNTBULUZDRzExNTIuIEZlYXR1cmVzIGluY2x1ZGU6DQo+PiAtIDE2IEdCIEZQR0Eg
RERSNA0KPj4gLSAxNiBHQiBNU1MgRERSNCB3aXRoIEVDQw0KPj4gLSBlTU1DDQo+PiAtIFNQSSBm
bGFzaCBtZW1vcnkNCj4+IC0gMnggRXRoZXJuZXQgMTAvMTAwLzEwMDANCj4+IC0gVVNCIDIuMA0K
Pj4gLSBQQ0llIHg0IEdlbjINCj4+IC0gSERNSSBPVVQNCj4+IC0gMnggRk1DIGNvbm5lY3RvciAo
SFBDIGFuZCBMUEMpDQoNCj4+ICsNCj4+ICsmc3BpMSB7DQo+PiArICAgICBzdGF0dXMgPSAib2th
eSI7DQo+PiArICAgICBmbGFzaEAwIHsNCj4+ICsgICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMg
PSA8MT47DQo+PiArICAgICAgICAgICAgICNzaXplLWNlbGxzID0gPDE+Ow0KPiANCj4gQXJlIHRo
ZXNlIG5lZWRlZD8gRG9lcyBpdCBwYXNzIGR0YnNfY2hlY2s/DQoNCkl0IGRpZCwgeWVhLiBCdXQg
eW91J3JlIHJpZ2h0IGluIHRoYXQgdGhleSdyZSBub3QgbmVlZGVkLCBJIGRlbGV0ZWQgc29tZQ0K
ZHVtbXkgZmxhc2ggcGFydGl0aW9ucyB0aGF0IHdlcmUgaW4gdGhlIGR0cyBJIHJlY2VpdmVkIGFu
ZCBJIGRpZG4ndCBzZWUNCnRoZSBjZWxscyB0b28uDQoNCkknbSBsaWtlbHkgZ29pbmcgdG8gc2l0
IG9uIHRoaXMgcGF0Y2ggZm9yIHF1aXRlIGEgd2hpbGUsIGJ1dCB0aGUgdmFyaW91cw0KdGhpbmdz
IHlvdSBwb2ludGVkIG91dCBhbGwgYXJlIHZhbGlkLCBzbyB0aGV5J2xsIGJlIHNvcnRlZCBieSB0
aGUNCmV2ZW50dWFsIHYyLi4uDQoNCkFzIGFsd2F5cywgdGhhbmtzIQ0KDQo+IA0KPj4gKyAgICAg
ICAgICAgICBjb21wYXRpYmxlID0gIm1pY3JvbixuMjVxMTI4YTExIiwgImplZGVjLHNwaS1ub3Ii
Ow0KPj4gKyAgICAgICAgICAgICBzdGF0dXMgPSAib2theSI7DQo+IA0KPiBObyBuZWVkIGZvciBz
dGF0dXMuDQoNCg0K
