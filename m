Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B3505A00F2
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 20:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240484AbiHXSB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 14:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240753AbiHXSAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 14:00:54 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A564112A92
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 11:00:05 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id w19so35045099ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 11:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=ZH0AW3c9ztNqQzucg5KecEsPcM7OXPYg9d2t9+QVkjo=;
        b=hwRf6JyOT1Jyp0yqMsQEH6rdf0/piRq37jqkfAP9b+yj4UgKieh1p5lJ1PeSPPku84
         Q3fgiavUUAOWFzbMHBjemM2EeNkp+0hFoRZsEJ/w8iL0FZCQspTvI5uiJGUuSao7RTjr
         OD0dVfYQ3C2R84vUtaqXCpY+azqvbS7HdWLIE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=ZH0AW3c9ztNqQzucg5KecEsPcM7OXPYg9d2t9+QVkjo=;
        b=RiUZUbeSp1ruiJWbTYX3/d3CEmTgCTw5suV1B61LPKZ/h6vrqa78ZpKQ9EACY/e5e6
         b0UJQKqbHPLmxsFJBZTaNe3N0sJWVpJrRoIgZKVOFNOeBfHU1IcqJuxv2sqbKysBqXNe
         dUZgp7awbVrSnNYsrO/RW58TPxQjr4fKyTBv9V393YdbBKGvwJqgGBm38jHDcCwIf71R
         h6JIcxtO+JhMgGkz0zIkNM91Xfk43oUttiG47dKJmq+G3Uba1qWLINKZWQfazPl7++2h
         66Jm89sx4G3Zmw+cVycwM13BAYzwIpb+IU0B/sMqDKfaifyTsc5xcAI8PNWr/Y/nJ2Pt
         uTGw==
X-Gm-Message-State: ACgBeo0f2trsaZVuXTnsjx0S6beHTvugLS+CVrzGfUgNY4TwfJFTNcn6
        lkjA4sl6JSVV7hMh4zPAR3UfgRS/qBb+vuGH
X-Google-Smtp-Source: AA6agR5ENRR7eYtG+We8t5qvY3uFWLKXtBcpSppB4zuATajYVMcs7N3vGHNQotOQpCp0NV8L5Wtggg==
X-Received: by 2002:a17:906:9b84:b0:73d:8324:487e with SMTP id dd4-20020a1709069b8400b0073d8324487emr99631ejc.98.1661364001610;
        Wed, 24 Aug 2022 11:00:01 -0700 (PDT)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com. [209.85.221.45])
        by smtp.gmail.com with ESMTPSA id 11-20020a170906308b00b0072abb95eaa4sm1417780ejv.215.2022.08.24.11.00.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Aug 2022 11:00:00 -0700 (PDT)
Received: by mail-wr1-f45.google.com with SMTP id bs25so21731706wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 11:00:00 -0700 (PDT)
X-Received: by 2002:a05:6000:136f:b0:225:2fad:dde7 with SMTP id
 q15-20020a056000136f00b002252faddde7mr210002wrz.274.1661364000263; Wed, 24
 Aug 2022 11:00:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220824012624.2826445-1-yury.norov@gmail.com> <20220824012624.2826445-2-yury.norov@gmail.com>
In-Reply-To: <20220824012624.2826445-2-yury.norov@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 24 Aug 2022 10:59:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiRJ1_kmvgkDCD+bp5zH_=KJ5217a9HqQji7XWBhp3nXA@mail.gmail.com>
Message-ID: <CAHk-=wiRJ1_kmvgkDCD+bp5zH_=KJ5217a9HqQji7XWBhp3nXA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] lib/find_bit: introduce FIND_FIRST_BIT() macro
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Dennis Zhou <dennis@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Alexey Klimov <aklimov@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Whitcroft <apw@canonical.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 6:26 PM Yury Norov <yury.norov@gmail.com> wrote:
>
> +
> +#ifndef word_op
> +#define word_op
> +#endif
> +
> +#define FIND_FIRST_BIT(EXPRESSION, size)                                       \

Please just make 'word_op' be an macro argument, the same way 'EXPRESSION' is.

That way the LE/BE cases can be handled without any odd tricks.

              Linus
