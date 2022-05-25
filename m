Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BDA45345DD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 23:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241037AbiEYVgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 17:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235135AbiEYVgw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 17:36:52 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3747CAF313
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 14:36:50 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id h11so27468777eda.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 14:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f/I4M8Sb3pZ5Nw6BzyhaOB507ih22zxAYT/4oQhTECY=;
        b=C6J2Bv4rnpDvfR3Q9wsPFBY17dXDPH4VZquZVqQT9mvDj6LxbHYdPrpepIIZO6B0vc
         uOFmnp//W8Q9oxTTbdO5QsSB68wWY+4qbbExWWLl4NMKwQOUd8CY9sbb4eVDaIMkYlfF
         LCzqhrcqfEBHe1eV4YCsaipKMXGsds9ZCywfc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f/I4M8Sb3pZ5Nw6BzyhaOB507ih22zxAYT/4oQhTECY=;
        b=CZ4vR4FyvgmvLVPtIrYOr3SmoM1GegM3gvVxiPRQT7qAihHPb4OcBG8cdp9PU7PUQl
         Cz+ypgbim3SaaiAHy4U+7agzXkCNX1pjQzt5SLhuPY4Zr60OULr3YNwErQHKKPvwznAs
         ZnlIu+OTZNdJ2jVKDFvdZMXnSA+fbdjdXCBRJcG8Y8v32Mhe1oH/afOnsK7CZudEaDCJ
         1ubqAU3teTT84+xzUm9tEa3L9zc3uPsehTIOjTx4b9TgsYHf09DSFACdXAvnMD5f13VX
         uKKyGh5OHX6eaAzEeaC2LwGaIFTKcUrtdboIyKrBrRQx1CfKGronUPHClsdFCa9ooQfb
         7HoQ==
X-Gm-Message-State: AOAM532oU3Lrnh7mMQ8EA8HEbqsWmYQWSTE8CiEDO1cR+el7UezKCUxM
        Elrhp+r4oySG2azdD7UqJj/WdKtu+pQsoiu6fW8=
X-Google-Smtp-Source: ABdhPJwGqWRTYgWwRgyyfakJbQEMVqxKmGcMbLPilKtG313Pt9qQ+BvB+VzjJ4hGkVh1xmW+m6j4pw==
X-Received: by 2002:a05:6402:350f:b0:428:43a1:647d with SMTP id b15-20020a056402350f00b0042843a1647dmr36862536edd.62.1653514608462;
        Wed, 25 May 2022 14:36:48 -0700 (PDT)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com. [209.85.128.47])
        by smtp.gmail.com with ESMTPSA id k24-20020a508ad8000000b0042bc97322desm1188565edk.43.2022.05.25.14.36.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 May 2022 14:36:47 -0700 (PDT)
Received: by mail-wm1-f47.google.com with SMTP id c5-20020a1c3505000000b0038e37907b5bso1877083wma.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 14:36:47 -0700 (PDT)
X-Received: by 2002:a7b:c4ca:0:b0:397:3bac:9b2a with SMTP id
 g10-20020a7bc4ca000000b003973bac9b2amr9722202wmk.154.1653514606752; Wed, 25
 May 2022 14:36:46 -0700 (PDT)
MIME-Version: 1.0
References: <8062f61e-5a4d-00a5-be1a-7921d3277e9d@suse.cz> <CAHk-=wiztQWhEw4tLiH3t5gw=gKB7XtoTXC=S2bhxBxoxOVZLw@mail.gmail.com>
 <6cdbe746-2c6f-f698-11d4-9f86d2c4e5cc@suse.cz>
In-Reply-To: <6cdbe746-2c6f-f698-11d4-9f86d2c4e5cc@suse.cz>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 May 2022 14:36:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjC5nS+fnf6EzRD9yQRJApAhxx7gRB87ZV+pAWo9oVrTg@mail.gmail.com>
Message-ID: <CAHk-=wjC5nS+fnf6EzRD9yQRJApAhxx7gRB87ZV+pAWo9oVrTg@mail.gmail.com>
Subject: Re: [GIT PULL] slab for 5.19
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, patches@lists.linux.dev,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Alexander Potapenko <glider@google.com>
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

On Wed, May 25, 2022 at 1:56 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> As I understand it's a tradeoff between memory overhead due to hash
> table size and cpu overhead due to length of collision chains.

... but why is that a build-time kernel config question? And when does
it actually end up triggering?

I didn't much care - and clearly small machines like m68k didn't
either - when the whole stackdepot thing was a "odd configuration
issue".

Because it used to be that stack depot users were fairly easy to
figure out. It was all about pretty special debug options that enable
a lot of very special code (KASAN and PAGE_OWNER - is there anything
else?).

Very clearly just debug builds.

But this slab change means that now it's basically *always* enabled as
an option, and that means that now it had better do sane things
because it's enabled by default and not something that can easily be
ignored any more.

The kernel config phase is something I'm very sensitive to, because
honestly, it's just about the worst part of building a kernel.
Everything else is pretty easy. The kernel config is painful.

That means that we should not ask insane questions - and asking what
static size you want for a data structure that 99% of all people have
absolutely _zero_ idea about or interest in is wrong.

So the problem here is two-fold:

 (a) it introduces a new compile-time question that isn't sane to ask
a regular user, but is now exposed to regular users.

 (b) this by default uses 1MB of memory for a feature that didn't in
the past, so now if you have small machines you need to make sure you
make a special kernel config for them.

And (a) happens unconditionally, while (b) is conditional. And it's
now clear exactly what all triggers the actual allocation in (b).

I _hope_ it's never triggered unless you actively enable slub debug,
but at least from a quick grep it wasn't obvious.

For example, if you happen to have rcutorture enabled, do you get the
allocation then just because rcutorture uses

       kcp = kmem_cache_create("rcuscale", 136, 8, SLAB_STORE_USER, NULL);

even if you have nothing else that would enable slaub debugging? It
*looked* that way to me from a quick grep, but I could easily have
missed something.

             Linus
