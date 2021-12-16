Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD219476747
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 02:11:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbhLPBLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 20:11:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbhLPBLL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 20:11:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9587C061574;
        Wed, 15 Dec 2021 17:11:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6896561B8A;
        Thu, 16 Dec 2021 01:11:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1179C36AE0;
        Thu, 16 Dec 2021 01:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639617070;
        bh=O5wbkmfaan7+aEG5Q8QCevqGxxIFLUqB6wy+7SqPZyo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tSUn/K3jQ6YOx4Q/U9xEkCJZBB92pf46s1dLfpg3aGvZH4eesqFvHtK+69BIK8StE
         1brdtlsPGL+38Ls0PTvrvGdl3f+GHAmB2IZ8jTnaGZMmjqjqCaUcj0hn3RNAaKrPZA
         bAAvDtiTVq0Y/Zn2fgep5QkPeLSA9yiXTgEWZ+Bmnf4jap6bngiRomupPFyLDX3Tnb
         JGzToJFuRfcusA54mljXMSY9lEbOLRjG5u4rY8PRVlQbe0hxUwcVBUmaZQSnFA8S3j
         KIJ/nMOJHElAu5qdMUC86rp4DJ3k5PrrtD0Zr/xltumsXUmyKPjfXOiT+fEyJXl+Jq
         DwEnlDBysj1Fw==
Received: by mail-ed1-f50.google.com with SMTP id r11so80063967edd.9;
        Wed, 15 Dec 2021 17:11:10 -0800 (PST)
X-Gm-Message-State: AOAM531FPFM5sxVtfy5uKEQfwE+PN6To+PxfkHAXSGMOqbmuVzt4Fuhm
        juqvcuq4yxOlGOdcR5SuUXhPBYJIlqpXp5Phog==
X-Google-Smtp-Source: ABdhPJxO/PLxW71C9IoE+8QCxnCUUOHY6hiwFdc4jnLHohXaZR+NlWFK6RpEDFsAtd2JCTLMDG79wsDzsl8OeOqF9tk=
X-Received: by 2002:a17:907:9256:: with SMTP id kb22mr12916123ejb.423.1639617069136;
 Wed, 15 Dec 2021 17:11:09 -0800 (PST)
MIME-Version: 1.0
References: <20211215144500.64284-1-david@ixit.cz>
In-Reply-To: <20211215144500.64284-1-david@ixit.cz>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 15 Dec 2021 19:10:57 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJMMCBnukFZLJ8X14s1PwqT=VEwKjDVj8mm4h55pZpcuw@mail.gmail.com>
Message-ID: <CAL_JsqJMMCBnukFZLJ8X14s1PwqT=VEwKjDVj8mm4h55pZpcuw@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: timer: add #size-cells 2 for ARM
To:     David Heidelberg <david@ixit.cz>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Caleb Connolly <caleb@connolly.tech>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 8:45 AM David Heidelberg <david@ixit.cz> wrote:
>
> It's already widely used by dt-schemas, so I blindly assume it's correct.
>
> Fixes warnings as:
> arch/arm64/boot/dts/qcom/sdm845-oneplus-fajita.dt.yaml: timer@17c90000: #size-cells:0:0: 1 was expected
>         From schema: Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml

That's somewhat on purpose. There's no reason the timer needs >32-bits
of address or size. Sadly, QCom has ignored the warnings and just
copy-n-pasted the same thing over and over.

>
> Signed-off-by: David Heidelberg <david@ixit.cz>
> ---
>  .../devicetree/bindings/timer/arm,arch_timer_mmio.yaml          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml b/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
> index cd2176cad53a..c061bb90b8e7 100644
> --- a/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
> +++ b/Documentation/devicetree/bindings/timer/arm,arch_timer_mmio.yaml
> @@ -30,7 +30,7 @@ properties:
>      enum: [1, 2]
>
>    '#size-cells':
> -    const: 1
> +    enum: [1, 2]
>
>    ranges: true
>
> --
> 2.34.1
>
