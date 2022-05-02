Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8134A516E86
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 13:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiEBLLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 07:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbiEBLLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 07:11:19 -0400
Received: from FRA01-MR2-obe.outbound.protection.outlook.com (mail-eopbgr90087.outbound.protection.outlook.com [40.107.9.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C384112768;
        Mon,  2 May 2022 04:07:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSDfzNFgtrvF/Sa+FSdrRWfKQ67iUvuKx+46ZYuGBn8j2ui3hRJWVyrey37+RIr0MHiG1Kz8/CHgoaJ0QfTa5P34yhm15FBANIWjgDO1+oelPrrvr6mZ6zDn7yRdT8sdFw6MTf8K7JSfFa1iivfJXCYUF4S8NzwZtQpYV+VlojF5TdsMoFHKM6GyKSEHTNRfz2iJySGNB12rBr9elB+5p0lt8H0wwX4tTMWX83MLw0JSI0FgooPJ+n4C5nNnFpiS2LPkTUaPlaTQJm00IKY/7x9fWHFn7G5AoDosSGiZCfPHYiKWX1NJQse2vKhnWq1uqpg6qB6rU+cT08OkyQlgDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sKpF8Rw+VsZjKpxz6DhX85/3ETYhfVgs3/I2aF986CE=;
 b=l2cM0fMRMWyVk6wROD0oJvq/6zzkG+vB2YmiH9OVFKOaLVHeMNSNKmu6HK7yepUUjfJW+4tBz2T2n5GIAps6ybFXlIsKVGsp1OzISwqUQL6ffkmfT4bCivoDPuAJ1j5dT4BQSAfSNldUgKHYGPh8IGhFK8VMwbQK6bEcVLnzV6/Q6VIT7NY529/1nVopu9LB0jZLwF25nWFg6u4H3MrJuUPS1K2X8XjGpwP4FWIcyB9sYs3bqPXNSiG8A52MHiXGPyrhbzHwc1Mi4wvdgUQGKkp+uHQnH4NbCqfZlWQyR2+l49E1HbbHaKlhYBd+AAY6GcXDOqJVtJkWlnee7cO/Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by MR1P264MB2323.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:34::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Mon, 2 May
 2022 11:07:46 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::d572:ae3f:9e0c:3c6]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::d572:ae3f:9e0c:3c6%7]) with mapi id 15.20.5206.014; Mon, 2 May 2022
 11:07:46 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Aaron Tomlin <atomlin@redhat.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>
CC:     "cl@linux.com" <cl@linux.com>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "ghalat@redhat.com" <ghalat@redhat.com>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        "neelx@redhat.com" <neelx@redhat.com>
Subject: Re: [PATCH v4 2/2] module: Introduce module unload taint tracking
Thread-Topic: [PATCH v4 2/2] module: Introduce module unload taint tracking
Thread-Index: AQHYWIQXznKbDh+0WUiDZi/VZUKKPK0LeKwA
Date:   Mon, 2 May 2022 11:07:46 +0000
Message-ID: <73869e4f-7190-221c-897b-fc13ec54c8cb@csgroup.eu>
References: <20220425090841.3958494-1-atomlin@redhat.com>
 <20220425090841.3958494-3-atomlin@redhat.com>
In-Reply-To: <20220425090841.3958494-3-atomlin@redhat.com>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 14fe077d-3ec5-46a1-adbe-08da2c2bfd2c
x-ms-traffictypediagnostic: MR1P264MB2323:EE_
x-microsoft-antispam-prvs: <MR1P264MB2323226D8F460FED68452468EDC19@MR1P264MB2323.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TcWrXclj3t7xnHTo5NIhchR69VFgkuUiVmsuY4P/t5FAEJvpOka/T1Hp+ugnmRf+OfKn9SFE+WyHekg6B3aqYJxb0Dv7lWj76La6tzVeoUUSouumEeWVosCNzAUUxj9E+/RDzqlpCeOzihbhu4CF+X2aQKv7j19DrYOzIEt3hRBKvOgsATak8h6/1gFWxUix9LZA4x/tSHmSvXNIItEHpZB4c055l7tcFQ3ujzjyMFDuhD/rnmDFcg21RDRM7qEhNyIf+La9v2KWReyxTS5vahyhTcweebxxUojNUBij1z2+kq4PmfCmvraeICuFOuFC8314NUwb952br4HWYt75pCAqKeotJkPzCwzjTDfrKReCTffDq/1lG5sHgQKFxYs6mSfJQFBFbeYx5ei3fJl15gHIChFetrh8ZTZAapJmujaYVusna5Gb9lFzLIBH+SGdWOetHwe5W4+6STPLVlP36HYd963QOQhLP0hvUMdLR1nWYIg6TGEqZbn0T29nW7dRp8cPoRdtvQ0gUNNZfYvcodkr2giuhvb1UkfCo+EELjPfotzZHxaV1kLYV06yX+px2CFPv/hPxEP2whDOxYseKXKdZ2BfMlk9qCK0R0eYgW1+4nrhl4Fl2zNa+wvsT8fU1aNRjXjvgmDBgY2LS6dR3tUdRg+1Nt55qraSJUWHtCy3AEgrrg1p8vpBG5lfH61igs2Rk1Qao71xg8FOKRRyN8xp/nzcpXULsxI9kPj6+qHisFoK1s+4R5giqpuve4B/pBieVStb5aRozwCdqHi6BA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(66574015)(83380400001)(6512007)(8936002)(122000001)(508600001)(26005)(6486002)(31696002)(31686004)(186003)(36756003)(54906003)(316002)(110136005)(71200400001)(64756008)(66476007)(66446008)(66946007)(4326008)(6506007)(2906002)(76116006)(66556008)(8676002)(91956017)(44832011)(45080400002)(86362001)(38100700002)(38070700005)(7416002)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3RWeElYbG9rVTZGMWtScVNNUlJSVGw5dlZsdWhYa0FFTzlVYUNWUm5SQ3F2?=
 =?utf-8?B?S1BMTCtQaW9YMDdjbThUbVhFUDdFaU5XWWxSdXZJMW04UVZUREoxcXFOcTRF?=
 =?utf-8?B?a2Yzdnl2WDFSQ3kvcE5Xem9xUTUrV3MyWktlRCtEMUFMcFpTRGtMQ0lNU1pn?=
 =?utf-8?B?RE51cDRVZXVRS0JzNjNIdTZFT1U4RnpVVGMwM1ZFNCsxczdVR0R2LzlDR2g2?=
 =?utf-8?B?SmJleDdVN0lZcklKNDdwK0xUVGt1MjdCanJSd3R2cWM5aXVLSEozRjdiSTJJ?=
 =?utf-8?B?YytXbjdudXJVRUJvYTFlelpWcHo1dmgydTNTbEJoTkFzby8rRGRPamhpcUpL?=
 =?utf-8?B?aTNWM094K2hWVXZYenJzN0h3eXBaQTNPYVBKMXpHWHk3bUJrT2twVngyWVpQ?=
 =?utf-8?B?R09nUWIxRFVFSFBoMXpEd1U4aDByR2IwazZyM1BsUlkrSGVTMkc1L3puZWo5?=
 =?utf-8?B?Q3BzZERKMFRaUlo4bnBLZlpYcWlUMWQ2dVNJMyt0Yld5aTJvd2Vxenp4TDNq?=
 =?utf-8?B?TU0yT0orRExiUGpzMGlNUFpXcW92Vi91b2tPUUhDR0ZySk4zVCtnMkJNN1JV?=
 =?utf-8?B?TGpnVVY1YjZTaFFlUTZFVGxRM3UzZVJkR1htd3JpcDl5NDF1RGNlNFN0anBu?=
 =?utf-8?B?dGZ3NVJqWW1jMWEzcGJNckpzSytNbWpPYjh4ZitxeWdTYWhhSTBMaUdlaHI0?=
 =?utf-8?B?NE1tV3l2WlJycWhoZFBXZ2VjME9kK2lwQUMvTE91dXRTN0tOV3lXWkt0cXFT?=
 =?utf-8?B?UDNTNFN1akFCQkYrSGs3aDFzSm1qcEs1bXZ6VTEyNWZZajhXMTJxa2NVbDNN?=
 =?utf-8?B?bTVKZ29ZclhxeWlvSCtjQkxMQmh2YTBJMlhBWFdBUkJEcmlMZnBueGdPSmpv?=
 =?utf-8?B?U1lwRVN1UEhFSVVIL3luNmxrTFZRQWlndVFpZUVJQ3Z0WGtwRmVwZ1VEV04z?=
 =?utf-8?B?ZTRaRXZjb0tkTisxSGNkMFBoUzF6RHpJR1VhcStKQTlRempXd2h0VkFPUXpC?=
 =?utf-8?B?Z3pwbTNSUTFOM3dCSW1kd3gyUGRJVXAxQXlZZEJ3VDljZERSNUZnSCszenNB?=
 =?utf-8?B?dnd1TWk1Ujg2YldYRDVlRytRVktEWEgxTXoxVkU4R1dwd09jemhOcCtZR0Zn?=
 =?utf-8?B?RTEzd2JLNDJ6Vmo5U3BKc3BMZHJYUnN6MHB4TWhsTjV3SFlxbFFjRC85Wis5?=
 =?utf-8?B?ODl2UEJzSmY4YzFKUWlySDE1UkRrYWxlZnVtRFk3dFl2RzNOY3d1a0Vib0hm?=
 =?utf-8?B?dkV6K2pqdnpJa0Vvb3pCZGFqNHVDWnMvR0xvekF2RS83eXIyTXBXV0h0ajAy?=
 =?utf-8?B?UmVqbFRMc2k5Q2Q4bzVhZ0x1d1lhNTNnQ2F4VDUzbWhNRVVMQkRCOFU5NWox?=
 =?utf-8?B?M0laYkxQMEZvdm1JTWd2S0lORjdiOEgyb2d3QUcrdzdQODJhQkxHRXRjejk2?=
 =?utf-8?B?Z2NiMUIzVHJUeWgrc0RWTkhLRG1vZXRjMUFDRWg3aGNGMXNHeDR1bVNmdmVE?=
 =?utf-8?B?TDdLUUVWWWdJSkptOEE1Nkk0OWJyVEN4VHlKeWlLbXBTTVJEazB0ZVhNWnBQ?=
 =?utf-8?B?Q3c1Q09WMnYyeTY3dnNUUFlOL29oWjl4NGpEWWNzdktvS1VadmdJMXpXbGlN?=
 =?utf-8?B?UUk1TVYveE5wc0xNbnRZbXFlU0s3Wk1MVzZ0bTBRTForOEhBQlllVi9VMHRv?=
 =?utf-8?B?ancrZ0hZbVlhVS9IRFhUWGtheVlncjN5MEVuaC9pcHlYdDhwMndCMDNpWjZO?=
 =?utf-8?B?aGdUTXZKdjZIM1lYRTFETzdDZW1NNHJ5MDdhOWo1WnJxUm9PemhOQjViSzRl?=
 =?utf-8?B?TVJ3cHoreHBHTElsYWsvM2h6eitFZG5VQzBmT0FpUk1BNVFWZzNxRE5XeHpI?=
 =?utf-8?B?clQrS1lFYnQ2MGg4bTlPWmwrc3ZKY3BBL2FKWnJLWldycVBGZDFHVGpVbDFa?=
 =?utf-8?B?N21UZWNIR3JpbHd0OEgraVExd2N0Tm01azFneHZSSHlhaVNtN2lKeGZmaVA0?=
 =?utf-8?B?cWxsWjlqYldBRkEwamFIdE5LTFFQbmJPZnhvTERHbTlyYVRMUDBVTG1wUWZB?=
 =?utf-8?B?QWtJaFpyVDBaMzJydVp6N1RrS0N5dHphQTYwblYvYjR2Vk5TZ2hnVVE5NWdk?=
 =?utf-8?B?RnUydjcyU3c0cGhmb3Q4Q1NmQW14T0RlNGxPK2ZhekIvV2pLTjFvY25ZNzJR?=
 =?utf-8?B?TzE4UDJCY2FTYmZLQjFTU0dZOUo3aEFncDhCRHFFZnFJdE9xcjJaY2x1U0FJ?=
 =?utf-8?B?RktLS2svZVo3VFhzZUUxbWVpVEgwcU5SaWRYZ3d3d3hRU25ta3JNaENaRm4r?=
 =?utf-8?B?eWRRbW80RWZSeDRweUxvWWVZdU0rOTQ5R3FnTGdGRjNJRkdlNmM3dEppNjNX?=
 =?utf-8?Q?Cv+DRVHRZ+pX//kb5xXk4QHGqtbnnddtbnq1O?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <793B3563E79FBE4492D59DFD9A757DB0@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 14fe077d-3ec5-46a1-adbe-08da2c2bfd2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 May 2022 11:07:46.8501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fdsz/NFyowVctaAZzFAhRJE0Ia3tKxcy+Ghn316ZUqgI7/eujujfg5YdhQrllnI13BSpm1lqLzTmiwM3hgdI6fxM9p3CFtt1PdliCd5aGUQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB2323
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDI1LzA0LzIwMjIgw6AgMTE6MDgsIEFhcm9uIFRvbWxpbiBhIMOpY3JpdMKgOg0KPiBD
dXJyZW50bHksIG9ubHkgdGhlIGluaXRpYWwgbW9kdWxlIHRoYXQgdGFpbnRlZCB0aGUga2VybmVs
IGlzDQo+IHJlY29yZGVkIGUuZy4gd2hlbiBhbiBvdXQtb2YtdHJlZSBtb2R1bGUgaXMgbG9hZGVk
Lg0KPiANCj4gVGhlIHB1cnBvc2Ugb2YgdGhpcyBwYXRjaCBpcyB0byBhbGxvdyB0aGUga2VybmVs
IHRvIG1haW50YWluIGEgcmVjb3JkIG9mDQo+IGVhY2ggdW5sb2FkZWQgbW9kdWxlIHRoYXQgdGFp
bnRzIHRoZSBrZXJuZWwuIFNvLCBpbiBhZGRpdGlvbiB0bw0KPiBkaXNwbGF5aW5nIGEgbGlzdCBv
ZiBsaW5rZWQgbW9kdWxlcyAoc2VlIHByaW50X21vZHVsZXMoKSkgZS5nLiBpbiB0aGUNCj4gZXZl
bnQgb2YgYSBkZXRlY3RlZCBiYWQgcGFnZSwgdW5sb2FkZWQgbW9kdWxlcyB0aGF0IGNhcnJpZWQg
YSB0YWludC9vcg0KPiB0YWludHMgYXJlIGRpc3BsYXllZCB0b28uIEEgdGFpbnRlZCBtb2R1bGUg
dW5sb2FkIGNvdW50IGlzIG1haW50YWluZWQuDQo+IA0KPiBUaGUgbnVtYmVyIG9mIHRyYWNrZWQg
bW9kdWxlcyBpcyBub3QgZml4ZWQuIFRoaXMgZmVhdHVyZSBpcyBkaXNhYmxlZCBieQ0KPiBkZWZh
dWx0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQWFyb24gVG9tbGluIDxhdG9tbGluQHJlZGhhdC5j
b20+DQo+IC0tLQ0KPiAgIGluaXQvS2NvbmZpZyAgICAgICAgIHwgMTEgKysrKysrKysNCj4gICBr
ZXJuZWwvbW9kdWxlL21haW4uYyB8IDY1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrDQo+ICAgMiBmaWxlcyBjaGFuZ2VkLCA3NiBpbnNlcnRpb25zKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvaW5pdC9LY29uZmlnIGIvaW5pdC9LY29uZmlnDQo+IGluZGV4IGRkY2Jl
ZmU1MzVlOS4uNmIzMDIxMGY3ODdkIDEwMDY0NA0KPiAtLS0gYS9pbml0L0tjb25maWcNCj4gKysr
IGIvaW5pdC9LY29uZmlnDQo+IEBAIC0yMTE4LDYgKzIxMTgsMTcgQEAgY29uZmlnIE1PRFVMRV9G
T1JDRV9VTkxPQUQNCj4gICAJICBybW1vZCkuICBUaGlzIGlzIG1haW5seSBmb3Iga2VybmVsIGRl
dmVsb3BlcnMgYW5kIGRlc3BlcmF0ZSB1c2Vycy4NCj4gICAJICBJZiB1bnN1cmUsIHNheSBOLg0K
PiAgIA0KPiArY29uZmlnIE1PRFVMRV9VTkxPQURfVEFJTlRfVFJBQ0tJTkcNCj4gKwlib29sICJU
YWludGVkIG1vZHVsZSB1bmxvYWQgdHJhY2tpbmciDQo+ICsJZGVwZW5kcyBvbiBNT0RVTEVfVU5M
T0FEDQo+ICsJZGVmYXVsdCBuDQo+ICsJaGVscA0KPiArCSAgVGhpcyBvcHRpb24gYWxsb3dzIHlv
dSB0byBtYWludGFpbiBhIHJlY29yZCBvZiBlYWNoIHVubG9hZGVkDQo+ICsJICBtb2R1bGUgdGhh
dCB0YWludGVkIHRoZSBrZXJuZWwuIEluIGFkZGl0aW9uIHRvIGRpc3BsYXlpbmcgYQ0KPiArCSAg
bGlzdCBvZiBsaW5rZWQgKG9yIGxvYWRlZCkgbW9kdWxlcyBlLmcuIG9uIGRldGVjdGlvbiBvZiBh
IGJhZA0KPiArCSAgcGFnZSAoc2VlIGJhZF9wYWdlKCkpLCB0aGUgYWZvcmVtZW50aW9uZWQgZGV0
YWlscyBhcmUgYWxzbw0KPiArCSAgc2hvd24uIElmIHVuc3VyZSwgc2F5IE4uDQo+ICsNCj4gICBj
b25maWcgTU9EVkVSU0lPTlMNCj4gICAJYm9vbCAiTW9kdWxlIHZlcnNpb25pbmcgc3VwcG9ydCIN
Cj4gICAJaGVscA0KPiBkaWZmIC0tZ2l0IGEva2VybmVsL21vZHVsZS9tYWluLmMgYi9rZXJuZWwv
bW9kdWxlL21haW4uYw0KPiBpbmRleCBlYTc4Y2VjMzE2ZGQuLjM1Njg2ZTYzYjMyZiAxMDA2NDQN
Cj4gLS0tIGEva2VybmVsL21vZHVsZS9tYWluLmMNCj4gKysrIGIva2VybmVsL21vZHVsZS9tYWlu
LmMNCj4gQEAgLTY4LDYgKzY4LDE2IEBADQo+ICAgICovDQo+ICAgREVGSU5FX01VVEVYKG1vZHVs
ZV9tdXRleCk7DQo+ICAgTElTVF9IRUFEKG1vZHVsZXMpOw0KPiArI2lmZGVmIENPTkZJR19NT0RV
TEVfVU5MT0FEX1RBSU5UX1RSQUNLSU5HDQo+ICtzdGF0aWMgTElTVF9IRUFEKHVubG9hZGVkX3Rh
aW50ZWRfbW9kdWxlcyk7DQo+ICsNCj4gK3N0cnVjdCBtb2RfdW5sb2FkX3RhaW50IHsNCj4gKwlz
dHJ1Y3QgbGlzdF9oZWFkIGxpc3Q7DQo+ICsJY2hhciBuYW1lW01PRFVMRV9OQU1FX0xFTl07DQo+
ICsJdW5zaWduZWQgbG9uZyB0YWludHM7DQo+ICsJdTY0IGNvdW50Ow0KPiArfTsNCj4gKyNlbmRp
Zg0KPiAgIA0KPiAgIC8qIFdvcmsgcXVldWUgZm9yIGZyZWVpbmcgaW5pdCBzZWN0aW9ucyBpbiBz
dWNjZXNzIGNhc2UgKi8NCj4gICBzdGF0aWMgdm9pZCBkb19mcmVlX2luaXQoc3RydWN0IHdvcmtf
c3RydWN0ICp3KTsNCj4gQEAgLTE1MCw2ICsxNjAsNDEgQEAgaW50IHVucmVnaXN0ZXJfbW9kdWxl
X25vdGlmaWVyKHN0cnVjdCBub3RpZmllcl9ibG9jayAqbmIpDQo+ICAgfQ0KPiAgIEVYUE9SVF9T
WU1CT0wodW5yZWdpc3Rlcl9tb2R1bGVfbm90aWZpZXIpOw0KPiAgIA0KPiArI2lmZGVmIENPTkZJ
R19NT0RVTEVfVU5MT0FEX1RBSU5UX1RSQUNLSU5HDQo+ICtzdGF0aWMgaW50IHRyeV9hZGRfdGFp
bnRlZF9tb2R1bGUoc3RydWN0IG1vZHVsZSAqbW9kKQ0KPiArew0KPiArCXN0cnVjdCBtb2RfdW5s
b2FkX3RhaW50ICptb2RfdGFpbnQ7DQo+ICsNCj4gKwltb2R1bGVfYXNzZXJ0X211dGV4X29yX3By
ZWVtcHQoKTsNCj4gKw0KPiArCWxpc3RfZm9yX2VhY2hfZW50cnlfcmN1KG1vZF90YWludCwgJnVu
bG9hZGVkX3RhaW50ZWRfbW9kdWxlcywgbGlzdCwNCj4gKwkJCQlsb2NrZGVwX2lzX2hlbGQoJm1v
ZHVsZV9tdXRleCkpIHsNCj4gKwkJc2l6ZV90IGxlbiA9IHN0cmxlbihtb2RfdGFpbnQtPm5hbWUp
Ow0KDQpXaHkgZG8geW91IG5lZWQgdGhhdCBzdHJsZW4oKSBhdCBhbGwsIGNhbid0IHlvdSBqdXN0
IHVzZSBzdHJjbXAoKSA/DQoNCldpdGggc3RybmNtcCgpIHdoYXQgaGFwcGVucyBpZiBmb3IgaW5z
dGFuY2UgbW9kX3RhaW50LT5uYW1lIGlzICJkZWFkIiANCmFuZCBtb2QtPm5hbWUgaXMgImRlYWRi
ZWVmIiA/DQoNCj4gKw0KPiArCQlpZiAoIXN0cm5jbXAobW9kX3RhaW50LT5uYW1lLCBtb2QtPm5h
bWUsIGxlbikgJiYNCj4gKwkJICAgIG1vZF90YWludC0+dGFpbnRzICYgbW9kLT50YWludHMpIHsN
Cj4gKwkJCW1vZF90YWludC0+Y291bnQrKzsNCj4gKwkJCWdvdG8gb3V0Ow0KPiArCQl9DQo+ICsJ
fQ0KPiArDQo+ICsJbW9kX3RhaW50ID0ga21hbGxvYyhzaXplb2YoKm1vZF90YWludCksIEdGUF9L
RVJORUwpOw0KPiArCWlmICh1bmxpa2VseSghbW9kX3RhaW50KSkNCj4gKwkJcmV0dXJuIC1FTk9N
RU07DQo+ICsJc3Ryc2NweShtb2RfdGFpbnQtPm5hbWUsIG1vZC0+bmFtZSwgTU9EVUxFX05BTUVf
TEVOKTsNCj4gKwltb2RfdGFpbnQtPnRhaW50cyA9IG1vZC0+dGFpbnRzOw0KPiArCWxpc3RfYWRk
X3JjdSgmbW9kX3RhaW50LT5saXN0LCAmdW5sb2FkZWRfdGFpbnRlZF9tb2R1bGVzKTsNCj4gKwlt
b2RfdGFpbnQtPmNvdW50ID0gMTsNCj4gK291dDoNCj4gKwlyZXR1cm4gMDsNCj4gK30NCj4gKyNl
bHNlIC8qIE1PRFVMRV9VTkxPQURfVEFJTlRfVFJBQ0tJTkcgKi8NCj4gK3N0YXRpYyBpbnQgdHJ5
X2FkZF90YWludGVkX21vZHVsZShzdHJ1Y3QgbW9kdWxlICptb2QpDQo+ICt7DQo+ICsJcmV0dXJu
IDA7DQo+ICt9DQo+ICsjZW5kaWYNCj4gKw0KPiAgIC8qDQo+ICAgICogV2UgcmVxdWlyZSBhIHRy
dWx5IHN0cm9uZyB0cnlfbW9kdWxlX2dldCgpOiAwIG1lYW5zIHN1Y2Nlc3MuDQo+ICAgICogT3Ro
ZXJ3aXNlIGFuIGVycm9yIGlzIHJldHVybmVkIGR1ZSB0byBvbmdvaW5nIG9yIGZhaWxlZA0KPiBA
QCAtMTIwMSw2ICsxMjQ2LDkgQEAgc3RhdGljIHZvaWQgZnJlZV9tb2R1bGUoc3RydWN0IG1vZHVs
ZSAqbW9kKQ0KPiAgIAltb2R1bGVfYnVnX2NsZWFudXAobW9kKTsNCj4gICAJLyogV2FpdCBmb3Ig
UkNVLXNjaGVkIHN5bmNocm9uaXppbmcgYmVmb3JlIHJlbGVhc2luZyBtb2QtPmxpc3QgYW5kIGJ1
Z2xpc3QuICovDQo+ICAgCXN5bmNocm9uaXplX3JjdSgpOw0KPiArCWlmICh0cnlfYWRkX3RhaW50
ZWRfbW9kdWxlKG1vZCkpDQo+ICsJCXByX2VycigiJXM6IGFkZGluZyB0YWludGVkIG1vZHVsZSB0
byB0aGUgdW5sb2FkZWQgdGFpbnRlZCBtb2R1bGVzIGxpc3QgZmFpbGVkLlxuIiwNCj4gKwkJICAg
ICAgIG1vZC0+bmFtZSk7DQo+ICAgCW11dGV4X3VubG9jaygmbW9kdWxlX211dGV4KTsNCj4gICAN
Cj4gICAJLyogQ2xlYW4gdXAgQ0ZJIGZvciB0aGUgbW9kdWxlLiAqLw0KPiBAQCAtMzEyNiw2ICsz
MTc0LDkgQEAgc3RydWN0IG1vZHVsZSAqX19tb2R1bGVfdGV4dF9hZGRyZXNzKHVuc2lnbmVkIGxv
bmcgYWRkcikNCj4gICB2b2lkIHByaW50X21vZHVsZXModm9pZCkNCj4gICB7DQo+ICAgCXN0cnVj
dCBtb2R1bGUgKm1vZDsNCj4gKyNpZmRlZiBDT05GSUdfTU9EVUxFX1VOTE9BRF9UQUlOVF9UUkFD
S0lORw0KPiArCXN0cnVjdCBtb2RfdW5sb2FkX3RhaW50ICptb2RfdGFpbnQ7DQo+ICsjZW5kaWYN
Cj4gICAJY2hhciBidWZbTU9EVUxFX0ZMQUdTX0JVRl9TSVpFXTsNCj4gICANCj4gICAJcHJpbnRr
KEtFUk5fREVGQVVMVCAiTW9kdWxlcyBsaW5rZWQgaW46Iik7DQo+IEBAIC0zMTM2LDYgKzMxODcs
MjAgQEAgdm9pZCBwcmludF9tb2R1bGVzKHZvaWQpDQo+ICAgCQkJY29udGludWU7DQo+ICAgCQlw
cl9jb250KCIgJXMlcyIsIG1vZC0+bmFtZSwgbW9kdWxlX2ZsYWdzKG1vZCwgYnVmKSk7DQo+ICAg
CX0NCj4gKyNpZmRlZiBDT05GSUdfTU9EVUxFX1VOTE9BRF9UQUlOVF9UUkFDS0lORw0KPiArCWlm
ICghbGlzdF9lbXB0eSgmdW5sb2FkZWRfdGFpbnRlZF9tb2R1bGVzKSkgew0KPiArCQlwcmludGso
S0VSTl9ERUZBVUxUICJVbmxvYWRlZCB0YWludGVkIG1vZHVsZXM6Iik7DQo+ICsJCWxpc3RfZm9y
X2VhY2hfZW50cnlfcmN1KG1vZF90YWludCwgJnVubG9hZGVkX3RhaW50ZWRfbW9kdWxlcywNCj4g
KwkJCQkJbGlzdCkgew0KPiArCQkJc2l6ZV90IGw7DQo+ICsNCj4gKwkJCWwgPSBtb2R1bGVfZmxh
Z3NfdGFpbnQobW9kX3RhaW50LT50YWludHMsIGJ1Zik7DQo+ICsJCQlidWZbbCsrXSA9ICdcMCc7
DQo+ICsJCQlwcl9jb250KCIgJXMoJXMpOiVsbHUiLCBtb2RfdGFpbnQtPm5hbWUsIGJ1ZiwNCj4g
KwkJCQltb2RfdGFpbnQtPmNvdW50KTsNCj4gKwkJfQ0KPiArCX0NCj4gKyNlbmRpZg0KPiAgIAlw
cmVlbXB0X2VuYWJsZSgpOw0KPiAgIAlpZiAobGFzdF91bmxvYWRlZF9tb2R1bGVbMF0pDQo+ICAg
CQlwcl9jb250KCIgW2xhc3QgdW5sb2FkZWQ6ICVzXSIsIGxhc3RfdW5sb2FkZWRfbW9kdWxlKTs=
