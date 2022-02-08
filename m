Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF8B4AD9A1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 14:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359750AbiBHNV4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 08:21:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376458AbiBHNJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 08:09:33 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA4DC03FECE
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 05:09:31 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id o5so6311828qvm.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 05:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=/s8FiFoNXLlWJsEmo8dsRXHngSoVZR77SSlKzOXt7DI=;
        b=QohgGiltFrcaDVrGMMj2PZ8boBvyEj0cqCLWL7vcz5XGkiAJ0tuv/Z5UkNsIOyiwMG
         aaKAT8a83xmJsTJ2pcdAOOM6ZXTv9b8fqJxtB4wP0yuKrBJCSBsfJJkhRFQuwm/1ciE5
         QqqanCkfFbGJbk264uR9ysMViQXC5fqWfzFvhaxCkMikCe82TMerVEOOxDK0L3kGNATY
         1f5BxY7lD44t7ZoYNXCNTyY+eVSjDyXfRcrzt7G27POwqZYhmCu2pveGJxzCkv3Y6x+C
         QTfNUvr8z8I9gPr2hqMHsUTz/VwjPKB51GdPoRFXEXJQ29/J3UxIYjfQh8R66g9h/ZU5
         oAcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=/s8FiFoNXLlWJsEmo8dsRXHngSoVZR77SSlKzOXt7DI=;
        b=5rULkR3fkNb0blHZWkxF9tEaccrNcsBvgCWlVWe3OzdmRi6Jx1YujAQZjR5PTGxqam
         WoQMdNFyKfjGDnDlCmGUc6VUij7K4nfC4fJjZGNEhs9qTLOJp5yK0VbPuR62aR5R9KmG
         XHGLFqWh7Gfq1YevCTJpzOozumTgOky/NOQudIXG2oWOzl0bL+AKpSZTB3ckc03GLvBD
         JXS11mEVrVF7RoNaAQjrCmvVMRGOrJiC3cw4wH50a6q2EtGeEpUuM9q1UVcOrGIspoY4
         f4vI9B7hrI3ZvUWdveMRQbIBC2VGqQS54bh4oUupNBYpwlIz/IYRblQ7tX7nDa+D7s2q
         QpMg==
X-Gm-Message-State: AOAM533ADF5ysr7ba5bkEDDQpQVdyLaD9FU1BYhefS1vRuyMTp5/7Hlu
        kKOvxAa7hMHrb4wisl4kRf0=
X-Google-Smtp-Source: ABdhPJxub5M8X2BfoYXJ/OcdvPF/ttHYF+U/7kF+/8iFMr+Mhgsh7qFlN9/MWHAE93sNGZBtdzD3yg==
X-Received: by 2002:a05:6214:b66:: with SMTP id ey6mr2827201qvb.131.1644325770607;
        Tue, 08 Feb 2022 05:09:30 -0800 (PST)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id q12sm7657455qtx.51.2022.02.08.05.09.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Feb 2022 05:09:29 -0800 (PST)
Message-ID: <62026b89.1c69fb81.b9102.7042@mx.google.com>
X-Google-Original-Message-ID: <20220208130926.GA1537772@cgel.zte@gmail.com>
Date:   Tue, 8 Feb 2022 13:09:26 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH] psi: Treat ksm swapping in copy as memstall
References: <20220116152150.859520-1-yang.yang29@zte.com.cn>
 <YeVdvVVBvrXH5U0L@cmpxchg.org>
 <61e7ac25.1c69fb81.e8938.bc67@mx.google.com>
 <YegK7+oKFG8EPRp9@cmpxchg.org>
 <61ea820f.1c69fb81.e79d5.09c9@mx.google.com>
 <YfNG5KAog6fI0kYu@cmpxchg.org>
 <61f35591.1c69fb81.48dad.3244@mx.google.com>
 <72532675-d898-9f30-1ba4-318fbd61786@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72532675-d898-9f30-1ba4-318fbd61786@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 07:22:22PM -0800, Hugh Dickins wrote:
> On Fri, 28 Jan 2022, CGEL wrote:
> > On Thu, Jan 27, 2022 at 08:29:08PM -0500, Johannes Weiner wrote:
> > > On Fri, Jan 21, 2022 at 09:51:08AM +0000, CGEL wrote:
> > > >  Wed, Jan 19, 2022 at 07:58:23AM -0500, Johannes Weiner wrote:
> > > > > On Wed, Jan 19, 2022 at 06:13:54AM +0000, CGEL wrote:
> > > > > > I did a test, when we use zram, it takes longer time for ksm copying than
> > > > > > swap_readpage(). Ksm copying average takes 147263ns, swap_readpage()
> > > > > > average takes 55639ns. So I think this patch is reasonable.
> > > > > 
> > > > > Ok, that sounds reasonable to me as well. Please add the
> > > > > PageWorkingset() check and resubmit the patch. Thanks!
> > > > I am a litte confused about adding PageWorkingset(), since I
> > > > think ksm_might_need_to_copy() memstall is like swap_readpage()
> > > > memstall and swap_readpage() doesn't add PageWorkingset().
> > > 
> > > That's actually a bug! It should do that.
> > I recently found that too. Please CC to me your new patch, thanks!
> > And I will send V2 of this patch "psi: Treat ksm swapping in copy
> > as memstall" with PageWorkingset().
> 
> I'm entirely PSI-ignorant, and reluctant to disagree with Johannes,
> but I don't see how your patch to ksm_might_need_to_copy() could be
> correct - maybe the "swapping" in your subject is confusing.
> 
> There is no PSI enter and exit around the page allocation and copying
> in wp_page_copy(), so why in the analogous ksm_might_need_to_copy()?
>
I think it's two questions, first why PSI didn't treat wp_page_copy() as
memstall, second why should PSI treat ksm_might_need_to_copy() as memstall.

The first question is unrelated with this patch. I think the reason is PSI
focous on memory contending(see Documentation/accounting/psi.rst), and
wp_page_copy() is not caused by memory contending. Actually wp_page_copy()
will still be called if memory is not contending.

For the second question, ksm_might_need_to_copy() is called only becaused
of swapping, and swap is caused by memory contending, so PSI better treat
it as memstall.

Thanks.
> Hugh
