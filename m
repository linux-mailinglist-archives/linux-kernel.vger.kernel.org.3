Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80AB94F5240
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1849852AbiDFCky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 22:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1577291AbiDEXMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 19:12:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7F29F39B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 14:43:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 246A7B81D6B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 21:43:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7664FC385A3;
        Tue,  5 Apr 2022 21:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649195001;
        bh=szpEVpgAF0+3N/j6Gm2zExlnHyVr3baDDffz0gb3dks=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BGrRZ+FyzSF27oVZ/Ecqz4metIlX3/tnLBucAbDXS6O0A75qahv8Tnkoap9Lk2CKp
         p93/llgRYtG/83uYgYktj2tQJVqYZ5yoOAWm5wbwrN6o6JOwJRXepvB6PwhR6VhzpI
         7h0h/NAGQ+uL4NxVMYA2feqid6aBYc7DU6Tb39yR6hnUs1ZSlbcd5+42lZdIIfCExX
         D9iNFDOqfdTjt9/Uh4N4bEWHfXJPcD63xYUhzJcdxld12qkfxmmHbasmOjkxTufYSU
         IOls5dvq7r0oo4uSffh11zxDws1/MAjK4iYdKamFOna+pnFKvrdXdRKuipqYm8ahtg
         4aGFXLeHVqsAQ==
Date:   Tue, 5 Apr 2022 23:43:19 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH 2/2] timers: Fix warning in __run_timers()
Message-ID: <20220405214319.GA1359137@lothringen>
References: <20220405191732.7438-1-anna-maria@linutronix.de>
 <20220405191732.7438-3-anna-maria@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220405191732.7438-3-anna-maria@linutronix.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 05, 2022 at 09:17:32PM +0200, Anna-Maria Behnsen wrote:
> When the timer base is empty, base::next_expiry is set to base::clk +
> NEXT_TIMER_MAX_DELTA and base::next_expiry_recalc is false. When no timer
> is queued until jiffies reaches base::next_expiry value, the warning for
> not finding any expired timer and base::next_expiry_recalc is false in
> __run_timers() triggers.
> 
> To prevent triggering the warning in this valid scenario
> base::timers_pending needs to be added to the warning condition.
> 
> Fixes: 31cd0e119d50 ("timers: Recalculate next timer interrupt only when necessary")
> Reported-by: Johannes Berg <johannes@sipsolutions.net>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

Thanks!
