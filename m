Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F03C48DBF1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:37:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiAMQhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiAMQht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:37:49 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B23C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 08:37:49 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id c3so10644479pls.5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 08:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bVTXmmIE7IBPyxQrXnC0p71oDoaSop9Sc+enhFol2Bo=;
        b=dhTbt7MQvjKFdG3Q5P8q2KbFg1viclCrADmfZsOk0AMqMAnNr1pS6PUERVLcmCKcJ1
         yLpTg0aYXMSBHA5M9Cjv8Ln+skHkL2cmHUkzz1uJ+fAe+zXlMl57Edx6aa4LzIB+M4UA
         kowDr28sYWr8qUfZSTYMlU5vx9zcCVdczRr0i3jbaWTI/zJoD6/fzLsdlHE9CeBR9Dnf
         dEIAddezopg7BoCnGtijJ8m98k5k5nA/IpB3M575xp8PXlnC+yXTwYWfMy8I/7Ke3/KG
         cObfFdiCJC+NPpExOQJ5m+eqM+jTLzdKwlVS8Y9vBmGpGV/Hh/k4m8Sa0Z2TEtIBzh2w
         sZWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=bVTXmmIE7IBPyxQrXnC0p71oDoaSop9Sc+enhFol2Bo=;
        b=nM4vak+Ytp8ikq6VmWvKOen+z8yxQ5gLVmRE7L244fjd2RYevk/8ZHjZkRAXa28TBM
         QoY0FKlWfqbpes+ipatXPRbAxc2+8rxhhl2x5/PerYnhgKh+bnR0W0UL7BuKw8WP3mJn
         x0rUamNzIF0SmOEGsiq2neZt7MpEuuwBviDqybSb212TXBn7VExdNmSQlX1xsukZEMoy
         NoEjvHkxNpCLpjNX+ab18j2PDBxv8VVv4CXxzJwDnHzJw4UxKHXR5ONw41ff3DjKuXp5
         TAzCYLhzDuCj8Xu6hFRFYDyhw9JnIVhETq3sUATuaYsBQP+tXIEijnPboYwwx7F2bds/
         9CuA==
X-Gm-Message-State: AOAM5308QvwaSTw0VU6fop9sB1kkXyXfAMhFhVDa/IYu4dd+P4/qeYSC
        cOKv0EVPAdbIaYs1kmSN12o=
X-Google-Smtp-Source: ABdhPJz9p9KTTDNveDHP3SkVWKwd6ykXbiRr9Wu1NJs087UjkElIzqft81Kwft88Cb1HYeKfwSeycw==
X-Received: by 2002:a17:902:bb0f:b0:149:d7c2:3e7f with SMTP id im15-20020a170902bb0f00b00149d7c23e7fmr5314532plb.109.1642091868514;
        Thu, 13 Jan 2022 08:37:48 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id q9sm2696208pgv.71.2022.01.13.08.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 08:37:48 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 13 Jan 2022 06:37:46 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] kernfs: use hashed mutex and spinlock in place of
 global ones.
Message-ID: <YeBVWmUaSXc/5NQf@slm.duckdns.org>
References: <20220113104259.1584491-1-imran.f.khan@oracle.com>
 <20220113104259.1584491-2-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113104259.1584491-2-imran.f.khan@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jan 13, 2022 at 09:42:58PM +1100, Imran Khan wrote:
> +#ifdef CONFIG_SMP
> +#define NR_KERNFS_LOCK_BITS (2 * (ilog2(NR_CPUS < 32 ? NR_CPUS : 32)))

How did the 32 limit come to be? It'd be nice to have a comment explaining
that this is something which affects scalability and brief rationale on the
current number.

> +static inline spinlock_t *open_node_lock_ptr(struct kernfs_node *kn)
> +{
> +	int index = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
> +
> +	return &kernfs_global_locks.open_node_locks[index].lock;
> +}
> +
> +static inline struct mutex *open_file_mutex_ptr(struct kernfs_node *kn)
> +{
> +	int index = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
> +
> +	return &kernfs_global_locks.open_file_mutex[index].lock;
> +}

I wonder whether it'd be useful to provide some helpers so that users don't
have to get the pointer for the lock and then lock it in separate steps.
Would it make sense to provide something which locks and returns the pointer
(or token)?

Thanks.

-- 
tejun
