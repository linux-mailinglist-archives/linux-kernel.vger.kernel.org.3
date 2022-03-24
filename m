Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 188D24E5C68
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 01:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346842AbiCXAlV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 20:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiCXAlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 20:41:17 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E817B65171
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 17:39:46 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2e5e9025c20so35717117b3.7
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 17:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8rN13FMeqEprGT5GtmNj2tl/IA4XlrCPy/4n11uT4fQ=;
        b=lFcisYYInl3HhTN9FFSdwKvRMetfhMw7fQeFnSW86dZe5L+XqQ8MjGPrpAEzEQXAt5
         LqcnW/7aRPO9dsI6WqRmEMkClwvp14cGL86TdEutHb3KsvDkXQKXUfGGg7ilRtflQNot
         B9t9JuVMDSN9Yp43S1qt7s0f/KCgHaYlpqDq33vcvwDEgKRSVwskw94RPWF1v513MvNS
         cqJ1fmjC5zqHjWYggPS2OFCXXvXU1ZFq8hQaaFVc4Xy8rUEUf1T20Yv4i0Thg5beToNh
         tSE+Z7oHq0TQBBvu+SyIfWvdRc8wjdmorRSrF5DpZfzWilfYZV6b58FF4MHzQwxoulaj
         A0hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8rN13FMeqEprGT5GtmNj2tl/IA4XlrCPy/4n11uT4fQ=;
        b=QRR9SGubx1kiKqONqJd8f0y45rA7tk2hItIctjaKeuxmmZ9ua1djYaGpO2j4cAuver
         YgQxcGa0jQHbqLQ4vU9GS7ijrfC5/+Any/du5bY9nq9KVLSGLikKOIfO6QjrZcW4x3eG
         xZUMqHZEvKLKJmSQGjaMYYCsiJlpEXoDb4OTY7/Pev4WgAjJKis9hRFPqErSdubrG68r
         uj3+yzsCZKEbTjbvrMofM4R+j6YjUnILt/sBAuqTK62J6/lmHYnKJr549sy5BaeTgZ2m
         Cdp2Bz5tYk8+YDsRpsMbbzkT0nFEqWhMcJEG0vFA2fQNDsOYWscgw4xPGh6w+lsHPqZE
         eavQ==
X-Gm-Message-State: AOAM530qyfC6XD9RNggl2J/oTPnr7s+s8w50N0lTeoeC9vmxvH8PGf4P
        qdbgv9scVuU1DXwOcp62Yx159LmoKbAYH4YXsH+RHA==
X-Google-Smtp-Source: ABdhPJwT1ooHzR6MDCbcAp1jYjLkMSCzH+kNHbpUiB/d+Fr61zHv94kOyIzetchA0tV5BKYcAwVjw2Jh3I98bLj2M44=
X-Received: by 2002:a81:d542:0:b0:2e5:c060:a0ac with SMTP id
 l2-20020a81d542000000b002e5c060a0acmr2644500ywj.118.1648082386034; Wed, 23
 Mar 2022 17:39:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220317065851.495394-1-zhangjialin11@huawei.com>
In-Reply-To: <20220317065851.495394-1-zhangjialin11@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 24 Mar 2022 01:39:34 +0100
Message-ID: <CACRpkdac+fBez9rX6Ewqng9mbywKBcMN3VACdMO7mhh=dXUnow@mail.gmail.com>
Subject: Re: [PATCH -next] pinctrl: nuvoton: Fix return value check in wpcm450_gpio_register()
To:     Jialin Zhang <zhangjialin11@huawei.com>
Cc:     j.neuschaefer@gmx.net, openbmc@lists.ozlabs.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Mar 17, 2022 at 7:49 AM Jialin Zhang <zhangjialin11@huawei.com> wrote:

> In case of error, the function devm_platform_ioremap_resource()
> returns ERR_PTR() and never returns NULL. The NULL test in the
> return value check should be replaced with IS_ERR().
>
> Fixes: a1d1e0e3d80a ("pinctrl: nuvoton: Add driver for WPCM450")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Jialin Zhang <zhangjialin11@huawei.com>

Patch applied!

Yours,
Linus Walleij
