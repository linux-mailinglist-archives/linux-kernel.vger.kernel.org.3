Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C452752591C
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 02:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359773AbiEMAuC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 20:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357287AbiEMAt7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 20:49:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E559116D5E8;
        Thu, 12 May 2022 17:49:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A6F17B8200D;
        Fri, 13 May 2022 00:49:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9D0C385B8;
        Fri, 13 May 2022 00:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652402996;
        bh=g0IhZHLcypRMQEW3o9PkdjskIdxfRPbz9rwZfz1QTYQ=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IvK0BxYHQaxctgykLUVShK8eT+1vvPT8PGzmI905HRkCgbpUbJj/RzHFDrw78jARV
         wTpwMVkhtD+lIrAfcPZdiachNhQgmFKlHcon8p/I0DTrvGE8OzL6myB62/fOdIM2m7
         a3JOZCFRvMtnZ6VOFmeAx+miph2rgA1zJJCsKtLpwykj1wd2BefCaW50HJ22eZ07kY
         voOexYYHRbMpF5fIVXypQquRjRsIyAx827pjzBaqu3g7MzOYGTvUik2k3n7Nh8/CAp
         dfpXSYV0AOP+z7uSTZA4G2pIJOoXDezNLFcQYIKLJrma+lefOm+mQh3fB3o5czUapv
         +0GWy8BAqrdsg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E92075C051B; Thu, 12 May 2022 17:49:55 -0700 (PDT)
Date:   Thu, 12 May 2022 17:49:55 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Zqiang <qiang1.zhang@intel.com>
Cc:     frederic@kernel.org, rcu@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rcu: Remove debug_object_active_state() from
 debug_rcu_head_queue/unqueue()
Message-ID: <20220513004955.GC1790663@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220510030748.1814004-1-qiang1.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510030748.1814004-1-qiang1.zhang@intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 11:07:48AM +0800, Zqiang wrote:
> Currently, the double call_rcu() detected only need call
> debug_object_activate() to check whether the rcu head object is
> activated, the rcu head object usage state check is not necessary
> and when call rcu_test_debug_objects() the debug_object_active_state()
> will output same callstack as debug_object_activate(). so remove
> debug_object_active_state() to reduce the output of repeated callstack.
> 
> Signed-off-by: Zqiang <qiang1.zhang@intel.com>

Could you please post the output of the dmesg output of a failed
check with your change?

							Thanx, Paul

> ---
>  kernel/rcu/rcu.h | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
> index 15b96f990774..0604ecd16627 100644
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@ -179,27 +179,16 @@ static inline unsigned long rcu_seq_diff(unsigned long new, unsigned long old)
>   */
>  
>  #ifdef CONFIG_DEBUG_OBJECTS_RCU_HEAD
> -# define STATE_RCU_HEAD_READY	0
> -# define STATE_RCU_HEAD_QUEUED	1
>  
>  extern const struct debug_obj_descr rcuhead_debug_descr;
>  
>  static inline int debug_rcu_head_queue(struct rcu_head *head)
>  {
> -	int r1;
> -
> -	r1 = debug_object_activate(head, &rcuhead_debug_descr);
> -	debug_object_active_state(head, &rcuhead_debug_descr,
> -				  STATE_RCU_HEAD_READY,
> -				  STATE_RCU_HEAD_QUEUED);
> -	return r1;
> +	return debug_object_activate(head, &rcuhead_debug_descr);
>  }
>  
>  static inline void debug_rcu_head_unqueue(struct rcu_head *head)
>  {
> -	debug_object_active_state(head, &rcuhead_debug_descr,
> -				  STATE_RCU_HEAD_QUEUED,
> -				  STATE_RCU_HEAD_READY);
>  	debug_object_deactivate(head, &rcuhead_debug_descr);
>  }
>  #else	/* !CONFIG_DEBUG_OBJECTS_RCU_HEAD */
> -- 
> 2.25.1
> 
