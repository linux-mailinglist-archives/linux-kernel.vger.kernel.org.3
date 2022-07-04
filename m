Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8AB564DEF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 08:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbiGDGry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 02:47:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbiGDGrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 02:47:52 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0295063C7;
        Sun,  3 Jul 2022 23:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656917271; x=1688453271;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SsZ3hdvcFLP5Bx8HYpZsH5krpZTd6CEnb3R7hjDMwrw=;
  b=ElnHl6RNw4FLBV/O2pqZY/6DErh+Glgx9bLszWoZL6V8sjDFjIzfyS6o
   epaIK76c/JD+xfMdrt6Q1A1DpqVT60vwObn2YnCkxtg/pve3yQjS9pcdw
   kgR7GCaTfcbwb5VM2it6pemwJEGjS4326A6JR4wfEb2mC7B0zo0qobFek
   KT2u2GDMjrEgGj/hLVb0LY/aUw1FFLg9kFGtieTxPqIbN7VKSvwkU53as
   1pXSuNwluBnETtV3+k2nLlKcfdzAkyFmoYKv7bzZRdoJAf0Y4hq0P/YX3
   wStZsvQtAj4Mbz3OWWoSVKYEyCw0kZMTwlzX2PmJXTAHChulvRdV/Ut4k
   g==;
X-IronPort-AV: E=Sophos;i="5.92,243,1650956400"; 
   d="scan'208";a="102870477"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Jul 2022 23:47:51 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 3 Jul 2022 23:47:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Sun, 3 Jul 2022 23:47:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJ7LYbV3tTkkJpCVQuQ723U6dxUhYR1xNO6KRoXsuxXNBIBuZXDdPg3OigqiAA8AakJjM6xnXYqoUpLELYnIcxuZRuewnvfR1pJgCqSLJ+BtngaH0LLo+d16WQlNXr9MW8RoF2jVmPERqVuaa2kdqUmWgNGGnDr5ylM/C7xLOrw8UGVssckyA5z9/emY9KqLnGpTRrSwAaccHXb/24QfmX0mD3NRy7wHjLldWRlsBwGbWOv0CdPadqfW8bt+vYy4niixIaIC3GzExMYKt/JV2XtTQAmzBxkfyNwI9VlbZjQzroajYjCkiTQMGXeQqxtrGDUYzqaJONY6Ay8nhCvJ2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SsZ3hdvcFLP5Bx8HYpZsH5krpZTd6CEnb3R7hjDMwrw=;
 b=CdgMs6fvYVncXrwh9aiLKwgybn0bhPCCwOUlfpQcB46vvKlPUL6Z+oX93hBRvbaJDjJqWB36txTFjXq59DW7HHSl6hOYErOc+VKn5Roa9wCTa65APbShokpb+vrygowwyqSWEuoJZTZTkVHNu4e/FC/ZdRYr/HM7xl44J/YCq+wtTlfa1wUFkBysYQLVsrXfdglt4+8UMreh5Q+02cHU6HXEF7WsL+LytKGkzlPWL7GrluHTfu6t7cB4kffc2reJR5oYbBmIH7KtnPZc4fAdHLoP2R2LnCHn0XewYTDtb4+hG8Vuf+uYYh0O0UNlb4iiny7YttaSYW3zr7vk+3HlZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SsZ3hdvcFLP5Bx8HYpZsH5krpZTd6CEnb3R7hjDMwrw=;
 b=uKSbP8QaiC+d4pbxx6R3XR0Fz2B0stB6uyKuaflin6XPh68xcHQitchRc/ASFv82AtyOz+OFfjkWDBaVQl3ONtSJ0EPY5P2p1j2y69yfEO40g6Acgey9+01sQQ5OPl2z/0xjPLaL5T5r3DwQ7k2ZQq8QlrVa4ktuZtrz+RA8ob8=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DM6PR11MB3497.namprd11.prod.outlook.com (2603:10b6:5:6e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.18; Mon, 4 Jul
 2022 06:47:49 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5c8c:c31f:454d:824c%8]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 06:47:49 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <p.zabel@pengutronix.de>, <sre@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 9/9] ARM: dts: at91: sama7g5: add reset-controller node
Thread-Topic: [PATCH v5 9/9] ARM: dts: at91: sama7g5: add reset-controller
 node
Thread-Index: AQHYj3H6so5qQCQ3cUeLDUq07bA2Ew==
Date:   Mon, 4 Jul 2022 06:47:49 +0000
Message-ID: <b68aff8b-7a0f-810b-2e13-95f3734e0e18@microchip.com>
References: <20220610092414.1816571-1-claudiu.beznea@microchip.com>
 <20220610092414.1816571-10-claudiu.beznea@microchip.com>
In-Reply-To: <20220610092414.1816571-10-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60c65c60-4254-4e39-5ef4-08da5d891ca2
x-ms-traffictypediagnostic: DM6PR11MB3497:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lGJL6/OJ2/ynwqqaQ0mkU6Ebo9RU9LpOziqXeGgF/x7GteXGR++E3cN7zmtc+F3nWwjeCGcN+UyjM5lv57/WVpCIDbvvNVptkyzfH8wG+iYBelNpASf+P2Bi/qf+6o7bvHtOzaaEZIcD+QJeW64bhN9ZP2irEK/7RrZ3NLQsHLCZr+dvnsKVTDINKkhDSvYfDTu5pO6iqkQgpdNdhkqf5kffgoeV3u7nyrQ5prq0n+IV/VvX2zFfX6WsdyAQfuFQZ15udImVWCxMICx7KsncGGvWDSEIzNHtEe6oGzO2bDjCo6WjGZtjPu8nnLAuYYWTuh7WKex0IgsjMBs3ogj5ZfGF0CwIALBFFVWnRr7u5cc0Kybb3aW+/s7Rtlkk0Le+X1KigZVdoD4QkkREXTy0PPlghwRaO2vtxQn75Ddb/4VMoGc5E9UkyTvSjInfOSvpEdl3pHkTwmBs8a94g6lKS2dwP7HqHpayKV7SuORN9qVTVXdieWBJhVI4CPKhrttUWleAnUo+NBTH8DBamAjFslR56/kJbgPFqV83VXpXU96a5EedcuqLqBPjSTssLKfpw39e8yssblt/L9jtVv35bEaxIn3ErcSX0/Fx/0y9J+vSNkk71hR+xfBs45W4oiLKedDg9Xe0qNTQT1PMBUheRPtmD9yMFa0D0kxdLS81tXJEEZNtryL3aUVW+D4MKpr3p+gB1kzpPBfqLco6s8348msPDSHV7tJ95Y031MtKcwREzFdL/Oqbn0vKLfdKVND0aFtjZjXeOd8S8QYhTyt/yxJm14Gu2sd391NgyGOgmiBXBRlqlP0YpkPnVSo6eCrSIUPfTmK4X2wYQic5JdSnfvnyIebki5ojfra8ob1NJ52WDQVXsobzdUby8KMC1AUv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(136003)(376002)(39860400002)(346002)(396003)(5660300002)(4326008)(76116006)(4744005)(8936002)(31686004)(26005)(31696002)(53546011)(6506007)(91956017)(8676002)(66946007)(66556008)(66476007)(66446008)(64756008)(36756003)(83380400001)(2616005)(186003)(38100700002)(54906003)(110136005)(2906002)(478600001)(6512007)(86362001)(38070700005)(41300700001)(316002)(6486002)(122000001)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N05mZ3MySlZKOVoxRmlRS2dhTkhha1IvQWoxUEJOaE9GV0FJVnZsRjhCeVVk?=
 =?utf-8?B?YXFWaklzRjdUYk9Zdmd2RGZJb0czUXcvSFhJVU5QdWFHTlpMMUNlZHhPSUFk?=
 =?utf-8?B?VVZ1SnBWRWhiVW91clNtUyt5eEFkQVlicmxNTXdCcnJLaVRVVHBYRnh5SHVw?=
 =?utf-8?B?cWxOUXBqWEF6b3ltQ3hpVUhwcVc2SHpkZlppK3FPTTN4THdxR2Z3a1VydU5K?=
 =?utf-8?B?YUlwZDJBcnJSdkg0YWRRV3JVVmdVbTZjSkFxZGU1QWcvd2F4cTZpSG4yMXBh?=
 =?utf-8?B?Y25ORXVLK0VsQjBvalJqTHY3OTZpQVNmWHBlRjQ1Vjkra2FxazJWV1lkZnZZ?=
 =?utf-8?B?VjhobDllZ2hzWk9haE5qQ1A1Rk1pczBpUVZha3BEM1J6ZG81dUExRnlKd2dP?=
 =?utf-8?B?RUg5R1U2cUVoVW0xMUF6V0hTQlJacW9jT2I5dXIySklsU1JJRkFjdzJxVVR3?=
 =?utf-8?B?Qk9xeEMvcUZCSVJjZXhmWVdnRU5iREdxMHJaNjJtaFNjRHJHbDAvTnNCOVV3?=
 =?utf-8?B?TEk4aCt6eFhPbEJxYU1NM3FaTlNobzhLblNIcVN3bTl3TVFwdEFxeHB4Y3Jy?=
 =?utf-8?B?Q3VwVU15SVM2UUtOUmhaWGZlUmFvWkt4VnU1NUc3Q2FmN2EvK1NFQS9BSEc2?=
 =?utf-8?B?aXBsdFRUQ3ZXSDhVUHdTQ2JidDlsb0o4Q3JxVllFOEx5b2wwS1NGNW5TemNv?=
 =?utf-8?B?YUxBWnEzVkdLcWNOZHpNZWVBK0RXdlRzU01qTFZhUStrOXYzdkd2VkN5Tng4?=
 =?utf-8?B?MXlkTzhROVZqR1JnMVdnOFkwcURPTFRQeFZ0TVlaM3hDOE5VUk8rbk5rOFRj?=
 =?utf-8?B?N1ZYbitmRHN3SDdLM3NlUXAydEd0bmduQk8wcTRNT2xVRmxxVjhwbTZCNnNk?=
 =?utf-8?B?bWhvK2ZzVUlwQnA5WklCR3AzeWd5QXpYQnNqU08yVFRRcDlTOGRjc3JTdHdB?=
 =?utf-8?B?Y0grb3ptNm0yYkVZYWh3WVNuTUhOc2c0MzMrdW1XWTFTdzhNWVdvbDJId203?=
 =?utf-8?B?YlBXT0lvQXhaU3ZRZ0pDeFdjckY5dlNYbC93NDdadVY2NWVkYmMyRXJ0SzNU?=
 =?utf-8?B?Z3pENEY5aitFTjdqajBIbHRtcjVEa1dWZGpreThzMEN2WGRoa3pVMnNuN2Z1?=
 =?utf-8?B?Q2oza1dBZktVL1ZFdTZ2MkhvTW1FMENjS0JLUnVmYlZQQWpQZUI5bHRkWGFs?=
 =?utf-8?B?ZjFBYzRjbWF0V0J5eUYyS2dsRU5XaVBrN1JESTQ3OVpTYUZDcU54REdLYmEz?=
 =?utf-8?B?aWRZeFVSaGs5QkR0VmZsYXRyMXl1UVYwMmpyZmlTK0pvUk9kMVFXa1UyY1oy?=
 =?utf-8?B?bnRHYkplQUs2d204S0U2ejZuVlVrcDlGL3oxOXFEc2lkSTZibVdDbUxGZm1j?=
 =?utf-8?B?NFpEdlhra0Q2S09BTWxhSFkvNzZXdTJndTM2anhuRUszNHljQ1ZoVExVRGxK?=
 =?utf-8?B?VzRMOTRuUHp2WkF4ZnozSHNHR1JhTUJVODZqbVBmcXM3dGM4aStMWU5aejBl?=
 =?utf-8?B?bTU3R3l0OGQrZHBpUjFnRWtCRHZqYk5haWJaZE9XYWlBSXdOR0lQSzZwVUZx?=
 =?utf-8?B?NG9MVTFGRTY0RG9NZjNkRkhFMG0vVHo2a1c5SWtzNGs0L2pZSkV3NzRvNFpZ?=
 =?utf-8?B?M2pFQmVwZWFicXhIU0w1YXQvZTdqTjJ3RXR0QUtrRE5abTVKZDVZcE5kamk0?=
 =?utf-8?B?cVcxRUZFNmw5RFlISG5PVkhjb0pwVEpWOWovZ1IyUkJqdzZiUWZIWmN6L3NH?=
 =?utf-8?B?eThxbk03NS9Kb3JmZkxVclJzQUN1Y0FoazBiUFB5UWs2VCtPVDVsYVQ4MWRt?=
 =?utf-8?B?UHJNbWRnSlFNUDhkUjNyRTZmdU9hRGNaVDFHNWZjdHBuUVVFWUZYUWU1SW9v?=
 =?utf-8?B?Y21IWmphRG5QV1dpaFlvUUJML1RuWGQ3bUlQZUMveE5zTUhDMnFjcGVnb0xq?=
 =?utf-8?B?QnJiTDNNVUU5RjRqQXYxT2FoUC9NRkNSOUFqNDV0bkRJNFNNa0I5S1czbDFu?=
 =?utf-8?B?TXVMTEEvOE5vVGhoNlE0QWJid2ZMcjg1dWRWUFlFWStjRHRsUW5LclZKa1dP?=
 =?utf-8?B?U1lKUDhxZlBBQ09kTy8wQkZFcmFUcUt2OEVsUzFzUjJ5UEJEM2MrK3ZIWTVk?=
 =?utf-8?B?clRjTGVVZjIrWjR0ODNEWEZmVklkYi92azJhQTEyaWVXL0Zhd3l4YlJOalFN?=
 =?utf-8?B?REE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6300254BBE869A489FE3082E411BD19C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60c65c60-4254-4e39-5ef4-08da5d891ca2
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2022 06:47:49.8339
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yttQtjRFSEcAnmDbMfGgC5XJax/EC6C/vVxyInpQZCWXMxhLZ/qgW5i4B94vzDtzSOqJzCFJfT6PqP3rKVA3K1fevI15wXv6OzZ+ZQ+lWUA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3497
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTAuMDYuMjAyMiAxMjoyNCwgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+IEFkZCByZXNldCBj
b250cm9sbGVyIG5vZGUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1IEJlem5lYSA8Y2xh
dWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCg0KQXBwbGllZCB0byBhdDkxLWR0LCB0aGFua3Mh
DQoNCj4gLS0tDQo+ICBhcmNoL2FybS9ib290L2R0cy9zYW1hN2c1LmR0c2kgfCA3ICsrKysrKysN
Cj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9h
cmNoL2FybS9ib290L2R0cy9zYW1hN2c1LmR0c2kgYi9hcmNoL2FybS9ib290L2R0cy9zYW1hN2c1
LmR0c2kNCj4gaW5kZXggYTM3ZTNhODAzOTJkLi5iYjZkNzFlNmRmZWIgMTAwNjQ0DQo+IC0tLSBh
L2FyY2gvYXJtL2Jvb3QvZHRzL3NhbWE3ZzUuZHRzaQ0KPiArKysgYi9hcmNoL2FybS9ib290L2R0
cy9zYW1hN2c1LmR0c2kNCj4gQEAgLTE5OCw2ICsxOTgsMTMgQEAgcG1jOiBwbWNAZTAwMTgwMDAg
ew0KPiAgCQkJY2xvY2stbmFtZXMgPSAidGRfc2xjayIsICJtZF9zbGNrIiwgIm1haW5feHRhbCI7
DQo+ICAJCX07DQo+ICANCj4gKwkJcmVzZXRfY29udHJvbGxlcjogcmVzZXQtY29udHJvbGxlckBl
MDAxZDAwMCB7DQo+ICsJCQljb21wYXRpYmxlID0gIm1pY3JvY2hpcCxzYW1hN2c1LXJzdGMiOw0K
PiArCQkJcmVnID0gPDB4ZTAwMWQwMDAgMHhjPiwgPDB4ZTAwMWQwZTQgMHg0PjsNCj4gKwkJCSNy
ZXNldC1jZWxscyA9IDwxPjsNCj4gKwkJCWNsb2NrcyA9IDwmY2xrMzJrIDA+Ow0KPiArCQl9Ow0K
PiArDQo+ICAJCXNoZHdjOiBzaGR3Y0BlMDAxZDAxMCB7DQo+ICAJCQljb21wYXRpYmxlID0gIm1p
Y3JvY2hpcCxzYW1hN2c1LXNoZHdjIiwgInN5c2NvbiI7DQo+ICAJCQlyZWcgPSA8MHhlMDAxZDAx
MCAweDEwPjsNCg0K
