Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA035A2C81
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 18:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245420AbiHZQlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 12:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245014AbiHZQlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 12:41:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD7DE22BE1;
        Fri, 26 Aug 2022 09:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661532060; x=1693068060;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AN+igvmVyKxyEW5XckRnYRpmalVFhUHDTkan7mORl4Q=;
  b=dcYf1jH2/EUs6Mz4N7tF1fHLtFXoKQjY7ZYpgpW8cCg6GxN/g/bi+Lod
   nCk7GNBEKVLHBgesuIKLt4ETrL907TcRBYai3YtuCrGZHZ6m5BfPJxc8M
   edUOexP2KTKkaQeoNrAe5R4sdSwNPRK2o6xzN7jvX6J17yngmQbpwrmtv
   o4x/cwDQueTg+le9hWsU/f5IMLqo5UQZYoMmyfbL6FQQbfRgE121sf1u1
   1n11kEywCgELnsEJT/FaMtciExjnAwLqrtStCVfp35bqHO6HL2Fbb5yrt
   biqj/xJpozZkY+bf9SS5TKjHfmzXyg/9EyKJ9v742HyzxTfkBFcgP+LC2
   w==;
X-IronPort-AV: E=Sophos;i="5.93,265,1654585200"; 
   d="scan'208";a="171152218"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Aug 2022 09:40:58 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 26 Aug 2022 09:40:56 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Fri, 26 Aug 2022 09:40:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oDdJHGhDEFcCOXwQk7Qjl5gGSniUYyRQyTQMIQ4pgUyUJXgq/23Eego4L/eTtOGsS12HrDd0hVnp+DprEniVPVs8j+cXFNtqRH5t808RdFxEKOXe2jF5806Me9D1bYTqyLDbyprnWBckJBD39X0ThkVV/nLJK+apogNyPejDo8N07QMBFLc/wE5+9xLcqc3lN301bOPyEg13qpbSwCDp645W/o6HYx0HsK9f967+RRezvja3tuhqg1N/R9w0R8+jT3WE6pcCsBnNjeTHDXHIeHyp4wcmXK+YiYrxqXTB+h8HBZ0fznsMbva9Fi/mwoZuqzfVb+2bZ8sI7Q3Uk0NitA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AN+igvmVyKxyEW5XckRnYRpmalVFhUHDTkan7mORl4Q=;
 b=h19zi8PNDYi1O5pUe1xSNG4axaApbHlEdTwvE2ayfFeJZ70QeI1YReDaHa97tSsbdwtwsb/3csT/KShddigXZp95G2hiPRIluNhNuNfgbR/dsJQMjCBAwh2L5k29TycMXYsBxv55+usbaPcwCmcvEvvupYe9wM1FNoUCKzgNxeuHhu4Kxh+FHm33RiRqfotzeShROttPZwKs2nSDxgUNYTw5rxizhmvzXi93t22PDRevEmP8ZK/k/V8+Kf4sAYt7C32thuOTwxl3XoxydLQ61R3qo5rsyc/Ou2ENnCxm1ZicbJJ5d29lORjUKP9wpK7nkUKImJdHyJx4XWMCtUs9NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AN+igvmVyKxyEW5XckRnYRpmalVFhUHDTkan7mORl4Q=;
 b=SCWNrm4whqP7S3twozsvnHwmhsL4ZXgR3CuBfLVx15wqDOfBC1k+qeC3bG0N2lkqtQronav162qHDgBuWinI7Llg0spy6Tr0zKx7hAFRDfXLi+Da+/R3VSooxGxN6sbzkhAfEDkCuE3tIZtjTeHJHp+auxlTqWvpb6A/xnGaZ24=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MN2PR11MB3919.namprd11.prod.outlook.com (2603:10b6:208:13b::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Fri, 26 Aug
 2022 16:40:50 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 16:40:50 +0000
From:   <Conor.Dooley@microchip.com>
To:     <jmaselbas@kalray.eu>, <linux-kernel@vger.kernel.org>
CC:     <rdunlap@infradead.org>, <bagasdotme@gmail.com>, <corbet@lwn.net>,
        <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v3] Remove duplicated words across the whole documentation
Thread-Topic: [PATCH v3] Remove duplicated words across the whole
 documentation
Thread-Index: AQHYuWnspvheZcHGaEG5DrvO77AQK63BYl8A
Date:   Fri, 26 Aug 2022 16:40:50 +0000
Message-ID: <cccaf53c-9438-0927-b074-c74c47bfb1ec@microchip.com>
References: <20220826143300.6794-1-jmaselbas@kalray.eu>
 <20220826163458.1142-1-jmaselbas@kalray.eu>
In-Reply-To: <20220826163458.1142-1-jmaselbas@kalray.eu>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 49ca924a-a0d3-4dc3-0938-08da8781bc5d
x-ms-traffictypediagnostic: MN2PR11MB3919:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9wOC+DSIDseAyqzOdRi0vsLG2fXe96aQ0NfsKIxl+/hLJxiLID/t8qgKok5MwwlTFifSC6Pim+iFaAEF5WgvoYi4SflafzzaB09CvW4zNRp9NLt1z5yxblkQiXkSFoVO/HGTJkIUAB86lxqM9BeszBUxgAHzNFQWt0t8xqrHb9E9uqgHJ1yXMnIsczvNsHgGvBum9xPgHsbwyniuJEr7O0zH74i2lESVAjOyoGIMOiuhFhuQckxCLhxYdDiRwDFU6dH8sVq7mn/n3Et5H+8m7bCxeRAEdATfPefYORl1IIkJCiiGvXX3FVuTTJvmyomfqoqZKjlaBvH20oJJWXMylqfmOIkXblh2bOQzm6WJwCSqg2JfTtTz7QfEP90LLmpaNWQexID+cFlOxCnzT4MfcnrLWwc8h+Nb7Aug+571pb8rp/sOaCZT0iOIo6P9UwQdJOBBBcQRawy0xZFhMR9sDdmtAOaXlbemTJxMmKz8UrlGcmX8o5MGK9DnWDHshbdmNGE+A9IyK8Ff72kgFOZxHQ1b7VuGPYI6Tnwb1iZykkR0WcsrFOTANfOGCSekWMkl9u2YrgmVENr+wF6jfTHq9OvKDkRAmUNej9+xa7lYy+2wZMZ1zXw8u2a0QUq7LaiBAeZJgutZu4eJz9FelijDi+VIrfIa2s/ppzS8rJyDV9eROkuB63U1IPWWIAe8nAJfBCVpRGE2Oc7hZW2Jq5zFsa60WUNL4XQTpF66hrW+yeaoo1IDeUYdPrP7ibBpykCeKyNSGE+njcVFuUNgn3JHdIoPihsWEj05iwHRzpA6CG8KXtIFgnjkM6ySAnk2o4y44WeVvYVhpu6GE12OC7jm3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(366004)(376002)(346002)(396003)(136003)(38070700005)(6506007)(8676002)(83380400001)(2616005)(26005)(2906002)(53546011)(186003)(6512007)(31696002)(86362001)(66946007)(122000001)(316002)(41300700001)(38100700002)(71200400001)(6486002)(76116006)(478600001)(91956017)(66446008)(110136005)(64756008)(36756003)(31686004)(5660300002)(66476007)(66556008)(54906003)(8936002)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U29FQTREV2xKbktBZGZzNk5UTFhpOUkyNktmOEsrNTRESVFUN25UOTJVS0Vl?=
 =?utf-8?B?cGFoNWRiem5WRmFQb1M4MnFIYk5STGFDcis1dXJsVG5VTW90NHBPZm9rNnls?=
 =?utf-8?B?MkFpT0JldlNaUllJNURnUUgyUTBxQjNsUHJQWHRDdGlhMllITXVPbDQzYkp5?=
 =?utf-8?B?V0wzbzIyQW1zbVhES3lwSE9lb0lwWGNPeWEzNzhQc3hmR3gvMGNvR0FQemlE?=
 =?utf-8?B?Smkwd3RvNmFLLzVMZ3BuMVV6M01DZWFDaXJXSllmcmhjNCt5bWYwWHI5YUxR?=
 =?utf-8?B?YWpHT0dLdkxHTkdTdkh1anA1QUlUK05pSVc5OUhHaFVqYjM2dHpVM2VrYUFT?=
 =?utf-8?B?c2RRcURQMm9zYUN5YjZJdHowMGZRdVk3a1FMSElFZnBxc0VoTmdQZE1YT0Er?=
 =?utf-8?B?Q3ZPdWZKN0JMYlRxRmhzdGV5L1VtK01mM3FLbmVtRHlQZHVXQllndERFdVUx?=
 =?utf-8?B?ZVl2ZVJlUFNGWG1mZmNuV3dKMmttK3BnMHo0ZU9uRElITUY5ZExiMytPM29n?=
 =?utf-8?B?R2Nib1BHU3hxR0ZaNDgxckRReVhpVUtIb0lrRGRDTXdSQnkzSDFvVDN2cVhN?=
 =?utf-8?B?NXBoVUpEb3g2R1IxNEdRb3cwK1lZM1lTS296NDFBMkg3cE1ZaXpUQWFHRG9n?=
 =?utf-8?B?YzVmcFZiV1FDOExpS0Q5cHhlWTZHMnZvbUJQMjg5QzVYR0IyTW90QVVvMnhN?=
 =?utf-8?B?MXpUN0ZWNVJFUTBORGFEWG8vUjFaQ3Zab1EzQXIwbjBWUlp6TXlHUjhMT0Nn?=
 =?utf-8?B?M0lWekdtZyswVTZQL2F2eFNvYUxGbFNsR3ZJelZDNHRjUVFralZLdHNlUnpB?=
 =?utf-8?B?a3hJSUZFam9OTEJ6Ym5xY0tVWU9NTk5BVVpNUU45SHhXTmRyQXIrZS9pTFl2?=
 =?utf-8?B?c2x2bGJuZGVjbFA4NEFxVTllaGRNREd4MzN4aGYrcm5oQXlQSTBRZG1FQWJG?=
 =?utf-8?B?VGZZdlI5cHNieE4wTHRiRnk3bi95SmJRYVFmUTlsSXZZWlphUFpETXJZUjZO?=
 =?utf-8?B?QVVZRWtHZVZvSVRJWkdYbXQwSnJHdEVTQTd3VmNRRlNwS2IyQi9OM3pvcVhi?=
 =?utf-8?B?aERrWW5IYmNhcUZFbk9TdXNjeWtWV0lmc1N0LzRsaU9Kc3dOL0xIVG1vYnR2?=
 =?utf-8?B?YTJDQ1JxVnJvNUI0YWNMVTBraG1jakpQb3N0WW4wWCsxNzJDWjloSlJYVVA1?=
 =?utf-8?B?RkQzTldxSEJTcGhEUHpFalJKSytXK2oyaWNIOFUxN3pjRjRCdFRHT2xtM2xK?=
 =?utf-8?B?RWRpMUg4elFHa21LeVhjRk1tazJISkFuQ3NjWGc4ZmtUalVUSit4ckpnTDJr?=
 =?utf-8?B?aENPM29xVG1UQUVJK2VoYnFwd1dXeG5JcVJjUzdZRnIyMTlqaUxZWjNGbVNo?=
 =?utf-8?B?Wm1kNm9ZTnhUQmhhMEhPV3drOFFZSzBzZ0FFcWdkWWFmVUxOc09meFp2dFJZ?=
 =?utf-8?B?dEk3Vk44aVNHNVdKeE95RUdHS0h2TmJnVVF3cnZYTk1yQlN2cUNhWFg3eTZm?=
 =?utf-8?B?QVhOTXZUTDNqQzBWRTN6b0laTks4bisyRHFEbmRjWXpPUkxzM1VtQXhjNXpM?=
 =?utf-8?B?SXpVUXdIUksyOU9rMXl2NXhjYzhBcXlreE5BUUZ3ZTUrSWlDbFg0VWF4d2lG?=
 =?utf-8?B?aUErbXVKdEp6Y2xmQzVWdTVMa0tKTjlmVm9QTTF3MkV1d1FzTHRtbWljbWpX?=
 =?utf-8?B?NS9ReUtZSmhrcnBFRG9NOGNyK3lncm0wcktiTk5JdUlrYWhZVnI1ZlJWd3d2?=
 =?utf-8?B?em5udFFtbkpiRGhtK0FHc1BSL0srbitENXhvazhUUzBvQytWRVRwcFFMcTg0?=
 =?utf-8?B?OWt6cXRjenhqcUc5SXo5amNPa3l1bDd3cm5nL0NDY2V4WW4zc25KYnpxSkRw?=
 =?utf-8?B?d2lZWkY0SllLSFN5enpyV2FFeXZ5VUp6MTVpZ3Y3VytrN2Q4LzNhT2FFMERh?=
 =?utf-8?B?aU1rUFJvS0ZxMnlrODJBZ3lmSzNsdkZYT2lBWllqcERRYjRpTjNqbWx0Q1ll?=
 =?utf-8?B?VE5Lamw4SWRiaC9xZTlRTUlBY3JaVWNUN3pJRVJQUll0cDAxbzBMSHNSL0Zz?=
 =?utf-8?B?aWxEaVVYcVl4ZU5oTjRKWS9yenlwWFBneWVrN0J5T3JKK29ISkVhcWpXZGlZ?=
 =?utf-8?B?dTdYRkMrK3hJQ1ZaakdwZHgrdlFWTDNBcEplMWZUR29HdkxzUXpES0svemhT?=
 =?utf-8?B?NGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <67ED38C0C9B6734A8BC4BBD4447F14FD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ca924a-a0d3-4dc3-0938-08da8781bc5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2022 16:40:50.6935
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dw5B74X9q0+3X5Lq5RxIBGRW3gxUfbpqRWd2Bg0QGA7ctHNUe6pNAYf8gDf20WpRpwI+YEBgY5CR3hmVckzrYAFZSkCcHE6N+D03QR7Uahk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3919
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IEp1bGVzLA0KT24gMjYvMDgvMjAyMiAxNzozNCwgSnVsZXMgTWFzZWxiYXMgd3JvdGU6DQo+
IFJlbW92ZSBkdXBsaWNhdGVkIHdvcmRzICh0aGUsIGF0LCBiZSAuLi4pIGFjcm9zcyB0aGUgd2hv
bGUgZG9jdW1lbnRhdGlvbi4NCj4gSW4gc29tZSBjYXNlcyB0aGUgZHVwbGljYXRlZCB3b3JkcyBh
cmUgcmVwbGFjZWQgYnkgc29tZXRoaW5nIHRoYXQgbWFrZXMNCj4gbW9yZSBzZW5zZSwgZm9yIGlu
c3RhbmNlOiAiYmUgYmUiIGlzIHJlcGxhY2VkIGJ5ICJjYW4gYmUiIHdoZW4gcG9zc2libGUuDQo+
IA0KPiBUaGVyZSBhcmUgbGlrZWx5IG1vcmUgZHVwbGljYXRlZCB3b3JkcyB0byBiZSBmb3VuZC4N
Cj4gDQo+IENDOiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4NCj4gQ0M6IEJh
Z2FzIFNhbmpheWEgPGJhZ2FzZG90bWVAZ21haWwuY29tPg0KPiBDQzogSm9uYXRoYW4gQ29yYmV0
IDxjb3JiZXRAbHduLm5ldD4NCj4gQ0M6IGxpbnV4LWRvY0B2Z2VyLmtlcm5lbC5vcmcNCj4gU2ln
bmVkLW9mZi1ieTogSnVsZXMgTWFzZWxiYXMgPGptYXNlbGJhc0BrYWxyYXkuZXU+DQo+IC0tLQ0K
DQoNCj4gIA0KPiAgcHJpbnRrX3JiX3N0YXRpYw0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi9hZG1pbi1ndWlkZS9tZWRpYS92aXZpZC5yc3QgYi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRl
L21lZGlhL3ZpdmlkLnJzdA0KPiBpbmRleCA0ZjY4MGRjOTY2MWMuLmE1YTljMDYyYjIzZiAxMDA2
NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9tZWRpYS92aXZpZC5yc3QNCj4g
KysrIGIvRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9tZWRpYS92aXZpZC5yc3QNCj4gQEAgLTM5
Miw3ICszOTIsNyBAQCBXaGljaCBvbmUgaXMgcmV0dXJuZWQgZGVwZW5kcyBvbiB0aGUgY2hvc2Vu
IGNoYW5uZWwsIGVhY2ggbmV4dCB2YWxpZCBjaGFubmVsDQo+ICB3aWxsIGN5Y2xlIHRocm91Z2gg
dGhlIHBvc3NpYmxlIGF1ZGlvIHN1YmNoYW5uZWwgY29tYmluYXRpb25zLiBUaGlzIGFsbG93cw0K
PiAgeW91IHRvIHRlc3QgdGhlIHZhcmlvdXMgY29tYmluYXRpb25zIGJ5IGp1c3Qgc3dpdGNoaW5n
IGNoYW5uZWxzLi4NCj4gIA0KPiAtRmluYWxseSwgZm9yIHRoZXNlIGlucHV0cyB0aGUgdjRsMl90
aW1lY29kZSBzdHJ1Y3QgaXMgZmlsbGVkIGluIGluIHRoZQ0KPiArRmluYWxseSwgZm9yIHRoZXNl
IGlucHV0cyB0aGUgdjRsMl90aW1lY29kZSBzdHJ1Y3QgaXMgZmlsbGVkIGluIHRoZQ0KDQpGWUks
IHRoaXMgZG9lcyBub3QgbG9vayBsaWtlIGEgdHlwby4gSXQgcmVhZHMgYXMgaWYgdGhlIGZpbGxp
bmcgaW4gaGFwcGVucw0KaW4gdGhlIGRlcXVldWVkIHN0cnVjdC4NCg0KPiAgZGVxdWV1ZWQgdjRs
Ml9idWZmZXIgc3RydWN0Lg0KPiAgDQo+ICANCg0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlv
bi92aXJ0L3VtbC91c2VyX21vZGVfbGludXhfaG93dG9fdjIucnN0IGIvRG9jdW1lbnRhdGlvbi92
aXJ0L3VtbC91c2VyX21vZGVfbGludXhfaG93dG9fdjIucnN0DQo+IGluZGV4IGFmMmE5NzQyOTY5
Mi4uY2U2N2EwM2E3YzgwIDEwMDY0NA0KPiAtLS0gYS9Eb2N1bWVudGF0aW9uL3ZpcnQvdW1sL3Vz
ZXJfbW9kZV9saW51eF9ob3d0b192Mi5yc3QNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi92aXJ0L3Vt
bC91c2VyX21vZGVfbGludXhfaG93dG9fdjIucnN0DQo+IEBAIC0xMDkwLDcgKzEwOTAsNyBAQCBi
ZSBmb3JtYXR0ZWQgYXMgcGxhaW4gdGV4dC4NCj4gIA0KPiAgRGV2ZWxvcGluZyBhbHdheXMgZ29l
cyBoYW5kIGluIGhhbmQgd2l0aCBkZWJ1Z2dpbmcuIEZpcnN0IG9mIGFsbCwNCj4gIHlvdSBjYW4g
YWx3YXlzIHJ1biBVTUwgdW5kZXIgZ2RiIGFuZCB0aGVyZSB3aWxsIGJlIGEgd2hvbGUgc2VjdGlv
bg0KPiAtbGF0ZXIgb24gb24gaG93IHRvIGRvIHRoYXQuIFRoYXQsIGhvd2V2ZXIsIGlzIG5vdCB0
aGUgb25seSB3YXkgdG8NCg0KQW5kIG5laXRoZXIgaXMgdGhpcy4gSXQgbWVhbnMgdGhhdCB0aGVy
ZSB3aWxsIGJlIGEgbGF0ZXIgc2VjdGlvbiB0aGF0DQpleHBsYWlucyBob3cgdG8gZG8gaXQuIFBv
c3NpYmx5IHRoZXJlIHNob3VsZCBiZSBzb21lIHB1bmN0dWF0aW9uIGluDQpiZXR3ZWVuIHRob3Vn
aC4NCg0KPiArbGF0ZXIgb24gaG93IHRvIGRvIHRoYXQuIFRoYXQsIGhvd2V2ZXIsIGlzIG5vdCB0
aGUgb25seSB3YXkgdG8NCj4gIGRlYnVnIGEgTGludXgga2VybmVsLiBRdWl0ZSBvZnRlbiBhZGRp
bmcgdHJhY2luZyBzdGF0ZW1lbnRzIGFuZC9vcg0KPiAgdXNpbmcgVU1MIHNwZWNpZmljIGFwcHJv
YWNoZXMgc3VjaCBhcyBwdHJhY2luZyB0aGUgVU1MIGtlcm5lbCBwcm9jZXNzDQo+ICBhcmUgc2ln
bmlmaWNhbnRseSBtb3JlIGluZm9ybWF0aXZlLg0KDQpUaGFua3MsDQpDb25vci4NCg==
