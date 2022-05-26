Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0909D5351DA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 18:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236462AbiEZQIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 12:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347434AbiEZQIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 12:08:25 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5876818B02
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 09:08:23 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id g184so1715989pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 09:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c1Bktjyy5yJ48/4ouEx7iyf57Oc/MXH/iXvxQddSwqY=;
        b=TG4xn66tfld7JgXJ99NFHNTFBy/Fa/PgxOABrwHjyvrHSkzB6WYiB2LwKkSu8YSgs3
         DzNa+O5Yn5Gq42nfsi1YffVHYgdR/+S8s4R7jSB07TNYoCNwy5H2WinMRkOI8mylW8kk
         QT8+hQuDfgdJywPgsRGmtYzZ5kArx76tGcQUiMIHpQx85rGCW1SqqX56K1h1+CZ43ob5
         4Wd/6ZYwt9FYdhx+O0wyo0SVMg9Nq2auNMb8WH0yChC1jwKNUvkQQYBkUw/p58ty6Tfv
         LW42xXWDPlW6rbkkqPC4l9q7CKBMX9aXCr7X8Psi1JoCZq29tec2Dj4hcZgrXn7KSSs/
         WgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c1Bktjyy5yJ48/4ouEx7iyf57Oc/MXH/iXvxQddSwqY=;
        b=6ZeFzFxL6iXZmPQNv5SDQh1AXNNSNWYEOj8aMjmw3nCZ0fEYPVw8u7TqAgTvHoW5Kq
         H1WX3iPSsoI6gMo/lxzmvZY9wTgnhP/UE6HRVruGHUCTnFwWvHuHGIX0sFD+rLw/BbC6
         i1MJ366sCMGBHrwFAgUCUIp4rMt77LKIyMzSjttpZ6QnV0pkGYzCl+yHb8DEaVc+TDd4
         G7rmBd+3fkf0u3sD5/IZTEzySc61Az+Kqd2Cyo7ts0QWYgQalZ9ocJYZzvf+oHK/TXjx
         kGAyMTCMtkc9XNhBVHHSIn0BgYyCorjrlDt/0JHioQbm6AX3QN7+yf9G/+Cfib5w/ovG
         FrcQ==
X-Gm-Message-State: AOAM533sk75N6SKRLdu48m7fHLu6k+8oeDcXnPEcEemcY95cqZSBWdoR
        OPWgokQbxzQRVjiQQQnHUHKOKA==
X-Google-Smtp-Source: ABdhPJzhCgX4b/z0L+UTtDS+3Sl4/75IHeHEbzY0Xzo3Wl9favASavx82GN1vnqWmi6FTV58ROfr1g==
X-Received: by 2002:a63:f705:0:b0:3fa:9d26:f4ef with SMTP id x5-20020a63f705000000b003fa9d26f4efmr13344938pgh.613.1653581302725;
        Thu, 26 May 2022 09:08:22 -0700 (PDT)
Received: from leoy-ThinkPad-X240s (n058152048195.netvigator.com. [58.152.48.195])
        by smtp.gmail.com with ESMTPSA id k12-20020a170902d58c00b0016366fbc155sm1695092plh.255.2022.05.26.09.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 09:08:22 -0700 (PDT)
Date:   Fri, 27 May 2022 00:08:17 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Carsten Haitzler <carsten.haitzler@foss.arm.com>
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        suzuki.poulose@arm.com, mathieu.poirier@linaro.org,
        mike.leach@linaro.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Subject: Re: [PATCH 3/3] perf test: Add coresight tests to guage quality of
 data generated
Message-ID: <20220526160817.GE795802@leoy-ThinkPad-X240s>
References: <20220309122859.31487-1-carsten.haitzler@foss.arm.com>
 <20220309122859.31487-3-carsten.haitzler@foss.arm.com>
 <20220410083041.GA184647@leoy-ThinkPad-X240s>
 <050209c2-c784-e255-4e75-5c8674c5cfe0@foss.arm.com>
 <20220526082039.GA795802@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526082039.GA795802@leoy-ThinkPad-X240s>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 26, 2022 at 04:20:39PM +0800, Leo Yan wrote:

[...]

> Yes, my Juno board has 8GB but I also have DB410c with 1GB with quad
> coes [1].  I am still concern for 256MB buffer size, it's not friendly for
> embedded system, and even not good for server.  For example, if we run
> this testing on Arm server with 96 cores (like Hisilicon D06 board),
> then we need the buffer size is:
> 
>   256MiB * 96 = 16GiB

Correct for my bad math... here should be 256MiB * 96 = 24GiB.
