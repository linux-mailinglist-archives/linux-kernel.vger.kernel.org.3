Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3AC4EE5D8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 03:56:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243894AbiDAB5q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 21:57:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233627AbiDAB5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 21:57:43 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAB41925A9;
        Thu, 31 Mar 2022 18:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648778154; x=1680314154;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QiD7b2hjqJ3TZWo1bNgev7iGSizl3kBp80iai3jo8CY=;
  b=AkOkoFXAKMYyQ2CcSB3GW2DqcPVbTVpj/GmRvcID29BGyveTtiaEEn9o
   tutmBTw9KGWIqGqMtfeaqGrq1TI7ggf5bvX5XNEdnGnnuYXfm0YFvdx+w
   XZXocDzAprGp6sAhK6XUksun9xbXZJ9DV18Khbr0KrnKapCwN+ayMkobT
   AFODgzG3lVrM5yZ1OE7HXikIPue1bxmcJWSqPOBjjGWm8cxjU1AE2MzrO
   EbzokO8G7iT824bomWeG3bZNFwDode8WeQ4Sx+O+0+d96qt5Q8cbuhG/g
   jxLx/tpTK3jSssDCyuMofbmZo55OzM1aD1lEjpZxL5ex+rvYlY5lEv7tE
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="242168421"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="242168421"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 18:55:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="720706062"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga005.jf.intel.com with ESMTP; 31 Mar 2022 18:55:53 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 31 Mar 2022 18:55:53 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 31 Mar 2022 18:55:53 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 31 Mar 2022 18:55:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WsBpD/yKQwb3a5L/L2AUicTjskYhVxc/jVlEk6/qg2Uueledm37ZiaVNTlEG9xx1ZyqvliQoD+GCDA0i6tq9txTnzmLjIg+9LszFCEaEpncLwUx0t6uHp7AUeeJ0lfbd20OHA6mgUdH3Yif8UKVAGr6+0HPK2GOqXeway16iLShyjKAS31hI9OgJRd3EHAAd+I4yDeomW+V3uiGT+hf2EiE9gqJTETXV7xyR991yIIAYZGQM1EwASqQhJuztCaqIBzNCkL+HzgW1dN5rM6sNnhC+6fKmS3jGCy1tjzfU6/mXZohbnfl/8YPXQAxoq6HuFWCnKEFFIGrOVWED0Opf7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5p/8HMjpfbDLIK2Onxy6+DzB35Eo30gz5r1lM6RAX4k=;
 b=db5NwKctiGKt6N71eQT6OkzyKsQh2hbMj+ZeDr3vne5B9gNJYL2U+3dJ4x08XcXzeX67UlkFcRvoxoXtHmxrIZ+7C60i0xWHdcjSp2UnhuUFSr3VhToRRc3oRj+dxSqxyWAPXvva6ZOhkyF8CKtelPxKYXMPd8rYCE0vvfHD5lamGUESn8Q54VVwzV6zL/nDdc4m+LSEtqGngsmFy5fmnwgvHtbw7/TWZLN2gen3wn1XOKW4puzzqWVl8gUkUZ22XS9vnDBFJjJVIqBzrM52oJqQscUJU6oDgLRDWAwE6kf2SdWzx4ej2UylKiP87FrdDA9DwOOEE/mbfyWdxDEs+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BY5PR11MB4308.namprd11.prod.outlook.com (2603:10b6:a03:1b9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 1 Apr
 2022 01:55:51 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::6439:b0f1:f43f:54d3]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::6439:b0f1:f43f:54d3%7]) with mapi id 15.20.5123.021; Fri, 1 Apr 2022
 01:55:51 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Put the irq work into hard interrupt context for
 execution
Thread-Topic: [PATCH] rcu: Put the irq work into hard interrupt context for
 execution
Thread-Index: AQHYQ/uAOn2CUwsFkEWWhrezlLtpoqzYXhIAgAAlweCAAT4HgIAAdE2Q
Date:   Fri, 1 Apr 2022 01:55:51 +0000
Message-ID: <PH0PR11MB5880709B39EC5BDAACBD340FDAE09@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220330060012.2470054-1-qiang1.zhang@intel.com>
 <20220330201620.GM4285@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB58802C1246C6F4FB895BDDA9DA1F9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220331172943.GV4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220331172943.GV4285@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: 3253a90e-9b00-4047-1b18-08da1382c027
x-ms-traffictypediagnostic: BY5PR11MB4308:EE_
x-microsoft-antispam-prvs: <BY5PR11MB43089717F328967FD43CCB8ADAE09@BY5PR11MB4308.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OJlR/C2uNnoLx4LhbFnK/qk8+g4sgTg1RKJn14KG+B407qDxEsrZKfqL/jJ27Ne4ap385blBhq0IGhKxzok4z3V9MXi9+R4LbOt659x18Bko/mC1Q4f96gEfm7KdMe2JKOwx0uwFxoQrqIY/VLdt2jjRsEh12SfpgA1MupIxYErU2CSj8iwcdzjh/LG7JQnLInGnE//hCtJttg1uRgdHjX6FqaPRxiokDg1wcF6yham6QSXfvUAwFadpTh8SPAyJDovTl6ixozHlAAYKWvmf2VwfCofqId7sgrKWCKgLM5fCQG/m7WGmm+hDHUuLvo1gBj8skZCX/ZsX7Puc0vKQbc3tzReInp1+PLx4ReE2IqtpJcEqdkt0ts+CnrOnDy5jEwFmRwOXa3wrlEuQyGRpGKQusJsYurjRuxwKYn6IFRIF2RgsSpk/w85by5sR+/ul7bYuG+5t0yXyWOWnCTcIZ71sWZq+EH9GDfv4s+nu9KEcbQSwMMjVPcg2CZofoTg+A+REWbtq5x5HIY5Rt59V4dJnCqSHnjlx9hwuAWJbiS7fwo5unqBmExrDuLa7aS4Vj8XOIhlOrIl2QWz71dUZhrpR26dP33HwZ00xHW6aNCh8gK4/2wRttjpzG3PJa/pKF0pQ8iDi3oQtHxZL9BA82nYCAXaXF9ZVbhHNCtQ7vl+0DV2hzDdZVxG8ipDwx14nbTC8vt1qV3zZ1ipDVYZ8mA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66574015)(6506007)(186003)(55016003)(76116006)(26005)(5660300002)(8936002)(508600001)(7696005)(9686003)(83380400001)(52536014)(4326008)(33656002)(86362001)(82960400001)(66556008)(66946007)(8676002)(64756008)(122000001)(71200400001)(38100700002)(6916009)(54906003)(38070700005)(2906002)(316002)(66446008)(66476007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FABdoArYEu9ib5859WdOj/dM/M4+C7qAUjPdULD7wkwdm+AIo8zUyDCLJdjt?=
 =?us-ascii?Q?vxGOeqj/p5YK5BKiRcT9KKaDKFIbme1aFLr6Ze80SqC9H9w3gCZp5rYw/zJA?=
 =?us-ascii?Q?ay7KdbdqxRiNFJ8ObnobrGi0ss0nNXev7uK5IeplNVsCmqSK/yS4+XNMp1Ov?=
 =?us-ascii?Q?KnxSyDbH91+C0LpA55rTfBkcW+UXEnbo3RDZ2lbX/czzLe1ldXPOgDIerR/A?=
 =?us-ascii?Q?+IzZYYti+tN6WxNXfhvWmN8bCkXN0fe7jJy2nx9VINcDN9WZHRZnQOYvLoij?=
 =?us-ascii?Q?PghXVGHTRQO0BkkDXJEGfh+HKiwvYPMunPQoI2L6O5/sbYw4XlXnXJoGiqqq?=
 =?us-ascii?Q?6bAMwWpUpcPGAblUXKYTRQHzzsqkae0HDu+yAQ5yB6sPppNcOQXXZURhUDL+?=
 =?us-ascii?Q?oKhNg9nAsyb7dby1RbUdR8WZ5oYPcfwbDlK2VvGN/LLMcSNTeha5496/cF8m?=
 =?us-ascii?Q?0Nn+IXKIwXjw+G5/0uL2/RDDv5hc27e0kyxNj7WYxf00tW6Ilq4kxXj7mW0S?=
 =?us-ascii?Q?gytRkQ5VSSj+/wyhcxWqQbrNB5migKeoIhok1v57+3jdi/rR5QIlhTXTfYlN?=
 =?us-ascii?Q?xAJHU14epMToMWXG2NDjKa4GX32rJKWUebku1J0F5LikXbBX4aknMEBB0t5M?=
 =?us-ascii?Q?0vIxFma2C450ovZ9KC+V159aHeFyNGZx0Okyfpkzjs85kXObKnchNSM4XqtV?=
 =?us-ascii?Q?6HkFKVSCswXECs4+VmFHfzL1L5VdkCNs0dLqKm6BhGlZFv7M65dDJhE1hAKa?=
 =?us-ascii?Q?u+U2Wjh/QkO+o4BOFsnL38EylxKW25RpM9gFA9rI7UZ3lDOuqujyN+n+CgbK?=
 =?us-ascii?Q?Wy2v7REqyUkziHpqLh3+YFP14evXn2LyiYFtNXSXQMRZmzGreEGSWNvPuALy?=
 =?us-ascii?Q?pLW7e8oj8pY5vEizbJSLZnXSHFulYS+X1U/51GQiWPrtGMnWfm0Mifd1v7zz?=
 =?us-ascii?Q?vjmjorWqE9d+9Kwh756jyMEEZk7BQCU2s30kx7eLVTVjlcBDIrx93Qeb77b2?=
 =?us-ascii?Q?la7+No4JDNzARZrqX0Uy9/tXPwZV6RT02WfOJqo8cC5C6/+Mm5IXmeGZfxIx?=
 =?us-ascii?Q?xsbfbwIaegH75ABgdgiTvAazllH4knUjagwk7Nkc+ijtz3AMHIfLnr2ZRa43?=
 =?us-ascii?Q?aybmjF1P1xN484t83tlAWgD0kQe1U1KOsuOsZ9CReuC+zZg/N5ClCRia6A6x?=
 =?us-ascii?Q?qBUfyjcEvOyUWKnTsU+glNFQUjzfetzDvZwr7adUr5j3hqjDSg4VwMXm9Xl2?=
 =?us-ascii?Q?wykP+D5qvxl8qF6W2YDpeTF31PpYB53XNhQsR88caEn8n28NxMV6x3idGFt0?=
 =?us-ascii?Q?a4c2bEAtoVCFQAgGQy1rkvD5NbNxYGvltO3KdMLiHA1wga1PUgZ8G0usG65o?=
 =?us-ascii?Q?VtnqPV+KRyEpCTwX0Qr68LxZObuTLZaefe8vEy/I4ZqgiHRNzz4yRh5vGK1O?=
 =?us-ascii?Q?jvzSP6i/2b4PFBBBzHz6ojyUWwU7bak3s/cNsI3YN92sbxNOScKCtHg09+kc?=
 =?us-ascii?Q?QoyMLcrAKx/XE+paiP+r4BB75eFCKBA7GjozfwGcxcToTxC+Iv4eCu4aelp8?=
 =?us-ascii?Q?XoX3dH3Eb5SIkeK+yVIUvMvBCNu5LWknmSQpObNdXxYoZqQv9i9+fXN7ebWK?=
 =?us-ascii?Q?VpQjUDaR7O7PTVP4KfAEucIrLCVDgduK+geAhpuBRJ6ztVlV2f7wBP2HJ30D?=
 =?us-ascii?Q?Ibvw/WrTteLIHIcBehCbvC+RbgI78kn+OPzXxFuFP+vtVgai8dwyPZgELqIB?=
 =?us-ascii?Q?OG0sjeGwaw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3253a90e-9b00-4047-1b18-08da1382c027
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 01:55:51.6185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RWbGxBB65702ySPlum8Dc6Xh5Lyf9lA48yTVU+OyxB9RkbC8+kn0qtJ9vYP7UsPrpiqqD9MRiC5/POrRKn4K/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4308
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Mar 30, 2022 at 10:47:05PM +0000, Zhang, Qiang1 wrote:
> On Wed, Mar 30, 2022 at 02:00:12PM +0800, Zqiang wrote:
> > In PREEMPT_RT kernel, if irq work flags is not set, it will be=20
> > executed in per-CPU irq_work kthreads. set IRQ_WORK_HARD_IRQ flags=20
> > to irq work, put it in the context of hard interrupt execution,=20
> > accelerate scheduler to re-evaluate.
> >=20
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > ---
> >  kernel/rcu/tree.c        | 2 +-
> >  kernel/rcu/tree_plugin.h | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c index
> > e2ffbeceba69..a69587773a85 100644
> > --- a/kernel/rcu/tree.c
> > +++ b/kernel/rcu/tree.c
> > @@ -678,7 +678,7 @@ static void late_wakeup_func(struct irq_work
> > *work)  }
> > =20
> >  static DEFINE_PER_CPU(struct irq_work, late_wakeup_work) =3D
> > -	IRQ_WORK_INIT(late_wakeup_func);
> > +	IRQ_WORK_INIT_HARD(late_wakeup_func);
>=20
> >This is used only by rcu_irq_work_resched(), which is invoked only by rc=
u_user_enter(), which is never invoked until userspace is enabled, by which=
 time all of the various kthreads will have been spawned, correct?
> >
> >Either way, please show me the exact sequence of events that lead to a p=
roblem with the current IRQ_WORK_INIT().
> >
> >  /*
> >   * If either:
> > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h=20
> > index 3037c2536e1f..cf7bd28af8ef 100644
> > --- a/kernel/rcu/tree_plugin.h
> > +++ b/kernel/rcu/tree_plugin.h
> > @@ -661,7 +661,7 @@ static void rcu_read_unlock_special(struct task_str=
uct *t)
> >  			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) =
{
> >  				// Get scheduler to re-evaluate and call hooks.
> >  				// If !IRQ_WORK, FQS scan will eventually IPI.
> > -				init_irq_work(&rdp->defer_qs_iw, rcu_preempt_deferred_qs_handler);
> > +				rdp->defer_qs_iw =3D
> > +IRQ_WORK_INIT_HARD(rcu_preempt_deferred_qs_handler);
> >  				rdp->defer_qs_iw_pending =3D true;
> >  				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
> >  			}
> >
> >OK, in theory, rcu_read_unlock() could get to this point before all of t=
he various kthreads were spawned.  In practice, the next time that the boot=
 CPU went idle, the end of the quiescent state would be noticed.
>=20
> Through my understanding, use irq_work in order to make the quiescent=20
> state be noticed earlier, Because the irq_work execute in interrupt,=20
> this irq_work can be executed in time, but In RT kernel The irq_work  is =
put into the kthread for execution, when it is executed, it is affected by =
the scheduling delay.
> Is there anything I missed?

>Yes, in that I am not seeing any actual data showing that this fix really =
makes things better.  Please in mind that IRQ_WORK_INIT_HARD does have perf=
ormance disadvantages of its own.  So although I agree with your words sayi=
ng that IRQ_WORK_INIT_HARD -might- be helpful, those words are not sufficie=
nt.
>
>So, can you show a statistically significant benefit on a real system?
>For example, by measuring the time required for a expedited grace period t=
o complete?  That would argue for this change, though it would need to be c=
onditional, so that systems that don't care that much about the latency of =
expedited RCU grace periods don't need to pay the IRQ_WORK_INIT_HARD perfor=
mance penalties.  Or you would need to demonstrate that these performance p=
enalties don't cause problems.  (But such a demonstration is not easy given=
 the wide variety of systems that Linux supports.)
>
>Now, I could imagine that the current code could cause problems during boo=
t on CONFIG_PREEMPT_RT kernels.  But, believe me, I can imagine all sorts o=
f horrible problems.  But we should fix those that happen not just in my im=
agination, but also in the real world.  ;-)

Thanks, agree.  I'll test it according to your suggestion.

>
>So if you can make such a problem happen in real life, then I would be hap=
py to take a patch that fixed this on CONFIG_PREEMPT_RT but kept the curren=
t code otherwise.
>
>							Thanx, Paul

> Thanks
> Zqiang=09
>=20
> >
> >Or has this been failing in some other manner?  If so, please let me kno=
w the exact sequence of events.
> >
> >							Thanx, Paul
