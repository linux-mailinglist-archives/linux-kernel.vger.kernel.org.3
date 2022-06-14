Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A808D54AC85
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355912AbiFNIux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354482AbiFNIu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:50:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A75F57;
        Tue, 14 Jun 2022 01:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655196620; x=1686732620;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tPc0IrgKz20P5AwzixTnKu9z43B1Bimpi40DrNJmtX8=;
  b=1qVji0aqvIxwKxWHV0yJWa/Np8sQRDfbt5KV6w3p9Mivbm0NcazEfgHF
   NVyVc3c4v3OA0VqSdrmBZtmzkA8kD8+poI0uO+irv13T7IVDY4bJ7tkYZ
   h137ByM0lkSMZ32VLoLwUs/jp78TDvZ5LoYELSKrmrEb2VIh7mogTsL4r
   lEvi8PqI5hdL0qT2h7b33TBP4xzU1oQ4rpVWtB6aqWlfDfrVghYXyMBpK
   0hkmvPeZJe8M6yhIU20I33zOiF5gc3TeV6rgXhbWRLp/5uVfvyvJrqhyC
   uKZx6uDpe8yw+yXuMokMfnZa2D+72xsI4q3B/AJ9vJTZ4UI64RcYk8zI0
   g==;
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="168327102"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jun 2022 01:50:19 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 14 Jun 2022 01:50:19 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 14 Jun 2022 01:50:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8OR8tu90X/MAZhGnywxeRV5mtjmcwUoPK1SfKu3n+3cr3L/NpGorfLzOSb2HFy9kyJHtZPd35DgvubYZ8viO1QDOA+KWBV9F+zbC0FPk9WY2EtZbV/UaRATcYm3puL07hFpeV1wheDG7NXzxj/cxLAxK9dV6txEkhCpY79MJ2qx9f+aGQ/OIsX8PeXaurKnZDqIaoLnjYHhaaHl8UXvW2SCowFivNJ0rGnYGq9MKt+zNlWekEjTJrN/rC4l6l/POKASmnD6laNVj1cTHxjzJmMRbIXvcLdIzG3aaYCZxHvjj8euxLJjhhAqDTj3RK81/5ydZ+fwAeSqZcFdd/NVjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tPc0IrgKz20P5AwzixTnKu9z43B1Bimpi40DrNJmtX8=;
 b=D+pF4Sg9YPecTO9gaSeWbyINglK1rQnJIlzIEQtpAC5iPHQet1Kdj8y11kGoTwfqumMzJLRFK/ju9FdN04062MVqZECVZcbV+vSkwZiz6bGxMzwjVvtlIoIrwboPcSbcQ7qvL/3GKU7TkEaryJjiSBqGV3eaOwWww8rS5Z/5i7vv416zhllpwcZEYgM+gloUOyf/fMcvjDVkAIfUqvBlDeIl/tsSGbF7ss2AeYKPB4x5xOpPg0Iu0sX5vzIJfWOfuIap9vliB2btb+ukkFiQsQK6oUDR0uG72beA5HUbnmyONd1asxlz6KjhMJBEnu+ktHx2k2jF5CvtoTlJZ9YFlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPc0IrgKz20P5AwzixTnKu9z43B1Bimpi40DrNJmtX8=;
 b=s53eaHdXvSdJsoCR6OMqoZZSJRDfriq/DcoDj4NxLMGX5JJaDRZQAjvXxScQjExkHBgiYzcytAubqgKo9o5fSiI1q9Jf4tIG9Vfb0pUInaR4DOL3NxQT1PvlfLouSke4/pCusdr+vMR69aJKlF6KJ6a3wBcJhiaxRf+q2cl1RbI=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by SJ1PR11MB6276.namprd11.prod.outlook.com (2603:10b6:a03:455::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Tue, 14 Jun
 2022 08:50:14 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5cfe:8088:aa93:fce8]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5cfe:8088:aa93:fce8%3]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 08:50:14 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <jic23@kernel.org>
CC:     <Eugen.Hristev@microchip.com>, <lars@metafoo.de>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <ludovic.desroches@atmel.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 11/16] iio: adc: at91-sama5d2_adc: add locking parameter
 to at91_adc_read_info_raw()
Thread-Topic: [PATCH 11/16] iio: adc: at91-sama5d2_adc: add locking parameter
 to at91_adc_read_info_raw()
Thread-Index: AQHYf8vDnSSymt/QDEuUTLKV0A4wdA==
Date:   Tue, 14 Jun 2022 08:50:14 +0000
Message-ID: <2989a8a5-b350-aac1-dcfb-249ac5bb23aa@microchip.com>
References: <20220609083213.1795019-1-claudiu.beznea@microchip.com>
 <20220609083213.1795019-12-claudiu.beznea@microchip.com>
 <20220611185851.4d266d5e@jic23-huawei>
In-Reply-To: <20220611185851.4d266d5e@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 33c09b59-e7f3-41c6-99fe-08da4de2e630
x-ms-traffictypediagnostic: SJ1PR11MB6276:EE_
x-microsoft-antispam-prvs: <SJ1PR11MB62762A1A99C6262CCF8D8AE787AA9@SJ1PR11MB6276.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qjSkaD/uhJfJzdCMnAgJnkZJTISPVv7mD9mabgpo2ELuJ2zkmxXDLTutttNxUz/xuM8/sJr18x3NJs3HXrta1513dfEHnRTcWWEA0uVWkgILSdmEpbUKnTui113acNZe9iIXqsZ+BzKEt7GD0w1r9QKm7t/h0A8OXwPXRefGVCMyTbOp+9jHDfZ1jOvj5439paQzQFYeTyMh5fLWXZGPQNFJHEXiRsPhc62M0jwgI8SBq0+wPwSklILyZl5qq88fYADwtf2wdyGPpEURBSACcIK/j9B6hQH/o7/JEAizBje/qE8+K4SrwYy9N/P0IX/JXhhfb7qK/xOmc2U8ODshmNN5z30tZr7K1lTodArOJ//yNP847F9+mCJoeextMMUV6/CKpt8tiwj5a+bre6NXedNC6/fIMvxcylxsS7xzShUxBQPPtrqq0TBYmC1shCal6sNZD4K0TEkMdyXM5ZEEOKX56dppJgraq8fppZ2+1rLRdbRIiyFIb27flZfPFUn15IJ2MbySezdXkWJUTauE/O+amEMdpul50vkAtLyMxA/TVuOOuMXhqgn9pPLk/dsBFt57oVdcnp2E27dgBfYsHhwYiFKsyd9MTVRWDhKr15w5fxQ6Jy9U3AmlxUkmXjaRgEqV7rmdv9azeL80ETxFpg3KOrcaT5eBxSffzaLyHVm0DKo3pnOSkmJIEmcaZDivbp4UI2N2Cxh1gcv1Bj+XnTpNGCEO+HEF29kbje7hlKuSkHIaGIejStme9ZhCBqdxQsWpBU+X5JPbs08puiVdEQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(66476007)(91956017)(66946007)(4326008)(64756008)(66446008)(8676002)(76116006)(66556008)(6486002)(7416002)(38100700002)(6512007)(8936002)(71200400001)(38070700005)(2906002)(6506007)(5660300002)(31696002)(26005)(53546011)(86362001)(36756003)(54906003)(316002)(186003)(83380400001)(122000001)(6916009)(508600001)(31686004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OU14V3pyLy81UzFiczBZRVVHOWNwVDZoTVlqS3JERDhYWXh5cmplUTlKd3Rm?=
 =?utf-8?B?QlNkb0JtTFZMRVk2NE1iUVFsQjZERXl6UXZ6RlBsaEcydmJ0L1pFNnJGR1Z0?=
 =?utf-8?B?cTE5ZUVsdW1pTzNzM3FrUWR3ZUp6Ny9INXVySkgzVjgxUmxuYUtSNm5OUjNV?=
 =?utf-8?B?VVNwbDJqVzFid2VEbHlZeE5MVkowdm96U3gvaTJjY3I4S1BtOHRyT0hQdUtC?=
 =?utf-8?B?TlF6bjNYYVRpUVJVOTNFVlFSN0NkTFUxV0JJZmNsNE1QUzQ3QTdLMTFxdUY1?=
 =?utf-8?B?NzZOMExFWklyVnB6YzZSdmNwNWdxd3hGdmtabW5ISlhOWDRiNmxSU3k4ajB5?=
 =?utf-8?B?NDRObWI0SmprVHArM0tNZHBJNHVUUitqNnFZUWpCWVlyWjk1N0hSSkRpQ09C?=
 =?utf-8?B?dVVwQTNDZHZ0aUpkcmFTcktpQ3dPWDFoWjZVak1lQ2tGNlBHVDVkazRFWGxx?=
 =?utf-8?B?YVlyR0hFRnJhZVovaktmNHJFRFhBdDFWaGYrVmt0WVNwbkNLcCtXMXBLeE1L?=
 =?utf-8?B?eU1IREk3bGQyZFFsVzFZVERpTFpRazlzZ3lHdHJLZEd6K0REYmNYREJveCtt?=
 =?utf-8?B?azBGZkFoUkxMRkJKT2loZkd4WE91OHh0RTFlMnFOMG51dTVubGZsdk5KWmgr?=
 =?utf-8?B?MnMvamRETGJoOTdrNEFmcUFjeGxTbDYxUTJHaEVUaWh4WThYcmUwWkYvbE1v?=
 =?utf-8?B?aFBoWm9ZYk90amozNzNvUTNZbHg2RmQxUUdtYmoxSW5UVDVkcVc0elg5S2VI?=
 =?utf-8?B?dnhKSUxYaHhGZDBTYVBCdjQwQUhFekJYclp5dTlTTWM2eGRmeEcyNENhUHdj?=
 =?utf-8?B?bm1GWG9IYUhBM2lQeFBqM1RKSkFPbDd2QVVIYmFjV3J3a0tiWXBoRElaNkFS?=
 =?utf-8?B?ekMwOE5ZdFdmMUp2WFhEM1FBUVpRYVNVTUJuSkxZTnJoVzlDcGJQZnZJT0Ns?=
 =?utf-8?B?cnhZQmVEUDE5anlQODZYa3ROejN5dmNjWUE1TTkxY0xFOFJUa3VSc0paemsw?=
 =?utf-8?B?THRXZWErUTVWcWpKV215VWswZGZQZHBldW0wcXI1TEpjWDIyV0FjNE1IMzV6?=
 =?utf-8?B?OStQeVdjZ3VocFIvZUdpbGhVa0NHSXZCSkZTejN4Z0cwQ3pGeEg3UzM5aW1K?=
 =?utf-8?B?MTVEc2dMTGFKcGQwNHE5Z2pkemFlWDBVR1FFMEhFYmlWZWVBcmlRVkNYZjRN?=
 =?utf-8?B?cktpWVgrUWtteVJybVIrS212c3FmNDBlZlhaNVVsaEZTdFFUM1h4UGVWcTda?=
 =?utf-8?B?M28xVklicmlLQ0lrT3g0WXh5UGtqdFFiSGtJV3AyNFBHV042VE91Q3hQbi93?=
 =?utf-8?B?T1lGZHp0S3BrdzA2bWNIM1ZEL0lNVjBJbTF3STVTaDVENEpaS2tOVjR1V1RL?=
 =?utf-8?B?cGJTWkZCMnQyd3JER0JmMS8yUDRuRXNKLy9RWXpPOHNiRk9mc3lGYXVDSUVU?=
 =?utf-8?B?MHV2Nm9mdjdyMkJIdUozTlFpQ09FemFUdit0UytyVE52SVFGU2VNK3pEb05W?=
 =?utf-8?B?Q0xKYzVnYWxnMWpjQ3p0OXFtUjlTZGhMU2RidFFwa1dnaFlZb3RodDRZcWJa?=
 =?utf-8?B?ekVSeGFXeGRnU2o4cUhvdU9ibzl6Tm5oMFd6NTkyMzNlczBMMGVjQ1FnWFNU?=
 =?utf-8?B?cFV3MUVUNDVKcjlTR3RNZXNhWXljdUszaVNtelZEZHMwT0kwOEgxWnhPSUpT?=
 =?utf-8?B?c1MxR3Q2OEhvcVBRL3V4bDBTTDRNMWxxYWFIRUU4SEd2enQrYXRLS2d3cVZX?=
 =?utf-8?B?bm0xaENHNHVSNUk5ZFpnUnkxYnVBeG9wbWQra21rZmFJNjRhTGMyU2JTL0xO?=
 =?utf-8?B?WjljTGYyT1dQS0hicGRsWVowaEtIZnVtYXpsOWdyTHRKWXo3Nzd0YXE0RXBT?=
 =?utf-8?B?dUN0d21SQjVINzc0aWF0TFBNSWZnNzVTTWxsNDdWMnRNQ1pjVGtLQmQwSzg2?=
 =?utf-8?B?dDM1V1hLRDE1M0craDJMQkVpbElFWDZmUVRHQ3pqY1RSVFNjZks1VmJQVEg3?=
 =?utf-8?B?YUtSUkJyUCs3Rks1Tm5lcjlXMGFNaG0rNktOaUZzQ05iTjloNXJXTytBQlNk?=
 =?utf-8?B?ZDRRZXkya1NoWWNyeUgrQVl4aStCaHh5OUtqTGQ4UlhrL3FWWGViSzV3Tjcr?=
 =?utf-8?B?clZyVnZ5ZFFsRHlDcy84ejRGTW9SaTJZSzMwb0M3d05xSDlnYmM3WU4wdTNl?=
 =?utf-8?B?TXRONW1aZ2hwYlJFWlZsRU1ROWFWMFBua2d5MVB3RWpyRVFpMUVQdzVvaENF?=
 =?utf-8?B?Z3hzR29UZUVSUDd0ZlU3dWhtWUYxUXdLVVp3cFBSVXRudjR2NlVRZXllckt4?=
 =?utf-8?B?K2hYQm1kd1R4dVVBeDlMaWZaRzdMRnJzV1NSaHlsK3E2VVUzMUZjTzRibUps?=
 =?utf-8?Q?hYK/9pnTaEBcyTko=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F480F1A432CD2D49B6ADA579A20C294C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33c09b59-e7f3-41c6-99fe-08da4de2e630
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 08:50:14.5770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: E+wyGvymepqAihnu+pW6uskT6BnmujGXyQV03BHHacOJ96CVYCCLu58Rswa3lTDH3gYABCLSWvhC/iJZoQ/VtY24lUlWol+S84Wz1UvDpew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6276
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEuMDYuMjAyMiAyMDo1OCwgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUaHUsIDkgSnVuIDIwMjIgMTE6MzI6
MDggKzAzMDANCj4gQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+
IHdyb3RlOg0KPiANCj4+IEFkZCBhIHBhcmFtZXRlciB0byBhdDkxX2FkY19yZWFkX2luZm9fcmF3
KCkgdG8gc3BlY2lmeSBpZiBzdC0+bG9jayBtdXRleA0KPj4gbmVlZCB0byBiZSBhY3F1aXJlZC4g
VGhpcyBwcmVwYXJlcyBmb3IgdGhlIGFkZGl0aW9uIG9mIHRlbXBlcmF0dXJlIHNlbnNvcg0KPj4g
Y29kZSB3aGljaCB3aWxsIHJlLXVzZSBhdDkxX2FkY19yZWFkX2luZm9fcmF3KCkgZnVuY3Rpb24g
dG8gcmVhZCAyIHZvbHRhZ2VzDQo+PiBmb3IgZGV0ZXJtaW5pbmcgdGhlIHJlYWwgdGVtcGVyYXR1
cmUuDQo+IA0KPiBUaGlzIGxvb2tzIGxpa2UgYSBwb3RlbnRpYWwgbG9jayBkZXBlbmRlbmN5IGlz
c3VlLg0KPiBpaW9fZGV2aWNlX2NsYWltX2RpcmVjdF9tb2RlKCkgdGFrZXMgYW4gaW50ZXJuYWwg
aWlvIGxvY2ssIGFuZA0KPiB5b3UgdGhlbiB0YWtlIHN0LT5sb2NrLg0KPiANCj4gSWYgeW91IGFy
ZSBnb2luZyB0byBpbnZlcnQgdGhhdCBsb2NraW5nIG9yZGVyIGluIGFub3RoZXIgcGF0aA0KPiB5
b3UgaGF2ZSBhIGRlYWRsb2NrLg0KPiANCj4gU28gcmV0aGluayB0aGlzLiBJZiB5b3Ugd2FudCB0
byByZXVzZSB0aGUgY29kZSB5b3UnbGwgbmVlZCB0byBmYWN0b3INCj4gaXQgb3V0IHRvIGEgc2Vw
YXJhdGUgZnVuY3Rpb24gdGhhdCB0YWtlcyBub25lIG9mIHRoZSBsb2NrcyB0aGVuDQo+IHRha2Ug
YWxsIGxvY2tzIG5lZWRlZCBpbiBlYWNoIGNhbGwgcGF0aCAoaW4gdGhlIHNhbWUgb3JkZXIpLg0K
DQpPSywgSSdsbCBjaGVjayBpdC4NCg0KPiANCj4gSm9uYXRoYW4NCj4gDQo+IA0KPj4NCj4+IFNp
Z25lZC1vZmYtYnk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29t
Pg0KPj4gLS0tDQo+PiAgZHJpdmVycy9paW8vYWRjL2F0OTEtc2FtYTVkMl9hZGMuYyB8IDE1ICsr
KysrKysrKystLS0tLQ0KPj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA1IGRl
bGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lpby9hZGMvYXQ5MS1zYW1h
NWQyX2FkYy5jIGIvZHJpdmVycy9paW8vYWRjL2F0OTEtc2FtYTVkMl9hZGMuYw0KPj4gaW5kZXgg
MTI4M2JjZjRlNjgyLi44ZjhmZWY0MmRlODQgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2lpby9h
ZGMvYXQ5MS1zYW1hNWQyX2FkYy5jDQo+PiArKysgYi9kcml2ZXJzL2lpby9hZGMvYXQ5MS1zYW1h
NWQyX2FkYy5jDQo+PiBAQCAtMTU4Myw3ICsxNTgzLDggQEAgc3RhdGljIGlycXJldHVybl90IGF0
OTFfYWRjX2ludGVycnVwdChpbnQgaXJxLCB2b2lkICpwcml2YXRlKQ0KPj4gIH0NCj4+DQo+PiAg
c3RhdGljIGludCBhdDkxX2FkY19yZWFkX2luZm9fcmF3KHN0cnVjdCBpaW9fZGV2ICppbmRpb19k
ZXYsDQo+PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCBpaW9fY2hhbl9z
cGVjIGNvbnN0ICpjaGFuLCBpbnQgKnZhbCkNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc3RydWN0IGlpb19jaGFuX3NwZWMgY29uc3QgKmNoYW4sIGludCAqdmFsLA0KPj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29sIGxvY2spDQo+PiAgew0KPj4gICAgICAg
c3RydWN0IGF0OTFfYWRjX3N0YXRlICpzdCA9IGlpb19wcml2KGluZGlvX2Rldik7DQo+PiAgICAg
ICBpbnQgKCpmbikoc3RydWN0IGF0OTFfYWRjX3N0YXRlICosIGludCwgdTE2ICopID0gTlVMTDsN
Cj4+IEBAIC0xNjAyLDEzICsxNjAzLDE1IEBAIHN0YXRpYyBpbnQgYXQ5MV9hZGNfcmVhZF9pbmZv
X3JhdyhzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2LA0KPj4gICAgICAgcmV0ID0gaWlvX2Rldmlj
ZV9jbGFpbV9kaXJlY3RfbW9kZShpbmRpb19kZXYpOw0KPj4gICAgICAgaWYgKHJldCkNCj4+ICAg
ICAgICAgICAgICAgcmV0dXJuIHJldDsNCj4+IC0gICAgIG11dGV4X2xvY2soJnN0LT5sb2NrKTsN
Cj4+ICsgICAgIGlmIChsb2NrKQ0KPj4gKyAgICAgICAgICAgICBtdXRleF9sb2NrKCZzdC0+bG9j
ayk7DQo+Pg0KPj4gICAgICAgaWYgKGZuKSB7DQo+PiAgICAgICAgICAgICAgIHJldCA9IGZuKHN0
LCBjaGFuLT5jaGFubmVsLCAmdG1wX3ZhbCk7DQo+PiAgICAgICAgICAgICAgICp2YWwgPSB0bXBf
dmFsOw0KPj4gICAgICAgICAgICAgICByZXQgPSBhdDkxX2FkY19hZGp1c3RfdmFsX29zcihzdCwg
dmFsKTsNCj4+IC0gICAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZzdC0+bG9jayk7DQo+PiArICAg
ICAgICAgICAgIGlmIChsb2NrKQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgIG11dGV4X3VubG9j
aygmc3QtPmxvY2spOw0KPj4gICAgICAgICAgICAgICBpaW9fZGV2aWNlX3JlbGVhc2VfZGlyZWN0
X21vZGUoaW5kaW9fZGV2KTsNCj4+DQo+PiAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+PiBA
QCAtMTY0NCw3ICsxNjQ3LDggQEAgc3RhdGljIGludCBhdDkxX2FkY19yZWFkX2luZm9fcmF3KHN0
cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsDQo+PiAgICAgICAvKiBOZWVkZWQgdG8gQUNLIHRoZSBE
UkRZIGludGVycnVwdGlvbiAqLw0KPj4gICAgICAgYXQ5MV9hZGNfcmVhZGwoc3QsIExDRFIpOw0K
Pj4NCj4+IC0gICAgIG11dGV4X3VubG9jaygmc3QtPmxvY2spOw0KPj4gKyAgICAgaWYgKGxvY2sp
DQo+PiArICAgICAgICAgICAgIG11dGV4X3VubG9jaygmc3QtPmxvY2spOw0KPj4NCj4+ICAgICAg
IGlpb19kZXZpY2VfcmVsZWFzZV9kaXJlY3RfbW9kZShpbmRpb19kZXYpOw0KPj4gICAgICAgcmV0
dXJuIHJldDsNCj4+IEBAIC0xNjU4LDcgKzE2NjIsOCBAQCBzdGF0aWMgaW50IGF0OTFfYWRjX3Jl
YWRfcmF3KHN0cnVjdCBpaW9fZGV2ICppbmRpb19kZXYsDQo+Pg0KPj4gICAgICAgc3dpdGNoICht
YXNrKSB7DQo+PiAgICAgICBjYXNlIElJT19DSEFOX0lORk9fUkFXOg0KPj4gLSAgICAgICAgICAg
ICByZXR1cm4gYXQ5MV9hZGNfcmVhZF9pbmZvX3JhdyhpbmRpb19kZXYsIGNoYW4sIHZhbCk7DQo+
PiArICAgICAgICAgICAgIHJldHVybiBhdDkxX2FkY19yZWFkX2luZm9fcmF3KGluZGlvX2Rldiwg
Y2hhbiwgdmFsLCB0cnVlKTsNCj4+ICsNCj4+ICAgICAgIGNhc2UgSUlPX0NIQU5fSU5GT19TQ0FM
RToNCj4+ICAgICAgICAgICAgICAgKnZhbCA9IHN0LT52cmVmX3V2IC8gMTAwMDsNCj4+ICAgICAg
ICAgICAgICAgaWYgKGNoYW4tPmRpZmZlcmVudGlhbCkNCj4gDQoNCg==
