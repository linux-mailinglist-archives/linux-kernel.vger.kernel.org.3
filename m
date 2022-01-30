Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51A914A32E9
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 01:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353579AbiA3Any (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 19:43:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242635AbiA3Anw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 19:43:52 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BC0C061741
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 16:43:52 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id i62so29563448ybg.5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 16:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i0heOt0MsnfbggLnL41BYSYo+JW4b1v4laT3az03jyE=;
        b=NTUUoAwKu7RD+Vz0K3+O7Xn0Q+qJK8lQEW5wXkAOwblKwjVUeOWeoXjSuUyHQOm2WU
         QLR05VjCiSdHhC2r3/lfYWWwxot6fMes++uNzubU/E+IosIe0VZaK2yrLpeqYGxCFj6t
         qFNdYlyHv5gFrXHes9twon2u56e+90H5YMqGrOXE4MzzkTFwZ23E4ZtBJ+fUlSMO9n7k
         ivfk/0fKeZCdf8ARYxPfnEY7xjBDObjf0TTLwfcttTXLcf8GT7iatHOW1toEDwZPeH0b
         PpMtLUQWp+S/baBvVEqBvBBbuXp1QHTqyMILfqFgRxiyqoDR7Hb8a6Bla3MPFzt424Ko
         2Hhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i0heOt0MsnfbggLnL41BYSYo+JW4b1v4laT3az03jyE=;
        b=LR9anlR4F0g+LXzjrTATdrPq8k/JH7bkrOblNgzz00fJ+kfGFjCa8sXa0UMwZY6NgX
         9SRxlXviA5QXOy1qo2SXY4uzYDY1hjFVDJlJ+IX7SIGU9gXv4GgdvTBLKzZjxpz9fr65
         DG0gSxrpR0vMR2kpEGLKpQsgmqLvfhslF+8eF9Q3YyhETbShbxjrvbbmetwR9eBfpri/
         3qBdywKwWtX5Ke5IRp4mPijuSPAgNN7sigGLviaQs7NphlrPnUq+Glj+IzydB6geifuR
         ooAzCgZEI3bDEsoDUqMM28SWV5//eIVlap2um49GMlCzeeOWn9goEmVo0SGdwUgvhOYO
         oGGw==
X-Gm-Message-State: AOAM533cM+tgGogptjIqRlDX9W+KlbqvFA9ThRyWSUXx0X4fB9XG+s1p
        FbJDBxyJ7BP52IW4ZbCpi5pnmuEgVP7vw5CCSJcfow==
X-Google-Smtp-Source: ABdhPJydy6ZkeacI3rT8jHNSi9nSVdfyeZ6fzuQWvUGVLQ53U3TfGwQChT4mT+0l3VMAP7QbbCFsXkBR31fK2hp451E=
X-Received: by 2002:a25:8c3:: with SMTP id 186mr21032329ybi.587.1643503431458;
 Sat, 29 Jan 2022 16:43:51 -0800 (PST)
MIME-Version: 1.0
References: <20220120150024.646714-1-paul.kocialkowski@bootlin.com> <20220120150024.646714-4-paul.kocialkowski@bootlin.com>
In-Reply-To: <20220120150024.646714-4-paul.kocialkowski@bootlin.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 30 Jan 2022 01:43:40 +0100
Message-ID: <CACRpkdZnw-Tf2eQwO+LZRW4UacR09qWRWct00=XLb4pfa-N3=g@mail.gmail.com>
Subject: Re: [PATCH v10 3/6] gpio: logicvc: Support compatible with major
 version only
To:     Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 4:00 PM Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:

> Support the newly-introduced common compatible for version 3.
>
> Signed-off-by: Paul Kocialkowski <paul.kocialkowski@bootlin.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Are there dependencies between the GPIO patches and the rest?
Doesn't look like that.
Can Bartosz just merge the GPIO stuff to the GPIO tree?

Yours,
Linus Walleij
