Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A5153700A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 08:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229592AbiE2GlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 02:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiE2GlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 02:41:06 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA0113FAA
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 23:41:05 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id l84so10485137oif.10
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 23:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3/+ZUmZdmdw27pbnk++KxX9Rw+MSygX4g2fczs64fyE=;
        b=CcmLGRWyjudLTA0cBaYrBr8cVaFy2IWaKgvpr1tBrYbZcuSIgPqjmQsu7seW6hjdvg
         7r+UTw2DXBhyzCpicDqHEjU7SQr28DDR+MDOKwFpZSdoGqDjMlEjs3lF/9qeh54NgpdB
         q064+p03AAGeo4znajn1zW1en04tCZIcK/LTGoj2r/XoDQ3BWDi12KHAcXbf4f4seR6k
         3ibij6FpHUiLhEwS1U2YSk9fDGrb06q3EShIwlIQrcKFmz0/uFs+AeY0dD8rz4d7eqAt
         C2ybsuMHC/VdR2eFl/lC4FXI5YFHC0f4TS4QbGTJ1cDRsAB9BoklSMxDUlg857cGof5P
         IVKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3/+ZUmZdmdw27pbnk++KxX9Rw+MSygX4g2fczs64fyE=;
        b=q1mc4Xvr1RtNJOLdZ5yo1OV31VBJhZpO4gtc+BrMgraOaalTSYMuDTi7cZC5mH46Ir
         1Ifo7E/OkQabEdVZQWctHYevjGbfgaSo3lIeShKc3sd5HqgJED5VHyUz4pk368dwiOIU
         IZlLUELO6Yg7a+2KcL6rf6+W3SPIkSG+M6hyZ0y4YC6FQdKR0bZS2k0zGbs1B/lVFO5Q
         0hqegMcS4gSHqpDUEZEubuPuvzjo7J5wE2h87wU7D+m7/nSen6sprNk9CFm1nbF3uRNw
         SI0NvR90VAydODe9r7FMBYjVVQs/yHgw/Q9KmvCZKUdzbrbwwgeF7S7F6Fhy5s/i98qD
         LZ5Q==
X-Gm-Message-State: AOAM531Ln4lYh7EX98T1X/xjEedMHoOciNFagDJHZymiB8xqnZx0HBNb
        bJVcMK+TTY81kpW7O8FVBE0=
X-Google-Smtp-Source: ABdhPJyE7sTwpgil3vRPOYXq11seATTAm8mRf+IEJj701waMQXcurP69qSSuWiqw9J/scvnUq9Jblw==
X-Received: by 2002:a05:6808:209e:b0:32b:22fe:bf7 with SMTP id s30-20020a056808209e00b0032b22fe0bf7mr6787417oiw.127.1653806464475;
        Sat, 28 May 2022 23:41:04 -0700 (PDT)
Received: from geday ([2804:7f2:8006:5ec0:8108:8ab5:1f16:73fe])
        by smtp.gmail.com with ESMTPSA id t9-20020a056830082900b006060322124csm3702547ots.28.2022.05.28.23.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 23:41:04 -0700 (PDT)
Date:   Sun, 29 May 2022 03:41:00 -0300
From:   Geraldo Nascimento <geraldogabriel@gmail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] workqueue: missing NOT while checking if Workqueue is
 offline
Message-ID: <YpMVfN7UUGxX0UxF@geday>
References: <YpKA5Bdk1Cm6KgKU@geday>
 <YpLLnx8/xpZIPMbi@geday>
 <YpL2rHUXd0vf8IML@geday>
 <YpMDmZZ7IpEhjywp@slm.duckdns.org>
 <YpMKY88/2tTK319E@geday>
 <YpMPPyIZVlBwUrNe@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpMPPyIZVlBwUrNe@slm.duckdns.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 08:14:23PM -1000, Tejun Heo wrote:
> On Sun, May 29, 2022 at 02:53:39AM -0300, Geraldo Nascimento wrote:
> > On Sat, May 28, 2022 at 07:24:41PM -1000, Tejun Heo wrote:
> > > On Sun, May 29, 2022 at 01:29:32AM -0300, Geraldo Nascimento wrote:
> > > > I would like very much to hear the opinion of the maintainers!
> > > 
> > > I have a hard time understanding what you're trying to do. Can you please
> > > slow down and start from describing the problem itself?
> > 
> > Hi Tejun,
> > 
> > Sorry for the hurry.
> > 
> > The problem is best described in https://gitlab.freedesktop.org/drm/amd/-/issues/1898
> > 
> > From my understanding from the context of __cancel_work_timer() we should not
> > ever call __flush_work() but I may be wrong. In the present case as
> 
> Yeah, you're wrong.
>

No problem from my side, sorry for wasting your time.

> > described in AMD's GitLab __cancel_work_timer() is being called by
> > cancel_delayed_work_sync() inside kfd_process_notifier_release()
> > from drivers/gpu/drm/amd/amdkfd/kfd_process.c:1157 (Linux 5.18).
> 
> Have you confirmed that that actually is the warning which is triggering? I
> don't see how that condition would trigger that late during the boot and the
> warning line being reported doesn't match v5.16 source code, so I'm not sure
> but skimming the instructon sequence, that's the second UD2 sequence, so I'm
> gonna guess that's the second WARN_ON - the !work->func one and someone else
> on the gitlab bug report seems to agree too.

While I can confirm from my dmesg traces it's the second WARN_ON (the one on
(!work->func)) that triggers, remember it's being called from
__flush_work() due to the lack of NOT operator on wq_online, inside
__cancel_work_timer().

To be honest, for me, it only makes sense to call __flush_work() from
the context of __cancel_work_timer() if we are sure the work isn't
executing. One of the few ways to be sure is when kthreads haven't
initialized yet, that means workqueue_init() hasn't fired yet and
wq_online is still false, so it makes sense to negate that false and
exceptionally call __flush_work() without waiting for completion of the
work - i.e., __flush_work() will WARN_ON workqueue offline condition and
return false immediately because task was already idle.

I know I may be repeating myself, but I'm trying to make my point, from
the little understanding I have of the kernel. And I know that you know best,
and that the possibility of a bug like that lying undiscovered on a
code-base as scrutinized as the Linux kernel is, is very small.

> 
> It's usually a lot more helpful if the bug report is complete - include the
> full warning message with some context at least, make sure that the kernel
> you're using is an upstream one or something close enough. If not, point to
> the source tree. Also, try to clearly distinguish what you know and what you
> suspect. Both can help but mixing them up together tends to cause confusion
> for everyone involved.

Sorry. Will try to do better.

> 
> It just looks like the code is trying to cancel a work item which hasn't
> been initialized and what it prolly needs is an ifdef around that cancel
> call depending on the config option.

Thanks for looking into it,
Geraldo Nascimento

> 
> Thanks.
> 
> -- 
> tejun
