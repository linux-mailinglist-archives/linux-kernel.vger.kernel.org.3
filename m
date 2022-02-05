Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93BB44AA4E1
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 01:04:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378650AbiBEAEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 19:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378429AbiBEAEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 19:04:22 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97868DF8C1BD;
        Fri,  4 Feb 2022 16:04:21 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id h20-20020a17090adb9400b001b518bf99ffso14532579pjv.1;
        Fri, 04 Feb 2022 16:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=DRNBcJ7tyUEYbzPE/bD5g3O69Rw7v+yqrMrOhptcKjo=;
        b=H+U8+aKZgVvUQkKPAwuvuwzBR7X6nZwv/TeOHzGTPpgSj1ISLlwkBkB+ZBiY1HNLqx
         FaYfjTkikBweTmgFJw66b22e7SBzGbzdPN6zM26NgiOvgRxwofZ31iE3hx7VVquO7tnd
         ikeHZxfL10JsA9leW6W1IO2x9oCdUIt57/s4C3TFz23krgGvgA+WEOd/FtTK78mPGBq8
         CQIPWzoo4W5ywVEpGutnGHF87+2TX64rbVbdkhx362IYydVOkHmub5wk3T85xzLqG2sv
         5IH02eZzRwt8t/z7uCrJ+ukN/ip4ZrZ8PILrSD0QNfb6DxTUym0g1ZOLzNpqlw073K/u
         Edlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=DRNBcJ7tyUEYbzPE/bD5g3O69Rw7v+yqrMrOhptcKjo=;
        b=XhwSCSkGfVMB+bjxnU18MeCMh/TfdK4o6dycfTw70X+c3nuFowHoXknUo6vBZf1GPN
         oDlo/GLenuqL5HTY1C394MRsv4R8Wfxa6YSEsHddF2NDGOgrw/qSLyf63RkA28+TSCLs
         GteZOKMn1aaWhD1Tu2i31g9uPlYEtrFKG7f1JDuo8Lv3joLe54R6S1TSDTtbL8gsXtX8
         lHBnJFuY0j+Ae91bxDl4/h6uyXc3njW6/UM6F0LpObqu7lOGaH6eubwy1VCpsLv+ZuNM
         0lWt5xHjV6/rS/4hO6+ewDIYyzRWF6jOJp9aV1x9ja5Diz/9dn/ddxJxx7sAgbc5CSuH
         0Ptg==
X-Gm-Message-State: AOAM532YJW2sPyMJFsJ7GQ5dtlB1b7JB/Us0vLprXdjDS4q/V6VYOVzj
        dCYaXuecFeRsg6bDeIxw/x4pA7CUlog=
X-Google-Smtp-Source: ABdhPJznWNFtayTxbEnsBFukX098ns64Jg56oDRElSRQRriFAvOB755XGzWP2mcFUBtyWXHOgRYh0w==
X-Received: by 2002:a17:90b:4a06:: with SMTP id kk6mr1668336pjb.204.1644019460757;
        Fri, 04 Feb 2022 16:04:20 -0800 (PST)
Received: from [10.1.1.24] (222-155-5-102-adsl.sparkbb.co.nz. [222.155.5.102])
        by smtp.gmail.com with ESMTPSA id y12sm4054438pfa.132.2022.02.04.16.04.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Feb 2022 16:04:20 -0800 (PST)
Subject: Regression in 5.17-rc1 on pata-falcon (was: Re: [PATCH] m68k: mm:
 Remove check for VM_IO to fix deferred I/O)
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, Jens Axboe <axboe@kernel.dk>,
        Laibin Qiu <qiulaibin@huawei.com>
References: <20220128173006.1713210-1-geert@linux-m68k.org>
 <63c80eba-7c55-2a92-8078-c63cec3c9efb@gmail.com>
 <8913a0a2-9496-143c-18c2-f3023fd37ba0@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
From:   Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <8d215dab-cd0f-452b-281b-f67c9324b53b@gmail.com>
Date:   Sat, 5 Feb 2022 13:04:13 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101
 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <8913a0a2-9496-143c-18c2-f3023fd37ba0@gmail.com>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

commit 180dccb0dba4f5e84a4a70c1be1d34cbb6528b32 (blk-mq: fix tag_get 
wait task can't be awakened) does cause a regression on my m68k hardware 
test rig (m68k Falcon030, IDE disk attached through pata-falcon driver 
which does use polled IO instead of interrupts, so may be a little on 
the slow side).

While it usually takes 8 minutes for my system to boot to a point where 
the network driver is loaded, and another 10 minutes before I can  ssh 
into the box, all the while with IO activity on the disk as seem from 
the disk activity LED, the boot takes a few hours to complete since 
v15-rc1, with IO activity only very rarely seen.

In the one case where I could log in remotely, I had to abort the 
attempted reboot after another few hours.

This problem occurs only on real hardware, and isn't seen on e.g. ARAnyM 
which is frequently used to test changes.

Bisection between v5.16 and v5.17-rc1 points to 
180dccb0dba4f5e84a4a70c1be1d34cbb6528b32 as the culprit, which is 
corroborated by reverting that commit in v5.17-rc1 and booting as 
rapidly as before.

I don't pretend to understand the purpose of the problematic commit, and 
cannot spot anything glaringly obvious with the change in logic in e.g. 
__blk_mq_tag_idle(). If there's anything you'd like me to test that 
could make that commit work for my unusual set-up, I'd be happy to help.

Cheers,

	Michael


Am 30.01.2022 um 19:57 schrieb Michael Schmitz:
> Hi Geert,
>
> Am 30.01.2022 um 13:32 schrieb Michael Schmitz:
>> Hi Geert,
>>
>> testing this patch on my Falcon 030, I'm seeing a weird error checking
>> and mounting the root filesystem (pata-falcon). The system appears to
>> sit idle, never completing the journal recovery and mount. Still
>> investigating that.
>
> Belay that - not related to your patch, must be some other regression
> since v5.16 that I'm seeing there.
>
> Just ignore the noise ...
>
> Cheers,
>
>     Michael
>
>
>> Can't see how that would be caused by your patch, just saying I could
>> not yet test it.
>>
>> Cheers,
>>
>>     Michael
>>
>>
>> Am 29.01.2022 um 06:30 schrieb Geert Uytterhoeven:
>>> When an application accesses a mapped frame buffer backed by deferred
>>> I/O, it receives a segmentation fault.  Fix this by removing the check
>>> for VM_IO in do_page_fault().
>>>
>>> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
>>> ---
>>> This check was never present in a fault handler on any other
>>> architecture than m68k.
>>> Some digging revealed that it was added in v2.1.106, but I couldn't find
>>> an email with a patch adding it.  That same kernel version extended the
>>> use of the hwreg_present() helper to HP9000/300, so the check might have
>>> been needed there, perhaps only during development?
>>> The Atari kernel relies heavily on hwreg_present() (both the success and
>>> failure cases), and these still work, at least on ARAnyM.
>>> ---
>>>  arch/m68k/mm/fault.c | 2 --
>>>  1 file changed, 2 deletions(-)
>>>
>>> diff --git a/arch/m68k/mm/fault.c b/arch/m68k/mm/fault.c
>>> index 1493cf5eac1e7a39..71aa9f6315dc8028 100644
>>> --- a/arch/m68k/mm/fault.c
>>> +++ b/arch/m68k/mm/fault.c
>>> @@ -93,8 +93,6 @@ int do_page_fault(struct pt_regs *regs, unsigned
>>> long address,
>>>      vma = find_vma(mm, address);
>>>      if (!vma)
>>>          goto map_err;
>>> -    if (vma->vm_flags & VM_IO)
>>> -        goto acc_err;
>>>      if (vma->vm_start <= address)
>>>          goto good_area;
>>>      if (!(vma->vm_flags & VM_GROWSDOWN))
>>>
