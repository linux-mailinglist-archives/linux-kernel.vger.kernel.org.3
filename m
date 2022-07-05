Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CBD75675EA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 19:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233300AbiGERlR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 13:41:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233135AbiGERlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 13:41:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E71718349;
        Tue,  5 Jul 2022 10:41:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC5DBB818C0;
        Tue,  5 Jul 2022 17:41:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 638EDC341C7;
        Tue,  5 Jul 2022 17:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657042870;
        bh=q8rfywL/asCDFzl+bzNB69RsGPcFbxMWNXZd9uMb3Dk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=CQSlWtkwC49c12+k+bAdxtXibl8dRGxFT2w1RxWsKVWXgw+XPBLHY74l4RwD6q+HL
         +mh9EYfyi9/KP0YmI58vw1H9arwv3GEJWXQnNVyqId1hGdFN1J6e+ZoN4adyfwGW5Q
         FZdhBG9vYys8RDO9PS3D3AKYshM/EHQNFwKwJ7XaeqAgB/yTQB1Lz+OgEHIPI7CJz3
         j6tu5d/o/AQSeu8SFblpa2rXtljcEFtNbjeTGCsAclohwE8EB0pOk1PUH+ZmfxtvvE
         foJAg9XEUrMXNuCY3bxXZjidzz/Rf8hpkRmMTcGYCC7BwvSZdMmDnIGue7DADpsdI+
         HTvTElm4Q1vSg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id F15FC5C05ED; Tue,  5 Jul 2022 10:41:09 -0700 (PDT)
Date:   Tue, 5 Jul 2022 10:41:09 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, quic_neeraju@quicinc.com, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] rcu: Make tiny RCU support leak callbacks for
 debug-object errors
Message-ID: <20220705174109.GD1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220701024404.2228367-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701024404.2228367-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2022 at 10:44:04AM +0800, Zqiang wrote:
> Currently, only tree RCU support leak callbacks setting when do
> duplicate call_rcu(). this commit add leak callbacks setting when
> fo duplicate call_rcu() for tiny RCU.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

This does look plausible, thank you!

What testing have you done?

One important test for Tiny RCU is that the size of the kernel not
grow without a very good reason.  In this case, the added code should
be dead code in a production build (CONFIG_DEBUG_OBJECTS_RCU_HEAD=n),
but it is good to check.

It is of course also good to check that the messages print as expected,
which is what rcutorture.object_debug is there to help with.

							Thanx, Paul

> ---
>  v1->v2:
>  for do duplicate kvfree_call_rcu(), not set leak callbacks. 
> 
>  kernel/rcu/tiny.c | 17 ++++++++++++++++-
>  1 file changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
> index f0561ee16b9c..943d431b908f 100644
> --- a/kernel/rcu/tiny.c
> +++ b/kernel/rcu/tiny.c
> @@ -158,6 +158,10 @@ void synchronize_rcu(void)
>  }
>  EXPORT_SYMBOL_GPL(synchronize_rcu);
>  
> +static void tiny_rcu_leak_callback(struct rcu_head *rhp)
> +{
> +}
> +
>  /*
>   * Post an RCU callback to be invoked after the end of an RCU grace
>   * period.  But since we have but one CPU, that would be after any
> @@ -165,9 +169,20 @@ EXPORT_SYMBOL_GPL(synchronize_rcu);
>   */
>  void call_rcu(struct rcu_head *head, rcu_callback_t func)
>  {
> +	static atomic_t doublefrees;
>  	unsigned long flags;
>  
> -	debug_rcu_head_queue(head);
> +	if (debug_rcu_head_queue(head)) {
> +		if (atomic_inc_return(&doublefrees) < 4) {
> +			pr_err("%s(): Double-freed CB %p->%pS()!!!  ", __func__, head, head->func);
> +			mem_dump_obj(head);
> +		}
> +
> +		if (!__is_kvfree_rcu_offset((unsigned long)head->func))
> +			WRITE_ONCE(head->func, tiny_rcu_leak_callback);
> +		return;
> +	}
> +
>  	head->func = func;
>  	head->next = NULL;
>  
> -- 
> 2.25.1
> 
