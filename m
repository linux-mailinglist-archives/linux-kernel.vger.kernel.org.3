Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499AB59BF5B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 14:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233217AbiHVMQO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 08:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbiHVMQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 08:16:12 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AE630556
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 05:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1661170570;
  x=1692706570;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=y/YEfz+k1hAzo3zlX9TaDtlgMamMYzSKXPinEdWmz1k=;
  b=RkQ1Pv6axH+Uw6HYyolWTcCOnyoVbOqtDzxSkzvsL9cgw+k67ZD8FtsE
   u4ySNkV9cacNucckfTSBTY3oBu7E3EzYvJpirScTRqNoE0n2PDerbJX4k
   Pn9C3tSC6SwKQdpmqhXmsUcTwyFD2lrvleWFSj3T4xjyu3driaqsQKq2g
   NoctHIHdVJsLanxCujwCV1a7ARW1pzFqpmksO8ZGL23vozdppzbevu/VW
   CGyoW4FilRJOyswzvBtxIdwQiwBkMm7hgo4uviN7l5oT7R5us6uYbUvDZ
   IkPR+CfHbqc1CyXURZBKzVO2fOtxtuv7gL+VGaY3Rh+kafNiCwtja4rJb
   w==;
Date:   Mon, 22 Aug 2022 14:16:08 +0200
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     Boqun Feng <boqun.feng@gmail.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        kernel <kernel@axis.com>, Waiman Long <longman@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] lockdep: Panic on warning if panic_on_warn is set
Message-ID: <YwNziHT2fO+M3TCZ@axis.com>
References: <20220818114259.2203505-1-vincent.whitchurch@axis.com>
 <Yv6z3SlfpmN+ZeV1@boqun-archlinux>
 <Yv9tLO2nbRBVyXgl@axis.com>
 <YwBurQWDUSZPfyqm@boqun-archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YwBurQWDUSZPfyqm@boqun-archlinux>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2022 at 07:18:37AM +0200, Boqun Feng wrote:
> > I'm not trying to obtain a kdump in this case.  I test device drivers
> > under UML[0] and I want to make the tests stop and fail immediately if
> > the driver triggers any kind of problem which results in splats in the
> > log.  I achieve this using panic_on_warn, panic_on_taint, and oops=panic
> > which result in a panic and an error exit code from UML.
> > 
> > [0] https://lore.kernel.org/lkml/20220311162445.346685-1-vincent.whitchurch@axis.com/
> > 
> > For lockdep, without this patch, I would be forced to parse the logs
> > after each test to determine if the test trigger a lockdep splat or not.
> 
> In that case, would a standard line with every lockdep warning help? For
> example:
> 
> [...] A LOCKDEP issue detected.
> 
> Two reasons I don't think making lockdep warning as panic is a good
> idea:
> 
> * We don't know what other CIs expect, given today lockdep doesn't panic
>   with panic_on_warn, this patch is a change of behaviors to them, and
>   it may break their setups/scripts.

Perhaps we could add a module parameter instead, so that the behaviour
can be enabled with lockdep.panic=1 or similar?  Then no existing setups
will be affected.

> * As I said, lockdep warnings are different than other warnings, and
>   panicking doesn't provide more information for debugging.
> 
> So I think an extra line helping scripts to parse may be better.
> 
> Work for you?

For my use case, the extra line isn't needed.  If I must parse the logs,
I can already do it with the existing prints.  But I'm trying to avoid
having to parse the logs altogether.
