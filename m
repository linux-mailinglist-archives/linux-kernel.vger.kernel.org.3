Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8924D03E6
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 17:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244073AbiCGQUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 11:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235239AbiCGQUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 11:20:32 -0500
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C984B1DC;
        Mon,  7 Mar 2022 08:19:38 -0800 (PST)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 227BIOmU019618;
        Mon, 7 Mar 2022 11:19:18 -0500
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3em2k9th3s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Mar 2022 11:19:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F04XfPClWGa/OMNWcTHHz0AQitfMSlr7403cZykEzaIXH8VEvjnBvmR2Sqemj7SXrRDm4XCgXK4jkxjUjb+juEW1mWRJqvJFvz8FYcqRNG7vWz9lAzvKnM9ML97pQN+u6w9eouHAmoBPEVxNbHw0mzB8s5uLZFnTEBmxv64R7sj/2t6pSdS1mswVmR1F6CKSvTu21gn0CX7mTgyAu7iIUA5yHE3AVd+jYhSpHBvqutNqbwLh0OfjfKRztVNLhH1Wbvo7YwHvdZHg5YUEe1fjolB53o2CZKg2w1h+9+mjWvTO6lCIUoCTZjKIkJoW43Vrl7txOrTydzNd171olPIITw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lcx2PgndOxUK0bDYz6mU1rAmpEzlxhTRUIchQDpDL+k=;
 b=E1N2CxDJAucsbq1oNL1OOYywmmE8mBd4oNK3KKfB3DeXlmxx1JEOrC//1TjAEPUXM7WaIbZfI+AAT1fqxGHNRYIgLSYBQugmrRH/tvueJ5peOINL0VvTqN9IhLB+woc8sBM13QLvhA5QvkWi73AEFUKZRDWVolX9/dX+iaqxyK7YVho8MjqlEtFlCpRxTXabNqnpvlitmXrmLMurJbgt2XNFGQUmP14WaHjk042Jb0PiOZxukDRHbZdP+9dx1ugGGmD/3YYpONbeGdVb9RuEQlVx/BGGb0o30U9Kpmj33/t3yCDBi6HXDN5IYQL0Hn3xmQT1Q52Dscjd/W96puq0Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lcx2PgndOxUK0bDYz6mU1rAmpEzlxhTRUIchQDpDL+k=;
 b=PQsIGwdVJwSN9k+I9lyW1zSoGkZsvGNrRQiOs7T1l68gynpLVXD6KRwZbNDWUWfax1RCGeiglb4n4we0EdaxCAsldaiXf5Lj2bZc161VgJrS7NE+Rlgd9zs7w6OvCTw1Ve+TykkwGNtd/ZwK7mD7oqMvw6XRk53TOux/wLBUM8w=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by BN6PR03MB2483.namprd03.prod.outlook.com (2603:10b6:404:14::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 16:19:15 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::dce:606f:6d26:c794]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::dce:606f:6d26:c794%5]) with mapi id 15.20.5038.027; Mon, 7 Mar 2022
 16:19:14 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: RE: [PATCH v4 3/3] iio: temperature: ltc2983: Make use of device
 properties
Thread-Topic: [PATCH v4 3/3] iio: temperature: ltc2983: Make use of device
 properties
Thread-Index: AQHYL/IQdHGXQF5840edvo8syPGtK6y0HZMQ
Date:   Mon, 7 Mar 2022 16:19:14 +0000
Message-ID: <PH0PR03MB678644F19C62CA372686F01C99089@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220304180257.80298-1-andriy.shevchenko@linux.intel.com>
 <20220304180257.80298-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220304180257.80298-3-andriy.shevchenko@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?utf-8?B?UEcxbGRHRStQR0YwSUc1dFBTSmliMlI1TG5SNGRDSWdjRDBpWXpwY2RYTmxj?=
 =?utf-8?B?bk5jYm5OaFhHRndjR1JoZEdGY2NtOWhiV2x1WjF3d09XUTRORGxpTmkwek1t?=
 =?utf-8?B?UXpMVFJoTkRBdE9EVmxaUzAyWWpnMFltRXlPV1V6TldKY2JYTm5jMXh0YzJj?=
 =?utf-8?B?dE5UTXdZekJsWkRNdE9XVXpNaTB4TVdWakxUaGlZemd0Wm1NM056YzBNakZt?=
 =?utf-8?B?WTJGaVhHRnRaUzEwWlhOMFhEVXpNR013WldRMUxUbGxNekl0TVRGbFl5MDRZ?=
 =?utf-8?B?bU00TFdaak56YzNOREl4Wm1OaFltSnZaSGt1ZEhoMElpQnplajBpTVRNNE9D?=
 =?utf-8?B?SWdkRDBpTVRNeU9URXhORE0xTlRNd05qVXhPRGs1SWlCb1BTSkZhM2RFUVRs?=
 =?utf-8?B?bE9IcFZZbnBKYjI5dlRHOXlhbGx6ZUVvMFZWRTlJaUJwWkQwaUlpQmliRDBp?=
 =?utf-8?B?TUNJZ1ltODlJakVpSUdOcFBTSmpRVUZCUVVWU1NGVXhVbE5TVlVaT1EyZFZR?=
 =?utf-8?B?VUZGYjBOQlFVUTNVMGRSVmxCNlRGbEJVa0phZW5jMk5WbDNMM2xGUm01UVJI?=
 =?utf-8?B?SnNha1F2U1VSQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCU0VG?=
 =?utf-8?B?QlFVRkVZVUZSUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJSVUZC?=
 =?utf-8?B?VVVGQ1FVRkJRVlpKUlhadlVVRkJRVUZCUVVGQlFVRkJRVUZCUVVvMFFVRkJR?=
 =?utf-8?B?bWhCUjFGQllWRkNaa0ZJVFVGYVVVSnFRVWhWUVdOblFteEJSamhCWTBGQ2VV?=
 =?utf-8?B?RkhPRUZoWjBKc1FVZE5RV1JCUW5wQlJqaEJXbWRDYUVGSGQwRmpkMEpzUVVZ?=
 =?utf-8?B?NFFWcG5RblpCU0UxQllWRkNNRUZIYTBGa1owSnNRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkZRVUZCUVVGQlFVRkJRV2RCUVVG?=
 =?utf-8?B?QlFVRnVaMEZCUVVkRlFWcEJRbkJCUmpoQlkzZENiRUZIVFVGa1VVSjVRVWRW?=
 =?utf-8?B?UVZoM1FuZEJTRWxCWW5kQ2NVRkhWVUZaZDBJd1FVaE5RVmgzUWpCQlIydEJX?=
 =?utf-8?B?bEZDZVVGRVJVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCVVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVOQlFVRkJRVUZEWlVGQlFVRlpVVUpyUVVkclFWaDNRbnBCUjFWQldY?=
 =?utf-8?B?ZENNVUZJU1VGYVVVSm1RVWhCUVdOblFuWkJSMjlCV2xGQ2FrRklVVUZqZDBK?=
 =?utf-8?B?bVFVaFJRV0ZSUW14QlNFbEJUV2RCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZC?=
 =?utf-8?B?UVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJR?=
 =?utf-8?B?VUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFV?=
 =?utf-8?B?RkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVGQlFVRkJRVUZCUVVG?=
 =?utf-8?B?QlFrRkJRVUZCUVVGQlFVRkpRVUZCUVVGQlFUMDlJaTgrUEM5dFpYUmhQZz09?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3cfb1ad3-8c58-4dea-d269-08da005638fa
x-ms-traffictypediagnostic: BN6PR03MB2483:EE_
x-microsoft-antispam-prvs: <BN6PR03MB24837DB61DE6C1B2A45E220C99089@BN6PR03MB2483.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gtOl43XSA4DOQr6OZ3lC/8bu7o73krTfeM4DksyaokjJbKh0xQX2xrCMd3cED28zClBVnV9Vg+GxRdnbva1NIzfeamePCRp16JoP1zwdUVV70LWqmd0xYBbpRG+IMiPjyFsCqCTSqF21tbYxq4tlTjPfoMkoUlwjvw0spNhk5oDe5rMVupabWMPW45BYtFa84EC4IK/1NsKR7hrgHEHBQpJYrDH/astebVDy3WteZGUQdMyEpNd0k3VHLpTdYePMqyoe0KKTK8uXg+DKhvpSOUBGQpdR/RhY65GeqPYw/Sdjg5rHd+wRyqvOmaF879QIiKEcbWp4KrQW835LG1Zxnnd1IcVd+ag4adv2FL0lYT6alSAcAJzUBNMJM8bo6T4O3lN8iUdfueFB0G6ABOhiTXGzzoaY3lOUZo9RYajF80f+lsa38o0aDth/Ho97myyqqJSQvbF9LYulTYvpZ7XVdaV4sr+ddGxUfcNbac7PvJfgWDzPNboTh7Dyv4WCF5FohnT+TTyXufwfBkvHN5/PxuecR0Po2jvKVXQKpagz6KCu/qY5v85sHOeXQjntRw9ACwwzz5OPelAzatbNHltzYjqeIelAFuKeLUN+yuLPNJZuj2kZNYaAd9saYa9hKMXfJHc/tOd/LWENZXu3l7K5POsNKijV20/hp08VVCz2YMikI8TCKU0ot7cj80ocKJkrHoebZRRg+v/Zie7wKrze6A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(55016003)(33656002)(8936002)(71200400001)(54906003)(110136005)(26005)(508600001)(122000001)(5660300002)(52536014)(8676002)(64756008)(66476007)(4326008)(2906002)(186003)(86362001)(66946007)(66556008)(76116006)(66446008)(38070700005)(316002)(53546011)(7696005)(6506007)(9686003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NkRKYUg1ZzFFYWU1Q1JxVWFVcDMvV0QzSjdoRkZrOVMvQno1MklVbkhBMDlT?=
 =?utf-8?B?WVh5TWFpYWhLVEl5RWdqUjhpQkpiQWU2VUkvMjJ3QlVDc0x6RlM2U09tZU9V?=
 =?utf-8?B?UE0vdjRnM21PaHFWVjVWMmp6Z3BwTzRIZk80RjFCdG5tRjZaUk43S21zN0RK?=
 =?utf-8?B?cTRNd1p2WlBBUHpSK1I4cmVWOW8xb2V0QjRmNWZaSm81RElJU3lVbUlsZ2RO?=
 =?utf-8?B?NXR6QnZOVlBRSmN5TXBKVUZyQ2c0UzRjQWdlM2tFQlRBVjZaUGhkWVBtR2Nn?=
 =?utf-8?B?UzlJUGkvL1BDK3JHb21pbkdKMHptMENpUWdjY3JQWkNzbFkwTDU1aldsUWNm?=
 =?utf-8?B?RWhmSlZFVXZER2x3SnRTWUwvU2xpK200NXlUb2VNdGhrdnUzNXFFZnh1c09G?=
 =?utf-8?B?N3dVdHpuV0VVcTNBR25lUGFOYUdDeHN5UEk3SUJZdk5mVEJVNVcxc2RXNFdW?=
 =?utf-8?B?S0pEYU1BaGRPUW1TaFFsaG1IZ3dyN29VNmhkNktJTS8rc2hNZzJ0NUxEVDhT?=
 =?utf-8?B?UENiMXNGcHN2aFpYZy9kWk82OVZJN3dxbk5FaENURmNHTFNJTHo0M1hUeFpU?=
 =?utf-8?B?bU9PRHoyYnlMT1BzOENLc09iczI1d3hoMVBjYWVCWkh2R01NQkFZY1NFKysr?=
 =?utf-8?B?NFkyRldvNXFuNllGVGZnTFlEN2tyZm1CSHN0VHpVV1JYWlhBTVFmV1lMbHRv?=
 =?utf-8?B?OHE1bzh6cFhrRnh3a1RvOWhLQ2Z3VUVqVmYzb1NxQkhTZkdLdEtadU8rUkJs?=
 =?utf-8?B?WGhyZ2lUT3RzVmo3a21XZmpuTHlUOVp3ZG5xMzNQK1hzb0RVN3RCSkFXQ3JH?=
 =?utf-8?B?RTV0YlJqb1dXMHN6dEtTZ1F2Mk5rMGpYSDFXOHkrdlBVT256R0RNZ0NLT1BJ?=
 =?utf-8?B?cGRVNUFDR1IwSDVBc3hZZW1lZm1MZUlFM3AvT0RhR0xiZXFNNkliZ3UzY1Nz?=
 =?utf-8?B?YXJjLzN0d1FKa25qdXNCd2xQRUh1VTZwZlM0YWVzVmVIU2NEVTlnOGNzQVJ2?=
 =?utf-8?B?UU1aYlhVczJuaTlVendrT1YrYUUyYzVMRkZzeXh5Z2IrMjlwNk14NjlYQlc4?=
 =?utf-8?B?MHhVYSt0WFJaWmp1d280VDlXdnh1Mm9sN0pKRHY1OWo5TkprSUNTMEt1emNn?=
 =?utf-8?B?bzBpbFZQTm5UN2REMlhySmdBWlljK09xTUFhYlJiMEdWQzJLbzRJN2IvRVc4?=
 =?utf-8?B?dnBwbVZROW5LODg5UUE4MTVzNi9tclp0OVBsVUZ4OVExQmtZME1FaTlTUEJn?=
 =?utf-8?B?ckcxK1VYTTZjbGVFSDJYemZ2NU8vZG1iS2pVRGg3c3BUSWFBVTduRHB5VG9J?=
 =?utf-8?B?ZnBvZ3F3UjVhWXRnL09SdWlVVm1uUkN0T2laamdGbTMzV0t4V3hFTEd6YXZB?=
 =?utf-8?B?b042a3FIM2ZudDROemR4STg4cVFJb0RxL2tscS9pMTQxVkZsU3N3MlRmcW9v?=
 =?utf-8?B?RXk1UngwcW5INFpCNEViQTNta2xzS1hJS2FuNytZbGRDeVFHM3lyK20zY3pC?=
 =?utf-8?B?cEdoTnhqWUpwYXpQWjNUQ2NmQjRlWjZBUTdMRC95R0doS1M5T2pXTmdIY20y?=
 =?utf-8?B?bzNxS3FYZVg4bGFqMkRsS2ZKQ0E0RFQzMVVyRWZYNGpiQ3dBMmJvblBUYTBE?=
 =?utf-8?B?eFh0OFBLRnRObUh2R2wwb3dvTTM5bkRjRFpkSEtYN25CNjlrSkpOdDJkNXVz?=
 =?utf-8?B?V3RlRUlFY2JmMjZ3SEdraVlFaWJBcVY3by9sM0pzeTh5Sk45MWlnN3RqMjlW?=
 =?utf-8?B?NjJFdDVBMFljMkc1dmxUNVZWUFB6ME5RcXJ0amdEemswa1ZMaEpvSFVWYlJC?=
 =?utf-8?B?SFJ6NVJ2WUNGaFExaXdEU1djdktsL2RPRTVKSHJTaFRIZlpHYlMrcUhFRTJJ?=
 =?utf-8?B?R3QyMUFHYWVUZHFIOWhwNXZvNCtHa1ExTDRGTERQd1liaTl5TFc0YjhBTndC?=
 =?utf-8?B?WmNzeXlKVXBBdWhTcGRMWWt5alBLc3ZZM1h6Z2k5elUwMTE3bnRrTEh2ckxl?=
 =?utf-8?B?ejdTUlppZFQva2ZaUUcwNWVJSk9PcjVRT0JydFBwUFkvSkZWbWFxSTJObnNQ?=
 =?utf-8?B?ZWI2L1VLdDJIVnpobWVpTnlUQ3E0YjlwTDVFRnRhZDgzQ2ZzYnVhbndjYWxL?=
 =?utf-8?B?bHFlTzg5Z3JZOHhGek1TMmZKUXpBSTJxckROMU14SW5GdmpiclR2RG56ZXc5?=
 =?utf-8?B?eHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cfb1ad3-8c58-4dea-d269-08da005638fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2022 16:19:14.7933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BpQiGx4uy60DmjN91yvT8DhOUtftnJ9d60ElNmuZmEAzmQGBVbn8xtbNyR+t6OYnrT2aIYum1pWYmfDHxLwxfw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR03MB2483
X-Proofpoint-GUID: hQJXoxRJrzheCmkHTjw7DvntZ_e6i9sJ
X-Proofpoint-ORIG-GUID: hQJXoxRJrzheCmkHTjw7DvntZ_e6i9sJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-07_05,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 mlxlogscore=831 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2202240000 definitions=main-2203070095
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gRnJvbTogQW5keSBTaGV2Y2hlbmtvIDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRl
bC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgTWFyY2ggNCwgMjAyMiA3OjAzIFBNDQo+IFRvOiBBbmR5
IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT47IGxpbnV4LQ0K
PiBpaW9Admdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IENj
OiBTYSwgTnVubyA8TnVuby5TYUBhbmFsb2cuY29tPjsgSm9uYXRoYW4gQ2FtZXJvbg0KPiA8amlj
MjNAa2VybmVsLm9yZz47IExhcnMtUGV0ZXIgQ2xhdXNlbiA8bGFyc0BtZXRhZm9vLmRlPg0KPiBT
dWJqZWN0OiBbUEFUQ0ggdjQgMy8zXSBpaW86IHRlbXBlcmF0dXJlOiBsdGMyOTgzOiBNYWtlIHVz
ZSBvZiBkZXZpY2UNCj4gcHJvcGVydGllcw0KPiANCj4gW0V4dGVybmFsXQ0KPiANCj4gQ29udmVy
dCB0aGUgbW9kdWxlIHRvIGJlIHByb3BlcnR5IHByb3ZpZGVyIGFnbm9zdGljIGFuZCBhbGxvdw0K
PiBpdCB0byBiZSB1c2VkIG9uIG5vbi1PRiBwbGF0Zm9ybXMuDQo+IA0KPiBUaGUgY29udmVyc2lv
biBzbGlnaHRseSBjaGFuZ2VzIHRoZSBsb2dpYyBiZWhpbmQgcHJvcGVydHkgcmVhZGluZyBmb3IN
Cj4gdGhlIGNvbmZpZ3VyYXRpb24gdmFsdWVzLiBPcmlnaW5hbCBjb2RlIGFsbG9jYXRlcyBqdXN0
IGFzIG11Y2ggbWVtb3J5DQo+IGFzIG5lZWRlZC4gVGhlbiBmb3IgZWFjaCBzZXBhcmF0ZSAzMi0g
b3IgNjQtYml0IHZhbHVlIGl0IHJlYWRzIGl0IGZyb20NCj4gdGhlIHByb3BlcnR5IGFuZCBjb252
ZXJ0cyB0byBhIHJhdyBvbmUgd2hpY2ggd2lsbCBiZSBmZWQgdG8gdGhlIHNlbnNvci4NCj4gSW4g
dGhlIG5ldyBjb2RlIHdlIGFsbG9jYXRlIHRoZSBhbW91bnQgb2YgbWVtb3J5IG5lZWRlZCB0bw0K
PiByZXRyaWV2ZSBhbGwNCj4gdmFsdWVzIGF0IG9uY2UgZnJvbSB0aGUgcHJvcGVydHkgYW5kIHRo
ZW4gY29udmVydCB0aGVtIGFzIHJlcXVpcmVkLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQW5keSBT
aGV2Y2hlbmtvDQo+IDxhbmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQo+IFRlc3Rl
ZC1ieTogTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT4NCj4gLS0tDQoNCkV2ZW4gdGhvdWdo
IEkgaGFkIGEgc21hbGwgbm90ZSBvbiB0aGlzIHBhcnRpY3VsYXIgcGF0Y2gsIGNvbnNpZGVyOg0K
DQpSZXZpZXdlZC1ieTogTnVubyBTw6EgPG51bm8uc2FAYW5hbG9nLmNvbT4NCg0KZm9yIHRoZSB3
aG9sZSBzZXJpZXMuLi4NCg0KLSBOdW5vIFPDoQ0KDQo=
