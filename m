Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E479156C933
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 13:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiGILbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 07:31:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiGILbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 07:31:01 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2E950199
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 04:30:59 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 9FADF1FE73;
        Sat,  9 Jul 2022 11:30:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1657366258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Jjp19mv6GbPrtx3Ra45YPyA7WLXFyG+o+BYLqlO0wQ=;
        b=Q3orYhZyiOEC3KgsuVc4FDSXU9CbsPqEHKAIjCVifrgsSLLrAgX0Li+Nbw8Wkm6HN0cYnM
        yrnqmDE17ruYFS/Hw5X7OrO0aJEp4d1CHo8KElwFxlE6B28aNq4fZUv/GhsV7rnmIoo6pz
        0W/PbwNXcmEL+Iyke/gCbDxpF2wVPw8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1657366258;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4Jjp19mv6GbPrtx3Ra45YPyA7WLXFyG+o+BYLqlO0wQ=;
        b=JzIyDqCR0U6YYmD3z60ghU1T3QOVL1L4pZp0VSWCfw+bdeiIKPuZB006penff41cnSw5Qu
        NPueAE8nwfdux4CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9266D13482;
        Sat,  9 Jul 2022 11:30:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id +Y22I/JmyWL0CQAAMHmgww
        (envelope-from <bp@suse.de>); Sat, 09 Jul 2022 11:30:58 +0000
Date:   Sat, 9 Jul 2022 13:30:52 +0200
From:   Borislav Petkov <bp@suse.de>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        "H . Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH random v2] x86/rdrand: Remove "nordrand" flag in favor of
 "random.trust_cpu"
Message-ID: <Yslm7D9E7nXAsPWk@zn.tnic>
References: <CAHmME9oeyPy5EEXU094xSEBDQ1xcqAgVbAihgS7_kEWCnw1kww@mail.gmail.com>
 <20220709104306.1094431-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220709104306.1094431-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 09, 2022 at 12:43:06PM +0200, Jason A. Donenfeld wrote:
> The decision of whether or not to trust RDRAND is controlled by the
> "random.trust_cpu" boot time parameter or the CONFIG_RANDOM_TRUST_CPU
> compile time default. The "nordrand" flag was added during the early
> days of RDRAND, when there were worries that merely using its values
> could compromise the RNG. However, these days, RDRAND values are not
> used directly but always go through the RNG's hash function, making
> "nordrand" no longer useful.
> 
> Rather, the correct switch is "random.trust_cpu", which not only handles
> the relevant trust issue directly, but also is general to multiple CPU
> types, not just x86.
> 
> However, x86 RDRAND does have a history of being occasionally
> problematic. Prior, when the kernel would notice something strange, it'd
> warn in dmesg and suggest enabling "nordrand". We can improve on that by
> making the test a little bit better and then taking the step of
> automatically disabling RDRAND if we detect it's problematic.
> 
> Also extend the basic sanity test to RDSEED in addition to RDRAND, and
> disable both if either one fails.
> 
> Cc: x86@kernel.org
> Cc: Theodore Ts'o <tytso@mit.edu>
> Suggested-by: H. Peter Anvin <hpa@zytor.com>
> Suggested-by: Borislav Petkov <bp@suse.de>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> This is a tip-ish commit, but it relies on the CONFIG_ARCH_RANDOM commit
> in the random tree, so I'll take this through the random tree to avoid
> conflicts.

Acked-by: Borislav Petkov <bp@suse.de>

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
