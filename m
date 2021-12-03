Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6687F46714A
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 06:03:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbhLCFHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 00:07:16 -0500
Received: from mail-ed1-f42.google.com ([209.85.208.42]:41792 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbhLCFHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 00:07:15 -0500
Received: by mail-ed1-f42.google.com with SMTP id g14so6628720edb.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 21:03:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=rprGn8RFY/tiTMnkDGz553s/55a0pvo9AIhDH03fGOA=;
        b=5G4kWT9xZsLFDx0eVw3RjiOD12U+iPUghK5EInqothOuVSDgSVuXGQQadA0n14/kDS
         tQpcdyS6rjVfQyD7qs3JKKos7OKemJZ+4+aUoknhzJY6CvljUD9687dLZm0tQBA/AcjN
         sW9QAgnQbHIx9szfWGLBzWyOxXVXcC9/dHe4v7ggIURdCLwtxgku6JAipezzw/E17OUc
         zc39HSa2AWCG7/8XRr7jifaLO43KGx4tGgqkKEWqWA3ZvnL11OgEkJPTiornNLv/lsNr
         +mtpW5otu4HcY7MxV3zoFbQzEI7nvO8kdFLO+D5OC1yE/osCYYz0OCSvpi5yH+shNrHi
         hx6g==
X-Gm-Message-State: AOAM531INUXK5FV+KOzr/GB3pFemnY3MD6229prVhJq2uOnv5hiRYlsP
        7DLatJ7a4NdYmoQSxIRlyVI=
X-Google-Smtp-Source: ABdhPJym8YGSl5nAchCGiGLIdvklp5kK+KReeVHZfG4+tyT47kY+Gw6Y6t6jsw4dvlHNkZxhTl890g==
X-Received: by 2002:a17:906:24ca:: with SMTP id f10mr20688895ejb.144.1638507831144;
        Thu, 02 Dec 2021 21:03:51 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id hc10sm1090382ejc.99.2021.12.02.21.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Dec 2021 21:03:50 -0800 (PST)
Message-ID: <5ac5c18d-d99c-460c-bfff-6674b3651549@kernel.org>
Date:   Fri, 3 Dec 2021 06:03:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] tty: vt: make do_con_write() no-op if IRQ is disabled
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20211116144937.19035-1-fmdefrancesco@gmail.com>
 <1825634.Qa45DEmgBM@localhost.localdomain>
 <44d83e9c-d8c9-38bf-501c-019b8c2f7b5e@i-love.sakura.ne.jp>
 <1701119.OD4kndUEs1@localhost.localdomain>
 <1d05e95c-556a-a34c-99fd-8c542311e2dd@i-love.sakura.ne.jp>
 <3add7ade-9c9b-2839-5a0c-0a38c4be0e34@i-love.sakura.ne.jp>
 <CAHk-=wjVL_CLm-+=7qf2obF6f8D+ujysmqp5dKdAb7UEyo1cZg@mail.gmail.com>
 <86452127-70e8-c0cf-de18-6f98e77849a6@i-love.sakura.ne.jp>
 <CAHk-=wiXNJ86W=gwAHH1qd+cE9dmfk_dEKFmNa89XH19NhPNkg@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <CAHk-=wiXNJ86W=gwAHH1qd+cE9dmfk_dEKFmNa89XH19NhPNkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02. 12. 21, 19:35, Linus Torvalds wrote:
> On Thu, Dec 2, 2021 at 7:41 AM Tetsuo Handa
> <penguin-kernel@i-love.sakura.ne.jp> wrote:
>>
>>> Looking at the backtrace, I see
>>>
>>>     n_hdlc_send_frames+0x24b/0x490 drivers/tty/n_hdlc.c:290
>>>     tty_wakeup+0xe1/0x120 drivers/tty/tty_io.c:534
>>>     __start_tty drivers/tty/tty_io.c:806 [inline]
>>>     __start_tty+0xfb/0x130 drivers/tty/tty_io.c:799
>>>
>>> and apparently it's that hdlc line discipline (and
>>> n_hdlc_send_frames() in particular) that is the problem here.
>>>
>>> I think that's where the fix should be.
>>
>> Do you mean that we should change the behavior of n_hdlc_send_frames()
>> rather than trying to make __start_tty() schedulable again?
> 
> I wouldn't change n_hdlc_send_frames() itself. It does what it says it does.
> 
> But n_hdlc_tty_wakeup() probably shouldn't call it directly. Other tty
> line disciplines don't do that kind of thing - although I only looked
> at a couple. They all seem to just set bits and prepare things. Like a
> wakeup function should do.
> 
> So I think n_hdlc_tty_wakeup() should perhaps only do a
> "schedule_work()" or similar to get that n_hdlc_send_frames() started,
> rather than doing it itself.

Concurred, this is even documented:
write_wakeup
     [DRV] void ()(struct tty_struct *tty)
This function is called by the low-level tty driver to signal that line 
discpline should try to send more characters to the low-level driver for 
transmission. If the line discpline does not have any more data to send, 
it can just return. If the line discipline does have some data to send, 
please arise a tasklet or workqueue to do the real data transfer. Do not 
send data in this hook, it may lead to a deadlock.

thanks,
-- 
js
suse labs
