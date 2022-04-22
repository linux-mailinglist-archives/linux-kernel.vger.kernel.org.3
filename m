Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC4650BC8C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356127AbiDVQGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357065AbiDVQGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:06:14 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75E475E149
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:03:20 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id j8so11778036pll.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UGK3iOLOSq8b+uW93AKentNVyqK1drmrSS6mX3tmCK4=;
        b=jREOmp2tBNoX9/1JSC70rEEUVIFeaV48CD7qYFaDgDafU4SAaf9LhxP1k+Rn6vpleM
         cskZCEoTYLEONhvD7sDXgIeb2ay/1zuHkkkpPeZNSbjJTGucqwNKlNwqA3EhplbzG7G4
         ZRoCWXpI8nSjzPsLjVHRNaL+ul/CBEs/833AqNI7BftoMXQzaXCNU4ereRAdqn5K6AEO
         CvAsxDdmuZRoKIGuKOonyNOEGdtlIoLyBKZgaXs6SPBR9VyJuo+AOSSuKZi47KF9WFdf
         7t6riDyt8vTj76MOUivasvnNMNXEqA2dE0lteUO1dl08saMJWervfiaLvH+0A6JLnbHP
         UiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=UGK3iOLOSq8b+uW93AKentNVyqK1drmrSS6mX3tmCK4=;
        b=cNxj8Mqfq7xRwOmFLdnjuMK4jUpg0ppzDCeCKGjdg1hJidNFEjcw9wR1V4V6uBvX30
         w3VgmWeQpaz1zjqMuemkjyxQp9EQT7bdrW/P5zLFvz24mNBgWdzC0uMpILZpS+VE+NWv
         wfsViJkyZUaZnmLD/C0T1qeNtcmdLNC2Zqaag1yRm+Iftg0phEhdqdrh3KDIWD33Q9G8
         PRzDvwXNvsHzT9gc9IJgMXcvgrrRaDABD/4EMok1Ywi/x6vGyLRPEJ3j+jbDvmgGE6nD
         Rr4I49z5ee+vPZXZYtju3NiqrO8UQ9mXk9LA+lHYCYe/Jm5+DcvMVNCDMrHZebpTW9Vq
         iV7Q==
X-Gm-Message-State: AOAM531IV5zMtv8Ao626kIYEbPUZzKJMIBsYGfOvIw8aK+mfzUAe+QVt
        5DuPHjC1SRwW1wrLLz8PBsg=
X-Google-Smtp-Source: ABdhPJx5XKcoaoRaemeTrLmz3cPHtWUeo+5F4Miz7i1lYIRFTpqzShSr3m+CgLrJ9DV3A/AMZs5J+g==
X-Received: by 2002:a17:902:c9d2:b0:15b:e021:8bcc with SMTP id q18-20020a170902c9d200b0015be0218bccmr4149894pld.40.1650643399714;
        Fri, 22 Apr 2022 09:03:19 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:b5ae])
        by smtp.gmail.com with ESMTPSA id g17-20020a625211000000b005056a6313a7sm2927881pfb.87.2022.04.22.09.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 09:03:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 22 Apr 2022 06:03:17 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 01/10] kernfs: Remove reference counting for
 kernfs_open_node.
Message-ID: <YmLRxWUnF/zflEO2@slm.duckdns.org>
References: <20220410023719.1752460-1-imran.f.khan@oracle.com>
 <20220410023719.1752460-2-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220410023719.1752460-2-imran.f.khan@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 10, 2022 at 12:37:10PM +1000, Imran Khan wrote:
> @@ -768,15 +765,15 @@ void kernfs_drain_open_files(struct kernfs_node *kn)
>  	if (!(kn->flags & (KERNFS_HAS_MMAP | KERNFS_HAS_RELEASE)))
>  		return;
>  
> -	spin_lock_irq(&kernfs_open_node_lock);
>  	on = kn->attr.open;
> -	if (on)
> -		atomic_inc(&on->refcnt);
> -	spin_unlock_irq(&kernfs_open_node_lock);
>  	if (!on)
>  		return;
>
>  	mutex_lock(&kernfs_open_file_mutex);
> +	if (!kn->attr.open) {
> +		mutex_unlock(&kernfs_open_file_mutex);
> +		return;
> +	}

What if @on got freed and new one got allocated between the lockless check
and the locked check? Is there a reason to keep the lockless check at all?

>  	list_for_each_entry(of, &on->files, list) {
>  		struct inode *inode = file_inode(of->file);

Thanks.

-- 
tejun
