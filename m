Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CE54D7966
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 03:37:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233325AbiCNCjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 22:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbiCNCjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 22:39:01 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2139.outbound.protection.outlook.com [40.107.255.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE7110FE6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 19:37:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ig7CcgiVmwEq/NiMwHYC+8Ba+F7Cv4HgGLY8za85WWdF4LcC2+y7FPgDtfhmAwjOnct5luXp7vaRNfQt3qi1kV3iMzovNrlmnGSHqVlKZKf7jQp3VEzoAIcN6aw7IzzJcOiGT5dlCJqR745cAPIBBMOTQ5nQuxW3+E2I+rgRU/sz2txbCKl51CpCPQXA7tWYTjE2aLSbc9dKTM/hJMuRccqW2TGgD+H6Ikivx/Xnk0NJJ2dHuRYMaZGtIl0w+H2lznUC11pT5RocnfLUN6u3szllzMQA7ZPw2td///IHc87/icmBURlsjmS18pyaVUCh4XJZEWT18OL7BeUsza/Ulw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0a0T0+i/SdNzZ5vtbqTZDiUezLe+6nVhhdxnw4NbJWA=;
 b=I4o/3uBzYPQqUtMNQNlMr3rE1T3r9fa4IGv9meSOLmaJTIIIn+BX7XJV+qO+W1V517WcxbUEWmE1DuQwr9NlpbmMH9JRYPC2FsIIpdbGT/8DUgCXtj5VcSNlRS1EzdWvRQw+Edc/qxstiR7oGlI48YAQKq0X1fJsi0/WmDv1myx1DUvIF46QeHeo5ko0bvNlkMOOQ4mhd1oVDEMwb8Ui+OGRG+x7/iutQdinDu5k91h6tgzoJo1+CD6TlGE62aJhDyXKvbHknhoY9kwMOo/Ml/qE90akFzgUmKBDHr03OTMFi7Yjne3411mquXgTHGGuZWFcun7VRP5xO/vaSTMpiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0a0T0+i/SdNzZ5vtbqTZDiUezLe+6nVhhdxnw4NbJWA=;
 b=ZlolT/AIDmBPIBYdAAhI8l0BBnSwQssdWNN8SihGmcE9giBrxGxxo5Jb8v5ecMM9Y0mccgO2fIrDm5d9Lj+DMsYQecnou1In+6TUAtRdnrG/QS31SDllHbn4IxY9JNzKNPJKZZO1/dwfYHzdSDfatWQH5kIfA633F9uq8nQLo04=
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SG2PR06MB4882.apcprd06.prod.outlook.com (2603:1096:4:179::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Mon, 14 Mar
 2022 02:37:48 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::49ef:baa:8c3b:cb3d]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::49ef:baa:8c3b:cb3d%5]) with mapi id 15.20.5061.022; Mon, 14 Mar 2022
 02:37:48 +0000
From:   =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
To:     Peter Zijlstra <peterz@infradead.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] sched: topology: make cache topology separate from cpu
 topology
Thread-Topic: [PATCH] sched: topology: make cache topology separate from cpu
 topology
Thread-Index: AQHYNH6wtHW6B7ixb027761a5egjaKy6DEGAgAQe1aY=
Date:   Mon, 14 Mar 2022 02:37:48 +0000
Message-ID: <SL2PR06MB3082047700A8440BD0DE80DEBD0F9@SL2PR06MB3082.apcprd06.prod.outlook.com>
References: <1646917125-20038-1-git-send-email-wangqing@vivo.com>
 <Yisxg3izMrGVahOQ@hirez.programming.kicks-ass.net>
In-Reply-To: <Yisxg3izMrGVahOQ@hirez.programming.kicks-ass.net>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: e0506239-21e4-4a4e-87c4-474d2371bf42
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9002e27e-5d71-4602-8206-08da0563a0ed
x-ms-traffictypediagnostic: SG2PR06MB4882:EE_
x-microsoft-antispam-prvs: <SG2PR06MB48829CB43961EB8C13D847F0BD0F9@SG2PR06MB4882.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Llvu3RaofGfjJgk55b3sbV0IRWiN8v6pNP6LFzL8CWv5tdR6nnnUZV4g9nSO//5N353Hv5vG3S5ICxDANoObR6rgY54E6ljSeNfTN3G1yTScJKHoFTncUiKyyWFdLyYyB6lXkhSnMz0YRI4464VkRGcguizDElw95e6AcPP2Ir11fidLZfdxpcKUNbxD4SmSsX0L6rNNs5nGRRBCIFC2f8O5rj4y7+Th+nr1OIebKMDE2vbFabhHLBAIlv9H4qmr49RbZ2jDNOFok5jCu410F16UES9FjZ4GjARRUYNj8o3C1wfIH0Zdh8X/uTfikjV+T1lDzRkTGAxPm6KkkEk85SiytIDgSEzTAMnbu9apYJT6QF9UOWu8C/hk+MnqkROYDNpNAEwQpukdnl8z5K3VMqf49wgCt3KthrjAMKJMR/DaaCm59mVrOVpIsI7Wp/M0ltinkdcu0mrtADnlDqfwGK0KQtXhwO6GDMn8ZPyudpaAD8chHnuFuMH9qZywHTdKicc+ChToE8k19YPlsmXo5Pyrp6MWXxegMx+t5exI8H8WiJbUDkdm1tKDnNWMKtIGfJoNHGzXswJaV/lAKUIEjFW7+4m00JashcmXMInkyi44yaWQPN9Rj+1tY2NMpD7RN74SI06MMZL2MjDFor6RfMZ+D5L3UGRR4l9HAqG+UA6bFK3K179vRKun99Ts94KwxniuennbYpV3Ly4nqZqOJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(26005)(38070700005)(122000001)(38100700002)(86362001)(91956017)(2906002)(9686003)(4326008)(66476007)(66446008)(64756008)(55016003)(66946007)(66556008)(54906003)(76116006)(6916009)(316002)(85182001)(5660300002)(8936002)(7416002)(52536014)(508600001)(71200400001)(6506007)(7696005)(8676002)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VVR4ZSt6U2RxMkVZODFaQUtYbXVSTHNwQmlkeUd0cVF4OW9FU3dzNDFLdUw1?=
 =?utf-8?B?ZTVxMjhLNDl2K0RVdnFXRkhpcHVmQ2NiaDBFYmFGQnVMUm9Db0hFcmZEdzE3?=
 =?utf-8?B?ZWpwWDJqQVRsL0hVN3FLYUV3MW1Jd0w5WUJ2NzVOV01aMEg2UENIbjRLVFVu?=
 =?utf-8?B?bWVlRU5KTkNxa2piNDVZRHIzN0d0cUN0REcxR3NQT1V6cEZSc0JUWVF3cTJF?=
 =?utf-8?B?eUgrdGdzV3dQdXhBbExreHJCYW85RmdQWEdsZ0syUXByS0UyMnRtZURUNjM2?=
 =?utf-8?B?czdPREJTOUFJMXIvRmdxOVZRQ1UvNnF1T3hWZDU2YVgxNGdRQ3BZWmx1dlJQ?=
 =?utf-8?B?SzhSMDlTdFBsLzBMU1h5eGFmSHBqdXlHMU5uOXZlQ1FQdHhSRmdnQTNVcGZq?=
 =?utf-8?B?UHBPWERxTmhiOExRMkRqdkZzVXRiQ0NaOFg3R0d4eTUzSTJBUGM2aHZPU0M5?=
 =?utf-8?B?T1R3SEwyQ3hDRlhaK2xNaXRLdUg0T1F5aVR0SWI3VnZybllWVE92UG5oU0Zn?=
 =?utf-8?B?OU9tUWthczRvcVBNUExNTkR5TjQrbUNxSzJGWEFYODlJTGdYT1VrekF0VUhW?=
 =?utf-8?B?S20wM3gxRCsrMU1EOEFGZUJnRG42eEVYVkV0VGdwRG00SHpSeEFuMHJMcUpN?=
 =?utf-8?B?OFRFdW9lN1R4OGdDY2Nkd0k2akhqN0lJK2VzbElPQm14VXZHV0NNeDFkQ3ZS?=
 =?utf-8?B?dXNVYUFkRHcvN0JwQXdqMDNDZHFNUmJ0Qkk2eUNsYXVjSHQyc0V5NGtEdDZq?=
 =?utf-8?B?VmpZZlkyTENZNURVMW9mRmxqUHRFcktPSEZVU2dMd2lsT01GUFAyOU5icEd1?=
 =?utf-8?B?ZTh4YTFqZHhOZGV4WVNUQ216Z2Vxdlo2UHpiL1Y3RTRlMXJRbW9FZ0lOZU5V?=
 =?utf-8?B?WDIxRmpydGFidWF1R2lDd3ZRVzFXWkRBTURHdzRtaUVKdHhncW1xcFRRMDlK?=
 =?utf-8?B?Vmk4aWJwNmc2dmNzeHZtQlBKU0l2RHQrbzNMc0lsb2xOc0NFN1JkRHNmQkZ0?=
 =?utf-8?B?TWFLT1FmajZxNE9CaDBzOTJNMFhOVE1jRjZaRHJrNHo0MGpYRGdPaUZaUFJv?=
 =?utf-8?B?bWRoRFl5TkNXZW05ZGlIZUlVaktOZVc0RE9YYjlMYytaYlRLUkx6by9rMDJm?=
 =?utf-8?B?MHZQcmtmYWpaNWd4U0xPWFQzT1RKYVI1bjdqVS9rK1hsR2FsVmhJT3prQ3Vq?=
 =?utf-8?B?VmRNNHgwVDg3dHlpMTdxbFRVaEN0Ty9pdzRqVWNLRWxDRHRmQ2Zmelgrcm5C?=
 =?utf-8?B?dHk5dlZCTlQ0Y1UzSjhFQmVGU1Rzb2JRWU0rekxGR3lNTEltNWRIbER0Ynpu?=
 =?utf-8?B?T2dmakg5ckVJWTNzQkhlUklnMXlFVmxrYnV3eU9SR2tDMWd2V29saHJ6MmpD?=
 =?utf-8?B?c3JrU2pmVHFIc0JJRWNYMnErTjRBbld0LzlKbloweWZIOUNEb0NFYlVPdk0z?=
 =?utf-8?B?TVJwNUVNQU0xanJvOTJSQU0xWWtHWVZHWEhZRXZpUTdBRUhMUGlBYmRSZ214?=
 =?utf-8?B?QlhScUJRTW0xUUV6bTJBVWtUc3JsRm5UWE9jNFBpcnFMOGR1Vnl5bndqNkw3?=
 =?utf-8?B?YnNkOGZXRTA2VWFiN2pBeFFCelhUVTdqa1RuVFVrd1AzOVkrSjU1UGpreDg4?=
 =?utf-8?B?bytDVFhOamMwajFSV0p6MndtUUYwM3VYZHZrUWJWVHA3YVBEd3haY0pueGNo?=
 =?utf-8?B?Ympwb1NKZ0VTMTgybXB1M2JUT0JvTjVzMGZRN0ovNUZuYlB1Z3krK2hZUUc2?=
 =?utf-8?B?VUpZOTNlNzl3NnNEVmNhUzducGU2VTJuc3daaklOY282ZzBGUXU2eWZVOG8w?=
 =?utf-8?B?dWxGL3FrejQ5eThKUUdsUWpEZE5sMGVzQ0lpQ1lUZ3VuREMrYldtMjlhMFB4?=
 =?utf-8?B?RCtJRTVMU2M2WlZrc3RzaW5uUERuamZYU2JPcHV2bmxRbldYWnVxQXRhaVAy?=
 =?utf-8?Q?27+jplOjKSg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9002e27e-5d71-4602-8206-08da0563a0ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 02:37:48.4136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6u2dzvZbl0dDULByybTVijjsZrxykdFLi3/AksrvXi7/JvylMwECxgAVV93epvYsyG+4K7PlW66ao6trMjV0fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB4882
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

wqAKPsKgPiBGcm9tOiBXYW5nIFFpbmcgPHdhbmdxaW5nQHZpdm8uY29tPgo+wqA+IAo+wqA+IFNv
bWUgYXJjaGl0ZWN0dXJlcyhlLmcuIEFSTTY0KSwgY2FjaGVzIGFyZSBpbXBsZW1lbnRlZCBiZWxv
dzoKPsKgPiBjbHVzdGVyOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICoqKioqKiBjbHVzdGVy
IDAgKioqKirCoMKgwqDCoMKgICoqKioqKiBjbHVzdGVyIDEgKioqKioKPsKgPiBjb3JlOsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDDCoMKgwqDCoMKgIDHCoMKgwqDCoMKgIDLCoMKg
wqDCoMKgIDPCoMKgwqDCoMKgIDTCoMKgwqDCoMKgIDXCoMKgwqDCoMKgIDbCoMKgwqDCoMKgIDcK
PsKgPiBjYWNoZShMZXZlbG4pOsKgwqDCoMKgwqDCoMKgICoqY2FjaGUwKirCoMKgICoqY2FjaGUx
KirCoCAqKmNhY2hlMioqwqDCoCAqKmNhY2hlMyoqCj7CoD4gc2RfbGxjX2lkKGN1cnJlbnQpOsKg
wqAgMMKgwqDCoMKgwqAgMMKgwqDCoMKgwqAgMMKgwqDCoMKgwqAgMMKgwqDCoMKgwqAgNMKgwqDC
oMKgwqAgNMKgwqDCoMKgwqAgNMKgwqDCoMKgwqAgNAo+wqA+IHNkX2xsY19pZChzaG91bGQgYmUp
OiAwwqDCoMKgwqDCoCAwwqDCoMKgwqDCoCAywqDCoMKgwqDCoCAywqDCoMKgwqDCoCA0wqDCoMKg
wqDCoCA0wqDCoMKgwqDCoCA2wqDCoMKgwqDCoCA2Cj7CoD4gCj7CoD4gQ2FjaGVzIGFuZCBjcHVz
IGhhdmUgZGlmZmVyZW50IHRvcG9sb2d5LCB0aGlzIGNhdXNlcyBjcHVzX3NoYXJlX2NhY2hlKCkK
PsKgPiByZXR1cm4gdGhlIHdyb25nIHZhbHVlLCB3aGljaCB3aWxsIGFmZmVjdCB0aGUgQ1BVIGxv
YWQgYmFsYW5jZS4KPsKgPiAKPsKgPiBDYWNoZSB0b3BvbG9neSBzaG91bGQgYmUgc2VwYXJhdGVk
IHdpdGggQ1BVIHRvcG9sb2d5LCBpdCBjYW4gYmUgb2J0YWluZWQKPsKgPiBmcm9tICJuZXh0LWxl
dmVsLWNhY2hlIiBpbiBEVFMgcHJlZmVyZW50aWFsbHkuCj7CoAo+wqBJZiB5b3VyIGNsdXN0ZXJz
IGRvIG5vdCBoYXZlIGNhY2hlLCB0aGVuIHlvdSdyZSBjdXJyZW50bHkgc2V0dGluZwo+wqBTRF9T
SEFSRV9QS0dfUkVTT1VSQ0VTIHdyb25nLCBpZiB0aGV5IGRvLCB0aGluZ3MgYXJlIGNvcnJlY3Qu
CgpJZiB0aGVyZSBpcyBhIHNoYXJlZCBjYWNoZShMMykgYmV0d2VlbiBjbHVzdGVycyhjbHMgMCBh
bmQgY2xzIDEpIGZvciBhbGwgY29yZXMsIApidXQgbm90IHdpdGhpbiB0aGUgY2x1c3RlciBsaWtl
IGFib3ZlLCBzaG91bGQgd2Ugc2V0IFNEX1NIQVJFX1BLR19SRVNPVVJDRVMgCmZvciBNQzAoY2xz
IDApLCBvciBqdXN0IHNldCBTRF9TSEFSRV9QS0dfUkVTT1VSQ0VTIGZvciBDTFM/Cj7CoAo+wqBJ
ZiB5b3Ugd2FudCB0byByZXByZXNlbnQgTDIsIHVzZSB0aGUgbmV3IGZhbmdsZWQgY2x1c3RlciBs
ZXZlbCBvcgo+wqBzb21ldGhpbmcsIHRoYXQncyB3aGF0IGl0J3MgdGhlcmUgZm9yLgo+wqAKPsKg
VGhhdCBpcywgeW91IGNhbiByZXByZXNlbnQgdGhlIGFib3ZlIGxpa2U6Cj7CoAo+wqDCoMKgwqDC
oMKgwqAgRElFOsKgwqDCoCAwLTcKPsKgwqDCoMKgwqDCoMKgIE1DOsKgwqDCoMKgIDAtMyzCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIDQtNwo+wqDCoMKgwqDCoMKgwqDCoCBDTFM6wqDCoMKgIDAtMSwx
LTIswqDCoMKgwqDCoMKgwqAgNC01LDYtNwo+wqAKPsKgQnV0IGlmIHRoZXJlIGlzIGNhY2hlIGF0
IE1DLCBMTEMgaXMgd2hhdCBpdCBpcy4KClRoZXJlIGlzIG5vIENMUyBzdXBwb3J0IGZvciBMVFMg
bm93LCBhbnkgcGxhbnMgdG8gYmFja3BvcnQ/CgpUaGFua3MsCldhbmc=
