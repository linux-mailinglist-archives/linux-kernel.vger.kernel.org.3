Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96E4568BF0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231451AbiGFO4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbiGFOz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:55:58 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A05CAD58;
        Wed,  6 Jul 2022 07:55:57 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 266Et4Za026327
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 6 Jul 2022 10:55:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1657119313; bh=ifFZJvbfIGVslUHWRDtftSqDp9BgS1ySpd5as638KpQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=jicRkedUge0cSrNp9dsPHkw4QFRERSGTRFWvzKMGECE7ezizOgSv9HxyR9V4F8S7F
         B3Z4cvkvhwTV+vUCLQyyRapiOOXIrh6qq6H06KmAU7CGQ4aXhLrDnNGj3ClQF1Na0r
         MfGlG/hzw6ibcSaN/qBTJnkql+Zzo+d40NlqpzyzX5ybtU1W3uQ2ySVzntVa7l0jYs
         tkDnbU64G7GfM2KZH9XpIvp8dnasZ7d1RvfrjUt2khPyFMDRUSqvqcK3+Ex61hsi7X
         BhyDG4ghY/zpMytxNISsWRBgmgGJllOR34RpeYEAVqRhNsCrgwz8QoCs3CgyKgd2Qk
         zZPwW6kHfDl3A==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 75A9215C3E94; Wed,  6 Jul 2022 10:55:04 -0400 (EDT)
Date:   Wed, 6 Jul 2022 10:55:04 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] random: remove CONFIG_ARCH_RANDOM and "nordrand"
Message-ID: <YsWiSH4BrY5oNJuM@mit.edu>
References: <20220705190121.293703-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705190121.293703-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 09:01:21PM +0200, Jason A. Donenfeld wrote:
> Later the thinking evolved. With a properly designed RNG, using RDRAND
> values alone won't harm anything, even if the outputs are malicious.

I personally think it's totally fine to remove nordrand.  However, the
reason why it was there was that there were some rather extreme
tin-foil-hatters who believed that if (the completely unavailable to
the public for auditing) RDRAND implementation *were* malicious *and*
the microcode had access to the register file and/or the instruction
pipeline, then in theory, a malicious CPU could subvert how the RDRAND
is mixed into the getrandom output to force a particular output.

Personally, I've always considered it to be insane, since a much
easier way to compromise a CPU would be to drop a Minix system hidden
into the CPU running a web server that had massive security bugs in it
that were only discovered years later.  And if you don't trust the CPU
manufacture to that extent, you should probably simply not use CPU's
from that manufacturer.  :-)

							- Ted
