Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 780BA507C11
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 23:46:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344364AbiDSVt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 17:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234579AbiDSVtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:49:22 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 027373FD96
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:46:39 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id b95so198407ybi.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nKYuve66AKuyzZwtLmTm5fhvpMnjjCQQv7on1/gZMDA=;
        b=oMmQWIW7ezel+AcddhNS6+Fief60wzC8kdJy+d2gMju5rVn9dqzW6YtVgbZvBtOG7y
         9h91A0P7dG3Ox7TljjfRZwOoaIv/p49QjkoWJOFsMQL9L3c77WwpZOSpYei9CR7nePAV
         DHi5Eo2JRrZdXChw9tnctcKtdJmlWxyoAgq+qiNWFrybJxXMv8bDcfItJigjlKH9rPrO
         cyD+zhbanq45r49EOrO2+/Kcq/isjfuLhCdJUSyEidvdeYX4txFDdU5VhZIIpAZ3jIPA
         JmVCby38SDggvh7BKyuuqNsINreWqTZJ751UQp5NDoatS+eIkZsfRaLHK8QKDGssMdlz
         hTVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nKYuve66AKuyzZwtLmTm5fhvpMnjjCQQv7on1/gZMDA=;
        b=P1uX41S9K3S1CjKGeKn0cdvFDTUPSlFZD0ytFEpX6jM/P0B4woZ0nI9qx/Ck2R7dlJ
         P8Q1exNhecRFiR+kbecvgES9NR7GXXbwjCyaWYSrmVM/SKvLzJ40rxaJZzdAoIyImEV8
         flhnrCPPD4sdoEvhDgBJ+H2c+iyhCiZhuVyY/joPlabkWQyQQ4gwtbJIiL6ySVXloiWu
         Fbm+uqkXvs+YMW40zJV77lLkD+OyO4vA7ZQUjZ7bUU3txEOjIkG9AsLgQEEBcMxe50Wo
         G+CwtInvyNTA5kWzVq+NDaSaDBoyY+zf0NfKFnX/XKVB4HOpyROFKVrr9hLTpe5pNBR2
         BOdg==
X-Gm-Message-State: AOAM533ZGLc4eBT7idznSBISSOXY0QMG5e+SZ44SOh9IONTz4vq/HKjr
        SFROwbe0Fdtut5sZt+lRMSemH9/JpM6SUDoKOTMKJQ==
X-Google-Smtp-Source: ABdhPJyGJe+uXKv+pKIJl5COC86/oFAQYoW5Il8D885KDlEUZ4hTXW0rikD/fIZqDdKKMk7GZyACCWrJrqFzKNqYwRs=
X-Received: by 2002:a25:4e82:0:b0:633:68d7:b864 with SMTP id
 c124-20020a254e82000000b0063368d7b864mr17788319ybb.514.1650404798233; Tue, 19
 Apr 2022 14:46:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220412115554.159435-1-andrei.lalaev@emlid.com>
In-Reply-To: <20220412115554.159435-1-andrei.lalaev@emlid.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 19 Apr 2022 23:46:26 +0200
Message-ID: <CACRpkdZkg2S1LHsyyv3U5wEfeUqH5G+Dw1aiFV0hNhxYYNMTSw@mail.gmail.com>
Subject: Re: gpiolib: of: gpio-reserved-ranges interpretation
To:     Andrei Lalaev <andrei.lalaev@emlid.com>
Cc:     angelogioacchino.delregno@somainline.org,
        bhupesh.sharma@linaro.org, andy.shevchenko@gmail.com,
        brgl@bgdev.pl, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, Apr 12, 2022 at 1:56 PM Andrei Lalaev <andrei.lalaev@emlid.com> wrote:

> Could you please help me realize how you interpreted the elements of
> "gpio-reserved-ranges"? Did you mean "start size" or "start end"?

It's related to ngpios.
See Documentation/devicetree/bindings/gpio/gpio.txt:
2) gpio-controller nodes

Yours,
Linus Walleij
