Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2F0A4C0031
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 18:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234526AbiBVRbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 12:31:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbiBVRbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 12:31:08 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51D71170D44
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 09:30:43 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id cm8so29083213edb.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 09:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5GmqNRhB5+LoDYStD2USYSV7vOo4JH447IACLApzM7c=;
        b=Sbly6JGaY7NCcVthClEqBSWBwk0y42HITnHQxM5X99XUqJLtNhRhPxGXmzjx5dI8Lu
         eA8AsrHoaav4XUoLSVHKpGp5HSKssiC3fDEeuMY9w3550lCtPJjVQgvxgt1KmcGPMrVZ
         BEryE/mhgv8nHjqnPERZKL+GPMLInsJy37/ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5GmqNRhB5+LoDYStD2USYSV7vOo4JH447IACLApzM7c=;
        b=ys0LYJpdYV1JTXMGnIXTdOGcbC7/eQXJO+4KlpMcGsbbZoE0kKyCnhrd0c2m67n9Ds
         xditLu3+koh8nd0BijQluOl8xsxOIyUqvmyuguIlsjHw3OfmVyg5Z2Ca3wDAWrrj0q5i
         +c+t6b7WB85o/zrn5v03e0Sq9ppnRzn6eNtZ45BBip+e/FIC4JwcCOC/LBi13MOidmQe
         pS9Zxjvj2U0RezBZ6L3PAQk4OixYDywQFj04O/zVG0Pgtf7Cs6zgKBSmHYvvopCX1Dc0
         qYKw4OaCdoSuyM9q0Uh1Lxq/ZwKtSk+RvzLmzlX7DafXyWCFjUw2i/m71uXTpZmuWg2S
         zbFw==
X-Gm-Message-State: AOAM531kTpWdZYWmNBX3RY1yMomOq9jXLrJbNwH6QUGcVwMVNRdR4fgD
        TeK1eFvs+amYKF1DYz6XEgaVs8rbUrjPBQ==
X-Google-Smtp-Source: ABdhPJxyaZ/5rhHNd/t4i6FkcdsfdKjLZw63f4/fCvRpwEm42EO59IF849QXTw+/0AWjnGbQzY1v9w==
X-Received: by 2002:a05:6402:268c:b0:411:e086:b7d1 with SMTP id w12-20020a056402268c00b00411e086b7d1mr27123868edd.111.1645551041480;
        Tue, 22 Feb 2022 09:30:41 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id 18sm6380232ejj.1.2022.02.22.09.30.40
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 09:30:40 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id d3so19133991wrf.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 09:30:40 -0800 (PST)
X-Received: by 2002:a5d:64ea:0:b0:1ea:8148:6b97 with SMTP id
 g10-20020a5d64ea000000b001ea81486b97mr4061063wri.679.1645551040170; Tue, 22
 Feb 2022 09:30:40 -0800 (PST)
MIME-Version: 1.0
References: <20220221061954.4822-1-tangmeng@uniontech.com>
In-Reply-To: <20220221061954.4822-1-tangmeng@uniontech.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 22 Feb 2022 09:30:27 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UN0fCc4TnUj_+sHX5ap9JkBBVR+pTzV8vssZDxfao9Hw@mail.gmail.com>
Message-ID: <CAD=FV=UN0fCc4TnUj_+sHX5ap9JkBBVR+pTzV8vssZDxfao9Hw@mail.gmail.com>
Subject: Re: [PATCH] kernel/debug: remove unnecessary CONFIG options
To:     tangmeng <tangmeng@uniontech.com>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Feb 20, 2022 at 10:20 PM tangmeng <tangmeng@uniontech.com> wrote:
>
> In kernel/Makefile has:
> obj-$(CONFIG_KGDB) += debug/
>
> so kernel/debug/Makefile don't need this 'obj-$(CONFIG_KGDB) +=',
> delete it from kernel/debug/Makefile.
>
> Signed-off-by: tangmeng <tangmeng@uniontech.com>
> ---
>  kernel/debug/Makefile | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Seems fine to me, with the nit that your Signed-off-by is supposed to
have your "real name", not your username. See
`Documentation/process/submitting-patches.rst`. Some maintainers will
let this slide, but if you're going to submit a patch fixing a nitty
issue then it seems fair to get called out on nits. ;-)

-Doug
