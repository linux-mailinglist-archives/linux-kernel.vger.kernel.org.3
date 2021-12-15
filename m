Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D27AF47584F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242253AbhLOMAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 07:00:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234188AbhLOMAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:00:36 -0500
Received: from mail-ua1-x934.google.com (mail-ua1-x934.google.com [IPv6:2607:f8b0:4864:20::934])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B43CEC061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 04:00:36 -0800 (PST)
Received: by mail-ua1-x934.google.com with SMTP id w23so40472830uao.5
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 04:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VOAaOrdWd5lD+mK78KAHRm3OPwW02mUiPealsVCa/TE=;
        b=nXffj4HlEJDZRxH9ClBp3ESjXsc80vQ6Bx4/t2/jtVy/sYzWZa3L3AzHtvC2ETkDAt
         F1WFJakkk49x6SHa8eFdvm0OThZv18X0r6ocfvBAsQW6J2/80+m29HbOIBHcHnMN8O3z
         Id8sO7VF5PvgCTP9vOGCK63cMWpcmICFdJGIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VOAaOrdWd5lD+mK78KAHRm3OPwW02mUiPealsVCa/TE=;
        b=Zfd8/mSQeco+gdlrJwaFAo9t9wtUSmTW4p7dPYGkMr2xTHsiWZksSfB3oIoR6eC+kz
         yNxh0hhFjRN+LTJ3dmuyCY6KiBCgURQr0JrZ873cqVlUwdNVIGYctu3p9m/5OAdIaJhe
         0xfSjginFecaX532HlhRhJMFXO/Hjdlqpm9/b6lBUqKigLyphvBIfs1wTJk/zLwJvF90
         6Q7ZSnEEtaCRlHJUWjTL2UWEYXVK0jgQoTemU0p0v9R0O/zx+Sw3r6zTkvEw3dJz8QtL
         B3erw9ENY3mY0lnF0WfaLjOsEhQ6cM0OpMwMTy4ALr2q2Yd9Acs35W/8oIdF0JsTeeX2
         b/Ng==
X-Gm-Message-State: AOAM530aBBHBtx4hgDhX9xAVs+36+QTgTMJFwJPea8+g2Rd81BCE7zqR
        d69GLDB2F+SU7PDyc10/svJsYdvLYeop99SdEpx+0w==
X-Google-Smtp-Source: ABdhPJzfnv9OWeG/6yWiNozReELreuK/r3yjp7+RBk370dK3SPwGVwGSqoE4lKW0XwFEoF8Kv706pzRsgb3p8eswoQM=
X-Received: by 2002:ab0:6c44:: with SMTP id q4mr9732674uas.127.1639569635807;
 Wed, 15 Dec 2021 04:00:35 -0800 (PST)
MIME-Version: 1.0
References: <20211212181906.94062-1-romain.perier@gmail.com> <20211212181906.94062-3-romain.perier@gmail.com>
In-Reply-To: <20211212181906.94062-3-romain.perier@gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Wed, 15 Dec 2021 21:00:25 +0900
Message-ID: <CAFr9PXki8LVdjQC_4eDSuB1dmEmv2K00bWOy92cOXENEoEyeqw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] clocksource: msc313e: Add support for
 ssd20xd-based platforms
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        DTML <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Romain,

On Mon, 13 Dec 2021 at 03:19, Romain Perier <romain.perier@gmail.com> wrote:
>
> SSD20X family SoCs have an oscillator running at ~432Mhz for timer1 and
> timer2, while timer0 is running at 12Mhz.

I don't think this is technically true. I think the boot rom sets the
divider for timer0 so that it runs at ~12MHz.
I think the current change to only configure timer1 and timer2 is ok
but maybe the commit message should say that timer0 is configured to
be backwards compatible at boot.

Cheers,

Daniel
