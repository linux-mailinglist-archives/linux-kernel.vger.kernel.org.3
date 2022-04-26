Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF60250F184
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245451AbiDZGzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiDZGzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:55:46 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2136.outbound.protection.outlook.com [40.107.117.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F223AA55
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:52:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nEmMmCw2/f3PJgj0kH1NMr9llmqtZOEcBlICr0JWPe+sFhpVvCum9kmLYwmkgv7/PSYAMDizrVJ+p6o+/8fqE+9r3jgICNTovdAySNRqUGTtXAlZvcr9WVXzvh/hQuaHyh+olNXK7vnj5tov+Q4j84GJ99Xu20TvM/HECmnK2llanQefnBuY8yPA9lqYpJkdfgicM6wRNXFYOmk/CWsMHuquH9kFFxljV/CidT6iNMh/kFYxXOjkAmOMcA+nQbpLJUh1TjJ+e7l9wMThBnhxJ15Sf0Aonk4yRGsODAqf0DXJDrZvKP6AuorOvVtpFlrXbiSuIG8c8qEjp0aMqGvLuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gFHMsbJAYUu9YGS+UDdx28Th6ujwISMF/aje38KnKB8=;
 b=OX/OINw11Dq6XMVbTST6GvCmwNDN+rEyCmLQlEWhSUKGPO2ROzkjdnks4HFMqsSnZKfUbzeCqs6+vL1JgkVFH2c3btqU9mjDwPI/RWNPEPP0hHJZxVs2iCax/Jy4pKBvltZIfx6DdDWP3EWRFzt6xQUR0jLDtr3L31bkK8js47Q1Eq6xdMoLssWnB3mwsTzPMzBrjPOApE5GAYUE2L9SbrJVhcOA+BytvSiCs0xb/2Cj2dkRAxUF94wp5akBUaQG5bdjG347F2adAaUOkvpDG8hvX1A5SuKDhrif7tPF0W2nFDIPHWNOIgu/fV8OC0iRr/vsURuZ+3/Doc1DPFMCng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gFHMsbJAYUu9YGS+UDdx28Th6ujwISMF/aje38KnKB8=;
 b=D8cy3gQOcATyQ/sGAIrBcbZ0WXec6Z6IASYX2NoVRcj0XPaFjnsJiQgLXjBZZbtEKBzwg9xeS1Jy9pcqImnzbLbqN/czUYYjMftubV3zjo41cskCxWjNJW/W5dai4tGPdMdZSszKqNTxk1+yZZAIFDCtFZKNn3cwcAYh2cLryUc=
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by KL1PR0601MB4050.apcprd06.prod.outlook.com (2603:1096:820:2a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Tue, 26 Apr
 2022 06:52:35 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc%6]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 06:52:35 +0000
From:   =?gb2312?B?zfXH5g==?= <wangqing@vivo.com>
To:     Sudeep Holla <sudeep.holla@arm.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>
Subject: [PATCH V2] arm64: add SCHED_CLUSTER's dependency on ACPI
Thread-Topic: [PATCH V2] arm64: add SCHED_CLUSTER's dependency on ACPI
Thread-Index: AQHYWE/nPyW0oeJKi0iRN/lm7iJKMK0AZ6qAgAAP2UeAAGOYAIAAnATTgABJZ4CAAAB5jQ==
Date:   Tue, 26 Apr 2022 06:52:34 +0000
Message-ID: <SL2PR06MB3082F1AEE684E638C1B5F226BDFB9@SL2PR06MB3082.apcprd06.prod.outlook.com>
References: <1650855303-91388-1-git-send-email-wangqing@vivo.com>
 <20220425100635.ig4dxvlflglfagpx@bogus>
 <SL2PR06MB308217E24459AB685FBF6FD2BDF89@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <20220425165946.qb6xilgmjahdh4pa@bogus>
 <SL2PR06MB3082544EFB9C6F518A2EBF04BDFB9@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <20220426064053.h4rwvcdvmwxj2hmt@bogus>
In-Reply-To: <20220426064053.h4rwvcdvmwxj2hmt@bogus>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 77887d67-1a8b-4a65-8843-08da27515800
x-ms-traffictypediagnostic: KL1PR0601MB4050:EE_
x-microsoft-antispam-prvs: <KL1PR0601MB4050899E621F04939B211837BDFB9@KL1PR0601MB4050.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C6V3m3l6SEVz+ixM1ftj4Oqua3N658LwkYgX66tlCiHfFIHOqxmz7kW96aLystZ3GXUGMX+uWLjPE6BD9opnLIMn8TPPpiFhazNOIDClIb4vgjfjg5nG6YvoLTZa55VRA6hPQOGJeFooQZv7cvVVMXHgY+8OD6eGOy+1aIJ75nd/koWYbLRuua1cnL8Y5iZ/tifuH3NcZAWu/gudPNgY9B3uS4bM0j1EppnRa1Th7aiVdhqgEKzOu7FVvDev0NxqkBZx8mPsdU31wbj0nS3bvuMEwF1xgMWFJMCh7BqNne6SZgihwSLJI1yhDP8F59tHvYp63ScFZaKLKfPhGLazcfc5aA8T1ZHLSRaIKxWH0gVCkEzFBkScdaMLd8r8SZZd4zwzlUORN5m6HhIIf/+JJa/Gw2Slh8DLfa5BsaZKylBRsBxCsC/yC5OLt3IM6HV0MSg7YSbNb6N7W2wkrL/Dh8B0DZENLxtFWnV/QZ43GVLzJ4MVnqPuggMewivohUhUzOjm73TrjUpPAGNFXZDe8VLRHnuyYFAu2fQsvvswj/BMiXIkKkveHOWzU0d+bOiK0UxYy1wNeN1PP60xs0KRQ4FSrxDzXsJlgWyv7zMtP6k2A9O2ocIMY2eaoEtMcJZEM+JSAgER4Kf1ZwTZvEkAVYh4x49TI4qLVKQbTMLXhH/0N0Mzrd8ttC9OTraanhA3BtigK36osVW9z8O4d4zJ5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(85182001)(5660300002)(52536014)(9686003)(6506007)(55016003)(83380400001)(122000001)(33656002)(186003)(8936002)(71200400001)(7696005)(86362001)(26005)(38070700005)(38100700002)(8676002)(91956017)(64756008)(2906002)(4326008)(66446008)(508600001)(66946007)(66556008)(66476007)(76116006)(316002)(6916009)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?VWpnT2xEVkY2RHR3bmIxSGthb1A1b0kvd0NIS0tyWENnMWJiZDVzL0hxOG4x?=
 =?gb2312?B?eklJMUwvclVlbDhPSE1FWndsMGhpVGp1LzQyL1NvSGNxMzVXWWVjdWN0SVZK?=
 =?gb2312?B?QndvSzJoTDJGQTdmSHM4Z0taY0dCbFVkRWxsMFdHWFZWZGxtT215ckFDdkI1?=
 =?gb2312?B?Ryt5RU05bGxCdDdwKzM1SGE3MEhlL0FUNGkwYVkxM2FvTnd6NXNRcjhoTWxZ?=
 =?gb2312?B?NjJvcTRKZFN3OFZicFJHQkFKUG5FYXVnSDJVeXlSSUxkZDBoOXVVVUFzRVJH?=
 =?gb2312?B?WlFlYTNLMFRLNUp5Qk9IZ3F3blI4TDBWWEJ3K04wRmNyS0RVZFBEVVk5bE1r?=
 =?gb2312?B?WkpVWWN3ZWMyUlRYOFU2bzZHT2VEY3NiaERiMmpEb0RhY0dDTlQrTDZnY3VJ?=
 =?gb2312?B?NzdUMWRaQW1kUS9VOERMVXVGdlc1RGE5Q1lwWmVjWjlHOXEvSnNQR0EwVDcr?=
 =?gb2312?B?OFJWYnNEQWZLM2JmQ25KVGVIdUFwUWUreUhnUnZJNDBoRWZveG9HRVNDWXVL?=
 =?gb2312?B?Q1drUzBac0svb1pKZTE2YnhYZHJCNDVxa1NScGZ4Rk1zR3hTQithSVE4TE40?=
 =?gb2312?B?Z0RaeGVQUU9GUldra2pWTHFTYlVmRmFGaitIUUFSTFU2dzVWWnpXazE4cjhm?=
 =?gb2312?B?UXh4WXBTbTVvQkJrWC9RSU43UWFuT3Q1bWJ1eWNvdkpDaWlSV01SYmM4WCs3?=
 =?gb2312?B?U1FSM2xlV09zcm10Q1BFdDlybTdTYkV3eis0TXc1aXZycWNueUNlMGhmNURV?=
 =?gb2312?B?UEVsN2o3S0Z3QURpdUcrOUpBRG10QlByd2o1bnVjNm9CUzhoUzNpRWJlUk0z?=
 =?gb2312?B?WDVsWXhoRzdMeVF5Q0wzc2NZbHNrRkU5VUNaTzRLRjhDVVFUQjZQVlhhMlgy?=
 =?gb2312?B?a1lBdlZ4UmdPSTlIdUFkVnltcWxQUW5zSjRYYThXcGpLS21JSjg2TjQ1WnBo?=
 =?gb2312?B?TlhxV01seFpiRWF5K2VZVVZGZ2RrSkJVQ0VFVGF5YS9XMko5THorR3ZZSk1J?=
 =?gb2312?B?bVF0RnAwZWJZV1oyK21NdE8yYitYNEI3b01CM0JkS1JMTDdQNDZDaEtxZ3pK?=
 =?gb2312?B?a2NXY2VYc0tEbUIrYzRlOThJOGVUYmo4RXFQb1QvTVl4bmRxWU50ZXE3U01w?=
 =?gb2312?B?M293eG83Wmo1QVNuMjBibEZoSTNXcm1RSVpYaDVqTERHRlZwTHhzMmdGM3BS?=
 =?gb2312?B?SXpzQS9vQUZFaGJwYmRRY0pNNDVkVVpVK045TG80U0NiVWVBUWkxYVFhdzBU?=
 =?gb2312?B?ZXBvMG5VV25QT3ZiN0V2akhZMGY4YXdhVW8rdHJ0NW95a2I2MXpZU2gvTm1Y?=
 =?gb2312?B?ZEVkRWt6VytDZ2k5OTBFOXJic0ZXWWNQTmduN2FqUTd6Z2I4SGQ2VWcwVS9P?=
 =?gb2312?B?OWFDN0k5U3l0aVBjOHd5dDBDUEFmV0w1Z09PSnl4UllxaVNaelZUeVJwSmtH?=
 =?gb2312?B?QlprNWkyOUpJVFlaelhLd2tVZUdQalNCOUdWbUFNT0tMbVBOanRHYUdMc3RL?=
 =?gb2312?B?NDgyQWJDYWFoamJjdkk4ZS9aOUpYMzVoYXMxUm84dnRSNmF2TUVyaWxBRnB0?=
 =?gb2312?B?TEU5NUFLcnFvemRLa0Y3Vkg3aWY3OWFaOHM2QkN0akZDSjNRaUgveEg3YWdj?=
 =?gb2312?B?UkU5VE9IVW5RNWNGWjFGS01mSDVoSERRaXoyRGFyK2xIamx6ZGFmU3hvRU15?=
 =?gb2312?B?VXJCdmZ3ajJxNVY5LzRXeXcyQ1pJcEVMSzUxN2hJUjFseUpSTDE4VDJ4ck95?=
 =?gb2312?B?bmRWRExPZEtNRldrUzBES294eCt5MlJocG1YNWROalNvV09STWh4cm5YcUlH?=
 =?gb2312?B?KzNtdGNoZGQ1SEVyZXcvOFZiVUl3TEpNZWNUcEd1ZXMwSzJRNjZETUVwTU5n?=
 =?gb2312?B?aC9zelczem9PTnZ3ckp3VFMzL09PMngyUktQMFFpUzROVjIzdkRrMVlwbWVj?=
 =?gb2312?B?SnN3NE0xRlBJL1plSURWR3dFa0Q1N3hpaWVjK0dYYU9QdG0yQ1ZEYm5sMFRL?=
 =?gb2312?B?UzViUkJoTkE4M2VvZFd0TmVxWHBzblRYMVZ6SlVVdUx6QjBWVkJxZ1E2NkU5?=
 =?gb2312?B?d29qWGZaSk1KMXAvSlJDY3VzQzV4QXpEcWd3UnFXK2taajJjZHJIQVUyTmNC?=
 =?gb2312?B?Yllld2FiTUc0UVFhMFhNbjV4SXJQM01LbHNYYzAvK3JZc3ZkYm44TTE0anhz?=
 =?gb2312?B?eVNGRGozMkMyZE9XQjZSZ3BQc2lwMUxrQmJxT2dlWkZZc2ZlblNXK2FrYyt2?=
 =?gb2312?B?bVJWR1AvdmljSjZXMFZxWlhOYnVhazVOK2FUYmZlZ3RXSWNXK3JQbmdhVFJp?=
 =?gb2312?Q?aoZ05wtkjTpz3EAAH3?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77887d67-1a8b-4a65-8843-08da27515800
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 06:52:34.7985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: h0cgWDikKEKcqd4kW5y8fdsAhJhKxZDvHScPj/D/8pxzjZlzQjyZXzOho9WD6O1LnSIFgzaUUFw9/qIa3lfOLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4050
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj4+IAo+PiA+PiAKPj4gPj4gPj4gRnJvbTogV2FuZyBRaW5nIDx3YW5ncWluZ0B2aXZvLmNvbT4K
Pj4gPj4gPj4gCj4+ID4+ID4+IGNsdXN0ZXIgc2NoZWRfZG9tYWluIGNvbmZpZ3VyZWQgYnkgY3B1
X3RvcG9sb2d5W10uY2x1c3Rlcl9zaWJsaW5nLCAKPj4gPj4gPj4gd2hpY2ggaXMgc2V0IGJ5IGNs
dXN0ZXJfaWQsIGNsdXN0ZXJfaWQgY2FuIG9ubHkgZ2V0IGZyb20gQUNQSS4KPj4gPj4gPj4gCj4+
ID4+ID4+IElmIHRoZSBzeXN0ZW0gZG9lcyBub3QgZW5hYmxlIEFDUEksIGNsdXN0ZXJfaWQgaXMg
YWx3YXlzIC0xLCBldmVuIGVuYWJsZQo+PiA+PiA+PiBTQ0hFRF9DTFVTVEVSIGlzIGludmFsaWQs
IHRoaXMgaXMgbWlzbGVhZGluZy4gCj4+ID4+ID4+IAo+PiA+PiA+PiBTbyB3ZSBhZGQgU0NIRURf
Q0xVU1RFUidzIGRlcGVuZGVuY3kgb24gQUNQSSBoZXJlLgo+PiA+PiA+Pgo+PiA+PiA+Cj4+ID4+
ID5BbnkgcmVhc29uIHdoeSB0aGlzIGNhbid0IGJlIGV4dGVuZGVkIHRvIHN1cHBvcnQgRFQgYmFz
ZWQgc3lzdGVtcyB2aWEKPj4gPj4gPmNwdS1tYXAgaW4gdGhlIGRldmljZSB0cmVlLiBJTU8gd2Ug
YWxtb3N0IGhhdmUgZXZlcnl0aGluZyB3LnIudCB0b3BvbG9neQo+PiA+PiA+aW4gRFQgYW5kIG5v
IHJlYXNvbiB0byBkZXZpYXRlIHRoaXMgZmVhdHVyZSBiZXR3ZWVuIEFDUEkgYW5kIERULgo+PiA+
PiA+Cj4+ID4+IFRoYXQncyB0aGUgcHJvYmxlbSwgd2UgcGFyc2Ugb3V0ICJjbHVzdGVyIiBpbmZv
IGFjY29yZGluZyB0byB0aGUKPj4gPj4gZGVzY3JpcHRpb24gaW4gY3B1LW1hcCwgYnV0IGRvIGFz
c2lnbiBpdCB0byBwYWNrYWdlX2lkLCB3aGljaCB1c2VkIHRvCj4+ID4+IGNvbmZpZ3VyZSB0aGUg
TUMgc2NoZWQgZG9tYWluLCBub3QgY2x1c3RlciBzY2hlZCBkb21haW4uCj4+ID4+Cj4+ID4KPj4g
PlJpZ2h0LCB3ZSBoYXZlbid0IHVwZGF0ZWQgdGhlIGNvZGUgYWZ0ZXIgdXBkYXRpbmcgdGhlIGJp
bmRpbmdzIHRvIG1hdGNoCj4+ID5BQ1BJIHNvY2tldHMgd2hpY2ggYXJlIHRoZSBwaHlzaWNhbCBw
YWNrYWdlIGJvdW5kYXJpZXMuIENsdXN0ZXJzIGFyZSBub3QKPj4gPnRoZSBwaHlzaWNhbCBib3Vu
ZGFyaWVzIGFuZCB0aGUgY3VycmVudCB0b3BvbG9neSBjb2RlIGlzIG5vdCAxMDAlIGFsaWduZWQK
Pj4gPndpdGggdGhlIGJpbmRpbmdzIGFmdGVyIENvbW1pdCA4NDliMzg0ZjkyYmMgKCJEb2N1bWVu
dGF0aW9uOiBEVDogYXJtOiBhZGQKPj4gPnN1cHBvcnQgZm9yIHNvY2tldHMgZGVmaW5pbmcgcGFj
a2FnZSBib3VuZGFyaWVzIikKPj4KPj4gSSBzZWUsIGJ1dCB0aGlzIGNvbW1pdCBpcyBhIGxvbmcg
dGltZSBhZ28sIHdoeSBoYXNuJ3QgaXQgYmVlbiB1c2VkIHdpZGVseS4KPj4gTWF5YmUgSSBjYW4g
aGVscCBhYm91dCBpdCBpZiB5b3UgbmVlZC4KPj4KPgo+SSBhc3N1bWUgbm8gb25lIGNhcmVkIG9y
IGhhZCBhIHJlcXVpcmVtZW50IGZvciB0aGUgc2FtZS4KCkl0IHRvb2sgbWUgYSB3aGlsZSB0byBm
aW5kIHRoZSByb290IGNhdXNlIHdoeSBlbmFibGluZyBTQ0hFRF9DTFVTVEVSCmRpZG4ndCB3b3Jr
LgoKV2Ugc2hvdWxkIGFkZCBTQ0hFRF9DTFVTVEVSJ3MgZGVwZW5kZW5jeSBiZWZvcmUgaW1wbGVt
ZW50YXRpb24uCk90aGVyd2lzZSwgZXZlcnlvbmUgd2hvIGRvZXNuJ3QgaGF2ZSBBQ1BJIGJ1dCB1
c2UgU0NIRURfQ0xVU1RFUiAKd2lsbCBoYXZlIHRoaXMgcHJvYmxlbS4KClRoYW5rcywKUWluZwoK
Pgo+LS0KPlJlZ2FyZHMsCj5TdWRlZXAK
