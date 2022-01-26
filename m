Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543EC49D42E
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 22:12:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbiAZVMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 16:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiAZVL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 16:11:57 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 498C6C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 13:11:57 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id s127so2120225oig.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 13:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=slBq4NHY0ygv8QW43vJ34+YaiAj8G4SyoF0HzZkCQHc=;
        b=YaD7LUIzV2ATPTv9SR3UQu+BkZ+pYRAYbI+veHC6Socrf7xUMvGRKtQPQkx/BLof2L
         vaGQCXUVt5RdGdmBnedu/mQzs41AsJhsPP5Juxum3ktgAMIqYGdDYDkmO75V/bN5AfjP
         lbOXG3Zt1UAu1rEfLhC+s2TsSHYqgGcYphNz0LHdMtvU7oR+gOqNJjcaIXQGBgvkPF8U
         g5xexwalvuKZL7Sw0bVCcO3rlkdue4E4xwg+g/i3sNp2O3yerSdJFB1TM8hi9iK/P/16
         9ODH1PFD3fY+BSBGIFIx6lXNoBW/BrMKYP+tmbILW7R2M8L8HCVUJfJFCERbRx8RZ4wV
         LTfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=slBq4NHY0ygv8QW43vJ34+YaiAj8G4SyoF0HzZkCQHc=;
        b=QnRsp5RgeOQ3rpttmMTyyOTLNylJ7aee1F3hpc87iy3Tx2+t2sdFgzgRFpqSrfsUyH
         JxQ6wJFEp4Mz5/QNPFlkInlEfkxvsPQ4tT0MG1N0nN2wRmZ4q4UoDP3QKWsn7JmXlBRH
         0zXWCIOgZu/BdcC+pOOS5qj0WQaASfOEFNquTg/5qB+rs11IQoSz5Ah7p8ekv3oA/fx+
         EQ082d4ViKGvn/d3tbDDTbha5kStLwqF2sTcOYpiyr3qZ4ainSNk6lnMK9JebZ5vqMil
         uUYpn1ppbcODAMHMHmTZBHjJLmD/hH2HlW9lOrSM0Dq1IxWe3JulYmzE7rtbPI1j13ea
         Pfhg==
X-Gm-Message-State: AOAM530Bvt3TPi3qeG/TpUbT2A2rVOgMXtu2Zc/VINh06HfvXBOohyPO
        tFXMlV3rGR00BdZkARNR+sRxB1pZ8d0=
X-Google-Smtp-Source: ABdhPJwKfUKG9txRxsfQ+FzsJFtRrkqOmIVVEbdM1wXY1/zmmO9x4aBYV4sFVvSCUCm88ecZcTwyww==
X-Received: by 2002:a05:6808:2003:: with SMTP id q3mr4830914oiw.254.1643231516493;
        Wed, 26 Jan 2022 13:11:56 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p26sm5956722oth.14.2022.01.26.13.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 13:11:55 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 26 Jan 2022 13:11:54 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chen Wandun <chenwandun@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, guillaume.tucker@collabora.com
Subject: Re: [PATCH] Revert "mm/page_isolation: unset migratetype directly
 for non Buddy page"
Message-ID: <20220126211154.GA3371726@roeck-us.net>
References: <20220117142712.3967624-1-chenwandun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220117142712.3967624-1-chenwandun@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 10:27:12PM +0800, Chen Wandun wrote:
> This reverts commit 075782149abff45ee22f27315eced44d02b96779.
> 
> commit 075782149abf ("mm/page_isolation: unset migratetype directly for
> non Buddy page") will result memory that should in buddy disappear by
> mistake. move_freepages_block move all pages in pageblock instead of
> pages indicated by input parameter, so if input pages is not in buddy
> but other pages in pageblock is in buddy, it will result in page out of
> control.
> 
> Reported-by: "kernelci.org bot" <bot@kernelci.org>
> Signed-off-by: Chen Wandun <chenwandun@huawei.com>

I see a number of qemu emulations fail with memory allocation
errors in v5.17-rc1. This revert fixes the problem.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
>  mm/page_isolation.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 6a0ddda6b3c5..f67c4c70f17f 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -115,7 +115,7 @@ static void unset_migratetype_isolate(struct page *page, unsigned migratetype)
>  	 * onlining - just onlined memory won't immediately be considered for
>  	 * allocation.
>  	 */
> -	if (!isolated_page && PageBuddy(page)) {
> +	if (!isolated_page) {
>  		nr_pages = move_freepages_block(zone, page, migratetype, NULL);
>  		__mod_zone_freepage_state(zone, nr_pages, migratetype);
>  	}
> -- 
> 2.18.0.huawei.25
> 
> 
