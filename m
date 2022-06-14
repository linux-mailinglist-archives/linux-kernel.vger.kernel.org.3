Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D94754AB9D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:21:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239223AbiFNITz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:19:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239056AbiFNITv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:19:51 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A376E40E62;
        Tue, 14 Jun 2022 01:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655194791; x=1686730791;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TNWm95YB34O5si4ioxfE4MpTZi3HdUpZXfqYRN27gn0=;
  b=RkylwCXh20tsXqlCG4JrIJ4n4YUcOvy+uJtHnYK2YE/vATeYbc2h9/nf
   07gGtSnKbXHBI6lnSXcKw0FRnzXdhJww5t1fO6ZfN2V9SmSfSA02eyhYe
   x6vedM1mWK30xwpo0KWOr4c/9e2WZ0GyaW0kBJ/ua7OqAunOlhP/FgWVT
   F5Se9B6QUPw75KUw1suZu0DHXIWFC83nj45YmpuojWbGCMu9ZuDW16Hh9
   tTBOcoHCiivLDteSqr1lXWgHI4dinaMIz82RxvTD3W+i/NeRtRwaTHjp3
   Q7MTcefil836kZYUcn9uARr+YrHWDJSlug+XYtxujfoBx/qsyoKSF52Xz
   g==;
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="160203739"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jun 2022 01:19:50 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 14 Jun 2022 01:19:49 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Tue, 14 Jun 2022 01:19:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U2pgKEa9bTp4Vfp6EfqV6ol0UwtDSc4EQcSXND8IfxBtuVnIcrbcgkKwn+Rw4pKX8Lo/YTTtGOPGQMAPp6Pwbg4mhbMunxmXHLqkZnKI8LCAZyiaOd7hXCHRagKhrybq5dadIiLX6mHMLAVjuexyl4mXqUsdlzFDGI8Exnq66NhQ4H34t3Ftss5iJm5OQEeX4okE7KhsJkztv13qULaCn0u9phh7RVLahhR+SYPthpQQoTcrDn4gFh5xhdtq8K878QrNnor3NHx9kkdABWSEMrEReTsT0Mt4hKB8kSWqcFaGP5+PQCCrifCbAPwuq6g/R+4Vi1XEPtGBvQ1PZGUzsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TNWm95YB34O5si4ioxfE4MpTZi3HdUpZXfqYRN27gn0=;
 b=N42948K0MzMyRp7/HIPOmLhMHDfJLbr3Rs0G4h1uDwFN/6vKz9b32ZK6iZUcluGQ6/HZ8+wPFkC7Vymf77xTe7c/ufVZb9E6kjVZHusHcxQtdH/MOky9LZFvhUEFUWuSIz25iWJfZhpWneG4j5E+i8+BHFCiRI/AAS+qYWLBAhpFrwvNBVCyNZCsIjGDDXpnDTRH2OdHqc39vJf8KhFDU1e97u0lHqUTHEG/KJa95gU1P7SD5BQW1EMT/vhKUeD0g/iRiLD2SzpHmz8XWO8Ey4g55onyprCQwon0+4VtR9zq3UmWfi4tEMR5TKmJjva5NPONs2PVwhIc5iv9Z/0W6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TNWm95YB34O5si4ioxfE4MpTZi3HdUpZXfqYRN27gn0=;
 b=jJAFcZJwUDO7c5BNFuLB/zFD/c7r3aRyVm7zz9dZ22dut9YmuZntCxzEJ/siIiGqSi3qz8v52aiZK2wwVgygmiqyfaJl9/VRZySg7AZOIofNa9+xym7qT73ybrlzEFqK8+UlyRDn/btKY37dN+oambHBoEVTLjcSgQ3haIzCkj0=
Received: from BN6PR11MB1953.namprd11.prod.outlook.com (2603:10b6:404:105::14)
 by BN6PR11MB1698.namprd11.prod.outlook.com (2603:10b6:404:42::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Tue, 14 Jun
 2022 08:19:44 +0000
Received: from BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5cfe:8088:aa93:fce8]) by BN6PR11MB1953.namprd11.prod.outlook.com
 ([fe80::5cfe:8088:aa93:fce8%3]) with mapi id 15.20.5332.022; Tue, 14 Jun 2022
 08:19:44 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <jic23@kernel.org>
CC:     <Eugen.Hristev@microchip.com>, <lars@metafoo.de>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <ludovic.desroches@atmel.com>, <linux-iio@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/16] iio: adc: at91-sama5d2_adc: exit from write_raw()
 when buffers are enabled
Thread-Topic: [PATCH 03/16] iio: adc: at91-sama5d2_adc: exit from write_raw()
 when buffers are enabled
Thread-Index: AQHYf8eAdPvUSOVYkkqvSOkKma/Neg==
Date:   Tue, 14 Jun 2022 08:19:44 +0000
Message-ID: <32e6b995-3400-7607-a606-858006bf4177@microchip.com>
References: <20220609083213.1795019-1-claudiu.beznea@microchip.com>
 <20220609083213.1795019-4-claudiu.beznea@microchip.com>
 <20220611183354.08788921@jic23-huawei>
In-Reply-To: <20220611183354.08788921@jic23-huawei>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 67929452-1982-4db5-a0c9-08da4ddea38f
x-ms-traffictypediagnostic: BN6PR11MB1698:EE_
x-microsoft-antispam-prvs: <BN6PR11MB1698FCB293B88115405128E987AA9@BN6PR11MB1698.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JSdPuxcsqId6Kjumli+QLD2CvK2xpRQlO42r1sEHAzunBYhHraTDBm1EPU3ghPqlV4/+I6tSSvgeeQCihryIY9KwDR9lktPkLkRiOUO5N9Ry49lgLdYki5aVq7hAnDAc6LpsMAFFjIkLqYKyZEMwxdimxpCdFWGyAz/VxcW4032fC5gA/2gNMZHlzjqHeIioK+/+6vqqPWchovKRMKLVuHnTlzzjnYBRgoE64q7etUdFYTQSMEakawAfZrpv5NGtLB3hqShIFYsFBRmHcrJYgmGgFaslkDthGU8g6tix5l8BEspnrzjkG1U6xeN5dvNoPizXD85FLWP0QfVuHU8iUK8pLXx0d0P2PCNO1kfTHtsP1y7nW28+R5+cpwftqdisUrJtIVc6UtrND5Tu1RtuZqXnDn95puL6S7nN5AI1WD5TCRJ8bwnoiFKEmkVlrYVevJCBKEPdEKbkDViqLHRkssHQdlE3ILm+qj6wDY+y2hvZ56vSeHvL20hLom77V/IO5QlI7hc9m1VGuZN0uBX1YmsOcIng8fdhZ7rTsAa/3P/UKAhkYRpPkQinx7GwEPwmUMbnYl/Su18gtBWiDmAdFPtRo+DY5GcxG0y+hWedEaWAlAP618xUGJ/7RaNKSqqsYxgcPQ+hV2NFS2KVMSd8ArOK4R4jbV24JrPGMmN2qcmBvt9lhJG3rdcsCJh1dn01OFVl+9S9UwUi5fcj4G6RY6XxREm+UZF8LM2Q29CfCF0InRmKEP6/0dj04uQmemqCLt2mUIlKmVlyeAHiWvSUmw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN6PR11MB1953.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(66946007)(316002)(508600001)(6486002)(53546011)(91956017)(54906003)(6512007)(71200400001)(36756003)(86362001)(6916009)(5660300002)(8676002)(26005)(2616005)(2906002)(64756008)(4326008)(66446008)(66476007)(66556008)(31686004)(76116006)(7416002)(8936002)(31696002)(186003)(83380400001)(6506007)(38100700002)(122000001)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SjhpZldVVDl6S1dCZU1EM0ZvSlBrb1RhN3pLOURLWnBveEtiaGw2L0RTei9w?=
 =?utf-8?B?RWhyUWhBY0dqdVNqZzRlcnByeUpjellGb3ZsankwUDc4R29hamd6d0toN056?=
 =?utf-8?B?d3lBUC9ya1VNbE01czFWdmxxemp5MGE3dlNnUmtwb2pWL0JrcTJpa1dTZXlu?=
 =?utf-8?B?eFdKeDNpajNmMlZqYVhyY1NlQ2xZZUI0YTBnOUovbzhDemlib04wTmV1aWlr?=
 =?utf-8?B?ZkdFWmdNQ0s5UTZ0SXNnSEtQT3d6aXoyZzNjL0dwbjRTRzNWM2ZqSlBxa3hi?=
 =?utf-8?B?YzZRQzRXV0VtK2pHWEg0dWFFSGF0czB0NW9LYnR2eDlLSUNTZEJPSjNDaUEx?=
 =?utf-8?B?TkhCSUhjWjM5Zk5yQnI3Qm13V2ViNmdZdkd2Ri9FKytmVjlZdTdQWHppaCtv?=
 =?utf-8?B?NUd2V2pRTm1yV2VOZUNiSU4vRXNRM0JCNW1VZ2h0TU9JSDhJa3M3eHdlRStm?=
 =?utf-8?B?M1AxenVKOEN5cS9tUEUxOFJ3L3FTOXJwRUdqNG9lN3JBWWtPZ0xrTGJSdlNk?=
 =?utf-8?B?TmdzOVR1MkFHS2d4b2hGNjN1MkVQaHlmSzZVNFFoeXh2SHc5dTdRNnNHU3U5?=
 =?utf-8?B?anlaT1ozcW1ldFE0bVhVaWQ1Q1VhUTJodklPT0thNi9vMzlzdU9hanpKNjFp?=
 =?utf-8?B?TStrTk9oTVZZcEw5a2oyVmFRMk8xb0NwY0VrK2FQMHVZQWhoUjhiejY0VXVO?=
 =?utf-8?B?cXJ5TlFpU0FFc1JLYzRRcW1NUnE4OHdianoxZkZpdkM2YUFBWlFpbnFURHNt?=
 =?utf-8?B?NS9ZOWpxYmFQb2pablo3OWFXK0x5aHJqQ2V4SmNoaXhQanFKcEh4TnJ5RmNP?=
 =?utf-8?B?SmNDd1JDc2o4eHlreWhRY0xneWJEVWxrUStLUDQ3SGVMMjN1SkhaeVM3RkN3?=
 =?utf-8?B?dWJ0VUNPYk5QSERmdm1leWN3SVBNbktFdXhpaFF2aW5GQU54VnN6VFhSaVJO?=
 =?utf-8?B?MW9PdUowb1UxOUdabklJQWd0Qy9sNnZyOHRWckRkcEpIekMvZWc3eUVoVnls?=
 =?utf-8?B?MGF6cGJQd3hYd01pL2luaE14UG55b3VOL3QvT2g4K1AyVUplSmpPSnBwc2J3?=
 =?utf-8?B?bE9JdnFiVkkyWURWN3hLSE1rQkIwQ243SzNSdWNDcSs0eXQ2dGNaRkJoR09K?=
 =?utf-8?B?alpIWUZZcmRKd0ZnenhUYUQvNHozQUNzalR6VHUxSnZabWFrUGYySWYraVVo?=
 =?utf-8?B?bkQvMnFtZWt6SW5IcUxiYmJEYm5nTldVUXNNVlV5b2xMR01EMXBqUzJiRW5Z?=
 =?utf-8?B?S0o0bmFYYTBnRXJSY1VDUWZyelFjL3B5ZzM1SzNsSjcwdmZVMTN5bTQrNmJX?=
 =?utf-8?B?NnB4eCtXMURMcFppazlnb2V5OVovZnJpd2tOYmJPVXp3RXlCK1NRMTJJNld5?=
 =?utf-8?B?SElZS3MybkpsRzdjdDlodjRBQWJrNTBSN0hncm1kQU9YZlR3KzV0Y01vcWtF?=
 =?utf-8?B?L0xkZE1vOTgzYldKcXIyS014d1BJSno0TmdnNGZ6WjN5VjRNNlFsV2lkeTU0?=
 =?utf-8?B?VE5MZU1pSkVhRXRjdzdGa2RUWi90ajBaWTZ3MjlwcmxGSnlKR0dqblBSNTMw?=
 =?utf-8?B?T1FtMHBxTHYrOHVMbjYwNGltOWVaL2Z6QkJ0c3loMU9Jb1dMQUhHZFdDbnJP?=
 =?utf-8?B?NzdqQXhXL0dMSEIzQWNFWkR6NWZWZWh4MGlucmgvNk15MEcyZ3ZjWlI4MmRw?=
 =?utf-8?B?VXM2MGJzQWpES3pRUFlXbDdFbE1mMHZvK0Ztcy93RjRhRlJ1WG5ha2pMZnpL?=
 =?utf-8?B?L0NwTnpQU3Zsb0d5K3VJczBZTUNUMVhwbkhwMU0vb2FTVnZPeEFkMjVFQ2ov?=
 =?utf-8?B?T1Q5eGR6SVlHWXZCZFlhY0JSYkFpUTlOVGpPTEpSN3ZjaUJia3NTM3VoY050?=
 =?utf-8?B?UkFLTXR1Vlp1QXlIa3o0YVplMk9JOVMzSCtYeG15UWwvb2pOSmhNRHNka0Vt?=
 =?utf-8?B?VDViTUxUZjhzeFgxb2kvZWk5Z0kzeHgxQ0xLQ2F5b3NvZktEQlFYTW42MkVC?=
 =?utf-8?B?cS82ejk0L1B2eVdLTTdKUk4rMkRzOFVIWFQzREdoMUd3ZWxQbVNJRzRqTkVV?=
 =?utf-8?B?U25HbytBUm9SanF0Q01ab3BndjBuVjhZejRPSzNNTHJJVXdNWXUvV0VkTG5H?=
 =?utf-8?B?TDlyVHhvcElIc3lpYXU4cHlja0ozVmF5a0lNKy84T2I0RHF4cTRYZE1uSDBz?=
 =?utf-8?B?RG5aaVVucXphNkUraDR4U2JLdzAzeWxrOTRpR0hLNjRiL1VnWDIrbTExUTUr?=
 =?utf-8?B?Rkd6V0FIMis4OHVDdHpFdWF4Qk1DR3lscDVoNDk3YXJKSGU3QS9heFlab3ZP?=
 =?utf-8?B?VXk0OTFTTS9kSE56VitySXYreUxXbWI5SHd6aGloa3NRNnBtbndwU1dodWdi?=
 =?utf-8?Q?TJ2+MJCxyqFRSEyU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0DC7CD4CBBB95542B182D7E6BDDE2F8E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR11MB1953.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67929452-1982-4db5-a0c9-08da4ddea38f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2022 08:19:44.8211
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z/jGulDehQunHyRArhUZBfiNUsW8L+wa4Is3QiLrJuXBjICHWekOkUtGOWXB0n0Y0cwui2vrwmblK2NZOrfn6mjOBDL7LcpEVszHPqYLvVs=
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

T24gMTEuMDYuMjAyMiAyMDozMywgSm9uYXRoYW4gQ2FtZXJvbiB3cm90ZToNCj4gRVhURVJOQUwg
RU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Ug
a25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBPbiBUaHUsIDkgSnVuIDIwMjIgMTE6MzI6
MDAgKzAzMDANCj4gQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+
IHdyb3RlOg0KPiANCj4+IFdoZW4gYnVmZmVycyBhcmUgZW5hYmxlZCBjb252ZXJzaW9uIG1heSBz
dGFydCBhc3luY2hyb25vdXNseSB0aHVzDQo+PiBhbGxvd2luZyBjaGFuZ2VzIG9uIGFjdHVhbCBo
YXJkd2FyZSBjb3VsZCBsZWFkIHRvIGJhZCBiZWhhdmlvci4gVGh1cw0KPj4gZG8gbm90IGFsbG93
IGNoYW5naW5nIG92ZXJzYW1wbGluZyByYXRpbyBhbmQgc2FtcGxlIGZyZXF1ZW5jeSB3aGVuDQo+
PiBidWZmZXJzIGFyZSBlbmFibGVkLg0KPiANCj4gTGVzcyB0aGFuIGRlc2lyYWJsZSBiZWhhdmlv
ciBwZXJoYXBzLCBidXQgYnJva2VuPyAgSSBkb24ndCBzZWUgdGhpcw0KPiBhcyBhIGZpeCBmcm9t
IHdoYXQgeW91IGhhdmUgbWVudGlvbmVkIC0gdGhvdWdoIEknbSBub3QgYWdhaW5zdCBpdC4NCj4g
KGp1c3QgZHJvcCB0aGUgZml4ZXMgdGFnKQ0KPiBJdCBpcyBhbiBBQkkgY2hhbmdlLCBidXQgdW5s
aWtlbHkgdG8gYmUgb25lIGFueSBzYW5lIGNvZGUgaGl0cy4NCj4gDQo+Pg0KPj4gRml4ZXM6IDVl
MWExZGEwZjhjOSAoImlpbzogYWRjOiBhdDkxLXNhbWE1ZDJfYWRjOiBhZGQgaHcgdHJpZ2dlciBh
bmQgYnVmZmVyIHN1cHBvcnQiKQ0KPj4gU2lnbmVkLW9mZi1ieTogQ2xhdWRpdSBCZXpuZWEgPGNs
YXVkaXUuYmV6bmVhQG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+ICBkcml2ZXJzL2lpby9hZGMv
YXQ5MS1zYW1hNWQyX2FkYy5jIHwgMyArKysNCj4+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRp
b25zKCspDQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2FkYy9hdDkxLXNhbWE1ZDJf
YWRjLmMgYi9kcml2ZXJzL2lpby9hZGMvYXQ5MS1zYW1hNWQyX2FkYy5jDQo+PiBpbmRleCBhNjcy
YTUyMGNkYzAuLmI3NjMyOGRhMGNiMiAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvaWlvL2FkYy9h
dDkxLXNhbWE1ZDJfYWRjLmMNCj4+ICsrKyBiL2RyaXZlcnMvaWlvL2FkYy9hdDkxLXNhbWE1ZDJf
YWRjLmMNCj4+IEBAIC0xNjQ0LDYgKzE2NDQsOSBAQCBzdGF0aWMgaW50IGF0OTFfYWRjX3dyaXRl
X3JhdyhzdHJ1Y3QgaWlvX2RldiAqaW5kaW9fZGV2LA0KPj4gIHsNCj4+ICAgICAgIHN0cnVjdCBh
dDkxX2FkY19zdGF0ZSAqc3QgPSBpaW9fcHJpdihpbmRpb19kZXYpOw0KPj4NCj4+ICsgICAgIGlm
IChpaW9fYnVmZmVyX2VuYWJsZWQoaW5kaW9fZGV2KSkNCj4+ICsgICAgICAgICAgICAgcmV0dXJu
IC1FQlVTWTsNCj4gDQo+IFRoaXMgaXMgcmFjeSBhcyBub3RoaW5nIHN0b3BzIGJ1ZmZlcnMgYmVp
bmcgZW5hYmxlZCBhZnRlciB0aGlzIHBvaW50Lg0KPiBVc2UgdGhlIGlpb19kZXZpY2VfY2xhaW1f
ZGlyZWN0X21vZGUoKSBhbmQgcmVsZWFzZSBmb3IgdGhpcyBhcyB0aGV5DQo+IHByb3RlY3QgYWdh
aW5zdCB0aGUgcmFjZS4NCg0KT0ssIHRoYW5rcyENCg0KPiANCj4gDQo+PiArDQo+PiAgICAgICBz
d2l0Y2ggKG1hc2spIHsNCj4+ICAgICAgIGNhc2UgSUlPX0NIQU5fSU5GT19PVkVSU0FNUExJTkdf
UkFUSU86DQo+PiAgICAgICAgICAgICAgIGlmICgodmFsICE9IEFUOTFfT1NSXzFTQU1QTEVTKSAm
JiAodmFsICE9IEFUOTFfT1NSXzRTQU1QTEVTKSAmJg0KPiANCg0K
