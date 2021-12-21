Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA0E47B910
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 04:39:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbhLUDjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 22:39:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbhLUDjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 22:39:35 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEDDC061574
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 19:39:35 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id z5so46533493edd.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 19:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HhnT9iNZb45m+Yl6mmQXF6P5epcMOvtSvPcLxLPj1Hk=;
        b=OTtRQUfhK6ogaf3OkEckf0AdFVHviCmA+iuNxTtJWMhIu2fWrZTI9qwtfjDf28mLHY
         gcYrWGWoXgnOhvwnvbtxuoInQmGgEIwOp45lwB8uiSGMIbrVExVtwfxeT0VYuv3C1Szf
         q8QKzfD9ewNC6xax+cp6ToRES9Se77yLt/m9Jmanl4ulaYqhnjDyNhGKlPcAv5WE41sR
         8bF0soaUCI0CoLbQBSYbzLe8reUJtmRc+pEKcdztC44tc7hmAanE0yO7hcqKVhjSH8aI
         79PhW1m4DK+9jvmEPA3mIUZ5QF/yTGpni2YHVkDM9F/X3G/rNWjgQTavKJtoa1hygxvP
         USPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HhnT9iNZb45m+Yl6mmQXF6P5epcMOvtSvPcLxLPj1Hk=;
        b=J97fPM6Jncve0OJSyxWqCBeZ7VAyCfAiqAXFldhEtbubsfX0sFnU5asIcC/XnukqYt
         UPS9g3ggbowMyi2N+Vpw7NhZyIKNrrc4W30pB73aoatSdsthTnHtxa7SlDc/x925poKo
         aqFd2/SCjPNuZUmKlAUQ93oEkFIMzf9Tibohs87SlZRjHYWAnAgwuS8IU19UyCVkwsmk
         NSyVQ3ZR1yzHf57A4kGqagTqKDsruPX6IFPAiecUjBBfGJ962YqoOdr7GgJfKggEYMqg
         jhjLvuGDruOWUZBMksnj6gnDcjcMuJcWGShG5CV2pSBdys6Rujrxj9hl7ZI3IeU9qSxn
         aWTQ==
X-Gm-Message-State: AOAM533O/4kBoRIWGsWfs2Z37EHlmF/1HNKkx9SftrFrU71q5XIj8Z/C
        UHFV8rNh9Y/7puh79BQp/h6x0vE7xyvoiRvR2oeG
X-Google-Smtp-Source: ABdhPJwAGTC0km/cbwkFPRUxwBn/XhPvg5GSgJxcHMqmSVAPC3iT1QyAHbSC+PLi61u4PtVo0FVoBVQzBNBelmY5xNA=
X-Received: by 2002:a17:907:2da6:: with SMTP id gt38mr1076078ejc.536.1640057973687;
 Mon, 20 Dec 2021 19:39:33 -0800 (PST)
MIME-Version: 1.0
References: <20211220122241.150-1-xieyongji@bytedance.com> <a4ba2441-83eb-dde2-09ae-7c5f42ff6ad3@acm.org>
In-Reply-To: <a4ba2441-83eb-dde2-09ae-7c5f42ff6ad3@acm.org>
From:   Yongji Xie <xieyongji@bytedance.com>
Date:   Tue, 21 Dec 2021 11:39:22 +0800
Message-ID: <CACycT3t-UzaLOFSTmYyKniHYPK8jH9SevgB+1xrnCTc_4JKXQw@mail.gmail.com>
Subject: Re: [PATCH] nbd: Don't use workqueue to handle recv work
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, Jens Axboe <axboe@kernel.dk>,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 21, 2021 at 1:10 AM Bart Van Assche <bvanassche@acm.org> wrote:
>
> On 12/20/21 04:22, Xie Yongji wrote:
> > The rescuer thread might take over the works queued on
> > the workqueue when the worker thread creation timed out.
> > If this happens, we have no chance to create multiple
> > recv threads which causes I/O hung on this nbd device.
> >
> > To fix it, this tries to create kthreads directly to
> > handle the recv work instead of using workqueue.
>
> Why a kthread instead of only removing the WQ_MEM_RECLAIM flag from the

I think we can not simply remove the WQ_MEM_RECLAIM flag because the
recv work is in the memory reclaim path.

> alloc_workqueue() call? This should have been explained in the patch
> description. Additionally, a Fixes: tag is missing.
>

OK, will do it in v2.

Thanks,
Yongji
