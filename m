Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B82F2524F1D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 16:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354659AbiELOAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 10:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354887AbiELN75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 09:59:57 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD5025B07D
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:59:50 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id q18so4929586pln.12
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 06:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3kOJe+H/ERTxI6v7eeqIA23qR8YVOZADC2y1mDVL6Wc=;
        b=ITK30V0ZUC+q2vylMd4KbId4Ew0IpXXKdRnB/uGG7YT+A58FXfW/a49f3+jEpj8OLj
         ANtE9V9zqSriZ7nDoXMGOR+o1WOd1YCUZOZQ+0jXTCIh5d0w+wPfiu7D+E60dcEn1Bfj
         WpRdRmKZ0IypCClA3wBKR8kaS4XwaFIxUsawG8rFxliw05T5hJOQwDZ1UP1PTRTkKN6q
         JLOhsyUwF4CsADHQAFrXQu7nHj3FYLiVcxR2ZtYAolcM7YCSNK0Sh5lqTRm+Lxl2GgDA
         FwwiM0BzoiPCiV/y2qGsw7rRvvgD/i7s0jxPbGGmVVt+1nNsNvoiz1RDXgwb47nBaAvd
         RheA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3kOJe+H/ERTxI6v7eeqIA23qR8YVOZADC2y1mDVL6Wc=;
        b=OuuNdfTdK2PKqLlJH5Ku6pZvxFyKueqhqZO/mOICdSshbgloJBwXhq4r1SI8DZDtHS
         RcE/AEKwlasZ7pjtqBVhII1D2GqTxBtLRY1wu8DGmu7kUBHodQ73Kn6FvY+JkG810HCF
         6qRrqoFbD0JFCLUlcZbyCNEV/ZXkIc4IZeLFZ7/KLfrMLyHI5qEKLv5qbyjE0WrJYkAx
         6pfcq0MH0oHmZNpBtcMlUcd+z4tUZOTwomC4v67jrAjss0Bphx+ZZsOMcsgJU0Ewmd1I
         XlCMKDnUWp5t5c5VBZGH4/SLj5O/jTGzqmCr/CifpKwbR5Qc2TNBqdgBizf0p55eTaKg
         1Uxg==
X-Gm-Message-State: AOAM530Gn6Sd6Rv/dSCp4IdIlv8u3l2DSTy88pQdbdYpiBRtEJ2E9gmO
        I2/uyqsgtfkP1Moc2Dp8wLJqzg==
X-Google-Smtp-Source: ABdhPJx+vFO/jdauj2MQt/7gUdxpe2Sk1Zo72LFQJnNVksQfkJKJxnKxVLSTLyzoFNKL3X0NWLRj5A==
X-Received: by 2002:a17:902:ccc2:b0:15f:4acc:f202 with SMTP id z2-20020a170902ccc200b0015f4accf202mr1778237ple.3.1652363990352;
        Thu, 12 May 2022 06:59:50 -0700 (PDT)
Received: from localhost ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id a8-20020aa78e88000000b0050dc76281bfsm3748854pfr.153.2022.05.12.06.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 06:59:49 -0700 (PDT)
Date:   Thu, 12 May 2022 21:59:37 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     corbet@lwn.net, mike.kravetz@oracle.com, akpm@linux-foundation.org,
        mcgrof@kernel.org, keescook@chromium.org, yzaikin@google.com,
        osalvador@suse.de, masahiroy@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, smuchun@gmail.com
Subject: Re: [PATCH v10 2/4] mm: memory_hotplug: override memmap_on_memory
 when hugetlb_free_vmemmap=on
Message-ID: <Yn0SyaqfS2YZ8kO/@FVFYT0MHHV2J.usts.net>
References: <20220509062703.64249-1-songmuchun@bytedance.com>
 <20220509062703.64249-3-songmuchun@bytedance.com>
 <ebffd794-697b-9bf1-f41b-4b2d52c100fc@redhat.com>
 <Yn0Ck5isxx4ghQi6@FVFYT0MHHV2J.usts.net>
 <284eec3f-a79d-c5f0-3cd6-53b8e64100cd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <284eec3f-a79d-c5f0-3cd6-53b8e64100cd@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 03:04:57PM +0200, David Hildenbrand wrote:
> On 12.05.22 14:50, Muchun Song wrote:
> > On Thu, May 12, 2022 at 09:36:15AM +0200, David Hildenbrand wrote:
> >> On 09.05.22 08:27, Muchun Song wrote:
> >>> Optimizing HugeTLB vmemmap pages is not compatible with allocating memmap on
> >>> hot added memory. If "hugetlb_free_vmemmap=on" and
> >>> memory_hotplug.memmap_on_memory" are both passed on the kernel command line,
> >>> optimizing hugetlb pages takes precedence. 
> >>
> >> Why?
> >>
> > 
> > Because both two features are not compatible since hugetlb_free_vmemmap cannot
> > optimize the vmemmap pages allocated from alternative allocator (when
> > memory_hotplug.memmap_on_memory=1). So when the feature of hugetlb_free_vmemmap
> > is introduced, I made hugetlb_free_vmemmap take precedence.  BTW, I have a plan
> > to remove this restriction, I'll post it out ASAP.
> 
> I was asking why vmemmap optimization should take precedence.
> memmap_on_memory makes it more likely to succeed memory hotplug in
> close-to-OOM situations -- which is IMHO more important than a vmemmap
> optimization.
>

I thought the users who enable hugetlb_free_vmemmap value memory
savings more, so I made a decision in commit 4bab4964a59f.  Seems
I made a bad decision from your description.
 
> But anyhow, the proper approach should most probably be to simply not
> mess with the vmemmap if we stumble over a vmemmap that's special due to
> memmap_on_memory. I assume that's what you're talking about sending out.
>

I mean I want to have hugetlb_vmemmap.c do the check whether the section
which the HugeTLB pages belong to can be optimized instead of making
hugetlb_free_vmemmap take precedence.  E.g. If the section's vmemmap pages
are allocated from the added memory block itself, hugetlb_free_vmemmap will
refuse to optimize the vmemmap, otherwise, do the optimization.  Then
both kernel parameters are compatible.  I have done those patches, but
haven't send them out.

Thanks.

