Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B71F4D57A5
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 02:53:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345482AbiCKByL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 20:54:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344070AbiCKByI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 20:54:08 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1203F68F1;
        Thu, 10 Mar 2022 17:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646963586; x=1678499586;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xH35CX1PaYGJMnUr6QKcofBxsK7ABCEamBC1ouk+zGA=;
  b=Z7UtNfv4btA0S8yrmccWfsllHsCsgze1pBkqneseYgycvvEIsyBPUcnf
   0/HzBDeFudBESIrQcfKzM/Hc8WTecIAlBzfFtn9VX60bN0sRKu+vh/CRk
   p9Wq7jKoga6hivbDp2No4MIZEYKt0s8F+3Q20vMeJQ7PSCXGw2tKTbbWb
   TKGRokh1LyhK4UPuCkoXC0uULsx+3UVj3Dp7CTu29Yar6906DQNNSfK+U
   XKjr5QcWMjn4Wos1sEsgR6koh91u8dzSN/aSt1PmhNWKdkCJn41nNauQd
   DTB6kCD1x1ZCi4JiZ32VqBybtOQ7yShbBKn4dT4xSe80CKJsdwAU/eD9r
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="255659795"
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="255659795"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2022 17:53:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,172,1643702400"; 
   d="scan'208";a="688921680"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP; 10 Mar 2022 17:53:05 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Mar 2022 17:53:05 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Thu, 10 Mar 2022 17:53:05 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 10 Mar 2022 17:53:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ej5x+GRsJyRfdn8cEP+YAa5j/+kzEjnAX1u6TslgwXJhqyE71K6Ar0RdWDEymxnT1UNdZ37i22fZjLfY5HngrapBLijsd2A476LpL7+Nao7EvGkdvARSu3K2Xxdd0tDMaSSQjYXwBivfijV1gPmdh2ZC49GA0qIjKScUhmcxVKelPg7zVbqaKeLbAithOJaBFCW8i//yD3gZoL2hJr7sYBcSmo87O6XlK8mo6P4yZCjgQ51flNIGG4ehVohQpebt+fnmsVSBsSv/FWdiIcfDIGrCFJLEAobTzkj1doc8V3uNQxkmnHqv+0g2UZZneg/A16BkNlzytBFp7GyRZ4MAFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2X3ESlHTlvHkocCPRvLwzYjAkF1TKTvNJLWsnR9SdQ=;
 b=QUPZCTJqHsASDzDrz/qpbx0B36O7BAUq0716IrSW4Yyi9J8JYz1aSZHvCNRpIDpPWhnZyDHSC7ZUnC9Arhveub6NTRDO4X20Eu9L1G4Sodhkh4APhEDp93JHVUKMFe06M64zM0q39oVT3bk2leELqpQ+JBAtRMwhzqkLYV3DmaGnx0TsiPMpF1xDrtg8EygkoOar3tYjJC+cF1V+z284huTPJQ0WTu/w8ZfYQnrwKLic3233EppMYQ/xF/EmWHzM2g4mw6BWkFGBOCTrzVmB0nlha09cSxX4K02T/vD8abI2jDSByS9uADTJCZLOX+WkSShshV/uxlUTjpNpN1+e7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by CY4PR11MB1575.namprd11.prod.outlook.com (2603:10b6:910:10::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.18; Fri, 11 Mar
 2022 01:53:03 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5ccb:dfa1:626e:af2c]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5ccb:dfa1:626e:af2c%8]) with mapi id 15.20.5038.027; Fri, 11 Mar 2022
 01:53:03 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Uladzislau Rezki <urezki@gmail.com>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "josh@joshtriplett.org" <josh@joshtriplett.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcu: Only boost rcu reader tasks with lower priority
 than boost kthreads
Thread-Topic: [PATCH v2] rcu: Only boost rcu reader tasks with lower priority
 than boost kthreads
Thread-Index: AQHYM43GzLOlgd+VXkaxpzNCLQQDhKy48diAgAB3gpA=
Date:   Fri, 11 Mar 2022 01:53:03 +0000
Message-ID: <PH0PR11MB58803825ED2F6BB19C62F42EDA0C9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220309081523.348450-1-qiang1.zhang@intel.com>
 <YipDBx137UdsieWV@pc638.lan>
In-Reply-To: <YipDBx137UdsieWV@pc638.lan>
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
x-ms-office365-filtering-correlation-id: 249afe1b-c168-4cf1-d6f0-08da0301e149
x-ms-traffictypediagnostic: CY4PR11MB1575:EE_
x-microsoft-antispam-prvs: <CY4PR11MB1575AD73F116FC27E576ADAEDA0C9@CY4PR11MB1575.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bf8Hfw+VqupBKUXCWdQu033uiJsmSOnM508WbrSeli8nzTNFt7xK8u+ZDF2p7ZYu8C07ZldbqjnKvPYUBtQbrPU/qmtuZ85i2fLTyftrOYL9xzpzsSNzxi5qLfUqPxs3343lEUFNKveWVS6i19jTNH8nhFBNR7gL1MtPienBtX84jsEM6r3HLLEJjRZYGj1IMcKAlhf3vnJl84GkuCkeDaAmDZQTLMWxGSIh9u7+vmeMj2BMPZsp6Q0JShXpvNnME+jCRw0sZfmCLCN1uw+dQDRlB4XBfDuPxviQBFK+apC9BQUhldiea8E1SzlJz4QWRbdPOS3Kd6v70ySyyPDv7Y87VpGM9t0SndmaRBE2Hh/WYLlxkLLWzvyfHTctXbxi0jqkLsaRtW9eMEPjESs6OzuLt1Nm9fJLGxi2twFooHtb78nVWIkiRPhHizrBatp55C13+Fb9rcLXv4suVd4hKzxXjp5CS2MaMo/4BKY5DT/CcxxmTAkB/H/yKPizUZGP8jiVmMTyHkiRBJfsFMN0rLWhdO+j6P9pbfb+9RmDLNDNaW8iuvHrJRk1gbBp7LjAnKn7MXdGJD/2WXMj+gQ9BQPGgdD0nqR0BDRx2bfBQCus9p7BpkCefoMiW9bppHkPv1/KpxiVaSOJZocOy7X4fLT1q837qqyGgFrW8OsCIEVXHXpFlsP5lyYy3yeS8cP84/uULhhcwv4ZjWk7NBJVzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(52536014)(8936002)(38070700005)(2906002)(82960400001)(6916009)(316002)(9686003)(186003)(83380400001)(26005)(86362001)(64756008)(54906003)(55016003)(76116006)(33656002)(66946007)(66476007)(8676002)(7696005)(66446008)(66556008)(4326008)(6506007)(122000001)(508600001)(66574015)(38100700002)(5660300002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cCTYbVSrHQrtcvTcmfPV79iWZUGE8/O2gyho3SJikgMHJQ4TRE5/1Qc9WinV?=
 =?us-ascii?Q?NKBO5pe8/Wno5vQCcrkjB0pWpIO1a/qc5it2Qy5+1ptJ/UXIfN5ciUnvB556?=
 =?us-ascii?Q?QmkCA0j1zS7M0bZlWf4JJp2QnjXnu7hBm6EJMtCEuSXezq4UeJAQoHt9SwHE?=
 =?us-ascii?Q?UOIvGhI6nHA3Xg2UC2stBD4WBOUqg+P6oQAsTlexKxYPa+l5u90JZ1ST635S?=
 =?us-ascii?Q?lWpiF+CwhqB/MS0+WwGuwQBw8AsSzL9FMm6gNLjtfdssZBlwbp2uxIw2ltQ4?=
 =?us-ascii?Q?LnvNvIVGkPRUQlzooUGGH+4P3LTQUVnG69UeeTFTJ4EkOskPFdeaH+N5SJuf?=
 =?us-ascii?Q?+3tvu6F9JmCpqDkMM+PlZBgx9BvXfljQfol1d71w/LjCmUp52uZBj1KPcbSA?=
 =?us-ascii?Q?Korbpvy517KxXcd4tDk+9m+9TuuwvKG/n6+1cM7T4aAxWp0bcN5hSe5yMuhv?=
 =?us-ascii?Q?EwqmHcCT6e6o2a2eOJqarMOitophbHewMFEUko5weDSse7/KBpR5tp9loOLe?=
 =?us-ascii?Q?4guc0EIDP4JcNa5aoPiUflKjysCcfaDiFpavrUY0hiofE4Eigh5z/w7u2a8P?=
 =?us-ascii?Q?voGUwA7jcWAr1PfiT/DJZ/Ng1+BPyLEVjrMkKrtOGOB2rb9Gl385oRVgS5rZ?=
 =?us-ascii?Q?M/eMr+yxZO3FagS43uWi24GsnSefDKJ/wBrcrnY0V2MYK+GgnygmMLwJgEIw?=
 =?us-ascii?Q?KHV3y5nqncLvJh/7GlMjcolfFYFnhqmKroRc5nALFyfAq3WPmDpodTpvKRbu?=
 =?us-ascii?Q?9Mq7GbknHCNHBwUKIjtkGtkl826h5BWmEdIfDvfej/iHk23Eatn0InsZVuMO?=
 =?us-ascii?Q?YeWjUizqfR1krfYtsex60C3C2lUjdORz0qkX1T70AkDRu/Si8eA/P8GJ2oXE?=
 =?us-ascii?Q?ZlAK1nr+hcrgKjwhSst/a3X9ncrfrsO/8xUCNubHuR31z+2EvIfXWfdy1vVp?=
 =?us-ascii?Q?RrIBc+7R39jd+OiC+GyrRfa2F2dk6lPk6SJnG9QFqKGpYXsAzLEfsrg8rJhE?=
 =?us-ascii?Q?oJ9XZAtxqe99aEDvIcV3fIWzVEYE5BL9lZf45r3Ago95rMYoWgnlfBhkoWfT?=
 =?us-ascii?Q?aRLw55/H7piFBl8Juty6df0Tumhlz+7MHwoP/6hu6pQYz11NJE7UtrQMT2Y9?=
 =?us-ascii?Q?0ocBeYALi/xleNhnUT2XbahbKjCDPaG0+UU5h5/AemUMbvQt/bB9BuDBmkWa?=
 =?us-ascii?Q?OiEUD9LbUPd/HNT83hKWfRh1VTkZ63M+K3VAugq3ckQoZJvWJxj0vcPycWTj?=
 =?us-ascii?Q?toGNAJZBLKp9D2cMdf4cbCCcn7ctkyVNZ0iH6BGPuGp9XcdgpLFhXaGmjYJm?=
 =?us-ascii?Q?QwRGyEQkW2cHasNzMUZ3UV2CjM3PMjJnrd6hGejMb2jJ6Ymx0ZDdfNr62HqY?=
 =?us-ascii?Q?rUBvYyywMuiyyOVXw0OjW92MieGh1GGTsKN62sM334GUblzhxhEnqSnu6WtM?=
 =?us-ascii?Q?SJxpKJf0lRtYHgbFJ03cSdtpf/gDNTvfFGj7jgol4oXIUCXyDFlSl2C8z8Bq?=
 =?us-ascii?Q?vLurh85JhAzf4hJ58DRb3jsjXhfNonMEL7k8QztHEfKeVkDbtFLnE0luNaMH?=
 =?us-ascii?Q?p+KmbU6FRnhQVBxwl2hHZXeb9boSzfX6pdEvXyWmeKyX10fi5FsNuDeEXupl?=
 =?us-ascii?Q?FA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 249afe1b-c168-4cf1-d6f0-08da0301e149
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 01:53:03.5441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3lLeQopxscWxG8TWymZgQ5VOEuu1rfphl9wuNPuISzUcWcSSG/f5EaPpSSNcWm1fwBu6kqTpBTbjUpZAsg33tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1575
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> When RCU_BOOST is enabled, the boost kthreads will boosting readers=20
> who are blocking a given grace period, if the current reader tasks=20
> have a higher priority than boost kthreads(the boost kthreads priority=20
> not always 1, if the kthread_prio is set), boosting is useless, skip=20
> current task and select next task to boosting, reduce the time for a=20
> given grace period.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  v1->v2:
>  rename label 'end' to 'skip_boost'.
>  add 'boost_exp_tasks' pointer to point 'rnp->exp_tasks'
>  do the similar thing as normal grace period.
>=20
>  kernel/rcu/tree.h        |  2 ++
>  kernel/rcu/tree_plugin.h | 31 +++++++++++++++++++++++--------
>  2 files changed, 25 insertions(+), 8 deletions(-)
>=20
> diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h index=20
> b8d07bf92d29..862ca09b56c7 100644
> --- a/kernel/rcu/tree.h
> +++ b/kernel/rcu/tree.h
> @@ -103,6 +103,8 @@ struct rcu_node {
>  				/*  queued on this rcu_node structure that */
>  				/*  are blocking the current grace period, */
>  				/*  there can be no such task. */
> +	struct list_head *boost_exp_tasks;
> +
>  	struct rt_mutex boost_mtx;
>  				/* Used only for the priority-boosting */
>  				/*  side effect, not as a lock. */ diff --git=20
> a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h index=20
> c3d212bc5338..22bf5a8040f5 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -12,6 +12,7 @@
>   */
> =20
>  #include "../locking/rtmutex_common.h"
> +#include <linux/sched/deadline.h>
> =20
>  static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)  { @@ -535,6=20
> +536,8 @@ rcu_preempt_deferred_qs_irqrestore(struct task_struct *t, unsig=
ned long flags)
>  			drop_boost_mutex =3D rt_mutex_owner(&rnp->boost_mtx.rtmutex) =3D=3D t=
;
>  			if (&t->rcu_node_entry =3D=3D rnp->boost_tasks)
>  				WRITE_ONCE(rnp->boost_tasks, np);
> +			if (&t->rcu_node_entry =3D=3D rnp->boost_exp_tasks)
> +				WRITE_ONCE(rnp->boost_exp_tasks, np);
>  		}
> =20
>  		/*
> @@ -1022,7 +1025,7 @@ static int rcu_boost(struct rcu_node *rnp)
>  	struct task_struct *t;
>  	struct list_head *tb;
> =20
> -	if (READ_ONCE(rnp->exp_tasks) =3D=3D NULL &&
> +	if (READ_ONCE(rnp->boost_exp_tasks) =3D=3D NULL &&
>  	    READ_ONCE(rnp->boost_tasks) =3D=3D NULL)
>  		return 0;  /* Nothing left to boost. */
> =20
> @@ -1032,7 +1035,7 @@ static int rcu_boost(struct rcu_node *rnp)
>  	 * Recheck under the lock: all tasks in need of boosting
>  	 * might exit their RCU read-side critical sections on their own.
>  	 */
> -	if (rnp->exp_tasks =3D=3D NULL && rnp->boost_tasks =3D=3D NULL) {
> +	if (rnp->boost_exp_tasks =3D=3D NULL && rnp->boost_tasks =3D=3D NULL) {
>  		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
>  		return 0;
>  	}
> @@ -1043,8 +1046,8 @@ static int rcu_boost(struct rcu_node *rnp)
>  	 * expedited grace period must boost all blocked tasks, including
>  	 * those blocking the pre-existing normal grace period.
>  	 */
> -	if (rnp->exp_tasks !=3D NULL)
> -		tb =3D rnp->exp_tasks;
> +	if (rnp->boost_exp_tasks !=3D NULL)
> +		tb =3D rnp->boost_exp_tasks;
>  	else
>  		tb =3D rnp->boost_tasks;
> =20
> @@ -1065,14 +1068,24 @@ static int rcu_boost(struct rcu_node *rnp)
>  	 * section.
>  	 */
>  	t =3D container_of(tb, struct task_struct, rcu_node_entry);
> +	if (dl_task(t) || t->prio <=3D current->prio) {
>This is a bit confusing to me. We know that "current" has SCHED_FIFO class=
. In this scenario if "t->prio" has lower value(higher priority) the task f=
alls into all real-time categories anyway and is either:
>  - SCHED_FIFO
>  - SCHED_RR
>  - SCHED_DEADLINE
>
>Checking whether the task is dl_task() sounds like unnecessary there.
>Am i missing something? Could you please comment on it?

Thanks feedback

Right, the deadline task's prio has lower value than rt fifo/rr task.
dl_task() condition detection seems redundant.

>
>Thanks!
>
>--
>Vlad Rezki
