Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADC7651BA61
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 10:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348797AbiEEIbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 04:31:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348621AbiEEIbn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 04:31:43 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14F731203
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 01:28:04 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id x23so3090765pff.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 01:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HOKWQO3AA3Q0kMwEYSF8sNwEKbhYO51b9Gcb/RnOKGg=;
        b=wci8YOoxZ3illRFKHKrWaX7T897Mmf1T5O3iEUl+cL+QRBXehtQcWlzLaWIPPakKqr
         ZW21u9nGyxk794Gfd2xWUN15d8CvQaYrXiETA8AIQUeETlm6NxnWyj3QuixYzEimAQqR
         WYyvmk61zfkke2dhM85U7aYfHweXphpxcwJEB3taPGqLejWPxB7tSWyYqmtxF2cHzQBd
         tTEAHp20VGgM9M2gs9WlZWFdXHhLA+Rc1yxd6Q4wR5ZNqQmBPIEm06qD8rquGqxXMU2k
         dqHArOIllIBoQAhxe6QBPhXz8EusZoVpiKvcqdgeWQqVeztKoWsb1Hyjf4bJGCftI2a5
         JFOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HOKWQO3AA3Q0kMwEYSF8sNwEKbhYO51b9Gcb/RnOKGg=;
        b=I2/jAH/GI3NcfA5g+S3J23zn0zblugnAbhBLg5kfycnaPncpQmDn1+yTM+uDg+sfAV
         YuyvU4lB/wOWtZMLn+cbIf83U7kxaJsW/S7WXvjtHxwGbMr4GjTpeJv9DHR5USWVGTVO
         NUFkfZ+vbsBdIiHgKeSeoJYVShbTC07GxTTQUd3avB2p/3vlD3Rad+Blp7R54nMqkOkW
         fICVCOg+D+jw8bLlohKPPYZRP+MJNwqJVpTPgqAarHmnSuH77UK7aJbLhihjfNs3DwjK
         iLb0gFuWdUK2xQ0IBqhyPg3XLpP4p4vhKJvQnscn5XLwnXFqgumEWfC6z8tvUuC29GDy
         S86A==
X-Gm-Message-State: AOAM533vrxZAcxkC4SD7kmOpPRqP0QY/6/0tqRFYgVSkVD2nNzVoh+u7
        Jj3Vl/eHsDDnMzt2xb6+tOF16Q==
X-Google-Smtp-Source: ABdhPJz9Kgs7jvcZ0UyuZFb+nux2ZvzGdTDCoVC8GdWBchRjFOawaRJ3x6Cb7nYnHszwKHVJJIuurw==
X-Received: by 2002:a63:da04:0:b0:3c1:457c:3df3 with SMTP id c4-20020a63da04000000b003c1457c3df3mr21712805pgh.292.1651739284363;
        Thu, 05 May 2022 01:28:04 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id r11-20020a170902ea4b00b0015e8d4eb2dfsm859092plg.297.2022.05.05.01.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 May 2022 01:28:03 -0700 (PDT)
Date:   Thu, 5 May 2022 13:58:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-pm@vger.kernel.org, Rex-BC Chen <rex-bc.chen@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] cpufreq: Avoid unnecessary frequency updates due to
 mismatch
Message-ID: <20220505082801.oks7ko2sbqazyenn@vireshk-i7>
References: <39e39a7d30c8ee6af81fb64670a330abeb87402e.1651652493.git.viresh.kumar@linaro.org>
 <CAKfTPtDbsd+RLwY+0ZfnNWkQD+jOHmoX2K+ZfsOMnEH81ouVjw@mail.gmail.com>
 <20220505074408.ayzmd5kdbw2fagbq@vireshk-i7>
 <CAKfTPtCuJGsrsBJ2jACr_YeKN3RXNVMkgRgo+cw9t7CAyGwHWQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtCuJGsrsBJ2jACr_YeKN3RXNVMkgRgo+cw9t7CAyGwHWQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-05-22, 10:21, Vincent Guittot wrote:
> Part of your problem is that cpufreq use khz whereas clock uses hz

Not in this case at least as the value mentioned in OPP table DT is in
Hz.

> Would it be better to do something like below in cpufreq_generic_get
> 
> (clk_get_rate(policy->clk) + 500) / 1000
> 
> so you round to closest instead of always floor rounding

That would be a fine thing to do anyway, though I am not sure if it
will fix the problem at hand.

If the hardware returns 499,999,499 Hz, we will still have the
problem.

-- 
viresh
