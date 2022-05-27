Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44B99536669
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 19:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354249AbiE0RKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 13:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350770AbiE0RKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 13:10:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DD6413FD52;
        Fri, 27 May 2022 10:10:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74A9C61E15;
        Fri, 27 May 2022 17:10:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CDEC385A9;
        Fri, 27 May 2022 17:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653671401;
        bh=1hGnT3uuFBFv2HsR/5cfZQxn6XGgLam5DB8waL5477Y=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=i2DTwlEML0hGS/pT9FCGGjUt97z18++fp5TlXsGf46lW8lQ3X+thxXAbhAF/lou/v
         ftHs1Qfi7vCIBZLz1qW1/oy9nKlptGql150ChSd5+vGZoLjy3sID02uqYkaO06raLW
         fboYbVP7xqft1715EMB5Afl2nin9DnQuO6oowTH+ENvO6PYOu7mKTYZYAPnLDO4aSm
         rzaPtL5y07NGbYmNmq5GegKxkplFnaGFhVVq6zMlGsAnL36/KQUU7FUCMbKx0dQG/l
         gXRd+wegW3Iuy3jzkINHlGFfLYv2viT9qtUknWisi03woIynjjej4VBQHqnkNz21r4
         q8Ja+QjJFvHgg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 441715C017C; Fri, 27 May 2022 10:10:01 -0700 (PDT)
Date:   Fri, 27 May 2022 10:10:01 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Cleanup RCU urgency state for offline CPU
Message-ID: <20220527171001.GT1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220526015512.2218046-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526015512.2218046-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 09:55:12AM +0800, Zqiang wrote:
> When an RCU grace period starts and at this time the CPU is in
> the process of going offline, if the RCU gp-fqs occurs during the
> time period when the CPU has passed the stop-machine but has not
> yet entered the idle loop, and this CPU have not report quiescent
> state yet, its urgent flags maybe is set, for example due to cbovld
> is true, but this CPUs rcu urgent flags is not cleanup in rcu_report_dead()
> when report qs. however for CPU that have been report qs, its rcu
> urgent flags should cleanup, so add rcu_disable_urgency_upon_qs()
> in rcu_report_dead() when CPU report qs.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Good catch, thank you!

I have queued this on -rcu, and it will become visible on kernel.org
on my next rebase.  Assuming good test results and no objections from
reviews, I will submit this not to the current merge window, but to
the next merge window (v5.20).

							Thanx, Paul
