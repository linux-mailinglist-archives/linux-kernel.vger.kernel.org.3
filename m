Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3D650628D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 05:22:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346370AbiDSDYq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 23:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbiDSDYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 23:24:43 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB9022BEC;
        Mon, 18 Apr 2022 20:22:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650338522; x=1681874522;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NdUqtX2n+8k/JkAY0Q2bOs0xbQ12WxDWSMrtzzMxopo=;
  b=ejk6ZWTOScphkQLoNTRS0DMY1oUtaChhYf7dJ40Ib3uQ43IyZ0Z/svVS
   gjXgU0lSDTZC6eWB3XpNasGtSVL52534F2nfAyz//zJOK0r12Y7FFHyxX
   DUnWmW0xjP7Jm+06WZILBYHZObhTQRDxahxQR34qujLrV2MSl6CW8uikQ
   nBkGfthyC5PSvJS9mKU22Ru2offoimt23iKmQ8vleLHhlrnB92cv+v6LM
   yIPoOJzfrO8taeNe7eX9a1Y9yPMxKbyi4unD4mNsLJ8zmFHXlS7EYD720
   He45Rit9HPDWuZJapAM7yjYIYp1/YfHI3Jd0gmgbUnbcIa2ZJNNP4uVOK
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="263838355"
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="263838355"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 20:22:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,271,1643702400"; 
   d="scan'208";a="860433696"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by fmsmga005.fm.intel.com with ESMTP; 18 Apr 2022 20:22:01 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 18 Apr 2022 20:22:00 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 18 Apr 2022 20:22:00 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 18 Apr 2022 20:22:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S1aCC+L6qpn5HGRoR385mBRrLoKJTtYfVwmp+mRvy/IDx92T+XW+cIG76t2/87ySawQsbAFyUaBNUijgWzYPnaxGABKqofSHSJMUxOSZuMvNvA5iymX1LUmIsovDDEt1Ymg5gS1oypq9TRThYeyl1dvZXR6z+eV/BN3KWZaMz7Op8tjScJ913T7RDKJy5ogIDer8mJxReMEptXEHxsQ0MfELMCAHPcixgL5wbctWdZljarETf4+qTamH9T3kmuAo6MQt8GF1zGwOP4s3Wh/1vtYJ07bFytCtfZR5Y+djwhFhr5PWFiF6CC2ES2rX5nGe8Wd+SOuVmvFUtWGfzz0DAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NyeX6Llawayk6EoTIkdYopKzTMorlBgnoRPcrf5XSZU=;
 b=f0PqeCP7iLSM26qAfaeFvKeRdmSYCCnUWJ4ge1zBE65aJD473pOjtSAHxrGZbS+4jDpK6/aWHHa/lgruYOnZOhLtAN5yeyPpLSe8OGr9nWWI1Pr/oGi6t4qhFv4MhrQ3WQd0jXDwyhYVMiGve2SQt509TvST5hjP/GFnl/CedI1xyW6apkf6pXQJPHbhdSoKpGgdPsIPLcZ8QX+EkTr5pezTLpg46ubTfDJJF8q9HqDGiQtD5Mg8gcZRuyEwXUes2R1r1EqfHTtHf8voPDXSk4yIl177HJ5L1hi3VG//nl8Wpm4b0poHw2ZWlE06zLCtXWsJ8ki5zWW1Pujth3Hbhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SJ0PR11MB5769.namprd11.prod.outlook.com (2603:10b6:a03:420::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Tue, 19 Apr
 2022 03:21:54 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::c579:f1c1:28b3:610f]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::c579:f1c1:28b3:610f%9]) with mapi id 15.20.5164.026; Tue, 19 Apr 2022
 03:21:53 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Dump all rcuc kthreads status for CPUs that not
 report quiescent state
Thread-Topic: [PATCH] rcu: Dump all rcuc kthreads status for CPUs that not
 report quiescent state
Thread-Index: AQHYTwpGNYsEpnO3pUOLiRwx3W6tm6zxsXSAgAApSfCABL7t4A==
Date:   Tue, 19 Apr 2022 03:21:53 +0000
Message-ID: <PH0PR11MB5880D8A33295BFDC6AC557A8DAF29@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220413074411.2369623-1-qiang1.zhang@intel.com>
 <20220416002025.GO4285@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880C3206B4BB782188844BDDAF19@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB5880C3206B4BB782188844BDDAF19@PH0PR11MB5880.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 9b296d30-99b4-41e0-670e-08da21b3c092
x-ms-traffictypediagnostic: SJ0PR11MB5769:EE_
x-microsoft-antispam-prvs: <SJ0PR11MB5769674188287C8DF533D69BDAF29@SJ0PR11MB5769.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YMabcniM1HYbhC/l6eo3cSFp8LWrCrWXAP0qyQA0eDNVv/7li3160GUOOgmh522Igvp9y+oD82wLK77Ysam//C8pp7CGsOLNA4wOgxE9NBVZjCkY/bWKksiGfm8IyWpUd5T7q3AnVDzAV8bLO7rLrEYeSzlO0fT/yETPN3Qk2f98iFTuK7QScuKzVc18UCFpn2qsDMHdSVHEPmmotQxZ/VrdXj+YIYsXBKBZlMezerXol1Vhsc+rWfrd0rwGb2gwY2MEAPBX4CQ0y2QF8cWFdCqH6ZlK218enRaPEQRSLHarGotHQ8dsM1+Xf9eX6+hjvjEAImT+1GeEXkBgeEHaloD6JZBa2wcI6Jvi85ZVVlfun+qG9jKFeMJpEPLs1pR73SjXznX22q7FYvL8q6wftBd/pPtpny803tOvwGaB2BeX6Sz+Od727BvcJ+OZ9cZEnt3K25xvHf7AK7K6329csiad3pVJyivjx4FL3bD9TBFgzS+61qGK8Zp1FUDdXx9Z7ezIGEmj1ne8HYN4yrV609+rFFvG6KjVWl5Q8HWj4zmwxzm986PUgf/BAHtAiRKiyrBzX93KkWf6XAnf51ce3WFEqn1DyDJEcw2n6OG+8+DAX9514AzI9L7kAFxWWse1mDmnxjw7rAajfwdHIyn3QBnvlVcZiwabieqHATZ3CHrPpksecnVQMJ3e4sb21fKmnA2wQQfYJ9SRaDSOs4n94g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(122000001)(4326008)(66574015)(5660300002)(186003)(38070700005)(38100700002)(86362001)(6506007)(66946007)(8676002)(83380400001)(76116006)(8936002)(82960400001)(52536014)(64756008)(66476007)(66446008)(66556008)(508600001)(55016003)(110136005)(71200400001)(7696005)(33656002)(316002)(2906002)(54906003)(9686003)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6G3QZfBxBV+1O5YFEzvpfRsGkqEQpdbf/m8hdzeQ4KLE29dqdAA5oRyS0Qjj?=
 =?us-ascii?Q?/3z5oeJRwG6DLco/dvgCfhx0wMQVr1DVhStkehyG1nEIId+bXC/xVHaW5NcU?=
 =?us-ascii?Q?PqyDcjIwy11GtRtkaQC7/uY1KoVAixuKse9C2az0ZP4i2TptOM4wYJiK9B4X?=
 =?us-ascii?Q?EQrqERoKOMH06RbGVZ4Yq1B6hDmsHPAgRq33K96UFMgjUm4Hlk8lfgn7MjDY?=
 =?us-ascii?Q?1c0ZftC/xFd+h9fObMj1WxNpNkYLYtOrswcCqZ54/2yEIqc8dRU5IW29yt+F?=
 =?us-ascii?Q?gnsuY/YTt/yWt3cmEo5VpefjKMvI0maRX57MrCZvmDkGsWkDkNY+McK2Nwfe?=
 =?us-ascii?Q?lGWgQ1DhdvvES6l2+NZEz0u1zmNiOZwKXdN4pZaJS2Ik8PchXoqFo/GhCDGg?=
 =?us-ascii?Q?RfVYwdk1AErrpcYiO9r1gC9cxrpxIjr7s47WzijyhxLLRxQZ06iq7uLhzumZ?=
 =?us-ascii?Q?R9I0PMivdMOcQqJqfw6wFF2p5AgylO6VYvzk+V1p0cqXBnne3ROFdXlqYt1a?=
 =?us-ascii?Q?vQzSTYSCXNUkeE1hoNmYL48vLsRXYG7mELqC8pY4Av2QvtIEumYQew+87bHZ?=
 =?us-ascii?Q?Y51bNhHf3kkyatTNbWTWt7JTpgmcl3y9JAzuKUCuZOT3+o8ntgneaABCVPzb?=
 =?us-ascii?Q?VOsnBxjPF/CLbaDSJcfz8hI5a0WUzSDtt30GY3ubtXW74LOYXNSvu0+tQhY9?=
 =?us-ascii?Q?qDOm/ym/V2ePrDVY/D/laZpLLEes5Xe10Zhz/Dtm5vQg9Wrq1nbNsDhxsrDJ?=
 =?us-ascii?Q?b1RppGS/IiL+XqteZwnVSfu2Y0cHaRNBELZ0IEqvJ0RLsO0GUdI48O70GSw9?=
 =?us-ascii?Q?d22yk9gmHVoB2xZFWZgaxmjo+UpBkjglJmIKcHL14iNDqJQ1V0bFgFahj3Ij?=
 =?us-ascii?Q?iiNAuhe25yfgZjpvpRxQHKb6RrFxuuKWcfw4ZGzKeNBG082Cp5UJ94bjR2mS?=
 =?us-ascii?Q?mOlCQAc/3xb+wCXVFC14M1Vdjd2SwP8WVR51JevgXf2hkSH97ZmuW6mfrKbQ?=
 =?us-ascii?Q?etkWBWDt7h8kstGS+VuJ10uRtfaXJRAX6IXcM6bcm+U+3uhyFvqt2b1qgew9?=
 =?us-ascii?Q?y3EAmYi1Vc29sFebM+J1aN+VcbdpP81uGn154Eaz06Vab046tGaO+odnLMoc?=
 =?us-ascii?Q?6hwQYdqAffRWCLIGtjVHX1vxk60H2e6HrjzwTOK4/Gb4Q7M/dXEGeSTCcu5E?=
 =?us-ascii?Q?D0a+acSeQMQOW/LuF3PQ+LgBzqOmgBubn38M+dRR5CK8uGseDnqDZ9km2J7q?=
 =?us-ascii?Q?o2XgCtGmwbeewaDlEh93XN+FeQBlhfmSuajWYSlP2DUMTVFIZOxU9HGDgpMv?=
 =?us-ascii?Q?ZhG9fGr/EQgX8aHmk473XxSB1dz7pYuguYmLGCC3h5VrnMuki9t7/uF10Tcg?=
 =?us-ascii?Q?kJ1BhV//ru7hE7AIvCiB07Bg6ZyLuVsrfqCK2KewzeKOmv2VaPHRrV6DD09n?=
 =?us-ascii?Q?po0m2NGTu0ULMCC/PZIlQ3/ZT/o5UgWXdtarykJmqiAU/lyxhlaveBAixIwh?=
 =?us-ascii?Q?oqsrVY72k85t4i+znOw43zONCZuxBZLjBKbE7ZTdYYrgmzgsqvvCj267hVI7?=
 =?us-ascii?Q?jDF/xwwimkXxMw+sh/jurgeqikWsf1ZoTvnSwftcEbe81YKSlbJMgB8EnTlj?=
 =?us-ascii?Q?1Z9562wuuNDNlUexMzkhHv3C9evOaS7pnBIcytYFaT8VHhyf+Fl3J8jTyEvy?=
 =?us-ascii?Q?dHKxqvQbnYytFoG6XBbqrlHVPRdwPRC/KPBzk9VklzpiALDj/zPH0H+hCOze?=
 =?us-ascii?Q?Rs/nJqlipQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b296d30-99b4-41e0-670e-08da21b3c092
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 03:21:53.9092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ioN/BU13XuCnNr8Tzy6qOE4hc1oIKQ1QZ6F34+sglWC544glPw9Q86d5xSIhnniiiddQJ48jH3lHflGQ3S/k4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5769
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h index
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

>Is it better to modify it like this?

I'm so sorry, the following modifications are problematic, I'll resend v2

Thanks
Zqiang

>diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h index d7956=
c03edbd..37444ff00787 100644
>--- a/kernel/rcu/tree_stall.h
>+++ b/kernel/rcu/tree_stall.h
>@@ -465,27 +465,38 @@ static void print_cpu_stall_info(int cpu)
>               falsepositive ? " (false positive?)" : "");  }
>
>-static void rcuc_kthread_dump(struct rcu_data *rdp)
>+static void rcuc_kthread_dump(void)
> {
>        int cpu;
>        unsigned long j;
>+       unsigned long flags
>+       struct rcu_node *rnp;
>        struct task_struct *rcuc;
>+       struct rcu_data *rdp;
>
>-       rcuc =3D rdp->rcu_cpu_kthread_task;
>-       if (!rcuc)
>-               return;
>+       rcu_for_each_leaf_node(rnp) {
>+               raw_spin_lock_irqsave_rcu_node(rnp, flags);
>+               for_each_leaf_node_possible_cpu(rnp, cpu)
>+                       if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu)) {
>+                               rdp =3D per_cpu_ptr(&rcu_data, cpu);
>+                               rcuc =3D rdp->rcu_cpu_kthread_task;
>+                               if (!rcuc)
>+                                       return;
>
>-       cpu =3D task_cpu(rcuc);
>-       if (cpu_is_offline(cpu) || idle_cpu(cpu))
>-               return;
>+                               cpu =3D task_cpu(rcuc);
>+                               if (cpu_is_offline(cpu) || idle_cpu(cpu))
>+                                       return;
>
>-       if (!rcu_is_rcuc_kthread_starving(rdp, &j))
>-               return;
>+                               if (!rcu_is_rcuc_kthread_starving(rdp, &j)=
)
>+                                       return;
>
>-       pr_err("%s kthread starved for %ld jiffies\n", rcuc->comm, j);
>-       sched_show_task(rcuc);
>-       if (!trigger_single_cpu_backtrace(cpu))
>-               dump_cpu_task(cpu);
>+                               pr_err("%s kthread starved for %ld jiffies=
\n", rcuc->comm, j);
>+                               sched_show_task(rcuc);
>+                               if (!trigger_single_cpu_backtrace(cpu))
>+                                       dump_cpu_task(cpu);
>+                       }
>+               raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>+       }
> }
>
>/* Complain about starvation of grace-period kthread.  */ @@ -595,6 +606,9=
 @@ static void print_other_cpu_stall(unsigned long gp_seq, unsigned long g=
ps)
 >              smp_processor_id(), (long)(jiffies - gps),
>               (long)rcu_seq_current(&rcu_state.gp_seq), totqlen, rcu_stat=
e.n_online_cpus);
>        if (ndetected) {
>+               if (!use_softirq)
>+                       rcuc_kthread_dump();
>+
>                rcu_dump_cpu_stacks();
>
>                /* Complain about tasks blocking the grace period. */ @@ -=
660,7 +674,7 @@ static void print_cpu_stall(unsigned long gps)
>        rcu_check_gp_kthread_starvation();
>
>        if (!use_softirq)
>-               rcuc_kthread_dump(rdp);
>+               rcuc_kthread_dump();
>
>        rcu_dump_cpu_stacks();
>
>Thanks
>Zqiang


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

>Yes the ' if (!use_softirq)' is redundant,  the if rcu_cpu_kthread_task  I=
s completely enough

>
>  		return;
> @@ -659,9 +664,6 @@ static void print_cpu_stall(unsigned long gps)
>  	rcu_check_gp_kthread_expired_fqs_timer();
>  	rcu_check_gp_kthread_starvation();
> =20
> -	if (!use_softirq)
>
>In particular, I am wondering if this "if" is redundant.

>Yes the ' if (!use_softirq)' is also redundant

>
> -		rcuc_kthread_dump(rdp);
> -
>  	rcu_dump_cpu_stacks();
> =20
>  	raw_spin_lock_irqsave_rcu_node(rnp, flags);
> --
> 2.25.1
>=20
