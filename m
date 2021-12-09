Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB9E646E09C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 02:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbhLICCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 21:02:40 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:33383 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbhLICCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 21:02:39 -0500
Received: by mail-io1-f72.google.com with SMTP id 85-20020a6b0258000000b005ed47a95f03so5622839ioc.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 17:59:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=X4FiWxWmye52Y3LrKLRpr7dU5cRyOrBsZmbMNfSo5CY=;
        b=WQWSdXQQXxZzXXpiVesLUT5uZFb+NeyNgNqWdGikRK5ypGslodSQpR9jrv8j2uoAYx
         94XcP5VlE21p2A3ZoGRpuhE6hJ9MM3tEvhJq6cePd4Rbh9zA6hkrOE3r92M6Q+PXOnxW
         h66HnRIIA+D2/P4mhEZMasCaVcy4pWIzU5htsAS6h/7SCuembF3VkCHf8Jq974piwect
         7J7oIK3PnRsoYnug/gIfLY9a5COyl/x2N9PUZIaDuCxlkaDg/EdQDXGx5asRGAhifunE
         zt8DSXUapm8dL9ILNISSyCftxvK68LYT5/GIIdQiFpyM+c02XhewnZPA1S8dkH3Fnkhw
         PWfA==
X-Gm-Message-State: AOAM5326Qcy0sIBNCEoi1pgrt5hbqBdG3SHmXYDk4axfvem9+tlTG2nv
        lONMUjfmMFKZETGRNJecGcTnzlaWy+7qKeZnNGRQWsbE6VT9
X-Google-Smtp-Source: ABdhPJwcKdNMEn0KYdQ1vLDPmmNZxklGqYWl2rCNCIb5QMi3PCt4qHD/Z9l7k31KBbRCAtfLak+fOlkcKYLqu/ng3mHqCptgF8XI
MIME-Version: 1.0
X-Received: by 2002:a05:6638:260d:: with SMTP id m13mr5339337jat.99.1639015146603;
 Wed, 08 Dec 2021 17:59:06 -0800 (PST)
Date:   Wed, 08 Dec 2021 17:59:06 -0800
In-Reply-To: <00000000000029e89205d2a8718d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000098464c05d2acf3ba@google.com>
Subject: Re: [syzbot] BUG: sleeping function called from invalid context in hci_cmd_sync_cancel
From:   syzbot <syzbot+485cc00ea7cf41dfdbf1@syzkaller.appspotmail.com>
To:     Thinh.Nguyen@synopsys.com, bberg@redhat.com, changbin.du@intel.com,
        christian.brauner@ubuntu.com, davem@davemloft.net,
        edumazet@google.com, gregkh@linuxfoundation.org,
        johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, luiz.dentz@gmail.com,
        luiz.von.dentz@intel.com, marcel@holtmann.org,
        mathias.nyman@linux.intel.com, netdev@vger.kernel.org,
        stern@rowland.harvard.edu, syzkaller-bugs@googlegroups.com,
        yajun.deng@linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot has bisected this issue to:

commit c97a747efc93f94a4ad6c707972dfbf8d774edf9
Author: Benjamin Berg <bberg@redhat.com>
Date:   Fri Dec 3 14:59:02 2021 +0000

    Bluetooth: btusb: Cancel sync commands for certain URB errors

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10a0fdc5b00000
start commit:   4eee8d0b64ec Add linux-next specific files for 20211208
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12a0fdc5b00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14a0fdc5b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20b74d9da4ce1ef1
dashboard link: https://syzkaller.appspot.com/bug?extid=485cc00ea7cf41dfdbf1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13e7e955b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10ed3641b00000

Reported-by: syzbot+485cc00ea7cf41dfdbf1@syzkaller.appspotmail.com
Fixes: c97a747efc93 ("Bluetooth: btusb: Cancel sync commands for certain URB errors")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
