Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAB2656A034
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 12:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235347AbiGGKmD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 06:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235337AbiGGKmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 06:42:01 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10EF633E03
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 03:42:00 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id h14-20020a1ccc0e000000b0039eff745c53so10451261wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 03:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ZVSYvXmefqE+MfS8n0FJBkX+AkR5IfISwtQFKKh7kvc=;
        b=L23etO+ocvne9PH19+wfoZuBbhwO+sVAFrxpV2Fb6QzCrdDT8aZYJbXKWwmHB9ZM3/
         LtFVWOTs/B1/Vx3uWTG5GMS1ib/p/ptp/X8Y34BEehd6eOn1V8EfXiafoFfxF/NSaLLQ
         +ZEc6MsDPmWbM1WXj4i3/AAHYMx6noyTbboqRXXjh2BVLOb7NcyLkq+rH9RFfTjDh4Wi
         U136tjV/Gjw9fzkeodZdKXOWgrCQKuauoFM+7dqT+vxxtLMJHT1oAHD605+Vfh3XD7Nq
         I5iQW55TgsDhthvo5IFdKZYzMTGfs9S+qTX35DMQvQquFY3NN63mw5W7nz/inFVXBG3q
         MBkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ZVSYvXmefqE+MfS8n0FJBkX+AkR5IfISwtQFKKh7kvc=;
        b=1Q4uWE68cTy99BbQxOcw4Gj3VcHIw1WNXQh5xYv8kJ/fzAcEvePcbu/G1qfYCSgPQ5
         9PoQTFb4Ivx+/TtpGn3+x0nK+Xxub/rv2kzS2vgWA68d/C8cMgEECzI7q3iyTJquvoPP
         ddlKgmQc/5IXj3iUFDhUTGX3aJwtjdiX6fWkqZZfQKT7VOJL+m7Z4Je38vyYP0Ts+xN2
         z2d5OWRmRD4VbTss2oKZSZnmMdeZBLNoLhQ42fLMjVhbT0VgmvoJvuLX+jCKiuClEVf3
         CH3/AFzhgxPADaGuOHjTQxdH1rlKGzW+ReDeyhzdBhKMj7j9PnneVKw43g8O0FpgOi42
         KDng==
X-Gm-Message-State: AJIora+rueNuJkvlFEhGmFkQgbl14I/ueHludkpliXHehs04fa68krZx
        fFTaMvnovfxvPZfhPCKIQr81hFFah9NXDg==
X-Google-Smtp-Source: AGRyM1sPT+iSrdXpKNV9l2ZR5aSEXqzu1zOGVjiyisaGkoovw7DGeA3cpuGhJkZJXem2fF9/nCRqlQ==
X-Received: by 2002:a05:600c:600d:b0:3a1:9712:5d31 with SMTP id az13-20020a05600c600d00b003a197125d31mr3618219wmb.67.1657190518617;
        Thu, 07 Jul 2022 03:41:58 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id v17-20020a5d5911000000b0021bbdc3375fsm14265075wrd.68.2022.07.07.03.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 03:41:58 -0700 (PDT)
Date:   Thu, 7 Jul 2022 13:41:57 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-arm-msm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC v2] driver core: Fix repeated device_is_dependent check for
 same link
Message-ID: <Ysa4dUhSbgz+VDIf@linaro.org>
References: <20220706155347.778762-1-abel.vesa@linaro.org>
 <CAGETcx_MV8QsAFC_ztY6CjysshxPSZZ2ZbgpyXhSpH1v2knhzA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGETcx_MV8QsAFC_ztY6CjysshxPSZZ2ZbgpyXhSpH1v2knhzA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-07-06 21:51:34, Saravana Kannan wrote:
> On Wed, Jul 6, 2022 at 8:54 AM Abel Vesa <abel.vesa@linaro.org> wrote:
> >
> > In case of a cyclic dependency, if the supplier is not yet available,
> > the parent of the supplier is checked for dependency. But if there are
> > more than one suppliers with the same parent, the first check returns
> > true while the next ones skip that specific link entirely because of
> > having DL_FLAG_MANAGED and DL_FLAG_SYNC_STATE_ONLY set, which is what
> > the relaxing of the link does. But if we check for the target being
> > a consumer before the check for those flags, we can check as many
> > times as needed the same link and it will always return true, This is
> > safe to do, since the relaxing of the link will be done only once
> > because those flags will be set and it will bail early.
> >
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  drivers/base/core.c | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 753e7cca0f40..2c3b860dfe80 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -297,13 +297,13 @@ int device_is_dependent(struct device *dev, void *target)
> >                 return ret;
> >
> >         list_for_each_entry(link, &dev->links.consumers, s_node) {
> > +               if (link->consumer == target)
> > +                       return 1;
> > +
> >                 if ((link->flags & ~DL_FLAG_INFERRED) ==
> >                     (DL_FLAG_SYNC_STATE_ONLY | DL_FLAG_MANAGED))
> >                         continue;
>
> Thanks for trying to fix this issue, but I'll have to Nack this patch.
>
> The whole point of the SYNC_STATE_ONLY flag is to allow cycles. It's
> needed to maintain correctness of sync_state(). I think I described
> those in the commit text that added the SYNC_STATE_ONLY flag. Check it
> out if you are interested. So this change of yours will break
> sync_state() functionality.
>

Fair enough.

> There's a bunch of nuance to fixing the dual cycle issue and I don't
> mind fixing this myself in a week or two if you can wait.
>

Please cc me on it.

> Thanks,
> Saravana
>
> >
> > -               if (link->consumer == target)
> > -                       return 1;
> > -
> >                 ret = device_is_dependent(link->consumer, target);
> >                 if (ret)
> >                         break;
> > --
> > 2.34.3
> >
