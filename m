Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 201AB5389E9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 04:26:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243581AbiEaC02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 22:26:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243555AbiEaC00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 22:26:26 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43DDD9346C
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 19:26:25 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id h1so2454531plf.11
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 19:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iv992blvs9Id0nKZNCQUi6AyK6qrkd7jCkuGgUWlqac=;
        b=QR9cp9SlXdxGFYBU5pilxQohbMBQAncS2IAUFL9MoT8gLdPyRrBdE+JmyHndh9OQDg
         rE6eeyc2jdsYk2vf0nYodiyQND1GTFmLwfIz41dLTveJWgyd3CRiZNPlWKe95h50CgOb
         RkmyOosMbRMZOCc6SduyD1vr+umt926AfGjmNX3fAdC1o966UMdF7EL3yB8dzVPhnWnK
         QOIitl7ariGYpeYBouTPLGraZr9dAfwtV87t5xQWTCYYgzELw1Dd6chT0Ep55jLLPQGb
         nSjNqhXIjVYKR0yBFSi8ZH/T6jT+m5mGD+zwpyWgCHzM5v5oT6nIuxtXCbS6PebIy8fn
         IO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iv992blvs9Id0nKZNCQUi6AyK6qrkd7jCkuGgUWlqac=;
        b=7DtjykFzb+CnJenJMHN/I86WKQH52sSyMTKwe6SwI5zyReDVPmjqr/1omjQP4yL89G
         samRt6CKZiHYf3Piq73ZQkb49ZNHkH/iQ3nnJR/DQTvsLobg7fYjj0p91F105nOBwnCH
         Ls5prIIhlldvFpDkR+Hs8u1v3gNoreurG2lEZd7D2yOezrzPdkgRF3g4VEWReKkfNbN3
         70nuxc/SqTnUUzxYD5SbyP1qAcjpF0ePDmf/74+U/toB0MC5UMxgGthDW4ANXkl9homb
         9UgNe57G50ojlFE5QMm7A5Fhh57eH8uI4Z5LUPnAfIAl7r0PQjF9Ai8OEVznLt+zlQT+
         or1w==
X-Gm-Message-State: AOAM530UrYC1PwxjvFcaaeQyN3xAkTXCGJVDQB0BKb6zVY36euy1aY49
        ryT5rQn0VjhBGydIs5rOt6EWeQ==
X-Google-Smtp-Source: ABdhPJxql+2GeEsG4msK5T3pxATV3sQyqA9V46SO//3rJmNOET4DX8x9cLKmr+nDzWuV1Mg01Bi1WA==
X-Received: by 2002:a17:90a:4093:b0:1e0:a6f4:ea1a with SMTP id l19-20020a17090a409300b001e0a6f4ea1amr26313423pjg.12.1653963984807;
        Mon, 30 May 2022 19:26:24 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:7163:3a36:783f:6d4a])
        by smtp.gmail.com with ESMTPSA id q10-20020a638c4a000000b003fa321e9463sm9474506pgn.58.2022.05.30.19.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 19:26:24 -0700 (PDT)
Date:   Tue, 31 May 2022 10:26:17 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, duanxiongchun@bytedance.com,
        longman@redhat.com
Subject: Re: [PATCH v5 00/11] Use obj_cgroup APIs to charge the LRU pages
Message-ID: <YpV8yVKKNmGw91No@FVFYT0MHHV2J.googleapis.com>
References: <20220530074919.46352-1-songmuchun@bytedance.com>
 <20220530141711.6cf70dcf200e28aa40407f6e@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530141711.6cf70dcf200e28aa40407f6e@linux-foundation.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 02:17:11PM -0700, Andrew Morton wrote:
> On Mon, 30 May 2022 15:49:08 +0800 Muchun Song <songmuchun@bytedance.com> wrote:
> 
> > This version is rebased on v5.18.
> 
> Not a great choice of base, really.  mm-stable or mm-unstable or
> linux-next or even linus-of-the-day are all much more up to date.
>

I'll rebase it to linux-next in v6.
 
> Although the memcg reviewer tags are pretty thin, I was going to give
> it a run.  But after fixing a bunch of conflicts I got about halfway
> through then gave up on a big snarl in get_obj_cgroup_from_current().
>

Got it. Will fix.

> > RFC v1: https://lore.kernel.org/all/20210330101531.82752-1-songmuchun@bytedance.com/
> 
> Surprising, that was over a year ago.  Why has is taken so long?
>

Yeah, a little long. This issue has been going on for years.
I have proposed an approach based on objcg to solve this issue
last year, however, we are not sure if this is the best choice.
So this patchset stalled for months.  Recently, this issue
was proposed in LSFMM 2022 conference by Roman, consensus was
that the objcg-based reparenting is fine as well.  So this
patchset has recently resumed.

Thanks.
