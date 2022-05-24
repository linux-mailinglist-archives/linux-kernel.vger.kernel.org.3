Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC8F6532FA2
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 19:29:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239950AbiEXR3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 13:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbiEXR26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 13:28:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65FC07DE00;
        Tue, 24 May 2022 10:28:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ED175614FB;
        Tue, 24 May 2022 17:28:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50F03C34100;
        Tue, 24 May 2022 17:28:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653413336;
        bh=OuUIX6i6CmssCGRzuFNEnxbirdfYgyCh/tlr9uIRveU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=uJfZPLKEPt9r6DC1v+/7HTQlHQLVxGsbHs9PeWKaui+W+fPkxhDWd6GXzEpCniCfo
         BRtSb/sFDYea6QFrJwVkS7HPgyLAgVf6PxgJUAYwzca8dTQKA5QrzFpw2CnmcI9EeU
         Ao4oM+lJS+/Ao1bbFsNabPvBeHHkc0OWsFxlz0wg/0GoedBXb6RIhrEp4ZL5plhI0k
         1bJ9M+SFsuclcwODEw+48hTBXBFW7bpag0SUKG/WqIxKrc+10sYb5cLAR4Ge9ozHf0
         aNTmzL2uPN837JvrGaMGYY/lp5x4PeG4VRf/Tc3PrqhbcYBbz6A46YiWqfUnyS4TWf
         5LDyn3AuJsCUQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id D95E15C0378; Tue, 24 May 2022 10:28:55 -0700 (PDT)
Date:   Tue, 24 May 2022 10:28:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Add no-idle tasks check which in dyntick-idle
 state
Message-ID: <20220524172855.GP1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220524003454.1887414-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524003454.1887414-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 08:34:52AM +0800, Zqiang wrote:
> These commit stop scanning no-idle tasks which in dyntick-idle state and
> remove idle-tasks check from warnings.

This patch might well be correct, but there are supposed to be upcoming
changes in the idle loop that would make it possible for RCU Tasks to
take idle tasks into account:

https://lore.kernel.org/all/20220515203653.4039075-1-jolsa@kernel.org/

There are currently issues in amd_e400_idle() and mwait_idle() preventing
this, and there might well also be similar issues in non-x86 idle loops:

https://lore.kernel.org/all/20220519135439.GX1790663@paulmck-ThinkPad-P17-Gen-1/

So I must hold off on this patch series for the time being.  Nevertheless,
thank you very much for your effort and interest in RCU.

							Thanx, Paul

> v1->v2:
> fix build error when CONFIG_TASKS_RCU=n
> v2->v3:
> remove idle-tasks check from task_is_on_dyntick_idle()
> 
> Zqiang (2):
>   rcu-tasks: Stop RCU Tasks scanning no-idle tasks which record on
>     dyntick-idle entry
>   rcu-tasks: Remove is_idle_task() from warnings in check_holdout_task()
> 
>  kernel/rcu/tasks.h | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> -- 
> 2.25.1
> 
