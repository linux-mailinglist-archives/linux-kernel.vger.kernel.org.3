Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBE749D6A5
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 01:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233798AbiA0AUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 19:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiA0AUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 19:20:44 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4ADC06161C;
        Wed, 26 Jan 2022 16:20:43 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id c192so764418wma.4;
        Wed, 26 Jan 2022 16:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition:in-reply-to;
        bh=P88xng2vA48vNxmFFaeQpDY6ed2eDOGSFZKxYpQjdco=;
        b=NLT00e6ACbbs3DPH4pPR3f8114ETqTQMC3awdXuieJyR4QFTeDslqokdq2QUPtXX1d
         QDjQs+cYsXjbZNMZjTFCo21GaNy3d1HM3GD710Lp6pkZYe8tuWTPqx5Gx9rREOp5W/mX
         666fUUv/CM4cTeTIYGiEPXih9Rb9spEZa5fVEY/bykJ0yQDSOmqZvmoO1xmqyrG40LS7
         OYSfl05X4M4o/3rXDEo2fFtRsfwBKs7bWPB8XQQ3Q6o7lbCKk2Yn3hCv6LDSjL0QsARI
         EhAchyP1Dcs6oUv3ZBMG2dW1q3Rrt1A6CxlXMNrGsjILMlaXUz1tqvsmZhBeERwKPczi
         9K+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mime-version:content-disposition:in-reply-to;
        bh=P88xng2vA48vNxmFFaeQpDY6ed2eDOGSFZKxYpQjdco=;
        b=FpfBH0+0cOcSJXpA3pOdvYcaGHf7vIiB9fVeShcw6EMtXajFagV6PRabxhciAK1iPy
         Rj5wZ56i0jhdOIvvxox+rOGTyFJ/4TKJvR8FeVQ6Efj8j409Snvy4XCOjDTwEhCsImiz
         7tQO3jrhN42d97XgaHxLIY35cbcdTjiRZMetUpb3mP1RPX7uDTiBBwqXSyUGmd6EbkKe
         ZvqsvZdCaZDOiVY+ep94To59voBWYsLUCLcx73V8zH9MyjAANRXFzGdviKA9J3Cq3jlz
         lSAejcIQ+HgTNU1cUbjnGI59k28Ov6dSBSUaOxtudAlA83v55R1jzwrCf+9/Wv3PDqai
         DcNg==
X-Gm-Message-State: AOAM530k42522KD4YaXKLVNi2Xl0Det3BOYF1fVjjexF7qYRL3QqGWI/
        TnnexuiihTONHcBrg4pCAlo=
X-Google-Smtp-Source: ABdhPJyK+xnb952IkbTOhlGEHm1/rv7TmZT5aAzIzS1jYJAgDzH86IaBYMK1cWoOy1407ww5EVNSZw==
X-Received: by 2002:a1c:2b06:: with SMTP id r6mr9533030wmr.4.1643242842544;
        Wed, 26 Jan 2022 16:20:42 -0800 (PST)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
        by smtp.gmail.com with ESMTPSA id o14sm785615wry.104.2022.01.26.16.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 16:20:42 -0800 (PST)
Date:   Thu, 27 Jan 2022 01:20:39 +0100
From:   Petr Vorel <petr.vorel@gmail.com>
To:     Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Oleksij Rempel <linux@rempel-privat.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Palmer <daniel@0x0f.com>,
        Max Merchel <Max.Merchel@tq-group.com>,
        Hao Fang <fanghao11@huawei.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jean THOMAS <virgule@jeanthomas.me>
Subject: Re: [PATCH 6/8] dt-bindings: vendor-prefixes: add LG Electronics
Message-ID: <YfHlV13Zi4KV+bNT@pevik>
Reply-To: Petr Vorel <petr.vorel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f415ca1-6527-5667-01f2-9676f565d670@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

> > Hi Krzysztof,

> > On Montag, 13. September 2021 10:49:43 CEST Krzysztof Kozlowski wrote:
> >> On 12/09/2021 01:27, Luca Weiss wrote:
> >>> LG Electronics is a part of the LG Corporation and produces, amongst
> >>> other things, consumer electronics such as phones and smartwatches.

> >> Hi,

> >> Thanks for the patches.

> >> I think "lge" it's the same prefix as "lg". There is no sense in having
> >> multiple vendor prefixes just because company splits inside business
> >> units or subsidiaries. The same as with other conglomerates, e.g.
> >> Samsung - if we wanted to be specific, there will be 4-5 Samsung
> >> vendors... Not mentioning that company organisation is not always
> >> disclosed and can change.


> > I was mostly following qcom-msm8974-lge-nexus5-hammerhead as it's the other LG
> > device tree I am aware of so I've picked lge instead of lg. Also worth noting
> > that Google uses "LGE" in the Android device tree[1] or in the model name in
> > the LG G Watch R kernel sources ("LGE APQ 8026v2 LENOK rev-1.0")

> [1] Does not point to kernel tree. Downstream user could be a good
> argument to switch to lge, but then I would expect correcting other "lg"
> devices which are in fact made by LGE.


> > I don't have a strong opinion either way so I'm fine with either.

> > If we decide to go with "lg" do we want to change the Nexus 5 devicetree
> > (hammerhead) also, that one has the lge name in at least compatible and
> > filename (I don't know how much of a breaking change that would be considered
> > as).

> We would have to add a new one and mark the old compatible as deprecated.

Have we sorted this lg- vs. lge- ?

There are both:
arch/arm/boot/dts/qcom-msm8974-lge-nexus5-hammerhead.dts
vs
arch/arm/boot/dts/qcom-apq8026-lg-lenok.dts

+ patch flying for msm8992-lg-bullhead-rev-101.dtb
original:
https://lore.kernel.org/linux-arm-msm/20211201231832.188634-1-virgule@jeanthomas.me/
rebased by me:
https://lore.kernel.org/linux-arm-msm/20220113233358.17972-2-petr.vorel@gmail.com/

Kind regards,
Petr

> >> We already have lg for several components, also made by LG Electronics.
> >> What about these?

> >> There is only one device with "lge", added back in 2016 without adding
> >> vendor prefix. I would propose to fix that one, instead of keeping
> >> duplicated "lg".

> >> Best regards,
> >> Krzysztof

> > Regards
> > Luca

> > [1] https://android.googlesource.com/device/lge/hammerhead/





> Best regards,
> Krzysztof
