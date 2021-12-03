Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C97467793
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 13:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380887AbhLCMov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 07:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352027AbhLCMou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 07:44:50 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E71C06173E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 04:41:25 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id i5so5500385wrb.2
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 04:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2DlaYyrMnNAfarN4p4bn7fLOENYHGsS+8GIcDJI44kI=;
        b=EGQ3aws5Y4/XGWAH1A6EHl4jGKcodEVMaTu6soy7BD9gxMZgtueQRjNgyQltM7OkYu
         82ffPIdz00JJ0MN2jQxpmbLVd2134QX2ghdaOLHgE37EfAQttbnZ95sybWO8DAoZTPGy
         kLkF4dyf9bGIIpn/N6jAvpFyLfMXjRnF0MsVhVHNW87w/tiSpI5iEg18F68Z8K+zi66y
         UdevS/ahqkO0WBH4R1+4JrhtbdgjTwiLW/ZeCsK83hlq24BIhOoY5TzdmnxqePwOieJ3
         rd8BuoOAy+Eb+NycsuNWEHEZgqcSKXxGJiw6GuyTt5ax6o8/MUflJko+mGEGNvYHpAe0
         vuEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2DlaYyrMnNAfarN4p4bn7fLOENYHGsS+8GIcDJI44kI=;
        b=rqNei+4F1u87sNOUEitgpiPgKvYaRN46sLENX7L8Ag0eV8wo9jvI9iveB632v9keua
         I6QpvSzRbQvQrjQMIYQAECtCtvvU87lk2hFd/yXlhJqLq+K5gqoj37cnJSl7nB3J/B6j
         TsJIN9d7mpeAK7XUKrSr4qxWlbM9wS3Df6Q8MqwydaS3CtkI3w1sl+10BqQpDPPDIISh
         P/UhN7atg5xv/V965GZ99x9nhHG0oWuryB1bFnraumU1D/ltR4aOVujb1LvaxTjlA7q4
         DOE3OC5KPtpRHtBIdQehAYnxT3slO5BJlEJ8CYtdWXxRgiMbilMBQm0DzUYNA1mgK7s1
         cZOQ==
X-Gm-Message-State: AOAM5326IhVmFa/T+x0jZk0YfLfrmV8VlBamdfVvWXd9UWgn7RQ2GvaX
        4anhlU6Hgd9MfNqrxODLGuo7cw==
X-Google-Smtp-Source: ABdhPJy/MiBgF2zqfmjd+3J4u1vP4T6FanHvj7EcLrUpNxZ+mISsd53PcHVj/Julw+2v3rUBi0jE+g==
X-Received: by 2002:a5d:4889:: with SMTP id g9mr21784593wrq.455.1638535284334;
        Fri, 03 Dec 2021 04:41:24 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:cb5f:d3e:205e:c7c4])
        by smtp.gmail.com with ESMTPSA id z6sm2427482wrm.93.2021.12.03.04.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 04:41:23 -0800 (PST)
Date:   Fri, 3 Dec 2021 13:41:18 +0100
From:   Marco Elver <elver@google.com>
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH 27/31] kasan, vmalloc: add vmalloc support to HW_TAGS
Message-ID: <YaoQbt/7FoEnBx4K@elver.google.com>
References: <cover.1638308023.git.andreyknvl@google.com>
 <aa90926d11b5977402af4ce6dccea89932006d36.1638308023.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aa90926d11b5977402af4ce6dccea89932006d36.1638308023.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 11:08PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> This patch adds vmalloc tagging support to HW_TAGS KASAN.
> 
> The key difference between HW_TAGS and the other two KASAN modes
> when it comes to vmalloc: HW_TAGS KASAN can only assign tags to
> physical memory. The other two modes have shadow memory covering
> every mapped virtual memory region.
> 
> This patch makes __kasan_unpoison_vmalloc() for HW_TAGS KASAN:
> 
> - Skip non-VM_ALLOC mappings as HW_TAGS KASAN can only tag a single
>   mapping of normal physical memory; see the comment in the function.
> - Generate a random tag, tag the returned pointer and the allocation.
> - Propagate the tag into the page stucts to allow accesses through
>   page_address(vmalloc_to_page()).
> 
> The rest of vmalloc-related KASAN hooks are not needed:
> 
> - The shadow-related ones are fully skipped.
> - __kasan_poison_vmalloc() is kept as a no-op with a comment.
> 
> Poisoning of physical pages that are backing vmalloc() allocations
> is skipped via __GFP_SKIP_KASAN_UNPOISON: __kasan_unpoison_vmalloc()
> poisons them instead.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Co-developed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

This is missing a Signed-off-by from Vincenzo.
