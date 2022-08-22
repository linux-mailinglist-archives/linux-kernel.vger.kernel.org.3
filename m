Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2548C59B973
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbiHVGbI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233220AbiHVGbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:31:03 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90072.outbound.protection.outlook.com [40.107.9.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6ED17AA9
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 23:31:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CdNKtJNoeaxUii07nhbmcR7zt1WxRZX3M5uAAPzbfS7WYZH/PX8hhcMTar903p+37gBVcUPWnG8q7FBol0M1k1pjXK94tNdLSju8E9Lr22JmZWT+BpFScObErkpiZP4ltMuLL3n8rHH231tb0KnlodlHlfitRuo5RkJFusCJsTlUEcV9qwvPTKOx+i0Mny6RUJaYJ4/yKPDk8TVa6mksj/8cybgcUpfJORrxCg4qISaDL+gDGVtFwQrYoce3nST10aiH2DFS05xhxsrLngTGXGKe3agDHQ3KTsS5+7mekoFBO5o9VYSgvono6qr31AA2Imsjl9pUwp3/dKAfeHIDcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fWO7NPRxSiGT/egcs36Af3RSXWYehdenyXCbMcBomAE=;
 b=PjpEpEl8cNc3GcN38kmTO3jybyufyg4L2lDesIJvXQKrTC076wNqkgav246nwwc0G43dKYJlsgTBVoTkiDHxwJzt3YBRIrJS8pk1vUfecQILzHJzegP6+aasyGJYlRLyVSwuxv2xX7+8OmJYyxBNd1vZKO4FvgUKGtBo5eJ+7HmiL1uMcIMtwLZrSu1fk5nzporLdvGYK2F96304F8jvs4VHPH9KNqWJV5/WhGxHwT48stGjbP77wQWAGc+R3MH+wqRWEQp78LEUZAOtDlPqiLEE5wz0hOL5BKAZroLgYlPWbNpIDtYFhSDxycwgTUc2431ZN1P/ZFpjxV+gYrUhKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fWO7NPRxSiGT/egcs36Af3RSXWYehdenyXCbMcBomAE=;
 b=1HqL+5/1fdqzcJs/coSgNwCxGwmffP7LHawfieUEMccWDSY3+w/feQ1XZLJup84rgNZ+v1U+X//RTv4bRBo4AqfOspjr01jP50IZqRR+uEDVwVrYGX2e+PC88RwngLKqFzc9Ne2vflJmt6hQ5CndkwAcXEVTWTSv9q/gBnuF5/VSlP2LVr9R3zc9ns28jz1OoE+85JcS1kZxH75icGYy2czQqtC/w5mywcEo+eq+8ra4w5u6mM+ziTk54pCStD5pPOL2y+pgAxpzUJPqUiIcYJTB2NyL32mdUxy8ciLyaMv6QjqMqb+bXlQjRerq0GllJEEBWwBpRjN/LbwgsBn89Q==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MRZP264MB2200.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:17::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.17; Mon, 22 Aug
 2022 06:30:59 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::888e:a92e:a4ee:ce9e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::888e:a92e:a4ee:ce9e%5]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 06:30:59 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Baoquan He <bhe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 02/11] mm: ioremap: fixup the physical address and page
 prot
Thread-Topic: [PATCH v2 02/11] mm: ioremap: fixup the physical address and
 page prot
Thread-Index: AQHYtCx+rO/zUftR00aLhjCOF9ttT626eSKA
Date:   Mon, 22 Aug 2022 06:30:59 +0000
Message-ID: <e7f8798a-43ac-8083-93ac-4581bd2a5647@csgroup.eu>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-3-bhe@redhat.com>
In-Reply-To: <20220820003125.353570-3-bhe@redhat.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e0f4adc-3366-4aec-1e9f-08da8407e095
x-ms-traffictypediagnostic: MRZP264MB2200:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ectaUcPMR28XeBCU5KgO/SiizqAlfEt1smExCqfq6Gecv5w+a4MBHC9HqiVz4vrVnobrsARh6mZfPZ9UpC7gxPuGlNf1jLyvp9yI/6GrQ6iQzvhGWSWnsP3+k+nTMlL3j3C+T3CJE270hVIIfsChEBbzcz0ZgPVgoruq8zDF62v6kQpXz3t7etOhtNgxrT8Coup0RJ9PxdXSj6+n2MjhbP3xdCfFgk0sUSZK39edeGcsBuAD6UF6L9KXNhccLFv58Y1YXad1NXdrDdBsxhPxlLFt497SYo6RivX/P/xAUzoa/Q8DaB1x7MpqS6Pm5uSHy73s6UbtaCte2JEA2jtF+4kWQVtOb73y+aDkLxY1x85379gC7bcO+jyTvYz20Rn7BoAk5JfS2+J1tflutvlJU2TEUs3tqKtQjiWHftxLzdFo3/Rvk24EEHMaMsXRRjk4E0OWe0dYkWydEA7OmiNFwj1BuKG2bPitsYiH5TUiRsVgpuVjPGKZ+Z1f7hy3wwsJMpcJ2ujA3HNyywEWxdyaTViTjvPFm5H6/yNiw7PU7o+xw7Icof/Ro8kVNoIP1OBMWSKVaLLReUGeNHqcnHJb4dDCelw5DQFdiMK1Hth/FBBKLkNff2ohAEbXMDashnDAW1BvWeFNidR/MD7cyihR29MCtzBXldaM0mWpaCjemMJNGmUeZ6g94Bi0B8FGmL5SCMl+HziiUP4OtHLeD0PQqX5/HW5XyEuxKnsJN4++Edq0vuta1FfLnGPoE/Q+xwTSY6hoP17HNJF8ioeCdTDrYAkSPyQ4hwgsB2FHftJ6ayi3/DRKrZPOPsY3wANoeuBGh8U5i6Lolv6IvNsEi/VB+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(396003)(39850400004)(376002)(346002)(5660300002)(36756003)(8936002)(41300700001)(122000001)(44832011)(6486002)(91956017)(71200400001)(316002)(66446008)(66946007)(66476007)(8676002)(4326008)(64756008)(478600001)(76116006)(66556008)(54906003)(31686004)(110136005)(2616005)(6506007)(38100700002)(186003)(6512007)(66574015)(86362001)(2906002)(26005)(83380400001)(31696002)(38070700005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ny9JSU5udXE1VzJaZzVLQm5UVjlFUnZkQU5RZEl0SHliNTZlcWx6VklqNGdn?=
 =?utf-8?B?ZWs3NVNFWkFDbUVYbTVEUlFITWp6c1k1NUJsWUtmZGJadTNOMklyM0tlTG5y?=
 =?utf-8?B?cE81UDc4T0tRbHlJQmszZG9HbEdtMUVCZW80cmNxMkdOY1ZQL3oyUk92R3Mw?=
 =?utf-8?B?UEVrbWtaY0gwOTFxbFFYQ0IzendjMDYxRitTQkJZRHNZS0hJVUFjZTJoK1RV?=
 =?utf-8?B?eGRKYWI3amcxMmhFSGhPczBIeEtlMXhqbHhia0d4Vk5oWnViNmdFdHp5L3Iv?=
 =?utf-8?B?ZlVEOGI5VnhGbEJKUEhuUlhpR3FubXVwMUlUVjlDdTMxbUlFQThzUGNsNnVT?=
 =?utf-8?B?b05ocTg5aEJUZEc4RSt2SStlZXJ4clc5bkRCSjc5azA0UWJsOXo1OThpejVr?=
 =?utf-8?B?QkpuNXorRGpnSUZhR0lsQnVMY2FOc1JTMmoxMnNlS2dnVmliNklxSjRZZ0VC?=
 =?utf-8?B?US80OGRDbjUyZkR1TW9Kb2RUS0VheEMvOGZMY3pTWm1Dbjg3aFBXOU1teS9F?=
 =?utf-8?B?Mmtwa0xWc3hsckZSMTFmUmpsOUlsbHJKMjBnSE9HM2FlMGFpTk1xLy9oSVFJ?=
 =?utf-8?B?NXF1TjA2QTRyVjBFNk1yL2ZrWi9kQUNydG1oSTNPdlNMejlseWJJbWRmcVVv?=
 =?utf-8?B?YjFaOEpJNUpZVVJRemZrTGdyY2taejVqVEdJT3JNdVhpQkw3M1Z6K3ZHZ3dk?=
 =?utf-8?B?L0djUll0WmlFWkduTi9zdmc5ajNRdXA0MGZRT1JyTnY4SXlkTlJuTm1PL1FH?=
 =?utf-8?B?UmY1YlJFYktkN0pBYk5FdE9uUUZOSDRPbUxTVnBoQkFPK25JTE1GRFFOczdm?=
 =?utf-8?B?QWsxbWJid0F0M0lYUkh4TWwxZS9CZGFRcFJaU3EwK2NkQ2IvS3JmTHcxRGEx?=
 =?utf-8?B?TzE1MjlPSG9ZSWNWNzB6WmdMZzNLZVZyelgvZkYzTVVwK1ZmSEVjcTV1UzFw?=
 =?utf-8?B?ZlVsRDZKeTd2RUtYL2JYSDRJTERaRnVvejYzZ2ZHdTI4ZGJ2MG42blZXMTRN?=
 =?utf-8?B?R1UxZW1PT3lMc2gzeXdoWkFzN1NyRFVqbXowQnhmb3VqNGFHbEdJWXhMejJF?=
 =?utf-8?B?TitxYldHWFVrU0pkRHFhZFo0aGhudUZnYmFsaG9FbFd6M29NeVZtS20xWEh4?=
 =?utf-8?B?cTJER29wUlFvd2dxd01SR3ZWRHBIUHlsKzJVdSs2WEZyWHBYZE5jWUNkdmpC?=
 =?utf-8?B?U2JxZGFHd0duN1dNSGVkcEkwS0xEcEZubUdvSExheUFncVA2Z1M5ckt4OHlL?=
 =?utf-8?B?YWNGbFZIYXhFaVRKWEU5Qkkrd3lRYWQrM3pidmpBVGQzVUZnNHF4NmtaRVdO?=
 =?utf-8?B?QTJSLzBEemxpUDFPdzBBTGh6MFMvSitwR2hRclZTb294WVNVWnBaM1EvMVA1?=
 =?utf-8?B?TUhHbTlNc1FzbDcvdno0UlBXSHFDRHJNYW5KMWNEZzdNeHdiMDFmMUUzMno3?=
 =?utf-8?B?citiT3hod1ByUTRxcXNEaUpET2dDMk9iY3VWWFRDS3ZvRjRQaDdhWWZGOWJD?=
 =?utf-8?B?U0hMNEtIUHk1eVRtS2xEcHVBT2ZCeWEvcmJHRXJ0TmFvT09xUkZ1UDYxcGVl?=
 =?utf-8?B?TWxBMHAxcUU4RzViN2ZjRXByRkQyUUpKbk5ZU2UrWGRmUEF1a2U3RythRXFT?=
 =?utf-8?B?am5adjJlejZ0OHNvdXhVNm9RQk16a1JpOTEzTWJhNnFndDlKT24zK2cveStl?=
 =?utf-8?B?MTh4bVJHcEhCTi93ZVE3MGUxazNid2lqdEtXL1BHTm53dHJKUkw2TVFWYytj?=
 =?utf-8?B?RGhSbmVKZmZ6anVlV2FrcDllRGo2OGRRY1Z5eTE1VkVzb1phN3I4ZWdEc2M0?=
 =?utf-8?B?Ykdua0tIR0lzaXNDZElrcUh5RnFXc050c1E1YkdUTHlNaWZraUxDcTQwR0hu?=
 =?utf-8?B?RlRyRldxV2x1WFBhbVZuVGFHOVBBclB5Sjlsdy9iaTRONndoQTE3ci9WUlpC?=
 =?utf-8?B?NG1kTmN5dWpWUkRSSnA4bTR5MWJwSzFuL0hWYUlhSVhSUWJaaWtvTXVZcVZz?=
 =?utf-8?B?Zy9lQXlteE9ibnFwS1ZYYWRtSXVYS3RrbGtUU2hnWC9PRTluaE14U2krV3hz?=
 =?utf-8?B?T3IvTFNkWEh6VlVCYU9Tb3RHVGVVOGJXaHZTWE92SFIzWmxkZGlTR25NU014?=
 =?utf-8?B?ZVh1K0xsZmV6bHMzZjNXZW1VcC8ycURUY0NkVHFQdi84Vng2R1J2UHlIdGlV?=
 =?utf-8?Q?iS6hvqLMLTvF0UCZmkJR1Lw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <779A4AE1FD7AE5448E3F7BF09EB18886@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e0f4adc-3366-4aec-1e9f-08da8407e095
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 06:30:59.3697
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VgUoExB1JrXKfPSZwb/EsJ6d1VRfUCq8rHK/EZ98imIO0PT3Bqj+hschOPaLPeoU7P48GKnR+B7MwYPqHwUqepuEQs6CQVrTwwlIE5Yn8YY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRZP264MB2200
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDIwLzA4LzIwMjIgw6AgMDI6MzEsIEJhb3F1YW4gSGUgYSDDqWNyaXTCoDoNCj4gT24g
c29tZSBhcmNoaXRlY3R1cmVzLCB0aGUgcGh5c2ljYWwgYWRkcmVzcyBuZWVkIGJlIGZpeGVkIHVw
IGJlZm9yZQ0KPiBkb2luZyBtYXBwaW5nLCBlLmcsIHBhcmlzYy4gQW5kIG9uIGFyY2hpdGVjdHVy
ZXMsIGUuZyBhcmMsIHRoZQ0KPiBwYXJhbWV0ZXIgJ3Byb3QnIHBhc3NlZCBpbnRvIGlvcmVtYXBf
cHJvdCgpIG5lZWQgYmUgYWRqdXN0ZWQgdG9vLg0KPiANCj4gSW4gb2RlciB0byBjb252ZXJ0IHRo
ZW0gdG8gdGFrZSBHRU5FUklDX0lPUkVNQVAgbWV0aG9kLCB3ZSBuZWVkIHdyYXANCj4gdGhlIGFk
ZHJlc3MgZml4aW5nIHVwIGNvZGUgYW5kIHBhZ2UgcHJvdCBhZGp1c3RpbmcgY29kZSBpbnRvIGFy
Y2hfaW9yZW1hcCgpDQo+IGFuZCBwYXNzIHRoZSBuZXcgYWRkcmVzcyBhbmQgJ3Byb3QnIG91dCBm
b3IgaW9yZW1hcF9wcm90KCkgaGFuZGxpbmcuDQoNCklzIGl0IHJlYWxseSB0aGUgYmVzdCBhcHBy
b2FjaCA/IFdvdWxkbid0IGl0IGJlIGJldHRlciB0byBoYXZlIGhlbHBlcnMgDQp0byBkbyB0aGF0
LCB0aG9zZSBoZWxwZXJzIGJlaW5nIGNhbGxlZCBieSB0aGUgaW9yZW1hcF9wcm90KCksIGluc3Rl
YWQgb2YgDQpkb2luZyBpdCBpbnNpZGUgdGhlIGFyY2hfaW9yZW1hcCgpIGZ1bmN0aW9uID8NCg0K
PiANCj4gVGhpcyBpcyBhIHByZXBhcmF0aW9uIHBhdGNoLCBubyBmdW5jdGlvbmFsaXR5IGNoYW5n
ZS4NCg0KQ291bGQgdGhpcyBiZSBzcXVhc2hlZCBpbnRvIHByZXZpb3VzIHBhdGNoID8NCg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogQmFvcXVhbiBIZSA8YmhlQHJlZGhhdC5jb20+DQo+IC0tLQ0KPiAg
IGFyY2gvYXJtNjQvaW5jbHVkZS9hc20vaW8uaCB8IDMgKystDQo+ICAgYXJjaC9hcm02NC9tbS9p
b3JlbWFwLmMgICAgIHwgNSArKystLQ0KPiAgIGluY2x1ZGUvYXNtLWdlbmVyaWMvaW8uaCAgICB8
IDQgKystLQ0KPiAgIG1tL2lvcmVtYXAuYyAgICAgICAgICAgICAgICB8IDIgKy0NCj4gICA0IGZp
bGVzIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYg
LS1naXQgYS9hcmNoL2FybTY0L2luY2x1ZGUvYXNtL2lvLmggYi9hcmNoL2FybTY0L2luY2x1ZGUv
YXNtL2lvLmgNCj4gaW5kZXggZGQ3ZTFjMmRjODZjLi42YTU1NzhkZGJiZjYgMTAwNjQ0DQo+IC0t
LSBhL2FyY2gvYXJtNjQvaW5jbHVkZS9hc20vaW8uaA0KPiArKysgYi9hcmNoL2FybTY0L2luY2x1
ZGUvYXNtL2lvLmgNCj4gQEAgLTEzOSw3ICsxMzksOCBAQCBleHRlcm4gdm9pZCBfX21lbXNldF9p
byh2b2xhdGlsZSB2b2lkIF9faW9tZW0gKiwgaW50LCBzaXplX3QpOw0KPiAgICAqIEkvTyBtZW1v
cnkgbWFwcGluZyBmdW5jdGlvbnMuDQo+ICAgICovDQo+ICAgDQo+IC12b2lkIF9faW9tZW0gKmFy
Y2hfaW9yZW1hcChwaHlzX2FkZHJfdCBwaHlzX2FkZHIsIHNpemVfdCBzaXplLCB1bnNpZ25lZCBs
b25nIHByb3QpOw0KPiArdm9pZCBfX2lvbWVtICoNCj4gK2FyY2hfaW9yZW1hcChwaHlzX2FkZHJf
dCAqcGFkZHIsIHNpemVfdCBzaXplLCB1bnNpZ25lZCBsb25nICpwcm90X3ZhbCk7DQo+ICAgI2Rl
ZmluZSBhcmNoX2lvcmVtYXAgYXJjaF9pb3JlbWFwDQo+ICAgDQo+ICAgI2RlZmluZSBfUEFHRV9J
T1JFTUFQIFBST1RfREVWSUNFX25HblJFDQo+IGRpZmYgLS1naXQgYS9hcmNoL2FybTY0L21tL2lv
cmVtYXAuYyBiL2FyY2gvYXJtNjQvbW0vaW9yZW1hcC5jDQo+IGluZGV4IGIwZjRjZWE4NmYwZS4u
ZWY3NWZmZWY0ZGJjIDEwMDY0NA0KPiAtLS0gYS9hcmNoL2FybTY0L21tL2lvcmVtYXAuYw0KPiAr
KysgYi9hcmNoL2FybTY0L21tL2lvcmVtYXAuYw0KPiBAQCAtMyw5ICszLDEwIEBADQo+ICAgI2lu
Y2x1ZGUgPGxpbnV4L21tLmg+DQo+ICAgI2luY2x1ZGUgPGxpbnV4L2lvLmg+DQo+ICAgDQo+IC12
b2lkIF9faW9tZW0gKmFyY2hfaW9yZW1hcChwaHlzX2FkZHJfdCBwaHlzX2FkZHIsIHNpemVfdCBz
aXplLCB1bnNpZ25lZCBsb25nIHByb3QpDQo+ICt2b2lkIF9faW9tZW0gKg0KPiArYXJjaF9pb3Jl
bWFwKHBoeXNfYWRkcl90ICpwYWRkciwgc2l6ZV90IHNpemUsIHVuc2lnbmVkIGxvbmcgKnByb3Rf
dmFsKQ0KPiAgIHsNCj4gLQl1bnNpZ25lZCBsb25nIGxhc3RfYWRkciwgb2Zmc2V0Ow0KPiArCXVu
c2lnbmVkIGxvbmcgbGFzdF9hZGRyLCBvZmZzZXQsIHBoeXNfYWRkciA9ICpwYWRkcjsNCj4gICAN
Cj4gICAJb2Zmc2V0ID0gcGh5c19hZGRyICYgKH5QQUdFX01BU0spOw0KPiAgIAlwaHlzX2FkZHIg
LT0gb2Zmc2V0Ow0KPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9hc20tZ2VuZXJpYy9pby5oIGIvaW5j
bHVkZS9hc20tZ2VuZXJpYy9pby5oDQo+IGluZGV4IDdiNmJmYjYyZWY4MC4uZmI5YmRhMmJlOGVk
IDEwMDY0NA0KPiAtLS0gYS9pbmNsdWRlL2FzbS1nZW5lcmljL2lvLmgNCj4gKysrIGIvaW5jbHVk
ZS9hc20tZ2VuZXJpYy9pby5oDQo+IEBAIC0xMDU5LDggKzEwNTksOCBAQCBzdGF0aWMgaW5saW5l
IHZvaWQgaW91bm1hcCh2b2xhdGlsZSB2b2lkIF9faW9tZW0gKmFkZHIpDQo+ICAgICovDQo+ICAg
I2lmbmRlZiBhcmNoX2lvcmVtYXANCj4gICAjZGVmaW5lIGFyY2hfaW9yZW1hcCBhcmNoX2lvcmVt
YXANCj4gLXN0YXRpYyBpbmxpbmUgdm9pZCBfX2lvbWVtICphcmNoX2lvcmVtYXAocGh5c19hZGRy
X3QgcGh5c19hZGRyLCBzaXplX3Qgc2l6ZSwNCj4gLQkJCQkgICB1bnNpZ25lZCBsb25nIHByb3Qp
DQo+ICtzdGF0aWMgaW5saW5lIHZvaWQgX19pb21lbSAqYXJjaF9pb3JlbWFwKHBoeXNfYWRkcl90
ICpwYWRkciwgc2l6ZV90IHNpemUsDQo+ICsJCQkJICAgdW5zaWduZWQgbG9uZyAqcHJvdF92YWwp
DQo+ICAgew0KPiAgIAlyZXR1cm4gTlVMTDsNCj4gICB9DQo+IGRpZmYgLS1naXQgYS9tbS9pb3Jl
bWFwLmMgYi9tbS9pb3JlbWFwLmMNCj4gaW5kZXggOTlmZGU2OWJlY2M3Li43OTE0YjVjZjViNzgg
MTAwNjQ0DQo+IC0tLSBhL21tL2lvcmVtYXAuYw0KPiArKysgYi9tbS9pb3JlbWFwLmMNCj4gQEAg
LTE5LDcgKzE5LDcgQEAgdm9pZCBfX2lvbWVtICppb3JlbWFwX3Byb3QocGh5c19hZGRyX3QgcGh5
c19hZGRyLCBzaXplX3Qgc2l6ZSwNCj4gICAJc3RydWN0IHZtX3N0cnVjdCAqYXJlYTsNCj4gICAJ
dm9pZCBfX2lvbWVtICppb2FkZHI7DQo+ICAgDQo+IC0JaW9hZGRyID0gYXJjaF9pb3JlbWFwKHBo
eXNfYWRkciwgc2l6ZSwgcHJvdCk7DQo+ICsJaW9hZGRyID0gYXJjaF9pb3JlbWFwKCZwaHlzX2Fk
ZHIsIHNpemUsICZwcm90KTsNCj4gICAJaWYgKElTX0VSUihpb2FkZHIpKQ0KPiAgIAkJcmV0dXJu
IE5VTEw7DQo+ICAgCWVsc2UgaWYgKGlvYWRkcik=
