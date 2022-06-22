Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 109C8556F32
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 01:37:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377263AbiFVXgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 19:36:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358300AbiFVXgd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 19:36:33 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C0941999;
        Wed, 22 Jun 2022 16:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655940992; x=1687476992;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=R85dzhERb/DiEUSGPoRA3vt3lFZzHA12dpPI34AgRyU=;
  b=RXJFY4/+6gQ04GsXs4rS71rOpgUmDyCRsZMfKVbCwlBwh9eYkDoNhsvf
   dnuAQfTIXzwGxLqQNYAoesMBRmSMUwXvCNWWN45lmbkAl346Jneyjpg5K
   Ect/lyhrZ5gfwlCYCPJ26wP3IRx/EcPaQbQCr2mVzjl63biPTbrHUSvAU
   XrJIEOgJQzcZardy37jT1Yex4TP9N9ejoQ9sbyNR/X2MdwWzYj0cS1pMP
   V4+r3TQxHLsSWYz+hSJXbOuKzSJbeG8YXk4PrDawi1FHUUZiHHVgZ+H9W
   yR+fv/muQOU6haBCuLdueIGtTMmvc48e0tZ8MRNBlU9nIWc9UijTPJxGW
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="280621185"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="280621185"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 16:36:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="730588411"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 22 Jun 2022 16:36:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 22 Jun 2022 16:36:31 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Wed, 22 Jun 2022 16:36:31 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Wed, 22 Jun 2022 16:36:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gLCzOz19sHJX4VSt/Ku9Z6KFE9Dsj8xToDtxIHyyXU+IB1KcHVDoTpa5cS5S+fBL1t6G33ldCouh8MwBKKB6IB2QpJy3ULrvfzzGslc1XW9BBR9JHMs79omvRRw/92pDrV8FpXw1L/06+I1OJk3T38rUAcBfHJ1wDImY7Ek+HSaCYt4uBjB2nT9G1fOUwLnxpeeLUQgS3dTUO+W1juxkc3n1CLsAiUEIzbffqqCjy9ogXMuHUt+CUFF3ncgj+8T/Jg/T2Irj88a6m+Bq3L5O645rXP5GhMfln4n9mEeYWvDkIyyixgpf5A18XRfAUIVxPmB1zf0PIYgPBwgAjjqUBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aSgznvk8Wg6REmx5XyZ6YEtvZ1YsrmqQKOZxQ22aLis=;
 b=hinqJ+I81d4FqlOxSHqGQXDO9nBbxx7uiwLwJ0ihRDD34YxmbB8YKw2F6woZdeZmIlfm+WkYWcUMrNtuvST846g1A9sq2QUsg6SVCjOcPZnhHATWQYJan7Zj1Ki3ToKM2W7aYerF5JH7OCj6pxyTAnNrBL0OrsuPHcik3sVEvjHWiR9D8JbQgMIIdGbx2cqTPtsn9J8YZfeaAKhZdDocb64BWHA4rdyB/PYBY6wfW9Hc3axw65fQNaFJNvqz2vldhhXbiSqcD0Wjo1cbGX8sCY/bbya7vPXvqcIoHxbuZK+nF8NGmYlkb9GfY4NGZc4zi/rBbhZV7Fo00xEGm9MVfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by SN6PR11MB3231.namprd11.prod.outlook.com (2603:10b6:805:b9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.18; Wed, 22 Jun
 2022 23:36:29 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5195:b3ce:d70:a7c]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5195:b3ce:d70:a7c%5]) with mapi id 15.20.5353.015; Wed, 22 Jun 2022
 23:36:29 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "Zhang, Qiang1" <qiang1.zhang@intel.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Add exp QS check in rcu_exp_handler() for
 no-preemptible expedited RCU
Thread-Topic: [PATCH] rcu: Add exp QS check in rcu_exp_handler() for
 no-preemptible expedited RCU
Thread-Index: AQHYhiPvaZaZmWFjQEu0NBJYl75Ct61brf6AgABcGPCAAAtMoA==
Date:   Wed, 22 Jun 2022 23:36:29 +0000
Message-ID: <PH0PR11MB5880B9B43513F15E328D27E5DAB29@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220622103549.2840087-1-qiang1.zhang@intel.com>
 <YrNQpxjIiNpxwyQh@boqun-archlinux>
 <PH0PR11MB58809E7A0BF02907DAA826AADAB29@PH0PR11MB5880.namprd11.prod.outlook.com>
In-Reply-To: <PH0PR11MB58809E7A0BF02907DAA826AADAB29@PH0PR11MB5880.namprd11.prod.outlook.com>
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
x-ms-office365-filtering-correlation-id: 5ad72024-b45d-46b6-68f5-08da54a80834
x-ms-traffictypediagnostic: SN6PR11MB3231:EE_
x-microsoft-antispam-prvs: <SN6PR11MB32314B67973C4A75C505C633DAB29@SN6PR11MB3231.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rNAerPdi2qF9sCbd6seO+ZJh+LNktYTvuQer4t2+o8U+iQrpiKDPih6jep57HI46olZ2Tp899XEWaLO2Hq2en8P8vJKm4M0dwjp1sXSMRaN4g5ercBdCOKKCpeNNgRE0IN1yyMth6usiBbsgqaroG1BAaTh+1QizHjk5ZPvjAzDBN7zrfp4064s/815yEWIkt5lZR2HX34hYNDKzI8gvOYNs06rxvfZrqTDTRpZXfHqjUAImRjcYUA1F6FSuu/z3ZzVufxkiKXhvBlUKQpUTfei/bTK6VsUzTRp1WpsDbq6Jtow+0qkpcLbY+zdx6bphL4LThhcbOd8SF9Y3K6qlv+FAtXs0QT+iSXGaUNPSdq173QpE0UDtTnR57G5MAtmFsOv3EG81FWiTI4NOJDld0sbodzaP6YlpcGFbToqGweVJeRX4Bb5iIMIAPdq9km9dT4S92UWNEcyKM4kjMcvg/C8sw/cUDlR0Mk0HfcQqM6yPwDZKH06BKAwaBgsD4ZCAFtGk/6udDReu5tTIcPLa+VUMR/UxARndJ/4PAxS62SxiM5LRYsvgYBicPm2WNa9gUtZKHuxr1ZCqcJ/hv596SpeZ2zeb+8uoQXmHQZRgnnvIlI8vVJ9q2jr7PNzZoWiZlfU+7XfQKa9JibrnnBIeVjT9kWvMyEGU0a3di1KZxgxCh0srT+CdBuyjAsN0uZWT0RvNR3NmFYSDSal38mBoWuJE/FgqYa9g8uuhslkkB6RVPyXioJte4NO4HLDlrIE+
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(396003)(376002)(366004)(136003)(39860400002)(346002)(41300700001)(186003)(66574015)(38100700002)(66446008)(66556008)(55016003)(71200400001)(110136005)(316002)(38070700005)(83380400001)(66476007)(8676002)(66946007)(4326008)(64756008)(76116006)(54906003)(52536014)(6506007)(86362001)(478600001)(2940100002)(5660300002)(8936002)(26005)(122000001)(82960400001)(2906002)(33656002)(7696005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y1R5wK500H8debdlhxH1TpX4953TKRwPcUTkI20xq6Frw+/pGPLsf1Sah5E4?=
 =?us-ascii?Q?eEi0Ky/If1O/thkD2eWRXCE9YFSqN/KquIVLpvbh7U/fl18rX9pM0zIo/uB+?=
 =?us-ascii?Q?IsnQaAifDyMCWfetwCNB+OCuXWHtASwFrYWksjQV9h+8EP8msg0gdlIh8ngs?=
 =?us-ascii?Q?t0q32cH1p7RCf0FKAvmc+Z+zOpmm4l8K8h5vJ0DI35rHEJ3ILgHomC1KIW7R?=
 =?us-ascii?Q?fdyGOXZiLekoXN9BPMzT1z9k/gAgeuaJBkHCJccN/UZ6CFC5KJoiSHrBbwW0?=
 =?us-ascii?Q?GhSdnauSMW1po10ph5IyotNcWiGtC2zYF826ucfjrWPB2RsEV3Lckn2anVGM?=
 =?us-ascii?Q?JiyjodwhweMoJqa5/2EYOQsuVTlPFtFRKvpCMyBQ79S/a+PKcyJwLvsaY+u6?=
 =?us-ascii?Q?jYE+gmVZDFegtAjpv871eBnR+mDQKnPSSI3MCMe0pNcXib904YfS5N0qCTs2?=
 =?us-ascii?Q?m7KO1BUafz8e1Oj0YFOTBNkZbRrASMvzyQ2ap2zIVuJQc4gm1dueiF3HJE9D?=
 =?us-ascii?Q?v/Df8nHlxYC/exjUOp+64yucjeNM1GceCW0zEy1QRN7Rau5HJN9TOptqt5jT?=
 =?us-ascii?Q?Gug3/adfUQP8SG+G4nSZ2+G2qGPuQQGqVelpxgux7wCYfwDv/phwRQAj0WSA?=
 =?us-ascii?Q?fG3Kh55/6drYISzOoPuqH4Ut9RdiFvz4W4TtAJtjhiZKhROQh7DtiBUBEAm4?=
 =?us-ascii?Q?1IeS96KxC00rTLI+3DmikWoA2lubtOqSA6jdt2DpGfgam8B5c2I52WUtRgY4?=
 =?us-ascii?Q?glBANNUvdUkwiU6H5xjqxZkIsKorBqCen1RlSszjCycXfGq3a3l/uuS7IWmb?=
 =?us-ascii?Q?ddkEO/jk9+5/g3wf2up2HrcywOxXAYxij2XrGRXPwRL5IKq4tx1iM589m1Kb?=
 =?us-ascii?Q?aaHcBGfD4ggwR/R+CMfoGSSkw92Rp1NtTLHgNycrc/XFQudmbAg2KGcMGHbg?=
 =?us-ascii?Q?TiGbxO9bAQo/8AYc+mebrddQxihKolDf3d5E+LCQ2s4PTnIqdTMqthIgz7La?=
 =?us-ascii?Q?YM+/AiW2FfeO6Exycm4IS919bP697cNQA9vkYdFhxvchVTdqjzwjKsyKQ5c+?=
 =?us-ascii?Q?PgiTxnaa1rQkWODu3lrJ8dz8v8mQwMhX4fhdI3umbTcZLWD20wgxEm8wFxTB?=
 =?us-ascii?Q?N9qVOhRZWsdm5A0YMIGJpqGPgS3CVaSAI6Ud/uHAx+AoO70mDJUaYPKijCeg?=
 =?us-ascii?Q?WQD+A3q2/PrKMzm3RM3URUXUmhaLknsa/AmyRe4YskUG07qzWcwWGHSvsA5J?=
 =?us-ascii?Q?OQg3I3RrWjYV/6N73+WROmqeXWE+n4tCjosZTX41deXmucOTGuKhaQVI/VcH?=
 =?us-ascii?Q?3aN96m9E8fL+IRs51A6G67iVIFRHzaYPenCfWpKPeAmKRTr+DP6o/SbiFs3X?=
 =?us-ascii?Q?kbZbJgM1BmTZxFXISkbamXm0CW1nHxfr6EizLFGyXWWhXcdsaeKVJfRlwmnX?=
 =?us-ascii?Q?129Yx8RPPE3lzKAEIaq6qGCd4gh3a7c5tNJzaXgadrj0EmC+HOnyrXtNqGPY?=
 =?us-ascii?Q?0+y9QfAM6E7YoDjp1If4FwTQ0eoyrLWv7J0LRnzIiVBjhQwYsOR2mlrRZcM3?=
 =?us-ascii?Q?j+k3bzununfWjfrhcHWTwWR3AkDqjJ8NrFIz6Fl4QrTrDr+5NwMzYrpUzyll?=
 =?us-ascii?Q?7n2bx1HxKKJoRfdedlnFAvdqnmWXr+nbyZ5uhgQ+Se6+Kn9QuP7dZYQU1nO4?=
 =?us-ascii?Q?A9wLsnA91aB78xqHzRC8rRvwK/3SCFgGwDTAPQxAterOYkPtMSGCHZXFalnN?=
 =?us-ascii?Q?pvrkiTfBBA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad72024-b45d-46b6-68f5-08da54a80834
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2022 23:36:29.4612
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z96H+vDB/PNQrkwe1Y+wgQ3hyhagALodcRgNRa7ygjejFQY8wTZTgc9kgjXKmLd9taC5mwL53fOubkA9gvTJiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3231
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

On Wed, Jun 22, 2022 at 06:35:49PM +0800, Zqiang wrote:
> In CONFIG_PREEMPT=3Dn and CONFIG_PREEMPT_COUNT=3Dy kernel, after a exp
> grace period begins, if detected current CPU enters idle in
> rcu_exp_handler() IPI handler, will immediately report the exp QS of the
> current cpu, at this time, maybe not being in an RCU read-side critical
> section, but need wait until rcu-softirq or sched-clock irq or sched-swit=
ch
> occurs on current CPU to check and report exp QS.
>=20

>I think the idea is OK, however, this "optimization" is based on the
>implementation detail that rcu_read_lock() counts preempt_count when
>CONFIG_PREEMPT_COUNT=3Dy, right? It's a little bit dangerous because the
>preempt_count when CONFIG_PREEMPT_COUNT=3Dy and CONFIG_PREEMPT=3Dn is most=
ly
>for debugging purposes IIUC, and in other words, _it could be gone_.
>

Yes, for CONFIG_PREEMPT_COUNT=3Dy and CONFIG_PREEMPT=3Dn kernel
The rcu_read_lock/unlock are replaced by preempt_disbale/enable, and the=20
preempt-count is exists,  so can report exp QS when not being an  RCU=20
read-side critical(preempt_count & (PREEMPT_MASK | SOFTIRQ_MASK )return zer=
o).
in IPI handler.=20

For CONFIG_PREEMPT_COUNT=3Dn and CONFIG_PREEMPT=3Dn kernel,=20
The rcu_read_lock/unlock is just barrier().=20


So I add IS_ENABLED(CONFIG_PREEMPT_COUNT) check in code.

Of course, for CONFIG_PREEMPT_COUNT=3Dy  kernel, in RCU softirq, the=20
preempt-count is also checked

/* Report any deferred quiescent states if preemption enabled. */
 if (IS_ENABLED(CONFIG_PREEMPT_COUNT) && (!(preempt_count() & PREEMPT_MASK)=
)) {
                 rcu_preempt_deferred_qs(current);

but the RCU softirq may not be triggered in time and reported exp QS, for
example a kernel loop exist on NO_HZ_FULL CPU

this change, It is to capture the exp QS state earlier and report it.


>Also I'm not aware of any but there could be someone assuming that RCU
>read-side critical sections can be formed without
>rcu_read_{lock,unlock}() in CONFIG_PREEMPT=3Dn kernel. For example, there
>might be "creative" code like the following:
>
>	void do_something_only_in_nonpreempt(void)
>	{
>		int *p;
>
>		// This function only gets called in PREEMPT=3Dn kernel,
>		// which means everywhere is a RCU read-side critical
>		// section, let's save some lines of code.
>
		rcu_read_lock();
>		p =3D rcu_dereference_check(gp, !IS_ENABLED(PREEMPT));
>		... // of course no schedule() here.
>		<access p>
                             rcu_read_unlock();
>	}
>

Usually access to pointers of type rcu needs to be protected.

Any thoughts?

>Again, I'm not aware of any existing code that does this but we need to
>be sure.
>
>Regards,
>Boqun
>
> This commit add a exp QS check in rcu_exp_handler(), when not being
> in an RCU read-side critical section, report exp QS earlier.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  kernel/rcu/tree_exp.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
> diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
> index be667583a554..34f08267410f 100644
> --- a/kernel/rcu/tree_exp.h
> +++ b/kernel/rcu/tree_exp.h
> @@ -828,11 +828,14 @@ static void rcu_exp_handler(void *unused)
>  {
>  	struct rcu_data *rdp =3D this_cpu_ptr(&rcu_data);
>  	struct rcu_node *rnp =3D rdp->mynode;
> +	bool preempt_bh_disabled =3D
> +				!!(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK));
> =20
>  	if (!(READ_ONCE(rnp->expmask) & rdp->grpmask) ||
>  	    __this_cpu_read(rcu_data.cpu_no_qs.b.exp))
>  		return;
> -	if (rcu_is_cpu_rrupt_from_idle()) {
> +	if (rcu_is_cpu_rrupt_from_idle() ||
> +			(IS_ENABLED(CONFIG_PREEMPT_COUNT) && !preempt_bh_disabled)) {
>  		rcu_report_exp_rdp(this_cpu_ptr(&rcu_data));
>  		return;
>  	}
> --=20
> 2.25.1
>=20
