Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E6C5306BE
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 01:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbiEVXxj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 19:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbiEVXxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 19:53:38 -0400
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2050.outbound.protection.outlook.com [40.107.113.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B13233883
        for <linux-kernel@vger.kernel.org>; Sun, 22 May 2022 16:53:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U03PAL0Ha2fcIvPuFhWpv2CLNeso+rl5kYDrWZyWpaNZs+pCaRnD8EHrBxcEtQoGtOqRsyWXafWxcI0SslfzS5cMDeGHftCqZBA6Ba0Jx67MYh3yX24r4NdK1Zh6A6giuhI6OKmcP5vNayl7VyTpfmqGOIqr5/9h3a1YcToAvpnKNpyAmfBSJp+J3VpG2cNtqaATC7nADsuYIkhP6BEFW1jKESYhgFy8JMKv8Y/HDfQjXat67ZZOxCtMP46P1uK02Davv6ZIIaDKCP4kn26aRWWvEpg2Z94VA+g4pNIzX4t5gydkOR1+Y9WacW/Q/IaY2vDxQABYaBWEWkWydpmkHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IMtNz/yGRi/G37Wa8SXjnpH6iJZfDcWRtQfTzfY9A+Y=;
 b=ge98w6BW/L/I6yUPrhL7yrCqUCgd9L7sKqxwiqVbm166qB8pDTkmVWmx2NpJli6O+eOHrWzgwlwRdSWYhEeNeqU04ZFaWypFtkZQlAmrJ18k0aOaSevOQmWvg5yZDT9tnOWRU1CrCjMnhVeOqb494odqlLHONXTVG3Nb2GTal9ajisPavpQ+MCby7TiUv8SAoqKt0ur+n7326FLuLQX73DEEuZNijbxU+ne9lzGfAKKx9oSGD9nQffZDkJbKbHufs1yyNIHUF7YFZBlOMERTMJ7vz2vK3QkC3UW8Us5ghaXsSiEpVFnRqcPhRpZO9fKiFma0oxMWf5vNzQvdbbHXpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nec.com; dmarc=pass action=none header.from=nec.com; dkim=pass
 header.d=nec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nec.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IMtNz/yGRi/G37Wa8SXjnpH6iJZfDcWRtQfTzfY9A+Y=;
 b=BInvvtp3ROCv75VKSFHpT8CLuLYKgWt53PtsNH8K4whrHacNnj+dwfIcF1jAqAS1pq1JiuoxfuAU3Nv090LWy0om7bhOQo+LKS4MtwKrSCzefwjd+7gyJi1CDcrqiCEisbSlvzNuQak7WapCBoCwNMX25E/18Q7MSLhCJwPl7wQ=
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com (2603:1096:400:13c::10)
 by OSAPR01MB3731.jpnprd01.prod.outlook.com (2603:1096:604:5b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.14; Sun, 22 May
 2022 23:53:27 +0000
Received: from TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::246b:9355:73ad:b995]) by TYWPR01MB8591.jpnprd01.prod.outlook.com
 ([fe80::246b:9355:73ad:b995%2]) with mapi id 15.20.5273.022; Sun, 22 May 2022
 23:53:27 +0000
From:   =?utf-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPo+OAgOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "hughd@google.com" <hughd@google.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "neilb@suse.de" <neilb@suse.de>,
        "apopple@nvidia.com" <apopple@nvidia.com>,
        "david@redhat.com" <david@redhat.com>,
        "surenb@google.com" <surenb@google.com>,
        "peterx@redhat.com" <peterx@redhat.com>,
        "rcampbell@nvidia.com" <rcampbell@nvidia.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 4/5] mm/shmem: fix infinite loop when swap in shmem
 error at swapoff time
Thread-Topic: [PATCH v4 4/5] mm/shmem: fix infinite loop when swap in shmem
 error at swapoff time
Thread-Index: AQHYa38Hnv+yD7ocokSyVBX8dxzd660nUFeAgAAc1YCABCoXAA==
Date:   Sun, 22 May 2022 23:53:27 +0000
Message-ID: <20220522235326.GA713751@hori.linux.bs1.fc.nec.co.jp>
References: <20220519125030.21486-1-linmiaohe@huawei.com>
 <20220519125030.21486-5-linmiaohe@huawei.com>
 <20220520063433.GA584983@hori.linux.bs1.fc.nec.co.jp>
 <970aee34-c377-2b8c-c6bb-45e2a96e84b9@huawei.com>
In-Reply-To: <970aee34-c377-2b8c-c6bb-45e2a96e84b9@huawei.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nec.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b50978f8-189a-4c90-0173-08da3c4e4424
x-ms-traffictypediagnostic: OSAPR01MB3731:EE_
x-microsoft-antispam-prvs: <OSAPR01MB3731D2EB3D24B167F9F64E51E7D59@OSAPR01MB3731.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t4X/kelpHxKUvnB35U4ourY8yP8/IkOEKrHU3EziBop0hyi88XhEK/RlkOnZ5isZr96kjDjM1yEVErmMe2dfZvIIY9Jell4qSfF47dGUNVN+IOqcKU8x4MmY5qx3fav431e1/yisfGnPCvEbGAUMR5HwsqdaykplMHdmwWfmr5esL7+5OjA9dR3nw4sIit4HbP0ntLcadOu/EECtKyulzHkfAoFmyqj8p4+Lu8SPY3MYqlwBENIZFX0swjIvtER9E0lsXRnlumj/MeEfm2juXHTHUky/Ud3rVJ6qrbfIwqu0xwfbWde6hwMfmMbzozZJ6CekhOAsjmF293yeSjJsC5VVb/62MuscLCHn1gJ5Gb3KD12lmM2oipnUuZ9LfCDFY1RQ4Of5Le3o72jYyMqEOtOKeDvQ8AXuyeGUFHVeBwb9mK1FL7oXpBdkv664xyZxh9BNaRKBNahHC3k7XPlr2++NQpKh6ILLYprdNEWRsSPjhiYXH3L0459RMWd4HAoYZ1Y94U0q2bYmUjiSdqOAI8txwBuIPsycswoj90XEuzlGwj5Pa+wTQGRO3k58zuRjMZyPmRg/yr50RzZ5l7WteS3At5Zv55jWYcn3hQIZ9uWH62vGFUpsExiqW6Auoo/tr5BXTz7KyoN7tt16oHBhDdoj8lHlH1PJUagjYuSYouJXD8oMfZIpZqcHftGtBhtZSE+mM2jp67CN+yZYpVmhdw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWPR01MB8591.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(66556008)(66446008)(64756008)(66476007)(86362001)(7416002)(76116006)(8936002)(8676002)(2906002)(66946007)(82960400001)(122000001)(38070700005)(38100700002)(5660300002)(6512007)(54906003)(6916009)(6506007)(1076003)(6486002)(53546011)(55236004)(71200400001)(316002)(508600001)(83380400001)(26005)(9686003)(186003)(85182001)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXVVTkVRcHdLQm54QXQ4TW0zT2J5c2RMSmE4ZTNRbnhxVUVhV1RIdmQ3VGhm?=
 =?utf-8?B?eGNPcm1CT0xXUW5uQXVxWVArYXdQdTVCeUJjbDlpaisxNkZwbVVsbWVOWmt0?=
 =?utf-8?B?STBEbHVSdjcvL2ZQeXd2VHBuOWRYdUFPWWlNZ3BFMTY2d2lmeUo0UXFhWkxN?=
 =?utf-8?B?U1pFRGpXalFyOHJ2L1ZBSnBDMFFvcmFWekVvRzF2SjlENEJrWE4xQ3BqbWxh?=
 =?utf-8?B?WmJhNWpYdjBoUEVUaXNZYjBzVlIxNEZCMkk5dVd2SGU4YUh5Q1pqSTlaODJD?=
 =?utf-8?B?Z2RqbENtYmFvV3R4T29ib0QxWEh5Z2I2QktKNFZvR3FWL1lBU0xnR293YzZN?=
 =?utf-8?B?d054K2FabGYranJHWHk4YWR3TU14eDRpV2UzWHhCMTR4WHZXeS9Tai9meFVu?=
 =?utf-8?B?L3czQ21ESGFrdFA5aWU0NFhLTmtMQXd2QnNwM1hFaEFMYTVOWE5DeFkxZzgx?=
 =?utf-8?B?bDBMUTlOYWhiL0hKdEplOTloTVdIdWdwS1hIZ1ErNzgrY081TTBSSm1ORlM1?=
 =?utf-8?B?b1RvN2JxWDRVODEwQ3d6UGhSeGgweEIwdnc0UVdZZnVwQzlzMy9EZlBZOUVL?=
 =?utf-8?B?NjhVMVgrZjJid0cydGFaRm9iOWs3RGFHeURPYUU5dG0rYytUOWVKZjV2WVZJ?=
 =?utf-8?B?Sjg1bGtXMlY1UWdTdWpDUWFsQ08wc25nTFVFOXRNSVc2dTRjakhZVCt3WFdK?=
 =?utf-8?B?dDhOL2pXR0xaMlMvUm5sRjZYK2Y3TFU5T1JvS01rbFdmZnpaNlkrU001SXk2?=
 =?utf-8?B?aVA5TzBLdGFrUjErWWt6YVlpMS8yMkorTFQxL3cyZXNGbXd3RW0xVjc3d2Vo?=
 =?utf-8?B?TjROd3VLSWlWOC93UWwzNzcyOHRPUHdTMGh5aFk4ZDRKTW9TNmQyVFkvTDBQ?=
 =?utf-8?B?K2c3cGZWQ3E0Wnk0ZE8rUjlhRmpiVUNqdW9aSmg4S3hCNjBUaW9xcXFBVUwz?=
 =?utf-8?B?U3J2QXNVVFErU25hZG9KVFZ1bEE5TW55RkgwaWFNTGk2cWFaQ0lwOWNsUHls?=
 =?utf-8?B?NkxoV0xPZERtTit2TU13WjZEOUlKcmY2N1VUNUFYcnJLRGRxaXZ2Vmk2NGZB?=
 =?utf-8?B?VWVkZGt4WXladDFndHE2SnZiQ052L0RNbzRva2hzdUZRREFiVjMrTmZieG0w?=
 =?utf-8?B?Ync1Y2oyVHF1RjVscjRicDFaUFNQUzFtUStCQ3F2OUUyVFlaY001Skl6YnNw?=
 =?utf-8?B?TFBlRWs2bHBmTGMxNE5uZnJQZFdmQnBVV3BFYUJKWmlsTmlBTC9RNyt1RTRq?=
 =?utf-8?B?bHdDTmp2eVlZc2ZtL2l1ZnVxaXlwdUpXeWhmQVd2dVhxaEcrdkFhNks4N3R3?=
 =?utf-8?B?Tkx4czRzdjZ1Y1pSckFkTkxpd3ZZRTBtMXNiZ09nNkUvTkVKRFkra0FVamJB?=
 =?utf-8?B?bEhiWTZTQWJ5ZUFSSk82b08vaFdSaHZUWkdNazFjZEVsQjFDckZ4NEJpUHIv?=
 =?utf-8?B?azI0T3o2WjJOQTJKbkJTck1ENHc1c0ZBQkF4emhKS2hDM29pOTg5SlBPOUh4?=
 =?utf-8?B?Uk9keThuUUt1RndoSENhTjA2ZDZzUTRuMm80SmN3RXNhUkEyc0ViWFFkVS9l?=
 =?utf-8?B?S0VLY251Mzl0R0NlbmszTlN1blMwU2g2ZFpIT3NGcnNiVjlzVHY4bkJvMEF5?=
 =?utf-8?B?UlZwR0syc0V1ckhlS0ttRnVJVjAyayt0UWYxdmRDenNZdGRNbVpvQ2NOclYy?=
 =?utf-8?B?cWcxS2hiWFdHM0FLRTViaUpXNk1iSWh6UVNxcGFqd2ZBQksvNHVmQ1NlZlFu?=
 =?utf-8?B?b0ZzcEdDTlp1K1NLdTlqREJ6d3FnWkFJOXppSDlLRjRoU0cwK0lORWFVcGtx?=
 =?utf-8?B?VFRDb2twVHZIUGFneGNCTndGdmsyRXRqTHR2K01ZYlZrbWROb1hXWXB0SFov?=
 =?utf-8?B?Q1dxUFhpY3Q4cTd5WVN2WnhKbCsvemdUc0I5S01yZmx6MUwyWHg3eU8xSTdS?=
 =?utf-8?B?amdBaXNCODlGU2d5SU1hVHBXaE5jb3diMitNWFNWdEVrMGpYUVFxY0ducWo1?=
 =?utf-8?B?b0kyTzdtVVp5NGdrekVQN2FwMU1FMExLZWUrci9YM0lsUDR1bDBiRkVDR1hv?=
 =?utf-8?B?dlh6b2d5UTNRVFZTNVZ3ZTlYQnJiQy9KNVlNZ2JYaVl1RU9UYWRPOXlTSzBJ?=
 =?utf-8?B?OEJpbHQyOWhod0RqQ3p4OE1zOUo5d1VRbHp0N1Z4aHZjaEFYeUxUeXhxVjlu?=
 =?utf-8?B?cUtxRzJZbnZTaC9Qa3hsY1lUbVBEdFUwcktkV25iRVlwVkJkVDBEMG9XN09F?=
 =?utf-8?B?YjZZOUVxeWRIeml5VVliL1VzZWlheUhQRWFYUGFVOXpucExlcEhzZERHVnpY?=
 =?utf-8?B?b1JodGluaU1qMVVvQlBHQnlKRkY4L0l5aGZTdkZUeWk5YS9sV3JxLzcvQk9i?=
 =?utf-8?Q?IOZm2YYqka57oc/8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <29F16CFAF9968544B132ECF7469CACB3@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nec.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWPR01MB8591.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b50978f8-189a-4c90-0173-08da3c4e4424
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2022 23:53:27.4360
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e67df547-9d0d-4f4d-9161-51c6ed1f7d11
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0nLmhnzm5HlVWV78otPVbFvp/QxpIXnMlgpovm+EgzDZ0EahfxGLY7xRZgNeIefpLN6gr2q4KAxxBVG8j3gNIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3731
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCBNYXkgMjAsIDIwMjIgYXQgMDQ6MTc6NDVQTSArMDgwMCwgTWlhb2hlIExpbiB3cm90
ZToNCj4gT24gMjAyMi81LzIwIDE0OjM0LCBIT1JJR1VDSEkgTkFPWUEo5aCA5Y+jIOebtOS5nykg
d3JvdGU6DQo+ID4gT24gVGh1LCBNYXkgMTksIDIwMjIgYXQgMDg6NTA6MjlQTSArMDgwMCwgTWlh
b2hlIExpbiB3cm90ZToNCj4gPj4gV2hlbiBzd2FwIGluIHNobWVtIGVycm9yIGF0IHN3YXBvZmYg
dGltZSwgdGhlcmUgd291bGQgYmUgYSBpbmZpbml0ZSBsb29wDQo+ID4+IGluIHRoZSB3aGlsZSBs
b29wIGluIHNobWVtX3VudXNlX2lub2RlKCkuIEl0J3MgYmVjYXVzZSBzd2FwaW4gZXJyb3IgaXMN
Cj4gPj4gZGVsaWJlcmF0ZWx5IGlnbm9yZWQgbm93IGFuZCB0aHVzIGluZm8tPnN3YXBwZWQgd2ls
bCBuZXZlciByZWFjaCAwLiBTbw0KPiA+PiB3ZSBjYW4ndCBlc2NhcGUgdGhlIGxvb3AgaW4gc2ht
ZW1fdW51c2UoKS4NCj4gPj4NCj4gPj4gSW4gb3JkZXIgdG8gZml4IHRoZSBpc3N1ZSwgc3dhcGlu
X2Vycm9yIGVudHJ5IGlzIHN0b3JlZCBpbiB0aGUgbWFwcGluZw0KPiA+PiB3aGVuIHN3YXBpbiBl
cnJvciBvY2N1cnMuIFNvIHRoZSBzd2FwY2FjaGUgcGFnZSBjYW4gYmUgZnJlZWQgYW5kIHRoZQ0K
PiA+PiB1c2VyIHdvbid0IGVuZCB1cCB3aXRoIGEgcGVybWFuZW50bHkgbW91bnRlZCBzd2FwIGJl
Y2F1c2UgYSBzZWN0b3IgaXMNCj4gPj4gYmFkLiBJZiB0aGUgcGFnZSBpcyBhY2Nlc3NlZCBsYXRl
ciwgdGhlIHVzZXIgcHJvY2VzcyB3aWxsIGJlIGtpbGxlZA0KPiA+PiBzbyB0aGF0IGNvcnJ1cHRl
ZCBkYXRhIGlzIG5ldmVyIGNvbnN1bWVkLiBPbiB0aGUgb3RoZXIgaGFuZCwgaWYgdGhlDQo+ID4+
IHBhZ2UgaXMgbmV2ZXIgYWNjZXNzZWQsIHRoZSB1c2VyIHdvbid0IGV2ZW4gbm90aWNlIGl0Lg0K
PiA+Pg0KPiA+PiBSZXBvcnRlZC1ieTogTmFveWEgSG9yaWd1Y2hpIDxuYW95YS5ob3JpZ3VjaGlA
bmVjLmNvbT4NCj4gPj4gU2lnbmVkLW9mZi1ieTogTWlhb2hlIExpbiA8bGlubWlhb2hlQGh1YXdl
aS5jb20+DQo+ID4gDQo+ID4gSGkgTWlhb2hlLA0KPiA+IA0KPiA+IFRoYW5rIHlvdSBmb3IgdGhl
IHVwZGF0ZS4gIEkgbWlnaHQgbWlzcyBzb21ldGhpbmcsIGJ1dCBJIHN0aWxsIHNlZSB0aGUgc2Ft
ZQ0KPiA+IHByb2JsZW0gKEkgY2hlY2tlZCBpdCBvbiBtbS1ldmVyeXRoaW5nLTIwMjItMDUtMTkt
MDAtMDMgKyB0aGlzIHBhdGNoc2V0KS4NCj4gDQo+IEkgd2FzIHRlc3RpbmcgdGhpcyBwYXRjaCBv
biBteSA1LjEwIGtlcm5lbC4gSSByZXByb2R1Y2VkIHRoZSBwcm9ibGVtIGluIG15IGVudiBhbmQN
Cj4gZml4ZWQgaXQuIEl0IHNlZW1zIHRoZXJlIG1pZ2h0IGJlIHNvbWUgY3JpdGljYWwgZGlmZmVy
ZW5jZSB0aG91Z2ggSSBjaGVja2VkIHRoYXQgYnkNCj4gcmV2aWV3aW5nIHRoZSBjb2RlLi4uIFNv
cnJ5LiA6KA0KPiANCj4gPiANCj4gPiBUaGlzIHBhdGNoIGhhcyB0aGUgZWZmZWN0IHRvIGNoYW5n
ZSB0aGUgcmV0dXJuIHZhbHVlIG9mIHNobWVtX3N3YXBpbl9mb2xpbygpLA0KPiA+IC1FSU8gKHdp
dGhvdXQgdGhpcyBwYXRjaCkgdG8gLUVFWElTVCAod2l0aCB0aGlzIHBhdGNoKS4NCj4gDQo+IElu
IGZhY3QsIEkgZGlkbid0IGNoYW5nZSB0aGUgcmV0dXJuIHZhbHVlIGZyb20gLUVJTyB0byAtRUVY
SVNUOg0KPiANCj4gQEAgLTE3NjIsNiArMTc5OSw4IEBAIHN0YXRpYyBpbnQgc2htZW1fc3dhcGlu
X2ZvbGlvKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHBnb2ZmX3QgaW5kZXgsDQo+ICBmYWlsZWQ6DQo+
ICAJaWYgKCFzaG1lbV9jb25maXJtX3N3YXAobWFwcGluZywgaW5kZXgsIHN3YXApKQ0KPiAgCQll
cnJvciA9IC1FRVhJU1Q7DQo+ICsJaWYgKGVycm9yID09IC1FSU8pDQo+ICsJCXNobWVtX3NldF9m
b2xpb19zd2FwaW5fZXJyb3IoaW5vZGUsIGluZGV4LCBmb2xpbywgc3dhcCkNCj4gDQo+ID4gQnV0
IHNobWVtX3VudXNlX3N3YXBfZW50cmllcygpIGNoZWNrcyBuZWl0aGVyLCBzbyBubyBjaGFuZ2Ug
ZnJvbSBjYWxsZXIncyB2aWV3IHBvaW50Lg0KPiA+IE1heWJlIGJyZWFraW5nIGluIGVycm9ycyAo
cmF0aGVyIHRoYW4gRU5PTUVNKSBpbiBmb3IgbG9vcCBpbiBzaG1lbV91bnVzZV9zd2FwX2VudHJp
ZXMoKQ0KPiA+IHNvbHZlcyB0aGUgaXNzdWU/ICBJIGJyaWVmbHkgY2hlY2tlZCB3aXRoIHRoZSBi
ZWxvdyBjaGFuZ2UsIHRoZW4gc3dhcG9mZiBjYW4gcmV0dXJuDQo+ID4gd2l0aCBmYWlsdXJlLg0K
PiA+IA0KPiA+IEBAIC0xMjIyLDcgKzEyMjIsNyBAQCBzdGF0aWMgaW50IHNobWVtX3VudXNlX3N3
YXBfZW50cmllcyhzdHJ1Y3QgaW5vZGUgKmlub2RlLA0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgIGZvbGlvX3B1dChmb2xpbyk7DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0Kys7
DQo+ID4gICAgICAgICAgICAgICAgIH0NCj4gPiAtICAgICAgICAgICAgICAgaWYgKGVycm9yID09
IC1FTk9NRU0pDQo+ID4gKyAgICAgICAgICAgICAgIGlmIChlcnJvciA8IDApDQo+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgYnJlYWs7DQo+ID4gICAgICAgICAgICAgICAgIGVycm9yID0gMDsN
Cj4gPiAgICAgICAgIH0NCj4gDQo+IFllcywgdGhpcyBpcyB0aGUgc2ltcGxlc3QgYW5kIHN0cmFp
Z2h0Zm9yd2FyZCB3YXkgdG8gZml4IHRoZSBpc3N1ZS4gQnV0IGl0IGhhcyB0aGUgc2lkZSBlZmZl
Y3QNCj4gdGhhdCB1c2VyIHdpbGwgZW5kIHVwIHdpdGggYSBwZXJtYW5lbnRseSBtb3VudGVkIHN3
YXAganVzdCBiZWNhdXNlIGEgc2VjdG9yIGlzIGJhZC4gVGhhdCBtaWdodA0KPiBiZSBzb21ld2hh
dCB1bmFjY2VwdGFibGU/DQoNCkFoLCB5b3UncmUgcmlnaHQsIHN3YXBvZmYgc2hvdWxkIHJldHVy
biB3aXRoIHN1Y2Nlc3MgaW5zdGVhZCBvZiB3aXRoDQpmYWlsdXJlLiAgSSB0cmllZCB0aGUgZml4
IGluIHlvdXIgYW5vdGhlciBlbWFpbCwgYW5kIHRoYXQgbWFrZXMgc3dhcG9mZg0KcmV0dXJuIHdp
dGggc3VjY2Vzcywgc28geW91ciBmaXggbG9va3MgYmV0dGVyIHRoYW4gbWluZS4NCg0KVGhhbmtz
LA0KTmFveWEgSG9yaWd1Y2hp
