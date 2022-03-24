Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EFE4E697D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 20:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344576AbiCXTtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 15:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241865AbiCXTtU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 15:49:20 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DFD4EF6C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 12:47:47 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id k21so9882595lfe.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 12:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rs+hkLtuejz0jp8IG6j+lCynmaYU2c6Un9EnKH5Ij0I=;
        b=Oqpul6J72/k8EqWztUoLjeFDKjEMWUCgohu5BJCmPHoWIbKngOJcLXigRdM/5+xArg
         zIq0bJSPGyga61BwSQKKQVkhg9ofNwzZUW2YeeAkjqko1ah20e/Twqu+KJxa0QEEhzTm
         Ce1gXWGp3lk8SHnpjJzozBrXo8rgpOecx7moI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rs+hkLtuejz0jp8IG6j+lCynmaYU2c6Un9EnKH5Ij0I=;
        b=N+x14ndRNiurrXuHNEyZM85st8/btYiDKNhSivGqOLNUPbzogG1oRLACCd5i9yTZ9d
         ivUc7Hro4QhMS3YCQrGVRuqtzAJH1A5O3sav8p8WA6xsSkvss7O6c7P0vAWPwrRGiz1T
         7jcv6KABXEjb59crU4YurPRlF1Uz1SvdhjiFzFXi2095UB9IT2n1jVpaBM/ZfbsuI9E1
         nDd1JERBOqOlb1hRmYQt/j7lA29Y6o18tiVOYMFoY5ljT7hDuHy09oaJHqjf+X1hFoT7
         OL3rK1mJOYU31rJsCoqDnNDF0tsUVYiWnDbncdr243ekEsCWxSZQDqBMW8EUZcnWUNug
         zNxA==
X-Gm-Message-State: AOAM532wmKCdu7ELPJbdeQj9etqDFfsjhdD+D2toMFNK8HBZa/6G26yO
        Gys6/HP5Yh9nEufQMaoQFREi0yDxF9cQtDqSDcI=
X-Google-Smtp-Source: ABdhPJwblKuH6MRt45K4WTW2FJM2YU0YGaaFXl3NacIkWWS5FQ9Txc/tM1gcZ5o4rFm6fbYolIPmXg==
X-Received: by 2002:ac2:4c51:0:b0:44a:34b8:fd72 with SMTP id o17-20020ac24c51000000b0044a34b8fd72mr4871282lfk.360.1648151265539;
        Thu, 24 Mar 2022 12:47:45 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id i3-20020a198c43000000b00448a1566977sm441792lfj.275.2022.03.24.12.47.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 12:47:45 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id o6so7601806ljp.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 12:47:44 -0700 (PDT)
X-Received: by 2002:a05:651c:1213:b0:247:e2d9:cdda with SMTP id
 i19-20020a05651c121300b00247e2d9cddamr5411119lja.443.1648151264448; Thu, 24
 Mar 2022 12:47:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAMZfGtUr6V5pTrPhZukD2_KbB7BLPoKvF6H63HP4pykY36Ou9A@mail.gmail.com>
 <0000000000009901d505dafc07b3@google.com> <CAHk-=whxaFX4nqnE-SLHTGKyqejvbrhYx5sagcxWd+UWCMf8dg@mail.gmail.com>
In-Reply-To: <CAHk-=whxaFX4nqnE-SLHTGKyqejvbrhYx5sagcxWd+UWCMf8dg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 24 Mar 2022 12:47:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg++3S5Cvks-4xFCrD7qgZDibc5aMS4Bt=Pemm7FnOBZA@mail.gmail.com>
Message-ID: <CAHk-=wg++3S5Cvks-4xFCrD7qgZDibc5aMS4Bt=Pemm7FnOBZA@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in list_lru_add
To:     syzbot <syzbot+f8c45ccc7d5d45fc5965@syzkaller.appspotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Muchun Song <songmuchun@bytedance.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 12:45 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, Mar 24, 2022 at 12:41 PM syzbot
> <syzbot+f8c45ccc7d5d45fc5965@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has tested the proposed patch and the reproducer did not trigger any issue:
>
> Heh, well that's unfortunate.
>
> I think the issue is that it triggered a new BUG() that didn't match
> the previous NULL pointer dereference, so it thinks things are
> "fixed".

Oh, no, it's because it used the truncated patch that didn't do anything:

> patch:          https://syzkaller.appspot.com/x/patch.diff?x=1208043d700000

and maybe (due to the racy nature) nothing actually happened.

             Linus
