Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 464824A4848
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 14:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378711AbiAaNgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 08:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378432AbiAaNgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 08:36:51 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBF8C06173D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 05:36:51 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id g13so12775265qvw.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 05:36:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=peHChX+dvslYcsfWY/zH1GowU+5RzB6143fTrnE3G1k=;
        b=FfYz3immfNmV2Ogq9ENoGUGQQehPwGA634TJY02OdFPo8zSOR4+aiae4kWBPbYUAjo
         cUKCyAiy9oVjQIu8ca2px+rsYMfFeyCKLWtWUrmOeioAx3rT9zCX/N8ESD0FBP7mON1u
         lo0EUlSrU4QyTEHtAqv0tklUx9c2MvvQNtR12CMxvP06BKOo243zDzN1BUw1lAKf4TUk
         6FXZz+ySNaw3UXYXhUc60HnVkC/QxXZ1S2p2bys3QwNqdfg9sVggE4QqG1W5UC8SAtHc
         B8StRzKL30QxPM/XX2Sp6CO5iu5LE9ZL16o9PFxBRDJFB4XWaQMOB3ByXS3rwavGHZzq
         a5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=peHChX+dvslYcsfWY/zH1GowU+5RzB6143fTrnE3G1k=;
        b=TLSVVehmSIlz+ClBfZW4TWEB5gYjdelRASGagl8YI8+rrTMz6GVnmjXAbw3/pvwzJZ
         TbI+q052hcaQTXXL+nkgn6yXrEdTz5RJTWCCsKI1lKu2vJkuDvVZ9ZhquuebfePkhzE2
         lAYPtEVlalMl+4NguRJ0i7rCWwePwtI8r/Eo5O2gzgdDb1jRul5lNfDmuD8Y4AQsuxTl
         H/mzTx/ENPfEZ57K5bKbiK7zWYueQAYfZzwYU0Y1jrWtUgk6WaZ4Nzv4Nc1EXBYjJoHQ
         evJDKKiArwXjqxyHHsZAYmVArQ2JxmiqLFd+KkypcQx6DNt6im6PWPHlTSV6I8PV36t/
         PQWA==
X-Gm-Message-State: AOAM533Y2U5oluSpjEtGSprEUcFt1ktMAwQaz/RFv5kBilGxxggRmD/M
        BVORVUL+glm2KjJ7V2cYz+7A7w==
X-Google-Smtp-Source: ABdhPJyJAFDRWh93YYkcOp0erQ9kaor7TK6x8MrA0tVsMQonos37ig40QR1WKbJaFxAvB+UkwsfTyw==
X-Received: by 2002:a05:6214:e8c:: with SMTP id hf12mr17115912qvb.68.1643636210280;
        Mon, 31 Jan 2022 05:36:50 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id i18sm8130480qka.80.2022.01.31.05.36.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 05:36:49 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nEWrR-009WBP-5e; Mon, 31 Jan 2022 09:36:49 -0400
Date:   Mon, 31 Jan 2022 09:36:49 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Peter Xu <peterx@redhat.com>, Jan Kara <jack@suse.cz>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Subject: Re: [PATCH 2/4] mm/gup: clean up follow_pfn_pte() slightly
Message-ID: <20220131133649.GX8034@ziepe.ca>
References: <20220131051752.447699-1-jhubbard@nvidia.com>
 <20220131051752.447699-3-jhubbard@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131051752.447699-3-jhubbard@nvidia.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 09:17:50PM -0800, John Hubbard wrote:
> Regardless of any FOLL_* flags, get_user_pages() and its variants should
> handle PFN-only entries by stopping early, if the caller expected
> **pages to be filled in.
> 
> This makes for a more reliable API, as compared to the previous approach
> of skipping over such entries (and thus leaving them silently
> unwritten).
> 
> Cc: Peter Xu <peterx@redhat.com>
> Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  mm/gup.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)

I still think it should be squashed into the previous path, but
otherwise

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
