Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271925879DE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 11:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236279AbiHBJb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 05:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236303AbiHBJbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 05:31:32 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5123F319;
        Tue,  2 Aug 2022 02:31:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659432691; x=1690968691;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9tUICVL52Oo5M/jv7hEA4TWB24Vc62vNhZ269HPoUHE=;
  b=TEUqwX2mdjVJiL1yC7gq5pIxiAghhtWiQD0JV93PHnZPKZ5/2iztqjrp
   NDodbKv0zBiwRHkrfa9t9RB5x42OqrCiXy0FfK4Gvf7x0VMPkzLhquVwM
   gVSaiUGMsj2gNbo8QA1FGSSD2iLa1V3T3S2fyIKx86Mbh3kdeeWssNPfQ
   akTaVNfjVwn/QqnJd8CXnuzROkN/Rcy2BsGgGzIKDdD3CMdW2sNhi8eg7
   WrrslA2CcK5/P7WCBWSJkfjjcJM0/4MuWk5309LhJvjlGDW0YpEofwzbK
   GA0ZF2OiQac1WC6pal6nqmQQWKP2aw4MWly9oCsSxyop45E1nBb1jAWAI
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,210,1654585200"; 
   d="scan'208";a="174549762"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Aug 2022 02:31:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 2 Aug 2022 02:31:30 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 2 Aug 2022 02:31:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lJ3XLqo+SNndguu6evVUpQ2MUy9QAEsQRrv/s9a1BNq8YZ13VfiVk0c27FF8gsM9mSDkFTK8Mn8HYU6RbO1n65stdFRbUdW3MsOCJitU59dQUPSnjbRZHL1FoVmut4onV8dBmranNs1KeL4VIC3H7jOumrKD7rilSC+dPM7OklucNMq727B7hpNVFjZ7Gf0o/IUK79I6y+uxvknQP8n4Waolf4CjYmYjvfkqH+Spmd0GRJJlLHJejHoURJ6rmI+hy1cB7S15fAftuzJDs8s1aYjxr9+KjLx/tlzsnwUp1hNXqrsd9R6xaqlyhRzRHnJ+MHwVFPoK0zYto5jw9BtJLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tUICVL52Oo5M/jv7hEA4TWB24Vc62vNhZ269HPoUHE=;
 b=g6AsjDfkZFIIl4YQ9E9HwDPSsJmCmELxb+glKot5M6WLGezFnez5r0oliR6JE859oBT+rZ7k/W+jQklND6B2owYK7WPc6jBP5TcpX53rULxo1JN1Hn9eDNB8iFDSTs2tB+BAaDI2QO+1YB8FxqL9p4sZKKgGRxqdpNTBxHceUaV7vZDu8aXL2/5E8etbin+JLq7gcYXZym/mirtfpjy+PIaZb+RMa+haL4r7ZZ01LjHFCcJ10tU7t8dgJX7dAKFySu96ivSEOSu49lOpgqptu1E9Liy3NOenYzCHQA+jjqrG30VudeXvXxBlSrHZtWuSsTjn8BV9IKTuWWuYtDI3Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tUICVL52Oo5M/jv7hEA4TWB24Vc62vNhZ269HPoUHE=;
 b=A0AZUhA+zaU/l0HNC7xg04xJ4mNJr+ucTdbFOCl4tjISg9NktEeylT90BNKNXisnlS9TYRER/gSD2s3tHnQsjPwj9VXwj1qTQD96aTXjjhu4E/y+L2Sx7+tIazXhlq2rBSDKn5fOxpaXuLkqNICMXuJqNiHYsJpPDQ/7P/zLlCM=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SA2PR11MB4858.namprd11.prod.outlook.com (2603:10b6:806:f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.11; Tue, 2 Aug
 2022 09:31:27 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 09:31:27 +0000
From:   <Conor.Dooley@microchip.com>
To:     <Nagasuresh.Relli@microchip.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Conor.Dooley@microchip.com>
CC:     <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] spi: microchip-core-qspi: Add support for
 microchip fpga qspi controllers
Thread-Topic: [PATCH v2 2/3] spi: microchip-core-qspi: Add support for
 microchip fpga qspi controllers
Thread-Index: AQHYpj5hAfrFjtawWkW7pKGOs9c5LK2bWPOA
Date:   Tue, 2 Aug 2022 09:31:27 +0000
Message-ID: <557f3938-002e-5649-a419-3334bd56f411@microchip.com>
References: <20220802070518.855951-1-nagasuresh.relli@microchip.com>
 <20220802070518.855951-3-nagasuresh.relli@microchip.com>
In-Reply-To: <20220802070518.855951-3-nagasuresh.relli@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 279ffbc3-32f7-41f3-d578-08da7469c684
x-ms-traffictypediagnostic: SA2PR11MB4858:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R0Unr6X21iA/1GzceOLu0yF3rfO8hNNn2lgy55CUjcwx0yItKHFCdTom+FOe8F4RNyW+B3Qw5jC76/3uNaKdsvVeqTFOw7ue6vDNJXTtrro3KbGhuCwZDBVYPHrHFOcDFnjAhNs9SQWMlieahJa2pKmehGugxX1grOoVDynhK9Yj/hFULdFZxu84yKre8KHrLjrV84EaJ8g1UoXHNIKSqwVKOWwcax/jM1o0YpJJj9liwBzvvcGUnZvcLERW4vRdoFkw7uWX5BuLmiSQgZsJWlCfMMhR7KaCckjkJugvOXsdxyapUdfsxXQmDMiHNSdl/J/UfC0wYkG59SuC5qN7wAcFvKe77fv6mpTueFYveb2CcmaqYexymwYIeZitXVm7F+m3pB3YypPd/lTJmDNlQjtLqGYTwfmP/gGM4gxMq4TMrxEHLy4Ond4bC2iUMYz3EfE9a6zqvq5HYc7X9kGLJjp0JdlvhUyMM4D64EsTPeDv+3DlSn3iajZbcQGTRh414c3HXLsxyjFwpmxVNXidAoffOMBSAEa4OgTxMJezbktivBDrGWcrJZCbVNQv0NSXo/q3iIoI85aLHtsD0M3n4MhF/doiULWaOWT4Z2CvMuoBpkbm7dQjVchVQx+2kuoUlV116jkrh/2sMXDn31ZZ1YZGY23pYm4MF9XGO8c+50Tgp2tvcbywPZ0LW0kNiOS68cr2/gEROsozaQQZ5e0bonANwN/z2FloFEH6lneJDwQVUqAW8CYcm3zkuAdddVLe5/W97JKSl9GAJM74L0I4DXqmIRO4d1S4bTS9zcg8vXmfwUQzfCaiM4FPWmqQC/wT83OJvfmF7x3vKgrjEBV3BKwGvlm1E/+lmNemTKZ5bdjqlZrUGwBRXxeU23JhyfpV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(136003)(366004)(376002)(346002)(396003)(83380400001)(91956017)(2616005)(186003)(4326008)(8936002)(36756003)(2906002)(66446008)(8676002)(5660300002)(66476007)(64756008)(31686004)(76116006)(66946007)(66556008)(316002)(71200400001)(86362001)(54906003)(110136005)(478600001)(41300700001)(6506007)(31696002)(53546011)(6512007)(26005)(38070700005)(38100700002)(122000001)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SVNhUjlTZVp6QWg1L3kzUW0vbzFFOXJDRThQSlVqYncrUlJQY0VUNFgwd0Z6?=
 =?utf-8?B?QWJVR1ZJekMyU0EreDNadWorSGFpbjJUUHBoT3RXbk9oNWs0VVA1NHFZdmhN?=
 =?utf-8?B?U3ZMUXBNSjhXaTlVVWdLcUYrN3FJV2VNNE5VSWlmc0lrZ2pac05ONFlFaUxz?=
 =?utf-8?B?OHhjaG5pQVZ3MjlVMTF4ZHh1TXErblpPTlM5bC9KYUxvQXR3alkvamFsSE1B?=
 =?utf-8?B?ejJ4T1IwTGkvZml6S1gyNEI1bnFMb3RLVG16djlaQW54VzkyVFZSdWtyRnR5?=
 =?utf-8?B?WjNJT0kxWi82YkhBcEVrTldwN2hxcGpNTGRuNHZMeWpMMWJnMi9FZzhNTXRj?=
 =?utf-8?B?bjJtTUVJdkUwcGgwK2F2N015L0U3M2RrMldKZi9jTXJkdW9qZVhWYzk5dXV3?=
 =?utf-8?B?b0JOWEYzclpndlI1amlyZFdoMjk2a0NtL2pOc2EyMG9YNDJpb2JyVWNCRTda?=
 =?utf-8?B?T0FVRnBtcFlWc3U3Z3ZkV2ZzUmoweTYrMkt1ekxiejhXNlhJT253U09VZUow?=
 =?utf-8?B?QmtBMlN2QW1qeWxucHVFN3lub2lKRFVHSFpzN0RSWjJpOUczcGFJRGx4eTdT?=
 =?utf-8?B?blpJUHZaa29FUE9QUmZHOHlnSXgvS3JZS3kvdndKNi9UeHVPTGdSVW02eXAz?=
 =?utf-8?B?WEVIMUVxS08rcmtWbnVEMDBHbFFuc3pEQmxpYmFNM2tMV3htT1o1STZUVzAv?=
 =?utf-8?B?VUFlQlc2akppd0thbDVGTjdHSGVITnpQR0ZTZlVFb3NCcTlxMVlVY1VNZU5R?=
 =?utf-8?B?K3ovRThYamJ2eXd4cTB5STZmbm1IdnA4ODJQN3VudFlPdExPRkNGWWhXN05K?=
 =?utf-8?B?UG5rMEhoTXdtUENYVjMvODZJT0t1Z1FybnVBazEwd0laYTQ0VFQyUVpCVkFt?=
 =?utf-8?B?QVpLTWM1RjZlVC9NcW5PL2o0MkRGb0tyRWpGbm5DbktraHppMmlwbklmUDVy?=
 =?utf-8?B?UThpeHk3aVZSdWxGYVRVeHB2cVJ2REFPQVF3Tm9sNWQvV001MUErNFgzNzNj?=
 =?utf-8?B?a0pnM3QxTWJiMHN3RE5ZT3hEcDdFU0JkczRlTTg2VUpIU1lSZncrMWtML3JK?=
 =?utf-8?B?VWQ5Q0hpeU5OZVNNT2F4QTVjM203bm1QZHpiTlZZQ1NlSTVMMmU5enZqaS9N?=
 =?utf-8?B?QlgrOEZrM1NZeFdHZldFL3VlNS9ITjNzV0NaTGtIbWlGRDFuQ3FCVWxlWlpk?=
 =?utf-8?B?T2ErZFRtSlZiZDcvdnJHTEI4b0VPbUlGbGVPb3ErNUVnbHM4N2VCbDlZRU1B?=
 =?utf-8?B?eThEZnpLeHpIR2I5L0NxTVd1MmtJc0ZPS3Y1ZUU1UVhWL012MjgwTFNqR2sx?=
 =?utf-8?B?TVVTV2taMWlUZlJBZlRnRVZsVTV3SVhVNTFsOTF0TEpOYXBScjJJME5oZTZz?=
 =?utf-8?B?M3JkY2xXaDJJaHdKQXVkcTFTWGNnTDZWY2RCK29NdVY0dGRUVkVFaGFWQWZW?=
 =?utf-8?B?R0JWaFNIYytyQ3hHd2NKM0FodEpmaE4xOHhIWHZrN09jUzBNb1YyVUN5em8y?=
 =?utf-8?B?Q1loVVM4UDBER2x0S05hRk5rTTN3UnVGdFM4N1RTbVZkZU4xMmVOOUthZ2Q4?=
 =?utf-8?B?d3JYNVJ4VkUrUzVBUHVJdXZ1VHdNU3J3U3dXaUVDN1AzYXNuV2gxNlFhU3hH?=
 =?utf-8?B?b0JrWFZYWlhsWG9QSTl5c25mNlh4bXI2ZThVNFRHNlYweTJVTVp0TTJqbS9n?=
 =?utf-8?B?YVZrcTFxdk5IOWdxckl1bUdOTC90OGwyaG5HdXNSODdlazFsSExlUWtUUm41?=
 =?utf-8?B?a29UL1M3Tm9UbzBVaENNVkVET3BVUWRZTzUrbjZhVVFMdjZ6MFJZTHFTZlpR?=
 =?utf-8?B?TENBVTdVV0YyLzJDQldWUVFUbElKK0thYVZSSjNlSGI2emM2TVVFTi9kZkFM?=
 =?utf-8?B?REk5T3liTVlYdmZEZHRRR2ZyMVhVTVdQa29NYzNHV3c1dTd5bzlVK1hsMWc2?=
 =?utf-8?B?YjBVRWY3NVdhajJ5YXlrb29VQit0NFF3MzlwenFqc3V5UldsN29uZUUrTzRj?=
 =?utf-8?B?SHFkODJhS2pSeWR6VzN2MStYNDFnaktQSjYyekFVTG16RSsxSHQ0TFJ0MXEw?=
 =?utf-8?B?aWJmWTdObFRQOUFlN3dmc2NZcWtGTnpJNkRxOC9FOU91elVxQUIxU2JXWFYw?=
 =?utf-8?Q?jkbY/iJBwrJyr/2zl6mll301S?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <10E8C984EC0074438CA5DD55709A1909@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 279ffbc3-32f7-41f3-d578-08da7469c684
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Aug 2022 09:31:27.6704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PSFFpnhWq+LKjQd9mbnOyp2sITooBT6OE9CuhPeBmyqKSMqIzTyWVlEuIaf96G7TRWL/1w/7VaiIjKLC8cw5hzQy9kF2JsTeBjb59ekPhqM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4858
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDIvMDgvMjAyMiAwODowNSwgTmFnYSBTdXJlc2hrdW1hciBSZWxsaSB3cm90ZToNCj4gQWRk
IGEgZHJpdmVyIGZvciBNaWNyb2NoaXAgRlBHQSBRU1BJIGNvbnRyb2xsZXJzLiBUaGlzIGRyaXZl
ciBhbHNvDQo+IHN1cHBvcnRzICJoYXJkIiBRU1BJIGNvbnRyb2xsZXJzIG9uIFBvbGFyZmlyZSBT
b0MuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBOYWdhIFN1cmVzaGt1bWFyIFJlbGxpIDxuYWdhc3Vy
ZXNoLnJlbGxpQG1pY3JvY2hpcC5jb20+DQo+IC0tLQ0KPiAgIGRyaXZlcnMvc3BpL0tjb25maWcg
ICAgICAgICAgICAgICAgICAgfCAgIDkgKw0KPiAgIGRyaXZlcnMvc3BpL01ha2VmaWxlICAgICAg
ICAgICAgICAgICAgfCAgIDEgKw0KPiAgIGRyaXZlcnMvc3BpL3NwaS1taWNyb2NoaXAtY29yZS1x
c3BpLmMgfCA2MDkgKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gICAzIGZpbGVzIGNoYW5n
ZWQsIDYxOSBpbnNlcnRpb25zKCspDQo+ICAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvc3Bp
L3NwaS1taWNyb2NoaXAtY29yZS1xc3BpLmMNCj4gDQoNCi0tLTg8LS0tDQoNCj4gK3N0YXRpYyBp
bnQgbWNocF9jb3JlcXNwaV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAr
ew0KPiArCXN0cnVjdCBzcGlfY29udHJvbGxlciAqY3RscjsNCj4gKwlzdHJ1Y3QgbWNocF9jb3Jl
cXNwaSAqcXNwaTsNCj4gKwlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiArCXN0
cnVjdCBkZXZpY2Vfbm9kZSAqbnAgPSBkZXYtPm9mX25vZGU7DQo+ICsJaW50IHJldDsNCj4gKw0K
PiArCWN0bHIgPSBkZXZtX3NwaV9hbGxvY19tYXN0ZXIoJnBkZXYtPmRldiwgc2l6ZW9mKCpxc3Bp
KSk7DQo+ICsJaWYgKCFjdGxyKQ0KPiArCQlyZXR1cm4gZGV2X2Vycl9wcm9iZSgmcGRldi0+ZGV2
LCAtRU5PTUVNLA0KPiArCQkJCSAgICAgInVuYWJsZSB0byBhbGxvY2F0ZSBtYXN0ZXIgZm9yIFFT
UEkgY29udHJvbGxlclxuIik7DQo+ICsNCj4gKwlxc3BpID0gc3BpX2NvbnRyb2xsZXJfZ2V0X2Rl
dmRhdGEoY3Rscik7DQo+ICsJcGxhdGZvcm1fc2V0X2RydmRhdGEocGRldiwgcXNwaSk7DQo+ICsN
Cj4gKwlxc3BpLT5yZWdzID0gZGV2bV9wbGF0Zm9ybV9pb3JlbWFwX3Jlc291cmNlKHBkZXYsIDAp
Ow0KPiArCWlmIChJU19FUlIocXNwaS0+cmVncykpIHsNCj4gKwkJcmV0ID0gUFRSX0VSUihxc3Bp
LT5yZWdzKTsNCj4gKwkJZ290byByZW1vdmVfbWFzdGVyOw0KDQpIZXkgU3VyZXNoLA0KDQpTaW5j
ZSB5b3Ugc3dpdGNoZWQgdG8gdXNpbmcgZGV2bV9zcGlfYWxsb2NfbWFzdGVyKCkgdGhlc2UgZ290
b3MgYXJlDQpubyBsb25nZXIgbmVlZGVkLCBhbmQgd2lsbCBjYXVzZSBhIGRvdWJsZSBwdXQoKSBv
ZiB0aGUgY29udHJvbGxlci4NCmRldm1fc3BpX2FsbG9jX21hc3RlcigpIHNob3VsZCBlbnN1cmUg
dGhhdCBzcGlfY29udHJvbGxlcl9wdXQoKSBpcw0KY2FsbGVkIGluIHRoZSBjYXNlIG9mIGEgZmFp
bHVyZS4gWW91IHNob3VsZCBqdXN0IGJlIGFibGUgdG8gcmV0dXJuDQpkZXZfZXJyX3Byb2JlIGhl
cmUgJiByZW1vdmUgdGhlIHJlbW92ZV9tYXN0ZXIgbGFiZWwuDQoNClRoYW5rcywNCkNvbm9yLg0K
DQo+ICsJfQ0KPiArDQo+ICsJcXNwaS0+Y2xrID0gZGV2bV9jbGtfZ2V0KCZwZGV2LT5kZXYsIE5V
TEwpOw0KPiArCWlmIChJU19FUlIocXNwaS0+Y2xrKSkgew0KPiArCQlkZXZfZXJyKCZwZGV2LT5k
ZXYsICJjbG9jayBub3QgZm91bmQuXG4iKTsNCj4gKwkJcmV0ID0gUFRSX0VSUihxc3BpLT5jbGsp
Ow0KPiArCQlnb3RvIHJlbW92ZV9tYXN0ZXI7DQo+ICsJfQ0KPiArDQo+ICsJcmV0ID0gY2xrX3By
ZXBhcmVfZW5hYmxlKHFzcGktPmNsayk7DQo+ICsJaWYgKHJldCkgew0KPiArCQlkZXZfZXJyKCZw
ZGV2LT5kZXYsICJmYWlsZWQgdG8gZW5hYmxlIGNsb2NrXG4iKTsNCj4gKwkJZ290byByZW1vdmVf
bWFzdGVyOw0KPiArCX0NCj4gKw0KPiArCWluaXRfY29tcGxldGlvbigmcXNwaS0+ZGF0YV9jb21w
bGV0aW9uKTsNCj4gKwltdXRleF9pbml0KCZxc3BpLT5vcF9sb2NrKTsNCj4gKw0KPiArCXFzcGkt
PmlycSA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwgMCk7DQo+ICsJaWYgKHFzcGktPmlycSA8PSAw
KSB7DQo+ICsJCXJldCA9IHFzcGktPmlycTsNCj4gKwkJZ290byBjbGtfZGlzX2FsbDsNCj4gKwl9
DQo+ICsNCj4gKwlyZXQgPSBkZXZtX3JlcXVlc3RfaXJxKCZwZGV2LT5kZXYsIHFzcGktPmlycSwg
bWNocF9jb3JlcXNwaV9pc3IsDQo+ICsJCQkgICAgICAgSVJRRl9TSEFSRUQsIHBkZXYtPm5hbWUs
IHFzcGkpOw0KPiArCWlmIChyZXQpIHsNCj4gKwkJZGV2X2VycigmcGRldi0+ZGV2LCAicmVxdWVz
dF9pcnEgZmFpbGVkICVkXG4iLCByZXQpOw0KPiArCQlnb3RvIGNsa19kaXNfYWxsOw0KPiArCX0N
Cj4gKw0KPiArCWN0bHItPmJpdHNfcGVyX3dvcmRfbWFzayA9IFNQSV9CUFdfTUFTSyg4KTsNCj4g
KwljdGxyLT5tZW1fb3BzID0gJm1jaHBfY29yZXFzcGlfbWVtX29wczsNCj4gKwljdGxyLT5zZXR1
cCA9IG1jaHBfY29yZXFzcGlfc2V0dXBfb3A7DQo+ICsJY3Rsci0+bW9kZV9iaXRzID0gU1BJX0NQ
T0wgfCBTUElfQ1BIQSB8IFNQSV9SWF9EVUFMIHwgU1BJX1JYX1FVQUQgfA0KPiArCQkJICBTUElf
VFhfRFVBTCB8IFNQSV9UWF9RVUFEOw0KPiArCWN0bHItPmRldi5vZl9ub2RlID0gbnA7DQo+ICsN
Cj4gKwlyZXQgPSBkZXZtX3NwaV9yZWdpc3Rlcl9jb250cm9sbGVyKCZwZGV2LT5kZXYsIGN0bHIp
Ow0KPiArCWlmIChyZXQpIHsNCj4gKwkJZGV2X2VycigmcGRldi0+ZGV2LCAic3BpX3JlZ2lzdGVy
X2NvbnRyb2xsZXIgZmFpbGVkXG4iKTsNCj4gKwkJZ290byBjbGtfZGlzX2FsbDsNCj4gKwl9DQo+
ICsNCj4gKwlyZXR1cm4gMDsNCj4gKw0KPiArY2xrX2Rpc19hbGw6DQo+ICsJY2xrX2Rpc2FibGVf
dW5wcmVwYXJlKHFzcGktPmNsayk7DQo+ICtyZW1vdmVfbWFzdGVyOg0KPiArCXNwaV9jb250cm9s
bGVyX3B1dChjdGxyKTsNCj4gKw0KPiArCXJldHVybiByZXQ7DQo+ICt9DQo=
