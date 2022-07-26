Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178705814FA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 16:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238351AbiGZOT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 10:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239083AbiGZOTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 10:19:15 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A42415FEE;
        Tue, 26 Jul 2022 07:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658845154; x=1690381154;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=/dyv4Ve4pwMDov3mwJqLkOdZHnuhoYArcMdJ8F1faEY=;
  b=PP8c6lXWzAz9aJn3Z5Z+AUiUZOvb6oKSItxuKmDsBEtjV7XSGugi/1G4
   wWHfH3nB84p1rGxBA94RQB34/BPjtvvJcxGUH8hhTcPF8WUY4kaNygy66
   tmErvNwwWJr2WHM+hyRtIR7ZrNotINUTc+WKSjgkq2aQ5mhTl9XEhnPQ5
   3JBqwptgbL2/8xvRv+zm6VgAkCC9F25CqnX/oVjx9GB5fOCDVYp7SKZl7
   jBz0/5CO49Xt11AGHxsoGBkjS7fXHMGj8drcnXBko8+WVCM81jhYksyvp
   DvipCPt+7hNFjNntnI+dDOZUvt23bm8b+G28xde7DFrzznnuEkq49yWDO
   A==;
X-IronPort-AV: E=Sophos;i="5.93,193,1654585200"; 
   d="scan'208";a="169575464"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jul 2022 07:19:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 26 Jul 2022 07:19:11 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 26 Jul 2022 07:19:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GCcT8LTp/Qw22uI+7RM2kfSekysOKbKH0VW+/20Smt62oOWBWil5SpMwyp8YcY9qDBV7Qzz7Fn6GYksnp59C7chEo7OOpbJkd0jnhXJyB98KKozUITTrKoMGOkeeIOXEInyza/IzVs7l8kn9DgLSq8H3rg3CBFJekP17aPD8ymld8hgkLaARGRihXzQxuXCXNv+aOL7lZKfkbD5UhOpw25ylCW9Ovvn0ajQ9E/FuRo1PWQiE3Assu0DeskoyW5SdwLFsyy5FzKYGxzR/vVTcEEVjImj+ou7tUz2WX63QyxncklIh0BXs+YK9EcPOqWsozylaiOnGgq4j/MrCkkhbBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/dyv4Ve4pwMDov3mwJqLkOdZHnuhoYArcMdJ8F1faEY=;
 b=cm/bxet7EQc5pZXmey9VPp+Rav2MXqogsY3wG1QSKVCfyrpkPXS/bGuZXjGiAubE/5VeEchCJj7gCtn9eFv+7b3iE/XFBE3JRKmro0qUZw8XagFPpyVCzfZUp4y6Bp3tWdm9F/qsad+60R2qs/siY50lClRn3xWOXPqyEGexWpdSbt4161jX2UABwgG8dJ3sw2e5Ep/07LmfXRpOvHmitFylmkavtIzFo4V9+JCNfgmLxkTqxXyLNhtjt37rrUEm7ZFKpXR70nAZRtEFjf2q9bc7w9+B7UQ0EIGKvl/bnQDYlGBiDkN3cdtOLf0XpdRkY16bfP+V3MBMY3nODL410Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/dyv4Ve4pwMDov3mwJqLkOdZHnuhoYArcMdJ8F1faEY=;
 b=fpVRTOmd1yUiA88dU34ifbnNBRRxaVvhq4g2cy8gDdd8RZcrE2/JRDM9bH7K/jrOGbg6i/QDxN9LKq3mtWPr+Ti+IjvXYO+Gklh2pCoZoK+L+ZpAbShAsfgDUKTKVjI7EgLX+zaoX5HO2tjK2lsDOfYaGHb9pDzALBKAzHzcs5s=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BY5PR11MB3925.namprd11.prod.outlook.com (2603:10b6:a03:182::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.21; Tue, 26 Jul
 2022 14:19:05 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5458.025; Tue, 26 Jul 2022
 14:19:05 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <arnd@arndb.de>,
        <olof@lixom.net>, <arm@kernel.org>, <soc@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <f.fainelli@gmail.com>, <rjui@broadcom.com>,
        <sbranden@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <nsaenz@kernel.org>, <Conor.Dooley@microchip.com>,
        <devicetree@vger.kernel.org>,
        <linux-rpi-kernel@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] dt-bindings: soc: microchip: use absolute path to
 other schema
Thread-Topic: [PATCH 4/4] dt-bindings: soc: microchip: use absolute path to
 other schema
Thread-Index: AQHYoPqpJ49D3mePY0ivhhZy3B/hhg==
Date:   Tue, 26 Jul 2022 14:19:05 +0000
Message-ID: <af0c5563-8e62-8909-61d3-476c1f36b074@microchip.com>
References: <20220726115841.101249-1-krzysztof.kozlowski@linaro.org>
 <20220726115841.101249-4-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220726115841.101249-4-krzysztof.kozlowski@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f536841-9e78-411b-bb18-08da6f11cbea
x-ms-traffictypediagnostic: BY5PR11MB3925:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sYe2ETfF+YFJd7gMFUb7lkYWD9WSjAEwhs213IQYB9Hg/yGscQf15U9Wb1b9lxKYMFa2CpIM3XcPWpk1fekT1YL8PuQmmq8xVwhGlBvapfL5pLI0Opp3NSnmFxxAXlGAmrKaxe5z+oHQwSZStfFBI4RcdM9TURf1cdq+aEOZD/DEsWnU5OuaBwMM9aiT1u8MKgxxQ88SUl0qLOBBuennk5RhjI4Y7T/V2ODaEf0NsGaITYrLwxv+cgbL4DjBnINS4465w1uaqaEdgauHUq/pPblgQcO+fjeCl3lIcF2lY8GjwVfeq0cCavbM371HYAGrnbrnBd6MYhkMPy/HS/BFfU/GLR5oMAIQiFx5MJTKidVGQMLlOHyucEtAmjXWOpNVRjBCwZ+MuzAV+GpWMBBETINcrAnAZmIHKKYKxXjfZDx4UIX7yO4Xue9WkJ8WT6GtdzATho+f9S4pb/Z07pYq89Fd/y6+aPRRGeeIbji/sK9nVwggRJNSCTc800pj5xYtjKG++oIpUKXkpBp7sqVu71xwhBKyznk6ZtYHjuRg2e5+iUkgzt590EFiqTJElI958vVzlmCtTMJCFH9mnGuNZ9s4L1IOuyJfB3ELzmb2uVihVVwcED/kYWl4l534V6ZWp503PW46qYxiJnnUC0Kc1NhGSy/OlPJBnJ3gBG55W8mhXHtyOD/YsFPfZsUAVPR3Wgy9Sa8k6ztVin4Mv4TEOPrOUgvPkfQ1ehmnfxoa3y1e1RghAlCkSWZ21p05QU8E4MbkNRK35xkN1eT3cnWKjGC3XXstvkreQyOKOiMGmNoZuteSRmaVl4iGSlSE0xsnDJEFvOa8w+6rGUU3bv1KmOrvBLAE78qLm5g4B6ijDlzQ3ruQuR3p0f+bNZWh7IPq8ZnhH36Fazgtch+QD4/taw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(39860400002)(346002)(376002)(366004)(136003)(316002)(91956017)(38070700005)(7416002)(8936002)(5660300002)(71200400001)(122000001)(2906002)(38100700002)(53546011)(76116006)(64756008)(921005)(6506007)(66556008)(66946007)(66476007)(36756003)(41300700001)(186003)(8676002)(2616005)(6486002)(31686004)(110136005)(86362001)(6512007)(26005)(478600001)(31696002)(66446008)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dW5vT3FFM2hJcXNpNzJRaXh4WElKNFpRK0NDVEhNSGwxNDhsckVMU2Nua1hS?=
 =?utf-8?B?M2t5K3psSHhFUzlieTVyQ1ZUc05NWFFBblIxb0JHaHpCMUxkb0N1ajczclBp?=
 =?utf-8?B?TEhYVGVPalJ5cG1oelpBcEZhQVJzM0x2WUVMMzR5Y1oyTFlGRENQM1hFUGJP?=
 =?utf-8?B?bDVsS3JvdTR5UjJlb056bUZaa0lmQ3FRUkZ5NXBhMjl3Z2Vzd1FpMCs5bmpv?=
 =?utf-8?B?OHl4Rjl3M3Urbk5oMGFlS09XcEw2d2lGcjZ4RlhsMTkxM0Z5YUFVSDcrdEk5?=
 =?utf-8?B?Mm5BQ05zdVM5WGdHVzNiQ3hZTDVtSW1neGI4QlFuR0JqZXdNckV6M0ZXS0hN?=
 =?utf-8?B?dy9TbTdKN0lVcWVPTllMa09QLy9mM2Z1OXZGNVRlODQ3KzArYU9OQVQ5cHMv?=
 =?utf-8?B?MUJ1TUFWdjlHOEJ1aTJRbWhGRElKamV0eHhjd2FwaTE0YTVXU1NhYk4xVnBB?=
 =?utf-8?B?QTYwN08zMTgyVTNFSlZUVWE2T3k1QjZiRE9oOGR3UDY4bU5PM2E2Mi9PTGhT?=
 =?utf-8?B?LzBxVTdEVWdBbzFtZ2xzU2hkTjAzbEdxek9xbG5KM2UwZS9Va2Q3ajlVcWFK?=
 =?utf-8?B?WWRUYUdyL3RJL2lhT0t0eXFVRTlGR2xpS0NmVHNxcnhidWNQMllOZllXN0or?=
 =?utf-8?B?ZEVkVWlVN0x6VlZHYkF3aG1hSDhiVTAxR2ovdzFSMTNkRjdKSTJCTjV2d0sw?=
 =?utf-8?B?RG1vejQyS2dKbEJ0SXJZOUg5UWJTY2RKMGJueE9yNG1nUFAvUnFOWCt0NlFM?=
 =?utf-8?B?Z0pnNDNidzFxR3J0Q2llZTIwMjlLZGcxa0psUXE5MnlpWUFOTDc3U1hvOTUv?=
 =?utf-8?B?V1JUazdDWWRBbC9CWm05TFNTaWJUN09Fa2h0V0FLOGJhSWVla2ZOZHY0OXJx?=
 =?utf-8?B?cXVnOHhhdS9PNjlINnV3b3dXT2haL0xyRjBpWll4L0s1blVUaWdLb2xFTXE1?=
 =?utf-8?B?cXhZL25qK0RWcGplMWNNd0twckI5UmVwSG1FVUpCN3ZBbXdsREZwTjJFbkh6?=
 =?utf-8?B?ZCs1U1BXeXllSEhRSXZBbmJjclVnaFhmRVRPdyswMUp6bUdURWM2cjNKRHZH?=
 =?utf-8?B?R1Q0cDBJZDF6SEUrL0tOZXRYU1FCUmd4WjRGdmxmRzBTQUUyZE9rNTViUEVX?=
 =?utf-8?B?cGVsRzUzM0JjeE82cTZWL0RLcWEzbXRXdDN4bjFRMlMxTXVSNFFXS3R2NE1M?=
 =?utf-8?B?NTBIOE8yRkxTQ0JubVJuUFVsUUpUVmpaOGVrQWtOVVNORjFvNnBnbS83aWhX?=
 =?utf-8?B?eHpHaEJRRTBhUVM1Tm5IbmV6USsyaUhkVFRhSVhWUlJXS2hXeFZIS3VuL3JK?=
 =?utf-8?B?RHByQ205QUkrN2NrWDY1MHpoZDhqVjcwUUc4WEJ3NWswZVArUWF3bjFUaG5Q?=
 =?utf-8?B?Z1V1MldWVW5QSzExU2o2bUdROFF2N2J3Y0R0WlRZSmdOYWFuR3kyb2VPSWVV?=
 =?utf-8?B?RzBJMFhDRmNsMWgvZzJ3NEx6U2ZBVDdTK2tpT0JJdEtNVC9VK2F6M0tRZjRL?=
 =?utf-8?B?VElySUIvWmpOQkJNNzVmbW1VUS9YaEVMNnBpTGlMZHoxWXJvYk5hck5SSk5U?=
 =?utf-8?B?VXR3MUtuOE9kSGdZckxtdHJabU95VTlUVEhnSGZ4NnEvSFRlMXZOUDZJRWpr?=
 =?utf-8?B?eDVyUlZSSVJ6M2dpcXJvL09iUkZ1bUVkcE1jNUNQN21OM1NGUWVrcjFaTkYv?=
 =?utf-8?B?eHg2WkhXNjZqN1phOVY0SmJjMUxNbTlzSGltQXVHOWdkZG9VVVJVMHhSY1RP?=
 =?utf-8?B?Uyt3cDVvL0VMeFVBcXJoZktoVzF3TEw0YWhCWFF0RDY1dFArdENEejRLN2tG?=
 =?utf-8?B?enNZM3FsdHd1c1oxdWljemx3RC9mK2tjYnVVZ2NsRVVBTjNUWE5qRlNTaEVp?=
 =?utf-8?B?WmRhbmw2c1N2S2xEbmhxQ2o2OVZqbWN1NGJsYk5UUE5rVFJNNExRcmNicTMy?=
 =?utf-8?B?dzlQZmVuUG5uSHducnlkOUtXamlPc0dMSnNiVW12c2l3Y1MydnpjTlVWSVQv?=
 =?utf-8?B?alVRbzhDN1d4QXVUQkZNZzBueFBrVHMvOUkxTGsxUXZGVHF0UDBBb1FtWE9h?=
 =?utf-8?B?OG5JWExQZlVqVlRnekJrWi9SN0Rja0lwVzNFNExXWk1WM1RpZ2NMSUNJTlo2?=
 =?utf-8?B?c3pMMmRqNzJpOVFrNUtncnBtcXVLWml3WEl4WW11U0xnTUJ5V09NY1VKSlU3?=
 =?utf-8?B?MGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <58979F946013A64D83AA698F135BDD88@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f536841-9e78-411b-bb18-08da6f11cbea
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2022 14:19:05.2006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pCH3Ez4R8+ItW0rNpD+PFrsgLH46QPdfT6OuYU9rPEz3jU/n+/LzwS4wp+p+UOqhNeyQ+OKtI0rBrcYtExoWwmnr0TJaXT/liQ2WSbonVv8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB3925
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjYuMDcuMjAyMiAxNDo1OCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBYnNvbHV0ZSBwYXRoIHRvIG90aGVy
IERUIHNjaGVtYSBpcyBwcmVmZXJyZWQgb3ZlciByZWxhdGl2ZSBvbmUuDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5v
cmc+DQoNClJldmlld2VkLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9j
aGlwLmNvbT4NCg0KDQo+IC0tLQ0KPiAgLi4uL2RldmljZXRyZWUvYmluZGluZ3Mvc29jL21pY3Jv
Y2hpcC9hdG1lbCxhdDkxcm05MjAwLXRjYi55YW1sIHwgMiArLQ0KPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9taWNyb2NoaXAvYXRtZWwsYXQ5MXJtOTIw
MC10Y2IueWFtbCBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zb2MvbWljcm9j
aGlwL2F0bWVsLGF0OTFybTkyMDAtdGNiLnlhbWwNCj4gaW5kZXggMmY4Y2Y2MTkxODEyLi4zMzc0
OGEwNjE4OTggMTAwNjQ0DQo+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9zb2MvbWljcm9jaGlwL2F0bWVsLGF0OTFybTkyMDAtdGNiLnlhbWwNCj4gKysrIGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NvYy9taWNyb2NoaXAvYXRtZWwsYXQ5MXJtOTIw
MC10Y2IueWFtbA0KPiBAQCAtNzUsNyArNzUsNyBAQCBwYXR0ZXJuUHJvcGVydGllczoNCj4gDQo+
ICAgICJecHdtQFswLTJdJCI6DQo+ICAgICAgZGVzY3JpcHRpb246IFRoZSB0aW1lciBibG9jayBj
aGFubmVscyB0aGF0IGFyZSB1c2VkIGFzIFBXTXMuDQo+IC0gICAgJHJlZjogLi4vLi4vcHdtL3B3
bS55YW1sIw0KPiArICAgICRyZWY6IC9zY2hlbWFzL3B3bS9wd20ueWFtbCMNCj4gICAgICB0eXBl
OiBvYmplY3QNCj4gICAgICBwcm9wZXJ0aWVzOg0KPiAgICAgICAgY29tcGF0aWJsZToNCj4gLS0N
Cj4gMi4zNC4xDQo+IA0KDQo=
