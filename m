Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F164545CF1
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 09:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343730AbiFJHNB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 03:13:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244110AbiFJHMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 03:12:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874A139B8F;
        Fri, 10 Jun 2022 00:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654845171; x=1686381171;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=M7acfPlRqWp5oWhIIpGRA0ACIa77UlizSFfYVdSmYEc=;
  b=uufuBZ45Rg4EE23iePFGixmXdT9O+M2xHi0bpEiFApzkf4sXfR0/uEEw
   BsnZxQskCRkCWCunXRASiTDHkeHBJCnnvFCOh0yu4p6GQkFsdUEgUE9Ap
   LIvIOEtkAwh/gem76JjKzuegDbpShlL2V5qGxBdCcm5dDpa84EQ65+xpv
   xnysTyvHl9mJP1h4zKwzDVPCW1pRxBbqR9hKmk5LpZJHH9i13Q5qVUaf3
   xHW1xW7D4jR8HseJv0L5hki6osiIgXTaXxWSi2s9187DzimfLPV3ELmyE
   /3TJESRU7tCid1Cam5EFIYezKfjTpMXnmbl2O7m2qS12d3VVB6i474Q3a
   A==;
X-IronPort-AV: E=Sophos;i="5.91,288,1647327600"; 
   d="scan'208";a="162750626"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Jun 2022 00:12:49 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 10 Jun 2022 00:12:49 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 10 Jun 2022 00:12:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bsL1ARC7jOoZ+39dfewP1t9nPMPuEORCB7KsPTocxsz/haun5nuYKi7v8SgxmS5KLQtkx8ofWhxme57IYp/ibOyMMmhwvGhtJaY5oSbiCaW71h3duFN9DOGsHnWu+7XcsF9crefhkrDjbXP1eMhickaKySJXCJaNKjFar+4GFuOHV31YwdC/xBh97AhDatswFB1shVZ1b/EyjoJmHLsyoa8tK393OTFWJRSgRjh8Mv+uRGtLbkUs6PS5Iz1F5pNj2vuTBXPZT8Q6QrQO0122/IaIZKeJHXI3+SIBYXmGM0fwu82+gswPdQxHMf48zP0ZQ5xbuCE55+Kj+gulw6h89A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7acfPlRqWp5oWhIIpGRA0ACIa77UlizSFfYVdSmYEc=;
 b=JTL93CRuZ6J3VSrp0YgIXM1VH4OEbzc4sAOVKMMgJSHzu7Dm2lbQPLCDfI9JHNyufCOxgQVUFRqf263Znbi+KJOiy+DdgZhWOstDcJ+ZIZxBY63bzztQ/Bf71CZhe4XLHH8Rsm9aaSrwK/tiQ9eHGexE+ikToKBRgih75Rr3xcabHjySIGFlgS3HW2ftsehVzUlGsvb+4kZYzedJ+mgfwiQ3aMPIjKcoh8o5LALox8xUhWX8zl9EsyufSt4Ip23h9GRUBc/YOSWIudKEvlxmgaFj2IimnspheXSV9DzVzzwA0xKRxYBykhAbmg02CqndQe3MNAsvhxc4hJ1Y3+OoLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7acfPlRqWp5oWhIIpGRA0ACIa77UlizSFfYVdSmYEc=;
 b=oWY6X/wzSlu35EUh2/Wz4DuMqn/BvjbChxPTyXada2akWuu4jqnA4mlCt7TCcHRKu7BzUIkKDNdDkTmekytN/kx/qRB5ealCLlLaNEIDH3lJSV8OepL0tCUplke82+Cp66/AQmi2mnT2fhsB0S/HZgxkUzI8aU1HaCrGx7X2P30=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DM4PR11MB5247.namprd11.prod.outlook.com (2603:10b6:5:38a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Fri, 10 Jun
 2022 07:12:47 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5cfe:8088:aa93:fce8]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5cfe:8088:aa93:fce8%3]) with mapi id 15.20.5332.014; Fri, 10 Jun 2022
 07:12:47 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <arnd@arndb.de>,
        <olof@lixom.net>, <arm@kernel.org>, <soc@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 45/48] ARM: dts: at91: correct gpio-keys properties
Thread-Topic: [PATCH v2 45/48] ARM: dts: at91: correct gpio-keys properties
Thread-Index: AQHYfJl99ttOB77uIEOolnL89aBMOw==
Date:   Fri, 10 Jun 2022 07:12:47 +0000
Message-ID: <44b011f6-6f4b-3816-1042-9a9b1fac3fa7@microchip.com>
References: <20220609113721.379932-1-krzysztof.kozlowski@linaro.org>
 <20220609114047.380793-6-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220609114047.380793-6-krzysztof.kozlowski@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 85d6a8db-8f74-417a-7009-08da4ab09f96
x-ms-traffictypediagnostic: DM4PR11MB5247:EE_
x-microsoft-antispam-prvs: <DM4PR11MB5247CCC4E683C4D4322F59EA87A69@DM4PR11MB5247.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A6BlyJ4PcQ8HGPqMisVSzVxPJOlJUf0ttVu+cAPuZr0sHJWdoTJxKh7b9hwnjbOVZCcqWFhpEVZQRB6WoWsAumQnqru/Kdf5lcZsM52dM4QGJOGwJsgzTjFcWD00k6oUn3dcNs6rbUK6qr1BfhGwDbinNrUKiCj/FsDCMKfRZrLrpmT5yqYkvn2UikoSRMfgbytJSz4SGjkBaf/qygMXuGhTaYgD9ElBXrYo08YK5AcTrEzfywaElJwAEJ6VQZM3xfXAfucchSaKfLDT9mDho5NkKUAEsyohhJunspbSPHDnN+vatQHqNJ+wNueyoNsmwqye6FDkLea2LXC10MmKU02ElpxutcCyxo9A1/afbPwtho/vCDrVXoZjEtKoOfODUFuD2wDaLpc23EDYiHjj8ndWQvFLS9hfN8Cbs9lVM/E1Sv1zdERlRIS8OjWXPOtNTEfMkD1w9CACvnnhny1zyzNdl3EQ99wVvEgF63yZ6IuA9TPayKh+vJ/8YymN4Qm17aaEcOchuHcpj5+8FqCpq5pyR7/W5YTkKdjIEzQ5C3F0jVWzMfhbyv8/na51C5yIlDnw2Fy8XlNAfSVh1eqL7OH9H8GgckuMNY3DEV+HF2q0CskadYE0EyMBj+mFPtrR/QMg30wEbgrbIdNJjv/ks1NuW6a8fphMDZY3au5FbA3Y9ud2OnhP6zDtQ/Qf2u72OG1RRDqSOVaHJc+9ez3ujt526shqaFtw4GKXJbivtUjkh+zniVTzH3OAzNPnSxS7UbyQcC0iL4uX78CpcPMtUQe0JdKvr0XrESDdv1j5SQE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(38100700002)(36756003)(53546011)(2616005)(83380400001)(31686004)(2906002)(316002)(38070700005)(8676002)(122000001)(921005)(66446008)(31696002)(5660300002)(71200400001)(64756008)(6512007)(6506007)(6486002)(508600001)(186003)(66476007)(91956017)(66556008)(76116006)(66946007)(8936002)(26005)(110136005)(7416002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aW85Q1M1dElnVzRTNktsR0pzdjRYdzlDUjg2SjBQWkgxaGJLenozVkhtTjdC?=
 =?utf-8?B?RmxBcUh0c2NhcDU3dDdrS3haeHk4ZVg3UUt0TlVKM3ZYMXBPdVNRWFAvZmhi?=
 =?utf-8?B?dGhuOWh6SmFXOUM4R21ROFJzNVlhMk9TUU1rdVp1dXBFaHBSbGpxbXFxTG1C?=
 =?utf-8?B?Z1kzMmVCVkdjUlh2ZUt3dmpCa0FGSnNMQUJsQ09wbEg1TEdlMDQ4SnF3a0sr?=
 =?utf-8?B?bW4yVWFNUE8xRktpUUNWM1RMNzQvVTJxNUQxcGZ6Nyt0Mm5XWlZxRmFJcmJy?=
 =?utf-8?B?WUlkenNVWXhIRUsxRG9XSEtsZTh2MzNiZFpLeXgyTGJWOEtMVGM3bWZQVjlZ?=
 =?utf-8?B?ak0wL291c1NQTXRsd0JZTGVQY2tOZFoxRFRqTnFsUFJ5YjJ3WUtITEFQMlA1?=
 =?utf-8?B?d2pGWE9QR1VnM3dKblRHTHJCc3N6YUpKRk5ycjMwb0l2YnJHV245RWR5dGhJ?=
 =?utf-8?B?STU4cmtONzZqUGVtYkdTbk81c0wwb3pOTVRmQnNpelRzU1ZEODZiVkRwT0dm?=
 =?utf-8?B?NnM4YTdYejRpSUY3V1VsZEl0QWVHVU1rb2Uzb01WbStTY3VRNTRMc1hyYkEw?=
 =?utf-8?B?S2xXc1NrcG9JU08xVG1maG9ndlZoK2ZuQldxMjVKVWtaV1ZmRFZjaUhFRXV0?=
 =?utf-8?B?SHowMXdEMlBrNnRPT0VZYndydW9HcU1HMlFMOEhYQ3p6Rms3YkxDckFRUW5p?=
 =?utf-8?B?RytOMlFXMlVQNVZMeEV5anRGdGZCcW9IVWJneW1VYWN6ZUxHdGpBKzkxOFIz?=
 =?utf-8?B?YmlwdVNmdWN5YmhuTGY5aHhvcVJadDlwSmZ1UWZKS0NIZ1lscUlSbXhWb1BO?=
 =?utf-8?B?V1pER0oxS1R2MWhHS2JSYUZhOGlOS0hNUXdVV082Z3k2alZ4S1MrSmVuTFNG?=
 =?utf-8?B?dzQvK1VXa1pjazRWU014Tlp2andVZU93N25STjhYenB1aW1MeXB4UjJJZ2hx?=
 =?utf-8?B?UDE5UVdtZUZ3aER4a2hHZkZ3VHc4U1Y3QklIOHZzUHFydHJtbXlYRWYwdHcy?=
 =?utf-8?B?dDVGM0orSTJVMnRqV3VsZllwNkVFNHB3ZVlwY1U5MHNVczN5NnFoYUpmUCtH?=
 =?utf-8?B?aTB6ZW94MUFpbnZOTGdsTnVNOEU5TzFQUkp2MDBPczBTMDdMVnhreThFUlFa?=
 =?utf-8?B?MEYyaTE2QUhTTkNsYXpyR0tWbnBQUDFmZ2FVWVV0aGpyWXVSZWJOaXg4UmJB?=
 =?utf-8?B?ZVNXM1NQcTBYMnFwMlIzR1ZvTS9MbVFteGQyMEMvNFZjYkZtWUswUFZLNzJ0?=
 =?utf-8?B?NjUvUldYQ0FPYS82VWVxc251MG96VlgxYXUxK0xoOEdGeHRnZTVKckY4cDMr?=
 =?utf-8?B?c3IySUttamtQbjNjeDQ1ZHBEVWxZVGt3c2h2eGdrMzI2OUJOT3pmYlBhNHl4?=
 =?utf-8?B?ZXRQR0lvMzVYY3V6aCtYTTVUQUxzMVRmTlIrTk55WSsyazllUG14U0ZXbWZn?=
 =?utf-8?B?RFVBMzZ4QldRcTF5WE5RMm9SQzQ0U0VyVUJTU0kyM0RiZmNNekV1Z2FGbC94?=
 =?utf-8?B?MWRlMkhtQTlnczZ3U3Nva3lsTno4MlJHSHluMGZBKzBLbi8xNnNiYWt0dWJq?=
 =?utf-8?B?RlVCc2RobStZRlJjOWRnTUlWbGZ6Nmh2SjBrdkYrV1BvWWZxWVJGQ1U5R3hS?=
 =?utf-8?B?NCtWYjRhUEhoVHBlcjZXelVIWGJNaVE1eG55SFEwK25GZ2oyK0NIS1daZVpG?=
 =?utf-8?B?RHJTNml5OXV5TEx2TWtYc29PV1dMYmdUTHllcVhGRmNvWnhteWUxNzVWWklT?=
 =?utf-8?B?UHRuL1F2WEpMaGNKL3RUcDZ5aXdiUmRzdk93OW5zVEtFcksvNUpKMUVqeDZM?=
 =?utf-8?B?ZUFYeWlDeTR0N3dPQXZrNUFQWkVuY3A0UGtXNFBjTmxKcUx1MXVlV3NEa3BF?=
 =?utf-8?B?aU0xTDNaYmpodnZOSmpUUVFTZkJqYzBJVmtqUWxQV2xBbmRWenI3ckVzYkVP?=
 =?utf-8?B?dXBQSGtubEFrNTNUa01udklDWWxUYzBKcjVZallKa2pza0h4TjJlYmFPdjBG?=
 =?utf-8?B?NHl3Q0hrcWtjZnF5eEVNekhqelE2blJxQWIrMGQwV3h4SzBSVEZBTTlrM3pY?=
 =?utf-8?B?V2RZUlcrbEhDODBQaTBxUG9oOUlNaE50Q0hiZzBYSjZmWjQ2aktBSE56S1J3?=
 =?utf-8?B?VmRnRjQrUGJ4eElEWWVaRkdJS1BwbEQwbnpOU0pRTlRCQ2YwWFpGN2l4dElX?=
 =?utf-8?B?elcreUk3SjVDUkRKS2VwQ3UxT0JQM01hV2lwZEE1RzREbmZ6Vm9tVkpDTnN0?=
 =?utf-8?B?R293dkh3dGlPdisvUmI0bG5Bb1pHWEhYcXVMMGJaNFN3WndmQkZEQ1B1dmVm?=
 =?utf-8?B?OG03cFd4dFdGSVRGb3JhdDVRL0dZNkdmaDJEZkI0MTEzVjNBQll0OUlpV0No?=
 =?utf-8?Q?N+g/RFYcniqXonDY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16E0F36DE3E5164FA03C462A7DD3DB1E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d6a8db-8f74-417a-7009-08da4ab09f96
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jun 2022 07:12:47.8326
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4TjoyD7PW2eMy4PcZHQnV6WbUGh0KK4XMWlqrMO/FmhpaozUvWsxrOKDhlDUAOv3taiunAGMiiBXJKe/pqEr4863Wx1CTVsHw8/qcUpFIfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5247
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDkuMDYuMjAyMiAxNDo0MCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBncGlvLWtleXMgY2hpbGRyZW4gZG8g
bm90IHVzZSB1bml0IGFkZHJlc3Nlcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtyenlzenRvZiBL
b3psb3dza2kgPGtyenlzenRvZi5rb3psb3dza2lAbGluYXJvLm9yZz4NCg0KUmV2aWV3ZWQtYnk6
IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KDQoNCj4gLS0t
DQo+ICBhcmNoL2FybS9ib290L2R0cy9hdDkxLWtpemJveC5kdHMgICAgICAgICAgICAgfCAyIC0t
DQo+ICBhcmNoL2FybS9ib290L2R0cy9hdDkxLWtpemJveDItY29tbW9uLmR0c2kgICAgfCAyIC0t
DQo+ICBhcmNoL2FybS9ib290L2R0cy9hdDkxLWtpemJveG1pbmktY29tbW9uLmR0c2kgfCAyIC0t
DQo+ICBhcmNoL2FybS9ib290L2R0cy9hdDkxLXFpbF9hOTI2MC5kdHMgICAgICAgICAgfCAyIC0t
DQo+ICBhcmNoL2FybS9ib290L2R0cy9hdDkxLXdiNDVuLmR0cyAgICAgICAgICAgICAgfCA1ICst
LS0tDQo+ICBhcmNoL2FybS9ib290L2R0cy9hdDkxLXdiNTBuLmR0cyAgICAgICAgICAgICAgfCA4
ICsrLS0tLS0tDQo+ICA2IGZpbGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMTggZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1raXpib3gu
ZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1raXpib3guZHRzDQo+IGluZGV4IDg3ZTk3MmVi
MmJhNi4uMzA3NjYzYjRlZWMyIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybS9ib290L2R0cy9hdDkx
LWtpemJveC5kdHMNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1raXpib3guZHRzDQo+
IEBAIC0zMCw4ICszMCw2IEBAIG1haW5feHRhbCB7DQo+IA0KPiAgICAgICAgIGdwaW8ta2V5cyB7
DQo+ICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImdwaW8ta2V5cyI7DQo+IC0gICAgICAg
ICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwxPjsNCj4gLSAgICAgICAgICAgICAgICNzaXplLWNl
bGxzID0gPDA+Ow0KPiANCj4gICAgICAgICAgICAgICAgIGJ1dHRvbi1yZXNldCB7DQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgIGxhYmVsID0gIlBCX1JTVCI7DQo+IGRpZmYgLS1naXQgYS9hcmNo
L2FybS9ib290L2R0cy9hdDkxLWtpemJveDItY29tbW9uLmR0c2kgYi9hcmNoL2FybS9ib290L2R0
cy9hdDkxLWtpemJveDItY29tbW9uLmR0c2kNCj4gaW5kZXggZWQ3MTQ2ZTIzMTQ3Li5lNWUyMWRm
Zjg4MmYgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEta2l6Ym94Mi1jb21t
b24uZHRzaQ0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9hdDkxLWtpemJveDItY29tbW9uLmR0
c2kNCj4gQEAgLTMzLDggKzMzLDYgQEAgbWFpbl94dGFsIHsNCj4gDQo+ICAgICAgICAgZ3Bpby1r
ZXlzIHsNCj4gICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiZ3Bpby1rZXlzIjsNCj4gLSAg
ICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiAtICAgICAgICAgICAgICAgI3Np
emUtY2VsbHMgPSA8MD47DQo+IA0KPiAgICAgICAgICAgICAgICAgYnV0dG9uLXByb2cgew0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICBsYWJlbCA9ICJQQl9QUk9HIjsNCj4gZGlmZiAtLWdpdCBh
L2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEta2l6Ym94bWluaS1jb21tb24uZHRzaSBiL2FyY2gvYXJt
L2Jvb3QvZHRzL2F0OTEta2l6Ym94bWluaS1jb21tb24uZHRzaQ0KPiBpbmRleCA4ZmIwOGU2ZmFk
N2EuLjQyNjQwZmU2YjZkMCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1r
aXpib3htaW5pLWNvbW1vbi5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEta2l6
Ym94bWluaS1jb21tb24uZHRzaQ0KPiBAQCAtMzYsOCArMzYsNiBAQCBhZGNfb3BfY2xrIHsNCj4g
DQo+ICAgICAgICAgZ3Bpb19rZXlzIHsNCj4gICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAi
Z3Bpby1rZXlzIjsNCj4gLSAgICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiAt
ICAgICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+IA0KPiAgICAgICAgICAgICAgICAg
a2V5LXByb2cgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICBsYWJlbCA9ICJQQl9QUk9HIjsN
Cj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtcWlsX2E5MjYwLmR0cyBiL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2F0OTEtcWlsX2E5MjYwLmR0cw0KPiBpbmRleCBkMDliM2QxNWE4Mjgu
LjlkMjZmOTk5NjM0OCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1xaWxf
YTkyNjAuZHRzDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtcWlsX2E5MjYwLmR0cw0K
PiBAQCAtMTk4LDggKzE5OCw2IEBAIHVzZXJfbGVkIHsNCj4gDQo+ICAgICAgICAgZ3Bpb19rZXlz
IHsNCj4gICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiZ3Bpby1rZXlzIjsNCj4gLSAgICAg
ICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiAtICAgICAgICAgICAgICAgI3NpemUt
Y2VsbHMgPSA8MD47DQo+IA0KPiAgICAgICAgICAgICAgICAgYnV0dG9uLXVzZXIgew0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICBsYWJlbCA9ICJ1c2VyX3BiIjsNCj4gZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2F0OTEtd2I0NW4uZHRzIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS13
YjQ1bi5kdHMNCj4gaW5kZXggM2U0NmIyOTQxMmQxLi5lZjczZjcyN2Y3YmQgMTAwNjQ0DQo+IC0t
LSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtd2I0NW4uZHRzDQo+ICsrKyBiL2FyY2gvYXJtL2Jv
b3QvZHRzL2F0OTEtd2I0NW4uZHRzDQo+IEBAIC0xNCwxMSArMTQsOCBAQCAvIHsNCj4gDQo+ICAg
ICAgICAgZ3Bpby1rZXlzIHsNCj4gICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiZ3Bpby1r
ZXlzIjsNCj4gLSAgICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiAtICAgICAg
ICAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+IA0KPiAtICAgICAgICAgICAgICAgaXJxYnRu
QDE4IHsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDE4PjsNCj4gKyAgICAgICAg
ICAgICAgIGJ1dHRvbiB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGxhYmVsID0gIklSUUJU
TiI7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGxpbnV4LGNvZGUgPSA8OTk+Ow0KPiAgICAg
ICAgICAgICAgICAgICAgICAgICBncGlvcyA9IDwmcGlvQiAxOCBHUElPX0FDVElWRV9MT1c+Ow0K
PiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS13YjUwbi5kdHMgYi9hcmNoL2Fy
bS9ib290L2R0cy9hdDkxLXdiNTBuLmR0cw0KPiBpbmRleCBlMjE5NWJkM2U0YjQuLmVjMmJlY2Y2
MTMzYiAxMDA2NDQNCj4gLS0tIGEvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS13YjUwbi5kdHMNCj4g
KysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS13YjUwbi5kdHMNCj4gQEAgLTE1LDE5ICsxNSwx
NSBAQCAvIHsNCj4gDQo+ICAgICAgICAgZ3Bpby1rZXlzIHsNCj4gICAgICAgICAgICAgICAgIGNv
bXBhdGlibGUgPSAiZ3Bpby1rZXlzIjsNCj4gLSAgICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxz
ID0gPDE+Ow0KPiAtICAgICAgICAgICAgICAgI3NpemUtY2VsbHMgPSA8MD47DQo+IA0KPiAtICAg
ICAgICAgICAgICAgYnRuMEAxMCB7DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwx
MD47DQo+ICsgICAgICAgICAgICAgICBidXR0b24tMCB7DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgIGxhYmVsID0gIkJUTkVTQyI7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGxpbnV4LGNv
ZGUgPSA8MT47IC8qIEVTQyBidXR0b24gKi8NCj4gICAgICAgICAgICAgICAgICAgICAgICAgZ3Bp
b3MgPSA8JnBpb0EgMTAgR1BJT19BQ1RJVkVfTE9XPjsNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgd2FrZXVwLXNvdXJjZTsNCj4gICAgICAgICAgICAgICAgIH07DQo+IA0KPiAtICAgICAgICAg
ICAgICAgaXJxYnRuQDMxIHsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDMxPjsN
Cj4gKyAgICAgICAgICAgICAgIGJ1dHRvbi0xIHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
bGFiZWwgPSAiSVJRQlROIjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgbGludXgsY29kZSA9
IDw5OT47IC8qIFN5c1JlcSBidXR0b24gKi8NCj4gICAgICAgICAgICAgICAgICAgICAgICAgZ3Bp
b3MgPSA8JnBpb0UgMzEgR1BJT19BQ1RJVkVfTE9XPjsNCj4gLS0NCj4gMi4zNC4xDQo+IA0KDQo=
