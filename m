Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B420F4D1058
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 07:33:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240438AbiCHGeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 01:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbiCHGec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 01:34:32 -0500
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01olkn2107.outbound.protection.outlook.com [40.92.98.107])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B6E3A709
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 22:33:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ggw+RbO2tN6Z/JQFnQKgZ6jmBsppYOGHiFYVcE9lXMjBZj13rRn+6o/oj57E1G6Dey8ihM4IzkjTRmhPRoKuKx+7yXYFFd7Us8JmK5WIPTWGY83h7ERLl6RCUfjOvC1EuF5O2gaUMS4TNlryff1HK8p87jiUp8+cg2V8zq5QZ9T8wZMZissdBiDAUty0hY1crdYEbXG+UzGWvJ7cKwHoK6HB/s9LDbpu21LoaLd//knC0VpR0yu1gEqelBd7V5bd925W6f8z1PnJR3enZkYCg2XhAge+jyHHaXG0s5CGOUexGIuTz86vFKiaX/Wv0H0Drx0pwWewvbbKYaxoRXqXOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8GN93pEWGUlF0KdEgOhbaqrfDSvnLiBhbus0urt/vc=;
 b=Y7WgZsAAret8v1ORB7ZnHqJ6Ryahn9bzLUnH+wpxi//8nQUeEIkTrO9dGlTce2X5pGZHGDkbbdZZeq5hnhpEMEtEY6DAGgukC8Ri5soi1Y0vhz/Hwv7i4FrJIXRm+eaL4fSXvoEcpPTkwZ1/z8gDvY7IkarDgXupkUOSoWl6oa2uLBWi1zZzWDZ96EAvccOAk5ugocoNYJSwJil56TXfkFhgJ7vfHS7uk971SWecAkqmo+uhEJcelfSYzhLivgyQzgP2x1Sd+YbPU/5D1jxUXHnWXY0ITXGPkzF5l65/mwXbQi48TVTVmAyMqNMRXg68MehwQ354p3OlPyK3FrWq+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:11e::14)
 by TYWP286MB2005.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:166::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Tue, 8 Mar
 2022 06:33:31 +0000
Received: from TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d80d:59f5:2572:ab1d]) by TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 ([fe80::d80d:59f5:2572:ab1d%5]) with mapi id 15.20.5038.027; Tue, 8 Mar 2022
 06:33:31 +0000
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
Date:   Tue,  8 Mar 2022 14:32:46 +0800
Message-ID: <TYCP286MB19134DD105CC996925379EC8A1099@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YhZvV5rRkHw4nOlR@fuller.cnet>
References: <YhZvV5rRkHw4nOlR@fuller.cnet>
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-TMN:  [bS9NK6e6VKQMlwyr0Tio1k0X2qaLWbTP]
X-ClientProxiedBy: HK0PR01CA0058.apcprd01.prod.exchangelabs.com
 (2603:1096:203:a6::22) To TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:11e::14)
X-Microsoft-Original-Message-ID: <20220308063246.3668-1-oscar0225@livemail.tw>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6b28e898-1246-4600-2483-08da00cd904c
X-MS-TrafficTypeDiagnostic: TYWP286MB2005:EE_
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y10ecNaTp3TIUOMhOBrypDelLiSQogkqmQGLLpnBqF0h7mOpB0I42KLNh/vtymAz3Yjd2HUfMXVlEl+TWc3dm/6bO97xJdaBdYs7+4w5BFOf9l/nTVmiAhg1wUwc9nNapVUHBAok0+cvONUvhRSTez9t6oP85KDeZO/Fr8W51fVnoTZTuUH5Smbr5ZonaH6TCQOw9r2hDykIHF1tpAhgQgW+DBkD0x2dlLgazois4KR795UE1JxUizJGb3Y1ZjX/uxPfY0MPuuGe2KkbP4RSmUUdbWQaXX1baEuZ3pElSeXDW9xgSdnb7ZjAylX6fxEBnHnLfFExVj7cuzMogVeH/z2MJ69v5g1mmLS87j7bSNufsgNx/lEWVGEVTV459o+qOOhaCHwCC6ZcZjzxpy/Q7ns5A8tfI3voGrsH9AF97IyJucy8n4ZpzcpARdQDC5XP7bs1VUl8nAgSr7PwK569DCvbvym5vo08BJj+pjFE+VDHxqQo+aHJ+x2k3ifOa6g9bsqOZ13Pp+hqdc7qlOt4yh+Imz2AV7fIPwKYX7DujgQ9ScGbqS8ydMCkOQeSCmP99jn6bXLv+ZOeJyHk0DYsrt+kEXmYj67Ol5UF+oDJxtcS1p3AucAtzQXugAoAxaZQ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vq4mfqocJ2LByQ8oEcQao7MSld8ppk0uFvbV84j4GyQp0BIVXUpbsr2Gz8EA?=
 =?us-ascii?Q?DjXckH/4PRPbadGa/fHLJWMKGmnd22HZj8BCzkvPFnTT311PA8ycwVYRWnOR?=
 =?us-ascii?Q?H5M4BYl51V9w2OO3VW4uAGpTun0jZmeiK8tIsSSWrFH/Il6+J/DASgiUQeeC?=
 =?us-ascii?Q?8xlCcUDUshVpio/xSAIF6+JJUapRsCoTE48AxpLF6gKKypTWV59KUogElAXV?=
 =?us-ascii?Q?TuDq3hvcUWOkrCoCV9Z0THItE/KlSVyUsh/Yf0csDuMN+kBfGMH29FsUbYUT?=
 =?us-ascii?Q?ql4QajeIwypVSgx3JrvPqQei8I0QzUVPflSTPeoOipv2VQ0NNCPKhPJ7hWwS?=
 =?us-ascii?Q?LKqJgM6MpAu6bulu3ptgrwLHtbTp7qZ7+YiBCRNTYiPqz/TDaR8hCFD11D47?=
 =?us-ascii?Q?0fHInX8Kf4+wv5FFIjyrLmcDWn8bHht6SyCSBv5xh27bYNe+SRmYNm4adt5f?=
 =?us-ascii?Q?MRVuIuuxglF46QBJs9+xPsmsBJm0haQxumxXPzeTtbdCfs5djifosdfpEJgn?=
 =?us-ascii?Q?2A3NYYwwaPpHvtyjut4p0a/Y5MhpDJEmjNUacZvCIITmC1+89iivOs9otCOK?=
 =?us-ascii?Q?xTH1JrkdSVzrQZ89ox0f6VegDal6LaE8rbOJvoxxqW1yOlwut9WalnFN7IZl?=
 =?us-ascii?Q?wukQejK3yKUd5GYWr1bVudYEJYZdQPA0ldB6IudlNe0D4a72p/b5bhNSbdoD?=
 =?us-ascii?Q?6xKBWAd24IPmldSSMEBfseT1xhlwLZFL1QC6k5lhvkzjDXQN56qS0H9gonPb?=
 =?us-ascii?Q?w10e+QPgY8/DvcR6t3BGuX5QOgSnX51iDwKR6aALzSezuZbJTuCdua+D10Qw?=
 =?us-ascii?Q?MuXEpOdNdKUdVX5Hh2PTqix5B/Dt5huL+TMHEEVVlIQsviWWOvU/Paj8nQzI?=
 =?us-ascii?Q?rRKRzmNFrm0tyAv8oJYd/1I6lKYFubjUfx33QRTYcBWZT9TLXzsQnLuD5NzR?=
 =?us-ascii?Q?cgwK2zPPDJ7V1H7ozyNhzg=3D=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-05f45.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b28e898-1246-4600-2483-08da00cd904c
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2022 06:33:31.8675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2005
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 24, 2022, at 1:31 AM, Marcelo Tosatti <mtosatti@redhat.com> wrote:
> Hi Oscar,
> 
> On Sat, Feb 19, 2022 at 04:02:10PM +0800, Oscar Shiang wrote:
> > Hi Marcelo,
> > 
> > I tried to apply your patches to kernel v5.15.18-rt28 and measured
> > the latencies through oslat [1].
> > 
> > It turns out that the peak latency (around 100us) can drop to about 90us.
> > The result is impressive since I only changed the guest's kernel
> > instead of installing the patched kernel to both host and guest.
> > 
> > However, I am still curious about:
> > 1) Why did I catch a bigger maximum latency in almost each of the
> >   results of applying task isolation patches? Or does it come from
> >   other reasons?
> 
> There are a number of things that need to be done in order to have an 
> "well enough" isolated CPU so you can measure latency reliably:
> 
> * Boot a kernel with isolated CPU (or better, use realtime-virtual-host profile of
> https://github.com/redhat-performance/tuned.git, which does a bunch of
> other things to avoid interruptions to isolated CPUs).
> * Apply the userspace patches at https://people.redhat.com/~mtosatti/task-isol-v6-userspace-patches/
> to util-linux and rt-tests.
> 
> Run oslat with chisol:
> 
> chisol -q vmstat_sync -I conf oslat -c ...
> 
> Where chisol is from patched util-linux and oslat from patched rt-tests.
> 
> If you had "-f 1" (FIFO priority), on oslat, then the vmstat work would be hung.
> 
> Are you doing those things?
> 
> > 2) Why did we only get a 10us improvement on quiescing vmstat?
> 
> If you did not have FIFO priority on oslat, then other daemons 
> could be interrupting it, so better make sure the 10us improvement 
> you see is due to vmstat_flush workqueue work not executing anymore.
> 
> The testcase i use is: 
> 
> Stock kernel:
> 
> terminal 1: 
> # oslat -f 1 -c X ...
> 
> terminal 2:
> # echo 1 > /proc/sys/vm/stat_refresh
> (hang)
> 
> Patched kernel:
> 
> terminal 1: 
> # chisol -q vmstat_sync -I conf oslat -f 1 -c X ...
> 
> terminal 2:
> # echo 1 > /proc/sys/vm/stat_refresh
> # 

Sure, I did see the terminal hung during oslat with FIFO priority.

BTW, thanks for providing this test case. I used to run all workload stuff to just
verify the improvement of task isolation. It is a more straightr- forward way to do.

> > [1]: The result and the test scripts I used can be found at
> > https://gist.github.com/OscarShiang/8b530a00f472fd1c39f5979ee601516d#testing-task-isolation-via-oslat
> 
> OK, you seem to be doing everything necessary for chisol 
> to work. Does /proc/pid/task_isolation of the oslat worker thread
> (note its not the same pid as the main oslat thread) show "vmstat"
> configured and activated for quiesce?

The status of task_isolation seems to be set properly with "vmstat" and activated

> However 100us is really high. You should be able to get < 10us with
> realtime-virtual-host (i see 4us on an idle system).
> 
> The answer might be: because 10us is what it takes to execute
> vmstat_worker on the isolated CPU (you can verify with tracepoints).
> 
> That time depends on the number of per-CPU vmstat variables that need flushing, 
> i suppose...

Considering the interferences outside of the KVM, I have redone the measurements
directly on my x86_64 computer [1].

As result, most of the latencies are down to 60us (and below). There are still
some latencies larger than 80us, I am working on and trying to figure out the reason.

[1]: https://gist.github.com/OscarShiang/202eb691e649557fe3eaa5ec67a5aa82

Thanks,
Oscar
