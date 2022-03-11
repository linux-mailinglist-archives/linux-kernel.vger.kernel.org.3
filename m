Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 345514D67AE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 18:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350793AbiCKRe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 12:34:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241879AbiCKRe1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 12:34:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4282FFCB57
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 09:33:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD9A3B82C87
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 17:33:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7139CC340EE;
        Fri, 11 Mar 2022 17:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647020000;
        bh=h4YcrFLT5L9IHxnYizYF6DXEs69GxUc/bE2JujXLGBY=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=grlCHjSKUeLW8HJDHZ+fLq8cn/y/zSGrAtSmPFvCvVHuo4ZTx14BlHvThnpi0NgWk
         WXLM/FWzNYsgQAa6dghxXiKdXoRSFhxp+stEV7LeozgOGe40EIM6/pCTRMQCmkGDnW
         kWAbdSi08io1iGyFAiiACGz7DGlOwg2ETRrjpFvhms+eRVI9d27josWxoZ4EgmzqZf
         a/1/b5LY4XeliaRJiQXNc1fb+nKw++jpvwpcd4PdweZRi0tDL1QPp534GIkLiL908K
         JBviZhEnpznmBbNuUKS7w3NZGNPd32z5heSoPXTdv5dStycO1degSe/APZZ0w7VI47
         3s3tfzT1Fx3OA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 16D2E5C0140; Fri, 11 Mar 2022 09:33:20 -0800 (PST)
Date:   Fri, 11 Mar 2022 09:33:20 -0800
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: Scenario TREE07 with CONFIG_PREEMPT_DYNAMIC=n?
Message-ID: <20220311173320.GK4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220310215630.GA3490034@paulmck-ThinkPad-P17-Gen-1>
 <20220310224103.GA94994@lothringen>
 <20220310225219.GE4285@paulmck-ThinkPad-P17-Gen-1>
 <20220311130719.GC96127@lothringen>
 <20220311152148.GF4285@paulmck-ThinkPad-P17-Gen-1>
 <20220311154603.GC227945@lothringen>
 <20220311160619.GG4285@paulmck-ThinkPad-P17-Gen-1>
 <20220311164758.GA3574399@paulmck-ThinkPad-P17-Gen-1>
 <20220311172620.GA229256@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220311172620.GA229256@lothringen>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 06:26:20PM +0100, Frederic Weisbecker wrote:
> On Fri, Mar 11, 2022 at 08:47:58AM -0800, Paul E. McKenney wrote:
> > And there is one more issue with this code.  Someone invoking
> > get_state_synchronize_rcu_expedited() in one task might naively expect
> > that calls to synchronize_rcu_expedited() in some other task would cause
> > a later poll_state_synchronize_rcu_expedited() would return true.
> > 
> > Except that if CONFIG_PREEMPT_NONE=y and there is only one CPU, those
> > calls to synchronize_rcu_expedited() won't be helping at all.
> > 
> > I could imagine poll_state_synchronize_rcu_expedited() setting a
> > global flag if there is only one CPU, which could be checked by
> > __synchronize_rcu_expedited() and reset.
> > 
> > Is there a better way?
> 
> I would tend to think that in this case, it's the responsibility of the
> caller to make sure that the task supposed to start the exp GP has a chance
> to run (cond_resched(), etc...).

Hahahahahahaha!

The same problem arises for poll_state_synchronize_rcu() and friends
on a single-CPU CONFIG_PREEMPT_NONE=y system.

							Thanx, Paul
