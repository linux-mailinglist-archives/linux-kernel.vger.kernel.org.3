Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF34483498
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbiACQKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 11:10:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233046AbiACQKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:10:52 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B24C061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 08:10:51 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id 69so31732665qkd.6
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 08:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D1Q3J6juiePL27oWBkNOxTw2Gj9XV99OOInUYuxJbFA=;
        b=K83wNLSqiOi8vkX/rso4uTib9WyUzG+hZKEYcqDcieuwvx8rSQoSi+KaIrxQ1OzQog
         TDzNbj//gaIPz6hc/czb1VUjZFifljsuefa5lRfEZSS2joeL3jairu9nvrFTo7aLcA8+
         chTKfTi35f+mA3a4VvuMf9g6B9+OXAwwU5B4BKT2GDtkgDlWySSFk97KAhhz5ZaV52YD
         OthaIbhPUP2OpIqopyIvOlDeaGPXNXl73+sYrfKfLQ/TGkBxSKmKr/waFZQAdAX956Hr
         Rxi/QHTYWUp1YAzfrxuuEFUez1Ljxin7TlA6P99aKoLlRTig2ys9lKYRIsgrj3BdCmun
         NmMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D1Q3J6juiePL27oWBkNOxTw2Gj9XV99OOInUYuxJbFA=;
        b=ItdlfUK8CGQO0MdA2iUPrjWbfGXD4ij+sKNocjvW3mh6a/CDtWRKm8Y1261VQik8M1
         NrITQcpyly5xaN/T7ji3dFtPK5Xh5eOAcyC12rwA4OAJSBCWrLF+Ndcq/frmu+FOTBgp
         UmSMH8VwFdSFlE/wq5BuqpZiN151plRXTmvw3lWkHuzf5r2ALqZH2bJa9Gy7KGo4CMht
         gZ67lipoOps4M5Y8ILJB92AL0/7Gergm2aRpz4v2GnnIIoCTAgwc/OKUqk1rcWPjnxQJ
         mq14xs/RetBEU6i3Ft4dBVsFQTyM/3OPFcRycwNUA1kJqMUaHG8mJl3gpbxB0whZpphG
         phoQ==
X-Gm-Message-State: AOAM530qFgoUKTrIcu+TSJP8yRvnmp8fJJbltTfHhDEBeZOj+iZlrpDv
        P2igMf98DZ0Hji8G2Vy6qzcqZw==
X-Google-Smtp-Source: ABdhPJyNV5rHobiq6J8ocNRs9MB2USBw2xmYNfVt1+XhSMp1T2zlbT9BAc0HnGfPjpPYBlHq18KNyg==
X-Received: by 2002:a05:620a:85e:: with SMTP id u30mr32185499qku.765.1641226250755;
        Mon, 03 Jan 2022 08:10:50 -0800 (PST)
Received: from localhost (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id o10sm30540976qtx.33.2022.01.03.08.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 08:10:50 -0800 (PST)
Date:   Mon, 3 Jan 2022 11:10:49 -0500
From:   Josef Bacik <josef@toxicpanda.com>
To:     Yongji Xie <xieyongji@bytedance.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] nbd: Don't use workqueue to handle recv work
Message-ID: <YdMgCS1RMcb5V2RJ@localhost.localdomain>
References: <20211227091241.103-1-xieyongji@bytedance.com>
 <Ycycda8w/zHWGw9c@infradead.org>
 <CACycT3usfTdzmK=gOsBf3=-0e8HZ3_0ZiBJqkWb_r7nki7xzYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACycT3usfTdzmK=gOsBf3=-0e8HZ3_0ZiBJqkWb_r7nki7xzYA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 30, 2021 at 12:01:23PM +0800, Yongji Xie wrote:
> On Thu, Dec 30, 2021 at 1:35 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Mon, Dec 27, 2021 at 05:12:41PM +0800, Xie Yongji wrote:
> > > The rescuer thread might take over the works queued on
> > > the workqueue when the worker thread creation timed out.
> > > If this happens, we have no chance to create multiple
> > > recv threads which causes I/O hung on this nbd device.
> >
> > If a workqueue is used there aren't really 'receive threads'.
> > What is the deadlock here?
> 
> We might have multiple recv works, and those recv works won't quit
> unless the socket is closed. If the rescuer thread takes over those
> works, only the first recv work can run. The I/O needed to be handled
> in other recv works would be hung since no thread can handle them.
> 

I'm not following this explanation.  What is the rescuer thread you're talking
about?  If there's an error we close the socket which will error out the recvmsg
which will make the recv workqueue close down.

> In that case, we can see below stacks in rescuer thread:
> 
> __schedule
>   schedule
>     scheule_timeout
>       unix_stream_read_generic
>         unix_stream_recvmsg
>           sock_xmit
>             nbd_read_stat
>               recv_work
>                 process_one_work
>                   rescuer_thread
>                     kthread
>                       ret_from_fork

This is just the thing hanging waiting for an incoming request, so this doesn't
tell me anything.  Thanks,

Josef
