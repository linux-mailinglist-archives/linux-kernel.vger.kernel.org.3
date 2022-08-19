Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11406599D29
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 15:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349419AbiHSNtD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 09:49:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348496AbiHSNtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 09:49:00 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0812D6CD2D;
        Fri, 19 Aug 2022 06:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660916940; x=1692452940;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eX13IveaO1cJXXg16frAzo7IM82DUsZHJHoDUjrSnls=;
  b=gq907Nx5y6zLeKCzsGHPaSXWndP5J4PGu1psijEQDhZDp7q05KEuWp6Z
   koaHC+DzNmappqhFncEVSaqSVYsNVUqVdByW4eM3x3R9BugZGUXqai6Wc
   tdW/ru8eTyzUJLUB0Mr3FtBXmNjDwHxu8OVZ+lbSUZoVZWdZueI+tmv+7
   /3KCxqqXciv7MemHiqinBn1FpJdxt6bHP3EABXGuTUcfRq5+vtIwpXhig
   NqG6ffz7lCpw3MXL89LejJ7txz/8rBlwmakn0Uh19AIEwJtINsA1tsWEW
   FDKeso1hKqK00uJyJaM9B43d6FxeTl+Dp71OMYl/sDTHXQWqVuVThs1KJ
   g==;
X-IronPort-AV: E=Sophos;i="5.93,248,1654585200"; 
   d="scan'208";a="170041312"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Aug 2022 06:48:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Fri, 19 Aug 2022 06:48:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12 via Frontend Transport; Fri, 19 Aug 2022 06:48:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2heJbS+fc14eNZ48pfNLhMHHtVyOB6j9+E6EHInBBHS5LhoPv8g5Ql4CRJpSWxpDs/3BMUKHfqeDyDfbtN2RnonbefcC6CJng9sFEZSmM6iC3D0AqpoKDTOShu1Syw3iYPfaM3qzSToaZzLg3Wo/HJvnT4xqL46xzSw/gIMvKeERPpI9GOijmkPKK88LgyuH9cEPpGnWlnHPKi026ovhftyxDTUOCNAl0Jbe0iUyeIbmcJDql8mRh3mZ8yQ8o6+DDncfTZYrcNlFajeGI68oDrjhF6WJE/OJDF/5shzbcVLbG+5IdXPG5zuFV71RtnkruQbOfksGWlKrQLhUaCdGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eX13IveaO1cJXXg16frAzo7IM82DUsZHJHoDUjrSnls=;
 b=jz9f1ApclYnPMqrZSHR1S0X7PZEj6Lx78KamA14yHLbtInmpp/0KA4fmLGz53pSbQrGq+FHUL7MN1YAA3lT3Yw7rfOXB+4KOCgzqsouKHrgXsV2bBfZKvBF6LSIokeQFYd0jFCH6l5YwShsHajcGhV11/slSXugZphK+8Ef5rh0652uKseGwSrjsANAfQnArAWISdWpM8eBsaFdJE9F5RKYoK5Bju6y2Tn8YQpS1fgkng90khm+nKMCGVpC5qGQi7j4I++zAAJaGzDHpKqbAk4x6uXwXOpYR+9dWpr6OpDt+17PZMD7U/0D+YYaYP2uVVB0vjCcztd7CTv17fEYI0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eX13IveaO1cJXXg16frAzo7IM82DUsZHJHoDUjrSnls=;
 b=gQHv4mHUT7tKvi7AJ1DchfA/sKggabJi9pu4rkcd8tZTlZT33BPVF1DMfRx0boDiWud+VRuEcAV0m6Pf9ygPh5Z/L1JYzu8o1idc8zXeYEYYkv7Pqc0YoxXPDV3vRNfEUEBBX8+ClarrZ/VGTfV1luwGqINfHm7IMwFFr+qdkzI=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM5PR11MB1593.namprd11.prod.outlook.com (2603:10b6:4:6::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5525.11; Fri, 19 Aug 2022 13:48:48 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5546.018; Fri, 19 Aug 2022
 13:48:47 +0000
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
Thread-Index: AQHYs8dCZDCkQVxYIEq9YtBMJX9yKK22LDYAgAAHm4CAAAPOAIAABY6A
Date:   Fri, 19 Aug 2022 13:48:47 +0000
Message-ID: <19ca2ca1-c678-c669-4214-e92416e37191@microchip.com>
References: <20220819122259.183600-1-conor.dooley@microchip.com>
 <20220819122259.183600-7-conor.dooley@microchip.com>
 <3df8d4bd-3d38-cecd-6589-ccc1be01b886@linaro.org>
 <3ffba600-bda9-8ffa-a435-9a6f94e072b8@microchip.com>
 <f3d8be5c-737b-8c71-9926-a4036c797769@linaro.org>
In-Reply-To: <f3d8be5c-737b-8c71-9926-a4036c797769@linaro.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02a50869-38bd-40f1-9f1b-08da81e98a90
x-ms-traffictypediagnostic: DM5PR11MB1593:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B0iWaZHM1fUJH8Wijb0shh5O6hbLh6U6G4bcFVKxQsNLgG7LmNZWVqey9A10YnHMpGW/sxq/fr9qoSJT4GT9FT3CN7FVO6YXDPo44cxt4Y/cmH0r5DGyOt+SiYZ9type2AlAHKfasu0UDV2WtsOACT3Edf1FzB3TmvNVpKogEkxyu+Pwu1KR5hEel7YPfpr4d4q7qkRK3+sSzNLgUe7GHks2obhYEO74K/qpZ0/aEwuFt6IBX+eZBuguV1K0cGEpfUoWzIpU9/MDRBusfgQP3evddhEaH7cugSE6lSZ05lxYf9PBAxeD/dK2YQ7rzZtQFu1pfPwasp6eTJFi5N11dGjiilGkHRZnD0YGgSP/Nfx9YddEgbfYVZ0kHSw2isnn4OiG2b/rzcbBknUoRr75mdX77kQ2a5/xvAj3ANO5RL5sgK8YOLsE3RvfSYEvrLMqlVgdmpiWa//c8vcyFU1Ak/qClYf7xer9PGdNN2M1CUVRZZ6r97mtoyuJzTzGHFGTFDgEZXJfY/D/4RYX5ueAJxU6bthdWCqdXp3BkCTBhj/hcdAtBtVyv5f5j2JskcqUQHpPzfzqRGqoZRmO/7Y4uBQY0wIJ5RaKaE+ci1rXRQ2lOEhVlz3TXVBtsMDGPpEujXEZZcYKbe0OiDVHQ5JHtWkOHWLPy/OwPhsSAmiEeZvPjZjnjr3vbIbuKcQmhJozyW3xPCS0Mvf3RhCfGLvDo+eiHp9XXlaVHpEHvukoXgPvnfnz8V6qPif7C85RRPirJYn6Eco/i0uXAsswzN5f1rELb3roMJyL+nEQt5I3M0JQ4AnIK0gVSg9FYQzgBHcfWYUvQxs99FDhbvR0Y0PHiw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(396003)(366004)(346002)(136003)(39860400002)(8676002)(6506007)(7416002)(66946007)(36756003)(31686004)(83380400001)(38070700005)(53546011)(6636002)(110136005)(54906003)(26005)(478600001)(6512007)(41300700001)(186003)(316002)(2616005)(64756008)(6486002)(122000001)(2906002)(86362001)(31696002)(38100700002)(76116006)(4326008)(66556008)(66476007)(91956017)(5660300002)(66446008)(71200400001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?enQ1R3N4czZ4MTRQRXJ5ZFRyMENpL2ptbThZMlNjdDlxb28xc1h5NERjTTFR?=
 =?utf-8?B?aWJ3YThtTFV3aW92a2xuZVk1VkZtR3E3OEtLZG95OEJSdzFHWGVkdEpKcEI4?=
 =?utf-8?B?N1dZUzJUbVBZYU5ZNGMvZ1c5TnBHSnoxYmRxbnFieTRCYzJ0U3B4TGlqdWNR?=
 =?utf-8?B?c2hIN1A4N1pSSDY4eVNRR0Z3MGdGekNaL1dIbDFwd2tOMUVPY2Zka2ExUTEz?=
 =?utf-8?B?WVRDZllSY2hXc0JDYmc0RXhvaWg0cHZrOFk4WUlrWXlmci9heTBKUmE2Njlm?=
 =?utf-8?B?Z25yU2JsWkkzMzRIR2VzMHIzdHdicm9zclNzNGZqcDBJZ0w5emRCZklDMkI3?=
 =?utf-8?B?L2RhY1ZqbTJjblNmeHdZK2UwYWxHc2xlbFNpbVc3WUNVQmlKYUdCbUNCRmhh?=
 =?utf-8?B?OHBmVWQ3WE5Pa1RDTlQrVzQ5R2pwaVFsd0ZUYVBPMFpKK1dER0kzaVM4M3Ry?=
 =?utf-8?B?YzdtQ0x5VENMSHROOWxmZ2ZJSkJST3VSNitKMzNVZXhOeXltWmlYS2FmbC80?=
 =?utf-8?B?V0gxNFNaS0hNekt3RW5leEVmMDNKV0JJR3d2aGJEME9tamVnQnp3V2dpdzZL?=
 =?utf-8?B?c2Vlc2Zpems1Y3BKMlF4dTZ3ZFgraWUxWUNwektJT1J1VkVRWi8zazZKUzh1?=
 =?utf-8?B?b1I0T1libTBGanN2NEM5NUl6eFhjSjUxZnlsUENHQUtrZlFLc3B5cDZhYUdP?=
 =?utf-8?B?UWpKNHdCMlNBQTlVUDAxS3MydTV1WlFQMzdYRXRKa1c4NlZoRmVrVy9Hcm9k?=
 =?utf-8?B?WGZUNW03WnFuMWpWaHl5cGZnRHlubDJaVDQ5ODRINnlTaHZ5Yy9VY2docXY5?=
 =?utf-8?B?L0xETGR6MXFaMlRLUXhvV2xLTUFPU2drTVRsT08zOHF5bVZMNzNOemhScytv?=
 =?utf-8?B?V2EzQktnSTdrMVBkTDl3VnhyanNYOGpCRjloelYxdWJGc2xGKzNkMXF2c1Uy?=
 =?utf-8?B?eTYweEZHLzBDRzQxekh3SmVlNGJ3cjl1eU0vbmora3VCZmwxNEx0YTM1SXlo?=
 =?utf-8?B?SjI1enl0TmVsWDVuL3l5dTdHaXZFcThiV2hBTThQOGdpKzYvSWJPWGxCalhl?=
 =?utf-8?B?WjFMMzlxSGpMaVpJVjVYU1dFYnFyeUpzb3Q4eDNjMC9BaHFwMGUrUGt6enQ3?=
 =?utf-8?B?QzVMTTZlVXdsQjd0ZnplMWdKeEcvVDh2MWE4MVVEL3NjMzhnMEEra0JLWjNs?=
 =?utf-8?B?YnFWanpTNUEyYUFDSVBxdTk0M2dLVHZxYk9yNzF5MndJcldibmlzT2tZUUZj?=
 =?utf-8?B?SlAySnVVSVVncGRSWEI5djZjdHNHdXczMCtwK2kwYUFoTFhBeGV3MS9IdTI4?=
 =?utf-8?B?SHFYVjhEYlZMVHBqYkNsUksxMWM1MU82dTlmc09WVDk1Tkx1UE5YazJWVVh2?=
 =?utf-8?B?czBxZ2tmNWJVU2pMeGcveWJYR3JNZ1FNOUhSOU9EbUpqU2N3djhnbEdzRzFs?=
 =?utf-8?B?R1BJWElWQmpDZVMzVWpIVXNvY2dJenRxbzhwSFhDVENOSDk5NFVrTmlJZ1VH?=
 =?utf-8?B?ekJjLzlUNHVObkRpOVdUd3dhVE1HamVsamhUMHdHTkhPTFpyck1RcWx0NWxt?=
 =?utf-8?B?NWhWQTg1bHhwZDA0eWRxOElic3hpUlNNWmRkVFBtZmd1NlNqL0t0Zllkc01m?=
 =?utf-8?B?OHpnTkFvRTlPeGZTWHBGQU41a2xabHFnUGpuRWtiOFkxRUZIek40SnBXdzBi?=
 =?utf-8?B?NVl0UkJMdUYzV0hxNlIrZDRrcnM1UkpmTk5yZlFZU1JCTEwrYTBaRDlDL01K?=
 =?utf-8?B?b0lMZGFUK3ZWYWtmeW1aK0NOeFp5TDlkWHRiUlVSWHl5bDhRY0JndXBpOFgw?=
 =?utf-8?B?VCtYT3BzZy8wZXVnRFBGbDZPWkJwQ0JJNWlLS2hVVHFCM25FYzc2Z3A5OEdZ?=
 =?utf-8?B?NjBrSGJ2ZmtFWmNZenAyNlEyMnNUdjFTMUN3OCszTXl3NWtjRUkxUE1LS0xD?=
 =?utf-8?B?RDRXa2ZDMG5La0YveCtjZmFlc05kNG52UmwxL3pjbk05TjNPcTlxRVg1SnpB?=
 =?utf-8?B?QWVSVWVsaWl6d29TVXorRFBqK2V6VHBtUkoyTWdlZEtPNDIxZEFkOHMzWERZ?=
 =?utf-8?B?NUEwVzU5cVJmSytDVSt0aUk1M2dvZmxHYXBuRk81T2czdFFsZUxEcmhycHo4?=
 =?utf-8?Q?rNdxHXrtgVuU1cWOk/Mw8ulx6?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2A9684803885345AEA81C6C7292E86E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a50869-38bd-40f1-9f1b-08da81e98a90
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2022 13:48:47.8287
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gybpEwJ5w0a8tFtFW22kRKjbGrInDaQv4kIg1sq76tssgX74SoQvpjS8OWT97odWch/OHImZOxdQPyYiQ072G58ApX8WZ+s1KaeowwCnF1M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1593
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTkvMDgvMjAyMiAxNDoyOCwgS3J6eXN6dG9mIEtvemxvd3NraSB3cm90ZToNCj4+IE1heWJl
IHRoYXQgaXMgbWUgZXhwbG9pdGluZyB0aGUgInNob3VsZCIsIGJ1dCBJIHdhcyBub3Qgc3VyZSBo
b3cgdG8NCj4+IGluY2x1ZGUgdGhlIGxvY2F0aW9uIGluIHRoZSBkZXZpY2V0cmVlLg0KPiANCj4g
TmVpdGhlciBub2RlIG5hbWVzIG5vciBjbG9jayBuYW1lcyBhcmUgY29uc2lkZXJlZCBhbiBBQkks
IGJ1dCBzb21lDQo+IHBpZWNlcyBsaWtlIHRvIHJlbHkgb24gdGhlbS4gTm93IHlvdSBjcmVhdGVk
IHN1Y2ggZGVwZW5kZW5jeSBzbyBpbWFnaW5lDQo+IHNvbWVvbmUgcHJlcGFyZXMgYSBEVFNJL0RU
UyB3aXRoICJjbG9jay1jb250cm9sbGVyIiBuYW1lcyBmb3IgYWxsIGZvdXINCj4gYmxvY2tzLiBI
b3cgeW91IGRyaXZlciB3b3VsZCBiZWhhdmU/DQoNCi1FRVhJU1QsIHJlZ2lzdHJhdGlvbiBmYWls
cyBpbiB0aGUgY29yZS4NCg0KPiBUaGUgRFRTIHdvdWxkIGJlIHBlcmZlY3RseSB2YWxpZCBidXQg
ZHJpdmVyIHdvdWxkIG5vdCBhY2NlcHQgaXQNCj4gKGNvbmZsaWN0aW5nIG5hbWVzKSBvciBiZWhh
dmUgaW5jb3JyZWN0Lg0KPiANCj4gSSB0aGluayB3aGF0IHlvdSBuZWVkIGlzIHRoZSBjbG9jay1v
dXRwdXQtbmFtZXMgcHJvcGVydHkuIFRoZSBjb3JlDQo+IHNjaGVtYSBkdHNjaGVtYS9zY2hlbWFz
L2Nsb2NrL2Nsb2NrLnlhbWwgcmVjb21tZW5kcyB1bmlmaWVkDQo+IGludGVycHJldGF0aW9uIG9m
IGl0IC0gbGlzdCBvZiBuYW1lcyBmb3IgYWxsIHRoZSBjbG9ja3MgLSBidXQgYWNjZXB0cw0KPiBv
dGhlciB1c2VzLCBlLmcuIGFzIGEgcHJlZml4Lg0KDQpTbyBjb3VsZCBJIGRvIGBjbG9jay1vdXRw
dXQtbmFtZXMgPSAiY2NjX253IjtgLiBUaGF0IHdvdWxkIHdvcmsgZm9yIG1lLA0Kd2l0aCBvbmUg
cXVlc3Rpb246DQpIb3cgd291bGQgSSBlbmZvcmNlIHRoZSB1bmlxdWUtbmVzcyBvZiB0aGlzIHBy
b3BlcnR5LCBzaW5jZSBpdCB3b3VsZCBiZQ0KYSBwZXIgQ0NDL2Nsb2NrLWNvbnRyb2xsZXIgcHJv
cGVydHk/IE1heWJlIEkgbWlzc2VkIHNvbWV0aGluZywgYnV0IEkNCmdhdmUgaXQgYSBzaG90IHdp
dGggdHdvIGRpZmZlcmVudCBDQ0Mgbm9kZXMgaGF2aW5nICJjY2NfbnciICYgZHRic19jaGVjaw0K
ZGlkIG5vdCBjb21wbGFpbi4gVXAgdG8gbWUgdG8gZXhwbGFpbiB0aGUgcmVzdHJpY3Rpb24gaW4g
dGhlIGR0LWJpbmRpbmdzDQpkZXNjcmlwdGlvbj8NCg0KRldJVyBJIHdvdWxkIHRoZW4gaGF2ZToN
CmNjY19zdzogY2xvY2stY29udHJvbGxlckAzODQwMDAwMCB7DQoJY29tcGF0aWJsZSA9ICJtaWNy
b2NoaXAsbXBmcy1jY2MiOw0KCXJlZyA9IDwweDAgMHgzODQwMDAwMCAweDAgMHgxMDAwPiwgPDB4
MCAweDM4ODAwMDAwIDB4MCAweDEwMDA+LA0KCSAgICAgIDwweDAgMHgzOTQwMDAwMCAweDAgMHgx
MDAwPiwgPDB4MCAweDM5ODAwMDAwIDB4MCAweDEwMDA+Ow0KCSNjbG9jay1jZWxscyA9IDwxPjsN
CgljbG9jay1vdXRwdXQtbmFtZXMgPSAiY2NjX3N3IjsNCglzdGF0dXMgPSAiZGlzYWJsZWQiOw0K
fTsNCg0KJiBpbiB0aGUgYmluZGluZzoNCiAgIGNsb2NrLW91dHB1dC1uYW1lczoNCiAgICAgcGF0
dGVybjogXmNjY19bbnNdW2V3XSQNCg0KQXMgYWx3YXlzLCB0aGFua3MgZm9yIHlvdXIgaGVscC4g
SSBkaWQgbG9vayBhdCBvdXRwdXQgbmFtZXMgZWFybGllciBpbg0KdGhlIHByb2Nlc3MsIGJ1dCBk
aWRuJ3QgcmVhbGlzZSBJIGNvdWxkIHVzZSBpdCBhcyBhIHByZWZpeC4NCkNvbm9yLg0KDQo=
