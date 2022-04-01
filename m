Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD35C4EEF18
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 16:17:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346778AbiDAOSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 10:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346704AbiDAOSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 10:18:48 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4644322F3D6
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 07:16:58 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id dr20so6132151ejc.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 07:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bmS8kGPX3oqylsdkqHV+AyKQ/jkv5xD40RzktvQFBCA=;
        b=k3AbnEjCIO9KtJuKhqWav0ixKZGHdzUpJy0TB96ZwLJiUMb6aBwkvyouonOEy3740l
         fx+KLUxr3Ia/2nW6ZvHzpeNLwC0KjhtU4t60G1gNpq9/O/M+LfEk3UAwCC8d3zraGTAW
         fPBcgXJ+/tzxgN4e/a/94pWU+DLGhDAIuLHOSna6SJhRUzOdB7/+z/35Qh4nGCc9I0hw
         DWlYmYVgfY7gadz7pIyxbSc3niS3o9PBkf4VhPtH+vcP0ZiLUucPsOasugiMMFhg1/gu
         eVqpap4/BBB3BrfE4TuScREYvqrqPm9iSebuiRQH2TKIw7aP1mLqbUOrzDHnJDxtkpn0
         zbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bmS8kGPX3oqylsdkqHV+AyKQ/jkv5xD40RzktvQFBCA=;
        b=lhk8QrO7PVn3okdMw/CeQXje4WFtE1w8WEtGeqjfhLzgQIzyPTZ5YI6M7likkotQwH
         6KNFGkxCE/rn1hLf4s7A7cJKVYdbp01PKSZd5qfz6L4dvfS/EC4+Cs7oI6rdwTOyUaSX
         fvIDiW3rO9CGOyFJGjxttKzDLyuE+6q1f43G2rkkZEDlXR7c3VAeIIY4vjElruCHZsCH
         blIZzK5H+CI+zNUV0wFQfsINFMs7r8LCMe3GJALsIVoLRuB/CMSEojt7nbjOfe+m2mHa
         Erso4P3YEJ6WPVU5n7JjxjLgt/JhJE3eVO1HPkT8LlU66ZiQ3ry6fvOVi/E8uY918TZQ
         +UwQ==
X-Gm-Message-State: AOAM530b268WyhVGhiQ7Jql9m6BNTsru+UwUfCGdDTxf3zoVoFgbW9DC
        HTotbA+8Jl641rGXvB+Rwf8pxqNAd6hSz4nA5DVl0psthQ==
X-Google-Smtp-Source: ABdhPJwLbimfaR6/uUNJolgpuaocB/w+2fMr9wzVTSwPRnDn00eP1Xml6RgKsNOeu5+RkdFvCiT3qtjHTvdCAivyGbU=
X-Received: by 2002:a17:907:1b09:b0:6d8:faa8:4a06 with SMTP id
 mp9-20020a1709071b0900b006d8faa84a06mr9613207ejc.701.1648822616645; Fri, 01
 Apr 2022 07:16:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220326094654.2361956-1-yang.yang29@zte.com.cn>
 <CAHC9VhTaCNqfTOi8X5G3AheBFzTYCzGnt_-=fNFc5Z1o8gPm9Q@mail.gmail.com>
 <62465bf3.1c69fb81.d5424.365e@mx.google.com> <2777189.mvXUDI8C0e@x2>
In-Reply-To: <2777189.mvXUDI8C0e@x2>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 1 Apr 2022 10:16:45 -0400
Message-ID: <CAHC9VhRYHhHPx42BKa0gp974uzwHoXZWqmwt9o=1rox7tHyy1w@mail.gmail.com>
Subject: Re: [PATCH] audit: do a quick exit when syscall number is invalid
To:     Steve Grubb <sgrubb@redhat.com>
Cc:     linux-audit@redhat.com, CGEL <cgel.zte@gmail.com>,
        kbuild-all@lists.01.org, Zeal Robot <zealci@zte.com.cn>,
        linux-kernel@vger.kernel.org, eparis@redhat.com,
        dai.shixin@zte.com.cn, Yang Yang <yang.yang29@zte.com.cn>,
        ink@jurassic.park.msu.ru, huang.junhua@zte.com.cn,
        guo.xiaofeng@zte.com.cn, mattst88@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 1, 2022 at 9:39 AM Steve Grubb <sgrubb@redhat.com> wrote:
>
> On Thursday, March 31, 2022 9:57:05 PM EDT CGEL wrote:
> > On Thu, Mar 31, 2022 at 10:16:23AM -0400, Paul Moore wrote:
> > > On Wed, Mar 30, 2022 at 10:29 PM CGEL <cgel.zte@gmail.com> wrote:
> > > > On Wed, Mar 30, 2022 at 10:48:12AM -0400, Paul Moore wrote:
> > > > > If audit is not generating SYSCALL records, even for invalid/ENOSYS
> > > > > syscalls, I would consider that a bug which should be fixed.
> > > >
> > > > If we fix this bug, do you think audit invalid/ENOSYS syscalls better
> > > > be forcible or be a rule that can be configure? I think configure is
> > > > better.
> > >
> > > It isn't clear to me exactly what you are asking, but I would expect
> > > the existing audit syscall filtering mechanism to work regardless if
> > > the syscall is valid or not.
> >
> > Thanks, I try to make it more clear. We found that auditctl would only
> > set rule with syscall number (>=0 && <2047) ...

That is exactly why I wrote the warning below in my response ...

> > > Beware that there are some limitations
> > > to the audit syscall filter, which are unfortunately baked into the
> > > current design/implementation, which may affect this to some extent.

-- 
paul-moore.com
