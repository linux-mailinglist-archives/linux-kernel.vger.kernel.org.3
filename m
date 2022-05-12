Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5F80524AE2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 12:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352893AbiELK4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 06:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352978AbiELK4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 06:56:32 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67DDE7326
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:56:29 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y21so5780278edo.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 03:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1qOQZQPTy4U7t+rkSLUr0kIO0VTPczZpQ9pnwXXnwbA=;
        b=WD7JQy6fN3kvH6v4mOydQ947Tw31kQgVUnaXgy31ouUajVtLLLRAW1tgkdaVG1wsak
         D2lRTCB/1lP7bJrcocRs4RbF1VsL3M68OHMwq1mDNsIoQdp3EqUAK8F2nKKhE4DTCrzp
         EmJpK9fI2F/0QHtUYcgGpcAMt9PbzdjpLG6bldHlUC9+qJoytLJr05g0AwEGgTvS1L+M
         Y+B9cUTITp90Zi8awi4Dppw5hqncJs5ox1bzohJ/DAllxsX0TgSQkfXdzNJP7ULIkSZc
         kua/FlRjij/TYEwClw3iq7oaN9yrVNHHegzNfMn31Rv9qE5GMO95VrNrpznV5kWBKNHg
         lP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1qOQZQPTy4U7t+rkSLUr0kIO0VTPczZpQ9pnwXXnwbA=;
        b=xxTMaSsPiOyS8pULcHQPpYWopt8D/Z9MBTFvJ+oY7mQMHAOYtAHm9/0bwVwPdze1KZ
         27mFw1Zoe8v0wrX1W6D9ACD50u2lJU+hdXInm8s/bR83HcoN4uBc6mX4t5egmb8cmx+Z
         GgNJkOCpqPX9ByX9saiCLP1Ooc9u/TDI1XN3F7+OqkjaqZKzvgOUt4ZyPTej4C5nuAOU
         RbGnkY011SijQJlqXW+xZRNTEOlBYmLBuyKfsMOq/xkGBrc8PED6Nc7XYTwyVgwc81xH
         n3gzPYh+uaasUnZq1rMgOTRwJa7HoUzF+JU382h7HJHUq0QNkef1LwS6/c8+FDYnfW2A
         bYew==
X-Gm-Message-State: AOAM5315VieSVCWG5CZnAT1jwJBFJD0oRueMfy2WF04Al8WIuOjNFACb
        QqUp/38tbr4Zsf6toDAJIJpHbqkQSjrtPV5P0oc=
X-Google-Smtp-Source: ABdhPJzZ/2UZwO8JVwO/F5piUiIPlJxVyh3uQd8vtnwVDQmeJ+cTHuVyEFiamoilO0JkH6nwoeYkA45H8vNAuB88uc4=
X-Received: by 2002:a50:ed0e:0:b0:425:e476:f4ed with SMTP id
 j14-20020a50ed0e000000b00425e476f4edmr34023372eds.32.1652352988427; Thu, 12
 May 2022 03:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220512021611.47921-1-linmq006@gmail.com>
In-Reply-To: <20220512021611.47921-1-linmq006@gmail.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 12 May 2022 12:56:17 +0200
Message-ID: <CAFBinCCJYjunsRjKmgxwBkQu+aL-42TPdSrCi1g=0jofXeYe+A@mail.gmail.com>
Subject: Re: [PATCH] ARM: meson: Fix refcount leak in meson_smp_prepare_cpus
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Carlo Caione <carlo@endlessm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 4:16 AM Miaoqian Lin <linmq006@gmail.com> wrote:
>
> of_find_compatible_node() returns a node pointer with refcount
> incremented, we should use of_node_put() on it when done.
> Add missing of_node_put() to avoid refcount leak.
>
> Fixes: d850f3e5d296 ("ARM: meson: Add SMP bringup code for Meson8 and Meson8b")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Thank you for spotting and fixing this issue!
