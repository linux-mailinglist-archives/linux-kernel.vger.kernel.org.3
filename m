Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEE1B5802EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 18:40:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236419AbiGYQkG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 12:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236517AbiGYQjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 12:39:55 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8753E1DA56
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:39:51 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id x11so8606403qts.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7xVgMqmN/86GQHcqXO1yw7VSBDbzPsFu44uQMKjUJeE=;
        b=G1BoE6F8flgmzsQzfW3nkF7mptQonm328gZXYogDGG2IBIo/98/hfHLbhV7UAJkXQI
         X8ynxusv76jgdnblo7OxdqtfwPoXk/rNSeoDm2clKMjo+cyP+MkOivoz3cjRpyBfFOMl
         SIlEVNpakmxkbmqt4+XxLQLJ4QQ5PCkIi8fjAenSwWjxlcnBfytss8LLn3ERV7YvDbZa
         +VH8K1yK0xvi9ijH2dX3DZyfC4rI5TE1UjZr8z9tc/TucWdSj8cQGKObuYxB1bKQ6CbK
         2/AGAfXA0e/T+pDGaivYnTvUT5YBiUB+stnvoGNHnjm/BVx/LCqP/LJmcqT6Q4OGgHau
         mRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7xVgMqmN/86GQHcqXO1yw7VSBDbzPsFu44uQMKjUJeE=;
        b=5NX/b9S5RYFHDaTfdmlp+y9UrOL/q5l/yTL00/F2cFrax8wYOLcAibLNnRCUU0hDtM
         yxFMYTQWM1aoYDl/8CY3yBxNPiTjM7SBxvEfTTcfwQU3SY3spK15YaALkoB4mq+0BVE9
         LOzIWEhPBgHPLC7Vx/ZMNnnqE0+0RfAfLRfqLXhh1Fn5d7eQ80W1RidU/dl7/O1hz3X0
         e2j3jA+beKsG8p5oBhSC10SmjT7jJhY6Zf/UA87YajYfY0hEOI/PSr7h5uPQ/RfGMe+X
         +W9uunSp9c7BONb9Ga0VrZpwzbiGlcOvu59gGgim6IUE/FEhtGbbmZj2XrtBXUp2ln8x
         Lw4A==
X-Gm-Message-State: AJIora/vapC/dBSFoaa6A46GpAnTOTEOVlFUuMCw/xt6nwh0oZE9CwHJ
        A/etW6brizeKGk4fVCsNAoHaX7yZ/eE9Kw==
X-Google-Smtp-Source: AGRyM1uKPvbHdE7zEZLQVfC2qN7mSkhxt10ohJq0YaOc0s83Re06cnlkFoQmtVFqPXBDnTfsAuzhwA==
X-Received: by 2002:a05:622a:1710:b0:31f:340:41dc with SMTP id h16-20020a05622a171000b0031f034041dcmr11262377qtk.311.1658767190695;
        Mon, 25 Jul 2022 09:39:50 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:994f])
        by smtp.gmail.com with ESMTPSA id r19-20020a37a813000000b006a6d7c3a82esm9041344qke.15.2022.07.25.09.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 09:39:50 -0700 (PDT)
Date:   Mon, 25 Jul 2022 12:39:49 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        tj@kernel.org, corbet@lwn.net, akpm@linux-foundation.org,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 3/9] sched/psi: move private helpers to sched/stats.h
Message-ID: <Yt7HVcdXMYeNn6uS@cmpxchg.org>
References: <20220721040439.2651-1-zhouchengming@bytedance.com>
 <20220721040439.2651-4-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721040439.2651-4-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 12:04:33PM +0800, Chengming Zhou wrote:
> This patch move psi_task_change/psi_task_switch declarations out of
> PSI public header, since they are only needed for implementing the
> PSI stats tracking in sched/stats.h
> 
> psi_task_switch is obvious, psi_task_change can't be public helper
> since it doesn't check psi_disabled static key. And there is no
> any user now, so put it in sched/stats.h too.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
