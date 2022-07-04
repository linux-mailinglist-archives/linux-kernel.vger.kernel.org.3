Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5B4564EAC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbiGDH3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:29:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiGDH3v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:29:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F3564FD
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 00:29:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 44617B80D8C
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:29:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2B6CC3411E;
        Mon,  4 Jul 2022 07:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656919788;
        bh=McCywfodUwTg/DHsbZpewQMUxw8nnYBiq3vah+DAdYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v2N5JkOADRblpp94Y9zpd2epLWjfQyB2hNTgCrEHzm5gQaOqeruvCFAwP6cmO30tf
         JLacZMT1ejauvxs1iqLkvyEaOQ1snQtaqfwOU/jfXydwQHe6ddkxEZ5sjxInrZFTs6
         BgbRDjjzYjZJUmiAMxQkydONkyg0VysJGB5YhXxc=
Date:   Mon, 4 Jul 2022 09:29:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] char: misc: make misc_open() and misc_register() killable
Message-ID: <YsKW6VvWqvcMRBSl@kroah.com>
References: <000000000000d9ff3a05bb37069e@google.com>
 <72e74af9-f1b6-e383-a2c3-6ee8a0aea5e0@I-love.SAKURA.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72e74af9-f1b6-e383-a2c3-6ee8a0aea5e0@I-love.SAKURA.ne.jp>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 03:44:07PM +0900, Tetsuo Handa wrote:
> syzbot is reporting hung task at misc_open() [1], for snapshot_open() from
> misc_open() might sleep for long with misc_mtx held whereas userspace can
> flood with concurrent misc_open() requests. Mitigate this problem by making
> misc_open() and misc_register() killable.

I do not understand, why not just fix snapshot_open()?  Why add this
complexity to the misc core for a foolish individual misc device?  Why
not add the fix there where it is spinning instead?

> Link: https://syzkaller.appspot.com/bug?extid=358c9ab4c93da7b7238c [1]
> Reported-by: syzbot <syzbot+358c9ab4c93da7b7238c@syzkaller.appspotmail.com>
> Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> ---
>  drivers/char/misc.c | 57 +++++++++++++++++++--------------------------
>  1 file changed, 24 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/char/misc.c b/drivers/char/misc.c
> index cba19bfdc44d..b9a494bc4228 100644
> --- a/drivers/char/misc.c
> +++ b/drivers/char/misc.c
> @@ -100,49 +100,39 @@ static const struct seq_operations misc_seq_ops = {
>  static int misc_open(struct inode *inode, struct file *file)
>  {
>  	int minor = iminor(inode);
> -	struct miscdevice *c = NULL, *iter;
> +	struct miscdevice *iter;
>  	int err = -ENODEV;
>  	const struct file_operations *new_fops = NULL;
> +	bool retried = false;
>  
> -	mutex_lock(&misc_mtx);
> -
> + retry:
> +	if (mutex_lock_killable(&misc_mtx))
> +		return -EINTR;

I really don't want to add this type of thing to the misc core if at all
possible.  Again, please just fix up the misbehaving misc driver
instead, don't penalize the core with thie complexity.

thanks,

greg k-h
