Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B1724BA512
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242862AbiBQPvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:51:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242947AbiBQPu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:50:29 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07AE2B3565
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:50:14 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id p7so8971447qvk.11
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TrDQU0wSmJ6gbE5qWNC2HspX1mTvA/w61hnKamurULY=;
        b=Bjc0C/P8P3VM61dFTCNftf1IoTERJSFiCh6cp97oIk7fgWzNuZ+688kiVF8wS89ArW
         PJSElY9F/Ndstf4E4cCqluq6d9+x/aV27fLitAhzwSn6dFRPhvcuGsU4MLfBrcZAWlFP
         Qa/adfQ0pmzUCOSE9s1QwHPmMa9/XxEEMWTaW06DY+f8JM3AAuLlssbqGmD0TG6hY93v
         kwwJVBmVImOHKpQryqXIbBN0Yz/I237/xO87gxOdwFzslFRjnS+FYJIQcTvG9HiGb+WX
         H0uN4X6GofFaAemkyoi2WGP9NWfs+YB/Hu9HXd5/wdRKDVBjZ2PpLWEfkfRrJJFpU6kd
         QW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TrDQU0wSmJ6gbE5qWNC2HspX1mTvA/w61hnKamurULY=;
        b=XCGWIvURetOc7HClPWMg/JkUM2bTV+/cQ1+FZSJcbv8/zXqJrvX1kMG++cWxyW7cT6
         0TwaCcYM+Xj3jgvgZVsAZGwHcJG7uXD7nO86FjBC6D+hyZEzWjFVhfIqHW+oF4Z0y7k2
         h2WGLLwiAg+HSFdhy4Bip9uRU0QPvwdYVJNDYL6ZpjYKYLbssEngltaNWZ+hPO7QPfp3
         gcE0H0VJAEBPTalOFs723aVokcbtvbg/K6FHfWSblB+OOmv2oVq8+s8OTfMpzfxA7nsz
         8kV599hveQbFigna2ADU954KGAEAdsiuYkMfhIOnt95gyF6mTf5z2oDsvnxs0lBz1s0H
         U9kw==
X-Gm-Message-State: AOAM530I1C0A6tGa5pjM0xgJ/kvY/0Kvygxa0VD8dDuBnqNJ4iU1UfCh
        gHR2ax2FN6Y7j1m4QHNljsBHcqTzB97lDQ==
X-Google-Smtp-Source: ABdhPJzPCX/BmaO5y5ccTenFCqI0tT7p3C7WedWxRly8fWyyPG9Kcsrdkf1zkVyjGuUFHnnYJ6inHQ==
X-Received: by 2002:a05:6214:5a3:b0:42c:2c13:759c with SMTP id by3-20020a05621405a300b0042c2c13759cmr2687720qvb.20.1645113014138;
        Thu, 17 Feb 2022 07:50:14 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id m5sm20092682qkp.132.2022.02.17.07.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 07:50:13 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nKj2q-0060gp-E5; Thu, 17 Feb 2022 11:50:12 -0400
Date:   Thu, 17 Feb 2022 11:50:12 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/mmu_notifiers: use helper function
 mmu_notifier_synchronize()
Message-ID: <20220217155012.GC1037534@ziepe.ca>
References: <20220217110948.35477-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217110948.35477-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 07:09:48PM +0800, Miaohe Lin wrote:
> Use helper function mmu_notifier_synchronize() to ensure all mmu_notifiers
> are freed. Minor readability improvement.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/mmu_notifier.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

I'm not keen on this, the internal synchronize_srcu's don't have the
same usage model as described in the comment for
mmu_notifier_synchronize(). Instead they are doing what their comments
say.

Yes, it is the same code, but the purpose is different.

Jason
