Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A579577EB2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234137AbiGRJb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233195AbiGRJb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:31:58 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82ED41A06F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:31:56 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 6so19758373ybc.8
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BRnIJhnc7zj4KKZ0HO33twM8x3MOEz6vSsZhsRfqSSk=;
        b=dp7jk0t5JzhYGiuclMZTx5/iTT1EbE5sziHRoVQjGU1uce7s6WlN7ys3lN2ZUmvVoU
         00T9ByMLojt5bfXV+gvEhBkc/4LEb35NKzpxm6nfPH5dK/r19/UnWX1epUtl15M39nzn
         yAwkY92hbK+8w5SQ2ASAqZK8mO/xu2j3phlWv5TZLwh0ghyEFU7sWidbcovjulGsKP4X
         S4oqgUUFXpi2ovI0IP+vENJ0rrY/DqD2lSwW7draZB89BOUU65s84v9+kuu/UQihfinX
         gr70ExG7mxnY90kqjt/g/dfOmD/oy+wfUvwdya5c5lqyB0POqmNxO74/gWnd471f8GBW
         LOPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BRnIJhnc7zj4KKZ0HO33twM8x3MOEz6vSsZhsRfqSSk=;
        b=i8MFIfLJVcD0paMze/UyTmjqlmb1b9DmULz28g7ag/ZCMTdLVEzksw0vR3N5z6QAD4
         7tOP3Voc3IwjP7dr5fTblEeNfDXbCaAnZTC9BwAgtIrdYJPLhvUOplmm9gIMoUrfdvTu
         tx4bxx8QR3+wJI8vHabZbnYg5QsVA2VvKTlNpMfG+aoVozauASzKfNDq/uk5iK4/8S1O
         8iEC8LwCogAbWtmBLlV7bdYthprZ5jBSIX9MJvNPTjNU+ykfgYOhwHkvJVsift8s1VLQ
         jfVZIEnc5e04BbZbqqHvrFRqKntv13djXo4x9/iLXdNFYEUtS2DDz/8mEe6QbLjnD5fb
         X0wA==
X-Gm-Message-State: AJIora8tFIOLCO3ItvPVRRReXUPb8THFofVwbh2qoK8xaUmqN2057zX6
        cdNKrxE/dphvao53JCGceQRjqb2NMbhRVS5qkaWrjw==
X-Google-Smtp-Source: AGRyM1uXldGPZJoJ/+9/ccHAHQvnwo2ZRA1orwV4zWgWiSU2c7r1rIOtncJqVdW/J4ktbugvQYAzUoc2M5iAUPO7Ds0=
X-Received: by 2002:a05:6902:703:b0:66e:a7aa:2706 with SMTP id
 k3-20020a056902070300b0066ea7aa2706mr27412795ybt.410.1658136715817; Mon, 18
 Jul 2022 02:31:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220714020319.72952-1-warthog618@gmail.com> <20220714020319.72952-5-warthog618@gmail.com>
In-Reply-To: <20220714020319.72952-5-warthog618@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jul 2022 11:31:44 +0200
Message-ID: <CACRpkdZA+KCrRgdRQbK1mG76EtA9uw8f4rXBfjGfNZW1bCaV9g@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] gpiolib: cdev: simplify line event identification
To:     Kent Gibson <warthog618@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, dipenp@nvidia.com, andy.shevchenko@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 14, 2022 at 4:04 AM Kent Gibson <warthog618@gmail.com> wrote:

> Reorganise line event identification code to reduce code duplication,
> and replace if-else initializers with a helper function to improve
> readability.
>
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

Yep more readable.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
