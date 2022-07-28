Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E16583EC8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:26:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238506AbiG1M0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238173AbiG1M0U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:26:20 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49274D830
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659011177; x=1690547177;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1R8JsJlshEmq4g+HhvBLx/H+wj0RamNTfkEDmNF47pI=;
  b=rBEhRdMLW7HX7AiB6L+z4Wj4wtaRY92oVZrDL4001tpY/thBidOn+m2U
   hltIlvqPqykfHz1nntwtD7HOJicn0khcLFRoVhYffh+x6i4WK54SWbxSw
   36w5Uz2Utu1k9ui2ulSYfr32m18MaZUXuxdWvK21GCMRT6BcnUxdW+9TR
   Hba2o8A5wdXlHNal9uhPUjR0eALlZia746ole/sg5e2bs9R+/GDHuQIf6
   hZrfJ0OytScFV9N+4eQOYcLtGaZQFH0KVOSPFO7gpMmR+2wBOTET4vYDR
   AyN5xhF6nQ4+W4O310iQrJiCGs2N9lUlQo5zdwReagvOnFjyjW04jIctk
   g==;
X-IronPort-AV: E=Sophos;i="5.93,198,1654585200"; 
   d="scan'208";a="173979455"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jul 2022 05:26:16 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Thu, 28 Jul 2022 05:26:14 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 28 Jul 2022 05:26:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBUKH3H/4duV9zlYyigp2jGHGOjQM2nGKT30mrBRoAizuSUTBJj9g/SD6ti+L1SUc1VtUgAqgrGQIONLutFGpjeNf/bL/oIvA+FYrvqNeGL/FcZ7F6ffxZcaIUnnsx92KlBJ23schP6prse42x+ciZ9D3CIb84HrNIAuZz39fRhkbjS91uFQGFe2r8uXDs8v0vjxuibYg+CmneckXMn8qSwn/PGzZtbavYB+s+e2Vwp/GEhPbeL+edUVnkep4IkM5i98xOvgW+R7wn0id012uZkUIuiRN8/FjnwFTpEN0vAuA19U2TL0L7nVH7gk3/P4mhC4D5tD/21L4eN99N4Z0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1R8JsJlshEmq4g+HhvBLx/H+wj0RamNTfkEDmNF47pI=;
 b=C5u77VQ2ejBW+onARqD6f5P8W7EA1vz6V+uyBeasZUQE2UIQGa0tILspnNN1p+JVZ7Cqh9cGpE5aUJaIn4YzLqRTFouNqPlE8SPkjQ9WQhk4korFyLvcmG9+KMN4jCRqeXmrAZsovejfCniNlypi3mT+qeSaeH587iTPVePDLLq++XvnqUCk9WjhUXNsWZw6cfFLCagsvBUV7STnyTYC3CYsxdIbZeqtniKj/a0ho3yfwTOMAulZnAOOmiIwkW0c5VhkqOk3s696W8pbZsTuQ9TnzVqe+supppnYtyl5TSkYN3Qc9MrKd3K7HEMYXzMzAPSCHucmV0tFlRiwFsORxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1R8JsJlshEmq4g+HhvBLx/H+wj0RamNTfkEDmNF47pI=;
 b=E76v3oX7jO7aiiWt5H1JGstZOJS1ovShk1oGfoVwacKyPufCysEjNODqaPUJz5bicZXM4hfIJqwdbVhifNKwUnDqTeq1T8SyCXjvFxJUSieyjMXAG+PoMZ5C3c4XmLUKrvUUXRkDfW3jPJAlEHWjEuOlJWaxeE9IFw+/bGmNZQY=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 SJ1PR11MB6297.namprd11.prod.outlook.com (2603:10b6:a03:458::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5458.24; Thu, 28 Jul 2022 12:26:09 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::7549:c58c:5e93:7c35]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::7549:c58c:5e93:7c35%5]) with mapi id 15.20.5458.023; Thu, 28 Jul 2022
 12:26:09 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>
CC:     <pratyush@kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <p.yadav@ti.com>
Subject: Re: [PATCH] mtd: spi-nor: core: Add an error message when failing to
 exit the 4-byte address mode
Thread-Topic: [PATCH] mtd: spi-nor: core: Add an error message when failing to
 exit the 4-byte address mode
Thread-Index: AQHYon03qS+LPpwA60SkPL4Qs6nflg==
Date:   Thu, 28 Jul 2022 12:26:09 +0000
Message-ID: <c5396813-8504-e24b-bb04-463308bd099a@microchip.com>
References: <20220728030159.68680-1-tudor.ambarus@microchip.com>
 <27c95d5e17906f5e45c04cec7c1bda9d@walle.cc>
In-Reply-To: <27c95d5e17906f5e45c04cec7c1bda9d@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec162adb-ea4c-45ce-e465-08da70945a3e
x-ms-traffictypediagnostic: SJ1PR11MB6297:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8gwKJj1NdDA+lNzqYROKgXjyT88pALlNMq2rs5pWk+KyZFlHhBJIzWmUI3trsk5YD6wK3EXxzKUdhey7fNsibN4mhFTWAGSX3dRL9jq0qNu1A0cM/Xv+1xDFRqlzwWXJUACXgosy4xahEYykM0lSbbFdyClsFgBsN0N3WW57qcna8+IOTnOgwRi1JTF1UzLljvf8Hapi5r4o4YwEISEyBbz9HQ1Z9XN3ecthqxx73Ytfe2BaPogwtZFYM0muym8Fn9rq7R+PBx31jlOOplZrB2XblENFM39IkwWa+8BeLJ8LQWej4lRWGlzZ4LRCPO4xQPBVHpdiOg+d31giN+OIU7B9hZpXzYEZCXrJF8RF1ARzx+2T3LZsFKx17pT7XYZMKwgc58wdx6yJtBuAGCTFPWNq+PI7Vz3JP00XJcv+f0CuYRsoz2rcCm+jva9ZuZssp5Iqm0pKg6x0WHkdmCj6z75xkifKupZpMoc8uV/TUu6JKAdEXAH5/4D7IZoXSGrnO4nZRLEV28kjRk0tD3ttLRqDp841KeSTWME6YYZZOMAiS9JOz+DXlca3T4frmIEx2Vxz7Ep21FomDvRFuyt2tKafM6ZsdHMluCg9/ZqzcHoWW3jPs/Oz3ANv0bLdFSkIb3jN0t/MZIMs3FnXMN2UelA8zrrZLWIrcRwyR7bQ10b5gzmvlpre+J8yvagSkkNd6/2601hLgqBt2e/0Bktkb+PPjEglNrTizAf+3qWDOFTn6xSCM2vVDyQ2vCqSLobweCwfdfzstO2fD46sKKqeupzTFM2x7SOHUiBPxBwyDdKMJtyGT7RTxRilFRVReA4PYefpFxjou9dWo6ICySEGslFUNYnULYNZgV1Q+tWWc1w82eFRm/by8uYMT/5bxiQ/
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(396003)(346002)(366004)(39860400002)(8936002)(31696002)(6486002)(38070700005)(5660300002)(26005)(6916009)(38100700002)(83380400001)(54906003)(478600001)(53546011)(76116006)(71200400001)(122000001)(2616005)(2906002)(8676002)(41300700001)(66946007)(316002)(66476007)(186003)(6512007)(91956017)(66556008)(86362001)(4326008)(6506007)(64756008)(66446008)(36756003)(15650500001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aS9CUjhMYkFTdnlnak9jaFpNOTF5SHkyS0FYWWZ6N3BQU3pobDM5RGY1T1FX?=
 =?utf-8?B?b0ZKcEdiWko4eXdQUHFlWTNsWnZYUHJabDhiZWVRRzJOUzRoTWtRZ3FCczdT?=
 =?utf-8?B?a2ZURTRWT2VobjJQdDdQbFBmTEZGRjhPZkpLTjBPMjNFdEpGbkxjbFBQQllG?=
 =?utf-8?B?NVAwbGtlTkFiTUZZK2dlU1A3N05jSHNPQkhXZ1BzZWZxdm1Zcm4yODZZZUlk?=
 =?utf-8?B?eG9GZUw5dTJLcTBWVXExM1psSnpkNEFkZFpUUUJqdE9xdU9RYW9rWHBuamlt?=
 =?utf-8?B?SjRIRDJMdWc4UGNVODlvTy9NbnNkQUxROTVralVhRmhqRVVYaGhLLzhkZWl0?=
 =?utf-8?B?SlBaU1p2MlJqZmFsMmlSUytBNGt6WTdzNmZzZVFnd2JIcFA3WXdiYkZtdC93?=
 =?utf-8?B?MEJ2aEs0VW40TExEU0YwVndqa1JyNEQ5NTZKa0Z3VGw2aGxxOENiY2U4NFAy?=
 =?utf-8?B?VlV3b0ZWQ0JlbEJLTU1kSW54K000WkFoZzFncnUrRnlPUVZIMnVhNjgxNExv?=
 =?utf-8?B?dFd4MkUwL3Avck1mNDViK3lDN3lIOVVhL2lpNm1jWW05YTIxdjhRSURwNWZR?=
 =?utf-8?B?WVllY2QyUGhEaS95RHJQbGM5SjJoWVFxYmhTdXh1enc5ZTBXaWVYUzRFS1Vk?=
 =?utf-8?B?UWhxQUo1N1BhUFdkYXA3eFpEc2pXbjBwU1dSZWpJTUd4UzZ4SXFBdmpQRUMr?=
 =?utf-8?B?djZ2V21NQ2xLYmFWdkdNSzU5S2RxVXBJR3dIU0wxTk5VNzZNczR3VGNYNGdX?=
 =?utf-8?B?c2VtRk4rbFlsd2dFb05GbnFLaVBhdk5iSG41aURiSmhYNjFrdFMvQ1BPR1dt?=
 =?utf-8?B?Mk9IbUMycHVuVnpJVkpOQks4aE45cHQrQTNZcXMrRVcrcysyVVdCajBLMUxW?=
 =?utf-8?B?QkFpSVNsdUN1a0EvR0xGa0xScGtndlJJZTJGSk83NnNqZ21MUWVhbDZTcTdS?=
 =?utf-8?B?dExTaWhXT1FUdkVXU0xveE8ySndZa21COTZGN2tHc1FneVpxblo2YkZPWE53?=
 =?utf-8?B?TTJibjREWDR2MUwvdUo5VjI4Ly9Ta0dQMCtkVnB6M200akNndFJZMHk1NTNU?=
 =?utf-8?B?aEladVdrbi9kV2ZnVnRvNUQ0OHlSM3I0TFdTY1prOXkvZjhKY3FTakluWlpl?=
 =?utf-8?B?a00vOEFIQmVPOFRqa1o3RWlYLyt2OUZLcCttZ0hXblVtSVY1RFNqQzY0N1Qy?=
 =?utf-8?B?S29TMXdRbVMxRXIvR2M1S1MvbThLRkFyRGN0aU1OT3pML3ppdnJNZjgvUlBp?=
 =?utf-8?B?ZWh4WWh4aHVqKzZwZFA2S3kxN2xQeUQ0YlVqUDZnY1pqRTAxNXFCYnh2ZVZ2?=
 =?utf-8?B?dDlmNWpuN0tDdE5GYW5DTXZoakpETjMybVlucmxWbS9ZeGdIc01oRVYrTFFV?=
 =?utf-8?B?Z3FUNitONGx3dWgxYjVXU3JaSUsxeXIwSGptQnJiN1lra0hIY1hjZzlJekxw?=
 =?utf-8?B?M05lOFhMSVV3N1RUUlkwdVhMU0dpMTFmQk43bHVOSXZiRzh2YkhqSkQ5SEtT?=
 =?utf-8?B?WGtmdm41SGxLT1Y4Y1BjREVQWExhSVFBZmNEWjdhWEFyY1owc1d6RFgzUnI0?=
 =?utf-8?B?ZWZFZGZyejJFanF3WmZ2b3BmeGQ2ME8vbXpWQ2piRlQwTDRNUDJmZlVESk1R?=
 =?utf-8?B?bEovbDk3MWNDUkQwWDhTaXNaMXRwZFJnaTZJQXJBVytRU3owUmEzU1pURWtN?=
 =?utf-8?B?TVBhM0lHZUpuZFpQemN6anZreXp0RW1TRjJZM1U0eWJ4OVI2bUp3MU11Uk9k?=
 =?utf-8?B?YXlBYmJjTjJTOTEvU3ZrV2doUzREZENDa1NYbDUwa2VSekZPamFxL0k3OEtB?=
 =?utf-8?B?SGVseVVndHo1QmdsQ0pINkVueTlTdFhlRHhzNm5vZ2NoRVFKY2pQWEdpRUdh?=
 =?utf-8?B?YUdFckJXWWZIY25kbTE3enF3RFA2VEgwVmxNWGlrSDBVaXZlZjlGeElEMzEw?=
 =?utf-8?B?ZExYYklwZ2pOZE1pa0JCK3VVRUM2Ti9JelpEcUFjYWUwUzR1UmtOc3dVVWxS?=
 =?utf-8?B?bE92bDZJTzJRZXZ5M213ME1KYjZvVW9NMyt2NXU3akRPaGtaWEVWc1FhVWNS?=
 =?utf-8?B?K1hTVHh2dFdMRU1VWjluZzludXlCeGllMmRmNHRvNmZEa25NYW1DMTJLNkhi?=
 =?utf-8?B?MXFWWCtCanJ6a05ETzd1aldVVlZTcy9XQ056ajdrU1VvSy9vWkVzZEg0c1d4?=
 =?utf-8?B?UkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DCC2AA4938E0174096E69EF40894935D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec162adb-ea4c-45ce-e465-08da70945a3e
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2022 12:26:09.7732
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 32Ocapb7mPOzBud1haIieK9NZ1afCfEExrd/7Kvp0nKlRs4Ko7Z4iEyZx2CfNRbLctlw+J6lcZj9tagvzxNslOr/W4NMzNcan4lY9+V2zP8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6297
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8yOC8yMiAxNToxNSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBIaSwNCj4gDQo+IEFtIDIwMjItMDctMjggMDU6MDEs
IHNjaHJpZWIgVHVkb3IgQW1iYXJ1czoNCj4+IEFkZCBhbiBlcnJvciBtZXNzYWdlIHdoZW4gZmFp
bGluZyB0byBleGl0IHRoZSA0LWJ5dGUgYWRkcmVzcyBtb2RlLiBEbw0KPj4gbm90DQo+PiBzdG9w
IHRoZSBleGVjdXRpb24gYW5kIGdvIHRocm91Z2ggdGhlIHNwaV9ub3Jfc29mdF9yZXNldCgpIG1l
dGhvZCBpZg0KPj4gdXNlZCwNCj4+IGluIHRoZSBob3BlIHRoYXQgdGhlIGZsYXNoIHdpbGwgZGVm
YXVsdCB0byAzLWJ5dGUgYWRkcmVzcyBtb2RlIGFmdGVyDQo+PiB0aGUNCj4+IHJlc2V0Lg0KPj4N
Cj4+IFN1Z2dlc3RlZC1ieTogUHJhdHl1c2ggWWFkYXYgPHAueWFkYXZAdGkuY29tPg0KPj4gU2ln
bmVkLW9mZi1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNyb2NoaXAuY29tPg0K
Pj4gLS0tDQo+PiDCoGRyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jIHwgMyArKy0NCj4+IMKgMSBm
aWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL2NvcmUuYyBiL2RyaXZlcnMvbXRkL3NwaS1ub3Iv
Y29yZS5jDQo+PiBpbmRleCBmMmM2NDAwNmY4ZDcuLjFjZGJkYWQ5NzEzNiAxMDA2NDQNCj4+IC0t
LSBhL2RyaXZlcnMvbXRkL3NwaS1ub3IvY29yZS5jDQo+PiArKysgYi9kcml2ZXJzL210ZC9zcGkt
bm9yL2NvcmUuYw0KPj4gQEAgLTI4NDEsNyArMjg0MSw4IEBAIHZvaWQgc3BpX25vcl9yZXN0b3Jl
KHN0cnVjdCBzcGlfbm9yICpub3IpDQo+PiDCoMKgwqDCoMKgIC8qIHJlc3RvcmUgdGhlIGFkZHJl
c3NpbmcgbW9kZSAqLw0KPj4gwqDCoMKgwqDCoCBpZiAobm9yLT5hZGRyX25ieXRlcyA9PSA0ICYm
ICEobm9yLT5mbGFncyAmIFNOT1JfRl80Ql9PUENPREVTKSAmJg0KPj4gwqDCoMKgwqDCoMKgwqDC
oMKgIG5vci0+ZmxhZ3MgJiBTTk9SX0ZfQlJPS0VOX1JFU0VUKQ0KPj4gLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBub3ItPnBhcmFtcy0+c2V0XzRieXRlX2FkZHJfbW9kZShub3IsIGZhbHNlKTsN
Cj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKG5vci0+cGFyYW1zLT5zZXRfNGJ5dGVf
YWRkcl9tb2RlKG5vciwgZmFsc2UpKQ0KPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgZGV2X2Vycihub3ItPmRldiwgIkZhaWxlZCB0byBleGl0IDQtYnl0ZSBhZGRy
ZXNzIG1vZGVcbiIpOw0KPiANCj4gQ291bGQgd2Ugc3RpY2sgdG8gdGhlIHVzdXNhbCBwYXR0ZXJu
Og0KPiANCj4gcmV0ID0gZnVuYygpDQo+IGlmIChyZXQpDQo+IMKgwqAgZXJyKCJibHViYiAoJWQp
IiwgcmV0KTsNCj4gDQo+IEkga25vdyBpdCBpcyBtb3JlIGxpbmVzIGJ1dCBpbWhvIGl0IG1ha2Vz
IHRoZSBjb2RlIG11Y2ggbW9yZSByZWFkYWJsZS4NCj4gQW5kIHRoYXQgd2F5IHlvdSBjb3VsZCBh
bHNvIHByaW50IHRoZSBlcnJvciBjb2RlLiBZb3UgY291bGQgYWxzbyB1c2UNCj4gZGV2X2Vycigi
YmxhICglcGUpXG4iLCBFUlJfUFRSKHJldCkpOw0KPiANCg0Kc3VyZSwgd2lsbCBkby4gVGhhbmtz
Lg0K
