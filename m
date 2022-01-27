Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 543FB49EAFD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 20:26:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245511AbiA0TZ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 14:25:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbiA0TZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 14:25:57 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3EEC061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 11:25:57 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id r59so3973785pjg.4
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 11:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lKMnBnjolln8U2OTn9rawxeDav9p/HtInvuZ+X5EaeQ=;
        b=Q0VTPoD8a46YDRFUDAcIZ70+aI+oG0Rztj+ZExTYze1afoK6XF+ASaguYxGEYiUUL0
         Ynd/IQVlEjwq87CTseTucRSnV4733aQAipNf+WoVYWf/Xs20Mh9L4gvQXl8ALo92Xy+f
         voy1bxmJQBYG0stSNj+1m8HVgO/J1g20CdM30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lKMnBnjolln8U2OTn9rawxeDav9p/HtInvuZ+X5EaeQ=;
        b=ISSYekhAqzhapoSyZdBPypIh5iZ6We7T1xC0kvmntK3I1Hk5tlKbBsrj7u9pkdqDG6
         y91Lgm147y64ZDDFbIbK79R18P29gQW2wDTTeTEa2Li7Pa8V4kZDiwdXwDro3yJB38eA
         4NP/qFG/05fKc1luCi3CQJ7c3xhnjdFVOp+svw/K2ftToNzSSNyonF2ibcxxjuPTL63B
         Xui7wqtgbxSs55QiLsOBJMTpeJH+uMljw9uBJjVPnTn8MGE+vNSGziWHoAy89sS+aFHA
         WyuufZ5XXaZl/c8lQ/AGvrnHNUBMJkNjycVsBa4ovB2DCjsLy7ZvWR661oOevnJbo9qG
         /eYQ==
X-Gm-Message-State: AOAM531U1tl08Fa6xaGF7JfU26i6AlOj7k/NIXwqAjAK+gP8/FHMh5ue
        TyAV+DCyUR1q8iUazN/8A83gzw==
X-Google-Smtp-Source: ABdhPJwdTl1/jHPJyn3r0Fa4ONLZanW1FZvHfsJdU32AJ/Xgo3AO1+ORPPCj7/ufn9RsJr6ofCoBBQ==
X-Received: by 2002:a17:902:6948:: with SMTP id k8mr4868559plt.136.1643311556653;
        Thu, 27 Jan 2022 11:25:56 -0800 (PST)
Received: from chromium.org (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id j18sm6695551pfj.13.2022.01.27.11.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 11:25:56 -0800 (PST)
Date:   Thu, 27 Jan 2022 19:25:55 +0000
From:   Prashant Malani <pmalani@chromium.org>
To:     Dustin Howett <dustin@howett.net>
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Michael Niksa <michael.niksa@live.com>, aaboagye@chromium.org
Subject: Re: [PATCH v2 2/2] platform/chrome: cros_ec_lpcs: reserve the MEC
 LPC I/O ports first
Message-ID: <YfLxw9r6VvbxijRM@chromium.org>
References: <20220126180020.15873-1-dustin@howett.net>
 <20220126180020.15873-3-dustin@howett.net>
 <YfLqloFQpF7bURGi@chromium.org>
 <CA+BfgNKS_uGZVh5K=O5Q-Brj-wWyg+gn1Nx4-Gr5OVb46ZFi=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+BfgNKS_uGZVh5K=O5Q-Brj-wWyg+gn1Nx4-Gr5OVb46ZFi=A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Aseda,

On Jan 27 13:18, Dustin Howett wrote:
> On Thu, Jan 27, 2022 at 12:55 PM Prashant Malani <pmalani@chromium.org> wrote:
> >
> > Hi Dustin,
> >
> > I can't find this update in the EC code base [1]. Is there any reason
> > you are not adding this, or is the change in flight (or in some other
> > location)?
> >
> > [1] https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/main/include/ec_commands.h
> >
> 
> Hey Prashant,
> 
> The host communication adapters in the EC repo don't support the MEC
> protocol at all,
> so it did not seem necessary to bring these changes over. I'd be happy
What source do Framework laptop ECs (MECs?) compile their EC firmware
from?

> to do so, of
> course, if that is desirable.
> 
> My understanding (well, my guess) is that protocol support was never
> added because
> it is already implemented here in cros_ec_lpcs. Userland I/O port
> access is(?) less desirable
> than having this driver handle it.
Yeah, I wasn't thinking about userland i/o port access, but just having
this behaviour/different I/O port mapping described in the EC code base
too.
