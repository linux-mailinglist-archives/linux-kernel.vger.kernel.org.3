Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAE355DB1D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbiF0GHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 02:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbiF0GHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 02:07:02 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2048.outbound.protection.outlook.com [40.107.113.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF93F2ADC
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 23:07:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fsrQW1nP6jvT1uQ+ChrDoRneXLJyo59iCklOX/xrEscQqpAGDUzcHc6aKpK9D3OAwNzHHXaWoBgbXyQzqE4f4fS1uDuu0Nsb1ulhzekonEqOm751cBVir1Pcseqyja/der7ntJHdB4kjDgl1msfBQa023RLDPo6J8LzQ5svbbnIwV40tqojxNrr4BBrWbMPF16GxTr8Jy0rI1/6hGzFQLbN3mHCqVcUjLtwg6g8fiMFOefLdD0Bwh+/x1YxxIi8k/cO7wOaMYLTbP8mjHGhU7X7nF95NHAKqUhHglGB+jLrt94pgDxVrLtFVA/HJJJ+MUkyfOtT0Y0cuV5Y5rVilEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n6+kFiclpx+bZW+bxbKGyM4VgeatADzqEcWPcbW1IXw=;
 b=mXXvMNohbKGOyJSq8IH077pzARhtgS4NCyNfO6IPUgfj+gTx/4f6TvZomV5ynLj/SNsVe/PWXXKRnOZnEo/lmDdzvmltu5mCaL94goI1axk9sahP+zndNzFfkJngs411CGfqVGKxrYcMVABNZ8CApFi2fKorG/bwP5JwRoCcZx9NC31kTlpTWD/KRuWCmWr4mY/0Ac2bn0hsSXckVeK5mbxx0wJReKygfEXKWqWVg7w/QeZ+fQdMMz4gPjwPUuV5rfOFsfJpHYhBojUe04Dt1RxvuwbDI7r84YuUH/bBuxghajOAyyoCoOqBPqesxXtG9dMfLdlgc+hwIeXbHwBgnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n6+kFiclpx+bZW+bxbKGyM4VgeatADzqEcWPcbW1IXw=;
 b=nECJT1PxxtHKDCn2HWyZtgqOFXubX3D3Fuv933772V8n8/8byVaA29fbI8SIHk9Z2eR3Cs4t6ky8xprsnpPOFOCCcXkC5chucJKqe0/+D8Jz9TblRIup//de8leBXCfDqZd0v66aA9DxjNXwBMOTamJvyQ5GDr55RGJtCy6EeN0=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OS3PR01MB8414.jpnprd01.prod.outlook.com (2603:1096:604:192::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.17; Mon, 27 Jun
 2022 06:06:59 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836%7]) with mapi id 15.20.5373.018; Mon, 27 Jun 2022
 06:06:59 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     Naoya Horiguchi <nao.horiguchi@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v2 2/9] mm/hugetlb: separate path for hwpoison entry in
 copy_hugetlb_page_range()
Thread-Topic: [PATCH v2 2/9] mm/hugetlb: separate path for hwpoison entry in
 copy_hugetlb_page_range()
Thread-Index: AQHYh1xUve5r1QiYqU6+XdseaUKBQq1eSXaAgASACoA=
Date:   Mon, 27 Jun 2022 06:06:59 +0000
Message-ID: <20220627060659.GB2159330@hori.linux.bs1.fc.nec.co.jp>
References: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
 <20220623235153.2623702-3-naoya.horiguchi@linux.dev>
 <be99e9db-3fd0-67de-7776-e6c6e932b965@huawei.com>
In-Reply-To: <be99e9db-3fd0-67de-7776-e6c6e932b965@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 00fa251a-9c60-4662-e2be-08da58033f54
x-ms-traffictypediagnostic: OS3PR01MB8414:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lpjzQ8AH/XByvY7A0aK+mhIemN8h5HD9h6b0Zn4Bpb1+a9i6wNbdWd6l2VrCDXQaVjjX3cD/got0oxp3pe7SIe93TQ5+BBAt3sYDIWr2gUG3Ig3ArLQvXWExkr0kLTeMXkvwN8S/zp3Gy6fkfdVDMwS46XehaeHpjBqlXc+Z+PAibMgOYLsNz56P17DOJSOwSmza31blHXIkNN0SEV6Qj4Q4Xy5iT6J3AGkIpHKGyLAVN719RX4BfWFvsI/8KhbQ81+V9wmky6HbxXDjlthu4PQN1qG4ROpDCfju2Uvc3yJLoOBMcv9bTJLkeyAVy0NbsuZfyW9NEZHRHaY4IcAz+gyhbL7119a9gzAjpYlp50ITkAovqGRXGMZ9ZF2wTvYNCgKuJ9V3/4sE4tn074+CNykKFu2qxusZXbgsgC2G70IO2ersASr8jdcdX7qGLQwJR0ktB/W31XkWhOLZEBgDSGB344gnHq4ItIGEP+cLJcQWcK8Qow4f4ypaAd9EC7X1wsfrUQ4D/Tr/eRJ2OpgyT6Al/s5A8SUpA9jz/VgPErPx11h8YbtvRPuc/Dx5gDi3oIfYO4wDEWkOHi8Z7TDwlsvv/GOk7O/15U62Wsa0MiuVmN2pMlnRWEE2rA6ZEahSDGCgRKlk6qot4aWRUDIvEJKlwICYnfwc60DtKDrY/0fADSqzNby1fTLE0PTWxXf7CvEuQEj9P54PQ/okLnAbUHB7TCTPp8bUrqkU5PaawYlLlY0fC21JBsK6EYZ+tHIexc2hQ+70+fPhEdL244twa8GVTOh03QFYdP/K6q6Ybto=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(39860400002)(366004)(396003)(4326008)(8676002)(9686003)(82960400001)(6486002)(83380400001)(6512007)(5660300002)(26005)(66946007)(76116006)(66476007)(478600001)(66556008)(66446008)(8936002)(64756008)(71200400001)(122000001)(7416002)(38070700005)(53546011)(85182001)(186003)(2906002)(33656002)(1076003)(55236004)(6506007)(54906003)(38100700002)(6916009)(41300700001)(86362001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnpFQlpYTEZrT2oybGlRK0xGWkxGMDRRYUc4Mi9xNmZoVVZoZGk0ZE9Rbm9v?=
 =?utf-8?B?cFhYbzhKRkFVc2FrZFhXRWc0V05iRmpITWsyS3Y0VXB3dWc5SGp6SHJWTjN5?=
 =?utf-8?B?dmRUb01SdUdDZzc3citOYjlnb040WEtRZW9qQW1LdGUyc1I3cGF3cE83c1E2?=
 =?utf-8?B?aFNlVkZmZzAxc0V4TFZ0MTBDSFJycHcxeUpWN0pkaFpKWDhibnVJTGlhUlNo?=
 =?utf-8?B?QXZkamh1MW1MU095NVZRSkxCYkFhNmViVUJJaVlSY0lNdmRqcTl0bjNJNHdF?=
 =?utf-8?B?YnZkbnZZazU2OVBnZzhCSnhSOVBIRnNKQytWNkljRjZlcVpCWXJVQzNvbnRr?=
 =?utf-8?B?Njd5cGNyZTAvVDJjQWJFN0Y4Z2hkMXhPcXlCK0xIcTNRWVc1TWx5ZzBacWVt?=
 =?utf-8?B?aWtEUjBteWl3c2szbC8yZjRKZnZ2MnJ3QXVMSkcrTE1UUHBSZldFYkFiV1VU?=
 =?utf-8?B?eG16MVlEaG42dllJQXora2pndHRCWUR2WlBrVDBhMGVSbEVHbGZuQ1ZSWFE0?=
 =?utf-8?B?VnI0ZnJ3R3FmdFRkTTNhc2NOclBEZExVdjM5RVN4WExTL0trenMrN2dIUU5m?=
 =?utf-8?B?STRDNHB2d2s4YnNxNSt5RG96aGxhdDQwbHdLS0ZXL1N1TlhnbjYwS3VicVVp?=
 =?utf-8?B?TTlZSjFqK1JlaksyOHk2eDNRZTNPelYvWm9KUmdibjlLV0MrT0dWM3hwek1j?=
 =?utf-8?B?cWJrcDVuU2dWa2NGbVdXU3dWaWRLWndqejZqNjNZV2paTEdXUmY3dWJRSFVq?=
 =?utf-8?B?ZmkwUEhMZXpocTkyVEg5ZzVYcUZQbGpiNEErVjRlaUZHZEk1SjIxRndHczY3?=
 =?utf-8?B?aWtISGFKUG9hNWpOSGhWaU96S0gya1JuaHdqSDZsVUNoUXZoS2hmTGdkdjNr?=
 =?utf-8?B?WUFKSUtsVlFNdnNqaUdxcE5TV2NmU2NVSTlVa0N0c1N3UEUrRkNGTDZzUXlE?=
 =?utf-8?B?QzhIOVRqV0JYbWFBT3ZUVFZIc1BYWEcvK09ibGZtWWFkZHhCdHN5a00zbWFj?=
 =?utf-8?B?a3k0NU1MaHZlc05xc2ZpVlRHS1dSUmczV2FKS29yVDFSVUtXek02M2FnaHRR?=
 =?utf-8?B?VThZZ1I4TmFaSDVIeGhqbEJNNmF2UkFEVy9jL0VoVkM3WDhhRlF5VStaekFq?=
 =?utf-8?B?dnFBbjQvMHJKM3U1S3poSmhLR3hieCtzYWFoTzN1V0svcm1IVmx5TWdBY1ky?=
 =?utf-8?B?UENncDh5OXNIK3R6Y3JPbTJMZlJETFF5SCtLTDYyZDAwVTc1N1ZhNUtMVjFk?=
 =?utf-8?B?SGlvekFhUEZLZHp2T1QyNzlJZzBpM3ErVnc5aHRCRlp4cytSQUhKZ2IxbTNV?=
 =?utf-8?B?ZVVNVFJFNHVnWUJzMlJQL3FyV2ErVndrZGE2Vm1MSW5TTlRLbThteGlTdnBq?=
 =?utf-8?B?eUk3UTZvdDJ6dTVIRjRlNmVIQ0QyaVNCV3U0bUErUW81UDZ1ZnF6QUQ4SUlp?=
 =?utf-8?B?T2J4c3ZYSzRLRzhNMHgxbXdUN2dSME9zbjZSdmRDRkZGZ1RSWVdKYmE4VlBQ?=
 =?utf-8?B?NWRCVExrQkkyREZtbEl1TTJVOEdhNVV6cEdDWmFvdkd5Y3dyenpWQVM3Sk8z?=
 =?utf-8?B?WFIvd1ZkQ2xySmZzTDdBSTY0M2ZydmwwZnhKR1l5OE9rL3k0SUkrQmw2RmhD?=
 =?utf-8?B?WU91U0dNb0V2Q05PME9WT2xTbnFwSnRSZXpVanFKVTdmLzVzUmxRVXlybjY2?=
 =?utf-8?B?bmJoZmpBUmxrck1kbzVVbjBDeXNMTHZZUlVXcVpmMm5MNlRtaXBxb0Q3YldJ?=
 =?utf-8?B?QVlnMHY4U0tUTVBJYXQ1ZFREbVptWmVIQ2J6ano0bU1BK08xbjlaNE9yZVJF?=
 =?utf-8?B?bWsvUUtTdXkvNHhyejRDMFNlRk5qaWZGQWhWVUFyWVREcE5SNC9XVUVrQTFn?=
 =?utf-8?B?YWlyWC9SaGQ4aXZTcWI2Q2kzbEg5V3Z4OFJWajNsbDJQbjQxVEYvUVZIZnZJ?=
 =?utf-8?B?YXJIVmFEQmFNQUUrWXN2bkxZdHVsVFlaV29wYjQ1VEdUOTU2N3gwcWl6TlI4?=
 =?utf-8?B?bmlhb1VtYzFQRVpHYzNXNG9ZS3kvK09Hek05L212bzdCelR1b2krdFRCQmhz?=
 =?utf-8?B?NGhOU3l3QWNLcjUweFg2MVN5a0liSWx5MmlYdG4vNlZtNG01Y3lCS2hNVXk3?=
 =?utf-8?B?WEdNYy9mUzhTclkvdmhPaW9ySnRtYlR2OXR5UTl1cEdRZmdpT0tLT3BTUlFs?=
 =?utf-8?B?aVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5315B800C4B2BA4AB43C5A5909F02F31@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00fa251a-9c60-4662-e2be-08da58033f54
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2022 06:06:59.6707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DJBrWL5pRhp2QT8BTCSRXPTvLIe2koK54ar+HCUhmKfNaMh+tRiq0B+S7Z1k/OrUQ71H+klG1si4JszMUdSBOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB8414
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBKdW4gMjQsIDIwMjIgYXQgMDU6MjM6NDFQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi82LzI0IDc6NTEsIE5hb3lhIEhvcmlndWNoaSB3cm90ZToNCj4gPiBGcm9t
OiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29tPg0KPiA+IA0KPiA+IE9y
aWdpbmFsbHkgY29weV9odWdldGxiX3BhZ2VfcmFuZ2UoKSBoYW5kbGVzIG1pZ3JhdGlvbiBlbnRy
aWVzIGFuZCBod3BvaXNvbmUNCj4gDQo+IHMvaHdwb2lzb25lL2h3cG9pc29uZWQvDQo+IA0KPiA+
IGVudHJpZXMgaW4gc2ltaWxhciBtYW5uZXIuICBCdXQgcmVjZW50bHkgdGhlIHJlbGF0ZWQgY29k
ZSBwYXRoIGhhcyBtb3JlIGNvZGUNCj4gPiBmb3IgbWlncmF0aW9uIGVudHJpZXMsIGFuZCB3aGVu
IGlzX3dyaXRhYmxlX21pZ3JhdGlvbl9lbnRyeSgpIHdhcyBjb252ZXJ0ZWQNCj4gPiB0byAhaXNf
cmVhZGFibGVfbWlncmF0aW9uX2VudHJ5KCksIGh3cG9pc29uIGVudHJpZXMgb24gc291cmNlIHBy
b2Nlc3NlcyBnb3QNCj4gPiB0byBiZSB1bmV4cGVjdGVkbHkgdXBkYXRlZCAod2hpY2ggaXMgbGVn
aXRpbWF0ZSBmb3IgbWlncmF0aW9uIGVudHJpZXMsIGJ1dA0KPiA+IG5vdCBmb3IgaHdwb2lzb24g
ZW50cmllcykuICBUaGlzIHJlc3VsdHMgaW4gdW5leHBlY3RlZCBzZXJpb3VzIGlzc3VlcyBsaWtl
DQo+ID4ga2VybmVsIHBhbmljIHdoZW4gZm9raW5nIHByb2Nlc3NlcyB3aXRoIGh3cG9pc29uIGVu
dHJpZXMgaW4gcG1kLg0KPiANCj4gcy9mb2tpbmcvZm9ya2luZy8NCg0KU29ycnkgZm9yIG1hbnkg
dHlwb3MuICBJIHNvbWVob3cgZm9yZ290IHRvIHJ1biBzcGVsbCBjaGVja2VyLg0KDQo+IA0KPiA+
IA0KPiA+IFNlcGFyYXRlIHRoZSBpZiBicmFuY2ggaW50byBvbmUgZm9yIGh3cG9pc29uIGVudHJp
ZXMgYW5kIG9uZSBmb3IgbWlncmF0aW9uDQo+ID4gZW50cmllcy4NCj4gPiANCj4gPiBGaXhlczog
NmMyODc2MDVmZDU2ICgibW06IHJlbWVtYmVyIGV4Y2x1c2l2ZWx5IG1hcHBlZCBhbm9ueW1vdXMg
cGFnZXMgd2l0aCBQR19hbm9uX2V4Y2x1c2l2ZSIpDQo+ID4gU2lnbmVkLW9mZi1ieTogTmFveWEg
SG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gPiBDYzogPHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmc+ICMgNS4xOA0KPiANCj4gVGhpcyBtYWtlcyBzZW5zZSB0byBtZS4gVGhhbmtz
IGZvciBmaXhpbmcgdGhpcy4NCj4gDQo+IFJldmlld2VkLWJ5OiBNaWFvaGUgTGluIDxsaW5taWFv
aGVAaHVhd2VpLmNvbT4NCg0KVGhhbmsgeW91IGZvciByZXZpZXdpbmchDQoNCi0gTmFveWEgSG9y
aWd1Y2hpDQoNCj4gDQo+ID4gLS0tDQo+ID4gIG1tL2h1Z2V0bGIuYyB8IDkgKysrKysrKy0tDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4g
DQo+ID4gZGlmZiAtLWdpdCBhL21tL2h1Z2V0bGIuYyBiL21tL2h1Z2V0bGIuYw0KPiA+IGluZGV4
IGM1MzgyNzgxNzBhMi4uZjU5ZjQzYzA2NjAxIDEwMDY0NA0KPiA+IC0tLSBhL21tL2h1Z2V0bGIu
Yw0KPiA+ICsrKyBiL21tL2h1Z2V0bGIuYw0KPiA+IEBAIC00Nzg0LDggKzQ3ODQsMTMgQEAgaW50
IGNvcHlfaHVnZXRsYl9wYWdlX3JhbmdlKHN0cnVjdCBtbV9zdHJ1Y3QgKmRzdCwgc3RydWN0IG1t
X3N0cnVjdCAqc3JjLA0KPiA+ICAJCQkgKiBzaGFyaW5nIHdpdGggYW5vdGhlciB2bWEuDQo+ID4g
IAkJCSAqLw0KPiA+ICAJCQk7DQo+ID4gLQkJfSBlbHNlIGlmICh1bmxpa2VseShpc19odWdldGxi
X2VudHJ5X21pZ3JhdGlvbihlbnRyeSkgfHwNCj4gPiAtCQkJCSAgICBpc19odWdldGxiX2VudHJ5
X2h3cG9pc29uZWQoZW50cnkpKSkgew0KPiA+ICsJCX0gZWxzZSBpZiAodW5saWtlbHkoaXNfaHVn
ZXRsYl9lbnRyeV9od3BvaXNvbmVkKGVudHJ5KSkpIHsNCj4gPiArCQkJYm9vbCB1ZmZkX3dwID0g
aHVnZV9wdGVfdWZmZF93cChlbnRyeSk7DQo+ID4gKw0KPiA+ICsJCQlpZiAoIXVzZXJmYXVsdGZk
X3dwKGRzdF92bWEpICYmIHVmZmRfd3ApDQo+ID4gKwkJCQllbnRyeSA9IGh1Z2VfcHRlX2NsZWFy
X3VmZmRfd3AoZW50cnkpOw0KPiA+ICsJCQlzZXRfaHVnZV9zd2FwX3B0ZV9hdChkc3QsIGFkZHIs
IGRzdF9wdGUsIGVudHJ5LCBzeik7DQo+ID4gKwkJfSBlbHNlIGlmICh1bmxpa2VseShpc19odWdl
dGxiX2VudHJ5X21pZ3JhdGlvbihlbnRyeSkpKSB7DQo+ID4gIAkJCXN3cF9lbnRyeV90IHN3cF9l
bnRyeSA9IHB0ZV90b19zd3BfZW50cnkoZW50cnkpOw0KPiA+ICAJCQlib29sIHVmZmRfd3AgPSBo
dWdlX3B0ZV91ZmZkX3dwKGVudHJ5KTsNCj4gPiAgDQo+ID4g
