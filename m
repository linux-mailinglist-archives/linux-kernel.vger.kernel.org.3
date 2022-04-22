Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 763E150B718
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 14:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447265AbiDVMTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 08:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237402AbiDVMTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 08:19:19 -0400
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F4945521B
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 05:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1650629787; x=1682165787;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=zcyNsiYzrzPwOWVr7GnMwQu5U7CP82toT+6DDjYVma8=;
  b=QDgPzln5Chfg1PhCW5A9JP6nvfcQWT+GcuVmQiPqZjoQtTeuAQLPNt0O
   lIuG0C6bPJz1fMJLuqzI3F6/yrjtwhBzm5z4rI0v8Ebuo0YOtsQsRqyDI
   T70sjkynqY922O7U8eT5S3zMZW1CPQ8Ydx7/eVFTsQp+KPTuoW7IkmiY9
   8PFo2pV3wh1csya3FKv2nA267FOLQkB9JUbFS0fdIe+LRaGOX/5sZQBvc
   5YYoRl3/HkA4Doojo2SkCmm8tecLBWwCY+7Yx+qszzLpb8oGsYYCS5PZM
   9uasb/V2LjMIjrwbMVQs9TiukLaTrOkmas5747KpnLFZ17+kRcZICyP2u
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="54453808"
X-IronPort-AV: E=Sophos;i="5.90,281,1643641200"; 
   d="scan'208";a="54453808"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 21:16:22 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DDhuTqY2/XMdr93gEQUH0lCzOEtG1ggWerArt0lMSmRTYMSrwPDt2nxy8cPklitHeh+gyl6wHsa1p7a3CxzX25oSlJS6pFdjFc73n3jIOs04WHYS6Id8csScfd73kdjNjbEk5pgFrtYYrotJhbHglzRoo+lBHiBX8rieWXJf6QOwhnenBUjMWIjysjl8LJVUpULqrsQX6WOkFiwhgKAYI7X1ShbWe8MCaUQgxmDAUoanBvNDCeprEhPon8GeoYlYk4y38mHIgu8xK6nxIfA4+ZphETVfRdSH35TuBnOnV9z5MoaJfNb6Ih87oIQDB53lRRfkcpmTjAlc1Zbf2FOzLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcyNsiYzrzPwOWVr7GnMwQu5U7CP82toT+6DDjYVma8=;
 b=fndCsdeq1BOKwEdZ8zSw4/IYWdM5hzIjRIdv5e73L5kH8lmaNIsD3qQth/iXmWyRZG4MmVc01I2aqFjPn4a86zQe9ZPalnC7sc94wUMqjVfCdP1qLwOslWdHfkpRIV6IAmYPZOUMB9aqQmFXjud6vfzsgqfk2oc4yWrt1P7ep/mxC8y6PCEjJ6lgb97Ar5YbOcVeo9glnrcEnOE5iMpjxSH5M9BMa3zs7tFFmZj80wuo5hn01ZZ53O1hdfShYg1H4ymQgr3K1q7LKOt0MgaaKtpucfE03a7sLh7IEPQXo5AY6QU/E3y/9NmoluRXP+vQH+587+WvpBAaJGQYppLEoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcyNsiYzrzPwOWVr7GnMwQu5U7CP82toT+6DDjYVma8=;
 b=H3oAftZFhc5KLadiIZnykooa/ekNBAFHBJn/4f8uwYITP6stgyoYYzVDKekeThRzMki3dtt051VSmhqB+YJR4zkctj9DJm22X/4ZdVGUKNc16UalQEIayGRht7zamaG4PCR5gHAIaaW/WyaFv2T/ifN+qrPewnqw5/grpcX2fak=
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com (2603:1096:603:25::17)
 by OS0PR01MB5907.jpnprd01.prod.outlook.com (2603:1096:604:bd::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 22 Apr
 2022 12:16:18 +0000
Received: from OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::382e:99b:f0f9:b18c]) by OSBPR01MB2037.jpnprd01.prod.outlook.com
 ([fe80::382e:99b:f0f9:b18c%6]) with mapi id 15.20.5186.015; Fri, 22 Apr 2022
 12:16:18 +0000
From:   "tarumizu.kohei@fujitsu.com" <tarumizu.kohei@fujitsu.com>
To:     'Thomas Gleixner' <tglx@linutronix.de>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "fenghua.yu@intel.com" <fenghua.yu@intel.com>,
        "reinette.chatre@intel.com" <reinette.chatre@intel.com>
Subject: RE: [PATCH v3 7/9] x86: Add hardware prefetch control support for x86
Thread-Topic: [PATCH v3 7/9] x86: Add hardware prefetch control support for
 x86
Thread-Index: AQHYVGMS5ZVzEyeIOE2a6l/c0xocPaz5YsWAgAJ4j6A=
Date:   Fri, 22 Apr 2022 12:16:18 +0000
Message-ID: <OSBPR01MB2037FFD9250ED3E075E2778080F79@OSBPR01MB2037.jpnprd01.prod.outlook.com>
References: <20220420030223.689259-1-tarumizu.kohei@fujitsu.com>
 <20220420030223.689259-8-tarumizu.kohei@fujitsu.com> <87czhbtmpu.ffs@tglx>
In-Reply-To: <87czhbtmpu.ffs@tglx>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 787dcd37-f4ee-41c1-7135-08da2459e7a1
x-ms-traffictypediagnostic: OS0PR01MB5907:EE_
x-microsoft-antispam-prvs: <OS0PR01MB5907C2A897033D2EFE7DA39580F79@OS0PR01MB5907.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cpnapM9dzKWB6IlIbYkOnnnEepEEjFB2s2gK5LOvK+qlM/RJSH4NjBOfJHdZwOIyWXCEdu4vZVuEls0b899cRy9lDgnVNK3jLM8DzMyNTxUKS8qa+9AkzOGG5QEaKh2QkecO8kroXr8aXxkxCRp38B4ehccLumuDKsYhZX+4FbxyvbSV1e2+WxECleUdTxFL/ArtbCzibhfEBatOApRHGC49cz4Yug1Hay15TNq+BPI73OAyJzktQOvHK3iFm8UuG9KSbZ6M8BGn+gcZF+4+U6WaCpQCXK7V3ufbJoLBq/XA6ROG48UCxNtf1YNgJFGNfx/pnG0t6SfAnoZvMUJ33V9U/gQ54dPYig2dNc8Evw5uHSWdqkWgOUIS2vTY9PQoTJplw2yckG6rUhSwBgACCYbc5ZRpqqqcGmlMrX0psUfQumoh+UR9lHwd0F/LXSXW8HUi2q+/wT+U098/qckleC8mS9kzUR3vDS1jSuhSG6UAJ5F1tbcn5UuJRKnl/G8rBYR2VsFM37yy3yaXawIbfHgVTfi2Pru7ez3203fHYX6FuwfgBPHWfhQw1oz6mX2n26WGNfOV6JGq/74MIX2QbV7bYBpk6O+bUT8xX0O5AjReaaP2/y63jJWW57lwEgYLYIP0jabCFjn4oXAHTeyfqS919bBWykLhI1mZmyQAE/bDN06xOrnfO0nFmQecr0g0OVz7EmkGZqbDv4aWLvxlFdymIyTJgPUEBc3MWjIr3Zg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2037.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(85182001)(186003)(316002)(82960400001)(110136005)(38070700005)(921005)(122000001)(33656002)(8936002)(7416002)(7696005)(55016003)(38100700002)(6506007)(2906002)(52536014)(5660300002)(26005)(76116006)(66556008)(66476007)(66446008)(8676002)(64756008)(66946007)(9686003)(71200400001)(508600001)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?WlA2cHhONHJiRFAwanUvME42cjk3dllReDcwN1E0ZnhkMGtsSld1MWJO?=
 =?iso-2022-jp?B?eE9yZkY2bUxJcWJIeHhNbzM5blpZWnhmZUtWZkJiNXpjNVZmcnFRek9j?=
 =?iso-2022-jp?B?ajc1QkNPYy93eUZ2MXlGa0dGNGwreXJKb0dNTU41QXgxcHp1dW9mSnVX?=
 =?iso-2022-jp?B?d0M4amZkRkRtYVBFVXBMQ090YW1JdlNuZ2ZKdFhjY2xjNm5BamszWCtU?=
 =?iso-2022-jp?B?d0tBV0FIYVJRVG9rWGl4MWlmMExuYSs0aUdOdVBuQXRFQmR4SWtkUmxJ?=
 =?iso-2022-jp?B?dFVZYUNsek0zRjZoZXVpa2x1aW1YajhDVU15UjBidyt6VlFRNFp2RkVt?=
 =?iso-2022-jp?B?OCthQW5tNDFXRXJKR3lDd1owU0VLNkdUQ005ZzNiY05xUm0xakZMaEM3?=
 =?iso-2022-jp?B?N0d6ekdKZjJIaDFyc1FLTFZrcHBaSzZPbzNDTnZISUtkcmNOT1Y2RllP?=
 =?iso-2022-jp?B?MTdvZDlxRVU4dnVtUlNYbUhFU2t1OGsxUWdMZXJsNzhLbW16T2dOWlFP?=
 =?iso-2022-jp?B?US80dDlwV0VVM0xCSzFKTE1McFJZaWg0NUI0YXdCWm1uZjZ3OGtIcVpz?=
 =?iso-2022-jp?B?OVRubGFlYjFQOHkrN2hLb0FCT00xcXFrVzZKa0dPTGwvWkthSUgxRzR1?=
 =?iso-2022-jp?B?SmVJYXBvNkxyRk9YZExHd2wvblYzM01KdkVpdEZ0K25sTXp5YmRCcmQy?=
 =?iso-2022-jp?B?UVQ5MFBaUlBLSlR6bm9ydnNOTk8yTnhvSDRSUm1xTHJQWXMzeTdrcW0x?=
 =?iso-2022-jp?B?WDZDWWFOTGFaTXpPNUo3RG8rWHVJYkx5WlRIaHROWXJ1aGRZd0lPTVdn?=
 =?iso-2022-jp?B?RE9XRXNvUkhPbGFUWmZlbHdmZEE5NnJ4OExvRFByeDlEZzhnQUxTcGJh?=
 =?iso-2022-jp?B?bDJlK1VBOGdRaVJ5amJTVEw5SnVrZXNDdk1yU014QU9VSmZ6NTY0SDVB?=
 =?iso-2022-jp?B?MG1DLy9oS0MxZUYxME43eE55ODJVWDFWcDVkaTNFM2V1dENkSGZJVDdT?=
 =?iso-2022-jp?B?dkgzWmsxRFkwSm5DcThPSTlxeHd5NHJrS0FmL09vZUtkbSt4bVdXVndj?=
 =?iso-2022-jp?B?WHNBM0hYSEJ1dkVrVjd1aURWbndXQlpkcSsrMFZDQk1FWHQ1bUNEYzN4?=
 =?iso-2022-jp?B?OXNhd3E4U1hYNTZuQUxyRmE4T0xKS2V0VjdBbTM0azU3anM3VnI2YXdK?=
 =?iso-2022-jp?B?cDBLenViZlRyclZITTJXZHNwOTNiMGlRdVVQWGRLTExmd3RJYUtZeHJY?=
 =?iso-2022-jp?B?UEYyaU9wRzNyekoyUEVEc01objRzYXNkTHI1ek9PYm9vK0RpVDc5U0FR?=
 =?iso-2022-jp?B?YVBTRXhRYzNvWHRyVEVESTNUTHZCcExNcEw2NVVGb2pFdERWU1pmZlhV?=
 =?iso-2022-jp?B?ZXU3VGE5bG85cFc5NEduQVJBQm5BWi9KZGQzYVBLZ1U1YzM3Z0N3MWJa?=
 =?iso-2022-jp?B?Z0dZcjhRWVdhUFlVOUlUZGZqWWVBbDg3MEs3cTZpem02bDU1UlRLRlc3?=
 =?iso-2022-jp?B?RXZSWDMzbUJOclI3NkM1RnFuU2VmUFpwMmtvOE04bzN5Rko3V0FyNlVD?=
 =?iso-2022-jp?B?b0xiT1YxYkJEM3NKaGt1NkhPVkJ2VnRnUHpZQm5mbUtYS0hmYTdBU1RO?=
 =?iso-2022-jp?B?YmxKY1ArRUpXR04yVVcxNHZlOG1CS0RGcGZnbnB6ODV0WG4xcUNPRzRh?=
 =?iso-2022-jp?B?SXN2dWdCdkxXRWhyS1ZPeVRtZmpzbUYvMjBxVjRNa1RyNSttWmRKUWJy?=
 =?iso-2022-jp?B?OXdlMUhXTWZXcHRTdldMemorREFib1oyeHlKaTZ4Mndmek02WncycVEx?=
 =?iso-2022-jp?B?TlZqWWtDSWM1RHhMK0dSc1JzbHNObGF1Vnk1RXVWWGtIY1ZpazFWaVB3?=
 =?iso-2022-jp?B?bXNvRnlwYVhSOG80TFc1OU5wR2x6VmNXc1lQMSt1NDJ0RWxHelluTTFm?=
 =?iso-2022-jp?B?cVQ3QzV2bytQYWRybDUrVFZ1WkdaZEVTcUtITTVkR2pFMjdJODZFS3NG?=
 =?iso-2022-jp?B?ZlRKYkl3NEk5TXZXUUdwakxrTGJ2bFRvMmg3QTV5U0FjRzMvaTBhWW1X?=
 =?iso-2022-jp?B?RlV4RjlmOWJnclVzU0xkV1JudGx4c1VDaEl5d1JaM3NYTm53Z05jQ1pB?=
 =?iso-2022-jp?B?bTlCODZsUGY0bnF2aThjQ2NNcjVFUEhTZnNDN0NGY0Z5blpkOWlXTzEv?=
 =?iso-2022-jp?B?UTVBenFDNDd2bXd6cTRJMlRBTDU0TG5RY2JXSDB0akJ5U3VoVVBqR21P?=
 =?iso-2022-jp?B?OURCM2JWQVVmQ29rNTA1OHEvVDYzRVlEZ216eFQwbzI3aUwzZHVjd3NT?=
 =?iso-2022-jp?B?SDRPUEduTS84NEhscm5yemVzZTQxRkE0eTJIZzcrY1NzNklucGJkRitv?=
 =?iso-2022-jp?B?d1dXbGUraE1YOWVIUFhrYXA0UTdMaE1tblJYTEJ6dlVHQTBkeGN4OHYw?=
 =?iso-2022-jp?B?Yk56NC8zQnBLZnVOYU1hbG5sMzVobUU3SzYvL2N6UnczVkdxU3Myb1lh?=
 =?iso-2022-jp?B?TXlZWjZ5WDVnelAvYkJqcVVLdU91V3VLRUFBZHNGaFRncU9xdXJ0ZEpJ?=
 =?iso-2022-jp?B?VDJ2UEdTdz0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2037.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 787dcd37-f4ee-41c1-7135-08da2459e7a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 12:16:18.2996
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KRp8PGww4tsAT3YMqoYNM9j1zawJr5m07cZu1WusLx69bnyaho54Z5RyUBwgy1EGV6LCKoEPRn7HT55rScnS//rkaLGsNa87VuWiWeH65mc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB5907
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Prefetch control is supported on a lot of CPU models and all except Xeon =
PHI have
> the same MSR layout. ATOMs do not support L2_ACL and DCU_IP, but that's i=
t. So
> there is absolutely nothing broadwell specific here.
>=20
> Why do we need six explicit functions, which are pretty much copy and pas=
te?

There is no special reason for them. My design was not good.

> The only difference is the bit they operate on. It's just a matter of pro=
per wrapper
> structs.
>=20
> See? One show() and one store() function which operates directly at the a=
ttribute
> level and supports all known variants of bits in the control MSR. No magi=
c global
> constants, no visible management, no hardcoded type/level relations... Si=
mple
> and straight forward.
>=20
> All what the core code needs to do is to populate the attributes in the
> sys/.../cache/index$N/ directories when level and type matches.
>=20
> I'm pretty sure you can simplify the A64FX code in a very similar way.

Thank you for showing me a concrete example. The implementation image
is now clear. With this in mind, I would like to simplify the core,
x86 and A64FX codes.
