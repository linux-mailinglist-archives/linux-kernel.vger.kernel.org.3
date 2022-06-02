Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA1753B2CB
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 06:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiFBEsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 00:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiFBEse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 00:48:34 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB67F2823E0
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 21:48:32 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id q7so4866220wrg.5
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 21:48:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AUkIrxS+XdWPb8Cp2nIkEd8cc/NScUdoM6o1x+2YUu4=;
        b=H+I3KPaKDu2vAXMm81hwAZN7P1ijnyOot4dMUNopd7KYMmy4j+jd0irgEnExJN1p81
         NHSIGXguPJZ6PpGdLfjOR+jWpomfF3xgJ/5cXbfOu+N97pGbwv1rLHNJ2EVzQPdej8X3
         6+cWkqixkBWXJh4LXSP2D1YQUo2mJRZ+zNHlZBGZCSGGsITnVCDV22Q5AAn20TtXVOgX
         3Y+ZZb78/fkspl0SFxvNHgZtdlSlWp8xN08PR4ulJ8zATCuEeBZOoR/azZT96yX3ikDU
         hb3nw/zklQvYxoO+u0Bthe28nelE8CD8O74cycmlmee+sVKg5GBoxPorzuBUxkdc82VQ
         bLTA==
X-Gm-Message-State: AOAM531Ccat/lwneJPmJpAMlZGeqtRbO7YH/piM3iMOX+s7WOzBn9rec
        xBRMlzbFW97B3prr8SncZF5twBm9D/Zlkw==
X-Google-Smtp-Source: ABdhPJyIz/NVsaPw8UNBIeCQcB01t4PENq2t2NN6Gs2dK1ZUgPkErt1toDQjfelA+6K+mFXYkh2bTw==
X-Received: by 2002:a5d:40c7:0:b0:210:3135:e662 with SMTP id b7-20020a5d40c7000000b002103135e662mr1954347wrq.280.1654145311366;
        Wed, 01 Jun 2022 21:48:31 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id r184-20020a1c2bc1000000b0039768532c79sm4083788wmr.6.2022.06.01.21.48.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jun 2022 21:48:30 -0700 (PDT)
Message-ID: <0dc35f2e-746c-bcec-160c-645055a6f8d2@kernel.org>
Date:   Thu, 2 Jun 2022 06:48:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: CVE-2022-1462: race condition vulnerability in
 drivers/tty/tty_buffers.c
Content-Language: en-US
To:     Hillf Danton <hdanton@sina.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     ChenBigNB <chennbnbnb@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220602024857.4808-1-hdanton@sina.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220602024857.4808-1-hdanton@sina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02. 06. 22, 4:48, Hillf Danton wrote:
> On Wed, 1 Jun 2022 21:34:26 +0300 Dan Carpenter wrote:
>> Hi Greg, Jiri,
>>
>> I searched lore.kernel.org and it seemed like CVE-2022-1462 might not
>> have ever been reported to you?  Here is the original email with the
>> syzkaller reproducer.
>>
>> https://seclists.org/oss-sec/2022/q2/155
>>
>> The reporter proposed a fix, but it won't work.  Smatch says that some
>> of the callers are already holding the port->lock.  For example,
>> sci_dma_rx_complete() will deadlock.
> 
> Hi Dan
> 
> To erase the deadlock above, we need to add another helper folding
> tty_insert_flip_string() and tty_flip_buffer_push() into one nutshell,
> with buf->tail covered by port->lock.
> 
> The diff attached in effect reverts
> 71a174b39f10 ("pty: do tty_flip_buffer_push without port->lock in pty_write").
> 
> Only for thoughts now.

I think this the likely the best approach. Except few points inlined below.

Another would be to split tty_flip_buffer_push() into two and call only 
the first one (doing smp_store_release()) inside the lock. I tried that 
already, but it looks much worse.

Another would be to add flags to tty_flip_buffer_push(). Like 
ONLY_ADVANCE and ONLY_QUEUE. Call with the first under the lock, the 
second outside.

Ideas, comments?

> Hillf
> 
> +++ b/drivers/tty/pty.c
> @@ -116,15 +116,8 @@ static int pty_write(struct tty_struct *
>   	if (tty->flow.stopped)
>   		return 0;
>   
> -	if (c > 0) {
> -		spin_lock_irqsave(&to->port->lock, flags);
> -		/* Stuff the data into the input queue of the other end */
> -		c = tty_insert_flip_string(to->port, buf, c);
> -		spin_unlock_irqrestore(&to->port->lock, flags);
> -		/* And shovel */
> -		if (c)
> -			tty_flip_buffer_push(to->port);
> -	}
> +	if (c > 0)
> +		c = tty_flip_insert_and_push_buffer(to->port, buf, c);
>   	return c;
>   }
>   
> +++ b/drivers/tty/tty_buffer.c
> @@ -554,6 +554,26 @@ void tty_flip_buffer_push(struct tty_por
>   }
>   EXPORT_SYMBOL(tty_flip_buffer_push);
>   
> +int tty_flip_insert_and_push_buffer(struct tty_port *port, const unsigned char *string, int cnt)

It should be _insert_string_, IMO.

> +{
> +	struct tty_bufhead *buf = &port->buf;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +	cnt = tty_insert_flip_string(port, string, cnt);
> +	if (cnt) {
> +		/*
> +		 * Paired w/ acquire in flush_to_ldisc(); ensures flush_to_ldisc() sees
> +		 * buffer data.
> +		 */
> +		smp_store_release(&buf->tail->commit, buf->tail->used);
> +	}
> +	spin_unlock_irqrestore(&port->lock, flags);
> +	queue_work(system_unbound_wq, &buf->work);

\n here please.

> +	return cnt;
> +}
> +EXPORT_SYMBOL(tty_flip_insert_and_push_buffer);

No need to export this, right?

thanks,
-- 
js
suse labs
