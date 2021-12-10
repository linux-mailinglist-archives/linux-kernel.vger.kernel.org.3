Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0622646F99B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 04:25:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236397AbhLJD2m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 22:28:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236356AbhLJD2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 22:28:41 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669FBC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 19:25:07 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id r5so6894755pgi.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 19:25:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lwj5GPmvS/i6jbubM1T0W+RpRaDna2NMTbylhTRqghs=;
        b=jlUZsuD90bsxm/0B8NKZsmOmbJcWH2r6kjQtyR73t8o5UL7RriwY71ZtY8RO0+io8z
         M/0NwENtKjfJCg5EkLz7dgnPE1cS64xsz0iCfQTiDdEVBRuZAIYj4XiC+6fYKLKm+i+N
         GvyPdxnXAhopayQa845VVno+W0AVu92T9E4UUvy9Ro43s48ATKz/kRKQGqD94ZEUicC4
         NJo1KTTAcmcINC+M0umFy/Bkusy4eWtFYsi6DopLW+iKZ9gP091D5JF1eCQ6I61egX4s
         RryUu/WD871jAkcw9djnTEukyFEEDk41nfJnv/99sU0aALf0aN5GZctanx0hOIkTfoUX
         FUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=lwj5GPmvS/i6jbubM1T0W+RpRaDna2NMTbylhTRqghs=;
        b=UoWMA4A9J1doYajxa+SqghWwRnEJj/Mpf/WDOj8Gb9Cd3MNYW5hUBsxDXO3/YzfmGD
         /99rAR1ksv9Qi4nmhgsgxSmF29kI0Ttv/tBAPrh3XJX+UxS43i06SO5e0SZ59LTA3/tw
         4X7O+sM8KckxLa8/C/s85UgqNdA5riJd5KMca7dxbTPkyxf01/yx//hdp8GNCYhCq0GX
         2ZAlgdu0tUL+q9e8q85EHcqMDnBaPnXtWkg/j5phJkeF7y/jzSRexpmxhk+RKDFnjN1r
         k4VEAo94oDNt1EHCfvuva1Vm+gAHsm9COTi0uepgCueoksrUqDO1cU1/rIcGAWEOHKvS
         xIdw==
X-Gm-Message-State: AOAM532Bq7ECKoO5gR4jAEF60TQVjIihDkN4TcWGXUgfcpMYNyUUQO+2
        m/Mx0vUfA99jBAyx3ZV67JbFwNX7LSM=
X-Google-Smtp-Source: ABdhPJz8BRVYad2uWHre9t0yBMsCAfON+259789eDQMmI9H8vdOZP3lb5Cb/4qsQQ4aVD9kZQEtKew==
X-Received: by 2002:a05:6a00:ad0:b0:4a3:1056:e2ae with SMTP id c16-20020a056a000ad000b004a31056e2aemr15441245pfl.2.1639106706893;
        Thu, 09 Dec 2021 19:25:06 -0800 (PST)
Received: from google.com ([2620:15c:211:201:85e0:23ee:fbe7:282b])
        by smtp.gmail.com with ESMTPSA id pc10sm1082527pjb.9.2021.12.09.19.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 19:25:06 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 9 Dec 2021 19:25:04 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        John Dias <joaodias@google.com>
Subject: Re: [PATCH] mm/madvise: pageout under plugging
Message-ID: <YbLIkAsiLy8flTIN@google.com>
References: <20211210003019.1481269-1-minchan@kernel.org>
 <6d844eda-a55a-d90c-d8bc-364ac8b17690@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d844eda-a55a-d90c-d8bc-364ac8b17690@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 10:02:24AM +0800, Miaohe Lin wrote:
> Hi:
> On 2021/12/10 8:30, Minchan Kim wrote:
> > Likewise shrink_lruvec[1], madvise_pageout could get the benefit
> > from per-task block plug.
> > 
> > [1] 3da367c3e5fc, vmscan: add block plug for page reclaim
> 
> It seems there is a block plug in the caller do_madvise already. This one
> might not be necessary for madvise.

I missed the place where it was already doing.
I will drop it.

Thanks for the catch.
