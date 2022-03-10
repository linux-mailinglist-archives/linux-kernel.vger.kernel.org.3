Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CCF54D3F49
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 03:38:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236559AbiCJCir (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 21:38:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbiCJCip (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 21:38:45 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 351C16306
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 18:37:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646879865; x=1678415865;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Cqm3FX2i/xk+CnkBN0A1lH1psgcPHdPddbai3APA5gU=;
  b=H/s44VcE26pew+PGe2VCwCOQ2s5CzKp8JXK5fez+ROKa+dZSo67LuV+Y
   w8HLTb01CbqJwuXitdZHUsYMusD+T+BcXllWqBq6VimUAdZ9yQk2PbqxH
   v9r4Aoj4bBrhoMVnIxTciq2AgUAAV8zCC6nLlFSmshEtnaEhgdSSwgr9f
   Jc25i9bgz285cv4X4FBRsmjCCpZnfZMPZXNZxSCJdxERIPD74G4taWJev
   uAXGJDk36eNysiOlADudaE/dHkGmInNSf13MGVjmcSARR9lt+tDAZy7uh
   fxkbWWNFDnKG5mOJRBhIVJsLAFNivqR0f5MjIFTJwwBHEYMRI8M+kwJxg
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="235093132"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="235093132"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 18:37:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="611588011"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by fmsmga004.fm.intel.com with ESMTP; 09 Mar 2022 18:37:44 -0800
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 18:37:43 -0800
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 9 Mar 2022 18:37:43 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 9 Mar 2022 18:37:43 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Wed, 9 Mar 2022 18:37:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XhlaV8I874T0u0Th+pdFRvvXzNtOQ0NoZAQ37fsaLKKINwMxb8YlLTgA23Ezg9oggtI26EtOPxASQfA70H+ZJqbpmLdj4zfkeateor0TBp0ZnLmLzomP64cVbQnY/0SsmMHLZ4TBs8b4V5k05ERmvTGVDjhYKLUiYqfybY2S6LgRL6QfjU1ZLazzFCgGXp16mm4uApxX37PEvtHza+hYBXipqgxFHZw7RzET1m1EO5xQjIAsp++jiA1jeLByDBzehu2oPPQqxeaCKzz/4CRUZYdvn9K221YQv3A4xMKJVzj7d6DMAH5I2qr06+QLIx7m+JiJWUDAHwkuEqlIcP9L+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W5wIRs5VzWZ2fJYcb7tWgU+HaXQs9Frbs4ZYSIEToIA=;
 b=Rkv11EpgjxG18IwfBQzJsMjrcV7r2Rq1Il+6GaC+CnwXMWokYSoXupIiP6HxK4yVGi8uLy7OHqYzdXOSY/rcAmTiWgaHY4icePCFxrHicsOLKTIFm8Q2HnUUKVPpHT9C/yR3v5/KzxwhAjtIe5o+VJdoyJ1KPTSDCQKg5L+qE6Gu296nvXY6bA7FYHD2EqoenIZJ/aKmXCbKeeBFoebNkuo8zphNPSS25jy+FfAz+BUzgkZQOLerjxsFOaSnrkVh0A/gp/ZNik7m/JTV0J/asQWCflmkeKwuZ+gUEJ2bTPs2jZwUxyZU+JANIza3gVU4Jr+svDkFVnUCWFA6xUwCyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SJ0PR11MB4944.namprd11.prod.outlook.com (2603:10b6:a03:2ae::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Thu, 10 Mar
 2022 02:37:41 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5ccb:dfa1:626e:af2c]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5ccb:dfa1:626e:af2c%8]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 02:37:41 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: RE: [PATCH] rcu/nocb: Clear rdp offloaded flags when rcuop/rcuog
 kthreads spawn failed
Thread-Topic: [PATCH] rcu/nocb: Clear rdp offloaded flags when rcuop/rcuog
 kthreads spawn failed
Thread-Index: AQHYLIaY7+I2utbBBk2DOZbNtjWjdKyt5C0AgAbbncCAAtphgIAASQVg
Date:   Thu, 10 Mar 2022 02:37:41 +0000
Message-ID: <PH0PR11MB58803A987BB0D7B51D3FD990DA0B9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220228093629.3746473-1-qiang1.zhang@intel.com>
 <20220303164914.GA87151@lothringen>
 <PH0PR11MB5880F450C2DDD04D4C76F814DA099@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220309210657.GA68899@lothringen>
In-Reply-To: <20220309210657.GA68899@lothringen>
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
x-ms-office365-filtering-correlation-id: 4463d2ef-5d44-47ed-2c13-08da023ef316
x-ms-traffictypediagnostic: SJ0PR11MB4944:EE_
x-microsoft-antispam-prvs: <SJ0PR11MB4944DBE890432D6C6CA46A03DA0B9@SJ0PR11MB4944.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jsNAe0UqTUOTgfSmWDa6wAAU2EvHFj/yYYOo/1nmV3TB3Jzxi8hvaVjibfBTyukFiJeAAesOY7x08ceQzv7k0B/Hd3bMCKz7EL5KT5K3sEaS0IGl4qAepzfHT3Mhye3d4leJKA3V6hP1cpAUJmo9cF6bN5KraxChdSczZAaaaztbJhIaWPT6sNW64cJhgmZ+F6g2bW+YO3xT3BhKWK0eUYr3BhCWlGP08Enfna/zBkHg4FwIuTxn/s90NR1tSzE5OQiQdoDEifpJT3oURZwudYwmIn/FxTZiZ0cqb+rukHwo/7rpa3AdTt+4sQ3UCQqKLYD52WfgThY2K/ceq4x7kEt95Zrow7JlklFmIR923hZ0p2/Dhl4wAee33sme819K2yNCb+ADNduVrBaPNR3FF9xi0Zej98CSp608je+DnXbkEy7SyMM0CLUOZ9bP8DwvxCaAFKhCSRlHepntcDuyrJRn9lMOBEURMS3ljaE3PQM/RXKwLbzZri0hPCfWYb0PpN+37GnsrhgrwjojAKyiwdjZbGORRfLFXvKetvX6vO9wrD7xT4Zrhby6VFFzqhtHIsj8b+lMCqe9QNZsvQR+j8B/hESX1N/dWG462q3bKjxNtB37teUrZN/kL7H5VX9O6s28CT4f9EERcvH2k4appgMyNBuKddZrqPRAQ/KLMCxEvybZzDRmdVVxVrw0w4RVZR+vnNeydgYeY5QEhPL/sw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8676002)(33656002)(4326008)(76116006)(66946007)(64756008)(508600001)(66556008)(66446008)(316002)(66476007)(52536014)(83380400001)(8936002)(5660300002)(66574015)(122000001)(86362001)(38100700002)(38070700005)(186003)(6506007)(26005)(54906003)(9686003)(6916009)(55016003)(71200400001)(7696005)(82960400001)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FAbphzxkz3RRhesyLPmB+/Vv1kgtEFTkwv6+xEcrpGWX+AH7VXzGkPLw54fU?=
 =?us-ascii?Q?GLIMaTw6GIfP9ecc+91XcBZCE5cZtPQ/N8+rSxqud4TrE7jzjXHSLd2owE+2?=
 =?us-ascii?Q?p4uN08tsMyb8hWcv7+B0u7EWi631vPpHEDEg31puhmisoSCplGHvLrg2K6NX?=
 =?us-ascii?Q?SBd4w4/IcxJbFIJ+6NyfS88U/8IBYY6lFLVscxMTnkudqak3Uyb8R8unmFQn?=
 =?us-ascii?Q?9vu7zCzs3zb9dYkmbqWRMtmDm41uaZh5Gh3snfJT7fQSRKaZ3pmyERbANbKd?=
 =?us-ascii?Q?FdHK+ulPh6hct0smt3tyyR7zbnq7HfkZfrodbDLjyPKlzukzAd1J4U2RLZgA?=
 =?us-ascii?Q?6iLRpTwcgeCEuqnSQqU4/aipf7lNkjOGAmZDeGPXs46kLE2Qaafjn+C5OK4t?=
 =?us-ascii?Q?Q69BGMoBuB+ciXeoAk6byy/XPVX+ZFnwqccbkCKNsMV8932ve9yZ7s626MF/?=
 =?us-ascii?Q?e4Kx3oVIszToRZLApKGxyJQMt9Vc2QakqZIW1owE61a9FcarHQGhMVQDFmK+?=
 =?us-ascii?Q?Zq+mUpD8ZpfEaLvDhvkzG2Zex+a1WT87vM1GOi0cr3G2kFUpm+FSZM7jAV7u?=
 =?us-ascii?Q?VVlRNv8HRiAefMy6TTwgtCvzrj5pdQscCFA+ITvQcvsuKVeG7LOuYcnmGuNo?=
 =?us-ascii?Q?A+QuSFDAswq4dsBljMu+yOIzg+pNHOgDOTqBkQQUKvgUokqtq0oxZJ+OHnFO?=
 =?us-ascii?Q?g3j8Fj9VY9ENsk/fPSUZab/rG6vEM8yogrUGrfri62ca6daJ7ORbUG3JF9EV?=
 =?us-ascii?Q?mVuwERVB6Tcbwn+572+83sWjfRmmLVJjheF2iJhtA2RYVI5MW3ctdEmMJHcK?=
 =?us-ascii?Q?wy7MAD3HDb9mUTBcbd8LaGXpzGWaK8qtj0Ss8p8Xj3Tx7XKXDdrsDRI5F7SH?=
 =?us-ascii?Q?TY1uCH8R/L/M1biulYteMeQcfZP/Vve8ifrc/KLuTHleKzJ+Y05J/COvGq6e?=
 =?us-ascii?Q?i1gBtGdix2L1etF+bHvAToq0vmD4U7UNSVORf7ABt+icrImhdSnli2k5xjzg?=
 =?us-ascii?Q?jgQTyqUnzg8e1wwg8yWkuNMmLqkCiEtBzFqw1mFKE8QyLdC5WCv1U6cEhy/h?=
 =?us-ascii?Q?xudbDrpasgCL2/yHH6W+dU6Svrx7WsBR7bD7WzK49O0ffYcXQfREBosDIYDk?=
 =?us-ascii?Q?hOFACBv6bR4gXyf0VadhcqD1I40A5s6wsAueUkqP6QCyxFwJS0ZIFlbWyDYP?=
 =?us-ascii?Q?mn8JidFHQgKoSWbrXDb7aEw3xoT170w5mgEmay9k4Yu9tx/OkKgjGrGCbNHp?=
 =?us-ascii?Q?LeQUpHBcUc8Iajw0+EziInpIXfUKRZxy2m7K5Q6+GH14tlEjEFXgnL6Q6iYs?=
 =?us-ascii?Q?E8yOQKl0hi9hxrufRB20wl9A69ZmHcPtQIjFw4UI5kTJ7DaRTA+Z+mOjsnLf?=
 =?us-ascii?Q?NMhcE6XRC6mvTggdVwazEXOaekGzVEJGFPqog2LGWsmLRlksuBVwIykAbO7R?=
 =?us-ascii?Q?vI0EeS2mfxcMlVLzhyVGriVnnS3EUwpr?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4463d2ef-5d44-47ed-2c13-08da023ef316
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 02:37:41.4797
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HKq4tg232GSmqIChRN3qoIz0STfm5FJhonMH8gGgH6bc+CBeWssLu1gtnKZ8tEq9/CnFpeoASlX7zkbjyF2qEw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4944
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 07:37:24AM +0000, Zhang, Qiang1 wrote:
>=20
> On Mon, Feb 28, 2022 at 05:36:29PM +0800, Zqiang wrote:
> > When CONFIG_RCU_NOCB_CPU is enabled and 'rcu_nocbs' is set, the=20
> > rcuop and rcuog kthreads is created. however the rcuop or rcuog=20
> > kthreads creation may fail, if failed, clear rdp offloaded flags.
> >=20
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> > ---
> >  kernel/rcu/tree_nocb.h | 14 ++++++++++++--
> >  1 file changed, 12 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h index
> > 46694e13398a..94b279147954 100644
> > --- a/kernel/rcu/tree_nocb.h
> > +++ b/kernel/rcu/tree_nocb.h
> > @@ -1246,7 +1246,7 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
> >  				"rcuog/%d", rdp_gp->cpu);
> >  		if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo GP kthread, OOM i=
s now expected behavior\n", __func__)) {
> >  			mutex_unlock(&rdp_gp->nocb_gp_kthread_mutex);
> > -			return;
> > +			goto end;
> >  		}
> >  		WRITE_ONCE(rdp_gp->nocb_gp_kthread, t);
> >  		if (kthread_prio)
> > @@ -1258,12 +1258,22 @@ static void rcu_spawn_cpu_nocb_kthread(int cpu)
> >  	t =3D kthread_run(rcu_nocb_cb_kthread, rdp,
> >  			"rcuo%c/%d", rcu_state.abbr, cpu);
> >  	if (WARN_ONCE(IS_ERR(t), "%s: Could not start rcuo CB kthread, OOM is=
 now expected behavior\n", __func__))
> > -		return;
> > +		goto end;
> > =20
> >  	if (kthread_prio)
> >  		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
> >  	WRITE_ONCE(rdp->nocb_cb_kthread, t);
> >  	WRITE_ONCE(rdp->nocb_gp_kthread, rdp_gp->nocb_gp_kthread);
> > +	return;
> > +end:
> > +	if (cpumask_test_cpu(cpu, rcu_nocb_mask)) {
> > +		rcu_segcblist_offload(&rdp->cblist, false);
> > +		rcu_segcblist_clear_flags(&rdp->cblist,
> > +				SEGCBLIST_KTHREAD_CB | SEGCBLIST_KTHREAD_GP);
> > +		rcu_segcblist_clear_flags(&rdp->cblist, SEGCBLIST_LOCKING);
> > +		rcu_segcblist_set_flags(&rdp->cblist, SEGCBLIST_RCU_CORE);
> > +	}
> >>
> >>Thanks you, consequences are indeed bad otherwise because the target is=
 considered offloaded but nothing actually handles the callbacks.
> >>
> >>A few issues though:
> >>
> >>* The rdp_gp kthread may be running concurrently. If it's iterating=20
> >>this rdp and
> >>  the SEGCBLIST_LOCKING flag is cleared in the middle,=20
> >>rcu_nocb_unlock() won't
> >>  release (among many other possible issues).
> >>
> >>* we should clear the cpu from rcu_nocb_mask or we won't be able to=20
> >>later
> >>  re-offload it.
> >>
> >>* we should then delete the rdp from the group list:
> >>
> >>     list_del_rcu(&rdp->nocb_entry_rdp);
> >>
> >>So ideally we should call rcu_nocb_rdp_deoffload(). But then bear in mi=
nd:
> >>
> >>1) We must lock rcu_state.barrier_mutex and hotplug read lock. But sinc=
e we
> >>   are calling rcutree_prepare_cpu(), we maybe holding hotplug write lo=
ck
> >>   already.
> >>
> >>   Therefore we first need to invert the locking dependency order betwe=
en
> >>   rcu_state.barrier_mutex and hotplug lock and then just lock the barr=
ier_mutex
> >>   before calling rcu_nocb_rdp_deoffload() from our failure path.
> >>  =20
> >>
> >>2) On rcu_nocb_rdp_deoffload(), handle non-existing nocb_gp and/or nocb=
_cb
> >>   kthreads. Make sure we are holding nocb_gp_kthread_mutex.
>=20
> Sorry for my late reply,  Is the nocb_gp_kthread_mutex really necessary?
> Because the cpu online/offline is serial operation,  It is protected=20
> by  cpus_write_lock()
>
>And you're right! But some people are working on making cpu_up() able to w=
ork in parallel for faster bring-up on boot.

Thank you for  explanation. Are you making the above changes to this patch?

Thanks
Zqiang

