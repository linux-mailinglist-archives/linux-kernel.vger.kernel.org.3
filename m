Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADB2535060
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 16:08:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347610AbiEZOIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 10:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347600AbiEZOIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 10:08:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC4F57B03;
        Thu, 26 May 2022 07:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1653574089; x=1685110089;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=D9GX7PdJ243y0Z2Z/5XMRNFbIsXDdHoAOhha3lCClwM=;
  b=okQiEcEVncClVuTZNoeqipkPhO4u4yyTN2V7nVhnrR+IsyFAogmhRnHQ
   hi5S2rFaMsgvaD41u3wUnhcfCthaF7Ap+XcY7pnef8PWBykT5q0A1kET1
   kIOf6o5l6Y6WO5iL5sowkbzXXby7K+//S3XjmiVHfG5B/AEgtDUa9sYi4
   4GHN1TyIuzhBwFMuoYsfiZQg2lZlW6ssAQS6SRbEjOkBGEqkK13Wa11Bq
   DoplJTisJWDGl78cqKaLh666rB+tAllKCL1fUgO9TaYyXFhbdOUn6zWNK
   /T1wVTvGQaS6kHIlsNhZYRHD2T8UBoVGrguTcLitgekGmWf6hvfBTRsjL
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="157708825"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 May 2022 07:08:08 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 26 May 2022 07:08:07 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 26 May 2022 07:08:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+M8BXu54d5rTbZs+eMNFu4NvvI1hRsTv+qSSd1N6bKZLwntfPf5fG25qZAtw/PTBYwBEtrkEzJy02J7XLR47p8Je7Y0V6j1QbmEOXTScYltiVwy0CxB7DOeV1AXSM9ipexwtw8+w7GGHep1JZaR99EOmrrT9b/0fNloDmrfmuWGe0wZOKBnSsMbDdOo7kOvlcp/ouwAgBnR71vXxhTLxFwBzazH8H/FqljXZ+ky/5LQ5EXL2zmLkJqKyyBPHSau8QUuFZc0B+Ow7e9fEepvuGg8uyMqAAwBBoWcySmV5MjS6CuayXqkolxKHf68NC9SE4NFfRQtO6dOzBfbfkFTjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9GX7PdJ243y0Z2Z/5XMRNFbIsXDdHoAOhha3lCClwM=;
 b=Kx5aFBP6U7xon0NF46HP9zVfjpSHzoRY8IjB+IgWx0/zDHbNQbD8ERX6isjG/mtae4pdoMt7/IJiRMTey3C8bOq91GP/4I8QAjGqIQVSpsm0L+ALP1IbynUAvdgSFF1QY9xRxuHxNHgAS+0e9dSKE7rWbgCo9RrU6CwnftfxyLrRgt15f1lJ/khC611HaH16fzjUbLXYXSvs/c1JrIrKmiAnKzDV11BWHj6GvSbIRTGXTh3xXcpezjjdaPATiEofqnbKho+hKeEnoohHBZDaU0VuUcNlBEVYClww39ija4x//BQjV/oLQ/cX3Ep67AS9sRZIhhGFbadn7QxGU+Bjhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9GX7PdJ243y0Z2Z/5XMRNFbIsXDdHoAOhha3lCClwM=;
 b=KsQzNWqdcNoInbNvdMYwprzj+NzJsfL+1zUxhkdd4rQF99UCnC3yRR1lm7rJ6YWD5aYswcX1N956S10ltQNMHLhtXj0+n5OKUe2BT+R+Be91kvyxl/XsZiXqVEdbUHKlgwALdFOfIBs9oR5oBN3Qmg+mtF0Jh0Ic8lNk3CH0B+U=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MWHPR1101MB2318.namprd11.prod.outlook.com (2603:10b6:301:4e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Thu, 26 May
 2022 14:08:06 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%6]) with mapi id 15.20.5293.013; Thu, 26 May 2022
 14:08:06 +0000
From:   <Conor.Dooley@microchip.com>
To:     <robh@kernel.org>
CC:     <broonie@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <krzysztof.kozlowski@linaro.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH] spi: dt-bindings: Fix unevaluatedProperties warnings in
 examples
Thread-Topic: [PATCH] spi: dt-bindings: Fix unevaluatedProperties warnings in
 examples
Thread-Index: AQHYcKHQtFDNalpqs0iqgomN20Lhca0wuJ6AgAB4XoCAAAFfAA==
Date:   Thu, 26 May 2022 14:08:06 +0000
Message-ID: <30c474d2-835c-0802-5af5-380b8374f38f@microchip.com>
References: <20220526014141.2872567-1-robh@kernel.org>
 <13a92f37-2491-9daa-05a7-f831d9bbb0e0@microchip.com>
 <20220526140141.GB3831942-robh@kernel.org>
In-Reply-To: <20220526140141.GB3831942-robh@kernel.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: faec917d-0973-4f3f-eb65-08da3f2127f2
x-ms-traffictypediagnostic: MWHPR1101MB2318:EE_
x-microsoft-antispam-prvs: <MWHPR1101MB2318A1C4C4ECE812EFE0B99D98D99@MWHPR1101MB2318.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uk4DH+5KQnObL/B+/DgDs/1r6Xb2uwBc3Re/yh7iJgs9y9As2l796xiGYfYcVWVRVjiAy+23ZXrx+aOqmKGFYJTlzRlKWP4zOasbsXDrrO9w0p7+FjCSbyay+6w+deHKFyWELf3Ym8/Y1expv5EEX1MkaejmMZ+fya1WrARuZHlOSz3TMzjv5XAy04mFxUTPYOabyIOj959BcARU3IZX1/ddp7elCvDVovxCvPXXqr0CrJNZln0+PYOcHi/rvehYpGYdwiAUka4oJcxqDmZhq3CNPUZK6NqN83BsRLzYguwAnif0/Fo4rOPzP2nb1OAxlft9LPsnTWae1eUkZoB5a+o0enkCyYdmuMmVxTcdK+OU4kPuL7rRaV1O8gk7/j0B/LD1h8v1hWMXuyY+GG7E+ulOSVuTwU/EnbV3BOGJEp/XVQfr3eemX3o30brRRBlC/jaUTgbSIPB/2H+sjvaptQ29/u/Dzf13n06QH4m2dWB8XfjF/0/BOuPNVb3Lp8T+1r8bRaOeyC3NmOCJivGx1NXRVWeAI4pUItpbhM0IDDmZElrBUOTXVkmY91PRVXznUFfr0iqi85ePa6XEHGLur1ZRFXSL9AeFb5ssEiHvDKGvYfFW+IREfrqRVKuyTyOiZEVIMdWpnu1VXvhYBihS8r1VP12ldaCzqiRQyI1hOF5sqDlsTA2jIM1V6TMi8NdxnLqhUTlCcWBsuJTG2hM5AsN4XSG1/8odi6Jc0gdfICECta08cvzB08wvTOKHxmauBVq4zzZNvARcMwy0FlVp6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(91956017)(31696002)(66476007)(66946007)(2906002)(76116006)(6512007)(64756008)(8676002)(4326008)(66446008)(7416002)(38070700005)(38100700002)(5660300002)(122000001)(8936002)(508600001)(186003)(83380400001)(6486002)(86362001)(2616005)(6506007)(53546011)(26005)(316002)(6916009)(54906003)(71200400001)(36756003)(31686004)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?R1FNTWplZEtMdFR0NkJTVm1tMUFMRjNZUnYvcXRlQ2NBZ21ESG8xWXQ2amRO?=
 =?utf-8?B?QzZLb2VUZTNiVDdmMXZKOHBVYW5URnF0TFppZFJHVFRWbWlQRDQyYWNZWVgz?=
 =?utf-8?B?ME56dlBJUTlEYWJlbC9Oc1pzRFBrZzRxMjY1YjhCRlpqSUdEa0xaWmhQR1NM?=
 =?utf-8?B?Z2k2ZmNiZ0VsNVpJTVN0bEczTjZjTm9DUFYzdXZDK2RDNWNaSlR4L0tnL1M4?=
 =?utf-8?B?eS8zVzFuQVg1N1piWkZoYk15VHFZUlVzcGNQemJJSU12S1pPR3pmRy8xQWlM?=
 =?utf-8?B?NDZMd0VGc3RQL29YY3FGTFJQdFBWbndUelRwTTNET1ZaVFNhY2JLazdaQWxv?=
 =?utf-8?B?WWhsMmpRVmdKQ0lhcmpzNTdlN0UraE5LZXNnRWhRM2lvRTNiMm9JZXNLQ2JH?=
 =?utf-8?B?bHRTayttc25iaDBvWnVSUTV6b3hXSlNxT01OMWllNDhDSEVUK2RadFJqaE1J?=
 =?utf-8?B?ZXczVzA0VC9QZFRmeThCOUNFYUl6R2l2U2NGLzUxb1NQeHNYczBYdjJmYnBM?=
 =?utf-8?B?Z2NCMEdvTWcxU2tTWUtjNzZxMUtWTVFPMDkrbG5BOXo1YVdHa2RGbWVwenp1?=
 =?utf-8?B?aW0xOVl3aWllSDlyc3JPc2F6Mlh5dVRjVEM0K1NjTlc3Z3VnMEF5NC90dEVo?=
 =?utf-8?B?a2d0MStpLzd3N0h4RGNEZit4V3h0SGxYV05HZDE1dnRPaVNmcWhBcnZCQWpv?=
 =?utf-8?B?U3ZNVzVhd3UwTWtYT2pKZytsR1Y5R05BQU1mZ3ZKWkJmYUtLdFhNWEI4Z3Bs?=
 =?utf-8?B?ZGF2cGZtQnJKSEdmZno2WHRtdWwrY2FuRFV4UlJZaUFjcSt4SUh6L0NJb0g5?=
 =?utf-8?B?STVmM2pEMG0vWmU1V2FsTTF4QUU0WGVzOS94aDRQY3lRTGJwOS9TRW1ZK3pE?=
 =?utf-8?B?MVFlRDZMRXB4ZE9JMitpTzZZbStvQWtRTFRUYkphT1dxQUg2TDR6QmZqRUNK?=
 =?utf-8?B?WGxpYWtCdzFad2FWRFNxVFA1WXIxTkpSbVVRNFU0YTNuVGlSVm1iQ3MrbGRM?=
 =?utf-8?B?MS9pV01qSzNkVTgwZEFqc0gxK213R3BQOVk2SCswTmwyWlg4YjFVcWZ1cEV5?=
 =?utf-8?B?ZCtFM29nNldWQVUwRXBEc2xJZVJ2QmpoUnRvcXlqYmpZOVowMDgvblJGTnZq?=
 =?utf-8?B?VldpK3htWkFQcm9mZzFYbkFPeFByRHo0VjYwSUVsS1YremY3TmZvRzFZZ0hu?=
 =?utf-8?B?ZzVaUTVIR1JiM0wvNnJDZnptRk4yd1htWWlMMHYrRlVsd0djUEdGNVhNRmJO?=
 =?utf-8?B?MTBQSVE4diswblZYWDI5eXBocUR3R0tCbTZLRFlzM3pWblpJazBKTkIvVHI5?=
 =?utf-8?B?dGhCTTRUS3hVYUJuM21ROWF1Vm9LTDByaEJlL2pkUTFWKzhaRWRKK2w3bE54?=
 =?utf-8?B?djFiZDhuekV1Wll6KzdJYTBtSENOTUNSellSYkk5YTlSdDNLK0tuSGFrZnJP?=
 =?utf-8?B?ZXNQQkNKa0xqbTR4bEhNWGJGcDhuWXViS00wZ0lYODdQZ1IvV25QRjliL0xy?=
 =?utf-8?B?TExMcTFPKysvNDNGUkRIeFVINjBnMVFQWFpqODVyMlg3SmFqTXVqNW82SVVx?=
 =?utf-8?B?YjBzV09BYzNpZDF2K3hXS2p2aVJKb2pUWjV2YVltdjFpZ054YXJGSTBLVFJG?=
 =?utf-8?B?ejVPaHFoYjdrKzlvdHFxZlgzdHZrR3dUSy91YkM5KzdsU0pCVEdNRjRtMlhI?=
 =?utf-8?B?UnlxVFkwaHQyamJSR2dNUHBnSUpCZ1duNjhzUUVUWDhlb1lVNEdsbUhIU0Fo?=
 =?utf-8?B?MFU3emNpeXorNTl6czFYQ05GWDdORjhHL3N2OU5Bb1NlbUR3MUFXWS81TEhQ?=
 =?utf-8?B?UlpxVjB2blBHNlFHVHlYVmtIcjFkQ3VHYjBLUEZYd1gxZmFqMm1MZWQ0eWtD?=
 =?utf-8?B?TDQwbkMzUFY4YkRaWnZ4VWVNaXJHc1hHN25RL2FGWVBXbldwMHpSNFN6dVVB?=
 =?utf-8?B?N1g5cDNKVDdtUTVHTG91QXhlanpXQVlwNEVtam8xUmcrbW41OHJqWDJHeXJQ?=
 =?utf-8?B?NHZWWE1HbDlHc1lhOTZDb09EM01MYTZOS1AwUnNPeGdnbmlqcVBHQk5zOTZB?=
 =?utf-8?B?OXUyWGRVbjlYUkVqckUzeUFXTFltSW5vVGJST2svMG96M0RlbWhSMlNQUEtD?=
 =?utf-8?B?dWRnWjFaMm03bTA1WkVnRXY1MDhHYUcvUEExNUhVWDZQYktqZkdkeVgzRzVU?=
 =?utf-8?B?Wk4ya0QrNHdoWUxGdU55VllaZUJXVXViYjlITzdIZ1paUHNGNXk4TmdVdXI3?=
 =?utf-8?B?aGp0Zm9vUDBOQ09Xd05SaUd2THczbWcxWFljY0hUcUt3NGVCalJ0MDRKR0d1?=
 =?utf-8?B?ZnFXUWRsTzlUdXhpMFI4ZW1FRE5lZHVZZzU3QmJQeUpNaXhyVzd3Zz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <07618F3D2B31584AB240E4D8D179DF80@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faec917d-0973-4f3f-eb65-08da3f2127f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2022 14:08:06.2579
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: grbCxJdF9Uw/bFCiPhWH0RNFV0YZ/Rjae30NMaLMRphlDcvsg4TNqaSq4aGtCN0jirbC+Rq/Z7lmbfJZGR3U/xYZtO+uqamNs1iy10RxEYE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2318
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjYvMDUvMjAyMiAxNTowMSwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gVGh1LCBNYXkgMjYsIDIwMjIgYXQgMDY6NTI6
MjNBTSArMDAwMCwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBPbiAyNi8w
NS8yMDIyIDAyOjQxLCBSb2IgSGVycmluZyB3cm90ZToNCj4+PiBFWFRFUk5BTCBFTUFJTDogRG8g
bm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRoZSBj
b250ZW50IGlzIHNhZmUNCj4+Pg0KPj4+IFRoZSAndW5ldmFsdWF0ZWRQcm9wZXJ0aWVzJyBzY2hl
bWEgY2hlY2tzIGlzIG5vdCBmdWxseSB3b3JraW5nIGFuZCBkb2Vzbid0DQo+Pj4gY2F0Y2ggc29t
ZSBjYXNlcyB3aGVyZSB0aGVyZSdzIGEgJHJlZiB0byBhbm90aGVyIHNjaGVtYS4gQSBmaXggaXMg
cGVuZGluZywNCj4+PiBidXQgcmVzdWx0cyBpbiBuZXcgd2FybmluZ3MgaW4gZXhhbXBsZXMuDQo+
Pj4NCj4+PiAnc3BpLW1heC1mcmVxdWVuY3knIGlzIHN1cHBvc2VkIHRvIGJlIGEgcGVyIFNQSSBw
ZXJpcGhlcmFsIGRldmljZSBwcm9wZXJ0eSwNCj4+PiBub3QgYSBTUEkgY29udHJvbGxlciBwcm9w
ZXJ0eSwgc28gZHJvcCBpdC4NCj4+DQo+PiBSZXZpZXdlZC1ieTogQ29ub3IgRG9vbGV5IDxjb25v
ci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4+DQo+PiBBcyB0aGlzIHByb3BlcnR5IGlzIGluIHRo
ZSBtcGZzIGRldmljZXRyZWUgJiBJJ2xsIG5lZWQgdG8gZml4IGl0LCBpcyB0aGlzDQo+PiBwYXRj
aCB0YXJnZXRlZCBhdCA1LjE5PyAoSSBhc3N1bWUgZ2l2ZW4gdGhlIHdpbmRvdyBpcyBvcGVuIGFu
ZCB0aGVyZSdzIG5vDQo+PiBmaXhlcyB0YWcgdGhhdCBpdCBpc24ndCkuDQo+IA0KPiA1LjE4IGlk
ZWFsbHkgYmVjYXVzZSB3YXJuaW5ncyBhcmUgZ29pbmcgdG8gYXBwZWFyIHdoZW4gSSBwdXNoIHRo
ZQ0KDQoxOD8gVGhhdCBhIHR5cG8gb3IgYW0gSSBtaXNzaW5nIHNvbWV0aGluZz8gRWl0aGVyIHdh
eSwgd2lsbCBzZW5kIHRoZSBkdA0KZml4IHNob3J0bHkuDQpUaGFua3MsDQpDb25vci4NCg0KPiBk
dHNjaGVtYSBmaXggZm9yICd1bmV2YWx1YXRlZFByb3BlcnRpZXMnLg0KPiANCj4gUm9iDQoNCg==
