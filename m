Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A81456C88F
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 11:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229617AbiGIJxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 05:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGIJxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 05:53:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F94A1F2E9
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 02:53:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0FECEB819C4
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 09:53:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4FFC3411C
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 09:53:46 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="W1UnI+Zh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657360423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mnY+P3mWpSBZqFByq54ULQgiE9sxLCHGuFF/WBFMUIs=;
        b=W1UnI+ZhN4TOf8ysqj4/5MkBVHPUADJmDyWVtQFsvveA/WdvccK7W6+KfwTG0Br3pwh9jl
        x2Lk4zoaQKqlfheECZT0C5BwFo3VPSmA16xuXvOGeNdVALJOrf6iPxkmbavWVIzA3skT79
        EDSjkwE7PjjTHpfPGNQTrepyS61l15s=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 2bef71cf (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Sat, 9 Jul 2022 09:53:42 +0000 (UTC)
Received: by mail-io1-f53.google.com with SMTP id p128so1014859iof.1
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 02:53:42 -0700 (PDT)
X-Gm-Message-State: AJIora/An9M5NCn4xwatmYPckEHpU4ynIbsP9hvIRb7HWpODd/is3OOy
        DaTeB/5N7MaSnKw2Ugd5NTRPKomOPLtsk9e8r24=
X-Google-Smtp-Source: AGRyM1t/cIvRhPGMnIX9ZI+kcDUAbI2HKjvlpD8czA5GwFWM7BxiAfPkStCozyBU4Md0LfbxyenHkgOdQdGjsZzRUbU=
X-Received: by 2002:a05:6602:29d1:b0:669:428e:8c59 with SMTP id
 z17-20020a05660229d100b00669428e8c59mr4178619ioq.85.1657360420929; Sat, 09
 Jul 2022 02:53:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220707000852.523788-1-Jason@zx2c4.com> <20220708113907.891319-1-Jason@zx2c4.com>
 <ddba81dd-cc92-699c-5274-785396a17fb5@zytor.com> <YslPKbrmwF0uSm7p@zn.tnic>
In-Reply-To: <YslPKbrmwF0uSm7p@zn.tnic>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sat, 9 Jul 2022 11:53:29 +0200
X-Gmail-Original-Message-ID: <CAHmME9oJGs1RxFaABpVvKj2j81rCbKDDZiLe-ejKWBG_V2B9OQ@mail.gmail.com>
Message-ID: <CAHmME9oJGs1RxFaABpVvKj2j81rCbKDDZiLe-ejKWBG_V2B9OQ@mail.gmail.com>
Subject: Re: [PATCH tip v8] x86/setup: Use rng seeds from setup_data
To:     Borislav Petkov <bp@alien8.de>
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
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

Hi Borislav,

On Sat, Jul 9, 2022 at 11:49 AM Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Jul 08, 2022 at 06:51:16PM -0700, H. Peter Anvin wrote:
> > #define SETUP_ENUM_MAX        SETUP_RNG_SEED
> > #define SETUP_INDIRECT        (1<<31)
> > #define SETUP_TYPE_MAX        (SETUP_ENUM_MAX | SETUP_INDIRECT)
>
> Wait, if we get to add a new number, SETUP_ENUM_MAX and thus
> SETUP_TYPE_MAX will change. And they're uapi too...

Perhaps this is the reason it wasn't bumped earlier from 6 to 8 (this
patch adds 9)? I suspect the primary usage is in .rodata.kernel_info,
though.

Anyway, you now have my v9 which updates the value, and my v8 which
does not. Whichever one, v8 or v9, is fine with me. Maybe you should
take v8 into tip now, and then I'll send a follow up that updates the
values, so it can be reverted separately need-be?

Jason
