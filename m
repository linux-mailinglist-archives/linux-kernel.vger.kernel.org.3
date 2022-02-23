Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364734C0D0D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 08:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238578AbiBWHLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 02:11:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238567AbiBWHLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 02:11:20 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50EA63C49B
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:10:51 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 12so15556579pgd.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 23:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ajou.ac.kr; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UnYuBTBC02IDGurVKWqCwwD4Ax807V8FS59cBIjeBnY=;
        b=At6K6BI+UF/OMrPo98IMklq3SWpmsBJNoRWsWKAu5Jpp+/UP2hOMGp8L9AglQfH4Qm
         tSmQg6OZ1o0LN9fYsMtjh3qe9ZrbGCO7t3ga00b1brLIyiMttVxjjsMVYMivbV9HccSV
         OtbL25h8lgVttNJPI1kHi9lvvf8EAb2b6nPT0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UnYuBTBC02IDGurVKWqCwwD4Ax807V8FS59cBIjeBnY=;
        b=mdrI6DIiWksnyuWvnlNNT34Lm/Mm0IUKruOx/rn5m5rV4QlHGjW5hbN342e9qZ6jiq
         qN6igMmdrzQa0wg4VKHNBRyNWPYlT8/FhcS3ojyL++AKIuzdd7JAqyyEdIJyybaAdmBJ
         HEnEAbwf9AfirgwE4Gw0gHViCaSjOiPk1wV53zjjnY0cEb3AMFAOrTqhKZjcGmpOJ2Hv
         MYLzRdVLLdaNTFWJeordYeCux1e3uLv+8fPoTCXQ3e4XkzNYQZHJ+csam8vq9Q0CWN3L
         KI0G/2eWW076tgNNiBx1FgC2tyCf56p6oRmOCoR0v6pruuSBNZAzaNTDnmvLiN2qKDcl
         NfkA==
X-Gm-Message-State: AOAM5324o6lK0/QhDyq5/rltgNNzVKMCF+/3Ps1yEDTjmHkKn5F+QmRg
        t3CK/P2m8YSZsaMeawu8JDgYeg==
X-Google-Smtp-Source: ABdhPJwS4HzcM9ielkNYjkNr8cWrE1EwP3XXS77aCdUlc2GDm25FusYvMuDRgHDodOEPN88+cxH0dQ==
X-Received: by 2002:a63:e604:0:b0:373:8aca:846e with SMTP id g4-20020a63e604000000b003738aca846emr22474459pgh.406.1645600250601;
        Tue, 22 Feb 2022 23:10:50 -0800 (PST)
Received: from swarm08 ([210.107.197.32])
        by smtp.gmail.com with ESMTPSA id g1sm18107670pfu.32.2022.02.22.23.10.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 22 Feb 2022 23:10:50 -0800 (PST)
Date:   Wed, 23 Feb 2022 16:10:44 +0900
From:   Jonghyeon Kim <tome01@ajou.ac.kr>
To:     SeongJae Park <sj@kernel.org>
Cc:     Jonghyeon Kim <tome01@ajou.ac.kr>, Jonathan.Cameron@Huawei.com,
        amit@kernel.org, benh@kernel.crashing.org, corbet@lwn.net,
        david@redhat.com, dwmw@amazon.com, elver@google.com,
        foersleo@amazon.de, gthelen@google.com, markubo@amazon.de,
        rientjes@google.com, shakeelb@google.com, shuah@kernel.org,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 1/3] mm/damon: Rebase damos watermarks for NUMA
 systems
Message-ID: <20220223071044.GA6270@swarm08>
References: <20220218102611.31895-2-tome01@ajou.ac.kr>
 <20220222095317.7911-1-sj@kernel.org>
 <20220223051056.GA3502@swarm08>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223051056.GA3502@swarm08>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 02:10:56PM +0900, Jonghyeon Kim wrote:
> On Tue, Feb 22, 2022 at 09:53:17AM +0000, SeongJae Park wrote:
> > Hello Jonghyeon,
> > 
> 
> Hello SeongJae,
> 
> > On Fri, 18 Feb 2022 19:26:09 +0900 Jonghyeon Kim <tome01@ajou.ac.kr> wrote:
> > 
> > > For NUMA systems, there is a need to allow damos to select watermark
> > > options for monitoring each NUMA node or whole system free memory. Even
> > > if we do not use NUMA, since the default NUMA node number is 0, we can
> > > monitor the whole system memory without any configuration.
> > 
> > Some users using NUMA machines but don't do NUMA-specific memory allocations
> > and therefore assume memory free rate in each NUMA node will be similar might
> > want to monitor only global free memory ratio, to limit number of kdamonds for
> > reducing CPU overhead.  In the case, this patch would make them monitor only
> > the first node.
> 
> I think that the purpose of DAMON_RECALIM is proactively reclaiming memory
> before waking up kswapd. But I missed that case you mentioned. In that case,
> they might not want to monitor each NUMA node. I agree with this.
> 
> > 
> > How about leaving DAMOS_WMARK_FREE_MEM_RATE to work as is, and adding a new
> > metric type, say, DAMOS_WMARK_NODE_FREE_MEM_RATE?
> > 
> 
> Yes, it looks good to me.
> 
> 
> Thanks,
> Jonghyeon
