Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7F55A114A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 15:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242115AbiHYNAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 09:00:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242102AbiHYNAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 09:00:42 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EC7872FFB
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:00:40 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id sd33so18030257ejc.8
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 06:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=PPQs0KNyvrvT+32AxeaLLndft2dq+PVgDYWSHwX6NY8=;
        b=AEzCszmaVV8hvqEEVOgP/1t/X0AwnZDO9HEuAF0OrMdzOr8g2irCgHsPLgXC06Yg8A
         U3GN7p5zkWDQIHzqWOR12onSvncp4fKgaEoSxHqTkSzo9lHjhut2ncyAV86vVNF2aYJu
         IC53A8osfDkE+pkv91/IxVqZLgKpZAPEhCIibf99/xS99HCZEc26Btl6nOIJnJI/2akB
         Xo0Xzcd87Amg+9Jz81P0wU7OgkJObgcoYgjdC7qRd5p7Li+3+uePvFGXqJNOQF6kFGx6
         YgkcWpOOTwk+1KtuSRlBlDkO8L97gccYEbYYl9uZYUMgMUmViiuvmv0VhKy8VH4xfWyW
         SFMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=PPQs0KNyvrvT+32AxeaLLndft2dq+PVgDYWSHwX6NY8=;
        b=4R0zCL1BtmgDJ1pSJudLkNGNI7dHHkUUz6ajLnpSFT4c2Gw8p21sYwohLVIRxE5jIi
         7gP6tlu0JwuPLyS2JWFeAb/96uJasdl3R40HvhsTROqM8/qHZukCrLI/hGMVqyIOOO33
         8CeJ1xOsH4suYZuktkHiZP5YjpzaKqk+KaMA57bsVLg/syELIcfm9nsZyM6H4B5OW675
         fZBfMZVej+IedwZO5UL7InZe3iqyASO4FsFvYlz+3DWtXQ3AjRYtH45QecOyxBsa9Tmf
         cVk7QgLzZCULfvm9wdNplaBTi6SvIoWA6dBrl76teCDH69QT3SQhx5j8Q96V3SlClMkG
         WFgQ==
X-Gm-Message-State: ACgBeo1q3Tqyo7HphJ1/lFIOHr2/LNRPvWNYTGib40mG1BHnJ8iE52a/
        1aH7SPALvOQRC3jf954d/1bxQ3Yku6kpCV2iCfSg8A==
X-Google-Smtp-Source: AA6agR4rG0d+Ixit0Yj0toSr1sLaIAFkyaPVvZInrDnnCe5x0uuHeODCbZ4Ez66M48or7dSwPrVJrKtBG3ErJwGG0qc=
X-Received: by 2002:a17:907:6293:b0:73d:b27b:e594 with SMTP id
 nd19-20020a170907629300b0073db27be594mr2497566ejc.526.1661432438542; Thu, 25
 Aug 2022 06:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220727040022.139387-1-lihuafei1@huawei.com> <13e8c9ba-c5ec-a231-5493-3255e1ef9db8@huawei.com>
In-Reply-To: <13e8c9ba-c5ec-a231-5493-3255e1ef9db8@huawei.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Aug 2022 15:00:27 +0200
Message-ID: <CACRpkda=csAw1wZj_Uwpb1B32BBHAin8=rQVXQ0c6TwnTWJSXA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] ARM: Convert to ARCH_STACKWALK
To:     Li Huafei <lihuafei1@huawei.com>
Cc:     linux@armlinux.org.uk, mark.rutland@arm.com, peterz@infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, arnd@arndb.de, rostedt@goodmis.org,
        nick.hawkins@hpe.com, john@phrozen.org, mhiramat@kernel.org,
        ast@kernel.org, linyujun809@huawei.com, ndesaulniers@google.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, rmk+kernel@armlinux.org.uk,
        ardb@kernel.org, will@kernel.org, broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 18, 2022 at 11:16 AM Li Huafei <lihuafei1@huawei.com> wrote:

> Hi Russell=EF=BC=8C
>
> Do you have any more comments on this patch set? Can you add this patch
> set to your patch tracker? Thanks!

I would rebase the patch on v6.0-rc1 and resend then you can add it
to Russell's patch tracker yourself, it's not very hard to use, there is
good documentation for how to use it:
https://www.arm.linux.org.uk/developer/patches/

Yours,
Linus Walleij
