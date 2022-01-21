Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD51C4965DA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 20:47:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbiAUTr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 14:47:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiAUTrZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 14:47:25 -0500
Received: from metanate.com (unknown [IPv6:2001:8b0:1628:5005::111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F5B6C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 11:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=metanate.com; s=stronger; h=Content-Transfer-Encoding:Content-Type:
        References:In-Reply-To:Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID
        :Content-Description; bh=Ru23K7nav+OHjyymO8CSjGmREtw3kKts4vIZNTASfAQ=; b=s0O0
        /UXqV9obxQwXq3xNCrUbPc8jZaPlneD+lUOrEoxSL04tAiZ/XTPuAt59zKIQOtQFHOqUSB/UnqBa+
        7izh4iMATFCXMFO3CeGx2DEMqs2OT1hSeCB0eOAdNNORNwzYM6BjOqvnmcc7euLdkinWJh+85RFPm
        vJTrmZ/GVhXd6deDhX5VWSzagcPhZ9L3UgggdJuCpvgJQrWJQ5i4T/ZXaNIEJyJ4i97o4AUeCgsgE
        KcyyI+O2kBQPUNJAixbt8frQMiq7PNoFe26zKaP4FIqWEpupIWVDYDtjetLrckELc39BRQNxR/7gd
        EgYdyTWnu1S5PrTV8pmxlQETJ9/8xQ==;
Received: from [81.174.171.191] (helo=donbot)
        by email.metanate.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <john@metanate.com>)
        id 1nAzsU-0001sS-UZ; Fri, 21 Jan 2022 19:47:19 +0000
Date:   Fri, 21 Jan 2022 19:47:18 +0000
From:   John Keeping <john@metanate.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH] sched/rt: Plug rt_mutex_setprio() vs push_rt_task()
 race
Message-ID: <20220121194718.5e32bc19.john@metanate.com>
In-Reply-To: <8735li6vgq.mognet@arm.com>
References: <20220120194037.650433-1-valentin.schneider@arm.com>
        <8735li6vgq.mognet@arm.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authenticated: YES
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2022 19:47:01 +0000
Valentin Schneider <valentin.schneider@arm.com> wrote:

> On 20/01/22 19:40, Valentin Schneider wrote:
> > Link: http://lore.kernel.org/r/Yb3vXx3DcqVOi+EA@donbot
> > Fixes: a7c81556ec4d ("sched: Fix migrate_disable() vs rt/dl balancing")
> > Reported-by: John Keeping <john@metanate.com>
> > Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>  
> 
> @John: it's slightly different than the few things we got you to try out,
> so I didn't keep your tested-by, sorry!

I ran a test with this version as well and as expected this does indeed
fix the issue, so this is also:

Tested-by: John Keeping <john@metanate.com>
