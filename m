Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E95D47CB61
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 03:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238713AbhLVCew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 21:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhLVCeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 21:34:50 -0500
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1ECDC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 18:34:50 -0800 (PST)
Received: by mail-oi1-x233.google.com with SMTP id m6so1751830oim.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 18:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sYPQxNDiwc1p2YuAwucmO/dt08S/FnPHNQdar04dxQo=;
        b=NzYwld7OJDu775p2JXn6igTIenucDLGsCSIdXQWsw2GxoS6GSAC8XbohtdYpm9SxFc
         /4QCdAdd/k5LvUiRhKqVAfEBfIXfJrW+a+ds6jjBMbHRvFxc6sv6OLo0gIEYczEFY6hK
         u1DPP0ZjJ+mgWwUo5pUF/zkuqINhiYVEKwSM5mkxuQostGDdK6Fq6kaLeDV7J0ddqzog
         Du0OrHbNEdYuv6+TwJ58DPNmWlDKWnp6k1w461Qz/gzHKUAqiTCLDh/Rwv3SsCQFpVxf
         g5/USiBSMFEkha/QEaYYjVwtvdHcey2S2gWga6L+0GOIScsvZjVfeRPvrGAHNH+q9pnE
         BtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sYPQxNDiwc1p2YuAwucmO/dt08S/FnPHNQdar04dxQo=;
        b=ri3/Jc41AIDm1qDampQ8KyqrG8Xu7M6nqJT4ILWQO12JxnJWMSGMUuBQyiOsc7IjGs
         BtN4hbzQznEFcoQmxcorCeim32sl8XC0K2Hv+JfE3II3xbx+GuMbG7VOhnh/VjRoybd5
         m/jSj2/VYboZml5pJ8zofwW9qmdxeptsNDFks8489JdUIABHKCHrY5LJXB+HapTrBo6B
         OOgFm+VUlQ91Lixnj+4hc1IMltMwxrZ7mNs/W1Ab21XEUYZMSo5NWLLgKZNSAn100g00
         UyJxMv8cgH7kHMK1ytuByLUk6RvO4mtRnbzgszYj8iV0dbMExoQlCWIryN7CdcChlbFu
         aSag==
X-Gm-Message-State: AOAM531uor4+gMR0HJldzlSgP3wBKWmOP62tdUazQhvojNk28IhPVWPq
        SpxqmDaZh1z5B8/axUSHc3IN9P+b3woxOBqJT1liwA==
X-Google-Smtp-Source: ABdhPJzuu+8qR8C7MuThUoAx534VTus4YzW/1YoxFZhnsl8yazni3G1exxc2PXE0Ft8YQ/k6hTwpVr0PehWtqReo2uM=
X-Received: by 2002:a05:6808:60e:: with SMTP id y14mr703199oih.162.1640140490110;
 Tue, 21 Dec 2021 18:34:50 -0800 (PST)
MIME-Version: 1.0
References: <20211220211854.89452-1-nbd@nbd.name> <20211220211854.89452-14-nbd@nbd.name>
 <CAK8P3a3jVd5VmsRB81CuFxbjwVwVrisicsjK8VtN3saHsto-HQ@mail.gmail.com>
In-Reply-To: <CAK8P3a3jVd5VmsRB81CuFxbjwVwVrisicsjK8VtN3saHsto-HQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 22 Dec 2021 03:34:38 +0100
Message-ID: <CACRpkdZE0XPBrssuu7etVNQRz_ohPTX7VNFZF5e8-3VYeak96A@mail.gmail.com>
Subject: Re: [PATCH v8 13/14] gpio: Add support for Airoha EN7523 GPIO controller
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        John Crispin <john@phrozen.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 2:50 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Dec 20, 2021 at 10:18 PM Felix Fietkau <nbd@nbd.name> wrote:
> >
> > From: John Crispin <john@phrozen.org>
> >
> > Airoha's GPIO controller on their ARM EN7523 SoCs consists of two banks of 32
> > GPIOs. Each instance in DT is for a single bank.
> >
> > Signed-off-by: John Crispin <john@phrozen.org>
> > Signed-off-by: Felix Fietkau <nbd@nbd.name>
>
> This looks ok to me. If you want to merge the entire series through
> the SoC tree,
> it does need to be reviewed by the GPIO maintainers though. If you want to
> go through individual subsystem trees, I would suggest you post this patch
> and the DT binding separately from the rest.

I reviewed a v7 version I think, anyways:
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
