Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2CF473296
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:58:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237971AbhLMQ63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:58:29 -0500
Received: from esa.hc3962-90.iphmx.com ([216.71.142.165]:46042 "EHLO
        esa.hc3962-90.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235177AbhLMQ60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:58:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=qti.qualcomm.com; i=@qti.qualcomm.com; q=dns/txt;
  s=qccesdkim1; t=1639414706; x=1640019506;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=dPumVHyksiJFN6D0nU85Y2prrZD4WLWBUtMJ5Ti48IE=;
  b=y78PNwfiIemzpleqzvuwnLFfW3mGptohqByELvO8GtgujMTfRRLkxD6W
   jtHkVYgqJU19EVreunJEozASLPsYsFobChXyZo8HMMNJ4e1tEsF4DH5zL
   q2vDEyOYyduLsijsERwmHsEI43v8+CQCWj161xlht8GP/ZEJGN1OBy2SB
   M=;
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 16:58:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iFPzuvb9TA/vvHRuoRqQUJbH7BgRY7Jm43aLRYbRj+/aidgRr5Mg9+TFCVhxVPhJfNcCa8hw5JvO1W9GzH62FCtSxm48kkwWQO4XHBMlIwSRKcjnCDu1oKfb387rriryS2XGl8tF8QypluBNGK3p+ZFwNdh+XryNxx8L7SeCLy7IHEmpMokDD0W0UIjD0cd2fSyNoWw91zYTau+eMcsw39i4A236bW1i/Fj0pSVN/E302ebPw369D8Fo0kcDwn5B4n31089/0nfHSgYyqZZiBwu+yIkT3ipw+88GvXePkdbvDTmA2m82tWwAn2vYSZaRCJ6EmJ6U36Q470lJnQijrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dPumVHyksiJFN6D0nU85Y2prrZD4WLWBUtMJ5Ti48IE=;
 b=WekbWTytnKZbLGQY2TLnu2KKJwMt/tZNLknanvbsOcU2WDn7GDkLPyXuOd2Bw+7etATKWrRR1F2mn8Ya3B4d66qcnLVyavRKfXdEVM6Cl5xjwvOvX4JasrChzIRRhN5Q2Ew4XcBgZS5cxjGDrLObUxobie4wgKGcPAAGmEohrFRm/TUWsmuwjDLGKnAHWLq2xp9JDbdSso14ctD6kNEoupIcsntxlrdHCigAU5XrRaNBU1+Ocws0gIN28Lt26zqGKVe9YuNXaW9DGo8NyH+kQo+ayWDu/yFTba7p8diqGOEa9dxHLqUWhIA/gI6OFC77hHhvEdDbD4hj6NDEUBXEyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=qti.qualcomm.com; dmarc=pass action=none
 header.from=qti.qualcomm.com; dkim=pass header.d=qti.qualcomm.com; arc=none
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com (2603:10b6:a03:3f5::8)
 by BYAPR02MB5560.namprd02.prod.outlook.com (2603:10b6:a03:9f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 16:58:21 +0000
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::6837:9c03:af16:e6a9]) by SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::6837:9c03:af16:e6a9%3]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 16:58:21 +0000
From:   "Sajida Bhanu (Temp)" <c_sbhanu@qti.qualcomm.com>
To:     Doug Anderson <dianders@chromium.org>,
        "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
CC:     Doug Anderson <dianders@chromium.org>,
        "tudor.ambarus@microchip.com" <tudor.ambarus@microchip.com>,
        "michael@walle.cc" <michael@walle.cc>,
        "p.yadav@ti.com" <p.yadav@ti.com>,
        "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "richard@nod.at" <richard@nod.at>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stummala@codeaurora.org" <stummala@codeaurora.org>,
        "vbadigan@codeaurora.org" <vbadigan@codeaurora.org>,
        "Ram Prakash Gupta (QUIC)" <quic_rampraka@quicinc.com>,
        "Pradeep Pragallapati (QUIC)" <quic_pragalla@quicinc.com>,
        "sartgarg@codeaurora.org" <sartgarg@codeaurora.org>
Subject: RE: [PATCH V2] mtd: spi-nor: winbond: Add support for winbond chip
Thread-Topic: [PATCH V2] mtd: spi-nor: winbond: Add support for winbond chip
Thread-Index: AQHX50c/AxvFsMywYUa9+bTRjnnN0awwpEgAgAARngA=
Date:   Mon, 13 Dec 2021 16:58:21 +0000
Message-ID: <SJ0PR02MB8449D55AF90D8CA80321AD0ECD749@SJ0PR02MB8449.namprd02.prod.outlook.com>
References: <1638427092-9139-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <CAD=FV=VB6hsEHEb8yZmB=xA__47p4vC6dBc528RV37dvAKTgOQ@mail.gmail.com>
In-Reply-To: <CAD=FV=VB6hsEHEb8yZmB=xA__47p4vC6dBc528RV37dvAKTgOQ@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=qti.qualcomm.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6208d2a9-9810-4b5a-786e-08d9be59c50a
x-ms-traffictypediagnostic: BYAPR02MB5560:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <BYAPR02MB55601030D8F4BD6587C44D0BCD749@BYAPR02MB5560.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o9EZzQ7RG6nIjlhnE9FfG7j2K7U4+RPNN2OpZWFsjUpbSvdDnGanrXjeLiTwNJlLTclzdaq/dsIRK3lcC3v8k46NpxhJEgWKNed946TYF7mHgWoWVMXPEneZ7AyOYm8LNdtqE5AmWk/ATi5/zsgdP3BrUN2h7FSUb8LihFfJCm4XCJq+qR1kGlmgyYPgn5neVDd1yj6yj/XvQucuovI/YKUJzJK/WFzvQuabsig4bDduCTu0gSwVhES4MOXI5KLoQlcw+E8VE2t1ueU+R9xQ/4mQXI5GqH6nOe03Gt0NGeAl5ewYtP6YkRUH98UKFXs2zjaCnX6jAQZbHzRA7F7H9Rt+7ojz+LCrWFM9nq5m8gJknkgjFiiLsufoe/Secf+YtqFA57CTcDO6J872yzdFMrYDvnyxtO2z1IdFSLzukmqpjJaATUM0KcqcCoLcg88NqLYBdge17XpcSNWbgYtm53P/Ez1HMAIy1UZxLhp2qpIO3jtW4y0vR2dSLyoij7pSua4j3Oe8gLKQS/45YXpu9obVY/RzEl8Zb2fQe9heLFseQq/UE5gVWpJEuFOo1XDCeIA4NOA7gCiYiTQQu1/8kpo3wiD2sUsXYFEvxch6jAhl31P/WUlzRrjFXAJ0w27YHsE4I7dacHoo0FRA5IV8NRQ9ua33kbSBStem/2/kHNbu+W98n96nrP3CnPMGcyf1iqOzf2tSfGUcPR1elrmSMR5dz9rQ7keFV5FR9j4cLYzh9JFFZ5pKf2OrsEfH94M1bZE5XDpxWxoPd0Ex8KlxCqlPBuAwgu5LyZAFvVFI7SyMBwyvDB1lup9XT71tnM6wpOIcZV87YLzE62Uirp/zbA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8449.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(54906003)(110136005)(66946007)(55016003)(7696005)(316002)(6506007)(53546011)(4326008)(186003)(64756008)(5660300002)(508600001)(66476007)(33656002)(966005)(71200400001)(66446008)(76116006)(26005)(66556008)(83380400001)(8936002)(8676002)(122000001)(7416002)(38100700002)(52536014)(86362001)(2906002)(9686003)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U1JESkp6OU82R0N5d1VMRnFLbU0wVDBGVXlFODNWdjFkMkZRVDY0TnZlVHBM?=
 =?utf-8?B?RVc4dWs2a1hDbjd6b3A5TjB6MUpLZHZoaXlub2RseUZwSzh6YjNXczRyQ3hZ?=
 =?utf-8?B?RFA1RGJnOXdwTlFPSEdLaEZUbDdzMm95UDF6T0JBWC9ObmUzaER3RDNZL1pt?=
 =?utf-8?B?cDFOVFZGTlc0RnJEVElVSGJ3d1NCSHdaaElLejhWSFVxc1ZNUmhHdlE0TVZR?=
 =?utf-8?B?ODlkUkZBY1RSSGdyU2VpQ0x4V1NpcGpaeU1BZW9XZlovNUxvL1BoQklzcDM5?=
 =?utf-8?B?VStBNmFoWW9FVlAweU5zVGgybVNwbldDTTIrMXFTQkM3OE4zZmx6SncrS2JX?=
 =?utf-8?B?cnhoTVBvd1VxYWZVMVh2bjF4MDl6VmduMm1UVUtpNlB2aXdsdnBsbmo4eHA3?=
 =?utf-8?B?RnJTdlU1bWNQMFR6VHB1ZGVCRyticjRHeW1MVGNEV3haTk1ncVJQQW5vRWxy?=
 =?utf-8?B?N3I5SnFySThuUGdwV0J5aUFIdWUwemQ2dmRrUVlqeG9NY210NEVGeDByRzFt?=
 =?utf-8?B?VFlKZUZyTmsvSkxKSjAvUEtpbzVNLzZRVVFVcHhMSnJKOHBFa1JBWE1KSFl6?=
 =?utf-8?B?YlhFcWd4SysxUjRzbXpFN1g4ckJNVHY1Q1FsWmpLRmY2cXMyNFVySUM5UFE5?=
 =?utf-8?B?YUp1eEhiWE5DdnczSDZFckwvTHRiY3ZlUEthcGk4U0J6QnN0M1V6MWxWeXQ4?=
 =?utf-8?B?ZzJQVTZuUFFwdjgvZmlJb0paRkR4ZWRBK2h5T0FiZGpPUGtuOXZoSVVLWVdP?=
 =?utf-8?B?SzB0RWZWcklxdUsxRXdwQzhoNDhGVnBZNFEzeDNNa0FEOUYrakx5TkpiUlRB?=
 =?utf-8?B?aytyVEpYdTMxMndPL0Q5N3FhQzlBTGhSTjg2cnpxVUpGRDQvRTI5VHkwMmJo?=
 =?utf-8?B?SnB5a0lHTzVKcFdSbHY3ZkJLTlpCQWtmd2FqL05jVGVNa3RLa1NOLzNjSWJ0?=
 =?utf-8?B?Zk1Hc2V3Q0lVWHMrWXVwQUNFUVVRZDZPODJpdE1PcFJRNkcxclU1cXQ3VFB3?=
 =?utf-8?B?WEJJbmV3aS9jbUZRQ2xEZTJJcXpPVXBFbnpNSG5QS2hManhySHFFeWpjSDVv?=
 =?utf-8?B?ODh5NXoxckRGOVhUVThYL2YzMEhUWWovbTRGbjYvTmhyaU42NlovSDNKczBB?=
 =?utf-8?B?RDVaK25VUmRjejhSWlRpZmhhTklBdGo3V3RJZkVuZ29wMlBjMlpQenlaNmlX?=
 =?utf-8?B?REpkVWJ5TXliVVA5ZDhlT0dNMUF3bzZiemI0N1RZeFo2TGFKdVEvWDdLTXVM?=
 =?utf-8?B?OFhQTDJFV0I2SENjYnhPQ1l5OGwwV2E4STJUU1AycU1ISFNPbmRBV0hxc2Fq?=
 =?utf-8?B?MW1OUDd1TGRZTUl2NUFZL3JLZmN1VjcwdCtXSUM2aGh5TE54YnRhS2pnbFow?=
 =?utf-8?B?Q0hIcDFCSExBNU5UM1hBMFdaY0JFSjJmbDE2YUxET0wxM0x5dFZ5a3UxQ2tM?=
 =?utf-8?B?aWFndUlUeW5jeDI2di83QVFIOVFSd0dsYVdBaXBxV1YxNUtzWjQ5TUE5M2kz?=
 =?utf-8?B?YXNYcnhVUkhaVGVpOWZuRFVJVHp6a0RqcTRZSlBnQWp0SnpMb3BwRXZ2RTA1?=
 =?utf-8?B?eFR1ZFN3S1RLM3pqTDFNVFRyNGh0WmhkRmVmVXRVZ1AzSE9SbitsOUJNVHR4?=
 =?utf-8?B?Tk5FUHhFR2NFekpxMVQxN3g0akQrWXpTbitrVVVlQXE1SWEvUDY4U1JrZlRk?=
 =?utf-8?B?MzYzWkgwT3dtaU9iOGNtdXdpRUdyRVhUNm56R2tyYkxjU3NPTVl3RmQ4dm1X?=
 =?utf-8?B?SUxLbEkxVnBVQ0RXOVl1eVZjaWVKcllPODRjWURVQmxReVBpUklDVVUwUWl1?=
 =?utf-8?B?RXovOXRGdkxKc3ZlL2VFUUl1R2VnRXo2Tm0yTHpGYlRqZG5DL0VnT2lzYlZR?=
 =?utf-8?B?YVMwMC8rRm00b2NaNDIwVDhoTGU1S3dnVmlZMnF3VGsySm9pRGNBclBnbnF6?=
 =?utf-8?B?QmlqVUdvcXVzbkVUQURidWx1eTJnbWlxT01uRW5hbjhDcDkySTBoaElXUDlL?=
 =?utf-8?B?eFE1Ukoxa1B3UkVrRWI4am1YbS85cWh3ak9ibVg1cGxlYmd4KzlYQlhiZXBN?=
 =?utf-8?B?MkE5bTFiUDUwQU1SS0RobERyK2g5dFJjR2plam9ObVQzSmk3MkFoK0dPSUt2?=
 =?utf-8?B?U3oySzV1UlVIaS9CT1pFaFV2UTVBNzlFNGxQSzMyMXdaQW5Hb0xud0NkbEVR?=
 =?utf-8?B?L1lEbFdXck9QSmJYUGtsaXhtcXhkM2pPRlFaQjI2cEdYdy9ISGlCZVliRVh0?=
 =?utf-8?B?V1ZmVlA4Sk5FTVk4OXpCbjFKc2lBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: qti.qualcomm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8449.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6208d2a9-9810-4b5a-786e-08d9be59c50a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2021 16:58:21.5862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s2vBefwdpxe/ZQWBkU49AXMbtBc/dntCKPpEYemBJTL9YEDAIHgqL8HXLEScV2g7WOIAP2fHuB0WncF8RVvYFVDJ0zK7eybcGgrpbniV3K0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5560
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgLA0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuDQoNClN1cmUsIFdpbGwgbWFrZSB0aGUgY2hh
bmdlLg0KDQpUaGFua3MsDQpTYWppZGENCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZy
b206IERvdWcgQW5kZXJzb24gPGRpYW5kZXJzQGNocm9taXVtLm9yZz4gDQpTZW50OiBNb25kYXks
IERlY2VtYmVyIDEzLCAyMDIxIDk6MjIgUE0NClRvOiBTYWppZGEgQmhhbnUgKFRlbXApIChRVUlD
KSA8cXVpY19jX3NiaGFudUBxdWljaW5jLmNvbT4NCkNjOiB0dWRvci5hbWJhcnVzQG1pY3JvY2hp
cC5jb207IG1pY2hhZWxAd2FsbGUuY2M7IHAueWFkYXZAdGkuY29tOyBtaXF1ZWwucmF5bmFsQGJv
b3RsaW4uY29tOyByaWNoYXJkQG5vZC5hdDsgdmlnbmVzaHJAdGkuY29tOyBsaW51eC1tdGRAbGlz
dHMuaW5mcmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgc3R1bW1hbGFA
Y29kZWF1cm9yYS5vcmc7IHZiYWRpZ2FuQGNvZGVhdXJvcmEub3JnOyBSYW0gUHJha2FzaCBHdXB0
YSAoUVVJQykgPHF1aWNfcmFtcHJha2FAcXVpY2luYy5jb20+OyBQcmFkZWVwIFByYWdhbGxhcGF0
aSAoUVVJQykgPHF1aWNfcHJhZ2FsbGFAcXVpY2luYy5jb20+OyBzYXJ0Z2FyZ0Bjb2RlYXVyb3Jh
Lm9yZw0KU3ViamVjdDogUmU6IFtQQVRDSCBWMl0gbXRkOiBzcGktbm9yOiB3aW5ib25kOiBBZGQg
c3VwcG9ydCBmb3Igd2luYm9uZCBjaGlwDQoNCldBUk5JTkc6IFRoaXMgZW1haWwgb3JpZ2luYXRl
ZCBmcm9tIG91dHNpZGUgb2YgUXVhbGNvbW0uIFBsZWFzZSBiZSB3YXJ5IG9mIGFueSBsaW5rcyBv
ciBhdHRhY2htZW50cywgYW5kIGRvIG5vdCBlbmFibGUgbWFjcm9zLg0KDQpIaSwNCg0KT24gV2Vk
LCBEZWMgMSwgMjAyMSBhdCAxMDozOCBQTSBTaGFpayBTYWppZGEgQmhhbnUgPHF1aWNfY19zYmhh
bnVAcXVpY2luYy5jb20+IHdyb3RlOg0KPg0KPiBBZGQgc3VwcG9ydCBmb3Igd2luYm9uZCBXMjVR
NTEyTlctSU0gY2hpcC4NCj4NCj4gU2lnbmVkLW9mZi1ieTogU2hhaWsgU2FqaWRhIEJoYW51IDxx
dWljX2Nfc2JoYW51QHF1aWNpbmMuY29tPg0KPiAtLS0NCj4gQ2hhbmdlcyBzaW5jZSBWMToNCj4g
ICAgICAgICBBZGRlZCBzcGFjZSBiZWZvcmUgbmFtZSBvZiB0aGUgZmxhc2ggcGFydCBhcyBzdWdn
ZXN0ZWQgYnkgRG91Zy4NCg0KV2hlbiBzb21lb25lIGNvbW1lbnRzIG9uIFYxLCBpdCdzIG5pY2Ug
dG8gQ0MgdGhlbSBvbiBWMi4gOy0pDQoNCj4gLS0tDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL3dp
bmJvbmQuYyB8IDMgKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+DQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL210ZC9zcGktbm9yL3dpbmJvbmQuYyANCj4gYi9kcml2ZXJz
L210ZC9zcGktbm9yL3dpbmJvbmQuYyBpbmRleCA5NjU3M2Y2Li40NGYxOWYyIDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL3dpbmJvbmQuYw0KPiArKysgYi9kcml2ZXJzL210ZC9z
cGktbm9yL3dpbmJvbmQuYw0KPiBAQCAtMTAwLDYgKzEwMCw5IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgZmxhc2hfaW5mbyB3aW5ib25kX3BhcnRzW10gPSB7DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgU0VDVF80SyB8IFNQSV9OT1JfRFVBTF9SRUFEIHwgU1BJX05PUl9RVUFEX1JFQUQp
IH0sDQo+ICAgICAgICAgeyAidzI1bTUxMmp2IiwgSU5GTygweGVmNzExOSwgMCwgNjQgKiAxMDI0
LCAxMDI0LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU0VDVF80SyB8IFNQSV9OT1Jf
UVVBRF9SRUFEIHwgDQo+IFNQSV9OT1JfRFVBTF9SRUFEKSB9LA0KPiArICAgICAgIHsgIncyNXE1
MTJudyIsIElORk8oMHhlZjgwMjAsIDAsIDY0ICogMTAyNCwgMTAyNCwNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgU0VDVF80SyB8IFNQSV9OT1JfRFVBTF9SRUFEIHwgU1BJX05PUl9RVUFE
X1JFQUQgfA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICBTUElfTk9SX0hBU19MT0NLIHwg
U1BJX05PUl9IQVNfVEIpIH0sDQoNCkkgaGFkIGEgcXVpY2sgbG9vay4gVGhvdWdoIEknbSBubyBl
eHBlcnQgb24gdGhpcyBkcml2ZXIsIEkgYmVsaWV2ZSB0aGF0IHRoZSBuYW1lIHNob3VsZCBiZSAi
dzI1cTUxMm53bSIsIG5vdCAidzI1cTUxMm53IiAoeW91IG5lZWQgYW4gIm0iDQphdCB0aGUgZW5k
KS4gRXZpZGVuY2U6DQoNClRoZSBXaW5ib25kIGRvYyBbMV0gc2hvd3M6DQoNClcyNVE1MTJOVy1J
TSBpcyAweGVmODAyMA0KVzI1UTUxMk5XLUlRL0lOIGlzIDB4ZWY2MDIwDQoNCkNvbXBhcmluZyB0
byBhIGRpZmZlcmVudCBkYXRhc2hlZXQgWzJdLCBJIHNlZSB0aGF0Og0KDQpXMjVRMjU2SlctSU0g
aXMgMHhlZjgwMTkNClcyNVEyNTZKVyBpcyAweGVmNjAxOQ0KDQpTaW5jZSAiVzI1UTI1NkpXLUlN
IiBpcyBpbiBjb2RlIGFzICJ3MjVxMjU2andtIiBpdCBpbXBsaWVzIHRvIG1lIHRoYXQgZm9yIHRo
ZSAiLUlNIiBzdWZmaXggeW91IGp1c3QgYWRkIGEgIm0iIHRvIHRoZSBlbmQgb2YgdGhlIG5hbWUu
DQoNClsxXSBodHRwczovL3d3dy53aW5ib25kLmNvbS9yZXNvdXJjZS1maWxlcy9XMjVRNTEyTlcl
MjBSZXZCJTIwMDcxOTIwMjEucGRmDQpbMl0gaHR0cHM6Ly93d3cud2luYm9uZC5jb20vcmVzb3Vy
Y2UtZmlsZXMvVzI1UTI1NkpXJTIwU1BJJTIwUmV2SiUyMDAzMTAyMDIxJTIwUGx1cy5wZGYNCg0K
QWZ0ZXIgY2hhbmdpbmcgdGhlIG5hbWUsIGZlZWwgZnJlZSB0byBhZGQgbXkgUmV2aWV3ZWQtYnkg
KGFuZCBwbGVhc2UgQ0MgbWUgb24gdjMpLg0KDQotRG91Zw0K
