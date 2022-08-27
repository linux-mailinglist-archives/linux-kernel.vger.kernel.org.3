Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA7105A3A12
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 23:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbiH0VNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 17:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiH0VNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 17:13:12 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33245357C4
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 14:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1661634790; x=1693170790;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TdcNBytt9/ChjYJ35cCVuTI+9SS6eJ0E9N/kmd/UpK4=;
  b=g5B71l0i1+iW4nazk3RCEpdE7EhSeHRZj79KwI1xjzs0jTKCzrlfDJTe
   3T989ZmY+bIeib6SFt6XZq6O+r7D34hTltUe/6DuUPmxD6lNQX8gIy2+R
   B4zmJIZjsmExowd3SmnUIK6CxZBNgdXardGwfoJymY9OtWMkrcrAkza+l
   QSbP9uX3wYgUw5nvUQzvBOSb7pqLZHJW+XrOcqrQnu9muCTz9ELWqaEBS
   D1c1mB+A4jroV6vo+zzAdwzmgIxqe993sBHfzX2AwwMmKcyaVNV1MKY5r
   0RV5VLSTBd22aD4dJxk1ynAujthekuFb/PV5tyFbsErRYTiHLvO3Uw1jU
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,269,1654585200"; 
   d="scan'208";a="178005791"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Aug 2022 14:13:09 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Sat, 27 Aug 2022 14:13:08 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Sat, 27 Aug 2022 14:13:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TlvIX3qr5iNDeO+VonAnazQ36AH1Pna0q532Pt/ngZscSMCKYy2VXDanKT7xVFZRINTx96k7dMPbMvLKjuymLo8o5OnLT3PQ79soaZIabdipa5nxJR2PfMU6fqmWDEBYBtCXOrRXdPUp590ls3E/zzxx2j2qns0B56r4PyZWOjVJgBcGiL5HWcaxEECORYgbHbwPYWiETyheay/ilbTTTBxo8H3VzMZ36yY1kQSz2JDysL5kNYF9h91cjQJafgdEZDBa5z/DwzkaqiiKb0z7bVex5BTLRD/oxkJGuBZuafdl1ZYJrCGd5c74ptors2B92gH/3DChbhp7g8rTVml9nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TdcNBytt9/ChjYJ35cCVuTI+9SS6eJ0E9N/kmd/UpK4=;
 b=FiizS8D1RqOiCWx0gUu5QnxdCqhJ7R20KqqsR5abzBxMInOsT3dpCx5TEySY9gJEhrha2oM4xN6RoY9YgXaeYVxJhq3EUYFAQsaZ6CwOm3MpI0YjQueEQzd+kJfS9wDZYRq0J1l3oMCgBpwSRmmnCTa2o9QiBCDEoa0CeI3P57audyAjGnFfc45gi4L7Te/19vJDCWq1qRkFgp2Go+0e0mXYRwFOO8JUVSItFwZoOh/hEnnJcHk5jhq5jvvasXtSPk8qxlW5eDK/QjsrdC2SQqpVRalX3xR3vFdxgLlX5kRjAfUTG83INguF+gl18i3Gj20mI1D9kVI5Hg0FsIoHew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TdcNBytt9/ChjYJ35cCVuTI+9SS6eJ0E9N/kmd/UpK4=;
 b=SznHCYoDsThBS6HPR5KHajz/r0EKLUXiP4qcrJe3sA1PKVtaYr5mzAxkd68aVVzUUmqckpkhl35mtaXehig2NqVaKyTsASf91+tfj08M0ebyN/z5ImlnFtkkisLTLtwiN6US4EL5T2OnlwukcHxvegr2pQWULd/tLhrgSRxYCKU=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by MN2PR11MB4430.namprd11.prod.outlook.com (2603:10b6:208:192::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.19; Sat, 27 Aug
 2022 21:13:04 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%9]) with mapi id 15.20.5566.019; Sat, 27 Aug 2022
 21:13:03 +0000
From:   <Conor.Dooley@microchip.com>
To:     <jszhang@kernel.org>, <paul.walmsley@sifive.com>,
        <palmer@dabbelt.com>, <aou@eecs.berkeley.edu>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <ajones@ventanamicro.com>
Subject: Re: [PATCH v2] riscv: enable THP_SWAP for RV64
Thread-Topic: [PATCH v2] riscv: enable THP_SWAP for RV64
Thread-Index: AQHYufzf4JJbBuNch02tBI9sTRPCrK3DP5sA
Date:   Sat, 27 Aug 2022 21:13:03 +0000
Message-ID: <0256a458-440c-171c-2a6f-e88a50c16f82@microchip.com>
References: <20220827095815.698-1-jszhang@kernel.org>
In-Reply-To: <20220827095815.698-1-jszhang@kernel.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8ca4f509-1a2a-4f31-081c-08da8870ede7
x-ms-traffictypediagnostic: MN2PR11MB4430:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DGoUGfzbkdkCDlrkTJDlQlCpZcIFo8VwgWqy9p89GGCs40P1MJ9/pKEo1sww3bCLCv89umuA4RX5FMWhxzDWacQParQujUZchqTlYv9dnT1xnUeJuKKIptafCJPMeu48BuN0ZeloUtgIqmmeo6sPxqGTbf5Vs2PNn5Lx/uE4IExUXH+/8Y21v6LVSvDwfNH6xFEOrIxJ5a4qaxELE059pOhXKCEethDqoXfy3KubXUf1z8+Bsu69wkxcRrDwZLmLTADf5n85Tx2CDR8N1GaYQE9luXMNm8wrbL1WXkTIFpCV0kdEBQGcyhLUVm4NUH7pHRh6+7U90L3jJlyuVHW7UcmvMvF24pCeOYCC4Pzw0q28c2qB9B/ZkU/AeRNipUns5dgfH6HjpIvLKDmfh8CuX7q/vll/Mgop4Rr59MEZO4f5ItqRlEOASqbyRg2VPLLOWaHxN/6+3X/ygkDv0lfpRJVk7z9A8YNoIx0JzQOeEGluczgub8q2++wlH2oHIxcIzx0Zmknwinn95swX9FBcWFowNRznZg1Vf78CS4zGmZbJqZI7+w607ti2grVjgRFbScMLMSU9X/JwdGGhN1KJ+ZnGTuJLw3a0fPXP4VGKIAaEmBvtjK+Wg08VOJO/brQWUUtFPmqqCjJbkNAJyDasjbz2OolGpuWrKrBGsQNnNrQOBUXxeqGGgVO7e/T8SxbfNk932Z74FKwV3JOFHbgXoCQYuodXoXLpCvqq0APmxcjDIBXz3HPz02PxHgEwQKY3CopTpndDyY2QT7mlOugM+1MbRCOYeocCBpZi3jzOmTVi+ukR+eJGbatIlVGBnrBq6zhwfJ3fJnFBcA7kHAPhig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(396003)(39860400002)(366004)(346002)(83380400001)(38070700005)(122000001)(38100700002)(110136005)(76116006)(54906003)(5660300002)(316002)(8936002)(91956017)(66946007)(66556008)(66476007)(64756008)(66446008)(4326008)(2906002)(186003)(2616005)(6486002)(478600001)(41300700001)(71200400001)(53546011)(6512007)(6506007)(26005)(31696002)(36756003)(31686004)(86362001)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnAzY0VaUTNnVGpoUHdSNmxjR0dUMmJ2bFMrb2w5SGJ3MWRiTUFLSmxKLzl4?=
 =?utf-8?B?M0Y2NFlJUzdNQm1HZUl1WEVzNUt1L0hLRnpaWG1SbWplN2N4K09KUHlCM3lJ?=
 =?utf-8?B?bzhMVzk3Y04yaGlrSlBBdjRXbGJNUUVvV0Q2eC9QemdWZWYwOW4wRFRMTGI3?=
 =?utf-8?B?ZlRyM1ZRRFZ6THpqMVdoYkhQcVRYZEdmaEtRY1BqOHJyWnZBa3FrakxUYzUz?=
 =?utf-8?B?aWJXV3Y3d3lhVk5yS1ZqSFRhL09JU0l2QlR5ZnVkbjRITDFrM1lIQ2tNQnRB?=
 =?utf-8?B?S2JQcXF6Mk9lUlVFZ1UzbDByRmRKZ3B2N1IvVEZOcGZzQmIwTVlGaE1RRUNM?=
 =?utf-8?B?Rm9TdnFNOEoxaEtTOGJJekZNOFpKSWlKWk1XU1N2aWxzcGxGbThsWjFsazdx?=
 =?utf-8?B?dTFaK2kwMU5Ka1VjakxnaEJGbVNyRmZHNFhqeFpzNWdPbmdjNnlETWFxYmE3?=
 =?utf-8?B?Y0xmdEpyS1h6MjlwVjQ0K2NhR0hYNy80Y2ZoQStEU0g4SExrbElYZTlqYnVa?=
 =?utf-8?B?QlpaMFRZS0RHa2R0R2h5U3o5VjNORjRXMTRMMzN4NzNHMWJvYWN5M0hpSFZC?=
 =?utf-8?B?Ymk1NVVuTzM0bHJnc3lkM3RQZG1ySGFqUWwrUTR4dkNJakxCcjlUZmdBMUpG?=
 =?utf-8?B?VlVobkFFSnZUUFBLR2JrYW8rSmU3UEtvUitGakVvMmlGbFh3eUMwNCsydDNx?=
 =?utf-8?B?d2FBVk82YkJDcFVTZFc1MVovOVN4TjlnbzhOSXdOOWsxYVVFZTh4RTBYa0F0?=
 =?utf-8?B?cjVTeXdKenoyTWVWNUhqYnBTUmsxbklOQWxTTXdFZHZobFdIRXRUN2lMd01E?=
 =?utf-8?B?UkZNVTI4T1N1elJucDJNdGNyWG5KRHVSKy9Rd3Z1M290MGNFMVlTSXhUUDRs?=
 =?utf-8?B?S3orT0xqNUkrUWpjS3JVMy9vankxUjZXbm9IV0VlTEpxSFJnMkxERGxYdWxN?=
 =?utf-8?B?U1FxUFdDWGF4Nkx0UGw0RFBuT2lXVjV4VGExUWdwS1FOMkdWRU0wNWozWnha?=
 =?utf-8?B?Vm1URStkelhwSzdvdzUzam94UEVyWmVCUUNFTmZ2SW96b2tOTTJZVWxwSms2?=
 =?utf-8?B?SXRQNTRTUFJyVHpLV1VJTG9MMGlUK3JLYzNPdlhhSjh6dERwR3JqOVhBajMv?=
 =?utf-8?B?VHEyazdiSEl2blVRTTJBWFBTaE5pckhwQy9nMWZXYlRybUZxaHhRL3o2c08w?=
 =?utf-8?B?akYzZXU2RDJJUGV2aklPM1Vqay8vZVg0NnNidlBqNkFxa3NuVmFCMURNdHI5?=
 =?utf-8?B?UHpZWDdaU2kza3M2ZnhWQmxRRGhKeFV4VmJiWW44Z1I1M2ovVURDT3RNNTc0?=
 =?utf-8?B?Snoyei9PdEU5alFscHUrRWNrWUlEekRxbmVuemRIaUpNNlpxczdyMmhhdDBT?=
 =?utf-8?B?OXVXd3ltRGhqcExNQzdxU01kV2g4MDFvYkVtYkVrQkRwQ2JiaTJRL2pJMWgx?=
 =?utf-8?B?MU8zQ3BybkJoZEo5MksvY0FVb1VpR1E5eEdaNHNudE4zKzIrY0hMQkw0UWkw?=
 =?utf-8?B?enk0ZkViTHhFcTBtV1NITU9mczFXdWxmS0pScm5xcFRmSjFGcWRKZTBmOWJP?=
 =?utf-8?B?eDJVdk9ucVdlQ2VVeGxIWjJFS1prYmVrMERxWCtXVjZCdFU4ZC92SGZwa1d6?=
 =?utf-8?B?Y29Ha0hDOUJ4SWQ2TGJySy9YNEtUSi85S0dadkM2NjRYK3h6VE9nZVY1Tmti?=
 =?utf-8?B?WDFQN2wvTUNNZXRHRHIwZXVpOW1MamdJUDRhRS9ERHIzUW44V01ObmN2QjQz?=
 =?utf-8?B?SHVwNjdSekI1NXM4NHVqY3ZCZzFNUVhJeEFKcHl2dENQMUxjZWhhZFNEcm1K?=
 =?utf-8?B?bjZhOWZjYVFNUnpiaEE3THVNOSsySEdxNTYyME0weHU5cG1sQmNkTktKSS9Q?=
 =?utf-8?B?V1dFb2RucEZJSWRkOXFURUZITklkT2N6alRrc2RBekJqN0JPa1BJTFIvNm9s?=
 =?utf-8?B?a1Z4NFFCUzIwYkVlSlVlUWkxVkZwNWJvUlUxQnIrM093NGtWZDZ3TS8yU1pE?=
 =?utf-8?B?OTQ1dGd3K0JvdXBvV3lCcTBTWElPaU4rYVV2WGtWSkZiYjkreDFmT2Z4bzhF?=
 =?utf-8?B?YTFTclF0SWFrTUplQmFjOVdaamRHQkxYaFFqSmxuTTFqNndyMVBQeUxxOHY2?=
 =?utf-8?Q?KNEfk7hgCoDdGhljgOCKFAYUv?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9732437204AC0B4793C355B7D2BC5B16@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ca4f509-1a2a-4f31-081c-08da8870ede7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2022 21:13:03.4777
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bWiQaVhiMo5N0gK9/GGrR2ldkQn9edEMNWsOk4eLzx0s64nFKXBtXbaNfkeRQwDtFsF9KsL7DIxNgiSH0RpkCTcNmtlWBTOjKJLExUinwWw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4430
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGV5IEppc2hlbmcsDQpPbiAyNy8wOC8yMDIyIDEwOjU4LCBKaXNoZW5nIFpoYW5nIHdyb3RlOg0K
PiBJIGhhdmUgYSBTaXBlZWQgTGljaGVlIFJWIGRvY2sgYm9hcmQgd2hpY2ggb25seSBoYXMgNTEy
TUIgRERSLCBzbw0KPiBtZW1vcnkgb3B0aW1pemF0aW9ucyBzdWNoIGFzIHN3YXAgb24genJhbSBh
cmUgaGVscGZ1bC4gQXMgaXMgc2Vlbg0KPiBpbiBjb21taXQgZDA2MzdjNTA1ZjhhICgiYXJtNjQ6
IGVuYWJsZSBUSFBfU1dBUCBmb3IgYXJtNjQiKSBhbmQNCj4gY29tbWl0IGJkNGM4MmMyMmMzNjdl
ICgibW0sIFRIUCwgc3dhcDogZGVsYXkgc3BsaXR0aW5nIFRIUCBhZnRlcg0KPiBzd2FwcGVkIG91
dCIpLCBUSFBfU1dBUCBjYW4gaW1wcm92ZSB0aGUgc3dhcCB0aHJvdWdocHV0IHNpZ25pZmljYW50
bHkuDQo+IA0KPiBFbmFibGUgVEhQX1NXQVAgZm9yIFJWNjQsIHRlc3RpbmcgdGhlIG1pY3JvLWJl
bmNobWFyayB3aGljaCBpcw0KPiBpbnRyb2R1Y2VkIGJ5IGNvbW1pdCBkMDYzN2M1MDVmOGEgKCJh
cm02NDogZW5hYmxlIFRIUF9TV0FQIGZvciBhcm02NCIpDQo+IHNob3dzIGJlbG93IG51bWJlcnMg
b24gdGhlIExpY2hlZSBSViBkb2NrIGJvYXJkOg0KPiANCj4gdGhwIHN3cCB0aHJvdWdocHV0IHcv
byBwYXRjaDogNjY5MDggYnl0ZXMvbXMgKG1lYW4gb2YgMTAgdGVzdHMpDQo+IHRocCBzd3AgdGhy
b3VnaHB1dCB3LyBwYXRjaDogMzIyNjM4IGJ5dGVzL21zIChtZWFuIG9mIDEwIHRlc3RzKQ0KDQpJ
IGtub3cgdGhlIG9yaWdpbmFsIGNvbW1pdCBtZXNzYWdlIGNvbnRhaW5zIHRoaXMsIGJ1dCBpdCdz
IGEgbGl0dGxlDQpvZGQuIElmIHRoZSBwYXRjaCAvZW5hYmxlcy8gVEhQIHRoZW4gaG93IHdvdWxk
IHRoZXJlIGJlIFRIUCBzd2FwDQpwcmlvciB0byB0aGUgcGF0Y2g/DQoNCj4gDQo+IEltcHJvdmVk
IGJ5IDM4MiUhDQoNCkkgY291bGQgbm90IHJlcGxpY2F0ZSB0aGUgYWZ0ZXIgbnVtYmVycyBvbiBt
eSBuZXpoYSwgc28gSSBzdXNwZWN0DQpJIGFtIG1pc3Npbmcgc29tZXRoaW5nIGluIG15IGNvbmZp
Zy9zZXR1cC4genN3YXAgaXMgZW5hYmxlZCBhbmQgaXMNCndvcmtpbmcsIFRSQU5TUEFSRU5UX0hV
R0VQQUdFIGlzIGVuYWJsZWQgZXRjLiBOb3QgdGhhdCBpdCBtYXR0ZXJzDQpmb3IgYWNjZXB0YW5j
ZSBvZiB0aGUgcGF0Y2ggdGhvdWdoLg0KDQpJIGdhdmUgaXQgYSB0cnkgYW5kIG5vdGhpbmcgd2Vu
dCB1cCBpbiBmbGFtZXMgd2hpbGUgdXNpbmcgenN3YXAgc286DQpSZXZpZXdlZC1ieTogQ29ub3Ig
RG9vbGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogSmlzaGVuZyBaaGFuZyA8anN6aGFuZ0BrZXJuZWwub3JnPg0KPiBSZXZpZXdlZC1ieTogQW5k
cmV3IEpvbmVzIDxham9uZXNAdmVudGFuYW1pY3JvLmNvbT4NCj4gLS0tDQo+IFNpbmNlIHYxOg0K
PiAgLSBjb2xsZWN0IHJldmlld2VkLWJ5IHRhZw0KPiAgLSBtYWtlIEFSQ0hfV0FOVFNfVEhQX1NX
QVAgcmVseSBvbiBIQVZFX0FSQ0hfVFJBTlNQQVJFTlRfSFVHRVBBR0UNCj4gICAgaW5zdGVhZA0K
PiANCj4gIGFyY2gvcmlzY3YvS2NvbmZpZyB8IDEgKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9yaXNjdi9LY29uZmlnIGIvYXJjaC9y
aXNjdi9LY29uZmlnDQo+IGluZGV4IGVkNjZjMzFlNDY1NS4uNzllNTI0NDFlMThiIDEwMDY0NA0K
PiAtLS0gYS9hcmNoL3Jpc2N2L0tjb25maWcNCj4gKysrIGIvYXJjaC9yaXNjdi9LY29uZmlnDQo+
IEBAIC00NSw2ICs0NSw3IEBAIGNvbmZpZyBSSVNDVg0KPiAgCXNlbGVjdCBBUkNIX1dBTlRfRlJB
TUVfUE9JTlRFUlMNCj4gIAlzZWxlY3QgQVJDSF9XQU5UX0dFTkVSQUxfSFVHRVRMQg0KPiAgCXNl
bGVjdCBBUkNIX1dBTlRfSFVHRV9QTURfU0hBUkUgaWYgNjRCSVQNCj4gKwlzZWxlY3QgQVJDSF9X
QU5UU19USFBfU1dBUCBpZiBIQVZFX0FSQ0hfVFJBTlNQQVJFTlRfSFVHRVBBR0UNCj4gIAlzZWxl
Y3QgQklORk1UX0ZMQVRfTk9fREFUQV9TVEFSVF9PRkZTRVQgaWYgIU1NVQ0KPiAgCXNlbGVjdCBC
VUlMRFRJTUVfVEFCTEVfU09SVCBpZiBNTVUNCj4gIAlzZWxlY3QgQ0xPTkVfQkFDS1dBUkRTDQo=
