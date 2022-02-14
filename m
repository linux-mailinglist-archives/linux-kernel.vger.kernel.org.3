Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC364B4C4A
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 11:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347571AbiBNKjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 05:39:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348856AbiBNKgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 05:36:01 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 534C2205D4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:02:21 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 0D41E210F4;
        Mon, 14 Feb 2022 10:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1644832940; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5mCqPoiiSFqVsEsSBkh61HkdEnJ7cMxylRwFu11LaQA=;
        b=OzueHF+cFHoaypaGmaasoI+PnOp34/rRlN6Qiq2/lo8bgGwlYqrOAPjoIKt+rDBmOgDlty
        Ek+RRwmKgEl56VXke2AvkLvUuwBZOWgglmy3NCIGpcAF5x1WraV2cQQobQTag2v15fjjEU
        HJJOhafFQFWPy+ScYqd/Oe71/GxR3Z4=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 81597A3B8E;
        Mon, 14 Feb 2022 10:02:19 +0000 (UTC)
Date:   Mon, 14 Feb 2022 11:02:19 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     John Ogness <john.ogness@linutronix.de>,
        Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH printk v1 10/13] printk: add kthread console printers
Message-ID: <Ygooq5zdsQHJ5Eiy@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220208083620.2736-1-hdanton@sina.com>
 <87v8xpmx9n.fsf@jogness.linutronix.de>
 <YgKD6X9eiADTnvIi@alley>
 <Ygny42nqV+3R5fp9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ygny42nqV+3R5fp9@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon 2022-02-14 15:12:51, Sergey Senozhatsky wrote:
> On (22/02/08 15:53), Petr Mladek wrote:
> > My mine concern is that the kthread_worker API still uses an internal
> > lock. And it is yet another layer that might be hard to debug when
> > printk() does not work.
> 
> Isn't this also true for kthreads? Looks like we add "couple of spin_locks"
> to the picture - rq, etc. - one way of the other.

kthread_worker API is built on top of kthreads. It means one more
lock, one more layer to deal with.

If anyone wants to propose workqueues or kthread_worker API, please,
come up with a code and proof that it makes things easier.

It is fine to mention this possibility. It is fine to consider it.
It is fine to keep it in mind. But I do not want to spent too much
time on theoretic discussions at the moment. We have a code now.
John has spent non-trivial time on it. Let's concentrate
on review.

Best Regards,
Petr
