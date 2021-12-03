Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F8446724F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 07:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378736AbhLCHDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 02:03:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47838 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345605AbhLCHDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 02:03:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638514781;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KE0+9VTqUtutX9N/PKRYwD8dprp7IA/RPBuLlGpqS5s=;
        b=S/gTRCAtr52b94lKtWZ9hAlnN+NV/F+PlJ29Q8aMXsshH97IwrS9aSuodag3NRi9cB0uqp
        bi1prjeXp5ygmuaOfus4SH4zR4roOgl0oVIGGsK/+ixVbPnZfKs9kigd0BwwE/UtKTd0Zp
        2L2W42FCJIqXK0e5LTVDfS9H8X3GzGw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-408-xsPI_-_ANTWtj0v1JQwH0w-1; Fri, 03 Dec 2021 01:59:38 -0500
X-MC-Unique: xsPI_-_ANTWtj0v1JQwH0w-1
Received: by mail-wm1-f69.google.com with SMTP id ay34-20020a05600c1e2200b00337fd217772so942072wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 22:59:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KE0+9VTqUtutX9N/PKRYwD8dprp7IA/RPBuLlGpqS5s=;
        b=Ll47nOCXwChMro4ayvjksrAU5YVxnA28gLCUu8LimJaAKItvsIKz7ieeeGUT6Kz9Zn
         ujU5nBWY3FeEfwkXoIMkHrqZ3jMSPqS3AT+gyhfHECbbP9XjX58YTJgNz28dArKeYZOe
         xEHSMPWe7LI5YBd8iDk8IC0wPxJ/4Vyu0yF8S35uCqjj+qN6hM0wFFdgFueESnn7xw+9
         aaIyDp+fZxD5c2lGJgAqTqq6QP1OW0qbQuaUPrmsh3uzJmzyYCilgsXFIc474OTnapHM
         KkUT9WZ4aCWlcLcwHoJ1cqWhGHYkBUwSh+RmJZP7xbaBk4tFo1pj0TuJNsqZgLUj3z3f
         tmfw==
X-Gm-Message-State: AOAM5306KpiUkb/YE6Eij+h9eOm/LSmT7bujAnQAKjDQRZHMi8lE6S0q
        1gi8T4UBxnyGy7iakNBNUaAp1IW2qKA1LSOQRbo/VKOgow1FJGuFsziymmvbrYC9rHJZIFKEpsY
        nKL9PGtM+SRbDX8B5OlA2RWJg
X-Received: by 2002:a1c:1903:: with SMTP id 3mr12641390wmz.89.1638514777012;
        Thu, 02 Dec 2021 22:59:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzDvEuQtuInBoFLdJ/X94tFtHj0cyBmHwQq+fzE9Q5jUVeCVwUUXYjORfnYYPAJ1RcNp9uiaA==
X-Received: by 2002:a1c:1903:: with SMTP id 3mr12641369wmz.89.1638514776774;
        Thu, 02 Dec 2021 22:59:36 -0800 (PST)
Received: from xz-m1.local ([64.64.123.26])
        by smtp.gmail.com with ESMTPSA id u15sm1526782wmq.13.2021.12.02.22.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 22:59:36 -0800 (PST)
Date:   Fri, 3 Dec 2021 14:59:30 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH RFC v2 1/2] mm: Don't skip swap entry even if zap_details
 specified
Message-ID: <YanAUpa6HoVOwxU6@xz-m1.local>
References: <20211115134951.85286-1-peterx@redhat.com>
 <5393877.lttFOZEo4r@nvdebian>
 <YamNRcrLDOPjG9wg@xz-m1.local>
 <11226930.BYJfa7kJGD@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11226930.BYJfa7kJGD@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 04:33:43PM +1100, Alistair Popple wrote:
> Thanks. That was the detail I was trying to figure out. Ie. why might something
> want to skip swap entries. I will spend some more time looking to be sure
> though.

Sure, please take your time, and thanks again for working together on this.

-- 
Peter Xu

