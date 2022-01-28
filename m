Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC1AE49FFCD
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 18:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240726AbiA1R5J convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 28 Jan 2022 12:57:09 -0500
Received: from mail-40136.proton.ch ([185.70.40.136]:27591 "EHLO
        mail-40136.proton.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbiA1R5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 12:57:08 -0500
Date:   Fri, 28 Jan 2022 17:57:04 +0000
Authentication-Results: mail-4018.proton.ch; dkim=none
To:     Geert Uytterhoeven <geert@linux-m68k.org>
From:   Conor Dooley <mail@conchuod.ie>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        Rob Herring <robh@kernel.org>
Reply-To: Conor Dooley <mail@conchuod.ie>
Subject: Re: [PATCH v4 1/2] dt-bindings: interrupt-controller: sifive, plic: Fix number of interrupts
Message-ID: <D-55Hk0vrg2vkivFR3NXwnyI8hno6J5TA6gRHi3GbGVflgVPOGQNM2auwcIoHVt3fuzkg-pe7MAARda8PG8-KPoEnarmha7U6TI-pA7V6uI=@conchuod.ie>
In-Reply-To: <f73a0aead89e1426b146c4c64f797aa035868bf0.1643360419.git.geert@linux-m68k.org>
References: <cover.1643360419.git.geert@linux-m68k.org> <f73a0aead89e1426b146c4c64f797aa035868bf0.1643360419.git.geert@linux-m68k.org>
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
> maximum of 15872 interrupts.
>
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Rob Herring <robh@kernel.org>
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

As with the clint - clears errors on the icicle dt, so fwiw:
Acked-by: Conor Dooley <conor.dooley@microchip.com>
