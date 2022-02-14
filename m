Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 514884B591B
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:51:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349698AbiBNRvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:51:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236422AbiBNRvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:51:00 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 140E0652C4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 09:50:52 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id c10so4906752pfv.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 09:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2pv1fIRY6lIfIcMtOwkrwdy494KZMRJ7a2DukPjeE14=;
        b=UiwCmkCiOy96pxOiFxdc1mAdYF/UzjC+2/DHFAuRTjOz5w/5V55MOswI3fZnNbEnIK
         O6kGEtP+Q0gw1sm0DNytI1D2ibMuyPxBOCqdHgaSYKVWW3Hox012WkY36qsGZyDGG1wb
         JiOvG+9TogJuMtkcN/6zlNzxGJQZgRYaqZywDAhDnA1cmlqHXvKoYaDuLECP659+ZyaJ
         oK2ktqIELMXWPtVU0Pu/5xcyglxg02K1r3P6bEOw6sm7lW8hbFBUPluLAvXrHL2pcti0
         VJoeyMd0/ZB4X9/U0xjN48b3cG7jPNRUoJ06X/ZAZ/YOcjbk2m/ilVsWRCGhjTCnEyxa
         Nfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=2pv1fIRY6lIfIcMtOwkrwdy494KZMRJ7a2DukPjeE14=;
        b=IM6wFf53LswPF4u/Z0UhfeaVxu3GUBggxcvGzDz2ygYUZ5bBtNxxm1UL7ittj4gj08
         NYUcNZWKzb3F59Mmb9SLd1FMGAQGbm3rCX5skj4gEOM3JsgVphmc42zGI4REkdo+ZkDF
         Sdw8HclEvWwYYHUT7fBitWOF4r83cX/3LpuKKzsw+FA0GYqj2ZqwMpdMA0o8Z8cVD7fI
         5n6/9o7XJG32dci+yPmRbYlCdmMmH2DiAyzEbqJIAGyj3fa0gLfKmqNFWc5YFLlohn8M
         z4YjTS2o6+k6/meLqIkTR6H47eqSTRAQq7L11XcKi9LRrdaQtVjAQR0f7f/x2+gzGN1m
         7sHQ==
X-Gm-Message-State: AOAM531K9BVJVJcWnA0RI2T5F5KpIg9nwymMj4voqpBXUvq+IwPRpMl7
        78iyAPK5AK21xefs5XniH58=
X-Google-Smtp-Source: ABdhPJz1+ChEtDlXTcjUgJemqfoJ5aK6WOyieS+wmOjThDDoGAEo88pZG458GvaKxeZWEBFCJHiXYg==
X-Received: by 2002:a63:ff44:: with SMTP id s4mr95099pgk.559.1644861051456;
        Mon, 14 Feb 2022 09:50:51 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id v20sm14582150pju.9.2022.02.14.09.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 09:50:51 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Feb 2022 07:50:49 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/7] kernfs: Introduce hashed mutexes to replace
 global kernfs_open_file_mutex.
Message-ID: <YgqWeZrK6XAiICmo@slm.duckdns.org>
References: <20220214120322.2402628-1-imran.f.khan@oracle.com>
 <20220214120322.2402628-2-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214120322.2402628-2-imran.f.khan@oracle.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Mon, Feb 14, 2022 at 11:03:16PM +1100, Imran Khan wrote:
> +extern struct kernfs_global_locks *kernfs_locks;
> +
> +static inline struct mutex *kernfs_open_file_mutex_ptr(struct kernfs_node *kn)
> +{
> +	int idx = hash_ptr(kn, NR_KERNFS_LOCK_BITS);
> +
> +	return &kernfs_locks->open_file_mutex[idx].lock;
> +}
> +
> +static inline struct mutex *kernfs_open_file_mutex_lock(struct kernfs_node *kn)
> +{
> +	struct mutex *lock;
> +
> +	lock = kernfs_open_file_mutex_ptr(kn);
> +
> +	mutex_lock(lock);
> +
> +	return lock;
> +}

So, splitting patches this way doesn't really help. Because this patch
introduces code which isn't used and the second patch does all the
meaningful changes. It'd be better if the first patch introduces the
interface without changing the actual locking - ie. introduce and convert to
use kernfs_open_file_mutex*() but make it return the same old global mutex,
and then the second patch adds the hashed locks and updates
kernfs_open_file_mutex*() to actually return hashed locks. This way, the
meaningful changes are split into two patches which can be verified
independently.

Thanks.

-- 
tejun
