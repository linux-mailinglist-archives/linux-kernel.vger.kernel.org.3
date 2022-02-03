Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4955B4A84E3
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 14:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233461AbiBCNIh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 08:08:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350695AbiBCNIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:08:36 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C3AC06173B
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 05:08:35 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id z131so2201914pgz.12
        for <linux-kernel@vger.kernel.org>; Thu, 03 Feb 2022 05:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z+cMMLA2uqIqG4JJGjT5UJwJKih1Hzcajbh1/9otjJ4=;
        b=EtkmuTeRXd6+VxCth18/d3W3LBLmSTMqrAsp8qbYATFLcz2qhrTa+jq3YpvwdOhcQe
         WGMc64XHokrPGuGjbrPvgxA646Bm62H6luiYNxl3DBSYTqA70GzR6y/1NR1gMDLGGoHE
         ryppNdaRkaD/cz80GnVHyTrwnsiTykYgMUEyi+zkxDynRKQf46WXTMlnJDzhuN7knUTW
         EkhfBcYM1QPlBTS2npBO2/bfYK/kTFPDuiYkQ01+ESd5myr3Vny2md9kkmSZsgyLHgYi
         lnFFLROVtRUt8FYRddajcs1+zMDEOjBoRIxy4DXytccq3kDvjMxpveGK0rtvrSc8Acof
         IvBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z+cMMLA2uqIqG4JJGjT5UJwJKih1Hzcajbh1/9otjJ4=;
        b=TON5hW5VchMIeoTRd84hrms+n26dFcDefu3+EqCEoCwvJQjoTPbMecsHmhGofWMaz3
         9myrG3MKxRN7kiOd39osbhB0C0v9iiA2aKogKGS7aP0CTvwjT63zqT2Pgd9wKr4im176
         e31jY8sHnx/i35vU3Yo/zcXTVEtZ8Rwp2qt0ICO2McJZRpwSb0Uc09hYE3EKwBiADHkL
         VkVKnQBttER4+2y9PI3eNCjAppyI5hHXweY6KsMAJMx5wJPO5bq864MQsP7Fhi6xbTZ5
         ulqByjU+IlCZ4g5xj7a/zTJ0FPp0g5KAIQESC8hsNWEDdYj7jx3XY/0rq0qoQh2W/bSN
         8q9Q==
X-Gm-Message-State: AOAM53308gsjzJe3C3TmczMIIk/i5m93SWpR6hvhmm1BZif71IUqYn3X
        rG7dHHB7dNlRaEqEaT0jo7FK+vxctpqRhNm6EpRwYQ==
X-Google-Smtp-Source: ABdhPJxYbtVRYXRlMOXZ+MlJmKpdFPiO0SSHyURxoVCWFi6244WEpnUclVVX0b3lLiJMhW7qEpKUv6huFDK8ATcmWlc=
X-Received: by 2002:a63:f709:: with SMTP id x9mr28206057pgh.428.1643893715325;
 Thu, 03 Feb 2022 05:08:35 -0800 (PST)
MIME-Version: 1.0
References: <20220127142939.1734912-1-jens.wiklander@linaro.org> <CAFA6WYNqSKwtRYN+dudreG=ZuRLhzsbNgy8wwjrYuSR6oq_79w@mail.gmail.com>
In-Reply-To: <CAFA6WYNqSKwtRYN+dudreG=ZuRLhzsbNgy8wwjrYuSR6oq_79w@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 3 Feb 2022 14:08:24 +0100
Message-ID: <CAHUa44EDnkwYLJGKqDmmkq1kgHEWo4u_1d3yZzrSM=vj8PMo2Q@mail.gmail.com>
Subject: Re: [PATCH] optee: use driver internal tee_contex for some rpc
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Lars Persson <lars.persson@axis.com>,
        Lars Persson <larper@axis.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 6:46 AM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Thu, 27 Jan 2022 at 19:59, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > Adds a driver private tee_context by moving the tee_context in struct
> > optee_notif to struct optee. This tee_context was previously used when
> > doing internal calls to secure world to deliver notification.
> >
> > The new driver internal tee_context is now also when allocating driver
> > private shared memory. This decouples the shared memory object from its
> > original tee_context. This is needed when the life time of such a memory
> > allocation outlives the client tee_context.
> >
> > This patch fixes the problem described below:
> >
> > The addition of a shutdown hook by commit f25889f93184 ("optee: fix tee out
> > of memory failure seen during kexec reboot") introduced a kernel shutdown
> > regression that can be triggered after running the OP-TEE xtest suites.
> >
> > Once the shutdown hook is called it is not possible to communicate any more
> > with the supplicant process because the system is not scheduling task any
> > longer. Thus if the optee driver shutdown path receives a supplicant RPC
> > request from the OP-TEE we will deadlock the kernel's shutdown.
> >
> > Fixes: f25889f93184 ("optee: fix tee out of memory failure seen during kexec reboot")
> > Fixes: 217e0250cccb ("tee: use reference counting for tee_context")
> > Reported-by: Lars Persson <larper@axis.com>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >
> > This patch is from "optee: add driver private tee_context" and "optee: use
> > driver internal tee_contex for some rpc" in [1] combined into one patch for
> > easier tracking. It turned out that those two patches fixes reported
> > problem so I'm breaking out this from the patchset in order to target it
> > for the v5.17.
> >
> > [1] https://lore.kernel.org/lkml/20220125162938.838382-1-jens.wiklander@linaro.org/
> >
> >  drivers/tee/optee/core.c          |  1 +
> >  drivers/tee/optee/ffa_abi.c       | 77 +++++++++++++++++--------------
> >  drivers/tee/optee/optee_private.h |  5 +-
> >  drivers/tee/optee/smc_abi.c       | 48 +++++++------------
> >  4 files changed, 64 insertions(+), 67 deletions(-)
> >
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

Thanks, I'm picking this up now.

/Jens
