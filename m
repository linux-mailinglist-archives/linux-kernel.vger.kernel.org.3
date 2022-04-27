Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 580BC51174A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233894AbiD0MXU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 08:23:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbiD0MXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:23:13 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4036A60F0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 05:20:01 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23R3Uswr026789
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 05:20:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=mvLpKedZnLy0q3P1swWaNXBmmQHQPCShF9fQ3yeaUFE=;
 b=cDaUBfInhisxJsIE3ONXtvCYuEl6fDKFrbfavZv62MkCA6+ugb4gXZ3oO7Cv8/yuE0wu
 777l4w5RqSzf4Y4CVdOjmTSMWUeljojNx9RjSWFuAKZJULxAOHyixsy1gDxAbjvIrVLo
 HKQTBNwn1rewqnpEXpTkDVABpXDywjO/a0A= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fprt8bqhq-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 05:20:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=drpwFQlhyzwI18sqk4owhmujy70azCtCopEVZipgEvupZhOKpE8s74uY43K0G7hQn0ZZq8yBFRBfIcxmSu/S8cioHah/haEx3mqIwq09QFa++NAgjC084ZdmxqWXbX/vjIghccIijv/vRDlA8ZUXYik2g4CkWG+F7lADbZc5165if5zKh27cWtI7P7JxxeFS9GBZPT6+EcmwASqj5qBvsVsO8A5D6FKedN06hvvmUmLwTxgCgbs72sr43t9Nv0mb5T4KAGTZwjKBGL40/bVx0d7iF+EY4Ws9g6EY3lzTgqyWHKxH8KEltHFTcrW2Rxn2XqTdQbN8XoZ7vU08AwJ6qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mvLpKedZnLy0q3P1swWaNXBmmQHQPCShF9fQ3yeaUFE=;
 b=aA9MLmmVFq8ohp3+6f+VCLNLvRLpio4jFGheKUhBWhNA0P1xRGfsMResJfeYKLtqVUlhUQV+vGq4Bw1NFvlaEkGc2RFgpYPAQ2elDwUP6JF3aV96UeBqlq47ari4/Zh8UTztGi8Ol78ctSmwofcXqmU1YZB4WExl0Ck5WW33Pbl0wgyaHXfb4tJ4lFNnF8v6Vi/dUnFQs7WjLnLT9UFSgmrsDDX/c3wemxaXqxG5VfeBwQnhO9MmcckkT8qJdl7wvpP/jcfMbymekPLZ4gHk50P7IMvQjVdrXAUyVrq8A8szAnT1dvN5hVkHErJmc9OJS09nborPlW9DH5KhLF+m9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from MN2PR15MB4287.namprd15.prod.outlook.com (2603:10b6:208:1b6::13)
 by MW4PR15MB5136.namprd15.prod.outlook.com (2603:10b6:303:184::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Wed, 27 Apr
 2022 12:19:57 +0000
Received: from MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::141f:56c2:abc5:af96]) by MN2PR15MB4287.namprd15.prod.outlook.com
 ([fe80::141f:56c2:abc5:af96%6]) with mapi id 15.20.5206.013; Wed, 27 Apr 2022
 12:19:57 +0000
From:   Chris Mason <clm@fb.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
CC:     Christoph Bartoschek <bartoschek@google.com>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "riel@surriel.com" <riel@surriel.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH RFC fs/namespace] Make kern_unmount() use
 synchronize_rcu_expedited()
Thread-Topic: [PATCH RFC fs/namespace] Make kern_unmount() use
 synchronize_rcu_expedited()
Thread-Index: AQHYIdXuUKIGLuECw02OdpDhd3P0HqyTbfIAgAGB/wCAbUKtgIAAeCaAgACT3wCAAAN6AIAA3G0A
Date:   Wed, 27 Apr 2022 12:19:56 +0000
Message-ID: <2A61C695-450E-499B-BCFA-411A36008D72@fb.com>
References: <8E281DF1-248F-4861-A3C0-2573A5EFEE61@fb.com>
 <20220426065917.3123488-1-bartoschek@google.com>
 <20220426140919.GD4285@paulmck-ThinkPad-P17-Gen-1>
 <CAAQBG5jnvSxcjwr+L5nuxwh87bv=D=tzU325W2Zp3DVpn-VmcQ@mail.gmail.com>
 <20220426231100.GL4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220426231100.GL4285@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.80.82.1.1)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dea55acd-3a23-4e67-3ac4-08da28483e0d
x-ms-traffictypediagnostic: MW4PR15MB5136:EE_
x-microsoft-antispam-prvs: <MW4PR15MB5136EB5716791A8275C80882D3FA9@MW4PR15MB5136.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aJFJKpmo4D1uhzALHQj/plPZbNAjSGIxpMSGS1+Ii2gNl/SmqpCi81lPs/eWf+5b218voQZGYrd2rpenLYYhvWjyNfPTfplmVspDxCZCkiqZ2HTdEzv23Vwaf1j7AUP1A+z/iGGJvLhIkn9UuDrXCZ0K4ozWz9BIV1dn1z+0NEKATIe7+T23g3uDZfK8IVYsPaaqAkChA+FUI/UrEpOA8hTJRQVe7kPyBqtftCarJ+91SWiOrRVsvc0+l833j52WcgolTgXP0hruugxESx5uh5shXhQNtVeDv+LBPQ/53mJMeHA92ubj04qvRPP6MEH8lwDfzgSWlpq0Jj3THt9Bh8YCR8YVxGXMonclfGRFiyPHwqtSOReYoLqDH056AyMzfV15yyLl9WCchbM5/bbr+p6PIbIlQvaJ0mqz2a/5OnohVdbQjAuk3CEhhGr+T5eqVLKSHAWr6KvqfQI1ulEMcmzqwZifR+avj0v1pDmKRWlVEPUSVLXHFtkjDg33FSirYF5qV4Q3R6HvkYzZ1lbAouvEr+zX8oE0qs7kTFGe5HLEBQ3qljpeC0OzR3nPYUoAntjjphxw8uYe3teOcxLTAtByGmIS/BuEpVIFX3rjHOWEudTMFoNFwtEJ126vllK8InMGxh8o9/cehdDSMQvyyVs82vnmbSdrbBmOmHaVjajJWFnL33d3HTd6S3RdMvNyR0UccOt6BWQnnqgsiPijabSn/Z1mPdsweGPX6JXDYOfNoKgXaO5gLnDYsoFPB00ep+zCAONtaJgSpmvp9PsH8Bzd9gX93yBhfE42vnTar6Abp0foxJgXeJyeZGllnyolEJME/Uy2E5XZ5XcEaW0z/DzpBvP5l3MJmQiRSkZnElI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR15MB4287.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(966005)(86362001)(6512007)(6486002)(316002)(26005)(2616005)(33656002)(6506007)(186003)(53546011)(36756003)(508600001)(66556008)(66946007)(4326008)(8676002)(66446008)(64756008)(66476007)(2906002)(38100700002)(38070700005)(76116006)(5660300002)(8936002)(6916009)(54906003)(122000001)(4744005)(71200400001)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUwySmlIekE5MURKM2JFQnNJZzFRYklxQW5ZYW05Rkwzd0VERVhhR1p1dEN3?=
 =?utf-8?B?bUpsRWNqRmRycGh5WCtJS1pXWWpnOS9OZWs3cjhGUDBsSk95d0RQSndLSFpp?=
 =?utf-8?B?dFl0aGYzM25TNkJrbllwWnFQc3luZDlSMmNpREE3VFk1eUp1MkJ5VVVwQU4x?=
 =?utf-8?B?MWFxczZpazRBdmhJQWRTQUlQcUVHMmZKbVdxSTlCMzZXKzRldXgrdnQ2NUJw?=
 =?utf-8?B?eHhlWjdGYXQxT0hqU1NvNTQrbFhibGcvRDNkb0VjUU1YZUJvYU1UWithU1ND?=
 =?utf-8?B?SmZDZUc4cjNLVS9KY0JIb2J1M29VNkR3LzBRMEZrUFlLdm5yVEpzemc1b1hQ?=
 =?utf-8?B?Z0FJZ1dHVUkxN1phNGlaQldJbmFNdTdKZUFKd285M21uN2ZXay9NWk90TWdi?=
 =?utf-8?B?MFJjWWFSUWRFSzZJNGZEQ3JZUGExMG9pWU9hVDFXVFBmZ0tPSDFDVk4wcnp2?=
 =?utf-8?B?QVhtZHV1MFIrdnVYeHF4RFg3RktYd0FvRFp6N21ISUI3RXpkckhRVXpGc1ZE?=
 =?utf-8?B?YXFGSFZmVzV5WTBQeU5KL3hUVDRjUjZYNHRjQ0hZK0hNN2EvZDh2UE8xQVlR?=
 =?utf-8?B?ZEsyclZUZksrVWhyLzJpUVFDK3dHSHBUb3BDSThVV2NQdzZvNkxPUXlzbU42?=
 =?utf-8?B?UVM4ZUFvd29wUnZpU2MvUWYza01SNmRDWHJlSHZiSkJmNGVERzFqSXN0aFdk?=
 =?utf-8?B?aTdrQ0l2Wjh2Tmp5RVJycElmaVdlcGxKUWRwaXhHbkYrMU9udVJCTlZzbG5W?=
 =?utf-8?B?TjRMRnZud1VLd3JxVHdDRjdZV1c5eG5ZR3lVblFvWUVQVUdsR2dvZEVMbVFU?=
 =?utf-8?B?emZDaWVkY0FMZ2hTTWx4SlcrSG5XNjRQanMzeEM2SlhQaG1NaWwrVXNFRlpJ?=
 =?utf-8?B?RUxoUmJOb254RkE5cnNxU2ZMUVB2R2s4VFA1Mit4YzgwcWhpYkV6QW1aNXB4?=
 =?utf-8?B?NFdKWmFkK3VaVGxZb0I1ZzcyTU9NTFlIUzVHdm0yZWZCenowM3lqVmU0cTlU?=
 =?utf-8?B?MWZCN2pzUVFOazhrb2NDWERzZjRvYzJvWXNIa2dHcWZJcnROK3FiMzludjkz?=
 =?utf-8?B?MmlPSEVoQjRtVWQ5dFJhS1lDb3VhVXBVQmpHQ0loSkR2YWlmRFdtWDNiWVNo?=
 =?utf-8?B?MmdpOERpZ1JjSzlZTkRJVzhqUHhSMlB5OVhQMzkvK2xZMjMyblNCcWh4R0JU?=
 =?utf-8?B?RVhxUlEyTldJaG04Q29DZ3dsVFBaVVQ1L1ZxZzN5QmVBMzB5ajIwekx0SFRu?=
 =?utf-8?B?MkZWcDZmeTFXbmczWXE0dU5MUVNIRTZzNkVUQ1JIdWo1TUF2bFlSQVhZallS?=
 =?utf-8?B?a0hkUUxLRUV5TllMb0V6LzE5SmE4d1ZvS09iYjJWZHcrWTJYdmlGcU05YWo2?=
 =?utf-8?B?c1orOUx4SG5mc2t5SzNSZWxxdGJ1Vlh5ZGZQRXFCZnpDejUwSFRvbTA1b01j?=
 =?utf-8?B?eVRRY0ppclRKVjFzc3ZnK3EzTGFRc2ZxWCtXNy9YbFRKNFhlcHNxMy9STlJD?=
 =?utf-8?B?TTdBVHZlRERndXVNYmw4QXlXRXJadTVaZVVZV0ltMnhmbFZzSjYzMStHbVA3?=
 =?utf-8?B?VW9ZMExla2p2VjNwWjNZenJtajZsVG80M2ZNdkF6QXhiMU1DZjcyV0NyVkhO?=
 =?utf-8?B?c1JEdjVidWRmZSt1b1htSDBRUU1tc25EcnMxSzhoRWNSUFBpL3k4enppbHJN?=
 =?utf-8?B?Rzhwenc1d3RnYy9VSUxESXpXQVBhUEZsK0dJTmp6MEg3bkpsUXMxQ1ZIaU1K?=
 =?utf-8?B?ZXNYNHFlZGYyK1V3cDJrUkFieTc1QXdGQmdMaHVkdERGNEpCRG1PR3NiUnJI?=
 =?utf-8?B?UEZxNFE2Y01zVHZTOXU4QkhvZ3pCOVNBQVJ4NG5BQU12aEVPZnRGaDZjNGZ3?=
 =?utf-8?B?OGpCeXhEWkFHZU9qQkRoeUVSU2dTekZEc05waXBBQnpLWXd1Tm1sZ3dNSC9w?=
 =?utf-8?B?Qmt6YzArUm5YVTZaMVhkaUZLVjB6ZXp5MFJHK1JISmtOT0VGeCtFR1FPU0I0?=
 =?utf-8?B?N0hFd1BSUG1EK0dvcGs1SlNnaXZOTmhmcy8vOUFGaDlDc2c2cC9QS0JOSFl2?=
 =?utf-8?B?aXkyT1ZqNjJBU2tuRW0rZXFXdTNlU3BzRUZ1cllNL3RiT0dhL3VMeTBiUHla?=
 =?utf-8?B?SnQ4RHJVSGRtNlBoUzBucml1VkVVemNTRVFoTWNQMTFHaTZNY3RQbGZYZ2Zw?=
 =?utf-8?B?N1hGQlo5WERBdVhCamVuS2RJRW94c2ZuczRXbGg1L1I0eTFMM3pNbkJFdm02?=
 =?utf-8?B?dktxb091d3djcldMNWR1ekV3UG1nYWErZVdGUVRtU1FWaVhJY1pUMDZ0clIv?=
 =?utf-8?B?aUNkSUdPaTNYUUh2dW10aWpiUHprSTRCTWVWMjdCUHdZU1YrK0FSZz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <34CAADC34DB6334D9FEB299F6A92B025@namprd15.prod.outlook.com>
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR15MB4287.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dea55acd-3a23-4e67-3ac4-08da28483e0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Apr 2022 12:19:56.9688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4yEBVbrkLv0rRTrgZP+Z8Opvq9WnB7myd207plMga98+fWWvxBnv4Uacqsh4+ESr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB5136
X-Proofpoint-GUID: Ze7btIXiye-cWdkgObyLHd2p14wHJ9Th
X-Proofpoint-ORIG-GUID: Ze7btIXiye-cWdkgObyLHd2p14wHJ9Th
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-27_04,2022-04-27_01,2022-02-23_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQo+IE9uIEFwciAyNiwgMjAyMiwgYXQgNzoxMSBQTSwgUGF1bCBFLiBNY0tlbm5leSA8cGF1bG1j
a0BrZXJuZWwub3JnPiB3cm90ZToNCj4gDQo+IE9uIFdlZCwgQXByIDI3LCAyMDIyIGF0IDEyOjU4
OjM0QU0gKzAyMDAsIENocmlzdG9waCBCYXJ0b3NjaGVrIHdyb3RlOg0KPj4+IDMuIGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMjAyMTgxODMxMTQuMjg2NzUyOC0xLXJpZWxAc3Vycmll
bC5jb20vDQo+Pj4gUmVmaW5lZCBxdWV1ZV9yY3Vfd29yaygpIGFwcHJvYWNoLg0KPj4+IA0KPj4+
ICMxIHNob3VsZCB3b3JrLCBidXQgdGhlIHJlc3VsdGluZyBJUElzIGFyZSBub3QgZ29pbmcgdG8g
bWFrZSB0aGUgcmVhbC10aW1lDQo+Pj4gZ3V5cyBoYXBweS4gIzIgYW5kICMzIGhhdmUgYmVlbiBz
dWJqZWN0IHRvIHJlYXNvbmFibHkgaGVhdnkgdGVzdGluZw0KPj4+IGFuZCBkaWQgZml4IGEgdmVy
eSBzaW1pbGFyIGlzc3VlIHRvIHRoZSBvbmUgdGhhdCB5b3UgYXJlIHJlcG9ydGluZywNCj4+PiBi
dXQgbGFzdCBJIGtuZXcgdGhlcmUgd2VyZSBkb3VidHMgYWJvdXQgdGhlIGNvbmN1cnJlbmN5IGNv
bnNlcXVlbmNlcy4NCj4+PiANCj4+PiBDb3VsZCB5b3UgcGxlYXNlIGdpdmUgYXQgbGVhc3QgIzMg
YSBzaG90IGFuZCBzZWUgaWYgaXQgaGVscHMgeW91Pw0KPj4gDQo+PiBJIGhhdmUgdHJpZWQgIzMg
YW5kIGl0IHdvcmtzIHdlbGwgd2l0aCBteSB0ZXN0Y2FzZXMgYXMgZmFyIGFzIEkgY2FuIHNlZSBp
dC4NCj4gDQo+IFRoYW5rIHlvdSBmb3IgZ2l2aW5nIGl0IGEgdHJ5IQ0KPiANCj4gQWwsIGFyZSBm
dXJ0aGVyIGFkanVzdG1lbnRzIG5lZWRlZCB0byBtYWtlIHRoaXMgcGF0Y2ggY292ZXIgYWxsIHRo
ZQ0KPiBjb3JuZXIgY2FzZXM/DQoNCg0KRGlkIHdlIGVuZCB1cCBhZGRyZXNzaW5nIGFsbCBvZiBB
bOKAmXMgY29tbWVudHMgaGVyZT8NCg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC9ZaENG
S3lWTXRPU3lCREpoQHplbml2LWNhLmxpbnV4Lm9yZy51ay8NCg0KLWNocmlzDQoNCg==
