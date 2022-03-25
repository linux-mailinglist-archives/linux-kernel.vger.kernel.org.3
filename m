Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 650504E6B5F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 01:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356207AbiCYAC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 20:02:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244412AbiCYACZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 20:02:25 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B43B6D13;
        Thu, 24 Mar 2022 17:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648166450; x=1679702450;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RtHvMDCBZ8X9BFaSRDzN2AAGL6yQIwu5ycQhW/1bXkw=;
  b=laJmWP8MQXCVzLpHgjgrbyy93cWHTSYADmTRg1RabuZ8MMaOav03BUO7
   akpuCmmgsIVZdXXLS0Ukh3SKeGHHlcPU63W17YyON2KtNJd97N701p1cy
   vlW1X3s7Su45BSZH31+fiCO4z/hGNyGiXIcuusE55u2ZYmgnSupYg9btT
   TdM8s4cbtv3DSXp7N0Gkxbym45FIV8RW/GPJoks5io87BDYKR6eQXdYdw
   L1kCoQW+dLa1DzkzvZuZ51f0mNrVt3CCB/FcBALISy3yyOAfhkwPxuueZ
   IBZyXPQXvBj0vDFqVY7QERO0uUkVpNs8WjJV/Rg8lRnWrfulJN4084ai2
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10296"; a="321714454"
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="321714454"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 17:00:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,208,1643702400"; 
   d="scan'208";a="519999703"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 24 Mar 2022 17:00:49 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 24 Mar 2022 17:00:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 24 Mar 2022 17:00:49 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Thu, 24 Mar 2022 17:00:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RuKPsXBwcBXlJEuQF/hqni/M2tu7Sr9SgozkhLE/XOU8sRQZMIqMoZWpHNdZ1KEUPmki1VXQ9uU+edr+1e3VsKoqIWRVgU2EgehLcVcjHQLnFb3nd2d/ygP8h2njQ/D2+0WsmbzJKtzSsjoykNmNOz2hijAdPCH31mhiwVqBMcicm8ZbvfnI1AOdmkUaqcsq3u1LGqzTQljHPwk8lEbIjky5XCxdhBLvzN1/cNTnq1d6By3ANaCLe25OqoWTC5gvO3B0FNVrATuEpNtFpWN4YKcx+i0NSTOuAFfe4TmnyWkYtuc+nH0EUKnZJyADIhe3qULbUCm4jNh6H3JLlDASkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=smxVyUlKa5IMrEA9rgUzxws8AtAezjVs4uezJzYoU6g=;
 b=iFCWJ+QhUnBLJ9TWmNg6AdUfiXrtfaZ1IiGqLTregdKs6pZhWfw8Lgy0wayF2VD1k/LpBQJsTDUk0NXTp22AcICOdm1/GAlnmcbZ2t66MA7NLIXKt56gCvcqK8NTej4YLmzsdxPUMvrMd07URVn+8l0f7Z0pxFYsePcagOWH4EuVzqVTQROpw6uEHgoafy/bZJGEXnUlxb7dqp2/8POnbqIse0O+PTELhzP/OJqYbmeKx8AQzNUAslCBJ10gOggrnzIoQN//GRMNhag1MO+0P0C9NieJGSBqNijkTlFWN58fF51EuWIM1SrHUrWaYtO1F6sK6lXned6HMQWRtvQ8zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by PH7PR11MB6054.namprd11.prod.outlook.com (2603:10b6:510:1d2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Fri, 25 Mar
 2022 00:00:47 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::d90e:5a21:8192:7c54]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::d90e:5a21:8192:7c54%7]) with mapi id 15.20.5102.018; Fri, 25 Mar 2022
 00:00:47 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Check the validity of the boost_kthread_task pointer
Thread-Topic: [PATCH] rcu: Check the validity of the boost_kthread_task
 pointer
Thread-Index: AQHYP3Bozuxnyt+Oy0WTfpuy9UBnzazOsY6AgACE/YA=
Date:   Fri, 25 Mar 2022 00:00:47 +0000
Message-ID: <PH0PR11MB5880D7F86F013AE3CD799E08DA1A9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220324111515.1810160-1-qiang1.zhang@intel.com>
 <20220324160001.GW4285@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220324160001.GW4285@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: 170f0dc4-800e-4de9-2732-08da0df28407
x-ms-traffictypediagnostic: PH7PR11MB6054:EE_
x-microsoft-antispam-prvs: <PH7PR11MB6054A74F5B6BF74858B815AEDA1A9@PH7PR11MB6054.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ExQ1Y3792wGf8jy9x7C2cZyUs7vT1qMXXzBcnhjUgwrCpsrmIfRa860efJXsj/dzsrwJh8lFB7Pv9ak/F54AzpaFx32D6sgZ377a25KjBgodXQAhcrPxW4pTjfEw0eVMfa/JzpLUn2SXzUnhdgYJ1XNvqUVHWHcErZ/Fe1WFt1nuLAxfjGxu5+hGehvlYA9Mw0Hx0ZelZxgm1CkVgk1pfm4uuWJgR/qar/aSw5r4CDCkeqB+EfPscqfqsdVg/HgBsP8qekqu3ExIR4+surTBBvTdCwkBSHAtQYxiALffV8WxrtAf64E7IJBFymDPU7lb0o9fwyiQh5F5CtukHgIgMub2LBgCSn+i9InlcIQrry+iSJbRupbz2M8dP8DFP6yksTJa6QTmZ0cCYNx4vwZMXIjDrQdBGYwxMWsEIvoGzTzPz4g8mHOb+7bLn7U1YinYMnkJRDyIudFha/H3dhvwCA0e2rFt6S2j1a3VygyRwORm8Z0hRwGAaQWQAs5Uc+/TzeDiZ4zD3XgNjlSSYb+MK1RpI4nRVrfirwtbBvxCHY8fV1ndj2kb20Evf3BNZ63bQRISqEZMGcbjqLGybZgqqCWtJry/KARpYnNQhW6gOgywsKwwf5Hfha/R4uhR1jx12f8VGTj4HO/+kNoDCBccnqB94FQUh2BneARjgCU0+SGoXLEeivG77JbZcBvBv1VFrmEUWOwa8tOgVdqy8h6/aw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(83380400001)(76116006)(66556008)(66476007)(66446008)(8676002)(64756008)(4326008)(71200400001)(66946007)(316002)(54906003)(6916009)(38100700002)(82960400001)(55016003)(122000001)(9686003)(33656002)(86362001)(508600001)(52536014)(2906002)(6506007)(7696005)(5660300002)(186003)(26005)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?J+MbkyeQsPR2WzPqM3flnVeK3j7Dg9TK0h08NoO+K+wF6+Aovh9AkpGdIgCU?=
 =?us-ascii?Q?5NXf25ikM5huLjylm2v/BkhDEafk0tMT7Y0Nb4EAY3I208AJdJmle/Xdggox?=
 =?us-ascii?Q?MYDcAJGxPaZleSgBfwb8mZ/hZp9yfVuHG5VijU0wUqw0By9iVV+y0usP9zrA?=
 =?us-ascii?Q?34W6WO2oBqg8PwMzcPHJPp791ZtG6Bn+rdQFmusJ6+qH1YqQBwJ3CNvAj6UK?=
 =?us-ascii?Q?tPvckU2cU+OU9GrtWHddKzQmxMd4KqFWPtOFVWk17MHM2SELO/nLrWdsEtW1?=
 =?us-ascii?Q?0QZSkv3LxnCFL97JfocQXHDLOAIYYT1uq9kf4iNvnjIowphjmnsBBSzJ02Wu?=
 =?us-ascii?Q?FRXpMbge3LeuuNfnzKIm3qoSQ2N0QGRRiTFuEPs7LmLOWmg7ElR+vUBoTYPP?=
 =?us-ascii?Q?be2zWQp/hhER12nYDLk8krH2u9edKv4jqOcdqhtuHc81dZxJ5Zj81axONuug?=
 =?us-ascii?Q?tUT1aGqtKZZSJqbGyU2v6EKJrpAHdHWsD22cBbEm3hNUbQiCa0Nw8ERUTxHc?=
 =?us-ascii?Q?UJMpbueP5ahgS+VMvhE7kvqcptZ3pTgNTQaNvT+6J2G32sVv+LtZp15UskCw?=
 =?us-ascii?Q?o2Eiuu0qWPpCJwrGNJPIi1hqN+rN6vctIMGmKgsvsCpZzk/wQT0pwuMYrM4g?=
 =?us-ascii?Q?8HUPtnIC9V8yu+4JIvlkWY2HxNfh+cXN6IznL9Y+YEfgzqMWAmi4v1HjtbTW?=
 =?us-ascii?Q?6f5E6vCrViDvrp9xohSozWgU7eeUMinS6UpGADl6J2IToeu8dNCZ/ymD3/UW?=
 =?us-ascii?Q?2QefSIu0XZ68n8ZdP6Mk93nWtEAXk7slc8pm0xftiQ03PoeV8uMfTX8323Ko?=
 =?us-ascii?Q?LPkSIzSClKgEox7F01sTue99i6BD34M0Zf4CBRWL3pOAgr8n4jNlJIQV/UrK?=
 =?us-ascii?Q?ufCIsY0pCUfsbxn8svNlBmW3lNKR9v/T4MOM+PSQvxsSGmIk5v9YbE6QAvps?=
 =?us-ascii?Q?rM2YI8U5neNHuPZ9fqxkHqdpZl+rl2q1VeOy4eEnHWN1rN2U1YNxGPIosJ3/?=
 =?us-ascii?Q?6RdpZ23y5EPhgz5qFr2hi4vwLcA6aFeme00envnhQv9Y+j5i7/1t9UPabLPb?=
 =?us-ascii?Q?c5e1E9ebXEMDGD0nDV8UVUzyhZemoRhaNJ0bhhtgdsBXu6XTmwbt+h7xW64a?=
 =?us-ascii?Q?fsFl1U9m7ksPLBSRaPChqRqGq56tbk5V98q9D42ZVfSD5NCtVqQDqwd+WmA3?=
 =?us-ascii?Q?NSJK2ZknVqwfQKpxiEDc26GlJwd1WUZ9jEryNsHAd/9C3SjEmA6pGmfJy3lC?=
 =?us-ascii?Q?INmlDDBK4vavue9pdvKh96aZqc0dJwoSJ11inUbS+W749oaURvwPM2hmcGEu?=
 =?us-ascii?Q?oQRXxedO4HyXBGgIbYao5sQpUgOm7Pl7KF9A8g/Yc8tDKN/K+yNfBDsmd2DZ?=
 =?us-ascii?Q?OzXk/To53LOD4k3D6t8bPjTNlR0/u+uRPWOfz/qciw5wUikocpkPQYu5aDMc?=
 =?us-ascii?Q?6Mbuh96oPtJDCe8f9pDiJtmw5zJX5EjXxwHXTXUAf/X+zfjFZO+SkbdV3LP/?=
 =?us-ascii?Q?Wq5pq9yPPQ8JA39J9SyzF8hRdYpmXRJ57J/WWzAmfHZeUDjR9o0BgqlRUoU9?=
 =?us-ascii?Q?tvJQokLZ663+lzDje0WyAy+fp0u5nvccpEkwTYuWdR74bvz7eI5B49uP1EZE?=
 =?us-ascii?Q?ZQY9KJyMed+HIjHuoC7wuEXTiDjVTrrVw5L0M6YGN/HTWNaoYz2NLj2+3q9j?=
 =?us-ascii?Q?lgJg5m6krPv2ZPWqABdLoZUUv4LkJd5Tpm7+SwltDWZuwj38CqqLWGnpc1dy?=
 =?us-ascii?Q?rPzTwVNjJA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 170f0dc4-800e-4de9-2732-08da0df28407
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 00:00:47.3872
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BpM8QMnyFgnPHUs0ELV6Sd2UPYzzMsMCY9fAecLUhjQyoa0SDcbELNj++LZvE0w8XF71aFR0fzwlQSV09jUDhQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6054
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 07:15:15PM +0800, Zqiang wrote:
> The boost kthreads may spawn failed, although the probability of=20
> creation failure is very low, in consideration of the robustness of=20
> the code, add boost_kthread_task pointer detection.
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>
>Good catch!  As you say, rare, but definitely worth fixing.
>
>I could not resist a bit of wordsmithing.  Could you please check to see i=
f I messed something up?

Thanks wordsmithing, I think it's ok.

Thanks,
Zqiang

>
>							Thanx, Paul
>
>------------------------------------------------------------------------
>
>commit ad3c438e248cbc41fe30a41287621c3dbfcdf51c
>Author: Zqiang <qiang1.zhang@intel.com>
>Date:   Thu Mar 24 19:15:15 2022 +0800
>
>    rcu: Check for successful spawn of ->boost_kthread_task
>   =20
>    For the spawning of the priority-boost kthreads can fail, improbable
>    though this might seem.  This commit therefore refrains from attemotin=
g
>    to initiate RCU priority boosting when The ->boost_kthread_task pointe=
r
>    is NULL.
>   =20
>    Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>
>diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h index 6b9=
bcd45c7b2..d58f6d6073bf 100644
>--- a/kernel/rcu/tree_plugin.h
>+++ b/kernel/rcu/tree_plugin.h
>@@ -1125,7 +1125,8 @@ static void rcu_initiate_boost(struct rcu_node *rnp,=
 unsigned long flags)
> 	__releases(rnp->lock)
> {
> 	raw_lockdep_assert_held_rcu_node(rnp);
>-	if (!rcu_preempt_blocked_readers_cgp(rnp) && rnp->exp_tasks =3D=3D NULL)=
 {
>+	if (!rnp->boost_kthread_task ||
>+	    (!rcu_preempt_blocked_readers_cgp(rnp) && !rnp->exp_tasks)) {
> 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> 		return;
> 	}
