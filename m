Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A834D2534
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 02:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbiCIBIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbiCIBHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:07:50 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C35F13DE2F
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 16:48:11 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id x200so1184631ybe.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 16:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6blG6EAzX4w/WH2eHf6lZLaVJfDBuoOmPYe51zQt/4A=;
        b=V39oqsH8PidHbrDaeyYTPlj2xsTvihPzTyN3cv91d+WXA3fnkhlv/m377gWtuzDsW1
         N+UDbiIOoqMlomI5DPKFmOHepNc1QiVzaQtNWW59h74OSDKEKok24ndZz+aiTXXsIqvi
         edgKHFlHEnHob8ds7KamIk0IoygOYIRjIAWfH5+ooKI/B3438XnSNQnFCDvOc9Bwih74
         3hlTQbpsnTKyvSRPdyJs3pVAl6GEN0sOR0pKI2d9zxCd/CyBxMhiLkLeIlSW7+LUTkPB
         SQUWSCOThdhBFxBgonCR0fe+eCBmIa5e/5TJHAnCo24qKGje3VPimwIZSCb6zy/sOkZP
         wmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6blG6EAzX4w/WH2eHf6lZLaVJfDBuoOmPYe51zQt/4A=;
        b=N8dqYi15iraRzn3Ycgc7myVMRV0cgTHR/GS2aFH9+d3Wi3HA/JY7p0Kc8QTtnRUkul
         U4oGmbMbcuAhbYGWt2/6sWbaQ/Ry2REV9Jp2ZsRwxDXCwm0Vb3NJv4zbfZlYPkZDrpmv
         65xshr2DayaARjKTdmePR2e68/l/dqfSKmCXBniEDgtzg6BeHREJI84ATYb4xyC3bQ7k
         xhjuB8coJqRkrQS3qsJKU7Nq9UfMpJVV2Wnv8K+fQ/AH6B4r5RIzoE2q4ruXFpIfaPV2
         wBzdki7v1tQ8AjLuxZkFzd0ZlPnS1O+xdP0utnsMaYU81KXhOBYu+6/hIXFL1+GFOGrE
         kEjw==
X-Gm-Message-State: AOAM532h3Ytg1lxfZ61LGL0FVtsC3tHr/+SqtQYjpDVECQWULYSlbLtu
        suS2cFbUr/1/W0jyQtWYIYfB7hwptIf6CnMiXukSVE+PmB2OThmD
X-Google-Smtp-Source: ABdhPJxskEt4z+ERhyGQD17DQXn+/I/xUbH/kIs14UdAcFpT7QiQvRSl/uyYzEI6mSU/i59zf8y4l96MGMXa7to9HA8=
X-Received: by 2002:a25:d188:0:b0:628:ba86:ee68 with SMTP id
 i130-20020a25d188000000b00628ba86ee68mr14027361ybg.427.1646783399600; Tue, 08
 Mar 2022 15:49:59 -0800 (PST)
MIME-Version: 1.0
References: <20220304170215.1868106-1-eric.dumazet@gmail.com> <20220307091541.GD15701@techsingularity.net>
In-Reply-To: <20220307091541.GD15701@techsingularity.net>
From:   Eric Dumazet <edumazet@google.com>
Date:   Tue, 8 Mar 2022 15:49:48 -0800
Message-ID: <CANn89iLmwT4XQ6JPi4C7dO+Q2O_j7HK19-TAo4nA1NUf8ZSLBw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/page_alloc: call check_new_pages() while zone
 spinlock is not held
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>
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

On Mon, Mar 7, 2022 at 1:15 AM Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Fri, Mar 04, 2022 at 09:02:15AM -0800, Eric Dumazet wrote:
> > From: Eric Dumazet <edumazet@google.com>
> >
> > For high order pages not using pcp, rmqueue() is currently calling
> > the costly check_new_pages() while zone spinlock is held,
> > and hard irqs masked.
> >
> > This is not needed, we can release the spinlock sooner to reduce
> > zone spinlock contention.
> >
> > Note that after this patch, we call __mod_zone_freepage_state()
> > before deciding to leak the page because it is in bad state.
> >
> > v2: We need to keep interrupts disabled to call __mod_zone_freepage_state()
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Mel Gorman <mgorman@techsingularity.net>
> > Cc: Vlastimil Babka <vbabka@suse.cz>
> > Cc: Michal Hocko <mhocko@kernel.org>
> > Cc: Shakeel Butt <shakeelb@google.com>
> > Cc: Wei Xu <weixugc@google.com>
> > Cc: Greg Thelen <gthelen@google.com>
> > Cc: Hugh Dickins <hughd@google.com>
> > Cc: David Rientjes <rientjes@google.com>
>
> Ok, this is only more expensive in the event pages on the free list have
> been corrupted whch is already very unlikely so thanks!
>
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
>

One remaining question is:

After your patch ("mm/page_alloc: allow high-order pages to be stored
on the per-cpu lists"),
do we want to change check_pcp_refill()/check_new_pcp() to check all pages,
and not only the head ?

Or was it a conscious choice of yours ?
(I presume part of the performance gains came from
not having to bring ~7 cache lines per 32KB chunk on x86)

Thanks !
