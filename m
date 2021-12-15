Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D24247620A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 20:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbhLOTp0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 14:45:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhLOTpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:45:25 -0500
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F6FC061574;
        Wed, 15 Dec 2021 11:45:25 -0800 (PST)
Received: by mail-lj1-x22d.google.com with SMTP id k2so34930127lji.4;
        Wed, 15 Dec 2021 11:45:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=U5tqj6k9Ifp4zAPqxyS1kKPXLpJGsk82GBuZYk+1lCw=;
        b=lrr8CLUO4ilsrjIFwukVXpAtwd/DJL9fu5Ork6LvtJjzf0kjZMS01HTjmN+0p8uZWH
         YJMkIvz1TdsfhY9RplUo9mXXroUqAW/IVKUW4+N9QYZYANBUIjecyNpg4d2G6RjYNewk
         WJMeVZLGQAW3z8tiRWShLphToBy7PzPxDNTH4S9Xvgt59Akto4ZR6g/DmxQZGlTLmgnv
         oiufvODWf+ZvxL5FyYcBEYLNsmIF/om+gmFQzrO6S4yuT3D9QPLhnevev8m4CUfL1QgE
         NeeZGr6WApauYMoLUd6YnEp/2NZBCwSNi2LNIv1iN+ReNvPJnTTw9kCJ1TmasLrZ0kcG
         bjGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U5tqj6k9Ifp4zAPqxyS1kKPXLpJGsk82GBuZYk+1lCw=;
        b=dPt/XeK4N7qhUQ6YHMrQdC+eRYtF2izIwHPp1+K6cqOY+vcl5vuNyBt2cAOh6Z802y
         EYM45nm4XIksxbJM99XbV89a5pj556kk8MLWziftq2dk5AueIZJBE95TQ+6k7nuMHiSU
         fPuydX/tFshOE1BrjNx6wfgQ4BR7DyiXpymOslPzobCVz8jLYzrvfOQErnVLeBNbmLZc
         l6skI+9YW8OKCZpvDTjK+yhuC8ODuAzIS9lOcflUtKVQayLe89UR6bmiGHbTL+a4ffb+
         sLu/8ebKp0TZiLi8bzS10WSjTN2xUGF2t8OyJALZ4ODNwmplTI1lEzNSuxYvw27M1VSC
         5nqw==
X-Gm-Message-State: AOAM530R4lvcjnJBqLGdaKK+wFVaG+9VhZzw9eT1Ppi5CXtnBG6gQ0gs
        rXB4rSmjXWJ8+yN+Q7xpyCo=
X-Google-Smtp-Source: ABdhPJzkdNxkaiGWL+9ZHndd6/Llp36bQcuYkYkzaBW9HZhyI6AepfXzKB7om1HogDN+MDyMMr9sIg==
X-Received: by 2002:a2e:974e:: with SMTP id f14mr11924549ljj.153.1639597523799;
        Wed, 15 Dec 2021 11:45:23 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id u22sm466206lff.118.2021.12.15.11.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 11:45:23 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 15 Dec 2021 20:45:21 +0100
To:     Jorgen Hansen <jhansen@vmware.com>, Vishnu Dasa <vdasa@vmware.com>,
        pv-drivers@vmware.com
Cc:     LKML <linux-kernel@vger.kernel.org>, RCU <rcu@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Axtens <dja@axtens.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <neeraju@codeaurora.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] misc: vmw_vmci: Switch to kvfree_rcu() API
Message-ID: <YbpF0WTOOBqdg6tL@pc638.lan>
References: <20211215111845.2514-1-urezki@gmail.com>
 <20211215111845.2514-6-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215111845.2514-6-urezki@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 12:18:42PM +0100, Uladzislau Rezki (Sony) wrote:
> Instead of invoking a synchronize_rcu() to free a pointer
> after a grace period we can directly make use of new API
> that does the same but in more efficient way.
> 
> CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> TO: Jorgen Hansen <jhansen@vmware.com>
> TO: Vishnu Dasa <vdasa@vmware.com>
> TO: pv-drivers@vmware.com
> 
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  drivers/misc/vmw_vmci/vmci_context.c | 6 ++----
>  drivers/misc/vmw_vmci/vmci_event.c   | 3 +--
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/misc/vmw_vmci/vmci_context.c b/drivers/misc/vmw_vmci/vmci_context.c
> index c0b5e339d5a1..6cf3e21c7604 100644
> --- a/drivers/misc/vmw_vmci/vmci_context.c
> +++ b/drivers/misc/vmw_vmci/vmci_context.c
> @@ -687,10 +687,8 @@ int vmci_ctx_remove_notification(u32 context_id, u32 remote_cid)
>  	}
>  	spin_unlock(&context->lock);
>  
> -	if (found) {
> -		synchronize_rcu();
> -		kfree(notifier);
> -	}
> +	if (found)
> +		kvfree_rcu(notifier);
>  
>  	vmci_ctx_put(context);
>  
> diff --git a/drivers/misc/vmw_vmci/vmci_event.c b/drivers/misc/vmw_vmci/vmci_event.c
> index e3436abf39f4..2100297c94ad 100644
> --- a/drivers/misc/vmw_vmci/vmci_event.c
> +++ b/drivers/misc/vmw_vmci/vmci_event.c
> @@ -209,8 +209,7 @@ int vmci_event_unsubscribe(u32 sub_id)
>  	if (!s)
>  		return VMCI_ERROR_NOT_FOUND;
>  
> -	synchronize_rcu();
> -	kfree(s);
> +	kvfree_rcu(s);
>  
>  	return VMCI_SUCCESS;
>  }
> -- 
> 2.30.2
> 
+ Jorgen Hansen <jhansen@vmware.com>
+ Vishnu Dasa <vdasa@vmware.com>
+ pv-drivers@vmware.com

--
Vlad Rezki
