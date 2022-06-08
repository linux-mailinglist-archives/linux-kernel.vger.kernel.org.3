Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB2D5423A7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbiFHD4t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 23:56:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiFHDyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 23:54:52 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FE3812E816;
        Tue,  7 Jun 2022 18:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654650120; x=1686186120;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=trjUl5qPx6Vw98md6RnSVsUiHZcg/BBBwtYbBWoTlFs=;
  b=QyEKFqahi6ZGQKLK+u1eSjxOOLDapVWT+uNvi9gNABfmHYNQof39t++H
   h4qO7ZNmY8EYA6DMo2gwmqH1mg5dFkcXDI0DnkIpvA6bmJ8HCFpWUV5B1
   0sfkZFxaDpqMGaFAKrNflykooEB0p9tY7PolUb5RgWu36bTycQXIrptBt
   sirdj9fUJ5TOUErhaIVvmAjEVH29DqJABeo4NnWwth7fPUtp+cUnnrDES
   v4PZpCY7WzM/8A1WoK0BR43SePgjIekuZwQ3X6ZPHjImCjZ27kZgDNMjV
   O9HLYqtQPvvAKpz92qFvqNWpfoUwmknH8iug2i3Gu3mEDheRUphHQJer8
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="275543220"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="275543220"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 18:01:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="532878395"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 07 Jun 2022 18:01:33 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 7 Jun 2022 18:01:33 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Tue, 7 Jun 2022 18:01:33 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Tue, 7 Jun 2022 18:01:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Tue, 7 Jun 2022 18:01:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2OPoyqga1tNhNsShKyZ8+SoZzF2/kKP7AIz3AQJ659eu/dnCKTeFaYvBqWdG4rFmI1v5d8bSZHY8wtGMDpkv6AW7QYNJU8goWuCoA3c0q2MOMgt4T7a1bU5ZBgEzC/E8dsA4W/Syhv+auW044STA2a2WxJgEn+axpRKmeujdi4Xv32Zbhyim1TlISY1MUIcQNRliZiLDDf/+DaOgM+uK1x4gb4jUgmkHaR+CVaANbeH82x+v5x+Bce3MxR5wvjkudhngEzZxPerLvMJIQ5khiDNXLPj7SNOHq1TUkN/hX35aujqBgjJkvJWdn92aZnyBm20LUhqZTxTgMCbquAM2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=teRHytD7w/v7AyEDnn7PEZdOMu/ni/E+HI8Q6vMaxIE=;
 b=dk6nHsb9msQz+7tspFE3RAqh/vNAF2rpxoqAUHLp50n2z/efKeYVDM9apWJn0LviPePGaFPWmCAkFcNFglPqdKaBtZBl3FEKdj7wPa0EH7I9WrWp5LfE+h1bjpJVecDSP1j2LLgWHjDyFvREd4jJ5K/63JAjzVRhcYLnlCThP2djABMj/PhpAFyqBKhXoTssPmdY0P/B1ZcZUDheVEl1NvwJ6tGRKopkCkjkET565wi0+yFl79PNmj1U0Aj0YyV0v+dxLkUQgU5z+9msVSo1xV3RfDQzgEJ6Fn3bQqBNdIsc874UkZY4w8K/8mhjxu0KdemXx4ccYssmGt84PUshTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by MWHPR11MB0077.namprd11.prod.outlook.com (2603:10b6:301:61::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 8 Jun
 2022 01:01:31 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72%7]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 01:01:31 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcu/nocb: Avoid polling when myrdp->nocb_head_rdp list
 is empty
Thread-Topic: [PATCH v2] rcu/nocb: Avoid polling when myrdp->nocb_head_rdp
 list is empty
Thread-Index: AQHYekOLcM/pjDOLHUOfGqJWFKxX8a1EH1EAgACISxCAAAiugIAAAQyw
Date:   Wed, 8 Jun 2022 01:01:31 +0000
Message-ID: <PH0PR11MB588014C2451C2E65E583924DDAA49@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220607075057.909070-1-qiang1.zhang@intel.com>
 <20220607161620.GH1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880551F642B1490CEFA65A8DAA49@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220608005513.GK1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220608005513.GK1790663@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: 4f68b033-72ce-4c39-7828-08da48ea6cd6
x-ms-traffictypediagnostic: MWHPR11MB0077:EE_
x-microsoft-antispam-prvs: <MWHPR11MB00771CEE9C1A46B2679F8534DAA49@MWHPR11MB0077.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lMQvnHlEwVjFJ0WVOvJMGbjLIKT+QMGAcQ5xGlKiklGk9QiaMXOmcdwwKuREVPXB28JAjGBcWYq6xCsjPUxWNQ4MZBYQyuH8NC5X8ZiXzbQVADAXFZL48O4VqZsP0GrDRlfcc72jw7KV4qXoWhzbBu0Q4F5inpDKc/cpo0XmXwXyXJYB1JT4CvauPGGQyQcA+Nm18ZclATI/h8cas9/vgcYbvOvD4oSUo5zNRXU8KIRblXDhmdS6/VoGprd88Rte27Kvd5wkk5GiUk9CwV1iZecgZs8oImA+iP4h6NLXeKikFLe4zjF5HhnvU3rXQw8MAOE1zX6yKfT6NO6WC4LPLk9pjzRfCo3313+IlRJ7g2AKimJNOX5eV8hvsbXu8Jiz5yJSeIN7nmcME4hq+PvC4bL/P1bNDASYc2pbF1nJtifRoYaiN0Sw1wHxEVmylFu27vQ9vqbUp9M2zPsqL4B62FRJ71DQ19k0kkQzctRpkeDAWF7PryJC1LbAeIG5MHb8aoVnCz7ACbfNARMwQWwkI+Ni4vd1WsKtR5YPDvym49JszuXdrds0CSbyhCDnjEe77nhvMwV7hVomUntWET7NNtq4dF4FgH12W4zIkphBM38eOWWOQt+WNAOClBneugVtMHHTV8/Gbggy02GLtrHk/Nrpsl0Z1nQ2ajt3h/+eK6UaaHVXEOZo13SpmNF9Un2I/9kH8bSkumj8FEJi8UnBvA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(64756008)(66556008)(66446008)(66946007)(6506007)(9686003)(76116006)(66476007)(26005)(2906002)(186003)(66574015)(86362001)(5660300002)(38100700002)(8676002)(4326008)(83380400001)(122000001)(71200400001)(8936002)(52536014)(6916009)(33656002)(54906003)(7696005)(55016003)(316002)(508600001)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?kxAuH8vCd0r6Zv/Yy0SBa0+wAWGbE7my6+C1eX1868X+bw9SJSRmU6F4b3bM?=
 =?us-ascii?Q?+l9vJMUs4xOTTPh/w0l+6fL2GV7j928/qC1e0UaigNkjKfrpwEwoH6d1k10+?=
 =?us-ascii?Q?7AZ0S42VuHDxAfoReBEx6dBFzb/wnrfE8onAUFwImyfhz5V+LeqB7nlurq6s?=
 =?us-ascii?Q?ewasAt+fJNfgcpvr15msbMDczeeCLetx4s2vhx+tm4Zz8lm1thiZcSDrIX4q?=
 =?us-ascii?Q?XpC9KSTtnWO/AewImrlqgvwICqDhleKzYgq2AnBh99K2oMNiT3Ljmo9NXUEQ?=
 =?us-ascii?Q?KlOox1vbkLye+U9B3B+LbNcA4WcKzaiVYJeMYLQa1ugTwB0QK9ZLKa6dI5RF?=
 =?us-ascii?Q?LUngQy+JPClnWqPWX9azxbYhAF5aav+10jBvhrSKP7ErU5g3/3MIiwFThSjL?=
 =?us-ascii?Q?YzkIRBWvZBuVXa75I8PfH3r4pBrpbRysmSPOT7ceFlO3BF0OvPovzq0f3Q3X?=
 =?us-ascii?Q?63UugNzBGIfbeLBjXD0frx6Jgg7pzZA5+q2JUUS51Da6IYNfLC94RVKtZIjo?=
 =?us-ascii?Q?+8UYnor8ofm1/VKmhQ4J7BYGD/+VYfYg98GN6FnGQXikX0+10+Q6x7ypzgRz?=
 =?us-ascii?Q?CJzv80RKtiaa/iRyFZOylg3GNHnD/LK9v97cr933RrmFKq6lPqaFzBxMZ1aQ?=
 =?us-ascii?Q?afovbMkE4I8DvV6pFEy9R9NlSjKTEa2MmvE7qEmoolRFqzTISxA/YDcDPqTj?=
 =?us-ascii?Q?4Zuuod7LNInFhP27D8DyvIZ3MX5tSfR/IlIFQScCagt6967O6W41T3Q6dTHS?=
 =?us-ascii?Q?YyJtT4AihmeTLjR+Ue8KvvooEiNvmPWo6j3BopmuOeI9ki2qLXSv319nfLLb?=
 =?us-ascii?Q?KDdpo5nD8CM2ZLeNmCByPaJJRNiQqpurmc7Gc2Uf65izMxx8aLYjotVLniOt?=
 =?us-ascii?Q?rh6WdlyYvqIFhnn4xWY5sMjiHEw4yh7WFPshE7B2q9biCw86lB2JNUFIz4pW?=
 =?us-ascii?Q?GfZSaURRU60F5Xbu8ponUwmTSgHRFclY0A3nCIQjylZBXMCmDVVwmBYYrSp2?=
 =?us-ascii?Q?F9SOBNc3YsK2l4XlXq59yT1c9TjC3hs4y5FX1tkuJXzBs5ZehfNHz8IpyjPY?=
 =?us-ascii?Q?k61kKCVY+WeMfxD/1uEraMk3Gag9a2fWIC63P3bp1kYdmarMFB+8WFsh83Tv?=
 =?us-ascii?Q?g39RNV9iNyre3Eo7PW7w3B8dSMV1uu5kTO98xgPp4mlTm9ns3phfRGlA755O?=
 =?us-ascii?Q?3giCn7ddOp/6KiBjzMupUKtilyjXSG9evy6vs93ZPXIXBypezREjOTkOLKIK?=
 =?us-ascii?Q?/r4VTJpSVksPftOz3Yy7hnYrIV/7PpXbQ4N1cd3ZHQo5ylUvsA/PMRAe1nr3?=
 =?us-ascii?Q?GQPfkomBW+lbMrbuWH36mI332p/TjJ/cOnYM4Seybuc9WfotuKIquXfqmKIl?=
 =?us-ascii?Q?ZJ9owQo6KCmdJ0Q6tm/eVKc1VOUL/EMkOA5QrJj/5ex/s8kLtJjwQDaRqSDd?=
 =?us-ascii?Q?eFiRG5icoAup8guldHzCaDv54TSXZMuAdd+AkQqTK7MzyYecB7bL2qE1NPBw?=
 =?us-ascii?Q?jL6VdcMf5/o/WaeP9wOtplLkVkKgAdHzmrnpz/+our76ni3qMwyykfOK/vUU?=
 =?us-ascii?Q?ENc/jhRiE4NcVdKn2i3uCz8vMuS+7PnHiZNJKrftSJCTgvwKHI0czUPIlgD/?=
 =?us-ascii?Q?Qg3HGaaKDEo1WTwN5xy5xzZEbVN3PBc0sQhQZDW/0m9ItUgSURkauSVvYjSN?=
 =?us-ascii?Q?cgcMyafSxe/DjelHmyAEHPIyuRkkJOjoANC2QISUWwQCoZlg3ZUYmycnkHx9?=
 =?us-ascii?Q?wmnvxxyt8g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f68b033-72ce-4c39-7828-08da48ea6cd6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 01:01:31.1263
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FVQcqzLVynJCF1AU6Rudb/uWS3ZXTEzSNtGKbR5oMP9uELqwu/cWXUMl5yE/j5+JgzhnlHKCd3B3Khf1o8qjfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0077
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 08, 2022 at 12:41:28AM +0000, Zhang, Qiang1 wrote:
> On Tue, Jun 07, 2022 at 03:50:57PM +0800, Zqiang wrote:
> > Currently, If the 'rcu_nocb_poll' bootargs is enable, all rcuog=20
> > kthreads enter polling mode. however, due to only insert CPU's rdp=20
> > which belong to rcu_nocb_mask to 'nocb_head_rdp' list or all CPU's=20
> > rdp served by rcuog kthread have been de-offloaded, these cause the=20
> > 'nocb_head_rdp' list served by rcuog kthread is empty, when the=20
> > 'nocb_head_rdp' is empty, the rcuog kthread in polling mode not=20
> > actually do anything. fix it by exiting polling mode when the=20
> > 'nocb_head_rdp'list is empty, otherwise entering polling mode.
> >=20
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> >
> >This looks a bit more plausible, but what have you done to test this?
>=20
> Yes , I have only tested as follows and I added two trace events.
>=20
> +                      trace_rcu_nocb_wake(rcu_state.name, cpu,=20
> + TPS("EnterNoPoll"));
>                        =20
> rcu_wait(READ_ONCE(my_rdp->nocb_toggling_rdp));
> +                       trace_rcu_nocb_wake(rcu_state.name, cpu,=20
> + TPS("ExitNoPoll"));
>=20
> runqemu kvm slirp nographic qemuparams=3D"-m 2048 -smp 4"=20
> bootparams=3D"rcu_nocbs=3D2,3 rcutree.dump_tree=3D1 rcu_nocb_poll=20
> rcutorture.nocbs_nthreads=3D4 rcutorture.test_boost=3D0" -d

>To exercise your change, could you please also add an appropriate value fo=
r the rcutorture.nocbs_nthreads kernel boot parameter?  Without that boot p=
arameter, your kernel will not actually offload or deoffload any CPUs.

I have set ' rcutorture.nocbs_nthreads=3D4 ' in bootargs.

>
>An alternative approach is to run rcutorture scenario TREE01.

I will also use TREE01 for testing

Thanks
Zqiang

>
>							Thanx, Paul

> Thanks
> Zqiang
>=20
> >
> >							Thanx, Paul
> >
> > ---
> >  v1->v2:
> >  Move rcu_nocb_poll flags check from rdp_offload_toggle() to=20
> > rcu_nocb_rdp_offload/deoffload(), avoid unnecessary setting of=20
> > rdp_gp->nocb_gp_sleep flags, because when rcu_nocb_poll is set  the=20
> > rdp_gp->nocb_gp_sleep is not used.
> >=20
> >  kernel/rcu/tree_nocb.h | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h index
> > fa8e4f82e60c..2a52c9abc681 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -698,10 +698,14 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
> >  				   TPS("WakeBypassIsDeferred"));
> >  	}
> >  	if (rcu_nocb_poll) {
> > -		/* Polling, so trace if first poll in the series. */
> > -		if (gotcbs)
> > -			trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Poll"));
> > -		schedule_timeout_idle(1);
> > +		if (list_empty(&my_rdp->nocb_head_rdp)) {
> > +			rcu_wait(READ_ONCE(my_rdp->nocb_toggling_rdp));
> > +		} else {
> > +			/* Polling, so trace if first poll in the series. */
> > +			if (gotcbs)
> > +				trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Poll"));
> > +			schedule_timeout_idle(1);
> > +		}
> >  	} else if (!needwait_gp) {
> >  		/* Wait for callbacks to appear. */
> >  		trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Sleep")); @@=20
> > -1030,7
> > +1034,7 @@ static long rcu_nocb_rdp_deoffload(void *arg)
> > =20
> >  	mutex_lock(&rdp_gp->nocb_gp_kthread_mutex);
> >  	if (rdp_gp->nocb_gp_kthread) {
> > -		if (wake_gp)
> > +		if (wake_gp || rcu_nocb_poll)
> >  			wake_up_process(rdp_gp->nocb_gp_kthread);
> > =20
> >  		/*
> > @@ -1152,7 +1156,7 @@ static long rcu_nocb_rdp_offload(void *arg)
> >  	 *      rcu_nocb_unlock()         rcu_nocb_unlock()
> >  	 */
> >  	wake_gp =3D rdp_offload_toggle(rdp, true, flags);
> > -	if (wake_gp)
> > +	if (wake_gp || rcu_nocb_poll)
> >  		wake_up_process(rdp_gp->nocb_gp_kthread);
> >  	swait_event_exclusive(rdp->nocb_state_wq,
> >  			      rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB) &&
> > --
> > 2.25.1
> >=20
