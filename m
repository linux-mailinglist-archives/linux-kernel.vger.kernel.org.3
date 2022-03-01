Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038EC4C921B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 18:43:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235522AbiCARof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 12:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiCARod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 12:44:33 -0500
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90049.outbound.protection.outlook.com [40.107.9.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E2C5F8EE;
        Tue,  1 Mar 2022 09:43:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfMPZbQF4cJbH5KhM/eGKiM/rWTx8BQ/8sdELM/wQDTVfqUCy/PARQi9ki2CZMpzs8HOz9fUZs7WsDqL0Hp7jC82DQvTp940mgR7nuq72x4dyc7BhoxHSIXPsd774SUAHZEAPzYui2Ce8iL2QkY4nbSKVz1d03hgiPynn0QpaqIuTg+xeF/AzzikJBG0G70775/JLaq/PAxm1XezqGGqKFIydgLJpc2V5DOhQmTGRVbhyb/uhApa2aLNh0BkOtfWhZ/LJywIZZXq7QXKO+Bm4Gt4XDjR6ALRt2Y/N+DIRV38QN6WQVwGQEhAqVfam8EVVKfQGdSb+dDtURZQnZQaSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBQuK1z3oHVOBdBKkDu+0pni44T5ie0X66k/eF/H2T4=;
 b=mvgug9yf+RYTmNNWyYbEhjKM7h4hOiic5Cd0WpcGmJ+nhcM6FT3qVska1FYGg5WgL/Pbkkr1P/h+GNvC/bcMUJn/RAUuTXgCZcKK7IoST6pOpl9czWGr2bLPYproTMVA/Cy/IZ6j4WoPG4oIu7Pc6ejwJ8BHkPD4bWqUKsk27pfdZpju6lij5qb3a3OBch36IH+pNrxDleKcwVShNHa6j8o99uA06GhKNExF0CNGwZ7KSUOH975SvsIh/g7Boa2UqfId/bAV5oGYw2yieellhs4TSXTL316wlcfdqfAcWOKMeFaTakJUgG9/ENovNOWqrdL15GIJspatNXjpj2AINQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAYP264MB4253.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:11b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Tue, 1 Mar
 2022 17:43:44 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::cd2f:d05d:9aa3:400d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::cd2f:d05d:9aa3:400d%4]) with mapi id 15.20.5038.014; Tue, 1 Mar 2022
 17:43:44 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Lucas De Marchi <lucas.demarchi@intel.com>,
        Luis Chamberlain <mcgrof@kernel.org>
CC:     Lucas De Marchi <lucas.de.marchi@gmail.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "cl@linux.com" <cl@linux.com>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        Aaron Tomlin <atomlin@redhat.com>
Subject: Re: [PATCH v9 00/14] module: core code clean up
Thread-Topic: [PATCH v9 00/14] module: core code clean up
Thread-Index: AQHYLPz9dCjYVwicx0iy9EhVniO5RaypqrEAgAB7rYCAAIragIAAFNOAgAAHxIA=
Date:   Tue, 1 Mar 2022 17:43:44 +0000
Message-ID: <20fddc03-4e31-d77a-024b-103d3c166d0f@csgroup.eu>
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <Yh1nGtM7MCMOI++l@bombadil.infradead.org>
 <2e2860d7-23e8-63f3-f7d3-bce0aa57a3d0@csgroup.eu>
 <Yh5DU6n7oCRTfbtG@bombadil.infradead.org>
 <20220301171555.tzrqrmhtv2tkxtaj@ldmartin-desk2>
In-Reply-To: <20220301171555.tzrqrmhtv2tkxtaj@ldmartin-desk2>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 69c983cc-4aa6-4fea-3124-08d9fbab0868
x-ms-traffictypediagnostic: PAYP264MB4253:EE_
x-microsoft-antispam-prvs: <PAYP264MB4253AEC266971AD10CFD75D9ED029@PAYP264MB4253.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TVFLOyuHvBYdF9lqEgVLAYORTCHYxO4AuOLdJ6a/RknjjYQGRl4P8V91SMFBAzSHMFSHYMoAiNefKhRuGrur7jSJcoFm8h7R3K7DF75643Zu85LTs/cvAJjaDQ0276+Tcf7RgaRKY10q0dRieLre90Pkm4Hf+sRUDXBE1CcmDiS3VXs+u0r/AVXpVjiXWPenvCmttpsXDAoPa6jkLVUG4waBdl5Y2plGH374cDoGhTy8UHG0BqaPqE6kUEj9JNgdg40KMSXdcNeKCo7NwDAFBTe1U0Mt1hyjUUeg6KLNvtxgn2HVnud9D7ukqlGUYNiqoNObFc02NUfu8uBQQg2TRGVa+fupvDRoRho4ZwsvV/Kq4BVpc0OZ3fX9rUM8DiKjnbpc2sql/tf+M58cgpiODAUOTcY8dZOTpCPzw45JLc3JNLKFjeY2iWTYXzD8W8Ji4ni6ntc1XxFHQgUmbOyNEdDDi68kdWtsc8uhgijXG4U8IBSFAoUmRFah50b8ckOPbFtZ8Ax8cjcjbnQBtgMN1Tm7p1SZtt/dlkj4uCUfednyHIa4RfxB1jTtW9GYXwba2ezi0QysJkjKSn8jRo1reyq5Vdz2rzpmXcerYVOKiaganebZi0k41QzQUsPESsjUeihXLqrupNZOhCkFNoDJH2mnM8KV2OgF7+v2U74cHE9l5nA7tfncqYcZveGRJOkid9avsbvJD2HvzMXNpbw6OnsyUrTumEV+L/+ajMK4LcmHWFaOpOtL5uqO0dnPVz9mHGlzQt/VZjNvUikyKQIw6RnwG8VDv1oTnVqivzAo9FeV/JjgWu4pz3R6MxhSN0eXimxLvBLavHeoIGvK7YyTfpnPQV+ba+Q51d+Tp18xVvQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(966005)(6486002)(508600001)(38070700005)(2906002)(31696002)(5660300002)(122000001)(7416002)(38100700002)(76116006)(186003)(66946007)(44832011)(66446008)(64756008)(66476007)(66556008)(4326008)(8676002)(91956017)(36756003)(26005)(31686004)(316002)(54906003)(6512007)(71200400001)(110136005)(6506007)(2616005)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QUJWOW51S0wxR1ZJV2orM2hHd2ZvcmlvQ1F5akk5TjJsUTB0OVhuR0c2TEJ2?=
 =?utf-8?B?T1ZSSGpOV09CUCs2ZHFBWHMvMDExNEowZThvS3JrMHFxaWtQZzFiMVB1UGFQ?=
 =?utf-8?B?MCtrS3cveWNSL0l2OS9DRktHU0hRTkVJclRjaXlMMExqYUk2NVp5ZFBzUUxt?=
 =?utf-8?B?Y2QxclJXaEhEQ05aQTUxaGxLWGhqT21TRzdYSTUvbUlUQ3FKSy9aM3lyaWdG?=
 =?utf-8?B?QXlMQVhrOCt0eFA2VFdlZTQzdnkxRDlsR2hLMXZMSG9WWWwrRTF5VmxNYVpt?=
 =?utf-8?B?VzNxOWhXYjh4SWNQYjhnSnJTVjZGYi9VTWdtMlZTVTlyYktTL2NrbUF0TXdK?=
 =?utf-8?B?b2JtMTdaTkI3cmhjMFJoeEdRWmVWN2RzS3lyMGdYM3JRdEFvd0E3R2QrZlpI?=
 =?utf-8?B?NGh0VGxLSndKM0dPZmlLdElXRzF2UDBENnJqSnhYWW8zQkZmNXNhNjZmekNp?=
 =?utf-8?B?SGg1MFFKdTNtc215dll2NHN3aURhTFNjRTVWem84Q0VLM3NrMHRnNlZvRUhO?=
 =?utf-8?B?WW5vaVJqWUxGejBYQmdqUnc0YXd1S29mbFlaeCs5K3E4elpwaFpoVWQxWFBu?=
 =?utf-8?B?L3ZvbEpCaG1wSEUwZWpqRVN1elFTRWR2WVJ2RnozRVhBTDdIMTl2bnFTRnFm?=
 =?utf-8?B?V2hsM1hPNndRaTlkMFBzWUhLTTcwZXEyZnY3cVpwckhiU0hObzNwQTMvU3hu?=
 =?utf-8?B?bzNHVnVIVXBGa1JCQXg5UkJ0c3NGaktrVFJwblBxSlBoSXV5TG00SVFnbjNh?=
 =?utf-8?B?ckxrcjNXZXI3VVFSNGFuc082UUh3OE1BWm8xVXNIME5qc0tzRE5YV2tTN2dn?=
 =?utf-8?B?azZQNWQ4V00wUmFKTHU2OEJvU2hjV2g1Mjh5a1VtNlZOS3N6elJpVkVmd0d2?=
 =?utf-8?B?dGpkbnU4NTFMbnZ1dnRGN09Bb3MyOG9oRi9mVDNqMmcxUXdud2ZIR2tJK2xK?=
 =?utf-8?B?dWVKcDRwdUxYZ05uVExnanFQMUxuczF4VDRqWVJTQTJFMVg0N0d5LzVqM09n?=
 =?utf-8?B?ZmYrRCswV2psQnNiODdTQnBhaXZienJzTERqRUZpVWtuVERpUTFLQ0NqNjZo?=
 =?utf-8?B?aFdsYlNwMG9IUG96R1Fwd0psdlIyOEU5bjBEVnVVblpudGwyd0FCd2ZwSndl?=
 =?utf-8?B?bFJiVkZ1QXNSdHkyZmtKVUsvUERmNUUwakVsdDcwaWwwK3NNWUFWdEhZbHFi?=
 =?utf-8?B?ZVBYb29qeVkvNXFxTlE3Z0wxbkxNQ0xzWGJUREg3V0puZlgrNDMwL1lBS3BO?=
 =?utf-8?B?K0xBREVCeHJONitaZVVIaEl2WjVNNlNRUzBVc2w1S3RLc284UmRIMXE0SC95?=
 =?utf-8?B?Z1V3TzJBV1gvT3ZUVDBXNWVUbzdyRDVWNzVGdnNPL3h0anY2OEE3ckJFRkxP?=
 =?utf-8?B?bjlaeWdORDdzcjBhYTREYkxVVm85NEFHQlNOTllWcU55bTRIbGpid2ZkVWt3?=
 =?utf-8?B?b2h5TG5NbVhDQ09ZWVFEbnZNaG95SHZoaFFTVmN6bm12SlNONnNza2VicVYw?=
 =?utf-8?B?R1lobnJ2Y2xiMk5XQUlSdGppaWR6dTUxVno0Z1h6dWhtR1kzdWNFSzZoNEVo?=
 =?utf-8?B?ZHJPLzhtM0RuMDBkbURDMm12L2FUamZ3Z3ZiNUxLeHZlQ2J2REQ1RzVhV2Fv?=
 =?utf-8?B?YmJkUzJObndDeUVyZ0J5Z29ZK0dRQzV6b2xUUEs2WGVlNWRyZjh6TGpMckow?=
 =?utf-8?B?NlY4UzFieHJ5K1d5S1V4L2tFNjkrdWxMZ0RtUDJ5MlhOS0ppVHBYSEF5OEhY?=
 =?utf-8?B?WU9XK1BNb2NONmpxZmo2aVlHYVlVN3VNT0g0aTB0YXZaZWRsNUF0VFNzVWRx?=
 =?utf-8?B?YWhzSXZXcmp3TTA2UnQyaHVNTWdhQ1pFZFNtblcrMStjTWFkRnBSRlpaK00v?=
 =?utf-8?B?UWpQZnNBalZ4OHlVTHk5NWRIKzEyV0R2UlF2Vlh4M3ZqeHpOekxIM0dVUlFB?=
 =?utf-8?B?YjVMVkYrNFJwU29zQ3hjWUpGaWpNcUxJS1plY1hzWlVCWkhEekVBeEdKUFJv?=
 =?utf-8?B?anR0TTgyUURHU092SFhPZDVmck1pNnlWMjNuNUhOWjQvS1plbG03SG1KWU44?=
 =?utf-8?B?MmZRYWpCSS9HSEpkSjZmbE92K0JQRk1uMWUvL1FXNThxcERQc0FVUjVXQnBV?=
 =?utf-8?B?a1d5eGlTT29wbnJ0cnkvalFBOU5vVUppNG5GekUvS0tBeU4rQjEvaHg5ZCsw?=
 =?utf-8?B?TUhyVjJnWWxxVmNYOFJNQ01uZlV2YithRmppTU01bGtaK1NOM0wrbldrcGFB?=
 =?utf-8?Q?nhTiYUe9nwbfJEALe8iBODwaGmFhgoOZ5Ty/Ds0cKs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <572D45B8D048CC43B6FEADC96B296EF7@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c983cc-4aa6-4fea-3124-08d9fbab0868
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 17:43:44.7723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xjD9vdDNbxKpquo+jis9st6SISJ613FXxXj6/zxrF5tlvT9pTz71/4RZVrBuZwWM/hiG8zolEH2vn7ewEmasl5zNw4iWVKVJuHCyYbED1Io=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAYP264MB4253
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDAxLzAzLzIwMjIgw6AgMTg6MTUsIEx1Y2FzIERlIE1hcmNoaSBhIMOpY3JpdMKgOg0K
PiBPbiBUdWUsIE1hciAwMSwgMjAyMiBhdCAwODowMToyM0FNIC0wODAwLCBMdWlzIENoYW1iZXJs
YWluIHdyb3RlOg0KPj4gT24gVHVlLCBNYXIgMDEsIDIwMjIgYXQgMDc6NDQ6MjZBTSArMDAwMCwg
Q2hyaXN0b3BoZSBMZXJveSB3cm90ZToNCj4+Pg0KPj4+DQo+Pj4gTGUgMDEvMDMvMjAyMiDDoCAw
MToyMSwgTHVpcyBDaGFtYmVybGFpbiBhIMOpY3JpdMKgOg0KPj4+ID4NCj4+PiA+IFdlIHNob3Vs
ZCBydW4ga21vZCB0ZXN0cyBhcyB3ZWxsLg0KPj4+ID4NCj4+Pg0KPj4+IEkgdHJpZWQgdG8gYnVp
bGQga21vZCB0ZXN0cywgYnV0IEkgZ2V0IGEgY3JhenkgcmVzdWx0Og0KPj4+DQo+Pj4NCj4+PiAk
IC4vY29uZmlndXJlIC0taG9zdD1wcGMtbGludXggLS1wcmVmaXg9L3Vzci9sb2NhbA0KPj4+DQo+
Pj4gJCBtYWtlDQo+Pj4NCj4+PiAkIGNkIHRlc3RzdWl0ZQ0KPj4+DQo+Pj4gJCBtYWtlDQo+Pj4N
Cj4+PiAkIGZpbGUgdGVzdC1saXN0DQo+Pj4gdGVzdC1saXN0OiBFTEYgMzItYml0IE1TQiBleGVj
dXRhYmxlLCBQb3dlclBDIG9yIGNpc2NvIDQ1MDAsIHZlcnNpb24gMQ0KPj4+IChTWVNWKSwgZHlu
YW1pY2FsbHkgbGlua2VkLCBpbnRlcnByZXRlciAvbGliL2xkLnNvLjEsIGZvciBHTlUvTGludXgN
Cj4+PiAzLjIuMCwgd2l0aCBkZWJ1Z19pbmZvLCBub3Qgc3RyaXBwZWQNCj4+Pg0KPj4+ICQgZmls
ZSBtb2R1bGUtcGxheWdyb3VuZC9tb2QtbG9vcC1hLmtvDQo+Pj4gbW9kdWxlLXBsYXlncm91bmQv
bW9kLWxvb3AtYS5rbzogRUxGIDY0LWJpdCBMU0IgcmVsb2NhdGFibGUsIHg4Ni02NCwNCj4+PiB2
ZXJzaW9uIDEgKFNZU1YpLA0KPj4+IEJ1aWxkSURbc2hhMV09ZDQ2OTU2YTRmZDM2ZDhkMzQ2Nzgw
NmMzMTgzMWM4MTIxN2E1NzNmNSwgd2l0aCBkZWJ1Z19pbmZvLA0KPj4+IG5vdCBzdHJpcHBlZA0K
Pj4+DQo+Pj4NCj4+Pg0KPj4+IEhvdyBkbyBJIGdldCBpdCB0byBjcm9zc2J1aWxkIHByb3BlciBQ
b3dlclBDIG1vZHVsZSA/DQo+IA0KPiBkbyBJIHVuZGVyc3RhbmQgY29ycmVjdGx5IHRoYXQgeW91
IHdhbnQgdG8gY3Jvc3NidWlsZCBrbW9kICsga2VybmVsDQo+IG1vZHVsZXMgdG8gZG8geW91ciB0
ZXN0PyB3aHk/DQoNCg0KWWVzLCBJIHdhbnQgdG8gYnVpbGQgdGhlIHRlc3RzIG9uIG15IFBDIGFu
ZCBydW4gdGhlbSBvbiBhIHBvd2VycGMgYm9hcmQuDQoNCj4gDQo+IElmIHlvdSByZWFsbHkgbmVl
ZCBpdCwgdGhlbiBiZXdhcmUgd2UganVzdCBjaGFpbmxvYWQgdGhlIGtlcm5lbCBidWlsZA0KPiBm
b3IgdGhlIG91dC1vZi10cmVlIG1vZHVsZXMgd2hlbiBjb21waWxpbmcgdGhlIHRlc3QgbW9kdWxl
cy4gU29tZXRoaW5nDQo+IGxpa2UgdGhpcyBzaG91bGQgd29yazoNCj4gDQo+ICDCoMKgwqDCoG1h
a2UgVj0xIEtESVI9JEhPTUUvcC9nZngtaW50ZXJuYWwvbGludXgtYXJtNjQvIEFSQ0g9YXJtNjQg
DQo+IENST1NTX0NPTVBJTEU9YWFyY2g2NC1saW51eC1nbnUtIGNoZWNrDQo+IA0KPiBCdXQgcnVu
bmluZyB0aGUgY3Jvc3MgYnVpbHQgYmluYXJpZXMgaXMgcHJvYmFibHkgbm90IHdoYXQgeW91IHdh
bnQ/DQoNCkkgd2FudCB0byBydW4gdGhlbSBvbiB0aGUgYm9hcmQuDQoNCj4gDQo+IEFub3RoZXIg
dGhpbmcgaXMgdGhhdCB1bmxlc3MgeW91IGFyZSBwYXRjaGluZyBrbW9kIGJpbmFyaWVzIG9yIGxp
Ymttb2QsDQo+IHRoZSB0ZXN0c3VpdGUgd29uJ3QgdGVzdCBtdWNoLiBrbW9kJ3MgdGVzdHN1aXRl
IGRvbid0IHRlc3QgYW55dGhpbmcgb24NCj4gdGhlIGtlcm5lbCBzaWRlLi4uIHRoZSBrZXJuZWwg
cGFydCBpcyBtb2NrZWQgYnkgdGhlIHRlc3RzdWl0ZSBpdHNlbGYuDQo+IEFkZGluZyBwcm9wZXIg
aW50ZWdyYXRpb24gd2l0aCB0aGUga2VybmVsIHBhcnQgaXMgcG9zc2libGUsIGJ1dCBub3QNCj4g
c29tZXRoaW5nIHJlYWR5Lg0KDQpBaCwgSSBzZWUuDQoNCkkgbWFkZSBub24gdHJpdmlhbCBtb2Rp
ZmljYXRpb24gb24ga2VybmVsIG1vZHVsZXMgaGFuZGxpbmcgKHNlZSBzZXJpZXMgDQphdCANCmh0
dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1tb2R1bGVzL2NvdmVyL2Nv
dmVyLjE2NDU2MDcxNDMuZ2l0LmNocmlzdG9waGUubGVyb3lAY3Nncm91cC5ldS8pIA0KYW5kIEx1
aXMgc3VnZ2VzdGVkIHRvIHJ1biBrbW9kIHRlc3Qgc3VpdGUgdG8gcGVyZm9ybSByZWdyZXNzaW9u
IHRlc3RpbmcuDQoNCkNocmlzdG9waGU=
