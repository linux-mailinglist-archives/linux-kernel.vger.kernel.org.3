Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC8A4D794B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 03:13:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235833AbiCNCOV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 22:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiCNCOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 22:14:20 -0400
Received: from APC01-HK2-obe.outbound.protection.outlook.com (mail-eopbgr1300099.outbound.protection.outlook.com [40.107.130.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B832DD7F
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 19:13:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QeDve+SLwgHXoXo35ga4+vBmvSuuS231zMu/SYR6SiendsMEIlm7qzNuOgWhLguhQ1WB7CJAUvGOngckg3uBcyaLdtm41O276XlIXyaEiNAnv5I3IPNg4T6GgJSjXojcwfRcBGs0REGyDNSIOPlDKIIQTh48k33slKUO94VHDXCRNs5J6UBrIy1fwHBLNmpEHdSfIE3QRp+NwNSoeCYqGqARJ+kLeMn1vnfHZnrNnusUJmIbEZQUq3vuw4TIuO7EM+S7YfygStoWdIdaSfCBlcyayZ8P0MRUwaKSTsZZdKbuRMFOacKAUt+SOOu9NziXkILcr2XBhhZx9jAPFtKpMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r2D8uH8bIB0zNQongcFX91NPUCq8Du72rT5d5PWBrw8=;
 b=mwKp60o1nYvAB4PUR1BuOM/lrH014pSMVV7aPdIIQuIsipM25AHn9eJeuaEjnXdoR882UexdilpqiASAje7T5YmVbHPlonHMCMobY8hx9MpWgr4sWgvzj1SykSHqAgxYRNB/Q/SkmX8E9LB7Zqw2ghxQnSykM6b9wq/rJzVHGE6wy2EXHH4JDideWjaglqgMYesPjePQD3kZ1bJvTPZKu64x9ATX3otzEQlmczFmFWprd2rtapXvDaC1m9F5XromCdZ/I+lJY1JIjXazg8xDBdaeahQ06HgO05cfxobJYmBK0Lv9fvJiqHL+2uk8EFiD2a54Bxs7QD2DnGEtwhFUpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r2D8uH8bIB0zNQongcFX91NPUCq8Du72rT5d5PWBrw8=;
 b=bpkdzzQ1BMsz9NffjHlfSZjHPxc3vSo+WXKp5bwrSQPq0f5XmeZ4UbYx4S179RGo/Va1To+qfVcyoOBQVLhNf/pk2SDNO1JOUboV+3MKmuRczUF4yOp6kRDVpf+3rN02Z+JUW1zVKkrHORJYAYdgS04ljnriEwaeVLQ6y6yoayQ=
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SG2PR06MB3774.apcprd06.prod.outlook.com (2603:1096:4:d5::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.24; Mon, 14 Mar
 2022 02:13:06 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::49ef:baa:8c3b:cb3d]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::49ef:baa:8c3b:cb3d%5]) with mapi id 15.20.5061.022; Mon, 14 Mar 2022
 02:13:06 +0000
From:   =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
To:     Darren Hart <darren@os.amperecomputing.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2] sched: topology: make cache topology separate from cpu
 topology
Thread-Topic: [PATCH V2] sched: topology: make cache topology separate from
 cpu topology
Thread-Index: AQHYNPe0u/Ikc5mFDkWwhUfMh6lF56y6gNcAgAOhlzE=
Date:   Mon, 14 Mar 2022 02:13:06 +0000
Message-ID: <SL2PR06MB30827A53DBA601F0FFFFA81BBD0F9@SL2PR06MB3082.apcprd06.prod.outlook.com>
References: <1646969135-26647-1-git-send-email-wangqing@vivo.com>
 <YiuUGi0cFyLHZhAI@fedora>
In-Reply-To: <YiuUGi0cFyLHZhAI@fedora>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 6eb7e8d3-cb68-7ef0-f53f-ab8a7db99098
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 377fbc92-15de-44df-aec6-08da05602d81
x-ms-traffictypediagnostic: SG2PR06MB3774:EE_
x-microsoft-antispam-prvs: <SG2PR06MB37746DA828A778E2B28C85D3BD0F9@SG2PR06MB3774.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i+cHJfLsYS17ozZY25nYeegpJrVCKPVS5LGaFjv1i//OVfL1fZ388HhfJ6+Sj2kV4sapjseTQ/yPQCKYkiCoVKvMa/M48gWNk7Z9k3FnFjEpTtcN6N7tEqP7KHAK0X6XyulH3CkNXybQWg6YM4OAx0c62ju6y5VwliXBqgmKYfZjRvnduwzIwynU1adT7MNgz1/1gxOCGhncZIJdqDci994EsbzTlo8hDu52bY3+ga0vGZjQB0ngYfZDN7JzdxMuC9jGnLHNpNd5xatxYF48obBg8r1gxIvZRTcC9249Cp/zd/v7xo/LFQaLI1dCs2FzLTyVUmKVpOzjOmBHANuXrHWp11BIMNNleRQ6uUw7Cp65SUkLsFYwPZYm0HPmzxxE6IxDDbORmEEdXSXrf+DIPbl9UKgDNExdgpqLvqPBEzgrQDqNyUx8lEXhy7ookQIqhhGT5lKhtHVH4FA16c/tj2JjCXU39ETr5pZQ8YbAvJBXKV2DHRXe9bBlFKPQDuSglipYhE7JI0cooEqEwMjZ9WTOAKB+F8o00lcbpbun8BYzZrIQuIxdKKN5g+Qs8PGR4+zEuSre+YtmBvKFj1GSOe/dvriWFe4iGttCG/+SYujPSTmf8WLteUtIoEBlfHIMx11NxDm3g9XpHkPryG4/bINEdoXIwy7/ts8YamtEHd1djJ71mWMo8simNg+PAliAQzBk1wXDlAKgk21Xw5wMyw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(7416002)(86362001)(38100700002)(38070700005)(122000001)(316002)(91956017)(6916009)(54906003)(5660300002)(8936002)(4326008)(8676002)(76116006)(64756008)(66446008)(66476007)(66946007)(66556008)(83380400001)(2906002)(71200400001)(508600001)(6506007)(186003)(26005)(55016003)(9686003)(7696005)(52536014)(85182001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b0MrTUpqaW4rU0lyOUNBSEhET0pJUm9Wd2MrZFQxaUs0NmRFT3pGbFRDVHNQ?=
 =?utf-8?B?c0JuSHlDTlBodW1RK082RzBtU2t1ODdqTU1OaytqU09JZkN2cW1FMVA1OXox?=
 =?utf-8?B?ZTJQWWJ1SVo4YjE3cEppWWJqWkN4SlIyTGtjNDIrbnl4V2dDTU81M0RxQXNS?=
 =?utf-8?B?aWRCeFZvQTJEOWIweWZRd0VCNy9pVjRsV2J4bWpCZU5DWHpPeEI3MGxwb3Iw?=
 =?utf-8?B?VnZSSlVzQWo2MjE5bURucFpIR1F5L3dBU2RuamUzYTFjV25MQTdXUVJhRDlY?=
 =?utf-8?B?aXY1LytiQzNBak5GNDBZclhCQ1FKcDRJWThnZ1hZeTNQZzI1SFdXWG1zU0pq?=
 =?utf-8?B?cmc3UVJKY041dWh0OWlDYlV5ZFBWMWlzcHYwbUpmNUc3VnJ2ckFKa2NoNmdK?=
 =?utf-8?B?am1VeUNkRUZMbDk4Q2RuMWxGdWR6cmp3OVZ0ZEE1VUx5WlNYWTUyZkxPS0Qz?=
 =?utf-8?B?dG5vV09PZG9KR3YxQjhxZTlzem1kbzQ3MmJQaytaZ056c095ZzZqb0FQQlRv?=
 =?utf-8?B?RitEZVdON25FUENac2JQK3pwV2pZOVU3bUlYd0d2ZllqS2xqVmRpQTdVa0lB?=
 =?utf-8?B?WGQrMm9QbEhGc0dTc0dLT1k5cHF6b2VwZ2tISUU3Y3FNc0J5WEZzYk40K0pW?=
 =?utf-8?B?UzdpVS9xQThWL2MxUGxIWVkvOU9nYlI4aXR0TWhrbUlNcCtlY0w5Z2FZYyt3?=
 =?utf-8?B?eGkwTWpTM21xQ0t5UVhkMHA3eUtWMnRSeTFCSklNM0o5ME9EYUlRVlpMbk1t?=
 =?utf-8?B?SmNlem1SMitIKzdodHJLNGxRbzlDbmhJL0c2UEp2M0ZPU04vT1JRc0FmYlI5?=
 =?utf-8?B?VTlhaFhIL1BibFR4WmFtaUs3T3NlSVZkZEV3RmVvdVpTdXZMWDN3eDFIbFRD?=
 =?utf-8?B?OWJBREgrT2xDRGEzUWhoSWtQME5Sb2JDcmRoa1cwVFJFb094TitKSFBsbDVB?=
 =?utf-8?B?RFZteFV6dE43VVhyVDdEbzBBV01HaXBtYUpEbllOTVRyNDZVTVFyMFF3NFFj?=
 =?utf-8?B?emlNUjRsMitVN09SM3RiWG1iODZhVmRPNmQrUFk0V3kyTkwwQnJFaGpOYXRt?=
 =?utf-8?B?K3V4NnNOTmk5eGUzZ3BzdVBCY2hMZzdrTmZkbnVreUNSYmlHcGdTS1BvNG14?=
 =?utf-8?B?ZE5OYy9mTDEzZlErMTNhbzNKT1ZUcDR4RWNrcWpWS0w5LytheVFQOFJGYjdt?=
 =?utf-8?B?dHlQK3RsQWFtRmtRcWJ5ejl5L2xXQWlMRHR5NTFsNHpHTG8yMjNVdDN4bEVU?=
 =?utf-8?B?ejFWZXVpT2l6ZWJsbkpXTi9OdS9RR3pObEVKakV5aGtRWXBoMjRrQVBoL1h2?=
 =?utf-8?B?VERWQnRTaHpWVUNQL1Z0SVUwTThrd2txZWoyeGlsVzdoWnVaV0lyNG8vWlhV?=
 =?utf-8?B?T1JPbTJ3dVQvVlMwZmFUNTI3SE9VNzNiZlFkS1B4Tm1yVFk1T0lMeHhrOHhK?=
 =?utf-8?B?M1RkWlFGaExFNCtVUFZuOUpwS3YyMkJQbkRWTWhvYTVEK0Z2VFpxdVh5M0hm?=
 =?utf-8?B?RzY2aERvUEZzQVRXbFFadmZlS1FGeXpvdVdVd2VBK2JPTFJhSHF6aDdNS3I2?=
 =?utf-8?B?V0tSc0JNQWdPL2FTRXZncGRJMm5aY2NVR3gxaVV5T0U1eVFBRU5ZY0Z5cncr?=
 =?utf-8?B?c1czUXAzcGcrL0t5eXRGUDhjWExlYTVYTVhoNFFXUzRIbTJMWkdoVzFBSkZt?=
 =?utf-8?B?OFVBK245eTJ3M2FidCtNdnhxbkszb0hickZ1YTFES3c0NGZPbVpqa21EdzNp?=
 =?utf-8?B?ZktlZWkyUWl1Ri9lS1JoUTlVZVAzNFJWUTgzb2N6YzlzT1JVdmlKbWJKbXVF?=
 =?utf-8?B?QUt4WFo3emNSKzJwTmo4R1hZVlNFa0YzNnJyZlVlTGxZVkVhczJsUXBzK2R3?=
 =?utf-8?B?NzAvT293R0hkc08weUloemhxQXdGV0Y0QVBUN3M0MEJUNVBSeVBSclJNMXlW?=
 =?utf-8?Q?0iN5mhbDPRk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 377fbc92-15de-44df-aec6-08da05602d81
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2022 02:13:06.2475
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TXspRfwWZsud/LtwX5U3MzBv0bSJN15X4ny+1LS/oVkbGcQnQFBGS2UmCOftLGX5bYB3gmcWzHnNzZubWkDorQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB3774
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj4+IEZyb206IFdhbmcgUWluZyA8d2FuZ3FpbmdAdml2by5jb20+Cj4+IAo+PiBTb21lIGFyY2hp
dGVjdHVyZXMoZS5nLiBBUk02NCksIGNhY2hlcyBhcmUgaW1wbGVtZW50ZWQgbGlrZSBiZWxvdzoK
Pj4gU0QoTGV2ZWwgMSk6wqDCoMKgwqDCoMKgwqDCoMKgICoqKioqKioqKioqKiBESUUgKioqKioq
KioqKioqCj4+IFNEKExldmVsIDApOsKgwqDCoMKgwqDCoMKgwqDCoCAqKioqIE1DICoqKirCoMKg
wqAgKioqKiBNQyAqKioqKgo+PiBjbHVzdGVyOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICoq
Y2x1c3RlciAwKirCoMKgICoqY2x1c3RlciAxKioKPj4gY29yZXM6wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIDDCoMKgIDHCoMKgIDLCoMKgIDPCoMKgIDTCoMKgIDXCoMKgIDbCoMKgIDcK
dj4gY2FjaGUoTGV2ZWwgMSk6wqDCoMKgwqDCoMKgIEPCoMKgIEPCoMKgIEPCoMKgIEPCoMKgIEPC
oMKgIEPCoMKgIEPCoMKgIEMKPj4gY2FjaGUoTGV2ZWwgMik6wqDCoMKgwqDCoMKgICoqQyoqwqDC
oCAqKkMqKsKgwqAgKipDKirCoMKgICoqQyoqCj4+IGNhY2hlKExldmVsIDMpOsKgwqDCoMKgwqDC
oCAqKioqKioqc2hhcmVkIExldmVsIDMqKioqKioqKgo+PiBzZF9sbGNfaWQoY3VycmVudCk6wqDC
oCAwwqDCoCAwwqDCoCAwwqDCoCAwwqDCoCA0wqDCoCA0wqDCoCA0wqDCoCA0Cj4+IHNkX2xsY19p
ZChzaG91bGQgYmUpOiAwwqDCoCAwwqDCoCAywqDCoCAywqDCoCA0wqDCoCA0wqDCoCA2wqDCoCA2
Cj4KPlNob3VsZCBjbHVzdGVyIDAgYW5kIDEgc3BhbiB0aGUgc2FtZSBjcHUgbWFzayBhcyB0aGUg
TUNzPyBCYXNlZCBvbiBob3cKPnlvdSBkZXNjcmliZSB0aGUgY2FjaGUgYWJvdmUsIGl0IHNlZW1z
IGxpa2Ugd2hhdCB5b3UgYXJlIGxvb2tpbmcgZm9yCj53b3VsZCBiZToKPgo+KFNEIERJRSBsZXZl
bCByZW1vdmVkIGluIGZhdm9yIG9mIHRoZSBzYW1lIHNwYW4gTUMpCj5TRChMZXZlbCAxKTrCoMKg
wqDCoMKgwqDCoMKgwqAgKioqKioqKioqKioqIE1DwqAgKioqKioqKioqKioqCj5TRChMZXZlbCAw
KTrCoMKgwqDCoMKgwqDCoMKgwqAgKkNMUzAqwqAgKkNMUzEqwqAgKkNMUzIqwqAgKkNMUzMqIChD
T05GSUdfU0NIRURfQ0xVU1RFUikKPmNvcmVzOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCAwwqDCoCAxwqDCoCAywqDCoCAzwqDCoCA0wqDCoCA1wqDCoCA2wqDCoCA3Cj5jYWNoZShMZXZl
bCAxKTrCoMKgwqDCoMKgwqAgQ8KgwqAgQ8KgwqAgQ8KgwqAgQ8KgwqAgQ8KgwqAgQ8KgwqAgQ8Kg
wqAgQwo+Y2FjaGUoTGV2ZWwgMik6wqDCoMKgwqDCoMKgICoqQyoqwqDCoCAqKkMqKsKgwqAgKipD
KirCoMKgICoqQyoqCj5jYWNoZShMZXZlbCAzKTrCoMKgwqDCoMKgwqAgKioqKioqKnNoYXJlZCBM
ZXZlbCAzKioqKioqKioKPgo+UHJvdmlkZWQgY3B1X2NvcmVncm91cF9tYXNrIGFuZCBjcHVfY2x1
c3Rlcmdyb3VwX21hc2sgcmV0dXJuIHRoZQo+Y29ycmVzcG9uZGluZyBjcHVtYXNrcywgdGhpcyBz
aG91bGQgd29yayB3aXRoIHRoZSBkZWZhdWx0IHNjaGVkIGRvbWFpbgo+dG9wb2xvZ3kuCj4KPkl0
IGxvb2tzIHRvIG1lIGxpa2UgdGhlIGxhY2sgb2YgbmVzdGVkIGNsdXN0ZXIgc3VwcG9ydCBpbgo+
cGFyc2VfY2x1c3RlcigpIGluIGRyaXZlcnMvYmFzZS9hcmNoX3RvcG9sb2d5LmMgaXMgd2hhdCBu
ZWVkcyB0byBiZQo+dXBkYXRlZCB0byBhY2NvbXBsaXNoIHRoZSBhYm92ZS4gV2l0aCBjcHVfdG9w
b2xvZ3lbY3B1XS5jbHVzdGVyX3NpYmxpbmcgYW5kCj5jb3JlX3NpYmxpbmcgdXBkYXRlZCB0byBy
ZWZsZWN0IHRoZSB0b3BvbG9neSB5b3UgZGVzY3JpYmUsIHRoZSByZXN0IG9mCj50aGUgc2NoZWQg
ZG9tYWlucyBjb25zdHJ1Y3Rpb24gd291bGQgd29yayB3aXRoIHRoZSBkZWZhdWx0IHNjaGVkIGRv
bWFpbgo+dG9wb2xvZ3kuCgpDb21wbGV4IChjb3JlWzAtMV0pIGxvb2tzIGxpa2UgYSBuZXN0ZWQg
Y2x1c3RlciwgYnV0IGlzIG5vdCBleGFjdGx5LC4KVGhleSBvbmx5IHNoYXJlIEwyIGNhY2hlLiAK
cGFyc2VfY2x1c3RlcigpIG9ubHkgcGFyc2VzIHRoZSBDUFUgdG9wb2xvZ3ksIGFuZCBkb2VzIG5v
dCBwYXJzZSB0aGUgY2FjaGUKdG9wb2xvZ3kgZXZlbiBpZiBkZXNjcmliZWQuCgo+SSdtIG5vdCB2
ZXJ5IGZhbWlsaWFyIHdpdGggRFQsIGVzcGVjaWFsbHkgdGhlIGNwdS1tYXAuIERvZXMgeW91ciBE
VAo+cmVmbGVjdCB0aGUgdG9wb2xvZ3kgeW91IHdhbnQgdG8gYnVpbGQ/CgpUaGUgRFQgbG9va3Mg
bGlrZToKY3B1LW1hcCB7CgljbHVzdGVyMCB7CgkJY29yZTAgewoJCQljcHUgPSA8JmNwdTA+OwoJ
CX07CgkJY29yZTEgewoJCQljcHUgPSA8JmNwdTE+OwoJCX07CgkJY29yZTIgewoJCQljcHUgPSA8
JmNwdTI+OwoJCX07CgkJY29yZTMgewoJCQljcHUgPSA8JmNwdTM+OwoJCX07CgkJZG9lX2R2ZnNf
Y2wwOiBkb2UgewoJCX07Cgl9OwoKCWNsdXN0ZXIxIHsKCQljb3JlMCB7CgkJCWNwdSA9IDwmY3B1
ND47CgkJfTsKCQljb3JlMSB7CgkJCWNwdSA9IDwmY3B1NT47CgkJfTsKCQljb3JlMiB7CgkJCWNw
dSA9IDwmY3B1Nj47CgkJfTsKCQlkb2VfZHZmc19jbDE6IGRvZSB7CgkJfTsKCX07Cn07CgpjcHVz
IHsKCQljcHUwOiBjcHVAMTAwIHsKCQkJbmV4dC1sZXZlbC1jYWNoZSA9IDwmTDJfMT47CgkJCUwy
XzE6IGwyLWNhY2hlIHsKIAkJCQljb21wYXRpYmxlID0gImNhY2hlIjsKCQkJCW5leHQtbGV2ZWwt
Y2FjaGUgPSA8JkwzXzE+OwogCQkJfTsKCQkJTDNfMTogbDMtY2FjaGUgewogCQkJCWNvbXBhdGli
bGUgPSAiY2FjaGUiOwogCQkJfTsKCQl9OwoKCQljcHUxOiBjcHVAMTAxIHsKCQkJbmV4dC1sZXZl
bC1jYWNoZSA9IDwmTDJfMT47CgkJfTsKCgkJY3B1MjogY3B1QDEwMiB7CgkJCW5leHQtbGV2ZWwt
Y2FjaGUgPSA8JkwyXzI+OwoJCQlMMl8yOiBsMi1jYWNoZSB7CiAJCQkJY29tcGF0aWJsZSA9ICJj
YWNoZSI7CgkJCQluZXh0LWxldmVsLWNhY2hlID0gPCZMM18xPjsKCQkJfTsKCQl9OwoKCQljcHUz
OiBjcHVAMTAzIHsKCQkJbmV4dC1sZXZlbC1jYWNoZSA9IDwmTDJfMj47CgkJfTsKCgkJY3B1NDog
Y3B1QDEwMCB7CgkJCW5leHQtbGV2ZWwtY2FjaGUgPSA8JkwyXzM+OwoJCQlMMl8zOiBsMi1jYWNo
ZSB7CiAJCQkJY29tcGF0aWJsZSA9ICJjYWNoZSI7CgkJCQluZXh0LWxldmVsLWNhY2hlID0gPCZM
M18xPjsKIAkJCX07CgkJfTsKCgkJY3B1NTogY3B1QDEwMSB7CgkJCW5leHQtbGV2ZWwtY2FjaGUg
PSA8JkwyXzM+OwoJCX07CgoJCWNwdTY6IGNwdUAxMDIgewoJCQluZXh0LWxldmVsLWNhY2hlID0g
PCZMMl80PjsKCQkJTDJfNDogbDItY2FjaGUgewogCQkJCWNvbXBhdGlibGUgPSAiY2FjaGUiOwoJ
CQkJbmV4dC1sZXZlbC1jYWNoZSA9IDwmTDNfMT47CiAJCQl9OwoJCX07CgoJCWNwdTc6IGNwdUAy
MDAgewoJCQluZXh0LWxldmVsLWNhY2hlID0gPCZMMl80PjsKCQl9OwoJfTsKClRoYW5rcywKV2Fu
ZwoKPgo+Cj4tLSAKPkRhcnJlbiBIYXJ0Cj5BbXBlcmUgQ29tcHV0aW5nIC8gT1MgYW5kIEtlcm5l
bA==
