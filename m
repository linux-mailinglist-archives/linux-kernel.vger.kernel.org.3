Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4FB55B1E6
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 14:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234384AbiFZMaf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 08:30:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiFZMac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 08:30:32 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130117.outbound.protection.outlook.com [40.107.13.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3417659;
        Sun, 26 Jun 2022 05:30:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgXjXdTxBaAE0iZ3ooj4HdC//d0a3fOz2ptuqBkn9SmX/vJQ3fkYTay24ySPR685uM/3F3kASqb+WazBbx5iDjCnjEdBgESYEChh1ksRtgVuUDJxuZFGkBTjxYNCsWweYiIW2Jblqb+HJN+3ooaXx3ktg92l+j3ZoOn919q8tjICdzPGLAW/eU5zgRNXyuLgo8wtbUyVm1KCyfh6h7lcgNBKKakhHavIJt7lER8FGn/6CQo3Dx6RrbiRzGLhhIV1wJPFTZJ4SI4mT5eMnO615/gGxtsBz7Eg2+5DPzKHfsAUdy7/JEMf+AH5Prxa/Va9iPnlCONn3caKSFtpCozYuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xEco4PvXTvA2SLzNhWphs57X/9NpVHztw9DneAqw8vA=;
 b=bbUbit9mLzeHYtbV74JZyXTNtaNPnCEC78Uycm+f+S1DNypPGRZcA47v46Pp+u0mBdrA7jfs/hw9fZkepVua7RPLYp+Ese4M5KXGMZizBm5VPNSBGlnkSL73DobTX4N59wUdiJFMdSGqn8hrr+kIXvQn+A9FJXKe3kKeeb8NNvpxwd6PqrMNobilYvqL69tHSvQx+jwByqAw4U72RUycbhOjBbCytD8nY0QxTGXvP+ydBSyQWJZ2JC9OD8MDSP0BVms9PuhkFr0LMtBniPVGHz4yYbNM9cCUvr+3+gBrgJaL3Jg67pa+XX3T3u7b/pD016vPdDxglYaJusip+o9izg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bksv.onmicrosoft.com;
 s=selector1-bksv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xEco4PvXTvA2SLzNhWphs57X/9NpVHztw9DneAqw8vA=;
 b=qC8My19XMwnmBoP3udLZXSQ9AEBFBoTsqmQZI1lDMUOTl2Yj+thAw0xN+6iMBrxcAwwi+ySehJTeRr3/u2zUM6fsPZ8/SBZM15fK1Btw2s0zYOx+Q8goSw81lNJaau2lSR3W7vTXi1nk794TyhW+EULkdrL4pcX+XVARkujfEH8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=concurrent-rt.com;
Received: from VI1PR09MB3582.eurprd09.prod.outlook.com (2603:10a6:803:13b::17)
 by AM5PR0902MB1972.eurprd09.prod.outlook.com (2603:10a6:206:c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.16; Sun, 26 Jun
 2022 12:30:26 +0000
Received: from VI1PR09MB3582.eurprd09.prod.outlook.com
 ([fe80::10ca:5087:bbde:5678]) by VI1PR09MB3582.eurprd09.prod.outlook.com
 ([fe80::10ca:5087:bbde:5678%8]) with mapi id 15.20.5373.018; Sun, 26 Jun 2022
 12:30:25 +0000
Date:   Sun, 26 Jun 2022 08:30:19 -0400
From:   Joe Korty <joe.korty@concurrent-rt.com>
To:     Mark Gross <markgross@kernel.org>
Cc:     "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux RT users <linux-rt-users@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [RT BUG] Mismatched get_uid/free_uid usage in signals in some
 rts (2nd try)
Message-ID: <20220626123019.GA51149@zipoli.concurrent-rt.com>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
References: <VI1PR09MB358214376379A2D6B024A689A0B39@VI1PR09MB3582.eurprd09.prod.outlook.com>
 <YrXtH1z2JSmwLS7W@T470>
 <20220624184431.GA4386@zipoli.concurrent-rt.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624184431.GA4386@zipoli.concurrent-rt.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: BN1PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:408:e2::8) To VI1PR09MB3582.eurprd09.prod.outlook.com
 (2603:10a6:803:13b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eaac065e-7721-4017-5561-08da576fa577
X-MS-TrafficTypeDiagnostic: AM5PR0902MB1972:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 27E01WBSbyV8zySU4cma9ZHhgXWhRjcIYm1Qx/3/sEqkPWB0EDFHQGKmgb4BwX5C7n70H+9GEHhHvPeAaxZxrYqbE98K8yjOsIS9H+PeqpOxt787+4eq5nYWRvQrGciCL54xs15d8MRYv+tMUR8H+jdZ4IrFMpTt3Rgy849wWJDkhaaGQNoKaCfB2/ApN3MGF5YEhrm/N443c+xPp7dcXVHrFJThp024hjhUZYutRMQQcfqoJ+S6n+QdP+6Eu0vV9AGf2dkFrvVk89WkdyHUB+0W9WLDtMWJ9VbpuhS+b2MpR88Jlzuj7bIAmm1NPFGHS/eosdwiNPtyGc77FMEy6StSc70A2+JlOAI/uRY+i2uYP90RcfGWXRaoWbcmWYmy8Gg5R+k2A3a15WPWnRQ6hIGYIRXDnZVDQnx6C5tfJFTC+O3OvFeatL2rCE/uQrKDKXM2QYI02241hrHAPVSSD1VnvOD5ux3RG8AlXd8Hy6mw8zk5HaQ2FVn507is9PzANcxYfzCOuIlDGAECuqwrzAURxRJn2+1vtSJRV0ALx9mey+uLle1EEIUhqvnOz7zBHI0PlX7rel07l7RD8xKxr7RH9cECb2Cn6wXG8NLd6A/eJdyg0HjqxucTDc6lg0mcaP22ohC9G800w7aCCGQUbJyj9EW3cAXzP/Oorqzvm1SVnh8ErWDoAu5j7bJGVuNpd2Dd2az94DLU220I+E2EHQMHLREofN5GAVMB3q0X94FmyQHJwIjU+s2EbImqP63evE48CS1IcLBMwn3jj0zyZPjpGw2XNVJJHatjrhQ0f3sT61zg9vaHOV5vZ0Bf2sY7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR09MB3582.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(39840400004)(376002)(366004)(83380400001)(33656002)(6486002)(6916009)(45080400002)(3450700001)(86362001)(186003)(44832011)(38350700002)(2906002)(5660300002)(1076003)(316002)(8936002)(66946007)(66476007)(4326008)(478600001)(66556008)(8676002)(84970400001)(54906003)(6506007)(26005)(6512007)(52116002)(41300700001)(6666004)(38100700002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pq4cdp744fuFMNUEXGRcPWbiRTdQxbnEJ/u/UoMlkjZOq2YcSZUXeHBi4yMI?=
 =?us-ascii?Q?986JrJwqnTMra1MmUCN2mQ+LZimmJHW5U6802meFLlqy+FyQFGZ73SUyTxwA?=
 =?us-ascii?Q?gmunvoMB5EyCbVwNZoxsHdujbAqWuVT7MYpn+xKLPjqn1xv2+0qgJuPReFNI?=
 =?us-ascii?Q?Vv+pK/u4lOHMHn65RFGsFKP8rJpgR8mSl886gog9IWj8+SvfmF9SCOE014Oo?=
 =?us-ascii?Q?T0+fMBnjuLnYFqE3Xadhv453i7ioKN7sE/S2x+1VpFGfHKMsLngN7l3uEXpf?=
 =?us-ascii?Q?FWzasV6tAaK/Gg9K1JD2Bp6zV61fh+xmcmjXrnBp3enVin//g8Sp20ydq6QB?=
 =?us-ascii?Q?qp4zQTUwamZn93g4xfjTyApBte38YjTSuTrNC3/gir4rJd/42GygwNK/k/6e?=
 =?us-ascii?Q?p49U3nXzi1RibFBGxGk5PhdaJxK5sORRtPKfozum97hmRDxJ7TtbCMm8xy9V?=
 =?us-ascii?Q?oVMhVbrJE37twfYjtXzWwHPTo6OT4CLOl17jAJLF9oXjrny8GBiCvNcMqwsw?=
 =?us-ascii?Q?7QWBVA184JxdLO90jVtqTI3ijEEi3pBJC0JW1dt65BqS4uohMM9suvYAHzMj?=
 =?us-ascii?Q?LrwDygSDX6LuTXFgLRHqO5vdr119GYsWhLlzdQlILPMNMgEtSXQ98HiWsCSB?=
 =?us-ascii?Q?rh5hOUs+95kVRW659a0N3UYEil4+1KDeQhnURnoPBpa79JzSB8wOJEqWktwS?=
 =?us-ascii?Q?W2J35nelSHhdF/3TMHyvbpEgFDYx7zqi9+WmuWsNuqQTHWzt0zpttLLg8DVl?=
 =?us-ascii?Q?26KHuSIzw1GpghTQDPoDPDAVhsJpk3sdYsleweFJKshavxcwPD2CzSGRlIEu?=
 =?us-ascii?Q?Aavp1nL4L0wPQLnYvSS72lvfCJ5yDHcK9gbpuhIsgKd624MW8AbTXAsfV+p1?=
 =?us-ascii?Q?0WvXi/fsIvUnjnQhud4teEP3/kdvr7lFgdvtliw0gUE//iv6y8yAK9bemt2W?=
 =?us-ascii?Q?IgT6n6qVfNBG/+0RJX4LGxgFhEHJrvCRQnCcpQgwRXrATxNsc1///h19dDJz?=
 =?us-ascii?Q?mLxVAmHuGm0mA+qk3HoA546aDMZKFrVUKpZQyS8QCbLaCOar1uei+dk8E1Rt?=
 =?us-ascii?Q?Va6XbC2OqCRl9BpwpVWlqHdj51oAi/huQgXW0chKnEqdm4g17YRx9yOcOOq8?=
 =?us-ascii?Q?v1omFy7TIpfiYRHqx10oVXpveIFrY4/3ovqqXBQpqeDMirdxXZDJxnzCymY+?=
 =?us-ascii?Q?ii8c2IlDpdAHD7AU2xPM2aU3bi9cfqm2EjOzQEwg/J5LNx6lACRDTwBrlsm3?=
 =?us-ascii?Q?onJ8REv0VxyAU/rf7Ck1D6RhhpucRYXwPF4WsCqHsGPiNZwkOyVZENmzLJ1x?=
 =?us-ascii?Q?l1kCad1vovm/eCrJkiEu6niRx1P0jMwExHOUDF5sO9+ilS+u9j+pK0Gku1QD?=
 =?us-ascii?Q?gZ4tzV3s7DSAVFpxAKooBGb2LKFLI5wzrGLnasPpSRbQ6Wva27KL69csoV4a?=
 =?us-ascii?Q?okSuKzTWnDTrC+srAahMe16wFhKctxUs1/qSETSQtooZeUSjszjiHypfjX6f?=
 =?us-ascii?Q?uGOJl21hn+RB5xozp6/k28ShTnG/YVKScvASXMyJhsDc/Uz9Nkuy7RFvlksu?=
 =?us-ascii?Q?QUg2ZKZ2tV70aYnOzWk9AiIOhAZxUMnSVp9lrsIx1/Y6AvwSZg8ptFHmQljs?=
 =?us-ascii?Q?bQ=3D=3D?=
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaac065e-7721-4017-5561-08da576fa577
X-MS-Exchange-CrossTenant-AuthSource: VI1PR09MB3582.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2022 12:30:25.7906
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6cce74a3-3975-45e0-9893-b072988b30b6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vU0VmVSV7kl+f9jTQ4dMlvUkgQCkPzTQNNKkidNmOk1g4K9l0XvyqdhCMO2PyKb4wsW1IVlP4r6SCaBAGeFPgaHAlYQNKW5923NRLc1zCQk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0902MB1972
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 02:44:31PM -0400, Joe Korty wrote:
> [ Fixed incorrect linux-rt-users email address in CC ]
> 
> On Fri, Jun 24, 2022 at 09:58:07AM -0700, Mark Gross wrote:
> > On Tue, Jun 21, 2022 at 03:16:39PM +0000, Joe Korty wrote:
> > > Mismatched get_uid/free_uid usage in signals in 4.9.312-rt193
> > >
> > >      [  First attempt using mutt did not show up on the mailing lists.
> > >         Trying again with office365 Outlook.   Also added the 4.9-rt
> > >         maintainers. ]
> > >
> > > The 4.19-rt patch,
> > >
> > >    0329-signal-Prevent-double-free-of-user-struct.patch
> > >
> > > needs to be ported to LAG 4.9-rt, as that release now has the Linus commit,
> > What does LAG stand for?
> 
> Hi Mark,
> LAG = Latest and Greatest
> 
> 
> 
> > FWIW the cherry-pick within the RT-stable tree worked without conflict.
> >     (cherry picked from commit a99e09659e6cd4b633c3689f2c3aa5f8a816fe5b)
> > It compiles.
> > See 58a584ee59b2 signal: Prevent double-free of user struct in
> > linux-stable-rt.git/v4.9-rt-next


Hi Mark,
Absent an actual test of your port of a99e09659e6c to 4.9-rt, I just
eye-verified that the change it makes to sigqueue_free_current looks
correct.  In detail,

  matches the same change the Linus patch makes to __sigqueue_free (ie,
  to the routine that sigqueue_free_current is a copy of).

  That the new variable 'up', in sigqueue_free_current, is being used
  in the patch (some variants of this fix do not have 'up'), and that
  variable is present in 4.9's version of sigqueue_free_current.
  
  That atomic_dec_and_test, rather than the refcounting version of that
  some function, is being used (some versions of this patch are refcounted
  instead).
  
Regards,
Joe
