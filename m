Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7765ACB2B
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236829AbiIEGfn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 02:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236345AbiIEGfW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 02:35:22 -0400
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2058.outbound.protection.outlook.com [40.107.114.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD951DEDD
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 23:34:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hiC3Eo82R5SqiJJx61iT6OjWVchdOzO5J3KWipeX4yTfA5SEbDsCG9XpVuAohBNUGCJcgFmV/i3DO50YaBvKb8qIseg1Z1c541JzY7GmCqIXpq1BfktRdkfL8LMwr3/eMUd4GaswdK9sLLtQBqaohbujOaPcoai+oDgf9R/yuaJiAE6Gzq0BwXFQeMMGrRjbBna0zIh9LKCv+NrvBYLdYdp/bIuWTm13xvvzfIRs9NA/XXlRzgQWMMhSr7iuheyxi1K1vx0U8s9myEnZZUNiJa8c0TVSpDG00pXbhHuf4OhaTdAloy6NAZg1U/DPJw8B7KCkjQa0/eFJcLbOIbimbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UYVVANHM3wvB1msXFVOqxh5OyQkDvk+AUvHW+84t01M=;
 b=BupqfgZL41pdI3vDwBN7DDbgeeiBCoobsfbazs9FMfGYZo8HBdPgN53rcSV5n+Y8+DpfZsJEkIOJnfkgCIVp+6bt7R4nnv5iabwQ8O3vbSCQHwzKY3nMhUvFEtIewGQEphCk1RzES/sPCXUW8wgVd+66gz1fQE6SjLLws9EZA1j7zD4vWAicnZUey8f9vxBSBFrX1ps+nDqxZLyOWmJyKlhn4ACHEmN4cHYSSyg4bXUFVOQYnqTt5CIT+UXbCyID5Fp5l34mMClbKXtZ2QvWtLxdGjL3MUTtwieh6aTUm7cWp0wI8zb5Vqeq6y7kWaltrZXrBxyHn1XFuEhoMttxag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UYVVANHM3wvB1msXFVOqxh5OyQkDvk+AUvHW+84t01M=;
 b=Q1NYcGRlS69t7Ch8sRiAGxp5SWH5DnGPKZKUM4QgqvX1+WypUYkZk66XWBUAyk2hjsAprjnxkyJOBwTwIZ3upaxuVJcZDu8Bk8xxWVyj6eSEwqO+W6HZK24iqPt/IdlU0cobZY6EAjvS3BuXeDv4T1CAcj7kZozA3xTXR2S1MS8=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by TYWPR01MB9341.jpnprd01.prod.outlook.com (2603:1096:400:1a4::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.14; Mon, 5 Sep
 2022 06:34:27 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::442c:db3a:80:287a%6]) with mapi id 15.20.5588.011; Mon, 5 Sep 2022
 06:34:26 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Naoya Horiguchi <naoya.horiguchi@linux.dev>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Jane Chu <jane.chu@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/4] mm/hwpoison: move definitions of
 num_poisoned_pages_* to memory-failure.c
Thread-Topic: [PATCH v2 2/4] mm/hwpoison: move definitions of
 num_poisoned_pages_* to memory-failure.c
Thread-Index: AQHYwO/fXMU3mQ/7RkusBuFIsQ2j2q3QYTYA
Date:   Mon, 5 Sep 2022 06:34:26 +0000
Message-ID: <20220905063426.GA1362182@hori.linux.bs1.fc.nec.co.jp>
References: <20220905062137.1455537-1-naoya.horiguchi@linux.dev>
 <20220905062137.1455537-3-naoya.horiguchi@linux.dev>
In-Reply-To: <20220905062137.1455537-3-naoya.horiguchi@linux.dev>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f84e622-9d90-44b9-b292-08da8f08ae0a
x-ms-traffictypediagnostic: TYWPR01MB9341:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QzwBGi2+xYxrka2OPo1WF2p3glKhZyvSuEJvpAs/lBkNcr3bOf7jA9gWe0JV9TgXex/fmoYk7ihAH6QVXCa/aW1sJ8o0eGKO+F7qtbK9cG1FWD4TMZQgOFjLcFpEwa1q+y8Tb4aQWPdFx0+mKFZIF+CImSFYvXCzUhjb1CXndizAs8FQfbVwlOxM+jeF0lKQr63SCMs9n/wSDjFBBImv3jLvWlziV3a0rKJzXkt/JJ7OE+7F/RFU+HujT2hhhqUsmmcPZt9gs1u5BAnGAnL/eWKamYa5GTQUGfrl4YrPTbXciVRmgWSZnzsYFMbx2jkgtjM4KmtiIxSQbrqw81IzE9O5NCAVvZz1UunUWHp2vvuNFNNpd8is9dFbx06+1E1TaXd4hKr0EXzlfLPvAh0bBIWpsGKWvIoXlwax/9A7ORYw5nR7yWqEfEWr4HZBVStzQBOLm5/3SvXt4Ee0pQ80CVSgzSsvpC0XVO3aZ/Fc3J1ImH7W1tplyOAAliA54qZZbI7YKzVEtElmi3pu7091eYsBEam16V1yLVvmkJV8fkcL7dbwWBAhjrPIDY2Sl42guPIb4Og6Khwf8pmQEGaaW8SmZUPdEDsxajefTPFFWt6ONF+BaP4vQ5ZvgwGTNFSBO8C4Fj929sqFM2RVcv3OOW/4gGl3u9OBxV08u/nIr66QUGwNZTJug5P8bfUbVyingNjFUftlR5sf57Nbx/KasshRwjPf0M7coaRqZAqzWxu5XPB7oy//qiKdiUpuZO1b+R/1KbT1H/hfIR698sHMqQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(136003)(346002)(366004)(39860400002)(396003)(186003)(33656002)(2906002)(54906003)(6486002)(6916009)(1076003)(316002)(55236004)(85182001)(9686003)(26005)(4744005)(6506007)(6512007)(86362001)(38070700005)(82960400001)(122000001)(41300700001)(71200400001)(8936002)(66446008)(8676002)(5660300002)(4326008)(66476007)(66946007)(64756008)(7416002)(478600001)(38100700002)(66556008)(76116006);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dUdGRVRwZFkrVXo4ZFRhb1BzNGhVNEs0M0hXZC82OUF1VVlOclpCd0VtYkEz?=
 =?utf-8?B?Rlg0eTlaYjUxaHZOUEVOQ0RKZDVjWm9Lekljd1plNTMya0UvOGJmSFUwM0J1?=
 =?utf-8?B?NDVqeWRkRnV1bWczRSttQ3NVbjcxOTJKeVhlVHA0aTJxa3NoV3dPbk50Q1pa?=
 =?utf-8?B?L2UrSDFjSmxkdUdnbUJYemhpVHhzUXRCT3FMbW1ndHBMMndhMEJJdk1GWDhJ?=
 =?utf-8?B?aHYvcUhET1dieG5ack9iQmNHNWtidThyTXZmbVkxRlF0R3FMVG5zeXBjREFS?=
 =?utf-8?B?TzNsekFzYit1Uk1rY0tDNVMzWDV2QlVyOW9PMXdqOWdiOFdWM2pEeWlxMFMr?=
 =?utf-8?B?TjBwbTFxTU1YaFV6SUIwM2R5WURIRlEycVlVZnhQM2R1ZWxCaDBwZEJ3V2dJ?=
 =?utf-8?B?aUNhY3NmUmovcEV3clpxOERnTDJTdHdVZzdwY0c5OHZGVGN3YUtFbXFiNXha?=
 =?utf-8?B?cDRpcmFJRGNLUTk4VjZnaWVNQ0tuR0c1T1JlM3g4cy8xeXFlUFJmTk9wYXJx?=
 =?utf-8?B?bVRycWEyeHN2Ujk3WE1RSHFTbGsxY01VcFlZMVRjQWRxUndoUENpR0hDajlL?=
 =?utf-8?B?MnhMa3ZoWFRIeC9rWmY5b1dGTTVMVytuK0swazhLMW8wS25ERDV2Z2g4dFB2?=
 =?utf-8?B?UVBxNUlJRVdYYy9DazRQcGhOdDZINEw2NERHcEVCSXM4bXd3NkJEd1BWYzRa?=
 =?utf-8?B?VjU0WTY5aExGeldRKzlpY2UvU21MTjdaUW4zbGJLa1gxdW8rVXVGNTRQTnEw?=
 =?utf-8?B?RjBmejVWSXZEMGJpWUhuQUU1S0FCbUVkbW05Q0FNWUlBanNWOWg0OExGeTFu?=
 =?utf-8?B?VXI4WFZLMElnd0VQOW0xVGY2MTZZTUs5U0gvdW1FVW9uWlRZczBhSG80YnZz?=
 =?utf-8?B?QVJoeXhEdXFZWjZGRy9OQlMwZnhKbTBiekFIblZsZEV1dHduSXRSVFBOMldC?=
 =?utf-8?B?VE4xM1R2VDhNQy9DM080VlRZRytmNXc4cklYQnYxMnNQY213ZDZxYUtqS1RO?=
 =?utf-8?B?T3oxMEJHUHFhVFc3dVc2Z3pBaUxjdVVhclV2UFM1c002b3I0Zi9ZckRUbURU?=
 =?utf-8?B?dGpEazdLdlFiMUI3YmRuY1JaWkk1UTByNldJV0MrYmJDNkdSSFpDS0lFZWUw?=
 =?utf-8?B?THV3K3MzS2s0d3VjcHBBaGhUWGpTRVpGZDZjSXFqcE93MWRxY1dDMTlacDBu?=
 =?utf-8?B?cGpuWURHd055NFNoUDBYckRIL0Z6TTN0cEMvdFFHM2tvVFU1SCt0dkpFNlgr?=
 =?utf-8?B?cnZwcVVLODNldG1HSGs2dzhyeEsxM1c3UHREbVFRdTh5NEJvSkpzY1l3c0dY?=
 =?utf-8?B?ODBRdVI4dWtMcE1qMm82V0ZUM2h4MGtoSEdZcmFDWm9ySFB0RjJrMlFIbmVD?=
 =?utf-8?B?MWZlbjhJN0k2U0xmdTNJclh6US83V2FtcFdRUzVjeFFGTlJYY1NBcC94dGlh?=
 =?utf-8?B?ekpjYU85UXYyWjRGMFZNMVBjdTlhamN0K2Iya1JONmxuS003U0RzSU80Vy81?=
 =?utf-8?B?NURyam01a2VDdjVUUVVjQkFmNlZlb1d0Y0czWGIwc3U0YmdKVzBhTWlWaS9W?=
 =?utf-8?B?ck9xMHBJRVhuQUxPNWZ4byswOGFxRlhCa2tYYzRyNTc3MTIvY3JQTitFV2FT?=
 =?utf-8?B?QmMxQjMyU2lSaU96NnRvb3lYR0RuMm5NSWlxcUJSQ1ZPWUhnS3A1T3lzbW0w?=
 =?utf-8?B?UmR3L25JTGFhMWNIZ1A1SXl3WURzRVFTc05sOTVOUThHNys5U0hQUTBseWNH?=
 =?utf-8?B?UDFLSnNzSmlBaFJRZjFNUmxKcUxuYW1oSlduSlpDU1c3d2VOdVJycW14S3Jq?=
 =?utf-8?B?cU0zeHNBWkZzUUJuU1FBcEo2djNOK0JpUEFhdFBvNzZJUEd6SUFaV25xV3Az?=
 =?utf-8?B?QWkrNzNzZjlCN0hTZ2F0Q0U1ZDVLZzZFMndLNFZ2dXBnRzUrUmNRekpPYUhK?=
 =?utf-8?B?MUdkWTl5UXVLaFR5dldSTzdCcGVZT3Fhc1ZxT1kxY3NFNHZIZ1NUTjg5WC9K?=
 =?utf-8?B?Q2RmQTJoY0I1SkE1SkZDdmVNUGx4Y3NGdE95NzdEMHBtdk9SbmJ5b1ZsTWN5?=
 =?utf-8?B?aDl2NzM0SWttYzBIbzBhSGFod25qSHdYbUVXS3k5VmRXTTVlZTBlYkN3K2Fl?=
 =?utf-8?B?S0tvNzZsT1Fpei81TzNPS3dsNW42QmMrZE91UStlT2MyT0dvQmxXNlloam9x?=
 =?utf-8?B?c1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <21764344C7EB334A8F3BA301EFE298A5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f84e622-9d90-44b9-b292-08da8f08ae0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Sep 2022 06:34:26.8324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Apj71+hQMBPaOytNbm4bwnpuyIL5sGtELDUt1jsMbE69QLlproYNXXbHvzpwhGITMegAv/7IjMTKe4Cn7qpYsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9341
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCBTZXAgMDUsIDIwMjIgYXQgMDM6MjE6MzVQTSArMDkwMCwgTmFveWEgSG9yaWd1Y2hp
IHdyb3RlOg0KPiBGcm9tOiBOYW95YSBIb3JpZ3VjaGkgPG5hb3lhLmhvcmlndWNoaUBuZWMuY29t
Pg0KPiANCj4gVGhlc2UgaW50ZXJmYWNlcyB3aWxsIGJlIHVzZWQgYnkgZHJpdmVycy9iYXNlL2Nv
cmUuYyBieSBsYXRlciBwYXRjaCwgc28gYXMgYQ0KPiBwcmVwYXJhdG9yeSB3b3JrIG1vdmUgdGhl
bSB0byBtb3JlIGNvbW1vbiBoZWFkZXIgZmlsZSB2aXNpYmxlIHRvIHRoZSBmaWxlLg0KPiANCj4g
U2lnbmVkLW9mZi1ieTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlAbmVjLmNvbT4N
Cj4gLS0tDQouLi4NCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvbW0uaCBiL2luY2x1ZGUv
bGludXgvbW0uaA0KPiBpbmRleCAyMWY4YjI3YmQ5ZmQuLmI4MWRkNjAwZTUxYSAxMDA2NDQNCj4g
LS0tIGEvaW5jbHVkZS9saW51eC9tbS5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvbW0uaA0KPiBA
QCAtMzIwMiw2ICszMjAyLDEwIEBAIHN0YXRpYyBpbmxpbmUgaW50IF9fZ2V0X2h1Z2VfcGFnZV9m
b3JfaHdwb2lzb24odW5zaWduZWQgbG9uZyBwZm4sIGludCBmbGFncykNCj4gIHsNCj4gIAlyZXR1
cm4gMDsNCj4gIH0NCj4gKw0KPiArc3RhdGljIGlubGluZSB2b2lkIG51bV9wb2lzb25lZF9wYWdl
c19pbmMoKQ0KDQpTb3JyeSwgY2hlY2twYXRjaC5wbCBmYWlscyBvbiB0aGlzIGRlY2xhcmF0aW9u
LCBJIHNob3VsZCd2ZSBnaXZlICJ2b2lkIg0KaW4gdGhlIGFyZ3VtZW50LiANCg0KK3N0YXRpYyBp
bmxpbmUgdm9pZCBudW1fcG9pc29uZWRfcGFnZXNfaW5jKHZvaWQpDQoNCi0gTmFveWEgSG9yaWd1
Y2hpDQoNCj4gK3sNCj4gK30NCj4gICNlbmRpZg==
