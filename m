Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4C24D121C
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 09:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237473AbiCHIXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 03:23:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243636AbiCHIXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 03:23:12 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAFE93F337;
        Tue,  8 Mar 2022 00:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646727736; x=1678263736;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eVZ9keLg+Qsp4VGu9PpSd54o/hUX8P3Q/9YRFFhjjYc=;
  b=O9JNk94SYvzPCHpIejJAeFUDFjLEsAbdLacAIfmdoBH5nulUGCKUqYVI
   cTf8yi99QojBcg+YkwY4SOVMxpCGm258lJylO0PCZRSnbPZEbByzSYmxG
   zuz/b1Rf3qiWcHCGD6XLHnCKXVUt8oOyuOuT42LAQzQOscrxs+0FQd1k9
   moGRVm70ILcJv2TElIEF9rNubZ2YtBxK3s3LuI7BSUxjbAopRxPK/HyCQ
   weo4FYleeiDtyLtUQivFDULgmyPN4yhecUmlVpy1T5uQ9eADFvMt88ldb
   3cLoQgB16zYps2hVQqBhenRgjiMWUEoGZnSPq4iBTfM9djxW+KM7yo60A
   g==;
X-IronPort-AV: E=Sophos;i="5.90,163,1643698800"; 
   d="scan'208";a="156065396"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Mar 2022 01:22:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 8 Mar 2022 01:22:16 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 8 Mar 2022 01:22:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UD/LxOD4ToennwtM6RPpdH/G3XqaHxGItdTgTZHTUv84uTqYG3uyo6/Pt3WnCCQLZTKtSTlY938Qv4YJNXpCwkvbbZIO8UsmBe3066AZreeGRLkyo08lmbEnF0ENIZtdSNIVyKdxgdnXnOkJY+0Yj3ck4giNBlXoRL3n9O6ShMS0VQhgDM2OHxxrckdsiumm1zMKtucGEiqEgncrlMV6wsztuh0rGPy4UDBqElAhJ+hofsM1+HOoCQ9sWX7UtHhDZyzgeFky9jrwDB63E/SqmzvdDGgHdK1hO5BghtFJ1JeG5hq+zDqLzmPy4KcpzGWRfgbxtpcmmjpL5qVhaOnIQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eVZ9keLg+Qsp4VGu9PpSd54o/hUX8P3Q/9YRFFhjjYc=;
 b=XqdqVj6/4IkfrXoilgGdbnZqkkx9gEeDFIGZIWMeB9Qr6S2sQXqwRt+t+faQRr/C1Q0RE+7UYDBMA24rMvVSueFHH29g+QOUWSse4tYCBNSU+Mzpy52If3OgxN3vuZ6xq9AxGhQhw+NkryP99mZcXzcx4Egh/mkkPGf+41DrmBborrDiGP60HDm61kZ8Hr8/27cpMh1YjyW7uvm4+cRO76DgY2iLWhtvGFkhp2yTDZVavBqpwp48zdKTCZL68nazUKAwXc5+3aDv052BQpPrrc/MDvhO2taAA3oYu8TFG+b3bwTVn9Z75WSO3759FOD4uzkN9oT4Go4oyWkULfWI0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eVZ9keLg+Qsp4VGu9PpSd54o/hUX8P3Q/9YRFFhjjYc=;
 b=IbSobQHxaMkDK8ctf0PoCLQKdhwvwy6e927jrSzPLuuttDAE8XsZKmLAo2jQnpg8cJFpiH+kP/aUDAVc7UArPSe2J3GG4pPdG3bIXkvJnt8z1dmIMYSLmoajNOP1wj/+17VNsTwWMf38YsAsNwN6qegwRWmeOWAYJLsmVyLgUIA=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by BN7PR11MB2673.namprd11.prod.outlook.com (2603:10b6:406:b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Tue, 8 Mar
 2022 08:22:11 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9%6]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 08:22:11 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <Sergiu.Moga@microchip.com>, <a.zummo@towertech.it>,
        <alexandre.belloni@bootlin.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski@canonical.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>
CC:     <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/4] dt-bindings: rtc: at91: Add SAMA7G5 compatible
 strings list
Thread-Topic: [PATCH v4 4/4] dt-bindings: rtc: at91: Add SAMA7G5 compatible
 strings list
Thread-Index: AQHYMsWbVgFJm8RUM0i8Vn3A6VS3MQ==
Date:   Tue, 8 Mar 2022 08:22:11 +0000
Message-ID: <de8feac5-59e5-a17d-03f8-b00161225bcc@microchip.com>
References: <20220304161159.147784-1-sergiu.moga@microchip.com>
 <20220304161159.147784-5-sergiu.moga@microchip.com>
In-Reply-To: <20220304161159.147784-5-sergiu.moga@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2a3d23b1-d8f0-4f75-375b-08da00dcbe64
x-ms-traffictypediagnostic: BN7PR11MB2673:EE_
x-microsoft-antispam-prvs: <BN7PR11MB26735A9E2AC15EAFA749D89CF0099@BN7PR11MB2673.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qjEQ3ICOput+pzt/V1Sg3fd+JfiM5rFtA/rUIkS8kii9HNjMFhPO1Gm0RdTQy6VdmHZag2lWNCv8YojtvihcmvNWTMlTX1pB2ASwjxi2Y0P9N75OC/RyNmVZ4S0LXToie0CJDCUr46g/aOJpFBVDbD7i3NQs5fT/XR6VEeVSPOWQSDLWgCPtv/kpHCQ9pwWUwllFMiwaYUuMPgMQiGHE+AqL3MySm5CpY30lYjkxBVF7UOIDWupWiuYETAERPmXicKjk+3xNte/LZyXghuBkx/8Jdr52dzZYiyY9olHl2msVGE+a5CbzmmGNrIj7AhD3bfkO19GWRiiTDdKtT+fozMFjrGzLY4G/j/6bCCzF7TDxbMwJeoX3/PHo74TYqa7967nnkPUAQqupko2zrSTPyjT9tK51qCTUruiYfZpx65Nw8JzYb5t/etWtSY7vAXF2Eke+CxgBVaBpmUeRUCDxXX1acoOq622dMjBkv9BioW1oCIYnz+SEIrg8CQpa3SG+urbs0+JNJ5X/wInzcS2DZ+ikGpgspK2ygydy/F+8eQ1beO4Ha5rgI1eapp/6wGocnEnhXtLyPr9nN9OCSMeCAU9B5QVNVWIC7gLnnOTLS3GHcQmlfNusvuHmTsMdEAo8uZj1PhPNj8Rqn6W+QCce3fddrHkcGpLX+HT5jYWGmmmfNmuNqkbbKZJmPnemzN8s8BC9BYRDJR77Fmr8XmSpn/ehRfAWxKNPM/Zce+ROOFpkRP3qQ3aYHQnV0O+VsMPDDd4cGOBXTKV5Vs7yKX8qk4NzUJyD4STbN3QnjqBX8VKeemY3V+XexX6Ycnmy/DSYq1OkH5gHj1QtB54Wuzte3cxgagynmo03ewxMpaqlWRc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(76116006)(66556008)(66946007)(966005)(316002)(5660300002)(6512007)(8936002)(26005)(54906003)(91956017)(64756008)(508600001)(66476007)(110136005)(66446008)(4326008)(122000001)(86362001)(6636002)(186003)(31696002)(6486002)(8676002)(36756003)(53546011)(38100700002)(6506007)(71200400001)(38070700005)(2906002)(31686004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c1hLZW8zZllON3dwUFFuWGc5T1RwckdwY2JhUDB3OGozMGZ4Rk54b2x4ZUth?=
 =?utf-8?B?bWRXeXhQUE1YTHNFMkpkL3loeDNRaWlYS1BJK2hiYlpBMWpYeFVydVFuSURw?=
 =?utf-8?B?TDBsdWxzY2NlSHVyeU5mQ1hZU3A2ZGV0L0M5RmVtTG9JRjlQKzUyLy8rNzIz?=
 =?utf-8?B?N05BNnIvVzUzRFlwZU9wcHRtcFU0bVFBUVVVRUd5L2xRQnpqYXNIaVpESk9Q?=
 =?utf-8?B?b1NDbk4ramlqTlVaZGp3Wi9DdEQ4WXg5UVZDdkJnNElCTlFwK0hGVmdqQzhR?=
 =?utf-8?B?QXByQkNSd1JTenhSVDJkV0w0Y0RTajRzVGo4bXQyekRBZU9mdWkwZkdrQUFv?=
 =?utf-8?B?L1ZFWUY1T2hTeGE1L2NMc1d3c3UrVUFRKzAwRU92LzNIazh4dEVwdDMweDlW?=
 =?utf-8?B?S2pINkprTDhmMlJ6bGd0U21yVmJPcy9jSU9FdSs4QUVJd3FkbnQ0djJodG1p?=
 =?utf-8?B?aGtsOWs3MEZVRWxzVVRuOElCRDBBVWV2TGhBa0RleHIvNGlCVVBkK09MZFRR?=
 =?utf-8?B?elNJRUgwZmtpdGpnT1FPMGJkZWk3d0xZU3BoQ1haUHd1d29KdjdvbEpkNWQy?=
 =?utf-8?B?cU14bmRMUitnaUd5QTZkWm9pYWhMZUVyWmxlVFhoVCttOGMrc1VjRHQ4Lzlu?=
 =?utf-8?B?am9WMFUrTFBucjQ4M3ZVWGJlMWYvY2czbHZTOUFXeFhjam5nL21DekNqeExJ?=
 =?utf-8?B?a0MzR1RzQjlteFNlN0FuSTV1YjJXbmZwa1hXbGJFVW5KcXR6eXlpdkIzWU5J?=
 =?utf-8?B?RFhKVGJBSEJKZ1ZMV3dIdEF6MUsxaDYwODg1d2lHcDEvRHR2amUvak5DM05V?=
 =?utf-8?B?ZXk4SHpldFNWbHNqbkZEOGgzaWhuNFd5R3VoTnhxUGFHUzdhU000TlBuZk9u?=
 =?utf-8?B?QktNMGNVNU54cTEzQ043d2MyNEVXYlBubDVMa3VOUzg1VFV0V2NhY1k4OVdC?=
 =?utf-8?B?Y2xCSjZERnJqbUJoOU5jeENsZkhjWmJzY3N5MkJpejhSL3l3ajh6TmZjT0VO?=
 =?utf-8?B?Mi8yV0M2dm9wRmRVbWNpdG9nYzhTMDlsRFVNWWNwTGx5bm1KREdJTVVoVzgw?=
 =?utf-8?B?NE9XUnJrTDEwSTVXZWh2cE5wY21vaE0yR1daOXFGaHBrNWhOdUxnRjdkVS9j?=
 =?utf-8?B?cFVTOVZaRTZua00xUDJvSmFiN29lU09mMGZhUU12bGdOWHlvcG8vc0gydk1W?=
 =?utf-8?B?RUxKWnJXMmZacitmZEJZbkhrcFU3SkJONUY4ME9qMFNaTTZtbTVyRlRZNllS?=
 =?utf-8?B?M2FPUU8zWDdDaCt2M1lYQW5tS1BVSjNZV3ZiblhmTFdwczhXN0JYMEJVSDh2?=
 =?utf-8?B?OUZMeHVWQU9mVjNrNFo3U1p3MzY3U2NNQVNCOXhaTlVCcTExZnJjZXhobU44?=
 =?utf-8?B?V0tEK011YTM3R1RMM1YwWWxRT1c1c3JrTG9PeHdMYisrQ2MvdzJPTmJyWk9V?=
 =?utf-8?B?S2dORDBYV05iTFR5RE1ZRFQyL0tMRDI1dVk2cWpsai9NNVA1MHJyemQ4RnZG?=
 =?utf-8?B?Z3o5dkczRS9DRXBHZDBWdk1NcnRCd0N4VXlDOVBKS21zMzBoWm9lYkFIcjZ0?=
 =?utf-8?B?Wit1dnBHSGFhRVR1TUJHbVBvNTR3MUpUb3kyMWt3bVVoaXlrMFNRMkJjTnoz?=
 =?utf-8?B?aVRZWEJkNkJUSjFqYkVscVRNaS9XcEcxZ01wekxvMlVobG1yUEgxaHBuWWov?=
 =?utf-8?B?VEhraGR3OStPekdla09GL0NVelZuOHQ2K3loTndvVGJncTdzL3l0b2JFZ0hL?=
 =?utf-8?B?YU1CSXcycEc0Y2ZGcG41dWRJWVg5dm9lTkNqMVZQYkdaZm40clJoYktZT1Uz?=
 =?utf-8?B?d1dqVThWOTVZQTdhOWlZeUt5SmFETmZpWHZoekFOb3VjVWpGYWhCb3IveTF5?=
 =?utf-8?B?VUZ3NGkyVDczWGVxN3JoeTB0QWRyY0RYa0Z5bHFEeTNFOVp2TG1kdTk5MDJL?=
 =?utf-8?B?SitsOVYrMGF3NW91ZEpSb2wwV21iRjAwUkRRNU41QmxGM1lEQ3dRdWdtMGZx?=
 =?utf-8?B?T3FsczVlOFFEbGxiQ3BUY2pGS2ZXQzk0amQzUTBXcENEYWlnYVgzcWlWQXFW?=
 =?utf-8?B?STZKcUZMMno5dGoyTmhKSXZGTW13SnNKdThST2EzN3A2Q0tZTWNzOTd0ejJE?=
 =?utf-8?B?dHRDVXpBd2pEV1oyYjdTWHJqdG0yanJHb0cwbndPRGFZWUZrK1FWOWhVNmxq?=
 =?utf-8?B?bHE0UzduV3NRU2NnbGg1eStaUVdETkJWUGV6K0hwQlRtOFFjNWlQa05NbytL?=
 =?utf-8?B?VFRuOTd1RjRMd0dVWWp4Z1p1bnNnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A7DEAF31A2C0D4BAAFD35F705075BA4@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a3d23b1-d8f0-4f75-375b-08da00dcbe64
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 08:22:11.2921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Pnlo9/xP/HJ3Qx3sFuAsD4oapZRJH+Om1dPaJADzYkAYQotnqeqq/SEbIX/Gfp3C0Xz+HpK28Jyzs7dbS5yIyoIB26PhyYD/fXSB+EowrO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2673
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy80LzIyIDE4OjExLCBTZXJnaXUgTW9nYSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6IERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlDQo+IA0KPiBBZGQgY29tcGF0aWJsZSBzdHJpbmdzIGxpc3QgZm9yIFNB
TUE3RzUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBTZXJnaXUgTW9nYSA8c2VyZ2l1Lm1vZ2FAbWlj
cm9jaGlwLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IEtyenlzenRvZiBLb3psb3dza2kgPGtyenlzenRv
Zi5rb3psb3dza2lAY2Fub25pY2FsLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFR1ZG9yIEFtYmFydXMg
PHR1ZG9yLmFtYmFydXNAbWljcm9jaGlwLmNvbT4NCg0KPiAtLS0NCj4gIERvY3VtZW50YXRpb24v
ZGV2aWNldHJlZS9iaW5kaW5ncy9ydGMvYXRtZWwsYXQ5MXNhbTktcnRjLnlhbWwgfCA0ICsrKysN
Cj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcnRjL2F0bWVsLGF0OTFzYW05LXJ0Yy55
YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3J0Yy9hdG1lbCxhdDkxc2Ft
OS1ydGMueWFtbA0KPiBpbmRleCBkMjQ1MjA2N2JmZTQuLmU1YzNjMzg0ZTE3MiAxMDA2NDQNCj4g
LS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3J0Yy9hdG1lbCxhdDkxc2Ft
OS1ydGMueWFtbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcnRj
L2F0bWVsLGF0OTFzYW05LXJ0Yy55YW1sDQo+IEBAIC0yMSw2ICsyMSwxMCBAQCBwcm9wZXJ0aWVz
Og0KPiAgICAgICAgLSBpdGVtczoNCj4gICAgICAgICAgICAtIGNvbnN0OiBtaWNyb2NoaXAsc2Ft
OXg2MC1ydHQNCj4gICAgICAgICAgICAtIGNvbnN0OiBhdG1lbCxhdDkxc2FtOTI2MC1ydHQNCj4g
KyAgICAgIC0gaXRlbXM6DQo+ICsgICAgICAgICAgLSBjb25zdDogbWljcm9jaGlwLHNhbWE3ZzUt
cnR0DQo+ICsgICAgICAgICAgLSBjb25zdDogbWljcm9jaGlwLHNhbTl4NjAtcnR0DQo+ICsgICAg
ICAgICAgLSBjb25zdDogYXRtZWwsYXQ5MXNhbTkyNjAtcnR0DQo+IA0KPiAgICByZWc6DQo+ICAg
ICAgbWF4SXRlbXM6IDENCj4gLS0NCj4gMi4yNS4xDQo+IA0KPiANCj4gX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gbGludXgtYXJtLWtlcm5lbCBtYWls
aW5nIGxpc3QNCj4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnDQo+IGh0dHA6
Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtYXJtLWtlcm5lbA0K
DQo=
