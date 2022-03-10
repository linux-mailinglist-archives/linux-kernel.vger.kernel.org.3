Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE19D4D4ED1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 17:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242177AbiCJQSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 11:18:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242201AbiCJQSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 11:18:06 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6801B190C20
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 08:17:01 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id a14so4970830qtx.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 08:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o3XiKem00gLr34GESQrNS9nG0HHXcvKwNDWv//lSnUM=;
        b=1fMvNcrI8SVPpYX5QeQXT/4iXJRVTUzJeQd1sa60b2pCKrmUm9NbtttV/Kyt8R5muB
         bwwpBmP5tj0wbJabkvNrWbTYUMXQ1ir91xgoRqdvbXkVfhQPTYQ2Y58FwiFCM26tzVbr
         rroGMlE+9VDqfWr13l06K8AMZkyhLkkDKU694V6IZoQSJyDXELYvYuJ4s+lSC5LUu0g/
         0arzgD1FEFOxFyaqL4DMiESYWo/unfntY4t++86tkpIS0ezudYQGGho2nAf+HLE9zipp
         kEEr1OwgMF4GSXwLeMJUoCjOrHkm8LUYuUshvd6q/YZLWgS2P5DB8KKNgkzJ9IqxuIbK
         atyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o3XiKem00gLr34GESQrNS9nG0HHXcvKwNDWv//lSnUM=;
        b=GQilf8NfBTge1x/751pvGlUY18ECb58kgSeBE5ceWFvT6CrTUBWgY8ZUnwHvJhQ5ez
         sGb+FZdb5YFX26ZEI5laydXa51QpmMC6fKL9JzMS0DOEUcF6AtDB9rYAmv/veoFdHFnW
         L2s2t+xLE1iKDKR2ZgKPQ6jfXWyTgXkfklfSteNxyCjY0Hj7wrPVzaqRqzacqoYdMMW6
         Us98QsMUCl9GxWEFgaokeaAmL1vvedkQas2Q7pQXnmPnzwKUBQAb3j+Xo4cn3bw98z7b
         8Riz60ge16aWexEH9L5OXJVdgDPVJDlxfSIauPiLZ6AIe4+lrFYy7l2PjHx0XvVv9Ruz
         Kc3Q==
X-Gm-Message-State: AOAM530K/f5z5yYPoVpTjpo98p+bw4xRl3p1iN0sfxv+KSRrY4xV/9iG
        dw439231E65caBVfXY9qCQjwSA==
X-Google-Smtp-Source: ABdhPJxHk9T5sCR1iHYOfvBRYoGqWAwMh2DfAxFoPQdXl/cWJ0bsam+OAT9uib4F75e/XrCLQt9oiw==
X-Received: by 2002:ac8:5fd1:0:b0:2d9:4547:9ddb with SMTP id k17-20020ac85fd1000000b002d945479ddbmr4468324qta.149.1646929020380;
        Thu, 10 Mar 2022 08:17:00 -0800 (PST)
Received: from localhost ([2620:10d:c091:480::1:5de6])
        by smtp.gmail.com with ESMTPSA id f14-20020ac8068e000000b002dd1bc00eadsm3187735qth.93.2022.03.10.08.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 08:17:00 -0800 (PST)
Date:   Thu, 10 Mar 2022 11:16:41 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     cgel.zte@gmail.com, axboe@kernel.dk, viro@zeniv.linux.org.uk,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org,
        Yang Yang <yang.yang29@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>
Subject: Re: [PATCH] block/psi: remove PSI annotations from submit_bio
Message-ID: <YiokaQLWeulWpiCx@cmpxchg.org>
References: <20220309094323.2082884-1-yang.yang29@zte.com.cn>
 <Yij9eygSYy5MSIA0@cmpxchg.org>
 <Yime3HdbEqFgRVtO@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yime3HdbEqFgRVtO@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 09, 2022 at 10:46:52PM -0800, Christoph Hellwig wrote:
> On Wed, Mar 09, 2022 at 02:18:19PM -0500, Johannes Weiner wrote:
> > On Wed, Mar 09, 2022 at 09:43:24AM +0000, cgel.zte@gmail.com wrote:
> > > From: Yang Yang <yang.yang29@zte.com.cn>
> > > 
> > > psi tracks the time spent submitting the IO of refaulting pages[1].
> > > But after we tracks refault stalls from swap_readpage[2][3], there
> > > is no need to do so anymore. Since swap_readpage already includes
> > > IO submitting time.
> > > 
> > > [1] commit b8e24a9300b0 ("block: annotate refault stalls from IO submission")
> > > [2] commit 937790699be9 ("mm/page_io.c: annotate refault stalls from swap_readpage")
> > > [3] commit 2b413a1a728f ("mm: page_io: fix psi memory pressure error on cold swapins")
> > > 
> > > Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
> > > Reviewed-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> > 
> > It's still needed by file cache refaults!
> 
> Can we get proper annotations for those please?  These bio-level hooks are
> horrible and a maintainance nightmware.

The first version did that, but it was sprawling and not well-received:

https://lkml.org/lkml/2019/7/22/1261
