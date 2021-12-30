Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A68D481C8D
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 14:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239377AbhL3Neg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 08:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232187AbhL3Ned (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 08:34:33 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8682EC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 05:34:32 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id d198-20020a1c1dcf000000b0034569cdd2a2so13335632wmd.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 05:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wk6QPu8R27ZzqD0xJCv/P/Bm+q/Aw5Xjx08K6+16C4w=;
        b=NxIUr/AMFV7p8+mpayu7CB60tSNUN5YGPVBV9Mty31tRBfbvV+gCuPGPsdjrOP2lIn
         iLwAkdrNPEdQLsyeXJ63H5Fr/Uht6YaBjPuHXe+nwMt+yJCMUKYPC1F30mVp12aUtgJy
         ZSd+SSgZfiQvNttevvTkX2mU/0Amt4FN3zJz+n6G3TwuuUuhlgyy2Dn1Ldc7HHyisyoE
         tIRzk3p0dpyYwWfG9sLam4aAqXsGOYOih0+UsL1TJbcTieRr4EBT/2Qw2f4UlqPRc8nR
         7oIRaZMyrfiMWkQMWeO9eUwjdY0o0mmJUwH+u/oVvFGU0RN51qiwEkwUgJiQZ5EiWvF/
         lghQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wk6QPu8R27ZzqD0xJCv/P/Bm+q/Aw5Xjx08K6+16C4w=;
        b=gUbRj0cszK6lkXuyjwnGSjov5lYjMSOw0I80ezqquwDoZE4xNE0cpep2xJ7+fnpM9O
         arp1brQ7l5DpwUXZyndjsrstf2Nl5gqGQ51291TYizDGrrMaaTOFZFoRixVbx0IemhnS
         LuSrCI07F4aYOWzx1Vjgg0D6OcilDMzAs8vqs8Ty58S4F5/mkARrcYVywGSQXsq9ZelP
         8jChV6YxtpzBoaSt/Z2ioWbVprA5PnLy8qJ7i/epd0zFqhEQ6VZddxLW9JFnbLKGazoH
         j2QeMv438i8FTLRLRTR3S9BzbP+ioJIu9Ruqj3aP+y0vtNqpV+ElQ228V4bxcUcP334V
         DDTQ==
X-Gm-Message-State: AOAM5339zyhHs4IWPW2VOME7FjOSRxkKowfndKeBKLWBGvPGQwRXJBqI
        iiAv2M0uEGk050vGdkmRmrjeLgH+CjVAIPjh
X-Google-Smtp-Source: ABdhPJxJ8bJsZtVkSh/cfUL8wfs5mSFdk7RFcltu0ESWV0+YKaDRXbUoIgCs/ayDawK4l/2H9o6UCQ==
X-Received: by 2002:a7b:c1d0:: with SMTP id a16mr23018582wmj.166.1640871271002;
        Thu, 30 Dec 2021 05:34:31 -0800 (PST)
Received: from pswork (i577BCE2C.versanet.de. [87.123.206.44])
        by smtp.gmail.com with ESMTPSA id o9sm8983268wri.97.2021.12.30.05.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 05:34:30 -0800 (PST)
Date:   Thu, 30 Dec 2021 14:34:30 +0100
From:   Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, nsaenz@kernel.org,
        Gaston Gonzalez <gascoar@gmail.com>,
        Ojaswin Mujoo <ojaswin98@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH] staging: vc04_services: Fix RCU dereference check
Message-ID: <20211230133430.GA10256@pswork>
References: <20211229153243.6064-1-treasure4paddy@gmail.com>
 <a30849fa-dd7c-f661-0b27-a04c6531cfb8@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a30849fa-dd7c-f661-0b27-a04c6531cfb8@i2se.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 29, 2021 at 08:13:40PM +0100, Stefan Wahren wrote:
> Hi Padmanabha,
> 
> Am 29.12.21 um 16:32 schrieb Padmanabha Srinivasaiah:
> > In service_callback path RCU dereference done without
> > rcu_read_[lock/unlock] pair, fixing same by using them.
> >
> > [   32.201659] =============================
> > [   32.201664] WARNING: suspicious RCU usage
> > [   32.201670] 5.15.11-rt24-v8+ #3 Not tainted
> > [   32.201680] -----------------------------
> > [   32.201685] drivers/staging/vc04_services/interface/vchiq_arm/vchiq_core.h:529 suspicious rcu_dereference_check() usage!
> > [   32.201695]
> > [   32.201695] other info that might help us debug this:
> > [   32.201695]
> > [   32.201700]
> > [   32.201700] rcu_scheduler_active = 2, debug_locks = 1
> > [   32.201708] no locks held by vchiq-slot/0/98.
> > [   32.201715]
> > [   32.201715] stack backtrace:
> > [   32.201723] CPU: 1 PID: 98 Comm: vchiq-slot/0 Not tainted 5.15.11-rt24-v8+ #3
> > [   32.201733] Hardware name: Raspberry Pi 4 Model B Rev 1.4 (DT)
> > [   32.201739] Call trace:
> > [   32.201742]  dump_backtrace+0x0/0x1b8
> > [   32.201772]  show_stack+0x20/0x30
> > [   32.201784]  dump_stack_lvl+0x8c/0xb8
> > [   32.201799]  dump_stack+0x18/0x34
> > [   32.201808]  lockdep_rcu_suspicious+0xe4/0xf8
> > [   32.201817]  service_callback+0x124/0x400
> > [   32.201830]  slot_handler_func+0xf60/0x1e20
> > [   32.201839]  kthread+0x19c/0x1a8
> > [   32.201849]  ret_from_fork+0x10/0x20
> >
> > Signed-off-by: Padmanabha Srinivasaiah <treasure4paddy@gmail.com>
> > ---
> >  drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> > index 6759a6261500..ee1b48db9681 100644
> > --- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> > +++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
> > @@ -1058,7 +1058,10 @@ service_callback(enum vchiq_reason reason, struct vchiq_header *header,
> >  
> >  	DEBUG_TRACE(SERVICE_CALLBACK_LINE);
> >  
> > +	rcu_read_lock();
> >  	service = handle_to_service(handle);
> > +	rcu_read_unlock();
> > +
> >  	if (WARN_ON(!service))
> >  		return VCHIQ_SUCCESS;
> >  
> 
> thanks for reporting this issue.
> 
> Could you please explain how to reproduce this issue?

Have enabled lock dependency check in 5.15 plus rt patchset have been
applied. And to catch this warning not loading any modules from default
build.

> 
> What makes you sure that your patch fixes the issue and not just hiding
> the warning?

Thank you stefan for the question. Yes, you are right dereferenced pointer
access should be inside the rcu read-side critical section. Will regenerate the patch
and will share for the review.

> Best regards
> 
