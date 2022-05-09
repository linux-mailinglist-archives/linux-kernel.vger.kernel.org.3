Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B9F51F487
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbiEIGbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 02:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbiEIGbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:31:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49335147584;
        Sun,  8 May 2022 23:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652077636; x=1683613636;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=3Z0W/+S5x/3Dicy6R3WSjV3nthBQK30JFWlQ2JOo85A=;
  b=2O+eIapU55ibfAypknbmThN4TTdcUbsl+n8InAsYSAFIL4EVwah4+Ni8
   qPorYZds8Uv7ZBhLP5WQ2e3ArMTHoS7kE9MhhfDyI6b+eLIZqCJlTEzw7
   oCIKO3447EFqloIxUt/7LcM9rFESsvH5amWcye6IzjRFW5H09gg5DZTTP
   mZERtk0ezToz3B7XMFH7DOcSR9Po2olOIP9MC50vyejnugvq/T3duTD6o
   0wh3jpF5jO8tWEM71OYlGj5Gg+GjJbIIVefPZwOSBQxauZUEzimIUxGn4
   hZi74slZBq/8/+YdEbEfXyPflQLi0vgoaHV97Rl10AVMXguEbjwVWMOnD
   g==;
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="155245158"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 May 2022 23:26:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 8 May 2022 23:26:45 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Sun, 8 May 2022 23:26:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D3CFLKQt13tHANH5fhoKJMNHgxmasILWjFoC7d18hHfMzaD8WC7CGXZVLpMJ3uT4kroA1/Z9Uki1wwKjde8j2Z8pJK/IXj46JD7jxd8x3+3uJeDFsCxj+6WD0JBdWzMHBdAy3OHaEEwcoHa8r28ZxJifHntjUke8VVkLaoNpARCD91AxR8C41EtoArH67Bt2FJomp4fVgPNdh1MKk/Bf0u9rK1u/Xqhc/DdZCTbkFqMiFCLaowF0BajH759A0/PtCSLw229xa+3CL3ci64mw4jb+ZmB0VshuzysW+OX05ZixbiymGx9UUrbu6ERC0QaVc4t6tixNjJ7S7CsJBSTmdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Z0W/+S5x/3Dicy6R3WSjV3nthBQK30JFWlQ2JOo85A=;
 b=N5zYukpmfBH5jw+22aAE/TEm+GeQ8YP3E5wdZVxmax5w6cpVtyl6gxZKdrPV9cOQ7KlJW1gjZ+M9XXDZoPuvzpzrDYdZv89ljA+7DVupkJ4iqyG790mC52TQxWX57Zov4/bxRzGV+Y0ggRShQEyjs93+pFN3gn8ieHhc/rtl/G5gyT5pQamAuOdvCsUo+/YUNNznPDou1pBMj3SGL7OU3F1oBco1BR0Fwebyi5JI+qVWUEPiOlmnqID6XJNOIwTZWu2ffpszWMnvgJhiwez873BhKdp1kid72izqMK7vL+5lagHpO2d7NhZt4xBxjb7eIrMzYH2uq1hcIHFyvoSuOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Z0W/+S5x/3Dicy6R3WSjV3nthBQK30JFWlQ2JOo85A=;
 b=CsE/KealkWXALulVTIyg7NFxSkznmhh0M0vqhOoGKcMAOwWDCKc94SmiryirhY7xEiA0RSlBIp9v5WH3BszoMwSCWEEirTgYFuGsQKfogW8zAAuKIFVSnd1Nf9BaYsP0NJKn/1yBP0VPbd+iwwsOx+dS6+ZI+bHXu8yTeGyoh3Q=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:95::10)
 by DM6PR11MB4121.namprd11.prod.outlook.com (2603:10b6:5:199::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 06:26:35 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::e906:3e8d:4741:c0f0]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::e906:3e8d:4741:c0f0%6]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 06:26:35 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <michael@walle.cc>, <Kavyasree.Kotagiri@microchip.com>,
        <Nicolas.Ferre@microchip.com>
CC:     <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <alexandre.belloni@bootlin.com>, <Tudor.Ambarus@microchip.com>,
        <Horatiu.Vultur@microchip.com>
Subject: Re: [PATCH v4 10/13] ARM: dts: lan966x: add reset switch reset node
Thread-Topic: [PATCH v4 10/13] ARM: dts: lan966x: add reset switch reset node
Thread-Index: AQHYY2279sLqcy0wjkG/8bWYNuleKw==
Date:   Mon, 9 May 2022 06:26:35 +0000
Message-ID: <642fa722-70d8-edcd-85c4-0ad9cc284fcd@microchip.com>
References: <20220502224127.2604333-1-michael@walle.cc>
 <20220502224127.2604333-11-michael@walle.cc>
In-Reply-To: <20220502224127.2604333-11-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 09afc030-cf4c-4065-c664-08da3184dda5
x-ms-traffictypediagnostic: DM6PR11MB4121:EE_
x-microsoft-antispam-prvs: <DM6PR11MB412141AE562AC973F9C9A0E987C69@DM6PR11MB4121.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +E5Hfo9FRsahuNWvdrzhjy0xq/wD7HX7wi6QXlPDvzTUS+kHWb/RMRl7tdZ6bv1FByGEAeco7CiAUfDHSM22rEO3D/EH6lTvVmLdcUa2ZUT402/HGgE9szyPy6kNo+dDaCCW4aTHvWlaPG3hdYrfp0NJzQwSDP4PyqLs4si4ZmZ74GWcG3p4DDhUONCBGsZs5ZIepImIsxaWWU0x8WTL5yYRBeAkhX1c1bV5iX8uk4r/fjT5KOVaPz6CEh2seAnY53sVWxYwHed/XlTbwPJLLsLfKByv5LywhYpAyBfEfMZLhu47bCnBRCKVlKtLZhp5Maow1w8jHHtQe6a0APsYRmFAZ6wpGVKVqqZa2aP33cXHMS3yrKDWsbzmXjaM0xUsed20IaJ90LVk4Ca655t8fgXzxjQm49hQ/QUbJvwvrxus4n0THysVESkiC4TzTkZY/iWhO8md+Gn+ouoWBKYMonvC+Pm7gJw9EZAHE/OtwAH4+nEKLjrq3ohDb8+1XJU24xDM6uVDZLuxTlAiJml1L/CfW7NdZsRKtSklXX+TJlIu1e1TB4FilmKJkvKIgD+6/XKieHC1QsFT9tjqzFhQXeHLUqojSk2eObKOjzq8w/Upmk9zDjrpA1shc5pjZsFcNKcFjOPb+I7OhKWTr906f4Bv49zLmZxY88c60myEj0cv2wee9bSuRnVCoiBxBuSYTeJG2RIV0JW3sVdzpZXiQjd6Fmom0DqfOL5rhCnUtSo3lm8zo5aOw6YLqZt3ucy0O40tSqvEJ0EpXuH9D5FjNg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(7416002)(36756003)(2616005)(107886003)(5660300002)(110136005)(4326008)(6506007)(186003)(53546011)(26005)(31686004)(66446008)(66476007)(6636002)(66946007)(76116006)(8676002)(54906003)(64756008)(2906002)(66556008)(91956017)(38070700005)(71200400001)(122000001)(8936002)(83380400001)(6486002)(38100700002)(31696002)(86362001)(316002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OTlQVmsreEdYdTdDUEJWU1c1NmEyZkdXQy9HWUtxOFVLQ2NLN0dvMHlOQ1JH?=
 =?utf-8?B?K05YUEIrN1FOSG9qRmdPeUU1cUhtWWM5TFJ3QmVCeUdaM3VhOVdvQjIxMnBa?=
 =?utf-8?B?RHFPT1kra3AyM1lwT2d2anVKM0N5Zkhrc2loZGpIcG5jVUVqSFpJeWFsazhi?=
 =?utf-8?B?NHNaNFR0YlNONjdrQzZ1Nnc1TUtZTXRvZllBTjNsWDlkcG1mTmxVcVJZQ08w?=
 =?utf-8?B?eldDNG1OM3JSTnB5Mld2U21hTmJaYVdQMnljQWRMMmc0RnJFQXQxbWN6M3dx?=
 =?utf-8?B?ZktDc0VNbHpnZTJRRnZudnZhc3Z6UFFGSXdrRnQyMlJlYThoWkkwQVZUZDNE?=
 =?utf-8?B?RUpvY3VBOGtZMWVDOFIyQmd3bFN3QmJhSk95cmlEM0cwbEpxQkJxQVc1TkhO?=
 =?utf-8?B?emMxTk45cElCR25ZRmRITHBHaG92RjJPVlBLMVg3VjF6TFd5dytIYUt2b1Ft?=
 =?utf-8?B?QTNJOW9wWURXblltZlpWdU1uYlovMjZJYUNybEEwWnZ6cTJYeWpUZjdFTStY?=
 =?utf-8?B?eW4rakNSbm1zeUtDcXhKVEFTczc3MEo2UWc1M2dDTEtMdEp2VjYvYnMrdnZP?=
 =?utf-8?B?QmFNUkNYV2RjWlAwOW85NXhITCtNN24vdVI0SzNuYVNjSzB0Uk1KMXh6TXp2?=
 =?utf-8?B?UUZZTHVvV1FCWXp6RzhqdHJWdng3YkNjY09GSEVIamNwNmRkSHpYTmkrNXdO?=
 =?utf-8?B?UFFka1lkV1puVFNlUHFnQW84ajlDWi9FQzFoNi9mVGY1K3FSME9Nb20vNlFO?=
 =?utf-8?B?RHF6T09XdjdoTzhEMzBRTXpTclBMQ0hHU09SUzZQL1haVFkvZ2lhYWFIQ05D?=
 =?utf-8?B?b3V4T0tWNjgrM2tGVUt2TjQvNk5lRFVodU1uK2t4RnpJeEJpZ1htaFg0cVVj?=
 =?utf-8?B?UlpIMXMvL3RNa28zUW4xR25YdTdqc2JKcURvK3NXYlRpVnJId01vNU80cGNM?=
 =?utf-8?B?dFZiNlFwM1lPR2pMeHFqZVg3Rm5CNkdDOFNPcWxib25HZlpuZHgyV0lra0I0?=
 =?utf-8?B?Z2wzaW45a3JtMDY3cjVaM1BiSU5IR29PbE5xU1M0THFNdzZnVXdrQi9pWlU4?=
 =?utf-8?B?dnI0Z0g5Wml2ZDN1REhYcW9zOEdTakNBZ01IWFZZYlJsT2hBSjR5RkoxMW5O?=
 =?utf-8?B?c1l1SWZCdTJYYnE0WjVUYm9lQW9KRHhwR3A3alFUVzExWjdDTU0zdnZLbXhP?=
 =?utf-8?B?VEEvQzBIOE1OSkxSc0V2a1g1VWVSelRiMUhHODdMR2l0M1U2Vk04V3dXR1JH?=
 =?utf-8?B?ZVNHa244OVFmQ0E5R25RTWxLOWxJT2F4TjRsNndRczA2RHN6ajJZSW1QR01q?=
 =?utf-8?B?ZjNSNmdHeGpPSGlCQ3BaeC9KbnVMK3p0TjFGNSszSWRGSGYyS0EyY2ZOYmVl?=
 =?utf-8?B?RFU4L1BsOVYvYjc2ZThOWVhuV2hjQjl3TDhBc0xXYmxZd1h6VEt0dm9TYndn?=
 =?utf-8?B?ekk3Y0lYR2VnMCtEYzhrbGN0bU1ia1VJVlJVcDRaVFUxenB4WFNvZm1HZzU5?=
 =?utf-8?B?SU9Fc1k5NnB1U0NRcWEydFRXTDZ3dllmVm5SQVNvL0FVRVVhRGNhT2JxcW4z?=
 =?utf-8?B?MURXQkVIL0JWMzY3dTEvbXViNDNoT1czcklMblJTd1VVcm43WUpoK2NzUDY4?=
 =?utf-8?B?Z3ljbGxERUZaNTdTcnNOUmtnUzdVV0R1TnlUdDBxbDNKYXFBQ0xkMHRtcFRn?=
 =?utf-8?B?NDVzSG5HbGZ1WDh4V3VRSVhhRnMxUGdVRHJrN2JMWDFiYUxiM0dQalFibHR5?=
 =?utf-8?B?ZkNWNy9JN3F1ODU1TnpZN1pOdlNqNWVwUUw3MzRJTGsxQXRNcUpxMXBLNXhZ?=
 =?utf-8?B?UU5LTjJ1cmxvWHZaZ2J6RXZ5S2ZYYnBBOUtQYkVxL09lV21UN3pWbTg1ZnUv?=
 =?utf-8?B?L0RNamhzR3orZ3NZL1h1SDlMYkMzaktrUnFENDE0QTgvdnZkZHhLK05yMjB0?=
 =?utf-8?B?WXpTcDZFMmRGbnB2NTkxWVVkTElnc2tZTVRPYWQ2aFBqdW1LK0Irbk96RHJH?=
 =?utf-8?B?aTl3Y2p5UUhDUTZsU3NPUDd2MVVlQkxEMXg5OHQzWDFLeksyMGFKa3hWMVMw?=
 =?utf-8?B?UWVDa2RKT1g3cXhpSUhTMmpQVGRsOXFheitlL1BqN0ZjMGdwN091cGtBV3ZB?=
 =?utf-8?B?Zk01VGUrTHZyMk1RYkVrOG1DVDdvTFE3MkxNb3VBeUkyblcyVWJic1grMGdY?=
 =?utf-8?B?Q2djRjdXVXRXbllybTlka3lwREdlN1dkeCtCRkVGc0dYYTJjc29aV1J4STdH?=
 =?utf-8?B?eXdwWGNSOFBNS3BIRmJzb0tsOHBPdHdlZ0hwZ21VWkNwN213M0t1bVNVNi9z?=
 =?utf-8?B?UHB2bTYyanFvdGZ3dFZGVFJORno1MnU1N2JTWXZkZkJNeHNGalhHcEJmbWhL?=
 =?utf-8?Q?FxFkvKDds8EBFypQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F31F1636FF625C499A4E65D60C65A179@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09afc030-cf4c-4065-c664-08da3184dda5
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 06:26:35.0263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rnebc7WG5YuuuyiNrpghtX4J/r+dQ6lgw4K9V9QGFRWn1g2tn1tNqfOgtSVgTl/N6MQ1I73r/moJ7awdlconMSNwsktpy6jZAN2EHYIX9rw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4121
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDMuMDUuMjAyMiAwMTo0MSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBZGQgdGhlIHN3aXRjaCByZXNldCBub2RlIHdo
aWNoIHdpbGwgbGF0ZXIgYmUgdXNlZCBieSB0aGUgc3dpdGNoIGRyaXZlci4NCj4gVGhlIHN3aXRj
aCByZXNldCBhbHNvIHJlc2V0cyB0aGUgR1BJTyBjb250cm9sbGVyIGFuZCB0aGUgU0dQSU8NCj4g
Y29udHJvbGxlciwgdGh1cyBpdCBhbHNvIGhhcyB0byBiZSBjb25uZWN0ZWN0ZWQgdG8gdGhlc2Ug
bm9kZXMuIFRoaXMgd2F5DQo+IHRoZSByZXNldCB3aWxsIG9ubHkgaXNzdWVkIG9uY2UgZm9yIHRo
ZSBmaXJzdCBkZXZpY2UgcmVxdWVzdGluZyB0aGUNCj4gcmVzZXQuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBNaWNoYWVsIFdhbGxlIDxtaWNoYWVsQHdhbGxlLmNjPg0KDQpSZXZpZXdlZC1ieTogQ2xh
dWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQoNCg0KPiAtLS0NCj4g
IGFyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2NnguZHRzaSB8IDE3ICsrKysrKysrKysrKysrKysrDQo+
ICAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2xhbjk2NnguZHRzaSBiL2FyY2gvYXJtL2Jvb3QvZHRzL2xhbjk2Nngu
ZHRzaQ0KPiBpbmRleCAwNDQyNzM1OTEwZGEuLjcwMjBiMzEzMjJkOCAxMDA2NDQNCj4gLS0tIGEv
YXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpDQo+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRz
L2xhbjk2NnguZHRzaQ0KPiBAQCAtMzkxLDYgKzM5MSwxMSBAQCB3YXRjaGRvZzogd2F0Y2hkb2dA
ZTAwOTAwMDAgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICBzdGF0dXMgPSAiZGlzYWJsZWQi
Ow0KPiAgICAgICAgICAgICAgICAgfTsNCj4gDQo+ICsgICAgICAgICAgICAgICBjcHVfY3RybDog
c3lzY29uQGUwMGMwMDAwIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9
ICJtaWNyb2NoaXAsbGFuOTY2eC1jcHUtc3lzY29uIiwgInN5c2NvbiI7DQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgIHJlZyA9IDwweGUwMGMwMDAwIDB4MzUwPjsNCj4gKyAgICAgICAgICAgICAg
IH07DQo+ICsNCj4gICAgICAgICAgICAgICAgIGNhbjA6IGNhbkBlMDgxYzAwMCB7DQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAiYm9zY2gsbV9jYW4iOw0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICByZWcgPSA8MHhlMDgxYzAwMCAweGZjPiwgPDB4MDAxMDAwMDAgMHg0
MDAwPjsNCj4gQEAgLTQwNiwxMCArNDExLDIwIEBAIGNhbjA6IGNhbkBlMDgxYzAwMCB7DQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgIHN0YXR1cyA9ICJkaXNhYmxlZCI7DQo+ICAgICAgICAgICAg
ICAgICB9Ow0KPiANCj4gKyAgICAgICAgICAgICAgIHJlc2V0OiByZXNldC1jb250cm9sbGVyQGUy
MDA0MDBjIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJtaWNyb2No
aXAsbGFuOTY2eC1zd2l0Y2gtcmVzZXQiOw0KPiArICAgICAgICAgICAgICAgICAgICAgICByZWcg
PSA8MHhlMjAwNDAwYyAweDQ+Ow0KPiArICAgICAgICAgICAgICAgICAgICAgICByZWctbmFtZXMg
PSAiZ2NiIjsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgI3Jlc2V0LWNlbGxzID0gPDE+Ow0K
PiArICAgICAgICAgICAgICAgICAgICAgICBjcHUtc3lzY29uID0gPCZjcHVfY3RybD47DQo+ICsg
ICAgICAgICAgICAgICB9Ow0KPiArDQo+ICAgICAgICAgICAgICAgICBncGlvOiBwaW5jdHJsQGUy
MDA0MDY0IHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJtaWNyb2No
aXAsbGFuOTY2eC1waW5jdHJsIjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4
ZTIwMDQwNjQgMHhiND4sDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8MHhlMjAxMDAy
NCAweDEzOD47DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJlc2V0cyA9IDwmcmVzZXQgMD47
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJlc2V0LW5hbWVzID0gInN3aXRjaCI7DQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgIGdwaW8tY29udHJvbGxlcjsNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgI2dwaW8tY2VsbHMgPSA8Mj47DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGdw
aW8tcmFuZ2VzID0gPCZncGlvIDAgMCA3OD47DQo+IEBAIC00NTMsNiArNDY4LDggQEAgc2dwaW86
IGdwaW9AZTIwMDQxOTAgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0g
Im1pY3JvY2hpcCxzcGFyeDUtc2dwaW8iOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICByZWcg
PSA8MHhlMjAwNDE5MCAweDExOD47DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGNsb2NrcyA9
IDwmc3lzX2Nsaz47DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJlc2V0cyA9IDwmcmVzZXQg
MD47DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJlc2V0LW5hbWVzID0gInN3aXRjaCI7DQo+
ICAgICAgICAgICAgICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwwPjsNCj4gICAgICAgICAgICAgICAgICAg
ICAgICAgc3RhdHVzID0gImRpc2FibGVkIjsNCj4gLS0NCj4gMi4zMC4yDQo+IA0KDQo=
