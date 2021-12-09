Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3DC746F1A8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242857AbhLIR2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbhLIR2N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:28:13 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3C3C061746
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 09:24:39 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id y12so21292094eda.12
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 09:24:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3tHtN7G3YGgTFoTuLt2UtzoWso0slwegtyye0NyKD6E=;
        b=EkUZICBj3sLfwkSa6PVgwK3UJYMBWKD3Zl6QL503dGClSkUivH631EePhpBTiQgDNd
         VoCL1zBnYteGbjvNrexkMxulvtqSc6W1x7ANtURNimEiRxxY81sHWsZDJM+iJu2oAiti
         SYA5FO15uZ/NSRZ6dw7jltE7xXAi1A4hAYadw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3tHtN7G3YGgTFoTuLt2UtzoWso0slwegtyye0NyKD6E=;
        b=PSOOU3en8vz5PmwBDqTSYeo7fgZrhw4KCY5kolB5IeavET5ZvbQrHX88rZOxqN1mUs
         Tskzpc3fT7og4FET27UObdyOqpMb659IV8MtX9xnpXOqm8X2bbK2EBInsbtIw/WPySRe
         s0DbfveSD5ycsa5XP0SAAB12H54RS3AOd9X1dG4Cth1FAdgtnDKA0Z9szLPa5bEWLWnQ
         hEdDfK383IfvPjKRhbNfElO+TVErc1sONKsmDBcE9rLF0G8/k45lzL0o5sYU1jeKH1XV
         /WoFT1GpV6sCVyS4zcut/ynJIXHR4yhrsM7gfdXHDthYVuzb8RihLg7yGBMWCkygaSZd
         5aAA==
X-Gm-Message-State: AOAM531KyHBhGnxD8X11p4ouGUD8Le4p2F+e/e4hBOILHXB6H3o6Wi8u
        h2CG+6F9cNn2wAcsTW9JNLqHfzzbhWZrIZil
X-Google-Smtp-Source: ABdhPJy+nyo1Fm1xjxa8pX43Nel3Np0vxOKmqOJt7USnQSm3gu4cMvcGYNdWtbMYJz+HHHLQqQOxyg==
X-Received: by 2002:a17:907:7250:: with SMTP id ds16mr17151622ejc.54.1639070480344;
        Thu, 09 Dec 2021 09:21:20 -0800 (PST)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id qk9sm214601ejc.68.2021.12.09.09.21.20
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Dec 2021 09:21:20 -0800 (PST)
Received: by mail-wm1-f52.google.com with SMTP id m25-20020a7bcb99000000b0033aa12cdd33so5660935wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Dec 2021 09:21:20 -0800 (PST)
X-Received: by 2002:a05:600c:1914:: with SMTP id j20mr8992229wmq.26.1639069994552;
 Thu, 09 Dec 2021 09:13:14 -0800 (PST)
MIME-Version: 1.0
References: <163906878733.143852.5604115678965006622.stgit@warthog.procyon.org.uk>
 <163906888735.143852.10944614318596881429.stgit@warthog.procyon.org.uk>
In-Reply-To: <163906888735.143852.10944614318596881429.stgit@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Dec 2021 09:12:58 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiTquFUu-b5ME=rbGEF8r2Vh1TXGfaZZuXyOutVrgRzfw@mail.gmail.com>
Message-ID: <CAHk-=wiTquFUu-b5ME=rbGEF8r2Vh1TXGfaZZuXyOutVrgRzfw@mail.gmail.com>
Subject: Re: [PATCH v2 07/67] fscache: Implement a hash function
To:     David Howells <dhowells@redhat.com>
Cc:     linux-cachefs@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        linux-afs@lists.infradead.org,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 9, 2021 at 8:54 AM David Howells <dhowells@redhat.com> wrote:
>
> Implement a function to generate hashes.  It needs to be stable over time
> and endianness-independent as the hashes will appear on disk in future
> patches.

I'm not actually seeing this being endianness-independent.

Is the input just regular 32-bit data in native word order? Because
then it's not endianness-independent, it's purely that there *is* no
endianness to the data at all and it is purely native data.

So the code may be correct, but the explanation is confusing. There is
absolutely nothing here that is about endianness.

           Linus
