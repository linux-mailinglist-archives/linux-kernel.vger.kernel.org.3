Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 540EC55A0FF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbiFXSoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiFXSop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:44:45 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150118.outbound.protection.outlook.com [40.107.15.118])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD071EE15;
        Fri, 24 Jun 2022 11:44:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8hcH6r1hlAj29tTRoQAtayN7wGcect0U/U7kZ/IMp0NzVE57N3byG3xIvG/w3KgqFk99f/FIp88/bXTom8o56i578jvl9gN59sxHS4j22bjyO63fH2x1SGT2gLBwiiaWcS3aklT1+vrW/Gj359NlbOSpHPxB02+9BwbLneifaPN18muR7T8BEjzHjcSoSTQDJ49K6PfR/f9m943czep9G8iGkgI/EycmP7C3O0lzGc1VqQWykZO7QKFe4XqoWXczbAIfyqHiyrMEMEfCRC/l+qnarxMpsrWNP9jlqBjy6pD9egoIG0XuDgOPPF0ek+Y+InFLhVCgnWkdbjMYG+pvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VjMLv22WnmDuLhhndRSRQ6CfUxrvwQPwgDQjqz3smM=;
 b=OeSL4VOcTzp8UMdryGCUKnaTKHht66l6YJdxCenPT+fvHO7atClLTWXhDviPU1BqEiTc//00ekQqBdgzzzRr6jeT+RfVOa2WH9d0ljGsq8YwdX9wHhYcrd8Iozmp94pFC7f1AVz0ta6FG6FCp/mPgjfv2mG65xPD6FqyRPYFlp/1bTQk6E7BJTEB2slqPTLtE2GKqeGT0ZJchhPGBp0bcRmgFBjkeQdAuOFpp9JZA4DfkKo5m2s91fe5Zilr798wP+KXqHP97h99ncAyfsTJLtPTXE/QN725pFCPUmJ03iZX/Oktq4IsTWClg58U4xb9+6Kc1LbkjAhYFq7/lYBQQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=concurrent-rt.com; dmarc=pass action=none
 header.from=concurrent-rt.com; dkim=pass header.d=concurrent-rt.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bksv.onmicrosoft.com;
 s=selector1-bksv-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VjMLv22WnmDuLhhndRSRQ6CfUxrvwQPwgDQjqz3smM=;
 b=dPb/uwHiQ71U8tr+ZIKh/W7iOKIW6mjVICpYUZD1E70V3pkwdMOeobru8UOxDVw9MJV/XnaMQbFLGdfrWhlKp9UjoNx5rO2dMqvAmPQIEHoFnlYnMWyOlis+8ziUCDQlQMOdKnH+jCOnUrM5X2vh7bLplOoqDfnZYsySSityUzI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=concurrent-rt.com;
Received: from VI1PR09MB3582.eurprd09.prod.outlook.com (2603:10a6:803:13b::17)
 by AM7PR09MB3669.eurprd09.prod.outlook.com (2603:10a6:20b:109::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.15; Fri, 24 Jun
 2022 18:44:41 +0000
Received: from VI1PR09MB3582.eurprd09.prod.outlook.com
 ([fe80::10ca:5087:bbde:5678]) by VI1PR09MB3582.eurprd09.prod.outlook.com
 ([fe80::10ca:5087:bbde:5678%8]) with mapi id 15.20.5373.017; Fri, 24 Jun 2022
 18:44:40 +0000
Date:   Fri, 24 Jun 2022 14:44:31 -0400
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
Message-ID: <20220624184431.GA4386@zipoli.concurrent-rt.com>
Reply-To: Joe Korty <joe.korty@concurrent-rt.com>
References: <VI1PR09MB358214376379A2D6B024A689A0B39@VI1PR09MB3582.eurprd09.prod.outlook.com>
 <YrXtH1z2JSmwLS7W@T470>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrXtH1z2JSmwLS7W@T470>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: SN6PR16CA0065.namprd16.prod.outlook.com
 (2603:10b6:805:ca::42) To VI1PR09MB3582.eurprd09.prod.outlook.com
 (2603:10a6:803:13b::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56ad630a-633b-4415-31e6-08da561198a5
X-MS-TrafficTypeDiagnostic: AM7PR09MB3669:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F241NTWSyTu+o3WhIaydBdcnjmKlaTXNerUVt75vthJoRG3ZB7DjuA3UuOuCF1F2futJ3flulk5gI6/tJItAdcBnOUVGrukZNOyq0i1qoH7XR9G4JjNJ7bS0LRKiVkJo0JEeiMqy92TdR1ApBEi9L07LpjrhkFo6Bh7c6KEOI2WN+dPNVZHsPKWTReR5YuyH0tnEDsq5B4pu5b/W5Hg0lML2SzU1LRK7kFLBuEQI9gSZdvOivl8B3uo4n2XTM+XtvKmvD94t72wuJPjcHVLBN3Uj0/GD1Ik4YyzUffBas7gq4H/f8UfxY1dSlwQYydLztXzPpC0zSsDALzrWUK31Afj0ohH2V/MHUG+89+jwvbvjVkcP475ozr1KDdyNwLpB7R3+GaIfYogjDBhyi6qaECAa6H5dMzYJD446eWFaRj4dv4Ze1DyFQvYgltQnxjKAmK+ycALrCcFzxFmGY9q3kmNiU0Wy4UvGuRTpx7/137kRreOSI5rnKdOohIBPIoqRh33+z+Hkm0wKU6AzoBJzonovRsN3oN0z6EybEXOHKq3RoAo8q6IXNL7emuYobIm23W3V0gJtY8YOecF89vVxmAkrQ+YHy0CgrPEDMi4K7X1q0cVS33Cklkfnzvmhc4N+vFlo+ObktHUfxlT1ZjS8lTQxBbHpz7QK/SQ9NbyFGkTlPsEE9Opma77lHgOXg/TV74XcIzR6aSpllxpGogNKeFO4IKff88cInpCKVl5zX3DkNenu//ME6eC+OAMfgPmn
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR09MB3582.eurprd09.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39850400004)(376002)(346002)(396003)(136003)(366004)(66556008)(3450700001)(6916009)(66946007)(26005)(2906002)(45080400002)(6512007)(54906003)(44832011)(38100700002)(38350700002)(8676002)(33656002)(41300700001)(84970400001)(316002)(66476007)(478600001)(6486002)(8936002)(4326008)(86362001)(6506007)(83380400001)(1076003)(6666004)(186003)(52116002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yDwEZ1QZSXK8gPtAO4hWzRMjgQDZYUFwg9woF2Ptme0QJEcLNpN441FD0BgX?=
 =?us-ascii?Q?z8lyouCCjcJaVEnjidkc3OcPFCEsmti08Dy9QF56TcpDAqNEevG0dJSHo/Cx?=
 =?us-ascii?Q?IrinzJS5Pp/jCsiyvc9KHOkvYdeunF25Ee/S6u8r+m6wtsMxgLGD9TSJJJvh?=
 =?us-ascii?Q?+gJLCb4v3I9zKm7IbMLQMKqf2lr15RHW0n8BarZeM0XgfGhfm9XBrRoYyC09?=
 =?us-ascii?Q?NzOmVRiEyvkyujBXdlU8VVdwGRzpNHfjAUyk0+oTi3E0mCTBOUqfe/5GgNaf?=
 =?us-ascii?Q?PmzL4GwLB+pMt9cvAfjtv6LTc+OIdM37yRuRKg6L6QE9mhaIA1FdHRXww1+w?=
 =?us-ascii?Q?bohyNzJrNX3GMOGrXIKo5Q5SrixpxCv3gGjpFAs/khpmEGiZfjbmhdrpzO3Q?=
 =?us-ascii?Q?6XfC9V8pVYS/KUqLlb+WIbZtRLyy2mtaw6giX3i4bqgaoGc23FkwMBGXyaOy?=
 =?us-ascii?Q?4ySObjpls8Sba7raZwCdWWjszXY3BwK/w8XdcXsRU4LDvBhhttNVd63/iw0l?=
 =?us-ascii?Q?K4D31dxJlbexWDI2g398eh2vZChxMY83Q77hQCHHhC4+e14JSF/GmJ2qQrAP?=
 =?us-ascii?Q?OIDBJqPgM7aBAufA3iJ2cDIkYCjHEsdJVaE/uwMhZUAKxT2yBNAMFuxGtPvb?=
 =?us-ascii?Q?ScmDsTPnTYgSeQufWIlktsyqqiCGDuIL5BBeXkzyKcOfMAg+h5Lgr5h6rWmy?=
 =?us-ascii?Q?eRb0OUEl649okgOosOy05vzG5qfSuNgSl7zVOO1LFt+s6E+Fnwj0HowkJPa8?=
 =?us-ascii?Q?hsXlf00Lw6MX9ObjsgIWcpqAj/FHIzWC0ydhkUn2M0Kg93jN2sP09S2UMeld?=
 =?us-ascii?Q?k8AwYN7NBcT4FoysBnZXSJD1d1GQhWjZXL1b9HYiqKIeKlfdOOZTaY5mjLNB?=
 =?us-ascii?Q?di4nY5fsZw1T5Md9Gfx5NXjvaX055ZZGgBiE4lMCOeOpLID/SKXioUbZEnax?=
 =?us-ascii?Q?DineB/c622CnC8cEaM/6J5KTRHIb+6O3rVlpFHshtxVsJx9/chXQJGWa1zLy?=
 =?us-ascii?Q?hB7ZcK4imlmNx2FrGb4cgiaHrlgNvCPZoYDzoKLTknApaodyTg/Z/v0wTt+7?=
 =?us-ascii?Q?gRg7ZHda4kVQG4E7u6n/iOfJSwcS7T3fe91IiEUWszf+ICv245aXW8n1JCDX?=
 =?us-ascii?Q?Z+e6b4JGWQdMbGpvEag6yV6/YdY3qBcvhGF6Sdgz4Yg/GNqSrwJd33CGP7OU?=
 =?us-ascii?Q?vZllAwfM6+8qgItZvjLfQN+lRENlfdVw+jEOaOwi93gbpFzf2xApNM3iYaEq?=
 =?us-ascii?Q?O2BtpmJnxSQWRfahs5k53sxg195PT5yU5YdNz7/X38aeor3HRV7M/p8qZGND?=
 =?us-ascii?Q?TkyAXTDH/9Qkd4e6Yv1gWosVDfznHEUvYZSrDkxb6AoV8KNlS8bhdL4T9GkN?=
 =?us-ascii?Q?82aANw/pAHiY6Mm9bqmMCvvrJotu0X5DQpDm110go0IWhG0Cnhh17Q68QSop?=
 =?us-ascii?Q?a7xCi5avSzseyZxnphQ1c4Ks84MwXAMmHklNj2N+Q06nWxVGR28snWaDs7JC?=
 =?us-ascii?Q?GPQMYLkyiXoX6Qhxe8ijreV+6FP1dOD6k3I2ImBb8e685L6+tQvrqwgIMTgZ?=
 =?us-ascii?Q?9yEiUHM53aMLofGaOu8fFkqL7zSCfmR/n2nLmMc2qNTaP1FUR0Ad+B69YvGA?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: concurrent-rt.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56ad630a-633b-4415-31e6-08da561198a5
X-MS-Exchange-CrossTenant-AuthSource: VI1PR09MB3582.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2022 18:44:40.6576
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 6cce74a3-3975-45e0-9893-b072988b30b6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oSVgSFpwTfK177vscFKdIW9EvI5T3L5dUPO/hYfFuO0jgYFyI53AbA+5IE6bhCbIxbA4m3rZ0vEBgb3OZwho+XWwBFfDQ2f+gVcnfbHLk/M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR09MB3669
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Fixed incorrect linux-rt-users email address in CC ]

On Fri, Jun 24, 2022 at 09:58:07AM -0700, Mark Gross wrote:
> On Tue, Jun 21, 2022 at 03:16:39PM +0000, Joe Korty wrote:
> > Mismatched get_uid/free_uid usage in signals in 4.9.312-rt193
> >
> >      [  First attempt using mutt did not show up on the mailing lists.
> >         Trying again with office365 Outlook.   Also added the 4.9-rt
> >         maintainers. ]
> >
> > The 4.19-rt patch,
> >
> >    0329-signal-Prevent-double-free-of-user-struct.patch
> >
> > needs to be ported to LAG 4.9-rt, as that release now has the Linus commit,
> What does LAG stand for?

Hi Mark,
LAG = Latest and Greatest



> FWIW the cherry-pick within the RT-stable tree worked without conflict.
>     (cherry picked from commit a99e09659e6cd4b633c3689f2c3aa5f8a816fe5b)
> It compiles.
> See 58a584ee59b2 signal: Prevent double-free of user struct in
> linux-stable-rt.git/v4.9-rt-next
> 
> >
> >    fda31c50292a ("signal: avoid double atomic counter increments for user accounting")
> >
> This was added to 4.9.y on March 20, 2020.
> commit 4306259ff6b8b682322d9aeb0c12b27c61c4a548 in linux-stable.
> 
> How did you find this issue?  What is missing from my testing?
> 
> Do you have a test case that I can conferm my cherry-pick works?
> Could you test the v4.9-rt-next branch to see if it fixes you issue?

We do not have a standard test.  We were seeing crashes in NFS.  It happened
only on arm64 systems.  We have a custom kernel with changes and the test
consisted of exercising one of those changes, which involved lots of signals,
then running NFS tests in loopback mode.  On occasion NFS would crash in
a way it never has crashed before, which suggested use-after-free corruption.
It never would crash unless we hit signals heavily first, which implied that
something in signals was wrong.  After that it wasn't too hard to find the
patch that fixed the problem in 4.4, 4.14, 4.19, 5.4, and 5.10.

We have not seen the NFS crash since applying the fix.

Joe


PS: Correction to the table below.  I tested a too-early version of 4.14-rt.  Retested.

Current application status:

   4.4.302-rt232        OK      has both Linus's patch and the fix needed for rt.
   4.9.312-rt193        BROKE   has Linus's patch but not the fix.
-  4.14.87-rt50         OK      does NOT have either Linus's patch nor its rt fix.
+  4.14.282-rt135       OK      has both Linus's patch and the fix needed for rt.
   4.19.246-rt110       OK      has both Linus's patch and the fix needed for rt.
   5.4.193-rt74         OK      has both Linus's patch and the fix needed for rt.
   5.10.120-rt70        OK      has both Linus's patch and the fix needed for rt.
   5.15.44-rt46         UNKNOWN no get_uid/free_uid usage in kernel/signal.c anymore.
