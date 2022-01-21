Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90588495ABA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 08:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379005AbiAUHb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 02:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378998AbiAUHbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 02:31:52 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF9FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 23:31:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5BB95617AC
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 07:31:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23551C340E1;
        Fri, 21 Jan 2022 07:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642750310;
        bh=vtR/YwAdNWGjtH8j5ag/QHqghKk8vLOzrc+UOKUndDQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fL0RBll75ZLtYh/LuinuDXJcMo9mfP6JwfIlyj9G3J5hXhsw1evmbfTU+IrxguXEm
         tJ0e4Ol38j9BXIQTlPcYC0MP7DJWQ+d/LK+hQMIwPjMOFRP1o84PbzWdCjxzd0ZGLJ
         1FAQQro343RbQoJrGFzD5TOYXwo/g4zZQRBeU7JQ=
Date:   Fri, 21 Jan 2022 08:31:47 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     jirislaby@kernel.org, jcmvbkbc@gmail.com, dsterba@suse.com,
        johan@kernel.org, dankamongmen@gmail.com,
        penguin-kernel@i-love.sakura.ne.jp, igormtorrente@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tty: vt: Check for NULL pointer after calling kzalloc
Message-ID: <YephYwxThlEYRjp5@kroah.com>
References: <20220121065320.2283544-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121065320.2283544-1-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 02:53:20PM +0800, Jiasheng Jiang wrote:
> As the potential failure of the allocation, the kzalloc() will return
> NULL pointer.
> Therefore, it should be better to check it in order to avoid the
> dereference of the NULL pointer.
> When it fails, we should free all the allocated memory and return error
> number.
> To make the code more clear, I use the 'err_free', like how
> vc_allocate() deals with the allocation failure.
> 
> Fixes: a5f4f52e8211 ("vt: use kzalloc() instead of the bootmem allocator")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/tty/vt/vt.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Please note that your patches are being ignored by my email systems (I
saw this because Jiri responded to it.)  I recommend at this point in
time that all other kernel subsystem maintainers also ignore them until
you get some more experience and provide changes that work correctly and
are actually tested.

good luck,

greg k-h
