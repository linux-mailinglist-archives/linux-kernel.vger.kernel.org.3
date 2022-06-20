Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B5E551433
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 11:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238800AbiFTJXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 05:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232112AbiFTJXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 05:23:40 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22A210FDF
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:23:37 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id m14so9220527plg.5
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 02:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=11nWdGNlsQJ8vwCvZcAwcBHvFY1NzaLJmvwQzAih1gM=;
        b=2ZksTczO7IcXLOn9SMjLbhINTewvTIZBAL10rFjdHN3O0AfPngKKMPjMd5sIBYrAf7
         rYraqo09tc5i1VGDBUTl0/9JBmAFqHTXN87CF9RcNmsMMPpvgq5YOht9nHzagyVef/q5
         bRL7VF2R1R4FtWb1TWTy512XTk+jEzSKdpQ8M5DYrAWNiaViCTO8cohbX/68v5OTD2jP
         Cf4QWu1AFiiHB0pyLaAxDCMCqTnvmtPQQbpna6qbcy/+3nAReVUNRBxTUh93G3dJum5n
         XQrgGel0WcJWu+r5BHPIA9bY8r2HA/VA/0Ze+C3UFKV/eeLj2cRnFnvWRdk5TXA85X0o
         MFfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=11nWdGNlsQJ8vwCvZcAwcBHvFY1NzaLJmvwQzAih1gM=;
        b=brWEytPTNoiXBOrta8oDDHSAn5hZuPLkJQ+OzM4Z7IyXrnShbwgOBYYsGMblpjQ6OO
         UyZmR0rncplQXyrGPxauqwGZMHqEC9fos5i801wexVj2D5oGQaR6kjoMzb6rqfxu5Zre
         fE/i7rEp4JtR8pQgSuzQAWZG5CaOXjYbqyNZnjpRuyLXfqSS071cavHpnGvSW9ygZa5G
         jHpiJmLBBAp9Ps74C2Rg0V70H9DS5O4B1SMk23iwrt67i56EPtC8TGBL/vUj/8w8l96X
         UOPT+oWRZ9yOpxlXehUUIEQMVTMrctXTjVEy3ijW6qmdGUt6iWX6U2iiwBA4aLXWys+M
         iuLw==
X-Gm-Message-State: AJIora/MuKzhYKRAFDblH6LjZTjKTWrDnMMWLkh+uAWLSxoQLcBe5uvi
        1en+Yt5VLWGkm7W6m9qHohEMhg==
X-Google-Smtp-Source: AGRyM1vUciEh04cYv+l8ffsEX6mJJrvZ+FH/8h8W9Iqhy4GIJzEcnrNCBF7/0xOoJDuvsnKb+ccrbg==
X-Received: by 2002:a17:90b:1d90:b0:1e8:5a44:820e with SMTP id pf16-20020a17090b1d9000b001e85a44820emr25579499pjb.217.1655717017270;
        Mon, 20 Jun 2022 02:23:37 -0700 (PDT)
Received: from localhost ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id z14-20020a17090a540e00b001e095a5477bsm9946331pjh.33.2022.06.20.02.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jun 2022 02:23:36 -0700 (PDT)
Date:   Mon, 20 Jun 2022 17:23:31 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     "Huang, Ying" <ying.huang@intel.com>, akpm@linux-foundation.org,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] mm/swapfile: fix possible data races of
 inuse_pages
Message-ID: <YrA8kxavqsDfH5R7@FVFYT0MHHV2J.usts.net>
References: <20220608144031.829-1-linmiaohe@huawei.com>
 <20220608144031.829-3-linmiaohe@huawei.com>
 <87edzjrcq8.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <13414d6a-9e72-fb6c-f0a8-8b83ba0455de@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13414d6a-9e72-fb6c-f0a8-8b83ba0455de@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 05:04:50PM +0800, Miaohe Lin wrote:
> On 2022/6/20 15:54, Huang, Ying wrote:
> > Miaohe Lin <linmiaohe@huawei.com> writes:
> > 
> >> si->inuse_pages could still be accessed concurrently now. The plain reads
> >> outside si->lock critical section, i.e. swap_show and si_swapinfo, which
> >> results in data races. But these should be ok because they're just used
> >> for showing swap info.
> >>
> >> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >> Reviewed-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  mm/swapfile.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/mm/swapfile.c b/mm/swapfile.c
> >> index d2bead7b8b70..3fa26f6971e9 100644
> >> --- a/mm/swapfile.c
> >> +++ b/mm/swapfile.c
> >> @@ -2646,7 +2646,7 @@ static int swap_show(struct seq_file *swap, void *v)
> >>  	}
> >>  
> >>  	bytes = si->pages << (PAGE_SHIFT - 10);
> >> -	inuse = si->inuse_pages << (PAGE_SHIFT - 10);
> >> +	inuse = READ_ONCE(si->inuse_pages) << (PAGE_SHIFT - 10);
> >>  
> >>  	file = si->swap_file;
> >>  	len = seq_file_path(swap, file, " \t\n\\");
> >> @@ -3265,7 +3265,7 @@ void si_swapinfo(struct sysinfo *val)
> >>  		struct swap_info_struct *si = swap_info[type];
> >>  
> >>  		if ((si->flags & SWP_USED) && !(si->flags & SWP_WRITEOK))
> >> -			nr_to_be_unused += si->inuse_pages;
> >> +			nr_to_be_unused += READ_ONCE(si->inuse_pages);
> >>  	}
> >>  	val->freeswap = atomic_long_read(&nr_swap_pages) + nr_to_be_unused;
> >>  	val->totalswap = total_swap_pages + nr_to_be_unused;
> > 
> > READ_ONCE() should be paired with WRITE_ONCE().  So, change the writer
> > side too?
> 
> READ_ONCE() is used to fix the complaint of concurrent accessing to si->inuse_pages from KCSAN here.
> The similar commit is 218209487c3d ("mm/swapfile: fix data races in try_to_unuse()"). IMHO, it's fine

I think the fix 218209487c3d is incomplete. The write side in swap_range_free() should
also be fixed. Otherwise, IIUC, it cannot stop KCSAN complaining.

> to see a not-uptodate value of si->inuse_pages because it's just used for showing swap info. So
> WRITE_ONCE() is not obligatory. Or am I miss something?
> 
> > 
> > Best Regards,
> > Huang, Ying
> 
> Thanks!
> 
> > .
> > 
> 
> 
