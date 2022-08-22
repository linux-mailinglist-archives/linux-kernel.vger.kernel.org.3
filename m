Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D515159B9AD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 08:39:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbiHVGiz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 02:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232602AbiHVGiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 02:38:52 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120084.outbound.protection.outlook.com [40.107.12.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBAB1DF17;
        Sun, 21 Aug 2022 23:38:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjRexMizBAHZpG/VcWe1MaPuX1N0iZu/PYN/qU10+CDnSUK0QBWRsz/lO3HU28XmoGxS46cKlkkmeZH0RB5D2Q+8mqoznxsYCtMSu0snRAMGqbO3LJrbWpFGq/D9JGqWpAx1R9bG6efpx/kvfiUXtInOEgiXPzbPyiEApDJsEEly/0mk9HPGnXXBF/+PsTqH+Qq3zoZUkYoY3xdVgelTBQg5cl4gTMVVMKjqJIsUAPO+9DHjjFbsUHGNS+F+S1oSISkn+6eHatcv3Xk0ZapeBKITI6k5PvXOeNSB3PEPgGYW0Nn3Tp3COMnB9w0olYhnaD1je8jJoyV3HOfWCtf5yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EjA9leuYksvAEMLie7qinMpnOegQl0jGh2C8hjE61uA=;
 b=PTuR97WiOoO6aGxqKZXZk1/0D+haI/5SS+nCFnpBuOPEznc3ITemkIp/r3TRuZWAoKkSOpwIRKitgPIWVq6VZ/K7bWPG0rtE1x1C56qtUvPHmgO9nYNfSDY1iDCVS3sESGY4tH0wSl9e0UbKIRkCu3Sw7SQZpUNOh8JLhN5hHThrE9hexJOjAlVcWKqUC85ZJ53Zad2qKbQHR+aIpt9w72/bUhS/RGEC+Vs18WVEjIu7snujbRNAvHihl95+2rp2lPidotU9EkqhSFmyx9IFXht7ZZlOJmzTjr2UdQFq9SY2PhSjj//a1U3FH89q/0pGsGQlVnMTH5cW5nov6At1Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EjA9leuYksvAEMLie7qinMpnOegQl0jGh2C8hjE61uA=;
 b=IdKfeG1JAPbKey/DZMVBZfx3C4l+cdFShlTgVimtXMqpdPVSOMwLOGFAL8+K7MUnOGIjnhZEt65hqvEA/RWiraKPppbOB3dXHBjJa0W3BvnsXltKZixom5RksOjbOyH3FY9Vw4qv6W+PgttIJJAIYfelmaBMuoz4T2MTvfej3ldZ9cqXCGv70RAsmqkDjCqMVSsGNlKH9ud1FomkkN4d7Ierju21zl9VqF4hX/8sFPq0HwZe17DlYv2K3mak5vBdi7ha3SLz7hz29UrI0RoiN/b16sU5vST8YMh6S89tiP8BSiun1zhO8efCDak+AqpNToz+31luPyOD93swJ5sc1w==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB1876.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.18; Mon, 22 Aug
 2022 06:38:49 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::888e:a92e:a4ee:ce9e]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::888e:a92e:a4ee:ce9e%5]) with mapi id 15.20.5546.022; Mon, 22 Aug 2022
 06:38:49 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Baoquan He <bhe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "agordeev@linux.ibm.com" <agordeev@linux.ibm.com>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Brian Cain <bcain@quicinc.com>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>
Subject: Re: [PATCH v2 05/11] hexagon: mm: Convert to GENERIC_IOREMAP
Thread-Topic: [PATCH v2 05/11] hexagon: mm: Convert to GENERIC_IOREMAP
Thread-Index: AQHYtCxFHZAbUaNZi0e9nWxT0wjQk626e1IA
Date:   Mon, 22 Aug 2022 06:38:49 +0000
Message-ID: <f7642f34-80a8-3215-b441-b7432f6a22b1@csgroup.eu>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-6-bhe@redhat.com>
In-Reply-To: <20220820003125.353570-6-bhe@redhat.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6e9a6587-3425-43bd-01e4-08da8408f8ae
x-ms-traffictypediagnostic: MR1P264MB1876:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mEj42T2qQu7gYJ9XCza23wyKt39aVu+MMyq0FbPsWsxrLfjdq/4VL/ajx66Wj5R0ane1S3a+qRAGadKY3Kbno2N985osV9DmuVNqsQNTvPgOEB6LYBIXJr0yTkOkhIRR90Iyw9vrP5EZdf9Zb8hxs/KwrVykzxfO/az1d87XYkYcBnFlbWKgbWrCurzDIInsYG5a1YcMS/RfRlxwUUGP/mSscHp49oI25rGaq55a/yP9YePU5xk5WtsD/pF6uNR/xmQhVAdq7cVIwYDcHilmV7do/slCHOKWlEdj23hV2DbMCd9NMSUek4a3D62bbxUaenvdU4ncQAw/5bVLrjNSvrjVz61bI5kpdibV46NbafREZS+kBEn2mbinV2vjO7pA+Rj2fHvG7ciwGA6RQVcqprUhjVKIBpCFWzjalhPBkNafptsKLUSZYdNv7Tsb0gI4gnJeKG/mk8S3aqrJzztoo4Zb3H3YP5TxW8XgE88ZTel2+/lYiTShbuu4ilGyXe7+gBtvzjTmyA1TKpkiinOUWTTK/9mwTCHyS/YH2gx/DrFzxnPIvpKQMHZmsGLopNWZtjAqS2qG3+xf4V/9VKGX25wr5lVSrp+NU0Fb94pafUV/rip9AOaSBNslIyLpbkjhQ8xUPtXGz2flv/qTVn/laLU5zVF/y90mAECd/aLrdGPcwCzS4VQGP8JZK3nyHYBe0De2GEVfbU/59LMqVAcTWLQgshnenhwiYutv5ns6ar3Dr4xe7Wi2WfXAhE41x0JxIxX1V89RWdiVpg6/+AmywTVofXVm+PQthqfQaE0LjFx0EmEfuQrQikBjuuK9y4eq8YUgtqM1sBks8nNfRZifMepPm5OJcpnaRybKXVI9ObQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(376002)(346002)(136003)(396003)(366004)(66946007)(76116006)(66476007)(66556008)(66446008)(64756008)(8676002)(4326008)(91956017)(54906003)(110136005)(38070700005)(36756003)(38100700002)(122000001)(31686004)(31696002)(86362001)(66574015)(186003)(6512007)(26005)(6506007)(478600001)(41300700001)(71200400001)(6486002)(7416002)(316002)(2906002)(2616005)(83380400001)(5660300002)(8936002)(44832011)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RmgvSW44U2tmYWZYNHJVVlQ3VjVReTVUQVg0bkJmbWRxV2F4djJJSEMrb2xj?=
 =?utf-8?B?dVZSUEl0dE9KbkwzWTl5QktmQWZ3WlBOVzlSYVRCYmp6QUtycEdCTS9qVHph?=
 =?utf-8?B?MVV1NkxSZ2x1bnF6Y2VIUjNnb2FLQzIxK0tWTzhtUlBJYUFiTit0UjlmVTNv?=
 =?utf-8?B?K2V0Tk14MXJUYjliSXdQcTVQZi9DMGlWUkhRNElnU0NuRFN3djcvMWhGenpa?=
 =?utf-8?B?U1kvNXQ4MG5OTFR2dXZ4djVyQXUySWhwNXQvRnBvMFh4MDBaZDVZdFB2dndu?=
 =?utf-8?B?U2JGV2ljVURmN2JZOXNaYVVsKzNXTmp2UFZmUlBScGZ4eHF3c25FK1N3ZVBK?=
 =?utf-8?B?Q3ExWmlISkhDTkxGUkRXQUZxdmhPcmpORlRoS2xqUGg1UkR4VjQ1cDk4RkJB?=
 =?utf-8?B?bnhhUFJtWXJWSnZJczQwUDlWREYxY2hIM3Exbk9vVEhDL1lqRnJlNmk4eG9o?=
 =?utf-8?B?RnY5dGlEa09BQXo3aVJLWi9JYjFQQlBOdlUvYy9GWkEvdkJ2N1JWZ3BCSGNw?=
 =?utf-8?B?MTNXNDlwRmtqcHZ1SDhBcXVNODdqNXJUak5FVWtnMEh1U2ZRUEpDNWtkWVVC?=
 =?utf-8?B?TmI3NzMwdktWalB2bTU4eW53UzBWbmFxTnl1endIRmVaSXZ1R0FtSkZaMStK?=
 =?utf-8?B?Y3dvaTlyVFdBVUpjbWs0YmJ6ZzdTSDgzMUZXaW5XbUNGenZNY0lNclJxVis2?=
 =?utf-8?B?N0JrNzJ6RU54K3NFNGhPbVVsK1ZFZmtXbmI4TzIzKytCSjFGTTZ6NWlLbnFP?=
 =?utf-8?B?SXM4VjJjWHREWnIvZEhHVDRQVjBpZ0tpV2RnYlQyMTVRT1N3NEhLdm9veUti?=
 =?utf-8?B?UStVQ1owRGxyU2tWQTN1TUhONXkwWlBBeW1JYXVqU2RVOE9RYVlPU2Z3Q3Nj?=
 =?utf-8?B?cUJja0ttcTNPYkpRTVhWbDByN0swR0tnd3AyRTJidlptaHBocWJXSEt1Z2Nt?=
 =?utf-8?B?d0w2NnJTREM0Z3Z5UmFQVXg2VzNkNlk3eCsrbW5tSTUwNG4zRVpoblNZTW5C?=
 =?utf-8?B?NFVTSm5YWEU3N3QvWnp6WHF3M2JmNkN2RXI5MlMyYVdkTkZYdld6bzdIVDBE?=
 =?utf-8?B?cW81MkpWN1hDa3JySWx0akF4c29BRHVldng1RnZ6QXRBWXF0NTJGK3ZmemFT?=
 =?utf-8?B?dFc5S3JraElzTWlJQnBxWkZGc2pPbWF1aGQwYnBCV1FXdGZZUDJOck56cmp1?=
 =?utf-8?B?QzFkei9obGZjeWlFTHY2MHo4RmdJd3o5bjdvZDZSYWFqRlcxL2kzL2paYjVJ?=
 =?utf-8?B?N00zY0xxSUtuZzQzTStxMDRBMm5ZdWxCUk55NXF5ZW9tVDd6RzkzTWtKSXEx?=
 =?utf-8?B?bHNMQ2J0bnpyR3ZQY2d4L2lrTkxZR2xlVWNvdytKWFhubVBMbHBDa3FUQTJk?=
 =?utf-8?B?d3EyQ0o2bXVJQ0ZLWmRPR3ZOMjhaeGcwb3FMMzZuU1VYSnphdmNjUjJ1M2Ey?=
 =?utf-8?B?bFBsalFqeWM2dUJ5elJhaEFWWWNabWNhVXRqYXpWVWx1Yll5RW9jbnAwMWNQ?=
 =?utf-8?B?WmZZTW5vL2l0R3dVcTNXck5FOWZ0OGlWQjQ1TE1uVUVDYk9QTiszK0I0OGFW?=
 =?utf-8?B?ZHlydVZlTS9iNDNtMktQcWgyeGR2cUJvZXRpZXBDbUlPSEtkT2tja0JjSkgz?=
 =?utf-8?B?c1JnNHJmUWVRa0RySDFyNlFpeWRNcGRpV04vWFRySFdkdlhaUlJUdXFoSDl1?=
 =?utf-8?B?dTV5bkIwRHl5K0p5MWUvUVcvWW40SEo4K1Y5cWlsWGVvLzM1NTgzTmpFZzlo?=
 =?utf-8?B?cmFjR0gzYVpWM3NvZUovRU5JeE5UT1VsS3lRRVdzUGFpOE02aGJvdHRqOVJO?=
 =?utf-8?B?LzRCMnlsRk1uWFZSSmJ3azNjdFdabGZtb3VTVUNLQ1c0eEJxRDdDN1ZWNjJw?=
 =?utf-8?B?U2hkWERhVEd4K2FacnVGNTBYR2NLTzdmSlQvcms1VWkxQlVwbWVpVEZ0UkNH?=
 =?utf-8?B?NENpdzBVdlBjMzQrZDNzWEdSMlJTbFhVTmorNDFvS1dITFVyY0Z5eWF1YVBx?=
 =?utf-8?B?b21NNU5wbjZuRGVoTUtvc28wR3BXc0gwSU9uaGp1VEZmSS9LVlJ0STc2MkN0?=
 =?utf-8?B?bmFYaGplblRVRnAvcVNKdUxCY05LQVlxY21wYVpWVjJ3Q3lId3BOVXM1UnpF?=
 =?utf-8?B?L042VTFpOE43VlhxMTg2NGFGSW1yZ0QrSUFMd3pFUTc2Mmlva08zaWdhSHIw?=
 =?utf-8?Q?zF057nC5dp0QWsxlx05koEg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <47573E762CAD4D408958B1638406FB81@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e9a6587-3425-43bd-01e4-08da8408f8ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2022 06:38:49.2947
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ImHD60UDqoUHNi3lE6txCpPxsviGnN3Vpbmn6fKBVfjmJQrs6WSjDuAlPoBtDu41FmVnarXlRYbMEeIq8uqSXYkYWWlBHH2Zm9AqPFPQzJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB1876
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDIwLzA4LzIwMjIgw6AgMDI6MzEsIEJhb3F1YW4gSGUgYSDDqWNyaXTCoDoNCj4gV2l0
aCBpdCwgdGhlIG9sZCBpb3JlbWFwKCkgYW5kIGlvdW5tYXAoKSBjYW4gYmUgcGVyZmVjdGx5IHJl
bW92ZWQNCj4gc2luY2UgdGhleSBhcmUgZHVwbGljYXRlZCB3aXRoIHRoZSBzdGFuZGFyZCBmdW5j
dGlvbnMuDQoNCkkgc2VlIG5vdGhpbmcgcmVsYXRlZCB0byB0aGUgcHJlcGFyYXRpb24gcGF0Y2hl
cy4gQ291bGQgdGhpcyBoYXZlIGJlZW4gDQpjb252ZXJ0ZWQgd2l0aG91dCBhbGwgcHJldmlvdXMg
cGF0Y2hlcyA/IEluIHRoYXQgY2FzZSBJIHRoaW5rIHRoaXMgb25lIA0Kc2hvdWxkIGdvIGluIHRo
ZSBiZWdpbmluZyBvZiB0aGUgc2VyaWVzLCBpdCB3b3VsZCBoZWxwIHNlZSB3aGljaCANCmFyY2hp
dGVjdGVjdHVyZSByZWFsbHkgbmVlZHMgdGhlIGNoYW5nZXMgdG8gdGhlIGdlbmVyaWMgcGFydHMu
DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJhb3F1YW4gSGUgPGJoZUByZWRoYXQuY29tPg0KPiBD
YzogQnJpYW4gQ2FpbiA8YmNhaW5AcXVpY2luYy5jb20+DQo+IENjOiBsaW51eC1oZXhhZ29uQHZn
ZXIua2VybmVsLm9yZw0KPiAtLS0NCj4gICBhcmNoL2hleGFnb24vS2NvbmZpZyAgICAgICAgICB8
ICAxICsNCj4gICBhcmNoL2hleGFnb24vaW5jbHVkZS9hc20vaW8uaCB8ICA5ICsrKysrLS0NCj4g
ICBhcmNoL2hleGFnb24vbW0vaW9yZW1hcC5jICAgICB8IDQ0IC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tDQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDQ2
IGRlbGV0aW9ucygtKQ0KPiAgIGRlbGV0ZSBtb2RlIDEwMDY0NCBhcmNoL2hleGFnb24vbW0vaW9y
ZW1hcC5jDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9oZXhhZ29uL0tjb25maWcgYi9hcmNoL2hl
eGFnb24vS2NvbmZpZw0KPiBpbmRleCA1NGVhZGYyNjUxNzguLjE3YWZmZmRlMWE3ZiAxMDA2NDQN
Cj4gLS0tIGEvYXJjaC9oZXhhZ29uL0tjb25maWcNCj4gKysrIGIvYXJjaC9oZXhhZ29uL0tjb25m
aWcNCj4gQEAgLTI1LDYgKzI1LDcgQEAgY29uZmlnIEhFWEFHT04NCj4gICAJc2VsZWN0IE5FRURf
U0dfRE1BX0xFTkdUSA0KPiAgIAlzZWxlY3QgTk9fSU9QT1JUX01BUA0KPiAgIAlzZWxlY3QgR0VO
RVJJQ19JT01BUA0KPiArCXNlbGVjdCBHRU5FUklDX0lPUkVNQVANCj4gICAJc2VsZWN0IEdFTkVS
SUNfU01QX0lETEVfVEhSRUFEDQo+ICAgCXNlbGVjdCBTVEFDS1RSQUNFX1NVUFBPUlQNCj4gICAJ
c2VsZWN0IEdFTkVSSUNfQ0xPQ0tFVkVOVFNfQlJPQURDQVNUDQo+IGRpZmYgLS1naXQgYS9hcmNo
L2hleGFnb24vaW5jbHVkZS9hc20vaW8uaCBiL2FyY2gvaGV4YWdvbi9pbmNsdWRlL2FzbS9pby5o
DQo+IGluZGV4IGMzMzI0MTQyNWE1Yy4uZTJkMzA5MWVjOWQ2IDEwMDY0NA0KPiAtLS0gYS9hcmNo
L2hleGFnb24vaW5jbHVkZS9hc20vaW8uaA0KPiArKysgYi9hcmNoL2hleGFnb24vaW5jbHVkZS9h
c20vaW8uaA0KPiBAQCAtMTcwLDggKzE3MCwxMyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgd3JpdGVs
KHUzMiBkYXRhLCB2b2xhdGlsZSB2b2lkIF9faW9tZW0gKmFkZHIpDQo+ICAgI2RlZmluZSB3cml0
ZXdfcmVsYXhlZCBfX3Jhd193cml0ZXcNCj4gICAjZGVmaW5lIHdyaXRlbF9yZWxheGVkIF9fcmF3
X3dyaXRlbA0KPiAgIA0KPiAtdm9pZCBfX2lvbWVtICppb3JlbWFwKHVuc2lnbmVkIGxvbmcgcGh5
c19hZGRyLCB1bnNpZ25lZCBsb25nIHNpemUpOw0KPiAtI2RlZmluZSBpb3JlbWFwX3VjKFgsIFkp
IGlvcmVtYXAoKFgpLCAoWSkpDQo+ICsvKg0KPiArICogSS9PIG1lbW9yeSBtYXBwaW5nIGZ1bmN0
aW9ucy4NCj4gKyAqLw0KPiArI2RlZmluZSBfUEFHRV9JT1JFTUFQIChfUEFHRV9QUkVTRU5UIHwg
X1BBR0VfUkVBRCB8IF9QQUdFX1dSSVRFIHwgXA0KPiArCQkgICAgICAgKF9fSEVYQUdPTl9DX0RF
ViA8PCA2KSkNCj4gKw0KPiArI2RlZmluZSBpb3JlbWFwX3VjKGFkZHIsIHNpemUpIGlvcmVtYXAo
KGFkZHIpLCAoc2l6ZSkpDQo+ICAgDQo+ICAgDQo+ICAgI2RlZmluZSBfX3Jhd193cml0ZWwgd3Jp
dGVsDQo+IGRpZmYgLS1naXQgYS9hcmNoL2hleGFnb24vbW0vaW9yZW1hcC5jIGIvYXJjaC9oZXhh
Z29uL21tL2lvcmVtYXAuYw0KPiBkZWxldGVkIGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMjU1
YzViMWVlMWE3Li4wMDAwMDAwMDAwMDANCj4gLS0tIGEvYXJjaC9oZXhhZ29uL21tL2lvcmVtYXAu
Yw0KPiArKysgL2Rldi9udWxsDQo+IEBAIC0xLDQ0ICswLDAgQEANCj4gLS8vIFNQRFgtTGljZW5z
ZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkNCj4gLS8qDQo+IC0gKiBJL08gcmVtYXAgZnVuY3Rp
b25zIGZvciBIZXhhZ29uDQo+IC0gKg0KPiAtICogQ29weXJpZ2h0IChjKSAyMDEwLTIwMTEsIFRo
ZSBMaW51eCBGb3VuZGF0aW9uLiBBbGwgcmlnaHRzIHJlc2VydmVkLg0KPiAtICovDQo+IC0NCj4g
LSNpbmNsdWRlIDxsaW51eC9pby5oPg0KPiAtI2luY2x1ZGUgPGxpbnV4L3ZtYWxsb2MuaD4NCj4g
LSNpbmNsdWRlIDxsaW51eC9tbS5oPg0KPiAtDQo+IC12b2lkIF9faW9tZW0gKmlvcmVtYXAodW5z
aWduZWQgbG9uZyBwaHlzX2FkZHIsIHVuc2lnbmVkIGxvbmcgc2l6ZSkNCj4gLXsNCj4gLQl1bnNp
Z25lZCBsb25nIGxhc3RfYWRkciwgYWRkcjsNCj4gLQl1bnNpZ25lZCBsb25nIG9mZnNldCA9IHBo
eXNfYWRkciAmIH5QQUdFX01BU0s7DQo+IC0Jc3RydWN0IHZtX3N0cnVjdCAqYXJlYTsNCj4gLQ0K
PiAtCXBncHJvdF90IHByb3QgPSBfX3BncHJvdChfUEFHRV9QUkVTRU5UfF9QQUdFX1JFQUR8X1BB
R0VfV1JJVEUNCj4gLQkJCQkJfChfX0hFWEFHT05fQ19ERVYgPDwgNikpOw0KPiAtDQo+IC0JbGFz
dF9hZGRyID0gcGh5c19hZGRyICsgc2l6ZSAtIDE7DQo+IC0NCj4gLQkvKiAgV3JhcHBpbmcgbm90
IGFsbG93ZWQgICovDQo+IC0JaWYgKCFzaXplIHx8IChsYXN0X2FkZHIgPCBwaHlzX2FkZHIpKQ0K
PiAtCQlyZXR1cm4gTlVMTDsNCj4gLQ0KPiAtCS8qICBSb3VuZHMgdXAgdG8gbmV4dCBwYWdlIHNp
emUsIGluY2x1ZGluZyB3aG9sZS1wYWdlIG9mZnNldCAqLw0KPiAtCXNpemUgPSBQQUdFX0FMSUdO
KG9mZnNldCArIHNpemUpOw0KPiAtDQo+IC0JYXJlYSA9IGdldF92bV9hcmVhKHNpemUsIFZNX0lP
UkVNQVApOw0KPiAtCWFkZHIgPSAodW5zaWduZWQgbG9uZylhcmVhLT5hZGRyOw0KPiAtDQo+IC0J
aWYgKGlvcmVtYXBfcGFnZV9yYW5nZShhZGRyLCBhZGRyK3NpemUsIHBoeXNfYWRkciwgcHJvdCkp
IHsNCj4gLQkJdnVubWFwKCh2b2lkICopYWRkcik7DQo+IC0JCXJldHVybiBOVUxMOw0KPiAtCX0N
Cj4gLQ0KPiAtCXJldHVybiAodm9pZCBfX2lvbWVtICopIChvZmZzZXQgKyBhZGRyKTsNCj4gLX0N
Cj4gLQ0KPiAtdm9pZCBpb3VubWFwKGNvbnN0IHZvbGF0aWxlIHZvaWQgX19pb21lbSAqYWRkcikN
Cj4gLXsNCj4gLQl2dW5tYXAoKHZvaWQgKikgKCh1bnNpZ25lZCBsb25nKSBhZGRyICYgUEFHRV9N
QVNLKSk7DQo+IC19
