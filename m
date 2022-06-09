Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6400754424D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 06:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236551AbiFIEDt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 00:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiFIEDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 00:03:44 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A3C7CDE1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 21:03:43 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2ff7b90e635so228961817b3.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 21:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bhGauVid88M2xfzqgH6+LgDOjyyWjact/QPhQzDbR78=;
        b=tV/gAoUoowgLPEjzHoq4Upm0xFu3ArE2deAaoABjpx5ze3SNxLcMV+K4/bnZX4/B0u
         m5j6yUQRocdDqWrnUUvQK+to5PTCe8UyNcLPhGGj6jyPR65lT9DdRbaZb3q3RFW+DbJt
         PQnPNHEquFsN2Kmux+Lh4eRBR04amv/NRnIbra7cUhtoU4VImvtlahQ90gjMtFIV/6FM
         X0lufO+vycL9++U34MppjoJHDNAG6aPP3PrOcBOEMJQr38bi4vihQ/ivpj5a0Ab2N/rg
         lCslEiVifNPekaX4WmWLPpFjBPhqX/hRsGhTjxwWbGnQgByPE9KMOvNoi6AYgXFBUd8+
         9jHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bhGauVid88M2xfzqgH6+LgDOjyyWjact/QPhQzDbR78=;
        b=DT3gRKTuuYCizbzLGH44DEcXFUl/MZDu70BprSocx/vc40y2mLFhvP9WiQecYrjZZ4
         ViT2jpG6pMLkmJxMqhQDpKiVl+5OUYXWNQ0lOnyB/NbjCKG97GdE3FUXGo/5NM99DzhO
         45rw+K/sfW7r5R+3wtUTL6iG7OIaq+h1tQFTi5aHDdDXFxsOik9XDnRnpQ0LwsNvO3he
         0Mp6DKAzAn2Y7bkrVuypzPPXFBmR/zGob3zS3hVsxnFkLHJR956XzX76nPdcuAiV0jEr
         nXdhiewQgzSdf7GQ4i2Yp2txB1MZBC54KNPmiY5TZEbyaAWTGYLTFYkieNbkfeb67gDM
         2S0w==
X-Gm-Message-State: AOAM533/sWSkV669aoP2ktNBUabYo8RBnmsPwuWjbMq8cg2KUhD5cjNn
        V5NxIfHXl/2MFgxegnDncs9fIUmiVC8DZcebp8FPQA==
X-Google-Smtp-Source: ABdhPJw50GpSGcOi3ONcY1gJm8BwLu4C4krZfIrPlbH0Yc9FUEBkBSynLT8zXpsU8+LvuJPQt8aEbs7RCzZkw2dHaqA=
X-Received: by 2002:a0d:d997:0:b0:30c:962e:7aa6 with SMTP id
 b145-20020a0dd997000000b0030c962e7aa6mr42075679ywe.278.1654747422845; Wed, 08
 Jun 2022 21:03:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220607070214.94443-1-songmuchun@bytedance.com>
In-Reply-To: <20220607070214.94443-1-songmuchun@bytedance.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 8 Jun 2022 21:03:31 -0700
Message-ID: <CANn89i+wqVnfwOcpvnBwoF4ZvjZL-RcsqdT5khu-3CHpCcoKTQ@mail.gmail.com>
Subject: Re: [PATCH v2] tcp: use alloc_large_system_hash() to allocate table_perturb
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     David Miller <davem@davemloft.net>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Willy Tarreau <w@1wt.eu>
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

On Tue, Jun 7, 2022 at 12:02 AM Muchun Song <songmuchun@bytedance.com> wrote:
>
> In our server, there may be no high order (>= 6) memory since we reserve
> lots of HugeTLB pages when booting.  Then the system panic.  So use
> alloc_large_system_hash() to allocate table_perturb.
>
> Fixes: e9261476184b ("tcp: dynamically allocate the perturb table used by source ports")
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---
> v2:
>  - Add Fixes tag and replace kvmalloc_array with alloc_large_system_hash suggested
>    by Eric Dumazet.
>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.
