Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C824B4EDFF0
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 19:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232671AbiCaR5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 13:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbiCaR5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 13:57:14 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811022220D5;
        Thu, 31 Mar 2022 10:55:26 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 22VHtKuR015132
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Mar 2022 13:55:21 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9166115C003E; Thu, 31 Mar 2022 13:55:20 -0400 (EDT)
Date:   Thu, 31 Mar 2022 13:55:20 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v2] random: mix build-time latent entropy into pool at
 init
Message-ID: <YkXrCMKxwFT3dT8y@mit.edu>
References: <20220331150706.124075-1-Jason@zx2c4.com>
 <20220331152641.169301-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331152641.169301-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 31, 2022 at 11:26:41AM -0400, Jason A. Donenfeld wrote:
> Prior, the "input_pool_data" array needed no real initialization, and so
> it was easy to mark it with __latent_entropy to populate it during
> compile-time. In switching to using a hash function, this required us to
> specifically initialize it to some specific state, which means we
> dropped the __latent_entropy attribute. An unfortunate side effect was
> this meant the pool was no longer seeded using compile-time random data.
> In order to bring this back, we declare an array in rand_initialize()
> with __latent_entropy and call mix_pool_bytes() on that at init, which
> accomplishes the same thing as before. We make this __initconst, so that
> it doesn't take up space at runtime after init.
> 
> Fixes: 6e8ec2552c7d ("random: use computational hash for entropy extraction")
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Cc: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

LGTM

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
