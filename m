Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7BC5AFC02
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 07:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbiIGFx1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 01:53:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiIGFxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 01:53:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 947A689CE9;
        Tue,  6 Sep 2022 22:53:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 304F861771;
        Wed,  7 Sep 2022 05:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 284F1C433D6;
        Wed,  7 Sep 2022 05:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1662529993;
        bh=ibfwkQ32Rbq5M69B5f3aQ0rXWs/oLVhNIkRFnLi89jw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=f1eAqZIOAFZFsl9R6/RqDMfeNu3ixnPwl2rPr/8Tp/4RfCtrwxxlMnP2U+KM6fqQQ
         g16x38RJEw2jZug00rcCi1ZhCYXIiqtMBsz3WllmfR3CvTAmxg+gGabxuToW0rmhPO
         GP91hN4ovuNOHh60JbH0tpk7qKs/9XIEzBk76fr8=
Date:   Tue, 6 Sep 2022 22:53:12 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     syzbot <syzbot+08ca1fa706a22cc17efe@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-next@vger.kernel.org, sfr@canb.auug.org.au,
        syzkaller-bugs@googlegroups.com,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Subject: Re: [syzbot] linux-next boot error: KASAN: slab-out-of-bounds Read
 in _find_next_bit
Message-Id: <20220906225312.263c4493a744cbcb66288283@linux-foundation.org>
In-Reply-To: <YxfpkzZhJ7GfRuKd@yury-laptop>
References: <000000000000974e2805e802137e@google.com>
        <20220906173154.6f2664c8fc6b83470c5dfea1@linux-foundation.org>
        <YxfpkzZhJ7GfRuKd@yury-laptop>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Sep 2022 17:45:07 -0700 Yury Norov <yury.norov@gmail.com> wrote:

> > > The buggy address belongs to the object at ffff888017576600
> > >  which belongs to the cache kmalloc-192 of size 192
> > > The buggy address is located 184 bytes inside of
> > >  192-byte region [ffff888017576600, ffff8880175766c0)
> > 
> > At offset 184 of a 192-byte region.
> > 
> > So what's wrong with doing that?  Does KASAN have an off-by-one?
> 
> Hi Andrew, all,
> 
> This is a bug in FIND_NEXT_BIT(). It should be 
>   if (idx >= sz / BITS_PER_LONG)                                   \
>           goto out;                                                \
> 
> instead of 
>   if (idx > sz / BITS_PER_LONG)                                    \
>           goto out;                                                \
> 
> The fix is in bitmap-for-next, expected to be in -next by tomorrow.
> Sorry for the noise.

OK... but why is KASAN reporting a bad access from an area
which appears to be OK?
