Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723C554CA2C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 15:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349181AbiFONrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 09:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348939AbiFONri (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:47:38 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7B42AEA
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 06:47:37 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id v81so20699330ybe.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 06:47:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mONcnYz+UzOM2FqAirFVMXvA1LDZQM3Ao3LXZabuA5g=;
        b=tUFcYyDOZ+9Ur1jyUwdIVJM6cJhA6p54V/BQEEerpF+ZZaqqZ6SCG6EgnUNRjtxNg2
         2mOxeXzfh+xiUGsy0W2LCQJL6NpBDAR4h1tFB3Ijv15nn7XH7egNqAKByj7vp3cpogWs
         D9Y6JADpvRSRMrSYn4GpLcblQEJ+Bx6WfQ/4OG6kpjnM3LGH3HhAmPphWt4dtWMx+GBI
         woTaT91TPoWeY/fXWDx1IVy8fmBjvwBJwE5nwqVGD1lW95tEX5w2AHc5CO41WkrQLfF9
         7HP6ar7Nyf6ZbIYleWoi25Do2vf2sM0coAX4KI3vp3vMTBmFJ52CfyXGhfQDvqU44iB+
         ljSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mONcnYz+UzOM2FqAirFVMXvA1LDZQM3Ao3LXZabuA5g=;
        b=jQBmkx754ttCEu8JkxdO8wcES2ZoVPnRL3iHYPKVV0pzjX5a1i8PVIjMvjeGk+WPCO
         gQPGvJ68nlc7njy/LKww9offMIo9D7AJlnXScI/2VE8+SAhUYW+XsvYH/EizK3kk6mZ2
         CkFyGLF0XnusUyAxQ5rP2RT1kmukn9IeJfAV4zteYtHlvvnjNJGqtHbRYzZGXuPi2vNA
         6+ePNGITy6q0ei1JcRTzDBA1czQR7mvVgXjnIJnGyj83Ih298TS+6QA4mjltAYuGZRfm
         HHHniUuIN0bREfoGh8ZTp9Iy9eh3a6/8DWU+QiJv2H2DGBccxJ0wkPC6uW8QJLi6V1M0
         e52Q==
X-Gm-Message-State: AJIora/pt/iEQyK15kZvpPBe2CRl5ANL2JG/NdIrCNJuFIxXA8UhBG9i
        2EYjP2Kg9gG7YKZOV8Y+2m4PapomBMc+PCcBfDPJY53hF5A=
X-Google-Smtp-Source: AGRyM1sz2wY7SAoRnB4riGZrHr6i1t3/rlPxtNWhTNN73BCJV68vk6fpab2+473jCZDukYE8nVRuOI4qi4I4XeaWMdE=
X-Received: by 2002:a25:1256:0:b0:65d:6433:7993 with SMTP id
 83-20020a251256000000b0065d64337993mr10101263ybs.626.1655300856998; Wed, 15
 Jun 2022 06:47:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220605084854.29659-1-linmq006@gmail.com>
In-Reply-To: <20220605084854.29659-1-linmq006@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 15 Jun 2022 15:47:25 +0200
Message-ID: <CACRpkdbD+__7Tqn_5oTKoMVC2LEEJHr4j-Jhb6bFTX_Xz0EqHw@mail.gmail.com>
Subject: Re: [PATCH] ARM: versatile: Fix refcount leak in ap_init_of
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 5, 2022 at 10:49 AM Miaoqian Lin <linmq006@gmail.com> wrote:

> of_find_matching_node() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when not need anymore.
> Add missing of_node_put() to avoid refcount leak.
>
> Fixes: e67ae6be734d ("ARM: integrator: hook the AP into the SoC bus")
> Fixes: df36680f1a71 ("ARM: integrator: core module registers from compatible strings")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>

Patch applied!

Yours,
Linus Walleij
