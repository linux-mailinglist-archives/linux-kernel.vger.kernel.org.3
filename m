Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2815023D9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 07:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343495AbiDOF2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 01:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbiDOF2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 01:28:15 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4B48D6B1;
        Thu, 14 Apr 2022 22:25:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KqLgoCgGxMSbEtjQTkGEf+AF3lJ9fEQit4A6lsBq2ujEvHLN5w4r8mWspoCNt0/mbhk9AmO8KNEeyC4pG+hAvB+sjtOhCv8RS6qxi2sU66zhTtzuNSsOp8O4AVY87QLuUBgjmygjT/xqfaIKdBWkXQXkPgO34iGhtnmFrJLiOa0L3++jG+OaL5MXqSCRm5kKIzQ+0KhAb0YUe+zGBEzcBcyxGFBe3lHaCaXsYiuRqEVAs2E0E+kfecIQDl5TW1gnhfT4FtN1UMNkTJ7ZlUW3kdmjF6ACrlBqhQ8rnm4dqhcHjrn3k5AMuRgp4LIdZEITqPnYVpjUghBGXi2+qpuuSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJFvEaIE6PHz9QgZrHzYinL/9g9s5O36uedUlDQMvro=;
 b=B3jA29NDMjler10f7EP4ueCAJet7c7oqd3CK2ERmKevIFwKaOVjgwQaFaUi5sMPFXKLNJmkDfZ5DeDvRxAq40CD5u35s3lB2KV41DbqXEBZPA96K6pltlIRVzKTLMZkTvpQSIAoORr7ps/aCblpwBZ4nAtF7P3kDiyCRy9q6LV6AoRND7ewjRD6J89WzkNE4zGF+hFpeQJSuDKUACJqK1hhEPQMcPGmhbIm3c7g5VWvFXpkxHL1hKpAGxC5/LU0Co59p2vxfOYX1hMAGzfqLADEQ+9bYQysF+oj7L2G9c+rpOBEbDNQtEnCwhGzZR5VFnLBI9u81AQ0G+D5SwoRp0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJFvEaIE6PHz9QgZrHzYinL/9g9s5O36uedUlDQMvro=;
 b=soClIWcDpFWfWInlT9KUDaKVUO7+0XdGbaGKCDIZRfsuQl6q0mPD6oNL7f+82fZFHF26cPY4HA0/BZp2eUCkaNGQkrQN5UR7gSaQO+yOUaAkgxyCPiJ2X5vmzllL9i8AkdmXeOw5doPyJOxznQVn8t69dLcq7Q8LfX3iejCgp8BBEiANENORBstRJ1jhPCBRKo+TN+GguJjMS3GcMSpdeNGDfu3U3L8Y84FhhuKXdhlH6+9soresP+uCPPQzC2mQZcj3r2l0xFx9MYEsm4E8rhdhSjdpDah+DPR1HIhnL8+L5qH8e9Jl4lWiDORpANQTZjCvnx+9aAuhSKu2HzQ81Q==
Received: from MW2PR12MB4667.namprd12.prod.outlook.com (2603:10b6:302:12::28)
 by MWHPR1201MB0093.namprd12.prod.outlook.com (2603:10b6:301:54::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Fri, 15 Apr
 2022 05:25:46 +0000
Received: from MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b]) by MW2PR12MB4667.namprd12.prod.outlook.com
 ([fe80::a90b:9df2:370c:e76b%3]) with mapi id 15.20.5144.030; Fri, 15 Apr 2022
 05:25:46 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Khazhismel Kumykov <khazhy@google.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v2] block/compat_ioctl: fix range check in BLKGETSIZE
Thread-Topic: [PATCH v2] block/compat_ioctl: fix range check in BLKGETSIZE
Thread-Index: AQHYUFDS3KOEUBtLo02aAhuMbG0wbqzwceIA
Date:   Fri, 15 Apr 2022 05:25:46 +0000
Message-ID: <4566cd49-a9c6-f928-9834-c608dfcdf565@nvidia.com>
References: <20220408234707.2562835-1-khazhy@google.com>
 <20220414224056.2875681-1-khazhy@google.com>
In-Reply-To: <20220414224056.2875681-1-khazhy@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 27497942-ddca-4dee-801b-08da1ea06522
x-ms-traffictypediagnostic: MWHPR1201MB0093:EE_
x-microsoft-antispam-prvs: <MWHPR1201MB00937CC7F0F620630DB7C7B3A3EE9@MWHPR1201MB0093.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QHsLQlsOE38+C6RD2Z/7Sv+teoB1QtzAIZ0C0Pg+MddDNGJxcc1wXLsbtFznvbRJWGwLLWe/va+A5VMTmyTlUKFwrWRDJvAerOLQFd1oCZ3h4fEyv0/CObFuGREz5W+191cqmUQCJLSLA7VsBmR5AYZZmJSYf+D3p6EnDpfiTCwkSJc7BpQM4F5fIfiEz4UD1tVgBIoCwqA0gTWvjpLN9SvWfVrz9gkCg1wj4Fcc0dKelWSaWlZhDOXpG5G/NkPWN6UVTTcu9rqjQA6WazTRfgHvFQvYXpSpSxX2iiYGu+3LyVdLLIm4dguHjg8W2xgGB4kO3Qs51UdjKBncmQkLIPDHKSrvbbJltBtDPG4TqtnnXZQhgRzdq5RdH9kbac/swIVVK1jcqMXmj2ZJbji+BjzaXNd5f9IfKRhfC/RV265W268+i0fxGoRIavlBIMAFLPsCYtusUz/HdhEQbHPvaorXKZUFqRem51xCT6R7nSoxa/9eeekYasDclPS5koU/hyCiFRSvwtwDNkrH+C2VeralTDoXwobDzDupMEB1fwnYWs/Np+Eoe76biP4tGvT6BrctIr2l3lI+GaTmzMDequG/tjnYpGKmlOiJXv7DHJbhOZp5cVsHjddMUu9kjRbeGWOIZ15dh0UQxu7qVftzN/icouHPo2tj8z4tAWvCWwwGpMewA4Kyf+HFpeTP+Ws3CfVJ5IaarN9Z9BzM+X87qJMwPWUDyera5rH1bqXt45cQn+adZjPqrxdjYrfFm/YX4oX4gZ5H/QydDl3ZNby55w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW2PR12MB4667.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(186003)(71200400001)(38070700005)(31696002)(86362001)(316002)(54906003)(66556008)(64756008)(66446008)(66476007)(8676002)(6916009)(76116006)(66946007)(4326008)(8936002)(122000001)(38100700002)(508600001)(6512007)(2906002)(91956017)(2616005)(4744005)(36756003)(5660300002)(53546011)(6506007)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFJNVG9wZVBQV0R4UXJra2JSUjh2K2NuY0x1dWFXUmd3elcwcEZ5VS9PZzRC?=
 =?utf-8?B?eGw4aE1wdmpvMGhuMGtnV2xLcWlFeUJUcWFGVDBHUHdpZmxwOWU3QTEzNHk5?=
 =?utf-8?B?SlFuUzF6MUVDUm0zTHVBMkRjUjljZERxMCsrMzZFUUpCNStRZUN5a0RGWnRn?=
 =?utf-8?B?c3hhRm9kQm5RdzMyTUExL2RJWlI0eCs4T3FKWllyejF4YThOY29UV25HOUVB?=
 =?utf-8?B?UDNPMnFFQjExTWJ6SEJicmhXNFBTRzZyc2NVZkk3MzA1WkJoQlFTdHlmamZ2?=
 =?utf-8?B?aU5oV0RWWVI4QXJJS3VMUXh1bTcxck91U01kakU2MXBlRndPRFpXMGFIVkJF?=
 =?utf-8?B?cXBwUmQ4VVJWakFaQ2tMa0pPeUQ2TUo2TDJjczM3VVlUZ1hkY3pGN1lWWGY1?=
 =?utf-8?B?YWxMZE9naUlmL1c2ZjBuR292T0F4NThQdW94ZjFZZjF1N2lMWHBqUEwyMjZM?=
 =?utf-8?B?Ym9OSXJMekFQSVM3Ykwza2VIWTEwOFBBUzZUTmtXbGkzQTBTVitzMFAzdVll?=
 =?utf-8?B?MWdRNndDSm5tQUI1NDB1MTliL1RWcHdYS1lQNmxxWEhoUSttYUdrV2hNYzhv?=
 =?utf-8?B?b0NBSi9FNWJTSzhyTTVpOEZPRnJ3cDRKbnoyMHZGelE2anJYdmVHMXRvNWVJ?=
 =?utf-8?B?a0lTM0VBcmFLeXhRT1pmVEdtWTRaYlBFZUF4ZjZaL1V3TmJ2TXY1c2ZocFZk?=
 =?utf-8?B?SjJFaHM0SlI2M0ZaN1hIeXZBZTNvaWNaY215akVNUWt4eDhZOHdkUjFIYXdr?=
 =?utf-8?B?bWFCdm1lY1ovSy9jT1ZGTC8yVGlRNkpVUWhCVDNzMGNPT1lwNmNKaCtGaE5u?=
 =?utf-8?B?ZGZ6TjBoVmRWcGJnY3pJQjhTcEY5Q3RtZkZ1ZlozL1Z1MWFLbld5bHBIbGFT?=
 =?utf-8?B?cmxLVjhaREhZejNSamVPU0lDaFBnZ1hxeEJZYUVzb0lDbGI4enpZck90cHl5?=
 =?utf-8?B?anZwdXNwVlJIbmY4M3RiUTNpMHo1T0w2T2t6T3ZmOUd4aHRLOVRiT1hLc2Ra?=
 =?utf-8?B?RnEvdTFSMHJWeWhiRi96azhwSzM1ZHZiRGRPU0MrcFRrRjRsa0RMUXdQakpu?=
 =?utf-8?B?Uno5dzUzVmN5YVZSdnJXUTJvZ21MdURjS0tFTG8rRW5vWTZienFGQW1QY2xX?=
 =?utf-8?B?V05CeG5COTdOMXhFc3lvZWtsNEhZNnB4a01EWVYrNEVHNWNpUCtYb0x6OUpz?=
 =?utf-8?B?UG0xLzk0MXpsYmVmMUJkNnJZU2xudlRVejhzWm85cFYzdFM2NWZDeXZtaEZq?=
 =?utf-8?B?RDVWUThibDVkaHFuYVk2d1FKODl4N3puNzNqSjVFcnlybnhTY21KWGN0Ym5w?=
 =?utf-8?B?YXB3VjQvQmJBMm1NaWlGNWdlTjBoSllxYk9PL0w5VklqekdkVEpDVWpFbEU1?=
 =?utf-8?B?R3g2ME1JQ1c5UnJJVTJLODhPdDR4cFZua0N2TUUrVWxjUE55NFdNTnFTYmJr?=
 =?utf-8?B?eit2UVpYL1RldFRwdytQVkpOYVNySnFWdUVrdlFlcExJZUIxOHhqSXhmSk10?=
 =?utf-8?B?TGUzRE5CM0JQd2pwL1d1Qnl6ckdiZTN6QUQ0eHp2Yml0MnJPckZONmpWYU02?=
 =?utf-8?B?aGJRNGs4VFBXWGRRU1gvdnVsOEI4bGdFWHB1NXowTE9mWENLMjFIL1J0ZWtX?=
 =?utf-8?B?Zy9NRXQ0NndzVm9OSk5vck9MRlFneEZnMkQ5NmxVSm9EZmdxQ0hUTDUwM3dU?=
 =?utf-8?B?OFF5UVk0VC96UGdCMTErVFZHR3Y4Uzd0eWxTbDZ2WVVHSHUrazNveFZ4OTQ2?=
 =?utf-8?B?QTNmMmZpdWFuaGQ2aW1NczM4YjBoekZjMlZlYmxzYTRhZWZtOTJ0ZENoWWM3?=
 =?utf-8?B?MWZNejFUdkZGUXRCV1ZGeEFISUZJdjN3cnpjRjA5em03NXZGU1FLZGxTcVVH?=
 =?utf-8?B?Z2lvamFpNHV6dXlSUnA4SnBadHM0M0tiRjhtY3VucEdyS29LU3NmSm9yZThC?=
 =?utf-8?B?YkxwZnVXODVpWUIyK1hXQVEwQlYvSzZrbXhxaFc0OWVuVllZTzR2OXhtTTh4?=
 =?utf-8?B?VWVQUEtPT0RWdnFCTFh6bEFiRitGU0E5cGJNTmdrTUx2bHJJUHQ5WXRyUFpR?=
 =?utf-8?B?QmdYT3hYRmp0eFFHVWM2dzJDU3J0dGlKandLdjRhS1JOcVhNTWFTSmxVOUtK?=
 =?utf-8?B?NzMvTEJmYms0UEZQYk5TWk1YeDNkWnhKQVh5ZWZERjl4ckJlSWtBemYwa3du?=
 =?utf-8?B?UEhmeEdGNWVWU2tPZ1MvbllPa1NwdlNxMFkwcWpmSzByaFRISEJLZzRDSXd4?=
 =?utf-8?B?U2NsZXEzY0t4bjI3ZXNObVNQZDlrUEIybmZFN1FUbW14M0NLbXFHdjQwOUZC?=
 =?utf-8?B?anVvY3lFR0Rsb3V1SC9WRURsRW0wc3NJUmZORUozVkpvMExVVFlETFhCeHNG?=
 =?utf-8?Q?wKnoxZq1Vs4vVngU=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <07B83AED5DA07F4F9CB245AD7790331E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR12MB4667.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27497942-ddca-4dee-801b-08da1ea06522
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 05:25:46.5769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b9WQptQXoybF7SGHQZC5OQ9lkGGU0K8WvCnum9y+jSTJbnJbyJOVWwy0lvttCmHKQMcfYbVGWFr2vCTRDFepIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0093
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNC8xNC8yMiAxNTo0MCwgS2hhemhpc21lbCBLdW15a292IHdyb3RlOg0KPiBrZXJuZWwgdWxv
bmcgYW5kIGNvbXBhdF91bG9uZ190IG1heSBub3QgYmUgc2FtZSB3aWR0aC4gVXNlIHR5cGUgZGly
ZWN0bHkNCj4gdG8gZWxpbWluYXRlIG1pc21hdGNoZXMuDQo+IA0KPiBUaGlzIHdvdWxkIHJlc3Vs
dCBpbiB0cnVuY2F0aW9uIHJhdGhlciB0aGFuIEVGQklHIGZvciAzMmJpdCBtb2RlIGZvcg0KPiBs
YXJnZSBkaXNrcy4NCj4gDQo+IFJldmlld2VkLWJ5OiBCYXJ0IFZhbiBBc3NjaGUgPGJ2YW5hc3Nj
aGVAYWNtLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogS2hhemhpc21lbCBLdW15a292IDxraGF6aHlA
Z29vZ2xlLmNvbT4NCj4gLS0tDQoNCkxvb2tzIGdvb2QuDQoNClJldmlld2VkLWJ5OiBDaGFpdGFu
eWEgS3Vsa2FybmkgPGtjaEBudmlkaWEuY29tPg0KDQotY2sNCg0KDQo=
