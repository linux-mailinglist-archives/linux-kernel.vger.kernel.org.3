Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBC154C674
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 12:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347533AbiFOKrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 06:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347479AbiFOKr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:47:27 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48DF352B17
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:47:24 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id w17so7295023wrg.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 03:47:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=mNHpgWeKV74aPRzSS+IzpuYFhYnFvrxkOM3S9oKNbvw=;
        b=D04UrYlM6D15gfDb+rCa+2aSwqy1OpPAiJNhRICko6fZm9HeK0zGjVnudiuKQZDIB7
         HRg9lHgvmihEmKvD3viBNB6HSCGaXWy/qxIhew65+7NAV2s0v6CpNu6yEGaetsbpnLIp
         TGyqmJtnt983GALJ/6/peWuV6ieIcOL9VA87x+Fpe5Zh3O+kikexnpXOYF8/6VVwuZx4
         Io0Rn8yZLBuE5IVFxCYHKbpDm/MAmA4LVsSQPixXECq7khVvgaysynZkyHbyrbSTB8Om
         0jH9Wm9XYoW/pNhYvJaYk7lc/6CwXesH2qiQxNC5ZL8YEPbGT/SkF+vYKgybjKWCOHHe
         JR5A==
X-Gm-Message-State: AJIora+cumWfey/bAArL0IWGlrpn+VA0E8YMkasbN7Yb5zoAGhBCmvhC
        cuEjPMDP+bEXkIdKxLcFekw=
X-Google-Smtp-Source: AGRyM1tj4rfhtxmvDHlvh0ad6efQQc+LKj6kjYWp3ht8Gzl7ulZ0x+5AocUzy3whYj1DTvDaoTrvew==
X-Received: by 2002:adf:e991:0:b0:210:3222:cd1e with SMTP id h17-20020adfe991000000b002103222cd1emr9667729wrm.49.1655290042590;
        Wed, 15 Jun 2022 03:47:22 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id z12-20020a5d44cc000000b00219e758ff4fsm14398933wrr.59.2022.06.15.03.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Jun 2022 03:47:21 -0700 (PDT)
Message-ID: <ca7fdc92-b94e-56e8-3d4a-739535cdf8c3@kernel.org>
Date:   Wed, 15 Jun 2022 12:47:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: CVE-2022-1462: race condition vulnerability in
 drivers/tty/tty_buffers.c
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
To:     Hillf Danton <hdanton@sina.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     ChenBigNB <chennbnbnb@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220602024857.4808-1-hdanton@sina.com>
 <0dc35f2e-746c-bcec-160c-645055a6f8d2@kernel.org>
In-Reply-To: <0dc35f2e-746c-bcec-160c-645055a6f8d2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02. 06. 22, 6:48, Jiri Slaby wrote:
> On 02. 06. 22, 4:48, Hillf Danton wrote:
>> On Wed, 1 Jun 2022 21:34:26 +0300 Dan Carpenter wrote:
>>> Hi Greg, Jiri,
>>>
>>> I searched lore.kernel.org and it seemed like CVE-2022-1462 might not
>>> have ever been reported to you?  Here is the original email with the
>>> syzkaller reproducer.
>>>
>>> https://seclists.org/oss-sec/2022/q2/155
>>>
>>> The reporter proposed a fix, but it won't work.  Smatch says that some
>>> of the callers are already holding the port->lock.  For example,
>>> sci_dma_rx_complete() will deadlock.
>>
>> Hi Dan
>>
>> To erase the deadlock above, we need to add another helper folding
>> tty_insert_flip_string() and tty_flip_buffer_push() into one nutshell,
>> with buf->tail covered by port->lock.
>>
>> The diff attached in effect reverts
>> 71a174b39f10 ("pty: do tty_flip_buffer_push without port->lock in 
>> pty_write").
>>
>> Only for thoughts now.
> 
> I think this the likely the best approach. Except few points inlined below.
> 
> Another would be to split tty_flip_buffer_push() into two and call only 
> the first one (doing smp_store_release()) inside the lock. I tried that 
> already, but it looks much worse.
> 
> Another would be to add flags to tty_flip_buffer_push(). Like 
> ONLY_ADVANCE and ONLY_QUEUE. Call with the first under the lock, the 
> second outside.
> 
> Ideas, comments?

Apparently not, so Hillf, could you resend your patch after fixing the 
comments below?

Thanks.

>> Hillf
>>
>> +++ b/drivers/tty/pty.c
>> @@ -116,15 +116,8 @@ static int pty_write(struct tty_struct *
>>       if (tty->flow.stopped)
>>           return 0;
>> -    if (c > 0) {
>> -        spin_lock_irqsave(&to->port->lock, flags);
>> -        /* Stuff the data into the input queue of the other end */
>> -        c = tty_insert_flip_string(to->port, buf, c);
>> -        spin_unlock_irqrestore(&to->port->lock, flags);
>> -        /* And shovel */
>> -        if (c)
>> -            tty_flip_buffer_push(to->port);
>> -    }
>> +    if (c > 0)
>> +        c = tty_flip_insert_and_push_buffer(to->port, buf, c);
>>       return c;
>>   }
>> +++ b/drivers/tty/tty_buffer.c
>> @@ -554,6 +554,26 @@ void tty_flip_buffer_push(struct tty_por
>>   }
>>   EXPORT_SYMBOL(tty_flip_buffer_push);
>> +int tty_flip_insert_and_push_buffer(struct tty_port *port, const 
>> unsigned char *string, int cnt)
> 
> It should be _insert_string_, IMO.
> 
>> +{
>> +    struct tty_bufhead *buf = &port->buf;
>> +    unsigned long flags;
>> +
>> +    spin_lock_irqsave(&port->lock, flags);
>> +    cnt = tty_insert_flip_string(port, string, cnt);
>> +    if (cnt) {
>> +        /*
>> +         * Paired w/ acquire in flush_to_ldisc(); ensures 
>> flush_to_ldisc() sees
>> +         * buffer data.
>> +         */
>> +        smp_store_release(&buf->tail->commit, buf->tail->used);
>> +    }
>> +    spin_unlock_irqrestore(&port->lock, flags);
>> +    queue_work(system_unbound_wq, &buf->work);
> 
> \n here please.
> 
>> +    return cnt;
>> +}
>> +EXPORT_SYMBOL(tty_flip_insert_and_push_buffer);
> 
> No need to export this, right?
> 
> thanks,


-- 
js
suse labs
