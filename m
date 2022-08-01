Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88111586B74
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233221AbiHAM5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235115AbiHAM45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:56:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD11B19C36;
        Mon,  1 Aug 2022 05:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659358592; x=1690894592;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Ah6rbgFOTQZN8lkf4n2RhQ7TAJnuIb3vzooan+RAnss=;
  b=kxPQOrnLj2RzsqKaQ0NvrKm/PoPRjZNVvE5TyUP5+2Pyg/JwGK28n4UZ
   f3atMiLY/MZxLfU2njtmtHKgidFfzakdbyBcLZb0CYPKUefdCfb8WV3uL
   ZjTNSGnF/xY+/5L0UCBrxdihgN8c0mDhVovo+l/yKfq7S2o5A1SEZ3CDz
   V9eaYnJulhg4FWpQn/OUxVQw9jVWdcZyjONSiwgA9fQvEBGsf0XhVeMrZ
   /6iiZCNVvX4XeCP013h3BBmxHadBvJvFrGdYsLk7qu4G868ZGJndZIaFS
   75aUjzR8J9FXxa0LgMgABtgL+bfnYnnkwbQvHT2imj1iPxhQQPCdY1OLn
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="107017749"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Aug 2022 05:56:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Mon, 1 Aug 2022 05:56:31 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 1 Aug 2022 05:56:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oIctqLyJKYZspW2+kBETBZll5FmzWT0odqElChX0iiiWp5Hfw/kSvxKEx+9DgVOwpOZ1dIqczlos8n98sNL+wQLQwWlPPGJj2mPFPj1hF7lZU2BvzCGdj/JWwVcUge2VYpJiXIge5KwzYpl2RV+L2wYCT4gTfuqn58tnFTzwdrCPIOW4kOWEhEXkQKh9Z/eokfiTnNQ26GltlXX2set9UE6S6MKgaQVLvHM6WU+NHd/bkL846dOvypoQWmKqj5CZRB8F8Bk7lojbx299h3r+3x36Vc2S/sje0rToX1tH13AJVi7gbAkskGb08bXq/UVymqzLKQ2GZMKbt3GK/0ILlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ah6rbgFOTQZN8lkf4n2RhQ7TAJnuIb3vzooan+RAnss=;
 b=O1vLtvyUJPUCdFePJbEbU1LbgjFs4F3A9mpSiZLK5aFjc74Mm0lTjlGqMnWGJbz+OTcXlCsKiKj7TwjVQsXdTiBOwj2G09zT25b4paDxiRglDvAg3NtvXYas05qYLMm58liKHFfF6NgdZm+IXbSPU4e7zx5K4f7u9bPu6koSnY1RDzDfPOPOTSUTbTzqfzqkQ9kTMPl5do2kc+Umh7LidpYlSYOhNlUuLesjL3xQhTqQg47N4rzKHGxU0jZKFVIccjNeFA+hZVwHpb0crHCqx3h3Hl1Kp+48wjktP06X6qq6Na70M0GkKlwIt1+QSpM47phsAZG/CI6oXv6Rrd7yJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ah6rbgFOTQZN8lkf4n2RhQ7TAJnuIb3vzooan+RAnss=;
 b=PaIzbVkx8gFANDO1RADU+lJutkS34GTx4lH/LC2nkiZ2tiXwbsMzmds7hsic/hd/BbexVlZNH1WZ9/QETj332jiBMldXT6EkjChbRq2/xRCFcY4IftQEDb6AfBkLr7SrntZujOsai0rHoS9sElHVBZMDuJ0V8fIgcs/K1MZOCyM=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SN6PR11MB2639.namprd11.prod.outlook.com (2603:10b6:805:59::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.6; Mon, 1 Aug
 2022 12:56:26 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5482.016; Mon, 1 Aug 2022
 12:56:26 +0000
From:   <Conor.Dooley@microchip.com>
To:     <broonie@kernel.org>
CC:     <Nagasuresh.Relli@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] spi: microchip-core-qspi: Add support for microchip
 fpga qspi controllers
Thread-Topic: [PATCH 2/2] spi: microchip-core-qspi: Add support for microchip
 fpga qspi controllers
Thread-Index: AQHYpYscI+Kkk/PiAEWVZ6Ma6620dK2Z2ykAgAAfn4CAAAZYgA==
Date:   Mon, 1 Aug 2022 12:56:26 +0000
Message-ID: <3ec68df2-7843-abc9-c490-29cbbac80edc@microchip.com>
References: <20220801094255.664548-1-nagasuresh.relli@microchip.com>
 <20220801094255.664548-3-nagasuresh.relli@microchip.com>
 <283bdfef-cbd9-5d87-f77d-10f007c37a0c@microchip.com>
 <YufIJ9JtTKaUjRqZ@sirena.org.uk>
In-Reply-To: <YufIJ9JtTKaUjRqZ@sirena.org.uk>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b25cd121-95f6-4df4-81e8-08da73bd3e98
x-ms-traffictypediagnostic: SN6PR11MB2639:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7FMyR2YsiBIWUCy4llNK++tKWzkNpsB14Rq9biu2URbJcokqH/Qtb8mWRydesGXJ3e05bxw4VxQ5VdEuewkPYwNskr7sNMePmPQqDk1w47e53O4xla/KAo/eaE9hXC20+LuY0rqf8BZKT0tD41tjX3SkyZVqJIG5mlmr4TmeNoOGuAqgArb1aVplJjsGKMwMcTDADHa3KTyFpG6txzPIJdsaaaBvQKr1TeWwgy01JvCeQF/F/d0ldPEBCAukYV60eQ2NbZejAZPu+HJwquHpyf6lYSMPqo+7z9vj8W3c5nuLiQC22w1JEtpX4XYvhYtYFdSCb+PyKI0UwwPpXdRk3Qn9cCluwcCborsj/K3385BNPleky0gVb+QX/HHZtbdUnDMcjazrPsNaZkS5cW2SpCnUPu4ys8QZLeApEdGYPj9rII8AjbBvhbuuIYk2CkD+p9Q+HcjyDRtQ2YlXZznuzxNLo1rA61GtNFGIJCndn90/IWJsTjgClXabNrv3oM/7pw9rht0Dg/5O5V2X67jurs13khuB2pTHWO7iRs84TUeTMPW9/UgQVm+7pF4XzxmRR/sqtE96AOGhUMYkp4cS+PD2VyPiUVogw7qCYQtGRnOEsxhikp/9ScyNRo+dDeLopZXxz4WV/PQjrxrL+9oSEAEKBxhWBOFk1tPSlEzHgXLwtj1E1dI3xGu8ZR+sQUorZNeSVcro/GHLoIn7s1T7tqLt4+4yLafMC68o4dW9+Oja4H0JhcgfT3L8dknOaypQleQJIBPZk4vOQPF2hrL2DEodSrigAXs7lpMjcie6qiCDUzjhMD17qSOaG4R07gHWALYEOuHuPiDtURc8kvMLbyYo3FVObP6L3YA/1Q/Ss6g=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(346002)(396003)(376002)(136003)(39860400002)(71200400001)(8676002)(4326008)(91956017)(41300700001)(6506007)(53546011)(6486002)(478600001)(31696002)(36756003)(31686004)(6916009)(54906003)(66556008)(86362001)(76116006)(66476007)(66946007)(66446008)(64756008)(2906002)(316002)(186003)(38070700005)(2616005)(26005)(6512007)(83380400001)(8936002)(5660300002)(122000001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q3UzamhGQmtub2ZTanZ6ZHJscE96dS9tSkkwSW91VmdQNTNZV3ZLT1BoM0Jx?=
 =?utf-8?B?UnV6RmxvWGdvWStrM1lKZmJPa2U1U0pVSmR6eWtyTEE1UC9XSUdRcG1wdFd1?=
 =?utf-8?B?K2diTFc5TzA4R2lzY3pVbXFUTDNjMWJzemdkaGlPVEcyaXYxZDdLekthRVZj?=
 =?utf-8?B?aTBqRllCaGgwNndhejZ3MHNrUFNyTGpPYUo1MDBxZ2ZUczBiSXM5RjJVd1Na?=
 =?utf-8?B?dUcxOWVZV3FrbUpYSjQ0ZXNOZm1rU092aFUvL2JEZzd6Q0FxU0pObk9lYktu?=
 =?utf-8?B?ejZoTUpvM0JGRHFWcnZtcmxvbEhxSlM1ZWNpTnJHMzE5ZFI3emE0cGd0OEg2?=
 =?utf-8?B?Tm95T1duNmFQT05taUo3MzBOeTNtRVlTM3QwbWpDZHI4UEc4NUJhQ3ZDVzdN?=
 =?utf-8?B?bUhGSFFuMGtZS01IMXFUbEdvOTVXaTUvQnVNZFQ3ZU1XZXRmSGp5a0xEZUlO?=
 =?utf-8?B?RnRPb0MzZm80a2J3ZkIxOHRpa1paWWluY2dCU3JxNXN3dGEvZGpWcmVCbTRF?=
 =?utf-8?B?ZDhMK2xGdkJwVmFUSU9iOCtnSTVFWkNIeXVzMk01ZEsvM3E0akc1aXAzWGl1?=
 =?utf-8?B?WWZ6ckkrSmNkK3ZhdVlScEJycjlLL2U2Sm0vc3hzK0dXa0xySGtvZWVxN1By?=
 =?utf-8?B?Qkg4TUdWeXE1WlVkeWUzTmRTdHdpZngzUjRRWjd1dWExY3R0Uzl1M2FSckRq?=
 =?utf-8?B?eGVzcDk4bTBvTTkweDQ3Wjl6YmE3T3FHQlpwWmRDelUvdGRQM1pPOThucndU?=
 =?utf-8?B?bmVHb1lHYXJyTFZxVEp4VjZQMjBXU2VPZUxBZXhMLzNRRXFHVkdTK1FUdi9B?=
 =?utf-8?B?elA4b001UUdkb3VRY3g0VHBIaC9EeUpnQ3B4eXlDa3NNeTJqdVM1RmpFL2Uy?=
 =?utf-8?B?ajdKSUlFY005NkRpMWF2UzM5VnBUV0ZyM1N1TlEwcnZaeGtUbkFxejRmZ3NZ?=
 =?utf-8?B?WmhOay9ZeEY3Z1hUNkRaM2lQM3hpV0FQaThoekdQY0pvTkVWcHMxOVVJcXl6?=
 =?utf-8?B?U2hjeEU3WThiWS9vd3dJajFtOEU4dFk0VFdrTHM3YmRHeFo0eDd1ZERXOXgw?=
 =?utf-8?B?bUNXdGRES1lOZ1RBbDlwUWNyZ0tXWjJxQUdkblpYL2loSHcvYTJSSmw4eWRa?=
 =?utf-8?B?eTVHekhZaStBWW51RzQ5dEZQdzRENTcraHNpMURFTGlCaGMzMEI3bWlzdmk0?=
 =?utf-8?B?YXI0a0E2bUdJKzNIK2dKa0k5RmZDM2FFbzhPVW9PZnlOWm55UWdCZTRIc0FJ?=
 =?utf-8?B?NWxBRTdlR2x0YXJWNFRmS0dLRm9xZytoVUppU1ZpV3VWOTc2K04ya0xzZ0VZ?=
 =?utf-8?B?eWhYN2dYU0ZLMmlHZkRqMFdYbVFqbFZkcEcvQkJRKytLdlVZR2hTTXVLMXJH?=
 =?utf-8?B?WkNKVmxmbTA5ZGM4MVUzcE51bXBMSmtzeDZPZ2lUQmlqRGxDcU9zWGs3OEZR?=
 =?utf-8?B?ckQ5K2VNYWtQZDgweGkyTG82VU1sVkxFSm9NR3dUTmxySi9LUzI2WjlIcGhX?=
 =?utf-8?B?SXJrZGxQSWRtT1I0MG44YjBRdVArWXlnWlVYUVZqOExSaUJGbmhNVmJxckNZ?=
 =?utf-8?B?Q1cwTG4yMU54WE5RYklLcGhnd3o2RVNVK0s1d1lTZkJhekZXSytTWTFqd2J1?=
 =?utf-8?B?RDRrWTlJaExjV0lMTjAxcXFkU0plRTE2NytwdTJ6MTRWS1J3UmhPUlhKQW0z?=
 =?utf-8?B?TnQ2UFJma1FlTE5ucEVoOTQ1VkFQb29OM001M0NkRlRkRFlHK1AwVXEvSGpC?=
 =?utf-8?B?SkZBMTJ1MFdDMXd4SnZJM1c5eVBidkRVaE55RGRLcm9sS2o3MGR1cWpIRkdh?=
 =?utf-8?B?V0FnSmVrQUdVRm43Ym1WV0R6RC9aNFREUnpiVytXU2JCcGRQdk90ckRCdisw?=
 =?utf-8?B?TUp0dmFBMHpvMlIxcEEyOGNIazZpRUlQSGtZOEdUemJMM3BmVzJCKzE3eDgv?=
 =?utf-8?B?NVVKM1h1S2tJZTV3TEtRbXFSUjIxSHRCZlN1M00zNUx5c09mOW05UFBObWZP?=
 =?utf-8?B?azV4MUF0RzRZK1JiV0tVWWVEd1VLSGdGb1RVVUwyZWxLdklkVlFRQ0hZOEpD?=
 =?utf-8?B?eWJqZFZhZFprRERHdzBmUVdVT3I0V2V3MmIyVGpDT3Y5R3l4TFF1NVpoQ3JQ?=
 =?utf-8?Q?4s0eQUjx7u4e39q2S+Gg+1ecl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DBD66C3F6D61754FB8E67F8ADC022D5C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b25cd121-95f6-4df4-81e8-08da73bd3e98
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Aug 2022 12:56:26.2229
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TNUpmbe0aDe0rUrocqV/bnqvzAvvvZoGcvmRPOzInRTB7gPagsZixXpOkxw+DWmnJR55xAKyM+KKgK8+epXEWrl5+QdNhzme/dxoA18lNpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2639
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDEvMDgvMjAyMiAxMzozMywgTWFyayBCcm93biB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IE9uIE1vbiwgQXVnIDAxLCAyMDIyIGF0IDEwOjQwOjMzQU0g
KzAwMDAsIENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gMDEvMDgvMjAy
MiAxMDo0MiwgTmFnYSBTdXJlc2hrdW1hciBSZWxsaSB3cm90ZToNCj4NCj4+PiArCXFzcGkgPSBz
cGlfY29udHJvbGxlcl9nZXRfZGV2ZGF0YShjdGxyKTsNCj4NCj4+IElzIHRoZXJlIGEgcmVhc29u
IHRvIHVzZSBzcGlfY29udHJvbGxlcl9nZXRfZGV2ZGF0YSgpIHJhdGhlciB0aGFuDQo+PiBzcGlf
bWFzdGVyX2dldF9kZXZkYXRhKCkgPw0KPg0KPiBXZSBhcmUgdHJ5aW5nIHRvIG1vdmUgZXZlcnl0
aGluZyBhd2F5IGZyb20gdGhlIG9sZCB0ZXJtaW5vbmxvZ3kgdG8gdXNpbmcNCj4gY29udHJvbGxl
ciwgdGhpcyBhbHNvIGFwcGxpZXMgdG8gdGhlIHRoZSBvdGhlciBBUEkgZnVuY3Rpb25zLg0KPg0K
DQpSaWdodCwgbWFrZXMgc2Vuc2UuDQoNCj4+PiArY2xrX2Rpc19hbGw6DQo+Pj4gKwljbGtfZGlz
YWJsZV91bnByZXBhcmUocXNwaS0+Y2xrKTsNCj4NCj4+IElmIHdlIG1vdmUgdGhlIGNsayBwcmVw
YXJlICYgZW5hYmxlIGxhdGVyIGluIHByb2JlLCBpZSBhZnRlcg0KPj4gZ2V0dGluZyB0aGUgaXJx
LCB0aGlzIGdvdG8gY291bGQgYmUgcmVtb3ZlZCB0b28gYmVjYXVzZSB0aGUNCj4+IG9ubHkgcGxh
Y2UgcmVxdWlyaW5nIHRlYXJkb3duIG9mIHRoZSBjbG9jayB3b3VsZCBiZSB0aGUgZXJyb3INCj4+
IHBhdGggb2YgZGV2bV9zcGlfcmVnaXN0ZXJfY29udHJvbGxlcigpLg0KPg0KPiBJcyB0aGUgY2xv
Y2sgbmVlZGVkIGZvciBoYW5kbGluZyBvZiB0aGUgaW50ZXJydXB0Pw0KDQpJIGd1ZXNzIEkgd2Fz
IHRoaW5raW5nIGluIHRlcm1zIG9mIHRoZSAiaGFyZCIgY29udHJvbGxlci4gSW4gdGhhdCBjYXNl
LA0Kd2l0aG91dCBhIGNsb2NrIHlvdSdyZSBub3QgZ29pbmcgdG8gZ2V0IGFuIGludGVycnVwdCBp
biB0aGUgZmlyc3QgcGxhY2UNCnNpbmNlIGl0IGlzIG5vdCBhIHNoYXJlZCBsaW5lIChub3IgYSBz
aGFyZWQgY2xvY2spLiBCdXQgdGhhdCBpcyBub3QgdGhlDQpjYXNlIGZvciB0aGUgInNvZnQiIGNv
bnRyb2xsZXIsIHNvIGtlZXBpbmcgdGhlIGNsa19wcmVwYXJlX2VuYWJsZSgpDQpwcmlvciB0byBy
ZWdpc3RlcmluZyB0aGUgaW50ZXJydXB0IGlzIGEgZ29vZCBpZGVhLiBTb3JyeSBmb3IgdGhlIG5v
aXNlDQpTdXJlc2ghDQoNClRoYXQgZGlkIG1ha2UgbWUgY2hlY2sgdGhlIGZsYWdzIGZvciBkZXZt
X3JlcXVlc3RfaXJxKCksIHdoaWNoIG5lZWRzIHRvDQpiZSBjaGFuZ2VkIHRvIHN1cHBvcnQgc2hh
cmVkIElSUXMuIFRoZSBoYW5kbGVyIGFscmVhZHkgY2hlY2tzIHRvIG1ha2UNCnN1cmUgdGhhdCBp
dCdzIGl0cyBpbnRlcnJ1cHQgc28gd2UganVzdCBuZWVkIHRoYXQgc21hbGwgY2hhbmdlIGluIHBy
b2JlLg0KDQpUaGFua3MsDQpDb25vcg0K
