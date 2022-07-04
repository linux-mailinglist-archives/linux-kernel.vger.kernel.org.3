Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23E556587A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229892AbiGDOTx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiGDOTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:19:49 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC134E96
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:19:48 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id h19so10032339qtp.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 07:19:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sEJN53L6BzfWwRddod8bktU/FwcXRe3wrheKMHUBD0M=;
        b=gzmCelenOs+wCtg9SR9PXcTu98xn8hlT6cjxHUdyNkLb92N0rc7GCxtoJiENNgjk/i
         oZ2l5otI8zHMQRCfx8zua97F3TZw2xx02hcvb2sL+IlQN/1k6Mm0xQOlmifuam46CpAY
         qPuLL1Oh9yjlXtiDGnPge1fB7XQvycM5ycp8L71I6+qd7u/zVqJe/rLeszDu10Qoc62f
         QWMDvarZfEA3asWZKKAYbqu31ejs1wBhxFMIH28qK2lOFbjCJKj/hiMq7U5v0m5EUBlZ
         H72aDNRWwkbsm2BfE3t1UEzLL8agYUwszUOKPljPC9Kt5sQF6hVnUWz+zPnhGztJzZHD
         1jQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sEJN53L6BzfWwRddod8bktU/FwcXRe3wrheKMHUBD0M=;
        b=PrbNeB9ddZez3jgmpV8kdjfFOUbLiVlTW/mg3hrvxFqjmAfLuoh6BEf9Anqu33pAuW
         E4tgwP707Ky62RgTs6vf/8Wytyo5VWXopo0HZMAwVl2SQpIls1q8J9eH5iZCN6iZ6T2z
         /6hThqdWrsRyl+6iVxTbL9iZVZsjHmKwyWdGnKcHGq6br9nIo8K5wsqvxi+IJ0x6kxKf
         MF0fCJO/GxF9DQZnlrXAq2N39ULercu88P12lk5cokj1rLOqXoXzpIZ0jFSZC0NlKxZ7
         5a+EIK2EBKwkDXrh2oCXPdiiFAmfAwK5hNu+iby9hVZnauQmmbqls377qOxIWVzhcASU
         C72w==
X-Gm-Message-State: AJIora9w245yDunzsSK1GiATy9t0rlTf0tRlPDMgNsywthUqG2dVECrJ
        wNDy0IbV2ran/gzKdFohZLL3Wy6m0CB4BCk=
X-Google-Smtp-Source: AGRyM1vGNT5DAaqpGF5lfdyet3EM+DFcR9G2Fp5/GjeGD7+0UTAZfWxJ0uk288PfxMm/sopnV1P8pQ==
X-Received: by 2002:a05:622a:187:b0:319:b2d:4aff with SMTP id s7-20020a05622a018700b003190b2d4affmr24648682qtw.386.1656944387962;
        Mon, 04 Jul 2022 07:19:47 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id g16-20020ae9e110000000b006aefa015c05sm23343969qkm.25.2022.07.04.07.19.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 07:19:47 -0700 (PDT)
Date:   Mon, 4 Jul 2022 10:19:46 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
Subject: Re: [PATCH 3/3] 9p: Add mempools for RPCs
Message-ID: <20220704141946.4yqo2o6ih5zrqjmy@moria.home.lan>
References: <20220704010945.C230AC341C7@smtp.kernel.org>
 <2335194.JbyEHpbE5P@silver>
 <20220704130631.eq5txpq62gwvbvts@moria.home.lan>
 <1877940.0u7pHPiiHj@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1877940.0u7pHPiiHj@silver>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 03:39:32PM +0200, Christian Schoenebeck wrote:
> So simple that it already had one obvious bug (at least). But as it seems that 
> Dominique already supports your patch, I refrain from enumerating more 
> reasons.

So snippy.

> 
> > > However that's exactly what I was going to address with my already posted
> > > patches (relevant patches regarding this issue here being 9..12):
> > > https://lore.kernel.org/all/cover.1640870037.git.linux_oss@crudebyte.com/
> > > And in the cover letter (section "STILL TODO" ... "3.") I was suggesting
> > > to
> > > subsequently subdivide kmem_cache_alloc() into e.g. 4 allocation size
> > > categories? Because that's what my already posted patches do anyway.
> > 
> > Yeah that sounds like you're just reimplementing kmalloc.
> 
> Quite exaggerated statement.

I'm just pointing out that kmalloc() is just a frontend around
kmem_cache_alloc() that picks the cache based on the size parameter... so...
still sounds like you are?

Not that there's never a legitimate reason to do so, but it does raise an
eyebrow.
