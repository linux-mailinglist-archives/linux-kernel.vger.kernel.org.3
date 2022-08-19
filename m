Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B35AB599DA1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 16:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349555AbiHSOcW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 10:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349422AbiHSOcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 10:32:19 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8A9BEA33A;
        Fri, 19 Aug 2022 07:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660919537; x=1692455537;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VWyqepu5/oYiahH+n7isnmUV2y9xD4r1Bw6QGPue5zY=;
  b=ym4QI5jkYVO+4f6FdCF2wYdljPYuME8kQFoYkKEXG2eGVe2ErKikUESC
   8Q1GmYizFnK6qBsw+3W02OW4vy3j07qVrV4vrND6gOQtZbyhdbwzviFWf
   Q8ecK1GzVWKuE6HjMrtb/tO2wq9yBJWwo2V7ZkR5X+WUXUUSzAI7725Bj
   eZg2YEf9tew1uhudc6uRzAjogMFtRzFSJ8ipMJNGbXPQKkn00vqTCVcXJ
   RFRPFZ91qAw31RMfbqKzV4mJTnmnsjYaUkr1j8HjFbXGOjXzSsuhWF+iP
   3YGqidd8Brw0whB1PgB6S+CRyz0BaVGGJeS6FXI5sreG9FSsc8URQbXyK
   w==;
X-IronPort-AV: E=Sophos;i="5.93,248,1654585200"; 
   d="scan'208";a="177085967"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Aug 2022 07:32:16 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 19 Aug 2022 07:32:15 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Fri, 19 Aug 2022 07:32:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HH3pG0kY/YOIcMdmZBT2lxQhPBBBUYwh8R/J/Pzx2ZvY8jdxAQdwOaT6ikW9XL9BHaC9OduPAAJXU+4x69KFMFTzE3porTo0ZwhyGBmCJcUdChsmp4C4/tUgPZXCWDgfSZUIP74LfO54iTmcEXOA/TzmF/zAV8LNoqViDMJKSS0fX9T3m4qo7iDb+oSoVwtubFOeay6BKOydXcWaHI5sRiclByojG+BvA/rxeab1f6LmijJDCdG12oTiikLNJdwmI27wEeJ0NhI0KUv3zdYXOynPF1NW/m1OAPXTwhXYNUtcO1wK57C6AUOAo1/+6rCsQjOUYI5qYmoeMdyy40RIxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWyqepu5/oYiahH+n7isnmUV2y9xD4r1Bw6QGPue5zY=;
 b=JIoLEKTYlwdtB+EKL7U0VCAQr/VnUq0NrXO1mAU3wncmq7XWNn3Q5SHYfylByXJD5Oz+IE0p6DdH2/KBq4AvKPtnsxrS0Cdn0HaVDQaepv/M1DdNHnpUEjAknM7bfKWfs+aja5EseAbLiIOgo47WXi8ekyNkKGUrZ5Wp8CW3W9nmzd/UINCTrNoUA+8QK7gPJjhNUqmTnkQc+I+VyYT5aVQbOi/4wjeUYeULT7yd8u7BTn0kLBvcejT/4xhstXvFBtcUFnyER8dcP0CLu7wzXrjQO9o46OJNPDGza/kbUj3nG3gu/LwEU3nwgK7i+GmGVhdFg6CBwKqLWDVEE96b7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VWyqepu5/oYiahH+n7isnmUV2y9xD4r1Bw6QGPue5zY=;
 b=b3cZujPzlWj2QRYXvrhMk9OkIrM9R1ztGFNaHB2x0IQDg6krLdDSjuGS33BCdhHFi231cmn1h+e+7S+UQXU65f9v/xT7xMB2dTkCouYH5lsdwuOV5/tPfV/+knfjZ28gzHdvRXSuxUK/J4o2Co/EaqsQ5I+ruvnpceFsGqX6T6c=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM5PR1101MB2172.namprd11.prod.outlook.com (2603:10b6:4:50::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Fri, 19 Aug
 2022 14:32:10 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5546.018; Fri, 19 Aug 2022
 14:32:09 +0000
From:   <Conor.Dooley@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>, <mturquette@baylibre.com>,
        <sboyd@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <palmer@dabbelt.com>,
        <Daire.McNamara@microchip.com>
CC:     <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 6/6] riscv: dts: microchip: add the mpfs' fabric clock
 control
Thread-Topic: [PATCH 6/6] riscv: dts: microchip: add the mpfs' fabric clock
 control
Thread-Index: AQHYs8dCZDCkQVxYIEq9YtBMJX9yKK22LDYAgAAHm4CAAAPOAIAABY6AgAAFKACAAAINgIAAAmIAgAACh4A=
Date:   Fri, 19 Aug 2022 14:32:09 +0000
Message-ID: <560e80df-4819-1062-50ee-eb1d1d19bae1@microchip.com>
References: <20220819122259.183600-1-conor.dooley@microchip.com>
 <20220819122259.183600-7-conor.dooley@microchip.com>
 <3df8d4bd-3d38-cecd-6589-ccc1be01b886@linaro.org>
 <3ffba600-bda9-8ffa-a435-9a6f94e072b8@microchip.com>
 <f3d8be5c-737b-8c71-9926-a4036c797769@linaro.org>
 <19ca2ca1-c678-c669-4214-e92416e37191@microchip.com>
 <138af26e-8e36-63a0-d3a0-5af866318839@linaro.org>
 <f8496006-7487-7b7e-1a53-ec38492dfe70@microchip.com>
 <4e12e8c3-2170-eaab-d910-f674bcc93f79@linaro.org>
In-Reply-To: <4e12e8c3-2170-eaab-d910-f674bcc93f79@linaro.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1300ade7-c21e-43a0-443a-08da81ef9988
x-ms-traffictypediagnostic: DM5PR1101MB2172:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jP4CzNCLroctCqw5hPvYqUwp9hLuboMYWNrj/72JjD1hn7X9J11aG4SOUYrgtGhEJ3U5+ITO0vPSmha1lcUBjXDuLp0N810eJLyf0FQEm7gi3v3W7hqxTbDmyytzdIw+RbqZJLsXeFX2LoVsawrDLqMtH7l0josllAM+TV9SyGPbCLyeAhEwwCL2uvmhobAYy0W22rSHi4p1CbzTctjQIFasUkpMbFcpHZPrxodExPglq94ASlEnnT0Uh+AH51OkSCq2/0CrXvMrj3ZWrqTosFG157SMwen7blEBmUlc+wdm5ULeq4DYJS5IQ3ywslY+AYCcFhsoVlpg0Xdep0AODkfwG0flsAqc191Wl03642A59Ki37rwAqFqLMu2Y2A+HLOKHHrTJmZkb3IP7yTbJIfbN9odGAoA/UtCVj2Qr8BV78bp3gW1w1/baMM4QOe6pR7PDzWzcMeO2KMS7446PYxLOiEhBtHQjuFUwNMRJqOsFOqCT2Eq0CsodVYRZvQCgZ/u1t5+RY9eocZdCdxukp4ahu+rRL7oYB/eltjAKhEqoA2tBgWRtJWO4T7xNyo+oM3Jf9rwRvb8v11xvmqklRjsmImWhfqIBXDvH0WTXMxO3n7Ry0B8vG/pzMMThL5C8oGuRt8FMNPOHJnnu794EkWZnSSX5pDRrYibuEuyL2AjragEMAiR5n5QJjbmWkUg/okBFXl2MDdTJLo57HfqSfaK6Er2uZlfH7O61Gb/taWuMZ31pCYDQDwf3O9UZcCiR+PKJR4yiujsdnmAGXAU4Ku95hGQk770SYNwdwJvW2LumLMsBbK78a3C+mS5zWQsb6hJyalZBjfUEsOyOrFUQiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(346002)(39860400002)(136003)(366004)(396003)(186003)(2616005)(83380400001)(6636002)(316002)(91956017)(5660300002)(26005)(6506007)(6512007)(36756003)(31686004)(478600001)(41300700001)(71200400001)(53546011)(6486002)(38070700005)(86362001)(31696002)(122000001)(2906002)(76116006)(4326008)(8676002)(66946007)(64756008)(66556008)(66476007)(66446008)(54906003)(38100700002)(8936002)(7416002)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MzY4VEdnZkNZTkFYRHdvL3hpKy9FQUdZRW5waCtBSng2eWtrcWhLcFo4WkpX?=
 =?utf-8?B?Y0FKRklWZ05Jd21ZL1pLampwT3lUTWNpY3FnMWppalJHdnZnaUJxUDVNbG15?=
 =?utf-8?B?L1NoQVdrcm1oWWw0V3ltVThRL0U4elRwdDlodGhOOGphcWp3NGdvbzB1cmRi?=
 =?utf-8?B?MzU5OTBJcis2bnhiNkV5VVNKVk1CeXFhK1o5ZEZZdjN4bm1RVncxbGFTQUp0?=
 =?utf-8?B?VStjbzNkYklNVDBLem9TRFp0dlplM3RUeGtRcloxYzVaQnM1SHZWNitrWUFR?=
 =?utf-8?B?eC9sTjg2aE5LaWViSFl5bDFnVFVCbm56NHF1U3RJUENKMjZhQm8zcWZIZDVu?=
 =?utf-8?B?cm14R01rVmI0R09NbE1VSkY1SkFKZUlsRkVLKzNkRURoelBSYkdYQkkzV1g0?=
 =?utf-8?B?L2pBZlRwMENzWUlIZytLaUlXOUw0TmYxUjZIUWxuNlNlMGpoSHRDL3Facy9p?=
 =?utf-8?B?Y2QzTldWRUtkbUtubzBVR3pZQk10ZWRqb1FvZGprQzNhZ3V5ajlTVUpSRTlh?=
 =?utf-8?B?eTlFakt6NVN1dnVCR2cwdUV3UDQxa3k1bzV1OFBCa0FiRTRlQzdHdWkxQWt6?=
 =?utf-8?B?RGxXN2YrcXBjUnNiSXZDV2tUQnBqT25Ecjd1Wk5KaTF1T3ZlVzFrUDZsK0ZK?=
 =?utf-8?B?T3J2R0JuOVdXTzhub05qTCtrbS83dHJVdU56SEY2VEYwZ09iOXN6UVNDNlV3?=
 =?utf-8?B?d1MzTHpiRnpSMmUxbEtyR2pLeTJuWmlZNFJRSTJLZzdGZlZnSmFVbWpxbnMz?=
 =?utf-8?B?TnlGdmhrRGM1a1I0TGd3MFVLeXZkKzNwUGxqbEozenVubjY1ZEh1aGdTSC9Q?=
 =?utf-8?B?a2hRRXdkR1BjNzczRmVuMTYxUTVaQm5VVnZjaWNVeTlBSDhFTHBYSHQvb0Vj?=
 =?utf-8?B?TmpCK1ZXWkdNQ2FlSEgzQlduYVlBMzBOQWh1bFhJaWc0NllZRmxoQ0dwQng2?=
 =?utf-8?B?Ykk0dUIyS2dVZjRJZ05XaThCbGpoby9DbXI1R2txN1hvQ1NKSDdRb2Rlbzd0?=
 =?utf-8?B?OTFPeGpiODBzcFhiSkpSRkRRYjVYcTZzNVFjaW5WYU5DSzBROWJqYzc2Zkcv?=
 =?utf-8?B?VlV5a01SdVBOOW5VeHpRTDFibGhXRTdCYy9FRlMrbjhETmFCRnhUVCtCMnBz?=
 =?utf-8?B?cWZ5Q3Q2dXVsVnRCeTNTT3RjdTZaUzZUYlpzMi8wOUFacnFrU05hbmtOMGg5?=
 =?utf-8?B?ZzNzZ2RwblZDckJ2eGNudnFTdXFod2d1Z1B6dDdyQTdiUnd2RTAxVm5QRWcw?=
 =?utf-8?B?VnJuay8wRGNNTzkvZkJrNndzeTh5NDNiWFc5VWVwc1B2cURlKzNxM1FhUlVQ?=
 =?utf-8?B?RXR0bWpCWm1Xei8zZVBVTTVkemVkY2thQUdHWW5OUkYxb3dLTzR4OW81TWFz?=
 =?utf-8?B?MjNnc0ZTRE1HTEUvWUlqYTF5SW01UUc1TldGbUpETDVvcmJLaTg5Qi9pNWE5?=
 =?utf-8?B?VzZUTkN5YnQ3ZWVDR3ZUNHJZeTZndGkvZnY5Yk43eWpNOU5sTXN5MzVaRW5I?=
 =?utf-8?B?bTdCL1VmL1lRcC9hRjFuTXZmWkZsaWtobEtObTMrcEt1cGc5NXBNVGhJSHF2?=
 =?utf-8?B?NWcreEswN1ZqOHdyN3lXNmtkaU16NCtKb1hKVlhaajdjTEQva3FKNlNQRE1k?=
 =?utf-8?B?QXEzcjVFSkdsUG5TSWFrWjJkeEl4aC90cVdGL3BsaTVNWm9zZWIvV0lZRlJS?=
 =?utf-8?B?N2RsK3gzT0JDZ0Q4ODVSb1FEZjhRRU5INHN0TFNlanRDeVByK0NMNGJYYitr?=
 =?utf-8?B?cnVBOWkxaHlNRStOZnAzd1ZDaUh3Y3oxSVVROGlmVThZMExRdnRlWWh2bnI2?=
 =?utf-8?B?a0RhQ0FmSGFhdmgwVzh0S0ViMUorQUJ3ancxRUVmRXBoZ3lQQkRQOFNpZzlz?=
 =?utf-8?B?UmdQamdLWlduNmpYYWJQUXZPcXlXN1ZpWm5FQ25SdXlCSDNSckI1dm1DL0lQ?=
 =?utf-8?B?ZjE5NHg1clVkaEZPaWdoWGNETXhDRTdEc2VwSkRPUkYySkZVYzloOEJkbkEy?=
 =?utf-8?B?NVRuQU1HT1ZoV1IrcWVGRVN2bFJrVTJRbGRXYnJDdVoxMzg0SFY0dktlczVh?=
 =?utf-8?B?T0h4SDU5TWNyK2F6T3FMVklEeWlWU28ybS9FaTBBZnBacnJYQ1NROWdMMG1z?=
 =?utf-8?Q?lh8cyWXRNqHaEL73PZ3+QELZD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9B279053B053B45BF28701065A54778@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1300ade7-c21e-43a0-443a-08da81ef9988
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 14:32:09.8876
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sk66GTjjvvjUUTT9uNSLLSPBgT0WCNm/Z1xnfl46OAJnbCggScU45rS4HRj2WNI8ZUKS6nkZLRNrQoGhTOaZEMqPmo2p0NPIoEJ7gUv8mBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1101MB2172
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTkvMDgvMjAyMiAxNToyMiwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4gRVhURVJO
QUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5
b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiAxOS8wOC8yMDIyIDE3OjE0LCBD
b25vci5Eb29sZXlAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+IE9uIDE5LzA4LzIwMjIgMTU6MDYs
IEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBj
bGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVu
dCBpcyBzYWZlDQo+Pj4NCj4+PiBPbiAxOS8wOC8yMDIyIDE2OjQ4LCBDb25vci5Eb29sZXlAbWlj
cm9jaGlwLmNvbSB3cm90ZToNCj4+Pj4gT24gMTkvMDgvMjAyMiAxNDoyOCwgS3J6eXN6dG9mIEtv
emxvd3NraSB3cm90ZToNCj4+Pj4+PiBNYXliZSB0aGF0IGlzIG1lIGV4cGxvaXRpbmcgdGhlICJz
aG91bGQiLCBidXQgSSB3YXMgbm90IHN1cmUgaG93IHRvDQo+Pj4+Pj4gaW5jbHVkZSB0aGUgbG9j
YXRpb24gaW4gdGhlIGRldmljZXRyZWUuDQo+Pj4+Pg0KPj4+Pj4gTmVpdGhlciBub2RlIG5hbWVz
IG5vciBjbG9jayBuYW1lcyBhcmUgY29uc2lkZXJlZCBhbiBBQkksIGJ1dCBzb21lDQo+Pj4+PiBw
aWVjZXMgbGlrZSB0byByZWx5IG9uIHRoZW0uIE5vdyB5b3UgY3JlYXRlZCBzdWNoIGRlcGVuZGVu
Y3kgc28gaW1hZ2luZQ0KPj4+Pj4gc29tZW9uZSBwcmVwYXJlcyBhIERUU0kvRFRTIHdpdGggImNs
b2NrLWNvbnRyb2xsZXIiIG5hbWVzIGZvciBhbGwgZm91cg0KPj4+Pj4gYmxvY2tzLiBIb3cgeW91
IGRyaXZlciB3b3VsZCBiZWhhdmU/DQo+Pj4+DQo+Pj4+IC1FRVhJU1QsIHJlZ2lzdHJhdGlvbiBm
YWlscyBpbiB0aGUgY29yZS4NCj4+Pj4NCj4+Pj4+IFRoZSBEVFMgd291bGQgYmUgcGVyZmVjdGx5
IHZhbGlkIGJ1dCBkcml2ZXIgd291bGQgbm90IGFjY2VwdCBpdA0KPj4+Pj4gKGNvbmZsaWN0aW5n
IG5hbWVzKSBvciBiZWhhdmUgaW5jb3JyZWN0Lg0KPj4+Pj4NCj4+Pj4+IEkgdGhpbmsgd2hhdCB5
b3UgbmVlZCBpcyB0aGUgY2xvY2stb3V0cHV0LW5hbWVzIHByb3BlcnR5LiBUaGUgY29yZQ0KPj4+
Pj4gc2NoZW1hIGR0c2NoZW1hL3NjaGVtYXMvY2xvY2svY2xvY2sueWFtbCByZWNvbW1lbmRzIHVu
aWZpZWQNCj4+Pj4+IGludGVycHJldGF0aW9uIG9mIGl0IC0gbGlzdCBvZiBuYW1lcyBmb3IgYWxs
IHRoZSBjbG9ja3MgLSBidXQgYWNjZXB0cw0KPj4+Pj4gb3RoZXIgdXNlcywgZS5nLiBhcyBhIHBy
ZWZpeC4NCj4+Pj4NCj4+Pj4gU28gY291bGQgSSBkbyBgY2xvY2stb3V0cHV0LW5hbWVzID0gImNj
Y19udyI7YC4gVGhhdCB3b3VsZCB3b3JrIGZvciBtZSwNCj4+Pj4gd2l0aCBvbmUgcXVlc3Rpb246
DQo+Pj4+IEhvdyB3b3VsZCBJIGVuZm9yY2UgdGhlIHVuaXF1ZS1uZXNzIG9mIHRoaXMgcHJvcGVy
dHksIHNpbmNlIGl0IHdvdWxkIGJlDQo+Pj4+IGEgcGVyIENDQy9jbG9jay1jb250cm9sbGVyIHBy
b3BlcnR5PyBNYXliZSBJIG1pc3NlZCBzb21ldGhpbmcsIGJ1dCBJDQo+Pj4+IGdhdmUgaXQgYSBz
aG90IHdpdGggdHdvIGRpZmZlcmVudCBDQ0Mgbm9kZXMgaGF2aW5nICJjY2NfbnciICYgZHRic19j
aGVjaw0KPj4+PiBkaWQgbm90IGNvbXBsYWluLiBVcCB0byBtZSB0byBleHBsYWluIHRoZSByZXN0
cmljdGlvbiBpbiB0aGUgZHQtYmluZGluZ3MNCj4+Pj4gZGVzY3JpcHRpb24/DQo+Pj4NCj4+PiBV
bmlxdWVuZXNzIGFtb25nIGVudGlyZSBEVFM/IEkgZG9uJ3QgdGhpbmsgeW91IGNhbiwgZXhjZXB0
IG9mIGNvdXJzZQ0KPj4+IG1lbnRpb25pbmcgaXQgaW4gZGVzY3JpcHRpb24uIFlvdXIgZHJpdmVy
IHNob3VsZCBoYW5kbGUgc3VjaCBEVFMgLQ0KPj4+IG1pbmltYWxseSBieSBncmFjZWZ1bGx5IGZh
aWxpbmcgYnV0IGJldHRlciBiZWhhdmluZyBpbiBzb21lIGRlZmF1bHQgd2F5Lg0KPj4NCj4+IEl0
IGZhaWxzIG5vdC10b28tZ3JhY2VmdWxseSBhdCB0aGUgbW9tZW50LCBidXQgdGhhdCBjb3VsZCBl
YXNpbHkgYmUNCj4+IGNoYW5nZWQuIFRydW5jYXRlZCBiYXNlIGFkZHJlc3MgSSBzdXBwb3NlIHdv
dWxkIGJlIGEgbWVhbmluZ2Z1bCB0aGluZw0KPj4gdG8gZmFsbCBiYWNrIHRvIGFmdGVyd2FyZHMu
DQo+Pg0KPj4+DQo+Pj4+DQo+Pj4+IEZXSVcgSSB3b3VsZCB0aGVuIGhhdmU6DQo+Pj4+IGNjY19z
dzogY2xvY2stY29udHJvbGxlckAzODQwMDAwMCB7DQo+Pj4+ICAgICAgICAgY29tcGF0aWJsZSA9
ICJtaWNyb2NoaXAsbXBmcy1jY2MiOw0KPj4+PiAgICAgICAgIHJlZyA9IDwweDAgMHgzODQwMDAw
MCAweDAgMHgxMDAwPiwgPDB4MCAweDM4ODAwMDAwIDB4MCAweDEwMDA+LA0KPj4+PiAgICAgICAg
ICAgICAgIDwweDAgMHgzOTQwMDAwMCAweDAgMHgxMDAwPiwgPDB4MCAweDM5ODAwMDAwIDB4MCAw
eDEwMDA+Ow0KPj4+PiAgICAgICAgICNjbG9jay1jZWxscyA9IDwxPjsNCj4+Pj4gICAgICAgICBj
bG9jay1vdXRwdXQtbmFtZXMgPSAiY2NjX3N3IjsNCj4+Pj4gICAgICAgICBzdGF0dXMgPSAiZGlz
YWJsZWQiOw0KPj4+PiB9Ow0KPj4+Pg0KPj4+PiAmIGluIHRoZSBiaW5kaW5nOg0KPj4+PiAgICAg
IGNsb2NrLW91dHB1dC1uYW1lczoNCj4+Pj4gICAgICAgIHBhdHRlcm46IF5jY2NfW25zXVtld10k
DQo+Pj4NCj4+PiBZZXMsIGFsdGhvdWdoIHRoaXMgd29uJ3QgZW5mb3JjZSB1bmlxdWVuZXNzLg0K
Pj4NCj4+IEkga25vdyA6KCBJJ2xsIHJlc3BpbiBuZXh0IHdlZWsgSSBndWVzcywgdGhhbmtzIGFn
YWluLg0KPiANCj4gDQo+IFRoZSBpc3N1ZSB3aXRoIHRoaXMgaXMgdGhhdCB3ZSBhcmUgZ2V0dGlu
ZyBjbG9zZSB0byB0eWluZyBiaW5kaW5ncyB3aXRoDQo+IHlvdXIgTGludXggaW1wbGVtZW50YXRp
b24uIFdoYXQgaWYgb3RoZXIgaW1wbGVtZW50YXRpb24gZG9lcyBub3QgdXNlDQo+IHRoZXNlIG5h
bWVzIGFzIHByZWZpeCBhbmQgaW5zdGVhZCBjcmVhdGVzIHNvbWUgb3RoZXIgY2xvY2sgbmFtZXMg
KGFzDQo+IGNsb2NrIG5hbWVzIGFyZSBub3QgY29uc2lkZXJlZCBBQkkpPyBZb3VyIGJpbmRpbmcg
d291bGQgc3RpbGwgZW5mb3JjZQ0KPiBzdWNoIHByb3BlcnR5IHdpdGggYSBzcGVjaWZpYyBwYXR0
ZXJuLg0KPiANCj4gVGhlIGNsb2NrIG5hbWVzIHNob3VsZCBub3QgcmVhbGx5IG1hdHRlciwgc28g
aWYgeW91IGhhdmUgY29uZmxpY3Qgb2YNCj4gbmFtZXMgYW1vbmcgbXVsdGlwbGUgY29udHJvbGxl
cnMsIEkgdGhpbmsgZHJpdmVyIHNob3VsZCBlbWJlZCB1bml0DQo+IGFkZHJlc3MgaW4gdGhlIG5h
bWUgKGFzIGZhbGxiYWNrIG9mIGNsb2NrLW91dHB1dC1uYW1lKSBhbmQgdGhlIGJpbmRpbmcNCj4g
c2hvdWxkIG5vdCBlbmZvcmNlIHNwZWNpZmljIHBhdHRlcm4uDQoNCk5vdCBzdXJlIGlmIHlvdSBq
dXN0IHBhc3NlZCBvdmVyIGl0LCBidXQgSSBhZ3JlZToNCj4+IFRydW5jYXRlZCBiYXNlIGFkZHJl
c3MgSSBzdXBwb3NlIHdvdWxkIGJlIGEgbWVhbmluZ2Z1bCB0aGluZw0KPj4gdG8gZmFsbCBiYWNr
IHRvIGFmdGVyd2FyZHMuDQoNCkJ1dCBpZiB0aGUgbmFtZXMgYXJlbid0IGFuIEFCSSwgdGhlbiBl
aXRoZXIgdGhlcmUncyBub3QgbXVjaCBwb2ludCBpbg0KaGF2aW5nIHRoZSByZWdleCBhdCBhbGwg
Zm9yIGNsb2NrLW91dHB1dC1uYW1lcyBvciBmYWlsaW5nIHRoZSBjaGVjayBmb3INCml0IGRvZXMg
bm90IG1hdHRlci4gSSdsbCBoYXZlIGEgdGhpbmsgb3ZlciB0aGUgd2Vla2VuZCBhYm91dCB3aGF0
DQpleGFjdGx5IHRvIGRvLCBidXQgSSB0aGluayB0aGUgZHJpdmVyIHNpZGUgb2YgdGhpcyBpcyBj
bGVhciB0byBtZSBub3cgJg0Kd2hhdCBub3QgdG8gZG8gaW4gdGhlIGJpbmRpbmcgaXMgdG9vLg0K
DQo+IEkgY2FuIGVhc2lseSBpbWFnaW5lIGEgcmVhbCBoYXJkd2FyZSBib2FyZCBkZXNpZ24gd2l0
aA0KPiAic2V4eV9kdWNrX2NjY19wbGwxX291dDMiIGNsb2NrIG5hbWVzLiA6KQ0KDQpJZiBBbGVz
dG9ybSBtYWRlIGEgYm9hcmQgd2l0aCBvdXIgRlBHQSwgSSBjb3VsZCBzZWUgdGhhdC4uDQpJJ2Qg
YnV5IHRoZSB0LXNoaXJ0IHRvbyENCg0K
