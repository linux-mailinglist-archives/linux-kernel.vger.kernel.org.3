Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8EC54AB9A
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239032AbiFNITq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235690AbiFNITo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:19:44 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC20B40E49;
        Tue, 14 Jun 2022 01:19:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655194782; x=1686730782;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=EmMvnuTjy5FOfEsTrAQLjeKDRSqzcx2Mtrq+qgCLs0A=;
  b=vdBt4rfNlCRRwIeLbTAvi5cSDDmBtAfBb85Ulg31AnN+HZeifqvBgOu6
   i3x0/cnjhh+VGbNxD5dUqJmPd3jW0Tu28Xx8VjrYHDGAjnbtkb6Qmezzg
   Wd/TUaQ7vqswT6v8LW1OnNQoMJXzxyP77QW9j9reGUo1f8e3JYH5ploxc
   p3Ape0J3HuvyJYKT28mXLixZTrp0ZH3QbGNREKZ5jVyTazyTCjdgS1gUR
   mXh28y/H31tUAYKVFxRHwvWR00UehWxg/fqO2D+Q5ATUAfg3atg/SYTCV
   P3XI6Yjexpc7S0D7hIwB4tD2mWNaS0NRLqiqxD6NwbUWcWOyP1XGuMzDk
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="177852618"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jun 2022 01:19:42 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 14 Jun 2022 01:19:41 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 14 Jun 2022 01:19:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AquRy8vpq9S8dllC+ZTbunEjfvDYO/Vg0VJYcofi617MUIpxJAcCIw+eHSdDbC6r2MGxgCppx9KMQr3lgQe2pHk2y/HbPLyDOKSnGpZTVdph9ow1GSJCjkq3uLCU6HkmGGLbRxIUoLDHkel4dtRcg55cD9Ejrh0u5RVUDZCMKYVL0zvz2BYlBL9j/xMC27NFu7a0vbkQVU9VPE3RsiKSx7E1OfSRF0kEqae3B8pN27I2zDw/QGn1xfiStf5Y0vX5omn37jT+KWoUPpKPEb8TWnyus7XfxyoaLHhv3Fc59Myz3lxhWbdjJlGtFy7f/CPp6lkr/y4FBhivWFmP/+nREw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EmMvnuTjy5FOfEsTrAQLjeKDRSqzcx2Mtrq+qgCLs0A=;
 b=GesmPe9uz3ptPvJ27/z8WSrudOc9jS/aaGpj3VqBqVMaK9kCZuqQhkd7CjLkSExQbHHqZfwt3p0lWf6C0snRX9PWbpl+/uDK5VvcISSW950UK1Pl73Mg5CvqLxyCVkHH68yuRaYiSqtCLnd/aCU26fgMj2tRffHne0YQJAhlQddazihdsChAHxst7u0F7Q7Q0Y2h/Ohd6EEqAoxkH3Fn8UGowEGy7fJB2x/n/0quPI5PPBdo43xaD3JDt9eDZBa0BT/Q06wAWsLC8VFndof14yfbLmqvmXHB69hwgk9vraxAPNT+bUofxWLczvlVl60R21x1zB82r02PK0V++J7vCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EmMvnuTjy5FOfEsTrAQLjeKDRSqzcx2Mtrq+qgCLs0A=;
 b=bnMaphWQP8ZZr1MxOwiScj6kOoE8x8qDmZvVhtRWN/ygK1mOTBld7il6mUyHPXMvThRn4ClVwew7oYG3jzkHGym1TSST8X9kK1OfBeNfUyuXh0a6xC9c2rbXZ0edudLUew4k3ZO/DSez45FvXCYYvVeLAYlc1uhEElOo566ny9A=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BN6PR11MB1698.namprd11.prod.outlook.com (2603:10b6:404:42::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Tue, 14 Jun
 2022 08:19:36 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5cfe:8088:aa93:fce8]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5cfe:8088:aa93:fce8%3]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 08:19:36 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <jic23@kernel.org>
CC:     <Eugen.Hristev@microchip.com>, <lars@metafoo.de>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <ludovic.desroches@atmel.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 02/16] iio: adc: at91-sama5d2_adc: lock around
 oversampling and sample freq
Thread-Topic: [PATCH 02/16] iio: adc: at91-sama5d2_adc: lock around
 oversampling and sample freq
Thread-Index: AQHYf8d7pN0ZTuk1yUS9W5Nq7HVSFg==
Date:   Tue, 14 Jun 2022 08:19:36 +0000
Message-ID: <3020793b-395d-c62e-febf-a7d553337da3@microchip.com>
References: <20220609083213.1795019-1-claudiu.beznea@microchip.com>
 <20220609083213.1795019-3-claudiu.beznea@microchip.com>
 <20220611183046.5515c001@jic23-huawei>
In-Reply-To: <20220611183046.5515c001@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 83f896a8-eabc-4b25-c6ca-08da4dde9e91
x-ms-traffictypediagnostic: BN6PR11MB1698:EE_
x-microsoft-antispam-prvs: <BN6PR11MB1698A854DFDCAEC49AD6968087AA9@BN6PR11MB1698.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wgXV/dwBTFHeAJcWVTE6vl5J9zjYNr1/hlKwS5W72LMVof/+6Hw84qjcD/HbmQpp9vv32ION/g7Vc0YD+9osaaOt2/GuLuHBrpZNSy89U9sv8/XVsg61zmHF2FRclwflHVNQYZoi4DKhaNZd1aDBTixtTcJY88bedKn8+9609VK4F1zK2KjK5WcrZon1AcaYk+QK2/WOd0Cx1rIKYhGDgvaBvZJEhxWdNl3SpryeonFbpVq5xSytd3yP8ffknE68qi8Q7T6o05rxLuAnDkOxZSivP3BLJKpZDRfsh3mg85N+vP0+31BVBwSv79gLk55E7o+iVMFmVE4Skvz3jmU69W5v1ru4x0juBiCGmL/Fl1lc8QMkM3uO8Yx1Kf+KZWE7lQlLygxMeigN87wbPEeUUWmvnlW6zGnI71msMq6OfbBuYLuTWEiQukZ/RkPt+xOg+dwBCRMUTZFo1DtCP0heGTBGlU47Av4lKUeCJ2tEzGIh7vd8QxOY7vBRmBGbAUfkT6qS0vMVdmAEW14gSkpHzKBvSrTEas8bq/CDzQp2tiywD+94hLs3nfaTgUzOepjoFN43IaNSPHvXxviYGEmZfPI1S2RqxtVNWHcxAqE3tnPLjw5LD9jSaFzpaQTJ6T6QuciZvDB6fRygLsSYVXZbMgWnih3V7LTS4xtC2aDRhnAKpIxjd7cQloITCsAJ4SYQT9iNqHXRF/exLHrgT2zJZBTqLvwN30Ni6GEKKqjsGZGDKnoqYnGnS4a1S3aRTqGGGR/dzpfin3WBh6NVeqXWew==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(66946007)(316002)(508600001)(6486002)(53546011)(91956017)(54906003)(6512007)(71200400001)(36756003)(86362001)(6916009)(5660300002)(8676002)(26005)(2616005)(2906002)(64756008)(4326008)(66446008)(66476007)(66556008)(31686004)(76116006)(7416002)(8936002)(31696002)(186003)(83380400001)(6506007)(38100700002)(122000001)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TENmYUN4YnVtWWZHZVF6T1BQZTM4bzYrODlPcmkwQldsQnpnclhZanlHWmVX?=
 =?utf-8?B?ZEJjNFRIOG5ZOHZJRnQ0OUFWTXBJV2VOVXBhOVZiSGpMaEJ4T293MGxpcklW?=
 =?utf-8?B?aXJGMzFLeHBLeGJHWDFJOXA5aEF5ME1MTDdxWmRFbjlLS0lhenF3Y0ZQZFZO?=
 =?utf-8?B?WXhTb0JJdWJ2SnkzZUUxTmZhNVZteGJ5TmUvTnlNTURGZTFIcnZUb0J1NHFL?=
 =?utf-8?B?L2NpRWVaRllqMmNYKzNtdkRHRkhOSzI2N1kzVDJoMjNTajVqODEzbTY0V1Nt?=
 =?utf-8?B?cmc3WGpyNmVHUW5RMGcwL3dGQlFOQTI3bldKNk5UQUdwa3dnTWlHM0tZVG9k?=
 =?utf-8?B?WVpXK3FZQ1kxSnpaY0ZGamlFTEtLRnVXdDIwOHhEVkxvUDk0a2xXWG4xRzFq?=
 =?utf-8?B?dTBBbitxZ0dGRFhqTGVJdlJ1RHJXSGZpRkdXU1IrTEVsQ2tKSDRyWER1UVJL?=
 =?utf-8?B?dG9NTGFTZXYvMlAvLzFMOEdiODFjaUxUL3FQQVFlMEhyZlZRUVRYK2xsaXdF?=
 =?utf-8?B?dk9UVGJrY1FyaHA3TWRLVTB0QUtiY0UwWXhPL255NlN2TDRIY0grN2lEQjZj?=
 =?utf-8?B?ZWNnaHc4YmhlWitIU3pSMktjM042VUg0V2REekRQMVJTSlBYWlBQanovVndp?=
 =?utf-8?B?TjMvQVFxZ0N5alhVeTl6SVcxRWR1K2dCQkJRNmVHZ0Iwd0NDU0dPc29OQzFX?=
 =?utf-8?B?ZHZYZDA4UXpJcWE0WERZYjlrUzVINFJkd3Jia1N0eXFpdUx0NVdPS2wxUU45?=
 =?utf-8?B?U0lGSVE3OU1oditXeFJaSVZaWjY0WnRJRDV4MUovQmJ6a3kvc041aWdrUE44?=
 =?utf-8?B?OGpoTVJpRFh5YmYyckNWUlMwV1p3UktTSGMvd3VweGNMVU9IMWhqVmhMYzhp?=
 =?utf-8?B?aFowYVBuSVZvYVAvdGFBcXZVMk0rMkJVRXpaQnV6TjBBNFRyY29Tdnd3YTQz?=
 =?utf-8?B?TWpBZXhMT29kaS8rellrV1hpdm56ay9wLzR3L2FLTjhNQm54Q0ZEUkNXSlhV?=
 =?utf-8?B?emJRWWZRTzlhcCsycEJhMGxyd3V3WDFxVmorYzllWUZ4OUoxTzAwam5CbDgz?=
 =?utf-8?B?eFVmMWUveWRIcnZmd21Na1NqK2NDUlJyemxtSXp2c05GMVAxdWZRUEhyWWFK?=
 =?utf-8?B?Y2Z0RzJMZkhFMmdhdWNaRDg0eXUwWnJXeXh2N2hhUVRHcEduOXFtM285MDRG?=
 =?utf-8?B?cU5Kc2tiUm1ZVjRrWU10Y2NOQzYvb0x2WDQ2d3pkYW1ocjIyajduM0Urd1hY?=
 =?utf-8?B?M1BtMGR1aG1nQWRzTzcvRFAzZCtSNGQ5SUh0NE9veXpWYVZrTXA2MTFET0Nh?=
 =?utf-8?B?V3N4blBFREZkdXpmUXpLQzFUMitac3RsRWtPRDA5MkxzcTM3UWRLR2ErQW5G?=
 =?utf-8?B?MnRFdU9aR2I2cm1pNXNqZDhxWEpxdkluT3pnaTJkYXhudE1xWllnVmJvK1pl?=
 =?utf-8?B?RmJaS3pIZjFhL0d4RVlhc3RkakFYSTBVSzk3TlBqSUVRWTFXNmdyeXBzSWM0?=
 =?utf-8?B?Z1VoYUxCdDJKL1VoQmV3SGwzNjZsMFpRZExKTXZ0UURQZDZKUWg4RmhJWGlV?=
 =?utf-8?B?MHRnQWl4c0xKNTZ6SVFpU1JYWnVjaml3OURZTjJnWEtCRGdhNldqK3p6akFZ?=
 =?utf-8?B?eVdrM2FxektjWG9Tc3VYMC9DeHdpVlB0ZUNpTEx3T2doeHJreDNkcWIvdUVD?=
 =?utf-8?B?N09BdmhUdEdxcW10Snl1V2dyR0NVZ3JicjJYTndpbGhhSllrcHRtbFhVanZl?=
 =?utf-8?B?MUlIMGdoeDNHY1RNcXJGY2UwNk5LSDJRcStCYWxTaTFJSUVDL1BKWmJiYVpX?=
 =?utf-8?B?c1kxZzRsV1E2c3dIZTlaTU5BYzNxZ0F1dzFVU1VXOEllNDR2eG9TYlRueUp1?=
 =?utf-8?B?cDNKdzZZQmQwU0RJMFNEYTk1TEtRN1BmOGVlZDIwMm1zL0JwVlhybU5XQ0k5?=
 =?utf-8?B?YmpVZzRzejdta1ZhT25BN3VuZnBsRWp2bWxKdXk4TGxpOWp2a3JPQUpZb2Ru?=
 =?utf-8?B?OXJnZXZMVk1PZ09naEw5Zm5mZVE3ZEY1b2hnMTYzUjhqcXZnRWxZQmtBN096?=
 =?utf-8?B?K2FhVWwyZTFpakNiRWtOakNwQTBwSnBTY1VWTk15TFJxazZTUG5VVlc2SlZw?=
 =?utf-8?B?aFdNVENvT1N0d2VrOGR1cUI2UWI0bzV3dEt0OWg2YzJCYmhEb2tjanFvYVZq?=
 =?utf-8?B?OUsrVXo1Wjg2NHE2T1NQN2YvSDV4OGl6YU1WaDM4aHk0Q3NLQ3dURkh5NU1x?=
 =?utf-8?B?RDk5d3NMZEFzREN5S1dDZndMdDU3UWFjU3Y0VFZTTzhWS1lUWms1M0d3UnVy?=
 =?utf-8?B?V2ZIMmNwL3VvalMwaVQ5U0J5S1dnZFVsR3pVOERJb29sVi9sYTNub0h5TUtt?=
 =?utf-8?Q?yXQDNr/VvKkiWHfQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D66795BED0C03C47B98208CEB4DC3190@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83f896a8-eabc-4b25-c6ca-08da4dde9e91
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 08:19:36.4466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: evHFPpGfkaYnGQyKv0Fu1VX36KmT04Pg3dijzCkcmZeL95b755rEFgZ9JOUof6aqymBDvbBJJbJJfsDal7g5OKdWSUfEWfT/jH1iDVjwzB8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1698
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEuMDYuMjAyMiAyMDozMCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUaHUsIDkgSnVuIDIwMjIgMTE6MzE6
NTkgKzAzMDANCj4gQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+
IHdyb3RlOg0KPiANCj4+IC5yZWFkX3JhdygpLy53cml0ZV9yYXcoKSBjb3VsZCBiZSBjYWxsZWQg
YXN5bmNocm9ub3VzbHkgZnJvbSB1c2VyIHNwYWNlDQo+PiBvciBvdGhlciBpbiBrZXJuZWwgZHJp
dmVycy4gV2l0aG91dCBsb2NraW5nIG9uIHN0LT5sb2NrIHRoZXNlIGNvdWxkIGJlDQo+PiBjYWxs
ZWQgYXN5bmNocm9ub3VzbHkgd2hpbGUgdGhlcmUgaXMgYSBjb252ZXJzaW9uIGluIHByb2dyZXNz
LiBSZWFkIHdpbGwNCj4+IGJlIGhhcm1sZXNzIGJ1dCBjaGFuZ2luZyByZWdpc3RlcnMgd2hpbGUg
Y29udmVyc2lvbiBpcyBpbiBwcm9ncmVzcyBtYXkNCj4+IGxlYWQgdG8gaW5jb25zaXN0ZW50IHJl
c3VsdHMuIFRodXMsIHRvIGF2b2lkIHRoaXMgbG9jayBzdC0+bG9jay4NCj4gDQo+IFRoZSBwYXRj
aCBtYWtlcyBzZW5zZSwgYnV0IEknbSBub3QgY29udmluY2VkIGFsbCBvZiB0aGUgY2hhbmdlcyBi
ZWxvdw0KPiBpbnZvbHZlIGFueSBjaGFuZ2VzIHRvIHJlZ2lzdGVycy4gRS5nLiBhdDkxX2FkY19h
ZGp1c3RfdmFsX29zcigpDQo+IGlzIHVzaW5nIHRoZSBjYWNoZWQgdmFsdWUgb2Ygc29tZXRoaW5n
IGluIGEgcmVnaXN0ZXIsIGJ1dCBub3QgdGhlDQo+IHJlZ2lzdGVyIGl0c2VsZiwgc28gcGxlYXNl
IHVwZGF0ZSB0aGUgZGVzY3JpcHRpb24gdG8gbWVudGlvbiBjYWNoZWQgc3RhdGUuDQo+IA0KPiBP
dGhlciBjb21tZW50cyBpbmxpbmUuDQo+Pg0KPj4gRml4ZXM6IDI3ZTE3NzE5MDg5MSAoImlpbzph
ZGM6YXQ5MV9hZGM4eHg6IGludHJvZHVjZSBuZXcgYXRtZWwgYWRjIGRyaXZlciIpDQo+PiBGaXhl
czogNjc5NGUyM2ZhM2ZlICgiaWlvOiBhZGM6IGF0OTEtc2FtYTVkMl9hZGM6IGFkZCBzdXBwb3J0
IGZvciBvdmVyc2FtcGxpbmcgcmVzb2x1dGlvbiIpDQo+PiBTaWduZWQtb2ZmLWJ5OiBDbGF1ZGl1
IEJlem5lYSA8Y2xhdWRpdS5iZXpuZWFAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gIGRyaXZl
cnMvaWlvL2FkYy9hdDkxLXNhbWE1ZDJfYWRjLmMgfCAxNyArKysrKysrKysrKysrKy0tLQ0KPj4g
IDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4NCj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvYXQ5MS1zYW1hNWQyX2FkYy5jIGIvZHJpdmVy
cy9paW8vYWRjL2F0OTEtc2FtYTVkMl9hZGMuYw0KPj4gaW5kZXggMzJiNmYxNTdiODAzLi5hNjcy
YTUyMGNkYzAgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2lpby9hZGMvYXQ5MS1zYW1hNWQyX2Fk
Yy5jDQo+PiArKysgYi9kcml2ZXJzL2lpby9hZGMvYXQ5MS1zYW1hNWQyX2FkYy5jDQo+PiBAQCAt
MTU0MiwxMCArMTU0MiwxMSBAQCBzdGF0aWMgaW50IGF0OTFfYWRjX3JlYWRfaW5mb19yYXcoc3Ry
dWN0IGlpb19kZXYgKmluZGlvX2RldiwNCj4+ICAgICAgICAgICAgICAgcmV0ID0gYXQ5MV9hZGNf
cmVhZF9wb3NpdGlvbihzdCwgY2hhbi0+Y2hhbm5lbCwNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAmdG1wX3ZhbCk7DQo+PiAgICAgICAgICAgICAgICp2YWwg
PSB0bXBfdmFsOw0KPj4gKyAgICAgICAgICAgICByZXQgPSBhdDkxX2FkY19hZGp1c3RfdmFsX29z
cihzdCwgdmFsKTsNCj4+ICAgICAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZzdC0+bG9jayk7DQo+
PiAgICAgICAgICAgICAgIGlpb19kZXZpY2VfcmVsZWFzZV9kaXJlY3RfbW9kZShpbmRpb19kZXYp
Ow0KPj4NCj4+IC0gICAgICAgICAgICAgcmV0dXJuIGF0OTFfYWRjX2FkanVzdF92YWxfb3NyKHN0
LCB2YWwpOw0KPj4gKyAgICAgICAgICAgICByZXR1cm4gcmV0Ow0KPj4gICAgICAgfQ0KPj4gICAg
ICAgaWYgKGNoYW4tPnR5cGUgPT0gSUlPX1BSRVNTVVJFKSB7DQo+PiAgICAgICAgICAgICAgIHJl
dCA9IGlpb19kZXZpY2VfY2xhaW1fZGlyZWN0X21vZGUoaW5kaW9fZGV2KTsNCj4+IEBAIC0xNTU2
LDEwICsxNTU3LDExIEBAIHN0YXRpYyBpbnQgYXQ5MV9hZGNfcmVhZF9pbmZvX3JhdyhzdHJ1Y3Qg
aWlvX2RldiAqaW5kaW9fZGV2LA0KPj4gICAgICAgICAgICAgICByZXQgPSBhdDkxX2FkY19yZWFk
X3ByZXNzdXJlKHN0LCBjaGFuLT5jaGFubmVsLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICZ0bXBfdmFsKTsNCj4+ICAgICAgICAgICAgICAgKnZhbCA9IHRt
cF92YWw7DQo+PiArICAgICAgICAgICAgIHJldCA9IGF0OTFfYWRjX2FkanVzdF92YWxfb3NyKHN0
LCB2YWwpOw0KPj4gICAgICAgICAgICAgICBtdXRleF91bmxvY2soJnN0LT5sb2NrKTsNCj4+ICAg
ICAgICAgICAgICAgaWlvX2RldmljZV9yZWxlYXNlX2RpcmVjdF9tb2RlKGluZGlvX2Rldik7DQo+
Pg0KPj4gLSAgICAgICAgICAgICByZXR1cm4gYXQ5MV9hZGNfYWRqdXN0X3ZhbF9vc3Ioc3QsIHZh
bCk7DQo+PiArICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+PiAgICAgICB9DQo+Pg0KPj4gICAg
ICAgLyogaW4gdGhpcyBjYXNlIHdlIGhhdmUgYSB2b2x0YWdlIGNoYW5uZWwgKi8NCj4+IEBAIC0x
NjIwLDExICsxNjIyLDE1IEBAIHN0YXRpYyBpbnQgYXQ5MV9hZGNfcmVhZF9yYXcoc3RydWN0IGlp
b19kZXYgKmluZGlvX2RldiwNCj4+ICAgICAgICAgICAgICAgcmV0dXJuIElJT19WQUxfRlJBQ1RJ
T05BTF9MT0cyOw0KPj4NCj4+ICAgICAgIGNhc2UgSUlPX0NIQU5fSU5GT19TQU1QX0ZSRVE6DQo+
PiArICAgICAgICAgICAgIG11dGV4X2xvY2soJnN0LT5sb2NrKTsNCj4+ICAgICAgICAgICAgICAg
KnZhbCA9IGF0OTFfYWRjX2dldF9zYW1wbGVfZnJlcShzdCk7DQo+IA0KPiBTbyB0aGlzIGlzIGEg
c3RyYWlnaHQgcmVhZCBvZiBhIGNhY2hlZCB2YWx1ZS4gIFRoZSBvbmx5IHRoaW5nIHlvdSAnbWln
aHQnDQo+IGFyZ3VhYmx5IGJlIHByb3RlY3RpbmcgYWdhaW5zdCBpcyByZWFkL3dyaXRlIHRlYXJp
bmcgZHVlIHRvIGl0IGluIHRoZW9yeQ0KPiBiZWluZyBwb3NzaWJsZSB0byB3cml0ZSBwYXJ0IG9m
IHRoZSB2YWx1ZSB3aGlsc3QgcmVhZGluZy4gIA0KDQpZZXMsIGZvciB0aGVzZSBraW5kIG9mIHNj
ZW5hcmlvcyBJIGtlcHQgdGhlIGxvY2sgYXJvdW5kIGNhY2hlZCB2YWx1ZXMsIHRvby4NCg0KPiBJ
IGRvbid0DQo+IHNlZSB0aGF0IGJlaW5nIGEgY29uY2VybiBmb3Igc3QtPmN1cnJlbnRfc2FtcGxl
X3JhdGUNCg0KSSBhbSBub3QgZnVsbHkgYXdhcmUgb2YgYWxsIHRoZSB1c2VyIHNwYWNlIHRvb2xz
IHRoYXQgYXJlIHJldHJpZXZpbmcgdGhpcw0KYW5kIGhvdyB0aGlzIGlzIHVzZWQgYW5kIHRodXMg
SSBrZXB0IHRoZSBsb2NrIGFsc28gYXJvdW5kIHRoZSBjYWNoZWQgdmFsdWVzDQp0byBwcm90ZWN0
IHRoZSB1c2VyIHNwYWNlIHRvb2xzIGJlaW5nIHBvbGx1dGVkIHdpdGggd3JvbmcgdmFsdWVzLCBp
ZiBhbnkuDQoNCj4gDQo+PiArICAgICAgICAgICAgIG11dGV4X3VubG9jaygmc3QtPmxvY2spOw0K
Pj4gICAgICAgICAgICAgICByZXR1cm4gSUlPX1ZBTF9JTlQ7DQo+Pg0KPj4gICAgICAgY2FzZSBJ
SU9fQ0hBTl9JTkZPX09WRVJTQU1QTElOR19SQVRJTzoNCj4+ICsgICAgICAgICAgICAgbXV0ZXhf
bG9jaygmc3QtPmxvY2spOw0KPj4gICAgICAgICAgICAgICAqdmFsID0gc3QtPm92ZXJzYW1wbGlu
Z19yYXRpbzsNCj4gTGlrZXdpc2UsIHdoYXQgYXJlIHlvdSBwcm90ZWN0aW5nIGFnYWluc3QgcmFj
aW5nIHdpdGggdGhpcyB0aGF0IGNhbid0DQo+IGp1c3Qgb2NjdXIgYmVmb3JlIG9yIGFmdGVyIHRo
ZSBsb2NrPw0KDQpTYW1lIGFzIGFib3ZlLg0KDQo+IA0KPj4gKyAgICAgICAgICAgICBtdXRleF91
bmxvY2soJnN0LT5sb2NrKTsNCj4+ICAgICAgICAgICAgICAgcmV0dXJuIElJT19WQUxfSU5UOw0K
Pj4NCj4+ICAgICAgIGRlZmF1bHQ6DQo+PiBAQCAtMTY0NCwxOCArMTY1MCwyMyBAQCBzdGF0aWMg
aW50IGF0OTFfYWRjX3dyaXRlX3JhdyhzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2LA0KPj4gICAg
ICAgICAgICAgICAgICAgKHZhbCAhPSBBVDkxX09TUl8xNlNBTVBMRVMpKQ0KPj4gICAgICAgICAg
ICAgICAgICAgICAgIHJldHVybiAtRUlOVkFMOw0KPj4gICAgICAgICAgICAgICAvKiBpZiBubyBj
aGFuZ2UsIG9wdGltaXplIG91dCAqLw0KPj4gKyAgICAgICAgICAgICBtdXRleF9sb2NrKCZzdC0+
bG9jayk7DQo+PiAgICAgICAgICAgICAgIGlmICh2YWwgPT0gc3QtPm92ZXJzYW1wbGluZ19yYXRp
bykNCj4+IC0gICAgICAgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4gSXQgc2hvdWxkIGJlIHJh
Y2UgZnJlZSB0byBjaGVjayB0aGlzIG91dHNpZGUgdGhlIGxvY2suDQo+IA0KPiBEZWZpbml0ZWx5
IHZhbGlkIHRvIGxvY2sgYXJvdW5kIHRoZSBjYWNoZWQgdmFsdWUgd3JpdGUgYW5kIHRoZSBjb25m
aWcNCj4gd3JpdGUgdGhvdWdoLg0KPiANCj4+ICsgICAgICAgICAgICAgICAgICAgICBnb3RvIHVu
bG9jazsNCj4gSWYgeW91IGRpZCB3YW50IHRvIGhhdmUgbG9ja2luZyBhcyBub3cgdGhlbiBmbGlw
IHRoZSBsb2dpYw0KPiANCj4gICAgICAgICAgICAgICAgIGlmICh2YWwgIT0gc3QtPm92ZXJzYW1w
bGluZ19yYXRpbykgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICBzdC0+b3ZlcnNhbXBsaW5n
X3JhdGlvID0gdmFsOw0KPiAgICAgICAgICAgICAgICAgICAgICAgICBhdDkxX2FkY19jb25maWdf
ZW1yKHN0KTsNCj4gICAgICAgICAgICAgICAgIH0NCj4gICAgICAgICAgICAgICAgIG11dGV4X3Vu
bG9jaygpDQo+IC4uDQo+IA0KDQpPSywgdGhhbmtzIQ0KDQo+IEdvdG8gYWx3YXlzIGhhdmUgYSBj
b3N0IGluIHJlYWRhYmlsaXR5IHNvIGlmIHlvdSBjYW4gYXZvaWQgdGhlbSB3aXRoDQo+IGEgc2lt
cGxlIGZsaXAgb2YgbG9naWMgbGlrZSB0aGlzIGl0IGlzIHVzdWFsbHkgYSBnb29kIGlkZWEuDQo+
IChleGNlcHRpb24gaXMgZXJyb3IgY29kZSB3aGljaCBzaG91bGQgYWx3YXlzIGJlIG91dCBvZiBs
aW5lIGFzDQo+IHRoYXQgaXMgbW9yZSBjb21tb24gc28gd2hhdCB3ZSBleHBlY3QgdG8gc2VlKS4N
Cj4gDQo+PiAgICAgICAgICAgICAgIHN0LT5vdmVyc2FtcGxpbmdfcmF0aW8gPSB2YWw7DQo+PiAg
ICAgICAgICAgICAgIC8qIHVwZGF0ZSByYXRpbyAqLw0KPj4gICAgICAgICAgICAgICBhdDkxX2Fk
Y19jb25maWdfZW1yKHN0KTsNCj4+ICt1bmxvY2s6DQo+PiArICAgICAgICAgICAgIG11dGV4X3Vu
bG9jaygmc3QtPmxvY2spOw0KPj4gICAgICAgICAgICAgICByZXR1cm4gMDsNCj4+ICAgICAgIGNh
c2UgSUlPX0NIQU5fSU5GT19TQU1QX0ZSRVE6DQo+PiAgICAgICAgICAgICAgIGlmICh2YWwgPCBz
dC0+c29jX2luZm8ubWluX3NhbXBsZV9yYXRlIHx8DQo+PiAgICAgICAgICAgICAgICAgICB2YWwg
PiBzdC0+c29jX2luZm8ubWF4X3NhbXBsZV9yYXRlKQ0KPj4gICAgICAgICAgICAgICAgICAgICAg
IHJldHVybiAtRUlOVkFMOw0KPj4NCj4+ICsgICAgICAgICAgICAgbXV0ZXhfbG9jaygmc3QtPmxv
Y2spOw0KPj4gICAgICAgICAgICAgICBhdDkxX2FkY19zZXR1cF9zYW1wX2ZyZXEoaW5kaW9fZGV2
LCB2YWwpOw0KPj4gKyAgICAgICAgICAgICBtdXRleF91bmxvY2soJnN0LT5sb2NrKTsNCj4+ICAg
ICAgICAgICAgICAgcmV0dXJuIDA7DQo+PiAgICAgICBkZWZhdWx0Og0KPj4gICAgICAgICAgICAg
ICByZXR1cm4gLUVJTlZBTDsNCj4gDQoNCg==
