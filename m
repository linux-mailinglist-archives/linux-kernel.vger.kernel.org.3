Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51EDA4862AD
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 11:06:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237769AbiAFKGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 05:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbiAFKGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 05:06:07 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3BFC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 02:06:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E09B461B03
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 10:06:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBECC36AE5;
        Thu,  6 Jan 2022 10:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641463566;
        bh=8nuZJdgxn1jRjGA9kZq2AtHcuknA2FUCLi9EQ8UbdD8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=QrwbyXiGK2d36Hj18vvsWy0B1RcZ0wHzl8ZMKuJlEREnqnJyqIvwcMue10VlhO10e
         JoqINwTGFO82hGqIrLd+jDfegQ2KqVCmgVbkysTZB73ZGnWIcs1FRIUxCjMMhIb0OO
         gBDN5lZkb88sTqoJpCw4S5MmDONe2834El72exl+5EevumuCLr30d1eaqaRVSU2H05
         6BT8qE+NW8DYsWs2muoeXlbhgcLFKvaXzxsXK8SzVEApjVNExrzRlQ0yNjrFEhOfsg
         1wiMQlhQpP5hlsYEPWUkFd+Ffjc30YLdYmp6FcOaeheoCryVapBvxkTrPbjARMPeGl
         OFLmcpFvXHS1A==
Date:   Thu, 6 Jan 2022 11:05:58 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Gwendal Grignou <gwendal@chromium.org>
Cc:     Dmitry Torokhov <dtor@chromium.org>, bleung@chromium.org,
        groeck@chromium.org, myungjoo.ham@samsung.com,
        cw00.choi@samsung.com, benjamin.tissoires@redhat.com,
        jic23@kernel.org, hverkuil-cisco@xs4all.nl, lee.jones@linaro.org,
        pmalani@chromium.org, sre@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, lgirdwood@gmail.com,
        a.zummo@towertech.it, cychiang@chromium.org, perex@perex.cz,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>
Subject: Re: [PATCH 00/17] Add export symbol namespace PL_CHROMEOS
Message-ID: <20220106110558.49dd6f26@coco.lan>
In-Reply-To: <CAPUE2uu3FPvxHHGYGbckxR=QmWt3=KwFk3DYoqBSmaQd+AO0QA@mail.gmail.com>
References: <20220105220653.122451-1-gwendal@chromium.org>
        <CAE_wzQ_DTnrU9QbADZuNyt4fszAiTwa04D9muC-xE_S3MM9eGQ@mail.gmail.com>
        <CAPUE2uu3FPvxHHGYGbckxR=QmWt3=KwFk3DYoqBSmaQd+AO0QA@mail.gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, 5 Jan 2022 20:26:36 -0800
Gwendal Grignou <gwendal@chromium.org> escreveu:

> On Wed, Jan 5, 2022 at 2:58 PM Dmitry Torokhov <dtor@chromium.org> wrote:
> >
> > Hi Gwendal,
> >
> > On Wed, Jan 5, 2022 at 2:07 PM Gwendal Grignou <gwendal@chromium.org> wrote:  
> > >
> > > Add a symbol namespace for functions exported by the plaform chromeos
> > > subsystem.  
> >
> > It would be great to explain why this is needed/desirable. What are
> > the benefits of introducing this namespace? What problem are you
> > trying to solve?  
> The issue came when reviewing an iio sensor
> (https://www.spinics.net/lists/linux-iio/msg66280.html). I wanted to
> be ahead of the curve (for once).

Patch 01 should clearly document the reason why this is needed.
Yet, see below.

While I see value on using namespaces, we should have extra care when
this is used for kAPIs designed for a product/system. I mean, what
prevents that the affected drivers won't support some day different
non-ChromeOS products? We have a media driver originally written to 
work with the One Laptop Per Children hardware, that used some
product-specific kAPIs, that were extended a couple years later to
cover different types of hardware.

What happens if some day, a driver introduced to be used on a ChromeOS
hardware would also be used by a non-ChromeOS hardware? This could
become messy as times goes by.

Instead, IMO, it would make sense to have per-subsystem namespaces.
So, for instance, placing iio under an IIO-specific namespace
(and the same for other subsystems) makes more sense on my
eyes, as the namespace boundary will be clearer, and an IIO driver
will always be IIO, no matter on what hardware such driver would
be used.

Thanks,
Mauro
