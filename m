Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9229A50ACD2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 02:35:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442955AbiDVAhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 20:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbiDVAhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 20:37:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9F36557;
        Thu, 21 Apr 2022 17:35:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80F6061F1F;
        Fri, 22 Apr 2022 00:35:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7ECBC385A7;
        Fri, 22 Apr 2022 00:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650587699;
        bh=VtPgWZlE7C2nVoqweagIYW/FoJ2sqG/IcX3v8LaDstA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jRVTrIjF+/xpLhXdTg3t89YzUMCjYtrGU8GfM/Cxu1B18Uk/D9nVVypOgODkDWj5k
         4BtoxYAW/y+wmW2WDwObGh8152+4daru3qdR0JXUz0dql4HXHHJ8g81z5vUCe38Zyj
         OanWoFbfsQbRKank7mDWVzIXEiPzINbPUJ4ltfKN2uZFfSZVqSaDl7wpd/gV6O3WtF
         dgPifDvDeV9Q8oL2WA1YReA/VUvB7+xElSbMqop2KZNFYSY1OvJvuYGWuUIcOc95Al
         eFk9Mn+0QGv8noVV5mNZrydUZDYOivCILMgb9liEhtGB8qqAVO46HD5deUzg75vaKz
         YrV827quRiHDg==
Date:   Thu, 21 Apr 2022 17:34:58 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2] random: avoid mis-detecting a slow counter as a cycle
 counter
Message-ID: <YmH4Mgbo9gs4tOp7@sol.localdomain>
References: <20220421233152.58522-1-ebiggers@kernel.org>
 <YmHraZcGnY3stnp9@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YmHraZcGnY3stnp9@zx2c4.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 22, 2022 at 01:40:25AM +0200, Jason A. Donenfeld wrote:
> Hi Eric,
> 
> Thanks. This looks better.
> 
> On Thu, Apr 21, 2022 at 04:31:52PM -0700, Eric Biggers wrote:
> > Therefore, increase the number of counter comparisons from 1 to 3, to
> > greatly reduce the rate of false positive cycle counter detections.
> > +	for (i = 0; i < 3; i++) {
> > +		unsigned long entropy = random_get_entropy();
>  
> Wondering: why do you do 3 comparisons rather than 2? What does 3 get
> you that 2 doesn't already? I thought the only real requirement was that
> in the event where (a)!=(b), (b) is read as meaningfully close as
> possible to when the counter changes.
> 

On CONFIG_PREEMPT kernels this code usually runs with preemption enabled, so I
don't think it's guaranteed that any particular number of comparisons will be
sufficient, since the task could get preempted for a long time between each call
to random_get_entropy().  However, the chance of a false positive should
decrease exponentially, and should be pretty small in the first place, so 3
comparisons seems like a good number.

We could also disable IRQs while checking, if you'd prefer to go that route.  We
would still need 2 comparisons.

- Eric
