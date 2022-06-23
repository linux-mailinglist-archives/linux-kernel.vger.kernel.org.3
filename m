Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BDC558A11
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 22:30:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbiFWUaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 16:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiFWUaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 16:30:24 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5866554BED
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 13:30:23 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id e2so610370edv.3
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 13:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H/lO1oENNfy7vmMJgr/E29ldbZVBHzBZTdtNgKvBlKc=;
        b=OYrprdnXLfCPeqbZyaMSZPCV4jww/kffZoNEBTHlZV7PQ9L2dClQvSVmOn81DyovCg
         mIsPcjZ7b0tCBsej/j2/V401TYKuO6bsIgB0nNizYlSafGAisc8wXyfUwUfXjVPAhyg/
         h0LsBlUFW8wr1EskyscqsVlMW5YjxK0obm6UdxqWzNK3xKXd/yzSM1eG/1ITtxvwm2Og
         7l1bHHzmzMpSY3rG0D3gj4jFFkKmmGxZ0xN/ZSglMZqWb2elfxGMi5uLDgJ8HiNTJMeN
         q235Vqxgan9472OtXJxseJE6QtGXfRdPYH9bZnXzcqH5oYP9wJ/gKsy3M4F0hKRuEOO+
         nZoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H/lO1oENNfy7vmMJgr/E29ldbZVBHzBZTdtNgKvBlKc=;
        b=50yMf7ilw0R3QzMPTHu2N2dmy0UAsFV2mZGI4MEjQnW67ExGGqyw04giOCXEsTq4S6
         63rXUN1D2kE2kguspmCvV09YJCMQsxsKTrkatKs2nU7wluhzGnOvXpvvE032f4DY6EW9
         3Bw44URUTqufSMtU2aoYSIzZGmYkIyDWbh6eS8BeKdq5CFDf9bdr5JMRhwvQRJ2PSc6H
         ZhaTIVCQA8Bf5ABbtbUumCSqh/R9AMZ21I5EdL+ti40i6ocJPEafA7X178Khf5jVcNjD
         bD+wyLvoiGL/msjIHHnP+LkM/u5cGAUATwfPrsAK9amef/IEDB1sLgHiR3cQly8XREK9
         GV9Q==
X-Gm-Message-State: AJIora/amUVhNv5y8IBaL2SQ+yM5xxPffHxanAewVTB5NqGy6P/QyyS7
        P2amDdxAwwI4bQdScSiqktd7vbOz+l36QNCF8rvKt545Kn9hng==
X-Google-Smtp-Source: AGRyM1vp+akZQOu6612uR1H5BLWRRkjkLz0ROFh1WQmqoL7FNnAU9Sd4mnw3yBTysurqaByP4xz0j0pWGZsJRcQ4YEc=
X-Received: by 2002:a05:6402:430e:b0:435:9e41:6858 with SMTP id
 m14-20020a056402430e00b004359e416858mr13228843edc.69.1656016221918; Thu, 23
 Jun 2022 13:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220613054310.21186-1-a-govindraju@ti.com>
In-Reply-To: <20220613054310.21186-1-a-govindraju@ti.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 23 Jun 2022 22:30:11 +0200
Message-ID: <CAMRc=MdLOEWyUjhsyUHU0hfHGbd+SmpzNUOagOoLM6z9eVAZgw@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: davinci: Add support for system suspend/resume PM
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>, Keerthy <j-keerthy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 7:43 AM Aswath Govindraju <a-govindraju@ti.com> wrote:
>
> From: Devarsh Thakkar <devarsht@ti.com>
>
> Add support for system suspend/resume PM hooks, save the
> register context of all the required gpio registers on suspend
> and restore context on the resume.
>
> Signed-off-by: Devarsh Thakkar <devarsht@ti.com>
> Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
> ---
>

Applied, thanks!

Bart
