Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08FD14683F8
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 11:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348130AbhLDKWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 05:22:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347426AbhLDKWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 05:22:12 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B62C061359
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 02:18:47 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id a23-20020a9d4717000000b0056c15d6d0caso6759017otf.12
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 02:18:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qTSQonO6cpdOT/9lK6N01NZXgDCMfbNPFb3L0B3C7TY=;
        b=E5OcN2+thklji0N2xi8yxr8M9qAHTMjuxXh2pQjPypGOgiGE8ZKwW1FP35jaLE1hje
         QpUv251xaqESYrfqqMbXmoXRoQ5f/7n8/FrMjQ3tHGorNSpgKQSAkJegS/wofzOwiKBJ
         xEOEFW08O2Bt3ZBPf9fdWMa2MkCHY3SmTLKc2KKb/16sDpYkigQ3aj/gj0Yu9Q+u32Y9
         mDKgfHKbPh/cZlQLbcEmzs0n8s9VeXJlyUE90+F2vUcHauJ3PnDm6JvJvnh5q/UU7bnM
         8PXQVTmFD+YMWpnjJhPjlQH2cVdSBDC9LtXcXMyuu0J5PfznbavWTktVMTgzdTeojYei
         ihXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qTSQonO6cpdOT/9lK6N01NZXgDCMfbNPFb3L0B3C7TY=;
        b=UK3isY4wtBxWnJtNx/s6y3bq92qRz1nx5F4CFmMycYb64QlfSHSKjOrjVGZzh22EHZ
         znQfmHv91vZ/YdWkR5zhzljFFm/eSN7OtrlRo6xO5jMa2CQbJVr0vkihjz1HfAx17LyY
         Mn5dG840OSFu6YsMonEz+bfCtdc/aqy+7vcQi/8gMXOdSxT3Rkqdw2wnHaj7OT/7R7XZ
         y1fgEf0YmRkPHas0QrKN5ti8I1sw1xRmKjToO0ORzQM8LDGU2sMVC/jueBYDI6/BPGPH
         CaV45G+zS626tzvYX5gpFBH4WD4QtOV88WudLy1ni3uPh2t+wk2pVkXYZtaLsgMW+HhO
         yD3w==
X-Gm-Message-State: AOAM531NJ84ljZnXE3ckGOCcrcypv1jf092uLWAIlUSMaUGqQgH3R/50
        0JL4vUufufj/fIJY5mcL+eN69239G2tTmEXtg/nNuw==
X-Google-Smtp-Source: ABdhPJx6mZbpcwe2rwwXgkqjIfJCq7YZmY8eKqWNuUTjv5tCDwtrERGexd3z9kft8T7L3n7+03HjEghubp7tRlKQKV8=
X-Received: by 2002:a05:6830:2425:: with SMTP id k5mr20582747ots.319.1638613126667;
 Sat, 04 Dec 2021 02:18:46 -0800 (PST)
MIME-Version: 1.0
References: <000000000000a56e9105d0cec021@google.com> <042900c4-7758-bb90-bac1-c01b12df49bc@suse.com>
In-Reply-To: <042900c4-7758-bb90-bac1-c01b12df49bc@suse.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 4 Dec 2021 11:18:35 +0100
Message-ID: <CACT4Y+bS=GfjNah0pGCt2DzifxVGK3QacvYtq_9==TXeZsL7NQ@mail.gmail.com>
Subject: Re: [syzbot] WARNING in usbnet_start_xmit/usb_submit_urb
To:     Oliver Neukum <oneukum@suse.com>
Cc:     syzbot <syzbot+63ee658b9a100ffadbe2@syzkaller.appspotmail.com>,
        davem@davemloft.net, kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Aleksandr Nogikh <nogikh@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Nov 2021 at 15:31, 'Oliver Neukum' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
>
>
> On 15.11.21 08:28, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    048ff8629e11 Merge tag 'usb-5.16-rc1' of git://git.kernel...
> > git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1480ade1b00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=d6b387bc5d3e50f3
> > dashboard link: https://syzkaller.appspot.com/bug?extid=63ee658b9a100ffadbe2
> > compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1313cb7cb00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a2f676b00000
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+63ee658b9a100ffadbe2@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > usb 5-1: BOGUS urb xfer, pipe 3 != type 1
> > WARNING: CPU: 0 PID: 1291 at drivers/usb/core/urb.c:502 usb_submit_urb+0xed2/0x18a0 drivers/usb/core/urb.c:502
>
> Hi,
>
> here I understand what is happening, but not why it can happen. Usbnet
> checks the endpoint type.
>
> May I request an addition to syzbot? Could you include the output of
> "lsusb -v" at the time
> of the error condition for USB bugs?

Hi Oliver,

Aleksandr filed https://github.com/google/syzkaller/issues/2889 for
this request.
But so far we did not find a good solution. syzbot collects some info
about the machine after boot, but that's obviously wrong moment. After
the bug it's also too late -- the kernel is dead/corrupted. It's also
unclear what exactly is "usb bug".
It may be easier to do from the kernel by hooking into panic. Would
also benefit all other kernel testing as this is not really
syzbot-specific, so better belongs to kernel. Is it possible to do it
from the kernel? If not, maybe the kernel could at least log
connect/disconnect events to the console.
