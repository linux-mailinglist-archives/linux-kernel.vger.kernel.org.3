Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC814E4D43
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 08:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242206AbiCWHX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 03:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232982AbiCWHXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 03:23:53 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2072.outbound.protection.outlook.com [40.107.113.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AA47305F
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 00:22:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QL0gPCPlRcKxvPNA1NlamG3GLBHx0dVnrwmI8J29D3Fcy6AdCPnL6qqUOaXzgB9ZiQa7zBhr+VXp32yJUyKee4ySZBR8/xuh8ahCX+G+HO3Tzl7h5pnvJ8E4m91E3e/Yp8wPyj2wkRrwxnSlV4GS7J6H3i9wK2MFlfg0Nu+bJ11abGrVI/WnJwjn7RJK/flPET9H5oBaYniSV7j/mieKTwXEUV4kFfcUegsI3obximGpJ6eTJC7DkVj5CtUsD7w+q8MPUDZTKNp61mxMuoGmL741xyAxs//Bqr9V4o5ADFUu0jvhq2bLzPD1CNX1HDDooAWfdCUJvIJCFqthPrf9UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73RcC6jzPPlNPbOVHCl2Hr3gv2bo8uqHT7NkLplocnc=;
 b=QcSWmqZ+HIVTAsY1FLE+lHO79Vg+yaszbujEIbCdYMA1rsSa84rHu6APgP0NXWw0ncyYqhtuGR6wGvo97SWRM3PFaqUHj8kwsXC5S32gXfv4CNTx9B9qyJc7Nsk+EQnhCO8+We34Y7tOKnEUXb6JEDjRlAq9CC62EcOa/4Dp9J7Si84X6zuGJouqD2jy4mspoz2exg+8PshDjCkVpSUSKBRhtunmZEwMQdjqfVFXblmpmOyO37icu7VnIpmrqn/6MTWwrdV2RIncYZHSBTGXi87al9l9qQbpp3WvjtaETnS/mdU2PSKkW9NVoBso4uFX8IetW18z9xn5gNOgXiU3qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73RcC6jzPPlNPbOVHCl2Hr3gv2bo8uqHT7NkLplocnc=;
 b=T2r4UJq+PJowOh22z21cFCERa/kiAwDdCC3O5Y699dejY71mT9QHzlTxYLQ86MFdmc4wCbaK8lrhD1Omiva3miTqO2gBwiSh0MXOvHXyFdQDn8LzbuDImfsY3brXS4KfsHGjSo7weFs3TbXtYDDIPoAOhco1puUKC8WtnGwarTM=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYCPR01MB5744.jpnprd01.prod.outlook.com (2603:1096:400:45::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Wed, 23 Mar
 2022 07:22:22 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::cdeb:f61:5132:905d]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::cdeb:f61:5132:905d%8]) with mapi id 15.20.5102.017; Wed, 23 Mar 2022
 07:22:22 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Yang Shi <shy828301@gmail.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5] mm/hwpoison: fix race between hugetlb free/demotion
 and memory_failure_hugetlb()
Thread-Topic: [PATCH v5] mm/hwpoison: fix race between hugetlb free/demotion
 and memory_failure_hugetlb()
Thread-Index: AQHYPYZPUV0YUqyZX0uAEo2rlZPAm6zKtYUAgAHc5oA=
Date:   Wed, 23 Mar 2022 07:22:22 +0000
Message-ID: <20220323072221.GA237485@hori.linux.bs1.fc.nec.co.jp>
References: <20220318051612.271802-1-naoya.horiguchi@linux.dev>
 <CAHbLzkrYf=jF2ZGLur5JpB_smoUkp51e2x1v5mr3CD5z73D=Ow@mail.gmail.com>
 <20220322025528.GA188243@hori.linux.bs1.fc.nec.co.jp>
In-Reply-To: <20220322025528.GA188243@hori.linux.bs1.fc.nec.co.jp>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e2b51f2-8f70-470c-5f0e-08da0c9ddf68
x-ms-traffictypediagnostic: TYCPR01MB5744:EE_
x-microsoft-antispam-prvs: <TYCPR01MB5744F9CDCB3E741DB73F9DCCE7189@TYCPR01MB5744.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JuleSk2wEVloEoGvQS3/zlDgF79CkqQOC1VzfNw4bJqzIbq6goUcKQp9exaMbnDEWOgmGBU+DvOr+Ak0n9ZblkQGvBOADDDooUs5N2Q32s8unUkInPA8FYzp1VwfGR7V30SHkFbaq4BMcNpFDltJ6zg6chY3MDeuGZFAtw6qk4/ohyMSCTnVOx8ZWtriDw070+hJ/LPetVDs+enPp4C7buxp7OuSrYwAsQzeVN0TJMl+x0ncdSxHkv1WQrbWYlwEA6uRmsDHqhpscSmV/JDLYxiqO7xKthsUGKqnAX7APAVS1N+kP8DKUDVgXfDj5Az0McCHnBzkBIMl7OvgOM5Fh8njg5IaU1Vtb0KalyAyF3od2Ah7tD85c7aCfz+xlnC7tFfnhON4VwBpjPU+hkGO+TxDAOksEgYPTyGaIuKWThd6uPC+RdGr/XwFZ5Vg5NfVGzGSPo2mt94p84PzYQ8N0mGqqsfkFV5iO3kjhQjg/L4gQ6C+By0qCSkVQcltyrIWU4pt9uUWTqxEWW18T1WxEt04adiKDN4dzvvvHQ0/eY78kzrYHGak7lZeWb4o9gpgkjRwgqG5aiKQkYscBDMf+30AgqOIg0jDfm4/Zmb8OHXrLt26CVLFxEXeMp1bMdSj4e9VTcuylqCJUvtWH7sk2D8TBSrzaRKNJ9VawvtCiYbXFC2ksY0s2A06jTp9715u9J2UHb6h7Y5s3Thmx+UQOQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(186003)(2906002)(6916009)(54906003)(1076003)(508600001)(33656002)(316002)(9686003)(6486002)(6512007)(53546011)(55236004)(38070700005)(6506007)(122000001)(71200400001)(82960400001)(66946007)(38100700002)(86362001)(76116006)(85182001)(8676002)(83380400001)(66476007)(66446008)(8936002)(64756008)(66556008)(5660300002)(4326008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cWdVOGNDeVBMTjc4dElWMjRheHVITDhwYzZFR0xtbEl6MmFZbzFpcTl4eHJx?=
 =?utf-8?B?NlNuMzVQZzNUdlhEZ3dOQW5Ycjl4dTJvTlkyNHNWa2U2cHJ0dU5uQmxlMkpB?=
 =?utf-8?B?Q0FjaUxUWFc5VWFDZG92WFpSaW4yRGhwMzhJNEpxK09nekl6aHdyWElDM2R6?=
 =?utf-8?B?elJjZXR1UG91bEw5cEhKYWw2d3RXU3d2ZHY3bWw1QVVkV3F4THhGN2xqN0Yx?=
 =?utf-8?B?d3lSWDBlMnVMRnlOblBTRkIrU2NMQlhrOFRiSjhjRG5Sb3E0YXY0d2VmcHdQ?=
 =?utf-8?B?aHJnV2lydFlzTE1qalNLS3pnVHlCRStoUzdIRXZ6VEhPZ0pvM2twdFV3K2ZI?=
 =?utf-8?B?NjlvektsSSs3TUN6WHZ1YkdlSHhKWHJtcE9QTGN6aUV0aXJ5SFBUY25YS05T?=
 =?utf-8?B?cHliWHRlNFpUUVk4TDBRcG1jVjB6U1hURXh6OFNscHJ0ZUhydVdEWnd2bm0r?=
 =?utf-8?B?QkRIcmFVYURIQkJNWlZ6N3B3WEd6TFgwMGRtN1kzZDZCRUdaYlFVMHNrTlNM?=
 =?utf-8?B?MHdjS3JFZGc5aUZ2bTZseC81eHlGR2hXbHNVRHQ5cFA3aGRaenZDNDA0Smlk?=
 =?utf-8?B?Z04zYnRsdDVXNVNIQldsdWFXbWx2UGQ4bGwxVkF1SmtmOG5xQnEvVW5HdGgv?=
 =?utf-8?B?bmo3blBkTXJKYVRrcHNjUDdTZ2w4QjBMOVVSV1lpRHJseWNNMS91TjRhY0xk?=
 =?utf-8?B?TWp2UW5NaEFjRTMybXhPajgzcS82M1JMalVOenIvLzJCUm1lWk03a05YeFRM?=
 =?utf-8?B?TTdqMCt5WDlWYUNpWWl6ZU5FZDRhYStuOGFWVWllV3QrL3RZV3crWFltLzZy?=
 =?utf-8?B?dDZTQU9vSElrZTNXbmJUdHdheG01UVVmK0cycVRFUzcwZzVSQ3lyNVorRVUw?=
 =?utf-8?B?SG55bXVSYnhrSFFKMklQTmpmaW5sTkNCWDkweHFyVXhMb1NCSlFudzNoQllj?=
 =?utf-8?B?bmlaVi94K0lHaXo5TC9OYjBRZG9zUHBudUdFcXEyVllONVJFT01JWjVrVjdS?=
 =?utf-8?B?VUZZb25nMVB6c29XNUtldS9mTGJNMHhuN0Q0ZFU4MHF6K052VUh3c2pBM0F3?=
 =?utf-8?B?U04vUVd3RjBhYlF5YXdXVkRKY01rWVYxZ0EzY0J1QS9vZ2o0YWhBYXFOM1dq?=
 =?utf-8?B?Qys2ZTU4R1FhekN0TGJDOVdwRjFyUTNSMWZEaG9senplSkpZekFoQXdBWHhL?=
 =?utf-8?B?U2VURzJ1QlpVeFJjU3JjOFVhN2orSy9tWVI5ekgzZmRLQTE2VWthQS9DK0JU?=
 =?utf-8?B?VTFKL05lZlJsS3JpWE9Sd0oyWmI1eHZzZ2ppaWFSN3BVRFZramxoZU1NQyt4?=
 =?utf-8?B?YlJlZlBKdGY0em9uTG9lRnFwYi8ydkFUbkRGV3FHUmxvbUtxekxQa2pNRTA1?=
 =?utf-8?B?d2ZKK055MFBkSW1ySyt3OXdXSThGRG43b0p2QUN3Znd3UEdEa2FpbEIyR1VW?=
 =?utf-8?B?TUx3VWsxajlrN3FPckdTTGc3U240QTJvNU11OUxVYzhxbVBwR3dyY2Zva3pT?=
 =?utf-8?B?ZXFoVW91dHlhT2hJRlp6WlhjZEorUjRMQTkrdWF6eS9Qa3dUVEplM1JJb2Mw?=
 =?utf-8?B?aWtFUFh5NlRMd2Z5a1Y2Y05UZFdzL1dRZlJjanFGRCtaY3lQVTBpUkp3QTRw?=
 =?utf-8?B?dkVpcXo0OThqY0VHMFJVM3Bpc1ZtSllhNWd5WjFBeUNCdU9NeG94dW53dkYw?=
 =?utf-8?B?Sm1lWEJDQUFDZFRZMERhTC9vTEFhSjdQNVRTSEVJVnVwZ1JjSGZVdlR2M242?=
 =?utf-8?B?L1F2VkdEM0ROOWxTdzRKU2s4MUMwa0xSdjEwaDAyU1BHSlpCeDd1WVRDNkJo?=
 =?utf-8?B?Y2w3aXk3dkZDWmRnWkttVzIwRmdsRUhEQVFYRGE4ODRvVHhDcFkrblg3OWRY?=
 =?utf-8?B?MG1tbURFMFBzUXVZSHF2WmdTOHpLRWc0Vlg3OUJJZ0gxcXJrMjdHcjNhbURZ?=
 =?utf-8?B?SkVyYm5GbGkxNm1seXpFSGNGQ1dwODdhR1NFK2gzTUM0T1lyczFYLzVPVWJX?=
 =?utf-8?B?VHk4MEJYclZRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B066EEAFCB371049ABA57A6DE1DE259D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2b51f2-8f70-470c-5f0e-08da0c9ddf68
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2022 07:22:22.1089
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0BtML8EITrm4Ny78TRssUB/GQj9BsMCj/YtY6nfQEAS7foWxXM0ZQuIUV1TK79UCKv7Rc92vZWWNhfuJHv1Emw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB5744
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCBNYXIgMjIsIDIwMjIgYXQgMDI6NTU6MzBBTSArMDAwMCwgSE9SSUdVQ0hJIE5BT1lB
KOWggOWPoyDnm7TkuZ8pIHdyb3RlOg0KPiBPbiBNb24sIE1hciAyMSwgMjAyMiBhdCAwNTo0Njo0
OFBNIC0wNzAwLCBZYW5nIFNoaSB3cm90ZToNCj4gPiBPbiBUaHUsIE1hciAxNywgMjAyMiBhdCAx
MDoxNiBQTSBOYW95YSBIb3JpZ3VjaGkNCj4gPiA8bmFveWEuaG9yaWd1Y2hpQGxpbnV4LmRldj4g
d3JvdGU6DQo+ID4gPg0KPiA+ID4gRnJvbTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3Vj
aGlAbmVjLmNvbT4NCj4gPiA+DQo+ID4gPiBUaGVyZSBpcyBhIHJhY2UgY29uZGl0aW9uIGJldHdl
ZW4gbWVtb3J5X2ZhaWx1cmVfaHVnZXRsYigpIGFuZCBodWdldGxiDQo+ID4gPiBmcmVlL2RlbW90
aW9uLCB3aGljaCBjYXVzZXMgc2V0dGluZyBQYWdlSFdQb2lzb24gZmxhZyBvbiB0aGUgd3Jvbmcg
cGFnZS4NCj4gPiA+IFRoZSBvbmUgc2ltcGxlIHJlc3VsdCBpcyB0aGF0IHdyb25nIHByb2Nlc3Nl
cyBjYW4gYmUga2lsbGVkLCBidXQgYW5vdGhlcg0KPiA+ID4gKG1vcmUgc2VyaW91cykgb25lIGlz
IHRoYXQgdGhlIGFjdHVhbCBlcnJvciBpcyBsZWZ0IHVuaGFuZGxlZCwgc28gbm8gb25lDQo+ID4g
PiBwcmV2ZW50cyBsYXRlciBhY2Nlc3MgdG8gaXQsIGFuZCB0aGF0IG1pZ2h0IGxlYWQgdG8gbW9y
ZSBzZXJpb3VzIHJlc3VsdHMNCj4gPiA+IGxpa2UgY29uc3VtaW5nIGNvcnJ1cHRlZCBkYXRhLg0K
PiA+ID4NCj4gPiA+IFRoaW5rIGFib3V0IHRoZSBiZWxvdyByYWNlIHdpbmRvdzoNCj4gPiA+DQo+
ID4gPiAgIENQVSAxICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBDUFUgMg0KPiA+
ID4gICBtZW1vcnlfZmFpbHVyZV9odWdldGxiDQo+ID4gPiAgIHN0cnVjdCBwYWdlICpoZWFkID0g
Y29tcG91bmRfaGVhZChwKTsNCj4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGh1Z2V0bGIgcGFnZSBtaWdodCBiZSBmcmVlZCB0bw0KPiA+ID4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYnVkZHksIG9yIGV2ZW4gY2hhbmdlZCB0
byBhbm90aGVyDQo+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBjb21wb3VuZCBwYWdlLg0KPiA+ID4NCj4gPiA+ICAgZ2V0X2h3cG9pc29uX3BhZ2UgLS0gcGFn
ZSBpcyBub3Qgd2hhdCB3ZSB3YW50IG5vdy4uLg0KPiA+ID4NCj4gPiA+IFRoZSBjb21wb3VuZF9o
ZWFkIGlzIGNhbGxlZCBvdXRzaWRlIGh1Z2V0bGJfbG9jaywgc28gdGhlIGhlYWQgaXMgbm90DQo+
ID4gPiByZWxpYWJsZS4NCj4gPiA+DQo+ID4gPiBTbyBzZXQgUGFnZUhXUG9pc29uIGZsYWcgYWZ0
ZXIgcGFzc2luZyBwcmVjaGVja3MuIEFuZCB0byBkZXRlY3QNCj4gPiA+IHBvdGVudGlhbCB2aW9s
YXRpb24sIHRoaXMgcGF0Y2ggYWxzbyBpbnRyb2R1Y2VzIGEgbmV3IGFjdGlvbiB0eXBlDQo+ID4g
PiBNRl9NU0dfRElGRkVSRU5UX1BBR0VfU0laRS4NCj4gPiA+DQo+ID4gPiBSZXBvcnRlZC1ieTog
TWlrZSBLcmF2ZXR6IDxtaWtlLmtyYXZldHpAb3JhY2xlLmNvbT4NCj4gPiA+IFNpZ25lZC1vZmYt
Ynk6IE5hb3lhIEhvcmlndWNoaSA8bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+DQo+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBNaWFvaGUgTGluIDxsaW5taWFvaGVAaHVhd2VpLmNvbT4NCj4gPiA+IENjOiA8
c3RhYmxlQHZnZXIua2VybmVsLm9yZz4NCj4gLi4uDQo+ID4gPiBAQCAtMTU0NywyMSArMTU0NSwz
MSBAQCBzdGF0aWMgaW50IG1lbW9yeV9mYWlsdXJlX2h1Z2V0bGIodW5zaWduZWQgbG9uZyBwZm4s
IGludCBmbGFncykNCj4gPiA+ICAgICAgICAgICogSWYgdGhpcyBoYXBwZW5zIGp1c3QgYmFpbCBv
dXQuDQo+ID4gPiAgICAgICAgICAqLw0KPiA+ID4gICAgICAgICBpZiAoIVBhZ2VIdWdlKHApIHx8
IGNvbXBvdW5kX2hlYWQocCkgIT0gaGVhZCkgew0KPiA+ID4gKyAgICAgICAgICAgICAgIGlmIChU
ZXN0U2V0UGFnZUhXUG9pc29uKHApKQ0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgYWxy
ZWFkeV9od3BvaXNvbmVkID0gcGZuOw0KPiA+ID4gKyAgICAgICAgICAgICAgIGVsc2UNCj4gPiA+
ICsgICAgICAgICAgICAgICAgICAgICAgIG51bV9wb2lzb25lZF9wYWdlc19pbmMoKTsNCj4gPiA+
ICAgICAgICAgICAgICAgICBhY3Rpb25fcmVzdWx0KHBmbiwgTUZfTVNHX0RJRkZFUkVOVF9QQUdF
X1NJWkUsIE1GX0lHTk9SRUQpOw0KPiA+IA0KPiA+IFRoZSBjb21taXQgbG9nIHNheXMgInRoaXMg
cGF0Y2ggYWxzbyBpbnRyb2R1Y2VzIGEgbmV3IGFjdGlvbiB0eXBlDQo+ID4gTUZfTVNHX0RJRkZF
UkVOVF9QQUdFX1NJWkUiLCBidXQgaXQgaXMgbm90IGRlZmluZWQgaW4gdGhlIHBhdGNoIGFuZCBp
dA0KPiA+IGlzIGNhbGxlZCBoZXJlLiBEaWQgSSBtaXNzIHNvbWV0aGluZz8NCj4gDQo+IFNvcnJ5
LCB5b3UncmUgcmlnaHQuICBNRl9NU0dfRElGRkVSRU5UX1BBR0VfU0laRSBpcyBkZWZpbmVkIGlu
IHRoZSBzZXBhcmF0ZQ0KPiBwYXRjaCBpbiBtbW90bSwgYW5kIGRpc2FwcGVhcmVkIHdoZW4gcmVi
YXNpbmcgKG5vdCBpbnRlbmRlZCkuDQo+IEkgdGhpbmsgb2YgcmViYXNpbmcgdGhpcyB0byBtYWlu
bGluZSBhZ2FpbiB0byBhcHBseSBjbGVhbmx5IHRvIC1zdGFibGUsDQo+IGV4cGVjdGluZyBpdCB0
byBhcHBsaWVkIGJlZm9yZSBvdGhlciByZWNlbnQgaHdwb2lzb24gcGF0Y2hlcy4NCg0KVGhlIG1h
aW5saW5lIGtlcm5lbCBub3cgaGFzIHRoZSBkZXBlbmRpbmcgcGF0Y2hlcywgc28gbWF5YmUgcmVi
YXNpbmcNCnRoZSBwYXRjaCBvbnRvIHVwc3RyZWFtIHNob3VsZCBubyBsb25nZXIgY2xlYW5seSBh
cHBsaWNhYmxlLg0KKFRoaXMgaXMgZHVlIHRvIG15IHBvb3IgcGF0Y2ggbWFuYWdlbWVudCBpbiBt
bW90bSwgc29ycnkgYWJvdXQgdGhhdC4uLikNCg0KQXMgcG9pbnRlZCBvdXQgYnkgTWlrZSwgdGhp
cyBwYXRjaCBoYXMgcmVhZGFiaWxpdHkgaXNzdWUgc28gdGhlIGJhc2UgY29kZQ0KbmVlZHMgKG1h
eWJlIHN1YnN0YW50aWFsKSBjbGVhbnVwIGFuZCByZWRlc2lnbmluZyBhcm91bmQgcGlubmluZyBw
YWdlcy4NClNvIEknbSBpbmNsaW5lZCB0byByZWRvaW5nIHRoaXMgZml4IHdpdGggbW9yZSBjbGVh
bmVyIGZvcm0sIG5vdCB0YXJnZXRpbmcNCnRvIHN0YWJsZS4NCg0KVGhhbmtzLA0KTmFveWEgSG9y
aWd1Y2hp
