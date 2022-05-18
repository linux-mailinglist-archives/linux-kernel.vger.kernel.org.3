Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845FA52BE16
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 17:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239185AbiERPKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 11:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239087AbiERPKK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 11:10:10 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD11F1DFD9A
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 08:10:08 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so2339330pjf.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 08:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DNSWvn36P8Ju40/gmO65ugg5AqpVVXxbcERcQscLzpM=;
        b=keN5z+JgikftdiPVK5OarD3l3Cy6ZqPF2RrKWaiQQehRNfGPKlqPo13y8OhK52vKhv
         ztgjk/7nXmm3/cHLh7h4wPrT+Sdo0QRXCsrr5vEO/i7kPmrHEZIl5MCEGYER5kCTNRnt
         QGZdMfNzb+ExarPWG7ZTlmv9OK/fEuKQTvYNUWDM8Mx3RIHPjzGOw0hzI8P29gx1UGG3
         lzLaMZ+zNTW5nFV718xLo5qgwS5Sx9Zt4vrgudgDiZWslG9QyJVthaRBqYCrrxIBh4Zi
         Hli/lsuacSHz6rsqEm1E119KiIlBkovKcckbIXq20ImaRYCKnADdE811yREqtAV/KgeS
         Yd1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DNSWvn36P8Ju40/gmO65ugg5AqpVVXxbcERcQscLzpM=;
        b=7iqiI83wmMOWu0Oys7AICeepI0GielonQ1Kam2a5b5jBMlYMVMeW/lpJXwmX90I+VP
         T1VLEYN+pBEq1wtSeV2XOklGcLKiDvMGSnNd1QW4Ju3fI6EnYvUWuof4ATGSm8DnA4Cb
         SZvvWtxgNvlQVCDaCcCckHmgZ++anKOWRzvwP9BsL4nmSGLfr98Wgg03cayQwA8FUNVy
         TiIdTOhhD4hvwZFujUq4I7tA5hHRAI3WMwSyHEhXkgyJtaAUbyV9WJTDyNcgmWjedRVX
         X389qKDgl1fMM+WFiyai5hOVvvyM9YuMS352rTsdvgNYlNTsaXysbGHH7Uz4/wXSLnpe
         bNuQ==
X-Gm-Message-State: AOAM5327ZxRpAsuHKpxqA+riBwt2PqoRypBGYBTYp3yH2W7HA3kyEI+d
        BXK2dY+0K7uBYYqTpVTvz6e3oIaoT2R80zrxj9qJJQ==
X-Google-Smtp-Source: ABdhPJwrWMLrAJXitNfkt95jrVfZNkFp0Q/OnWv5We5nfD18OxwBhx5MJM9kkXxi5ci1Przmkq5A6gBEnei8CDeVzu0=
X-Received: by 2002:a17:90b:3a81:b0:1df:109f:ceed with SMTP id
 om1-20020a17090b3a8100b001df109fceedmr427956pjb.237.1652886607934; Wed, 18
 May 2022 08:10:07 -0700 (PDT)
MIME-Version: 1.0
References: <f6625cd8-90f9-6d48-50f6-7bb052bf479f@openvz.org>
In-Reply-To: <f6625cd8-90f9-6d48-50f6-7bb052bf479f@openvz.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 18 May 2022 08:09:55 -0700
Message-ID: <CALvZod4XdLTXhcKrV0nRK5PqdMt4+y4qGzfUdZfHUuwWHxU2tA@mail.gmail.com>
Subject: Re: [PATCH v3] tracing: add 'accounted' entry into output of
 allocation tracepoints
To:     Vasily Averin <vvs@openvz.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>, kernel@openvz.org,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
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

On Tue, May 17, 2022 at 11:24 PM Vasily Averin <vvs@openvz.org> wrote:
>
> Slab caches marked with SLAB_ACCOUNT force accounting for every
> allocation from this cache even if __GFP_ACCOUNT flag is not passed.
> Unfortunately, at the moment this flag is not visible in ftrace output,
> and this makes it difficult to analyze the accounted allocations.
>
> This patch adds boolean "allocated" entry into trace output,
> and set it to 'true' for calls used __GFP_ACCOUNT flag and
> for allocations from caches marked with SLAB_ACCOUNT.
>
> Signed-off-by: Vasily Averin <vvs@openvz.org>

Acked-by: Shakeel Butt <shakeelb@google.com>
