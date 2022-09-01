Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16065A9076
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233837AbiIAHh5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:37:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233610AbiIAHhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:37:54 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120078.outbound.protection.outlook.com [40.107.12.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD8B8109082
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 00:37:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cwhDKPAcq1rPhRw/DLEhrCZx1ys5bA1fodbXJWl+VdjLeM3UysJGKudqc6jWrJxsx93cadep7KpuT6BM4V5/F+4euNu1Ujp53z6WCJ+yowBXGdDtztSNMl/RdTAVVJkuDZL/6NBRzJ+Ko/l4RJrG0pFadiMHyVZKEQxYC1p+u/YWmY0Ke4Q92BEqwSpM+MSTfyQtHSJphEHlyf17JigVNiYvugt79WZ+X2uILRH+1dy+A/AbQ2ecgTJc4NAe4AQCJPpTMhPOvl4Al/Kzz0mKUusSMUsOO6LTFc2NHordfOZIsvOccH5Vu0IYM2BPKFSPUMNNd3akyctsnNNbMn5NDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=isJtQLFV4RWpaXxTFbSr1A+UN+Xsw4rz7OJt5ifA5Cs=;
 b=G4u8KRaPFwBdG6QGVDtvqMycPfwUqFHMUAOPOj7uSxjuT/yVB1EMf570sxHZdO1ehdMo3Ueg2Y/1/5KbyMoPKFoVcB9pIpWjgAJLlC1N4WU7hzFnCVbjnkkVnWX/zf43+e1J0xAm0TjBx4SynHsAYfuSygfmQsYfNrabnLZmL+b+RKOo2PyfRsiRM8PVT0BMGIysvVCELLKscjfPMycU/6iAKlO6xnPnwR++EHX8r74HCVAMQ96H2tzcKZte4LWXuiyU8mma9uPLjDqFU0QfwmggHeTLvv00z330D/M2was6cyHWCrP+Tl1kGkOs6LcZ58qu8X311WwRPkfwc1BCDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=isJtQLFV4RWpaXxTFbSr1A+UN+Xsw4rz7OJt5ifA5Cs=;
 b=PNMfUa5PAy/OcruWilQCtSPTodqz00Y4P9UB7wl+NSSCks6MgPVnNbVF0wlQSQV3w+7+t9zJMSZsfLnM50QqPJo8z17jftncAmHAZOhsXrgjFHENnYObJrKQT6A9fJE0hl0smCi9gc2KP104RjGIADLxjY6owEDDOjNVLY1pUjvVgc7pQBggazLGHW6bgw8hI+VzDDmu98GJnZXy1RtBYAb6pp/nFpesL9xRmLwPz8tTrgPYCnKPHSYENDT9FZfAnKmLhBGdASi97s8QewU0VsXlMxLWrbWWCCf1Bm/oJMLL/h2OPgKwYIH+DUYEwqnhChioUwN6ao81Mv2uVlSqUA==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PR0P264MB3144.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1d7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 1 Sep
 2022 07:37:50 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::382a:ed3b:83d6:e5d8%4]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 07:37:50 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Yuan Can <yuancan@huawei.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: remove extra empty line
Thread-Topic: [PATCH] mm: remove extra empty line
Thread-Index: AQHYvc2TONWZCjFsJ0SltDVL7gZs263KL9qA
Date:   Thu, 1 Sep 2022 07:37:49 +0000
Message-ID: <0e2ea2d8-5b0b-107a-c679-7d5a7e37718f@csgroup.eu>
References: <20220901063725.24220-1-yuancan@huawei.com>
In-Reply-To: <20220901063725.24220-1-yuancan@huawei.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7867fc1f-3213-440d-b8e1-08da8becdf3c
x-ms-traffictypediagnostic: PR0P264MB3144:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iBPDGW6gV0ix4XiapQ/qnKLjOS4lP/kK2ABbqVUoJzrLrzvL3UcoRNb5qciKT2+nJ7EQ+SHEND1G0i3PHunOF8w2FIkU0ieft/UL66e5kJ4jX+JJVMQTwKftiKBn7yp9pz/TvKv/rdTRyNSBT8tGtbB3qOyfvrCml9C04ER11ZTEUL4SUh16cYgjxO7vww8CZPtVq1jsOqqRnv8Rhyjll+O3iejc1wpIQuEH7I0Bm5TvVBdxxIMj1K/QFjBpNIDVa3mu/NSUxghzGqsUiS1aHVCfwgpaaAbgvX57m16tMhvit3+wWw0t0wlknEehdgs5CxAjb1lnkAi0eX1jPovO7bcyZyAUiRqfCRBP7+/OzvpM6AKtIx6+bDEfJ07alLfF4gDg/2laThOw2bep+qQpiqVljfJzVH8HHy6z4+OKIDthyfW7/mWxRkpj8i7AcBl9ku2xlEPTEuXZycQUDHkEotVwic8sbzZHGE4GY3Ok5R7Xg/0wSzfjTws05MbsRgc/zcYM54+/ZnsgKdCvbDQ5LoyRt7pG8q6x6mGdAPwcqLjjRvSxytgABAP2Cbwr8cIYLL8NkXvyD2pR0HT0aA4NGI3EhdOXH+rXsltxv0EbRJY+TE9hNMCbb+psQ4V0ls40SXfBPlMBs6ZXRKzhuHB7w9Iub7wNjqDEJe1l5uZyYg3jq6rveUCJszGTi7+UiixtAbjKG8QS4dQcvlt0j9uA3yoO84XQXaUCaenIx1EnZYBMCL9wF5jfpdKfZG/bmxGeRqA5koBSddMnINUtNtG2TJ9Fxl0puFxnRcwe0lhFhyeKHjdDpB+iKxrwZeGgXgzxDlikqYT28kYxpMwd9AfKOw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(39850400004)(346002)(396003)(366004)(136003)(66556008)(38070700005)(4326008)(76116006)(66446008)(64756008)(8676002)(66946007)(31686004)(36756003)(122000001)(38100700002)(86362001)(31696002)(91956017)(66574015)(83380400001)(41300700001)(478600001)(26005)(4744005)(6486002)(2616005)(6506007)(71200400001)(6512007)(186003)(2906002)(316002)(5660300002)(966005)(110136005)(8936002)(44832011)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFA0dUR1WDVzSUw0bUg1d2o0Skp2ODdSZlNyRmYyYjc1YVRDWHlPRzRZWjNz?=
 =?utf-8?B?bDNjSStockV3cHlRV3Q0TDkyYzZHS0NOajI0ZEVXUktkS3d5VHhiQjNZcmJU?=
 =?utf-8?B?SE9UREdzUi9jVkcrY0dtaDZNNk9lOXJCT0V4QW5LdFRYTlU1OUtLbXl6eVBU?=
 =?utf-8?B?WmpIRmlsUEtPaHBKcVZHOWZaZTF1NkwwYVo5ei9McUJGb0FGVUpqVEpwcnhh?=
 =?utf-8?B?aWJvNXl5TnMzT2wvam9wQ1gybUZRQTN4Q2xmRS9zN0QreE5VVlE1SE56ZVhM?=
 =?utf-8?B?eVZTM0VxM3gySmlCVi84eHBkRU55cXFTQ0Z4UW42dDVaMEJSV2IyeDhuc09G?=
 =?utf-8?B?RXVrVmRMZkJnU0N1Y2loZjFmSEI3UUI1L2djaEd6MTNwUThDRHBXS1Q3ZktF?=
 =?utf-8?B?U0xscEJnR01SaW80SlpiVlBlTkpQL3l4TXU2bVhHYzYvVU91dWFFV05taXlK?=
 =?utf-8?B?UnVzYzhuMy85NjRTWUdtRkh2NENSaDZQOHd2WEVMUTZSUmZ3Wm84L0h5TmJV?=
 =?utf-8?B?SFlLd2s5VXphZjR4ZHVSUkVmQlBIQUxBdVF0YWhvMDFzZmlVZTFsTGpzQTVZ?=
 =?utf-8?B?dS9zRjF6M2pjNnBWUHV2bS9HZzVmSjVzK1JsbzZjaGNHeGduV3M0ZFVoTkk3?=
 =?utf-8?B?eEEyUldOemh0MktlWTBSL25DejRnc0lGazgyb0hYRnJzNGZmUmFmQlkrT200?=
 =?utf-8?B?c2ZmbFVBSkVGVWVGd2lQcWpQVkhFY3JaeGFic1V2VFZwb3p4QmM1enNwdkpt?=
 =?utf-8?B?bDI1eHdLVENhOGJ0WWhHZlBRSkpxdy9GdlpuVk85dGVJcFRDWFdTc0d3bis3?=
 =?utf-8?B?NS9LSU1VR2o3OGZ1NzB1cVZGa1J3aTBwNXF0QjY4Zm9IRFA3amx3d2hoanNv?=
 =?utf-8?B?QlB1Njd0ekJHbUJyelpiRVJNT3VTOHRsT0JKdkE3UVNFZnJGcnU4RS96TXdQ?=
 =?utf-8?B?R0tQNkZYQUpHanNCUDdXYnZyZjVqdUR5RElGcUY3dWk5YVZLeXNDeG80WmVy?=
 =?utf-8?B?MUFyZC9oOHIzbVJXTTZQc0RxbjdIRDFXOFVheFB5cGJNMTZ0UUxFbVg3L3dB?=
 =?utf-8?B?cXJYeWJ6NHErWGVSZmhKU0VYY1FHY0E4QVNPNzhGOFEzcGZpU1BNNmQ4cTNX?=
 =?utf-8?B?VnhkUmV6UmNDZkNoNzRCVGF5eUcxN3MvdmE3RDkvTXBhdjdkUmdTKy9lMnpv?=
 =?utf-8?B?c1hCOVNBUC9hWTR4eDltMVdrY1FBNjBhNDRmbWx0dkNJWW1kOFJLakZ2bHd3?=
 =?utf-8?B?cGdGYlJoT3Z1MkphNVpBMGVGWTJaQVlGUGs0Zi83bGpib3VZeVJ3bWpZYjht?=
 =?utf-8?B?MW56Wkx0UjJNVmYvaG40MUdITjN2eWpSOUVSeGdrNXZNOFEvUlVmOEZKNmRN?=
 =?utf-8?B?eXNtbGg1TmVsbFFGdEsxMFZtMzNHRmRDeHNPVFg3QVJCVjN2aG5yeXVPVk5K?=
 =?utf-8?B?S0ZlQ1J5UnhSaW84cVFZZlB6Y0VGSU9Gd2c2bUcyRFBPb09YMi9VRjdpdnFQ?=
 =?utf-8?B?emhya0NXampQYTBmSjlxM3Zwb0RUSk5DVnhXQk1aRnpVRzZGZWRkQTVlZm11?=
 =?utf-8?B?NWNORVh4NUVpZjdqZ3k3YWxRRlZZS3gwT3gyVTVCQURTRS83SjY2S1RNU2ZJ?=
 =?utf-8?B?b1hLeGZ6K2RRSHlpaGVtdExXMnFvYmtZZUVkdFpNWExiSmRaMmJlekRtWUY1?=
 =?utf-8?B?ZXl6bUk1a2tndlV3QmFlVVpWNXZoZ241LzhxYVo1a3RVQnhQKzBxVFRSZkUx?=
 =?utf-8?B?M2FnZHE1aHhDbEZUWGxucHpmZmxhT2RjeUIwMnFpeU55QVYxVnI1bkpoWmpl?=
 =?utf-8?B?VjhhWXBLNjJXQlY2SEhkQlcydnF5bUNBbWR0aGJaRXZNT2xRM2dSVE1PZUln?=
 =?utf-8?B?QlNZRkVPQUJmV3VrVSsyZWpaYlhPaTNualN2dFFPVFhvSitPS0QxYldsMWdo?=
 =?utf-8?B?SkplaHdUR2JiWkt1ZHBzWHluMExwRjF1eCtWOENncVNlZ2pkM2RZSmpiRURm?=
 =?utf-8?B?eS9EajVpbEpRUGdXd2xKT29XbHBTTldDUjhjakhGK3BSWlc0aXJWcTVjWTU2?=
 =?utf-8?B?RVplNkhYS2dncmpZcEt0Mnd0cmYzMjZMNjFFZjBKdlRKaDhSbC9UWnUxTG9m?=
 =?utf-8?B?SFhNRHovTHM4ay9RSFo2SDN1UzV1TWFmajd1bithY0lpRldXYTNMcEVJMmNy?=
 =?utf-8?Q?ao4Ss9bcUuoYazqQVCB/6Ek=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33165CBA048E564F8A833F828935B457@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7867fc1f-3213-440d-b8e1-08da8becdf3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 07:37:50.0031
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nFe94jEf5sCD1+NUUyW8GQ1NLwtzeJAqS1Pr89cs7CJYu4R5N9SGfp5Jq8R1ZHdwfBCfjMeoo6+aQQrzTI6fH03X8aM+O7K3oci/rTJHzt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR0P264MB3144
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDAxLzA5LzIwMjIgw6AgMDg6MzcsIFl1YW4gQ2FuIGEgw6ljcml0wqA6DQo+IFtWb3Vz
IG5lIHJlY2V2ZXogcGFzIHNvdXZlbnQgZGUgY291cnJpZXJzIGRlIHl1YW5jYW5AaHVhd2VpLmNv
bS4gRMOpY291dnJleiBwb3VycXVvaSBjZWNpIGVzdCBpbXBvcnRhbnQgw6AgaHR0cHM6Ly9ha2Eu
bXMvTGVhcm5BYm91dFNlbmRlcklkZW50aWZpY2F0aW9uIF0NCj4gDQo+IFJlbW92ZSBleHRyYSBl
bXB0eSBsaW5lLg0KDQpEb24ndCB5b3UgaGF2ZSBhbnl0aGluZyBtb3JlIGV4Y2l0aW5nIGFuZCB1
c2VmdWxsIHRvIGRvIGluIHlvdXIgbGlmZSA/DQoNClRoaXMga2luZCBvZiBzdGFuZGFsb25lIHBh
dGNoIGlzIGEgd2FzdGUgb2YgdGltZSBmb3IgYm90aCB5b3UgYW5kIHRoZSANCnJldmlld2Vycy9t
YWludGFpbmVycy4NCg0KQ2hyaXN0b3BoZQ0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBZdWFuIENh
biA8eXVhbmNhbkBodWF3ZWkuY29tPg0KPiAtLS0NCj4gICBtbS9tbWFwLmMgfCAxIC0NCj4gICAx
IGZpbGUgY2hhbmdlZCwgMSBkZWxldGlvbigtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL21tL21tYXAu
YyBiL21tL21tYXAuYw0KPiBpbmRleCA2NDQ1ZmQzODZmMDQuLjI1MDRmODlkNTE5ZiAxMDA2NDQN
Cj4gLS0tIGEvbW0vbW1hcC5jDQo+ICsrKyBiL21tL21tYXAuYw0KPiBAQCAtMjgwNCw3ICsyODA0
LDYgQEAgU1lTQ0FMTF9ERUZJTkUyKG11bm1hcCwgdW5zaWduZWQgbG9uZywgYWRkciwgc2l6ZV90
LCBsZW4pDQo+ICAgU1lTQ0FMTF9ERUZJTkU1KHJlbWFwX2ZpbGVfcGFnZXMsIHVuc2lnbmVkIGxv
bmcsIHN0YXJ0LCB1bnNpZ25lZCBsb25nLCBzaXplLA0KPiAgICAgICAgICAgICAgICAgIHVuc2ln
bmVkIGxvbmcsIHByb3QsIHVuc2lnbmVkIGxvbmcsIHBnb2ZmLCB1bnNpZ25lZCBsb25nLCBmbGFn
cykNCj4gICB7DQo+IC0NCj4gICAgICAgICAgc3RydWN0IG1tX3N0cnVjdCAqbW0gPSBjdXJyZW50
LT5tbTsNCj4gICAgICAgICAgc3RydWN0IHZtX2FyZWFfc3RydWN0ICp2bWE7DQo+ICAgICAgICAg
IHVuc2lnbmVkIGxvbmcgcG9wdWxhdGUgPSAwOw0KPiAtLQ0KPiAyLjE3LjENCj4gDQo+IA==
