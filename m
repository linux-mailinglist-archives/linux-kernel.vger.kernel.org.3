Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5712A5004EC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 06:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239799AbiDNEHE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 00:07:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbiDNEHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 00:07:00 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFB62BE2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 21:04:36 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id o5-20020a17090ad20500b001ca8a1dc47aso8180071pju.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 21:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1Yvw2OdMv8Wer1zau2Qqgf9K5ZU91nVYs0auzDDWTAE=;
        b=bS3J8H3+QDcELENjNFvFu9mMbmF7yl/dm/cHNSZD77rUAfzCe9dg8fvSJjVfy269p/
         F4pXukydfJ+IYEmIARGce2SXHwi/Xobw+QcE4aHJrIhLdJY8E8Rztp1YdOdMz+J04beH
         kPjNyaNw6Rh10lB//HPNtNk6g2BOFgaBO1xUXewq9A3m45cttZbx3vvDqw7U40OvnyOS
         Ox+suMvZmkJo/95JiXjRp3k1+Sf9J6cKoqVuWoiWR0t9fJdzjz845b531wtTg54Qb7vP
         dnDh81pBKAw5qMMCcXvvX4KLfYAcZuTRisyE1z7mYpz30pc//2Npj+3wenshfAsYtbsq
         sLmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1Yvw2OdMv8Wer1zau2Qqgf9K5ZU91nVYs0auzDDWTAE=;
        b=c5SKkfzBWYxnpeYKJn6hPRFvbqSqcCVtuoZfR/64QfcO3mDJIyd+mWn9Aty4z1lGyb
         j6T9FiVAU4yZO/hndM3jQn+ATtitWV4BH3EpDTZN8K7j1b1of3+efwCUoFrs1OX3le8N
         4IIlOWEMucs0KKO/n+WbKA3ooVKkcl3uKue04wD+jIv5vWKXOSDYqWsLCoEPsLHGGAtX
         34QEVgT0t5y+pjiHAQutaJIaoeLYSKPu7KqrIQiuPrm65YAKzg+xsJMUS8hfrS0SKsDn
         wwGbnUCaj7pdjTT5AXVii7T7ZqzBBf0qEl8e80U4iqwIGzqiyMLchX1ojpGLo0X2Kd6b
         J50Q==
X-Gm-Message-State: AOAM530Ocu5JVbxSnP4mDE7O3Cs70UcOWIJLxNiDdocxVoFyOAQuD67n
        Z10OW1DtANCKil6dv8z/tVehUA==
X-Google-Smtp-Source: ABdhPJxGWI1CZqiLhhdt7xudKn9fMZwBuVLqm+dNGrQaijILM1Hww8DNvntXLZstY4WN8dDcRWI99w==
X-Received: by 2002:a17:903:284:b0:158:8e21:2108 with SMTP id j4-20020a170903028400b001588e212108mr9878098plr.37.1649909076271;
        Wed, 13 Apr 2022 21:04:36 -0700 (PDT)
Received: from localhost ([139.177.225.245])
        by smtp.gmail.com with ESMTPSA id w14-20020a63474e000000b0039cce486b9bsm565631pgk.13.2022.04.13.21.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 21:04:35 -0700 (PDT)
Date:   Thu, 14 Apr 2022 12:04:32 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, mcgrof@kernel.org,
        keescook@chromium.org, yzaikin@google.com, osalvador@suse.de,
        david@redhat.com, masahiroy@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v8 4/4] mm: hugetlb_vmemmap: add hugetlb_optimize_vmemmap
 sysctl
Message-ID: <YledUEAa6cPBri52@FVFYT0MHHV2J.usts.net>
References: <20220413144748.84106-1-songmuchun@bytedance.com>
 <20220413144748.84106-5-songmuchun@bytedance.com>
 <20220413121051.a363193c726451115c634a69@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413121051.a363193c726451115c634a69@linux-foundation.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 12:10:51PM -0700, Andrew Morton wrote:
> On Wed, 13 Apr 2022 22:47:48 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
> 
> > We must add hugetlb_free_vmemmap=on (or "off") to the boot cmdline and
> > reboot the server to enable or disable the feature of optimizing vmemmap
> > pages associated with HugeTLB pages.  However, rebooting usually takes a
> > long time.  So add a sysctl to enable or disable the feature at runtime
> > without rebooting.
> 
> Do we really need this feature?  Really?  What's the use case and what
> is the end-user value?
>

We know that this feature is disabled by default without passing
"hugetlb_free_vmemmap=on" to the boot cmdline. When we (ByteDance)
deliver the servers to the users who want to enable this feature,
they have to configure the grub (change boot cmdline) and reboot the
servers, whereas rebooting usually takes a long time (we have
thousands of servers). It's a very bad experience for the users.
So we need a approach to enable this feature after rebooting. This
is a use case in our practical environment.

> Presumably CONFIG_HUGETLB_PAGE_OPTIMIZE_VMEMMAP worsens things for some
> setups/workloads?  Please tell us much more about that.  What is the
> magnitude of the deoptimization?
>

Most workloads are allocated HugeTLB from the pool not the buddy
allocator, which are the users of this feature. However if the
use case is that HugeTLB pages are allocated 'on the fly' instead
of being pulled from the HugeTLB pool, those workloads would be
affected with this feature enabled.  Those workloads could be
identified by the characteristics of they never explicitly allocating
huge pages with 'nr_hugepages' but only set 'nr_overcommit_hugepages'
and then let the pages be allocated from the buddy allocator at
fault time.  I don't know what the specific workload is. But I
can confirm it is a real use case from the commit 099730d67417.
For those workloads, the page fault time could be ~2x slower than
before. I suspect those users want to disable this feature
if the system has enabled this before if they don't think the memory
savings benefit is enough to make up for the performance drop.

Do you think it's ok if I put those information in the commit
log or vm.rst?

Thanks.

