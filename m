Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D7D65A6208
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 13:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230441AbiH3LdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 07:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiH3Lcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 07:32:50 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66058F72DC;
        Tue, 30 Aug 2022 04:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661859060; x=1693395060;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OogR7QCL3VibHfXbaj3nt87Gy0XqZ3ZXJRDjTuHCV4g=;
  b=bBoWGrKtgDzht7sOhK0/IRExsNb7U7ulYy/RGDVpHws4mFp8IFbN/iG2
   a+iJwxR/j5nEnrOW35hWpns3rV4OX2atxNVpFZKVh7vfLpFUjNRDklAUZ
   O55D0OkYRhAc6yibAOzRQ8hEnI/me+I6+q6KTEBDHXPgN7t1HobaUnSAp
   8PRK9PM3d77KCwy4gROfV8kfna5f3KOxNNDnnCjNEfMV8X47gfYXoXiPK
   tX8fbiYJre35YugKhwi9XD8+y445vFZ4xh6TIgXjn68/DF6oHl1zf7M1f
   RJsY2kdnV9wkqAMIeRoz73iTYbr/D4Gqu+hrjFIskeOFHUt4GPUIn3NmO
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10454"; a="356866218"
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="356866218"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2022 04:30:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,274,1654585200"; 
   d="scan'208";a="588564244"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga006.jf.intel.com with ESMTP; 30 Aug 2022 04:30:42 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 04:30:41 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 30 Aug 2022 04:30:41 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 30 Aug 2022 04:30:41 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 30 Aug 2022 04:30:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aZTXMKrXgCle7fwOYODylRYWbJ17w8/aj6UWa6o8OkJqu+5xBEDbHHddo/woNCTTkisUthHx6cPmvJ2iZwTkju//y0Z88DJwCKxsn1pPB2VFZ52r2GLSd2HkPdr5AkATuyD0/Q9dFvlHBqqD9ih9wfiEIgxU2vJipkV4H2qyYhAFUtO/fAx6pZ5c5LPOugCpt44NdTK4MvCAGFr3r0jRjmgUTge36PlBRsQEjwts511ybjm2sATM1zkz2ZcmWc45ENhagSatBBqTddGI0+J/jDcM+Yt8z6hoTrwEEWcuaiej5E1jTRGgJCq9G/HD/tvKd4MArYX1fEKRoMP0ltZZ+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0SQDB4dFlLjQd3YjBD3OwbqLMB2FlOVQCJSHQNeDwU=;
 b=CMq9A1lKMiNsGjU2N1P4q5SZ2pkUz/+hyZtJhCVRcDfYoKWjFUWxI+yrmhlxSHek5RhmhlUKCVQvJ096MebzI4JlTiPAUneRNJ4lR9pbFWFDn3R34t15muEir/ltRZd1Aqz7sN/sHtbbRjnmMANLgDNYXQ+JokM+iUFEcw20nnguxnNVf0ll4X/CFiY7xliiweTzTZX97JS9zUgWkWF6rmg+0Yo7a1eloOIgzsE3HNviwdnIlZkGRFzS9XWsMS4b5yGPdwK47tl/HK2mwBVAgLbc8vQf4NsubGNkJEodMBe60AGD9gQomciV9sZRB2U1dHEcqedKrL4a5Shz7BmKuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by PH8PR11MB6925.namprd11.prod.outlook.com (2603:10b6:510:227::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Tue, 30 Aug
 2022 11:30:39 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::2d74:9016:374d:f7e9]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::2d74:9016:374d:f7e9%5]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 11:30:39 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "frederic@kernel.org" <frederic@kernel.org>,
        "quic_neeraju@quicinc.com" <quic_neeraju@quicinc.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] rcu: Remove duplicate RCU exp QS report from
 rcu_report_dead()
Thread-Topic: [PATCH] rcu: Remove duplicate RCU exp QS report from
 rcu_report_dead()
Thread-Index: AQHYvEojjFZtiK5khEuSJPg6VsxqKq3HJvmAgAAZmXA=
Date:   Tue, 30 Aug 2022 11:30:39 +0000
Message-ID: <PH0PR11MB58809A3EB14FDBD408292446DA799@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220830083151.396561-1-qiang1.zhang@intel.com>
 <20220830090623.GR6159@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220830090623.GR6159@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: 1277bf61-e337-49fb-314c-08da8a7b1101
x-ms-traffictypediagnostic: PH8PR11MB6925:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h7hukIVb5qL8B1AXx1wRDVJTbwv/XNHHhS42+AH/NlDkXMuTRHA6NwxM4WYkTxogJkL+mYDoFXmn53XgUzVO5sZbA93UKWRyAxo6oGcZ2DTQqjFSY29zyI0DTn7Q594sto4sEX60foPZgNFriRgDPWtsfepYF5T0C9GTmiLHbvuk4orxNPJthqDOUp/BFOB91gHaZtiFJYyfKf3OvIWq5gjm6oOjm6i+eNRiXSsO7sQT5nByepUZvLpqfnT7+L+cSyUIxhG3OBYTfD1M/zG1S8FQUSGIjxG/U9ojDBCB8GPhEvOJknTs0T/wOfgTINz2v9qUdEai01WUCRepw0NB8YF/+W9qWfOIZyFMENCxPnBA0RcHcCESJPpnCK0UPN1xOR43jNpa8N5Nmk+CkI1ZBVHUJiMoHY0x23yWq6yhWiEpVC00lEIX/YokwitygPa2tKn5IRU/3xP3jvSDo+Bylmp2EBG+HUWGbE83b00WFVOrhRqAqU85GoKVLJcCkatpCbrSdhITq5m8CIc+Cb0eGvGrlYo9kznXjDf9TBEUVR4A+8Nrjpnu7Lr62+TZZbl07fQMdfExnuVu7HYC+taFK2N1e9UerIGtJuWU4Uuo/CcUJcx0PxTR1SKbwMiSEgL1sUrEf5HGlIBGKmFubKHLGPzR1KRvAHBgy6vm3DQOA97kH8gcO9xl7nUnoaU2b0+MITnJschG4K1kJaweUdNE550QKpLvNbywyLS3adEoSIkhQ2GWVjpXycWSAaD+x29q
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(39860400002)(346002)(366004)(396003)(66574015)(6916009)(186003)(316002)(71200400001)(9686003)(7696005)(6506007)(83380400001)(2906002)(33656002)(26005)(66476007)(86362001)(82960400001)(38070700005)(4326008)(55016003)(122000001)(76116006)(54906003)(478600001)(5660300002)(8936002)(41300700001)(52536014)(38100700002)(66556008)(64756008)(66946007)(8676002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xPw+1mARyguIdBy7ON9XMwFpqzTLXNd5SMWnoRyVeMW76KjfkcAAyibNq51Q?=
 =?us-ascii?Q?EaAaRz5m44fAjeVnip/D9Zf0WxYdfuyU/vOCHQXLYF7LqjeVR37nw0XwiLRp?=
 =?us-ascii?Q?u4kpWbTWRNxLEzIimG0ddW97enU/q9AMQhScQJM3RfQAJXT7jpafzGMhTVP8?=
 =?us-ascii?Q?6Xx9In0dbUCrFieix4DNT7/TJkBtvFaBBY8LqoeN7ziy3QjaMTuMgXJbgUMz?=
 =?us-ascii?Q?jTX5vaMHgy6YIz2NlhE8lHodIEje0jqlv3ONIX1Yy0mfIrzR+AK792Gmc25m?=
 =?us-ascii?Q?MFUce6DuMnrg6AlC6AGtCzBHcDxwb6ftX4LrntSSxkrKPJG+1MxW/9i9sAVp?=
 =?us-ascii?Q?B3PeWQcDozbFcOupdtfzh2ABqPyC2bAki5eVz2UPpnfKiWE6FYjfXnkrZVyV?=
 =?us-ascii?Q?Yr4a5VLPzaKSPOAHTyeYupSjm2m00A9AH4xrtljQtEqjLMnKjzBRlOk56xcy?=
 =?us-ascii?Q?QBm+aO44IMtGvwHoPPZ7AJ8gBzV3WictgH7f4MerkgLD7+JWdlOccP/adOVP?=
 =?us-ascii?Q?Uj75qtpHutdU7lI+BJWNOhIF1tJkRhVmg63qzs4qE501ZQcs044JcG6oTXrq?=
 =?us-ascii?Q?+bv4FEQFySyKjxnXqHbMypN1Tgxh6yRMLVy7W+xt+Xd/ymwkd5I68Uhg2e8u?=
 =?us-ascii?Q?Wih62ZZgcWIyrSJj3X8yUzz8OhMPkwJ0d3yfpx+v5jSUoLCq8nlwwBgkvqiK?=
 =?us-ascii?Q?WJvyENxAJW+qd/pOWKh9SOdS+n5ikyUUpr8BRk23qOR+ERIIur3GQXB3ICiQ?=
 =?us-ascii?Q?gVkzOwVfxA0VMyzLIqLWDMRb1eqlUa5lzH3KWamRIxPe4htD0KOeEwH9/5dR?=
 =?us-ascii?Q?64dZSSU8p8m7/UP80Jyvm+t5lH3OD03o+7qIt7UL8szpVocQNC+FbTyuyLw6?=
 =?us-ascii?Q?Mrta8vp9drC2APlXs0FlBhpik+WdQZg2O9/Om562lU60nyq1z9vXUoEhO55n?=
 =?us-ascii?Q?SPw+TQ6Uy8IlPAkbR2ZjetvtrGgnU+p/lKaNqlshOSiGGuIoqC09uDL9QtPj?=
 =?us-ascii?Q?zEsw3c0QCWEzQWx1cBshBoF+cfHWQ41gFn03Md9DVC58derXUmIavYQlVNZR?=
 =?us-ascii?Q?cn7Cqt/hRelsrrZskSdyRmHIBD/7PjpbXap8+YV76pYWHG0JWo7Q3Yk0lj3U?=
 =?us-ascii?Q?afkUyrZYMjvG/ZS7I3P0j28UGcsQ3A8if5aNVpmgw0MC4zPUbPJpk7HT0NYF?=
 =?us-ascii?Q?YamkSL3PtPay7CMmMwCM4gWIFHVWlCRJ0urwIJN0UuTwFIj67zVwS8IvrQMf?=
 =?us-ascii?Q?ZhONTkB084m+bM51Y0Z1VYqt/MX09sipYPLWwRKX/o8YbpccHFBbdROeALOm?=
 =?us-ascii?Q?dR2gSCWtTdhqFHf6+d0DB4R290HaGbbxmYoJriTotPoTxNuM4j6lDLKMny5k?=
 =?us-ascii?Q?kJkNO6UPNZ1LH9+2uJwXlgoptm9eiAQktWGAEndlNqcZiwMfBHl2Xr/n8Y/P?=
 =?us-ascii?Q?9igAn9J6Zmwdh4QvYGmgefeyUIdiVFPq/5MMdFQeTL2FxelBY/IJCfTch9Wf?=
 =?us-ascii?Q?eGrA+T6d0X1ac/la+4LSC7iGanUZu3KWVMzYMLEGjeUqOjT7ZNaBaouMq+kX?=
 =?us-ascii?Q?/RV7SVea7CY0NdkO8ACcjSyQsD5ZKbj2Ty066zIR?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1277bf61-e337-49fb-314c-08da8a7b1101
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2022 11:30:39.7091
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SpleY6zIGYMOHcIr+4eYbLK+sL3AQi8wKklVllyEvppXUG7nIfQzclI+EC9g4E1wbLXzjBVFEfUAqlzNBj6nNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6925
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

On Tue, Aug 30, 2022 at 04:31:51PM +0800, Zqiang wrote:
> For PREEMPT_RCU, the rcu_report_dead() is invoked means that the
> outgoing CPU mask is clear from leaf rcu_node and has no further
> need of RCU, so invoke rcu_preempt_depth() return value is always
> zero in rcu_report_dead(), if the current outgoing CPU rcu_data
> structure's cpu_no_qs.b.exp is true, the rcu_preempt_deferred_qs()
> will invoke rcu_report_exp_rdp() to report exp QS.
>=20
> for non-PREEMPT_RCU, the rcu_preempt_deferred_qs() is equivalent to
> rcu_report_exp_rdp().
>=20
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>
>Nice! =20
>
>One question... Currently, for PREEMPT_RCU, the outgoing CPU silently
>reports a quiescent state even if there was a bug that resulted in that
>CPU still being in an RCU read-side critical section.  With your change,
>the outgoing CPU would silently refuse to report a quiescent state.
>
>Is there something along the CPU-offline code path that already complains
>about this situation?  If not, I believe that the first WARN_ON_ONCE()
>in rcu_implicit_dynticks_qs() would complain.

In the following code, the current CPU will report QS if (rnp->qsmask & mas=
k) return true.
it means that the WARN_ON_ONCE(!rcu_rdp_cpu_online(rdp)) is not trigger.

if (rnp->qsmask & mask) { /* RCU waiting on outgoing CPU? */
                /* Report quiescent state -before- changing ->qsmaskinitnex=
t! */
                rcu_disable_urgency_upon_qs(rdp);
                rcu_report_qs_rnp(mask, rnp, rnp->gp_seq, flags);
                raw_spin_lock_irqsave_rcu_node(rnp, flags);
        }
 WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext & ~mask);

>
>Could you please try this, just so we know what happens in this case?
>One way of forcing this would be to do rcu_read_lock() just before the
>call to rcu_report_dead(), though other diagnostics might require that
>rcu_read_lock() to be earlier in the code.
>
>
>Another question in both cases...  There is a more subtle change where the
>old code ignores rdp->cpu_no_qs.b.exp (thus invoking rcu_report_exp_rdp()
>unconditionally) and the new code avoids invoking rcu_report_exp_rdp()
>unless this is set.  How does this interact with a new expedited
>grace period that starts just as this CPU calls rcu_report_dead()?

1.When a new expedited grace period that starts just as this CPU call rcu_r=
eport_dead(),
if in this time, this CPU rcu_data structure's cpu_no_qs.b.exp is not set t=
rue,=20
the rcu_preempt_deferred_qs() will not call rcu_report_exp_rdp().  but when=
 call
rcu_report_dead(),  this CPU have been offline(cpu_is_offline(this CPU) ret=
urn true).

2.In __sync_rcu_exp_select_node_cpus(), invoke smp_call_function_single() f=
or this
CPU will return -ENXIO,  and then check  (rnp->qsmaskinitnext & mask) and (=
rnp->expmask & mask)=20

3.If in this time, the rcu_report_dead() has not yet clear CPU mask from rn=
p->qsmaskinitnext,
we will redo 2 step,  recall smp_call_function_single(), but is always retu=
rn -ENXIO,=20
and recheck (rnp->qsmaskinitnext & mask) and (rnp->expmask & mask), until r=
cu_report_dead()
clear CPU mask from rnp->qsmaskinitnext. =20

Therefore, the __sync_rcu_exp_select_node_cpus() will call rcu_report_exp_c=
pu_mult()
to report this offline CPU's exp QS=20


Thanks
Zqiang

>The expedited grace-period code in __sync_rcu_exp_select_node_cpus()
>is of special concern here.
>
>							Thanx, Paul

> ---
>  kernel/rcu/tree.c | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 6bb8e72bc815..0ca21ac0f064 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -4276,8 +4276,6 @@ void rcu_report_dead(unsigned int cpu)
>  	// Do any dangling deferred wakeups.
>  	do_nocb_deferred_wakeup(rdp);
> =20
> -	/* QS for any half-done expedited grace period. */
> -	rcu_report_exp_rdp(rdp);
>  	rcu_preempt_deferred_qs(current);
> =20
>  	/* Remove outgoing CPU from mask in the leaf rcu_node structure. */
> --=20
> 2.25.1
>=20
