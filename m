Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A16E95B00F8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbiIGJ4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbiIGJ4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:56:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B222A436;
        Wed,  7 Sep 2022 02:56:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E4CF861834;
        Wed,  7 Sep 2022 09:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD67DC433D7;
        Wed,  7 Sep 2022 09:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662544564;
        bh=43j1/GXOQ8HjrTpBSPu9G1AgM4IhX1nLYs/I4J5dp1g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kWpHwkKnG5jm3GRd1QEOnAGFiOkgolGgxZJrrbVgaR804F1WxHy9qM5tspu2/J9Ic
         6vGLAf1Ke5HOFhysEIRWwnDMfwEQ73a6939yBVKcICL4nJS0bXZFgbMJG810UXtPs3
         YQ/nUIG3ZX1C/DxIQ/QO4PkcrRpTPG5BVrByiVCg1JIaXuSdInQ8fmW3tsF3jw6Vu/
         pgoEOCbU0PHBwVJwQkBeuwf7SiwtMTC/ManazRJbd52XMe/A9PCXMtA4IUFsqiYVsA
         Dl3VI+KjU6IEhuCo5JbhWw16+DEp3+ObqcfsJ6xy9t9GLfVGa9WhwMy7YdTLZR15kX
         GCw2JM6mbblgQ==
Date:   Wed, 7 Sep 2022 11:56:01 +0200
From:   Frederic Weisbecker <frederic@kernel.org>
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        rushikesh.s.kadam@intel.com, urezki@gmail.com,
        neeraj.iitr10@gmail.com, paulmck@kernel.org, rostedt@goodmis.org,
        vineeth@bitbyteword.org, boqun.feng@gmail.com
Subject: Re: [PATCH v5 06/18] rcu: Introduce call_rcu_lazy() API
 implementation
Message-ID: <20220907095601.GA194889@lothringen>
References: <20220901221720.1105021-7-joel@joelfernandes.org>
 <20220902152132.GA115525@lothringen>
 <Yxa5Ch574cRZxRdo@google.com>
 <20220906151757.GA183806@lothringen>
 <cde6586e-ae61-5e85-3c9a-1ce7dd2464ed@joelfernandes.org>
 <64f5770c-df37-8975-200d-7908de23fa73@joelfernandes.org>
 <da45d265-52f9-6314-7fcd-ea71e2bf4cec@joelfernandes.org>
 <4f6061f0-0de7-2916-dc6e-9f5af9b944c0@joelfernandes.org>
 <20220906191110.GA187950@lothringen>
 <8812ea75-ef14-0d5d-19d8-bda70394b41a@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8812ea75-ef14-0d5d-19d8-bda70394b41a@joelfernandes.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 10:56:01PM -0400, Joel Fernandes wrote:
> On the issue of regressions with non-lazy things being treated as lazy, I was
> thinking of adding a bounded-time-check to:
> 
> [PATCH v5 08/18] rcu: Add per-CB tracing for queuing, flush and invocation.
> 
> Where, if a non-lazy CB takes an abnormally long time to execute (say it was
> subject to a race-condition), it would splat. This can be done because I am
> tracking the queue-time in the rcu_head in that patch.
> 
> On another note, boot time regressions show up pretty quickly (at least on
> ChromeOS) when non-lazy things become lazy and so far with the latest code it
> has fortunately been pretty well behaved.

Makes sense. We definetly need some sort of detection for delayed non-lazy
callbacks.

Thanks!

> 
> Thanks,
> 
>  - Joel
