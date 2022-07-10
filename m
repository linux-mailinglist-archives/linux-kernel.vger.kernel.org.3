Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B5256CEAD
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Jul 2022 13:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiGJLL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 07:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiGJLLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 07:11:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD00BCB0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 04:11:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9796611DF
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 11:11:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6EC9C341CA
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 11:11:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RiBMuvV7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1657451479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0J6pzvcjnUGrovZ2yqFFcJRTYAwyFN73LNI4AsTu72I=;
        b=RiBMuvV7i4fZyDkhR+JpVjM89ewLEYMhfTqU3oPAmZ9rQFxeuR03LwR5FX29z2RqREYJzn
        5A2oLNIhzTBFWG/ICzDye7VblYCOtuA6fEsaRLIsIpopoQmT8QbshtZdGtelFqThC7Nzw4
        iK0j9BKKcwTl31NK9Lk/uknfps7gLQY=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9ba3f6eb (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO)
        for <linux-kernel@vger.kernel.org>;
        Sun, 10 Jul 2022 11:11:19 +0000 (UTC)
Received: by mail-io1-f49.google.com with SMTP id h200so2688109iof.9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 04:11:18 -0700 (PDT)
X-Gm-Message-State: AJIora9BJ8bZeBErxK7t1C6PZYPVamR1XrOJNcUkTeMADTROTh/9sLsE
        S8QA8877nijGPRl8smSXq6epaHj7vcQJwkMIsa8=
X-Google-Smtp-Source: AGRyM1sAgOdleKqdcMEza/Bbh2GIu2JsvDtLy9PIpX+Z4Ht4lrYYY87ZM3SyImWMRKaq4eCbjBmbBE2NakdugVzAm/Y=
X-Received: by 2002:a5e:c308:0:b0:67b:8226:3c86 with SMTP id
 a8-20020a5ec308000000b0067b82263c86mr2617398iok.172.1657451477613; Sun, 10
 Jul 2022 04:11:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6e02:20e5:0:0:0:0 with HTTP; Sun, 10 Jul 2022 04:11:16
 -0700 (PDT)
In-Reply-To: <YsqfuPeB5jhFU9g5@zn.tnic>
References: <20220707000852.523788-1-Jason@zx2c4.com> <20220708113907.891319-1-Jason@zx2c4.com>
 <ddba81dd-cc92-699c-5274-785396a17fb5@zytor.com> <YslPKbrmwF0uSm7p@zn.tnic>
 <191d8f96-7573-bd0e-9ca4-3fc22c5c9a49@zytor.com> <Ysn5uvBKBpcZ4j6m@zn.tnic>
 <8e5eb2db-ce31-3dc8-8f75-3959036686f8@zytor.com> <YsqfuPeB5jhFU9g5@zn.tnic>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 10 Jul 2022 13:11:16 +0200
X-Gmail-Original-Message-ID: <CAHmME9rBRvU1z5Je1B2ahiTWuBaeJ9mHmohMAxLeoPMubT1+zw@mail.gmail.com>
Message-ID: <CAHmME9rBRvU1z5Je1B2ahiTWuBaeJ9mHmohMAxLeoPMubT1+zw@mail.gmail.com>
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

On 7/10/22, Borislav Petkov <bp@alien8.de> wrote:
> On Sat, Jul 09, 2022 at 03:41:19PM -0700, H. Peter Anvin wrote:
>> In ABI/API terms, that symbol has the semantic of connecting the API
>> version
>> to the underlying ABI version; a piece of code that sees an enumeration
>> type
>> > SETUP_ENUM_MAX must by definition treat it as an opaque blob. In the
>> future, should it become warranted, we may add flags that indicate how
>> unaware code should handle them, but I don't think we can engineer that
>> right now.
>
> Ok, let's hope it doesn't come to that and userspace behaves... <eyeroll>
>
> So, I'm going to send the below to Linus now so that 5.19 releases fixed
> and then queue Jason's patch next week.

Do you want me to rebase mine on top of the 5.19 fixup? Or is that
trivial enough that you'll just do it when applying?

Jason
