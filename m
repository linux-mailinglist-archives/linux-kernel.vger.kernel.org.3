Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED0B151D815
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:43:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392112AbiEFMr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349759AbiEFMrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:47:23 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4255AA4A;
        Fri,  6 May 2022 05:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651841020; x=1683377020;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MeimNzs5w0q+s5/vhApe5QhAQNmns1dFzoz+ChwdOUQ=;
  b=jBbvZuFGhkh0evf9s0SstqgVLvm2nmV0P9hbWuiTmejAVFO0O/t/tPr0
   01WRLRZyOxf4cjDz4IGzqR+2kUQ6exEF59XUHAQh+x9GWypnQoyWT/DXn
   EhnhGrT92UB8PhmW1JqtfC5pWyNaX4paaah0M9DNptus3hJDrPWwuCMF3
   DPTL8Og0ib9nVdu1tdl2tCJMV5ScqCNbrc+ymCe1jLUF1EVLw8j0zYUmf
   D7vmzUWKs9lop9+UhT0sjSmNfqSL0sQ7CmfBQWUuUDtqhpn54QLkwkDPj
   sEIjwiATJMpIhbYN8Sa9x89ybQBqAjSAw6gvP0YFTXJsD+0Y5nM86Hp7I
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="268061971"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="268061971"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:43:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="537871649"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga006.jf.intel.com with ESMTP; 06 May 2022 05:43:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 6 May 2022 05:43:39 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 6 May 2022 05:43:38 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 6 May 2022 05:43:38 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.175)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 6 May 2022 05:43:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W7l3ZdMmGU7DAL3bHoskqQwXgPcrBelZPRXxFNz0tEC+x2TR3GwPm08Usgah2HNpAFCfpRvrG4DJiI5lan8CM0Mug3AgarkhfcKKsMkiEOlSI+o98h+vlnLJah4v9bI1Y8HY39clouxTavF52l/yNl1pTQVXATZjT3U6NTbVXokHLetQMlLvJoRN4FrUSJ0z2HKbiQz1zHyPOfHT3oZwfOznHiv6TqyfVaiMsrnUzZMxO/qAiHsJ6MsAJEubUQurjT4Bw4PLPh6siiGYi7dKy+UKFyw5V95mtRDDglB01oNUqyNPI9CdWIOHem6U1488tEJGHW1nMuqMIVFMJgpzHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uL8ntBEvrpaU33Po5+XT7pL35BBA3jsZ0YsoCc1TVRQ=;
 b=NWHNiIGtsTqb7w/wx36AIUYjxb4MZcPRQAJQk13johumyjR+X9NpGufe3XNDnadd8Q5Pn3ZO+VHGWWZs/gIm4yprsEhcgPtYlg7tNIW5OMgIpfoV7VPoJtyBWce21pgAynYOgxiDykFr7XV6b8JmTx/hKpRGujz3COiCJPuqH1W9tj361SyZ+molYh4NC90/KqSsVjsDR9zVQ61K+qPxT1quryNqTGJwiRZomvvgik3Bx9modMSB2iRM79Va1HrO6AO8rnxnlvXIYcvew1RoFmi3pWlPwtcTTVDBclBzzllEBFAJ2/MVfPFOfbGj5Kn7mQWvbC3CTNiGEzHI1jhq6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by MN2PR11MB4366.namprd11.prod.outlook.com (2603:10b6:208:190::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Fri, 6 May
 2022 12:43:36 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::c579:f1c1:28b3:610f]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::c579:f1c1:28b3:610f%9]) with mapi id 15.20.5227.020; Fri, 6 May 2022
 12:43:36 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Add rnp->cbovldmask check in
 rcutree_migrate_callbacks()
Thread-Topic: [PATCH] rcu: Add rnp->cbovldmask check in
 rcutree_migrate_callbacks()
Thread-Index: AQHYYJkonORSfrYVw02H56cLgBUTL60Qq84AgABKvvCAAEQ9gIAAQ+DQ
Date:   Fri, 6 May 2022 12:43:35 +0000
Message-ID: <PH0PR11MB5880F4D73760DCA42238A29DDAC59@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220505155236.1559619-1-qiang1.zhang@intel.com>
 <20220505192956.GX1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB5880A25078A7D4DBAB1267C2DAC59@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220506040141.GA1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220506040141.GA1790663@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: f900eb4a-bcfd-4268-7e8a-08da2f5e0994
x-ms-traffictypediagnostic: MN2PR11MB4366:EE_
x-microsoft-antispam-prvs: <MN2PR11MB4366C55D04D681F7DAEB8374DAC59@MN2PR11MB4366.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mYliYjM9DKA8DsZwJ3nut3y6s7MT7pNuUqx7bPqwi3V/bpxbyrexTJudPc0gR2K4bAQDn7S+sG/KfM5J0MYnO5q5ARAsoC6M/8JSHuv07PrQ1oY6gPamAUEQbFeeMdHXxqgAzLxkXpbYiuXkrKNg3aQGIjTUeHwU/bEW7UfeT+mNQk+M+1eAwXvlqzMlWrrQ8O3HuPkUQBEsp/CHR4ea0knRteyg5FyiyxDq430HaCZaEJK76sTwYNfZjhOAkPoRA+oC3VXumnpzPjjcIrNcb5qe88iX+1CUbkkdCB+XmmIrbXLQkM3VQPN+AkU3HdC/H1PgCP0go8pampjh4cRKRmBp+iFSW0Yb42bGZzwb/WGfIbREH14HyE75meLWrKgwY+NDRDdbcLRc6GFMc0sOJUaW0M7uz0c/wU0BThAZ5jKct1LaMsksDQuxRp0Vy/e926L39mOP4axkuPJ0/Bz5EcXNs1vdXAgQBerieOqLnRngFUPosmaYISp5wSWK5BDeFrEnKOEvJ8Zxf6TGmRizT34ZmbjKmcdshH5UCDfZea3ztYeDQ0dsJ5e/TLv89JwaIqgG/yA6mEhIt025lpaMcI3B/UzksrRVpyqAztbWVyI+YHPusfBumgKLRQpxh8gSJBLNFEtHpW8UwPbNWDfqVAEIh+zk7d1L+znsCeL7BSOchwHrqGEsrK9q3xhgivqlpCLcFcUMhgAf03pBftDQEA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(508600001)(71200400001)(4326008)(33656002)(52536014)(9686003)(86362001)(6506007)(26005)(7696005)(8936002)(2906002)(55016003)(122000001)(82960400001)(66574015)(186003)(38100700002)(38070700005)(83380400001)(66946007)(316002)(64756008)(66556008)(66476007)(66446008)(54906003)(76116006)(8676002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?6NfNNSUOq4+gcvEBLCKss7ihazVJ2DfCX4PgSLjLZ2jOq/AObYAmK7Uo+jFm?=
 =?us-ascii?Q?qPzvqFqk6ZAP+W69qS0KqNO/FEyPL1Alq9HtIh77BkoZySj9GeHjgUq3zuoT?=
 =?us-ascii?Q?rfmo6YhC6eAeW3i+2uaEzn0cIcekF512kOSeV8MawNh3NwntcL7qI3OSaNH6?=
 =?us-ascii?Q?Z2QOFOvTRRjOe8hAw/aNi92f0UkFKqwYEKLF6LOJ4ECuKiaoyEQjsfngZQdT?=
 =?us-ascii?Q?p/oyamBsgRwGSJKnm+uveVBpD+BLcqnkjHAwDNY2ACEEjU3BdCTzSCNgOasw?=
 =?us-ascii?Q?e9OwBqR/juX7DLBpppao6eSJ6EbIRn4/L/rn44GH2LdbdKSFF7psZt6WozQW?=
 =?us-ascii?Q?ZvO0hHJGFkCL8YgYmHiiSWTC5zJlUPbXTmvwhyHOY5MsCGzqRFyDG9B8Z8+8?=
 =?us-ascii?Q?UC7R2LqdkY66Lehf2vFxR3QJflekJumPsZnxxdI2xVWxI0gZ9+t5hP77jP09?=
 =?us-ascii?Q?mfVQ9n+wEDFgqU+2Ec7aWSVOhoyMfeYNuHwsx0Y2O0EBt0wZt7r3FihA04Ii?=
 =?us-ascii?Q?pYFjVe7Dig/kVCBymVn4zc1O30YYkzRsVvzK4YBdMORgaNrWyMf6YOoYPBxE?=
 =?us-ascii?Q?xxPIcvZaa3a14NQeXXnXE00pR4Bf6JrwSr7Uti+dRXS5f1W+X3G667sz2H+G?=
 =?us-ascii?Q?2atGjOj4rqsHwLmy5ELs5M3vGaIScUpqBMfCsbGJof9BBcD4g4g7jVU7gSmu?=
 =?us-ascii?Q?15w2Zpu291kwQxj5j2r0n1NCdel3MMpuBixPe+65jTX9a+W1UZReSSmT3Nn8?=
 =?us-ascii?Q?yLu9RihX2SAZnjbkDDG21yiRV6z8U2SUMIcutNpRjK4lcJqSyfnfD+G1A/Cw?=
 =?us-ascii?Q?So8hqmpR3ac089bDeV2fbbkQI/xJJiZHx7Hh+Jfo2xk6viUCut7OjVm5Nu6n?=
 =?us-ascii?Q?sbfFi86ovRYf5iBq6+psbnJoONhfzZRTyARSpNJRuejbofTVkglSSGEpC7tb?=
 =?us-ascii?Q?yCbhc/Nu5lRyqR/wfvCwxksrJeGRMCxXMmfUZP0N78ttk7jMayZxTXvZq88K?=
 =?us-ascii?Q?/7XpZazb4cIFTXA5VhU1hNtNI6CoDGJVGvh+t75BE9lQ7AxHKItFqSmc0aUj?=
 =?us-ascii?Q?xVTv+hCWQvvyZhGYfuBUHCf0f/1MVDK1Jw2lxd0kRkPzHnQQJmq46NQCyf3L?=
 =?us-ascii?Q?3ENw3W+3YAOrVEea7JfnbM6REDkU1Ks7BFszKF2jU7RsZrtBxF5Q9qR5eNSr?=
 =?us-ascii?Q?P2ET8qgRcqAK1VsxyhEwWQ+dfwu/mnhgyjHpES4Edn02XtqLhFHq68J/pUmE?=
 =?us-ascii?Q?rc6Cd/c1NEMMwhRcqcEjA/0aW13m9zVU3PKvW2fzmfvc6X8af8zByd5+k9p1?=
 =?us-ascii?Q?akvIN6ED7+0fC4s3m+D9CdUagHVUbbW+TSg3UCO/VFxgjHS50Da4mn76cJTq?=
 =?us-ascii?Q?u8LIUxod+gMRNPEMOu5HoAXPOlNHE7IufAt5uMRhfZNUNEYj6MeoFJh9n126?=
 =?us-ascii?Q?/a+xQoDa/qTLcuyc01Sv+yUd9V1BMEv8renlO0cp6chsBhdKz7ZEfXLLsKus?=
 =?us-ascii?Q?IPXrh1nOjEgvtPDk53OeNGaZGxjN8+eOZK6f+zqFR9t4xtRrdosmorzVg8gW?=
 =?us-ascii?Q?92PqWDun39ZRZZSLim+OuuhIQQkAB/Y7oocMbR1zS9RZYVxtdje/igY+pCSE?=
 =?us-ascii?Q?pmPp7vLJ9mGwl2q0ml1KR8H6sBl05hMoAwLcDdCQ2R9g8M43x2A/RTpHlpJD?=
 =?us-ascii?Q?5OnZ7SIEJE17f2jcKRKzhTXA8LIwP8X2lv/IPFarxB6wd6dyrHTSk9Aq1Hpc?=
 =?us-ascii?Q?CW+eEYHjkw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f900eb4a-bcfd-4268-7e8a-08da2f5e0994
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2022 12:43:35.9880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LQ2sBVuI8tYw18tpbXQ3DYa0kkhPV6+ErKitWEbYxobOP9fbuUp+EOO9mwuiRwh2zg8EO0/cb166Fwf70z+8pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4366
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, May 06, 2022 at 12:40:09AM +0000, Zhang, Qiang1 wrote:
> On Thu, May 05, 2022 at 11:52:36PM +0800, Zqiang wrote:
> > Currently, the rnp's cbovlmask is set in call_rcu(). when CPU going=20
> > offline, the outgoing CPU's callbacks is migrated to target CPU, the=20
> > number of callbacks on the my_rdp may be overloaded, if overload and=20
> > there is no call_rcu() call on target CPU for a long time, the rnp's=20
> > cbovldmask is not set in time. in order to fix this situation, add
> > check_cb_ovld_locked() in rcutree_migrate_callbacks() to help CPU=20
> > more quickly reach quiescent states.
> >=20
> > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>=20
> >Doesn't this get set right at the end of the current grace period?
> >Given that there is a callback overload, there should be a grace period =
in progress.
> >
> >See this code in rcu_gp_cleanup():
> >
> >		if (rcu_is_leaf_node(rnp))
> >			for_each_leaf_node_cpu_mask(rnp, cpu, rnp->cbovldmask) {
> >				rdp =3D per_cpu_ptr(&rcu_data, cpu);
> >				check_cb_ovld_locked(rdp, rnp);
> >			}
> >
> >So what am I missing here?  Or are you planning to remove the above code=
?
>=20
> We only checked the overloaded rdp at the end of current grace period,=20
> for my_rdp overloaded cause by migration callbacks to it,  if the=20
> my_rdp overloaded, and the my_rdp->mynode 's cbovldmask  is empty, =20
> the my_rdp overloaded may be not checked at end of the current grace peri=
od.
>
>Very good!
>
> I have another question, why don't we call check_cb_ovld_locked() when rd=
p's n_cbs decreases.
> for example call check_cb_ovld_locked() in rcu_do_bacth(), not at the end=
 of grace period.

>The idea (as you noted above) is that it gets cleared at the end of each g=
race period.  We could also clear it in rcu_do_batch() as you suggest, but =
to make that change you would need to convince me that the extra overhead a=
nd complexity would provide a useful benefit.  This will not be easy.  ;-)

> >If so, wouldn't you also need to clear the indication for the CPU that i=
s going offline, being careful to handle the case where the two CPUs have d=
ifferent leaf rcu_node structures?
>=20
> Yes the offline CPU need to clear.
>
>But again, the clearing happens at the end of the next grace period.
>Here we lose (almost) nothing by leaving the bit set because the other bit=
 is set as well.
>
>Another question, as long as we brought up rcu_do_batch().
>
>Why have the local variable "empty" given that the local variable "count"
>could be checked against zero?

Thanks for reminding
I noticed  when RCU_NOCB_CPU and DEBUG_OBJECTS_RCU_HEAD is not enable .=20
double call call_rcu() will cause the rdp->cblist's len increase, but
actually, the number of objects in the rdp->cblist has not changed.  the
WARN_ON_ONCE(!IS_ENABLED(CONFIG_RCU_NOCB_CPU) && count !=3D 0 && empty)
will be triggered.

When RCU_NOCB_CPU is enabled, even without double call call_rcu().  due to =
nocb  bypass
Some objects may be in the rdp->nocb_bypass list, this causes the count to =
be non-zero=20
when the rdp->cblist list is empty.

>
>In the meantime, I have queued your commit for v5.20, thank you and good e=
yes!  As always, I could not resist the urge to wordsmith the commit log, s=
o could you please check it for errors?

Thank you very much.

>							Thanx, Paul

------------------------------------------------------------------------

commit 5c36f04bd460246dd28c178ce5dce6fb02f898e1
Author: Zqiang <qiang1.zhang@intel.com>
Date:   Thu May 5 23:52:36 2022 +0800

    rcu: Add rnp->cbovldmask check in rcutree_migrate_callbacks()
   =20
    Currently, the rcu_node structure's ->cbovlmask field is set in call_rc=
u()
    when a given CPU is suffering from callback overload.  But if that CPU
    goes offline, the outgoing CPU's callbacks is migrated to the running
    CPU, which is likely to overload the running CPU.  However, that CPU's
    bit in its leaf rcu_node structure's ->cbovlmask field remains zero.
   =20
    Initially, this is OK because the outgoing CPU's bit remains set.
    However, that bit will be cleared at the next end of a grace period,
    at which time it is quite possible that the running CPU will still
    be overloaded.  If the running CPU invokes call_rcu(), then overload
    will be checked for and the bit will be set.  Except that there is no
    guarantee that the running CPU will invoke call_rcu(), in which case th=
e
    next grace period will fail to take the running CPU's overload conditio=
n
    into account.  Plus, because the bit is not set, the end of the grace
    period won't check for overload on this CPU.
   =20
    This commit therefore adds a call to check_cb_ovld_locked() in
    check_cb_ovld_locked() to set the running CPU's ->cbovlmask bit
    appropriately.
   =20
    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c index 9dc4c4e82db62..bcc=
5876c9753b 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4577,6 +4577,7 @@ void rcutree_migrate_callbacks(int cpu)
 	needwake =3D needwake || rcu_advance_cbs(my_rnp, my_rdp);
 	rcu_segcblist_disable(&rdp->cblist);
 	WARN_ON_ONCE(rcu_segcblist_empty(&my_rdp->cblist) !=3D !rcu_segcblist_n_c=
bs(&my_rdp->cblist));
+	check_cb_ovld_locked(my_rdp, my_rnp);
 	if (rcu_rdp_is_offloaded(my_rdp)) {
 		raw_spin_unlock_rcu_node(my_rnp); /* irqs remain disabled. */
 		__call_rcu_nocb_wake(my_rdp, true, flags);
