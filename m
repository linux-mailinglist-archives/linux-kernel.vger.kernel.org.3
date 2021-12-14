Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FBB2473CB8
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 06:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbhLNFtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 00:49:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbhLNFtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 00:49:19 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7332EC061748
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 21:49:19 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id j11so16478969pgs.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 21:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hr5Wpg7ev5riau6J8AsCFp781PoK7TjuAKB0LRsYr3M=;
        b=MGzriN/1d6rVkfghphGHEsPbps/B1r5OA9eMGSvm2IKrjCXb0PzoKrJDOzPDS7VoHB
         +Dm8hdW4+kc1yTvSiKAs8t5CxMYVHJfvvEWl9iYvT4WOYrnSVZQQbJuWSusCeAkFMbhj
         RyVNEnjVkS04PRGrKG0B6F8eiI63e6Mcrdnc5sePETXwcY0fRexAovoxestlOy9lKSty
         ST7EC1CsMlXkgu2mD6xavaP2X1vIApimw+TabhmqiQDEBsBesiZoeN3EG5kCQ3SNA8/d
         uDAiabvJF5LOP5OR1SzEvHDWQpPTmLP6LII/jI4pG1z0mPvt4q60SEC/38UQWW2lX6Dc
         KBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hr5Wpg7ev5riau6J8AsCFp781PoK7TjuAKB0LRsYr3M=;
        b=Z9p45nLy9EJqiU7FdBJfjfjjonaiMbkUY3/DwxawujtFHd6Spvo9JuGXFr+6E9cCHt
         hJjWYHIqu+niRY7ZpJnnxJL0R63wEB7xaadlSuolYGpUd3hOXPL+kKHelQGtz+nv0+0m
         +PP1yD70gqO0HqKBc5rBrqhRJj2OCO8pCwbijm/TNJTFjQ3SJIEHO7vKUYehL55fJ0eB
         PTCBGYpSgJEiA4mjO++FNKt1CzVw93zfy+P4FV6SIomNaL9mDr2uvJkpH7n59Jp1Z/ye
         ThPulsGmZzhs9mm94Cb+0NPy/Zehosq/XWtFDQPsUhQ/Jkrm71tOzAN+hT+D/fJeal6b
         5gWQ==
X-Gm-Message-State: AOAM533gHrJ7IFmrg5tIffNqzO7L7RUdZtErUbdBsOE57G/gd6X3SAXs
        eipL5Yx/Hccyke4OnCV5GWZfn0XeOrxbhg==
X-Google-Smtp-Source: ABdhPJwtcjX0i478P/HBWMUvhwLpZphrfwuE0Nb6BbP6+qiPvYmFDBBXmpwdnT2nBbQBfhimLlIQwA==
X-Received: by 2002:a05:6a00:99e:b0:49f:f9e2:c116 with SMTP id u30-20020a056a00099e00b0049ff9e2c116mr2441444pfg.83.1639460958872;
        Mon, 13 Dec 2021 21:49:18 -0800 (PST)
Received: from localhost ([110.141.142.237])
        by smtp.gmail.com with ESMTPSA id z13sm2005224pfj.160.2021.12.13.21.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 21:49:17 -0800 (PST)
Date:   Tue, 14 Dec 2021 16:49:14 +1100
From:   Balbir Singh <bsingharora@gmail.com>
To:     yong w <yongw.pur@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, mingo@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, yang.yang29@zte.com.cn,
        wang.yong12@zte.com.cn
Subject: Re: [PATCH v2 linux-next] delayacct: track delays from memory compact
Message-ID: <YbgwWir/Ymt/2gxE@balbir-desktop>
References: <1638619795-71451-1-git-send-email-wang.yong12@zte.com.cn>
 <Yax01zjuzmNyyJK/@balbir-desktop>
 <CAOH5QeDhjyjAkS1bUju2cv67KFukUr0ov8uG+z3bM6Oa=iFrMA@mail.gmail.com>
 <Ya7uQingLC3fMJlt@balbir-desktop>
 <CAOH5QeC+0xDrgO+t3zwN4o48F9Q2CiTnzQDO78kuJLfyNJwoLA@mail.gmail.com>
 <CAOH5QeCO_EZzkU=B3L1=1OPiZa7XxnWZK87GbwXNOQXxZqYcoQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOH5QeCO_EZzkU=B3L1=1OPiZa7XxnWZK87GbwXNOQXxZqYcoQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 09:56:08PM +0800, yong w wrote:
> Hello,  is this patch OK?
> 
> Thanks.
> 
> yong w <yongw.pur@gmail.com> 于2021年12月8日周三 00:50写道：
> >
> > Balbir Singh <bsingharora@gmail.com> 于2021年12月7日周二 13:16写道：
> > >
> > > On Sun, Dec 05, 2021 at 07:08:02PM +0800, yong w wrote:
> > > > Balbir Singh <bsingharora@gmail.com> 于2021年12月5日周日 16:17写道：
> > > > >
> > > > > On Sat, Dec 04, 2021 at 04:09:55AM -0800, yongw.pur@gmail.com wrote:
> > > > > > From: wangyong <wang.yong12@zte.com.cn>
> > > > > >
> > > > > > Delay accounting does not track the delay of memory compact.
> > > > > > When there is not enough free memory, tasks can spend
> > > > > > a amount of their time waiting for compact.
> > > > > >
> > > > > > To get the impact of tasks in direct memory compact, measure
> > > > > > the delay when allocating memory through memory compact.
> > > > > >
> > > > >
> > > > > Should we call this DIRECT_COMPACT and through documentation
> > > > > or name change imply that this won't work for kcompactd the
> > > > > kernel thread - based on my reading of the patches.
> > > > >
> > > > Using DIRECT_COMPACT is a little redundant，because the
> > > > delayacct stats of delay accounting is specific to tasks, it has
> > > > nothing to do with kcompactd, which is similar to the RECLAIM field.
> > > >
> > >
> > > What would we expect when we call delayacct -p <pidof kcompactd>
> > > to be output?
> > If the slow path of memory allocation is invoked in the kcompacd process,
> > there may be delays being recorded.
> >
> > > Don't feel to strongly, but it can be confusing that kcompactd
> > > has spent no time in compact'ing? Not that delayacct is used for
> > > kernel threads, but I am not sure if that use case exists today.
> > Yes, delayacct does not restrict the process of obtaining information，
> > but kcompactd is used for  compaction,  the compact delay of
> > kcompatd is not actually a delay.Maybe it can be added to the
> > document later to make it clearer.
> >
> > Thanks for your reply!

Please avoid top posting, when you say added later, I presume more
patches for documentation are coming. I am OK with the patch in that
case.

Reviewed-by: Balbir Singh <bsingharora@gmail.com>

Balbir Singh
