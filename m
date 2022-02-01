Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D673D4A5C4D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 13:31:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238098AbiBAMbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 07:31:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237764AbiBAMbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 07:31:36 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10853C06173B
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 04:31:36 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id bs32so3490578qkb.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 04:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OgfpcxUM1YQT09LVbS6a5sMPyg+YT9z4Iq2cGwT7zuM=;
        b=S/aeUb5iNCgJN76OvNhe3noC+RNK2w/xXMmNls7LjaGBxxlN/pM10ooLAFACwJiHVc
         bN9+t4cX5cPCa4KOPHTe07h9xg3c+/8MdWaDYpVhdlgP+J6N8KOTv+tO516q2l7sS5Ns
         kTG5P4ojPkmQ4WW37GQfh2FA5KLd7SrbrvfbuwY/JCkZr62woyRKBe+a58LLHlyqAYP5
         9dRtYSyACwe31w+CilxbUQDSRs/k7ziXEvSyFwYXCbj9sVTw70AwQbyRoYygKZyTnvjr
         QtcPnXGw389H4XqgEBF8rYeBdL+6Rop40n4b8/+1UuS7BJrhQE0j8avYnBF+xcaV32zk
         dnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OgfpcxUM1YQT09LVbS6a5sMPyg+YT9z4Iq2cGwT7zuM=;
        b=zheMQs8uAAxquEz6k+KgZ9BX+YfX7LejVHWsp9i7XpQcjLijqlaykECngIeKq8d9KG
         JQEH6d1W1dxFb8X5YGcXXUAilh2bRzzx4sVJ+OAn2fAqsCbWwM07oBFDpHoeEQin4G/v
         OxqJ524E8Jy3fFVWle3qWDAVHA3VgCT0Trx2aKogubHXFhRY03tqJWb0AiC/taIUyrLC
         Aje0XlM1+qPkMruRYBYKf2GtQCDQ9Xqkn7fn2XuMVSwtEpRhrQs/ihfo5vbBBZwXuw+9
         +KyyxrEHI/o3iW5vnijvmkJBrRkJ8WJnRtBUSRhaZ0HJXxZmmrG0OLA2EOl6+dshRp+w
         nnKA==
X-Gm-Message-State: AOAM530CAaHlJwbOSU5sS/CZ42WIv+1e/B7LFfP91I2W2++8luuz5tw2
        DOoWBjNbN6Dqm+z4kf4A0uPxvw==
X-Google-Smtp-Source: ABdhPJzmGuAiQPbbwfPi5nKhZGAKkWjgngLA/JAnb2Y9o8GB4Pxo98NrM1I0j9QIlsco0XcLKaaLog==
X-Received: by 2002:ae9:eb4f:: with SMTP id b76mr15968552qkg.696.1643718695219;
        Tue, 01 Feb 2022 04:31:35 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id q15sm9597818qti.41.2022.02.01.04.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 04:31:34 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nEsJq-00A6xN-2N; Tue, 01 Feb 2022 08:31:34 -0400
Date:   Tue, 1 Feb 2022 08:31:34 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>, Jan Kara <jack@suse.cz>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH v2 4/4] mm/gup: remove get_user_pages_locked()
Message-ID: <20220201123134.GZ8034@ziepe.ca>
References: <20220201101108.306062-1-jhubbard@nvidia.com>
 <20220201101108.306062-5-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201101108.306062-5-jhubbard@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 02:11:08AM -0800, John Hubbard wrote:
> There is only one caller of get_user_pages_locked(). The purpose of
> get_user_pages_locked() is to allow for unlocking the mmap_lock when
> reading a page from the disk during a page fault (hidden behind
> VM_FAULT_RETRY). The idea is to reduce contention on the heavily-used
> mmap_lock. (Thanks to Jan Kara for clearly pointing that out, and in
> fact I've used some of his wording here.)
> 
> However, it is unlikely for lookup_node() to take a page fault. With
> that in mind, change over to calling get_user_pages_fast(). This
> simplifies the code, runs a little faster in the expected case, and
> allows removing get_user_pages_locked() entirely.
> 
> Cc: Jan Kara <jack@suse.cz>
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  include/linux/mm.h |  2 --
>  mm/gup.c           | 59 ----------------------------------------------
>  mm/mempolicy.c     | 21 +++++++----------
>  3 files changed, 9 insertions(+), 73 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
