Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50ED0461AC1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 16:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244412AbhK2P2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 10:28:03 -0500
Received: from mga09.intel.com ([134.134.136.24]:56401 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344262AbhK2P0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 10:26:01 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10182"; a="235812506"
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="235812506"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 07:22:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,273,1631602800"; 
   d="scan'208";a="511724838"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP; 29 Nov 2021 07:22:43 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 29 Nov 2021 07:22:43 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Mon, 29 Nov 2021 07:22:43 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Mon, 29 Nov 2021 07:22:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gwAQ9doIscMPhbjip2LUEZ8NLMG0F/EgMB38eakrc9DqV6DlVw3KK0fN0clYR37+geQ/HO9AgzkidlFMSAB5PlZ6k14rjmICXGmC1/aRFHAdylRRW/CfEBG91hF9vQqbt4UYPXr7Qj8IjhEXmk00Efj+pyeQ/i7natvaQYghNYJUdUjwl1KTXjjLjSP1vicYJ71uxu1oy95jteVYh5Ey+kuqX4n4L0CGT3WJuswRt/darPU0Wb9nFZ28QJR1pDnkyIo0SNa8ZI8gfkwlBLeIXx4jt+dHeK4yBuEDEM4hgHdnk4BFyi1Vpv1Bknr3N/vtqP+T/f1LXWYlCy8ga5OUgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Df07gr9iCnnM2FDb+ZS3PgPT7sqw/1GwOQrF4PYZVf4=;
 b=HVR8AgcUX1AhGHA+PQOBy3cwOiahEYXv5Rt6cRY12kSSf1kwkX5IOSntIiPniY7ZyAHyBCRerW9X5zyqxgvjZxQoqdbkueGrDWlsrHuWOXm2B2OVbpwmE//SPP3FvqbLu9wCZHAj00XKEa1u7sj8HWHyX8NGNgDsVuGTkOE7lcqLio4vBXdo/Bgm3ZitVCCaIW75ZPpkzbF1Vn7HMZbEP8nVfxDNfjhMvmYhK40TrDyfjYvoS9jFQaUPLe9hV7LBQ8DpLrWYXM+kUspyrfj/ItEkobwvKNEcmdBH/9HJ8mG2yiYpc0GzuoZsHyfgP6BS+01G/eLXHsmDrPb9EGeiKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com;
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Df07gr9iCnnM2FDb+ZS3PgPT7sqw/1GwOQrF4PYZVf4=;
 b=xjCNRlYxlj9wqotoT2fJ2NSWpGMn+TMRrzM6rnweON6F7uj3u/tczWyc4u113HPde2NacYrqtYwnUqdrAbe/xy9IcaC/Jhw/+1HH2TIx6l6jzPPXAr/3CbsGzy7Myvs5Id+GAaanvwyUN35yZbmCEwGLwFlc5TmSqAi/8G6uAuY=
Received: from DM6PR11MB3660.namprd11.prod.outlook.com (2603:10b6:5:13c::17)
 by DM6PR11MB3084.namprd11.prod.outlook.com (2603:10b6:5:6c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22; Mon, 29 Nov
 2021 15:22:42 +0000
Received: from DM6PR11MB3660.namprd11.prod.outlook.com
 ([fe80::b987:803c:b0b4:fd9e]) by DM6PR11MB3660.namprd11.prod.outlook.com
 ([fe80::b987:803c:b0b4:fd9e%6]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 15:22:42 +0000
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
Subject: RE: [PATCH v1 2/2] pinctrl: Add Intel Thunder Bay pinctrl driver
Thread-Topic: [PATCH v1 2/2] pinctrl: Add Intel Thunder Bay pinctrl driver
Thread-Index: AQHX4IILIkKx1+kP6EWf92vCh2swAawU+XWAgAWt2RA=
Date:   Mon, 29 Nov 2021 15:22:42 +0000
Message-ID: <DM6PR11MB3660B018DC1826415CBD23F7C4669@DM6PR11MB3660.namprd11.prod.outlook.com>
References: <20211123155144.21708-1-lakshmi.sowjanya.d@intel.com>
 <20211123155144.21708-3-lakshmi.sowjanya.d@intel.com>
 <CACRpkdanKspORKBa2ETRvQyBkzgCssca-fFE+QcybZY=GYmMAQ@mail.gmail.com>
In-Reply-To: <CACRpkdanKspORKBa2ETRvQyBkzgCssca-fFE+QcybZY=GYmMAQ@mail.gmail.com>
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
x-ms-office365-filtering-correlation-id: 7ca5b787-535b-41c0-9ea4-08d9b34c1658
x-ms-traffictypediagnostic: DM6PR11MB3084:
x-microsoft-antispam-prvs: <DM6PR11MB3084D6894401003EA7101CA4C4669@DM6PR11MB3084.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CYIp03FWjFcBF215v1a0J/p8fm31sRF78qOsCykTkok643eRnBygjDHa6MA2tYvj54ZqlpkZc5eCwLmyeUGDXhS0v2Nx7diFmbrqo6FD1t8d9AbTAP+llw7lOwWbYwLuInYmr1izcxnbwdgGzzc17d5ZukIA15JFTSRtkmIKomwFIZKININFthcFco1ZYMMlrVEVH27HACXF8aTR2jxVAXIz/jDJL9b9oOFrJ0lScy5J9xPZC7FOGYSoQPshHYag6IsIxcY9s/vczj8NjS9H0qyy6LlSTqtsM1Vho4uLFddt/dVzuwCVOZtthtFEObG/REwlcBiLQ1yvd5JLc9SL2eVh0PcAtGjRLq9cRgB+N4C4/DmUoifs9uZXJQXP3wSegAPWUaNRBcjWQTwFNQ+MRrQlHcgVx7kiql2cgLcpm1BSe2lGju5r8fEABaTFyotyiOuSOPQ069KNdBXZNNh/7V2pS3QphAlZJNX2zZFjGvV7gsWiW1+xzoEOmOZr0YUBA2TLvBw+CIPeaPoBafI84LH58wwTRFbvsHdaVKeBFKmGzlfGJcXAQY3YoqTwrod3gln/e7glMyyhsJyvEvUYot9FEv/xd5owJxGJKC2Gmoy4hcSj4UqIH/Uj8CEq8DBjI84KqN+x8IOOA2toGkoxKuNvh++EXko9vx0u7bGoCVsrkCup8ECtIIgRJCCBrIWNsNoVXzkvS8/JK8tcscx7Jw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3660.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(55016003)(38070700005)(2906002)(9686003)(8676002)(316002)(52536014)(71200400001)(6506007)(33656002)(6916009)(122000001)(186003)(54906003)(86362001)(38100700002)(8936002)(66476007)(4326008)(83380400001)(66946007)(82960400001)(76116006)(66556008)(66446008)(64756008)(5660300002)(508600001)(7696005)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WVZSczF2L1dHVVFiYUNWZDZHVlg5VDlEWkFtck9qdkQ1OTVxT3lEZFlHbWxN?=
 =?utf-8?B?REMrV2lLejNnV3lUelVrTGVrcXVoWCtUY013WDBJQ2VpWlR6cmI5NFl1Ukp6?=
 =?utf-8?B?VlB2MWMwR0pzdUhCMmFsS1ZoeUk3TW15UWtyQUJPOHhWUkpBbk45Q3Q5MFo3?=
 =?utf-8?B?WVROcDlvSTl5TGdLSTBXZjNDN2prSmgyL0EwVmNVRWJrMlFscFQxcG1YZXNW?=
 =?utf-8?B?SjVtczNHdUJ0cWlZVVE0cHhaYXVuNDBvSFY1OXpLYkptbmoyK3pnMGhBTFln?=
 =?utf-8?B?aEk1YmdYWHBaTUNOd2VpenNabjRBZUo5SVdWQTZKZFk2Zjh1d01iTTNUVVdS?=
 =?utf-8?B?RnVDS0ZnMThZemtWamxGOHZJMkl4UWF5d1JyN3ZsRDBmVVZYdmt0V1N5K3lu?=
 =?utf-8?B?cUtJNUV2K2pzNXhzL0ltTSs3WXo3cDI2WGo2RmVyZ0dBWG9lSXVrcnF6Mi9K?=
 =?utf-8?B?dG5zaVBubkc1Mm5BY0pzWUl6RTFWb2g1SUJYREZLMFhaQ0lGOFBoT0NkQlhm?=
 =?utf-8?B?MHh1Ujh5NzZ0Z1gwVk1BTjdPL2xtVXRvcUVubUFHbTkxT1U0cHNkbTZ2b0V2?=
 =?utf-8?B?NDdjRVVCSjBjVXRsVHRPcEQzS3dYaWRHQ1ZCYytSWTd5bmZZdjhRbUhkZUs1?=
 =?utf-8?B?T3pHSkVWWkk0UGlVYjNITVd1MFV6OC9nRjBhQTc0YVRObWlTZFcvbTFuaHJj?=
 =?utf-8?B?TzZ3QjZsMHV6ZXZrM2xYN3RFWG45YXMvY01PUjFmWEUyU29INWdQQjBJdjdN?=
 =?utf-8?B?VGh5YkVFM3UrVlNEdlBBRldCMHZUQWptZGhSbXk0d1RsWHlaSG9Gc0M0VHJV?=
 =?utf-8?B?aG1ybVVWZ0ZxZnNuSlFYU3poSTdVTlV1RnVvQU1qdzg2KzE1NFpBUmRmdG1L?=
 =?utf-8?B?OHpDeExmbzFHcmVFOWs4ZWl1dmNHcURNNE1QN2ZzdzFES09pVmNhRDQ0TStR?=
 =?utf-8?B?L2x5Y0xOT3FjMzJtYWt4cUcwamtIOWFzS2VJZ3ZvRTc0bmVXYUswN3NHdzJQ?=
 =?utf-8?B?bFFWYTBvWnB0eUsvOENCTHpOVWJYVGcza2psbjRQS1lpVlFCeGkzQU9rcHIz?=
 =?utf-8?B?Q2o5MWhmKzFlTkhUWEJYd2Q0R2I1dUFQTGx0dDJvYzFOT3RIWUxyS25xVUVt?=
 =?utf-8?B?bVVBZzhsY1ZHRHFRVTZsbWUxd2s2Z3MyOGVPc21RUmFDZHIxQTlzTTdKWFFr?=
 =?utf-8?B?eS9sYXlVbTg3ZEV4S2dHbFppOW5pUHR0c2g4aUFacy8rTS9wWFNlVEJCR1ow?=
 =?utf-8?B?NGJNT3pRNjNQNHdkMkNXOUk4QzZkaU9EaWlnaFJ4bW0wRnorRU5DUW81SkRq?=
 =?utf-8?B?aUdqbHg1NlZUMTc0ekJKRjJHd0JvM0xEYjZ1bW1UbzNUTDJoUmYwSUI1aWZs?=
 =?utf-8?B?MjVHaC9JM0tOMlFQZm5DZSsrbDFXdTdYLzJTa2FKRkl1ck02UTQ0VmVIOHgz?=
 =?utf-8?B?Q1kzTUdXaDhMd0dOTjc2R0VLYkw4MVdRQzhhbmF3eTllRTBmUktGSm9DVjZa?=
 =?utf-8?B?UW1DUC9CVkkvTnBRL1NJSUk1Vys0bFFzc0FKMjM3QldKZ3N6MkdiZFhOU1VX?=
 =?utf-8?B?Z09YZUkydDl5T0NCb0h3dXdmU2tLMFk5NFM0UnZVMHh1YXVtazRzNEo5cDdv?=
 =?utf-8?B?MVpxR1dGVDZGbjN3clBKZHhMUHh4UWR1NjFvWDRuYnJTS3FGZElxT3BkajFx?=
 =?utf-8?B?eHBKSXpZRjVNUWVqZDc2SFludzNuZ0pCYWw2bTZlYU1ZVXBocjh5UVJ1d01W?=
 =?utf-8?B?aXpJVUFPajR3VU5TckRGNUtRbW9aZTVnTGZLcDl1V3FpdStmM2FqRmJXcXBM?=
 =?utf-8?B?RDM1YTB1L2tzaGRuWDdhU3ZDZ1g1dVlwMk1iQys5YzdMcCtJSWg0b0ZsSncw?=
 =?utf-8?B?Ry9JbDd2cHdEY1N4YXlURUpGZldwUzlMaWRJTFhkc0dTK0RsRXdKdU1sMFc2?=
 =?utf-8?B?USsraEJoRjZERDg5emFaSzJrcmlEc2RmbmhkRDBsMXNzVjBvYVlTTGJDTzdh?=
 =?utf-8?B?Vk55L2h5emVxY2xmcmxmdkpiZDhVTUw2WlppS3ZCeEtjNTRMVmZVQ0NicDdK?=
 =?utf-8?B?WnFOY010V0I2S3JlSnlRc0NXc0FkSDA4NFRmYUM4R3J3VFZ0WU5tRnM5NUUy?=
 =?utf-8?B?cW9NMndmaStWeFdLOUIzM0hualpCMTBUR0w4ZURaQ1ZkZEJDRDNRZVhjRXYy?=
 =?utf-8?B?Y21OUjFRbnVVa0c3RVRKTEF2N29Ub2NkZ1RGWFRXckhMcXNObm1aRlhCdEV0?=
 =?utf-8?B?SkNvRzZLQVY5TFU3cVViSVBranB3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3660.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ca5b787-535b-41c0-9ea4-08d9b34c1658
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 15:22:42.2559
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: poDencBgWqTCUZDTWD+g+i9RkWQ72ymQL/2aL/bJdOW+hGE5eye1Q0ym7ijU3foSWAZLNiAnWyPLTBBhoswwuc7ACA+zM4/Vu2S6QLkkIEQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3084
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIExpbnVzIQ0KDQo+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj5Gcm9tOiBMaW51
cyBXYWxsZWlqIDxsaW51cy53YWxsZWlqQGxpbmFyby5vcmc+DQo+U2VudDogRnJpZGF5LCBOb3Zl
bWJlciAyNiwgMjAyMSA2OjA0IEFNDQo+VG86IEQsIExha3NobWkgU293amFueWEgPGxha3NobWku
c293amFueWEuZEBpbnRlbC5jb20+DQo+Q2M6IGxpbnV4LWdwaW9Admdlci5rZXJuZWwub3JnOyBi
Z29sYXN6ZXdza2lAYmF5bGlicmUuY29tOyBsaW51eC0NCj5rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb207IFNhaGEsIFRhbWFsDQo+PHRhbWFs
LnNhaGFAaW50ZWwuY29tPjsgTiwgUGFuZGl0aCA8cGFuZGl0aC5uQGludGVsLmNvbT47IERlbWFr
a2FuYXZhciwNCj5LZW5jaGFwcGEgPGtlbmNoYXBwYS5kZW1ha2thbmF2YXJAaW50ZWwuY29tPg0K
PlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjEgMi8yXSBwaW5jdHJsOiBBZGQgSW50ZWwgVGh1bmRlciBC
YXkgcGluY3RybCBkcml2ZXINCj4NCj5IaSBMYWtzaG1pLA0KPg0KPnRoYW5rcyBmb3IgeW91ciBw
YXRjaCEgSW50ZXJlc3RpbmcgY2hpcCEgVGhpcyBpcyBsb29raW5nIHZlcnkgZ29vZC4NCj4NCj5J
IGJldCBBbmR5IHdpbGwgYWxzbyBnaXZlIHlvdSBzb21lIGF0dGVudGlvbiB0byBkZXRhaWxzIHVu
bGVzcyB5b3UgaGFkIHNvbWUNCj5hbHJlYWR5IGludGVybmFsbHkgYXQgSW50ZWwuDQo+DQo+T24g
VHVlLCBOb3YgMjMsIDIwMjEgYXQgNDo1MiBQTSA8bGFrc2htaS5zb3dqYW55YS5kQGludGVsLmNv
bT4gd3JvdGU6DQo+DQo+VGhpcyBjYXVnaHQgbXkgZXllOg0KPg0KPj4gKyNkZWZpbmUgVEhCX0JP
QVJEX1NQRUNJRklDX0dQSU9fUkVRVUlSRU1FTlRTX0hBTkRMRSAgICAoMXUpDQo+DQo+V2UgZG9u
J3QgZG8gdGhpcyBraW5kIG9mIGNvbmRpdGlvbmFscywgZWl0aGVyIGl0IGlzIHRoZXJlIG9yIG5v
dC4NCj5Ecm9wIHRoaXMgZGVmaW5lIHNpbmNlIGl0IGlzIGFsd2F5cyAxDQo+DQo+PiArI2lmIChU
SEJfQk9BUkRfU1BFQ0lGSUNfR1BJT19SRVFVSVJFTUVOVFNfSEFORExFKQ0KPj4gKw0KPj4gK3N0
YXRpYyB1MzIgdGhiX2dwaW9fYm9hcmRfcmVxdWlyZW1lbnRzX2hhbmRsZShzdHJ1Y3QgZ3Bpb19j
aGlwICpjaGlwKQ0KPj4gK3sNCj4+ICsgICAgICAgdTMyIG9mZnNldCwgcmVnOw0KPj4gKw0KPj4g
KyAgICAgICAvKiAweDQzID0gcmVnaXN0ZXIgT2Zmc2V0IGZvciBncGlvX3Bvd2VyX2ludF9zZXR1
cC80dSAqLw0KPj4gKyAgICAgICBvZmZzZXQgPSAweDQzOw0KPj4gKyAgICAgICByZWcgPSB0aGJf
Z3Bpb19yZWFkX3JlZyhjaGlwLCBvZmZzZXQpOw0KPj4gKw0KPj4gKyAgICAgICAvKiBLZWVwaW5n
IGFsbCBwb3dlciBpbnRlcnJ1cHRzIHRvIExldmVsLUhpZ2ggdHJpZ2dlcmVkIGFzIHN1Z2dlc3Rl
ZCBieQ0KPkhXIHRlYW0gKi8NCj4+ICsgICAgICAgcmVnIHw9IDB4MUU7DQo+PiArDQo+PiArICAg
ICAgIHJldHVybiB0aGJfZ3Bpb193cml0ZV9yZWcoY2hpcCwgb2Zmc2V0LCByZWcpOyB9DQo+DQo+
VGhpcyBsb29rcyBsaWtlIHNvbWV0aGluZyB0aGF0IGNhbiBqdXN0IGJlIGlubGluZWQgaW50byBw
cm9iZSgpLCBzb21lIEhXIHNldC0NCj51cD8NClllcyBpdCdzIGh3IHNldHVwLg0KVGhpcyB3aWxs
IGJlIHJlbW92ZWQgaW4gbmV4dCB2ZXJzaW9uIG9mIHRoZSBwYXRjaHNldC4gVGhlc2UgY2hhbmdl
cyBhcmUgYWNjb21tb2RhdGVkIGluIHRoZSBCSU9TLCBzbyBub3QgcmVxdWlyZWQgaW4ga2VybmVs
IGNvZGUuDQo+DQo+PiArICAgICAgIHN0cnVjdCBncGlvX2NoaXAgKmNoaXAgPSAmdHBjLT5jaGlw
Ow0KPiguLikNCj4+ICsgICAgICAgY2hpcC0+Z2V0ICAgICAgICAgICAgICAgPSB0aHVuZGVyYmF5
X2dwaW9fZ2V0X3ZhbHVlOw0KPj4gKyAgICAgICBjaGlwLT5zZXQgICAgICAgICAgICAgICA9IHRo
dW5kZXJiYXlfZ3Bpb19zZXRfdmFsdWU7DQo+DQo+SXQgc2hvdWxkIGJlIHRyaXZpYWwgdG8gYWxz
byBpbXBsZW1lbnQNCj4NCj4uc2V0X2NvbmZpZyA9IGdwaW9jaGlwX2dlbmVyaWNfY29uZmlnDQo+
DQo+anVzdCBsaWtlIHRoZSBvdGhlciBJbnRlbCBkcml2ZXJzLiBUaGlzIGlzIGdyZWF0IGJlY2F1
c2UgaXQgd2lsbCBtYWtlIHRoaW5ncyBsaWtlIHRoZQ0KPmdlbmVyaWMgYml0LWJhbmdlZCBHUElP
IEkyQyBidXMgdXNlIHRoZSBvcGVuIGRyYWluIGhhcmR3YXJlIHN1cHBvcnQgZnJvbQ0KPnRoZSBj
aGlwLiAoRXRjKQ0KDQpXaWxsIGJlIGFkZGVkIGluIHRoZSBuZXh0IHZlcnNpb24gb2YgcGF0Y2hz
ZXQuDQo+DQo+PiArICAgICAgIC8qIFJlZ2lzdGVyIHBpbiBtYXBwaW5nIGJldHdlZW4gR1BJTyBh
bmQgUGluQ29udHJvbCAqLw0KPj4gKyAgICAgICByZXQgPSBncGlvY2hpcF9hZGRfcGluX3Jhbmdl
KGNoaXAsIGRldl9uYW1lKHRwYy0+ZGV2KSwgMCwgMCwgY2hpcC0NCj4+bmdwaW8pOw0KPj4gKyAg
ICAgICBpZiAocmV0KSB7DQo+PiArICAgICAgICAgICAgICAgZGV2X2Vycih0cGMtPmRldiwgIkZh
aWxlZCB0byBhZGQgZ3Bpb2NoaXAgcGluIHJhbmdlXG4iKTsNCj4+ICsgICAgICAgICAgICAgICBy
ZXR1cm4gcmV0Ow0KPj4gKyAgICAgICB9DQo+DQo+SXQncyB1c3VhbGx5IGJldHRlciB0byBwdXQg
dGhlc2UgcmFuZ2VzIGludG8gdGhlIGRldmljZSB0cmVlLiBUaGUgZ3Bpb2xpYiBjb3JlIHdpbGwN
Cj5oYW5kbGUgaXQuIFNlZSBncGlvLXJhbmdlcyBpbg0KPkRvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9ncGlvL2dwaW8udHh0DQoNClRoYW5rcywNClRoaXMgd2lsbCBiZSB0YWtlbiBj
YXJlIGluIG5leHQgdmVyc2lvbi4NCg0KPg0KPj4gKyNpZiAoVEhCX0JPQVJEX1NQRUNJRklDX0dQ
SU9fUkVRVUlSRU1FTlRTX0hBTkRMRSkNCj4+ICsgICAgICAgLyogZnVuY3Rpb24gdG8gaGFuZGxl
IFRIQiBib2FyZCBzcGVjaWZpYyByZXF1aXJlbWVudHMgKi8NCj4+ICsgICAgICAgcmV0ID0gdGhi
X2dwaW9fYm9hcmRfcmVxdWlyZW1lbnRzX2hhbmRsZShjaGlwKTsNCj4+ICsjZW5kaWYNCj4NCj5K
dXN0IGlubGluZSB0aGF0IGZ1bmN0aW9uJ3MgY29kZSBpbiBoZXJlLg0KV2lsbCBiZSByZW1vdmVk
Lg0KPg0KPllvdXJzLA0KPkxpbnVzIFdhbGxlaWoNCg0KUmVnYXJkcywNClNvd2phbnlhDQo=
