Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 368D2566FAD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 15:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233253AbiGENon (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 09:44:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbiGENoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 09:44:12 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E987F1D30F;
        Tue,  5 Jul 2022 06:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=S/YFv54JTDc1FmYECgAN91i/LP+GF3iJnpVhVBrSnuI=; b=FVdtXtc69ESas1TRuen4OQ46T0
        jG6Z8dzasNi9g8sefltZiUqm8DGsO7aXZMGuh5FiJDmHdQwiQbbx7uTgItwriNIIfEzbbi5AfNETi
        LWL8eVUW/+quv0HpZ7NzUSCstDJjtD7GseP8HUtcsEDyusL6eQNAxArEFDQ0fBLmn1GQGB+3cwake
        3m1L834fz1RtwVIOD2fXVAxvzU/e3f/Zucqr1CSpPHmJxddv7BThqPRagtdOTHtL0hBGeE1T9Qv3Q
        vRUYjWIqY7y2zE3qAOrO1x/dknFWu6H+m/J8NA2I6okedrJfwdY8Z1Knh6DDqinkUX9K7trMYLmIi
        6qiEvVUg==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o8iH2-00Hab2-Ed; Tue, 05 Jul 2022 13:07:29 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7EB44980060; Tue,  5 Jul 2022 15:07:26 +0200 (CEST)
Date:   Tue, 5 Jul 2022 15:07:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf/core: Fix data race between
 perf_event_set_output and perf_mmap_close
Message-ID: <YsQ3jm2GR38SW7uD@worktop.programming.kicks-ass.net>
References: <20220704120006.98141-1-yangjihong1@huawei.com>
 <YsMGixSL4CDPTTZs@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsMGixSL4CDPTTZs@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 05:26:04PM +0200, Peter Zijlstra wrote:
> On Mon, Jul 04, 2022 at 08:00:06PM +0800, Yang Jihong wrote:
> > Data race exists between perf_event_set_output and perf_mmap_close.
> > The scenario is as follows:
> > 
> >                   CPU1                                                       CPU2
> >                                                                     perf_mmap_close(event2)
> >                                                                       if (atomic_dec_and_test(&event2->rb->mmap_count)  // mmap_count 1 -> 0
> >                                                                         detach_rest = true;
> > ioctl(event1, PERF_EVENT_IOC_SET_OUTPUT, event2)
> >   perf_event_set_output(event1, event2)
> >                                                                       if (!detach_rest)
> >                                                                         goto out_put;
> >                                                                       list_for_each_entry_rcu(event, &event2->rb->event_list, rb_entry)
> >                                                                         ring_buffer_attach(event, NULL)
> >                                                                       // because event1 has not been added to event2->rb->event_list,
> >                                                                       // event1->rb is not set to NULL in these loops
> > 
> >     ring_buffer_attach(event1, event2->rb)
> >       list_add_rcu(&event1->rb_entry, &event2->rb->event_list)
> > 
> > The above data race causes a problem, that is, event1->rb is not NULL, but event1->rb->mmap_count is 0.
> > If the perf_mmap interface is invoked for the fd of event1, the kernel keeps in the perf_mmap infinite loop:
> > 
> > again:
> >         mutex_lock(&event->mmap_mutex);
> >         if (event->rb) {
> > <SNIP>
> >                 if (!atomic_inc_not_zero(&event->rb->mmap_count)) {
> >                         /*
> >                          * Raced against perf_mmap_close() through
> >                          * perf_event_set_output(). Try again, hope for better
> >                          * luck.
> >                          */
> >                         mutex_unlock(&event->mmap_mutex);
> >                         goto again;
> >                 }
> > <SNIP>
> 
> Too tired, must look again tomorrow, little feeback below.

With brain more awake I ended up with the below. Does that work?

---
 kernel/events/core.c | 45 +++++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 4d8c335a07db..c9d32d4d2e20 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6262,10 +6262,10 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 
 		if (!atomic_inc_not_zero(&event->rb->mmap_count)) {
 			/*
-			 * Raced against perf_mmap_close() through
-			 * perf_event_set_output(). Try again, hope for better
-			 * luck.
+			 * Raced against perf_mmap_close(); remove the
+			 * event and try again.
 			 */
+			ring_buffer_attach(event, NULL);
 			mutex_unlock(&event->mmap_mutex);
 			goto again;
 		}
@@ -11840,14 +11840,25 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 	goto out;
 }
 
+static void mutex_lock_double(struct mutex *a, struct mutex *b)
+{
+	if (b < a)
+		swap(a, b);
+
+	mutex_lock(a);
+	mutex_lock_nested(b, SINGLE_DEPTH_NESTING);
+}
+
 static int
 perf_event_set_output(struct perf_event *event, struct perf_event *output_event)
 {
 	struct perf_buffer *rb = NULL;
 	int ret = -EINVAL;
 
-	if (!output_event)
+	if (!output_event) {
+		mutex_lock(&event->mmap_mutex);
 		goto set;
+	}
 
 	/* don't allow circular references */
 	if (event == output_event)
@@ -11885,8 +11896,15 @@ perf_event_set_output(struct perf_event *event, struct perf_event *output_event)
 	    event->pmu != output_event->pmu)
 		goto out;
 
+	/*
+	 * Hold both mmap_mutex to serialize against perf_mmap_close().  Since
+	 * output_event is already on rb->event_list, and the list iteration
+	 * restarts after every removal, it is guaranteed this new event is
+	 * observed *OR* if output_event is already removed, it's guaranteed we
+	 * observe !rb->mmap_count.
+	 */
+	mutex_lock_double(&event->mmap_mutex, &output_event->mmap_mutex);
 set:
-	mutex_lock(&event->mmap_mutex);
 	/* Can't redirect output if we've got an active mmap() */
 	if (atomic_read(&event->mmap_count))
 		goto unlock;
@@ -11896,6 +11914,12 @@ perf_event_set_output(struct perf_event *event, struct perf_event *output_event)
 		rb = ring_buffer_get(output_event);
 		if (!rb)
 			goto unlock;
+
+		/* did we race against perf_mmap_close() */
+		if (!atomic_read(&rb->mmap_count)) {
+			ring_buffer_put(rb);
+			goto unlock;
+		}
 	}
 
 	ring_buffer_attach(event, rb);
@@ -11903,20 +11927,13 @@ perf_event_set_output(struct perf_event *event, struct perf_event *output_event)
 	ret = 0;
 unlock:
 	mutex_unlock(&event->mmap_mutex);
+	if (output_event)
+		mutex_unlock(&output_event->mmap_mutex);
 
 out:
 	return ret;
 }
 
-static void mutex_lock_double(struct mutex *a, struct mutex *b)
-{
-	if (b < a)
-		swap(a, b);
-
-	mutex_lock(a);
-	mutex_lock_nested(b, SINGLE_DEPTH_NESTING);
-}
-
 static int perf_event_set_clock(struct perf_event *event, clockid_t clk_id)
 {
 	bool nmi_safe = false;
