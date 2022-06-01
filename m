Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0383653A152
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351159AbiFAJyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350502AbiFAJyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:54:10 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9426338D
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 02:54:08 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id gd1so1553962pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 02:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e0X3nukNsLOhh6Y9CwwnQna0l5z5ykZ7aUl5rmtL/+E=;
        b=majHexgf9bZrG6j89RxBARjC4r4/myBR0n4vbdDVCWqmrs1Rw5jzT206JsmizuE8BM
         7DnboMS+fAMQVqPVmMp4ZIaw7AEVbsMJp/qJvq21xpPxHynppuiy/wFtI/nibejLBJzY
         fajfgkkCUVDeNWBsvCqFxY9NEaS7oPX/urrCvQRQton/nzrHwol37OhfOLaVcYgrRHWf
         oJDo2a/WPIO1zh6tT+subXTxm2Gz6YS+LnNRdo4926Aw5p4hUXJpQIwv+a7oFxErT/9m
         nSB+YiX7cQXupp9czW22mI90l2Fe3VTm6U+C8BxEtYWe5BqvTmkOBKPuabO1QVjUv0qH
         cYtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e0X3nukNsLOhh6Y9CwwnQna0l5z5ykZ7aUl5rmtL/+E=;
        b=WUYYbJz8QiRPlm/xHQ7kl9TrNop6GxnrDsEHnYk+Q3pBiTCZQjFQmyvgKwQJ8szyek
         w+mcV1+IK7g6kRqgYkp9VYXwPAWKUq2FuyhefXZcTY6eTY4vp2MlzoJzwRMujkR+/5kB
         ilShwzZiYcyNBJlIGT7RxhlDQtbJ43ieYoZLcFCfH0UDobD8e3/9eoURSz9nt+pJn1ys
         GuREvSWrvyEs+twvu+WX1Yzvzv5OexVHVngg1t+fWcbIFa2nuRNh6dKgV/t2iuAACAgF
         SNKje5QRE4jssHI//pK3e3nU2zYaEiCNCnnjxzaYUTCw93u9kL9Cidhm4ewVoIbnsIdG
         RvJg==
X-Gm-Message-State: AOAM531J9CD/tS6k/YZO7bxS4tGOmN4g+DKvV7GQgZMAGnz+izWZ2iHD
        MAmUrhq1+lG0tDGy5yTsbtpiUw==
X-Google-Smtp-Source: ABdhPJw0Vdas5Ez2S0AVtmbs6S8PBW7lkn3x/2HBDyhbbY3eSGdom+a26dU8rcZUKgzNom8aPOsbwg==
X-Received: by 2002:a17:902:e5ca:b0:164:1958:c84a with SMTP id u10-20020a170902e5ca00b001641958c84amr4779962plf.72.1654077247993;
        Wed, 01 Jun 2022 02:54:07 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:f9bc:fb5f:5b66:a80e])
        by smtp.gmail.com with ESMTPSA id p16-20020a1709027ed000b0016403cae7desm364272plb.276.2022.06.01.02.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 02:54:07 -0700 (PDT)
Date:   Wed, 1 Jun 2022 17:54:02 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        smuchun@bytedance.com
Subject: Re: [PATCH 3/3] mm: hugetlb_vmemmap: cleanup
 CONFIG_HUGETLB_PAGE_FREE_VMEMMAP*
Message-ID: <Ypc3OquA5MZUl5iw@FVFYT0MHHV2J.googleapis.com>
References: <20220404074652.68024-1-songmuchun@bytedance.com>
 <20220404074652.68024-4-songmuchun@bytedance.com>
 <ba64cd1b-c8ee-a4eb-f0cd-e16c26777d46@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba64cd1b-c8ee-a4eb-f0cd-e16c26777d46@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 01, 2022 at 11:32:37AM +0200, David Hildenbrand wrote:
> On 04.04.22 09:46, Muchun Song wrote:
> > The word of "free" is not expressive enough to express the feature of optimizing
> > vmemmap pages associated with each HugeTLB, rename this keywork to "optimeze".
> > In this patch , cheanup configs to make code more expressive.
> 
> Nit: why not simply CONFIG_HUGETLB_OPTIMIZE_VMEMMAP if we're touching
> this already? At least I don't see value in the additional "PAGE" :)
>

I thought it keep consistent with CONFIG_HUGETLB_PAGE.  If you think
CONFIG_HUGETLB_OPTIMIZE_VMEMMAP is a better name, maybe we need to
another separate patch since this series is already on mm-stable branch.
 
> > 
> > Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt |  4 ++--
> >  Documentation/admin-guide/mm/hugetlbpage.rst    |  2 +-
> >  arch/arm64/Kconfig                              |  2 +-
> >  arch/arm64/mm/flush.c                           |  2 +-
> >  arch/x86/Kconfig                                |  2 +-
> >  arch/x86/mm/init_64.c                           |  2 +-
> >  fs/Kconfig                                      | 16 ++++++++--------
> >  include/linux/hugetlb.h                         |  2 +-
> >  include/linux/mm.h                              |  2 +-
> >  include/linux/page-flags.h                      |  6 +++---
> >  mm/Makefile                                     |  2 +-
> >  mm/hugetlb_vmemmap.c                            |  4 ++--
> >  mm/hugetlb_vmemmap.h                            |  4 ++--
> >  mm/sparse-vmemmap.c                             |  4 ++--
> >  14 files changed, 27 insertions(+), 27 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 56edbe3f458f..89a58ac49d5f 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -1660,7 +1660,7 @@
> >  			Format: size[KMG]
> >  
> >  	hugetlb_free_vmemmap=
> 
> We didn't change the parameter name in #2, correct?
>

I think this is a interface to users. Is it correct to
change it?

Thanks.

