Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0AF4D5E70
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 10:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347491AbiCKJbj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 04:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiCKJbf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 04:31:35 -0500
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2136.outbound.protection.outlook.com [40.107.215.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218851BE0C9
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 01:30:30 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AqAeCVUhTeTkvuD1edX5hb7FPL+zGbwAJVYvXPAZChRIJ4Y/TiWxCiz/r91BkogdtVwu5BCHrQF6NyNfAub1KISIuLsQbQqcsX89XK2owoVymUlA2u5mQ4fENJ/+d+tMN4NF1poA8gBMz3dOUe9F66jr4kvXi6gojOBfoDLBGpa8rhUPfluC60PU7XXYdtr/fz+hIAfEQ1NeQAzOIRyd25DqdD8J00J6GFSkJPB1+wwmof/L5bbA8Q8ZEdg31xEaqpeVyimm2IsLrOOLDkEeuy+Wz3liQIZCfBbz7jbA93onWweuttmHTc/PJXrNmnMKtPA7xgFkMODR8UyG3wnFlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n+QLYmTV96cZjXjAxNXnlUb3pMOKacrxQvMfK15Rtp4=;
 b=CijK0flP6iuj8drRwDy45yZ2Fq/v00y7Z1urGzVanszH93AcUFoesc8F8hlSo06TBrvY78TlpXO99emt0EQ35jc+MZn1L3AWsTHABRbIFKPsvRYytlQBo1PrLenIkIsrdL56qhA8Hs6Qx1iAhuuYAugI1rRqHq4+j5+XU+e+DmURNIk5vaGVWmKjHkqe3Tnm6E/zboIS2qZgGin/cgIFDN34clbNd2Pq/szeF646+ZTV1t49KLyoU0ZWM56l8PxJM8r0W+0g2xBfETTsWrSuyuxEOJepJiTyC5xxjg0g8JM6xpoVZ+pHYD8K4NkRh2DVOW7LDe1UG/r/5RBcFObaCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n+QLYmTV96cZjXjAxNXnlUb3pMOKacrxQvMfK15Rtp4=;
 b=FQiY7EP9sBVlaeN7jQOdNR/CkH+dRGJDQD8VS7aJoRcA+UcLh9rKCJMAKHBUsrx/H4soMmX0MTvkFtBmntD3gknawCQuGg+Zr35Z264BK6y3fp2dUTnkc/5FlnLgE7EqE2iPbUWMIas+DBgQ0RMYljTr5Kv8y92Xscq/9dD35FA=
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by TYZPR06MB5074.apcprd06.prod.outlook.com (2603:1096:400:1c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.26; Fri, 11 Mar
 2022 09:30:24 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::49ef:baa:8c3b:cb3d]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::49ef:baa:8c3b:cb3d%5]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 09:30:24 +0000
From:   =?utf-8?B?546L5pOO?= <wangqing@vivo.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
CC:     Catalin Marinas <Catalin.Marinas@arm.com>,
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
Subject: RE: [PATCH] sched: topology: make cache topology separate from cpu
 topology
Thread-Topic: [PATCH] sched: topology: make cache topology separate from cpu
 topology
Thread-Index: AQHYNH6wtHW6B7ixb027761a5egjaKy4qoqAgACydgyAAHYBAIAAAhW+gAAFIYCAAAqIMA==
Date:   Fri, 11 Mar 2022 09:30:24 +0000
Message-ID: <SL2PR06MB308268BDF646BFA0FC9A4590BD0C9@SL2PR06MB3082.apcprd06.prod.outlook.com>
References: <1646917125-20038-1-git-send-email-wangqing@vivo.com>
 <CAKfTPtAvbpUUaOqP3gmOT7fLk8-7v70LzBUiQ-vgDvc7ZZujag@mail.gmail.com>
 <SL2PR06MB30828CF9FF2879AFC9DC53D2BD0C9@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <CAKfTPtBM9WBEgP_PpRHNaATvp9FrBeV2NXhg_EAp4xYtBZYCWQ@mail.gmail.com>
 <SL2PR06MB30826C314139509EC4778C1BBD0C9@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <CAKfTPtA=dy4M2OK+GqvPDo9D8YBZAHbEpM-YPVZEyEUjEJKU5g@mail.gmail.com>
In-Reply-To: <CAKfTPtA=dy4M2OK+GqvPDo9D8YBZAHbEpM-YPVZEyEUjEJKU5g@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 17717563-a407-53aa-6eff-85e216ae9b25
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d3e031d2-d993-426d-c2c3-08da0341c583
x-ms-traffictypediagnostic: TYZPR06MB5074:EE_
x-microsoft-antispam-prvs: <TYZPR06MB507422E9C64C389E9BB317EEBD0C9@TYZPR06MB5074.apcprd06.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wxi2vrEH3woRnT1r9+5ylPY9Np0aQ67fG4t+EL8gFB10Kx3Rz/O/Txj5s66zVqLaX4movHCdFdGLI0fWsfq7c84IyH9nQGgEfQ7cIs4Qxtk6ff6qq+QNy8smtWyP8LgYlDW2NFHQVLBiXN9S0ZqiIxwJHG0cKIdE59HppQWNTdvLaB/C1etYwPvnvTwmjUklci/2XrJYxG82+AtYbd+5uYUhBESm5w7Xq6sgT8w9Oj9RrqsFwolAHYxjYjIqXOAfXqxX0o6YeA+tkzrqfOwQ2TEkbXNnmX+Hqmx9JoLNmKYbozwGAQr+I4BdvkNgMWnRWiMmBZELDl2bFgPhLiaZP6oaSYskmswMeFcOiVTeZ0GoXo6q3EVJ6dhwkCTovkQSfN/uFTSgibgxYvixBOSciwvMc2BWKLHhT93qKS/weVkfXnDbjpsjrkvrqWoBJAJZB888p21t/Ntx7aZ/VKPtH0UggY3cjd3k9pH1dfdb8I+yGoX77bxaDXYOx2AR32088xyxbKyXDZjxzhZDOzzbtZCCSB9df3ViOBzN7KdwlIwqNqgti5ZTEaz9GQdvUHy/3uJF/26IhfpktyJKmr7qIpsZJLgbLlc9yv1asIrI10mZGTtBYGtIovjhYOnMj6rPOsbkAgX45jNxVMOhKQhLJk1HwSGc7gD0CUNSDejwTnqbPzf5/C6TR2QrV34nSsFuQVNOIMV6wXlC/NjPSX8LDg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(91956017)(71200400001)(66476007)(6916009)(8676002)(66446008)(66946007)(54906003)(83380400001)(316002)(7416002)(508600001)(85182001)(9686003)(5660300002)(64756008)(76116006)(2906002)(26005)(52536014)(7696005)(6506007)(8936002)(186003)(38100700002)(122000001)(38070700005)(55016003)(86362001)(33656002)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K2ZtWVUvc1ZWN2ltZC9icWtReFIzdXdWSFdrTTFCYmpPWWgyMXRmdnlNSWU0?=
 =?utf-8?B?N2taRUR0eHJOVjE3UFU0cGJJcGhpWFQwY3lKdGRjM2FOVDFiNHhPVWg5Rlpu?=
 =?utf-8?B?R0RrSmNsY2c0RnZ0L0EvMEdTSW5aeGpjczRMRzErS0FTaEVlNFJwMW1TNVdN?=
 =?utf-8?B?c0Rhd3RpQTcxQU1ETXJ6VVdkYUxIUXRsS2J6Y2dYQ1J5cmFjWkFCaWhvcVd1?=
 =?utf-8?B?eGNNV2ZjWWV3WjBML1psaWJXcGYybXlvUGI0WkppYUNvRDlXSnBjeHhLZHY2?=
 =?utf-8?B?ZzVibEZQcVNvcTJvdVVFTXdKZkJzT0VUK3FGRjdFbHRPcStVYVp0VEtSY3Ir?=
 =?utf-8?B?UTZ1MFgrdXZVQUpBMCsydUtvYU9mTXQvekw2czFVdk14TTRmZHRpTE01d1Bu?=
 =?utf-8?B?bGp3YTBqT05xZUdKRTAvWGhVdEhDMEk5WncwVUdkZzZrakU1V2NjZlZPUjNw?=
 =?utf-8?B?WXZWMWp1N2hKaVhSRGZ3NVErbXhRN25UYkhOS3UwWVlNVkxQbWVkS01GM2wv?=
 =?utf-8?B?M08wbmkyTDREbElpdFQ2RkdPMzB6amJWNllubmRKN3oyall4ODc1NzdzMXhm?=
 =?utf-8?B?TGN6eWVrS3VneXZUMXo3d1Rpc0ZMQlRXbloveDUzSEZJWXJBc1Q1cENiMlRN?=
 =?utf-8?B?VWtwUWpwLytuNDBQMWtCMk5DNk9kM1p4Wm04N1poUHNWN3M3am94dWswMDN1?=
 =?utf-8?B?eDYzU1ZYc0UzQlVvNk0wdkN4bmE3MlhtZGtCZy9GZ1ZmUXdqTXhhL3Vrb1Fj?=
 =?utf-8?B?ZjZFVE9GOEhsTWxQZWp2N0I5MThRRDltc2FkT2ZqdUFaTEhCSlU4REVvVXlW?=
 =?utf-8?B?NEszTERsTmZaU25mVWd6eUZoNHBmeEJ3ODZIQ3FuZS9pZk5FWk85dzdQS3Ns?=
 =?utf-8?B?bC9hbVJ1OWZpUk12RUkraGYxSURpWTJlQUY2N1lCNDBYc3ZacTY1Um00SzYv?=
 =?utf-8?B?TmlsSG5HYktwcThkeDhVempvYnpva3VYQ1V6c1pNeFFuanZpb3Jlb3VxNlhI?=
 =?utf-8?B?cm9ZV2FEQXZPOWlPSXBMNGhzWlhKczJMWFN0WTRzSXNPaDg4Y1RKQWRNMVRp?=
 =?utf-8?B?KzJqMWxRejdabmljbW5jTFVCaE5kRjkyQjc1YzlkamtLREc2cXFtYXlTQW0v?=
 =?utf-8?B?NmNEdHVoOXhlaUtyTFlJTG5tV2JvQWtNdzk4anBtN1ZtcTVkRGQ2Z08vWUpP?=
 =?utf-8?B?d0IvZjJXdzFHbXdQbTlHMzRVMEh6YTBCT1BFTUtZN2RPYnl3amJ0S2Fxd09x?=
 =?utf-8?B?WkNiRFBPTlVDVXh2NlBFVGJjQlFxa3J2OE9tdk5KVDJDSXR6c1pGU1kyalVI?=
 =?utf-8?B?YWhBbUtHRDlnemJ4NnlnK2d2YjJWdEFVbjFEb2ovMnQwZUFwZjVaejByeVRG?=
 =?utf-8?B?eHlWQjBKanE5UUJJUVhEakF1S3NESFErMTZJaEN0M0JFbHhLZ2lIOE5EbTZL?=
 =?utf-8?B?aGx2RVNnek9LcGRhK2dYZnpPVjRKTm5IRUljSDY5M0NRR3o1SGx1QXhSek1E?=
 =?utf-8?B?aXJwbHdXaU00OXRpS0hWV3dzYWpuRVJTVUN5VC9ucjMyNmN6M1k5L25ud3NF?=
 =?utf-8?B?SGpaSk01NXBGOTRqa2dzVTJiWkZBUWtCQmtoRDB4YTRJL0NHTzdkTTJ0VXpp?=
 =?utf-8?B?V3VlZk5GdWk0OW5VVm44d3lEZk8wVzlCTnJkc01WQ3J3Vk9Jek9lejAvRlY2?=
 =?utf-8?B?NUNOZGh6OHNDMEViaDBEejRzQTFRMFZ4NEltZDlOSGMrdEN0cjNPY093bFps?=
 =?utf-8?B?YmFudSt4ZFpKcjdocTVoS0E1YTMwNkpGMjduTVg1UUVHR2VXYndZMjNKYVNJ?=
 =?utf-8?B?eXN0NEhXQ3BWWU93dEZDU0N0QWFDaFZyT1pCVWdBOG5PR2huWEhwMGduZ25R?=
 =?utf-8?B?d3JCZHdHa3UrYmdSSEFDbDJ3aVI3RHBXU1J2NzNKT3NGcktSSjhCekZmcUkx?=
 =?utf-8?B?M2pjSTg5b2xtMzY1cWhheVZySlNKNmZXbGtObjhnN3Y1SUtYV3pYVHExdFox?=
 =?utf-8?B?TjFaWDJHZ1BRQlJzS1ZVeXFGRXExYWMrU3hNZ0NEOEVjdncxZ3Rkd0hObmxX?=
 =?utf-8?B?a1lPVS95UnpjVVZsVm1mMy9scXVkUkc0M3FmRk5hTDZtRkJIT3NVc0pUc2dG?=
 =?utf-8?B?RW9OZklyeEo1TjRyd1VKUzIyU1ladEwzdDF5SWZXWUs2L2w0UWVMK0tJZGhP?=
 =?utf-8?B?UWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3e031d2-d993-426d-c2c3-08da0341c583
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 09:30:24.7069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z+GsRwhyaidg7ouewiZdbh6LiRitnt8HHxnE7tFzoZPE4EMQYRxVwkL5IiWZB3JxqH89a4aN7yf4M9czDKtDnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR06MB5074
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cj4+Cj4+Cj4+ID4+Cj4+ID4+Cj4+ID4+ID5PbiBUaHUsIDEwIE1hciAyMDIyIGF0IDEzOjU5LCBR
aW5nIFdhbmcgPHdhbmdxaW5nQHZpdm8uY29tPiB3cm90ZToKPj4gPj4gPj4KPj4gPj4gPj4gRnJv
bTogV2FuZyBRaW5nIDx3YW5ncWluZ0B2aXZvLmNvbT4KPj4gPj4gPj4KPj4gPj4gPj4gU29tZSBh
cmNoaXRlY3R1cmVzKGUuZy4gQVJNNjQpLCBjYWNoZXMgYXJlIGltcGxlbWVudGVkIGJlbG93Ogo+
PiA+PiA+PiBjbHVzdGVyOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
KioqKioqIGNsdXN0ZXIgMCAqKioqKsKgwqDCoMKgwqAgKioqKioqIGNsdXN0ZXIgMSAqKioqKgo+
PiA+PiA+PiBjb3JlOsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCAwwqDCoMKgwqDCoCAxwqDCoMKgwqDCoMKgwqDCoMKgIDLCoMKgwqDCoMKgIDPCoMKgwqDC
oMKgwqDCoMKgwqAgNMKgwqDCoMKgwqAgNcKgwqDCoMKgwqDCoMKgwqDCoMKgIDbCoMKgwqDCoMKg
IDcKPj4gPj4gKGFkZCBjYWNoZSBsZXZlbCAxKcKgwqDCoMKgwqDCoMKgIGMwwqDCoMKgIGMxwqDC
oMKgwqDCoMKgwqAgYzLCoMKgwqAgYzPCoMKgwqDCoMKgwqDCoMKgIGM0wqDCoMKgIGM1wqDCoMKg
wqDCoMKgwqDCoCBjNsKgwqDCoCBjNwo+PiA+PiA+PiBjYWNoZShMZXZlbG4pOsKgwqDCoMKgwqDC
oMKgwqAgKipjYWNoZTAqKsKgICoqY2FjaGUxKirCoCAqKmNhY2hlMioqwqAgKipjYWNoZTMqKgo+
PiA+PiAoYWRkIGNhY2hlIGxldmVsIDMpwqDCoMKgwqDCoMKgwqAgKioqKioqKioqKioqKnNoYXJl
IGxldmVsIDMgY2FjaGUgKioqKioqKioqKioqKioqCj4+ID4+ID4+IHNkX2xsY19pZChjdXJyZW50
KTrCoMKgwqDCoCAwwqDCoMKgwqDCoCAwwqDCoMKgwqDCoMKgwqDCoMKgIDDCoMKgwqDCoMKgIDDC
oMKgwqDCoMKgwqDCoMKgwqAgNMKgwqDCoMKgwqAgNMKgwqDCoMKgwqDCoMKgwqDCoMKgIDTCoMKg
wqDCoMKgIDQKPj4gPj4gPj4gc2RfbGxjX2lkKHNob3VsZCBiZSk6IDDCoMKgwqDCoMKgIDDCoMKg
wqDCoMKgwqDCoMKgwqAgMsKgwqDCoMKgwqAgMsKgwqDCoMKgwqDCoMKgwqDCoCA0wqDCoMKgwqDC
oCA0wqDCoMKgwqDCoMKgwqDCoMKgwqAgNsKgwqDCoMKgwqAgNgo+PiA+PiA+Pgo+PiA+PiBIZXJl
LCBuIGFsd2F5cyBiZSAyIGluIEFSTTY0LCBidXQgb3RoZXJzIGFyZSBhbHNvIHBvc3NpYmxlLgo+
PiA+PiBjb3JlWzAsMV0gZm9ybSBhIGNvbXBsZXgoQVJNVjkpLMKgIHdoaWNoIHNoYXJlIEwyIGNh
Y2hlLCBjb3JlWzIsM10gaXMgdGhlIHNhbWUuCj4+ID4+Cj4+ID4+ID4+IENhY2hlcyBhbmQgY3B1
cyBoYXZlIGRpZmZlcmVudCB0b3BvbG9neSwgdGhpcyBjYXVzZXMgY3B1c19zaGFyZV9jYWNoZSgp
Cj4+ID4+ID4+IHJldHVybiB0aGUgd3JvbmcgdmFsdWUsIHdoaWNoIHdpbGwgYWZmZWN0IHRoZSBD
UFUgbG9hZCBiYWxhbmNlLgo+PiA+PiA+Pgo+PiA+PiA+V2hhdCBkb2VzIHlvdXIgY3VycmVudCBz
Y2hlZHVsZXIgdG9wb2xvZ3nCoCBsb29rIGxpa2U/Cj4+ID4+ID4KPj4gPj4gPkZvciBDUFUgMCB0
byAzLCBkbyB5b3UgaGF2ZSB0aGUgYmVsb3cgPwo+PiA+PiA+RElFIFswwqDCoMKgwqAgLcKgwqDC
oMKgIDNdIFs0LTddCj4+ID4+ID5NQ8KgIFswXSBbMV0gWzJdIFszXQo+PiA+Pgo+PiA+PiBUaGUg
Y3VycmVudCBzY2hlZHVsZXIgdG9wb2xvZ3kgY29uc2lzdGVudCB3aXRoIENQVSB0b3BvbG9neToK
Pj4gPj4gRElFwqAgWzAtN10KPj4gPj4gTUPCoCBbMC0zXSBbNC03XcKgIChTRF9TSEFSRV9QS0df
UkVTT1VSQ0VTKQo+PiA+PiBNb3N0IEFuZHJvaWQgcGhvbmVzIGhhdmUgdGhpcyB0b3BvbG9neS4K
Pj4gPj4gPgo+PiA+PiA+QnV0IHlvdSB3b3VsZCBsaWtlIHNvbWV0aGluZyBsaWtlIGJlbG93IGZv
ciBjcHUgMC0xIGluc3RlYWQgPwo+PiA+PiA+RElFIFswwqDCoMKgwqAgLcKgwqDCoMKgIDNdIFs0
LTddCj4+ID4+ID5DTFMgWzAgLSAxXSBbMiAtIDNdCj4+ID4+ID5NQ8KgIFswXSBbMV0KPj4gPj4g
Pgo+PiA+PiA+d2l0aCBTRF9TSEFSRV9QS0dfUkVTT1VSQ0VTIG9ubHkgc2V0IHRvIE1DIGxldmVs
ID8KPj4gPj4KPj4gPj4gV2UgZG9uJ3QgY2hhbmdlIHRoZSBjdXJyZW50IHNjaGVkdWxlciB0b3Bv
bG9neSwgYnV0IHRoZQo+PiA+PiBjYWNoZSB0b3BvbG9neSBzaG91bGQgYmUgc2VwYXJhdGVkIGxp
a2UgYmVsb3c6Cj4+ID4KPj4gPlRoZSBzY2hlZHVsZXIgdG9wb2xvZ3kgaXMgbm90IG9ubHkgY3B1
IHRvcG9sb2d5IGJ1dCBhIG1peGVkIG9mIGNwdSBhbmQKPj4gPmNhY2hlL21lbW9yeSBjYWNoZSB0
b3BvbG9neQo+PiA+Cj4+ID4+IFswLTddwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgKHNoYXJlZCBsZXZlbCAzIGNhY2hlICkKPj4gPj4gWzAtMV0gWzIt
M11bNC01XVs2LTddwqDCoCAoc2hhcmVkIGxldmVsIDIgY2FjaGUgKQo+PiA+Cj4+ID5TbyB5b3Ug
ZG9uJ3TCoCBib3RoZXIgdGhlIGludGVybWVkaWF0ZSBjbHVzdGVyIGxldmVsIHdoaWNoIGlzIGV2
ZW4gc2ltcGxlci4KPj4gPnlvdSBoYXZlIHRvIG1vZGlmeSBnZW5lcmljIGFyY2ggdG9wb2xvZ3kg
c28gdGhhdCBjcHVfY29yZWdyb3VwX21hc2sKPj4gPnJldHVybnMgdGhlIGNvcnJlY3QgY3B1IG1h
c2sgZGlyZWN0bHkuCj4+ID4KPj4gPllvdSB3aWxsIG5vdGljZSBhIGxsY19zaWJsaW5nIGZpZWxk
IHRoYXQgaXMgY3VycmVudGx5IHVzZWQgYnkgYWNwaSBidXQKPj4gPm5vdCBEVCB0byByZXR1cm4g
bGxjIGNwdSBtYXNrCj4+ID4KPj4gY3B1X3RvcG9sb2d5W10ubGxjX3NpYmxpbmcgZGVzY3JpYmUg
dGhlIGxhc3QgbGV2ZWwgY2FjaGUgb2Ygd2hvbGUgc3lzdGVtLAo+PiBub3QgaW4gdGhlIHNjaGVk
X2RvbWFpbi4KPj4KPj4gaW4gdGhlIGFib3ZlIGNhY2hlIHRvcG9sb2d5LCBsbGNfc2libGluZyBp
cyAweGZmKFswLTddKSAsIGl0IGRlc2NyaWJlcwo+Cj5JZiBsbGNfc2libGluZyB3YXMgMHhmZihb
MC03XSBvbiB5b3VyIHN5c3RlbSwgeW91IHdvdWxkIGhhdmUgb25seSBvbmUgbGV2ZWw6Cj5NQ1sw
LTddCgpTb3JyeSwgYnV0IEkgZG9uJ3QgZ2V0IGl0LCB3aHkgbGxjX3NpYmxpbmcgd2FzIDB4ZmYo
WzAtN10gbWVhbnMgTUNbMC03XT8KSW4gb3VyIHN5c3RlbShBbmRyb2lkKSwgbGxjX3NpYmxpbmcg
aXMgaW5kZWVkIDB4ZmYoWzAtN10pICwgYmVjYXVzZSB0aGV5IApzaGFyZWQgdGhlIGxsYyhMMyks
IGJ1dCB3ZSBhbHNvIGhhdmUgdHdvIGxldmVsOgpESUUgWzAtN10KTUMgWzAtM11bNC02XQpJdCBt
YWtlcyBzZW5zZSwgWzAtM10gYXJlIGxpdHRsZSBjb3JlcywgWzQtN10gYXJlIGJpdCBjb3Jlcywg
c2Ugb25seSB1cCBtaWdyYXRlIAp3aGVuIG1pc2ZpdC4gV2Ugd29uJ3QgY2hhbmdlIGl0LgoKPgo+
PiB0aGUgTDMgY2FjaGUgc2libGluZywgYnV0IHNkX2xsY19pZCBkZXNjcmliZXMgdGhlIG1heGlt
dW0gc2hhcmVkIGNhY2hlCj4+IGluIHNkLCB3aGljaCBzaG91bGQgYmUgWzAtMV0gaW5zdGVhZCBv
ZiBbMC0zXS4KPgo+c2RfbGxjX2lkIGRlc2NyaWJlcyB0aGUgbGFzdCBzY2hlZF9kb21haW4gd2l0
aCBTRF9TSEFSRV9QS0dfUkVTT1VSQ0VTLgo+SWYgeW91IHdhbnQgbGxjIHRvIGJlIFswLTNdIG1h
a2Ugc3VyZSB0aGF0IHRoZQo+c2NoZWRfZG9tYWluX3RvcG9sb2d5X2xldmVsIGFycmF5IHJldHVy
bnMgdGhlIGNvcnJlY3QgY3B1bWFzayB3aXRoCj50aGlzIGZsYWcKCkFjdHVyZWx5LCB3ZSB3YW50
IHNkX2xsYyB0byBiZSBbMC0xXSBbMi0zXSwgYnV0IGlmIHRoZSBNQyBkb21haW4gZG9uJ3QgaGF2
ZQpTRF9TSEFSRV9QS0dfUkVTT1VSQ0VTIGZsYWcsIHRoZSBzZF9sbGMgd2lsbCBiZSBbMF1bMV1b
Ml1bM10uIEl0J3Mgbm90IHRydWUuCgpTbyB3ZSBtdXN0IHNlcGFyYXRlIHNkX2xsYyBmcm9tIHNk
IHRvcG9sb2d5LCBvciB0aGUgZGVtYW5kIGNhbm5vdCBiZQptZXQgaW4gYW55IGNhc2UgdW5kZXIg
dGhlIGV4aXN0aW5nIG1lY2hhbmlzbS4KClRoYW5rcywKV2FuZwoK
