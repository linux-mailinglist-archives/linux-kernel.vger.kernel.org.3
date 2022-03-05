Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711234CE250
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 03:41:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbiCECmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 21:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiCECml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 21:42:41 -0500
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C295A24F866;
        Fri,  4 Mar 2022 18:41:52 -0800 (PST)
Received: by mail-vk1-xa29.google.com with SMTP id x62so5318394vkg.6;
        Fri, 04 Mar 2022 18:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KkcNCtjpcO8rVm8LUzoHbBDqzf+JRgklTyG6XGrgh2A=;
        b=n3v5g4r26iSDUpyH/15c34qb0OSlTQqGD+1AH+W+Ewm3Q8qbcr6ZF6eVUJqPxPg4AK
         v1GMcYCik7Q682YyBSUSvzc4tarHahIlPrBHLKlVNZ6xWcydkFrucAajd29dD6DrJJwB
         KTzCOgZpQjNn+KApVn46AtG6+ybOyLOhA9IoX4hMorNwLui+negdc5M2M9uoYiNIs9yd
         rBlpV3llDOutr17RMr5lWoEb9FOXiZ9lIk79HMyeVyH1CJcoAt+fTwQEcMbyduPCmZax
         Ew3hwauqxhC3lmJkK/c1qRQHdxy6tAj+6Hq97iFEV2MNzbiVNsP8nR/6Cf4PLyfkf3T6
         J5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KkcNCtjpcO8rVm8LUzoHbBDqzf+JRgklTyG6XGrgh2A=;
        b=xdZXcN9ndX6kIjQSkktOsaEWTkfV/+JtGBe5Tiy4wCcYZjhq2uxKVQ0TQMNAFTSNoD
         29ckoy8axEIFoc7y4PEQm5uaFXxCAgPPnb1iqcio403cY4MNpoDFqSH7xUTztYTStCI/
         Y9dn0fTy+jO6U630wuOY4Ci2+sx//kcZH6s0Me0oksnu0ZZTUy/ClYSoM9vSTBsOn0kS
         ZegBiwEgNgCk+jmyVWy7EAxBIwap5CuQOtqfUS/kT9O9ebsc9HdWhrhnTwzxYXafus++
         bYDD5jPFxxarNP2ON8gOqRSLUkRzKrcgqMXElCcKSWhhkNfrXObLB5aDM6OhmK9PkSQD
         2TNg==
X-Gm-Message-State: AOAM531VMTI4FhWRyCvpHzxIQA0Z+62a7ky8EVFagBAXlNCwHd1lNwH4
        G5ykantArbgyJyL3RVa8f+3N2rDE+9Im3KVt00iZBH3z
X-Google-Smtp-Source: ABdhPJxOsN2RrE8cJHgE60PZbU5R7UZ2J4YCIf+ekeTLJwL7RE7YXmJekBtVPUrks2W4I8GY7/R3s05NmLLJnOyQapA=
X-Received: by 2002:a1f:ee4a:0:b0:336:e616:82c6 with SMTP id
 m71-20020a1fee4a000000b00336e61682c6mr603775vkh.8.1646448111552; Fri, 04 Mar
 2022 18:41:51 -0800 (PST)
MIME-Version: 1.0
References: <20210226141411.2517368-1-linux@rasmusvillemoes.dk>
 <20210304221247.488173-1-linux@rasmusvillemoes.dk> <20210304221247.488173-2-linux@rasmusvillemoes.dk>
 <4b560502-3885-91a0-3100-4b5506a17b32@roeck-us.net>
In-Reply-To: <4b560502-3885-91a0-3100-4b5506a17b32@roeck-us.net>
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date:   Fri, 4 Mar 2022 18:41:39 -0800
Message-ID: <CAKdAkRQj9fTv-g03__ncNrnyNh5x+4uG2_yioyrc-iFAd22c3Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] clk: add devm_clk_prepare_enable() helper
To:     Guenter Roeck <linux@roeck-us.net>,
        Russell King <linux@armlinux.org.uk>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>, Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        LINUXWATCHDOG <linux-watchdog@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 8, 2021 at 9:32 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On 3/4/21 2:12 PM, Rasmus Villemoes wrote:
> > Add a managed wrapper for clk_prepare_enable().
> >
> > Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
>
> That has been tried several times, including by yours truly,
> and has always been rejected.
>
> Just use devm_add_action_or_reset() like many other watchdog
> drivers.

Can we apply the devm version for crying out loud? I do not see what
benefit there is to force everyone open-code it with
devm_add_action_or_reset(). By simply blocking it we are not making
the kernel better and it's been stalled for a very long time.

Thanks.

-- 
Dmitry
