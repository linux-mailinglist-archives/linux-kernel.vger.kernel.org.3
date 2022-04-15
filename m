Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7F0502966
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353046AbiDOMLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238850AbiDOMLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:11:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFF01BF005
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lml+TwxImOpNa3t25Q8XQWiapNJmRx4JSkAQRKPlW+Y=; b=JRh6nVFK75HLN/1PYSokvl69HY
        vpcJgGjGikGM6U6vVRibJdA4jRsE29eTZsNHo5tprVceh+JzzMpo43fBEKUH71M9Pzpxw2h2qAf5/
        inetTSL/u8pE0AFwpTK77Dz658gSUQoIUa53Koi/mejtKZQlPY18kmLQJc5o1w3Hv1kVgbcNFrSWU
        +l9cG4AJp4SeUrCtY5NpYU3nrfqBj6m4hJ2gKBhZXK2MofoJq+tCBkY6Cit2IhYROS8YOhy89D7dl
        LZTw2TiuiS+s64eTsy+w6g0SBcySAEJLajP0ttNuewEDO/yEPH/idFLQeywHTdgfh68B9G7ckdc/g
        8cPTv2Pg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfKl9-005NIG-2u; Fri, 15 Apr 2022 12:09:07 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B4FD43001AD;
        Fri, 15 Apr 2022 14:09:06 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A541430A47E02; Fri, 15 Apr 2022 14:09:06 +0200 (CEST)
Date:   Fri, 15 Apr 2022 14:09:06 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: Re: [patch 2/3] timekeeping: Mark tk_clock_read() __always_inline
Message-ID: <YllgYuZ2jJvQbfZo@hirez.programming.kicks-ass.net>
References: <20220415091223.187169221@linutronix.de>
 <20220415091921.014937522@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415091921.014937522@linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 11:19:36AM +0200, Thomas Gleixner wrote:
> Compilers can uninline this which makes the notrace annotation of the NMI
> safe accessors moot.

inline already implies notrace.

No objection to making it __always_inline, but this reason doesn't
really work.

> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  kernel/time/timekeeping.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- a/kernel/time/timekeeping.c
> +++ b/kernel/time/timekeeping.c
> @@ -186,7 +186,7 @@ static inline void tk_update_sleep_time(
>   * a read of the fast-timekeeper tkrs (which is protected by its own locking
>   * and update logic).
>   */
> -static inline u64 tk_clock_read(const struct tk_read_base *tkr)
> +static __always_inline u64 tk_clock_read(const struct tk_read_base *tkr)
>  {
>  	struct clocksource *clock = READ_ONCE(tkr->clock);
>  
> 
