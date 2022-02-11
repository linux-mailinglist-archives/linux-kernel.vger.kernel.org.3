Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9335B4B1B1A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346734AbiBKBUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:20:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243679AbiBKBUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:20:23 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5564A2651
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:20:23 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id p5so20421456ybd.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FxR2tCd2kQ2slz4IkVSpQwFsX+MPwtsdOXOlbt9nOOY=;
        b=UQnBoKSK7byn2I0KnUJSpQUYM33v2c1HGs/VbASBlEP3xui+kZkgyeCWVxp5XUdfx2
         AHCPQcjBpxGE16zdapg1W5X8VEzI6TfhymRx0nBgsvzGJ1IOGwlPD8rn59ZxC0Fa0d25
         3n2KxZYmaA/Xwu7CiH7povjf+KUmXmiOw4OgnjfEopvWVGYUGczJNe7Ir0zbFMC2Vhn3
         3Y0yk0SeMEfqjl7X+OvgxEfW2jgPdi8BB1vmotBZMER7Fco/IGR9T7RrOPS/DyyJvKtU
         0YfR/aJGhOxmpuDFWH+sf+g07IM9XxmI25DHNNX8WdX4LJvC3lDksGovzt+GUoka/84o
         x6Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FxR2tCd2kQ2slz4IkVSpQwFsX+MPwtsdOXOlbt9nOOY=;
        b=ZcOMfk4hR9UpQWXU7Y++He5g1bWSIevqTFoM2b3zoWfgAn7bPQfSTxnZkaR/T2ynVe
         lb8Aa9umcTobRgiHf5G97hSGx/ayjBzNIrdqzv6Q9UZh6O8XGJ5bNR7ILiMtUcjkQp7q
         hcwHRqTqhpwmUc2vK/dKZz0i6zdB8uYiJ/dnOjh77i/n8kjl+stMqx6fRQNVUC76ElWD
         ejDkdAoF9GSaozSZXOmQpiVQi7f3ola6xE9itkqls/co0/w/ps4erFXZXzQ0h7s4I8H1
         tszcSogb6fbjPLjXW3WhIeaygq7HzVHbbUbMdZTSplBSSJtHMyf4WRZ3kKpH2y2GX0rv
         auGA==
X-Gm-Message-State: AOAM530GcXYzQtQYVOed93X4A5430bIGsYqT+X7HHyUpr1S8469XLRs0
        WiPzFLq4of/UPUcg62ncW+yGS04bH1U62yYyq38JJg==
X-Google-Smtp-Source: ABdhPJxvvbhC/Ip2xmkeo9KyLe5UWlcZ2Cjmmt6Q2osiy0C19S3Zfn9E7oHXfdrmpct5QTha34v/loucubB8P31MPwI=
X-Received: by 2002:a25:5143:: with SMTP id f64mr10175550ybb.520.1644542422611;
 Thu, 10 Feb 2022 17:20:22 -0800 (PST)
MIME-Version: 1.0
References: <20220209182822.640905-1-seanga2@gmail.com>
In-Reply-To: <20220209182822.640905-1-seanga2@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 11 Feb 2022 02:20:11 +0100
Message-ID: <CACRpkdZmWAhToG5m0pqzpE6G-xZKnqYPS5GZnyLfzs0XQ3CfJQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: k210: Fix bias-pull-up
To:     Sean Anderson <seanga2@gmail.com>
Cc:     linux-gpio@vger.kernel.org, Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
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

On Wed, Feb 9, 2022 at 7:28 PM Sean Anderson <seanga2@gmail.com> wrote:

> Using bias-pull-up would actually cause the pin to have its pull-down
> enabled. Fix this.
>
> Signed-off-by: Sean Anderson <seanga2@gmail.com>

Patch applied for fixes.

Yours,
Linus Walleij
