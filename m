Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D650C5472BD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 10:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbiFKIBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 04:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiFKIBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 04:01:41 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B718410F9;
        Sat, 11 Jun 2022 01:01:36 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id r3so2169976ybr.6;
        Sat, 11 Jun 2022 01:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J6tjynxzIVHRb16JzapzgQcaIfTmSbsb2/a0kmRZXfE=;
        b=gT95eMHWJT2+APQPM5Sb/zlwU3qLLfVhm8RS4IDEDOluySu+nfAwnG2wdCQUs2etxG
         a3qWJPqoGqxviVQvgou6M4KXoavBKCVsbpnlsSCN4VFzC9aBVXn3u8SSvfu6sYMEwVHc
         +RakSf4zwpF6JZqIiVgEtpFuZsgu0PjppeRnv9Z9bRkUh6nzTdldxO2aF/L/U40L01lw
         m1q9Yms8CVfw3qII7OfPkKUqyOu0y99VMc7Hrm7zL3jXSTpfkDkXB5V2HCGEOLhSn/a8
         RKdvTc7/GHhYqTmz6dHOyaa30NhHFrframySZURj255Jx28thKDTa9smn0AFHcl2Sn8u
         j8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J6tjynxzIVHRb16JzapzgQcaIfTmSbsb2/a0kmRZXfE=;
        b=YaLokb8Nmy3QFnXsjlLNm5EYSGdPfL66DozqWjxQUlX9/trHuVIiPKfUiAdwNtRvTk
         r5G1YinVLdCns8XoY14WqoI3vHvP5YThBqDAlyr2HFDs0SwfxTEK5v0PeqSRWfny53vb
         bqox4Y1WVuPPN39IOivFqCk8tr5TkwWMJXC97Wp1jfFA2M6L0PcOHxT5U1ZR2CiFVrtn
         PfNtyn/Tl6o5E7h7dCGDUHDnqFWJFiJTu5LpZTOxL85klV29Kv/d2TzX3XHSnj9yRsYl
         zDon2GTtsrb/jcp6cXNVlpijbXp4CMiVsh/b05a3WhQjvzHoShLnCrlMNJF4tCMrx7y2
         EGgQ==
X-Gm-Message-State: AOAM530YkOraUvVW1dlJn0SL7NhZ0XWKJEeHUxyEXSOed2weFoSN2a1O
        LhnQuzApC5hM4jthAK/PtUgkD5wO+X/rRaMo8rN+Vt85QDpdsQ==
X-Google-Smtp-Source: ABdhPJy5kYyqrX/lptw1Ap7SKHtGXneDN+CrtV2GFrbq/7UNmNiXQaPRJbhG2lL6+ozyK78i/oXBtkBJo6JQI9dWEhk=
X-Received: by 2002:a25:1c04:0:b0:660:1ffc:fb9 with SMTP id
 c4-20020a251c04000000b006601ffc0fb9mr47542871ybc.431.1654934495957; Sat, 11
 Jun 2022 01:01:35 -0700 (PDT)
MIME-Version: 1.0
References: <20220316200633.28974-1-prabhakar.mahadev-lad.rj@bp.renesas.com> <CAMSo37US03pKhPR=a1sJnWMF6L+WDvhWz469G=+0XY2WX-p=bg@mail.gmail.com>
In-Reply-To: <CAMSo37US03pKhPR=a1sJnWMF6L+WDvhWz469G=+0XY2WX-p=bg@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Sat, 11 Jun 2022 09:01:09 +0100
Message-ID: <CA+V-a8t2w14bJVCiiHQq8bwgetw5za1-t_OSfyr6Cwo4eZOt2Q@mail.gmail.com>
Subject: Re: [RFC PATCH] of/platform: Drop static setup of IRQ resource from
 DT core
To:     Yongqin Liu <yongqin.liu@linaro.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Biju Das <biju.das.jz@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yongqin,

On Sat, Jun 11, 2022 at 6:28 AM Yongqin Liu <yongqin.liu@linaro.org> wrote:
>
> Hi, Lad
>
> # sorry for the confusion if you have received it before with the
> non-plain-text mode
>
> In this change you said "all the DT drivers have switched to
> platform_get_irq()",
> could you please help share with me one example about the above change
> as reference?
The change is we just switch to using platform_get_irq() [0] for
fetching IRQ numbers.

> We have one hikey960 android build with some out of tree changes,
> which could not boot
> successfully with some errors on surfaceflinger(I am not sure it's a
> problem with the gpu or display),
> but could boot if I have this change reverted.
>
> I guess it needs some changes on the gpu/display dts or driver side to
> have it work
Just the changes to the driver is needed.

> with this change, not sure if you could give some suggestions on the fix.
>
> And here are two out of tree changes might be related listed here just
> for reference in case:
> https://android-review.linaro.org/c/kernel/common/+/21680
> https://android-review.linaro.org/c/kernel/common/+/21682
>

[0] https://lore.kernel.org/lkml/20211221213547.1553-1-prabhakar.mahadev-lad.rj@bp.renesas.com/

Cheers,
Prabhakar
