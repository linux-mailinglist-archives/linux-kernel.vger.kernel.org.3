Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50A84B06B1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 07:53:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235495AbiBJGwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 01:52:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232439AbiBJGwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 01:52:47 -0500
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E9321B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 22:52:48 -0800 (PST)
Received: by mail-qk1-x736.google.com with SMTP id m25so3910256qka.9
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 22:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=kQLstrcYL5Y3s8HLEVH3WhFFkmRMPkeyalWeq1ayvQY=;
        b=aZa+ex8kUhxoEf93Rpfkogg0c2V3ZUMwqZ3tjFYBQ7vNaqUEf3ZVfgHGPwderTtUBs
         73ZxBwbT8mhrBrVjHSe3Fh4z+z7WXuREiq9pm+hASi0HlTmHu0DvTJB1H0MA1QEmStyR
         C7O6nIfOM3BuZ1zOT7iHEpThGxx6Opm+GF5f/tPe7Dq8pPJzAk6JyyZZEtE8Cl/0zb+m
         qIOEztKMlAgfqWCUp40t/MlK7boJUW5Sm1m0nxgIj1aXVHQk8ACCUgONkJ+vh++cqirw
         QFavfkfClObM+L33fuCbu08aNKw2NZYBeFMCbxpmMfyCWINI3KUk1JKGRd4NJOIt8lz9
         u5iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=kQLstrcYL5Y3s8HLEVH3WhFFkmRMPkeyalWeq1ayvQY=;
        b=mxj6QRgxYLBDDvqWhyBDLhPXEEcFNnrwkzqRDhnfCT5JqPyQYFQe9+jPvf19Qnnt12
         IoLvhEGJQUF+mW3S6wbqlbcDRo78JL97BfgB+9nQwg9LvDQbGmwt0VM/pxHQHwJXKHIy
         adkcnNqwKrNQr1NWP6+ScK7Sf2aBoedGDFzCH24KYSoCl5NxRWCi3cMl4UhiljenFfV9
         eBHpj3v1qFXLwTh6W4RlBj75Pcm0sZVhRuoStSjM6ltGZ/3QPaOjcBq0+LwN1YBXe3MN
         6XgrHQ2YDloUCwWDV11OEAQ5rZYUIZ7FzSbCgOdYZFwufVGQtt2XHDQKb+XCezL+wYO6
         j0nw==
X-Gm-Message-State: AOAM5307YFHE1s10CQHdpS9HPmirCFe0oCYDIQ6/8E/VUREBGlk9EdDf
        08Yz100m1GOZDd+hR9tyZFs=
X-Google-Smtp-Source: ABdhPJwEVCv4xERtCmPdj9D/GjlqtwAtpfjYdVSecm3FPIm6Llpbnk3Y4WdT8pkP5lpFpcmdbdbLXQ==
X-Received: by 2002:a37:44d:: with SMTP id 74mr3100471qke.328.1644475967895;
        Wed, 09 Feb 2022 22:52:47 -0800 (PST)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id k9sm9433007qkj.31.2022.02.09.22.52.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 22:52:47 -0800 (PST)
Message-ID: <6204b63f.1c69fb81.6011.2908@mx.google.com>
X-Google-Original-Message-ID: <20220210065244.GA1607307@cgel.zte@gmail.com>
Date:   Thu, 10 Feb 2022 06:52:44 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>,
        ran.xiaokai@zte.com.cn, wang.yong12@zte.com.cn
Subject: Re: [PATCH] psi: Treat ksm swapping in copy as memstall
References: <20220116152150.859520-1-yang.yang29@zte.com.cn>
 <YeVdvVVBvrXH5U0L@cmpxchg.org>
 <61e7ac25.1c69fb81.e8938.bc67@mx.google.com>
 <YegK7+oKFG8EPRp9@cmpxchg.org>
 <61ea820f.1c69fb81.e79d5.09c9@mx.google.com>
 <YfNG5KAog6fI0kYu@cmpxchg.org>
 <61f35591.1c69fb81.48dad.3244@mx.google.com>
 <72532675-d898-9f30-1ba4-318fbd61786@google.com>
 <62026b89.1c69fb81.b9102.7042@mx.google.com>
 <11c8fcd3-58fc-77f4-addb-18d3a52b51a7@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11c8fcd3-58fc-77f4-addb-18d3a52b51a7@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 09:55:48PM -0800, Hugh Dickins wrote:
> On Tue, 8 Feb 2022, CGEL wrote:
> > On Mon, Feb 07, 2022 at 07:22:22PM -0800, Hugh Dickins wrote:
> > > On Fri, 28 Jan 2022, CGEL wrote:
> > > > On Thu, Jan 27, 2022 at 08:29:08PM -0500, Johannes Weiner wrote:
> > > > > On Fri, Jan 21, 2022 at 09:51:08AM +0000, CGEL wrote:
> > > > > >  Wed, Jan 19, 2022 at 07:58:23AM -0500, Johannes Weiner wrote:
> > > > > > > On Wed, Jan 19, 2022 at 06:13:54AM +0000, CGEL wrote:
> > > > > > > > I did a test, when we use zram, it takes longer time for ksm copying than
> > > > > > > > swap_readpage(). Ksm copying average takes 147263ns, swap_readpage()
> > > > > > > > average takes 55639ns. So I think this patch is reasonable.
> > > > > > > 
> > > > > > > Ok, that sounds reasonable to me as well. Please add the
> > > > > > > PageWorkingset() check and resubmit the patch. Thanks!
> > > > > > I am a litte confused about adding PageWorkingset(), since I
> > > > > > think ksm_might_need_to_copy() memstall is like swap_readpage()
> > > > > > memstall and swap_readpage() doesn't add PageWorkingset().
> > > > > 
> > > > > That's actually a bug! It should do that.
> > > > I recently found that too. Please CC to me your new patch, thanks!
> > > > And I will send V2 of this patch "psi: Treat ksm swapping in copy
> > > > as memstall" with PageWorkingset().
> > > 
> > > I'm entirely PSI-ignorant, and reluctant to disagree with Johannes,
> > > but I don't see how your patch to ksm_might_need_to_copy() could be
> > > correct - maybe the "swapping" in your subject is confusing.
> > > 
> > > There is no PSI enter and exit around the page allocation and copying
> > > in wp_page_copy(), so why in the analogous ksm_might_need_to_copy()?
> > >
> > I think it's two questions, first why PSI didn't treat wp_page_copy() as
> > memstall, second why should PSI treat ksm_might_need_to_copy() as memstall.
> > 
> > The first question is unrelated with this patch. I think the reason is PSI
> > focous on memory contending(see Documentation/accounting/psi.rst), and
> > wp_page_copy() is not caused by memory contending. Actually wp_page_copy()
> > will still be called if memory is not contending.
> 
> Agreed.
> 
> > 
> > For the second question, ksm_might_need_to_copy() is called only becaused
> > of swapping, and swap is caused by memory contending, so PSI better treat
> > it as memstall.
> 
> But there I'm not at all convinced.
> 
>  * psi_memstall_enter - mark the beginning of a memory stall section
>  * @flags: flags to handle nested sections
>  *
>  * Marks the calling task as being stalled due to a lack of memory,
>  * such as waiting for a refault or performing reclaim.
> 
> psi_memstall_enter() will have been called if do_swap_page() had to
> read back from swap or wait on page lock; and psi_memstall_enter()
> will be called if ksm_might_need_to_copy()'s alloc_page_vma() or
> mem_cgroup_charge() goes into page reclaim.  Being stalled due to
> a lack of memory is fully covered there.
PSI counts "read back from swap time" as memstall time, because the
reason why we had to "read back from swap" is memory contending had
happened before and caused swap out. ksm_might_need_to_copy() is just
like it, we had to do this copy because of swap out happened before,
not because ksm_might_need_to_copy() may goes into page reclaim. And
if page reclaim happens, doesn't matter, psi_memstall_enter() will
handle nested sections.

> Your argument is that copy_user_highpage() is a significant overhead
> (but not a memstall), and it might have been avoided if there was
> no KSM or no swapping - though doing the copy there often(?) saves
> doing the wp_page_copy() when do_swap_page() goes on to do_wp_page()
> (and that one you're not asking to count).
"Doing the copy" doesn't always means "saves doing the wp_page_copy()".
For example, if there is no FAULT_FLAG_WRITE flag. What about we only
count this case as memstall: ksm_might_need_to_copy() do the copy and
not "saves doing the wp_page_copy()"? As this copy takes 2 times longer
than swap_readpage() when use zram(see early mail on this maillist),
we'd better not just leave it.

> I can understand you wanting to keep track of page copying overhead;
> and I've grown uneasy recently about the way CONFIG_KSM=y can add a
> ksm_might_need_to_copy() overhead for pages which never went near KSM;
> but I still don't see how psi_memstall is appropriate here.
For "ksm_might_need_to_copy() overhead for pages which never went near KSM",
is there a plan to optimize it? Or should I work on this?

Thanks.

> Hugh
