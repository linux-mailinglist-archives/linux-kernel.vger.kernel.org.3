Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9BEB531F56
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 01:45:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiEWXpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 19:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbiEWXpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 19:45:17 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AAC880F8;
        Mon, 23 May 2022 16:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653349516; x=1684885516;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=axhqc50RvUlGEYachPLynrEzO8RmYNTKIv+cbfTsvAc=;
  b=ZBbyLEkjl3S+WXgBwDaI06mUVBzmKTdDijSryG7fzfmMPw/iN+VEKXFh
   Eu0CHbIzecNdocv/yq6ENnD08Hd1IV7D5cpWDI5hI4E78lRFpAQZzIQTD
   YFR4xua2gTrDCTadlMlJeeE9QpFV+iFghvxEwE762LxOZy/GVKsxHozUY
   z2D84O6JCCzYNHD6tkbuOdX9PD9u6wBFUPSbrsKvchnqvmAKGop3YcMFB
   lFTRbpbWMDFcjX9/0aXs7YsJJeyzWzKCVrG55S7jeZkG+zGz6BEMGQiI3
   g/RrbvTETNk7YVFht85S+mdjxDTl7umvJY7mHWLV2vqZb/bQEkcEm/7kn
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="273501850"
X-IronPort-AV: E=Sophos;i="5.91,247,1647327600"; 
   d="scan'208";a="273501850"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 16:45:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,247,1647327600"; 
   d="scan'208";a="716944256"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by fmsmga001.fm.intel.com with ESMTP; 23 May 2022 16:45:16 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 23 May 2022 16:45:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 23 May 2022 16:45:15 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 23 May 2022 16:45:15 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 23 May 2022 16:45:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nhzrWaQ1h4mHctQI1WE+oc+ETCHmx2SK4DFuGHKnHyUDiViPydMt9eFC0SDaY4HCNFSTnCwrLMIvrGFcFr2GSZUz0dTDK0RB9FSG+uXBvrZY5e6424X9dAltFViYFN6McAIlmAmty84Z4t5A/ALc12zTwVp/i+lJ/3sRu0+r/UVdkmCq2J6psqgUdxsCJ8ppLgG2eimc4JUm2QQoyIXy16yeX0fcKflNTIokZQykRjO/Aogvl+jOxVvHYtxtpwgK4jLzrznGAw+D1+6inTMm8/mytbsmOdqNAqHG62udU6mTl+dCcd7/odX12EDrrIVaCMTsi2OqNdnzSnUEOvl7iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DyW41XggwDtPAhIpGxSueE/OR/PH1xYEgLh7h02Aq/4=;
 b=aTr61+A3OrBXHNpIs3RsRKenFjpp2OEP50xiaKeSSIlHPzhpi5V+uVTCIILBL6cUgPMC6A58Nv7E+fIiR6JkPUPKtbW6DR5lret1LtnzT3Cd92PtrcJJdl8MMCHi+K3f8/Sk8pKXTkCEvgW5KN/gbaYkBYAZwz1sCDjnV/765F/VzizfkygHpki+Q8vhi4Tp5q96e1N7XWOXpKjWL8GFEB4LRRsl5ensgnQ1AzbD/bcp1/cX6Wfq8QY2Xb2GhSAu8TleJH+AIawaKk4tCamNADVludTi3c8YFG+pG4ljRjv1P5DQJ1JkZD6JGMEdWdCDuj8AqSvEMEoFMqJUf1UETg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SJ1PR11MB6180.namprd11.prod.outlook.com (2603:10b6:a03:459::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.23; Mon, 23 May
 2022 23:45:13 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72%8]) with mapi id 15.20.5273.022; Mon, 23 May 2022
 23:45:13 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        lkp <lkp@intel.com>
Subject: RE: [PATCH v2] rcu-tasks: Stop RCU Tasks scanning tasks which record
 on dyntick-idle entry
Thread-Topic: [PATCH v2] rcu-tasks: Stop RCU Tasks scanning tasks which record
 on dyntick-idle entry
Thread-Index: AQHYbCV/lb12vPYjukKy63FEgFIY2K0tG/kAgAAGzJA=
Date:   Mon, 23 May 2022 23:45:13 +0000
Message-ID: <PH0PR11MB58801059C846CE5321CB3447DAD49@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220520084155.1745726-1-qiang1.zhang@intel.com>
 <20220523230920.GG1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220523230920.GG1790663@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.500.17
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 307383e3-704e-46b2-9384-08da3d164829
x-ms-traffictypediagnostic: SJ1PR11MB6180:EE_
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <SJ1PR11MB61800E13569C01A57217DA0FDAD49@SJ1PR11MB6180.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jqfuSAZtdOryUZP8rvdftBwJtBL42wVdDEED+y5FwndIUWsUsfg9i8g7GAnYtQk2btEu4hJcBcN4xg/EBCd9EyRc4Om8EKOr0urf9rCavf/IBjO/jXOq7UVrq2OCqEsMd4B+wHvQLrId+wmPp606ekUQ2OKftt0l56Ua+6x6QwnXa09XMcOPEE5MPHbrbWkRO5KCVNPjTSH30e+d5+yIffsuFnIPCHyGgKbdR+DXl2+CBsBWfM4PdrePJc3KINaFnW83BKT82kO5mgY9KcoxgG+cWwG2XmL+R+bsYMhQHaxj4ATgXcy8aC+9Uj0f7Q/a5mHAI7UenvW4/9p+PMdpv/PV0QCCpuo8rFHnb9ytHl25CSY+MxQWARLwBxoNhDfZv9K2zY7IYJNexj0RRkAk6vdtihbRU/HZesJ8LI0xBiwjAWUXGPhB3YyyNXw33TFvPqBmiYz8j9QE8qw1DCj/rQmR1zWSiD77ooZQQ0jZ4dmVpRc/3jEoqpeRbEB/3CRkbXxDvrsI2uQlJm9kTvncbORnIBGQOU29tMHtU6NjmrmJ7UDHhbXG7JBKpXPrXCL4ILIr+fDFTSZV722WpffQBoUYXMjKjsP8PFvsZB7XEOCJtzpusmn6rjSp8KyWOEt9zoyfGZnUHVS5buELT2tXVni5hJfXm7+5rDYR2WyvjfGyC/InTF7aqCh7zl/8M+L4ZAIbs2r0o4dtLeXSDmQV3Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(55016003)(4326008)(316002)(66946007)(6916009)(33656002)(54906003)(8936002)(66556008)(71200400001)(2906002)(26005)(76116006)(508600001)(66446008)(5660300002)(52536014)(64756008)(8676002)(66476007)(186003)(38070700005)(38100700002)(107886003)(6506007)(7696005)(9686003)(86362001)(82960400001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?m7xAeExvCQeyC/WJ5Ic8+FF3qgDg3YbEvNRAbZXWOx+VP4zWohWHdd1IqbLy?=
 =?us-ascii?Q?x54AAfdhQO8Jsn9koquzpM+giQcigHbMcyOz4mtIJ4Ub6eTI8PzLbYcn+Fgx?=
 =?us-ascii?Q?w+Be9tMRlWLPrMRjA8eZgpOZD4zUhmxQkKGTjTlnI7p9g3vQKGeK+MOFf8yZ?=
 =?us-ascii?Q?HuTd8LeM0jCKBhtEBfo9N3GbxRZTypA73YIQiWpfHObmPy3Ls9lfqJeQp31T?=
 =?us-ascii?Q?AB0gC5pro72YQ6J/Sk5vmQEGShVTE2qu24nioui5d0QEyuae9LszjWfQ5M5u?=
 =?us-ascii?Q?b9/9ldBh9b0xtR4YZGDHhNyrFKx2mqyWZc89VxoJ0lUByb7Kzs39Cs1mP7ZT?=
 =?us-ascii?Q?/TTNZZBsQGSV7ku2MmxvbsK+6+lUNfAueru7ABamzkouoMrwGafrhpZ6U8nW?=
 =?us-ascii?Q?BIa+pRhTzMFJlupD+I/CQ3DhJ9nH49TOJFvyTVUTjkP6pYOLkWd+Rpxz188U?=
 =?us-ascii?Q?SNJQmyt+lOqhF4IjX36NkXH9dSfJqQiKMSuD0xr9lrlOwnQcZtqw+yh1GrvJ?=
 =?us-ascii?Q?hEe5jehgK55qNOIFMHTpRqvmNtTd1I9EGb2lSosgYMlTV99SFiuiZZCr0Crl?=
 =?us-ascii?Q?1PI/R7nVzfacb5DdTjAZ0f+raQ1sziMZmlesmcZjccFpUiJnFHKusQOvopYS?=
 =?us-ascii?Q?Kfje2ikEW/duRnIvneguiHbMkyWCridmZgnTSOzJcMcrLWtvKYVtn4M5HmF2?=
 =?us-ascii?Q?wc6binhEEiYyTNnql95Iwe3SoEa9s+gu8VgwhWxYpWAeF7V0hu/lk7w1f4t7?=
 =?us-ascii?Q?xF6y6LYGawFOM4WACWgGmJqag8/j08aoeQ/xcjO0fvmDFQEheCO5NP++nobt?=
 =?us-ascii?Q?hZGobZXzWeVaApvxn5QX0PInESeHlxrlPWD2NSRno2EDp+fLt0kKr0rNqI32?=
 =?us-ascii?Q?VHYGk0GVgHswco3CVaEzUdN8v6KGQuu273NCCAm2UPl5i2fAfcwM/b+wyZ6X?=
 =?us-ascii?Q?7dm7J0roTSQauu4ugf6irD8K2DRvk4ezTuxwSRH8fOshqmyrwSjbhUtW1UcI?=
 =?us-ascii?Q?i62V/JdaekQNxKuEt2z6kU202EjTiBJKZBMoJ18LrB2kI2Ek3jyK0BsyXNWf?=
 =?us-ascii?Q?+jOuF2E2wTlm+kxRkhXKhtJx/s7lhx4JIC6Tmjix5e3WVdn+XapkYXmrmjNk?=
 =?us-ascii?Q?9Vyv/gBydMlb+PXsAAJuX0pFMDPTlGiSXtxI/wCAE+/ElmTHTAyRX765HgNz?=
 =?us-ascii?Q?HNyegSVPdc9XWWnQCIec1nJo7tB8mJ8vlCt9NzN0MOOK4Nw898AsG+tKSKvn?=
 =?us-ascii?Q?5jk2mew3dOyp5c4AbGMxF1fvl/nt5TpUDgnCEos3jT7YT3B9sFPlouZHpRos?=
 =?us-ascii?Q?hD6IOj+/bgzvKHY+oe2HK260DIMsg7+SBoNFqSRcTJhXLPhTvJOCd/aAdlAb?=
 =?us-ascii?Q?r5HvyMSFgul6sdABPstS3JCzwNS7KQBghies+jDngUNaNdaK7HKV3MSoRnBz?=
 =?us-ascii?Q?VW3i343VxBIR62exg1AU5JWUR85ewG7Pe36OOl4cjIUbwEXH6INU91i2WXL2?=
 =?us-ascii?Q?jsw+KXqliFzdU91UeBnU5USbnqvH+7R7Vya6niZ6bDwmPyNqWBSqjOix55Kq?=
 =?us-ascii?Q?j7ULGnb6OAB9Kp/XakmmJq8Rhr3HDsGB6yppUIlfy0tv5BatmXzUp1vA2oyf?=
 =?us-ascii?Q?uM2eyZy2vFPvFYoif3+3qKlcNMYy7nP8MYJWMTnxQyXz59Dy6+H4tmxLBsyY?=
 =?us-ascii?Q?o9RgjK5WN6ndbNN5mL4jaetDJyzlmCqJZIPXaeS0NLcjpAOI9DLkGWXRvGG5?=
 =?us-ascii?Q?91ZgLO877Q=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 307383e3-704e-46b2-9384-08da3d164829
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 23:45:13.5136
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rNE8OSc0HR3VZPhM4koRI/rRWxhTkjoyeAsgjNBMH2p3C9uJv3ruiActEH8OldUwb0Ga/gutguftdCGRK1wfuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6180
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, May 20, 2022 at 04:41:55PM +0800, Zqiang wrote:
> When the RCU Tasks scanning on-rq tasks, there is no need to scanning=20
> tasks which record on dyntick-idle entry, at this time, these tasks=20
> are not remain within an RCU Tasks read-side critical section.
>=20
> This commit skip scanning tasks which record on dyntick-idle entry in=20
> rcu_tasks_pertask().
>=20
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>
>You lost me with this one.  Doesn't the rcu_tasks_pertask() function alrea=
dy exclude the idle tasks that might possibly be running in dyntick-idle st=
ate in non-CONFIG_NO_HZ_FULL systems?
>
>What am I missing here?

Thanks for reply.
Yes, the is_idle_task() can remove from task_is_on_dyntick_idle().
And the is_idle_task() can also remove from warnings in check_holdout_task(=
), because=20
the rcu _tasks_pertask() already exclude the idle tasks. Is my understandin=
g correct?

Thanks
Zqiang


>							Thanx, Paul
>
> ---
>  v1->v2:
>  fix build test ERROR due to CONFIG_TASKS_RCU=3Dn
>=20
>  kernel/rcu/tasks.h | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h index=20
> f6459343e4b6..7cb0f922478e 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -809,10 +809,17 @@ static void rcu_tasks_pregp_step(struct list_head *=
hop)
>  	synchronize_rcu();
>  }
> =20
> +static bool task_is_on_dyntick_idle(struct task_struct *t) {
> +	return IS_ENABLED(CONFIG_NO_HZ_FULL) && !is_idle_task(t) &&
> +				t->rcu_tasks_idle_cpu >=3D 0;
> +}
> +
>  /* Per-task initial processing. */
>  static void rcu_tasks_pertask(struct task_struct *t, struct list_head=20
> *hop)  {
> -	if (t !=3D current && READ_ONCE(t->on_rq) && !is_idle_task(t)) {
> +	if (t !=3D current && READ_ONCE(t->on_rq) && !is_idle_task(t) &&
> +				!task_is_on_dyntick_idle(t)) {
>  		get_task_struct(t);
>  		t->rcu_tasks_nvcsw =3D READ_ONCE(t->nvcsw);
>  		WRITE_ONCE(t->rcu_tasks_holdout, true); @@ -842,8 +849,7 @@ static=20
> void check_holdout_task(struct task_struct *t,
>  	if (!READ_ONCE(t->rcu_tasks_holdout) ||
>  	    t->rcu_tasks_nvcsw !=3D READ_ONCE(t->nvcsw) ||
>  	    !READ_ONCE(t->on_rq) ||
> -	    (IS_ENABLED(CONFIG_NO_HZ_FULL) &&
> -	     !is_idle_task(t) && t->rcu_tasks_idle_cpu >=3D 0)) {
> +	    task_is_on_dyntick_idle(t)) {
>  		WRITE_ONCE(t->rcu_tasks_holdout, false);
>  		list_del_init(&t->rcu_tasks_holdout_list);
>  		put_task_struct(t);
> --
> 2.25.1
>=20
