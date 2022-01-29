Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2764A2CB9
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 09:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245071AbiA2IHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 03:07:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241955AbiA2IHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 03:07:12 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D28C061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 00:07:11 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id k18so15199746wrg.11
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 00:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=QGqCLwrYCOsLTLWxlsYjHAKL7s07BhHpkbZ0BHayhEY=;
        b=XXhQLm4XFpK3TEqUu6oVnTKrNXWyDVZ19MGKTRDv/YMl8p4WAUmNbBD1IxTMPQi1/Q
         7zUeRdI3tGgsJvTeMZTZgK3ls+Cghokr/ZIIrWGfC321V/NgNm7HqcsQHjr5hCrozLiE
         ctasMt1p8lnwt5z5QNqSV1xcpS2lLImSqvwtK5aJIOe7f4rAMQabXTKJ9E5R71Sqe4Zy
         NKeZQYipRj6+BRrOEOeGZvgM7+JdFVlBZvfTd+kUaOu8HZsBAD6scwriB720tyhv2D0k
         f3PdjRp+ZU3hnh23J5SYKhKZryk5+HD5tsR30y6YhHA05y/y+kJR424vaM27JljQskZg
         4L5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=QGqCLwrYCOsLTLWxlsYjHAKL7s07BhHpkbZ0BHayhEY=;
        b=Twi0JfeQ4sV4IoQwl6WZXa/lqa7DvapcwThUfSXEAOfrKLchsp8nNygnzxqtWHv0f6
         CU9CcKfb9c5skfqLz+vP+OY1S4QG+7cwe6JlHQDv9sdkhBdj6oMiKJqGLBmIy3IzAc+2
         GC2BaCbEYv07PjXm4AzI67EbpWPh2lnNCzEEzwOaGOW9EaOd2AMKfFA9JOePqMcCKymx
         LH7ro2FQvDvTCVOqEj+IIyIUSVgX9nAmYt7q8N+Mfcbh5YIexmVQCup3eQWqtbog4xlR
         HgjxfRi1MHuvmOp1ie7UFHEF9rxykgN6TXcapFeO10e0cvzTRdA/VskSIQwpgdN+qDVD
         D2ag==
X-Gm-Message-State: AOAM53368aTWOsMmembr9LcGiN1SOSFXualayoiIawmUMvKWKu6zOb+p
        eavsXS+DJgedRKZhJmxUrTo37rNAlcU=
X-Google-Smtp-Source: ABdhPJy2Kz0Ejxy8IE6Nkx/AeK5mYYZno6b45FJq7Ugm4sukeGrRfzbYnJWcFIqqwqkjXvXPhGh2bA==
X-Received: by 2002:adf:de83:: with SMTP id w3mr9591722wrl.181.1643443630198;
        Sat, 29 Jan 2022 00:07:10 -0800 (PST)
Received: from [10.68.0.6] ([64.64.123.28])
        by smtp.gmail.com with ESMTPSA id n2sm7460545wrw.63.2022.01.29.00.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jan 2022 00:07:09 -0800 (PST)
Subject: Re: [BUG] ALSA: core: possible deadlock involving waiting and locking
 operations
To:     perex@perex.cz, tiwai@suse.com, broonie@kernel.org,
        o-takashi@sakamocchi.jp
References: <56766037-972e-9e5b-74c1-88633a72a77f@gmail.com>
 <YfTCKrjpaeKWFglO@workstation>
Cc:     alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <37c84cd1-80c6-cbcf-6673-d90d99501d4f@gmail.com>
Date:   Sat, 29 Jan 2022 16:07:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <YfTCKrjpaeKWFglO@workstation>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/1/29 12:27, Takashi Sakamoto wrote:
> Hi,
>
> On Sat, Jan 29, 2022 at 11:33:26AM +0800, Jia-Ju Bai wrote:
>> Hello,
>>
>> My static analysis tool reports a possible deadlock in the sound driver
>> in Linux 5.10:
>>
>> snd_card_disconnect_sync()
>>    spin_lock_irq(&card->files_lock); --> Line 461 (Lock A)
>>    wait_event_lock_irq(card->remove_sleep, ...); --> Line 462 (Wait X)
>>    spin_unlock_irq(&card->files_lock); --> Line 465 (Unlock A)
>>
>> snd_hwdep_release()
>>    mutex_lock(&hw->open_mutex); --> Line 152 (Lock B)
>>    mutex_unlock(&hw->open_mutex); --> Line 157 (Unlock B)
>>    snd_card_file_remove()
>>      wake_up_all(&card->remove_sleep); --> Line 976 (Wake X)
>>
>> snd_hwdep_open()
>>    mutex_lock(&hw->open_mutex); --> Line 95 (Lock B)
>>    snd_card_file_add()
>>      spin_lock(&card->files_lock); --> Line 932 (Lock A)
>>      spin_unlock(&card->files_lock); --> Line 940 (Unlock A)
>>    mutex_unlock(&hw->open_mutex); --> Line 139 (Unlock B)
>>
>> When snd_card_disconnect_sync() is executed, "Wait X" is performed by
>> holding "Lock A". If snd_hwdep_open() is executed at this time, it holds
>> "Lock B" and then waits for acquiring "Lock A". If snd_hwdep_release()
>> is executed at this time, it waits for acquiring "Lock B", and thus
>> "Wake X" cannot be performed to wake up "Wait X" in
>> snd_card_disconnect_sync(), causing a possible deadlock.
>>
>> I am not quite sure whether this possible problem is real and how to fix
>> it if it is real.
>> Any feedback would be appreciated, thanks :)
> I'm interested in your report about the deadlock, and seek the cause
> of issue. Then I realized that we should take care of the replacement of
> file_operation before acquiring spinlock in snd_card_disconnect_sync().
>
> ```
> snd_card_disconnect_sync()
> ->snd_card_disconnect()
>    ->spin_lock()
>    ->list_for_each_entry()
>      mfile->file->f_op = snd_shutdown_f_ops
>    ->spin_unlock()
> ->spin_lock_irq()
> ->wait_event_lock_irq()
> ->spin_unlock_irq()
> ```
>
> The implementation of snd_shutdown_f_ops has no value for .open, therefore
> snd_hwdep_open() is not called anymore when waiting the event. The mutex
> (Lock B) is not acquired in process context of ALSA hwdep application.
>
> The original .release function can be called by snd_disconnect_release()
> via replaced snd_shutdown_f_ops. In the case, as you can see, the spinlock
> (Lock A) is not acquired.
>
> I think there are no race conditions against Lock A and B in process
> context of ALSA hwdep application after card disconnection. But it would
> be probable to overlook the other case. I would be glad to receive your
> check for the above procedure.

Thanks a lot for the quick reply :)
Your explanation is reasonable, because snd_shutdown_f_ops indeed has no 
value for .open.

However, my static analysis tool finds another possible deadlock in the 
mentioned code:

snd_card_disconnect_sync()
   spin_lock_irq(&card->files_lock); --> Line 461 (Lock A)
   wait_event_lock_irq(card->remove_sleep, ...); --> Line 462 (Wait X)
   spin_unlock_irq(&card->files_lock); --> Line 465 (Unlock A)

snd_hwdep_release()
   snd_card_file_remove()
     spin_lock(&card->files_lock); --> Line 962 (Lock A)
     wake_up_all(&card->remove_sleep); --> Line 976 (Wake X)
     spin_unlock(&card->files_lock); --> Line 977 (Unlock A)

When snd_card_disconnect_sync() is executed, "Wait X" is performed by 
holding "Lock A". If snd_hwdep_release() is executed at this time, "Wake 
X" cannot be performed to wake up "Wait X", because "Lock A" has been 
already hold by snd_card_disconnect_sync().

I am not quite sure whether this possible problem is real.
Any feedback would be appreciated, thanks :)


Best wishes,
Jia-Ju Bai
