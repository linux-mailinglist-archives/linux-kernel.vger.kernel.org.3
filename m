Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C3C49F5F0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:06:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238005AbiA1JGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:06:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237969AbiA1JGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:06:23 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE31C06173B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 01:06:23 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id k18so9519093wrg.11
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 01:06:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xKmKkemO7LZgNH3z0FyPV0a1F2pctQzcwkbzVf+pn9M=;
        b=dMjEiUSnrp58PvxtH8/oq3uk2znAwoXs16+ia+Di+iOLZWWrdxj1szC1T8NAzX/gps
         Pt8T8++gA+3eGQxk785oSrLqWGJdXzyYzgYvqx7BtIPIusrsdYU/OUmX4buHQzaVOsyd
         I2GdFE2nwLxRGW3VhTokvS5WpQ5E7/19VRiuzYkUSMWAj+P7z9tzgIyx5K9z4GxiB7Ip
         BeUR2/u3SCO/rN+Cbs01UtQjK2gDMsPOzWti1O1KnyY3AcKYkaNIKWSI46p0Nia80PVX
         UDoBkKTzZuI/qK/EkT3CGKvbsreqwuhwv6Qqf7zeVI2HFmxZTIvexSh1B1aC5vXlGOTu
         5C9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xKmKkemO7LZgNH3z0FyPV0a1F2pctQzcwkbzVf+pn9M=;
        b=5TmTA79c0OwmPIdrWTLCNCnvh5roC1QJSngD3qLcFruJCKMfgv52gJRalm8lTHxLmQ
         s6DE2TPjwIq0Fo8PuSkfqh1yK59lEu1dRqe7I5bmWxNmyenCIiWkcGUVEZJlVKlXnDRG
         Bfg6Mt2+0LxfV+goV2mZ0YVbkDNsoIC1WQdcB3FdxxF2N6l1AmXFyq13Yfw5HZ7dU0UR
         NeIEudqHqk+0gr98R+lCa+ZyQY/h0Z5GCFABAYeU+119SmBaVLX/TACxoNRKgZwxQcrG
         l3B9b9tpNLnrMUUS5l4WRpJK+S8URLCvZzQQXmK8G3nOpTZ8VZgxj5ExQ4/Fi34wR8nQ
         iefg==
X-Gm-Message-State: AOAM533RqhwgyrX+S7uNwiYqQjmQWxgJ8y/bFLQ5FqraoqoR6hFP9vPw
        Dsu+W8lQhiOa1iqszNscD4Pm7mqfm9YmbDfyttjpMQ==
X-Google-Smtp-Source: ABdhPJyi2j2no5AvzLexpxvXn1W3Bl71f/NV5cWi8/uC4z/VF2s2n5jyqjBFmXLiJFR1/nEBiZPeQCSoIZM2KrosgAc=
X-Received: by 2002:a5d:6b48:: with SMTP id x8mr6411882wrw.86.1643360781694;
 Fri, 28 Jan 2022 01:06:21 -0800 (PST)
MIME-Version: 1.0
References: <cover.1643360419.git.geert@linux-m68k.org> <f73a0aead89e1426b146c4c64f797aa035868bf0.1643360419.git.geert@linux-m68k.org>
In-Reply-To: <f73a0aead89e1426b146c4c64f797aa035868bf0.1643360419.git.geert@linux-m68k.org>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 28 Jan 2022 14:36:10 +0530
Message-ID: <CAAhSdy2r-F8cJR8feV9c5-RHATe3Wv7ioYU2RwgNbwUMBJhHJA@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: interrupt-controller: sifive, plic:
 Fix number of interrupts
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 2:34 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> The number of interrupts lacks an upper bound, thus assuming one,
> causing properly grouped "interrupts-extended" properties to be flagged
> as an error by "make dtbs_check".
>
> Fix this by adding the missing "maxItems", using the architectural
> maximum of 15872 interrupts.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Rob Herring <robh@kernel.org>

Looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

> ---
> v4:
>   - Use architectural maximum instead of practical maximum of 9,
>
> v3:
>   - Add Acked-by,
>
> v2:
>   - Split in two patches,
>   - Improve patch description and document limit rationale.
> ---
>  .../bindings/interrupt-controller/sifive,plic-1.0.0.yaml         | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> index 28b6b17fe4b26778..57c06126c99502fa 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> +++ b/Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.yaml
> @@ -62,6 +62,7 @@ properties:
>
>    interrupts-extended:
>      minItems: 1
> +    maxItems: 15872
>      description:
>        Specifies which contexts are connected to the PLIC, with "-1" specifying
>        that a context is not present. Each node pointed to should be a
> --
> 2.25.1
>
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
