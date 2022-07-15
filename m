Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EBE576A5D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 01:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231575AbiGOXEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 19:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbiGOXDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 19:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A84511C928
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 16:03:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657926223;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Icw+DEbSSX3MLPi/wiDEHSul5TtCehj1QjKG5ZBjsAI=;
        b=PaeFWSfKpc31xoUbpdXZyAAVQFRWAI3N4AZ6XdevWq0gQnBjtPoMx1dQn3cD6V8pxWlW7B
        KD0+Yg8NAkYD7hztwX53r5PRivYKWPxVwuqhCPq2v6vF9RYXkYOmvua3qNpAd3Lzp75cGL
        6O7SIOacbVW2tm8xc4hte8TZnA+DRn4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-645-M1QEQ-KFPsuDJ2FcFMifLA-1; Fri, 15 Jul 2022 19:03:41 -0400
X-MC-Unique: M1QEQ-KFPsuDJ2FcFMifLA-1
Received: by mail-qt1-f198.google.com with SMTP id fx12-20020a05622a4acc00b0031e98cb703cso4452756qtb.18
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 16:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Icw+DEbSSX3MLPi/wiDEHSul5TtCehj1QjKG5ZBjsAI=;
        b=QlrSnI8bPvMy42ANAdnuHDd8W8NwLO0JP3TXZ7VdTVgzk+HrG25erHMfkEZPGSquhW
         JykuYRFZ694E7hMF7BS19LfKwlCrj75dm/n+0n4SEgJmTusy134YDOf/OHz623IHqBLP
         GFQh3p7mNi3x0eiIc1dUpWGbhsKlid5JHqhFqj42/2TuE1IQw9XM4i/dkTu9BqGKB5Jo
         sZ1BPi1OwA/sBItsrOY2wG/LzpkRGljfeI8Za2TL+vFRh3e0UEh6UWDZLH7gtSe/Nb0A
         QB4aMaamr1edW0NJ77nMtmI2cxhs+qiX2VThlDsZYNGoj+/sc46AxUm3Emrb8KayBZ1T
         LzcQ==
X-Gm-Message-State: AJIora90zKIbC3oryQbeea18L6wSOewk3FeJPxD07/y/g/8YT5JMTfr5
        0aS9kLWBdCu7mx9Sj3mjaEf1+x/Pr9DkHn4JdyXaerPC1y8OkuCHTmQlb0PE6UUiOR8ZQmPFAUS
        kOcQTIJSH8EWlXDV7kpBcdd2k
X-Received: by 2002:a05:620a:1a9b:b0:6a6:d3f6:5c97 with SMTP id bl27-20020a05620a1a9b00b006a6d3f65c97mr11062824qkb.225.1657926220596;
        Fri, 15 Jul 2022 16:03:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1v0QNYTL780R2LvwScBaG53gCdrmd38N/vQaAAVgRX3spItAx0R9rUcsdDRvws7EQJAr34eXw==
X-Received: by 2002:a05:620a:1a9b:b0:6a6:d3f6:5c97 with SMTP id bl27-20020a05620a1a9b00b006a6d3f65c97mr11062801qkb.225.1657926220374;
        Fri, 15 Jul 2022 16:03:40 -0700 (PDT)
Received: from xz-m1.local ([74.12.30.48])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a254a00b006a6d74f8fc9sm6098721qko.127.2022.07.15.16.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 16:03:39 -0700 (PDT)
Date:   Fri, 15 Jul 2022 19:03:34 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH 07/26] hugetlb: add hugetlb_pte to track HugeTLB page
 table entries
Message-ID: <YtHyRrkA+go+7D9D@xz-m1.local>
References: <20220624173656.2033256-1-jthoughton@google.com>
 <20220624173656.2033256-8-jthoughton@google.com>
 <YsyzGMS+MS0kZoP8@monkey>
 <Ys1B+fXo2uSPd46B@work-vm>
 <YtGXTlyRs3oVVPA5@xz-m1.local>
 <CAJHvVci+vBRnSNBnBC5tNKtesf0m5XQ943fWw9M+MRj7o7VDrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVci+vBRnSNBnBC5tNKtesf0m5XQ943fWw9M+MRj7o7VDrQ@mail.gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 02:52:27PM -0700, Axel Rasmussen wrote:
> Guest access in terms of "physical" memory address is basically
> random. So, actually filling in all 262k 4K PTEs making up a
> contiguous 1G region might take quite some time. Once we've completed
> any of the various 2M contiguous regions, it would be nice to go ahead
> and collapse those right away. The benefit is, the guest will see some
> performance benefit from the 2G page already, without having to wait
> for the full 1G page to complete. Once we do complete a 1G page, it
> would be nice to collapse that one level further. If we do this, the
> whole guest memory will be a mix of 1G, 2M, and 4K.

Just to mention that we've got quite some other things that drags perf down
much more than tlb hits on page sizes during any VM migration process.

For example, when we split & wr-protect pages during the starting phase of
migration on src host, it's not about 10% or 20% drop but much drastic.  In
the postcopy case it's for dest but still it's part of the whole migration
process and probably guest-aware too.  If the guest wants, it can simply
start writting some pages continuously and it'll see obvious drag downs any
time during migration I bet.

It'll always be nice to have multi-level sub-mappings and I fully agree.
IMHO it's a matter of whether keeping 4k-only would greatly simplify the
work, especially on the rework of hugetlb sub-mage aware pgtable ops.

Thanks,

-- 
Peter Xu

