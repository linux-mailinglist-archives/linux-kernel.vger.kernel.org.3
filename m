Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883524FE304
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354825AbiDLNsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351841AbiDLNsn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:48:43 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF8FE53E0E
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 06:46:25 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id m132so3900870ybm.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 06:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OgwLkfwtGf8/loBEqnh01cIKZgA1erKp1D0/s+cv76Q=;
        b=QTTouREbF51x1D/wPkA2j0JPBO8onK8rDVHUSf3JIZoaCuEAQNtYbnxTUCo2i3j3xc
         CPYuz25QADgIqCpbx+yj2z0UuClgDLIalj53ViDrStnIN2neUwEtv5wRLZ3K0GmA0659
         q41/3oqIrYFuaKFNz2BlFZ4WS299jRStkJqs3c01dSuIl0rY+iYBrqXtkVyCpX7ad3wu
         NEflxlzMQLTl0tUBe2b65GP3FPHUXtu8yRC7dAghkcP5Gqad2M4kplH0NGBtYY4BLF0/
         d3l0WItEJ2v8IaQa8oFnLcaYylSudwzGLP040s5+D9UYrUSS3BcEnmWS0UZqlziIqo62
         Zj5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OgwLkfwtGf8/loBEqnh01cIKZgA1erKp1D0/s+cv76Q=;
        b=PjTWbvHbzOKqPkzfI/KafUGeSDKJUGPmiAf5Cmx5sdYqf+FDwY4yR0+ScBn9anFHLe
         R/Leq13OqcoBI8MSjC+J+WVBLos7ffraEIE2qkD9gaAKm7ZfA3F9YR6OGu6RYFQwTOO6
         h30rPCUVsx6fJCvEt0ManbFBHHXCywI1KqABNMXeuHwL7qjyJ1l6xmIxapyLuCwupkL+
         iGTbqvAL/qyToExDJe+h826lbXzRRvvFAnzF3ksPrmUHcxQC+SQLacQQ08Ez1+FyToCY
         XTFR+hN7r7nQ1OcZzlH5iQGvWHZL9NE/ztYXRXgXqYRIHU3xMH2niero8meBZAHOI8UJ
         c6iw==
X-Gm-Message-State: AOAM530bmFQBrxBEmAZgoB4n1ZAmCr1P2ClzJCeTgHxXAkoGvp+INB6L
        nWaocdUVOBzWXcDtZ2gK4CFplUNs0vn/HF4qH+UW/A==
X-Google-Smtp-Source: ABdhPJxvBXLqUyuGpr5OcOlOD3eldCLItE3Y8ZEGJvE6Msor5ApYtcUhRNATWrsqKELftLsynbTXgcw/ZT8CT8LDXzk=
X-Received: by 2002:a25:3d02:0:b0:63c:a59b:8246 with SMTP id
 k2-20020a253d02000000b0063ca59b8246mr27665505yba.369.1649771185066; Tue, 12
 Apr 2022 06:46:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220412085305.2533030-1-lv.ruyi@zte.com.cn>
In-Reply-To: <20220412085305.2533030-1-lv.ruyi@zte.com.cn>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 12 Apr 2022 15:46:14 +0200
Message-ID: <CACRpkdYf7BRcB_PT4VUhrUZX2OTMzaKCtoJHuHdrWrKGjaz-Yg@mail.gmail.com>
Subject: Re: [PATCH] mfd: fix error check return value of platform_get_irq()
To:     cgel.zte@gmail.com
Cc:     lee.jones@linaro.org, gremlin@gremlin.it,
        gregkh@linuxfoundation.org, mad_soft@inbox.ru,
        linux-kernel@vger.kernel.org, Lv Ruyi <lv.ruyi@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
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

On Tue, Apr 12, 2022 at 10:53 AM <cgel.zte@gmail.com> wrote:

> From: Lv Ruyi <lv.ruyi@zte.com.cn>
>
> platform_get_irq() return negative value on failure, so null check of
> irq is incorrect. Fix it by comparing whether it is less than zero.
>
> Fixes: dcc21cc09e3c ("mfd: Add driver for Atmel Microcontroller on iPaq h3xxx")
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
