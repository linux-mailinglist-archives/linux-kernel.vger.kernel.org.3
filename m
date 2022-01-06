Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD53485E76
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 03:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344627AbiAFCLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 21:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344590AbiAFCLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 21:11:37 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216FFC061245
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 18:11:37 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id t204so1713711oie.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jan 2022 18:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=q2VQMTLj5iMfGBhNI/dlyoIBVmaRNduV4g9FSAc5d0Q=;
        b=HAVqmktk9jdmgZuflgaqkWXgkT6HjjILGQc4nyrtPjXqB/28cq964Ts7Dx4YSVx+nZ
         lvMilO6WZjQUOE7DcdMRpEeflvrwsEdmHMJw3y1+54jjelilqM1XnGYhpkyKEdLGD4is
         5wV0VP6y2BEak1xFEQq6CQf3jXLQX5hdP559w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=q2VQMTLj5iMfGBhNI/dlyoIBVmaRNduV4g9FSAc5d0Q=;
        b=5G5InQcJb4Qd0SwWq1llzuAyzMfs2rGwbs2NCSbSQ3FTUjZ7jC+dXuLt3mdb1oGVJg
         gpCOJRqHCrbxmIqSAETwH6d0XLRmj4P4Tci1+lBwomxBRj0He3oBy7Kh3gV9tHMs/mpB
         n/wMtu6mqzQHA16GJP/w5wQzmwBPIDoPIY366werVY36oLPio6y+Zj49gWyFgDj8ckfj
         r8NBt+4c+2MhCQ/PTRTJrBdBOqprrq6Lj3rm9j1J9OUgNeMWtDRJjfjUO/Mt8jTf5Zck
         JoVGLnvgYe6piO71V7t+lyZYyJVoUkPwl6NcUm6GTe1h43brUDfL74Wd9c3cn/FiXQOW
         eHnA==
X-Gm-Message-State: AOAM533d0UOKUT44NU0UdPGSkCvIVWaR+RAHCqH31HZuqJjKXENXZxr6
        /NNiGg6Q3/08IA7jrIUFqdhlih2WlU6/yE+Fi/yG3g==
X-Google-Smtp-Source: ABdhPJwpP4rARq+ZNtjjgLJ5aaz4xxbiA6N8LCGM1f9VveTOLHPxVsLehRjSQTj+a9Afka6xm71L9rlxNmHRbUONRxc=
X-Received: by 2002:a54:4710:: with SMTP id k16mr4656667oik.32.1641435096318;
 Wed, 05 Jan 2022 18:11:36 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 5 Jan 2022 18:11:35 -0800
MIME-Version: 1.0
In-Reply-To: <YcGeKpy/oecKlKZg@kroah.com>
References: <20211202222732.2453851-1-swboyd@chromium.org> <20211202222732.2453851-2-swboyd@chromium.org>
 <YcGeKpy/oecKlKZg@kroah.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.9.1
Date:   Wed, 5 Jan 2022 18:11:35 -0800
Message-ID: <CAE-0n52E-9T0X8COP0EhnjCK8iieSD0Vy_0f9-v8JX7ZshZ_0A@mail.gmail.com>
Subject: Re: [PATCH v4 01/34] component: Introduce struct aggregate_device
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Saravana Kannan <saravanak@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Greg Kroah-Hartman (2021-12-21 01:28:10)
> On Thu, Dec 02, 2021 at 02:26:59PM -0800, Stephen Boyd wrote:
> > Replace 'struct master' with 'struct aggregate_device' and then rename
> > 'master' to 'adev' everywhere in the code. While we're here, put a
> > struct device inside the aggregate device so that we can register it
> > with a bus_type in the next patch.
>
> Do not do a "while we are here" type change please.  Do the
> rename/replace first, and then make the other change.
>
> > The diff is large but that's because this is mostly a rename, where
> > sometimes 'master' is replaced with 'adev' and other times it is
> > replaced with 'parent' to indicate that the struct device that was being
> > used is actually the parent of the aggregate device and driver.
>
> The diff is 15 lines, how is that "large"?
>

Looks like I forgot to remove this chunk of commit text while splitting
the change earlier. Will fix it up now.
