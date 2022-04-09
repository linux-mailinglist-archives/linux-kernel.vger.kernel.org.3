Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 160724FA962
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 17:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242563AbiDIP6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 11:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234296AbiDIP6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 11:58:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED4C0B8213
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 08:56:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 86F3060B69
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 15:56:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF7B8C385A4;
        Sat,  9 Apr 2022 15:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649519772;
        bh=iEsZf4yCox/8RyXdErEUAGOd+SMekJ2heiJThUv/iec=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=J6tLAqJf75T0x3NLhkSTXBPTy5UqyrqO7ag0uuW0AXQMs8Vcrcb6y2I8DlY3Egr51
         MfUioqWHjCZosSeV7z/rqhOHyIVqUG+Ol4WvqW0OT3BTGeEzzPP+XT2U3l/vDZ/5ks
         dKTIxIW3fpbZEemvHE90D9TYVfEr8cxRyqlXM5r/ybFgJeITyuyDKFZ1nGpnx2vDWY
         KMkFYw4NzIPX28InYDh2Hcn3hwOSOxUfl7efqmJjXb8vhr7ydnsvEbL1Uk0e0/GdmD
         28ej/nN8fRJP1H+ZyOJAiH9ipS8p6YmcqNYGdOphYgVAVG5GEpc5I0XQk9+W9i4L4U
         UA37kelcXdfIw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 812025C09EF; Sat,  9 Apr 2022 08:56:12 -0700 (PDT)
Date:   Sat, 9 Apr 2022 08:56:12 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Kalesh Singh <kaleshsingh@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] EXP rcu: Move expedited grace period (GP) work to RT
 kthread_worker
Message-ID: <20220409155612.GO4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220408045734.1158817-1-kaleshsingh@google.com>
 <CAEXW_YQ6_VpneJnBfhTOMr6DwJhNmvMAKDRMnpr8LxB9Gtt=Xg@mail.gmail.com>
 <20220408143444.GC4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YSrGKXh5DiJyrNvmbssSXbWBkA-XUjGRdS8HtGvW1r6hw@mail.gmail.com>
 <20220408153447.GE4285@paulmck-ThinkPad-P17-Gen-1>
 <CAEXW_YT-vJmXgWPQ_1J34iTb+ZhrAgN7c-HPz7kW17HmvKzJ3A@mail.gmail.com>
 <20220408173908.GJ4285@paulmck-ThinkPad-P17-Gen-1>
 <20220409071740.6024-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220409071740.6024-1-hdanton@sina.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 09, 2022 at 03:17:40PM +0800, Hillf Danton wrote:
> On Fri, 8 Apr 2022 10:53:53 -0700 Kalesh Singh wrote
> > Thanks for the discussion everyone.
> > 
> > We didn't fully switch to kthread workers to avoid changing the
> > behavior for users that dont need this low latency exp GPs. Another
> > (and perhaps more important) reason is because kthread_worker offers
> > reduced concurrency than workqueues which Pual reported can pose
> > issues on systems with a large number of CPUs.
> 
> A second ... what issues were reported wrt concurrency, given the output
> of grep -nr workqueue block mm drivers.
> 
> Feel free to post a URL link to the issues.

The issues can be easily seen by inspecting kthread_queue_work() and
the functions that it invokes.  In contrast, normal workqueues uses
per-CPU mechanisms to avoid contention, as can equally easily be seen
by inspecting queue_work_on() and the functions that it invokes.

Please do feel free to take a look.

If taking a look does not convince you, please construct some in-kernel
benchmarks to test the scalability of these two mechanisms.  Please note
that some care will be required to make sure that you are doing a valid
apples-to-apples comparison.

							Thanx, Paul
