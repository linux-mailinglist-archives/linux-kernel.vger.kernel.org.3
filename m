Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68F84CF25A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 08:03:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234179AbiCGHC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 02:02:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiCGHCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 02:02:53 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2085.outbound.protection.outlook.com [40.107.113.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A28D606C9
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 23:01:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ef5CGkFSl0BBz1VqU2vWoxcJKNbAzfBW5Bie4ZMgmD65/W+uqN6XQanLl3X1syK89y+uxdGrY5hbsInm+VUCbr0e5lUl1XlA3+6gla5NNJbBvYjcgGA4JVqJmw+BvNeP71y7RmHEqeIgax+jyYAPODeQvW4pCkw7N7Y3Sq28IoNxheKQVbnviNjNRoXZCztxYElNqW0lObeihsJzJLLLoMVDd7O5F06RWZIIVxj7cxRF8pWw/KXE01r1k/u7yFrmm+xh9A0b6UDTXV4Hj53y1XHL/HObHK8Rp+eF3FN5kxNHrljF+Zc2KsuUX76o5/PKfsrdWtNDxB5Ff0d/6vCQkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s1xf6ndWl/1rzlSE5XVoE5MTBsaJNI+JYwXd2N4IUoQ=;
 b=KQ8q2uNXyu/cNEPzkfkzus45/iagtQWcqzNL6XVXnGBEkJBuWNWH4DQpo8q/AVaCllNS+Jlt5mFsNDcWe335wKPJ9BzI6JV0YPlb/ddNSmDHTSNSGOJyCm/l5nMHkATwDQeOcaoiC6tkO7GSJI3UhQu/6zq8jrJj2F1dimiApk6juwoCIKyMIRdPk+RIQz+ekxLhhyVn2OxTMESRkaPhmLQHFaubICYJcHqC3q5TWmcy+vJMygTzR9PQboQfdy38CvnDK5llnXdOVbLj20zlGBs3EF9qncZ3hxJKBtYHW8dRSj22GoXX/gwNxsn1WVXyUrkRwR03+q0au0iI6cHrng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s1xf6ndWl/1rzlSE5XVoE5MTBsaJNI+JYwXd2N4IUoQ=;
 b=WSTlFghmNvEdrnVDEv/PFa/WIphO8oC+7g2MMIoJyvMrLQRHehJLsq7as/rC+t1+eBbfAr+MTNKJ43DMbamVGDrgrSoPHRQ34muBUaFmjin3BvROl0jjnLQM3nAcZ+8oSRfRo1kyApCrxAJ4yVI2QV5Cv1r9l/jMjr7guLku0bQ=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TY2PR01MB4683.jpnprd01.prod.outlook.com (2603:1096:404:111::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.16; Mon, 7 Mar
 2022 07:01:55 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::6565:8408:9726:83e]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::6565:8408:9726:83e%8]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 07:01:55 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     Mike Kravetz <mike.kravetz@oracle.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] mm/memory-failure.c: fix race with changing page
 compound again
Thread-Topic: [PATCH 1/4] mm/memory-failure.c: fix race with changing page
 compound again
Thread-Index: AQHYLKv/m9lQFb/m9ESDNV8aDBIe4ayu6bkAgAC5+gCAA642AIAANzSA
Date:   Mon, 7 Mar 2022 07:01:55 +0000
Message-ID: <20220307070155.GA591088@hori.linux.bs1.fc.nec.co.jp>
References: <20220228140245.24552-1-linmiaohe@huawei.com>
 <20220228140245.24552-2-linmiaohe@huawei.com>
 <20220304082624.GA3778609@hori.linux.bs1.fc.nec.co.jp>
 <79f79813-bb9a-bfff-0837-a24d14da0b19@oracle.com>
 <999a0f88-9465-0c93-e922-8aa80fa64f81@huawei.com>
In-Reply-To: <999a0f88-9465-0c93-e922-8aa80fa64f81@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 60ee8df7-2e2e-4795-79d2-08da00085daf
x-ms-traffictypediagnostic: TY2PR01MB4683:EE_
x-microsoft-antispam-prvs: <TY2PR01MB4683E896135C76F7AF1FD7A1E7089@TY2PR01MB4683.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f8ZekDyfeqr4hHhFaVVZPPdsKE5cCIyhKnc8tkuVbsP+2Y2WbhdljKw8KuAjdJQ80ztnMI6OBDexfyNciThVI/+GFYV/ydqn5UADsVE86+pMDQJyRxTS7h3iH44SXEtAsCWe5w7FWA6/6CCjxHMqyP7rl3sakbjX5xmTpSQ5bB+c0BefmJRKJ3aSfTbSXxqWxvxl+SxQx2g7LnURU3fA+4qDxR0gMad7MaXaahWPSe7yRibiBNcj/AZPjDC+TkB/Pb2O8XZP0YhALDG4w1iXU85yZ2UcXMDdgP6bJsuEU39kBSiEgN/4h/6xJxt7Hu5f57agemlyhTqu8bqTUAqkOaZpQNXXeixswAcSQ076VcRBPo90L94NhBYscgLbhL1XjdjKSpgOtY/AvKtaK0hf5Ks4RoY8lasDqklMJxULigIuzpvB5WOGdLHP6x+s01yD4QAnfjys2vWFvsCIQXnw2NPpneXsZFxuemVrYRW/LpJsp9MQ8PdjpksMnV3AsPMmuTEQXHdzJVTIqkBV6pOp/UerB0nGxKplnJyRwXq6zkjEEDhHiQE+dwkCEm1IatWiZkox7LviySL2M3hujZrpXLLk35toqHB9mjFMSabA0WiKX5DHc5q3TeasoleX3jZbd+iZKyR4SpasNJBHcFkiPk5WvDVryFjKcs4pL2g0+2ldSmzMo8+8UL9pTjqlcCPd67MwWt3SvajMJmG4Fp65kfDvEwl+//UKiNn+MoyrM7yKigRJiMJ0stp+l+p/z1JOsX5G53f05MUX8sLSFzKpytCycaYHBe34fiINwNg46qY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(8936002)(2906002)(4326008)(8676002)(76116006)(66946007)(64756008)(66476007)(66556008)(66446008)(5660300002)(85182001)(122000001)(83380400001)(6916009)(54906003)(38070700005)(33656002)(316002)(966005)(6486002)(53546011)(55236004)(71200400001)(9686003)(6512007)(6506007)(82960400001)(508600001)(26005)(38100700002)(186003)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TW9wM3JSYnNMNTBzOXpaK2tQOVdjeHNkVm9Qc3YwUWVnMmFNUHFoRUZwMWpp?=
 =?utf-8?B?dytoY2NYc1NEU3lzSG8xNlp1NDliTkxiOFU5eENRYkFJYmpuenFuS3hFUTdO?=
 =?utf-8?B?aWJUL3ZVQnJER3M5RVJPTG1iMmt4Z1BZc2JCVkR3TTBTYWRxdE5xeWExU2M4?=
 =?utf-8?B?Y1pwQS9NZCtRS0JTT1k3TTRDMGlXV2Y2alBubWJ0MmZZeXQ1Q1VNalZ3ZWJm?=
 =?utf-8?B?Y3phYVNUU1RGMzVDSFZQQjhYYlpaTXFUTC9SWVZRTnVCNW1DcXBPSzJvTFBS?=
 =?utf-8?B?eko1RnZLUE9XcDNuYTJCc2k5N3NvRGthWDV5WE4vK2c2RS84QThMb0tESFBa?=
 =?utf-8?B?aG9kM0kvVVRKNG1vOU1nZlM0c1IydkVJYmJyK0xtbDRHMXdrWlBQeWJER2tN?=
 =?utf-8?B?WXlMTVBxK0oxUDdWOWJ4NExxRTF2bk9qWjNpUTM0VDJuOWRrSHVoM1BBeHpx?=
 =?utf-8?B?NTE1ZmJYVUdvNGUxM3krdUVpVDJlTWJlV3YxSmp1VVQwY0xFaTVjMDM4Unpq?=
 =?utf-8?B?ZG14UXhqUVRnZ01qR3VrOHd1cjFTbTVKdnpyZWdVUTRzcU5remtHb25uMytj?=
 =?utf-8?B?cWZpb3RBbWtURU5zMFpKVnNLWUM5NFZYWFpZQm9tSExiaW1jSWtKQU9taExq?=
 =?utf-8?B?Z0F5bFA0azJmS3JablFJYWgvSUJZYlNUd0UrMzIwZGsxcFdiQThqZUtJZ3RO?=
 =?utf-8?B?YmxkZjlOb054bStJdHZVcGllV3JBMFZoNVEzOThiNTBFTjg2ZmlyZTlTcm9Y?=
 =?utf-8?B?QXQvaUgyRTFPRmhOQU5uc2VlaUlGbFc2ZitNckNoNWg0eENMZUtkUlR5UmJy?=
 =?utf-8?B?UGtVVm5vM1FMa3lBNGVqcisrMmFqLzdVaUdONjIzbGJsemd3dFNRQzNDbUNP?=
 =?utf-8?B?NnlwYmtObkxHZndJQnRzcDQya09KVWZoNFZzR1FvdHBKLzFBcHIxQW1rajVz?=
 =?utf-8?B?Y2doRzE2RUMwNnlIRjNxUUlkQ3hwbjJuQzI2ZjZwaWlKQ1pDRnpVeE4xOFEv?=
 =?utf-8?B?bHBHWEdDWmJibzdxZzB4MlNqSldwTkRzOEREd3kxYnZhNkJ2cWthZUhjYVk5?=
 =?utf-8?B?VDVxYTBLTDhvTXZQYWdXYkxPTWdpcW5mMW1XZFJCTklQRTBwaGs5akduSlly?=
 =?utf-8?B?MXdPYlJoM0EvSWVGa1BYcUJzTVJyT0U2bW9RQkxjWlJwcmNneEMyUCtqaElw?=
 =?utf-8?B?c3pWa0VoMkVTUGhJTmNVMlk5K2VMdmlHSHQ2OXA3SzB0OEw4Nmc0Uk9Lc0Ra?=
 =?utf-8?B?Uk1VT1dUb2hQMWxTY2ZibnpUWnhFSEx5OVcxbXhsdlg4eDhhYzgrQnh4ZmRH?=
 =?utf-8?B?NDJQcHFBeHhySWJsbmhibURQTkxhQ2tlTGcwOGZyekc4L2sxNnJvK21FRlJp?=
 =?utf-8?B?enA0TWluWkF1OE5WdndQWkwrUnBBL2d3Y1VXcHlJcHZ6OXVHcmJ1WnE5Nm1E?=
 =?utf-8?B?L3p6SWNlazRIZjJkZVJMcHRURlk0S3lNS2NpY3l0SDd0b0xFZCtuQkNBYVhk?=
 =?utf-8?B?eEVralZLdFJITlRncEVrYXBqMnBWblFIUHV4d2hEcHpzN2JMc2NVNzZRNXdD?=
 =?utf-8?B?aGRmaU9LdGcvaDliVk9ySUdlYnFRdXYxNU81cWVuT20vVVVsMW5uRzhKZzgx?=
 =?utf-8?B?eGdSekpjZEt0aTErbSt6ZllXVnRGbzRwc2Y2N001bGo0enAzRVhRK2ZPWGtV?=
 =?utf-8?B?V0RrdEdRUU43QUVDTWNqQ283ekUvRitrSkZWTmhLUEFBYWVSOGZjRDhTOTRx?=
 =?utf-8?B?MjkwQnhVKzE2SFBLWTNVdUJ6YWRwcUoreGRFSGlkajd1em1IZ3o2amZSMis3?=
 =?utf-8?B?Q3pKZ1lGUHkwZTdGS3d1Q1dPWEhJa0crTExLRk1MalNCZklIOHhoMk1MejAv?=
 =?utf-8?B?cURLZHhiTE9XVVFrMjJ0QkNFL0VFci8xSzNWU1VOMG1kMGlnSHQva2s5TkVG?=
 =?utf-8?B?WEJkTi8yVzNPL2NEdHhvcW4xTmx4RDUyTEppbWtzNDloZDdqTUI5SUVkWE0x?=
 =?utf-8?B?WVZMYlk5aFkwcHY3S05zd0lUSnM5a2pWN2daZ0FHQ2JLOGRMME84RmZuMndv?=
 =?utf-8?B?azZ5KzR6MW96b1pEbytvMmtjaXN1S2FuQytjWWhJTU9HdGI0SE1DZmg0Wm4x?=
 =?utf-8?B?MVhIMlRNRDFoVE1hUG15eDQybTdvTlBRUEVYOURGME1Da3lRVkdUQVJxNU5M?=
 =?utf-8?Q?cvvueuitIWKkdEfydFtZEYc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C9387CC22E7F8C4088C726A98F277672@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ee8df7-2e2e-4795-79d2-08da00085daf
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 07:01:55.7241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5aoMOuPrtfE0h2cSI9Xi6gwulfUG3uauDfqXYXzyKqo4//ijm34JDGysLXiyI0D9ueprM7+prgpXjbOGP7tt/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4683
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBNYXIgMDcsIDIwMjIgYXQgMTE6NDQ6MjBBTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi8zLzUgMzozMiwgTWlrZSBLcmF2ZXR6IHdyb3RlOg0KPiA+IE9uIDMvNC8y
MiAwMDoyNiwgSE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8pIHdyb3RlOg0KPiA+PiBPbiBN
b24sIEZlYiAyOCwgMjAyMiBhdCAxMDowMjo0MlBNICswODAwLCBNaWFvaGUgTGluIHdyb3RlOg0K
PiA+Pj4gVGhlcmUgaXMgYSByYWNlIHdpbmRvdyB3aGVyZSB3ZSBnb3QgdGhlIGNvbXBvdW5kX2hl
YWQsIHRoZSBodWdldGxiIHBhZ2UNCj4gPj4+IGNvdWxkIGJlIGZyZWVkIHRvIGJ1ZGR5LCBvciBl
dmVuIGNoYW5nZWQgdG8gYW5vdGhlciBjb21wb3VuZCBwYWdlIGp1c3QNCj4gPj4+IGJlZm9yZSB3
ZSB0cnkgdG8gZ2V0IGh3cG9pc29uIHBhZ2UuIElmIHRoaXMgaGFwcGVucywganVzdCBiYWlsIG91
dC4NCj4gPj4NCj4gPj4gSSB0aGluayB0aGF0IHdoZW4gc29tZSBodWdldGxiIHBhZ2UgaXMgYWJv
dXQgdG8gY2hhbmdlIGludG8gb3RoZXIgdHlwZS9zaXplDQo+ID4+IG9mIGNvbXBvdW5kIHBhZ2Us
IGl0IGhhcyB0byBnbyB0aHJvdWdoIGJ1ZGR5IGFsbG9jYXRvciBiZWNhdXNlIGh1Z2V0bGIgcGFn
ZXMNCj4gPj4gYXJlIG1haW50YWluZWQgaW4gc2VwYXJhdGUgbWVtb3J5IGFsbG9jYXRvciBhbmQg
dGhleSBuZXZlciBjaGFuZ2UgaW50byBvdGhlcg0KPiA+PiBub3JtYWwgc3RhdGUgZGlyZWN0bHku
ICBtZW1vcnlfZmFpbHVyZV9odWdldGxiKCkgdGFrZXMgcmVmY291bnQgYmVmb3JlDQo+ID4+IGxv
Y2tfcGFnZSgpLCBzbyB0aGUgaHVnZXRsYiBwYWdlIHNlZW1zIG5vdCBjaGFuZ2UgYmV0d2VlbiBn
ZXRfaHdwb2lzb25fcGFnZSgpDQo+ID4+IGFuZCBsb2NrX3BhZ2UoKS4gU28gaXQgdGhpcyBuZXcg
Y2hlY2sgcmVhbGx5IG5lY2Vzc2FyeT8NCj4gPiANCj4gPiBBIGh1Z2V0bGIgcGFnZSBjb3VsZCBj
aGFuZ2Ugc2l6ZSB3aXRob3V0IGdvaW5nIHRocm91Z2ggYnVkZHkgdmlhIHRoZSBuZXcNCj4gPiBk
ZW1vdGUgZnVuY3Rpb25hbGl0eSBbMV0uICBPbmx5IGh1Z2V0bGIgcGFnZXMgb24gdGhlIGh1Z2V0
bGIgZnJlZSBsaXN0IGNhbg0KPiA+IGJlIGRlbW90ZWQuICANCj4gPiANCj4gPiBXZSBzaG91bGQg
bm90IGRlbW90ZSBhIHBhZ2UgaWYgcG9pc29uIGlzIHNldC4gIEhvd2V2ZXIsIHRoZXJlIGlzIG5v
IGNoZWNrIGluDQo+ID4gdGhlIGRlbW90ZSBjb2RlLiAgSUlVQywgcG9pc29uIGlzIHNldCBlYXJs
eSBpbiB0aGUgbWVtb3J5IGVycm9yIGhhbmRsaW5nDQo+ID4gcHJvY2VzcywgZXZlbiBiZWZvcmUg
dGFraW5nIHJlZiBvbiBwYWdlLiAgRGVtb3RlIGNvZGUgbmVlZHMgdG8gYmUgZml4ZWQgc28NCj4g
PiB0aGF0IHBvaXNvbmVkIHBhZ2VzIGFyZSBub3QgZGVtb3RlZC4gIEkgY2FuIGRvIHRoYXQuDQo+
ID4gDQo+ID4gV2l0aCB0aGlzIGNoYW5nZSBpbiBwbGFjZSwgdGhlbiBJIHRoaW5rIE5hb3lhJ3Mg
c3RhdGVtZW50IHRoYXQgaHVnZXRsYiBwYWdlcw0KPiA+IGNhbiBub3QgY2hhbmdlIHN0YXRlIGlz
IGNvcnJlY3QgYW5kIHRoaXMgcGF0Y2ggaXMgbm90IG5lY2Vzc2FyeS4NCj4gPiANCj4gDQo+IFNv
cnJ5IGZvciBteSBjb25mdXNpbmcgY29tbWl0IHdvcmRzLiBXaGF0IEkgbWVhbiB0byB0ZWxsIGlz
IGluZGVlZCB0aGUgYmVsb3cgcmFjZToNCj4gICBDUFUgMQkJCQkJCQlDUFUgMg0KPiAgIG1lbW9y
eV9mYWlsdXJlX2h1Z2V0bGINCj4gICBzdHJ1Y3QgcGFnZSAqaGVhZCA9IGNvbXBvdW5kX2hlYWQo
cCk7DQo+IAkJCQkJCQlodWdldGxiIHBhZ2UgaXMgZnJlZWQgdG8gYnVkZHksIG9yDQo+IAkJCQkJ
CQlldmVuIGNoYW5nZWQgdG8gYW5vdGhlciBjb21wb3VuZCBwYWdlDQo+IAkJCQkJCQlhcyB3ZSBo
YXZlbid0IGhlbGQgdGhlIHBhZ2UgcmVmY250IG5vdw0KPiAgIGdldF9od3BvaXNvbl9wYWdlIC0t
IHBhZ2UgaXMgbm90IHdoYXQgd2Ugd2FudCBub3cuLi4NCj4gDQo+IERvZXMgdGhpcyBtYWtlIHNl
bnNlIGZvciBib3RoIG9mIHlvdT8gTWFueSB0aGFua3MgZm9yIGNvbW1lbnQgYW5kIHJlcGx5ISA6
KQ0KDQpUaGFua3MgZm9yIGVsYWJvcmF0aW9uLCBJIGFncmVlIHdpdGggeW91IChJIHNpbXBseSBv
dmVybG9va2VkIHRoaXMgcmFjZSwgc29ycnkpLg0KQW5kIHBsZWFzZSBhZGQgdGhpcyBpbiB0aGUg
Y29tbWl0IGxvZy4NCg0KPiArDQo+ICsgICAgICAgLyoqDQo+ICsgICAgICAgICogVGhlIHBhZ2Ug
Y291bGQgaGF2ZSBjaGFuZ2VkIGNvbXBvdW5kIHBhZ2VzIGR1ZSB0byByYWNlIHdpbmRvdy4NCj4g
KyAgICAgICAgKiBJZiB0aGlzIGhhcHBlbnMganVzdCBiYWlsIG91dC4NCj4gKyAgICAgICAgKi8N
Cj4gKyAgICAgICBpZiAoIVBhZ2VIdWdlKHApIHx8IGNvbXBvdW5kX2hlYWQocCkgIT0gaGVhZCkg
ew0KPiArICAgICAgICAgICAgICAgYWN0aW9uX3Jlc3VsdChwZm4sIE1GX01TR19ESUZGRVJFTlRf
Q09NUE9VTkQsIE1GX0lHTk9SRUQpOw0KPiArICAgICAgICAgICAgICAgcmVzID0gLUVCVVNZOw0K
PiArICAgICAgICAgICAgICAgZ290byBvdXQ7DQo+ICsgICAgICAgfQ0KDQpMZXQgbWUgaGF2ZSBv
bmUgY29tbWVudCBvbiB0aGUgZGlmZi4gVGhlIHJlc3VsdCBjb2RlIE1GX01TR19ESUZGRVJFTlRf
Q09NUE9VTkQNCm1pZ2h0IG5vdCBmaXQgd2hlbiBQYWdlSHVnZSBpcyBmYWxzZSBpbiB0aGUgY2hl
Y2sgKGJlY2F1c2UgaXQncyBubyBsb25nZXIgYQ0KY29tcG91bmQgcGFnZSkuICBNYXliZSB5b3Ug
bWF5IGludmVudCBhbm90aGVyIHJlc3VsdCBjb2RlLCBvciBjaGFuZ2VzDQpNRl9NU0dfRElGRkVS
RU5UX0NPTVBPVU5EIChmb3IgZXhhbXBsZSkgdG8gTUZfTVNHX0RJRkZFUkVOVF9QQUdFX1NJWkU/
DQoNCj4gDQo+ID4gRG9lcyB0aGF0IHNvdW5kIHJlYXNvbmFibGU/DQo+ID4gDQo+ID4gWzFdIGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LW1tLzIwMjExMDA3MTgxOTE4LjEzNjk4Mi0xLW1p
a2Uua3JhdmV0ekBvcmFjbGUuY29tLw0KPiANCj4gVGhpcyBpcyByZWFsbHkgYSBuaWNlIGZlYXR1
cmUuIFRoYW5rcy4NCg0KWWVzLiBIdWdlcGFnZSBkZW1vdGlvbiBhZnRlciBlbnRlcmluZyBtZW1v
cnlfZmFpbHVyZV9odWdldGxiKCkgc2hvdWxkDQpjYXVzZSB0aGUgcmFjZSwgc28gd2UgbmVlZCB0
aGUgY2hlY2sgYWZ0ZXIgcGFnZSBsb2NrLg0KDQpUaGFua3MsDQpOYW95YSBIb3JpZ3VjaGk=
