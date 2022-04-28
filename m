Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B7E513EAC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 00:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353038AbiD1Wux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 18:50:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353018AbiD1Wut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 18:50:49 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5A7C1C8B
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:47:31 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id r189so11595991ybr.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 15:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rNIaKSd9HIOo++vQl55ronwO6gWeoBJTBYDBf9qgIGc=;
        b=xDEiqUW0WSk4+uzwF0xl2Of3qEC5D1FWLYE5HSp6i6QWdKwKWokbTmpRaSJEmFkQeA
         rr1smsrUCQokqpRT1zKrUjWADVBVnxFg6L7QhmQV8Zu7tgFSIUx3FxdPzNpFEPk+Ti2B
         v/Q/t5AwR86jyOqaWihswIPNkAkKFZA4yqgwm3qCv0ROPVz24RdHdvG7PYJi++D8Zbba
         0R9dXFBQmxW+2Im+ACPlloNLaLfHR2d1N/MY2HEEHn1cDf7LbKRXKWf9Wu+dtvdgvGG9
         VbkhbKrfVxve/AN3KksU/BPi7ZPHAh1hGFAaNJ8M/7hFZUBRavohA6D+do98WsK9sxkC
         TzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rNIaKSd9HIOo++vQl55ronwO6gWeoBJTBYDBf9qgIGc=;
        b=ohMjvefNRgCVjRGWkxur7Glni6NllhQZArS4rr6cgG8GUmivBxSeFrNztEhdcJZz4F
         1k6uvm3gwtij6IFE0txjO6ICR+v0ICj2vpT7NBr+9gZNrtQSmu67i5ltG+lzbiNigFZy
         pvRsGw0TTlXWDtj3Pf5lFCfGYPC8r2ox7k/epPBejaAV5mbWYhT1kOytSD7c4GGqP75w
         NoBBq51YJErnKih+qEHhyF1GpQIOJRzJPh7z/AZ6OrJIMfe4pgbAue2wQNZfoTjEWJhW
         J3RyPoqkPZ5tBWSylvJV8BXk4tJ8mL1v6fkreuC99xgbmqm8dBxxKotFJhgfjUB4UbfF
         YCOQ==
X-Gm-Message-State: AOAM531j7tvSR0qqU7q4KsnPYIBpcEE6TGR6BaA3tKrNZVkcrTDn1C3x
        0CBcPF2gLqQUsFhz2oEHJl27wHkwx53jhE2V2oc9gg==
X-Google-Smtp-Source: ABdhPJyq3RnHxpIs1eT7rZa7x+L1tgpqQQaWbIkCGc6vz4lOgunasyHNBZt/HD3SsyvhMQZY25MrO/JWCpjUd8WpaCE=
X-Received: by 2002:a25:a12a:0:b0:644:e94e:5844 with SMTP id
 z39-20020a25a12a000000b00644e94e5844mr32540771ybh.492.1651186050515; Thu, 28
 Apr 2022 15:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220413192918.3777234-1-horatiu.vultur@microchip.com>
In-Reply-To: <20220413192918.3777234-1-horatiu.vultur@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 29 Apr 2022 00:47:19 +0200
Message-ID: <CACRpkdbMxK=w4DDsPUrdzkJcjHRhZfuY585gUR8j0HP88m19dQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: ocelot: Fix for lan966x
To:     Horatiu Vultur <horatiu.vultur@microchip.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        kavyasree.kotagiri@microchip.com, alexandre.belloni@bootlin.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 9:26 PM Horatiu Vultur
<horatiu.vultur@microchip.com> wrote:

> For lan966x, the GPIO 35 has the wrong function for alternate mode 2.
> The mode is not none but is PTP sync.
>
> Fixes: 531d6ab36571c2 ("pinctrl: ocelot: Extend support for lan966x")
> Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>

Patch applied for fixes.

Yours,
Linus Walleij
