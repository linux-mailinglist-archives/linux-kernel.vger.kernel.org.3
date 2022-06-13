Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA430548D25
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356258AbiFMLuJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 07:50:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356275AbiFMLoQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 07:44:16 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FE0046CA8
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 03:50:38 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 94C4621C6E;
        Mon, 13 Jun 2022 10:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1655117431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=17/3CEJujfFLNuAQBHZxH41y/BnqBjSR48wov2fqM/c=;
        b=jsn1Bbn3KdWZklFqk+mXqUxZUX4hqzl0edsHWICFEPtWCiWWEwgCsH9264lqYdbRk91Oh0
        TItVqszzHUyQezUUDAG6XgmdWz8kveKvNWR/PQHPbpIT7uE0xU3JjIXjUlMe1D7uFpELx2
        36hBK7JNegpR2rwYjKDgbuuRxA8wNJI=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 70D812C141;
        Mon, 13 Jun 2022 10:50:31 +0000 (UTC)
Date:   Mon, 13 Jun 2022 12:50:31 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     john.ogness@linutronix.de, linux-kernel@vger.kernel.org,
        frederic@kernel.org
Subject: Re: [BUG] 8e274732115f ("printk: extend console_lock for per-console
 locking")
Message-ID: <YqcWd16LNnFPRJHg@alley>
References: <20220610205038.GA3050413@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220610205038.GA3050413@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 2022-06-10 13:50:38, Paul E. McKenney wrote:
> Hello, John,
> 
> I have started getting rcutorture shutdown-time hangs when running
> against recent mainline, and bisected back to the 8e274732115f ("printk:
> extend console_lock for per-console locking") commit.  These hangs go
> away (or at least their probability drops dramatically) if I build with
> CONFIG_PREEMPTION=n -and- CONFIG_NO_HZ=y (not n!), at least assuming
> that I also boot with "nohz_full=0-N".

This means that the kthreads are probably more often sleeping with
con->lock when the pre-emtion is done by regular ticks.

We might want to wake them if we could call pr_flush().
But we could not do this in the generic panic() path.
It might cause deadlock when panic() is called from
scheduler code.

Pest Regards,
Petr
