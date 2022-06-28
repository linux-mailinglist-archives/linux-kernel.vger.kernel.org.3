Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D1C55E505
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346641AbiF1NiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiF1NiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:38:17 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C2C825E9B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656423496; x=1687959496;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Acay1bB90FDMIxeZQGBfgnwmctqjxa1cceZW5My1Sss=;
  b=dyWEAx527EbpmEGDyr/YZ7B+NLAKyhx0IrLXrJ34C3C7YHlZzzPsgziy
   kb06JhHUB0D09Y4FT0Tbjc146v6oA/cHJX8O3L4vtYbJw5LnckzSt+c5N
   0fwln0OUShXaO4nzB9ihb7cnxnR7Yo4rqHjKDOZHsxEOGriRwDxuC18QB
   NrzC/pVV2A30PihsBBM4P1979zgCkHv044QJpZDzWQvuad9ZFDN5c/WIl
   gmSAGbepmnkTsGKpNJnDaDfXxQJSUGnrOv7cUKbeOYzSibGV9S/tNRbX6
   YfSZ0m0Er5GSBxns1h1QaYSAuxAtijMPylY6DrBZ658imJ5tK1hTl3JGl
   A==;
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="165447350"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 28 Jun 2022 06:38:15 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 28 Jun 2022 06:38:14 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Tue, 28 Jun 2022 06:38:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StDIslUNSFitySpWjBNhKxSDyY2nPqTqkAmIhSopcchlJANt447NdtepcvwzuWn7nGZd7GPsTfMur3MEyKp417uPXEl9GOoOptrXf1uXIPDcj8EhMjSxd7MJ0eMXnUS9aPsnUvwLaeOQ3T6oxlVJBNsHrpIgBaObEh+Dc10Ux7Ds4SI/j7xjbBKiC4gn6W4hrulG8hm+QY0YcFzGhFaAQaGuXCHAZi93HLyrPT9DdhOHLuBeUcLsXUeXnG4SEG7BYiyK66QIGg6n1vqGNUNJHAw3xiyemxjOTiaee2AO+h6w9Dr3wqxn/CfOyoJtbf5+OiA+ntRS0P+DmJlxv9jD8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Acay1bB90FDMIxeZQGBfgnwmctqjxa1cceZW5My1Sss=;
 b=RXa7bXqpNdrBzUqMeV+bbQnkBimk5u/c028zxzP2lo0+UZ0cNK3OCGqzGwWlhlvH2FPaBav7w3N/0vC95SUyllfsJM0jq2WFQd2k4qGuzOBOitIXeMnpdq86jMsWB6q6SzW4/wUtJweWNDun1r0DZcfYFpZ965Co5Wk0lBssg1+VIKJkCAQg7AG+ybyEb50i+gUUb25KVNjm90t2W73JfprgHTmBCGIOGrjZEJfU7iqDTk3x39KjKY9AtkAPkI3XbsqMXrTgp9vKgnf7BfrBOqmY4JB15kD4+wWLfGiGxnliUt+G23HAWT3787YAlL1odxCYSPTOztqXZ/HcTHNq0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Acay1bB90FDMIxeZQGBfgnwmctqjxa1cceZW5My1Sss=;
 b=mIenK55LemgJtwT3i6dyKgmhljqHWfA/NiNNGPyjpXtdMCKM+fvgpIEycjPMmlDC492BcZocyI23lykA3HsvV2GHAd4TXy7e/6CCzZQBehqGd9LZutrde+xdTidZilUy0ReEI1AtbH2Q4/mjLgeo+nr0JQkxdLVnOtfwStPvf2k=
Received: from CY4PR11MB1960.namprd11.prod.outlook.com (2603:10b6:903:11d::21)
 by DM4PR11MB5391.namprd11.prod.outlook.com (2603:10b6:5:396::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Tue, 28 Jun
 2022 13:38:10 +0000
Received: from CY4PR11MB1960.namprd11.prod.outlook.com
 ([fe80::80c4:1a95:649d:2ee0]) by CY4PR11MB1960.namprd11.prod.outlook.com
 ([fe80::80c4:1a95:649d:2ee0%10]) with mapi id 15.20.5373.018; Tue, 28 Jun
 2022 13:38:10 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Mihai.Sain@microchip.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: at91: fix soc detection for SAM9X60 SiPs
Thread-Topic: [PATCH] ARM: at91: fix soc detection for SAM9X60 SiPs
Thread-Index: AQHYivROM7gCEj9G0ke/pj/GPYMtqg==
Date:   Tue, 28 Jun 2022 13:38:10 +0000
Message-ID: <0880f677-de84-3e58-5a0d-285e38537023@microchip.com>
References: <20220616081344.1978664-1-claudiu.beznea@microchip.com>
In-Reply-To: <20220616081344.1978664-1-claudiu.beznea@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53908e78-0ae5-4f1a-2702-08da590b70f7
x-ms-traffictypediagnostic: DM4PR11MB5391:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IyaXESwRUp9VaHVchqUSQ6ZfTw85/RFTcUjrIBn5s/7SzIHIYTLZoxZCSRncIxRfb5cgxvrIO8Udb0bARr0KriR12U8zorma7wQD7rs9uCddOal2+p+aME+g1BcuJsdBH1ytPXLLNk/7KSXGtMqjrb0PFPEnkw4Ryaz1IVQTyDQqrsQi0gLQnyL5mMvCUmm06OBGULCTrKps4vlK7eySxIDNcPICCn9UudMgLbqqVDQhseklAdo5vKu3m8KLCJMlwlLhfU8MtUJu271yxYSfCUg542775XYz5ImgQOzeS+Zve9pX89aICFZtTAA4rB1I86O4k3Gzk9WwICflCUg2YsgIMRmarv8zUWXnrCJ+1Jk1sy5Ni09KYDI+UZU5hvddd2x13Mzdw6y8BNFAZJBZfRZChL65LDXyzSNQRBMLNCF9K/ARcAE5KuRQUAwjwI/yvAWZdEeFa5xxi+i3/LwHc+E0c4mae4Sw3rX4N68JqEdMTAQRTuu7NA/t5/17Gtg49bNUAvimw4HiW+7szjziKpApS4dw9GwO4Zubt9CqmhaiPFX/YI3Db+bV+VJhwxdqPN7I/TmVG9vve7yg4+C8jW7QeyFd4blO+gsaQ/f4W9Uk72mycYIx39wvaz1yZ9O1rdX0Y0Qm4XAG6sPPXf7IbA3P4rCsX+Qwq2e8NcQP06f+ociS5LlvazgGUiX4dWX06yBbs0wM2ifvn0IQvHwqcZdk3aysSdcwqFBoAMLhd3lAyf5wiqMlITP8sgbwDPhVxyFtcnHk04tNFTm1bz/oQf8/Xm8yLyAnl2OFplQF1A3PeZHj5TmZ0ntKi2MtOGHWrvHeebQY6gzfunV+SDKR+dwnhZTS7Hvs9NDOUtxECm4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1960.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(6029001)(39860400002)(136003)(346002)(376002)(366004)(396003)(6506007)(41300700001)(36756003)(122000001)(186003)(38070700005)(478600001)(26005)(86362001)(6512007)(5660300002)(31696002)(316002)(4326008)(8936002)(6636002)(54906003)(64756008)(2616005)(66556008)(83380400001)(71200400001)(2906002)(66476007)(66946007)(38100700002)(8676002)(76116006)(31686004)(110136005)(53546011)(91956017)(6486002)(66446008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Tm5Gem1LM0gyMldYZFpIUEljcFJrejE0alBPb3dyZnVwZkQzQkx5UGdOcVEx?=
 =?utf-8?B?UUk2L1ZFeFBWWWErZWNtR1hrL3lHVVlSMUlEVndmcjBrbCt3bEpzd3k0d3VQ?=
 =?utf-8?B?WFh5YkJkU214dU1NdjFIQ0psM2EyNUhUQUg3anNROE1OUjJRcEttUGVxS0JY?=
 =?utf-8?B?T05WMWVzOGlic3ZLVk5wQlNleUdxN0dwaFEyVmRnM0FTUDRmTmQ0V3RrMExY?=
 =?utf-8?B?dys3QkJ4blQzQmV0ZjFGVnRvbWJIbmdxT28vcVIrTFlUT1dKWjV3blhSd3Uy?=
 =?utf-8?B?Ynd5WWhaRS9UYlNtTjdBMnQvbGJyYllPQk9IbzA4Z1ZRQy9HbWJ2TklPQXpJ?=
 =?utf-8?B?djBQQ0N6L3B6SVUrT1VvQ3lNNStXYVI5QkdLaVQ5QXB5ZEQ3VzNZOEhsazcz?=
 =?utf-8?B?SW1QYUpSVGtGNDlWQVYwc1E2dEpneWpuVEUrZXkzSk5RQ0h6amFHYlplWDcx?=
 =?utf-8?B?N1ROaWMzNDc5NXRwS2pLa0dEeUcvc0swbWpXQkFLdkN3NzZTdWNQYml5allv?=
 =?utf-8?B?MmRQQTloU2hlZU1QRE0wTGRNUFVwby9jeTloRWwraEgySGVWWXI5RmlwZlhI?=
 =?utf-8?B?dzMwQ0VuMkRCdHk1aXh0bWI4UmNQWHRWZGU3K2Y2dTQweVgyLzBPa1ZkM3FU?=
 =?utf-8?B?elIrV3Q0YjFhcnR5eCtjUEZUQTJsdllkQlQvSVEzMkE3dWFlbG9LaFZGZ2d3?=
 =?utf-8?B?ZkQ5MU9oc2lDSXJqaExBVHp3NFhyWllUcWphWnZuUWpMV3pFbWFvVVZoeU9I?=
 =?utf-8?B?dEhMd1B5TWk4VkxsdGVJRkJkRklBN2lXb1NRTzJOemZVeWtBdzVrMkdoM3pQ?=
 =?utf-8?B?VGJhWlp5SWhNUHVKRC9VR1QwMnpKQXJJbmtTcnFjM21PZGZmMUhyLzUwVlFw?=
 =?utf-8?B?NmozK2prMVRxdzBXOHV4ZGFjanpTVFArOWJxRzB1eFowanNOODRGeWZ2R2NG?=
 =?utf-8?B?RG8xaG16eFIrN1RoRnJOOTVPY1dDRGJYeHlhR21sdFNoRjZrUTdrNmFaaVAz?=
 =?utf-8?B?aGNTTWlEbTExMFk5SVN4bnZKWGxJNC90bDF0R2swSHhPeCtKU0R2Qm8wK0lr?=
 =?utf-8?B?eEZocmJPK3hpdkRRRjVwSVBvWm5ZVlQ4ditqUHJhb0QxUEd0ZXc5OWtYVjMz?=
 =?utf-8?B?WGhaejRFcXBWQlRwNG1oVVl2Z3Ird3Q1dWhWREM0SHpKbmhNakdQVzdwcEJS?=
 =?utf-8?B?alRGVkJmUDBZWjM2cEVtNGJJdU9SemRVQk1WNy9mbndyVlBZczFaNUhnT1h2?=
 =?utf-8?B?dDRKZ3A4NENSbDFteDB5RDlwcEtDQlQ3eXBYdVJIczFVS0JVSkpjbDg1NDZk?=
 =?utf-8?B?Q3RmUzFDNVJUYmVvUFd0bUNYV1RqV0x6YVJYaXhtcjF4OVlwSk9lSHRRVDNj?=
 =?utf-8?B?NW01SmloR0hMTlR0eVl4LzJYbHlJTnVDMzRwTHhnTDlKc3JuQSt4dGhLVHdx?=
 =?utf-8?B?Z1psMGYyNkhYQlkzZFAwMGo3ZDdkNURoajhvUUF4QlR2L0JPYXJOYUVXSGJZ?=
 =?utf-8?B?aithOGpxa1J3R2FvZ1lXWjdLQXlPc3l4U1VsRVRGS3V3YXhMNHFCYXRFWnp3?=
 =?utf-8?B?SDB2Zjl0Vjc2NVljSU5MMlpxNkVvQXRDSFJUSlVYSUk2RnFwenBtQVhoWm9J?=
 =?utf-8?B?Z1hXQWNDTzV3MVZQYkFSdXVtSkZYblFDS3U4SkdnZFJrU1Z6TmJqeVZBNFlP?=
 =?utf-8?B?TW5GSENzZ0pXN2h1OEluYmtjRiswdXN0TzJSV0E1Q1E4di95S1pYblBJWTlm?=
 =?utf-8?B?VDl0S0RDNzRicUVCWHNVQm1MandmN28zKzc3MHZJZlVhYXVIbk1XV0ViZGRZ?=
 =?utf-8?B?SjYwcnh2QzZYM2x1U1VWdDJQZ01zWWIzVjVWczI0S0JtQ0M0SUxKeWxjdEF0?=
 =?utf-8?B?ZlVCLzlEaVQ0ci91U25Db1hkSXFsS2pJelYxYmh1WUlMWVlKdFNKM2hxb3Js?=
 =?utf-8?B?UHhBOE9XNS9ZamxzdnU5N3JEYlhaTWdJM0N2c1lhTXVOQURJUlNPc2xrZjlu?=
 =?utf-8?B?VEFKd1IwWUVha0ZqTjl1b0FPMHFFQW9LTUlDUG1raUl0aG5tYk9FQWYvTFhv?=
 =?utf-8?B?cEVHZ1grN2xBRjl5WVMyZi9kWTdlS3VXK3ZyY04wNmlTZXJuSzBPSHNRT1VB?=
 =?utf-8?B?dE54bndPRlJwTkh4cktHS0QyMkFLUlhxMndIbGQwY3dSUUVNZDVkSUFiWjRo?=
 =?utf-8?B?c3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <54D92F3F4836ED43A85277E931550722@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1960.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53908e78-0ae5-4f1a-2702-08da590b70f7
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2022 13:38:10.0479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SKgbNayQDqklf6c4DLFSC+LIbdasrPvUenbVZ0UUJ0N6oORuHqAIVx1CayPQApB4Fp9UvSkzW/629tuAEMgdtea3+eH7Xks7kGm//q6Liz8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5391
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYuMDYuMjAyMiAxMToxMywgQ2xhdWRpdSBCZXpuZWEgd3JvdGU6DQo+IEZyb206IE1paGFp
IFNhaW4gPG1paGFpLnNhaW5AbWljcm9jaGlwLmNvbT4NCj4gDQo+IEZpeCBTb0MgZGV0ZWN0aW9u
IGZvciBTQU05WDYwIFNpUHM6DQo+IFNBTTlYNjBENU0NCj4gU0FNOVg2MEQxRw0KPiBTQU05WDYw
RDZLDQo+IA0KPiBGaXhlczogYWYzYTEwNTEzY2Q2ICgiZHJpdmVyczogc29jOiBhdG1lbDogYWRk
IHBlciBzb2MgaWQgYW5kIHZlcnNpb24gbWF0Y2ggbWFza3MiKQ0KPiBTaWduZWQtb2ZmLWJ5OiBN
aWhhaSBTYWluIDxtaWhhaS5zYWluQG1pY3JvY2hpcC5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IENs
YXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KDQpBcHBsaWVkIHRv
IGF0OTEtZml4ZXMuIFRoYW5rcyENCg0KPiAtLS0NCj4gIGRyaXZlcnMvc29jL2F0bWVsL3NvYy5j
IHwgMTIgKysrKysrLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspLCA2
IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvc29jL2F0bWVsL3NvYy5j
IGIvZHJpdmVycy9zb2MvYXRtZWwvc29jLmMNCj4gaW5kZXggYjJkMzY1YWUwMjgyLi5kYWU4YTJl
MGY3NDUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvc29jL2F0bWVsL3NvYy5jDQo+ICsrKyBiL2Ry
aXZlcnMvc29jL2F0bWVsL3NvYy5jDQo+IEBAIC05MSwxNCArOTEsMTQgQEAgc3RhdGljIGNvbnN0
IHN0cnVjdCBhdDkxX3NvYyBzb2NzW10gX19pbml0Y29uc3QgPSB7DQo+ICAJQVQ5MV9TT0MoU0FN
OVg2MF9DSURSX01BVENILCBBVDkxX0NJRFJfTUFUQ0hfTUFTSywNCj4gIAkJIEFUOTFfQ0lEUl9W
RVJTSU9OX01BU0ssIFNBTTlYNjBfRVhJRF9NQVRDSCwNCj4gIAkJICJzYW05eDYwIiwgInNhbTl4
NjAiKSwNCj4gLQlBVDkxX1NPQyhTQU05WDYwX0NJRFJfTUFUQ0gsIFNBTTlYNjBfRDVNX0VYSURf
TUFUQ0gsDQo+IC0JCSBBVDkxX0NJRFJfVkVSU0lPTl9NQVNLLCBTQU05WDYwX0VYSURfTUFUQ0gs
DQo+ICsJQVQ5MV9TT0MoU0FNOVg2MF9DSURSX01BVENILCBBVDkxX0NJRFJfTUFUQ0hfTUFTSywN
Cj4gKwkJIEFUOTFfQ0lEUl9WRVJTSU9OX01BU0ssIFNBTTlYNjBfRDVNX0VYSURfTUFUQ0gsDQo+
ICAJCSAic2FtOXg2MCA2NE1pQiBERFIyIFNpUCIsICJzYW05eDYwIiksDQo+IC0JQVQ5MV9TT0Mo
U0FNOVg2MF9DSURSX01BVENILCBTQU05WDYwX0QxR19FWElEX01BVENILA0KPiAtCQkgQVQ5MV9D
SURSX1ZFUlNJT05fTUFTSywgU0FNOVg2MF9FWElEX01BVENILA0KPiArCUFUOTFfU09DKFNBTTlY
NjBfQ0lEUl9NQVRDSCwgQVQ5MV9DSURSX01BVENIX01BU0ssDQo+ICsJCSBBVDkxX0NJRFJfVkVS
U0lPTl9NQVNLLCBTQU05WDYwX0QxR19FWElEX01BVENILA0KPiAgCQkgInNhbTl4NjAgMTI4TWlC
IEREUjIgU2lQIiwgInNhbTl4NjAiKSwNCj4gLQlBVDkxX1NPQyhTQU05WDYwX0NJRFJfTUFUQ0gs
IFNBTTlYNjBfRDZLX0VYSURfTUFUQ0gsDQo+IC0JCSBBVDkxX0NJRFJfVkVSU0lPTl9NQVNLLCBT
QU05WDYwX0VYSURfTUFUQ0gsDQo+ICsJQVQ5MV9TT0MoU0FNOVg2MF9DSURSX01BVENILCBBVDkx
X0NJRFJfTUFUQ0hfTUFTSywNCj4gKwkJIEFUOTFfQ0lEUl9WRVJTSU9OX01BU0ssIFNBTTlYNjBf
RDZLX0VYSURfTUFUQ0gsDQo+ICAJCSAic2FtOXg2MCA4TWlCIFNEUkFNIFNpUCIsICJzYW05eDYw
IiksDQo+ICAjZW5kaWYNCj4gICNpZmRlZiBDT05GSUdfU09DX1NBTUE1DQoNCg==
