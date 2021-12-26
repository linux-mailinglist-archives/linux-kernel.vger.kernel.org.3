Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C29747F6DB
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Dec 2021 14:00:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbhLZNAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Dec 2021 08:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhLZNAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Dec 2021 08:00:16 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F16CC06173E;
        Sun, 26 Dec 2021 05:00:15 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id f5so51405113edq.6;
        Sun, 26 Dec 2021 05:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KX2upN7lVMvP7KxPsUIxf4otN3C1XyFORAeifAgwa9Q=;
        b=NRcegHRcUTALBuw2JA8M3RNUoWmZ5rUW0EH33YHkauYgFsn4Gbl1FmeyLB+l50F5ca
         T3ImxolWDzh5ErkZVzeK0451ogcqGbmUBzsZ44kZMI4y0TopK6dLo5PiUCqHrrxZnM7T
         8aBoJTztEkeHf3sNYe+zq4SdQS82VRfDuoo58IAu1/VMmew85fkCGggZ8xGW2mXlBldP
         zXrKkDhKCgZcvQowCbZH/M2VvedBpritYK3p65WjuGPKXDwVSYY5RlpMv8Aa7M/qTcsG
         4zHCCtXvLHB2093d1i3noP5/3B+2VwCIp6i+DBeHcl5c4VUcVoHP7h5aB3tsHbgi926R
         97iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KX2upN7lVMvP7KxPsUIxf4otN3C1XyFORAeifAgwa9Q=;
        b=tFYK8R89++w2irT9Dv7QzZSNmLr9MntHsdz0TLk7F4ev9rDY6eMsEayBtYOPz5uAzH
         cqlB5CoH8Buy/G1xYoTTqOHRqrAe0Gcc9VeqhxFgYMkVNh6heIDPL9nydxc38iYCgM+k
         HQw7qQY4WNKi4msXXdSXkRiSaXQqmuKmyTxq9xli/wCHgh8AdVMpPhAkgqzHxJZ9mbtS
         NTW8ut07qAn/BzDkoCUhn2+ist4XIgqUHr0/ByvJZe10t5sDMvIC0ttiR2BgzTMEoDoi
         RngPyKmiT90fVe5c42IMOADpFXz7bp0iPSTSGuny/R8j9FdTlwKMXoOiTlCU8mN9zd1q
         tPgA==
X-Gm-Message-State: AOAM5328yMpjZn2ZI/6m6K+Bmcia6uKwM+hsVda0mXn+IM7qhc/3Jfag
        6A/arcCQf8IEo6GAYapz8gCDue8vWyk5QpkuoqjUo8LX
X-Google-Smtp-Source: ABdhPJxQ+bZq6kRE/3/e0qbgonSeiFY6lRVPfwW8z3QhAFnZxTBkS+cqBKy3IXqhmqVx4RMFh7RBKh7AJ09b+XtRcXo=
X-Received: by 2002:a17:906:1643:: with SMTP id n3mr10428732ejd.733.1640523614056;
 Sun, 26 Dec 2021 05:00:14 -0800 (PST)
MIME-Version: 1.0
References: <20201216165239.2744-1-grzegorz.jaszczyk@linaro.org>
 <20210106232704.GE9149@xps15> <11303a1b-5ab4-def5-77b1-c500894c9c87@ti.com>
 <20210107224448.GB43045@xps15> <75365443-57e3-e2e0-5865-f78af9d5890b@ti.com>
 <b0e32ad0-487f-9d57-7287-835eee836514@oracle.com> <c5252e8d-094a-dcb7-7ccb-172e58ab3413@ti.com>
In-Reply-To: <c5252e8d-094a-dcb7-7ccb-172e58ab3413@ti.com>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Sun, 26 Dec 2021 14:00:02 +0100
Message-ID: <CAH9NwWfJHRc5A5D4qwU_wzGhLzQiYwkOq9RtLGc2SpnruKKHxA@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] Introduce PRU remoteproc consumer API
To:     Suman Anna <s-anna@ti.com>
Cc:     "santosh.shilimkar@oracle.com" <santosh.shilimkar@oracle.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, ssantosh@kernel.org,
        linux-remoteproc@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        praneeth@ti.com, rogerq@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI all,

Am Di., 26. Jan. 2021 um 06:58 Uhr schrieb Suman Anna <s-anna@ti.com>:
>
> Hi Santosh,
>
> On 1/24/21 10:34 PM, santosh.shilimkar@oracle.com wrote:
> > Hi Suman, Mathieu,
> >
> > On 1/7/21 2:49 PM, Suman Anna wrote:
> >> On 1/7/21 4:44 PM, Mathieu Poirier wrote:
> >>> On Wed, Jan 06, 2021 at 06:03:25PM -0600, Suman Anna wrote:
> >>>> Hi Mathieu,
> >>>>
> > [...]
> >>> I only see input from Andy and Lars in the thread you point out, nothing from
> >>> Greg.  I have also taken a look at the patch [1] that made checkpatch complain
> >>> about ENOTSUPP.  From what I see in that commit log the goal is to prevent new
> >>> additions of ENOTSUPP to the kernel.
> >>>
> >>> Please modify and resend, otherwise I'm sure someone will send another patch to
> >>> fix it before the end of the cycle.
> >>
> >> Yeah ok. I will send out a v3.
> >>
> > I haven't seen v3 of this series yet. Please post it
> > if you would like to include it for 5.12.
>
> This series is dependent on couple of patches that would have to come through
> the remoteproc tree first, and I need to post the next versions of those as
> well. So, let me sort out those first. You can drop this from your queue for 5.12.
>

Is there any update on this patch series?

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
