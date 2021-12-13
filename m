Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C77472EB4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 15:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238811AbhLMOUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 09:20:00 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34834 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbhLMOT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 09:19:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8B5E9B80EAF;
        Mon, 13 Dec 2021 14:19:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D60C34602;
        Mon, 13 Dec 2021 14:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1639405196;
        bh=G5oL15r8MfACBMd4Acl40Vokbu2uNByzt91jDIyzlS4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=r6C7sH9BeXpM3ZWMpbrtz5EUGv4/DvXWFtvpFkVgRwm586OCMYotKuqJUTwqTCk6Q
         qUhMlv2GlSiDYEVt0oGWwFBWTJdP8GNlJ6MldEJyyd8+fq1tMDX22zCuOjnUfzL2BU
         BMUyLKuLYe24bbvuLrFQLUx/2Ud4C+Akl9mfkVtg=
Date:   Mon, 13 Dec 2021 15:19:53 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Eddie Hung <eddie.hung@mediatek.com>,
        Yuwen Ng <yuwen.ng@mediatek.com>
Subject: Re: [PATCH 3/3] usb: mtu3: fix list_head check warning
Message-ID: <YbdWiYU+LJHWd4wQ@kroah.com>
References: <20211209031424.17842-1-chunfeng.yun@mediatek.com>
 <20211209031424.17842-3-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209031424.17842-3-chunfeng.yun@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 11:14:24AM +0800, Chunfeng Yun wrote:
> This is caused by uninitialization of list_head.
> 
> BUG: KASAN: use-after-free in __list_del_entry_valid+0x34/0xe4
> 
> Call trace:
> dump_backtrace+0x0/0x298
> show_stack+0x24/0x34
> dump_stack+0x130/0x1a8
> print_address_description+0x88/0x56c
> __kasan_report+0x1b8/0x2a0
> kasan_report+0x14/0x20
> __asan_load8+0x9c/0xa0
> __list_del_entry_valid+0x34/0xe4
> mtu3_req_complete+0x4c/0x300 [mtu3]
> mtu3_gadget_stop+0x168/0x448 [mtu3]
> usb_gadget_unregister_driver+0x204/0x3a0
> unregister_gadget_item+0x44/0xa4
> 
> Reported-by: Yuwen Ng <yuwen.ng@mediatek.com>
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  drivers/usb/mtu3/mtu3_gadget.c | 1 +
>  1 file changed, 1 insertion(+)

What commit does this fix?  Should it go to stable kernels?

thanks,

greg k-h
