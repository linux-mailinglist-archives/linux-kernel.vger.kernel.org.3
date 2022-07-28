Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE51583906
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 08:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbiG1Gwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 02:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233104AbiG1Gwc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 02:52:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67F05D0CF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 23:52:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9053AB821BD
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 06:52:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C91C433B5;
        Thu, 28 Jul 2022 06:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658991149;
        bh=K9c9yy81GS7CFkzPv82V7yRAR1v5pIO6ddj+1v5t3Mk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GLqb0tZazPI/3BtsiAZ/M4HVVg8whBTxwy2ZEQefsBgNIdkb6+pzCk37NgrFEUmJk
         xbXiHFoxcgwXEigx8+9C1K0lXdfMBh4l4MbQR2kSyVLHZa1WxpVtnI1JvRqORGvbdL
         3xvcqY/cXO+qV8wFkAQESELOErLeHQv7NYTPl/I4=
Date:   Thu, 28 Jul 2022 08:52:26 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dipanjan Das <mail.dipanjan.das@gmail.com>
Cc:     dhowells@redhat.com, sashal@kernel.org, fmdefrancesco@gmail.com,
        edumazet@google.com, linux-kernel@vger.kernel.org,
        syzkaller@googlegroups.com, fleischermarius@googlemail.com,
        its.priyanka.bose@gmail.com
Subject: Re: KASAN: use-after-free Read in post_one_notification
Message-ID: <YuIyKjvQ0vOeRWhl@kroah.com>
References: <CANX2M5bHye2ZEEhEV6PUj1kYL2KdWYeJtgXw8KZRzwrNpLYz+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANX2M5bHye2ZEEhEV6PUj1kYL2KdWYeJtgXw8KZRzwrNpLYz+A@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 02:28:45PM -0700, Dipanjan Das wrote:
> Hi,
> 
> We would like to report the following bug which has been found by our
> modified version of syzkaller.
> 
> ======================================================
> description: KASAN: use-after-free Read in post_one_notification
> affected file: kernel/watch_queue.c
> kernel version: 5.10.131
> kernel commit: 8f95261a006489c828f1d909355669875649668b
> git tree: upstream
> kernel config: https://syzkaller.appspot.com/x/.config?x=e49433cfed49b7d9
> crash reproducer: attached
> patch: This bug was previously reported by syzkaller for kernel
> version 5.17. The same patch works for kernel version 5.10 as well,
> i.e., we tested that the repro can no longer triggers the reported
> crash with this patch:
> https://syzkaller.appspot.com/text?tag=Patch&x=13b8c83c080000

I'm sorry, I do not understand.  So this is fixed in Linus's tree?  But
not in 5.10.y?  Or it is not fixed everywhere?

If it is fixed, what is the git commit id of the patch in Linus's tree
that fixes this that should be backported to 5.10.y?

confused,

greg k-h
