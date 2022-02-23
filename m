Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92EB4C1DD3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 22:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242694AbiBWVgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 16:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbiBWVgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 16:36:05 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D250A4F471
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 13:35:37 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id i21so55950pfd.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 13:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Ac/BcOmu5MdCFvS6JemgJvEoEjf0jHjFl+jOA9n59Gc=;
        b=N/wTJKNAsZAb2+DXd9uj0Oou2P7XETVHuE1paOj0Y2ML35z//aC0r2GJr2MClR45rT
         psUelX9t/gf+vG1bABjgortKasTe6wAnmupXsSu/4KcTbxxVICoUAubvvdtii7xUimVc
         8C4S8d4njpOej0HVoqsGPUQfZE8YrknKb7f1sAz4nm/Ktor/SJqUj0vEc/FU6E5Zvu0O
         4Kem6g2f7Et8fjdHNgEQZFvJg3YG/xxhXy6rZJjFlWPucfwsvmYFkHIhomLnV7grI4ZH
         LxAr7q5qUVwdPN8kuX5Vp4AiLcjrqqz5yogchFGVxCk2ht/xGRHMhvwX/lAU+L5K2YPn
         gYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=Ac/BcOmu5MdCFvS6JemgJvEoEjf0jHjFl+jOA9n59Gc=;
        b=i4987E8PLh3zv/E7arKHIlgviH1zsbqvIjdZbZag4CL8Y3EKPrmAAcKccOdKIB2FJc
         O+B26jFDJ4u4Ry38zvVtxpnEODxSHMylUSDBg/3BukSFaP2weAdX2MqCVAosIhffzd31
         QBZKTIWgIOWHfgMJ7dbsrno31oQmBkctitxnHxd5g/pIVSZU6vCYKn9edY8Ukkwoiucf
         6wekWza1orKDa9KbugcRI5OiSQ1InNZFMBL/839aAzZPD440QJ5OaWJVBNYcxl2Vy5YM
         hN2rU5foZpQVHFEqWKvLyqtClU/sdBWJ50XOwAmpdHMvU0KN237EnxQ7T8tE7aD4pl2q
         saWQ==
X-Gm-Message-State: AOAM533H6bAErEn1uqTakGUzWbPZvFzLYB3A0TVfTJsGmUet9BeoZKH7
        d9YStQgYzt5FLN+hythDlV3+UfUtnNw=
X-Google-Smtp-Source: ABdhPJymrFlposXdBgHft7TUiaq7uyEHdUjCbKVRK+0wR1l8SoJwKXsQ28HBNk21IZoHVJX0D6QP+g==
X-Received: by 2002:a63:af02:0:b0:375:57f0:8af1 with SMTP id w2-20020a63af02000000b0037557f08af1mr1247422pge.188.1645652137012;
        Wed, 23 Feb 2022 13:35:37 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id m13sm518443pfk.202.2022.02.23.13.35.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 13:35:36 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 23 Feb 2022 11:35:35 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-rpi-kernel <linux-rpi-kernel@lists.infradead.org>,
        Bart Van Assche <bvanassche@acm.org>, jgg@ziepe.ca,
        linux-kernel@vger.kernel.org,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Haakon Bugge <haakon.bugge@oracle.com>,
        DRI mailing list <dri-devel@lists.freedesktop.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>
Subject: Re: [PATCH v2] workqueue: Warn flush attempt using system-wide
 workqueues
Message-ID: <Yhaop3T53bHo7v2I@slm.duckdns.org>
References: <71d6f14e-46af-cc5a-bc70-af1cdc6de8d5@acm.org>
 <309c86b7-2a4c-1332-585f-7bcd59cfd762@I-love.SAKURA.ne.jp>
 <aa2bf24e-981a-a811-c5d8-a75f0b8f693a@acm.org>
 <2959649d-cfbc-bdf2-02ac-053b8e7af030@I-love.SAKURA.ne.jp>
 <YgnQGZWT/n3VAITX@slm.duckdns.org>
 <8ebd003c-f748-69b4-3a4f-fb80a3f39d36@I-love.SAKURA.ne.jp>
 <YgqSsuSN5C7StvKx@slm.duckdns.org>
 <2f887679-c783-bf18-a2aa-aa9a709bfb38@I-love.SAKURA.ne.jp>
 <CGME20220223212048eucas1p1fab5e35ff398eff57808a8f1125dd15f@eucas1p1.samsung.com>
 <4e5fe60d-abbb-6e73-b8cc-c3e1a314fbce@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4e5fe60d-abbb-6e73-b8cc-c3e1a314fbce@samsung.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 23, 2022 at 10:20:47PM +0100, Marek Szyprowski wrote:
> Hi All,
> 
> On 17.02.2022 12:22, Tetsuo Handa wrote:
> > syzbot found a circular locking dependency which is caused by flushing
> > system_long_wq WQ [1]. Tejun Heo commented that it makes no sense at all
> > to call flush_workqueue() on the shared workqueues as the caller has no
> > idea what it's gonna end up waiting for.
> >
> > Although there is flush_scheduled_work() which flushes system_wq WQ with
> > "Think twice before calling this function! It's very easy to get into
> > trouble if you don't take great care." warning message, it will be too
> > difficult to guarantee that all users safely flush system-wide WQs.
> >
> > Therefore, let's change the direction to that developers had better use
> > their own WQs if flushing is inevitable. To give developers time to update
> > their modules, for now just emit a warning message when flush_workqueue()
> > or flush_work() is called on system-wide WQs. We will eventually convert
> > this warning message into WARN_ON() and kill flush_scheduled_work().
> >
> > Link: https://syzkaller.appspot.com/bug?extid=831661966588c802aae9 [1]
> > Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
> 
> This patch landed in linux next-20220222 as commit 4a6a0ce060e4 
> ("workqueue: Warn flush attempt using system-wide workqueues"). As it 
> might be expected it exposed some calls to flush work. However it also 
> causes boot failure of the Raspberry Pi 3 and 4 boards (kernel compiled 
> from arm64/defconfig). In the log I see one call from the 
> deferred_probe_initcall(), but it isn't critical for the boot process. 
> The deadlock occurs when DRM registers emulated framebuffer on RPi4. 
> RPi3 boots a bit further, to the shell prompt, but then the console is 
> freezed. Reverting this patch on top of linux-next 'fixes' the boot.

Tetsuo, can you please revert the patch? The patch is incorrect in that it's
triggering also on work item flushes, not just workqueue flushes.

Thanks.

-- 
tejun
