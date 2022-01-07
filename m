Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D681487696
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 12:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237968AbiAGLeO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 06:34:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29706 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232117AbiAGLeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 06:34:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641555253;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/4miwulnF5JUWTEMT0YKoKtJPjUdNUU/eGbpM5de04o=;
        b=Q2DEqYGlzJvNbb6ktZcRJBi1QJsconfjnMmUCo5rKu8nTKULMu4qu5ZuNEQ3TNoYVaHpeR
        YabcxIHc7gdurJ6eQU73SejaI0cSnmPqDcZotke5UQlddWkC62ieBo356VZr9i9TT8zedz
        KUtLCiZIlQUMoeK6zv52MUiHaDi0syQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-550-rV2-3EDmPUm_m-rym8TsRQ-1; Fri, 07 Jan 2022 06:34:11 -0500
X-MC-Unique: rV2-3EDmPUm_m-rym8TsRQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 416611800D50;
        Fri,  7 Jan 2022 11:34:10 +0000 (UTC)
Received: from fuller.cnet (ovpn-112-2.gru2.redhat.com [10.97.112.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D4C0A84A3A;
        Fri,  7 Jan 2022 11:33:56 +0000 (UTC)
Received: by fuller.cnet (Postfix, from userid 1000)
        id 6A7EA40C5C1D; Fri,  7 Jan 2022 08:30:01 -0300 (-03)
Date:   Fri, 7 Jan 2022 08:30:01 -0300
From:   Marcelo Tosatti <mtosatti@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>
Cc:     linux-kernel@vger.kernel.org, Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [patch v8 02/10] add prctl task isolation prctl docs and samples
Message-ID: <20220107113001.GA105857@fuller.cnet>
References: <20211208161000.684779248@fuller.cnet>
 <20220106234956.GA1321256@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106234956.GA1321256@lothringen>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 12:49:56AM +0100, Frederic Weisbecker wrote:
> On Wed, Dec 08, 2021 at 01:09:08PM -0300, Marcelo Tosatti wrote:
> > Add documentation and userspace sample code for prctl
> > task isolation interface.
> > 
> > Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
> 
> Acked-by: Frederic Weisbecker <frederic@kernel.org>
> 
> Thanks a lot! Time for me to look at the rest of the series.
> 
> Would be nice to have Thomas's opinion as well at least on
> the interface (this patch).

Yes. AFAIAW most of his earlier comments on what the 
interface should look like have been addressed (or at
least i've tried to)... including the ability for
the system admin to configure the isolation options.

The one thing missing is to attempt to enter nohz_full
on activation (which Christoph asked for).

Christoph, have a question on that. At
https://lkml.org/lkml/2021/12/14/346, you wrote:

"Applications running would ideally have no performance penalty and there
is no  issue with kernel activity unless the application is in its special
low latency loop. NOHZ is currently only activated after spinning in that
loop for 2 seconds or so. Would be best to be able to trigger that
manually somehow."

So was thinking of something similar to what the full task isolation
patchset does (with the behavior of returning an error as option...):

+int try_stop_full_tick(void)
+{
+	int cpu = smp_processor_id();
+	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
+
+	/* For an unstable clock, we should return a permanent error code. */
+	if (atomic_read(&tick_dep_mask) & TICK_DEP_MASK_CLOCK_UNSTABLE)
+		return -EINVAL;
+
+	if (!can_stop_full_tick(cpu, ts))
+		return -EAGAIN;
+
+	tick_nohz_stop_sched_tick(ts, cpu);
+	return 0;
+}

Is that sufficient? (note it might still be possible 
for a failure to enter nohz_full due to a number of 
reasons), see tick_nohz_stop_sched_tick.

