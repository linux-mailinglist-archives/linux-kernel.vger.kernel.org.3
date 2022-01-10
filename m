Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E425B489455
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242149AbiAJIyE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:54:04 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41352 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242461AbiAJIv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:51:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55739B81203
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 08:51:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95DA0C36AE9;
        Mon, 10 Jan 2022 08:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1641804713;
        bh=GNvWBWA/INoGx2mwXRgT6H3UxnSfJ+bXQ3cFyB/K62s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fQVHQx+8c/WS61UjxI35WWwrjrkUuxp0CSH0SpsWqBtprI/xs4SYs6XzmGzjHIUFL
         hFJ2hl2chCPdXsrGNisv4hjBtdcGE/9VkNfS3kx180hD8CLPxUsGODbWq+vvtieimm
         Ur0dpDTEgBZA65xg7xghJcwO8gHMuqo2g20qJ42U=
Date:   Mon, 10 Jan 2022 09:51:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     tcs.kernel@gmail.com
Cc:     jirislaby@kernel.org, linux-kernel@vger.kernel.org,
        syzbot+b68d24ad0de64bdba684@syzkaller.appspotmail.com
Subject: Re: [PATCH] tty tty_buffer: fix uninit-value in
 n_tty_receive_buf_common
Message-ID: <YdvzphVl+tsNyixD@kroah.com>
References: <20220107093058.1659772-1-tcs.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107093058.1659772-1-tcs.kernel@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 07, 2022 at 05:30:58PM +0800, tcs.kernel@gmail.com wrote:
> From: Haimin Zhang <tcs.kernel@gmail.com>
> 
> syzbot report an uninit-value issue in n_tty_receive_buf_common.
> The root case is in the tty_buffer_reset() which in tty_buffer_alloc()
> function, it initialized the tty_buffer struct but did not initialize 
> "data[]" points area. So we should initialize the points area to avoid
> using dirty data.

Why?  The data is not really "dirty", it is just data that the driver
used in the past.  The driver should always overwrite it with it's own
data anyway, it does not care what is in the buffer to start with.

As "proof" of this, look a few lines up from your change, the buffer is
allocated with kmalloc() just fine, not kzalloc(), right?  :)

Is this data getting sent to userspace somehow with stale data?  If so,
what tty driver is doing that?

> The syzbot report is as follows:
> 
> BUG: KMSAN: uninit-value in variable_test_bit arch/x86/include/asm/bitops.h:214 [inline]
> BUG: KMSAN: uninit-value in test_bit include/asm-generic/bitops/instrumented-non-atomic.h:135 [inline]
> BUG: KMSAN: uninit-value in n_tty_receive_buf_standard drivers/tty/n_tty.c:1557 [inline]
> BUG: KMSAN: uninit-value in __receive_buf drivers/tty/n_tty.c:1577 [inline]
> BUG: KMSAN: uninit-value in n_tty_receive_buf_common+0x1e6c/0x10360 drivers/tty/n_tty.c:1674
>  variable_test_bit arch/x86/include/asm/bitops.h:214 [inline]
>  test_bit include/asm-generic/bitops/instrumented-non-atomic.h:135 [inline]
>  n_tty_receive_buf_standard drivers/tty/n_tty.c:1557 [inline]
>  __receive_buf drivers/tty/n_tty.c:1577 [inline]
>  n_tty_receive_buf_common+0x1e6c/0x10360 drivers/tty/n_tty.c:1674
>  n_tty_receive_buf2+0xbe/0xd0 drivers/tty/n_tty.c:1709
>  tty_ldisc_receive_buf+0x15e/0x390 drivers/tty/tty_buffer.c:471
>  tty_port_default_receive_buf+0x14b/0x1e0 drivers/tty/tty_port.c:39
>  receive_buf drivers/tty/tty_buffer.c:491 [inline]
>  flush_to_ldisc+0x5bf/0xa10 drivers/tty/tty_buffer.c:543
>  process_one_work+0xdc2/0x1820 kernel/workqueue.c:2298
>  worker_thread+0x10f1/0x2290 kernel/workqueue.c:2445
>  kthread+0x721/0x850 kernel/kthread.c:327
>  ret_from_fork+0x1f/0x30

Are you sure the the tool is correct here?  If so, how come the
kmalloc() allocation does not trigger a report here?



> 
> Uninit was created at:
>  slab_post_alloc_hook mm/slab.h:524 [inline]
>  slab_alloc_node mm/slub.c:3251 [inline]
>  slab_alloc mm/slub.c:3259 [inline]
>  __kmalloc+0xc3c/0x12d0 mm/slub.c:4437
>  kmalloc include/linux/slab.h:595 [inline]
>  tty_buffer_alloc drivers/tty/tty_buffer.c:177 [inline]
>  __tty_buffer_request_room+0x4d2/0x900 drivers/tty/tty_buffer.c:275
>  __tty_insert_flip_char+0xe5/0x3d0 drivers/tty/tty_buffer.c:392
>  tty_insert_flip_char include/linux/tty_flip.h:36 [inline]
>  uart_insert_char+0x495/0xb70 drivers/tty/serial/serial_core.c:3139
>  serial8250_read_char+0x280/0x820 drivers/tty/serial/8250/8250_port.c:1769
>  serial8250_rx_chars drivers/tty/serial/8250/8250_port.c:1784 [inline]
>  serial8250_handle_irq+0x540/0x980 drivers/tty/serial/8250/8250_port.c:1927
>  serial8250_default_handle_irq+0x18f/0x370 drivers/tty/serial/8250/8250_port.c:1949
>  serial8250_interrupt+0x111/0x3f0 drivers/tty/serial/8250/8250_core.c:126
>  __handle_irq_event_percpu+0x188/0xc90 kernel/irq/handle.c:158
>  handle_irq_event_percpu kernel/irq/handle.c:198 [inline]
>  handle_irq_event+0x188/0x420 kernel/irq/handle.c:215
>  handle_edge_irq+0x472/0x13e0 kernel/irq/chip.c:822
>  generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
>  handle_irq arch/x86/kernel/irq.c:231 [inline]
>  __common_interrupt+0xf8/0x360 arch/x86/kernel/irq.c:250
>  common_interrupt+0xb1/0xd0 arch/x86/kernel/irq.c:240
>  asm_common_interrupt+0x1e/0x40
> 
> Reported-by: syzbot+b68d24ad0de64bdba684@syzkaller.appspotmail.com
> Signed-off-by: Haimin Zhang <tcs.kernel@gmail.com>
> ---
>  drivers/tty/tty_buffer.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> index 6c7e65b1d9a1..0e7f3547d971 100644
> --- a/drivers/tty/tty_buffer.c
> +++ b/drivers/tty/tty_buffer.c
> @@ -180,6 +180,7 @@ static struct tty_buffer *tty_buffer_alloc(struct tty_port *port, size_t size)
>  
>  found:
>  	tty_buffer_reset(p, size);
> +	memset((char *)p + sizeof(struct tty_buffer), 0, 2 * size);

As others have pointed out, this is a crazy line to try to understand,
and could be made simpler.  If it were even needed, which I do not think
it is.

thanks,

greg k-h
