Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AFF56959C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 01:06:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233846AbiGFXGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 19:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbiGFXGb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 19:06:31 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2066.outbound.protection.outlook.com [40.107.113.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416B42B24E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 16:06:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gmw5mAig/nagYP92AFhnfqTjElghopCEDqNpuG6TcoW4Vvbj1nT+g91EHuP9CVrsAq8StXVStQhri8q0FVrXJUHnBOE2uqufDca6SsL6jVDStCoUn7gydiFpNWZc14Ef9c7tSOhZIcvTL147UsA+rnaml+6+chzdKDrQOEn8owr0UzQOMGdEunriya1crAzC61hCSQiXk5c8KN3gA50DLY51ci070jLt0pYqac90npC3Mwg+802xSLElrc1tHZAcFL2xDILySBOSxwi/wxbEpSaCWJ0CyxWYf4qa1TugYmLuDnRWk5sqDbZaI/shaxXHnXt1c/fLqgxTmELZXQrcyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GwqcCfhzUNfCdObMhTQP3hYfWINRj7742RQ88apcQMY=;
 b=bCI1b2+RWjt85bcxM53NTBVL8ao8yMZhzxJi0jShGqSnPv5giz0gDw+Sav7xYPdjmFDPXygAaeAgKFvH7+k2htr3mQwraqqNGFdD5ayyVEvpy6YM1fDM/xKQjX8rVdCUnDfILRll+w8AZrzSuo4nbaF04ucSESj/eLtj1nyBm7u9nSNMSxs2FlGuq5nz8fucxPmUwNm69wqXsZWseK9w+cLiIshDLZgaJ/9YGWstnj3ZfJMfe3xVWrAGAogUuRbxGtzT2S8iGK8d+9pDD5IYvv1yl4sG5nve/mvvGqlETI4WoE8zuHubUXEhrCsrExJs75GtUwyNICOfqm+3tVgi3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GwqcCfhzUNfCdObMhTQP3hYfWINRj7742RQ88apcQMY=;
 b=dSpjqzhqH37ZSA9Z6P+r0PzcySxry7y/ga7+ro6eiUMn0p5t4GtHlyJtupMV4+TjYB49rLrSEWyfKvKwKsUThuwa/lJ+GlHDl1YtvHC2Bb6LyzTMGreZLW3r87KheblMcMfsOLqJXh5lyjvrLXZ2XoH6CmMUkRjM67q0+f17wec=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYCPR01MB6654.jpnprd01.prod.outlook.com (2603:1096:400:9b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Wed, 6 Jul
 2022 23:06:28 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836%6]) with mapi id 15.20.5395.021; Wed, 6 Jul 2022
 23:06:28 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [mm-unstable PATCH v4 5/9] mm, hwpoison: make unpoison aware of
 raw error info in hwpoisoned hugepage
Thread-Topic: [mm-unstable PATCH v4 5/9] mm, hwpoison: make unpoison aware of
 raw error info in hwpoisoned hugepage
Thread-Index: AQHYkOR4nIqzf3Z5RkmHICXrERFsHa1x+EGA
Date:   Wed, 6 Jul 2022 23:06:28 +0000
Message-ID: <20220706230627.GB2560241@hori.linux.bs1.fc.nec.co.jp>
References: <20220704013312.2415700-1-naoya.horiguchi@linux.dev>
 <20220704013312.2415700-6-naoya.horiguchi@linux.dev>
 <9aba706c-b38f-f887-486e-b60c0025d9d8@huawei.com>
In-Reply-To: <9aba706c-b38f-f887-486e-b60c0025d9d8@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c15e4ad6-918b-4bd3-9371-08da5fa42881
x-ms-traffictypediagnostic: TYCPR01MB6654:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xd85y3PSyxegYIkLDyDoYhXK/a95UA8IQF26YFH5Co2XRTKkdptbgsfLpLiH8a9vV5dmgvgPAK6mQHy5emTn76zY+hdIfBfmM1ZCfpCD25WR9SX4O8pN4mIrYpvdzxO089dXJ4OwBra1uxGspZSVhCaYxT27ORwImu2qDGAhsk12/OJrMZUN+8LtkvRpTuDO4GPuH4ADCppjmjrMkZQWuQRiaf5zA22XXFDShYPgYq0sVenUoDysD2kFkMd9NAZX75s/YwZicxLQ4/0o+ia0MWqBTsisCQyV1KMLqKHXt/rwZQVcyr/vz28Mi3C5+tDPmklq3SJTUnG5asSIDYho/w5WWwAjzWBdoUBNaSLD0jecYAcQ7VqF0/YLwfz95TloL9KosGq8DkbKHVPU+f9PJICBBcF8OWOj6qrmYaXpxQdV74TcDSgWmc8LzdH0O0X+/Wc8NVOFpw4yNKtpr6ZNbw8r2/suA1TRTEE6kziCmYvagsHr9WjeeMhMm6b0sRvf/1yo/q5ZBdjJr0AMo8LiEVbd+2Vopaoj906iftzj40rDmbAsiRq2uA9mb2FdNExX1xSgYyEB0zEND1AU/nVOr3Zx6IZmPWTSTA9zrdzrHZSOgl6wxVjUbI5wEdJd605ffvPIpm9K8HCJ5Z0LwlQbEdpV6xhaD7TPNNF2WIEOdcLz/Jzy60O0Fx8+kYVLmabCbKExREz4Nj5XgY81PzLKMIGi+KG7vzqWIk5eCQ+Q7WFSt0iS11GF5d291NDXzBIeN9d56czmUZJBMWD3a2ZBYMDmwvrG/040e3mmgIk6aGe4gtO8tBfCxLyJTMtK84CbLvJuR/7OrzU/ePEey1TN5xO/GBFrO4tVPluZytv7pwY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(76116006)(66556008)(66476007)(66946007)(6916009)(8676002)(66446008)(41300700001)(53546011)(6506007)(55236004)(33656002)(38070700005)(82960400001)(4326008)(38100700002)(64756008)(122000001)(86362001)(1076003)(186003)(8936002)(71200400001)(5660300002)(7416002)(6486002)(2906002)(316002)(6512007)(9686003)(478600001)(26005)(83380400001)(54906003)(85182001)(309714004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnA1T01lL3dPNGhsanJkc1Jzdi9HaDVXVFN3bTZraDVZN2oyZTdZSngyQUlo?=
 =?utf-8?B?OG5FbnlrTkNUY2lqUEIvT295NnNpemUwRHAvaE5vQThvVnFjLzNnaW5iRnhx?=
 =?utf-8?B?MGpIUW55ZC9GelhyRkYybWZLRHAyQ3c4T1JYR2Rkc3NzWjB0cUxUa2htd1pG?=
 =?utf-8?B?RlZBNUJ1TVBzWjM4dU9hZlN3TVBpYnBQb2lDTGluQmdJMWtaVGtOS01oQmdI?=
 =?utf-8?B?R012OENvRG0xQVJFd2t6bmZTbVpKeE1DVGt6b05tZysvK1FycTVQdFV3eTNi?=
 =?utf-8?B?c0Q5cnd4QytGVllCRHF4UUVZOEZONjlRNERFTklmVy9QMDhYaFBuVjBiVTRm?=
 =?utf-8?B?WW4wSTZMWTdxWUNwWWN3WnZMS2FqL2l6TFdKUVBJUlhIakZDQ0xYSksvQWZa?=
 =?utf-8?B?Z0FyNFB4QW5VdFFncEQ1S1pUdW9VYVJPcDNJc1BnV3lEaUVnRFlEVmN2d0NS?=
 =?utf-8?B?Y2dXY0lQemhvMkZ6aXpnTVI3ZDFLaHhzOWxwaDZBN2ZCZ0F1elRzOUZYcjVy?=
 =?utf-8?B?WGk4OW8wcUIxVnlXRTUyaUY0ejJMSG93SjlNWHNaSUNpZ2pZNitNTG5RM1o4?=
 =?utf-8?B?R2dEb2pPQ3lneFcrQlFTTjFjUDhhZlJFWUFRSWFKbmgxanA1UnZtZkFSTVpp?=
 =?utf-8?B?WmRLZ0NTUkdWc3pleEh6dTZPdHJxYkVXbkREc0MvU1J5TEdkQ1lnV21jc1Jk?=
 =?utf-8?B?U2t5VEh3MVNveDNEajVYck51Y1BlUzEwR20rMnd3ZlNkWS9FaHVVZENoZ1JC?=
 =?utf-8?B?czNtZ3JrUUIxZnlGRTBkbldnRUN5RTJZVGcxbEdvaXNwZ2o5d24xUnRKR0tp?=
 =?utf-8?B?VzlDMXpQbnJrb2FmdGx5WHRWenJmZGV0SGdpNmNXb2Q0ZDFkTmtLSGl4Z1RV?=
 =?utf-8?B?ck9tdCtJN3NoMm5ub0sxYStkS0JndjFaS05rRjJTUU5XeEJzbllYVmR1TTF6?=
 =?utf-8?B?ZUhSdGJiQWh2VWRPZVR0Rmh2aUpmSS9vdU9HV1kvVENHdXpmYVBxK1FLUlcv?=
 =?utf-8?B?MXdQZ2tIaEtVVmw1SjJJZ0NpeUZ2Q2w5dDZQRmUyai9ta1dtMzY4TkhsemNw?=
 =?utf-8?B?NHFlUFZUWWN0MEUzNEd3MEQwek5qTnd3OFhLc0VWWFVLSk5xbTluMm1oVFB4?=
 =?utf-8?B?YWtzOWg2U1hkbEdMUTlTTkovbEJxanpBRFd5NEZQSDc2N1JCQmZubVJSMnJr?=
 =?utf-8?B?a3h1TDNoUTBkT3ZzblNFZUQxVkd0OVJzSzJuVkpkSjc0bDV0czYxL2dpTjAx?=
 =?utf-8?B?SXhhNHlPOFN1SzJwZUVCbGxYaUxEUGpuREtXNGV2VHRzNUFwSzhua2h3M3dw?=
 =?utf-8?B?dnRWVUd3U3YvYldseG43RG0wbnV3anhBUFpWNGZ5N3BjVTFteTNYMHh2ZVhZ?=
 =?utf-8?B?VENFRGV3UE15VEVlTVRSM1RQeW9odW5MWGlEa2VzN1BsRXJHbmFQbmtOa2hi?=
 =?utf-8?B?ZnFacUZqSDRZN2EySnpia2M4NnlNSEpneE5yeVRYTFREcjY1MW0vR3pSc3hP?=
 =?utf-8?B?SmdyU1Z4TlpPVDJnRHRGNy9jSENKU2RINFI3M2ZhM0ZyV0RMdnJ0b2lCZ0RS?=
 =?utf-8?B?SnZLUjduVzkrTFkvS0ZIVTcwRWV5Mm54MkdsSldvbnp4cU9vdVg2Vm5GL3BO?=
 =?utf-8?B?MlJ6OU0zaksyV28xZEV2R09nUzQ5NXJyKzJCNVBiVkNleDhBYU0zQ0l3YlNi?=
 =?utf-8?B?bU0zUWt6M2RsbXo5KzNPQlVHMHdlQjZNcXpadHJWYldtbzR2bzlYY1kxU1pm?=
 =?utf-8?B?UWUvcEZZVVZuWkE0eFJKaVB1QWRxcDN6SHU5aGZ2SWlQUVdFUWlLSUtlNTk5?=
 =?utf-8?B?WDFOdk5WK3hFdHA4bXdOKzVndVRWVUYxQlBZeHgyUmN5NlNNRVBUMStNTVFG?=
 =?utf-8?B?dE9lOEdiMzJJeitlU2NEWG8wQVIwa1dKN2I1Rm03RnMwblRnN25RMjhXWEFI?=
 =?utf-8?B?VVA4TDhtdmEwZ2JPZUdESjMzbzN5eHFzVEZ2ZVRBTjBxSjg4Y3gyZXhOZmNq?=
 =?utf-8?B?NVNpeWVFUEF3bVY4cjd3NWc1S1FoQ3lycmU0WkVmWTBYOHRwandtWTUxbDh4?=
 =?utf-8?B?RU5XbldGdFBFMVZBcjdIUFc3N2h3QlRMbmJPVS9ETWtNM2xXSUlXV3k1aHVN?=
 =?utf-8?B?d29kS2RBb0RmSlNxS2l5eWE4RzRaczJHOFhIZTR5SjQzRWQvWEVUQmlaNVRk?=
 =?utf-8?B?OWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <403793A40143CE47AD6AC87FF1A793D7@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c15e4ad6-918b-4bd3-9371-08da5fa42881
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jul 2022 23:06:28.4889
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WCkBLLniG20T3nGvT9xVoxlMSIhBU1OMPDM4vDOTu2nuJ4tPS076ZZjufRN8lYsQw95vtTjMbUSKvYDHi4sxnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6654
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBKdWwgMDYsIDIwMjIgYXQgMTA6NTg6NTNBTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi83LzQgOTozMywgTmFveWEgSG9yaWd1Y2hpIHdyb3RlOg0KPiA+IEZyb206
IE5hb3lhIEhvcmlndWNoaSA8bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+DQo+ID4gDQo+ID4gUmF3
IGVycm9yIGluZm8gbGlzdCBuZWVkcyB0byBiZSByZW1vdmVkIHdoZW4gaHdwb2lzb25lZCBodWdl
dGxiIGlzDQo+ID4gdW5wb2lzb25lZC4gIEFuZCB1bnBvaXNvbiBoYW5kbGVyIG5lZWRzIHRvIGtu
b3cgaG93IG1hbnkgZXJyb3JzIHRoZXJlDQo+ID4gYXJlIGluIHRoZSB0YXJnZXQgaHVnZXBhZ2Uu
IFNvIGFkZCB0aGVtLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IE5hb3lhIEhvcmlndWNoaSA8
bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+DQo+ID4gLS0tDQo+ID4gQEAgLTIyODcsNiArMjMwMSw3
IEBAIGludCB1bnBvaXNvbl9tZW1vcnkodW5zaWduZWQgbG9uZyBwZm4pDQo+IA0KPiBJcyBpdCBz
YWZlIHRvIHVucG9pc29uIGh1Z2VwYWdlIHdoZW4gSFBhZ2VSYXdId3BVbnJlbGlhYmxlPyBJJ20g
YWZyYWlkIGJlY2F1c2UNCj4gc29tZSByYXcgZXJyb3IgaW5mbyBpcyBtaXNzaW5nLi4NCg0KQWgs
IHJpZ2h0LiBXZSBuZWVkIHByZXZlbnQgaXQuICBJJ2xsIGZpeCBpdCBieSBpbnNlcnRpbmcgdGhl
IGNoZWNrLg0KDQogc3RhdGljIGlubGluZSBsb25nIGZyZWVfcmF3X2h3cF9wYWdlcyhzdHJ1Y3Qg
cGFnZSAqaHBhZ2UsIGJvb2wgbW92ZV9mbGFnKQ0KIHsNCiAgICAgICAgIHN0cnVjdCBsbGlzdF9o
ZWFkICpoZWFkOw0KICAgICAgICAgc3RydWN0IGxsaXN0X25vZGUgKnQsICp0bm9kZTsNCiAgICAg
ICAgIGxvbmcgY291bnQgPSAwOw0KIA0KKyAgICAgICAgaWYgKCFIUGFnZVJhd0h3cFVucmVsaWFi
bGUoaHBhZ2UpKQ0KKyAgICAgICAgICAgICAgICByZXR1cm4gMDsNCg0KVGhhbmtzLA0KTmFveWEg
SG9yaWd1Y2hpDQoNCj4gVGhhbmtzLg0KPiANCj4gPiAgCXN0cnVjdCBwYWdlICpwOw0KPiA+ICAJ
aW50IHJldCA9IC1FQlVTWTsNCj4gPiAgCWludCBmcmVlaXQgPSAwOw0KPiA+ICsJbG9uZyBjb3Vu
dCA9IDE7DQo+ID4gIAlzdGF0aWMgREVGSU5FX1JBVEVMSU1JVF9TVEFURSh1bnBvaXNvbl9ycywg
REVGQVVMVF9SQVRFTElNSVRfSU5URVJWQUwsDQo+ID4gIAkJCQkJREVGQVVMVF9SQVRFTElNSVRf
QlVSU1QpOw0KPiA+ICANCj4gPiBAQCAtMjMzNCw2ICsyMzQ5LDggQEAgaW50IHVucG9pc29uX21l
bW9yeSh1bnNpZ25lZCBsb25nIHBmbikNCj4gPiAgDQo+ID4gIAlyZXQgPSBnZXRfaHdwb2lzb25f
cGFnZShwLCBNRl9VTlBPSVNPTik7DQo+ID4gIAlpZiAoIXJldCkgew0KPiA+ICsJCWlmIChQYWdl
SHVnZShwKSkNCj4gPiArCQkJY291bnQgPSBmcmVlX3Jhd19od3BfcGFnZXMocGFnZSwgZmFsc2Up
Ow0KPiA+ICAJCXJldCA9IFRlc3RDbGVhclBhZ2VIV1BvaXNvbihwYWdlKSA/IDAgOiAtRUJVU1k7
DQo+ID4gIAl9IGVsc2UgaWYgKHJldCA8IDApIHsNCj4gPiAgCQlpZiAocmV0ID09IC1FSFdQT0lT
T04pIHsNCj4gPiBAQCAtMjM0Miw2ICsyMzU5LDggQEAgaW50IHVucG9pc29uX21lbW9yeSh1bnNp
Z25lZCBsb25nIHBmbikNCj4gPiAgCQkJdW5wb2lzb25fcHJfaW5mbygiVW5wb2lzb246IGZhaWxl
ZCB0byBncmFiIHBhZ2UgJSNseFxuIiwNCj4gPiAgCQkJCQkgcGZuLCAmdW5wb2lzb25fcnMpOw0K
PiA+ICAJfSBlbHNlIHsNCj4gPiArCQlpZiAoUGFnZUh1Z2UocCkpDQo+ID4gKwkJCWNvdW50ID0g
ZnJlZV9yYXdfaHdwX3BhZ2VzKHBhZ2UsIGZhbHNlKTsNCj4gPiAgCQlmcmVlaXQgPSAhIVRlc3RD
bGVhclBhZ2VIV1BvaXNvbihwKTsNCj4gPiAgDQo+ID4gIAkJcHV0X3BhZ2UocGFnZSk7DQo+ID4g
QEAgLTIzNTQsNyArMjM3Myw3IEBAIGludCB1bnBvaXNvbl9tZW1vcnkodW5zaWduZWQgbG9uZyBw
Zm4pDQo+ID4gIHVubG9ja19tdXRleDoNCj4gPiAgCW11dGV4X3VubG9jaygmbWZfbXV0ZXgpOw0K
PiA+ICAJaWYgKCFyZXQgfHwgZnJlZWl0KSB7DQo+ID4gLQkJbnVtX3BvaXNvbmVkX3BhZ2VzX2Rl
YygpOw0KPiA+ICsJCW51bV9wb2lzb25lZF9wYWdlc19zdWIoY291bnQpOw0KPiA+ICAJCXVucG9p
c29uX3ByX2luZm8oIlVucG9pc29uOiBTb2Z0d2FyZS11bnBvaXNvbmVkIHBhZ2UgJSNseFxuIiwN
Cj4gPiAgCQkJCSBwYWdlX3RvX3BmbihwKSwgJnVucG9pc29uX3JzKTsNCj4gPiAgCX0NCj4gPiA=
