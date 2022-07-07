Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16352569711
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 02:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbiGGA4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 20:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbiGGA4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 20:56:20 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2044.outbound.protection.outlook.com [40.107.113.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE542CE26
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 17:56:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQsv1HCpqtkuWUvtZTbqmMrkWZ/+U3R7Zaj/LtRGVOzoX+DAU17XmL7q/l2uo1jVyvkL8Bw1of3xuaozSjR8WtTVPxHwmTz70rg3Fj2frp2JaissN/RfeLRwKk+7LL7/dlBdwDVQVuyOOWTP5yyK9kVFDjkPN7yHLQIPZA4Fco3ovKBoll6Psp1RVTKLJbRWgduMuDzenNy+eLEYcCyI2ZCEpil/oV/PrwK0qiiIJTl4rZfbb2AO3GFrZlYW1U8Z4O7/fJ7gSWKjL1c0fU3tJR3x6nkmkpTfYCG9MdesK4RfyVy+7paXYA3kCqMTYVTJw+GQ6XCb+TrdZURI7zSO4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J58rRQQsQJhak1qp+O2oCaqFOnx/2WM9TdOpklbfPCc=;
 b=cJm3foYQ+KXlkA5ByQ7cxnDm1cKolOjPrM/FKTfg6IVWnyKgAVSiYWYcGU///O0ypHNqqFXGx2jx0XiWdEa80UX/uLBfWLV3POwuZe5SmlrOA6rPGVlakXEKUxO6LXbhYsvpE+IXOiW4sY1kyapNxCQmQpwBeO9RR9AXqxqRy0LqU8DQ9pR7rvy9EYk3xdkh2zfTfuyUXJdaI4TXIjTnpGvJB7GTST2aeTJki3qTYQfyfyrCZAoQOrEEOgxpb6hlkCeW+slUYaYaDkrsXS//Aa+HY/t8vkYNVVNRFX48XOGLc4Tf3OkSt17vYrbiUCl7xWX+IxDfLteJvfCdhwqJEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J58rRQQsQJhak1qp+O2oCaqFOnx/2WM9TdOpklbfPCc=;
 b=VszKLHjeuFnjL/xpRcdSOOymoiETjLb3nl48oYz6xt1m4vcVXAmy4NoXJBkq0dF5TuaAh/E0oul5SZX2+VTQPZEPMryxm7crkVuTwE9mAXytrwgwT18LCDZK4hPE5B3vGEozYETh5bI/UbQpYpDdrmm6zr2PU4ziIJ98myJhBUI=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSAPR01MB4658.jpnprd01.prod.outlook.com (2603:1096:604:36::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Thu, 7 Jul
 2022 00:56:15 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::5d07:3dbc:2b8c:d836%6]) with mapi id 15.20.5395.021; Thu, 7 Jul 2022
 00:56:15 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [mm-unstable PATCH v4 1/9] mm/hugetlb: check
 gigantic_page_runtime_supported() in return_unused_surplus_pages()
Thread-Topic: [mm-unstable PATCH v4 1/9] mm/hugetlb: check
 gigantic_page_runtime_supported() in return_unused_surplus_pages()
Thread-Index: AQHYkYJ6saw1fOUNYUuWE/DbNGRYha1yFbEA
Date:   Thu, 7 Jul 2022 00:56:15 +0000
Message-ID: <20220707005614.GA2577747@hori.linux.bs1.fc.nec.co.jp>
References: <20220704013312.2415700-1-naoya.horiguchi@linux.dev>
 <20220704013312.2415700-2-naoya.horiguchi@linux.dev>
 <YsYDxLUebryYIuwe@monkey>
In-Reply-To: <YsYDxLUebryYIuwe@monkey>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: acbbb5d3-0f6e-4e47-30f3-08da5fb37ecd
x-ms-traffictypediagnostic: OSAPR01MB4658:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /wdhwLkV6u7Ag5crfyAKUhDhsQm5F1OLseXESutrYMVJBmRR7lbVEGbaAxw0wK7CqmWI2yD4BbnVN3C05phWEy7Ag98+5ZI+5uck/5kqXMZsugsnka3cBpjgBBXHfFrcplHbR2/1NWbd4fdndjsRpwFnN7aV5nMyZsc8aS+1R65LayGljN61zMVxNsCbpXb/qILrzu4E6e+ufrlB81d07N7abqzd2wsJBjCaI0yVj7Uc5XAYjESeBLaMEi4DYKSpc9pMvvj/v3Wv6ZrJBi7pdRjWf8GdWBs789hU7xkyeWjKuPQZsttWuCPsRVKEkBfhfEYYtzcC+Zv7kQkISayqD1qkQgMZCaAghUztuLDp1vsjx5c2Ij/4efbsxT/TN8IhoxHhBqBXtet6lAQvFAJZsGeOFF9hEvPgALvGYkrw1XYFXBTMnaok8hVQwy9Jz6APxeNvm9tZ8FBLKoRmRZDSRJUg15K07Sl+N5l38t0u5aGIMt+LNxOKgYLavT7sSa1y0h5RPFP1Fjwqc8pKatKDHq1aA9r2BA7aVg5sdJluBubfbVnDkpaWlnP9V2kl/N7nTPEn6MEUNuBXs10odIrjTksQaehrxzxWCucNXoHi3ql/Mu2IB/2ZjbhICsd02USYWXWj8mZ+yTtm4axwrLZthQv3zQxz4/RRfYGHeddME7/CzXUO6lGJKMSoQ/xIcxxYa4maaOEM7PhdVGMotsMeC7TuV08ehU+q7PmbDIRcj8sUUmn4K9P6KVGaBW2GlSJkITAmOexllbCJhZjbAjPZvnHjJcZCKgqrXk3+Xr9Dgi6od5PkpM7Erg43S4sWa4+l
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(39860400002)(136003)(346002)(376002)(8936002)(86362001)(478600001)(186003)(6486002)(83380400001)(85182001)(5660300002)(7416002)(1076003)(6916009)(316002)(54906003)(38100700002)(122000001)(26005)(6506007)(82960400001)(6512007)(76116006)(71200400001)(41300700001)(66476007)(55236004)(53546011)(2906002)(38070700005)(4326008)(64756008)(8676002)(66556008)(66446008)(33656002)(9686003)(66946007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SFRCNVZURnNMOTdXY0Q1MUlLSVY2L0ptRitOSWczRzRwa2Jwb0dhdDFDcWhB?=
 =?utf-8?B?bGFrT05XRE9qTjRqdktaZDdzMTRoalJxQlZzOWpHLytGKzErcitlejBNNVJx?=
 =?utf-8?B?clRqbk5HZFRHSnJ2THcwaU85dy8yV05MSFVmZWkvM2lZcWEyanU0ZWNMMmJQ?=
 =?utf-8?B?RXRjay9seWMxMHdWSmxyUXk2ck1KKzBmelVBWGdQR0ppL2JkZGx2Mm9CU0I2?=
 =?utf-8?B?VjhNbkRnc2lLVGc0OGFKc2dNRjZNdlZrd2VHdkc4TjgxVGpjVFMxQk0wZUdE?=
 =?utf-8?B?cGlLMWpHS0QyRit1WXdIZkV2VURoSU1wN2hnS2hXNlB0R0xBWUZvNEF6ME9F?=
 =?utf-8?B?T2x3SkhtL1ZsZTdpNy9TbzdKNU9DdjBzZlhQdE1PVW9JY2lJNmJIZ2pHS2xX?=
 =?utf-8?B?SHg4SDhEMVhNaXdRS1AycDV5bUFwMUtWUFNWK1RtWGExUXpkMldjRUxnT1Mz?=
 =?utf-8?B?Q0RKRWEzQXc3bFNTKzFBRzZFaHR4dFc0eVcva1dKL25oUXdGalpFZENVQTdN?=
 =?utf-8?B?U2Y2bEp3QktON2p6QWhLL3dMWkxpUTVUMWRDRFIvbWNYM1o1M25WM0lCeUM0?=
 =?utf-8?B?ZWI1emU3MEJOalpuK1Z6OE1icmE4WFE4OFVPbmJod3crMFdqSUE1cWxzd0lq?=
 =?utf-8?B?UXhUMkdKdVk2Q2ROKzd3NmxEVkhSY21nS0xub3gxMlB6WTBqWm9XRHJiTWdQ?=
 =?utf-8?B?aFNkNU5BYUVzZitGWXZlWnJBTW9IYWVUMWVLb2xKVHQ3QUVFY2MwcVBObi9x?=
 =?utf-8?B?Q05KYlkwSzNlRWhxZmJXSXhjK1lSSmdYb2p5bStTak9DY1hwYUxWMko4NGNS?=
 =?utf-8?B?ajRWL214NUc3Wk1qMHBQZmgxdXVHODZjKyt6QkNjeSs4M2JGbE5HQThDeklo?=
 =?utf-8?B?VU1GUUNQRXRDQkkyZlpEclBZZ21VMVNObGFsWm9iOTVjRWwrUEExZ25pekt4?=
 =?utf-8?B?WW9NNXlSWXllOVE4TnZ5Vm11VlQzMm5VZHQrVlJHejJ4UDBEK0RYQWhKa3By?=
 =?utf-8?B?OVRLS0xEdk4wek9UMzJXaENFRnJ5TXIyMmhzb2pjb0xvYXZxMHE3cHNtdW82?=
 =?utf-8?B?cDBGMThwWldrbk9DcU4vTHp2K050dFdJYldQNkpZYnp1eDVmYlcxSHFZQUU3?=
 =?utf-8?B?dXFuZmxLY1JjVXR2NzE5TENuc2ZnelROeWRoZWxMOFEzODhac0hkaGJJdlV1?=
 =?utf-8?B?cHgzS3JMUXlsYzJsdHlhaHZ6V2s1Yis3Y3lOazFjaVFwL2dicUY0SUdNSm15?=
 =?utf-8?B?NlNTbWpnc0w3S3JtSDVGbnBOYXB1RVBjMjRRdE5MTHJVeTkrRWZJSXhnS3RI?=
 =?utf-8?B?QzhqdjFTalVZTUVRZHNaWGRBSzlSdXY4dUZ5TEZNNFRrRmhEYUdna0J3cVRP?=
 =?utf-8?B?enhVTHQxWUtlekhuUXM2b0xCNEV0VlVqWXFNbEtwU2ZkeElGZlg2ZDdoOGR1?=
 =?utf-8?B?aHFsUkF4TGdjMEs5YjBEYTRGU0hOdFVVKzNLd0hMbVdiRld1NjBPK2dPWUMx?=
 =?utf-8?B?RDZKbnFTNWxSL0g1UUlodVJxZHVtTzJmOVQvQkMxV0dsQlhGbWJIK05iVkFy?=
 =?utf-8?B?ZjNIdFlQODJkSjVweGdJUzhtTTJFa2ZaN1FiM1QrcnkxWmtQVGpndVdyVjM3?=
 =?utf-8?B?UkJ0UVVWNnZkalBCSXBiaCtoTCtyMlpzcnVrcGl3Nndyc0ZaaEhnRkQya1BM?=
 =?utf-8?B?bUQwdm9lSkE5ZVY5WWVDNU93Nk5mVWdKVHVYa1lBQ3BvVHUrSHFmbnR5bWFZ?=
 =?utf-8?B?Y01qTlpaSDQvQXBXSDE3OWpIMmxDZ2haQmJrSXExZkJSYTZwaVhkbkJBM05W?=
 =?utf-8?B?clNqRHhrNXpRb3ZjTDZhTDZBVHFjZ2l4ZFYzcmZPTW5YM2gveDVWbk83eC90?=
 =?utf-8?B?M0xpS0t3WFNYcEozYmpMZk00Z2lhTHJwdHg5dHBDTW9kSEg3YXFNczYrYWhQ?=
 =?utf-8?B?ekhKY1RZZENraEc1alRCOXQ4SzNPSVBiSDZpR2k5NDRuQUprY0ZmYUg3VmRu?=
 =?utf-8?B?emR4ekV4ZmVSR2R4WHpkeUlhcUgwSDRJUnNlOFJqY2NTa0Y2UngrYml3NXpj?=
 =?utf-8?B?WldXL2t3N2JTMWQyRUZiZkxWR2EzMzYzUm1qekc2ai9KTnJFSlJLSjNnaVg4?=
 =?utf-8?B?eHp4NEk3QkN3M0htdEVNYnFSaG00bzlJaXZwNWo2ejM1dFNXREVqUlVkMUI3?=
 =?utf-8?B?bXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BC098176F5CF514898D29A76C869E54E@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acbbb5d3-0f6e-4e47-30f3-08da5fb37ecd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2022 00:56:15.7351
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +co29txH2oJvWkalHkZEvMkFlkFBiHLQuBrHue+5z7loJRJbY5lsp4wJsLp15gJYtn1cVMdlznw43Sqh1I847w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4658
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBKdWwgMDYsIDIwMjIgYXQgMDI6NTE6MDBQTSAtMDcwMCwgTWlrZSBLcmF2ZXR6IHdy
b3RlOg0KPiBPbiAwNy8wNC8yMiAxMDozMywgTmFveWEgSG9yaWd1Y2hpIHdyb3RlOg0KPiA+IEZy
b206IE5hb3lhIEhvcmlndWNoaSA8bmFveWEuaG9yaWd1Y2hpQG5lYy5jb20+DQo+ID4gDQo+ID4g
SSBmb3VuZCBhIHdlaXJkIHN0YXRlIG9mIDFHQiBodWdlcGFnZSBwb29sLCBjYXVzZWQgYnkgdGhl
IGZvbGxvd2luZw0KPiA+IHByb2NlZHVyZToNCj4gPiANCj4gPiAgIC0gcnVuIGEgcHJvY2VzcyBy
ZXNlcnZpbmcgYWxsIGZyZWUgMUdCIGh1Z2VwYWdlcywNCj4gPiAgIC0gc2hyaW5rIGZyZWUgMUdC
IGh1Z2VwYWdlIHBvb2wgdG8gemVybyAoaS5lLiB3cml0aW5nIDAgdG8NCj4gPiAgICAgL3N5cy9r
ZXJuZWwvbW0vaHVnZXBhZ2VzL2h1Z2VwYWdlcy0xMDQ4NTc2a0IvbnJfaHVnZXBhZ2VzKSwgdGhl
bg0KPiA+ICAgLSBraWxsIHRoZSByZXNlcnZpbmcgcHJvY2Vzcy4NCj4gPiANCj4gPiAsIHRoZW4g
YWxsIHRoZSBodWdlcGFnZXMgYXJlIGZyZWUgKmFuZCogc3VycGx1cyBhdCB0aGUgc2FtZSB0aW1l
Lg0KPiA+IA0KPiA+ICAgJCBjYXQgL3N5cy9rZXJuZWwvbW0vaHVnZXBhZ2VzL2h1Z2VwYWdlcy0x
MDQ4NTc2a0IvbnJfaHVnZXBhZ2VzDQo+ID4gICAzDQo+ID4gICAkIGNhdCAvc3lzL2tlcm5lbC9t
bS9odWdlcGFnZXMvaHVnZXBhZ2VzLTEwNDg1NzZrQi9mcmVlX2h1Z2VwYWdlcw0KPiA+ICAgMw0K
PiA+ICAgJCBjYXQgL3N5cy9rZXJuZWwvbW0vaHVnZXBhZ2VzL2h1Z2VwYWdlcy0xMDQ4NTc2a0Iv
cmVzdl9odWdlcGFnZXMNCj4gPiAgIDANCj4gPiAgICQgY2F0IC9zeXMva2VybmVsL21tL2h1Z2Vw
YWdlcy9odWdlcGFnZXMtMTA0ODU3NmtCL3N1cnBsdXNfaHVnZXBhZ2VzDQo+ID4gICAzDQo+ID4g
DQo+ID4gVGhpcyBzdGF0ZSBpcyByZXNvbHZlZCBieSByZXNlcnZpbmcgYW5kIGFsbG9jYXRpbmcg
dGhlIHBhZ2VzIHRoZW4NCj4gPiBmcmVlaW5nIHRoZW0gYWdhaW4sIHNvIHRoaXMgc2VlbXMgbm90
IHRvIHJlc3VsdCBpbiBzZXJpb3VzIHByb2JsZW0uDQo+ID4gQnV0IGl0J3MgYSBsaXR0bGUgc3Vy
cHJpc2luZyAoc2hyaW5raW5nIHBvb2wgc3VkZGVubHkgZmFpbHMpLg0KPiA+IA0KPiA+IFRoaXMg
YmVoYXZpb3IgaXMgY2F1c2VkIGJ5IGhzdGF0ZV9pc19naWdhbnRpYygpIGNoZWNrIGluDQo+ID4g
cmV0dXJuX3VudXNlZF9zdXJwbHVzX3BhZ2VzKCkuIFRoaXMgd2FzIGludHJvZHVjZWQgc28gbG9u
ZyBhZ28gaW4gMjAwOA0KPiA+IGJ5IGNvbW1pdCBhYTg4OGE3NDk3N2EgKCJodWdldGxiOiBzdXBw
b3J0IGxhcmdlciB0aGFuIE1BWF9PUkRFUiIpLCBhbmQNCj4gPiBhdCB0aGF0IHRpbWUgdGhlIGdp
Z2FudGljIHBhZ2VzIHdlcmUgbm90IHN1cHBvc2VkIHRvIGJlIGFsbG9jYXRlZC9mcmVlZA0KPiA+
IGF0IHJ1bi10aW1lLiAgTm93IGtlcm5lbCBjYW4gc3VwcG9ydCBydW50aW1lIGFsbG9jYXRpb24v
ZnJlZSwgc28gbGV0J3MNCj4gPiBjaGVjayBnaWdhbnRpY19wYWdlX3J1bnRpbWVfc3VwcG9ydGVk
KCkgdG9nZXRoZXIuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogTmFveWEgSG9yaWd1Y2hpIDxu
YW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCj4gPiAtLS0NCj4gPiB2MiAtPiB2MzoNCj4gPiAtIEZp
eGVkIHR5cG8gaW4gcGF0Y2ggZGVzY3JpcHRpb24sDQo+ID4gLSBhZGQgIWdpZ2FudGljX3BhZ2Vf
cnVudGltZV9zdXBwb3J0ZWQoKSBjaGVjayBpbnN0ZWFkIG9mIHJlbW92aW5nDQo+ID4gICBoc3Rh
dGVfaXNfZ2lnYW50aWMoKSBjaGVjayAoc3VnZ2VzdGVkIGJ5IE1pYW9oZSBhbmQgTXVjaHVuKQ0K
PiA+IC0gYWRkIGEgZmV3IG1vcmUgIWdpZ2FudGljX3BhZ2VfcnVudGltZV9zdXBwb3J0ZWQoKSBj
aGVjayBpbg0KPiA+ICAgc2V0X21heF9odWdlX3BhZ2VzKCkgKGJ5IE1pa2UpLg0KPiANCj4gSGkg
TmFveWEsDQo+IA0KPiBNeSBhcG9sb2dpZXMgZm9yIHN1Z2dlc3RpbmcgdGhlIGFib3ZlIGNoZWNr
cyBpbiBzZXRfbWF4X2h1Z2VfcGFnZXMoKS4NCj4gc2V0X21heF9odWdlX3BhZ2VzIGlzIG9ubHkg
Y2FsbGVkIGZyb20gX19ucl9odWdlcGFnZXNfc3RvcmVfY29tbW9uLg0KPiBBdCB0aGUgdmVyeSBi
ZWdpbm5pbmcgb2YgX19ucl9odWdlcGFnZXNfc3RvcmVfY29tbW9uIGlzIHRoaXM6DQo+IA0KPiAJ
aWYgKGhzdGF0ZV9pc19naWdhbnRpYyhoKSAmJiAhZ2lnYW50aWNfcGFnZV9ydW50aW1lX3N1cHBv
cnRlZCgpKQ0KPiAJCXJldHVybiAtRUlOVkFMOw0KPiANCj4gU28sIHRob3NlIGV4dHJhIGNoZWNr
cyBpbiBzZXRfbWF4X2h1Z2VfcGFnZXMgYXJlIHVubmVjZXNzYXJ5LiAgU29ycnkhDQoNCk9LLCBz
byBJJ2xsIGRyb3AgYm90aCBjaGVja3MsIHRoYW5rIHlvdS4NCg0KLSBOYW95YSBIb3JpZ3VjaGk=
