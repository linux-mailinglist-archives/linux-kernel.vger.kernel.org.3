Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 369E357AE3F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 05:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238257AbiGTDDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 23:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239226AbiGTDD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 23:03:27 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCFF1BEAB;
        Tue, 19 Jul 2022 20:03:25 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LngWD5dzkz4x7X;
        Wed, 20 Jul 2022 13:03:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1658286203;
        bh=07a5cjF0e9SE4ghrWPN59Y1xcS8Op+XIj+zd97Y/sD4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VBUywPF7BJl/iHXB6z0aZcik5dkO6ISMryTwHHBOfdsHO/F7DusRlENuecPpb0ocU
         h0aptq1KpohsSf3IbkKyI8f/yuYSR1zSllHmHraP+a2MZhaIo0+7L6e50EE+01F76G
         phcNILJZ/UkLOwibUep6WX+/H3wRxrGPwmLv8gGFpgLZV+3zJCq9ePTtD4Z+2l0JX6
         qTSYLwY1fVjmsG5ebVAceqlzLnx4mIDtEmy+qrMvPYMF6f58UUhgep38kjZhOXRySi
         5zet7uxpBCKVR+InMq55C9PgjnZUsRY+/vkd5H1wFqmQ6FjMy34sVQ45g1LvS6H0Ty
         Ff7032tCwAY/Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Gabriel Paubert <paubert@iram.es>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        x86@kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Harald Freudenberger <freude@linux.ibm.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Borislav Petkov <bp@suse.de>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2] random: handle archrandom in plural words
In-Reply-To: <YtUB3Iola9R0OwN6@lt-gp.iram.es>
References: <YtP1+MJ1tNdJA60l@zx2c4.com>
 <20220717200356.75060-1-Jason@zx2c4.com>
 <87a697dj9s.fsf@mpe.ellerman.id.au> <YtUB3Iola9R0OwN6@lt-gp.iram.es>
Date:   Wed, 20 Jul 2022 13:03:19 +1000
Message-ID: <87y1wocwp4.fsf@mpe.ellerman.id.au>
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

Gabriel Paubert <paubert@iram.es> writes:
> On Mon, Jul 18, 2022 at 04:31:11PM +1000, Michael Ellerman wrote:
>> "Jason A. Donenfeld" <Jason@zx2c4.com> writes:
>> > The archrandom interface was originally designed for x86, which supplies
>> > RDRAND/RDSEED for receiving random words into registers, resulting in
>> > one function to generate an int and another to generate a long. However,
>> > other architectures don't follow this.
>> >
>> > On arm64, the SMCCC TRNG interface can return between 1 and 3 words. On
>> > s390, the CPACF TRNG interface can return between 1 and 32 words for the
>> > same cost as for one word. On UML, the os_getrandom() interface can return
>> > arbitrary amounts.
>> >
>> > So change the api signature to take a "words" parameter designating the
>> > maximum number of words requested, and then return the number of words
>> > generated.
>> 
>> On powerpc a word is 32-bits and a doubleword is 64-bits (at least
>> according to the ISA). I think that's also true on other 64-bit
>> architectures.
>
> IIRC, this is (or was) not the case on Alpha, where word was defined as
> 16 bits. All assembly mnemonics had w for 16 bits, l for 32 bits, and q
> for 64 bits.

Yeah I should have said on *some* other 64-bit arches.

Seems to be a common feature/hack on arches that have evolved over time,
or been inspired by earlier arches.

The latest Power ISA has octwords :)

cheers
