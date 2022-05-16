Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A363527D71
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 08:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238940AbiEPGNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 02:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbiEPGNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 02:13:09 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BD118352
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:13:08 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ks9so26572851ejb.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 May 2022 23:13:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UMivNP1yATOqWiy4xAV1dIXzJMIjL6HYMoQwwXh9g8U=;
        b=U9k6OUws21OayeSqTQt3GmsNurJtExmOYfgxajIaoyI7I2td2Yq9miYkQhG8IEwl5/
         uPFve13ZyNG/Nej7aDhOlaTCbpoPm2NysOSkOXHB3C/y1d90TwZFSGsfNsvoQ1/T6SHa
         VCl7AFEAVUNFiXJcJxF2AzwSORetVgCErxNN9jbVM/z8Zy15uLTO0l2gFcTPfbpAPD1j
         ftj3u8hnX7+Z73WN3VhdroO/P/EJO0w4FPwbH8wTM4QoVQzu2C2xML4qcBuTn9cHAweD
         Lf2zS/7jBL06rclsoc+G+JBIx0SdEiS/0d+iZ+bFSx6EEbdryBxn7OaTrKnRoD2obMlv
         DIPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UMivNP1yATOqWiy4xAV1dIXzJMIjL6HYMoQwwXh9g8U=;
        b=cDDqueZBdnQ5QLcmPksS2BHlzxP75Ey3HhhHI9tU82GV+5z9+gxGORtJYSMLNrhbOe
         DLbRklsS70PoFpTMiVKT+nU/9jO12DNzvrvf0a1aGh4pqnOqsqVi8H+MxYyWhoz6DEiu
         +uIXU1nnKjPAczdrJd3DS4h4ZGX6d69ULGPysDePJts4dA0GLR6dvJLCNxbDhspF3J1L
         oc7Rq4c1IsPr96RAzy++bgnSHuYkDchvp6fIupxarod5vdv2n76VE8+KT4yyOC00Srbn
         UCQkI98SyQevoV6rDcZbGueAe6i9nYsIT1G0fI2+/C/i9ZYKC0yHcHyOyOUCoCxPhoH6
         wNMg==
X-Gm-Message-State: AOAM533QGkFha+fcb40TIv67jIESQkE6MPQDygleRDjeyk/6B4cnNcYS
        6rJrH2Rid/PzrfbhtBnucMa7gOJtbFDqCKMIUr32
X-Google-Smtp-Source: ABdhPJxwQU9n4T2vbv6zUUJLoz7qvcHSvdfpZ0OoVoSPI1Lmi3TIaOffSlIgVbg0SF0TtcFdY6c/pr0IlFrm5oX11lo=
X-Received: by 2002:a17:906:dc8f:b0:6f4:e6df:a48d with SMTP id
 cs15-20020a170906dc8f00b006f4e6dfa48dmr14195693ejc.206.1652681587130; Sun, 15
 May 2022 23:13:07 -0700 (PDT)
MIME-Version: 1.0
References: <20211227091241.103-1-xieyongji@bytedance.com> <YjotekJZcSvwoZhp@localhost.localdomain>
 <CACycT3vz4hYTFpHo0Jphs-xE-k--y63+vedTFAaDRWhpi4_5rg@mail.gmail.com>
In-Reply-To: <CACycT3vz4hYTFpHo0Jphs-xE-k--y63+vedTFAaDRWhpi4_5rg@mail.gmail.com>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Mon, 16 May 2022 14:13:48 +0800
Message-ID: <CACycT3vExVBrmE3JN=Bay7sqX=C+wXo5imswLJv_pODbyFFSMA@mail.gmail.com>
Subject: Re: [PATCH v2] nbd: Don't use workqueue to handle recv work
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Bart Van Assche <bvanassche@acm.org>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping.

On Wed, Mar 23, 2022 at 7:21 PM Yongji Xie <xieyongji@bytedance.com> wrote:
>
> On Wed, Mar 23, 2022 at 4:11 AM Josef Bacik <josef@toxicpanda.com> wrote:
> >
> > On Mon, Dec 27, 2021 at 05:12:41PM +0800, Xie Yongji wrote:
> > > The rescuer thread might take over the works queued on
> > > the workqueue when the worker thread creation timed out.
> > > If this happens, we have no chance to create multiple
> > > recv threads which causes I/O hung on this nbd device.
> > >
> > > To fix it, we can not simply remove the WQ_MEM_RECLAIM
> > > flag since the recv work is in the memory reclaim path.
> > > So this patch tries to create kthreads directly to
> > > handle the recv work instead of using workqueue.
> > >
> >
> > I still don't understand why we can't drop WQ_MEM_RECLAIM.  IIRC your argument
> > is that we need it because a reconnect could happen under memory pressure and we
> > need to be able to queue work for that.  However your code makes it so we're
> > just doing a kthread_create(), which isn't coming out of some emergency pool, so
> > it's just as likely to fail as a !WQ_MEM_RECLAIM workqueue.  Thanks,
> >
>
> I think the key point is the context in which the work thread is
> created. It's the context of the nbd process if using kthread_create()
> to create a workthread (might do some allocation). Then we can benefit
> from the PR_SET_IO_FLUSHER flag, so memory reclaim would never hit the
> page cache on the nbd device. But using queue_work() to create a
> workthread, the actual thread creation happens in the context of the
> work thread rather than the nbd process, so we can't rely on the
> PR_SET_IO_FLUSHER flag to avoid deadlock.
>
> Thanks,
> Yongji
