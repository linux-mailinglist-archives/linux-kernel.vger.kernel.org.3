Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A035ABAC5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 00:20:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbiIBWUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 18:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiIBWUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 18:20:47 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66623D41AD
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 15:20:46 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id h20-20020a056830165400b00638ac7ddba5so2385401otr.4
        for <linux-kernel@vger.kernel.org>; Fri, 02 Sep 2022 15:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=oEjTtmEeJyadPZmcREP7RymvVzUAf/2+rbHBKgatgtM=;
        b=dV6ExSd2XB1gJOwm7oLykcYRWQ843sqJEFXi9ZfhpRi9rBnSwIsGPLH/mPBBeiNHx+
         b/3FV4+r5nwjpLb7o9XsCecIXx8gMbh0ySGLwQNDg2gpV5IpELr6EONjxx5xEKewfKRw
         SgZmFfl7hcBrG4+B9tLtVQLfO4WnTc+SEV/rQx4quyI80KJKor1TmjfW0z4E7QURxgKU
         q0yAkumwH5aZI8rXPtyfHhskckMi+P4aTeQW3Ut2RVOoT0WehCeYmik1c7DlHj/GVZFZ
         vjwf1cHvLZJPgKiuyAH8uIQyqhBsT40KlX8bFOd6+t4ZvZAfIbjCgwOkHYKk7T196HrW
         zcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=oEjTtmEeJyadPZmcREP7RymvVzUAf/2+rbHBKgatgtM=;
        b=dR8s/mLCNVnUJyEUPuGEZDGE12OYszBVh3BH6JIKD6pgOxTRjBnmKvx7J5425/TR92
         HAhO7J17qGuaIpzbdPDdQDonEdgC7kImpklN5mXd1DcziDZ/ZmBT6c6H+8PYJeG/TU54
         lnYySl+lHC+T6Hzb8jczDbF3L7nDbf3UNuBqPmsKTq3ev3s7RcAm8MWs8ENxTWmXhEpz
         QGlJgGBcy2R0eJtN8xM0hugAPk/RDWUNLDvvj8S8dTs1SqXwEyRidot0nvwu+t4KKx44
         BbSlAHaRrU8Dz8/cIrN1MtYqGmSpCBu9UhAgoxmRxp0E8Tf1HeaYZUuru2Y1oUByl64M
         120Q==
X-Gm-Message-State: ACgBeo0xKYnhgQnlBvGkN3C8SxZDNxxITJwRdXuR2+wjuxEx0bT07p2j
        NmF9mHe0oXUmJYYFjJzZ3YE=
X-Google-Smtp-Source: AA6agR6geISkTUTg+VUqoPKAR12Su+GU6Jidr+aIw1F+rISW6ng+smmpoWGv8vgHcMWpm0UW1Lrn0A==
X-Received: by 2002:a05:6830:3146:b0:637:18d7:5715 with SMTP id c6-20020a056830314600b0063718d75715mr15333214ots.312.1662157245645;
        Fri, 02 Sep 2022 15:20:45 -0700 (PDT)
Received: from localhost ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id b11-20020a9d754b000000b0061d31170573sm1617773otl.20.2022.09.02.15.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Sep 2022 15:20:45 -0700 (PDT)
Date:   Fri, 2 Sep 2022 15:20:44 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] tools: Fix compilation after gfp_types.h split
Message-ID: <YxKBvExWNAB8xN3b@yury-laptop>
References: <20220902191923.1735933-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220902191923.1735933-1-willy@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2022 at 08:19:23PM +0100, Matthew Wilcox (Oracle) wrote:
> When gfp_types.h was split from gfp.h, it broke the radix test suite.
> Fix the test suite by using gfp_types.h in the tools gfp.h header.
> 
> Reported-by: Liam R. Howlett <Liam.Howlett@oracle.com>
> Fixes: cb5a065b4ea9 (headers/deps: mm: Split <linux/gfp_types.h> out of <linux/gfp.h>)
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Yury Norov <yury.norov@gmail.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Reviewed-by: Yury Norov <yury.norov@gmail.com>

> ---
>  tools/include/linux/gfp.h       | 21 +--------------------
>  tools/include/linux/gfp_types.h |  1 +
>  2 files changed, 2 insertions(+), 20 deletions(-)
>  create mode 100644 tools/include/linux/gfp_types.h
> 
> diff --git a/tools/include/linux/gfp.h b/tools/include/linux/gfp.h
> index b238dbc9eb85..6a10ff5f5be9 100644
> --- a/tools/include/linux/gfp.h
> +++ b/tools/include/linux/gfp.h
> @@ -3,26 +3,7 @@
>  #define _TOOLS_INCLUDE_LINUX_GFP_H
>  
>  #include <linux/types.h>
> -
> -#define __GFP_BITS_SHIFT 26
> -#define __GFP_BITS_MASK ((gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
> -
> -#define __GFP_HIGH		0x20u
> -#define __GFP_IO		0x40u
> -#define __GFP_FS		0x80u
> -#define __GFP_NOWARN		0x200u
> -#define __GFP_ZERO		0x8000u
> -#define __GFP_ATOMIC		0x80000u
> -#define __GFP_ACCOUNT		0x100000u
> -#define __GFP_DIRECT_RECLAIM	0x400000u
> -#define __GFP_KSWAPD_RECLAIM	0x2000000u
> -
> -#define __GFP_RECLAIM	(__GFP_DIRECT_RECLAIM | __GFP_KSWAPD_RECLAIM)
> -
> -#define GFP_ZONEMASK	0x0fu
> -#define GFP_ATOMIC	(__GFP_HIGH | __GFP_ATOMIC | __GFP_KSWAPD_RECLAIM)
> -#define GFP_KERNEL	(__GFP_RECLAIM | __GFP_IO | __GFP_FS)
> -#define GFP_NOWAIT	(__GFP_KSWAPD_RECLAIM)
> +#include <linux/gfp_types.h>
>  
>  static inline bool gfpflags_allow_blocking(const gfp_t gfp_flags)
>  {
> diff --git a/tools/include/linux/gfp_types.h b/tools/include/linux/gfp_types.h
> new file mode 100644
> index 000000000000..5f9f1ed190a0
> --- /dev/null
> +++ b/tools/include/linux/gfp_types.h
> @@ -0,0 +1 @@
> +#include "../../../include/linux/gfp_types.h"
> -- 
> 2.35.1
