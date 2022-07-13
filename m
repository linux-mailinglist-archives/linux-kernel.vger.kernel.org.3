Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B81C45730B9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 10:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235372AbiGMIPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 04:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbiGMIOR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 04:14:17 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA65EBBC2;
        Wed, 13 Jul 2022 01:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657699981; x=1689235981;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=v95+y1YIXCGlwO3l5/Hv9D8rhBuUDsUfOZpGnQ62Q9Y=;
  b=JHFttXDDeF/1xRWNmO5Zw5b6IGp9VuRK715MpYDgEm3G6ill+y65a1yd
   HcKns+WXcDmsRqYdH1KzQ6bmYgASuLHXJXP5DdKH1o513Ya4Ci/PmHWpb
   DbG4o9ZggmdUy+sy9GkCD6ubPBFDJx2PfqV8lk3iA0a1t+19HhPNIF+4i
   iSgA4VSBRAoxoP8j13A1PNDgNTQZgq5tYhim1SbvERIxNKw0P35y0p/uv
   MekpaACojUvHEDRPHb44F5wBpjbTS/Ou4T6aujyZcW4AqsDJMqRAYklZg
   bPTLoSCVZtHDBseYdZTMke2QSZ77KBxjo6PYbbxtzByCEWc2D6fi8NNkh
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,267,1650956400"; 
   d="scan'208";a="167601443"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 13 Jul 2022 01:13:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 13 Jul 2022 01:12:58 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Wed, 13 Jul 2022 01:12:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STJDpXPwur0wdA6XDv3w9RGy7a5WAwbNIPzDF245O1VM3fOTXqw87rRI7s9dyZhhL2GHT3ZeCX7aOcOREs6KNBkEG5qEAHRVfRrR1nlisKkd/0q40QQUTAYd/IPhNfv4wgnhQUServdR62a0MpAC0aw8RTevHRutFMrkYYPSvGUqTwC1hK0qk77PjggXdj/ZIv1SKLTfA1dETshxH0HzaPuvC/rg48Piwgs6VeDsJJ4bpNI5C8405xI/h4Gk3q7g3uJdtXalnnrCL5pXm5sAFhmsOQQAc9PGAZKNvB24bXHdT6Qwar9sYqP517FZ2K+4F7NjY4LSo5IqtY062/MFCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v95+y1YIXCGlwO3l5/Hv9D8rhBuUDsUfOZpGnQ62Q9Y=;
 b=RlF2ZV9AQdNf+3TCL/vyUOjn88NYZI8aNjTnMmTe1TRJi24eHXSFCUoL6VeoAQlVuMERVsEiTpE1CjGwjyzB+tWJjvu5GyKULeeokA9L1+dyPzOf7lyzEoXHtv1ctD1/tIiJ3fTFtgVePBVYBJqa8j7UdEYJtPKhsZ3M6uhcobuIJ/tx5EWnJuLD2xStdx/WTpw80qHm0ObUlR/KJNg8vxkfBUUvYX4s7NdRXR/bnnH89Y9rjN//jMfOZ2EfNrNwyRAgKEDzDD++zjadAl8t3NzgY1ljBSDHDHmjKaKHZiVBYfQsk887q1stJWje1YoPBeMPKSpe7xezcOJ+PI9wGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v95+y1YIXCGlwO3l5/Hv9D8rhBuUDsUfOZpGnQ62Q9Y=;
 b=T/D/gEDh9Po2CGi374bTfoqVcYuoNSYrOupb1Gssj/KlEDrgi11bQETt9+rk0n4Bsxk7iYXu1I+JqSKkNeKzIjERvyPkL8G9HtjwOQ55iarxPw1sNsAIijAEN14i8Awmsa7eh9tdC/eCW9eyX4pTPpPItujpVH4rX3E2khJoe+I=
Received: from BYAPR11MB2758.namprd11.prod.outlook.com (2603:10b6:a02:c9::11)
 by DM4PR11MB5373.namprd11.prod.outlook.com (2603:10b6:5:394::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Wed, 13 Jul
 2022 08:12:53 +0000
Received: from BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::6852:5740:4bc9:d1b4]) by BYAPR11MB2758.namprd11.prod.outlook.com
 ([fe80::6852:5740:4bc9:d1b4%7]) with mapi id 15.20.5438.012; Wed, 13 Jul 2022
 08:12:53 +0000
From:   <Sergiu.Moga@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Claudiu.Beznea@microchip.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <Kavyasree.Kotagiri@microchip.com>,
        <UNGLinuxDriver@microchip.com>, <Tudor.Ambarus@microchip.com>
Subject: Re: [PATCH v3] spi: dt-bindings: atmel,at91rm9200-spi: convert to
 json-schema
Thread-Topic: [PATCH v3] spi: dt-bindings: atmel,at91rm9200-spi: convert to
 json-schema
Thread-Index: AQHYlgxnceq8Q7huJEqVFSn4N5xWeK167ckAgAEG0AA=
Date:   Wed, 13 Jul 2022 08:12:53 +0000
Message-ID: <134b2da3-9f6d-2769-f9d4-33e62b3e1262@microchip.com>
References: <20220712162554.148741-1-sergiu.moga@microchip.com>
 <dc26dd92-c107-bb8d-b40d-71b3568c52e5@linaro.org>
In-Reply-To: <dc26dd92-c107-bb8d-b40d-71b3568c52e5@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7e30240f-8dca-4dd8-c0e3-08da64a77c4a
x-ms-traffictypediagnostic: DM4PR11MB5373:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kWsxOs0vt2tbz9Q8FS5jqXmUhyD3JoGOeacHG7IVApeSwlxam0hQbnJql1SV8AZEpf0DRIdghN06zlInuIYNEcTvR+XR14aBuuYzh6sh6dyPbpHKCbOA8Kjd0pYl0ngK1qXu86apRarxsyVkQbzDCZLVWNJs3UvagKaA+e1vGYVfsRddCFUIzZpphW7fqQHgArBWk6+U6J7zWDiU7p5ox07pC8CH+zCXDy+qqYAwc1jl3Mpn0PW7Pl73Wpb3LcTjsKKK4Z+k6XZ+i9YeRwHZysr8PeAtrA3Dyjx+HEUl0gpkWmMH8Qy64kpIuBPpt2c0uRm8eyZiJ3HpH5ixE9su+vYFKzvlOzEMuipLg1ekZ3Gny16/SYSprlfdZSYL8W3mFO8XMz0tC1M5884WeYZI4AvtMpo0tXT9RDUjyD2DvluLSXp8le3/KPIW8byTmdGXP3vg/S7su71I3hssOVfubaLUKmUqE7NwlxGpR+XrD5PRNwEacP5rIPatv//u5avBZEycHg0A2ZaDs0URhrMAtlqbHsOJN7h1h250WUdSx8Nd2ApV6XtdCZ5du2UtVeKRtPW3aFP1/4cUMb6jy6o5fAV+56XhMsckAxDcFFsf6hXryFJ6DNmL2HNG3+gNK9GBBDQfP1Ur0CvbICDPAWSoLy/j3Z34GFoV+toV+9+xrUhpdXicdOCPecRnERWoPvkqHFUDEj77wVGSgJrnp8cNc/3qUKMeCDCKz5LSnQBDeP62XPFnFpgwI1A8bOokecNK03ugMPfYB5aMnkpyTnTI1Y8paGKz4aKCipam+ycmuBkQ7IiE7i5JaQbRJoJ6LCroIf72AKFTPggicla47UwV7f8BP89iDwxB9eUStjarkzS1FCydf18iGkl6sf963XZYijDy0mJH1R1CA/Z7WMM8acPu3QJny7fSXf8I19mHXSU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB2758.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(136003)(346002)(396003)(366004)(6636002)(6506007)(316002)(54906003)(26005)(6512007)(478600001)(66556008)(110136005)(38100700002)(64756008)(91956017)(66446008)(966005)(71200400001)(36756003)(76116006)(41300700001)(66946007)(31686004)(107886003)(53546011)(66476007)(8936002)(2616005)(4326008)(122000001)(8676002)(31696002)(38070700005)(186003)(86362001)(2906002)(5660300002)(6486002)(83380400001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZmVhZUtmQjQwWEhxVmtraHdaSEdqK2RvZ29taUJLeU9vQUZTVGdVc1RUNlZm?=
 =?utf-8?B?TkpJZGYvdlJvZGVONFo0QkJ1dnR2ZUpVeFNnUWtNcHR2Y3A1dmJPd1FXQlBy?=
 =?utf-8?B?OGwwQjBHUHRtcDlNSC9qWjFCQlFNbXUveE1xbjNEazBtdnRDTmlkcW45OTNZ?=
 =?utf-8?B?ZUs2eHhpK2kyQU52bDIyR2U2OWt0a3NtQmMyWjlCbE84UmdZUEhPcm9MRWF4?=
 =?utf-8?B?Q2Y5ejB6UGJMa0dCYU1CdzI4a0Y3cGdKMWxOeVRsUWIycUM2NkFGeWNFbzVT?=
 =?utf-8?B?T1QwZVFaOGM2OENIOHJkSzJpL0tWeDR3YWUvY29EL0MvbFZEUm9BeVZFZThY?=
 =?utf-8?B?OGszZXJQQWl0MHUwRmg0bHNDTnJTam5RWkVRRUpyLzhjK3BTSHJJTWJ5V1BH?=
 =?utf-8?B?WDNadUcrUkhjK2lyWm1tYmY3VmdaTnlOd3BzdnBBWVp1VUkxZit4UTRxd0Vs?=
 =?utf-8?B?VU1kVjJOTTFrR3RGdFdrRERMRlhqN2dRa3ZxR3MyUjlPcElOcG82UHViZ3NP?=
 =?utf-8?B?VWdWbmVNbFRzWFdGMEs5aGk1aENhU1FYZVJhK2V2cHRHL0xHbzd6YnZ0c2px?=
 =?utf-8?B?d25uRE13dUFwZGZGL2sxaTFHUS9wbk85dlFmRGt2RjdlUDVqbCs2aVV2TXFR?=
 =?utf-8?B?a0VFQlZIajJXcjh2a1pOL1Y0M0psVTZhTzhZTFQvcGRmOWlvZXBTSjdYVWZ4?=
 =?utf-8?B?NGRta2ZPNGpFWjdHemdqaUFmUmpUZlBJRE8rUjg2aEFKdThsa0pyRVE2aW1B?=
 =?utf-8?B?QkFINGFGSk9jZzRJdGxQaEp6ZDZiTDVsZVNwUVo4UFpqb3FpMUpWdWRFS0tL?=
 =?utf-8?B?cnRob2dGSGFlL1hUV0Vpa3kzUVNhdG5XQ1R3bCtIMmp3UGQ5MlBjKzlVWjJp?=
 =?utf-8?B?R0xWcGlaampuOHZ5VE51dlEyMTRnRSt4SjVIV3kwalZUZm5BUGxUdXJDNGpD?=
 =?utf-8?B?dVo3ZGpYcFcyYy9DanRuQ1Z6aDRhTVc2b1BuUXlwaXhEWkJDRVhQaW9ibFhD?=
 =?utf-8?B?R3hBaVFWUWxLTWk4ZnpMNXRoYnlZNjRiN0NnaTFLWXh4anZOMmlUelB3WnZw?=
 =?utf-8?B?aytQSnhzQ0FjZ1VnN3Uwc3Q4YmFmOGxXR2JaNTc0RmdFekpkaDVod2lISGxI?=
 =?utf-8?B?VC95Ymp3Um56YmQrQUM4bjFZa0txQkZ0YTZmYmF1RHA5M2FrZVVFTzQwSERk?=
 =?utf-8?B?L1NkL0ljdU9FNFV5bGhBVjNtdm1Za0pjV2VqbTZVd2RGR1BFZ2xmMzZ6NGJ6?=
 =?utf-8?B?U05HdUowWkZJRkdialRScGNhZDQ5SHFjUk5CVnhFdm82cElaZ0hpbmhtcTdm?=
 =?utf-8?B?cm44bFZabngvRjRrNkEvZHlBbENvbnhDTzhGanhLdjJ0Z3lndm5QVFN4QnRl?=
 =?utf-8?B?YVBqcGo4WjhIYmt2M3M3b2ptTzMvU1drdW5Fb29lWCsrQVpQUERPK082VkFE?=
 =?utf-8?B?ZGVYWHo5cWFMaWhWM0YzbjA4NFNNQ3B3ZFBYNWR1Q09EOVBobnVnZW1hZ2Jw?=
 =?utf-8?B?N3JLcW1EWE5QdE5ycUFXTGF0V3hqRGtUaTI1TG1mb1gyeDRUQ2Y3bHdzWHFw?=
 =?utf-8?B?ZHNON2t0MklVSUovWTVOcmZkS2JuK3BEQndsSjE1Z3c0TTY2amdQL01ZcWRV?=
 =?utf-8?B?TmdJdEsrSHZIMFluSFBnVHFvTURxenhYTDFnTmphcUZMenNEMHIxb085WkNr?=
 =?utf-8?B?d2l2bzBoMkJtRTFHR0xYc2NUOTZwSFVzQmdncFhEZTFqQTFKalc0dVV2YVVL?=
 =?utf-8?B?SjQvY0FyTlBwYWxuQTNTM3FUdE9HMEUwdHFPTWVDQTZpWm9qWXpEbTYvN3BD?=
 =?utf-8?B?OG9STHRPdHRkaDIxZ1FGWHBYK1NkdWUvMHBJcGczZjJIK0JKMGphMHdWR2ps?=
 =?utf-8?B?V2Zjck00bFlnNHZKaHdaYzlvWUsrdmVObDFrNTh6K3dDM3BVLzVBeW5RNGky?=
 =?utf-8?B?V0J4SFFHNjFZT1NFOFFVUndZK083WU9naytBczl5dTgvem5FOE9OSUprSzNT?=
 =?utf-8?B?UkpEMndGdWxUUUlBN0E0QVprT3BjdXJVQzBzWEE4dzVkWWNtMEx6UGJ3R1hY?=
 =?utf-8?B?Vy9CZHBDck5lcDgzL3FKbDQ1NUhFWkNGWGcvSnpLZkFJc0ZnWnJTTmlyd0Zy?=
 =?utf-8?B?Myt4eHk3aTVYZ1N6aDRMQjFqcktPd1puU2ZVcUQ0UTBaNFVtUERwTHNsU2pX?=
 =?utf-8?B?UFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A80A45DD6DA31144A5498FFC2E825FB3@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB2758.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e30240f-8dca-4dd8-c0e3-08da64a77c4a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 08:12:53.3780
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CPSbGEMPxicUQioeR9uZ8FsgL7rJKJeE6q0q8s2Vp9UIhEiTmCINLwtxuMVKbA5ITKpKv/I/cvJPgY39GNjIyqRAP4bVOcrT8t3OAfmo3ME=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5373
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIuMDcuMjAyMiAxOTozMiwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gT24gMTIv
MDcvMjAyMiAxODoyNSwgU2VyZ2l1IE1vZ2Egd3JvdGU6DQo+PiBDb252ZXJ0IFNQSSBEVCBiaW5k
aW5nIGZvciBBdG1lbC9NaWNyb2NoaXAgU29DcyB0byBqc29uLXNjaGVtYS4NCj4+DQo+PiBTaWdu
ZWQtb2ZmLWJ5OiBTZXJnaXUgTW9nYSA8c2VyZ2l1Lm1vZ2FAbWljcm9jaGlwLmNvbT4NCj4+IFJl
dmlld2VkLWJ5OiBLcnp5c3p0b2YgS296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFy
by5vcmc+DQo+PiAtLS0NCj4+DQo+PiB2MSAtPiB2MjoNCj4+IC0gY2hhbmdlIHN1YmplY3QgaGVh
ZGxpbmUgcHJlZml4IGZyb20gImR0LWJpbmRpbmdzOiBzcGkiIHRvICJzcGk6IGF0bWVsIg0KPj4g
LSBjaGFuZ2UgbWFpbnRhaW5lcg0KPj4gLSBrZXB0IHRoZSBjb21wYXRiaWxlIGFzIGl0ZW1zIChp
bnN0ZWFkIG9mIHN3aXRjaGluZyB0byBlbnVtcykgYW5kIGF0OTFybTkyMDANCj4+IGFzIGZhbGxi
YWNrIGZvciBzYW05eDYwLCBzaW5jZSB0aGUgZXZvbHV0aW9uIG9mIElQJ3MgaXMgaW5jcmVtZW50
YWwuDQo+PiAtIHJlbW92ZWQgdW5uZWNlc3NheSAiY3MtZ3Bpb3MiIHByb3BlcnR5IGFuZCBkZXNj
cmlwdGlvbnMNCj4+IC0gYWRkZWQgbWluL21heCBmb3IgZmlmby1zaXplIHByb3BlcnR5Lg0KPj4N
Cj4+DQo+PiB2MiAtPiB2MzoNCj4+IC0gY2hhbmdlIHN1YmplY3QgaGVhZGxpbmUgcHJlZml4IGZy
b20gInNwaTogYXRtZWwiIHRvDQo+PiAic3BpOiBkdC1iaW5kaW5nczogYXRtZWwsYXQ5MXJtOTIw
MC1zcGk6IGNvbnZlcnQgdG8ganNvbi1zY2hlbWEiDQo+PiAtIHVzZSBlbnVtIGluc3RlYWQgb2Yg
YSByYW5nZSBmb3IgImF0bWVsLGZpZm8tc2l6ZSINCj4+DQo+Pg0KPj4gICAuLi4vYmluZGluZ3Mv
c3BpL2F0bWVsLGF0OTFybTkyMDAtc3BpLnlhbWwgICAgfCA3NiArKysrKysrKysrKysrKysrKysr
DQo+PiAgIC4uLi9kZXZpY2V0cmVlL2JpbmRpbmdzL3NwaS9zcGlfYXRtZWwudHh0ICAgICB8IDM2
IC0tLS0tLS0tLQ0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDc2IGluc2VydGlvbnMoKyksIDM2IGRl
bGV0aW9ucygtKQ0KPj4gICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3NwaS9hdG1lbCxhdDkxcm05MjAwLXNwaS55YW1sDQo+PiAgIGRlbGV0ZSBt
b2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mvc3BpL3NwaV9hdG1l
bC50eHQNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3NwaS9hdG1lbCxhdDkxcm05MjAwLXNwaS55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3NwaS9hdG1lbCxhdDkxcm05MjAwLXNwaS55YW1sDQo+PiBuZXcgZmlsZSBt
b2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMDAwLi4wODQ4OTdjYzhmNjYNCj4+IC0tLSAv
ZGV2L251bGwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkv
YXRtZWwsYXQ5MXJtOTIwMC1zcGkueWFtbA0KPj4gQEAgLTAsMCArMSw3NiBAQA0KPj4gKyMgU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPj4g
KyMgQ29weXJpZ2h0IChDKSAyMDIyIE1pY3JvY2hpcCBUZWNobm9sb2d5LCBJbmMuIGFuZCBpdHMg
c3Vic2lkaWFyaWVzDQo+PiArJVlBTUwgMS4yDQo+PiArLS0tDQo+PiArJGlkOiBodHRwOi8vZGV2
aWNldHJlZS5vcmcvc2NoZW1hcy9zcGkvYXRtZWwsc3BpLnlhbWwjDQo+IFlvdSBuZWVkIHRvIHRl
c3QgdGhlIGJpbmRpbmdzLg0KPg0KTXkgYXBvbG9naWVzLCBJIGRpZCBub3RpY2UgdGhlIHJlbGF0
ZWQgZXJyb3IgbG9jYWxseSwgYnV0IEkgc29tZWhvdyANCmZvcmdvdCB0byBhbWVuZCB0aGUgY29t
bWl0IGJlZm9yZSBmb3JtYXR0aW5nIHRoZSBwYXRjaCBhbmQgc2VuZGluZyBpdC4gSSANCmFtIHNv
cnJ5IGFib3V0IHRoaXMuDQo+PiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEt
c2NoZW1hcy9jb3JlLnlhbWwjDQo+PiArDQo+PiArdGl0bGU6IEF0bWVsIFNQSSBkZXZpY2UNCj4+
ICsNCj4+ICttYWludGFpbmVyczoNCj4+ICsgIC0gVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1
c0BtaWNyb2NoaXAuY29tPg0KPj4gKw0KPj4gK2FsbE9mOg0KPj4gKyAgLSAkcmVmOiBzcGktY29u
dHJvbGxlci55YW1sIw0KPj4gKw0KPj4gK3Byb3BlcnRpZXM6DQo+PiArICBjb21wYXRpYmxlOg0K
Pj4gKyAgICBvbmVPZjoNCj4+ICsgICAgICAtIGl0ZW1zOg0KPiBJIG1pc3NlZCB0aGF0IHBhcnQg
LSB0aGlzIGlzIG9uZSBpdGVtLCBzbyBubyAiaXRlbXMiLg0KWW91IGFyZSByaWdodCwgc2hvdWxk
IGJlIGp1c3QgYSBjb25zdCBJIGd1ZXNzLiBUaGFuayB5b3UuDQo+IEJlc3QgcmVnYXJkcywNCj4g
S3J6eXN6dG9mDQoNClJlZ2FyZHMsDQoNCiDCoMKgwqAgU2VyZ2l1DQoNCg==
