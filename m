Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D72D524D8B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 14:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353990AbiELMwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 08:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354131AbiELMu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 08:50:56 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080F714091
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:50:41 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 202so4492393pgc.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 05:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=A0xOx0HJGPqe65kUT8EYAv7c6q9fmHkJFCQDDmRbELQ=;
        b=lwxhL4wAs6Qvzati4H2W524EGSAsQhuS3/nB5BZWZ4DEpD5RDkZvry5sMHYjaX/WEw
         y3U0PGPPxvMt6oD+WQwL4AHVAjGflqpa/Bt0K+pciJmSLHe+5NVj/LUGh9Dp1uTu01RQ
         znnBn8BAy0KGV9DBsyKUfoiT1Sy8QscSdPlY7DZUd03IdYvEkO6Y47GwahGKpBKZ4YS2
         oTFA9xVdwzp02a3nxDkp37gCPunfyYdIN3xquEjhbu1X9zZ+YpuOgWoeAIdpYVQZgq6F
         SqGFY/KIvGfMxFo6rKdQROw+56A0Hn0UjJNrM2h71EC59qap64VmDCAdMBoYbnUGbGLY
         +75w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=A0xOx0HJGPqe65kUT8EYAv7c6q9fmHkJFCQDDmRbELQ=;
        b=l4Gw8NJYwTvGyOx26g2bizTWpSC0rftOmIrbRlnY8Zx/Ky+p5s8BhIH8grQ0f8gzUF
         C7uuuN3bYN8Fi9JFx4hhmgEa3q5k4TF9a+Zy0jmcUc0OLIbRwDyGlP97lyKe8yyLDCG1
         BjAXON+No9hRrlbVfNnguVBwSrWpCW1f3a8ie0RZXSrq2ToUpx/eJpKdh5nexsmNRT/X
         4VqcafexZfVMVcqlg+aqtxEC713pH+LsQEtKWIj5BgiW5cUHjTPn44p13XKmlj7F33tY
         lhAeDveuVhUHNGRZTT1kZ911aYnAWfdanc1l4/RFg/0+fGTfyFOlMtFzV2HuBriRNJMy
         p4sQ==
X-Gm-Message-State: AOAM531DJd4z5qlZxwht/J9538slth+BL5kzJYrlrgkAZu4hGfsLvYjf
        N6H+0Z7Y0smB5KS3Cj1gCt8O3A==
X-Google-Smtp-Source: ABdhPJzD/auBmfoLWNxs2s5aGR2dmgOFqGv/Z5slJeRepfjx/hj1IpceD0OaHmBJGL5a2oxFasebMg==
X-Received: by 2002:a63:4549:0:b0:3db:5130:d269 with SMTP id u9-20020a634549000000b003db5130d269mr4372076pgk.101.1652359840481;
        Thu, 12 May 2022 05:50:40 -0700 (PDT)
Received: from localhost ([139.177.225.250])
        by smtp.gmail.com with ESMTPSA id i21-20020a170902e49500b0015e8d4eb20dsm3758677ple.87.2022.05.12.05.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 05:50:40 -0700 (PDT)
Date:   Thu, 12 May 2022 20:50:27 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, masahiroy@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v10 2/4] mm: memory_hotplug: override memmap_on_memory
 when hugetlb_free_vmemmap=on
Message-ID: <Yn0Ck5isxx4ghQi6@FVFYT0MHHV2J.usts.net>
References: <20220509062703.64249-1-songmuchun@bytedance.com>
 <20220509062703.64249-3-songmuchun@bytedance.com>
 <ebffd794-697b-9bf1-f41b-4b2d52c100fc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebffd794-697b-9bf1-f41b-4b2d52c100fc@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 09:36:15AM +0200, David Hildenbrand wrote:
> On 09.05.22 08:27, Muchun Song wrote:
> > Optimizing HugeTLB vmemmap pages is not compatible with allocating memmap on
> > hot added memory. If "hugetlb_free_vmemmap=on" and
> > memory_hotplug.memmap_on_memory" are both passed on the kernel command line,
> > optimizing hugetlb pages takes precedence. 
> 
> Why?
>

Because both two features are not compatible since hugetlb_free_vmemmap cannot
optimize the vmemmap pages allocated from alternative allocator (when
memory_hotplug.memmap_on_memory=1). So when the feature of hugetlb_free_vmemmap
is introduced, I made hugetlb_free_vmemmap take precedence.  BTW, I have a plan
to remove this restriction, I'll post it out ASAP.

Thanks.

