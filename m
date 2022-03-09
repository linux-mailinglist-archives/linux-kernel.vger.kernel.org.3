Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED984D31D3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 16:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233903AbiCIPdj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 10:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231816AbiCIPdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:33:37 -0500
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01olkn2078.outbound.protection.outlook.com [40.92.99.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A96D062E8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 07:32:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EE8CCH/hpycom55Mnu9POSIEINIktQQVMMf04+uPs0x/Z/dl/epMl1z/AvKQ/g/Rm/6pVNFKPoUny/SCV6kiQCfYg+dOr055bdrsb8z1LumLnsmA9JIHqP9dv7nDoAkwbHjlqHV4qHQddipPj9DpNVwqAPEXcG48yJigbpOwX8enBwA1GqrD+sCCk2Onv/84UcxpZnKNyFUqoB9SgEYYrRkir4VcS6G+mehUzjDglZcqQQL0GQCCGjxNb8TlEPtE2zIB0zZ2A/pETAifN6mYL1xQrFLaIzUA25tuyif0yLzCgtU0C45B5B+oC14avBvy/7ZA4HsHBruvh++zYvjA+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=95psHVVURXt6HiMTwWMsSBWjaRgfmiyT5/Z+NofyqGQ=;
 b=bf3CKnDjc344qRzB5qpzdYa04DZ+Cplmmi8ZaTKuh2P8kfu2THkOEiHh4WBNZEG9HK1TUpxVH/uhupptvggTeGBzKIu2NXenOwhanSyM0L3xeyWiewvIh9iGru0KMWoGrYkVvROQjATprCGqkcTtOhRZTZ3hfTxM5sdWWCQW8us5YnmBjkElKdRrUPMizwnRH8oU/L6qbgIMZQZEsrXCdokFmcLQJO7ADnHs0yr9K0x32Lb2mtMFivbQbOiIrBdZ5dHBIqvkJ44zPb2RuGM3CW2xSmHRNyoSeVxDql0uL1EuZkFe0iP2hEhY9StF8FKbTBHvucafoSZ83z2uCTEdhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11e::14)
 by TYCP286MB0880.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:78::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Wed, 9 Mar
 2022 15:32:33 +0000
Received: from TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d80d:59f5:2572:ab1d]) by TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d80d:59f5:2572:ab1d%5]) with mapi id 15.20.5038.027; Wed, 9 Mar 2022
 15:32:33 +0000
From:   Oscar Shiang <oscar0225@livemail.tw>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [patch v11 00/13] extensible prctl task isolation interface and vmstat sync
Date:   Wed,  9 Mar 2022 23:31:59 +0800
Message-ID: <TYCP286MB1913B65EAA86A871FFF86AB5A10A9@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YidWQ28Jgs/FpmL1@fuller.cnet>
References: <YidWQ28Jgs/FpmL1@fuller.cnet>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [TMkQrxER+VRyjUELH47FDhVE+IN4sKSp]
X-ClientProxiedBy: HK2PR02CA0158.apcprd02.prod.outlook.com
 (2603:1096:201:1f::18) To TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:11e::14)
X-Microsoft-Original-Message-ID: <20220309153159.4152-1-oscar0225@livemail.tw>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4147448a-c7ba-44c3-dfce-08da01e207cf
X-MS-TrafficTypeDiagnostic: TYCP286MB0880:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 85wBzyDV/tqJz+5auEqwFz15o1mKQ2Vtl7ptwl2SuF0BkOq9Xv+oB6WWly70YSuEbPl+/nrn/VCxC5DjOKvNe3Vm82PdMjBrEFCLSKZ8hvIy7GsmLe/o6iNJAngGLXlarjYV2T8t5B5QqBHcNKJbGTySGHkteQX1YJsZikCZXRxHxPovBQRHUCiU9ZdHVsD3WDgzpb0m4SxCFUXqS2rSG70vsq39uBu1PTsCVoP3+GNhaZSl+DZFGNxcws2TxBkJVsd7qDz3b1/EzSfQ592tSVyKI65T3exQj+4HFxR4Hof8f1ey9+DTcAKA8V1aEfScusjnEptDkhbsWaNTclGmAy1WG8f+SKb8Qh1eMnSEyUmk+vlKW6qVotImQlYtpM15zWGqnhtOX38nz4AB7zA+a5+VnWKajyOkGuX6+AHeeJ3e50AaLMw+p4agtYCTHgBj5K8a9Mqc9Rqqy3Ck8fkMVu9KNZJcWqK1H3NUotTxW4Iu+kyUnl2yIRl1ASs5EaO41pE7xo7pESCPBLaS8LZGaEv1lM71FdFMUTURwBXxOzlNFhutvZfJ6K2aDmOQjC2iMOLXk2nPp62OOPw33Cft3En8/NSBatjKe3kpLMc1K4r3mmeoU14wklVDPNqSsGWh
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i89dXuuvgN1rE1fNSvOO+ZAccb2gDlBZwi7fkTfLVNl43kuVn+78E4YXl74e?=
 =?us-ascii?Q?jTkPNhJPetPtUcSH+giHWcKavN5o2EiHGjzrXe4egabeyQsX6grEMO2RIAdB?=
 =?us-ascii?Q?r+cY3gkIPI8y6GquY0LAtKTCN0NC3xGHqU0ywhuJBR5TwJKOrFNa99kKZEuS?=
 =?us-ascii?Q?DfuDX/t5fDrIuI7gTKXJC/89x6YiYXcI9jYi0Duqp4KEMBEgp63crGFPtked?=
 =?us-ascii?Q?1jtv0wDQXAd8ii2MwHSI6Aj8NMfDmlfFcNrhMjcciJanThzgtluWeQzLSKpR?=
 =?us-ascii?Q?OgwzhTfUN8HfGahuwU7Xan2lv7tNYk8DzTSGc5XSF4pzSRPQVM7E89AZ6IaB?=
 =?us-ascii?Q?hTb50Pz8/q73N0/rgipnrSdCtEF8BnPlvNxyjJkXENqtS9rd5JeAzDG1vBoh?=
 =?us-ascii?Q?SDYNIYPSWRg9NhjTKB0UZPOlX0PPN5IS4qG5iXosgm1XtBvR/045ixRmUTi9?=
 =?us-ascii?Q?Cg5Z5Q2fAeQjUNqg78yRLnPADolhZJJ6z4hEEMFct4bWa5I5MmRBVjFEJpV5?=
 =?us-ascii?Q?gf+79fwyeK698o7T2dhzyDkLmYgfIPuNagsrijiRRClKXNrfX9CfkV0y+ihy?=
 =?us-ascii?Q?9g45tbG1LjOKhbHx93v5+xkSbDqG7gR1X1cG5WMpDDgXRssw/mJw3EYhkKRD?=
 =?us-ascii?Q?v7Rl4Y7Jp0tzAx8ygXg0ace4ExO9Ciit20gYunU2Jrb5HKQL40vz1LAI0QgG?=
 =?us-ascii?Q?DMadGgmBkoB4UhrW2ljeYDUQ3kK+Joug/cH1BPrKfUGFnQDJH6LbJOSLCtaP?=
 =?us-ascii?Q?PochBOt60SaPxO9qkt4OFsEVNvwJHGvUGtJvX6Bvt6TkOlvm0LHG4Lgid5PR?=
 =?us-ascii?Q?X1RY5H89tF5ttlySq0xwbysLhkUKnwnr9t6Qxi7HxkWndK9Un/VZlzGAGUrY?=
 =?us-ascii?Q?KYvTV6dqgX0R1mpg0RjzbOKj7+VlH0poVo9xflhc/t45fPoqkaWYeROEJiAR?=
 =?us-ascii?Q?Tow4C2kgjGJLkfeL4dG35Q=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 4147448a-c7ba-44c3-dfce-08da01e207cf
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 15:32:33.3990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB0880
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 8, 2022, at 9:12 PM, Marcelo Tosatti <mtosatti@redhat.com> wrote:
> On Tue, Mar 08, 2022 at 02:32:46PM +0800, Oscar Shiang wrote:
> > On Feb 24, 2022, at 1:31 AM, Marcelo Tosatti <mtosatti@redhat.com> wrote:
> > > Hi Oscar,
> > > 
> > > On Sat, Feb 19, 2022 at 04:02:10PM +0800, Oscar Shiang wrote:
> > > > Hi Marcelo,
> > > > 
> > > > I tried to apply your patches to kernel v5.15.18-rt28 and measured
> > > > the latencies through oslat [1].
> > > > 
> > > > It turns out that the peak latency (around 100us) can drop to about 90us.
> > > > The result is impressive since I only changed the guest's kernel
> > > > instead of installing the patched kernel to both host and guest.
> > > > 
> > > > However, I am still curious about:
> > > > 1) Why did I catch a bigger maximum latency in almost each of the
> > > >   results of applying task isolation patches? Or does it come from
> > > >   other reasons?
> > > 
> > > There are a number of things that need to be done in order to have an 
> > > "well enough" isolated CPU so you can measure latency reliably:
> > > 
> > > * Boot a kernel with isolated CPU (or better, use realtime-virtual-host profile of
> > > https://github.com/redhat-performance/tuned.git, which does a bunch of
> > > other things to avoid interruptions to isolated CPUs).
> > > * Apply the userspace patches at https://people.redhat.com/~mtosatti/task-isol-v6-userspace-patches/
> > > to util-linux and rt-tests.
> > > 
> > > Run oslat with chisol:
> > > 
> > > chisol -q vmstat_sync -I conf oslat -c ...
> > > 
> > > Where chisol is from patched util-linux and oslat from patched rt-tests.
> > > 
> > > If you had "-f 1" (FIFO priority), on oslat, then the vmstat work would be hung.
> > > 
> > > Are you doing those things?
> > > 
> > > > 2) Why did we only get a 10us improvement on quiescing vmstat?
> > > 
> > > If you did not have FIFO priority on oslat, then other daemons 
> > > could be interrupting it, so better make sure the 10us improvement 
> > > you see is due to vmstat_flush workqueue work not executing anymore.
> > > 
> > > The testcase i use is: 
> > > 
> > > Stock kernel:
> > > 
> > > terminal 1: 
> > > # oslat -f 1 -c X ...
> > > 
> > > terminal 2:
> > > # echo 1 > /proc/sys/vm/stat_refresh
> > > (hang)
> > > 
> > > Patched kernel:
> > > 
> > > terminal 1: 
> > > # chisol -q vmstat_sync -I conf oslat -f 1 -c X ...
> > > 
> > > terminal 2:
> > > # echo 1 > /proc/sys/vm/stat_refresh
> > > # 
> > 
> > Sure, I did see the terminal hung during oslat with FIFO priority.
> > 
> > BTW, thanks for providing this test case. I used to run all workload stuff to just
> > verify the improvement of task isolation. It is a more straightr- forward way to do.
> > 
> > > > [1]: The result and the test scripts I used can be found at
> > > > https://gist.github.com/OscarShiang/8b530a00f472fd1c39f5979ee601516d#testing-task-isolation-via-oslat
> > > 
> > > OK, you seem to be doing everything necessary for chisol 
> > > to work. Does /proc/pid/task_isolation of the oslat worker thread
> > > (note its not the same pid as the main oslat thread) show "vmstat"
> > > configured and activated for quiesce?
> > 
> > The status of task_isolation seems to be set properly with "vmstat" and activated
> > 
> > > However 100us is really high. You should be able to get < 10us with
> > > realtime-virtual-host (i see 4us on an idle system).
> > > 
> > > The answer might be: because 10us is what it takes to execute
> > > vmstat_worker on the isolated CPU (you can verify with tracepoints).
> > > 
> > > That time depends on the number of per-CPU vmstat variables that need flushing, 
> > > i suppose...
> > 
> > Considering the interferences outside of the KVM, I have redone the measurements
> > directly on my x86_64 computer [1].
> > 
> > As result, most of the latencies are down to 60us (and below). There are still
> > some latencies larger than 80us, I am working on and trying to figure out the reason.
> > 
> > [1]: https://gist.github.com/OscarShiang/202eb691e649557fe3eaa5ec67a5aa82
> 
> Oscar,
> 
> Did you confirm with hwlatdetect that the BIOS does not have long
> running SMIs?

Marcelo,

I have run hwlatdetect and the result is shown below:

hwlatdetect:  test duration 900 seconds
   detector: tracer
   parameters:
        Latency threshold: 0us
        Sample window:     1000000us
        Sample width:      500000us
     Non-sampling period:  500000us
        Output File:       test.report

Starting test
test finished
Max Latency: 48us
Samples recorded: 37
Samples exceeding threshold: 37
SMIs during run: 0
report saved to test.report (37 samples)
ts: 1646837340.346151918, inner:5, outer:9
ts: 1646837351.550312752, inner:46, outer:45
ts: 1646837381.549331178, inner:45, outer:0
ts: 1646837400.008623200, inner:0, outer:9
ts: 1646837425.578093371, inner:0, outer:8
ts: 1646837429.587363003, inner:0, outer:1
ts: 1646837436.549050243, inner:45, outer:45
ts: 1646837580.005173999, inner:0, outer:9
ts: 1646837605.591017161, inner:7, outer:8
ts: 1646837635.552410329, inner:0, outer:1
ts: 1646837639.246489489, inner:9, outer:5
ts: 1646837645.426611917, inner:9, outer:5
ts: 1646837651.550721975, inner:0, outer:1
ts: 1646837728.549928137, inner:40, outer:47
ts: 1646837756.281606376, inner:1, outer:8
ts: 1646837757.492693661, inner:0, outer:1
ts: 1646837759.355807689, inner:13, outer:13
ts: 1646837761.590570928, inner:0, outer:1
ts: 1646837762.382475433, inner:5, outer:9
ts: 1646837764.185172836, inner:0, outer:9
ts: 1646837768.675668348, inner:1, outer:0
ts: 1646837776.485184319, inner:0, outer:1
ts: 1646837777.544517878, inner:45, outer:41
ts: 1646837855.549140154, inner:45, outer:0
ts: 1646837886.492523509, inner:1, outer:0
ts: 1646837897.544172247, inner:45, outer:0
ts: 1646837933.550015925, inner:48, outer:48
ts: 1646837981.546557947, inner:45, outer:45
ts: 1646837998.051615598, inner:0, outer:1
ts: 1646838030.550099263, inner:45, outer:0
ts: 1646838072.549664559, inner:0, outer:46
ts: 1646838106.571038324, inner:0, outer:1
ts: 1646838107.547228682, inner:1, outer:0
ts: 1646838114.549686904, inner:45, outer:45
ts: 1646838162.549477219, inner:46, outer:47
ts: 1646838180.014465679, inner:5, outer:9
ts: 1646838237.486873064, inner:0, outer:1

It seems that there is no SMI occurring (but some other latencies around 40us?)

> Also, for the software part, you could save time by using the
> realtime-virtual-host profile (check /usr/lib/tuned/realtime-virtual-host/
> to see what its doing in addition to isolcpus=).

Yes, I have switched to realtime-virtual-host profile with its kernel cmdline args.
