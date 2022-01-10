Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0E27489331
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240254AbiAJIXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:23:22 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:34328 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240138AbiAJIXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:23:17 -0500
Received: by mail-ed1-f42.google.com with SMTP id u25so50379301edf.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 00:23:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MCjsaZKiElFXQ6aa4KTCJIyXot8aP7/iCBf4GFOffo8=;
        b=pGLeD1UDvu3xseYOihcKzerW6ZAdELM8hflcxdpLU5IAjMtqNxJ1RP0/9XwLlLks2R
         b5YtIhsaQ+7TKk/07GA5FoedoC7wJK8HOGVsuM7NO2RUn+Lxtuy4ru6tHsiWnopZL6Zj
         gIXSrQNNfqHkjJvvbXPjw7R7JIj7uGMK2avQw9s51NmvWNxelPKwFM0Sa/WxYV1vJyhs
         HCPp+uT9PXKXgW4JA2fZlGL0mZj9tKLysdkfIxNyeTxwIvJ7Lh/HjP+6WcaiB+31JDvD
         xHG6ob+U/43MuOl7AruA6NbvQGripPdYhH2UU0er8w9qmuFxWXnJeHDRzQWT7/+XoJEh
         iLOw==
X-Gm-Message-State: AOAM530B7nYyq0xw2ax/2LU+3MsI2kaE5rrZDyNkWoK1nZXzOxZk7IUU
        MGQj3pLh5YWl/SrGgXGYNyw=
X-Google-Smtp-Source: ABdhPJxRvuLyhPJ++tfX/SUIKHeqZktkKGiu7FVK64ep3xUSWckUOctRCjKZPrnHr/cW+X/pJNH4xg==
X-Received: by 2002:a17:906:58c9:: with SMTP id e9mr62142578ejs.30.1641802996530;
        Mon, 10 Jan 2022 00:23:16 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id dd5sm2142876ejc.59.2022.01.10.00.23.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jan 2022 00:23:16 -0800 (PST)
Message-ID: <7a6eef24-66eb-297d-8bc2-2170692018f9@kernel.org>
Date:   Mon, 10 Jan 2022 09:23:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH] tty tty_buffer: fix uninit-value in
 n_tty_receive_buf_common
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "tcs.kernel@gmail.com" <tcs.kernel@gmail.com>
Cc:     "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzbot+b68d24ad0de64bdba684@syzkaller.appspotmail.com" 
        <syzbot+b68d24ad0de64bdba684@syzkaller.appspotmail.com>
References: <20220107093058.1659772-1-tcs.kernel@gmail.com>
 <CAHp75VeeZhoHr528mij=m6uku625d5D=KNsCkgRic4Tbm4HVWQ@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <CAHp75VeeZhoHr528mij=m6uku625d5D=KNsCkgRic4Tbm4HVWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08. 01. 22, 0:24, Andy Shevchenko wrote:
> 
> 
> On Friday, January 7, 2022, <tcs.kernel@gmail.com 
> <mailto:tcs.kernel@gmail.com>> wrote:
> 
>     From: Haimin Zhang <tcs.kernel@gmail.com <mailto:tcs.kernel@gmail.com>>
> 
>     syzbot report an uninit-value issue in n_tty_receive_buf_common.
>     The root case is in the tty_buffer_reset() which in tty_buffer_alloc()
>     function, it initialized the tty_buffer struct but did not initialize
>     "data[]" points area. So we should initialize the points area to avoid
>     using dirty data.
>     The syzbot report is as follows:
> 
>     BUG: KMSAN: uninit-value in variable_test_bit
>     arch/x86/include/asm/bitops.h:214 [inline]
>     BUG: KMSAN: uninit-value in test_bit
>     include/asm-generic/bitops/instrumented-non-atomic.h:135 [inline]
>     BUG: KMSAN: uninit-value in n_tty_receive_buf_standard
>     drivers/tty/n_tty.c:1557 [inline]
>     BUG: KMSAN: uninit-value in __receive_buf drivers/tty/n_tty.c:1577
>     [inline]
>     BUG: KMSAN: uninit-value in n_tty_receive_buf_common+0x1e6c/0x10360
>     drivers/tty/n_tty.c:1674
>       variable_test_bit arch/x86/include/asm/bitops.h:214 [inline]
>       test_bit include/asm-generic/bitops/instrumented-non-atomic.h:135
>     [inline]
>       n_tty_receive_buf_standard drivers/tty/n_tty.c:1557 [inline]
>       __receive_buf drivers/tty/n_tty.c:1577 [inline]
>       n_tty_receive_buf_common+0x1e6c/0x10360 drivers/tty/n_tty.c:1674
>       n_tty_receive_buf2+0xbe/0xd0 drivers/tty/n_tty.c:1709
>       tty_ldisc_receive_buf+0x15e/0x390 drivers/tty/tty_buffer.c:471
>       tty_port_default_receive_buf+0x14b/0x1e0 drivers/tty/tty_port.c:39
>       receive_buf drivers/tty/tty_buffer.c:491 [inline]
>       flush_to_ldisc+0x5bf/0xa10 drivers/tty/tty_buffer.c:543
>       process_one_work+0xdc2/0x1820 kernel/workqueue.c:2298
>       worker_thread+0x10f1/0x2290 kernel/workqueue.c:2445
>       kthread+0x721/0x850 kernel/kthread.c:327
>       ret_from_fork+0x1f/0x30
> 
>     Uninit was created at:
>       slab_post_alloc_hook mm/slab.h:524 [inline]
>       slab_alloc_node mm/slub.c:3251 [inline]
>       slab_alloc mm/slub.c:3259 [inline]
>       __kmalloc+0xc3c/0x12d0 mm/slub.c:4437
>       kmalloc include/linux/slab.h:595 [inline]
>       tty_buffer_alloc drivers/tty/tty_buffer.c:177 [inline]
>       __tty_buffer_request_room+0x4d2/0x900 drivers/tty/tty_buffer.c:275
>       __tty_insert_flip_char+0xe5/0x3d0 drivers/tty/tty_buffer.c:392
>       tty_insert_flip_char include/linux/tty_flip.h:36 [inline]
>       uart_insert_char+0x495/0xb70 drivers/tty/serial/serial_core.c:3139
>       serial8250_read_char+0x280/0x820
>     drivers/tty/serial/8250/8250_port.c:1769
>       serial8250_rx_chars drivers/tty/serial/8250/8250_port.c:1784 [inline]
>       serial8250_handle_irq+0x540/0x980
>     drivers/tty/serial/8250/8250_port.c:1927
>       serial8250_default_handle_irq+0x18f/0x370
>     drivers/tty/serial/8250/8250_port.c:1949
>       serial8250_interrupt+0x111/0x3f0
>     drivers/tty/serial/8250/8250_core.c:126
>       __handle_irq_event_percpu+0x188/0xc90 kernel/irq/handle.c:158
>       handle_irq_event_percpu kernel/irq/handle.c:198 [inline]
>       handle_irq_event+0x188/0x420 kernel/irq/handle.c:215
>       handle_edge_irq+0x472/0x13e0 kernel/irq/chip.c:822
>       generic_handle_irq_desc include/linux/irqdesc.h:158 [inline]
>       handle_irq arch/x86/kernel/irq.c:231 [inline]
>       __common_interrupt+0xf8/0x360 arch/x86/kernel/irq.c:250
>       common_interrupt+0xb1/0xd0 arch/x86/kernel/irq.c:240
>       asm_common_interrupt+0x1e/0x40
> 
> 
> It’s rather long and noisy trace back, can you decrease it to the point, 
> please?
> 
>     Reported-by: syzbot+b68d24ad0de64bdba684@syzkaller.appspotmail.com
>     <mailto:syzbot+b68d24ad0de64bdba684@syzkaller.appspotmail.com>
>     Signed-off-by: Haimin Zhang <tcs.kernel@gmail.com
>     <mailto:tcs.kernel@gmail.com>>
>     ---
>       drivers/tty/tty_buffer.c | 1 +
>       1 file changed, 1 insertion(+)
> 
>     diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
>     index 6c7e65b1d9a1..0e7f3547d971 100644
>     --- a/drivers/tty/tty_buffer.c
>     +++ b/drivers/tty/tty_buffer.c
>     @@ -180,6 +180,7 @@ static struct tty_buffer
>     *tty_buffer_alloc(struct tty_port *port, size_t size)
> 
>       found:
>              tty_buffer_reset(p, size);
>     +       memset((char *)p + sizeof(struct tty_buffer), 0, 2 * size);
> 
> 
> I’m wondering if you may use offsetof() or other suitable macro instead 
> of this cryptic pointer arithmetic.

That memset was one of the WTFs. Why not simply p->data?

Anyway, it remains to explain why something touches the data, when the 
metadata are properly reset?

thanks,
-- 
js
suse labs
