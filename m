Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E67F4B765C
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:49:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238253AbiBORod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 12:44:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242669AbiBORo2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 12:44:28 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACBBE687F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:44:18 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id y18so13637024plb.11
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 09:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3joERcoQKId/zOkoKD6SJoazN6O1PmNm0Tu+J2P9YSI=;
        b=YgYgbr0K4iZYpvIS0mXDtaeLL5DkSUCJg76i9XndkniN82i0jhOg45lRnPuba3VZSi
         iPWHWcekY5egS/liL2WXby6spXFfIOPy5teIbH9WsnHq9QXWeR+DZaPV9JNPzduF7RXC
         Yqv+3QTuYMS5CQft4+nDdttei44BaXqIjxT6nxDRi9f248r1ltEOdjH7mcLKB8BigmZa
         kiYcIzl9SO3y6ilmvkOmfAU9hmVrjFehYf9aQJg7EkPXZf9i0WPKYrTa4EcIuDMfCvM5
         AJajgeDFnbieAzAl3nuMgas8Gl4MocplB/MXArAN35vkglG7r6ApWYbFHKKIykUVG+Z4
         UOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=3joERcoQKId/zOkoKD6SJoazN6O1PmNm0Tu+J2P9YSI=;
        b=3FXcoQL161CAfZ+ji6KcWs6gC3RKUcb5EU4v9pr8YS4EeDnRFeQv4iBixvAYbbjwzx
         Prmx2cNu7VbWNmI/LJYfqrKMHVmwSZFRhcNjv2L0LuB3S0PNFk/WBSShu7XsKukiRn/4
         ucocAm/7ibEhM6h012il33FnARkPLqOUXYZ08RlN8su3SYe7Ktg6Ub8iKId1ZUdBPAzj
         5XVoco+jFptXgiATiPsNdgaJjztyX7ExEhSKK3OkIlVi8qSOys4ZzGSDJyVjS/jTD3jC
         xYnA/U83RQeDZC0/FeRC/hfkggNtTrO+X1sqWtNiFI6RGm70jUY3K+RhK24iqMyUVSCv
         C/3w==
X-Gm-Message-State: AOAM531SnM6dlhVYcmMjNu63v0NdsVUpbfG/7Lchjawv1aSSMCzfMZtV
        lagGwFrmBLD2XziYJ55eonH24rW6Ogo=
X-Google-Smtp-Source: ABdhPJx6dNpICXka2jir8VDYSzAtQ50eldeKKX8qrCPLzXa60bSBip/upGFW8GLYek1NzR0S3ZfuFw==
X-Received: by 2002:a17:90b:2243:b0:1b9:e528:5496 with SMTP id hk3-20020a17090b224300b001b9e5285496mr5610729pjb.240.1644947057841;
        Tue, 15 Feb 2022 09:44:17 -0800 (PST)
Received: from google.com ([2620:15c:211:201:6806:5397:3a20:7881])
        by smtp.gmail.com with ESMTPSA id s5sm2878098pfd.66.2022.02.15.09.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 09:44:17 -0800 (PST)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Tue, 15 Feb 2022 09:44:15 -0800
From:   Minchan Kim <minchan@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        CGEL <cgel.zte@gmail.com>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Yu Zhao <yuzhao@google.com>
Subject: Re: [PATCH] mm: page_io: fix psi memory pressure error on cold
 swapins
Message-ID: <Ygvmb+LYlU3KC05O@google.com>
References: <20220214214921.419687-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214214921.419687-1-hannes@cmpxchg.org>
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

On Mon, Feb 14, 2022 at 04:49:21PM -0500, Johannes Weiner wrote:
> Once upon a time, all swapins counted toward memory pressure[1]. Then
> Joonsoo introduced workingset detection for anonymous pages and we
> gained the ability to distinguish hot from cold swapins[2][3]. But we
> failed to update swap_readpage() accordingly, and now we account
> partial memory pressure in the swapin path of cold memory.
> 
> Not for all situations - which adds more inconsistency: paths using
> the conventional submit_bio() and lock_page() route will not see much
> pressure - unless storage itself is heavily congested and the bio
> submissions stall. ZRAM and ZSWAP do most of the work directly from
> swap_readpage() and will see all swapins reflected as pressure.
> 
> Restore consistency by making all swapin stall accounting conditional
> on the page actually being part of the workingset.
> 
> [1] commit 937790699be9 ("mm/page_io.c: annotate refault stalls from swap_readpage")
> [2] commit aae466b0052e ("mm/swap: implement workingset detection for anonymous LRU")
> [3] commit cad8320b4b39 ("mm/swap: don't SetPageWorkingset unconditionally during swapin")
> 
> Reported-by: CGEL <cgel.zte@gmail.com>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Acked-by: Minchan Kim <minchan@kernel.org>
