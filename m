Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95FC2476207
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 20:44:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232419AbhLOToE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 14:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbhLOToD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 14:44:03 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C8CC061574;
        Wed, 15 Dec 2021 11:44:02 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id 13so34832374ljj.11;
        Wed, 15 Dec 2021 11:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=l8LbkgeOuF1NFCsdQoXLkD/5dTY/no2XlRKkmb1RC6o=;
        b=ALZ0oy71pz7jkih6vTdLH/REKeB9XfVGw01bYk/kVZmXYvQRzfeT+FYFlFjU4gkAm0
         oH5NudVBWAhEjO3IwWVcw9J1LNOFuZTIVFesTfVpDUKusns6RrXX4QXtK1XrHYmNAgKB
         6LUctJMoNAQeCJzTRKXip0/R+Ucj+wkar34JiywxQ+mIDm5GB+uH4yA4Q1PmsI8nDwEn
         TnINkRpOFuXQRQbSJAvOp2WIjoWKj+4wJqYsd3pyvyhwM/MIquQ68Q0qaebxVga++Vky
         ZM8avxoY1EMvBm6SbwN4qgvmsHNsa/5Lk26kYKGqJPGLNAK0tZXt4Oz9sJYxmJmIRbjv
         Tp0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=l8LbkgeOuF1NFCsdQoXLkD/5dTY/no2XlRKkmb1RC6o=;
        b=E6MasPGhmQ3lYsRCjNfdkjUfoJQD24T1umj6PRbRqBx1Yt+dyAn1XWEMSPNsNwc8p1
         ha4WRTMJ7wBa/IbtEmDFGrUrIzxi8A4ozZeJkANSkOm2a4YGYers+GfjByJ5R6EjfK9b
         FvLvinmnwfRc+iUWHNwP5ajgBdw+HvcjbSmzOQgRPOcDHhM+BF7AUeUp9BOmYPiwj13X
         wOfVoGhR8OMq53OsNGr13AJTHzq/MUl7q3+lE7shKyOUDd6FDS8WCtpGFqSIR7Nhwy61
         q9+USY9gTrh4V6J/z4Esa+FkXXOyE8F5dz+7xLzrlNfZyt/hoTXvjS+Bo4PUe6iADZ/9
         kVVg==
X-Gm-Message-State: AOAM533KeINPqzi3820iwErtxkZ211Z0/hC17TLRsn6RRv+rPYcVtdLg
        bupEhbfsJViE6PzQpcCVfJA=
X-Google-Smtp-Source: ABdhPJy8vBMl/BU1gYTWShY8doWiTiWPMEQvKiFbwGWjGI/AJu9xDtb2GMFizlsUOSEjT/eTAHUR5A==
X-Received: by 2002:a2e:a409:: with SMTP id p9mr11700493ljn.412.1639597441101;
        Wed, 15 Dec 2021 11:44:01 -0800 (PST)
Received: from pc638.lan (h5ef52e3d.seluork.dyn.perspektivbredband.net. [94.245.46.61])
        by smtp.gmail.com with ESMTPSA id a29sm462118lfi.302.2021.12.15.11.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 11:44:00 -0800 (PST)
From:   Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc638.lan>
Date:   Wed, 15 Dec 2021 20:43:58 +0100
To:     Lee Jones <lee.jones@linaro.org>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
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
Subject: Re: [PATCH] mfd: dln2: Switch to kvfree_rcu() API
Message-ID: <YbpFfsTvB96g4+yU@pc638.lan>
References: <20211215111845.2514-1-urezki@gmail.com>
 <20211215111845.2514-5-urezki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215111845.2514-5-urezki@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 12:18:41PM +0100, Uladzislau Rezki (Sony) wrote:
> Instead of invoking a synchronize_rcu() to free a pointer
> after a grace period we can directly make use of new API
> that does the same but in more efficient way.
> 
> TO: Lee Jones <lee.jones@linaro.org>
> TO: Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
> Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
> ---
>  drivers/mfd/dln2.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/mfd/dln2.c b/drivers/mfd/dln2.c
> index 852129ea0766..365e3e77cac4 100644
> --- a/drivers/mfd/dln2.c
> +++ b/drivers/mfd/dln2.c
> @@ -179,10 +179,8 @@ void dln2_unregister_event_cb(struct platform_device *pdev, u16 id)
>  
>  	spin_unlock_irqrestore(&dln2->event_cb_lock, flags);
>  
> -	if (found) {
> -		synchronize_rcu();
> -		kfree(i);
> -	}
> +	if (found)
> +		kvfree_rcu(i);
>  }
>  EXPORT_SYMBOL(dln2_unregister_event_cb);
>  
> -- 
> 2.30.2
> 
+ Lee Jones <lee.jones@linaro.org>                                                                                                                                                     
+ Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>

--
Vlad Rezki
