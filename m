Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABFCA480DB2
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 23:26:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237630AbhL1W0V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 17:26:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237601AbhL1W0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 17:26:21 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40DEC06173F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 14:26:20 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id u16so14511005plg.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 14:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3jpnFYyU1UvK2qtPGd0z/wd/hya+F4jiLnmmdr9GXaY=;
        b=lUSNHxvHtkgI97VY4BNHsI8aGGvWFzcNyLEczitXX2GAu6UfkWCeA4fPS7M5ihYtBF
         R2vIXAHPuxna50R0Cs9fT7CemGFJv6g7fO0rkVFwKzDWc1QEiV8rHvLUtM5lTlFPX2UN
         TysjcC3EtVvf/TT+K0MEMj/2dG7uX55DG2P/sa6InIcei83woXrbsBruBpXGU75yTxsS
         dXgVVJZVlKbPDw+ldethhaGjmRjOXQ4N55UUqHwmgL8YbYhUiiAPk2xStYTpWJ8rvgsE
         IXy0lgL2Mce9N2DSZ/y94l9eYcKDu+he794dqgjMONViLrP2RSVK3abog12ExpHe/aKu
         fn0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3jpnFYyU1UvK2qtPGd0z/wd/hya+F4jiLnmmdr9GXaY=;
        b=nPrDCeIrSRVe9JPVG30CFz165LWL5A1cXTW3+CZ0YSW5V8QrDSzx+ecaaT3K0ycxj9
         f1TXYKU9zigM1M5P4gR6El2fufajC08eAFwLxanCYAFOyytDtO/99nzYXtu/c1IjQRRb
         kOQ76fyGJrZSjCyGPPxiqlVGMADVF+S8W5mD5XbnPXnAfbYh82B7YeT70YVukgM2leOr
         7lH2n9N1eHUdQF9MTrwiJbfLBMbw4Y3wNR+j3XSs1H68CArjVZFaZwSFC/GjLGbqzAtS
         rcoym6Uf8awtNC/ugkKCQH5zfI9gM7BOc18/cdFGYRszlix4kKSYSLU9XF5So3tXtDt0
         N5OQ==
X-Gm-Message-State: AOAM530t2e6s/kJiR2JnaahYCum6IvMp8VgCNj1vyhUD3UxPUQyEzn6T
        Y8ay+1PDmYE0ne1/XqVqRiQ5pA==
X-Google-Smtp-Source: ABdhPJw9pY6bU/ixHEj19r6nqHSjypC3pzEscKgxKQVE846L338oJSTiWn3H18Q4b3PTpHGB3RxyEQ==
X-Received: by 2002:a17:90a:f0cc:: with SMTP id fa12mr4452980pjb.134.1640730380358;
        Tue, 28 Dec 2021 14:26:20 -0800 (PST)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id s6sm2724082pjp.19.2021.12.28.14.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 14:26:19 -0800 (PST)
Date:   Tue, 28 Dec 2021 22:26:16 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     syzbot <syzbot+4e697fe80a31aa7efe21@syzkaller.appspotmail.com>
Cc:     changbin.du@intel.com, christian.brauner@ubuntu.com,
        daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com,
        hkallweit1@gmail.com, kuba@kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        pbonzini@redhat.com, syzkaller-bugs@googlegroups.com,
        yajun.deng@linux.dev
Subject: Re: [syzbot] WARNING in kvm_mmu_notifier_invalidate_range_start
Message-ID: <YcuPCI+Nq2ixPGPD@google.com>
References: <000000000000ef6c6c05d437c830@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000ef6c6c05d437c830@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 28, 2021, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    ea586a076e8a Add linux-next specific files for 20211224
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=12418ea5b00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a9c4e3dde2c568fb
> dashboard link: https://syzkaller.appspot.com/bug?extid=4e697fe80a31aa7efe21
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15724985b00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d1aedbb00000
> 
> The issue was bisected to:
> 
> commit e4b8954074f6d0db01c8c97d338a67f9389c042f
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Tue Dec 7 01:30:37 2021 +0000
> 
>     netlink: add net device refcount tracker to struct ethnl_req_info

Heh, while I'd love to blame someone else, there's zero chance this is the
offending commit.  The WARN repros on kvm/queue, it's likely related to the KVM
memslot changes queued for 5.17.  I'll take a look.
