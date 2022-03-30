Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EBB04ECFCE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 00:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351748AbiC3Wt1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 18:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351731AbiC3WtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 18:49:23 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D4C5575C;
        Wed, 30 Mar 2022 15:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648680456; x=1680216456;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=4My1AUsHng4+UOnB14zKb0zvS9pSmm9KIweqB2+AVbQ=;
  b=BTEr0OiDP0tGwBK9yv0qTwXLhtnqaHTT5eJBf1NRfiZnMXHiWxsO9Jgw
   O5duZOITDhG6b9KKyRt0Dmrwaf4mWalqGRvoQUhrcr1UqFOk94yiFg0ZY
   rgveAdr8j0ym4Ep0kQaZC6ydg7TU3McbckmISJ0BUHCROW6cktMeIPIF5
   tfG03rKX35SAFsgcWoRbkxM74VvsWvh7loG1LGf2BjszNW0vBC2UQuQrO
   bBhzGpGMHN1OvlpCJws1rIxEfPAPwbx/i8jME0NLEX8ydzb+7ZPC3qskR
   IHbXCVWHBr4g3FaQPj1I3GjR3dEIRPpOvISjxWcasv8VWcNp8QcGVLYbw
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="346099699"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="346099699"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 15:47:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="788177336"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 30 Mar 2022 15:47:33 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 30 Mar 2022 15:47:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 30 Mar 2022 15:47:32 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 30 Mar 2022 15:47:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SavQOepF17bzX3YgorqV29D7oRodu6V/3KChZ8uLaQq1xjFJqjmiF8ly1qAXhYkoRnTneaP82ci00cVjk6WpOBxlTfwZnuanTqErjkSlZ68FfTpe8Vxm3lpXV23U64cLao5poOB90lkjTW1S5chDq6dji9ZkuAv1TU5JPMg+AlbHNS28jTOOPzkTCcBITzNoGtACPJBE5phTJBLfDXBr7jwoC81J6lPqvvmO9qBGclQ9RJ3LbKsjlGGCgCSYAmzcj9C3Alz4tlJXhNl6eOlfInEXL+px8uYeZ07yGgmTAcC38Iko62G91vjqg1jrbj6OtSmHOUvxnTodGdYGpz3leA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=10paIMtKq3nImwooQyAqjceC3XijQHTrabU1goc6dI4=;
 b=PR8xISidY7wy2koYS67/pg3KFGQIqpV5slds61Ld8x1PGKfcAMiKe1znT1bzBP8tBaAfZ3KtxbwKFDYDM8zsyMWiGuJmfH0SxoZsmYtWpkFUb2tow2p6s5kp/CWDjde7+zqUUBe5OH72xAxzqRclQKB/LdXlIFZYRg+c72mhZyb3ERSO/6TjrjQmCVFlYjMjePbYwQ/I8XKqr2XgLeVE1/2EfgbcUMM51uLG7vHTaWxiTDjpa0ginh0w6xACU/ylfYpsowwHHAVuSr9Pc3UfD2YgYNJoKrphvi3KGSus99SqiSIW0m8Qpr3qCY+1O12yIXZyBCnItk3aCQanWpvQLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BYAPR11MB3431.namprd11.prod.outlook.com (2603:10b6:a03:8d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Wed, 30 Mar
 2022 22:47:05 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::d90e:5a21:8192:7c54]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::d90e:5a21:8192:7c54%7]) with mapi id 15.20.5102.023; Wed, 30 Mar 2022
 22:47:05 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Put the irq work into hard interrupt context for
 execution
Thread-Topic: [PATCH] rcu: Put the irq work into hard interrupt context for
 execution
Thread-Index: AQHYQ/uAOn2CUwsFkEWWhrezlLtpoqzYXhIAgAAlweA=
Date:   Wed, 30 Mar 2022 22:47:05 +0000
Message-ID: <PH0PR11MB58802C1246C6F4FB895BDDA9DA1F9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220330060012.2470054-1-qiang1.zhang@intel.com>
 <20220330201620.GM4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220330201620.GM4285@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: 6f6bf35b-d63d-4e4b-bc94-08da129f36cb
x-ms-traffictypediagnostic: BYAPR11MB3431:EE_
x-microsoft-antispam-prvs: <BYAPR11MB3431ACE2167EEF19D41EEAC9DA1F9@BYAPR11MB3431.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZtbilfPcmvr9dcNr+PBQGjMY+BnqtkA2JF+NkQkf84ZTonNzV27OlObZF3ABb7NiBZBycxTZ2ajg7oBryDNb61QDrmZ7QP2tAQuugQVMqR6u/x9W86UPIgRbhOcZiiVgSX9GoFwKHnWp78kzkwrTK7Dvn0cr2KrkVTIlkl9iTITCbSzDQNla/7uY5vr0/misdcMVhMXrTT4Tq1uL8yAuzWpbJVjCqH+LJew6qFo99sydCgOakuCtsGLikxeZv1pIV/n7F+DzHMbk3vE1b2CtfXg9pgQvwzPAzJ1EUWNc9QaOMhOmV7vq32wjpGrCSjRT+MA4v5CZ34UfhWzNZuuDSyBL6JLtJrVwQyNRf6Qs9e62qPDgqnyZJLFSxZF8G6y09z+TwU1ARnPN5T91/O9h1Kv+fOf/rY5Hl7EHCoHrQ0ZG2FCnv86rvkKxbF+pp7QrNLfw+1M514piGwUnC4tR2hqi3v9T6FgmJ+1hXcGiyzxrC8G4q59/DaCL9TeCKGnDwMuVHTKhbb1pYYo6H/GG8tmgqFcO1G4NNzaAnn8VI8i8xbaccUPgNQSbuQziPIaVk2CEqsZYgUcIKpmzSxzyPouPBja/RRr7ofiQZUtomCCHQH9tLVGfUXea64tDcR3vqjSczC9+krowaeV44NFl8kQoh00i2fKbQyIXR3pIlAB0Z/bTBmqw2iEjPbk3ry9qxWUp8kkP4jK9HD62gzfUzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(66476007)(5660300002)(38070700005)(52536014)(26005)(33656002)(8676002)(66574015)(186003)(64756008)(66556008)(66446008)(4326008)(76116006)(66946007)(2906002)(86362001)(316002)(82960400001)(6506007)(71200400001)(55016003)(508600001)(122000001)(9686003)(38100700002)(6916009)(7696005)(54906003)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WmqkVcv8uejcpQtbApFlTEbhwx+RehcHjG2lcs1r+fokejaFCoKTDyK9tf4w?=
 =?us-ascii?Q?wmSum7/Lvn78oQHf3epch6EtfOKPCUatL3c5+qKgesbgOLJ8Us3Ah3YTWTeI?=
 =?us-ascii?Q?aqIN3ZaVtjx+nrULiyaVevIUaXHPKpS30AqW4JMWoMpQUurfbDd03esiLmvb?=
 =?us-ascii?Q?Gk1KM/BIB7EtbHdhLgacQSlofDuYTM77Y+El0IgxguNJGyNd4osyjGwGxD1b?=
 =?us-ascii?Q?lY8DUzDEm4UdZGedJtU2BFBxi7d9KA9Az0V8/Z2IsBDr2zkw9JkwZBK0pR5q?=
 =?us-ascii?Q?+nsyp1SBWC1Ql+tEOq0pN1a2UCh2w8IJ+73IInSWDlpjg+5FEO1WIdgqBa1b?=
 =?us-ascii?Q?T+j51lu+sND5eMTZDlvLNH5Q/WXwAze9PuzlsmWRNUxlwLw/6NqQyQrbNCV/?=
 =?us-ascii?Q?OhGxa2d4FougX8v4iD1AI7gEt9CQaeflfrNbZcTXp001grBOS5bfryo3oFXB?=
 =?us-ascii?Q?EkngKbBmTAw4NE3IGCPwP8ao6T5OAZZKwsnMLUckVpOr+IHKypJJ8qJUVDrP?=
 =?us-ascii?Q?QO8gz0ElgB+vByS6Eb5lVkrgoDkkB1mt3nhoZ/+z+EeT8TbUuMbQp8SSMvsQ?=
 =?us-ascii?Q?JQ1iGug5GGpmWzafnnbjWY7l9OR64rpYngP0uFcrZF4qh6GGOjHEHJ0NZogp?=
 =?us-ascii?Q?Nl7Ewj+4rJBbmuumeT1W/6xVRF8Y5ENhvYuJ7VSGkgWkq9Y+gMk+E8UTearv?=
 =?us-ascii?Q?WFN49O28Ewks3bB1DAvMbMKvW8rZ9dj+L2zDvaDrqGBaurM8bNmT6JT39BRC?=
 =?us-ascii?Q?vu/7N5eEHGuROwTws8IJXJl92o9z6RCP/uvRQ9WDEa6dwPt/bmTdION23EIk?=
 =?us-ascii?Q?Ci6nqDjks2WaYQpTO454TCuLHDYgcru/fbI8n0Em+Dh4DzbtyRorCgqOr0OJ?=
 =?us-ascii?Q?cuUybQh9cK9Lrn9nJA7nHMCKNvnyMBCz+rZSXLOGacv23qrpcrOAkyRRIgAb?=
 =?us-ascii?Q?LgK4PllWYyxgwcxq+ZcI8pR49KFPM2kIWcWGlSbAUtrjeSzHZthidnL7K6me?=
 =?us-ascii?Q?UWYshIw2xb2zityfiNOTiayxMslITo3xwBZlewgw2rhYw1D6TNfuq3CQlO0Y?=
 =?us-ascii?Q?u/UN8zkxQOg/dI+FTutNfJPQSzXEqiMigilIbE3HP8dgAg1SJhdafQCg2pfZ?=
 =?us-ascii?Q?3OWHnp/RswaiCvE8e5NOwVDQFLPx4wtczk813vW/MO1SlOcztpZTyJPa3Pq3?=
 =?us-ascii?Q?29g75M7hvaqbifrUXEzrdCRuDTVPvDQEJv0Xb/KHosxCgRr73OKqEXMx+3wZ?=
 =?us-ascii?Q?B14U1uSzGkHNzv//tAptZWb3AluJbw4woaLBep0XlBBpEou5RnqW/q4E+M+I?=
 =?us-ascii?Q?kagOfBHK6MaQt3IOtfDDFH/SzqLm+fST/qvFVEO1IF7raksBbDj+d9PetPPl?=
 =?us-ascii?Q?OGbGKGc5WXnpIhHVOTAVZg6abqT6W5Dl422Zj4Lc3jhFyt7gSzPavT0O2FKd?=
 =?us-ascii?Q?sSRN+X6Gc5VG2H1ZoyO0Xfl6fAnV+evpPwLenYCkxaiTjRoMjOaivDc2Efrg?=
 =?us-ascii?Q?9Zyim3dL7og9Z9iSz0jcsA/sCb/PcG8oyr8tkElEWQrJXRUoTEnIEmRONRaw?=
 =?us-ascii?Q?sTVyVO/WuvNQ8AwdxeRB8nMtc/o0xFwHuTfh1WLTEivz9RzWhjtL4vudFGvz?=
 =?us-ascii?Q?E0YLjGufpwOoEuUDqo6NtX0XAXhR0QgFTbzS4jmdZ6R2Y6d59Ki3OKKj78ov?=
 =?us-ascii?Q?F6hv1Z7oo6K2MpHgY4qH0Sgbnh8OPOEnhqvjMYsjFk6PaF0NQYkThvJN/wPu?=
 =?us-ascii?Q?kG1ckPJJNQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6bf35b-d63d-4e4b-bc94-08da129f36cb
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2022 22:47:05.3987
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zH7VRhRwJV+BqNSbw9Ryg01zRm3rt+GHFzdL0OwFFZwIdxzJw32YYmDa+XLTB7nuY3Z8j/hZMRVP2TKIMz88mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3431
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

On Wed, Mar 30, 2022 at 02:00:12PM +0800, Zqiang wrote:
> In PREEMPT_RT kernel, if irq work flags is not set, it will be=20
> executed in per-CPU irq_work kthreads. set IRQ_WORK_HARD_IRQ flags to=20
> irq work, put it in the context of hard interrupt execution,=20
> accelerate scheduler to re-evaluate.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tree.c        | 2 +-
>  kernel/rcu/tree_plugin.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c index=20
> e2ffbeceba69..a69587773a85 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -678,7 +678,7 @@ static void late_wakeup_func(struct irq_work=20
> *work)  }
> =20
>  static DEFINE_PER_CPU(struct irq_work, late_wakeup_work) =3D
> -	IRQ_WORK_INIT(late_wakeup_func);
> +	IRQ_WORK_INIT_HARD(late_wakeup_func);

>This is used only by rcu_irq_work_resched(), which is invoked only by rcu_=
user_enter(), which is never invoked until userspace is enabled, by which t=
ime all of the various kthreads will have been spawned, correct?
>
>Either way, please show me the exact sequence of events that lead to a pro=
blem with the current IRQ_WORK_INIT().
>
>  /*
>   * If either:
> diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h index=20
> 3037c2536e1f..cf7bd28af8ef 100644
> --- a/kernel/rcu/tree_plugin.h
> +++ b/kernel/rcu/tree_plugin.h
> @@ -661,7 +661,7 @@ static void rcu_read_unlock_special(struct task_struc=
t *t)
>  			    expboost && !rdp->defer_qs_iw_pending && cpu_online(rdp->cpu)) {
>  				// Get scheduler to re-evaluate and call hooks.
>  				// If !IRQ_WORK, FQS scan will eventually IPI.
> -				init_irq_work(&rdp->defer_qs_iw, rcu_preempt_deferred_qs_handler);
> +				rdp->defer_qs_iw =3D=20
> +IRQ_WORK_INIT_HARD(rcu_preempt_deferred_qs_handler);
>  				rdp->defer_qs_iw_pending =3D true;
>  				irq_work_queue_on(&rdp->defer_qs_iw, rdp->cpu);
>  			}
>
>OK, in theory, rcu_read_unlock() could get to this point before all of the=
 various kthreads were spawned.  In practice, the next time that the boot C=
PU went idle, the end of the quiescent state would be noticed.

Through my understanding, use irq_work in order to make the quiescent state=
 be noticed earlier,
Because the irq_work execute in interrupt, this irq_work can be executed in=
 time, but In RT kernel
The irq_work  is put into the kthread for execution, when it is executed, i=
t is affected by the scheduling delay.
Is there anything I missed?

Thanks
Zqiang=09

>
>Or has this been failing in some other manner?  If so, please let me know =
the exact sequence of events.
>
>							Thanx, Paul
