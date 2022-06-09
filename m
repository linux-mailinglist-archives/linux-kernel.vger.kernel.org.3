Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1940B544664
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241984AbiFIIuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242285AbiFIIuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:50:08 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2046.outbound.protection.outlook.com [40.107.113.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A8C27B9A1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 01:45:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jy0Lo25SF8rwQJu9IqX14aD1UwN4ZKJ8jVKSKNrscGN+INWO7Bn9A0tQ20jG7l4nFMriLhE+I2kxuBgmryBaD62UrzP6G/x3hcjGqmGVo+nff07xfGCcw4w+wO/Lnn2spBNrPoA5z3OCb5PDv5H+QqjHTSnzI6glsvD72c6W1HpoZ9aTFkyIRwT1GD8+IppEq6W3S9Ejgnd8uP5WK4K6vLwy9Nh5PP8DoCOnBhNhYR5ZziqK15jdrqPv3dyNWTBmUK/emK/okOPZ71NKXRVeqE2b6NlJQX1ObHZxqLRearPlDmTCj5aluFYje/b7kk0CTi8wn1gCh5SMdAskNS4k4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1h7Guhb+Vb6hKaX+kx3MqNMd9GUTs7Lbkz1dZMFs16M=;
 b=VtPdhiUn3Kv8anqyT1A3Vf+pB3yfspbfAlWUwI7kmntFzZJv95TGG9OO5n63YOZgA/PlPCDI2MbULeZLzvRjJs99mVAFRSaPVM3yDg7U9GCP5o1jdyz+CH7AyQ0HbyF7Yg0zUOTV8TIQmV/sJHg4GJYOSf59kz3rau66QkZc8iVpl0T5IovWY8XnjSCm6SraZ/oI5T8W21Nxv1aEMvW5C83Fuh2v0il7zPr8Q4VOQHKRHKQbC1H9O1IN93QBaS4q4klV83WRtzllkShH2ZVbG7/xmDZW5gtJE9df+Fi1CK7EicbloKeAdyJ5CkKkP9+7G7laAUWmmSsu8tqjCF3xcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1h7Guhb+Vb6hKaX+kx3MqNMd9GUTs7Lbkz1dZMFs16M=;
 b=kRhMLrBL3g4cQOLuUTEvqda8RqdCzpDrHDZbz38xr0LXH4xaYPcNaSqYx0ORB3EPuT+oJCPuv1PpVqMbQEC2JDQPVtt3WIE3AjwwayzONcz4J3k3plTIsEO1fCvHOfOGvPE7GB9EvBhPRVtfIqkk/OjHn6k3C8Gx22bpe2oLToc=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OS0PR01MB6387.jpnprd01.prod.outlook.com (2603:1096:604:104::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 08:45:57 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::246b:9355:73ad:b995]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::246b:9355:73ad:b995%2]) with mapi id 15.20.5314.020; Thu, 9 Jun 2022
 08:45:57 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH v1 5/5] mm, hwpoison: enable memory error handling on 1GB
 hugepage
Thread-Topic: [PATCH v1 5/5] mm, hwpoison: enable memory error handling on 1GB
 hugepage
Thread-Index: AQHYdj6nyGcEYLsXXE6UrwIIvDiJA61EBHMAgAENq4CAAG/9AIABTBIA
Date:   Thu, 9 Jun 2022 08:45:57 +0000
Message-ID: <20220609084556.GA1459006@hori.linux.bs1.fc.nec.co.jp>
References: <20220602050631.771414-1-naoya.horiguchi@linux.dev>
 <20220602050631.771414-6-naoya.horiguchi@linux.dev>
 <ff58b65d-e55d-04c0-e26d-3c92830b5912@huawei.com>
 <20220608061635.GA1413099@hori.linux.bs1.fc.nec.co.jp>
 <5743855d-8f22-0d82-56c0-1ab61ad431b7@huawei.com>
In-Reply-To: <5743855d-8f22-0d82-56c0-1ab61ad431b7@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1c427bfe-9def-4acf-747d-08da49f47903
x-ms-traffictypediagnostic: OS0PR01MB6387:EE_
x-microsoft-antispam-prvs: <OS0PR01MB6387AE2645249253C67E01BEE7A79@OS0PR01MB6387.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sMcWPgYKgchlplhaNwLaIra/rcj2cD0/JqmiEeSA23hg+yv7l2ssQqJn8BfbEfG1Oyb8wEp4On5nA/99OEmAUsxijDZsbcT8JXtriGl+P4C9+63HfNPpeYifaRsRH5tYSyEAvIXl7MRozNBEZCL9i0eEmoLdNgUfJw6rP+oXG0b1dDMXbqILv5ZrFJAzq15KtbrfwqMf3or1Kv4h11Cbjx75iRDeUAa7W+AQv6Ow6ySrBtTOFxUULd+syJg2QkMmDWbHWD7Vy9kcw1BGeg2dAYwdEVRh93hijNREeh/v7v5tECfKgOXtrODUkRsyPxlmQsm6HOeBwIbmRmj/p/49kCi+LUnAb3G5zZb/HL88xkne6GHj9cegOXtxHDgFk2bwyTKx918B776imYoo4MpWAIlMvOHG9v+9XZtelISUlmkn/1/DyWBxzz8SkFbfPFt6Zlk/av8iD4DZqAwe6RuxKTCgTgaf0p7N182CNLq13ME6WYpYGgd5eFi8ZRyAPSpIQqYt8kMJUCuOlbjEGiUrlZL5otkGe1rREG7B9whVSXWKe7X3FPQy16t875GPWwegvAqXSEI7XqRYlTBsgmhat3OigPvjpdyB5jBBh5Psl0Ql6mcKk6wpjhbHskTd3w/DnJt6iCmWwSWMKu1VUcecdVgxS5+nYZLiuI9KdrGtBRVsCX+RB9R+GxtmIzHTuKsYsif1sJYnzKYaT54PdNJKPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(4326008)(2906002)(8676002)(38070700005)(38100700002)(54906003)(64756008)(66446008)(1076003)(76116006)(66476007)(66946007)(66556008)(85182001)(6916009)(316002)(8936002)(508600001)(71200400001)(5660300002)(6486002)(82960400001)(33656002)(7416002)(122000001)(26005)(83380400001)(9686003)(6512007)(55236004)(86362001)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V25FUnIvOWhvNnpGaEo0aVJsNHIrUmkzNVk1RVlWQ1MyazZ6dm5SR2E0ckxv?=
 =?utf-8?B?YlRrclJzend1YnVuWFBKdFlGOVltOFRHV2l6ZkZTNXJ3ODc1RkFDbVVDWklQ?=
 =?utf-8?B?YU9yVUJNc05iWmxLb3o4a3FZbzB5dWxVdnoxRU5sN21IMURYdGFOcDVjOG5U?=
 =?utf-8?B?dGp1VFpFRjFLVHBkS080M3QxeUQ4VGhmNVVRb3IzSHo5K0JzSVRJUytIdktq?=
 =?utf-8?B?cWpxRVN2TTZLczFjVkgvMklYWWdET3RIbXdMcHl5K1RJa2x2ZkR6dG5XY1JN?=
 =?utf-8?B?dE41eFpMS0poN1I4ZEoybHlFSk80MlQyZmdESGk1MzViMHpDd2ZlRHErdUIz?=
 =?utf-8?B?TExPRjFMZUVwUHlxVTVmMnBDYXl4ZEFsTGRUUDNWQ3ZodDU2U2ZYdVdvOXNp?=
 =?utf-8?B?Q1FGSWErek9lUHYxOEdKV1pPOTViaUZ5MTVDY0xBbEJmaUpYbi9ienZaTUdB?=
 =?utf-8?B?V2NRd2RYNmRQeXNDTmZFYWh0Uzh2K2RQelZ5bGVXVng4c0wrTTVNajV4bUZP?=
 =?utf-8?B?Q1ZGK25jOG44eGJJaVpTR29pS21xSkFvK1JNSlhJalZxWFIreHNXUEZBVkdr?=
 =?utf-8?B?T2xsRU5YN201dVROU2tneFJRc2J4QkRKU3c3ZDh3cjZSOGJJNTZjSXF4TDha?=
 =?utf-8?B?c1grSmdWaFV2RVB0RDJHUUE5dlNJRDR3MUkybS8va2xWalRNNWR2MGhNb1Nw?=
 =?utf-8?B?NVVlSis3ZUgvbDNPa09Lc1czWStJWHo5VkVYSUllOHkwUHJjY0w3VWNpTG5B?=
 =?utf-8?B?cGsrWFVpM1B0ZHRSYUR5Q0hsdmFDUHh4WnRveGM5YXZ5ZndqNDJVaDFuWHlK?=
 =?utf-8?B?dS9KbXN2WVovcjRSY2NnYXZlNmtLTzhYemJUaEpTUm03VFhGb1Q1c09jK0dn?=
 =?utf-8?B?cXZucWV4R09oQUZscjkvYlZsZzNLeEcyVXlGaE9CMDR3THJFTjdTNG5tb3Zz?=
 =?utf-8?B?bGJqelFLUDJFNUZ4NnNuUVQwdmFjM1l0aWIydmtobUdOZmtCZ3FkbzRPYk5R?=
 =?utf-8?B?TWdDZ28yZzRmUmNOY2pwVC94ZUp1TlFTOEtna2Y1dFhpZ21pNjArVldLNGdB?=
 =?utf-8?B?UmhVVkNuL1BtalF1ZWpLTUdFcldYMGFwcTF0Qy9uYzZncDl6c0VRVDVVSEgr?=
 =?utf-8?B?QlRWZ0RvWlZzMzZVRHRJSi9XaXVZaEFGanIrN3A3WmVCaUhSZ1IrWWJkRFBl?=
 =?utf-8?B?TFRWQ0dIb0J2dllnNk95R0ZHYk9Va2JrYi9qcGNkU3hLMCsvOXJxM3JEQmlR?=
 =?utf-8?B?RlRJNlo3UnlaWVpvdElHU2FRYXJPRWF6ZHp6NDRkYlg2d1FDL2lWckFSL1RJ?=
 =?utf-8?B?bkVRUXhwaHZhQlFWNU92SnJNeHNvUVFCK05vYTNtbG5MeTVkZVFwQmJUSEU1?=
 =?utf-8?B?V29MY0JrcFhveFB0Z0dzcmhwL1lFQ2VCWENkbE9GMTN1RzlTRHJzbSt6YVJK?=
 =?utf-8?B?bmNUNUoycGdjTmVKcXRwaWdhUzhlNk1oYzBGWVlKbURpRXJoVTh2RGlYZG9i?=
 =?utf-8?B?bGtPcWovVllUcC9VTzlkWGw1QUgwUFBmRWxCT2RIRFVGTjNaSlFEZVp2YkZz?=
 =?utf-8?B?NzdmeUZiSU9sZm5DZ3BSbzBBR2xzQ3ZNZFQ0MTVGeStCOXpaTG04NG9ySEta?=
 =?utf-8?B?Z1IxVktJaVdSVnp3VXJCbVR3Sm4rcEw5TW10dnR3d1VwSGFneGl4R0Z6RnAz?=
 =?utf-8?B?dDlGcEhtMXZpamZFUGFSVzUxUTlEVHpuVzBlRkVzOHEyUEhLWVlTQXRmTUNz?=
 =?utf-8?B?aEJWeUIvcS9sbTJGRG5JNkFMSTJkNWNXOHpsbDkxSXJkai9MMEtMb1dJTjJW?=
 =?utf-8?B?SkhGdlV5QnVWTlpob0JZUmtDNWZibmp2UVVUSXN1YlQxMmduTUFFeWhycTd5?=
 =?utf-8?B?a0Qzek5MSjNheVllaWd6M0d4WVZrdHdQRTJHNjZSNGdoaGJ1N1FsUmZIaU1o?=
 =?utf-8?B?aE92eldEajRUNjhSMnl3WjRIOHh0NkZ3NXJjK21WK0NFdHRrWVZIZWJSTDR0?=
 =?utf-8?B?c3NOcXI3UU9uNzR1TFdFK0lhMyt5S0tvQm5uWWNtb3pySDVVTHhDSG5CUzgw?=
 =?utf-8?B?NU5GS2lnRmsvTEN6SWw5UVlTSFpuMFRZYjROcnZ5b1BjL1dRbStjcUZJemt4?=
 =?utf-8?B?ZDBQcjh6TUdnamRhTWhBWTNqM1o0cE4waFRNU3pWbXVhV3Z3NGV4TG1MK0tk?=
 =?utf-8?B?aCs4UDh4RUE0bW5zWDZickNibWt2enZJNHlaMXdnVkM3N2NOM2VCYlIwTXpi?=
 =?utf-8?B?Mnp1OWZPczRPSks0SlpaWXo0VGNPUjNGSE5mQVZRbTJ3OTRxTUI3ejlRaHo5?=
 =?utf-8?B?Vmc3YlVPV3p5dmFRT25XN3Jpc0NNUVE0cGh5QkFSMjFUWFVXNkVlTy83ek9Z?=
 =?utf-8?Q?9Z9uDHHKV55th3t0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <80DB42612F9AFC4B9AD2FC3BA246B183@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c427bfe-9def-4acf-747d-08da49f47903
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 08:45:57.4651
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w4Ou1/026m2HtEcMGXWq/LCfO7S7g5W56oIK7vG0PQtJ7xwCkTHzWdGQ1Lqqlhl35iujdOE668Sy3d1jAbmi6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS0PR01MB6387
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCBKdW4gMDgsIDIwMjIgYXQgMDg6NTc6MjRQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCi4uLg0KPiA+DQo+ID4gSSB0aGluayB0aGF0IG1vc3Qgb2YgcGFnZSB0YWJsZSB3YWxrZXIg
Zm9yIHVzZXIgYWRkcmVzcyBzcGFjZSBzaG91bGQgZmlyc3QNCj4gPiBjaGVjayBpc192bV9odWdl
dGxiX3BhZ2UoKSBhbmQgY2FsbCBodWdldGxiIHNwZWNpZmljIHdhbGtpbmcgY29kZSBmb3Igdm1h
DQo+ID4gd2l0aCBWTV9IVUdFVExCLg0KPiA+IGNvcHlfcGFnZV9yYW5nZSgpIGlzIGEgZ29vZCBl
eGFtcGxlLiAgSXQgY2FsbHMgY29weV9odWdldGxiX3BhZ2VfcmFuZ2UoKQ0KPiA+IGZvciB2bWEg
d2l0aCBWTV9IVUdFVExCIGFuZCB0aGUgZnVuY3Rpb24gc2hvdWxkIHN1cHBvcnQgaHdwb2lzb24g
ZW50cnkuDQo+ID4gQnV0IEkgZmVlbCB0aGF0IEkgbmVlZCB0ZXN0aW5nIGZvciBjb25maXJtYXRp
b24uDQo+DQo+IFNvcnJ5LCBJIG1pc3NlZCBpdCBzaG91bGQgYmUgY2FsbGVkIGZyb20gaHVnZXRs
YiB2YXJpYW50cy4NCj4NCj4gPg0KPiA+IEFuZCBJJ20gbm90IHN1cmUgdGhhdCBhbGwgb3RoZXIg
YXJlIHByZXBhcmVkIGZvciBub24tcHJlc2VudCBwdWQtbWFwcGluZywNCj4gPiBzbyBJJ2xsIG5l
ZWQgc29tZWhvdyBjb2RlIGluc3BlY3Rpb24gYW5kIHRlc3RpbmcgZm9yIGVhY2guDQo+DQo+IEkg
YnJvd3NlZCB0aGUgY29kZSBhZ2FpbiwgdGhlcmUgc3RpbGwgbWlnaHQgYmUgc29tZSBwcm9ibGVt
YXRpYyBjb2RlIHBhdGhzOg0KPg0KPiAxLkZvciBmb2xsb3dfcHVkX21hc2ssICFwdWRfcHJlc2Vu
dCB3aWxsIG1vc3RseSByZWFjaCBmb2xsb3dfcG1kX21hc2soKS4gVGhpcyBjYW4gYmUNCj4gY2Fs
bGVkIGZvciBodWdldGxiIHBhZ2UuIChOb3RlIGd1cF9wdWRfcmFuZ2UgaXMgZml4ZWQgYXQgMTU0
OTQ1MjBiNzc2ICgibW06IGZpeCBndXBfcHVkX3JhbmdlIikpDQo+DQo+IDIuRXZlbiBmb3IgaHVn
ZV9wdGVfYWxsb2MsIHB1ZF9vZmZzZXQgd2lsbCBiZSBjYWxsZWQgaW4gcHVkX2FsbG9jLiBTbyBw
dWRwIHdpbGwgYmUgYW4gaW52YWxpZCBwb2ludGVyLg0KPiBBbmQgaXQgd2lsbCBiZSBkZS1yZWZl
cmVuY2VkIGxhdGVyLg0KDQpZZXMsIHRoZXNlIHBhdGhzIG5lZWQgdG8gc3VwcG9ydCBub24tcHJl
c2VudCBwdWQgZW50cnksIHNvIEknbGwgdXBkYXRlL2FkZA0KdGhlIHBhdGNoZXMuICBJdCBzZWVt
cyB0aGF0IEkgZGlkIHRoZSBzaW1pbGFyIHdvcmsgZm9yIHBtZCBmZXcgeWVhcnMgYWdvDQooY2Jl
Zjg0NzhiZWU1ICgibW0vaHVnZXRsYjogcG1kX2h1Z2UoKSByZXR1cm5zIHRydWUgZm9yIG5vbi1w
cmVzZW50IGh1Z2VwYWdlIikuDQoNClRoYW5rcywNCk5hb3lhIEhvcmlndWNoaQ==
