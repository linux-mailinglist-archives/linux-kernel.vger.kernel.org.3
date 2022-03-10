Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BFA94D3EAD
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 02:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239129AbiCJBVO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 20:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbiCJBVM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 20:21:12 -0500
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC629AC069
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 17:20:11 -0800 (PST)
Received: by mail-yb1-xb29.google.com with SMTP id u61so7928344ybi.11
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 17:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JmPdtloZn5nLn/nh5/A9uRjfT6MWL2yPHo380/oj0ww=;
        b=w2TYrLbGDfZLgkaLpTjQ52vZzwISr9+czyvmtGOyHYlOGImxset3G99l2vSx9R6uxs
         BdWyTm/u7y3kgHqO6SLEQp2gaDhBy6rPMjwlhbgeU6RBnxF477rTZ4Am0X3I7Ef3dGA3
         gIPiWBspaRv2ouza0ht1ZmUtaEL6Xuv7APsGk8QzwKf30lzJjS1E2liOhdl9rYx1xMgn
         WhTaQVn1gcapOoR3fy5UoAcphiX+uteNycMRtJ7FzznUiozdFrbBvXE+eA+nSakXmDse
         tLaP4GcbvuXvzeeeoyygSRs/bswNVuMa2MY7kGYXDT5mVv5DIabSzdZY1iLCFIhOAFM9
         HLDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JmPdtloZn5nLn/nh5/A9uRjfT6MWL2yPHo380/oj0ww=;
        b=CeSaSofguOUIs6iKgPbQhB/4y27C+tl7QQg+t9y/KQfkqmQ6yg0tj0Xy6beerjSeZX
         1tv6HBsejBiFqU+aNPL/C+n79m9VPQlgFxAJqlmvkivGF8CYbBzvFSYmSsAZSAfdCv9y
         VdwVINEll0GGoZxel3ZwhE64jyMAVHO6z02PGUkv0LLwVS/c02PullKQyZlzW1kTJZSI
         6AjnlUAKSd5p4Bh2awDGifMtJziSDxpIfwl0+mxO+2uRdEHvFYPT3eNiZrAjjL+QNfh4
         wfH3unaKzfo5H45iRC5pV4dQIijHHpwKpFQSSZLaJ6McFITibwcippCc7jdiKkc451Pq
         8Axg==
X-Gm-Message-State: AOAM530L2f/0BScYENUlKdi2qVPTFwwOWAK7T0HLyXXPJr4BXVRxLs7a
        bYC2p+dwcfMdEiyrsxDpsqdjfz/v7KpUtmQdldqJ/Q==
X-Google-Smtp-Source: ABdhPJztq9SMnVEkO57rm6BrTRuialGjIgkikwsM73vKRGs4fElni7/EYW3p3+X17HJJxRPyQoW4vHyb5eWbzJtsjuU=
X-Received: by 2002:a25:da85:0:b0:629:36f:5669 with SMTP id
 n127-20020a25da85000000b00629036f5669mr2120273ybf.492.1646875210862; Wed, 09
 Mar 2022 17:20:10 -0800 (PST)
MIME-Version: 1.0
References: <20220309144138.360482-1-arnd@kernel.org>
In-Reply-To: <20220309144138.360482-1-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 10 Mar 2022 02:19:59 +0100
Message-ID: <CACRpkdbvZjDvxtWW=G=tO5+16RqwcdtWKFyT+ix2A9aXN7bbPQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: fix building NOMMU ARMv4/v5 kernels
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
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

On Wed, Mar 9, 2022 at 3:41 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The removal of the old-style irq entry broke obscure NOMMU
> configurations on machines that have an MMU:
>
> ld.lld: error: undefined symbol: generic_handle_arch_irq
>  referenced by kernel/entry-armv.o:(__irq_svc) in archive arch/arm/built-in.a
>
> A follow-up patch to convert nvic to the generic_handle_arch_irq()
> could have fixed this by removing the Kconfig conditional, but did
> it differently.
>
> Change the Kconfig logic so ARM machines now unconditionally
> enable the feature.
>
> I have also submitted a patch to remove support for the configurations
> that broke, but fixing the regression first is a trivial and correct
> change.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Fixes: 54f481a2308e ("ARM: remove old-style irq entry")
> Fixes: 52d240871760 ("irqchip: nvic: Use GENERIC_IRQ_MULTI_HANDLER")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thanks for fixing this so quickly!

Yours,
Linus Walleij
