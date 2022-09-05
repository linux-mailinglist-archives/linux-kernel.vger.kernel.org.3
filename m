Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A0B5AC9BF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 07:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231744AbiIEFZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 01:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbiIEFYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 01:24:55 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2064.outbound.protection.outlook.com [40.107.114.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF532175A3
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 22:24:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7Ap2en2kTXB4ETnWEISPykg4sJNAS1MU3PiVNz3cTENn0tVjA8h/9YwqYVZe+UozSDo0py90q5qhwNktYSdvda+MdEc59W5dUVzPhTjP2UT8IXQQt/uWA+qOUkKDsX3Sh3cftaFmnLlBieLz7hUoeDIjJrTr2YNYFdl0GKD16af3fwXlbQyqSfcJJfv2AIQLduCTup/rTnXbd1RA2vv3sZ9xjd9i/XdFeRdpaYnE2FOC5rhXhbYBNQmB4iueWfngWPJ4m1Rcnw1piZdVobtzOT8/ZgGDoE3s0E9kWJaMyvdlo8pc793umHCcp9qttkXA9SxRwaGYnKqP0fpvs8maw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mANiR048t2fi4YF+w90TWNCeBRG9H/jp3xfzykv2/Q8=;
 b=QKj+6nBDLkDOZQoCPLF3PYDfZjeMWiAdD6wekHEZU2g4hGdg9D4cYpV5Wibstkb3LwWyBMkCjmzdHkkc5r58M12mjp6zVdRKEiB7VPjttQNrms94f9rshM+LCAMA9321HLd5qvPVacqiv0AX7YB6ih/cKE0n1rbmzyXt/lJ85ZrrowHahZlt514yP4VUwDBX6HWsBMwS3y1ROqEvGf/r6BsopJL9wBfuec663GQFu8SX7O3taYtndGlrDNUpHCMf7xmE6yWPSX1mOh+ECU+N1xfT2SxB+Gg4mhgAEz2FM4RJbtUIoQdAxXcB/oQEC4RzZ+kaB0Ho72AQB0Zn8O4LGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mANiR048t2fi4YF+w90TWNCeBRG9H/jp3xfzykv2/Q8=;
 b=DKqmHggqvEhjQa+Kl/oLXyOsXQq/RgV+csnMMtUqCCro14WWlJm8865FX4E85HgtKz3fpwJGN3cPf2qmb1xOUX4qsfxBzRqCLaikYMksXpAszOnWlSizy5nQeMYyST2shB/yznc98hwLUEfdj50/Tnv/vODvOklibi1TQfEEJ0s=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYCPR01MB8551.jpnprd01.prod.outlook.com (2603:1096:400:150::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Mon, 5 Sep
 2022 05:24:52 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a%6]) with mapi id 15.20.5588.011; Mon, 5 Sep 2022
 05:24:51 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/6] mm, hwpoison: avoid unneeded page_mapped_in_vma()
 overhead in collect_procs_anon()
Thread-Topic: [PATCH 4/6] mm, hwpoison: avoid unneeded page_mapped_in_vma()
 overhead in collect_procs_anon()
Thread-Index: AQHYvG0pQ+Em7HpHdkmAQCZxpr6/1K3QVskA
Date:   Mon, 5 Sep 2022 05:24:51 +0000
Message-ID: <20220905052450.GD1355682@hori.linux.bs1.fc.nec.co.jp>
References: <20220830123604.25763-1-linmiaohe@huawei.com>
 <20220830123604.25763-5-linmiaohe@huawei.com>
In-Reply-To: <20220830123604.25763-5-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: da9825a0-2247-4378-ce55-08da8efef58e
x-ms-traffictypediagnostic: TYCPR01MB8551:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 40NpO3leuX8/F+KKjmuk7MpV+4mMERWete39FjCwF192J0WwVVZ/+sx4oMAZkamVWYAq0m55/rsFOf4+oiNt3m+o713plXxqp6nv716Kn8fa4hqTd2LoQyV0HR5FezEbtWttEQSaQAZkhTkF1zp9+dXwPFnBarbAoZur9MZhBxxIk+9hwymlsfb9L/rN2MIzJTQ8XY1gZUuqci4bML61iHOg/Rl8IoEbRYjArPveMo5OZXQVcPSX6au2+hP1q5e8hAZdyhSm2rRAm2COZtX2x1XNkVj1Md9ks8qYmfByFNsBfZQhdQI242Db6I7l5bqI0U3tvomU3boG9kezNmqF9331GqPtwmNW4W+E9J5lyPfUZamTTRKT4mG/CiznQdw0/N4Po7Aa/rFhBdrIyCVG8vVak2LCh9Q7UINAh348zaJlKFZ1zgf6Omrrwklt4I1rz3jl2K/I27bexmaC6+aRzd06Yxd46FT+kKgq+ioq/cmzpvYlRyYpBj4lH5eWlQ+DizpXLloeC31p5KLxHzF8IOnOERZIGUi1QXYNtwHTuQr3axpEe7g+jPz884RVZNBhUWdSNoCio52qCjuScG/1uls9PC7p7qoNi43UOGI9GqqYZvX9KREU+0zVnokoVFrfhSP9kEr1F59s2t2w2OG/ghhHrr2ySUCGVW4kl7/dzpLo6kSFlEMrrhdtZKzI1ePk8jMOPd8F5IASl8tuUKXMaXdd44RfoJS4P4RRSbEEvWShkaBGsXjrFmkMJYCT9Lk6TbTNzDndn+z8f2n8vXz2gw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(6512007)(8936002)(33656002)(5660300002)(26005)(9686003)(41300700001)(38100700002)(2906002)(66946007)(4744005)(6506007)(86362001)(55236004)(4326008)(186003)(122000001)(1076003)(82960400001)(71200400001)(478600001)(54906003)(38070700005)(6916009)(76116006)(66446008)(85182001)(64756008)(8676002)(316002)(66476007)(66556008)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WUdDTkFnaE8yWVkxWlZzK0VzSjYvOVhraE54ZFlaWHJadCsyRXBDTlR5bHFt?=
 =?utf-8?B?a1U4MGxMVnFhUm5nMUNpSXdvUWZJQXMvQWtuM0ZqMTBwTlgvZHpsV1lOZVF6?=
 =?utf-8?B?SG5WRis1MVVCRFFmcGJwbncwQmk2NTdSV01KWDhPdjFCTjhZRklsWm45aU1W?=
 =?utf-8?B?cjcwbGVzcEJnV3hQQ09HSlhPSHN4K0x4WVhVdWlQa1oyVUpqUjZYTVZJWDZj?=
 =?utf-8?B?Q2VtcDhMaklzb0ZyeWhCK29oa3RweTUvNjEvbFZXSEpORXY1TGpoL3JMeVR1?=
 =?utf-8?B?T0FjM0NvblMrSFRlWHFNOWdhQURWUXFBcFNCMzVZNk1HcmpqcDVySEhzZlR2?=
 =?utf-8?B?K2Nsc0QwY2hIRHJpOUlXUmdIWXM1SHZFUGp0ZlpoQ3E2VGcrZmw1T2hDODBO?=
 =?utf-8?B?Y01BK3pPT3RrdTlzTSt5bHpQeWxuSEcvZGdLZXpyTm5xMEtsRmdYcXh4d2Ry?=
 =?utf-8?B?ZlRiTGFwOWhNNE5rRHVCZlExdGF3T1I2ZWtQaUFJaE93VnYveG9LV2Q4bGVE?=
 =?utf-8?B?WXZqem5ZWFNzdWF5YXV0cFprU2NPQ3R1OGdTQTlKVk9EWGV2bFIzdHBydWcx?=
 =?utf-8?B?cUpjVHpwNWRTcFJvTU9IU2s4Sk1KbHlLVDJHZGl3d01EdE1kaWFweWJlOUpQ?=
 =?utf-8?B?UjRnZklRNHYyZ3pvU01tUXo5cDNRU1NaelJDVGZjTWtYVDA5eU0yV3pwSThQ?=
 =?utf-8?B?K1dtR0orbklkaWI0UGg1NE0rL0ozd2plallxaWdINDN6S3lSNjFlWllNdk9u?=
 =?utf-8?B?ZFdISmdkSDRBUnY3dy9lOThodWxva2FUdGxrWWlEZEsrL0k5Yk9kT3Yrdk00?=
 =?utf-8?B?L1djNmRrd0t5bUZyNGFjMnVZd3RHUXNQNVhNMm9qcmdmOXNYZWdiSEhxdnR3?=
 =?utf-8?B?RFVPUjZ3ZkpabitUcGViMnkxOUJFVzlwR0NRR0ZPdWY5ZEFuUHA5UFZsTDNJ?=
 =?utf-8?B?NG10dW1TR0dvc255aUcrRkQ5U1RzN2prc0g3ZWJqVDRqaW5tclZlZ28xbXUw?=
 =?utf-8?B?YmVjNGNLN3ArbFhCMkZ5dGZnNW9LTVA5eHZGeVNPTVIzdXZLNFJYZHlwUlI0?=
 =?utf-8?B?YnFWUVNSQmVkNGxMVWFxeFJVM0NiRmhlbVhGVmRvZENFMWF0ZXhUUHN1NUo2?=
 =?utf-8?B?V2ZJUzJFUXZvMTE0MDdYTzJ3ZTlXRjZwYTdidE9tWTBWRWNvT1RDWWUrdExK?=
 =?utf-8?B?MHRvV2x0RGhJUHFTRnZ5QmI4NEdTKzBUT21PZ1RLaFdLRk1QV0h5b2hhRmJT?=
 =?utf-8?B?V29WODRsMXduWmtSSnFiYndmdUxBeGprWXFjd3owZGw0anlEUENyZDN0dnlU?=
 =?utf-8?B?Y3pRTlpEQ2Jxb2xwR2w3QUhCa3BtZFlxNzRJeDJTM1g5RzlYZjhhb2dPRFBo?=
 =?utf-8?B?emNzbHd0TzI0ZnV5RGdMSmE2bnZjVUJoU29hT0x5K2dBZUZKTlpENkdPcURF?=
 =?utf-8?B?MTllSkI1M3JNV041QnVHZytPWkZLRGxwbTE3QThsNUswcmpMNVZ0dUpmVnlQ?=
 =?utf-8?B?R2phYkRZenAvb1lYQUY4Sm05V1pteC9icHV3cW1tQkRxYXcxR1M1THY2ZGt6?=
 =?utf-8?B?Q05CbEl0MVo1K2dxNzA1VEFvZGtxOVZiNHdNSk8wQy9yZjZtZGo1akZ1WlhP?=
 =?utf-8?B?Tms4QXE3c3V3K01IQmFtZHZUVzBzbHhhNWhQZnZRM0Iwa1pNcW8weUdQd0M4?=
 =?utf-8?B?eGNqdTV1MnZKVHZ4MUZMSUpOMzNJSHdienpzaHBoenpWVlhKZWdBREJqQ2tT?=
 =?utf-8?B?T0pBUDNjTmVKWUw4TnRyTi9hTFBFOFdBeFZ2VUk2cXZMWE9UaFdLZ2JTbm9P?=
 =?utf-8?B?OU15dmdSWkFldDdvQ3BDNTUzeGNub2Z5Y0RnYVA5TXprejJTcG5hYmJRQXN1?=
 =?utf-8?B?SnFNSnN3aHZRaThVejlLQUVCQTNUK0g5NGlWWUZZRW1VZG9vTjBuT05Kakwv?=
 =?utf-8?B?ZEVCUVpMTmtvMEhCTlVGbnBlRDN0RFA1UExjT0JNVUlvcStxTVV4TmhRY3pq?=
 =?utf-8?B?N1owSHh6SElsWTJ3MFljZmFra08vOUxpS2s3WEZ5b3NxR3owMlNwMHNkd1Rp?=
 =?utf-8?B?cGhRcUk4U05jU2hqTFFnL1Y4RXh5RmppSlZrSkFET1VCRVVyaUtUUndFOHZk?=
 =?utf-8?B?ZktMU00zdUhRbEhmNTRmQ2N0Y2dqOFpicit1aEhpOTh1TTBuaVJHQjE0TUp4?=
 =?utf-8?B?SlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <699D81737073AB4EB16974ABC9593CDC@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da9825a0-2247-4378-ce55-08da8efef58e
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 05:24:51.8648
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W/cEq8G5QZO0xjo5N8+KqyjUu0X6GZXYuPT5bIHyKjXvYtocK5o0yB1rtqK3wtCQ5MoqX6ldP67rld1XI1V9xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB8551
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBBdWcgMzAsIDIwMjIgYXQgMDg6MzY6MDJQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gSWYgdm1hLT52bV9tbSAhPSB0LT5tbSwgdGhlcmUncyBubyBuZWVkIHRvIGNhbGwgcGFn
ZV9tYXBwZWRfaW5fdm1hKCkgYXMNCj4gYWRkX3RvX2tpbGwoKSB3b24ndCBiZSBjYWxsZWQgaW4g
dGhpcyBjYXNlLiBNb3ZlIHVwIHRoZSBtbSBjaGVjayB0byBhdm9pZA0KPiBwb3NzaWJsZSB1bm5l
ZWRlZCBjYWxsaW5nIHRvIHBhZ2VfbWFwcGVkX2luX3ZtYSgpLg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogTWlhb2hlIExpbiA8bGlubWlhb2hlQGh1YXdlaS5jb20+DQoNCkFja2VkLWJ5OiBOYW95YSBI
b3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg==
