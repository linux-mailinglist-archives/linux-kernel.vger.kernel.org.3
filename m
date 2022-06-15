Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C163554C10D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 07:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345703AbiFOFPa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 01:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235251AbiFOFP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 01:15:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A08E2FE78;
        Tue, 14 Jun 2022 22:15:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B7D0B81BF1;
        Wed, 15 Jun 2022 05:15:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2F23C34115;
        Wed, 15 Jun 2022 05:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655270122;
        bh=l7Ooh1K8E7d1b4QbCo+pmpsWrgYmk62wXLDqM7Ns1G0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=FEbBm0MVASqmsGMDxLQiPui09BE4UmwquG7QBPWHfj/FkL8OxEbTm90Iv89eu2Vhk
         1uRAFgS4m/kp+eKXJYzpKOY7c/emgpeRdwqziicWg/ta7Lp47ALJGCCR6R6AOfOwve
         llI4iYGRfjU5criKVMfoOhgmHj5r5I6Bu4qfSrSqNVVJ9mtKpP00uEGcgCzzE87sj6
         hpUNBuxFSh8G1t/artem+HM4aCOUaUoj8ownZv+aOOxsgCOssA6aHDxs6vqD0pTHCV
         jM/GXmiXCuaZPsJHH2XfIE2t43kFZJVtEs+yEZkLBnz+xC50T8k6L8nLjVaM5UO95n
         GmIx7SviGMOEQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A0F6C5C0BCC; Tue, 14 Jun 2022 22:15:21 -0700 (PDT)
Date:   Tue, 14 Jun 2022 22:15:21 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     zhouzhouyi@gmail.com
Cc:     john.ogness@linutronix.de, pmladek@suse.com, dave@stgolabs.net,
        josh@joshtriplett.org, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: Re: [PATCH linux-next] RFC: torture: add pr_flush to flush the
 results to console
Message-ID: <20220615051521.GH1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220615003733.16447-1-zhouzhouyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220615003733.16447-1-zhouzhouyi@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 15, 2022 at 08:37:33AM +0800, zhouzhouyi@gmail.com wrote:
> From: Zhouyi Zhou <zhouzhouyi@gmail.com>
> 
> currently tools/testing/selftests/rcutorture/bin/torture.sh reports
> false positve because of kthread printing.
> 
> Commit "printk: add functions to prefer direct printing" (2bb2b7b57f812)
> have added functions to prefer direct printing activated for the primary
> import messages.
> 
> Meanwhile adding printk_prefer_direct_enter/exit to
> torture_cleanup_begin/end still can't eliminate the false positives
> for a hundred percent.
> 
> This patch add pr_flush to torture_cleanup_end because the latter
> is sleepable.
> 
> Reported-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
> Tested-by: Zhouyi Zhou <zhouzhouyi@gmail.com> 

Just the one Signed-off-by suffices.  ;-)

> ---
>  kernel/torture.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/torture.c b/kernel/torture.c
> index 789aeb0e1159..b51e42463a67 100644
> --- a/kernel/torture.c
> +++ b/kernel/torture.c
> @@ -878,6 +878,7 @@ void torture_cleanup_end(void)
>  	mutex_lock(&fullstop_mutex);
>  	torture_type = NULL;
>  	mutex_unlock(&fullstop_mutex);
> +	pr_flush(1000, true);

But in this case, the kernel keeps on running, correct?  So won't the
output appear over time?  All of printk()'s kthreads are still running
after all.

Or do you have a use case that requires that the output appear sooner
than it does?  If so, please let me know what that is.

							Thanx, Paul

>  }
>  EXPORT_SYMBOL_GPL(torture_cleanup_end);
>  
> -- 
> 2.25.1
> 
