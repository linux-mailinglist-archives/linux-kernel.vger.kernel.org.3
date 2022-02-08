Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A7854ADEF0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 18:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383723AbiBHRIz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 12:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383626AbiBHRIw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 12:08:52 -0500
X-Greylist: delayed 1210 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Feb 2022 09:08:49 PST
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F4CC061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 09:08:49 -0800 (PST)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 218DHCBn028548;
        Tue, 8 Feb 2022 16:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com; h=date : from : to :
 cc : subject : message-id : content-type : mime-version; s=PPS06212021;
 bh=QA4MvhwexQfcexlukRrhQnsoU3Tvn4tFbnV8xTUtTd4=;
 b=W2wnSFBZfVTCR5k88LwbrTcB0g8Y0jm0+7yeu6cmmSlzcKWJTHM6/UHITtHZdy3fXM05
 aUhFNJBROUCys9VztAk+eVQk8Y+3ZBo83IUVZIW7x9FlQqOnhQyvVJQmI2iysb4f09OE
 F/5WMRL3A4ozTcBe9GySY+jN49UpeBMXg/gzLWXhTs1j+nraJGr69hiFJtBEMDCoZasG
 4R3IwSh7c6G8x+NB4rS61J6QXn9770lN6e6C1hTnd19jPEjoybZta+CDihlM83j8WbD/
 P/8ZY6I3shgF9PR5ZP232OTtwCr4zXBcagbti5QI1/tqOXgs3zSNywb9RfJltborBDCv GQ== 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2104.outbound.protection.outlook.com [104.47.70.104])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3e34s191f7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Feb 2022 16:47:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eI8mL8MpZriYDBiqCETm/VgPI0BX7q7ON50RuZcqZzVafstEzbH0seBCN8WzFBjRpBB/I/kyviozPYea9H7m3DXIkhQEfMnwhwwr7rdB7u13y9g26R08Tmof5lcYwfxU6sBak1VKbaQxNU7seB377bV4QDxWkXsOh928bqP3deaHZpErgYcIxIS1C4MYXNb/so2R1CDUKVrUQa6q1Eg4yhfK0SwYVxDisTscHaIT2slMWNT1pT7/QD3cxW+5VueADEl5FBcZpqMlXeM/7x+tjebLKgN0vrYYheiJojB65pzLZ2jQ2TmZi5WHYE836RW7oDiEPKnjuL1OT3ltN3suzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QA4MvhwexQfcexlukRrhQnsoU3Tvn4tFbnV8xTUtTd4=;
 b=mPD+T5GN6iltvji36fFImlligQ3h7qlYDnTGI7r9psHU6wDN2Gbnm0suhFrqlblQMU7RxbDo66f7Y/Qq+swZSA7hPPLs4SQrmgDb4P+aoo2XccGl4OPPK353v9M5W2EiX3Q88knonn2wHIqkh8xRuPvVQg+x4K4AOBiyQ3OlTTtkyZ548w+vGa49whBj+1uwwOhUzBDaxcmQrJphSQ6dYCY8jYWwdzCZRxWepTMgg6N+hk59s9xPPbwRLnF8kJdaVDp+7w0Fhixg+EhGzlFoXWe8W6d8srdoLRbzODtpsX4M7jzNdy9WQSTWTlMVDpy7UVFmJptPTA2nXrNbj+79IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DM6PR11MB4545.namprd11.prod.outlook.com (2603:10b6:5:2ae::14)
 by DM4PR11MB5552.namprd11.prod.outlook.com (2603:10b6:5:399::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 16:47:55 +0000
Received: from DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::f521:6df5:7924:e4f0]) by DM6PR11MB4545.namprd11.prod.outlook.com
 ([fe80::f521:6df5:7924:e4f0%8]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 16:47:55 +0000
Date:   Tue, 8 Feb 2022 11:47:49 -0500
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@gentwo.de>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nitesh Lal <nilal@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz <nsaenzju@redhat.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>
Subject: Revisiting the current set of nohz / housekeeping flags before export
Message-ID: <20220208164749.GB230002@windriver.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-ClientProxiedBy: YQBPR0101CA0115.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:5::18) To DM6PR11MB4545.namprd11.prod.outlook.com
 (2603:10b6:5:2ae::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b86c9794-d6d8-4d94-aadc-08d9eb22c0ea
X-MS-TrafficTypeDiagnostic: DM4PR11MB5552:EE_
X-Microsoft-Antispam-PRVS: <DM4PR11MB5552FE0582A7F44AA0F575AD832D9@DM4PR11MB5552.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bp7bFV540BmyIrJUmya+M+qdjB9qTEFOLiEBbrX4xGHnw9T70kDQb6a2sJfLIjm4EV3RjRof9o7KNylX3lqtQSIl241zefPJ0onyc7t+XMAAVQY8BaANm5pyZcYzFF7XWpkQ35pC1FUYysv0h4Fxhf3eg+YfkDes+gv0lyiDpnqp7EsQxdPVWnq76tFRxFRCNltK/LoPLMB1exbsW5stIiKuvn0+L2yU3BVTRJj0heT/4H9HnDWPto5vijqe2G6vxZfeq+fEc3piL2vNA8LfQOsdilnxyLh9f85hnnApFtwmocY6Cq/xPLZDU07JF3iuJo4JoqMrslvDHrXgGICWbAswwNf/dbIqTNjpmSDF3IBwLLyxI8BQOpW/Vnz7KPgyaB90naPBzbfpRwpJUQM33kIHmpe1EVWsojIs9BOShc9zXVMn1Pj76MZF9BHOvtCo7eHPwPQB0/r5t+iUmLg/fEwOwFQeyiBJp5aqED/ZRp50BcQ7fX8vaWY3MArvGgj3zxq5Xzao8ZzLyHs+ZH/gOGFAxmgNLim6Qc0thXpKS5UK/SD34DRMUtMmstskgnoASR3GABfF4IB551m3+CgJZHZbTc0l+qCZsM3pah4UWpY5vJJs61tZdlIKdx0P4tp72MRu527YsJUFyU1gYx+vpVTxHUMtmdiGpA5Rg9wjsCuhKSyjFxEOtDpMA9WRKKY5SJ5sDv6rj3dWfT4/oON4OiqWR9yryPmQLjpfu9SvFoyqnCl8Ia/WYJa+XVY7flDkF5BQNXevU00I3Rs0IcZ+dGy7JkgiZnq83PIO2ZjjcvX2uN6GVvtYovlXUuacH0N02DTIG/1RDkGlhCWrYqUcc65i4XWMffVp3mO/KB0kz4E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB4545.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52116002)(4001150100001)(6506007)(6666004)(33656002)(966005)(6486002)(6512007)(7416002)(86362001)(30864003)(2616005)(38100700002)(508600001)(44832011)(2906002)(83380400001)(186003)(110136005)(5660300002)(26005)(8936002)(4326008)(66574015)(36756003)(54906003)(316002)(8676002)(66946007)(1076003)(38350700002)(66556008)(66476007)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XIj9xTtr0NafcoA/n2TAAOMAyln/bF+p03snPpELLGAsgfBV7KdRGhxhqDP0?=
 =?us-ascii?Q?EVxrMEgXavL/RynQh6qQ+EZA07tI1jC8BdJXYCOGDdysIOHGs56E9N19GUEa?=
 =?us-ascii?Q?Qt/eCSB7JdH0sTz78sz6jLzdOzsZd8itzKWJQFgJK/LzzjQkZU7hQHq8HTZW?=
 =?us-ascii?Q?GM+JJYOKgaryvH0ny4u0/u+Blv30QaJJKc+IOPotLXDTtnM3Ybb+pUo70N1s?=
 =?us-ascii?Q?yV4gWK5gC2YhUhDvyyFgHrFIeTHuNfg0xx96I7G0+TJkN20PJfWlf5VpBuor?=
 =?us-ascii?Q?6FO0nB5FVDwtpTsQhSLp7AJE5evtwxf6uQXD9QVNdQhCQ7WCEPYmAWYOPi7Z?=
 =?us-ascii?Q?BONLEFhuj/pf122V/t6UPWK5VlZa9Jf/waWP9tgy7jAK0Ok+N0aQn1DDM7J2?=
 =?us-ascii?Q?TAG2pcixiGqXyMCEawRfeX/eKb47W3hFqhLNXA6E3alqGCo+w7hPsq42PORL?=
 =?us-ascii?Q?6pbMDXSdYWwYOG2WH81BAKWynpJ3SJn32026aRZ5GrpoKu/TWXCrk+q+KiX5?=
 =?us-ascii?Q?AD6Kj4FfJQ9uBAZUDLX95R0e151Y9VmX2F3XAhpQARjndB7ZJ4nF7F3773rQ?=
 =?us-ascii?Q?LnhC6A1lhxYkyVva2LfOySd7wwGOQ7POTkRc40nbPI6DQPLsr1tkzIV5M8o2?=
 =?us-ascii?Q?s37yjFygnnZWmZsLdOSGK44yZgOH/ltqq3HrO+jO0h0Xx9BFn/n4N2f5rs5K?=
 =?us-ascii?Q?t+CveaBsRN18GWC5p+Tw1t8Jkv6N68f9LLsgQO7cmDujexg4tXX8DRzZ7nPx?=
 =?us-ascii?Q?wWLcpdy6QqEQw98b+ggLBW/GvyBLu7VA02hfbV9Tj3J0sm8av9PaB5/zcxIl?=
 =?us-ascii?Q?JtYtgndD3oHppbwoJ2E4Bnb0yTLvzZ6nV76QSNTlOSFkZ0qQCt3dh9fuWkis?=
 =?us-ascii?Q?+0Ru4vrSzaHbt311NkPkO8FB4eDpuB8QweZcbdAOK8yncOgsd9lmttQUFCTj?=
 =?us-ascii?Q?336NPlFkdieehmB2emPXnCKuhMBwUCxZYzuc1JSb7R+VS1jZxoS1fV+uMpHB?=
 =?us-ascii?Q?Gn02l795pUf99GWwDBdiV3hab8bTwJBigBVs6CkbUTPEoHtU8JOzEDoqeISN?=
 =?us-ascii?Q?/V1JDe1GDW50DvGExlorxCW5CAb8Jpuf0LLNXQlBWcI52T7/VgrUTnST9MMN?=
 =?us-ascii?Q?LCWGimo5m4JWDpLdStbwgCtfrv0kgTOqQkyB6m0S30fzyi3F6zHking704SY?=
 =?us-ascii?Q?2vsyOIDoGX+B3Km6XPmGxN/E5c0Uo4nOgqMO3sN7wEoFBi2nz2Rq7tE8MCwL?=
 =?us-ascii?Q?PuuGXsEA15mBBIL1PvWgiUzEjkFNRxSVgDY1Pb+AAJMAZwFHZvKpFn0BMnYv?=
 =?us-ascii?Q?YyqQSGa1KlTmYJyKmYn6fke1/j7vie8teGlB4Ie0LC/rmLrlxXY2bRKtA9O0?=
 =?us-ascii?Q?2FvQQfzyhFgYzeRq656SZSUdesbCh+OjFjOghPSnJzQj08kdXz/U0A95ssxX?=
 =?us-ascii?Q?SWenSWZLMhuIXZnMtRYx+NNBGsDj9or4NFLEZg4/DVUAT+RNiG2KYp6j9VSz?=
 =?us-ascii?Q?ecu4tAxe03ZsizFg+ddqSZM25MGD3KQxbWwRV+gtQu58EHhSfeHa5pJbdzxl?=
 =?us-ascii?Q?dos19iXSrThx5+ur4LR82LUgOgXB7O+7PUyINexhGh6Rb+qYei/XKwoLWSFW?=
 =?us-ascii?Q?LBLfGa2pN9DmzDqn+XvrLhD5j+cAMpnWYPyAyytSWxE+Yr5tAnzUCNVHzYtS?=
 =?us-ascii?Q?fLJbmVts/v9s+80TurvAcUCQhXM=3D?=
X-OriginatorOrg: windriver.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b86c9794-d6d8-4d94-aadc-08d9eb22c0ea
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB4545.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 16:47:55.0467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ddb2873-a1ad-4a18-ae4e-4644631433be
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgJrvRMgszPg5G1oZ5F7NTHfLgXwvxDhQYE5GkMRx2h3f5hDTp8DYt6uhkszN5dc3+vc1UElj+FYV4YITpSN44JPblSSaWS6pzzz5st0LOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5552
X-Proofpoint-GUID: 9PAWTvltCeYC9mTqQsc5570nEFLfDExH
X-Proofpoint-ORIG-GUID: 9PAWTvltCeYC9mTqQsc5570nEFLfDExH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_05,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 clxscore=1011 suspectscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 impostorscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202080101
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The isolation flags [some/all?] are someday going to be exposed via cgroups.
Frederic has a series out for review now that moves us closer to doing that:

https://lore.kernel.org/all/20220207155910.527133-1-frederic@kernel.org/

They will be user exposed tuning knobs and no longer just hidden away in
source with a subset linked to boot args used by a small set of people.

As such, we'll need clear user-facing descriptions of each, and specifics of
what they control/alter.  Which was the initial thought that got me here.

When the 1st group of flags was introduced (2017) they were split at a fine
grained level, leaving the door open to re-merge some flags later if natural
groupings arose. (see de201559df8 log)

Prior to the elevated userspace exposure they'll get via cgroups (and via
adding a Documentation/isolation.rst or similar) it probably makes sense
to revisit possible flag merges now, before they become cemented into API
and thus essentially leave us stuck with the choices forever.

Open questions:
-should HK_FLAG_SCHED be squashed into HK_FLAG_MISC ?  It isnt set and the
 name can be misleading to new users, in that it "sounds like" the main
 isolation flag (vs the "real" one which is essentially !HK_FLAG_DOMAIN)

-should HK_FLAG_RCU be squashed into ... ?  HK_FLAG_MISC ?  It is only used
 for rcu_online/offline of a CPU and the name might inadvertently suggest
 that it is somehow related to rcu_nocbs= (when it isn't).

-do we need HK_FLAG_WQ ?  Currently always or'd with DOMAIN.  Or should we
 change to select from WQ and then fall back to DOMAIN iff WQ set is empty?

To better address this, and answer "how did we get here, and who is using
what flags and where currently" I found myself making some notes to gather
all that kind of information in one place.

So what follows below are my rough notes on the housekeeping flags - a
combination of snippets of source, and commit references etc.  Maybe it
provides others a shortcut to the overall picture w/o duplicating the work.

From here, hopefully we can decide if we are OK with the flags as they are,
and I can take what remains and try and address the documentation I think
we'll need, as per what I outlined at the top.

Paul.

			======================

Current (5.17) Housekeeping Flag Set:
-------------------------------------

de201559df872 (Frederic Weisbecker 2017-10-27  8) enum hk_flags {
de201559df872 (Frederic Weisbecker 2017-10-27  9)        HK_FLAG_TIMER           = 1,
de201559df872 (Frederic Weisbecker 2017-10-27 10)        HK_FLAG_RCU             = (1 << 1),
de201559df872 (Frederic Weisbecker 2017-10-27 11)        HK_FLAG_MISC            = (1 << 2),
de201559df872 (Frederic Weisbecker 2017-10-27 12)        HK_FLAG_SCHED           = (1 << 3),
6f1982fedd598 (Frederic Weisbecker 2017-10-27 13)        HK_FLAG_TICK            = (1 << 4),
edb9382175c3e (Frederic Weisbecker 2017-10-27 14)        HK_FLAG_DOMAIN          = (1 << 5),
1bda3f8087fce (Frederic Weisbecker 2018-02-21 15)        HK_FLAG_WQ              = (1 << 6),
11ea68f553e24 (Ming Lei            2020-01-20 16)        HK_FLAG_MANAGED_IRQ     = (1 << 7),
9cc5b8656892a (Marcelo Tosatti     2020-05-27 17)        HK_FLAG_KTHREAD         = (1 << 8),
de201559df872 (Frederic Weisbecker 2017-10-27 18) };

Note that we currently don't set any "default" flags.  Assignment only happens
via use of isolcpus= and/or nohz_full= bootargs.

Further, the "default" tries to skip all housekeeping flags considerations
entirely via the static key "housekeeping_overridden" used by all the various
housekeeping_cpu() type query functions.


1st split:
-----------
commit de201559df872f83d0c08fb4effe3efd28e6cbc8
Author: Frederic Weisbecker <frederic@kernel.org>
Date:   Fri Oct 27 04:42:35 2017 +0200

    sched/isolation: Introduce housekeeping flags
    
    Before we implement isolcpus under housekeeping, we need the isolation
    features to be more finegrained. For example some people want NOHZ_FULL
    without the full scheduler isolation, others want full scheduler
    isolation without NOHZ_FULL.
    
    So let's cut all these isolation features piecewise, at the risk of
    overcutting it right now. We can still merge some flags later if they
    always make sense together.

+enum hk_flags {
+       HK_FLAG_TIMER           = 1,
+       HK_FLAG_RCU             = (1 << 1),
+       HK_FLAG_MISC            = (1 << 2),
+       HK_FLAG_SCHED           = (1 << 3),
+};


TICK and DOMAIN appears (same time):
------------------------------------
commit 6f1982fedd59856bcc42a9b521be4c3ffd2f60a7
Author: Frederic Weisbecker <frederic@kernel.org>
Date:   Fri Oct 27 04:42:36 2017 +0200

    sched/isolation: Handle the nohz_full= parameter
    
    We want to centralize the isolation management, done by the housekeeping
    subsystem. Therefore we need to handle the nohz_full= parameter from
    there.
    
    Since nohz_full= so far has involved unbound timers, watchdog, RCU
    and tilegx NAPI isolation, we keep that default behaviour.
    
    nohz_full= will be deprecated in the future. We want to control
    the isolation features from the isolcpus= parameter.

        HK_FLAG_SCHED           = (1 << 3),
+       HK_FLAG_TICK            = (1 << 4),
 };

commit edb9382175c3ebdced8ffdb3e0f20052ad9fdbe9
Author: Frederic Weisbecker <frederic@kernel.org>
Date:   Fri Oct 27 04:42:37 2017 +0200

    sched/isolation: Move isolcpus= handling to the housekeeping code

    We want to centralize the isolation features, to be done by the housekeeping
    subsystem and scheduler domain isolation is a significant part of it.
    
    No intended behaviour change, we just reuse the housekeeping cpumask
    and core code.

        HK_FLAG_TICK            = (1 << 4),
+       HK_FLAG_DOMAIN          = (1 << 5),
 };


Current (5.17) housekeeping NOHZ_FULL Base Flags:
-------------------------------------------------

static int __init housekeeping_nohz_full_setup(char *str)
{
        unsigned int flags;

        flags = HK_FLAG_TICK | HK_FLAG_WQ | HK_FLAG_TIMER | HK_FLAG_RCU |
                HK_FLAG_MISC | HK_FLAG_KTHREAD;

        return housekeeping_setup(str, flags);
}
__setup("nohz_full=", housekeeping_nohz_full_setup);

[Note: SCHED not in above, but probably should be? (see discussion below).]


Individual Flags accesible via isolcpus= (currently):
-----------------------------------------------------

static int __init housekeeping_isolcpus_setup(char *str)
{
                if (!strncmp(str, "nohz,", 5)) {
                        flags |= HK_FLAG_TICK;

                if (!strncmp(str, "domain,", 7)) {
                        flags |= HK_FLAG_DOMAIN;

                if (!strncmp(str, "managed_irq,", 12)) {
                        flags |= HK_FLAG_MANAGED_IRQ;

        /* Default behaviour for isolcpus without flags */
        if (!flags)
                flags |= HK_FLAG_DOMAIN;

        return housekeeping_setup(str, flags);
}


HK_FLAG_<name> Bit Breakdown and where used:
============================================


DOMAIN: (put 1st so as to not "bury the lead")
------------------------------------------------------------------------------

--if set, this core appears in the scheduler domain hierarchy and is available
  for "normal" use.  See Documentation/scheduler/sched-domains.rst

--can consider this the "main" isolation flag but in inverse; it NOT being set
  dictates what gets printed from /sys/devices/system/cpu/isolated

drivers/base/cpu.c
static ssize_t print_cpus_isolated(struct device *dev,
                                  struct device_attribute *attr, char *buf)
{
        cpumask_var_t isolated;

        cpumask_andnot(isolated, cpu_possible_mask,
                       housekeeping_cpumask(HK_FLAG_DOMAIN));
        len = sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(isolated));

--init is moved to domain (housekeeping) core here:
kernel/sched/core.c
        /* Move init over to a non-isolated CPU */
        if (set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_FLAG_DOMAIN)) < 0)
                BUG();

--cgroups only allows stuff on CPUs with it set
kernel/cgroup/cpuset.c
                cpumask_and(doms[0], top_cpuset.effective_cpus,
                            housekeeping_cpumask(HK_FLAG_DOMAIN));

--asymmetry scan only covers DOMAIN CPUs
kernel/sched/topology.c
        for_each_cpu_and(cpu, cpu_possible_mask, housekeeping_cpumask(HK_FLAG_DOMAIN))
                asym_cpu_capacity_update_data(cpu);

--workqueue only on DOMAIN (or dedicated WQ CPUs).
kernel/workqueue.c
void __init workqueue_init_early(void)
{
        int hk_flags = HK_FLAG_DOMAIN | HK_FLAG_WQ;

        cpumask_copy(wq_unbound_cpumask, housekeeping_cpumask(hk_flags));

...and see other DOMAIN | WQ instances below


SCHED:
------------------------------------------------------------------------------

--note: intention seems to have been scheduler *housekeeping* (idle rebalance
  etc) and should NOT be interpreted as "please schedule stuff here".

Note wrt. SCHED vs. MISC:
 * idle load balancing details
 * - When one of the busy CPUs notice that there may be an idle rebalancing
 *   needed, they will kick the idle load balancer, which then does idle
 *   load balancing for all the idle CPUs.
 * - HK_FLAG_MISC CPUs are used for this task, because HK_FLAG_SCHED not set
 *   anywhere yet.

...and even though SCHED isn't set, we do have tests for it:

void nohz_balance_enter_idle(int cpu)
{
        /* Spare idle load balancing on CPUs that don't want to be disturbed: */
        if (!housekeeping_cpu(cpu, HK_FLAG_SCHED))
                return;


static void nohz_newidle_balance(struct rq *this_rq)
{
        if (!housekeeping_cpu(this_cpu, HK_FLAG_SCHED))
                return;

See also:
	https://lore.kernel.org/all/20200401121342.930480720@redhat.com/

...which actually sets SCHED in default nohz_full mask,  but was never merged.


WQ:
------------------------------------------------------------------------------

--workqueus: note that it is always used *currently* as:
        int hk_flags = HK_FLAG_DOMAIN | HK_FLAG_WQ;
  FW is splitting the assignment in two, but that doesn't change the
  fact they have been always used OR'd together and still will be.

commit 1bda3f8087fce9063da0b8aef87f17a3fe541aca
Author: Frederic Weisbecker <frederic@kernel.org>
Date:   Wed Feb 21 05:17:26 2018 +0100
    sched/isolation: Isolate workqueues when "nohz_full=" is set

kernel/workqueue.c
void __init workqueue_init_early(void)
{
        int hk_flags = HK_FLAG_DOMAIN | HK_FLAG_WQ;

        cpumask_copy(wq_unbound_cpumask, housekeeping_cpumask(hk_flags));

                --------------------------------------

--networking and Rx pkt steering (see desc in commit log)
commit 0a9627f2649a02bea165cfd529d7bcb625c2fcad
Author: Tom Herbert <therbert@google.com>
Date:   Tue Mar 16 08:03:29 2010 +0000
    rps: Receive Packet Steering

...went ~10y before being limited to housekeeping CPUs

commit 07bbecb3410617816a99e76a2df7576507a0c8ad
Author: Alex Belits <abelits@marvell.com>
Date:   Thu Jun 25 18:34:43 2020 -0400
    net: Restrict receive packets queuing to housekeeping CPUs

net/core/net-sysfs.c
static ssize_t store_rps_map(struct netdev_rx_queue *queue,
		[...]
        if (!cpumask_empty(mask)) {
                hk_flags = HK_FLAG_DOMAIN | HK_FLAG_WQ;
                cpumask_and(mask, mask, housekeeping_cpumask(hk_flags));
                if (cpumask_empty(mask)) {
                        free_cpumask_var(mask);
                        return -EINVAL;

                --------------------------------------

--directing PCI probes and subsequent resources they allocate/set-up.
commit 69a18b18699b59654333651d95f8ca09d01048f8
Author: Alex Belits <abelits@marvell.com>
Date:   Thu Jun 25 18:34:42 2020 -0400

    PCI: Restrict probe functions to housekeeping CPUs

drivers/pci/pci-driver.c
static int pci_call_probe(struct pci_driver *drv, struct pci_dev *dev,
		[...]
        int hk_flags = HK_FLAG_DOMAIN | HK_FLAG_WQ;

         * Prevent nesting work_on_cpu() for the case where a Virtual Function
         * device is probed from work_on_cpu() of the Physical device.

        if (node < 0 || node >= MAX_NUMNODES || !node_online(node) ||
            pci_physfn_is_probed(dev))
                cpu = nr_cpu_ids;
        else
                cpu = cpumask_any_and(cpumask_of_node(node),
                                      housekeeping_cpumask(hk_flags));

        if (cpu < nr_cpu_ids)
                error = work_on_cpu(cpu, local_pci_probe, &ddi);
        else
                error = local_pci_probe(&ddi);


MISC:
------------------------------------------------------------------------------

--idle load balance; note comment - would have used SCHED if it could have

  commit 9b019acb72e4b5741d88e8936d6f200ed44b66b2
  Author: Nicholas Piggin <npiggin@gmail.com>
  Date:   Fri Apr 12 14:26:13 2019 +1000

    sched/nohz: Run NOHZ idle load balancer on HK_FLAG_MISC CPUs

kernel/sched/fair.c
 * - HK_FLAG_MISC CPUs are used for this task, because HK_FLAG_SCHED not set
 *   anywhere yet.
static inline int find_new_ilb(void)
{
        int ilb;
        const struct cpumask *hk_mask;

        hk_mask = housekeeping_cpumask(HK_FLAG_MISC);

        for_each_cpu_and(ilb, nohz.idle_cpus_mask, hk_mask) {

--blocking core frequency probe requests from !MISC cores
arch/x86/kernel/cpu/aperfmperf.c
   commit cc9e303c91f5c25c49a4312552841f4c23fa2b69
   Author: Konstantin Khlebnikov <koct9i@gmail.com>
   Date:   Wed May 15 09:59:00 2019 +0300

    x86/cpu: Disable frequency requests via aperfmperf IPI for nohz_full CPUs

@@ -85,6 +86,9 @@ unsigned int aperfmperf_get_khz(int cpu)
 
+       if (!housekeeping_cpu(cpu, HK_FLAG_MISC))
+               return 0;

@@ -101,9 +105,12 @@ void arch_freq_prepare_all(void)
 
-       for_each_online_cpu(cpu)
+       for_each_online_cpu(cpu) {
+               if (!housekeeping_cpu(cpu, HK_FLAG_MISC))
+                       continue;
                if (!aperfmperf_snapshot_cpu(cpu, now, false))


RCU:
------------------------------------------------------------------------------

--currently only on path of CPU add/remove ops
kernel/rcu/tree_plugin.h
 * We don't include outgoingcpu in the affinity set, use -1 if there is
 * no outgoing CPU.  If there are no CPUs left in the affinity set,
 * this function allows the kthread to execute on any CPU.
static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
{
        struct task_struct *t = rnp->boost_kthread_task;
        unsigned long mask = rcu_rnp_online_cpus(rnp);
        cpumask_var_t cm;
        int cpu;

        if (!t)
                return;
        if (!zalloc_cpumask_var(&cm, GFP_KERNEL))
                return;
        for_each_leaf_node_possible_cpu(rnp, cpu)
                if ((mask & leaf_node_cpu_bit(rnp, cpu)) &&
                    cpu != outgoingcpu)
                        cpumask_set_cpu(cpu, cm);
        cpumask_and(cm, cm, housekeeping_cpumask(HK_FLAG_RCU));
        if (cpumask_weight(cm) == 0)
                cpumask_copy(cm, housekeeping_cpumask(HK_FLAG_RCU));
        set_cpus_allowed_ptr(t, cm);
        free_cpumask_var(cm);
}
                    ------ rcu_boost_kthread_setaffinity -----

 * The CPU has been completely removed, and some other CPU is reporting
 * this fact from process context.  Do the remainder of the cleanup.
 * There can only be one CPU hotplug operation at a time, so no need for
 * explicit locking.
int rcutree_dead_cpu(unsigned int cpu)
{
        struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
        struct rcu_node *rnp = rdp->mynode;  /* Outgoing CPU's rdp & rnp. */

        if (!IS_ENABLED(CONFIG_HOTPLUG_CPU))
                return 0;

        WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus - 1);
        /* Adjust any no-longer-needed kthreads. */
        rcu_boost_kthread_setaffinity(rnp, -1);

                    -----------------------------------------

 * Update RCU priority boot kthread affinity for CPU-hotplug changes.
static void rcutree_affinity_setting(unsigned int cpu, int outgoing)
{
        struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);

        rcu_boost_kthread_setaffinity(rdp->mynode, outgoing);
}

 * Near the end of the CPU-online process.  Pretty much all services
 * enabled, and the CPU is now very much alive.
int rcutree_online_cpu(unsigned int cpu)
{
		...
        rcutree_affinity_setting(cpu, -1);

 * Near the beginning of the process.  The CPU is still very much alive
 * with pretty much all services enabled.
int rcutree_offline_cpu(unsigned int cpu)
{
		...
        rcutree_affinity_setting(cpu, cpu);

                    -----------------------------------------

MANAGED_IRQ
------------------------------------------------------------------------------

--avoid (not prevent) IRQ traffic landing on isolated cores

commit 11ea68f553e244851d15793a7fa33a97c46d8271
Author: Ming Lei <ming.lei@redhat.com>
Date:   Mon Jan 20 17:16:25 2020 +0800
    genirq, sched/isolation: Isolate from handling managed interrupts
    
    The affinity of managed interrupts is completely handled in the kernel and
    cannot be changed via the /proc/irq/* interfaces from user space. [...]

kernel/irq/cpuhotplug.c
static bool hk_should_isolate(struct irq_data *data, unsigned int cpu)
{
        const struct cpumask *hk_mask;

        if (!housekeeping_enabled(HK_FLAG_MANAGED_IRQ))
                return false;

                --------------------------------------

kernel/irq/manage.c
int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,

        /*
         * If this is a managed interrupt and housekeeping is enabled on
         * it check whether the requested affinity mask intersects with
         * a housekeeping CPU. If so, then remove the isolated CPUs from
         * the mask and just keep the housekeeping CPU(s). This prevents
         * the affinity setter from routing the interrupt to an isolated
         * CPU to avoid that I/O submitted from a housekeeping CPU causes
         * interrupts on an isolated one.
         *
         * If the masks do not intersect or include online CPU(s) then
         * keep the requested mask. The isolated target CPUs are only
         * receiving interrupts when the I/O operation was submitted
         * directly from them.
         *
         * If all housekeeping CPUs in the affinity mask are offline, the
         * interrupt will be migrated by the CPU hotplug code once a
         * housekeeping CPU which belongs to the affinity mask comes
         * online.
         */


KTHREAD
------------------------------------------------------------------------------

commit 9cc5b8656892a72438ee7deb5e80f5be47643b8b
Author: Marcelo Tosatti <mtosatti@redhat.com>
Date:   Wed May 27 16:29:09 2020 +0200
    isolcpus: Affine unbound kernel threads to housekeeping cpus

    This is a kernel enhancement that configures the cpu affinity of kernel
    threads via kernel boot option nohz_full=.
    
    When this option is specified, the cpumask is immediately applied upon
    kthread launch. This does not affect kernel threads that specify cpu
    and node.
    
    This allows CPU isolation (that is not allowing certain threads
    to execute on certain CPUs) without using the isolcpus=domain parameter,
    making it possible to enable load balancing on such CPUs
    during runtime (see kernel-parameters.txt).

kernel/kthread.c
static int kthread(void *_create)
{
        /*
         * The new thread inherited kthreadd's priority and CPU mask. Reset
         * back to default in case they have been changed.
         */
        sched_setscheduler_nocheck(current, SCHED_NORMAL, &param);
        set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_FLAG_KTHREAD));
`
int kthreadd(void *unused)
{
        /* Setup a clean context for our children to inherit. */
        set_task_comm(tsk, "kthreadd");
        ignore_signals(tsk);
        set_cpus_allowed_ptr(tsk, housekeeping_cpumask(HK_FLAG_KTHREAD));


TICK:
------------------------------------------------------------------------------

--triggers scheduler tick offload at boot:
kernel/sched/isolation.c
void __init housekeeping_init(void)
{
        if (!housekeeping_flags)
                return;

        static_branch_enable(&housekeeping_overridden);

        if (housekeeping_flags & HK_FLAG_TICK)
                sched_tick_offload_init();

        /* We need at least one CPU to handle housekeeping work */
        WARN_ON_ONCE(cpumask_empty(housekeeping_mask));
}

--assumes tick is already on and never turned off for TICK cores.
kernel/sched/core.c
static void sched_tick_start(int cpu)
{
        int os;
        struct tick_work *twork;

        if (housekeeping_cpu(cpu, HK_FLAG_TICK))
                return;

	---------------

#ifdef CONFIG_HOTPLUG_CPU
static void sched_tick_stop(int cpu)
{
        struct tick_work *twork;
        int os;

        if (housekeeping_cpu(cpu, HK_FLAG_TICK))
                return;


TIMER:
-------------------------------------------------------------------------

arch/x86/kvm/x86.c
  8710) int kvm_arch_init(void *opaque)

  8771)    if (pi_inject_timer == -1)
  8772)            pi_inject_timer = housekeeping_enabled(HK_FLAG_TIMER);


kernel/cpu.c
 1484) int freeze_secondary_cpus(int primary)
 1485) {
 1489)        if (primary == -1) {
 1490)                primary = cpumask_first(cpu_online_mask);
 1491)                if (!housekeeping_cpu(primary, HK_FLAG_TIMER))
 1492)                        primary = housekeeping_any_cpu(HK_FLAG_TIMER);
 1493)        } else {

--timers and timer migration:
kernel/sched/core.c
  1021) int get_nohz_timer_target(void)       <------- users below
  1022) {
  1023)  int i, cpu = smp_processor_id(), default_cpu = -1;

  1027)  if (housekeeping_cpu(cpu, HK_FLAG_TIMER)) {
  1028)          if (!idle_cpu(cpu))
  1029)                  return cpu;
  1030)          default_cpu = cpu;
  1031)  }
  1032) 
  1033)  hk_mask = housekeeping_cpumask(HK_FLAG_TIMER);

  1048)  if (default_cpu == -1)
  1049)          default_cpu = housekeeping_any_cpu(HK_FLAG_TIMER);

            ----- get_nohz_timer_target -----
kernel/time/timer.c
static inline struct timer_base *
get_target_base(struct timer_base *base, unsigned tflags)
{
#if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
        if (static_branch_likely(&timers_migration_enabled) &&
            !(tflags & TIMER_PINNED))
                return get_timer_cpu_base(tflags, get_nohz_timer_target());
                                                  ^^^^^^^^^^^^^^^^^^^^^
#endif
        return get_timer_this_cpu_base(tflags);
}

__mod_timer(struct timer_list *timer, unsigned long expires, unsigned int options)
{
		[....]
        new_base = get_target_base(base, timer->flags);
                   ^^^^^^^^^^^^^^^

        if (base != new_base) {
                [ ... ]

            -------------------------------

kernel/time/hrtimer.c
static inline
struct hrtimer_cpu_base *get_target_base(struct hrtimer_cpu_base *base,
                                         int pinned)
{
#if defined(CONFIG_SMP) && defined(CONFIG_NO_HZ_COMMON)
        if (static_branch_likely(&timers_migration_enabled) && !pinned)
                return &per_cpu(hrtimer_bases, get_nohz_timer_target());
                                               ^^^^^^^^^^^^^^^^^^^^^
#endif
        return base;
}

static inline struct hrtimer_clock_base *
switch_hrtimer_base(struct hrtimer *timer, struct hrtimer_clock_base *base,
                    int pinned)
{
        struct hrtimer_cpu_base *new_cpu_base, *this_cpu_base;
        struct hrtimer_clock_base *new_base;
        int basenum = base->index;

        this_cpu_base = this_cpu_ptr(&hrtimer_bases);
        new_cpu_base = get_target_base(this_cpu_base, pinned);
                       ^^^^^^^^^^^^^^^
again:
        new_base = &new_cpu_base->clock_base[basenum];

        if (base != new_base) {
                [ ... ]

            -------------------------------

For influence of housekeeping on get_nohz_timer_target() see also 
commit 9642d18eee2cd169b60c6ac0f20bda745b5a3d1e
Author: Vatika Harlalka <vatikaharlalka@gmail.com>
Date:   Tue Sep 1 16:50:59 2015 +0200
    nohz: Affine unpinned timers to housekeepers

            -------------------------------

kernel/watchdog.c

commit 314b08ff5205420d956d14657e16d92c460a6f21
Author: Frederic Weisbecker <fweisbec@gmail.com>
Date:   Fri Sep 4 15:45:09 2015 -0700
    watchdog: simplify housekeeping affinity with the appropriate mask

 845) void __init lockup_detector_init(void)
 846) {
 847)         if (tick_nohz_full_enabled())
 848)                 pr_info("Disabling watchdog on nohz_full cores by default\n");
 849) 
 850)         cpumask_copy(&watchdog_cpumask,
 851)                      housekeeping_cpumask(HK_FLAG_TIMER));

                ------------- end ----------------
