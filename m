Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF20A53B118
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 03:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbiFBBIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 21:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbiFBBIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 21:08:43 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE819278504
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 18:08:41 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id m20so7009496ejj.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 18:08:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AMLk7uMNCtOe4gy9/LZgkLZRBX0ALCzfWfzDBXHnFo8=;
        b=OYbmFRcqjOukBt1QgTghY6i5XSE1P4Lt88ABmn7yr1figRBOYiE95+mswItMYHSdNG
         lviOuM27J5QIIeBwiLSJpAbPnwuY91jc54iyDcuCVAnICvUgcOifKGuJEsuhq8aGrj2A
         h1gTJ/7WWYaX/+zmQRNAu0O5nZCrZo4IJc/ww=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AMLk7uMNCtOe4gy9/LZgkLZRBX0ALCzfWfzDBXHnFo8=;
        b=HPvGSLr3lZVofp8Ls5wrAWkOowZEikjOTy1f08rv4rUQJz0GJOiw9vQHqmjDfonhY0
         q1UQOzErMxoq/Mgiw51lg58JwR71ixuAb7uvXwdHvAnE0B7rw3bEGdf5DVLwIP7lzTaM
         TVrOs5FiA3pPSns1fFswe/YMiD9EweSTJkHmmvDre9ijToaXJpocScnmk2iBM+WwCJfy
         pRvbQHymq7iJYnkx21cIaGJC2R0m80SmX2Gf3wnWhwwAES85mG2+MpXMhqaOH4Iww5Hb
         vXAlnOArdo4Yz4QnL+HKUvQJjiAZUMSjKcqsE1MA1xK4DM0HJR8yMFOibUpahrBTVNBy
         OWMQ==
X-Gm-Message-State: AOAM53190MxwvaxcWvBQ86ewuRGufm2fR0WOlCj44fkysR+s8bIQ75uR
        yeNsP5jgRIg3WY8VkoHSgqyFk3/0hfJX2g3k
X-Google-Smtp-Source: ABdhPJzx0W4a1OQNkx46tY3bZt04x7McoTekt6vwBqcCcRKEldTuPsUDnx9vie/FUhdswBRlvfXLrw==
X-Received: by 2002:a17:907:720f:b0:6f8:5c31:4027 with SMTP id dr15-20020a170907720f00b006f85c314027mr2050241ejc.284.1654132120312;
        Wed, 01 Jun 2022 18:08:40 -0700 (PDT)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id n9-20020a170906700900b006fe8ac6bc69sm1234909ejj.140.2022.06.01.18.08.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 18:08:40 -0700 (PDT)
Received: by mail-wm1-f51.google.com with SMTP id r123-20020a1c2b81000000b0039c1439c33cso1966221wmr.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 18:08:39 -0700 (PDT)
X-Received: by 2002:a7b:cb91:0:b0:397:3225:244 with SMTP id
 m17-20020a7bcb91000000b0039732250244mr30980346wmi.68.1654132109585; Wed, 01
 Jun 2022 18:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a2Zg2QDS1_Ysn8-Zqqd+K7bbTFS7JV7gPabp6nvPiKaog@mail.gmail.com>
 <91E67F46-A3C7-4159-9E0C-C6C6306F3669@inria.fr> <CAK8P3a2iAsemAQdbTZ_E7GGGCXAOeWbjSjLgXEsd5sg_buZWhw@mail.gmail.com>
 <CAHk-=wgO0V9OdY+DFm-f0qZYMyFSm0ptReO+_qgSTEpBLtFV7Q@mail.gmail.com> <d971a684-ccd9-3839-1e30-c166fd55cf49@inria.fr>
In-Reply-To: <d971a684-ccd9-3839-1e30-c166fd55cf49@inria.fr>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 1 Jun 2022 18:08:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiViikY0szsJGipSxFmMwdsvxjm7SwDfwNfMHYvQ64kAA@mail.gmail.com>
Message-ID: <CAHk-=wiViikY0szsJGipSxFmMwdsvxjm7SwDfwNfMHYvQ64kAA@mail.gmail.com>
Subject: Re: mainline build failure due to f1e4c916f97f ("drm/edid: add EDID
 block count and size helpers")
To:     Keisuke Nishimura <keisuke.nishimura@inria.fr>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Ayush Sawal <ayush.sawal@chelsio.com>,
        Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
        Rohit Maheshwari <rohitm@chelsio.com>
Cc:     Julia Lawall <Julia.Lawall@inria.fr>,
        Arnd Bergmann <arnd@arndb.de>,
        Jani Nikula <jani.nikula@intel.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Viresh Kumar <vireshk@kernel.org>,
        Shiraz Hashim <shiraz.linux.kernel@gmail.com>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        SoC Team <soc@kernel.org>
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

On Wed, Jun 1, 2022 at 3:28 PM Keisuke Nishimura
<keisuke.nishimura@inria.fr> wrote:
>
>
> I found 13 definitions of packed structure that contains:
>  > - spinlock_t
>  > - atomic_t
>  > - dma_addr_t
>  > - phys_addr_t
>  > - size_t
>  > - struct mutex
>  > - struct device
>
> - raw_spinlock_t

Ok, so I don't think dma_addr_t/phys_addr_t/size_t are problematic,
they are just regular integers.

And 'struct device' is problematic only as it then contains any of the
atomic types (which it does)

> security/tomoyo/common.h: atomic_t in tomoyo_shared_acl_head
> drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls.h: spinlock_t in key_map
> arch/s390/include/asm/kvm_host.h: atomic_t in kvm_s390_sie_block

So these do look problematic.

I'm not actually clear on why tomoyo_shared_acl_head would be packed.
That makes no sense to me.

Same goes for key_map, it's not clear what the reason for that
__packed is, and it's clearly bogus. It might work, almost by mistake,
but it's wrong to try to pack that spinlock_t.

The s390 kvm use actually looks fine: the structure is packed, but
it's also aligned, and the spin-lock is at the beginning, so the
"packing" part is about the other members, not the first one.

The two that look wrong look like they will probably work anyway
(they'll presumably be effectively word-aligned, and that's sufficient
for spinlocks in practice).

But let's cc the tomoyo and chelsio people.

                 Linus
