Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7668555E8E3
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348269AbiF1P7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 11:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348190AbiF1P7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 11:59:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13FD17E2B
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 08:59:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A45661763
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 15:59:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 060E1C341C6;
        Tue, 28 Jun 2022 15:59:15 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="fn8GFMp/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656431954;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=08Z8m+5SnpYMfrUky7ceZsy039gVfd2LXp8U4ZyDynU=;
        b=fn8GFMp/Y9zjBaL1vxMwDywM01xTcdOH4PhLDRvy1Vt9lWeEqJIviIYQoySTzToE/cRX1A
        WoYDTojzGFmehYCuIEmIXDYaj372GGpk9chpabxewKx+jWP6XI9Kk4L9fhzMeM9qhA3+2i
        Q4/7cS/sNV6jt31rSGJpAuSld18YH3k=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4d7d88c1 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 28 Jun 2022 15:59:14 +0000 (UTC)
Date:   Tue, 28 Jun 2022 17:59:11 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v2] signal: break out of wait loops on kthread_stop()
Message-ID: <YrslT9h0whngMIhw@zx2c4.com>
References: <YrnEvjcG8tmF3dRV@zx2c4.com>
 <20220627145716.641185-1-Jason@zx2c4.com>
 <877d51udc7.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877d51udc7.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

On Mon, Jun 27, 2022 at 02:16:08PM -0500, Eric W. Biederman wrote:
> Semantically this makes a lot of sense.
> 
> Bloating up signal_pending which is mainly called in non-kthread
> contexts is undesirable.

I guess I understand that concern, but does it really matter here? This
is called by code that waits anyway, so it's not like performance
matters at all, right?

> Instead could you modify kthread_stop to call set_notify_signal().
> 
> That is exactly what set_notify_signal is there for.  When you don't
> actually have a signal but you want to break out of an interruptible
> loop.  My last round of work in the area decoupled set_notify_signal
> from any other semantics.

This sounds like the best option here, if in fact it does work. I'll
send in a patch for that and we can see how it interacts with the other
work you're doing.

Jason
