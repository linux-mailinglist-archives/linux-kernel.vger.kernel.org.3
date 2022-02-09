Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD6364AEC28
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241044AbiBIIWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 03:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239620AbiBIIWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:22:15 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE58FC0613CA;
        Wed,  9 Feb 2022 00:22:18 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id cf2so3439909edb.9;
        Wed, 09 Feb 2022 00:22:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XpQU7MwvnnmzkAtetNTBKBwEhnc+PKqXnl8IukTROIA=;
        b=IhXDd7OGarp3eySx5bkZfw12VJDhaOaz7OC5hMX1/gqGa7Kv64i/UfuFWYOZ646SMC
         +COGlUX3M8SLh5qgaI138hDe5mHFI1ah2h7Ya68sA5Q7NyR5UNd88Cq+eFVzeZ0Of76Q
         N79j63SOMOlONqN/c5Vnjih/sDEW67NcDoHTdj80hEUuU977wg/Ju+LaEfTp+Nh/xPIg
         gXvQUAdJ15BHg5TDeROrmqmxo6PYPCBvlKC+wU5FTqSMf6SlivQeu9IoTBM6O9QBFqjB
         TaFiiZFMvdRL6qTgtEccmtyHtpgbNJKnaQw8U76C9RzU7NLskUOUdEI0p0ZrQRJ9NLkj
         JrlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XpQU7MwvnnmzkAtetNTBKBwEhnc+PKqXnl8IukTROIA=;
        b=Xo1cvAVoyQKP1xn+cpPf88o6c5ifycUQo0Po2d7iDa2Nq7wyMVd250hqGw650Nu7mK
         /5rvODwiBCvg3dTaQsxaZdKNjbNOvrKk1UM9CayrIqRHg3qF7urtXJTHVw2s8iEzuOX0
         5CaBdq2zfYABChPZh/W5Gk5oLFOJkotoclKvTCN73VYP6HbjHvuJWgu+grMVuKMwUpPR
         ARxDwFjtzvx84I6LI3xYmgwmhQ5eq5tML4vax31rm5N/WM6gywbeUhHQ6292Y4UGP5Tx
         V/J42exdSYKfwGXGHGQ9KuzxXZan4xMVE0oRdbX20KlINYMHL2CTUXYdXcK9Zl8Y7mrK
         8JxA==
X-Gm-Message-State: AOAM530RByrFXYgmBF0zvH4+iaSh8JTp/UVtCJu+z40yHGeTO3fkLrBH
        eRnUGhXpuSiVYOtZjmAn1LUiYC0FljnVSl0/rac=
X-Google-Smtp-Source: ABdhPJxgbIM9HkQTeMr8qIeIvkRgzKugj11n3DUKBGJfOENttEguf2tvMkGSkDAJKiQ90eexactk/erkyNtZaQFulHQ=
X-Received: by 2002:a05:6402:4254:: with SMTP id g20mr1242666edb.281.1644394936606;
 Wed, 09 Feb 2022 00:22:16 -0800 (PST)
MIME-Version: 1.0
References: <96f0e23f49d708ce2476a6c19867443a48d78f65.1644283006.git.yang.guang5@zte.com.cn>
In-Reply-To: <96f0e23f49d708ce2476a6c19867443a48d78f65.1644283006.git.yang.guang5@zte.com.cn>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 9 Feb 2022 10:21:40 +0200
Message-ID: <CAHp75VfQMkb0Ek6HG_FL+4OJV91=nd3QKjYFCobQPCt5PzdASA@mail.gmail.com>
Subject: Re: [PATCH] serial: 8259: replace snprintf with sysfs_emit
To:     davidcomponentone@gmail.com
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Zev Weiss <zev@bewilderbeest.net>,
        Johan Hovold <johan@kernel.org>,
        Yang Guang <yang.guang5@zte.com.cn>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/ASPEED MACHINE SUPPORT" 
        <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zeal Robot <zealci@zte.com.cn>
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

On Wed, Feb 9, 2022 at 9:24 AM <davidcomponentone@gmail.com> wrote:
>
> From: Yang Guang <yang.guang5@zte.com.cn>
>
> coccinelle report:
> ./drivers/tty/serial/8250/8250_aspeed_vuart.c:85:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/tty/serial/8250/8250_aspeed_vuart.c:174:8-16:
> WARNING: use scnprintf or sprintf
> ./drivers/tty/serial/8250/8250_aspeed_vuart.c:127:8-16:
> WARNING: use scnprintf or sprintf
>
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.

Subject should start with "serial: 8250_aspeed_vuart: "

> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
> Signed-off-by: David Yang <davidcomponentone@gmail.com>

Who is the author(s)?

-- 
With Best Regards,
Andy Shevchenko
