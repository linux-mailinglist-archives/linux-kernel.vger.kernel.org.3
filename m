Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0544BC3BD
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 01:52:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240578AbiBSAvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 19:51:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234663AbiBSAvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 19:51:17 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB79277917
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:50:59 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id bt13so22753492ybb.2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:50:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VXoRcxd/PxYohLQuDrXNBKC8j1xxruLF97guBacNWlE=;
        b=rid44RDP6i/IyKvN0mvHkgxD7LQCEuqQqYxPqJ8hXXRcILYW3Y5QxLsWfL+aSEDs3y
         Mf6gmzprzc000szkdKEn9ujHljqBKiuG+0wEeVxWlIltnrHynd/dVWSiURAAavhBl6hj
         X/HdMZHM8PSb+Oynwq4xOMKVSM5i2Yo4Up5auwNDRqkIWg6W7OJCN9iIBLxs8ph1RufY
         2bqsTBTTyqYcICUPWL+2sJ/rZJGR0js2wcqLqaM8jTDfbDHjleoT52HVol70H+SPmxSN
         Z1i1i42/fPmBaatQTvpvWllhxGQXTrPEoSMbrGeUoEGdtVP6Z9d8n8vEbxBcyXE2KMw7
         LaUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VXoRcxd/PxYohLQuDrXNBKC8j1xxruLF97guBacNWlE=;
        b=t1XuJbvdp9/MsQs0u4LFGQQsgYkcdxEeaE4PuYMGnppCDtT6ydRS6Krwmc8rEngo/J
         iLcxaXpC0H09kcDzPCUPtCPxSrlMB7/p1zfoeKgm8SDpzUmQA12u5CRvE79wGeWJ9Pjp
         nmr86uibV1b8Pp4JzVN7fWZ+l/pyhUt5JWr+ZxSIt1ds74Bna5uqNs7qaqxyGD/RjnSy
         BOjIWQh97D4Go0vNzcpA8zysAwr/k1nOGBCaKpnxmapg7j4zFqihzutUB+EH0pr9lxJk
         G9kK1mokcTof+VOdyOPHFSQ9pVqirRC884OZ6qc8y6j3UWRf71RsE8ffTb8HxYNXpywM
         bFeQ==
X-Gm-Message-State: AOAM530TfDvr/2mQ2fDTccpybctxrtvDpQZgzwoCEv126mFJucR1d2Hm
        Cc0g1/LdKY+UD5oEq/yxHlL0fFadLMe4EaLEkwAQEhXK58RiFQ==
X-Google-Smtp-Source: ABdhPJyOHCqTr6s4YxN8I7+fD33QonsyyzRr1EyAqSXbWIPDsxeaLLl37s1WIuUsMRmea4RikYkqTa1ApEabhza8HMM=
X-Received: by 2002:a25:a50a:0:b0:61d:720e:2748 with SMTP id
 h10-20020a25a50a000000b0061d720e2748mr9629946ybi.492.1645231858884; Fri, 18
 Feb 2022 16:50:58 -0800 (PST)
MIME-Version: 1.0
References: <20220211092345.1093332-1-maz@kernel.org>
In-Reply-To: <20220211092345.1093332-1-maz@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sat, 19 Feb 2022 01:50:47 +0100
Message-ID: <CACRpkdashCs2GAK5hy6imOnQjJAuTJiZn0Syf+T=2KwUG9reZw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: starfive: Use a static name for the GPIO irq_chip
To:     Marc Zyngier <maz@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        kernel-team@android.com, Emil Renner Berthing <kernel@esmil.dk>,
        Bartosz Golaszewski <brgl@bgdev.pl>
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

On Fri, Feb 11, 2022 at 10:24 AM Marc Zyngier <maz@kernel.org> wrote:

> Drop the device name used for the GPIO irq_chip and replace it
> with something static. The information is still available from
> debugfs and carried as part of the irqdomain.
>
> Suggested-by: Emil Renner Berthing <kernel@esmil.dk>
> Signed-off-by: Marc Zyngier <maz@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>

Applied for fixes!

Yours,
Linus Walleij
