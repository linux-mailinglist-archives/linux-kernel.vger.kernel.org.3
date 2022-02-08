Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 045814AD1C5
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 07:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347816AbiBHGsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 01:48:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347792AbiBHGsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 01:48:38 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D00E4C0401F2;
        Mon,  7 Feb 2022 22:48:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6DD1B61605;
        Tue,  8 Feb 2022 06:48:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6AA8C004E1;
        Tue,  8 Feb 2022 06:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644302916;
        bh=dqtHfl1ZlQ/aqoV7BiXslJfNRbt2e+V2Yl0qeT7NtOM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SGulEKnyIsffiHFhbNnmjUaC1uCHs1YCXWqZK5OKECUr4pFRLFrn+cgZgM255v9aQ
         LyWgspTr/kg9HxCIRJ+jTa77jHyEILJL7N3j9ncm0auVMX8KAcsLBsoc9532Bukjoo
         ve/MfkoPUgRin8P0ut/w0bh3k9INnWQn5uZ6fT4KQ7r8ij8ygiJLZDX5fwY5yRH1Ir
         A0S1m9+nog8J5mAesuf9aTiYlXKSe64L+YFVca313xMRN4gao6oDmbeokzG2zxjWgS
         zsTK2+wN7cLWwZSTxE4Igl2/GC6T4tNdnStxc8f4Stm7jpLEKIT5otpvVv9/0ZvL9k
         w9sBKpLvfytPQ==
Date:   Mon, 7 Feb 2022 22:48:35 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v3 0/5] random: use computational hash for entropy
 extraction, and related fixes
Message-ID: <YgISQ3RXJ7DpAMqA@sol.localdomain>
References: <20220205160118.252698-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220205160118.252698-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 05, 2022 at 05:01:13PM +0100, Jason A. Donenfeld wrote:
> The bulk of the motivation for this and description of crypto
> vulnerabilities is in the first patch of this series. The following
> three patches then fix up entropy accounting for the new model. The last
> patch fixes a minor code safety issue.
> 
> This v3 fixes comments and commit message wording, simplifies a bit of
> code in a cmpxchg loop, and adjusts semantics around the poll write
> wakeup threshold.
> 
> Jason A. Donenfeld (5):
>   random: use computational hash for entropy extraction
>   random: simplify entropy debiting
>   random: use linear min-entropy accumulation crediting
>   random: always wake up entropy writers after extraction
>   random: make credit_entropy_bits() always safe
> 
>  drivers/char/random.c         | 501 ++++++----------------------------
>  include/trace/events/random.h |  30 +-
>  2 files changed, 87 insertions(+), 444 deletions(-)

Looks good, thanks!  You can add for the series:

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
