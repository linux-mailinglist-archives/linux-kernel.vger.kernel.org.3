Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A394EE13A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 21:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237987AbiCaTCH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 15:02:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237948AbiCaTCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 15:02:05 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7768C1BD9A6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 12:00:16 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id s11so404972pfu.13
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 12:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YCOslDIO/0W733/ujDklGbRX/ha6VpRvkSSUEoU714s=;
        b=nzw9o0AJLtRqnDYEvjxXTLiWlKWPs/MTqSc49MT79Nvi0jxqks7k/DYO3nbr+/O2MV
         xdNUqABzyfe3o+DPmH2ee8ccnTZyBR2yPKjOjzJpGF6TF5zLrLnHm/B5RXRf3HkkOcer
         p/YeAjvZaGsKXrWiKaqcsc3srAIykbXCJBxXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YCOslDIO/0W733/ujDklGbRX/ha6VpRvkSSUEoU714s=;
        b=uQFe68lLJmEDKLjRUEqWzv2mOn03oNzzhd7LIJScZ8qnWVDuojvbfoiyU5yUaEd21M
         wjSWecNf4md/X1klat1WhAWwfwEpG5GPz9/VOLLeMFOY4pUsrK+AltiY+9SbRFIcDziR
         G5QK2MF8n4Fc/QMcsBeErwm0ZXO5UIES3bgRSkwcyKg1w5S/NvgGLDsZprnaOwukELHz
         ycuknE6lw2aDqbC1Naa24FzCLWsJv+4Z0jHKCNLp3nchjvWCJGAQkcgfqaA7UpvVx7VV
         Hi9btaFM8LKvPhJAFmgsfzooeED+HqAy7vUgvkZWorIDik/QdiIl1E5oCMUD9glYkeBm
         8J8Q==
X-Gm-Message-State: AOAM5331ohJ3mb4rc+46jLRUh5iMud+UgcW58Ejm9tAqps6j2slIGFdR
        ybnq1K3AFZfur5q39OhYXv1MSg==
X-Google-Smtp-Source: ABdhPJwPAbG0pC/w9f4u+f4/nphD+UfXfd7YySe+QBeu9aUDnnXE9J1pLUD5Y3njX+cudadqUA6UPA==
X-Received: by 2002:a05:6a00:188f:b0:4fa:ece9:15d9 with SMTP id x15-20020a056a00188f00b004faece915d9mr7009932pfh.28.1648753215947;
        Thu, 31 Mar 2022 12:00:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s3-20020a056a00194300b004f6664d26eesm222905pfk.88.2022.03.31.12.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 12:00:15 -0700 (PDT)
Date:   Thu, 31 Mar 2022 12:00:15 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        David Hildenbrand <david@redhat.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Martin Oliveira <martin.oliveira@eideticom.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Minchan Kim <minchan@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Zi Yan <ziy@nvidia.com>
Subject: Re: [GIT PULL] hardening fixes for v5.18-rc1
Message-ID: <202203311157.F7FA779@keescook>
References: <202203311127.503A3110@keescook>
 <CAHk-=wjQ0+9jBy6bm850h1jms1tja8xnon4X5v0LSO4biLhFGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjQ0+9jBy6bm850h1jms1tja8xnon4X5v0LSO4biLhFGg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 11:49:42AM -0700, Linus Torvalds wrote:
> On Thu, Mar 31, 2022 at 11:35 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > Please pull these hardening fixes for v5.18-rc1. This addresses an
> > -Warray-bounds warning found under a few ARM defconfigs, and disables
> > long-broken CONFIG_HARDENED_USERCOPY_PAGESPAN.
> 
> Can't we just remove that HARDENED_USERCOPY_PAGESPAN thing entirely?
> 
> Yes, yes, I know Matthew did that as part of other patches that is too
> late to go in any more in this merge window, but just the removal
> patch is a no-brainer.

I can do that, but it seemed like more work for folks: a larger diff to
look at, and a rebase for Matthew or me. It's not MUCH more work, but
given the timing of the merge window, I wanted to have a minimal diff.

> IOW, why not just do the attached?

But I can certainly respin it, if you'd prefer?

-- 
Kees Cook
