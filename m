Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C82258600E
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 19:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237510AbiGaRBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 13:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiGaRBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 13:01:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC89F765E;
        Sun, 31 Jul 2022 10:01:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7940F60F52;
        Sun, 31 Jul 2022 17:01:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02B2EC433D6;
        Sun, 31 Jul 2022 17:01:50 +0000 (UTC)
Date:   Sun, 31 Jul 2022 13:01:44 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH V9 01/16] rv: Add Runtime Verification (RV) interface
Message-ID: <20220731130144.26576a6a@rorschach.local.home>
In-Reply-To: <20220731124730.311c8207@rorschach.local.home>
References: <cover.1659052063.git.bristot@kernel.org>
        <a4bfe038f50cb047bfb343ad0e12b0e646ab308b.1659052063.git.bristot@kernel.org>
        <YuU7TGxm5pzmBFTx@geo.homenetwork>
        <0197dd47-ea15-4d8b-5fc7-e466d8a501a7@kernel.org>
        <YuaadlzgSJLtzOUw@geo.homenetwork>
        <20220731124730.311c8207@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 31 Jul 2022 12:47:30 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> But Daniel, these checks do need to be updated. Please send patches on
> top of this series to address it.

I believe what Tao is trying to say is this:

If we set RV_PER_TASKS_MONITORS greater than 1 we have:

int rv_enable_monitor(struct rv_monitor_def *mdef)
{
        int retval;

        lockdep_assert_held(&rv_interface_lock);

        if (mdef->monitor->enabled)
                return 0;

        retval = mdef->monitor->enable();  <- if that returns positive, then things break.

        if (!retval)
                mdef->monitor->enabled = 1;  <- this is not set.

        return retval;
}

static int enable_wip(void)
{
        int retval;

        retval = da_monitor_init_wip();  <- if that returns positive, things break
        if (retval)
                return retval;



static int da_monitor_init_##name(void)                                                         \
{                                                                                               \
        int slot;                                                                               \
                                                                                                \
        slot = rv_get_task_monitor_slot();  <- if this returns positive, things break           \
        if (slot < 0 || slot >= RV_PER_TASK_MONITOR_INIT)                                       \

And we probably need slot to be negative if it is greater or equal to RV_PER_TASK_MONITOR_INIT.

                return slot;                                                                    \
                                

int rv_get_task_monitor_slot(void)
{
        int i;

        lockdep_assert_held(&rv_interface_lock);

        if (task_monitor_count == RV_PER_TASK_MONITORS)
                return -EBUSY;

        task_monitor_count++;

        for (i = 0; i < RV_PER_TASK_MONITORS; i++) {
                if (task_monitor_slots[i] == false) {
                        task_monitor_slots[i] = true;
                        return i;  <- if RV_PER_TASK_MONITORS > 1 then it can return positive!
                }
        }

-- Steve

