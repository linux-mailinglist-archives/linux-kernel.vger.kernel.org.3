Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9B234B06E1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 08:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbiBJHUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 02:20:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiBJHUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 02:20:33 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB8FD6D
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 23:20:35 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id v47so12820546ybi.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 23:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZX/WOZsnGI7NHrW3LHW9fWbxuWWXkvq+KrfxlH19WkQ=;
        b=mnCQTtryb0tmtF8+f3k+sVI71drjg1mVtn46FiiiRafv0su+7dnP8kwTMp/ROdO048
         fcfOjVYrES+pwRrCHDsb2EFqdXLRXvCOJUML8Byl50JsMjb2ZqqzRvyi27AFULX36V4k
         e0bSSMnAvdy+UuvKrjJF2Eq/gWCNzHStw1iY8Gd29DOd4pTEqiMb6E4B7Yc8wGmJ1dPg
         tK05dDTqrH0pimHGgGB5AoLlLnyIFeckKIV8XW2xPI+VISAKUXI633AEmu4XAbQfENd5
         +CTvdOtmZZU5UzYXvyu94nambEXkpN3j2sx3dD7w9y9ciuqii1a6zZf1spDvyf1PlvZf
         h8dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZX/WOZsnGI7NHrW3LHW9fWbxuWWXkvq+KrfxlH19WkQ=;
        b=5Jk5TIMp4qxhpVGv2l42eEUf7tjtMaB2VbwwVis+Hyi4DAndUEHy4e4CzkBiAYnb7B
         EEkmzzA0zHTWuioJpvWAOBw8JS7GMa8E7np0OUnjOf8MRRG2E2qwrbMhTU+M/yF9AbTV
         cafqbQVSK5PlhKSwaQ4T060zIcW/27VSjs2FmAO6PNjis8Ad1GOHYCNEcNhAQxhR30+u
         CPPTCfcaenlTs7IhBoT6Yfm2FmfxxBRUSnDR0+KwGxRPqHBO6DpxetnhDfotb2yxSO45
         Gv2Czzc9hXVs2+PW0dQl9gB12CF502TK0R13lJCKUHUXf6o3oRQDWS0wRRvhDJKRu0Kx
         XBwQ==
X-Gm-Message-State: AOAM530hg+opyAcWZDg4f9Njjkig00gVjjEvj52+lowhtLHq8cJrNWJR
        9qy3YEf3pqWosemi4NSXAhuzcFTLMfn596a+5IJ6u0GNXy4GT1pr
X-Google-Smtp-Source: ABdhPJwaXiABsmttpq0abL+FY1DkbKr8FxxA6gSxIWp2Lq3V0jvddYBCy3+ENnEdd8oHMco7G1iYYIzkL6kvQl23mjM=
X-Received: by 2002:a81:4524:: with SMTP id s36mr6060238ywa.331.1644477634424;
 Wed, 09 Feb 2022 23:20:34 -0800 (PST)
MIME-Version: 1.0
References: <20220208073617.70342-1-songmuchun@bytedance.com>
 <20220208073617.70342-4-songmuchun@bytedance.com> <d78d6e56-1879-94c8-dc28-06431e583a77@oracle.com>
In-Reply-To: <d78d6e56-1879-94c8-dc28-06431e583a77@oracle.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Thu, 10 Feb 2022 15:19:57 +0800
Message-ID: <CAMZfGtUTj-r-sO3YRfyEhvR1mKYxi6kXx+ZZPVYjV3AhAMdh1g@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] mm: hugetlb: fix missing cache flush in copy_huge_page_from_user()
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, zi.yan@cs.rutgers.edu,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        David Rientjes <rientjes@google.com>,
        Lars Persson <lars.persson@axis.com>, Zi Yan <ziy@nvidia.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Fam Zheng <fam.zheng@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 3:07 AM Mike Kravetz <mike.kravetz@oracle.com> wrote:
>
> On 2/7/22 23:36, Muchun Song wrote:
> > The userfaultfd calls copy_huge_page_from_user() which does not do
> > any cache flushing for the target page.  Then the target page will
> > be mapped to the user space with a different address (user address),
> > which might have an alias issue with the kernel address used to copy
> > the data from the user to.  Fix this issue by flushing dcache in
> > copy_huge_page_from_user().
>
> Quick question.
>
> Should this also be done for the non-hugetlb case?  Take a look at the
> routines __mcopy_atomic() and mcopy_atomic_pte().  Or, is that somehow
> handled?

Actually, you are right. __mcopy_atomic() and mcopy_atomic_pte()
should also be fixed.  And shmem_mfill_atomic_pte() also should
be fixed. I'll fix those places in the next version. Thanks.

>
> For this change,
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

Thanks Mike.
