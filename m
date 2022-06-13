Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8574254A212
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 00:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236934AbiFMW0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 18:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiFMW0w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 18:26:52 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C49730F50
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 15:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655159211; x=1686695211;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Yn+y9kYMz8qDFpz0iiYqTMWW4nWt1UT49JJh0GC8b/s=;
  b=NA8OZwx4lU5oFmYY7RjIuJV1R57oF0TCobEAmwlYBTBeT4+QeSc/SP0/
   3uFUEIH62r7cruCxHAjEDXmEoVRpUk+8eKfyQzj6KbF00UXOI9839XoM1
   mcdrCalCssJ+38IC1eKud0ZWH41OuzeKb61yn4fmSAuSHeeaLITH+d1st
   CaiS8J+tArMDRJWLo8loksKbFtZwl2fvi2LDpJwZRCm6SRT6HceRR8Mr8
   vM7HxOzaqo9BVQ4tJc6GyrmwGHS2naMGhBWP3B9VPGg5ZPpe70S5Vfenf
   CV7iMY0ErhDjDm6unQzeb4/fINOwdNfM2Vpm7o82PCeE8OwEimoFOKVOO
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="340099373"
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="340099373"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 15:26:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,298,1647327600"; 
   d="scan'208";a="569517170"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga002.jf.intel.com with ESMTP; 13 Jun 2022 15:26:50 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Mon, 13 Jun 2022 15:26:49 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Mon, 13 Jun 2022 15:26:49 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Mon, 13 Jun 2022 15:26:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l2h5CgvMZ1b9VOa566QkaDYpQjuCPWffjdoH/NLLqeNJVtjoIDkuD+XfWPpkBlQrkJF7lonZ2Ujvl9dfijQxzkjLtHFonh2DsVOazX/pnkqj1I2KN1HbnuE+r/D1A0QK/QfeBBPMG2vGlusPcsb9HV7FjF77yyQdSl/35elez+Jj4ZKn4Io0/1cI9glNWbpRcEfUZb+m7QOqiRs795GdY5E1PhmNTGUwUfs+sSr2CuPEC800MSm1AXuSm30y6/hBjUrgizSWuZNzpaITAlapZuh2ytf2e753ye+7LBW3ZaYhK3Z/e6y4d09faOfXvIU+10Cl/MM3kQneGcFqA5Sk7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XaoIMJJOWdK8ceUhokohIAXw1CkRKg/UVZF8TY/ku0=;
 b=OQfhbJ4xYIw2/vP+861pyCNJTnWFV7Grdp5oJDF2a6qr/Ywi8NIHZXWZF/3UXbtpOTOev8rEeEsuhiYiIfKpbNKmpZciRYaq7HWZCA3fzJSOEv5VsZ9/+5ectUaLIDxl3vt0YeWONkwrl7iXWWhcpn1gxpLx3UatVgn622atAb9P2aYqO0gtedFM79aycUDYEvjnlaUdVMBZY3QHeOQefVLPlSMEwaI1WaYuBkTq+H7eqSBhk3UlrxgkSPYKMvg3820QMy3RlrZpIJx5cS6XS74AX0CHHUtE+mZs8t7ru5LGJTOomT3AZnhDhfawvBXOtJeJBInAJVNpQA26JvC7qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH0PR11MB5880.namprd11.prod.outlook.com (2603:10b6:510:143::14)
 by BN6PR1101MB2132.namprd11.prod.outlook.com (2603:10b6:405:5b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Mon, 13 Jun
 2022 22:26:47 +0000
Received: from PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72]) by PH0PR11MB5880.namprd11.prod.outlook.com
 ([fe80::a4a9:b58f:8246:5f72%7]) with mapi id 15.20.5332.020; Mon, 13 Jun 2022
 22:26:47 +0000
From:   "Zhang, Qiang1" <qiang1.zhang@intel.com>
To:     "paulmck@kernel.org" <paulmck@kernel.org>
CC:     "Eric W. Biederman" <ebiederm@xmission.com>,
        syzbot <syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: RE: [syzbot] WARNING in exit_tasks_rcu_finish
Thread-Topic: [syzbot] WARNING in exit_tasks_rcu_finish
Thread-Index: AQHYfnKnPcEG5KPSqUKTUzyVmEvcrK1MN1mLgADFmMCAAHlEgIAAboyg
Date:   Mon, 13 Jun 2022 22:26:47 +0000
Message-ID: <PH0PR11MB5880EB4D4F2B7D91C88BC852DAAB9@PH0PR11MB5880.namprd11.prod.outlook.com>
References: <000000000000e2fc3f05e141f930@google.com>
 <87bkux1yn4.fsf@email.froward.int.ebiederm.org>
 <20220612202204.GX1790663@paulmck-ThinkPad-P17-Gen-1>
 <PH0PR11MB588027C1A486FCED7885C500DAAB9@PH0PR11MB5880.namprd11.prod.outlook.com>
 <20220613152337.GD1790663@paulmck-ThinkPad-P17-Gen-1>
In-Reply-To: <20220613152337.GD1790663@paulmck-ThinkPad-P17-Gen-1>
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
x-ms-office365-filtering-correlation-id: 10e31aa0-4953-43c1-b924-08da4d8bcdaa
x-ms-traffictypediagnostic: BN6PR1101MB2132:EE_
x-microsoft-antispam-prvs: <BN6PR1101MB21321C4ECB59D53CB09A5916DAAB9@BN6PR1101MB2132.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PdYL9lJ1/+PLrJ5TdBK6/iZCb1uUXcF7dZMmv7WjTaYy4+eFXlPfmlQbmylHZyVT5C0qObVb3/lbtpHdMuZsslcthHl+pdEY7Y7n4ERv/ACXL/NEw6SegVdKL/shoGYrpPmsJF9QcYFkRDV7BCM4fZa9m8jr6AFu9J/I1eYn+qwv0UrMQxW7ezwEEdr6JfMkKljW4tOM5ovLxfqhlUhUZC37LWl0wc5CPAtWFavqWd0Xae2WW0JOUqTSd8PkDfhc+nZ6VLjNTlOyzXGvhXCyX/eH+oc+AuwWWGvUNN2mlcHJ9iuIgCsNod0cs93F0TVsBsrK6HfZRZU3z+arhuFHX+MlDPauL3+7UbTyUtiSw0uXyOGhwZTTYNf3f/zSi4NmaAkmKeE0+jozOgM+s8hYgbfvuNfaRMYvjnTpJ6OSm7HXdeaFbGM0GGu37dkxPYq6IjD28UIZasuqoSg53Pb29bpkF7VTupmOweSV/toEd0ObUKCW9VehW6WM0McB7EQ5hHU5T9PG8KFMty/jypm9xCG0kpF9tod/wb+/EG5rAKUtRn8uqLoUbl8g1Vp1GeYjgtLwFJknLbEwpBqQfx21nRzE8brAPoLbmCwTZnrhwzalb+Ph1wgmu0C+6E8Ij2v/a+XfdwvMn4je1NRjSv9bWrUbsdXh5Rxwl1ga9xYCKJmFgA6cLKNI86WYdNbBsTyrfD9USnZO8QGuUX14JUl/p+xXEymasVOWlL0zmqatPGf84vvSsztaaMiO4qjYuQGyezHp1zEe7C7AsnZDrO0eTmp/QO1ToM3KsolZXU2Ev5jHyKFfv+MPCJXhmFXCQxtC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5880.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(8676002)(66446008)(64756008)(4326008)(5660300002)(66946007)(76116006)(86362001)(66556008)(66476007)(8936002)(6506007)(7696005)(71200400001)(508600001)(54906003)(52536014)(82960400001)(9686003)(38100700002)(316002)(6916009)(122000001)(966005)(38070700005)(26005)(33656002)(186003)(55016003)(2906002)(83380400001)(99710200001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qB3/9nlumSlmwCbPzRnuqLJ0LXRtK/YvDb7sovZWYzZdkjwMigAt8bXrRcye?=
 =?us-ascii?Q?7neNweSlyaTozJGVB+GZqIn3LNsjofhSoaiXFRI0GOIMy617eOwfj7igQ8AE?=
 =?us-ascii?Q?FbfREkH+j9skO+Y9aw/Ux+mctfcOt7bGgkHPJkSn3hXri8buUzjswsh29bgU?=
 =?us-ascii?Q?mUl+nYIFAKtveHOijBcaKx2l0AVfiZF8I455PAdnPJgaXEOdQxoo1beZL5EI?=
 =?us-ascii?Q?SNnKIFztLCaWJCgmqPsV8u2+M3aePNVQE/XRLwYmKSqJI+uOsPwvyknXM53v?=
 =?us-ascii?Q?sL08S72MGs0v5UZdd6rO2vLM8XdYr/UpyZT6eYvv7PFQ2v7Rdf4nu0oJCyRD?=
 =?us-ascii?Q?MY9ZL3thnGhRvRvnUxBFmzuu/6TgoiybGtZqWbl9Yb3TqZlwBk9VfPFC6AGk?=
 =?us-ascii?Q?lHpjBJurob2tYMpS9ztXIef/28i+OR2Kc6aA36E4cON4IEG0CC7a0/lYTwDN?=
 =?us-ascii?Q?KdIuqcKYIkh7o8I54MzSbOry1AKtm1Fw5D43feNJiBKRCQEtzeJqLRodZaIl?=
 =?us-ascii?Q?IkU+IVq+P0cTAm0kEn2nRiwS1ajhiUZTGneYWT8wOg3Pg4E85iXtNkAxLB5c?=
 =?us-ascii?Q?LUCUNfNkD4Mrg+/VCBTDvAewNLTeDsI3GbNk0pH91nn1a8PYW8ecQNSnn9F6?=
 =?us-ascii?Q?tNNoEcw0m5KilSjjGdL6pTut2/MMM/0+OwkZtiSTPE1wPxZBpbSj9eqBjplZ?=
 =?us-ascii?Q?gB9eRcF0RqBRmR/k2tGw3Wp29SnISMSGO5ijmoE8iQCK/gJRPe+fa6/ldb3o?=
 =?us-ascii?Q?CZ0+V1ot5IFERcLRjXv1dV+jMDd0nskE/l1r/Vb7Zj7O2dbq1fWFVg4OV/yq?=
 =?us-ascii?Q?D/YNouWkRtxNP2/JcJ3BnyLh2Sdsi3l8aqIw6tdTapPyeXnZGCeISRSl4hUI?=
 =?us-ascii?Q?HMoDiP17hg/oEQqXbFxz48BOEo5ZUVdM9ULlxa4D5GyaAMWEZrRgYxiuW62D?=
 =?us-ascii?Q?W43r4TN7NtYkM3L/+7zDCs3E4EPXMjwzq6AQHt1pR9mk4vCOMP7frfKaec4t?=
 =?us-ascii?Q?+zJXka5VYmlbeWNbcuSpvIl0Upz16VChvkN2gJBmPWpFVXB8io5hMpGaRf3J?=
 =?us-ascii?Q?KKMpjlEpE1rocfj9OG/1Mx5j1LK0v1cqI4IhsXRKN6qxfflWormVHbraZtDI?=
 =?us-ascii?Q?M+aNKp0j4ToaVd4tse6KaWpQDPfXIx+YWG5EernVS4APRap+66Gt7YZHnnJ2?=
 =?us-ascii?Q?Q+PP5Mhgg5JUNvBZlEqLXqi+rAVWybhr4izgX9XK4GjUK/GQRNg6LJ82HtIe?=
 =?us-ascii?Q?SiVedmOBGfX8RXN3Irh21WYDfUZPqDkvCbZKujy3Q6lfCNVvCNppOqQgbErI?=
 =?us-ascii?Q?VFGVEIp0yNFGnemZnMlAItBTROUTLZa5W3uh8M5i8IK892OUawy2e1h0C32a?=
 =?us-ascii?Q?EGjhyKG3JMhPG4ZQFtTYVvCG4FggDTJWRjcw2fRQGSlYevgeKzChv3s7UNlC?=
 =?us-ascii?Q?i2PQF7QdtRHU0wG5oci7q+unyC/QwbHQrddH/ZzwGhA3/8KpQaFS1CxhV7/r?=
 =?us-ascii?Q?cM3SPS+g45edvYzePdPmRQlmhruLL75LXhUdVdgebWT8b+hCL2vaDJ0UQFBL?=
 =?us-ascii?Q?YIbK+89gySdVLiMAPzIDLLC2s9YJfEQ3OhqWQ7U8dFE22UH3qmAgnpF5fjgT?=
 =?us-ascii?Q?zWEaRSnIW+fi9Grg+12W5SBjJJL5GDOQwgOtVugwuWL+zu/d8sz0BFBl5V2r?=
 =?us-ascii?Q?p94V7OsOIK43xWsUSfhCOzrWoMyPGNIcCazy1aWmGsyvWejsZHsXLkCopJYi?=
 =?us-ascii?Q?XJixBtFVwg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5880.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10e31aa0-4953-43c1-b924-08da4d8bcdaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2022 22:26:47.2501
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /4DkWUuaftr6QeQ7f47eJMoZVo69KFCSyczNk4ayUQLKnseKX17NWExit62RzBP6xOpKtt/QMXzqgd7SqKmiRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2132
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 01:55:31PM +0000, Zhang, Qiang1 wrote:
> > syzbot <syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com> writes:
> >=20
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    6d0c80680317 Add linux-next specific files for 202206=
10
> > > git tree:       linux-next
> > > console output:=20
> > > https://syzkaller.appspot.com/x/log.txt?x=3D13b52c2ff00000
> > > kernel config: =20
> > > https://syzkaller.appspot.com/x/.config?x=3Da30d6e3e814e5931
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D9bb26e7c5e8=
e4fa7e641
> > > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Bi=
nutils for Debian) 2.35.2
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> >=20
> > I don't understand what is going on in linux-next kernel/rcu/tasks.h=20
> > looks different than in Linus's tree.  Paul does that mean you have=20
> > some staged rcu changes?
>=20
> >Less than 100 RCU-related patches in -rcu, so not all that bad.  ;-)
> >
> >But yes, this could possibly be an issue in one of those patches.
>=20
> > Eric
> >=20
> >=20
> > > IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> > > Reported-by: syzbot+9bb26e7c5e8e4fa7e641@syzkaller.appspotmail.com
> > >
> > > ------------[ cut here ]------------
> > > WARNING: CPU: 1 PID: 28639 at kernel/rcu/tasks.h:1664=20
> > > exit_tasks_rcu_finish_trace kernel/rcu/tasks.h:1664 [inline]
> > > WARNING: CPU: 1 PID: 28639 at kernel/rcu/tasks.h:1664
> > > exit_tasks_rcu_finish+0x122/0x1b0 kernel/rcu/tasks.h:1006
>=20
> >The usual way for this warning to trigger is for these a task to exit wh=
ile in an RCU Tasks Trace read-side critical section:
> >
> >	rcu_read_lock_trace();
> >	do_something_that_causes_task_exit();
> >
>=20
> Hi Paul, wether the following scenarios be considered
>=20
> rcu_read_unlock_trace_special
>    ->if (trs.b.blocked)
>        ->raw_spin_lock_irqsave_rcu_node
>        ->list_del_init(&t->trc_blkd_node)
>        ->WRITE_ONCE(t->trc_reader_special.b.blocked, false)
>        ->raw_spin_unlock_irqrestore_rcu_node
>                      ->Inerrrupt
>                             ->schedule
>                                 ->rcu_note_context_switch
>                                     ->rcu_tasks_trace_qs
>                                          If (___rttq_nesting && !READ_ONC=
E((t)->trc_reader_special.b.blocked)=20
>                                                         /*___rttq_nesting=
  =3D=3D1    &&  (t)->trc_reader_special.b.blocked =3Dfalse*/
> 				rcu_tasks_trace_qs_blkd(t)    =20
>    ->WRITE_ONCE(t->trc_reader_nesting, 0)
>     .......
>    -> exit_tasks_rcu_finish
>=20
> Whether the following patch can fix it, or what am I missing?
> Any thoughts?
>=20
> diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h index=20
> f1209ce621c5..c607e4c914d3 100644
> --- a/kernel/rcu/tasks.h
> +++ b/kernel/rcu/tasks.h
> @@ -1247,6 +1247,7 @@ void rcu_read_unlock_trace_special(struct task_stru=
ct *t)
>         struct rcu_tasks_percpu *rtpcp;
>         union rcu_special trs;
>=20
> +       WRITE_ONCE(t->trc_reader_nesting, 0);
>         // Open-coded full-word version of rcu_ld_need_qs().
>         smp_mb(); // Enforce full grace-period ordering.
>         trs =3D smp_load_acquire(&t->trc_reader_special);
> @@ -1267,7 +1268,6 @@ void rcu_read_unlock_trace_special(struct task_stru=
ct *t)
>                 WRITE_ONCE(t->trc_reader_special.b.blocked, false);
>                 raw_spin_unlock_irqrestore_rcu_node(rtpcp, flags);
>         }
> -       WRITE_ONCE(t->trc_reader_nesting, 0);
>  }
>  EXPORT_SYMBOL_GPL(rcu_read_unlock_trace_special);

>Thank you for looking into this!
>
>You do have what I believe to be the correct failure scenario, but the abo=
ve fix would break nested RCU Tasks Trace read-side critical sections.

Hi Paul

Break nested RCU Tasks Trace read-side critical sections? =20
Does it mean the following?

rcu_read_unlock_trace
    -> WRITE_ONCE(t->trc_reader_nesting, INT_MIN);
         /* t->trc_reader_special.s  =3D=3D 0*/
    -> if (likely(!READ_ONCE(t->trc_reader_special.s)) || nesting)
          -> Interrupt
              -> schedule
                 -> rcu_note_context_switch
                     -> rcu_tasks_trace_qs
                              /*___rttq_nesting  =3D=3D INT_MIN    &&  (t)-=
>trc_reader_special.b.blocked =3D=3D false*/
                          ->rcu_tasks_trace_qs_blkd(t)    =20
             /*nesting =3D=3D 0*/
         -> WRITE_ONCE(t->trc_reader_nesting, nesting);
         -> return;
 .........
 exit_tasks_rcu_finish
     trigger Warnings

Or where am I misunderstanding?

Thanks
Zqiang

>
>But would you be willing to try out the patch shown below?

I will try to test it.

>
>							Thanx, Paul
>
>------------------------------------------------------------------------

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h index 0805=
9d8d4f5a7..937a58b3266bf 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -184,7 +184,7 @@ void rcu_tasks_trace_qs_blkd(struct task_struct *t);
 		if (likely(!READ_ONCE((t)->trc_reader_special.b.need_qs)) &&	\
 		    likely(!___rttq_nesting)) {					\
 			rcu_trc_cmpxchg_need_qs((t), 0,	TRC_NEED_QS_CHECKED);	\
-		} else if (___rttq_nesting &&					\
+		} else if (___rttq_nesting && ___rttq_nesting !=3D INT_MIN &&	\
 			   !READ_ONCE((t)->trc_reader_special.b.blocked)) {	\
 			rcu_tasks_trace_qs_blkd(t);				\
 		}								\
diff --git a/include/linux/rcupdate_trace.h b/include/linux/rcupdate_trace.=
h index 6f9c358173989..9bc8cbb33340b 100644
--- a/include/linux/rcupdate_trace.h
+++ b/include/linux/rcupdate_trace.h
@@ -75,7 +75,7 @@ static inline void rcu_read_unlock_trace(void)
 	nesting =3D READ_ONCE(t->trc_reader_nesting) - 1;
 	barrier(); // Critical section before disabling.
 	// Disable IPI-based setting of .need_qs.
-	WRITE_ONCE(t->trc_reader_nesting, INT_MIN);
+	WRITE_ONCE(t->trc_reader_nesting, INT_MIN + nesting);
 	if (likely(!READ_ONCE(t->trc_reader_special.s)) || nesting) {
 		WRITE_ONCE(t->trc_reader_nesting, nesting);
 		return;  // We assume shallow reader nesting.
