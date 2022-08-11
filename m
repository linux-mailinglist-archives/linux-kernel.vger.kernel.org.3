Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1BD8590801
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 23:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236272AbiHKVXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 17:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236170AbiHKVXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 17:23:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 457759C2C8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660252998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EvXEqwnpgxBR5V37M69x7J1gz6DoDVNjLXtrplisCZQ=;
        b=Q+hf7fXGkzRqDZWhHjoW0+z305SRjbpSkPZs2DpE5teRvT+EfZymkRuOKeMpYoj2Npo13y
        fZcqW6TJtrAgPyTzXxAcin7/cRyeblVe/nwLmwna7QYa4UsAGeu1XrDQtj0W6LVxql9Vin
        Qy50ycZYICEetJmoTIWNojxk6/EgGAI=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-237-EJQq67L-MT6HzJwDkfEDfg-1; Thu, 11 Aug 2022 17:23:17 -0400
X-MC-Unique: EJQq67L-MT6HzJwDkfEDfg-1
Received: by mail-il1-f199.google.com with SMTP id a19-20020a921a13000000b002df8a28c30dso12690994ila.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 14:23:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=EvXEqwnpgxBR5V37M69x7J1gz6DoDVNjLXtrplisCZQ=;
        b=v+4WfBiqrOVH5VRk3PwD0K/QVdfHgQlo6F6Eux1WjbQbd2mGTRYULZdnI2LxgluhAO
         +Y0giiC1gQPoMEA2KYrULGbIXcdk7RzHxNFjeaW+FtQkxhMdBsrsFtQ+XjT78xnOA62R
         rwLBbMlZU1dJt3z3XXASl2mCiukAskdENUO16kI0jAvcjmE4K2uta03iCgxY6a4Fal7v
         DdZDJjZiTl2EskUoDnhJ6s/VzpR/VPzvFvkvIteZYLhrXG8VwAvZ2mNrlYjhAmJR9LOb
         +51HY/HdAh74ZOOSvStt4Im2kDYi8ZvgxalQPhQbYZYXlYSOOkwqS3IvpQ2ooW6tyFr4
         fQBQ==
X-Gm-Message-State: ACgBeo2xmgPsjnYY5zd8K2FWMiELhSPfCoeoWYygt2yUIPC+GkfWz7t6
        r7xUicFyhjZq22ooKsgeIglE/XbU5LIJV6PPRa2Te+FtRI2qslt147Rylhw+NoU+E5n+uQPfS6r
        iA6md578QACJijP3JTjxVlyC+
X-Received: by 2002:a05:6638:408a:b0:343:4e78:3d6d with SMTP id m10-20020a056638408a00b003434e783d6dmr580567jam.9.1660252996385;
        Thu, 11 Aug 2022 14:23:16 -0700 (PDT)
X-Google-Smtp-Source: AA6agR50v/aovLGMB6cObagQV2vXH8mMuQeI2tmvoteP2TWYTc/0UBplSCwVrdq7os7G5z5WKJJZ4g==
X-Received: by 2002:a05:6638:408a:b0:343:4e78:3d6d with SMTP id m10-20020a056638408a00b003434e783d6dmr580561jam.9.1660252996165;
        Thu, 11 Aug 2022 14:23:16 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id n6-20020a056e021ba600b002de23b60e77sm154376ili.39.2022.08.11.14.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Aug 2022 14:23:15 -0700 (PDT)
Date:   Thu, 11 Aug 2022 17:23:14 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: Re: [PATCH] mm/uffd: Reset write protection when unregister with
 wp-mode
Message-ID: <YvVzQqXp81zgA/DP@xz-m1.local>
References: <20220811201340.39342-1-peterx@redhat.com>
 <20220811141144.6aa509e68c5c7cd8b6c131b6@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220811141144.6aa509e68c5c7cd8b6c131b6@linux-foundation.org>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 11, 2022 at 02:11:44PM -0700, Andrew Morton wrote:
> On Thu, 11 Aug 2022 16:13:40 -0400 Peter Xu <peterx@redhat.com> wrote:
> 
> > I added a Fixes upon introducing of uffd-wp shmem+hugetlbfs because that's
> > the only issue reported so far and that's the commit David's reproducer
> > will start working (v5.19+).  But the whole idea actually applies to not
> > only file memories but also anonymous.  It's just that we don't need to fix
> > anonymous prior to v5.19- because there's no known way to exploit.
> 
> I added a cc:stable to this.

Thanks, Andrew.  I'll remember to do so in future patches when Fixes apply.

-- 
Peter Xu

