Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BDE4DD481
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 06:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbiCRFwB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 01:52:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiCRFv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 01:51:59 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DE125FD79;
        Thu, 17 Mar 2022 22:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647582641; x=1679118641;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/gdpmIQn6zs81QNn/Qm3pTMNOTr5Xd94uM1uIl1lf1c=;
  b=VrPIDPP2UIfEEaKDf+NIR9Z1+WAHIpjzJdLFw/ywz4D1XN9z0LRIKyi9
   WYECw8YFRiZQw/U2JvI+sKJlEhGoS/wQvQPNhDGX6hdtZYm2G+63afAKI
   uWqsmZSPcuxN/+gvEbfO662A87V36vVJaXU9pqtX7lsrngFokSG/EosTv
   HVxFthavcELZOfe6/ttDB7SMplKyxLzn2VG0kll0c2kSOwvR29qtFcMWK
   t9KsDAeES0uJEAvi6ivLZn49mhlXciK03oQ5aN5yBGBwStEMRcXQIbcqo
   0DlDQ+bwXmLyuAfQ5TAU2ldIi1qWsAip/ilTwx1dtDltPlnfVwY/2PU2l
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="320269587"
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="320269587"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 22:50:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,191,1643702400"; 
   d="scan'208";a="614241562"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga004.fm.intel.com with ESMTP; 17 Mar 2022 22:50:40 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 22:50:40 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 17 Mar 2022 22:50:39 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 17 Mar 2022 22:50:39 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 17 Mar 2022 22:50:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pa2orroPMV1Q2muF+H/sU7K6VGlWpnPN+RQ2btjgGWOn6KpD3AaVEMT0Ac7Y4VT3U16y8fMkjQ857FbzyNu8Ftou4KPSNqyzeZkZSViJhAkiyh6pVP9pFtRwAY03pKoi4ecxs/NIP5Y7hHiBQAtf+zwuN/P+t+UlQPSPc1yzJeekf5/g56RuvZaauHhyS22B7LNMQqeH7o3vhOQIm9687fmFm4y8tKhxQZwhMNW3CZR/H50PvnSO37joIn7cmUsFS9LAl9Y/upDRBBXNDE/H7L5+UL6DVpSOz7IqD0RIiC4ynFte8smDs490Kw/vxX10uygPkKjD/aYaZ49Zyr5dtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8TBqraqLTyDoIVANnHsmoy7OI4yKiCoQOtVrnMRGx2o=;
 b=Smsp5p881unq0nbxc0O3T58krs1Rt7pLAMGV8JErDgqbDzXzum75Sh3gJOep7cm4Swtt0AutTV4t8Qj6T1BlC8qJVuY5XIVVd3gaLkCLtbOQljxSet5UZIWuvAGAJq9kyZyHzd0AFpdZnHwA/6utOM7DwzSWyOS38nhpzxrtZILSk+FSKuTT/i4018McG6eD8doWBd61X4SIGG78hB1eGHUPweJBx56dFlna1JuTGR8EJ4NdB3/tPkC50Bo8EDxjeVL+WQHvY8eIhqB1dyvdB6CcEvMS1aXRf3iuf/yTDZ4tvB9RhKod+FEUDxZhHcdY+4lSh2FRXCn3j8yJuR6BzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SA0PR11MB4767.namprd11.prod.outlook.com (2603:10b6:806:97::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 05:50:35 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::d90e:5a21:8192:7c54]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::d90e:5a21:8192:7c54%7]) with mapi id 15.20.5081.017; Fri, 18 Mar 2022
 05:50:35 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "urezki@gmail.com" <urezki@gmail.com>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3] rcu: Only boost rcu reader tasks with lower priority
 than boost kthreads
Thread-Topic: [PATCH v3] rcu: Only boost rcu reader tasks with lower priority
 than boost kthreads
Thread-Index: AQHYNO7gNJl5wtEdME6XCIwd5VJW/6y6BwsAgADvr2CAABoXIIAHM7mAgAJeEOA=
Date:   Fri, 18 Mar 2022 05:50:35 +0000
Message-ID: <PH0PR11MB58806B59FC8148C9C5160A5FDA139@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220311022226.595905-1-qiang1.zhang@intel.com>
 <Yist4IWWR/6BZzeK@linutronix.de>
 <PH0PR11MB58802B8804EDFFC73BA676F2DA0D9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <PH0PR11MB58807AD9A1BAA122218B92DBDA0D9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220316165931.GI4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220316165931.GI4285@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: f98dc7c9-5d1c-4892-08e9-08da08a338f6
x-ms-traffictypediagnostic: SA0PR11MB4767:EE_
x-microsoft-antispam-prvs: <SA0PR11MB4767B0D1BE87A7838EC43BFDDA139@SA0PR11MB4767.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qh89KdHVRRpMTcgfCeNsxeWmSlNRDPUfw3DCP7P09HerxY3yA8ee57mQAQ1wZz+OvInJowJaQuCpLxoewQ73LfEVYKmT066b6UidU6Fd2E+ApP6mjfIGjnI2D0W6GHGkeKtpdXpsXnG7CbXvr6H60bZ5t6rGr2RcUxKKaMM+KsZUoBxRBzOvIog8dblX2lQ031Jq3Llu8PvgSLYMnnCeu5JRt5BSFh5aIgyr0VDt211xSOc0cqrh8wExAwcYYoLsMyDXOGXvM3w2KLYp1xhE+190SD2C2611jIXz/SHjjOg2SutShTXh4a+Gjsg81csmry/+dcawRrRypWr65fqKlahnSss8HrJPrPNAqBao8cEPrqy3JkiarzMJ1tTtKw8qix6ni3BadXaVp6gzSctKAfkcpWKYzyACga++adjgYrLanvjlnYvDl66x/MC5XQDk5oB9cswgrkxWRPJJ+leS/aeVtX/gqXEJbboQylWBg8vlvPJwhCnn3CRrB5tCxR5K2NvtjRcHXVWEfVyRlHEIJ7eFhfacugqNptoS3J0A6MotSbf3NVZ5r061kn+bDSMQDL0DWUBiFj815Dj7WHMvZOYbrWqw9LZkYvJ8pQSQe6xDFOh5lQjLgOg6MmA+JjLfVHBStgzS9E8mwO5zNLA/axqVmgoMFRaMBuYHhS8Flvr574gUAYKqyLrvZPyP9/ONeCDg5kiXVpgy3sDKElvcFA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52536014)(8936002)(4326008)(55016003)(5660300002)(316002)(66946007)(71200400001)(76116006)(8676002)(64756008)(66446008)(66476007)(66556008)(86362001)(6916009)(54906003)(508600001)(82960400001)(33656002)(53546011)(9686003)(7696005)(122000001)(186003)(38100700002)(26005)(83380400001)(2906002)(38070700005)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?CZBvfNiy5UBtxqeqwZUVYlxzh5q0Or0BXZS9ZZ3q69nz/8qxJpnBoqDaalYo?=
 =?us-ascii?Q?XcYewaov4klpEGyM9MiZXb4bsWH/6AipHRD0vwuRKGEs7B/7z9rmAssDF0Th?=
 =?us-ascii?Q?V1Q38ChYOQRvcUrQFGn8mrXmKIJj/XRwrxPioGFiQOLwd1/rrKf0T0eI+Ovc?=
 =?us-ascii?Q?rFXmDyPD4ASc+BkNwdFj4k73unixs9zT00D3N7wkSq8eMnZ85Uq+rv2KWDcL?=
 =?us-ascii?Q?+NDMaS/oA9DsBxTPpZPJpC1mIjQsNHQWNqbk6PbH6CWtX5ln8Rc2Z6uLkCPz?=
 =?us-ascii?Q?v+rpnmcMD00EYXNXMs6Z25q1DgTs1Hh0WdMeATgHeOIxNkzeMVCfdMI2HOHn?=
 =?us-ascii?Q?eGAcAsn/bEERoT5KyKlBh7EMMtKjsZdt+NYV3BVeJenI2ZjoHjW1OD5WuC1s?=
 =?us-ascii?Q?LuV14PKE28bZOxGfTR1a+DKUO4cX2U/dN8RS3Y2qBgYQYkXV5Ebh8TSGfoho?=
 =?us-ascii?Q?SDWMtM/Nq1h7ARxKzOOurUzBlgFG6UYn25OCjy5tZ7SwjND/oI0v7SFU7Hfc?=
 =?us-ascii?Q?xzV1n/okXxc+GmWxbg8qdqkktGqSPTwjCONaX+HwN/GISKzr658mgJc1HeFY?=
 =?us-ascii?Q?XpkxvN3JpiFdmaKNwf4e1xSYvEfb305Mw9UxvxRiZwFaxV8P+/X5tvMMpsG+?=
 =?us-ascii?Q?y8D4E/O/0A0n3yx3mxXWkRkTiQZj0gEzKrYyBxY10NxzEM46D6ZL7u8jNaOL?=
 =?us-ascii?Q?YWOWdLevZq8JMZndcnvYmUdRf0zk+jYIh92SKmkPB/0KpPnvKQnoDsS+b78D?=
 =?us-ascii?Q?KLot32SRBOwXXK6L/3lxUpduJjsRYTDbFs5T6mR3yLjP0VtuzscJwZU21BwX?=
 =?us-ascii?Q?rAKtPUWjqrlk1+Ro9lthzwqMI1IqNRg8ZbbGhtSwyMwFgbeFDRFDFsX4Vwrg?=
 =?us-ascii?Q?ChEkUuRKCuLypRMHSlhV/K6MZBNVNYeHpH8M0ah0PvD3CL9N0RmOrB6pXuMz?=
 =?us-ascii?Q?gF8H1EoXXBcX6mKSFVbd6oslFKt+/bKWyCC7Rqf3NKpDVc3p9TDDWDNGaTH+?=
 =?us-ascii?Q?/3MV626d8WrIw31ZXnSTEgLvKK9Q6TAs8D/sO5g68gIGx2mlI3MaGqK/EuKJ?=
 =?us-ascii?Q?Z12lYQlBvh7zdDljXHHH+X4ijlxQVFnZdUQyaq4GbIiWlarLyrRnU3GQo1fz?=
 =?us-ascii?Q?cujH4bEjN5y75mWPlbyRp+atJkXl9dFoEK0aRi9sPgddsbJWVx/cnmUyZMkg?=
 =?us-ascii?Q?5ejQJLRT62VPnzl6QY2nA5416RZMCwTg4Z4UXtyxWG5KIrYJxH0fFv9PQDOB?=
 =?us-ascii?Q?Mo+AI/HXyje2uoCFP1/5V49YIZXPzgWhqRa1ZondIO09Stl3oLAGfw7Izd0X?=
 =?us-ascii?Q?xh1uk7Y9iwsZ1FGP46Cko0t5Bn6DIXvOKXKW/XIA2X9ceDIYvHRaK7ze7Nst?=
 =?us-ascii?Q?iL09rA+Kk+1Z1jxnQmpNgeJ/PVB+5Eg9BShdkPmsCtTfKLdOT9j8iWj5tXur?=
 =?us-ascii?Q?jS83Iea4Fftn4I5mssD4zErsLg46XjT2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f98dc7c9-5d1c-4892-08e9-08da08a338f6
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Mar 2022 05:50:35.3748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nN0RO1ZfYMXrR/xL2U5W0/iCdADMyZYcXox+OSstkGLjcw6KdDrVn+WBTmgYI6PWfkrP+RoHDda6JCEBMcMpdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4767
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 03:11:04AM +0000, Zhang, Qiang1 wrote:
> On 2022-03-11 10:22:26 [+0800], Zqiang wrote:
> > When RCU_BOOST is enabled, the boost kthreads will boosting readers
> > who are blocking a given grace period, if the current reader tasks
>                                        ^ Period.
>=20
> > have a higher priority than boost kthreads(the boost kthreads priority
> > not always 1, if the kthread_prio is set),=20
>=20
> >>This confuses me:
> >>- Why does this matter
>=20
> In preempt-rt system, if the kthread_prio is not set, it prio is 1.
> the boost kthreads can preempt almost  rt task, It will affect
> the real-time performance of some user rt  tasks.  In preempt-rt systems,
> in most scenarios, this kthread_prio will be configured.
>
>Just following up...  These questions might have been answered, but
>I am not seeing those answers right off-hand.
>
>Is the grace-period latency effect of choosing not to boost high-priority
>tasks visible at the system level in any actual workload?
>
>Suppose that a SCHED_DEADLINE task has exhausted its time quantum,
>and has thus been preempted within an RCU read-side critical section.
>Can priority boosting from a SCHED_FIFO prio-1 task cause it to start
>running?
>
>Do delays in RCU priority boosting cause excessive grace-period
>latencies on real workloads, even when all the to-be-boosted
>tasks are SCHED_OTHER?
>
>Thoughts?

I have tested this modification these days,  I originally planned to genera=
te a Kconfig option to control
whether to skip tasks with higher priority than boost kthreads. but it does=
n't seem necessary
 because I find it's optimization is not particularly
obvious in the actual scene, I find that tasks with higher priority than bo=
ost kthreads=20
will quickly exit the rcu critical area , even if be preempted in the rcu c=
ritical area.
sorry for the noise.

Thanks,
Zqiang

>
>							Thanx, Paul
>
> Thanks
> Zqiang
>=20
> >>- If it is not RT prio, what is then? Higher or lower? Afaik it is
> >>  always >=3D 1.
>=20
> >>>If it is not RT prio, the sanitize_kthread_prio() will limit RT prio
>=20
> > boosting is useless, skip
> > current task and select next task to boosting, reduce the time for a
> > given grace period.
>=20
> >>So if the task, that is stuck in a rcu_read() section, has a higher
> >>priority than the boosting thread then boosting is futile. Understood.
> >>
> >>Please correct me if I'm wrong but this is intended for !SCHED_OTHER
> >>tasks since there shouldn't a be PI chain on boost_mtx so that its
> >>default RT priority is boosted above what has been configured.
>=20
> >>>Yes, you are right. If the boosting task which itself already boosted =
due to PI chain,
> >>>and Its priority may only be temporarily higher than boost kthreads,  =
once that
> >>>PI boost is lifted the task may still be in a RCU section, but if we h=
ave been skipped it,
> >>>this task have been missed the opportunity to be boosted.
>=20
> >>
> >>You skip boosting tasks which are itself already boosted due to a PI
> >>chain. Once that PI boost is lifted the task may still be in a RCU
> >>section. But if I understand you right, your intention is skip boosting
> >>tasks with a higher priority and concentrate and those which are in
> >>need. This shouldn't make a difference unless the scheduler is able to
> >>move the rcu-boosted task to another CPU.
> >>
>=20
> >>>Yes, It make sense when the rcu-boosted kthreads and task which to be =
boosting
> >>>should run  difference CPU .
>=20
> >>Am I right so far? If so this should be part of the commit message (the
> >>intention and the result). Also, please add that part with
> >>boost_exp_tasks. The comment above boost_mtx is now above
> >>boost_exp_tasks with a space so it looks (at least to me) like these tw=
o
> >>don't belong together.
>=20
> >>>Yes, I will add your description to the commit  information.
>=20
>=20
> > Suggested-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>=20
> >Sebastian
