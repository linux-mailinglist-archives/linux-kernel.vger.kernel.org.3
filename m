Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4994F0026
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 11:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343610AbiDBJgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 05:36:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232062AbiDBJgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 05:36:01 -0400
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2130.outbound.protection.outlook.com [40.107.255.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 763065B3F8
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 02:34:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i/USf/fihFXIHJMpzTrOvm7tnprGO4qNi/GbSiLFW48uyrrx0D6weDbgOuyfDRjYJ2LkCxlgS5lv/8cQhTJXK9av2N1KjxcoQS49AjFXaRCPJiZGiahzObkKKslvdTTkTmG/c9c1JWUpoLqwEwXq9r9JS0VC4JGondlFzuomWu2Cstn+H4K/NqDzpU5iYVBecM4802tfhm/whzY8AsvLZRVtKQT2wPrl7ePa9xjjeMIx6/1lNWIcy2Msn+jshet6VK00UD7s0PauzootisCjF4d/3Xv2z4vSN/JgVDMlTKRYF8gX/fl72IW/q9Er9cQeEPpKWIctmZnkvW3GMPCNXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUIFwZfrpCi7Pb1rd1Ypn6Ie1vsjDaOqpl4IkkhKgHc=;
 b=KlDlE1q7C3jbWYeeOHwjS8fgprchOYAYcDc/JvxT0TgsZV595jOlx9EcLQ/JHxMSYjAdtdNiM3+UaNE6naCo2rJ3goi+vj3Reg8KE8ayYB9lsnuZsAYU4TFAIyvoRBJyZdDJAzO2/JGSRhmG6vaJGliWP4UOGVzyEThjmYcVyitOusjfs1LKkR3BCXCgyc9p4lm3FygcdTNap7FFapRXWbe5WKCU5FYtsJ60yRL9m9UbAqqa+Yq3Aj1z1z5sGprygpkFFgDiBmBGm0T1LlwvRDgMbtlx0aeOJTXk1V717ode5LsltfES/pryNPCvekSkMvOpNUsIHvggDA9IV0gJig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUIFwZfrpCi7Pb1rd1Ypn6Ie1vsjDaOqpl4IkkhKgHc=;
 b=eeuI6+5RJmsej1qbp7bas1Aw0iSnvR0ackCHtRNbd07/v7VXs+pNRHNSnSoeyEVbksuInUwDBKyQCy56KK7Cxh/U8jq2ygYf7iSi7ET26H1zrE9flqMaNeKKNLCaPKmEkVG69777h2+tzNsLRWIDEyrvLVRbgDwb4JcdYfZAVHs=
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by PS2PR06MB3638.apcprd06.prod.outlook.com (2603:1096:300:5e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Sat, 2 Apr
 2022 09:34:05 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::6c6e:d8af:2d3c:3507]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::6c6e:d8af:2d3c:3507%7]) with mapi id 15.20.5123.021; Sat, 2 Apr 2022
 09:34:05 +0000
From:   =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] sched: topology: make cache topology separate from cpu
 topology
Thread-Topic: [PATCH] sched: topology: make cache topology separate from cpu
 topology
Thread-Index: AQHYNH6wtHW6B7ixb027761a5egjaKy4qoqAgACydgyAAHYBAIAAAhW+gAAFIYCAAAqIMIAAJLWAgAWpZBWAAP4OgIAby4AI
Date:   Sat, 2 Apr 2022 09:34:04 +0000
Message-ID: <SL2PR06MB308281BAC7D7F7CBF136DCD3BDE39@SL2PR06MB3082.apcprd06.prod.outlook.com>
References: <1646917125-20038-1-git-send-email-wangqing@vivo.com>
 <CAKfTPtAvbpUUaOqP3gmOT7fLk8-7v70LzBUiQ-vgDvc7ZZujag@mail.gmail.com>
 <SL2PR06MB30828CF9FF2879AFC9DC53D2BD0C9@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <CAKfTPtBM9WBEgP_PpRHNaATvp9FrBeV2NXhg_EAp4xYtBZYCWQ@mail.gmail.com>
 <SL2PR06MB30826C314139509EC4778C1BBD0C9@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <CAKfTPtA=dy4M2OK+GqvPDo9D8YBZAHbEpM-YPVZEyEUjEJKU5g@mail.gmail.com>
 <SL2PR06MB308268BDF646BFA0FC9A4590BD0C9@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <CAKfTPtCVV_cpBty7xH8Gea8HdjNzfiE3Kd882i7Pffvrv3p1zw@mail.gmail.com>
 <SL2PR06MB3082ED191BF8892367A3465EBD109@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <CAKfTPtCn0As7Kbj7aHtmu++RDyo8proM6k9DLa1AMAc7iSSQXg@mail.gmail.com>
In-Reply-To: <CAKfTPtCn0As7Kbj7aHtmu++RDyo8proM6k9DLa1AMAc7iSSQXg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0850699-af72-4073-f5e6-08da148bee40
x-ms-traffictypediagnostic: PS2PR06MB3638:EE_
x-microsoft-antispam-prvs: <PS2PR06MB363832BA8497BB6E8B5E4F3EBDE39@PS2PR06MB3638.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 76WOcFId7TT50vGUMKsDNJSIuOBHHxYGcRZZgXVDq0tILe50H5wt0EoD44CHadh04b5fxEujPsCcTwEeFd7XIO5a9Jggra3ByNjgiFD9xDQ3Mxt8/D1ljYbqMjG7pXTxxVbsakfW9HYFaE9i/qdbgh7A+uO1DfFiWvdwbFWdSZWsDLSBvLLuLGDbQZ4EwSh2pWJlM49Y3y8i1GgSrf61PG2F+kHZULylNKUJtPq/EGX2Ys/obzlfuGReB+UA5PcnlLhyC2/1ZKxUSTnDpDViQp2OKFEZ/k4prEoG0Cp7lzHToo8R5bGcnkwTiG/Jk6y/FlNMGnHxlKIsoNByGZCKixuSr9l6Ytx8+lSJ8iktU9rOs0b5kvgrYhpMxCKY2P/cA5ykpH5Qmd01t86YnLJdVS1vgcCLyfsevoHDSq1V3Lw37pEqEa46Q9KNPn/pgcv+/kJ3x8H4TVdpTN6xppvGTN0OyYTrHKb2ApAJ/BeLRam1QTJyn+qcl7Hkvz1CmY9mK18f5NO/MU69G/GaOmBoHt05DGVf+gnZRq7qWxJLVwTS7AEIK9WJlRf4MUK4VmQmUYostYH9CJy7TdW2g7HIHVafNVz976EaEd0ngo43ZPOI+yK0LKI4I70REm2iPLPSgTRB8ThPP8Z0dsqFHjlUaw+XGeOp5MQYbXo0b6lm2IvQ1KlHu5jKM1DChIwfRmikgTl20snu0wY8x6UUz0IPoQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(508600001)(54906003)(85182001)(6916009)(5660300002)(122000001)(38100700002)(66556008)(186003)(55016003)(2906002)(6506007)(7696005)(26005)(38070700005)(8936002)(8676002)(4326008)(9686003)(86362001)(7416002)(316002)(91956017)(52536014)(71200400001)(33656002)(64756008)(66446008)(66476007)(76116006)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q0NtczlRTUx6OVNXYStaQmVQem1sMThQbUs0WklkOENkZHR2MC9sVXl0bk1U?=
 =?utf-8?B?eDVjSmRLVHowOW5sL2o4TVRIVUVQam5ac0VpQWhHYnJ2UHNOR2tPTVlFY3FE?=
 =?utf-8?B?bDFLeU1pb29KQlNxUlBLKzYwRkZndzdFUDU2bmhsNTNTWENDK3JTRnJWdldh?=
 =?utf-8?B?cExvcHBjYkprbmM4NFR0aUdhcDhrRHFRSnVaTG1YT2RTOWIwek8yQWVxcjlV?=
 =?utf-8?B?aVVSbVJuWURZdHp4cTVEbEJWbjFxUlZlcTdWRE85L3J3VFpjM01jS1k4bXZ2?=
 =?utf-8?B?RmcvcEZ6SjdDOFFpNTliU2JwZmYyMXRtTWZURll1MWgwQnZIRkxEOFNsSDUr?=
 =?utf-8?B?cUhzRU9OMmdWN0xrdEdvM2x5dGk5cndkRmpCYXlLNVU0REFHNjdyQUhkZnZn?=
 =?utf-8?B?Z0RtUW5IbEpNajNlTUMwc3Fsc0ZaZTRKUzhrV2lQRlNHZFE5ZGVDUFU2Q0k1?=
 =?utf-8?B?bW1Ndk9CWEMwbjZkaUJyemxHOVNjUVdpbm5YM3Y4czBGR090MnJiM2hVSjl6?=
 =?utf-8?B?cDFsbmNxODFLUlhiUzZrVkRqcDlWS2VsN2xzb2pHdndZZTB0RmlCVnoxQkk3?=
 =?utf-8?B?cXhvdDJPZDFMS1Y4QXE1WTQ3UzMzaXV6aVFGdk16aFdkdWRqdVFDekFoQkY1?=
 =?utf-8?B?RkpETFdxaXdmWmFrOUMrODV5T0w5QUhMMlg5bEE3NEx1aU9WY3BDUTR3YnJZ?=
 =?utf-8?B?cW1KcnFUV3VDQm5ZamxoQnZMN2xuZHBnaXpGQXFMdkRtNUk4OWtidUJuQk5H?=
 =?utf-8?B?UFdPdDhCUEVpQnU4T1o3TnN4MWt5RjI3YmxzSjNDT2xublMwd2JLR1RZM09L?=
 =?utf-8?B?blFhVk1CV1ZqTzVNR3kweGZQNzlsQWR6eXBFcG1oMUoyUjFveTF6WWRBVFYr?=
 =?utf-8?B?NTJOU29pS3JnMDZKODh4aWU2d0VjOUY5YVNDeW5PanhpbllBZHRNR3ZadHVV?=
 =?utf-8?B?R3UzVkV3RiswS1AwTlVSWkViK3RXOENCMlpvQXE0YlZnS0hxbVc0Z3BsWXJL?=
 =?utf-8?B?VlhVZHhGaUViN0lkeUZrc0hhVU1QaTE3Q2NZUWZjYnhSYWJvbiswZFg5K1By?=
 =?utf-8?B?REJmalZNdmR3OTRlWmt1S2hHRk1Eenh5SGNYUENxS0RTODBTREtueWUzOXRY?=
 =?utf-8?B?M0EwQTBJMGdLaFN5ZUU2eUtEeFNsbXZRaU9pWjdNZTlGR1hsZTdOU0piSEpv?=
 =?utf-8?B?YjQ4aWhYOUgzb2tTemN0ZEM4TzA4MHh4aS9FTjQyNDI0aEFDaVQzOVUxaFBh?=
 =?utf-8?B?bmprVldQTkdDdDJHRTBJazJ1aXRnUmp1SjRLb1VYK3FoajVKK3JSRmZGOHhZ?=
 =?utf-8?B?a1NkR1Y4U0JPdVd2QXRScWg4cEZvTTdGQnBDQk8vMWc5OUdwVTdGYk5HSy9Q?=
 =?utf-8?B?dWVjeStJS29EV0s2Mk9jeWVaRUsxZWZQK1c2djJUM1BYKzBVbm1vU1dmeEtD?=
 =?utf-8?B?UWZQQThoUWFaK3lKQ3BYSzV0VDh6NVVxQTJCY2lOS3Rna0Fkck92OEFPUmJP?=
 =?utf-8?B?ZURIRTMwS1RzY1dwb0kxZXRORVM1L28vMlhYWUIyZlUrMERGRVBtcWVtVVRh?=
 =?utf-8?B?ZEdINkJrc1hmYldBcU5FMWp4OElCVmRqcUJKdVdwdjVweXNDVkUrVmc4czNE?=
 =?utf-8?B?alB2ejZNYkc0cGFJREFjbFIwU3RaUmdpUlJCaEpsNUIydC9Vdy9rTWw0dW9T?=
 =?utf-8?B?YXFQVGZsVTFjeWMzWGt0UzJFRFdGRVN0UmdyLytrQTI2VVVOL2o4Wk9QWGpS?=
 =?utf-8?B?OGU0cWZzOVEyeEtUY2w3K2NHWVVVQXBCa3NTRkgwNFJUOElYQWNKVDFmdURN?=
 =?utf-8?B?NG04bGZDSktIa3J0U2VlVElBa3BWOVJ2My9OLytHZnZzUFE0TnptWlBIa09q?=
 =?utf-8?B?UkUrUzJvaTlJcnlURUo4cFlVUnhNcUFTU2NCK2YrdlB3UzI5aytSalVNUjR1?=
 =?utf-8?B?UWhZQmttRG9uOC9KbHEzamNDUzZiRzFML3g3bFhkUHA1YUJIMDVCbjhSZXdN?=
 =?utf-8?B?U0RPOEtlZ3pRbFlyN0xLM2FvREMyR2tRQjRFWkhVSTdqblBKTm83TURuYVZm?=
 =?utf-8?B?SEw4czEwSHBGRUMwc1NUcVlrVFU5c0ZZcWdmK0RIeVoxaGlzZjFtRzlvcUcw?=
 =?utf-8?B?b1hpR1ZqTDBFNy9uTzh6aCtsUy9pbWs2UDI3RUF5bHpzRjRNSGprQ3Q5ZXZ3?=
 =?utf-8?B?MFVVYUQwNHZHdmF3M0tHZ3B0NlFrS3RhcW05QU9pZGRORzlBb284TkZzOEhh?=
 =?utf-8?B?UFBsczNuMjRCdzFmbWNJbWdiam9nUElPLzJuMi8vbDhHdk53ZlFjQ1I5Umx6?=
 =?utf-8?Q?RPCFrBjFDEXdVSTb/V?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0850699-af72-4073-f5e6-08da148bee40
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2022 09:34:04.7372
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eNRFKvo75wD5GHdUPnHrfQfUnDYsJZl1B4deUQDMy9pgFEEXd3pK4BFUvLqDCpZlsfXBZWPgwSAxm8fBbjQ21Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS2PR06MB3638
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj4+Cj4+Cj4+ID4+Cj4+ID4+Cj4+ID4+ID4+Cj4+ID4+ID4+Cj4+ID4+ID4+ID4+Cj4+ID4+ID4+
ID4+Cj4+ID4+ID4+ID4+ID5PbiBUaHUsIDEwIE1hciAyMDIyIGF0IDEzOjU5LCBRaW5nIFdhbmcg
PHdhbmdxaW5nQHZpdm8uY29tPiB3cm90ZToKPj4gPj4gPj4gPj4gPj4KPj4gPj4gPj4gPj4gPj4g
RnJvbTogV2FuZyBRaW5nIDx3YW5ncWluZ0B2aXZvLmNvbT4KPj4gPj4gPj4gPj4gPj4KPj4gPj4g
Pj4gPj4gPj4gU29tZSBhcmNoaXRlY3R1cmVzKGUuZy4gQVJNNjQpLCBjYWNoZXMgYXJlIGltcGxl
bWVudGVkIGJlbG93Ogo+PiA+PiA+PiA+PiA+PiBjbHVzdGVyOsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgKioqKioqIGNsdXN0ZXIgMCAqKioqKsKgwqDCoMKgwqAgKioq
KioqIGNsdXN0ZXIgMSAqKioqKgo+PiA+PiA+PiA+PiA+PiBjb3JlOsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAwwqDCoMKgwqDCoCAxwqDCoMKgwqDCoMKg
wqDCoMKgIDLCoMKgwqDCoMKgIDPCoMKgwqDCoMKgwqDCoMKgwqAgNMKgwqDCoMKgwqAgNcKgwqDC
oMKgwqDCoMKgwqDCoMKgIDbCoMKgwqDCoMKgIDcKPj4gPj4gPj4gPj4gKGFkZCBjYWNoZSBsZXZl
bCAxKcKgwqDCoMKgwqDCoMKgIGMwwqDCoMKgIGMxwqDCoMKgwqDCoMKgwqAgYzLCoMKgwqAgYzPC
oMKgwqDCoMKgwqDCoMKgIGM0wqDCoMKgIGM1wqDCoMKgwqDCoMKgwqDCoCBjNsKgwqDCoCBjNwo+
PiA+PiA+PiA+PiA+PiBjYWNoZShMZXZlbG4pOsKgwqDCoMKgwqDCoMKgwqAgKipjYWNoZTAqKsKg
ICoqY2FjaGUxKirCoCAqKmNhY2hlMioqwqAgKipjYWNoZTMqKgo+PiA+PiA+PiA+PiAoYWRkIGNh
Y2hlIGxldmVsIDMpwqDCoMKgwqDCoMKgwqAgKioqKioqKioqKioqKnNoYXJlIGxldmVsIDMgY2Fj
aGUgKioqKioqKioqKioqKioqCj4+ID4+ID4+ID4+ID4+IHNkX2xsY19pZChjdXJyZW50KTrCoMKg
wqDCoCAwwqDCoMKgwqDCoCAwwqDCoMKgwqDCoMKgwqDCoMKgIDDCoMKgwqDCoMKgIDDCoMKgwqDC
oMKgwqDCoMKgwqAgNMKgwqDCoMKgwqAgNMKgwqDCoMKgwqDCoMKgwqDCoMKgIDTCoMKgwqDCoMKg
IDQKPj4gPj4gPj4gPj4gPj4gc2RfbGxjX2lkKHNob3VsZCBiZSk6IDDCoMKgwqDCoMKgIDDCoMKg
wqDCoMKgwqDCoMKgwqAgMsKgwqDCoMKgwqAgMsKgwqDCoMKgwqDCoMKgwqDCoCA0wqDCoMKgwqDC
oCA0wqDCoMKgwqDCoMKgwqDCoMKgwqAgNsKgwqDCoMKgwqAgNgo+PiA+PiA+PiA+PiA+Pgo+PiA+
PiA+PiA+PiBIZXJlLCBuIGFsd2F5cyBiZSAyIGluIEFSTTY0LCBidXQgb3RoZXJzIGFyZSBhbHNv
IHBvc3NpYmxlLgo+PiA+PiA+PiA+PiBjb3JlWzAsMV0gZm9ybSBhIGNvbXBsZXgoQVJNVjkpLMKg
IHdoaWNoIHNoYXJlIEwyIGNhY2hlLCBjb3JlWzIsM10gaXMgdGhlIHNhbWUuCj4+ID4+ID4+ID4+
Cj4+ID4+ID4+ID4+ID4+IENhY2hlcyBhbmQgY3B1cyBoYXZlIGRpZmZlcmVudCB0b3BvbG9neSwg
dGhpcyBjYXVzZXMgY3B1c19zaGFyZV9jYWNoZSgpCj4+ID4+ID4+ID4+ID4+IHJldHVybiB0aGUg
d3JvbmcgdmFsdWUsIHdoaWNoIHdpbGwgYWZmZWN0IHRoZSBDUFUgbG9hZCBiYWxhbmNlLgo+PiA+
PiA+PiA+PiA+Pgo+PiA+PiA+PiA+PiA+V2hhdCBkb2VzIHlvdXIgY3VycmVudCBzY2hlZHVsZXIg
dG9wb2xvZ3nCoCBsb29rIGxpa2U/Cj4+ID4+ID4+ID4+ID4KPj4gPj4gPj4gPj4gPkZvciBDUFUg
MCB0byAzLCBkbyB5b3UgaGF2ZSB0aGUgYmVsb3cgPwo+PiA+PiA+PiA+PiA+RElFIFswwqDCoMKg
wqAgLcKgwqDCoMKgIDNdIFs0LTddCj4+ID4+ID4+ID4+ID5NQ8KgIFswXSBbMV0gWzJdIFszXQo+
PiA+PiA+PiA+Pgo+PiA+PiA+PiA+PiBUaGUgY3VycmVudCBzY2hlZHVsZXIgdG9wb2xvZ3kgY29u
c2lzdGVudCB3aXRoIENQVSB0b3BvbG9neToKPj4gPj4gPj4gPj4gRElFwqAgWzAtN10KPj4gPj4g
Pj4gPj4gTUPCoCBbMC0zXSBbNC03XcKgIChTRF9TSEFSRV9QS0dfUkVTT1VSQ0VTKQo+PiA+PiA+
PiA+PiBNb3N0IEFuZHJvaWQgcGhvbmVzIGhhdmUgdGhpcyB0b3BvbG9neS4KPj4gPj4gPj4gPj4g
Pgo+PiA+PiA+PiA+PiA+QnV0IHlvdSB3b3VsZCBsaWtlIHNvbWV0aGluZyBsaWtlIGJlbG93IGZv
ciBjcHUgMC0xIGluc3RlYWQgPwo+PiA+PiA+PiA+PiA+RElFIFswwqDCoMKgwqAgLcKgwqDCoMKg
IDNdIFs0LTddCj4+ID4+ID4+ID4+ID5DTFMgWzAgLSAxXSBbMiAtIDNdCj4+ID4+ID4+ID4+ID5N
Q8KgIFswXSBbMV0KPj4gPj4gPj4gPj4gPgo+PiA+PiA+PiA+PiA+d2l0aCBTRF9TSEFSRV9QS0df
UkVTT1VSQ0VTIG9ubHkgc2V0IHRvIE1DIGxldmVsID8KPj4gPj4gPj4gPj4KPj4gPj4gPj4gPj4g
V2UgZG9uJ3QgY2hhbmdlIHRoZSBjdXJyZW50IHNjaGVkdWxlciB0b3BvbG9neSwgYnV0IHRoZQo+
PiA+PiA+PiA+PiBjYWNoZSB0b3BvbG9neSBzaG91bGQgYmUgc2VwYXJhdGVkIGxpa2UgYmVsb3c6
Cj4+ID4+ID4+ID4KPj4gPj4gPj4gPlRoZSBzY2hlZHVsZXIgdG9wb2xvZ3kgaXMgbm90IG9ubHkg
Y3B1IHRvcG9sb2d5IGJ1dCBhIG1peGVkIG9mIGNwdSBhbmQKPj4gPj4gPj4gPmNhY2hlL21lbW9y
eSBjYWNoZSB0b3BvbG9neQo+PiA+PiA+PiA+Cj4+ID4+ID4+ID4+IFswLTddwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKHNoYXJlZCBsZXZlbCAzIGNh
Y2hlICkKPj4gPj4gPj4gPj4gWzAtMV0gWzItM11bNC01XVs2LTddwqDCoCAoc2hhcmVkIGxldmVs
IDIgY2FjaGUgKQo+PiA+PiA+PiA+Cj4+ID4+ID4+ID5TbyB5b3UgZG9uJ3TCoCBib3RoZXIgdGhl
IGludGVybWVkaWF0ZSBjbHVzdGVyIGxldmVsIHdoaWNoIGlzIGV2ZW4gc2ltcGxlci4KPj4gPj4g
Pj4gPnlvdSBoYXZlIHRvIG1vZGlmeSBnZW5lcmljIGFyY2ggdG9wb2xvZ3kgc28gdGhhdCBjcHVf
Y29yZWdyb3VwX21hc2sKPj4gPj4gPj4gPnJldHVybnMgdGhlIGNvcnJlY3QgY3B1IG1hc2sgZGly
ZWN0bHkuCj4+ID4+ID4+ID4KPj4gPj4gPj4gPllvdSB3aWxsIG5vdGljZSBhIGxsY19zaWJsaW5n
IGZpZWxkIHRoYXQgaXMgY3VycmVudGx5IHVzZWQgYnkgYWNwaSBidXQKPj4gPj4gPj4gPm5vdCBE
VCB0byByZXR1cm4gbGxjIGNwdSBtYXNrCj4+ID4+ID4+ID4KPj4gPj4gPj4gY3B1X3RvcG9sb2d5
W10ubGxjX3NpYmxpbmcgZGVzY3JpYmUgdGhlIGxhc3QgbGV2ZWwgY2FjaGUgb2Ygd2hvbGUgc3lz
dGVtLAo+PiA+PiA+PiBub3QgaW4gdGhlIHNjaGVkX2RvbWFpbi4KPj4gPj4gPj4KPj4gPj4gPj4g
aW4gdGhlIGFib3ZlIGNhY2hlIHRvcG9sb2d5LCBsbGNfc2libGluZyBpcyAweGZmKFswLTddKSAs
IGl0IGRlc2NyaWJlcwo+PiA+PiA+Cj4+ID4+ID5JZiBsbGNfc2libGluZyB3YXMgMHhmZihbMC03
XSBvbiB5b3VyIHN5c3RlbSwgeW91IHdvdWxkIGhhdmUgb25seSBvbmUgbGV2ZWw6Cj4+ID4+ID5N
Q1swLTddCj4+ID4+Cj4+ID4+IFNvcnJ5LCBidXQgSSBkb24ndCBnZXQgaXQsIHdoeSBsbGNfc2li
bGluZyB3YXMgMHhmZihbMC03XSBtZWFucyBNQ1swLTddPwo+PiA+PiBJbiBvdXIgc3lzdGVtKEFu
ZHJvaWQpLCBsbGNfc2libGluZyBpcyBpbmRlZWQgMHhmZihbMC03XSkgLCBiZWNhdXNlIHRoZXkK
Pj4gPj4gc2hhcmVkIHRoZSBsbGMoTDMpLCBidXQgd2UgYWxzbyBoYXZlIHR3byBsZXZlbDoKPj4g
Pj4gRElFIFswLTddCj4+ID4+IE1DIFswLTNdWzQtNl0KPj4gPj4gSXQgbWFrZXMgc2Vuc2UsIFsw
LTNdIGFyZSBsaXR0bGUgY29yZXMsIFs0LTddIGFyZSBiaXQgY29yZXMsIHNlIG9ubHkgdXAgbWln
cmF0ZQo+PiA+PiB3aGVuIG1pc2ZpdC4gV2Ugd29uJ3QgY2hhbmdlIGl0Lgo+PiA+Pgo+PiA+PiA+
Cj4+ID4+ID4+IHRoZSBMMyBjYWNoZSBzaWJsaW5nLCBidXQgc2RfbGxjX2lkIGRlc2NyaWJlcyB0
aGUgbWF4aW11bSBzaGFyZWQgY2FjaGUKPj4gPj4gPj4gaW4gc2QsIHdoaWNoIHNob3VsZCBiZSBb
MC0xXSBpbnN0ZWFkIG9mIFswLTNdLgo+PiA+PiA+Cj4+ID4+ID5zZF9sbGNfaWQgZGVzY3JpYmVz
IHRoZSBsYXN0IHNjaGVkX2RvbWFpbiB3aXRoIFNEX1NIQVJFX1BLR19SRVNPVVJDRVMuCj4+ID4+
ID5JZiB5b3Ugd2FudCBsbGMgdG8gYmUgWzAtM10gbWFrZSBzdXJlIHRoYXQgdGhlCj4+ID4+ID5z
Y2hlZF9kb21haW5fdG9wb2xvZ3lfbGV2ZWwgYXJyYXkgcmV0dXJucyB0aGUgY29ycmVjdCBjcHVt
YXNrIHdpdGgKPj4gPj4gPnRoaXMgZmxhZwo+PiA+Pgo+PiA+PiBBY3R1cmVseSwgd2Ugd2FudCBz
ZF9sbGMgdG8gYmUgWzAtMV0gWzItM10sIGJ1dCBpZiB0aGUgTUMgZG9tYWluIGRvbid0IGhhdmUK
Pj4gPgo+PiA+c2RfbGxjX2lkIHJlZmVycyB0byBhIHNjaGVkdWxlciBkb21haW4gYnV0IHlvdXIg
cGF0Y2ggYnJlYWtzIHRoaXMgc28KPj4gPmlmIHlvdSB3YW50IGEgbGxjIHRoYXQgcmVmbGVjdHMg
dGhpcyB0b3BvOsKgIFswLTFdIFsyLTNdIHlvdSBtdXN0Cj4+ID5wcm92aWRlIGEgc2NoZWRfZG9t
YWluIGxldmVsIHdpdGggdGhpcyB0b3BvCj4+Cj4+IE1heWJlIHdlIHNob3VsZCBhZGQgYSBzaGFy
ZWQtY2FjaGUgbGV2ZWwoU0MpLCBsaWtlIHdoYXQgQ0xTIGRvZXM6Cj4+Cj4+IERJRcKgIFswLTdd
IChzaGFyZWQgbGV2ZWwgMyBjYWNoZSwgU0RfU0hBUkVfUEtHX1JFU09VUkNFUykKPj4gTUPCoCBb
MC0zXSBbNC03XcKgIChub3QgU0RfU0hBUkVfUEtHX1JFU09VUkNFUykKPj4gQ0xTwqAgKGlmIG5l
Y2Vzc2FyeSkKPj4gU0PCoMKgwqAgWzAtMV1bMi0zXVs0LTVdWzYtN10gKHNoYXJlZCBsZXZlbCAy
IGNhY2hlLCBTRF9TSEFSRV9QS0dfUkVTT1VSQ0VTKQo+PiBTTVQgKGlmIG5lY2Vzc2FyeSkKPj4K
Pj4gU0MgbWVhbnMgYSBjb3VwbGUgb2YgQ1BVcyB3aGljaCBhcmUgcGxhY2VkIGNsb3NlbHkgYnkg
c2hhcmluZwo+PiBtaWQtbGV2ZWwgY2FjaGVzLCBidXQgbm90IGVub3VnaCB0byBiZSBhIGNsdXN0
ZXIuCj4KPndoYXQgeW91IG5hbWUgU0MgYWJvdmUgbG9va3MgdGhlIHNhbWUgYXMgQ0xTIHdoaWNo
IHNob3VsZCBub3QgYmUgbWl4ZWQKPndpdGggQXJtIGNsdXN0ZXIgdGVybWlub2xvZ3kKCkRvIHlv
dSBtZWFuIGNsdXN0ZXIgaXMgZXF1YWwgdG8gc2hhcmVkIGNhY2hlIGluc3RlYWQgb2YgY29udGFp
bmluZywgU0MganVzdCAKbWVhbnMgc2hhcmVkIGNhY2hlLCBidXQgbm90IGZvcm0gYSBjbHVzdGVy
LCBhIENMUyBjYW4gY29udGFpbiBtYW55IFNDcy4KCklmIGFzIHlvdSBzYWlkLCBTQyBsb29rcyB0
aGUgc2FtZSBhcyBDTFMsIHNob3VsZCB3ZSByZW5hbWUgQ0xTIHRvIFNDIHRvIAphdm9pZCBjb25m
dXNpb24/CgpUaGFua3MsCldhbmc=
