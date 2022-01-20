Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B158495015
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 15:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345974AbiATO01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 09:26:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345906AbiATO00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 09:26:26 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECA9AC061574;
        Thu, 20 Jan 2022 06:26:25 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nAYOL-0000pr-IY; Thu, 20 Jan 2022 15:26:21 +0100
Message-ID: <6c194b50-84f6-a554-140c-174cb658813a@leemhuis.info>
Date:   Thu, 20 Jan 2022 15:26:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH] Bluetooth: Apply initial command workaround for more
 Intel chips
Content-Language: en-BZ
To:     Paul Menzel <pmenzel@molgen.mpg.de>, Takashi Iwai <tiwai@suse.de>
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
 <7886757f-60f4-b63e-95a6-52dc7dcb86d8@molgen.mpg.de>
From:   Thorsten Leemhuis <linux@leemhuis.info>
In-Reply-To: <7886757f-60f4-b63e-95a6-52dc7dcb86d8@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1642688786;2a394a0f;
X-HE-SMSGID: 1nAYOL-0000pr-IY
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking.

Top-posting for once, to make this easy accessible to everyone.

Could the bluetooth maintainers please provide a status update? I wonder
if it's time to bring this regression to Linus attention, as it seems to
be an issue that hits quite a few users -- and at the same takes quite a
long time to get fixed for a issue where a patch with a workaround was
already proposed one and a half months ago.

Ciao, Thorsten

On 16.01.22 15:06, Paul Menzel wrote:
> 
> Dear Takashi,
> 
> 
> Am 10.12.21 um 14:23 schrieb Takashi Iwai:
>> On Tue, 07 Dec 2021 17:14:02 +0100, Marcel Holtmann wrote:
> 
>>>>> Thanks, so this seems depending on the hardware, maybe a subtle
>>>>> difference matters.  As far as I read the code changes, the workaround
>>>>> was applied in the past unconditionally, so it must be fairly safe
>>>>> even if the chip works as is.
>>>>>
>>>>> Or, for avoiding the unnecessarily application of the workaround,
>>>>> should it be changed as a fallback after the failure at the first
>>>>> try...?
>>>>
>>>> I don't know if this helps, but I started experiencing this same
>>>> issue ("hci0:
>>>> command 0xfc05 tx timeout") yesterday after a kernel upgrade.
>>>>
>>>> My controller is a different one:
>>>>
>>>>     8087:0025 Intel Corp. Wireless-AC 9260 Bluetooth Adapter
>>>>     ^^^^^^^^^
>>>>
>>>> I tried with different (older) versions of the v5.15.x kernel but
>>>> none worked.
>>>>
>>>> Now, this is the interesting (?) part: today, when I switched on the
>>>> computer
>>>> to keep testing, the bluetooth was *already* working once again.
>>>>
>>>> I have reviewed my bash history to try to figure out what is it that
>>>> I did, and
>>>> the only thing I see is that yesterday, before going to sleep, I did
>>>> a full
>>>> poweroff instead of a reset (which is what I used yesterday to try
>>>> different
>>>> kernels).
>>>>
>>>> This does not make any sense... but then I found this [1] post from
>>>> someone else
>>>> who experienced the same.
>>>>
>>>> Is there any reasonable explanation for this? Could this be the
>>>> reason why you
>>>> seem to have different results with the same controller (8087:0a2a)?
>>>
>>> we trying to figure out what went wrong here. This should be really
>>> only an
>>> issue on the really early Intel hardware like Wilkens Peak. However
>>> it seems
>>> it slipped into later parts now as well. We are investigating what
>>> happened >> and see if this can be fixed via a firmware update or if
>>> we really 
> have to
>>> mark this hardware as having a broken boot loader.
>>
>> The upstream bugzilla indicates that 8087:0aa7 seems hitting the same
>> problem:
>>    https://bugzilla.kernel.org/show_bug.cgi?id=215167
>>
>> OTOH, on openSUSE Bugzilla, there has been a report that applying the
>> workaround for 8087:0026 may cause another issue about the reset
>> error, so the entry for 8087:0026 should be dropped.
> 
> Can you confirm that commit 95655456e7ce (Bluetooth: btintel: Fix broken
> LED quirk for legacy ROM devices) [1] merged in the current Linux 5.17
> cycle this week fixed the issue?
> 
> 
> Kind regards,
> 
> Paul
> 
> 
> [1]:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=95655456e7cee858a23793f67025765b4c4c227b
> 

