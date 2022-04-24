Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B2250CED7
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 05:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237957AbiDXDW2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 23:22:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234096AbiDXDWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 23:22:24 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E7316E691;
        Sat, 23 Apr 2022 20:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650770365; x=1682306365;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Z4esdxnDxvQWs8x4Q6ULGRSb/y1Jr379kDY8qMJBcCY=;
  b=fljx+de+RqLZFS6x/gtfhQclqXeWcX7Ri+Qvz1DH7S456Es0UBzeYmbM
   r/MYNBYc4ImauADYlu5BFtyZzv7+pQzLqDa5v/i2W1XrMSQaxd0KNkeP3
   Q4wU82UjyxuSnInEoDdeGLraX58VyF6Rv989i+Ar5cQMD9AWNWjiJE+2o
   CfYFhI8sT4LSGtO0IISOL8tcL0Nov6KkeTUc5I0TgI9idbdssZrgME5Ez
   NEuNECjKxdugDmv992qyXg2E4WhDVxkP1tNIGIEO5KMfKpjOSm17RHVkx
   ThWWWREuIbbU90G88PyihRHipZgYOsMLEPDh1wEQuRZjo/G/c0n41pvaK
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10326"; a="264768448"
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="264768448"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2022 20:19:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,285,1643702400"; 
   d="scan'208";a="870291301"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP; 23 Apr 2022 20:19:24 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Sat, 23 Apr 2022 20:19:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Sat, 23 Apr 2022 20:19:23 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Sat, 23 Apr 2022 20:19:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z0jyY/YoEvOFh11zDZ9CfOpBiuMiqeAsP8OI2rRWmh2Y1XnbPwQsuHNclRio8S7xIQv7NHC4hYrmqQJS3PkHjp5SDb/o251OwepBc4TaaBqZyDIp7DBN/JxqdOMtmoA7BgKgbD6B9AdM6vlhCKzg03RVjmo9QPoiaMx+NBteeeS30dhONIEDTDpy9FF/u59ZFDOY6oVJIgQSIWXghtyQzzW3og2Eki/VXg73EGhujh9MapJwBKD563Borp7yoBEfU8AEiUMsW8qdlxAr0nCI55PPRagVninBq7oUjPC1ZWLnZYYCi7PfSDXEe7Oa3gXNR9ElfVe7C26JEYUgWSL7xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKzgd7cbPAjTbGegkW/nzjXD8z6REyNXsiZJViGICeQ=;
 b=Z704Lp04BxbnpO99ubs8gel1W6qypr6Fn3TGBfgGBi17O3OUwFu9fgoqpkCodV5jhPgibgBm3DLFay6w7Y4syl3ORvQS9XdCVoUxbcTQWr843YWIYNOJy5B/1R4vphAjSuoS5JJXiY6WYXw44P6sMvRBEPFkfBfm3tJnCz+JuXlg81HZispRgO4KiIaNT/ZSucQqlSgnfcBRmTiKRA0vrPZUsgzuphOVtdiUVgYG7DP0hFIsEObEKwiKBPirwAAHPvGrjl5QWHCpfLHfKs1ZbX85+vJN1+T99lzrI/i3HDifF4/qajiN3uSeZtgrXymL+b4XrAosH9lzQATH3oA7IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by DS7PR11MB6173.namprd11.prod.outlook.com (2603:10b6:8:9b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Sun, 24 Apr
 2022 03:19:15 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::c579:f1c1:28b3:610f]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::c579:f1c1:28b3:610f%8]) with mapi id 15.20.5186.020; Sun, 24 Apr 2022
 03:19:15 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "urezki@gmail.com" <urezki@gmail.com>
Subject: RE: [PATCH v2] rcu: Dump all rcuc kthreads status for CPUs that not
 report quiescent state
Thread-Topic: [PATCH v2] rcu: Dump all rcuc kthreads status for CPUs that not
 report quiescent state
Thread-Index: AQHYU68ghF0IexEC8UWUHs//592Qaaz8E2SAgAJYy3A=
Date:   Sun, 24 Apr 2022 03:19:15 +0000
Message-ID: <PH0PR11MB5880E088CB975674DB791B3BDAF99@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220419053426.2820350-1-qiang1.zhang@intel.com>
 <20220422152647.GY4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220422152647.GY4285@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: 643acac6-8ecd-4e7b-5fb4-08da25a1363c
x-ms-traffictypediagnostic: DS7PR11MB6173:EE_
x-microsoft-antispam-prvs: <DS7PR11MB617387AF9093234FE543F85DDAF99@DS7PR11MB6173.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J630HrsKbHB/5IFNuk9NmAqC57HMvitmqMsMgd8NBb9aCJ106tG2qEaIFAYmJwJjtyf3re5CdNlWPlW4Q1s0XuD2uBEtA8tUtfwImY+eYRaoG/HHY7AvtztMSG0iaGD311XID5Y7Q0d7e+Sf2WAdP6/bBtepusKuuxvEP2x6zP0XCmwKKWzVJTPQH8W+998Eqgx5FkFtuTvGihUIob/d3QyyvG5Etsq3SwgPcnDP0w7OccnrBWO7dh9UIBrVKOOaG/nfGntNXDwmpCKkvdnO1yK7xvf7v0NmUy3Z5fQ41QgbBtbb4GIadVJm7QC3pI4EcpX5nI7snQBf2J/QkxFRLhKHW5Glv1VolDmex7jNfva++daTmP6YBvZYtJCesh9N+GsKaYT3lKTegkNO0u1RaFJmNpWpnvIXooZCuUmKDDXUmVokMMlSlpm5E0eyeKt9lKBxHRpYWYQSQVt9lyqY4MYg6AGK3KTYezf9DXPobSYl3DScjzcI5tEouBByAgYZGkEY7NBq86gILMbhbkUQZZB3R/GJjZG19Q8xs4cwe/A3cH7NUrGXkTtxiBZ1veIIdYcqrJqe5ywUHil9Qb6ptBPPF4UQrWlON/oYy2DeUGNMLiCn1o/zSe8JPXGZYf8LvnAAyHVIvI/qG7F09bG+ZESI9CLqncIA91JZnog/rjdHJsWGoHKwmk2UzRBJXT0lmqBJ++JNr7Q68Gs0LKbX0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(316002)(82960400001)(2906002)(86362001)(6916009)(5660300002)(38070700005)(38100700002)(52536014)(8936002)(55016003)(186003)(122000001)(66574015)(71200400001)(83380400001)(508600001)(26005)(9686003)(6506007)(54906003)(7696005)(8676002)(33656002)(4326008)(66556008)(66476007)(66946007)(66446008)(64756008)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?hqQmQtxUh3VQUq/aVyVnMlOtRmw9KyG5hnPif3IqMIjuKyNGvHdjg/kSjdwt?=
 =?us-ascii?Q?/ui/Wjol87izCEdMrYZk3iebiycW+8/kxzQH6EYr+DXuBxZBPNpf3V6y1Pv+?=
 =?us-ascii?Q?R9YVx7n9oNOGD0QHKflJcf5OzIJAC9HAdvU1CbvDKN9+9q/DeyM8V8OHCLwm?=
 =?us-ascii?Q?vij60D1kZ4W0/cKUrElbuRUDNESv2opJMeTs2+3Y3sM40/XNy5NGftcCJqxR?=
 =?us-ascii?Q?bxhZ5JRO4DP6J298zkMgkgyZwsQcXlZ6hID7sXhA8gqLe8mIKnfDYwrjQufT?=
 =?us-ascii?Q?46jWYqHiobAS4JZDD8oQGIILHFyrhvqjNSY5nIGMo+qdv4JZZZIpajim95UZ?=
 =?us-ascii?Q?ZppHg9GB2eja/dMkZjyylcF3UhtFlt7ZSd62A21b6jVcdMAdCD+IBtFxMFQk?=
 =?us-ascii?Q?zrbCBOZVpgmo5OXyuEbWxHfCyLr0MjDxw/QR9hFL3iBOuBiJX2dNqk0uDZCD?=
 =?us-ascii?Q?QY7JcUBwu9FM7qAod+XBZ+TN+AM9MQ+ddoPTM97xVcXTWx51nCqvY3pWZui1?=
 =?us-ascii?Q?q1gH2tD5t/fASn3uRJ+jqB8+EVCAz3xxVq364e/2tY4/BdwQqIQscA3FQS5B?=
 =?us-ascii?Q?CDqwzAFX8N51wvn2YePDyT0zXWCNxyDrauLGJD02syuPUCvbHNJ/e9gQrw4E?=
 =?us-ascii?Q?Vfj5MqH5vPAKV3FvixNG7gxHZaTI3ka3GyF5QplqwXDaUDnHnc5DuOvWuyEO?=
 =?us-ascii?Q?U84rGBljPFizQoJO0r0sRnMywtYCNJMEe/OP1ziTtHTYy1lUnRiM6y/uS4bn?=
 =?us-ascii?Q?yOphWoCnzOcNuN1FeCp4a1/Szkc6jW4NvuBFv4ajQDvq1nVrcbzULSu6CHTt?=
 =?us-ascii?Q?SzHEIPWWxoV4tVXyHdMgH/9XlslPDsK8Guj/H+9KmmPyS7tRvqZz88y+DT04?=
 =?us-ascii?Q?r9rjtaftMmvfLbcFvtzFRXAkKaVp4Xz5yD7PpNUsyD00p4pfwETryjsRx0o3?=
 =?us-ascii?Q?LfM1yclhzZU2yjLDQajz4vJ4i+101sRiS3XMtzLld2S5UvCS1JFrC/5g2G0v?=
 =?us-ascii?Q?SbwCNNS1+YSRjJFPbJAiHFUddqL9bGO40pJxNCz3/uURdV5nTOrADvvFTGDB?=
 =?us-ascii?Q?NCT6XzhmSCOk7ikFkp/Q/EwaI+zY2dEndNNhutzHat5vQULWBfqqWb9Nb89i?=
 =?us-ascii?Q?4bocAll8BtXZAUGqfKUJAxROZYvzyOm7UnNW+nVFXSypIuEkzf0Uwjr6fh9X?=
 =?us-ascii?Q?iIz6Yvz19MwlwM4M0WWc4iZdfLrQ/68HuFv2N3abACBXOGiXxD3IjkAIIHOw?=
 =?us-ascii?Q?O82WM1d5ULtlWDtSY+a2dtosZxLzEy7V/wOT4TLCXYjX4mNZInuqWBcTHF4K?=
 =?us-ascii?Q?F/ALKV7JNSvUSO3Nkt9TRoPhp01TCBb5pv2a3MfPC+phKSY2EHW4+7px6afI?=
 =?us-ascii?Q?U1WbuL29lEotmmPpbCy/q6N4IX57Ykg/wVgke+/ajsBGTuFrXRzoc/S9jpWJ?=
 =?us-ascii?Q?WBGgnUSb/i+7fGlfrmhS22DXsK1YU5kc0vjcXTITGVwyopuO8ktYajQPc0aL?=
 =?us-ascii?Q?YNombQG9pvF7j4fgnxZflIozLIw+rI+ObYZ3ckDPFUXp8ZBTHJJQjmCVhQ2y?=
 =?us-ascii?Q?uJ4pUCUpIcjJTpSWLLk1qTrhguVZ+ppbIK/9XhsicpnRn/iggc+xPTo+WMov?=
 =?us-ascii?Q?AdC840NCFGwlo56j96KRKLZFgHhFXTqkBk8lOWbuxE4pVW+1telTYaR4jEu/?=
 =?us-ascii?Q?tcITha8s+YDRzUVOhilnFFQaQ5jTyp5UWGGqsgSlnaq3htix60qbsgd5790x?=
 =?us-ascii?Q?W2WRnOWPXg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643acac6-8ecd-4e7b-5fb4-08da25a1363c
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2022 03:19:15.5766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d1u8VlSP82WXYJ506dmtwp1X7V6/PxdC49pZJn57YUOlOMKBFvd1ofOwSdVWF0zdkfu5HjqmQi4gM/GRE+jOsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB6173
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, Apr 19, 2022 at 01:34:26PM +0800, Zqiang wrote:
> If the rcutree.use_softirq is configured, when RCU Stall event
> happened, dump status of all rcuc kthreads who due to starvation
> prevented grace period ends on CPUs that not report quiescent
> state.

>Please accept my apologies for the delay, and please let me try
>again.  ;-)
>
>Your earlier patch added at most one line and one stack backtrace to
>the RCU CPU stall warning text, which is OK.  Sort of, anyway.  I was
>relying on the fact that the people who have (rightly) complained about
>RCU CPU stall-warning verbosity never run with !use_softirq.  But it is
>only a matter of time.  Yes, we could argue that they should use faster
>console serial lines, faster management-console hardware, faster networks,
>faster mass storage, and so on, but I would expect them to in turn ask
>us if we were volunteering to pay for all that.
>
>In contrast, this patch can add one line per stalled CPU on top of the
>existing output.  Which is better than your earlier patch, which could
>add a line plus a stack trace per stalled CPU.  But that can still be
>a lot of added output, and that added output can cause problems.
>
>So, could you please merge this rcuc-stalled information into the
>existing per-CPU line printed by print_cpu_stall_info()?  Right now,
>each such line looks something like this:
>
>rcu: 0-....: (4 ticks this GP) idle=3D1e6/1/0x4000000000000002 softirq=3D1=
2470/12470 fqs=3D2
>
>One approach would be to add the number of jiffies that the rcuc
>task was stalled to this line, maybe something like this:
>
>rcu: 0-....: (4 ticks this GP) idle=3D1e6/1/0x4000000000000002 softirq=3D1=
2470/12470 fqs=3D2 rcuc=3D15384
>
>Of course, this "rcuc=3D" string should only ut only if the stall lasted
>for longer than (say) one eighth of the stall timeout.
>
>Any "(false positive?)" needs to remain at the end of the line:
>
>rcu: 0-....: (4 ticks this GP) idle=3D1e6/1/0x4000000000000002 softirq=3D1=
2470/12470 fqs=3D2 rcuc=3D15384 (false positive?)
>
>Thoughts?

Thanks suggestion, I will resend v3.

>
>							Thanx, Paul
>
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  v1->v2:
>  rework rcuc_kthread_dump function
>=20
>  kernel/rcu/tree_stall.h | 32 ++++++++++++++++++++++++++------
>  1 file changed, 26 insertions(+), 6 deletions(-)
>=20
> diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
> index d7956c03edbd..fcf0b2e1a71c 100644
> --- a/kernel/rcu/tree_stall.h
> +++ b/kernel/rcu/tree_stall.h
> @@ -465,11 +465,13 @@ static void print_cpu_stall_info(int cpu)
>  	       falsepositive ? " (false positive?)" : "");
>  }
> =20
> -static void rcuc_kthread_dump(struct rcu_data *rdp)
> +static void __rcuc_kthread_dump(int cpu)
>  {
> -	int cpu;
> -	unsigned long j;
> +	struct rcu_data *rdp;
>  	struct task_struct *rcuc;
> +	unsigned long j;
> +
> +	rdp =3D per_cpu_ptr(&rcu_data, cpu);
> =20
>  	rcuc =3D rdp->rcu_cpu_kthread_task;
>  	if (!rcuc)
> @@ -488,6 +490,21 @@ static void rcuc_kthread_dump(struct rcu_data *rdp)
>  		dump_cpu_task(cpu);
>  }
> =20
> +static void rcuc_kthread_dump(void)
> +{
> +	int cpu;
> +	struct rcu_node *rnp;
> +	unsigned long flags;
> +
> +	rcu_for_each_leaf_node(rnp) {
> +		raw_spin_lock_irqsave_rcu_node(rnp, flags);
> +		for_each_leaf_node_possible_cpu(rnp, cpu)
> +			if (rnp->qsmask & leaf_node_cpu_bit(rnp, cpu))
> +				__rcuc_kthread_dump(cpu);
> +		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> +	}
> +}
> +
>  /* Complain about starvation of grace-period kthread.  */
>  static void rcu_check_gp_kthread_starvation(void)
>  {
> @@ -597,6 +614,9 @@ static void print_other_cpu_stall(unsigned long gp_se=
q, unsigned long gps)
>  	if (ndetected) {
>  		rcu_dump_cpu_stacks();
> =20
> +		if (!use_softirq)
> +			rcuc_kthread_dump();
> +
>  		/* Complain about tasks blocking the grace period. */
>  		rcu_for_each_leaf_node(rnp)
>  			rcu_print_detail_task_stall_rnp(rnp);
> @@ -659,11 +679,11 @@ static void print_cpu_stall(unsigned long gps)
>  	rcu_check_gp_kthread_expired_fqs_timer();
>  	rcu_check_gp_kthread_starvation();
> =20
> -	if (!use_softirq)
> -		rcuc_kthread_dump(rdp);
> -
>  	rcu_dump_cpu_stacks();
> =20
> +	if (!use_softirq)
> +		rcuc_kthread_dump();
> +
>  	raw_spin_lock_irqsave_rcu_node(rnp, flags);
>  	/* Rewrite if needed in case of slow consoles. */
>  	if (ULONG_CMP_GE(jiffies, READ_ONCE(rcu_state.jiffies_stall)))
> --=20
> 2.25.1
>=20
