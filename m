Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D434643B3
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 00:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345475AbhLAAAI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 19:00:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:42607 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345451AbhLAAAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 19:00:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638316605;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+4Ly6xHNhtVUY3AH8Qlby8GSJHjPJLpcoba68bX+aow=;
        b=ITitGQyBGs3UnbFdtMFkhl6mWHPhqEnV2z0bIMyBPHVumLaujIFJMmkCr1uBLmskjOInKc
        XFx/+kUXu2xFvctFWVzLDUuYX/RkcQ2djKqYnhQzZyubXpE6p6PF+2iA5TJE19K8ZlPo9s
        +kIEy5GiXm7kGEUkDbZncXEV3i1I2YM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-yRYCwGETNw-KdwaVTPUhzg-1; Tue, 30 Nov 2021 18:56:43 -0500
X-MC-Unique: yRYCwGETNw-KdwaVTPUhzg-1
Received: by mail-wm1-f69.google.com with SMTP id 144-20020a1c0496000000b003305ac0e03aso14667546wme.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 15:56:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+4Ly6xHNhtVUY3AH8Qlby8GSJHjPJLpcoba68bX+aow=;
        b=LjFiMLw0WwQHH5Gljth49r+njkEA5NJs9qz2Zd7XjbShnXfTekGodbACCL4UUOE5l2
         /wsaiZNGXKC9/JUWxGjRz870ECRTwvcpiyuPzrP6zqaN5dgY0d+hFtO/S+oXVWIIZK0p
         Y0c+vBPofyCJ5/M8FT8ayqbtI7g4UzysaEDrgs2XxtbBaDLkkaADbkDLXsp4mU1Biaa0
         poDfnaFisoVt6ppV3KSz/xpyX9JlO1PTUFfBu1zOWO89t3iOr6U5XEyOehKeqv17b2VB
         JShW61wrXL+Ary7Ytus1AJuJ6UNQ8/Rf8B9Y+/f2e047PelVHrLtPbk0jBj8EnVEzv8z
         VpGw==
X-Gm-Message-State: AOAM532OmomViGm3c/06uddl1V9d2x2B6j04op90EWOQqxP5t/ocLgQD
        mMa6uFzmVzs+uFKiAfE8mtdzvIxLFX2Yd3iYfa36LD7aNotMxqR2YrBknPYY+ClCnPz5rBO9Wue
        wJb6zA8f4s9Xno9lCoBO4ryni
X-Received: by 2002:a7b:c341:: with SMTP id l1mr2507448wmj.60.1638316602446;
        Tue, 30 Nov 2021 15:56:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQ8RabJd/yKEXGAgH6YMRKO+2L/7mA0kjS4lJhWYXjOug4extDYcFzwzfNJvdxbSacBrlLnQ==
X-Received: by 2002:a7b:c341:: with SMTP id l1mr2507417wmj.60.1638316602217;
        Tue, 30 Nov 2021 15:56:42 -0800 (PST)
Received: from redhat.com ([2.53.15.215])
        by smtp.gmail.com with ESMTPSA id g18sm17573721wrv.42.2021.11.30.15.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 15:56:41 -0800 (PST)
Date:   Tue, 30 Nov 2021 18:56:38 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        Zi Yan <ziy@nvidia.com>, Gavin Shan <gshan@redhat.com>,
        Hui Zhu <teawater@gmail.com>, Eric Ren <renzhengeek@gmail.com>,
        Sebastien Boeuf <sebastien.boeuf@intel.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org
Subject: Re: [PATCH v1 0/2] virtio-mem: prepare for granularity smaller than
 MAX_ORDER - 1
Message-ID: <20211130185612-mutt-send-email-mst@kernel.org>
References: <20211126134209.17332-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126134209.17332-1-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 26, 2021 at 02:42:07PM +0100, David Hildenbrand wrote:
> The virtio-mem driver currently supports logical hot(un)plug in
> MAX_ORDER - 1 granularity (4MiB on x86-64) or bigger. We want to support
> pageblock granularity (2MiB on x86-64), to make hot(un)plug even more
> flexible, and to improve hotunplug when using ZONE_NORMAL.
> 
> With pageblock granularity, we then have a granularity comparable to
> hugepage ballooning. Further, there are ideas to increase MAX_ORDER, so
> we really want to decouple it from MAX_ORDER.
> 
> While ZONE_MOVABLE should mostly work already, alloc_contig_range() still
> needs work to be able to properly handle pageblock granularity on
> ZONE_NORMAL. This support is in the works [1], so let's prepare
> virtio-mem for supporting smaller granularity than MAX_ORDER - 1.

is there value to merging this seprately? or should this just
be part of that patchset?

> Tested with ZONE_MOVABLE after removing the MAX_ORDER - 1 granularity
> limitation in virtio-mem, and using different device block sizes (2MiB,
> 4MiB, 8MiB).
> 
> [1] https://lkml.kernel.org/r/20211115193725.737539-1-zi.yan@sent.com
> 
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Zi Yan <ziy@nvidia.com>
> Cc: Gavin Shan <gshan@redhat.com>
> Cc: Hui Zhu <teawater@gmail.com>
> Cc: Eric Ren <renzhengeek@gmail.com>
> Cc: Sebastien Boeuf <sebastien.boeuf@intel.com>
> Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
> Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
> Cc: virtualization@lists.linux-foundation.org
> Cc: linux-mm@kvack.org
> 
> David Hildenbrand (2):
>   virtio-mem: prepare page onlining code for granularity smaller than
>     MAX_ORDER - 1
>   virtio-mem: prepare fake page onlining code for granularity smaller
>     than MAX_ORDER - 1
> 
>  drivers/virtio/virtio_mem.c | 110 ++++++++++++++++++++++++------------
>  1 file changed, 74 insertions(+), 36 deletions(-)
> 
> -- 
> 2.31.1

