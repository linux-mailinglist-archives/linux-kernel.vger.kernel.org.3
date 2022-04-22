Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0B450C2F4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 01:09:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbiDVWq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 18:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbiDVWqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 18:46:42 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98EE3135394
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 14:37:06 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2eafabbc80aso98376527b3.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 14:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O1brtd49tFwU6VlKDj5lc7i4Jw60+UgK83W4qk+h+e0=;
        b=XmIyifA+YpSofgABXPeSSRBcyBPBXndpAol7TNCDT554ScXbKEZAGvD8TXYYTomqT9
         b1YgxnQtXAnla4d+aH4p7J7sUz8LS4gj00UO/+UgEyJkk4wt3eWA2/f9Q/Mman2yKB5g
         2+qB1nwco1Og0RxqJK+kfROBBCxGPhj6XC7UUwURBmzFCN7l3rpY2NLq8FnHtN+CetHK
         3FEliT9GwLRCfAMRKaPlKBFh01G1mYUZla2ux4cNWIfhWPogxM3DxBF4nDtHQDgCk13d
         JQ5ekbGxRAFBNNzbit2lZnRMqQVTGY94IfQnW5SbBCm5qqSOlwRzABfF5Uv9l9bs2VN3
         CLSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O1brtd49tFwU6VlKDj5lc7i4Jw60+UgK83W4qk+h+e0=;
        b=7/Z1sVws1hg2jDMgg10jToDudK3zdp1LMvyWGJO3f/bSv+Ny7NlTaG/kL7GZA86OkZ
         KPufRsGLsWR2aZwTD/ZD4xiZZQgdn2/VGaWXhaiANa/yzS6uKEl8buCwnGlM4WlFcND2
         wgkkhqgKZA5mm1/5t1cdAwlVemQW2FWcBmRVkspopf5LdlIopR3jQ0SomWFUr1FEL+3+
         sDnh/chJCu581FiCDlzH2K5TxPK6l05KLuVFRsconKz4aWwbxGwSedZ5y5GupU7jDCc4
         YZyNG22ovxFLCPwwzkGg3kGyQ2788SPWto+Df3ZipjuE65RrjwNsf2oP4z/KZSUwKVWf
         AfrA==
X-Gm-Message-State: AOAM532utfjvfXIdTGlKGgpYwwaXL2ZUqAVlG/lVTevK2YKFkbFOgqVU
        fntKWD9d+3fAFYB5iE4sxGOqdtSK0JjzOY7o4WQnl9YnRx8=
X-Google-Smtp-Source: ABdhPJzpJm8aFbRgP7AYh9JTSDrohue4rzeBHmDncZK7KYHl1Wq9GHZoH62A7GncOVa0KRpQG0mu6FKnr2J3pJbFF1w=
X-Received: by 2002:a81:2154:0:b0:2f4:d79e:35dc with SMTP id
 h81-20020a812154000000b002f4d79e35dcmr7027734ywh.126.1650663425930; Fri, 22
 Apr 2022 14:37:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220420142432.248565-1-luca.ceresoli@bootlin.com>
In-Reply-To: <20220420142432.248565-1-luca.ceresoli@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Apr 2022 23:36:54 +0200
Message-ID: <CACRpkdb51a=kuudD=g8ozzmsHdgHzou2gA8_zT2Ex4bds923cQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: rockchip: fix RK3308 pinmux bits
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     linux-gpio@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        Jianqun Xu <jay.xu@rock-chips.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 20, 2022 at 4:24 PM Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:

> Some of the pinmuxing bits described in rk3308_mux_recalced_data are wrong,
> pointing to non-existing registers.
>
> Fix the entire table.

Patches 1 + 2 applied for fixes!

Yours,
Linus Walleij
