Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 818754D3FAC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 04:28:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239247AbiCJD3l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 22:29:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233019AbiCJD3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 22:29:39 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E442D128DDC;
        Wed,  9 Mar 2022 19:28:39 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-2db2add4516so44837667b3.1;
        Wed, 09 Mar 2022 19:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yuLZvyDmx07dtOHeNAZ5njHvHkrJ39K8IFBS0/yye1E=;
        b=UFLHQCMrRLGiVgSdtagsUX/9qqpRsvJi0igxULCIZ+ghvxMvNr50A1LbM2zl3uwrFX
         PA8aeNwqrBF3Duw9WGnBUhcRK23Mb/FHC3NIl/4jvcAOg9BGruit91LboxhD4seAgxVS
         rDSG3Jq9XjXwparBajn/c8K5oGH4Uqy6AKJl4BNvtTOT/do2J8fqF9H1IZEfyj9BPH7s
         lsIIPoQej8DIgQi73KteOd+cmH8YCMjtlbtwEc69/7BuvXoLsGR2i3lpGwpE59pt6Ome
         DRCAiFKiXf2rZQ8yqj02xnQiSInRQ+fo3id6Kt2Vfnzi7fRXJZFx2aS8G1XauBhk1j6c
         qKyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yuLZvyDmx07dtOHeNAZ5njHvHkrJ39K8IFBS0/yye1E=;
        b=uB5sJmBHVAjFIeHshWcoXquRQPoffDI7uXFhRNmI0oHmi8uM5AoKZtFy6ycVxNMfjE
         RRecM9xLzBNxjW2coJxEb1gnwp+CsCyr4kfyZcSurFn9yUUB5fHNHzTFQgS4TVAob2Xb
         ojlYrblCJsoR0Iug4ajEkmd1hUU8AwvwsXbnBVY6V8P8M2wEjUW7L3W2IX9PyJF6VyHX
         VyICeQ2ntSe/zGUoYh0i1uOCi1UnQT+3TPY1CShgwPWzAfa3WGKOXlCeZsruqObWQdgk
         AzpNSgBZlMLH4GQY/sYCDY3Kt/pZCUYwe4nzMunai6wNd/E8cu2iaKZA5cJTWahNb/2d
         hcWw==
X-Gm-Message-State: AOAM5331jzkob8MlSWenZ1mpDuiXvi1q+ZgJ+K5OYt+bpefG8jWaztIv
        spetCS2n7U48CwwFN4BWxOQk3/uaxselLg5t6wPPA3GJ
X-Google-Smtp-Source: ABdhPJykYbEAU8fLWqryirXpJ9k4NV/swmv5oFMBc517LU8PMgHdQHfo3VMASn2Ko5Yi2UqLjmRl1lidK+U/eTu3ztw=
X-Received: by 2002:a81:cf06:0:b0:2db:f404:d7b with SMTP id
 u6-20020a81cf06000000b002dbf4040d7bmr2501883ywi.334.1646882919000; Wed, 09
 Mar 2022 19:28:39 -0800 (PST)
MIME-Version: 1.0
References: <20220309162301.61679-1-alexandre.belloni@bootlin.com> <20220309162301.61679-21-alexandre.belloni@bootlin.com>
In-Reply-To: <20220309162301.61679-21-alexandre.belloni@bootlin.com>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Thu, 10 Mar 2022 08:58:28 +0530
Message-ID: <CAOh2x=mP2AFGFd27P8YeBNr-X4AJi84B2FJ3Rfr=E0SC_EheAg@mail.gmail.com>
Subject: Re: [PATCH 21/29] rtc: spear: fix spear_rtc_read_time
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>, linux-rtc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 9, 2022 at 10:26 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> The reference manual doesn't specify whether the registers are latched and
> they probably aren't, ensure the read time and date are consistent.
>
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
>  drivers/rtc/rtc-spear.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
