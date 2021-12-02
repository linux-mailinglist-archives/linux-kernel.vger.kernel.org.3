Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A89E4668C4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 18:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359835AbhLBRD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 12:03:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359813AbhLBRD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:03:57 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7155C06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 09:00:34 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id m17so45443qvx.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 09:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kbxwA3sKQ3VoXVlinWMZnniVnpttzpOT0znWtoAppcQ=;
        b=QcPmHVO5lAA/QTFeN3tFY0aYSNlJe0K3oiAx+Do8XqwGbTOeaZtSfwWnO+/gzfT7R7
         uqhLZ92dKDZzytkEgVKaJSUU3YHoT/vjRYObGqLVSyM7yIs62wSQ8Pvmunpqu7PeNzX5
         7PUJIOCrp7762zd/givR04oHd5nL5dQky1K2AUx3NCuRJWJotwBeNM45SeLtqbIjm9Kq
         lTWRnirQSSdYOdKpmmoNqfL3WOJTga/kJEKCLj+KcjWYRkeZQ3aGyshIjyRq2dNE/FXu
         fcqAj0/VFA05P+uKMNosQv/o3TdsHpzaTlpLTy67NqBZotIDtHtqEi/azkwgmAtwPRub
         rSFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kbxwA3sKQ3VoXVlinWMZnniVnpttzpOT0znWtoAppcQ=;
        b=3BD4OREPyAkz5esqbSlMdFidrvb7vEFyOQIS1rJqEb+1ph22A0AIEMCMDHN9qYZRNf
         d3p8jY4xU3R0sQJNfI46MMnraKu53PkEQ/kEsZX8c+QOYo+jft3h6xGQjpQWfGLu4ECB
         Tef3kii0WN/eYs+JWuiJB98DAjSI4/EOoOQ3S01b6E/5TTqPTpJgBzlH9sHPR57B7s9j
         RGsMjkug9h7LTSiLwlqelTZD2HScni8h2jrWiukZY+aO45lQOaCF4yVbwk2UsqDP3dpL
         vxFPLMxygSHmLWnWJKzfCxtbrwoUXZuEWT5s2wfUQEA4J1FP2QCAz4llZs+bCm2vYV51
         DrAw==
X-Gm-Message-State: AOAM530Pu5DLtlpSnjKhClRJdxyv1uplTf0YdCGq7/oNaCCnHH16iNT9
        zmGdBg49rFlHQydBZ2dCeGwryw==
X-Google-Smtp-Source: ABdhPJzO9oFxXAyQcrmDiRj9xkoyqtrbKrukesQ7GrY6BtK7F42G6UcjyCUO6WC60QJn/7zM+JX/Vg==
X-Received: by 2002:a05:6214:1d03:: with SMTP id e3mr14469202qvd.61.1638464433983;
        Thu, 02 Dec 2021 09:00:33 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id bp38sm264091qkb.66.2021.12.02.09.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 09:00:33 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mspRg-0071lx-DU; Thu, 02 Dec 2021 13:00:32 -0400
Date:   Thu, 2 Dec 2021 13:00:32 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Leon Romanovsky <leon@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Bixuan Cui <cuibixuan@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        w@1wt.eu, keescook@chromium.org
Subject: Re: [PATCH -next] mm: delete oversized WARN_ON() in kvmalloc() calls
Message-ID: <20211202170032.GN5112@ziepe.ca>
References: <1638410784-48646-1-git-send-email-cuibixuan@linux.alibaba.com>
 <20211201192643.ecb0586e0d53bf8454c93669@linux-foundation.org>
 <Yajk/oVypyUFTtgd@unreal>
 <YajmawzehKqR+j0v@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YajmawzehKqR+j0v@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 03:29:47PM +0000, Matthew Wilcox wrote:
> On Thu, Dec 02, 2021 at 05:23:42PM +0200, Leon Romanovsky wrote:
> > The problem is that this WARN_ON() is triggered by the users.
> 
> ... or the problem is that you don't do a sanity check between the user
> and the MM system.  I mean, that's what this conversation is about --
> is it a bug to be asking for this much memory in the first place?
>
> > At least in the RDMA world, users can provide huge sizes and they expect
> > to get plain -ENOMEM and not dump stack, because it happens indirectly
> > to them.
> > 
> > In our case, these two kvcalloc() generates WARN_ON().
> > 
> > 		umem_odp->pfn_list = kvcalloc(
> > 			npfns, sizeof(*umem_odp->pfn_list), GFP_KERNEL);
> 
> Does it really make sense for the user to specify 2^31 PFNs in a single
> call?  I mean, that's 8TB of memory.  Should RDMA put its own limit
> in here, or should it rely on kvmalloc returning -ENOMEM?

I wrote this - I don't think RDMA should put a limit here. What
limit would it use anyhow?

I'm pretty sure database people are already using low TB's here. It is
not absurd when you have DAX and the biggest user of ODP is with DAX.

If anything we might get to a point in a few years where the 2^31 is
too small and this has to be a better datastructure :\

Maybe an xarray and I should figure out how to use the multi-order
stuff to optimize huge pages?

I'd actually really like to get rid of it, just haven't figured out
how. The only purpose is to call set_page_dirty() and in many cases
the pfn should still be in the mm's page table. We also store another
copy of the PFN in the NIC's mapping. Surely one of these two could do
instead?

Jason
