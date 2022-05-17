Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBE2552ABCD
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 21:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352659AbiEQTTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 15:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352579AbiEQTTP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 15:19:15 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878F0424AF
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:19:14 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id n18so18207203plg.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 12:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uFpzKd8+5eur2wnKQGvnGRu8GddC8MabfhuazKv+lQE=;
        b=Ht5NLjURccfwH5eRnozuDpzDT+vxXb107WEJ1vLRCu2coMyeKDWx2GQ9oegu7jKrmx
         RyMtljPSemntkEKFeXsAN050wKX0wgE/jsV36NQcepCnzmBzLztdBaevy0QrD9tAqWGL
         gObyokYjTTVajTRzHGHWQzoDuo9+bh3iHIdTN33+9TC8JU63Md3G2Sw5l+JSGvDzaCk4
         HA1PVBrOLZtU0nYAN6Issihrb/CMwvTkoaj8h+ssUTxk75eU+wvvugztlM7pRzwOKDCA
         9Z8/GaR7UxuxwuTa5gXJzIcg4Km34zGZGIJRynkrmBXOw+K5GckP+zNm6Bikt5DcxtvT
         Eg3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uFpzKd8+5eur2wnKQGvnGRu8GddC8MabfhuazKv+lQE=;
        b=2qlOUhvwcKf9v9hA41/3odEJYVKli/HY8n7i2xusupnLCxJZFItkS7zPUqyfrh4YNu
         tiYQepWpjN1UC0c12MaNbNiZkzj2sFzj87i0rPQjfaW/x2ViW8RT9eGo0sdn4XIpoTtY
         W8LSbbLT0z9TOzcuEy9flkCsuX27P5SWMdXNwiZ73aCm5Xx+X43pldJ64BTdhTeSeHD0
         rRyGc/QcZOV+MJkBVyQ7kHfvJ+C3m9HfUigLQiBEK6TlURAfIwmHkHIKN/C+tcDW/TRF
         SZ2JldZhwXTfQ6dbKLAzzZKY7z35DIm7UZDT/9z8HeTdr9fmehEUiBxQEgxb4kjG0eBe
         WzJA==
X-Gm-Message-State: AOAM530xe7vqOO6nnlF4vODjLGuQD94+jXm+MNApsbBIa9CajWriklHq
        DZPgnC5EaRIDh25In2rkbm0peQ==
X-Google-Smtp-Source: ABdhPJxwIeudU5F7scZJ2Z/4JvN7ksPaAFpJpjuAl7Cmz0kb9tcKYL/uFJPN2iknvyDqhYe81zdurw==
X-Received: by 2002:a17:902:e948:b0:15e:cd79:2a1a with SMTP id b8-20020a170902e94800b0015ecd792a1amr23530940pll.109.1652815153759;
        Tue, 17 May 2022 12:19:13 -0700 (PDT)
Received: from google.com (201.59.83.34.bc.googleusercontent.com. [34.83.59.201])
        by smtp.gmail.com with ESMTPSA id c11-20020a170903234b00b0015e8d4eb21csm9804505plh.102.2022.05.17.12.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 12:19:13 -0700 (PDT)
Date:   Tue, 17 May 2022 19:19:09 +0000
From:   Carlos Llamas <cmllamas@google.com>
To:     Schspa Shi <schspa@gmail.com>
Cc:     gregkh@linuxfoundation.org, arve@android.com, tkjos@android.com,
        maco@android.com, joel@joelfernandes.org, brauner@kernel.org,
        hridya@google.com, surenb@google.com, linux-kernel@vger.kernel.org,
        syzbot+46fff6434a7f968ecb39@syzkaller.appspotmail.com
Subject: Re: [PATCH] binder: fix atomic sleep when get extended error
Message-ID: <YoP1LSSzgg9sHJDW@google.com>
References: <20220517175225.65283-1-schspa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517175225.65283-1-schspa@gmail.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 18, 2022 at 01:52:25AM +0800, Schspa Shi wrote:
> binder_inner_proc_lock(thread->proc) is a spin lock, copy_to_user can't
> be called with in this lock.
> 
> Copy it as a local variable, and check the id to make sure the user space
> gets the latest error message
> 
> Reported-by: syzbot+46fff6434a7f968ecb39@syzkaller.appspotmail.com
> Fixes: bd32889e841c ("binder: add BINDER_GET_EXTENDED_ERROR ioctl")
> Signed-off-by: Schspa Shi <schspa@gmail.com>
> ---
>  drivers/android/binder.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/android/binder.c b/drivers/android/binder.c
> index d9253b2a7bd9..5f2e1fa3da74 100644
> --- a/drivers/android/binder.c
> +++ b/drivers/android/binder.c
> @@ -5163,13 +5163,20 @@ static int binder_ioctl_get_extended_error(struct binder_thread *thread,
>  					   void __user *ubuf)
>  {
>  	struct binder_extended_error *ee = &thread->ee;
> +	struct binder_extended_error eeb;
>  
>  	binder_inner_proc_lock(thread->proc);
> -	if (copy_to_user(ubuf, ee, sizeof(*ee))) {
> -		binder_inner_proc_unlock(thread->proc);
> +retry:
> +	eeb = *ee;
> +	binder_inner_proc_unlock(thread->proc);
> +	if (copy_to_user(ubuf, &eeb, sizeof(eeb)))
>  		return -EFAULT;
> -	}
>  
> +	binder_inner_proc_lock(thread->proc);
> +	if (eeb.id != ee->id) {
> +		/* retry to get newest error info */
> +		goto retry;
> +	}
>  	ee->id = 0;
>  	ee->command = BR_OK;
>  	ee->param = 0;
> -- 
> 2.24.3 (Apple Git-128)
>

Oops! Thank you for your patch. In this case the local copy would be
enough, no need for the retry logic as this is already taken care of.
You could also leverage the binder_set_extended_error() to reset the
thread->ee. Would you mind sending these updates? I was thinking
something like this:

 drivers/android/binder.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 83facfa1a5c3..f92021cd384b 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -5163,19 +5163,16 @@ static int binder_ioctl_get_freezer_info(
 static int binder_ioctl_get_extended_error(struct binder_thread *thread,
 					   void __user *ubuf)
 {
-	struct binder_extended_error *ee = &thread->ee;
+	struct binder_extended_error ee;

 	binder_inner_proc_lock(thread->proc);
-	if (copy_to_user(ubuf, ee, sizeof(*ee))) {
-		binder_inner_proc_unlock(thread->proc);
-		return -EFAULT;
-	}
-
-	ee->id = 0;
-	ee->command = BR_OK;
-	ee->param = 0;
+	ee = thread->ee;
+	binder_set_extended_error(&thread->ee, 0, BR_OK, 0);
 	binder_inner_proc_unlock(thread->proc);

+	if (copy_to_user(ubuf, &ee, sizeof(ee)))
+		return -EFAULT;
+
 	return 0;
 }

--

Carlos Llamas
