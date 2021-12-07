Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8217746AF8B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 02:07:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357052AbhLGBLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 20:11:09 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:3826 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243594AbhLGBLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 20:11:08 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B70gDPY030277;
        Mon, 6 Dec 2021 17:07:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=yBSYa5y3JxfeTQvRz4J0NIflWQcRqqrfSF4oquc8J7k=;
 b=B62aIL0xUxYOV2Tjdj+1ng3KQBXv9w6b+aMvafjx/WZYxJwrc+2aeFhAk8wivtXb4/2Q
 MbYq3PFOkMIb+fjSgkCCFUx/Wlter/J2EOj6/Ujt/ioHPtwrJOL7YRtrpasxzO0SMH9R
 zandhvuI4km5Lgz/FwMoLJYW9OAUtcw2LA4= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3csdrhefcr-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 06 Dec 2021 17:07:38 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 6 Dec 2021 17:07:33 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZYnwRV3+vzXCKgqMhotWWXYIPtHDJoAIRWAW5qValQ0wWjhivEv/Ct8v9mpje4lRw1gHNoP7jLYHeO+U5dn6G0lVlo61rlxDUSsMBD7WLO9UoZofVUNtYjcTaz/O2k7VRP8rWv6dAjORFzjlUArfKN9RnMhyizghBr4EH7u+MW71trX7hzlokiPOUDCpoxR2mmck9fVdwe97kPt+jc4rnfo+K5SWLfnKPrEYDu1NeSEdXgMeBYUn1Qv+SAl8w6/CuxaTOstHOMEs/D/ayJOT/KtxD8ld7emGrMpBGvwI7gf/68NXbE+Z057X7pB73If5lqlWxPqBQu45drR0HZYsfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yBSYa5y3JxfeTQvRz4J0NIflWQcRqqrfSF4oquc8J7k=;
 b=GKRAIA1pwjxdgUTBLKV9BGBHghkbnteprmlGUCdy6onU88zzYeK/KnGDLlGjxKtz+vzVYTmBJi50HRNkBYFFHVKbHF0SEQ+PAVBa4MJgcK6qZzJr7X/nmJeaB21hUYhQKXpT0FFv0dyzZrI88eTkxXabcz9cOKacvi4p/73HpFJVshA+Y7sQjZWtk3gkeNf2a3lHfvGII+xUC8/thXr/KS506Ky2QhktWUEikmYIPTnxXSjvEXc2bOpoBp2gas0JKeAhf8alXl7CeG64UzNoarIK2g2vl842Kb8vxgCukEKwgCSvHZm02RFItaqw5LQIpZh237NSEm3xuMybfGa6Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SA1PR15MB5109.namprd15.prod.outlook.com (2603:10b6:806:1dc::10)
 by SA1PR15MB5079.namprd15.prod.outlook.com (2603:10b6:806:1de::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 7 Dec
 2021 01:07:32 +0000
Received: from SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::f826:e515:ee1a:a33]) by SA1PR15MB5109.namprd15.prod.outlook.com
 ([fe80::f826:e515:ee1a:a33%4]) with mapi id 15.20.4755.022; Tue, 7 Dec 2021
 01:07:32 +0000
From:   Song Liu <songliubraving@fb.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "linux-perf-users@vger.kernel.org" <linux-perf-users@vger.kernel.org>
Subject: Re: Building perf with BUILD_BPF_SKEL=1 by default
Thread-Topic: Building perf with BUILD_BPF_SKEL=1 by default
Thread-Index: AQHX6EczClIG2E5d9UOz/2n0HlwT/KwgwqAAgABvMQCABDgvAIAATS4AgAAwM4CAACruAIAAJbMAgAAFDoA=
Date:   Tue, 7 Dec 2021 01:07:32 +0000
Message-ID: <80DE21EF-C2F8-4F20-9748-5C6E2BF1472C@fb.com>
References: <YaoXUrLUZt1scVb0@kernel.org> <YaobYKgrTV1Bthi0@kernel.org>
 <80DE5BBF-E831-43F5-91DE-46775DE4D6E7@fb.com> <Ya4CxsyoyFQVFzoi@kernel.org>
 <90475C95-0E7E-4212-A390-2FB33E47EC04@fb.com> <Ya5r81oxLY1Lb/JN@kernel.org>
 <BEF5C312-4331-4A60-AEC0-AD7617CB2BC4@fb.com> <Ya6vlokMH2pCTTfd@kernel.org>
In-Reply-To: <Ya6vlokMH2pCTTfd@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3693.20.0.1.32)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2177188e-b5c1-4b11-dee3-08d9b91df276
x-ms-traffictypediagnostic: SA1PR15MB5079:EE_
x-microsoft-antispam-prvs: <SA1PR15MB5079492326E58988C794785AB36E9@SA1PR15MB5079.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v7X0WqPCpTOOCPyaAdLhF3uGECS6x9oYNYFIaoYrvHzYOfUH6QtAxQhwzTd7TSdCmSTDmfXpxXTCw4OyyQjT/pTjFFU/jIPORjg0qjhOrW0T6hZHywuLh2vt4N2u+zD/OdizGRH1V7vVG2hlJDNgNWuuAREEzk0Qwej2hy8E5yEpOh/TcbwF6MS0Jh1I6PW306XMRteSI0wIqXMyLATxStF8p1dOEihILx3PbURwv8e7Djlyf60RCuwOD/olTx/c6ygx6BZuXHEYzjxcNvuOB7FQW1F4iDP2g3N1vUwFmQ5NAMJU3UtGUs1xyK58/vsHKk9PMMa5nuovU5yLzaaqaoE83pp5f5kht4GmOMYR+LGh8M4aRqp7t+WDyh68/BJ6CD0+V0xe8FqMHg/F4Ejbx3Dz1lG0DmUHt9HHdQbK1UoOTSzlne8lWI/sND1XF6CTFJEIem4gHOzcIz80s/T87q853OITzgegk5xN0q5hiSUU8ueITJYW4mPED7J3YXXXUWLLbrrywJ8rtKVq7e8v3hTFptWxW5eZaS7VVA+hYuEJQC0nlVndEWbkdCQsveqBmHCdvDTnkns5E+AOGVix3kelNdNSArboAYWj0gLKgdshveI99uJ2pI+kv5b403GQgR/1sgy5UOtcjR1ydfbBJXy1TY42Qd3xUmKYCDZ+0JU91VpZ5GLm9sqsZeuN6DqgWOxDGKaMO2U6nTsIVScbEH+GdPMe8DflGnzg6RwIgvcEMnCFQIY8mz8lmGzvrxKb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB5109.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(76116006)(508600001)(71200400001)(4744005)(83380400001)(36756003)(86362001)(2616005)(53546011)(54906003)(91956017)(2906002)(6486002)(6506007)(8936002)(38100700002)(4326008)(122000001)(33656002)(66446008)(5660300002)(6916009)(316002)(186003)(66476007)(6512007)(66946007)(64756008)(66556008)(38070700005)(8676002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bElhYzBQdVljb3MvVFdzUFlBWGNYT0xxSzJ2T3dyeFI3VzdraEtGVGxhWERq?=
 =?utf-8?B?a09HQkVsdnZxRE9IVk5HcEs4VVFKWHRLZzNMek5zdCtOWXVxa25uZkIvS1Zw?=
 =?utf-8?B?R3hKaTg4OGhhT09EU3pWeHVic2N1RFk1NnVMNjZ2NWxyT2JlL1R6QndMUG9m?=
 =?utf-8?B?VjJpNGhmcjZtTmlSc2xmaEp4Y29ET3NXNUc5V0hGaWQzMlQrbVJ3ZllhV3V0?=
 =?utf-8?B?d0NCb1M1OWFvV21MemZxNGZrcURWSi9zdG15L2tHU3FRTGFUa2xzL1dBTzUv?=
 =?utf-8?B?aExQWGs1S05jOUFjNjlyb21ZcENJdlVZMS9TRFIvRDBiVE9UZFUwK1lILzdO?=
 =?utf-8?B?VEFoa0ZMQTVuWXcrb0FtN3o4L053dVpUWGtYRnpWUE5saGdtalhvZnBLN1JN?=
 =?utf-8?B?aE1kZDdvWEZOZmlBWFVMTjQxQW9iMVk3ckJaMlVNdk02YzcwWktLSW5vbGZ1?=
 =?utf-8?B?NERvaEFwMzZzakNscUlYbEh2OXZNcm1NcFIxWWJCZDFXaWZ3MXVscnhIbTZ3?=
 =?utf-8?B?bkRBQVZCd0xaN3pOV1hwVTU3SVgrampCcFYxc1dXbUhzR2tkSHMvWE1BZ3NN?=
 =?utf-8?B?eHFIU3pCK0p4WGNkTEdlZk95U2lHM1N1ZDFUYml4R2p1UWU0dEFPb3cvcEVp?=
 =?utf-8?B?Wnp2THlWOHUyZW1nendQMGxvcDlHb2Y4aVQ0RklNekdleGVSZDRjMjhjakF2?=
 =?utf-8?B?cFJiL0c2UFNUM3c5NjM5RjdwanFmRTJKcUpUaHA5R3BDUGdJelJ1RXFqbmxV?=
 =?utf-8?B?VWcrbHIrQWVTdXRjWlJrRWV6MnJWUmpnaGlXZnMvaFFCeGJIY2NSQ1hqcmNl?=
 =?utf-8?B?WlpiV29USWw2V3BOZC9XRmVtUTdTMzIvbmtPYkhUaEw0NDFkK3NzaTlkUXJC?=
 =?utf-8?B?cG1TMHJOQUQ0T2lZOWUzb20xVTk5c21hM2pBdDNvR2wrV2MwVmZFUEdUUnJ1?=
 =?utf-8?B?M1VKNEJtQW1zV3NpZXZCL1dNb1dBQytUcTRQNndlbGJtZmhuZXNOM2tjQzJK?=
 =?utf-8?B?RkllS0FvclJPR0RQdnJhQ0xkN3FicmV4cE9GeTk3bW1iTnJaMkhYRWdHeGtY?=
 =?utf-8?B?aWxzbCtNSmlqUnliQkpWRUJDRzZ6dFdjNFdmaTg0WG9NMFJsLysrSTh4SWJT?=
 =?utf-8?B?MHpJRjRpUDVTL0tudVV3VW4xVjJTajh1a3R2L2JPRmJqSUtPS0VrY1VEWUF5?=
 =?utf-8?B?L0VJTnB4Q0pJWkFnWTRnbngyNitDa2hMdkwwNytwRzJDVm92NitaNWNtMzB1?=
 =?utf-8?B?QU9TRm5HeldCbGJPbDJBVlFVMEJCSXFVRVk5NVNzeEdxWGl4MHFWSVlNOUo2?=
 =?utf-8?B?d0hrOWZHTjRJZHlvVGJRUVJBVzVIdC82WEdET01KYWdpdFlXcmlzRDFmKzRt?=
 =?utf-8?B?MUh5L0U0aEp5aTBCcEtSUUFMZ2pmcENsZ0FOMktNSXFHdlNZMDQ5MXdxUWFz?=
 =?utf-8?B?eXBESkRJdG5naERvK09nWEVZUXRFQm5CZHZsMmNkZHZIaGF0eXlCd2g0SVRN?=
 =?utf-8?B?aGt1cXdTVnJtTk1MdGVpbTNKaTFvdm1GVHF2NjYxTmxQTzZGTkF4NDNqY2FP?=
 =?utf-8?B?VHpjeEVkNXpUR2xZNFhxeXBKWnVpUnBha3FETHJBK1d6WGdmV3dqbEoxZFF4?=
 =?utf-8?B?K2U2amdvYWdSd3VUU2xUa3U4b3AzOG8rUzY0QkgrOVUzMnovYzlLeVhsa1h1?=
 =?utf-8?B?RVRRbUFnM0NKSWtaQm8wTGExLzFmK2VmT3k3MXRkb3ZxU3pPc2RINlU3b0h5?=
 =?utf-8?B?SUZrUUdnSDVKeklQNzJZb2V6d0NMT01JWkxPVWo4WklMMEtqY0dUMTZWRS96?=
 =?utf-8?B?dkFla3AvbVhscmJpZUk3TVVTMmlMWW04U2pPcVpaRXhkOGw3YTNFbVBmbG9X?=
 =?utf-8?B?R2lXMWZTbk4wOGdGaDlXSkVWbXNWck5VR0ZnVGxIa0orVWt5WnhLTzZsQzMw?=
 =?utf-8?B?RE84K0gzenh2NDRheE9HUytqK2trbjdoYU9lbTM4Z2N1NzJXd3ZXVmJiQ250?=
 =?utf-8?B?aEFGVHp1N3c1V1dDcnlGRDlRbTlYbU04SFN2L2ZxcUk3bEpQV1hxclJybTY0?=
 =?utf-8?B?WDJEQTJmblVncWhnRDJMR3VoVGRyNzZ6L0hQYUNJSTJOVDlicUdxaVp5N0lO?=
 =?utf-8?B?cW5WamJWK2tOZjQyblZid0hnYUtTQlNNZFh4UEszYy96czVlV3kzalJsc2pR?=
 =?utf-8?B?VlNqc1pnWlVRa01HYmtwNnVwOVpTTmZCbUF0aU5SRE8xa1NjSzZZVU44MnM1?=
 =?utf-8?B?QVRCeitJaVNTZDdsSWJWWlpIWFZRPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70A92937F9313E469AD06EB4C96A6D8D@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB5109.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2177188e-b5c1-4b11-dee3-08d9b91df276
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2021 01:07:32.2055
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CTO3/ttjxnfshbxXmwZOjKGEZK7KENkhXnwNPjD66xE7VfBkpvqI9PMgdr7cXzMt/ouosp+Wx4TQnjsyGbW4pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5079
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 9FGMID_gbgSCAcaLXuXsbL9T1R9Yc7gt
X-Proofpoint-GUID: 9FGMID_gbgSCAcaLXuXsbL9T1R9Yc7gt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_08,2021-12-06_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 spamscore=0 mlxscore=0
 priorityscore=1501 mlxlogscore=780 malwarescore=0 bulkscore=0
 clxscore=1015 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112070006
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gT24gRGVjIDYsIDIwMjEsIGF0IDQ6NDkgUE0sIEFybmFsZG8gQ2FydmFsaG8gZGUgTWVs
byA8YWNtZUBrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IEVtIE1vbiwgRGVjIDA2LCAyMDIxIGF0
IDEwOjM0OjMxUE0gKzAwMDAsIFNvbmcgTGl1IGVzY3JldmV1Og0KPj4+IEZyb20gZTAzM2ZkMzY2
NTcyODhlY2UzODNiYTUyOGFhZmY3YjU2ZWViZmVlMiBNb24gU2VwIDE3IDAwOjAwOjAwIDIwMDEN
Cj4+IEZyb206IFNvbmcgTGl1IDxzb25nbGl1YnJhdmluZ0BmYi5jb20+DQo+PiBEYXRlOiBGcmks
IDMgRGVjIDIwMjEgMTU6MTQ6NDEgLTA4MDANCj4+IFN1YmplY3Q6IFtQQVRDSF0gcGVyZi9icGZf
c2tlbDogZG8gbm90IHVzZSB0eXBlZGVmIHRvIGF2b2lkIGVycm9yIG9uIG9sZCBjbGFuZw0KPj4g
DQo+PiBXaGVuIGJ1aWxkaW5nIGJwZl9za2VsIHdpdGggY2xhbmctMTAsIHR5cGVkZWYgY2F1c2Vz
IGNvbmZ1c2lvbnMgbGlrZToNCj4+IA0KPj4gIGxpYmJwZjogbWFwICdwcmV2X3JlYWRpbmdzJzog
dW5leHBlY3RlZCBkZWYga2luZCB2YXIuDQo+PiANCj4+IEZpeCB0aGlzIGJ5IHJlbW92aW5nIHRo
ZSB0eXBlZGVmLg0KPj4gDQo+PiBGaXhlczogN2ZhYzgzYWFmMmVlICgicGVyZiBzdGF0OiBJbnRy
b2R1Y2UgJ2JwZXJmJyB0byBzaGFyZSBoYXJkd2FyZSBQTUNzIHdpdGggQlBGIikNCj4gDQo+IFBs
ZWFzZSBnZXQgYSBsYXJnZXIgc2hhIGFiYnJldjoNCj4gDQo+IOKsolthY21lQHRvb2xib3ggcGVy
Zl0kIGdyZXAgY29yZSAtQTEgfi8uZ2l0Y29uZmlnDQo+IFtjb3JlXQ0KPiAJYWJicmV2ID0gMTYN
Cj4g4qyiW2FjbWVAdG9vbGJveCBwZXJmXSQNCg0KSG1tLi4gSSB0aGluayB0aGUgcnVsZSBpcyB0
byBoYXZlIDEyIGxldHRlcnMgc2hhIGluIHRoZSBGaXhlcyB0YWcuIERpZCB3ZQ0KY2hhbmdlIHNv
bWV0aGluZyByZWNlbnRseT8NCg0KVGhhbmtzLA0KU29uZw==
