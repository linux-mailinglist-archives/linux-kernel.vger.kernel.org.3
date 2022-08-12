Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B96F591762
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 00:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237635AbiHLWhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 18:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiHLWg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 18:36:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D51634D820
        for <linux-kernel@vger.kernel.org>; Fri, 12 Aug 2022 15:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1660343813; x=1691879813;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zLNwlPtX6GBDyPEKlMIX0F0yuK/6/6z/9I1kipjTeCk=;
  b=TEnF94iiFV2W2xORwh0I4NbZC38XSZvOiyy0/ZZsD8QU5/lx7i90o/Gp
   3oc310PYK2lmn1ucEk7hVhPWtGLCG2DchmrhhyOdNhXga/zilltYls2jD
   frIuytm0N7xkran8qsRyHGW2u2OWBzHsqLkFRGiU0JrOS77VLB2LZ1fPJ
   j6OF19iPOBwWictEAL2qrq5Co+F8rUEN/jfNbXRXCgJFFwVTmo4/zm6jS
   BhtN7ifBHvMCQwWf/3eS3+ur/qNUJmM35Rn9b5jq+NCnJko7AXplcZdyc
   kMjvkAd1eV76GLOfRevXUgeCi96j3sbC87NKKLltFHaL+E6289DIkuNHw
   w==;
X-IronPort-AV: E=Sophos;i="5.93,233,1654585200"; 
   d="scan'208";a="176211425"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 12 Aug 2022 15:36:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.12; Fri, 12 Aug 2022 15:36:50 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 12 Aug 2022 15:36:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=afyFFX6JrbkSiFDUAes3Xn8pBTS9I86rwJoPilHrK87/2AFDi86McJ15zRikMm7TCYpeF0iIKWhadRWDoBlGxvl+evFKGxvTUDn27dJjGIdWRXr+Wdna7Vc1VJnu1gN2vVWwyt6RQ8MyiN+Acjm9cVYoP8lGu57MKFa7a6Gv5Exz2d2UIGDiyf0S3IP9C9WZP3Us9fGuhGH2fNJjY6WGKvhOokhLDXOSEgrEz+S27TUhPM7Bxx+g0pxoyyJSaJj409Os/EJaP56lmq4HYDWyTwK1Su0ECrq0tc3bBKOgJZ3GpLu+4nUaoiVc+484Z+NIAJm8kvLxsLpbls4sUOapAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zLNwlPtX6GBDyPEKlMIX0F0yuK/6/6z/9I1kipjTeCk=;
 b=C7OuVaIx4DXdnhqkJ4nEQln+qO9JojjrEFYa6E+HS/KSl03EDW+R2vleRPOl98ymUFseYau5HHkB/pIY/6g8fvQ6f0gLkX/Eoo9tRHlk/w6Cgoqb0heXxT5gA7qR5t5OL9HcnfwnJ01L8Hm1h8HCzN/qSIjD5+VkjI8Ti86uVfkpP1Sa6lAp+RExs5Qmmo/45ak2TpDvLWTTQR32M9rXKWjzH7xajfbnxJanjfstDu2O4jzB4yptTnjYm1TYrmAQBineak/h7h09iUh4g0JEWyqjzm/gOwjgWNroZQUh/QmhOqjOqU/lSwBUFtCuD7x/cbvLt2o9mgdDLEh5nOs8Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zLNwlPtX6GBDyPEKlMIX0F0yuK/6/6z/9I1kipjTeCk=;
 b=khOKW2CYCe/TW+lmtwpa0W9gH1cvyB3fdkVNza2mrP2SUn92sSRdct4vwVrIjkZGLHw5H/24lONBPP6tSLmf08BRciD487NNYC+0c8DecOgX2/fhd15wzDiIitTLRKKeMXyTKcGfXrg+YPcROx2AlU3nzy5vCmx9AtLFUjRV+xc=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM5PR11MB1372.namprd11.prod.outlook.com (2603:10b6:3:11::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 12 Aug
 2022 22:36:35 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5525.011; Fri, 12 Aug 2022
 22:36:35 +0000
From:   <Conor.Dooley@microchip.com>
To:     <palmer@rivosinc.com>, <Conor.Dooley@microchip.com>
CC:     <jrtc27@jrtc27.com>, <atishp@atishpatra.org>,
        <anup@brainfault.org>, <will@kernel.org>, <mark.rutland@arm.com>,
        <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-riscv@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf: riscv: fix broken build due to struct redefinition
Thread-Topic: [PATCH] perf: riscv: fix broken build due to struct redefinition
Thread-Index: AQHYrlLLJJmuNPzJiU+k51rJJC8n162rTtwAgAABmgCAAIn8AIAAANsA
Date:   Fri, 12 Aug 2022 22:36:35 +0000
Message-ID: <8cd009c0-d106-3042-c803-f48c9b4229ba@microchip.com>
References: <mhng-32b44fa5-288d-4186-bc79-6c5f2608aa36@palmer-ri-x1c9>
In-Reply-To: <mhng-32b44fa5-288d-4186-bc79-6c5f2608aa36@palmer-ri-x1c9>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e756190-3cfb-49b5-7286-08da7cb31ce4
x-ms-traffictypediagnostic: DM5PR11MB1372:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CGD2rTO3J9MuSP3nXKJQ/JVlRrclUG6ulkGLMXZZxepXLN90jlE02udCDCviMYmv8yjzaJ2PoHxgD2f25qQUUNnAEI2bRAkcj1Ub6CyG5wtqHZyqbstEbourm0fRmcAXR8USEU4RgFZ0iVKDUwyG1KzLE9gu+wOlNpaBupPAjFgqn9f6bGEy6PgKuUXwyRpx99Y3lJ+sKEN0ImPniSMenURXCi002G+fjNSnVf/sUAPHr2CZndYYJLDcehXRifl4YaTuLUEft+GKW6ohqc734dPyrj5o+RMCA+nElrFKPsFq24MO+FRb2eBafJnPQTrc8Sd37vWBzrT5s5tJQfMg/8BR9dyWe4FQvvDZ8XrVCO6RcXoYP+CmAhTzEaOFqxowzCdl+wUr/BGJA+CdDVX+TAnIYwlJCOt3ox/Uub667JVk/vHHUMdTyKQOPnHsvnh/bGI06FuF8fSXCFKljdjGkCy35CoyZoi/7n/rn0CoISH998amou0SQCl/YI32Knp+eSyWDyr5ZVAHqdMXUtoRTYfjq5faw4cRFryGPYa9lyAUFGAubzGFTTMbNqhZm7RBBkxlfgETJhTEaGYUwV+9pZXHJ2mB01BFQJVZ06hJOKnUH3zlf35MVEyY0HWRN4BIekN3Lz5cBKDXxASncqcHK3ZvOHMIfB67j9+HvvibO6hySbuFwUi4nCxcF+aLAvyLwihZmfGo1asBE2c0dSK5Wy5yIiwPnbJAsWLSkxsLeVVCQn0EyeREO5ggXilTpSbA6lsGGspljdhP8kO53uMkiaKYIA4ViqF2hiIuntWJTHK135fxIMTAIHFyPQF7tubSk9SW/nMtP8rFccQvJvm9VDcqo0FCHVv1P1OPRVtIjWBj/ATloqyaGfAE2h1v/lBk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(136003)(346002)(39860400002)(366004)(376002)(7416002)(36756003)(31686004)(8936002)(66476007)(66446008)(64756008)(91956017)(66556008)(2906002)(66946007)(76116006)(110136005)(54906003)(316002)(5660300002)(478600001)(6486002)(71200400001)(6506007)(6512007)(26005)(122000001)(38100700002)(53546011)(186003)(83380400001)(41300700001)(2616005)(8676002)(4326008)(38070700005)(31696002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OExTMXh5dUZXRWZwQkdnUkFMV2FSRXFpOUFFeVVuU1NldWlZMys0YTdQRXJq?=
 =?utf-8?B?TEIvc0NtalpUY25oNUVFbW45T1lKVHluY0daZXJOeEwyazlzck1HdHBHN011?=
 =?utf-8?B?bkFVUXhvS2JkamlEUnEwTEdTNWRqUE9EVWo1Uzc2Z0tXTUM0bXlDVnF6ZDBI?=
 =?utf-8?B?VFI3a2thc25ET2UwVWM3VkwrQUljUml1cGY5dlNrbkJmaWdYeFFwc1hRdndX?=
 =?utf-8?B?SVNEeG5LKzdyRkVWSnVlWWxSSTRTTVZaeXJ5YzNQcldmRjdUUUZMZGRyeG5m?=
 =?utf-8?B?dDA1YjVFRjlNTkJvSVZpSUdMYWNBMXpiVW9Pd2RNM2RtQ2phL2k4WG85dUhE?=
 =?utf-8?B?ZnBVQWNuRDdVV2pzelNSRTBZV0RCejNmNEMrbzBHZlhhenJIZmRQaUJQc2R1?=
 =?utf-8?B?ekxnbS9iVnhiUy9jUWxva0l1VWtyempFQlY3bW1pL3NwcGZoSVJtb2JyTmMy?=
 =?utf-8?B?NHNHaU5FUlAyU1lEQ2RHbkVEbmFETUxxV2U1RXEwS3E4bHgyOWNFR1ZyRFB6?=
 =?utf-8?B?djh6Z1lDVFVMaDdIb2xQL3llY0FYRitJZTJhaTh0cDRKNklibzExbi95bVVU?=
 =?utf-8?B?VzVpcGl4VDVPT2laZjhoM0w5TTNZV3RnNlB1NTVRck9vTWU4RDE2QlJqSUJo?=
 =?utf-8?B?NFlJYkhxUG1QaUJHZ01PUXBMV2xVMC9hNWhaUjg1YnlTR2psY1llNzNwcCtN?=
 =?utf-8?B?cGI4MlJBcHhjMDZrNE1LYm9PdzVtaEpCVGRXWlpTZnUzclZFMlFMZGRmRCsz?=
 =?utf-8?B?MGNNRkV0M0RWM2ZhY0llTUgvOTZuVjU3eFpyYlRoZ2pFTHN1ZmhzcW9WN3RW?=
 =?utf-8?B?SlUrZTNncUFWSlZ2VkZzZG9tR2ZKbTVBWXZYUzRZMHhUWm84WTN5SHpFTW16?=
 =?utf-8?B?dU91UHlLc2hkYUM2V0FzV3h1UmppVW1hTjJzUnRIS05hMTZsRWxYeVMyWllU?=
 =?utf-8?B?dkZ4amJXVHYwUGszWmFrYXlvRFRUMXJ3WlRDV2VwVHdaYWtSTGNqQXJIbVYy?=
 =?utf-8?B?UXZSdDRhTGlBbkErbFdFcVQrZExGT0NnZlNVS1IydWMxSjA3Q0VSek9jZlZ0?=
 =?utf-8?B?K0o4YkVKWlBNRHlvNmdUL0ZyTFE2VHVoOGZTN01WSkFaQ05RV0N1SWFHczFo?=
 =?utf-8?B?N3Z1QUkyN1hUVzh2WGhyL3NFMEg1UzZUUko1cEY4blVNN0t0ZmxHTFFPa3M5?=
 =?utf-8?B?ZDZxNEFQOHRoWVBqVS9KZU1wb3RSL3VjQnkybHJCQ2RNMFJZM1JPVnk0SzB6?=
 =?utf-8?B?YkRQczVzNXBXTmZJaHZMVzk3dXpUSytGVjBjNWVtdXNjQ1hFS2dOL1cyeWtu?=
 =?utf-8?B?WGU1bTF6UGlabTNPTXlTbjQxN2JWTmk4ZDdhR1pBbEltWE9hTkxHYzRvSWxP?=
 =?utf-8?B?NWduN3c0QWJrZjRpMjZjYkNYVjZqcnlZSGhGOVp6VnEwdG5qbTlDZGpPR2JB?=
 =?utf-8?B?TXF4M0I3a3g3MHVpbkdUcUd5RWh5WE5jZm14dTRhcm9NUVRYN3IreWh0a0FY?=
 =?utf-8?B?bDB4T3JjODB4ZkZyd1F1MjJVZktPRXRnaW9qaFN6a3pycFNGZDMvT2pHUVYw?=
 =?utf-8?B?UytMNDJFMHNLVjlUTlRpdW1JQUJEdnI2M2NFeGo2eEZkeUlQOWwvNXRrbU1L?=
 =?utf-8?B?UlZ0cWFvWUJkaG1PSmpkUjhCb0F1algzejR0Mjk1U0pEQ1pDNHRFVnlxS1cr?=
 =?utf-8?B?WTdkMzlXaHYxUy9SaTJydWxlYkM5TUJha1RxK3lzeG1waTI1M1pucTNURXd4?=
 =?utf-8?B?b1I0MURteTduUGZtOWxJQlZpMUpVa0xETGZ6V0RJMGV3Zlc4UHVqZFZydHB0?=
 =?utf-8?B?VjNGblNnNWVGZFJpaW5pNVN6MWl2dURIWit2RWcwcS9EdzVFQjNBK2RNM2tC?=
 =?utf-8?B?aEJhWi9HTE9GbWg5L1dPQWJrSWY2aXhHbWZTRC9FT0JGTnlnRElBVWVQK0k1?=
 =?utf-8?B?RjUwRDlPalNTZHlEVXlOR1IxNG9wdkljczhNV2JiRExFcUhJcXBzdVVBSGNL?=
 =?utf-8?B?NHpvUkpwQUU1N2FKUU1nRjBUaExEY0U1ZFRLdDNMMFk2K2Vnb3BKWW9hbm1r?=
 =?utf-8?B?NldWVkFsTWRaK1BBL2FXdDR2ejhLL0xoMDFEMjFVbTBQZmtNMzJ4M3MvTmkw?=
 =?utf-8?Q?CZKpMwSs29//45u9GM91Oa0Tq?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <51FC717FB14A574CB451680F34315FEF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e756190-3cfb-49b5-7286-08da7cb31ce4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Aug 2022 22:36:35.1601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9DNZzJ+Um7odARdy1LSS3te0F1HNRxR5ggGCmqLDCR6CajBhN6o5Q/esKC7mYRI4KRBeSjdR0bfTv4m7ai9xB8LPvwet7ul0ra6MfgPBWSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1372
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvMDgvMjAyMiAyMzozMywgUGFsbWVyIERhYmJlbHQgd3JvdGU6DQo+IE9uIEZyaSwgMTIg
QXVnIDIwMjIgMDc6MTk6NTQgUERUICgtMDcwMCksIENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29t
IHdyb3RlOg0KPj4gT24gMTIvMDgvMjAyMiAxNToxMywgSmVzc2ljYSBDbGFya2Ugd3JvdGU6DQo+
Pj4gRVhURVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRz
IHVubGVzcyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+Pj4NCj4+PiBPbiAxMiBBdWcg
MjAyMiwgYXQgMTQ6NTEsIENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+
IHdyb3RlOg0KPj4+Pg0KPj4+PiBCdWlsZGluZyByaXNjdi9mb3ItbmV4dCBwcm9kdWNlcyBmb2xs
b3dpbmcgZXJyb3I6DQo+Pj4+IGRyaXZlcnMvcGVyZi9yaXNjdl9wbXVfc2JpLmM6NDQ6NzogZXJy
b3I6IHJlZGVmaW5pdGlvbiBvZiAnc2JpX3BtdV9jdHJfaW5mbycNCj4+Pj4gdW5pb24gc2JpX3Bt
dV9jdHJfaW5mbyB7DQo+Pj4+IMKgwqDCoMKgwqAgXg0KPj4+PiBhcmNoL3Jpc2N2L2luY2x1ZGUv
YXNtL3NiaS5oOjEyNTo3OiBub3RlOiBwcmV2aW91cyBkZWZpbml0aW9uIGlzIGhlcmUNCj4+Pj4g
dW5pb24gc2JpX3BtdV9jdHJfaW5mbyB7DQo+Pj4+DQo+Pj4+IFRoaXMgYXBwZWFycyB0byBoYXZl
IGJlZW4gY2F1c2VkIGJ5IGEgbWVyZ2UgY29uZmxpY3QgcmVzb2x1dGlvbiBiZXR3ZWVuDQo+Pj4+
IHJpc2N2L2Zvci1uZXh0ICYgcmlzY3YvZml4ZXMsIGNhdXNpbmcgdGhlIHN0cnVjdCBkZWZpbmUg
bm90IGJlaW5nDQo+Pj4NCj4+PiB1bmlvbiwgbm90IHN0cnVjdA0KPj4NCj4+IGF1dG9waWxvdCwg
dGhhbmtzIDopDQo+Pg0KPj4+DQo+Pj4gSmVzcw0KPj4+DQo+Pj4+IHByb3Blcmx5IG1vdmVkIHRv
IGl0cyBoZWFkZXIuDQo+Pj4+DQo+Pj4+IEZpeGVzOiA5YTdjY2FjNjNmOWMgKCJwZXJmOiByaXNj
dl9wbXV7LF9zYml9OiBNaXNjYWxsZW5vdXMgaW1wcm92ZW1lbnQgJiBmaXhlcyIpDQo+Pj4+IFNp
Z25lZC1vZmYtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+
Pj4+IC0tLQ0KPj4+PiBkcml2ZXJzL3BlcmYvcmlzY3ZfcG11X3NiaS5jIHwgMTQgLS0tLS0tLS0t
LS0tLS0NCj4+Pj4gMSBmaWxlIGNoYW5nZWQsIDE0IGRlbGV0aW9ucygtKQ0KPj4+Pg0KPj4+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9wZXJmL3Jpc2N2X3BtdV9zYmkuYyBiL2RyaXZlcnMvcGVyZi9y
aXNjdl9wbXVfc2JpLmMNCj4+Pj4gaW5kZXggZTdjNmZlY2JmMDYxLi42ZjY2ODFiYmZkMzYgMTAw
NjQ0DQo+Pj4+IC0tLSBhL2RyaXZlcnMvcGVyZi9yaXNjdl9wbXVfc2JpLmMNCj4+Pj4gKysrIGIv
ZHJpdmVycy9wZXJmL3Jpc2N2X3BtdV9zYmkuYw0KPj4+PiBAQCAtNDEsMjAgKzQxLDYgQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBhdHRyaWJ1dGVfZ3JvdXAgKnJpc2N2X3BtdV9hdHRyX2dyb3Vwc1td
ID0gew0KPj4+PiDCoMKgwqDCoMKgwqAgTlVMTCwNCj4+Pj4gfTsNCj4+Pj4NCj4+Pj4gLXVuaW9u
IHNiaV9wbXVfY3RyX2luZm8gew0KPj4+PiAtwqDCoMKgwqAgdW5zaWduZWQgbG9uZyB2YWx1ZTsN
Cj4+Pj4gLcKgwqDCoMKgIHN0cnVjdCB7DQo+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
dW5zaWduZWQgbG9uZyBjc3I6MTI7DQo+Pj4+IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdW5z
aWduZWQgbG9uZyB3aWR0aDo2Ow0KPj4+PiAtI2lmIF9fcmlzY3ZfeGxlbiA9PSAzMg0KPj4+PiAt
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgcmVzZXJ2ZWQ6MTM7DQo+Pj4+
IC0jZWxzZQ0KPj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgcmVz
ZXJ2ZWQ6NDU7DQo+Pj4+IC0jZW5kaWYNCj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1
bnNpZ25lZCBsb25nIHR5cGU6MTsNCj4+Pj4gLcKgwqDCoMKgIH07DQo+Pj4+IC19Ow0KPj4+PiAt
DQo+Pj4+IC8qDQo+Pj4+IMKgICogUklTQy1WIGRvZXNuJ3QgaGF2ZSBoZXRlcmdlbm91cyBoYXJ0
cyB5ZXQuIFRoaXMgbmVlZCB0byBiZSBwYXJ0IG9mDQo+Pj4+IMKgICogcGVyX2NwdSBpbiBjYXNl
IG9mIGhhcnRzIHdpdGggZGlmZmVyZW50IHBtdSBjb3VudGVycw0KPiANCj4gQXRpc2gganVzdCBw
b2tlZCBtZSBhYm91dCB0aGlzIGFzIEkgd2FzIHRhZ2dpbmcgbXkgUFIsIEkgc3F1YXNoZWQgaXQg
aW4uDQo+IEkgZG9uJ3Qgc2VlIGEgbWVzc2FnZSBvbiBsb3JlLCBub3Qgc3VyZSBpZiBzb21ldGhp
bmcgd2VudCBvZmYgdGhlIHJhaWxzDQo+IG9yIGlmIGl0J3MganVzdCBpbiB0aGUgb3V0Ym94IG9u
IG15IGJveCBhdCBob21lLg0KDQpJIGFzc3VtZSBzdHVjayBpbiB0aGUgb3V0Ym94LiBJIGNoZWNr
ZWQgb3V0IGZvci1uZXh0IGFmdGVyIEkgZ290IGhvbWUNCmZyb20gd29yayBhbmQgdGhlIGVycm9y
IHdhcyBnb25lIHNvIEkgYXNzdW1lZCB5b3UnZCBkb25lIHNvLg0KDQo6KQ0K
