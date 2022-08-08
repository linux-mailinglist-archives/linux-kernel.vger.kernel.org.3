Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 182A258CFFB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 00:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236172AbiHHWBc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 18:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbiHHWB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 18:01:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A9A4186F2;
        Mon,  8 Aug 2022 15:01:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659996087; x=1691532087;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=J6l+LNMBKID0iJrfPHb/LlICyGZEpbj7HFp2Az0q77s=;
  b=IE2jSJDl68koKPpbgj4Z2i6fOZGrfMKQ5gaeXhUyRK0MwplvIfM32wR7
   TGmdtczuaqm5QgUKVWOdTOx5pXBo6UZgCMB+YYGCCdTmvWTkZRkKyad5L
   Fsp4nqhKiew6Wbr4mTj9rfLUwOtrZfPoY48MxOEj5wxudh7F8cQx0ZQTo
   f1Upl0sYzqTQUEgBikk2l2znY0DuULBfBu6xCmQvt7mkyxmZi0EUunRtZ
   ZDhHPG3jXdHacWfKlnWFvj9u5aI6gMg2mpquumLru0s3TNape6D71+EUg
   QRlMIc0aEIrYytPJbtwmUCPOvQIkh63b/RUohi3yuabJHiT2TjsIlPJxh
   g==;
X-IronPort-AV: E=Sophos;i="5.93,222,1654585200"; 
   d="scan'208";a="175434128"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Aug 2022 15:01:26 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 8 Aug 2022 15:01:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 8 Aug 2022 15:01:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UrErFCzR/VAyAZhVtq2IIyrLB1vM4ndc95EuknpW2feBnjqMERbjrGE2ibXoemVp/nf93Hq2aNH+6r+qYMuUOUFblgXbFxFa3eoSrwTPYxN1HkFPf965Lq6xRQeuVnkT0L01B6oL9t/NUJrcN2GB+52+PCJSGlw5XKi+k6XbsiczG4kRT6oZMvF102yaT+8k38c/EMc8U7dkxpYt8odbEUJq9b9DeirDVEHvkOcPKPk2LDuIGTlVozszGJ69FrKQ4TNlSq2RswbhfPFnNJtG0Tp92VBTjWrNucLyxTtUW8q3V+/btPdKcSzuMQaFWH8Bl/XP0tLxsHiiEJyKeXTKxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6l+LNMBKID0iJrfPHb/LlICyGZEpbj7HFp2Az0q77s=;
 b=kIHqY8LyCorySkq+5jn0abEsDMSHpIynFoLWBhxgYcvLNTfRvVVh5Aoi6xqlHnsDig8A3Co9mS/hqZ2kSVtwWBxSMFfKrs6ZBlSd1y6rm2NURLbTIkcQewmbD19nnpVai6cGeuGPGtshpLN58lPpMmblMQxlrBTlbHUMQAaHO1eSwhhn9QMf5MbIW6pSh5mIOSyxJHQJlGOeevzyCq9Mx5hwLanffBVgqiw2I45VZ8F4ArdfALGk1T3awVDXlB0o3+G15q5xrWiC2S/pgODNyn6SwRBluw94NK7Ih+KUMpG6IH91izigY9ra7IpAbUl9vcl4TLmuzkVnT1igfUqFdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6l+LNMBKID0iJrfPHb/LlICyGZEpbj7HFp2Az0q77s=;
 b=V3CpHvh/YdTVnWQJqBzl5q1e8wK/NgqPvyQikLi7YMLEO2mdu2H/fowem/cW84bIB4Eqkk7lplMQgT5oBRtPk91weK3/D7Wlp+MT1nJjUz6z9Gtv6RXTSfGo1e2j89+KI8l3jCgiPLAdAKKUDtnpZ+g8j3apl/qcOFZqLpexfoU=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SA2PR11MB5082.namprd11.prod.outlook.com (2603:10b6:806:115::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Mon, 8 Aug
 2022 22:01:11 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5504.020; Mon, 8 Aug 2022
 22:01:11 +0000
From:   <Conor.Dooley@microchip.com>
To:     <jrtc27@jrtc27.com>
CC:     <tglx@linutronix.de>, <maz@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <daniel.lezcano@linaro.org>, <anup@brainfault.org>,
        <Conor.Dooley@microchip.com>, <guoren@kernel.org>,
        <sagar.kadam@sifive.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <qemu-riscv@nongnu.org>
Subject: Re: [PATCH 0/3] Fix dt-validate issues on qemu dtbdumps due to
 dt-bindings
Thread-Topic: [PATCH 0/3] Fix dt-validate issues on qemu dtbdumps due to
 dt-bindings
Thread-Index: AQHYqOiQvE59vmIAhkiZ1sZQKraNy62li3AAgAAHfIA=
Date:   Mon, 8 Aug 2022 22:01:11 +0000
Message-ID: <94fe7e46-6156-1cc5-a4dc-1eee78e99bc4@microchip.com>
References: <20220805162844.1554247-1-mail@conchuod.ie>
 <YvGBYKZyW0B2/wSr@Jessicas-MacBook-Pro>
In-Reply-To: <YvGBYKZyW0B2/wSr@Jessicas-MacBook-Pro>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65a2e27b-690d-4461-381b-08da79898176
x-ms-traffictypediagnostic: SA2PR11MB5082:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: msISlLUjjBDFFi94kRarVCFkqYz4DcO1alzkrvEqVraO7uU+HNf7lTFSrSNfclbutLpB42WDP/VjdjD85yFXwng9E6NuUbasDZ/s/WaNz5GLYvwA1gsYyLR6rPias358vgfKKMUjjtePN/AO6zERscGK17dB1cYrYgW58bACLs6S6F52bAh/OK8v1wxZsXtEF51LRKRiaus76iDyPTEi1+n48fZAGsTJg8mSExIIR3Ck+GA0wzZ1AbzvcSNnOYdAgZ+XSdWJ/1e6NtMpG481sHv7PwwOlyX45d+q4S8jgMqjQZNaXC2s0JGx1SBPQL7rmo1wScewdW3XhF5Nn4wR/3R1WH0dJ9F7o+cifQzDBYutLcNWZSHv3Blu7P8jx52fTZVygInhXx6d4lc/duEeCu6kzc2RKGt5livARxmi42WVJqFMkQB5yL6Z56V146xMdyr6kWJPU4p1HXu6Hi0b6rLOUKUv/kb1K7hS9NomuHa1Bd6LXpO5dh1wKfvyAyE3AnhZm3HpYyKKfzBjLfXjOKCMBwjG336mGkUXGFMdkUMDp55qHOukXrQ5mAs66tfkdO3zLoiZGIJvOXCghKGtRMUQewdRlXRXWRC+I7dMWhBDsx1/ph5VR8m3QKod1dWiY4d7L8gYw1x6c5iQ3OVshmB66lcSDqgw+e9L+InUdw+Oqn/eRmUZsp6lcY6jr0rVbOS22dTluJ5Dny9u0MGWxdgnRKMcTlJmbuk+smKPlTxMh3Tk1ZvC9wMUSoEoGReTa8gAOCxAfzPb6/tjL4mjjzzm8vcm0THyPq0ue7YIrhu1nbu77HXN0ZopgAtptP75MPu7JoicIWdiA7NaTBpUG7dMMW7tZZKmuF3reg5fsj4JGFRPBdS60fD8g/pSgV2C
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(396003)(39860400002)(376002)(346002)(136003)(8936002)(71200400001)(53546011)(41300700001)(5660300002)(2616005)(186003)(316002)(6916009)(36756003)(31696002)(6506007)(6512007)(7416002)(26005)(86362001)(31686004)(38100700002)(38070700005)(83380400001)(4326008)(91956017)(66556008)(478600001)(64756008)(6486002)(76116006)(66946007)(8676002)(66476007)(66446008)(15650500001)(2906002)(122000001)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ditaK0MvRnJtNHUxelB2TzRqYUM5RnBZT2RkMDhEblpXTFJjcUQzb2s3WDdK?=
 =?utf-8?B?cGpIU3Y0bUQwajBGc3hDSXNyei90T3pFT2FKNnVFNnlZSnhadmFRbkc3bEZM?=
 =?utf-8?B?eGVvNG16WGcwTzhPRDFmcHhPbzdkdjVpS0lzTGRiSFlNNkFrMWhHRTN6QVlP?=
 =?utf-8?B?YTh2NU5rMS8rZFloVW5lZUJNVkk3ZHFTUTRJa0lpZTl6OTdyMWpUNjd0THJD?=
 =?utf-8?B?SWhXbnc4QmhaYnprNEJWa2NGTCtHOENmdGRnUml4ZHVGR0g5bHN3VzNlUzJZ?=
 =?utf-8?B?bjNKTU5iejZZRmxxYU1KSGRrVi9zZmlKYmRDd3ZmeXU0VkVRVDZqL0xUcFZF?=
 =?utf-8?B?S3NFNjFVWURsUTBaOXNVNGVEQlYxYjhSZTlFSGpvbnpTNWsvUlRMaGlxaHFH?=
 =?utf-8?B?akxKSmd2TW4vSFpTZUVOejFrbEJGeTJSdEJLN3JoUnNGMklQZFltcmp6SUFN?=
 =?utf-8?B?S0dSNHVhUmg3NS9VNGNYWGU0VHZvY3hER1NxdHdnSmptVExlUWhWejZyV0hh?=
 =?utf-8?B?SnExYmdVbkc2WXdrV09LTUhIOVZaSjdOZ010MTVpaUJZaExEVFFuMUhZc05k?=
 =?utf-8?B?QVZMd3ZYaXFxc2pkdDdaN3BqWXFBanhNNzFhd0dudlpvSXlZdVVncmxNZXBF?=
 =?utf-8?B?ZmxMcGdBYVc3bVBYSFZjOVI4MWE0RTRsUFJKZXFQSEFGUFBBS2YwdHVSTHZG?=
 =?utf-8?B?T2l4ZlFnRWxlTGZNcmNkWkNHc3g3S1FUMmxha04yQ214RU04T0szemRWazVL?=
 =?utf-8?B?U1g5OUxuVmR2UlFiWGxqd0V6QTh5Q0Jxd0tJaThGVDZhd3JrZm8vaHdoK0Q0?=
 =?utf-8?B?Y1k2ZHlwbDJobU9SUldBc3VsU0JmeDhzYXg1NkJJalJmL1Y4eXh0YWN4Y1dU?=
 =?utf-8?B?cG9zbDA2Yko2RHpoQ0N4Qk1walZxd0dDZmdENHg4OWdWYXJXcDFOd0d3aVA5?=
 =?utf-8?B?bW8vRktkOExLUmRGUjB4WmVpVnlQRmg1OHRsTWNzTkppb203eHduY01rL2lS?=
 =?utf-8?B?K3lpdlcxSDZQcTBXREdBZWV1aWJxVFIrU3BlUE5Gd05mc0pzTExhZEZiSU5V?=
 =?utf-8?B?RGV6aWQ5MjJpRmxoZFZ5QlhSOENTd3NHUGo1dlAvRlI2TFNSOUN6SEF2THFh?=
 =?utf-8?B?S3dYU2FTTERrNk1sSCtaaHBsWXhsVlhGc08zd2pnMHJQV1EzTlY0WExOYlVV?=
 =?utf-8?B?YzMrOUtrcExHcEtDZ1dSdHdvNnNpOUVRRGUvNHZiMVo0ZUZhUG9iTFUvRHJR?=
 =?utf-8?B?UTJOaTVJWDZMRERLeXFZcXpuZTJnNHdRaU9vZ1hna1h4UVNhYlNsV2RvNm1s?=
 =?utf-8?B?TEN6YzhrclVmMkY0MysxSXlLVFRLWkVQaEF3VUhNYnY2Qkh2Rlk5WUZHWlZk?=
 =?utf-8?B?RE9VUDk1c1lMYkNZckk3SVJwbldzdGs3dTkzdUVlc3RIRGlWT0pNcVNhSG9V?=
 =?utf-8?B?UFl4ZHl3eE1FYWdTZndPOS90ZVUxZGpReHZWMk1RcWNUSExQU0ZEY0FBSkVP?=
 =?utf-8?B?RUNqdjU2OXEwQ3Y1Y0c0NGt4OTFibDdEdGZpcUkvajEvZHBTVGVXOU8wY3My?=
 =?utf-8?B?ZlVqbm1IRFAxWDBIK3R0YmswazhNdEJwYVVtQzhDQllHQU55M0o1UUwxRy81?=
 =?utf-8?B?YWxIUThldzB6WklzaFB3aXRKQWlTYmVBTHAvOUgzUVBvcUo1c3ZQa2M5N2ZJ?=
 =?utf-8?B?Qm9qckE5dEZoVU1EdWdpSVQ1OGovQy9GSmgvZ1ErN2ZIZ1JnQ1lXdTVRY0Rq?=
 =?utf-8?B?UkhWcHRHd3BNSGx5UGlWR0kvVWhZZTlDdldrWkNvMVJJWUl0RVQ1bDAyK2VP?=
 =?utf-8?B?OUFwVHE3eUdiVU9laUE1cmh6YUFiZFZjV0hmSmRRLzhkb2FBb1dyd21WRmVS?=
 =?utf-8?B?eEk0Y0NqSmZ3NGlnWG92M2pnZWRhemFxV0g0OVd5S1FKd1JnUlVJQmhQbkNh?=
 =?utf-8?B?NFhzcE5PZEZHcmF2dEtFRVB1bG1kOWJidkZGWW5MUjgzTkE4THE3ZnEreXhq?=
 =?utf-8?B?YVZrcWRkUzAyZEl0bnlIUjNPb0l1T3NYclFjZVBxcDJQNnZ1TWhQeUJrbmVU?=
 =?utf-8?B?eUxXRkZSazNGdXd0aHkrdTdVZHMzUElCOHF2L0RpVFcwa2lyK0xYMjVaSDd2?=
 =?utf-8?Q?YKkZtfnZUMYZJNuJHakIWaggU?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EEC662626BF8D744965DE4B2151DBA4E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a2e27b-690d-4461-381b-08da79898176
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2022 22:01:11.5210
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JfWn/mVvfdrJ3nUdOUIuwa1BZUGzF0emexroSZpAFtYCL1dVEumU/Hd2VSarRju+HoaNq06BUiBedjZ6+NbV4OUt6i18jy1rOufuEP+OaV4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5082
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDgvMDgvMjAyMiAyMjozNCwgSmVzc2ljYSBDbGFya2Ugd3JvdGU6DQo+IE9uIEZyaSwgQXVn
IDA1LCAyMDIyIGF0IDA1OjI4OjQyUE0gKzAxMDAsIENvbm9yIERvb2xleSB3cm90ZToNCj4+IEZy
b206IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+Pg0KPj4gVGhl
IGRldmljZSB0cmVlcyBwcm9kdWNlZCBhdXRvbWF0aWNhbGx5IGZvciB0aGUgdmlydCBhbmQgc3Bp
a2UgbWFjaGluZXMNCj4+IGZhaWwgZHQtdmFsaWRhdGUgb24gc2V2ZXJhbCBncm91bmRzLiBTb21l
IG9mIHRoZXNlIG5lZWQgdG8gYmUgZml4ZWQgaW4NCj4+IHRoZSBsaW51eCBrZXJuZWwncyBkdC1i
aW5kaW5ncywgYnV0IG90aGVycyBhcmUgY2F1c2VkIGJ5IGJ1Z3MgaW4gUUVNVS4NCj4+DQo+PiBQ
YXRjaGVzIGJlZW4gc2VudCB0aGF0IGZpeCB0aGUgUUVNVSBpc3N1ZXMgWzBdLCBidXQgYSBjb3Vw
bGUgb2YgdGhlbQ0KPj4gbmVlZCB0byBiZSBmaXhlZCBpbiB0aGUga2VybmVsJ3MgZHQtYmluZGlu
Z3MuIFRoZSBmaXJzdCBwYXRjaGVzIGFkZA0KPj4gY29tcGF0aWJsZXMgZm9yICJyaXNjdix7Y2xp
bnQscGxpY30wIiB3aGljaCBhcmUgcHJlc2VudCBpbiBkcml2ZXJzIGFuZA0KPj4gdGhlIGF1dG8g
Z2VuZXJhdGVkIFFFTVUgZHRicy4NCj4gDQo+IElNTyB0aGUgY29ycmVjdCB0aGluZyBpcyB0byBo
YXZlIFFFTVUgdXNlIGEgcWVtdSxwbGljWCByYXRoZXIgdGhhbiB0bw0KPiB3ZWFrZW4gdGhlIHJl
cXVpcmVtZW50IHRoYXQgYSBub24tZ2VuZXJpYyBjb21wYXRpYmxlIGJlIHVzZWQuIE90aGVyd2lz
ZQ0KPiB5b3UgZW5kIHVwIHdpdGggUUVNVSB1c2luZyBzb21ldGhpbmcgdGhhdCdzIG1hcmtlZCBh
cyBkZXByZWNhdGVkIGFuZA0KPiBlaXRoZXIgdGhlIHdhcm5pbmcgcmVtYWlucyBhbmQgYW5ub3lz
IHBlb3BsZSBzdGlsbCBvciBpdCBiZWNvbWVzIHRvbw0KPiB3ZWFrIGFuZCBwZW9wbGUgaWdub3Jl
IGl0IHdoZW4gY3JlYXRpbmcgcmVhbCBoYXJkd2FyZS4NCg0KSXQncyBhbHJlYWR5IGluIGEgZHJp
dmVyIHNvIEkgZmlndXJlIGl0IHNob3VsZCBiZSBpbiB0aGUgYmluZGluZ3MgdG9vLg0KDQpJbiBh
cm0ncyB2aXJ0LmMgdGhleSB1c2UgdGhlIGdlbmVyaWMgZ2ljIGNvbXBhdGlibGUgJiBJIGRvbid0
IHNlZSBhbnkNCmV2aWRlbmNlIG9mIG90aGVyIGFyY2hzIHVzaW5nICJxZW11LGZvbyIgYmluZGlu
Z3MuIEkgc3VwcG9zZSB0aGVyZSdzDQphbHdheXMgdGhlIG9wdGlvbiBvZiBqdXN0IHJlbW92aW5n
IHRoZSAicmlzY3YscGxpYzAiIGZyb20gdGhlIHJpc2N2J3MNCnZpcnQuYw0KDQo+IA0KPj4gVGhl
IGZpbmFsIHBhdGNoIGFkZHMgc29tZSBuZXcgSVNBIHN0cmluZ3MNCj4+IHdoaWNoIG5lZWRzIHNj
cnVpdGlueSBmcm9tIHNvbWVvbmUgd2l0aCBtb3JlIGtub3dsZWRnZSBhYm91dCB3aGF0IElTQQ0K
Pj4gZXh0ZW5zaW9uIHN0cmluZ3Mgc2hvdWxkIGJlIHJlcG9ydGVkIGluIGEgZHQgdGhhbiBJIGhh
dmUuDQo+IA0KPiBMaXN0aW5nIGV2ZXJ5IHBvc3NpYmxlIElTQSBzdHJpbmcgc3VwcG9ydGVkIGJ5
IHRoZSBMaW51eCBrZXJuZWwgcmVhbGx5DQo+IGlzIG5vdCBnb2luZyB0byBzY2FsZS4uLg0KDQpZ
ZWFoLCB0b3RhbGx5IGNvcnJlY3QgdGhlcmUuIENhc2UgZm9yIGFkZGluZyBhIHJlZ2V4IEkgc3Vw
cG9zZSwgYnV0IEkNCmFtIG5vdCBzdXJlIGhvdyB0byBnbyBhYm91dCBoYW5kbGluZyB0aGUgbXVs
dGktbGV0dGVyIGV4dGVuc2lvbnMgb3INCmlmIHBhcnNpbmcgdGhlbSBpcyByZXF1aXJlZCBmcm9t
IGEgYmluZGluZyBjb21wbGlhbmNlIHBvaW50IG9mIHZpZXcuDQpIb3BpbmcgZm9yIHNvbWUgaW5w
dXQgZnJvbSBQYWxtZXIgcmVhbGx5Lg0KDQpUaGFua3MsDQpDb25vci4NCg==
