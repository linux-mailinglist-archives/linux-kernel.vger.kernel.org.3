Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8EC857FE50
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 13:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235027AbiGYLZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 07:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235013AbiGYLZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 07:25:13 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A41389D
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 04:25:11 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D0A912005D;
        Mon, 25 Jul 2022 11:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658748309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FkbOTZeXbuGPcsmYrhwC6BftW6Xv7bUNRGWwxI1HptQ=;
        b=mAaVDSEjTAgRb+gypaAUY7R+Pb805t175yu3Cdz95hXurwuqX3KDRCjm0B1kDzi96v493n
        mGz+FITge4/ENFcD2NG9EZ3uGfbh/8t2+NL/t6sOKL3V6bczTWBFOgv3ikO+vJgP326SU7
        Kgb0fKx1aeVgBckpUN5tPO9TMa1QgBs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658748309;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FkbOTZeXbuGPcsmYrhwC6BftW6Xv7bUNRGWwxI1HptQ=;
        b=13YM1ib7x3gMUZU6tQ+yZPfkyW0tRMGcgwWdvgvK//NobdON+l4ZJBZPkqIC04Ycx7emCW
        Yt5gkbw3nyZ1tHDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C3C6A13ABB;
        Mon, 25 Jul 2022 11:25:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id R5/BL5V93mKERQAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 25 Jul 2022 11:25:09 +0000
Date:   Mon, 25 Jul 2022 13:25:09 +0200
From:   Borislav Petkov <bp@suse.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] random: discourage use of archrandom outside of rng
Message-ID: <Yt59lUGcUdgU1VDZ@zn.tnic>
References: <Yt5hwxC1xgvA8Asw@zx2c4.com>
 <20220725111038.720624-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220725111038.720624-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 01:10:38PM +0200, Jason A. Donenfeld wrote:
> Borislav pointed out during the review of "random: handle archrandom
> with multiple longs" that people might actually use this function, which
> might not be good because the function has surprising semantics. This of
> course was also the case before that patch, and indeed RDSEED-like
> functions across architectures often behave surprisingly, failing often.
> While random.c has been written specifically to work with that behavior,
> not much else is well equipped for that.
> 
> So add a comment suggesting that this is not for general consumption.
> Fortunately, nobody uses this for general consumption anyway, and people
> who try quickly find themselves in trouble. But adding this comment out
> of an abundance of caution was nonetheless suggested, and it at least
> means there will be easier justification for cleaning up potential
> misuses of the function later.
> 
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Suggested-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  arch/arm64/include/asm/archrandom.h   | 13 +++++++++++++
>  arch/powerpc/include/asm/archrandom.h |  8 ++++++++
>  arch/s390/include/asm/archrandom.h    |  8 ++++++++
>  arch/um/include/asm/archrandom.h      |  8 ++++++++
>  arch/x86/include/asm/archrandom.h     |  9 ++++++---
>  include/asm-generic/archrandom.h      |  8 ++++++++
>  6 files changed, 51 insertions(+), 3 deletions(-)

Acked-by: Borislav Petkov <bp@suse.de>

Thx.

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
