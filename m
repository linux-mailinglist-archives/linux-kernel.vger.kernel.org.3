Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865ED56883C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 14:24:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233665AbiGFMXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 08:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233632AbiGFMXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 08:23:38 -0400
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067DD19002;
        Wed,  6 Jul 2022 05:23:36 -0700 (PDT)
Received: from zn.tnic (p200300ea970ff625329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:970f:f625:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6AAC51EC0554;
        Wed,  6 Jul 2022 14:23:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1657110211;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=wRdQIXL+RCAyyd72uEUIKY6ww/WujnqY3JOF3eBRCiU=;
        b=rdh8t6RFc0gGt9G7tiGczrhFL/KSKJRLZe9z6ziieJGHXPuN46/Wx0tgG2eu18eZZHq/6u
        XqBPTMWfxRifBHoav2tz0EDz93YQXWAy36Yq4MltpFTjWiu4ZebUZOyXzE/oVOAM+QiOBG
        FkmSrY+t2bnotZdQZMoN34logw4SzC4=
Date:   Wed, 6 Jul 2022 14:23:31 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] random: remove CONFIG_ARCH_RANDOM and "nordrand"
Message-ID: <YsV+w77z8iSM7dJQ@zn.tnic>
References: <20220705190121.293703-1-Jason@zx2c4.com>
 <YsSStCQQf008hF2F@zn.tnic>
 <YsSUkapje04MP2a1@zx2c4.com>
 <YsSXkNBtB6Ciy9iN@zn.tnic>
 <11C903CC-22A7-48EE-AD63-E71CC8D28B88@zytor.com>
 <YsS0ZLQw+QFA7XdJ@zn.tnic>
 <805B66CB-D847-4547-B6EE-C4FB72B75765@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <805B66CB-D847-4547-B6EE-C4FB72B75765@zytor.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 04:11:45PM -0700, H. Peter Anvin wrote:
> What I'm wondering is if we shouldn't be simply instrument *every*
> invocation, and set the trust to zero if we ever trip it.

I guess you can add some logic to rdrand_long() to sanity-check what it
returns...

But would that be worth the effort?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
