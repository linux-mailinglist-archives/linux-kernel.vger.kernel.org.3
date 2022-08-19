Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3F059A98A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 01:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243132AbiHSXeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 19:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241985AbiHSXeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 19:34:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 425BE62AAE
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 16:34:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D2057618A0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 23:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A77DC433C1;
        Fri, 19 Aug 2022 23:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660952041;
        bh=1ex3S37pImaGea2RTEMBFJZL5Q2Fyharq5elZu5Uhrk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tlYQ3GLsCqHp+8R2FdtK2KF1FHDfPHqeM4x5wTW92kUkID0q4IY7pDyh0p6c1uB1C
         uZ+UNFZEuMy2VrYCeItpESw3GshHZgSsZvPqZh8tEqNblOtYkD4DR7mr5Hm+/w9Xi2
         g1/8UAMMRsKAamDhUDFvvGYyrE61GvVm9KuuErHrBCPQJl7XbCb3SPMortDNAJ+nNQ
         /zuBSEGy/xGkCoHpGGU4ZyHA1/Gav4O2GyN7Bf5Sz47inlRZ4Z1mHsAKC1/a3q8qpX
         DzkXZ9RakQubhCCx5K0udEAdJd7s0Y0Otu0jVK0qZtk7IbR1RvzTVCZ3hXYrHRREd0
         yN3MFc60VCeIQ==
Date:   Fri, 19 Aug 2022 16:33:59 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, stable@kernel.org
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix wrong continue condition in GC
Message-ID: <YwAd5wyhXIs1n108@google.com>
References: <20220813143709.11909-1-jaegeuk@kernel.org>
 <65562b32-505f-796e-305a-d1b03baeb388@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65562b32-505f-796e-305a-d1b03baeb388@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/15, Chao Yu wrote:
> On 2022/8/13 22:37, Jaegeuk Kim wrote:
> > We should decrease the frozen counter.
> > 
> > Cc: stable@kernel.org
> > Fixes: 325163e9892b ("f2fs: add gc_urgent_high_remaining sysfs node")
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   fs/f2fs/gc.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index 6da21d405ce1..7e4b41240d59 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -102,7 +102,7 @@ static int gc_thread_func(void *data)
> >   					sbi->gc_urgent_high_limited = false;
> >   					spin_unlock(&sbi->gc_urgent_high_lock);
> >   					sbi->gc_mode = GC_NORMAL;
> > -					continue;
> > +					goto next;
> >   				}
> >   				sbi->gc_urgent_high_remaining--;
> >   			}
> 
> Why not:
> 
> 	if (!sbi->gc_urgent_high_remaining) {
> 		sbi->gc_urgent_high_limited = false;
> 		spin_unlock(&sbi->gc_urgent_high_lock);

Should not call spin_unlock, if so. Anyway, let me send v2.

> 		sbi->gc_mode = GC_NORMAL;
> 	} else {
> 		sbi->gc_urgent_high_remaining--;
> 	}
> 
> Thanks,
