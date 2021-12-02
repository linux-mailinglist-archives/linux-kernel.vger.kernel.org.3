Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 371EA4664BC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 14:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358351AbhLBNxm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 08:53:42 -0500
Received: from mail-dm6nam11on2055.outbound.protection.outlook.com ([40.107.223.55]:31072
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1358341AbhLBNxi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 08:53:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/xw2ZwPoAJkEAdLuR3GsoLSebZYeHJGxe04HSVwENkXkJmqr4+AbQ0FuX4so2sQX4U8a76mrYhXkNpSnf4YUR9gOLH2SHbHfpLlp0XLzTeTaFOW8LBf7BReVd4GNVsaPxmNqW47qk/FAyTc/xB+oz8j+ULfCX0URZ5xKDDSW20/Cx1HJPqEZtVBWb6Whi8UYd5hmob78GnVrS7dImytG/OsmKWEqFRVC1Bp/2GZzl17LTgmGvx3EsrmwE5FLPjmhS/wevlP1pPU/QKbZP0zst/wAdfloTKsszN4csUr/4jwpOZ/MDjxfWe/UyQ1R/YOcJNk4PhTbj7MmPFvjbT9Xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ITn0bJv9tAA05A2DFohYT5tbqy1siGx2hEID5w6q58=;
 b=CBi3ON0bEBBuH+RplrIqQU4QLXswB81Spvw9YS2gWvXXT6mbOhg/B1Lx3eX1giAKqOcEkwL/vKDnh6vS3QI276NaSxCqD6ZZECtfUWCGQ6nYX9M/2TwMD3lxpiDWtCBQNIDLpoOgfDKop0iB4+0TYWan46cNyn2miuOwSwn62cfXSIgcPhJ4enXAOv7QivM+vY4XlFUMUnFzFHFxYGub9+LGtY4JHApxMkQ9/gQSyV+PI6S7q7sL0QoKrxlcWK26/vyuyEm/AN9M76FhREK0Q715yTaWfIdsPhVNB1dW2vp8T8DpxcdFfIdc3Jrt+BuE8h/c8wtOlc5icX/cng0Akg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ITn0bJv9tAA05A2DFohYT5tbqy1siGx2hEID5w6q58=;
 b=a9vGjRcY0cJVdqW09AO+oab2vEFn+JytnA1QT3K2sCSL+8HYWRYUMFENfgDrFclvf3Efe1wnhIfDWAwjpFvSRccqLLaj1mIYN/k1ciNqUklkho0DbMoax3DZo30Hv11z/2ij7Hl6HaLedHP+UEt8twa1gS8L5aFzFq/yE2kKZFTapU07al7gc8hQ8JyKurRUVwrJLcoVbFh0QnxhhqUicxmGpe3p69CmvyCiAwPqYgA+SUZ10UVLuJQW8l5SxjMo/a+UCSfyqqqM/0Y4f+jzGCG7QGcqaCglmt9I6JUMpeVKB3nu/NF1hOBr/MEGLXbuQZmH6uZI5U91SFFr/RrG/Q==
Received: from DM5PR12MB2406.namprd12.prod.outlook.com (2603:10b6:4:b7::23) by
 DM5PR12MB1289.namprd12.prod.outlook.com (2603:10b6:3:79::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.20; Thu, 2 Dec 2021 13:50:14 +0000
Received: from DM5PR12MB2406.namprd12.prod.outlook.com
 ([fe80::5926:d2bb:5b4b:1b99]) by DM5PR12MB2406.namprd12.prod.outlook.com
 ([fe80::5926:d2bb:5b4b:1b99%6]) with mapi id 15.20.4713.027; Thu, 2 Dec 2021
 13:50:14 +0000
From:   Prathamesh Shete <pshete@nvidia.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Aniruddha Tvs Rao <anrao@nvidia.com>,
        Suresh Mangipudi <smangipudi@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>
Subject: RE: [PATCH] mmc: sdhci-tegra: Add support to enumerate in HS400ES
 mode
Thread-Topic: [PATCH] mmc: sdhci-tegra: Add support to enumerate in HS400ES
 mode
Thread-Index: AQHX5RHOU7NXipPLNkqn7lxv5zR8mqwexJsAgABwF/A=
Date:   Thu, 2 Dec 2021 13:50:14 +0000
Message-ID: <DM5PR12MB2406A29535088939076800ACB7699@DM5PR12MB2406.namprd12.prod.outlook.com>
References: <20211129111047.5299-1-pshete@nvidia.com>
 <0a8368f9-8ca2-f01b-2f9e-0c91e3b946f5@intel.com>
In-Reply-To: <0a8368f9-8ca2-f01b-2f9e-0c91e3b946f5@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 02b70a4f-f2d1-4fb9-a3f3-08d9b59aaae7
x-ms-traffictypediagnostic: DM5PR12MB1289:
x-microsoft-antispam-prvs: <DM5PR12MB12897B6C0DCA8181846CB2B4B7699@DM5PR12MB1289.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2201;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X5PvdvGJywmBJ0S+dqIsVontmomS7zw14guWFl4EvIIMPT8L+XqKoLvejsTDzZG5xlC1xxTM6awOLhmNe+EUYYx15H3UYhes87LGYjUdgneteE257GzTF4aBKEx0MYRO7nLD7J8SxRnbVa5e3fELBkly6oI6Fe9UeV4nt8PN872f8BncnHHH3g9X/aKiswqYqRVqZQWfhActij2pMeZLZQpgR7SmuFHFfW8YggxOOmS7woyEiQY/XgRXaZSGPJfMHq1tyoYjvPxEkBsHWuyD8fpX4YPpS6/hu/666JPX30FjY2XOiikTk6m4twbz1VCVPKbsqWxj+dvFuzI92+/Axu/wAJvBjXXKTJY7NiGTNAP7MOIR3tJh0mhcPbWByfKazjt7Ew3l68app6+1mRQ1GtiU/n2Q5OCI/N+PNWhLaWWJ8JUf5HggLfTpV/OSFksgq2jdAeU+AuQl4OdFkQhNAeQq3TRhD86TN3UT7BV9siZvuh9g/xVdbMSIA2G44CnxlhU33i/qsboEA70oWYa5CCMfCmCe9Vu7uMYaxiA/+meDkCIWg9mJstwIAtu/TlKUWTy2pekOmwiYJecFbg3SsOXznHRrDOiHXSHZSVbd0O+q+nEYqmrcpryBQAmrwTgolDnCvE53MGRJTFj0thuOu3C36OD69KGY0sJXBg8V9EnbiFsG2dt2Yky2Ck5T5HteazQzQVAhuBD1TZv/GIxvdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2406.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(86362001)(53546011)(38070700005)(33656002)(6506007)(122000001)(26005)(4326008)(107886003)(54906003)(66476007)(316002)(66556008)(64756008)(66446008)(38100700002)(508600001)(76116006)(186003)(2906002)(66946007)(110136005)(8676002)(5660300002)(71200400001)(55016003)(8936002)(9686003)(52536014)(7696005)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VXRISDZiNmVrYU5lSy9seERPVCtTdHMxOHhkL2ttbzBsdko5TDVJM0pFRXg4?=
 =?utf-8?B?YU5jWDhUNTFBYjdVZlFXMG1ENHp4UUIrSlhKWnVyeUNDN204emJDeVNSZVVm?=
 =?utf-8?B?bmJxM1JDK3J3T1hwVW93ZUk2eFUwQlB1c3FhVDMrbXBDM25KOTdWWFZuUXF0?=
 =?utf-8?B?RWFnTGxteUh0VG5xV3pOUXg3b3RNRUM2ZWJrN1VZQjlHM0VxQmw3RHhTM0ND?=
 =?utf-8?B?cDhSTDlLaTVvcVhqdE1ocHFucGM1Zk94QkN4SEtuOVBldEVOU09IeHlwQ2dQ?=
 =?utf-8?B?SVViYUpZYWg1Yy9yczcwckFXWU1VbUtJT2NmcERnU2F3NElRSWV2OU8vdE1Y?=
 =?utf-8?B?bXFUdjdzSEJOTW9OQWJUd2J2TUdjMGFwdUtjWVZmbUEzbjFhbmRSNUIrUmlY?=
 =?utf-8?B?K3M4Q0p1Z2FWWWNYcVdmeG9WWlBNM2V0VG0vYUxEQktPRVBoOWRnbjdLelp6?=
 =?utf-8?B?Z3R1UmcrWHI0ODZPb1FFRlVtMUxCV3VNUGpUY1Q3YVMvcnJuR3BjVmVjVitO?=
 =?utf-8?B?Z0M3YmRPNkJNL21GRnJiWHRYVHQyS2E2VUtheUF0V1RWR3htMmkyTmNWMnJF?=
 =?utf-8?B?M3Axdk1McEtjMTc0Rm5hckpucjBsWExDVU9pdG11RUgxekVoRVBjZnhBVlJN?=
 =?utf-8?B?ZHA3a01rYVByWEZlZEZ3aHl2UXNISHNQSFlBL1ZTWGZBc3JycTFrSUtabkIr?=
 =?utf-8?B?amJBOUFlRkdNRGtTQWNWeENqUjBrUldLby9IbGN0NzFsMm9ya2RrTnFzeGJV?=
 =?utf-8?B?L1QzTnBOL3cxYjZ2S2JhbldrUnZYV3l2TnRoTDlENkM5aS9UbWh5UUV3SGE0?=
 =?utf-8?B?Ryt6OWs0RkJHQThUdDRoK0tvaEZmNHRpTjhXaDBLTUIzV2g4azBPRVpqK1A3?=
 =?utf-8?B?RnhrTzZucWNBOU56UStxUkpVNGhXUHBPcXc5K1h1VlJybkQwM0w1WUpCZ0Z3?=
 =?utf-8?B?Q01zMDhMWHpxY3V1ZTNmVENJMWpLblhpS3NJOE5IbVk4bVJVdmYvRGtWOFc5?=
 =?utf-8?B?N0JIb09uUnRqWEoxTGlZY1VlSysvb2pBcjIzdHBETDVSeXFnK2RORVJVNUNX?=
 =?utf-8?B?ZDdWWDEzR3RzYjdWVDd4b0U3NmphNy9zMTVhdFhYOFJwK3VxWTN2dmIwQjEx?=
 =?utf-8?B?Yjh0Vk1WUGJzUVF4WkJvTHQyYlJQSjZBWWNBd016QTBncS9rUUkvTmdXVGVi?=
 =?utf-8?B?SXhXNGFBVFFYd3ZUSTVjZW1Qb202S0hpaGlvS1pZaWJBeFdoeEF3VXZYVHBX?=
 =?utf-8?B?WGdQUThQWFhaa1lKSDFod21hTnFVNGFYMzc3M2FSOUZGREgxbHYrTzVEZm4v?=
 =?utf-8?B?Nzl1a3ExR2NSb00vRkFPVFdaYzQzT25wcVlmeEdVUHg1dnpXdkQxVlZrcXJZ?=
 =?utf-8?B?amZld0doeXQ5L1dhNUdzNm5qbi92WTY4cklqVDVLbTdCNFQxUnRIWEFTRVlj?=
 =?utf-8?B?a2oyVUtSS3FxNE9aRjJVTUw0ZndUVW9POU1PbFB2bWhHaGFlYWs1dGdESTNh?=
 =?utf-8?B?bzQxQVBCTkgrSzZvbldpMnJSNWgxNmZ0cld2dDVoblV6TkR5Ym9nOGttZnN6?=
 =?utf-8?B?T29MY0lzUWg2aTVmNVhjeTQyRnNLbElveENtY2hXOUxxREpyQlJ6eGNlZVNx?=
 =?utf-8?B?dk5oSHI3MWJ1M0JHZ3hNOENsNHllMDVEV3c2Vnk3OHpld1d4VEp3OWhSeWRW?=
 =?utf-8?B?T0JFUE5KNUplaGZwbDdpSDRrSzJxejdNS2dNM2hvUEJvOFpTZ2ZvZGxxeVUz?=
 =?utf-8?B?ZWs2ZGxhajVXWUN1Z0ZjTkZHS05mYTR6SlE0YzZKOUgrMTZzdDVvcHhOM3Js?=
 =?utf-8?B?UzF2UlJWVEh4eUo5aTV5RWpyV3VSUDN0TzNVK0wzQURFczVJa1Rxd0wrTWxr?=
 =?utf-8?B?S2tVT0psWjF2QnRwN1BreVFPNk8wTXJidjVLemxoMXdmclBSMmsrT3BTUkNa?=
 =?utf-8?B?dFVFS0pZcGFYZDVFakdjQXlkVjhRS3MrMVNFaWZqSzMzWVU0L1cydDVSRklq?=
 =?utf-8?B?eERidzFBc2lYTHdmejFJMVFDK2NkMnVoMWVCUjZkKzkzT3RYOHFvaVhZTkNL?=
 =?utf-8?B?QXUxOE1mRStDSnZWLzF5UmVPaHBsblZTOEYxdnk0eG83aGdPbU15aUVwck5O?=
 =?utf-8?B?Qm44UitHRC9TVmxnU2E1M3lqS2p0eC9xNU1CN1lJVmY0ald1b0E4TncvNUhu?=
 =?utf-8?B?alE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2406.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02b70a4f-f2d1-4fb9-a3f3-08d9b59aaae7
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 13:50:14.5325
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t26QnJ4Jc3oooSFrSDk/uRApWKKnvXpjdRy2QZaeT+hwX02QXUiVHzBhip8nSntmeUsTVCyYMzQi4bOoT1W/+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1289
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmtzIGZvciByZXZpZXcNCg0KVGhpcyBpc3N1ZSBpcyBzcGVjaWZpYyB0byBIUzQwMEVTIG1v
ZGUuDQoNClVwZGF0ZWQgYW5kIHB1c2hlZCB2ZXJzaW9uIHYyLg0KVXBkYXRlZCBjb21taXQgbWVz
c2FnZSBhbmQgY29tbWVudHMgdG8gY2xhcmlmeSBvbiBIUzQwMEVTIG1vZGUuDQpBbHNvIG1vdmVk
IHRoZSBmdW5jdGlvbiBhcyBzdWdnZXN0ZWQuDQoNCkFuc3dlcnMgdG8gc29tZSBxdWVzdGlvbnMg
aW5saW5lZC4NCg0KVGhhbmtzDQpQcmF0aGFtZXNoLg0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KRnJvbTogQWRyaWFuIEh1bnRlciA8YWRyaWFuLmh1bnRlckBpbnRlbC5jb20+IA0KU2Vu
dDogVGh1cnNkYXksIERlY2VtYmVyIDIsIDIwMjEgMTI6MTAgUE0NClRvOiBQcmF0aGFtZXNoIFNo
ZXRlIDxwc2hldGVAbnZpZGlhLmNvbT47IHVsZi5oYW5zc29uQGxpbmFyby5vcmc7IHRoaWVycnku
cmVkaW5nQGdtYWlsLmNvbTsgSm9uYXRoYW4gSHVudGVyIDxqb25hdGhhbmhAbnZpZGlhLmNvbT47
IHAuemFiZWxAcGVuZ3V0cm9uaXguZGU7IGxpbnV4LW1tY0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LXRlZ3JhQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZw0KQ2M6
IEFuaXJ1ZGRoYSBUdnMgUmFvIDxhbnJhb0BudmlkaWEuY29tPg0KU3ViamVjdDogUmU6IFtQQVRD
SF0gbW1jOiBzZGhjaS10ZWdyYTogQWRkIHN1cHBvcnQgdG8gZW51bWVyYXRlIGluIEhTNDAwRVMg
bW9kZQ0KDQpFeHRlcm5hbCBlbWFpbDogVXNlIGNhdXRpb24gb3BlbmluZyBsaW5rcyBvciBhdHRh
Y2htZW50cw0KDQoNCk9uIDI5LzExLzIwMjEgMTM6MTAsIFByYXRoYW1lc2ggU2hldGUgd3JvdGU6
DQo+IFdoZW4gQ01EMTMgaXMgc2VudCBhZnRlciBzd2l0Y2hpbmcgdG8gSFM0MDAgbW9kZSwgdGhl
IGJ1cyBpcyBvcGVyYXRpbmcgDQo+IGF0IGVpdGhlciBNTUNfSElHSF8yNl9NQVhfRFRSIG9yIE1N
Q19ISUdIXzUyX01BWF9EVFIuDQo+IFRvIG1lZXQgVGVncmEgU0RIQ0kgcmVxdWlyZW1lbnQgYXQg
SFM0MDAgbW9kZSwgZm9yY2UgU0RIQ0kgaW50ZXJmYWNlIA0KPiBjbG9jayB0byBNTUNfSFMyMDBf
TUFYX0RUUiAoMjAwIE1Ieikgc28gdGhhdCBob3N0IGNvbnRyb2xsZXIgQ0FSIGNsb2NrIA0KPiBh
bmQgdGhlIGludGVyZmFjZSBjbG9jayBhcmUgcmF0ZSBtYXRjaGVkLg0KDQpUaGlzIHNvdW5kcyBs
aWtlIGFuIGlzc3VlIHdpdGggb3Igd2l0aG91dCBlbmhhbmNlZCBzdHJvYmU/DQpbUC5TXWlzc3Vl
IGlzIHNwZWNpZmljIHRvIEhTNDAwRVMgbW9kZSB1cGRhdGVkIGNvbW1pdCBtZXNzYWdlIGluIHYy
Lg0KDQpBbHNvIGl0IHNlZW1zIG1vcmUgbGlrZSBhIGZpeCB0aGFuICJhZGRpbmcgc3VwcG9ydCIu
DQppLmUuIGlzIHRoaXMgcmVhbGx5ICJtbWM6IHNkaGNpLXRlZ3JhOiBGaXggc3dpdGNoIHRvIEhT
NDAwRVMgbW9kZSIgPw0KW1AuU10geWVzIHRoaXMgaXMgZml4IC4uLiB1cGRhdGVkIGNvbW1pdCBz
dWJqZWN0IGluIHZlcnNpb24gdjIuDQoNCj4NCj4gU2lnbmVkLW9mZi1ieTogUHJhdGhhbWVzaCBT
aGV0ZSA8cHNoZXRlQG52aWRpYS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9tbWMvaG9zdC9zZGhj
aS10ZWdyYS5jIHwgMTIgKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0
aW9ucygrKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tbWMvaG9zdC9zZGhjaS10ZWdyYS5j
IA0KPiBiL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2ktdGVncmEuYyBpbmRleCAzODdjZTljZGJkN2Mu
LmQ4MDAzOTZkMTExMiANCj4gMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbW1jL2hvc3Qvc2RoY2kt
dGVncmEuYw0KPiArKysgYi9kcml2ZXJzL21tYy9ob3N0L3NkaGNpLXRlZ3JhLmMNCj4gQEAgLTEy
Myw2ICsxMjMsOCBAQA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBT
REhDSV9UUk5TX0JMS19DTlRfRU4gfCBcDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFNESENJX1RSTlNfRE1BKQ0KPg0KPiArc3RhdGljIHZvaWQgdGVncmFfc2RoY2lf
c2V0X2Nsb2NrKHN0cnVjdCBzZGhjaV9ob3N0ICpob3N0LCB1bnNpZ25lZCANCj4gK2ludCBjbG9j
ayk7DQoNClBsZWFzZSBtb3ZlIG9uZSBvZiB0aGUgZnVuY3Rpb25zIHNvIHRoYXQgdGhlIGZvcndh
cmQgZGVjbGFyYXRpb24gaXMgbm90IG5lY2Vzc2FyeS4NCltQLlNdRG9uZS4NCg0KPiArDQo+ICBz
dHJ1Y3Qgc2RoY2lfdGVncmFfc29jX2RhdGEgew0KPiAgICAgICBjb25zdCBzdHJ1Y3Qgc2RoY2lf
cGx0Zm1fZGF0YSAqcGRhdGE7DQo+ICAgICAgIHU2NCBkbWFfbWFzazsNCj4gQEAgLTM2OSw2ICsz
NzEsMTYgQEAgc3RhdGljIHZvaWQgDQo+IHRlZ3JhX3NkaGNpX2hzNDAwX2VuaGFuY2VkX3N0cm9i
ZShzdHJ1Y3QgbW1jX2hvc3QgKm1tYywNCj4NCj4gICAgICAgc2RoY2lfd3JpdGVsKGhvc3QsIHZh
bCwgU0RIQ0lfVEVHUkFfVkVORE9SX1NZU19TV19DVFJMKTsNCj4NCj4gKyAgICAgLyoNCj4gKyAg
ICAgICogV2hlbiBDTUQxMyBpcyBzZW50IGFmdGVyIHN3aXRjaGluZyB0byBIUzQwMCBtb2RlLCB0
aGUgYnVzDQo+ICsgICAgICAqIGlzIG9wZXJhdGluZyBhdCBlaXRoZXIgTU1DX0hJR0hfMjZfTUFY
X0RUUiBvcg0KPiArICAgICAgKiBNTUNfSElHSF81Ml9NQVhfRFRSLg0KPiArICAgICAgKiBUbyBt
ZWV0IFRlZ3JhIFNESENJIHJlcXVpcmVtZW50IGF0IEhTNDAwIG1vZGUsIGZvcmNlIFNESENJDQo+
ICsgICAgICAqIGludGVyZmFjZSBjbG9jayB0byBNTUNfSFMyMDBfTUFYX0RUUiAoMjAwIE1Ieikg
c28gdGhhdCBob3N0DQo+ICsgICAgICAqIGNvbnRyb2xsZXIgQ0FSIGNsb2NrIGFuZCB0aGUgaW50
ZXJmYWNlIGNsb2NrIGFyZSByYXRlIG1hdGNoZWQuDQo+ICsgICAgICAqLw0KPiArICAgICB0ZWdy
YV9zZGhjaV9zZXRfY2xvY2soaG9zdCwgTU1DX0hTMjAwX01BWF9EVFIpOw0KDQpUaGlzIGJlaW5n
IGRvbmUgaXJyZXNwZWN0aXZlIG9mIGlvcy0+ZW5oYW5jZWRfc3Ryb2JlLCB3aGljaCBkb2Vzbid0
IHNlZW0gcmlnaHQgYmFzZWQgb24gdGhlIGNvbW1lbnQ/DQpbUC5TXVVwZGF0ZWQgY29tbWVudHMu
DQo+ICsNCg0KUGxlYXNlIHJlbW92ZSB0aGUgYmxhbmsgbGluZS4NCltQLlNdZG9uZQ0KPiAgfQ0K
Pg0KPiAgc3RhdGljIHZvaWQgdGVncmFfc2RoY2lfcmVzZXQoc3RydWN0IHNkaGNpX2hvc3QgKmhv
c3QsIHU4IG1hc2spDQo+DQoNCg==
