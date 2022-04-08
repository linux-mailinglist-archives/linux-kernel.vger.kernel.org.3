Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81F2F4F8E94
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbiDHF7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 01:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiDHF7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 01:59:14 -0400
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154281E8177
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 22:57:12 -0700 (PDT)
Received: by mail-pj1-f45.google.com with SMTP id fu5so7709868pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 22:57:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eMm3hlpk7JoRfwolyhktq+6EgRac5qtfF9ueVrGFlP4=;
        b=iKf5Qh3ua/YV/5XeKZ+3fe9Jt5+A/QHU/JxygeGQkSOHpIIWS1O7W6H/jGnTtiaGGo
         04CjnD6E3cZ+3rpNM1LtRA0GHd424sLab7waHw3begvy1PtxRpD9N/6qJ+HYkstgh5tS
         ypr2keo24qZDABZSf89gH1HH5nx8yZQurkd6iPu4kLvfHgZzE05/DbH9qHh+bPY/LrIq
         Wl58WPIFWvCiTPwpyCY3ZuSQUJRBenPoKpxRIEXDnXrTVh2o3MvjYoG96NtWP1h6QV9B
         TnTWKdQRDnLEtPfspwb5unt8mQAcrAehu3Xr7A2ykQXDTXG/Y6WLMX0f7tra2JhWc/EV
         2ioQ==
X-Gm-Message-State: AOAM532XVNviv8r/0Kcn37bPMAOvl8+26jNLQzVf27E8/8RfNdlJHxrI
        Abcrlfjy2xr3Z575A7+yNEpFfJeoWcfm7xSE
X-Google-Smtp-Source: ABdhPJz7oKZxcs8tbdwy05UCiDpw9eLdIfkQD1w3/fezoCGqvxmLYQWwvqg0BPCQEF0ikBPuCvsT2g==
X-Received: by 2002:a17:90a:c504:b0:1bf:6d9f:65a6 with SMTP id k4-20020a17090ac50400b001bf6d9f65a6mr19798066pjt.204.1649397431491;
        Thu, 07 Apr 2022 22:57:11 -0700 (PDT)
Received: from fedora (136-24-99-118.cab.webpass.net. [136.24.99.118])
        by smtp.gmail.com with ESMTPSA id g1-20020a633741000000b0039958c06c53sm9319592pgn.61.2022.04.07.22.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 22:57:10 -0700 (PDT)
Date:   Thu, 7 Apr 2022 22:57:08 -0700
From:   Dennis Zhou <dennis@kernel.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <songmuchun@bytedance.com>, tj@kernel.org,
        cl@linux.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: Re: [PATCH] percpu_ref: call wake_up_all() after percpu_ref_put()
 completes
Message-ID: <Yk/OtIKckFprZrGx@fedora>
References: <20220407103335.36885-1-zhengqi.arch@bytedance.com>
 <Yk+kAUwxZx1JhxIu@FVFYT0MHHV2J.usts.net>
 <cffbad48-db3b-e99b-11b3-7956ed460fb2@bytedance.com>
 <20220407205419.f656419a8f4665a2dc781133@linux-foundation.org>
 <35195a61-d531-aeb2-5565-146e345f8bf6@bytedance.com>
 <20220407211018.875696691e4411a7b5c8f63f@linux-foundation.org>
 <d546cbce-b1d6-9499-3093-796cad7be9aa@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d546cbce-b1d6-9499-3093-796cad7be9aa@bytedance.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 12:14:54PM +0800, Qi Zheng wrote:
> 
> 
> On 2022/4/8 12:10 PM, Andrew Morton wrote:
> > On Fri, 8 Apr 2022 12:06:20 +0800 Qi Zheng <zhengqi.arch@bytedance.com> wrote:
> > 
> > > 
> > > 
> > > > > > > Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> > > > > > 
> > > > > > Are any users affected by this?  If so, I think a Fixes tag
> > > > > > is necessary.
> > > > > 
> > > > > Looks all current users(blk_pre_runtime_suspend() and set_in_sync()) are
> > > > > affected by this.
> > > > > 
> > > > > I see that this patch has been merged into the mm tree, can Andrew help
> > > > > me add the following Fixes tag?
> > > > 
> > > > Andrew is helpful ;)
> > > > 
> > > > Do you see reasons why we should backport this into -stable trees?
> > > > It's 8 years old, so my uninformed guess is "no"?
> > > 
> > > Hmm, although the commit 490c79a65708 add wake_up_all(), it is no
> > > problem for the usage at that time, maybe the correct Fixes tag is the
> > > following:
> > > 
> > > Fixes: 210f7cdcf088 ("percpu-refcount: support synchronous switch to
> > > atomic mode.")
> > > 
> > > But in fact, there is no problem with it, but all current users expect
> > > the refcount is stable after percpu_ref_switch_to_atomic_sync() returns.
> > > 
> > > I have no idea as which Fixes tag to add.
> > 
> > Well the solution to that problem is to add cc:stable and let Greg
> > figure it out ;)
> > 
> > The more serious question is "should we backport this".  What is the
> > end-user-visible impact of the bug?  Do our users need the fix or not?
> 
> The impact on the current user is that it is possible to miss an opportunity
> to reach 0 due to the case B in the commit message:
> 

Did you find this bug through code inspection or was the finding
motivated by a production incident?

The usage in block/blk-pm.c looks problematic, but I'm guessing this is
a really, really hard bug to trigger. You need to have the wake up be
faster than an atomic decrement. The q_usage_counter allows reinit so it
skips the __percpu_ref_exit() call.

Thanks,
Dennis
