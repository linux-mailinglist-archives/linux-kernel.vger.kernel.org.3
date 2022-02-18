Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362204BC2C5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 00:11:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbiBRXLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 18:11:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbiBRXLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 18:11:11 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22FB760CE2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 15:10:54 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 21IKfU7Y006076
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 15:10:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : mime-version; s=facebook;
 bh=tpyvDuSepAatgPa0lVT29m6IEHyGw/jgSskFogFZZeQ=;
 b=ZGano73MfLEOQAJUzrMirhxS6d5PDrHkLJbRIauYEqf766HPRUluwP81L9/oa91viRx4
 0Z2v42hZtRWqruXC4bjObQHKfm1uWNFVyfpzxDhSXfHsBF9V/vrgfy6gy6iQYpxnQXUc
 wSowRSkHke1oknCnmYNv5fXfJWwSIDzG1YA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3ea5cae1xp-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 15:10:53 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Feb 2022 15:10:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Glop189Lhb1Uak0mmcSZZb0ulUqK7DbquQzeu2hVy1yBunNvQDmgbB/5QkV8QTMWxKuqrut7J5IipBUi7shonaW4ibyvG00K2xoMDWdoG78fvxiE6FMwFgouVjTMyCFOQhxHe8L5GJdfUy7JNcSDsF5DQWkcKPDuYUuhy/SMitCrpxMvO8SUqe4JvaMGMSSMD+XfC4akeEiYAPSRJz4VUy7uMsv3yfS4JOWSVtC7j/d39eu5EpLElM/WrGhH4AQiV5fraAx9wU6sDlP34mpaEOyHuIxQK6wTplFep88Yvo6MeLsQbSNsQ0Mxo70hlRS76rTUI/D1QFzdgakP+AJX6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tpyvDuSepAatgPa0lVT29m6IEHyGw/jgSskFogFZZeQ=;
 b=B39FPZJGx0/xN3JAvJEAB5Yyy4FJqDnUriwlo+orjDx4yoj9DLInK4mp9P7RUsVU7TvAMXi9iXZSPE3jlCjTtyE8TZuoZgKAMza7WcAsF1YnQyLtWZEobgkDTa3x58M8eh3E2ES6XJR3hV3EVLgqOkS4zP2pwL/CRe99Ebk4qQA2hSkMu0bUQLGo7cgWPT4OyyvoopxZqMpP90Q/RtRkLjR5lU2+qCbKAIMn2+F6Dq32nXkzkktiysz/nLijZIzcoly1vK6YA2JDhxNQpbZ7+se23b7E4A8iOYWrqdxoF8/VyTq7VdX2qHF427KFZnSUkSYrV6yzYd2Q7gNlKGDQvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from BY5PR15MB3667.namprd15.prod.outlook.com (2603:10b6:a03:1f9::18)
 by PH0PR15MB4229.namprd15.prod.outlook.com (2603:10b6:510:1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Fri, 18 Feb
 2022 23:10:51 +0000
Received: from BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::cfb:a2:e4e9:be55]) by BY5PR15MB3667.namprd15.prod.outlook.com
 ([fe80::cfb:a2:e4e9:be55%3]) with mapi id 15.20.4995.020; Fri, 18 Feb 2022
 23:10:51 +0000
From:   Nick Terrell <terrelln@fb.com>
To:     Qu Wenruo <quwenruo.btrfs@gmx.com>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: v5.17-rc3 compile failure on aarch64
Thread-Topic: v5.17-rc3 compile failure on aarch64
Thread-Index: AQHYI9msiKPjLIK4aEiPohfL7+V0rqyZ8dWA
Date:   Fri, 18 Feb 2022 23:10:51 +0000
Message-ID: <F85853B6-A81C-4AD9-972C-747CAD6391B8@fb.com>
References: <85bfe02c-9432-c5b0-04e0-8096adf37b93@gmx.com>
In-Reply-To: <85bfe02c-9432-c5b0-04e0-8096adf37b93@gmx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 74eefb59-335d-40cf-5e25-08d9f333e848
x-ms-traffictypediagnostic: PH0PR15MB4229:EE_
x-microsoft-antispam-prvs: <PH0PR15MB42291F240BB331E1D9F7A5AFAB379@PH0PR15MB4229.namprd15.prod.outlook.com>
x-fb-source: Internal
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bIHCeKFrnfR5jNqYj3EBLf/ORN+Jlq7ZrqLF/6K4dPJR7A1R8JzLpJa42m9q2YsRcACq0fJ32c0IRehimhAnB4KgP0S0tkbzZZ0dmQdqQt54Wq8IljZmqRlcQiWhgda1uKC3RTe5MPXdJJZ8rHwhMisee6NDEYtnoyuUMl6gmjgZfOrQ2HW0chYGYSp9ehO3xwAkso+c/Tx+5udITt6GmSt4oWGVOBmvFBBEvUkTu8gLvCkI+s8xXvIc9g7lpDfaYx4z+W6Po79IpmlQpIc8v3Es6+NDzHBcUsPjFAMCCS237bniAHZazQ28bxpAXYVP87W8t5ZVY4WcAcYS2rDweEfUOk7Ahd98ymmm8bQ0mWjRZYYQWRfBEwK9eveiiXNvmSJWusS7h7imKqtXRj+Hzdc31L5UGUtpLiFLaPnpXOWxj5efehV/MbpxQb+a5WYDu9gV5jYMLPBy2gszMFllYZjsoKiePw0t8GrvS/Izomv/K8a0NmQ1qFZJesMxlnq9k/M8TOCS6edrwN2XR4gHhnkv7UcDPvLBtx/BYfj60ckFA8y2Y3sISVb9GAJv+1v/wfZxI1e5omcpfdRAywvyfeVA0pQjkzgmreIZVRWOs/2MCm6tIiCOI/LFUHgojbo5aFKuc9aujB0BdEeXazCZzcgJIDuxto1IW8SpGIQfh+WWzXEn+iUat1uTD/gmcqhJisYOxyuHvvHgjl4Jw5kdT9qXgRUXgQ7RNrvDDcfcXPbHHs/URMEvCI+X1vz7IOWJ+2xPjVO2Wds++KtEpTtAlrDckYFLEspoNoQzf4s3b5mY09tjFtvQ58QZEX4yptSXp0ANMB18+9cu4oLUP8bwR9YL5SrSt1W1nbh4VgGYK+s=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR15MB3667.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(966005)(36756003)(38070700005)(38100700002)(53546011)(316002)(6506007)(71200400001)(508600001)(186003)(2616005)(6486002)(2906002)(6916009)(8936002)(33656002)(83380400001)(4326008)(5660300002)(66946007)(91956017)(66476007)(76116006)(66556008)(66446008)(64756008)(122000001)(8676002)(86362001)(6512007)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?aa1M51tFGqcAlqnOwsA5OXxp8E0fzrNnT7lpklSfayHdDw4aeTr13gEObnmY?=
 =?us-ascii?Q?X4Pc/qS2URLevW3MF1hlFz2BAiMg6IysEbqdiEXYm0J0pS8YW4xIB20AA4kR?=
 =?us-ascii?Q?SwUwyiWmhEVSdGfnN94/bNnsEXNrl2D6Ark6ehJwXqqM5mX9u+r8/ZzTpbbU?=
 =?us-ascii?Q?xiWRxjo924MHSpxTlK8trGgCIy8/sn7zZKfqTk9opcxHRlK8EFcUlpyV1scM?=
 =?us-ascii?Q?0HNGb3ETQU4R1P91ZJOW83CcTaKn9ndLr+tFMoycIa4eSD1TOOPnTeoLBS3/?=
 =?us-ascii?Q?Dj633wQ5O0CYW4hPVjvZWvTYlY/mm3Fq6mJpmdv4Z7SVVLLwt79PQbCh2+Xz?=
 =?us-ascii?Q?20ukX9ntxp6hHgTUXfixfZ53f22DLrPeu+grKW5K7y8XBw24rg+k/QMDe9jN?=
 =?us-ascii?Q?hD8YcJpXtGN4glLu644pNckKGS0k/atgNuCyMf/3XPmzVgoLkrkLhv5MjPNw?=
 =?us-ascii?Q?hoL9bxAVmh4hNZGd2uRebao/RIbv4N1gR3HgVQYjchcACUs2KpHK9KNZR8Sr?=
 =?us-ascii?Q?YRzeE5hLUObmypec7D53te24KQm25ubn8njxV93ZVy1zi/p3epqO17x08LfH?=
 =?us-ascii?Q?PFyQjwAFmZgyqUSUZlvOP5OvraBcjZ1mk0/eahV+ZBRpUiiuJJGtrFLqfdba?=
 =?us-ascii?Q?VQV7CoOwJkVme/Jeo6gcA+SXHHSyJZLJNUnMlu22Gn3DviB7aaJiq8TDrKr/?=
 =?us-ascii?Q?8ax5fGICebwD7+es7BKP6YUQSnPD6Ebku0F0uV6W7BY3YqgPRLFeu6vrI6KF?=
 =?us-ascii?Q?A1ldVLf/kM/n2Q7Gv7ptxybHz5cmJlw9+5yNfF9w2nZd1XpbV4RDoDAY9Xcb?=
 =?us-ascii?Q?3T0JXLiEgK49atQWbBNdPjqan25hJhz0yssTy+V59gTJ1aN2QBQb70hOy03t?=
 =?us-ascii?Q?gideL1TOLjw+ZPMhPM3DYrmDltkxs+jqcmGTE81BBTGNCBcf60XM3YQMwwpg?=
 =?us-ascii?Q?v+405QifkC6br7KnxZxpT0ZL7gRKumzv7+aAJ+BN5BlELIGR/PC0c+gspDwX?=
 =?us-ascii?Q?Q+azbg7rOx+5Q6YUZitUJ2NAYHybZRFYL1nGHyLhy/Z6xKRSPVQuzzgDAUEl?=
 =?us-ascii?Q?UhHBcYWthLDynzBv7gQKTH+4pa2dvKWB9+tiRKJay7FYINnUYWX67thiepcJ?=
 =?us-ascii?Q?O8/ZVBbuOKxvJhlwVVD4/K6sAvd4XFVI7TmPoqw0P94N8ubrWFZVC5xLuqjR?=
 =?us-ascii?Q?bRNbPm2/SU6/2xZ5ApTKX/zdChJGXlI7tQm1sGZlt3KglaTNs5Zie3oB9CkT?=
 =?us-ascii?Q?lsgv/kPBMU8dU/ucSMN+wgXA+f6FIEoi0dAMC7J8faFPOnVnSl4QFxWJVXp8?=
 =?us-ascii?Q?wDkjsH1/PUejj2pZQjEZu7l18JLxFKq1aT25NIEd4zaTi8+dUm0z3NnEEPuy?=
 =?us-ascii?Q?UnTL/Db5k0qabeJW9uBNRXBVM6zKf24CVT2/fIaKa3rJARgVAw78YGa1S+DI?=
 =?us-ascii?Q?K6kPvcNQ4tYynNNpA0gFkzhkmHWG/ombfId9/GciVms3+g6N8tJHb9eHMFE+?=
 =?us-ascii?Q?qTD8s6r/nM7piwvHA7HfZ6wzW+YpPECdQtzwBUn4IeSjJeQ5tvYEZNjPvWTO?=
 =?us-ascii?Q?cakM9nhO70jFDPnIYbjhTzDXyv5Q50dtdo11bE7NPufx3t1AQhu8XE7331vV?=
 =?us-ascii?Q?cQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <24011BDB68AF6A4AA43E9F467B1BA287@namprd15.prod.outlook.com>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR15MB3667.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74eefb59-335d-40cf-5e25-08d9f333e848
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2022 23:10:51.4480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kh3KFWAl8/Sl+yQPUtYNfxJYp99mdjBLyGSPKottgrHv+tBNL7xx3u2J258iJD2B
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4229
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: Po_7wVPpv4JCeaeqyw5_wWriCx9uDIV4
X-Proofpoint-GUID: Po_7wVPpv4JCeaeqyw5_wWriCx9uDIV4
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-18_10,2022-02-18_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 mlxlogscore=803 lowpriorityscore=0 impostorscore=0 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxscore=0 spamscore=0
 clxscore=1011 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202180142
X-FB-Internal: deliver
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Feb 17, 2022, at 12:37 AM, Qu Wenruo <quwenruo.btrfs@gmx.com> wrote:
> 
> Hi,
> 
> Recently I found v5.17-rc3 kernel failed to compile on my aarch64 setup,
> it failed with the following error messages:
> 
>  AR      lib/zstd/built-in.a
>  LD [M]  lib/zstd/zstd_compress.o
> ld: __patchable_function_entries has both ordered
> [`__patchable_function_entries' in lib/zstd/common/entropy_common.o] and
> unordered [`__patchable_function_entries' in
> lib/zstd/common/error_private.o] sections
> ld: final link failed: bad value
> make[2]: *** [scripts/Makefile.build:484: lib/zstd/zstd_compress.o] Error 1
> make[1]: *** [scripts/Makefile.build:550: lib/zstd] Error 2
> make: *** [Makefile:1831: lib] Error 2
> make: *** Waiting for unfinished jobs....

I'm not sure what's going on, but maybe I can provide a hint to people
more knowledgable about the situation.

These objects are included in both the `zstd_compress` and
`zstd_decompress` modules [0]. That may be relevant. Back in 2018
we used to avoid having duplicate objects in different modules,
but then kbuild added support for it, and it was cleaned up in commit
dc35da16 [1].

It also may be irrelevant. Zstd was updated in the v5.16 kernel, but hasn't
changed in the v5.17 kernel.

Best,
Nick Terrell

[0] https://github.com/torvalds/linux/blob/master/lib/zstd/Makefile
[1] https://github.com/torvalds/linux/commit/dc35da16a2e23db04822f0129cd5b28b7b0e72b4

> But the same code base compiles fine inside my x86_64 VM.
> 
> The aarch64 environment is an VM running on RockPro64 or RPI CM4.
> 
> With a little older gcc (v10.2.0) and bintuils (2.35).
> 
> While for my x86_64 VM it has newer gcc (11.1.0) and binutiles (2.36.1)
> 
> I'm super happy to upgrade my tool chain for my aarch64 VM, but I'm a
> little concerned if there is something worthy fixed.
> 
> Thanks,
> Qu

