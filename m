Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8583956178A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 12:20:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiF3KUR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 06:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234016AbiF3KUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 06:20:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 262C245070
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 03:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656584411; x=1688120411;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=f8CqJWRkHoDagzwGAgH/KueETKIck0fEuJO5la8rrN8=;
  b=azYVzLdufE37DkHk1eAhTzKxTNRV7MX3LSkFd7pQy6a+hTj9XUKKtOkR
   O87f8RyohmbNptrVY39viMrXrrqPfbu4pey5huVIxJ/1aa30o7FzcSqtj
   5VkfErAIKGY1+ZvfEsovdvFSTtT2Jg+C48eqmZuCQ71CW64PfgXBjPtkn
   pxl30rPM0bQf6j6YUrKBi0nlxem37Nw9/IJsVIJ6g9D/6kYDYd7ksqHov
   Dihuwtsuy5MSy1Qa+0kSa+niTPaS4zcs8C2Z83KtLNp8quvKK8mwrL2i2
   2UrrVkTGkFkVhMORtazjoyakLXk+KggVYBpm+xdESv6UDRCjwOv9gJFW5
   w==;
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="170507197"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Jun 2022 03:20:10 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 30 Jun 2022 03:20:10 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Thu, 30 Jun 2022 03:20:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IAspQpU92ebkGtCgEmB8yKvj67MnfERIECM4d4uFDb2AK2INJrHJH7cusv9N/E8li2Xd2dRSqXPc37Yt2Bh7ju3DKFrufcG7LpgbC9wGXZNtM9jBzhoPH3ZvGyHWJ5FO8cGeIrSsWB0rF9Qy0/Rh3VWs048xCuJADZKQnJsvzIScyQSKRs6T4sA074rdMF/LpRl4j38BRU7Luln9cuuugag1BsVvUyFJYSHe0DWp0ac2AbEwqlXtd2wpr+AuaDm1xFF3JgDKXTYdQnIadB8QsFybp9zDeoSdOI3DfMQj0vQyTHmUmvK2JEX6B2cEkbsOTa4ahynZ4ikAUQHvaaQttg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f8CqJWRkHoDagzwGAgH/KueETKIck0fEuJO5la8rrN8=;
 b=RR8FhNk8GPZzEsKC/H5KHBxMd4JHURU7kdHunubvP3W4EnMEVbj7yHnIrG6DDvaWa8bOTyhz8no0TLOsThHqS7QaVjrFUG6RhCLe5g0LAFEiGQJzev2bRZwCtNxTp5Z4pz6fB4dBr9/YPDL3bocudyBaBK0dQUBjBZwmTCnKsNhnH7KQp3KnK2C4TAolFDP0JKnrJG2kvBIgLMdmvXi7XCh0gwX9dkzXkLeA5hBdZMrs1vS5Eod1PJdRSMZ8WeIgfoZ/iKSgVZ+klv/YZ+DiJmdECLmNxzl2piP8A2/MXAmpSsm+avqJqLkTH8ULaF/wlMu0DuCjJ2E73uChCjjgzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f8CqJWRkHoDagzwGAgH/KueETKIck0fEuJO5la8rrN8=;
 b=QCNe30BKGhimE2kdQ+OmhTxo5OKTfItXC1z1Ezq5LKtu3QS7Y98rBLVC6vH/ryEzwdojlZUlTLsp+rMZ3QXzOfWz7TTE/+tLZdIyXIsMuGwAVXRAxEHSly6VWfcU85UiV/WLc55v0jlKpHGf8T/JoUpSZCxm1l6Da7UC4uUsd5s=
Received: from DM4PR11MB6479.namprd11.prod.outlook.com (2603:10b6:8:8c::19) by
 DM6PR11MB4475.namprd11.prod.outlook.com (2603:10b6:5:14e::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5373.18; Thu, 30 Jun 2022 10:20:07 +0000
Received: from DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4]) by DM4PR11MB6479.namprd11.prod.outlook.com
 ([fe80::1954:e4ab:eafd:9cb4%5]) with mapi id 15.20.5395.014; Thu, 30 Jun 2022
 10:20:07 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <peda@axentia.se>, <regressions@leemhuis.info>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>
CC:     <du@axentia.se>, <Patrice.Vilchez@microchip.com>,
        <Cristian.Birsan@microchip.com>, <Ludovic.Desroches@microchip.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <gregkh@linuxfoundation.org>, <saravanak@google.com>
Subject: Re: Regression: memory corruption on Atmel SAMA5D31
Thread-Topic: Regression: memory corruption on Atmel SAMA5D31
Thread-Index: AQHYL7i/by/02n1wA0qavxdAEojSf61odn4A
Date:   Thu, 30 Jun 2022 10:20:06 +0000
Message-ID: <ab0d6f40-bbb8-81e2-b703-d33f4057aedc@microchip.com>
References: <13c6c9a2-6db5-c3bf-349b-4c127ad3496a@axentia.se>
 <d563c7ba-6431-2639-9f2a-2e2c6788e625@axentia.se>
 <e5a715c5-ad9f-6fd4-071e-084ab950603e@microchip.com>
 <220ddbef-5592-47b7-5150-4291f9532c6d@axentia.se>
 <6ad73fa2-0ebb-1e96-a45a-b70faca623dd@axentia.se>
 <0879d887-6558-bb9f-a1b9-9220be984380@leemhuis.info>
 <4a1e8827-1ff0-4034-d96e-f561508df432@microchip.com>
 <1a398441-c901-2dae-679e-f0b5b1c43b18@axentia.se>
 <14e5ccbe-8275-c316-e3e1-f77461309249@microchip.com>
 <c5928610-4902-27f3-7312-e8c85eefad39@axentia.se>
 <bfb4cb27-e2e1-e709-1c27-d938e4d30eab@leemhuis.info>
 <6b1bae01-d8fb-1676-3dee-9d5d376e37f1@microchip.com>
 <0d8b2d9c-af85-7148-ff13-aa968a7f51ad@microchip.com>
 <AM0PR02MB4436C535FDD72EFE422D8B10BCB39@AM0PR02MB4436.eurprd02.prod.outlook.com>
 <272fb9f0-ad33-d956-4d0f-3524c553689c@microchip.com>
 <dc500595-7328-999e-6fa7-7e818378bb0d@microchip.com>
 <d12d7f38-f3cb-6461-da7a-a82c3f340b80@axentia.se>
 <17835914-cc0d-4a8d-4795-b16ff9243b76@microchip.com>
In-Reply-To: <17835914-cc0d-4a8d-4795-b16ff9243b76@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e7e347a-38fc-4e26-b676-08da5a821af0
x-ms-traffictypediagnostic: DM6PR11MB4475:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wxb6ya53F4EWzU7kueSCZxHm9pFgEiRWXgLY9qQeQkHdPm3oYz5fC/4pdCrcIPyKC+kdB3dkW8GatLW9gtPNKJObk+ylzcXD8zGN6D+pk8VH6AGRZp3EslSc+XZgEM52LJVjB0Jxkt4H93A+TdrbMM7kz34T0z8qLvDV0K13NlX1ageHq7r24Iloy2f6J4k9VmFLKZFzlferch/0zVZfODNFyJDAfXvOdoo259hb6zrrv1rVqARGOG726lMovmmBNe1b7FOsUUVH0udj+dpPIPd7z5ptGTbdYcETQMf+BfrBdxrmpu+kjTm1T5o4YuiRaC860GXAIo+jVPSBJJrWxkfct7grqYFwKosXuneJYBXqFskjrwl/MLsYcrgAIqSERsV7zDQBZj1OkKEHea1KOfGb2po2Kgng1KVkk6qJy9S8U2byF1hMNB5+noRFDeRKF1RHWtkHxPIWbHLyXhdP5OzvOzphgE8gdlVenUKCpKBk6C02vugzI9kJq0irE2oDeiqrDV7qRsM6ZJAik7+EI/Jj/PG3gHlcGdmdjs6DHtLHkSi4YRS7dtqN0NyibPhT1gNPkG9rPg70NTrZKhAq1SHHU8HguJLD3y3K7LIhGsHAaItA/ekpyhvizmZE/ZD4fxFNeAXXP510VhtHsrlpCMIpC4EwAh1ZK9YCu9IQLnoZfwkw2sYmj7xLoXDnk0BqOfKegKBMiKRUHCKVXQf/oHVDPoMjzhPF6oK29qBhCdXBdBTjBpQNiZgHO+FygVbZOir87/DXcL3EGYunOE6eUWoLzYtvaTb+cFSoQnAiKBY08KhdoDyDDbo+mVlhjwuJ2A2U7qOXZsXXmZ6wrAIrJS93GEKDc4i1U08rgkSTAxAeVPatvDEUShSn+4usizeR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6479.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(366004)(39860400002)(346002)(136003)(396003)(2906002)(2616005)(186003)(53546011)(478600001)(6506007)(83380400001)(41300700001)(8676002)(54906003)(6512007)(5660300002)(6486002)(316002)(71200400001)(76116006)(122000001)(66476007)(26005)(8936002)(36756003)(110136005)(66446008)(86362001)(91956017)(31686004)(38070700005)(31696002)(66946007)(64756008)(38100700002)(4326008)(66556008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OFJXdWlmWjBtV1lEdkFrMGtXT0xUckJaVFcvbHp0T2R3bVg0WkNlNWtWUUVr?=
 =?utf-8?B?UWVpSkN0QmYzTGJuWUNENG53QzNmSzVuZUlIcVN4RXJVTWIxYTNYWTdHcGNR?=
 =?utf-8?B?dUk4M2M0OEpoRjJwQmtxODZvRnJRU2lqTENqQTF1T0lrR0hhcnNLaENib3dO?=
 =?utf-8?B?Qkl3ODFGZ0svZ2FMbFJMdlMrenB0cEk3cnN0QXdJUUVJanVDeGE4MDNCOHJs?=
 =?utf-8?B?KzNVV2UyeGtnOXBCNDQ3MTdRakVMRTNsYlpHN0Jza3JhREZrQnlaam5CQnVW?=
 =?utf-8?B?UzluczlGUnRlS1dBZHJuODN4b2RBM2FpSElXeTRiV05UanNxc3RwbDRkVTMv?=
 =?utf-8?B?SW9QUWl4eXdEM0FWNGhCVUNXdEIvWWNLMVdCZFI1alhZSUQ3OXM0OTdDeEdK?=
 =?utf-8?B?a0lEK2dvVVV1enFIQUdmZ3RYS3h2UUlrdGRENTRsYkhuUElJS2IvSnhSVS9p?=
 =?utf-8?B?ZHBWZjVOVENBZ1czK1hNZGJ2WDFOYTBzZWZuWFVKVUI4ME1qYy9YcW50OThi?=
 =?utf-8?B?c0FhQVplUi80bkFtWEkwdnVxcnk5TjZReFF6Z1h4aU1FeWdHQUJzM25qWXdQ?=
 =?utf-8?B?NnJaUTd5SDRsblI4eFpjYWIxUGdxR1JyRk5xNVl4NWF0KzVWRjlJUWgzU0ps?=
 =?utf-8?B?U2xXY1E5VUpCclNTditiS2VSZFZYbmhSZkw1VUZrL21LenVCbnphR0gvYm9O?=
 =?utf-8?B?LzJXeWZuL1NibGZ1Z04rS2F1S3kxWUVRcElMZTM2ZXFrSExyOVd5U05mY0Vu?=
 =?utf-8?B?Mm5PODUyNnM2dldQMXZkajJTazJZTTdIUmhuTlQ0dHFiTUt0NFFsQzUwcFhp?=
 =?utf-8?B?RUJNVUthOVNTeXU2SjBEbFZ0OHFsam1SSllKelRiaXR6L1dCQUwrSlJxT2tr?=
 =?utf-8?B?WDhUSVdjdnFNUFQ2RFFZZEJnV2h1SlIzZjJQM0N6dzNKL3oxUEZ3a0s5blp0?=
 =?utf-8?B?M3YwLzQvSmFaTnJickVSMjNmL1EvRkdFL0s4czhoS0RGeHMxME1UZkRkR1Rk?=
 =?utf-8?B?SXo4ekhjdXJ6TklOWU9waG5UcTN3eU9yVWNjQjlEa2NIc1MvY1FtSHp5eklx?=
 =?utf-8?B?N091MUNKbVV6UVlVeTYzVXp0Zkl6YjBvOXJURjUyTFJ6UkxpYVo1ODd5R2JL?=
 =?utf-8?B?R1RlZmNmQlRMYzhmM1laR0dMeDlmdUpNYVhvamJ2aitNTGkvS0RlNXV3b2k1?=
 =?utf-8?B?ekM1OHF6ejY5SndyTkMyeXNxUGZmL0tVRnExbnJVRlRGQURtUVlUaEd6ZWVz?=
 =?utf-8?B?QnhhemZiT0xQQjl5SzJNdXVZdGN5K3IrTUNRRFA3VlRXcE9nUE1RSmlkZlpO?=
 =?utf-8?B?cHRTeXpkM2swSzlGdnRUNEJCMUM3TGJ2RHMwRlBJSkJieENNbW8wVWlDbWpH?=
 =?utf-8?B?NTVHTUgvcnFpRUIxYW5zbkFsNncrTURPSUx4eG5HZW0wZ1MvczlYUWhjUHlN?=
 =?utf-8?B?UCtqWExPK3FWSnBCc3ArZkNVQUpXUGswRW9BcDArVG1id1dHcTd4azVxZUh5?=
 =?utf-8?B?anBNako2WHR5cG43M2IyU0lrbENwN0VQVURUZzZoZERnakQ5UVNlOStTaWR6?=
 =?utf-8?B?c1ZkK1ZDMHM5SUI5Q1BWZHIyRTRIRWhMRGE3eFdISXlGVnMrUGZodmxkK1VB?=
 =?utf-8?B?NWNqdW9kZ21ZY3RJQnk0cXNRSmt1dEFDOG9yUlVpR1h5Qk16Y2M5bEFveU1n?=
 =?utf-8?B?dGI0WG52cUxwOUNENURFR0dybU9CM1RVNlhpRTlNVFo2Tk1PSEpwV1VPQVZY?=
 =?utf-8?B?VHlYZkJJZ3dqVTBwQTFNNExTUFpqdHdBTm1qY3NRck5OcHZ5VlIxT0U3b3Zl?=
 =?utf-8?B?SmFmOHA1SlZHOVpGVG5hd0ZRTjdhTjRLci9rMXFTcXYvUU9DTWJMQmNxNFBx?=
 =?utf-8?B?SWxJNldvR29GMnhRdjNCc3hpNjErQStybFN1L1doZnFMLzJoQTAvdmtzNlFk?=
 =?utf-8?B?dWwza3MyMXp6S05VUjNQL095RUZLRmd1LzZLc2xBa0JaM2EyUkhMUEhWWWx6?=
 =?utf-8?B?dGlnYno1VU5ibmd4SWZ4ZEJFRlBUR2pwMllHa0hkSFB4cEl5Wk0vekRPczNh?=
 =?utf-8?B?Q2JqdzA0TVFPRmFGZnhpaDE5ZDRIejI1UU5OMHgxWHNreHdBNG1ycVJxVmh0?=
 =?utf-8?B?QUhlQzk2V1VzaklVcjJXRTZLYVRVZ0lPbTQwREh3c0FUOEtIVnBLaDFzVWVB?=
 =?utf-8?B?Mnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <631D9EBD502EFC40AFACCB0A19CA6362@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6479.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e7e347a-38fc-4e26-b676-08da5a821af0
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 10:20:07.0265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8Ysyi/i8vw0oFed//FAiaauDU06X/DJgjknxaWWu08BpEoKGaFqOizmBkSVg+pGkzdPEsmeQR+M63yefKuQjjJPivy9g5v9ZDMADuFFCDyE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4475
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNi8zMC8yMiAxMjoyMywgVHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tIHdyb3RlOg0KPiBF
WFRFUk5BTCBFTUFJTDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5s
ZXNzIHlvdSBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIDYvMzAvMjIgMDg6MjAs
IFBldGVyIFJvc2luIHdyb3RlOg0KPj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5r
cyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZl
DQo+Pg0KPj4gSGkhDQo+IA0KPiBIaSwgUGV0ZXIhDQo+Pg0KPj4gMjAyMi0wNi0yNyBhdCAxODo1
MywgVHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4+IE9uIDYvMjcvMjIgMTU6
MjYsIFR1ZG9yLkFtYmFydXNAbWljcm9jaGlwLmNvbSB3cm90ZToNCj4+Pj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+Pj4+DQo+Pj4+IE9uIDYvMjEvMjIgMTM6NDYsIFBldGVy
IFJvc2luIHdyb3RlOg0KPj4+Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBv
ciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+
Pj4+Pg0KPj4+Pj4gMjAyMi0wNi0yMCBhdCAxNjoyMiwgVHVkb3IuQW1iYXJ1c0BtaWNyb2NoaXAu
Y29tIHdyb3RlOg0KPj4+Pj4+DQo+Pj4+Pj4+DQo+Pj4+Pj4+IGdpdEBnaXRodWIuY29tOmFtYmFy
dXMvbGludXgtMGRheS5naXQsIGJyYW5jaCBkbWEtcmVncmVzc2lvbi1oZG1hYy12NS4xOC1yYzct
NHRoLWF0dGVtcHQNCj4+Pj4+Pj4NCj4+Pj4+Pg0KPj4+Pj4+IEhpLCBQZXRlciwNCj4+Pj4+Pg0K
Pj4+Pj4+IEkndmUganVzdCBmb3JjZWQgcHVzaGVkIG9uIHRoaXMgYnJhbmNoLCBJIGhhZCBhIHR5
cG8gc29tZXdoZXJlIGFuZCB3aXRoIHRoYXQgZml4ZWQgSSBjb3VsZA0KPj4+Pj4+IG5vIGxvbmdl
ciByZXByb2R1Y2UgdGhlIGJ1Zy4gVGVzdGVkIGZvciB+MjAgbWludXRlcy4gV291bGQgeW91IHBs
ZWFzZSB0ZXN0IGxhc3QgMyBwYXRjaGVzDQo+Pj4+Pj4gYW5kIHRlbGwgbWUgaWYgeW91IGNhbiBz
dGlsbCByZXByb2R1Y2UgdGhlIGJ1Zz8NCj4+Pj4+DQo+Pj4+PiBIaSENCj4+Pj4+DQo+Pj4+PiBJ
IHJlYmFzZWQgeW91ciBwYXRjaGVzIG9udG8gbXkgY3VycmVudCBicmFuY2ggd2hpY2ggaXMgdjUu
MTguMiBwbHVzIGEgZmV3IHVucmVsYXRlZA0KPj4+Pj4gY2hhbmdlcyAoYXQgbGVhc3QgdGhleSBh
cmUgdW5yZWxhdGVkIGFmdGVyIHJlbW92aW5nIHRoZSBwcmV2aW91cyB3b3JrYXJvdW5kIHRvIGRp
c2FibGUNCj4+Pj4+IG5hbmQtZG1hIGVudGlyZWx5KS4NCj4+Pj4+DQo+Pj4+PiBUaGUgdW5yZWxh
dGVkIHBhdGNoZXMgYXJlIHR3byBiYWNrcG9ydHMgc28gdGhhdCBkcml2ZXJzIHJlY29nbml6ZSBu
ZXcgY29tcGF0aWJsZXMgWzFdWzJdLA0KPj4+Pj4gd2hpY2ggc2hvdWxkIGJlIGNvbXBsZXRlbHkg
aGFybWxlc3MsIHBsdXMgYSBjb3VwbGUgb2YgcHJvcG9zZWQgZml4ZXMgdGhhdCBoYXBwZW5zIHRv
IGZpeA0KPj4+Pj4gZWVwcm9tIGlzc3VlcyB3aXRoIHRoZSBhdDkxIEkyQyBkcml2ZXIgZnJvbSBD
b2RyaW4gQ2l1Ym90YXJpdSBbM10uDQo+Pj4+Pg0KPj4+Pj4gT24gdGhhdCBrZXJuZWwsIEkgY2Fu
IHN0aWxsIHJlcHJvZHVjZS4gSXQgc2VlbXMgYSBiaXQgaGFyZGVyIHRvIHJlcHJvZHVjZSB0aGUg
cHJvYmxlbSBub3cNCj4+Pj4+IHRob3VnaC4gSWYgdGhlIHN5c3RlbSBpcyBvdGhlcndpc2UgaWRs
ZSwgdGhlIHNoYTI1NnN1bSB0ZXN0IGRpZCBub3QgcmVwcm9kdWNlIGluIGEgcnVuIG9mDQo+Pj4+
PiAxNTArIGF0dGVtcHRzLCBidXQgaWYgSSBsZXQgdGhlICJyZWFsIiBhcHBsaWNhdGlvbiBydW4g
d2hpbGUgSSBkbyB0aGUgdGVzdCwgSSBnZXQgYSBmYWlsdXJlIHJhdGUNCj4+Pj4+IG9mIGFib3V0
IDEwJSwgc2VlIGJlbG93LiBUaGUgcmVhbCBhcHBsaWNhdGlvbiBidXJucyBzb21lIENQVSAoYnV0
IG5vdCBhbGwgb2YgaXQpIGFuZA0KPj4+Pj4gY29tbXVuaWNhdGVzIHdpdGggSFcgdXNpbmcgSTJD
LCBuYXRpdmUgVUFSVHMgYW5kIHR3byBvZiB0aGUgZm91ciBVU0Itc2VyaWFsIHBvcnRzDQo+Pj4+
PiAoRlRESSwgd2l0aCB0aGUgbGF0ZW5jeSBzZXQgdG8gMW1zIGFzIG1lbnRpb25lZCBlYXJsaWVy
KSwgc28gSSBndWVzcyB0aGVyZSBpcyBtb3JlIERNQQ0KPj4+Pj4gcHJlc3N1cmUgb3Igc29tZXRo
aW5nPyBUaGVyZSBpcyBhIDEwMG1icHMgbmV0d29yayBjb25uZWN0aW9uLCBidXQgaXQgd2FzIGxl
ZnQgImlkbGUiDQo+Pj4+PiBkdXJpbmcgdGhpcyB0ZXN0Lg0KPj4+Pj4NCj4+Pj4NCj4+Pj4gVGhh
bmtzLCBQZXRlci4NCj4+Pj4gSSBnb3QgYmFjayB0byB0aGUgb2ZmaWNlLCBJJ20gcmVjaGVja2lu
ZyB3aGF0IGNvdWxkIGdvIHdyb25nLg0KPj4+Pg0KPj4+DQo+Pj4gSGksIFBldGVyLA0KPj4+DQo+
Pj4gV291bGQgeW91IHBsZWFzZSBoZWxwIG1lIHdpdGggYW5vdGhlciByb3VuZCBvZiB0ZXN0aW5n
PyBJIGhhdmUgZGlmZmljdWx0aWVzDQo+Pj4gaW4gcmVwcm9kdWNpbmcgdGhlIGJ1ZyBhbmQgbWF5
YmUgeW91IGNhbiBzcGVlZCB1cCB0aGUgcHJvY2VzcyB3aGlsZSBJIGNvcHkNCj4+PiB5b3VyIHRl
c3Rpbmcgc2V0dXAuIEkgbWFkZSB0d28gbW9yZSBwYXRjaGVzIG9uIHRvcCBvZiB0aGUgc2FtZSBi
cmFuY2ggWzFdLg0KPj4+IE15IGFzc3VtcHRpb24gaXMgdGhhdCB0aGUgbGFzdCBwcm9ibGVtIHRo
YXQgeW91IHNhdyBpcyB0aGF0IGEgdHJhbnNmZXINCj4+PiBjb3VsZCBiZSBzdGFydGVkIG11bHRp
cGxlIHRpbWVzLiBJIHRoaW5rIHRoZXNlIGFyZSB0aGUgbGFzdCBsZXNzIGludmFzaXZlDQo+Pj4g
Y2hhbmdlcyB0aGF0IEkgdHJ5LCBJJ2xsIGhhdmUgdG8gcmV3cml0ZSB0aGUgbG9naWMgYW55d2F5
Lg0KPj4+DQo+Pj4gVGhhbmtzIQ0KPj4+DQo+Pj4gWzFdIFRvIGdpdGh1Yi5jb206YW1iYXJ1cy9s
aW51eC0wZGF5LmdpdA0KPj4+ICAgIGNiYjJkZGNhNDYxOC4uNzljNzc4NGRiY2YyICBkbWEtcmVn
cmVzc2lvbi1oZG1hYy12NS4xOC1yYzctNHRoLWF0dGVtcHQgLT4gZG1hLXJlZ3Jlc3Npb24taGRt
YWMtdjUuMTgtcmM3LTR0aC1hdHRlbXB0DQo+Pg0KPj4gSSB3YXMgb3V0IG9mIG9mZmljZSwgYnV0
IEkgbWFuYWdlZCB0byBnZXQgYSB0ZXN0IHJ1bm5pbmcgb3ZlciBuaWdodCBhbmQgY2FuDQo+PiBy
ZXBvcnQgdGhhdCBJdCBzdGlsbCBmYWlscy4gVGhpcyBpcyBhIGxvbmdlciBydW4gb2YgYWJvdXQg
NTAwIHdpdGggYSBmYWlsdXJlDQo+PiByYXRlIG9mIDUlIGNvbXBhcmVkIHRvIHRoZSBsYXN0IHRp
bWUgd2hlbiB0aGUgZmFpbHVyZSByYXRlIHdhcyAxMCUuIEkgdGVuZA0KPiANCj4gVGhhbmtzIQ0K
PiANCj4+IHRvIHRoaW5rIHRoYXQgdGhlIG9ic2VydmVkIGRpZmZlcmVuY2UgaW4gZmFpbHVyZSBy
YXRlIG1heSB3ZWxsIGJlIHN0YXRpc3RpY2FsDQo+PiBub2lzZSwgYnV0IHdobyBrbm93cz8gV291
bGQgaXQgYmUgdXNlZnVsIHdpdGggYSBsb25nZXIgcnVuIHdpdGhvdXQgdGhlIGxhc3QNCj4+IHR3
byBwYXRjaGVzIHRvIHNlZSBpZiB0aGV5IG1ha2UgYSBkaWZmZXJlbmNlPw0KDQpJIGZvcmdvdCB0
byBhbnN3ZXIsIHNvcnJ5LiBObywgbm90IG5lZWRlZCBhcyBpdCBzdGlsbCBmYWlscy4NCj4gDQo+
IEkgcHVzaGVkIGFub3RoZXIgcGF0Y2ggd2VyZSBJIGFkZGVkIGEgd3JpdGUgbWVtIGJhcnJpZXIg
dG8gbWFrZSBzdXJlIGV2ZXJ5dGhpbmcNCj4gaXMgaW4gcGxhY2UgYmVmb3JlIHN0YXJ0aW5nIHRo
ZSB0cmFuc2Zlci4gQ291bGQgeW91IGFsc28gdGFrZSB0aGUgbGFzdCBwYXRjaA0KPiBhbmQgcmUt
dGVzdCBpZiBpdCdzIG5vdCB0b28gY29tcGxpY2F0ZWQ/IEkgc3RpbGwgY2FuJ3QgcmVwcm9kdWNl
IGl0IG9uIG15IHNpZGUsDQo+IEknbSBjaGVja2luZyB3aGF0IGVsc2UgSSBjYW4gYWRkIHRvIHN0
cmVzcyB0ZXN0IHRoZSBETUEuDQoNCkkgY291bGQgcmVwcm9kdWNlIHRoZSBidWcgZXZlbiB3aXRo
IHRoZSB3bWIoKS4gSSdtIHJlY2hlY2tpbmcgd2hhdCBJIG1pc3NlZC4NCg0KQ2hlZXJzLA0KdGEN
Cg==
