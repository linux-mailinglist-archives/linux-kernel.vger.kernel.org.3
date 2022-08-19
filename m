Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8151599605
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 09:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344679AbiHSHbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 03:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241145AbiHSHbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 03:31:34 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7E43E3C09
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 00:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660894293; x=1692430293;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=PEaNqgVEbMGTl5MFf0L34MIXIpf5IsT5Yai/ucThPT8=;
  b=GsOpTdhzV2cpSLO1ajQ4QXW41uAD0cVDkwE4KLt3MIX+DlTNZ0/VEUn2
   uNiMy2k4ZB+/TWIWxeSjjJTezZ3T5HhQPTtFIHU9D+uF/TB1Yi+1sXF9+
   GdPeZG1SPL85zMJ7lAgEHCm1Oy2lNam5v+ccQtQa/mfXcxjRU+vla3UBL
   fciay5UAnehZ2pglBrasK3GGraB9egHWXsIeqRkNjfs+Vg1fMBwgW9Ex0
   N+t2tScQLF1rATwZRWWwuloWBd30RP8AUlfnZdpF8l7mTC4vFvEHtZqoD
   0RMn41UVlO22ETqs4T7jC/7UcV6ZyN5V8jvENu6eLnmDm0fDSqAcXzNSp
   g==;
X-IronPort-AV: E=Sophos;i="5.93,247,1654585200"; 
   d="scan'208";a="176895002"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Aug 2022 00:31:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 19 Aug 2022 00:31:30 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 19 Aug 2022 00:31:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBnE4m/LaCy98aP9oKXZgOXSGq2BwyNCV0Of/i1Zdzf4afI9twelB3SfABAYmfsCwym5qHKyKbttuKkdidp8tfk1zEtuUXhLcCalg9nQFxOsDZ/ruF9YmuHAX02V3suIx7J/9olYqE4kKJLzof2slVJ8FSZxq8GfattrgplMlbCGnkvlzc1+MXgireEHcOAshtTEi1cDXrSvXsdFNMl5MunRpZtkukIUsTUplH+KmuEVA8CeOKyNP2k14Mzpw8Uc9sd7K6RMvQJc1vMSXeX3d9dnm/me2A/VZ/iCpp57w6dlHh5YLCbLFD/MeA8owNX0LcqqR26RIzhRLq3kKQnkwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PEaNqgVEbMGTl5MFf0L34MIXIpf5IsT5Yai/ucThPT8=;
 b=bxWT4yqqnihree+8HxDAj0vPNbETYVje7tXhb/3EY2u/isu+1v51y4oMCXHvIX7WpxmrHjTM6eEQuzorhHwO054DOgX3ZUfT4JjdQXAEAwEdZYITLmvFfHs9AHvV6Zu/s1PYbMHl7JuEdv4kTC1NU9O1p2orw3ad19xkwBrPrSBwEec5eFkhK0FaMhV1D3gMT8ak2wqer9MX20kfNPNuOXGae2eepNxC4KEWXxaYezIdslp0g/fBF2AHOFfbnF3bg10p2d2zjdTuZ3uhzHYsqVO7j+iP8h4QVfdCrZQ6D1xpHBCyHlNAco5xjLFL2BsFlSiSgJ237sEy69xhsVoWpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PEaNqgVEbMGTl5MFf0L34MIXIpf5IsT5Yai/ucThPT8=;
 b=to0hT1DvQOCVYXP6vp6ZxvhirsG18oS/hT4/44g5NRuMA33zCubcfixTws5AxsPjH7fXNoXhD2hFecE3lG+R3OYDFgO+tlaQVvxnpU0YBDXZDdJwpqpLv1/SqIT67/g/fUvKMSmbwEKUZF6rVc5w6jSLKuC0Q2s3wGiK3SmRfQA=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by DS0PR11MB6469.namprd11.prod.outlook.com (2603:10b6:8:c3::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Fri, 19 Aug
 2022 07:31:26 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::7c6d:be4a:3377:7c4a]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::7c6d:be4a:3377:7c4a%5]) with mapi id 15.20.5525.011; Fri, 19 Aug 2022
 07:31:26 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <arnd@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <Nicolas.Ferre@microchip.com>
CC:     <arnd@arndb.de>, <joel@jms.id.au>, <f.fainelli@gmail.com>,
        <treding@nvidia.com>, <digetx@gmail.com>, <broonie@kernel.org>,
        <william.zhang@broadcom.com>, <stephan@gerhold.net>,
        <michael@walle.cc>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 09/11] ARM: defconfig: drop CONFIG_MICROCHIP_PIT64B
Thread-Topic: [PATCH 09/11] ARM: defconfig: drop CONFIG_MICROCHIP_PIT64B
Thread-Index: AQHYs52wCCPmz8a03kehrLtmIlhdKQ==
Date:   Fri, 19 Aug 2022 07:31:26 +0000
Message-ID: <6fe0733b-2cfb-a95d-b69e-6c5ef5162e0f@microchip.com>
References: <20220818135522.3143514-1-arnd@kernel.org>
 <20220818135737.3143895-1-arnd@kernel.org>
 <20220818135737.3143895-8-arnd@kernel.org>
In-Reply-To: <20220818135737.3143895-8-arnd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 469fc38a-28b7-49bb-f693-08da81b4d30c
x-ms-traffictypediagnostic: DS0PR11MB6469:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Fw5XRBdntVE6UeQooSG+t0Q7hZ7PoUczoCjS6rVWbgsWjhg5OTrvudmLfEeirB58SzHA333UXAxND/CmbszzDKGusqinrai8LS8EsGeFu+A04AAlno+L6F9rko+8ErOZhWADE174lssgocRnQNZIbvwRCQQfwXbiV1WrghniPBvBvDGuZu+snT6I+lNbO4gIN8TdhDv8sWudm/uImIR1dD7RRfGX+3NQCwLm2Dso0SOR7dlmenZPPHMzlSYa081AicPByk443kwc7K49p2wFHZHRJcF3d3IDEKBe6Fm4BaQG8r82EoVBF+TVeDQf3CDv/D/FSt1kjceK9fhxFHxjNYShSSeoKfK7I4Kq5ULq9DY3tze7mMauIq2wTzVwLUWiYoZv+QUxF3T1mldRiyH0h9w2TnVCAXBjw0Sz2KDesBlAL2XFaKFHE+tvikYJ3mxvTJ8lF6kMOq5DocOlkruP2uil88RU+6Qa5tokkzAYVWFP+bWjZv3PMvtVZNjhgT6fZ7wkp1scmUvfugFQzaibTVdPLBUAzqjnWypOXMzTvaAZ2Hhvp+ppEOBRt5fB5tVG1Lmjcm8nV7OJPgdwc44snIIMkQQG+l29lHAmD+RMpkblAiy/clnYD141GX0RGbhzkjdmgwGtNOE2hcEUJaC7H2r6TitFfdgz85YKKlzIXR6u6+Dxny2JyDV3ctUPyNhyDSEP2haz/IsaF002tg1h169f8gTAfavxGqSrsF9JZmvRt19pz8poyOEDHSHo4EGIrkWOf9Yg5dmXm4ZKaOnVpSp3u8PXiUlnKgHwO6McykvE2oRvuEnRaJe/tqAI8z+zkvfPYuASsAYGYx97e1kYdA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(136003)(39860400002)(366004)(376002)(396003)(5660300002)(4326008)(83380400001)(38070700005)(26005)(66476007)(91956017)(7416002)(36756003)(76116006)(66556008)(8676002)(64756008)(31686004)(478600001)(2906002)(66946007)(66446008)(2616005)(6512007)(186003)(6486002)(110136005)(8936002)(54906003)(53546011)(122000001)(6506007)(316002)(31696002)(4744005)(71200400001)(86362001)(6636002)(41300700001)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d000VVFLd1QzMDZSQ095ZjVObThEb2ZiVUdWV0FBMUVxdGl0NXpQUDJTQkRv?=
 =?utf-8?B?SUMyL1JFVU9oVW1ySndHYTFIRFhTa3JqMXlDejd2aTEyT2ROTk9IakxlbFBk?=
 =?utf-8?B?dVViOURaZTRpNEtmaGN1V2F1LzFLMEhrWkFkZUQ0bTFZZHNrbVQyTkIwOHhG?=
 =?utf-8?B?aWl5Rlk2akp2N0tYM01oRzNVek9IaDU3Y2VscW1LMTZVVkhmdko2NytEZThC?=
 =?utf-8?B?NG1aNEI1d1VCSDB1T3c1bjhJYm8zQm11cnludFJ2V3NrUyt2RXJWMUFoaVJh?=
 =?utf-8?B?ZkNvaGJ3dGllSC9CYVNTejNpSkY3Q1o4bWFtc1VBY1M0NEhKM0I1WFJjOXdr?=
 =?utf-8?B?c1g2RG5jNlcvZHRzSHNOeTBVUW9PbHUzOGFaR2FwaUR1bVhvajJSZVVhc1Fu?=
 =?utf-8?B?eHNSb0tYdkFZS2k0N1BGWjJpK0NkckNWQThnNXZoblRKd2hkcFFLZHRXNjNz?=
 =?utf-8?B?Qi9ocnRqWjBzRnRhWVhlM1ZBcFBaRmJCemNwc3NIQ3pCMmIxOTVESlZQT3R5?=
 =?utf-8?B?WStGd0FxSUJOMUhtaHpMWGxlVGVQK2REVlZIZFlHamVCc0IzakpFYlk2U1Nq?=
 =?utf-8?B?UGVBdnVHWVZ4dnE0OENTeWVMc1dlTFpaUTQvbXl0VWNjS01DOUp4b0RqM3Ji?=
 =?utf-8?B?OEZJODE1TUN2THpUWTE3M3M0L2d0NlVsZTBJeHdEaWdHTlY4M3NydXdVSVhN?=
 =?utf-8?B?SUdGOGpYUUd1SzRpb1VxSC94enJ0NmVIRUg5UktvbzNWc3hxeSswaW5vSi9W?=
 =?utf-8?B?ay9qbUJseWVuSGh4SGVUVHovYXN0bzhaM1NjUjBocUNycFFkcW9lNHR5dmty?=
 =?utf-8?B?ZUQvWHk5emx5d1FnamplNFZKSkwzeGUrY2hoK2VCSWg5MVRDT2dNZ1FnRitz?=
 =?utf-8?B?RFcyTXBod2l2SWluMTRiUGhZZjc1c2p6aXFyUGhVaUZuK3Y4cEorR21DWFBl?=
 =?utf-8?B?VW1MeHlrdFQrY2d2VFI3M3d3TGp0OFFJZWJTd1lGM1drWmFrUTJZVUVSSjBO?=
 =?utf-8?B?dndXSFZrN1ViODY0Y3JUL2w4NittLzVrRjNlZ0hEVFkzVEc4OXNiVFJZd2lt?=
 =?utf-8?B?YWRBLzB3ZEMvNjRZc0RFSXc4QUphVXJqcE5vWjE5R2pwdFpCSmxja3cyM05m?=
 =?utf-8?B?MU1FWTAvcGRQTVVCZ2RXVkt2VWVsTnpwKzRSS3NSWnNkc0lkeHdVSHJaMC8v?=
 =?utf-8?B?OGlidTlLd3lqQ3B0MjJjL1NCRTdCcnJEdml0RTBpYjhNMUlPN3RqYzlHcnVn?=
 =?utf-8?B?Qjk3dS93RCtHeEwrNExDQ3FOOFRpTGE2a3ZDVGdtcGt3eHk0eXQ0OGFneVFQ?=
 =?utf-8?B?M3p6aUpXMndjZnlFVndzbEhnNVpnRmRDR0Jnb3VuQzRzdVZwM2Z4NFpSWHlD?=
 =?utf-8?B?MUdtOUVGbmpKUFNZK1g1b09qVVdLVmJaeWMvYTV6Y3FoRDljdUptOEszTkFt?=
 =?utf-8?B?eStFelJnKzN0QkMvRWpFczVySERkTyswSGZKWGdLSThYWWZrYTJNZWNCbGlx?=
 =?utf-8?B?OTFEMWtIbnlNalJTL3AxRXcwdnIrMFJ6S2REckhtK1QzSDRSUllIenN6RGZu?=
 =?utf-8?B?bS9tdVhmTGV1ODR6aXlTWlJtMTBKRmZDRkRhYThsZVZ3U3lJNUdlZmJFakZZ?=
 =?utf-8?B?ODE3N05OaUNRaXhqK3VVaU53N09za1c2bGNGZEh6c2VBaStJY3d1TTlJMmJm?=
 =?utf-8?B?c05tMnFpbnBvV3VZcW1WUmp0OHpUYnZiTVBqUElrSS9TWmsremNpbGJqT0VR?=
 =?utf-8?B?bnJ1VVVveit0RzFaZnVkU210QWY0TEFzc3pLYlhMTmV6ZlpvNXFSdisySEYy?=
 =?utf-8?B?ai9nQmpOc0RGeFZWWkErQWJnOVhFSVRMT3ZwNHo3LytBbHdNbXZOcU5RTksz?=
 =?utf-8?B?QWR2SncyYVNXNEI4R1VHMm04cFFEZzlLK2JlWEVLcUxNRTI3YkZzRS9wdDhJ?=
 =?utf-8?B?alFhU1QyUE4zM0IxcVFDNlY3U3ZQRE94bml1OXQ1Y0JTVlN5Zms0S2sydHBV?=
 =?utf-8?B?VWRMYU1pY3N5eGNwRGRTQzZ2bG5EZFVBZXhaWXRqZHRFL3FjZ3dROWZFNWZh?=
 =?utf-8?B?R2Vud3NWWU1KOUkyMkI0QlMreDI4TWRJTFNiVHRaRGxSV1R5T3FNTkVZS0ds?=
 =?utf-8?Q?YpZN6gTe62PVOM6OOTS2aZA7W?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B77A9FDFCB97484BA42DEB0E05B76A54@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 469fc38a-28b7-49bb-f693-08da81b4d30c
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 07:31:26.0972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8T9iXNzkDAUCd9JeqJkhpICItXwDeGMKUE1sJxUis3k23UIIsCdG5tnB2ScJ9ko9UI274EzMk2+4HlY11AU8w3kJJaQkNHNK6eXQUtRiUcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6469
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTguMDguMjAyMiAxNjo1NywgQXJuZCBCZXJnbWFubiB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBGcm9tOiBBcm5kIEJlcmdtYW5uIDxhcm5kQGFy
bmRiLmRlPg0KPiANCj4gVGhpcyBpcyBub3cgZGVmYXVsdC1lbmFibGVkIHdoZW4gQ09ORklHX1NP
Q19TQU1BNyBpcw0KPiB1c2VkLCBzbyB0aGUgZGVmY29uZmlnIGVudHJ5IGNhbiBiZSBkcm9wcGVk
Lg0KPiANCj4gRml4ZXM6IGY2MTFhZjRjM2JmYSAoIkFSTTogYXQ5MTogS2NvbmZpZzogaW1wbGVt
ZW50IFBJVDY0QiBzZWxlY3Rpb24iKQ0KPiBTaWduZWQtb2ZmLWJ5OiBBcm5kIEJlcmdtYW5uIDxh
cm5kQGFybmRiLmRlPg0KDQpBY2tlZC1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVh
QG1pY3JvY2hpcC5jb20+DQoNCg0KPiAtLS0NCj4gIGFyY2gvYXJtL2NvbmZpZ3MvbXVsdGlfdjdf
ZGVmY29uZmlnIHwgMSAtDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2NvbmZpZ3MvbXVsdGlfdjdfZGVmY29uZmlnIGIvYXJjaC9h
cm0vY29uZmlncy9tdWx0aV92N19kZWZjb25maWcNCj4gaW5kZXggMWNiMjkzYWRlY2IxLi4yYjU2
NGRlZmUzM2UgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2NvbmZpZ3MvbXVsdGlfdjdfZGVmY29u
ZmlnDQo+ICsrKyBiL2FyY2gvYXJtL2NvbmZpZ3MvbXVsdGlfdjdfZGVmY29uZmlnDQo+IEBAIC0x
MDQ0LDcgKzEwNDQsNiBAQCBDT05GSUdfTVNNX01NQ0NfODk2MD15DQo+ICBDT05GSUdfTVNNX01N
Q0NfODk3ND15DQo+ICBDT05GSUdfSFdTUElOTE9DSz15DQo+ICBDT05GSUdfSFdTUElOTE9DS19R
Q09NPXkNCj4gLUNPTkZJR19NSUNST0NISVBfUElUNjRCPXkNCj4gIENPTkZJR19CQ00yODM1X01C
T1g9eQ0KPiAgQ09ORklHX1FDT01fQVBDU19JUEM9eQ0KPiAgQ09ORklHX1FDT01fSVBDQz15DQo+
IC0tDQo+IDIuMjkuMg0KPiANCg0K
