Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4834B577B00
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 08:31:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233499AbiGRGbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 02:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232841AbiGRGbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 02:31:21 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874CD2DCF;
        Sun, 17 Jul 2022 23:31:19 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LmXD32nd5z4xXF;
        Mon, 18 Jul 2022 16:31:15 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1658125878;
        bh=k/N2K3A9Z5dV/oTr9hSFt64T6vlj0t235fSbwzPjkEA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rhhdlO5yl1t520u8BwcWmo9I5ryGffVzXJ8RE1EukbGFkVthHUiVLAjQDW9mzbv/g
         OWnQlMsP8NiwLcTMDx/u2JG1Y845X4k4XCnsJBoiWa8UdmP575Nw0RWGtzsUbxe3Jo
         bjBoqD+2lq0gKxXSMd0ODRCH8GSL8M6V7sL4NgfhjmUAkga44TSCl7UfnulRjDEHIo
         FCaFHm+TySK1rfoT4o+dES2ZEbTrcYCPeHtbeg4lIr9pHGtIWMcl595MciqG3LLg/f
         VdNtecuoOERxk91eMns13YSoniRlSGOaiEJZ8DZNFdGSbyIrboLkLaefUXVezPcmCK
         4YiA9QdovohVg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        x86@kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Will Deacon <will@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Borislav Petkov <bp@suse.de>,
        Heiko Carstens <hca@linux.ibm.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Harald Freudenberger <freude@linux.ibm.com>
Subject: Re: [PATCH v2] random: handle archrandom in plural words
In-Reply-To: <20220717200356.75060-1-Jason@zx2c4.com>
References: <YtP1+MJ1tNdJA60l@zx2c4.com>
 <20220717200356.75060-1-Jason@zx2c4.com>
Date:   Mon, 18 Jul 2022 16:31:11 +1000
Message-ID: <87a697dj9s.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Jason A. Donenfeld" <Jason@zx2c4.com> writes:
> The archrandom interface was originally designed for x86, which supplies
> RDRAND/RDSEED for receiving random words into registers, resulting in
> one function to generate an int and another to generate a long. However,
> other architectures don't follow this.
>
> On arm64, the SMCCC TRNG interface can return between 1 and 3 words. On
> s390, the CPACF TRNG interface can return between 1 and 32 words for the
> same cost as for one word. On UML, the os_getrandom() interface can return
> arbitrary amounts.
>
> So change the api signature to take a "words" parameter designating the
> maximum number of words requested, and then return the number of words
> generated.

On powerpc a word is 32-bits and a doubleword is 64-bits (at least
according to the ISA). I think that's also true on other 64-bit
architectures.

You could avoid any confusion by defining the API in terms of "longs"
rather than "words".

But that's just a comment, see what others think.

>  arch/powerpc/include/asm/archrandom.h |  30 ++------
>  arch/powerpc/kvm/book3s_hv.c          |   2 +-

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
