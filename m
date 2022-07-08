Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF5C56C350
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 01:14:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239568AbiGHTGW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 15:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239283AbiGHTGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 15:06:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5881E27B2D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 12:06:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A389B824F7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 19:06:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C168C341C0;
        Fri,  8 Jul 2022 19:06:16 +0000 (UTC)
Date:   Fri, 8 Jul 2022 15:06:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Schspa Shi <schspa@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched/rt: fix bad task migration for rt tasks
Message-ID: <20220708150614.2cda886d@gandalf.local.home>
In-Reply-To: <m2ilo779f9.fsf@gmail.com>
References: <20220707165014.77127-1-schspa@gmail.com>
        <20220707135329.08cf74b0@gandalf.local.home>
        <m2h73snqja.fsf@gmail.com>
        <20220708140000.6aa75a50@gandalf.local.home>
        <m2ilo779f9.fsf@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 09 Jul 2022 02:19:42 +0800
Schspa Shi <schspa@gmail.com> wrote:

> Yes, it's what I did in the V1 patch.
> Link: https://lore.kernel.org/all/20220623182932.58589-1-schspa@gmail.com/
> 
> But I think it's not the best solution for this problem.
> In these scenarios, we still have a chance to make the task run faster
> by retrying to retry to push the currently running task on this CPU away.
> 
> There is more details on V2 patch's replay message.
> Link: https://lore.kernel.org/all/CAMA88TrZ-o4W81Yfw9Wcs3ghoxwpeAKtFejtMTt78GNB0tKaSA@mail.gmail.com/#t

The thing is, this situation can only happen if we release the rq lock in
find_lock_lowest_rq(), and we should not be checking for it in the other
cases.

Perhaps add the check in find_lock_lowest_rq() and also in the !lowest_rq
case do:

		task = pick_next_pushable_task(rq);
		if (task == next_task) {
+			/*
+			 * If next task has now disabled migrating, see if we
+			 * can push the current task.
+			 */
+			if (unlikely(is_migrate_disabled(task)))
+				goto retry;
			/*
			 * The task hasn't migrated, and is still the next
			 * eligible task, but we failed to find a run-queue
			 * to push it to.  Do not retry in this case, since
			 * other CPUs will pull from us when ready.
			 */
			goto out;
		}

-- Steve
