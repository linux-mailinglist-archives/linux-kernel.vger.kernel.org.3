Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24303525B88
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377378AbiEMG0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377308AbiEMG0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:26:25 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B8827CC0
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 23:26:22 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id F07F2201406;
        Fri, 13 May 2022 06:26:05 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id D3E92809A3; Fri, 13 May 2022 08:23:40 +0200 (CEST)
Date:   Fri, 13 May 2022 08:23:40 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] random: avoid init'ing twice in credit race
Message-ID: <Yn35bNS6RlElAGYh@owl.dominikbrodowski.net>
References: <20220509121409.529788-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509121409.529788-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mon, May 09, 2022 at 02:14:08PM +0200 schrieb Jason A. Donenfeld:
> Since all changes of crng_init now go through credit_init_bits(), we can
> fix a long standing race in which two concurrent callers of
> credit_init_bits() have the new bit count >= some threshold, but are
> doing so with crng_init as a lower threshold, checked outside of a lock,
> resulting in crng_reseed() or similar being called twice.

Sidenote: crng_reseed() did manage quite fine if called twice in short
order.

> In order to fix this, we can use the original cmpxchg value of the bit
> count, and only change crng_init when the bit count transitions from
> below a threshold to meeting the threshold.
> 
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
