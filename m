Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41837461CA3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 18:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349521AbhK2RYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 12:24:33 -0500
Received: from mail-mw2nam12on2133.outbound.protection.outlook.com ([40.107.244.133]:29665
        "EHLO NAM12-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1348295AbhK2RWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 12:22:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ClEX6fNMQV7ZpllvbePkl91GjR2FUaW/z45gZr1xSDfA9rCrsryGll1xIkkyM+Rb+RukC/iQQ9annt++4+FDCmIplrVG+89368pEwol86S6tgSnbFvnORnQOn7oQrcGuq5ag0l4fnewwBbivMDOekXLeRnaAp/GhEeBJp1AVY4I3sO99/d6tjrOsYwGt5KZ02KZkzosrVkbUcLV86n2iG46UY1gtxq5k2Q612EaSW+tkZWRPTa5tjtdOnq6vxNO/dAtA+Ho0iUuMwzh1+B5p1YqwXfH3NSrsti3/feBCPuqswmJt24HmcA1SGuZrCcm2mhwvlDjD8UzWL0cZ0mFgWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y153pBrnUFab34Evm1zGVR1ipTLZhC6XqKfLwg91obk=;
 b=QhTK73p6olCwgyXcf2gsI636Bj3apQZf5SgAnB3RP1iVWzX84A1oP67I4+zBZtLhUUfnOnkBq040k3cdd07qrG46RV8Or4UGPQYFOCMBtRWkB4RoVE4/YOpCVjIzSbYjgOIQo/S7M1tybx/jcM+NIA6t90ksTh6i90QL85w7nQgk6pZYifYMXyp10f9JHQdaWlONRrHSj9L4HCPuaZg5NbEx/oaFmeHzYZgg6CQt+pZQ5suCTOsVyOsmtansmKMcWS6iJ7Ggpz2kzaaTHPuy5JoXgH7YIq8Haw3qE35P6RQ2tnrgWX0yx3bT5u8Ir5KCZC3aediHkAsEVidHOC458w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cornelisnetworks.com; dmarc=pass action=none
 header.from=cornelisnetworks.com; dkim=pass header.d=cornelisnetworks.com;
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cornelisnetworks.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y153pBrnUFab34Evm1zGVR1ipTLZhC6XqKfLwg91obk=;
 b=Ny50ZyWstGyiJLpGgu5mcDAf6Bbl3eoRYt7HwiddeXgrenHGqkLb9qcGBGHTpCygOJEd8aiLKazcAwdmSgc5Bk5w6h4+6mCjvuQLFx69JJ0pUNoNhyZyPwVxa9U/pWd22+9WGsgUwDr1WoSbCXxZWYuC0WmAHtBZNRLcYpmTewmlCn58LyE2saavtQDy7vlK9+fjALb6dxzurd6wmkY1gW65is94qgOl/desyTPnKK1lozZKBmuyb+UsCIDSMBOC/gAra58MKwFuFLifXjFiEiAV/WfonQak9qZwq0pgqeyKeRB98A0Vxrve6JUV+u0YrGVMXmTpH8+8u5pqqr8DNA==
Received: from CH0PR01MB7153.prod.exchangelabs.com (2603:10b6:610:ea::7) by
 CH2PR01MB5957.prod.exchangelabs.com (2603:10b6:610:49::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Mon, 29 Nov 2021 17:19:12 +0000
Received: from CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::bdea:4e22:1b89:24e0]) by CH0PR01MB7153.prod.exchangelabs.com
 ([fe80::bdea:4e22:1b89:24e0%9]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 17:19:12 +0000
From:   "Marciniszyn, Mike" <mike.marciniszyn@cornelisnetworks.com>
To:     Lee Jones <lee.jones@linaro.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>
CC:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Samuel Iglesias Gonsalvez <siglesias@igalia.com>,
        Jorgen Hansen <jhansen@vmware.com>,
        Raju Rangoju <rajur@chelsio.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Boris Pismenny <borisp@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH 4/9] drivers: Switch to kvfree_rcu() API
Thread-Topic: [PATCH 4/9] drivers: Switch to kvfree_rcu() API
Thread-Index: AQHX4SLovqOHzi8zakW5pKSla04gRqwaf1+AgABClqA=
Date:   Mon, 29 Nov 2021 17:19:12 +0000
Message-ID: <CH0PR01MB715310E9D87D76A15FEF96E2F2669@CH0PR01MB7153.prod.exchangelabs.com>
References: <20211124110308.2053-1-urezki@gmail.com>
 <20211124110308.2053-5-urezki@gmail.com> <YaTOfSi99jV6EGfM@google.com>
In-Reply-To: <YaTOfSi99jV6EGfM@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=cornelisnetworks.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c22b1bda-4619-4a57-550e-08d9b35c5c99
x-ms-traffictypediagnostic: CH2PR01MB5957:
x-microsoft-antispam-prvs: <CH2PR01MB5957D3A536EF5DB5DA96A9E3F2669@CH2PR01MB5957.prod.exchangelabs.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wUSd2kI5DhsqG5D3EKYgy/iEYlJVA8UDVtPjHs7fQC5htjC3p7qKvDRkqDMenq3ofk13WZXroxVJ5CV348ITqMRkyGbJD4URSttLBhm7gASBy2UTZbDpozlyssefTa0wI+TJgwQAhc2ZpLxSb1HxRFiHtW6IRD9mwAiodfQF8LjOO+1s06WzZq0xUImcOg2sJD+IMYLiOvj+qW/zc7FDzeNX3wYDG0Dv3Ljp3bBSiokgNeRa3RMLQYle2PtcMAvo9gR2MGaSHNkrCbm/Cbec6vhhMhxRJL2ts5/bRuLZdyPfOqrB7Akikyw5YLAvdZbjgCYtuVE0Zv55qylTqQRe0xV9EkSN8QSDI1Vx4Yks7OADNmP2pSzu1mzeQxJn03LhaWg5rVbhG3VXHNiFlwAWLD7urp4DL4MflenHcNuOAnNL+60o8ebFgZecpKZXeY28rHSwcTVOdQyfG+mOGA9Ec+NbCwKQhVkiVc12JbgBCvB/Fg/yXGr76j6m/7uqrExDhF2QfsosFwJRXimpDarmflBNp7FMe61rDjHcpBhDAnSWj4v7WZXFRACx8OBrMc+9KM8ICsAWBvfygQFbWTJTwyGCUOsL7p1BGs23DltftCL3N0yq0jQAMx32mLZMaRir05DPOQQsgXq33uvKY6ruKY7MiUj33diDsX0uTKwsyBhrrOrwyPv6eAfbDCMyNujG8OfsJIiVEQEFkOOeLAy1Dw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB7153.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(346002)(366004)(136003)(396003)(39830400003)(110136005)(186003)(4744005)(54906003)(8676002)(55016003)(122000001)(26005)(86362001)(4326008)(38100700002)(8936002)(52536014)(316002)(9686003)(33656002)(66556008)(66946007)(66476007)(66446008)(64756008)(2906002)(38070700005)(76116006)(7416002)(6506007)(5660300002)(7696005)(71200400001)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RGZWWXBtaTdoRkpQd1ViOUZ2ZTlpRnpoeDRxZWxwNzg4MVdVcTNmNVRJcVRp?=
 =?utf-8?B?RFdPbzFwbFlaM25ocWlWL0QxbGNUSlhhcVY4SUZHSUNxRzJYSTFEdUhkUHBk?=
 =?utf-8?B?STRSWTl0QUtXK1hoaThnaUs1VjF1dGUycE1aanZyT2lsOE42S1d6Q08xcFlT?=
 =?utf-8?B?NTFKaGRRdjFUZ05KZktnQ0FxOE96UVlHakh6cnZBZmRndmZEdTVReDBxZU12?=
 =?utf-8?B?RjcrZTBqTm1GZFZoZEc0RFpNOUV1WGdnSTFWekFMeEZnVXIvSytNdGN3eUpv?=
 =?utf-8?B?b2hyeGg4dm91TkNIUGxQZWtHV1NPUThpdkZKTTNWazI1TkFMY2dEL09PVHFv?=
 =?utf-8?B?UHRIYmhpYXozb3BqeUF5a1pYVUplOFhIcnZyQ2thekZxZnlTb3BGQUJvTUIz?=
 =?utf-8?B?TkNOS3g4ckUyaURFRTRFYlBnaVdKN3hOa2ROSVF2a2taMTR5eXdvZG9CcnlS?=
 =?utf-8?B?aUU1NG5RbHk4VURrWktTblQrNmE3eUlHaFJNWjMxVXRoQWlNZmhkVU5USkRE?=
 =?utf-8?B?dUxCVmt2Y2EwYnJvZ0dIV3dMZm4xbUE2Nk9IMHZON2RWUTdxZ2lxblE5RHJJ?=
 =?utf-8?B?RUl6QS9XdGI5ZDl3Tk8rTWRhYjRjbjdIWjlYbzFDekY1Mlo4QzNoUWo2UE4v?=
 =?utf-8?B?bWhoanhtWHJCVnlsclU0Sm1oeGdYV2xDQUFiNUdHajhDZFNOaGgvdjNTWHEx?=
 =?utf-8?B?bmc3bThqeHdiYW9PQURUYmczRS85Q1p0ekFxNERWU1pNaUJZZVlQK1JIOEVo?=
 =?utf-8?B?TmlyeElWVy9xYjBoMlI4Rmw1MEJEUWJocWplYm52VnFzMitjT1M0eG0vcG1a?=
 =?utf-8?B?Ti9MVlJqNThmUE9PSGsrUUhuelR1SWsyanhiWmRya1RnZldQUGZiSGZONDBD?=
 =?utf-8?B?TkZDc1dmN2ZPUHh1dGFDWDI0NkQ2Qk1nTG9COFlRckNLcEtlelhKTzdvT0JY?=
 =?utf-8?B?M1RJQUI1UysxNCtkQ2pMMmplOU9KZHRYZmZuTXhIejE4d1lHWmllZjZYWWdu?=
 =?utf-8?B?aEVMN1hnK1lKTDRlZnRwanhIYy9yNFEvN1NVQmNwSXZOSmp1cjhFSEw1b3Q1?=
 =?utf-8?B?c3hmemZEcG0rTXhSSGcrVXV0UCthUTg4QjFkVkp2WlhHSldVSXI3S0RhTWQ2?=
 =?utf-8?B?UERTRWdoTlhpVWNZSEhYUCtmdzlLYmVHN0IrcUNJQTU3L3d6ZmZWeVdKd0JY?=
 =?utf-8?B?eTNRVDBjd083NFBIWnpUU09YOE5pY2cxeWlqcGRZOXN6eDZEMXl1dHFSN2FY?=
 =?utf-8?B?K2REb2RuSEczUTl3cG9yUnhVWE1IOWNTbVh6Z1VwUmdsUzlITmZaZXNMb0sw?=
 =?utf-8?B?MWhmaVNOTGkzalVPR3hSSjFmNTVFTkdrUHhVZ0Rjc0ZaVEY2NXFBTFFERXow?=
 =?utf-8?B?RWs2NDBKeUEvTDFLbFBMRWl2dUc4VFZORTM3UklickE1cFV0czRxVXZUSEww?=
 =?utf-8?B?T29idnREQUIxWmZPMUUxeHVIcGRGa0FUVFpKUU9tWnA1SklWK3BMQ1ROZ0tE?=
 =?utf-8?B?UnczMHJkOTVVbytjRDhrQVZ4WGdJN1pXdlp0MHV0bzBxc2czUklVQ0gzTkg1?=
 =?utf-8?B?TFhKQ2xtU0Z3N2M2RTk1bzZ1dFJMOG95UnNFMXZmc2dJRU9JdjcrVWwvSzAz?=
 =?utf-8?B?dFpZb01hNnhhYVIwTVRjOXpGT2hsdnc5eUJJc3dIVzgrQ1FwRk9BRS9YTFk2?=
 =?utf-8?B?ZHpuaFpKK1dpc1ZFKzVSWXNTTER4YVRHTlg1aDJqNjduQzJ5ci9HQWIydUlR?=
 =?utf-8?B?TUV6TmZSeXJ6VU5iL0o4dmg5UjJZc05jWDlhK2JWNWx0bmFBVjB6TFdFeUYz?=
 =?utf-8?B?RXJxN011NG5yRGt6TUt4RmNwYkZXam9lV3R3ODVmU01kUFJjaHB1NlRiUzQx?=
 =?utf-8?B?WFFxQkpLZUpJSlEraElEK2JQUXpFcUhWOHU4ZDYydm5PV1IwTEpsczVTSkww?=
 =?utf-8?B?WDlITTRDdGFTNldmNzRzTUhPWFFaZnM2R2c5MXlHM0M5QVBrNUJmVkEzZTgy?=
 =?utf-8?B?cFBTRCtBR2JaU0U5NVoyQ0xvdWNKZGFwK1NaMSs1RzZvQmZTVGxRSm9aU251?=
 =?utf-8?B?Q3Y1Wms2S0llYUtYOHFVN0l6V0xEN0lOV3puSWVid2NZQkhxcTJGbzlKNVFl?=
 =?utf-8?B?cys2Q3BaWXRTQkp1REZDY3JWcWFOWG9Mb2RacjBYQnhNSndKbmR0Z3RCcWly?=
 =?utf-8?B?U2NyT0R0VStiQ0dzQ3krb1pXRlUwVGFoK2VmSjlyWjhFTmNMYkE5c3VJVVAw?=
 =?utf-8?B?WFVzd0pWOGJzVHJDaU9pSk1nWTZkejNROWEybGxkaVJLSEpWcU03a2RKRU9R?=
 =?utf-8?Q?tO46kqTA0uJ++wxfJe?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: cornelisnetworks.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB7153.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c22b1bda-4619-4a57-550e-08d9b35c5c99
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Nov 2021 17:19:12.0595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4dbdb7da-74ee-4b45-8747-ef5ce5ebe68a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VwUVG9QzU6coLv9V2sU/to3liuiZNkv1NlP+SwUT0nTJ/1FRzs7I92/l6fmevUyMOy0RsSMlwHR6I0dh20eRCok/rl9FMW87As1zb504RloN8ZmdTlVHiUYRR/Yv4CIP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR01MB5957
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBTdWJqZWN0OiBSZTogW1BBVENIIDQvOV0gZHJpdmVyczogU3dpdGNoIHRvIGt2ZnJlZV9yY3Uo
KSBBUEkNCj4gDQo+IE9uIFdlZCwgMjQgTm92IDIwMjEsIFVsYWR6aXNsYXUgUmV6a2kgKFNvbnkp
IHdyb3RlOg0KPiANCj4gPiBJbnN0ZWFkIG9mIGludm9raW5nIGEgc3luY2hyb25pemVfcmN1KCkg
dG8gZnJlZSBhIHBvaW50ZXIgYWZ0ZXIgYQ0KPiA+IGdyYWNlIHBlcmlvZCB3ZSBjYW4gZGlyZWN0
bHkgbWFrZSB1c2Ugb2YgbmV3IEFQSSB0aGF0IGRvZXMgdGhlIHNhbWUNCj4gPiBidXQgaW4gbW9y
ZSBlZmZpY2llbnQgd2F5Lg0KPiA+DQorLS0NCj4gPiAgZHJpdmVycy9pbmZpbmliYW5kL2h3L2hm
aTEvc2RtYS5jICAgICAgICAgICAgICAgICAgfCAzICstLQ0KDQpUaGUgc2RtYSBwb3J0aW9uIG9m
IHRoZSBjaGFuZ2UgbG9va3MgZ29vZCENCg0KTWlrZQ0KDQpBY2tlZC1ieTogTWlrZSBNYXJjaW5p
c3p5biA8bWlrZS5tYXJjaW5pc3p5bkBjb3JuZWxpc25ldHdvcmtzLmNvbT4NCg==
