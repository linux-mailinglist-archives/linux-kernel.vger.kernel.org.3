Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B24C55779E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 12:16:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiFWKP6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 23 Jun 2022 06:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiFWKP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 06:15:56 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D851549F9F
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:15:55 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id t16so24218156qvh.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:15:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WdEpPXLKfhqq9IG36z1EWALeSW6O91EJHeyMOynLQUg=;
        b=HovcxFkftONUcVFktQXXrBl/6JQp5LiLWU3VnCAA9qydF0aZ6NZjaoefVlLT8xjiZt
         KUmP2wZhpdyy6SGKjc8OMVEa1DWeEwlc9Y9CZXCAnjj+s5WuI0ZIIFWEnAjYX7jHO4mX
         Ff1CcZ4D8aNqHT0QqYX2waBB20m0bE5spgjRAMDsx7RvmPVe/r6ZLh0FYmECM78hj/yK
         maH3EAb756z3j6s+ra0NLFQ/pkgvj1RgeNdW9g1UGEI/EHdGD4GJk4Owz568gF5yuCw6
         6X7acj+Tt2hOdUSCWy937GD4fjN/RPlqaxEavt4dlhR/4CQwKcMcxsVY/FDF3Ezqpd2P
         2HPg==
X-Gm-Message-State: AJIora9u+UewnQsPeR2mYUjcnZ1nzWo/W3T6zL71n7PbJRd88bHu98bM
        S0iJp3xOEDrYIbmUNNuTg1B0bEV8QTUTHA==
X-Google-Smtp-Source: AGRyM1t5Ir2vo8xOLUDj31cNyK60lOJXmbNgeE/WC6o5NPSo1m4uboJqtaMmIA3mOmLK7jtT3zCT0w==
X-Received: by 2002:a05:622a:13c7:b0:306:65f0:d26e with SMTP id p7-20020a05622a13c700b0030665f0d26emr6865803qtk.538.1655979354838;
        Thu, 23 Jun 2022 03:15:54 -0700 (PDT)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com. [209.85.219.181])
        by smtp.gmail.com with ESMTPSA id x12-20020ac87a8c000000b00304fce6a137sm15635280qtr.66.2022.06.23.03.15.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 03:15:54 -0700 (PDT)
Received: by mail-yb1-f181.google.com with SMTP id w6so34998792ybl.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 03:15:54 -0700 (PDT)
X-Received: by 2002:a05:6902:905:b0:64a:2089:f487 with SMTP id
 bu5-20020a056902090500b0064a2089f487mr8751534ybb.202.1655979354043; Thu, 23
 Jun 2022 03:15:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220621090900.GB7891@pathway.suse.cz>
In-Reply-To: <20220621090900.GB7891@pathway.suse.cz>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 23 Jun 2022 12:15:42 +0200
X-Gmail-Original-Message-ID: <CAMuHMdXq6eboM1m-K+TbEhZDWUUTgOM8vKUu_pDbwz04hoUPiA@mail.gmail.com>
Message-ID: <CAMuHMdXq6eboM1m-K+TbEhZDWUUTgOM8vKUu_pDbwz04hoUPiA@mail.gmail.com>
Subject: Re: [PATCH v2] printk/console: Enable console kthreads only when
 there is no boot console left
To:     Petr Mladek <pmladek@suse.com>
Cc:     John Ogness <john.ogness@linutronix.de>,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jan Kara <jack@suse.cz>, Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Petr,

On Tue, Jun 21, 2022 at 11:09 AM Petr Mladek <pmladek@suse.com> wrote:
> Threaded console printing does not take into consideration that boot
> consoles may be accessing the same hardware as normal consoles and thus
> must not be called in parallel.
>
> Since it is currently not possible to identify which consoles are
> accessing the same hardware, delay threaded console printing activation
> until it is known that there are no boot consoles registered.
>
> Link: https://lore.kernel.org/r/20220619204949.50d9154d@thinkpad
> Link: https://lore.kernel.org/r/2a82eae7-a256-f70c-fd82-4e510750906e@samsung.com
> Link: https://lore.kernel.org/r/20220619204949.50d9154d@thinkpad
> Reported-by: Marek Behún <kabel@kernel.org>
> [john.ogness@linutronix.de: Better description of the problem.]
> Signed-off-by: Petr Mladek <pmladek@suse.com>
> Tested-by: Marek Behún <kabel@kernel.org>

Thanks, this restores the lost printing of "38000000.serial: ttySIF0
at MMIO ..." on SiPEED MAiXBiT, so
Tested-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
