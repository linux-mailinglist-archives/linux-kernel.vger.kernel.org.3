Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4794C1A2A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 18:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243500AbiBWRsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 12:48:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243501AbiBWRsb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 12:48:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2301626CA
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 09:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645638482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fZTx6rkdVq8MJb095qCc+m29wfJPTq/nh3YyPpCbjOY=;
        b=W2GlMo6T0eOuPxlUMhFWu9wMovCJUWWgoX4xyD797ZkdBqd9BFcjhY9NOds+OHV3yDp95h
        jEaxYh+hDnaztwTnt9NwTvbdRaji6sLPuFDua6kLbTicSWzZSSadSMmSNX6IKmdHw3+sti
        RUfRCnhchnmhtGAv+iZ+O6cwFFKxgrA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-JV4nWpbuPvChy6MBoD9asw-1; Wed, 23 Feb 2022 12:47:58 -0500
X-MC-Unique: JV4nWpbuPvChy6MBoD9asw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0B921006AA6;
        Wed, 23 Feb 2022 17:47:56 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C958F1086486;
        Wed, 23 Feb 2022 17:47:21 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 337594168B84; Wed, 23 Feb 2022 14:31:03 -0300 (-03)
Date:   Wed, 23 Feb 2022 14:31:03 -0300
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
Message-ID: <YhZvV5rRkHw4nOlR@fuller.cnet>
References: <20220204173537.429902988@fedora.localdomain>
 <TYCP286MB19133894C3D15F11A9DB62A9A1389@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYCP286MB19133894C3D15F11A9DB62A9A1389@TYCP286MB1913.JPNP286.PROD.OUTLOOK.COM>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oscar,

On Sat, Feb 19, 2022 at 04:02:10PM +0800, Oscar Shiang wrote:
> Hi Marcelo,
> 
> I tried to apply your patches to kernel v5.15.18-rt28 and measured
> the latencies through oslat [1].
> 
> It turns out that the peak latency (around 100us) can drop to about 90us.
> The result is impressive since I only changed the guest's kernel
> instead of installing the patched kernel to both host and guest.
> 
> However, I am still curious about:
> 1) Why did I catch a bigger maximum latency in almost each of the
>    results of applying task isolation patches? Or does it come from
>    other reasons?

There are a number of things that need to be done in order to have an 
"well enough" isolated CPU so you can measure latency reliably:

* Boot a kernel with isolated CPU (or better, use realtime-virtual-host profile of
https://github.com/redhat-performance/tuned.git, which does a bunch of
other things to avoid interruptions to isolated CPUs).
* Apply the userspace patches at https://people.redhat.com/~mtosatti/task-isol-v6-userspace-patches/
to util-linux and rt-tests.

Run oslat with chisol:

chisol -q vmstat_sync -I conf oslat -c ...

Where chisol is from patched util-linux and oslat from patched rt-tests.

If you had "-f 1" (FIFO priority), on oslat, then the vmstat work would be hung.

Are you doing those things?

> 2) Why did we only get a 10us improvement on quiescing vmstat?

If you did not have FIFO priority on oslat, then other daemons 
could be interrupting it, so better make sure the 10us improvement 
you see is due to vmstat_flush workqueue work not executing anymore.

The testcase i use is: 

Stock kernel:

terminal 1: 
# oslat -f 1 -c X ...

terminal 2:
# echo 1 > /proc/sys/vm/stat_refresh
(hang)

Patched kernel:

terminal 1: 
# chisol -q vmstat_sync -I conf oslat -f 1 -c X ...

terminal 2:
# echo 1 > /proc/sys/vm/stat_refresh
# 

> [1]: The result and the test scripts I used can be found at
> https://gist.github.com/OscarShiang/8b530a00f472fd1c39f5979ee601516d#testing-task-isolation-via-oslat

OK, you seem to be doing everything necessary for chisol 
to work. Does /proc/pid/task_isolation of the oslat worker thread
(note its not the same pid as the main oslat thread) show "vmstat"
configured and activated for quiesce?

However 100us is really high. You should be able to get < 10us with
realtime-virtual-host (i see 4us on an idle system).

The answer might be: because 10us is what it takes to execute
vmstat_worker on the isolated CPU (you can verify with tracepoints).

That time depends on the number of per-CPU vmstat variables that need flushing, 
i suppose...


