Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AA7578409
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 15:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234888AbiGRNng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 09:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbiGRNnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 09:43:33 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DAC21821
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:43:32 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id m8so1897046edd.9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 06:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hnfHfZxYNUZt/Px9ux9l14VbmfOCDnqYfPKEnB9z/no=;
        b=AnHZKs0DXJjOJJ00mzghBpIrSTeMvfnlR9SpjD+0Ngy7A25lxpgsbgrTvYadxfFs3i
         ekNFu09OZaRfC+OSxO0gfaj999gyBKfuM/LeR5If3pHoPFRtH4k1FZzxQy8nafE4J+13
         1sOGaakvolq0P+RVcs1FvfHVBMtrxkF1vDqf8AtgQukbkKyygNZcQuIjluqtxl8uJn2T
         UYvOqJCH7oWlseBBo5CXUoNga7xLCDXaMahcsx9QARuGoI40pngooYzijLG3ph1sCgqF
         58neSor1L1qoO18p4hB3BdBt5Itakel5WNzZ1rNACC/791SYMzUDDsp3tYBr/9qUCSOJ
         skMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hnfHfZxYNUZt/Px9ux9l14VbmfOCDnqYfPKEnB9z/no=;
        b=VrzHgU0s6wGJxQqK9oXEkX6SR0bWKZSKf+s8qfk0fWZ16VrXLYiwvFXb3AJ/K54OX5
         2uhQC3+1sGjy5NI90VaCGpR7RxhkYjg7ZYS+VhArf8tDylhUNtTR5vvpTt/yBtXi9suM
         R0c9Qh/domXwvpBdvoMUNZU6R1Nm9TPNX3L2R76tlOOZEi3UiWxCp+tuNDrvaPGMP46a
         s5hV3EWpsVvcklSvkzAYcI/uTJfIsMHznz2I9dbnNISL9L2UlfZye84SSK5mintq5GaK
         UljaX7E8zlGZ6alrQvtXSXWZJQN5yANOxG3wDOeQlFNKHzld6HfRAPJ5hDGpygqD1hFO
         e81A==
X-Gm-Message-State: AJIora/88VoJLYVeQvwrRaw6Vx2C94HUZa/9nHacqRreUT69kdu0fKM3
        35v9E0TPS1DoPOrUvg0a3CB+CqJTdX2fC7UEV6eAww==
X-Google-Smtp-Source: AGRyM1tUllg8yDsJKjb0ainm4ebnVZKH+EWWmJB7x63T+CXhnVAYvvjjahiW31mzwxL9T/Uk9p27OBGYW7hbzKVa2Kg=
X-Received: by 2002:a05:6402:34ce:b0:43a:a4bb:27a6 with SMTP id
 w14-20020a05640234ce00b0043aa4bb27a6mr36844792edc.158.1658151810702; Mon, 18
 Jul 2022 06:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220716233745.1704677-1-vladimir.oltean@nxp.com>
In-Reply-To: <20220716233745.1704677-1-vladimir.oltean@nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jul 2022 15:43:19 +0200
Message-ID: <CACRpkdZ4tdKwYBaTGzc4DX6H8Bsib1cDLkTnpTiipCL7uFquXQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] Fix kernel splats on boot with armada-37xx irqchip driver
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?B?TWFyZWsgQmVow7pu?= <kabel@kernel.org>,
        =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 17, 2022 at 1:38 AM Vladimir Oltean <vladimir.oltean@nxp.com> wrote:

> Due to these splats on boot, lockdep disables itself on Armada 37xx and
> we fail to see further useful information about real deadlocks.
>
> For those in doubt, the approach to use raw spinlocks for irqchip
> drivers has been previously discussed here and doesn't seem too
> controversial.
> https://lore.kernel.org/lkml/20210825205041.927788-1-vladimir.oltean@nxp.com/
>
> Tested on the Turris MOX board.
>
> Vladimir Oltean (2):
>   pinctrl: armada-37xx: make irq_lock a raw spinlock to avoid invalid
>     wait context
>   pinctrl: armada-37xx: use raw spinlocks for regmap to avoid invalid
>     wait context

Patches applied for fixes so they get some rotation in linux-next.

Reviewers have some days to react before I send this to Torvalds.

Should these even be tagged for stable?

Yours,
Linus Walleij
