Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D04B4D9028
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 00:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343617AbiCNXN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 19:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343621AbiCNXN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 19:13:57 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236E1385
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 16:12:47 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-2d07ae0b1c0so183072247b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 16:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/4Ng72DEMJZQ3vKqwaFDLeDEbQLFRq6vhCDNE+Xq22k=;
        b=wAu5gFGOxW9EFAC+CAsMNSH3Mwe/y1h7mnSx1lUN+Pg+on7cGgjUke7mvjeo9VaQGA
         WE/YSh69H48TreZKk4xAN3/4NZCiI8DecFeJToFEo6cEYUjLjW8LanKZqduyManKfMc7
         8UgvFFLz3amZnwTl1fYzpwVf7VJi4+QqGciU9qCfFQTetssyle7woHtvgVr5cS/+u+27
         Mwg5FyTnYx/zbirZVDxwMu/ogxhPxuFSQm4h9rtdSzFp3MR5rD0y+vmrUUzvQasP5HJZ
         YUjGv49l2Ta1OKuhtji+OZQaEyAwokDT4O/PH+iKfKcxr4ND0d5bpQTajmCKpMsy4ZPa
         IS/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/4Ng72DEMJZQ3vKqwaFDLeDEbQLFRq6vhCDNE+Xq22k=;
        b=4QRpA7v0266aTD1RAIB5tPMq++LAL6y0gAogWsN2D1s4aE8fxsGr4nPtgykuxeqMwh
         Qf/aDRRa5xLFST+AmbHYIQJzf4UxWIojHrWwRRCZT7RPSVje6rRDC2CSrSfMt1EpBtEr
         ELh3FLNWKu4OEa1JHr2f3gX5LFm75bfgo85yJmrzmGgISkobh2olEwbKbiRu5EE12yHd
         PjtCdR64VAtNlhil3Kj5VYOHyt04+Z1Zi79Tj+zKoUy05yp7zvkutcBe3QlzP0szaY7N
         M/hMTxKbD05NU720kpcPBrcelH3xw14YH7mb2rwLnEmdN1KO+NB+2UcAxfCCqrKvkpfk
         +LlQ==
X-Gm-Message-State: AOAM533eRXa8bQujz8EgvDai/RaWddoYw603AAjIFp7P747HgNJNYUpp
        rFd+uI3FdwuQ2/IftcA21ZKCHDu/MpqWBP+RyW1HFg==
X-Google-Smtp-Source: ABdhPJxnEZRMtPD3xRUKRlfDDbD0CWt7hFvmIjt9so/RSNKg1eKNNFT85bA83kFK7JOOAK3L6TrbGNJG9riQ2uZxMAw=
X-Received: by 2002:a81:d15:0:b0:2db:d348:2fda with SMTP id
 21-20020a810d15000000b002dbd3482fdamr21430009ywn.151.1647299566366; Mon, 14
 Mar 2022 16:12:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220309035607.2080884-1-chi.minghao@zte.com.cn>
In-Reply-To: <20220309035607.2080884-1-chi.minghao@zte.com.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 15 Mar 2022 00:12:35 +0100
Message-ID: <CACRpkdY6QYSx7pwxJj87ZwQXExk-E6e3_RXvcHFTQibPJP4k+A@mail.gmail.com>
Subject: Re: [PATCH] mfd: Use platform_get_irq() to get the interrupt
To:     cgel.zte@gmail.com
Cc:     lee.jones@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
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

On Wed, Mar 9, 2022 at 4:56 AM <cgel.zte@gmail.com> wrote:

> From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
>
> It is not recommened to use platform_get_resource(pdev, IORESOURCE_IRQ)
> for requesting IRQ's resources any more, as they can be not ready yet in
> case of DT-booting.
>
> platform_get_irq() instead is a recommended way for getting IRQ even if
> it was not retrieved earlier.
>
> It also makes code simpler because we're getting "int" value right away
> and no conversion from resource to int is required.
>
> The print function dev_err() is redundant because platform_get_irq()
> already prints an error.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>

OK that is indeed much better code:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
