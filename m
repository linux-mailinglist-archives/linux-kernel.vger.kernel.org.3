Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74FCF4D005E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 14:46:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242923AbiCGNq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 08:46:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241358AbiCGNqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 08:46:55 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14ACB8BF77
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 05:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646660760; x=1678196760;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=/Q0vuBB691Vma08yqS6omjZ6pYs7AnBPTMS7e68uArg=;
  b=nG4NGg0Xb33P9rDnuouS6MbPMls5YfK42wRWXm2g2zQy+pkWqW+cG5Bh
   gR8zgDP0Y4RX/KBvYHBvgtyddfcov6GV8eK3eYi8D0wZcZF3YwCUkOkci
   90d4Alar/l8+YFTDkby9O2rpnnqRskdbRrXXDNP98iwYKOMQYD68f4gFA
   OL0BYHf4CjoJecmCoWSi9LtE7/PcVspqbPFZy57RMotGjXLssZJWmljlP
   Dv9gAnpJR2sa55Jdoc15VZlB5VVD3tp2DNqD1SDctNWm4guhbdAZvKqA4
   JRA3rk54S3eQvFg8nTm8x2vT/Ls4x48etQP3t6ddRB3h5EWAz8qeijiz+
   Q==;
X-IronPort-AV: E=Sophos;i="5.90,162,1643698800"; 
   d="scan'208";a="151097736"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2022 06:46:00 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 7 Mar 2022 06:46:00 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 7 Mar 2022 06:45:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TtgW3+tKqkB4j3/MuW+JSa4nxzwHiwQpJoNS2k4KRUODTvoshstGA6PAR99hf8DBTULdqdwhZ6FbK7I+eFbXT4jue0hLOfCmpanTk1vtNr1uo47OBimdcKAOZGFmA91JbUHMZ39GGkRQt2XmQaT2nFGqOgv0fbUWOUiNcyrfo/ALijnS9FxpsIJ9YYwl1ZWkfs9WxtTE0JFeGKg3z3/P06eRkEhwXHPSYqA+OW7ToQZiwaOJYQ4aNPdBTMk8koOlmviWefsPDSi5IOCXc1pFtvC55+ca6dEz/LE522YubPjW8tKp/V1wvDpm2tX5jSLoRYOU2tkAPh1zBPRumVJYag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Q0vuBB691Vma08yqS6omjZ6pYs7AnBPTMS7e68uArg=;
 b=hTccLOMFIIbR1/IlvG1tFSwvcuMcqF8aj2CimRqXduoCmiFizR3nm3ug/jB3s1T9mJYhb/iuAJfLubcNaDrij12A+0ELY+vs0gOVpwl4xqUnVYNw2fYU/LxadolPrJgk5xBUb5one97ZA+HB0tgmPgjhseMB6vKEIxEd1nCgmZyddK/NjAJXn5/zKKDYF53bYeQpQ5OLA0YiFuE5ZG/fe7XjLMKMcHxqJ6xD0DqsSz8trya+oPn2ijkVnG2UlB9pVMZrS/y35CAsoj6F+2f5sAgMQ8TvwHP8Oriiuw6gSQ0gU/18y9rQBzA+VaVXOTDbVfAWVoVvWLhLEJsqlj2AfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Q0vuBB691Vma08yqS6omjZ6pYs7AnBPTMS7e68uArg=;
 b=SIPRPonkppxOXGIPsQRt9i6vOKaddyNQiUnLgHJp5JN62lCnAlqopQMTDNnsLw07h7U7Q/VMkUqetoVOUPXzc2fYaRMVP8LAR8ub70n2xk8x5N8BSfV3rONi2PZWttgCBu7kZIOjYPa6+Ra4ju2p25scDtWe2Fa1ZXv1x55T5oM=
Received: from DM8PR11MB5687.namprd11.prod.outlook.com (2603:10b6:8:22::7) by
 DM8PR11MB5592.namprd11.prod.outlook.com (2603:10b6:8:35::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Mon, 7 Mar 2022 13:45:48 +0000
Received: from DM8PR11MB5687.namprd11.prod.outlook.com
 ([fe80::fc32:96a4:933f:194f]) by DM8PR11MB5687.namprd11.prod.outlook.com
 ([fe80::fc32:96a4:933f:194f%4]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 13:45:48 +0000
From:   <Codrin.Ciubotariu@microchip.com>
To:     <linmq006@gmail.com>, <lgirdwood@gmail.com>, <broonie@kernel.org>,
        <perex@perex.cz>, <tiwai@suse.com>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>,
        <florian.meier@koalo.de>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: atmel: Fix error handling in snd_proto_probe
Thread-Topic: [PATCH] ASoC: atmel: Fix error handling in snd_proto_probe
Thread-Index: AQHYMiP4bPe/zaBAxUSeZ+WVHeCX7ayz7wUA
Date:   Mon, 7 Mar 2022 13:45:48 +0000
Message-ID: <582c39ac-3099-d54f-5de3-d54a4ace0a04@microchip.com>
References: <20220307130415.5720-1-linmq006@gmail.com>
In-Reply-To: <20220307130415.5720-1-linmq006@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4a420c58-bd6a-430b-272d-08da0040c99b
x-ms-traffictypediagnostic: DM8PR11MB5592:EE_
x-microsoft-antispam-prvs: <DM8PR11MB5592A43B030E9EE5E4CD8270E7089@DM8PR11MB5592.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KmNgpxRX8zu8uogsVC/rDiKWavlhpbu557tRjQUiy6RCsbtTeq52IQnvRUG9G38GjEsB6hrmefTiaJi0mRQmaXwY3+UDUkgrCH5R3/soXBEf5Tc2lfjyGpuFYg0234ULvX/5y6OKMcDYDhqqpuQfH2E82KBtHHuWVc07BjeXBkVUrjCY47mE4IOytlNk8ROb8j8ha8NsI8qoW4oD7x7UxRByvXYy09BS637S3CQkoTdgol/TqIlg0ByYjMZh8+xgMs65QlybnsRaRtWBa7siYdCck2PaKmqLI78EBKgcDJvCRkNHll6q9d1IJtnE71oS7jaZiD4OYCRIhrwGITD/ng7lSRdtQ3avMAzw5L8Cwb/BIX2pdfe0cFeh0OuW9PLOZTTDWg96QQ8OjVviYZIRPpj6AxLE0cuXyU7rhhvv211lXV78z56D9RAPPCQ7T59cqIg2nG6xMonFNtbrKkHuo0T4fDXk7XLZrHRF+hCFqWTtY14kSf2sf49IdO3va9/l3EYgfc/mSOSc8Jzqy2aFu2/jAAZ6s40QCcNLw/GT5gbqowmXtlhkJD9eec2Z8E7zZUbPDSkc+BcIXHe/+PFelCWliSGrnqd40cFEgP381vuj1Ev71tGHY8PHW7Oi8hdXRdRgzRgNWzOqF9GJqbobq6nEeNtPZ+igG9Yp/JTTFBFHlSrnaHYcsnb0rxntW5NJHYzu2KWPgHxQjvzxgTWSoorwFG+u9hszRmrfUSaNMLdxnogI5XW8ep6oX+tcedc+e4g0goTcuYdWNL2p+/PAtKxdk81e0bbKR6YcqC/6cL4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR11MB5687.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(6506007)(186003)(26005)(6512007)(38100700002)(2906002)(36756003)(31686004)(4744005)(7416002)(2616005)(122000001)(921005)(8936002)(110136005)(76116006)(5660300002)(66446008)(64756008)(38070700005)(31696002)(86362001)(91956017)(508600001)(71200400001)(8676002)(66556008)(66946007)(66476007)(83380400001)(6486002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlNVRTZsTUYxcG9xSTYybExNeDVnejlpWUlJeTBuVEZabWhmZVBsbnZ6b1R3?=
 =?utf-8?B?VzFMU3MxSk92OGxMbzJqY0c3WldwcitHVS8zR256dHpYdUFNbkJvb2VnRE9T?=
 =?utf-8?B?TWliYmdwUDBmK2VlRmVIYUNWbGdlNzVxd3dtT2dvbEVCSkJrbWtNUTVnTGJx?=
 =?utf-8?B?OW95ZW16cFkwYTZIWW9udnNSdXE4WVhuR3pZcHFiK0trTFFoNnZiWlB2QWtB?=
 =?utf-8?B?SGdVR3ViYitWcXFDN0dWZFVhYnhiTTY1YVpGeHZtOUtHcDg3TTlJc2xJNkxy?=
 =?utf-8?B?MWJuWlhmK0xjY2M5YlZlM3hZVGUxMllUTktkQXp4MWRnY28ybzQ4TEpkR1hi?=
 =?utf-8?B?WXhqMElLM29LK3FyNUMyT1JLTmpSTHZhWW1yYlpETUpBbWZSaldiby96bnhX?=
 =?utf-8?B?Y09qRXE0Ly95d255bVlKNFN0WjhIdVdvbjFsQXZRQ3VQRDVVRVN4RmZYQnlK?=
 =?utf-8?B?dXdsb0FEWXgwcUIxM2FnbGE1SUFhNHJMUDMxMmZYZ1BRYnlrQzl5eTdIRVpT?=
 =?utf-8?B?MDg5U1p1QXNLdVdZK0M1cVZxb2NzbW5FY1NSSktMNzlqZHpUY2lORGJycGxv?=
 =?utf-8?B?Ky9HNTUvT1M0UHBjc0ZMRkw5Z3JBL3Z5S2dxSEZMQzFUV1MwdmJIMlp5WWZD?=
 =?utf-8?B?UkF1VTIrc1F2SXltNm1TOGQ0M1dPOGZBQThJT1JVa1krRWFEMTdYT3NSSEdn?=
 =?utf-8?B?NWpVcHkvejVMYkpjNThsTlc1bFcxc25KWWR6WmlZT1E5NWRVRUd1R05wcFZz?=
 =?utf-8?B?ZFhHVkpJaGVuQjVlR3FwcFVkei9kUThCdVRYWHF4VUxEa3M4UGNMc3dsdWho?=
 =?utf-8?B?alVBeHcyeEx2LzJWZ1dsb1o0QUVVZEJwSlBKemZYanR6QzBoZ1lMMFgwZUlG?=
 =?utf-8?B?SkJsN1pNZ05GcEl1ckVqNEJwdjZBZTBzdGJ2ajBPdStiZFFCS3V2NkhndXUz?=
 =?utf-8?B?VHlqbVp4dURtR3VMamFQMzlhcVc1WmFVL0RrWWNwVEhuNEsrZmRsWGdSOGdQ?=
 =?utf-8?B?SzNFeHBKL05vZGtmbXpTcU92NGpRMGJrWFMxRm1tY1FWeTJGK3BHR3c2aVZq?=
 =?utf-8?B?K09iamROeGNaUlczblFvU1U1eWQ1WEpUQzlpeUY2aElYT1NEL0UzR3BsVTNP?=
 =?utf-8?B?MWkvR2t3SXhxWWwxcUlteFBRdEt6NGlqWXllMDRENm9LNW5VZHlkZHl6Ni9z?=
 =?utf-8?B?THBJcGs4djZ3WmdMajFYaTV2eGZic1orWFg0T1FHQTJPcjVPT0lkV1VuQm9i?=
 =?utf-8?B?MlZ0ZzNyY2ZsWmRONWVVbDVJL2pQRW1FeTdJS0lVY3BkbmN1UG1UbUJUUWpB?=
 =?utf-8?B?aWRQWDFDcE9LeEgrNzRrNnNxNVI4S3ZrSVBLc2NRdDdhUlEyQjg4VStTNzQx?=
 =?utf-8?B?dVZWSDkvYWJ0Tk5hUlYyT2pQYlNPZ1RCZDZmcEhibVdMTUdsNm1XblZzTU0r?=
 =?utf-8?B?MHRqdFVrTjFINHVtcHByYys3RXptWlEvaHNGYXA4Q2NJVlltM2JEYWZCYlZS?=
 =?utf-8?B?ZGs3eUJXUnBtMCs3OWhZSVBkV3plT3Rhd2wybEdkWmVQdXgwMTRqcmFGK0Vj?=
 =?utf-8?B?b1BGTWNINWY1TGtRTjhpT3phYXh4dTJIajQwQWFxem5FbENyNnQ1eVJCSkUy?=
 =?utf-8?B?U21IcW1iNlZ4U3dqMThOaTQ4VjFRenoxQTJWeEw1V3hUQTdoazNlbHNZcGY2?=
 =?utf-8?B?SjVBVnJNdmdRdHRiNTN2ZHJ6Wi9GYm9EQmd5Q0NlekhsZHBwSnd6U0FHV3N1?=
 =?utf-8?B?WHFSR3VxWTd3a1BIWXJGT0t3UmNTV0d5cmlkd0lSL0c2c24wRTZlWFlnQjlr?=
 =?utf-8?B?OHFRaGpnK0ozM3VYNWNPckZjRlpzS1J6SVJ4VFJYUE1QQXVMUUNsVFRpL1Ni?=
 =?utf-8?B?am1lbDRKV0RyTHJ0VnQvbFpiay9MOVJ0U0lNOXEvWU9aS2JIR0RGWWpzVzE1?=
 =?utf-8?B?MGt0aVlINldWUmR1Y0xTSWl4NFdxMENnTmJkZ3Z3MFRJSk1aOWZIS2U2bkxq?=
 =?utf-8?B?MXprS3Z1L3c2L2JPcjBPNnFwbHZxWnFpdnMwd21WQjBOK2VENlVScHpQbHNF?=
 =?utf-8?B?N0h1dy9mSTloRGVxSXh6aDZsaHFoVVJZdFFjRWFMa1RuS2swclIzWGRaVXdZ?=
 =?utf-8?B?M2xVNThzdDg2cEFYOG9MZVV3V2ZrZ2NIaGw3MHVBUHNXWWZUQ3REWXVqam15?=
 =?utf-8?B?SXZqYVNiKzdYdXhQdnRBYTFWMkw1aVpIcVJ1SXBmNTJSSzVCRnIyNXljZlJu?=
 =?utf-8?B?Q2t4bnBhNHA5TnNCTStOMHN2Z3V3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FBE0439F7867B94F8511AC397E3CA974@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR11MB5687.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a420c58-bd6a-430b-272d-08da0040c99b
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 13:45:48.6017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q450nlBtT4Z0Y9npGGXqQkFRKfPUavqbW873RpInXXpxK/FxVe6vqK5L2lns5FrA8f2bJn+zoVXtoQPnJKA7WJL2UfrEb2c33MrEmfwOHCg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5592
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDcuMDMuMjAyMiAxNTowNCwgTWlhb3FpYW4gTGluIHdyb3RlOg0KPiBAQCAtMTM2LDE4ICsx
MzgsMjEgQEAgc3RhdGljIGludCBzbmRfcHJvdG9fcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikNCj4gICAgICAgICAgICAgICAgICBkYWlfZm10IHw9IHNuZF9zb2NfZGFpZm10X3Bh
cnNlX2Nsb2NrX3Byb3ZpZGVyX2FzX2ZsYWcobnAsIE5VTEwpOw0KPiAgICAgICAgICB9DQo+IA0K
PiAtICAgICAgIG9mX25vZGVfcHV0KGJpdGNsa21hc3Rlcik7DQo+IC0gICAgICAgb2Zfbm9kZV9w
dXQoZnJhbWVtYXN0ZXIpOw0KPiAtICAgICAgIGRhaS0+ZGFpX2ZtdCA9IGRhaV9mbXQ7DQo+IA0K
PiAtICAgICAgIG9mX25vZGVfcHV0KGNvZGVjX25wKTsNCj4gLSAgICAgICBvZl9ub2RlX3B1dChj
cHVfbnApOw0KPiArICAgICAgIGRhaS0+ZGFpX2ZtdCA9IGRhaV9mbXQ7DQoNCmxvb2tzIGxpa2Ug
dGhlcmUgaXMgYW4gZXh0cmEgbGluZSB0aGF0IHJlbWFpbnMgaGVyZQ0KDQpXaXRoIHRoaXMgYWRk
cmVzc2VkLCB5b3UgY2FuIGFkZDoNCg0KUmV2aWV3ZWQtYnk6IENvZHJpbiBDaXVib3Rhcml1IDxj
b2RyaW4uY2l1Ym90YXJpdUBtaWNyb2NoaXAuY29tPg0KDQpUaGFua3MhDQo=
