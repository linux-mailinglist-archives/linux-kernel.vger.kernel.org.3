Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B45B4D6794
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 18:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350756AbiCKR13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 12:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350003AbiCKR11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 12:27:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D88F91D21E0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 09:26:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 799AD61B4A
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 17:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 602C1C340E9;
        Fri, 11 Mar 2022 17:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647019583;
        bh=4Rc2G7Bf2wtSLLayL6+3/TOHRyUSOxjI9bDKZYIsqEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p49wM+pR/bGJ7mySZWeLuvJYZjkTUtiunRzzIULQLLym81KuXiNRTIYHS0fecdjlD
         M+5wkYTp/CDN2cxpsV7OezNk4seb2iqcLFsLrPawZP30S5dQP6bB3Wh1CO0TRwOWbV
         ba9hzSaTcjuxaS7ZNjDyuMWtmuFba6r9jOJneFqFyLqPLiDa/H22OGUOpu+m3ELhwV
         nZG+5uZ7rqEL9VlsFae120TbD0PuoYHSFqeqQo2Mpo7T6wVEtwBBhk6caEP1tphHrq
         67rLiwAb2ZsDNlo3gpInuskEG7j0KQgKZKmu62dOL/3Lj5xRAaTKTyoX+Lbk/+ZDm0
         J6M0UEH5uxPeg==
Date:   Fri, 11 Mar 2022 18:26:20 +0100
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Scenario TREE07 with CONFIG_PREEMPT_DYNAMIC=n?
Message-ID: <20220311172620.GA229256@lothringen>
References: <20220310215630.GA3490034@paulmck-ThinkPad-P17-Gen-1>
 <20220310224103.GA94994@lothringen>
 <20220310225219.GE4285@paulmck-ThinkPad-P17-Gen-1>
 <20220311130719.GC96127@lothringen>
 <20220311152148.GF4285@paulmck-ThinkPad-P17-Gen-1>
 <20220311154603.GC227945@lothringen>
 <20220311160619.GG4285@paulmck-ThinkPad-P17-Gen-1>
 <20220311164758.GA3574399@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311164758.GA3574399@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 08:47:58AM -0800, Paul E. McKenney wrote:
> And there is one more issue with this code.  Someone invoking
> get_state_synchronize_rcu_expedited() in one task might naively expect
> that calls to synchronize_rcu_expedited() in some other task would cause
> a later poll_state_synchronize_rcu_expedited() would return true.
> 
> Except that if CONFIG_PREEMPT_NONE=y and there is only one CPU, those
> calls to synchronize_rcu_expedited() won't be helping at all.
> 
> I could imagine poll_state_synchronize_rcu_expedited() setting a
> global flag if there is only one CPU, which could be checked by
> __synchronize_rcu_expedited() and reset.
> 
> Is there a better way?

I would tend to think that in this case, it's the responsibility of the
caller to make sure that the task supposed to start the exp GP has a chance
to run (cond_resched(), etc...).
