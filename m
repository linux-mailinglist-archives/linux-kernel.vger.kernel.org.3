Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C176C56CC00
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 01:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbiGIXXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 19:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGIXXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 19:23:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4922AA46E
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 16:23:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D3E286101F
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 23:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC62EC3411C
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 23:23:44 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="PcOmRlfl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657409021;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4luwdHtoa5TijeIa0ocStPfhJ5ySkRw52BzfnU2PTro=;
        b=PcOmRlflZvJudt6wPN/M4269Hbb/2snzrDGtkr2F37K01WjkH/hjOkFaCaBc+qyVUE/Ibt
        gcz0Bk7Dklfd+N0tI1Dcnh0QHWQLwVHcLWLZT0mbGdHaU94GPIxJvJjwzZ2xcP+Ua0roGq
        WYYdM4/pvyqrQ7h+sNPhB4y/XKfx0EQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ee9c887b (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Sat, 9 Jul 2022 23:23:41 +0000 (UTC)
Received: by mail-il1-f182.google.com with SMTP id v1so1201620ilg.11
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 16:23:41 -0700 (PDT)
X-Gm-Message-State: AJIora+PLrvXTDmzLDz/fsQzycVrZZf9Ryo7A1GeonqcK76BIJAqDUMe
        ac5gFmiETRi7U2HICJ01IY39BCj4Nd8SgsxCnyc=
X-Google-Smtp-Source: AGRyM1u0QrOeHNn5hN7JEwN7Gon7A7YUY+3gDx6Q90PkI16F8Re6eK8n50bnZzjR+SamjqgGyks9napDt8znePeKLl8=
X-Received: by 2002:a05:6e02:164f:b0:2dc:6d38:ff8e with SMTP id
 v15-20020a056e02164f00b002dc6d38ff8emr2277930ilu.16.1657409019467; Sat, 09
 Jul 2022 16:23:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6e02:20e5:0:0:0:0 with HTTP; Sat, 9 Jul 2022 16:23:38
 -0700 (PDT)
In-Reply-To: <ec46a292-dcc1-c12b-25a0-491b522c2db8@zytor.com>
References: <YslN1bo2jnnxl3E3@zx2c4.com> <20220709094853.1090735-1-Jason@zx2c4.com>
 <ec46a292-dcc1-c12b-25a0-491b522c2db8@zytor.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 10 Jul 2022 01:23:38 +0200
X-Gmail-Original-Message-ID: <CAHmME9pPTWB0so2-wXmmsMQn0WhqZWwVcbpMP15U=QCt57Q_cg@mail.gmail.com>
Message-ID: <CAHmME9pPTWB0so2-wXmmsMQn0WhqZWwVcbpMP15U=QCt57Q_cg@mail.gmail.com>
Subject: Re: [PATCH tip v9] x86/setup: Use rng seeds from setup_data
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
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

Hey Peter,

On 7/10/22, H. Peter Anvin <hpa@zytor.com> wrote:
> On 7/9/22 02:48, Jason A. Donenfeld wrote:
>> Currently the only way x86 can get an early boot RNG seed is via EFI,
>> which is generally always used now for physical machines, but is very
>> rarely used in VMs, especially VMs that are optimized for starting
>> "instantaneously", such as Firecracker's MicroVM. For tiny fast booting
>> VMs, EFI is not something you generally need or want.
>>
>> Rather, here we want the ability for the image loader or firmware to
>> pass a single random seed, exactly as device tree platforms do with the
>> "rng-seed" property. Additionally, this is something that bootloaders
>> can append, with their own seed file management, which is something
>> every other major OS ecosystem has that we do not (yet).
>>
>> This patch adds SETUP_RNG_SEED, similar to the other seven setup_data
>> entries that are parsed at boot. It also takes care to zero out the seed
>> immediately after using, in order to retain forward secrecy. This all
>> takes about 7 trivial lines of code.
>>
>> Then, on kexec_file_load(), a new fresh seed is generated and passed to
>> the next kernel, just as is done on device tree architectures when
>> using kexec. And, importantly, I've tested that QEMU is able to properly
>> pass SETUP_RNG_SEED as well, making this work for every step of the way.
>> This code too is pretty straight forward.
>>
>> Together these measures ensure that VMs and nested kexec()'d kernels
>> always receive a proper boot time RNG seed at the earliest possible
>> stage from their parents:
>>
>>     - Host [already has strongly initialized RNG]
>>       - QEMU [passes fresh seed in SETUP_RNG_SEED field]
>>         - Linux [uses parent's seed and gathers entropy of its own]
>>           - kexec [passes this in SETUP_RNG_SEED field]
>>             - Linux [uses parent's seed and gathers entropy of its own]
>>               - kexec [passes this in SETUP_RNG_SEED field]
>>                 - Linux [uses parent's seed and gathers entropy of its
>> own]
>>                   - kexec [passes this in SETUP_RNG_SEED field]
>> 		   - ...
>>
>> I've verified in several scenarios that this works quite well from a
>> host kernel to QEMU and down inwards, mixing and matching loaders, with
>> every layer providing a seed to the next.
>>
>> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
>
> Acked-by: H. Peter Anvin (Intel) <hpa@zytor.com>

Thanks for the ack. In case your ack here is meant to communicate
"good to go for random.git," I thought I should mention: while earlier
versions of this patch were against my random.git tree, this one (and
the previous) is against tip.git, because otherwise there'd be some
annoying conflicts when merging. So if it's not too much trouble, I
think it would make sense to apply this to tip.

Jason

>
>> ---
>> Changes v8->v9:
>> - [hpa] Update SETUP_TYPE_MAX and add SETUP_ENUM_MAX.
>
