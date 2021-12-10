Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E288F46FA54
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 06:26:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232107AbhLJF36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 00:29:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbhLJF35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 00:29:57 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1FCC061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 21:26:23 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id x131so7441023pfc.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 21:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=9HaCr403HoDBRC5zt6/TcAYhY0RvCo+TqoHKsMM6+Zg=;
        b=XGGwhTb5e6gXGmVldeHS9UQWDNv/lgCXlDuqZlzFTzCisYJsxCbK2LP9R9slKt2fyh
         aTLPkH/Ggt09eHgCjtnfOg7HPVlBccrU3bO5ejAwZImmawIB8OEPLJ2RuAkcu4aj8B3u
         KyNPgvjy4aNnxH0DBszqz0kT4XsKaHvTofXgiWLgXSSdNg41RXRgMTGZz7Nk+CpeU//L
         D9rDEB+YZoCG+yObJWOh+osczpRd+K7rSAKpJIVRy6uslBrT8AmU7oqHX7/lrWsMj4T8
         iYlC3J4EuFg/TePjSKzj/HwCJBs0GxMivlX39xptJg9KSGU3jELnSHGamqctmD5/NQVD
         8WLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9HaCr403HoDBRC5zt6/TcAYhY0RvCo+TqoHKsMM6+Zg=;
        b=T8pcOGCa0fa1lYK7+YK53OY8UQY4x4FVzeTMED6NMqHqB6i7z6RWOthpYsBpfotCJn
         PYo+jafyZrbRhRRKONgrWnWjoGHEUQqA6PdYsoMowtBav2vJFyWdMUcnJEiVEZbvbQYf
         Fx6p67oTpMr8MTLxSx4+svqAdHCNW8PITckRMUnx68brKqbuor+3/awXyHwoe7uEy2Ro
         POdDyFJQ6zoJE7AHsTh5RZXdsX2+5M10/+TBO1cxnRegFJjKt5LkQYYm72wuZMT2ZXmw
         fbyUT8o2VS8sHahhBd0NjsBt6IEQvaM1MkXNm8sVg2CWBaWTRXreW+SlkL0v8LNN5WFq
         +lTA==
X-Gm-Message-State: AOAM533b3yab1IeJ4gZGRVzMleaLw7Y8QLh5RtcuYidXMun5O2U9kHPw
        eA5lZgvcT3XcNCjTANypwvuBeA==
X-Google-Smtp-Source: ABdhPJyaLUBIHXu2rZzkWm3g4aXnlEdx8xWgQP6fYPG8wWDyXI4dqfSDOtp/2akL00w47mZyOesYIQ==
X-Received: by 2002:a63:d217:: with SMTP id a23mr2083973pgg.143.1639113980852;
        Thu, 09 Dec 2021 21:26:20 -0800 (PST)
Received: from [172.20.4.26] ([66.185.175.30])
        by smtp.gmail.com with ESMTPSA id g1sm1571813pfv.19.2021.12.09.21.26.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 21:26:20 -0800 (PST)
Subject: Re: [syzbot] KASAN: use-after-free Write in io_queue_worker_create
To:     syzbot <syzbot+b60c982cb0efc5e05a47@syzkaller.appspotmail.com>,
        asml.silence@gmail.com, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <0000000000007b4e3605d2c3e4f1@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <9db849c7-f998-dec6-5553-1d2670389204@kernel.dk>
Date:   Thu, 9 Dec 2021 22:26:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0000000000007b4e3605d2c3e4f1@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/9/21 10:21 PM, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    c741e49150db Merge tag 'for-linus' of git://git.kernel.org..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=125600bab00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=221ffc09e39ebbd1
> dashboard link: https://syzkaller.appspot.com/bug?extid=b60c982cb0efc5e05a47
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1686906db00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1539a9b9b00000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+b60c982cb0efc5e05a47@syzkaller.appspotmail.com

#syz test git://git.kernel.dk/linux-block io_uring-5.16

-- 
Jens Axboe

