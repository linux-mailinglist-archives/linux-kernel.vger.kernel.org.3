Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0554513E93
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 00:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352915AbiD1WiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 18:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352904AbiD1WiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 18:38:02 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B167C12EA
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:34:46 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-2f16645872fso68382937b3.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0feeoMrcWszYCfSrxHSgx4H/3IveYcwWC4Cl4lgiGH4=;
        b=ixUNmBFVgYwgdLVwJIRe4IdaB6TGEHx+HLHPTiwTPLr31WNdRttL2C/OZf+7ep2n0+
         xl7MZ+kjlYuatydCbkMYlC4+wHU22lq919Bsie6bgrXCm3IG3dKJMWE+j/2TbnPshb46
         EvbhV0mNdoyWW5GeFCMQpIoVM3ZAFEt/RM2xfLlXhGEC6X9NT5W0Bx6U+NJIEom2VSTZ
         gu8ZrgVK4jtoOWRC+ZNthBvnpwUv9Dutk5AkoncraxV/DXT+IV813VWCa8IfcGDSLwLJ
         Y+5LxbsY2CE49BKq+mz9LwBggwJgd8CEMvU5yluJrn/b8APR/E+AlqVHhXQuO5NV/0tH
         5IHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0feeoMrcWszYCfSrxHSgx4H/3IveYcwWC4Cl4lgiGH4=;
        b=yP2hO44oyOoKVzrIFGtRk8rXlybfF+kr2aZk0wudSnqPCmj4+XE5K1SnknEqG/z3ZI
         oPhOpesZvFK+nWrXzs6HLgjWfng8X/zXEzn1MDy7zPK6tZ09QodlYnYuNCYg+JAY4Ne6
         fE9Gh/cvXphugXU07x8NUfzWb4+91AhZilUc6aKZrgFrERdqY7prcJINj5UPZ2xYYx6F
         t9YtrQuQ0aboW3i0tlDqe2nTELRToAy0aoyAa77zb78/oFbuRMqP0sZ4udmdvI/SN+4u
         YNjBwR4EUeQVSgeviuq1lmtJ3dB/ppNR/GNOIqTwEfHTBmx0OaWoOp5V0yl34I9tKTbe
         lWOw==
X-Gm-Message-State: AOAM5317C+fNQToVzXVUrp4ZEEcEJQMghUj8nC5c2h81kNeuUCC+/6lJ
        ezteieWr+ZW6dsIExeI0Sw46IvdkpJZV4oym9Ic7CQ==
X-Google-Smtp-Source: ABdhPJwymsnQ4Q7gEKcXPpD/MbjbiQgK5FOvY/AhPhloOsoz4XMxyhZejE9yU1YUIvUX/6kvgt3ECRLKcKg0x91b3B8=
X-Received: by 2002:a0d:f0c3:0:b0:2f4:d291:9dde with SMTP id
 z186-20020a0df0c3000000b002f4d2919ddemr35531921ywe.437.1651185285368; Thu, 28
 Apr 2022 15:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220428111622.1395831-1-michael@walle.cc>
In-Reply-To: <20220428111622.1395831-1-michael@walle.cc>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Apr 2022 00:34:34 +0200
Message-ID: <CACRpkdZfTh9NeNtGHLavOz6HXjYqLwOcgi87E6k2rj9RjTZLfw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: microchip-sgpio: make irq_chip immutable
To:     Michael Walle <michael@walle.cc>
Cc:     Marc Zyngier <maz@kernel.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        UNGLinuxDriver@microchip.com, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2022 at 1:16 PM Michael Walle <michael@walle.cc> wrote:

> Since recently, the kernel is nagging about mutable irq_chips:
>
> [    4.967050] gpio gpiochip1: (e2004190.gpio-input): not an immutable chip, please consider fixing it!
>
> Drop the unneeded copy, flag it as IRQCHIP_IMMUTABLE, add the new
> helper functions and call the appropriate gpiolib functions.
>
> Signed-off-by: Michael Walle <michael@walle.cc>

I'm still waiting to see if Bartosz pulls in the prerequisites
to the GPIO tree, when/if he does I will pull it in too and
apply this on top.

Yours,
Linus Walleij
