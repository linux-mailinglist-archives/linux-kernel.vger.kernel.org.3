Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C9352B2CB
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 09:10:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231693AbiERG6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 02:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiERG6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 02:58:33 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8CD2F3AB
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:58:32 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id v11so1304405pff.6
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 23:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rd55rxMMovw1DJHwtWtEtl0R1U+oRc69yxfkFhW/hio=;
        b=Swbk+9Vm70BNHGqrXE4GL/6Tv578+ci1hy5+i05a8uy27qxBkTT7Ow9oHkWdZvqEUK
         zkzEemgm/GG5WEp8kGt6fUdTTuaAwsy6H2pxOTqcoFJVx84bTiA9yp42yD0Ibq0vbT7f
         JeTo8nMbZ+cbQKZOXROGFYaZV7BrO0gw4Wh+tabcZBYdD5riFl4V6OATkmHhXbtY3JU9
         kytB25BnrUGasCh7tp0Al51eoNQppostiqvHjcF+ltQ9YaKw6keH8VeIBokTWGCgAIxi
         dziepVJjPs9Gz/1qw2g+whsJbHDOrjKe5P6NetyTc0AW/l+gSCAGP7/0I9rDwmGjp4R0
         jX8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rd55rxMMovw1DJHwtWtEtl0R1U+oRc69yxfkFhW/hio=;
        b=ftmMlKk7Xwdl4fHUycFAJ01Y63OyKfYY3HODHPxQpwKLRTvfaouBCMWZ7Wk48/Te+S
         O2HQC0TNM5JMmNtwazm4BlLl9RhyvZEBAzGhbAe3fxJolPq/YOvQBu+4VLRVA+/16or0
         CtPfDdVteIGbw0b6DfTBTqSPB4ZpAJxoKv+GojPi0uq0zhBrTmDDn/x44kTDC3q3ebzd
         ZNW8l4sHqGzznV0o5OBdCXjmNl0HzoKzIUb4YaHLiGJxEDNtOXpjTPpyGiBNG0+vWYEB
         Ze+oUtRoxYi0khrVwOgTLIqBnCO+SaOf0RK2ERRsL+BOcSJAR9D33aE9jzwc8RQeTzg2
         H+Qw==
X-Gm-Message-State: AOAM531AM2ilovk0+6uOGPqrfJXDl3GNTXFS9LqPJoGeoMh07ox6zXHm
        9Z4EcMt4itY+/KKKHPM2+6M=
X-Google-Smtp-Source: ABdhPJyATi7qvRbn8sZ6FiHlt7BWvwgSpx5G/qJgtKmC8fhI6KJYy8POxua/9BOMUjZtNeRI2IwDew==
X-Received: by 2002:a63:4e62:0:b0:398:cb40:19b0 with SMTP id o34-20020a634e62000000b00398cb4019b0mr22631738pgl.445.1652857111880;
        Tue, 17 May 2022 23:58:31 -0700 (PDT)
Received: from localhost ([1.157.44.177])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d50400b0015f15459652sm776372plg.277.2022.05.17.23.58.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 23:58:30 -0700 (PDT)
Date:   Wed, 18 May 2022 16:58:27 +1000
From:   Balbir Singh <bsingharora@gmail.com>
To:     cgel.zte@gmail.com
Cc:     akpm@linux-foundation.org, ammarfaizi2@gnuweeb.org,
        oleksandr@natalenko.name, willy@infradead.org, linux-mm@kvack.org,
        corbet@lwn.net, linux-kernel@vger.kernel.org,
        xu xin <xu.xin16@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        wangyong <wang.yong12@zte.com.cn>,
        Yunkai Zhang <zhang.yunkai@zte.com.cn>,
        Jiang Xuexin <jiang.xuexin@zte.com.cn>
Subject: Re: [PATCH] mm/ksm: introduce ksm_enabled for each process
Message-ID: <YoSZE7Iak3AYA4VE@balbir-desktop>
References: <20220517092701.1662641-1-xu.xin16@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220517092701.1662641-1-xu.xin16@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2022 at 09:27:01AM +0000, cgel.zte@gmail.com wrote:
> From: xu xin <xu.xin16@zte.com.cn>
> 
> For now, if we want to use KSM to merge pages of some apps, we have to
> explicitly call madvise() in application code, which means installed
> apps on OS needs to be uninstall and source code needs to be modified.
> It is very inconvenient because sometimes users or app developers are not
> willing to modify their app source codes for any reasons.
>

I thought we got process_madvise in 5.13, doesn't that help solve the
problem with extensions to advice and an appropriate wrapper? Granted
it might be a little racy with a running process potentially
participating in KSM already. If we are concerned about KSM, I would
assume that we care about long running processes, is that true?

Balbir Singh
