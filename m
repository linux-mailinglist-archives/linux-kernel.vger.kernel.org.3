Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD569547ABB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 17:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234591AbiFLPVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 11:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbiFLPVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 11:21:08 -0400
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120050.outbound.protection.outlook.com [40.107.12.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74AEB5B3D9;
        Sun, 12 Jun 2022 08:21:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O6YyL4tTecSpD0J8hFQkjhkb/NK0J6JwMz3Yf5b7Rktq2C5HA7abATdzTdBY05FBSEylb9nAO0XBnzaTRX5Jmnh674p/pllNgPsK1Z/b/QFfHEfDNu3I8NwQ/0AiEy52tUgWOyj3zKzikmSVj5LP/K4icC3l7HXM8U3O7ZfVqfwgD6u713YTE0TX0SnIBfntadN89hmGU6yU6XoGNmZz04p3HYRKepHJzmjGzV1twf1H6M3PMk/hVD8SicuffYE51nKB/4//GD2XbS4Jhn3GwFDCBFxEWigJjl9vJX3tLh/34/ELycYOlzcDUX4oaKBd0/hGm+6j5Q71XGJb++hlWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFJGEf7gNZo89F6NhN9r4P6v24Q1fYnnxzhLqQTtRSw=;
 b=X2wQ5vzUrh/DcmS0GsOtljv9u/i0pbGI5z1PoFY+64z2F99kSA7Edakfjh1CkAigXRUsmdS+lwSUAHOD+uy9bkaLTcbdNl6+Mk9ysGeGzeuwQ2wDN1T6Ir4VafsusaCrdNcR0pDP0/xKzcrdLlUbwBZzM9uvyN1ZXGRNBda5YbA5hzv8rUIpOZ/DgQJeJokRwR/bXJSdNu6ziLwrzv3lS+SJLHzci43tBw8O5LMXda4xy/YTz2F13snLSu/EIQJQOwGr9xORI+8i4KATZv1/B/J+RalYuOzlF8XRd9cKgNh3NbHsggL/SglcsjWxb8NFjWU6sHOMggZcSbugS3eCFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFJGEf7gNZo89F6NhN9r4P6v24Q1fYnnxzhLqQTtRSw=;
 b=G8RVcbnlkkvqaoFacY4QjhktLHbUFzU2/XO/S+IphRrvObEnctKYQTsG4xZufh3dzVMfZJcMVd2Bd+M+Ohd/6WO/Y/q0M9uh0Iu7HhUvBD8Ev/SyN161sqVat4TYz/CmV4AnXv2+/N24U+W+FgJ/16BqZYpSvHfi7zrZZswVgXf6XlQ4vuXK1kcwuv7bOKE+I8sjWP9vhEqDP1RkA8kRBEMCwAoSnf/UDgWPTvKxrQ74+9Yut2O4Tck7CGybpWri7OLMOefdjBP3smyQ9E1mCz+le53IGwM5MC0zNuEpTsAtYwgUSjR3x6Idr9qt8axKpMP+lHr3Nyf4GqA1xe6zag==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PAZP264MB4062.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:112::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Sun, 12 Jun
 2022 15:21:01 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b15e:862f:adf7:5356]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b15e:862f:adf7:5356%6]) with mapi id 15.20.5332.020; Sun, 12 Jun 2022
 15:21:01 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Alexey Dobriyan <adobriyan@gmail.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Subject: Re: [PATCH] module: Fix selfAssignment cppcheck warning
Thread-Topic: [PATCH] module: Fix selfAssignment cppcheck warning
Thread-Index: AQHYfkmz7EtWIXEgh0i4YqdyVNpNc61L43cA
Date:   Sun, 12 Jun 2022 15:21:01 +0000
Message-ID: <05674791-41e7-d701-0dad-8577229849ba@csgroup.eu>
References: <YqXEDCzsYvDKsgQa@localhost.localdomain>
In-Reply-To: <YqXEDCzsYvDKsgQa@localhost.localdomain>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fc0f9df2-e58a-4314-a6aa-08da4c8728e0
x-ms-traffictypediagnostic: PAZP264MB4062:EE_
x-microsoft-antispam-prvs: <PAZP264MB4062FD4F1BCE11BF635EA1E5EDA89@PAZP264MB4062.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: w98u8wsjKtwVN4PtkNJzDMg4VLPFjInuvxmh0M/k3t7Kz85+1jV/br2tbIU0TWv1lASYFoyFgXaDmiSELW3hLzE3/BdVwHEhhW1y1y9fu4PkriRJ/W0Je/FcRZBmA63jbvwLIisiJOJ7bquJ+aChViR2w7FFrpzpGCM18m4YGibw6iyiM+p2m/oRfJ4IaeLcXDYnQw7gwgZfbYc5Ju6aUFaMp7VA5nQO8K3WJ2vfs/489t9PxexDAgNpj9mJyqe6BfJlfsGm4lAxC6BygB9mgt5j1DgzAz5JQ8epJR/XPcITmrbLkjU/PaGUFo082mqwT+NI9Ay21BhFY5BrWSvur1EcpX45uZEGCSJ6k//FoIQ2LXbBK4aTGIdjEcCoOOskwRmYv6EnSQkb8svZ05hiS9S1sQaXwVZofs8z++FAmJpTYnQMWz+OI/kHDp/erGmd4br10R/IIcHUaZFGXFkGA5SbsoQ1wZU7xuDREYX6L71hPac7UQpQ0aB8NUXRy6AdJiud+I03Xp3T/lYRnTdtWgwXIQRjHdGAL0KGW3S8dNR2ayzHU+p987JWBLT4365r1eQkFqrYxUt/ScCCqmLfNYc+GIbW9gh133uKSbnuwlx4mo2er3mPcFfO4LzQPxIfYzTKYQWoaPBe1WokKZxR4SCk/E7Zzn4FrOkHAu4kxQVZ6Vb3qm19egErXYWpJFdW4nb8YhK7uotuVzilxgrHEIJInNlZlbwmKVSbSfxxh/hyOIEMUaRA0cnm1mg6pavnFJkOqel8yCoMAar4VxgSJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(8676002)(38100700002)(122000001)(6506007)(6486002)(31686004)(6512007)(26005)(8936002)(66446008)(91956017)(64756008)(38070700005)(66476007)(76116006)(54906003)(66946007)(66556008)(316002)(2616005)(36756003)(6916009)(66574015)(4744005)(83380400001)(71200400001)(186003)(508600001)(4326008)(2906002)(86362001)(5660300002)(31696002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bXZsSHZWQ1pZekhDMitGU3ZQczdhdVhmQjJZM0RucWpsODJIS3NiNXc2UzNR?=
 =?utf-8?B?bDMxSWZQVENNc0h4ZlpMRjFqcGVHc3c0aXNxYmhKVXJydlpxQWUrREd6NVBj?=
 =?utf-8?B?Mk41aVVITEY1UGhvUkliMVVPNDhoVGZ4YjdScVMrakpYMnpyNENaSzJhS0E0?=
 =?utf-8?B?eTJJaDdtZVpneXBoRXA5YUNPVWxKcVlETDgwNVlUVGk3d09ET3E0M1lla1lK?=
 =?utf-8?B?elhUSG50RisvdjBXQTJrRlV5NGYwbWh2MXNLaUdua3dhRElBdFBSQ08rS0Nv?=
 =?utf-8?B?Vit3QUZnZWVSQlcvaHFlWjgxdHZGVHdwSDZscngzVklEMGJuM09UM0M1YmdL?=
 =?utf-8?B?UlJFZHpPc25HMXk3SjJuNTkzeGZDOWF5SVhtMW1CWmFtaHZ1QlRIRy9yTHdz?=
 =?utf-8?B?NmFJMnFjUmpqMThQMEduSUZnY3pJOW5NSzU0WHByTnVpYm5sbnhaNi83Wk5k?=
 =?utf-8?B?ckVQRnVDYVFpaVJRM1R0L2dNVmRHWVZPUEZDcEZCNG5OOHhVUkpzcVJkRzRN?=
 =?utf-8?B?T3dibG4vVkpqaVNwOXFJei9ZT2tIN3JtTmF6QkFzL0ptVWFqWU1ZYmRWVEFY?=
 =?utf-8?B?R0NFNFdVWi9FZmZSeXJ2STZXMHhBelRQYTR5bTdXNEY2OE9uMjluRUdabk5l?=
 =?utf-8?B?cW5ZRFNUVlhKRk1VZkhGeDQyNThCeTlhOGdZK3R2b0J3dWtZT0M2K1lnUlNN?=
 =?utf-8?B?UENhMHBMbWYxMmhnaG9WaTlmU1NjdkF5a1htMHVRZWlTYWJlc1kvWHM1bDRt?=
 =?utf-8?B?M2t3VW5CcUhHckZXaUg2YUxpNmR4U3RLaDFpTmNWMXM1ZVRZYUxVSEdZc2VT?=
 =?utf-8?B?MzIrTGJORmVzODlGWmZ1dzdmQVUzSm1MNXloWlBWWTNES3dCK1cwSmUyNy9Z?=
 =?utf-8?B?a0NwYmdzS0FtMUE0S2x0NkZTY2p3ZDBkVWw4NkpybU52QWtzVEU0VU4zYitB?=
 =?utf-8?B?SlVkYXhWdi8yM1VKZWNLK0RvN1NaQ1NxbDBsTGFYYXN3aUgzRTNlSXpnYmxh?=
 =?utf-8?B?RFlhbHJyUWhRWVZ4WEdpL0cyb3hrUWlzaG84dHlDdXI4dGJvVTlKb1hvK3li?=
 =?utf-8?B?SjRlb1QvTERJTlRNQUVjWDJaeXdkYUU2bmJ4YXh4NlZsLzFpdGpKMEgzcnI0?=
 =?utf-8?B?elRqWHVHZHRaNnQ4UVE2anNSNU5ST1JFTENwN1lDM2Ztd1FzU0NYeEtGYTZs?=
 =?utf-8?B?MjJEYU41LzAyUVhibGNJYzZVZEFSckY4LzRGb1JvQjY4NXQ4cXlDWStlRHZR?=
 =?utf-8?B?YVh5RTFuNjQ3OWE3cHY4Q1B0dnBMMEgyS3hZM2N4ZTFra2x5ZHZSWmRyMmdW?=
 =?utf-8?B?cEl1cjYvdkhOWlllQ3ZsVXlwcERKQVZROXVLUEU3L1owaElPT2hHYlBrL3FC?=
 =?utf-8?B?MldTT0ZkTkNiMjFOZjdPK25EbFdtT2E5Q1lOcTBrVXNVeFA2ZzY0NFMrTVMv?=
 =?utf-8?B?VXBteE45TUdwT21nWHB6K0JLckc4bFYydEFtR0ZFdlNHZkkyd0hpUHo2TW8v?=
 =?utf-8?B?L2p6cmpwSEZtNDhmdmt1c015V3lHVmFESzZ1Y1ZXVmFPZFVhZit5Z2VMYmJq?=
 =?utf-8?B?ZE1GcS9ZNWk0ckdKMG9wRjVVcFoyOWcvZlpWczY5UGN4bkFRTU1ZSXVmanJx?=
 =?utf-8?B?RnpwUW5FTEZXTEJIMzhrMktucUlDV1J4V0F4Mk1SN0g4aFRXYmI3bHNrbGdo?=
 =?utf-8?B?ang3WWxYS1lXcmcvVTNzR0VUdUdQbmtIKzRHSHNEUmNCSmxDTVFCK1RRZ2Nu?=
 =?utf-8?B?OGJWREd2ZE9oallRcnVGbjdWZXZOajRLVTZJZnVhd2pHV1ZiZ0lxVGdhN2FK?=
 =?utf-8?B?VURvUWlrSlpuSWVmcjl6TS8vN2Uyem1OTXVKSTJ6R0t0Zk1lbEIvTVdEdVpG?=
 =?utf-8?B?RUthbFU5Wk53NXM1ckhDQkw0ejB4YzhBQXl5MTU5clZBak1IU1NkbHVrUWtZ?=
 =?utf-8?B?U3VxRjRKRU43RUFZTFkxeHVyaEhZTTYwbmNIcTJMSERoMm5wNU95SExlRm1z?=
 =?utf-8?B?VU1CSmsrWjhFMU9yZVF3eFN3ako2bkpNWkpCeHNnT25vTjIveDNDSlFscGNS?=
 =?utf-8?B?QUZEOEJOdnF6S3FUeDVDdVNrSVdNSktScFNuOEQ3SFZoNkRvbXNEYWZDMk5o?=
 =?utf-8?B?bElRbEo5UzZQbUtoREpXZkw4QXlFSThDbnFqNm42V2JKT2ZlQXFIZy9tTmdR?=
 =?utf-8?B?ekVodks4NDA4WTl4ZlFCczhyTDhXbkpGZTI3NDhHbjFmNGY1ejlVaUpESTMv?=
 =?utf-8?B?ODdpc1NFcFRUVkVhU3prTjFpTkZkVTRyaGVNcDdrdEtOTjd6YTNMOE44S0ln?=
 =?utf-8?B?eW51a3pWQzZoV0hLa1M4d1A2aVNwQUJ2aGQweWdJemJaY3lPNW1GVlF3R3Vz?=
 =?utf-8?Q?d/Xxj4uAQqpJAxlcg8ame1TzU7T6fSNoqtcjg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <39F12362CEBA44429641615F0E732783@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0f9df2-e58a-4314-a6aa-08da4c8728e0
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jun 2022 15:21:01.5828
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3wikOJgt5i87IBcBKvVE6AEVmNqDETq+ReQYo2WK+PMtNc5AqoCuuem7EsNKiBe+alXphA2/BpDv3llEkCyKFWbmt8t8b3oRBaj+DmV/CKM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAZP264MB4062
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCkxlIDEyLzA2LzIwMjIgw6AgMTI6NDYsIEFsZXhleSBEb2JyaXlhbiBhIMOpY3JpdMKgOg0K
Pj4gQEAgLTMzLDcgKzMzLDggQEANCj4+ICNpZmRlZiBDT05GSUdfU1RSSUNUX01PRFVMRV9SV1gN
Cj4+ICMgZGVmaW5lIHN0cmljdF9hbGlnbihYKSBQQUdFX0FMSUdOKFgpDQo+PiAjZWxzZQ0KPj4g
LSMgZGVmaW5lIHN0cmljdF9hbGlnbihYKSAoWCkNCj4+ICsvKiBPUiB3aXRoIHplcm8gdG8gYXZv
aWQgY3BwY2hlY2sgc2VsZkFzc2lnbm1lbnQgd2FybmluZyAqLw0KPj4gKyMgZGVmaW5lIHN0cmlj
dF9hbGlnbihYKSAoKFgpIHwgMCkNCj4+ICAgI2VuZGlmDQo+IA0KPiBDYW4gdGhlc2UgbXlvcGlj
IHRvb2xzIGJlIHRhdWdodCB0byBzZWUgYXJvdW5kIGFuZCBub3RpY2Ugc2Vjb25kDQo+IGRlZmlu
aXRpb24gd2hpY2ggZG9lcyBtdXRhdGUgdmFyaWFibGUgc28gdGhlcmUgaXMgbm8gc2VsZi1hc3Np
Z25tZW50Pw0KDQpJIGd1ZXNzIG5vdC4NCg0KSG93ZXZlciwgdXN1YWxseSB3ZSB1c2Ugc3RhdGlj
IGlubGluZXMgdG8gYXZvaWQgdGhhdC4gSSdsbCBzZW5kIHYyLCB3aWxsIA0KYmUgY2xlYW5lci4=
