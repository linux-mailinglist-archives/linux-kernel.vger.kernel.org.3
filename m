Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A370D4F7217
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 04:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239171AbiDGCd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 22:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiDGCdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 22:33:25 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2123.outbound.protection.outlook.com [40.107.215.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 609A01FC9E1
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 19:31:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l09cZL29pzYMdXfrbyGDv+ZicWtXRZvNj5FNCtrneqGrT+AkxyF0qmSRnp4EZJ5Ed9HF+Foa6ebirCdNP1QfuBp7JIhLIIJCZLEapPOlLPbj8m+xYs5xaProDDM1R4SFSmxKsRg1ARnPRkFHqh2rr759zUJIBUjQ6OAC2okoTLeDHxxU210tTi3VhX5/un5qQ4fzmxq+lRgYmxkyhlVZIQBmc7uQmLzBWFWzqQTGbKJKrBxjrh3CZGK6Gnb8jdZkhP9Ap7SBfsPLFAha5q4zABPzNEhCd6fYJAse61zXtf+eZprlFqvdjMdrz4OqZgaoCGh0k8vvHpTh6cVBmviGBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqCFPOjWFc0jWbnvc6J0TOU2vZ2vym8ztb+XOjdCrSU=;
 b=aj4IwDJqCeW5bi4xIU/SB7XnOB9nJsmlLrU8ZaGaChOhc9wJLQUX+rbXRGx9HuQoPOuWsZAMKrq3Ow4PfmE2kp0ye3M6sdu8OPkITB7kaxMxiNtlhpEDE9FVQKisf75K2it7+cNO7sYR6n+wzViMkpFTvdyet3fn6IwbcjsOYNreLYLXp4KwUz7cv/N59fD5GDosIx9HKzdo18AcRKUGJzsfbedbOHlEINNeYPrh/St3fcY4cb0j7ZuJshPGORb4kMxCDzxVmEPdI9SvZMU41w2RGqqEAcyZ6l6UyAmMKMN0BW6EhfSOXSE4m8huahhUVGogQWrjV3uRXMmq8diBaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqCFPOjWFc0jWbnvc6J0TOU2vZ2vym8ztb+XOjdCrSU=;
 b=gTKGgeGiSWlFEoitRgqRIWhvUS4aA2m8KrtT8hD+Tw0mLQtvCMBO41JJ2XIHWDSz2CZKcxKUhpWOYDcbN8+Mab12NdUgXCaDD+CkT2qWTD7Wc6ovpjlTvDqhkhKpPgUy2bBcP6c1B15pfBOBKc5JNjZ8NoAnGdPNmn9fQaEoXdQ=
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by TYAPR06MB2189.apcprd06.prod.outlook.com (2603:1096:404:1d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Thu, 7 Apr
 2022 02:31:23 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::e468:c298:cfe5:84fc%6]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 02:31:23 +0000
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
Thread-Index: AQHYNH6wtHW6B7ixb027761a5egjaKy4qoqAgACydgyAAHYBAIAAAhW+gAAFIYCAAAqIMIAAJLWAgAWpZBWAAP4OgIAby4AIgANaj4CABAqgXQ==
Date:   Thu, 7 Apr 2022 02:31:22 +0000
Message-ID: <SL2PR06MB3082FA912CBF7F0DCF758AC8BDE69@SL2PR06MB3082.apcprd06.prod.outlook.com>
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
 <SL2PR06MB308281BAC7D7F7CBF136DCD3BDE39@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <CAKfTPtD9T4CF3QzE_ES9cwHa2VgRsuSx6bKyM4d69poxp7ou2w@mail.gmail.com>
In-Reply-To: <CAKfTPtD9T4CF3QzE_ES9cwHa2VgRsuSx6bKyM4d69poxp7ou2w@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cfb0fd27-6a1b-4a0c-9f20-08da183eb514
x-ms-traffictypediagnostic: TYAPR06MB2189:EE_
x-microsoft-antispam-prvs: <TYAPR06MB2189E4BE07B2FE83658BC4EDBDE69@TYAPR06MB2189.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2SDgCzlpCeBiyaY7T7oOL080XqLD3jaRE16qQriRIR93rufLD3gP4E0pHUSUe5LLso0VQBLLWlryiVn7UR1cRnwQoaJYS+QSqlQvOheDZ4FgBAfrATgln7cFM8I+Oor7St2NiYZBfCVAwifFCcHogMcZ2GczhwsGeF62cCpujIidMlaUoHGHKQzF6W2d+FQFND/i3F/dAHZdnBm/0n/dQ5hm5P9NkvOqD5LZfHBZkFWzNUnUsdspCEA5tFHh3iT77IohLH39PVHkW5kELngkgZjtsx1YTox5eBHWOYT5IOjMb1upey+ctgYY0ndZIwX0MSMDykG2CypqW8L2UH5QykAAslQi54Rq3tS/Nc02751nAJuU7qPX2giILpEUs0ojGCA9I1KcCjfJ4NsHR96ZQeqtwB+IWjMNxRpWz0rEtoBNuz5lPObjQtWCW7L+Ic/yorCuTA8sWQsh+HRINac6Ox3CD/yB6jqZgx5cWu0ydOVocgQZBrABDTRKJdjeSmHUT9zCWAZ+aG9obQxj81YV6n8dtin8HABt48XPVBIeZ99Z+0nxJKqneNSrjmELdCTaXfZdTmeF7NojoqwI2/VS7GwZzl4Tpn1T2ah2dn4pGZf+tCG5Eeo02bS3yvonG8v59wjBMp/ILdC7i6QUEu5imkVkKb+em/ZMvEWabup8r7AxJAoiNCH7rAdLUXyImKtFgSu4S7OTA8sPjwwy0Yx4iA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(122000001)(33656002)(38070700005)(86362001)(6916009)(66946007)(66476007)(66556008)(64756008)(66446008)(85182001)(4326008)(91956017)(76116006)(54906003)(5660300002)(316002)(9686003)(2906002)(8936002)(52536014)(7416002)(55016003)(6506007)(26005)(7696005)(186003)(8676002)(83380400001)(71200400001)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDNnWmZSUE1oMGx6RDRqTE1rbWZ6cTlQVmJYaVA2WDFQS3p2STRxRzVmWk45?=
 =?utf-8?B?WXdaRGNmYVhMNUwyZDZoMHBQajlLR3AxdXBjS1RMeHVxcG5wZG8zWmpHMng5?=
 =?utf-8?B?M25aM3NzTDE1OGlrc1YrUEx1TlgwQWNhNWRoM2d2QWo0eXBiNTRsWURQTUla?=
 =?utf-8?B?NDluSkpIOVpkdFUvbmdTWUhzbzR2VnR0aEdpYS9WblRETGhnNmNKZ0x2RmJh?=
 =?utf-8?B?NHRpQlIxNXV4VW9TeTNzV0djdEk0QjRyUURUbzFseUpFSXZ4cm5xZGM3V0Y1?=
 =?utf-8?B?TkphMVlSY3cwNlJXRUpBNStHZ3hSQ1FzRHFYTmVXemRYL01tQ0ZUYW5vdlFP?=
 =?utf-8?B?ZExKbkQ1ZkQ3bStZdVArd3FjVHAyNmFCU2pWNHlkdmhZR0JpMFdTMk4zVGo0?=
 =?utf-8?B?RzlZOEJyQkVtakpMRERqbGVvdkFyeDc5MEowdVY2d0xiYzVvS1pLSTI2UzEy?=
 =?utf-8?B?MG0ySUc3U1JJN1pLYnNoNk5KSHIzMUxML1BuMWgyRFM4TXdMamFQMnphc0Jq?=
 =?utf-8?B?LzViVHNFKzZKcDBNU2ExOE1EdDc4RnRqMStqM3FWQStuR3FGaFhuSXNVLzF0?=
 =?utf-8?B?VHFFVENoS1J3NERCMzFpWlA4aDJXSEIxTnptY0lmckJkWCtNaWRTM2pXdThr?=
 =?utf-8?B?alFFYjBVSzNLOUN1TDd5VVAwb0Q4UzFtbzEvZ3NObklVczZnUEJpc0g5NUtP?=
 =?utf-8?B?aDJyTS9ySk5CTUN5Q1NCQlo4elBMLzhqNWFIVjBXQVQvNzFIMUFoL1V5c3lz?=
 =?utf-8?B?WUpOdHd2R2NhbkRpTUpPbmRGcW96akJidFovUVJ1QzFKNG1YUzdSV3RZenZ3?=
 =?utf-8?B?UUVPZHRDYVZGS1JNcHVCNENJblRreXNhSkF5TEs3UWFVRVhEcGthWXdaTDUx?=
 =?utf-8?B?dmwvekRwWittVkpiL2xrRnJlSTEvcDg3S29TYTFGekRSS2crWitzU0FQM2FN?=
 =?utf-8?B?bzJZTVRnMFdzZEJHQjVDK21rdjFpNVFOdnIwcjl2QWVnZTVUcHZ3bmdaNDZG?=
 =?utf-8?B?cjRXWjdEOXhRQ3d3OFhyd2tyLzh5d0JqV3NRUDB0aWdmMVJtdVdaL09BUjRP?=
 =?utf-8?B?Nng4ZmhNbU5oRlRCelZjZlFad2ZOUFpCL09DNFpZS1lEUGFyUFVJUGtwb2Qv?=
 =?utf-8?B?TmJMeHlTamVoTU1ZY1BhZ1lUVG9EL3MyUExhUUFkeXJneTBDVnhZKzk3OEdq?=
 =?utf-8?B?NUNPcjU3c2Q2QlhWVDJMendvaVNVZnM2SElBNjZMRG9xYXczYndBeFBha0tr?=
 =?utf-8?B?RHZ6ak5iVFlCSm40SytqNkRZaUNBNzd0emRRMkF5UTBCaEw1Y3JIbTZ4STRp?=
 =?utf-8?B?YzQ2NmtSZVozdVg5UTl5Qno5LzgyQ0JXblNoKzR1Y0VwZHRrdHp3Y1g4a1cv?=
 =?utf-8?B?dW4vSUxHQS9QME5VbGdpNG9aeTMxWmcyVitCYWMvZnl2N0JUd1daT1FMb2NC?=
 =?utf-8?B?Wk9nOWd2cVZJeG1XUWVVeGxMWnBLaFA0Z0ZXR1BXdnZ5bnczMW8vWjZPYTA4?=
 =?utf-8?B?TkRkTFlRMEx2STZsZXovK0dueUtrSU16NXAzNTdPeFRJeVQwclBrT1luWDE2?=
 =?utf-8?B?emk1bHo1bmlmY25QcEV1UmwwU0FMeTNhWS9tS1dVMS95M3h0SlZSYllPa1NN?=
 =?utf-8?B?WUNNNjRlem9sZ2lMM3d4ODVvb1dDQVYvZ0ZBNHU1dkhQMjRIa21OcTJBdmNr?=
 =?utf-8?B?RU0zcGE4Z1plQmR2YTR1KzZtRExOdWt4SzltVmhDM1ZXR2VZdHJVdFJKVmxq?=
 =?utf-8?B?dFovdk9uaWh4N3NzL2hJaFZ0UnNEcUd4UmY5dmRJc1JXT25PWVdwUnB1RVAz?=
 =?utf-8?B?NUVkdDJzcm9MSzhiUDh3L2FyLzJHM01VZys3bk53UnRTNjNWaTNnOWRuSjU3?=
 =?utf-8?B?VHN3cjA5VFFCT0xiTGNzQlFlMVg1TzUrWEM2UnRYUUtCRlVmdC9kSm5pWHVR?=
 =?utf-8?B?V2dqc3pGSSs3MlU5b2ZOaTlGUzNDUzBweko1TG9uZFJ4YjBUOWp1VlROQk0y?=
 =?utf-8?B?dGdVbUxhdnA0elJxenIyUCtKc3N3Q2ltcFRQeDl2TEE4OFYvZWtHYWQrN2dl?=
 =?utf-8?B?dEFNMU1heCtrRGtDWitOTFJxTUYvRSsxOUhKT3ZXVDZXVTBPNkwzTGpkdTFD?=
 =?utf-8?B?VCtRalc4Rjh2SGduYkI2Sjk3L0lPVkFJRUpPOTY2OFlDdzVmSGt4eVBvQkta?=
 =?utf-8?B?b3Rlb21YZlpGMFQ4QjlNbWt5NXd6OTlVNzhucXptVHdXbXlEdVgzdFdQOTV5?=
 =?utf-8?B?NUVPcWdFU0FHcE0yN1pMMTZBWkljbnE2SE5vcjVBbnd6aTA4TjZkVEFEZ1Ra?=
 =?utf-8?Q?wEW9pzzK4YfVTxPwd6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfb0fd27-6a1b-4a0c-9f20-08da183eb514
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 02:31:22.7350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rqJo7NaAkLMOf3kk6mdVWpJH9Gffz7Zh6H/lms7wcvCOULzxZH2PqkJzuvDLBUDTKCmV0nalnsw+RO/MxMHr7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR06MB2189
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj4+Cj4+Cj4+ID4+Cj4+ID4+Cj4+ID4+ID4+Cj4+ID4+ID4+Cj4+ID4+ID4+ID4+Cj4+ID4+ID4+
ID4+Cj4+ID4+ID4+ID4+ID4+Cj4+ID4+ID4+ID4+ID4+Cj4+ID4+ID4+ID4+ID4+ID5PbiBUaHUs
IDEwIE1hciAyMDIyIGF0IDEzOjU5LCBRaW5nIFdhbmcgPHdhbmdxaW5nQHZpdm8uY29tPiB3cm90
ZToKPj4gPj4gPj4gPj4gPj4gPj4KPj4gPj4gPj4gPj4gPj4gPj4gRnJvbTogV2FuZyBRaW5nIDx3
YW5ncWluZ0B2aXZvLmNvbT4KPj4gPj4gPj4gPj4gPj4gPj4KPj4gPj4gPj4gPj4gPj4gPj4gU29t
ZSBhcmNoaXRlY3R1cmVzKGUuZy4gQVJNNjQpLCBjYWNoZXMgYXJlIGltcGxlbWVudGVkIGJlbG93
Ogo+PiA+PiA+PiA+PiA+PiA+PiBjbHVzdGVyOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgKioqKioqIGNsdXN0ZXIgMCAqKioqKsKgwqDCoMKgwqAgKioqKioqIGNsdXN0
ZXIgMSAqKioqKgo+PiA+PiA+PiA+PiA+PiA+PiBjb3JlOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAwwqDCoMKgwqDCoCAxwqDCoMKgwqDCoMKgwqDCoMKg
IDLCoMKgwqDCoMKgIDPCoMKgwqDCoMKgwqDCoMKgwqAgNMKgwqDCoMKgwqAgNcKgwqDCoMKgwqDC
oMKgwqDCoMKgIDbCoMKgwqDCoMKgIDcKPj4gPj4gPj4gPj4gPj4gKGFkZCBjYWNoZSBsZXZlbCAx
KcKgwqDCoMKgwqDCoMKgIGMwwqDCoMKgIGMxwqDCoMKgwqDCoMKgwqAgYzLCoMKgwqAgYzPCoMKg
wqDCoMKgwqDCoMKgIGM0wqDCoMKgIGM1wqDCoMKgwqDCoMKgwqDCoCBjNsKgwqDCoCBjNwo+PiA+
PiA+PiA+PiA+PiA+PiBjYWNoZShMZXZlbG4pOsKgwqDCoMKgwqDCoMKgwqAgKipjYWNoZTAqKsKg
ICoqY2FjaGUxKirCoCAqKmNhY2hlMioqwqAgKipjYWNoZTMqKgo+PiA+PiA+PiA+PiA+PiAoYWRk
IGNhY2hlIGxldmVsIDMpwqDCoMKgwqDCoMKgwqAgKioqKioqKioqKioqKnNoYXJlIGxldmVsIDMg
Y2FjaGUgKioqKioqKioqKioqKioqCj4+ID4+ID4+ID4+ID4+ID4+IHNkX2xsY19pZChjdXJyZW50
KTrCoMKgwqDCoCAwwqDCoMKgwqDCoCAwwqDCoMKgwqDCoMKgwqDCoMKgIDDCoMKgwqDCoMKgIDDC
oMKgwqDCoMKgwqDCoMKgwqAgNMKgwqDCoMKgwqAgNMKgwqDCoMKgwqDCoMKgwqDCoMKgIDTCoMKg
wqDCoMKgIDQKPj4gPj4gPj4gPj4gPj4gPj4gc2RfbGxjX2lkKHNob3VsZCBiZSk6IDDCoMKgwqDC
oMKgIDDCoMKgwqDCoMKgwqDCoMKgwqAgMsKgwqDCoMKgwqAgMsKgwqDCoMKgwqDCoMKgwqDCoCA0
wqDCoMKgwqDCoCA0wqDCoMKgwqDCoMKgwqDCoMKgwqAgNsKgwqDCoMKgwqAgNgo+PiA+PiA+PiA+
PiA+PiA+Pgo+PiA+PiA+PiA+PiA+PiBIZXJlLCBuIGFsd2F5cyBiZSAyIGluIEFSTTY0LCBidXQg
b3RoZXJzIGFyZSBhbHNvIHBvc3NpYmxlLgo+PiA+PiA+PiA+PiA+PiBjb3JlWzAsMV0gZm9ybSBh
IGNvbXBsZXgoQVJNVjkpLMKgIHdoaWNoIHNoYXJlIEwyIGNhY2hlLCBjb3JlWzIsM10gaXMgdGhl
IHNhbWUuCj4+ID4+ID4+ID4+ID4+Cj4+ID4+ID4+ID4+ID4+ID4+IENhY2hlcyBhbmQgY3B1cyBo
YXZlIGRpZmZlcmVudCB0b3BvbG9neSwgdGhpcyBjYXVzZXMgY3B1c19zaGFyZV9jYWNoZSgpCj4+
ID4+ID4+ID4+ID4+ID4+IHJldHVybiB0aGUgd3JvbmcgdmFsdWUsIHdoaWNoIHdpbGwgYWZmZWN0
IHRoZSBDUFUgbG9hZCBiYWxhbmNlLgo+PiA+PiA+PiA+PiA+PiA+Pgo+PiA+PiA+PiA+PiA+PiA+
V2hhdCBkb2VzIHlvdXIgY3VycmVudCBzY2hlZHVsZXIgdG9wb2xvZ3nCoCBsb29rIGxpa2U/Cj4+
ID4+ID4+ID4+ID4+ID4KPj4gPj4gPj4gPj4gPj4gPkZvciBDUFUgMCB0byAzLCBkbyB5b3UgaGF2
ZSB0aGUgYmVsb3cgPwo+PiA+PiA+PiA+PiA+PiA+RElFIFswwqDCoMKgwqAgLcKgwqDCoMKgIDNd
IFs0LTddCj4+ID4+ID4+ID4+ID4+ID5NQ8KgIFswXSBbMV0gWzJdIFszXQo+PiA+PiA+PiA+PiA+
Pgo+PiA+PiA+PiA+PiA+PiBUaGUgY3VycmVudCBzY2hlZHVsZXIgdG9wb2xvZ3kgY29uc2lzdGVu
dCB3aXRoIENQVSB0b3BvbG9neToKPj4gPj4gPj4gPj4gPj4gRElFwqAgWzAtN10KPj4gPj4gPj4g
Pj4gPj4gTUPCoCBbMC0zXSBbNC03XcKgIChTRF9TSEFSRV9QS0dfUkVTT1VSQ0VTKQo+PiA+PiA+
PiA+PiA+PiBNb3N0IEFuZHJvaWQgcGhvbmVzIGhhdmUgdGhpcyB0b3BvbG9neS4KPj4gPj4gPj4g
Pj4gPj4gPgo+PiA+PiA+PiA+PiA+PiA+QnV0IHlvdSB3b3VsZCBsaWtlIHNvbWV0aGluZyBsaWtl
IGJlbG93IGZvciBjcHUgMC0xIGluc3RlYWQgPwo+PiA+PiA+PiA+PiA+PiA+RElFIFswwqDCoMKg
wqAgLcKgwqDCoMKgIDNdIFs0LTddCj4+ID4+ID4+ID4+ID4+ID5DTFMgWzAgLSAxXSBbMiAtIDNd
Cj4+ID4+ID4+ID4+ID4+ID5NQ8KgIFswXSBbMV0KPj4gPj4gPj4gPj4gPj4gPgo+PiA+PiA+PiA+
PiA+PiA+d2l0aCBTRF9TSEFSRV9QS0dfUkVTT1VSQ0VTIG9ubHkgc2V0IHRvIE1DIGxldmVsID8K
Pj4gPj4gPj4gPj4gPj4KPj4gPj4gPj4gPj4gPj4gV2UgZG9uJ3QgY2hhbmdlIHRoZSBjdXJyZW50
IHNjaGVkdWxlciB0b3BvbG9neSwgYnV0IHRoZQo+PiA+PiA+PiA+PiA+PiBjYWNoZSB0b3BvbG9n
eSBzaG91bGQgYmUgc2VwYXJhdGVkIGxpa2UgYmVsb3c6Cj4+ID4+ID4+ID4+ID4KPj4gPj4gPj4g
Pj4gPlRoZSBzY2hlZHVsZXIgdG9wb2xvZ3kgaXMgbm90IG9ubHkgY3B1IHRvcG9sb2d5IGJ1dCBh
IG1peGVkIG9mIGNwdSBhbmQKPj4gPj4gPj4gPj4gPmNhY2hlL21lbW9yeSBjYWNoZSB0b3BvbG9n
eQo+PiA+PiA+PiA+PiA+Cj4+ID4+ID4+ID4+ID4+IFswLTddwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKHNoYXJlZCBsZXZlbCAzIGNhY2hlICkKPj4g
Pj4gPj4gPj4gPj4gWzAtMV0gWzItM11bNC01XVs2LTddwqDCoCAoc2hhcmVkIGxldmVsIDIgY2Fj
aGUgKQo+PiA+PiA+PiA+PiA+Cj4+ID4+ID4+ID4+ID5TbyB5b3UgZG9uJ3TCoCBib3RoZXIgdGhl
IGludGVybWVkaWF0ZSBjbHVzdGVyIGxldmVsIHdoaWNoIGlzIGV2ZW4gc2ltcGxlci4KPj4gPj4g
Pj4gPj4gPnlvdSBoYXZlIHRvIG1vZGlmeSBnZW5lcmljIGFyY2ggdG9wb2xvZ3kgc28gdGhhdCBj
cHVfY29yZWdyb3VwX21hc2sKPj4gPj4gPj4gPj4gPnJldHVybnMgdGhlIGNvcnJlY3QgY3B1IG1h
c2sgZGlyZWN0bHkuCj4+ID4+ID4+ID4+ID4KPj4gPj4gPj4gPj4gPllvdSB3aWxsIG5vdGljZSBh
IGxsY19zaWJsaW5nIGZpZWxkIHRoYXQgaXMgY3VycmVudGx5IHVzZWQgYnkgYWNwaSBidXQKPj4g
Pj4gPj4gPj4gPm5vdCBEVCB0byByZXR1cm4gbGxjIGNwdSBtYXNrCj4+ID4+ID4+ID4+ID4KPj4g
Pj4gPj4gPj4gY3B1X3RvcG9sb2d5W10ubGxjX3NpYmxpbmcgZGVzY3JpYmUgdGhlIGxhc3QgbGV2
ZWwgY2FjaGUgb2Ygd2hvbGUgc3lzdGVtLAo+PiA+PiA+PiA+PiBub3QgaW4gdGhlIHNjaGVkX2Rv
bWFpbi4KPj4gPj4gPj4gPj4KPj4gPj4gPj4gPj4gaW4gdGhlIGFib3ZlIGNhY2hlIHRvcG9sb2d5
LCBsbGNfc2libGluZyBpcyAweGZmKFswLTddKSAsIGl0IGRlc2NyaWJlcwo+PiA+PiA+PiA+Cj4+
ID4+ID4+ID5JZiBsbGNfc2libGluZyB3YXMgMHhmZihbMC03XSBvbiB5b3VyIHN5c3RlbSwgeW91
IHdvdWxkIGhhdmUgb25seSBvbmUgbGV2ZWw6Cj4+ID4+ID4+ID5NQ1swLTddCj4+ID4+ID4+Cj4+
ID4+ID4+IFNvcnJ5LCBidXQgSSBkb24ndCBnZXQgaXQsIHdoeSBsbGNfc2libGluZyB3YXMgMHhm
ZihbMC03XSBtZWFucyBNQ1swLTddPwo+PiA+PiA+PiBJbiBvdXIgc3lzdGVtKEFuZHJvaWQpLCBs
bGNfc2libGluZyBpcyBpbmRlZWQgMHhmZihbMC03XSkgLCBiZWNhdXNlIHRoZXkKPj4gPj4gPj4g
c2hhcmVkIHRoZSBsbGMoTDMpLCBidXQgd2UgYWxzbyBoYXZlIHR3byBsZXZlbDoKPj4gPj4gPj4g
RElFIFswLTddCj4+ID4+ID4+IE1DIFswLTNdWzQtNl0KPj4gPj4gPj4gSXQgbWFrZXMgc2Vuc2Us
IFswLTNdIGFyZSBsaXR0bGUgY29yZXMsIFs0LTddIGFyZSBiaXQgY29yZXMsIHNlIG9ubHkgdXAg
bWlncmF0ZQo+PiA+PiA+PiB3aGVuIG1pc2ZpdC4gV2Ugd29uJ3QgY2hhbmdlIGl0Lgo+PiA+PiA+
Pgo+PiA+PiA+PiA+Cj4+ID4+ID4+ID4+IHRoZSBMMyBjYWNoZSBzaWJsaW5nLCBidXQgc2RfbGxj
X2lkIGRlc2NyaWJlcyB0aGUgbWF4aW11bSBzaGFyZWQgY2FjaGUKPj4gPj4gPj4gPj4gaW4gc2Qs
IHdoaWNoIHNob3VsZCBiZSBbMC0xXSBpbnN0ZWFkIG9mIFswLTNdLgo+PiA+PiA+PiA+Cj4+ID4+
ID4+ID5zZF9sbGNfaWQgZGVzY3JpYmVzIHRoZSBsYXN0IHNjaGVkX2RvbWFpbiB3aXRoIFNEX1NI
QVJFX1BLR19SRVNPVVJDRVMuCj4+ID4+ID4+ID5JZiB5b3Ugd2FudCBsbGMgdG8gYmUgWzAtM10g
bWFrZSBzdXJlIHRoYXQgdGhlCj4+ID4+ID4+ID5zY2hlZF9kb21haW5fdG9wb2xvZ3lfbGV2ZWwg
YXJyYXkgcmV0dXJucyB0aGUgY29ycmVjdCBjcHVtYXNrIHdpdGgKPj4gPj4gPj4gPnRoaXMgZmxh
Zwo+PiA+PiA+Pgo+PiA+PiA+PiBBY3R1cmVseSwgd2Ugd2FudCBzZF9sbGMgdG8gYmUgWzAtMV0g
WzItM10sIGJ1dCBpZiB0aGUgTUMgZG9tYWluIGRvbid0IGhhdmUKPj4gPj4gPgo+PiA+PiA+c2Rf
bGxjX2lkIHJlZmVycyB0byBhIHNjaGVkdWxlciBkb21haW4gYnV0IHlvdXIgcGF0Y2ggYnJlYWtz
IHRoaXMgc28KPj4gPj4gPmlmIHlvdSB3YW50IGEgbGxjIHRoYXQgcmVmbGVjdHMgdGhpcyB0b3Bv
OsKgIFswLTFdIFsyLTNdIHlvdSBtdXN0Cj4+ID4+ID5wcm92aWRlIGEgc2NoZWRfZG9tYWluIGxl
dmVsIHdpdGggdGhpcyB0b3BvCj4+ID4+Cj4+ID4+IE1heWJlIHdlIHNob3VsZCBhZGQgYSBzaGFy
ZWQtY2FjaGUgbGV2ZWwoU0MpLCBsaWtlIHdoYXQgQ0xTIGRvZXM6Cj4+ID4+Cj4+ID4+IERJRcKg
IFswLTddIChzaGFyZWQgbGV2ZWwgMyBjYWNoZSwgU0RfU0hBUkVfUEtHX1JFU09VUkNFUykKPj4g
Pj4gTUPCoCBbMC0zXSBbNC03XcKgIChub3QgU0RfU0hBUkVfUEtHX1JFU09VUkNFUykKPj4gPj4g
Q0xTwqAgKGlmIG5lY2Vzc2FyeSkKPj4gPj4gU0PCoMKgwqAgWzAtMV1bMi0zXVs0LTVdWzYtN10g
KHNoYXJlZCBsZXZlbCAyIGNhY2hlLCBTRF9TSEFSRV9QS0dfUkVTT1VSQ0VTKQo+PiA+PiBTTVQg
KGlmIG5lY2Vzc2FyeSkKPj4gPj4KPj4gPj4gU0MgbWVhbnMgYSBjb3VwbGUgb2YgQ1BVcyB3aGlj
aCBhcmUgcGxhY2VkIGNsb3NlbHkgYnkgc2hhcmluZwo+PiA+PiBtaWQtbGV2ZWwgY2FjaGVzLCBi
dXQgbm90IGVub3VnaCB0byBiZSBhIGNsdXN0ZXIuCj4+ID4KPj4gPndoYXQgeW91IG5hbWUgU0Mg
YWJvdmUgbG9va3MgdGhlIHNhbWUgYXMgQ0xTIHdoaWNoIHNob3VsZCBub3QgYmUgbWl4ZWQKPj4g
PndpdGggQXJtIGNsdXN0ZXIgdGVybWlub2xvZ3kKPj4KPj4gRG8geW91IG1lYW4gY2x1c3RlciBp
cyBlcXVhbCB0byBzaGFyZWQgY2FjaGUgaW5zdGVhZCBvZiBjb250YWluaW5nLCBTQyBqdXN0Cj4+
IG1lYW5zIHNoYXJlZCBjYWNoZSwgYnV0IG5vdCBmb3JtIGEgY2x1c3RlciwgYSBDTFMgY2FuIGNv
bnRhaW4gbWFueSBTQ3MuCj4KPkNMUyBpbiB0aGUgc2NoZWR1bGVyIHRvcG9sb2d5IGlzIG5vdCBz
dHJpY3RseSB0aWVkIHRvIHRoZSAiQXJtCj5jbHVzdGVyIiBidXQgaXQncyB0aGUgZ2VuZXJpYyBu
YW1lIHRvIGRlc2NyaWJlIGFuIGludGVybWVkaWF0ZSBncm91cAo+b2YgQ1BVcyB3aXRoIGNvbW1v
biBwcm9wZXJ0aWVzLiBDTFMgaXMgYWxzbyB1c2VkIGJ5IHNvbWUgaW50ZWwKPnBsYXRmb3JtcyBh
cyBhbiBleGFtcGxlLiBXaGF0IEkgbWVhbiBpcyB0aGF0IHlvdSBjYW4gdXNlIHRoZSBzY2hlZHVs
ZXIKPkNMUyBsZXZlbCB0byBkZXNjcmliZSB3aGF0IHlvdSBjYWxsIGFuIEFybSBTQyBsZXZlbC4K
Ckl0IHdvbid0IHdvcmssIGJlY2F1c2UgY2x1c3Rlcl9zaWJsaW5nIGlzIGFzc2lnbmVkIGFjY29y
ZGluZyB0byBjbHVzdGVyX2lkLCAKd2hpY2ggaXMgc3RyaWN0bHkgdGllZCB0byB0aGUgIkFybSBj
bHVzdGVyIi4KQW5kIGlmIHdlIGhhdmUgdXNlZCBDTFMgdG8gZGVzY3JpYmUgdGhlIGNsdXN0ZXIg
c2QsIGhvdyBkbyB3ZSBkZXNjcmliZQpzaGFyZWQgY2FjaGUgc2QsIGxpa2UgY29tcGxleCwgd2hp
Y2ggc2hhcmVkIHNlbGYgY2FjaGUgd2l0aGluIGEgY2x1c3Rlci4KPgo+Pgo+PiBJZiBhcyB5b3Ug
c2FpZCwgU0MgbG9va3MgdGhlIHNhbWUgYXMgQ0xTLCBzaG91bGQgd2UgcmVuYW1lIENMUyB0byBT
QyB0bwo+PiBhdm9pZCBjb25mdXNpb24/Cj4KPkNMUyBpcyBhIGdlbmVyaWMgc2NoZWR1bGVyIG5h
bWUgYW5kIEkgZG9uJ3QgdGhpbmsgdGhhdCB3ZSBuZWVkIHRvCj5yZW5hbWUgaXQgdG8gYSBBcm0g
c3BlY2lmaWMgbGFiZWwKCkkgc3RpbGwgaW5zaXN0IG9uIGFkZGluZyBzYyBsZXZlbCB3aXRoaW4g
dGhlIGNscywgYmVjYXVzZSBtYXliZSB3ZSBoYXZlIAphbHJlYWR5IHVzZWQgQ0xTIHRvIGRlc2Ny
aWJlIHRoZSBjbHVzdGVyIHNkLCBwbGVhc2UgY29uc2lkZXIgYWJvdXQgaXQuCgpUaGFua3MsCldh
bmcKCj4KPlRoYW5rcywKPlZpbmNlbnQKPgo+Pgo+PiBUaGFua3MsCj4+IFdhbmc=
