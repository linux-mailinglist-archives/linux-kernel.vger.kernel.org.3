Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F534CDD48
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 20:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229565AbiCDTUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 14:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiCDTU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 14:20:29 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C48E182BDF
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 11:19:34 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2dbf4238d6bso79121767b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 11:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=UDWcKffKui4XwCKVJHIK+JVgQsKzY1Vbou/8cX6kuGw=;
        b=CskeBnwYi8AGR1jJSShOOv9vPjSw3nXsL0l5QH7mRd/t83w9MJWkOfeGH4iQoL479x
         pfbd0WWZGZOZSIbK25Gku4N12pDwSd3DXSCGHW0PP8QpWJVpFwfevzo125a4NXBCy2Im
         2YcgpvdiAsCDYE7UJJKc6Blc4scDwLzh7DWXz5L/b9aja3S44fW/cdVRODkAai3QV1Or
         5GkTgUWg+DFo7OTIRBHrZByAz/iA2yzQpRtM7kPZV37u1LllMhDZpQtI/cuajuNfPqds
         n4ctvCA5ojacfhEsygQyyY1Uu56hqvg1sMSi2uxGp83PVmcd1ixA6N8iak3UM5Z4dT8C
         my+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=UDWcKffKui4XwCKVJHIK+JVgQsKzY1Vbou/8cX6kuGw=;
        b=fQjg2+l2r8Ns+xybYGafGuCA22TiHVNgZLFarwa3Jqt1fhLVckB5y9NolcJ81QHEqi
         rWs4SlKgMk4bYuTSYUjlLdxnL2A0J1r5BAmmRJzlTQtrKFLlXWL+QHZYEzXV07ouHWNA
         2/w1KSR2+zYd9p9/jx0+uLT4JiNeqIj7scQUMGaljOC53ZpOlDl9YhSkqbDivZUWfpn1
         vk1Cl2XSUHJdHru4aERnpsbOqKUIijfw6vu424lUj3U4f057vuP0odfJdvsChf7TSFwO
         0RUVHAWV0d1xWH20O0GZHaR4NUF9ssW7fGHlyoongf37kOSPfu4xt3nY00ElUcqFqqUK
         Y98A==
X-Gm-Message-State: AOAM531NRDGZ51rDK2S7kdmGj2sNMNXsVfzEUjNzQwTV3NHquxWTgTxx
        +AERnMezVXvjnvguM6yjBzqlo/sZfBGtMw==
X-Google-Smtp-Source: ABdhPJzojehDkLC7mTTaV1b/BxVv+/dWays+AM4ORyKClLmTCxSgpe0Mqjt2vxpfifi3i2RbT/mKxzIIgJQc4Q==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:a5b:f8d:0:b0:628:620c:a45f with SMTP id
 q13-20020a5b0f8d000000b00628620ca45fmr21458679ybh.17.1646421567384; Fri, 04
 Mar 2022 11:19:27 -0800 (PST)
Date:   Fri, 4 Mar 2022 19:19:24 +0000
In-Reply-To: <20220304170215.1868106-1-eric.dumazet@gmail.com>
Message-Id: <20220304191924.75zuylhmgvlb6zt4@google.com>
Mime-Version: 1.0
References: <20220304170215.1868106-1-eric.dumazet@gmail.com>
Subject: Re: [PATCH v2] mm/page_alloc: call check_new_pages() while zone
 spinlock is not held
From:   Shakeel Butt <shakeelb@google.com>
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Eric Dumazet <edumazet@google.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>, Wei Xu <weixugc@google.com>,
        Greg Thelen <gthelen@google.com>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 04, 2022 at 09:02:15AM -0800, Eric Dumazet wrote:
> From: Eric Dumazet <edumazet@google.com>

> For high order pages not using pcp, rmqueue() is currently calling
> the costly check_new_pages() while zone spinlock is held,
> and hard irqs masked.

> This is not needed, we can release the spinlock sooner to reduce
> zone spinlock contention.

> Note that after this patch, we call __mod_zone_freepage_state()
> before deciding to leak the page because it is in bad state.

> v2: We need to keep interrupts disabled to call  
> __mod_zone_freepage_state()

> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Mel Gorman <mgorman@techsingularity.net>
> Cc: Vlastimil Babka <vbabka@suse.cz>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Greg Thelen <gthelen@google.com>
> Cc: Hugh Dickins <hughd@google.com>
> Cc: David Rientjes <rientjes@google.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
