Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 538385B1FE1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 16:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbiIHN76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 09:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbiIHN7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 09:59:24 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8833C10C9B3;
        Thu,  8 Sep 2022 06:58:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1662645523; x=1694181523;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=68ophpEsqtM38jmBb+9KtFtd0vdOu7KAtRfvvrGkGxo=;
  b=M2biU6dCC+Rmn44m9HhyLKb/KaOSF46diuAXAs+YL5rjdG/HsmtKptsW
   vTnSn6ndEqLxYu/kDILWzbYnhq6i9bL7vQIrent/16nf7peOXftbO8irJ
   fWWRs8K5Lnig1j9WVH/lCYibWLHykGhNZIE0ZjUWQwZVE6/c+jVcaxr+y
   9uTwH+1Ha031P7w358AiNHwfHB+i9vvg8x4TYIG2qN0eQJiP1lqyRN10t
   6RBT8+B0CwGlv7uRDfaCidq6Xha+hclTllK45ggNEyWyN5vMkVhow2O5F
   o0L8lzqlbHmtUO8d1lU0rbRZ5dmWZn3DL1skQz5TAq11XM1iAicmjzLj1
   g==;
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="112754929"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Sep 2022 06:58:41 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Thu, 8 Sep 2022 06:58:41 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.12 via Frontend
 Transport; Thu, 8 Sep 2022 06:58:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XXSuVgW5oAFeQP5fWYirSy7CFPmn+SsAAjBmB5K6EHD7+l/gEb2m3o3sVjmP5eMM5ZuAlBASS1Grx6XlTac8epPLVLXEsats3MyvKCDHbbmEUUc+iNd5gApP+g2gPramBOgf/6O5smKJAErK1TZErvpgCjN44PpO9pEzBEewOUXdNSerlBCbCLOoQlkqSoqhyKhNrcnXO7lj4++lT4PrSsYIGmFssf2XKUpnytdyI3Q/v4VEel+Seygwy3YqgvoqnS2ePk9P3Cg5DKoU1uQlq2H/jwL4X/hEYrVxWPjcW48/igPiibXRt4kdSiyPWTii1pnzTpl6m6q5OMidj//RwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=68ophpEsqtM38jmBb+9KtFtd0vdOu7KAtRfvvrGkGxo=;
 b=O5yNasgxVwet7heZZ5rQfp3LYD5ZLrdP1i+dhZ0bXc8wtVyzReZCctQzugGmQET7CUl6O9XhlggQKqU4qavy6XpBKuvXnGytBRklUy3gn70DBawkZDxQAFBS0cFnlu+ttgS+72+cLmPXaC74ehIgfh17jjbTcxlILzGddGA77f0OG4oZDcX5CWStRyu0tVnfHo9hi9xFt5eePsgjLoDaiOdYUmO1EO9oLmIcY87LHZ9yS0kT0WOPOo5dtg5sebut4t4Ml8XT69+KS8TTvwBbzb/brTjdAGdFlpIsM5TW1rBBM1rV4Qs36+6qKYDLq2y75DYt0hPfB7+2Jhj+hYWqKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=68ophpEsqtM38jmBb+9KtFtd0vdOu7KAtRfvvrGkGxo=;
 b=gPYi1VvIqqmc4V8PBOGmtxTJ2CgCoioDJtDLoxATpRDjni5eGKK6xK0mdhvnuOPq6BtNLUTf1V0Dt7GV6VK7nlXy9kqukZef/PWF5tBPQtmyn65stNTOT0Qq/BYhlm9O5tYbsAO6Z0SWawQj4K6S7yMK1oqLYBVgCFeQpK+SZXA=
Received: from MWHPR11MB1693.namprd11.prod.outlook.com (2603:10b6:300:2b::21)
 by CY4PR1101MB2086.namprd11.prod.outlook.com (2603:10b6:910:1c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Thu, 8 Sep
 2022 13:58:34 +0000
Received: from MWHPR11MB1693.namprd11.prod.outlook.com
 ([fe80::ccae:ffc6:d9f5:8535]) by MWHPR11MB1693.namprd11.prod.outlook.com
 ([fe80::ccae:ffc6:d9f5:8535%9]) with mapi id 15.20.5612.019; Thu, 8 Sep 2022
 13:58:34 +0000
From:   <Jerry.Ray@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Claudiu.Beznea@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v6 2/2] ARM: dts: at91: Adding SAMA5D3-EDS board
Thread-Topic: [PATCH v6 2/2] ARM: dts: at91: Adding SAMA5D3-EDS board
Thread-Index: AQHYvwFp8Od1EQWLAkC3vC8jcHRCTq3VcuSAgAAlItA=
Date:   Thu, 8 Sep 2022 13:58:34 +0000
Message-ID: <MWHPR11MB1693B3327E7061DB8DDB5577EF409@MWHPR11MB1693.namprd11.prod.outlook.com>
References: <20220902192236.14862-1-jerry.ray@microchip.com>
 <20220902192236.14862-2-jerry.ray@microchip.com>
 <bc6f19f3-0825-7c9c-c11d-92474bb12375@linaro.org>
In-Reply-To: <bc6f19f3-0825-7c9c-c11d-92474bb12375@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MWHPR11MB1693:EE_|CY4PR1101MB2086:EE_
x-ms-office365-filtering-correlation-id: 08c1cbd1-b104-47da-7fce-08da91a23856
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jyqnF7k2r3dR8Zc47r+EMbdOtVpT5u9J4hFwgW5+UQobZ6uYHj7njpz/8Zt1YmQrhlBD8Cli77XauPgApNyhxJroeZrTME+Z+HpkUQqO6XlVvb2EhF12C0z/gQ6X5C311/pZ3Fhp/lVZ5CnWwo35asUyXwkKz3PP0EAySI+2sq2YwldD8uxRSRqtPgMuZRvL5RQDNraWBGihiqHKFYXyb34PZsarE5u7fm1v5ftBR+p60QrUsr5FMBEMeXH+Y7kVH8JZqt3mnmb1QD9fXLvri9jx637Zi6IMpxz9H7c7/ttKNU6N+3a367Rwn1nV4X9lWs7+YP6x9NZL8Zl73XaPqEFed46dzMgHGyo1gxd+2UgQr46IltJeJ4f9BAlAxGN10FU8unhsRKLInwAG7uNM8fgKbbmyz9EUXGVatlRC0quxV4Y3D838p80qPYsAGgEqTK5Junsk28xS+A2Q4FTdYb+W7idRnU7uI9gsNlYTh2km+b8rLtlckv1G9X115rH7eQwRSvpeCo8hoc8MH+rAMnlTYBIQy58VDF/0QfZBrsu4PrmdMR0K3pwkTP7gtTYEZNcgMv8vdR1tROttZ6aDVwrfoHFBBvHMGJ1k0vlVCnCY3A9k7qsr//ADjHt3aiTfbMj5LKn+lyGmHklEAjq9gvWSXFGEtTtTAjSwnpV6Lnrwe3ipGUJP/e2MOjIFjVLK9ad9Eg+L6CIHv5DQC9wB7oDjdzOMgpt8yWCMyXt2aMESBtPdu9VlfzZL6RQBuRCbZHhTK+KFdsHvFCpmpoKtCA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR11MB1693.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(39860400002)(346002)(366004)(396003)(186003)(122000001)(38100700002)(83380400001)(8936002)(8676002)(5660300002)(66446008)(66946007)(33656002)(64756008)(2906002)(71200400001)(55016003)(26005)(508600001)(52536014)(66556008)(7696005)(6506007)(66476007)(110136005)(9686003)(41300700001)(76116006)(38070700005)(316002)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NmVmcVgwL0J5WlpsZ3FMbmNWaVhZbVJtcUJ2LzRpMys1WWJJb0FHYnowRG4y?=
 =?utf-8?B?YWlqd0RRM3lpZ1lPU0NDay82OW9hengrMHc5TnM3eVppSDJsT2FKM2RSemVh?=
 =?utf-8?B?OXM3bnZoN0JBUDJETEpZMkhnNTNiY1h3RERtaHVSUndnajFqc2ZTNWJjY2sz?=
 =?utf-8?B?Qjh3cHRIVzZRMDE5dVpLZ1B5eHdYckFpMkMrTTVlNHIvbmJZbkRMSlIyeEdW?=
 =?utf-8?B?akh0cnBDK0RiTCtIYWUxVUhOYnRzQ1NCa0ZTaTRRRllpN1VTdmUydjhNcHNs?=
 =?utf-8?B?em1ka1ZLdVoxRk5LRnQvRkVMREF0d1YvdENtcTJrQnBUdFFna1dWN0ZRSTRt?=
 =?utf-8?B?WVdsbDVrNGdOdnF1dDU3QmZOMllyNFNIdzBFY1pkZUFSdmFLVU8rc0RISlFB?=
 =?utf-8?B?d2pCQzc2ZkJTVHZDbEhWR3FpYXA3cXV4OEdvNWthalBRdkpNUmxjQVhvMkps?=
 =?utf-8?B?SDdIL0ZzNGlxNG0vakNTNURKVmNHaFhBR2V6TC9weUg2K2ZhdXFhUUdzZTJj?=
 =?utf-8?B?YVZqdkFCM1ZSd3FZN3QvRnJGTzdiY2hNSjljamNGdm1GYzhDc1BMWEIybDhj?=
 =?utf-8?B?MTZqLzhRdDNNMkFBYXd3UkVZVzE0WkVFVDJ0SkYzb1dIdFNQY0RTcEhqRE1m?=
 =?utf-8?B?OFEzV2p5bndpSU5YYU1Hd0dlTDEwVGJaaEw5Njd4ZCs4M0cxdFZPMmMzeFJz?=
 =?utf-8?B?TU5jR05OakVNUmsyUzlyQVd0OXorVnFQTTVuZ0ZPTEdUNHRPNVdGSjcvR3By?=
 =?utf-8?B?SkNlRlc4MWZIeENvWGlpNWpmRFdIMkZZd1NIS3psM2hvOWNNaWtmUWpRR2Fa?=
 =?utf-8?B?RVJwcFNKcnJTaGFUVldqeVAvQkZ1dXhkZUpGaG9UQ1pXTVAwZ3hhZmY1RUtJ?=
 =?utf-8?B?NEdUTUVDTW5JUk0xTjgrcWZ0SjUvVUFiNlN6UExGcGs4Qi9EeTkveEhTVS9u?=
 =?utf-8?B?YmVGUmY3YThZRDVWRDloL240U0RQb2V0WjJyRTVHVms5YnFORGtZQlBqRXps?=
 =?utf-8?B?OUtBUVRrVC81QUpJamtqOW9kYU9HRHNvY0lqUFp1WnBCK0REMlRqbnllVW1D?=
 =?utf-8?B?VGFNZ0F0Y3BNV2tCOTIvTVdiVXc3dytVZlBUTk01TmJGMURsM3dKNEdvYVcx?=
 =?utf-8?B?azFXck1Rd0tEVDN5M2lWV3lJVVBJYkFRdzFEcVVxa3RaY3ZZcDBxaExuK0p2?=
 =?utf-8?B?N1JTMHAzWVcvbjNWLzVpWGdKNmFUakRYRUNjZzJEalVSaE1LM3ZyeFA5L0U5?=
 =?utf-8?B?MmRLL0pDb1RQVmVrK3ZCSHRiY0VSR1VaQWxTK2NPSXBKekl3VTNMVEpTMFhG?=
 =?utf-8?B?ZlVaY0wzTEpEaDFTdStxWU9aa1J3MmI1eWIwZWllOE5qVXBsT0VwWm9Oa1hQ?=
 =?utf-8?B?czh1OVl1bmhLN3dGWWFZWTZ0cU9kWUdsUmE2TXdib0U0K1F2VEVwVkxSbldB?=
 =?utf-8?B?MjZJNlJTVFpDL1A0UjBCMVhoZExtd2M4Nkx1NGgyejhvbWVGcElDbFlJL0xB?=
 =?utf-8?B?eWxoRHhpSk1yQmswTkd2K2FhTFljaGtidWo5R0NqUmhnVGdRSzk1NnFiYTdR?=
 =?utf-8?B?NWZmSWVaNE16VklaSnZudGVpcUtqQmUvY1Rsb3JXUjFaT1Z1cHRkQXpaR2pj?=
 =?utf-8?B?MlJudkRIbXIyaFFRVWFoSUZxL1dNU1U4dzhQaEp6cTBjQVBnby90K1ZRNHpU?=
 =?utf-8?B?VFRXZEo5R2hHeUlScytTSkFlRkxSOHdMN3plczBZYXhWOTBGc2dVUzRSSnBS?=
 =?utf-8?B?eHdpY0NFNzVUWjViUCszNTJLdEhLRU1BQ0JyUjZjT0tkVDJXaXRvakY3eTdC?=
 =?utf-8?B?WWdqd3ViZ2dIK0dwTjNFLzhSdXpWbndZUHE0UHhrNGVzSm9obG5pRlFycWVG?=
 =?utf-8?B?dGFUVUNqU0JoR0hwSmZOTjZYMW0zMjFJZFptN3dneGhQdm1sZHhTd0tZSGRM?=
 =?utf-8?B?NGpad2ZzL3dmRWRZZ2p4Q2p5cTdhQ3JxVXl4Mmd0N2hWU2MzZCt3QmJpK1du?=
 =?utf-8?B?WVk0bUdXQlkxYmlzSi9STzBnYUZJZVVNdUtpdXZrY04rOUxUTTBDbzc1ZFFS?=
 =?utf-8?B?YkJhZ0QzRUR4dys5R0w0TzZ3SFgraXRyWTl3OFB1WWN2UjYyWFgxQm03VDFC?=
 =?utf-8?Q?KU0ud/5zSAUO5e5aZX5BnD8vI?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1693.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c1cbd1-b104-47da-7fce-08da91a23856
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Sep 2022 13:58:34.2112
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oEyA4otm3GMSWq8WwSV7pLsIvtDmqvbv0U1jgdkmryeLqUDp375PAd0zyTbxgbrr+nxQFRFDCR5m+HwuVMkN6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2086
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pk9uIDAyLzA5LzIwMjIgMjE6MjIsIEplcnJ5IFJheSB3cm90ZToNCj4+IFRoZSBTQU1BNUQzLUVE
UyBib2FyZCBpcyBhbiBFdGhlcm5ldCBEZXZlbG9wbWVudCBQbGF0Zm9ybSBhbGxvd2luZyBmb3Ig
DQo+PiBldmFsdWF0aW5nIG1hbnkgTWljcm9jaGlwIGV0aGVybmV0IHN3aXRjaCBhbmQgUEhZIHBy
b2R1Y3RzLiAgVmFyaW91cyANCj4+IGRhdWdodGVyIGNhcmRzIGNhbiBjb25uZWN0IHVwIHZpYSBh
biBSR01JSSBjb25uZWN0b3Igb3IgYW4gUk1JSSBjb25uZWN0b3IuDQo+Pg0KPj4gVGhlIEVEUyBi
b2FyZCBpcyBub3QgaW50ZW5kZWQgZm9yIHN0YW5kLWFsb25lIHVzZSBhbmQgaGFzIG5vIGV0aGVy
bmV0IA0KPj4gY2FwYWJpbGl0aWVzIHdoZW4gbm8gZGF1Z2h0ZXIgYm9hcmQgaXMgY29ubmVjdGVk
LiAgQXMgc3VjaCwgdGhpcyANCj4+IGRldmljZSB0cmVlIGlzIGludGVuZGVkIHRvIGJlIHVzZWQg
d2l0aCBhIERUIG92ZXJsYXkgZGVmaW5pbmcgdGhlIGFkZC1vbiBib2FyZC4NCj4+IFRvIGJldHRl
ciBlbnN1cmUgY29uc2lzdGVuY3ksIHNvbWUgaXRlbXMgYXJlIGRlZmluZWQgaGVyZSBhcyBhIGZv
cm0gb2YgDQo+PiBkb2N1bWVudGF0aW9uIHNvIHRoYXQgYWxsIGFkZC1vbiBvdmVybGF5cyB3aWxs
IHVzZSB0aGUgc2FtZSB0ZXJtcy4NCj4+DQo+PiBHb29nbGUgc2VhcmNoIGtleXdvcmRzOiAiTWlj
cm9jaGlwIFNBTUE1RDMtRURTIg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEplcnJ5IFJheSA8amVy
cnkucmF5QG1pY3JvY2hpcC5jb20+DQo+PiAtLS0NCj4+IHY1LT52NjoNCj4+ICAtIFJlcGxhY2Vk
IHVuZGVyc2NvcmVzIGluIG5hbWVzIHdoZXJlIEkgY2FuLCBpbXByb3ZpbmcgbmFtaW5nLg0KPj4g
djQtPnY1Og0KPj4gIC0gcGF0Y2ggbm93IGFwcGxpZXMgdG8gdjYuMC1yYzINCj4+IHYzLT52NDoN
Cj4+ICAtIEZpeGVkIHJlZ3VsYXRvcnMgYXMgbmVjZXNzYXJ5IHRvIGdldCB0aGUgYm9hcmQgdG8g
Ym9vdCBmcm9tIFNEIENhcmQuDQo+PiB2Mi0+djM6DQo+PiAgLSBBbHBoYWJldGl6ZWQgcGluY3Ry
bCBlbnRyaWVzLg0KPj4gIC0gY2xlYW5lZCB1cCBhIHdhcm5pbmcgaW4gdGhlIHJlZ3VsYXRvcnMg
c2VjdGlvbi4NCj4+ICAtIExpY2Vuc2UgdHdlYWtlZCB0byAnT1IgTUlUJw0KPj4gIC0gSW5jbHVk
ZWQgTWFrZWZpbGUgY2hhbmdlDQo+PiB2MS0+djI6DQo+PiAgLSBNb2RpZmllZCB0aGUgY29tcGF0
aWJsZSBmaWVsZCBpbiB0aGUgZGV2aWNlIHRyZWUgdG8gcmVmbGVjdCBNaWNyb2NoaXANCj4+ICAg
IEV0aGVybmV0IERldmVsb3BtZW50IFN5c3RlbSBCb2FyZC4NCj4+IC0tLQ0KPj4gIGFyY2gvYXJt
L2Jvb3QvZHRzL01ha2VmaWxlICAgICAgICAgICAgIHwgICAxICsNCj4+ICBhcmNoL2FybS9ib290
L2R0cy9hdDkxLXNhbWE1ZDNfZWRzLmR0cyB8IDMwOSANCj4+ICsrKysrKysrKysrKysrKysrKysr
KysrKysNCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDMxMCBpbnNlcnRpb25zKCspDQo+PiAgY3JlYXRl
IG1vZGUgMTAwNjQ0IGFyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTVkM19lZHMuZHRzDQo+Pg0K
Pj4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL01ha2VmaWxlIGIvYXJjaC9hcm0vYm9v
dC9kdHMvTWFrZWZpbGUgDQo+PiBpbmRleCAwNWQ4YWVmNmU1ZDIuLmU5MmU2MzlhMmRjMyAxMDA2
NDQNCj4+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL01ha2VmaWxlDQo+PiArKysgYi9hcmNoL2Fy
bS9ib290L2R0cy9NYWtlZmlsZQ0KPj4gQEAgLTYxLDYgKzYxLDcgQEAgZHRiLSQoQ09ORklHX1NP
Q19TQU1fVjcpICs9IFwNCj4+ICAgICAgIGF0OTEtc2FtYTVkMl9pY3AuZHRiIFwNCj4+ICAgICAg
IGF0OTEtc2FtYTVkMl9wdGNfZWsuZHRiIFwNCj4+ICAgICAgIGF0OTEtc2FtYTVkMl94cGxhaW5l
ZC5kdGIgXA0KPj4gKyAgICAgYXQ5MS1zYW1hNWQzX2Vkcy5kdGIgXA0KPj4gICAgICAgYXQ5MS1z
YW1hNWQzX2tzejk0NzdfZXZiLmR0YiBcDQo+PiAgICAgICBhdDkxLXNhbWE1ZDNfeHBsYWluZWQu
ZHRiIFwNCj4+ICAgICAgIGF0OTEtZHZrX3NvbTYwLmR0YiBcDQo+PiBkaWZmIC0tZ2l0IGEvYXJj
aC9hcm0vYm9vdC9kdHMvYXQ5MS1zYW1hNWQzX2Vkcy5kdHMgDQo+PiBiL2FyY2gvYXJtL2Jvb3Qv
ZHRzL2F0OTEtc2FtYTVkM19lZHMuZHRzDQo+PiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPj4gaW5k
ZXggMDAwMDAwMDAwMDAwLi5iNGZlMWM1ZjI5OTcNCj4+IC0tLSAvZGV2L251bGwNCj4+ICsrKyBi
L2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEtc2FtYTVkM19lZHMuZHRzDQo+PiBAQCAtMCwwICsxLDMw
OSBAQA0KPj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wKyBPUiBNSVQNCj4+
ICsvKg0KPj4gKyAqIGF0OTEtc2FtYTVkM19lZHMuZHRzIC0gRGV2aWNlIFRyZWUgZmlsZSBmb3Ig
dGhlIFNBTUE1RDMgRXRoZXJuZXQNCj4+ICsgKiAgICBEZXZlbG9wbWVudCBTeXN0ZW0gYm9hcmQu
DQo+PiArICoNCj4+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjIgTWljcm9jaGlwIFRlY2hub2xvZ3kg
SW5jLiBhbmQgaXRzIHN1YnNpZGlhcmllcw0KPj4gKyAqDQo+PiArICogQXV0aG9yOiBKZXJyeSBS
YXkgPGplcnJ5LnJheUBtaWNyb2NoaXAuY29tPiAgKi8gL2R0cy12MS87ICNpbmNsdWRlIA0KPj4g
KyJzYW1hNWQzNi5kdHNpIg0KPj4gKw0KPj4gKy8gew0KPj4gKyAgICAgbW9kZWwgPSAiU0FNQTVE
MyBFdGhlcm5ldCBEZXZlbG9wbWVudCBTeXN0ZW0iOw0KPj4gKyAgICAgY29tcGF0aWJsZSA9ICJt
aWNyb2NoaXAsc2FtYTVkMy1lZHMiLCAiYXRtZWwsc2FtYTVkMzYiLA0KPj4gKyAgICAgICAgICAg
ICAgICAgICJhdG1lbCxzYW1hNWQzIiwgImF0bWVsLHNhbWE1IjsNCj4+ICsNCj4+ICsgICAgIGNo
b3NlbiB7DQo+PiArICAgICAgICAgICAgIHN0ZG91dC1wYXRoID0gInNlcmlhbDA6MTE1MjAwbjgi
Ow0KPj4gKyAgICAgfTsNCj4+ICsNCj4+ICsgICAgIGNsb2NrcyB7DQo+PiArICAgICAgICAgICAg
IHNsb3dfeHRhbCB7DQo+DQo+Tm8gdW5kZXJzY29yZXMgaW4gbm9kZSBuYW1lcy4gT3ZlcnJpZGUg
YnkgbGFiZWwuDQo+DQo+PiArICAgICAgICAgICAgICAgICAgICAgY2xvY2stZnJlcXVlbmN5ID0g
PDMyNzY4PjsNCj4+ICsgICAgICAgICAgICAgfTsNCj4+ICsNCj4+ICsgICAgICAgICAgICAgbWFp
bl94dGFsIHsNCj4+ICsgICAgICAgICAgICAgICAgICAgICBjbG9jay1mcmVxdWVuY3kgPSA8MTIw
MDAwMDA+Ow0KPj4gKyAgICAgICAgICAgICB9Ow0KPj4gKyAgICAgfTsNCj4+ICsNCj4+ICsgICAg
IGdwaW8gew0KPj4gKyAgICAgICAgICAgICBjb21wYXRpYmxlID0gImdwaW8ta2V5cyI7DQo+PiAr
DQo+PiArICAgICAgICAgICAgIHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+PiArICAgICAg
ICAgICAgIHBpbmN0cmwtMCA9IDwmcGluY3RybF9rZXlfZ3Bpbz47DQo+PiArDQo+PiArICAgICAg
ICAgICAgIGJ1dHRvbi0zIHsNCj4+ICsgICAgICAgICAgICAgICAgICAgICBsYWJlbCA9ICJQQl9V
U0VSIjsNCj4+ICsgICAgICAgICAgICAgICAgICAgICBncGlvcyA9IDwmcGlvRSAyOSBHUElPX0FD
VElWRV9MT1c+Ow0KPj4gKyAgICAgICAgICAgICAgICAgICAgIGxpbnV4LGNvZGUgPSA8MHgxMDQ+
Ow0KPj4gKyAgICAgICAgICAgICAgICAgICAgIHdha2V1cC1zb3VyY2U7DQo+PiArICAgICAgICAg
ICAgIH07DQo+PiArICAgICB9Ow0KPj4gKw0KPj4gKyAgICAgbWVtb3J5QDIwMDAwMDAwIHsNCj4+
ICsgICAgICAgICAgICAgcmVnID0gPDB4MjAwMDAwMDAgMHgxMDAwMDAwMD47DQo+PiArICAgICB9
Ow0KPj4gKw0KPj4gKyAgICAgdmNjXzN2M19yZWc6IGJ1Y2stcmVndWxhdG9yLTEgew0KPg0KPktl
ZXAgY29uc2lzdGVudCBwcmVmaXggb3Igc3VmZml4LCBzbzoNCj5yZWd1bGF0b3ItYnVjay0xDQo+
DQo+PiArICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAicmVndWxhdG9yLWZpeGVkIjsNCj4+ICsg
ICAgICAgICAgICAgcmVndWxhdG9yLW5hbWUgPSAiVkNDXzNWMyI7DQo+PiArICAgICAgICAgICAg
IHJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDMzMDAwMDA+Ow0KPj4gKyAgICAgICAgICAgICBy
ZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwzMzAwMDAwPjsNCj4+ICsgICAgICAgICAgICAgcmVn
dWxhdG9yLWFsd2F5cy1vbjsNCj4+ICsgICAgIH07DQo+PiArDQo+PiArICAgICB2Y2NfMnY1X3Jl
ZzogbGRvLXJlZ3VsYXRvci0yIHsNCj4NCj5yZWd1bGF0b3ItbGRvLTENCj4od2h5IG51bWJlcmlu
ZyBvZiBMRE8gcmVndWxhdG9ycyBzdGFydHMgZnJvbSAyPyBrZWVwIHNvbWUgc2Vuc2UgaW4gdGhp
cykNCj4NCj4NCg0KVGhlcmUgYXJlIE4gcmVndWxhdG9ycyBvbiB0aGUgYm9hcmQsIHNvIHRoZXkg
YXJlIG51bWJlcmVkIDEgdGhydSBOLg0KUmVndWxhdG9yIDIgaXMgcmVndWxhdG9yIDIgd2hldGhl
ciBpdCdzIGEgYnVjayBvciBMRE8uDQoNCj4+ICsgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJy
ZWd1bGF0b3ItZml4ZWQiOw0KPj4gKyAgICAgICAgICAgICByZWd1bGF0b3ItbmFtZSA9ICJWQ0Nf
MlY1IjsNCj4+ICsgICAgICAgICAgICAgcmVndWxhdG9yLW1pbi1taWNyb3ZvbHQgPSA8MjUwMDAw
MD47DQo+PiArICAgICAgICAgICAgIHJlZ3VsYXRvci1tYXgtbWljcm92b2x0ID0gPDI1MDAwMDA+
Ow0KPj4gKyAgICAgICAgICAgICByZWd1bGF0b3ItYWx3YXlzLW9uOw0KPj4gKyAgICAgICAgICAg
ICB2aW4tc3VwcGx5ID0gPCZ2Y2NfM3YzX3JlZz47DQo+PiArICAgICB9Ow0KPj4gKw0KPj4gKyAg
ICAgdmNjXzF2OF9yZWc6IGxkby1yZWd1bGF0b3ItMyB7DQo+PiArICAgICAgICAgICAgIGNvbXBh
dGlibGUgPSAicmVndWxhdG9yLWZpeGVkIjsNCj4+ICsgICAgICAgICAgICAgcmVndWxhdG9yLW5h
bWUgPSAiVkNDXzFWOCI7DQo+PiArICAgICAgICAgICAgIHJlZ3VsYXRvci1taW4tbWljcm92b2x0
ID0gPDE4MDAwMDA+Ow0KPj4gKyAgICAgICAgICAgICByZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9
IDwxODAwMDAwPjsNCj4+ICsgICAgICAgICAgICAgcmVndWxhdG9yLWFsd2F5cy1vbjsNCj4+ICsg
ICAgICAgICAgICAgdmluLXN1cHBseSA9IDwmdmNjXzN2M19yZWc+Ow0KPj4gKyAgICAgfTsNCj4+
ICsNCj4+ICsgICAgIHZjY18xdjJfcmVnOiBidWNrLXJlZ3VsYXRvci00IHsNCj4+ICsgICAgICAg
ICAgICAgY29tcGF0aWJsZSA9ICJyZWd1bGF0b3ItZml4ZWQiOw0KPj4gKyAgICAgICAgICAgICBy
ZWd1bGF0b3ItbmFtZSA9ICJWQ0NfMVYyIjsNCj4+ICsgICAgICAgICAgICAgcmVndWxhdG9yLW1p
bi1taWNyb3ZvbHQgPSA8MTIwMDAwMD47DQo+PiArICAgICAgICAgICAgIHJlZ3VsYXRvci1tYXgt
bWljcm92b2x0ID0gPDEyMDAwMDA+Ow0KPj4gKyAgICAgICAgICAgICByZWd1bGF0b3ItYWx3YXlz
LW9uOw0KPj4gKyAgICAgfTsNCj4+ICsNCj4+ICsgICAgIHZjY19tbWMwX3JlZzogZml4ZWRyZWd1
bGF0b3ItbW1jMCB7DQo+DQo+SnVzdCByZWd1bGF0b3ItbW1jMA0KPg0KDQpPa2F5Lg0KDQo+PiAr
ICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAicmVndWxhdG9yLWZpeGVkIjsNCj4+ICsgICAgICAg
ICAgICAgcmVndWxhdG9yLW5hbWUgPSAibW1jMC1jYXJkLXN1cHBseSI7DQo+PiArICAgICAgICAg
ICAgIHJlZ3VsYXRvci1taW4tbWljcm92b2x0ID0gPDMzMDAwMDA+Ow0KPj4gKyAgICAgICAgICAg
ICByZWd1bGF0b3ItbWF4LW1pY3Jvdm9sdCA9IDwzMzAwMDAwPjsNCj4+ICsgICAgICAgICAgICAg
cmVndWxhdG9yLWFsd2F5cy1vbjsNCj4+ICsgICAgICAgICAgICAgcGluY3RybC1uYW1lcyA9ICJk
ZWZhdWx0IjsNCj4+ICsgICAgICAgICAgICAgcGluY3RybC0wID0gPCZwaW5jdHJsX3ZjY19tbWMw
X3JlZ19ncGlvPjsNCj4+ICsgICAgICAgICAgICAgZ3BpbyA9IDwmcGlvRSAyIEdQSU9fQUNUSVZF
X0xPVz47DQo+PiArICAgICB9Ow0KPg0KPg0KPkJlc3QgcmVnYXJkcywNCj5Lcnp5c3p0b2YNCj4N
Cg0KUmVnYXJkcywNCkplcnJ5Lg0K
