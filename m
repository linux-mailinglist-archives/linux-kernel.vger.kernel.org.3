Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8D665827A2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbiG0NZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232646AbiG0NZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:25:24 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD526EE26
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:25:23 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id c12so14000507ede.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kqFNbE+aXXivn44JOwD+CLf88ASFJmrA3QkI4yv/BwY=;
        b=WZyfnrrhksvpWBLouKDJn/piW1ld+hisGQMb+xy+M/pOxZtD7PWWggX9zC42TTJP54
         PyyYX2/7NnOKDxAunaUK4YwkRbAbB5Euo7eHuzONYuVAR/vYbMIUu5xKiWOyPNmMzmqS
         U3dCYoS3Ps9LVJJSFl6izA265QF5NiaAjPwrU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kqFNbE+aXXivn44JOwD+CLf88ASFJmrA3QkI4yv/BwY=;
        b=yu7tWz+ObcyZzvdyej5giC/A08tRpKJh9JY7TgACuSDmQoUV9T9pA5xEC3bi62QOel
         egPyAspkstJRchhDK3MV5JkwPAruoZ/PpjR2hrlhi8fWmmldkCXG2n1NnQT4IKK0uZcQ
         FoqeeXwNmUlLhNSqVZYCYdE+TKNvt/SCykTN8ATRUWdY5NCZ98ibehiLQdSYaSFefO9V
         6JjPJT5Trq4GUH+L4+Q850+OSC04+uwcrHg6bl6wgndmVGGiwr8OaHdPorEwGDDBjKp7
         ANa28LTHOf+FxYiF7kb+cqbMS0ofM7QggFVCZBlDISTsT+/XMltv0iz101cpM84d3kGb
         0qKQ==
X-Gm-Message-State: AJIora+f1a6en+YSKZxrNBXGCRaz3ItugeqDqShtztQdEH2nzpa+rpPU
        w/NfJkm3ay6fTdatguq1A2LurJvx7eFammbibbeHXg==
X-Google-Smtp-Source: AGRyM1s8WP3OBt1gsHtGiiinaLIF69C5+rkDudiyLGY00MyjFeImI3wdU676TNjPQ6E3FfBwfdfHBK318Wl5DfqWItU=
X-Received: by 2002:a05:6402:e96:b0:43a:f21f:42a0 with SMTP id
 h22-20020a0564020e9600b0043af21f42a0mr23708627eda.382.1658928322262; Wed, 27
 Jul 2022 06:25:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220712152318.2649819-1-williamsukatube@163.com>
In-Reply-To: <20220712152318.2649819-1-williamsukatube@163.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 27 Jul 2022 15:25:11 +0200
Message-ID: <CAJfpeguvvbPQnd15Ait+-EZbq9QojdL7Mp+-w7KTVwy7k3-wkA@mail.gmail.com>
Subject: Re: [PATCH -next] ovl: clean up comparsions to NULL
To:     williamsukatube@163.com
Cc:     overlayfs <linux-unionfs@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        William Dean <williamsukatube@gmail.com>,
        Hacash Robot <hacashRobot@santino.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022 at 17:24, <williamsukatube@163.com> wrote:
>
> From: William Dean <williamsukatube@gmail.com>
>
> Clean up comparsions to NULL, simplify as follows:
> if (x == NULL) -> if (!x)

Again, this has too little worth.  NACK.

Thanks,
Miklos
