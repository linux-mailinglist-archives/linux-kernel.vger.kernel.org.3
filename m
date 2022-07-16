Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46B1F576E85
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 16:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbiGPOZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 10:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbiGPOZC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 10:25:02 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 033721EADE
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 07:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1657981500; x=1689517500;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KyAdgc6L0erXUe/NNIJu/yMhL2O7lUnGL9UICrW0yxE=;
  b=rFoaF3oyMj0eXFQtTGz0Y3QyYCybXQV8gcCSBNguGZ84i47VoR8wYAd3
   Ixb2cBircCQh9D/0663v3MDGh9XRxqUkBt1hlGGB0Yy4PY7IYB4vPjrf0
   nCSvAeEiR/y3cuOFvA9Cl3p5ZQUuzguDZTX9ak966GmtjWbdx/l+OeM5w
   xbL/HWm57Lid/YR9VAMEzh440knmYv04xD5RWuk7lNbvoQIA1RuUz7s4X
   /MUDKHRL85ileJ35+xE9ZJ+O3fRj3TPhlGJEvOzBtA4qBJ4y/X4PBzaQ5
   h1siTKnasXxBfuKulXH6CskxffmqMD2CUWdVtVs6h/D0jS0Z0gZuMnMMw
   Q==;
X-IronPort-AV: E=Sophos;i="5.92,277,1650956400"; 
   d="scan'208";a="182468151"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Jul 2022 07:25:00 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sat, 16 Jul 2022 07:24:59 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Sat, 16 Jul 2022 07:24:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UbOmEvoNJt8JoG+EvTVkm75siuNeWhcEWlsPSXmp9M/BYBrwOGYHennH8Shri2e78uS3fiO+TbDq6YGVJ58Ikho7jljguFTnIjdVmOFbCCEIxvnxn2QUQp2rw3ytL1Ci3ius/Oi7sqZR9vveiFfPD3yFjv5gdtWnWA5PkE0HTTciEebDN/ltfZVcIlsz9+DMmK45ESjYEuz/BFWy6g4j2y9gHYciKVtvkiaPfAd1fBoVqsVYz97g/ISoWD2vVItToCVV8slxiSs7IU0113DNus+eB33dDvc+A48LWay7Dh8l1gUjTdhKUcPoklVFPilpvM/BlsdgFQ20ANzELxURMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KyAdgc6L0erXUe/NNIJu/yMhL2O7lUnGL9UICrW0yxE=;
 b=IWjEYrZ+j5DKsJAlcFsTeEeUnIZWZb3o6C1ILD1aJBtXd3zczT9o6cS8zrmhWlPA3yOe4lF8HEsc+rOdDwrkU9yDKL5HAc62wwwJPX/igctwmQBE0yLvSDPE8TjFbvCYY5EsjZTVal86CF1RbLkcBLllaCnSPW+/AFjVWMkKTUxyxRyGQwcPuroSU3qz1FeUcTHedgTZbzeGQ3o8pyRfdUK6EtWzuI7E35lvzQPFs7/JUFM42OvI/ZACUlo25yihdcd2HcymJa4VUmPofeRNc5N/z0s7+dF+GZ80RhXlcueLAcGUfY2xG8/EEfx5VldigX4UX0t0L51aeCwqqGk+5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KyAdgc6L0erXUe/NNIJu/yMhL2O7lUnGL9UICrW0yxE=;
 b=mX+xQfLaImclwC8P1YPWCQ3dahEOLTbLtDY2Yn4CD58uT7bCSwjEBPL9bItH21x/U68dzNtJrADBE5KFazBOEuwG1FJxaSf2dkpb8t4FMJUFwJTcN/cEGc1fcbnKQxMWdgbCSOtgfoZFJmJWFgLJUa7t3ToGPXDsY2lH39vVVpA=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM5PR11MB1530.namprd11.prod.outlook.com (2603:10b6:4:c::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5417.25; Sat, 16 Jul 2022 14:24:54 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::357a:acc9:829e:bf7b%7]) with mapi id 15.20.5438.021; Sat, 16 Jul 2022
 14:24:54 +0000
From:   <Conor.Dooley@microchip.com>
To:     <heiko@sntech.de>, <palmer@dabbelt.com>, <daolu@rivosinc.com>
CC:     <linux-kernel@vger.kernel.org>, <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>, <atishp@atishpatra.org>,
        <anup@brainfault.org>, <guoren@kernel.org>, <jszhang@kernel.org>,
        <rdunlap@infradead.org>, <niklas.cassel@wdc.com>,
        <panqinglin2020@iscas.ac.cn>, <alexandre.ghiti@canonical.com>,
        <robh@kernel.org>, <research_trasio@irq.a4lg.com>,
        <yury.norov@gmail.com>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH v4] arch/riscv: add Zihintpause support
Thread-Topic: [PATCH v4] arch/riscv: add Zihintpause support
Thread-Index: AQHYhOesbS0PbUe670SvwueJS2HLKa15xC+AgAdt8oCAAAOwgA==
Date:   Sat, 16 Jul 2022 14:24:54 +0000
Message-ID: <2cbafe81-d919-8cb7-d0ad-d7ed01556bf9@microchip.com>
References: <20220620201530.3929352-1-daolu@rivosinc.com>
 <18a1126c-393e-9c52-4b30-caee01975ad1@conchuod.ie> <8823276.lOV4Wx5bFT@phil>
In-Reply-To: <8823276.lOV4Wx5bFT@phil>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d1290c2-9d3b-449f-ee9e-08da6736f3b4
x-ms-traffictypediagnostic: DM5PR11MB1530:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kDmCTcNUKBMYRbmb27KqIxV5ynnT5PSh9bKvwbr406Shc196fgZKhjmUnmyVN63IIOFUp9I4bLiIZvoEABqDwA0OiSqdkPZcq14J5Myn7pU/UeuzyrIvlk/++ZWtOSjYXq0+q+jhwRQ2AECUNvzpg9a9enesS+pDq97YhZafNXv8+dBi5nFsZ7HujY7FZTzMFKHIAtVuZkiU5sUeUljGOFYgB8UT1t7OmlcCCNq3N4+vlAOaFTgYMpl7ndqezKKVzR11Ilr4ufcPvnr6u0ZAuiPj7Rr5h8+CNZdMtxlolbKtzLqMVoVJm5xxD/GcS2MUTKn7DYptKNLj1wSRAOySHe24D82r77XmwPL+rRMSVjIF7W1YxvlHPTuh06k5t1wIeNkrhbUWLkQTNFchYWi8EjwhpCywtKZdVEywZmfJTudwZwi9V1WMkZAKJWn3079R2Ctk2cLbfyt+e2bS6bgCq4ewjS6VoPLvOrjNBkJDKGVuWy0ay967FxxyYg3zbyLI11FDQwcamgoY6FqeD3NKdNHfroYI8I7UWwwYi9bikbdRwQvTId4Wxuc27McwMj4PhclCQ1An2On0g8CtzfreYsXE8LNGpTE4Vib5M/0SCgiVjiT37Ax0lHJn5irlYizd6dVEzNqwD8aiEpk3Iq6yEo9pk7KaEcqTapAiXyzRXBnPUCErVUq9h+sNL8hRwaL5mqd6Wnl+5vojSgxRBTfNW05Av73vMMidEnDaQBysBy2roRCAfwMWgyjhsO0peM9xGwP7JIotRwDg+L3bLPf+7/lXYApTqh+lonSCDG9JPwvEa5XvM7j9yC9XLk0suaMKAwhQ4TjnyAK+jgyvGf5LTlC8QuMR8WK8RS1f7aHERq5gCcBxn4htHzv70mVHd4gD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(376002)(396003)(136003)(366004)(7416002)(478600001)(122000001)(36756003)(2906002)(66946007)(2616005)(38070700005)(6486002)(41300700001)(6506007)(8936002)(31686004)(76116006)(54906003)(66476007)(31696002)(64756008)(5660300002)(316002)(8676002)(53546011)(83380400001)(4326008)(6512007)(66556008)(186003)(26005)(38100700002)(91956017)(71200400001)(110136005)(66446008)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K1YxRGVPYUlabjdOZ2VzeEx4ZzI2bVd6VU9FQnNaQUxKVmRiOXVjOFBWV1VC?=
 =?utf-8?B?cm00SFozbEk3ekJMV1gxUHpEM25kN0pQbUpNQVFYOFc3R1o1LzdhK2pVYU40?=
 =?utf-8?B?M2RhZnljK0tyWTd2dmNPWlBoRVA5Q1Rnd0pJNndlYzZzV0NsMmVvUy9DRWJm?=
 =?utf-8?B?VzNlVUVPbGpzSFF4S3dxdlNWMWM4emIxQ1lUZWNhejhUV1QzckcrTU1ZMkYr?=
 =?utf-8?B?cXJtbS9wSmNsRXZuOUh0SEN3Y1ozTmkyWVJobjF2MWRONGZRSXNTcEF2UUpS?=
 =?utf-8?B?dXFXZ0IyOEVDN3E2ZTdFUW0veFI4c2grS2J0aFV6YWZTcWtyN3NoRjJrMERz?=
 =?utf-8?B?RGdBaWQ4YkFCYmNBb2xYOWgybTV2dmgwL2I0eWRadUJXQ3ZrT3JFS01iNkNx?=
 =?utf-8?B?cTZBOVRBTTA0Ny9tKzkzWEkyV1U5V2UyTmh1bExoeDh2SVNJRXpsL1RZOEFs?=
 =?utf-8?B?MXhCYmtZV0IwKy9NTzd5NzU3ck8yQXVNL095N01aVXNVQjFuQXZhMm8rcDcx?=
 =?utf-8?B?bkppZzBKUmVKc2JTN0oxbUpmam1NUWMweW5DV3JEeGw5S3JGY0VheGZaYUgr?=
 =?utf-8?B?eTdYU0pQTmJWZ0ZSU05jU0x3bnJwbndmeDJOL3AySjNGelFZM0ZjalVUUnVS?=
 =?utf-8?B?aGxXejROTDhSbStpcU1xci9tc0xpVVdrOFJhcTh6R2drUHgvTGRORUM5SThh?=
 =?utf-8?B?UWxiNFY4WE5EVlljZTJIa21DblFabHgxdE5yWWFjWTBZVC9xckRnLzdQdGN1?=
 =?utf-8?B?a3dSQm44NkhJZkdEU3NjenFWQnpXOUYyOUJSQWxITUFwV3RpUzR2UllNWFRz?=
 =?utf-8?B?MHR4azlzblBVQ3BEaWc5cUVPQjMyM28xV0M1QzcyN2JhMVV1TGFsbGZoQ2ZI?=
 =?utf-8?B?T09YQkRMdElhNVhubzBhTnZSTThKcUl5OVNJeWRkVkFrcGEyYUJqMkFKaHNZ?=
 =?utf-8?B?Z2JXQ0t6cDMzeHdTekh6MFV5ZDBUQmgvTUpYbXdkNnQ1SnZjV0FrOUNCUTVh?=
 =?utf-8?B?YmNFMU0yWjdWYnBEa3NkR0JNZitYZDZaaFVMc3lDWHRJeVhQekwwZHczNmRn?=
 =?utf-8?B?UFQweGNieXNGUHFpVjZwcFJRNm1wSGRXbFVaUmMzOURSU0ZadjIvajRMY2lo?=
 =?utf-8?B?cXU4VjJJVXpocXMwa2tyUkFyaTdzTmk1ZHVmVkk4MDhML01EVTN0UzF3NTI0?=
 =?utf-8?B?MHI4bzdYeExlbGlLYzRzUmNlaEhsTnV6aWVwTWd0NE4reXh2ZkRGRStZeUdw?=
 =?utf-8?B?R29CSC9mbmVoV3hkWVJyMGtvcE1CbTRSVTR2UjZ1cHdaWG54a0s1ZlJjNDEr?=
 =?utf-8?B?WW9SMVNPMG5pOEdJaDgvdGk5V1JiUGhwc3NkQXhxTG1LR2VMdHVadFZZU09O?=
 =?utf-8?B?U0ZsZ3U3Z2dSeU5GeG1lVTBWM0pKWmtSUytreG1jTU9TSmlJQzR5WWpIQ0ZT?=
 =?utf-8?B?WUt3dlEvUUxkTGIvNVQrM1BMdnJyUWVISGJJeFdIMy9LT0pxRlVIRWp0dzVv?=
 =?utf-8?B?L3NtT0h6QWozOEZTbU5oVWlxeXVCRVVLRWVVc1krcmtKRXVZcGQrbVJFOHRS?=
 =?utf-8?B?eWxHOTl3OTVGY2RnZTV5N3cvVE1zb2RUMzN0UzV0cWIwdHlDRVhTaHNlTWhx?=
 =?utf-8?B?SlVKcGJmalZDUlNsY0E2OEMwMG1XaGdCRUR2ZVFTOU1OTTdaOEdPdzhwdTNv?=
 =?utf-8?B?V2lOWWZkL0pQTTIyaHVyRlNHOTNZcDg2SXRnV3BsK0JLNUJpSFNZclpzS3VM?=
 =?utf-8?B?UmRZbXBtRkdxRGtPNVhEb1dtNDV2V2NGc3dwazgwR2txeHArbTZZR3Z3eC8x?=
 =?utf-8?B?VXVOWG9Ja20zTEExUGJ6cWRCK0I1Lyt2ZFFmYk1td2FGbEFUK3FaUXJYYlZG?=
 =?utf-8?B?d1JMbGRBREthS2xUQzZWemtQZVo4RDJRb0RQd2NocTZmcjFSTVhtbHNzWE1T?=
 =?utf-8?B?Y0VxdWRhSkdHQkdCemNrN3JZZDcyQzFLUHBOdStlL0c2T1hDTnlXSDYvc20z?=
 =?utf-8?B?OTZ6eFZjUEUzUDkyeS9aRGt0c2h1alV1cGhrdkNlRUR2S0dVVVJ1VlV5b0p0?=
 =?utf-8?B?OUIyYzlXYlJEOUhGT3dOYmJqNTE1VlF5ZXlzdkQydzhlL1lnaldJWm1sUWVy?=
 =?utf-8?Q?COyYKvfVADgAowE0J4Zot1NpD?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4E1B2EE8D2FDF4CB520881FF3BF21BD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d1290c2-9d3b-449f-ee9e-08da6736f3b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2022 14:24:54.0806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RkUVfso5ZC5MbH30CmuYZ3t1ZM1zjw1by9GzBt5a7dS/2mJTd0lsVMrGlOJtSsEaH3hdXrTsUXTX0G/lidZyPkVhAMx3kMwpmEEzMpck7pY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1530
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTYvMDcvMjAyMiAxNToxMSwgSGVpa28gU3R1ZWJuZXIgd3JvdGU6DQo+IEFtIE1vbnRhZywg
MTEuIEp1bGkgMjAyMiwgMjI6NDQ6MjEgQ0VTVCBzY2hyaWViIENvbm9yIERvb2xleToNCj4+IE9u
IDIwLzA2LzIwMjIgMjE6MTUsIERhbyBMdSB3cm90ZToNCj4+PiBbUEFUQ0ggdjRdIGFyY2gvcmlz
Y3Y6IGFkZCBaaWhpbnRwYXVzZSBzdXBwb3J0DQo+Pg0KPj4gQSBsaXR0bGUgb3JuZXJ5L3BlZGFu
dGljIG1heWJlLCBidXQgdGhlICJhcmNoLyIgaXNuJ3QgbmVlZGVkLg0KPj4gR3Vlc3MgaXQgY2Fu
IGVhc2lseSBiZSBmaXhlZCBvbiBhcHBsaWNhdGlvbiBvciBpZiB0aGVyZSdzIGENCj4+IHY1IHNv
IHRoZXJlJ3MgcHJvYiBubyBuZWVkIHRvIHJlc2VuZC4NCj4gDQo+IEkgbm90aWNlZCB0aGF0IHRo
ZSBwYXRjaCBwcmVmaXggb24gcmlzY3YgaXMgYWxsIG92ZXIgdGhlIHBsYWNlDQo+IGluIGEgbG90
IG9mIGNhc2VzLiBUaGVyZSBhcmUNCj4gDQo+IC0gUklTQy1WOg0KPiAtcmlzY3Y6DQo+IC0gbm93
IGFyY2gvcmlzY3Y6DQo+IA0KPiBhbmQgcHJvYmFibHkgZXZlbiBtb3JlLg0KPiANCj4gSSBndWVz
cyBzb21lb25lIHNob3VsZCBqdXN0IGRlY2lkZSBvbiBvbmUgcHJlZml4IHRoYXQgdGhlbg0KPiBn
ZXRzIHVzZWQgKGFuZCBzbGlnaHRseSBlbmZvcmNlZCkgYWxsIHRoZSB0aW1lLg0KDQpZZWFoLCBJ
IGRpZCBzZWUgUGFsbWVyIGNvbW1lbnRpbmcgb24gUklTQy1WL3Jpc2N2IG9uY2UuDQpJIHRoaW5r
IHJpc2N2IGlzIG1vcmUgY29tbW9uIHNpbmNlIGl0IG1hdGNoZXMgdGhlIGFyY2ggZGlyZWN0b3J5
DQpidXQgUGFsbWVyIGhpbXNlbGYgdXNlcyBSSVNDLVYNCg0KSSd2ZSBzZWVuIHBhdGNoc2V0cyB0
aGF0IHVzZSBib3RoIFJJU0MtViBhbmQgcmlzY3YgaGFoYQ0KDQpNYXliZSBpdCBpcyB0aW1lIHRv
IHBpY2sgb25lPyBQYWxtZXI/DQoNCj4gDQo+IEV2ZW4ganVzdCBtb2RpZnlpbmcgYXBwbGllZCBw
YXRjaGVzIHRvIG9uZSBzcGVjaWZpYyBwcmVmaXggc2hvdWxkDQo+IGFscmVhZHkgc29sdmUgdGhl
IGlzc3VlIGluIGEgc2hvcnQgdGltZSwgYXMgSSBndWVzcyBtb3N0IHBlb3BsZSB3aWxsDQo+IGp1
c3QgZ2V0IHRoZSBhcHBpY2FibGUgcHJlZml4IGZyb20gYSAiZ2l0IGxvZyIgOy0pIC4NCg0KQWdh
aW4sIHRoYXQncyBkb3duIHRvIFBhbG1lciAoYW5kIG5vdyBtZSBJIGd1ZXNzIHRvIGEgbGVzc2Vy
IGV4dGVudA0KZ2l2ZW4gSSd2ZSBzdGFydGluZyBkb2luZyBQUnMpLg0KDQpNeSBPQ0Qgd291bGQg
bGlrZSBhIHNpbmdsZSBwcmVmaXggdGhvdWdoIDspDQpDb25vci4NCg0KPiANCj4gDQo+IEhlaWtv
DQo+IA0KPj4+IEltcGxlbWVudCBzdXBwb3J0IGZvciB0aGUgWmlIaW50UGF1c2UgZXh0ZW5zaW9u
Lg0KPj4+DQo+Pj4gVGhlIFBBVVNFIGluc3RydWN0aW9uIGlzIGEgSElOVCB0aGF0IGluZGljYXRl
cyB0aGUgY3VycmVudCBoYXJ04oCZcyByYXRlDQo+Pj4gb2YgaW5zdHJ1Y3Rpb24gcmV0aXJlbWVu
dCBzaG91bGQgYmUgdGVtcG9yYXJpbHkgcmVkdWNlZCBvciBwYXVzZWQuDQo+Pj4NCj4+PiBSZXZp
ZXdlZC1ieTogSGVpa28gU3R1ZWJuZXIgPGhlaWtvQHNudGVjaC5kZT4NCj4+PiBUZXN0ZWQtYnk6
IEhlaWtvIFN0dWVibmVyIDxoZWlrb0BzbnRlY2guZGU+DQo+Pj4gU2lnbmVkLW9mZi1ieTogRGFv
IEx1IDxkYW9sdUByaXZvc2luYy5jb20+DQo+Pj4gLS0tDQo+Pj4NCj4+PiB2MSAtPiB2MjoNCj4+
PiAgUmVtb3ZlIHRoZSB1c2FnZSBvZiBzdGF0aWMgYnJhbmNoLCB1c2UgUEFVU0UgaWYgdG9vbGNo
YWluIHN1cHBvcnRzIGl0DQo+Pj4gdjIgLT4gdjM6DQo+Pj4gIEFkZGVkIHRoZSBzdGF0aWMgYnJh
bmNoIGJhY2ssIGNwdV9yZWxheCgpIGJlaGF2aW9yIGlzIGtlcHQgdGhlIHNhbWUgZm9yDQo+Pj4g
c3lzdGVtcyB0aGF0IGRvIG5vdCBzdXBwb3J0IFppSGludFBhdXNlDQo+Pj4gdjMgLT4gdjQ6DQo+
Pj4gIEFkb3B0ZWQgdGhlIG5ld2x5IGFkZGVkIHVuaWZpZWQgc3RhdGljIGtleXMgZm9yIGV4dGVu
c2lvbnMNCj4+PiAtLS0NCj4+PiAgYXJjaC9yaXNjdi9NYWtlZmlsZSAgICAgICAgICAgICAgICAg
ICAgIHwgIDQgKysrKw0KPj4+ICBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2h3Y2FwLmggICAgICAg
ICAgfCAgNSArKysrKw0KPj4+ICBhcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL3Zkc28vcHJvY2Vzc29y
LmggfCAyMSArKysrKysrKysrKysrKysrKystLS0NCj4+PiAgYXJjaC9yaXNjdi9rZXJuZWwvY3B1
LmMgICAgICAgICAgICAgICAgIHwgIDEgKw0KPj4+ICBhcmNoL3Jpc2N2L2tlcm5lbC9jcHVmZWF0
dXJlLmMgICAgICAgICAgfCAgMSArDQo+Pj4gIDUgZmlsZXMgY2hhbmdlZCwgMjkgaW5zZXJ0aW9u
cygrKSwgMyBkZWxldGlvbnMoLSkNCj4+Pg0KPj4+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L01h
a2VmaWxlIGIvYXJjaC9yaXNjdi9NYWtlZmlsZQ0KPj4+IGluZGV4IDM0Y2Y4YTU5ODYxNy4uNmRk
YWNjNmY0NGI5IDEwMDY0NA0KPj4+IC0tLSBhL2FyY2gvcmlzY3YvTWFrZWZpbGUNCj4+PiArKysg
Yi9hcmNoL3Jpc2N2L01ha2VmaWxlDQo+Pj4gQEAgLTU2LDYgKzU2LDEwIEBAIHJpc2N2LW1hcmNo
LSQoQ09ORklHX1JJU0NWX0lTQV9DKQk6PSAkKHJpc2N2LW1hcmNoLXkpYw0KPj4+ICB0b29sY2hh
aW4tbmVlZC16aWNzci16aWZlbmNlaSA6PSAkKGNhbGwgY2Mtb3B0aW9uLXluLCAtbWFyY2g9JChy
aXNjdi1tYXJjaC15KV96aWNzcl96aWZlbmNlaSkNCj4+PiAgcmlzY3YtbWFyY2gtJCh0b29sY2hh
aW4tbmVlZC16aWNzci16aWZlbmNlaSkgOj0gJChyaXNjdi1tYXJjaC15KV96aWNzcl96aWZlbmNl
aQ0KPj4+ICANCj4+PiArIyBDaGVjayBpZiB0aGUgdG9vbGNoYWluIHN1cHBvcnRzIFppaGludHBh
dXNlIGV4dGVuc2lvbg0KPj4+ICt0b29sY2hhaW4tc3VwcG9ydHMtemloaW50cGF1c2UgOj0gJChj
YWxsIGNjLW9wdGlvbi15biwgLW1hcmNoPSQocmlzY3YtbWFyY2gteSlfemloaW50cGF1c2UpDQo+
Pj4gK3Jpc2N2LW1hcmNoLSQodG9vbGNoYWluLXN1cHBvcnRzLXppaGludHBhdXNlKSA6PSAkKHJp
c2N2LW1hcmNoLXkpX3ppaGludHBhdXNlDQo+Pj4gKw0KPj4+ICBLQlVJTERfQ0ZMQUdTICs9IC1t
YXJjaD0kKHN1YnN0IGZkLCwkKHJpc2N2LW1hcmNoLXkpKQ0KPj4+ICBLQlVJTERfQUZMQUdTICs9
IC1tYXJjaD0kKHJpc2N2LW1hcmNoLXkpDQo+Pj4gIA0KPj4+IGRpZmYgLS1naXQgYS9hcmNoL3Jp
c2N2L2luY2x1ZGUvYXNtL2h3Y2FwLmggYi9hcmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2h3Y2FwLmgN
Cj4+PiBpbmRleCBlNDhlZWJkZDI2MzEuLmRjNDcwMTlhMGIzOCAxMDA2NDQNCj4+PiAtLS0gYS9h
cmNoL3Jpc2N2L2luY2x1ZGUvYXNtL2h3Y2FwLmgNCj4+PiArKysgYi9hcmNoL3Jpc2N2L2luY2x1
ZGUvYXNtL2h3Y2FwLmgNCj4+PiBAQCAtOCw2ICs4LDcgQEANCj4+PiAgI2lmbmRlZiBfQVNNX1JJ
U0NWX0hXQ0FQX0gNCj4+PiAgI2RlZmluZSBfQVNNX1JJU0NWX0hXQ0FQX0gNCj4+PiAgDQo+Pj4g
KyNpbmNsdWRlIDxhc20vZXJybm8uaD4NCj4+PiAgI2luY2x1ZGUgPGxpbnV4L2JpdHMuaD4NCj4+
PiAgI2luY2x1ZGUgPHVhcGkvYXNtL2h3Y2FwLmg+DQo+Pj4gIA0KPj4+IEBAIC01NCw2ICs1NSw3
IEBAIGV4dGVybiB1bnNpZ25lZCBsb25nIGVsZl9od2NhcDsNCj4+PiAgZW51bSByaXNjdl9pc2Ff
ZXh0X2lkIHsNCj4+PiAgCVJJU0NWX0lTQV9FWFRfU1NDT0ZQTUYgPSBSSVNDVl9JU0FfRVhUX0JB
U0UsDQo+Pj4gIAlSSVNDVl9JU0FfRVhUX1NWUEJNVCwNCj4+PiArCVJJU0NWX0lTQV9FWFRfWklI
SU5UUEFVU0UsDQo+Pj4gIAlSSVNDVl9JU0FfRVhUX0lEX01BWCA9IFJJU0NWX0lTQV9FWFRfTUFY
LA0KPj4+ICB9Ow0KPj4+ICANCj4+PiBAQCAtNjQsNiArNjYsNyBAQCBlbnVtIHJpc2N2X2lzYV9l
eHRfaWQgew0KPj4+ICAgKi8NCj4+PiAgZW51bSByaXNjdl9pc2FfZXh0X2tleSB7DQo+Pj4gIAlS
SVNDVl9JU0FfRVhUX0tFWV9GUFUsCQkvKiBGb3IgJ0YnIGFuZCAnRCcgKi8NCj4+PiArCVJJU0NW
X0lTQV9FWFRfS0VZX1pJSElOVFBBVVNFLA0KPj4+ICAJUklTQ1ZfSVNBX0VYVF9LRVlfTUFYLA0K
Pj4+ICB9Ow0KPj4+ICANCj4+PiBAQCAtODMsNiArODYsOCBAQCBzdGF0aWMgX19hbHdheXNfaW5s
aW5lIGludCByaXNjdl9pc2FfZXh0MmtleShpbnQgbnVtKQ0KPj4+ICAJCXJldHVybiBSSVNDVl9J
U0FfRVhUX0tFWV9GUFU7DQo+Pj4gIAljYXNlIFJJU0NWX0lTQV9FWFRfZDoNCj4+PiAgCQlyZXR1
cm4gUklTQ1ZfSVNBX0VYVF9LRVlfRlBVOw0KPj4+ICsJY2FzZSBSSVNDVl9JU0FfRVhUX1pJSElO
VFBBVVNFOg0KPj4+ICsJCXJldHVybiBSSVNDVl9JU0FfRVhUX0tFWV9aSUhJTlRQQVVTRTsNCj4+
PiAgCWRlZmF1bHQ6DQo+Pj4gIAkJcmV0dXJuIC1FSU5WQUw7DQo+Pj4gIAl9DQo+Pj4gZGlmZiAt
LWdpdCBhL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vdmRzby9wcm9jZXNzb3IuaCBiL2FyY2gvcmlz
Y3YvaW5jbHVkZS9hc20vdmRzby9wcm9jZXNzb3IuaA0KPj4+IGluZGV4IDEzNDM4OGNiYWFhMS4u
MWU0ZjhiNGFlZjc5IDEwMDY0NA0KPj4+IC0tLSBhL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vdmRz
by9wcm9jZXNzb3IuaA0KPj4+ICsrKyBiL2FyY2gvcmlzY3YvaW5jbHVkZS9hc20vdmRzby9wcm9j
ZXNzb3IuaA0KPj4+IEBAIC00LDE1ICs0LDMwIEBADQo+Pj4gIA0KPj4+ICAjaWZuZGVmIF9fQVNT
RU1CTFlfXw0KPj4+ICANCj4+PiArI2luY2x1ZGUgPGxpbnV4L2p1bXBfbGFiZWwuaD4NCj4+PiAg
I2luY2x1ZGUgPGFzbS9iYXJyaWVyLmg+DQo+Pj4gKyNpbmNsdWRlIDxhc20vaHdjYXAuaD4NCj4+
PiAgDQo+Pj4gIHN0YXRpYyBpbmxpbmUgdm9pZCBjcHVfcmVsYXgodm9pZCkNCj4+PiAgew0KPj4+
ICsJaWYgKCFzdGF0aWNfYnJhbmNoX2xpa2VseSgmcmlzY3ZfaXNhX2V4dF9rZXlzW1JJU0NWX0lT
QV9FWFRfS0VZX1pJSElOVFBBVVNFXSkpIHsNCj4+PiAgI2lmZGVmIF9fcmlzY3ZfbXVsZGl2DQo+
Pj4gLQlpbnQgZHVtbXk7DQo+Pj4gLQkvKiBJbiBsaWV1IG9mIGEgaGFsdCBpbnN0cnVjdGlvbiwg
aW5kdWNlIGEgbG9uZy1sYXRlbmN5IHN0YWxsLiAqLw0KPj4+IC0JX19hc21fXyBfX3ZvbGF0aWxl
X18gKCJkaXYgJTAsICUwLCB6ZXJvIiA6ICI9ciIgKGR1bW15KSk7DQo+Pj4gKwkJaW50IGR1bW15
Ow0KPj4+ICsJCS8qIEluIGxpZXUgb2YgYSBoYWx0IGluc3RydWN0aW9uLCBpbmR1Y2UgYSBsb25n
LWxhdGVuY3kgc3RhbGwuICovDQo+Pj4gKwkJX19hc21fXyBfX3ZvbGF0aWxlX18gKCJkaXYgJTAs
ICUwLCB6ZXJvIiA6ICI9ciIgKGR1bW15KSk7DQo+Pj4gICNlbmRpZg0KPj4+ICsJfSBlbHNlIHsN
Cj4+PiArCQkvKg0KPj4+ICsJCSAqIFJlZHVjZSBpbnN0cnVjdGlvbiByZXRpcmVtZW50Lg0KPj4+
ICsJCSAqIFRoaXMgYXNzdW1lcyB0aGUgUEMgY2hhbmdlcy4NCj4+PiArCQkgKi8NCj4+PiArI2lm
ZGVmIF9fcmlzY3ZfemloaW50cGF1c2UNCj4+PiArCQlfX2FzbV9fIF9fdm9sYXRpbGVfXyAoInBh
dXNlIik7DQo+Pj4gKyNlbHNlDQo+Pj4gKwkJLyogRW5jb2Rpbmcgb2YgdGhlIHBhdXNlIGluc3Ry
dWN0aW9uICovDQo+Pj4gKwkJX19hc21fXyBfX3ZvbGF0aWxlX18gKCIuNGJ5dGUgMHgxMDAwMDBG
Iik7DQo+Pj4gKyNlbmRpZg0KPj4+ICsJfQ0KPj4+ICAJYmFycmllcigpOw0KPj4+ICB9DQo+Pj4g
IA0KPj4+IGRpZmYgLS1naXQgYS9hcmNoL3Jpc2N2L2tlcm5lbC9jcHUuYyBiL2FyY2gvcmlzY3Yv
a2VybmVsL2NwdS5jDQo+Pj4gaW5kZXggZmJhOWU5ZjQ2YThjLi5hMTIzZTkyYjE0ZGQgMTAwNjQ0
DQo+Pj4gLS0tIGEvYXJjaC9yaXNjdi9rZXJuZWwvY3B1LmMNCj4+PiArKysgYi9hcmNoL3Jpc2N2
L2tlcm5lbC9jcHUuYw0KPj4+IEBAIC04OSw2ICs4OSw3IEBAIGludCByaXNjdl9vZl9wYXJlbnRf
aGFydGlkKHN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZSkNCj4+PiAgc3RhdGljIHN0cnVjdCByaXNj
dl9pc2FfZXh0X2RhdGEgaXNhX2V4dF9hcnJbXSA9IHsNCj4+PiAgCV9fUklTQ1ZfSVNBX0VYVF9E
QVRBKHNzY29mcG1mLCBSSVNDVl9JU0FfRVhUX1NTQ09GUE1GKSwNCj4+PiAgCV9fUklTQ1ZfSVNB
X0VYVF9EQVRBKHN2cGJtdCwgUklTQ1ZfSVNBX0VYVF9TVlBCTVQpLA0KPj4+ICsJX19SSVNDVl9J
U0FfRVhUX0RBVEEoemloaW50cGF1c2UsIFJJU0NWX0lTQV9FWFRfWklISU5UUEFVU0UpLA0KPj4+
ICAJX19SSVNDVl9JU0FfRVhUX0RBVEEoIiIsIFJJU0NWX0lTQV9FWFRfTUFYKSwNCj4+PiAgfTsN
Cj4+PiAgDQo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvcmlzY3Yva2VybmVsL2NwdWZlYXR1cmUuYyBi
L2FyY2gvcmlzY3Yva2VybmVsL2NwdWZlYXR1cmUuYw0KPj4+IGluZGV4IDFiM2VjNDRlMjVmNS4u
NzA4ZGYyYzBiYzM0IDEwMDY0NA0KPj4+IC0tLSBhL2FyY2gvcmlzY3Yva2VybmVsL2NwdWZlYXR1
cmUuYw0KPj4+ICsrKyBiL2FyY2gvcmlzY3Yva2VybmVsL2NwdWZlYXR1cmUuYw0KPj4+IEBAIC0x
OTgsNiArMTk4LDcgQEAgdm9pZCBfX2luaXQgcmlzY3ZfZmlsbF9od2NhcCh2b2lkKQ0KPj4+ICAJ
CQl9IGVsc2Ugew0KPj4+ICAJCQkJU0VUX0lTQV9FWFRfTUFQKCJzc2NvZnBtZiIsIFJJU0NWX0lT
QV9FWFRfU1NDT0ZQTUYpOw0KPj4+ICAJCQkJU0VUX0lTQV9FWFRfTUFQKCJzdnBibXQiLCBSSVND
Vl9JU0FfRVhUX1NWUEJNVCk7DQo+Pj4gKwkJCQlTRVRfSVNBX0VYVF9NQVAoInppaGludHBhdXNl
IiwgUklTQ1ZfSVNBX0VYVF9aSUhJTlRQQVVTRSk7DQo+Pj4gIAkJCX0NCj4+PiAgI3VuZGVmIFNF
VF9JU0FfRVhUX01BUA0KPj4+ICAJCX0NCj4+DQo+IA0KPiANCj4gDQo+IA0K
