Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9B454683B1
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 10:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384475AbhLDJoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 04:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244166AbhLDJoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 04:44:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D83C061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 01:40:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=CabEUrityYp5BqyqfatQFaxjhKlMnkTqu2pZZbvUMEk=; b=LxkOzDTQ+yQe6sujWoUvEVScr/
        mTYeWVmNtgi/2VKdHIfPq/gTWx/O3CbjN0x7ttlzoOduneN92hrep9zrqCfmEFLt6LP5+vNruFpNH
        FXqSQcGspCq2LYgNAWa3lARUPx1mLSaeFqMOMJLNv/0nBGS8Vr04M5JV3ExYgDE6Q7cJaUM2f61xQ
        mc9xT2h8q2OUSD++cqusWLvP851wKk9M9TIkWpWXhnzEOj+3NqQ+AHUMfXpILK6bqiFZaz+E80Dv7
        vh3Yl1aomvxaseyBXrtNitF6VcM6FjdFTgqum1LEsZPoMjGr1HenkX/q1fvK9rAYz2BZzKwJJvE4T
        2l8ZIsgg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mtRX6-00CTor-En; Sat, 04 Dec 2021 09:40:41 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 816D998106D; Sat,  4 Dec 2021 10:40:40 +0100 (CET)
Date:   Sat, 4 Dec 2021 10:40:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        valentin.schneider@arm.com
Subject: Re: [PATCH v3] sched/fair: Fix per-CPU kthread and wakee stacking
 for asym CPU capacity
Message-ID: <20211204094040.GN16608@worktop.programming.kicks-ass.net>
References: <20211129173115.4006346-1-vincent.donnefort@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129173115.4006346-1-vincent.donnefort@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 05:31:15PM +0000, Vincent Donnefort wrote:
> select_idle_sibling() has a special case for tasks woken up by a per-CPU
> kthread where the selected CPU is the previous one. For asymmetric CPU
> capacity systems, the assumption was that the wakee couldn't have a
> bigger utilization during task placement than it used to have during the
> last activation. That was not considering uclamp.min which can completely
> change between two task activations and as a consequence mandates the
> fitness criterion asym_fits_capacity(), even for the exit path described
> above.
> 
> Fixes: b4c9c9f15649 ("sched/fair: Prefer prev cpu in asymmetric wakeup path")
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
> Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

Thanks!
