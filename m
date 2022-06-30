Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B530561241
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 08:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231500AbiF3GIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 02:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiF3GIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 02:08:00 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8317E9C;
        Wed, 29 Jun 2022 23:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656569280; x=1688105280;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0vD4dyY0Y9JyjTo7KN/i7kVdjqjLYDDvulW3f8urwus=;
  b=WwcKB3UU0vtL5dI462P9su11VNbU5Y815jPB0QUQIX1e2H1pWeJ15WXE
   mBmkQP43C7Yt9HvsR5JJpJGSneSp5uOzXO89AeXF/PrzUFbW6DiA/unfk
   WgxfZ4R6eaaxR50L3kyA/dhGwpdW8B+SRe7U3+RN83ElkozI0nJw0VCcS
   MvpLO1YfWwtmeedcCUthO7toXJcIXcoXBAeUdGByuL93rfpjRE968c8k3
   +bloZAObE5pnZeO/OmADfxqET/2s5OfD4W829it5OvnCuhgStbUoNBl8L
   BEVa4rxDDtppFWoD5SnM7juyBj8R6bysAC2W3v++TvWM+U0DjopnVhs/4
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="165764712"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jun 2022 23:07:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 29 Jun 2022 23:07:59 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 29 Jun 2022 23:07:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RbGhz777EL2N5aDlN78wUoyvNpYJoK28gaiPyfZl+Adfm2byf6UZsv55/ug598aqIzPI9B/5j0JSIRa1DD9DguPqZVI0o9GfhUhfju1TBRXmuGF7WNUA+UfzYKDXlpd0Bf0tBWhR9+f+7uF65RxeSL4NfVdZvdSo6clULXkhftKnllRdcjJLExg/3ha9ihxGBJj2sV0XHMb+gYKdZfZbJSO4kYzkS8NYoW+tTPhNCeZur08GWPUct0N9peTlJs1N4rWqhqhpqz9fncCbmRVWTNV5w/tjwFczazC6vdOe0OAoJmvyZRVlv3tmUOM4h7YRuGZ/YSiZiBLnbjq9oHy/eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vD4dyY0Y9JyjTo7KN/i7kVdjqjLYDDvulW3f8urwus=;
 b=asYOAT/EphYlvm8oJ+SsfV1atC2okyYvxXcHYRJWtjrQeEAuroubkliXggAgsNIA3RKXH3uqh8fhUqu6OMA6wzfpwhUeyTOKmdFOfk/eVmp/uHf3xv392GnOK2ZhhSGhj4FAEFNRMa4KRGAPimWoZ1ijLtbR15ejrh5fCF/YPhcVw4BWa55igaXWrb1fWrthSgvGs9lCeIwCl5R9697OpJK14O/JRIRv40dnl7+IKAL3T/rEcXFD6V6+yJcFzNnepxZ0U8Bz19fnUD1X4U+Di9JSNF86UY+4atKWCBtV+bAx3tJ/+QeYKS4lw/2Em8gKiJ4DIMwdLSpJR93PFwvfTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vD4dyY0Y9JyjTo7KN/i7kVdjqjLYDDvulW3f8urwus=;
 b=Fv3dfNIeDPxutpbt3HLNyebSOST7O1I+E0imXMM74Iu+j+af2EkfWFV1y7xW5rUTn9/ZOhSLhxcMjWw5qhxyVtyq+KpL/9GndP3KGyQho0raZV7rN5Df6vWhZTvMH91z96IoecTb9DEqVX1VD+PbSP/03bdHnFSuGZvd2SzBqSo=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by SA0PR11MB4527.namprd11.prod.outlook.com (2603:10b6:806:72::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Thu, 30 Jun
 2022 06:07:54 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::c1d:1b72:2d90:d496]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::c1d:1b72:2d90:d496%4]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 06:07:54 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <krzysztof.kozlowski@linaro.org>,
        <broonie@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Tudor.Ambarus@microchip.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Claudiu.Beznea@microchip.com>,
        <alexandre.belloni@bootlin.com>,
        <Kavyasree.Kotagiri@microchip.com>, <UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH] dt-bindings: spi: convert spi_atmel to json-schema
Thread-Topic: [PATCH] dt-bindings: spi: convert spi_atmel to json-schema
Thread-Index: AQHYi7hgu9BbfCeInkGneSj5bi0Tm61mX4IAgAAbUoCAAP00AA==
Date:   Thu, 30 Jun 2022 06:07:54 +0000
Message-ID: <2bbea8cc-6f17-6236-6f4b-352a274784de@microchip.com>
References: <20220629125804.137099-1-sergiu.moga@microchip.com>
 <a2422718-2ec4-dbad-0245-1d78dbb39f25@linaro.org>
 <f641fd0e-2da2-112e-f2fb-f5d89af00587@microchip.com>
In-Reply-To: <f641fd0e-2da2-112e-f2fb-f5d89af00587@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9070c613-f168-4224-444f-08da5a5edf53
x-ms-traffictypediagnostic: SA0PR11MB4527:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Eivn/LH9Lb0BZDGo5t0E2oYKxZNiG5ZLFZQCDWKUpgKREO1sQu91HXqmnZxU+esUTrGQ4M4D83TmCqOm1UQwsS9m3iANvFoalltJ0RYbAXk85eINkjll9KSjvzDViHhuH+XlMiWK4gm64FR/0PVHL+64W8nlDMZXJL1kHsxglwf391VtiQhLLgPIwqyVbzO47QirLjj6QTc/KjU5jxz8V3xOVa+RzpSZdmTC/uJVYshuRmoHdo8X+oXObDvkPVw5CiaE0oRVwtDjJ1tCrzQPmzhcRYAYxwyIM9zZGQro1WD6fPPYrA4XZkdJs4yUE+D9mP6q5HB1nYclCpluxd+NuZKXtq7smDaudSvlAvsYJdXJ9t7yae8oE8px+nMPI1uyFJLE7DNr2AIH9RGTbNhf/vu32q5xYlRz/J2i+7Uv+EAzHWYbv74VyyEZJjAPp+IRUPuc9VIr0LMEgVX+rrIoTAiDd95DQWYUnohKvmQYc3vFBBRLaEXNz1aT1YK+K2sizv+Y/qpHElCODxZAnMNSiqL7Qnwsz6Nie+XfYTNdaedQtOvN0skFyV/udT7OLnk5yBN0th90RMVUq894s6gPO8MD80Yf3uKAQ6BCkvfebKU1htMyBTm4+yMIQozwswlvcRgt7fr3+fiM2LCxBoyqQD9dBOBmpGHEFuadTlBEsMZar0lzQUGEIVIp+ni6MoWDq9qkoBLeB+h5dN1c/qa/wTc+7M3tE+vyUG1ot4Q6LCS3cAoKyetGjakZcjYxLo3pXE8fVx1tDk1SUnLTDDsJAD2LLJyA4OQFMsBeDFf8byi9h0a23iiKswApP9vWjfBBlUZUmxSAc8+wW41cexRSfQIyFF1Msmv4bnNdDXI8LWQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(346002)(376002)(366004)(39860400002)(86362001)(122000001)(36756003)(6486002)(6636002)(2616005)(53546011)(31686004)(186003)(4744005)(71200400001)(2906002)(4326008)(66476007)(66446008)(107886003)(66556008)(31696002)(66946007)(8676002)(478600001)(110136005)(8936002)(91956017)(26005)(38070700005)(41300700001)(316002)(54906003)(76116006)(38100700002)(6512007)(5660300002)(64756008)(6506007)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmZmVVM2ZDBXQnpkdVJWMkxEOWp4L3VYYzRDQTdmaDRMYlZWZGRwZWkrbHN1?=
 =?utf-8?B?THVUWHBwN0hMeDJ5TThxQlphSlorOHB3Z1hhSllXY1RJcXAxV3dxeVpMQy9F?=
 =?utf-8?B?aHlwWnBTelJYSkhrbWdrTE9PbVpmUTVrZk1raDV6dGhLWm9YdmxxYUhnSWZE?=
 =?utf-8?B?Z1ZadEtQZEtZZkV5aVpjZjRseHo1UUE1L0FyZUliQ0hEWUVJOXEyRTMvL1Bp?=
 =?utf-8?B?THJ1SGNva0R4cyt2OWpLdDBmN0szYmlBNEN2VTVMcW5aVDN4K0tyVmlxakZm?=
 =?utf-8?B?cjhuNlIvK1pkeS9McER0eTBLWkdsR1dQVFRuYmxxUU5CT2lGdFQ0YkxyRFZI?=
 =?utf-8?B?eTlaOFFIdDBBTHBJSEd5TVYyVG5YQ09ybmQyaXQ3SXM5UVQ2dC9EOXNDYUVF?=
 =?utf-8?B?bWtmaUxPMmpPc1pWcHFNcWJicTE4ZzFBSU1uQ0pEaUdVaXRDN1dFUzd0cUl6?=
 =?utf-8?B?dEJ6c1dwZHRPK3JSUzF5LzB5N1FLSmRjbWNFOU1Xc0RNZkVQb3oyOERGbHpz?=
 =?utf-8?B?eGVHK0ZhQzlXWEcwSzlqV2V2Y2MvalNtUkp0aTcvRUU5NVM1T3VDM2JWb3pH?=
 =?utf-8?B?eGd5L1VrdUpFSjZUK1hNb2sva0xGV1NpZkRKVzNzWlhMZ1ZXc09YbHRtZzNL?=
 =?utf-8?B?VndTaFhZdVJLcThYNGZ6b3VlZUhVSzhSdjRKTXpJVjlMckRrOEV3UlpaZ0I5?=
 =?utf-8?B?Z3gwSmhvazB5STI3dFBSeGRmamtlaUZubUd6QzB4bEN0Si8ycC8yRVA1MTBh?=
 =?utf-8?B?UUs1elBuUStXeUtRaTBVaGNZRWZPWU52Zjg3QU9TS051eGt6bW1BdXBDZGZ4?=
 =?utf-8?B?SDBKNGo4QTZaeHV0Mkt6aDVJdjFBRHErRk5XQWZwVEE1ZVp5cjh4QW9zcmI4?=
 =?utf-8?B?Z0FYV0xCRURDYUxsek1NNDQ0RXpRQm9WdzR2d0NmSEhUcFB4VWNYU0VKWTV2?=
 =?utf-8?B?RE9SZlJqaTQ4SnBCcHBHeGxndGhrQysrRlllZ013dTdpbGVSeFliY2ZETHc0?=
 =?utf-8?B?am9JcXlEa1IwbGt5Y2xhM294a1RrTU12TzErU1F1RnJmdnVDM0s5U0daMWRH?=
 =?utf-8?B?VHU2blQ3bWs4aEt0VW9YY0NMbTc5cDhQVytHVVN2L0dvMjYvQTcweWhZMW9V?=
 =?utf-8?B?S0xCWHh2MC9xZjZPNHhwT1dlK0s1N0ZBMWNVVkxoM2FncDRoSUd0UDFYWTg2?=
 =?utf-8?B?dFA1Wk5zNWEvVWt2Mnp3UzhhVVdTS0RtblFVNXUwbmVTUnFxOHY1OFc4NXB4?=
 =?utf-8?B?YjA2WE5qNllrK0ljMCtjMWY5V1dyb1FVVmFadHZvY1pEbW54bEdEdUQzelZK?=
 =?utf-8?B?WXBESzZybkFkUDVmRkdRcSt1eVBWWTB4ZUJaNHNpTnlrYzZhSWl2aXEwNk9Y?=
 =?utf-8?B?N0xSNFRxVDBFOE9QR3N6b0hHcmhWQ1dTZ1VyRHhYdG8ycTlUZ0N6dm1NQ0R6?=
 =?utf-8?B?dTZjQW1pRjdQZGhtek16U0JtZ2JEcGxGbXNyQ0pJVGt1RExGUmFvMWc2NDU3?=
 =?utf-8?B?eVlmemZtSTJMbFdQamIvZkVwSzNiZGpZazhMbnJ4VWxJZWhXZ1ZKUXhJYWVx?=
 =?utf-8?B?OURyOG5QV1NCMXVpZG91bSs5SWxzenppWnZnZ3hwTVpxdTk3UjVRWXhmeXRV?=
 =?utf-8?B?K09SQ3dQL0ZhMG9SMVNLU2dKTExmaWh3bGttbXlLUlJiLzR1aXpPUVJPVmpa?=
 =?utf-8?B?dWxocTU1UjdjbEZOZU1Jb2ZEUXVHenNpSFNkbHFyaWZYaXB0TjkzaUFpb1R6?=
 =?utf-8?B?b041bk9YcWRhMEdzR3hmWlR1L0tKSG5pRFpJbCtDTnRpQmE4Q2poUkx0OVk0?=
 =?utf-8?B?UFhMK0Q0UzExZnFJKzNBVDZDeDR4L1AvL01nOGRuVlpCVjliVzJLL3p1UDdV?=
 =?utf-8?B?RUptVjRZTFYvK1kwL0Y1dUFsVStneGtHeW9SSFd0Wll0SEE1aVFOL1ZpaUVp?=
 =?utf-8?B?Mm9sS2FLMHk3bTIwYll2MHh3OG10VlVZdGt2NS94dStHdU83VWhUTGFVMEdS?=
 =?utf-8?B?REdjZk83cTE0eWJJZjlSOEhDbysxZUluZUtmZ3E2aVpMb2RiYjZQVW96S2Uy?=
 =?utf-8?B?aUswRFgvdW5qMzdmbnIxTHhVeTAzSWwrQVlkVHVHazFwWHJ4MVhaMkxtUUsv?=
 =?utf-8?Q?38k0U9m9kHOyd+p1CGtyoto0P?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7AD271026C659F4BB63960477367E1CB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9070c613-f168-4224-444f-08da5a5edf53
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 06:07:54.5923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tMvG+ES8vwIuAAF7+7WDZU0INSmcr842XfsKoQJcurVBwbz4oTW8lNgg7+tCPbeV2dgjODRZhTv3fXBt6ZO8h2z5KIeiKasp4Z0qS4Mxb0w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4527
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjkuMDYuMjAyMiAxODowMSwgTmljb2xhcyBGZXJyZSB3cm90ZToNCj4gU2VyZ2l1LA0KPg0K
PiBPbiAyOS8wNi8yMDIyIGF0IDE1OjIzLCBLcnp5c3p0b2YgS296bG93c2tpIHdyb3RlOg0KPj4+
ICt0aXRsZTogQXRtZWwgU1BJIGRldmljZQ0KPj4+ICsNCj4+PiArbWFpbnRhaW5lcnM6DQo+Pj4g
K8KgIC0gTWFyayBCcm93bjxicm9vbmllQGtlcm5lbC5vcmc+DQo+PiBUaGlzIHNob3VsZCBiZSBy
YXRoZXIgc29tZW9uZSBmcm9tIE1pY3JvY2hpcC4NCj4NCj4gVHVkb3IgQW1iYXJ1cyA8dHVkb3Iu
YW1iYXJ1c0BtaWNyb2NoaXAuY29tPiBpcyBvdXIgbWFpbnRhaW5lciBmb3IgU1BJIA0KPiBjb250
cm9sbGVyLCBzb3JyeSBmb3Igbm90IGhhdmluZyBhZHZpc2VkIHlvdSBpbnRlcm5hbGx5IGFib3V0
IHRoaXMgOy0pDQo+DQo+IEJlc3QgcmVnYXJkcywNCj4gwqAgTmljb2xhcw0KPg0KTm90ZWQuIFRo
YW5rIHlvdSwgTmljb2xhcyA6KS4NCg0KDQpSZWdhcmRzLA0KDQogwqDCoMKgIFNlcmdpdQ0KDQo=
