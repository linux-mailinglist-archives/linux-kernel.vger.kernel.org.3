Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04A36467798
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 13:42:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380900AbhLCMpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 07:45:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380896AbhLCMpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 07:45:42 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD78CC06173E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 04:42:18 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so2110016wms.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 04:42:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=K6qjVToyPcEHlycO2HNFxJnoTYZ6aOQ5rp3ZUXudbCA=;
        b=rL72f8vzH8f7cYwRsqF4gj4Qxu8c2GlTrqrumu2a2F7PUM33o50UExXGXs8k4npXl1
         qmIpXs9apzavATZ40TwvBFZN3xhBlcNN3ixv+KjMohiXbl8N55nrrb13O4KiFgOMgYuy
         qyJbJk3Osg0oxy7RjoylqnGqUXe9xDcQd2BCvAMZgMBG9CeRds6I6IfCloQT57j+KzbQ
         ehFzVV0HZoJzLHquoUPHyhX8F7TeSHdkkEt6sxdwgPzT00Zte259RQ3Uu3QbC85mqaoi
         56Ru2X6P/lzkyDdXfPaXlBqlKdP07JpxYvSiT9RMBjYxLHwrE1pQPjNJ9vn5hv9W8v0H
         n6TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=K6qjVToyPcEHlycO2HNFxJnoTYZ6aOQ5rp3ZUXudbCA=;
        b=0HpPN5BXrawomwihtUBiAdtj67bqzRMf897fc/4V2ZIyGX+XFDyO3SLqKg8yqTwp4w
         F5FktrPcKYZqaYBTQDywJzZT8ukiQD6kqqX5l3hKhn/pf+srEp9J1UDZIqqrFE5J2fap
         RU6DpleoYK0pGTAG6vSCfqXvVLZ1TBEAgAoAv1xTDiwdILrQymBTMqA4G244dUtCAm2n
         raBe+Ynj8GAR/dCCwkUSsrzXjGQxElJY1QeYkv2LfiBsUaOvxcoGNXFglhLHZygqu7V6
         HPvFZf7uFqovrCssoA+gEmjX9SfxPOmC2wGzF4RU/3oul0k2R12A06571bb83Dxkw/jC
         cI8g==
X-Gm-Message-State: AOAM530UXfKH45eaiNhis667uYeJh5e50bDg5sU6usRUuwWGO/SOVeyR
        R3/hmgP4NmdBOfY+nLIhe2UhgA==
X-Google-Smtp-Source: ABdhPJyO7X8Vj9qWcvyIA1fCz7OcGIZG+FVgEN8mEee9QZg2PITmHDGzsm4Y9LQhPk9kGHgybp1UrA==
X-Received: by 2002:a05:600c:299:: with SMTP id 25mr14594606wmk.77.1638535337117;
        Fri, 03 Dec 2021 04:42:17 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:cb5f:d3e:205e:c7c4])
        by smtp.gmail.com with ESMTPSA id a22sm2474329wme.19.2021.12.03.04.42.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 04:42:16 -0800 (PST)
Date:   Fri, 3 Dec 2021 13:42:10 +0100
From:   Marco Elver <elver@google.com>
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH 24/31] kasan, vmalloc, arm64: mark vmalloc mappings as
 pgprot_tagged
Message-ID: <YaoQos9Fevz32h6+@elver.google.com>
References: <cover.1638308023.git.andreyknvl@google.com>
 <8557e32739e38d3cdf409789c2b3e1b405c743f4.1638308023.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8557e32739e38d3cdf409789c2b3e1b405c743f4.1638308023.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 11:07PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> HW_TAGS KASAN relies on ARM Memory Tagging Extension (MTE). With MTE,
> a memory region must be mapped as MT_NORMAL_TAGGED to allow setting
> memory tags via MTE-specific instructions.
> 
> This change adds proper protection bits to vmalloc() allocations.
> These allocations are always backed by page_alloc pages, so the tags
> will actually be getting set on the corresponding physical memory.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Co-developed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

This is also missing Signed-off-by from Vincenzo.
