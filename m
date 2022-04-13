Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F074FF1B3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 10:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233725AbiDMIYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 04:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233729AbiDMIYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 04:24:06 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A019D4CD46
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 01:21:44 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id e8-20020a17090a118800b001cb13402ea2so1400430pja.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 01:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=I8Fp/J9JBJVbIQwf58urq1qg0AO1zW6eUoOmoZ1bkg4=;
        b=q5FDv0Px5CByb31Tweiv/B0gTqaGCser0iNxMIpsp59sZ2yunCpiuZ0O4jxGASqnYe
         EK1FuIH9YLdO29ogUUVb9wejJSHQ2rVSDwL2akrt8+2/bxdFNLUtCt05Sahao1VYB/3V
         +gVf4f/gHZ/oPFa02rGWSoHVlCIw/cEPQxw8+AA9LUD9N+th1l9P3/9BHkFqAJ9EAOE7
         2LKhvxmoVtQNWaWTU2ZLPmLQXKVwIpRezD8sP6Mwvt7f3gkeG/HPF9NrcZg/f5fiiCTW
         AEKfetEB5JBRjD7mtIZ849JJ5WRPtW6nhWZT8/a+KxZQTl+YlEBU3iyaxq7QIxa4nfxi
         NNEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=I8Fp/J9JBJVbIQwf58urq1qg0AO1zW6eUoOmoZ1bkg4=;
        b=fYen+QLicmN5PGlm6MYVWkK02jLKLPJEUleSXVbm1LNDbd1KJzj0Y3gxtztb0/CgsC
         z3Srhw7mH6JmeHB96gex71G3sQomFUHCD3cTYCWMchqd4ZyiqF06cyiHGB4EFV0K8liQ
         taQM012eW0uYkSx6b764np7in2dxsP/lTblRM1O850uNGv9rGtPpkWf0cdT237Mn3tFn
         cKIfUjyd9rrJvDj6imvGy7dtgKDbunLilweEBWxzOoidYS79FZrG2IcIWlzbvikdM7ko
         7TVxe+PxCB4Wh3yYK50bK9HC8uNrTqxeefAOZk1pEXN1dAl+jsT7T7i4DwbQNjL98E5u
         eFrA==
X-Gm-Message-State: AOAM531yODWwJEkpeLpTm+YfWBHcPKQK8bQVceu3dig6c82TX0AYPjl3
        QiWVNFllICZo07MZhn/Qg3n1Zg==
X-Google-Smtp-Source: ABdhPJzK2/EZPWI5J4c9DvBmSuWTO1Fq8jyEeOrDNsUftZ+Z9vuWVXwmsMbPwUEzI/gPyRwCUzFpnA==
X-Received: by 2002:a17:903:31cd:b0:158:542b:908d with SMTP id v13-20020a17090331cd00b00158542b908dmr15949247ple.16.1649838104069;
        Wed, 13 Apr 2022 01:21:44 -0700 (PDT)
Received: from localhost ([139.177.225.229])
        by smtp.gmail.com with ESMTPSA id o4-20020a625a04000000b004fdf5419e41sm33700162pfb.36.2022.04.13.01.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 01:21:43 -0700 (PDT)
Date:   Wed, 13 Apr 2022 16:21:40 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     "liupeng (DM)" <liupeng256@huawei.com>
Cc:     mike.kravetz@oracle.com, david@redhat.com,
        akpm@linux-foundation.org, yaozhenguo1@gmail.com,
        baolin.wang@linux.alibaba.com, liuyuntao10@huawei.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] hugetlb: Fix return value of __setup handlers
Message-ID: <YlaIFL8TCRfiFFgR@FVFYT0MHHV2J.usts.net>
References: <20220413032915.251254-1-liupeng256@huawei.com>
 <20220413032915.251254-4-liupeng256@huawei.com>
 <YlaCA6kqjN5nYNSH@FVFYT0MHHV2J.usts.net>
 <5bbf45e7-1d92-f543-5cfc-bc0141999d46@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5bbf45e7-1d92-f543-5cfc-bc0141999d46@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 04:16:11PM +0800, liupeng (DM) wrote:
> 
> On 2022/4/13 15:55, Muchun Song wrote:
> > On Wed, Apr 13, 2022 at 03:29:14AM +0000, Peng Liu wrote:
> > > When __setup() return '0', using invalid option values causes the
> > > entire kernel boot option string to be reported as Unknown. Hugetlb
> > > calls __setup() and will return '0' when set invalid parameter
> > > string.
> > > 
> > > The following phenomenon is observed:
> > >   cmdline:
> > >    hugepagesz=1Y hugepages=1
> > >   dmesg:
> > >    HugeTLB: unsupported hugepagesz=1Y
> > >    HugeTLB: hugepages=1 does not follow a valid hugepagesz, ignoring
> > >    Unknown kernel command line parameters "hugepagesz=1Y hugepages=1"
> > > 
> > > Since hugetlb will print warning/error information before return for
> > > invalid parameter string, just use return '1' to avoid print again.
> > > 
> > Can't return -EINVAL? It is weird to return 1 on failure.
> > 
> > Thanks.
> > 
> > .
> 
> Not against "return -EINVAL", but consistent with:
> 1d02b444b8d1 ("tracing: Fix return value of __setup handlers")

I think it is better not return 1.  I don't think it's a good habit we
should follow.

Thanks.

Thanks.
