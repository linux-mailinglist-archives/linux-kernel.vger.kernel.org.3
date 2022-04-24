Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE14950D5F7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 01:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239934AbiDXXpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 19:45:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232746AbiDXXpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 19:45:00 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2058.outbound.protection.outlook.com [40.107.113.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22255A94F3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 16:41:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IoOB2w8cNu4N0aRR3g7R0t87p9Dz9c0xVS3k3ayntzQ+ZZI/LGo+YrMnFKC+t4lnbFB1AaYdgDbU+r8Gfw6/FYXPddZ8IA3MTl02w1zYKXom6bjFu+J1xeOXG9pLmM6EBtVElyf1i590+5wwRRrYrdNM6ksSmWNdFUr4dmdIV5vYQ/a9dTpCSLNzdSm6LtsuYUJI+dtwQezth9LCA6qUmQ+jHRXoNKXh0B+hZbh8TUb4AWjhkv4KH1/TwOXrrVpHNdaGFsFak4tPCHvlloCNovaNjZWh0I9NTyM5ClWnk4GzVYaSdXJvqZiuIyVlyZEb9gV8QoLj+ymB6g/YdYhT7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mz1w0YObjzLTvKbDv/d0gvwh9Ulns0vpS/5QbwBsWhk=;
 b=c7GAhG5hEaw4+h7rYQn0hTTCTS2AZOsvPvANrtJ2a8V6qCnfwCEI8W6ngMjLvcE0B/RIFPxmeeCaVyOhikDkTy+4qR33osRZ6g1cf68RuX0ZnENVyGx6E9pPWGPkB11Zj2EynvqVFLtmwuSMM6zxcILoN8nJocD5pMYVEwkxystsd9lz9/w25934P2PqO+JeYwusuaYBTTubCRjt4jqmS5XUiiThGPDAPuH1KAfgqmjqoZTzd046OEX1diktFSay3sVQRLpQ4fipgZCR/pajGs/gfTyJ4A9JmU28vlEJdU84lXoE1o+SXQtMLGPAxa43+uCJa7uCTq1wwSU1N/BsJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mz1w0YObjzLTvKbDv/d0gvwh9Ulns0vpS/5QbwBsWhk=;
 b=MIgKcEI6JCoD9ht3CXIH/w7Wvm7i8+4Y3Sn4XLoBjpTm/sFDk9csk1nZNf9EXUCLxLW3Yp8pc41+NHqENac8QiIMd3zMM+IZw4vzYqUP/anEuiQMOzGAAmPC2fvtWPPcyMSAJ+iJ46/505Upv9mA5BytAWfJvzrUKckuY7CZw7k=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TY2PR01MB2762.jpnprd01.prod.outlook.com (2603:1096:404:6d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.20; Sun, 24 Apr
 2022 23:41:29 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::e58f:5f3b:6d28:b245]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::e58f:5f3b:6d28:b245%4]) with mapi id 15.20.5186.021; Sun, 24 Apr 2022
 23:41:29 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "david@redhat.com" <david@redhat.com>,
        "apopple@nvidia.com" <apopple@nvidia.com>,
        "surenb@google.com" <surenb@google.com>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/3] mm/madvise: free hwpoison and swapin error entry
 in madvise_free_pte_range
Thread-Topic: [PATCH v3 3/3] mm/madvise: free hwpoison and swapin error entry
 in madvise_free_pte_range
Thread-Index: AQHYV7sx3+3g5gdCt0uUhAI4aXMQE6z/uiwA
Date:   Sun, 24 Apr 2022 23:41:29 +0000
Message-ID: <20220424234128.GA3740950@hori.linux.bs1.fc.nec.co.jp>
References: <20220424091105.48374-1-linmiaohe@huawei.com>
 <20220424091105.48374-4-linmiaohe@huawei.com>
In-Reply-To: <20220424091105.48374-4-linmiaohe@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ba7eba18-cf09-4183-a305-08da264bf45a
x-ms-traffictypediagnostic: TY2PR01MB2762:EE_
x-microsoft-antispam-prvs: <TY2PR01MB27621E1B0C4AB86FC5546223E7F99@TY2PR01MB2762.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o+xzh3Pxmaxp4fzAK1dBuAY2P4qUiBi+gVwMpjCsL8p1YK+A6OScQKkqpTZhstKMSkC4Jo6/FYvPRAqWShH4Gxa8J2rVksrRwmM4I6T6bmKNM2ZXLKF0wk6d0iSxrPKZiAujUEXMnIaosTm+NX2xytgrS7ndJGgH1hm1Jl072xTlB77D+IrvBBAJqDn4XyD/q62JmNtBWmEFQIr0E0ZgQZ6mwrc3i2/u666W7zjB5e21jefzRQhwb3LeP41DZjQl5wipEHxDoWZfKgGJ9NUDlCOMNyZpD/ksAPA0tUkPIVjAaESskEcjkQWSwL9Wcu//UaOqq5E7yWnfyuu0pCF3vFwjaIS8JogFcXUEpQ+qL8lplWUmWo+KOTTaG0JJxglEW5eD7TmJKHh9JM7CzHh+0e5qcWiIdtgFoBNgt6S37h33kwyDBynqleTY+FFMNGHIvDzTGWh8NrjrvcbBTYJxyV308UsoybNrxkE+dsYRh2ZVlw45w/NoUOQE76URoR0+rRbhxq/Ar2pj0ms2WgSEQphiFuzA/Y1/qN4O4vsKv0R8m4Ig6Iv8EBGHpWXhbzwFMl+qJZHuloUXUHMerfQ6hp/q6p+GJtXoDTgFtf7WjOxu0KUgV6Yp2uUDKFFJdOM96BKu96Ch7UH+/OU/YF0m1sTSOaunAfT6rGERys0U/C/OirCOji5/YNb2uR+qv4jRsMBwddB1tcwfwL6Syc03yQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(66446008)(66476007)(4326008)(6506007)(55236004)(64756008)(66946007)(66556008)(76116006)(9686003)(8676002)(6512007)(508600001)(54906003)(86362001)(6916009)(316002)(6486002)(71200400001)(1076003)(186003)(82960400001)(122000001)(38070700005)(38100700002)(83380400001)(33656002)(2906002)(8936002)(7416002)(5660300002)(85182001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFJSeTZ1MTRIeHpPZWdhR2RVU3RGYm0xdkVFbTg3cW9nQm5sTmRDVElkMGpx?=
 =?utf-8?B?UmlrN2JNTnR0WjM3WlZBWTVBRmZ3UzRid2M4QjBFOGZ0dWk2N0sxbGV2OHdF?=
 =?utf-8?B?VzFEcTB3dUp4MTVONG9YNXIwelc0Z3hqNmxYMEtCU2ZDc1BwNHd5YzA1VGFh?=
 =?utf-8?B?ZXlQR2lhRXU4ZHY2OU05WVk4YWloRzgwdG5UQ0l6b1ZjUm9KZXAvUzYrcU4z?=
 =?utf-8?B?OG1DbEdKRE1sWkoyeDhFZHpCbzAxOVN3dHcvYVFvV3lPN015ckdLa2xYdjFx?=
 =?utf-8?B?WmhpZkpGRVBhSDRwRlJyMDVCYndMVjhXR1RhZC9xc3lqT2M1eW5tSXBXR3lk?=
 =?utf-8?B?K2oxVS83MnpxS2pIU2dqeTNjWTdaOUk1am80QjFBbFcvc1ZPck9SVnVQRmhB?=
 =?utf-8?B?V0YvMG9qa2NlNm5pY3RYRGpBRmIrUVBqbzBRZFN2ZHVuYkNKNVRQckgvbzZy?=
 =?utf-8?B?S0xlT0orL1BweVp3N3FaRG5WOU9vcjhUN2hzT2g1ellURFVpZTNlRHFGMU5o?=
 =?utf-8?B?emEzdEpkTEVSRVFLb1IxcmZvWmRhR1lNZ3pyUmlSNkY1cmpDVTRTRWZjS05l?=
 =?utf-8?B?MWljMWc2SnQyNEhPaDZ2ajk5L2x5OFNhaFZpK0ZjZGZzSGZUNnVDckpCVlZU?=
 =?utf-8?B?enMzNkdLZm1NSGNmL2ZTNUo1TjFtYjhZY0RtL2JFeXJ5azhlajg1Z3dRY0RR?=
 =?utf-8?B?RmtpelRhTFdLaDBIU2FYQ3dtSEpSNHgzcU15TzZieno1azlPejlXSGs1b1Vw?=
 =?utf-8?B?OTNNOTBNYWVCNU5Lc1lrVGd5RUlsUk15T0wyelAxQXM3VHdMdjBEVHNNU21h?=
 =?utf-8?B?OHg1VkFsWWN0TzFrNnNDMTBjTytydTlHVnEydngveVd2TmdjcUlzeERjQ0N0?=
 =?utf-8?B?eE1BazR4ck5saXFJSHBHZ0lmNXdteHFoNlhBdGJYMlBNOHZoeXBHWTg5b3hL?=
 =?utf-8?B?Q2w0UXNMa1VTbDh3NWR3T3ZTdEZkNFBMZjI0UWlaMlc4ek1RQWdMN3lOT243?=
 =?utf-8?B?S1djOTVaWkUvclQ2RnlvVlg4b1JqckowYVduUURHZ1lET1cvU1FjU2lKaDho?=
 =?utf-8?B?b2k2dEYyYXR3cCt3eThQSXpvZWtpOWYwQTZabnlGYzBlRmZCcytuSXNZK2J3?=
 =?utf-8?B?aXlGdzZ5eU13M1A3cENTVzAxdTU3akhPN2tWd0hNbWplRFhabHJrZGNueFk2?=
 =?utf-8?B?MERoWUZzSUJEd2ZzV2FNdFN3UXlrQW5ra29NYTdEeXpjZkI2eDZxUkxwSytJ?=
 =?utf-8?B?dkU0ZW5wM2RRZTFyRFlYeDdrNmVkbGVNSWFnSUhDZmhtTEVuN2RmSjdMWXZB?=
 =?utf-8?B?UkFuaGU0M0FmMlBLVGlWL09ZT0JLZ1RXTi90VldJWis2OFYyZWpHbU94YUJy?=
 =?utf-8?B?bmxpYU14SjV0a2k0RGdycEE1ZStJUXZKV0F6cWtnamtINEtyRzRiNlZreXBF?=
 =?utf-8?B?R0U1UmRMWGJSRTBidDR3UFNnM1A0TkVWNGc0NE9FOHlVakc3TUo3TXBoNm1S?=
 =?utf-8?B?dHlKemhSZjNlRUowSmFVVzJRSzZUdkhOS3VwZVJyWk1JOFArSFNKbkhadTF5?=
 =?utf-8?B?NllRYkg1SEZUekk0a1pRb2ZBcGpEaUpab2NYN1VHK1VDbUR4TlBwalZiQ201?=
 =?utf-8?B?aFB4LzBXbk1WeGNIdDVpa255emN1THN0RHpjUDdNNktHeFRwWTB5bUUwcU0z?=
 =?utf-8?B?SC9CTTNEeFFNT2lKRy9Za2ZGM2V4bytNekszS3h4UzNqTHk3OGQ5aGkvRi8x?=
 =?utf-8?B?eS9XU0plUVBxbVBwLzgwcVg5cEFHZlUxVE53UDhldUJHU3BjOWNDK0dsVjk3?=
 =?utf-8?B?SlFjdjFqU1M1b0FRTHorTm5HdVdML0VBUFJVUllNbWIwckNUWnRLUHhxWXVv?=
 =?utf-8?B?T0w0NjFSVEdKVGpkOWFZdVJFSDhLTkpseG82d2ZBcWhEQnVLbWkvcXNoWEZi?=
 =?utf-8?B?ZkFZTUNaS3oxMkIzR3FhS1kwUHVrdjZaV0VhQ0MvOHZTSkkwL0xnOEdUNXQ4?=
 =?utf-8?B?c0xtOTFRNFhDSXp4MjdCNVhWYzlWRmRMZVoxQ05YRFJWbmRvd215SGN1bDRv?=
 =?utf-8?B?MkJwQnQvNEdMSG9DY0k4cHhYOURWbm1YeVV0Q3JRN1lVSUllNEMwNnJHYUhv?=
 =?utf-8?B?M1NoTUhoOHhqNjBmeEFWcEFMSDVaMXloQzBIZzN4Mk5lSzZUZ2FSS3NVa0Rj?=
 =?utf-8?B?OXIzVDBmV3A0ZHZvczNwR1lGMHp2ZzFkbnNkM2M3OG96RkxocE56YVBvNWlJ?=
 =?utf-8?B?MGVSejRsemVlUkxpZWFDRzNjY3FoOTVYUUkwd25oS2NGVzlTZ3hxMFJTa0tv?=
 =?utf-8?B?THV6Tmpsbzh5QUVZYzRrYUc3b25hK3pZVWFhMnRaZmtGMWF3VmtRNHVhbjBN?=
 =?utf-8?Q?U3qbeAVse9ZPxA0I=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <959398754B63C94B89FA012E781857E5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7eba18-cf09-4183-a305-08da264bf45a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2022 23:41:29.0017
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OWA2IAuoqxZIfjNt8a1D4JoPDv3+l5e+VntImfBbG2etZhfHpzgaH7WxjguEpZRmHjNw/Dod8lQVuQ12mqA2Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB2762
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gU3VuLCBBcHIgMjQsIDIwMjIgYXQgMDU6MTE6MDVQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT25jZSB0aGUgTUFEVl9GUkVFIG9wZXJhdGlvbiBoYXMgc3VjY2VlZGVkLCBjYWxsZXJz
IGNhbiBleHBlY3QgdGhleSBtaWdodA0KPiBnZXQgemVyby1maWxsIHBhZ2VzIGlmIGFjY2Vzc2lu
ZyB0aGUgbWVtb3J5IGFnYWluLiBUaGVyZWZvcmUgaXQgc2hvdWxkIGJlDQo+IHNhZmUgdG8gZGVs
ZXRlIHRoZSBod3BvaXNvbiBlbnRyeSBhbmQgc3dhcGluIGVycm9yIGVudHJ5LiBUaGVyZSBpcyBu
bw0KPiByZWFzb24gdG8ga2lsbCB0aGUgcHJvY2VzcyBpZiBpdCBoYXMgY2FsbGVkIE1BRFZfRlJF
RSBvbiB0aGUgcmFuZ2UuDQo+IA0KPiBTdWdnZXN0ZWQtYnk6IEFsaXN0YWlyIFBvcHBsZSA8YXBv
cHBsZUBudmlkaWEuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBNaWFvaGUgTGluIDxsaW5taWFvaGVA
aHVhd2VpLmNvbT4NCj4gQWNrZWQtYnk6IERhdmlkIEhpbGRlbmJyYW5kIDxkYXZpZEByZWRoYXQu
Y29tPg0KDQpJIGNvbmZpcm1lZCB0aGF0IGh3cG9pc29uIGVudHJ5IGlzIHByb3Blcmx5IHJlbW92
ZWQgd2l0aCBtYWR2aXNlKE1BRFZfRlJFRSkNCndpdGggdGhpcyBwYXRjaC4gVGhpcyBwcm92aWRl
cyBhcHBsaWNhdGlvbnMgd2l0aCB0aGUgYWJpbGl0eSB0byByZWNvdmVyIGZyb20NCm1lbW9yeSBl
cnJvcnMgaW4gc2ltcGxlciB3YXkgKGFwcGxpY2F0aW9ucyBkb24ndCBoYXZlIHRvIG11bm1hcCB0
aGVuIG1tYXAgYWdhaW4NCnRoZSBlcnJvciBhZGRyZXNzKS4gVGhhdCdzIGEgZ29vZCBzbWFsbCBp
bXByb3ZlbWVudC4gVGhhbmsgeW91Lg0KDQpSZXZpZXdlZC1ieTogTmFveWEgSG9yaWd1Y2hpIDxu
YW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4NCg0KPiAtLS0NCj4gIG1tL21hZHZpc2UuYyB8IDEzICsr
KysrKysrLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDUgZGVsZXRp
b25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbW0vbWFkdmlzZS5jIGIvbW0vbWFkdmlzZS5jDQo+
IGluZGV4IDRkNjU5MjQ4OGI1MS4uNWY0NTM3NTExNTMyIDEwMDY0NA0KPiAtLS0gYS9tbS9tYWR2
aXNlLmMNCj4gKysrIGIvbW0vbWFkdmlzZS5jDQo+IEBAIC02MjQsMTEgKzYyNCwxNCBAQCBzdGF0
aWMgaW50IG1hZHZpc2VfZnJlZV9wdGVfcmFuZ2UocG1kX3QgKnBtZCwgdW5zaWduZWQgbG9uZyBh
ZGRyLA0KPiAgCQkJc3dwX2VudHJ5X3QgZW50cnk7DQo+ICANCj4gIAkJCWVudHJ5ID0gcHRlX3Rv
X3N3cF9lbnRyeShwdGVudCk7DQo+IC0JCQlpZiAobm9uX3N3YXBfZW50cnkoZW50cnkpKQ0KPiAt
CQkJCWNvbnRpbnVlOw0KPiAtCQkJbnJfc3dhcC0tOw0KPiAtCQkJZnJlZV9zd2FwX2FuZF9jYWNo
ZShlbnRyeSk7DQo+IC0JCQlwdGVfY2xlYXJfbm90X3ByZXNlbnRfZnVsbChtbSwgYWRkciwgcHRl
LCB0bGItPmZ1bGxtbSk7DQo+ICsJCQlpZiAoIW5vbl9zd2FwX2VudHJ5KGVudHJ5KSkgew0KPiAr
CQkJCW5yX3N3YXAtLTsNCj4gKwkJCQlmcmVlX3N3YXBfYW5kX2NhY2hlKGVudHJ5KTsNCj4gKwkJ
CQlwdGVfY2xlYXJfbm90X3ByZXNlbnRfZnVsbChtbSwgYWRkciwgcHRlLCB0bGItPmZ1bGxtbSk7
DQo+ICsJCQl9IGVsc2UgaWYgKGlzX2h3cG9pc29uX2VudHJ5KGVudHJ5KSB8fA0KPiArCQkJCSAg
IGlzX3N3YXBpbl9lcnJvcl9lbnRyeShlbnRyeSkpIHsNCj4gKwkJCQlwdGVfY2xlYXJfbm90X3By
ZXNlbnRfZnVsbChtbSwgYWRkciwgcHRlLCB0bGItPmZ1bGxtbSk7DQo+ICsJCQl9DQo+ICAJCQlj
b250aW51ZTsNCj4gIAkJfQ0KPiAgDQo+IC0tIA0KPiAyLjIzLjA=
