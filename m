Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BD55A7358
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 03:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230188AbiHaB2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 21:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiHaB2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 21:28:02 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDF489C8D4;
        Tue, 30 Aug 2022 18:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661909282; x=1693445282;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=2NqL9agXm9A2dmoKC9UW1XHORwEVY861xxi/fZzBFio=;
  b=BNNLyT9lMTTGEL7Q5v3IMMzMpDZNOh5o343Pl1/JNLgwBzr5ZXEcnydO
   hOxqucFdaGbRku0OosSx6bsbcrFFYhUR9w6z5tRCFEa2/rfjtqsTx05Uw
   4472aTyJBdEdL8i0vAjg5QAEzvwsW/rCBVMTktghf6BsWpnlQbDpWx/Eg
   4acgVy5G78KyvAzsAWAojUz2HjxKiDxMzYbTJA5wx/KD0LKsmA4Dccj0c
   tdOzFXL/vnHqzQjf7BzF+lWJ3Ciu03XrYQCcfHz/XLDKui2MlS9Ldc7Lo
   teVDz5/dVKTjtzF0L/n2tZjX+RQl0B27ZgjgRTzEkDz+XyD91jRGXyAbD
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10455"; a="357063133"
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="357063133"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 18:28:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,276,1654585200"; 
   d="scan'208";a="588857545"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 30 Aug 2022 18:28:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 18:28:00 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 30 Aug 2022 18:28:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 30 Aug 2022 18:28:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HY2L2rhWZAZuf0tbVzUailk3u64ItoZ3vy71rweFVeNaka04EhKPhQ1qqEp893v7hINulBu+5ujyr9p6gqs8oI42byhzoDmeB5jLgm0VA2y2xmVSZUh0/q/9GhDzxLLtnKSlZqda0PXzX4rSqG4Eahe1tgvBNyus3PPg0KqteVif92sbodcnW9hsAA1g2bPCmIc6D19WOkX7zCV03TNaUVDnAw1rEzqbI8XYFopPdxgtiftDOXk1s+G8MQ0Lg1NnJzQ1H1W6KwFp5FG8kBEhGav3GJhSShbvIpWkluvzxdLQfxYFI2/YOhoAbTsaqdHtt+wwgmJ2DiYuQdCxyZ3pbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2NqL9agXm9A2dmoKC9UW1XHORwEVY861xxi/fZzBFio=;
 b=kDX+I15NqS3bx9CwvBRVGITTLp3usy8OQaBYm4q4GNNLfl9Va6yVtyKdiurl7CbYq3qjJnX+7ELtsxezM4FGd6Tq/QsTWK6Wwm+7a2/xt+dLNuEW49WSa4uwL6Pxk08q9khtyb1sBObd7Pq1p5JQuQSy5vgTL8lVXIEMtcTUCCfOqb7857QUqw8RGHMA7M9N+8rA/xQu+EZ5Dr3bNXyu+sU2BoKBror4gzUZIiDxGagwRPXZgIcbAFOOuQgH4pYU2BcCHGf8WpoU5Sdym0elpfojkhDmdEsQwGYLuepucErXwbUiHrBZhiJo5Fqq9dpjgdF1DfmQ3nbZtH0vBlKkoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by BN6PR11MB1683.namprd11.prod.outlook.com (2603:10b6:404:3f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Wed, 31 Aug
 2022 01:27:58 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fce1:b229:d351:a708]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::fce1:b229:d351:a708%8]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 01:27:58 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "jarkko@kernel.org" <jarkko@kernel.org>
CC:     "pmenzel@molgen.mpg.de" <pmenzel@molgen.mpg.de>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "Dhanraj, Vijay" <vijay.dhanraj@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/6] x86/sgx: Do not consider unsanitized pages an error
Thread-Topic: [PATCH 1/6] x86/sgx: Do not consider unsanitized pages an error
Thread-Index: AQHYvB5Zhte1gFzwtkKh12BdFyDkBa3IDqyAgAAq44A=
Date:   Wed, 31 Aug 2022 01:27:58 +0000
Message-ID: <1b3308a364317d36ad41961ea9cfee24aa122f02.camel@intel.com>
References: <20220830031206.13449-1-jarkko@kernel.org>
         <20220830031206.13449-2-jarkko@kernel.org>
         <1f43e7b9-c101-3872-bd1b-add66933b285@intel.com>
In-Reply-To: <1f43e7b9-c101-3872-bd1b-add66933b285@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6deb9968-3a9d-4287-689d-08da8af009b8
x-ms-traffictypediagnostic: BN6PR11MB1683:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RngeUZz9Hp7LC8qvlfOmWgyfdX8e6ONc1Ayf69SQBGR6Q5xCq3bAg+/JDYwvNsY0W1d+XtfDacOJdWK4+uTRrAerxAIamewmilYK5I6K5/5R64Zfo5D5Rg8NuTQz5X3SOfdqvMiB72z1XbFigRklAa8g7wsS7YTsw2GPYiNAYVj2PFLgIXOyRj4XvjdsBcexus/8g3Ug4rfEh4DWvmMMjbMTqdmQ4ioma0iM+7F8vUfniK+S8iZlY2YRqHFlGL/FELzV8q6WutcFhf/5x1bPz3zeyEKIt2VaU+lEjwvi2tw1rO+aBSUwFdAmm6GOp4jhADAxlL6TZKZw+UEcNoWh3vdgi3zez/ErRUppNl5Lr0vFmHEJqoG6sV3vHQaVBjml7UhpAMdKpzevjTagDj9w0GKL9NEfSwbyeZyJWcQivtq08M7yTYjgIfL7QKYiy1mNIW9SIDJjD2MUIDYuEbyc7OfY4B/8qm3sTkDhuWxKifYYp51eH1YHEmTbJw1a5j9UCqIlOtkeCeNR5pyI+bjv0MeWMaVUUvIWZr/eeO0yE+SSxOo3vwWsa8zeM6CG7ZybsKI5zHQCCwzCnLsYktQMo8X4RA92/QTXMKn8TWwlRhzSrSPEeJjit4vSm+7ewo5xkHJOTeTEG9/J7piq0liYyDRlLDMFXHqwFLTHjSMeU7iykRUMC9rwEEOK6pzm1oNbisfPuaD3hxELnW5HUjqBwfjCjLWw9u/CpMTTygXy/ET5ftC2LUKF/xifjHMLFTtQAOo1eFnOUYudf22oL1gi9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(366004)(346002)(376002)(136003)(39860400002)(122000001)(66946007)(86362001)(38100700002)(4326008)(76116006)(8676002)(66556008)(66476007)(66446008)(64756008)(36756003)(91956017)(38070700005)(82960400001)(316002)(186003)(478600001)(2616005)(26005)(41300700001)(6506007)(6486002)(6512007)(53546011)(71200400001)(54906003)(110136005)(83380400001)(2906002)(5660300002)(7416002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0RIQm0rcDR2YzR4RXhFZVlDcllTWTlzcmgrRjVaZWFKU0tZTTNTQXhzU1hH?=
 =?utf-8?B?cVlkR09Vdjljbk1ZL0paeEliRklCM3g5MjlBOTNrMm9WbHNuMUdqeHVBajJF?=
 =?utf-8?B?bkJ3VUJNSDlXNzNyTlBMNXRnejdoZkl6WWpvSUpPOVhWQ3lTZ29qNUQ2ZldO?=
 =?utf-8?B?SmlUV09tdGJKcWw3Q1Q5S2FNd3RFb3FYUGRwcUxINUliUDdZelZnSVgvTVlh?=
 =?utf-8?B?ODVWS011azJxUHN6RWFHNm5ldXBqdGx0SVRyZ3pXcW5FVG5Vc3ZmRXlIYnFh?=
 =?utf-8?B?RnkwVTczWXFTWExHU3RKaFVMaHlnT21jVlp3bWJsM0xGN0MwRnQ3M0kyYjRL?=
 =?utf-8?B?NFpCRkZ1eENTQ3ppeXJWUHZxeGV5bFdKQkN3enZnSk1EcERJNVVJR2t0R1VP?=
 =?utf-8?B?U0oyb0ZIV25XNDRLOEdWU1p2VEVQRUdEYVlpVEZURVMwV1Z1QWUrSGJOYXBr?=
 =?utf-8?B?K29qclBzczhZSGFkWFQrdGdSdHdIRytmVlN0c0d5MWJyZUJ3Q3FpWUV3bXc4?=
 =?utf-8?B?bEpkTTljbjVjU0IxN000cXF5ck1mWUNBSkZMd2h2VjVoV2ZmWFBVbnRsdUZN?=
 =?utf-8?B?alRER3VrNS9HS0hRd1o5UE9FREZNSElsR29Fc3pXMUcwaW0vbVEyeUE0YXg3?=
 =?utf-8?B?M0JTU1l6bXF2MXM4b1d6UEdyOTZmNitIemRzZHBOMWYvdDlOa3pGWkNZRlZx?=
 =?utf-8?B?REVHZXpKenNld0IwS2xQWmdSZ0ptSnpyQk1EQ0lPYzB6YnY0VVo5WmY2UGdL?=
 =?utf-8?B?cEQ1TCt2ODAxSFBOVndIRzU4NTdPMGkwaVRycHpqcWpPMkdBeEp0ajhmQ3BT?=
 =?utf-8?B?K25hR3NlZmdWN2V2MzJtUDlNZFpBMWxxMjRVOXNWTXFKTUFhRlpSK1A3UWZL?=
 =?utf-8?B?ckpmY2s4WS9YZlNYNENXNEtoTVd0aGJDa3IrN0tMUEpVMk9YZmI5Ni9Qam8v?=
 =?utf-8?B?R1M2c2dzZnp4T3hnUnhFK0xvTGFjRVI5UlpBWFRRd0xJdFJPaWlqdmNjQnJj?=
 =?utf-8?B?T0MwZytGVU91dkRwS2U5eE01alRiQi9VYjR3R3Rsekdvb1VRdHBuMkNDYUV6?=
 =?utf-8?B?QnFnRjFRYmlONy9yN0NOZjJValIwaDA5ZFZTQ0grUFRjTGxGaFE0WmNQb3h4?=
 =?utf-8?B?aUVDZlZBL3BaYjhUaDFUVU5VSFNEL21Hc08ra3R2MnlOYmwrb2Yybk1NWmhl?=
 =?utf-8?B?djJmRXczYkFydmEvZE9iM1pKWi9mQnNZblNva2JEYmtpN1JGdVA5d2gwbTRH?=
 =?utf-8?B?S2JueDQxQXk1OWtSM2V1QThNUGVkQlduVUxnN0NicGFCdHlYNG96RHZWb3Jh?=
 =?utf-8?B?TURCWTJUemthc3hZd3Y2dktwRWcrWk45WW5sVnNkNm84dzNtRzlNRkcxOE1E?=
 =?utf-8?B?Y2lma1dFd2ZhM1VRMlB6VHRFTi9NeG1nRlZNejVOUUxJcFdJcC9SeExZbzVa?=
 =?utf-8?B?ekllMDRLS1FYRnBpQU1BaEZqdTZLek9MMk9pSUhnYUpZby9paml6aU03V3da?=
 =?utf-8?B?VWVGM2RFb2tJUzIwMCtUeWNib21VdTZGUUs3OG94TWdJZldtMER4eGZWNE5F?=
 =?utf-8?B?RHIxVWJlQkZVOGFPd1B4aVZORDg4Z3dINDJDancyZkdPL2xPbGd1TWJ5amJk?=
 =?utf-8?B?MnpJbGdodWx0V2xhZWlGOTFnWm1kKzFwaUVSbkRNNGNOTDVGTlFyN3ZranlE?=
 =?utf-8?B?M2FXZ3V1MWNxcWN4UW9PM0Vhc3hmZjkrMVNxRklEc0hXZGZ2djROdXNKWEM3?=
 =?utf-8?B?L3NuMWswdCszMGdDZFdCN212bExHNlBKY2xZaHQwUDQxbnNvb2pxdWpKR05t?=
 =?utf-8?B?aStTME5LMGlUUUU5MGJtaFlFWkZseFNteXI2OUFnN2hEODF5QTdCN2dTK1lT?=
 =?utf-8?B?VGE1SUlSejVFMmR0M2J6dXJ2YnJnSnE4Smkra1BmT2ZjaktMcTlPWGFtaWlp?=
 =?utf-8?B?SUZienczZldoWDVOWFM1T3FSOFdlM3hFbUNzYkhuUU01SVBxZ0daeEtCN1Jl?=
 =?utf-8?B?TFpuUHBQL3JDTmlMNWIvV0pNU2l3cXBnWHBVcU9ReXRRdVpSYzB2NUpTbzI1?=
 =?utf-8?B?SWowQzg2R2tqWWkxWUhMdFdSaGlpekt2VEhIZDF4NC9xSTFtbjQwdjZMOTBU?=
 =?utf-8?B?TGZ0a3R3R0FVaHltM0l5cEova29na0cwcTdkWk9qSTJ0WDkyblVPKzFpY01Y?=
 =?utf-8?B?U1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <656C96DF57BCA34089D45903AF727C2B@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6deb9968-3a9d-4287-689d-08da8af009b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Aug 2022 01:27:58.5898
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aNUQGmcZUojILOheYECzVgmoSk6y8c4BuYiQxNi8BGT1ihMsBvBzPgXbvfX9blUOnMfjAuhaEyLflpVaE+Y4Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1683
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIyLTA4LTMwIGF0IDE1OjU0IC0wNzAwLCBSZWluZXR0ZSBDaGF0cmUgd3JvdGU6
DQo+IEhpIEphcmtrbywNCj4gDQo+IE9uIDgvMjkvMjAyMiA4OjEyIFBNLCBKYXJra28gU2Fra2lu
ZW4gd3JvdGU6DQo+ID4gSW4gc2d4X2luaXQoKSwgaWYgbWlzY19yZWdpc3RlcigpIGZvciB0aGUg
cHJvdmlzaW9uIGRldmljZSBmYWlscywgYW5kDQo+ID4gbmVpdGhlciBzZ3hfZHJ2X2luaXQoKSBu
b3Igc2d4X3ZlcGNfaW5pdCgpIHN1Y2NlZWRzLCB0aGVuIGtzZ3hkIHdpbGwgYmUNCj4gPiBwcmVt
YXR1cmVseSBzdG9wcGVkLg0KPiANCj4gSSBkbyBub3QgdGhpbmsgbWlzY19yZWdpc3RlcigpIGlz
IHJlcXVpcmVkIHRvIGZhaWwgZm9yIHRoZSBzY2VuYXJpbyB0bw0KPiBiZSB0cmlnZ2VyZWQgKHJh
dGhlciB1c2UgIm9yIiB0aGFuICJhbmQiPykuIFBlcmhhcHMganVzdA0KPiAiSW4gc2d4X2luaXQo
KSwgaWYgYSBmYWlsdXJlIGlzIGVuY291bnRlcmVkIGFmdGVyIGtzZ3hkIGlzIHN0YXJ0ZWQNCj4g
KHZpYSBzZ3hfcGFnZV9yZWNsYWltZXJfaW5pdCgpKSAuLi4iLg0KDQpJTUhPICJhIGZhaWx1cmUi
IG1pZ2h0IGJlIHRvbyB2YWd1ZS4gIEZvciBpbnN0YW5jZSwgZmFpbHVyZSB0byBzZ3hfZHJ2X2lu
aXQoKQ0Kd29uJ3QgaW1tZWRpYXRlbHkgcmVzdWx0IGluIGtzZ3hkIHRvIHN0b3AgcHJlbWF0dXJh
bGx5LiAgQXMgbG9uZyBhcyBLVk0gU0dYIGNhbg0KYmUgaW5pdGlhbGl6ZWQgc3VjY2Vzc2Z1bGx5
LCBzZ3hfaW5pdCgpIHN0aWxsIHJldHVybnMgMC4NCg0KQnR3IEkgd2FzIHRoaW5raW5nIHdoZXRo
ZXIgd2Ugc2hvdWxkIG1vdmUgc2d4X3BhZ2VfcmVjbGFpbWVyX2luaXQoKSB0byB0aGUgZW5kDQpv
ZiBzZ3hfaW5pdCgpLCBhZnRlciB3ZSBtYWtlIHN1cmUgYXQgbGVhc3Qgb25lIG9mIHRoZSBkcml2
ZXIgYW5kIHRoZSBLVk0gU0dYIGlzDQppbml0aWFsaXplZCBzdWNjZXNzZnVsbHkuICBUaGVuIHRo
ZSBjb2RlIGNoYW5nZSBpbiB0aGlzIHBhdGNoIHdvbid0IGJlIG5lY2Vzc2FyeQ0KaWYgSSB1bmRl
cnN0YW5kIGNvcnJlY3RseS4gIEFGQUlDVCB0aGVyZSdzIG5vIGdvb2QgcmVhc29uIHRvIHN0YXJ0
IHRoZSBrc2d4ZCBhdA0KZWFybHkgc3RhZ2UgYmVmb3JlIHdlIGFyZSBzdXJlIGVpdGhlciB0aGUg
ZHJpdmVyIG9yIEtWTSBTR1ggd2lsbCB3b3JrLg0KDQpCdHcgY3VycmVudGx5IEVQQyBwYWdlcyBh
c3NpZ25lZCB0byBLVk0gZ3Vlc3QgY2Fubm90IGJlIHJlY2xhaW1lZCwgc28NCnRoZW9yZXRpY2Fs
bHkga3NneGQgY2FuIGJlIG1vdmVkIHRvIHNneF9kcnZfaW5pdCgpLCBidXQgd2hvIGtub3dzIHNv
bWVkYXkgd2UNCndpbGwgZGVjaWRlIHRvIG1ha2UgS1ZNIGd1ZXN0IEVQQyBwYWdlcyB0byBiZSBh
YmxlIHRvIGJlIHJlY2xhaW1lZC4gOikNCg0KDQoNCi0tIA0KVGhhbmtzLA0KLUthaQ0KDQoNCg==
