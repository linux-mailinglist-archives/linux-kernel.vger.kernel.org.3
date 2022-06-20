Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 973C1551EE2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346752AbiFTOei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242683AbiFTOeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:34:07 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC5D2ED6C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:48:50 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u12so21228918eja.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hoDwsyCPbxAXsPRHgnlWqg6oqsfxTDr8MWMJehQSHOQ=;
        b=U6tJGh/ymYHJiOb318DThrdnVTEZzfdovLcKmFYgbh21zmIgPKtJLHpjrLzRcM3mPQ
         AwblBPHbaUn1sIe9+J57uk9W8nJTLB9gDPoIzdvfMX9nDPz5lWR3Ad04VhCL7L7Vlj+4
         sWDgThs0lL1RNQ3/cOOn2pxDMihnBbUgHo10w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hoDwsyCPbxAXsPRHgnlWqg6oqsfxTDr8MWMJehQSHOQ=;
        b=C3fmEQEQr6CfIZHVQLmRLm6Zh6a5r+gh3t2okLzX1AJSaY4IcNVAP7MjwqoI1IAj4N
         XAPTC95uh715/TRLPT2exNIY1YrnClkiNvXl3JybITv6akkm6dyxzCbTvENTlHDTnSzw
         WZwfx6VnkdO4OLOBS19JxGwCD7vGxQt/7N4p8Z0DxsN4FWC21U1uzcgF8kZMsSm6WaiV
         m0yuEnhOwV8MMRixnyFt8XPUJki8fzvvNI12whzyDJDgCo6mSUSQ1m2R/eGt2sS3wntb
         vriGZcpjPfLHlOE/ACO7MTWxH8rYCM3+TuQwpGwivQ7n3PFW+eBmCxjef0klzeF5GQwH
         e4fA==
X-Gm-Message-State: AJIora+UwzRheRE5asHADHFQCw1aKQftPjjeA14L1EjVvzYr59MjkIjQ
        LrA1KVgubpN2dDWhb5BzkUz/ribsddJXsm5D
X-Google-Smtp-Source: AGRyM1vaorRZdMBl69MJeLMDHDRRQ3c9NAP6jkbfSSaYEZ22xAI3sivXG5l4Gm7s82H9BKPCVB5iEg==
X-Received: by 2002:a17:907:60cb:b0:711:d516:ebab with SMTP id hv11-20020a17090760cb00b00711d516ebabmr21435036ejc.159.1655732928445;
        Mon, 20 Jun 2022 06:48:48 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906218a00b006fee98045cdsm6112461eju.10.2022.06.20.06.48.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Jun 2022 06:48:47 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id m1so7014509wrb.2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 06:48:46 -0700 (PDT)
X-Received: by 2002:a05:6000:1251:b0:21a:efae:6cbe with SMTP id
 j17-20020a056000125100b0021aefae6cbemr16632661wrx.281.1655732925960; Mon, 20
 Jun 2022 06:48:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220619204949.50d9154d@thinkpad> <87r13kwawb.fsf@jogness.linutronix.de>
 <20220620112936.48fcb2a4@thinkpad> <YrBdjVwBOVgLfHyb@alley>
In-Reply-To: <YrBdjVwBOVgLfHyb@alley>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Jun 2022 08:48:29 -0500
X-Gmail-Original-Message-ID: <CAHk-=wgdquXVVE37CZooVK4X+YdSa7XoGtjr71CEYh8UsdKUow@mail.gmail.com>
Message-ID: <CAHk-=wgdquXVVE37CZooVK4X+YdSa7XoGtjr71CEYh8UsdKUow@mail.gmail.com>
Subject: Re: Boot stall regression from "printk for 5.19" merge
To:     Petr Mladek <pmladek@suse.com>
Cc:     =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>
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

On Mon, Jun 20, 2022 at 6:44 AM Petr Mladek <pmladek@suse.com> wrote:
>
> Both early console and proper console driver has its own kthread.
>
> >    1.166486] f0512000.serial: ttyS0 at MMIO 0xf0512000 (irq = 22, base_baud = 12500000) is a 16550A
>
> The line is malformed. I wonder if both early console and proper
> console used the same port in parallel.

Honestly, I get the feeling that we need to just revert the whole
"console from thread" thing.

Because:

> So, it looks like that con->write() code is not correctly serialized
> between the early and normal console.
> [ ... ]
> I am going to check the driver...

We really cannot be in the situation that some random driver that used
to work no longer does, and causes oopses and/or memory corruption
just because it's now entered differently from how it traditionally
has been.

The traditional console write code has always been very careful to get
exclusive access, and it sounds like that is just plain broken now.

So I don't think this is a "driver is broken". Even if you find a fix
for it that makes that particular configuration happy, it sounds like
there is a much more fundamental issue at hand: the new printk code
just doesn't work well, and does things that are against the way
console printing has always worked in the past.

I realize that people have wanted to do printing from proper thread
context for ages and ages.

But maybe people should also just admit that "I wanted this" was not
"this was actually a good idea".

                  Linus
