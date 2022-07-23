Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB40057EF5D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 16:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237318AbiGWOEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 10:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236970AbiGWOEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 10:04:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BA317070;
        Sat, 23 Jul 2022 07:04:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2F6F76142E;
        Sat, 23 Jul 2022 14:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C049C341C0;
        Sat, 23 Jul 2022 14:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658585060;
        bh=i1hxM7Ujsdhm0k5s+lkC/ZUWIW+MTz2oWW+dSJcQLC8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bM4kEy1UjIF7GQ2Cqma5PvVIa4l9Ycx641e8SXLbUQjuzhfNV56YWb8GsGgVDVbPn
         UD+qsJz0rlBCL23S82Ol4/5NHIVKM6lLBE8KEJ2VpZm0LZwd7qrTvDEcnFQqXYNB0T
         M8EUJwv32dszihD48D1JbVOhmHUcB4tpWGYhCUPM=
Date:   Sat, 23 Jul 2022 16:04:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Siddh Raman Pant <code@siddh.me>
Cc:     David Howells <dhowells@redhat.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Eric Dumazet <edumazet@google.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-security-modules <linux-security-module@vger.kernel.org>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com
Subject: Re: [PATCH] kernel/watch_queue: Make pipe NULL while clearing
 watch_queue
Message-ID: <Ytv/4Tljvlt0PJ2r@kroah.com>
References: <20220723135447.199557-1-code@siddh.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723135447.199557-1-code@siddh.me>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 23, 2022 at 07:24:47PM +0530, Siddh Raman Pant via Linux-kernel-mentees wrote:
> If not done, a reference to a freed pipe remains in the watch_queue,
> as this function is called before freeing a pipe in free_pipe_info()
> (see line 834 of fs/pipe.c).
> 
> This causes a UAF when post_one_notification tries to access the pipe on
> a key update, which is reported by syzbot.
> 
> Bug report: https://syzkaller.appspot.com/bug?id=1870dd7791ba05f2ea7f47f7cbdde701173973fc
> Reported-and-tested-by: syzbot+c70d87ac1d001f29a058@syzkaller.appspotmail.com
> 
> Signed-off-by: Siddh Raman Pant <code@siddh.me>
> ---
>  kernel/watch_queue.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
> index bb9962b33f95..bab9e09c74cf 100644
> --- a/kernel/watch_queue.c
> +++ b/kernel/watch_queue.c
> @@ -637,8 +637,17 @@ void watch_queue_clear(struct watch_queue *wqueue)
>  		spin_lock_bh(&wqueue->lock);
>  	}
>  
> -	spin_unlock_bh(&wqueue->lock);
>  	rcu_read_unlock();

Also you now have a spinlock held when calling rcu_read_unlock(), are
you sure that's ok?

