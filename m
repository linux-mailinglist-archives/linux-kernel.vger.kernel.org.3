Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912C3503394
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiDPDLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 23:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiDPDLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 23:11:21 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5777D11BD9F;
        Fri, 15 Apr 2022 20:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650078530; x=1681614530;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=YiaphKb0lO7mW7oxpKNUkTrr6L6POZqI3JzP1e6Drio=;
  b=HPi96+oyH7yVfX+OSj5Sy8GKzELTC4EFi9TY7Iq0z5Ocm435SzjBCXTu
   FkzGWpu0mtJZyq6eBcqFTeHwaEDO3MzfEy+QvyeF1RXmx9GkkUOUhey5O
   iD0ZZ4Fc7v/a5jISu9zslKT+6WP8HbRgJbA2b3Ef32ajTHUZPASyCc5iq
   3hfkxetIgtlGurofyPmc1Nag4S0FH729wcBpJyqee12xWvGohpHfWTtr4
   cwvi1JmsI+a7+GNI2aT99HKzEJMabBqzKLcEiE2JwRMTfxNiRoBs/MCXt
   w+eAxBAltrdqF1QOwLMpsqdocM5p4st1WIZEirEfuqpkEh6oyfUc8iQHX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10318"; a="262120161"
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="262120161"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 20:08:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,264,1643702400"; 
   d="scan'208";a="701253197"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 15 Apr 2022 20:08:50 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 15 Apr 2022 20:08:49 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 15 Apr 2022 20:08:49 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 15 Apr 2022 20:08:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OflGow1166Pl57nxOBucF6Tbhncyz+exmJMs5GqWWX/Qmr+2Nkakf9rDdozYzYU+2kcfn1Rwd7Es3tN1RxXYo3oYktT6oe4yO5CRz9m/Ee5pr/8cbU67paJP/UsZ9JnuSft1Fjcwo+xrMUhEvOCakfG3rkF6XfN2oPLctsz/H1mtSsUfAnbkQTpkxMcrAx/pQY+MhZsP/vGt/lU/UKgsA1CSlCWn/7MavxSwwi0d5ApsIy1DevUJWl1ty3YHX65jH0pWuTvqV/2PzWO5C6Y6ytn8RlfrkzsWrSAb7P1/7gicGglU93AduVMQ3Bb/ujyGxms7dkcoe0jpipewOYSxCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FTWD/47fR+xn77kag1P8Cyk3hLAcwkF2RX61+hHgOJU=;
 b=WF8WG8zHNArO2F8byDZwXnv7DyB8t0VpY+VP16mXrqoSU1uuVxFgfN++v+rzY0k5UzoH6ynffmXz8mpyuJ3adCKOcURHwiblk3CvixPY+CBoihenFSpDhhXfbhbMQzqBlAMWaIqvv398761QR5SBhUAaGwYbbcYedok38/pp8JSEm7hunxH2KbSYB8XpVJAwb5lJiYSr7CNPlrbkNzPNSCZKXqKOT/uaUFZexf+dyu3CaB9bAaC+4HcG0x6h9AWzyYQe3OFkEK+Jqmq5iO1EX2W7/9hBtoROgbYGlp3NSQ0xD39naooH0K2VnE7pyPqEEx0uUIXyqJU0Po+C8vgYKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BYAPR11MB3717.namprd11.prod.outlook.com (2603:10b6:a03:b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Sat, 16 Apr
 2022 03:08:47 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::c579:f1c1:28b3:610f]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::c579:f1c1:28b3:610f%9]) with mapi id 15.20.5164.020; Sat, 16 Apr 2022
 03:08:47 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Dump all rcuc kthreads status for CPUs that not
 report quiescent state
Thread-Topic: [PATCH] rcu: Dump all rcuc kthreads status for CPUs that not
 report quiescent state
Thread-Index: AQHYTwpGNYsEpnO3pUOLiRwx3W6tm6zxsXSAgAApSfA=
Date:   Sat, 16 Apr 2022 03:08:47 +0000
Message-ID: <PH0PR11MB5880C3206B4BB782188844BDDAF19@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220413074411.2369623-1-qiang1.zhang@intel.com>
 <20220416002025.GO4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220416002025.GO4285@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: 2b0c47d3-0bb0-4bd9-7f1f-08da1f566cb3
x-ms-traffictypediagnostic: BYAPR11MB3717:EE_
x-microsoft-antispam-prvs: <BYAPR11MB3717402B4903DE6A53CCD56EDAF19@BYAPR11MB3717.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0Wh6BsqFofQ1sIoAETn+tsZhKhLbJqOOI8YpzGXwU+6ak3JIeWe+82yD1G5epPdmtEAcf03dlp6uedEMlZ4dqMHTEpofzww71LFMoeP73KH7UJwbFEOMezFx75wO6QlQRKKygEsS8+Y9//H0UdhEfUbw1Li11iYU7becdq60+3KqG+1iYKIDsTz7hVkW7xJQN8OYOWQ4+qyHBTxmqi+yvOJ3CeNsWuHdjAcJQ9W1JO2wz8I1vTPcvWtC9cTo9poEJSTmiN16EqapnMVR4ukVl7zUoZ2AkqD61O85AhtQcb31iGZb+hYtlRohSNBFiXZU5gQNE0HiseMmJtMZfwQzh6x9vb2ZOIG0fyJwTQxhIowTK8vjCaAJleFOh5Ev2ARg0jsKbg2ffP6mplyvhVvjeYv0BW0tJdPQDLV0eMt/cwIbBBc46V3M5ywfp/b664L6/o2xclhhjUwRfjN7VGHgjUskZWwjsUU1vAbusxC9wbGxav2YIFrhux3Rn0hyhKQbfSdHXPMNhkTTZLmc9R7TySWcsQEVtmNQrUSwo46ScC6QOvC19coDPc9qRI5iRoJbLYLYkeE7TNpWUZ8wv1+rEftB+pfH5KJQ2nEvxsQqZBnQCJw+y93dAJXDWKau+jC9zIfbAWvT6jMNtz6Y3qQLKocKGriueW+0JMhmPipiwvJCsMbulPWvlTqqi1voIuxK782OaFJI9604ETA+qH5o6Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66446008)(66556008)(66946007)(38100700002)(316002)(6506007)(82960400001)(9686003)(64756008)(4326008)(6916009)(66476007)(8676002)(38070700005)(26005)(186003)(122000001)(7696005)(54906003)(71200400001)(83380400001)(55016003)(508600001)(2906002)(66574015)(8936002)(5660300002)(76116006)(86362001)(33656002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ST2bELaMbK7ui0BF3HIHNdewKtG/VDFmHZyy1FaFds/DgLJB/uVyz+O1/WWe?=
 =?us-ascii?Q?hkfCi4cY4hrePJYG9lHrSaBgXcD3IxTlf6U2u/6uB1ND3Bhf4+/A2j7AW9Tq?=
 =?us-ascii?Q?PDR276KsabF8Yfqz0QDrSXG0cwTzXIJHCvnT9s5QwkAu9PzLL884+DXYTZY3?=
 =?us-ascii?Q?N4guC3koJCf2zVXr4iK0GhDWLwk1PA5etWpmmvDyiVzGDIBaRClpjf7xYurj?=
 =?us-ascii?Q?5IR2U8QFCvv09r2Fyj8OhwO38aeUa/Daewv3HhG0G7wBzO1WTKpHQro7Onkb?=
 =?us-ascii?Q?8xIxLDDjNNZ9szwTvJ32/QZejttt0LZ/Bs10KaDjwR8xa5/LwcZ0Rfd7gDfJ?=
 =?us-ascii?Q?Y/7i5aWXmMx556NqKFGRFjltMkj9wlJmWf14h/G0sPV9JlVl3RoQHSJPN6Vj?=
 =?us-ascii?Q?8Huzc6HPJlBigI8QLrgW7c0RPW9PhWLj14nWTucO5YeMjcoE/3ZxEbf/6l2h?=
 =?us-ascii?Q?7iEWgKLgqQ9hcsj3ABbPHDWGDF2fL5kMSJB1bLyNQvlEQUNJzDTmRwtfL0Wl?=
 =?us-ascii?Q?q2F2Xy/1FXrosegCX3gVeFQe7BrMdrBlO6X0FTfqmg9VODpOvpBb27p48KgN?=
 =?us-ascii?Q?JeMj1aWo9s3tFa/autHMclkLFxgBA2ET2e3E0mERoQ3PFxhCyT2c4D6sl1kf?=
 =?us-ascii?Q?ShpJfFY6x7TPiRPOjAQLKK9wfFZ5yLZmzbTqZU9foijGkjoqeTO/FlmE0T6s?=
 =?us-ascii?Q?1fzlII3N5kpJXyJaIuG8BiEzXj+GglSzX1oK02y9YlCKZYUzNnXctRthIkT8?=
 =?us-ascii?Q?MUnCqwxGvQVvP3n5Qsi2BJjnbidSBf3owMmRbLdDLP2JMluFkFEi62KiolOW?=
 =?us-ascii?Q?0QTshKFkrHEHpFKH5UKacaNmKC+YakibftHsFITrKoM0PCExoS97CDyMDQMm?=
 =?us-ascii?Q?UTrU6Mu5hcUMT7RkULsjaqivxyBRo+vtOzRS5/81mq3ulwg72+O/F5EDLUzl?=
 =?us-ascii?Q?uDHAxlFyRU1S9Fr8Opyk2n43mSUm+BWwKzjcGK/7s1ULmDkANJFcNY6Y9bLa?=
 =?us-ascii?Q?oBFloWuXLjhZXeonGpSP0LWRJDatFxT1TIYr/2DmU/PjyoBRZO0JiIn5+HdH?=
 =?us-ascii?Q?V7Aa70pxwaLLenzcs8QTnb+e/DG5+VvxIrqDw2rEzrAsen4xG4qP4yBPebme?=
 =?us-ascii?Q?+SMMEEQooPUh7+F6A0fGDpAXfevDMcz2OTwWcCiARsnAx8kjvlSmjx0ItJWW?=
 =?us-ascii?Q?+NKqpTTKsLraizwTFqZNsqq15fWtJD94ZyHWOCtxyM2GqWijZc/Pia6YsTTj?=
 =?us-ascii?Q?fGLg6jE8dB/CQ2TOeTg8ngklyVw5iLADYEPxI5yfFC/5NdJNj5KzNptgQmjS?=
 =?us-ascii?Q?Xyt82LUt1NmrP470cJOKwmS6rotjSAY6oRn0sUdRhz2/bfF0VjlevkUXfLmc?=
 =?us-ascii?Q?556O6eshZ/z/DNaDD0N/Uw9g5w1CBgINExm4s3yvkufUSPA0PSZzCKcI0/2J?=
 =?us-ascii?Q?t1d+PJVvvVuKzHtBuT9BaATn98cgcYWBFCV8PLTfFdtQsH1kzgwawq8Ec2Hz?=
 =?us-ascii?Q?MM7O0s/rngIWni7oPcgUhOOy8EnbjNXNUu/h4ZVc/OLxaZs7X7tIg500QZDN?=
 =?us-ascii?Q?9STdt86titMkghcp8akUa9voqWBIL4knJu29yThEmFA7A/ReKqrfOviIrGOW?=
 =?us-ascii?Q?wEoyNq65LK3gGh6f9e/NTu3Vwe04Puww6vcpVMAYvCBQLYLA5yaUsNvqhv9j?=
 =?us-ascii?Q?5KJH/uiFRPDzgjbWIXmrbtfo6jKR2pqSPeaS8ZonT3w1fmH47jecB+hUdRrw?=
 =?us-ascii?Q?ltxaPSBdAw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b0c47d3-0bb0-4bd9-7f1f-08da1f566cb3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Apr 2022 03:08:47.7072
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 60TjPUw/v1/i67pvgvJ+8yQhFDQVZpd2Beg1X4BuwZDOfLZVn5rIDDccyc8G0NkdByxE6SqIbwtRxAVj49s7sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3717
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 03:44:11PM +0800, Zqiang wrote:
> If the rcutree.use_softirq is configured, when RCU Stall event=20
> happened, dump status of all rcuc kthreads who due to starvation=20
> prevented grace period ends on CPUs that not report quiescent state.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

>This could be a good improvement!  But a few questions and comments below.
>
>							Thanx, Paul

> ---
>  kernel/rcu/tree_stall.h | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h index=20
> d7956c03edbd..e6ecc32cfe23 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -348,6 +348,7 @@ static int rcu_print_task_stall(struct rcu_node=20
> *rnp, unsigned long flags)  }  #endif /* #else #ifdef=20
> CONFIG_PREEMPT_RCU */
> =20
> +static void rcuc_kthread_dump(struct rcu_data *rdp);
>  /*
>   * Dump stacks of all tasks running on stalled CPUs.  First try using
>   * NMIs, but fall back to manual remote stack tracing on=20
> architectures @@ -368,6 +369,7 @@ static void rcu_dump_cpu_stacks(void)
>  					pr_err("Offline CPU %d blocking current GP.\n", cpu);
>  				else if (!trigger_single_cpu_backtrace(cpu))
>  					dump_cpu_task(cpu);
> +				rcuc_kthread_dump(per_cpu_ptr(&rcu_data, cpu));

>Was this addition inspired by the chasing of a bug?  If so, please let me =
know exactly what information was (or would have been) the most helpful.
>
>For example, the starvation information might be more compactly represente=
d in the information printed by print_cpu_stall_info().
>Unless the stack trace was quite valuable, it might be best to omit it.
>After all, RCU CPU stall warnings are already infamously heavy on the text=
 output.

Is it better to modify it like this?


diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index d7956c03edbd..37444ff00787 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -465,27 +465,38 @@ static void print_cpu_stall_info(int cpu)
               falsepositive ? " (false positive?)" : "");
 }

-static void rcuc_kthread_dump(struct rcu_data *rdp)
+static void rcuc_kthread_dump(void)
 {
        int cpu;
        unsigned long j;
+       unsigned long flags
+       struct rcu_node *rnp;
        struct task_struct *rcuc;
+       struct rcu_data *rdp;

-       rcuc =3D rdp->rcu_cpu_kthread_task;
-       if (!rcuc)
-               return;
+       rcu_for_each_leaf_node(rnp) {
+               raw_spin_lock_irqsave_rcu_node(rnp, flags);
+               for_each_leaf_node_possible_cpu(rnp, cpu)
+                       if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu)) {
+                               rdp =3D per_cpu_ptr(&rcu_data, cpu);
+                               rcuc =3D rdp->rcu_cpu_kthread_task;
+                               if (!rcuc)
+                                       return;

-       cpu =3D task_cpu(rcuc);
-       if (cpu_is_offline(cpu) || idle_cpu(cpu))
-               return;
+                               cpu =3D task_cpu(rcuc);
+                               if (cpu_is_offline(cpu) || idle_cpu(cpu))
+                                       return;

-       if (!rcu_is_rcuc_kthread_starving(rdp, &j))
-               return;
+                               if (!rcu_is_rcuc_kthread_starving(rdp, &j))
+                                       return;

-       pr_err("%s kthread starved for %ld jiffies\n", rcuc->comm, j);
-       sched_show_task(rcuc);
-       if (!trigger_single_cpu_backtrace(cpu))
-               dump_cpu_task(cpu);
+                               pr_err("%s kthread starved for %ld jiffies\=
n", rcuc->comm, j);
+                               sched_show_task(rcuc);
+                               if (!trigger_single_cpu_backtrace(cpu))
+                                       dump_cpu_task(cpu);
+                       }
+               raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
+       }
 }

/* Complain about starvation of grace-period kthread.  */
@@ -595,6 +606,9 @@ static void print_other_cpu_stall(unsigned long gp_seq,=
 unsigned long gps)
               smp_processor_id(), (long)(jiffies - gps),
               (long)rcu_seq_current(&rcu_state.gp_seq), totqlen, rcu_state=
.n_online_cpus);
        if (ndetected) {
+               if (!use_softirq)
+                       rcuc_kthread_dump();
+
                rcu_dump_cpu_stacks();

                /* Complain about tasks blocking the grace period. */
@@ -660,7 +674,7 @@ static void print_cpu_stall(unsigned long gps)
        rcu_check_gp_kthread_starvation();

        if (!use_softirq)
-               rcuc_kthread_dump(rdp);
+               rcuc_kthread_dump();

        rcu_dump_cpu_stacks();

Thanks
Zqiang


>  			}
>  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  	}
> @@ -471,6 +473,9 @@ static void rcuc_kthread_dump(struct rcu_data *rdp)
>  	unsigned long j;
>  	struct task_struct *rcuc;
> =20
> +	if (use_softirq)
> +		return;
> +
>  	rcuc =3D rdp->rcu_cpu_kthread_task;
>  	if (!rcuc)

>The checks for use_softirq on the one hand and the checks for non-NULL
>rdp->rcu_cpu_kthread_task are a bit "interesting".  Not your fault or
>problem, of course!

Yes the ' if (!use_softirq)' is redundant,  the if rcu_cpu_kthread_task  Is=
 completely enough

>
>  		return;
> @@ -659,9 +664,6 @@ static void print_cpu_stall(unsigned long gps)
>  	rcu_check_gp_kthread_expired_fqs_timer();
>  	rcu_check_gp_kthread_starvation();
> =20
> -	if (!use_softirq)
>
>In particular, I am wondering if this "if" is redundant.

Yes the ' if (!use_softirq)' is also redundant

>
> -		rcuc_kthread_dump(rdp);
> -
>  	rcu_dump_cpu_stacks();
> =20
>  	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> --
> 2.25.1
>=20
