Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161B153C81A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 12:08:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243367AbiFCKIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 06:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240691AbiFCKII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 06:08:08 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CC233356
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 03:08:08 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id a64so12844559ybg.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 03:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WnE5RrHzxxSGtOi1725wQK8h4gusso5fLN6rE06bqxM=;
        b=w09d3BZLSBmHDpNZ+2JvTLISTeomBfSC5ND07oDpVF2t4sEHyxHpavXMmVKH2HcW9n
         H8TUFhfd41sUXvLR004/atJhUk3VYxAONCM1IhzjATc2lEV8r42CbUrwIeiwy2f9Agul
         NDBeOhhnZ0mSSgsfPZkrh2gl5w7TgsDYids3RofYlTORiXwLktrXZD6Z/+mHC0R4TzNK
         dqeQiGolQmKq5KkTz0p19IXIm+IAtbAvPVbvIqBDiphIn0lcCMMHtz7o1xMSNqUk+vuL
         onWafzdo2IsNtpocLEKrFCWH0UmjWeOjPjXNnsl4m1OoYUwbDah3gjW6OOD0qAttwSol
         0wvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WnE5RrHzxxSGtOi1725wQK8h4gusso5fLN6rE06bqxM=;
        b=Y8WRp/NQXCrJh0g6zZ4ciZ8Z/G475aUdPlkpQPj10yWOnPP5VCbame8nHeMfJTE0qQ
         XB7SPc6893orNHuMsa04IDhnZDf0glwA/6/RPIiez49Y2zNvpzcjkaAf24tFXUnV34fJ
         qQNZUjURIfuOejeEbFKm2Ngoo/QFKX5SuEtTd7fIl1R7zAK5NEUVzcTZ/FmNR04xhlJI
         +nEFjPfX7Q7AEIKyJfBI8MvbLdAWn4j+jXDt8mXnOPNlTqRHZs5pTzfF4L7sX3zbA4MQ
         d9Md1+Gs7KeoLsN0Ow6NDATcIA9tV5rr1emv0Uv9p+OtpErPTxIlVwzHqS+OoDJcprn6
         svtg==
X-Gm-Message-State: AOAM531oXfFw4b9VRbMDqfBju9Sm0j2HMb8zBdVh1soRZ/dcJzmuG/TR
        ci5x8g01rrGpi4Z3LGo2ovprIFYM5B97PSE1ntaA2iCh4KE=
X-Google-Smtp-Source: ABdhPJwBoQKorP4+Mlj7LXa4ceDF9DAXciPrcs7xcMDgyB9Lt6QhGpFViv90iR2s6nLl9nLmxlTq7RKlxXnrxSmgzgQ=
X-Received: by 2002:a5b:302:0:b0:64b:a20a:fcd9 with SMTP id
 j2-20020a5b0302000000b0064ba20afcd9mr10073983ybp.492.1654250887315; Fri, 03
 Jun 2022 03:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220523153409.22949-1-linmq006@gmail.com>
In-Reply-To: <20220523153409.22949-1-linmq006@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 3 Jun 2022 12:07:55 +0200
Message-ID: <CACRpkdZPxGbTivpGFsjDWa7KtDVxihdjLSbQkAps2fxCtP9WVw@mail.gmail.com>
Subject: Re: [PATCH] bus: arm-integrator-lm: Fix refcount leak in integrator_ap_lm_probe
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Mon, May 23, 2022 at 5:34 PM Miaoqian Lin <linmq006@gmail.com> wrote:

> of_find_matching_node() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
>
> Fixes: ccea5e8a5918 ("bus: Add driver for Integrator/AP logic modules")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Patch applied!

Yours,
Linus Walleij
