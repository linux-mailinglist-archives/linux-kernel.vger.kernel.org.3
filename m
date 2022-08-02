Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7778C5879BC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 11:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbiHBJNz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 05:13:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbiHBJNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 05:13:53 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613D211814;
        Tue,  2 Aug 2022 02:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659431632; x=1690967632;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Y/ZDRMAG9wIE1sTY1/0OehuTSEOny7aWWPWpJN/p+vQ=;
  b=ARwRPa7NAcnpyfEQFyupDVDODwHux/SFFBXbuvjJmWTO6oHP1lGqRwb+
   UhHR8ImYCOOFaEwWK55oPak+5N0XngnN77+OSfXbMbVxmj/Qneup1CW0k
   VNFmZjr80s9z8u9cVQn4SI71lOoB4ZQLl2WdFRBYW6h+5eZoJaxSQxwnT
   9deHKktIwlG85xZRxEH6wdOSl2Nwgu/tZTZAKYWwHWAeXxer49Zd5RdNp
   waL+J+AgwClyiTs4pyYOffekXpD0BwpY2TeP/r8czg89IBHUj3ab7FCK3
   VDFm4grPJVXG4THklUymBix0jodGAZfGKNuK7jF56Iirbi05mLhvZe4go
   A==;
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="174708806"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Aug 2022 02:13:51 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 2 Aug 2022 02:13:51 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 2 Aug 2022 02:13:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TeP0cdP+uq9qTjDq4HBpQAXIoOQnIZSdd/ExcpoEzJ9hDyHYj9ZW3oS2s54q6YP/neMFG8T1TxcN8SIgkzmk5rsp9HAtScHPYK2EJ+cnXPt0Es76Ml9AAnzPNIsjz+avJfBuJKcv/PJSgtcW+6eSSBeEtR7o0+Wr8FioOPdigzZ5xxSmIUaRfr9kKY6Uz2f+r3oTpJf0VNl/6qiZZ8i4WNnH2X1CT7ArFuqgtH5i1Z/vcLpVqMNkZZYoaS6z6Bywsj8uNiKkQfK7Z3ABR8eniLg64aO5dmXuuA57AVdJVWmqMBAqgvlxh1bvfosY9nQ7doM00UQCtSS+hDxgUW7E8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y/ZDRMAG9wIE1sTY1/0OehuTSEOny7aWWPWpJN/p+vQ=;
 b=YJZelRzR33OMBAdHYYbJlufnHIILWBwMp9L+y/1DA9FaGAGT6A01BOazHrj+1tvS4KGiQcCUdvm6k75HXc98l0jUi+VklXlkEEa7z48bQ6UgcZTkqapwqyRoaPhY3LKNP5sZvPbgTmclI53PJwHVYBs8ZW+Ri+cRGxcjfenHnT+vV36JyGgP12feDhzyBHvam+7/D6BIhRDfSHskLUgqqJisNPGe5U85FS2AJe7zuNYcSgGaOR1vK2kwLI7PH9yMWbyuESsx1jRUSthRDdCQWDFQnQDnz6jDViQF7qwsmmxcSpcJSyiKeeZojK/yzDLqsIZZ3ASF3Ljm4rMAIWW+lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y/ZDRMAG9wIE1sTY1/0OehuTSEOny7aWWPWpJN/p+vQ=;
 b=tb2xH0LIejuD79gRCZ8nSHCuFv2jkSTcUKfAY3L2ckcRHSdSDqhYAM84X6waAxMP+tzM+7BrjE/ZL4xVaxlWmxwRPKd/1OdYIuV7KO8bXOGxAs9/q4WdryZ1vqa1E86uALL0sTTXh4iqUpsD2rj3E5COMhcYV7yNdmtPr1oDo1M=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MWHPR11MB1326.namprd11.prod.outlook.com (2603:10b6:300:21::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12; Tue, 2 Aug
 2022 09:13:46 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 09:13:46 +0000
From:   <Conor.Dooley@microchip.com>
To:     <Nagasuresh.Relli@microchip.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Conor.Dooley@microchip.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] MAINTAINERS: add qspi to Polarfire SoC entry
Thread-Topic: [PATCH v2 3/3] MAINTAINERS: add qspi to Polarfire SoC entry
Thread-Index: AQHYpj5qv1mq0ZJ5s02/u9XlT+5Ki62bVAIA
Date:   Tue, 2 Aug 2022 09:13:46 +0000
Message-ID: <f1d723cb-5e7f-e698-cdcd-d84e3dc9dcdf@microchip.com>
References: <20220802070518.855951-1-nagasuresh.relli@microchip.com>
 <20220802070518.855951-4-nagasuresh.relli@microchip.com>
In-Reply-To: <20220802070518.855951-4-nagasuresh.relli@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7abf338c-8262-43e2-8a55-08da74674df2
x-ms-traffictypediagnostic: MWHPR11MB1326:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UAO2dJ50fXWhNI8AQ/m8NpAF3kWJxv+XTGtY3+tatoCM/1MeTc2YGNbmD76dVPe7j3BEwZbOLuGL2LHFkrn5719ZG07PlV1bU3IMJHf1ZBuuTmfs4+OrCOeHvyxeFzp7Y5v/Knqs7mxsgpc+R4yA9V9UDWwY1hEgLelhUveOYHpbVPhqzxhXmQQC4vT6UJr46CeogbdGgiHJsldERJCW5ga9UvzutoDhsD8r29LXO5f8qpNq0Mv1Bt96S0h6TQA7T8zHpmQ0I7YPuYqebfOPwWi1ltt0wsYBnA7XBs7hq7DfQzyqExkw6R1UPoRGg5O9RaZE2+fgH/+EWnV6Jjd75iTFu+qzUC1vqFAvIbwjBiDXkOiuXF058NSS2fn19IM/4Djk67cN3Ld7Cp/AkZHztVvmVYRgH20yLifSf12VBOH1nACtnkXY22sI74NnMGWjcQziDDbDIVJBUiGunZnkuj84+FiqeHzM1u/ZT/GdO/bYXPS8UwMPlPHlbW11j1em5IxJP8wIeoCaXFXDhH/lYb0ovw6TqbIseZPoLs1D5YaDmmU7JTTkurPK+FwX/Q0z5h3Jfi7I3hUsXm4KzLg9ZiF6Igq99x9fdduoyxH4Tke4F6UmN4XMoFNkeyEOYslBai5gGiD2ACW/BnwwlT5xHHVGZJzipaC3ECg1cH+JCDyxe4eunibEG/k+kJbbaVm5Py3wJIYOd/rbi/YRLooN3RMzzJMSckU6KisMgNdeEvIoFj+bJ+pZ4dUCAWxt+1nr1WwujpcwzksC+8i7ca5Pl6WykAe0zoVGtrtpCSnNP4rP4uq4WKjaJPi4F6st9WzJ5x4zd1sNDcr+eZzp/daCP+ySot3L5ftqHs/6UbmvM0Y=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(376002)(39860400002)(346002)(396003)(83380400001)(91956017)(5660300002)(4744005)(2616005)(186003)(36756003)(76116006)(66946007)(66476007)(8936002)(8676002)(64756008)(4326008)(66556008)(66446008)(31686004)(2906002)(316002)(478600001)(6486002)(71200400001)(6512007)(53546011)(26005)(110136005)(54906003)(31696002)(41300700001)(86362001)(6506007)(38100700002)(122000001)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGdrVW5uODdtc2R5ellLMEI5ZWVCM3VtQlYrK01SK2V1ZWRaaldJdlQzbXRp?=
 =?utf-8?B?OWFaYk1qd25nc2l4LzFRS0U1THh4aW1SMWNvK0JpcWJqOE5nSzBleitpc0tr?=
 =?utf-8?B?TjV0c2tOMTBwNkJiZ3RsUEprWHFrbXAwVkpaWEFsQzkvdWc3amZYTSt0RDZu?=
 =?utf-8?B?K3c1cHJHVTF0dlJnc2J1M1VkVzdUbnNCdCtPZnU5RHhlK245TzhtQ2EwYUgv?=
 =?utf-8?B?R3VZbUIzczdrU3ZlRXo4Q3d3dkZwWnUxMjBSazB0bkZDTDZDb0FJci9uZ05a?=
 =?utf-8?B?b3paSXhBQnUxVkE1blczc1NnTC9hTnFkZERRamc4ZkVOWjBTT3paY0hnT0xm?=
 =?utf-8?B?SjJ2RkJjSFlzTjE2R2lPa0ovM3hqd0RZbWFtWlNpaWNmUkZUVityMEE1WU9E?=
 =?utf-8?B?U1U0YkZpUmo2VmlxcjRxVEJFamRlY1hteHBNbHllTXVGU0kzc25yZ0RZcm02?=
 =?utf-8?B?YW5PUCs1RlZ1eitqWHlHMnNaMmhENlpsWVNsZkZLWTBUbENxTDRNazhKL3Ns?=
 =?utf-8?B?Nmh6cWI4MjNyYVh3SGJoYVVFdUowSFpKd3dHQmk0eURaNVNVbk1XeE9uT3FQ?=
 =?utf-8?B?Wm5uOURwaHRvem5FN0YrYTA1aGt0Q1RtVU41OVdBclJnYStVbEc2YUg4NU1G?=
 =?utf-8?B?a1FrTUlPOFhzUVhOTHZ5R1BISHlDM3dtamZ0SlY0U2FFV0VOeTg1K1FPZzBM?=
 =?utf-8?B?a2xnZlBvcFo4bVZheWdNK0JzWFRHcTYxbmZ1cTlmUWZWZU5DUndNS3ZKVVhh?=
 =?utf-8?B?YzNNK3pXc1dNQVRVQXh0Sy9ScHhWY3dSZlZYdjI2UERQQ3dsTitRcVRYa0Fs?=
 =?utf-8?B?eC9nVzdWQ0g4a2xxWXpuTGRhUFpIdmUrL2NZQnhOM21RbkZtMkpuczFWNXI0?=
 =?utf-8?B?ZkJFMzlVM0ZaZ25VQmxXRkNOOXJEMDBRQytKVWdpZGlLVTN4ZEFYN3owS042?=
 =?utf-8?B?QUx6OGhJOStZQjQ1RnB3cklKYlJ3Vi8yNFpodk13Z0hUemFMRXNzaExkV2tm?=
 =?utf-8?B?Y3JscFQrNWhLY0JWcWZzT0dOKzZBZHRFcHp4NWE4OGVXR0NjU005UVp2MTgz?=
 =?utf-8?B?WTA3SENtcmxvVXNYOFVCQVE4SkR1USs2NXpncVpqTXFzMmFpdURBN3QrdUM4?=
 =?utf-8?B?OUl6ZDRZOVRDM3NBZ3lNMWlRSGJQV012VmlUMmpCa1MxMkFIK1RHcE1jMlpm?=
 =?utf-8?B?UHJRSkhhQTJEYWE3UEVDaThFbE9jMGFjMmw4aGZwcGVjSlFxKytWUzF5QVd5?=
 =?utf-8?B?QUlpVEFXb1pHZmhGK0s0RmdRU2lRWXIvc3dCUHZtUmRLYXBrSFpJYXNIR25O?=
 =?utf-8?B?cjhyRUltU1VHdGFzaUR1c1h4K2hzS3ZhcVFXRjRVNkN6TlBzZVZKcTJTWVpC?=
 =?utf-8?B?a0lzZWpMNnhnYjRoQml0b3Y1RGJSeU9Jb2VnYlRoUVpUV0lsSXVQcmtLbTBj?=
 =?utf-8?B?eXBvQmo3VzladElTRkphck5aMGIwOXlvSzhBcWV6dUJhaE8vM0NydmYyUzlB?=
 =?utf-8?B?QkViQW9OS1MwZnJtOFFTMmZ2OXUzQy9iY2xRalRzeVREUlJXeWY5M0hPeVdI?=
 =?utf-8?B?ZGN2MXUzdzAzWmpiTndxU2J5YlptMnpoenpreUI1TVl4eHFCaFJSUnNJbTl4?=
 =?utf-8?B?c3d5cndJZXkweG0xZ091TkdHTHBKeFBmR3lnSSs0TFRjbjV4YkROUXBhNU1n?=
 =?utf-8?B?WDEvUHEzVHJUbUZscExJQ1VRN0ZMUGpxZjFRRVpXN284UTA2UGtVYWFzSmM0?=
 =?utf-8?B?UU9NS1dPQWM1bGpvS1hyWEh1UVRRUHpnRHpjY2l6bWtZR1RMeW9kMFdxNUty?=
 =?utf-8?B?bU1jVDNmMVVmS25SdXh5bVJQeSt4aHNRM0w4YTJmWC9YQXh2RW5tVmdKVDZ6?=
 =?utf-8?B?Qk51ZnJVOU9QbnB0bUdOUW42K2RCSncxWWltODU5cDZUSG1FQStLREJzWVQ5?=
 =?utf-8?B?N1ZJZXR3RW9NMHorNGFOc1lvQ29RczFZSGgzRlRnZFZmNCswRnlpTmpNcDJ3?=
 =?utf-8?B?cFVNcXlQYU5DaVQzcnhLcEVxaFRONjVyYzFQMHVqcFZzOVl1RVlDOVdQUThk?=
 =?utf-8?B?S2hKZmlZSnVIUmFxSXprQXNXVGZiSUtKVkJYdm8ySjhXYzBNL1cybXhaSGFn?=
 =?utf-8?Q?bgrQjcU3zDn60Jv5u9H8vqpTV?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FF52561FBFADA64AB4F581BB0F0B9457@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7abf338c-8262-43e2-8a55-08da74674df2
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 09:13:46.4384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tBQ/i8N2hUGasWAEKoIcz60vyMvECRYpXo++/4aVJY6mlUwJFDvMAU0iarxk45xHoBSjA7eoeJTetucO3uKHI0neifa5zFj+evqkx8jDV8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1326
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDIvMDgvMjAyMiAwODowNSwgTmFnYSBTdXJlc2hrdW1hciBSZWxsaSB3cm90ZToNCj4gQWRk
IHRoZSBxc3BpIGRyaXZlciB0byB0aGUgZXhpc3RpbmcgUG9sYXJmaXJlIFNvQyBlbnRyeS4NCj4g
DQo+IFNpZ25lZC1vZmYtYnk6IE5hZ2EgU3VyZXNoa3VtYXIgUmVsbGkgPG5hZ2FzdXJlc2gucmVs
bGlAbWljcm9jaGlwLmNvbT4NCg0KVGhhbmtzIFN1cmVzaC4NCg0KQWNrZWQtYnk6IENvbm9yIERv
b2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQoNCj4gLS0tDQo+ICAgTUFJTlRBSU5F
UlMgfCAxICsNCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9NQUlOVEFJTkVSUyBiL01BSU5UQUlORVJTDQo+IGluZGV4IDI5NWNhMTZhNDE1Yi4u
MDMyOWRjYTIzZmUyIDEwMDY0NA0KPiAtLS0gYS9NQUlOVEFJTkVSUw0KPiArKysgYi9NQUlOVEFJ
TkVSUw0KPiBAQCAtMTcxNDYsNiArMTcxNDYsNyBAQCBTOglTdXBwb3J0ZWQNCj4gICBGOglhcmNo
L3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC8NCj4gICBGOglkcml2ZXJzL21haWxib3gvbWFpbGJv
eC1tcGZzLmMNCj4gICBGOglkcml2ZXJzL3NvYy9taWNyb2NoaXAvDQo+ICtGOglkcml2ZXJzL3Nw
aS9zcGktbWljcm9jaGlwLWNvcmUtcXNwaS5jDQo+ICAgRjoJZHJpdmVycy9zcGkvc3BpLW1pY3Jv
Y2hpcC1jb3JlLmMNCj4gICBGOglpbmNsdWRlL3NvYy9taWNyb2NoaXAvbXBmcy5oDQo+ICAgDQo=
