Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A586E57F808
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 03:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiGYBq6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 21:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbiGYBqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 21:46:49 -0400
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D09B2673
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 18:46:48 -0700 (PDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 26P1f2gP023146;
        Sun, 24 Jul 2022 20:41:02 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 26P1f1YV023145;
        Sun, 24 Jul 2022 20:41:01 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Sun, 24 Jul 2022 20:41:01 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc/purgatory: Omit use of bin2c
Message-ID: <20220725014100.GQ25951@gate.crashing.org>
References: <20220625224037.836581-1-masahiroy@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625224037.836581-1-masahiroy@kernel.org>
User-Agent: Mutt/1.4.2.3i
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 26, 2022 at 07:40:37AM +0900, Masahiro Yamada wrote:
> The .incbin assembler directive is much faster than bin2c + $(CC).

And perhaps more importantly it is simpler and less clumsy.

> --- /dev/null
> +++ b/arch/powerpc/purgatory/kexec-purgatory.S
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +	.section .rodata, "a"
> +
> +	.align	8
> +kexec_purgatory:
> +	.globl	kexec_purgatory
> +	.incbin	"arch/powerpc/purgatory/purgatory.ro"
> +.Lkexec_purgatroy_end:

Typo here (s/ro/or/)

> +
> +	.align	8
> +kexec_purgatory_size:
> +	.globl	kexec_purgatory_size
> +	.quad	.Lkexec_purgatroy_end - kexec_purgatory

And here again ofc.

Looks good to me otherwise, nice cleanup :-)

Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>


Segher
