Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927F9498817
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:17:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245098AbiAXSRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235979AbiAXSRQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:17:16 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB925C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:17:16 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u11so16449637plh.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 10:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=08wQ/FjWhd9KqUOc/eygK6tPJPPOkuZJXthR/BJ1yOQ=;
        b=Yk1yEoQ8dSUuH70Owq9SrFlZ8iEBBJ2JlN/Agb3VcDyAS+Hw0PLCUcGTQpbYUlVRhd
         NDKuZ1ulFRT9MptnA02ChWFhtT3rDQeKp9ERrEkZA3dqUKvfJSFoncnYERrpOnuTgf1+
         CmTQyGTU7sKiyA6We0JdSy9IsOlfSvw24gZc4/voFoOToWu8UlkXa5nAgAMRBkjm0nZt
         bM9uFooFDB43qdI8zab1kZd+yowvFtUOdXgai0A3iv6f/SansSGZiT3+PSutCLaR1Ivw
         Uian5SN/N/hKzlE79Imv3L9dK64i023UabCW0eSZQjZj9PfocX/l4B8yL47XW04ond61
         oRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=08wQ/FjWhd9KqUOc/eygK6tPJPPOkuZJXthR/BJ1yOQ=;
        b=5dtTX8dmYVCvzfZ/bE75onuWltiAjzY+uYu3Nb+5jS143tnuXz4d9QM8HV1eQSi09o
         CNjFbrHMZpnsBD/IrpoVb6ibDAK5qTJrfmnWB4/EAWukgN8vgRAtbHfNge7OScze+6nQ
         vKz9U5WvFcggGNVZyl4iUjBeZsvh8R95ZkPuEnPRW0+gKSIw/1HAAiLS6H9RCX2q/nsl
         vQx6Yg41ybh37+BisNS6MTfisv1XzMJzB2+GP8gYi6PMfXKFL8DIEM0m6fqKZSSazi9o
         UQBxijODGQ9Nb6ntnuqnxqQ8uyiajYtpjEuuhsNDSgzGMXga/NVvRE19k3zIurlDvzZW
         wVVQ==
X-Gm-Message-State: AOAM530FeVeBOxnDqBOul6vplGeAnDypsQ3zBP2qElYipcsQUaVUGczI
        bObI1wLriioM9ihEAxzyzqCoPF/QMgozhw==
X-Google-Smtp-Source: ABdhPJysob7/6AunTAmMMu9QWaHblyvtcySsEX5H+3uOnvKftwpkJWbsnDersNxYbqJTvSoUnQ5vmA==
X-Received: by 2002:a17:902:7c09:b0:148:e02f:176b with SMTP id x9-20020a1709027c0900b00148e02f176bmr15367461pll.130.1643048235855;
        Mon, 24 Jan 2022 10:17:15 -0800 (PST)
Received: from [2620:15c:29:204:1f99:bd65:fcbb:146c] ([2620:15c:29:204:1f99:bd65:fcbb:146c])
        by smtp.gmail.com with ESMTPSA id ce15sm55886pjb.5.2022.01.24.10.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 10:17:15 -0800 (PST)
Date:   Mon, 24 Jan 2022 10:17:14 -0800 (PST)
From:   David Rientjes <rientjes@google.com>
To:     Ard Biesheuvel <ardb@kernel.org>
cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: make 'highmem' symbol ro_after_init
In-Reply-To: <20220124170555.1054480-1-ardb@kernel.org>
Message-ID: <346af9f-d9ea-463a-686e-1cce79a1c8d2@google.com>
References: <20220124170555.1054480-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2022, Ard Biesheuvel wrote:

> diff --git a/mm/memory.c b/mm/memory.c
> index c125c4969913..50e82cb94ccc 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -106,7 +106,7 @@ EXPORT_SYMBOL(mem_map);
>   * highstart_pfn must be the same; there must be no gap between ZONE_NORMAL
>   * and ZONE_HIGHMEM.
>   */
> -void *high_memory;
> +void *high_memory __ro_after_init;
>  EXPORT_SYMBOL(high_memory);
>  
>  /*

Same should be true for the mm/nommu.c variant?
