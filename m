Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B066D50F167
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240301AbiDZGsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbiDZGrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:47:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8E71DA57;
        Mon, 25 Apr 2022 23:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650955489; x=1682491489;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=LwWFxR7ChckbDfK1+VW+/PZ21x/hSmcf6y2F7M2+ZsM=;
  b=bkg+EbPcvkd9LTqd4OKip4eWWoNlYr5ln9M+9j5w+nR8Eifkrxam2iUX
   tSCE6TKy07NbPUcVm1ZY4Cnz7rj1LDVYK2sGeJ5hCzy/U3Ow5BrlZYi6C
   Ads2jghLED8oiTH4GoVdj0lnAZ+Bij+4eBQO5zncQW1OVlmO244TC+rT/
   zSNn52eRqb4m15MQzm4JUxhRPDx7z3iM0ibSz6fMXU89gHXG3XK71/rKq
   NBQ0PDWAI7kEmeGNLrtG/KAT4OhLO9ANIAgL9AWWqLmmuGAcCgKq2OOt7
   tNDairbkxG7/t2eIR9b+rQX6je9pGmegsbIwpbVdljfDIVsmtjcLprAFF
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="264995890"
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="264995890"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 23:44:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,290,1643702400"; 
   d="scan'208";a="678226578"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga004.jf.intel.com with ESMTP; 25 Apr 2022 23:44:48 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 25 Apr 2022 23:44:48 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 25 Apr 2022 23:44:48 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 25 Apr 2022 23:44:48 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 25 Apr 2022 23:44:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EgXsib/0GoTzspx7D8Ws+97VisUmCj6/1/lpMxJ1V2H6vKPvGRyVO8rTCPUN5pQdgpfAOg08zLGfw7Jdv+YQpygLOqAEZLVNYrDYujUGvTEGLM5atGNrluGPcqMrC+G+9nOAkP8odV02DvvuJtiZjiKUPaa8G5eJBJdPiDF8b+P2eJgqr7p+/skYDMFIvJx5ShrDVuNgc4fQU90+/is9ZgbUk+cEbnRxpO6hnX7pdesE1k5x7YOzLRwVmlyVn32BsA+PrZXnPeuDKFQfVO2CHLjAYrZUJh8SZ3gpX/FmoC3mUcszaTB4u7rx9Jk0nCaf3uBUCKDTaUhKRujav4v34A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A7aUkcxic3o0wQ13jNp28Hyohv1XKLuYDMKnc1bWrWk=;
 b=Wmy78cNKck958/jnJdaE3/95nDYzCs7aIiR7ScTpaVrQeXr26ZUuijpGZYOr4CpoIW8/UYT2WrtXdM43BTwcjJ47CSdJTkj7+4F0Xrs5ePYWAQl+vQbAilgZnSHowX/cb5AKoNLc5tXvfpmJfipofnju29JsdIsjz/jwJzDhVPrQSaIwyYUrW2CO4gsOSwulYXxDCdFlcRiVVwZiXpVr8zDE/7PLTg4vnT6m1SmiUy9KLq8cW6mPQ52hU5GcJ/KIjxroca2CSjJF+u8BR3qJivwJk2W4YWAhHdcCejSV9REmJPWg9MQsWSTdGxdggg9Y7aBApk6WVVT8m82XkozWRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by CY4PR11MB1992.namprd11.prod.outlook.com (2603:10b6:903:2f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Tue, 26 Apr
 2022 06:44:46 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::c579:f1c1:28b3:610f]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::c579:f1c1:28b3:610f%8]) with mapi id 15.20.5186.021; Tue, 26 Apr 2022
 06:44:46 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] rcu: Dump all rcuc kthreads status for CPUs that not
 report quiescent state
Thread-Topic: [PATCH v4] rcu: Dump all rcuc kthreads status for CPUs that not
 report quiescent state
Thread-Index: AQHYWEB6oQO0A/rD6EKnXzafiZz6Ja0Axn6AgAD56rA=
Date:   Tue, 26 Apr 2022 06:44:46 +0000
Message-ID: <PH0PR11MB5880A72D33DCB9CDC22DED19DAFB9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220425010404.3249118-1-qiang1.zhang@intel.com>
 <20220425154533.GT4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220425154533.GT4285@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.401.20
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2d543c10-26ac-4c16-c28d-08da275040af
x-ms-traffictypediagnostic: CY4PR11MB1992:EE_
x-microsoft-antispam-prvs: <CY4PR11MB1992982CE7EEF5F3B5E032A2DAFB9@CY4PR11MB1992.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: d+12QkUOrqhiRSZIePxZXWYn7l5q/ZqHvqILsoKHrNqEsrW3mnW/mPfMv6yLCzkZHSkWc5hsL4pQgNF3LY/SDUYSnykPc/TO0HosxD9dOohGsyI3L7ItfPmtb85l6RCTlVv3XdWedwsqumaDFvBJnuH8a+QDaap+2Mj2w4gZ0HsH3Vc+Ngwb2V15rOFwBrUUbvi+jHXddafhYhcO1S+wbDKN3Q7aIjequFkUnlqz0SDS1VNre0T2/336quTuuwn5W1HrbyH3c0SWCC2C5BVuAoLTUO0my4Z+TfvSsxl3ExiDhnMltOxarj2JACp7dWFkxmZrNY1MR1vcS8R8EfSmmNmeRJgqHIeWHT0Sg61gXF6aFHefR1WAEhhY7VVnRyuTz71juZXtBzBUUyYmaJ3dx4I/dIk+gQeQ5SlnENLo5MFAGRtxbIj14IjbHn7sMEyjVb7yjxOiyR9XkN2RkGvzm7vjmVppzALZB9nvyYQg7RZMsJdzRvssJNtOgqe+cJvYz2LyBSRpIH4xwfTGxleSn2X/iLTJPygYgdl98eImBCCRfcy7awr5OD3qSZw7p8hBU/O4Z+iVnPlI0ZRN6iRDpastQyNbo5H+MrNGUAO7IzbMyrZPDW8wWQXV7zGfY5rVNIlR0fZqWrh9sQuKszcN5fdHrDDH2VrihOb/GASYlJBSeF6x3FSsUgNfhti//JzXQu9wb0LriNc75u0ciFY9mNx2uvWsKA6qIxJcUR4PISuE9E/jpVkSTLBudlBDA9tFoOsCxeun1Evmf2c5mRBHLz7AESn2fmiMa1Zg0klMxwc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(66574015)(38070700005)(508600001)(6506007)(7696005)(6916009)(86362001)(186003)(9686003)(38100700002)(52536014)(8936002)(4326008)(8676002)(55016003)(33656002)(2906002)(5660300002)(66476007)(76116006)(82960400001)(66556008)(66446008)(64756008)(66946007)(26005)(316002)(71200400001)(54906003)(966005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?XqzMK2ZRp5d15FA1JMgaOJqbLtzq8Cj6PM8Z9Q7DCjkBR1O/iPKVZLp2id5F?=
 =?us-ascii?Q?2YAr76dbJBkOxBY0bMoRbX5TpJCkPr73DedEt8aVkgk6hr1Rid4J9utJQ6rH?=
 =?us-ascii?Q?EYNEtBRRx4ZKe8X2ciNZ6iNTP9Jlw7jkLSiWrBk3LFlzfaosqPtPvGEiXi/q?=
 =?us-ascii?Q?fQkbq5V3pRq7UQWVK2QV2MY6euNlMFRfYeNf0L3aEPjbEC/6lGuguhg0ivYk?=
 =?us-ascii?Q?xVHYtQU6cdGdcvAU4Hp2NQG/MUSzytCBHpiX6ThnnG3yppiqfmNrONqSMgpn?=
 =?us-ascii?Q?Rv3Ff+9fazQcINsHZ9IXPXFtUkOn1EU7yJ/YF3B9V9nR27YAfqAPKcKn8acF?=
 =?us-ascii?Q?9cNhGP/sAIYuzhP8dyDRafl/XbHSwFSVw+Q09pOsGDRSV9usnqIJ2iUoi+Ke?=
 =?us-ascii?Q?Vp+ydGkVC/pqGE18btx4pOowCiJHEBgImoj8FH2MZh7XzE2vChEUPwOc4QqL?=
 =?us-ascii?Q?Gk9M/mZ77J0xaXlPvkllntnIpFmUlsPAEc8xL0ivzKccEWtUwKqjSb2forpx?=
 =?us-ascii?Q?ZPI4Tk/N0J3JXYqiu+wQr3EDPDNA/se9F/qARDK6i5vShQgfqSiDh4Hn1aun?=
 =?us-ascii?Q?XHwVKovcpM89ObzPkGsF5+DLszYnVpQQsLInYr6c8wiitOAfbaD72hCkkiTW?=
 =?us-ascii?Q?Vr7uuGTcnss35eFRb4MUp3/B5ONI0vNbmaHd7gNa924LkGHQZQERoyMxONS8?=
 =?us-ascii?Q?AgRW1eswmojZI1KZ/6lqDe2eDhho7r56ZWOthTyojXHGM3oJmN2B+HgG87Wj?=
 =?us-ascii?Q?xS88eE4PPFf0FB3hom4xIdoTm+KHexO7ZkbWN0KsoLfIcDPdCkv88/HhSmx6?=
 =?us-ascii?Q?xYvGhOTW2tTBACnU+vaSweivh1CQn4pa8zcA3gBb2c0Vs+BPxf/UeBR3wTRU?=
 =?us-ascii?Q?8fxkAI7G2ZWDBBvEunwhnpN3cVOgxUJQHPWYy8ak1nBfPVlWxTGNhFkHQD7i?=
 =?us-ascii?Q?FILdUBoJzr4u33dCIwRVoncc97R9NooTSV1sL4hmm0/hzcA/ONm6cTq3SgZt?=
 =?us-ascii?Q?bFngKX0vD782YVTSTNyKCGOSbSQ9lavUQNCSy2ChRUyRH2H3b7XyqoAakzbd?=
 =?us-ascii?Q?Jfpz1XnVVVTvCEJTMzfr5gAe8zikw4egr7xoC+a7mW6YurxPHChVRtv6U4CH?=
 =?us-ascii?Q?8vgTpUm6d0qQXTGq2StavpwTPzoErg5nFodDm1L+iKl6a7+EBAXNhpxGSck5?=
 =?us-ascii?Q?FgEe1qEJ+s5i/Ai+KThh7+PMpRq0IZX1Gh77J+cBCWJY3SGj/VjsE33BYf1D?=
 =?us-ascii?Q?WfRWOXQQu/HLL0SDh9H0VzGO7pLbjvoHyQ9XMKhGdzPGyCEwzpWoV13BScPH?=
 =?us-ascii?Q?kaP0RbhuVpmlv9rVor6HmdQyfSsh/CzT7WFmBGLcMBioYx17lM0Ip1n9sgC2?=
 =?us-ascii?Q?p3M6Ohcvs3Hx/WKF0UaMHHC5zLi1wc65w05Y+Wr6oI3qu6EunDd7oSDZgh6K?=
 =?us-ascii?Q?ksoWnpv1xDbkHW2kPLy8P9ySzfrQlRFqDGIem5OS7f1C1qru+8Jhjr49hu5A?=
 =?us-ascii?Q?2wPsWsr6Cxi0yP/OoxdVExKd21ZInNoHMCGcdE3pq5IRRcqGAfnZ/YesC/q6?=
 =?us-ascii?Q?fCLveqRycrVZc+HTdI+eFTktItj/AWaWChvZs9CQ0T5seHVC4Ql2EWtqsx8n?=
 =?us-ascii?Q?jO2nhZNUqIAuO2oLkQNByQBwambKEgSjAg1cYtLHSGJ8ffeqHfLypTZQvGro?=
 =?us-ascii?Q?XucKef8NZm2xNhkOPjAVBwtgtH/rZ4w3Cu0dDAIiqDc9yziWT6jEFLvfXzYy?=
 =?us-ascii?Q?63bm5jQhow=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d543c10-26ac-4c16-c28d-08da275040af
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Apr 2022 06:44:46.2161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XudiLM3NQSYQq4ebWT3VVDyjZRCAsUVzMg64cx33eB3g1W8GsSM6bj84aqovbOO6QYZ/0SUJUrz0pxduzBgCVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1992
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Apr 25, 2022 at 09:04:04AM +0800, Zqiang wrote:
> If the rcutree.use_softirq is configured, when RCU Stall event=20
> happened, dump status of all rcuc kthreads who due to starvation=20
> prevented grace period ends on CPUs that not report quiescent state.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  v1->v2:
>  rework rcuc_kthread_dump function
>  v2->v3:
>  merge this rcuc-stalled information into print_cpu_stall_info()
>  v3->v4:
>  print rcuc info only when rcuc kthread is starved
>=20
>  kernel/rcu/tree_stall.h | 49=20
> ++++++++++++++++++-----------------------
>  1 file changed, 21 insertions(+), 28 deletions(-)

>I have queued this for testing and further review, thank you!
>
>I did the usual wordsmithing, plus I got rid of a couple of space characte=
rs that are extraneous in the common case (one of yours and one pre-existin=
g instance).
>
>Could you please generate an actual stall of this type?  You might need to=
 add a delay to the rcuc code, but other than that, please see the rcutortu=
re blog series [1] and in particular the post on forcing stall warnings [2]=
.
>
>							Thanx, Paul
>
>[1] https://paulmck.livejournal.com/61432.html
>[2] https://paulmck.livejournal.com/58077.html

I followed the instructions, add " rcutorture.stall_cpu=3D22 rcutorture.fwd=
_progress=3D0"  and
" rcutree.use_softirq=3D0"to bootargs, can trigger  RCU CPU stall warning:

root@qemux86-64:/# dmesg
[   37.556435] rcu: INFO: rcu_preempt self-detected stall on CPU
[   37.556437] rcu:     3-....: (1 GPs behind) idle=3D269/1/0x4000000000000=
000 softirq=3D0/0 fqs=3D5631 rcuc=3D26004 jiffies(starved)
[   37.556440]  (t=3D26000 jiffies g=3D3589 q=3D35403)
[   37.556441] NMI backtrace for cpu 3
[   37.556442] CPU: 3 PID: 117 Comm: rcu_torture_sta Tainted: G            =
 L    5.17.0-yoctodev-standard #16 7fe7533e7466875b0801ac148f921afcf57d38bc
[   37.556443] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel=
-1.15.0-0-g2dd4b9b3f840-prebuilt.qemu.org 04/01/2014
[   37.556444] Call Trace:
[   37.556445]  <IRQ>
[   37.556446]  dump_stack_lvl+0x5b/0x82
[   37.556449]  dump_stack+0x10/0x12
[   37.556451]  nmi_cpu_backtrace.cold+0x32/0x8a
[   37.556452]  ? lapic_can_unplug_cpu+0x80/0x80
[   37.556454]  nmi_trigger_cpumask_backtrace+0xce/0xe0
[   37.556456]  arch_trigger_cpumask_backtrace+0x19/0x20
[   37.556458]  rcu_dump_cpu_stacks+0xcd/0x140
[   37.556460]  rcu_sched_clock_irq.cold+0x7a/0x3ba
[   37.556463]  ? debug_smp_processor_id+0x17/0x20
[   37.556466]  update_process_times+0x9b/0xd0
[   37.556467]  tick_sched_handle.isra.0+0x25/0x50
[   37.556469]  tick_sched_timer+0x79/0x90
[   37.556470]  ? tick_sched_do_timer+0x60/0x60
[   37.556471]  __hrtimer_run_queues+0x1d1/0x4c0
[   37.556473]  hrtimer_interrupt+0x114/0x230
[   37.556475]  ? rcu_read_lock_held_common+0x12/0x50
[   37.556489]  __sysvec_apic_timer_interrupt+0xa4/0x280
[   37.556491]  sysvec_apic_timer_interrupt+0x95/0xc0
[   37.556492]  </IRQ>


Thanks
Zqiang

>
------------------------------------------------------------------------

commit 66226e2acda8b31b60137b1ae71244df68541a01
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Mon Apr 25 09:04:04 2022 +0800

    rcu: Dump all rcuc kthreads status for CPUs that not report quiescent s=
tate
   =20
    If the rcutree.use_softirq kernel boot parameter is disabled, then it i=
s
    possible that a RCU CPU stall is due to the rcuc kthreads being starved=
 of
    CPU time.  There is currently no easy way to infer this from the RCU CP=
U
    stall warning output.  This commit therefore adds a string of the form =
"
    rcuc=3D%ld jiffies(starved)" to a given CPU's output if the correspondi=
ng
    rcuc kthread has been starved for more than two seconds.
   =20
    [ paulmck: Eliminate extraneous space characters. ]
   =20
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h index d7956c=
03edbd4..0a25a4ea6eef8 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -407,7 +407,19 @@ static bool rcu_is_gp_kthread_starving(unsigned long *=
jp)
=20
 static bool rcu_is_rcuc_kthread_starving(struct rcu_data *rdp, unsigned lo=
ng *jp)  {
-	unsigned long j =3D jiffies - READ_ONCE(rdp->rcuc_activity);
+	int cpu;
+	struct task_struct *rcuc;
+	unsigned long j;
+
+	rcuc =3D rdp->rcu_cpu_kthread_task;
+	if (!rcuc)
+		return false;
+
+	cpu =3D task_cpu(rcuc);
+	if (cpu_is_offline(cpu) || idle_cpu(cpu))
+		return false;
+
+	j =3D jiffies - READ_ONCE(rdp->rcuc_activity);
=20
 	if (jp)
 		*jp =3D j;
@@ -432,6 +444,9 @@ static void print_cpu_stall_info(int cpu)
 	struct rcu_data *rdp =3D per_cpu_ptr(&rcu_data, cpu);
 	char *ticks_title;
 	unsigned long ticks_value;
+	bool rcuc_starved;
+	unsigned long j;
+	char buf[32];
=20
 	/*
 	 * We could be printing a lot while holding a spinlock.  Avoid @@ -449,7 =
+464,10 @@ static void print_cpu_stall_info(int cpu)
 	delta =3D rcu_seq_ctr(rdp->mynode->gp_seq - rdp->rcu_iw_gp_seq);
 	falsepositive =3D rcu_is_gp_kthread_starving(NULL) &&
 			rcu_dynticks_in_eqs(rcu_dynticks_snap(rdp));
-	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=3D%03x/%ld/%#lx softirq=3D%u/%u fqs=
=3D%ld %s\n",
+	rcuc_starved =3D rcu_is_rcuc_kthread_starving(rdp, &j);
+	if (rcuc_starved)
+		sprintf(buf, " rcuc=3D%ld jiffies(starved)", j);
+	pr_err("\t%d-%c%c%c%c: (%lu %s) idle=3D%03x/%ld/%#lx softirq=3D%u/%u=20
+fqs=3D%ld%s%s\n",
 	       cpu,
 	       "O."[!!cpu_online(cpu)],
 	       "o."[!!(rdp->grpmask & rdp->mynode->qsmaskinit)], @@ -462,32 +480,=
10 @@ static void print_cpu_stall_info(int cpu)
 	       rdp->dynticks_nesting, rdp->dynticks_nmi_nesting,
 	       rdp->softirq_snap, kstat_softirqs_cpu(RCU_SOFTIRQ, cpu),
 	       data_race(rcu_state.n_force_qs) - rcu_state.n_force_qs_gpstart,
+	       rcuc_starved ? buf : "",
 	       falsepositive ? " (false positive?)" : "");  }
=20
-static void rcuc_kthread_dump(struct rcu_data *rdp) -{
-	int cpu;
-	unsigned long j;
-	struct task_struct *rcuc;
-
-	rcuc =3D rdp->rcu_cpu_kthread_task;
-	if (!rcuc)
-		return;
-
-	cpu =3D task_cpu(rcuc);
-	if (cpu_is_offline(cpu) || idle_cpu(cpu))
-		return;
-
-	if (!rcu_is_rcuc_kthread_starving(rdp, &j))
-		return;
-
-	pr_err("%s kthread starved for %ld jiffies\n", rcuc->comm, j);
-	sched_show_task(rcuc);
-	if (!trigger_single_cpu_backtrace(cpu))
-		dump_cpu_task(cpu);
-}
-
 /* Complain about starvation of grace-period kthread.  */  static void rcu=
_check_gp_kthread_starvation(void)
 {
@@ -659,9 +655,6 @@ static void print_cpu_stall(unsigned long gps)
 	rcu_check_gp_kthread_expired_fqs_timer();
 	rcu_check_gp_kthread_starvation();
=20
-	if (!use_softirq)
-		rcuc_kthread_dump(rdp);
-
 	rcu_dump_cpu_stacks();
=20
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
