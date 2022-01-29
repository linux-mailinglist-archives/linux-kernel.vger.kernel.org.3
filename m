Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1834A2D14
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 09:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352497AbiA2I2M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 03:28:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236180AbiA2I2K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 03:28:10 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82808C061714
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 00:28:10 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id v13so15246217wrv.10
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 00:28:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=GA0NOfpEqe3qWBXSOvv5bXzkV1hAhaFI4xVLJT/VjQw=;
        b=M3PSr+boKzzuhkE347kbKzzUFNBNo9+qgDNw90wyTDUZ5sVblW8s44uCWmPZUuG7nN
         d5le4A+fJS/h+kQKw/3/veAb1RVmnz2jsP7otGQVxUWWHfVjxRDRMAWbEKIfzdID0EMq
         UgLT6gBvdyuUhOVlxqfR0ayL2s26j4DUugWIEnYvS7prow0eN4iNF7bn0ewd5kXRDQ3L
         1Go8EKKeoZ25pTc+gSnnKN0o6U4fmwlJPLgYIfqI0flt+otUMM+GEdXVMG1sBhYGbcVe
         TbpHI81nc5CTKixazjclRNis5FZoQqDWQLlaBK3qWvGexAx+vzZWVpoI2vlSXGG1YPXH
         ciEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=GA0NOfpEqe3qWBXSOvv5bXzkV1hAhaFI4xVLJT/VjQw=;
        b=Ph3ugrn/2dSLrY5vxYxBIlDSXgEYvJWhfmLIE3LDDim2Y7iKaHISEvhnMzHKEqkSEX
         RQbEyEv4cAYSs2fKzatjEKZMCa7M36Zme6x0jHTxBthc59x1JcUvDXF4M1fE69kf4G/e
         IW1NPKAfsRF7EoW3QFeTCPYnA5KiGEEQpgDAiq2tn7QAT+VMotMnsE7ZtPtSmKXVeJjJ
         Fi2QTxvMO3xqxd+Q7NzVCdeVhhVlYsgXJ+gu5e+vmvs9QeVvFB4k6HMrHxvazgakBpsO
         Lcxd+1XVkqiskcOEIJLEOPXuKHi3rleJNv0Y4I98a5LiDbSc/B/n4/W6hH2fc1iOwhIB
         mCng==
X-Gm-Message-State: AOAM532vbdnl7mVhNaQRkqfkjEVaOI0c/qLAkFkHLAybts9KfxJAuTFI
        kDPzd3m4IKU/A+zrtRWwKqFN9FG4J4U=
X-Google-Smtp-Source: ABdhPJyf80oiedkVRZRUYWxy3k4AL+v7nCEOVzF8s88hXoQ3GK+EczTGvPZGVx37GtNwGWC7rufaig==
X-Received: by 2002:a5d:598c:: with SMTP id n12mr9712824wri.29.1643444888987;
        Sat, 29 Jan 2022 00:28:08 -0800 (PST)
Received: from [10.68.0.6] ([64.64.123.28])
        by smtp.gmail.com with ESMTPSA id 6sm7874795wry.69.2022.01.29.00.28.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Jan 2022 00:28:08 -0800 (PST)
Subject: Re: [BUG] ALSA: core: possible deadlock involving waiting and locking
 operations
To:     Takashi Iwai <tiwai@suse.de>
Cc:     perex@perex.cz, tiwai@suse.com, broonie@kernel.org,
        o-takashi@sakamocchi.jp, alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <56766037-972e-9e5b-74c1-88633a72a77f@gmail.com>
 <YfTCKrjpaeKWFglO@workstation>
 <37c84cd1-80c6-cbcf-6673-d90d99501d4f@gmail.com>
 <s5hilu3eywp.wl-tiwai@suse.de>
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Message-ID: <5e068664-9c9e-271a-08a0-ea107554b1a5@gmail.com>
Date:   Sat, 29 Jan 2022 16:28:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <s5hilu3eywp.wl-tiwai@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/1/29 16:20, Takashi Iwai wrote:
> On Sat, 29 Jan 2022 09:07:05 +0100,
> Jia-Ju Bai wrote:
>>
>>
>> On 2022/1/29 12:27, Takashi Sakamoto wrote:
>>> Hi,
>>>
>>> On Sat, Jan 29, 2022 at 11:33:26AM +0800, Jia-Ju Bai wrote:
>>>> Hello,
>>>>
>>>> My static analysis tool reports a possible deadlock in the sound driver
>>>> in Linux 5.10:
>>>>
>>>> snd_card_disconnect_sync()
>>>>     spin_lock_irq(&card->files_lock); --> Line 461 (Lock A)
>>>>     wait_event_lock_irq(card->remove_sleep, ...); --> Line 462 (Wait X)
>>>>     spin_unlock_irq(&card->files_lock); --> Line 465 (Unlock A)
>>>>
>>>> snd_hwdep_release()
>>>>     mutex_lock(&hw->open_mutex); --> Line 152 (Lock B)
>>>>     mutex_unlock(&hw->open_mutex); --> Line 157 (Unlock B)
>>>>     snd_card_file_remove()
>>>>       wake_up_all(&card->remove_sleep); --> Line 976 (Wake X)
>>>>
>>>> snd_hwdep_open()
>>>>     mutex_lock(&hw->open_mutex); --> Line 95 (Lock B)
>>>>     snd_card_file_add()
>>>>       spin_lock(&card->files_lock); --> Line 932 (Lock A)
>>>>       spin_unlock(&card->files_lock); --> Line 940 (Unlock A)
>>>>     mutex_unlock(&hw->open_mutex); --> Line 139 (Unlock B)
>>>>
>>>> When snd_card_disconnect_sync() is executed, "Wait X" is performed by
>>>> holding "Lock A". If snd_hwdep_open() is executed at this time, it holds
>>>> "Lock B" and then waits for acquiring "Lock A". If snd_hwdep_release()
>>>> is executed at this time, it waits for acquiring "Lock B", and thus
>>>> "Wake X" cannot be performed to wake up "Wait X" in
>>>> snd_card_disconnect_sync(), causing a possible deadlock.
>>>>
>>>> I am not quite sure whether this possible problem is real and how to fix
>>>> it if it is real.
>>>> Any feedback would be appreciated, thanks :)
>>> I'm interested in your report about the deadlock, and seek the cause
>>> of issue. Then I realized that we should take care of the replacement of
>>> file_operation before acquiring spinlock in snd_card_disconnect_sync().
>>>
>>> ```
>>> snd_card_disconnect_sync()
>>> ->snd_card_disconnect()
>>>     ->spin_lock()
>>>     ->list_for_each_entry()
>>>       mfile->file->f_op = snd_shutdown_f_ops
>>>     ->spin_unlock()
>>> ->spin_lock_irq()
>>> ->wait_event_lock_irq()
>>> ->spin_unlock_irq()
>>> ```
>>>
>>> The implementation of snd_shutdown_f_ops has no value for .open, therefore
>>> snd_hwdep_open() is not called anymore when waiting the event. The mutex
>>> (Lock B) is not acquired in process context of ALSA hwdep application.
>>>
>>> The original .release function can be called by snd_disconnect_release()
>>> via replaced snd_shutdown_f_ops. In the case, as you can see, the spinlock
>>> (Lock A) is not acquired.
>>>
>>> I think there are no race conditions against Lock A and B in process
>>> context of ALSA hwdep application after card disconnection. But it would
>>> be probable to overlook the other case. I would be glad to receive your
>>> check for the above procedure.
>> Thanks a lot for the quick reply :)
>> Your explanation is reasonable, because snd_shutdown_f_ops indeed has
>> no value for .open.
>>
>> However, my static analysis tool finds another possible deadlock in
>> the mentioned code:
>>
>> snd_card_disconnect_sync()
>>    spin_lock_irq(&card->files_lock); --> Line 461 (Lock A)
>>    wait_event_lock_irq(card->remove_sleep, ...); --> Line 462 (Wait X)
>>    spin_unlock_irq(&card->files_lock); --> Line 465 (Unlock A)
>>
>> snd_hwdep_release()
>>    snd_card_file_remove()
>>      spin_lock(&card->files_lock); --> Line 962 (Lock A)
>>      wake_up_all(&card->remove_sleep); --> Line 976 (Wake X)
>>      spin_unlock(&card->files_lock); --> Line 977 (Unlock A)
>>
>> When snd_card_disconnect_sync() is executed, "Wait X" is performed by
>> holding "Lock A".
> No, it's wait_event_lock_irq(), and this helper unlocks the given lock
> during waiting and re-locks it after schedule().  See the macro
> expansion in include/linux/wait.h.

Oh, yes, you are right.
Sorry for this false positive...
I will improve my tool, thanks.


Best wishes,
Jia-Ju Bai
