Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2C5159FFCB
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239591AbiHXQt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239430AbiHXQtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:49:21 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 757B44E635
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 09:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661359758; x=1692895758;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PPzF8q0qID37hix0TUrX4ZmDO6yQuTNHlydOx/Z8ycg=;
  b=EN2GrCpR6kE5fNxofOY5vkFXQocl+f2EyxnZd9NKTFWa9gKC1j0U49vo
   uW7rteHgSYqDBkBLkCwvCJ13l6Q7A3FgevQlmj4Ztzq5sl18mLippds3A
   MtD3UE1NqPL6n9xinDjUJZ3OrFCMqpWwNjVB1SQOUq5KdtzLfBgVrknxm
   FNQVCxwFRErl6IR6MsxCT4bICTxxiofhVeGCizcgfKElc+V1kKHeCKHeN
   HpsJ5UKC0xVV/UwuCPLzhDS8NHkoP/wGrieKL2BAXTo229UTGJRaBoPej
   Kk039twApj1EP13Eg3fm6NwUpSlkzdoT/WyvGAHpiYiHK5dEtIPDsdVAw
   A==;
X-IronPort-AV: E=Sophos;i="5.93,260,1654585200"; 
   d="scan'208";a="187891749"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Aug 2022 09:49:17 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Wed, 24 Aug 2022 09:49:17 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Wed, 24 Aug 2022 09:49:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejpb4kQQuEAjq7hM0gHM6gHEahPAIqHLkXyHfpV8u0YR/ELGRmcO2Ngi6RzhPDqC7o7L/62uEoEpR+swUOi8gZk2HbES921aA+rq6e+Of4hvXtkvcpONycolK4ftxJfMjMuRmsNgAj9D2USjZtov1yTe4ixyuYfyD7cx1mv+VwikhWRhd0Phka8GTGgVXNQ/8Pk6EyrJSWPOmDmNtL5rEdkxq0YZtOFPoFIpPG/ngj40cIMuMzTGTSyV2laE0Sgd7K4T/1vU8gBs2qJdOX8wDifOXjYKuMTOeOqiYThUL78i/lG79yVgPBN3sRXFhKcTReVdGZnuXmKsAgL5YUFSvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PPzF8q0qID37hix0TUrX4ZmDO6yQuTNHlydOx/Z8ycg=;
 b=mUc7prtw72FkLR0epnSjia+PcVb9TsxXW4z51rnqNi0tYeXpt1UZuqDjUVdsUXl/wBSfUMEChDYbBs2ixaKhDdKrlqEdFMxNLSyZe2Ps0cIfJnMnyY2yYnBDoFIPVL3U9abS264ku5WP6co4pJ3svqUB5nptZowF0Iqk5rN2+Nj7vb/fgA4dA9A7j763ZtcvNYL3GjM9WIjM4lVpk24tRjWr5la4fMs1n8mGKS5QRd/jqSL+tcfma2ceJscPDcrdjeKCvkFANx1riqOnRxYAXy6E+lMYnrCpCJynsNZm7/h9Fngqs/R8LXDekPhUvwGOPwf+GGS300NbgRuU3C0LkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PPzF8q0qID37hix0TUrX4ZmDO6yQuTNHlydOx/Z8ycg=;
 b=JLIGnylYGlP+nptARjGPVG42Pqg9ay3fvyqrX5FVkBn4zDm34MgFNn7vXVtIVkNWFvKOtR6dsyBIEBwKbHrfp8Tjvhap637srl4UvWdDA/wD+hD25jwthlQwAAJZF7j50allro/ugrllPskghNmPHrrPjP9BhXiyk9vn1Ku3JJU=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BL1PR11MB5413.namprd11.prod.outlook.com (2603:10b6:208:30b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Wed, 24 Aug
 2022 16:49:12 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5566.015; Wed, 24 Aug 2022
 16:49:12 +0000
From:   <Conor.Dooley@microchip.com>
To:     <tongtiangen@huawei.com>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <palmer@rivosinc.com>,
        <aou@eecs.berkeley.edu>, <Conor.Dooley@microchip.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <wangkefeng.wang@huawei.com>, <guohanjun@huawei.com>
Subject: Re: [PATCH -next v2 0/2]riscv: some refactorings realted to uaccess
 and extable
Thread-Topic: [PATCH -next v2 0/2]riscv: some refactorings realted to uaccess
 and extable
Thread-Index: AQHYsFYTspnxDjytBU+7Hhl7RUmBma29pbMAgACsf4A=
Date:   Wed, 24 Aug 2022 16:49:12 +0000
Message-ID: <207ef9da-34d3-b059-9bfd-871a0c6ddab2@microchip.com>
References: <20220815032025.2685516-1-tongtiangen@huawei.com>
 <4063da85-b110-4afd-2023-59d4da41c27f@huawei.com>
In-Reply-To: <4063da85-b110-4afd-2023-59d4da41c27f@huawei.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6d7b37b6-122f-4d52-f2f3-08da85f09271
x-ms-traffictypediagnostic: BL1PR11MB5413:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hIzbjGhEVvD3l1cNryAep/r6toBFJNFwIHRQKLl89faoDCMwOXlM6Tgx+HDSskEOBwczYV3AT+wdwmb749ibl3n6hzwfnn+KzDsO7tdB1DBr7QPzrdCMz4vFtA/VouUoELUg92/oXKtxxicy0LMsAG/kOYcnv9s4S7eDgY+xakjqZPT4UlBTZW6ahoVoiitdrffoS1n8RH7okiVRJD3jLQazZm/wB/zc2j6mzE8K9/BCj3VShqi1q0xg5hUMCVSMD4ftjL3LwD3B1F5xN/jFqHvYZiZS8XBlcEmUSuiG0KNiiorkDKInEjVk3J2fUMna7zPAvh/Bn+129B/3Mp/E+G5Wr6hBP7BdpKeEBvDfgXAv2TViwsWlX61X31aVAWCoUoFMkgDFSQ2XfKhvC0f/VC/E7ggo203va7gHmD1xZKUSeSDOwz02StwXRI33WskrhDxEPXoOEuPObMYn5EIRyS7CspHzarqQGhbAc7In1LO6Zosgj6UqNH2zykFAKXkxkrYaOJJ3Vju+xWoeMLKnLaGeV5MBTzSsZx3Kvd2sTCVxKbcieyIurEQxiYO+o0VFb3t+ESPcdJskvHLyp7fGz448/St77NohK5k7eqbinprSX6neGthSpiVfrPTa2WRYOCunXph9ZkOXPUJ/LLwdT3S8jO1TQe5EKWAAmkxsHkFTqrM90EDYOTe7odBVVitD+nl18bLBr4CCjmGySpEAp0cCXvlJe6AwIgTuCTnWfqq1thbzex4sIsU1CIgtg5+g1MMbl9XR+euuMdm5dpX4090lTb2SG4V+/wFeianAqtxuvGpbuBu8agMTdXPKgzCyIpqIAF5HGU6z59IZk19few==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(376002)(39860400002)(346002)(136003)(396003)(122000001)(86362001)(2906002)(38100700002)(6486002)(41300700001)(38070700005)(478600001)(186003)(2616005)(53546011)(6506007)(26005)(6512007)(83380400001)(5660300002)(71200400001)(31696002)(8936002)(316002)(36756003)(31686004)(54906003)(110136005)(66476007)(91956017)(4326008)(76116006)(66446008)(64756008)(66556008)(8676002)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T0VEQ1VpWVp4ZlNXTEFTTy9FOTlhOUpXS05hMmRvWnh1a0dFdlIrcWZseFlw?=
 =?utf-8?B?UlhpeEZMMWVJb1VuVmhuUmIyamZNdmZjclg2OTFrdmlTdUltSEVGOWtCT1Vv?=
 =?utf-8?B?VDRNYnFJK3ZyUXA0SDlCYlVTSGw0ek12ZTM4OCt6SzRrUVozNTZYMDN4amtW?=
 =?utf-8?B?Y0Fnb0VPOU9ka3MwZEZvTFliSjl5RnRIekZSN3RveGZpMUFpTk1vdHlnNVhK?=
 =?utf-8?B?Q2NybzBTY2NiQ2xUc0p5eHk4TjAzanVPWStRYWZmaU45YjlQaVYvM216TW9F?=
 =?utf-8?B?KzFJU2RVNGRuSkpHV011WHRqOTFjZ2Njd09oY1BsNUx6cWVlUXUvRUhLV1c0?=
 =?utf-8?B?R1FKbHltTVU0aUpsaEVwQVhHUGRaMnNCNk1ZZUpIM2xSWTdmbkhBMDdHWVJV?=
 =?utf-8?B?ZWZJN2NTK2UwTGFiWmFsRWtwOThUMWZuMjJkT1NVTjRscEQyK0V4VTYyZE1s?=
 =?utf-8?B?NFFnMGRPaGNzWEZUOGJxY0hnQS9aa2hwa2Y3bWxpc2VhR3BjVStFTjdxaXFI?=
 =?utf-8?B?elpKbisxdzNSR242VDdGYldMSUxwU0lublBBY0RhWjk0YUc3QkRaUmxKK1Zw?=
 =?utf-8?B?OHVtUTJBdkJlRDAwS2xFdG9iM2RteXU2VlB2SGQ1TFBaeXpIaFhSbFVKNGx1?=
 =?utf-8?B?enluZVB4QVBaakR6L1hWK0MyRUN3OFRwWlQ3T0M3a2dMME4xYWEwZE40UlhZ?=
 =?utf-8?B?UDJDOGpmOHY3eEsyZHErVmhJVGhSWTdjQ0FLbWh1SHdxMGpmRGdKT05vM2Qr?=
 =?utf-8?B?ZHdkME1PYzJlU21DQW1lU1hpdTN0eFlwbjgzK0xCWExjQnlMMGlPUC9lc2dm?=
 =?utf-8?B?TFUxY2hNMHBScStmR3dPc3lrOFBJMThWcUk4UVlKRVo2ZHJCUDJ1WnVsN242?=
 =?utf-8?B?MTNWWTg2aXZjMkQvU0pxeUV1OWhRYkkrd2E2bHo5OEtpbmp6dUpzdnFoYWEr?=
 =?utf-8?B?aDNqeGp4dU45cWt3Z2M1aUVScm0wMnJLVTRDNUtVdHRkbzc3RFBSMGZlTHRW?=
 =?utf-8?B?ZHdGTmtJU1B1WnJ2YUNXS0RPRnAxT2VDdTVDd0xGRktsZmJuRmFyZU96bUdx?=
 =?utf-8?B?TkNSWnlrb3IwZTVWbFpjb1hBeHAvL011UkVBdDJuS1BhamhEODh2eWsxZHZl?=
 =?utf-8?B?NjNQT3AzZk84Y1I2U2lwT01rN2FiY2Q0NEd4ZEtYbWtzL0JWWmUxVENaYzF4?=
 =?utf-8?B?OEV1cWs0VnFjRjNDZDdFM2xpOFNTbDRaTEFzWHY4WjNlZDlNVGM0bXdKS0Zt?=
 =?utf-8?B?TWs5OWczbDRtQVNTbmJVVTNicUZPVFJCcjUzMFVMQkpISnYvUFh5RW1BODQv?=
 =?utf-8?B?T1R0V0ZMRVg4Z0gzb1dNVGVpa21YcDh5bWRtSU43UlYwMGVHb28yQ01tdGs0?=
 =?utf-8?B?djVMSHg1VWt2WUhoTVI0MkJHWjFLNW8rSGd5bXlWRllLNEFmbW9PTGdKU0dz?=
 =?utf-8?B?OU01VUVJZ3pIUFZMUFZQZXJuelYxQitYejRlYzZodWZpTTR0eWU0K1d0Vnhq?=
 =?utf-8?B?QVBOa0VkeldCcDlzRlVHU1IvaEhVVEFSNHVISkwzb1FUeFgrN3NENThydjM5?=
 =?utf-8?B?a2xzSEJWT2VFdWEyczdBV1JOYVRZcGlSUWd2NXlrOEtZSkV3QlFjdjhVLzdt?=
 =?utf-8?B?ZytySDk4UkkzL1NJdUk1bVRHc0c0eGpCMkdwZTV0dUtoaFNnOFlqNnFjU2tI?=
 =?utf-8?B?US9GdUtsc2pnSCtQVGUzRHZ3SUJLUHJudjN2VUIxK1d6cTI3WXR3S2txTGlL?=
 =?utf-8?B?Z0FmTkN0YUZlN2JIOG5saHFKTHJxcitjK2ZyT1hSaGplcUYrM0RDY3Q0UWJ3?=
 =?utf-8?B?K3JVTE1CK3ZzeHUzWkI4a1pPMEo4WG9FeHpacFg3bGF6cHNaUkFGM01uOVhi?=
 =?utf-8?B?Y2ZUSCtpNWl4b0dtemQ5ZGl3VHRoWHg0WU1UTFYwSi82UG41U3k4R1k4djNR?=
 =?utf-8?B?NU9LQVU2b25xbC9URmdaeEtlN20xaXhMMFZhYlM2ak5jMzVvOGpzajBxT3BV?=
 =?utf-8?B?bk9iTkVRbzl6cFRZazJtclBvOWUrTzAwYzF1T29LblVESnJUMzZ6cVlCenh5?=
 =?utf-8?B?aVorN0tiMC9wRVFaLzZuRk9oUzlhNTZZSnBzdm9xRGtaMk5KdHFuQlgwRWk1?=
 =?utf-8?B?QXprK25nQ25mbmVlaU9pVlRaRURTaENCbkJ1QzlOdkVoSVBaR0dEY1RzMFJQ?=
 =?utf-8?B?dEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6DFBE383D1D98743B2792C41DE4457A1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d7b37b6-122f-4d52-f2f3-08da85f09271
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2022 16:49:12.1308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7hDItU9F0S3dcIlbJf517WfK29Wt5SoTknCp5FrQFJ0dB8AF2TdijWCERMyRh2ITriQWsqYlfjJLRHG+Cf0+R4FLirhXkBy19Cei0ujij8Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5413
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjQvMDgvMjAyMiAwNzozMSwgVG9uZyBUaWFuZ2VuIHdyb3RlOg0KPiBIaSByaXNjdiBtYWlu
dGFpbmVycywga2luZGx5IHBpbmcuLi4NCj4gDQo+IFRoYW5rcywNCj4gVG9uZy4NCj4gDQo+IOWc
qCAyMDIyLzgvMTUgMTE6MjAsIFRvbmcgVGlhbmdlbiDlhpnpgZM6DQoNCkl0J3MgYmFyZWx5IGJl
ZW4gbW9yZSB0aGFuIGEgd2VlaywgcmVsYXggOikNCg0KY2hlY2twYXRjaCByZWFsbHkgZG9lcyBu
b3QgbGlrZSBvbmUgb2YgdGhlIG1hY3JvcyB5b3UgYWRkZWQuIFBsZWFzZQ0KY29uc2lkZXIgd2hl
dGhlciB0aGlzIGlzIHZhbGlkOg0KDQpFUlJPUjogTWFjcm9zIHdpdGggY29tcGxleCB2YWx1ZXMg
c2hvdWxkIGJlIGVuY2xvc2VkIGluIHBhcmVudGhlc2VzDQojMzg6IEZJTEU6IGFyY2gvcmlzY3Yv
aW5jbHVkZS9hc20vYXNtLWV4dGFibGUuaDo2MToNCisjZGVmaW5lIF9BU01fRVhUQUJMRV9LQUND
RVNTX0VSUl9aRVJPKGluc24sIGZpeHVwLCBlcnIsIHplcm8pICAgICAgICAgIFwNCisgICAgICAg
X19ERUZJTkVfQVNNX0dQUl9OVU1TICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIFwNCisgICAgICAgX19BU01fRVhUQUJMRV9SQVcoI2luc24sICNmaXh1cCwgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIFwNCisgICAgICAgICAgICAgICAgICAgICAgICAgX19z
dHJpbmdpZnkoRVhfVFlQRV9LQUNDRVNTX0VSUl9aRVJPKSwgICAgICAgIFwNCisgICAgICAgICAg
ICAgICAgICAgICAgICAgIigiICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICBFWF9EQVRBX1JFRyhFUlIsIGVycikg
IiB8ICIgICAgICAgICAgICAgICAgIFwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICBFWF9E
QVRBX1JFRyhaRVJPLCB6ZXJvKSAgICAgICAgICAgICAgICAgICAgIFwNCisgICAgICAgICAgICAg
ICAgICAgICAgICAgIikiKQ0KDQpUaGFua3MsDQpDb25vci4NCg0KPj4gVGhpcyBwYXRjaHNldCBk
byBzb21lIHJlZmFjdG9yaW5ncyByZWxhdGVkIHRvIHJpc2N2J3MgdWFjY2VzcyBhbmQgZXh0YWJs
ZSwNCj4+IG1haW5seSBmb3IgdGhlIHVzYWdlIG9mIF9fZ2V0L3B1dF91c2VyX25vY2hlY2soKSB3
aGljaCBub3QgZGlzdGluZ3Vpc2ggdXNlcg0KPj4gYWNjZXNzIGFuZCBrZXJuZWwgYWNjZXNzLg0K
Pj4NCj4+IHYxIC0+IHYyOg0KPj4gwqDCoCBBY2NvcmRpbmcgdG8gQ29ub3IncyBzdWdnZXN0aW9u
LCBzcGxpdCBpbnRvIHR3byBsb2dpY2FsbHkgaW5kZXBlbmRlbnQNCj4+IMKgwqAgcGF0Y2hlcy4N
Cj4+DQo+PiBUb25nIFRpYW5nZW4gKDIpOg0KPj4gwqDCoCByaXNjdjogdWFjY2VzczogcmVuYW1l
IF9fZ2V0L3B1dF91c2VyX25vY2hlY2sgdG8gX19nZXQvcHV0X21lbV9ub2NoZWNrDQo+PiDCoMKg
IHJpc2N2OiBleHRhYmxlOiBhZGQgbmV3IGV4dGFibGUgdHlwZSBFWF9UWVBFX0tBQ0NFU1NfRVJS
X1pFUk8gc3VwcG9ydA0KPj4NCj4+IMKgIGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vYXNtLWV4dGFi
bGUuaCB8wqAgMTIgKysNCj4+IMKgIGFyY2gvcmlzY3YvaW5jbHVkZS9hc20vdWFjY2Vzcy5owqDC
oMKgwqAgfCAxNjIgKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tDQo+PiDCoCBhcmNoL3Jpc2N2
L21tL2V4dGFibGUuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoMKgIDEgKw0KPj4gwqAg
MyBmaWxlcyBjaGFuZ2VkLCA5NCBpbnNlcnRpb25zKCspLCA4MSBkZWxldGlvbnMoLSkNCj4+DQo=
