Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F924E4CDE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 07:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241993AbiCWGrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 02:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231617AbiCWGrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 02:47:05 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2095.outbound.protection.outlook.com [40.107.117.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25FC70CEE
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 23:45:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYtUUnXL/wMX8wRAKk2xdWqFvAncI7RkwAgqqCku1Hy751O11dqQnYFI52lrWEtEhyhVzIKoLLuvdZwBNI/OXeJwp+nCFeNiTmnpoMVAq3lPYyeKtRdCeOj6rXARoB7Cd/gID9SralnxbHC60AuUU9rtLUQuoCd8SFekt36vrnVW6gno+oHSrB3z1ti6+6ZjFhKJjGFkv2H81pj9Q3H2/tMLDexhkJZaSBS9zL4VP3v8wp/ml4h8FE8u6dPmRhIG4SgpioD2AnHFfb4BQnMYe5eJN+cp/bVjDmYGg5HfVvdUiAUQiH+ITAsIB4y7fCVuApHGx4EtAksW1Q/IV6zp9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3JLlivw6+2NQqOZOHiEDAQnEfm5wfDYb6+LViIx24rc=;
 b=HQnGtq3vFPBNi6HCMokUZJcV6j4Zmlh9Bamm9dKPBfTa6vhjpFWRmuvSbBPPy9aBn5+rb2+WuRnrZ+37b8L3IunO/u6fTW8rH648cgwFIaig4mbm8z9wTdA9brVLQnbdChnQWMW9JgdfAKhPUsJrnx711s46MwHDykx9Hj/V85VWEKNBTiFwS4HrOQz+0GeXz5dA4CSFjWR1roU0jSN8Lor9wpuue+KypPhC9hWB3FdjEB5MpBOwalU637JMjhkYyETlFEs7FS5s/cjkgacUFe8azY+r1/w6xJzvyz0QRWqVAvDRxNSsvXSPrGW7HsvEqP1La/mxCgJQMRLJ1tRInw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3JLlivw6+2NQqOZOHiEDAQnEfm5wfDYb6+LViIx24rc=;
 b=MBnlXrUWC7cO5mSyooXJnWxtexRdkPjkI4gW7tj+qkqE4NtXHLLs+CMS+odV+6pQJrVDaJJOZCEqoR/z1K4eJdv3+GBuyBuBCxxpuWSfq1e6S8x7egGyRTQ2Tz5BlBk6W4oVJn4bPf10ukAV3x94k25Hk1h+pSw6OOrkqmbBnbk=
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SG2PR06MB2715.apcprd06.prod.outlook.com (2603:1096:4:1b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.17; Wed, 23 Mar
 2022 06:45:30 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::49ef:baa:8c3b:cb3d]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::49ef:baa:8c3b:cb3d%5]) with mapi id 15.20.5081.023; Wed, 23 Mar 2022
 06:45:29 +0000
From:   =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Subject: RE: [PATCH] sched: dynamic config sd_flags if described in DT
Thread-Topic: [PATCH] sched: dynamic config sd_flags if described in DT
Thread-Index: AQHYOEKbopUZOeviIUquO7ORmgh/j6zAsP6AgACNF0yAAkFBAIAJCUWE
Date:   Wed, 23 Mar 2022 06:45:29 +0000
Message-ID: <SL2PR06MB3082FAA7900ED3664838B48CBD189@SL2PR06MB3082.apcprd06.prod.outlook.com>
References: <1647331137-69890-1-git-send-email-wangqing@vivo.com>
 <68df2f49-9b74-7ea2-0178-be55824b3c89@arm.com>
 <SL2PR06MB3082DBB58303601F73FB77D3BD119@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <73b491fe-b5e8-ebca-081e-fa339cc903e1@arm.com>
In-Reply-To: <73b491fe-b5e8-ebca-081e-fa339cc903e1@arm.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: f5cbcf52-364e-a757-7309-b291d2378f5a
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4003f7fe-efa4-497a-cb20-08da0c98b8b6
x-ms-traffictypediagnostic: SG2PR06MB2715:EE_
x-microsoft-antispam-prvs: <SG2PR06MB2715EAF5311A93C556D996F9BD189@SG2PR06MB2715.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jYXZvbp0DFDIorezOPiMyNMR1DXCgj0HG6DL5/NcFK0XLLTKXJyul2heJnYgg2gYYCyyivzdkZCcT7SqKn99wtMXi6ZDtbFfAWMRkCUIVgCNQksbqZ02ITqE3Wl5CWjfe7j6ytdx3Rp0LZcqAbGuRZUkOvXqP3I5nNOnPkQu8JUNx2UrAb+JnBtuTwqVMWGfGa/lZKBTEefOphwbyf30kHosXjcNBvwHC2mWZGnt4rJbV81kyrdI8N1lThB5Qffm+wu+y1KhIpOylCG9Expaxg8JXoh9WAcag8XM2TURSB9TvedKjzQJXQ/uiHUrF02PXOxRrsAFKrqDnt/AnjqiCIrvThzBpH0Qkg5NJqoNzit5qevP/5qdaeSnkG895YCFVgmQxBcYK0+Dqi1gCTn2UQ6CuVJ7+OhUoLPXP3aklAZIRaYiqbBmQ07697nPcHXcamAXUtUj34DRWrFCuUF9B7ThhP1VR911ER4qzCv5YEur9cmEfmVmMTQCh289StrXKJbXOnzQX3gFzmUfbXB73+VxWiZR6r4Lw+PLeh5PgMMBdOPu85fi7txeHDKR1tcBKlTQ5bn610gw9UttICFwo/kEB2SWWFkGlsuNxN0zSyuo8Pb4ep0Lw1mWPJDXdC2mBjYPlSqYmNXdvAUKU3C/j8yC22H11JH5ss3UHAX0lMOabYAJsdkl0UdxAqpOLcUKs+XuiIt+OilsDqV94NzkFe3PyyRlE4ylrAioKd+Hv/c=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(64756008)(91956017)(66476007)(66946007)(76116006)(66556008)(52536014)(66446008)(7416002)(8936002)(86362001)(122000001)(26005)(186003)(2906002)(921005)(8676002)(110136005)(38100700002)(316002)(38070700005)(83380400001)(85182001)(33656002)(508600001)(9686003)(6506007)(7696005)(55016003)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dXM1Q1dsVzA2TWdXSkxtT01kYjNwczdxS0ExSGhWQktnU052aEgrZ2FVWWJL?=
 =?utf-8?B?L2JpRzhLS2JYVkpGTkRBZWFuelNOUW9ZR0V4aVlNSmRYOUVCWHk1N2d6N0ZN?=
 =?utf-8?B?dnBWUUk1YjAwWGQ5Mi90U25aanU5WGNpd0ozeExiSmY4ZFFSb2h6aFo0MHlj?=
 =?utf-8?B?S0trN29RZmExa1g1OUxzdXFRUnY0QkMwZmYrUkRmb0xnTTN0K1pQcTFuenlY?=
 =?utf-8?B?c2Q1UDNldTArREdyZ3ZOSlZTMTNyd25FUkdhYm5nd3YrTWtCdnZqSnRMbEUv?=
 =?utf-8?B?YjBYUjZ6Y2dDME5xdnRYUGpmczZTcTRja1NKVlhjUWw2dmVacDZIb0JzSXdR?=
 =?utf-8?B?MDhZY1p2UjB0cUxyWUFCNXEwQ2x3dFFpcUhLQ0s2WWVhK1NCVkRnWnZWcWdC?=
 =?utf-8?B?ampReHE4dE5OUzB2UzVJNmNJbWtmZlhPK0o0cTdXQk94TXdna1c4SjE4T05o?=
 =?utf-8?B?V3JEVFRLbEdzdzJkVkJWWVA2aTZ0ZWE4Z1ZsaU5BTk0wblR6NlJJeWF2bGV2?=
 =?utf-8?B?K09kYnRMV1pvY3dqL3dkZWNDRmVyZUpQK0VnaG1OcTROSnRScE52UC92aXVm?=
 =?utf-8?B?U0gwcDNiTG80R2VuNUhCUWl6SmVYSnNSK0w4Y3ZxZTVRSWhFTUtmdkN4Vy9E?=
 =?utf-8?B?N0xVa0VZN09jSWJ3VnNrVHc3dG9MZldGc2M4V2Fya2lkTEtrdCtyZ0o0ektY?=
 =?utf-8?B?NWFGNUhFMDhpTUFMUGNTaWwxZjVvYTNoVjVaTEoySXRBRTJwU0lNVm9kdHk2?=
 =?utf-8?B?MnBTbHlQNjBOd3I3TTFZWTZvUlJVZGo4VTVxTnIyakZ1Qm5WOUZFRVUyeUlq?=
 =?utf-8?B?UDdMOUQ5dkQzY1hDMUlHdVNXZzhjQ2JaeTRVMEVTaElXRGpseWgxY3lCcG5t?=
 =?utf-8?B?S2RnUStlaXljaVhXbzZzd3hsb0MybzZKL2RmOGJjeVdBOUFxWnVFYzRoSmw1?=
 =?utf-8?B?Q2hmZXRER0Q2MTJJUWdpQTMvaU4vL0ZvWlZuckxVZ2NCc0NTbHpRSUJaNHpI?=
 =?utf-8?B?MG14U3FlSGd5TkFGdnpIc1V4VnhGUTMreGl5SC9meXhIRlVlT1htYzZMeTB6?=
 =?utf-8?B?bUhVWUFuNU5CdWdqQ1RyeXQwMURIM2Z0WDdNQzdzL2MxYUZpcXNRblZjTVlG?=
 =?utf-8?B?WDd2eE1nT0RXTytsRXhtazlVMFc4MWZMMjdscTkrTC9pbVU1ck9tYkFhazhy?=
 =?utf-8?B?dWtXQStMQVJsVmFOYmhHTGp5Z0lNNXdER2Y0dEVYcEtpbkd4bjk4TUlPei92?=
 =?utf-8?B?c2NTcm1hZWtXQW5GSE50LzNPNG1XSUM3Y0dtMEtFVlpuanlKN0FXd2R2bnlv?=
 =?utf-8?B?WmJkNGVySEFBMFdHODdxcnROaW9BRXkvcVZGakwxcHNoalNndmNiK1dpMm9q?=
 =?utf-8?B?TE5sL285RGpRZUU0SjBKMXgwTWVxekx6VmFDNVpJM1pPMytIdmxQWHZuYU9J?=
 =?utf-8?B?cUlpd3RHSCt3OTMvYm1OMndScnk4RUMxN0p0UXhWOW1MM28yYVpVd3gzRDI5?=
 =?utf-8?B?KzByTDZZTDZpc2ZMYUEvK21yaUpoTU9NUEk4aFl5elVhbVl0bm1lRyt3cUhD?=
 =?utf-8?B?cldlanVDSUVrWmwwWkp6alV3NnNyRXNEblBTWmkweURXSEdhMDU2aUxva2lT?=
 =?utf-8?B?VWF3ZVNVallyZHZaWnFHMlE0TEtIUTRQdXNRd1V3RXgrc2pOU2s5TGlCbXNU?=
 =?utf-8?B?UzRpaElXUjlZcUxiV3dHVmNBY0ovNHp6ZVllemprWTJLaDBaRzJHbmVlT0RP?=
 =?utf-8?B?Ritla1N0dkI0dEZZSmxoZFBBODJwdXJmOWg3amg1aTBvZHBqblpQOEhjNTZr?=
 =?utf-8?B?NW1HQlFXUWVNNUdpb2hueFpMS3c0cVNIbytmeHY2bkdtSTRSdkNTcjVOM1Zn?=
 =?utf-8?B?SXNQcmwwUDhHVkRZcGxGdk9XWGNLRUI2SHQrNjFSQWFmWWlmZk92TFN3V3Fj?=
 =?utf-8?Q?btz20ombBbQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4003f7fe-efa4-497a-cb20-08da0c98b8b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Mar 2022 06:45:29.6615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OVEWMvOei7s8hf2mAArDobRrCenZMjc9Qdo5dQCTzFpJeVzkRW6vtkLDrHHwlnqnQ8VFij/PDCgH1p9/948HWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB2715
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj4+IAo+Pj4gKDEpIENhbiB5b3Ugc2hhcmUgbW9yZSBpbmZvcm1hdGlvbiBhYm91dCB5b3VyIENQ
VSB0b3BvbG9neT8KPj4+Cj4+PiBJIGd1ZXNzIGl0IGlzIGEgc2luZ2xlIERTVSAoRHluYW1JUSBT
aGFyZWQgVW5pdCkgQVJNdjkgc3lzdGVtIHdpdGggOAo+Pj4gQ1BVcz8gU28gTDMgc3BhbnMgb3Zl
ciBbQ1BVMC4uQ1BVN10uCj4+Pgo+Pj4gWW91IGFsc28gbWVudGlvbmVkIGNvbXBsZXhlcy4gQW0g
SSByaWdodCBpbiBhc3N1bWluZyB0aGF0IFtDUFUwLi5DUFUzXQo+Pj4gYXJlIENvcnRleC1BNTEw
IGNvcmVzIHdoZXJlIGVhY2ggMiBDUFVzIHNoYXJlIGEgY29tcGxleD8KPj4+Cj4+PiBXaGF0IGtp
bmQgb2YgdWFyY2ggYXJlIHRoZSBDUFVzIGluIFtDUFU0Li5DUFU3XT8gQXJlIHRoZXkgQ29ydGV4
LUE1MTAncwo+Pj4gYXMgd2VsbD8gSSdtIG5vdCBzdXJlIGFmdGVyIHJlYWRpbmcgeW91ciBlbWFp
bDoKPj4gCj4+IFllcywgQW5kcm9pZCBzeXN0ZW1zIGFyZSBjdXJyZW50bHkgdXNlZCBkZWZhdWx0
X2RvbWFpbiB3aXRoIHdyb25nIHNkX2ZsYWdzLCAKPj4gdGFrZSBRdWFsY29tbSBTTTg0NTAgYXMg
YW4gZXhhbXBsZSwgdGhlIENQVSBhbmQgY2FjaGUgdG9wb2xvZ3koMSszKzQpOgo+Cj5BaCwgeW91
ciBzeXN0ZW0gbG9va3MgbGlrZSB0aGlzOgo+Cj7CoMKgwqDCoMKgIC4tLS0tLS0tLS0tLS0tLS0u
Cj5DUFXCoMKgIHwwIDEgMiAzIDQgNSA2IDd8Cj7CoMKgwqDCoMKgICstLS0tLS0tLS0tLS0tLS0r
Cj51YXJjaCB8bCBsIGwgbCBtIG0gbSBifCAoc28gY2FsbGVkIHRyaS1nZWFyOiBsaXR0bGUsIG1l
ZGl1bSwgYmlnKQo+wqDCoMKgwqDCoCArLS0tLS0tLS0tLS0tLS0tKwo+wqAgTDLCoCB8wqDCoCB8
wqDCoCB8IHwgfCB8IHwKPsKgwqDCoMKgwqAgKy0tLS0tLS0tLS0tLS0tLSsKPsKgIEwzwqAgfDwt
LcKgwqDCoMKgwqDCoMKgwqAgLS0+fAo+wqDCoMKgwqDCoCArLS0tLS0tLS0tLS0tLS0tKwo+wqDC
oMKgwqDCoCB8PC0tIGNsdXN0ZXIgLS0+fAo+wqDCoMKgwqDCoCArLS0tLS0tLS0tLS0tLS0tKwo+
wqDCoMKgwqDCoCB8PC0twqDCoCBEU1XCoMKgIC0tPnwKPsKgwqDCoMKgwqAgJy0tLS0tLS0tLS0t
LS0tLScKPgo+PiB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBEU1XCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgfAo+PiB8wqDCoMKgwqDCoMKgwqDCoMKgwqAgY2x1c3RlcjDCoMKgwqDCoMKgwqDC
oMKgIHzCoMKgwqDCoMKgwqAgY2x1c3RlcjHCoMKgwqDCoCB8Y2x1c3RlcjJ8Cj4KPl5eXiBUaG9z
ZSBhcmVuJ3QgcmVhbCBjbHVzdGVycywgaGVuY2UgdGhlIG5hbWUgPFBoYW50b20+IFNELiBUaGUg
Y2x1c3Rlcgo+aXMgW0NQVTAuLi5DUFU3XS4gQW5kcm9pZCB1c2VzIFBoYW50b20gU0QgdG8gc3Vi
Z3JvdXAgQ1BVcyB3aXRoIHRoZSBzYW1lCj51YXJjaC4gVGhhdCdzIHdoeSB5b3UgZ2V0IHlvdXIg
TUMtPkRJRSBTRCdzIG9uIHlvdXIgc3lzdGVtIGFuZAo+U0hBUkVfUEtHX1JFU09VUkNFUyAoU2hQ
Uikgb24gTUMsIHJhdGhlciBESUUuCj4KPk5vdGUsIHlvdSBzaG91bGQgYWxyZWFkeSBoYXZlIGFu
IGFzeW1tZXRyaWMgU0QgaGllcmFyY2h5LiBDUFU3IHNob3VsZAo+b25seSBoYXZlIERJRSBub3Qg
TUMhIEVhY2ggQ1BVIGhhcyBpdHMgb3duIFNEIGhpZXJhcmNoeSEKPgo+PiB8IGNvcmUwwqAgY29y
ZTHCoCBjb3JlMsKgIGNvcmUzIHzCoCBjb3JlNCBjb3JlNSBjb3JlNiB8IGNvcmU3wqAgfAo+PiB8
wqDCoCBjb21wbGV4MMKgIHzCoMKgIGNvbXBsZXgxwqDCoCB8wqAgLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0twqDCoCB8Cj4+IHzCoMKgIEwyIGNhY2hlwqAgfMKgwqAgTDIgY2FjaGXCoMKgIHzCoMKg
IEwywqAgfMKgIEwyIHzCoCBMMsKgIHzCoMKgIEwywqDCoCB8Cj4+IHzCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTDMgY2FjaGXCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfAo+PiAKPj4gVGhlIHNjaGVkIGRvbWFp
biBub3c6Cj4+IERJRVswLTddwqAgKG5vIFNEX1NIQVJFX1BLR19SRVNPVVJDRVMpCj4+IE1DWzAt
M11bNC02XVs3XSAoU0RfU0hBUkVfUEtHX1JFU09VUkNFUykKPj4gCj4+IFRoZSBzY2hlZCBkb21h
aW4gc2hvdWxkIGJlOgo+PiBESUVbMC03XcKgIChTRF9TSEFSRV9QS0dfUkVTT1VSQ0VTKQo+PiBN
Q1swLTNdWzQtNl1bN10gKG5vIFNEX1NIQVJFX1BLR19SRVNPVVJDRVMpCj4KPkZpcnN0IHJlbWVt
YmVyLCB1c2luZyBQaGFudG9tIFNEIGluIEFuZHJvaWQgaXMgYWxyZWFkeSBhIGhhY2suIE5vcm1h
bGx5Cj55b3VyIHN5c3RlbSBzaG91bGQgb25seSBoYXZlIGFuIE1DIFNEIGZvciBlYWNoIENQVSAo
d2l0aCBTaFBSKS4KPgo+Tm93LCBpZiB5b3Ugd2FudCB0byBtb3ZlIFNoUFIgZnJvbSBNQyB0byBE
SUUgdGhlbiBhIGN1c3RvbSB0b3BvbG9neQo+dGFibGUgc2hvdWxkIGRvIGl0LCBpLmUuIHlvdSBk
b24ndCBoYXZlIHRvIGNoYW5nZSBhbnkgZ2VuZXJpYyB0YXNrCj5zY2hlZHVsZXIgY29kZS4KPgo+
c3RhdGljIGlubGluZSBpbnQgY3B1X2NwdV9mbGFncyh2b2lkKQo+ewo+wqDCoMKgwqDCoMKgIHJl
dHVybiBTRF9TSEFSRV9QS0dfUkVTT1VSQ0VTOwo+fQo+Cj5zdGF0aWMgc3RydWN0IHNjaGVkX2Rv
bWFpbl90b3BvbG9neV9sZXZlbCBjdXN0b21fdG9wb2xvZ3lbXSA9IHsKPiNpZmRlZiBDT05GSUdf
U0NIRURfU01UCj7CoMKgwqDCoMKgwqDCoCB7IGNwdV9zbXRfbWFzaywgY3B1X3NtdF9mbGFncywg
U0RfSU5JVF9OQU1FKFNNVCkgfSwKPiNlbmRpZgo+Cj4jaWZkZWYgQ09ORklHX1NDSEVEX0NMVVNU
RVIKPsKgwqDCoMKgwqDCoMKgIHsgY3B1X2NsdXN0ZXJncm91cF9tYXNrLCBjcHVfY2x1c3Rlcl9m
bGFncywgU0RfSU5JVF9OQU1FKENMUykgfSwKPiNlbmRpZgo+Cj4jaWZkZWYgQ09ORklHX1NDSEVE
X01DCj7CoMKgwqDCoMKgwqDCoCB7IGNwdV9jb3JlZ3JvdXBfbWFzaywgU0RfSU5JVF9OQU1FKE1D
KSB9LAo+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIF5eXl4KPiNlbmRpZgo+wqDCoMKgwqDCoMKgwqAgeyBjcHVfY3B1X21hc2ssIGNwdV9jcHVf
ZmxhZ3MsIFNEX0lOSVRfTkFNRShESUUpIH0sCj7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIF5eXl5eXl5eXl5eXl4KPsKgwqDCoMKgwqDCoMKgIHsgTlVMTCwg
fSwKPn07Cj4KPnNldF9zY2hlZF90b3BvbG9neShjdXN0b21fdG9wb2xvZ3kpOwoKSG93ZXZlciwg
ZHVlIHRvIHRoZSBsaW1pdGF0aW9uIG9mIEdLSSwgd2UgY2Fubm90IGNoYW5nZSB0aGUgc2QgdG9w
b2xvZ3kKYnkgb3Vyc2VsdmVzLiBCdXQgd2UgY2FuIGNvbmZpZ3VyZSBDUFUgYW5kIGNhY2hlIHRv
cG9sb2d5IHRocm91Z2ggRFQuCgpTbyB3aHkgbm90IGdldCB0aGUgU2hQUiBmcm9tIERUIGZpcnN0
PyBJZiBub3QgY29uZmlndXJlZCwgdXNlIHRoZSBkZWZhdWx0Lgo+Cj4+ICpDTFNbMC0xXVsyLTNd
KFNEX1NIQVJFX1BLR19SRVNPVVJDRVMpCj4KPkJ1dCB3aHkgZG8geW91IHdhbnQgdG8gaGF2ZSB5
ZXQgYW5vdGhlciBTRCB1bmRlcm5lYXRoIE1DIGZvciBDUFUwLUNQVTM/Cj5zZF9sbGMgaXMgYXNz
aWduZWQgdG8gdGhlIGhpZ2hlc3QgU2hQUiBTRCwgd2hpY2ggd291bGQgYmUgRElFLgoKV2Ugd2Fu
dCBkbyBzb21ldGhpbmcgZnJvbSB0aGUgc2hhcmVkIEwyIGNhY2hlKGZvciBjb21wbGV4LCBsaWtl
IHdhbHQpLCAKeW91IGNhbiBpZ25vcmUgaXQgaGVyZSBhbmQgdGFsayBhYm91dCBpdCB3aGVuIHdl
IGRvbmUuCgpUaGFua3MsCldhbmc=
