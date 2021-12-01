Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E384659C9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 00:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344113AbhLAX3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 18:29:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232038AbhLAX3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 18:29:16 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9558BC061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 15:25:54 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id f125so11927647pgc.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 15:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xGeNM4jaBTTeV3zmlNIV+CZJ1AiY1aOgNT/zSQgiork=;
        b=E1BtuqSmVhEAWDMgrxpMo9xQXVM+rWMdAoxUZJwj5O6sSM1L8gOwWhFcBtNwiF44Kd
         ADZ89FIup/Ykv7effjaf9R237FbqZHchCtXHfwsrpvQu/TtROYmonM5MjZ+sWfix26/o
         TsbjytDekzi9z/hQeTpegYZKw0iM7pbyggRBSIXUunHT/P4m85ZPTFEIUh35IW44cl2n
         W3W7aL5aGDYJhSCb99D1rGtNYWUSD+z9qWk3VC/poQJGi9mNEoJ/RK03lDifE9/jDbS2
         D5r0uaMmAZgLFpEA94q29lLbD+gepWX+DrQLi5MqdGbwCz8cqRXVS1Jqvap6jlig934Y
         lMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=xGeNM4jaBTTeV3zmlNIV+CZJ1AiY1aOgNT/zSQgiork=;
        b=v/0aQgJKouz/jOJxDI0jusSOgwTwuMn1JkoP2I6trUOpl0P8w5ZMwEVNx4uhAbXuBb
         xeQHr56/wBnIhlrH5fZgrmM9ja86kVyOUGhH75WGN86AX7AOAi4kNeIjO+0Dcr2oyVtr
         X0LGFhpi0zh/tiQ2UNvnJE8G5FKXOdbKPoTpOptTsMJBKxwzv9SVpSv0zcXZyhTJkgtW
         GBxzagFAHhPZaXHfQR2oi9phQqOvw2EFMpcEk/yhOhAvLLQpf+/LkZkhZAhbsrTWM9IY
         41llXz6yViyPAu82P85FKxnLzmrfE17QC44Hzzcirhk6YdBmRYEysxEq4i8HHsbNd7hG
         aaAg==
X-Gm-Message-State: AOAM532dgkPK5yeYKsDoqiXtnAYKGDaemsackBr6ZemEQuY/7LDrXwBN
        v8R77v+S3LnDXgISv7fKFYQ=
X-Google-Smtp-Source: ABdhPJzCTZPIsORiriUPh8uj5zCRka4hWr9hsp7FhP6ivmR2aOzFt0xKtcNaoAR+VkobnZ8EA5lD/w==
X-Received: by 2002:a63:4458:: with SMTP id t24mr7014349pgk.236.1638401153887;
        Wed, 01 Dec 2021 15:25:53 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id q11sm640849pgt.54.2021.12.01.15.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 15:25:53 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 1 Dec 2021 13:25:51 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH] kernfs: prevent early freeing of root node
Message-ID: <YagEf//iqIAk/gEf@slm.duckdns.org>
References: <20211201231648.1027165-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201231648.1027165-1-minchan@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 03:16:48PM -0800, Minchan Kim wrote:
...
> Since kernfs moves the kernfs_rwsem lock into root, it couldn't hold
> the lock when the root node is tearing down. Thus, get the refcount
> of root node.
> 
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Minchan Kim <minchan@kernel.org>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
