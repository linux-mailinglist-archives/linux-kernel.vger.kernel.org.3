Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD57B47621D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 20:49:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbhLOTtH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 14:49:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhLOTtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:49:04 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2FDC061574;
        Wed, 15 Dec 2021 11:49:04 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id z8so34950263ljz.9;
        Wed, 15 Dec 2021 11:49:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vcNX1xtWpeU6LVfIzPLuSSCjELleiDOsKNoz5AgStk0=;
        b=Kd8faY5eDP7NRPVckgnWz2dYj7gUEn80dpaBaxFckJmQGb3SZCjDaBBWUtp04FQdxC
         6zgUOxyNGL5lnv+i3VSfyqCtruO5+uuv70S6KPZGGr0nwfVU+ybGiZPJ8T3xZz+loZRu
         LPOfL97FdJtjGhHe8uXHv8s411W0ZA9FsMIGF0K5GOZ+qY/chEGBsV/FUzoMnRwIy9/2
         8/kSKP6YmfJyOycIPrZ5dMbwuJsqQ0HydwxD5UnxkD8hlbyvTx6RGBB3RR2zV0EReMJp
         mi7n3VHRqYm8cmaj0ulaRcp2araNzhCSs2JYoTJmtsB81dntx2nxVF9YyWq4NkNFFBXp
         EYuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vcNX1xtWpeU6LVfIzPLuSSCjELleiDOsKNoz5AgStk0=;
        b=RgbgoF+Mhc43cTriTzzFJsdR1f7I3Ty9N/TEAooASAghizgwQ/RZ/LeQwbcTSHPB71
         3XOqc9uCRZbjEzvgEWvI6qFMC8iqQ3dG6CQCV+qyGKBQ8MxjZptzvmHLuFsH+xcHfvai
         OINkh/mp/ikf8sNHn1rXl8O5LErlt5m0t9jNW7BRmAf82MWXw4fkP3VPLAUYx1qVfrcX
         0CZ2zk5/jUle2ZFngqINtXlrG26X+qtrOwdP7K6SO5VfZ30ofeTkmsOczhkjJxb/FzWj
         TlaxdFhPG+tZwQ/B10qB4hwZXm7nE2eapfhpwtnvigk8thy5mr+rNI8rCUwRs39+trdo
         W4mg==
X-Gm-Message-State: AOAM530G1PUjSpnapJjazbTHYgYxgDXuX+EukZLWz9ikL1dIFPQ0lRRl
        QD1gI3e/MDVMIPJbLkHp+Go=
X-Google-Smtp-Source: ABdhPJyH3C+WsPMpaOxKQZx3ZdYX2ooepOrTvghaXCtXe4NyX7OT3qYVXYDAMPZHBUxDrntVD+V0Uw==
X-Received: by 2002:a2e:a279:: with SMTP id k25mr11912398ljm.37.1639597742446;
        Wed, 15 Dec 2021 11:49:02 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id e17sm466706lfq.102.2021.12.15.11.49.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 11:49:01 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 15 Dec 2021 20:48:59 +0100
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
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
        Oleksiy Avramchenko <oleksiy.avramchenko@sonymobile.com>
Subject: Re: [PATCH] scsi: core: Switch to kvfree_rcu() API
Message-ID: <YbpGq1GkO/14i939@pc638.lan>
References: <20211215111845.2514-1-urezki@gmail.com>
 <20211215111845.2514-9-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215111845.2514-9-urezki@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 12:18:45PM +0100, Uladzislau Rezki (Sony) wrote:
> Instead of invoking a synchronize_rcu() to free a pointer
> after a grace period we can directly make use of new API
> that does the same but in more efficient way.
> 
> TO: James E.J. Bottomley <jejb@linux.ibm.com>
> TO: Martin K. Petersen <martin.petersen@oracle.com>
> TO: linux-scsi@vger.kernel.org
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  drivers/scsi/device_handler/scsi_dh_alua.c | 3 +--
>  drivers/scsi/device_handler/scsi_dh_rdac.c | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/scsi/device_handler/scsi_dh_alua.c b/drivers/scsi/device_handler/scsi_dh_alua.c
> index 37d06f993b76..308246ce346a 100644
> --- a/drivers/scsi/device_handler/scsi_dh_alua.c
> +++ b/drivers/scsi/device_handler/scsi_dh_alua.c
> @@ -1238,8 +1238,7 @@ static void alua_bus_detach(struct scsi_device *sdev)
>  		kref_put(&pg->kref, release_port_group);
>  	}
>  	sdev->handler_data = NULL;
> -	synchronize_rcu();
> -	kfree(h);
> +	kvfree_rcu(h);
>  }
>  
>  static struct scsi_device_handler alua_dh = {
> diff --git a/drivers/scsi/device_handler/scsi_dh_rdac.c b/drivers/scsi/device_handler/scsi_dh_rdac.c
> index 66652ab409cc..dc687021ff3a 100644
> --- a/drivers/scsi/device_handler/scsi_dh_rdac.c
> +++ b/drivers/scsi/device_handler/scsi_dh_rdac.c
> @@ -782,8 +782,7 @@ static void rdac_bus_detach( struct scsi_device *sdev )
>  	}
>  	spin_unlock(&list_lock);
>  	sdev->handler_data = NULL;
> -	synchronize_rcu();
> -	kfree(h);
> +	kvfree_rcu(h);
>  }
>  
>  static struct scsi_device_handler rdac_dh = {
> -- 
> 2.30.2
> 
+ James E.J. Bottomley <jejb@linux.ibm.com>
+ Martin K. Petersen <martin.petersen@oracle.com>
+ linux-scsi@vger.kernel.org

--
Vlad Rezki
