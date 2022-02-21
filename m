Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7BB4BEAE5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:37:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbiBUTPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 14:15:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiBUTPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 14:15:42 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5115321E14
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 11:15:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 04582B816F9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 19:15:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81C29C340E9;
        Mon, 21 Feb 2022 19:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645470916;
        bh=im76sRYWIi95DVQAR3uS7HE+45419J0jXwfGYOIoH4I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lmjQZNbfA09mRafaY8Mln3N5Prf/6xH3JNvce/zUwyaY7d8/a5gq8Httkjt+RMgHO
         m4awLNA+kMSGbjofACPQQiRbEHjgQS9Kf+VY+eoeizhkaA/nsEiAGT88lKUbOiFADL
         cIZ/RsIHobTgSH8sT4jKy95cjoN+6thkj0BbtFH46wOKp6IbFzXckBo/YKGXbY80Sj
         7a/Or2Ylq0amkMesa2nvHFCbNz9ml+ioGmGgETZTQHf6RIT1q48kL8DYXOWlAk9/nN
         MvJag/mk1hFtP/CGNeBHO1Bo6eR52PhiHQUj63qYjrp022uJQZU4mYbe9O0e2Z0BQS
         Pd6iM5UhraSlA==
Date:   Mon, 21 Feb 2022 11:15:15 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v3] random: make more consistent use of integer types
Message-ID: <YhPkw4xhJKSuAZHU@sol.localdomain>
References: <CAHmME9o5XzZVQUKBkS7d30AwVvPX3weyHdBsUBOK7fKaQO0JMA@mail.gmail.com>
 <20220221150523.2282542-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221150523.2282542-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 04:05:23PM +0100, Jason A. Donenfeld wrote:
> We've been using a flurry of int, unsigned int, size_t, and ssize_t.
> Let's unify all of this into size_t where it makes sense, as it does in
> most places, and leave ssize_t for return values with possible errors.
> 
> In addition, keeping with the convention of other functions in this
> file, functions that are dealing with raw bytes now take void *
> consistently instead of a mix of that and u8 *, because much of the time
> we're actually passing some other structure that is then interpreted as
> bytes by the function.
> 
> We also take the opportunity to fix the outdated and incorrect comment
> in get_random_bytes_arch().
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>
> Reviewed-by: Jann Horn <jannh@google.com>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> v3 changes a u8* into a const u8* and makes the rand_initialize loop
> count up from 0, per Eric's request.
> 
>  drivers/char/random.c         | 123 +++++++++++++++-------------------
>  include/linux/hw_random.h     |   2 +-
>  include/linux/random.h        |  10 +--
>  include/trace/events/random.h |  79 +++++++++++-----------
>  4 files changed, 99 insertions(+), 115 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
