Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEECC58C324
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 08:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbiHHGKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 02:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbiHHGKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 02:10:08 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9EE010B8
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 23:10:06 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4M1Qlw546Jz4x1J;
        Mon,  8 Aug 2022 16:10:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1659939004;
        bh=LZgjXTb9vBdbAEpHKe5L3j/y7J+RSnYI1mHQe+AyoFg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Bh24TTDigtLy4H5pm2qxg7DkRRnF/YGA7VkCTNuVmGXpnZPTI4DBbDdklj+39Uxs5
         ZBgVGstaXRDTzJrl/wMJ4XPbWFhRbEagQA0wZbOPhhF56qBSRvPYMeD9zKXTvy2yP3
         tiDGzP1Nsa/Y/3PSTAqum1qhc3SZLfGXr3Ef/oBrctgexpJ7W1DBUhxHfYGcKeNBWz
         Nao+mxM/bTBiFKyCsfEfLIOdF7R+p2PH6Mnud2Jctz/TTtmgPSto6ywQqhNz6SLIwE
         m2xoBpzjy6zH5Nu4K1dnEAnGb3XXno/slEgcqD7hfnX/yUgYfbhQAj11LR1ubtKM1f
         kd6acTauwRZ0g==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Yury Norov <yury.norov@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] Bitmap patches for v6.0-rc1
In-Reply-To: <CAHk-=whsgbpbVC_+V-dxuPbQCPV1eFQG00TrQvJcjYAXVHdswA@mail.gmail.com>
References: <20220805022940.1637978-1-yury.norov@gmail.com>
 <87edxtaol6.fsf@mpe.ellerman.id.au>
 <CAHk-=whsgbpbVC_+V-dxuPbQCPV1eFQG00TrQvJcjYAXVHdswA@mail.gmail.com>
Date:   Mon, 08 Aug 2022 16:10:01 +1000
Message-ID: <874jyn9sg6.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Fri, Aug 5, 2022 at 11:11 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> This pull request has a conflict with the random tree in some powerpc
>> code.
>
> I noticed.

Thanks. Your resolution looks fine and builds for me.

> And I tried to do a cross-compile, but with my update to F36 the
> powerpc64 cross-tools seems to be very broken. I get lots of strange
> errors like
>
>     Cannot find symbol for section 11: .text.kgdb_arch_pc.
>
> and I have no idea why.  I used to have a working cross-build
> environment at one point, but now it just gives me lots of errors.

If you just build defconfig rather than allmodconfig it should build
cleanly.

That's the "recordmcount" issue that's been going on for the last ~year.
It's some bad interaction between recordmcount and weak symbols and
newer versions of binutils.

Naveen made an attempt to fix it, but the discussion with Steve fizzled
out inconclusively.

AIUI objtool doesn't have the same problem so hopefully we can switch to
objtool soon and avoid the issue.

cheers
