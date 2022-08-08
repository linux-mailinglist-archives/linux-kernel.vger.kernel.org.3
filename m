Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A133C58CBE0
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 18:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243892AbiHHQKL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 12:10:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243316AbiHHQKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 12:10:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 12F641580D
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 09:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659975007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k2rVxCQ9cERJ9mXQXAN4OFCiUy0IwjBElfQJb084200=;
        b=gIRvVmFUqMn4qjjeB1KIItfSGTqGU6XpId1sIIeqNcCh9OIMq7fsePZ2uM2Q/xB43VwTJt
        HMZAGAzYkEJaORFdznC7Oy01rNUHscFpR41xwMdS1vPD1sWqU+f8g+UgpqkvWdIOiZ3p5N
        4XPq9VIFC7Le2WmQ0ENDrGCgVTi4DSM=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-H0QaD-jlPIad752LSb2Rhw-1; Mon, 08 Aug 2022 12:10:06 -0400
X-MC-Unique: H0QaD-jlPIad752LSb2Rhw-1
Received: by mail-il1-f199.google.com with SMTP id f5-20020a056e020b4500b002df180f0997so6926951ilu.21
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 09:10:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=k2rVxCQ9cERJ9mXQXAN4OFCiUy0IwjBElfQJb084200=;
        b=KR89qEJZ1wOK4N0GqYGBe3jD1fRgeMJLZgbwo8jeLDyQ0mUUt1jdUAD2+IXfdNTXgq
         XFyHn5PZtzBEVcTRmHbCaUKQYzHCZJHyrg4qB8W/oHwwedkVZXoM3pB/TR/EdzUreeHx
         vCAwIdZgMwRVLrNrzguO8pp7R8vaxEbT/WOAwHNf1oZ9Yxo+UM7HJl3BjUXE+SoxFX0i
         1ZcwY05yhiiu8nJZi/AD9ib9Mrb/qSvUq82AEPL5oLgorCe/JPr0dJU/PH3FEhLbO7S2
         3gJLbVcZ5LfrI75CdpxDGsuEXtbYl/CQNwn3Bap81naaaMbhGZCQIma5PT0BzgJD0Auq
         gKug==
X-Gm-Message-State: ACgBeo2uvBn4OMBr6+uCQGDEg0g4Hhd/jKMevqVbImWOTdNYE8MpiwJq
        WjEkZQrt5Kp6b2Fe1MEDIZQCcv4IECm/7RfjaNSE3b4zo4YnLq0gScNbIJRZDUj7MWyCK0U2qQV
        GMmjKHrUIi9wvMufyJVOjo6yj
X-Received: by 2002:a05:6e02:1c8d:b0:2df:72a9:ffcc with SMTP id w13-20020a056e021c8d00b002df72a9ffccmr8511695ill.189.1659975005366;
        Mon, 08 Aug 2022 09:10:05 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7M1kTZV0NW8ZsPJx7vif6CuH8zsDVFp6bLmx9V6FX7OFY7lFm4pqiWPcbvha02rSsJfqTNtg==
X-Received: by 2002:a05:6e02:1c8d:b0:2df:72a9:ffcc with SMTP id w13-20020a056e021c8d00b002df72a9ffccmr8511686ill.189.1659975005142;
        Mon, 08 Aug 2022 09:10:05 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-35-70-27-3-10.dsl.bell.ca. [70.27.3.10])
        by smtp.gmail.com with ESMTPSA id n16-20020a056602341000b00684f4b808ffsm13634ioz.39.2022.08.08.09.10.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Aug 2022 09:10:04 -0700 (PDT)
Date:   Mon, 8 Aug 2022 12:10:02 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Feiner <pfeiner@google.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH v1 1/2] mm/hugetlb: fix hugetlb not supporting
 write-notify
Message-ID: <YvE1WsGKkGjyx1FU@xz-m1.local>
References: <20220805110329.80540-1-david@redhat.com>
 <20220805110329.80540-2-david@redhat.com>
 <Yu1eCsMqa641zj5C@xz-m1.local>
 <Yu1gHnpKRZBhSTZB@monkey>
 <c2a3b903-099c-4b79-6923-8b288d404c51@redhat.com>
 <Yu1ie559zt8VvDc1@monkey>
 <73050e64-e40f-0c94-be96-316d1e8d5f3b@redhat.com>
 <Yu2CI4wGLHCjMSWm@monkey>
 <Yu2kK6s8m8NLDjuV@xz-m1.local>
 <Yu2o5DUncFywbPFS@monkey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Yu2o5DUncFywbPFS@monkey>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2022 at 04:33:56PM -0700, Mike Kravetz wrote:
> It looks like vma_soft_dirty_enabled is recent and not in any stable
> trees (or even 5.19).
> 
> Yes, I did start working on hugetlb softdirty support in the past.
> https://lore.kernel.org/lkml/20210211000322.159437-1-mike.kravetz@oracle.com/
> 
> Unfortunately, it got preempted by other things.  I will try to move it up
> the priority list.

Thanks, Mike.

It'll also makes sense to forbid it if it may take time to finish, so we
don't need to push ourselves.

-- 
Peter Xu

