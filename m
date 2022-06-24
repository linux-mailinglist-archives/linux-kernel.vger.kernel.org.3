Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 819D2559580
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 10:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiFXIev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 04:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229910AbiFXIep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 04:34:45 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2074.outbound.protection.outlook.com [40.107.114.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67ABC6F490
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 01:34:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZidrdzlIMbZ4REpVPEgIGVZ23XHKvE3wECpRo6vwPI62v6WppUjnsIzoMu1Qgc6T/Cfak5VHbIw6HmwI7moTFnCXWwdYRc0EdaghgnXvYF9AO7l9QUe4fucVHpX7pv+KAjHbway+5GhP1G1gPvlQluTaSl0OKp74zRA6/IqTeyMDB/Aj+D94A+4yP+EGiYyokHg1kNa97vB3sy5mSPKslL4oh0SIMMc6kzGQqYwgbGZBmuua0fiqf29fHvvtsje6quNoZ9YSON3L6Xoh+lg+LgaYydUrhKWrM80/cn/PW+bReRjOG1y4A3UvGzM3yv5BZFwz5hxvZEF3gpjhe9GsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+i68eMqNGgd80OJ0JnK0FpfER/uA1m6bp+YVnCUE2iw=;
 b=M6j7bl5PQKwTZO6KCMy7lliGEzmxNms6HIvbJoTDyiIsTXRFzellqgbWNZQHupqSSTy4Kj8zrdV9AOmrjnQTWLi1x3o6NkFVi1vZ0m6KPmU8BZdPAZ8XEsIEfa8IP62WNwlpSnXXy+AzKjCqIyG0MgKdDnztfgH1R4WKXrIwln2BVGyCoxXngIwbzaZ432tl1srdGz/XhxcpXtbTcDMFw4vyIIHt/RRUp4gGZsBLllYkP7U9V/odZydvMdW7zVQtBQIXa5pDASZl+DyRxSzrX3u36CeTOJyBPuGhu6suEyao1ptt/UY8u/3nhW5mR8xcoFajgRzxeZAxRCX+Q1K0fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+i68eMqNGgd80OJ0JnK0FpfER/uA1m6bp+YVnCUE2iw=;
 b=k7h5qwjnS9GQt3vq71yNWMevR3p2i5cGv4VoiK3ZbOtxb7a0oBQwyzq6AxqDFWjzPiAP0LTm7fYbaC6MQ+mLjbBTuEcogY/sfOVK1EyJMrmI+jfHpA1i0ufHroEqjOL5BDTMYg0aCUkhJc/jLXbh5uV1paimOjrrqmM3wF36NB8=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYYPR01MB8183.jpnprd01.prod.outlook.com (2603:1096:400:fe::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Fri, 24 Jun
 2022 08:34:42 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836%6]) with mapi id 15.20.5353.022; Fri, 24 Jun 2022
 08:34:42 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>,
        Muchun Song <songmuchun@bytedance.com>
CC:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2 1/9] mm/hugetlb: remove checking hstate_is_gigantic()
 in return_unused_surplus_pages()
Thread-Topic: [PATCH v2 1/9] mm/hugetlb: remove checking hstate_is_gigantic()
 in return_unused_surplus_pages()
Thread-Index: AQHYh1xSoNvgTy1mRUSP6G7yMyIF8K1d1LUAgABeaQCAAAM+gIAABVoA
Date:   Fri, 24 Jun 2022 08:34:42 +0000
Message-ID: <20220624083428.GA2070418@hori.linux.bs1.fc.nec.co.jp>
References: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
 <20220623235153.2623702-2-naoya.horiguchi@linux.dev>
 <0b69e3ef-0123-4575-b68d-4d9b2067aa0e@huawei.com>
 <YrVv3gKMxbu/dwCs@FVFYT0MHHV2J.usts.net>
 <e9a22524-d9f6-1018-a712-00adb90d432a@huawei.com>
In-Reply-To: <e9a22524-d9f6-1018-a712-00adb90d432a@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 18797ba8-5be2-4738-25a0-08da55bc6299
x-ms-traffictypediagnostic: TYYPR01MB8183:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BL3sS2lq80CDnqfsYVpq9ZDog0ZmksKk9t0GxFAaOCKELATEqZTY7tGCdFwtrpJuWNEoq3g5w1e5+Q4EbdkpzVOwvMKlSVxdkSrzVW37mQj8PUFtuZD9uH33Ul+heBDFlRyjss5AcZogFsSE5Yr0jjTghl79yFsiQ3axNcYE1gxvktgCR3cGltREEapfdqyNVkvYN02wgc4zv7F60BgiB4WvRcC1tg73Ryy6jG0fcsUyNgu7NtkJS6Su3iUzA/2WXVUWm5gaTLI74G07tgcwC6uDI2S22YQlQvVOmSd+Z0la6UU0ZVvJidEoaXbx+4ALiHxZRiSSyKjqLBxnvQ78BNh2Jnvsmcmf5QoWXEj/Gk2DlQ+dv/3QomCbzuYrYiJypH9UwoCufQ1myj/gWG73ka2JUE6bBrRq9B4GP7ZinvyyFXFZv03tYCaUulCtpek4IPy2SeZWzDxZ+NCxcrnlLiMmGLZSTa1t2NOZ57cwJG4or542g0fThOCHYB3EvyX/+cSy5VssMYCi4hefZtprexsc9frqw5jJ2yoVi2XQAHi83v/mjcULLfNGMAel3/1PpVuaa05eQoDlvA7qIFFola/Yq19LfnK/NfsKwnohKxOQ5qqu/jJUOIeete2ecSu9UXqfhew9eJ0Ntu+mW1WS6U0mDY2O1XHjWLI9pDkBjAM3U7pD2hZ+EF70DAG7bnpJF1Hnvex7ylJdyGvq1/TPpSUx88Ojjvs7vWObGFOTvCsL6ttct/td9Sh8TdpQE1NafVWaF8MQt3Ph8hxn6sTY9TExFPuQyXjLUhCXxzGbWLc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(346002)(376002)(366004)(8936002)(2906002)(5660300002)(53546011)(55236004)(83380400001)(1076003)(41300700001)(9686003)(6506007)(186003)(478600001)(33656002)(6512007)(26005)(66946007)(76116006)(66556008)(66446008)(66476007)(64756008)(6486002)(8676002)(4326008)(54906003)(110136005)(71200400001)(316002)(85182001)(38100700002)(122000001)(38070700005)(82960400001)(86362001)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEozWG5jN0VRakFDUTlXcnd4dG4weEwvUzR1SW9xWUVualJndG9GUlVTUTlO?=
 =?utf-8?B?RG4xMnVrMnMxK1d5d0dGUE45QUFYUjNWY0pyb3lRSlNVL3lsNmozNjlseHky?=
 =?utf-8?B?QkQrWnN6ckd5d3JRMnAwQnRZMHBOZmc1UXIybDk5cU5LaUZjbmlZMVJiR01p?=
 =?utf-8?B?ZWxIQzRWbzlQT25lN01vR1kzS2FsWDVROHpMZWpPRGxlZlpQRVMzT255aVJF?=
 =?utf-8?B?MFdnZVJyK1hUeDF4ZWxta0FkYU4wdWMwR0VBQUxkNldnWEhEblVUeUVtbW5N?=
 =?utf-8?B?cWVPKzB5SCs0QlNmUUU0dmlkdGwyVUtMdVBERUliVm83eVI1aEFIYUY0dzFH?=
 =?utf-8?B?Qmh0WXAvKytyOExUZUpUTkpRRTJJT1ZVUE1TeWtGRWJXcmx2ZTZlcFI1Vnlw?=
 =?utf-8?B?VWQrcFBYNEoxYyszK1RsZlhHMDlhTmxIN0xTc2ZOWlY2dkp1bENLOWR2OENC?=
 =?utf-8?B?QnM4TEpVQzlpSWI4dmR2cXhKMVJ3L3JvMDc1V3Rmdzh6ckVlQUIvQVY0NWJs?=
 =?utf-8?B?VDFxMFNBcjZRN2hEQnByWExJZlk4WXpOMndsckZrL1dnQ0ZEcXkxekVremgx?=
 =?utf-8?B?ZFFkZ1RBZ1U5ekUrOUFIeVRwWGcxaVdKd2Y2U3VyN3RDVm4vTFFhTlVKeE05?=
 =?utf-8?B?NkNCWGpabXhoZUNPK1phVmoycnkwTXk3alQvTStOOExGNHIzaDJ5a0lMVzNV?=
 =?utf-8?B?eXpyTXNYNUdkUWhsdHVFaDJIYWtPRS9OY1JBSkFWK0h1UHk5NEl5R3ZaQ1V3?=
 =?utf-8?B?a2ptd0Q1cFdPMXA1K3ZNUDhjYjNnZmMrZTE5Y2V5dW52M3Q1KzdWUDI0VVVM?=
 =?utf-8?B?UjZiaUZtekdsUWtaMUd1czNyWksxK2lieU04NzNjbmRqR05EWDJtanRyZlU4?=
 =?utf-8?B?aER6M0kwa0gvRi9vcGRKQXJCS1RYTWRnZTlLdDNKNW1IZUZ3NUJ6VVptT3Nh?=
 =?utf-8?B?VHc4Qnl4N1I0dSsyVkVSdXp2K1RSNmRDTmozOUlvRlhmU0o5cGs5VmF6R3lm?=
 =?utf-8?B?L250QkpNWkxDSytCc2lFNzk4MnJpOUwweUltMk44eFc1VWNrYis0bHhKMGp2?=
 =?utf-8?B?Vm1hYXM2KzV0ODZaaWxSajhyNERxQmZHalB2QkY4YTRlQUFReFhTMVd4aVpO?=
 =?utf-8?B?MEVFSEhBbHRsNlI2Tk1OWjNzaUtOVE8wUzJFUjg4YWRzYjVtRWxoYmZGUmpy?=
 =?utf-8?B?L2ltQ2Q2RDNPNDZXK2liWDFDWnkyVEI3RWlkbTVSVW12YUJXR216WUw0dDd3?=
 =?utf-8?B?aU1uUzVVd090dzN4N3dDZTFSTmRIZHBIL0lZWGdhUlR2ZUU3OGVOQ3kvVGdK?=
 =?utf-8?B?NVVpUVhFOCtKQWtiQUx1d1QyVlVjL1BlbkI0dGZVaU9OeEZTWHlTMXRWV291?=
 =?utf-8?B?VXJCWHp0ekd2Y3ZxamwvMWxrdW9Fd2FCNkZOQ0hxYUllZ05ZTjF5U3JTQ2R1?=
 =?utf-8?B?NGlRWTVJRHpwQ1Rwa0h4MWFuRmVtN1pjODU3QnpZcEcrcXQzYXNKT2tnVkl5?=
 =?utf-8?B?Z05SSno1MVdHR2poL0dDU0dCK05CMU1xZFNYZUQvdEd3cUE3c3pZQU1CZFJm?=
 =?utf-8?B?V2VMeEE5NlhMNnJvQkdkdWg3Nnp2Sy9JQllZVFZ1SUZRY2g4SjlqbTZUQUs3?=
 =?utf-8?B?T2xxNDAzV3d2MWJCUFZIa1M5MEp4OU84WVllSGMzM0dpNklUQ21TSFNWNmdh?=
 =?utf-8?B?V09QcFJuYnMxOGx6eWo0ZUVySDJWSmhoTGlXUTJNdUwxa29TMVJUc0wyMnJy?=
 =?utf-8?B?Ujg3b09ZZEE1ZjUvY3cvMG56cWtYR1IwbkFsWCtJNXhKbUxLcmJtcE5pMjJ3?=
 =?utf-8?B?K2hXaGZMcHZqK1N2bzk1ak5ycFNZM1dpb25uNFF2dUhPcDdnS2pRSFFCbWcw?=
 =?utf-8?B?d29yeWRydmt0S1N0Ri9ycDhDcXB1aE5ieittUFhOY01YODR5SGNpRDdzZ05j?=
 =?utf-8?B?RDFQbkpHT1BDdFBmZ3NIem44RWNidkJoblRmTWFiZ3AyeVNXeS9YWEY5azZG?=
 =?utf-8?B?T2Z1UStxd2dRbmE1VzRZaWJoUkZKZk9lc2Z6a0FWMzJaU25EbHk1dGIwcWU1?=
 =?utf-8?B?ZkM5b2drZUJMeGdLNFRDUHZpUVQzc3AzWGZyd1FDd0dvSUdxL0lBSE53Ty96?=
 =?utf-8?B?ODFRV3ZIanF2cjNDSDFGS3o5UDlDSlQybTg5bDg2Uk1Sa3NteXpmeVpEMnRL?=
 =?utf-8?B?OVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F032B334DDF08A4DBAC71BD04D1392E0@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18797ba8-5be2-4738-25a0-08da55bc6299
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jun 2022 08:34:42.2437
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wnz7vUoFiK/rSEzoG8Jm9axK6Ao8aLAZCzpyaiXa702cj5QWVDsswwcJppLhyF5WBZS+FjuvirkyBmGuXTJtPg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYPR01MB8183
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBKdW4gMjQsIDIwMjIgYXQgMDQ6MTU6MTlQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi82LzI0IDE2OjAzLCBNdWNodW4gU29uZyB3cm90ZToNCj4gPiBPbiBGcmks
IEp1biAyNCwgMjAyMiBhdCAxMDoyNTo0OEFNICswODAwLCBNaWFvaGUgTGluIHdyb3RlOg0KPiA+
PiBPbiAyMDIyLzYvMjQgNzo1MSwgTmFveWEgSG9yaWd1Y2hpIHdyb3RlOg0KPiA+Pj4gRnJvbTog
TmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gPj4+DQo+ID4+PiBJ
IGZvdW5kIGEgd2VpcmQgc3RhdGUgb2YgMUdCIGh1Z2VwYWdlIHBvb2wsIGNhdXNlZCBieSB0aGUg
Zm9sbG93aW5nDQo+ID4+PiBwcm9jZWR1cmU6DQo+ID4+Pg0KPiA+Pj4gICAtIHJ1biBhIHByb2Nl
c3MgcmVzZXJ2aW5nIGFsbCBmcmVlIDFHQiBodWdlcGFnZXMsDQo+ID4+PiAgIC0gc2hyaW5rIGZy
ZWUgMUdCIGh1Z2VwYWdlIHBvb2wgdG8gemVybyAoaS5lLiB3cml0aW5nIDAgdG8NCj4gPj4+ICAg
ICAvc3lzL2tlcm5lbC9tbS9odWdlcGFnZXMvaHVnZXBhZ2VzLTEwNDg1NzZrQi9ucl9odWdlcGFn
ZXMpLCB0aGVuDQo+ID4+PiAgIC0ga2lsbCB0aGUgcmVzZXJ2aW5nIHByb2Nlc3MuDQo+ID4+Pg0K
PiA+Pj4gLCB0aGVuIGFsbCB0aGUgaHVnZXBhZ2VzIGFyZSBmcmVlICphbmQqIHN1cnBsdXMgYXQg
dGhlIHNhbWUgdGltZS4NCj4gPj4+DQo+ID4+PiAgICQgY2F0IC9zeXMva2VybmVsL21tL2h1Z2Vw
YWdlcy9odWdlcGFnZXMtMTA0ODU3NmtCL25yX2h1Z2VwYWdlcw0KPiA+Pj4gICAzDQo+ID4+PiAg
ICQgY2F0IC9zeXMva2VybmVsL21tL2h1Z2VwYWdlcy9odWdlcGFnZXMtMTA0ODU3NmtCL2ZyZWVf
aHVnZXBhZ2VzDQo+ID4+PiAgIDMNCj4gPj4+ICAgJCBjYXQgL3N5cy9rZXJuZWwvbW0vaHVnZXBh
Z2VzL2h1Z2VwYWdlcy0xMDQ4NTc2a0IvcmVzdl9odWdlcGFnZXMNCj4gPj4+ICAgMA0KPiA+Pj4g
ICAkIGNhdCAvc3lzL2tlcm5lbC9tbS9odWdlcGFnZXMvaHVnZXBhZ2VzLTEwNDg1NzZrQi9zdXJw
bHVzX2h1Z2VwYWdlcw0KPiA+Pj4gICAzDQo+ID4+Pg0KPiA+Pj4gVGhpcyBzdGF0ZSBpcyByZXNv
bHZlZCBieSByZXNlcnZpbmcgYW5kIGFsbG9jYXRpbmcgdGhlIHBhZ2VzIHRoZW4NCj4gPj4+IGZy
ZWVpbmcgdGhlbSBhZ2Fpbiwgc28gdGhpcyBzZWVtcyBub3QgdG8gcmVzdWx0IGluIHNlcmlvdXMg
cHJvYmxlbS4NCj4gPj4+IEJ1dCBpdCdzIGEgbGl0dGxlIHN1cnByaXppbmcgKHNocmlua2luZyBw
b29sIHN1ZGRlbmx5IGZhaWxzKS4NCj4gPj4+DQo+ID4+PiBUaGlzIGJlaGF2aW9yIGlzIGNhdXNl
ZCBieSBoc3RhdGVfaXNfZ2lnYW50aWMoKSBjaGVjayBpbg0KPiA+Pj4gcmV0dXJuX3VudXNlZF9z
dXJwbHVzX3BhZ2VzKCkuIFRoaXMgd2FzIGludHJvZHVjZWQgc28gbG9uZyBhZ28gaW4gMjAwOA0K
PiA+Pj4gYnkgY29tbWl0IGFhODg4YTc0OTc3YSAoImh1Z2V0bGI6IHN1cHBvcnQgbGFyZ2VyIHRo
YW4gTUFYX09SREVSIiksIGFuZA0KPiA+Pj4gaXQgc2VlbXMgdG8gbWUgdGhhdCB0aGlzIGNoZWNr
IGlzIG5vIGxvbmdlciB1bm5lY2Vzc2FyeS4gTGV0J3MgcmVtb3ZlIGl0Lg0KPiA+Pg0KPiA+PiBz
L3VubmVjZXNzYXJ5L25lY2Vzc2FyeS8NCg0KVGhhbmtzLCBJIGZpeGVkIGl0Lg0KDQo+ID4+DQo+
ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3Vj
aGlAbmVjLmNvbT4NCj4gPj4+IC0tLQ0KPiA+Pj4gIG1tL2h1Z2V0bGIuYyB8IDQgLS0tLQ0KPiA+
Pj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGRlbGV0aW9ucygtKQ0KPiA+Pj4NCj4gPj4+IGRpZmYgLS1n
aXQgYS9tbS9odWdldGxiLmMgYi9tbS9odWdldGxiLmMNCj4gPj4+IGluZGV4IGE1N2UxYmU0MTQw
MS4uYzUzODI3ODE3MGEyIDEwMDY0NA0KPiA+Pj4gLS0tIGEvbW0vaHVnZXRsYi5jDQo+ID4+PiAr
KysgYi9tbS9odWdldGxiLmMNCj4gPj4+IEBAIC0yNDMyLDEwICsyNDMyLDYgQEAgc3RhdGljIHZv
aWQgcmV0dXJuX3VudXNlZF9zdXJwbHVzX3BhZ2VzKHN0cnVjdCBoc3RhdGUgKmgsDQo+ID4+PiAg
CS8qIFVuY29tbWl0IHRoZSByZXNlcnZhdGlvbiAqLw0KPiA+Pj4gIAloLT5yZXN2X2h1Z2VfcGFn
ZXMgLT0gdW51c2VkX3Jlc3ZfcGFnZXM7DQo+ID4+PiAgDQo+ID4+PiAtCS8qIENhbm5vdCByZXR1
cm4gZ2lnYW50aWMgcGFnZXMgY3VycmVudGx5ICovDQo+ID4+PiAtCWlmIChoc3RhdGVfaXNfZ2ln
YW50aWMoaCkpDQo+ID4+PiAtCQlnb3RvIG91dDsNCj4gPj4+IC0NCj4gPj4NCj4gPj4gSUlVQyBp
dCBtaWdodCBiZSBiZXR0ZXIgdG8gZG8gdGhlIGJlbG93IGNoZWNrOg0KPiA+PiAJLyoNCj4gPj4g
CSAqIENhbm5vdCByZXR1cm4gZ2lnYW50aWMgcGFnZXMgY3VycmVudGx5IGlmIHJ1bnRpbWUgZ2ln
YW50aWMgcGFnZQ0KPiA+PiAJICogYWxsb2NhdGlvbiBpcyBub3Qgc3VwcG9ydGVkLg0KPiA+PiAJ
ICovDQo+ID4+IAlpZiAoaHN0YXRlX2lzX2dpZ2FudGljKGgpICYmICFnaWdhbnRpY19wYWdlX3J1
bnRpbWVfc3VwcG9ydGVkKCkpDQo+ID4+IAkJZ290byBvdXQ7DQo+ID4+DQo+ID4gDQo+ID4gVGhl
IGNoYW5nZSBsb29rcyBnb29kIHRvIG1lLiBIb3dldmVyLCB0aGUgY29tbWVudHMgYWJvdmUgaXMg
dW5uZWNlc3NhcnkNCj4gPiBzaW5jZSBnaWdhbnRpY19wYWdlX3J1bnRpbWVfc3VwcG9ydGVkKCkg
aXMgc3RyYWlnaHRmb3J3YXJkLg0KPiANCj4gQWdyZWUuIFRoZSBjb21tZW50cyBjYW4gYmUgcmVt
b3ZlZC4NCg0KVGhhbmsgeW91LCBib3RoLiBBZGRpbmcgIWdpZ2FudGljX3BhZ2VfcnVudGltZV9z
dXBwb3J0ZWQgd2l0aG91dCBjb21tZW50DQptYWtlcyBzZW5zZSB0byBtZS4NCg0KVGhhbmtzLA0K
TmFveWEgSG9yaWd1Y2hp
