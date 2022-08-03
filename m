Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28790588BC7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:07:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237742AbiHCMHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbiHCMHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:07:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3118C0C
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 05:07:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E0D3B82253
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 12:07:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E63DDC433D6;
        Wed,  3 Aug 2022 12:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659528423;
        bh=TY8/cpj97CeuAGeyEdlSoi8KimpP3r7t3KkyLr201eM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=umW48keVamvnUxIT7cMIgzBqUOcaJvGErmpybh8Rdnt2aH0Ii3+8tqrj9v1Yt1KJn
         T7PzcgEVQXmnWawlGK1jkfaaWtfiyP733VNPdAN3ZzMU3IK7D1c+ieJDzxFv0vaohH
         RAMj8ZPvqZz8Wrs/XLCjSDZOsosg7mwU5B+4ytOI=
Date:   Wed, 3 Aug 2022 14:07:00 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Theodore Ts'o <tytso@mit.edu>
Subject: Re: [v4.9 PATCH v2 6/6] random: move rand_initialize() earlier
Message-ID: <Yupk5K1S7flR7yjD@kroah.com>
References: <20220801164328.2205839-1-hegtvedt@cisco.com>
 <20220801164328.2205839-6-hegtvedt@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801164328.2205839-6-hegtvedt@cisco.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 06:43:28PM +0200, Hans-Christian Noren Egtvedt wrote:
> From: Kees Cook <keescook@chromium.org>
> 
> Right now rand_initialize() is run as an early_initcall(), but it only
> depends on timekeeping_init() (for mixing ktime_get_real() into the
> pools). However, the call to boot_init_stack_canary() for stack canary
> initialization runs earlier, which triggers a warning at boot:
> 
> random: get_random_bytes called from start_kernel+0x357/0x548 with crng_init=0
> 
> Instead, this moves rand_initialize() to after timekeeping_init(), and moves
> canary initialization here as well.
> 
> Note that this warning may still remain for machines that do not have
> UEFI RNG support (which initializes the RNG pools during setup_arch()),
> or for x86 machines without RDRAND (or booting without "random.trust=on"
> or CONFIG_RANDOM_TRUST_CPU=y).
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> (cherry picked from commit d55535232c3dbde9a523a9d10d68670f5fe5dec3)
> Signed-off-by: Hans-Christian Noren Egtvedt <hegtvedt@cisco.com>
> 
> Adjusted to fit on top of linux-4.9.y branch, suspecting a wrongly
> solved conflict when cherry picked earlier.
> ---
>  init/main.c | 7 -------
>  1 file changed, 7 deletions(-)

This is not commit d55535232c3dbde9a523a9d10d68670f5fe5dec3, as that is
already in the 4.9.y tree.  I can see that you want to fix the previous
merge up, so can you just send a real fix for that and don't try to say
you really are a different commit?

Other patches in this series now queued up.

thanks,

greg k-h
