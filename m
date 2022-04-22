Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABF7D50BFA5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 20:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbiDVSIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 14:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236298AbiDVSGU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 14:06:20 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D31117A7C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 11:03:24 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23MBqwvW003852
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:22:23 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=facebook;
 bh=5TJiMRWF6TKqApGoE0LJlON0bg/PwBl7+wFb6SXcC08=;
 b=W9+3PWdayC32pHHeOGu9eXUdJWsJehgS4aDP7mRipbTlajjVCrz+WdXbDN4elfsCYE6t
 66qxpOkzZYOsX6dYBAqxokgJTxBnD3El7q763Z061tS3bTFIjONP6XeCOYFU6z9wXjqo
 +dVH1hfQCTZ8mizYV++mjvheSfyqpf9c1m8= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3fkuvh23u2-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 10:22:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/Q3SKHgsAs/lm9qrvrwr6tjuhXK9MQ/6CZQOVjEVD3duZzwMA/xMR5RcOYFcjzbmRDJ/gNImC6KZUFo0EhNXyPqPUULfxL2mh0sCG+FpTg9Y+OF1hCakg3l4h0XeYw4vBh2AF5yibOSMsmsqBXw8aFaTBYI+sR1iZqowG/R9NSQDPcRF+01SKPP7qJ3nJC0fGI5KMLA84Zi9Ad0inCOZGLhbVoIozK7JcFueJK6Y3zV/lmzjm1QRukKZw9c2tI8BaGezQrvMPqf5mDhLwhqqGZEobJP+NShnLvF2Q2we++Q3FLu1vSgSVM8Auq9oUgEYBJ0x1U9qvktil0bOrSUjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TJiMRWF6TKqApGoE0LJlON0bg/PwBl7+wFb6SXcC08=;
 b=knL50bREV9GrzyZ71Ednr+wB7Ys3Jxt2iKViUKh0WTZCqCYQbZI9zkB33n/Le0t9WQjBZm2vn0kZ6IKCtBWkoQjclABM90N97KYNL8EjQAXjOYepylX5N4Tet0Guoj65bXT5zy0ZgtcloVJBX3+McZ0qFP225d8rqRCmEyvkHllPN6MnZsBYOzg9brP1qSi0ZQA5/h12+mVd23FfXIXKSNLiieEKv07QwYS50jddbRZORx2xeV2RG00ARDu+fNNLcoo5VMN30nIFRKi73//63KMmi39R7UBE4wFRoNtDRDJgkeA2OwBW5vt7UDjaKHh8uILY/bnT8OFiybLSqsbtMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com (2603:10b6:a03:423::6)
 by BN6PR15MB1858.namprd15.prod.outlook.com (2603:10b6:405:4e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Fri, 22 Apr
 2022 17:22:20 +0000
Received: from SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b]) by SJ0PR15MB5154.namprd15.prod.outlook.com
 ([fe80::b5e0:1df4:e09d:6b5b%4]) with mapi id 15.20.5186.014; Fri, 22 Apr 2022
 17:22:20 +0000
From:   Delyan Kratunov <delyank@fb.com>
To:     "peterz@infradead.org" <peterz@infradead.org>
CC:     "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "ast@kernel.org" <ast@kernel.org>,
        "legion@kernel.org" <legion@kernel.org>,
        "adharmap@quicinc.com" <adharmap@quicinc.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>,
        "ed.tsai@mediatek.com" <ed.tsai@mediatek.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>
Subject: Re: [PATCH] sched/tracing: append prev_state to tp args instead
Thread-Topic: [PATCH] sched/tracing: append prev_state to tp args instead
Thread-Index: AQHYVczhRtkPH5j9Z0y2TXtm68r0Mqz7xyaAgABm5IA=
Date:   Fri, 22 Apr 2022 17:22:20 +0000
Message-ID: <056e9bb0d0e3fc20572d42db7386face1d0665d6.camel@fb.com>
References: <20220120162520.570782-1-valentin.schneider@arm.com>
         <93a20759600c05b6d9e4359a1517c88e06b44834.camel@fb.com>
         <20220422110903.GW2731@worktop.programming.kicks-ass.net>
In-Reply-To: <20220422110903.GW2731@worktop.programming.kicks-ass.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 10229ced-bd6e-4f78-579f-08da2484a81f
x-ms-traffictypediagnostic: BN6PR15MB1858:EE_
x-microsoft-antispam-prvs: <BN6PR15MB1858964CFCBAEB5E6CA48B87C1F79@BN6PR15MB1858.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Uh19dn8ff83wndjFqlc3hemwNZ5noJTeOYdL0bzzcmDtc1qNZXCzgPP/+L1I6+kaPBsdziK9BQk0EXJTi3NseyAOPCei0XkFDjZrCVRzoCOZPHt5mXZn3XJ+IigOIydKaUAvMPhO1BIZVGvb0d3zMR9ItLFUqb3P7LxSgkFGZ9aPTYg86+7NsMlf/QeLyGbYoGPRNlX6fJezcqC0iV0sLpbLcVJP/AM6Mx+njQzI7p62WrKq/IdnkhmT3stxFtXGnGPemqBtn4la1ZF+M1p/6hIqOQMR0jfUQq7PqFCtXJ6TL7mh1TeaxiaPrvTyj20MtQA3Ww6mDLUE7JIP6yukFvyy6ZSebBdNXPXCCfSV8QJiITOEZsiBGQzj1kpRUSF3OevRYxbViYq4F7v3vbPAgBeMgDGFcJ1jGYNXy2v0W33/yev4vTvg+o47Fc15k++HpmRlvacmp+dSbvTSQlxtYsN50aHLtXpPYGmKaZVh8oIUjQKQqmAEYmQhM7HagoUUi3uXF8Oqyk5ScCPYlX2MAWTzI5pDzxr+f++O/GFB5Sig4YxEh+6l7hil142HR2DkBDeiNz7tVY60KPKnmcLFxjPJkfG3EZZXmV8NHHSb+9a4qD0d7jSHh3Ds7dBor4PHyGIspscFzSIyoZ72uBUJTwhZtG129YV/M0mM/b0VR+Ich0rKSXc0jJYWF6qb4U21bYVmL9qqlnmgUxIbGeIRcQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR15MB5154.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4744005)(86362001)(6506007)(66556008)(66446008)(64756008)(4326008)(8676002)(26005)(508600001)(71200400001)(83380400001)(8936002)(7416002)(66476007)(2906002)(186003)(5660300002)(6512007)(76116006)(2616005)(6486002)(66946007)(122000001)(316002)(54906003)(38100700002)(6916009)(38070700005)(36756003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cE95R3VMenoxakVBdldrbHRrQjhuUGpqZDBQaHBEcXI4ZjU4MDRvTlgzN3Ay?=
 =?utf-8?B?N09UUkpxM282NlR3bkN4UVBMRG5XQ1paaG1lQTMwcjVNUzRIK2h4VmdPUmdV?=
 =?utf-8?B?VHNWejZubmxoZ2JKNW90eXlJbjFnNEpvOUx5NVV2SnZrZ0EraHoyOG0xeUpm?=
 =?utf-8?B?Z2JxcGRYVVlRc2w2bUVCTEpxSk1oNXZmZkVDc1BJZDJPUkhKNnQyd1EwcEt1?=
 =?utf-8?B?SzhBR1kzL0dqV0ZWOVB2SHg0YnlxbDZsaWdCZVdDeDZORWxDVjJRTWlYSnhU?=
 =?utf-8?B?bnhXNkswb3ZPRWRGTE5EdHZiV25ZYXplVzBkRm0xS3FFcWY4MlhlN1U0V1dL?=
 =?utf-8?B?STR4NTVXZTRvaCtCdzdEazJDUkdvellISDEyNk9CSzJqbFR5M0lVekp0YjRa?=
 =?utf-8?B?SEdsdG4vTnhqWWF4ZkI3N0FqT084QXFtdksyUDRqSTJzZ3lVaXNoanN3WWtK?=
 =?utf-8?B?ek9rQlpkVFJrQlRldkVHK1ZyMlc3OEp5U2FwRW9IWUU1aE9OK2JMdEpMLzM5?=
 =?utf-8?B?M0dMSnlhR210MDNzZDZWUkhqcnRBTCtEUklSRXBFaUdxcTArT2F1azh2Q2tq?=
 =?utf-8?B?TGIwdythNFF2U2E1ZUQyTjlXQU44MnpDUDZxUlU1a3BkdEFzRXoyN0dwaTZs?=
 =?utf-8?B?L2szVDRNaWhXSkFkbUdYRGRXSGJyc2pid2ZVbGkwUU45OXYzQWc2S09FM1lw?=
 =?utf-8?B?U3VubmthTHRuQXpRK0lzWTdWVzVrQ1FFdkJ5NElBL0JNVERVZndHUThwTUt6?=
 =?utf-8?B?ZWJjS0lsM281YlRpWUJJa3lHZEFmbTViV0Y2ZCt3RXVCR1hBRjk3RVVyS2J5?=
 =?utf-8?B?VUZVUHBBaDdhV201YjhlRTl3RDZoc0FUdlpCWVR6ZDRUbWhDYXJ1eHNVVVlZ?=
 =?utf-8?B?UU1HYnJrVGFiWWJMc2xCTWN6YU5SMi91Umh4U2wrT3JDbEliZUU1QkJIcnhs?=
 =?utf-8?B?MHNpNHVtWXNwMExBbjBEQWRpMi8vcGtqeFo1WHNzdmppYlZvREZlNG5COE82?=
 =?utf-8?B?dWU2elMxRzU2YmNBUGEySVJLdU0ydEpuUWI4THlISmMxd2p0MTNMMStKUzZF?=
 =?utf-8?B?eEd0VVU4ODJzZWVlNXVYLy9mcWRrNTYyMjg1MStza2Yzdk5MTXQrMkZRb3FZ?=
 =?utf-8?B?SnpXcE1UZGozNXREL3JYdHJlbUxwdlFXV1FURndXQmtXbFNRRXNzdDBPcHY5?=
 =?utf-8?B?dW5VWVFMNEJmcmRtZlpQemRxNzdGcHJrRjl2S05VbG8xNDhDbHREbERWUHl1?=
 =?utf-8?B?aWxWeDVyREthOUlIa2xuR1RkWkx2NEwzbmhteGo1aWQ4K1REdFNzM1ZyR2px?=
 =?utf-8?B?dVRIVnNueEZuOVJlTSs0ZmprVFU3M0xUSVNtSnBrSTErOHBUQWExSnlTKzZC?=
 =?utf-8?B?dEMvN0l0cll6VCttWVZNdnU4Z2NieEduTUZWa2pZU3BhRWluUFNiRlB3NHBX?=
 =?utf-8?B?RDlmZnJrNTJkMUw3ckVORVU0RFVoZTd0TE9KN1Fkb21ERGYrelVyeExUV1RJ?=
 =?utf-8?B?b3lBVHZ0UDhHMmszVUZRL0cwZXlrdGZhaGpzMlBTU0NKSkphZy9zamtLMk1a?=
 =?utf-8?B?OFRacElDa2F2WlNMb2ZaNWF5TE1NQUJnMzUxak54Y21rSnJ2bS9GV2Vob01m?=
 =?utf-8?B?cWdIQWZDeW5pamdNL2k5WFdLVzJnU05wSUFBa3ovU1poNnRxSUUwVzVBaWxY?=
 =?utf-8?B?MCs3UGsvNUhxSlgzbHpxMTM0bnN5OCtucHd0U2lHSGZ6Wm1FYXRJQmdraU1V?=
 =?utf-8?B?V0FrVVRWbDYrcXhxUGNWdE5JVnhhSU43SHZRWmlob1VuUjRmM0s0dHhCOHQz?=
 =?utf-8?B?S2l1bnJ1RENPZ0JnMHpNZE1YQ0NyZzQ5SkgyVmlOU0tsOVBKbnQ2Z0tPYm9q?=
 =?utf-8?B?blNqZ0NYQS9hYVJLUGJOQ3lnUEk1a0pLTVFDMnRFNkx6cWptbDl2TllYNU9I?=
 =?utf-8?B?RVMzelJ4Y3lvbGV3ZEsyRndWRUliZFFtaVFYZWhuVHpFOUh1OEo2VlZqaXEv?=
 =?utf-8?B?QU0wZ0RhbUZyekN0REN2ZHZvSDQyaW04a21zSTlQYUpmRWlhYnZpSVg4N2k1?=
 =?utf-8?B?SEdHL0VmcVlxTWhOOFFLZ2VMTjc1bW0xaXpFNXpoZWFKbndpWkhqQkNLV0Zm?=
 =?utf-8?B?QUxDYVloNmZUcVZmMDI2OEdNVVdMdHdwYjloRXBEUGFzOEgycm45ZG9VdUhR?=
 =?utf-8?B?RlllWVVucDJZTWJzVncwKzNKUDU3M3lydjNJeDFpMDE5dmxnWURyNW12RVI4?=
 =?utf-8?B?R0NIVUZWUHBBTTloYlNCQmd2SVExTXRIbjg0RllhNFdHTmJPa1RmUnJ3OFlz?=
 =?utf-8?B?czZIVUUvbUtqN0lKVXFxRStXQnZhbVVzL3RQQlVPREtoL2J1QU44dz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AEE8529F7C01094F8C84CB39637FAE08@namprd15.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR15MB5154.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10229ced-bd6e-4f78-579f-08da2484a81f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Apr 2022 17:22:20.0630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AbSzFPstBSX+N7CZ5oUXlakxSwhThsek1nKIfNwKWfImTA7SQ/J7VXSHxXSvj9xx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1858
X-Proofpoint-GUID: X3LDRFtlR5kO-d32y0iAOlMAdj8x2wde
X-Proofpoint-ORIG-GUID: X3LDRFtlR5kO-d32y0iAOlMAdj8x2wde
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-22_05,2022-04-22_01,2022-02-23_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIyLTA0LTIyIGF0IDEzOjA5ICswMjAwLCBQZXRlciBaaWpsc3RyYSB3cm90ZToN
Cj4gQW5kIG9uIHRoZSBvdGhlciBoYW5kOyB0aG9zZSB1c2VycyBuZWVkIHRvIGJlIGZpeGVkIGFu
eXdheSwgcmlnaHQ/DQo+IEFjY2Vzc2luZyBwcmV2LT5fX3N0YXRlIGlzIGVxdWFsbHkgYnJva2Vu
Lg0KDQpUaGUgdXNlcnMgdGhhdCBhY2Nlc3MgcHJldi0+X19zdGF0ZSB3b3VsZCBtb3N0IGxpa2Vs
eSBoYXZlIHRvIGJlIGZpeGVkLCBmb3Igc3VyZS4NCg0KSG93ZXZlciwgbm90IGFsbCB1c2VycyBh
Y2Nlc3MgcHJldi0+X19zdGF0ZS4gYG9mZmNwdXRpbWVgIGZvciBleGFtcGxlIGp1c3QgdGFrZXMg
YQ0Kc3RhY2sgdHJhY2UgYW5kIGFzc29jaWF0ZXMgaXQgd2l0aCB0aGUgc3dpdGNoZWQgb3V0IHRh
c2suIFRoaXMga2luZCBvZiB1c2VyDQp3b3VsZCBjb250aW51ZSB3b3JraW5nIHdpdGggdGhlIHBy
b3Bvc2VkIHBhdGNoLg0KDQo+IElmIGJwZiB3YW50cyB0byByaWRlIG9uIHRoZW0sIGl0IG5lZWRz
IHRvIHN1ZmZlciB0aGUgcGFpbiBvZiBkb2luZyBzby4NCg0KU3VyZSwgSSdtIGp1c3QgYWR2b2Nh
dGluZyBmb3IgYSBmYWlybHkgdHJpdmlhbCBwYXRjaCB0byBhdm9pZCBzb21lIG9mIHRoZSBzdWZm
ZXJpbmcsDQpob3BlZnVsbHkgd2l0aG91dCBiZWluZyBhIGJ1cmRlbiB0byBkZXZlbG9wbWVudC4g
SWYgdGhhdCdzIG5vdCB0aGUgY2FzZSwgdGhlbiBpdCdzIGENCmNsZWFyIG5vLWdvLg0KDQo=
