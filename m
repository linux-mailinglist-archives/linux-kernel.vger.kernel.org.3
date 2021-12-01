Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADC34647E0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 08:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347214AbhLAH0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 02:26:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347168AbhLAH02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 02:26:28 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061BDC061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 23:23:07 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id cq22-20020a17090af99600b001a9550a17a5so20323043pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 23:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OuGAO91bT9scHZ+M1kNZF+Tb/U4vNWoZYvfq/f3IMVg=;
        b=csvqKVfNLrfpigEcYFqMdY40Jpcx70IZ0qYiYOa1GiG0JGDYuA4/WlFbwiL0jTitTP
         qR8fo1vLRKYA7+ms8tK/GAlIIg71gwGM8fLDmugtv2VW9gSv0sMj8ShqBOELViSJtgf3
         t+x0l9P1vOLuaWlWwrmbMV822saINCsdEq1cyKRJPYU+yEDKkBsqwDa7lA6TBwyIERul
         Td4r9LzQY/Q6AsaYTscpziYjzlqdf3Fd/C03fjveNTg5iOX3eEgl5Sxm1PGhetTXBVFj
         OXQtGXosvFS/7OQVRXVFxdIJ4CSPuxV7SN0IhE29KpHyVtWWQfDE8CF99RqQh2RdDdW2
         IZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OuGAO91bT9scHZ+M1kNZF+Tb/U4vNWoZYvfq/f3IMVg=;
        b=QnGXCawu7qZlZNBgFB15ntQM2Izv/Ig4GO4sXuyCpse8pG9JjjDvlml5qhaoPb5jVV
         TQDiVURAzXiV2AG20VqkYl4WbPxstKi9c0rqonUZ1gBMEtRwMOdf7Nlz1KJ/IgP8C4Ew
         1gaHwBCH9C5nCsrUcBR1RDVUeLzKX024U3KVGD3tNKgiixfwozUzwkXG7isUdrOJZ+9k
         Q/4pxEDcAmrukb53WBW2GyImwnBe4HuSHk3i9xTO2hdmyKo6HMpfs340irKFy7BYTBjL
         JRAn9iSoSBGUr81mmV3MfV9rWX6Rz0GYr+rhexa0cyxWSu//6LSVtpATsIRYrU8xKZf+
         PmOA==
X-Gm-Message-State: AOAM531NEf7DtzdUCwZOGMs7GPxMFlkb61fN2W+uI9heQMoW+g+emQt/
        AoQO10gdwMhyD9IABN4y9Q2peQ==
X-Google-Smtp-Source: ABdhPJx4ah0Y5CvPRiW/0gUYuUy2sHW9L897sSnRS1Y/3bO9F/06gcH0kLH9ziEC4SS+Sm+C5n4+dg==
X-Received: by 2002:a17:90b:3ecd:: with SMTP id rm13mr5227188pjb.157.1638343387412;
        Tue, 30 Nov 2021 23:23:07 -0800 (PST)
Received: from localhost ([122.171.9.64])
        by smtp.gmail.com with ESMTPSA id f21sm24843516pfe.69.2021.11.30.23.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 23:23:06 -0800 (PST)
Date:   Wed, 1 Dec 2021 12:53:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hanjun Guo <guohanjun@huawei.com>
Subject: Re: [PATCH] cpufreq: Fix get_cpu_device() failed in
 add_cpu_dev_symlink()
Message-ID: <20211201072304.5j44qi6bbgdx3hhv@vireshk-i7>
References: <20211129080248.46240-1-wangxiongfeng2@huawei.com>
 <20211129091039.s7bqq43o4ktuub6t@vireshk-i7>
 <CAJZ5v0hYskLTjSGOJgRRXD0cE0a5DMHh5qTvmgCmJh8bMicLzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0hYskLTjSGOJgRRXD0cE0a5DMHh5qTvmgCmJh8bMicLzA@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30-11-21, 12:42, Rafael J. Wysocki wrote:
> This is the real hot-add path which isn't tested on a regular basis.

Ahh, I thought this is a simple offline/online thing. Makes sense now.

> > Anyway the patch is okay,
> 
> It would be good to add a Fixes: tag to it, though.  Any idea about
> the commit this should point to?

This is broken since a very long time then, we need to get this into all stable
kernels we care about.

As Xiongfeng pointed out, 2f0ba790df51 ("cpufreq: Fix creation of symbolic links
to policy directories") looks to be a good candidate.

-- 
viresh
