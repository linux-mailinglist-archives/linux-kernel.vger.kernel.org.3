Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B9B5703C4
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 15:04:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiGKNEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 09:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiGKNE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 09:04:28 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ADFC2E689
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:04:27 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-31cf1adbf92so48088917b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 06:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9JKRBi7riS8dgDanXOkqRAyM5H4qVguce4FeaGzoT7s=;
        b=okcsyTE0zJ0p2APWdLeNBmYNX8aFctszqIOEnjmyHinbyXjv4TrkM3plisAYlh6vAh
         FEuT5tA3ikYdJQXUYj3t2QSj4xJU7UPICd6IRv+HfPChYvOlfLGjhHbFTawXcJRhVDQ6
         aH3VVl4EfFAq1yQb31uooHzZTnwLY3OncgwszldSzE0Rh9P0EQPsZ4LBBV0nS+sCQMbd
         XTDSGUJoNHsKXm6JVZv+uQzQfmYElbijb67isYpyrPV/TlTujXNMUwExfXeyKIeyz50Y
         7rpr9p8FKpouuoDhBAX7fsk/lzsM/5TA3AuPW8JTK9IaklWJrcUisOo86/iv4W7iJ/Sf
         soDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9JKRBi7riS8dgDanXOkqRAyM5H4qVguce4FeaGzoT7s=;
        b=X84vPmkfBt0HW7SqRgp5smZo5u83naGsa/CuTIiVx+thlUBS74sB2wrPTKNee/z/R4
         UMQdF3nvLkPTTUTLg04xcJxpzNMGQTL4ffyFfxozv0ke3fqqY5vPntHj+vgdtXwBxZ7w
         k7xIBCuwE0CvNRv23Jea2rpRDVICuem1/ieofevwX/wqMsaDzswvQkYp7+TdW6ntuElm
         h5/ijuaZdL/+t2IJ5NbARnNaXlhaKIXDcEyXIF62r+rTw93cItAY38o5lRZWZiwVnQ5+
         3mDIjtj3MJS7MAi0Kfybt0FV+adDdLmtYelFLPYvNlNBOJ2FHvXijTttZSaWx1aLzaSd
         IQeA==
X-Gm-Message-State: AJIora8YEBLR+Vuccr17qQ9FP756ve6rue7enLyWwzKtKwNKO1Xv4CcT
        mx/gXm2O6yng+6RpJz/bWOLeNEYYERIBLUEDjNDf4w==
X-Google-Smtp-Source: AGRyM1soi5CEesjCriJC5s0V8He+RqLwxBsOQ7/WmYldHS3JUxOjl1iLjob8jJN+e13tAYA/yAS2ilrm2Sp1NITCnSU=
X-Received: by 2002:a81:a8d:0:b0:31c:cb2f:c805 with SMTP id
 135-20020a810a8d000000b0031ccb2fc805mr20481784ywk.118.1657544666696; Mon, 11
 Jul 2022 06:04:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220710154822.2610801-1-williamsukatube@163.com>
In-Reply-To: <20220710154822.2610801-1-williamsukatube@163.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Jul 2022 15:04:15 +0200
Message-ID: <CACRpkdY-USEfscMOb6bPONW6xcSqhe3HU-93vJC800xJYCTkGA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: Add check for kcalloc
To:     williamsukatube@163.com
Cc:     dvorkin@tibbo.com, wellslutw@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        William Dean <williamsukatube@gmail.com>,
        Hacash Robot <hacashRobot@santino.com>
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

On Sun, Jul 10, 2022 at 5:48 PM <williamsukatube@163.com> wrote:

> From: William Dean <williamsukatube@gmail.com>
>
> As the potential failure of the kcalloc(),
> it should be better to check it in order to
> avoid the dereference of the NULL pointer.
>
> Fixes: aa74c44be19c8 ("pinctrl: Add driver for Sunplus SP7021")
> Reported-by: Hacash Robot <hacashRobot@santino.com>
> Signed-off-by: William Dean <williamsukatube@gmail.com>

Patch applied, tweaked the subject a bit,

Yours,
Linus Walleij
