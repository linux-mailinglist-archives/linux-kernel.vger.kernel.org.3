Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0619461AB5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 16:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbhK2PW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 10:22:28 -0500
Received: from mga04.intel.com ([192.55.52.120]:42396 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229780AbhK2PUY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 10:20:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="234712172"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="234712172"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 07:17:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="743733278"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga006.fm.intel.com with ESMTP; 29 Nov 2021 07:17:05 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 07:17:05 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 29 Nov 2021 07:17:05 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Mon, 29 Nov 2021 07:17:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSoe2TQMA0a7yVG5DNVzzY9QFCxhH1W+sPOVfHSmRSJwjlfyUihL665aYcjFbT6Y4tG8cS1eXJkLeCtp0mkiLbyHahAEzGrotX9gzZTa/E4o4h6FhaB93RGTjpklkzEGBwtdjqWMgKGgIkTHARW0q43Z0Ec3HG8nmOlA3N8xPbNfdHKlXelZ2o+51WuOS6/TwP5oPsvdL81GCWV5FwLiFFJlEfr2gOcWo0TeAt62h71pmQORuATVu5T05e48+K6+Cf57OeZMCgG3/M2mEYFt2/7oT5j+ZTO9RRVaJ3c3sqZSyZaiJQAobRvVqLgnoG8acfwSJJpKE4BSs0zCvfuR5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZP82N3JAmLkJq9PehojZqFKGehvDMb/kODTCu+sVm6Q=;
 b=cmKi22EcfbVVGB6wje88J6H2q+NtXXziiT030UTT3mO4j6wkq8i8fL89PynsK50JxWp5Abv4PLGE+G/RXSPfZV666BiRYoFBOMj3W+nxj0ytT6PC8UFzSLt4AMB7rHlyOiRdUsl9swcR9HpfrldCczbavS9c3IYbX8P4h5tdYEiTBHcv1bmq1zSHWHnLTAvUF6kKmchNVAvaDtZckmFV+O4NK94uxjk82SPzG4FfwwY1rxBuIXBtQWtFvWvrl1On2HBKAgHRh/1Iz8AVINoFtJmf/J61TGjcyISpv0mfQbSso0XY/vDwh60D6fhf+gibAn8vFhKYIgkQxIC+rNdWWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZP82N3JAmLkJq9PehojZqFKGehvDMb/kODTCu+sVm6Q=;
 b=UUS3LeRliqIhow8aQJ3VmFmy7saZrcN3v2FzjdIJhx/Ob6h+QvQebQl/hDPikqg4HwsyunHelpHrEGPEPvSDdm+f3Ogvozfo2Q4vLb0C93ThCrGomZPQCeCWWArF+czHf0qZ/7zBbpwfIv7mlVwaDmCh/X7YUTHW1jainP8293o=
Received: from DM6PR11MB3660.namprd11.prod.outlook.com (2603:10b6:5:13c::17)
 by DM6PR11MB3241.namprd11.prod.outlook.com (2603:10b6:5:58::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 15:17:03 +0000
Received: from DM6PR11MB3660.namprd11.prod.outlook.com
 ([fe80::b987:803c:b0b4:fd9e]) by DM6PR11MB3660.namprd11.prod.outlook.com
 ([fe80::b987:803c:b0b4:fd9e%6]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 15:17:03 +0000
From:   "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Saha, Tamal" <tamal.saha@intel.com>,
        "N, Pandith" <pandith.n@intel.com>,
        "Demakkanavar, Kenchappa" <kenchappa.demakkanavar@intel.com>
Subject: RE: [PATCH v1 1/2] dt-bindings: pinctrl: Add bindings for Intel
 Thunderbay pinctrl driver
Thread-Topic: [PATCH v1 1/2] dt-bindings: pinctrl: Add bindings for Intel
 Thunderbay pinctrl driver
Thread-Index: AQHX4IIOedvNIJiQzkCUwFLCyhFPG6wU8tIAgAWzppA=
Date:   Mon, 29 Nov 2021 15:17:03 +0000
Message-ID: <DM6PR11MB3660D7A7AA5E796478A0AA14C4669@DM6PR11MB3660.namprd11.prod.outlook.com>
References: <20211123155144.21708-1-lakshmi.sowjanya.d@intel.com>
 <20211123155144.21708-2-lakshmi.sowjanya.d@intel.com>
 <CACRpkdbOG7AiZxMoP9azYzHBEeOvNVWt9-ArYiP=BBswydRDqQ@mail.gmail.com>
In-Reply-To: <CACRpkdbOG7AiZxMoP9azYzHBEeOvNVWt9-ArYiP=BBswydRDqQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.200.16
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2094f972-dd7a-49a3-0313-08d9b34b4ca5
x-ms-traffictypediagnostic: DM6PR11MB3241:
x-microsoft-antispam-prvs: <DM6PR11MB3241A01A5FFEAEC7CC9B662DC4669@DM6PR11MB3241.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qp0WNow3pTiOJMcmr2QJPjbCKSUQq3awRSFqF0UmtV8dPLQp5/teaCwzyqCLwQMKSrut+KrkceN6n7cYLRXQtj03wA4d1UA92MiVFykL5ezWRolJlPH6HPhF6t8TeX8xUz3IAycY0zwbfSVKVbh+OYOvVB0XSXqFjN0sU/XF2MDZemzIXtq3ceRM8jjIUm1T5KxguGHtl3R3HYe1gTIw/CkbyFX5pxxgoQHpsx3f7lJ9ljnvbpgxi8M+FFDw8sX3paw3beJQxqEGeAdGZGgXz9nJilXqrxSm8AORTbE8Pc9DUg5agKMYlyO9UuZTuKs4E1w8to+tD9yqSuHf3dVh+0kq4qQHHVQd3+RsUozbaZnE8QLVFkWVbEAH4omaT3a2fnRo2/J5eZNRfoYr0n60G0qI5yqvJUlq5yY+piKEPS97E6e0Pmo3JwsQaEGcFzH1rNrI4ElUP9rs3Bo7dFI2UpDTuxmgUSxnQPnEBZZPoNVkWrUp9BWpHuSZq7H14Pz5ocGbCnIl0FSB7P0aEjNGttkwy5Ay5sr36XI86oez/w6ksntx/T3pYWd9gomHuSWmp6gwe1Xzq0gVukRgrWx9POzhvtawim2hgDM5xRlxfGuAriYQLyDL0IkIgMs8mommjdKP6AaVs2ZYfG0YbmLnkarsuad/Nv1P2YY+QQMmbbfrIv1TSl3OLoI6kBX3Z5wTbAjX+niZqiXP7iVfRvHpRQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(6916009)(52536014)(71200400001)(9686003)(5660300002)(33656002)(4326008)(54906003)(4744005)(83380400001)(122000001)(2906002)(66946007)(82960400001)(8676002)(8936002)(55016003)(186003)(38100700002)(6506007)(38070700005)(64756008)(66556008)(66476007)(76116006)(7696005)(66446008)(26005)(86362001)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c3BKb2pvdDR5WkhySldrRzdJRmIrUG1hWTVzTmZZbmZsN045NGpTczlUK3lI?=
 =?utf-8?B?NERUYVN2NFpsUlhDWlpLei9nSlhCcXFKQnJCRDcrQ011QnhNY1lyd2tuMzFu?=
 =?utf-8?B?UGdtdXB0SndRclo5YUM1L1hQWXk4OUVhNndZQUZPam01MmFrdUpPbytPR1p5?=
 =?utf-8?B?NnRvUDhXbVRFdStOa21vdzhNeWkvKzFESWt5RmEwclVhenF0SWhoM0xaOElS?=
 =?utf-8?B?bG04aXVxQ0dBenpjdWhQZXpPQkdLdzBxZ3dCVXZlcFdXVmhqVWdyOHRUbCtZ?=
 =?utf-8?B?T09YYzNkcVFUdW5yZ3RzdnN6NkcyNXFxUmZHRE9kTytHM1A3YVFuMmlJQXFy?=
 =?utf-8?B?ZXE5di9rdmZsQVFCeUo2R0M4WmhacWptYTJwelFYb0I2NXBjVnBkaEFhOElK?=
 =?utf-8?B?UWE5NWRuNlBBQ2pvUjhjN242bHhMY3VCUmJhUFVGd3pxTUpSSVM4SHNQVjMw?=
 =?utf-8?B?ejlkWWdwdFdkdnBodzV1c2hpUjcvZEFNUytPNVhlQ1VOWExTdTdoRGppbFEr?=
 =?utf-8?B?aXplY3pOM1FKY3Y2WHQ3YXdnZlRhUHpvU2lIR0dtaWtGK0JkdGZPN0o0b2FX?=
 =?utf-8?B?dW0xSlJHOHhmRjBPeXNtVFRGbXZ3RGJOUVVKSmt2ZXZDUkZEYUhPYitValcr?=
 =?utf-8?B?RENubXJCVm95UHBTaUgxMDZ1UGJja0NBaEo3NlFyL3RqeG1oSkFVU1JoUkZm?=
 =?utf-8?B?RU91SjhjYU9RdlVtZGtoeDZiK1JFNVJmRlNpWnBFaFdsQmIyRUZiV3ZnUmpO?=
 =?utf-8?B?TGU5b0lkMnlHVTFTdGEyQ3FnelJNc0E3QUFVYkJ0SGtncVBLdUdZWFRHTTBy?=
 =?utf-8?B?Sk1IZ0l2L3lVNk5YLzdGbThYTlgrM1BvMjBpd25LTUJkVGFMOUFrWEtFWC9V?=
 =?utf-8?B?UGVUVWZQUzQrbHQ3UUdiaUZTQ2FoNXpjdU8zWWFDR1gyMlowRXM2Z0d3V3lK?=
 =?utf-8?B?L2loRzZySzFsUERFNm9RandNTE9IMGRPUS9qaGZaNHBDL2tNdDU3Wmp2cEF1?=
 =?utf-8?B?dDR2TjB2OFE3NytOaXlUeXMxQUVuNG1HY3g3L212M0hHbjVIRWxyOGpTTzRY?=
 =?utf-8?B?ZDA1eGRTMkYyd0FiMGJTeFRTK3BMS1NhQUNxVjBjZFg3dWdtcmhxUjR0cjNW?=
 =?utf-8?B?S0Z6WG5IUE1kaURsL2NEVDhCNDJXMDZSRXFtREMrYzhNUzU5NkV4TkpGbzhQ?=
 =?utf-8?B?NTI1UVBSSTMrQUlGRHZQZWJkQXlZZ2ZueENEL0NBSzBleEorUm9jSHJtcHQv?=
 =?utf-8?B?R2oxb2wyWlpiY1NQcHBKeUxIbGFiUVlBTkR4Sy90NVZrSnJZV1FOc3FzQ3Vt?=
 =?utf-8?B?dUNtU2poWmR5VHZvcVp0TkdGdXdnZDR6T1NpcVg4NTg4bm1qUVRSd3MwZkFl?=
 =?utf-8?B?WHlpZ3RKRGpYb1FvR29RVWtyTXVIZzBlK3E3cGtnaG1SWVd3SnFOKzBvSks1?=
 =?utf-8?B?cnJGOCt3QU9YeDh1Z09ERSt2T2V5bk1ycmVjZE5WM3lTUGE2ZDA3bkkxS2ZR?=
 =?utf-8?B?N2dqZklQQXNiRGNCUHptMmFLVGd0N09QZWJOblV0QTdXQ0tNWjh4NEpIU3BO?=
 =?utf-8?B?SWtIVzQ4MzZRZGZqZmNSTGFoR0c5SUxnY2pSb0U5aUhEdlQyNld6R2hicXQz?=
 =?utf-8?B?cU4yVi9VNmVsSWViSzJ2UTZWWThvUll6TjVMMklXYkJ1cnJVOWVxNExoTFFN?=
 =?utf-8?B?L2liQWEvblVSK2ZJeHNPTVlDZ1RNVlJ1UElvbTg1R0w4cm12Q2VYcmJRVzV0?=
 =?utf-8?B?ODJlSGRNaUVWSGhZdm5rUk5xRnJMQkxKb2lheXhvbnFvMndnTCs3Z3kvUm5K?=
 =?utf-8?B?VEdUZnprRDB3VU5BYk0zbDZkK1FVYUVnVWdIRmpJbDBUL0FXaEQ5ZVBOR0JT?=
 =?utf-8?B?WStTTmFPdGNjaUtoN1ZBdHVUVUNTNGNGdExQRWNnUUpCT2hMd0J4aERMRldI?=
 =?utf-8?B?SkJXM000TTNsSGFOYTRXUjB4YXZtSjFmUm5GMTdsQUhNT0ZvNm1tZWkycEIx?=
 =?utf-8?B?Kzc0d29KS2NZejZWZkxUOUF0WkdwQW9kSVpoRFRycHNXeU45YWgzdGxQK1d0?=
 =?utf-8?B?aVRFNDJNUlNLVlBrN3FaMEFDTGt1U3JOT1FNc1NhVUZ2aHlHdW92Mm1GYzlL?=
 =?utf-8?B?VWFUMjQ1YUJQaldHWXhYaU9CYkc1dCtqdHRpbTVtT2VZeTE3UGNUSDZxcVJK?=
 =?utf-8?B?VTZ0dzFNM0grOW10RU9odGcwMmVrRVk4aG5TdDZCRDkwMXdYL3UwMllMVG9l?=
 =?utf-8?B?MVFGcUZnUXQ5UzBkdUhnQXg3bW9RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2094f972-dd7a-49a3-0313-08d9b34b4ca5
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 15:17:03.7868
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KXbGBiDe90lstqtCIPc336Av+u8CRO/f5j3rUE7bKtbW5m8k3EhKwEJAV48hk/wE+0QV8rPnFoyIlSXAike+6Rf3ylNPdQecLNIkzDeTZPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3241
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpbnVzIFdhbGxlaWogPGxp
bnVzLndhbGxlaWpAbGluYXJvLm9yZz4NCj5TZW50OiBGcmlkYXksIE5vdmVtYmVyIDI2LCAyMDIx
IDU6NDAgQU0NCj5UbzogRCwgTGFrc2htaSBTb3dqYW55YSA8bGFrc2htaS5zb3dqYW55YS5kQGlu
dGVsLmNvbT4NCj5DYzogbGludXgtZ3Bpb0B2Z2VyLmtlcm5lbC5vcmc7IGJnb2xhc3pld3NraUBi
YXlsaWJyZS5jb207IGxpbnV4LQ0KPmtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGFuZHJpeS5zaGV2
Y2hlbmtvQGxpbnV4LmludGVsLmNvbTsgU2FoYSwgVGFtYWwNCj48dGFtYWwuc2FoYUBpbnRlbC5j
b20+OyBOLCBQYW5kaXRoIDxwYW5kaXRoLm5AaW50ZWwuY29tPjsgRGVtYWtrYW5hdmFyLA0KPktl
bmNoYXBwYSA8a2VuY2hhcHBhLmRlbWFra2FuYXZhckBpbnRlbC5jb20+DQo+U3ViamVjdDogUmU6
IFtQQVRDSCB2MSAxLzJdIGR0LWJpbmRpbmdzOiBwaW5jdHJsOiBBZGQgYmluZGluZ3MgZm9yIElu
dGVsDQo+VGh1bmRlcmJheSBwaW5jdHJsIGRyaXZlcg0KPg0KPkhpIExha3NobWkhDQo+DQo+VGhh
bmtzIGZvciB5b3VyIHBhdGNoIQ0KPg0KPk9uIFR1ZSwgTm92IDIzLCAyMDIxIGF0IDQ6NTEgUE0g
PGxha3NobWkuc293amFueWEuZEBpbnRlbC5jb20+IHdyb3RlOg0KPj4NCj4+IEZyb206IExha3No
bWkgU293amFueWEgRCA8bGFrc2htaS5zb3dqYW55YS5kQGludGVsLmNvbT4NCj4+DQo+PiBBZGQg
RGV2aWNlIFRyZWUgYmluZGluZ3MgZG9jdW1lbnRhdGlvbiBhbmQgYW4gZW50cnkgaW4gTUFJTlRB
SU5FUlMNCj4+IGZpbGUgZm9yIEludGVsIFRodW5kZXIgQmF5IFNvQydzIHBpbiBjb250cm9sbGVy
Lg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IExha3NobWkgU293amFueWEgRCA8bGFrc2htaS5zb3dq
YW55YS5kQGludGVsLmNvbT4NCj4NCj5UaGlzIHBhdGNoIG11c3QgYmUgQ2MgdG8gZGV2aWNldHJl
ZUB2Z2VyLmtlcm5lbC5vcmcgc28gdGhlIERUIGJpbmRpbmcNCj5tYWludGFpbmVycyBjYW4gbG9v
ayBhdCBpdCwgY2FuIHlvdSByZXNlbmQgaXQ/DQoNClRoYW5rcyBMaW51cywNCkknbGwgc2VuZCB0
aGUgbmV4dCB2ZXJzaW9uLg0KDQpSZWdhcmRzDQpTb3dqYW55YQ0KPg0KPllvdXJzLA0KPkxpbnVz
IFdhbGxlaWoNCg==
