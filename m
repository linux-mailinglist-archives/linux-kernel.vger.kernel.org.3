Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A710E46CD2C
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 06:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233772AbhLHFbX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 00:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233796AbhLHFbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 00:31:20 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29687C061756
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 21:27:49 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id x131so1442688pfc.12
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 21:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C/xmja+VaCYMUqWD89Oy8QuQw1Lbx2l43n/WXHJebHo=;
        b=Q1tD6MF8e5eHgSICypuGaj6cfSO+lpaPpW5St/IlJvGMavr6KY2fwtmLEzYkoTEioa
         QyiezwsN1S7hF202483eKn4nRgPzA3/fqPJ541nO4lMaQB3JdqBBt0n/YqXztGvWH+oj
         I8ofsDuKTK6ersjkjTqXfwRXS19ngTOsjanRQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C/xmja+VaCYMUqWD89Oy8QuQw1Lbx2l43n/WXHJebHo=;
        b=XEmnnWKk1kMwQqn32YgHKjNDvvYFL7FLtv1NwtbgylRWmKl13Z8CQRBD9Mz89f+57G
         eOue68dU/bFd/YK6L9P4aH5kAqk7ub3IsfJmj8PG/QH8U0aHkBh/gSemaq23Wex2VsZz
         RlC1MC+4axRtQCry9pIP8YOb7YtUCPmrgTDSmEQApXxn+graepRyylwOSq92d0/s4d3N
         ChSl63l4j++fPrZcqs4J6NrUuxrwPydvE7ckwAhSKKk9MA9lRDBcmPvNjqkR2uOXde+m
         uJXd4dgpKwJ1Cn9QBdpQd/MR31bf7CtpdW99Y9pm30TndDJvfvlNDDgJKU29MdhALuVt
         z+Lg==
X-Gm-Message-State: AOAM530qZAQE50bUsm4ZkUWBUHYmAqCV2Ao38FWCy3IVO1gRYvOGmQ24
        6cUtqf3vvrG7j0ebFnQsc6tlLQ==
X-Google-Smtp-Source: ABdhPJw0ifG721tDSMl4Pa0kahZYl0+d2BQ/RC+y7ZsrF0w2eviIDphPswt+oUpH4a16rlCwphSkoA==
X-Received: by 2002:a05:6a00:17a4:b0:49f:c0c0:3263 with SMTP id s36-20020a056a0017a400b0049fc0c03263mr3717005pfg.81.1638941268574;
        Tue, 07 Dec 2021 21:27:48 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t12sm4477039pjo.44.2021.12.07.21.27.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 21:27:48 -0800 (PST)
Date:   Tue, 7 Dec 2021 21:27:47 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     akpm@linux-foundation.org, laniel_francis@privacyrequired.com,
        andriy.shevchenko@linux.intel.com, adobriyan@gmail.com,
        linux@roeck-us.net, andreyknvl@gmail.com, dja@axtens.net,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: Re: [PATCH -next 0/2] Introduce memset_range() helper for wiping
 members
Message-ID: <202112072125.AC79323201@keescook>
References: <20211208030451.219751-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208030451.219751-1-xiujianfeng@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 11:04:49AM +0800, Xiu Jianfeng wrote:
> Xiu Jianfeng (2):
>   string.h: Introduce memset_range() for wiping members

For doing a memset range, the preferred method is to use
a struct_group in the structure itself. This makes the range
self-documenting, and allows the compile to validate the exact size,
makes it addressable, etc. The other memset helpers are for "everything
to the end", which doesn't usually benefit from the struct_group style
of range declaration.

>   bpf: use memset_range helper in __mark_reg_known

I never saw this patch arrive on the list?

-- 
Kees Cook
