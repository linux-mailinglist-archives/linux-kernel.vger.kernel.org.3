Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1AA74779EE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:03:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239913AbhLPRDA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:03:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239907AbhLPRDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:03:00 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2BA3C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 09:02:59 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id s1so11252137wrg.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 09:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SrVCHaSSUww1aUIlo9VUKiSwk7a826/Fk8HSVed0lbU=;
        b=oE2mc1WjeSGmDZolVhS6lIXVpReQkkc+OMnmHwpvVE+Kvdh6a0uAT6wX6xkEB+qlaf
         xJnr1aWLF+FRJq6U4bWJFCHuXjdXastRSIk8mDm2OPTaMHLZ3jSkKFor+O4nR83ySpE5
         wWKem3sERbIoS0fv67sp+3Ez+TSrfXEUGGZ9KmG9J1ronTD0cmZA1XQTaGdrjIWynN8t
         wgWH602ixhBSTGwSDWzHynt/pk7jugRbMvdEDViG+PSZshKz2E/9c6LDjSSFMIc9HMdy
         SLCqWcPwrekOMEYlQQsYeTmOFhqNr7Vh7qinfLw1/AD5lj3vyfHHQeIcViNcum5xvCDt
         EdRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SrVCHaSSUww1aUIlo9VUKiSwk7a826/Fk8HSVed0lbU=;
        b=tmyckI/+eXuRGqWTgybVw+MYbDK84CtBdXd8cvaEmafB+mwl7kOyHlHU/bRkWOmws1
         bl7B3jtTZxzrS6tS/pN+LKcSIAbpbsMBM3ODO+pi9ua78i9ajaaXGp88reMeGl+GVNgj
         JaG/fT/m+KCbbmaNCOIHkeRH7EoaH695y+tHWe5urNyVNaQuJllbYWVs+AiPDpQHGJfV
         YrfWwzw1DqpPWGOIIU163f2mE0q/utTfl8NKlnWPrpUlI6W9opRKTPAcBPBHW+2Ucw+6
         9b6B9HhytnqdfBp84nQFaOCvpRCBZHyhKw9MNyTCfHliIeFN7GsIXul+2buJIJC3tyT6
         Rw8A==
X-Gm-Message-State: AOAM533CFN0pDf8Bt6fc5z9fsTkvyse8IzzGEEqagc/ExNTfqYR7e7qF
        RKYmolLv2oLjX6bmwUZkURIG5g==
X-Google-Smtp-Source: ABdhPJzBJgn6GwDUGy7kLbPH98ubX4OIJvp7lqM5S68uYwB/Fyf9/8xted9dA5x6AfEAlxVFV98qQw==
X-Received: by 2002:adf:cd06:: with SMTP id w6mr9835298wrm.431.1639674178280;
        Thu, 16 Dec 2021 09:02:58 -0800 (PST)
Received: from google.com ([2.31.167.18])
        by smtp.gmail.com with ESMTPSA id b132sm5251570wmd.38.2021.12.16.09.02.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 09:02:57 -0800 (PST)
Date:   Thu, 16 Dec 2021 17:02:52 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Pavel Begunkov <asml.silence@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        syzbot <syzbot+9671693590ef5aad8953@syzkaller.appspotmail.com>,
        io-uring@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [syzbot] KASAN: stack-out-of-bounds Read in iov_iter_revert
Message-ID: <YbtxPB/ceMUVK7t7@google.com>
References: <6f7d4c1d-f923-3ab1-c525-45316b973c72@gmail.com>
 <00000000000047f3b805c962affb@google.com>
 <YYLAYvFU+9cnu+4H@google.com>
 <0b4a5ff8-12e5-3cc7-8971-49e576444c9a@gmail.com>
 <dd122760-5f87-10b1-e50d-388c2631c01a@kernel.dk>
 <YYp4rC4M/oh8fgr7@google.com>
 <YbmiIpQKfrLClsKV@google.com>
 <c7131961-23de-8bf4-7773-efffe9b8d294@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c7131961-23de-8bf4-7773-efffe9b8d294@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2021, Pavel Begunkov wrote:

> On 12/15/21 08:06, Lee Jones wrote:
> > On Tue, 09 Nov 2021, Lee Jones wrote:
> > 
> > > On Mon, 08 Nov 2021, Jens Axboe wrote:
> > > > On 11/8/21 8:29 AM, Pavel Begunkov wrote:
> > > > > On 11/3/21 17:01, Lee Jones wrote:
> > > > > > Good afternoon Pavel,
> > > > > > 
> > > > > > > syzbot has tested the proposed patch and the reproducer did not trigger any issue:
> > > > > > > 
> > > > > > > Reported-and-tested-by: syzbot+9671693590ef5aad8953@syzkaller.appspotmail.com
> > > > > > > 
> > > > > > > Tested on:
> > > > > > > 
> > > > > > > commit:         bff2c168 io_uring: don't retry with truncated iter
> > > > > > > git tree:       https://github.com/isilence/linux.git truncate
> > > > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=730106bfb5bf8ace
> > > > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=9671693590ef5aad8953
> > > > > > > compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.1
> > > > > > > 
> > > > > > > Note: testing is done by a robot and is best-effort only.
> > > > > > 
> > > > > > As you can see in the 'dashboard link' above this bug also affects
> > > > > > android-5-10 which is currently based on v5.10.75.
> > > > > > 
> > > > > > I see that the back-port of this patch failed in v5.10.y:
> > > > > > 
> > > > > >     https://lore.kernel.org/stable/163152589512611@kroah.com/
> > > > > > 
> > > > > > And after solving the build-error by back-porting both:
> > > > > > 
> > > > > >     2112ff5ce0c11 iov_iter: track truncated size
> > > > > >     89c2b3b749182 io_uring: reexpand under-reexpanded iters
> > > > > > 
> > > > > > I now see execution tripping the WARN() in iov_iter_revert():
> > > > > > 
> > > > > >     if (WARN_ON(unroll > MAX_RW_COUNT))
> > > > > >         return
> > > > > > 
> > > > > > Am I missing any additional patches required to fix stable/v5.10.y?
> > > > > 
> > > > > Is it the same syz test? There was a couple more patches for
> > > > > IORING_SETUP_IOPOLL, but strange if that's not the case.
> > > > > 
> > > > > 
> > > > > fwiw, Jens decided to replace it with another mechanism shortly
> > > > > after, so it may be a better idea to backport those. Jens,
> > > > > what do you think?
> > > > > 
> > > > > 
> > > > > commit 8fb0f47a9d7acf620d0fd97831b69da9bc5e22ed
> > > > > Author: Jens Axboe <axboe@kernel.dk>
> > > > > Date:   Fri Sep 10 11:18:36 2021 -0600
> > > > > 
> > > > >       iov_iter: add helper to save iov_iter state
> > > > > 
> > > > > commit cd65869512ab5668a5d16f789bc4da1319c435c4
> > > > > Author: Jens Axboe <axboe@kernel.dk>
> > > > > Date:   Fri Sep 10 11:19:14 2021 -0600
> > > > > 
> > > > >       io_uring: use iov_iter state save/restore helpers
> > > > 
> > > > Yes, I think backporting based on the save/restore setup is the
> > > > sanest way by far.
> > > 
> > > Would you be kind enough to attempt to send these patches to Stable?
> > > 
> > > When I tried to back-port them, the second one gave me trouble.  And
> > > without the in depth knowledge of the driver/subsystem that you guys
> > > have, I found it almost impossible to resolve all of the conflicts:
> > 
> > Any movement on this chaps?
> > 
> > Not sure I am able to do this back-port without your help.
> 
> Apologies, slipped from my attention, we'll backport it,
> and thanks for the reminder

Excellent.  Thanks Pavel.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
