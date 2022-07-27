Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3315820F1
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 09:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiG0HTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 03:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiG0HTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 03:19:49 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7A532DBF;
        Wed, 27 Jul 2022 00:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658906388; x=1690442388;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rTBt5N9MnHd5XeKra8KFD44Hyo7pw7KRLjsxQYVl4jE=;
  b=KXYmzoixOgkjeK208s1JygPCXjY+W47kieHUbu6ufV/CqymOo/7r3Gzn
   5xu1/xcCzQM/FZddvtp5g73JrYZOd3znAPcR+lyzUTx0Iir5LE7Rv+C/W
   nUaTuqqilS+abcu07iUgBiWjxWBA5WGWbFLqgLNMHnyPGC7BMehw3XXOw
   C3xVMx6eOxwZb0KmO+ipMr0zuG0OEGFiAZjfYTf3SR5cJEnLp3fb5x0dB
   78qiuTyZIwbry0pHNRe9xqaHKV+xSrFxSlgd/Gi7aQWnudPKfRaZYWdeR
   uWUkFmSjd+3SP/vdCHLfDOS9bhyhsTrbdlOFpHwF2RE6Q4/VCfnUStDxd
   w==;
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="106313205"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Jul 2022 00:19:46 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Wed, 27 Jul 2022 00:19:46 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Wed, 27 Jul 2022 00:19:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OR1IbJAPLGUkLwjrjcw1/cvgV3ZY9XFVkvSBhB6lbmcLPCaa+YK0V7Oe+VC4NbFXNlYfobsPKd7ZiihWqSsLFzFdHu2Co4IAkddLFMUZDr1W3awSJMBV2xIXmEwcuZ8zakrNmbFOu4R8uJww4dIHW6KH7TFixnahZ89fRdKaBcz068wekuJtNGRznJgJXdEe/z+IxdqHogQLZiWHUk6tC9qc02xeiFjqgVXNeKuHV514cSW+jgSrTwBmk2jaeiq5uelYxZ+4O7jMMsdGcryF+NSJI25wkWO52OtzwR6tHuT+VID2jXcpPzbVOjYuR+NtCnq4ygD61IY6EIa+0Epdhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rTBt5N9MnHd5XeKra8KFD44Hyo7pw7KRLjsxQYVl4jE=;
 b=XOX9yp2o+RFFwRoPlo6WuRHGIzs0vu1wQM2O6xq2d5Os8Cf5MJwtDdy1rj0M8f2aQ4Lp7l6dh5K7I7WvAQ611aXIREdsN5uKhve5rrg0EOlamZE8vII497MRNSKSgU7Ug8qENdw5ubdnKcAYrAztU2u+JS0KPPyaVv49+1FJMPu1B05RTv0YLJApnc4+I1GzjhBSMmumMjnywWZ7w/NtkYxmBIFxlg5yRAA9u/Jm2Wsn9vtFMejKOcOuy0N4eVsGjl0OUT8dt82phnstufJ+SAtDnm2DZpa0ms64PsY69KyP1sGlp9Ab0HLK2qY7GgVAjnUvQsP/ybk+O869QRbCFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rTBt5N9MnHd5XeKra8KFD44Hyo7pw7KRLjsxQYVl4jE=;
 b=JI8NfzrUrPgrpvBcAHZd+GY+8YIOdMLsa4F0pHNJgUFbgx9R89oir88B3VHjLP5aWbdU0kwp3g/EWYwTHc+Cp6zTtne3xV4hoq8AoHLmLw1jUlCaUS3A4pQ8etsU9ZqVZIDkI6tpa9grUib+tcdIvOyo1CqPzwrFe8GnXltuG4A=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SN7PR11MB6703.namprd11.prod.outlook.com (2603:10b6:806:268::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Wed, 27 Jul
 2022 07:19:35 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%7]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 07:19:35 +0000
From:   <Conor.Dooley@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <linus.walleij@linaro.org>,
        <brgl@bgdev.pl>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <atulkhare@rivosinc.com>, <sagar.kadam@sifive.com>
CC:     <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] dt-bindings: sifive: add cache-set value of 2048
Thread-Topic: [PATCH v3 1/2] dt-bindings: sifive: add cache-set value of 2048
Thread-Index: AQHYoRJORxZFGGFwkky2Nc2hNdByz62Q6giAgAABE4CAAOOSAIAAAcEA
Date:   Wed, 27 Jul 2022 07:19:35 +0000
Message-ID: <a530d8c8-7dcb-9cc0-2be3-16567e1a99bc@microchip.com>
References: <20220726170725.3245278-1-mail@conchuod.ie>
 <20220726170725.3245278-2-mail@conchuod.ie>
 <246f132a-a23d-7c53-38a7-2bcec50d65e5@linaro.org>
 <c77f34aa-ff29-b18a-a3a7-9d90145364a8@microchip.com>
 <bf470847-9e96-fc5e-0b82-d05068aaeb47@linaro.org>
In-Reply-To: <bf470847-9e96-fc5e-0b82-d05068aaeb47@linaro.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aceb0f2b-b88b-4078-91d7-08da6fa05be3
x-ms-traffictypediagnostic: SN7PR11MB6703:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IY6YgU0jgpjTI4fglTL2iUUass1SZ3SfjTuZYLSDFZ2UVVMpH1NZ3OBx+Cuywm2DKHfbg/WzcLWCxNczbtoGOm95hKu5S4g1NUvSVEmkmU7oi97eGNdxdyHBhEyMwjWrJuHfx0tpuNzDn/q1mFgbegmUBNIAMaAcD3p10MMFg2So0R6RuecUP7pTPWRgxE/HBcU+KXrOnwQ9cDDFlBMeAaFfMdm0/SNzsHkpp8N1JssxxISNK6KVZWTiq+ewdFyg/adjDtShhRoBYD9L+CybVpQsbcixZoKTnEyPSFrKvuyGlKze89DeNYboJINgHkNRGrUn9Gu2YWQgXpue68ogbIKhbnV+WT66XA17BaYVVsO5gg226OnX0pobdQPm0R2RES4FPEbwjxylTI+H0WWtYUx86CN0o8yirEHvTlc1IedvRbX3ERdx7b7FspBa1ym3fLyhNE4cEQl0xX3Pct4f6PPmV2+rnv8mfPnswtzBXVZOJrf3CRzkTJE+WU9XZk+uYpHA5c6Ch62cllJWSV8kRX3NVCKMeGc/1VzKtmX77AuC0g83MGNSnPEn7IuMBNZvspxqwjStBT3UAbtg/iG2FpNw0mPNKV4gKnH+UyVhUbPYbpS3doiR5rNNcdTlJN2X6JU95Hcahu27TCIE05DtJ7UIJ1/TbFdVgwwkr2hnVotavGVU+lF9t5A7fimkxXzb81PWuFcpHUMx1re5RgVcQX+fr3NmJ4aXRdoElW8GEOoG/Xyx78BIbO9gWCfR0XjMBJXlXnoSKBFZp0F46AmWlgQGLSuI3r38iqZyRbwr6oRYbT04EsjRvQXw2RKkLn4ZZZxF5MC3xenaU8wmpCL2ssYg942oR50dhlwPiY3kJmP9QOzpvYRUjWanTwNj1mBOhLHKOHFm0ucQD1z2D/PvWjM6X9imhstSfel2NZ8Ge08=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(346002)(366004)(39860400002)(136003)(2616005)(26005)(53546011)(6506007)(6512007)(186003)(36756003)(31686004)(83380400001)(7416002)(8936002)(2906002)(41300700001)(122000001)(6486002)(66946007)(38070700005)(316002)(31696002)(38100700002)(966005)(86362001)(66556008)(71200400001)(110136005)(5660300002)(478600001)(8676002)(66446008)(64756008)(91956017)(4326008)(76116006)(921005)(54906003)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVRiZ0JJWDRGY0NDQTVGNTJvZDl4Z1Q5R1llY0p4Z244cHpMNnp4OHdZek9v?=
 =?utf-8?B?Y0dxdHgwYTVOM1dWSi9Yd1o5WnllangvalRQalB0WXBuamtDc0RtMTJjcE43?=
 =?utf-8?B?U2t4YVF4cXJTTkJWTjJUMHlQaUFlWlB3L2RRTmtFczFwMUpORzEzS3EreGJT?=
 =?utf-8?B?ZFVFLy9EeXA3MGNuQVhtZ1MvVnNibkpLMDI2dk54Qzg3MzZGaG94a2wxMEYr?=
 =?utf-8?B?RFYrakNwaXRmZlVEdWUycU05dktneU9YbkZBcThPclgrS3BWbHdqQndVUEV4?=
 =?utf-8?B?bm10ZC9xWXNWM2tHUWtaUFlJdmUzTThiNFNlR2dTM0JlVlZvcjNiRnR3Y3or?=
 =?utf-8?B?bW1KMDNwYVhKYUJWdlFaMDRJMkg5bXVud0t6dm51OXpsdGxDYTkxYmx1QXZr?=
 =?utf-8?B?YlBadkl2dktzbUhXQXpsYnE4TnNUa0RHSzhQRWljTkwyM2FEUXUvQm8vclNE?=
 =?utf-8?B?end1Y1ZtYjgrTlpwdURZeWMxT0tqbURQOTBPd1NySDNTS2dHMzRaMU5ySFBv?=
 =?utf-8?B?amN6RStneloyT3g5N0NNT3ZLSXBhTExMM3I0VUlyclZ1WjNaV1FxNzFRN2hX?=
 =?utf-8?B?djR0eE1Ca3V2dEh5eGxMV1BpcEdjejZLV2trMHc3Zmh3VE9wK2NuSkVrQU85?=
 =?utf-8?B?VkZSTVUxbkhoYUUybkQvQjVkcFVrS1RsV2JpS3VIbmNZcnBmZEthNHlRbnJw?=
 =?utf-8?B?WXJobVdDODNzS1FWS051a3NaZVdyRXNpNm8yZHVEWWlHY2V4Wm9JaWhGdlBG?=
 =?utf-8?B?RFJ2eTJ0bmgwRkVzRXpnaFk3NXBvd1E1NWErOU5GNU9QaDJTbXhhV24yV0pL?=
 =?utf-8?B?eE5YM01Zb0lLOSsxbkxUSG5WekRYZjFDNVJFUFBrbHB6bDFGcEI5NkFkVDlC?=
 =?utf-8?B?TUlVZGNOYnc4RERDM1RvZlM3Mlg3VHFXRk5KcndmVmg3NGxWTFVrZUxBTURQ?=
 =?utf-8?B?bklVeCtuNExnU2FRZmc3MkQxMmV1MnFsVU9PbC9Dc2hiV1lnemhGNVZoUzgx?=
 =?utf-8?B?T2pNTXJZS3lEaG5ockxyMm55KzM1ajE3cEZUZStYcXB0L0t6MlMzRHN0b3pr?=
 =?utf-8?B?WG50VmxYdEYxS1UrZ1crdTlUYmx3enliODJmZTFFdGErcDRPQTZmdGk1L1hX?=
 =?utf-8?B?b0pVM3dBNTRScnJLVmNuSlFHY1V6VW10c04vRXJ1TmtYNGFlRGlCdy9YdXhH?=
 =?utf-8?B?dG5DQ1MyOER4UUQ3ZzhHRlBmYW9tT1lLeXFVbXZLUmExL3pMeDhvcVU1ejd0?=
 =?utf-8?B?VUlTYWgxM1FGUmc2K2JJanY5OEhOOS9WNTloSzRmUGw4MDZrQU5ScTNvNEFz?=
 =?utf-8?B?d0tBN1EwUUVHVVM3RUgwQXhlZWVXUGFNL1hqcXNQSFNrSXF1NzRrcFRIbEdV?=
 =?utf-8?B?RmE4amJSSG56czdiRTZPZSttcktLT3ZsZlYweXhwd210S29ZVy9KT2tRV1BL?=
 =?utf-8?B?WkhUZWNMQjd5QVk3WFBZR21MUjlLR3pGQTB4amtXYW9LcXRIWjA0Nm80dzZj?=
 =?utf-8?B?dzVKbG43NWFUc09wY0YxeURFZ2hLM04zYStkMWZJUE5RYVdibE1YeEdBZWsz?=
 =?utf-8?B?WVB4NTk1U3gzNjRyd29hckh5ZUVuK3FGZFBkMXZUYURrSXpYQWozV0I4TXpQ?=
 =?utf-8?B?eGt2WU5aN3ovaWJjcnhkeEI1Z0FEOVkvaU5RVGRocU5IcFhWaFpxMVJVa0sw?=
 =?utf-8?B?TEdVT0pQbWYrbUNvV3pScHdra3c1SHRsZUJTNWxjSkZkelhhajZiOG00TVFm?=
 =?utf-8?B?ellveEtHTmx3YW9HUUNZZHFiMzNPaGpqY0RZaHBJUFhwZ3FoYzRsZUtzNUt5?=
 =?utf-8?B?bG84QzE5QmNxcVVtUXlMYWthYmhYbkRlOVc1N3psQktLN0tIMTFRSWg0cWFG?=
 =?utf-8?B?MldIcWo1SkVlWHdtSVRNZU5LdVVZMWhVdlVZMEgxS245VGpVQXdkOTRoNkN1?=
 =?utf-8?B?ZzBmZ2gvRHpBZXdhdHZER3ZJK05paFRMZFpSQVBJQzJSVU96V0lCMzNPS1lj?=
 =?utf-8?B?VTV2elRXblk3V0owQUxLOFVwNWIvUVpBYTNSSnB3TXFIZkpLdXpNQjdoL0ho?=
 =?utf-8?B?Q3BMMDdFNW1teXY5aHJQMysvOGFtZzQycVltRGJDWndVZ3VhdzNJdkRWV3Rw?=
 =?utf-8?Q?UdLkCsc+D/nJbauyHhVcA7l2w?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C6E17024C391440949B4BDA05760124@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aceb0f2b-b88b-4078-91d7-08da6fa05be3
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 07:19:35.2968
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zmk/Ey9BXqG3hJJsU5mDSDpTCf8nU3CMxtH4MIXtcKoS1uJh/yp0W5VaLvCaXi1pqEE0tlWzdHOAc8Uo8yXdTGDlCINuCLeIgA6Ks8i3B70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6703
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjcvMDcvMjAyMiAwODoxMywgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAyNi8wNy8yMDIyIDE5OjM5LCBD
b25vci5Eb29sZXlAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+DQo+Pg0KPj4gT24gMjYvMDcvMjAy
MiAxODozNSwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4+PiBPbiAyNi8wNy8yMDIyIDE5
OjA3LCBDb25vciBEb29sZXkgd3JvdGU6DQo+Pj4+IEZyb206IEF0dWwgS2hhcmUgPGF0dWxraGFy
ZUByaXZvc2luYy5jb20+DQo+Pj4+DQo+Pj4+IEZpeGVzIFJ1bm5pbmcgZGV2aWNlIHRyZWUgc2No
ZW1hIHZhbGlkYXRpb24gZXJyb3IgbWVzc2FnZXMgbGlrZQ0KPj4+PiAnLi4uIGNhY2hlLXNldHM6
MDowOiAxMDI0IHdhcyBleHBlY3RlZCcuDQo+Pj4+DQo+Pj4+IFRoZSBleGlzdGluZyBiaW5kaW5n
cyBoYWQgYSBzaW5nbGUgZW51bWVyYXRlZCB2YWx1ZSBvZiAxMDI0LCB3aGljaA0KPj4+PiB0cmlw
cyB1cCB0aGUgZHQtc2NoZW1hIGNoZWNrcy4gVGhlIElTQSBwZXJtaXRzIGFueSBhcmJpdHJhcnkg
cG93ZXINCj4+Pj4gb2YgdHdvIGZvciB0aGUgY2FjaGUtc2V0cyB2YWx1ZSwgYnV0IHdlIGRlY2lk
ZWQgdG8gYWRkIHRoZSBzaW5nbGUNCj4+Pj4gYWRkaXRpb25hbCB2YWx1ZSBvZiAyMDQ4IGJlY2F1
c2Ugd2UgY291bGRuJ3Qgc3BvdCBhbiBvYnZpb3VzIHdheQ0KPj4+PiB0byBleHByZXNzIHRoZSBj
b25zdHJhaW50IGluIHRoZSBzY2hlbWEuDQo+Pj4NCj4+PiBUaGVyZSBpcyBubyB3YXkgdG8gZXhw
cmVzcyAicG93ZXIgb2YgdHdvIiBidXQgZW51bSBmb3IgbXVsdGlwbGUgdmFsdWVzDQo+Pj4gd291
bGQgd29yay4gSXMgdGhlcmUgYSByZWFzb24gdG8gbGltaXQgb25seSB0byAyMDQ4Pw0KPj4NCj4+
IENvcHkgcGFzdGluZyBmcm9tIHRoZSBjb3ZlcjoNCj4+PiBJIGRvbid0IHRoaW5rIHRoYXQgdGhl
cmUncyB2YWx1ZSBpbiBzcGVjdWxhdGl2ZWx5IGFkZGluZyB2YWx1ZXMgdG8gdGhpcw0KPj4+IGVu
dW0gZXNwZWNpYWxseSBhcyAoSSB0aGluayBhdCBsZWFzdCkgdGhlIHNjYWxhIGZvciB0aGlzIGNh
Y2hlIElQIGhhcw0KPj4+IGJlZW4gcmVsZWFzZWQgcHVibGljbHk6DQo+Pj4gaHR0cHM6Ly9naXRo
dWIuY29tL3NpZml2ZS9ibG9jay1pbmNsdXNpdmVjYWNoZS1zaWZpdmUvYmxvYi9tYXN0ZXIvZGVz
aWduL2NyYWZ0L2luY2x1c2l2ZWNhY2hlL3NyYy9QYXJhbWV0ZXJzLnNjYWxhI0wzMg0KPj4+DQo+
Pj4gVGhlIHR3byBjb21wYXRpYmxlcyBpbiB0aGUgZmlsZSBtYXRjaCBvbmx5IGFnYWluc3QgdHdv
IHNwZWNpZmljIGNhY2hlDQo+Pj4gaW1wbGVtZW5hdGlvbnM6IHRoZSBmdTU0MCdzICYgdGhlIGZ1
NzQwJ3MuIEkgd291bGQgc2VlbSB0byBtZSB0aGF0LCBpdA0KPj4+IHdvdWxkIGJlIGJldHRlciB0
byBsb2NrIHRoaXMgdG8gYSBzaW5nbGUgdmFsdWUgcGVyIGNvbXBhdGlibGUgc2luY2UgdGhlDQo+
Pj4gMTAyNCBhcHBsaWVzIHRvIHRoZSBmdTU0MCAmIHRoZSBuZXcgdmFsdWUgb2YgMjA0OCBhcHBs
aWVzIG9ubHkgdG8gdGhlDQo+Pj4gZnU3NDAuDQo+Pj4NCj4+PiBJIGhhdmUgbm90IG1hZGUgdGhh
dCBjaGFuZ2UsIEkgc2ltcGx5IHdhbnRlZCB0byByZXBhY2thZ2UgdGhpcyBzZXJpZXMNCj4+PiBp
biBhIHdheSB0aGF0IGNvdWxkIGJlIG1vcmUgZWFzaWx5IGFwcGxpZWQgJiByZXN0YXJ0IHRoZSBk
aXNjdXNzaW9uLg0KPj4NCj4+IFRMO0RSOiBJIHdvdWxkIGxpbWl0IGl0IHRvIDEwMjQgJiAyMDQ4
IHRvIG1hdGNoIHRoZSBvbmx5IGltcGxlbWVudGF0aW9ucw0KPj4gYWx0aG91Z2ggbm90IGluIHRo
ZSB3YXkgdGhpcyBwYXRjaCBkaWQgaXQuDQo+IA0KPiBUaGUgZXhwbGFuYXRpb24gaW4gY292ZXIg
bGV0dGVyIGlzIGdvb2QsIGJ1dCBpdCB3b3VsZCBiZSBnb29kIHRvIGhhdmUNCj4gb25lIHNlbnRl
bmNlIGxpa2UgdGhpcyBpbiB0aGUgY29tbWl0IG1zZy4gT3RoZXJ3aXNlIHlvdXIgY29tbWl0IGlz
DQo+IGFjdHVhbGx5IGNvbmZ1c2luZyAtIHlvdSBtZW50aW9uIHRoYXQgeW91IHdhbnQgcG93ZXIg
b2YgdHdvIGFuZCB0aGVuIHNldA0KPiBvbmx5IDFrICsgMmsuDQoNClllYWgsIEkganVzdCB0b29r
IHRoZSBjb21taXRzIGZyb20gZXhpc3RpbmcgcGF0Y2hzZXQgYXMgdGhleSB3ZXJlLg0KSSdsbCBy
ZXdyaXRlIHRoZSBjb21taXQgZm9yIHRoZSBuZXh0IHRpbWUuDQpUaGFua3MsDQpDb25vci4NCg0K
