Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A02D550BD4D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:41:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449788AbiDVQoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380470AbiDVQom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:44:42 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B275F247
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:41:48 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id bg9so7736055pgb.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OT4DYjNot2cW1epTGtznv45g/IwmF1Mk4TN/EWSjHBs=;
        b=bwTnqAlMIqhefmWyq0HYbiHQcz1ImrL5yrJv/18scG4WW37vi237ZeU1MgbWE5vDCk
         ClQzlMPaBPBu0bkHXkGkqqYBkzir2P4R122jNwQpGyi6r5M2cpByFFalTJ4l9kjAqDwr
         b2VU5C//bBqFWaY5yM9KJl+hwFIqE1f3lbam2Rngzr3LPx8Y2uxM1K50SN0CCc0MbEqv
         bzi9oIfWBUvgD9be7eeCCfosbJn2cMtd4/RikiO/23MpnhLffer07nwjfCwcUBNyRzYJ
         QmBNMweoivyrO8Cb/qJDQBBVLmCBWWa3G5TIgcrdx5LKe+IWeUzm1v2j7OOqAgxTBs4F
         f8YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=OT4DYjNot2cW1epTGtznv45g/IwmF1Mk4TN/EWSjHBs=;
        b=Ylgi2cGeR7Nw+hMKCYNK7t+NuGhZ4/rsUMMGus6+9+gCggS3zmLLVvIdHo18W2TPOg
         unGhgeRY/cTJuVIDCk4FtnZs5DzoEcyigQeThTVZ1RXEqLGI3oPU4/OPf8zsgNnJmAIA
         8PqN4B0pTszIJgs6fjOTc6vIVeSIACnSDosUu6Fg98pu8CGK2P5WX/yvMJb8iutE0h8i
         kZf9nduQXU947qUVbzEq2FK+S3iYoTxgYNWT6NDeSmD4v3WZsYcz/rxLps4WBEz95J9k
         S9DaZQV+n65PP+rO6rz5nXsQuGviWUZ8HFnrscTaZPEHbIwuqo78tyzu6tliPu6WSjdL
         h9lw==
X-Gm-Message-State: AOAM532E12xPAH4zwI87rOri61otnlB2FzL3/lOMJPO4oOwlPpFHnfTO
        flzPBQoxu8cbBNlIRB095ck=
X-Google-Smtp-Source: ABdhPJzEQTUulV61gXq0MxkzNZzN13/wJJIoJeVMukHaO/lNLhP+x8xVv6Ekh7zerXIbArp9ZzOjjQ==
X-Received: by 2002:a65:6b92:0:b0:39c:c97b:1b57 with SMTP id d18-20020a656b92000000b0039cc97b1b57mr4759688pgw.517.1650645708196;
        Fri, 22 Apr 2022 09:41:48 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:b5ae])
        by smtp.gmail.com with ESMTPSA id m23-20020a17090a859700b001cd4989ff47sm6534182pjn.14.2022.04.22.09.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 09:41:47 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 22 Apr 2022 06:41:45 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     viro@zeniv.linux.org.uk, gregkh@linuxfoundation.org,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 03/10] kernfs: Change kernfs_notify_list to llist.
Message-ID: <YmLaySAIldwNwreD@slm.duckdns.org>
References: <20220410023719.1752460-1-imran.f.khan@oracle.com>
 <20220410023719.1752460-4-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220410023719.1752460-4-imran.f.khan@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Apr 10, 2022 at 12:37:12PM +1000, Imran Khan wrote:
> @@ -846,18 +845,25 @@ static void kernfs_notify_workfn(struct work_struct *work)
>  	struct kernfs_node *kn;
>  	struct kernfs_super_info *info;
>  	struct kernfs_root *root;
> +	struct llist_node *free;
> +	struct kernfs_elem_attr *attr;
>  repeat:
> -	/* pop one off the notify_list */
> +	/**
> +	 * pop one off the notify_list.
> +	 * There can be multiple concurrent work items.
> +	 * Use kernfs_notify_lock to synchronize between multipl consumers.
> +	 */

This is running off of a single work item, so there can only be one instance
of this running at any given time.

>  	spin_lock_irq(&kernfs_notify_lock);
> -	kn = kernfs_notify_list;
> -	if (kn == KERNFS_NOTIFY_EOL) {
> +	if (llist_empty(&kernfs_notify_list)) {
>  		spin_unlock_irq(&kernfs_notify_lock);
>  		return;
>  	}
> -	kernfs_notify_list = kn->attr.notify_next;
> -	kn->attr.notify_next = NULL;
> +
> +	free = llist_del_first(&kernfs_notify_list);

Why not just test whether the returned pointer is NULL here instead of doing
a separate empty check above?

Thanks.

-- 
tejun
