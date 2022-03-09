Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFEB4D27BA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 05:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231598AbiCIDFZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 22:05:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231593AbiCIDFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 22:05:21 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1803B020;
        Tue,  8 Mar 2022 19:04:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646795063; x=1678331063;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=T3JUfuKv/QVEXhzpsArnqvsw1lbihvuC2uiMzFjVrvo=;
  b=gYmbC9ZyD5hLR7L0AHeWJEkELw73f7cTMKsOezSuPuoX3EW4FH7ACBT1
   ihvz+EmvgvCQV7ftO4yqPnO6w5JnA8LBjzS1+gfaJo+PVMYC1dWxX+NX5
   EFlRVPofxT6k/e7IAxyWc2l0V8I6OeI+2nV161hWTOjQct2eO3X5J0FdC
   jjguAxfLDDAOCv8gM2Rn+cyVosdxb+yAvvwpRtcPCpOr4VN2cjt3HGc3r
   IvWNxh/cTHBkwnKF3646YCXIs98Mi5RAiYnWvPf8a0JghmIp7yzEB/rYf
   noMQM6TRAY5WoEKLsL4Ap85I6mwr45z8QjO1KRz74k0/JoxICYqUGoXMS
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="235480937"
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; 
   d="scan'208";a="235480937"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 19:04:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,166,1643702400"; 
   d="scan'208";a="510338507"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 08 Mar 2022 19:04:22 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 19:04:22 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 19:04:21 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Tue, 8 Mar 2022 19:04:21 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.21; Tue, 8 Mar 2022 19:04:21 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b/Kz/rfBpgUzVDqUlw3s/i/4HEGvzXcU+6GhCC6nu3YRDhXkpiVBW3w6yycBrIJvJysnJDN2+X6pa93ob03eSkJnHTLUC/cd+2iYf5q845gmoPJ0kjDbMzDbaanBhBmqcNpIxbgGBrk6TzXMnBEeww7v2BzdjF/JdGnCISUEJjG2mgqMQ5veRkBEKMKaVfbsGYCXUE5JMrzFNyn/bzzZdV8TAruABU6Xu3AeHm9lzmjCtC2zNe/aZRwbn/PpbuCVdynG5K94bBYg6HrjpliYYgH1Tct3dZH59zLkMSZaSGC7rKDUcmmlzEGz4K89a0f8Fg7X0cpny1XEUd/+DnF16w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+xhKzPV8/TyBQXBuMRhQo0HB2joaCpOn+W5j5LFZW5Q=;
 b=EyRcCMynCFMURCBnAz30Z2yDkw2qkmGFbThaOrRSsKkjFktOvES0nOnrLnwW5mOXJiCa0iqaKwMCWE11WaFzYqpa10jqd78YMdoIpVdm/166hIpuQX3JxhizRBLM+Ca7JeIhwnvX3VVq07F6Z9TPbNM6HndHFdfp2DBZHSICpDfXJMUkQJaJff0VkDNd+sUlgt8dSlabQ7oVtUyZwoX8Ar87ONJPziBCgK1XO9u0L56j65LFUEN+6nwXWGIxUUfaO5hypFuYDzH2v/Yc9qzOuPeTHKptf5VPZfDGuGxskxhE9R6w6b1HKq0MTbb68ugoWQEgzRN3XOrs7xQBiPDG5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by CH2PR11MB4341.namprd11.prod.outlook.com (2603:10b6:610:3c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Wed, 9 Mar
 2022 03:04:19 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5ccb:dfa1:626e:af2c]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::5ccb:dfa1:626e:af2c%8]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 03:04:19 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     Uladzislau Rezki <urezki@gmail.com>
CC:     "paulmck@kernel.org" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        "frederic@kernel.org" <frederic@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rcu@vger.kernel.org" <rcu@vger.kernel.org>,
        "bigeasy@linutronix.de" <bigeasy@linutronix.de>
Subject: RE: [PATCH] rcu: Only boost rcu reader tasks with lower priority than
 boost kthreads
Thread-Topic: [PATCH] rcu: Only boost rcu reader tasks with lower priority
 than boost kthreads
Thread-Index: AQHYL6nedKu+SJDFEUmZSHHikE8cTayvGo8AgAQNpZCAASfOAIABfomAgACVE5A=
Date:   Wed, 9 Mar 2022 03:04:19 +0000
Message-ID: <PH0PR11MB5880569E024586505CD18630DA0A9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <20220304092631.4123188-1-qiang1.zhang@intel.com>
 <81f69dd4-6ca9-760c-bec5-5cb27afbe788@quicinc.com>
 <PH0PR11MB5880026EBBE3E195549E2245DA089@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220307191512.GN4285@paulmck-ThinkPad-P17-Gen-1>
 <YieapfzKvy2chaHT@pc638.lan>
In-Reply-To: <YieapfzKvy2chaHT@pc638.lan>
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
x-ms-office365-filtering-correlation-id: a72e7d2f-9ce0-4535-fe7d-08da01798117
x-ms-traffictypediagnostic: CH2PR11MB4341:EE_
x-microsoft-antispam-prvs: <CH2PR11MB434178C9C455C0ABBAA85909DA0A9@CH2PR11MB4341.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XROlFJKNmsGl7m9OLaTIncL4riit0d7xjPYS+n0k8EdCJg5mfCfFsiyBCLyhJGG7QCc8ZFdkO50vmqStsyjEhF8JUDm35+mA4tvY250QjANUiYggopg6A+Dw3JUgidfJxRbqqB7u8VJQsn69IyJdrhxmNxK56DNuJAvmxs5EXVy7eC1gheE3A4/O4Q+L+t90PQ5g8pz3VivXvFwIwAQSueXvFHTJ9NlyO80jxL751+hos+iDXo+Et5QsHbZffNHFiZWEFyxivCIUIVzYb0QDLaQcvwyY877o0C2pDSTFiLLmQlEO/tazeohNFrww1Bf79RglN5rtuGzksGfiW016gkAPLMfPHXFPm+Fofo+XXyXsJ8LqgXqObBftLe8WnP6FIeKLUHhoV8gjmOWMNW5MIsA5e9pdmu0/h0nsIYY6vY4jIc2ktPhruY1hOUZ949IphgfaBA09JGJ2mu+DvShsVbhAc8QHZAfxWkzmykF2elF2eNA7GBQuLYgADE9oy+JrhhHpmML8TRcx09pkNZmO4Dtz917/8BWNSyMfgK0pf9ziCgmVeqmWn9ordYLKN3hfGxrJ9u+BgHDYWi273R6q61QnNjcuHv16OblCavYhNiYzdh0dsSGEC0l9bMrbrcV5qVwobyfASf9HUbwHCriK9LZcg8bqNgN+28VH1YE41c3un6vglnzPsZGY8MBhaEPW3r2yNVfM0kOkB1CuvD5W+Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(66446008)(8676002)(64756008)(66476007)(66556008)(66946007)(76116006)(33656002)(4326008)(52536014)(2906002)(316002)(6916009)(8936002)(54906003)(38100700002)(122000001)(508600001)(38070700005)(86362001)(186003)(82960400001)(71200400001)(53546011)(6506007)(55016003)(7696005)(9686003)(66574015)(83380400001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?t+8RWRe/InP4H93ety2NLktwJ4N5Rz9NNC4B+ZwW57CVgjhyajidPxk/3M/2?=
 =?us-ascii?Q?p6zfwewmU3G2uZX8Uc50if2Kou9YCdgsWHYkxrayXMXKQ9aZ0OrJ3YxsSjNv?=
 =?us-ascii?Q?GAPOFedmgEQHDooULcKLw3pZt+Knt6hh5674zhzLK80eMc9iRs4kSOBECjJl?=
 =?us-ascii?Q?RCYdJEomUAEa+5QnggOeu8MqW+eLeTjdYlHKxefLtxebxJ3NWb6GtNuZc3K6?=
 =?us-ascii?Q?PNAVZPOHhb5Kb5Ub0vja9CIyh2k4/YnTHhyHti+/9KtUwKUkYrkK7O3fcU9e?=
 =?us-ascii?Q?HW972TyXtFGTcQc0lTuDLBAPI+X+9aRZcL/B67/BvlDHziOZbGh7NEk4q8Sq?=
 =?us-ascii?Q?+EbFlFCfVqh6bSoMDqVBkRN/2lx8beLaytS5Srl9hYq3BSgi2JnugWIEKe+j?=
 =?us-ascii?Q?m1hPyDUzQrS7qCACbPAWbno+D9Do4h9NPwwMXB+Gig2T6MnIrRVOZ3AliQqc?=
 =?us-ascii?Q?a78GZ/wfsTevpQARJkj5jzliX/2Ux4WMbkf1EWWanJo1RxGnz3U8iLHmcTN1?=
 =?us-ascii?Q?TpcL3MKIN1nDK8CY4XYj5lPPs1QPU4oeupmRCuzjk3uKJCX68VTRVotJCTBr?=
 =?us-ascii?Q?MyuQRf09vSoyXMpTVstcozpAC5XV7pd26zKp5RdtXak9zpXPkLa+/69quAeO?=
 =?us-ascii?Q?GpfPx9jGQClGOXoKnl6ubf7P/FUifp62cA/0kLHWj39LoDOrS1HM9uFHSYy0?=
 =?us-ascii?Q?8PhGgQf1Bw5MRTwme+/9aNRz5RreZAvsCCOvgmFMAu+f7G4TGWKipLnwnhL/?=
 =?us-ascii?Q?gliQy7nl7Myxbm/81Grr5Y8iVA2chnHCLWPADljVtUnIeIq1fQD9UPF0COnJ?=
 =?us-ascii?Q?Lq7G9ryYqkxvmgVL6qDmS/bUVnNQ99IwZLiwWA/Hum4Q9j71ZwujOdJhZhGO?=
 =?us-ascii?Q?Y16DhZe3SsCjEIbgdT97EL/9fpi0RqPPAAmvipp9UOyhQW3i3Kfzzazx4P4z?=
 =?us-ascii?Q?vQSN9EV1pcTXUEaP7BkFWrMuv2svp30dNxJCn+GpOKpnOeUzBOAo6Dc9jBLv?=
 =?us-ascii?Q?BfWarqF/WFdRCPKFI+4wKBIyKLa4BQl5orjxts72CW3roh98DU4a/2xPwBc4?=
 =?us-ascii?Q?EpbC5eUhNW2iOhBOm2CrS7e++HjM8e3z4nHBeJoeoWXKmGFNk3rCHLWF51FD?=
 =?us-ascii?Q?BJuUkNdh+AtNgRTTKnPMocfHYEiR5SPlPDLJqAkYf2zFqJ8qC97t03s19IWV?=
 =?us-ascii?Q?outgO24tPHZ85mO0TLGumpIrVEpboy3J7boqbm5ysbV9RKH0XJjXw3eDvEHP?=
 =?us-ascii?Q?axuNisa8s8GU5J+eDir6jEqNoCAFVxmhNEtiilSNA27Kub5h3tX+o0STZsjm?=
 =?us-ascii?Q?gkFDiHSBI7BjkERujx30scXIOqLZ3sb0o59rKPaLyBmT0xYmgmahh3S5JV+e?=
 =?us-ascii?Q?KrvaPjWTCyHbC0K6QaH6NUBBtfzE70hXpLdza2yZa6yhkYt9R6ytdBU3osay?=
 =?us-ascii?Q?2+JYNTbOPUl3iPmOn4FAm+iDXf2gCQHcvO7k1In4X7t6z1yn28l8viX2Kb6V?=
 =?us-ascii?Q?nuQWsNaGyqGfdZOUMcL3iXmyjA8Wua3gxYUKpjJzKGZD2bPUNQPjFdbdlBnb?=
 =?us-ascii?Q?bADVwHaa+mLyY2DyjUHhaNX88cOLc0K9K0WmsuHH0TF8VhsbFRTK7KOy8EXj?=
 =?us-ascii?Q?Ow=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a72e7d2f-9ce0-4535-fe7d-08da01798117
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2022 03:04:19.4056
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sMb9Ko4FoRHeH7KrfQ5bWWJtWitnGgyBNP+1GZdz3vs1MKkMnSPK+YhU8mDSiLZsrIOH1MdXPvzhPY/HfYGF0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4341
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mon, Mar 07, 2022 at 02:03:17AM +0000, Zhang, Qiang1 wrote:
> > On 3/4/2022 2:56 PM, Zqiang wrote:
> > > When RCU_BOOST is enabled, the boost kthreads will boosting=20
> > > readers who are blocking a given grace period, if the current=20
> > > reader tasks have a higher priority than boost kthreads(the boost=20
> > > kthreads priority not always 1, if the kthread_prio is set),=20
> > > boosting is useless, skip current task and select next task to=20
> > > boosting, reduce the time for a given grace period.
> > >=20
> > > Signed-off-by: Zqiang <qiang1.zhang@intel.com>
>=20
> Adding to CC to get more eyes on this.  I am not necessarily opposed=20
> to it, but I don't do that much RT work myself these days.
>=20
> 							Thanx, Paul
>=20
> > > ---
> > >   kernel/rcu/tree_plugin.h | 10 +++++++++-
> > >   1 file changed, 9 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h=20
> > > index c3d212bc5338..d35b6da66bbd 100644
> > > --- a/kernel/rcu/tree_plugin.h
> > > +++ b/kernel/rcu/tree_plugin.h
> > > @@ -12,6 +12,7 @@
> > >    */
> > >  =20
> > >   #include "../locking/rtmutex_common.h"
> > > +#include <linux/sched/deadline.h>
> > >  =20
> > >   static bool rcu_rdp_is_offloaded(struct rcu_data *rdp)
> > >   {
> > > @@ -1065,13 +1066,20 @@ static int rcu_boost(struct rcu_node *rnp)
> > >   	 * section.
> > >   	 */
> > >   	t =3D container_of(tb, struct task_struct, rcu_node_entry);
> > > +	if (!rnp->exp_tasks && (dl_task(t) || t->prio <=3D current->prio)) =
{
> > > +		tb =3D rcu_next_node_entry(t, rnp);
> > > +		WRITE_ONCE(rnp->boost_tasks, tb);
> > > +		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
> > > +		goto end;
> > > +	}
> > > +
>>>>Why do you bypass the expedited grace period and boost any tasks anyway=
?
>>>>Same way the expedited gp can be blocked by higher prior tasks SCHED_DE=
ADLINE or SCHED_FIFO.

Thanks advice, it really ignores expedited grace period, may be
should generate 'boost_exp_tasks' pointer to point 'rnp->exp_tasks', do the=
 same thing
as normal grace period.

Thanks
Zqiang

>>>>
>>>>Thanks!
>>>>
>>>>--
>>>>Vlad Rezki
