Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB22A4C4744
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:17:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238262AbiBYORX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:17:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241605AbiBYORT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:17:19 -0500
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8618034653
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 06:16:43 -0800 (PST)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id F248F200230;
        Fri, 25 Feb 2022 14:16:40 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 38FF5802B3; Fri, 25 Feb 2022 15:16:34 +0100 (CET)
Date:   Fri, 25 Feb 2022 15:16:34 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v3] random: unify cycles_t and jiffies usage and types
Message-ID: <Yhjkwg6s8BP7xdaR@owl.dominikbrodowski.net>
References: <CAHmME9qsj-Ge0LAXwFjtaMpY6W-G_fB7fTdXQ3rKRGpVpHnDnw@mail.gmail.com>
 <20220225134408.933305-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220225134408.933305-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Fri, Feb 25, 2022 at 02:44:08PM +0100 schrieb Jason A. Donenfeld:
> random_get_entropy() returns a cycles_t, not an unsigned long, which is
> sometimes 64 bits on various 32-bit platforms, including x86.
> Conversely, jiffies is always unsigned long. This commit fixes things to
> use cycles_t for fields that use random_get_entropy(), named "cycles",
> and unsigned long for fields that use jiffies, named "now". It's also
> good to mix in a cycles_t and a jiffies in the same way for both
> add_device_randomness and add_timer_randomness, rather than using xor in
> one case. Finally, we unify the order of these volatile reads, always
> reading the more precise cycles counter, and then jiffies, so that the
> cycle counter is as close to the event as possible.
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Cc: Dominik Brodowski <linux@dominikbrodowski.net>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
