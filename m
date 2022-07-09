Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D84856CAC5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 18:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbiGIQ43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 12:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbiGIQ40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 12:56:26 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39871705B;
        Sat,  9 Jul 2022 09:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657385783; x=1688921783;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5jZJW1DvobdHoaO/QlhpH0+MCCICjte5GplwqoqvYCg=;
  b=qtEIxrL5zVI/+NkZjAWxmN/2k4kgaLGx49HnU9oPwE2XzLq4jd9sZvqk
   TTevK173+am+Wys5ZI3lgFyHcqUQkOejnEY4DukgE0YKfvkLFO0I7EVKU
   aHD4kmjQ5rtA5t2v77YGMh9keNm+XClxPDnIjKdUhZ5Tt8b8gpTPZrrX2
   KJNWsrnXb42hDbVTSoxYTWiWaJDTESrBpDv9g110iQKVNjuVbKtllWxvD
   xgfsK4in2vFroulrp4QnSh2YRJwfK5pKTal7Aq2AdatkOROopD6LVKdDG
   81lxhKT+4TCvBwdirggQLIN/rrvW53FyZTH7Ajh5sSguUus+bG8t4h1Dd
   A==;
X-IronPort-AV: E=Sophos;i="5.92,259,1650956400"; 
   d="scan'208";a="181464584"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jul 2022 09:56:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sat, 9 Jul 2022 09:56:22 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Sat, 9 Jul 2022 09:56:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRNKdsVxBAwMvOcnphWNXTjCrJf5xY5zBLPqvw638ScZWZJ0VY86rkqDv3mg/RUN7OFZyXG6XQ1O0lT1GaxFRfVfdg+I3grZijzCUM+29wGLOISp+L2dUKKFjeORoPIyZinHeclsCexXOciSOUhWHbztkPczeUtJljMGGmYMdCKND0yVnc9HwZrvw6aphMBn/r9YkqDajMC65Q9AnTijBRQ/wjMCfiFgjdsS6Z7fxPZ9Ind27zClcdYNYt1gwB+tb6kYDPajknmtoxO4LwkgZ5wRVbAo5wDTVeP/xrZFRWSlzxYOSdB4F44nhI7p4BaydIq82ZOlcbYylh1VBGimZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5jZJW1DvobdHoaO/QlhpH0+MCCICjte5GplwqoqvYCg=;
 b=KjJ9JXz6DWDHnm7ZirYnSpFPfr/Lho36IjN+dLgSDrCR1ffL+TEoFzpUUNxKX0kj80Id9wlhYVyMCk7Lc05jun/xdtuRMm7dBP4QPZTLM7i/KVdn+TlTFl7R9XvwKw/XHnSNcz4wyApK3TuKUcDkHzfKHDgtaJalnxpnG3knr4NkE9w+onCQdKewtzlYT1kwCRK+spJNCB9GSCXfB+ghEwvSO60GqDCWgR+dgFXK3+GO5SVjpga1ubhG32YpOHsYN9g2KL5S+pg3io/HSQhRO/BrV5kJYcuVfTlcY6IiKdcdQcnh8vqC8N/nkjOexAwpcpnpc67cGUdqLVRU0LyNhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5jZJW1DvobdHoaO/QlhpH0+MCCICjte5GplwqoqvYCg=;
 b=N23xlEXf/0gRl3xfi4yQocNr6iVIQTvDkPFd732DIooK3U68KVVBwxNlVoZei3Ot268dsLAldBAwDzt/7e0suXLytPxgd2x9Q+82E1R68dLRXQg1W6c7h5VymIDGKRoG50ldxCsiBpD97QqV05MYtqqBVNg5CNj1Zi753RltjCA=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by BY5PR11MB4465.namprd11.prod.outlook.com (2603:10b6:a03:1c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Sat, 9 Jul
 2022 16:56:16 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::8d4a:1681:398d:9714%5]) with mapi id 15.20.5417.025; Sat, 9 Jul 2022
 16:56:16 +0000
From:   <Conor.Dooley@microchip.com>
To:     <u.kleine-koenig@pengutronix.de>, <Conor.Dooley@microchip.com>
CC:     <thierry.reding@gmail.com>, <lee.jones@linaro.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <Daire.McNamara@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v5 3/4] pwm: add microchip soft ip corePWM driver
Thread-Topic: [PATCH v5 3/4] pwm: add microchip soft ip corePWM driver
Thread-Index: AQHYktiKMJrSlPtjv0SK+U5DwIwspK12NMcAgAAFfoCAAASIAIAABRoA
Date:   Sat, 9 Jul 2022 16:56:16 +0000
Message-ID: <2d734171-2a8a-2f89-9435-09e39d55dba5@microchip.com>
References: <20220708143923.1129928-1-conor.dooley@microchip.com>
 <20220708143923.1129928-4-conor.dooley@microchip.com>
 <20220709160206.cw5luo7kxdshoiua@pengutronix.de>
 <f2720cc9-be02-f457-7e8e-0d6b3845477c@microchip.com>
 <20220709163758.nvsaf4jcwqenl2ax@pengutronix.de>
In-Reply-To: <20220709163758.nvsaf4jcwqenl2ax@pengutronix.de>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2d63b05-2a77-4a8a-cf83-08da61cbf01e
x-ms-traffictypediagnostic: BY5PR11MB4465:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4DY8/o6HD3hPNGHkCDjEDgOh15tvoMi8SA8+gMSN0tReHOcLnhxZIkTGmApG2vgmxvxJf1+Q1UoWogFqBdqlACRf+NlexqmfM7Bvl2z9TiFyoYkxnJchuLIZiFrCO8linBrQUPt7EmTdzKO+cUHl3ML9jW/wKS4TlWklThAthVQh7X5i7VBOXRjPkaBjDOOhfwmaH43h4K479WP5K89eIeU8FDvZRsBaqcvQ76coLnS7/1LqmnH+gOv4MIHOom2SafanN+LkkO5RaqboR4NQUyCUMUAgkjd+9QURF5envw0Y0Nykzz/64V+pIVhGA5QIy2FYKe2TcyR6AMf1gRK8AjelQBx4xWBh+xFn1v7v7jPEitGPYbtSOjTuGV0i2/RnOI0jnKl5OuGGWdCq8MLpoWm4EkVDGYVf+FUDcQk4KPiIxgbnhZTrqX9dHJAejfWvMMdN/p6jEISEMt8eBTiydWuALs4tdr5+ONoqfApB8SZLMwzG9IsBpj+5JrmWfQ1pRcpk2Z/oQMEWh4nr6XOCxieM5bc6Um8B6EOafmJ8Dl3HfW+uGnue3Mn8W5tTeWiJMXAJudsB/YrIxNUKVIuXpR7OntWWrUswIDqrzFNbOrdDXrmU0oBEw+7Qxfkhr5r/PZSy1I6SNZpCspqolwtBGy1Mtg6JzICGpCCe/eUeJYCIdxAST/Kh3nJxXdOxpghEo32YvL/p7rlFmY27l+UEKL+WI9f2ufy13k8SQvhRqAxmC+isRDCIXhfWapRPohXlM1oHFZPlAs3sAfq0iIZ3AbdC5tre4Pw/7r7VI56JAeqilWTbaShQHHfTW0kaxmQx62e8lsihR3SLZZKuGbnNvEm27oK0QqwphsVSrzQZJy1tr4XzUh23XmuNlaavamJZ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(39850400004)(136003)(396003)(346002)(376002)(64756008)(4326008)(71200400001)(66556008)(66446008)(31696002)(66476007)(6486002)(38070700005)(53546011)(41300700001)(8936002)(478600001)(26005)(6506007)(2906002)(8676002)(86362001)(38100700002)(6512007)(83380400001)(66946007)(122000001)(5660300002)(54906003)(66574015)(186003)(316002)(2616005)(110136005)(91956017)(76116006)(31686004)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?akdqWkxDNkUyTlFyMnZuYlBRZWNkOEowcmpKNVhkTHlXWDNOeklMckNjVmNj?=
 =?utf-8?B?VzNxMUJpbThoK3Jwdkh0UGU4Vis5RXN3aFdMSE9DSURGY05nWmdMMlBDSXNY?=
 =?utf-8?B?OGVpWHZEamdteGdDNTVtSjRzSjN0eGVFL2YrOUYwcEFqRlB4a1YwRWZqaHQ3?=
 =?utf-8?B?NXFLSkZXd0tPWlo4TWprRk4yaFY2bnBmbmNtNzdVMXhUdkpKa2tHVU1rUXZG?=
 =?utf-8?B?VENvaExpUWE0enRyRzRrelY4UHRzWllHVmZUWFlBalBicU4rcUVINDJmK3Nu?=
 =?utf-8?B?NE9OMWV0TEhMNG5PMEFZTWFKRS9pbDJYbTVJRFk0azFBQWhMMzFlKzFyT085?=
 =?utf-8?B?RldERnhaUTk2NmlXNDdaajZzcDZqM2dpWkhLRXROMkIrNUFLUml4WHdsaVBQ?=
 =?utf-8?B?cEFqcHpiVWwwVWs2NzlqcEZCbU9JV0k0ZmNzWlJUUDBmKzdObkNXUmFIQ0JK?=
 =?utf-8?B?bUFQdjJsd2RBeWV2RFVBTGthMnBpbnJKWUM4QWtPSDBjeUdoRzdkdFlSRVo2?=
 =?utf-8?B?V1dXK2tGSG9rRU9tMnB0QmY0bnlZcThCRXp2WW44WDE0VGNMUU13RGpZOFBm?=
 =?utf-8?B?bERwWDNqRmlIYkplbll0ZGlwZ2wxcHpMaGVlRzlzeHhNREdhS2ZOTVJCdWxm?=
 =?utf-8?B?MlVKT3E3VzVRamt5bWtDYTdGWktVcDgwc1FWcmFJcm5BMHVJWWF3MmlxN1Fa?=
 =?utf-8?B?Tit1VFhGQTVKUk1WcVE0QmFhWlFkZHFqVm9paDJsajZUQ2lINTFXaVVJS0Zn?=
 =?utf-8?B?NVorcHkyVXVkdkQrRWV3WTVOZis0NWVJQXNybFdlTk1GSEcxWjJMNXozYzdw?=
 =?utf-8?B?NFFnKy9xTHQ0ZTlMYVN5K2Q0WG1TUjNvWC9xTDBRdzlQb3BlWmU2QUJzdUJh?=
 =?utf-8?B?aEcxSVFXNzd1WVNkdVhiQXZnOGQ0R0Jicmk5cUhYMzF4cjlvMWo5bTFBRCtx?=
 =?utf-8?B?ZVZBWmZBdXJTN01KSWIyR2ZydkxBRk8rVWtTbGpOcXRaM2hlSHNYMmllek05?=
 =?utf-8?B?d2ZxQVA3ZDBURlk5WmFWeDhybXArWFNIbWo1cHcwcmluSFJiYzFYUFdHVDZB?=
 =?utf-8?B?aXg1cjd5eGcwbHhqa0ExejIwdXhzNnA1a2N5YjBScnVEallSejFnNEgzWFpq?=
 =?utf-8?B?b0tIdURsZFlsL0d2Qm56aGJlUm9Sdk5hVFF4YjdTdzgvTDZSME5HYWh3alNU?=
 =?utf-8?B?VHZFd1RzK092UDBhT281MTFUN0c0M1NKc1Y3UHIwN0pncm5Qdkg5VmladXVk?=
 =?utf-8?B?TEJsTFUzeDlLQzVxQTBrOGhxdVRzTnVCNk1RTHBHNWVBSHJJQytyNDlyYkVX?=
 =?utf-8?B?MlhyMGhZU3hUNnI5QjFEaTE3cHU5cGc3a25NaTJjNVlIS3ZOQTBKM2VIVElK?=
 =?utf-8?B?cWYwZnB6TUZnWC9yUGkrRGpnYlpPMWx1VGxqbUN0WCs2NzVIVkkvTkkrSDZm?=
 =?utf-8?B?SU9aR25QcGRmMWthWk4wcmR0SUdtWEJSTkdacGI2SzNQWEFkYm5wcUNhK2JZ?=
 =?utf-8?B?WnlDb1BtYkpwMTlLbXdQNTVIYXpkenZrS0hreTU5b0VOQjZlWkhpcUdlSVVQ?=
 =?utf-8?B?dTgyMjMxMmpDaENJS2txNTZWR0R5K3lqWmZGbUJsSFVENXhqRmZpakxmNHc5?=
 =?utf-8?B?YTN2bWtidHIvVVhCTWhhY0VtVGJORFNqa1FYbzdYazdNWUoyTnhlNFB5bXFR?=
 =?utf-8?B?b3ZvZU9XVSs2S2R2MjJKVjE0MitQQXRCNnNmaDdHa3ZYa3NrdUhzRyt3VlNE?=
 =?utf-8?B?M1FBeUFjdFl0MTFmWU5jbEVxcmtDZzlLT2Z4TFhTUWIxblZmVG9DNEREbDF1?=
 =?utf-8?B?RlhqWWhOTEFMdVZITzgwdjh6VGZmZWVBbXdUZXI5S0puTmtKbyswQUVsTU9W?=
 =?utf-8?B?cXRwQ2NqUTBhZ29PL1B3RnpQUkdFeEVTeHlrLzk3U3VDOWdqR0I5L3JhMmUy?=
 =?utf-8?B?TGpJRFNGTi9oVFUyTWwxc1o3NGFIaHNvOFVqZG9nTHQ0bitLZmYvZkxUdzNj?=
 =?utf-8?B?d1RqaUo4eUNDR1FONnlpa1o5V3duN2FKRzlXWDVBUmtJcE1qVUZCNnQ4Ty9o?=
 =?utf-8?B?dno4a2ZYTTN5SjRwcDZQN2lBQ0thWGdXS29tZ2dHdEJPMmxjK1lDQVlQZHJz?=
 =?utf-8?Q?E5MnTIHCgOFIIkSTMiLMvZH84?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <860C50EB8D2A55458D090DEA8B7DCB0F@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d63b05-2a77-4a8a-cf83-08da61cbf01e
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2022 16:56:16.0528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yGz/Bo0q34e8lOR6I9q0JYi2elkd6iCtBuCrEi4XBA3rNcWmjAmLAgDmL+Qyvz/plGQ6/csrKDj5xGRgc0GQ7FRpaIA7GtwUfjsclfKqxJE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4465
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDA5LzA3LzIwMjIgMTc6MzcsIFV3ZSBLbGVpbmUtS8O2bmlnIHdyb3RlOg0KPiBIZWxs
byBDb25vciwNCj4gDQo+IE9uIFNhdCwgSnVsIDA5LCAyMDIyIGF0IDA0OjIxOjQ2UE0gKzAwMDAs
IENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gMDkvMDcvMjAyMiAxNzow
MiwgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6DQo+Pj4gT24gRnJpLCBKdWwgMDgsIDIwMjIgYXQg
MDM6Mzk6MjJQTSArMDEwMCwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPj4+PiBBZGQgYSBkcml2ZXIg
dGhhdCBzdXBwb3J0cyB0aGUgTWljcm9jaGlwIEZQR0EgInNvZnQiIFBXTSBJUCBjb3JlLg0KPj4+
Pg0KPj4+PiBTaWduZWQtb2ZmLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNyb2No
aXAuY29tPg0KPj4gLS0tODwtLS0NCj4+Pj4gKwltY2hwX2NvcmVfcHdtX2FwcGx5X2R1dHkoY2hp
cCwgcHdtLCBzdGF0ZSwgcHJlc2NhbGUsIHBlcmlvZF9zdGVwcyk7DQo+Pj4+ICsNCj4+Pj4gKwkv
Kg0KPj4+PiArCSAqIE5vdGlmeSB0aGUgYmxvY2sgdG8gdXBkYXRlIHRoZSB3YXZlZm9ybSBmcm9t
IHRoZSBzaGFkb3cgcmVnaXN0ZXJzLg0KPj4+PiArCSAqIFRoZSB1cGRhdGVkIHZhbHVlcyB3aWxs
IG5vdCBhcHBlYXIgb24gdGhlIGJ1cyB1bnRpbCB0aGV5IGhhdmUgYmVlbg0KPj4+PiArCSAqIGFw
cGxpZWQgdG8gdGhlIHdhdmVmb3JtIGF0IHRoZSBiZWdpbm5pbmcgb2YgdGhlIG5leHQgcGVyaW9k
LiBXZSBtdXN0DQo+Pj4+ICsJICogd3JpdGUgdGhlc2UgcmVnaXN0ZXJzIGFuZCB3YWl0IGZvciB0
aGVtIHRvIGJlIGFwcGxpZWQgYmVmb3JlIGNhbGxpbmcNCj4+Pj4gKwkgKiBlbmFibGUoKS4NCj4+
Pj4gKwkgKi8NCj4+Pj4gKwlpZiAobWNocF9jb3JlX3B3bS0+c3luY191cGRhdGVfbWFzayAmICgx
IDw8IHB3bS0+aHdwd20pKSB7DQo+Pj4+ICsJCXdyaXRlbF9yZWxheGVkKDFVLCBtY2hwX2NvcmVf
cHdtLT5iYXNlICsgTUNIUENPUkVQV01fU1lOQ19VUEQpOw0KPj4+PiArCQl1c2xlZXBfcmFuZ2Uo
c3RhdGUtPnBlcmlvZCwgc3RhdGUtPnBlcmlvZCAqIDIpOw0KPj4+PiArCX0NCj4+Pj4gKw0KPj4+
PiArCXNwaW5fdW5sb2NrKCZtY2hwX2NvcmVfcHdtLT5sb2NrKTsNCj4+Pj4gKw0KPj4+PiArCW1j
aHBfY29yZV9wd21fZW5hYmxlKGNoaXAsIHB3bSwgdHJ1ZSk7DQo+Pj4NCj4+PiBJIGFscmVhZHkg
YXNrZWQgaW4gdGhlIGxhc3Qgcm91bmQ6IERvIHlvdSByZWFsbHkgbmVlZCB0byB3cml0ZSB0aGUN
Cj4+PiBTWU5DX1VQRCByZWdpc3RlciB0d2ljZT8gSSB3b3VsZCBleHBlY3QgdGhhdCB5b3UgZG9u
J3Q/IQ0KPj4NCj4+IFNvcnJ5LCBJIHRob3VnaHQgdGhhdCBJIGhhZCByZXBsaWVkIHRvIHRoaXMg
b24gRnJpZGF5LCBkaWRuJ3QNCj4+IG1lYW50IHRvIGlnbm9yZSB5b3UuDQo+Pg0KPj4gWWVzLCBJ
IGRvIG5lZWQgdG8ga2VlcCB0aGF0IC0gb3RoZXJ3aXNlIHRoZXJlIGFyZSBwcm9ibGVtcyB3aGVu
DQo+PiB0dXJuaW5nIG9uIHRoZSBQV00gY2hhbm5lbCBmb3IgdGhlIGZpcnN0IHRpbWUuDQo+IA0K
PiBIb3cgdW5pbnR1aXRpdmUgYW5kIHVuZm9ydHVuYXRlLiBJIHdvbmRlciBpZiB0aGVyZSBpcyBh
biB1cHNpZGUgb2YgdGhpcw0KPiBhcHByb2FjaCB0aGF0IEknbSBtaXNzaW5nLg0KDQpTaW1wbGlj
aXR5IG9mIHRoZSBzeXRoZXNpc2VkIGRlc2lnbiBtYXliZT8NCkdpdmVuIG9uZSBvZiB0aGUgdGhp
bmdzIHRoZSBtYW51YWwgdGFsa3MgYWJvdXQgaXMgdGhlIExVVCBzYXZpbmdzIGJ5DQp0dXJuaW5n
IG9mZiBzaGFkb3dpbmcgaXQgd291bGQgbm90IHN1cnByaXNlIG1lLg0KDQo+IA0KPj4gQmVmb3Jl
IHdyaXRpbmcgdG8gdGhlIGVuYWJsZSByZWdpc3RlcnMsIHdlIG5lZWQgdG8gbWFrZSBzdXJlIHRo
YXQNCj4+IHRoZSB2YWx1ZXMgaGF2ZSBiZWVuIGFwcGxpZWQgc2luY2UgYm90aCBwb3MgYW5kIG5l
ZyBlZGdlIHJlZ2lzdGVycw0KPj4gY29tZSBvdXQgb2YgcmVzZXQgc2V0IHRvIDB4MC4NCj4gDQo+
IEkgYWx3YXlzIGxpa2UgdG8gdW5kZXJzdGFuZCB0aGUgaGFyZHdhcmUsIGNhbiB5b3UgZXhwbGFp
biB0aGUgcHJvYmxlbXMNCj4gaW4gbW9yZSBkZXRhaWxzPw0KDQpUaGUgVExEUiBpcyBpZiBJIGRv
bid0LCB0aGUgY2hhbm5lbCBnZXRzIGVuYWJsZWQgdy8gdGhlIDUwJSBkdXR5IGN5Y2xlDQpwcm9i
bGVtLiBGcm9tIGdsYW5jaW5nIGF0IHRoZSBSVEwgdGhlIG90aGVyIGRheSwgaXQgbG9va3MgbGlr
ZSBpdCBpcw0KZG93biB0byB0aGUgaG93IHRoZSBpZiBzdGF0ZW1lbnQgdGhhdCBkZWNpZGVzIHRo
ZSBvdXRwdXQgbGV2ZWwgaXMNCm9yZGVyZWQuDQoNCkRlcGVuZGluZyBvbiBob3cgYm9yZWQgSSBn
ZXQgdG9uaWdodC90b21vcnJvdywgSSdsbCBnaXZlIHlvdSBhIGJldHRlcg0KYW5zd2VyIHRoZW4g
b3IgZHVyaW5nIHRoZSB3ZWVrLg0KDQo+IA0KPj4+IEFsc28gdGhlIGxvY2tpbmcgbG9va3MgZmlz
aHkgaGVyZS4gSXQgd291bGQgYmUgc2ltcGxlciAoYW5kIG1heWJlIGV2ZW4NCj4+PiBtb3JlIHJv
YnVzdCwgZGlkbid0IHRoaW5rIGRlZXBseSBhYm91dCBpdCkgdG8gYXNzdW1lIGluDQo+Pj4gbWNo
cF9jb3JlX3B3bV9lbmFibGUoKSB0aGF0IHRoZSBjYWxsZXIgaG9sZHMgdGhlIGxvY2suIFRoZW4g
eW91IG9ubHkNCj4+PiBncmFiIHRoZSBsb2NrIG9uY2UgZHVyaW5nIC5hcHBseSgpIGFuZCBub3Ro
aW5nIHN0cmFuZ2UgY2FuIGhhcHBlbiBpbiB0aGUNCj4+PiBnYXAuDQo+Pj4NCj4+Pj4gKwlyZXR1
cm4gMDsNCj4+Pj4gK30NCj4+Pj4gKw0KPj4+PiArc3RhdGljIHZvaWQgbWNocF9jb3JlX3B3bV9n
ZXRfc3RhdGUoc3RydWN0IHB3bV9jaGlwICpjaGlwLCBzdHJ1Y3QgcHdtX2RldmljZSAqcHdtLA0K
Pj4+PiArCQkJCSAgICBzdHJ1Y3QgcHdtX3N0YXRlICpzdGF0ZSkNCj4+Pj4gK3sNCj4+Pj4gKwlz
dHJ1Y3QgbWNocF9jb3JlX3B3bV9jaGlwICptY2hwX2NvcmVfcHdtID0gdG9fbWNocF9jb3JlX3B3
bShjaGlwKTsNCj4+Pj4gKwl1OCBwcmVzY2FsZSwgcGVyaW9kX3N0ZXBzLCBkdXR5X3N0ZXBzOw0K
Pj4+PiArCXU4IHBvc2VkZ2UsIG5lZ2VkZ2U7DQo+Pj4+ICsJdTE2IGNoYW5uZWxfZW5hYmxlZDsN
Cj4+Pj4gKw0KPj4+DQo+Pj4gSSdkIHRha2UgdGhlIGxvY2sgaGVyZSB0byBiZSBzdXJlIHRvIGdl
dCBhIGNvbnNpc3RlbnQgcmV0dXJuIHZhbHVlLg0KPj4+DQo+Pj4+ICsJY2hhbm5lbF9lbmFibGVk
ID0gKCgodTE2KXJlYWRiX3JlbGF4ZWQobWNocF9jb3JlX3B3bS0+YmFzZSArIE1DSFBDT1JFUFdN
X0VOKDEpKSA8PCA4KSB8DQo+Pj4+ICsJCXJlYWRiX3JlbGF4ZWQobWNocF9jb3JlX3B3bS0+YmFz
ZSArIE1DSFBDT1JFUFdNX0VOKDApKSk7DQo+Pj4NCj4+PiBtaWNybyBvcHRpbWlzYXRpb246IFlv
dSdyZSByZWFkaW5nIHR3byByZWdpc3RlciB2YWx1ZXMgaGVyZSwgYnV0IG9ubHkgdXNlDQo+Pj4g
b25lLiBTaGFkb3dpbmcgdGhlIGVuYWJsZWQgcmVnaXN0ZXJzIGluIG1jaHBfY29yZV9wd20gbWln
aHQgYWxzbyBiZSBhbg0KPj4+IGlkZWEuDQo+Pj4NCj4+Pj4gKwlpZiAoY2hhbm5lbF9lbmFibGVk
ICYgMSA8PCBwd20tPmh3cHdtKQ0KPj4+DQo+Pj4gSSdtIGFsd2F5cyB1bnN1cmUgYWJvdXQgdGhl
IGFzc29jaWF0aXZpdHkgb2YgJiBhbmQgPDwsIHNvIEkgd291bGQgaGF2ZQ0KPj4+IHdyaXR0ZW4g
dGhhdCBhcw0KPj4+DQo+Pj4gCWlmIChjaGFubmVsX2VuYWJsZWQgJiAoMSA8PCBwd20tPmh3cHdt
KSkNCj4+Pg0KPj4+IEkganVzdCB0ZXN0ZWQgdGhhdCBmb3IgdGhlIHVtcHRlZW5zIHRpbWUgYW5k
IHlvdXIgY29kZSBpcyBmaW5lLCBzbyB0aGlzDQo+Pj4gaXMgb25seSBmb3IgaHVtYW4gcmVhZGVy
cyBsaWtlIG1lLg0KPj4+DQo+Pj4+ICsJCXN0YXRlLT5lbmFibGVkID0gdHJ1ZTsNCj4+Pj4gKwll
bHNlDQo+Pj4+ICsJCXN0YXRlLT5lbmFibGVkID0gZmFsc2U7DQo+Pj4+ICsNCj4+Pj4gKwlwcmVz
Y2FsZSA9IFBSRUdfVE9fVkFMKHJlYWRiX3JlbGF4ZWQobWNocF9jb3JlX3B3bS0+YmFzZSArIE1D
SFBDT1JFUFdNX1BSRVNDQUxFKSk7DQo+Pj4+ICsNCj4+Pj4gKwlwb3NlZGdlID0gcmVhZGJfcmVs
YXhlZChtY2hwX2NvcmVfcHdtLT5iYXNlICsgTUNIUENPUkVQV01fUE9TRURHRShwd20tPmh3cHdt
KSk7DQo+Pj4+ICsJbmVnZWRnZSA9IHJlYWRiX3JlbGF4ZWQobWNocF9jb3JlX3B3bS0+YmFzZSAr
IE1DSFBDT1JFUFdNX05FR0VER0UocHdtLT5od3B3bSkpOw0KPj4+PiArDQo+Pj4+ICsJZHV0eV9z
dGVwcyA9IGFicygoczE2KXBvc2VkZ2UgLSAoczE2KW5lZ2VkZ2UpOw0KPj4+DQo+Pj4gSWYgZHV0
eV9zdGVwcyA9PSAwIHRoZSByZXR1cm5lZCByZXN1bHQgaXMgd3JvbmcuIEkgc3VnZ2VzdCB0byBm
aXggdGhhdCwNCj4+PiBhdCBsZWFzdCBtZW50aW9uIHRoZSBwcm9ibGVtIGluIGEgY29tbWVudC4N
Cj4+DQo+PiBBaCByaWdodCB5ZWFoLCBJIGRpZG4ndCB1cGRhdGUgdGhpcyBhZnRlciBjaGFuZ2lu
ZyB0aGUgb3RoZXIgbG9naWMuIFNvcnJ5Lg0KPj4NCj4+Pg0KPj4+PiArCXN0YXRlLT5kdXR5X2N5
Y2xlID0gZHV0eV9zdGVwcyAqIHByZXNjYWxlICogTlNFQ19QRVJfU0VDOw0KPj4+DQo+Pj4gQ2Fu
IHRoaXMgb3ZlcmZsb3c/DQo+Pj4NCj4+Pj4gKwlkb19kaXYoc3RhdGUtPmR1dHlfY3ljbGUsIGNs
a19nZXRfcmF0ZShtY2hwX2NvcmVfcHdtLT5jbGspKTsNCj4+Pg0KPj4+IFdoYXQgaXMgdGhlIHR5
cGljYWwgcmV0dXJuIHZhbHVlIG9mIGNsa19nZXRfcmF0ZShtY2hwX2NvcmVfcHdtLT5jbGspPw0K
Pj4NCj4+IEl0J3MgZ29ubmEgYmUgbGVzcyB0aGFuIDYwME0NCj4gDQo+IEFuIGV4YWN0IHZhbHVl
IHdvdWxkIGJlIGludGVyZXN0aW5nLCB0aGVuIHdoZW4gSSBzcG90IGEgcm91bmRpbmcgcHJvYmxl
bQ0KPiBJIGNvdWxkIGdpdmUgeW91IGEgdGVzdCBjYXNlIHRvIGRvdWJsZSBjaGVjay4NCg0KWWVh
aCwgSSBhbSBub3Qgc3VyZSB3aGF0IHRoZSBtYXhpbXVtIGNsb2NrIHJhdGVzIGFsbG93ZWQgaW4g
dGhlIEZQR0EgZmFicmljDQphcmUgb2ZmIHRoZSB0b3Agb2YgbXkgaGVhZC4gNjAwIE0gd2FzIGEg
c2FuZSBsaW1pdCBiL2MgdGhhdCdzIHdoYXQgdGhlIGNvcmUNCmNvbXBsZXggcnVucyBhdC4gU2Fp
ZCBpdCBtb3JlIHRvIHNheSB0aGF0IGl0IHdvdWxkbid0IGJlID5OU19QRVJfU0VDDQoNCj4+PiBZ
b3UgbmVlZCB0byByb3VuZCB1cCBoZXJlLiBEaWQgeW91IHRlc3QgeW91ciBkcml2ZXIgd2l0aCBQ
V01fREVCVUcgb24/DQo+Pj4gRHVyaW5nIHRlc3QgcGxlYXNlIGRvIGZvciBhIGZldyBmaXhlZCBw
ZXJpb2RzOg0KPj4+DQo+Pj4gCWZvciBkdXR5X2N5Y2xlIGluIFswIC4uIHBlcmlvZF06DQo+Pj4g
CQlwd21fYXBwbHkobXlwd20sIHsucGVyaW9kID0gcGVyaW9kLCAuZHV0eV9jeWNsZSA9IGR1dHlf
Y3ljbGUsIC5lbmFibGVkID0gdHJ1ZSwgLi4ufSkNCj4+Pg0KPj4+IAlmb3IgZHV0eV9jeWNsZSBp
biBbcGVyaW9kIC4uIDBdOg0KPj4+IAkJcHdtX2FwcGx5KG15cHdtLCB7LnBlcmlvZCA9IHBlcmlv
ZCwgLmR1dHlfY3ljbGUgPSBkdXR5X2N5Y2xlLCAuZW5hYmxlZCA9IHRydWUsIC4uLn0pDQo+Pj4N
Cj4+PiBhbmQgY2hlY2sgdGhlcmUgaXMgbm8gb3V0cHV0IGNsYWltaW5nIGEgbWlzY2FsY3VsYXRp
b24uDQo+Pg0KPj4gSSByYW4gdGhlIHN0dWZmIHlvdSBnYXZlIG1lIGxhc3QgdGltZSwgZG9pbmcg
c29tZXRoaW5nIHNpbWlsYXIgdy8gYQ0KPj4gc2hlbGwgbG9vcC4gR290IG5vIHJlcG9ydGVkIG1p
c2NhbGN1bGF0aW9ucy4NCj4gDQo+IEknbSBzdXJwcmlzZSwgSSB3b3VsZCBoYXZlIGV4cGVjdGVk
IHRoYXQgbXkgdGVzdCByZWNpcGUgd291bGQgZmluZCBzdWNoDQo+IGFuIGlzc3VlLiBDb3VsZCB5
b3UgZm9sbG93IG15IGFyZ3VpbmcgYWJvdXQgdGhlIHJvdW5kaW5nIGRpcmVjdGlvbj8NCj4gVGhl
cmUgYWx3YXlzIHRoZSBwb3NzaWJpbGl0eSB0aGF0IEknbSB3cm9uZywgdG9vLg0KDQpJJ2xsIHRh
a2UgYW5vdGhlciBsb29rICYgZ2V0IGJhY2sgdG8geW91Lg0KVGhhbmtzIGZvciB0aGUgcmV2aWV3
Lg0KQ29ub3IuDQoNCg==
