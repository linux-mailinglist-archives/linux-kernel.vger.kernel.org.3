Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F38044AF6A4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 17:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236994AbiBIQ1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 11:27:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237046AbiBIQ1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 11:27:19 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E8AC050CE5
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 08:27:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D675B6182A
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 16:27:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87F0EC340E7;
        Wed,  9 Feb 2022 16:27:04 +0000 (UTC)
Date:   Wed, 9 Feb 2022 11:27:03 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Byungchul Park <byungchul.park@lge.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Radoslaw Burny <rburny@google.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        intel-gfx@lists.freedesktop.org, paulmck@kernel.org
Subject: Re: [PATCH 05/12] drm/i915: Protect lockdep functions with #ifdef
Message-ID: <20220209112703.1679e48b@gandalf.local.home>
In-Reply-To: <87iltonoaa.fsf@intel.com>
References: <20220208184208.79303-1-namhyung@kernel.org>
        <20220208184208.79303-6-namhyung@kernel.org>
        <87y22lp4xx.fsf@intel.com>
        <CAM9d7ci0By5zioo+52+14RuFrTqZfzbupJuP-908HhYB2Ovc9A@mail.gmail.com>
        <87iltonoaa.fsf@intel.com>
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

On Wed, 09 Feb 2022 15:49:01 +0200
Jani Nikula <jani.nikula@linux.intel.com> wrote:

> > Because I want to use the lockdep annotation for other purposes.
> > But the workqueue lockdep_map was defined under LOCKDEP
> > only.  Please see the description in the cover letter.
> >
> > https://lore.kernel.org/all/20220208184208.79303-1-namhyung@kernel.org/  
> 
> So lockdep_init_map() might still be there and build just fine for
> CONFIG_LOCKDEP=n, but now we're actually required to wrap all call sites
> in #ifdefs depending on the purpose? I'm not convinced yet.

I addressed this already. I suggested to add a "raw" variant that turns to
a nop when LOCKDEP is not enabled. That is, for those locations that are
only for working with LOCKDEP, the call will be:

	lockdep_init_map_raw()

This will differentiate the locations that are for just lockdep and those
that are for both lockdep and tracing.

-- Steve
