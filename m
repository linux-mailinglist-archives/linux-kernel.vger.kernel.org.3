Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309D85A9840
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 15:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbiIANOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 09:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232997AbiIANNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:13:00 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413DF30E
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 06:12:25 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id se27so26846822ejb.8
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 06:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=G9R0QAAm6mXZOdYiAbbisy0joj2Ln2Tb7boXjxnlO/g=;
        b=XZmKOPIt8Qub9dr7WZ0y95VXwgms4z2JKISqKno0HjZqjygLhx86t/8lg8cQA1V259
         aIFSzv2ggf7B/nBSpbOnOz4EYycxS3OctxzAFjx2jK9377GZqOays6bmAHc8mqKvmBWl
         rYGSv/RTvkHvwuY2T94ju1Qj1Wp7r8VfYRIcXKv1mxCrLdiEV5r/4Ob4ixWDxeKAW8Fl
         qTcsz/JkBpXt3ObqhruCwrv8+t5aSk+Q0USqUQ2qqk4FZmqnG5WEWojPSIc0ONSvbKi1
         g2LoyoFZzSYLqORYz1RUwx5C2vqSRtOm/uqJFdfnDCSZCUDUN7U/Z5KCja3e35VT974k
         Uh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=G9R0QAAm6mXZOdYiAbbisy0joj2Ln2Tb7boXjxnlO/g=;
        b=Yqso8cNtVZJgShxGXZkyqvoHm8Nd2mgeTz09X7lZ5/6tmcYWowPBlA5lOLcZfr78I7
         EdLbAm9vi1ZotGNBpbfH1G1QM8AVcgn6zjlqHd9gT0aFb2CGIH0fGIDR1zzLjvfDlbk+
         kJmq3fQo7LIS3NwW0S7WwcSoMKG49hUTS2sHefUqyhKv8MLLfNjZJd/7r3zlMd3FzKpx
         o0zpRMYQvw7it+CGvYtVJzqr0bqD2tge4B+AAoVa1cNh8y09eE31VQttyx1MIWCkUdwN
         t/Wsx5E1OInAYWiZGIH9PgmoOoVR2KyKFHIZgz4sjaG6rZY+UYaWm6Ueg2zHc7oEML4D
         qL2Q==
X-Gm-Message-State: ACgBeo2MnOKLt6VmLn0Lv+EVDYrBOHBjcSXozGgXsYo4N6rINl1fbTTU
        xvc9Vk5xblpL/22jhm2RaWMoSMVmRJQXR5OqKJDFAg==
X-Google-Smtp-Source: AA6agR5UF8wTUdNJMqiJ1bGz7CO4QmbS2WAvDOmDCubR574vrDPFyL+Pq6Ir79zWEUfqZAPm5lH0f0EctbBbcfvO3dA=
X-Received: by 2002:a17:907:2707:b0:741:7c18:4e76 with SMTP id
 w7-20020a170907270700b007417c184e76mr13260189ejk.690.1662037943636; Thu, 01
 Sep 2022 06:12:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220827213009.44316-1-alexander.sverdlin@nokia.com>
 <CACRpkdYgZK1oaceme6-EEuV3F=m1L5B3Y8t6z7Yxrx842dgrFw@mail.gmail.com> <ccde957b-20b1-2fd6-5c90-ad9ee4b8924c@nokia.com>
In-Reply-To: <ccde957b-20b1-2fd6-5c90-ad9ee4b8924c@nokia.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 1 Sep 2022 15:12:12 +0200
Message-ID: <CACRpkdarYrhtrv2W8+MQm6QNFkrqE-EUVz4cm7kGvsbWgBdk+Q@mail.gmail.com>
Subject: Re: [PATCH] ARM: kasan: Only map modules if CONFIG_KASAN_VMALLOC=n
To:     Alexander Sverdlin <alexander.sverdlin@nokia.com>
Cc:     kasan-dev@googlegroups.com,
        Lecopzer Chen <lecopzer.chen@mediatek.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 1, 2022 at 10:42 AM Alexander Sverdlin
<alexander.sverdlin@nokia.com> wrote:

> >> -       create_mapping((void *)MODULES_VADDR, (void *)(PKMAP_BASE + PMD_SIZE));
> >> +       if (!IS_ENABLED(CONFIG_KASAN_VMALLOC) && IS_ENABLED(CONFIG_MODULES))
> >> +               create_mapping((void *)MODULES_VADDR, (void *)(MODULES_END));
> > So the way I understand it is that modules are first and foremost loaded into
> > the area MODULES_VADDR .. MODULES_END, and then after that is out,
> > they get loaded into VMALLOC. See arch/arm/kernel/module.c, module_alloc().
>
> yes, but both areas are managed by __vmalloc_node_range().

Owww!

> > If you do this, how are the addresses between MODULES_VADDR..MODULES_END
> > shadowed when using CONFIG_KASAN_VMALLOC?
>
> That's the thing, __vmalloc_node_range() doesn't differentiate between address
> ranges and tries first to recreate [already existing] shadow mapping, and then
> vfree() unconditionally frees the mapping and the page.
>
> vmalloc() KASAN handling is generic, module_alloc() implemented via vmalloc()
> is however ARM-specific. Even though we could teach vmalloc() about MODULES_VADDR
> and MODULES_END (and don't call kasan_ instrumentation on these), but, this is
> ARM-specifics that it's used for this range.

OK I get it. Maybe this warrants a comment in the code explaining the
above behaviour (also in commitlog) so nobody gets confused.

With that:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours.
Linus Walleij
