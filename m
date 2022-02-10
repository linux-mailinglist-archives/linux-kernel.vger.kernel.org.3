Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B774D4B0484
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 05:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233396AbiBJEhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 23:37:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiBJEhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 23:37:37 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AA1137
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 20:37:33 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id p7so3775339qvk.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 20:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Yn6D5zszKlFFTj2ppKQupmnyQ5qIo8Lc60YvIthRsEY=;
        b=qW92ZoTcKqckRiGPMTxt23+m9OqS4N94afHcq9j/4BRKnlwh8S/OxBT5OZ/yJZhkg+
         wXMBKMIhHrYjR++xkkK2a0vFPdhpK25q8eVdi5fnPRFDmrJojRhj9FeqlFbSxWGVsuri
         NTT1MzCBARnAUBH+7hGwqe1Ui8V3nXhoUwKKHDDzDr92rr1CVDQusOrqh3UZgyjmBgjQ
         TPCnLg6i9mgNh8Avx5fy11ERWw77IzlyGY0Ssd6BGVE52BB+yuAhlOeMkdSzl1gaF0W+
         O1o9z9w5qvsqPXB/7XCoCJPysXUj5ZsZZJU8IpwwHDuU6de2OHPCdGCwPUxplt4heCBl
         PKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Yn6D5zszKlFFTj2ppKQupmnyQ5qIo8Lc60YvIthRsEY=;
        b=Nh4M8ZPqv2yXkUPSN0iBzcxkOMD22NIdSlJH2suSsBiuKCX9bkf1GORmuuSD8Kri5I
         cDuRwTEUuiz2DQbdBx/Fkm5uNeuvOkKzHkcFqoDnZ9w9X8eDyQtoKOjBdzWXXGPKwn5d
         kzMFPXGrxcuyQJCatEgG7WGR5NaD3Lg4UNlOEvnZ8AWcCYi/tAkw2RRXV/N3c/1CqX9b
         66ywNAhHClTXy66Eu8NNUkvGpLPYCrM0xmD/hJOkj5SlBMKq5Tw4oz4iFN8bcN6/ww9x
         +xzV3XoptIeoxyRoc5JXLcaK+lb7+bmrz29PjiYm5KEuyncRfrtSnfD8qmOmYVfC7OE2
         zUCg==
X-Gm-Message-State: AOAM53248zECQs/SivxYUVmZyMJ3PVR8bP4SiSRh3nXFytFZzZpUK30k
        9VI6WreXGOH4n/kIf0HY8JoK2Q3/jDl4sA==
X-Google-Smtp-Source: ABdhPJxuuIgMQDhC4FYhTpD5F+jZXdAdK+z59w4/q95HooTGaDUbGSqm89h2112MIthns8qBBeCe/A==
X-Received: by 2002:a05:6214:1bce:: with SMTP id m14mr3865403qvc.102.1644467852786;
        Wed, 09 Feb 2022 20:37:32 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p10sm8941203qtx.62.2022.02.09.20.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 20:37:31 -0800 (PST)
Date:   Wed, 9 Feb 2022 20:37:16 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Geert Uytterhoeven <geert@linux-m68k.org>
cc:     Hugh Dickins <hughd@google.com>, SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH for-mm 1/2] mm/internal: Implement no-op mlock_page_drain()
 for !CONFIG_MMU
In-Reply-To: <CAMuHMdV7EaHK5zJAbLU9eKwMYxFdAQ0TiS+Ydg56mGkBv09dHA@mail.gmail.com>
Message-ID: <be1b571c-ca4b-ab4a-ea8c-43fd579e3a32@google.com>
References: <20220209094158.21941-1-sj@kernel.org> <20220209094158.21941-2-sj@kernel.org> <715a8b2e-1048-c098-8b89-bcf3c13cbd75@google.com> <CAMuHMdV7EaHK5zJAbLU9eKwMYxFdAQ0TiS+Ydg56mGkBv09dHA@mail.gmail.com>
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

On Wed, 9 Feb 2022, Geert Uytterhoeven wrote:
> On Wed, Feb 9, 2022 at 4:38 PM Hugh Dickins <hughd@google.com> wrote:
> > The thing is, SeongJae's patch makes me wonder, why did it not need a
> > !CONFIG_MMU definition for need_mlock_page_drain() too?  That's because
> > mm/swap.c's call to it is under an #ifdef CONFIG_SMP, and I imagine that
> > CONFIG_MMU=n usually goes along with (but does not necessarily imply?)
> > CONFIG_SMP=n.  It'll be safer to add a need_mlock_page_drain() stub too.
> 
> RISC-V K210 is SMP without MMU.

Thanks Geert, that makes it very clear that we also want the stub for
need_mlock_page_drain().  I'll follow now with update of SeongJae's patch.

My fear of wider implications of not having CONFIG_SMP turned out to
be a false alarm.  The UP lru_add_drain_cpu() calls mlock_page_drain()
just like the SMP one does: the difference between them is merely that
the UP case doesn't need an efficient way for asking in advance whether
drain on another cpu will be needed.

Hugh
