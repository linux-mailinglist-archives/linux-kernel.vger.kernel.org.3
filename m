Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5B34AE539
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 00:08:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235217AbiBHXIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 18:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235172AbiBHXIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 18:08:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D720BC06157A;
        Tue,  8 Feb 2022 15:08:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 94B07B81DA0;
        Tue,  8 Feb 2022 23:08:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442ABC340ED;
        Tue,  8 Feb 2022 23:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644361688;
        bh=HHLDK0gdiu6mDdxkccPZJ03JgjiezwhJUW2MRc88A9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LE6VHe3/21VfERQewKclqDF5EJ9iVsjJRkB7//XHu+DbUvV74qk2QJ2rYQDZcCRkE
         /PxU52NAqVAURdHbgOjSOMrndra3gtrDrFgpBR7AJUP9aKziksZz9QwsGQ76jxt+mY
         gMLAL39PU+lTph+X6frYI8u1JNzh7twkGWJXbckGBUO/acto6O+i65/Ut3VNXOzChc
         EIs6LjXLcPv4vGib9zLhGRh9yTYQDYHwvcgirQJ20MtTWhGh3y/IdZqV0LzxdX3yL4
         YSIAKMMONgaJYE2bbxe3RGSgj2/9kA+3ibKHRB8zZYZnkeKOZ5xA4u1mcp7tkAInnk
         iHV3USmx+4GIg==
Date:   Tue, 8 Feb 2022 15:08:06 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH v1 3/7] random: inline leaves of rand_initialize()
Message-ID: <YgL31gTJX6UztpvH@sol.localdomain>
References: <20220208155335.378318-1-Jason@zx2c4.com>
 <20220208155335.378318-4-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208155335.378318-4-Jason@zx2c4.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 04:53:31PM +0100, Jason A. Donenfeld wrote:
> This is a preparatory commit for the following one. We simply inline the
> various functions that rand_initialize() calls that have no other
> callers. The compiler was doing this anyway before. Doing this will
> allow us to reorganize this after.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
>  drivers/char/random.c | 90 ++++++++++++++++---------------------------
>  1 file changed, 33 insertions(+), 57 deletions(-)

Looks good,

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
