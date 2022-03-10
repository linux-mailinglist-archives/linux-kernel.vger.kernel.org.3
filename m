Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10D7F4D42E6
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 09:55:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240541AbiCJIzy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 03:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240537AbiCJIzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 03:55:50 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 305C91375B6;
        Thu, 10 Mar 2022 00:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646902490; x=1678438490;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=neRTR6WmhoU2DM1Hwn25hj9amsQGl0n5MhCekeXFOzo=;
  b=ywvelYRhtTjGCXEifP4G83abEd4uAYKH4fn8J8LaMxSTZPhQk81wwcg4
   sW/MYOPdNaHUJppL+HDfajkdbilnXDsYBZVokAJqW/dZ8P4qKYoWh/oNe
   IQmoT34thu0RrPtdlPp4lyT3UZYzxcng/khFDivW52oDDMd+cmWco+5EN
   W7d2GuTnIju5244liU2lA52+kO/YeDH67TeApN75rzSfiB/Uc8ocEzK6X
   z8nX+JwuqhzBzHnunrPezag6xhv2mKcfT+wsl7c5h1SicZ8vjYBFGqEwq
   0+Mag0eV4aYonjFm7ro+il9F2DQSR7T7kZeo9Ys15Z4LynsjYBQIygBe7
   g==;
X-IronPort-AV: E=Sophos;i="5.90,169,1643698800"; 
   d="scan'208";a="165245163"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Mar 2022 01:54:48 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 10 Mar 2022 01:54:48 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 10 Mar 2022 01:54:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1jG30S3VZy+dJPOc6N8xfaKSqCF6e4uCTdIOxN9Djy7ohLbaiMQL54/jk/rSPHUTiINiSeFvcnEu0phYp8Wfgqd2P4hVPNytTlp6+/MpQAZLp3wF3H+tyLxGJn+k17Y2q0PNMvYgF7EGDS5Cmxkoiw5dG81NWUp/m8ppj0F5bu2OhIWDGrnVv7E3z9wBsDt/BZv6zODE3gc/rQ+s44RzOTuxmF5RhndBKYyx6uSWUawxNHb9JWI8ocDqwxFMqx4eET9XHuL0xPa4AVpidbi/FG4RJDyyVc4ZYwcie5CXspdSI4XbKm2Zpx2T+P3PHxyNR0ewAPMEw6MbCD/Hwytdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neRTR6WmhoU2DM1Hwn25hj9amsQGl0n5MhCekeXFOzo=;
 b=jsIfOF2bcc6798vLX46aiOPfFle83wiubwGdgqiDjWEZlQ3HZT7OO4x5c8jDZionDiFnrdUgvXBeVF/LJPjQDipTqRM8rHQW35BRQVb2ZjLrw6RB0U+ORW5zkNzbZfdNEYndKlSCBk00aUAEAn7ySgmA69Wp9FBoPQkuH/7HwjlTmI/1eXdPQsw9nMLSvbfP3r5pVHx4IHfxPIDSCq6HEXaMJeRFVvLsTyGLREa6mqowK6yTkHmve9CyGe/IEL5/jKn1tIhoap4+VpjrhOaGxTh/6V6RfO0U9CF+2/D1KFnBE62fnrd/Z9HzPcSCOGj+4MC9Bog+IbIiCGKhnbIkpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neRTR6WmhoU2DM1Hwn25hj9amsQGl0n5MhCekeXFOzo=;
 b=arUjeEdHSFVlENjJv0UigSFCBNALPNWADejwoxRM3Kovi4Ki6xmV8ua3CjMoE7PYlv0WmKHR3Mmb1Q8sp/fbh8dIwzSjKSGoKiCPtHKn5Cb//PZrsF/n9Nfh1gTJ36zJMGS86iQXRRZtgHHbsjn4V6d3m6SF504O4AyulZ44f7k=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by MN2PR11MB4520.namprd11.prod.outlook.com (2603:10b6:208:265::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Thu, 10 Mar
 2022 08:54:43 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9%6]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 08:54:43 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>
CC:     <michael@walle.cc>, <broonie@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <zhengxunli@mxic.com.tw>, <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH 2/4] mtd: spi-nor: core: Allow specifying the byte order
 in DTR mode
Thread-Topic: [PATCH 2/4] mtd: spi-nor: core: Allow specifying the byte order
 in DTR mode
Thread-Index: AQHYNFx8f7+WK6w3y0ymEA9p051zmg==
Date:   Thu, 10 Mar 2022 08:54:43 +0000
Message-ID: <19e9f9a3-7648-b2e3-4731-646e09ec9f0b@microchip.com>
References: <20220218145900.1440045-1-tudor.ambarus@microchip.com>
 <20220218145900.1440045-3-tudor.ambarus@microchip.com>
 <20220302113449.tc2iipvwtaxavfec@ti.com>
In-Reply-To: <20220302113449.tc2iipvwtaxavfec@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0a993bd2-fc19-4f7a-68d2-08da02739ec9
x-ms-traffictypediagnostic: MN2PR11MB4520:EE_
x-microsoft-antispam-prvs: <MN2PR11MB4520FF35B83DDEBA86DDF347F00B9@MN2PR11MB4520.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Tje5UV4pDVmL41ehbNq7CEv165aaPmmizoY0wbKMI7OrpDJ8M1gcI120pa7d2ENJrYXRsJWSDDBGKqLc7U+vnYGhChtVC85faaP39T67SPvksTFlil3ZMm/IYcAtmCdeWajxJuL5D3hnV0Hhax3FBFbrHjJfOaQwxGqan8o9QjwkCX5trNy1wgfewBnf4EPIxk2K6wBikZkCOBeojWfyh9JVkj+LQPpxmPrwuCyT1sWfiX81aqwNQMaTBjX24kYao7n5rcuYQgpxBQtgfm4T8vmC19Pl02quY25i7tz1JpM2lLQ/l1rDWXQYtg/GnnN7/JQ+EJoeLVuvTGkfAm7p63olPNWAtjC9dWjbOOmCeGBzJNB1lA2bX1kexhwH2PYUxiQ3AqFUUmtd89X+AQOSnrt503yfsfhZZCbQHaTBntBsZ9NvQu5HVcoMFF40m700Vg1VH0TutyzNlL/FwwkfOLRaafJFIXEcGox+LdL2ODSrD4O+zc2+B7O8a+a/1ZYq8XLXGcD2rK69863od2ZG4EzNXT5xZxe96f7LpjL1lFq1UtMzP/TooZNrPfICf2+t3Hqiwr1zn2bmslKmQwlgIr49MN+/z7eF0ETEt0RhjZ1/GlE57F7h6MedHmLF8b82HAomAt1mQMgpWb70CNftR7O9v8OHKOes/5pPt1bKf7KJDi9g4/bmsv0RyyzVpIwbhjEkRnu/tdkpAcmLDeRj98N32/+FMwXDOOPzlvOK+bilvc/8Z3ZvW7RDq2mXXwXT3FXMjQWBEklrTsUOiPFMkg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(2906002)(6512007)(6486002)(7416002)(66446008)(91956017)(4326008)(8676002)(64756008)(66946007)(66556008)(122000001)(66476007)(76116006)(26005)(186003)(8936002)(31686004)(2616005)(86362001)(53546011)(6506007)(508600001)(83380400001)(6916009)(38100700002)(316002)(36756003)(54906003)(38070700005)(31696002)(71200400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEdUZkMvUlpBY3dhS1N6aGdiaENhSHQ0K0xRbjh1V3o4dkN3VFc4ZTJXZlB1?=
 =?utf-8?B?L0tLcERyZzlnbzZGdGVadHVROExyN1kyYTNXZzNScmJoaDBwSi9IZnBUc05a?=
 =?utf-8?B?VmhUQ0x5QnhweVMvVlcyTTFldDVFR3M5ajExQmE1N1ZQc05tdXNxcCtDbXEx?=
 =?utf-8?B?YXJYU0pmczJCT0VqYXRQemFUdEpaOWsrcU9ZTUltb1JMVTBDUGdPbHYwcEcv?=
 =?utf-8?B?V1pBSVpKM0p5Q1ExVnlIamJKdXFYL05wVTBUTjFjdWRRWUZ2ZkNSL0lscEZT?=
 =?utf-8?B?emdoK1Q2WGllZ2V6L1ZMUC9nM2Nwb0IrdFRhNWR4a2phU0dvV0Q0MVBnSkt6?=
 =?utf-8?B?REE2WkRpT3FKbDdOWEpXdlhLWjVhOFo2MDM5V3grMTMzUG96M3JGODdwRmxC?=
 =?utf-8?B?cGU2VFJxSUN1c2ZCOVJYNDRYYUlXdnMvMXAvc3lrWVdhMWQwb3ZFaEtHdkJ4?=
 =?utf-8?B?alhTdzhJZjhHSVBRdFRpUG05aWFTQkNFMnlCTUpvc0R5NWVKaUxhTU5lYVVC?=
 =?utf-8?B?OXdMa1k1YXFRRzVITXcxWHJzKzh2OGJ0L29uU09xVDcvUG9KMktra3JWSkt5?=
 =?utf-8?B?NFZ5ZkFOV0lkQWxuLzZMR09QaStleVIzalBLZ2VkNDR4KzdGZjl6S21ybTRF?=
 =?utf-8?B?T3BteERFUnpCSmU5dlF2cUhBMDZEOVpUb1h4YkZJVTk5L0UwZ1FxbTEvZzlT?=
 =?utf-8?B?UkNoZDZLVGs3UE1KQStQUFZwMlEwWVpvWElvK08zRWR1MU1qTkdDS0ZPYTR3?=
 =?utf-8?B?YzBla2Q4NnRMeWxwRUppTklpYVFqRXhlaDcxMkJ0M0Z1YlFncDFybE1ranZa?=
 =?utf-8?B?NHpqdkJXbEsyWmRXM2hsRDBwZjVnQUlpSklhRUV4ZFFQSnVnVXJmQTBjRHRi?=
 =?utf-8?B?cmxGVXA3ejNuM0EwZXY2SS9vRnVSeGVPRk9acUtwSXhXcnBuVjhDMHpIbUU3?=
 =?utf-8?B?NDdrcW0rdVpIWWxQM1laeTg0ZUVWcTdLWnpHaStBdHpkdjlLS2JpQ2pDM200?=
 =?utf-8?B?YnNNQkNyQWtYUDFJaC9EbFE4UHM3SGRpUzF3bCtCRnd3N3JPRjY2V0VROG9D?=
 =?utf-8?B?Q1M5TFlXOVdoOTVlMXFDUHV1bzg5VWZQN213OStrZCtudlN2NVRSVHYzQ3lH?=
 =?utf-8?B?TlVKbS82TVA3UEZpcjU4dGgyNndYdjNveWgyK0NhZ0ZOVEExcHErZDY0bitp?=
 =?utf-8?B?ZTcrREdWZG00QW9nVTFGUDVrUHJWTTBRbkpFOFI2RWt2UUxZTEZmYW5pcGhN?=
 =?utf-8?B?UjBlRjBYelNVMldoUmlIakRtdFRVeEkvbzdKcURNbis1bTF6WTZvdlpqbHBT?=
 =?utf-8?B?TU1yT0Jxbm9SaUxnemRvVnBYdGdBZzdKMVAwTFdjVTNNQktjUVhUZFlrVGND?=
 =?utf-8?B?MGhUZG9RcVhnVHZZYVFncUJHaHRtVUE2TzFHZVFGcHdXMHhqQzNEWkk4ZUR3?=
 =?utf-8?B?Zk9VNkdpVFBSR1duTFphRVpUL0lRMm00T25pU2hkVFhZVnBSVGdpcWJzNGZR?=
 =?utf-8?B?djArbGNMQjNjK2FpSjE4SWQraWV2NHV4T2NPOVd6Z0hQei9zWFF0RDM0cnBq?=
 =?utf-8?B?VEtQazQxTkExZ1RNTHhReXVwVnFvZlZtYmhod1d5RDZ2bitibldoNGl3N0xX?=
 =?utf-8?B?WFpqVVFXN1VSTk1HNlhEMVlUZ2c2cTlXb0xuVzJNZUhiNjBnQmM5S2d1azYw?=
 =?utf-8?B?ZFJNS2JndkEwOU9Wc29xdFpITFNINWFKamtrWkxDZjZpOXVJUzRmTkhqWlh1?=
 =?utf-8?B?YVcrRzJSVWVMeGs3SUpuRnhObHNnREh4a1AvaVEyV1JWM09CelJJdGpZOStY?=
 =?utf-8?B?dzBsSG1DSFFNa1ZOOEd5ejlNUHArY2FSYzBVb0RHTFQvNE43VTdCR2MyUGV3?=
 =?utf-8?B?dlo5b2kyUHRrei9YOHBwY2p3S0JjOStkT2Z5Y1RsNVgvSzVsSXQxZzllWHk2?=
 =?utf-8?B?RWJxUUMyUElYYW4xT01udnhvWlpZRVpGMWxPbnlMdFFzSjdJOGRpYnJtRWNv?=
 =?utf-8?B?SUx4eHdBVmZsdjIrZnB6VHZ4SlNxTkVoRHFvVGpmUVh1SUFEWFdSb1dSU01y?=
 =?utf-8?B?V2p5M2M4bWp6WmhveGloT3lGZ1dvUG1OdnVFVUZsTUlKL01BcHZjTHBNN09h?=
 =?utf-8?B?cUd5bi9mYmloQ2R2U2VRZWQ0VGNIeHV1bXduQzc0UE5QcDFMSEpZcWtnRlY3?=
 =?utf-8?B?N2NERTluOXRoMEN0WHlaT1F3clpKWXplbXVxMnYrZzJjbjZ0amhVS2JSUEZT?=
 =?utf-8?B?TENNekh0dVRUc2ZJdUkyZjBzQ2Z3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D38050A4A0F774CA9D20DC6E0F2DD9B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a993bd2-fc19-4f7a-68d2-08da02739ec9
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 08:54:43.3903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UDYUnSXMBYpIsk4p86eOmyPN1urWn8Yl0QEdJinlM+SayxfZlwC5+4rbUOeVP6j1G2Bn5zHQJDtTzeiPa8A9qvcRM8jxcb4TwCGt8ovVlRg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4520
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8yLzIyIDEzOjM0LCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBIaSBUdWRvciwNCg0KSGksIFByYXR5dXNoLA0KDQo+
IA0KPiBPbiAxOC8wMi8yMiAwNDo1OFBNLCBUdWRvciBBbWJhcnVzIHdyb3RlOg0KPj4gTWFjcm9u
aXggc3dhcHMgYnl0ZXMgb24gYSAxNi1iaXQgYm91bmRhcnkgd2hlbiBjb25maWd1cmVkIGluIE9j
dGFsIERUUi4NCj4+IFRoZSBieXRlIG9yZGVyIG9mIDE2LWJpdCB3b3JkcyBpcyBzd2FwcGVkIHdo
ZW4gcmVhZCBvciB3cml0ZSB3cml0dGVuIGluDQo+PiA4RC04RC04RCBtb2RlIGNvbXBhcmVkIHRv
IFNUUiBtb2Rlcy4gU3dhcHBpbmcgdGhlIGJ5dGVzIGlzIGEgYmFkIGRlc2lnbg0KPj4gZGVjaXNp
b24gYmVjYXVzZSB0aGlzIG1heSBhZmZlY3QgdGhlIGJvb3Qgc2VxdWVuY2UgaWYgdGhlIGVudGly
ZSBib290DQo+PiBzZXF1ZW5jZSBpcyBub3QgaGFuZGxlZCBpbiBlaXRoZXIgOEQtOEQtOEQgbW9k
ZSBvciAxLTEtMSBtb2RlLiBBbGxvdw0KPj4gb3BlcmF0aW9ucyB0byBzcGVjaWZ5IHRoZSBieXRl
IG9yZGVyIGluIERUUiBtb2RlLCBzbyB0aGF0IGNvbnRyb2xsZXJzIGNhbg0KPj4gc3dhcCB0aGUg
Ynl0ZXMgYmFjayBhdCBydW4tdGltZSB0byBmaXggdGhlIGVuZGlhbm5lc3MsIGlmIHRoZXkgYXJl
IGNhcGFibGUuDQo+Pg0KPj4gVGhlIGJ5dGUgb3JkZXIgaW4gOEQtOEQtOEQgbW9kZSBjYW4gYmUg
cmV0cmlldmVkIGF0IHJ1bi10aW1lIGJ5IGNoZWNraW5nDQo+PiBCRlBUW0RXT1JEKDE4KV0gQklU
KDMxKS4gV2hlbiBzZXQgdG8gb25lLCB0aGUgIkJ5dGUgb3JkZXIgb2YgMTYtYml0IHdvcmRzDQo+
PiBpcyBzd2FwcGVkIHdoZW4gcmVhZCBpbiA4RC04RC04RCBtb2RlIGNvbXBhcmVkIHRvIDEtMS0x
IG1vZGUuIi4gSXQgZG9lc24ndA0KPj4gc3BlY2lmeSBpZiB0aGlzIGFwcGxpZXMgdG8gYm90aCBy
ZWdpc3RlciBhbmQgZGF0YSBvcGVyYXRpb25zLiBNYWNyb25peCBpcw0KPj4gdGhlIHNpbmdsZSB1
c2VyIG9mIHRoaXMgYnl0ZSBzd2FwIGFuZCBpdCBkb2Vzbid0IGhhdmUgY2xlYXIgcnVsZXMsIGFz
IGl0DQo+PiBjb250YWlucyByZWdpc3RlciBvcGVyYXRpb25zIHRoYXQgcmVxdWlyZSBkYXRhIHN3
YXAgKFJEUEFTUywgV1JQQVNTLA0KPj4gUEFTU1VMSywgUkRTRkRQKSBhbmQgcmVnaXN0ZXIgb3Bl
cmF0aW9ucyB0aGF0IGRvbid0IHJlcXVpcmUgZGF0YSBzd2FwDQo+PiAoV1JGQlIpLiBBbGwgdGhl
c2UgYXJlIG5vdCBjb21tb24gYW5kIGNhbiBiZSBoYW5kbGVkIGluIDEtMS0xIG1vZGUsIHNvIHdl
DQo+PiBjYW4gaWdub3JlIHRoZW0gZm9yIG5vdy4gQWxsIHRoZSBvdGhlciByZWdpc3RlciBvcGVy
YXRpb25zIGFyZSBkb25lIG9uIG9uZQ0KPj4gYnl0ZSBsZW5ndGguIFRoZSByZWFkIHJlZ2lzdGVy
IG9wZXJhdGlvbnMgYXJlIGFjdHVhbGx5IGluIDhELThELThTIG1vZGUsDQo+PiBhcyB0aGV5IHNl
bmQgdGhlIGRhdGEgdmFsdWUgdHdpY2UsIG9uIGVhY2ggaGFsZiBvZiB0aGUgY2xvY2sgY3ljbGUu
IEluIGNhc2UNCj4+IG9mIGEgcmVnaXN0ZXIgd3JpdGUgb2Ygb25lIGJ5dGUsIHRoZSBtZW1vcnkg
c3VwcG9ydHMgcmVjZWl2aW5nIHRoZSByZWdpc3Rlcg0KPj4gdmFsdWUgb25seSBvbiB0aGUgZmly
c3QgYnl0ZSwgdGh1cyBpdCBkaXNjYXJkcyB0aGUgdmFsdWUgb2YgdGhlIGJ5dGUgb24gdGhlDQo+
PiBzZWNvbmQgaGFsZiBvZiB0aGUgY2xvY2sgY3ljbGUuIFN3YXBwaW5nIHRoZSBieXRlcyBmb3Ig
b25lIGJ5dGUgcmVnaXN0ZXINCj4+IHdyaXRlcyBpcyBub3QgcmVxdWlyZWQsIGFuZCBmb3Igb25l
IGJ5dGUgcmVnaXN0ZXIgcmVhZHMgaXQgZG9lc24ndCBtYXR0ZXIuDQo+PiBUaHVzIHN3YXAgdGhl
IGJ5dGVzIG9ubHkgZm9yIHJlYWQgb3IgcGFnZSBwcm9ncmFtIG9wZXJhdGlvbnMuDQo+Pg0KPj4g
U2lnbmVkLW9mZi1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29t
Pg0KPj4gLS0tDQo+PiAgZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMgIHwgMzEgKysrKysrKysr
KysrKysrKysrKysrKysrKy0tLS0tLQ0KPj4gIGRyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oICB8
ICAxICsNCj4+ICBpbmNsdWRlL2xpbnV4L210ZC9zcGktbm9yLmggfCAxNyArKysrKysrKysrKysr
KysrKw0KPj4gIDMgZmlsZXMgY2hhbmdlZCwgNDMgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMo
LSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMgYi9kcml2
ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPj4gaW5kZXggMDRlYTE4MDExOGUzLi40NTNkOGM1NGQw
NjIgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYw0KPj4gKysrIGIv
ZHJpdmVycy9tdGQvc3BpLW5vci9jb3JlLmMNCj4+IEBAIC0xMDYsNiArMTA2LDkgQEAgdm9pZCBz
cGlfbm9yX3NwaW1lbV9zZXR1cF9vcChjb25zdCBzdHJ1Y3Qgc3BpX25vciAqbm9yLA0KPj4gICAg
ICAgICAgICAgICBvcC0+ZHVtbXkuZHRyID0gdHJ1ZTsNCj4+ICAgICAgICAgICAgICAgb3AtPmRh
dGEuZHRyID0gdHJ1ZTsNCj4+DQo+PiArICAgICAgICAgICAgIGlmIChzcGlfbm9yX3Byb3RvY29s
X2lzX2R0cl9ic3dhcDE2KHByb3RvKSkNCj4+ICsgICAgICAgICAgICAgICAgICAgICBvcC0+ZGF0
YS5kdHJfYnN3YXAxNiA9IHRydWU7DQo+PiArDQo+PiAgICAgICAgICAgICAgIC8qIDIgYnl0ZXMg
cGVyIGNsb2NrIGN5Y2xlIGluIERUUiBtb2RlLiAqLw0KPj4gICAgICAgICAgICAgICBvcC0+ZHVt
bXkubmJ5dGVzICo9IDI7DQo+Pg0KPj4gQEAgLTM4OCw3ICszOTEsNyBAQCBpbnQgc3BpX25vcl9y
ZWFkX3NyKHN0cnVjdCBzcGlfbm9yICpub3IsIHU4ICpzcikNCj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIFNQSV9NRU1fT1BfTk9fRFVNTVksDQo+PiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBTUElfTUVNX09QX0RBVEFfSU4oMSwgc3IsIDApKTsNCj4+DQo+PiAt
ICAgICAgICAgICAgIGlmIChub3ItPnJlZ19wcm90byA9PSBTTk9SX1BST1RPXzhfOF84X0RUUikg
ew0KPj4gKyAgICAgICAgICAgICBpZiAoc3BpX25vcl9wcm90b2NvbF9pc19vY3RhbF9kdHIobm9y
LT5yZWdfcHJvdG8pKSB7DQo+PiAgICAgICAgICAgICAgICAgICAgICAgb3AuYWRkci5uYnl0ZXMg
PSBub3ItPnBhcmFtcy0+cmRzcl9hZGRyX25ieXRlczsNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICBvcC5kdW1teS5uYnl0ZXMgPSBub3ItPnBhcmFtcy0+cmRzcl9kdW1teTsNCj4+ICAgICAgICAg
ICAgICAgICAgICAgICAvKg0KPj4gQEAgLTQzMiw3ICs0MzUsNyBAQCBzdGF0aWMgaW50IHNwaV9u
b3JfcmVhZF9mc3Ioc3RydWN0IHNwaV9ub3IgKm5vciwgdTggKmZzcikNCj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIFNQSV9NRU1fT1BfTk9fRFVNTVksDQo+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBTUElfTUVNX09QX0RBVEFfSU4oMSwgZnNyLCAwKSk7DQo+
Pg0KPj4gLSAgICAgICAgICAgICBpZiAobm9yLT5yZWdfcHJvdG8gPT0gU05PUl9QUk9UT184Xzhf
OF9EVFIpIHsNCj4+ICsgICAgICAgICAgICAgaWYgKHNwaV9ub3JfcHJvdG9jb2xfaXNfb2N0YWxf
ZHRyKG5vci0+cmVnX3Byb3RvKSkgew0KPj4gICAgICAgICAgICAgICAgICAgICAgIG9wLmFkZHIu
bmJ5dGVzID0gbm9yLT5wYXJhbXMtPnJkc3JfYWRkcl9uYnl0ZXM7DQo+PiAgICAgICAgICAgICAg
ICAgICAgICAgb3AuZHVtbXkubmJ5dGVzID0gbm9yLT5wYXJhbXMtPnJkc3JfZHVtbXk7DQo+PiAg
ICAgICAgICAgICAgICAgICAgICAgLyoNCj4+IEBAIC0yNDg4LDcgKzI0OTEsNyBAQCBzdGF0aWMg
aW50IHNwaV9ub3Jfc2V0X2FkZHJfd2lkdGgoc3RydWN0IHNwaV9ub3IgKm5vcikNCj4+ICB7DQo+
PiAgICAgICBpZiAobm9yLT5hZGRyX3dpZHRoKSB7DQo+PiAgICAgICAgICAgICAgIC8qIGFscmVh
ZHkgY29uZmlndXJlZCBmcm9tIFNGRFAgKi8NCj4+IC0gICAgIH0gZWxzZSBpZiAobm9yLT5yZWFk
X3Byb3RvID09IFNOT1JfUFJPVE9fOF84XzhfRFRSKSB7DQo+PiArICAgICB9IGVsc2UgaWYgKHNw
aV9ub3JfcHJvdG9jb2xfaXNfb2N0YWxfZHRyKG5vci0+cmVhZF9wcm90bykpIHsNCj4+ICAgICAg
ICAgICAgICAgLyoNCj4+ICAgICAgICAgICAgICAgICogSW4gOEQtOEQtOEQgbW9kZSwgb25lIGJ5
dGUgdGFrZXMgaGFsZiBhIGN5Y2xlIHRvIHRyYW5zZmVyLiBTbw0KPj4gICAgICAgICAgICAgICAg
KiBpbiB0aGlzIHByb3RvY29sIGFuIG9kZCBhZGRyZXNzIHdpZHRoIGNhbm5vdCBiZSB1c2VkIGJl
Y2F1c2UNCj4+IEBAIC0yNzAxLDYgKzI3MDQsMTkgQEAgc3RhdGljIHZvaWQgc3BpX25vcl9pbml0
X2ZpeHVwX2ZsYWdzKHN0cnVjdCBzcGlfbm9yICpub3IpDQo+PiAgICAgICAgICAgICAgIG5vci0+
ZmxhZ3MgfD0gU05PUl9GX0lPX01PREVfRU5fVk9MQVRJTEU7DQo+PiAgfQ0KPj4NCj4+ICtzdGF0
aWMgdm9pZCBzcGlfbm9yX3NldF9kdHJfYnN3YXAxNl9vcHMoc3RydWN0IHNwaV9ub3IgKm5vcikN
Cj4+ICt7DQo+PiArICAgICBzdHJ1Y3Qgc3BpX25vcl9mbGFzaF9wYXJhbWV0ZXIgKnBhcmFtcyA9
IG5vci0+cGFyYW1zOw0KPj4gKyAgICAgdTMyIG1hc2sgPSBTTk9SX0hXQ0FQU19SRUFEXzhfOF84
X0RUUiB8IFNOT1JfSFdDQVBTX1BQXzhfOF84X0RUUjsNCj4+ICsNCj4+ICsgICAgIGlmICgocGFy
YW1zLT5od2NhcHMubWFzayAmIG1hc2spID09IG1hc2spIHsNCj4+ICsgICAgICAgICAgICAgcGFy
YW1zLT5yZWFkc1tTTk9SX0NNRF9SRUFEXzhfOF84X0RUUl0ucHJvdG8gfD0NCj4+ICsgICAgICAg
ICAgICAgICAgICAgICBTTk9SX1BST1RPX0lTX0RUUl9CU1dBUDE2Ow0KPj4gKyAgICAgICAgICAg
ICBwYXJhbXMtPnBhZ2VfcHJvZ3JhbXNbU05PUl9DTURfUFBfOF84XzhfRFRSXS5wcm90byB8PQ0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgIFNOT1JfUFJPVE9fSVNfRFRSX0JTV0FQMTY7DQo+PiAr
ICAgICB9DQo+PiArfQ0KPj4gKw0KPj4gIC8qKg0KPj4gICAqIHNwaV9ub3JfbGF0ZV9pbml0X3Bh
cmFtcygpIC0gTGF0ZSBpbml0aWFsaXphdGlvbiBvZiBkZWZhdWx0IGZsYXNoIHBhcmFtZXRlcnMu
DQo+PiAgICogQG5vcjogICAgIHBvaW50ZXIgdG8gYSAnc3RydWN0IHNwaV9ub3InDQo+PiBAQCAt
MjcyMSw2ICsyNzM3LDkgQEAgc3RhdGljIHZvaWQgc3BpX25vcl9sYXRlX2luaXRfcGFyYW1zKHN0
cnVjdCBzcGlfbm9yICpub3IpDQo+PiAgICAgICBzcGlfbm9yX2luaXRfZmxhZ3Mobm9yKTsNCj4+
ICAgICAgIHNwaV9ub3JfaW5pdF9maXh1cF9mbGFncyhub3IpOw0KPj4NCj4+ICsgICAgIGlmIChu
b3ItPmZsYWdzICYgU05PUl9GX0RUUl9CU1dBUDE2KQ0KPj4gKyAgICAgICAgICAgICBzcGlfbm9y
X3NldF9kdHJfYnN3YXAxNl9vcHMobm9yKTsNCj4+ICsNCj4+ICAgICAgIC8qDQo+PiAgICAgICAg
KiBOT1IgcHJvdGVjdGlvbiBzdXBwb3J0LiBXaGVuIGxvY2tpbmdfb3BzIGFyZSBub3QgcHJvdmlk
ZWQsIHdlIHBpY2sNCj4+ICAgICAgICAqIHRoZSBkZWZhdWx0IG9uZXMuDQo+PiBAQCAtMjg5OSw4
ICsyOTE4LDggQEAgc3RhdGljIGludCBzcGlfbm9yX29jdGFsX2R0cl9lbmFibGUoc3RydWN0IHNw
aV9ub3IgKm5vciwgYm9vbCBlbmFibGUpDQo+PiAgICAgICBpZiAoIW5vci0+cGFyYW1zLT5vY3Rh
bF9kdHJfZW5hYmxlKQ0KPj4gICAgICAgICAgICAgICByZXR1cm4gMDsNCj4+DQo+PiAtICAgICBp
ZiAoIShub3ItPnJlYWRfcHJvdG8gPT0gU05PUl9QUk9UT184XzhfOF9EVFIgJiYNCj4+IC0gICAg
ICAgICAgIG5vci0+d3JpdGVfcHJvdG8gPT0gU05PUl9QUk9UT184XzhfOF9EVFIpKQ0KPj4gKyAg
ICAgaWYgKCEoc3BpX25vcl9wcm90b2NvbF9pc19vY3RhbF9kdHIobm9yLT5yZWFkX3Byb3RvKSAm
Jg0KPj4gKyAgICAgICAgICAgc3BpX25vcl9wcm90b2NvbF9pc19vY3RhbF9kdHIobm9yLT53cml0
ZV9wcm90bykpKQ0KPj4gICAgICAgICAgICAgICByZXR1cm4gMDsNCj4+DQo+PiAgICAgICBpZiAo
IShub3ItPmZsYWdzICYgU05PUl9GX0lPX01PREVfRU5fVk9MQVRJTEUpKQ0KPj4gQEAgLTI5Njgs
NyArMjk4Nyw3IEBAIHN0YXRpYyBpbnQgc3BpX25vcl9pbml0KHN0cnVjdCBzcGlfbm9yICpub3Ip
DQo+PiAgICAgICAgICAgICAgIHNwaV9ub3JfdHJ5X3VubG9ja19hbGwobm9yKTsNCj4+DQo+PiAg
ICAgICBpZiAobm9yLT5hZGRyX3dpZHRoID09IDQgJiYNCj4+IC0gICAgICAgICBub3ItPnJlYWRf
cHJvdG8gIT0gU05PUl9QUk9UT184XzhfOF9EVFIgJiYNCj4+ICsgICAgICAgICAhc3BpX25vcl9w
cm90b2NvbF9pc19vY3RhbF9kdHIobm9yLT5yZWFkX3Byb3RvKSAmJg0KPj4gICAgICAgICAgICEo
bm9yLT5mbGFncyAmIFNOT1JfRl80Ql9PUENPREVTKSkgew0KPj4gICAgICAgICAgICAgICAvKg0K
Pj4gICAgICAgICAgICAgICAgKiBJZiB0aGUgUkVTRVQjIHBpbiBpc24ndCBob29rZWQgdXAgcHJv
cGVybHksIG9yIHRoZSBzeXN0ZW0NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9y
L2NvcmUuaCBiL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5oDQo+PiBpbmRleCAyYWZiNjEwODUz
YTkuLjdjMDc3ZDQxYzMzNSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29y
ZS5oDQo+PiArKysgYi9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuaA0KPj4gQEAgLTI5LDYgKzI5
LDcgQEAgZW51bSBzcGlfbm9yX29wdGlvbl9mbGFncyB7DQo+PiAgICAgICBTTk9SX0ZfSU9fTU9E
RV9FTl9WT0xBVElMRSA9IEJJVCgxNCksDQo+PiAgICAgICBTTk9SX0ZfU09GVF9SRVNFVCAgICAg
ICA9IEJJVCgxNSksDQo+PiAgICAgICBTTk9SX0ZfU1dQX0lTX1ZPTEFUSUxFICA9IEJJVCgxNiks
DQo+PiArICAgICBTTk9SX0ZfRFRSX0JTV0FQMTYgICAgICA9IEJJVCgxNyksDQo+PiAgfTsNCj4+
DQo+PiAgc3RydWN0IHNwaV9ub3JfcmVhZF9jb21tYW5kIHsNCj4+IGRpZmYgLS1naXQgYS9pbmNs
dWRlL2xpbnV4L210ZC9zcGktbm9yLmggYi9pbmNsdWRlL2xpbnV4L210ZC9zcGktbm9yLmgNCj4+
IGluZGV4IGZjOTBmY2UyNmUzMy4uNmU5NjYwNDc1YzViIDEwMDY0NA0KPj4gLS0tIGEvaW5jbHVk
ZS9saW51eC9tdGQvc3BpLW5vci5oDQo+PiArKysgYi9pbmNsdWRlL2xpbnV4L210ZC9zcGktbm9y
LmgNCj4+IEBAIC0xNjgsNiArMTY4LDExIEBADQo+PiAgICAgICAgU05PUl9QUk9UT19EQVRBX01B
U0spDQo+Pg0KPj4gICNkZWZpbmUgU05PUl9QUk9UT19JU19EVFIgICAgQklUKDI0KSAvKiBEb3Vi
bGUgVHJhbnNmZXIgUmF0ZSAqLw0KPj4gKy8qDQo+PiArICogQnl0ZSBvcmRlciBvZiAxNi1iaXQg
d29yZHMgaXMgc3dhcHBlZCB3aGVuIHJlYWQgb3Igd3JpdHRlbiBpbiBEVFIgbW9kZQ0KPj4gKyAq
IGNvbXBhcmVkIHRvIFNUUiBtb2RlLg0KPj4gKyAqLw0KPj4gKyNkZWZpbmUgU05PUl9QUk9UT19J
U19EVFJfQlNXQVAxNiAgICBCSVQoMjUpDQo+IA0KPiBJIGFtIG5vdCBzbyBzdXJlIGlmIHRoZSBw
cm90b2NvbCBpcyB0aGUgYmVzdCBwbGFjZSB0byBlbmNvZGUgdGhpcy4gVGhlDQo+IHByb3RvY29s
IHN0YXlzIHRoZSBzYW1lIHJlZ2FyZGxlc3Mgb2YgdGhlIGRhdGEgb3JnYW5pc2F0aW9uLiBNYXli
ZSBhbGwNCj4gd2UgbmVlZCB0byBkbyBpcyBhZGQgc29tZXRoaW5nIGxpa2UNCj4gDQo+IHN0YXRp
YyBpbmxpbmUgYm9vbA0KPiBzcGlfbm9yX25lZWRzX2Jzd2FwMTYoc3RydWN0IHNwaV9ub3IgKm5v
ciwgZW51bSBzcGlfbm9yX3Byb3RvY29sIHByb3RvKQ0KPiB7DQo+ICAgICAgICAgcmV0dXJuIChw
cm90byA9PSBTTk9SX1BST1RPXzhfOF84X0RUUikgJiYgKG5vci0+ZmxhZ3MgJiBTTk9SX0ZfRFRS
X0JTV0FQMTYpOw0KPiB9DQo+IA0KPiBBbmQgdGhlbiBjYWxsIGl0IGZyb20gc3BpX25vcl9zcGlt
ZW1fc2V0dXBfb3AoKS4gVGhvdWdodHM/DQo+IA0KDQpJIGZpbmQgaXQgYmV0dGVyLiBUaGVyZSdz
IG5vIHN1Y2ggdGhpbmcgYXMgYSA4RC04RC04RC1ic3dhcDE2IGluDQp0aGUgc3RhbmRhcmQgdGVy
bWlub2xvZ3ksIHNvIEknbGwgZHJvcCB0aGUgcHJvdG9jb2wgaGFuZGxpbmcuDQoNClRoYW5rcyEN
CnRhDQo=
