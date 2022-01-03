Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD2614831AB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 15:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233238AbiACOET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 09:04:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiACOES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 09:04:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50618C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 06:04:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E17BD610A5
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 14:04:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77DF9C36AEB;
        Mon,  3 Jan 2022 14:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641218657;
        bh=b1Z4TUnfAUBsXmy2Byf0FBL1mQQmUSO3JuT+f5m4J40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r9hqlQphtM7RoWq0STsFvdR9qOQ4bJybVsLXdRDBE0qBxMzIYONFvCnl/RIaVMltd
         OQ41Ea8U6F68sEoyxcFiW2QxoEoy4vj3by15x4JJXAM0FLra0AVLQHbY+m0AESBsfe
         2MB7Fnl822emLlyTxERL6Y6/xpftTXvGxNg3CuyI=
Date:   Mon, 3 Jan 2022 15:04:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     arnd@arndb.de, giometti@enneenne.com, linux-kernel@vger.kernel.org,
        thesven73@gmail.com, ojeda@kernel.org
Subject: Re: [RFC char-misc-next 1/2] cdev: Add private pointer to struct cdev
Message-ID: <YdMCXierm0K6cVA/@kroah.com>
References: <cover.1641185192.git.dxu@dxuuu.xyz>
 <34157f5e8dbaa1063dd76608e1e57244305460e8.1641185192.git.dxu@dxuuu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <34157f5e8dbaa1063dd76608e1e57244305460e8.1641185192.git.dxu@dxuuu.xyz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 02, 2022 at 09:01:39PM -0800, Daniel Xu wrote:
> struct cdev is a kobject managed struct, meaning kobject is ultimately
> responsible for deciding when the object is freed. Because kobject uses
> reference counts, it also means a cdev object isn't guaranteed to be
> cleaned up with a call to cdev_del() -- the cleanup may occur later.
> 
> Unfortunately, this can result in subtle use-after-free bugs when struct
> cdev is embedded in another struct, and the larger struct is freed
> immediately after cdev_del(). For example:
> 
>     struct contains_cdev {
>             struct cdev cdev;
>     }
> 
>     void init(struct contains_cdev *cc) {
>             cdev_init(&cc->cdev);
>     }
> 
>     void cleanup(struct contains_cdev *cc) {
>             cdev_del(&cc->cdev);
>             kfree(cc);
>     }
> 
> This kind of code can reliably trigger a KASAN splat with
> CONFIG_KASAN=y and CONFIG_DEBUG_KOBJECT_RELEASE=y.
> 
> A fairly palatable workaround is replacing cdev_init() with cdev_alloc()
> and storing a pointer instead. For example, this is totally fine:
> 
>     struct contains_cdev_ptr {
>             struct cdev *cdev;
>     }
> 
>     int init(struct contains_cdev_ptr *cc) {
>             cc->cdev = cdev_alloc();
>             if (!cc->cdev) {
>                     return -ENOMEM;
>             }
> 
>             return 0;
>     }
> 
>     void cleanup(struct contains_cdev_ptr *cc) {
>             cdev_del(cc->cdev);
>             kfree(cc);
>     }
> 
> The only downside from this workaround (other than the extra allocation)
> is that container_of() upcasts no longer work. This is quite unfortunate
> for any code that implements struct file_operations and wants to store
> extra data with a struct cdev. With cdev_alloc() pointer, it's no longer
> possible to do something like:
> 
>     struct contains_cdev *cc = container_of(inode->i_cdev,
>                                             struct contains_cdev,
>                                             cdev);
> 
> Thus, I propose to add a void *private field to struct cdev so that
> callers can store a pointer to the containing struct instead of using
> container_of().
> 
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  include/linux/cdev.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/include/linux/cdev.h b/include/linux/cdev.h
> index 0e8cd6293deb..0e674e900512 100644
> --- a/include/linux/cdev.h
> +++ b/include/linux/cdev.h
> @@ -18,6 +18,7 @@ struct cdev {
>  	struct list_head list;
>  	dev_t dev;
>  	unsigned int count;
> +	void *private;

I understand your request here, but this is not how to use a cdev.  It
should be embedded in a larger structure, and then you can always "cast
out" to get the real structure here.  If you can't do that, then this
private pointer doesn't make much sense at all as it too would be
invalid.

Ideally the kobject in the cdev structure would not be used by things
"outside" of the cdev core, but that ship seems long gone.  So just rely
on the structure that this kobject protects, and you should be fine.

thanks,

greg k-h
