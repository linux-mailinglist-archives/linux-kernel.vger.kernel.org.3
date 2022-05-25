Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB5F533FE7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233535AbiEYPG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245095AbiEYPEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:04:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1A60AFB08
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:02:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23482619EF
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 15:02:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 741BCC385B8;
        Wed, 25 May 2022 15:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653490953;
        bh=SopjZnEwL9dH67Z0H4heqgDTmhRTyXWQG5QAyoHE0Ks=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=dqhaUWLUxzSGjJpJsMwtqmlG16itKLnW9wbA6iR2gF9+08cUfegm+zUemDhThmfWZ
         t7GgemjxEVGO7Eb/8YJQTPO3DpcEQOxwAtMO34go1jStSynPAx5t4u0zSQN4rQJ11Z
         zqHdHaYzXXj1IACXKsuz+H0qpqbz8bk4+tDXAeXOQq6WFxcD6F3ouxdfjuaaomOZIz
         MnfgpYQLvk88jTykmegPZ3xndQgJioiE+tPPqao5eujkAZKs2hxh2SD9ts7N4U3INT
         mx8nyxM+2Y398PHkdfAd2o6lpEAq/GbeN6Lx+ovrdcmlHga97u43zbdhBvmmu3c7MU
         x21MNhRCZrDlg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 116B45C018D; Wed, 25 May 2022 08:02:33 -0700 (PDT)
Date:   Wed, 25 May 2022 08:02:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Stefan Wahren <stefan.wahren@i2se.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Phil Elwell <phil@raspberrypi.com>, regressions@lists.linux.dev
Subject: Re: vchiq: Performance regression since 5.18-rc1
Message-ID: <20220525150233.GX1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <77d6d498-7dd9-03eb-60f2-d7e682bb1b20@i2se.com>
 <YoszE8lQ9VcofLtX@linutronix.de>
 <Yo41ggMvkI1B9TeM@fuller.cnet>
 <e0402350-687e-14b6-2e30-4b459afa9afb@i2se.com>
 <Yo48k4InPmj8lDxZ@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yo48k4InPmj8lDxZ@linutronix.de>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 04:26:27PM +0200, Sebastian Andrzej Siewior wrote:
> On 2022-05-25 16:07:47 [+0200], Stefan Wahren wrote:
> > this was the same as Paul send. I think i need more time for investigation,
> > maybe there is an issue with the application.
> 
> I haven't seen Paul referring to *that* patch. He pointed to some fs/
> related changes.

True!  Both patches changed from a synchronize_rcu() to a
synchronize_rcu_expedited(), but different instances of synchronize_rcu().

							Thanx, Paul
