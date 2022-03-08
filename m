Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A6A44D1E2A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 18:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348409AbiCHRKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 12:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245053AbiCHRKb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 12:10:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA14336B4D
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 09:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646759373;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9kvrF8a5fSjVKql9gaDkDoyGNlOLifpMBJz2kVYkRkE=;
        b=BI1s2Vs9ivhHP20PzWPB5/4zLjZdPPArGsIo/vq1qjYG3id/MTOlGbbK/oHxcT2AeGlyS2
        GYl+dUivcOrqCE4Go+4K2asek91sPQE/9sYhnC6wT8Xyl/Ia8Lc6Gyu9Y48vD2UaykrIIj
        49/xVnj3Zper4cZGmVygEIuKbp72Ong=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-505-GicO_gLLPdGsjqd5MZyW7A-1; Tue, 08 Mar 2022 12:09:28 -0500
X-MC-Unique: GicO_gLLPdGsjqd5MZyW7A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 763941006AA7;
        Tue,  8 Mar 2022 17:09:25 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-3.gru2.redhat.com [10.97.112.3])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BF09C86C3B;
        Tue,  8 Mar 2022 17:08:46 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id BB821416D5C1; Tue,  8 Mar 2022 10:12:35 -0300 (-03)
Date:   Tue, 8 Mar 2022 10:12:35 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Oscar Shiang <oscar0225@livemail.tw>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [patch v11 00/13] extensible prctl task isolation interface and
 vmstat sync
Message-ID: <YidWQ28Jgs/FpmL1@fuller.cnet>
References: <YhZvV5rRkHw4nOlR@fuller.cnet>
 <TYCP286MB19134DD105CC996925379EC8A1099@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCP286MB19134DD105CC996925379EC8A1099@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 02:32:46PM +0800, Oscar Shiang wrote:
> On Feb 24, 2022, at 1:31 AM, Marcelo Tosatti <mtosatti@redhat.com> wrote:
> > Hi Oscar,
> > 
> > On Sat, Feb 19, 2022 at 04:02:10PM +0800, Oscar Shiang wrote:
> > > Hi Marcelo,
> > > 
> > > I tried to apply your patches to kernel v5.15.18-rt28 and measured
> > > the latencies through oslat [1].
> > > 
> > > It turns out that the peak latency (around 100us) can drop to about 90us.
> > > The result is impressive since I only changed the guest's kernel
> > > instead of installing the patched kernel to both host and guest.
> > > 
> > > However, I am still curious about:
> > > 1) Why did I catch a bigger maximum latency in almost each of the
> > >   results of applying task isolation patches? Or does it come from
> > >   other reasons?
> > 
> > There are a number of things that need to be done in order to have an 
> > "well enough" isolated CPU so you can measure latency reliably:
> > 
> > * Boot a kernel with isolated CPU (or better, use realtime-virtual-host profile of
> > https://github.com/redhat-performance/tuned.git, which does a bunch of
> > other things to avoid interruptions to isolated CPUs).
> > * Apply the userspace patches at https://people.redhat.com/~mtosatti/task-isol-v6-userspace-patches/
> > to util-linux and rt-tests.
> > 
> > Run oslat with chisol:
> > 
> > chisol -q vmstat_sync -I conf oslat -c ...
> > 
> > Where chisol is from patched util-linux and oslat from patched rt-tests.
> > 
> > If you had "-f 1" (FIFO priority), on oslat, then the vmstat work would be hung.
> > 
> > Are you doing those things?
> > 
> > > 2) Why did we only get a 10us improvement on quiescing vmstat?
> > 
> > If you did not have FIFO priority on oslat, then other daemons 
> > could be interrupting it, so better make sure the 10us improvement 
> > you see is due to vmstat_flush workqueue work not executing anymore.
> > 
> > The testcase i use is: 
> > 
> > Stock kernel:
> > 
> > terminal 1: 
> > # oslat -f 1 -c X ...
> > 
> > terminal 2:
> > # echo 1 > /proc/sys/vm/stat_refresh
> > (hang)
> > 
> > Patched kernel:
> > 
> > terminal 1: 
> > # chisol -q vmstat_sync -I conf oslat -f 1 -c X ...
> > 
> > terminal 2:
> > # echo 1 > /proc/sys/vm/stat_refresh
> > # 
> 
> Sure, I did see the terminal hung during oslat with FIFO priority.
> 
> BTW, thanks for providing this test case. I used to run all workload stuff to just
> verify the improvement of task isolation. It is a more straightr- forward way to do.
> 
> > > [1]: The result and the test scripts I used can be found at
> > > https://gist.github.com/OscarShiang/8b530a00f472fd1c39f5979ee601516d#testing-task-isolation-via-oslat
> > 
> > OK, you seem to be doing everything necessary for chisol 
> > to work. Does /proc/pid/task_isolation of the oslat worker thread
> > (note its not the same pid as the main oslat thread) show "vmstat"
> > configured and activated for quiesce?
> 
> The status of task_isolation seems to be set properly with "vmstat" and activated
> 
> > However 100us is really high. You should be able to get < 10us with
> > realtime-virtual-host (i see 4us on an idle system).
> > 
> > The answer might be: because 10us is what it takes to execute
> > vmstat_worker on the isolated CPU (you can verify with tracepoints).
> > 
> > That time depends on the number of per-CPU vmstat variables that need flushing, 
> > i suppose...
> 
> Considering the interferences outside of the KVM, I have redone the measurements
> directly on my x86_64 computer [1].
> 
> As result, most of the latencies are down to 60us (and below). There are still
> some latencies larger than 80us, I am working on and trying to figure out the reason.
> 
> [1]: https://gist.github.com/OscarShiang/202eb691e649557fe3eaa5ec67a5aa82

Oscar,

Did you confirm with hwlatdetect that the BIOS does not have long
running SMIs?

Also, for the software part, you could save time by using the
realtime-virtual-host profile (check /usr/lib/tuned/realtime-virtual-host/
to see what its doing in addition to isolcpus=).

