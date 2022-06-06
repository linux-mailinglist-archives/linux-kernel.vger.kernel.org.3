Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7691B53E8AB
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241689AbiFFQ2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 12:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241695AbiFFQ2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 12:28:49 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2060.outbound.protection.outlook.com [40.107.96.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A439231A075
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 09:28:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CBOB1HQC45/I1/1WIQ0N5ZLQmTxz0RxuQc7l5JxQ46bQbiqRpXf+8WbgEKAd2bVoEdS2dZiUB+osKvY+KiitZAXZn4l7mLVqTe/seTMqxpAsd6Ssl27mDuVWconKA2/zMV9fJlO0CoQsKVqTtdM3T1omZ4k+JSyT8qjsDqMh7XP4tAmThGjD1NgUvKd6BU5jjJUBjqM5CzTbiIJ6JFGxaWU2grB5+DRMTVTmZS+9MH7/yk212ihzQB3qnrxnkUAzQye3itvxvTp0zD20/SmWonpUUpBFKXWsXT8PuoPsVJQG/kU4fwx01bCuNSy3MR2Rp+KmSXRIKHNZrr6oGzcJjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7mPVA0qIOWxMogfY+BZZYycGxotXX7K4yWdmOS35gJ4=;
 b=DXanuU5ay/xigaTfPMdxGenZ6OuhZgdqsVjpJ55VawAkbLOU+Jw0kBNUS3fIdgvT76+O1H9k0UygA0gbCazVcPWOZfPDq9PO9XmVQ6A/1XEc87AhNQNAWrxsKiLiqPanpvdfS9eZ3+dcQV7a+HqKt8Z4v3PMSyBORxvtiZTsxe98rIsVjYyTDwuGEwLEYtlYsy+TaQM2MMytfVvpeoNfW2NDsIa8YaUSTDc4jRxIOjmUDnfcSkgnABvyazoshTRadptrhJitxKvFvjRo6wP7PYc/aSwgNmdYe9DjflbPWYpsO3Lmc3Kvpis0/M0v65aRyS9I4TlFRRdOf7R8fEfWiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7mPVA0qIOWxMogfY+BZZYycGxotXX7K4yWdmOS35gJ4=;
 b=IEMDgFOMHD7kSxKuyA5zozgV4lrhcp5xSJIxfrSsrJ/UWDCP2HUi+t59spCzZ6h6+myIPB0MvAoOvQKoJdHpOMxcMDq+y7OoQmU1I4vry1xzGK7O1R+spDpGwzghIGQvxojUJpCgXnMl9ZkzLQcSjiVmtbDksnbPRlRRovyke4g=
Received: from BY3PR05MB8531.namprd05.prod.outlook.com (2603:10b6:a03:3ce::6)
 by BN3PR05MB2641.namprd05.prod.outlook.com (2a01:111:e400:7bb9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.9; Mon, 6 Jun
 2022 16:28:45 +0000
Received: from BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f]) by BY3PR05MB8531.namprd05.prod.outlook.com
 ([fe80::a4f8:718a:b2a0:977f%7]) with mapi id 15.20.5332.010; Mon, 6 Jun 2022
 16:28:44 +0000
From:   Nadav Amit <namit@vmware.com>
To:     Dave Hansen <dave.hansen@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] x86/mm/tlb: avoid reading mm_tlb_gen when possible
Thread-Topic: [PATCH] x86/mm/tlb: avoid reading mm_tlb_gen when possible
Thread-Index: AQHYPjktgPdnqvShpU6wVxX2Ukms261C+BKAgAAQdgA=
Date:   Mon, 6 Jun 2022 16:28:44 +0000
Message-ID: <8ADBA1FC-1CFF-4B4D-907A-4CF004AAD534@vmware.com>
References: <20220322220757.8607-1-namit@vmware.com>
 <84dc784b-10c9-9ade-7a20-97fe0c32f2ff@intel.com>
In-Reply-To: <84dc784b-10c9-9ade-7a20-97fe0c32f2ff@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d478c077-62b3-45f0-27da-08da47d9a046
x-ms-traffictypediagnostic: BN3PR05MB2641:EE_
x-microsoft-antispam-prvs: <BN3PR05MB264101B53195BACCC6C10018D0A29@BN3PR05MB2641.namprd05.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sbKXGEEoav5VfelWVESMYpZS+0Mb8JMeqzmsrj/sxNxTcndtNmHKWg/tz37gns+8J1yvDR0vmckMUj0HIbvsE7juN8yVYbz7kwQE329h9hIsDlHcTdK6OfI+5kAm8ZjfWqVQuL6zdibW3aJOxjBEy6VzdcGZJMsW3Bq/40qHphK+KTaIfjsqM/zSKRYvq4MEJXaoRupYzuBZBKxCpBAeUHjetrlou38eMSyzWxtJSnpAiOyIV6B7H5Go3tkoE1Q/ykPqdNyVdlvF5eJz23CGX2JtmqMFNh7qEUsfFmiOrBedv/5S1ESY4KYPS4Ipcn4LviM9aa4Te+2D49xDF53HZbdjNMeR0L19dGZ3Y8U0GR9fuRkpvoppb+7pyBRbjgIoUby0bYEOICwlymHtLhxdUyBfE0TTYtJH5vq6XajEOVrXfAnldkgMNEiOGpiweKII8mfUXSFMAWCMhOi7FsmBVfxoTdp2Wk50Ll6+qppgCIMEzjtUHFNu/dQKGdVeOQgh76CwFE+XwZs7/phs8mOjfbNs0cThupUjMVAUV2bcxb1iJOl7ax7sxSVB7I0EdkIsZTUc6thnnbPmWwGsol4iP+4xznrKoVBvOgtAjN3MdgxqQlBsbUZahacliQjQSYbnQZGs3AnqUYgwqtO67gV8AL3ytvzpbsrmtfmctYZTio22pDmgWCkjk1CQfXrhKWB/QR8ITixU1jhpJFS7WXtWS3wHS/Vf3FsJXLP9Bsl6NqAsKxKkUoR0kQpN6gWNVP+u
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8531.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(508600001)(6486002)(2906002)(38100700002)(316002)(33656002)(186003)(6916009)(2616005)(53546011)(54906003)(26005)(6512007)(71200400001)(6506007)(36756003)(122000001)(5660300002)(4744005)(8676002)(8936002)(4326008)(66946007)(64756008)(66446008)(76116006)(66476007)(66556008)(38070700005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXptbjgvajhYZ1BUbDRkNXZmblF1ZDNLRS9lZHl0N3ZBTHpPYkpZQ0pzaFRu?=
 =?utf-8?B?U2x6WDRYSzJoZEp3WlVqcnliQnI4ZVJWQU5Gb1lESUQvMkRNajFEWkJvV2V1?=
 =?utf-8?B?aHkwMUVCODhoZHBGOENjVGY0NDJJSU1nTFRKaEJydllnQmJiTzltRXQxSjFq?=
 =?utf-8?B?TE51Q0x6REkzZGRmdWhIQW11ZE5kZXNheXZGT2lLYW5BeWtoaWV5aGJDQ1l4?=
 =?utf-8?B?Q3pXZmhaVGs5VUF5TExmVnJpWVZ3Njg2OUNUTE9EZUVJN3Byd0phTU92MHhz?=
 =?utf-8?B?aDlwSEYzNXh4TksrRnA3bExBY25MT2dKZTN0RDNTc3dORkVRVTRmYmZUNmla?=
 =?utf-8?B?THlGWWJ6R0N4YkhOYjhmL1d5VTR0NzFXWS9RdnA4b1JYZUU5c0d2WlRKa0tD?=
 =?utf-8?B?UVl0VzdQVmZwTmNhMGs1L0dBcXVmZDRrY1QwbTN4MnFmWlE2RHcwYlBqMGJi?=
 =?utf-8?B?NTVPTGp0N01EQ25kRys0TkVPS3VNNnlmUkRUVm9kcStNbnU5VmdxNEV6eDhq?=
 =?utf-8?B?Rzc2K3UzZ0RTcXhqSUNvOHFxZkhScEg3cmt6REdRY1pRR1N5b3dIdDNvZ2tJ?=
 =?utf-8?B?K2l6VGJpbW9lTi9JNkpBdFVKbzBxa1FnRWFoMmF4YkFtMWJKcS92ZVcvV1ZM?=
 =?utf-8?B?ckxIVzVMYkxVTmNhSGtIaFIwaEZlS3ZaY2xzUnFvQjNib1hJbmlOMXZkNTFI?=
 =?utf-8?B?alNSMk55V3EyRHphWS9LekFFM2JvVS9TT3ZBMGV4Q0NQZzBNUFlySUFRREtm?=
 =?utf-8?B?bG93RXI0QkUvc3BuUVRJWFdmMmpBaFNxNjBKZzZnMTQzcDI4TTVscm5tQWd5?=
 =?utf-8?B?dGJtWG05NkUyMGtaRUwwR2FHQUhHNEdHdkI5R3I5clFiam5jRFYrdnBjR3pT?=
 =?utf-8?B?Nlp1WThJTGFOdHdEeEtXYVFneS9xZ3RaOUF1RlBwblpQeUpsOVprTTZnN3lN?=
 =?utf-8?B?SUN4d1I5bk5DSStycnJ6VFhqL2NVNlRXZzRkc0tOMTlwR0xnYXNHK3crVzVZ?=
 =?utf-8?B?UmRjdllRSDd3Zk9BMVhLK0JZUTdWNGZHNkJON2l1M0ZUbUtYTEw5empuS3BG?=
 =?utf-8?B?VW52SFEyYWF2dVIzTmE1YUFhTFlHTUVCb2tMT3Aza3lteVRoOWpaSmJzNjln?=
 =?utf-8?B?Z2o2TXlzT010OTNWaGwxcVp2K3B2Vkc0dVZmWjVIQW8rRk53aGpNNFJTNHlw?=
 =?utf-8?B?WnB0Vyt2WkFiUHpuR0plSk1MRWRDcEZZTENOSGg4TGJKSnNGV2FuK1J5OFl4?=
 =?utf-8?B?ODBValUxY2gzdXIxUDVTT01jdkRmY0cvbWExdEt5UE4xdVppL0hCK01uMWUz?=
 =?utf-8?B?QlBVL3lYMGdHcVhVNlJsbW9TV3dVUXZ5YzA2RDU2WU90K1ZlalFlMkNkL2tu?=
 =?utf-8?B?UEJIejMvSG5QSGpJbFg3OGxlUUIxMmM0Si9wMHMvMHNFSDFsanorYjNCejZW?=
 =?utf-8?B?NVI3OXFBZkxEemJ4RU90OW9zam1iZUJQblI0aEN6dHJQbEJNKzhIUE1GSGNw?=
 =?utf-8?B?SDJwaENnNEM0TzBoeU84SGpoTzRaZGczc1Z2MkV3WXBMUVVlTjZBV1kyM094?=
 =?utf-8?B?d1BQZjJ3QmNtWGxERXNQcE9GN3V6clYxcWRGeDZlSktmVjlqNG9zemJvRVpX?=
 =?utf-8?B?ZEtkaHh5bVQyS24rZk5CY1BnV3IrWk93NkpoMnpiWXlzYUhzUFdrYlhJSjFO?=
 =?utf-8?B?VjRReGJmNXlheTVKQS9tZXFlUzd2M2JVdmlpczVBeEtKOXNqK2ppbVljeXhr?=
 =?utf-8?B?Y2pLM3FPZWVBOEpZZk5mVTdSQkVxUzJheTZzM0NDbFYvTWN3Nkpqb05Dem52?=
 =?utf-8?B?dU9YY240Vk1wcytCajk5NWtiQWpLbGwyYThSbDJVaWo5N3VlYldxUjNmYUZ5?=
 =?utf-8?B?TFJiU3hEQTg4dnh2U1pZU0RzQ0hSRXJBZi9tU3FxZS9qZzhWVDk0SzFHb0I0?=
 =?utf-8?B?VVh5dG5lVmJ5aHIvbTgyZVJQVlczK1MyR1dQQWxzL0ZIdVZCMkRXcjJodXUx?=
 =?utf-8?B?YUVIY013SlB0K1NzNUhYbDR6RmRmQTN3LzdYc0VpalpXNkZnNXJDMWRmbHNx?=
 =?utf-8?B?K1h1SmozM2VyUlZLZ0tFVTJBYmlYRXdnRFdQR2NHUDZ0b1poYXJCeFJNcWlE?=
 =?utf-8?B?eGV5QWFrYTUyQnM3aUZKN2RHSXRVMVZSQXpIM1M5Zi9zUXNVVDRHdTljbVRh?=
 =?utf-8?B?c2xBemNEdTh4aHpXQjgrMXVTMDc5ck0vc3RKZFA2cSsyYXVTQ2l6dmpLZzdt?=
 =?utf-8?B?aEl0UUk2RXVyRlZzVTBwRVVoWTM3TytRbzc4L0I3RXFPL3lQSW9yK2cwN25S?=
 =?utf-8?B?Ty9ITWNKblFjY0t6a3BKSGhnME80d1h3NHFvVGFnalkxVUdWQWgzdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6522BAAEA9193B4788B4846EABCEA0F2@namprd05.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8531.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d478c077-62b3-45f0-27da-08da47d9a046
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2022 16:28:44.8617
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L/acgpnXMCDMlQkR1RsRqf2wjozK6h5IUBTKVufwcxCHc1OGswPA9SQloi5jTX4Xsi7MmSWphpMkVl5gtSA8EQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN3PR05MB2641
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gSnVuIDYsIDIwMjIsIGF0IDg6MjkgQU0sIERhdmUgSGFuc2VuIDxkYXZlLmhhbnNlbkBpbnRl
bC5jb20+IHdyb3RlOg0KDQo+IOKaoCBFeHRlcm5hbCBFbWFpbA0KPiANCj4gT24gMy8yMi8yMiAx
NTowNywgTmFkYXYgQW1pdCB3cm90ZToNCj4+ICsgICAgIGlmIChmLT5uZXdfdGxiX2dlbiA8PSBs
b2NhbF90bGJfZ2VuKSB7DQo+PiArICAgICAgICAgICAgIC8qDQo+PiArICAgICAgICAgICAgICAq
IFdlIGFyZSBhbHJlYWR5IHVwIHRvIGRhdGUgaW4gcmVzcGVjdCB0byBmLT5uZXdfdGxiX2dlbi4N
Cj4+ICsgICAgICAgICAgICAgICogV2hpbGUgdGhlIGNvcmUgbWlnaHQgYmUgc3RpbGwgYmVoaW5k
IG1tX3RsYl9nZW4sIGNoZWNraW5nDQo+PiArICAgICAgICAgICAgICAqIG1tX3RsYl9nZW4gdW5u
ZWNlc3NhcmlseSB3b3VsZCBoYXZlIG5lZ2F0aXZlIGNhY2hpbmcgZWZmZWN0cw0KPj4gKyAgICAg
ICAgICAgICAgKiBzbyBhdm9pZCBpdC4NCj4+ICsgICAgICAgICAgICAgICovDQo+PiArICAgICAg
ICAgICAgIHJldHVybjsNCj4+ICsgICAgIH0NCj4+ICsNCj4gDQo+IE5pdDogVGhlcmUncyBhdCBs
ZWFzdCBvbmUgIndlIiBpbiBoZXJlIHRoYXQgbmVlZHMgdG8gZ2V0IGZpeGVkIHVwLiAgSSdsbA0K
PiBwbGFuIHRvIGRvIHRoYXQgd2hlbiBJIGFwcGx5IGl0LCBidXQgYSB2MiB3aXRoIHRoYXQgZml4
ZWQgYW5kIFBldGVyJ3MNCj4gYWNrIGFkZGVkIG1pZ2h0IHNhdmUgbWUgZml2ZSBtaW51dGVzLg0K
DQpObyBnb29kIGRlZWQgZ29lcyB1bnB1bmlzaGVkLg0KDQpJ4oCZbGwgc2VuZCB2MiBsYXRlciB0
b2RheS4=
