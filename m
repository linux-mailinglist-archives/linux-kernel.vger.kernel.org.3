Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADFF47B048
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 16:30:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240143AbhLTPaj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 10:30:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239571AbhLTPaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 10:30:24 -0500
Received: from mail-vk1-xa35.google.com (mail-vk1-xa35.google.com [IPv6:2607:f8b0:4864:20::a35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA71C08ED8C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 07:24:49 -0800 (PST)
Received: by mail-vk1-xa35.google.com with SMTP id h67so5437614vkh.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 07:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iip86zq9P3Go1eFxd9vhsnpCnr9ENJGNCNN0oeKnYNo=;
        b=db54HA5CrsXkJZVeGvGc+cxUsT3tu0ElVuaQ4Zgp5LeNcZKgQ6Ce9PlSkNZseDqCgW
         /RGfI9R00jArJR5dKlDVyWQuysXnPj+SkRn0fXJyiKF2oE7fTxl9+jmIROnJYWVdhZdt
         Vg9J16NdLtu/VU5UcMg5zkwm5JbamgzjXLdck=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iip86zq9P3Go1eFxd9vhsnpCnr9ENJGNCNN0oeKnYNo=;
        b=SRuK8E+PoRyU5kMm920enpNBa0sEQiIj1xwfmBpsN45xt35f5djylnr1YnEXiQ8vLX
         MJydbh4SvjHyKZX8HSSnO0Ya8/zD5yPZeLwWdITXP3NFXh7PaXiF2NAL8/BDhcpeYZ/p
         X0u5cAbz4e41vR4NjBOuVPvsIiH+axQy16hZmEcdCdM7W49orUAkFrk1kcvfGW22MUMc
         eRt6jfvmalJEF6NRkmoKqCwqxBut0WZaGIm0EptFtBcLYQ2sy6pLiIyhkTbkv5ozjfwq
         g8NWVr2lqbY3oBNjLvgWuA2aONKu6S9RmDlv0wasPaHrKrA4+u4i0qp+/ZTSDMy5a4v0
         NVTg==
X-Gm-Message-State: AOAM533BRwZKSlKhsFzgcqBPYkJ0VluQ6j/EISeXcHdwpqwipA4TJYod
        /Es58jOctAG3ld5BiSD0Hf9aGUheXplqK+6gvj7pRQ==
X-Google-Smtp-Source: ABdhPJwygBszde+O5n1dvD0oyqEewzFG5UE5ec4Uz0gp/WlwAx+iMlxg/xbf4a8wPtowlHNy7yZLvvUqlyQB43bgfp8=
X-Received: by 2002:a1f:218e:: with SMTP id h136mr613155vkh.41.1640013888172;
 Mon, 20 Dec 2021 07:24:48 -0800 (PST)
MIME-Version: 1.0
References: <20211213094036.1787950-1-daniel@0x0f.com> <20211213094036.1787950-5-daniel@0x0f.com>
 <CAMRc=Md_2b-sBnPQL-E59byYSv+Z0+d3V8JrbPqpGSMjGS+tgA@mail.gmail.com>
 <CAFr9PXkkp8B5Vv0eu+2gPF2S4CNaxZDwjPg+UXRgvyUkAZBFpA@mail.gmail.com> <CAMRc=MepS1rh13kYGvvsMmAec93fdtSHiddxqO1W4Bg+uy-dNg@mail.gmail.com>
In-Reply-To: <CAMRc=MepS1rh13kYGvvsMmAec93fdtSHiddxqO1W4Bg+uy-dNg@mail.gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Tue, 21 Dec 2021 00:27:59 +0900
Message-ID: <CAFr9PXnYKLLp9=sJFobrOg0S2-Y2Lnm30dorm1_vzSqQqGMnpg@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] gpio: msc313: Add support for SSD201 and SSD202D
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartosz,

On Tue, 21 Dec 2021 at 00:07, Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> I took a closer look now and it got even worse. This is some major
> obfuscation with those names being defined as macros defining partial
> lists...

A bit of background because I guess we'll hit this again when I push
the next part of this (interrupt support):

There are lists of pin names and offsets that are put into arrays
because these chips have different mixes of the same sets of pins
with, mostly, the same register offsets for those pins. So it's easier
to create the composite array for a specific chip if the sets of pins
are defined as lists.
It's not possible to have a linear range of gpios based on register
offset and ignore the offsets that don't matter because someone
thought it would be nice to put some clock registers, boot control
registers etc in the unused registers in the gpio block. Hence the
offset arrays to map out the registers that are actually GPIOs.
This driver might need to be changed to use a syscon at some point...

If anyone has any ideas to make it nicer I'll do that change as the
first patch for the next series for this driver.

> Anyway, it was already there when you got there so I guess we can
> address it separately. Queued for v5.17.

Thank you!

Cheers,

Daniel
