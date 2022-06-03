Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFAC53C29D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 04:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiFCCKu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 22:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbiFCCKs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 22:10:48 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2058.outbound.protection.outlook.com [40.107.113.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0E41C2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 19:10:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RaPkIUvGgmK95NKRkFGI0We5mGGBUH2w8H1K+jFnmC3XRVa3XXi1/mPRIXx24pp9eDzO1zkGzEMqNi5BCpISXifiOaocobJYgqzntYT8jz6OaCuxUaAZYOTtgMwifcCbKFBvvftldk6wBxtglM/h7OYw4taxdP90hqoiE7Bt2udjv0g8Sdo8U6IueDW4ELBR0pwLt/6rbApdCRU6XQ8BekM6dwtctzbyoeHlCAeW4XTJ/AyBHk/WlliNc8bR0xDF/xpll9f5IjfBZloIecLxWRwlqA0OE6ss8XIysODbzrP1v5jZ17KZrEa23eSL3MtxSuvYOm2kKuJ8BKZwxHf9Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kPJi7FQIxp3n2EpAjRD4Td06uzNh1mZAhrK5DMstYY=;
 b=WkB/V8MPmNr37kbE25adnkmTRY4ZSoMLP73oQtclmnPVlsbibsOJeN3x0hQbasBRKX0/gNnjT/4GShPt3rFEofxbz0OmHulneIS5TznBcrApfRRYdv5zEGuQERVLg49q4HDnn83NGycoUS8i1kwQt+ycbfbCCGCtFjvI79q5n01yzxz+GE42ig5Ijt+JK3voxaJgWCWQwsffIwAkB55nXfLyl19zdvJPUExqJoKuj4uAm3PcYnr1ll26FqyeCquG43QXcL2uZgzGp077ONjwl88rWgHuxDJ+FkhD9bssMLfqe7BYXN7GC4TbrkQYbr9dDdAPlx704cANRtinklDAEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kPJi7FQIxp3n2EpAjRD4Td06uzNh1mZAhrK5DMstYY=;
 b=AZTp3bvitaBxpLQCNZeYFqG3qHqPYWanLcKUc/YLfQ4NavOIKa0WqbN5X4LPgoBB3oSHkybUn+qy2g5jUR7ZTeEZ1at8sHonzacgsciCT2wvQwYX88/m/vRN3yw+thnB22ZVhcdHN70jmXMvD3SA1T9FtIEugMQTVbmR8CrnDJQ=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSZPR01MB7149.jpnprd01.prod.outlook.com (2603:1096:604:137::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Fri, 3 Jun
 2022 02:10:43 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::246b:9355:73ad:b995]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::246b:9355:73ad:b995%2]) with mapi id 15.20.5314.013; Fri, 3 Jun 2022
 02:10:43 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     kernel test robot <lkp@intel.com>
CC:     "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: [akpm-mm:mm-unstable 154/159] mm/memory-failure.c:1538:9: error:
 implicit declaration of function 'hugetlb_set_page_hwpoison'
Thread-Topic: [akpm-mm:mm-unstable 154/159] mm/memory-failure.c:1538:9: error:
 implicit declaration of function 'hugetlb_set_page_hwpoison'
Thread-Index: AQHYduDaxY/J3Go+2EmFtksz+v1Jt6088H8A
Date:   Fri, 3 Jun 2022 02:10:43 +0000
Message-ID: <20220603021042.GA1205503@hori.linux.bs1.fc.nec.co.jp>
References: <202206030829.0eS2kZa0-lkp@intel.com>
In-Reply-To: <202206030829.0eS2kZa0-lkp@intel.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6500c28d-ec78-48a0-a72e-08da450643c2
x-ms-traffictypediagnostic: OSZPR01MB7149:EE_
x-microsoft-antispam-prvs: <OSZPR01MB7149FD8DEB9AE0D1C8E24B2AE7A19@OSZPR01MB7149.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eWCipLdfQtVA9QcewoZ6mKFud0ffHjEQwSC1+0wR3EMuWVx/3whMZ0BcRS0/ad+C9vnr37wHcTd18ey7jmdjGt61GojveCgyyJJcEieSm6WrHCgkPvsKswvHyBLuk8LHLPRzKdGzGXoI+834K21q61kmSfrIgyQIkY9bWTrWdn3POoZsd3IYRNOCaR3zN//MxmmckjAfNVurzzz3eunTqCIfdG2jsqdZNiOUmjDI+khl2LlBaT9F/Qsy3A14XOUJ545fumqQ9OA+WVdd3utrqjArRiClxfEtuTa1w9sb8KMj4sPhZvXmuIVVJkFai3ICsGfH2NSe2VD0QU2l0fjb2wmkpuY26w6IXKElaf2lABIoC4EoAxI9zAxKdU5kida7WxGByilj06Wg6oOs/v0cfHGCcjLI5vG7zUaISiDAhp+Y/rJt0cGK+hxafiULGKW+suiAIs/bgqlsnLrl7QLCvizWfdfSZNNxRnnP8TjJqWjjsu8+xC/6PrbiX6v1t26+EWU3Nax9pFgCPoMmytlb9LwkFgbmT5DBCUgBFQcqC/HV/e0VaIOb7a1k4AjMMybpoWzT0QMlontPLaz8Ga1rZ1Z4okhb9w4Z8zS8vW0emHsnMarBrTEI5DHPXt3krKDyhvFmPttpl1Vv90b7B5V4UsqmWZOyUtuHE5cULowEuzFpRhbfzbVO7iW9SdiWnNyB2BGS+ynrCO7jFVZmO9mq9zv1dDcoMu+c7mVByI/DejbfwEIJwidgEbvw7S67eIcmL1LdB952xYl/AS2yg3lV0bxM1/DqkTQkRsUL80Vev6ZHsGx4fN9RXJBoRjDFgdMxVQhJP8eFNbiTkkxAS2eJyQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(6506007)(55236004)(1076003)(86362001)(33656002)(2906002)(82960400001)(85182001)(316002)(8676002)(66556008)(71200400001)(66446008)(66476007)(64756008)(66946007)(76116006)(6916009)(54906003)(8936002)(6486002)(966005)(508600001)(4326008)(38100700002)(122000001)(9686003)(6512007)(83380400001)(38070700005)(26005)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aThVdkRXOWtpQmh4MTVCUG04bWhCdjh3V2h1SE1McGtVb2h2bkQxbTdxTW1z?=
 =?utf-8?B?ejVXK014VGpJTitVUU1WQWxmS1l3eEJPYVVaRzdaajcwTFA1Z1RSdFVOdlNr?=
 =?utf-8?B?ZG05WjRpYXVIRnRFSi9JcnloL1hLbUhCUXpiMDkxT3h0aUNIRmorY1B4T0Nz?=
 =?utf-8?B?RkhnQzNkeW0yNjVQZUVoL21rY21nWWdEWGpUSGdpdTNjR2RVM2hMM3p1VGZD?=
 =?utf-8?B?ZFR2dnhod2xyRnpkRjhxOGkzSUExaERZSXgrVWlwUTVNWktVWGhZK2E0VktG?=
 =?utf-8?B?NUdqR3hTcXlPSjZ2ZkQxb1AyWFk3V05CcFRCcnJEejdOUlFualpLUitVOTh5?=
 =?utf-8?B?UGdBNFhveWRxY3RBbEp6c2dXcGMyK3dPUGExdGZoMlZqOFpwNlZOLzJ1YXdz?=
 =?utf-8?B?SHlPaFpheEdpYVB0Zko2T1VSNktsS3JWbldLZG00ZUZuK0lhU0t0NFRJRDRk?=
 =?utf-8?B?Sk9WaTVZRnBLMEdybEpSN2xNWlJMU0dxRlpmU1JEMnExQjQrd1d1SjRxTFFE?=
 =?utf-8?B?SE9Da1duM2loYVdISVpkcjFVenhYem1nUis3QmlCVkJrYmlvVm9vWmVzZmd3?=
 =?utf-8?B?SW1hblRHTGJWbW82MTUyRFMyUnU5VjBNcmxLcHcxSFZxZXoyeXY0ZFNmLytr?=
 =?utf-8?B?MmdVWXZ1Lzc2Wk1ZRVVTWXNSbUlXODZ0VEhCQU1wQWxta1hLREtDTDJzMHpZ?=
 =?utf-8?B?STA1eGRja1VUNmdwcUVaN3l5NGZ3bGRMMDFBb0g0QUFVWTY5a1ZkRmtXTHpT?=
 =?utf-8?B?RWM5S1RLdEFiSmlCNEREczBXaEV2dXRDL1MrazBTRTdzK2J0cUxZd1NwOUpK?=
 =?utf-8?B?VjJ4NXgwRkc0c1FhS3loZmxob3dtVnFldzdQbXNOa0xRcGdpcnNBVEp2U3VF?=
 =?utf-8?B?WmYyWmVoUHRJemM0R0VNb0N0YXlaQVpVVmZRSEkvbS83OWRUNWJPMVNNYno5?=
 =?utf-8?B?SEJIQ0l0Y2JQbjdVRmJzVUlETzVPZEQ1TDdXUEZGRk55VHc4WUFqQ1RUd0ZM?=
 =?utf-8?B?ajg4N3VOY091eGpSVTFwWEExMXFaeFdITFBmeGlHQmcvNm9MV0xpMDVCazN4?=
 =?utf-8?B?SGVRZmNPcXpCa1JGRExTVEQzZ29tRmkveDNuMEVPdklDakdVS2RsVlNVQkkr?=
 =?utf-8?B?MjVNeWVGcXRuOGNrSjhVWFpVcmg5bzJJcE8vNTEzNDJOUFMrQUxXbFZGait2?=
 =?utf-8?B?UHFCWXpabHpGbFdwUFRDdVVJTWhUcUJpWlpZMGJ4YVYwSUYzTHlrVjFiRFJW?=
 =?utf-8?B?N2x6cmlUNzNZams1QjF1QzYvSE5RNU5JUEx6Q1plK2RoRnRQaitaWmNNeEdU?=
 =?utf-8?B?b1ZRcVRoOXREbGlBOWMwOWdiRDNLRTd6c29EWkl3NXFMcDhPVk5aRlZaRUVa?=
 =?utf-8?B?eHljWmlUeU9yRERWbG14VEtOOVZHUlNCSGFnamdNSi9najhCVGx2UW5YZTVi?=
 =?utf-8?B?Y0Y1dTRIOHRRT3hHelh6ajRRaS9WSDJsS0VxUktxN0p5eWhnQzRQV2I3SkRB?=
 =?utf-8?B?TndBbGE3Wm5JMWIrMmZVMHdHYW9yWjV1Wm9yNVpjUk1pZGlnZlp1M2dtQVR3?=
 =?utf-8?B?VmdsNFJIMWdSWmJNZFk1Y09mTFR5aU82Tnp1ZDJJdmVEZm1VMkxwUytIVXJH?=
 =?utf-8?B?UUh4RUpvWkRFc0J3a2ZZMFNraVBOQzk0bng4ZFA1L01jZU1uOGdwWGhvUmxD?=
 =?utf-8?B?NUR5U01XeFdoSHk1MDd2OUxHR2JXZlN3QWdiZHcrbWdOOFpla0MzM3NodTJP?=
 =?utf-8?B?L3VOdXM4NEpBUm94bUlYMGpVVFZDZDNWa2pFY2U5TEZmUUN0ZGw2TEcxVjNo?=
 =?utf-8?B?aVZESDI5QVNuNVVXSndzYXMwSC9qTnBvTDRqQURRQ0VsalM5MEk0N3RWN3Yx?=
 =?utf-8?B?SCtKSEJ3dG44YTlwLzJIMU5tekI1bDBUQ2JmT0hhdXhCVVh1YzJFWlYweUl1?=
 =?utf-8?B?WlJ2ako2NjErZmFIM0FmSGdFNmNDS2tvWVI4LytMVkJ0SVFvaHo5Y1M3SU51?=
 =?utf-8?B?RDZYQVJTTVIxa0QzTGZkZG55c05aK0JjQ1ZTekQrUndKV0FmQ29BTnNaVFFJ?=
 =?utf-8?B?R2laNDdJTEx6S08yRWVVaDRWcHVTM0NjT3lMWE11R25GRVpFNDJ6UGFoaHJu?=
 =?utf-8?B?TFduVEpUTjcxTExoakdScnlGcDd4dDR2b0E2ZjJRandrSjFFeVQvaWM5Qzdm?=
 =?utf-8?B?WHVUb2tSTEwvTFVteHVKRkF4akxPWTlyVVBrWkUvSG1WZ0owTUR5NnNzY21R?=
 =?utf-8?B?T0daM3JoWUZ1eVVDYUc1aGQrbzRLelBUSVBteW1oeGFKUmdyVm5tNXZZR2Va?=
 =?utf-8?B?YTlZaG1EYlZjR25kUi9XYThHYlN2WlZhWithdmRXR1FiMUQyZTBjZi9qMGR5?=
 =?utf-8?Q?nnTg3KQTRGzCzmAI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70CD14AA0A1E2E4F83671A7D95FC9271@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6500c28d-ec78-48a0-a72e-08da450643c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jun 2022 02:10:43.4984
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9o8JC5yIU22SHDCZBJk1u5SZRi00RIQGVOV9byzZ74Vrxg3m0yNWHzIDMJzLOaI5o1BSuqIZlrwSX24F8VilLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZPR01MB7149
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBKdW4gMDMsIDIwMjIgYXQgMDg6Mjc6NTBBTSArMDgwMCwga2VybmVsIHRlc3Qgcm9i
b3Qgd3JvdGU6DQo+IHRyZWU6ICAgaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4
L2tlcm5lbC9naXQvYWtwbS9tbS5naXQgbW0tdW5zdGFibGUNCj4gaGVhZDogICAxYmRmNDRkYmM5
NjZlMzFjNjM1MTk5ZDQxM2VlMDY0YTdkMzIwODQ0DQo+IGNvbW1pdDogZDRlZGYzOGFiOTUzOTdm
MzJhZTAxNzg0OGRlZWViM2I2ZDJjNWJiNyBbMTU0LzE1OV0gbW0sIGh3cG9pc29uLCBodWdldGxi
OiBpbnRyb2R1Y2UgU1VCUEFHRV9JTkRFWF9IV1BPSVNPTiB0byBzYXZlIHJhdyBlcnJvciBwYWdl
DQo+IGNvbmZpZzogeDg2XzY0LWtleGVjIChodHRwczovL2Rvd25sb2FkLjAxLm9yZy8wZGF5LWNp
L2FyY2hpdmUvMjAyMjA2MDMvMjAyMjA2MDMwODI5LjBlUzJrWmEwLWxrcEBpbnRlbC5jb20vY29u
ZmlnKQ0KPiBjb21waWxlcjogZ2NjLTExIChEZWJpYW4gMTEuMy4wLTEpIDExLjMuMA0KPiByZXBy
b2R1Y2UgKHRoaXMgaXMgYSBXPTEgYnVpbGQpOg0KPiAgICAgICAgICMgaHR0cHM6Ly9naXQua2Vy
bmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvYWtwbS9tbS5naXQvY29tbWl0Lz9pZD1k
NGVkZjM4YWI5NTM5N2YzMmFlMDE3ODQ4ZGVlZWIzYjZkMmM1YmI3DQo+ICAgICAgICAgZ2l0IHJl
bW90ZSBhZGQgYWtwbS1tbSBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2Vy
bmVsL2dpdC9ha3BtL21tLmdpdA0KPiAgICAgICAgIGdpdCBmZXRjaCAtLW5vLXRhZ3MgYWtwbS1t
bSBtbS11bnN0YWJsZQ0KPiAgICAgICAgIGdpdCBjaGVja291dCBkNGVkZjM4YWI5NTM5N2YzMmFl
MDE3ODQ4ZGVlZWIzYjZkMmM1YmI3DQo+ICAgICAgICAgIyBzYXZlIHRoZSBjb25maWcgZmlsZQ0K
PiAgICAgICAgIG1rZGlyIGJ1aWxkX2RpciAmJiBjcCBjb25maWcgYnVpbGRfZGlyLy5jb25maWcN
Cj4gICAgICAgICBtYWtlIFc9MSBPPWJ1aWxkX2RpciBBUkNIPXg4Nl82NCBTSEVMTD0vYmluL2Jh
c2gNCj4gDQo+IElmIHlvdSBmaXggdGhlIGlzc3VlLCBraW5kbHkgYWRkIGZvbGxvd2luZyB0YWcg
d2hlcmUgYXBwbGljYWJsZQ0KPiBSZXBvcnRlZC1ieToga2VybmVsIHRlc3Qgcm9ib3QgPGxrcEBp
bnRlbC5jb20+DQoNClRoYW5rIHlvdSENCg0KPiANCj4gQWxsIGVycm9ycyAobmV3IG9uZXMgcHJl
Zml4ZWQgYnkgPj4pOg0KPiANCj4gICAgbW0vbWVtb3J5LWZhaWx1cmUuYzogSW4gZnVuY3Rpb24g
J19fZ2V0X2h1Z2VfcGFnZV9mb3JfaHdwb2lzb24nOg0KPiA+PiBtbS9tZW1vcnktZmFpbHVyZS5j
OjE1Mzg6OTogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uICdodWdldGxi
X3NldF9wYWdlX2h3cG9pc29uJyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJhdGlv
bl0NCj4gICAgIDE1MzggfCAgICAgICAgIGh1Z2V0bGJfc2V0X3BhZ2VfaHdwb2lzb24oaGVhZCwg
cGFnZSk7DQo+ICAgICAgICAgIHwgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+DQo+
ICAgIGNjMTogc29tZSB3YXJuaW5ncyBiZWluZyB0cmVhdGVkIGFzIGVycm9ycw0KDQpfX2dldF9o
dWdlX3BhZ2VfZm9yX2h3cG9pc29uKCkgaXMgbm90IG5lZWRlZCB3aGVuIENPTkZJR19IVUdFVExC
X1BBR0UgaXMgbiwNCnNvIGV4dGVuZGluZyAiI2lmZGVmIENPTkZJR19IVUdFVExCX1BBRyIgdG8g
Y292ZXIgX19nZXRfaHVnZV9wYWdlX2Zvcl9od3BvaXNvbigpDQp3b3VsZCBiZSBhIHNpbXBsZSBy
ZXNvbHV0aW9uLg0KDQoNCmRpZmYgLS1naXQgYS9tbS9tZW1vcnktZmFpbHVyZS5jIGIvbW0vbWVt
b3J5LWZhaWx1cmUuYw0KaW5kZXggY2VkMDMzYTk5ZTE5Li4zMWQ3ZWZmMzVhY2YgMTAwNjQ0DQot
LS0gYS9tbS9tZW1vcnktZmFpbHVyZS5jDQorKysgYi9tbS9tZW1vcnktZmFpbHVyZS5jDQpAQCAt
MTUwMSw2ICsxNTAxLDcgQEAgc3RhdGljIGludCB0cnlfdG9fc3BsaXRfdGhwX3BhZ2Uoc3RydWN0
IHBhZ2UgKnBhZ2UsIGNvbnN0IGNoYXIgKm1zZykNCiAJcmV0dXJuIDA7DQogfQ0KIA0KKyNpZmRl
ZiBDT05GSUdfSFVHRVRMQl9QQUdFDQogLyoNCiAgKiBDYWxsZWQgZnJvbSBodWdldGxiIGNvZGUg
d2l0aCBodWdldGxiX2xvY2sgaGVsZC4NCiAgKg0KQEAgLTE1NTAsNyArMTU1MSw2IEBAIGludCBf
X2dldF9odWdlX3BhZ2VfZm9yX2h3cG9pc29uKHVuc2lnbmVkIGxvbmcgcGZuLCBpbnQgZmxhZ3Mp
DQogCXJldHVybiByZXQ7DQogfQ0KIA0KLSNpZmRlZiBDT05GSUdfSFVHRVRMQl9QQUdFDQogLyoN
CiAgKiBUYWtpbmcgcmVmY291bnQgb2YgaHVnZXRsYiBwYWdlcyBuZWVkcyBleHRyYSBjYXJlIGFi
b3V0IHJhY2UgY29uZGl0aW9ucw0KICAqIHdpdGggYmFzaWMgb3BlcmF0aW9ucyBsaWtlIGh1Z2Vw
YWdlIGFsbG9jYXRpb24vZnJlZS9kZW1vdGlvbi4NCg0KVGhhbmtzLA0KTmFveWEgSG9yaWd1Y2hp
