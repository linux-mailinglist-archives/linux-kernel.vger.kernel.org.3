Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0107F4EFA3D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 21:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351459AbiDATDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 15:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241935AbiDATDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 15:03:19 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C18232D0A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 12:01:28 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id k21so6608460lfe.4
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 12:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oDw8S5KrFCWwz/lG5l+hXBDsrtf0IQ3Qu1r88NhJ04Q=;
        b=JO2RfQc0LSop+AwFNQt7LZomcriv9oithuEpIPz1RWcT7BtDWwYWEllPLjFCJk/+B5
         NpRbbmfBwT/y4YIiiLNkzwmiDVep2a32Q1EfobrHj1iVl+veNANmaIf7pwi6LGT5oaBS
         HzFohZtFV5xDxWv2+R58A5YDtFJbjZX65VapA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oDw8S5KrFCWwz/lG5l+hXBDsrtf0IQ3Qu1r88NhJ04Q=;
        b=15+X7ZgyW9xAWRmO617PR2g8+Sn2gbxjcgdbHtlpLiZ+qVZTCI4xdRhjMH+vnzrZ9N
         hGOTvRCzT7u5nHZ6AUbLj5DehXNWBhv8NsgLfHHpcqlwrWzrU9HVyHio/7xA+oNfYTyu
         WYPDKihLsbCsPuaAykvi8Zr75GsjDKGzU3vzx+lpWnK70e9dyx9p+WCzfoxzrKtLSgbB
         O7tbzdtznTA84OFx/9lRhObB/b2L2akARH0TkDshlUqZjZyFBUQA7WKwlffrh1wlxszu
         vCtWnHYOKkqok8VtTQiir6WoseY1v542NOMwDg0M88g2p+KbsULAAllFnlsdY+NqurDv
         6rnw==
X-Gm-Message-State: AOAM531/RPE3OZ0A5/EeKEfLD/v+yS+Ee/D8R+limR0H5EvOIjcGi9pZ
        3JXAlw6sNdVVJ044vsGlISKOAavRJycDJC5Ota0=
X-Google-Smtp-Source: ABdhPJygF/8jDSc/98xpTh7S1HJ8HbQaSDCHsXa6+tRyejukIR6wlVtyChq4WqOOrm1zKM8O330ynw==
X-Received: by 2002:a05:6512:33d4:b0:44a:9971:de48 with SMTP id d20-20020a05651233d400b0044a9971de48mr14792574lfg.392.1648839685097;
        Fri, 01 Apr 2022 12:01:25 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id d11-20020a05651233cb00b0044ae32872fdsm160354lfg.147.2022.04.01.12.01.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Apr 2022 12:01:24 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id p15so6573140lfk.8
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 12:01:24 -0700 (PDT)
X-Received: by 2002:a05:6512:b12:b0:44a:ba81:f874 with SMTP id
 w18-20020a0565120b1200b0044aba81f874mr11728022lfu.449.1648839683880; Fri, 01
 Apr 2022 12:01:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220401181109.1477354-1-zi.yan@sent.com> <20220401181109.1477354-2-zi.yan@sent.com>
 <CAHk-=wifQimj2d6npq-wCi5onYPjzQg4vyO4tFcPJJZr268cRw@mail.gmail.com> <ADC113C0-F731-4835-AE3E-87C2302877B5@nvidia.com>
In-Reply-To: <ADC113C0-F731-4835-AE3E-87C2302877B5@nvidia.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Apr 2022 12:01:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgNxEq9BaxBSjC+RvKPsc5zuRwc1PGEvXqqX9vb1UALyA@mail.gmail.com>
Message-ID: <CAHk-=wgNxEq9BaxBSjC+RvKPsc5zuRwc1PGEvXqqX9vb1UALyA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: wrap __find_buddy_pfn() with a necessary buddy
 page validation.
To:     Zi Yan <ziy@nvidia.com>
Cc:     Linux-MM <linux-mm@kvack.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 1, 2022 at 11:56 AM Zi Yan <ziy@nvidia.com> wrote:
>
> How about the patch below? If it looks good, I will send v3.

I can't see anything worrisome, but by now I've looked at several
versions and who knows what I'm missing.

Making it inline and allowing a NULL 'buddy_pfn' pointer for the cases
that don't care might be an option, but I don't think it matters
hugely.

                   Linus
