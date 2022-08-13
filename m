Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4449591A86
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 15:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239457AbiHMNPh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 09:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235278AbiHMNPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 09:15:31 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 758AF1E3C3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 06:15:27 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id l64so2983276pge.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 06:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=NOVF3cxn2Ri4x7HZo2XH8zAToMyNEkNqssFkJS3Mqok=;
        b=fo0R6i5xMVYrHmk0aMK56No9uNXQICwOCaH2EdVQ9e26VfuQ15FpgCfmnft7Ijdd9O
         ZObpHyWvrZ9X19qrUWjMufvZZA4R4sMMZ0vwXB5zhKOxn57HSIOKCJHoXbRegcUWPjHJ
         MUj7HP/nbw0jkM6WI+aWHq9Hjt68Cg6pDkOEMC/zR+ocwgJrRiRYGyVFanhnmO0UNYRb
         kApOl2ZiSazW0AEwju5YCfveledXA4q45NoRueHsmDn2qxIh7jbcoHgVYlp/fsChZwDQ
         Kcuakz696nBOP8DavByhMZFU1+Qa/JF7scKIIyZyvOt4sJQ40eXNWOgHbpfIxwAd3See
         SHJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=NOVF3cxn2Ri4x7HZo2XH8zAToMyNEkNqssFkJS3Mqok=;
        b=V/kLw3qNo5uHOEVvWw6JyzXdhjwp5LTVzxgY2NLc3ofEsvNmLE9PgHiiipK2ErC6YY
         Tg6ay2HRt4Q5HwAWj6DwjsQU65zNaMJvWl6X9xZKnbDhutobjJXjF+4VA4g65rtmgyXx
         ZLCFfsv4FL0WlDXLJQl83rHR4WEpOg5cdW4zN681wyMSVr+T1HcMALIJo1q4Dh1TGKOk
         fNmUOL8W/gXNIJeM0ws1mCy9VTXAZg0If4pIM4yhyjedvmnAwRJ3g3X7B3qA71bris1C
         BgaIgS6cZ+/BKHYAk9YsEKZFizkXGEXAoswgoL3Gi4bmp/7CueB45lqxxFmwS1x3lA2q
         g/xQ==
X-Gm-Message-State: ACgBeo0KT1zigDsLhfWgDhcwrNOXiuteftNyq7N9fxVkZdwCWwrhxD4z
        gzyUYM0ALpSaU66IMXlXjHk=
X-Google-Smtp-Source: AA6agR5LtjhsBKdIGS2E4yqtSOcgjZBm18RZyQ33RxP3LIFIarQTFLk3fb8LYNZ0Q2/cZHcCzxsrMg==
X-Received: by 2002:a05:6a00:10d3:b0:4fe:5d:75c8 with SMTP id d19-20020a056a0010d300b004fe005d75c8mr8525693pfu.6.1660396526799;
        Sat, 13 Aug 2022 06:15:26 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a25-20020aa794b9000000b00532649b67bfsm3331095pfl.84.2022.08.13.06.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 06:15:25 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sat, 13 Aug 2022 06:15:23 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, David Gow <davidgow@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Isabella Basso <isabbasso@riseup.net>,
        Kees Cook <keescook@chromium.org>,
        Keith Busch <kbusch@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>
Subject: Re: [PATCH 5/5] lib/nodemask: inline next_node_in() and node_random()
Message-ID: <20220813131523.GA2787704@roeck-us.net>
References: <20220711044711.466822-1-yury.norov@gmail.com>
 <20220711044711.466822-6-yury.norov@gmail.com>
 <20220729034638.GA2276915@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729034638.GA2276915@roeck-us.net>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 08:46:40PM -0700, Guenter Roeck wrote:
> On Sun, Jul 10, 2022 at 09:47:11PM -0700, Yury Norov wrote:
> > The functions are pretty thin wrappers around find_bit engine, and
> > keeping them in c-file prevents compiler from small_const_nbits()
> > optimization, which must take place for all systems with MAX_NUMNODES
> > less than BITS_PER_LONG (default is 16 for me).
> > 
> > Moving them in header file doesn't blow up the kernel size:
> > add/remove: 1/2 grow/shrink: 9/5 up/down: 968/-88 (880)
> > 
> > Signed-off-by: Yury Norov <yury.norov@gmail.com>
> 
> This patch results in
> 
> Building powerpc:allmodconfig ... failed
> --------------
> Error log:
> In file included from include/linux/nodemask.h:97,
>                  from include/linux/sched.h:22,
>                  from include/linux/sched/mm.h:7,
>                  from arch/powerpc/lib/feature-fixups.c:16:
> include/linux/random.h: In function 'add_latent_entropy':
> include/linux/random.h:25:46: error: 'latent_entropy' undeclared
> 
> and many more similar errors when trying to compile ppc:allmodconfig.
> 

As a follow-up on this: The problem is still seen and now made it
into the mainline kernel.

Guenter
