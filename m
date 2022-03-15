Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D460F4DA158
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 18:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244939AbiCORfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 13:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238293AbiCORfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 13:35:02 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D782A730;
        Tue, 15 Mar 2022 10:33:50 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22FFX4XO023019;
        Tue, 15 Mar 2022 17:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=lFC5hmS01qnp+oNr1gNkPPjve5HwUT7Us4w5oWiT1vU=;
 b=zXSugwEjd/8nou3GLDgawamqm9jogIUjp03s5xtWZWWQgRU64uamwIUon/3bANSYYD36
 EFLD7Jx2iuhN75jnKfUAOzvn+ZjWWk87A+lA8bDpM7D9uU1ZRpLboq8yBkLiJ08SkGHQ
 foXNpbIUXJcj4wxe31oh5zO+4g2VhwqSlczgTJNsttVctHSHvr5wLiVva/jR0373eR2q
 xnhD2sCww9e3BTQNZIw8Y0JxdbYOs3MHQIKOawpKlZOhyxiesZslzipG8fqEykHjLQvW
 cth1EMzUQaFtY06LxpzdOQuyQS77s2gSOGEHFBUvLbgDx9lydYAW35LTE2WUYBSmIHqF MQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et60rbsqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 17:33:21 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22FHW194002458;
        Tue, 15 Mar 2022 17:33:20 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        by aserp3020.oracle.com with ESMTP id 3et64k4x7n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Mar 2022 17:33:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ao/oHrNn/V0/toAxRe55S1I1qDJKEbF+pKE0t3TTLtadbhk3AupfK+NX1+C3KF526Sr/5LD8jL5XU1sfcJcp2jwW+WvgRxx0zJgSlNVgyPMSo1uPQwAPUcs5gCwvKc7p21Q3lzDETAXOGJriHtESWtFkOtGflES+1KKYLWsv5+o8RGujGeG3i581O1W6xdy4wmqRKkn1scqg1wfR5Dg2Zz9r3xv/F7F6Fn3T7gGXhXu3yimCyx8aK/TGkQYx0vgohhILTQk88kUGgnNHv7N49WiHZ9O5OF4/mn2NTMIhQ9MoGnfWbzpJPrCSRR2ebi8WI6Ju0ZpqbwBgtm2jtHi1XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lFC5hmS01qnp+oNr1gNkPPjve5HwUT7Us4w5oWiT1vU=;
 b=cCNUiHsPxewAw+L+mnU4ytIjCbhwNdUpPJBE33lwNLVNhLxQA4XOrRVeK2T3Pk1kXRI920uoCGrk7zykozVKXM8mYK/H2qUmCgHuJDcpDVbcDZBDtZNoLyiff3D+/jPsgyeEjncV4eVWcfTNn4bRTEYTfDQMvUApCqsGEu+uQ7YTDiOdpBXoz5oeeu3JtxQTvuA7FQfOlyrBVcsroHEb+2c4kStPU+OAiNrd/pJ3o4v3f/Owr5da3gdw8HgbGyjdZue0BpMtfDNJFKYsGkOUby4vQ7WVBTfU4Y0R6Dxj1rafLY7q6/ErNbu52DkkeC8ya9ryCkP4G59polDSqNqV7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lFC5hmS01qnp+oNr1gNkPPjve5HwUT7Us4w5oWiT1vU=;
 b=Uu47ABX6RE70HDvObrzKgeSxBMzRfzTiB9c45D9LptQMEgzr5lEIoFiMIC9bWDXDFnfeHy0mulApD/TUr5156YQQxs0cmFig1Qk6wKbGJrfRf/xpeQhdhd8f0ktb6NiCSW1acmE6AOThR/BkAldNPThuGxQ12SiS41Q3PVrsBsU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by BN8PR10MB3377.namprd10.prod.outlook.com (2603:10b6:408:cf::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Tue, 15 Mar
 2022 17:33:18 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::94c5:42b1:5147:b6f0%5]) with mapi id 15.20.5061.028; Tue, 15 Mar 2022
 17:33:18 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the ftrace tree with the nfsd tree
Thread-Topic: linux-next: manual merge of the ftrace tree with the nfsd tree
Thread-Index: AQHYOCERC/ggh9jrUkKI/LHpz3zN0qzAckGAgABCmYCAAABmgA==
Date:   Tue, 15 Mar 2022 17:33:18 +0000
Message-ID: <E027D78E-E372-44A9-AD3C-234B109DDD28@oracle.com>
References: <20220315145828.413e9301@canb.auug.org.au>
 <A1869114-7192-4DF2-BD0F-B2A970F79CC2@oracle.com>
 <20220315133151.7e415bb3@gandalf.local.home>
In-Reply-To: <20220315133151.7e415bb3@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f60055a2-31f1-4c71-a5cc-08da06a9e4c0
x-ms-traffictypediagnostic: BN8PR10MB3377:EE_
x-microsoft-antispam-prvs: <BN8PR10MB33771586DF252CAA848A8CD093109@BN8PR10MB3377.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oMAJs9eW2WaEFO+Js9BdbqxHQ8wv7G1ji17A+OGM3xCImQTJ9eFAwiPYK3zvRng1CYwZrFG2BXCvXmIYo8oHHCNrBvMnmy3OSd62QIzdHBGXMs0ved7hio6txl4RrZzXv4dn9AM30RGcfvyiOAfSZMa75DzXj2DfKvrjaO16GmUpIUwUdcygQpSYQzIO0j2UAgOk9a0MGyrRlXBaS8gczIaOAyMPpU3rhB6u1Ljd+ezd4zabJU2jWntFze3ejAajGqIJmKYwWS4phanZVRISacFvt44u3+osGIvYJNOtHy8CFNLXaumo+Z/4t8RYloPtHyj0uN9Al0D6f6QsNizEktthuyU8ek9tk5aIreaEFgaVDU8aFUO4uhJycXRP4YBZassRf7zLkd+r0IZ6s8lUMklap9XBYtoLCUH2TyGcYRIEbKTJ29wZa3D3QoLaWmhCrQMOc2LIRb87UtnveQYGybQ7Bh1vwKuGT/xHkbvA/D7Pvnn4kODQWUGd4yX4bqLJyd/h95HLwa4ajTG8+pSOFCkOA4MHb89N8thzRwODpReR4JtHqEGM9UUO8LmmX8izbYTilI/3ElOrMhyZ4hEfYbGjxIxeYAIQVwU7H9ZbU3chA8d7ihvoQiohsTZBrCg7cSrqqBRzNbW8PdMuwoPCbbJWgWYD1lGLu4XIgiM7omWuH32HzzmCtfwUl2jVrbwDZvzM3ErInfE5nb3CfOc/XpkL52yUropWF+UlJoDcs5LUd5PLyIX6UdSp2Oukb1WC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2616005)(33656002)(86362001)(91956017)(76116006)(26005)(186003)(66946007)(66556008)(66446008)(8676002)(66476007)(4326008)(64756008)(5660300002)(508600001)(6486002)(38100700002)(8936002)(2906002)(122000001)(71200400001)(6506007)(53546011)(6512007)(38070700005)(6916009)(54906003)(316002)(36756003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qzrSthovfsMgPcSnZZzouev6HU+QRjJTi8q4qMtvAUpnSTEM1OXI45EZz920?=
 =?us-ascii?Q?EOQJ9ijRM8b2wTwVQ4HivzBrJb9DZPOVNIhX7cAMjaQgijwHI15bPljR41m0?=
 =?us-ascii?Q?OuAW6Uf08pGVnuJjNB7/4TuO9+Vn+NFNnNxb02LSk+Sc8qAXxfamDMsL672r?=
 =?us-ascii?Q?9QaPNYqcnCT43OqPkylMGXPDZ0fiKN9hJp4LRG4c8kRVyAfDzphY4Zp9XW5S?=
 =?us-ascii?Q?DsB4zexfWh53gJZUH6f99jzPfgDQD0MAoY+xVbzjcCj355OJdKXNfUaqtdvP?=
 =?us-ascii?Q?dE8uY3/JD/6RrMRrphx4/hAuNUK6S18ZYUJtjx1bqb8cQkh0wIl5xE9+beQI?=
 =?us-ascii?Q?fjrA3lBZz5wZJsjqz59XaX9NApzQJxSx/vCvz4sq62u9r1QOo5Zl+M364PJo?=
 =?us-ascii?Q?WB6Q1Xb1MXBMNmDYLEHo6h3Tq2AIjUfdkNLANBE0NTxHA5AYwXwChq079AtX?=
 =?us-ascii?Q?xKYNcmG+i34dt4Cin29D+1tEQFo1F6cVJW7fb+4kip85DTTy1wqiqadduXAR?=
 =?us-ascii?Q?3eDsYyijEifFY52PFkqe0Wufw4Q+iOUkFL9IzH6IgFw+hokQ5n3Zau1uSfkG?=
 =?us-ascii?Q?626ZG8IdKm1rR39Da3GFpHV7HVRha0JUC7pWVwPS7B0+wk482EziX4KRDzrl?=
 =?us-ascii?Q?Zr+4DjOMFnl7ZzMuRrDfXrtqjT1q1qDIfH0YBHLPd8Pyp4gR5c8o/biukIxd?=
 =?us-ascii?Q?ntwCSQefJ0y1ylQWvyZ2v+HyfZcH0Qw4c3t3H3Ri+UUCP4x1M7lKFnsRr1BL?=
 =?us-ascii?Q?DJH3nFM2B05V6vGVYpOPEMQ5TbfiDJ6f81nQVEH9awV4yaKhIEtM3hK+Yrww?=
 =?us-ascii?Q?kbg6M2I852tqJLblnLfUFij4oep59J2rk9plrWeix4sUV8n3JSkY0pcKhyFB?=
 =?us-ascii?Q?S/8jpwW2QKsMahUz9mb67FzjKepOICVM3OdCInfiDg2npIzIWJU0vJ5K+/Pa?=
 =?us-ascii?Q?mH5MZS6UNydNQ6bNDkFVQmTBWO26yhUsXdylu3TLLM6cGvCaxJg9XRH6ZLuk?=
 =?us-ascii?Q?+b6RCqW4qh00M/Oy6lIioZkTy9cCo+RBkt/ervlX/zsZ5ujOtp0IoA2O6A0y?=
 =?us-ascii?Q?7MRDhohualjc5K/+qCIuWVwjzmPgDxMpR2OjMAG6Li5ZqHnS2+Ax+ZPyZDVZ?=
 =?us-ascii?Q?DzpDz82lk6WFnmYoR7AXipe1tjGMkhcFqjxPL45WJBm/KqkjNSAxeDOIH33N?=
 =?us-ascii?Q?fsmVVTdpRD1Rq5riYsqzI5tPOuf6b8IwmkyUDCRLMr1EPJ9dCWxzl7EDzDMZ?=
 =?us-ascii?Q?ts1WNe+1i2ya6xJX1rzslsh0KhjQa+2q09/YHF+SnIr5qkS3l2ZNfJl+cI4i?=
 =?us-ascii?Q?GgZzRtgTfH2twfsc2iLYvHnHH5pks8pkBhQXkjAl02WAhSqc7E0k/ZQwAMsu?=
 =?us-ascii?Q?nFKau0+NwRaG2qEm2sPHaVBvbBSPT3hTVQgq0LyztqxCyXU3OMT2pjAEEs4M?=
 =?us-ascii?Q?iQ+7VQtZZjdVaQow+SHKyzeYR6OEYNsbtl0djfF6E6PTOotm6aKHyA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <45D0A3AC8AAF2341B23B79B13B12C6C3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f60055a2-31f1-4c71-a5cc-08da06a9e4c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Mar 2022 17:33:18.2322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QSXm2r5nk1c2W5qCubtm0Hs/rTzSo2BSvotEqILbvnxLo6GTlqeJbx9u9Br/ca7xKYCqg2UMqQnq2LXv/l/o7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3377
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10287 signatures=693139
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203150106
X-Proofpoint-GUID: 2Q7ZFK0mh19ixV4XItDchqbf3LySTuAa
X-Proofpoint-ORIG-GUID: 2Q7ZFK0mh19ixV4XItDchqbf3LySTuAa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Mar 15, 2022, at 1:31 PM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Tue, 15 Mar 2022 13:33:30 +0000
> Chuck Lever III <chuck.lever@oracle.com> wrote:
>=20
>>> On Mar 14, 2022, at 11:58 PM, Stephen Rothwell <sfr@canb.auug.org.au> w=
rote:
>>>=20
>>> Hi all,
>>>=20
>>> Today's linux-next merge of the ftrace tree got a conflict in:
>>>=20
>>> include/trace/trace_events.h
>>>=20
>>> between commit:
>>>=20
>>> d07c9ad62247 ("tracing: Introduce helpers to safely handle dynamic-size=
d sockaddrs")
>>>=20
>>> from the nfsd tree and commit:
>>>=20
>>> af6b9668e85f ("tracing: Move the defines to create TRACE_EVENTS into th=
eir own files")
>>>=20
>>> from the ftrace tree.
>>>=20
>>> Well, this is a pain :-( =20
>>=20
>> Apologies. Steven, can you take the sockaddr patches in your tree
>> and resolve the x86_64 build issue?
>=20
> Actually, the issue is not with your tree. It's a conflict with:
>=20
>  fa2c3254d7cff ("sched/tracing: Don't re-read p->state when emitting sche=
d_switch event")
>=20
> Which changed the sched_switch event that my example was attaching to.

Thanks for troubleshooting!


> At least this proves that it will not compile if your custom event does n=
ot
> match the prototype of the event that the custom event is modifying :-)
>=20
>=20
>>>=20
>>> However, my x86_64 allmodconfig build then failed like this:
>>>=20
>>> In file included from include/trace/define_custom_trace.h:55,
>>>                from samples/trace_events/trace_custom_sched.h:95,
>>>                from samples/trace_events/trace_custom_sched.c:24:
>>> samples/trace_events/./trace_custom_sched.h: In function 'ftrace_test_c=
ustom_probe_sched_switch':
>>> include/trace/trace_custom_events.h:178:42: error: passing argument 1 o=
f 'check_trace_callback_type_sched_switch' from incompatible pointer type [=
-Werror=3Dincompatible-pointer-types]
>>> 178 |         check_trace_callback_type_##call(trace_custom_event_raw_e=
vent_##template); \
>>>     |                                          ^~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~
>>>     |                                          |
>>>     |                                          void (*)(void *, bool,  =
struct task_struct *, struct task_struct *) {aka void (*)(void *, _Bool,  s=
truct task_struct *, struct task_struct *)}
>>> include/trace/trace_custom_events.h:34:9: note: in expansion of macro '=
DEFINE_CUSTOM_EVENT'
>>>  34 |         DEFINE_CUSTOM_EVENT(name, name, PARAMS(proto), PARAMS(arg=
s));
>>>     |         ^~~~~~~~~~~~~~~~~~~
>>> samples/trace_events/./trace_custom_sched.h:21:1: note: in expansion of=
 macro 'TRACE_CUSTOM_EVENT'
>>>  21 | TRACE_CUSTOM_EVENT(sched_switch,
>>>     | ^~~~~~~~~~~~~~~~~~
>>> In file included from include/linux/trace_events.h:11,
>>>                from samples/trace_events/trace_custom_sched.c:10:
>>> include/linux/tracepoint.h:279:49: note: expected 'void (*)(void *, boo=
l,  unsigned int,  struct task_struct *, struct task_struct *)' {aka 'void =
(*)(void *, _Bool,  unsigned int,  struct task_struct *, struct task_struct=
 *)'} but argument is of type 'void (*)(void *, bool,  struct task_struct *=
, struct task_struct *)' {aka 'void (*)(void *, _Bool,  struct task_struct =
*, struct task_struct *)'}
>>> 279 |         check_trace_callback_type_##name(void (*cb)(data_proto)) =
       \
>=20
>=20
> It's the type check code that failed. The above is complaining that it
> expects:
>=20
> 'void (*)(void *, bool,  unsigned int,  struct task_struct *, struct
> task_struct *)' {aka 'void (*)(void *, _Bool,  unsigned int,  struct task=
_struct *, struct task_struct *)'}
>=20
> But it found:
>=20
> 'void (*)(void *, bool,  struct task_struct *, struct task_struct *)' {ak=
a
> 'void (*)(void *, _Bool,  struct task_struct *, struct task_struct *)'}
>=20
>=20
> That's because the sched_switch event had the int prev_state added to it,
> but my custom event was unaware of that.
>=20
> Stephen, I pushed out a branch on my tree that merges my for-next branch
> with next-20220315 and pushed it to:
>=20
> git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
>=20
> branch: trace-merge-next-20220315
>=20
> -- Steve
>=20
>=20
>=20
>=20
>>>     |                                          ~~~~~~~^~~~~~~~~~~~~~~
>>> include/linux/tracepoint.h:419:9: note: in expansion of macro '__DECLAR=
E_TRACE'
>>> 419 |         __DECLARE_TRACE(name, PARAMS(proto), PARAMS(args),       =
       \
>>>     |         ^~~~~~~~~~~~~~~
>>> include/linux/tracepoint.h:553:9: note: in expansion of macro 'DECLARE_=
TRACE'
>>> 553 |         DECLARE_TRACE(name, PARAMS(proto), PARAMS(args))
>>>     |         ^~~~~~~~~~~~~
>>> include/trace/events/sched.h:222:1: note: in expansion of macro 'TRACE_=
EVENT'
>>> 222 | TRACE_EVENT(sched_switch,
>>>     | ^~~~~~~~~~~
>>>=20
>>> So I gave up and uses the ftrace tree from next-20220310 for today.
>>>=20
>>> I am going to need some help with this mess, please.
>>> --=20
>>> Cheers,
>>> Stephen Rothwell =20
>>=20
>> --
>> Chuck Lever

--
Chuck Lever



