Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BF0509FFA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 14:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385715AbiDUMvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 08:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385644AbiDUMvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 08:51:05 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2087.outbound.protection.outlook.com [40.107.215.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 640C5326E1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 05:48:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITLE32Vk6VtDADuDfveNN/n8OnDxWyG2p46dV1LD/PTkDkBYBamHfQN4YP8kleIb89AGpHJEkIT9nGDeJuaZuqL6+MnHjME9WT6QrOm/qqndfvzg/JTA1kqTmmlyPMQWy8JKyWMJczTU9lxLeqcxhjcwNmDbQDWzrobHSYG9KJJj+3lQv8CR7hCO1ClJ/q4NyPSl902FjIw/7apps6he2kOFgfenb7fMMrUPP/OFTiKnhdbQPGWNGhDV0jZBzVv0Ntqb1t6CGz3QIAKreAXkFUTAuL02PMoj1vSvH8gKF8xXCoRG1GsZJaNgwnIXo3oqldWFIVScd9jsX8WJZsDTqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GMQ93B0GE+OyEVEhaePzJBiEhJCgfW/lJk7bXrjh3kI=;
 b=kB6+3FkTOEeur0OM0/4QgIxOyfE5qRaM4QknzUotR80Qtu6WC1pQ6+rNsGNVBvVVwL7WEd9yba2VH+H2arBwzBHm745GUG4MrRFczISDbnWQGIKtP4S8Hc1vgLXld3JPFI3bSrdhNIkFsAWY07t4sjjO7WBCP3UBKu6fpI5L0jkqmJtb+pAPrPvig1t94I0B9gp0kAcas/rBWP8aqo83IdK8kRJs8MQglwk9f1mKkPfCVvHR9wN463DYAA63ssZ7ql5REMaFg4P8hXm/XRpAHMK/0UMXj1c9fxVrME9y+WrWIgorrsOap8Bv+Jxm3pMP9b2lQXv8FY5ytfjIqjyIjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GMQ93B0GE+OyEVEhaePzJBiEhJCgfW/lJk7bXrjh3kI=;
 b=av3ItYUy7IHyRb/SALpHnyDHWIzrA1IWZfJN4lpzbx7l4ji6/jiUZKO0hdgUfGtWrStAh30qmFFbCojITTI6GrwANTcu5yZjNvD5ZPHmSveRBUH1L9w90CPJLVROMyGC9YZ/Bd1/cw5cv0Gx9LljXzZA1pPeVcc7kDwdKnLYi/k=
Received: from HK0PR02MB3202.apcprd02.prod.outlook.com (2603:1096:203:61::14)
 by PS2PR02MB3541.apcprd02.prod.outlook.com (2603:1096:300:48::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Thu, 21 Apr
 2022 12:48:11 +0000
Received: from HK0PR02MB3202.apcprd02.prod.outlook.com
 ([fe80::6947:c14d:6740:c250]) by HK0PR02MB3202.apcprd02.prod.outlook.com
 ([fe80::6947:c14d:6740:c250%7]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 12:48:11 +0000
From:   =?gb2312?B?zb+6o8H6KEhhaWxvbmcp?= <tuhailong@oppo.com>
To:     SeongJae Park <sj@kernel.org>, Hailong Tu <tuhailong@gmail.com>
CC:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "gregkh@google.com" <gregkh@google.com>,
        "surenb@google.com" <surenb@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?gb2312?B?wO60usX0KHB1bmsgbGkp?= <lichunpeng@oppo.com>,
        =?gb2312?B?x/GzpMa9KEFhcm9uIFFpdSk=?= <aaron.qiu@oppo.com>,
        =?gb2312?B?t7a5+tTzKEdvcmRvbik=?= <fanguoze@oppo.com>,
        =?gb2312?B?zfW1wsv4KERlU3VvKQ==?= <wangdesuo@oppo.com>,
        =?gb2312?B?wO7WvruqKFRlcnJ5KQ==?= <lizhihua@oppo.com>
Subject: =?gb2312?B?tPC4tDogW1BBVENIIFY0XSBtbS9kYW1vbi9yZWNsYWltOiBGaXggdGhlIHRp?=
 =?gb2312?Q?mer_always_stays_active?=
Thread-Topic: [PATCH V4] mm/damon/reclaim: Fix the timer always stays active
Thread-Index: AQHYVWhX/0pP8hv4IU6FQZWGKOH6q6z6T0WAgAAA3qA=
Date:   Thu, 21 Apr 2022 12:48:10 +0000
Message-ID: <HK0PR02MB320269261363F86222CAE2D1DEF49@HK0PR02MB3202.apcprd02.prod.outlook.com>
References: <20220421100523.689294-1-tuhailong@gmail.com>
 <20220421124055.493710-1-sj@kernel.org>
In-Reply-To: <20220421124055.493710-1-sj@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0789cf43-76f8-4e3e-6b5e-08da2395315c
x-ms-traffictypediagnostic: PS2PR02MB3541:EE_
x-microsoft-antispam-prvs: <PS2PR02MB3541CD52572BDC1A9454E64DDEF49@PS2PR02MB3541.apcprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q7b+4cTyAYtpH6RrHFlYol/ng9pLuTkTt/OIckz00HtQjgWB+2HxLfxE6ZIuqE0beSukzc9nztNZOmFhgggXP3Pab4LJFDGXsJCIpRIpWekpDimt5+NOK++5YHd92KfHtooTHwUvrotkeHZfqwhG9WaYenL9k1b8KxLCW2NIFXapSqfVOSgRah1bPXhcqHvD+MNVbcJfHlD2zwW9naaBuZfkx9QF3FT22aJFUSFnifXKzP2YWYl+Vp/ERDimmV2eEjtEv86mmWTzSISbIwW9E2z0RM0EQwMjIrZHSBOYT1r8ywvm0W9rJtwQK25h8iaalRAHf+NzLQp8IqetBIV/Ai9Dt35woaqVoNy6favUKAmTE8/OO+e4y0whLOGzY+ELDQuVx9HAS/3rMXc6WoSNIPjogvBBu8IKzPaztWFpEZqB0ITfRpIhJChiVJNcBIrwkeHLONnu3zBTR2AxPJOmEQaUz7oem45c44E4coYyqAXoRsmcptP3pHbTfa0MFGsDizbWL1Qjdi/uj8Ov6odAo6LhVMQWqDW8fMgzSg9eA5IwVu9hu9Cqqumhc13aB51XiSoBGXTp4DNQwMbeOECuxL2GY6G3AzWz90SotXp9hXeYrmGO0gF6tD7FncOyG+QWzN3syQZEom6t6ZTW4aVf314P8jv5yclQAmYCboi5dFxL1nJWTs4KS2PE4wtobp7s8myUkVGHgeNvHPHg5uSTUIuMU3mQghFKd+TEsmqDYp4BtptwNBmOyf+OLpW7MXYH+cDtNtkSGpTOJlwuds2uYW25CDRPBYZzEHHgqsH2rSQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK0PR02MB3202.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(86362001)(7696005)(26005)(6506007)(38100700002)(38070700005)(107886003)(122000001)(186003)(8936002)(5660300002)(83380400001)(2906002)(66476007)(66446008)(64756008)(316002)(4326008)(52536014)(66946007)(66556008)(76116006)(33656002)(55016003)(71200400001)(85182001)(224303003)(110136005)(966005)(54906003)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?ZkNZNVFWTlJGR0I0K3ZuK2RKb0pHYzc5N3llTnNxVVNHYW5FaW9FTzVCQ2Nh?=
 =?gb2312?B?ckVONHpNaFFrRDJMU1hvcFFCdVF1b0E0aUJybUcrSlBCOVVZcld1WFplNTU4?=
 =?gb2312?B?enBoVnZwSkFhYW5ONmlmRW9YRmRhY1BrNWxoMy9zaWh4UVlNMGtHVFU3R051?=
 =?gb2312?B?NkR2dFc4cEdQV0Rzd3dtdmFMOFNUQlgwSEFxckxldFBCazArMUlzQUQ1WFJE?=
 =?gb2312?B?bjlKakM1a1pwVFNIRWtJYWE5bmJZZ3lmUGw2UDVmQ0J4UDlOMisrMkl3bGc5?=
 =?gb2312?B?bGgySnVoZG1QMzI2RzZHaER3MjRVdFp5MDlLTXVFdDRGejQxL3lwVmFkMWdp?=
 =?gb2312?B?TTVBMVBDWDhNaFdaQ01ZQmdDVXpQYkZDK1BScnRiaEV5ZFVUc0tTYnVMbmEr?=
 =?gb2312?B?RkpUVTdwT1gwc3U5K0JSWnAzVlpKOURVak5ES3ZhdG5hNGpKKzJueEk4alky?=
 =?gb2312?B?OGNObTJjTmZSSEpXdDFGZ2VuS2c4Q2JLc2VDV0I5emFzN1RrNVRPOEYvWGNk?=
 =?gb2312?B?MDRtOGJwNTlQVE5jU0pqLzhid211eVJCMmFKWHhrb1Jqa3JIc1liYTFlMWJx?=
 =?gb2312?B?bzIzNmQvYnh4TjM1ZC9tUUs0RXd3TG1RK24yd0luT0RNSVYyMVA1blZYMkVu?=
 =?gb2312?B?emtCY2NjWlh4cm1TY0ZId2c5RWxlK1N2MituOHk5QkJTUG1qTmZuSzNKdzYy?=
 =?gb2312?B?c1ZyeU02WWdKSit1cS8zOEJMQmFNRnZRdkJ2U3dRZXJFQm4vQmhiUFQ4TXhT?=
 =?gb2312?B?c2pJeUJsOHlNTURlemFzM29EUldCcXZNaVBUVUlLd2VGVzcwZTNOYzFqdm9y?=
 =?gb2312?B?OUttQTB4K3YvQ29kRlU2NjI4L0JDL2hpc21pVVlDT0g4Q0gxSmt4M2FOWWc2?=
 =?gb2312?B?MVE2bUhsQ1N3YkZMNFIwbk1EUlF6ZXdqcndycVFYaE43dlUxVEozWVJyVHpi?=
 =?gb2312?B?dHpYaFBJZ1VodktRRDdscmlJajhMUlJYOW1rbzJHNjhNNzY5Z212THdsOHRi?=
 =?gb2312?B?NisvWE5sTWlTT2VyS3phQU91dWF1dEdSVWlIaTBZSGc5QWFIaFFMaFl1dXZ4?=
 =?gb2312?B?b0F2OC94VmNIbzAxYVd1YzNNN1RFdFM5Kzc3YnlVV1BQYzFRS05GQnp5NkJj?=
 =?gb2312?B?R0tZZGprM2p0MU81cTFmZ1AyRGVwMjdER3pKLzhqR1NLOGpJdStlbXZLUTBH?=
 =?gb2312?B?aGpobGwwNmZjc05EQ1IzcEZZdnlIcld1Vk0yN0FWYXdVdGdhUXZYWkJjbUlI?=
 =?gb2312?B?bmVLRUd5M1dvNlpiVmhOakZlYXhJMDZCNlR3UW5hUm5CMHpmK05zTmdiR21y?=
 =?gb2312?B?Ym1mV1ZkTXZhVzVaaVNkY1p4anNYV2hVdW1QUkp6R3dwejRpaEN3TzB6Y1ZJ?=
 =?gb2312?B?bWFSeDZ0UXMveUk4M3cwcE9FK25PdVcxTmtXQkNGV0xlN24wWEhMR3J0em5m?=
 =?gb2312?B?YnkyNHZEQlYxL2dZaDByTlQyNzJxSFJqR2MxM24wZUlBNGdtRGV0M25DcHl2?=
 =?gb2312?B?cUxiZEN2T1ZMYkJadS9GczJxZmNobUkzbUNGdmcwT3JXMXBEMzB3dnc2Mm1j?=
 =?gb2312?B?SHRKNVNVUnVhTzZ5S2NGVVlQdzR6bnpjZG8yb0s3cmFTQjRpYW9zdWlDZWZm?=
 =?gb2312?B?dmJ2WmVuNW4yUmtYTFVGOFhQaXRzZGxkT3laMC8wYUNuZTFRWVUxUmI0S216?=
 =?gb2312?B?akxkakVnYmRkakNtcUlmUDdORWVUeUxBbnBYRnRCUW1WYkJiS1o0dlhqN1Rq?=
 =?gb2312?B?V1pVWHlUN0daYlZDbkxlZnlLSXRybU1iSWJLa3Y3VkFnWGgxdjI4b1hwUjIy?=
 =?gb2312?B?Uk05YXd3MG4wTkRtVUZBcWlpY29LamNsQkJHbi9CTWJ3ZjdLVUN6RnRQanh4?=
 =?gb2312?B?c3BJdXFVN0p5cEhiZ1Y4WUM1SUJudlZscCs4MjNnQitpWk5BM3YwK3kzV0tl?=
 =?gb2312?B?UXIxUGd3bklhaVl0S0M2QU50T0xaaUZObXV1b0FMNkV5MHRQS0VGa2VvU0tX?=
 =?gb2312?B?R2ZLMzh5eGg2U09LQ0xiTUVOMFBRT0Y4Yy8reGZQWUJqSGtyTnNoWktKdmNx?=
 =?gb2312?B?dDJxVDgrdmVFMjN5L2poTnF1VmJUR0wrS0FLTytoTU8wRlhybWl1V2tpR053?=
 =?gb2312?B?TklibGdCN3lMUm9OdFVsTnhLb09WZjFTY29kNXFtaDJrSllpcjhwOTJ3L1dM?=
 =?gb2312?B?R1JaSU9QbE9vdDhlZXYwNTNvOG5qU2lFRUJ5YXZpQ216Vng2aDZEMmxVa0Fp?=
 =?gb2312?B?U2NIVUV2MmxDaUtkRVlOTGZNNGtDZnFLV0JnYThQM1J5dTE1OG1HWHE3ZW5U?=
 =?gb2312?B?US85VUN3bXJuTFpsOTZoRE43NmNpVVBEVWRueTd3cjRNa0xMejlMQT09?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK0PR02MB3202.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0789cf43-76f8-4e3e-6b5e-08da2395315c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 12:48:11.1273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ApD7accVrk2vsxvPzyEkjoZXr/2KyEweMtR8sJ9CPOVlt1xYohXs/LZ8e/94OC144rwf5XIYfgqYpAIHzE9oIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR02MB3541
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksIFNKDQogIE9LLCBJIHdpbGwgbW9kaWZ5IGl0IGFjY29yZGluZyB0byB5b3VyIGNvbW1lbnRz
DQoNCiAgQnV0IEkgZGlkIGNoZWNrcGF0Y2gsIHRoZXJlIHdhcyBubyBvYnZpb3VzIHN0eWxlIHBy
b2JsZW0uDQouL3NjcmlwdHMvY2hlY2twYXRjaC5wbCAtLW5vLXRyZWUgLWYgbW0vZGFtb24vcmVj
bGFpbS5jDQp0b3RhbDogMCBlcnJvcnMsIDAgd2FybmluZ3MsIDQyNSBsaW5lcyBjaGVja2VkDQpt
bS9kYW1vbi9yZWNsYWltLmMgaGFzIG5vIG9idmlvdXMgc3R5bGUgcHJvYmxlbXMgYW5kIGlzIHJl
YWR5IGZvciBzdWJtaXNzaW9uLg0KDQpZb3VycyBzaW5jZXJlbHkNCkhhaWxvbmcNCg0KLS0tLS3T
yrz+1K28/i0tLS0tDQq3orz+yMs6IFNlb25nSmFlIFBhcmsgPHNqQGtlcm5lbC5vcmc+DQq3osvN
yrG85DogMjAyMsTqNNTCMjHI1SAyMDo0MQ0KytW8/sjLOiBIYWlsb25nIFR1IDx0dWhhaWxvbmdA
Z21haWwuY29tPg0Ks63LzTogYWtwbUBsaW51eC1mb3VuZGF0aW9uLm9yZzsgc2pAa2VybmVsLm9y
ZzsgdG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc7IGdyZWdraEBnb29nbGUuY29tOyBzdXJl
bmJAZ29vZ2xlLmNvbTsgbGludXgtbW1Aa3ZhY2sub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyDNv7qjwfooSGFpbG9uZykgPHR1aGFpbG9uZ0BvcHBvLmNvbT47IMDutLrF9ChwdW5r
IGxpKSA8bGljaHVucGVuZ0BvcHBvLmNvbT47IMfxs6TGvShBYXJvbiBRaXUpIDxhYXJvbi5xaXVA
b3Bwby5jb20+OyC3trn61PMoR29yZG9uKSA8ZmFuZ3VvemVAb3Bwby5jb20+OyDN9bXCy/goRGVT
dW8pIDx3YW5nZGVzdW9Ab3Bwby5jb20+OyDA7ta+u6ooVGVycnkpIDxsaXpoaWh1YUBvcHBvLmNv
bT4NCtb3zOI6IFJlOiBbUEFUQ0ggVjRdIG1tL2RhbW9uL3JlY2xhaW06IEZpeCB0aGUgdGltZXIg
YWx3YXlzIHN0YXlzIGFjdGl2ZQ0KDQpIaSBIYWlsb25nLA0KDQoNCk9uIFRodSwgMjEgQXByIDIw
MjIgMTg6MDU6MjQgKzA4MDAgSGFpbG9uZyBUdSA8dHVoYWlsb25nQGdtYWlsLmNvbT4gd3JvdGU6
DQoNCj4gVGhlIHRpbWVyIHN0YXlzIGFjdGl2ZSBldmVuIGlmIHRoZSByZWNsYWltIG1lY2hhbmlz
bSBpcyBuZXZlciBlbmFibGVkLg0KPiBJdCBpcyB1bm5lY2Vzc2FyeSBvdmVyaGVhZCBjYW4gYmUg
Y29tcGxldGVseSBhdm9pZGVkIGJ5IHVzaW5nIG1vZHVsZV9wYXJhbV9jYigpIGZvciBlbmFibGVk
IGZsYWcuDQoNCkFzIGNvbW1lbnRlZCB0byB0aGUgcHJldmlvdXMgdmVyc2lvblsxXSwgbGV0J3Mg
d3JhcCB0aGUgbGluZSBhdCA3NSBjb2x1bW5zLg0KY2hlY2twYXRjaC5wbCBpcyBhbHNvIGNvbXBs
YWluaW5nLg0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbW0vMjAyMjA0MjEw
ODQ4MDYuNzI1NTMtMS1zakBrZXJuZWwub3JnLw0KDQo+DQo+IFNpZ25lZC1vZmYtYnk6IEhhaWxv
bmcgVHUgPHR1aGFpbG9uZ0BnbWFpbC5jb20+DQo+IC0tLQ0KPiAgbW0vZGFtb24vcmVjbGFpbS5j
IHwgMjYgKysrKysrKysrKysrKysrKysrKysrKysrLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCAyNCBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPg0KPiBkaWZmIC0tZ2l0IGEvbW0vZGFtb24v
cmVjbGFpbS5jIGIvbW0vZGFtb24vcmVjbGFpbS5jIGluZGV4DQo+IGUzNGM0ZDBjNGQ5My4uZTU3
M2UzZjUwMDY0IDEwMDY0NA0KPiAtLS0gYS9tbS9kYW1vbi9yZWNsYWltLmMNCj4gKysrIGIvbW0v
ZGFtb24vcmVjbGFpbS5jDQo+IEBAIC0yOCw3ICsyOCw2IEBADQo+ICAgKiB0aGlzLg0KPiAgICov
DQo+ICBzdGF0aWMgYm9vbCBlbmFibGVkIF9fcmVhZF9tb3N0bHk7DQo+IC1tb2R1bGVfcGFyYW0o
ZW5hYmxlZCwgYm9vbCwgMDYwMCk7DQo+DQo+ICAvKg0KPiAgICogVGltZSB0aHJlc2hvbGQgZm9y
IGNvbGQgbWVtb3J5IHJlZ2lvbnMgaWRlbnRpZmljYXRpb24gaW4gbWljcm9zZWNvbmRzLg0KPiBA
QCAtMzU4LDExICszNTcsMzQgQEAgc3RhdGljIHZvaWQgZGFtb25fcmVjbGFpbV90aW1lcl9mbihz
dHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQo+ICAgICAgICAgICAgICAgICAgICAgICBlbmFibGVk
ID0gbGFzdF9lbmFibGVkOw0KPiAgICAgICB9DQo+DQo+IC0gICAgIHNjaGVkdWxlX2RlbGF5ZWRf
d29yaygmZGFtb25fcmVjbGFpbV90aW1lciwNCj4gKyAgICAgaWYgKGVuYWJsZWQpDQo+ICsgICAg
ICAgICAgICAgc2NoZWR1bGVfZGVsYXllZF93b3JrKCZkYW1vbl9yZWNsYWltX3RpbWVyLA0KPiAg
ICAgICAgICAgICAgICAgICAgICAgbXNlY3NfdG9famlmZmllcyhFTkFCTEVfQ0hFQ0tfSU5URVJW
QUxfTVMpKTsNCj4gIH0NCj4gIHN0YXRpYyBERUNMQVJFX0RFTEFZRURfV09SSyhkYW1vbl9yZWNs
YWltX3RpbWVyLA0KPiBkYW1vbl9yZWNsYWltX3RpbWVyX2ZuKTsNCj4NCj4gK3N0YXRpYyBpbnQg
ZW5hYmxlZF9zdG9yZShjb25zdCBjaGFyICp2YWwsDQo+ICsgICAgICAgICAgICAgY29uc3Qgc3Ry
dWN0IGtlcm5lbF9wYXJhbSAqa3ApDQo+ICt7DQo+ICsgICAgIGludCByYyA9IHBhcmFtX3NldF9i
b29sKHZhbCwga3ApOw0KPiArDQo+ICsgICAgIGlmIChyYyA8IDApDQo+ICsgICAgICAgICAgICAg
cmV0dXJuIHJjOw0KPiArDQo+ICsgICAgIGlmIChlbmFibGVkKQ0KPiArICAgICAgICAgICAgIHNj
aGVkdWxlX2RlbGF5ZWRfd29yaygmZGFtb25fcmVjbGFpbV90aW1lciwgMCk7DQo+ICsNCj4gKyAg
ICAgcmV0dXJuIDA7DQo+ICt9DQo+ICsNCj4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qga2VybmVsX3Bh
cmFtX29wcyBlbmFibGVkX3BhcmFtX29wcyA9IHsNCj4gKyAgICAgLnNldCA9IGVuYWJsZWRfc3Rv
cmUsDQo+ICsgICAgIC5nZXQgPSBwYXJhbV9nZXRfYm9vbCwNCj4gK307DQo+ICsNCj4gK21vZHVs
ZV9wYXJhbV9jYihlbmFibGVkLCAmZW5hYmxlZF9wYXJhbV9vcHMsICZlbmFibGVkLCAwNjAwKTsN
Cj4gK01PRFVMRV9QQVJNX0RFU0MoZW5hYmxlZCwgIkVuYWJsZSBvciBkaXNhYmxlIERBTU9OX1JF
Q0xBSU0gKGRlZmF1bHQ6DQo+ICtkaXNhYmxlZCkiKTsNCg0KSSdkIHByZWZlciA4MCBjb2x1bW5z
IGxpbWl0LiAgQ291bGQgeW91IHBsZWFzZSBwdXQgdGhlIHN0cmluZyBpbiB0aGUgbmV4dCBsaW5l
LCBsaWtlIGJlbG93Pw0KDQogICAgTU9EVUxFX1BBUk1fREVTQyhlbmFibGVkLA0KICAgICAgICAg
ICAgICAgICAiRW5hYmxlIG9yIGRpc2FibGUgREFNT05fUkVDTEFJTSAoZGVmYXVsdDogZGlzYWJs
ZWQpIik7DQoNCg0KVGhhbmtzLA0KU0oNCg0KPiArDQo+ICBzdGF0aWMgaW50IGRhbW9uX3JlY2xh
aW1fYWZ0ZXJfYWdncmVnYXRpb24oc3RydWN0IGRhbW9uX2N0eCAqYykgIHsNCj4gICAgICAgc3Ry
dWN0IGRhbW9zICpzOw0KPiAtLQ0KPiAyLjI1LjENCj4NCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fDQpPUFBPDQoNCrG+tefX09PKvP68sMbkuL28/rqs09BPUFBPuavLvrXEsaPD3NDF
z6KjrL32z97T2tPKvP7WuMP3tcTK1bz+yMvKudPDo6iw/LqsuPbIy7ywyLrX6aOpoaO9+9a5yM66
zsjL1NrOtL6tytrIqLXEx+m/9s/C0tTIzrrO0M7Kvcq508Oho8jnufvE+rTtytXBy7G+08q8/qOs
x+vBory00tS159fT08q8/s2o1qq3orz+yMuyosm+s/2xvtPKvP68sMbkuL28/qGjDQoNClRoaXMg
ZS1tYWlsIGFuZCBpdHMgYXR0YWNobWVudHMgY29udGFpbiBjb25maWRlbnRpYWwgaW5mb3JtYXRp
b24gZnJvbSBPUFBPLCB3aGljaCBpcyBpbnRlbmRlZCBvbmx5IGZvciB0aGUgcGVyc29uIG9yIGVu
dGl0eSB3aG9zZSBhZGRyZXNzIGlzIGxpc3RlZCBhYm92ZS4gQW55IHVzZSBvZiB0aGUgaW5mb3Jt
YXRpb24gY29udGFpbmVkIGhlcmVpbiBpbiBhbnkgd2F5IChpbmNsdWRpbmcsIGJ1dCBub3QgbGlt
aXRlZCB0bywgdG90YWwgb3IgcGFydGlhbCBkaXNjbG9zdXJlLCByZXByb2R1Y3Rpb24sIG9yIGRp
c3NlbWluYXRpb24pIGJ5IHBlcnNvbnMgb3RoZXIgdGhhbiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50
KHMpIGlzIHByb2hpYml0ZWQuIElmIHlvdSByZWNlaXZlIHRoaXMgZS1tYWlsIGluIGVycm9yLCBw
bGVhc2Ugbm90aWZ5IHRoZSBzZW5kZXIgYnkgcGhvbmUgb3IgZW1haWwgaW1tZWRpYXRlbHkgYW5k
IGRlbGV0ZSBpdCENCg==
