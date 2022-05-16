Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635D8528DFE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 21:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345455AbiEPTeW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 15:34:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbiEPTeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 15:34:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 916113DDCF
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 12:34:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 518CDB81609
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 19:34:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56244C385AA;
        Mon, 16 May 2022 19:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652729657;
        bh=FB9eTZK8M04mRESOOhUpglawdFeeIp1rHdyPsEbNa7M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AO0cuWKrKGscIfaH4N5mnXVK50gmRj74AXOOThzkUiYoN/wfLHO1FWj3FpNRnHaYJ
         voHMGYt1JfiDCE1CFCyHapqFMA8cHUIK+jm/Nrk1KNtNzbXnShq6Zni2QRPGr3DDAd
         a2tufIWfrSzgCV7O6yALqFhAzyHEwSGpfM0ba8S8=
Date:   Mon, 16 May 2022 21:34:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Hao Luo <haoluo@google.com>
Cc:     Tejun Heo <tj@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernfs: Separate kernfs_pr_cont_buf and rename_lock.
Message-ID: <YoKnNZhgqTgkHmJ6@kroah.com>
References: <20220516190951.3144144-1-haoluo@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220516190951.3144144-1-haoluo@google.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 12:09:51PM -0700, Hao Luo wrote:
> Previously the protection of kernfs_pr_cont_buf was piggy backed by
> rename_lock, which means that pr_cont() needs to be protected under
> rename_lock. This can cause potential circular lock dependencies.
> 
> If there is an OOM, we have the following call hierarchy:
> 
>  -> cpuset_print_current_mems_allowed()
>    -> pr_cont_cgroup_name()
>      -> pr_cont_kernfs_name()
> 
> pr_cont_kernfs_name() will grab rename_lock and call printk. So we have
> the following lock dependencies:
> 
>  kernfs_rename_lock -> console_sem
> 
> Sometimes, printk does a wakeup before releasing console_sem, which has
> the dependence chain:
> 
>  console_sem -> p->pi_lock -> rq->lock
> 
> Now, imagine one wants to read cgroup_name under rq->lock, for example,
> printing cgroup_name in a tracepoint in the scheduler code. They will
> be holding rq->lock and take rename_lock:
> 
>  rq->lock -> kernfs_rename_lock
> 
> Now they will deadlock.
> 
> A prevention to this circular lock dependency is to separate the
> protection of pr_cont_buf from rename_lock. In principle, rename_lock
> is to protect the integrity of cgroup name when copying to buf. Once
> pr_cont_buf has got its content, rename_lock can be dropped. So it's
> safe to drop rename_lock after kernfs_name_locked (and
> kernfs_path_from_node_locked) and rely on a dedicated pr_cont_lock
> to protect pr_cont_buf.
> 
> Acked-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Hao Luo <haoluo@google.com>
> ---
>  fs/kernfs/dir.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
> index e205fde7163a..6eca72cfa1f2 100644
> --- a/fs/kernfs/dir.c
> +++ b/fs/kernfs/dir.c
> @@ -18,7 +18,15 @@
>  #include "kernfs-internal.h"
>  
>  static DEFINE_SPINLOCK(kernfs_rename_lock);	/* kn->parent and ->name */
> -static char kernfs_pr_cont_buf[PATH_MAX];	/* protected by rename_lock */
> +/*
> + * Don't use rename_lock to piggy back on pr_cont_buf. We don't want to
> + * call pr_cont() while holding rename_lock. Because sometimes pr_cont()
> + * will perform wakeups when releasing console_sem. Holding rename_lock
> + * will introduce deadlock if the scheduler reads the kernfs_name in the
> + * wakeup path.
> + */
> +static DEFINE_SPINLOCK(kernfs_pr_cont_lock);
> +static char kernfs_pr_cont_buf[PATH_MAX];	/* protected by pr_cont_lock */
>  static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
>  
>  #define rb_to_kn(X) rb_entry((X), struct kernfs_node, rb)
> @@ -229,12 +237,12 @@ void pr_cont_kernfs_name(struct kernfs_node *kn)
>  {
>  	unsigned long flags;
>  
> -	spin_lock_irqsave(&kernfs_rename_lock, flags);
> +	spin_lock_irqsave(&kernfs_pr_cont_lock, flags);
>  
> -	kernfs_name_locked(kn, kernfs_pr_cont_buf, sizeof(kernfs_pr_cont_buf));
> +	kernfs_name(kn, kernfs_pr_cont_buf, sizeof(kernfs_pr_cont_buf));
>  	pr_cont("%s", kernfs_pr_cont_buf);
>  
> -	spin_unlock_irqrestore(&kernfs_rename_lock, flags);
> +	spin_unlock_irqrestore(&kernfs_pr_cont_lock, flags);
>  }
>  
>  /**
> @@ -248,10 +256,10 @@ void pr_cont_kernfs_path(struct kernfs_node *kn)
>  	unsigned long flags;
>  	int sz;
>  
> -	spin_lock_irqsave(&kernfs_rename_lock, flags);
> +	spin_lock_irqsave(&kernfs_pr_cont_lock, flags);
>  
> -	sz = kernfs_path_from_node_locked(kn, NULL, kernfs_pr_cont_buf,
> -					  sizeof(kernfs_pr_cont_buf));
> +	sz = kernfs_path_from_node(kn, NULL, kernfs_pr_cont_buf,
> +				   sizeof(kernfs_pr_cont_buf));
>  	if (sz < 0) {
>  		pr_cont("(error)");
>  		goto out;
> @@ -265,7 +273,7 @@ void pr_cont_kernfs_path(struct kernfs_node *kn)
>  	pr_cont("%s", kernfs_pr_cont_buf);
>  
>  out:
> -	spin_unlock_irqrestore(&kernfs_rename_lock, flags);
> +	spin_unlock_irqrestore(&kernfs_pr_cont_lock, flags);
>  }
>  
>  /**
> @@ -823,13 +831,12 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
>  
>  	lockdep_assert_held_read(&kernfs_root(parent)->kernfs_rwsem);
>  
> -	/* grab kernfs_rename_lock to piggy back on kernfs_pr_cont_buf */
> -	spin_lock_irq(&kernfs_rename_lock);
> +	spin_lock_irq(&kernfs_pr_cont_lock);
>  
>  	len = strlcpy(kernfs_pr_cont_buf, path, sizeof(kernfs_pr_cont_buf));
>  
>  	if (len >= sizeof(kernfs_pr_cont_buf)) {
> -		spin_unlock_irq(&kernfs_rename_lock);
> +		spin_unlock_irq(&kernfs_pr_cont_lock);
>  		return NULL;
>  	}
>  
> @@ -841,7 +848,7 @@ static struct kernfs_node *kernfs_walk_ns(struct kernfs_node *parent,
>  		parent = kernfs_find_ns(parent, name, ns);
>  	}
>  
> -	spin_unlock_irq(&kernfs_rename_lock);
> +	spin_unlock_irq(&kernfs_pr_cont_lock);
>  
>  	return parent;
>  }
> -- 
> 2.36.1.124.g0e6072fb45-goog
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- This looks like a new version of a previously submitted patch, but you
  did not list below the --- line any changes from the previous version.
  Please read the section entitled "The canonical patch format" in the
  kernel file, Documentation/SubmittingPatches for what needs to be done
  here to properly describe this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot
