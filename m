Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529CF46C17A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 18:15:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239870AbhLGRTJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 12:19:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234054AbhLGRTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 12:19:09 -0500
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF7EC061746
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 09:15:38 -0800 (PST)
Received: by mail-qv1-xf31.google.com with SMTP id i13so13730042qvm.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 09:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XBFyhsQNquZ3pQHlUtJ+6p1EED9gXcXiwvxejmOE88o=;
        b=PgGKb+Njo2T1X/tum6Ttion0RVdSWLjvQNuQQUQh/9ciXyvFmQts2vIfjGDS4lbW4l
         lJ3EfP11Wu9S1Y6tSz2xhls/0T0ilKTm+JwuBUlz2KQwdRSDlTTqPLPiGcSAHkTU22cp
         2fprTvHiMLIlRFFm/R/cDEoY23MJ5wKne/mh1wtBWmdoNu9F7bFYn5tSwcAlzCpyMJVH
         AxTALAhF4016N/A8Ye82uUl6/bJnQmAQZVopQrqZyWRFeckKCR6TsKICVobXreJd2yDo
         FDliWYkLgmsAth2w/v/F1Xw3LTOfGYFk26upKuayLj8XyVaburOFCXILvGyYjkYf0UB2
         Ex0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XBFyhsQNquZ3pQHlUtJ+6p1EED9gXcXiwvxejmOE88o=;
        b=24diNWBPvp+W53Jwb/vkUrLnkxsKg/61GOBAFG+uOlGXwJBnrOuyveOx68a8CgPPki
         +BbPli6c5G02uaf7I7FPKcg+XpsvhKlT7tAmHC6FNAB1DLGHJ7SKUUbgC+kq7R/5lb73
         HUTk2ONOguffG+KusiYYQx6rh9Y7XGFah0jnJCvTi9Qn3LFmY++JJ1USNmQVdwXyRQe4
         hr3m9pWsSjMBCQpj2uMt7wGFY7MYlbcjOklzETcMwnUmWalgFan1Ezev5lWDuo2RA6jD
         daU9KzUsigMOkK7fwNwHG8fFRI3XPkTwc+BtPmOXHW9LBrHk2UAZHDqWRjBDVAMaBVp7
         si7Q==
X-Gm-Message-State: AOAM5305BrjmKWu1CWLyNleBde/QiloKSdIw/quXImLfUKhGSbu1JcRp
        5Edqe2vRN2ZBD2GfQAoKf/SQow==
X-Google-Smtp-Source: ABdhPJx2dAwjSu6007TyEGRFXM67eMCde+v+xT39zzAQ9NoQBCOcllZxeigztUqz6Ze6rQ9T4R5awg==
X-Received: by 2002:a05:6214:29c3:: with SMTP id gh3mr620183qvb.30.1638897337717;
        Tue, 07 Dec 2021 09:15:37 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id b11sm182363qtx.85.2021.12.07.09.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 09:15:37 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mue40-0005eD-O7; Tue, 07 Dec 2021 13:15:36 -0400
Date:   Tue, 7 Dec 2021 13:15:36 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     syzbot <syzbot+c94a3675a626f6333d74@syzkaller.appspotmail.com>,
        avihaih@nvidia.com, dledford@redhat.com, haakon.bugge@oracle.com,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] BUG: corrupted list in rdma_listen (2)
Message-ID: <20211207171536.GB6467@ziepe.ca>
References: <000000000000c3eace05d24f0189@google.com>
 <20211206154159.GP5112@ziepe.ca>
 <CACT4Y+bnJ5M84RjUONFYMXSOpzC5UOq2DxVNoQkq6c6nYwG9Og@mail.gmail.com>
 <20211206173550.GQ5112@ziepe.ca>
 <CACT4Y+atv60UELnQJqejS_Z+uBYYERha4-o1dViwVuSLpb-Tfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+atv60UELnQJqejS_Z+uBYYERha4-o1dViwVuSLpb-Tfw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 09:37:30AM +0100, Dmitry Vyukov wrote:

> > > https://syzkaller.appspot.com/bug?extid=c94a3675a626f6333d74
>
> In the Crashes table there are 2 crashes, one is the one that was
> reported in this email and the second happened on upstream commit
> 5833291ab6de (you can search by this hash on the page).
> 5833291ab6de is newer than a year:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/log/?id=5833291ab6de

Oh I see, I did not read it properly then

Sigh, OK

I thought we fixed this :(

Jason
