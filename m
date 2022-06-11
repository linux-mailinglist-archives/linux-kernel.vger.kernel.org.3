Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2021A54723B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 07:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiFKF3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 01:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiFKF3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 01:29:25 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509291F9;
        Fri, 10 Jun 2022 22:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654925362; x=1686461362;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D4bzH4WC9Jgmmzql5+6e3GnQCxDai6nUAyYWb7FuwFY=;
  b=DFKjB9Zr0OU4oxsW/LAvFiLUbCBjZSAUsTPcFo+HfN4z0xlJCm+vVz3I
   fHR5gjhJ2yEHUTYba519ILsgLr6WhHD/Jea62cMn7GLqxW1YCKfnbYHYa
   MiCv9KDhZ5/13EZ7DMU8h3rVOCcH+gkvCOr7ZZhx+O/Ln0CFAVIfdUNNO
   5qhNQkiYIMjxPhB+DqgZ6buhFV7IVQNxLmzQjyvcv3k5iBf4ZGYSyMgQH
   LtutLCMt8NCXIdz5KpI0Nzu9wIejSJcLm7uss8eJ4judbObRgwHKwULBO
   JCGtlNT1SojG56Bmf86eVOWUIT+jeckRuGfMPZSWAmvGCzzUXYEzulw7r
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="277869319"
X-IronPort-AV: E=Sophos;i="5.91,292,1647327600"; 
   d="scan'208";a="277869319"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 22:29:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,292,1647327600"; 
   d="scan'208";a="556710223"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
  by orsmga006.jf.intel.com with ESMTP; 10 Jun 2022 22:29:21 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Fri, 10 Jun 2022 22:29:20 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Fri, 10 Jun 2022 22:29:20 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Fri, 10 Jun 2022 22:29:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n6r5iHEZ92lvpNo6iaw/MnhPoB5M9pfN4fk/+3f4l35LJ/fjCDq5mid5mFxQ5M27bT85pP5O9i0s8DNaaSSNPHWhKFjoMhlKoEEwvlof++nxGV2+v9R+d5y3Jmg4/65RyRN+RZh2TRe0iD1gyNUhFmDoR27W+ndualhCvelp/By7vA/33kAlvsIJKHTPXWMqR1W3ZTRq38BFCce1KO62/ZpDulM7G6A43LHtYC6fmfpvfyEiJH4r6d169bptLOE9u/z9ddD5eB+kijS2VgBMrzNZWfpU5MmB8M+/WM+65YFuOBmaBLL/bQB654WQ/Ors9VJlclhL7+Xj11c287OhBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEIwMCoQBetVGEFfbJrb02wpiTmNBfp8RCfu+BHBsI8=;
 b=J2yHuu/ZuwGFw10Z9TA/q2JsZYVJa9YQ6LQWh29Ob3y/sGsl8fJ9Nx8WRn9Ryy9pAD44q38Cqcor8zWaFdE4UrTfzKT2SsfUVowSteoJ/VOL1/37Nzjd+6XlGDSoaLnKY5hcjdL5cwzNQDkoZBWrAm0oE3MZnLc8l4SlbDDisYqp/MQxEKQLBQpkiN/4dlpS/xHIssL7a1SGPNDBg9aZ7tk0tg77loUvz2u5MfFmkErY9wMXSFGOnq81UuMuasoM+Hj5l0wpHkhFyx7OwUkamLUZ+0Y/8vHVDLr6fABcMP9XpXRuiKSLXy+tU0CEReMJbOG+Xd/kMuvcf3FIyR2qyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by MN2PR11MB3886.namprd11.prod.outlook.com (2603:10b6:208:137::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Sat, 11 Jun
 2022 05:29:18 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72%7]) with mapi id 15.20.5332.013; Sat, 11 Jun 2022
 05:29:18 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] rcu/nocb: Avoid polling when myrdp->nocb_head_rdp list
 is empty
Thread-Topic: [PATCH v2] rcu/nocb: Avoid polling when myrdp->nocb_head_rdp
 list is empty
Thread-Index: AQHYekOLcM/pjDOLHUOfGqJWFKxX8a1IkEkAgAEfBTA=
Date:   Sat, 11 Jun 2022 05:29:18 +0000
Message-ID: <PH0PR11MB5880DBE1D62DD56DB45BDE88DAA99@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220607075057.909070-1-qiang1.zhang@intel.com>
 <20220610120542.GA1811980@lothringen>
In-Reply-To: <20220610120542.GA1811980@lothringen>
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
x-ms-office365-filtering-correlation-id: 7134ddcd-3ffd-4406-fca3-08da4b6b551f
x-ms-traffictypediagnostic: MN2PR11MB3886:EE_
x-microsoft-antispam-prvs: <MN2PR11MB3886015ED0A9AB47DA675B25DAA99@MN2PR11MB3886.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p7G2awVOJEkHQpGV4OsD5M+UFFsa8dVCaqs8/vHoyougz6cIwcvrtLlFFISb/RCOTL0K9u7O9MFsMoKaaQPlE96dtRXSOHK9F1qC93JLtpyOs/MeQPWQgZHh89bYcetoOjZfC/3VYtfLsO51FTUKCQRlFOLCLOCgq46fKfS3Apt2CboYPecYxOQC1sXj0u2DujahcOgxThARZcQdzPdIgxCBT4Z3OlHk8/t+dL3VQXJRTIlxZ9mlUVCqLaVAyvwRH8shKWir/u8x9AHiVeiz616zb+khrLGX0KDV0G3OnxPK2azAEkeHPnTTZmIpJ4y+LO+JovuB2j0W8fH8ic1nAmpIFaatGwF2O2qJKSRJHY1Do+yQuKmOU/6lDZB8zzB5EdQhxR2skfr8wdc1YGyCb6ZxVZAZD7hFoD2ar3u87spNI5cWFXQo9Y1JqG+3mEpg0tELePLFd9/Mxz0OV9prys6vUEfeqGF13MHwMp6t1V0Q0Y9qS3A4vG/aIG552LxHvx+Mq3o4nK67KN0yAqAL8DYh6B3j9x2wNk8v+66M9DKAEl52L7Bdf96s4SBzQMiqZGZBu4JGk1Jdvo0dyDvrCgf7ew6B6Au1IUlhtJsU5g64Y8w7EPMaU+8bWNDLFHiu05dn0J1j47ha4yF46t2ABIW+FZW4yYpS1iCWjEeA61Jt0nKaIpy/vtSjL4Z8QAWy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(316002)(2906002)(4326008)(9686003)(26005)(71200400001)(186003)(6916009)(76116006)(66556008)(66476007)(8676002)(64756008)(66446008)(66946007)(54906003)(86362001)(7696005)(38070700005)(33656002)(8936002)(5660300002)(38100700002)(82960400001)(66574015)(55016003)(52536014)(83380400001)(122000001)(6506007)(508600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?zH4kiiPj7+s7rmgF5eo7ys1kltOBqJvGfcXL4BQgZkGk5wizlniny2SP9PzE?=
 =?us-ascii?Q?A6dTxA3GRQsAM27uV1qW3fQ8L4AfEO/yXqzzOSXHd5SCZhP43HljcXuPkq3N?=
 =?us-ascii?Q?Rk6LD/VYcd0XbDtVr8hWijicnxUYeO87r5TAbrJXzc8v0dTSbJC9ftpQcpsp?=
 =?us-ascii?Q?ZGmZBb/NUSoqUVyBzDe/O0kqkGhejPkonK+FOXF8fy2Hs8jm7vnxR5+fFW+x?=
 =?us-ascii?Q?a0LoQOkDV3eWBYLT2mxwYIh1pJ5uOGhIY2pMOjQ6TXNkEGYPIpQb2drHDDBl?=
 =?us-ascii?Q?iYYPFYJs7OtXzXntGVT7zsDflSsqmaVq2FFa+eNhelrCUZnMYFsSsQJDSdpE?=
 =?us-ascii?Q?p6mO5+rWFYRDzSy1m9ggjLw0nLpOCZVGMjU0y/Z+NBpt0qyya22KoXDXaQdu?=
 =?us-ascii?Q?gNQWs+Pi+OhFkLbCkYQVy/sLZ9Vf62acBXBnNH4ErUlFB3dn5gHBC86I6nKh?=
 =?us-ascii?Q?o+a9TZh8HXtMfQiVjzY/uhg/Q6b+Papi8dtnT9PgHb+HNiRokXsRbeblVV8T?=
 =?us-ascii?Q?KasxyQgOCskI/cN18OnPzjILWE3eqzwQULaW0Rh1KJ6c0cK+rMZPsOAb3393?=
 =?us-ascii?Q?vs3vqNmpzgXgTDuxS3w3x8LNMkLY3HT8mdablAhB5ND5h8YEUJ+9N/DcUMD9?=
 =?us-ascii?Q?8pVEmG1VPuRM6gnNdQdJATDJcGkyIZiBCoAgXS7/TnmQzkDytrqLeFEE0bQP?=
 =?us-ascii?Q?DaU17OnEoxoJ/+N/s+VqMpJfFwXJZik6Ja4SeIw7LqWsM9o+HyYCykncPvRW?=
 =?us-ascii?Q?/7HZTDgXFBJgrqLR+ABksuLLNnI1kXyUawAgn9FtMWNMb+UZy6veCkLu8d6z?=
 =?us-ascii?Q?BskZyNJed6J9k4fXZx1HWM0xe1oB91URebw8pvw6/ezWv79P3uzA6zzB3UzT?=
 =?us-ascii?Q?DVOXjyu96pejQbDxFKjnGJyX1DElofteJKkxvJ70swdPEw40et5iYbejH/pV?=
 =?us-ascii?Q?y0ef0EJPC/asBD/wMnbuKxpIAWbYxw/XAXp7kZ3IhX7k54u5fbwnrcJziANm?=
 =?us-ascii?Q?5OG9O5+FCYziEDSWYkbvWE88NxxyuB7lctMJmi/E68hqzyIdBhlyVUzLZP4z?=
 =?us-ascii?Q?WQqtk+COzgR8acirqcBU+tCZ+xVZxo5iVgJZsY239AbpFrNqnwkBaPTTAIeL?=
 =?us-ascii?Q?SizA3nLKMVBC+kPnbQTd+l51whuBEs7/UAPqt2PJCOQvhRFj/K+5BM9iE2Rv?=
 =?us-ascii?Q?AiHdXJwrlNwwpwORKHaE1SZmn9PKWYyqEpoIANjibN57/XHUf0dAl14WLbbD?=
 =?us-ascii?Q?99hjzJ0uU7CKkoxcNWqbY6eXRMt121EQZdcSd8YO+vDVGfcmHKMSOtzPBpYN?=
 =?us-ascii?Q?ZkCze46tfw6CJl6sfPvMAONc1H2LuKi/JjhjBsg/nTxXtEAWH+ojGV9fjTp+?=
 =?us-ascii?Q?hOMq1t0NaMoc6aE1lDm1q+RL5P0NnqjAFQmoxNhpFhblx77eBbjokla4B1hh?=
 =?us-ascii?Q?P+3ClR5Snq+BkulVjxjj/mf+SsNrrLFkyc+EroX5HJDu2Sl6PAAGigbAI5B2?=
 =?us-ascii?Q?WE1X8Kt64fUEcQSCySVhvqbBJC7C33WtbRzoCsqD3pWjMRxnYjpAvdcT8Wlp?=
 =?us-ascii?Q?8q38WmFAb2pCEVnnfl/oXH5FtR4q6kIiC9e6ufY2HxDAGMZ6ycOXEknZOct6?=
 =?us-ascii?Q?+Gv06EE39RiF81inCU5uYvsLRtfboOrdu0j4ETOPHAcydlk4DCJp41cwty4w?=
 =?us-ascii?Q?7kfVlEWobM5BxOzIpIcwfIucEzmzrOVjPrtYYeK7rOyqlndzmY1zzSwp9Ucr?=
 =?us-ascii?Q?rzUySEMsHg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7134ddcd-3ffd-4406-fca3-08da4b6b551f
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2022 05:29:18.7933
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9xISWVg0AzUEPwv2rKjMNno29An5c22N0j+bSSsUCruxI5lCNG1dv29+1RzLA378typHMDDQNalE0S+MPjHCYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3886
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 03:50:57PM +0800, Zqiang wrote:
> Currently, If the 'rcu_nocb_poll' bootargs is enable, all rcuog=20
> kthreads enter polling mode. however, due to only insert CPU's rdp=20
> which belong to rcu_nocb_mask to 'nocb_head_rdp' list or all CPU's rdp=20
> served by rcuog kthread have been de-offloaded, these cause the=20
> 'nocb_head_rdp' list served by rcuog kthread is empty, when the=20
> 'nocb_head_rdp' is empty, the rcuog kthread in polling mode not=20
> actually do anything. fix it by exiting polling mode when the=20
> 'nocb_head_rdp'list is empty, otherwise entering polling mode.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
> ---
>  v1->v2:
>  Move rcu_nocb_poll flags check from rdp_offload_toggle() to =20
> rcu_nocb_rdp_offload/deoffload(), avoid unnecessary setting of =20
> rdp_gp->nocb_gp_sleep flags, because when rcu_nocb_poll is set  the=20
> rdp_gp->nocb_gp_sleep is not used.
>=20
>  kernel/rcu/tree_nocb.h | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>=20
> diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h index=20
> fa8e4f82e60c..2a52c9abc681 100644
> --- a/kernel/rcu/tree_nocb.h
> +++ b/kernel/rcu/tree_nocb.h
> @@ -698,10 +698,14 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
>  				   TPS("WakeBypassIsDeferred"));
>  	}
>  	if (rcu_nocb_poll) {
> -		/* Polling, so trace if first poll in the series. */
> -		if (gotcbs)
> -			trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Poll"));
> -		schedule_timeout_idle(1);
> +		if (list_empty(&my_rdp->nocb_head_rdp)) {
> +			rcu_wait(READ_ONCE(my_rdp->nocb_toggling_rdp));

>I suspect you have based your patch on upstream tree which doesn't seem to=
 have this one yet:
>
>   "rcu/nocb: Add/del rdp to iterate from rcuog itself"
>
>With this patch you can't wait on changes to my_rdp->nocb_toggling_rdp bec=
ause
>nocb_gp_wait() now performs the list_add/list_del itself.
>
>Please rebase your patch on top of latest rcu:dev from Paul's tree. Then a=
ll you need to do is to change the wait side, something like this (untested=
):

Hi Frederic  thanks for your advice.
This is similar to what I said in my previous email, this change is better,=
 I will test it.

Thanks
Zqiang


>
>diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h index fa8e4f8=
2e60c..f36d6be4f372 100644
>--- a/kernel/rcu/tree_nocb.h
>+++ b/kernel/rcu/tree_nocb.h
>@@ -584,6 +584,15 @@ static int nocb_gp_toggle_rdp(struct rcu_data *rdp,
> 	return ret;
> }
>=20
>+static void nocb_gp_sleep(struct rdp *my_rdp, int cpu) {
>+	trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Sleep"));
>+	swait_event_interruptible_exclusive(my_rdp->nocb_gp_wq,
>+					    !READ_ONCE(my_rdp->nocb_gp_sleep));
>+	trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("EndSleep")); }
>+
>+
> /*
>  * No-CBs GP kthreads come here to wait for additional callbacks to show =
up
>  * or for grace periods to end.
>@@ -701,13 +710,19 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
> 		/* Polling, so trace if first poll in the series. */
> 		if (gotcbs)
> 			trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Poll"));
>-		schedule_timeout_idle(1);
>+		if (list_empty(&my_rdp->nocb_head_rdp)) {
>+			raw_spin_lock_irqsave(&my_rdp->nocb_gp_lock, flags);
>+			if (!my_rdp->nocb_toggling_rdp)
>+				WRITE_ONCE(my_rdp->nocb_gp_sleep, true);
>+			raw_spin_unlock_irqrestore(&my_rdp->nocb_gp_lock, flags);
>+			/* Wait for any offloading rdp */
>+			rdp_gp_sleep(my_rdp, cpu);
>+		} else {
>+			schedule_timeout_idle(1);
>+		}
> 	} else if (!needwait_gp) {
> 		/* Wait for callbacks to appear. */
>-		trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("Sleep"));
>-		swait_event_interruptible_exclusive(my_rdp->nocb_gp_wq,
>-				!READ_ONCE(my_rdp->nocb_gp_sleep));
>-		trace_rcu_nocb_wake(rcu_state.name, cpu, TPS("EndSleep"));
>+		rdp_gp_sleep(my_rdp, cpu);
> 	} else {
> 		rnp =3D my_rdp->mynode;
>
> 		trace_rcu_this_gp(rnp, my_rdp, wait_gp_seq, TPS("StartWait"));
