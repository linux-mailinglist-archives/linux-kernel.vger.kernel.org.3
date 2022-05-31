Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A761D539512
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 18:46:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346218AbiEaQqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 12:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346219AbiEaQqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 12:46:07 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919CE994F4
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 09:46:06 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id rq11so27827123ejc.4
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 09:46:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cNojDTLao1Z4XaYj65XKMONnf5xkNz1oGm9Mhmr9dio=;
        b=CdOghQEWfzmHS/gYSBGNd2Zmo1WoX6ZkLgkCYy4aXw3cor8o5NKLh7p51XrC/HhmLq
         nqmBc2kzlyllIM3gXBiyxhqltGuDh6eA6pYyLHt9jrZV8Z3Jc247vcE5OAL7jFLRBqiL
         2+pwqtApnzyaED7q1C+yxi0D5kHjxYNEbpUQw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cNojDTLao1Z4XaYj65XKMONnf5xkNz1oGm9Mhmr9dio=;
        b=iY41X27c7b2CaDvKlz1Xak8LizK8cz74DVyEnsgB92cMmnpDy/z8l6JeMDjXni0E/R
         Pp5/XOSe2ZpV2UF3uQssDULb9NsOdXuAarj7njTnXD8bo0yZyD/S8Q009+o015btptdi
         wG89wseFR0KEAa1+9OsAII1dZ/BD1h46+RrThtYEs/4p3POyHStfJT2uAlCCRy6Qi+eQ
         Uc9Fe8muO3m0GxTUDBVS5W08GHd0RgyyTBO1tzxpvw6f/BKSWoMB0gN24mWbU0Ows0J/
         jhvGMou2RexrTqKVvsDpwwmszxnUhNzygO/8G5/VE6BLwd/Dza8lrhcAgdE1nK6xqFmV
         HKnA==
X-Gm-Message-State: AOAM530PzuFgZgsjdoSAUvxVH920p0V8m1/BBmmMeaHxAPNmdzLzAv/E
        HqpEmv8/q35vnPeXcAUKJzW0mU0MHhwIElT+
X-Google-Smtp-Source: ABdhPJxcWTqtE5dJg2MgULG/9I1m8P3aj205MtKQ+/fpbgQI4/Ib98yzFSuOnzrwZNUuzNYYgZrIig==
X-Received: by 2002:a17:907:761c:b0:6d6:e553:7bd1 with SMTP id jx28-20020a170907761c00b006d6e5537bd1mr52841173ejc.5.1654015564625;
        Tue, 31 May 2022 09:46:04 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id h10-20020a50c38a000000b0042617ba6396sm8635893edf.32.2022.05.31.09.46.03
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 May 2022 09:46:03 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id h5so11396570wrb.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 09:46:03 -0700 (PDT)
X-Received: by 2002:a05:6000:16c4:b0:20f:cd5d:4797 with SMTP id
 h4-20020a05600016c400b0020fcd5d4797mr39830737wrf.193.1654015563235; Tue, 31
 May 2022 09:46:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220531104424.0a467ba4@canb.auug.org.au> <9353ac77-f473-3f64-7e61-566807cd47e2@I-love.SAKURA.ne.jp>
In-Reply-To: <9353ac77-f473-3f64-7e61-566807cd47e2@I-love.SAKURA.ne.jp>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 31 May 2022 09:45:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi4wyvuXs0SUq-2x=XHxWmJ6jVKRD-WpE0kWgWiqVJNbg@mail.gmail.com>
Message-ID: <CAHk-=wi4wyvuXs0SUq-2x=XHxWmJ6jVKRD-WpE0kWgWiqVJNbg@mail.gmail.com>
Subject: Re: linux-next: build warnings after merge of the tomoyo tree
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
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

On Mon, May 30, 2022 at 9:32 PM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Yes, currently there are many matches when building all modules.
> But do developers build all modules?

They had better. Every time you change a core header file, you'd
better check it. And the minimum check is "build as much as you can on
your primary architecture", which is usually something like
'allmodconfig'.

> Hmm, an important part which was missing in commit 771c035372a036f8 ("deprecate
> the '__deprecated' attribute warnings entirely and for good") is that Linus
> builds all modules and reads all messages during the build?

Indeed. I do an 'allmodconfig' build between every single pull  I do
(except when traveling - it gets too painful on a laptop), and often
do a couple of other builds too (ie I have my own "machine config"
that I also do).

And yeah, I will complain if that build is not quiet. The standard
kernel build needs to be _clean_, because that's the only way you
notice when new problems happen.

                 Linus
