Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86825608E7
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:18:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiF2SSk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 14:18:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiF2SSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:18:35 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476FBD10F
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656526715; x=1688062715;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4lydrkeNPjVug/kvLF5iZK2q1i1y7oYev4S8Q7Zs9bA=;
  b=oQ8M/Ehc5Vya0FxFAgTotsNOxWWESwKg1XebylcQ65WnMsvwpnN37miZ
   HF5C9yov5PiKYK+BoWqQjwFFL+XBmBoG054Wa9lLYY8ufdHGOvhH13tDG
   1xGT82qB3w5Q/2k+GlTdurhNKaAV+qDQBA3316Q1sBU2bMsaxcdCeKh6C
   acEJp5Y8l6tEeghEHeEr55iLe9s+NSYwna4JGs5rPvUhaiIhAEVYO/rVh
   b2k8eG040Wmd6Q0ZhrOKPyCaoeF9rSsmq/cDXjXM72uTZR3r7cTZcq8mO
   RVBAtYOw1PWgBcE8wNSy0ZbEREE3ize5009qpMfnSk9CTLP4KjCwLRXbF
   g==;
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="162633887"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jun 2022 11:18:34 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 29 Jun 2022 11:18:31 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 29 Jun 2022 11:18:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hMqme5sNTPOqcQJ74ehvGG+Psxy0px7Okun03Cz7/HVWtlsUNyz0BXeMn4Jnmza8rt8/QDCtlhbZEtEzpJoZvUAubJvpeh7JGnbUZL9RlDiXTvxXyAsszUYhyaBocJwT50irXqr7Ef0JR7/vPNyO8pdC89P0VpjTTGbcRuzDhiKvRaWiCDKiJ4gPVMsq4r1OBSN8Mr9KhJtvyUyzQGCyZi9cEeKg9fhnlOWbqQzSnBLLZOal3QQrU2XCuTdzJMFqKEnEntGrcyvN+cSMCte5buViW7sojqtDhKdXsR2lwrDmPdcRg4aScT6i9+0WnEFn5QHGtjCDVe6JdhTGneugCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4lydrkeNPjVug/kvLF5iZK2q1i1y7oYev4S8Q7Zs9bA=;
 b=Cep7NYzfRsMgBLxaC8MM4qtxF57p76AqYkCgpsmgRlyKpOte7D/UTLk932omba7N1WhIqlBVsB0S1jQLOpkn5Dzdp8rsNEoABgg1aKvii8NVHlYK6R9koSzUCIGVUYxiBS/WUp9y4MsU5ZuAK5oivogIyGR6+ov+YaHpVXTe/S22BqApAkhbTDF0tbBJrHvMh5zTKxcnqJ8HNNPZ+0oHgdBGblXvRJtIan2R1T7863CW7WagM5XvC2YcYuVx36BGVdEw3ul56o9iXoiNHLXNr+1OxwByWc0p07W9H7LJjexl1edB8XuugJK0cfxCmOMkQJj2wuKVGaSrKAjN7QeIgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lydrkeNPjVug/kvLF5iZK2q1i1y7oYev4S8Q7Zs9bA=;
 b=MqxweOI9aFKZavwaO/aSZrdii26JZgIjuqA11Y0JtlyJ6Br9k5HRr0PtNnZkOCTGMeVYw5C8CVg4mbOgI/o67Hgib6iTUaZNMVtbGBIaIw8Idq2KsTTzZcZM19ktzaScTF5Rs6rltOp5B8iqE0uyaBKmR75pQR4JHIri328awxU=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CY4PR11MB1384.namprd11.prod.outlook.com (2603:10b6:903:2c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 18:18:25 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5373.022; Wed, 29 Jun 2022
 18:18:25 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sudeep.holla@arm.com>, <linux-kernel@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <atishp@atishpatra.org>,
        <atishp@rivosinc.com>, <vincent.guittot@linaro.org>,
        <dietmar.eggemann@arm.com>, <wangqing@vivo.com>,
        <robh+dt@kernel.org>, <rafael@kernel.org>,
        <ionela.voinescu@arm.com>, <pierre.gondois@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <gshan@redhat.com>,
        <Valentina.FernandezAlanis@microchip.com>
Subject: Re: [PATCH v5 09/19] arch_topology: Use the last level cache
 information from the cacheinfo
Thread-Topic: [PATCH v5 09/19] arch_topology: Use the last level cache
 information from the cacheinfo
Thread-Index: AQHYikaSsliGXUqkU0W62iFZL9A2pK1mrJEAgAAIIIA=
Date:   Wed, 29 Jun 2022 18:18:25 +0000
Message-ID: <3656a067-cc3f-fd5b-e339-5925a856cce1@microchip.com>
References: <20220627165047.336669-1-sudeep.holla@arm.com>
 <20220627165047.336669-10-sudeep.holla@arm.com>
 <bb124e47-f866-e39e-0f76-dc468ce384c6@microchip.com>
In-Reply-To: <bb124e47-f866-e39e-0f76-dc468ce384c6@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c9870fd2-681d-4690-edc8-08da59fbc246
x-ms-traffictypediagnostic: CY4PR11MB1384:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FeIhjG/n388V0rQVnrsM3LnMyCZKKXRLud+w0sv0BBW0u5YMfLYgMuzc0UhlwG8oGAatFodCFHA155qWpvor6ryG4woKb3qsvCVXpNoE7+tA9N5aJ1XWWH0w1rQZiG+Sm4FIsylf8IxAUqLbX5bIzI33S0pIc/OpdX+sNea5ra2zKqHd0Jg7sa6soKSBn6avNywHQNx6k0uC5FP2sW8euTLmEnYQnWYviPwqGSNGWX2thIlouXnRSAVTgNIwxUtxAAqpBDyY0u1jo/Qo0KFwbGoGHWz3ozRaalCsS/sH/mTYFZ7IOjLuyj2Tf79zT6joSsaEL6RHNUdRfgxGNRPMkYC8Ws9U7Qv0VI+wYcmub4/lF1TZwryaGiXO8uB49WR++0jcug7ldfsuDKiNgrMF0r7mcxJ5b4d6XiGTGiwPIwxonEY0JeZ/lZ/rviykiPb2miORAW6xqoWakdWlvpDXhMEKxxM9alDoB1390c/ASiBcMTsaJdr22+xizrBrhqEJHWAZRkVHa073m2HlqqjoNxzk/j+tRyKKYN0T80otm4Aa/uf3JIn9wnjp+4JoO+Ctu0J6+7FZE+pzmRpx5185EfwV6uiYi6ukFUWI/v35CAXZ9STUNlzKocoNSjuzSlXWKvCaJaPOarZK85yGTSoHhYKYk4DQKWk6BwozkORJm6HfzUwXTNq34O54HKLCssrOMKItYgtLvJv2RpAkeEykx271cFkZU7UKXe69pKgrJBO6O7qkVAJvCovEQSfGaSauptGQYt51cX3jmMXOnNxKpOPWOBu8qVWnLDvDFdqbYf4zNsG7e2hy6+EwtQctdzQj/yMo0zEWConMXbje3QZSYYkPFInp1oklu63JSQ8Bkhghb2HRUMJONeAlSXMiImiKxuSBR0Z6eCLQenCZFnZfGdCchmOlFZdMWt6Rxi2YuHY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(39860400002)(136003)(346002)(366004)(107886003)(186003)(38070700005)(8676002)(36756003)(54906003)(91956017)(38100700002)(4326008)(64756008)(110136005)(2616005)(316002)(76116006)(83380400001)(71200400001)(66946007)(66476007)(66446008)(66556008)(6512007)(31696002)(966005)(31686004)(478600001)(6486002)(7416002)(6506007)(26005)(2906002)(5660300002)(8936002)(86362001)(122000001)(53546011)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TER1WEZiTVpwcGd6WmZCd1VYNHhZR1A0cUVJeUlZTFlwNUZ1UU8xOVdtZ3NN?=
 =?utf-8?B?K3VOeWVjMWQ5cWNiMHYxdW1YaUE0NXB1ZnQraVFGRXhBTXVwckdOaDNkU1Jo?=
 =?utf-8?B?YU52MkJyOGpqamhCeUdOcU5hZ08xdWpYOTJPZUJJZ0ZoRWkwdHpjdEN6bnIx?=
 =?utf-8?B?WW1Sc3dIa01lVGhpYU84ekFzSThGRmNXV1JzN05VaFMrT3lGRWJDNEtjaVg3?=
 =?utf-8?B?TVFTRVBiWWdna3Y0cWhST0IxQVk5UjZ4Um1oOHMrTUFFSEsrOEJjam90enJH?=
 =?utf-8?B?NHgrZGxPcm8rOWlNRTFYSjRJUkdvVmptamdDck9udkt1TWxxdGZWSnF0WjR0?=
 =?utf-8?B?TjFFVUZVRExFVmxTSjNZS2NUSkNoVDhEMW9QUGlLMXhHaHZwNWo1V3ZxSjhm?=
 =?utf-8?B?Z0JKTDIyVGJjNDVORFlBTk5DYTFLYnVzRHljK2hGU1FYSHFpa3ZRbk1VR0lt?=
 =?utf-8?B?SDEzKy9SUzYvc1dHejZYa0NkS0dEQ1dOU1NkeUpTOWoraFJGOWZiVks4UVhF?=
 =?utf-8?B?alEyTW1BRUF2aWxWcjZTdHNzcVBkcWxPZU1zTFVaQ2piYytuUHpRWk1vaU0z?=
 =?utf-8?B?TzJxVkdNeHFPVk5zUkxwUXpERzJQaWlsRVlkQXFjNFRKMVJCYk11MkZQVTFH?=
 =?utf-8?B?ZnRDSTRLVXE2RENGa3FKWk9CSnNBQmJHYks4cEFtV3dibFpMakVNZ2Z2YThK?=
 =?utf-8?B?M3c0TEtibC9EWnc3RlREWmhZa0dEYTAzTitLSFk1VXRwV3FFUlFFb2wrNkVw?=
 =?utf-8?B?QktRMVE2dmhhV0QxeWVZZGg5R0x5V21mYXFQV3dGcjZSMS90N1IxdXl2cVB4?=
 =?utf-8?B?cG1IRUFMODhJTDJ2NC9MYmVuUVI3a3JLdVdQblBZUC9JaGF0VFBSeC8zb1Aw?=
 =?utf-8?B?WC9XaG51dVpnNU85SjVVTjZ4THVtbFM4MmxoVnlTR3BtSC9MUkJLNGduWEQx?=
 =?utf-8?B?UEVxdjRYalhQZVN2TWFxZWF2TEdaNEdXSEpBWnloSGZuSnNlRVk0WmFWdjdG?=
 =?utf-8?B?V0s4VjlWSWR5dWpVdkwzL0cwbkRuUXpnOE05eGJTTlp0Z1gvV1RUTlNveUxL?=
 =?utf-8?B?VURRcVVQOFRQMVZMSGJYUFhubngxdXFGNjJOSU1FK003MUw4eEpiOG41bG9J?=
 =?utf-8?B?WWFuUVhEbXJPWEZyRlozenNUVStkRDhtamFFVVphYzkvb1pnRklpL0x4WVU1?=
 =?utf-8?B?WDE3RVVTMFpjUUZ0YmZkRTQyVkJ5VTUwT0grTWJRbjludUg0dmtJdExrMWxl?=
 =?utf-8?B?OFRENjUyRStiaUEzNVlaMElLZHBQRlVDL3lNMDVEQjhWanQ3N09wRVlkaVBU?=
 =?utf-8?B?UGh5V0sydmF1cjZuUmxWRjBabjFHN3NZc1JHWFVoVUFNNVJFMHVnSjRmc24r?=
 =?utf-8?B?amZSRndzbEFZSnBuOGFZTkZJQ240YmpRZ2p6MkwyTmcwRFVERWEzblZmR1RE?=
 =?utf-8?B?aE5DT3ZMc0h2OUUwaVRNdkZ4dnVLNlRibHgwWkJmNHlhSW00akNtS3hjMzRi?=
 =?utf-8?B?T01XTFhsYzNIUm9rSFBVenZjV28wSG52c2NzYWM5TWJ0WU1CRkdkdlVOS3Er?=
 =?utf-8?B?a2xGTFRrd1VtL2hIQ1ZIaXFkT0x0MWFYYWhSN2dzZlFRNmlIS0JNdW8wWmdX?=
 =?utf-8?B?NE1CaEpCN0hmS1F1a3hHYi92KzRHNDlmTXR1NENhYVUzdnVLZHZJRXIybmZm?=
 =?utf-8?B?M2hyT2hMQTdtcVBwcWpqY2FFQWNEQTY5Rldzc0ZqZ3o1TDIzS2pnMEJCWUtC?=
 =?utf-8?B?QWpFZFVGOFdGSG1xanhQRXJJb3RhaUUzYVlBMWdBS2NhL2tXWGxoSDlnRGt5?=
 =?utf-8?B?RHIzd09mMnJtcll6NnpoYXhlMDcvVXRjdzZXY2xwVC9yUGFNdkR4RlM4RVIz?=
 =?utf-8?B?R1ZwQVgyWHVZNjlaQXJxMFRSZXREeHFvODFQZHZIMEphYnlZOXRMRmdVMGdD?=
 =?utf-8?B?NE9HSzh0eGpzdk9ZQTZhUG1LWHFzaUxDcStjbERUS2dvVWdsNlhLR1R1cmda?=
 =?utf-8?B?VTJlWDRDU2xmUXBqUkNLa3Zhc3RkNzJOZHdMbXlleHUxcnQ4K0dRVXJFd0x1?=
 =?utf-8?B?U2lqUG9UeC9VRXdSTGZwMTlmVFlqZVJESm1DaFYzRExBem5wVlFYdzFuc0lk?=
 =?utf-8?B?UktKd29zdmdZS09NT2pJMktnc0c2WUVyMjUyQUcvREFaTFdTczR3VUNObkJF?=
 =?utf-8?B?YkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31FA09677DEC594FA40DDAB40DE05355@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9870fd2-681d-4690-edc8-08da59fbc246
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 18:18:25.7125
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YzQHtQMwcPEW3elMbr92knKrlaCdtlMGbjjCyPyJSPznwKDd4wn39qjkIdTlgj5JwZvOjahsKcMyGA2FsguxaeJf3VLIrroJel9MTTlTWoI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1384
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjkvMDYvMjAyMiAxODo0OSwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+
IEVYVEVSTkFMIEVNQUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1
bmxlc3MgeW91IGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gMjcvMDYvMjAyMiAx
Nzo1MCwgU3VkZWVwIEhvbGxhIHdyb3RlOg0KPj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGlj
ayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBp
cyBzYWZlDQo+Pg0KPj4gVGhlIGNhY2hlaW5mbyBpcyBub3cgaW5pdGlhbGlzZWQgZWFybHkgYWxv
bmcgd2l0aCB0aGUgQ1BVIHRvcG9sb2d5DQo+PiBpbml0aWFsaXNhdGlvbi4gSW5zdGVhZCBvZiBy
ZWx5aW5nIG9uIHRoZSBMTEMgSUQgaW5mb3JtYXRpb24gcGFyc2VkDQo+PiBzZXBhcmF0ZWx5IG9u
bHkgd2l0aCBBQ1BJIFBQVFQgZWxzZXdoZXJlLCBtaWdyYXRlIHRvIHVzZSB0aGUgc2ltaWxhcg0K
Pj4gaW5mb3JtYXRpb24gZnJvbSB0aGUgY2FjaGVpbmZvLg0KPj4NCj4+IFRoaXMgaXMgZ2VuZXJp
YyBmb3IgYm90aCBEVCBhbmQgQUNQSSBzeXN0ZW1zLiBUaGUgQUNQSSBMTEMgSUQgaW5mb3JtYXRp
b24NCj4+IHBhcnNlZCBzZXBhcmF0ZWx5IGNhbiBub3cgYmUgcmVtb3ZlZCBmcm9tIGFyY2ggc3Bl
Y2lmaWMgY29kZS4NCj4gDQo+IEhleSBTdWRlZXAsDQo+IEkgYmlzZWN0ZWQgYnJva2VuIGJvb3Qg
b24gUG9sYXJGaXJlIFNvQyB0byB0aGlzIHBhdGNoIGluIG5leHQtMjAyMjA2MjkgOi8NCj4gSSBz
dXNwZWN0IHRoZSBpc3N1ZSBpcyBhIG1pc3NpbmcgIm5leHQtbGV2ZWwtY2FjaGUiIGluIHRoZSB0
aGUgZHQ6DQo+IGFyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21wZnMuZHRzaQ0KPiANCj4g
QWRkaW5nIG5leHQtbGV2ZWwtY2FjaGUgPSA8JmNjdHJsbHI+IGZpeGVzIHRoZSBib290Lg0KDQpO
bywgbm8gaXQgZG9lc24ndC4gTm90IHN1cmUgd2hhdCBJIHdhcyB0aGlua2luZyB0aGVyZS4NClBy
b2IgdGVzdGVkIHRoYXQgb24gdGhlIHRoZSBsYXN0IGNvbW1pdCB0aGF0IGJpc2VjdCB0ZXN0ZWQN
CnJhdGhlciB0aGFuIHRoZSBvbmUgaXQgcG9pbnRlZCBvdXQgdGhlIHByb2JsZW0gd2FzIHdpdGgu
DQoNCkVpdGhlciB3YXksIGJvb3QgaXMgYnJva2VuIGluIC1uZXh0Lg0KDQo+IE5vdCBzdXJlIHdo
YXQgdGhlIHJlc29sdXRpb24gaGVyZSBpcywgb2xkIGRldmljZXRyZWVzIGFyZSBtZWFudCB0byBr
ZWVwDQo+IGJvb3RpbmcsIHJpZ2h0Pw0KPiANCj4gVGhhbmtzLA0KPiBDb25vci4NCj4gDQo+Pg0K
Pj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvci8yMDIyMDYyMTE5MjAzNC4zMzMyNTQ2
LTEwLXN1ZGVlcC5ob2xsYUBhcm0uY29tDQo+IA0KPiBidHcsIHdoeSBpcyB0aGlzIGxpbmsgaW4g
dGhlIHBhdGNoPyBXaHkgaXMgYSBsaW5rIHRvIHY0IHJlbGV2YW50Pw0KPiBMaW5rcyB0byBib3Ro
IHY0IGFuZCB2NSBleGlzdCBpbiB5b3VyIGZvci1saW51eC1uZXh0IGJyYW5jaC4NCj4gDQo+IExv
ZzoNCj4gZ2l0IGJpc2VjdCBzdGFydA0KPiAjIGJhZDogW2M0ZWY1MjhiZDAwNmZlYmM3ZGU0NDRk
OTc3NWIyODcwNmQ5MjRmNzhdIEFkZCBsaW51eC1uZXh0IHNwZWNpZmljIGZpbGVzIGZvciAyMDIy
MDYyOQ0KPiBnaXQgYmlzZWN0IGJhZCBjNGVmNTI4YmQwMDZmZWJjN2RlNDQ0ZDk3NzViMjg3MDZk
OTI0Zjc4DQo+ICMgZ29vZDogW2IxM2JhY2NjMzg1MGNhOGI4Y2NjYmY4ZWQ5OTEyZGJhYTBmZGY3
ZjNdIExpbnV4IDUuMTktcmMyDQo+IGdpdCBiaXNlY3QgZ29vZCBiMTNiYWNjYzM4NTBjYThiOGNj
Y2JmOGVkOTkxMmRiYWEwZmRmN2YzDQo+ICMgYmFkOiBbOTVjNzU4YTg4OTljNGU4ODI1YTM1YTYy
YTZmMzE2Njc5OTEyMTdmOV0gTWVyZ2UgYnJhbmNoICdkcm0tbmV4dCcgb2YgZ2l0Oi8vZ2l0LmZy
ZWVkZXNrdG9wLm9yZy9naXQvZHJtL2RybS5naXQNCj4gZ2l0IGJpc2VjdCBiYWQgOTVjNzU4YTg4
OTljNGU4ODI1YTM1YTYyYTZmMzE2Njc5OTEyMTdmOQ0KPiAjIGJhZDogWzVjYmI5YWVlZmUwMDcw
YjYyN2NkNWM1NTI4ZTZlNjM3MDE1NjFkNTddIE1lcmdlIGJyYW5jaCAnZm9yLW5leHQnIG9mIGdp
dDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9kZWxsZXIvcGFyaXNj
LWxpbnV4LmdpdA0KPiBnaXQgYmlzZWN0IGJhZCA1Y2JiOWFlZWZlMDA3MGI2MjdjZDVjNTUyOGU2
ZTYzNzAxNTYxZDU3DQo+ICMgZ29vZDogWzJlNjU1NmJhZTNlNDUzY2YyN2YzZmI5YzYxNDQwODBl
MmE2MTcwN2VdIE1lcmdlIGJyYW5jaCAnbGlibnZkaW1tLWZpeGVzJyBvZiBnaXQ6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbnZkaW1tL252ZGltbS5naXQNCj4gZ2l0
IGJpc2VjdCBnb29kIDJlNjU1NmJhZTNlNDUzY2YyN2YzZmI5YzYxNDQwODBlMmE2MTcwN2UNCj4g
IyBnb29kOiBbMTdlZmU3NmFmMzNmNmFmMDlhODIxYWNjZTJlMmU0ZTg0ODE5ZDM4MV0gTWVyZ2Ug
YnJhbmNoICdmb3ItbmV4dCcgb2YgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9r
ZXJuZWwvZ2l0L3RtbGluZC9saW51eC1vbWFwLmdpdA0KPiBnaXQgYmlzZWN0IGdvb2QgMTdlZmU3
NmFmMzNmNmFmMDlhODIxYWNjZTJlMmU0ZTg0ODE5ZDM4MQ0KPiAjIGdvb2Q6IFs1YWVlYWY0MGQz
MTI4OGU4ZWZhNmZmMmNiZDk1MmIxM2RlMDc3YWE5XSBNZXJnZSBicmFuY2ggJ2Zvci1uZXh0JyBv
ZiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbW1pbmQvbGlu
dXgtcm9ja2NoaXAuZ2l0DQo+IGdpdCBiaXNlY3QgZ29vZCA1YWVlYWY0MGQzMTI4OGU4ZWZhNmZm
MmNiZDk1MmIxM2RlMDc3YWE5DQo+ICMgYmFkOiBbZjY0ZGZhMzZiMzI1ZDEwN2Q4YWNhOTcyNzQx
MDM0M2JkODZkMzdkY10gTWVyZ2UgYnJhbmNoICdzdG0zMi1uZXh0JyBvZiBnaXQ6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvYXRvcmd1ZS9zdG0zMi5naXQNCj4gZ2l0
IGJpc2VjdCBiYWQgZjY0ZGZhMzZiMzI1ZDEwN2Q4YWNhOTcyNzQxMDM0M2JkODZkMzdkYw0KPiAj
IGdvb2Q6IFs4OTQ1OWEyYWVmODgzMmYwNDRjOGZiYmVjNTRiNDZjZWMwNTE1NmM4XSBNZXJnZSBi
cmFuY2ggJ25leHQvZHQnIGludG8gZm9yLW5leHQNCj4gZ2l0IGJpc2VjdCBnb29kIDg5NDU5YTJh
ZWY4ODMyZjA0NGM4ZmJiZWM1NGI0NmNlYzA1MTU2YzgNCj4gIyBiYWQ6IFsyNGNkZWZjOTY5NzNm
ZjFhMWY2NzAyNDcwYWQ5MWFiMDE5ZTVmZWRkXSBNZXJnZSBicmFuY2ggJ2FyY2hfdG9wb2xvZ3kn
IG9mIGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9zdWRlZXAu
aG9sbGEvbGludXggaW50byBmb3ItbGludXgtbmV4dA0KPiBnaXQgYmlzZWN0IGJhZCAyNGNkZWZj
OTY5NzNmZjFhMWY2NzAyNDcwYWQ5MWFiMDE5ZTVmZWRkDQo+ICMgYmFkOiBbMGQ3MWYyMzZmMGEx
MDY3YWJhNzY2MGQwNTZhOTA2MWI1ODc3YmY1Ml0gYXJjaF90b3BvbG9neTogQXZvaWQgcGFyc2lu
ZyB0aHJvdWdoIGFsbCB0aGUgQ1BVcyBvbmNlIGEgb3V0bGllciBDUFUgaXMgZm91bmQNCj4gZ2l0
IGJpc2VjdCBiYWQgMGQ3MWYyMzZmMGExMDY3YWJhNzY2MGQwNTZhOTA2MWI1ODc3YmY1Mg0KPiAj
IGdvb2Q6IFtiZTZhYjJlODIyODg4YjhkOTk4M2Q2NzBmZGFiYzA5ZDc1M2ZkMjRmXSBjYWNoZWlu
Zm86IFVzZSBjYWNoZSBpZGVudGlmaWVycyB0byBjaGVjayBpZiB0aGUgY2FjaGVzIGFyZSBzaGFy
ZWQgaWYgYXZhaWxhYmxlDQo+IGdpdCBiaXNlY3QgZ29vZCBiZTZhYjJlODIyODg4YjhkOTk4M2Q2
NzBmZGFiYzA5ZDc1M2ZkMjRmDQo+ICMgYmFkOiBbODU0YTMxMTVmOWVjMGI4ODkwMTVjNjg1NGZi
YzBjMWQ2OWE0NmU0YV0gYXJtNjQ6IHRvcG9sb2d5OiBSZW1vdmUgcmVkdW5kYW50IHNldHRpbmcg
b2YgbGxjX2lkIGluIENQVSB0b3BvbG9neQ0KPiBnaXQgYmlzZWN0IGJhZCA4NTRhMzExNWY5ZWMw
Yjg4OTAxNWM2ODU0ZmJjMGMxZDY5YTQ2ZTRhDQo+ICMgYmFkOiBbM2IyM2JiMjU3M2U2NWIxMWJl
OGY0Yjg5MDIzMjk2ZGVlN2YwNmMwYl0gYXJjaF90b3BvbG9neTogVXNlIHRoZSBsYXN0IGxldmVs
IGNhY2hlIGluZm9ybWF0aW9uIGZyb20gdGhlIGNhY2hlaW5mbw0KPiBnaXQgYmlzZWN0IGJhZCAz
YjIzYmIyNTczZTY1YjExYmU4ZjRiODkwMjMyOTZkZWU3ZjA2YzBiDQo+ICMgZ29vZDogWzJmN2I3
NTdlYjY5ZGYyOTY1NTRiZDM5YjBiMmIyZjRkYTY3OGM3MzZdIGFyY2hfdG9wb2xvZ3k6IEFkZCBz
dXBwb3J0IHRvIHBhcnNlIGFuZCBkZXRlY3QgY2FjaGUgYXR0cmlidXRlcw0KPiBnaXQgYmlzZWN0
IGdvb2QgMmY3Yjc1N2ViNjlkZjI5NjU1NGJkMzliMGIyYjJmNGRhNjc4YzczNg0KPiAjIGZpcnN0
IGJhZCBjb21taXQ6IFszYjIzYmIyNTczZTY1YjExYmU4ZjRiODkwMjMyOTZkZWU3ZjA2YzBiXSBh
cmNoX3RvcG9sb2d5OiBVc2UgdGhlIGxhc3QgbGV2ZWwgY2FjaGUgaW5mb3JtYXRpb24gZnJvbSB0
aGUgY2FjaGVpbmZvDQo+IA0KPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXw0KPiBsaW51eC1yaXNjdiBtYWlsaW5nIGxpc3QNCj4gbGludXgtcmlzY3ZAbGlz
dHMuaW5mcmFkZWFkLm9yZw0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LXJpc2N2DQoNCg==
