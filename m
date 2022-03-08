Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6364C4D0FCF
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 07:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344378AbiCHGL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 01:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234179AbiCHGL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 01:11:57 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120074.outbound.protection.outlook.com [40.107.12.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F58A3BF83;
        Mon,  7 Mar 2022 22:11:00 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ym/mJl/Ee1t1iXuu8aS1GjoEkhRnVsnXE1G7CJkGWU4CkVHUjn1qLxgHEGKbDw6pIU90+96ycPjMz9xyyLioN0QK+2LvF7/uBTlH0m7np1jYOmIiJybW+EEN6++zdhaD1rFoA2a8+5kSM+h1vaVYOGpLxspFhuhhJs6Pe2iI//B2cNgFBTwZZXLkoMHOmPqtQyRGS58N9p+56uIc+Lb24cJjXXpYhQLjm+O9kUHVfJSe2LZNfFNWjGZy/UNARYYLcK7vq45T1uwFha+ww3XgZBLeZorwmfnvu1iaNDkq9njfB4VkesjMuyA/625nlIMsfxr3NxKe+5St2u0HF2qlgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gC8T/LC86Ax9fSFgJG9RBwv/pubz0hkTPxz0inNttA4=;
 b=SREtz8wI1kd5tiNjS3hEimsnYvtnECjNqYR7tqRuPDa7GM3s9oZft3Clod6r2URWYor3fSJy+RqAZgwNpz8pFy3uVspmIFlDfiKKRyQDwWhpd1sZY+tdbvLrQQnGT3ICfkRpeIhfl/uWK9IJF6EzJO/dv6wcNNg5lGdKiY7D4Oe85VPdPCzlHM0SdedAzlbBVXWPtyL/ZD4ZZQMZ48bDHJtOUZp9LQJk0RVBVV5y5NQuzRKCqlgL10Zja+wwPdP28zv+R2H29DcFHmyrDHLR2hIqDuughDUfCQck48kAQheMrgbLDduv+7xu8PGcG/fpmQPZhy2CfnYofGSqzmopZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB0363.FRAP264.PROD.OUTLOOK.COM (2603:10a6:100:8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.13; Tue, 8 Mar
 2022 06:10:56 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::cd2f:d05d:9aa3:400d]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::cd2f:d05d:9aa3:400d%4]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 06:10:56 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Aaron Tomlin <atomlin@redhat.com>
CC:     "cl@linux.com" <cl@linux.com>, "mbenes@suse.cz" <mbenes@suse.cz>,
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
        "hch@infradead.org" <hch@infradead.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: Re: [PATCH v10 00/14] module: core code clean up
Thread-Topic: [PATCH v10 00/14] module: core code clean up
Thread-Index: AQHYMksde+zZeRksuEqfqxIrOYMWLay0aZoAgACYXIA=
Date:   Tue, 8 Mar 2022 06:10:56 +0000
Message-ID: <1245a265-e3c0-b52a-5fc4-9508f5dd211e@csgroup.eu>
References: <20220307174509.2887714-1-atomlin@redhat.com>
 <YiZzotNHdKsvixLD@bombadil.infradead.org>
In-Reply-To: <YiZzotNHdKsvixLD@bombadil.infradead.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 379bccc2-e812-4353-282a-08da00ca68c9
x-ms-traffictypediagnostic: PR0P264MB0363:EE_
x-microsoft-antispam-prvs: <PR0P264MB03630699FE55F18EB25600A6ED099@PR0P264MB0363.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pDm8pyN4LtDRw+OVE9Mc0nVYTTFRWaxb4gUYshbS7E8mYy8kCskoRet7k8XwciDceZEwx/mC7FMjvU9n6g76xgInj8ntZkC+1V7eI+rgGtv0f06aMaSGDA+Vnf6f7FqU5xT2Zdtmj8BnV/bpyr2vXG3efJ96qkDqNkqIJ6xCt6CJPAm4LdDGbn7yZ2M4wMKZ2RF/ZUGf5R80cKGzpvLRGjCSLz+ZhHEBmIbiqWEJMmdZUunJmvawDc8N8iph+xFKi3qhXLGWrGaznfk4mheXK4hLaFn2wazXDqMeu1u/RuXdBgbvG+jPZFc1qfKTenlV1J68zQ7Z8tNb/NEXaqx/JtDOPbDvSBGKwbKYMrZYCY01DOjv0HtBZmwB/QTYuDiSoQnqyq6k5CLH3dgbUF6A0FmffgaZx2YLARoKRVgOZ80Or2JNqWsBAiR/6pDhi8u5q7IuN5sxS/svPzM4JcG2ptFHVM75dAZWIBN0IKYBUwpk8oZgciEzlCx0a44jsF6jQl8kQ+bu/04zsPYH1ku+u0MbfQIa+LgNM+0AdWGjkrOhXUz1dbtzCSbweCmSZGb8XgsW8kdH/m89wVgzKwq1HRt4RhOv8LavZ6TodfcMKKVlaXFmMXQ6Mblr3Cko8CN49r4StmyZTQ0IoA+yO47+L+o/sNoK78DjQfRtZd9DKdNs3MIPVgFFime+aJUwCk2T0TwtG/qgghev/ASrsqQtYR4lKL929U0vMdBEM9yVEI9xYgTP9IBd7j5WMiUsec9nd10oga1UfRez0eaaWxY58g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(66556008)(66946007)(4744005)(44832011)(66574015)(316002)(5660300002)(7416002)(6512007)(8936002)(54906003)(26005)(91956017)(110136005)(508600001)(66476007)(66446008)(64756008)(4326008)(86362001)(122000001)(186003)(31696002)(6486002)(8676002)(36756003)(38100700002)(71200400001)(6506007)(2906002)(38070700005)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?S2NwVGdUcy9yTFlMcjVUQWNLUXcyYUQrUUFRSkduMGZIcmlCQTR4NXFBbUpp?=
 =?utf-8?B?Vnh2b1ZPVWI2aUF2cjIvZUc2RllndDVRM2tCQkI1NGpWQm9hTFZtOHp1UnFG?=
 =?utf-8?B?Y0UzUUlrOG44dWFzS21DczF5RkNSaGV2ZDNTQlZmQ1RGSTlhL1hEUDlOR01V?=
 =?utf-8?B?aDBFcjBVZmJNNjcwUTNvVk5iN3c0UFZOVkxxQzZzM3VCWU1wRVZPZjI2a0xo?=
 =?utf-8?B?MUVoR0MrUFQ0ZjMrYTN2UExFY3NzSVJtVTZWNm5NbGlXNzVFbStTaU9kYitv?=
 =?utf-8?B?eWNKRWZmSmNpcmU1YUNubmpadGsvOTN4RndDSjlmRFZyc2s5VHhOVjZrZFlh?=
 =?utf-8?B?NFFNa2lFeHJkeGlkbzgvbmpkVzlpT0E1UzlyeFY5cm9EMnV4WEpSTUdReXRu?=
 =?utf-8?B?TSt5YkRCU1J3K0k4QytZNWxaQStkWk1ydmJwYklESldqZDhEd1dmYUQxeGFa?=
 =?utf-8?B?THhkUHlWaTZkY1g3UEJiMDZuZ1FwWHFrb09YUHZXc2tGdEdweXNtdjNzVGV5?=
 =?utf-8?B?am8vbkFQaVdFMzdMRkJIb3ZybGdCUkg2aTNwREFNYTB0aWxYc2hnd3MvTS9R?=
 =?utf-8?B?UExoYitzeWRZYk9hcklyTmp4U1RJV1QxYVNsUUxvZ1RtcjYycWw3L2xOM1hP?=
 =?utf-8?B?KzdZT0dROHJkaGIyMHIvU3pQcm4yNjY2MHRrYzl5NXhmN1lSbWJqMlZ5b1Ew?=
 =?utf-8?B?LzFKWUdXWnpIM3F6ckF4dk5obFVDUDhyakIvdmM0WHBnd0lFNFNPL2JjVmlR?=
 =?utf-8?B?aTJ2ZlVDbXhOL3JweWhoc1Rna1JmcVVVSzE0YmdFZ1I0UDMxRThWUlF4NEVO?=
 =?utf-8?B?S0FjcmVsQmRxWUNYa1BieWVoejdRUkRhMHMyWm5tNDQ4RlJFMGlrTnNXWlZJ?=
 =?utf-8?B?REtPN0s3a2ZUQ2FvRWFJSGxRbnJhaTBQUXVFc1VHb2ZXdUVGZGhRN2QyS1lG?=
 =?utf-8?B?cHMvTDIyQytoOHdrTFNGY0pHZWhJYlgwOUJkSGltejQ1STVlOGhUdDBKMlVx?=
 =?utf-8?B?aUVndkQ1dmtWc0NrODRRdlRGdlpmc1lZc0ZHNkp0eGJvYnY1WjVVbFVIY2da?=
 =?utf-8?B?NEQ0Y2hjNUJPMm92ZWh1QmMwZUhlUnpydStxcUxRSXgzT2I3UThYSTlXNjB4?=
 =?utf-8?B?ZGtleHVjbU9MK3ZBNk15Y0ltTkZIZmhXRXVKS3d3SS92YitWbVpNUmloRGFm?=
 =?utf-8?B?bEV1aGZoRVIxdVJENk1OQXRWVS9qTVRNUzRUWllMQzVhWjB2ckVIVG84ak9y?=
 =?utf-8?B?TUd0elUrZERNem0ya0E0QmFrZm5WajRqVmpRTlIzRFdscnExYzVocU16WHla?=
 =?utf-8?B?OHY1V1ZnWWRMSTdKWXlKaFF3WnNMeVBrZG5wY0VURFQvcERBNEVPNW5zYjRI?=
 =?utf-8?B?Qjkwdm1oWTFuSWtCNjVtK3pORlhCYnVjWXpsSWNDd2dZMDdaRGxwSE5FMThD?=
 =?utf-8?B?aGEycUNhVlhubyt5c25VNzBKYVhEd2xoQjJpUXNEOTduNk1JMUdDeXlXZjJk?=
 =?utf-8?B?NllLV2c3eDYraTVxOVNLaGpzQnVMSEtHdUZjWEg3VlE0ZWdnTWI3b3dyU2FT?=
 =?utf-8?B?M3IxY1ltMEhMMXREa1lHanB5bVp4djkwekJSMDJsVEhhdmxDVEd5RUVzOFZT?=
 =?utf-8?B?UUdaTmN0dEsydlRRSk1VZWIzNy90azVPc2hvM2ZGS3Qyd05hOCt5OFJYU0o0?=
 =?utf-8?B?RE5DcnpRM0RMK0N4cTN5UXd5Y0d6TFBTYkd0NGRtTENQano3L2QyUXZYQ1Vz?=
 =?utf-8?B?Zk96QmFQZnJVem9Za3oyNWZjVDdzS0tndTU1L2EvN0I3QXZDN0hiZENVa1NR?=
 =?utf-8?B?OENjUFJLekI3eWlqYlh4aURuN25ENXJUZGdlbi8zejh1OEs5WStTNGE3azF1?=
 =?utf-8?B?MEozUUVMU2g4dWFORktKaGdJREtSUFJPanZOdXJ1bFFycEVBVzYxNTFXOEV5?=
 =?utf-8?B?MEdjTkZldjFyeGdCNWFMWDVvbmYwejBqdmdnZStQZzl0V0xwb0FCMFk1dGhZ?=
 =?utf-8?B?MEpkNW5WV2VIU1MzWXJBMzc4RUpVWWoyM1cyMVZici9yZjdVUTZnTHpvRmo3?=
 =?utf-8?B?ZEg3N0VsTDUvSjBuMk5saVlIUzhTbWJiOFIwZkFYemN5WTJ1MmFWTisySjJi?=
 =?utf-8?B?aFJ3K2p6Y3VBdUVQRWdEK3JibG5HdFRaMDNUNG1hMkRwQ0Rob3VRQVBkNSs2?=
 =?utf-8?B?UHI1SGNzYnVsanJmVUNaOU8wb1FOVXl6TXhiKzZmNERmYmNrMjEwL1dHR2Za?=
 =?utf-8?Q?pELriNFV0uI4xjr9u9VvWL/bbJEYNKtko8kx+WYEWU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3B759BF9716F041B5CB60E7CF14C0D9@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 379bccc2-e812-4353-282a-08da00ca68c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2022 06:10:56.6972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: urSvJBfDu35ZJ1yLlXegx+yN17pwVqJsGEVv7AyEJZYdmCh27SFFvTch/pKrdLnUZf3RzG/HPXyU4ktzU8/ehuar1OZRDY53c1mz5rUYDdE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB0363
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTHVpcywNCg0KTGUgMDcvMDMvMjAyMiDDoCAyMjowNSwgTHVpcyBDaGFtYmVybGFpbiBhIMOp
Y3JpdMKgOg0KPiBPbiBNb24sIE1hciAwNywgMjAyMiBhdCAwNTo0NDo1NVBNICswMDAwLCBBYXJv
biBUb21saW4gd3JvdGU6DQo+PiBIaSBMdWlzLA0KPj4NCj4+IEFzIHBlciB5b3VyIHN1Z2dlc3Rp
b24gWzFdLCB0aGlzIGlzIGFuIGF0dGVtcHQgdG8gcmVmYWN0b3IgYW5kIHNwbGl0DQo+PiBvcHRp
b25hbCBjb2RlIG91dCBvZiBjb3JlIG1vZHVsZSBzdXBwb3J0IGNvZGUgaW50byBzZXBhcmF0ZSBj
b21wb25lbnRzLg0KPj4gVGhpcyB2ZXJzaW9uIGlzIGJhc2VkIG9uIExpbnVzJyBjb21taXQgNzk5
M2U2NWZkZDBmICgiTWVyZ2UgdGFnDQo+PiAnbXRkL2ZpeGVzLWZvci01LjE3LXJjNScgb2YNCj4+
IGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9tdGQvbGludXgi
KS4NCj4gDQo+IFRoYW5rcyEgUHVzaGVkIG91dCB0byBtb2R1bGVzLXRlc3RpbmcgdG8gc2VlIHdo
YXQgMC1kYXkgY2FuIGZpbmQuDQo+IEZ1cnRoZXIgcmV2aWV3IGZyb20gb3RoZXJzIGlzIHdlbGNv
bWVkIGluIHRoZSBtZWFudGltZS4gSWYgbm8gaXNzdWVzDQo+IGFyZSBmb3VuZCwgd2UgYWxzbyBn
ZXQga21vZCB0ZXN0aW5nIGRvbmUsIGFuZCBtb3JlIHJldmlld3MsIEkgY2FuDQo+IHB1c2ggdGhl
biBsYXRlciB0byBtb2R1bGVzLW5leHQgZm9yIGZ1cnRoZXIgdGVzdGluZyBvbiBsaW51eC1uZXh0
Lg0KPiANCg0KQXMgZmFyIGFzIEkgdW5kZXJzdG9vZCBrbW9kIHRlc3RpbmcgZG9lc24ndCB0ZXN0
IHRoZSBrZXJuZWwgYXQgYWxsIHNvIGl0IA0Kd29uJ3QgdGVzdCBhbnkgb2Ygb3VyIGNoYW5nZXMu
DQoNCkluIGhpcyBtYWlsIGxhc3Qgd2VlaywgTHVjYXMgc2FpZDogImttb2QncyB0ZXN0c3VpdGUg
ZG9uJ3QgdGVzdCBhbnl0aGluZyANCm9uIHRoZSBrZXJuZWwgc2lkZS4uLiB0aGUga2VybmVsIHBh
cnQgaXMgbW9ja2VkIGJ5IHRoZSB0ZXN0c3VpdGUgaXRzZWxmLiINCg0KQ2hyaXN0b3BoZQ==
