Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC98A4B1C33
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 03:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347296AbiBKC3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 21:29:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238596AbiBKC3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 21:29:01 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B73310D8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 18:29:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644546539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZRXctwJeAQFVYjXrxuQmTAgJlVAm+rBpFurANrwaps0=;
        b=eSwnmSQz6ka58umkUu8n/zHUOsg+lMJ80DXfCUxKgd21k2JLdozva3+nEjShkHwCLWWnWA
        s8BStRqFqfqq8iJR3GeGuWbG5Iporf0DNZwNoz125FyaNBRJ13haET2AsqvHQ1aOD7Y85B
        +KnJgZmfUSLFvPb1G4NmHnPMwgTt4Y4=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-650-jwjMdBHBNF-F0Q7qA8cseA-1; Thu, 10 Feb 2022 21:28:57 -0500
X-MC-Unique: jwjMdBHBNF-F0Q7qA8cseA-1
Received: by mail-pf1-f199.google.com with SMTP id m6-20020a056a00080600b004e06140d481so3944441pfk.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 18:28:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZRXctwJeAQFVYjXrxuQmTAgJlVAm+rBpFurANrwaps0=;
        b=M944KPuuOJFtdIhKBI2V/UiE8UVwSKPDBC0DVjWi2E2BvOcIMIvGHPaGdyFIdeUwfE
         HSV16dsfBW9CEu6ihQf5MnSFSMOhblMb37hStnHHnQwjTvF7BhaPte2aJhvJDIrrEc5A
         AGI46LJejN3JqTH7VUPJOLlhLhiDBCVEt/QyXlt3qWFWX0QYeS3rgvCgZ3TVgqSAOLUc
         oBrUnPV0emoWV8Cvz7CulRZ7iHN7xk7aCaYDASWDCjyzR8EuYFxflWJOiLHT4ANy/PUn
         gtoBqHdaTS/9Col1LiYP2RcSy/j6atfmAw65ureB55DP0V3patvoafNFxodNd3AmQyti
         U3jA==
X-Gm-Message-State: AOAM530dbJ8LCPxYCZ8xXFcCM46C9smBy9KbENuC1wa5iBqMKunGe2wu
        2MCWxz35IWB6pF2Mg3FPNnp11VOLU4bgdR+j4JzjhVVIUzMIisiC+GYJnhhgxBYaUqHk3O2nOkU
        XWdTYT+XWvAHjI9sIDSeKUazI
X-Received: by 2002:a17:90b:3509:: with SMTP id ls9mr395377pjb.119.1644546536289;
        Thu, 10 Feb 2022 18:28:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwyKhpLjhur3uEYC/MkRKNPNhuN8BVtI9OKif4ZLj48t7oOtjhV+RYCcpM1wBjEQ2GppRv0/Q==
X-Received: by 2002:a17:90b:3509:: with SMTP id ls9mr395358pjb.119.1644546535962;
        Thu, 10 Feb 2022 18:28:55 -0800 (PST)
Received: from xz-m1.local ([94.177.118.150])
        by smtp.gmail.com with ESMTPSA id q1sm8172622pfs.112.2022.02.10.18.28.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 18:28:55 -0800 (PST)
Date:   Fri, 11 Feb 2022 10:28:49 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        David Hildenbrand <david@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/3] mm: enable MADV_DONTNEED for hugetlb mappings
Message-ID: <YgXJ4VjYBJC9ZfbF@xz-m1.local>
References: <20220202014034.182008-1-mike.kravetz@oracle.com>
 <20220202014034.182008-2-mike.kravetz@oracle.com>
 <YgSDcmXya7vTvvZE@xz-m1.local>
 <bf1f7a47-5d57-492a-03dd-e42afe186d47@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <bf1f7a47-5d57-492a-03dd-e42afe186d47@oracle.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 01:36:57PM -0800, Mike Kravetz wrote:
> > Another use case of DONTNEED upon hugetlbfs could be uffd-minor, because afaiu
> > this is the only api that can force strip the hugetlb mapped pgtable without
> > losing pagecache data.
> 
> Correct.  However, I do not know if uffd-minor users would ever want to
> do this.  Perhaps?

My understanding is before this patch uffd-minor upon hugetlbfs requires the
huge file to be mapped twice, one to populate the content, then we'll be able
to trap MINOR faults via the other mapping.  Or we could munmap() the range and
remap it again on the same file offset to drop the pgtables, I think. But that
sounds tricky.  MINOR faults only works with pgtables dropped.

With DONTNEED upon hugetlbfs we can rely on one single mapping of the file,
because we can explicitly drop the pgtables of hugetlbfs files without any
other tricks.

However I have no real use case of it.  Initially I thought it could be useful
for QEMU because QEMU migration routine is run with the same mm context with
the hypervisor, so by default is doesn't have two mappings of the same guest
memory.  If QEMU wants to leverage minor faults, DONTNEED could help.

However when I was measuring bitmap transfer (assuming that's what minor fault
could help with qemu's postcopy) there some months ago I found it's not as slow
as I thought at all..  Either I could have missed something, or we're facing
different problems with what it is when uffd minor is firstly proposed by Axel.

This is probably too out of topic, though..  Let me go back..

Said that, one thing I'm not sure about DONTNEED on hugetlb is whether this
could further abuse DONTNEED, as the original POSIX definition is as simple as:

  The application expects that it will not access the specified address range
  in the near future.

Linux did it by tearing down pgtable, which looks okay so far.  It could be a
bit more weird to apply it to hugetlbfs because from its definition it's a hint
to page reclaims, however hugetlbfs is not a target of page reclaim, neither is
it LRU-aware.  It goes further into some MADV_ZAP styled syscall.

I think it could still be fine as posix doesn't define that behavior
specifically on hugetlb so it can be defined by Linux, but not sure whether
there can be other implications.

Thanks,

-- 
Peter Xu

