Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF0114E5BB4
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 00:11:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345405AbiCWXNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 19:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239570AbiCWXNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 19:13:06 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5917270936
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 16:11:36 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id w7so5205518lfd.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 16:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LvvJua2HwnpcZu/lZqjkwEOtblbUH05/8X7U8pGraJU=;
        b=gMl+fS3lrRv6fX2mlXjT1mMPFzuVA37g702GFzj7pFse+/oWOYkpYuJZOg2mCdmjPu
         jOWerR/UGHNgS70hwzv9UyqG3ZzUkCraxjiOTxR/48EAVirkw+14slfAinxstlZNjWWK
         s6ABpXP9kQLBOK9CSTZ0TRgdEe9wsuppUllHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LvvJua2HwnpcZu/lZqjkwEOtblbUH05/8X7U8pGraJU=;
        b=iXjS76vzHETCuA0HCU8LBjqkxFomGoVv++7QFUCAIjEEVKLCxAZQ6vv8YhQmV0MdLP
         IAIPhgbKtoYbmrZsat5RyFW3Ye6w2LayGfxK+a2s9fid2CvmcTQN8o01rHMqpzndCZeK
         O7OxV+biyZt5to8+O1SED063HvMk51Qnr/PrGNV10B9Tw50dGuphrUSnVWKtMi8bWYDk
         DbaB9cnKycF4YVi/AQH0hMQGDb8jZ9iNioTR7VIU6l/3icDPC0dkOwLQWT6H33s0omk/
         ioALVxzWry+dLjcHHi2HTof6v8LwUup+jw8GwCa4IxZ/6QbtKr/ClwOwXg6Z5RoTaXtb
         rqVw==
X-Gm-Message-State: AOAM533P9yxmXyEXLRxdwiDBNGT3i7Lgmh/hBR7kyj1S3Rt2DNlqc4op
        fxC0+3EOxNS2EkhqZIRIvj1rb2IbGbfUJvh3FOk=
X-Google-Smtp-Source: ABdhPJxqzX41HsGcfPpy3ssKGxMtsjP/LxedUAfq7l8lZMcqgDr0ggFhPU/LdUqgkFSTN/OgCbhuMQ==
X-Received: by 2002:a05:6512:3f20:b0:448:1f53:59d7 with SMTP id y32-20020a0565123f2000b004481f5359d7mr1583361lfa.173.1648077094089;
        Wed, 23 Mar 2022 16:11:34 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id g7-20020a05651222c700b0044a2c68bb24sm117360lfu.224.2022.03.23.16.11.32
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 16:11:33 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id w27so5206721lfa.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 16:11:32 -0700 (PDT)
X-Received: by 2002:a05:6512:b13:b0:448:90c6:dc49 with SMTP id
 w19-20020a0565120b1300b0044890c6dc49mr1716074lfu.542.1648077092366; Wed, 23
 Mar 2022 16:11:32 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000cabcb505dae9e577@google.com>
In-Reply-To: <000000000000cabcb505dae9e577@google.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 23 Mar 2022 16:11:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjLL3OB8PvFGBLgUs=zip-Q2m1P=UwG+Pw_E8nYDs+MUw@mail.gmail.com>
Message-ID: <CAHk-=wjLL3OB8PvFGBLgUs=zip-Q2m1P=UwG+Pw_E8nYDs+MUw@mail.gmail.com>
Subject: Re: [syzbot] general protection fault in list_lru_add
To:     syzbot <syzbot+f8c45ccc7d5d45fc5965@syzkaller.appspotmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
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

Muchun,
 mind taking a look at this asap? This seems like a pretty core thing,
and the fact that it oopses on that

> RIP: 0010:list_add_tail include/linux/list.h:102 [inline]
> RIP: 0010:list_lru_add+0x277/0x510 mm/list_lru.c:129
>  d_lru_add fs/dcache.c:431 [inline]
>  retain_dentry fs/dcache.c:685 [inline]
>  dput+0x7a7/0xdb0 fs/dcache.c:908

just worries me a lot.

The dentry lru list rules are odd but not outrageously so. The main
oddity is that the DCACHE_LRU_LIST bit in the dentry flags indicate
whether the dentry is on a LRU list or not.

And it's not one single list - it can be *either* the usual
sb->lists_dentry_lru list, or the special "shrink list".

But this oops is for the regular d_lru_add() path that adds the dentry
to the sb->s_dentry_lru list as the dentry count goes down to zero
(and it's not one of the dentries that get insta-free'd).

So it looks like quite a regular path and something is horribly wrong
with a very core data structure.

                 Linus
