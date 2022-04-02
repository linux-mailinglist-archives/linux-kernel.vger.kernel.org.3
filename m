Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A854EFF2D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 08:29:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238209AbiDBGbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 02:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiDBGa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 02:30:59 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0398427B38;
        Fri,  1 Apr 2022 23:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648880948; x=1680416948;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sBqj10dCO/KN9cc8n4ms0fcoI8dRI3jGHy+3jFPNRIU=;
  b=MJ6Qi4bR5IDPpXNsaNU5nUGWHTuk9nhXtEjMKoCq3DVWuFOpan+tbSml
   OtfzTpunJk4buG2BCAsykDYkntkpNEtcHnkIAM+jg0PT6ye6GRPZOh0WA
   w1sYAG294/YLLAEhRWSWQc5a5O0ju89ZlecqGAWmZOXB4GaBxnnNmuAT3
   8wBEhUeAJ6BF7isplnoOMIWMq9g5+oqB0SOHUSPF0UK5PpzeWX7r9LvVF
   I2aY1vZLZbIh5bjM9nmBQU12R19NIoxUhowJ8dwtcCW8JuGwwb6WeGcOG
   3BuTP37YjvxXInDdnZSsAhwyI+uB2Vi71l3D+5lzq/bfgppGDpBCchv5t
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="320980581"
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="320980581"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 23:29:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="789029050"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 01 Apr 2022 23:29:07 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Apr 2022 23:29:06 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 1 Apr 2022 23:29:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 1 Apr 2022 23:29:06 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 1 Apr 2022 23:29:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l9MGR202miTBkYyfsusGcGYTQg8GsC6WsN0rlu9Rufk7oICIhcct7nUX2yi7CPLlqoLi4a9swjD8u8jO850JJqvEwUZmZNXY7w6po7pCVnKcQSrQlRYBtBfHCgyROIo1gdIfd5NoRxS9CFQnPcXm0n3419h+aLhLDAWTSbj/bBX3C6OWxkJEQC5cN0zniIifMJ0jbwvWXc5t5xiZolNwdOrz0jwWa4dEGYaKPB39J86Y1slTp/GXkfZZ79ZJR1UeGucbe+iPzZLQB2Cnjax6iCgcNGfPlUpaEutCt0b6i5OShbNqfxyJlN+vL6hw11f7PAUyLZ7esv4nJ41b/CFkSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8cCBKAPpRYl2uTK+ktiK2JYLaEctPSH1fepeZ9au5A4=;
 b=me0P0wpbVkBGiLdrLTJmyN4P0jikbfrGGnoGG+gAC/3ZeDs3/drRu/zqSKsa0SsIcG5JemciN2ax1TycPQdhKE/0YJ3ACi0OS0Kp02zydnMfDiK5DOeY2RdmMQwYZLEYQRI/1m84Yxr9drXlBZRr88nPXTIDrdK+bIBqj+CgqmN2Z/WULeMy8ZtUCQjOEeJ58dbLWqf5wYUKbCPCPRrMCgmWR47a+qyyCxvE+dqZK/P5YME3kip9sSnp/Ro3OdyTx5f5T2+9tvM353bjQPqJz143Y2ea6eaPchRWhNkakUMc88wk1QjhxQ76IE/LCZpt9eNq0IZ9xHlO5ymizPhTaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BYAPR11MB2920.namprd11.prod.outlook.com (2603:10b6:a03:82::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Sat, 2 Apr
 2022 06:29:04 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::6439:b0f1:f43f:54d3]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::6439:b0f1:f43f:54d3%7]) with mapi id 15.20.5123.021; Sat, 2 Apr 2022
 06:29:04 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Put the irq work into hard interrupt context for
 execution
Thread-Topic: [PATCH] rcu: Put the irq work into hard interrupt context for
 execution
Thread-Index: AQHYQ/uAOn2CUwsFkEWWhrezlLtpoqzYXhIAgAAlweCAAT4HgIAAdE2QgAEUcQCAALfXAA==
Date:   Sat, 2 Apr 2022 06:29:04 +0000
Message-ID: <PH0PR11MB5880CDD975CC12FDF7BF89DEDAE39@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220330060012.2470054-1-qiang1.zhang@intel.com>
 <20220330201620.GM4285@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB58802C1246C6F4FB895BDDA9DA1F9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220331172943.GV4285@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880709B39EC5BDAACBD340FDAE09@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220401165524.GF4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220401165524.GF4285@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: 9d999e59-4755-47db-1360-08da147215aa
x-ms-traffictypediagnostic: BYAPR11MB2920:EE_
x-microsoft-antispam-prvs: <BYAPR11MB29200A5B1FA31F2EE548CCCADAE39@BYAPR11MB2920.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +5cEh6VOygjq9X5jTOvGwJ4cYDrjKK8hrBNGQQ12hVZVci1AeqQqSek/Iz6uPdMUPEtA95bxn5JyJjQpf5fS/SRS0Ws4qPtzJ5dpu7Z9ep2izVdrRNohNE1HnTXjE153l2HsiuW1+cqjEXmvGefTHgFz7UU2JvRp8f2u683yUkK5weqnz3iYbWFI2URdJ1YhYV5LjLppw5elS6/44aL39Ib/KDSsv5Hgce7V5asKv70AhMENfzrGfL1sssAhMYAJk1rKI8NKqfTM7NQd1nRii4Pc0Z16gOCEdz9CuHSNz6o3Qg8C+YrD70acp1ZwMTAt0xWlwr6/mt67N/fZ6blOkj6XnFH25mlr9h3sl/xZdHu8jHDg4jKp99iD4GUSQY3ViR579YpJrj7AOjwLVhTD0yMRdE4+XCKe1/RfPJK6BnVia2UrdMZHIYaxMLvFdhIusPU2Uybpb0Ona0FjR//BmUYY+HNVfOHBDhcs1EN+Rknv1KaV71eqvxG3RkiZjGUAiC09rZ22mFonWSYRIBfEq23VtdEanxZEIEvVGwPD0OAQdanI0d47qss09m9Yfj/0DhjT35BavEN1qSOlgfDdUOS9N1KICQW6uq7LkwcT3qHC6ejyvb+exV/3JgwLUJLQjd0+8cO6EgO3/xSg5iJwMLFIfXW5WQAo7Ia4inMPLouozXPM5dmrOSe+N+PpxqYI8IcwPQnuCKqc14qMJPbxVw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(86362001)(4326008)(55016003)(76116006)(8676002)(186003)(2906002)(38070700005)(33656002)(82960400001)(83380400001)(64756008)(66946007)(66556008)(66476007)(26005)(66446008)(5660300002)(66574015)(8936002)(52536014)(54906003)(9686003)(7696005)(6916009)(316002)(6506007)(122000001)(508600001)(71200400001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?miMZAGfl0RAy4EYqNZ5zxc56I5tl/Dchi64rrakaLdpY30ID047K6i4QHm0T?=
 =?us-ascii?Q?14s2HAIkHf9h7JR5CEK9GTHD7q7q+b2FeCmfoTtaMOJbYwRK6TYMrhYgCkmd?=
 =?us-ascii?Q?plm3wlnEABvZYupTimSTFOFgWfE3lsu/pQKikrOkJZW3CuvIiuORuNvv4AT0?=
 =?us-ascii?Q?yYDBFZ6u+5NiFeNn/Va6bidLJ8JJ43sr5J9LXFx7fK3+Q1KwVzkbbtZIiEmj?=
 =?us-ascii?Q?LPmehgr7GdxJw0bUbA3kHf2nLF6chfqUxVG08xhHj3DHeeNR1GIYilvp+bxc?=
 =?us-ascii?Q?jc1LN17QK6gHQM36TrGX72FOGkrZeDaVwos3RKo3MW8y73eblBNFAdASN8DP?=
 =?us-ascii?Q?0qOctEpPRD7Fn/fYPKCapHXFxIGu6p0lJmJSB/59ndG32sMKn4/MfeX5/mQe?=
 =?us-ascii?Q?94rBT71ZtP9fxhr3vPfciKlxZf/3R8f7Q8CylIE8QPi7+ABdeael4fn8k1D1?=
 =?us-ascii?Q?+BmpAUDZwbtt2saoIENDjzH9KRsDjIblhe45QW/T/gNVVuycK9ZQkN5HFlbC?=
 =?us-ascii?Q?xHeihXCNQy+UmygzD7+K2W9g8SqLVz6aycvMX7gWSfGmR3m9tbGDXmRMZkaK?=
 =?us-ascii?Q?UzM5v2y8O5MWKdcSMpcLPUfcu5HmJ1cXfCGXSZ4PLu90eXRvsoMkaabGGSxm?=
 =?us-ascii?Q?AxNepEuL7Zrxz9IVozXIxlWAGF+RT3Eqlpa4NEPKav3+kXb0PesxuGKzAn7h?=
 =?us-ascii?Q?YV7NFEYEUw1TM8IZ9GPKkwm2Ofhmxy5//49gkzSVlbmLAavxFmVfDSdSLnCz?=
 =?us-ascii?Q?jr6TIWTSZscuMKvazMtEV+7rAZJTbvu3CJssqgstEAYFhZhlaG3biyAtIjJ0?=
 =?us-ascii?Q?Z4bkDiRRgk+P1/uJ6nezBxKMV19swoHqEMqX0W2zEm25CWEBHpi8yiUZvD/w?=
 =?us-ascii?Q?aR9su8HAnGilFA1jUNLHQc2APMFiOdojJNqr1fzOnqGx1olta4wmrUfi4+tx?=
 =?us-ascii?Q?gVzATu7X+P3HWQOQDISXC5kufXNEXivTwy3jbCarbxzmRodPImLuGF8A10Hj?=
 =?us-ascii?Q?LEoGXr3Hr+PQxLY7J/6WA03+1YBUsKcNX74eoaw9yknTHupRMmMVKukJlXBy?=
 =?us-ascii?Q?j7vcJFt5h5hKNBgNijYyMe5rJyolgVQfWLOo1Uu4C8IP0UHwhrGPwBzwxHnJ?=
 =?us-ascii?Q?jnGFdYQ574X+z0B7qSWWSTjb5ye3OFug55kLda7CzLzMMwoyJda+sv/hUX1y?=
 =?us-ascii?Q?n/pLorusF4X5iGvPMk3f8CPYHyjjPKbGF6275DqcIDB1BxLd1JYwPNQCeCnA?=
 =?us-ascii?Q?kTOliLuJJ3pdartW772kDDS+tRnTvXrqqOYyBoLX5KAS6hxBXTcxg9X738eL?=
 =?us-ascii?Q?S7l2I4+AMruH2o9QbJzAWcW1Ztpv82svspSjlBxzL55+qkALnMg/az3B3txx?=
 =?us-ascii?Q?eQpMFcuBsJGM5j4AGW+WBVJBgdgKLFFC3IT0KW4LbPW5OR7SrDNGnIWYz+Mj?=
 =?us-ascii?Q?8LjNPoaVTUKwnJPOczx7VrQ2wlI0j+SnuRDf+QTb2Pp7JXDBuY+AOg1hqrpX?=
 =?us-ascii?Q?mJhMT+OjarVz9pKU6H7jxyuZ74eZqo8ZqAS/dlCfI20JazrHyU/gQqB/RCFD?=
 =?us-ascii?Q?POA/ODKWZWcT2UtDCcAUK8KU2wldHFFjX/R3jrQocdBQ8X1l4DAYmh7SQ9mo?=
 =?us-ascii?Q?IhYoANVdtOOqfRSXu6jgtw46QCdcwfAUxhui/69OkrvqZi3lKZ94pXwFEd5n?=
 =?us-ascii?Q?41i98xVeqUNo1Y8Oq0lLq8SayfkhVlg/qcBbgA6OqNS93atD7mKU8F0B8g0e?=
 =?us-ascii?Q?h4UQ3JiaIg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d999e59-4755-47db-1360-08da147215aa
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2022 06:29:04.8016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FeZJuhlcrn9NiBo8KES2f4BAurdAs26+wJKHW3SfgxpPh3L8pwzvR1OX89jZs4CuRr0/9Mk0yInFemvtNpEmwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2920
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, Apr 01, 2022 at 01:55:51AM +0000, Zhang, Qiang1 wrote:
>=20
> On Wed, Mar 30, 2022 at 10:47:05PM +0000, Zhang, Qiang1 wrote:
> > On Wed, Mar 30, 2022 at 02:00:12PM +0800, Zqiang wrote:
> > > In PREEMPT_RT kernel, if irq work flags is not set, it will be=20
> > > executed in per-CPU irq_work kthreads. set IRQ_WORK_HARD_IRQ flags=20
> > > to irq work, put it in the context of hard interrupt execution,=20
> > > accelerate scheduler to re-evaluate.
> > >=20
> > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > > ---
> > >  kernel/rcu/tree.c        | 2 +-
> > >  kernel/rcu/tree_plugin.h | 2 +-
> > >  2 files changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c index
> > > e2ffbeceba69..a69587773a85 100644
> > > --- a/kernel/rcu/tree.c
> > > +++ b/kernel/rcu/tree.c
> > > @@ -678,7 +678,7 @@ static void late_wakeup_func(struct irq_work
> > > *work)  }
> > > =20
> > >  static DEFINE_PER_CPU(struct irq_work, late_wakeup_work) =3D
> > > -	IRQ_WORK_INIT(late_wakeup_func);
> > > +	IRQ_WORK_INIT_HARD(late_wakeup_func);
> >=20
> > >This is used only by rcu_irq_work_resched(), which is invoked only by =
rcu_user_enter(), which is never invoked until userspace is enabled, by whi=
ch time all of the various kthreads will have been spawned, correct?
> > >
> > >Either way, please show me the exact sequence of events that lead to a=
 problem with the current IRQ_WORK_INIT().
> > >
> > >  /*
> > >   * If either:
> > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h=20
> > > index 3037c2536e1f..cf7bd28af8ef 100644
> > > --- a/kernel/rcu/tree_plugin.h
> > > +++ b/kernel/rcu/tree_plugin.h
> > > @@ -661,7 +661,7 @@ static void rcu_read_unlock_special(struct task_s=
truct *t)
> > >  			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)=
) {
> > >  				// Get scheduler to re-evaluate and call hooks.
> > >  				// If !IRQ_WORK, FQS scan will eventually IPI.
> > > -				init_irq_work(&rdp->defer_qs_iw, rcu_preempt_deferred_qs_handler=
);
> > > +				rdp->defer_qs_iw =3D
> > > +IRQ_WORK_INIT_HARD(rcu_preempt_deferred_qs_handler);
> > >  				rdp->defer_qs_iw_pending =3D true;
> > >  				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
> > >  			}
> > >
> > >OK, in theory, rcu_read_unlock() could get to this point before all of=
 the various kthreads were spawned.  In practice, the next time that the bo=
ot CPU went idle, the end of the quiescent state would be noticed.
> >=20
> > Through my understanding, use irq_work in order to make the=20
> > quiescent state be noticed earlier, Because the irq_work execute in=20
> > interrupt, this irq_work can be executed in time, but In RT kernel The =
irq_work  is put into the kthread for execution, when it is executed, it is=
 affected by the scheduling delay.
> > Is there anything I missed?
>=20
> >Yes, in that I am not seeing any actual data showing that this fix reall=
y makes things better.  Please in mind that IRQ_WORK_INIT_HARD does have pe=
rformance disadvantages of its own.  So although I agree with your words sa=
ying that IRQ_WORK_INIT_HARD -might- be helpful, those words are not suffic=
ient.
> >
> >So, can you show a statistically significant benefit on a real system?
> >For example, by measuring the time required for a expedited grace=20
> >period to complete?  That would argue for this change, though it=20
> >would need to be conditional, so that systems that don't care that=20
> >much about the latency of expedited RCU grace periods don't need to=20
> >pay the IRQ_WORK_INIT_HARD performance penalties.  Or you would need=20
> >to demonstrate that these performance penalties don't cause problems. =20
> >(But such a demonstration is not easy given the wide variety of=20
> >systems that Linux supports.)
> >
> >Now, I could imagine that the current code could cause problems=20
> >during boot on CONFIG_PREEMPT_RT kernels.  But, believe me, I can=20
> >imagine all sorts of horrible problems.  But we should fix those that=20
> >happen not just in my imagination, but also in the real world.  ;-)
>=20
> Thanks, agree.  I'll test it according to your suggestion.
>
>Very good!  I am looking forward to seeing what you come up with.

Hello, Paul

I use v5.17.1-rt16 PREEMPT_RT kernel and enable CONFIG_RCU_STRICT_GRACE_PER=
IOD.
When boot, find a lot of  'defer_qs_iw' irq-work is handled in the 'irq_wor=
k/0', the 'irq_work/0' is RT fifo
Kthreads,  it occupies boot CPU for a long time,  the kernel_init kthread c=
annot get the boot CPU to start
Up other CPU,  the boot process occurs hang.
Replace  init_irq_work (&rdp->defer_qs_iw) with IRQ_WORK_INIT_HARD can fix.

Thanks
Zqiang

>
>							Thanx, Paul

> >So if you can make such a problem happen in real life, then I would be h=
appy to take a patch that fixed this on CONFIG_PREEMPT_RT but kept the curr=
ent code otherwise.
> >
> >							Thanx, Paul
>=20
> > Thanks
> > Zqiang=09
> >=20
> > >
> > >Or has this been failing in some other manner?  If so, please let me k=
now the exact sequence of events.
> > >
> > >							Thanx, Paul
