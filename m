Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B9E525B8E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 08:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377383AbiEMG0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 02:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377311AbiEMG0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 02:26:25 -0400
Received: from isilmar-4.linta.de (isilmar-4.linta.de [136.243.71.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E71252980B;
        Thu, 12 May 2022 23:26:22 -0700 (PDT)
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl.brodo.linta [10.2.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id F3FF920140A;
        Fri, 13 May 2022 06:26:05 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id D88E880989; Fri, 13 May 2022 08:22:20 +0200 (CEST)
Date:   Fri, 13 May 2022 08:22:20 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: Re: [PATCH v4] random: use static branch for crng_ready()
Message-ID: <Yn35HIqb2vPxg6XB@owl.dominikbrodowski.net>
References: <20220512144235.2466-1-Jason@zx2c4.com>
 <20220512163748.3477-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512163748.3477-1-Jason@zx2c4.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Thu, May 12, 2022 at 06:37:48PM +0200 schrieb Jason A. Donenfeld:
> Since crng_ready() is only false briefly during initialization and then
> forever after becomes true, we don't need to evaluate it after, making
> it a prime candidate for a static branch.
> 
> One complication, however, is that it changes state in a particular call
> to credit_init_bits(), which might be made from atomic context, which
> means we must kick off a workqueue to change the static key. Further
> complicating things, credit_init_bits() may be called sufficiently early
> on in system initialization such that system_wq is NULL.
> 
> Fortunately, there exists the nice function execute_in_process_context(),
> which will immediately execute the function if !in_interrupt(), and
> otherwise defer it to a workqueue. During early init, before workqueues
> are available, in_interrupt() is always false, because interrupts
> haven't even been enabled yet, which means the function in that case
> executes immediately. Later on, after workqueues are available,
> in_interrupt() might be true, but in that case, the work is queued in
> system_wq and all goes well.

	Reviewed-by: Dominik Brodowski <linux@dominikbrodowski.net>

Thanks,
	Dominik
