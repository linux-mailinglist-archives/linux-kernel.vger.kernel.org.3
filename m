Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 804E85867B7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 12:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiHAKlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 06:41:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiHAKld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:41:33 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D63C37FB8;
        Mon,  1 Aug 2022 03:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659350444; x=1690886444;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=csAygSnLTGImDquSANTX1B55dxACUv5vkOiUvRK6lp0=;
  b=duOIe1f6hbc3K+LAYJyYTzSccjFmuBprjNOruo8mMrEEYyYoWNTKEPL6
   bvDR12pe1iZtj8zaq7R4rAqJt2ujSyS7MJ2Xd/Dx2F0F4axhubscDAkAr
   hxATa/5kcnOPcdbr79+2hEpn4m9wPHxwZtHMEjgdN/Z+E2K5W1DJnXSbh
   mibKTCKMa7Y1soCytt4c2XEJoDDrQbtiXP95a8EIwvBvWFmj5KwexWl56
   x9tRri/ZaLSiEWa44zT0aMaRiW+pZ1bIueqvhqs6GAbFLSpUVMjWabEtW
   pUQp40zMfWuts2SdjrVGJGWxzRRrTZ+767u2JnFhT/jZRUmEvWJxoSSMl
   A==;
X-IronPort-AV: E=Sophos;i="5.93,206,1654585200"; 
   d="scan'208";a="184562531"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Aug 2022 03:40:38 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 1 Aug 2022 03:40:38 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Mon, 1 Aug 2022 03:40:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBaTqv3z2Xt/twnhSzlC9+FeVEGp8oyR2UgVJy80qmonQ9fSgEjVPZNk6TmknqiIECe4jvHBvu8BqMyXE6cRSJwrKYWoxK0sg01KoJipQjmZiW8rDxwJUiglNu8pGbefrHICe2iB8i6pL/3EKJruFbllVrtbKqsle7C7OKj5h/1caJwVSZdclpLp/CHYIV2RvZrRvvzQALS1a/Bxm8tWzBsZe1rT8AVXbHiBdjLEgLM/bpAV+sY5tcA4CzRollr390ABR8tFPOVc7rOrvx3EMjiWuGGnVTGqOJCiDEh20w1jeCWl4PXA91Eg5q51aEfPy28YwivpYsRZ962KmM0nIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=csAygSnLTGImDquSANTX1B55dxACUv5vkOiUvRK6lp0=;
 b=Pu/eHU3QYJO9dJI0U+n1hhn/6nSSZaPg0DqwxC60bv1eDkNhzE3SbYjwStb1D4ipjTiTzxiIyyfbd79k/r8n2OadEluIboKB9Azf9Jdsw2A7gp6G43T+QLrop29jkWmctgiHATqxY20N1TyYeQINi5dxO3BYvXZPd+ALj5OvUwpB6Yw3ZPuHmqujKaRXf4Pqg1eeDDLhHqJcFz8YQW/bFi1EOErB+52VIygaTR9+8sJu4cxOifjb71LyTM1k51V+fp+lOZH2HLLyFh9pd74caj4qqkpjwehhmkm1lPfG1WOLGSax49XyMJ3rYHdC3Sr5IAT4Zgo0RDJ5Lw6SAO7LZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=csAygSnLTGImDquSANTX1B55dxACUv5vkOiUvRK6lp0=;
 b=IS6dAgk3XMaT1wD3Q0iF07Jo8pJUgAQ0fvCkQ8uHtKyXlAPLha34yZsNkOpIUyhDiLzV5hyBQSrINycEHwXuXOGQdRBmbuUMPJBH7+KIboaYv9Yg09bCckX8YJ7Xu0S1Lzwmzg0LJDf6gsgXMgYXEKLmLsWOV/AUnaQaxR2JfCc=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BN9PR11MB5483.namprd11.prod.outlook.com (2603:10b6:408:104::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Mon, 1 Aug
 2022 10:40:33 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 10:40:33 +0000
From:   <Conor.Dooley@microchip.com>
To:     <Nagasuresh.Relli@microchip.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] spi: microchip-core-qspi: Add support for microchip
 fpga qspi controllers
Thread-Topic: [PATCH 2/2] spi: microchip-core-qspi: Add support for microchip
 fpga qspi controllers
Thread-Index: AQHYpYscI+Kkk/PiAEWVZ6Ma6620dK2Z2ykA
Date:   Mon, 1 Aug 2022 10:40:33 +0000
Message-ID: <283bdfef-cbd9-5d87-f77d-10f007c37a0c@microchip.com>
References: <20220801094255.664548-1-nagasuresh.relli@microchip.com>
 <20220801094255.664548-3-nagasuresh.relli@microchip.com>
In-Reply-To: <20220801094255.664548-3-nagasuresh.relli@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 68270587-838d-47f2-3471-08da73aa42e8
x-ms-traffictypediagnostic: BN9PR11MB5483:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uWW5fCu4YfUPURPTIwux7mhVF68VmRSq0R+I8t+67LkDpDZMbbtOB06gJVlJ656qEJ0uGeRLuGW8nuNhTnicMMwRB977tyhcgqaPfJAy+iaVuViClpr3RX2Y/G9H8jvmyXDsU4ZCBGZdeMR6/bXsDfsKXKM0L3Gor4PObVsa6MnLTfcCXH4cnU8VbndAvQfvgq+ZAFqK5LG4toDCXTlwseWp1o/qIpJABajuta3kBl0zkJ2B6WexTV+lzqu1s+aHu5O1rZSZSLdhdLw8PBRFPxq/IAsqoG1oEL29TMnKGHDdS7fY5NTTm9E4rQt2RxlIWzwLjvslEpv5n9uV6Rct44Abwy/Zbp/CknrYyb8RX6vjpPagz7vO467UuhPNLd+8MmaqCd+ud/+YWzDuVgUJMCzhJiZqUR3cSIsm2giBtltCegJkqlDL9D5h0cRn0+vo1bi7iiitf35YAFc61lcq/booFnY7ZIhTpbhs9IolnUg62p2Vt367zh5F8AgdoqrYOhLlvNXgqlILGcdhIDTJP13zX7LbI198/9+De/Fbk3UPzeNkI55MQ/kKQRb88mZmQ/fgpo01BLEQPWOobqDhdL5GyUK9MM2eWaOJm2PO/L+7EFDQ9nxXomfhr6I/2T9FbGRWtE55Rr8H2onB7qwtKR1daDxv0YrrkkaWiNPxsbGnpFhM4b+f/AWmMIeXyPRdEkEtXMVyMi/5JTNkntFPTN1rSzEpXmNH0fLLFy+5ljMEZnwW53QnZxXEBj+4ow9S2i1qxv9nknE+9jdQR3Ia2ks8LxvXVXiSz2+fFT+k9o9+zhKKx6eQokYas88KZNjw68x61ZQOd578+oR6rVRECCbOLflQVDsormaKws9syKO70JEWF1na5PAcz6DCUfz+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(136003)(346002)(376002)(39860400002)(41300700001)(6506007)(53546011)(186003)(83380400001)(6512007)(26005)(2616005)(38100700002)(38070700005)(122000001)(5660300002)(8936002)(2906002)(36756003)(478600001)(86362001)(31696002)(6486002)(71200400001)(91956017)(8676002)(31686004)(64756008)(66476007)(76116006)(66946007)(66446008)(4326008)(66556008)(110136005)(316002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YUplQWNWcjZOUThzNVd2UWNXSGNFQTM5MGE5Y0MxdFZqdnBhNTQ1TVZMWWU5?=
 =?utf-8?B?QVh0dTNPb3l4d2M5ckpxZXdveTBReWVUY25xVjJPRUVRcTdHamNVVE5Bb3lY?=
 =?utf-8?B?NzhVcVlKcVJRN3JhRlQ0U01MMkJZMDhyTFVkSWhHM3Yxc2Nuc0toclV5TGxS?=
 =?utf-8?B?U0dVSElWaVJwcVFaU204RTkzcmJXbzNnMGFjdnd2eFBNbXEvdU55QTJLWkx4?=
 =?utf-8?B?ajYxUUNKUThUWldra3VXMmZYZWZSSnhoakZhZXNTQmtEV3p1VkozVjkxckFh?=
 =?utf-8?B?cWVWUlhJYjlDSGpVM2x2WDNHQjNPM2I4eWZtL2ZWRjZwTGJEdWF1NE9FQXc2?=
 =?utf-8?B?eVM1MUtJeXV1bHp4bU01c2hPc2w5Zk9nQ0xtWWdQSVFHdzhoU2ZHM1Q2THZu?=
 =?utf-8?B?VzRhZVVVUStBaW1rUUYyTDdtSExySUlRK0psS25wMzY4R3VSOHlTY3J6MFNG?=
 =?utf-8?B?dTQ4T3F2TnRtY1R2VTg0UDgwaDErckFjOUtTKzZla0dtTk0reU1NWmNxdWox?=
 =?utf-8?B?YmdMT3IrbkFTRE5aTWdrdWJyZzlBNEZaOURzam5yTSt6RXpteGdyMUZpdE5K?=
 =?utf-8?B?cTJ1MHIwenN6UjMvVTRrZm15Nitvb3pkRzJOVE9iRUFOK29BdGVTMGdQb3kv?=
 =?utf-8?B?eWlUcThzeExtZlArSy83RU9nZWY3dlV2eWcwUVY2ajRWY2NhNHV3S2FRMHZV?=
 =?utf-8?B?eVFwTFl4ZEllUVNZSmZDNWlzMlN3UHpyaS8wU1prVWhRaDEySE4zZnhHT3Jz?=
 =?utf-8?B?K005aVF6Q21JUHVRbS83ZWJGS0I1OEY3MlhWQmlUVEJONXB6QVFYbyt5K20v?=
 =?utf-8?B?VHBjYjU2Ly9jeVgwcStwa2sycWJGdkZ4THV3VDBKa3FNRGlFS1NOK0NYc1Q1?=
 =?utf-8?B?TGRXb3I1Rm1uaWs0ZzlXQ2twZWxlYmplWGhqV2I4bTFlV0k1SFFmQ0xqYzlz?=
 =?utf-8?B?aVMycTFVb3hIOEhXdmxEM2dyNmMvMXZrcHBqaEpwUWRKV3pVcHowcmZXM2dT?=
 =?utf-8?B?ZWQ2MG9jRUlEdUZvQXlFend1Y2JUeHRtejlNV0hyU3I1ZGl3cWtjNFpoeElR?=
 =?utf-8?B?THJjc0JhS2ErQUdTT0xOY2E2R2hSMjhMV2xDckVpb1c3bit2N3JUV05tY2Nz?=
 =?utf-8?B?dWJNL3dJaElDSzZERythanZwN25hZTRmRWYvSUd0SSsvYmVYYU9pMEt1VFYw?=
 =?utf-8?B?N1dTUitqTy9wMHZEZU9Cc1ZRM1BSUDF3Q0x5S0I3eDJ6VGI1VXNpUU9ZamJG?=
 =?utf-8?B?Qyt5bjlkelVrdjByRXdWQkF0MThydG8zRTB5VzdBNDdnd3l3SzlzN2JYL1NW?=
 =?utf-8?B?Q0svT0dIVnBIWGVERTc0dmZWZ3ByZnA4U1RyandYS2tBdTBlc0dMVFZ3RFhW?=
 =?utf-8?B?UUFUMmxZZmp6MkRjYU5KSTE4cTFsd3RySXBodzk1SGliejhtNHFrOTllQ2g0?=
 =?utf-8?B?eS9KaTM1NloxdkF6TzVHS2NDMnorWUxKV2M3NVZoZHg4NFlaNHpDV0JlT1JM?=
 =?utf-8?B?MjZaak9vVCtHNHN2Y0taV1BRVG9KeHRnNTU3azBHY2J5b1loL1Vobm1JYlR0?=
 =?utf-8?B?RE5kVGY0Nmt2ZFRTa0pUWGN4MDErWEtwWWZtNlBiNzR4akRXcDcxV09oVlZZ?=
 =?utf-8?B?U0RjTkt1VGRseUVvMi9OVnpuMnNHYlJJdkdXWnFTRUZUTzZvVGJDZFpuQ1hu?=
 =?utf-8?B?VmJxSUdHTVZDWFhiVnZ1QjUrS0NpN2JlODh0U1ZBRlFOYmY0VWhvaWErZzhm?=
 =?utf-8?B?TDZVYjAwNDh6N3p5NzlURi85R2p0a0tNc0pGMHVVallnTFFRK0RGOTBUODFO?=
 =?utf-8?B?UmVWa2d6cHRSNnVoMEs4QjJlMjRRZTg5RG90c09yTkppRzBGS0oyRkFZRU1E?=
 =?utf-8?B?VzZjSjRxTGE0T0dkSDByYUxWUUw3dG1aWXU2OEdtMC9rT0JuU2F3b1BZNmxI?=
 =?utf-8?B?VjlGN2x6RFlyS1ZqZjZZVEJ0WmFidHFQcDlpQi9TREt1eE5ZUVNKOTdCaCtx?=
 =?utf-8?B?Y3lNakdlRXNwRkhvT3BBMVdyNnpjRTBWNFFwWEMwdUl5S2dxMDJ6M2dKTUtW?=
 =?utf-8?B?ODJSMmtBSU9IekZtOWwzUm13RXJOODlyL3lvNVJQeTVyNmtidTQwcFQ3TDFx?=
 =?utf-8?Q?I4dsMNsN5tlWJcyVVAdLHZ0oO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F170E1E12548384A8F84772BDC9C9396@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68270587-838d-47f2-3471-08da73aa42e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 10:40:33.0182
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kpqNNgevkE+JODn7jbnwQj77ZnHDq2di8nrccWD9IIQvVo2pQBWw7+0AYUMkMK1eWU9u3ciuBbnVHsu0oHOxgEI3i5xfBU39Mpp2T0Ce22A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5483
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDEvMDgvMjAyMiAxMDo0MiwgTmFnYSBTdXJlc2hrdW1hciBSZWxsaSB3cm90ZToNCj4gQWRk
IGEgZHJpdmVyIGZvciBNaWNyb2NoaXAgRlBHQSBRU1BJIGNvbnRyb2xsZXJzLiBUaGlzIGRyaXZl
ciBhbHNvDQo+IHN1cHBvcnRzICJoYXJkIiBRU1BJIGNvbnRyb2xsZXJzIG9uIFBvbGFyZmlyZSBT
b0MuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBOYWdhIFN1cmVzaGt1bWFyIFJlbGxpIDxuYWdhc3Vy
ZXNoLnJlbGxpQG1pY3JvY2hpcC5jb20+DQo+IC0tLQ0KDQotLS04PC0tLQ0KDQo+ICtzdGF0aWMg
aW50IG1jaHBfY29yZXFzcGlfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4g
K3sNCj4gKwlzdHJ1Y3Qgc3BpX2NvbnRyb2xsZXIgKmN0bHI7DQo+ICsJc3RydWN0IG1jaHBfY29y
ZXFzcGkgKnFzcGk7DQo+ICsJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsNCj4gKwlz
dHJ1Y3QgZGV2aWNlX25vZGUgKm5wID0gZGV2LT5vZl9ub2RlOw0KPiArCWludCByZXQ7DQo+ICsN
Cj4gKwljdGxyID0gc3BpX2FsbG9jX21hc3RlcigmcGRldi0+ZGV2LCBzaXplb2YoKnFzcGkpKTsN
Cj4gKwlpZiAoIWN0bHIpDQo+ICsJCXJldHVybiAtRU5PTUVNOw0KDQpBcmdoLi4uIEkgYW0gc29y
cnkgZm9yIG5vdCBtZW50aW9uaW5nIHRoaXMgd2hlbiB5b3UgYXNrZWQgbWUgaWYNCkkgdGhvdWdo
dCB0aGUgZHJpdmVyIHdhcyByZWFkeSB0byBiZSBzZW50IHVwc3RyZWFtLCBidXQgSSB0aGluaw0K
d2Ugc2hvdWxkIHRyeSB0byB1c2UgdGhlIGRldm1fIHZlcnNpb25zIG9mIHRoZXNlIGZ1bmN0aW9u
cy4NCg0KPiArDQo+ICsJcXNwaSA9IHNwaV9jb250cm9sbGVyX2dldF9kZXZkYXRhKGN0bHIpOw0K
DQpJcyB0aGVyZSBhIHJlYXNvbiB0byB1c2Ugc3BpX2NvbnRyb2xsZXJfZ2V0X2RldmRhdGEoKSBy
YXRoZXIgdGhhbg0Kc3BpX21hc3Rlcl9nZXRfZGV2ZGF0YSgpID8NCg0KPiArCXBsYXRmb3JtX3Nl
dF9kcnZkYXRhKHBkZXYsIHFzcGkpOw0KPiArDQo+ICsJcXNwaS0+cmVncyA9IGRldm1fcGxhdGZv
cm1faW9yZW1hcF9yZXNvdXJjZShwZGV2LCAwKTsNCj4gKwlpZiAoSVNfRVJSKHFzcGktPnJlZ3Mp
KSB7DQo+ICsJCXJldCA9IFBUUl9FUlIocXNwaS0+cmVncyk7DQo+ICsJCWdvdG8gcmVtb3ZlX21h
c3RlcjsNCg0KVXNpbmcgZGV2bV9zcGlfYWxsb2NfbWFzdGVyKCkgYWJvdmUgd291bGQgc2ltcGxp
ZnkgdGhpcw0KdG8ganVzdCBhIHJldHVybiBvZiBkZXZfZXJyX3Byb2JlKCkgJiBkaXR0byBmb3Ig
ZXZlcnkNCnRpbWUgd2UgZG8gYSAiZ290byByZW1vdmVfbWFzdGVyIg0KDQo+ICsJfQ0KPiArDQo+
ICsJcXNwaS0+Y2xrID0gZGV2bV9jbGtfZ2V0KCZwZGV2LT5kZXYsIE5VTEwpOw0KPiArCWlmIChJ
U19FUlIocXNwaS0+Y2xrKSkgew0KPiArCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJjbG9jayBub3Qg
Zm91bmQuXG4iKTsNCj4gKwkJcmV0ID0gUFRSX0VSUihxc3BpLT5jbGspOw0KPiArCQlnb3RvIHJl
bW92ZV9tYXN0ZXI7DQo+ICsJfQ0KPiArDQo+ICsJcmV0ID0gY2xrX3ByZXBhcmVfZW5hYmxlKHFz
cGktPmNsayk7DQo+ICsJaWYgKHJldCkgew0KPiArCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJmYWls
ZWQgdG8gZW5hYmxlIGNsb2NrXG4iKTsNCj4gKwkJZ290byByZW1vdmVfbWFzdGVyOw0KPiArCX0N
Cj4gKw0KPiArCWluaXRfY29tcGxldGlvbigmcXNwaS0+ZGF0YV9jb21wbGV0aW9uKTsNCj4gKwlt
dXRleF9pbml0KCZxc3BpLT5vcF9sb2NrKTsNCj4gKw0KPiArCXFzcGktPmlycSA9IHBsYXRmb3Jt
X2dldF9pcnEocGRldiwgMCk7DQo+ICsJaWYgKHFzcGktPmlycSA8PSAwKSB7DQo+ICsJCXJldCA9
IHFzcGktPmlycTsNCj4gKwkJZ290byBjbGtfZGlzX2FsbDsNCj4gKwl9DQo+ICsNCj4gKwlyZXQg
PSBkZXZtX3JlcXVlc3RfaXJxKCZwZGV2LT5kZXYsIHFzcGktPmlycSwgbWNocF9jb3JlcXNwaV9p
c3IsDQo+ICsJCQkgICAgICAgMCwgcGRldi0+bmFtZSwgcXNwaSk7DQo+ICsJaWYgKHJldCAhPSAw
KSB7DQo+ICsJCWRldl9lcnIoJnBkZXYtPmRldiwgInJlcXVlc3RfaXJxIGZhaWxlZCAlZFxuIiwg
cmV0KTsNCj4gKwkJZ290byBjbGtfZGlzX2FsbDsNCj4gKwl9DQo+ICsNCj4gKwljdGxyLT5iaXRz
X3Blcl93b3JkX21hc2sgPSBTUElfQlBXX01BU0soOCk7DQo+ICsJY3Rsci0+bWVtX29wcyA9ICZt
Y2hwX2NvcmVxc3BpX21lbV9vcHM7DQo+ICsJY3Rsci0+c2V0dXAgPSBtY2hwX2NvcmVxc3BpX3Nl
dHVwX29wOw0KPiArCWN0bHItPm1vZGVfYml0cyA9IFNQSV9DUE9MIHwgU1BJX0NQSEEgfCBTUElf
UlhfRFVBTCB8IFNQSV9SWF9RVUFEIHwNCj4gKwkJCSAgU1BJX1RYX0RVQUwgfCBTUElfVFhfUVVB
RDsNCj4gKwljdGxyLT5kZXYub2Zfbm9kZSA9IG5wOw0KPiArDQo+ICsJcmV0ID0gZGV2bV9zcGlf
cmVnaXN0ZXJfY29udHJvbGxlcigmcGRldi0+ZGV2LCBjdGxyKTsNCj4gKwlpZiAocmV0KSB7DQo+
ICsJCWRldl9lcnIoJnBkZXYtPmRldiwgInNwaV9yZWdpc3Rlcl9jb250cm9sbGVyIGZhaWxlZFxu
Iik7DQo+ICsJCWdvdG8gY2xrX2Rpc19hbGw7DQo+ICsJfQ0KPiArDQo+ICsJcmV0dXJuIDA7DQo+
ICsNCj4gK2Nsa19kaXNfYWxsOg0KPiArCWNsa19kaXNhYmxlX3VucHJlcGFyZShxc3BpLT5jbGsp
Ow0KDQpJZiB3ZSBtb3ZlIHRoZSBjbGsgcHJlcGFyZSAmIGVuYWJsZSBsYXRlciBpbiBwcm9iZSwg
aWUgYWZ0ZXINCmdldHRpbmcgdGhlIGlycSwgdGhpcyBnb3RvIGNvdWxkIGJlIHJlbW92ZWQgdG9v
IGJlY2F1c2UgdGhlDQpvbmx5IHBsYWNlIHJlcXVpcmluZyB0ZWFyZG93biBvZiB0aGUgY2xvY2sg
d291bGQgYmUgdGhlIGVycm9yDQpwYXRoIG9mIGRldm1fc3BpX3JlZ2lzdGVyX2NvbnRyb2xsZXIo
KS4NCg0KPiArcmVtb3ZlX21hc3RlcjoNCj4gKwlzcGlfY29udHJvbGxlcl9wdXQoY3Rscik7DQoN
CldpdGggZGV2bV9zcGlfYWxsb2NfbWFzdGVyKCkgdGhpcyBwdXQgaXMgbm8gbG9uZ2VyIG5lZWRl
ZCAmDQp3ZSBjYW4gcmV0dXJuIGEgbmljZSBkZXZfZXJyX3Byb2JlKCkgZm9yIGVhY2ggZXJyb3Ig
OikNCg0KPiArDQo+ICsJcmV0dXJuIHJldDsNCj4gK30NCg0KVGhhbmtzIFN1cmVzaC4NCkNvbm9y
Lg0K
