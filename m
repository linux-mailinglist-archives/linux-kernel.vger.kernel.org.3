Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7404C84AA
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 08:07:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232574AbiCAHIV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 02:08:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbiCAHIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 02:08:15 -0500
Received: from FRA01-PR2-obe.outbound.protection.outlook.com (mail-eopbgr120043.outbound.protection.outlook.com [40.107.12.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80EBE2C;
        Mon, 28 Feb 2022 23:07:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dk3EPYZs7P10K4n4V21E8Sam7FB3Li5PJdwszzx22W6pNBbl9t2jPjeGlACj1hK7IomSY8QQSPN1HiEEuIkWEdttXQkbT4HKDNFeBGsSGIyVXAH88L9gNBxsfDO50WUOe5FbfupHuUG0kRd6i/mlZ8RPQ6bShwUeZxhu5xjOHacbMF/xtyLfBEYye9qWzr5dylh7vH0tmnhy1BAzBJVpO7uZfcJRsC0kGHehcwul7RkF+1skoBgxnSmwM+Hzt4Sgt713i1B4LrXMVN3N45eOgZ3vkt0dgrd+JdqbNpMbupPQCyCH2L8AMH2psotqJDSuXCGqWPZjos3ih0Cs79WjnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVz/SQH8MzZ2RLfFj7tpVGUNnh5XexfNp/s42rO7lSY=;
 b=V5lxT45VORvfkIljQDcTP7WzzVYNrUj3cA6F1Pd2054fBpw2FlydAO8vtJxaMcKMDGbPlxPj+XMFxbidAGcahAjs49cWM8gSr/SMUvnrhcHeotc+SZfd2rtwSsAsCgSBL3xadstb57zW5xbVGMsKg1R9lFQOUNvYzc3H0BdW5p/Fbd6xnO/NBgpc5j8mBmGR4g8JSOYR5xTdAdXJa4j+emRfjXNhrZvAZCnFE5M4GVUxXbGVT6sNc/dmV90LLUyP53RooBGNmCT5cYnQyAsfczeihJwk/niwfdDIT/1aGOjcd4LyJmYITgZRzNjttbBIxihEcC6S7vOsOuUe5OsSqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
Received: from MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3d::7) by
 MR1P264MB3154.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:3b::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.13; Tue, 1 Mar 2022 07:07:30 +0000
Received: from MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b4e1:6a58:710c:54f3]) by MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
 ([fe80::b4e1:6a58:710c:54f3%6]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 07:07:30 +0000
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Aaron Tomlin <atomlin@redhat.com>
CC:     "pmladek@suse.com" <pmladek@suse.com>,
        "cl@linux.com" <cl@linux.com>, "mbenes@suse.cz" <mbenes@suse.cz>,
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
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>
Subject: Re: [PATCH v9 00/14] module: core code clean up
Thread-Topic: [PATCH v9 00/14] module: core code clean up
Thread-Index: AQHYLPz9dCjYVwicx0iy9EhVniO5RaypqrEAgABxW4A=
Date:   Tue, 1 Mar 2022 07:07:30 +0000
Message-ID: <6b6e02be-2d0a-31df-8375-baf79714d5b7@csgroup.eu>
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <Yh1nGtM7MCMOI++l@bombadil.infradead.org>
In-Reply-To: <Yh1nGtM7MCMOI++l@bombadil.infradead.org>
Accept-Language: fr-FR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6344341b-4d25-41dd-5bd2-08d9fb522696
x-ms-traffictypediagnostic: MR1P264MB3154:EE_
x-microsoft-antispam-prvs: <MR1P264MB315424B1C06D96DF5BFCBA59ED029@MR1P264MB3154.FRAP264.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MgUKKg5e+kdr1bCJZhCQfniMLLioiyJBUpTdMaDLuC5vuiyrd4+F6/xnUM2eID/W/WyrWnRRJfw4RiEgDBOyyQOd1mDwNMfi4l8xPjEsHOXxerv/fT6ZW3b42u/HA/d93Hwf/I+qjzv8kkhofficgcsKi/Cwj8NbUoE5JOFKlCRzM83d0EK+dgS07hKDe7pktHLTFT41e5M5mqFcynJdDs74X8w7PVyFv0x6abeuGeDU7fD2dp0br8IjsyOqquK9KLatSTnAdmy1+8snL9lpb+6WiLk/NL6mkxxrUqStWpuNz3XQOLwJY0PYJ3F6TcnpH8J9r9mW0W+oOAzxHaCenTc3l8mcC2+i2vy/Yv/IjO8Roqhj20bZluw6gl9fh0WhcTZKqK8yujHtFx8S6Z7U9drltJRzDU0XMrFJuQpwP6sAn8BcWM1i7BEncW+rlmC1JgF5XRBTgY8XdEDX+yFP1sEb/EAJ//voG2f6c8BsXiEzAPYZO0S7OIWi9BOgnHSQIoD239NiOOIrLs6ol3BB5rRCFojx13Xm7igGOubJia5TcqjKSb14WpwabyYMORmsxKj67HhaSA91ZavK9ECkzPP9lK4rMF9tsXupVnH1r4r4l30TthAdnAPnOE8NuuJ9F0iFPYNLg6pMYXZWXp0L7DZbfeNlL1j7mqL08Ln60GImNNirlXQzZ4nionJkqD+9DZgWND3p5rZIaXfBDL/TPvewPKYhe/no5eNM7Qtq1+BJefYcUWWrty2rEaqy+UBoPfGwbwK+VNcGvfNhfCpdQA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(76116006)(6486002)(64756008)(36756003)(38100700002)(316002)(66476007)(66446008)(66556008)(5660300002)(122000001)(6506007)(8676002)(31686004)(86362001)(4326008)(7416002)(31696002)(186003)(91956017)(26005)(2616005)(8936002)(508600001)(54906003)(110136005)(44832011)(71200400001)(6512007)(38070700005)(4744005)(2906002)(66574015)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VFhTb1QrSEYxQnV2dUdML2RyeHh3TVJnR2tPb2NSOHRzWUl5S2pWRkFhd1BW?=
 =?utf-8?B?Ri9RL0JFYk8yRHBOd2d5V0NzL2lvVW0rV3NLMFRJRGpWaHNYSVZxZC9LSWRs?=
 =?utf-8?B?OHRORm9TSXozQlRQQnlTdlhMSFA2VCtmdzB4T25HSVBuM1FIS3AvUTgzYklV?=
 =?utf-8?B?dk93RkYwamY3Y2FpM2RWMVBnSm0rcTVHcG83UEhOZFpEaXBYSzA1M3hPd1Vi?=
 =?utf-8?B?RGdIeDNJT0pHNTRucHFnbXpNdTlSQ3RlenpndVhlM1V6alJRSnNQZ1IxeVRF?=
 =?utf-8?B?bnBJTk4yTHNMZ2kyR0haSVdFU1BhaWxXUUcxRm9jbkxBbkJDQ0tzdlJtTGU2?=
 =?utf-8?B?eVR3NmQxWDlkd0JYVWxYaDhEb0FMR2pleHVER2VzdmZmcnlnakZlQWdlZG9X?=
 =?utf-8?B?ZzkxR0tuSmJndkUvUnZWdytCeS9xSW5lU2RhR0orVjlGdmdkZ1htc292UGZU?=
 =?utf-8?B?a01DbjVscWFZdmZ2Z0FBTnlqL09uOGtUMnppVXNFKzI0Vms1aTB1V2tJaXZS?=
 =?utf-8?B?TFpWSjFsT0VLcldtKzAzSVJLVzVDbU9ERG5GUzZNL3E5SXRicDhpK0lheEJy?=
 =?utf-8?B?N2pLVXFPZmY0RHVVVEgvQlNUYVBudkROSlNSOTVJRkdZMm03akRDRFNodEJM?=
 =?utf-8?B?ZlhFQzRISWJHV0J1NGFJK1ZuTzhoVDhIVmMyQ2xJeTlzOG1QZ3hhdmRCQ21P?=
 =?utf-8?B?bzBIQWxaUi94M0Zoa0xsQ3VTN2xsV1V5OCtTak1KOWU1eFMwU25jcVNUR0Q1?=
 =?utf-8?B?S0NrZk1qcldmenBtVTdZWlRHc0FSM1ZxT080c2hYcVVkdTZjRzNncXBtZ0RI?=
 =?utf-8?B?bnpVNXQzQVV4eEVFL3FPRVdMSXBzT01vQm1aOWF5R3hQZEZ0Y2FMNkw0OUN2?=
 =?utf-8?B?OFUxRXlMS2Irb3JGdnAwV0p0MGk1Z0xoT2ZOYldBbWpZMWJwaVQxR2dZb0VD?=
 =?utf-8?B?eTBBRFRVS3pZN004Z0pmK0ppcHA5bGc5QnpUemZuVnRSUXRBZ1FOenRNam5Z?=
 =?utf-8?B?VzBGOXdpdUJlczgxT1dRK0p3QW5xUEhpZGdkV2dVanZVWVpSL0JXbDRUV29N?=
 =?utf-8?B?Zmh0NmhDd0xFR2IxRTlCZnNpQ1dZZXNSTURqTnB5MDAwRUtxTlVOQUxycHQ3?=
 =?utf-8?B?emh6ZGhEbUVJN003dVZNVXExRldBOUZpQlNaell3b1h0MFBQSjdRMzI0WFph?=
 =?utf-8?B?OGVPdEtKemU3UUV5ZndZV3ZyZmVVRkp3M0p2b08yR0tuMC92Mm5Ybk4vUmZE?=
 =?utf-8?B?WTlxekxiR290OVFHODQyUzJoVGZnd0hNNHF5eDZWR3IwMlRNcnlwWEUxVjJZ?=
 =?utf-8?B?YkNMNytRMElwQllhdVlFOEF5cmxlUHBNOWlpclY1YTRKdmdISkp3Z2tSbVRy?=
 =?utf-8?B?TXI1OHErUm1kR1k4WW1NMStSelBOLzFtZm96U1FUZUxYbzZaMWpSUGVkcGsw?=
 =?utf-8?B?TmFIODR6bEQ1R3Vycmk5a2JnNG9VMkdYMEVmckkwN0J5VW1QQXVQbWdwOGY3?=
 =?utf-8?B?NmNMRTFwNTVTZWZJRHJ3eGlpTDN0Mkd6eUtsTXJWYm45Z2hNRUhJL0cyZ2ZY?=
 =?utf-8?B?a0xjMkc5Z3htaGI3WnJJcUpPVFpXUFY1d3JqN1A2WmNYSGhkT3N3eDN2bmdq?=
 =?utf-8?B?VHRUbW9NZ2ZpYlRpZFNqZk9ac2oxN3NZdXhsb1dGNUt3SjR0cnN1UWR1bDFv?=
 =?utf-8?B?aHpXRklKTFFvSVdYS2NnV3FQM3VPN1pQUDU5YzZnVEQxdHRuRjJsVTRKNGJK?=
 =?utf-8?B?bVc3M3c3czg1N3owb3ZPR1A2M2FQZ2s0YW02MktjUFRPZERWN1E5VDdiNCtR?=
 =?utf-8?B?T1ZITjMzM3B2dm1NU2tra2JLSlFSVXN4VUtBMytMSHg0clNwZnpyK3JEUktX?=
 =?utf-8?B?enYvYk14Q0JocERGMERKREgzNUFGVDBIWCsrT0R4bDNDMCtXMHE5b2VaUmJP?=
 =?utf-8?B?WWx5TlRFcjkxZnRMNDFlT253UEZPQ2RsR010RVJ5RlhqWTdsalNpNDdrZ05E?=
 =?utf-8?B?QVBGN3ZyWjNwUDF6MG8rU0tSYXBJUEJQNWgxeGR2REdLWGtmbnhaYURldStq?=
 =?utf-8?B?TG5YSmpMb2FReERlMjRwSktreGRscEVkNHhGaW0wQVJsUThxTm1leXhlV3JD?=
 =?utf-8?B?cjl5UEU3L0F4VUFkMDhQeTNpNnAvbjM4Rm1zVWlDTjF4UWtYQzRuTG1WMWFl?=
 =?utf-8?B?d295MUdSMDhZaWVMTlV2KzNaU3h5aHNpUzlwWDVaRFJsVVJGZGUyVElLcUIv?=
 =?utf-8?Q?6pkbLKmrNiUQYtETmTaXi64iP//BwKS2F9z9BakWaU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7D853E126F64454EAFCEF3504212F0B7@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MR1P264MB2980.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6344341b-4d25-41dd-5bd2-08d9fb522696
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 07:07:30.2132
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rGTMFl6e42hRt/nc8z1hfbIwBd91mnncXvYszsTKBg7YIfuknQzc21/4Tfr0ImQXaBzRRgFBtSJWJfSUYBvOZi6jxb+1MCXie2K2dt2s/BQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MR1P264MB3154
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTHVpcywNCg0KTGUgMDEvMDMvMjAyMiDDoCAwMToyMSwgTHVpcyBDaGFtYmVybGFpbiBhIMOp
Y3JpdMKgOg0KPiBPbiBNb24sIEZlYiAyOCwgMjAyMiBhdCAxMTo0MzowOFBNICswMDAwLCBBYXJv
biBUb21saW4gd3JvdGU6DQo+PiBIaSBMdWlzLA0KPj4NCj4+IEFzIHBlciB5b3VyIHN1Z2dlc3Rp
b24gWzFdLCB0aGlzIGlzIGFuIGF0dGVtcHQgdG8gcmVmYWN0b3IgYW5kIHNwbGl0DQo+PiBvcHRp
b25hbCBjb2RlIG91dCBvZiBjb3JlIG1vZHVsZSBzdXBwb3J0IGNvZGUgaW50byBzZXBhcmF0ZSBj
b21wb25lbnRzLg0KPj4gVGhpcyB2ZXJzaW9uIGlzIGJhc2VkIG9uIExpbnVzJyBjb21taXQgNzk5
M2U2NWZkZDBmICgiTWVyZ2UgdGFnDQo+PiAnbXRkL2ZpeGVzLWZvci01LjE3LXJjNScgb2YNCj4+
IGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9tdGQvbGludXgi
KS4NCj4+DQo+PiBQZXRyLA0KPj4NCj4+IEkgZGVjaWRlZCB0byB1c2UgcHJlZW1wdF9kaXNhYmxl
KCkgaW5zdGVhZCB0byByZW1haW4gY29uc2lzdGVudCB3aXRoIHRoZQ0KPj4gcmVzdCBvZiB0aGUg
ZmlsZS4gVW5mb3J0dW5hdGVseSwgSSBkaWQgbm90IG1ha2UgdGltZSB0byBib290IHRlc3QgZXRj
Lg0KPiANCj4gQWFyb24sIHRoYW5rcyBzbyBtdWNoIGZvciBkb2luZyB0aGlzIQ0KPiANCj4gU2lu
Y2Ugbm8gYm9vdCB0ZXN0cyBhcmUgcGVyZm9ybWVkIHlldCwgSSBqdXN0IHB1c2hlZCB0aGlzIHRv
IG1vZHVsZXMtdGVzdGluZw0KPiBmb3Igbm93LCBhZnRlciB3ZSBnZXQgc29tZSBib290IHRlc3Qg
cmVzdWx0cyBJJ2xsIHB1c2ggdG8gbW9kdWxlcy1uZXh0Lg0KPiANCj4gV2Ugc2hvdWxkIHJ1biBr
bW9kIHRlc3RzIGFzIHdlbGwuDQo+IA0KDQoNCk15IEtjb25maWcgcGF0Y2ggYW5kIG15IHR3byBz
ZXJpZXMgc3RpbGwgY2xlYW5seSBhcHBseSBvbiB2OS4gSSBkb24ndCANCm5lZWQgdG8gcmViYXNl
L3Jlc2VuZCB0aGVtLg0KDQoNCmJvb3QgdGVzdCBpcyBPSyBmb3IgbWUgd2l0aCBBYXJvbidzIHY5
Lg0KDQoNCkNocmlzdG9waGU=
