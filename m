Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3E034D6EB3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 13:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbiCLMp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 07:45:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiCLMp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 07:45:57 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4260DFE406;
        Sat, 12 Mar 2022 04:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647089092; x=1678625092;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=S4l8cB7+mqA6d7RUj9g2JJuqoY81zxBUftNuF1Hr3xg=;
  b=gXi9M2VDs0XLIt9z65jpRX6E1sTgyktP2aUT23K5N1/SU2XDwatJGqIN
   XFEPst0HBliHX6EBm7tF4k2DWAjoBVuUnutrFEk1F7GsbcM3dqLqMYVcH
   PRSlHs686n57iLfrkZpk5LOQ/mAfxEV5GnZRyoRZlFm9OT1pR5JOmkupM
   dOyiGAjVFfFztuwYulp7+fR2rjUfw6FgDRYT2jWLsxcNSMcNfypy6Xt/f
   qeIGbX/yvQJGk6dwDp+TsrNxIU8k1zv/YaoCozHty9wXn1XfuGFmq+KTV
   17qo/S1M5a90N/toQcT3OCMS7uxfbe3Y4fIR1QZgLUKP5h06qqaKmq8vF
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10283"; a="255740400"
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="255740400"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2022 04:44:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,175,1643702400"; 
   d="scan'208";a="539365503"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga007.jf.intel.com with ESMTP; 12 Mar 2022 04:44:50 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 12 Mar 2022 04:44:50 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 12 Mar 2022 04:44:49 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Sat, 12 Mar 2022 04:44:49 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Sat, 12 Mar 2022 04:44:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MGbW8JIc7PKfhP5m4QPC8aRP6uiOWRxjqefVSQuD46b8imEglE5XekEEV8MyCkCZYDpj10EExwf4huzVXv8Q5mbmoAOP1muV/2Fou44TAwVzUmVNtKDZjcWM93ULsOjwlgyxRZlnqfoyHsL2aMFG6GtSKy5HRiM49bvaetmC0CMNchTShQhG0b6Sclcui1rHOvJVSblhLi6uJ/ml2FqEoQ8q/qc3KEPUBJkoaUjnssQhdacW4GD77p/wenRYDKAL+UP9d0b96c04lrdh+/GJNIruEI24zps/SSz3bPN8D3aeWbQmc+j/Z7MKnEGEXvfvbgCZAxU/Wev6PYEBrUhBwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S4l8cB7+mqA6d7RUj9g2JJuqoY81zxBUftNuF1Hr3xg=;
 b=T87fCUTZ41kZrWo+n/AfGAnrSDTwbvR8QoNX3wWt3HXZi68yUU+O4jUFP71lE1e173urgFKfB6n6wyc96UHjNtJAtKLo4bO564kbLCKvnn12lRqfOjvb5KhigxIO9STcVUPcPqr0873UTqMs4NA3aQ9JQQPMAdB03aGcsi2BwlqlgjaktvJpL+f9Ii3mUtnO3WRpOpw804gMom9klu+Fs283sAB0Agdr6rxElE7zQZmepqlmB5ioXuUh8fDSlAGpw5t34kBgsrL/FufFSNbBaKCoM6hhryjqQAE+axlEMSmYnEfQ1SwhCBK/IOi1MhgylUrA/OF0VfnzcHxB94bBxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DM6PR11MB3291.namprd11.prod.outlook.com (2603:10b6:5:d::10) by
 BN9PR11MB5560.namprd11.prod.outlook.com (2603:10b6:408:105::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Sat, 12 Mar
 2022 12:44:42 +0000
Received: from DM6PR11MB3291.namprd11.prod.outlook.com
 ([fe80::ad08:5a1c:3a93:c0ac]) by DM6PR11MB3291.namprd11.prod.outlook.com
 ([fe80::ad08:5a1c:3a93:c0ac%7]) with mapi id 15.20.5038.027; Sat, 12 Mar 2022
 12:44:42 +0000
From:   "Rabara, Niravkumar L" <niravkumar.l.rabara@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        "Ang, Tien Sung" <tien.sung.ang@intel.com>,
        "dinguyen@kernel.org" <dinguyen@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] arm64: dts: intel: add device tree for n6010
Thread-Topic: [PATCH] arm64: dts: intel: add device tree for n6010
Thread-Index: AQHYNaTTYL7ZBbp5YUCaOp9jydl6Y6y7p4QAgAAK8vA=
Date:   Sat, 12 Mar 2022 12:44:42 +0000
Message-ID: <DM6PR11MB329136947066E7E380C85ABAA20D9@DM6PR11MB3291.namprd11.prod.outlook.com>
References: <20220312080127.1528190-1-tien.sung.ang@intel.com>
 <2a4bddac-dca3-0e9a-5d84-00dc39b31699@kernel.org>
In-Reply-To: <2a4bddac-dca3-0e9a-5d84-00dc39b31699@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.401.20
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 087b3d4b-8f98-43b8-98c0-08da04261493
x-ms-traffictypediagnostic: BN9PR11MB5560:EE_
x-microsoft-antispam-prvs: <BN9PR11MB556073B838967CE038748B76A20D9@BN9PR11MB5560.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MLIjgYMMM2wisuoKHy392mlk3KfY/UJDsEXz6P6IFRL2vf9ECZaT3GwHxC+ZoMK96Kv9ee3B7CRW8voPyFgb6aAf4KwCOVTZC3a7zHaZIrGSMjtY5Sl0nKQ2QPfk7Q861s7CYTZq3bQtj7CX7kPsKRm5Pz3n66Z9IHqFST1coBLie5/UqAjqrGecu6FQvr4N2AFWbxgRPq7koUSqTL56fOO8QVuHYcaRdo+GjTbzTibfC+u9ssx+T4NzyICiSeqwo1ZCZDNf5nhYKv3gQljDjJtd/b91qs3I2uZlaANsbDia1tEYSWIni3g/hsYwaPfcnWZNj17bUFi9vKEoor1/YEis6JrdA5p3rRS+ax+PMb7tGGqOxWqYHpbLgpe/a2MUANb184mAn26o2O8LkJS5f9ryj56sO0FV/OumvGMLXFv0aQZBV9msG712Ina+X+VZHrgaT5ld0NFdq7zGi+/s6k7O90joXUJy+dJj6fFazCslY4DbgML+sXfom+M9+RJPAX/U+4182inDnERLCuR0LYSU3F712nmeejZPbFXPQmIJqw4jX0A+fuCBl8OBirt+iAUvA9R9JHRAp1Tv+4B4PAukf6jUM3kDyKj//TiJ0NsOQE2Bzg0VWSqqWur6EbrePeeUIvDwm5CUmVu00oNxIhUmvwq0StflXPFTaKGfSyHMoWGQhztbEqchChRmMsLXq9ivk7/fSMjHQRxlY67Tzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3291.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(66946007)(66476007)(76116006)(2906002)(38070700005)(66556008)(64756008)(66446008)(8676002)(9686003)(53546011)(83380400001)(52536014)(33656002)(26005)(5660300002)(4744005)(8936002)(7696005)(6506007)(55016003)(186003)(316002)(122000001)(38100700002)(508600001)(71200400001)(110136005)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dG1sVm9ZeURNRVNTS2VFNXZvRXNtV3BrTHU5VDhvYVRvamZZeE9iTCs4UURX?=
 =?utf-8?B?T3pydVJGKytmY0hhZXhzUGFUS0JyeGhuSzlpZTZmbk9yNTJDSFlPdHNWQmRr?=
 =?utf-8?B?b0tFT2ZnQVBpckY1cEhsSVdQRFU4TVJmeDh4dVlneDVaQVhINEJSMWlwdGlK?=
 =?utf-8?B?Z2dYZDF6U2hQMnR0bExPYktQMEdEL1ppc08ybDJMSmtYcVM3aVQrU0c3Qjh3?=
 =?utf-8?B?bHcva1BmazJlZWhrVmZrck92Yjk3YmgxbFhhWHlUbFduUVBZSTBwSE5CdGFu?=
 =?utf-8?B?Mk1mL2NMQTZyUjV4UzEvM0pxY1BDaHhTbTZKUkhKa1FhMGtQc3gzTmJzMzRn?=
 =?utf-8?B?OTU2dG9PTGF5Z1Nxdk9BVDJWVmxNOEUzbUdidVhZb213eFo2YnpmZnNHbVp4?=
 =?utf-8?B?UnRVQTVjK1hrc3JXQ0N0VDFkcDQrbEtUVUFXZzd4dlFIRmxNZVl4SDJjaE91?=
 =?utf-8?B?d2FKaDE3Ykx1dnNXVmp6WU5vWk83TmFYUndaUjFNcG1JbkladmF4RjVMUjJ6?=
 =?utf-8?B?N0ZYbmFOdGp0RmVrTWl0ZTdabE4zcUUwd2ZiU3VaT05qZWpQem1zbi8xa1dt?=
 =?utf-8?B?YlJPdCs1RXRlQ0pXRmlmeGxMTG5WNFVnTGYvdGxZelJQRU5RZ1RPQy9UTWJh?=
 =?utf-8?B?M2JhMFg4MWx5UDhKaldWcHpOMkdHLzNNQ0FOSHZHYXhNZFpZZjRiSEg0ZUxz?=
 =?utf-8?B?Yzk2WVZ1OU4wK0hVVE1lVXA1SzBzYzUvZFBoeWFWSmdCRWFuT09LeG9IN1N1?=
 =?utf-8?B?T0RVWDdRVFBsTXhnSkJVN3BkN0g3MXE3bFB6QlZEMDM4ZEZDZmJrUXhhM1dC?=
 =?utf-8?B?dXVUaWlSaFAwSC9RWXNweHhJc0d5SFQ0Ym9BTVFpY3RjWTE0S1hvSkJOSHZ3?=
 =?utf-8?B?UStaZ1RFT0dyZEZ4ZlFpM2tIUVpOOTBFN1BuSWZHVTdWWGZnbUpaL2VvS0ox?=
 =?utf-8?B?WUVoa0JkNHo1c1JZK0dpVGFKaHB4aExOQXNRbWttdGlZWjA4dmJXYzdRV1RX?=
 =?utf-8?B?Umw1UEtlQkxhMEFoRzJIaVoyQjhjZmIrb254ZTNwR1RvSCt1aVQ0Y2tCZlRS?=
 =?utf-8?B?K1NQZlcvUmhMWVZqaktkUGpCRDZsME1QaXMzSmZ2SFZNaWI1cUdVY3pFWVJX?=
 =?utf-8?B?Yk8yd0I0bkpJWmZTbWJNSEZ0Zmp3R3AyYWU4MGx3MVhPc3Bkb0NBemVzS2lv?=
 =?utf-8?B?amNuTE44Z1pYWjNxU1R2OVlXVG9adElXdVMxcXdZSTl4S3M2Y0QzYkpwVFRR?=
 =?utf-8?B?dUUzTk00cFduM1ZLa2Q0NFAydkl3SkQ2ekl0bnNqMHpuWkRhREd5eGp1c0ZO?=
 =?utf-8?B?ZkpFTndSdDhQSmJnbHFNeXJtdnlZUk9FZlpGcUt2RkV1WXlUZUxTeXlmbmIr?=
 =?utf-8?B?RW13bzdpbG55UE9mTUJ3Q08rU0lxd2d6RlRzMUxnZ0RBRkt3blJNVElaNnhW?=
 =?utf-8?B?ZHNEVnRFNlpQd0J4SnN6N01QbXBweHNNdjcxaVFxcW85WjVHL1ZpSHRjQmpN?=
 =?utf-8?B?bkswOEhzTUtYWTZES2kvVnpqcmZnUERKcnBWbmdxTFBocXo0dVZZOVhTU3Yr?=
 =?utf-8?B?WDZxVVMraDRCaHFTaXlHK2lLUlBsYjdMUWUwSWh0aVMwMmNFTFM3RmZnY3d1?=
 =?utf-8?B?TXFTeGRhTGtQVDBidkwxQUtSS2EwanZ0S0tMZXU1V0ZFWU53NkpLb293Uit4?=
 =?utf-8?B?RlRnYnp4SVp5Szh0S25Ea1J4UGR4UzZUM242RE1hMHlEcWFVU3QrZklNS21p?=
 =?utf-8?B?c1RaSzlvK1RBRUJhKzFYQklSRVMrZlZYT2JhdmkvRFNoeXVBeVF0ZWt4cUxP?=
 =?utf-8?B?aS90Zm9JMi8yR001WXlNTXdHOE0rbDVmSUlsVThHS3ZLYStyRDVtbitBYm1Y?=
 =?utf-8?B?blNyWVV1Vkl3RWlzTEI2Qi93K2d5MkJqMlQ3YkRhTjREN0tQajFjT2RndXRi?=
 =?utf-8?B?UzU0VEl3WHF2UVRPM0U2NHZUb3NlSHJzQm9UbjhoVXJreVVQaGZsTHY3azRa?=
 =?utf-8?B?TVFGTnpPQnl3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3291.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 087b3d4b-8f98-43b8-98c0-08da04261493
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Mar 2022 12:44:42.3082
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vW34K4Kd0u83jQUg7LkQ2xvfsV9ubURMUiC36k9v8cI7KG74WH68hDc/lS52Sw5JiGBT0JhjQuK6ivEZevnZDFiQeyKmh4y14sHNNZ3+Mzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5560
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WWVzIHRoaXMgd2FzIGEgbWlzdGFrZS4gDQoNClRoYW5rcywgDQpOaXJhdg0KDQotLS0tLU9yaWdp
bmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogS3J6eXN6dG9mIEtvemxvd3NraSA8a3J6a0BrZXJuZWwu
b3JnPiANClNlbnQ6IFNhdHVyZGF5LCAxMiBNYXJjaCwgMjAyMiA4OjA1IFBNDQpUbzogQW5nLCBU
aWVuIFN1bmcgPHRpZW4uc3VuZy5hbmdAaW50ZWwuY29tPjsgZGluZ3V5ZW5Aa2VybmVsLm9yZzsg
cm9iaCtkdEBrZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2Vy
bmVsQHZnZXIua2VybmVsLm9yZw0KQ2M6IFJhYmFyYSwgTmlyYXZrdW1hciBMIDxuaXJhdmt1bWFy
LmwucmFiYXJhQGludGVsLmNvbT4NClN1YmplY3Q6IFJlOiBbUEFUQ0hdIGFybTY0OiBkdHM6IGlu
dGVsOiBhZGQgZGV2aWNlIHRyZWUgZm9yIG42MDEwDQoNCk9uIDEyLzAzLzIwMjIgMDk6MDEsIHRp
ZW4uc3VuZy5hbmdAaW50ZWwuY29tIHdyb3RlOg0KPiBGcm9tOiBOaXJhdmt1bWFyIEwgUmFiYXJh
IDxuaXJhdmt1bWFyLmwucmFiYXJhQGludGVsLmNvbT4NCj4gDQo+IEFkZCBhIGR0cyBmaWxlIGZv
ciB0aGUgU2lsaWNvbSBGUEdBIFNtYXJ0TklDIE42MDEwL042MDExLCB3aGljaCBpcyANCj4gYmFz
ZWQgb24gdGhlIEludGVsIEFnbGlleCBwbGF0Zm9ybS4NCj4gDQo+IEFja2VkLWJ5OiBEaW5oIE5n
dXllbiA8ZGluZ3V5ZW5Aa2VybmVsLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogTmlyYXZrdW1hciBM
IFJhYmFyYSA8bmlyYXZrdW1hci5sLnJhYmFyYUBpbnRlbC5jb20+DQo+IC0tLQ0KPiAgYXJjaC9h
cm02NC9ib290L2R0cy9pbnRlbC9NYWtlZmlsZSAgICAgICAgICAgIHwgIDEgKw0KPiAgLi4uL2Jv
b3QvZHRzL2ludGVsL3NvY2ZwZ2FfYWdpbGV4X242MDEwLmR0cyAgIHwgODMgKysrKysrKysrKysr
KysrKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA4NCBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgYXJjaC9hcm02NC9ib290L2R0cy9pbnRlbC9zb2NmcGdhX2FnaWxleF9uNjAx
MC5kdHMNCj4gDQoNCkkgdW5kZXJzdGFuZCB0aGlzIG9uZSBzaG91bGQgYmUgYWJhbmRvbmVkPw0K
DQpCZXN0IHJlZ2FyZHMsDQpLcnp5c3p0b2YNCg==
