Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2025057E1D1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 15:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234891AbiGVNBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 09:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbiGVNA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 09:00:58 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04B29AF86C
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 06:00:57 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id x91so5781891ede.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 06:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=baynEo7vnNm1XYDH0i7dj9nJYt96fbnXE4sQDZAxVtQ=;
        b=gJmyYtLDyaREVdwZyxpqlcnisGWEXOiTuJ5YWkc7D+Bqb7zBSwwOB4ZFh5n6ZQrA8x
         pCRiAUwXrJxF0oom8kDQB/sbiXCq8JmA0B8JMecIAt/9ePFqGHfHdbcHtinnuZe6BWWl
         n9U2yye/18vIVKalHy2/36N0IeK0feOpme1jpM59ifIE93PYuB1PJMLGbSvmA/lnjePE
         b6tN/esY+/eqTXuopjoHwHEluojCitpttzh/689dpuq+lIDOju9DOO38ExMTI+6uKWE1
         ltJ0nV/hJZMgya+2XmaT8xvUTbKDZs0d9NckUgwkjcEkZfJZrP3bW6bry5SVCBmyudSX
         w8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=baynEo7vnNm1XYDH0i7dj9nJYt96fbnXE4sQDZAxVtQ=;
        b=HIWy73FgCu/HiLDOIBHSQagpJ5Lk4KIvbzsOI8lzy4RIqg0zlgncPgRqdYu9RXYBR4
         JCCBO0NZtX7OCpqrj3THdU/SMLy6fe6/IF0NAgiTSqiFZlUiOygEVwhgzl4eJ6i24EI5
         zb7M4/jVnZwPVTfYAB0v3eFBTGU0gAKvxDm60rNNqPqa0ld6yFLZCxpzcNSBMOd+8BHC
         mUZSUzvEtIp2cYJBUvKEDmVEWiDWDQLNJPTBG2RHix0Munmm9md+SHpj4pwYtnqt87aN
         y8j8ym1p3iYQ0pYEfmhi5aCOcztIw8ALHvQ6WjozyFsU3jchZjynmBlAjOaxHDknw9m7
         8/2w==
X-Gm-Message-State: AJIora9jJBMt1rqFboyBesQaYvf3LOulfadfr5Z8GaFHkvE4Y9dAvAyc
        sEzaMarwFSLdD/nVXYWmQcXuU+YwabXcgTOr2sbeag==
X-Google-Smtp-Source: AGRyM1sfEMb9SVoxsN9BQXeDZdyBMMWHOKQGS3GlRPZlLOUUMleYFQOEwWCeuFpspnuhgXLSul1uaahyl7/RtrX3UHc=
X-Received: by 2002:a05:6402:26c2:b0:43b:ce7b:648b with SMTP id
 x2-20020a05640226c200b0043bce7b648bmr555241edd.133.1658494855592; Fri, 22 Jul
 2022 06:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220720111432.18321-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20220720111432.18321-1-lukas.bulwahn@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 22 Jul 2022 15:00:44 +0200
Message-ID: <CACRpkdYyHTMYMKwFW5JSNXi+4SiP7=NPQ_uwZHRzPUK9j3EfHA@mail.gmail.com>
Subject: Re: [PATCH] arm: davinci: remove CPU type detection for DaVinci
 DM644x and DM646x
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Sekhar Nori <nsekhar@ti.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Wed, Jul 20, 2022 at 1:14 PM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Commit 7dd33764486d ("ARM: davinci: Delete DM644x board files") and commit
> b4aed01de486 ("ARM: davinci: Delete DM646x board files") removes the
> support for DaVinci DM644x and DM646x boards.
>
> Hence, remove the CPU type detection for those boards as well.
>
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Please put this into the SoC patch process.

Yours,
Linus Walleij
