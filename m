Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE20508D32
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 18:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380547AbiDTQ1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 12:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380543AbiDTQ1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 12:27:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038EC3EAB3;
        Wed, 20 Apr 2022 09:24:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B8C16B81FEF;
        Wed, 20 Apr 2022 16:24:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65DE8C385A1;
        Wed, 20 Apr 2022 16:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650471866;
        bh=Z14csptkYo6YFkAsrY3X0v2ocRk84wD0ZQbb6BJb2ak=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=h6Cw0i4+9IWLE9+mDUzkjge/kwDznk3K5OZxVGzQGb/jU9pw12odJbeWVFC+Q5YbB
         3aWU5/AUFT5rDpI0sQ0rSLZ/fjceePjAoNeFCCNYG74bsql9y3LII7QT3nes00FuI2
         y/VPccjVTqCQqoxF/snZgTe/ywNAfyT27z00ztMYAAtoIL4eIYZtjkq2E75H8GIz+Z
         svcjnlHcULo3/XdXWPawHS4recVRRFqsot3las8mXX4gBfdcKoL1VrB2vp6elC1gk8
         FC07glMrFFLHDijeY36Fj1nol26XdYUNKySMuDFP8oApK2GVdxvxQYQmHBduU9q7C6
         H+CCdMdS/u4uQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EE0D75C0269; Wed, 20 Apr 2022 09:24:25 -0700 (PDT)
Date:   Wed, 20 Apr 2022 09:24:25 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Luis Chamberlain <mcgrof@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Zhen Ni <nizhen@uniontech.com>
Subject: Re: linux-next: manual merge of the sysctl tree with the rcu tree
Message-ID: <20220420162425.GF4285@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20220420153746.4790d532@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220420153746.4790d532@canb.auug.org.au>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 03:37:46PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the sysctl tree got a conflict in:
> 
>   kernel/rcu/rcu.h
> 
> between commit:
> 
>   95d4e9e339d1 ("rcu: Provide a get_completed_synchronize_rcu() function")
> 
> from the rcu tree and commit:
> 
>   d9ab0e63fa7f ("sched: Move rt_period/runtime sysctls to rt.c")
> 
> from the sysctl tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thank you, Stephen!  I have this one marked down.

							Thanx, Paul

> -- 
> Cheers,
> Stephen Rothwell
> 
> diff --cc kernel/rcu/rcu.h
> index 15b96f990774,7812c740b3bf..000000000000
> --- a/kernel/rcu/rcu.h
> +++ b/kernel/rcu/rcu.h
> @@@ -23,9 -23,8 +23,11 @@@
>   #define RCU_SEQ_CTR_SHIFT	2
>   #define RCU_SEQ_STATE_MASK	((1 << RCU_SEQ_CTR_SHIFT) - 1)
>   
>  +/* Low-order bit definition for polled grace-period APIs. */
>  +#define RCU_GET_STATE_COMPLETED	0x1
>  +
> + extern int sysctl_sched_rt_runtime;
> + 
>   /*
>    * Return the counter portion of a sequence number previously returned
>    * by rcu_seq_snap() or rcu_seq_current().


