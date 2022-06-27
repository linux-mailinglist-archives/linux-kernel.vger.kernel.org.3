Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6E5B55DEF7
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235200AbiF0OzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 10:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbiF0OzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 10:55:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FF2415FE7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 07:55:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D0E1E615A1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 14:55:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49AC4C3411D;
        Mon, 27 Jun 2022 14:55:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="g4N42kJX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1656341701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WgEinyux4HlcnBBbLgqEe2jqcu3BiHmbct/DDxcrzfA=;
        b=g4N42kJXVt1UCxJAERhIJhvgsWqV1XEzPPyo4U2CVs9N0qupusktT5AZ4pty7mjiTTFYbY
        V4Ym8SNocQbDpJcaxomrczDPK5/XIQpnelXVXsr5g9qaU3gyfg7qcNL7ygGyxeHk5hf9gz
        /vCA/Pnz5qy97Ts2ZN+84Uzb8wOvUJ8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 8401e912 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Mon, 27 Jun 2022 14:55:00 +0000 (UTC)
Date:   Mon, 27 Jun 2022 16:54:54 +0200
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        ebiederm@xmission.com,
        Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Kalle Valo <kvalo@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH] signal: break out of wait loops on kthread_stop()
Message-ID: <YrnEvjcG8tmF3dRV@zx2c4.com>
References: <20220627120020.608117-1-Jason@zx2c4.com>
 <YrmwJyueoz1Z4ti0@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YrmwJyueoz1Z4ti0@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 03:27:03PM +0200, Peter Zijlstra wrote:
> On Mon, Jun 27, 2022 at 02:00:20PM +0200, Jason A. Donenfeld wrote:
> 
> > +bool __kthread_should_stop(struct task_struct *k)
> > +{
> > +	return (k->flags & PF_KTHREAD) &&
> > +	       test_bit(KTHREAD_SHOULD_STOP, &to_kthread(k)->flags);
> > +}
> 
> This used to be a racy pattern; not sure it still is since Eric poked at
> this last, but please use __to_kthread() instead.

Ah, indeed. Will send a v2.

Jason
