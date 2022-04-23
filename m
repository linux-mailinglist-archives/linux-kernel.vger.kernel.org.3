Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C19B50CB03
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 16:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236048AbiDWOGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 10:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235987AbiDWOGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 10:06:13 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C861692A2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 07:03:15 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f4e28ae604so50161677b3.8
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 07:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fa8nrg7PnSBHWiz/ixAu3+CbgP2gabmfB3kka70Ad0U=;
        b=RBzRm8aigFAmC2YQq4Au63IrMg4vk5mNEbXU0HTFREh1S8MkXIo2r1//dLE4dyUX/e
         6NozTIV4b1f9CJCUnvT4w7Sx7ybqXpLGTEuCwKk4b3Cr+DCdjlOpNBVoS7xw+1IljbxX
         WY9TJe1wbjl3aDMWyDZjVVUsZQ+WpulkaJM5CwkywnoIXR0oQof2FUp7skcLKtWIfukx
         VknJtnGg5S6NNilEWi8UYh+oR7TXcfJ/JyaSL8lv6ju9ciyY4p8a1ydjQvkXybSBiEhR
         MVC/MmsNWdd9lqggkQCwKJIffrY3xA8wW9Gow+xt10wW2staPBbArzYc4Kx+820Ntvm+
         KDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fa8nrg7PnSBHWiz/ixAu3+CbgP2gabmfB3kka70Ad0U=;
        b=PUi1QF2KqkoX7aQzjMVugSyBvkiLLHxFtkfbDBMmcmAbxTMWfOJDYVB4tcq3DJQNwU
         eDBXrgGJb+5uu8wNfc/lvatSWWCd0N1ucoyhRfvhdIGsX5gGBcoJM7ANKAvv10oKyR+h
         Cd5EuQdGDWFiPZ+d4AQbMw5JRLShFvVZtLBRAgPmoCIEIpHn6oWIAVpKcSJvQ29XmwW+
         wvncQy1IVgtQ9evBEZFliVh/DX0OSCfOGMMbusPIHZ810Vm21fS2aiabyvyiL85lStN+
         QJROVZDpQB4y9+WCvJnymNMs3fM0w2cnPFw7S6mxmCOiexW+3jW1ST595VneNXjdbgC3
         cThw==
X-Gm-Message-State: AOAM530kPWDaH5hYfFvPb9SAvXHdGtSxyoKdvktzhI9ImiR5T2kqkJPR
        OCifpKg8+Fr8QiE34bqzLU0SKjeN1KCECQ==
X-Google-Smtp-Source: ABdhPJwStmJpcHiA2mFTxcNMhfws2BRPRjdd+RlFHxUK+bhjIRki3ilpkcFSKTXyuoE3Fh60b9kljL0wiOv+vg==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:a81:18d7:0:b0:2eb:553e:f3ee with SMTP id
 206-20020a8118d7000000b002eb553ef3eemr9135814ywy.393.1650722594556; Sat, 23
 Apr 2022 07:03:14 -0700 (PDT)
Date:   Sat, 23 Apr 2022 14:03:12 +0000
In-Reply-To: <20220421234426.3494842-4-yosryahmed@google.com>
Message-Id: <20220423140312.fxsxjwcebvor2x5l@google.com>
Mime-Version: 1.0
References: <20220421234426.3494842-1-yosryahmed@google.com> <20220421234426.3494842-4-yosryahmed@google.com>
Subject: Re: [PATCH v4 3/4] selftests: cgroup: fix alloc_anon_noexit()
 instantly freeing memory
From:   Shakeel Butt <shakeelb@google.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        "Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 11:44:25PM +0000, Yosry Ahmed wrote:
> Currently, alloc_anon_noexit() calls alloc_anon() which instantly frees
> the allocated memory. alloc_anon_noexit() is usually used with
> cg_run_nowait() to run a process in the background that allocates
> memory. It makes sense for the background process to keep the memory
> allocated and not instantly free it (otherwise there is no point of
> running it in the background).
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
> Acked-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeelb@google.com>
