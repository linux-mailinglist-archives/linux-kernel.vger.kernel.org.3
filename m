Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DE835201C9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 17:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238716AbiEIQAc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 12:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238680AbiEIQA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 12:00:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B49226886
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 08:56:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A5F2612CB
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 15:56:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F99C385AE;
        Mon,  9 May 2022 15:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652111794;
        bh=6L+UzvyilUsWmuMKa2o6reD9OfemDuJY/UKqTwVgBj0=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=kjdUcIhIIui29wj/hMYd53aPq6YMMh+Wt7Luu6feeUmtFVqkVU8FkzD2jZMLSGv3u
         EAXsFuMV8MtpLQI9GT7ux4X6wfFWxSp2oCitmYkuP9ZaIviTgZ2P9Jet7Bl+zG5yzl
         Z8EhFpofju4vcPsncgxDasZtMO62CLcq/Z3COrpoZMYketOwzDmduZaCiF/WpmEU2x
         edx+dCZ4VfScVEZ9mVy3OuIF8YlvCMcizEF1uH1Vb62z6gOFdZFjewi20xv3gyjf+f
         sfW0ouUwH+mQOfYyI+k6i38yFPolT23qqI54MXJnHe4tUw/s5pZ/GllaEdz6FnN8mU
         O6K0NsPIvA78g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 9F8A45C00B8; Mon,  9 May 2022 08:56:33 -0700 (PDT)
Date:   Mon, 9 May 2022 08:56:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     jolsa@redhat.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org
Subject: Folllowing up on LSF/MM RCU/idle discussion
Message-ID: <20220509155633.GA93071@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Jiri!

It was good chatting with you last week, and I hope that travels went
well!

Just wanted to follow up on the non-noinstr code between the call
to rcu_idle_enter() and rcu_idle_exit().  Although the most correct
approach is to never have non-noinstr code in arch_cpu_idle(), for all I
know there might well be architectures for which this is not feasible.
If so, one workaround would be to supply a flag set by each arch (or
subarch) that says that rcu_idle_enter() and rcu_idle_exit() are invoked
within arch_cpu_idle().

CCing Peter, who just might have an opinion on this.  ;-)

							Thanx, Paul
