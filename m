Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E4E58B085
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 21:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240725AbiHETvj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 15:51:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbiHETvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 15:51:37 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885B210FFB
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 12:51:36 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 275HHDLQ016783
        for <linux-kernel@vger.kernel.org>; Fri, 5 Aug 2022 12:51:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=6a7t0gZ7cQHT28kwwsSJhH6mHYruSJckbf9R3HiLKE4=;
 b=V+PJMG0w7xE83uQ3FhlfSlC63SQp3WY+QNNZw1FUr2S1IedMCaHbhGRCTk7buzfancvj
 dXHCZPlUNPX1pW9fwkmUOV2zNkDD4t/+RidE7hqmhBL0Rk5biGSQXqvvYhSRtFNXGhIU
 BHU5r6T1TEUjYxfVGn9PoBnWWJmJSDGi3oQ= 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by m0001303.ppops.net (PPS) with ESMTPS id 3hs14gbdcb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 12:51:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dNvEsrWufy/wh581GWY6O3zJaSmBEcec6V3OBy9T0AmKRfBKnZdvWjxY/2dp/lpImrAzEL17IlOa/zD1yqERSKji4/2yi7BtRLsPEY3BXk7dFzwqm9EHUBmKiDaoNbcG8zQ3ZU5jjUSbv6v1avWYQjQLUlMAbSlwZoamLjc4yvhXuTjSfqe8n2lWo9/MSqeq0TKs88uU7DepJGnQGyxtZDJTRz79JorB93zfKfKh8sUNbQLJ02lX1TAPpz40mvcjNyzoz3I1G8IA/8mpH8gSwiTAk2fvF4IbG8a+hBCaOVKPU0FSPHC36esj+Kz+qNt2QsT3bmAOfPYU/gpF4l29rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6a7t0gZ7cQHT28kwwsSJhH6mHYruSJckbf9R3HiLKE4=;
 b=PQ863PK2daCRAuXLJIWEkBtpqDzWzwly4BpYsMKp7kpruy5WfZov90aCSGNTQtu5mjlwRSxVHj0+GtPzytnRWiMJcitGe9H5ISfllcUJf9sh0rI+uplZutuz41HzEHavHe2zAcVkBqFoiJyqw8w4v5T98JB2Zhpe/Z53R6I3Urn/DJeLJxm73Uq2PGOXYpbLeYUZ7c7YsOKoyV0Khawz0vqqr6s3fCCMZd8w6H6cEBF7czScVyDoeVObFe7qpOmwUdXtCa5tUTI6CSWbMqbpnVi7ZVTdjFouif9wlvOGXq2gYQV/I/wDx9qV3DFsOLpLPoyWJuHheeXNLt5wmXFkQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from CY4PR15MB1781.namprd15.prod.outlook.com (2603:10b6:910:1f::13)
 by BYAPR15MB2517.namprd15.prod.outlook.com (2603:10b6:a03:151::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Fri, 5 Aug
 2022 19:51:33 +0000
Received: from CY4PR15MB1781.namprd15.prod.outlook.com
 ([fe80::351d:e6bc:a9e4:4118]) by CY4PR15MB1781.namprd15.prod.outlook.com
 ([fe80::351d:e6bc:a9e4:4118%12]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 19:51:32 +0000
From:   "Alex Zhu (Kernel)" <alexlzhu@fb.com>
To:     Matthew Wilcox <willy@infradead.org>
CC:     Rik van Riel <riel@fb.com>, Kernel Team <Kernel-team@fb.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] mm: add thp_utilization metrics to
 /proc/thp_utilization
Thread-Topic: [PATCH v3] mm: add thp_utilization metrics to
 /proc/thp_utilization
Thread-Index: AQHYqPrSmG3WqzybNUurgyMbb9mveq2gpnsAgAAD8ACAAAWRgIAAB5EA
Date:   Fri, 5 Aug 2022 19:51:32 +0000
Message-ID: <CA8C72B6-E509-4FB0-BEAA-C4368EB7A419@fb.com>
References: <20220805184016.2926168-1-alexlzhu@fb.com>
 <Yu1mcD6Jp4fCVEMi@casper.infradead.org>
 <0b16dbac6444bfcdfbeb4df4280354839bfe1a8f.camel@fb.com>
 <Yu1uabedm+NYnnAj@casper.infradead.org>
In-Reply-To: <Yu1uabedm+NYnnAj@casper.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 29fc5e25-584e-4950-4618-08da771be5b5
x-ms-traffictypediagnostic: BYAPR15MB2517:EE_
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xoiIlmVANzVsuQOXtPYfxHtTvwugUolAYeMsFdk8YTquSewxHwS74VqlHJsSWZCbICXzOsz28o6T/hmc9EmW/OrqSz6DaEyWs/t0oh/kO2MLl5+0lCdyyDmKflw1Hz5fl45zyq5qtvfx5WZAiZJ8Oh0n4PTPKTW4MMCn73wifjq2xwKHg3qSpEUXEfxj3T4bhPwEcmoyIzVBZn1HllWDUn9Ls3wgoqmA6WEzlQ+KjaCBCUu7A+gf/o0apaJuRgKYEt7iF9SuTL7La/lBopkM9vK+YltX69hNwWokpDCLanm39ozOEzCU8ufuRpHZBldcGRSsWeD/jmngQ7x89b9E8+VuepO4Yfp6iBPCxtL5ydQQ5/tTTFXpd61y3LssQc8iOVGXACZR4tJfkmiheUZ5I+fy2e1XxO9ExHOeqzVwBR6H7xT3X82pg3ffrGTFEX5RPbosJgVQDoY3xb40h6DgnJSxANROTVNP1X24Pe/KqKBxShct3BHDNKnv6ETcc8529gNSrQdbQg4edd4I7rh7rBdeq6jhNB4WES7RPGrqS8lqDv9kEHJFtxo5Jn4FRu6ncL+LyS55f/x3H5/ociMt5Q8nHOPhNHYMZcVw625uKG4y3N2KmuyD5MalpXoei2cyTXzZc3sTWo0VCKQRMZWecG7O5glCGhg+++F6ROuQkC+RWvYsgnJYcQ/DTU/4ms9HF2q4Fg/crb6xUrF+P+1iK8cQt2jbNDWt2673vI+oF9iGorphnx90//0WAxyX8qRkn2VbDO/nhEcIwAs8qAhZyi3w9GDuHS+8x+9duk8P6LkR1AZaY9Max/ilaS7RIhRAl/0WarwvMyRYAm4QOVDVvw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR15MB1781.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(136003)(39860400002)(396003)(54906003)(2616005)(36756003)(186003)(38100700002)(6506007)(8936002)(41300700001)(71200400001)(122000001)(478600001)(83380400001)(2906002)(6486002)(6512007)(86362001)(5660300002)(91956017)(316002)(64756008)(6916009)(66476007)(33656002)(38070700005)(66946007)(66556008)(76116006)(4326008)(66446008)(8676002)(4744005)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjFkc3ZMR3h3ZnJ1ZlVOU2FqakVsbEt6YUkzcnN0RWcwODgvZEJNNEltNWVt?=
 =?utf-8?B?UmZaSTZNWk56Y2Jocm1WNkwwRE1HV1N1RVlZVzlwRmRoc1FHdHMyZ1ZWQXhR?=
 =?utf-8?B?cnFXTTlyMmhrRmJpZmlaM1ZsTjNxLzZBYnNxamdDK2VMWUxTNHVVZGxrQ0Jm?=
 =?utf-8?B?V1k0Zmk0TFNpYjF5UVJsd2dvNHdEWWR2T0I1TWsxV0hsbFFJTXJPQWc5NUsw?=
 =?utf-8?B?WkZzKzZTZW4wem1iY3o0Qi9GSWJMcnk2ZEpCNjZiOEJhQzlqM0d2MDJ2QlVv?=
 =?utf-8?B?d1JKTkJMeTUxU0p4T09Sb0d1UHg0c2gyYWpqRGR5VG1YVkI4MzBSdXJ1YzZI?=
 =?utf-8?B?aml6dVhDNlRBa1FSQlhybHB6SHNuSk1meitXMXZHY1hnL1ZuVWZuN0J3TlUv?=
 =?utf-8?B?bXBOS2tNd1dScUlDenFQTkM3KzZEME5DTUFNeFkzSlZ2UGVVVmt0S3NwTldH?=
 =?utf-8?B?Umk1ZjVLOFMzOUtnRElMamFuMGVramRZSzlHS3A4SEFEam0rRWZtbGJ6QUhR?=
 =?utf-8?B?bTFTSlVqK0NnSlFUZzl2RnRMQWxsVGk1UUxWY1QzWWZFVEdMazl4Ni9IclRj?=
 =?utf-8?B?Q0p3dW9JZXd0eUNLL2dPVWhocEVvY0hjMzV2ODFlZkNxMFh1T0RCR3pmT3ps?=
 =?utf-8?B?OHc0bmJ4VEc4R2xWaHpOQVgzTzJpNWd2b1VLQ1ZNUlM1dXNveWczUWRkcXE1?=
 =?utf-8?B?dG5oSEo1UFRYMzFBVWxXcmJjeEx5MFh0VDQ1OU1MMXNsQlBpNkNZOUlHMmYr?=
 =?utf-8?B?YmhjUVdxOU9mOW92dzhkQ3FQT3pOcXVBdjlCTUdoR0tlM241TytkWmNNLzIz?=
 =?utf-8?B?ZUZXQzc0RkVOaVNNM3M3U0VBUmNSMFBNRExjK0NVUFkxeUQwbkZtei8zTVJO?=
 =?utf-8?B?Mk04REVEMncrR3lpM0JuUGVqSWRrTFYzY0QyOGxZQVdaN2Z2WUpwV3U5bHVX?=
 =?utf-8?B?SWM2aDg0YVZoWFdvMmFhL0FpTGtZeVlrVmYwN3VPc1MwY0ZBMU90bTVucnNk?=
 =?utf-8?B?b2J6WlRZV2JRTHl3bU9HT1VTUGE2Z3o5K3RJMWFPcmR3UGZXRDZBMzYwR08w?=
 =?utf-8?B?OE9kWktkZnFFcTlPcXpSZTZYT0ZhakNKMW56R1hYenhpOUlGZ0MyanNZems0?=
 =?utf-8?B?a3V2aWJ6TUxyK1hpTHFUdXlTbnB6K2ZoNGxJM3kyYnFERFc5a3VhM1pyT1By?=
 =?utf-8?B?ZWtFZlhHVVcrUlp3QitTL0V6d1VvdEdJdWlUdWN4dFE0eFcvUFh1LzVIVXFr?=
 =?utf-8?B?N2k4SUt3TDR2d3laajduR3E2SGJQbmhtK295VXB5d3RwZEF6eWs4SVdsdGZN?=
 =?utf-8?B?bWFleXMwVXJuMFBOMW5obGNoZWV5d3ozYXZUZEhHa1poZ1hzKzl5UzljUVRn?=
 =?utf-8?B?YndSbHp2a1JvMk91YUpiNG9sdzFwd3dMQjFaOVc3SEIwY1pnYUkxcC9qKzlM?=
 =?utf-8?B?ZTdtZUFJNEpONzhDVllTK2VlWHVOazIrWllvbVlPajRObytEMlI1LzY5OThV?=
 =?utf-8?B?MGRMSGY4N1o3ZXVFSVIyS2pPWlowSGh5SzJXcjdYU1lidHFBTkVybVFMWDEy?=
 =?utf-8?B?SnphMkYxUExrWEg1NEtFZWdHY1pmZGd0MDVkeEFvdHBDcWRIbU02Y0Y0YXJz?=
 =?utf-8?B?dkNiSkxxM1Z5S2RwZTloYTNvdk9qRzN4U0tHNnhEdzlnZ2VQYlMzWFRvMURp?=
 =?utf-8?B?Vk40WVZYYXloTjRnN09FNXpzVUU0c2wraWFiYVNCTEsydDdvS2RlY09HL29C?=
 =?utf-8?B?UDE2bVhjTVVKeFlIYXZjU2IrOXVVcHB3dmRoRWN3azB1K0FLdmxRbWRkOUg1?=
 =?utf-8?B?VG8zb3Y1MFVqeDZEUG1ySVQxaWVJMUVmZjBBblNVTGhobHpoVWhBNVdVaG41?=
 =?utf-8?B?ajkzUzVhKytIOG84OHJFWUd6U1JSL3ZpcDBzVUJuOTVjRnlQRTJWOUwrMjln?=
 =?utf-8?B?UUxrT1pFOHMrci9IYjZsYUc5T2xUSG4rZit2T2Q4UjFQbTVNVlZWWElMZHJ5?=
 =?utf-8?B?U3dFWmRUZjhRVm1BajJRREl3dHoyeUxkcWdaN3Y4ZEN3cDh3NVNyTXhZd0lm?=
 =?utf-8?B?cVpEbi9TQVlKL3UzY0VEOVN6NXp0WWc3RU0rcEZTTXQzNURYVVVKejZ2VHV2?=
 =?utf-8?B?V09KV1FYVmFiaTQwdTBHNzB4SjdPWnJoVUxkRXZNb29SQnQxSmJ2V1Rpb05m?=
 =?utf-8?Q?GSgXQNLxR6gdrnBTWR9p4CU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3ADF2D28E2A7934E889AF66C43028FF9@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR15MB1781.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 29fc5e25-584e-4950-4618-08da771be5b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2022 19:51:32.7406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1eHm4xj32gOxNgl4/4B5DC7PAyqrf7kXhl+sBCObVhPmqhjFncz/psn1Sl/eT/ID
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2517
X-Proofpoint-ORIG-GUID: 8PEwv7oKOESafVlDzS2QWlrTl06ZHuwl
X-Proofpoint-GUID: 8PEwv7oKOESafVlDzS2QWlrTl06ZHuwl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-05_10,2022-08-05_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IA0KPiBBaCEgIFNvIHdoZW4gdGhhdCBleGlzdHMsIHRoaXMgaW50ZXJmYWNlIHRlbGxzIHVz
ICJob3cgd2VsbCIgd2UncmUgZG9pbmcuDQo+IA0KDQpZZXMsIGV4YWN0bHkuIA0KPiANCj4gWWVh
aCwgZGVidWdmcyBzZWVtcyBsaWtlIGEgYmV0dGVyIHBsYWNlLiAgQW5kIEknZCBsb3ZlIHRvIHNl
ZSB0aGUgc2hyaW5rZXINCj4gY29kZS4gIEJlZm9yZSB5b3UgbWVudGlvbmVkIHRoYXQgSSB3YXMg
aGF2aW5nIGFsbCBraW5kcyBvZiBwZWN1bGlhcg0KPiBmZWVsaW5ncyBhYm91dCB0aGlzIGNvZGUu
ICBGb3IgZXhhbXBsZSwgc3VwcG9zZSB5b3UgaGF2ZSBpbmNyZWRpYmx5IGhvdA0KPiAyNTZrQiBv
ZiBkYXRhLCBidXQgdGhlIG90aGVyIDE3OTJrQiBvZiBkYXRhIGFyZSBuZXZlciB0b3VjaGVkIC4u
LiB0aGF0DQo+IGNvdWxkIGNhdXNlIHVzIHRvIGRvIGVudGlyZWx5IHRoZSB3cm9uZyB0aGluZyBh
bmQgYnJlYWsgdXAgdGhpcyBUSFAuDQo+IEhhdmluZyBpdCBhcyBhIHNocmlua2VyIG1ha2VzIHNl
bnNlIGJlY2F1c2UgdGhlIGhvdCAyNTZrQiB3aWxsIGtlZXAgdGhlDQo+IFRIUCBmcm9tIHJlYWNo
aW5nIHRoZSBlbmQgb2YgdGhlIGxpc3QgYW5kIGJlaW5nIHJlY2xhaW1lZC4NCg0KU291bmRzIGdv
b2QsIEnigJlsbCBtb3ZlIHRoaXMgdG8gZGVidWdmcyB0aGVuLiBXaWxsIGZvbGxvdyB1cCB3aXRo
IHRoZSBzaHJpbmtlciBjb2RlDQppbiBhbm90aGVyIHBhdGNoLiBUaGUgc2hyaW5rZXIgcmVsaWVz
IG9uIHRoaXMgc2Nhbm5pbmcgdGhyZWFkIHRvIGZpZ3VyZSBvdXQgd2hpY2gNClRIUHMgdG8gcmVj
bGFpbS4gDQoNCldoYXQgYXJlIHlvdXIgdGhvdWdodHMgcmVnYXJkaW5nIGludGVncmF0aW5nIHRo
aXMgd2l0aCBEQU1PTj8g
