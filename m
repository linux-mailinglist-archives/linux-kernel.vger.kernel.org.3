Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA34483E51
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 09:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbiADIjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 03:39:08 -0500
Received: from mga11.intel.com ([192.55.52.93]:26250 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232797AbiADIjG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 03:39:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641285546; x=1672821546;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gjqMDbJYpaEh1xKhJ4dvkDgfjk46XCiOfpJBJguwJpk=;
  b=fSij1MPVlFETGYp75O7rU24XwxE8gnCXh0tUKsOqdydIqzctJ4ZFwRuF
   oQlGSIdYfyHYy1ioZnXpY3W/eBSFR1UoJJwrBqAeLR0ambfWixp4zb0vQ
   z0t9eFLjU2NQn9w2u5GpJb1+I0Tpj9a5ZiaCzRxetRs624yOHcumk99p7
   BgOtHwpH+U0iPet8SuxcTnsem84a4vc05NsSK4Gge6xq9msrQsgdrrdHj
   OvndARSnXx5ypIpndQJo5vRLOy4seVoXl/BVV51XAf1LE12cxzGgEmitf
   ZMQig2ljmWV8zWxqBCksU2NFDNkdr0fMk2oiHe6ZkqSmS19dK0wH6jAGX
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10216"; a="239724910"
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="239724910"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 00:38:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,260,1635231600"; 
   d="scan'208";a="760376780"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by fmsmga006.fm.intel.com with ESMTP; 04 Jan 2022 00:38:35 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 4 Jan 2022 00:38:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Tue, 4 Jan 2022 00:38:35 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Tue, 4 Jan 2022 00:38:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Saf/ULPcwzOU0dXATiVhKhHh+PiQeJ/6ky30KEEE7W4GIHjYjREJO4JqPttDQCr2D1P2zI43haIzwmuLHgUIXIKWm7YScW7Lct41OeigDm6Giy9SPjxOxeMGCST8Exkqdpkwi7MSDvqexgDdEHcFdXU6ixboVK7ZeCKMDz8yyDh1RBUHJ0To+EzA4gW7O69gW+aV8RtNqUxIQltM1a6+d+MVxtYPBsSGUIfa9TjzsiIhPWC96LFSbILcsHQDOjqcbyfoGY6ygPZOxjkUQfLTvjPUUFDzYuslTJMrzzJMHcNj0onNTJmqsq5XprF3/9KvaA3rf+c6kJichVdzW2wn+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPB9lHbfYeMr99M02zG5ney9etJqPu7mvRw05HOwrto=;
 b=MeqdZ7Kw2xAuFAlsNEiFHvTnAT+SkOLPhDKTMzIuzcxCuIcDCwA6XR2PgIMHpdDm/PI2gliA2CGW0A/nuRIFb+o/NhK7iQfrQhNXc1qar9HYblJalgmFQVtF7TnE6biv/776ce6DxfF67ewadoV8UBjHWZ6LKJ0iXm07StKTwy9BKx4pSesa6AjBhKz4sl2uIw42Kov6VToAYVQEZSZ7wYPJRGiRZHiYuYI+bqRcQNekbzwsIGTUEJUdoR3wqSoieV8wBVoj1Z5NLj6mY3RjYtTzaL/seBqLOkovRekcdENwYm4cpJWKrlwYBTSw1mnjBfvT0QIzUjKAUgDiry3NhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by PH7PR11MB5942.namprd11.prod.outlook.com (2603:10b6:510:13e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.15; Tue, 4 Jan
 2022 08:38:33 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::ed1b:85d3:1ae7:a4e9]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::ed1b:85d3:1ae7:a4e9%7]) with mapi id 15.20.4844.016; Tue, 4 Jan 2022
 08:38:32 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: per-cpu rcuc kthread are created only when
 rcutree.use_softirq=0
Thread-Topic: [PATCH] rcu: per-cpu rcuc kthread are created only when
 rcutree.use_softirq=0
Thread-Index: AQHX+8Gg3pvzIsNS/E+4asoIGfkMTaxOZikAgALqwoCAABWoAIABGxDw
Date:   Tue, 4 Jan 2022 08:38:32 +0000
Message-ID: <PH0PR11MB58809470102F4519610B6BE3DA4A9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20211228160510.2893362-1-qiang1.zhang@intel.com>
 <20220101164426.GA2408833@paulmck-ThinkPad-P17-Gen-1>
 <YdL3Vx6pq6YCL1kx@linutronix.de>
 <20220103143442.GG2408833@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220103143442.GG2408833@paulmck-ThinkPad-P17-Gen-1>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.6.200.16
dlp-reaction: no-action
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0e81acf-3055-4fef-abc9-08d9cf5d977a
x-ms-traffictypediagnostic: PH7PR11MB5942:EE_
x-microsoft-antispam-prvs: <PH7PR11MB5942FC376A86A56E0B1C6D20DA4A9@PH7PR11MB5942.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Xg7FTbYbBfM0T8C6XOuYjS2qpDdadp+5qxZfnTcaESo4xstboDZV7musLdIOqDwP+yff1qy3KS95nPvstQI9P5wDYZQgmqPXFrEP5jLQsaQabdsJuBqcjtDWEykk4kAt/OQhbY6F2oH3PFhyfzLF2RNEkBDaym5Dz3E5Osfh2X2hO6Ca/RVtflnWHJjqsqNNtBC2j+Lu7G3komwpBa6OzPRgHEnZwr1nMZWLjXPcSaenPK1tH2SXyeAN9thL03cw16RBEFlovR6bj9kVvwcK+t3ETG9+/dEV5Z/6GGHq2NRMJI7DYNvulxtwzL9OOwkhHzE3UtGIOc4ab9Ir0WpxczHBtjdVFdAYcI/cA5P7EChud/DT7dv7xTd2QMCYXx5fl0LMrL4Ji5fkMkLqF/CWlLg8g9NN1yhnx67BfLxk4d67k71rAi3BpZwTaxQycMMqNNIjnSpk8CK8/Fkkcc8xXrP+ny+fdI0edReq/7WZrpDcTk/+yIUBpZ73sT7t6zkq3iPcHdAS6AdE+26NIDZrsMSaavHBJk+NiR/OMH+SVShHSrnrkPg/cgle17jCWVLRlk/YZY0Uo90FFMPQVL3o7BU9uBmLo6YhQLWEZ+OncTp7wfjxJynNqXsBkKCbk4+pn8XEQMPMqiCokEyPduVruX6bWJj72BO54tr+77AQX58aXEHp8ADr/OyXRLiWO4veKOrgVTh6dfe9kteOcp8F1Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66446008)(5660300002)(508600001)(26005)(86362001)(38100700002)(52536014)(8676002)(8936002)(6506007)(82960400001)(316002)(33656002)(55016003)(66556008)(38070700005)(64756008)(76116006)(9686003)(71200400001)(110136005)(66946007)(53546011)(122000001)(2906002)(4326008)(186003)(7696005)(66476007)(54906003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6ATtf6AxCKfwaSA5OrDRfP1W7NW9rjzkVP5rrm356bBL/RbUySGsjLOn3yP7?=
 =?us-ascii?Q?Wb1zPfbK6ffdWUhwSzRoh4rz108Ay9iXIbxvinFtY5tsFw54wUJSXP+qAh8t?=
 =?us-ascii?Q?XyyO/oqBpPebbx3ccjPSde+nMSYLhGKZsEeP5ynuL/nJlMXu2ZbabROT4m3r?=
 =?us-ascii?Q?9GzDldT5APN2tB+S+VeDFpktnHcAwI0wQJDjvkp5tCzEeYK7s/OpnmsKlObz?=
 =?us-ascii?Q?6FtSXCQ0mUVdn+8iWhnGNs3BY3dobPq18jAUkefIsWy7cMUeJ0c52twc9rai?=
 =?us-ascii?Q?GoB/CcYBu5pJYsn7KQZJ7Fe9V84UNjEKk22vqTbYavkIGqCow5BQFQCFFWvZ?=
 =?us-ascii?Q?IQocsxLZHXTiMIOwvK1H8LS9u+3gjPfGS+vysgL8u37Nfdw5qxCEry/MtGpi?=
 =?us-ascii?Q?tKX1LJU5WUd6JPnwhvkPoEsB+kn1oV9IM7SSVKwWRFJ52n3qVOid+WSj1T9C?=
 =?us-ascii?Q?jzGUODyt0u7kQccK4HacqmBb0rUuR2YKXEX/o8Cav1LfvhD69PJbp2o56Qgk?=
 =?us-ascii?Q?fQr1CZvDBkAOtEFDHPFoEyYqrKtPpvw6MKVVN6Lw+o90CVWHj7q+V4NgilRT?=
 =?us-ascii?Q?SEY5nxe8tZLS19TUtEdAVl2IjKRYs+s7tvQ/hY8o11yT4Rnk63Z+6VTzTYyt?=
 =?us-ascii?Q?aCYanJe0sTQZHqZuIwErLqUHspXllO2VUYynp2wcFGVUecnmUqk0cmJAnp63?=
 =?us-ascii?Q?fPUOuedFXe51KMmTzyvC4vGs/hBwQGzMuP6O7KvH15Hyk7sRxtnL6Ni/EwXc?=
 =?us-ascii?Q?3n0pkIGLJ3C0nE1CIwh920TyKPigdhkKM4SEiPJ5Kay8fLPxd1boSEFk77Qy?=
 =?us-ascii?Q?ozZ875111BzOMK1Raxr0FNF7OC5dXlY71YACTl2DaucrRBIZI4q8Nhlqp2xL?=
 =?us-ascii?Q?WhzumSqT9MBT+IwZ2eiGSLciMw53X0BJulBjIPBLLY+2aGB26x6Ruou9f4K9?=
 =?us-ascii?Q?CgcPcdBtXXoJUGUfTpv+yk5CBFvabrE8ISY182HRFrXudQka7LHveEEwXmCN?=
 =?us-ascii?Q?sJZ0Q1P6vP1SuFTmo+GGhI0x5bZDiGHPL/erj+x3ik6eh8HFdiHnW/Lqeg4y?=
 =?us-ascii?Q?JzvYgoCrWcheoPxpDAw7I6ahbVD4oNGSGBLC7MF8UDmaXnZnQooukhjY80vZ?=
 =?us-ascii?Q?VQs3LrI3iBplMW97MbOGJ7ieLkfcIE3w/8lL7KRdzp66WXlDKHOeDNGQ2J9f?=
 =?us-ascii?Q?tXDAo91wdmp0T6g013CEMcq8uGt7fXuKd6l4TwueLLL5goWpVccGKbrOYC6a?=
 =?us-ascii?Q?Z4YaCuGUFUZjXjQK3IEcvaByI4fwTvNNLfGZqJQ6WqFrn7w+44t9aBtFIN1R?=
 =?us-ascii?Q?NxNXrEGQgpPp3tX7cezQpL2L40i7H1wFVM8DXI2NDnOSijhiqlLmBfesIn8B?=
 =?us-ascii?Q?n9M7/viIwWKOgxA7/SrR/rB8fNU9kxiyK1bALjacOfm1cMZb6/6dy8H+gTZv?=
 =?us-ascii?Q?nSjjx2+KUQAgwqAHLc98Kpy6iiQKTXtm3ZPNYeuYjmRQwiBQ0jQrdZcv/TXU?=
 =?us-ascii?Q?EGC24dvw1c1PAnUW6RwXDRFM9JKwp4fgjKMCwHti759PCMcHtw96GpOGPZdq?=
 =?us-ascii?Q?+Zft0oXG097a587l2UZX0kQSfs1dulg15KF2Ul5RbcqS7N62bwVZrNU8C3Dy?=
 =?us-ascii?Q?B4354uPLUTcfvF6DbN7Mo6A=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0e81acf-3055-4fef-abc9-08d9cf5d977a
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jan 2022 08:38:32.9006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Sj8fp7TBAOvd8RAq2U0ZQvhlvJGrMUXkj/dDf8lH3Cld1FruhLfriJ+fxNC0y/eFRu06eeGj2H9z+Th7uZ4BPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5942
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Jan 03, 2022 at 02:17:11PM +0100, Sebastian Andrzej Siewior wrote:
> On 2022-01-01 08:44:26 [-0800], Paul E. McKenney wrote:
> > On Wed, Dec 29, 2021 at 12:05:10AM +0800, Zqiang wrote:
> > > In non-RT kernel, if the RCU_BOOST is enabled, the per-cpu rcuc=20
> > > kthread will be created, however under the rcutree.use_softirq=3D1,=20
> > > the RCU core processing only in softirq context, the rcuc kthread=20
> > > doesn't do anything, so remove RCU_BOOST interference.
> > >=20
> > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> >=20
> > Looks sane to me, but adding Sebastian on CC for his thoughts.
>=20
> Yes, it makes sense. invoke_rcu_core_kthread() is only invoked for=20
> !use_softirq so it makes to create the threads based on this condition.
>=20
> Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Thanks Sebastian review.

>Thank you both!  As usual, I could not resist a bit of wordsmithing, pleas=
e see below.

Hi Paul , thank you for your modification, your description is clearer.

Thanks,
Zqiang

>
>							Thanx, Paul
>
>------------------------------------------------------------------------
>
>commit 6e68b781388cfaca95a07493a060c4a6e4ee5d0f
>Author: Zqiang <qiang1.zhang@intel.com>
>Date:   Wed Dec 29 00:05:10 2021 +0800
>
>    rcu: Create per-cpu rcuc kthreads only when rcutree.use_softirq=3D0
>   =20
>    The per-CPU "rcuc" kthreads are used only by kernels booted with
>    rcutree.use_softirq=3D0, but they are nevertheless unconditionally cre=
ated
>    by kernels built with CONFIG_RCU_BOOST=3Dy.  This results in "rcuc"
>    kthreads being created that are never actually used.  This commit
>    therefore refrains from creating these kthreads unless the kernel
>    is actually booted with rcutree.use_softirq=3D0.
   =20
>    Acked-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
>diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c index aeea5487632f7..5c=
0ffee7a43a0 100644
>--- a/kernel/rcu/tree.c
>+++ b/kernel/rcu/tree.c
>@@ -2903,7 +2903,7 @@ static int __init rcu_spawn_core_kthreads(void)
>=20
> 	for_each_possible_cpu(cpu)
> 		per_cpu(rcu_data.rcu_cpu_has_work, cpu) =3D 0;
>-	if (!IS_ENABLED(CONFIG_RCU_BOOST) && use_softirq)
>+	if (use_softirq)
> 		return 0;
> 	WARN_ONCE(smpboot_register_percpu_thread(&rcu_cpu_thread_spec),
>		  "%s: Could not start rcuc kthread, OOM is now expected behavior\n", __=
func__);
