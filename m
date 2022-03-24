Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA744E698A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 20:53:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243185AbiCXTzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 15:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbiCXTzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 15:55:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357B44ECF1;
        Thu, 24 Mar 2022 12:53:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0EA460A73;
        Thu, 24 Mar 2022 19:53:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165B6C340EC;
        Thu, 24 Mar 2022 19:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648151617;
        bh=D75ud677m4ZIqiTRL5Pi0culPxhWBX4MDdbcWmJ4Pgg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aI8QOAeEBJQ2V2pBj7SfIWPZUdZ8AP7+sWFiaDK/bH4sLE0US1azgNwG3FghT6fjR
         H2IVtJh3EB8tK5kGMKOr3dEn4WHmf0P7MZmmNbp8+5XJLp8tzwrx5Fhxs9Aquo3czC
         1NyXTlM/bvXN+ohC4+7nFF6g6cNijIxErwAsgJF7xafLUICmze3qhOxMlqRzWpRLwq
         i1CRZUvuviw40RxaRejxz5w3U6JgYRAkZvzwEm7PGnX5xHI5lu8gFgPxonYTegqTbR
         LxDFwlWwGnAlKA8M3r91QpQ20o0vbjMb5M5XOW28POLKMqa0g/N0JRpozE5nsB+sDH
         a8fIY0jtqb6dg==
Date:   Thu, 24 Mar 2022 19:53:35 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Theodore Ts'o <tytso@mit.edu>, Jann Horn <jannh@google.com>
Subject: Re: [PATCH] random: allow writes to /dev/urandom to influence fast
 init
Message-ID: <YjzMPymC3uXQUTrq@gmail.com>
References: <20220322191436.110963-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322191436.110963-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 01:14:36PM -0600, Jason A. Donenfeld wrote:
> For as far back as I can tell, writing to /dev/urandom or /dev/random
> will put entropy into the pool, but won't immediately use it, and won't
> credit it either.

Did you check kernels v4.7 and earlier?  It looks like this actually changed in
v4.8 when the ChaCha20 CRNG was introduced.  v4.7 would mix the data written to
/dev/{u,}random into {non,}blocking_pool, which would immediately be reflected
in reads from /dev/{u,}random, sys_getrandom(), and get_random_bytes().  Writes
to /dev/{u,}random didn't affect the input_pool, which was separate.

Was the change in behavior in v4.8 a regression?

- Eric
