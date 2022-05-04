Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F15151B190
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 00:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378943AbiEDWFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 18:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378946AbiEDWFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 18:05:02 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFBFC50B11
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 15:01:25 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id y76so4739642ybe.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 15:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pX2ngpFNk2Ghr51om2PA0Pj/G14x4bghqSpSrOsoJNU=;
        b=kq8t/UuBXfETDAhqBKubijfq3sWXLthyRNbY8B12K8TrNDl9l8r9J/fXC4rZAyGAyU
         3E90ggARwwH/f8OQGxhEy1+h/42GluJ26rEhlzHpwPtwqSkfGiDJufxCaHtEWUlKWE5t
         qnFPKKDJX/edCbv2/NINGOSkgZLnB7oT27aKFUwhhzhdh1HaFFtA/Xj6cdIlWrzCbf1v
         6Fq1MR+n625ediEt5ZIxuh1DW0WIptd1d3zKcAHaX1dSMAOu2W4UCtBFEhhB2b+IAsak
         YOb2Jgsynw7vz90ZzY5xmpQ/el4SItPpAUMDmWzemifHfHZNKrV9Xd3WAJi3dNon4ac1
         KxdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pX2ngpFNk2Ghr51om2PA0Pj/G14x4bghqSpSrOsoJNU=;
        b=EKGNaOG2wKok5+wCf3TsuR14wBhc4dKgTcA+k0udDni35D/e/xNBxMWjeV4Bh4XPui
         61K0qP8J5u78NCejAzHcMCHtHzZ2poNDSG7zF5AN+8qcHv05GRtkqeoxvm+3nfHl+QyR
         Lc2k8xz0Ux7+t70bsjwkVyuw2GnM8bG5xZLeHyEVCWUzBWA0F3CrLuqxaAEIB6LmEn4A
         WkxInjHe+Xb6WLct8CBGCXiU0+InE/6Ah8R9E8TEnczmIsKttfynEMuzwbLblDffWQUW
         BmeRGnSbQoC7ExmFhAL8HGyf5ynDfnzlBNsOvOplca4wTEaj4nFc+ziYGvV0ub8RKT7w
         3ZlA==
X-Gm-Message-State: AOAM530pUwXZsGsXquXCg/liViJWC/lSvQe4L62CeqpR8BYlRcpMlXOi
        9+RLDowCw0d85ilLI1Yop1u7yhwyjAgBvH5vMxSQMg==
X-Google-Smtp-Source: ABdhPJxRdvTwncc0f0hY6oBiPl4XnV4u57gzrV6gKZx8HsF6PExk2uGe9TNXvMLUiy7JU8oQaOjuQH0QFBGqWj3vPFM=
X-Received: by 2002:a25:e684:0:b0:645:d429:78e9 with SMTP id
 d126-20020a25e684000000b00645d42978e9mr19961978ybh.369.1651701685134; Wed, 04
 May 2022 15:01:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220502092335.30670-1-marcan@marcan.st>
In-Reply-To: <20220502092335.30670-1-marcan@marcan.st>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 5 May 2022 00:01:14 +0200
Message-ID: <CACRpkdbc35bdsVLCfNB4-BHSmCjSW3BaX8EPbRSw545fY5HhxQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: apple: Make it work as a module
To:     Hector Martin <marcan@marcan.st>
Cc:     Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Mon, May 2, 2022 at 11:23 AM Hector Martin <marcan@marcan.st> wrote:

> We need MODULE_DEVICE_TABLE for module autoloading to work.
>
> Signed-off-by: Hector Martin <marcan@marcan.st>

Patch applied.

Yours,
Linus Walleij
