Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7622489C3C
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbiAJPbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:31:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236213AbiAJPbH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:31:07 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EF6C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 07:31:07 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id h4so2911426qth.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 07:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NHs+ZRg9gtWg5UuhR9O+Iz5CnWEf4bkCRZd4AfMolXA=;
        b=jpZc39wrjW1coHSL/Dr+B8gik5rjLFG9s7T9rympPYqEMTzbUbc87EyYUmXiiRRXPJ
         koypIp1OKYLHUTle6s09LfU9M8R8x5SJ11v+UeGbe/+1e/PXPucInFPB/003vbz1afbN
         PFR9GIWbmAukQymGvlhTXQMDFA7T9WKpk6EqAo6/xYutZc/RI+ebMJPuim85PBYo2mJV
         osKcla6YtCPJUYn4J/8+83TgkarsAFzXYlW6fT+o+Po9fEsROsC8AH+2p5SdaNTSbYig
         5C3rygNnDA04obYGdGtb/wsqvp4h4S7khPAt8169YDy2OITWXraFVtfLiOX6u8ddTJzn
         vD2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=NHs+ZRg9gtWg5UuhR9O+Iz5CnWEf4bkCRZd4AfMolXA=;
        b=cuk02RwLmNDE/V5TyG/wp/TFLTimSUDby86SPvwMzklYkVrhgjRaTAqS2TSBq3q2Dj
         Z3Ze8+fCAPWTj5klUmuttH9xARKsOmyMewj2/vbNbwcW8ujZCv+76fB7TIiitz1OqIng
         4p8gCec2yQU/Z2Mn04/6Ml3ba19KiI9Ztu/uLo/qJs1fmDzLRjwWpkcaLgnPiU3FqVIG
         VEwlP1p5njCygSQPlba2k6m3jr+QcTnlTwd3NHyxadBQlooqUpoPnggR0QX8IuIvR5GF
         I+ZqpOvxVMbnN0QatGcjy1c/k5KRNgRqSTTLogbve9Cw7VqhOcb/iPq3v0h6LMflsWjM
         Kpvg==
X-Gm-Message-State: AOAM532ayAqQEmeEw4L9fIN5pk6SdIpASEMFbwdGKNBTniZDIencZcby
        YDEly5bEvOhamU90xE+ZlfE5Nw==
X-Google-Smtp-Source: ABdhPJz6O/sZ+nA4Hl6ptpUDFw0RagoR29DfPCnVFtdn9tAvTnbFrVca8vWtPG8GWa137RRqWN943w==
X-Received: by 2002:ac8:7d08:: with SMTP id g8mr163619qtb.573.1641828664786;
        Mon, 10 Jan 2022 07:31:04 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id a16sm4624081qta.13.2022.01.10.07.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 07:31:04 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1n6wdT-00Dp3D-Pz; Mon, 10 Jan 2022 11:31:03 -0400
Date:   Mon, 10 Jan 2022 11:31:03 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/28] Convert GUP to folios
Message-ID: <20220110153103.GH6467@ziepe.ca>
References: <20220110042406.499429-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110042406.499429-1-willy@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, Jan 10, 2022 at 04:23:38AM +0000, Matthew Wilcox (Oracle) wrote:
> This patch series is against my current folio for-next branch.  I know
> it won't apply to sfr's next tree, and it's not for-next material yet.
> I intend to submit it for 5.18 after I've rebased it to one of the
> 5.17-rc releases.
> 
> The overall effect of this (ignoring the primary "preparing for folios
> that are not PAGE or PMD sized" purpose) is to reduce the size of gup.o
> by ~700 bytes in the config I normally test with.
> 
> This patchset just converts existing implementations to use folios.
> There's no new API for consumers here to provide information in a more
> efficient (address, length) format.  That will be a separate patchset.
> 
> In v2, I've tried to address all the comments from the reviews I got
> on v1.  Apologies if I missed anything; I got a lot of good feedback.
> Primarily I separated out the folio changes (later) from the "While
> I'm looking at this ..." changes (earlier).  I'm not sure the story
> of the patchset is necessarily coherent this way, but it should be
> easier to review.
> 
> Another big change is that compound_pincount is now available to all
> compound pages, not just those that are order-2-or-higher.  Patch 11.
> 
> I did notice one bug in my original patchset which I'm disappointed GCC
> didn't diagnose:
> 
> 		pages[nr++] = nth_page(page, nr);
> 
> Given the massive reorg of the patchset, I didn't feel right using
> anyone's SoB from v1 on any of the patches.  But, despite the increased
> number of patches, I hope it's easier to review than v1.
> 
> And I'd dearly love a better name than 'folio_nth'.  page_nth() is
> a temporary construct, so doesn't need a better name.  If you need
> context, it's in the gup_folio_range_next() patch and its job
> is to tell you, given a page and a folio, what # page it is within
> a folio (so a number between [0 and folio_nr_pages())).

folio_tail_index() ?

Series still looks good to me, though I checked each patch
carefully than the prior series:

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
