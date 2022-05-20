Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D2E52F173
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 19:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352130AbiETRVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 13:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352122AbiETRVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 13:21:36 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C183EB90
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 10:21:34 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id jx22so3364817ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 10:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GBLh0J+t/T5q+hfavxvNCcW0ikmymnmk+L3i1gWEqLQ=;
        b=QIZj/BbktjFwNItbM7A4GHMQdfprBs12g+gEp137eJ4gShNtIomOg5zNm2P1gwgbQl
         JcpnYRSLPfvjVeHefqzcmEyVVGOOju/QhphTINFE94yCDUyCTHmAwoM9P5dfYZ74OpE0
         jDHkLLqe60XGXbyWq6T5gTOzYc/8POk5KB2jJetIETnFh5xaK0tA0Pi2On1Lq8yIu5Gy
         PtzF0eeLMjUgOViN+zq2FAefPcMi70cxeVqfm4dZCX5Jc2hkdWQLSK9ZXKYAq4sBIISF
         2Sbgz8l18I7JbgptT6J01r8NH3TdpLVabFKFF2Yx7grm/f5F8tmaXcXV7ZivCcGYXkZI
         x8Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GBLh0J+t/T5q+hfavxvNCcW0ikmymnmk+L3i1gWEqLQ=;
        b=qUVVk5PA2xucGh/Rcb77foJxoL/WjQL6lXNbpo6LuIsqLGIYCXDF32DTFt11/8b888
         c08TBydIMhhZLSZXKq+qi88f2lWNhwrBee+k2L68ZVhJrA6QktJioiHAdDgonpkRd+l4
         asbkE7ki9MhS1KJGUqNlfi6jvalesBk8jpYydNpK103m2pw2jisYa07xoIMvDXTnbhbR
         DkLGivdJ/o9JB09w8UU+GrKKxC0MiUbIEG18PRWjpnde9+QezEuKtCyjX4Sa7Xw663eY
         wjCko6zg1Y6MFDG+KxH2bLIG2Jti0Zd/bAlE6AYXYX++N0jHMDLtjbzgdHn/qMqI78Hy
         MJLg==
X-Gm-Message-State: AOAM533pTp1L4XdYIDPGxEkA20TqFSBrfUwl8MPIeJ94eGpL3dAHS6XN
        MVwDU0OYf6uHlConV8g4raC/Wul0BRBBvrgXc6J0LA==
X-Google-Smtp-Source: ABdhPJzPOGzMa4WOrxVRY1ADDnO0nuDdJB8phnBRSLJYIZ9p8JWPCDylwwWy2QTLjqsGI8G2/nuNSho9l4qrI5EakkI=
X-Received: by 2002:a17:907:6e04:b0:6f4:d6f3:c72a with SMTP id
 sd4-20020a1709076e0400b006f4d6f3c72amr9421686ejc.636.1653067293120; Fri, 20
 May 2022 10:21:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220520025624.3803776-1-zheyuma97@gmail.com>
In-Reply-To: <20220520025624.3803776-1-zheyuma97@gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 20 May 2022 19:21:22 +0200
Message-ID: <CAMRc=MdysKQK4zGa=GH5-T=NTWOiMHBEEd9hKeHYANgKzrwpTQ@mail.gmail.com>
Subject: Re: [PATCH v3] gpio: ml-ioh: Convert to use managed functions pcim*
 and devm_*
To:     Zheyu Ma <zheyuma97@gmail.com>
Cc:     Andy Shevchenko <andy@kernel.org>,
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

On Fri, May 20, 2022 at 4:56 AM Zheyu Ma <zheyuma97@gmail.com> wrote:
>
>  When removing the module, we will get the following flaw:
>
> [   14.204955] remove_proc_entry: removing non-empty directory 'irq/21', leaking at least 'gpio_ml_ioh'
> [   14.205827] WARNING: CPU: 0 PID: 305 at fs/proc/generic.c:717 remove_proc_entry+0x389/0x3f0
> ...
> [   14.220613]  ioh_gpio_remove+0xc5/0xe0 [gpio_ml_ioh]
> [   14.221075]  pci_device_remove+0x92/0x240
>
> Fix this by using managed functions, this makes the error handling more
> simpler.
>
> Fixes: e971ac9a564a ("gpio: ml-ioh: use resource management for irqs")
> Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
> ---

Applied, thanks!

Bart
