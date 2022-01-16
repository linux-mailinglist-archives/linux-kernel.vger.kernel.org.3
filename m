Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5DB148FD57
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 15:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235407AbiAPOG3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 09:06:29 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:33429 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229785AbiAPOG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 09:06:28 -0500
Received: from [192.168.0.4] (ip5f5aeaa0.dynamic.kabel-deutschland.de [95.90.234.160])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id E839F61EA1BE4;
        Sun, 16 Jan 2022 15:06:26 +0100 (CET)
Message-ID: <7886757f-60f4-b63e-95a6-52dc7dcb86d8@molgen.mpg.de>
Date:   Sun, 16 Jan 2022 15:06:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] Bluetooth: Apply initial command workaround for more
 Intel chips
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Fernando Ramos <greenfoo@u92.eu>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Tedd Ho-Jeong An <tedd.an@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-bluetooth@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>
References: <20211202162256.31837-1-tiwai@suse.de>
 <acc7b5b4-72cc-9f3b-90a6-6fbf6c3a71e7@molgen.mpg.de>
 <s5h7dcnt0lp.wl-tiwai@suse.de> <YayVYIAi56097Ltl@zacax395.localdomain>
 <1D49EE9C-42D4-45C9-AE37-F4C508FD2D64@holtmann.org>
 <s5hk0gch9ve.wl-tiwai@suse.de>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <s5hk0gch9ve.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Dear Takashi,


Am 10.12.21 um 14:23 schrieb Takashi Iwai:
> On Tue, 07 Dec 2021 17:14:02 +0100, Marcel Holtmann wrote:

>>>> Thanks, so this seems depending on the hardware, maybe a subtle
>>>> difference matters.  As far as I read the code changes, the workaround
>>>> was applied in the past unconditionally, so it must be fairly safe
>>>> even if the chip works as is.
>>>>
>>>> Or, for avoiding the unnecessarily application of the workaround,
>>>> should it be changed as a fallback after the failure at the first
>>>> try...?
>>>
>>> I don't know if this helps, but I started experiencing this same issue ("hci0:
>>> command 0xfc05 tx timeout") yesterday after a kernel upgrade.
>>>
>>> My controller is a different one:
>>>
>>>     8087:0025 Intel Corp. Wireless-AC 9260 Bluetooth Adapter
>>>     ^^^^^^^^^
>>>
>>> I tried with different (older) versions of the v5.15.x kernel but none worked.
>>>
>>> Now, this is the interesting (?) part: today, when I switched on the computer
>>> to keep testing, the bluetooth was *already* working once again.
>>>
>>> I have reviewed my bash history to try to figure out what is it that I did, and
>>> the only thing I see is that yesterday, before going to sleep, I did a full
>>> poweroff instead of a reset (which is what I used yesterday to try different
>>> kernels).
>>>
>>> This does not make any sense... but then I found this [1] post from someone else
>>> who experienced the same.
>>>
>>> Is there any reasonable explanation for this? Could this be the reason why you
>>> seem to have different results with the same controller (8087:0a2a)?
>>
>> we trying to figure out what went wrong here. This should be really only an
>> issue on the really early Intel hardware like Wilkens Peak. However it seems
>> it slipped into later parts now as well. We are investigating what happened >> and see if this can be fixed via a firmware update or if we really 
have to
>> mark this hardware as having a broken boot loader.
> 
> The upstream bugzilla indicates that 8087:0aa7 seems hitting the same
> problem:
>    https://bugzilla.kernel.org/show_bug.cgi?id=215167
> 
> OTOH, on openSUSE Bugzilla, there has been a report that applying the
> workaround for 8087:0026 may cause another issue about the reset
> error, so the entry for 8087:0026 should be dropped.

Can you confirm that commit 95655456e7ce (Bluetooth: btintel: Fix broken 
LED quirk for legacy ROM devices) [1] merged in the current Linux 5.17 
cycle this week fixed the issue?


Kind regards,

Paul


[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=95655456e7cee858a23793f67025765b4c4c227b
