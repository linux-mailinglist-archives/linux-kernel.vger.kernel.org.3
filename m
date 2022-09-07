Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCA635B0135
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 12:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbiIGKD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 06:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbiIGKD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 06:03:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C6CA1A5;
        Wed,  7 Sep 2022 03:03:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 25645B81BEB;
        Wed,  7 Sep 2022 10:03:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA14C433D6;
        Wed,  7 Sep 2022 10:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662545032;
        bh=cP3n6lYGdS8Im7b3OzknOQvKOK+r1YmiyNwd/uRfFWU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Mg4WHLIJt8mwvUi4wIAi6wHkD84YEmod4vIzAwCIB9C/Mi65oE+oz1z6Qn2nKK01n
         SmGz0fwwk93PcIkyNvfGu6gd8Qo/5J4s7OFlbfxuiKzpWFqZsHXUc9+tf8khs43O2x
         Vnrys4fz/3GHMzJQjkwj653WlqHPNo3tg+VUmm2lT9qFxi1NTxviMulDxiYWWATEWS
         jQhCEX7M3JrUiiYtIWh/XTicYylg0+LeH5zySTUDt53feTCOYULDQyWffwwPJcG8b6
         41prHBLCbxLJtmsuP8fm/dPxnqQ7ueS5+Rbmj3hwzeW6MtuMgraE08cckWpM4LAuym
         GISzjigV7dxYQ==
Date:   Wed, 7 Sep 2022 12:03:49 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org, boqun.feng@gmail.com
Subject: Re: [PATCH v5 06/18] rcu: Introduce call_rcu_lazy() API
 implementation
Message-ID: <20220907100349.GB194889@lothringen>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
 <20220901221720.1105021-7-joel@joelfernandes.org>
 <20220902152132.GA115525@lothringen>
 <Yxa5Ch574cRZxRdo@google.com>
 <20220906151757.GA183806@lothringen>
 <cde6586e-ae61-5e85-3c9a-1ce7dd2464ed@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cde6586e-ae61-5e85-3c9a-1ce7dd2464ed@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 12:15:19PM -0400, Joel Fernandes wrote:
> >> +
> >> +	// We had CBs in the bypass list before. There is nothing else to do if:
> >> +	// There were only non-lazy CBs before, in this case, the bypass timer
> > 
> > Kind of misleading. I would replace "There were only non-lazy CBs before" with
> > "There was at least one non-lazy CBs before".
> 
> I really mean "There were only non-lazy CBs ever queued in the bypass list
> before". That's the bypass_is_lazy variable. So I did not fully understand your
> suggested comment change.

I may well be missing something but to me it seems that:

bypass_is_lazy = all bypass callbacks are lazy
!bypass_is_lazy = there is at least one non-lazy bypass callback

And indeed as long as there is at least one non-lazy callback, we don't
want to rely on the LAZY timer.

Am I overlooking something?

> 
> >> +	// or GP-thread will handle the CBs including any new lazy ones.
> >> +	// Or, the new CB is lazy and the old bypass-CBs were also lazy. In this
> >> +	// case the old lazy timer would have been setup. When that expires,
> >> +	// the new lazy one will be handled.
> >> +	if (ncbs && (!bypass_is_lazy || lazy)) {
> >>  		local_irq_restore(flags);
> >>  	} else {
> >>  		// No-CBs GP kthread might be indefinitely asleep, if so, wake.
