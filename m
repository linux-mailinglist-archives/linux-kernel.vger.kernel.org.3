Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D42F49FFCB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238734AbiA1Rza convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 28 Jan 2022 12:55:30 -0500
Received: from mail-0301.mail-europe.com ([188.165.51.139]:50104 "EHLO
        mail-0301.mail-europe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbiA1Rz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:55:29 -0500
Date:   Fri, 28 Jan 2022 17:55:24 +0000
Authentication-Results: mail-4317.proton.ch; dkim=none
To:     Geert Uytterhoeven <geert@linux-m68k.org>
From:   Conor Dooley <mail@conchuod.ie>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup.patel@wdc.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Rob Herring <robh@kernel.org>
Reply-To: Conor Dooley <mail@conchuod.ie>
Subject: Re: [PATCH v4 1/2] dt-bindings: timer: sifive, clint: Fix number of interrupts
Message-ID: <57Vhxv8ckv7WroKy1FfDqfQsDLTkgIaUSc-aiOIftZeBHjDkXLAqDfcsCMHgEYQvPebzA9iZExDD2HfRw-Vmm03d-h-MlwJqH8T8JDSVWrc=@conchuod.ie>
In-Reply-To: <e6a4c5b20d2acb52125d7d6e6c7e3694d7cb182c.1643360652.git.geert@linux-m68k.org>
References: <cover.1643360652.git.geert@linux-m68k.org> <e6a4c5b20d2acb52125d7d6e6c7e3694d7cb182c.1643360652.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.0 required=10.0 tests=ALL_TRUSTED,
        T_SCC_BODY_TEXT_LINE shortcircuit=no autolearn=disabled version=3.4.4
X-Spam-Checker-Version: SpamAssassin 3.4.4 (2020-01-24) on
        mailout.protonmail.ch
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> The number of interrupts lacks an upper bound, thus assuming one,
> causing properly grouped "interrupts-extended" properties to be flagged
> as an error by "make dtbs_check".
>
> Fix this by adding the missing "maxItems", using the architectural
> maximum of 4095 interrupts.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> v4:
>   - Use architectural maximum instead of practical maximum of 10,
>
> v3:
>   - Add Acked-by,
>
> v2:
>   - Split in two patches,
>   - Improve patch description and document limit rationale.
> ---
>  Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> index 8d5f4687add9e81e..fe4b73c3f269fc0f 100644
> --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> @@ -44,6 +44,7 @@ properties:
>
>    interrupts-extended:
>      minItems: 1
> +    maxItems: 4095
>
>  additionalProperties: false
>
> --
> 2.25.1

Clears errors on the icicle dt, so fwiw: Acked-by: Conor Dooley <conor.dooley@microchip.com>
