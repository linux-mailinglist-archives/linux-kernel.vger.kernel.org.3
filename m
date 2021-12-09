Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A26846E149
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 04:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbhLIDaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 22:30:09 -0500
Received: from mga14.intel.com ([192.55.52.115]:19525 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229601AbhLIDaI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 22:30:08 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="238232911"
X-IronPort-AV: E=Sophos;i="5.88,191,1635231600"; 
   d="scan'208";a="238232911"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 19:26:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,191,1635231600"; 
   d="scan'208";a="480177599"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga002.jf.intel.com with ESMTP; 08 Dec 2021 19:26:35 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 19:26:35 -0800
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 8 Dec 2021 19:26:34 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Wed, 8 Dec 2021 19:26:34 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 8 Dec 2021 19:26:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HFRKDPuzYsKye5C54Wln6q0BzNzQJCfgjs4Ct5xmodV3jaWXHrv1eirTi2HrwvdbiDU87qYenOvv0JDQ4+3tIadcEQGxhytE+bDb2jQQVudItPJHIDwbNMJXy3hY4l68qcPS/R183NBzhhidbSvMxTxB/NatOXorg1A+uUGfgZA4rCIm9ZUabSz94/24XqiUwoi4pgKrPtYztqIppW6tJ0aiAC6rBjb5fLyrnaHsjNDB91kMeyu+XS7xfNbIRvjk17uJK3++xopJ6YBpnXAHCljwFa8+S6YDIja9hkoiqAmX76SewTmVLA2+CzoJyokcq1iL/ZemZQIh5dl2K874cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7b3/oHQsSVawZ4Kzx77RNlwgpwv//UrgKXvGkYm8hZ8=;
 b=Q27dmHeK5mDFqfbIokpB3P8nmPX0gTH4/gPlNNkR7P3haI4c46uyMTmj2yPSD6npxK1BJ1lS3P/ZCeLquHMI9ZAlAx+xXn1FPuAg4rfm+UVnLAwFy9my7cYG+x16he5EMG2rSFY1lPRXLQWmRViMulVbT+psKGwQHl4tK/jUribUA0OLTOIHzxb4kbHE9FCT1kPOV4B9kRRrwKAixLMC7/bQLUT+u0M+6Lef5u5fI2zGY7dda0sAVT4RJr5AinjEi0AqDZsfriywBMz1tfbvN4XORqqoLurkzvrSJXkqzJMC/IFcYo0N9wnIqiUyD8x7tBzleJlJZVGZbqVGRkHhvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7b3/oHQsSVawZ4Kzx77RNlwgpwv//UrgKXvGkYm8hZ8=;
 b=AMPVK4hvw3mGvd61Ylra5bAcSzKkizYY3LNH2C51ShkOHx0f1B8s4EUtvEnB0VLHPqW2iKpVr6bNbJN/n3xPc2m78BbfIQAR3dPrhIHbwTNl5uNbh/C9GkiEonX1+LHYBhphLqKvl9F6Fw5aYQd5YjfJXDzbBjXAtpf+2rvWcrs=
Received: from BN8PR11MB3650.namprd11.prod.outlook.com (2603:10b6:408:8f::24)
 by BN6PR11MB3939.namprd11.prod.outlook.com (2603:10b6:405:7b::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Thu, 9 Dec
 2021 03:26:33 +0000
Received: from BN8PR11MB3650.namprd11.prod.outlook.com
 ([fe80::8961:a5ca:7c52:57d4]) by BN8PR11MB3650.namprd11.prod.outlook.com
 ([fe80::8961:a5ca:7c52:57d4%4]) with mapi id 15.20.4778.013; Thu, 9 Dec 2021
 03:26:33 +0000
From:   "D, Lakshmi Sowjanya" <lakshmi.sowjanya.d@intel.com>
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "Saha, Tamal" <tamal.saha@intel.com>,
        "N, Pandith" <pandith.n@intel.com>,
        "Demakkanavar, Kenchappa" <kenchappa.demakkanavar@intel.com>
Subject: RE: [PATCH v2 1/2] dt-bindings: pinctrl: Add bindings for Intel
 Thunderbay pinctrl driver
Thread-Topic: [PATCH v2 1/2] dt-bindings: pinctrl: Add bindings for Intel
 Thunderbay pinctrl driver
Thread-Index: AQHX5oTHil2ZuCOiKES5kVYqxJSIyqwpek4AgAAQ9gA=
Date:   Thu, 9 Dec 2021 03:26:33 +0000
Message-ID: <BN8PR11MB3650392F7D887A0C39FBE792C4709@BN8PR11MB3650.namprd11.prod.outlook.com>
References: <20211201072626.19599-1-lakshmi.sowjanya.d@intel.com>
 <20211201072626.19599-2-lakshmi.sowjanya.d@intel.com>
 <CACRpkdYFJf=A_isumOO6F5_oYbsdpA5KyCSj1niFRumKW7VJjw@mail.gmail.com>
In-Reply-To: <CACRpkdYFJf=A_isumOO6F5_oYbsdpA5KyCSj1niFRumKW7VJjw@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: 1127a804-5ca1-4108-e39c-08d9bac3b311
x-ms-traffictypediagnostic: BN6PR11MB3939:EE_
x-microsoft-antispam-prvs: <BN6PR11MB393971C697605A82571A3C9AC4709@BN6PR11MB3939.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JCZknQooL8vz9LDjf5WUGfb1l8r3dh0CR/OsMi4F4Ffw/q2RGW5/P+RLhKNyndI7VcRW75Dr14AVOqM0m26G0/tTxcu89dny5o0YIr+4w2ds88igyx+kjlcdKLTF4oJs1fMJt0pqd9HqUR2hNYejz/pEEx4vNljnhEatfX1MBCY3lUVhXSkeGEn14FkBowhXb9RKk5Czu2QN1PbuKrQjAPh2vNEpKqihiDQKChyMiWL0kSH9CrMheLNq89MrcqkegX6WcCoAhN1ZKMyQVG/m1cJHWQNX0gM3C9S785BwRiVzkkUgzDBarZr7SoC0QJjVpOALZQvOt77OBbADiyz/Cv1FXSM6w3Z0uwaXbpUNxNETS2BymAsd/FdgPgB7P8WXgKtwsJ+e5Yvbiv/vKrrSDjp39zsycrXoSeM25+pB7JrvQMyGgbkHqjPVxCzAF2zI9d912rMAoUChWxZinCBeUrhWKHpjan85VT02vgG3OX4Jdb6T1U0pLmJJwE0Jfl37dgHk8Iooxlug7/AjJzluszD0oawbRoKuBOJPnQStQY1C7KFTc6ms5G4qFuC9pZmeQK3RyhxRsBx9eye/h6G+O2yXZCiPPlLhmglLOSo0nO4FTNgJd8DnzE8YHIVWhcWb76RO65GjTD3bIV79MahxZrk57eHjoHDtUpwlr3c5IaQPFo79nFTtk+FNYXir2KlfGbdOGAs6GAH/Kz8aBqX8og==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR11MB3650.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(316002)(38070700005)(8676002)(5660300002)(66446008)(6916009)(7696005)(64756008)(66556008)(54906003)(52536014)(76116006)(9686003)(508600001)(26005)(122000001)(8936002)(38100700002)(66946007)(66476007)(71200400001)(6506007)(186003)(33656002)(55016003)(82960400001)(86362001)(83380400001)(2906002)(4326008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlczWWYyanZiak5qS1J1T2N3dE9ucURJMStrZm1kVjJjeU42U3Ftc0NTN3lv?=
 =?utf-8?B?aitPRFA4YnhoVjJ3ZUJvTjU1Ritmc3dQbXd6aEdCUWcwUW5VNmdKblFqZ3Vn?=
 =?utf-8?B?ZU5USG9pSTU3UW9wRGQ2R2xidUcvbkpoL2YzY1l5Rk5vNUpFaWVSeUpxc2Na?=
 =?utf-8?B?S3J2Uk56UlpSV0tia0k0RUI2aWk1cWVUNXZIT2piZG9QNkZ1cjhYTGgraTls?=
 =?utf-8?B?V29MWFVreXNFTGw0eGk2WmFUQXFNUGtCd1ZOcm0wdmdZaTZzc2tPYUk5aDRs?=
 =?utf-8?B?WGNRa2VTQWhsMWN4N3ZEWWsrdU1YeDZKYUJKSlp4V1E1Vnp3NHQ5Wnp4ZmVH?=
 =?utf-8?B?c29HazlkUXN0amh4Z3JrVmlRUkdrQ2VZMEc5REhWWGdCQ2Y0MkVVM051V29o?=
 =?utf-8?B?Ty9MS3R6UnlUZ1hqemdUM1ArVlZlSGNjN3F4T0F0cUEwYlJGaC93czlwbUFR?=
 =?utf-8?B?d3dqMzFsZHIvclZzZldEMkxLSlJROHc2TlIybmVJS051OFpGL0NwRzdBV1lF?=
 =?utf-8?B?cGFrMUdSMWVnMEw1Skt0S0JFL29ML212Q1hKMHp3enl2bGNJampkQ2d0TGh0?=
 =?utf-8?B?Z2xRZGhMQUtvT1NPMlBjZElscHZubDJxUXNVWU84alpHZEovdTVTODJlRUZj?=
 =?utf-8?B?dytKNXBGbEpLcHAvaHlXd3pUaUttR3BaQTRYTzlJOXhNd2dHbWNwU01LR29k?=
 =?utf-8?B?WmVwZTB6NFFwb2NmNDBBSFFpU3VYMGh4WkUvRm1mS1R0QlpTMk81UiszVVlh?=
 =?utf-8?B?Ym1pZmdvYzl4cG9qQmpiYXZRYlpXU1JLZzdXNmE2UnVneVRibVhka0lIcEcr?=
 =?utf-8?B?Sm8xWlR3aDhUM05nNzlqa1dETkcxVWpIaUdXaGs1elBCUmk3NmhuWXMreW9s?=
 =?utf-8?B?eXc3ejhsdW12VE1kOTBoWkhFQlloVGdWZncxZlJHUnRKaHAvSzVCMjM3R3Y1?=
 =?utf-8?B?OTdONXVyWGw5b1VNejFqRFlTaGw1MmNEcnVmL2l2TzV0Yi9rWTduZDNrc01u?=
 =?utf-8?B?TkY3enZ2bWw4VjdNSDE5RnkvNWV1QmhUSlJnZDJWYUxvMDRNcXV3L1RGRG1n?=
 =?utf-8?B?dWFIaVNqRVlDam5XTFU1UG9temZ0VXZhUC9CbnVDUkVOSDhhMUx2cHQwNHVF?=
 =?utf-8?B?Qjd3WVB3Ymh4Ymh1TTZHQjMwUGgvb29ZRzBGbElEcTFyZjd0NVZpbkpERGhp?=
 =?utf-8?B?SGxiaXhTQkJtZmh3MHN5OXVIdGdEcDJJcVVON2hmS0gzVSsxdE4rbWxFbzNm?=
 =?utf-8?B?cEF2RlFRekJpSTBFM2x2dzF4T0RZODU5K0VRNlV5bmoyYnFEZmJRUHo5SmV5?=
 =?utf-8?B?Q0pRVFg0dnFQRzNPbnllcWY3UkQrdmg3WlkzcDB4dnpZd0lkWHpmd1VGNXFQ?=
 =?utf-8?B?c3J5K1lESTJQK051clpqeGFwOG8zTGZGSk4xdzFzdCtvdFZCZ29vck1nVkxN?=
 =?utf-8?B?d2hWUzlaSTJMWEkwRzhmYnU5WWVaWFJLTlovVlBjVWZqL3V5K2Jrb2NWek8r?=
 =?utf-8?B?TFpnWFlCVVNNbWFiaEpTdzNWVW03ak5sbWNmYnd6dU8wS3l4SEV0NlFoUGhs?=
 =?utf-8?B?MXQreGptbU1PeFdIbzFUTDZRUWNuckRvUnZ4dkNjMXMyenBoQ255SGJqVVJk?=
 =?utf-8?B?NkNtZWUva0lhSmZLZmp6QW1CSXBzM0dVMzEvTmtWMnYrUjYxcnBXTTdaeGlq?=
 =?utf-8?B?dXVYRFRmaXJVN0ZSalVMd3g2VlZRZk54WnAraU5PMjBySDJYenFEN0JEWVRC?=
 =?utf-8?B?ZXZMOW9MZis0dGI5RklObytrK1dFZ2Y5c3dJczF4SW8zWGNqZExTckZnWEZn?=
 =?utf-8?B?dkhzTG8vY01SMG9EcG1BWVlNRkFXcTdSZkliK2lQZW5DTlNWQlc2TjZyRFRJ?=
 =?utf-8?B?d21vb2JlRklrcHR3NllFcDllYWhlMW1iaHc4bktVbStlVVZjdmZBMC8vSGpz?=
 =?utf-8?B?MGlXRXcwamVLc3JEQXZVRlA1eXdyM3JTSFQ0aGptOUVueVpIM0pvOE16NTVk?=
 =?utf-8?B?RGh0UVNrVzRjL3FpZ085MmZjWE0rbll1YkdaYlBzTjUxcEppTHJTR1hKbWMv?=
 =?utf-8?B?Rm9RTmpLUCsrd05yaWhpRUxvN0xDL1B4a0srenk2RExSQXpoNWtIL2lET3NJ?=
 =?utf-8?B?RDAyTEtxdFBKS2ZYVTNpTVNNTlcxNU0yZGxOcmRtU2M5NjhvZGJGY3hzSTNF?=
 =?utf-8?B?QXhUZ1I5TGl6Y2pZYWUrai9OYzJTUDdzRU9HUll6YzgyWFFLajI3cEFIMitn?=
 =?utf-8?B?M3QzY3g5U0Q1N3dyWEtjSHk3K3NnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR11MB3650.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1127a804-5ca1-4108-e39c-08d9bac3b311
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2021 03:26:33.3639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t0jQZ2s3wBZS1GmMnyD0ATkaJZrsCiaRcqv8Jt45qSplyp50BAURL9Rftnl/ZVoaPZwZrZZC7UB7M+IHiZi9tukh/rHdYq25Ojz/myn/rTM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB3939
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IExpbnVzIFdhbGxlaWogPGxp
bnVzLndhbGxlaWpAbGluYXJvLm9yZz4NCj5TZW50OiBUaHVyc2RheSwgRGVjZW1iZXIgOSwgMjAy
MSA3OjUzIEFNDQo+VG86IEQsIExha3NobWkgU293amFueWEgPGxha3NobWkuc293amFueWEuZEBp
bnRlbC5jb20+DQo+Q2M6IGxpbnV4LWdwaW9Admdlci5rZXJuZWwub3JnOyBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZzsNCj5iZ29sYXN6ZXdza2lAYmF5bGlicmUuY29tOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOw0KPmFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbTsgU2Fo
YSwgVGFtYWwgPHRhbWFsLnNhaGFAaW50ZWwuY29tPjsgTiwNCj5QYW5kaXRoIDxwYW5kaXRoLm5A
aW50ZWwuY29tPjsgRGVtYWtrYW5hdmFyLCBLZW5jaGFwcGENCj48a2VuY2hhcHBhLmRlbWFra2Fu
YXZhckBpbnRlbC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MiAxLzJdIGR0LWJpbmRpbmdz
OiBwaW5jdHJsOiBBZGQgYmluZGluZ3MgZm9yIEludGVsDQo+VGh1bmRlcmJheSBwaW5jdHJsIGRy
aXZlcg0KPg0KPkhpIExha3NobWksDQo+DQo+T24gV2VkLCBEZWMgMSwgMjAyMSBhdCA4OjI2IEFN
IDxsYWtzaG1pLnNvd2phbnlhLmRAaW50ZWwuY29tPiB3cm90ZToNCj4NCj4+ICtwYXR0ZXJuUHJv
cGVydGllczoNCj4+ICsgICdeZ3Bpb0BbMC05YS1mXSokJzoNCj4+ICsgICAgdHlwZTogb2JqZWN0
DQo+PiArDQo+PiArICAgIGRlc2NyaXB0aW9uOg0KPj4gKyAgICAgIENoaWxkIG5vZGVzIGNhbiBi
ZSBzcGVjaWZpZWQgdG8gY29udGFpbiBwaW4gY29uZmlndXJhdGlvbiBpbmZvcm1hdGlvbiwNCj4+
ICsgICAgICB3aGljaCBjYW4gdGhlbiBiZSB1dGlsaXplZCBieSBwaW5jdHJsIGNsaWVudCBkZXZp
Y2VzLg0KPj4gKyAgICAgIFRoZSBmb2xsb3dpbmcgcHJvcGVydGllcyBhcmUgc3VwcG9ydGVkLg0K
Pj4gKw0KPj4gKyAgICBwcm9wZXJ0aWVzOg0KPj4gKyAgICAgIHBpbnM6DQo+PiArICAgICAgICBk
ZXNjcmlwdGlvbjogfA0KPj4gKyAgICAgICAgICBUaGUgbmFtZShzKSBvZiB0aGUgcGlucyB0byBi
ZSBjb25maWd1cmVkIGluIHRoZSBjaGlsZCBub2RlLg0KPj4gKyAgICAgICAgICBTdXBwb3J0ZWQg
cGluIG5hbWVzIGFyZSAiR1BJTzAiIHVwIHRvICJHUElPNjYiLg0KPj4gKw0KPj4gKyAgICAgIGJp
YXMtZGlzYWJsZTogdHJ1ZQ0KPj4gKw0KPj4gKyAgICAgIGJpYXMtcHVsbC1kb3duOiB0cnVlDQo+
PiArDQo+PiArICAgICAgYmlhcy1wdWxsLXVwOiB0cnVlDQo+PiArDQo+PiArICAgICAgZHJpdmUt
c3RyZW5ndGg6DQo+PiArICAgICAgICBkZXNjcmlwdGlvbjogRHJpdmUgc3RyZW5ndGggZm9yIHRo
ZSBwYWQuDQo+PiArICAgICAgICBlbnVtOiBbMCwgMSwgMiwgMywgNCwgNSwgNiwgNywgOCwgOSwg
MTAsIDExLCAxMiwgMTMsIDE0LCAxNV0NCj4+ICsNCj4+ICsgICAgICBiaWFzLWJ1cy1ob2xkOg0K
Pj4gKyAgICAgICAgdHlwZTogYm9vbGVhbg0KPj4gKw0KPj4gKyAgICAgIGlucHV0LXNjaG1pdHQt
ZW5hYmxlOg0KPj4gKyAgICAgICAgdHlwZTogYm9vbGVhbg0KPj4gKw0KPj4gKyAgICAgIHNsZXct
cmF0ZToNCj4+ICsgICAgICAgIGRlc2NyaXB0aW9uOiBHUElPIHNsZXcgcmF0ZSBjb250cm9sLg0K
Pj4gKyAgICAgICAgICAgICAgICAgICAgICAwIC0gU2xvdw0KPj4gKyAgICAgICAgICAgICAgICAg
ICAgICAxIC0gRmFzdA0KPj4gKyAgICAgICAgZW51bTogWzAsIDFdDQo+PiArDQo+PiArYWRkaXRp
b25hbFByb3BlcnRpZXM6IGZhbHNlDQo+DQo+Q2FuJ3QgeW91IHJlZmVyZW5jZQ0KPkRvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9waW5jdHJsL3BpbmNmZy1ub2RlLnlhbWwNCj5oZXJl
Pw0KPg0KPkxvb2sgYXQgZm9yIGV4YW1wbGU6DQo+RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3BpbmN0cmwvYWN0aW9ucyxzNTAwLXBpbmN0cmwueWFtbA0KDQpJIGNhbiBkbyB0aGF0
LiBTaGFsbCBhZGQgaXQgaW4gdGhlIG5leHQgdmVyc2lvbiBvZiBwYXRjaHNldC4NCg0KUmVnYXJk
cw0KTGFrc2htaSBTb3dqYW55YSBEDQo+DQo+WW91cnMsDQo+TGludXMgV2FsbGVpag0KDQo=
