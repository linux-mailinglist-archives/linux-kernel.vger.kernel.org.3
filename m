Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582884D88BD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 17:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbiCNQEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 12:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240452AbiCNQEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 12:04:16 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A78823BE5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 09:02:59 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 15-20020a17090a098f00b001bef0376d5cso15058017pjo.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 09:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1iT022fIKxpXmN8c755nbteZp5bmgr4mJqOC9s4pU+M=;
        b=YszkTIZuKwUzUrrO+088AWNuLXa2SqygoFgan2PIzRf2h5EM5YACyz09I77TN17p7t
         iZ/DsI06OGIiSEZA/I6LCxli0z0BVOJKcxfgnjjwMNc/Aw9WH9P21BTqg226W7WucAfY
         ZHWnzr9RhTur1ZHdsMdDU8kx4KivbhdhdgJ1sKjhlgitHmo7StU62OhJV7XOCEcaPvIq
         DIL/30bX/kiyeDLz3IeMWagJa+RJDRVtQsIRQZEZZNmGF3ogfExSKQFWO4MElDqetSfB
         7nRnQbBBND8SLmdU7s93FEzLiOeR5hCbrutJRfrZGneG1S09q9ul0C2U/Mk6VsMz6A4w
         vbMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=1iT022fIKxpXmN8c755nbteZp5bmgr4mJqOC9s4pU+M=;
        b=tX3dTxdeFh0dcu4ySTTTaz4nPNOqa4jLVy3BwN4poPUj7iH4EOJFdX/4UneGPLZNSG
         3qX1G4Mjcv8NHQ4prerKnHvvrl0iZ7WGy1qdydh3bdQWrrFDZIpdKaSUAib45emsXIoA
         bwaL277klDbZwVFyTtxGaFtttjAGFSXR5NYTMu5XCkKnxWWKYncAEHmOgJS9GVYkmcw0
         hQOFUnfjuHiyqOc/KTBmJPeseXjjybes9B9qgSKHGUyoAC4EvVWBDNwDJVib6nlJ88p7
         0Ql8Jnt6X1+PVfC59ru2kCXjlXeRox+e4Sl081lgkncLp4HMkcXn+lafX2ozHedMOIdi
         h4ig==
X-Gm-Message-State: AOAM532CRAtKFN11kQFV3cZNdS5Z8xRxj0PLuZ9HVdX7hCWSWXb+f6uh
        Hf47hySHGbPVbiQmYuwj7tM=
X-Google-Smtp-Source: ABdhPJy2IzCO66f+V0fQdvwZ7Wl67owDcFCFksRCr/5jDaScEoqgLkTZGGxohQrvNOubydApI9cKfw==
X-Received: by 2002:a17:90b:1c03:b0:1bf:5720:f8a1 with SMTP id oc3-20020a17090b1c0300b001bf5720f8a1mr25979428pjb.100.1647273778648;
        Mon, 14 Mar 2022 09:02:58 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id g6-20020a056a001a0600b004f7bd56cc08sm6375600pfv.123.2022.03.14.09.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 09:02:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 14 Mar 2022 06:02:56 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        David Hildenbrand <david@redhat.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Cai Huoqing <caihuoqing@baidu.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linux/kthread.h: remove unused macros
Message-ID: <Yi9nMDGQGKIr8Wms@slm.duckdns.org>
References: <20220314145343.494694-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220314145343.494694-1-linux@rasmusvillemoes.dk>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 03:53:42PM +0100, Rasmus Villemoes wrote:
> Ever since these macros were introduced in commit b56c0d8937e6
> ("kthread: implement kthread_worker"), there has been precisely one
> user (commit 4d115420707a, "NVMe: Async IO queue deletion"), and that
> user went away in 2016 with db3cbfff5bcc ("NVMe: IO queue deletion
> re-write").
> 
> Apart from being unused, these macros are also awkward to use (which
> may contribute to them not being used): Having a way to statically (or
> on-stack) allocating the storage for the struct kthread_worker itself
> doesn't help much, since obviously one needs to have some code for
> actually _spawning_ the worker thread, which must have error
> checking. And these days we have the kthread_create_worker() interface
> which both allocates the struct kthread_worker and spawns the kthread.
> 
> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
