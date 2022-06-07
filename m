Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE87F53FB6B
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 12:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233851AbiFGKfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 06:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241175AbiFGKfg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 06:35:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A1D99EC33F
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 03:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654598134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EMDZylt7g0yFaR5sDv75Os0wo2b83bVT7I9pPHZT0dE=;
        b=bWzklHdsjgjQGjY2N1eV3r9XHn7tPrCWQZ+rRIM6qIrCUaPC+ZhHScB5Gj+em8hjKQ7x7j
        r+rLjSH6UQtp/VoBgdz7Rwsrqe6HMpuq1oPrtiKuE3x+rEf4of+bd2FbD/xPTGyZF9IFMe
        QcRe5V5gMPeOFTMUi7Umgpin0ADa8ao=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-61--ogT2ekYPSW6npCQBEIdJA-1; Tue, 07 Jun 2022 06:35:33 -0400
X-MC-Unique: -ogT2ekYPSW6npCQBEIdJA-1
Received: by mail-ed1-f70.google.com with SMTP id t14-20020a056402020e00b0042bd6f4467cso12312254edv.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 03:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=EMDZylt7g0yFaR5sDv75Os0wo2b83bVT7I9pPHZT0dE=;
        b=3UZhIKBF/ZIN00oEL1xMjwRUO06yYY6y+2Bh2CL4NjLNIIhoKV5HTq7XJV0knlm1pb
         WKiPYr8H1/6L78PGxZs3AJRU9RStyS4jBxil2u6ffhdEpVZYIq3DfXHuCxZduP678/pF
         3kFh0ibDPL82nUiwjCsr4a5rl1cbF1+RFWtZ9gOwSfm7o2cqXGwQUCHj6kio9+5cpj+h
         BuGojJZWHSriVYP56Fw5LKidP9GvOyZ4YNFbz88mq00bo//9zroCXmOV0mlygdjORZfT
         fc4wA7aKxuCwDBllTiFvtMOnW79dS8XLJDuaJSgZCu+UH7sUbW2vEbF0HLQE99cGR7yu
         wWZA==
X-Gm-Message-State: AOAM533V07SxyIJdGzMVIayProhdVy414sgPsKlpNTGMaoKXanHlRkrg
        QKYIEaHeEXbLL6ot5O7c5oAFYuU6IFWYHnJ+JWSqaYBrIrcBMFGgF/DKq/NMWwUKODcA+iskexz
        RivR78mIzJgsoGVq1aQVCD9SP
X-Received: by 2002:a17:907:3e86:b0:6f5:917:10cc with SMTP id hs6-20020a1709073e8600b006f5091710ccmr25403238ejc.53.1654598131443;
        Tue, 07 Jun 2022 03:35:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyzbiRHXFmPNGfPUDUE3OX+nygJ741kuKfLhQyuDg0pZrdO9AfsU4pb5jr0xG7SONciLAdopA==
X-Received: by 2002:a17:907:3e86:b0:6f5:917:10cc with SMTP id hs6-20020a1709073e8600b006f5091710ccmr25403218ejc.53.1654598131168;
        Tue, 07 Jun 2022 03:35:31 -0700 (PDT)
Received: from redhat.com ([2.55.169.1])
        by smtp.gmail.com with ESMTPSA id z14-20020a170906074e00b006fecf62536asm5096099ejb.188.2022.06.07.03.35.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 03:35:30 -0700 (PDT)
Date:   Tue, 7 Jun 2022 06:35:26 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     syzbot <syzbot+5b59d6d459306a556f54@syzkaller.appspotmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux@dominikbrodowski.net, mpm@selenic.com,
        syzkaller-bugs@googlegroups.com,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>, yuehaibing@huawei.com
Subject: Re: [syzbot] INFO: task hung in add_early_randomness (2)
Message-ID: <20220607063454-mutt-send-email-mst@kernel.org>
References: <000000000000fc128605e08585c6@google.com>
 <00000000000068486805e0d68f94@google.com>
 <CACGkMEvCmtmfBSDeq1psgW4+MTymfs_T-EFQx=2UdXfy1vWDiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEvCmtmfBSDeq1psgW4+MTymfs_T-EFQx=2UdXfy1vWDiw@mail.gmail.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 07, 2022 at 05:05:41PM +0800, Jason Wang wrote:
> On Tue, Jun 7, 2022 at 3:30 PM syzbot
> <syzbot+5b59d6d459306a556f54@syzkaller.appspotmail.com> wrote:
> >
> > syzbot has bisected this issue to:
> >
> > commit 8b4ec69d7e098a7ddf832e1e7840de53ed474c77
> > Author: Jason Wang <jasowang@redhat.com>
> > Date:   Fri May 27 06:01:19 2022 +0000
> >
> >     virtio: harden vring IRQ
> >
> > bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1175c3c7f00000
> > start commit:   f2906aa86338 Linux 5.19-rc1
> > git tree:       upstream
> > final oops:     https://syzkaller.appspot.com/x/report.txt?x=1375c3c7f00000
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1575c3c7f00000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=cbd131cc02ee620e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=5b59d6d459306a556f54
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=104f4d4ff00000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14d6782df00000
> >
> > Reported-by: syzbot+5b59d6d459306a556f54@syzkaller.appspotmail.com
> > Fixes: 8b4ec69d7e09 ("virtio: harden vring IRQ")
> >
> > For information about bisection process see: https://goo.gl/tpsmEJ#bisection
> >
> 
> I wonder if it's related to shared IRQ.
> 
> Want to know if the attached patch works.
> 
> Thanks


syzbot will test it for you if you ask it nicely.
See e.g.
https://lore.kernel.org/r/20220221054115.1270-1-hdanton%40sina.com

for an example of how to do it.

-- 
MST

