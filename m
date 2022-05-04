Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 695C551A480
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 17:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352818AbiEDPz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 11:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352806AbiEDPzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 11:55:52 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 313F245ADE
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 08:52:16 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id 202so1473789pgc.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 08:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pMc4HZgJ4WDMVFUKNjkRSvRoarYOHBjdOLFJ+JcudJE=;
        b=LTFB1OjUJGw2zg2beDtYujBQvuumELokvnv1zDT+PhJ6LeTj+U6IC9xuWxKPXkw8g1
         kR4qRhQLHvovhB0GiRTORcQ6pIueUYhxQmIvBxyqViRuwpr/92BSnGuLFQvLT7oHcd9Q
         hZEOyqJmkXTqwrPI7fP0UcOa8fzNg+dyYeua4Znhp3qaWkF30trSKGXfRR3bbCJd2Oob
         yyYYL924NUecwfSFyiqv3fiAUuvKq3lonOJvda9fAuCgmx5ANlcGt7NyjXBRpJmsJBZf
         1mGiYbZr5BPLlQ5v2vqvd8bfg5hPJSDUBqq1Z192ymgpx5XmHsWkddkn4FX3358qsVn5
         R9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=pMc4HZgJ4WDMVFUKNjkRSvRoarYOHBjdOLFJ+JcudJE=;
        b=2MVqpPIHbdY3zAprIOPnqdLyQ0Rtujo5Gdtmr5CqS+SqbbZWHDZPeProtDuxkRrX5F
         11/zhYaZBaa3zeGzLGeUFpsGBmtep0moZbe3uD3r8pqfVpgfPOEIs3LmNRiArfE/ksI4
         LR3AaFHFORTt+2B0EUaFDv9Wo8ZUEW3z7QoOGNDyxLHmNuA+2gXNxpuZ7UokpYHKy8LN
         xVEekHRqnG/nihIdPW8FoMpYBUhYmo6mlo7OLden+MgOWfzc0Is3PJysnCZfkgxSdftL
         EkTYjibmIZs5pGdVHf6OEfKKMx9pddFByhH1f8Cjmu0vuyKZYPzZIC1uGsUDE6NeYgyI
         YiSA==
X-Gm-Message-State: AOAM533jyg26nclOlAi6zOOu7pEPQ1hLoLp/eA/Ihkv+3uX/vHio5iCP
        jTJwKmSA+ERxqKF5ChlL/uQ=
X-Google-Smtp-Source: ABdhPJwvYO2u6/rr4XQ9KYLYNCUrcMUMbTHMRz5vC0+zhGOQLWRPjzelxGtHXRa7rUCl6xFVRO2tsw==
X-Received: by 2002:a63:874a:0:b0:3ab:8715:9abd with SMTP id i71-20020a63874a000000b003ab87159abdmr18441524pge.403.1651679535572;
        Wed, 04 May 2022 08:52:15 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:8435:b3e7:62fc:4dfa])
        by smtp.gmail.com with ESMTPSA id y12-20020a17090322cc00b0015e8d4eb1b9sm8632768plg.3.2022.05.04.08.52.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 08:52:15 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 4 May 2022 08:52:13 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        John Dias <joaodias@google.com>,
        Tim Murray <timmurray@google.com>
Subject: Re: [PATCH] mm: don't be stuck to rmap lock on reclaim path
Message-ID: <YnKhLX+jzJc+2KwB@google.com>
References: <20220503170341.1413961-1-minchan@kernel.org>
 <YnHzvV2Uz2ynENnG@casper.infradead.org>
 <YnIBbjRYACzvuZpp@google.com>
 <YnIYofrw/GGEvc0U@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YnIYofrw/GGEvc0U@casper.infradead.org>
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

On Wed, May 04, 2022 at 07:09:37AM +0100, Matthew Wilcox wrote:
> On Tue, May 03, 2022 at 09:30:38PM -0700, Minchan Kim wrote:
> > On Wed, May 04, 2022 at 04:32:13AM +0100, Matthew Wilcox wrote:
> > > On Tue, May 03, 2022 at 10:03:41AM -0700, Minchan Kim wrote:
> > > > -void rmap_walk(struct folio *folio, const struct rmap_walk_control *rwc);
> > > > -void rmap_walk_locked(struct folio *folio, const struct rmap_walk_control *rwc);
> > > > +void rmap_walk(struct folio *folio, struct rmap_walk_control *rwc);
> > > > +void rmap_walk_locked(struct folio *folio, struct rmap_walk_control *rwc);
> > > 
> > > I see the build bot already beat me to pointing out why this is wrong,
> > > but do you not look at git log to figure out why code was changed to be
> > > the way it is now, before you change it back?
> > 
> > This patch added a new field as out param like compact_control so
> > the rmap_walk_control is not immutable.
> 
> ... but we have a user which treats it as if it is.

True. I don't think it will show sizable benefit on runtime overhead
since rmap_walk is already one of the most expensive operation in MM.

I could reintroduce the typecast for page_idle_clear_pte_refs to remove
the const as we had several years.

If your concern was to make rmap_walk_control mutable back, I could
change rmap_walk function having return value or adding a addtional
new out param. However, I thought rmap_walk_control is more readable/
easier than them.



