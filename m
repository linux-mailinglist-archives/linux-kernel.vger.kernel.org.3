Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB3E0529FB5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 12:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343566AbiEQKqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 06:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbiEQKqO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 06:46:14 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFD76250;
        Tue, 17 May 2022 03:46:13 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id D0E541F8A6;
        Tue, 17 May 2022 10:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1652784371; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CrqyxTgDDbPMICiLN/JVfD2ePciVDSch7V2FdjTNLhM=;
        b=ACn2Dz7yp7KXjxQJF0PCdh1Qkl7ohIYkCniXIeUpehEzGSQ+jUi2Vm9WUi1Swzzw/hiuLL
        e+p8bhxJ/XxbNSRhmV3ZNPjjiwo6znMTsxWtWQUYIs5Sp+HRlm/17u1cEvB23qn5qCUKVZ
        d5K3eg6tVNnW1XExbtbv8Elb3PmjT3s=
Received: from suse.cz (unknown [10.100.201.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7628C2C141;
        Tue, 17 May 2022 10:46:11 +0000 (UTC)
Date:   Tue, 17 May 2022 12:46:08 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] random: remove mostly unused async readiness notifier
Message-ID: <YoN88JdmiTO39nqk@alley>
References: <YoD7hn4yBHE0RYUa@zx2c4.com>
 <20220515131927.474097-1-Jason@zx2c4.com>
 <YoNlNs7vGcAy8rU3@alley>
 <YoNvb265RG5pOObU@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YoNvb265RG5pOObU@zx2c4.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-05-17 11:48:31, Jason A. Donenfeld wrote:
> Hi Petr,
> 
> On Tue, May 17, 2022 at 11:04:54AM +0200, Petr Mladek wrote:
> > I would go even further. The workqueue is needed only because we are not
> > able to switch the static branch in an atomic context.
> > 
> > But the static branch looks like an over-optimization.
> > vsprintf() is a slow path. It will be enough to use a normal
> > variable.
> > 
> > Well, it would be nice to check it without the spinlock to keep it
> > fast and avoid problems with the spin lock during panic().
> > 
> > What about?
> 
> That all makes sense to me, but I'm a bit worried about changing too
> much from the original design in a commit mostly intended on removing
> things from random.c. Maybe we can do the patch I sent here, and then
> once that lands in 5.19, we can do some more simplifications as
> standalone commits that you can assess. Or if you're adamant about doing
> this now, maybe you can send a patch that I can apply on _top_ of this
> commit here?
> 
> The reason I'm a bit cautious is because I recall the original code from
> Tobin way back had some smp_wmb() just like this, but it got removed and
> replaced with that static branch. So at least somebody felt differently
> about it. Which means it'll probably be a whole discussion with more
> people, and I'm probably not the right person to lead that.

Fair enough.

> > Well, your approach with static_key is fine as well. Feel free
> > to use:
> > 
> > Acked-by: Petr Mladek <pmladek@suse.com>
> 
> Okay, I'll do this. And then let's circle around the memory barriers
> whenever you feel like it later.

OK, let's stick with your version in 5.19.

I will later send a patch with the barriers when time permits.
But it will probably be for the next release.

Best Regards,
Petr
