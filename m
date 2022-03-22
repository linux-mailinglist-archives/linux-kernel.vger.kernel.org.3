Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3683C4E462E
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 19:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239042AbiCVSnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 14:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240932AbiCVSnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 14:43:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01BFA1CC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 11:41:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8F31C615E2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 18:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFC46C340EC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 18:41:49 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="lqEVdmpA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1647974508;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8mw1SkYPtlZUBR1/z2OCgZKYzrYK1ru46TFWU7fH9wM=;
        b=lqEVdmpACdCg3BrJBAs+44nTktGi1DT8ZadPCte531oHkqYCKUdsoYuKrbJWYihce49e4v
        5ZZUyqWb9wBDLDkr8ZKthzZV3Z84q9yLnfr8MesgvLrrklA5tP4Ne4kCboh4SG95peiQ4G
        NK8WHKSvF0Yjhk2Hv9LnZpLpwxE2JuY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5940703e (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Tue, 22 Mar 2022 18:41:48 +0000 (UTC)
Received: by mail-yb1-f175.google.com with SMTP id t11so35307160ybi.6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 11:41:48 -0700 (PDT)
X-Gm-Message-State: AOAM5322PvKp45S/+uXy9AhcsiO6fU5uIV6VJy5VzIhaxAvTCenQFT0e
        SQld1Juzc0dmFKuTosFD2qknfcR9edUxSXp1+m0=
X-Google-Smtp-Source: ABdhPJwNGeD11vVhCc8AFn+1sm8OuKNiuprnRK1gcsy42vtNDvgpnqPnGhNVm0xipkE4O0YwCjiop/kUdf7+D55nZoo=
X-Received: by 2002:a25:ad83:0:b0:633:abf6:5f69 with SMTP id
 z3-20020a25ad83000000b00633abf65f69mr25239387ybi.382.1647974508153; Tue, 22
 Mar 2022 11:41:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220322164655.83229-1-Jason@zx2c4.com> <CAHk-=whnK3eG6+=Q7MgcLEKAny1Eqdc9XKyq5W49Dz6x1bHAqw@mail.gmail.com>
In-Reply-To: <CAHk-=whnK3eG6+=Q7MgcLEKAny1Eqdc9XKyq5W49Dz6x1bHAqw@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 22 Mar 2022 12:41:37 -0600
X-Gmail-Original-Message-ID: <CAHmME9p=neo19U0DYftmO64kkRSirdy2b-LjaUXi5dC2npoQuw@mail.gmail.com>
Message-ID: <CAHmME9p=neo19U0DYftmO64kkRSirdy2b-LjaUXi5dC2npoQuw@mail.gmail.com>
Subject: Re: [PATCH] random: go back to not blocking in /dev/urandom
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

On Tue, Mar 22, 2022 at 12:41 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Mar 22, 2022 at 9:47 AM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > This reverts commit 6f98a4bfee72 ("random: block in /dev/urandom").
>
> Just a note that by the time I saw this, I already had my own revert
> in the tree.
>
> It's pushed out now, as commit 0313bc278dac.

Saw that, no problem.

Jason
