Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C636D516DDF
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 12:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384383AbiEBKHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 06:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384460AbiEBKGN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 06:06:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF27F60
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 03:02:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 19EC7CE16E0
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 10:02:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A754C385AC;
        Mon,  2 May 2022 10:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651485749;
        bh=NguaT+/Q3HuD7q15xEi7PC7PJM/qponU/4ADlpgZs+w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Sd/guOm8G8Ap3pDANr1h6S8iv5TXhnudF/5d2+TgVdbjgGTaqB7A4fh01IW1MpuO7
         aVIkzyDHXUXYhBiC8iCISKGyxn271S+bufNaZ+Q1d1jUi1IuwgzmV7HBCns+idAbtq
         0xGOpoNsRhhIUU26yFTk2nZNPY63PR3zW2l8HhYjcGMusF3/kSvXImPzRc/uOuhWhb
         x4AkQh9BhGzjmNZ80NKz0QCXSmJCXHIzHv5t6D2rtt4UH+3Cvvdz47RSXEMWEyKnFu
         3YE5/bx7ChsOTrtAR0G5SPi85LZAKnqyW2QD2knP3QqwXqY3yWEnyY+HUXuCK3IkBw
         1TbcUr5VHcl9g==
Date:   Mon, 2 May 2022 11:02:26 +0100
From:   Filipe Manana <fdmanana@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Filipe Manana <fdmanana@suse.com>
Subject: Re: [patch 0/3] x86/fpu: Prevent FPU state corruption
Message-ID: <Ym+sMv5NUOhmLVPH@debian9.Home>
References: <20220501192740.203963477@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220501192740.203963477@linutronix.de>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2022 at 09:31:42PM +0200, Thomas Gleixner wrote:
> The recent changes in the random code unearthed a long standing FPU state
> corruption due do a buggy condition for granting in-kernel FPU usage.

Thanks for fixing this. I had been reliably hitting that fpu state splat
since 5.18-rc1 with fstests, and was annoying because it made a few tests
fail (fstests reports a failure whenever there's a splat or warning in
dmesg).

I confirm that with this patchset applied the issue no longer happens and
everything seems to be working fine, so:

Tested-by: Filipe Manana <fdmanana@suse.com>

> 
> The following series addresses this issue and makes the code more robust.
> 
> Thanks,
> 
> 	tglx
> ---
>  arch/um/include/asm/fpu/api.h       |    2 
>  arch/x86/include/asm/fpu/api.h      |   21 +-------
>  arch/x86/include/asm/simd.h         |    2 
>  arch/x86/kernel/fpu/core.c          |   92 +++++++++++++++++++-----------------
>  net/netfilter/nft_set_pipapo_avx2.c |    2 
>  5 files changed, 57 insertions(+), 62 deletions(-)
> 
> 
> 
