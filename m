Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A71D4E7CD3
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 01:22:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232021AbiCYUR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 16:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbiCYUR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 16:17:26 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C245739154
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 13:15:51 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-2e64a6b20eeso94502427b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 13:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vtp7+nDUHbkUKPJ586tHhPQHIGkVxn40OpnwYxUR31I=;
        b=etfZ2To2AkmbDwdMb4CemT9IGY7lkeRqGgVivTwjfOQJoN9U9bZ5skarGYOO2Oq8I0
         W85wxZ8MPSLmLidAYZCd3XG0GDfGOSJKpINCippQRZGUf7Nv9cZTqf84DSWa+YPREmgF
         jJqjj7mlo2YiKvw3yAeMF21Nuy5X7hyehxeuuPotXyAenAXf0nNM4RHRLc8YQTULVjPA
         FqvoJtQBRtjgVLv8zsO/m3D+DMyKzHyOdMJjXEHhIrWlkoWzla+aDSLA07y0aDgRaEER
         CNMkNERYLMkcuoRK5l4y2xUCEszmqCFGPSwPFGBQV9Ds1A1YLeewOIjQAM+4kGkM0z4M
         IPBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vtp7+nDUHbkUKPJ586tHhPQHIGkVxn40OpnwYxUR31I=;
        b=WoN2/rULwhjqytIlftjAMipov/LRNI/VTdh+I34BKD/Xh8E99R6l2mMfEAKTM15Iqu
         QKUsPGvdY8nRyKXC37O21et7/XbQzs3atvCl9Kc8wcgAYhfCZrUcapxHa2g0HL5X7dYm
         +gvOF06dgQkDAKyBMA1qJs4tUlp8oitJf0XQ5FWGoKbj3OLf+Nig8DTK9PNFvd1uWcGM
         iGRXBC7iCFW1BqLiV4Jn6Y+VkX8h7iTInSV4l1sQ74mpGFpq5Kxl9zlA9AF/HUCCnrmw
         tNfrSL0qOH2FqDoodaznPCMg8mkx5boK0OOqzzvvrkooGER4MpNhMxqpJMQulbiKs95z
         tc2A==
X-Gm-Message-State: AOAM532x9oxhI6XevPm8SlD5nrT982n3vUA4k79W/yZxnqMytIgiPDnj
        5BUqFMsZcsC6gEzdQ4Z1kEP3V+PpaBinYUurm0Li+A==
X-Google-Smtp-Source: ABdhPJx9wqjoJz3ZPG5WcmFuaeeOXO7mos5GYyBTpymriLoOeZj41vkwrTWS/8NtQ2pgHGEGQWw5VikpO324lYovgig=
X-Received: by 2002:a81:1182:0:b0:2dc:4e58:da41 with SMTP id
 124-20020a811182000000b002dc4e58da41mr12592447ywr.268.1648239351038; Fri, 25
 Mar 2022 13:15:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220325074450.3228840-1-zhengbin13@huawei.com>
In-Reply-To: <20220325074450.3228840-1-zhengbin13@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 25 Mar 2022 21:15:39 +0100
Message-ID: <CACRpkdYHKq+aSHzm6wG3ETwob69gmmjFT5UV7EXL0rDxe4ZQ=Q@mail.gmail.com>
Subject: Re: [PATCH -next] pinctrl: nuvoton: wpcm450: Fix build error without OF
To:     Zheng Bin <zhengbin13@huawei.com>
Cc:     j.neuschaefer@gmx.net, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, tangyizhou@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2022 at 8:30 AM Zheng Bin <zhengbin13@huawei.com> wrote:

> If OF is not set, bulding fails:
>
> drivers/pinctrl/nuvoton/pinctrl-wpcm450.o: In function `wpcm450_dt_node_to_map':
> pinctrl-wpcm450.c:(.text+0x404): undefined reference to `pinconf_generic_dt_node_to_map'
>
> Make PINCTRL_WPCM450 depends on OF to fix this.
>
> Fixes: a1d1e0e3d80a ("pinctrl: nuvoton: Add driver for WPCM450")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Zheng Bin <zhengbin13@huawei.com>

Patch applied, thanks for fixing this so quickly Zheng!

Yours,
Linus Walleij
