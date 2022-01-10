Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E47C5489AF0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234993AbiAJN6o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:58:44 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:28651 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234923AbiAJN6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:58:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1641823122; x=1673359122;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=0DYBrNg1VjoxXmDJnHUAWnsgEGeV2sVxrp9Lel/dc8Y=;
  b=ePyyRqlONFO7pezu1pwWB7fMouHXHhwYngw5dz7YQJQxMbmzB28mDiXW
   4ZRZbZwRNhCQckAA5zdq5ZViOoubLrMHfOubf+cQ8JzxL4RqxP4/4UHEo
   j1hj7Bj3fJ1k4Fs+/Q4M6xLyJSOfqemPVCm+Y4hs1ZFatLbq1kiSD+fwa
   LuojEiKyUDNMBP+WIUoBgg61yDFGuw8fLgBPlU30dHROSw8yckVTthU9o
   sUJAeHqoS3pZKCYI3erHRa+mgo9CyDHvDnpkqgEZEnRZrTA5Jl0FnayjX
   jEmr36QXXOojki5bv9Nu2VniGkXn0RQX5BwIPYHnGj/BrSamiDozOJEYq
   w==;
X-IronPort-AV: E=Sophos;i="5.88,277,1635177600"; 
   d="scan'208";a="294149025"
Received: from mail-mw2nam08lp2172.outbound.protection.outlook.com (HELO NAM04-MW2-obe.outbound.protection.outlook.com) ([104.47.73.172])
  by ob1.hgst.iphmx.com with ESMTP; 10 Jan 2022 21:58:38 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hpjnnzIIGG9Yrh2OYE5zRSG3WRt9sXLuuF+m7eZSAbXTVHkM5FIPJ+RkEYHzJmE4PCNSxAqgQ6oeS482VqYDdpGsGlvDToBrjTwUFs6JE37y1OF4rKzYnJMth9nvXV3FdidBKSmZ966dya7baqkPad8S52lj4ER+eyHb4pmVSPKnMfGVSbUk6L2kOlj/n683SDg+IQuJBmOiJ7EtYkMF1bks+P/NNGy5MxJrISZEXbKK3sp2c1Z8bWMqxh47JQYVDIGOVQjy9pViThGCw5YyHzKSv9TaZt2wpgH/00xsuOCchT+iUywRl//DNujZGDrUxEk+nv5bwxCbvi6H1oS2mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0DYBrNg1VjoxXmDJnHUAWnsgEGeV2sVxrp9Lel/dc8Y=;
 b=DrOI2yKsWxctfLlOniQ7xt9iDwxSt1VA7spA+NOyuOHSYPxmKAw+wsyX1Lk2OPuQdIVXO2uBZH/ZBCWRyocfLzv+tt+8Csc0q/7y8nb2iyCkbKMUKm8M+1DSvbYiTuVKg5WLYUU/uyCp23rxxz6pGzmXAKrT8uLNI7V3zg9d5kXlj8HZUd6ZD3uJ1MS2bo2iWsgexaIEhiw9pVgRGquVz/uFxMVBPJbR7ZfAzuMdw/WOnuQLUrH9s/3QJxmMsuuZd7jSpWmv2Vd3hEAfq4VSjjQUgPzvRwLpbf9y91m5iU0+gyb+kCWEmfxQVyBgUX5L5sgUx0w4i0/T/pPu5JoBDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0DYBrNg1VjoxXmDJnHUAWnsgEGeV2sVxrp9Lel/dc8Y=;
 b=X9nxP7GSwKQSjrEbZASQsSz9/AGFiat6514VrMTc3VLuHJFNF9m+Lr35HNb9tMXVyse1ULVVM2BQ/1EJl/b4Zgl3H3ABkCTeyI3lBH2AL3KnCYdilQa/eFVqkheCVfgs0/d14oksGEhrli2WUyvxfIv/AkYX1z/jr/nihV1hX/g=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 DM6PR04MB4170.namprd04.prod.outlook.com (2603:10b6:5:9c::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4867.11; Mon, 10 Jan 2022 13:58:33 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed20:7b26:3474:b3e0]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::ed20:7b26:3474:b3e0%5]) with mapi id 15.20.4867.012; Mon, 10 Jan 2022
 13:58:33 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     =?utf-8?B?7ISc7Zi47JiB?= <hy50.seo@samsung.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        "bvanassche@acm.org" <bvanassche@acm.org>
Subject: RE: [PATCH v2] scsi: ufs: modify Tactive time setting conditions
Thread-Topic: [PATCH v2] scsi: ufs: modify Tactive time setting conditions
Thread-Index: AQHYA6ykHezHkSj3q0euQmOgUzLo+6xXYlpQgAQjUQCAAMcScA==
Date:   Mon, 10 Jan 2022 13:58:33 +0000
Message-ID: <DM6PR04MB657586C4A2B162F5B1E7D608FC509@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <CGME20220107095451epcas2p2d06b23e50cbd46e910532e2d9078c912@epcas2p2.samsung.com>
        <20220106213924.186263-1-hy50.seo@samsung.com>
        <DM6PR04MB657535F7CC817A0E2893F668FC4D9@DM6PR04MB6575.namprd04.prod.outlook.com>
 <000401d805c6$8329ae40$897d0ac0$@samsung.com>
In-Reply-To: <000401d805c6$8329ae40$897d0ac0$@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c55c8a9b-f568-450c-05bc-08d9d4414a5e
x-ms-traffictypediagnostic: DM6PR04MB4170:EE_
x-microsoft-antispam-prvs: <DM6PR04MB4170010200C3CEEA0F6D3481FC509@DM6PR04MB4170.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hs0DvZbnnCXc0f7Nx2t0ttNOOoc3YVy09Es5jcVvyuF0Tg1YfXw3fTDKg67JbOdMNsTeNNm2UlFR4MhmvrI8k1Qcdr6m4CU1rHuFVzUpOLWy9+xZmM1mWBUBxLqd0lxh+0y+Su7zMCJauaFrkCyPv/FyD5U3Ksx0XuhVbMwETgeBkW00jPdXlNyR7h3bn1fJ4yRVwUcTV3GuvIibx0jwk0BFWFyhU03KQbnu6rAp/H1Qo7v/2FuMWCHfifXYz6VZZ4miEng0UsL7vvn2B4005ym8TML4lShyOUDq+m+kKlL6XIRBUXydccroDnzCYlGQcOGohGGnVDEuVMv1OflxDy6TvOjkiz/jUN5+lStM9beYpqg0bpFU5RG+yp2GVNLisIjkB8yQN2UdepXEbWqt1QakLzkycThqwfnfz7fVy9Apcjoh/vjubwbrHqP6ufj+ejidK8Dn2IrZEtoGNQ/ihJ0q/+4yyKEkvWDckF69Zai5kCCpMnuN/yv0qLa5qJqEnJvizAdFYCORkwChy2GhbNuFVdUw5dg2NJ1eKZyoOxldaGG+oQAijYM6HEwTzz9B5cJnlp3LF08J5VK2TWFXDl0j+5Ku7nAgtTjh97k4WQn4MLom13pGtAZUt+40/B1hX/iietAYkKyRrxx7pSqBR2m/+5DCGKb8tDTREByZsjO4UMMDEX7UjeySi8MoE28M3sekce/bHbMVJbzrxOkPNIWqygvVj7YPaxBPCKgKqUI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(921005)(7696005)(83380400001)(6506007)(53546011)(64756008)(76116006)(66556008)(66476007)(66446008)(38100700002)(8676002)(186003)(122000001)(316002)(5660300002)(110136005)(71200400001)(8936002)(26005)(508600001)(38070700005)(66946007)(2906002)(55016003)(7416002)(86362001)(82960400001)(9686003)(52536014)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXhjc2E5TCtXaytoMVEyWTIwd0d6T3BqWW5NUW9yUWE0NHJGeWE2ak9rekVo?=
 =?utf-8?B?MVFzTDE1cW5hU0ZYTk1GKzIwbUt4U3RFYkEzZDZJYk1aWmtRaTZ5RGxzS01N?=
 =?utf-8?B?SndXUDh1aVdGbENleFNtRCtLSkVZbTF5eTV1MW1WNS9iNkxDMXhYZmtJY0lq?=
 =?utf-8?B?UWRrOG1HK1VpK0R5cFBaTm9qTjFyWXZDMHFUWlYxYnVkSTZ4TWZsOXN3Ym1D?=
 =?utf-8?B?VjllRHFVMFBWSXM5cElydXdkemNxRXltZWdpWUpBMndzY1I3Z1Z1K0pMTkx4?=
 =?utf-8?B?d0dvTU14NUQ5TG9MYm9LZW1UWmJ5L1N3aTlVRlNkbmN5T0VOWXNLY0VwTnFh?=
 =?utf-8?B?aTBqL1BkdDJudVlrRDlBZEhkVDVBYkg4ZWYvdGI1bXpZMzB4M2RJN2RhN2FD?=
 =?utf-8?B?R1BSVnNaRlk1RHU3SDBOUE03OWw5QzdKQS80K205dWxCWVhXeUMxR3drcEEw?=
 =?utf-8?B?d1VwYjExUDQvSFhWcnJpdkcvSXFhenZwV2FRdXRsTHNzZm1ETXdwRzd1M0tm?=
 =?utf-8?B?dFlaZ3dkTTFCa2RXRGdheVVLM012My9Td3B1aG9ubVpyWmZ5WUdzVE56aitl?=
 =?utf-8?B?RlQ4NXdQZXFYT1hvQ0dpbTU0aEZWZHpBMjJza3k1Qi9WVDBJZGJ6VHcrNGha?=
 =?utf-8?B?dmw0L2k4bFhzc3BaWWhBcE1DdlpQSjB3SVZ5ekVsclZjT0NkUkpGMy9ITjZB?=
 =?utf-8?B?cHV3d3ZwVEdhODMyU2w1ekQxT1BSMVFDMTVneUpOSXlKZU9rdnpOSW95YVVG?=
 =?utf-8?B?d1RXMjZjRkVvS1VXdXpyZDZSZlhNenlGUjVJaUovemZNQ25iNGtiZHkvRGkz?=
 =?utf-8?B?cW51NmpCMjVjMkFLKzhoQlpWQmNuNlk3MTlBOTRQNVpyRG1NajdWOTF6cXdm?=
 =?utf-8?B?RFpLTnlUcmxoc2Z4SkY5SGlKUlJIZ1VzaFozUURnWmNFQjBNUFVISFRqOG54?=
 =?utf-8?B?YjBRdTBwaWFxUTlITGZvdDhjYWwzdGdkUVo3YVB0cFc1U2w3dTNpYk40T0Fw?=
 =?utf-8?B?U29EV3EwNkcxTDlFZ2N1VUdzMFZlbEk2TW9jOGdPUEZLSnZCWG9wQVZVaTM1?=
 =?utf-8?B?TkhiZEdtMElyMHh1b1M3Vmk0YUM2SWc0M3RtcnhUVzBVZk5VdFBzdlZJUmor?=
 =?utf-8?B?dDRYcnFSNWo5M29zMmZickNGNmNFUy9tMkJJVENoblEvMVlBcWV5WFhSdzdQ?=
 =?utf-8?B?ZHNXS0FvbW5OUXMxUngxalRYNXdOTmxVN0oycTdjanFuODZGbitEenJoOXoz?=
 =?utf-8?B?STUzck1wdGp2dVI5U0FDR2p1eFdIbXVQMGxRYkNqcWFqQXZrZXFuL1Vwdm12?=
 =?utf-8?B?aDlMSzJScExZSHlKcTBUWUY0Tk5IalRuOFdmVndlbUhFakl5QU0zRi9nOFFa?=
 =?utf-8?B?Mitic0I4WE5icG00aElpeVowdDY5LzRzMG5wblpqLzA0ejQrZHRlSEZaUkhG?=
 =?utf-8?B?aGIxQUZmcmgyWERZNG93aHpTQ0VyNDZ1dmFCQ3cvdURkVDhvR2JPQitlaXlX?=
 =?utf-8?B?dldQaGpsQ1NIT2Q0YWpYc1RDMERMUVdNaWUzMGdHZXd4Z0N6MXZKQ253Y0VR?=
 =?utf-8?B?K2FMd28vYmxDODd4RHdEeUN4dTZFeTFXbGVzSHZKSzdhaVNHUTMwVlpLYStq?=
 =?utf-8?B?cWdZMlVhdSs1bDA0WFNadFFoUEJGQklndVRPK2dpT2Q5R3J3VEtBcG5ucFJk?=
 =?utf-8?B?TDdTWEEwdlFjNGVQdm14R1RSbWFUMnZvWWxGai9qWm9welpaWUU1WG5FL2lp?=
 =?utf-8?B?TWM2ZXd1Y1UyY0R0YVNHSXgvbU8vVUFadlZVYzM5RlZTZDI4cjZkY3JJcjFi?=
 =?utf-8?B?RVlOR2JNaWorYUZyRXRHZ3A1QUxGMXN1VTQ0a1drQmwweVh0Q0V3MkhjQThN?=
 =?utf-8?B?ZlBWcHMvWjE2d3UwMjZqUnpvakE3Z295ekpYazRWVW1MeFl4Uzk5QXoyekdh?=
 =?utf-8?B?ZTV4NDF0b0wxbE1obHl0bEdYYy9iN3Q1UHVlNkltTXBoYXpMYmpQcG1BU1hq?=
 =?utf-8?B?NENYZ0ROUU9kUjNTOStZMVJEQStQbzVJdVNsZitkSW9SYVZ0VjltVlZ6NXpR?=
 =?utf-8?B?SzBXSFhkMk8xT0IzNGNQalhJeDBpN093VGRuRE5aM0Y0WjRGeTBPK28zUExi?=
 =?utf-8?B?emh5QjJMek1YdUxUYTlpdytVM3dNb1EvRzN6eHV0b05wRFg5dGV5Y2ozUGZr?=
 =?utf-8?Q?VvcRs0IGOmH2R+uZ05/WXVE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c55c8a9b-f568-450c-05bc-08d9d4414a5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2022 13:58:33.4649
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /4s5qhsOpzbMG7nOHaBR8YUvVoCEvvgoE8yJ+HH3iQsIi1YsY/bML1PEOyXNubtFzfeFoU1YH5YS1epc0mmPnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4170
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gSGksDQo+IElmIHJlZ2lzdGVyICJVRlNfREVWSUNFX1FVSVJLX0hPU1RfUEFfVEFDVElW
QVRFIiBxdWlyaywNCj4gdXNpbmcgdGhpcyBUYWN0IHRpbWUgZnVuY3Rpb24uDQo+IEFuZCBJIG1l
YW4gYWxsIFNhbXN1bmcgZGV2aWNlIHVzZSBVRlNfREVWSUNFX1FVSVJLX0hPU1RfUEFfVEFDVElW
QVRFDQo+IHF1aXJrIGJlbG93IHRoaXMuIHNvIEkgdG9sZCB0aGF0Lg0KPiBzdGF0aWMgc3RydWN0
IHVmc19kZXZfZml4IHVmc19maXh1cHNbXSA9IHsNCj4gICAgICAgICAgLyogVUZTIGNhcmRzIGRl
dmlhdGlvbnMgdGFibGUgKi8NCj4gICAgICAgICAgVUZTX0ZJWChVRlNfVkVORE9SX01JQ1JPTiwg
VUZTX0FOWV9NT0RFTCwNCj4gICAgICAgICAgICAgICAgICBVRlNfREVWSUNFX1FVSVJLX0RFTEFZ
X0JFRk9SRV9MUE0gfA0KPiAgICAgICAgICAgICAgICAgIFVGU19ERVZJQ0VfUVVJUktfU1dBUF9M
MlBfRU5UUllfRk9SX0hQQl9SRUFEKSwNCj4gICAgICAgICAgVUZTX0ZJWChVRlNfVkVORE9SX1NB
TVNVTkcsIFVGU19BTllfTU9ERUwsDQo+ICAgICAgICAgICAgICAgICAgVUZTX0RFVklDRV9RVUlS
S19ERUxBWV9CRUZPUkVfTFBNIHwNCj4gICAgICAgICAgICAgICAgICBVRlNfREVWSUNFX1FVSVJL
X0hPU1RfUEFfVEFDVElWQVRFIHwNCj4gDQo+IE90aGVyIHZlbmRvcnMgY2FuIHVzZSBpdCBpZiBu
ZWNlc3NhcnkuDQo+IEFuZCBmb3Igc3RhYmlsaXR5LCB0aGUgZGV2aWNlIHRhY3QgdGltZSBtdXN0
IGJlIGxvbmdlciB0aGFuIGhvc3QgdGFjdCB0aW1lLg0KPiAoSSBhbHJlYWR5IGNoZWNrIE1ham9y
IGRldmljZSB2ZW5kb3JzKQ0KPiBUaGF0J3MgcmVhc29uIHdoeSB1c2UgdGhpcyBmdW5jdGlvbi4N
Cj4gQnV0IHRoZSBIb3N0IHRhY3QgdGltZSBhbmQgRGV2aWNlIHRhY3QgdGltZSBzYW1lLCBzdGFi
aWxpdHkgbWF5IG5vdCBiZSBzYXRpc2ZpZWQuDQo+IFNvIEkgY2hhbmdlZCB0aGlzIHdheQ0KWWVz
IC0gSSBhZ3JlZS4NCkxvb2tzIGdvb2QgdG8gbWUuDQoNClRoYW5rcywNCkF2cmkNCg0KPiANCj4g
VGhhbmtzLA0KPiBIT1lPVU5HLg0KPiANCj4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+IEZyb206IEF2cmkgQWx0bWFuIFttYWlsdG86QXZyaS5BbHRtYW5Ad2RjLmNvbV0NCj4gPiBT
ZW50OiBGcmlkYXksIEphbnVhcnkgNywgMjAyMiA3OjU3IFBNDQo+ID4gVG86IFNFTyBIT1lPVU5H
OyBsaW51eC1zY3NpQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
ZzsNCj4gPiBhbGltLmFraHRhckBzYW1zdW5nLmNvbTsgamVqYkBsaW51eC5pYm0uY29tOw0KPiBt
YXJ0aW4ucGV0ZXJzZW5Ab3JhY2xlLmNvbTsNCj4gPiBiZWFuaHVvQG1pY3Jvbi5jb207IGFzdXRv
c2hkQGNvZGVhdXJvcmEub3JnOyBjYW5nQGNvZGVhdXJvcmEub3JnOw0KPiA+IGJ2YW5hc3NjaGVA
YWNtLm9yZw0KPiA+IFN1YmplY3Q6IFJFOiBbUEFUQ0ggdjJdIHNjc2k6IHVmczogbW9kaWZ5IFRh
Y3RpdmUgdGltZSBzZXR0aW5nIGNvbmRpdGlvbnMNCj4gPg0KPiA+ID4gVGhlIFRhY3RpdmUgdGlt
ZSBkZXRlcm1pbmUgdGhlIHdhaXRpbmcgdGltZSBiZWZvcmUgYnVyc3QgYXQgaGliZXJuOA0KPiA+
ID4gZXhpdCBhbmQgaXMgZGV0ZXJtaW5lZCBieSBIL1cgYXQgbGlua3VwIHN0YXRlIEhvd2V2ZXIs
IGluIHRoZSBjYXNlIG9mDQo+ID4gPiBzYW1zdW5nIGRldmljZXMsIGd1aWRlZCBob3N0J3MgVGFj
dGl2ZSB0aW1lDQo+ID4gPiArMTAwdXMgZm9yIHN0YWJpbGl0eS4NCj4gPiA+IElmIHRoZSBIQ0kn
cyBUYWN0aXZlIHRpbWUgaXMgZXF1YWwgb3IgZ3JlYXRlciB0aGFuIHRoZSBkZXZpY2UsDQo+ID4g
PiArMTAwdXMgc2hvdWxkIGJlIHNldC4NCj4gPiBUaGlzIHdheSB5b3UgYXJlIGNoYW5naW5nIHRo
aXMgZm9yIGV2ZXJ5b25lIC0gbm90IGp1c3QgZm9yIFNhbXN1bmcuDQo+ID4gZS5nLiBRdWFsY29t
bSBhcmUgdXNpbmcgdGhpcyBxdWlyayBhcyB3ZWxsIGZvciBXREMgZGV2aWNlcy4NCj4gPg0KPiA+
IFRoYW5rcywNCj4gPiBBdnJpDQo+ID4NCj4gPiA+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTRU8g
SE9ZT1VORyA8aHk1MC5zZW9Ac2Ftc3VuZy5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBkcml2ZXJz
L3Njc2kvdWZzL3Vmc2hjZC5jIHwgMiArLQ0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4NCj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L3Njc2kvdWZzL3Vmc2hjZC5jIGIvZHJpdmVycy9zY3NpL3Vmcy91ZnNoY2QuYw0KPiA+ID4gaW5k
ZXggMTA0OWU0MWFiZDViLi40NjBkMmI0NDBkMmUgMTAwNjQ0DQo+ID4gPiAtLS0gYS9kcml2ZXJz
L3Njc2kvdWZzL3Vmc2hjZC5jDQo+ID4gPiArKysgYi9kcml2ZXJzL3Njc2kvdWZzL3Vmc2hjZC5j
DQo+ID4gPiBAQCAtNzgxNSw3ICs3ODE1LDcgQEAgc3RhdGljIGludA0KPiA+ID4gdWZzaGNkX3F1
aXJrX3R1bmVfaG9zdF9wYV90YWN0aXZhdGUoc3RydWN0DQo+ID4gPiB1ZnNfaGJhICpoYmEpDQo+
ID4gPiAgICAgICAgIHBlZXJfcGFfdGFjdGl2YXRlX3VzID0gcGVlcl9wYV90YWN0aXZhdGUgKg0K
PiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICBncmFuX3RvX3VzX3RhYmxlW3BlZXJf
Z3JhbnVsYXJpdHkgLSAxXTsNCj4gPiA+DQo+ID4gPiAtICAgICAgIGlmIChwYV90YWN0aXZhdGVf
dXMgPiBwZWVyX3BhX3RhY3RpdmF0ZV91cykgew0KPiA+ID4gKyAgICAgICBpZiAocGFfdGFjdGl2
YXRlX3VzID49IHBlZXJfcGFfdGFjdGl2YXRlX3VzKSB7DQo+ID4gPiAgICAgICAgICAgICAgICAg
dTMyIG5ld19wZWVyX3BhX3RhY3RpdmF0ZTsNCj4gPiA+DQo+ID4gPiAgICAgICAgICAgICAgICAg
bmV3X3BlZXJfcGFfdGFjdGl2YXRlID0gcGFfdGFjdGl2YXRlX3VzIC8NCj4gPiA+IC0tDQo+ID4g
PiAyLjI2LjANCj4gDQoNCg==
