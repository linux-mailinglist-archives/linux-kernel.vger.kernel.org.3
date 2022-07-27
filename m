Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A207D581F66
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 07:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbiG0FQ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 01:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiG0FQ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 01:16:26 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FA82A41E;
        Tue, 26 Jul 2022 22:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1658898984; x=1690434984;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=P6HmDVgjdLFV0n3Df96a/FHIVmT8L4yglgCN9NawC2k=;
  b=SIfeqdfdEpDA7LiKEQEEJygwNwKcx1aZ9WiHKpIATDsCymfF9C3Ys9Wg
   4spjvdWdTg+wYz+ZOSdk4OhO7erqVap+ASCz5XTTKEyQNdl08JcXGYa0k
   Vf6Li7aZQ+O1zepcB+Q3xRbTapfm1NduCGINdW28eKOjj1zYa/Z0DWfwp
   5eGSSQ3DbjtKa5mYyzHRhPY5EQ+9GmlCNjnZqWhY6JIgY9VlNOCwpVTVV
   kadMqG6phqiKhC2z6sGzm8vXUAu+VD+VAt6ukXIeRtdoXQTrsT8NW8xji
   uXz3Gxmm2/0OlQFE0InfFwDGn5H1ENAaOen4M2hNQ6vFiiVV0YVZjIeaa
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,195,1654531200"; 
   d="scan'208";a="211954578"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jul 2022 13:16:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=chNUZwuwCpm3oj5UCSiJQu5UhREGV2M+lQzj1rPEai3CIQurtYET62c8wQbZNhEreIKu8H2y6kIF/OfCxZj7mHkssd+LTDuBsNERos4o6o2BJSyVs4XGy0dGBddAh5okmKGtUmMsJnf1fUZDm15jU06uE8C9JWgEGpf7SAgIJhl0lhG++d3npQgdXB/vs2yJgUYeUZxkLQSr9oC9Kpox0tN3EWVL1Jn01ON4yt7bDIXcECdTPX4qnibOxp9oHE5A06/arSSjIa1pAD2RKc3dFyEwa9e57waLB7yOr8dvrxdxh594ngzQjGcVa8LaJEuNZTD+gujPcYYd4G5BFsw7Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6HmDVgjdLFV0n3Df96a/FHIVmT8L4yglgCN9NawC2k=;
 b=BMfxaxG3Tai7q2O/9ocu09OPWHJI9EITnqnW8vR77cV2tGuefyAjkIzRPUSWhZhp+9pUHvnRef4WYwOpp/wyy8Bw6rDdhEq7OdLVjh7NyUVXVp0R0+EvQ2Sm0cZmufDAuTEggRlNtLViZcaD9jG3NCX0jjHIkGFGm0niV8fMoyxsxXEn+dOUukh5NOqMGltitqGssYk0qTodpoKmtgAHdFQLY4fG/N66D3p6JSN7+/CNMnoEgbnbrMwzOkNyDA7qGf1MtxeABxMtqmj0Mq8rjjrNWEBxPad+ywGYMLl6RJgbXvnv0p3k8x24Yo4Wkj1LJEzNpMG80PZTZMYfb+nkDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P6HmDVgjdLFV0n3Df96a/FHIVmT8L4yglgCN9NawC2k=;
 b=PLjMqK2QE8eNDiW6Hg3ohv8Bc5YKdYBzsQaACGtUY6tVPiyF62g/KUzUqOXZMU/gz/9UEJI9ucb3Npsp7hBxNgRuWWMueImLhCgORqGdheBHHDjNSPszK2bTtPKoq/77XcOQF4MV3RgSdSa6GrHpYMr8AMcAvfLwCj127ikqrgI=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 SJ0PR04MB7168.namprd04.prod.outlook.com (2603:10b6:a03:297::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Wed, 27 Jul
 2022 05:16:22 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::5d26:82d8:6c89:9e31%8]) with mapi id 15.20.5458.025; Wed, 27 Jul 2022
 05:16:22 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Gyunghoon Kwon <goodjob.kwon@samsung.com>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC:     "alim.akhtar@samsung.com" <alim.akhtar@samsung.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] scsi: ufs: introduce dev_cmd_notify callback
Thread-Topic: [PATCH] scsi: ufs: introduce dev_cmd_notify callback
Thread-Index: AQHYoXdBziph/dXK0Eu7i5Dve30rXK2RrJVg
Date:   Wed, 27 Jul 2022 05:16:22 +0000
Message-ID: <DM6PR04MB65752988E971F9953913C38DFC979@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <CGME20220727051046epcas2p15481688ac3b7917bed8d06ebfb0a4184@epcas2p1.samsung.com>
 <20220727050954.118743-1-goodjob.kwon@samsung.com>
In-Reply-To: <20220727050954.118743-1-goodjob.kwon@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5bdcbee5-6c4b-49f4-69ba-08da6f8f252b
x-ms-traffictypediagnostic: SJ0PR04MB7168:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y1r4nR8xmxwmP2y1iQEkLviSWNrudzgOgM7cILx9DFFeu3ycmM7Q3ImQau0+FKa0FDOsLAdZfAY98YpBPsZ8T/jbDXxx1PbmDJJC/tAI7UbqMY2ePleBmYc+jXKnxKTgqbVeIh/lOaeRJEnF1kO6I3s9gauImxgpv9rIE2TPBxNa49AtQQT+K/k8q3MU3kJp8FlGnjMX4BP7K6R40SPkCFRSMirWpqoHcn+LAILb7MN2UOnTXyXpa6uqVp+IG4QFLrb4sR0VNlHWbvDuuQkNcHWE3qkwHyWhlD02evml5Gcz57DQelJt8wod8b4SIvevXkM7D1IzsNPf73//tqITEhf22yYmna1w+YqBkODTjF8jciJPVtFmF5HJ/q+sI5k6WALm8FFfCGDRcdS81Rj+GJZn4y57tWMv8RwM3tqwAi/qkwgKHyGxFREaZbHFYcVj70qlEN+/VjedwI+m9di9sDUlHRsg/9KWXHW+k3aC5rRPMb1Ee3SjFMNEC7JblPNfmweAMzb6s4sV+jxR0i1Dluge7oO6uKicGx6FdAcjPgvK/5E9L5VVovaFR0gZEfgIIXe72wDTpzfSJI5xkQYe5B8H+6XPNsV7IwAFzdfLuz5vyPdeuleL1yUyrQGNJXhwE5pyg2SwQVeRUtaeWWo1GuQgYOV5q4cXjc0DXs106Dihivb5JzkfKlhD/1NkJ/+fFsJ7+y45nfgWwnqBVmH8xuTAfAdEKU8zqldo+k0DzKdMEzznf0EUpwlPPslH6DDa6S9X0TcULXckmA0zwhOUVjCRhclqTiyDStJFfcymBOrLG7NC5A7bMYoYLR8NCYVT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(39860400002)(376002)(396003)(136003)(346002)(71200400001)(122000001)(186003)(110136005)(82960400001)(2906002)(86362001)(55016003)(33656002)(41300700001)(38070700005)(478600001)(83380400001)(38100700002)(66946007)(52536014)(76116006)(7696005)(54906003)(8676002)(66446008)(8936002)(66556008)(4326008)(64756008)(66476007)(9686003)(26005)(5660300002)(6506007)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OG9xNUdSUzRUY0V4dGNRcmtvSXBxS0FnYVd0UmlOS3Z1eEJFdm1zMVRkdWti?=
 =?utf-8?B?UUsvYmxUM2xNbkVJSjZVSFVLQW50bzg3K0ptWTR2RWYxTFI1aVk1b1pxNzA0?=
 =?utf-8?B?Z2hlN1ZVeU1tM3MybnVuMHExME1kVTFZYzBFWmhyeVhtREpBMU1JVFNmZC9n?=
 =?utf-8?B?K0lQMElETkdGZ014OWE2NEk4UzNKQno3WnpBWnpKUEFkdnBWYWl1ckVwUktH?=
 =?utf-8?B?T0RDOTdQeTJvemdFNFRYcEVHQmlwaERlOWJKK1JneEpYWGhEV01HaDgrUmJY?=
 =?utf-8?B?UFQzQ3hJUlNWUkYyTHBnQmQ1Umg4dGhVK2U3eFFyeWI1M0gvRFk3MTE2R2Fm?=
 =?utf-8?B?d0pzdCtCZVpoUG9Zem9QN0l3bTN4eTNuRmY5TlRWRXhsYXlqWHlsUTQ2Q1FU?=
 =?utf-8?B?bVhSYUhhbmlGUGdCNGtaUjlSQUJMNHpZMU1aTGlaVncyQWJXZGl5VG5QUXNT?=
 =?utf-8?B?bjY3WCsrVEVRQ0JVMXpxYnRCVWl1MHlRakpaZXRkVmw4clpMQnhjWjNJbjZ5?=
 =?utf-8?B?VzU0a3dic1luMnRzbVNZWWdEMmhHUEpaUFBXWW5DWThKUHNOWlZtbzgzM25X?=
 =?utf-8?B?TDZnUTFHbFFUSjlIb0RqUHV4bTQrVnpNTUxldGVPQ1I5MUl1bUtsd2FrRG5z?=
 =?utf-8?B?M3ZvKzZMTW5ETENhblZ5WS80Uk5ZZnQ3RllreGs5UEFBdzNTK0trZlFqUnVn?=
 =?utf-8?B?ZEE5dEdsbnNKSXpYWUlROERaTVMxVWNDVmoveXgxY29GMkYxL2JaVi9GVjJW?=
 =?utf-8?B?MVlwbnhDeUNQMFgxYXpFamM4d1ZCN0hpRzdPaUxmN09RYmtpK3E1cFlLbzhl?=
 =?utf-8?B?K3VicWxCYXNpNFlRU2xJWWgzWjNjNWNZaFpTai9jTlk2RmZhTHFhdkJsSWln?=
 =?utf-8?B?TUNHSENhZzl5eHY0bFZ1T2ZhN0JybVdpdzdOWGJqaWJrei9lRDRPWWd4U1Vw?=
 =?utf-8?B?ckRYSTU1N0JiY0R0bTJvWEZBZDNVeWoxUktLTVFtSkoycmRpTGNTb0xoaXkv?=
 =?utf-8?B?ZE1LczY3NXJQVC80S2RXVC96bEM2N3Q4L3IvWjRQb3R2elRXdVgrMzQ3d0U5?=
 =?utf-8?B?VXY5S1VRbWY2ZzZVZC9ZWlZLUlNkdk5uTktuOUFodTRMS0NiRkZCZVUySkVK?=
 =?utf-8?B?WkJQclZVaTI3U0FQZmlHbWxqM0ZkS2xOdnNMZ0Z6YnBBR3RkbStSS1dqb1BE?=
 =?utf-8?B?OUR1U0dpVk9aYkczV1JyTG5rOGtRZTIrK2M2Y2daSGtwZEc3bWgyckFlVDZC?=
 =?utf-8?B?VkxhWTIzN090ZWZsVXE2QTBmNTZiQis2M1RPTEpSMjhCZmVtcWdRMEpDWEZq?=
 =?utf-8?B?SE5MSXByM2dJSXV0RjVKRjFjR292OTZNcW44ZUo5cDRXSEtoZHV0VGNZSElG?=
 =?utf-8?B?dUwzVXNxZm0wMjVhN1JKemY2dGFaM2VPNHJ3RE9hc0laQ0ZKWFFvMTBtRWdu?=
 =?utf-8?B?Mlg0T0hMTE9MVURCUkdBUGQ4M3BPN2w0ZGJ1ZWVubVRxY1drVXJ3Rk9JZWVP?=
 =?utf-8?B?ZUREL1ltc0pjdlhrdG5lNHA2MGVlYzVib1h2UmdHejgzMHB5Q1ByWnpUNVYx?=
 =?utf-8?B?bzRPd2VybmMwaWpkU3R4d1E5bDJmSDV6d1FmcmVjN3ZMa0FWU09IM0doQVpt?=
 =?utf-8?B?T0xkSXErbFBUTWdMMHdUWW9zYzZIbkVSVTZjVkVNbWVwaGl5cmRBRGowYW1J?=
 =?utf-8?B?RU9nMURZNHhZdnlNQ3hOM3pwamxLVTlOK2I0SDB2U2N2OXVVVXY2WXRpdldJ?=
 =?utf-8?B?aitsclZuTTc0Ly82a0JUQ0J1TGRvLy91TC95Ymo0L3A1S1RHaHdXWGJhR3My?=
 =?utf-8?B?akx5N2puY25vSW9Tc2J2N1JQZkdWS2thazhHbVRiT25lWGUwYXZPVE91REEv?=
 =?utf-8?B?N1d5dHFLcDFiNy9NUENnVUh3SzFZL0VTK2JQM1N4c282QzMvUERSKzg4V1Zl?=
 =?utf-8?B?LzY0YTNZZlhNTGFIaENad0NoeDVKaFhHSVJ6aWlFN2gzb2NXd204d21zNFpt?=
 =?utf-8?B?MFhUOVI2UnYyTGZRZ1oxZXhyS2YyVlNxVEpXUU15RTRYaTF6TGRnSXBnZFhC?=
 =?utf-8?B?QkNHZVZRMzlDcDl3dDFJUFBCMTdORFFOOWxOUmxkZTNSbDFNTnlQV29Feiti?=
 =?utf-8?Q?jtC+G1MgeMJefzp1DzMRZRnDm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bdcbee5-6c4b-49f4-69ba-08da6f8f252b
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2022 05:16:22.0486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fNJWJxJx1B44SddFccQRw78+work4bbHZ/99agn3PFP/iXyrVEhzsUjtF2K1JuUMdJZ0jeLr+YcDtFP0gj0BIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7168
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiANCj4gU29tZSBVRlMgaG9zdCBjb250cm9sbGVyIG1heSBuZWVkIHRvIHN5bmNocm9uaXplIGRl
diBjb21tYW5kIGFtb25nIFVGUw0KPiBob3N0IGNvbnRyb2xsZXJzLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogR3l1bmdob29uIEt3b24gPGdvb2Rqb2Iua3dvbkBzYW1zdW5nLmNvbT4NCllvdSBuZWVk
IHRvIGluY2x1ZGUgYXQgbGVhc3Qgb25lIGltcGxlbWVudGF0aW9uIG9mIHRoaXMgdm9wLA0KT3Ro
ZXJ3aXNlLCBpdHMganVzdCBhIHBpZWNlIG9mIGRlYWQgY29kZS4NCg0KVGhhbmtzLA0KQXZyaQ0K
DQo+IC0tLQ0KPiAgZHJpdmVycy91ZnMvY29yZS91ZnNoY2QuYyB8ICAyICsrDQo+ICBpbmNsdWRl
L3Vmcy91ZnNoY2QuaCAgICAgIHwgMTAgKysrKysrKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAx
MiBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91ZnMvY29yZS91ZnNo
Y2QuYyBiL2RyaXZlcnMvdWZzL2NvcmUvdWZzaGNkLmMgaW5kZXgNCj4gYzdiMzM3NDgwZTNlLi5m
YjY0MmM1ZTczYTMgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdWZzL2NvcmUvdWZzaGNkLmMNCj4g
KysrIGIvZHJpdmVycy91ZnMvY29yZS91ZnNoY2QuYw0KPiBAQCAtMzAyMSw4ICszMDIxLDEwIEBA
IHN0YXRpYyBpbnQgdWZzaGNkX2V4ZWNfZGV2X2NtZChzdHJ1Y3QgdWZzX2hiYQ0KPiAqaGJhLA0K
PiANCj4gICAgICAgICB1ZnNoY2RfYWRkX3F1ZXJ5X3VwaXVfdHJhY2UoaGJhLCBVRlNfUVVFUllf
U0VORCwgbHJicC0NCj4gPnVjZF9yZXFfcHRyKTsNCj4gDQo+ICsgICAgICAgdWZzaGNkX3ZvcHNf
ZGV2X2NtZF9ub3RpZnkoaGJhLCBQUkVfQ0hBTkdFKTsNCj4gICAgICAgICB1ZnNoY2Rfc2VuZF9j
b21tYW5kKGhiYSwgdGFnKTsNCj4gICAgICAgICBlcnIgPSB1ZnNoY2Rfd2FpdF9mb3JfZGV2X2Nt
ZChoYmEsIGxyYnAsIHRpbWVvdXQpOw0KPiArICAgICAgIHVmc2hjZF92b3BzX2Rldl9jbWRfbm90
aWZ5KGhiYSwgUE9TVF9DSEFOR0UpOw0KPiAgICAgICAgIHVmc2hjZF9hZGRfcXVlcnlfdXBpdV90
cmFjZShoYmEsIGVyciA/IFVGU19RVUVSWV9FUlIgOg0KPiBVRlNfUVVFUllfQ09NUCwNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKHN0cnVjdCB1dHBfdXBpdV9yZXEgKils
cmJwLT51Y2RfcnNwX3B0cik7DQo+IA0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91ZnMvdWZzaGNk
LmggYi9pbmNsdWRlL3Vmcy91ZnNoY2QuaCBpbmRleA0KPiBhOTIyNzE0MjE3MTguLjM3NmJhYmY3
MTQzMiAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS91ZnMvdWZzaGNkLmgNCj4gKysrIGIvaW5jbHVk
ZS91ZnMvdWZzaGNkLmgNCj4gQEAgLTI5Myw2ICsyOTMsNyBAQCBzdHJ1Y3QgdWZzX3B3cl9tb2Rl
X2luZm8gew0KPiAgICogQGNvbmZpZ19zY2FsaW5nX3BhcmFtOiBjYWxsZWQgdG8gY29uZmlndXJl
IGNsb2NrIHNjYWxpbmcgcGFyYW1ldGVycw0KPiAgICogQHByb2dyYW1fa2V5OiBwcm9ncmFtIG9y
IGV2aWN0IGFuIGlubGluZSBlbmNyeXB0aW9uIGtleQ0KPiAgICogQGV2ZW50X25vdGlmeTogY2Fs
bGVkIHRvIG5vdGlmeSBpbXBvcnRhbnQgZXZlbnRzDQo+ICsgKiBAZGV2X2NtZF9ub3RpZnk6IGNh
bGxlZCB0byBub3RpZnkgZGV2aWNlIG1hbmFnZW1lbnQgcmVxdWVzdCBpcw0KPiArIGlzc3VlZA0K
PiAgICovDQo+ICBzdHJ1Y3QgdWZzX2hiYV92YXJpYW50X29wcyB7DQo+ICAgICAgICAgY29uc3Qg
Y2hhciAqbmFtZTsNCj4gQEAgLTMzMSw2ICszMzIsOCBAQCBzdHJ1Y3QgdWZzX2hiYV92YXJpYW50
X29wcyB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCB1bmlvbiB1ZnNf
Y3J5cHRvX2NmZ19lbnRyeSAqY2ZnLCBpbnQgc2xvdCk7DQo+ICAgICAgICAgdm9pZCAgICAoKmV2
ZW50X25vdGlmeSkoc3RydWN0IHVmc19oYmEgKmhiYSwNCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBlbnVtIHVmc19ldmVudF90eXBlIGV2dCwgdm9pZCAqZGF0YSk7DQo+ICsgICAg
ICAgdm9pZCAgICAoKmRldl9jbWRfbm90aWZ5KShzdHJ1Y3QgdWZzX2hiYSAqaGJhLA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZW51bSB1ZnNfbm90aWZ5X2NoYW5nZV9zdGF0
dXMpOw0KPiAgfTsNCj4gDQo+ICAvKiBjbG9jayBnYXRpbmcgc3RhdGUgICovDQo+IEBAIC0xMjE3
LDYgKzEyMjAsMTMgQEAgc3RhdGljIGlubGluZSBpbnQNCj4gdWZzaGNkX3ZvcHNfcGh5X2luaXRp
YWxpemF0aW9uKHN0cnVjdCB1ZnNfaGJhICpoYmEpDQo+ICAgICAgICAgcmV0dXJuIDA7DQo+ICB9
DQo+IA0KPiArc3RhdGljIGlubGluZSB2b2lkIHVmc2hjZF92b3BzX2Rldl9jbWRfbm90aWZ5KHN0
cnVjdCB1ZnNfaGJhICpoYmEsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBlbnVtIHVmc19ub3RpZnlfY2hhbmdlX3N0YXR1cw0KPiArc3RhdHVzKSB7DQo+ICsgICAg
ICAgaWYgKGhiYS0+dm9wcyAmJiBoYmEtPnZvcHMtPmRldl9jbWRfbm90aWZ5KQ0KPiArICAgICAg
ICAgICAgICAgaGJhLT52b3BzLT5kZXZfY21kX25vdGlmeShoYmEsIHN0YXR1cyk7IH0NCj4gKw0K
PiAgZXh0ZXJuIHN0cnVjdCB1ZnNfcG1fbHZsX3N0YXRlcyB1ZnNfcG1fbHZsX3N0YXRlc1tdOw0K
PiANCj4gIGludCB1ZnNoY2RfZHVtcF9yZWdzKHN0cnVjdCB1ZnNfaGJhICpoYmEsIHNpemVfdCBv
ZmZzZXQsIHNpemVfdCBsZW4sDQo+IC0tDQo+IDIuMzcuMQ0KDQo=
