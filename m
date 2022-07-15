Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58B4A5765EA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbiGORHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235564AbiGORHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:07:45 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1D7C61401F
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657904862;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EHV1QhmT8JPtQAFBTILbNQ8Q1Cjq9HLm6CE8YiVAOqY=;
        b=HzCz4i1CRZnA8H4XddeyoNsY/0brqmpuZZZFq8tvyLh+tP8DvuVVFFQ2EfZniEQq5gREw3
        2CWAqCMeUE1TvPnhAvjaWmB0WUAf/ezsjlOD/t79f31Vhu9H0UBrZOYyfyqMPY4fSJGKxd
        Q7o0jlJFiOUOBt2zzBzqCx1yl++sJuE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-617-QnndiV_uNxCLPSGePvIx5w-1; Fri, 15 Jul 2022 13:07:41 -0400
X-MC-Unique: QnndiV_uNxCLPSGePvIx5w-1
Received: by mail-qv1-f69.google.com with SMTP id q3-20020ad45743000000b004735457f428so3377699qvx.23
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 10:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EHV1QhmT8JPtQAFBTILbNQ8Q1Cjq9HLm6CE8YiVAOqY=;
        b=UQ+/5CKUn6KUltyCxixmCUikeU8iD6kl8Kni6fvtpBmnzryL/1g3JCybHuuXQ+aYf5
         gCNweHshhPk3UU/XbuyAxGiNlZm1rbwfOhbNVqloydvmNt7vweaXuywgIapIZ4w17Qdc
         xfdco6wIB53gdPvM6tMDwMtcOHFnRXHPkghpJWXG9Qu8e6wWYOr+1DDbzkvHrk5j8m9F
         N5VCbN+rpQ2rw28DbhlBw1/M0VXwPw6hlUD07MnGQuUJORTvw4N5gLko8gdoZfj7FAAQ
         zP8IbrMbd0dvv/WdQ6iC7KcewlnqHUKOVKRDne7MdZoJV4+xNElEAE/cyEhKAguj65kD
         3Alg==
X-Gm-Message-State: AJIora9s7SMJNscrwpcsrxeaZ2H5On6eIhlR4wrrlovlRAB6yZGp1tHT
        WScTqHsmjJYbQ9wMEydNJoGDjOS9R3UCKml+M2dZvbkFoUQULIeVD0hjRaxlu5+Baq445qai3d7
        8viRP26GYKaqZyFn141rjuEiz
X-Received: by 2002:ad4:5ca6:0:b0:473:9f3b:a1d with SMTP id q6-20020ad45ca6000000b004739f3b0a1dmr9561444qvh.25.1657904860521;
        Fri, 15 Jul 2022 10:07:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vAuzSiARBGaAHLEmB8N33I1B7gu/rnc5VEXZTohrWR9BX1q7CVNeim/8VUENoLr9NCJjPJqg==
X-Received: by 2002:ad4:5ca6:0:b0:473:9f3b:a1d with SMTP id q6-20020ad45ca6000000b004739f3b0a1dmr9561418qvh.25.1657904860087;
        Fri, 15 Jul 2022 10:07:40 -0700 (PDT)
Received: from xz-m1.local (bras-base-aurron9127w-grc-37-74-12-30-48.dsl.bell.ca. [74.12.30.48])
        by smtp.gmail.com with ESMTPSA id bs33-20020a05620a472100b006b5d665634asm418164qkb.65.2022.07.15.10.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 10:07:39 -0700 (PDT)
Date:   Fri, 15 Jul 2022 13:07:38 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>
Cc:     Miaohe Lin <linmiaohe@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/hugetlb: avoid corrupting page->mapping in
 hugetlb_mcopy_atomic_pte
Message-ID: <YtGe2qIO038e627p@xz-m1.local>
References: <20220712130542.18836-1-linmiaohe@huawei.com>
 <20220713102357.8328614813db01b569650ffd@linux-foundation.org>
 <a47922cf-eb30-1ad9-fc96-1896254564ef@huawei.com>
 <YtA7svbn4MtuT7qJ@xz-m1.local>
 <402ae708-4c86-8feb-75c4-9339e1deac3b@huawei.com>
 <YtFfHU3fb/ncCG6O@xz-m1.local>
 <CAJHvVcgFY2uXM=CkxYmHc32Vqb5qmr8vFv0dpFk-2=Ef+Kssqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJHvVcgFY2uXM=CkxYmHc32Vqb5qmr8vFv0dpFk-2=Ef+Kssqw@mail.gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 09:45:37AM -0700, Axel Rasmussen wrote:
> I agree we should either:
> - Update the UFFD selftest to exercise this case
> - Or, don't allow it, update vma_can_userfault() to also require VM_SHARED
> for VM_UFFD_MINOR registration.
> 
> The first one is unfortunately not completely straightforward as Peter
> described. I would say it's probably not worth holding up this fix while we
> wait for it to happen?

Agreed, Andrew has already queued it.  It actually is a real fix since we
never forbid the user running private mappings upon minor faults, so
it's literally a bug in kernel irrelevant of the kselftest.

> 
> I don't really have a strong preference between the two. The second option
> is what I originally proposed in the first version of the minor fault
> series, so going back to that isn't a problem at least from my perspective.
> If in the future we find a real use case for this, we could always easily
> re-enable it and add selftests for it at that point.

I'd go for fixing the test case if possible.  Mike, would it be fine if we
go back to /dev/hugepages path based approach in the test case?

Thanks,

-- 
Peter Xu

