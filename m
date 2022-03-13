Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465D94D7824
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 21:09:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235539AbiCMUK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 16:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiCMUKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 16:10:55 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D9E049FAD
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 13:09:47 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id o26so12033545pgb.8
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 13:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=s/L2c/ExU2lRRbbGeHNM0fTyvtWmir/JMQ4lIG+dqPQ=;
        b=NHshDFyEJcyEiGKm2Xt+OMjFtjqs/nqg17/NmX/5+10JbigfEW7kQoEZs2E80Ezkni
         ggQQvpqP3G5meFEDXYywi1a1lM6SbmZh+ji46GJy67WZpvfM+oEuVWgP44qAUqNbjYuL
         JbwTN3qzOElmXWdiGV4hS5/tRu+qsdub3eoBIOl8ZToV6v75mtsqHxCJftMBaBpCLroc
         G7BAzGXa8O8HkPYJdXLVcYLdvJmNpPLGrIEmJ+y6oThvL1DlxSWFMb9X681aMVkikej/
         WlW/MhZvXtVGO9CO9b8CNlf4VAwxOc62FXTztBnwKuIkjqxdOhXpMaWiHPP2GhE7HZXq
         hPZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=s/L2c/ExU2lRRbbGeHNM0fTyvtWmir/JMQ4lIG+dqPQ=;
        b=4ForU1Le7tctN1GI3CZivERVzdiyZtsRYQ0rLOuRkUD45c6ox9nATHdCFTnsPQoRUN
         f74jxl4JpsCIpYnv/yM/NJyOCg650CK3pVUiOSsVACkBKGJsEz35JDG/duGrQs9cuj2v
         HxQ6bW8QhiseRbjLx3NCDHu5E04AHIMltcQtKaFIfNTRFVYXmG+EKNeF8X1397B1Y5j4
         7G0whNJmbhWGPzw6AGlxSe/FmB1JBj8kiueGkqrlGZ97lrWnEhDm76necFSbtoUWzoHS
         OiUdxpjf4zf8vgOFGnrLFv0S+Upq9yXB3o0BEo7Gpk5mUAfWdj7Hbg4KPX+SFozVqL6n
         orjw==
X-Gm-Message-State: AOAM530yWFeBy0GD1cTV+DOaANDtztlGp+xhrODrcXawH/3sZA4gUuzF
        /aebWwBluOPqCQaxG2e6oOZ3Mg==
X-Google-Smtp-Source: ABdhPJxCg27sMKMp7nSUM8vluoc736QFCgbEPPs5y8MHcFa4rKL7ROWWo0QzvAc4iwxsjxHh8X/1hA==
X-Received: by 2002:a05:6a02:208:b0:372:c366:8ff4 with SMTP id bh8-20020a056a02020800b00372c3668ff4mr17009152pgb.76.1647202186271;
        Sun, 13 Mar 2022 13:09:46 -0700 (PDT)
Received: from [2620:15c:29:204:1b89:dc90:772c:f65f] ([2620:15c:29:204:1b89:dc90:772c:f65f])
        by smtp.gmail.com with ESMTPSA id b2-20020a056a000a8200b004e1414f0bb1sm18849705pfl.135.2022.03.13.13.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 13:09:45 -0700 (PDT)
Date:   Sun, 13 Mar 2022 13:09:45 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
To:     Mel Gorman <mgorman@techsingularity.net>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Eric Dumazet <edumazet@google.com>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] mm/page_alloc: check high-order pages for corruption
 during PCP operations
In-Reply-To: <20220310092456.GJ15701@techsingularity.net>
Message-ID: <7b288234-84ef-db82-3b85-7f921dd3c2f@google.com>
References: <20220310092456.GJ15701@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Mar 2022, Mel Gorman wrote:

> Eric Dumazet pointed out that commit 44042b449872 ("mm/page_alloc: allow
> high-order pages to be stored on the per-cpu lists") only checks the head
> page during PCP refill and allocation operations. This was an oversight
> and all pages should be checked. This will incur a small performance
> penalty but it's necessary for correctness.
> 
> Fixes: 44042b449872 ("mm/page_alloc: allow high-order pages to be stored on the per-cpu lists")
> Reported-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> Acked-by: Eric Dumazet <edumazet@google.com>

Acked-by: David Rientjes <rientjes@google.com>
